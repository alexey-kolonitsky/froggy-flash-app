/**
 * Created by Alexey on 16.08.2015.
 */
package org.kolonitsky.alexey.service
{
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.net.URLRequestMethod;
    import flash.net.URLVariables;

    import org.kolonitsky.alexey.events.ServiceEvent;

    import ua.com.froggy.flash.client.model.vo.ProductVO;

    /**
     * General service which retrieve products info from HTML web client.
     */
    public class HTMLFroggyService extends FroggyService
    {
        /** STATE_BUSY set after sending request */
        public static const STATE_BUSY:String = "send";

        /** STATE_RADY indicate that service waiting for next instruction */
        public static const STATE_READY:String = "ready";

        /** STATE_INVALID indicate that service are not setted up or can't find connection */
        public static const STATE_INVALID:String = "invalid";

        /** STATE_PROCESSING indicate that data received and currenctly processed */
        public static const STATE_PROCESSING:String = "processing";


        //-----------------------------
        // Private
        //-----------------------------

        private var _baseURL:String;
        private var _parser:HTMLParser;

        private var _queue:Vector.<URLRequest>;
        private var _state:String = "";

        private var _loader:URLLoader;
        private var _productsFull:Vector.<ProductVO>;
        private var _productsFilter:Vector.<ProductVO>;
        private var _filter:String;


        //-----------------------------
        // Constructor
        //-----------------------------

        public function HTMLFroggyService()
        {
            _state = STATE_INVALID;
            _queue = new Vector.<URLRequest>();

            _loader = new URLLoader();
            _loader.addEventListener(Event.COMPLETE, loader_completeHandler);
            _loader.addEventListener(IOErrorEvent.IO_ERROR, loader_ioErrorHandler);
            _loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loader_securityErrorHandler);
        }

        public function init(baseURL:String, parser:HTMLParser):void
        {
            _baseURL = baseURL;
            _parser = parser;
            _state = STATE_READY;
        }

        override public function sendRequest(url:String, method:String = URLRequestMethod.GET, data:Object = null):void
        {
            var parameters:URLVariables = new URLVariables();
            for (var key:String in data)
                parameters[key] = data[key];

            var request:URLRequest = new URLRequest(_baseURL + url);
            request.method = method;
            request.data = parameters;
            _queue.push(request);
            checkQueue();
        }

        public function addProduct(product:ProductVO):void
        {
            var data:URLVariables = new URLVariables();
            data["data"] = _parser.productToHTML(product);
            _state = STATE_BUSY;
            sendRequest("addProduct.php",  URLRequestMethod.POST, data);
        }


        //-------------------------------------------------------------------
        //
        // Private
        //
        //-------------------------------------------------------------------

        private function checkQueue():void
        {
            if (_queue == null || _queue.length == 0)
                return;

            if (_state == STATE_READY)
            {
                var request:URLRequest = _queue[0];
                _loader.load(request);
            }
        }


        //-------------------------------------------------------------------
        // Event Handlers
        //-------------------------------------------------------------------

        private function loader_securityErrorHandler(event:SecurityErrorEvent):void
        {
            _state = STATE_PROCESSING;
            var request:URLRequest = _queue.shift();
            var method:String = request.url.replace(_baseURL, "");
            var errorXML:XML = <error>{event.text}</error>;
            dispatchEvent(new ServiceEvent(ServiceEvent.FAILURE, method, request.data, errorXML));
            _state = STATE_READY;
        }

        private function loader_ioErrorHandler(event:IOErrorEvent):void
        {
            _state = STATE_PROCESSING;
            var request:URLRequest = _queue.shift();
            var method:String = request.url.replace(_baseURL, "");
            var errorXML:XML = <error>{event.text}</error>;
            dispatchEvent(new ServiceEvent(ServiceEvent.FAILURE, method, request.data, errorXML));
            _state = STATE_READY;
        }

        private function loader_completeHandler(event:Event):void
        {
            _state = STATE_PROCESSING;

            var request:URLRequest = _queue.shift();
            var method:String = request.url.replace(_baseURL, "");
            var strData:String = _loader.data as String;
            var xmlData:XML = null;
            try
            {
                xmlData = new XML(strData);
            }
            catch (error:Error)
            {
                trace("ERROR: [Service] Invalid HTML\n" + error.message);
            }

            dispatchEvent(new ServiceEvent(ServiceEvent.SUCCESS, method, request.data, xmlData));

            _state = STATE_READY;
            checkQueue();
        }
    }
}

/**
 * Created by Alexey on 16.08.2015.
 */
package ua.com.froggy.flash.client.service
{
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLLoader;
    import flash.net.URLRequest;

    import org.robotlegs.mvcs.Actor;

    import ua.com.froggy.flash.client.Config;
    import ua.com.froggy.flash.client.events.ShopEvent;

    import ua.com.froggy.flash.client.model.vo.ProductVO;

    public class HTMLFroggyService extends Actor implements IFroggyService
    {
        private static const XHTML_NAMESPACE:Namespace = new Namespace("http://www.w3.org/1999/xhtml");
        public static const HPRODUCT_ROOT:String = "hproduct";
        public static const HPRODUCT_NAME:String = "fn";
        public static const HPRODUCT_DESCRIPTION:String = "description";
        public static const HPRODUCT_PHOTO:String = "photo";
        public static const HPRODUCT_PRICE:String = "price";

        private var _loader:URLLoader;
        private var _urlRequest:URLRequest;
        private var _productsFull:Vector.<ProductVO>;
        private var _productsFilter:Vector.<ProductVO>;
        private var _filter:String;

        public function HTMLFroggyService()
        {
            _urlRequest = new URLRequest(Config.PRODUCTS_URL);

            _loader = new URLLoader();
            _loader.addEventListener(Event.COMPLETE, _loader_completeHandler);
            _loader.addEventListener(IOErrorEvent.IO_ERROR, _loader_ioErrorHandler);
            _loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, _loader_securityErrorHandler)
        }

        private function _loader_securityErrorHandler(event:SecurityErrorEvent):void
        {
            trace("[ERROR] [Service] " + event.text);
        }

        private function _loader_ioErrorHandler(event:IOErrorEvent):void
        {
            trace("[ERROR] [Service] " + event.text);
        }

        private function _loader_completeHandler(event:Event):void
        {
            var strData:String = _loader.data as String;
            try
            {
                var xmlData:XML = new XML(strData);
            }
            catch (error:Error)
            {
                trace("[ERROR] [Service] Invalid HTML\n" + error.message);
            }

            pars(xmlData);
            dispatch(new ShopEvent(ShopEvent.CATALOG_LOADED))
        }

        private function pars(xmlData : XML) : void
        {
            _productsFull = new Vector.<ProductVO>();

            default xml namespace = XHTML_NAMESPACE;

            var bodyXML:XMLList = xmlData.body;
            var divList:XMLList = bodyXML.div;

            for each (var divXML in divList)
            {
                if (!divXML.hasOwnProperty("@class"))
                    continue;

                var classValue:String = divXML["@class"].toXMLString();
                if (classValue != HPRODUCT_ROOT)
                    continue;

                var productVO:ProductVO = new ProductVO();
                productVO.title = String(firstNodeByClass(divXML..h2, HPRODUCT_NAME));
                productVO.description = String(firstNodeByClass(divXML..p, HPRODUCT_DESCRIPTION).text());
                productVO.imageURL = String(firstNodeByClass(divXML..img, HPRODUCT_PHOTO).@src);
                productVO.price = String(firstNodeByClass(divXML..span, HPRODUCT_PRICE));
                _productsFull.push(productVO);
            }
        }

        private function firstNodeByClass(root:XMLList, classValue:String)
        {
            for each (var node:XML in root)
            {
                if (!node.hasOwnProperty("@class"))
                    continue;

                var cv:String = node["@class"].toXMLString();
                if (cv == classValue)
                    return node;
            }

            return "";
        }

        public function load():void
        {
            trace("[INFO] [Service] load: " + _urlRequest);
            _loader.load(_urlRequest);
        }

        public function filter(mask:String):void
        {
            _filter = mask;

        }

        public function get products() : Vector.<ProductVO>
        {
            return _productsFull;
        }
    }
}

/**
 * Created by Alexey on 16.08.2015.
 */
package ua.com.froggy.flash.client.service
{
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.HTTPStatusEvent;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.net.URLRequestMethod;
    import flash.net.URLVariables;

    import ua.com.froggy.flash.client.events.ServiceEvent;
    import ua.com.froggy.flash.client.model.vo.OrderProductVO;
    import ua.com.froggy.flash.client.model.vo.OrderVO;
    import ua.com.froggy.flash.client.model.vo.ProductVO;


    /**
     * General service which retrieve products info from HTML web client.
     */
    public class HTMLFroggyService extends FroggyService
    {
        [Embed(source='/templates/order-template.xhtml',  mimeType="application/octet-stream")]
        private static var OrderTemplateClass:Class;

        //-----------------------------
        // Namespaces
        //-----------------------------

        private static const XHTML_NAMESPACE:Namespace = new Namespace("xhtml", "http://www.w3.org/1999/xhtml");
        private static const FROGGY_NAMESPACE:Namespace = new Namespace("froggy", "http://froggy.com.ua/2007/shop");


        //-----------------------------
        // Class names
        //-----------------------------

        public static const HPRODUCT_ROOT:String = "hproduct";
        public static const HPRODUCT_NAME:String = "fn";
        public static const HPRODUCT_DESCRIPTION:String = "description";
        public static const HPRODUCT_PHOTO:String = "photo";
        public static const HPRODUCT_PRICE:String = "price";
        public static const HPRODUCT_CURRENCY:String = "currency";


        public var urlRequest:URLRequest;


        //-----------------------------
        // Private
        //-----------------------------

        private var _loader:URLLoader;
        private var _productsFull:Vector.<ProductVO>;
        private var _productsFilter:Vector.<ProductVO>;
        private var _filter:String;


        //-----------------------------
        // Constructor
        //-----------------------------

        public function HTMLFroggyService()
        {
            _loader = new URLLoader();
            _loader.addEventListener(Event.COMPLETE, loader_completeHandler);
            _loader.addEventListener(IOErrorEvent.IO_ERROR, loader_ioErrorHandler);
            _loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loader_securityErrorHandler)
        }

        override public function load():void
        {
            if (urlRequest == null)
            {
                trace("ERROR: [HTMLFroggyService] URL not specified. Check configuration");
                return;
            }

            trace("INFO: [Service] load: " + urlRequest);
            _loader.load(urlRequest);
        }

        override public function filter(mask:String):void
        {
            _filter = mask;

        }

        override public function get products() : Vector.<ProductVO>
        {
            return _productsFull;
        }


        override public function sendOrder(order:OrderVO):void
        {
            var request:URLRequest = new URLRequest("http://froggy.com.ua/sendmail.php");
            request.method = URLRequestMethod.GET;
            request.data = new URLVariables();
            request.data['from'] = order.customer.name + "<" + order.customer.email + ">";
            request.data['data'] = orderToHTML(order);

            var loader:URLLoader = new URLLoader();
            loader.addEventListener(Event.COMPLETE, sendOrder_completeHandler);
            loader.addEventListener(IOErrorEvent.IO_ERROR, sendOrder_ioErrorHandler);
            loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, sendOrder_httpStatusHandler);
            loader.load(request);
        }

        private function orderToHTML(order:OrderVO):String
        {
            var ulProducts:XML = <ol />;
            for each (var productOrder:OrderProductVO in order.products)
            {
                var productVO:ProductVO = productOrder.product;
                var fullURL:String = "http://froggy.com.ua/" + productVO.imageURL;
                var productHTML:XML = <li>
                    <img src={fullURL} alt={productVO.title} width="64" height="64"/>
                    {productVO.title} ({productVO.price} x {productOrder.count}) {productOrder.localPrice}
                </li>;
                ulProducts.appendChild(productHTML);
            }

            var template:XML = <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
                <head>
                    <title>Заказ №{order.orderId}</title>
                </head>
                <body>
                    <h1>Заказ №{order.orderId}</h1>
                    <h2>Товары</h2>
                    {ulProducts}

                    <p>Итого: {order.totalPrice}</p>

                    <h2>Покупатель</h2>
                    <ul>
                        <li>Имя: {order.customer.name}</li>
                        <li>Адрес: {order.customer.address}</li>
                        <li>Телефон: {order.customer.phone}</li>
                        <li>email: {order.customer.email}</li>
                    </ul>

                    <p>{order.details}</p>
                </body>
                </html>
            return template.toXMLString();
        }

        private function sendOrder_httpStatusHandler(event:HTTPStatusEvent):void
        {
            trace("NET: Service: " + event.status + ", " + event.toString())
        }

        private function sendOrder_ioErrorHandler(event:IOErrorEvent):void
        {
            trace("ERROR: NET: HTTPFroggyService failure send order");
        }

        private function sendOrder_completeHandler(event:Event):void
        {
            var loader:URLLoader = event.target as URLLoader;
            var response:String = String(loader.data);

            trace("NET: sendOrder : '" + response + "'");
        }

        //-------------------------------------------------------------------
        // Private
        //-------------------------------------------------------------------

        private function pars(xmlData : XML) : void
        {
            _productsFull = new Vector.<ProductVO>();

            default xml namespace = XHTML_NAMESPACE;

            var bodyXML:XMLList = xmlData.body;
            var divList:XMLList = bodyXML.div;

            for each (var divXML:XML in divList)
            {
                if (!divXML.hasOwnProperty("@class"))
                    continue;

                var classValue:String = divXML["@class"].toXMLString();
                if (classValue != HPRODUCT_ROOT)
                    continue;

                var productVO:ProductVO = new ProductVO();
                productVO.id = String(divXML.@FROGGY_NAMESPACE::id);
                productVO.title = String(firstNodeByClass(divXML..h2, HPRODUCT_NAME));
                productVO.description = String(firstNodeByClass(divXML..p, HPRODUCT_DESCRIPTION).toXMLString);
                productVO.imageURL = String(firstNodeByClass(divXML..img, HPRODUCT_PHOTO).@src);
                productVO.price = parseInt(firstNodeByClass(divXML..span, HPRODUCT_PRICE));
                productVO.currency = String(firstNodeByClass(divXML..span, HPRODUCT_CURRENCY));
                _productsFull.push(productVO);
            }
        }

        private function firstNodeByClass(root:XMLList, classValue:String):XML
        {
            for each (var node:XML in root)
            {
                if (!node.hasOwnProperty("@class"))
                    continue;

                var cv:String = node["@class"].toXMLString();
                if (cv == classValue)
                    return node;
            }

            return null;
        }


        //-------------------------------------------------------------------
        // Event Handlers
        //-------------------------------------------------------------------

        private function loader_securityErrorHandler(event:SecurityErrorEvent):void
        {
            trace("ERROR: [Service] " + event.text);
        }

        private function loader_ioErrorHandler(event:IOErrorEvent):void
        {
            trace("ERROR: [Service] " + event.text);
        }

        private function loader_completeHandler(event:Event):void
        {
            var strData:String = _loader.data as String;
            try
            {
                var xmlData:XML = new XML(strData);
            }
            catch (error:Error)
            {
                trace("ERROR: [Service] Invalid HTML\n" + error.message);
            }

            pars(xmlData);

            dispatchEvent(new ServiceEvent(ServiceEvent.SUCCESS_SERVICE_LOADING));
        }
    }
}

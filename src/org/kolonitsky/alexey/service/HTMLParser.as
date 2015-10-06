/**
 * Created by Aliaksei_Kalanitski on 10/6/2015.
 */
package org.kolonitsky.alexey.service
{
    import ua.com.froggy.flash.client.model.vo.OrderProductVO;
    import ua.com.froggy.flash.client.model.vo.OrderVO;
    import ua.com.froggy.flash.client.model.vo.ProductVO;

    public class HTMLParser
    {
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


        //-----------------------------
        // Constructor
        //-----------------------------

        public function HTMLParser()
        {
        }

        public function parse(html:XML):Object
        {
            return null;
        }


        public function productToHTML(product:ProductVO):XML
        {
            return null;
        }


        public function parseCatalog(xmlData:XML):Vector.<ProductVO>
        {
            var result:Vector.<ProductVO> = new Vector.<ProductVO>();

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
                result.push(productVO);
            }

            return result;
        }

        public function orderToHTML(order:OrderVO):String
        {
            var orderId:String = "{orderId}";

            var template:XML =
            <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
                <head>
                    <title>Заказ №{orderId}</title>
                </head>
                <body>
                    <h1>Заказ №{orderId}</h1>
                    <h2>Товары</h2>
                    {orderProductsToHTML(order.products)}

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
            </html>;
            return template;
        }

        private function orderProductsToHTML(products:Vector.<OrderProductVO>):XML
        {
            var ulProducts:XML = <ol />;
            for each (var productOrder:OrderProductVO in products)
            {
                var productVO:ProductVO = productOrder.product;
                var fullURL:String = "http://froggy.com.ua/" + productVO.imageURL;
                var productHTML:XML = <li>
                    <img src={fullURL} alt={productVO.title} width="64" height="64"/>
                    {productVO.title} ({productVO.price} x {productOrder.count}) {productOrder.localPrice}
                </li>;
                ulProducts.appendChild(productHTML);
            }

            return ulProducts;
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
    }
}

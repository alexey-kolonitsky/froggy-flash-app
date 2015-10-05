/**
 * Created by Alexey on 11.09.2015.
 */
package ua.com.froggy.flash.client.model.vo
{
    public class OrderProductVO
    {
        public var productId:String;
        public var count:int;
        public var product:ProductVO;

        public function get price():Number
        {
            return count * product.price;
        }

        public function get localPrice():String
        {
            return price + " " + product.currency;
        }
    }
}

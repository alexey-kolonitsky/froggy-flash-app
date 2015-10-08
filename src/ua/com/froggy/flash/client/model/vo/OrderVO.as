/**
 * Created by Aliaksei_Kalanitski on 10/2/2015.
 */
package ua.com.froggy.flash.client.model.vo
{
    public class OrderVO
    {
        public var orderId:String;
        public var products:Vector.<OrderProductVO>;
        public var customer:CustomerDetailsVO;
        public var payment:String;
        public var status:uint;
        public var details:String;

        public function get totalPrice():Number
        {
            var result:Number = 0;
            for (var i:int = 0; i < products.length; i++)
                result += products[i].price;

            return result;
        }

        public function get localTotalPrice():String
        {
            var product:ProductVO = products[0].product;
            var strCurrency:String = product.currency ? product.currency : "грн";
            return totalPrice + " " + strCurrency;
        }
    }
}

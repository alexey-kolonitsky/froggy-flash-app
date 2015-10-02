/**
 * Created by Aliaksei_Kalanitski on 10/2/2015.
 */
package ua.com.froggy.flash.client.model.vo
{
    public class OrderVO
    {
        public var products:Vector.<OrderProductVO>;
        public var customer:CustomerDetailsVO;
        public var payment:String;
        public var status:uint;
    }
}

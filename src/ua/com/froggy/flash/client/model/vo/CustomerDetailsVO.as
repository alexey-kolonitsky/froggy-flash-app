/**
 * Created by Aliaksei_Kalanitski on 10/2/2015.
 */
package ua.com.froggy.flash.client.model.vo
{
    import ua.com.froggy.flash.client.model.types.PaymentType;

    public class CustomerDetailsVO
    {
        public var userId:String;
        public var name:String;
        public var email:String;
        public var address:String;
        public var phone:String;
        public var details:String;
        public var languageCode:String;
        public var countryCode:String;
        public var currencyCode:String;
        public var paymentType:uint = PaymentType.CASH;
    }
}

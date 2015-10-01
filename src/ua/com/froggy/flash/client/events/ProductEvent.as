/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.events
{
    import flash.events.Event;

    import ua.com.froggy.flash.client.model.vo.ProductVO;

    public class ProductEvent extends Event
    {
        public static const BUY:String = "buyProduct";
        public static const CANCEL:String = "cancelProduct";

        public var product:ProductVO;

        public function ProductEvent(type:String, product:ProductVO = null)
        {
            super(type, true, false);
            this.product = product;
        }

        override public function clone():Event
        {
            var result:ProductEvent = new ProductEvent(type, product);
            return result as Event;
        }
    }
}

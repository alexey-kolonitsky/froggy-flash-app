/**
 * Created by Aliaksei_Kalanitski on 10/6/2015.
 */
package ua.com.froggy.flash.client.events
{
    import flash.events.Event;

    import ua.com.froggy.flash.client.model.vo.OrderVO;

    public class OrderEvent extends Event
    {
        public static const CREATE:String = "createOrder";
        public static const UPDATE:String = "updateOrder";
        public var order:OrderVO;

        public function OrderEvent(type:String, order:OrderVO)
        {
            super(type, false, false);
            this.order = order;
        }

        override public function clone():Event
        {
            return new OrderEvent(type, order);
        }
    }
}

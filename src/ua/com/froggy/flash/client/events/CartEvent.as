/**
 * Created by Aliaksei_Kalanitski on 9/30/2015.
 */
package ua.com.froggy.flash.client.events
{
    import flash.events.Event;

    public class CartEvent extends Event
    {
        public static const CHANGED:String = "cartChanged";

        public function CartEvent(type:String)
        {
            super(type, true, false);
        }
    }
}

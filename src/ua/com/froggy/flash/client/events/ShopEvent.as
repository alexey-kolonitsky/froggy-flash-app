/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.events
{
    import flash.events.Event;

    public class ShopEvent extends Event
    {
        public static const STARTUP:String = "startup";


        public function ShopEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
        {
            super(type, bubbles, cancelable);
        }
    }
}

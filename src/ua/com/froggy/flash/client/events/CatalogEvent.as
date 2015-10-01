/**
 * Created by Aliaksei_Kalanitski on 9/30/2015.
 */
package ua.com.froggy.flash.client.events
{
    import flash.events.Event;

    public class CatalogEvent extends Event
    {
        public static const CHANGED:String = "catalogChanged";

        public function CatalogEvent(type:String)
        {
            super(type, true, false);
        }
    }
}

/**
 * Created by Aliaksei_Kalanitski on 9/30/2015.
 */
package ua.com.froggy.flash.client.events
{
    import flash.events.Event;

    public class CatalogChangedEvent extends Event
    {
        public static const CATALOG_CHANGED:String = "catalogChanged";

        public function CatalogChangedEvent()
        {
            super(CATALOG_CHANGED, true, false);
        }

        override public function clone():Event
        {
            return new CatalogChangedEvent();
        }
    }
}

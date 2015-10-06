/**
 * Created by Aliaksei_Kalanitski on 9/30/2015.
 */
package ua.com.froggy.flash.client.events
{
    import flash.events.Event;

    public class LoadCatalogEvent extends Event
    {
        public static const LOAD_CATALOG:String = "loadCatalog";

        public function LoadCatalogEvent()
        {
            super(LOAD_CATALOG, true, false);
        }

        override public function clone():Event
        {
            return new LoadCatalogEvent();
        }
    }
}

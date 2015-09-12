/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.view
{
    import org.robotlegs.mvcs.Mediator;

    import ua.com.froggy.flash.client.events.SearchEvent;
    import ua.com.froggy.flash.client.events.ShopEvent;
    import ua.com.froggy.flash.client.model.CatalogProxy;
    import ua.com.froggy.flash.client.service.IFroggyService;

    public class CatalogMediator extends Mediator
    {
        [Inject]
        public var catalog:Catalog;

        [Inject]
        public var catalogProxy:CatalogProxy;

        override public function onRegister():void
        {
            eventMap.mapListener(catalogProxy.eventDispatcher, ShopEvent.CATALOG_CHAHNGED, catalogLoadedHandler);

            catalog.searchField.addEventListener(SearchEvent.SEARCH, searchField_searchHandler);
            catalog.searchField.addEventListener(SearchEvent.CLEAR, searchField_searchHandler);
            catalog.addEventListener(ShopEvent.BUY_PRODUCT, buyProductHandler);
        }


        //---------------------------------------------------------------------
        // Event handlers
        //---------------------------------------------------------------------

        private function buyProductHandler(event:ShopEvent):void
        {
            dispatch(new ShopEvent(event.type, event.product));
        }

        private function catalogLoadedHandler(event:ShopEvent):void
        {
            catalog.products = catalogProxy.products;
        }

        private function searchField_searchHandler(event:SearchEvent):void
        {
            dispatch(new SearchEvent(event.type, event.mask));
        }
    }
}

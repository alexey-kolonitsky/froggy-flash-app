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
    import ua.com.froggy.flash.client.signals.BuyProductSignal;
    import ua.com.froggy.flash.client.signals.CatalogChangedSignal;
    import ua.com.froggy.flash.client.signals.CatalogLoadedSignal;
    import ua.com.froggy.flash.client.signals.SearchClearSignal;
    import ua.com.froggy.flash.client.signals.SearchSignal;

    public class CatalogMediator extends Mediator
    {
        [Inject]
        public var froggyService:IFroggyService;

        [Inject]
        public var catalog:Catalog;

        [Inject]
        public var catalogProxy:CatalogProxy;

        [Inject]
        public var catalogChangedSignal:CatalogChangedSignal;

        [Inject]
        public var searchSignal:SearchSignal;

        [Inject]
        public var searchClearSignal:SearchClearSignal;

        [Inject]
        public var buyProductSignal:BuyProductSignal;

        override public function onRegister():void
        {
            trace("[INFO] CatalogMediator.onRegister() ");
            catalogChangedSignal.add(catalogLoadedHandler);

            catalog.searchField.addEventListener(SearchEvent.SEARCH, searchField_searchHandler);
            catalog.searchField.addEventListener(SearchEvent.CLEAR, searchField_searchClearHandler);
            catalog.addEventListener(ShopEvent.BUY_PRODUCT, buyProductHandler);

            froggyService.load();
        }


        //---------------------------------------------------------------------
        // Event handlers
        //---------------------------------------------------------------------

        private function buyProductHandler(event:ShopEvent):void
        {
            buyProductSignal.dispatch(event.product);
        }

        private function catalogLoadedHandler():void
        {
            catalog.products = catalogProxy.products;
        }

        private function searchField_searchHandler(event:SearchEvent):void
        {
            searchSignal.dispatch(event.mask);
        }

        private function searchField_searchClearHandler(event:SearchEvent):void
        {
            searchClearSignal.dispatch("");
        }
    }
}

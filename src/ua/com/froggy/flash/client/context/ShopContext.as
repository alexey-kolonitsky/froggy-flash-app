/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.context
{
    import flash.display.DisplayObjectContainer;

    import org.robotlegs.mvcs.SignalContext;

    import ua.com.froggy.flash.client.controller.BuyCommand;
    import ua.com.froggy.flash.client.controller.CancelProductCommand;

    import ua.com.froggy.flash.client.controller.CatalogLoadedCommand;
    import ua.com.froggy.flash.client.controller.SearchCommand;

    import ua.com.froggy.flash.client.model.CatalogProxy;
    import ua.com.froggy.flash.client.model.ShoppingCartProxy;
    import ua.com.froggy.flash.client.service.HTMLFroggyService;
    import ua.com.froggy.flash.client.service.IFroggyService;
    import ua.com.froggy.flash.client.signals.BuyProductSignal;
    import ua.com.froggy.flash.client.signals.CancelProductSignal;
    import ua.com.froggy.flash.client.signals.CatalogChangedSignal;
    import ua.com.froggy.flash.client.signals.CatalogLoadedSignal;
    import ua.com.froggy.flash.client.signals.SearchClearSignal;
    import ua.com.froggy.flash.client.signals.SearchSignal;
    import ua.com.froggy.flash.client.signals.ShoppingCartChangedSignal;
    import ua.com.froggy.flash.client.view.Catalog;
    import ua.com.froggy.flash.client.view.CatalogMediator;
    import ua.com.froggy.flash.client.view.ShoppingCartMediator;
    import ua.com.froggy.flash.client.view.froggy_components.ShoppingCartLine;

    public class ShopContext extends SignalContext
    {
        public function ShopContext(contextView:DisplayObjectContainer)
        {
            super(contextView, false)
        }

        override public function startup():void
        {
            trace("[INFO] ShopContext startup");

            //map model
            injector.mapSingleton(CatalogProxy);
            injector.mapSingleton(ShoppingCartProxy);

            //map signals
            injector.mapSingleton(CatalogChangedSignal);
            injector.mapSingleton(ShoppingCartChangedSignal);

            signalCommandMap.mapSignalClass(BuyProductSignal, BuyCommand);
            signalCommandMap.mapSignalClass(CancelProductSignal, CancelProductCommand);
            signalCommandMap.mapSignalClass(CatalogLoadedSignal, CatalogLoadedCommand);
            signalCommandMap.mapSignalClass(SearchSignal, SearchCommand);
            signalCommandMap.mapSignalClass(SearchClearSignal, SearchCommand);

            //map service
            injector.mapSingletonOf(IFroggyService, HTMLFroggyService);

            //map view
            mediatorMap.mapView(Catalog, CatalogMediator);
            mediatorMap.mapView(ShoppingCartLine, ShoppingCartMediator);
        }
    }
}

/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.context
{
    import flash.display.DisplayObjectContainer;

    import org.robotlegs.base.ContextEvent;
    import org.robotlegs.mvcs.Context;

    import ua.com.froggy.flash.client.controller.CatalogLoadedCommand;

    import ua.com.froggy.flash.client.controller.StartupCommand;
    import ua.com.froggy.flash.client.events.ShopEvent;
    import ua.com.froggy.flash.client.model.CatalogProxy;
    import ua.com.froggy.flash.client.model.ShoppingCartProxy;
    import ua.com.froggy.flash.client.service.HTMLFroggyService;
    import ua.com.froggy.flash.client.service.IFroggyService;
    import ua.com.froggy.flash.client.view.Catalog;
    import ua.com.froggy.flash.client.view.CatalogMediator;
    import ua.com.froggy.flash.client.view.ShoppingCart;
    import ua.com.froggy.flash.client.view.ShoppingCartMediator;

    public class ShopContext extends Context
    {
        public function ShopContext(contextView:DisplayObjectContainer)
        {
            super(contextView, false)
        }

        override public function startup():void
        {
            //map commands
            commandMap.mapEvent(ShopEvent.STARTUP, StartupCommand, ShopEvent, true);
            commandMap.mapEvent(ShopEvent.CATALOG_LOADED, CatalogLoadedCommand, ShopEvent, true);

            //map model
            injector.mapSingleton(CatalogProxy);
            injector.mapSingleton(ShoppingCartProxy);

            //map service
            injector.mapSingletonOf(IFroggyService, HTMLFroggyService);

            //map view
            mediatorMap.mapView(Catalog, CatalogMediator);
            mediatorMap.mapView(ShoppingCart, ShoppingCartMediator);

            dispatchEvent( new ShopEvent(ShopEvent.STARTUP) );
        }
    }
}

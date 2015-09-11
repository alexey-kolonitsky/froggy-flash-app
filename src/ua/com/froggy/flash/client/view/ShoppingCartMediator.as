/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.view
{
    import org.robotlegs.mvcs.Mediator;

    import ua.com.froggy.flash.client.events.ShopEvent;

    import ua.com.froggy.flash.client.model.CatalogProxy;
    import ua.com.froggy.flash.client.model.ShoppingCartProxy;
    import ua.com.froggy.flash.client.service.IFroggyService;
    import ua.com.froggy.flash.client.view.froggy_components.ShoppingCartLine;

    public class ShoppingCartMediator extends Mediator
    {
        [Inject]
        public var model:ShoppingCartProxy;

        [Inject]
        public var view:ShoppingCartLine;

        [Inject]
        public var froggyService:IFroggyService;

        override public function onRegister():void
        {
            super.onRegister();

            eventMap.mapListener(model.eventDispatcher, ShopEvent.SHOPPING_CART_CHANGED, shoppingCartChanged);
            
            view.addEventListener(ShopEvent.CANCEL_PRODUCT, shoppingCart_removeProductHandler)
        }

        private function shoppingCart_removeProductHandler(event:ShopEvent):void
        {
            dispatch(new ShopEvent(event.type, event.product));
        }

        private function shoppingCartChanged(event:ShopEvent):void
        {
            view.orders = model.orders;
        }
    }
}

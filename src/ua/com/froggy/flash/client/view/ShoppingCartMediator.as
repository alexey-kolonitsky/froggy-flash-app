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
    import ua.com.froggy.flash.client.signals.CancelProductSignal;
    import ua.com.froggy.flash.client.signals.ShoppingCartChangedSignal;
    import ua.com.froggy.flash.client.view.froggy_components.ShoppingCartLine;

    public class ShoppingCartMediator extends Mediator
    {
        [Inject]
        public var model:ShoppingCartProxy;

        [Inject]
        public var view:ShoppingCartLine;

        [Inject]
        public var froggyService:IFroggyService;

        [Inject]
        public var shoppingCartChangedSignal:ShoppingCartChangedSignal;

        [Inject]
        public var cancelProductSignal:CancelProductSignal;

        override public function onRegister():void
        {
            super.onRegister();
            shoppingCartChangedSignal.add(shoppingCartChanged);
            
            view.addEventListener(ShopEvent.CANCEL_PRODUCT, shoppingCart_removeProductHandler)
        }

        private function shoppingCart_removeProductHandler(event:ShopEvent):void
        {
            cancelProductSignal.dispatch(event.product);
        }

        private function shoppingCartChanged():void
        {
            view.orders = model.orders;
        }
    }
}

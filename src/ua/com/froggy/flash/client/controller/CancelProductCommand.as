/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.controller
{
    import org.robotlegs.mvcs.Command;

    import ua.com.froggy.flash.client.events.SearchEvent;
    import ua.com.froggy.flash.client.events.ShopEvent;
    import ua.com.froggy.flash.client.model.CatalogProxy;
    import ua.com.froggy.flash.client.model.ShoppingCartProxy;

    public class CancelProductCommand extends Command
    {
        [Inject]
        public var shoppingCart:ShoppingCartProxy;

        [Inject]
        public var shopEvent:ShopEvent;

        override public function execute():void
        {
            trace("[INFO] [CancelProductCommand]");
            shoppingCart.remove(shopEvent.product);
        }
    }
}

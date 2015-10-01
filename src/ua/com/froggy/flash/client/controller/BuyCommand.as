/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.controller
{
    import ua.com.froggy.flash.client.events.ProductEvent;
    import ua.com.froggy.flash.client.model.ShoppingCartProxy;
    import ua.com.froggy.flash.client.model.vo.ProductVO;

    public class BuyCommand
    {
        [Inject]
        public var shoppingCart:ShoppingCartProxy;

        public function execute(event:ProductEvent):void
        {
            trace("[INFO] [BuyCommand] " + event.product);
            shoppingCart.add(event.product);
        }
    }
}

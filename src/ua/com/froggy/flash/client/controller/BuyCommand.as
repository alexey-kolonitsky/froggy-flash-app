/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.controller
{
    import org.robotlegs.mvcs.SignalCommand;

    import ua.com.froggy.flash.client.model.ShoppingCartProxy;
    import ua.com.froggy.flash.client.model.vo.ProductVO;

    public class BuyCommand extends SignalCommand
    {
        [Inject]
        public var shoppingCart:ShoppingCartProxy;

        [Inject]
        public var product:ProductVO;

        override public function execute():void
        {
            trace("[INFO] [BuyCommand] " + product);
            shoppingCart.add(product);
        }
    }
}

/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.controller
{
import ua.com.froggy.flash.client.model.ShoppingCartProxy;
import ua.com.froggy.flash.client.model.vo.ProductVO;

public class CancelProductCommand
    {
        [Inject]
        public var shoppingCart:ShoppingCartProxy;

        [Inject]
        public var product:ProductVO;

        public function execute():void
        {
            trace("[INFO] [CancelProductCommand] " + product);
            shoppingCart.remove(product);
        }
    }
}

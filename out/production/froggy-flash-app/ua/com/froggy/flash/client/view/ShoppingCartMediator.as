/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.view
{
    import org.robotlegs.mvcs.Mediator;

    import ua.com.froggy.flash.client.model.CatalogProxy;
    import ua.com.froggy.flash.client.service.IFroggyService;

    public class ShoppingCartMediator extends Mediator
    {
        [Inject]
        public var catalog:ShoppingCart;

        [Inject]
        public var froggyService:IFroggyService;

        public function ShoppingCartMediator()
        {
        }


    }
}

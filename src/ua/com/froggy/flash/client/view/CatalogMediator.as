/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.view
{
    import org.robotlegs.mvcs.Mediator;

    import ua.com.froggy.flash.client.model.CatalogProxy;

    public class CatalogMediator extends Mediator
    {
        [Inject]
        public var catalog:Catalog;

        [Inject]
        public var catalogProxy:CatalogProxy;

        public function CatalogMediator()
        {
        }
    }
}

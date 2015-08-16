/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.controller
{
    import org.robotlegs.mvcs.Command;

    import ua.com.froggy.flash.client.model.CatalogProxy;
    import ua.com.froggy.flash.client.model.vo.ProductVO;

    import ua.com.froggy.flash.client.service.IFroggyService;

    public class CatalogLoadedCommand extends Command
    {
        [Inject]
        public var froggyService:IFroggyService;

        [Inject]
        public var catalogProxy:CatalogProxy;

        override public function execute():void
        {
            // restore previous session
            catalogProxy.updateCatalog(froggyService.products);
        }
    }
}

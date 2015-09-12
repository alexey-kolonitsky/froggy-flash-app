/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.controller
{
    import org.robotlegs.mvcs.SignalCommand;

    import ua.com.froggy.flash.client.model.CatalogProxy;
    import ua.com.froggy.flash.client.service.IFroggyService;
    import ua.com.froggy.flash.client.signals.CatalogChangedSignal;

    public class CatalogLoadedCommand extends SignalCommand
    {
        [Inject]
        public var froggyService:IFroggyService;

        [Inject]
        public var catalogProxy:CatalogProxy;

        [Inject]
        private var catalogChangedSignal:CatalogChangedSignal;

        override public function execute():void
        {
            trace("[INFO] [CatalogLoadedCommand] ");
            catalogProxy.updateCatalog(froggyService.products);
        }
    }
}

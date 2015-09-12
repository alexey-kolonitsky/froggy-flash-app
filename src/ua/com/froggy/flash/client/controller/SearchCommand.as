/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.controller
{
    import org.robotlegs.mvcs.SignalCommand;

    import ua.com.froggy.flash.client.events.SearchEvent;
    import ua.com.froggy.flash.client.model.CatalogProxy;
    import ua.com.froggy.flash.client.signals.CatalogChangedSignal;

    public class SearchCommand extends SignalCommand
    {
        [Inject]
        public var catalog:CatalogProxy;

        [Inject]
        public var mask:String;

        [Inject]
        public var catalogChangedSignal:CatalogChangedSignal;

        override public function execute():void
        {
            trace("[INFO] [SearchCommand] mask: " + mask);
            catalog.filter(mask);
        }
    }
}

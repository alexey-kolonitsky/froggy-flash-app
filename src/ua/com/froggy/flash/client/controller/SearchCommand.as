/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.controller
{
    import org.robotlegs.mvcs.Command;

    import ua.com.froggy.flash.client.events.SearchEvent;
    import ua.com.froggy.flash.client.model.CatalogProxy;

    public class SearchCommand extends Command
    {
        [Inject]
        public var catalog:CatalogProxy;

        [Inject]
        public var searchEvent:SearchEvent;

        override public function execute():void
        {
            trace("[INFO] [SearchCommand]");
            catalog.filter(searchEvent.mask);
        }
    }
}

/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.controller
{
    import ua.com.froggy.flash.client.events.SearchEvent;
    import ua.com.froggy.flash.client.model.CatalogProxy;

    public class SearchCommand
    {
        [Inject]
        public var catalog:CatalogProxy;

        public function execute(event:SearchEvent):void
        {
            trace("[INFO] [SearchCommand] mask: " + event.mask);
            catalog.filter(event.mask);
        }
    }
}

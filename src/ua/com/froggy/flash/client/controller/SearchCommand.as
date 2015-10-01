/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.controller
{
    import ua.com.froggy.flash.client.model.CatalogProxy;

    public class SearchCommand
    {
        [Inject]
        public var catalog:CatalogProxy;

        [Inject]
        public var mask:String;

        public function execute():void
        {
            trace("[INFO] [SearchCommand] mask: " + mask);
            catalog.filter(mask);
        }
    }
}

/**
 * Created by Alexey on 16.08.2015.
 */
package
{
    import flash.net.URLRequest;

    import org.kolonitsky.alexey.data.LocalStorage;
    import org.spicefactory.parsley.flex.tag.builder.LocalScopeTag;

    import ua.com.froggy.flash.client.controller.BuyCommand;
    import ua.com.froggy.flash.client.controller.CancelProductCommand;
    import ua.com.froggy.flash.client.controller.SearchCommand;

    import ua.com.froggy.flash.client.model.CatalogProxy;
    import ua.com.froggy.flash.client.model.ShoppingCartProxy;
    import ua.com.froggy.flash.client.service.HTMLFroggyService;
    import ua.com.froggy.flash.client.service.FroggyService;

    public class Config
    {
        public static const VERSION:String = "v1.0.1";
        public static const APPLICATION_NAME:String = "froggy-client-app";

        public const catalogProxy:CatalogProxy = new CatalogProxy();

        public const shoppingCartProxy:ShoppingCartProxy = new ShoppingCartProxy();

        public const buyCommand:BuyCommand = new BuyCommand();

        public const cancelCommand:CancelProductCommand = new CancelProductCommand();

        public const searchCommand:SearchCommand = new SearchCommand();

        //-----------------------------
        // LocalStorage tool
        //-----------------------------

        private static var _localStorage:LocalStorage;

        public function get localStorage():LocalStorage
        {
            if (_localStorage == null)
            {
                _localStorage = new LocalStorage();
                _localStorage.applicationId = APPLICATION_NAME;
                _localStorage.applicationVersion = VERSION;
                _localStorage.init();
            }
            return _localStorage;
        }


        //-----------------------------
        // Service
        //-----------------------------

        private static var _froggyService:FroggyService;

        public function get froggyService():FroggyService
        {
            if (_froggyService == null)
            {
                var service:HTMLFroggyService = new HTMLFroggyService();
                service.urlRequest = new URLRequest("html-client.html");
                _froggyService = service;
            }

            return _froggyService;
        }
    }
}

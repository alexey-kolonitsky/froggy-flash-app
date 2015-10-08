/**
 * Created by Alexey on 16.08.2015.
 */
package
{
    import flash.net.URLRequest;
    import flash.net.URLRequestMethod;

    import org.kolonitsky.alexey.data.LocalStorage;
    import org.kolonitsky.alexey.gui.windows.WindowManager;
    import org.spicefactory.parsley.flex.tag.builder.LocalScopeTag;

    import ua.com.froggy.flash.client.controller.BuyCommand;
    import ua.com.froggy.flash.client.controller.CancelProductCommand;
    import ua.com.froggy.flash.client.controller.LoadCatalogCommand;
    import ua.com.froggy.flash.client.controller.SearchCommand;
    import ua.com.froggy.flash.client.controller.SendOrderCommand;

    import ua.com.froggy.flash.client.model.CatalogProxy;
    import ua.com.froggy.flash.client.model.ShoppingCartProxy;
    import org.kolonitsky.alexey.service.HTMLFroggyService;
    import org.kolonitsky.alexey.service.FroggyService;
    import org.kolonitsky.alexey.service.HTMLParser;

    public class Config
    {
        //-----------------------------
        // Build Configuration
        //-----------------------------

        public static const VERSION:String = "v1.0.2";
        public static const APPLICATION_NAME:String = "froggy-client-app";
        public static const DOMAIN:String = "http://froggy.com.ua/";



        public const parser:HTMLParser = new HTMLParser();

        //-----------------------------
        // Proxies
        //-----------------------------

        public const catalogProxy:CatalogProxy = new CatalogProxy();
        public const shoppingCartProxy:ShoppingCartProxy = new ShoppingCartProxy();

        //-----------------------------
        // Client Commands
        //-----------------------------

        public const buyCommand:BuyCommand = new BuyCommand();
        public const cancelCommand:CancelProductCommand = new CancelProductCommand();
        public const searchCommand:SearchCommand = new SearchCommand();

        //-----------------------------
        // Server Commands
        //-----------------------------

        public const sendOrderCommand:SendOrderCommand = new SendOrderCommand();
        public const loadCatalogCommand:LoadCatalogCommand = new LoadCatalogCommand();


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
                service.init(DOMAIN, parser);
                _froggyService = service;
            }

            return _froggyService;
        }
    }
}

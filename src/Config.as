/**
 * Created by Alexey on 16.08.2015.
 */
package
{
    import flash.net.URLRequest;

    import ua.com.froggy.flash.client.model.CatalogProxy;
    import ua.com.froggy.flash.client.model.ShoppingCartProxy;
    import ua.com.froggy.flash.client.service.HTMLFroggyService;
    import ua.com.froggy.flash.client.service.FroggyService;

    public class Config
    {
        public const catalogProxy:CatalogProxy = new CatalogProxy();

        public const shoppingCartProxy:ShoppingCartProxy = new ShoppingCartProxy();


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
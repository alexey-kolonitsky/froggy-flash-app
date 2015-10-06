/**
 * Created by Aliaksei_Kalanitski on 10/6/2015.
 */
package ua.com.froggy.flash.client.controller
{
    import flash.net.URLRequestMethod;

    import org.flexunit.asserts.fail;

    import ua.com.froggy.flash.client.events.LoadCatalogEvent;

    import ua.com.froggy.flash.client.events.OrderEvent;

    import org.kolonitsky.alexey.events.ServiceEvent;

    import ua.com.froggy.flash.client.model.CatalogProxy;

    import ua.com.froggy.flash.client.model.vo.OrderVO;

    import org.kolonitsky.alexey.service.FroggyService;
    import org.kolonitsky.alexey.service.HTMLParser;

    import ua.com.froggy.flash.client.model.vo.ProductVO;

    public class LoadCatalogCommand extends ServerCommand
    {
        [Inject(id="froggyService")]
        public var service:FroggyService;

        [Inject]
        public var parser:HTMLParser;

        [Inject]
        public var catalogProxy:CatalogProxy;

        //-----------------------------
        // Constructor
        //-----------------------------

        public function LoadCatalogCommand()
        {
            super("html-client.html", URLRequestMethod.GET);
        }

        public function execute(event:LoadCatalogEvent):void
        {
            send(service);
        }

        override protected function onFail(event:ServiceEvent):void
        {
            trace("FAIL on sent order");
        }

        override protected function onSuccess(event:ServiceEvent):void
        {
            trace("Order Successfuly sent");
            var products:Vector.<ProductVO> = parser.parseCatalog(event.response);
            catalogProxy.updateProducts(products);
        }
    }
}

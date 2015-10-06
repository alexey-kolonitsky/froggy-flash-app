/**
 * Created by Aliaksei_Kalanitski on 10/6/2015.
 */
package ua.com.froggy.flash.client.controller
{
    import flash.net.URLRequestMethod;

    import ua.com.froggy.flash.client.events.OrderEvent;

    import org.kolonitsky.alexey.events.ServiceEvent;

    import ua.com.froggy.flash.client.model.vo.CustomerDetailsVO;

    import ua.com.froggy.flash.client.model.vo.OrderVO;

    import org.kolonitsky.alexey.service.FroggyService;
    import org.kolonitsky.alexey.service.HTMLParser;

    public class SendOrderCommand extends ServerCommand
    {
        [Inject(id="froggyService")]
        public var service:FroggyService;

        [Inject]
        public var parser:HTMLParser;


        //-----------------------------
        // Constructor
        //-----------------------------

        public function SendOrderCommand()
        {
            super("sendmail.php", URLRequestMethod.GET);
        }

        public function execute(event:OrderEvent):void
        {
            var order:OrderVO = event.order;
            var customer:CustomerDetailsVO = order.customer;
            send(service, {
                from: customer.name + "<" + customer.email + ">",
                data: parser.orderToHTML(order)
            });
        }

        override protected function onFail(event:ServiceEvent):void
        {
            trace("FAIL on sent order");
        }

        override protected function onSuccess(event:ServiceEvent):void
        {
            trace("Order Successfuly sent");
        }
    }
}

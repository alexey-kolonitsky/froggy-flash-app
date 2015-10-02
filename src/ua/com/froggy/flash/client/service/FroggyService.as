/**
 * Created by Alexey on 16.08.2015.
 */
package ua.com.froggy.flash.client.service
{
    import flash.events.EventDispatcher;

    import ua.com.froggy.flash.client.model.vo.ProductVO;

    [Event(name="successServiceLoading", type="ua.com.froggy.flash.client.events.ServiceEvent")]

    [ManagedEvents("successServiceLoading")]

    public class FroggyService extends EventDispatcher
    {
        public function load():void {}
        public function filter(mask:String):void {}
        public function get products():Vector.<ProductVO> { return null }
        public function sendOrder(OrderVO):void {}
    }
}

/**
 * Created by Aliaksei_Kalanitski on 10/6/2015.
 */
package ua.com.froggy.flash.client.controller
{
    import flash.events.EventDispatcher;
    import flash.net.URLRequestMethod;

    import org.kolonitsky.alexey.events.ServiceEvent;
    import org.kolonitsky.alexey.service.FroggyService;

    public class ServerCommand
    {

        //-----------------------------
        // Constructor
        //-----------------------------

        public function ServerCommand(method:String, httpMethod:String = URLRequestMethod.GET)
        {
            _method = method;
            _httpMethod = httpMethod;
        }

        //-----------------------------
        // Method
        //-----------------------------

        private var _method:String;
        private var _httpMethod:String;

        public function get method():String
        {
            return _method;
        }


        public function send(service:FroggyService, parameters:Object = null):void
        {
            service.sendRequest(_method, _httpMethod, parameters);
            service.addEventListener(ServiceEvent.SUCCESS, successHandler);
            service.addEventListener(ServiceEvent.FAILURE, failureHandler);
        }

        protected function onSuccess(event:ServiceEvent):void
        {

        }

        protected function onFail(event:ServiceEvent):void
        {

        }

        private function successHandler(event:ServiceEvent):void
        {
            var service:FroggyService = event.target as FroggyService;
            service.removeEventListener(ServiceEvent.SUCCESS, successHandler);
            service.removeEventListener(ServiceEvent.FAILURE, failureHandler);
            if (event.method == _method)
                onSuccess(event);
        }


        private function failureHandler(event:ServiceEvent):void
        {
            var service:FroggyService = event.target as FroggyService;
            service.removeEventListener(ServiceEvent.SUCCESS, successHandler);
            service.removeEventListener(ServiceEvent.FAILURE, failureHandler);
            if (event.method == _method)
                onFail(event);
        }

    }
}

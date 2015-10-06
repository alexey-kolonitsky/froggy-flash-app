/**
 * Created by Aliaksei_Kalanitski on 9/30/2015.
 */
package org.kolonitsky.alexey.events
{
    import flash.events.Event;

    public class ServiceEvent extends Event
    {
        public static const FAILURE:String = "failureResponse";
        public static const SUCCESS:String = "successResponse";

        public var method:String;
        public var data:Object;
        public var response:XML;

        public function ServiceEvent(type:String, method:String, data:Object, response:XML = null)
        {
            super(type, false, false);
            this.method = method;
            this.data = data;
            this.response = response;
        }


        override public function clone():Event
        {
            var result:Event = new ServiceEvent(type, method, data, response);
            return result;
        }
    }
}

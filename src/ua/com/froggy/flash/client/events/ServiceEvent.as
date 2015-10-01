/**
 * Created by Aliaksei_Kalanitski on 9/30/2015.
 */
package ua.com.froggy.flash.client.events
{
    import flash.events.Event;

    public class ServiceEvent extends Event
    {
        public static const SUCCESS_SERVICE_LOADING:String = "successServiceLoading";

        public function ServiceEvent(type:String)
        {
            super(type);
        }
    }
}

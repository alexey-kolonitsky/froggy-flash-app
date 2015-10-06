/**
 * Created by Alexey on 16.08.2015.
 */
package org.kolonitsky.alexey.service
{
    import flash.events.EventDispatcher;
    import flash.net.URLRequestMethod;

    [Event(name="failureResponse", type="org.kolonitsky.alexey.events.ServiceEvent")]

    [Event(name="successResponse", type="org.kolonitsky.alexey.events.ServiceEvent")]

    [ManagedEvents("failureResponse,successResponse")]

    public class FroggyService extends EventDispatcher
    {
        public function sendRequest(url:String, method:String = URLRequestMethod.GET, data:Object = null):void
        {

        }
    }
}

/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.context
{
    import flash.display.DisplayObjectContainer;

    import org.robotlegs.base.ContextEvent;
    import org.robotlegs.mvcs.Context;

    import ua.com.froggy.flash.client.controller.StartupCommand;
    import ua.com.froggy.flash.client.events.ShopEvent;

    public class ShopContext extends Context
    {
        public function ShopContext(contextView:DisplayObjectContainer)
        {
            super(contextView, false)
        }

        override public function startup():void
        {
            commandMap.mapEvent(ShopEvent.STARTUP, StartupCommand, ShopEvent, true);

        }
    }
}

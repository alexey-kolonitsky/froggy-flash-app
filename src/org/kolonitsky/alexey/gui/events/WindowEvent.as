/**
 * Created by Aliaksei_Kalanitski on 10/2/2015.
 */
package org.kolonitsky.alexey.gui.events
{
    import flash.events.Event;

    import org.kolonitsky.alexey.gui.windows.WindowDefinition;

    public class WindowEvent extends Event
    {
        public static const OPEN_WINDOW:String = "openWindow";
        public static const CLOSE_WINDOW:String = "closeWindow";
        public static const CLOSE_ALL:String = "closeAllWindows";

        public var definition:WindowDefinition;

        public function WindowEvent(eventType:String, windowType:String, data:Object = null)
        {
            super(eventType, true, false);
            definition = new WindowDefinition();
            definition.type = windowType;
            definition.data = data;
        }


        override public function clone():Event
        {
            var result:WindowEvent = new WindowEvent(type, definition.type);
            result.definition.data = definition.data;
            return result;
        }
    }
}

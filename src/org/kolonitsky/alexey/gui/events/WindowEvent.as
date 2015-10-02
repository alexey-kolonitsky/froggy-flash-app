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

        public function WindowEvent(eventType:String, data:Object)
        {
            super(eventType, true, false);
            if (data is String)
            {
                definition = new WindowDefinition();
                definition.type = data as String;
            }
            else if (data is WindowDefinition)
            {
                definition = data as WindowDefinition;
            }
            else if (data is Object)
            {
                definition = new WindowDefinition();
                definition.data = data as String;
            }
        }

        override public function clone():Event
        {
            var result:WindowEvent = new WindowEvent(type, definition);
            return result;
        }
    }
}

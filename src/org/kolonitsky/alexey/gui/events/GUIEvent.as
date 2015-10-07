/**
 * Created by Aliaksei_Kalanitski on 10/7/2015.
 */
package org.kolonitsky.alexey.gui.events
{
    import flash.events.Event;

    public class GUIEvent extends Event
    {
        public static const RESIZE:String = "guiResize";
        public function GUIEvent(type:String)
        {
            super(type, false, false);
        }
    }
}

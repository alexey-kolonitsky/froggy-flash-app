/**
 * Created by Aliaksei_Kalanitski on 10/2/2015.
 */
package org.kolonitsky.alexey.gui.windows
{
    import flash.display.Sprite;
    import flash.events.Event;

    import org.kolonitsky.alexey.gui.core.GUIGroup;

    import org.kolonitsky.alexey.gui.events.WindowEvent;

    import ua.com.froggy.flash.client.view.components.LayoutType;

    public class WindowBase extends GUIGroup
    {
        //-----------------------------
        // Constructor
        //-----------------------------

        public function WindowBase()
        {
            super(640, 480);
            updateLayout(LayoutType.FREE, 2, 2);

            if (stage)
                dispatchEvent(new Event('configureView', true));
            else
                addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
        }

        public function close():void
        {
            dispatchEvent(new WindowEvent(WindowEvent.CLOSE_WINDOW, definition))
        }

        //-----------------------------
        // Window Definition
        //-----------------------------

        private var _definition:Object;

        public function get definition():Object
        {
            return _definition;
        }
        public function set definition(value:Object):void
        {
            _definition = value;
        }

        //-------------------------------------------------------------------
        //
        // Private
        //
        //-------------------------------------------------------------------

        private function addedToStageHandler(event:Event):void
        {
            dispatchEvent(new Event('configureView', true));
            removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
        }
    }
}

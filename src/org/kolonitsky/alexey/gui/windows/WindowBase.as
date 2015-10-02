/**
 * Created by Aliaksei_Kalanitski on 10/2/2015.
 */
package org.kolonitsky.alexey.gui.windows
{
    import flash.display.Sprite;
    import flash.events.Event;

    public class WindowBase extends Sprite
    {
        //-----------------------------
        // Constructor
        //-----------------------------

        public function WindowBase()
        {
            if (stage)
                dispatchEvent(new Event('configureView', true));
            else
                addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
        }

        //-----------------------------
        // Window Data
        //-----------------------------

        private var _data:Object;

        public function get data():Object
        {
            return _data;
        }
        public function set data(data:Object):void
        {
            _data = data;
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

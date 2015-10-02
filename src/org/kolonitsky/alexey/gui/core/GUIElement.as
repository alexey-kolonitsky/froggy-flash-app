/**
 * Created by Aliaksei_Kalanitski on 10/1/2015.
 */
package org.kolonitsky.alexey.gui.core
{
    import flash.display.Sprite;
    import flash.events.Event;

    public class GUIElement extends Sprite
    {
        //-----------------------------
        // Constructor
        //-----------------------------

        public function GUIElement()
        {
            state = GUIState.CREATED;
            if (stage)
                initialize();
            else
                addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
        }

        //-----------------------------
        // State
        //-----------------------------

        private var _state:uint = GUIState.UNDEFINED;

        public function get state():uint
        {
            return _state;
        }

        public function set state(value:uint):void
        {
            _state = value;
        }

        public function initialize():void
        {
            _state = GUIState.INITIALIZED;
        }

        private function addedToStageHandler(event:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
            initialize();
        }
    }
}

/**
 * Created by Aliaksei_Kalanitski on 10/1/2015.
 */
package ua.com.froggy.flash.client.view.core
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
            if (stage)
                dispatchEvent(new Event('configureView', true));
            else
                addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);

            state = GUIState.CREATED;
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

        [Init]
        public function initialize():void
        {
            _state = GUIState.INITIALIZED;
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

/**
 * Created by Aliaksei_Kalanitski on 10/1/2015.
 */
package org.kolonitsky.alexey.gui.core
{
    import flash.display.Sprite;
    import flash.events.Event;

    [Event(name="guiResize", type="org.kolonitsky.alexey.gui.events.GUIEvent")]

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

        //-------------------------------------------------------------------
        // GUIElement API
        //-------------------------------------------------------------------

        /**
         * Initilize method invoked once after adding element to stage.
         * Override it in ancestors to initilize your component.
         */
        public function initialize():void
        {
            _state = GUIState.INITIALIZED;
        }

        public function drawWireframe(color:uint = 0xFF0000, size:uint = 1, fill:uint = NaN):void
        {
            graphics.clear();

            if ( !isNaN(fill) )
                graphics.beginFill(fill);

            if (size > 0)
                graphics.lineStyle(size, size);

            graphics.drawRect(0, 0, width, height);
            graphics.lineStyle();
            graphics.endFill();
        }

        private function addedToStageHandler(event:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
            initialize();
        }
    }
}

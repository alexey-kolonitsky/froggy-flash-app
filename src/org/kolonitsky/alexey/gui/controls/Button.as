/**
 * Created by Alexey on 11.09.2015.
 */
package org.kolonitsky.alexey.gui.controls
{
    import flash.events.FocusEvent;
    import flash.events.MouseEvent;

    import org.kolonitsky.alexey.gui.core.GUIElement;
    import org.kolonitsky.alexey.gui.core.GUIState;

    import ua.com.froggy.flash.client.Styles;

    public class Button extends GUIElement
    {
        public static const BUTTON_WIDTH:int = 128;
        public static const BUTTON_HEIGHT:int = 32;

        private var _textLabel:Label;


        //-----------------------------
        // Constructor
        //-----------------------------

        public function Button(text:String, width:int = BUTTON_WIDTH, height:int = BUTTON_HEIGHT)
        {
            useHandCursor = true;
            buttonMode = true;

            _textLabel = new Label(4, 4, width - 8, height - 8, Styles.BUTTON_TEXT);
            _textLabel.mouseEnabled = false;
            _textLabel.text = text;
            addChild(_textLabel);

            _width = width;
            _height = height;
            state = GUIState.BUTTON_UP;
            drawButton();
            addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
            addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
            addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
            addEventListener(FocusEvent.FOCUS_IN, focusHandler);
            addEventListener(FocusEvent.FOCUS_OUT, focusHandler)
        }

        private function focusHandler(event:FocusEvent):void
        {
            if (event.type == FocusEvent.FOCUS_IN)
                state = GUIState.BUTTON_OVER;
            else
                state = GUIState.BUTTON_UP;
            drawButton();
        }

        //-----------------------------
        // Width
        //-----------------------------

        private var _width:int;

        override public function get width():Number
        {
            return _width;
        }

        override public function set width(value:Number):void
        {
            _width = value;
            drawButton();
        }


        //-----------------------------
        // Height
        //-----------------------------

        private var _height:int;

        override public function get height():Number
        {
            return _height;
        }

        override public function set height(value:Number):void
        {
            _height = value;
            drawButton();
        }


        //-----------------------------
        // text
        //-----------------------------

        public function get text():String
        {
            return _textLabel.text;
        }

        public function set text(value:String):void
        {
            _textLabel.text = value;
        }

        private function drawButton():void
        {
            var color:uint = Styles.BUTTON_UP_COLOR;
            switch (state)
            {
                case GUIState.CREATED:
                case GUIState.INITIALIZED:
                case GUIState.BUTTON_UP:
                    color = Styles.BUTTON_UP_COLOR;
                    break;

                case GUIState.FOCUS_IN:
                case GUIState.BUTTON_OVER:
                    color = Styles.BUTTON_OVER_COLOR;
                    break;

                case GUIState.BUTTON_DOWN:
                    color = Styles.BUTTON_DOWN_COLOR;
                    break;
            }

            graphics.clear();
            graphics.beginFill(color);
            graphics.drawRect(0, 0, width, height);
            graphics.endFill();
        }

        private function mouseDownHandler(event:MouseEvent):void
        {
            state = GUIState.BUTTON_DOWN;
            drawButton();
        }

        private function rollOverHandler(event:MouseEvent):void
        {
            state = GUIState.BUTTON_OVER;
            drawButton();
        }

        private function rollOutHandler(event:MouseEvent):void
        {
            state = GUIState.BUTTON_UP;
            drawButton();
        }
    }
}

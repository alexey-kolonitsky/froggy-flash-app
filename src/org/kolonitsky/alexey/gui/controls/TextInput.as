/**
 * Created by Aliaksei_Kalanitski on 10/2/2015.
 */
package org.kolonitsky.alexey.gui.controls
{
    import flash.events.Event;
    import flash.events.FocusEvent;
    import flash.events.MouseEvent;
    import flash.events.TextEvent;
    import flash.text.AntiAliasType;
    import flash.text.TextField;
    import flash.text.TextFieldType;

    import ua.com.froggy.flash.client.Styles;

    import org.kolonitsky.alexey.gui.core.GUIElement;
    import org.kolonitsky.alexey.gui.core.GUIState;

    /**
     * One line text input component. Should be used if you need to
     * enter short part of information with prompt.
     */
    public class TextInput extends GUIElement
    {
        //-----------------------------
        // Constructor
        //-----------------------------

        public function TextInput(width:int, height:int)
        {
            super();
            _width = width;
            _height = height;

            createChildren();
        }

        //-----------------------------
        // measuredWidth
        //-----------------------------

        private var _width:Number;

        override public function get width():Number
        {
            return _width;
        }

        override public function set width(value:Number):void
        {
            _width = value;
            drawBorders();
        }


        //-----------------------------
        // measuredHeight
        //-----------------------------

        private var _height:Number;

        override public function get height():Number
        {
            return _height;
        }

        override public function set height(value:Number):void
        {
            _height = value;
            drawBorders();
        }

        //-----------------------------
        // Prompt Text
        //-----------------------------

        private var _promptText:String = "";
        private var _promptTextChanged:Boolean = true;

        public function get promptText():String
        {
            return _promptText;
        }

        public function set promptText(value:String):void
        {
            _promptText = value;
            _promptTextChanged = true;
            commitProperties();
        }


        //-----------------------------
        // Text
        //-----------------------------

        private var _text:String = "";
        private var _textChenged:Boolean;

        public function get text():String
        {
            return _text;
        }

        public function set text(value:String):void
        {
            _text = value;
            _textChenged = true;
            commitProperties();
        }

        override public function initialize():void
        {
            drawBorders();
            commitProperties();
            super.initialize();
        }

        protected function textChanged():void
        {
            _text = _inputTextField.text;
            trace("TextInput textChanged " + _text);
        }

        protected function commitProperties():void
        {
            if (_textChenged && _inputTextField && _text != _inputTextField.text)
            {
                _inputTextField.text = _text;
                updatePromptVisible();
                _textChenged = false;
            }

            if (_promptTextChanged && _promptTextField && _promptText != _promptTextField.text)
            {
                _promptTextField.text = _promptText;
                updatePromptVisible();
                _promptTextChanged = false;
            }
        }

        private function updatePromptVisible():void
        {
            if (_promptTextField == null || _promptText == null || _promptText.length == 0)
                return;

            _promptTextField.visible = _text == null || _text.length == 0;
        }

        protected function createChildren():void
        {
            _promptTextField = new Label(32, 0, _width, _height, Styles.HINT_TEXT);
            addChild(_promptTextField);

            _inputTextField = new TextField();
            _inputTextField.type = TextFieldType.INPUT;
            _inputTextField.defaultTextFormat = Styles.INPUT_FONT_FORMAT;
            _inputTextField.embedFonts = true;
            _inputTextField.antiAliasType = AntiAliasType.ADVANCED;
            _inputTextField.x = 32;
            _inputTextField.y = 4;
            _inputTextField.width = _width -32 -32;
            _inputTextField.height = _height -2 -2;
            _inputTextField.addEventListener(MouseEvent.MOUSE_DOWN, inputTextField_mouseDownHandler);
            _inputTextField.addEventListener(FocusEvent.FOCUS_IN, inputTextField_focusInHandler);
            _inputTextField.addEventListener(FocusEvent.FOCUS_OUT, inputTextField_focusInHandler);
            _inputTextField.addEventListener(Event.CHANGE, inputTextField_changeHandler);
            addChild(_inputTextField);
        }

        private function inputTextField_focusInHandler(event:FocusEvent):void
        {
            if (event.type == FocusEvent.FOCUS_IN)
                state = GUIState.FOCUS_IN;
            else
                state = GUIState.INITIALIZED;

            updatePromptVisible();
            drawBorders();
        }

        protected function drawBorders():void
        {
            if (isNaN(_width) || isNaN(_height))
                return;

            if (state == GUIState.FOCUS_IN)
            {
                graphics.beginFill(Styles.BACKGROUND_COLOR);
                graphics.lineStyle(1, Styles.BORDER_ACTIVE_COLOR, 1.0, true);
                graphics.drawRoundRect(0, 0, _width, _height, Styles.TEXT_INPUT_CORDERN_RADIUS, Styles.TEXT_INPUT_CORDERN_RADIUS);
                graphics.lineStyle();
                graphics.endFill();
            }
            else
            {
                graphics.beginFill(Styles.BACKGROUND_COLOR);
                graphics.lineStyle(1, Styles.BORDER_INACTIVE_COLOR, 1.0, true);
                graphics.drawRoundRect(0, 0, _width, _height, Styles.TEXT_INPUT_CORDERN_RADIUS, Styles.TEXT_INPUT_CORDERN_RADIUS);
                graphics.lineStyle();
                graphics.endFill();
            }
        }


        //-------------------------------------------------------------------
        //
        // Private
        //
        //-------------------------------------------------------------------

        private var _promptTextField:Label;
        private var _inputTextField:TextField;


        private function inputTextField_changeHandler(event:Event):void
        {
            textChanged();
        }

        private function inputTextField_mouseDownHandler(event : MouseEvent) : void
        {
            _promptTextField.visible = false;
        }
    }
}

/**
 * Created by Aliaksei_Kalanitski on 10/2/2015.
 */
package ua.com.froggy.flash.client.view.controls
{
    import flash.events.FocusEvent;
    import flash.events.MouseEvent;
    import flash.events.TextEvent;
    import flash.text.TextField;
    import flash.text.TextFieldType;

    import ua.com.froggy.flash.client.Styles;

    import ua.com.froggy.flash.client.view.core.GUIElement;
    import ua.com.froggy.flash.client.view.core.GUIState;

    /**
     * One line text input component. Should be used if you need to
     * enter short part of information with prompt.
     */
    public class TextInput extends GUIElement
    {


        //-----------------------------
        // Constructor
        //-----------------------------

        public function TextInput()
        {
            super();
        }

        //-----------------------------
        // width
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
        // height
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

        [Init]
        override public function initialize():void
        {
            createChildren();
            drawBorders();
            commitProperties();
            super.initialize();
        }

        protected function textChanged():void
        {
            _text = _inputTextField.text;
        }


        protected function commitProperties():void
        {
            if (_textChenged && _inputTextField && _text != _inputTextField.text)
            {
                _inputTextField.text = _text;
                _textChenged = false;
            }

            if (_promptTextChanged && _promptTextField && _promptText != _promptTextField.text)
            {
                _promptTextField.text = _promptText;
                _promptTextChanged = false;
            }

            if (_text && _text.length == 0 && _promptText && _promptText.length > 0)
                _promptTextField.visible = true;
        }

        protected function createChildren():void
        {
            _promptTextField = new Label(32, 0, 192, 30, Styles.HINT_TEXT);
            _promptTextField.text = _promptText;
            addChild(_promptTextField);

            _inputTextField = new TextField();
            _inputTextField.type = TextFieldType.INPUT;
            _inputTextField.defaultTextFormat = Styles.INPUT_FONT_FORMAT;
            _inputTextField.x = 32;
            _inputTextField.y = 4;
            _inputTextField.width = 192;
            _inputTextField.height = 24;
            _inputTextField.addEventListener(MouseEvent.MOUSE_DOWN, inputTextField_mouseDownHandler);
            _inputTextField.addEventListener(FocusEvent.FOCUS_IN, inputTextField_focusInHandler);
            _inputTextField.addEventListener(FocusEvent.FOCUS_OUT, inputTextField_focusInHandler);
            _inputTextField.addEventListener(TextEvent.TEXT_INPUT, inputTextField_changeHandler);

            addChild(_inputTextField);
        }

        private function inputTextField_focusInHandler(event:FocusEvent):void
        {
            trace("DEBUG: TextInput focus change: " + event.type);
            if (event.type == FocusEvent.FOCUS_IN)
                state = GUIState.FOCUS_IN;
            else
                state = GUIState.INITIALIZED;

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


        private function inputTextField_changeHandler(event:TextEvent):void
        {
            textChanged();
        }

        private function inputTextField_mouseDownHandler(event : MouseEvent) : void
        {
            _promptTextField.visible = false;
        }
    }
}

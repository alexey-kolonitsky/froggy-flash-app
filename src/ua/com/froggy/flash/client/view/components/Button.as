/**
 * Created by Alexey on 11.09.2015.
 */
package ua.com.froggy.flash.client.view.components
{
    import flash.display.Sprite;
    import flash.events.MouseEvent;

    import ua.com.froggy.flash.client.Styles;

    public class Button extends Sprite
    {
        public static const BUTTON_UP_COLOR:uint = 0xf2711f;
        public static const BUTTON_OVER_COLOR:uint = 0x1FF287;
        public static const BUTTON_DOWN_COLOR:uint = 0x1FF287;
        public static const BUTTON_WIDTH:int = 128;
        public static const BUTTON_HEIGHT:int = 32;

        private var _textLabel:Label;
        private var _width:int;
        private var _height:int;

        override public function get width():Number
        {
            return _width;
        }

        override public function get height():Number
        {
            return _height;
        }

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
            drawButton(BUTTON_UP_COLOR);
            addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
            addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
            addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
        }

        private function mouseDownHandler(event:MouseEvent):void
        {
            drawButton(BUTTON_DOWN_COLOR);
        }

        private function rollOverHandler(event:MouseEvent):void
        {
            drawButton(BUTTON_OVER_COLOR);
        }

        private function rollOutHandler(event:MouseEvent):void
        {
            drawButton(BUTTON_UP_COLOR);
        }



        public function get text():String
        {
            return _textLabel.text;
        }

        public function set text(value:String):void
        {
            _textLabel.text = value;
        }

        public function drawButton(color:uint):void
        {
            graphics.clear();
            graphics.beginFill(color);
            graphics.drawRect(0, 0, width, height);
            graphics.endFill();
        }
    }
}

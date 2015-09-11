/**
 * Created by Alexey on 16.08.2015.
 */
package ua.com.froggy.flash.client.view.froggy_components
{
    import flash.events.TextEvent;
    import flash.events.TimerEvent;
    import flash.utils.Timer;
    import flash.utils.getTimer;

    import ua.com.froggy.flash.client.events.SearchEvent;

    import ua.com.froggy.flash.client.view.components.*;
    import flash.display.Bitmap;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.FocusEvent;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import flash.text.TextFieldType;

    import ua.com.froggy.flash.client.Images;

    import ua.com.froggy.flash.client.Styles;

    public class SearchField extends Sprite
    {
        public var DEFAULT_WIDTH:Number = 256;
        public var DEFAULT_HEIGHT:Number = 32;
        private var SEARCH_DELAY:Number = 1000;

        private var _inputTextField:TextField;
        private var _promptTextField:Label;

        private var _searchIconBitmap:Bitmap;
        private var _removeIconBitmap:Bitmap;

        private var _searchTimer:Timer;
        private var _searchMask:String;
        private var _searchRequestTime:int;

        public function SearchField()
        {
            _searchIconBitmap = new Images.ICON_SEARCH;
            _searchIconBitmap.alpha = 0.4;
            _searchIconBitmap.x = 4;
            _searchIconBitmap.y = 4;
            addChild(_searchIconBitmap);

            _removeIconBitmap = new Images.ICON_REMOVE;
            _removeIconBitmap.x = DEFAULT_WIDTH - 4 - _removeIconBitmap.width;
            _removeIconBitmap.y = 4;
            _removeIconBitmap.alpha = 0.4;
            _removeIconBitmap.visible = false;
            _removeIconBitmap.addEventListener(MouseEvent.CLICK, removeIconBitmap_clickHandler);
            addChild(_removeIconBitmap);

            _promptTextField = new Label(32, 0, 220, 30, Styles.HINT_TEXT);
            _promptTextField.text = "ангел";
            addChild(_promptTextField);

            _inputTextField = new TextField();
            _inputTextField.type = TextFieldType.INPUT;
            _inputTextField.defaultTextFormat = Styles.BASE_TEXT_FORMAT;
            _inputTextField.x = 32;
            _inputTextField.y = 4;
            _inputTextField.width = 220;
            _inputTextField.height = 24;
            _inputTextField.addEventListener(MouseEvent.MOUSE_DOWN, inputTextField_mouseDownHandler);
            _inputTextField.addEventListener(TextEvent.TEXT_INPUT, inputTextField_changeHandler);
            addChild(_inputTextField);

            _searchTimer = new Timer(SEARCH_DELAY);
            _searchTimer.addEventListener(TimerEvent.TIMER, searchTimer_timerHandler);

            _searchMask = "";

            graphics.beginFill(0xFFFFFF);
            graphics.lineStyle(1, 0xEEEEEE, 1.0, true);
            graphics.drawRoundRect(0, 0, DEFAULT_WIDTH, DEFAULT_HEIGHT, 16, 16);
            graphics.lineStyle();
            graphics.endFill();
        }

        private function removeIconBitmap_clickHandler(event:MouseEvent):void
        {
            clear();
        }

        private function clear():void
        {
            dispatchEvent(new SearchEvent(SearchEvent.CLEAR));
            _removeIconBitmap.visible = false;
            _promptTextField.visible = true;
            _searchTimer.stop();
        }

        private function searchTimer_timerHandler(event:TimerEvent):void
        {
            search();
        }

        private function inputTextField_changeHandler(event:TextEvent):void
        {
            search();
        }

        private function inputTextField_mouseDownHandler(event : MouseEvent) : void
        {
            _promptTextField.visible = false;
        }

        private function search()
        {
            if (_searchMask == _inputTextField.text)
                return;

            var maskLength:int = _inputTextField.text.length;
            _promptTextField.visible = maskLength < 1;
            _removeIconBitmap.visible = maskLength > 1;

            if (_searchMask == "")
                _searchTimer.start();
            _searchMask = _inputTextField.text;

            if (_searchMask == "")
            {
                clear();
                return;
            }

            var timer:int = getTimer();
            var dt:int = timer - _searchRequestTime;
            if (dt > SEARCH_DELAY || _searchRequestTime == 0)
            {
                _searchRequestTime = timer;
                dispatchEvent(new SearchEvent(SearchEvent.SEARCH, _searchMask));
            }
        }
    }
}

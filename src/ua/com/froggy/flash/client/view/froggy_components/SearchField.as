/**
 * Created by Alexey on 16.08.2015.
 */
package ua.com.froggy.flash.client.view.froggy_components
{
    import flash.display.Bitmap;
    import flash.display.SimpleButton;
    import flash.events.MouseEvent;
    import flash.events.TimerEvent;
    import flash.utils.Timer;
    import flash.utils.getTimer;

    import ua.com.froggy.flash.client.Images;
    import ua.com.froggy.flash.client.events.SearchEvent;
    import org.kolonitsky.alexey.gui.controls.TextInput;

    public class SearchField extends TextInput
    {
        public var DEFAULT_WIDTH:Number = 256;
        public var DEFAULT_HEIGHT:Number = 32;
        private var SEARCH_DELAY:Number = 1000;

        public function SearchField()
        {
            super();

            width = DEFAULT_WIDTH;
            height = DEFAULT_HEIGHT;

            _searchTimer = new Timer(SEARCH_DELAY);
            _searchTimer.addEventListener(TimerEvent.TIMER, searchTimer_timerHandler);

            _searchMask = "";
        }

        [Init]
        override public function initialize():void
        {
            super.initialize();
        }

        override protected function createChildren():void
        {
            super.createChildren();

            _searchIconBitmap = new Images.ICON_SEARCH;
            _searchIconBitmap.alpha = 0.4;
            _searchIconBitmap.x = 4;
            _searchIconBitmap.y = 4;
            addChild(_searchIconBitmap);

            _removeIconBitmap = new SimpleButton(new Images.ICON_REMOVE,new Images.ICON_REMOVE,new Images.ICON_REMOVE,new Images.ICON_REMOVE);
            _removeIconBitmap.x = DEFAULT_WIDTH - 4 - _removeIconBitmap.width;
            _removeIconBitmap.y = 4;
            _removeIconBitmap.alpha = 0.4;
            _removeIconBitmap.visible = false;
            _removeIconBitmap.addEventListener(MouseEvent.CLICK, removeIconBitmap_clickHandler);
            addChild(_removeIconBitmap);
        }

        override protected function textChanged():void
        {
            if (_searchMask == text)
                return;

            var maskLength:int = text.length;
            _removeIconBitmap.visible = maskLength > 1;

            if (_searchMask.length < 1)
                _searchTimer.start();
            _searchMask = text;

            if (_searchMask.length < 1)
            {
                clear();
                return;
            }

            var timer:int = getTimer();
            var dt:int = timer - _searchRequestTime;
            if (dt > SEARCH_DELAY || _searchRequestTime == 0)
            {
                _searchRequestTime = timer;
                trace("[INFO] [SearchField] search: " + _searchMask);
                dispatchEvent(new SearchEvent(SearchEvent.SEARCH, _searchMask));
            }
        }


        //-------------------------------------------------------------------
        //
        // Private
        //
        //-------------------------------------------------------------------

        private var _searchIconBitmap:Bitmap;
        private var _removeIconBitmap:SimpleButton;

        private var _searchTimer:Timer;
        private var _searchMask:String;
        private var _searchRequestTime:int;

        private function clear():void
        {
            text = "";
            _searchTimer.stop();
            dispatchEvent(new SearchEvent(SearchEvent.CLEAR));
        }

        //-------------------------------------------------------------------
        // Event Handlers
        //-------------------------------------------------------------------

        private function removeIconBitmap_clickHandler(event:MouseEvent):void
        {
            clear();
        }

        private function searchTimer_timerHandler(event:TimerEvent):void
        {
            textChanged();
        }
    }
}

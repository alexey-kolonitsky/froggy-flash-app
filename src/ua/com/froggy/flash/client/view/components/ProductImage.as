/**
 * Created by Alexey on 10.09.2015.
 */
package ua.com.froggy.flash.client.view.components
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Loader;
    import flash.display.LoaderInfo;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.net.URLRequest;

    import ua.com.froggy.flash.client.Styles;

    public class ProductImage extends Sprite
    {
        private var _imageWidht:int;
        private var _imageHeight:int;
        private var _url:String;
        private var _autoLoad:Boolean = true;

        private var _loader:Loader;
        private var _label:Label;

        private var _bitmapData:BitmapData;

        public function get bitmapData():BitmapData
        {
            return _bitmapData;
        }

        public function set bitmapData(value:BitmapData):void
        {
            _bitmapData = value;
            drawBoundary();
        }

        public function ProductImage(imageWidth, imageHeight)
        {
            _imageWidht = imageWidth;
            _imageHeight = imageHeight;

            _label = new Label(0, 0, 256, 60, Styles.PRODUCT_DESCTIPTION_FORMAT, true);
            _label.text = "loading...";
            addChild(_label);

            _loader = new Loader();
            _loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loader_ioErrorHandler);
            _loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loader_completeHandler);
            _loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loader_progressHandelr);

            drawBoundary();
        }

        private function loader_progressHandelr(event:ProgressEvent):void
        {
            var loadingPercent:int = Math.ceil(100 * event.bytesLoaded / event.bytesTotal);
            _label.text = "loading: " + loadingPercent + "%";
        }

        private function loader_completeHandler(event:Event):void
        {
            if (_label.parent == this)
                removeChild(_label);

            var loaderInfo:LoaderInfo = event.target as LoaderInfo;
            var bitmap:Bitmap = loaderInfo.content as Bitmap;
            _bitmapData = bitmap.bitmapData;
            drawBoundary();
        }

        private function loader_ioErrorHandler(event:IOErrorEvent):void
        {
            _label.text = event.text;
        }


        public function get url():String
        {
            return _url;
        }

        public function set url(value:String)
        {
            _url = value;
            if (_autoLoad)
                load();
        }

        public function load():void
        {
            if (_url == null || _url == "")
            {
                trace("[WARNING] Wrang URL");
                return;
            }

            _loader.load(new URLRequest(_url));
        }

        private function drawBoundary():void
        {
            if (_bitmapData == null)
                graphics.beginFill(0x00FFFF);
            else
                graphics.beginBitmapFill(_bitmapData);

            graphics.drawRect(0, 0, _imageWidht, _imageHeight);
            graphics.endFill();
        }
    }
}

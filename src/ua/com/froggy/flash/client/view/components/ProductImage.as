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
    import flash.geom.Matrix;
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
        private var _scaleMode:String;

        public function get bitmapData():BitmapData
        {
            return _bitmapData;
        }

        public function set bitmapData(value:BitmapData):void
        {
            _bitmapData = value;
            drawBoundary();
        }

        public function ProductImage(imageWidth:Number, imageHeight:Number, fitType:String = "noScale")
        {
            _imageWidht = imageWidth;
            _imageHeight = imageHeight;
            _scaleMode = fitType;

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
            dispatchEvent(new Event(Event.COMPLETE));
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
                graphics.beginFill(0x229544);
            else
            {
                var m:Matrix = new Matrix();
                var sx:Number = _imageWidht / _bitmapData.width;
                var sy:Number = _imageHeight / _bitmapData.height;
                var smax:Number = sx > sy ? sx : sy;
                var smin:Number = sx < sy ? sx : sy;
                switch(_scaleMode)
                {
                    case FitType.FIT:
                        m.scale(sx, sy);
                        break;
                    case FitType.FIT_LONGEST:
                        m.scale(smax, smax);
                        break;
                    case FitType.FIT_SHORTEST:
                        m.scale(smin, smin);
                        break;

                    default:
                    case FitType.NO_SCALE:
                        break;
                }
                graphics.beginBitmapFill(_bitmapData, m, false, true);
            }

            graphics.drawRect(0, 0, _imageWidht, _imageHeight);
            graphics.endFill();
        }
    }
}

/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.view.renderers
{
    import flash.display.Bitmap;
    import flash.display.Loader;
    import flash.display.SimpleButton;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.net.URLRequest;

    import ua.com.froggy.flash.client.Styles;

    import ua.com.froggy.flash.client.model.vo.ProductVO;

    import ua.com.froggy.flash.client.view.components.IItemRenderer;
    import ua.com.froggy.flash.client.view.components.Label;
    import ua.com.froggy.flash.client.view.components.ProductImage;

    public class ProductItemRenderer extends Sprite implements IItemRenderer
    {
        public static const DEFAULT_WIDTH:int = 256;
        public static const DEFAULT_HEIGHT:int = 512;

        private var _photo:ProductImage;
        private var _titleLabel:Label;
        private var _descriptionLabel:Label;
        private var _priceLabel:Label;
        private var _buyButton:SimpleButton;

        private var _data:ProductVO;

        private var _loader:Loader;

        public function ProductItemRenderer()
        {
            graphics.beginFill(0xEEEEEE);
            graphics.lineStyle(1, 0x000000);
            graphics.drawRoundRect(0, 0, DEFAULT_WIDTH, DEFAULT_HEIGHT, 16, 16);
            graphics.lineStyle();
            graphics.endFill();

            _titleLabel = new Label(0, 256, DEFAULT_WIDTH, 64, Styles.PRODUCT_TITLE_FORMAT, false);
            addChild(_titleLabel);

            _descriptionLabel = new Label(0, 256 + 64, DEFAULT_WIDTH, 128, Styles.BASE_TEXT_FORMAT, true);
            addChild(_descriptionLabel);

            _photo = new ProductImage(DEFAULT_WIDTH, DEFAULT_WIDTH);
            _photo.addEventListener(Event.COMPLETE, photoCompleteHandler);
            addChild(_photo);
        }

        private function photoCompleteHandler(event:Event):void
        {
            _data.imageBitmap = _photo.bitmapData;
        }

        public function get data() : Object
        {
            return _data;
        }

        public function set data(value : Object) : void
        {
            if (value is ProductVO)
            {
                _data = value as ProductVO;
                update();
            }
            else
            {
                trace("ERROR: Wrong Data");
            }
        }

        public function get index() : int
        {
            return 0;
        }

        public function set index(value : int) : void
        {
        }

        public function get id() : int
        {
            if (_data)
                _data.id;
            return 0;
        }

        private function update()
        {
            if (_data && _titleLabel)
                _titleLabel.text = _data.title;
            if (_data && _descriptionLabel)
                _descriptionLabel.text = _data.description;

            if (_data && _photo)
            {
                if (_data.imageBitmap != null)
                {
                    _photo.bitmapData = _data.imageBitmap;
                }
                else
                {
                    _photo.url = _data.imageURL;
                    _photo.load();
                }
            }

        }
    }
}

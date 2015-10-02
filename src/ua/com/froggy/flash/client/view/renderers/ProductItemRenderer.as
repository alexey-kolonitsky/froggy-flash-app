/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.view.renderers
{
    import flash.display.Loader;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;

    import ua.com.froggy.flash.client.Styles;
    import ua.com.froggy.flash.client.events.ProductEvent;
    import ua.com.froggy.flash.client.model.vo.ProductVO;
    import org.kolonitsky.alexey.gui.controls.Button;
    import ua.com.froggy.flash.client.view.components.IItemRenderer;
    import org.kolonitsky.alexey.gui.controls.Label;
    import org.kolonitsky.alexey.gui.controls.Image;

    public class ProductItemRenderer extends Sprite implements IItemRenderer
    {
        public static const DEFAULT_WIDTH:int = 256;
        public static const DEFAULT_HEIGHT:int = 412;

        private var _photo:Image;
        private var _titleLabel:Label;
        private var _descriptionLabel:Label;
        private var _priceLabel:Label;
        private var _buyButton:Button;

        private var _data:ProductVO;

        private var _loader:Loader;

        public function ProductItemRenderer()
        {
            graphics.beginFill(0xEEEEEE);
            graphics.lineStyle(1, 0x000000);
            graphics.drawRoundRect(0, 0, DEFAULT_WIDTH, DEFAULT_HEIGHT, 16, 16);
            graphics.lineStyle();
            graphics.endFill();

            _photo = new Image(DEFAULT_WIDTH, DEFAULT_WIDTH);
            _photo.addEventListener(Event.COMPLETE, photoCompleteHandler);
            addChild(_photo);

            _titleLabel = new Label(0, 256, DEFAULT_WIDTH, 32, Styles.PRODUCT_TITLE_FORMAT, false);
            addChild(_titleLabel);

            _buyButton = new Button("Купить");
            _buyButton.x = (DEFAULT_WIDTH - _buyButton.width) / 2;
            _buyButton.y = 256 + 32;
            _buyButton.addEventListener(MouseEvent.CLICK, buyButton_clickHandler);
            addChild(_buyButton);

            _descriptionLabel = new Label(0, 256 + 64, DEFAULT_WIDTH, 128, Styles.BASE_TEXT_FORMAT, true);
            addChild(_descriptionLabel);
        }

        private function buyButton_clickHandler(event:MouseEvent):void
        {
            var e:ProductEvent = new ProductEvent(ProductEvent.BUY, _data);
            dispatchEvent(e);
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

        public function get id() : String
        {
            if (_data)
                return _data.id;
            return "";
        }

        private function update()
        {
            if (_data && _titleLabel)
                _titleLabel.text = _data.title;
            if (_data && _descriptionLabel)
                _descriptionLabel.htmlText = _data.description;

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

            if (_data && _buyButton && _data.price)
                _buyButton.text = "Купить за " + _data.price;
        }
    }
}

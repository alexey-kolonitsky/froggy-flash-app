/**
 * Created by Alexey on 11.09.2015.
 */
package ua.com.froggy.flash.client.view.renderers
{
    import flash.display.Sprite;

    import ua.com.froggy.flash.client.model.vo.OrderVO;
    import ua.com.froggy.flash.client.view.components.Button;
    import ua.com.froggy.flash.client.view.components.FitType;

    import ua.com.froggy.flash.client.view.components.IItemRenderer;

    import ua.com.froggy.flash.client.view.components.ProductImage;

    public class OrderSmallRenderer extends Sprite implements IItemRenderer
    {
        public static const DEFAULT_WIDTH:int = 64;
        public static const DEFAULT_HEIGHT:int = 64;

        private var _photo:ProductImage;
        private var _data:OrderVO;
        private var _index:int = 0;

        public function OrderSmallRenderer()
        {
            _photo = new ProductImage(DEFAULT_WIDTH, DEFAULT_HEIGHT, FitType.FIT);
            addChild(_photo);

            graphics.beginFill(0xFFFF00);
            graphics.drawRect(0, 0, DEFAULT_WIDTH, DEFAULT_HEIGHT);
            graphics.endFill();
        }

        public function get data():Object
        {
            return _data;
        }

        public function set data(value:Object):void
        {
            _data = value as OrderVO;
            updateData();
        }

        private function updateData():void
        {
            if (_data && _photo)
            {
                if (_data.product && _data.product.imageBitmap)
                    _photo.bitmapData = _data.product.imageBitmap;
                else
                    _photo.url = _data.product.imageURL;
            }
        }

        public function get index():int
        {
            return _index;
        }

        public function set index(value:int):void
        {
            _index = value;
        }

        public function get id():String
        {
            return _data.productId;
        }
    }
}

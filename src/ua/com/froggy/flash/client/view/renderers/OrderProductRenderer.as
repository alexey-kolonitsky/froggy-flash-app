/**
 * Created by Aliaksei_Kalanitski on 10/2/2015.
 */
package ua.com.froggy.flash.client.view.renderers
{
    import flash.display.Sprite;
    import flash.events.MouseEvent;

    import org.kolonitsky.alexey.gui.controls.Button;
    import org.kolonitsky.alexey.gui.controls.Label;
    import org.kolonitsky.alexey.gui.core.GUIGroup;

    import ua.com.froggy.flash.client.Styles;

    import ua.com.froggy.flash.client.model.vo.OrderProductVO;
    import ua.com.froggy.flash.client.model.vo.ProductVO;

    import ua.com.froggy.flash.client.view.components.IItemRenderer;
    import org.kolonitsky.alexey.gui.controls.Image;
    import org.kolonitsky.alexey.gui.controls.ImageScaleMode;

    import ua.com.froggy.flash.client.view.components.LayoutType;

    public class OrderProductRenderer extends GUIGroup implements IItemRenderer
    {
        public static const DEFAULT_WIDTH:int = 640 - 8 - 8;
        public static const DEFAULT_HEIGHT:int = 64;

        private var _photo:Image;
        private var _title:Label;
        private var _price:Label;
        private var _totalPrice:Label;
        private var _count:Label;
        private var _increaseCountButton:Button;
        private var _decreaseCountButton:Button;
        private var _index:int = 0;

        public function OrderProductRenderer()
        {
            super(DEFAULT_WIDTH, DEFAULT_HEIGHT);
            updateLayout(LayoutType.HORIZONTAL);

            _photo = new Image(64, 64, ImageScaleMode.FIT);
            addElement(_photo);

            _title = new Label(0, 0, 240, 30, Styles.BASE_TEXT_FORMAT);
            addElement(_title);

            _price = new Label(0, 0, 60, 30, Styles.BASE_TEXT_FORMAT);
            addElement(_price);

            _decreaseCountButton = new Button("-", 40, 30);
            _decreaseCountButton.addEventListener(MouseEvent.CLICK, decreaseCountButton_clickHandler);
            addElement(_decreaseCountButton);

            _count = new Label(260, 0, 40, 30, Styles.BASE_TEXT_FORMAT);
            addElement(_count);

            _increaseCountButton = new Button("+", 40, 30);
            _increaseCountButton.addEventListener(MouseEvent.CLICK, increaseCountButton_clickHandler);
            addElement(_increaseCountButton);

            _totalPrice = new Label(0, 0, 60, 30, Styles.BASE_TEXT_FORMAT);
            addElement(_totalPrice);

            drawWireframe(0, 0, 0xDBEDA2);
        }

        //-------------------------------------------------------------------
        // IItemRenderer implementation
        //-------------------------------------------------------------------

        //-----------------------------
        // Data
        //-----------------------------

        private var _data:OrderProductVO;

        public function get data():Object
        {
            return _data;
        }

        public function set data(value:Object):void
        {
            _data = value as OrderProductVO;
            updateData();
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

        private function updateData():void
        {
            if (_data && _photo)
            {
                var product:ProductVO =  _data.product;
                if (product == null)
                    return;

                if (product.imageBitmap)
                    _photo.bitmapData = product.imageBitmap;
                else
                    _photo.url = product.imageURL;

                _title.text = product.title;
                _count.text = _data.count.toString();
                _totalPrice.text = _data.localPrice;
            }
        }


        //-------------------------------------------------------------------
        // Event handlers
        //-------------------------------------------------------------------

        private function decreaseCountButton_clickHandler(event:MouseEvent):void
        {

        }

        private function increaseCountButton_clickHandler(event:MouseEvent):void
        {

        }

    }
}

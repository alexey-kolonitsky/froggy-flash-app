/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.view.renderers
{
    import flash.display.Bitmap;
    import flash.display.SimpleButton;
    import flash.display.Sprite;

    import ua.com.froggy.flash.client.view.components.IItemRenderer;
    import ua.com.froggy.flash.client.view.components.Label;

    public class ProductItemRenderer extends Sprite implements IItemRenderer
    {
        private var _imageBitmap:Bitmap;
        private var _titleLabel:Label;
        private var _descriptionLabel:Label;
        private var _priceLabel:Label;
        private var _buyButton:SimpleButton;

        public function ProductItemRenderer()
        {

        }

        public function get data() : Object
        {
            return null;
        }

        public function set data(value : Object) : void
        {
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
            return 0;
        }
    }
}

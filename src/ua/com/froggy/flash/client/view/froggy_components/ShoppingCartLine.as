/**
 * Created by Alexey on 11.09.2015.
 */
package ua.com.froggy.flash.client.view.froggy_components
{
    import flash.display.Sprite;

    import ua.com.froggy.flash.client.model.vo.OrderVO;
    import ua.com.froggy.flash.client.model.vo.ProductVO;
    import ua.com.froggy.flash.client.view.components.Button;
    import ua.com.froggy.flash.client.view.components.LayoutType;
    import ua.com.froggy.flash.client.view.components.List;
    import ua.com.froggy.flash.client.view.renderers.OrderSmallRenderer;

    public class ShoppingCartLine extends Sprite
    {
        public static const DEFAULT_WIDTH:int = 512;
        public static const DEFAULT_HEIGHT:int = 64;

        public static const MAX_ITEM_COUNT:int = 5;

        public var _list:List;

        private var _orderButton:Button;
        private var _width:Number;
        private var _height:Number;

        public function ShoppingCartLine()
        {
            _list = new List(OrderSmallRenderer, DEFAULT_WIDTH, DEFAULT_HEIGHT,
                OrderSmallRenderer.DEFAULT_WIDTH, OrderSmallRenderer.DEFAULT_HEIGHT,
                LayoutType.HORIZONTAL_LAYOUT);
            addChild(_list);

            _orderButton = new Button("Заказать.");
            _orderButton.x = MAX_ITEM_COUNT * OrderSmallRenderer.DEFAULT_WIDTH;
            addChild(_orderButton);

            _width = MAX_ITEM_COUNT * OrderSmallRenderer.DEFAULT_WIDTH + _orderButton.width;
            _height = OrderSmallRenderer.DEFAULT_HEIGHT;
            drawBorder();
        }

        override public function get width():Number
        {
            return _width;
        }

        override public function get height():Number
        {
            return _height;
        }

        public function get orders():Vector.<Object>
        {
            return _list.dataProvider;
        }

        public function set orders(value:Vector.<Object>):void
        {
            _list.dataProvider = value;
        }

        private function drawBorder():void
        {
            graphics.lineStyle(2, 0xFF0000);
            graphics.drawRect(0, 0, _width, _height);
            graphics.lineStyle();
        }
    }
}

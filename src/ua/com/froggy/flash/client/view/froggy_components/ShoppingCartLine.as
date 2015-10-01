/**
 * Created by Alexey on 11.09.2015.
 */
package ua.com.froggy.flash.client.view.froggy_components
{
    import flash.events.Event;

    import ua.com.froggy.flash.client.events.CartEvent;
    import ua.com.froggy.flash.client.model.ShoppingCartProxy;
    import ua.com.froggy.flash.client.view.components.LayoutType;
    import ua.com.froggy.flash.client.view.components.List;
    import ua.com.froggy.flash.client.view.controls.Button;
    import ua.com.froggy.flash.client.view.core.GUIElement;
    import ua.com.froggy.flash.client.view.renderers.OrderSmallRenderer;

    public class ShoppingCartLine extends GUIElement
    {
        public static const DEFAULT_WIDTH:int = 513;
        public static const DEFAULT_HEIGHT:int = 64;

        public static const MAX_ITEM_COUNT:int = 5;

        public var _list:List;

        private var _orderButton:Button;
        private var _width:Number;
        private var _height:Number;

        [Inject]
        public var cartProxy:ShoppingCartProxy;


        //-----------------------------
        // Constructor
        //-----------------------------

        public function ShoppingCartLine()
        {
            super();
            createChildren();
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

        [Init]
        override public function initialize():void
        {
            updatePosition();
            stage.addEventListener(Event.RESIZE, stage_resizeHandler);
        }

        [MessageHandler]
        public function shoppingCartChanged(event:CartEvent):void
        {
            _list.dataProvider = cartProxy.orders;
        }




        //-------------------------------------------------------------------
        //
        // Private
        //
        //-------------------------------------------------------------------

        private function createChildren():void
        {
            _list = new List(OrderSmallRenderer,
                DEFAULT_WIDTH,
                DEFAULT_HEIGHT,
                OrderSmallRenderer.DEFAULT_WIDTH,
                OrderSmallRenderer.DEFAULT_HEIGHT,
                LayoutType.HORIZONTAL_LAYOUT);
            addChild(_list);

            _orderButton = new Button("Заказать.  ");
            _orderButton.x = MAX_ITEM_COUNT * OrderSmallRenderer.DEFAULT_WIDTH;
            addChild(_orderButton);
        }

        private function updatePosition():void
        {
            _width = MAX_ITEM_COUNT * OrderSmallRenderer.DEFAULT_WIDTH + _orderButton.width;
            _height = OrderSmallRenderer.DEFAULT_HEIGHT;
            x = stage.stageWidth - _width - 8;
            y = 60;
            drawBorder();
        }

        private function drawBorder():void
        {
            graphics.lineStyle(2, 0xFF0000);
            graphics.drawRect(0, 0, _width, _height);
            graphics.lineStyle();
        }

        //-------------------------------------------------------------------
        // Event Handlers
        //-------------------------------------------------------------------

        private function stage_resizeHandler(event:Event):void
        {
            updatePosition();
        }
    }
}

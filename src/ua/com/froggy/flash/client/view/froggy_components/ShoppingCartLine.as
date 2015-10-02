/**
 * Created by Alexey on 11.09.2015.
 */
package ua.com.froggy.flash.client.view.froggy_components
{
    import flash.events.Event;
    import flash.events.MouseEvent;

    import org.kolonitsky.alexey.gui.events.WindowEvent;

    import ua.com.froggy.flash.client.events.CartEvent;
    import ua.com.froggy.flash.client.model.ShoppingCartProxy;
    import ua.com.froggy.flash.client.view.components.LayoutType;
    import ua.com.froggy.flash.client.view.components.List;
    import org.kolonitsky.alexey.gui.controls.Button;
    import org.kolonitsky.alexey.gui.core.ViewComponent;
    import ua.com.froggy.flash.client.view.renderers.OrderSmallRenderer;
    import ua.com.froggy.flash.client.view.windows.OrderWindow;

    public class ShoppingCartLine extends ViewComponent
    {
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
        public function initialize():void
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
            var listWidth:int = MAX_ITEM_COUNT * (OrderSmallRenderer.DEFAULT_WIDTH + 2);

            _list = new List(OrderSmallRenderer, listWidth,
                OrderSmallRenderer.DEFAULT_WIDTH,
                OrderSmallRenderer.DEFAULT_HEIGHT,
                LayoutType.HORIZONTAL_LAYOUT);
            addChild(_list);

            _orderButton = new Button("Заказать.  ");
            _orderButton.x = listWidth;
            _orderButton.addEventListener(MouseEvent.CLICK, orderButton_clickHandler);
            addChild(_orderButton);
        }

        private function updatePosition():void
        {
            var listWidth:int = MAX_ITEM_COUNT * (OrderSmallRenderer.DEFAULT_WIDTH + 2);
            _width = listWidth + _orderButton.width;
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


        private function orderButton_clickHandler(event:MouseEvent):void
        {
            dispatchEvent(new WindowEvent(WindowEvent.OPEN_WINDOW, OrderWindow.TYPE));
        }

        private function stage_resizeHandler(event:Event):void
        {
            updatePosition();
        }
    }
}

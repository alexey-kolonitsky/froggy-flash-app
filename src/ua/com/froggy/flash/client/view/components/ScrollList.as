/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.view.components
{
    import flash.display.DisplayObject;
    import flash.display.Sprite;

    import ua.com.froggy.flash.client.model.vo.ProductVO;

    public class ScrollList extends Sprite
    {
        private var _itemRendererClass:Class;
        private var _dataProvider:Vector.<Object>;

        /**
         * Pool of ItemRenderers.
         */
        private var _renderers:Vector.<IItemRenderer>;

        private var contentWidth:int = 700;
        private var contentHeight:int = 500;

        private var itemWidth:int = 256;
        private var itemHeight:int = 300;

        public function ScrollList(itemRendererClass:Class, contentWidth:int, contentHeight:int)
        {
            super();
            _renderers = new Vector.<IItemRenderer>();
            _itemRendererClass = itemRendererClass;

            updateSize(contentWidth, contentHeight);
        }

        public function get dataProvider():Vector.<Object>
        {
            return _dataProvider;
        }

        public function set dataProvider(value:Vector.<Object>)
        {
            _dataProvider = value;
            createItemRenderers();
        }

        public function updateSize(contentX:int, contentY:int)
        {
            this.contentWidth = contentX;
            this.contentHeight = contentY;

            updateRenderersPosition();
        }

        private function createItemRenderers():void
        {
            if (_itemRendererClass == null)
            {
                trace("[ERROR] [View] itemRendererClass not defined");
                return;
            }

            if (_dataProvider == null || _dataProvider.length == 0)
            {
                trace("[ERROR] [View] data is not defined");
                return;
            }

            var i:int;
            var child:DisplayObject;
            var itemRenderer:IItemRenderer;
            var n:int = _dataProvider.length;
            if (n > _renderers.length)
            {
                n = _renderers.length - n;

                for (i = 0; i < n; i++)
                {
                    itemRenderer = new _itemRendererClass();
                    itemRenderer.data = _dataProvider[i];
                    itemRenderer.index = i;
                    _renderers.push(itemRenderer);

                    child = itemRenderer as DisplayObject;
                    addChild(child);
                }
            }
            else
            {
                n = n - _renderers.length;
                for (i = 0; i < n; i++)
                {
                    itemRenderer = _renderers[_renderers.length - 1 - n];

                    child = itemRenderer as DisplayObject;
                    removeChild(child);
                }
            }
        }

        private function updateRenderersPosition():void
        {
            var rowIndex = 0;
            var colIndex = 0;
            var colMax = Math.ceil(contentWidth / itemWidth);

            if (_renderers == null || _renderers.length == 0)
                return;

            if (_dataProvider == null || _dataProvider.length != _renderers.length)
                return;

            var n:int = _dataProvider.length;
            for (var i:int = 0; i < n; i++)
            {
                var xPos:int = 0;
                var yPos:int = 0;
                if (colIndex > colMax)
                {
                    rowIndex += 1;
                    colIndex = 0;
                }

                var child:DisplayObject = _renderers[i] as DisplayObject;
                if (child)
                {
                    child.x = colIndex * itemWidth;
                    child.y = rowIndex * itemHeight;
                }
                else
                {
                    trace("[ERROR] [View] ItemRenderer must be inherited from DisplayObject");
                }
            }
        }
    }
}

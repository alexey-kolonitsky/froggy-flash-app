/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.view.components
{
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.globalization.NumberParseResult;

    import ua.com.froggy.flash.client.model.vo.ProductVO;

    public class List extends Sprite
    {
        private var _itemRendererClass:Class;
        private var _dataProvider:Vector.<Object>;

        /**
         * Pool of ItemRenderers.
         */
        private var _renderers:Vector.<IItemRenderer>;

        private var _contentWidth:int = 700;
        private var _contentHeight:int = 500;

        private var horizontalGap = 2;
        private var verticalGap = 2;

        private var _itemWidth:int = 0;
        private var _itemHeight:int = 0;

        private var _colMax:int;
        private var _rowMax:int;
        private var _width:int;
        private var _height:int;

        public function List(itemRendererClass:Class, contentWidth:int, contentHeight:int, itemWidth:int, itemHeight:int)
        {
            super();
            _renderers = new Vector.<IItemRenderer>();
            _itemRendererClass = itemRendererClass;

            updateSize(contentWidth, contentHeight);
            setItemSize(itemWidth, itemHeight);
        }

        private function setItemSize(itemWidth:int, itemHeight:int):void
        {
            _itemWidth = itemWidth;
            _itemHeight = itemHeight;
            updateRenderersPosition();
        }

        public function get dataProvider():Vector.<Object>
        {
            return _dataProvider;
        }

        public function set dataProvider(value:Vector.<Object>)
        {
            _dataProvider = value;
            createItemRenderers();
            updateRenderersPosition();
        }

        override public function get width():Number
        {
            return _width;
        }

        override public function get height():Number
        {
            return _height;
        }

        public function updateSize(contentX:int, contentY:int)
        {
            _contentWidth = contentX;
            _contentHeight = contentY;
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
            if (_dataProvider.length > _renderers.length)
            {
                var n:int = _dataProvider.length - _renderers.length;

                for (i = 0; i < n; i++)
                {
                    itemRenderer = new _itemRendererClass();
                    _renderers.push(itemRenderer);

                    child = itemRenderer as DisplayObject;
                    addChild(child);
                }
            }

            n = _renderers.length;
            for (i = 0; i < n; i++)
            {
                var isVisible:Boolean = i < _dataProvider.length;

                itemRenderer = _renderers[i];
                if (isVisible)
                {
                    itemRenderer.index = i;
                    itemRenderer.data = _dataProvider[i]
                }

                child = itemRenderer as DisplayObject;
                child.visible = isVisible;
            }
        }

        private function updateRenderersPosition():void
        {
            if (_renderers == null || _renderers.length == 0)
                return;

            if (_dataProvider == null)
                return;

            if (_contentWidth == 0 || _contentHeight == 0)
                return;

            var n:int = _dataProvider.length;
            var rowIndex:int = 0;
            var colIndex:int = 0;
            _colMax = (_contentWidth + horizontalGap) / (_itemWidth + horizontalGap);
            for (var i:int = 0; i < n; i++)
            {
                if (colIndex >= _colMax)
                {
                    rowIndex += 1;
                    colIndex = 0;
                }

                var child:DisplayObject = _renderers[i] as DisplayObject;
                if (child && child.visible == false)
                    continue;

                if (child)
                {
                    child.x = colIndex * (_itemWidth + horizontalGap);
                    child.y = rowIndex * (_itemHeight + verticalGap);
                }
                else
                {
                    trace("[ERROR] [View] ItemRenderer must be inherited from DisplayObject");
                }
                colIndex++;
            }
            _rowMax = rowIndex + 1;

            _width = _colMax * (_itemWidth + horizontalGap) - horizontalGap;
            _height = _rowMax * (_itemHeight + verticalGap) - verticalGap;
        }
    }
}

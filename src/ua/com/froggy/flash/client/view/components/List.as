/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.view.components
{
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.globalization.NumberParseResult;

    import ua.com.froggy.flash.client.events.ShopEvent;

    import ua.com.froggy.flash.client.model.vo.ProductVO;

    public class List extends Sprite
    {
        public static const ERROR_DISPLAY_OBJECT:String = "[ERROR] [View] ItemRenderer must be inherited from DisplayObject";

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

        private var _columnCount:int;
        private var _rowCount:int;
        private var _width:int;
        private var _height:int;

        private var _layout:String;

        public function List(itemRendererClass:Class,
            contentWidth:int, contentHeight:int,
            itemWidth:int, itemHeight:int, layout:String = "tile")
        {
            super();
            _renderers = new Vector.<IItemRenderer>();
            _itemRendererClass = itemRendererClass;
            _layout = layout;

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

            switch (_layout)
            {
                case LayoutType.TILE_LAYOUT:
                    tileLayout();
                    break;
                case LayoutType.HORIZONTAL_LAYOUT:
                    horizontalLayout();
                    break;
                case LayoutType.VERTICAL_LAYOUT:
                    verticalLayout();
                    break;
            }

            _width = _columnCount * (_itemWidth + horizontalGap) - horizontalGap;
            _height = _rowCount * (_itemHeight + verticalGap) - verticalGap;
        }

        public function horizontalLayout():void
        {
            var n:int = _dataProvider.length;
            var index:int = 0;
            for (var i:int = 0; i < n; i++)
            {
                var child:DisplayObject = _renderers[i] as DisplayObject;
                if (child == null)
                    continue;

                if (child.visible == false)
                    continue;

                child.x = index * (_itemWidth + horizontalGap);
                child.y = 0;
                index++;
            }

            _columnCount = index;
            _rowCount = 1;
        }

        public function verticalLayout():void
        {
            var n:int = _dataProvider.length;
            var index:int = 0;
            for (var i:int = 0; i < n; i++)
            {
                var child:DisplayObject = _renderers[i] as DisplayObject;
                if (child == null)
                    continue;

                if (child.visible == false)
                    continue;

                child.x = 0;
                child.y = index * (_itemHeight + verticalGap);
                index++;
            }

            _columnCount = index;
            _rowCount = 1;
        }

        public function tileLayout()
        {
            var rowIndex:int = 0;
            var colIndex:int = 0;
            var n:int = _dataProvider.length;
            _columnCount = (_contentWidth + horizontalGap) / (_itemWidth + horizontalGap);
            for (var i:int = 0; i < n; i++)
            {
                if (colIndex >= _columnCount)
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
                    trace(ERROR_DISPLAY_OBJECT);
                }
                colIndex++;
            }

            _rowCount = rowIndex + 1;
        }
    }
}

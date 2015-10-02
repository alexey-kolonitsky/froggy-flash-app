/**
 * Created by Aliaksei_Kalanitski on 10/2/2015.
 */
package org.kolonitsky.alexey.gui.core
{
    import flash.display.DisplayObject;

    import ua.com.froggy.flash.client.view.components.LayoutType;

    public class GUIGroup extends GUIElement
    {
        public static const ERROR_DISPLAY_OBJECT:String = "[ERROR] [View] ItemRenderer must be inherited from DisplayObject";

        private var _columnCount:int;
        private var _rowCount:int;

        private var horizontalGap:int = 2;
        private var verticalGap:int = 2;

        private var _layout:String;

        private var _fixedWidth:int = 0;
        private var _fixedHeight:int = 0;
        private var _elements:Vector.<DisplayObject>;


        //-----------------------------
        // Constructor
        //-----------------------------

        public function GUIGroup(layout:String, contentWidth:int = -1, fixedWidth:int = -1, fixedHeight:int = -1)
        {
            _layout = layout;
            _contentWidth = contentWidth;
            _fixedWidth = fixedWidth;
            _fixedHeight = fixedHeight;
            _elements = new Vector.<DisplayObject>();
        }

        //-----------------------------
        // contentWidth
        //-----------------------------

        private var _contentWidth:int = 0;

        public function get contentWidth():int
        {
            return _contentWidth;
        }

        public function set contentWidth(contentWidth:int):void
        {
            _contentWidth = contentWidth;
            updatePosition();
        }

        //-----------------------------
        // width
        //-----------------------------

        private var _width:int;

        override public function get width():Number
        {
            return _width;
        }

        //-----------------------------
        // height
        //-----------------------------

        private var _height:int;

        override public function get height():Number
        {
            return _height;
        }

        public function addElement(element:DisplayObject)
        {
            _elements.push(element);
            addChild(element);
            updatePosition();
        }

        public function removeElement(element:DisplayObject)
        {
            var index:int = _elements.indexOf(element);
            if (index == -1)
                return;

            _elements.splice(index, 1);
            removeChild(element);
            updatePosition();
        }

        protected function updatePosition():void
        {
            if (_elements == null || _elements.length == 0 || state == GUIState.CREATED)
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

            _width = _columnCount * (_fixedWidth + horizontalGap) - horizontalGap;
            _height = _rowCount * (_fixedHeight + verticalGap) - verticalGap;
        }

        public function horizontalLayout():void
        {
            var n:int = _elements.length;
            var index:int = 0;
            for (var i:int = 0; i < n; i++)
            {
                var child:DisplayObject = _elements[i] as DisplayObject;
                if (child == null)
                    continue;

                if (child.visible == false)
                    continue;

                child.x = index * (_fixedWidth + horizontalGap);
                child.y = 0;
                index++;
            }

            _columnCount = index;
            _rowCount = 1;
        }

        public function verticalLayout():void
        {
            var n:int = _elements.length;
            var index:int = 0;
            for (var i:int = 0; i < n; i++)
            {
                var child:DisplayObject = _elements[i] as DisplayObject;
                if (child == null)
                    continue;

                if (child.visible == false)
                    continue;

                child.x = 0;
                child.y = index * (_fixedHeight + verticalGap);
                index++;
            }

            _columnCount = 1;
            _rowCount = index;
        }

        public function tileLayout():void
        {

            if (_contentWidth == 0)
            {
                trace("ERROR: To use GUIGroup tile layout define _contentWidth property");
                return;
            }

            var rowIndex:int = 0;
            var colIndex:int = 0;
            var n:int = _elements.length;
            _columnCount = (_contentWidth + horizontalGap) / (_fixedWidth + horizontalGap);
            for (var i:int = 0; i < n; i++)
            {
                if (colIndex >= _columnCount)
                {
                    rowIndex += 1;
                    colIndex = 0;
                }

                var child:DisplayObject = _elements[i] as DisplayObject;
                if (child && child.visible == false)
                    continue;

                if (child)
                {
                    child.x = colIndex * (_fixedWidth + horizontalGap);
                    child.y = rowIndex * (_fixedHeight + verticalGap);
//                    var index:int = colIndex + rowIndex * _columnCount;
//                    TweenLite.from(child, 0.7, {alpha:0.0, y:child.y+60, delay: 0.1 * index})
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

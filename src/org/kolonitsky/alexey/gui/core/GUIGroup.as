/**
 * Created by Aliaksei_Kalanitski on 10/2/2015.
 */
package org.kolonitsky.alexey.gui.core
{
    import flash.display.DisplayObject;

    import org.kolonitsky.alexey.gui.events.GUIEvent;

    import ua.com.froggy.flash.client.view.components.LayoutType;

    [Event(name="guiResize", type="org.kolonitsky.alexey.gui.events.GUIEvent")]

    /**
     * GUIGroup is base class for all layout groups.
     */
    public class GUIGroup extends GUIElement
    {
        public static const ERROR_DISPLAY_OBJECT:String = "[ERROR] GUIGroup element must be inherited from DisplayObject";

        private var _columnCount:int;
        private var _rowCount:int;

        private var _horizontalGap:int = 2;
        private var _verticalGap:int = 2;
        private var _paddingTop:int = 0;
        private var _paddingRight:int = 0;
        private var _paddingBottom:int = 0;
        private var _paddingLeft:int = 0;
        private var _layout:String = LayoutType.FREE;

        private var _itemFixedWidth:int = 0;
        private var _itemFixedHeight:int = 0;
        private var _elements:Vector.<DisplayObject>;


        //-----------------------------
        // Constructor
        //-----------------------------

        public function GUIGroup(fixedWidth:int = -1, fixedHeight:int = -1)
        {
            _fixedWidth = fixedWidth;
            _fixedHeight = fixedHeight;
            _elements = new Vector.<DisplayObject>();
        }

        //-----------------------------
        // fixedWidth
        //-----------------------------

        private var _fixedWidth:int = 0;

        public function get fixedWidth():int
        {
            return _fixedWidth;
        }

        public function set fixedWidth(value:int):void
        {
            _fixedWidth = value;
            updatePosition();
        }

        //-----------------------------
        // fixedHeight
        //-----------------------------

        private var _fixedHeight:int = 0;

        public function get fixedHeight():int
        {
            return _fixedHeight;
        }

        public function set fixedHeight(value:int):void
        {
            _fixedHeight = value;
            updatePosition();
        }

        //-----------------------------
        // measuredWidth
        //-----------------------------

        private var _measuredWidth:int = 0;

        override public function get width():Number
        {
            if (_measuredWidth == 0 || isNaN(_measuredWidth))
                return _fixedWidth;

            return _measuredWidth;
        }

        //-----------------------------
        // measuredHeight
        //-----------------------------

        private var _measuredHeight:int;

        override public function get height():Number
        {
            if (_measuredHeight == 0 || isNaN(_measuredHeight))
                return _fixedHeight;

            return _measuredHeight;
        }

        //-------------------------------------------------------------------
        // GUIElement Implementation
        //-------------------------------------------------------------------

        override public function initialize():void
        {
            super.initialize();
            updatePosition();
        }

        //-------------------------------------------------------------------
        // Layout logic
        //-------------------------------------------------------------------

        public function updateLayout(layout:String, horizontalGap:int = 2, verticalGap:int = 2, itemFixedWidth:int = -1, itemFixedHeight:int = -1):void
        {
            _layout = layout;
            _horizontalGap = horizontalGap;
            _verticalGap = verticalGap;
            _itemFixedWidth = itemFixedWidth;
            _itemFixedHeight = itemFixedHeight;

            if (state != GUIState.CREATED)
                updatePosition();
        }

        public function updatePadding(top:int, right:int, bottom:int, left:int):void
        {
            _paddingTop = top;
            _paddingRight = right;
            _paddingBottom = bottom;
            _paddingLeft = left;

            if (state != GUIState.CREATED)
                updatePosition();
        }

        public function addElement(element:DisplayObject):void
        {
            element.addEventListener(GUIEvent.RESIZE, element_resizeHandler);
            _elements.push(element);
            addChild(element);

            if (state != GUIState.CREATED)
                updatePosition();
        }

        public function removeElement(element:DisplayObject):void
        {
            var index:int = _elements.indexOf(element);
            if (index == -1)
                return;

            _elements.splice(index, 1);
            removeChild(element);

            if (state != GUIState.CREATED)
                updatePosition();
        }

        protected function updatePosition():void
        {
            if (_elements == null || _elements.length == 0)
                return;

            if (state == GUIState.CREATED)
                return;

            switch (_layout)
            {
                case LayoutType.TILE:
                    tileLayout();
                    break;
                case LayoutType.HORIZONTAL:
                    horizontalLayout();
                    break;
                case LayoutType.VERTICAL:
                    verticalLayout();
                    break;
                default:
                    break;
            }
        }

        private function horizontalLayout():void
        {
            var horizontalPadding:int = _paddingLeft + _paddingRight;
            var verticalPadding:int = _paddingTop + _paddingBottom;
            var measuredWidth:int = 0;
            var measuredHeight:int = 0;
            var xPosition:int = _paddingLeft;
            var yPosition:int = _paddingTop;
            var index:int = 0;

            for (var i:int = 0; i < _elements.length; i++)
            {
                var child:DisplayObject = _elements[i] as DisplayObject;
                if (child == null)
                    continue;

                if (child.visible == false)
                    continue;

                child.x = xPosition;
                child.y = yPosition;

                index++;
                if (_itemFixedWidth == -1)
                    xPosition += child.width + _horizontalGap;
                else
                    xPosition = _paddingLeft + index * (_itemFixedWidth + _horizontalGap);

                if (measuredHeight < child.height + verticalPadding)
                    measuredHeight = child.height + verticalPadding;
            }

            measuredWidth = xPosition - _horizontalGap + _paddingRight;
            if (measuredWidth != _measuredWidth || measuredHeight != _measuredHeight)
            {
                _measuredWidth = measuredWidth;
                _measuredHeight = measuredHeight;
                dispatchEvent(new GUIEvent(GUIEvent.RESIZE));
            }
        }

        private function verticalLayout():void
        {
            var horizontalPadding:int = _paddingLeft + _paddingRight;
            var measuredWidth:int = 0;
            var measuredHeight:int = 0;
            var xPosition:int = _paddingLeft;
            var yPosition:int = _paddingTop;
            var index:int = 0;

            for (var i:int = 0; i < _elements.length; i++)
            {
                var child:DisplayObject = _elements[i] as DisplayObject;
                if (child == null)
                    continue;

                if (child.visible == false)
                    continue;

                child.x = xPosition;
                child.y = yPosition;

                index++;
                if (_itemFixedHeight == -1)
                    yPosition += child.height + _verticalGap;
                else
                    yPosition = _paddingTop + index * (_itemFixedHeight + _verticalGap);

                if (measuredWidth < child.width + horizontalPadding)
                    measuredWidth = child.width + horizontalPadding;
            }

            measuredHeight = yPosition - _verticalGap + _paddingBottom;
            if (measuredWidth != _measuredWidth || measuredHeight != _measuredHeight)
            {
                _measuredWidth = measuredWidth;
                _measuredHeight = measuredHeight;
                dispatchEvent(new GUIEvent(GUIEvent.RESIZE));
            }
        }

        private function tileLayout():void
        {

            if (_fixedWidth == 0)
            {
                trace("ERROR: To use GUIGroup tile layout define _fixedWidth property");
                return;
            }

            var rowIndex:int = 0;
            var colIndex:int = 0;
            var n:int = _elements.length;
            _columnCount = (_fixedWidth + _horizontalGap) / (_itemFixedWidth + _horizontalGap);
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
                    child.x = colIndex * (_itemFixedWidth + _horizontalGap);
                    child.y = rowIndex * (_itemFixedHeight + _verticalGap);
                }
                else
                {
                    trace(ERROR_DISPLAY_OBJECT);
                }
                colIndex++;
            }

            _rowCount = rowIndex + 1;
            var measuredWidth:int = _columnCount * (_itemFixedWidth + _horizontalGap) - _horizontalGap;
            var measuredHeight:int = _rowCount * (_itemFixedHeight + _verticalGap) - _verticalGap;
            if (measuredWidth != _measuredWidth || measuredHeight != _measuredHeight)
            {
                _measuredWidth = measuredWidth;
                _measuredHeight = measuredHeight;
                dispatchEvent(new GUIEvent(GUIEvent.RESIZE));
            }
        }


        //-------------------------------------------------------------------
        // Event Handlers
        //-------------------------------------------------------------------

        private function element_resizeHandler(event:GUIEvent):void
        {
            updatePosition();
        }
    }
}

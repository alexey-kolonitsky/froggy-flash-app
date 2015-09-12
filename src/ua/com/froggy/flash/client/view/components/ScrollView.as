/**
 * Created by Alexey on 10.09.2015.
 */
package ua.com.froggy.flash.client.view.components
{
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    public class ScrollView extends Sprite
    {
        private var MOUSE_MOVE_DELTA:int = 8; /* pixels */
        private var MOUSE_WHEEL_FACTOR:Number = 5;

        public var horizontalScroll:Boolean = false;
        public var verticalScroll:Boolean = false;

        public var horizontalScrollPosition:int;
        public var verticalScrollPosition:int;

        private var _scrollWidth:int;
        private var _scrollHeight:int;
        private var _content:DisplayObject;

        protected var debugMode:Boolean = false;

        public function ScrollView(content:DisplayObject, scrollWidth:int, scrollHeight:int)
        {
            if (scrollWidth == 0)
                return;
            if (scrollHeight == 0)
                return;
            if (content == null)
                return;

            _content = content;
            setScrollSize(scrollWidth, scrollHeight);

            addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
            addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
        }


        //----------------------------------------------------------------------
        // Drag content logic
        //----------------------------------------------------------------------


        public function setScrollSize(scrollWidth:int, scrollHeight:int):void
        {
            _scrollWidth = scrollWidth;
            _scrollHeight = scrollHeight;
            if (!debugMode)
                scrollRect = new Rectangle(0, 0, _scrollWidth, _scrollHeight);
            drawBackground();
        }

        public function moveContentBy(dx:Number, dy:Number):void
        {
            moveContentTo(_content.x + dx, _content.y + dy);
        }

        public function moveContentTo(x:Number, y:Number):void
        {
            if (horizontalScroll)
                _content.x = x + horizontalConstraint(x);

            if (verticalScroll)
                _content.y = y + verticalConstrain(y);
        }

        private function drawBackground():void
        {
            var alpha:Number = 0.0;
            if (debugMode)
                alpha = 0.5;

            graphics.clear();
            graphics.lineStyle(2, 0xFF0000, alpha);
            graphics.beginFill(0xFF0000, alpha);
            graphics.drawRect(0, 0, _scrollWidth, _scrollHeight);
            graphics.lineStyle();
        }

        private function horizontalConstraint(x:Number):Number
        {
            var left:Number = x;
            var right:Number = x + _content.width;

            if (_content.width < _scrollWidth)
                return -left;

            if (left > 0)
                return -left;

            if (right < _scrollWidth)
                return _scrollWidth - right;

            return 0;
        }

        private function verticalConstrain(y:Number):Number
        {
            var top:Number = y;
            var bottom:Number = y + _content.height;

            if (_content.height < _scrollHeight)
                return -top;

            if (top > 0)
                return -top;

            if (bottom < _scrollHeight)
                return _scrollHeight - bottom;

            return 0;
        }




        //----------------------------------------------------------------------
        // Drag content logic
        //----------------------------------------------------------------------

        private var _mouseDownX:Number;
        private var _mouseDownY:Number;
        private var _dragStartX:Number;
        private var _dragStartY:Number;
        private var _dragStart:Boolean;

        private function mouseDownHandler(event:MouseEvent):void
        {
            _dragStart = false;
            _mouseDownX = event.stageX;
            _mouseDownY = event.stageY;
            _dragStartX = _content.x;
            _dragStartY = _content.y;
            stage.addEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
            stage.addEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler);
        }

        private function stage_mouseMoveHandler(event:MouseEvent):void
        {
            var dx:Number = event.stageX - _mouseDownX;
            var dy:Number = event.stageY - _mouseDownY;
            if (!_dragStart && (Math.abs(dx) > MOUSE_MOVE_DELTA || Math.abs(dy) > MOUSE_MOVE_DELTA))
                _dragStart = true;

            if (_dragStart)
                moveContentTo(_dragStartX + dx, _dragStartY + dy);
        }

        private function stage_mouseUpHandler(event:MouseEvent):void
        {
            var dx:Number = event.stageX - _mouseDownX;
            var dy:Number = event.stageY - _mouseDownY;

            if (_dragStart)
                moveContentTo(_dragStartX + dx, _dragStartY + dy);

            stage.removeEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
            stage.removeEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler);
        }

        private function mouseWheelHandler(event:MouseEvent):void
        {
            moveContentBy(event.delta * MOUSE_WHEEL_FACTOR, event.delta * MOUSE_WHEEL_FACTOR);
        }
    }
}

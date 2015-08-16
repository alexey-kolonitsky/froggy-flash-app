/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.view.components
{
    import flash.display.Sprite;

    import ua.com.froggy.flash.client.model.ProductVO;

    public class ScrollList extends Sprite
    {
        private var dataProvider:Array;
        private var itemRendererClass:Class;
        private var renderers:Vector.<IItemRenderer>;

        private var contentX:int = 100;
        private var contentY:int = 100;

        public function ScrollList(dataPrivider:Array, itemRendererClass:Class, contentX, contentY)
        {
            super();
            renderers = new Vector.<IItemRenderer>();
            this.dataProvider = dataPrivider;
            this.itemRendererClass = itemRendererClass;
            this.contentX = contentX;
            this.contentY = contentY;
        }

        public function updateSize(contentX:int, contentY:int)
        {
            this.contentX = contentX;
            this.contentY = contentY;

            updateRenderersPosition();
        }

        private function createItemRenderes():void
        {
            if (itemRendererClass == null)
            {
                trace("[ERROR] [ScrollList] itemRendererClass not defined");
                return;
            }

            if (dataProvider == null || dataProvider.length == 0)
            {
                trace("[ERROR] [ScrollList] data is not defined");
                return;
            }

            var n:int = dataProvider.length;
            for (var i:int = 0; i < n; i++)
            {
                var itemRenderer:IItemRenderer = new itemRendererClass
            }
        }

        private function updateRenderersPosition():void
        {

        }
    }
}

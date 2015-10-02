/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.view.components
{
    import flash.display.DisplayObject;

    import org.kolonitsky.alexey.gui.core.GUIGroup;

    public class List extends GUIGroup
    {
        private var _itemRendererClass:Class;


        /**
         * Pool of ItemRenderers.
         */
        private var _renderers:Vector.<IItemRenderer>;


        //-----------------------------
        // Constructor
        //-----------------------------

        public function List(itemRendererClass:Class,
            contentWidth:int, itemWidth:int, itemHeight:int, layout:String = "tile")
        {
            super(layout, contentWidth, itemWidth, itemHeight);
            _renderers = new Vector.<IItemRenderer>();
            _itemRendererClass = itemRendererClass;
        }


        //-----------------------------
        // dataProvider
        //-----------------------------

        private var _dataProvider:Vector.<Object>;

        public function get dataProvider():Vector.<Object>
        {
            return _dataProvider;
        }

        public function set dataProvider(value:Vector.<Object>):void
        {
            _dataProvider = value;
            createItemRenderers();
        }


        override public function initialize():void
        {
            super.initialize();
            createItemRenderers();
        }

        //-----------------------------
        // Private
        //-----------------------------

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
                    addElement(child);
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
    }
}

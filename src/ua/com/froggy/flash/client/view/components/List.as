/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.view.components
{
    import flash.display.DisplayObject;

    import org.kolonitsky.alexey.gui.core.GUIGroup;
    import org.kolonitsky.alexey.gui.core.GUIState;

    /**
     *
     */
    public class List extends GUIGroup
    {
        /**
         * Item renderer class definition. Each item of list will be
         * represented by this class.
         */
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
            super(contentWidth, -1);
            updateLayout(layout, 2, 2, itemWidth, itemHeight);

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

            if (state != GUIState.CREATED)
                updatePosition();
        }

        //-------------------------------------------------------------------
        // GUIElement override
        //-------------------------------------------------------------------

        /**
         * Create item renderers and invoke GUIGroup.initialize() to update
         * their position.
         */
        override public function initialize():void
        {
            createItemRenderers();
            super.initialize();
        }

        //-------------------------------------------------------------------
        //
        // Private
        //
        //-------------------------------------------------------------------

        /**
         * Create item renderer if count of instance are not enough to render
         * all data from dataProvider. If new renderers are not needed all
         * renderers from pool updated.
         */
        private function createItemRenderers():void
        {
            if (_itemRendererClass == null)
            {
                trace("[ERROR] List.createItemRenderer() itemRendererClass is NOT defined");
                return;
            }

            if (_dataProvider == null || _dataProvider.length == 0)
            {
                trace("[ERROR] List.createItemRenderer() data is NOT defined");
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

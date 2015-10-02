/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.view.froggy_components
{
    import flash.events.Event;

    import ua.com.froggy.flash.client.events.ProductEvent;

    import ua.com.froggy.flash.client.view.components.*;
    import ua.com.froggy.flash.client.view.controls.Label;
    import ua.com.froggy.flash.client.view.renderers.ProductItemRenderer;

    public class CatalogList extends ScrollView
    {
        public var _label:Label;

        private var _productsList:List;

        public function get dataProvider():Vector.<Object>
        {
            return _productsList.dataProvider;
        }

        public function set dataProvider(value:Vector.<Object>)
        {
            _productsList.dataProvider = value;
        }

        public function CatalogList()
        {
            _productsList = new List(ProductItemRenderer, 0, 0, ProductItemRenderer.DEFAULT_WIDTH, ProductItemRenderer.DEFAULT_HEIGHT);

            super(_productsList, 1024, 760);
            horizontalScroll = false;
            verticalScroll = true;
            debugMode = false;

            addChild(_productsList);
            addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
        }

        public function addedToStageHandler(event:Event)
        {
            var stageWidth = stage.stageWidth;
            var stageHeight = stage.stageHeight - y;

            setScrollSize(stageWidth, stageHeight);
            _productsList.updateSize(stageWidth, stageHeight);

            stage.addEventListener(Event.RESIZE, addedToStageHandler);
        }

    }
}

/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.view
{
    import flash.display.Bitmap;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.text.TextField;

    import ua.com.froggy.flash.client.Images;
    import ua.com.froggy.flash.client.Styles;
    import ua.com.froggy.flash.client.events.CatalogEvent;
    import ua.com.froggy.flash.client.events.ProductEvent;
    import ua.com.froggy.flash.client.events.SearchEvent;
    import ua.com.froggy.flash.client.model.CatalogProxy;
    import ua.com.froggy.flash.client.model.ShoppingCartProxy;
    import ua.com.froggy.flash.client.service.FroggyService;
    import ua.com.froggy.flash.client.view.controls.Button;
    import ua.com.froggy.flash.client.view.controls.Label;
    import ua.com.froggy.flash.client.view.controls.TextInput;
    import ua.com.froggy.flash.client.view.core.GUIElement;
    import ua.com.froggy.flash.client.view.froggy_components.CatalogList;
    import ua.com.froggy.flash.client.view.froggy_components.SearchField;

    [Event(name="buyProduct",type="ua.com.froggy.flash.client.events.ProductEvent")]

    [ManagedEvents("search,clear,buyProduct")]

    /**
     *
     */
    public class OrderWindow extends GUIElement
    {
        private var _titleLabel:Label;
        private var _closeButton:Button;

        private var _nameTextInput:TextInput;
        private var _emailTextInput:TextInput;
        private var _addressTextInput:TextInput;
        private var _phoneTextInput:TextInput;
        private var _detailsTextArea:TextInput;

        private var _catalogTileList:CatalogList;

        [Inject(id="froggyService")]
        public var froggyService:FroggyService;

        [Inject]
        public var catalogProxy:ShoppingCartProxy;

        //-----------------------------
        // Constructor
        //-----------------------------

        public function OrderWindow()
        {
            super();
            createChildren();
        }

        [Init]
        override public function initialize():void
        {
            updatePosition();
            stage.addEventListener(Event.RESIZE, stage_resizeHandler);
        }


        //-----------------------------
        // products
        //-----------------------------

        public function get products():Vector.<Object>
        {
            return _catalogTileList.dataProvider;
        }

        public function set products(value:Vector.<Object>):void
        {
            _catalogTileList.dataProvider = value;
        }

        [Init]
        public function init():void
        {
            froggyService.load();
        }


        //-------------------------------------------------------------------
        //
        // Private
        //
        //-------------------------------------------------------------------

        private function createChildren():void
        {

            _catalogTileList = new CatalogList();
            _catalogTileList.x = 0;
            _catalogTileList.y = 220;
            addChild(_catalogTileList);
        }

        private function updatePosition()
        {
            x = (stage.stageWidth - width) / 2;
            y = (stage.stageHeight - height) / 2;
        }



        //-------------------------------------------------------------------
        // Event Handler
        //-------------------------------------------------------------------

        private function stage_resizeHandler(event:Event):void
        {
            updatePosition()
        }
    }
}

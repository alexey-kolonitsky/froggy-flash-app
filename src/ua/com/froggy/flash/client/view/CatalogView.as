/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.view
{
    import flash.display.Bitmap;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.text.TextField;

    import org.spicefactory.lib.command.builder.Commands;

    import ua.com.froggy.flash.client.Images;
    import ua.com.froggy.flash.client.Styles;
    import ua.com.froggy.flash.client.controller.LoadCatalogCommand;
    import ua.com.froggy.flash.client.events.CatalogChangedEvent;
    import ua.com.froggy.flash.client.events.CatalogChangedEvent;
    import ua.com.froggy.flash.client.events.LoadCatalogEvent;
    import ua.com.froggy.flash.client.events.ProductEvent;
    import ua.com.froggy.flash.client.events.SearchEvent;
    import ua.com.froggy.flash.client.model.CatalogProxy;
    import org.kolonitsky.alexey.service.FroggyService;
    import org.kolonitsky.alexey.gui.controls.Label;
    import org.kolonitsky.alexey.gui.core.GUIElement;
    import org.kolonitsky.alexey.gui.core.ViewComponent;
    import ua.com.froggy.flash.client.view.froggy_components.CatalogList;
    import ua.com.froggy.flash.client.view.froggy_components.SearchField;
    import ua.com.froggy.flash.client.view.froggy_components.ShoppingCartLine;

    [Event(name="buyProduct",type="ua.com.froggy.flash.client.events.ProductEvent")]

    [Event(name="search",type="ua.com.froggy.flash.client.events.SearchEvent")]

    [Event(name="clear",type="ua.com.froggy.flash.client.events.SearchEvent")]

    [Event(name="loadCatalog",type="ua.com.froggy.flash.client.events.LoadCatalogEvent")]

    [ManagedEvents("search,clear,buyProduct,loadCatalog")]

    /**
     *
     */
    public class CatalogView extends ViewComponent
    {
        private var _logoBitmap:Bitmap;

        private var _phoneLabel:Label;
        private var _emailTextField:Label;
        private var _addressTextField:Label;
        private var _searchField:SearchField;

        private var _catalogTileList:CatalogList;

        private var _miniCart:ShoppingCartLine;

        [Inject(id="froggyService")]
        public var froggyService:FroggyService;

        [Inject]
        public var catalogProxy:CatalogProxy;

        //-----------------------------
        // Constructor
        //-----------------------------

        public function CatalogView()
        {
            super();
            createChildren();
        }

        [Init]
        public function initialize():void
        {
            updatePosition();
            stage.addEventListener(Event.RESIZE, stage_resizeHandler);
            dispatchEvent(new LoadCatalogEvent());
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

        [MessageHandler]
        public function catalogLoadedHandler(event:CatalogChangedEvent):void
        {
            products = catalogProxy.products;
        }


        //-------------------------------------------------------------------
        //
        // Private
        //
        //-------------------------------------------------------------------

        private function createChildren():void
        {
            _miniCart = new ShoppingCartLine();
            addChild(_miniCart);

            _logoBitmap = new Images.FROGGY_LOGO();
            _logoBitmap.smoothing = true;
            _logoBitmap.scaleX = 0.8;
            _logoBitmap.scaleY = 0.8;
            addChild(_logoBitmap);

            _phoneLabel = new Label(256, 60, 500, 30, Styles.TITLE_FORMAT);
            _phoneLabel.text = "тел.: (063) 27-888-27";
            addChild(_phoneLabel);

            _emailTextField = new Label(256, 100, 500, 30, Styles.TITLE_FORMAT);
            _emailTextField.text = "email: devishna@gmail.com";
            addChild(_emailTextField);

            _addressTextField = new Label(256, 150, 500, 90, Styles.TITLE_FORMAT, true);
            _addressTextField.text = "вы можете купить эксклюзивные украшения в магазине Podval";
            addChild(_addressTextField);

            _searchField = new SearchField();
            _searchField.x = 700;
            _searchField.y = 150;
            addChild(_searchField);

            _catalogTileList = new CatalogList();
            _catalogTileList.x = 0;
            _catalogTileList.y = 220;
            addChild(_catalogTileList);
        }

        private function updatePosition():void
        {
            _searchField.x = stage.stageWidth - _searchField.DEFAULT_WIDTH - 8;
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

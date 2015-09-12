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
    import ua.com.froggy.flash.client.events.ShopEvent;
    import ua.com.froggy.flash.client.model.vo.ProductVO;
    import ua.com.froggy.flash.client.view.components.Label;
    import ua.com.froggy.flash.client.view.froggy_components.CatalogList;
    import ua.com.froggy.flash.client.view.froggy_components.SearchField;

    public class Catalog extends Sprite
    {
        private var _logoBitmap:Bitmap;

        private var _phoneLabel:Label;
        private var _emailTextField:TextField;
        private var _addressTextField:TextField;
        private var _searchField:SearchField;

        private var _catalogTileList:CatalogList;

        public function Catalog()
        {
            super();

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
            
            addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
            addEventListener(Event.RESIZE, addedToStageHandler);
        }

        private function addedToStageHandler(event:Event):void
        {
            _searchField.x = stage.stageWidth - _searchField.DEFAULT_WIDTH - 8;
        }

        public function get searchField():SearchField
        {
            return _searchField;
        }

        public function get products():Vector.<Object>
        {
            return _catalogTileList.dataProvider;
        }

        public function set products(value:Vector.<Object>):void
        {
            _catalogTileList.dataProvider = value;
        }
    }
}

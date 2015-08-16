/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.view
{
    import flash.display.Bitmap;
    import flash.display.Sprite;
    import flash.text.TextField;

    import ua.com.froggy.flash.client.Images;
    import ua.com.froggy.flash.client.Styles;
    import ua.com.froggy.flash.client.view.components.Label;
    import ua.com.froggy.flash.client.view.components.SearchField;

    public class Catalog extends Sprite
    {
        private var _logoBitmap:Bitmap;

        private var _phoneLabel:Label;
        private var _emailTextField:TextField;
        private var _addressTextField:TextField;
        private var _searchField:SearchField;

        private var _catalogTileList;

        public function Catalog()
        {
            super();

            _logoBitmap = new Images.FROGGY_LOGO();
            addChild(_logoBitmap);

            _phoneLabel = new Label(256, 60, 500, 30, Styles.HEADER_TEXT);
            _phoneLabel.text = "тел.: (063) 27-888-27";
            addChild(_phoneLabel);

            _emailTextField = new TextField();
            _emailTextField.defaultTextFormat = Styles.HEADER_TEXT;
            _emailTextField.text = "email: devishna@gmail.com";
            _emailTextField.x = 256;
            _emailTextField.y = 100;
            _emailTextField.width = 500;
            _emailTextField.height = 30;
            addChild(_emailTextField);

            _addressTextField = new TextField();
            _addressTextField.defaultTextFormat = Styles.HEADER_TEXT;
            _addressTextField.multiline = true;
            _addressTextField.wordWrap = true;
            _addressTextField.text = "вы можете купить эксклюзивные украшения в магазине Podval";
            _addressTextField.x = 256;
            _addressTextField.y = 150;
            _addressTextField.width = 500;
            _addressTextField.height = 90;
            addChild(_addressTextField);

            _searchField = new SearchField();
            _searchField.x = 700;
            _searchField.y = 60;
            addChild(_searchField);
        }
    }
}

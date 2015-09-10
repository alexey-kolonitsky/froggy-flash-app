/**
 * Created by Alexey on 16.08.2015.
 */
package ua.com.froggy.flash.client.view.froggy_components
{
    import ua.com.froggy.flash.client.view.components.*;
    import flash.display.Bitmap;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.FocusEvent;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import flash.text.TextFieldType;

    import ua.com.froggy.flash.client.Images;

    import ua.com.froggy.flash.client.Styles;

    public class SearchField extends Sprite
    {
        private var _inputTextField:TextField;
        private var _promptTextField:Label;

        private var _searchIconBitmap:Bitmap;

        public function SearchField()
        {
            _searchIconBitmap = new Images.ICON_SEARCH;
            _searchIconBitmap.x = 4;
            _searchIconBitmap.y = 4;
            addChild(_searchIconBitmap);

            _promptTextField = new Label(24, 0, 220, 30, Styles.HINT_TEXT);
            addChild(_promptTextField);

            _inputTextField = new TextField();
            _inputTextField.type = TextFieldType.INPUT;
            _inputTextField.defaultTextFormat = Styles.BASE_TEXT_FORMAT;
            _inputTextField.x = 32;
            _inputTextField.y = 4;
            _inputTextField.width = 220;
            _inputTextField.height = 24;
            _inputTextField.addEventListener(MouseEvent.MOUSE_DOWN, _inputTextField_mouseDownHandler);
            addChild(_inputTextField);

            graphics.beginFill(0xFFFFFF);
            graphics.lineStyle(1, 0xEEEEEE, 1.0, true);
            graphics.drawRoundRect(0, 0, 256, 32, 16, 16);
            graphics.lineStyle();
            graphics.endFill();
        }

        private function _inputTextField_mouseDownHandler(event : MouseEvent) : void
        {
            _promptTextField.visible = false;
        }
    }
}

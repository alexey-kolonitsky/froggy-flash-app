/**
 * Created by Alexey on 16.08.2015.
 */
package ua.com.froggy.flash.client
{
    import flash.text.TextField;
    import flash.text.TextFormat;

    public class Styles
    {
        public static const BASE_FONT_NAME:String = "Arial";

        // Size
        public static const TITLE_FONT_SIZE:int = 24;
        public static const INPUT_FONT_SIZE:int = 24;
        public static const BASE_FONT_SIZE:int = 12;

        // Color
        public static const HINT_TEXT_COLOR:uint = 0xEEEEEE;
        public static const BASE_TEXT_COLOR:uint = 0x000000;
        public static const TITLE_TEXT_COLOR:uint = 0x5FCA38;
        public static const BUTTON_TEXT_COLOR:uint = 0xFFFFFF;
        public static const PRODUCT_TITLE_TEXT_COLOR:uint = 0x5FCA38;


        // Format
        public static const PRODUCT_DESCTIPTION_FORMAT:TextFormat = new TextFormat(BASE_FONT_NAME, BASE_FONT_SIZE, BASE_TEXT_COLOR);
        public static const BUTTON_TEXT:TextFormat = new TextFormat(BASE_FONT_NAME, BASE_FONT_SIZE, BUTTON_TEXT_COLOR);
        public static const PRODUCT_TITLE_FORMAT:TextFormat = new TextFormat(BASE_FONT_NAME, TITLE_FONT_SIZE, PRODUCT_TITLE_TEXT_COLOR);
        public static const TITLE_FORMAT:TextFormat = new TextFormat(BASE_FONT_NAME, TITLE_FONT_SIZE, TITLE_TEXT_COLOR);
        public static const BASE_TEXT_FORMAT:TextFormat = new TextFormat(BASE_FONT_NAME, BASE_FONT_SIZE, BASE_TEXT_COLOR);
        public static const HINT_TEXT:TextFormat = new TextFormat(BASE_FONT_NAME, BASE_FONT_SIZE, HINT_TEXT_COLOR);
    }
}

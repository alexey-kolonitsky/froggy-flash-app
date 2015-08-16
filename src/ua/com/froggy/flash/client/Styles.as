/**
 * Created by Alexey on 16.08.2015.
 */
package ua.com.froggy.flash.client
{
    import flash.text.TextField;
    import flash.text.TextFormat;

    public class Styles
    {
        public static const TITLE_TEXT_COLOR:uint = 0x5FCA38;

        public static const HINT_TEXT_COLOR:uint = 0xEEEEEE;
        public static const TITLE_FONT_SIZE:int = 24;

        //-----------------------------
        // Base Text
        //-----------------------------

        public static const BASE_TEXT_SIZE:int = 12;
        public static const BASE_TEXT_COLOR:uint = 0x000000;

        public static const HEADER_TEXT:TextFormat = new TextFormat("Arial", TITLE_FONT_SIZE, TITLE_TEXT_COLOR);
        public static const BASE_TEXT:TextFormat = new TextFormat("Arial", BASE_TEXT_SIZE, BASE_TEXT_COLOR);
        public static const HINT_TEXT:TextFormat = new TextFormat("Arial", BASE_TEXT_SIZE, HINT_TEXT_COLOR);
    }
}

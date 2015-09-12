/**
 * Created by Alexey on 16.08.2015.
 */
package ua.com.froggy.flash.client.view.components
{
    import flash.text.AntiAliasType;
    import flash.text.TextField;
    import flash.text.TextFormat;

    import ua.com.froggy.flash.client.Styles;

    public class Label extends TextField
    {
        public function Label(x:int, y:int, width:int, height:int, format:TextFormat, multiline:Boolean = false)
        {
            defaultTextFormat = format;
            antiAliasType = AntiAliasType.ADVANCED;
            embedFonts = true;
            this.x = x;
            this.y = y;
            this.width = width;
            this.height = height;
            this.selectable = false;

            this.multiline = multiline;
            this.wordWrap = multiline;
        }
    }
}

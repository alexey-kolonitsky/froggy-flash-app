/**
 * Created by Alexey on 16.08.2015.
 */
package org.kolonitsky.alexey.gui.controls
{
    import flash.text.AntiAliasType;
    import flash.text.TextField;
    import flash.text.TextFormat;

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

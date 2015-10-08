/**
 * Created by Aliaksei_Kalanitski on 10/7/2015.
 */
package org.kolonitsky.alexey.gui.forms
{
    import org.kolonitsky.alexey.gui.core.GUIGroup;

    public class Form extends GUIGroup
    {
        public function Form(layout:String, fixedWidth:int = -1, fixedHeight:int = -1, itemWidth:int = -1, itemHeight:int = -1)
        {
            super(layout, fixedWidth, fixedHeight, itemWidth, itemHeight);
        }
    }
}

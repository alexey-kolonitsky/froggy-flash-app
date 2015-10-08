/**
 * Created by Aliaksei_Kalanitski on 10/2/2015.
 */
package org.kolonitsky.alexey.gui.core
{
    public class GUIState
    {
        public static const UNDEFINED:uint = 0;

        /**
         * This state seted in constructor, after creating component
         */
        public static const CREATED:uint = 1;

        /**
         * This state added after initilizeng properties. i.e. after injecting
         * parsley view properties and adding on stage.
         */
        public static const INITIALIZED:uint = 2;


        /**
         * This state assigned when GUIElement removed from stage.
         */
        public static const REMOVED:uint = 3;

        public static const FOCUS_IN:uint = 3;

        public static const BUTTON_UP:uint = 3;
        public static const BUTTON_OVER:uint = 4;
        public static const BUTTON_DOWN:uint = 5;
    }
}

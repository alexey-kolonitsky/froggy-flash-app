/**
 * Created by Aliaksei_Kalanitski on 10/1/2015.
 */
package ua.com.froggy.flash.client.view.core
{
    import flash.display.Sprite;
    import flash.events.Event;

    public class GUIElement extends Sprite
    {
        public function GUIElement()
        {
            if (stage)
                initilize();
            else
                addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler)
        }

        public function initilize():void { }

        //-------------------------------------------------------------------
        //
        // Private
        //
        //-------------------------------------------------------------------

        private function addedToStageHandler(event:Event):void
        {
            initilize();
            removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
        }
    }
}

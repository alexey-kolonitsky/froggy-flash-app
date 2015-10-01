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
                dispatchEvent(new Event('configureView', true));
            else
                addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler)
        }

        [Init]
        public function initialize():void
        {
        }

        //-------------------------------------------------------------------
        //
        // Private
        //
        //-------------------------------------------------------------------

        private function addedToStageHandler(event:Event):void
        {
            dispatchEvent(new Event('configureView', true));
            removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
        }
    }
}

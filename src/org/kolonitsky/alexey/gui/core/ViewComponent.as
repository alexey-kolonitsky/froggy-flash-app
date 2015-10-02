/**
 * Created by Aliaksei_Kalanitski on 10/2/2015.
 */
package org.kolonitsky.alexey.gui.core
{
    import flash.display.Sprite;
    import flash.events.Event;

    /**
     * Base component for view parts of Parsley Framework.
     */
    public class ViewComponent extends Sprite
    {
        public function ViewComponent()
        {
            if (stage)
                dispatchEvent(new Event('configureView', true));
            else
                addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
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

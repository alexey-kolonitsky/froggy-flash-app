package ua.com.froggy.flash.client
{
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.text.TextField;

    import org.robotlegs.base.ContextEvent;

    import ua.com.froggy.flash.client.context.ShopContext;
    import ua.com.froggy.flash.client.events.ShopEvent;
    import ua.com.froggy.flash.client.view.Catalog;

    public class Main extends Sprite
    {
        private var context:ShopContext;

        public function Main()
        {
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;

            addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
        }

        private function addedToStageHandler(event : Event) : void
        {
            context = new ShopContext(this);
            context.startup();

            dispatchEvent( new ShopEvent(ShopEvent.STARTUP) );

            var catalog:Catalog = new Catalog();
            addChild(catalog);
        }
    }
}

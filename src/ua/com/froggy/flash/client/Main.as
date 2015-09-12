package ua.com.froggy.flash.client
{
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;

    import ua.com.froggy.flash.client.context.ShopContext;
    import ua.com.froggy.flash.client.view.Catalog;
    import ua.com.froggy.flash.client.view.EffectLayer;
    import ua.com.froggy.flash.client.view.froggy_components.ShoppingCartLine;

    public class Main extends Sprite
    {
        private var _context:ShopContext;

        private var _catalog:Catalog;
        private var _miniCart:ShoppingCartLine;
        private var _effectLayer:EffectLayer;

        public function Main()
        {
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;

            addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
        }

        private function addedToStageHandler(event : Event) : void
        {
            _context = new ShopContext(this);
            _context.startup();

            _catalog = new Catalog();
            addChild(_catalog);

            _miniCart = new ShoppingCartLine();
            _miniCart.x = stage.stageWidth - _miniCart.width - 8;
            _miniCart.y = 60;
            addChild(_miniCart);

            _effectLayer = new EffectLayer();
            addChild(_effectLayer);
        }
    }
}

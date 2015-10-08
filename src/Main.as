package {
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;

    import org.kolonitsky.alexey.gui.windows.WindowManager;
    import org.spicefactory.parsley.asconfig.ActionScriptConfig;
    import org.spicefactory.parsley.asconfig.ActionScriptContextBuilder;
    import org.spicefactory.parsley.command.MappedCommands;
    import org.spicefactory.parsley.context.ContextBuilder;
    import org.spicefactory.parsley.core.context.Context;
    import org.spicefactory.parsley.core.view.ViewSettings;

    import ua.com.froggy.flash.client.controller.BuyCommand;
    import ua.com.froggy.flash.client.controller.CancelProductCommand;
    import ua.com.froggy.flash.client.controller.LoadCatalogCommand;
    import ua.com.froggy.flash.client.controller.SearchCommand;
    import ua.com.froggy.flash.client.controller.SendOrderCommand;
    import ua.com.froggy.flash.client.events.CatalogChangedEvent;
    import ua.com.froggy.flash.client.events.LoadCatalogEvent;
    import ua.com.froggy.flash.client.events.OrderEvent;
    import ua.com.froggy.flash.client.events.ProductEvent;
    import ua.com.froggy.flash.client.events.SearchEvent;
    import ua.com.froggy.flash.client.view.CatalogView;
    import ua.com.froggy.flash.client.view.windows.OrderWindow;

    [SWF(width="1030", height="748")]
    public class Main extends Sprite
    {
        private var _context:Context;
        private var _catalog:CatalogView;
        private var _winodwLayer:Sprite;
        private var _windowManager:WindowManager;

        public function Main()
        {
            trace("[INFO] " + Config.APPLICATION_NAME + Config.VERSION);

            if (stage)
            {
                setupStage();
                configureParsley();
                createChildrend();
            }
            else
            {
                addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
            }
        }

        private function setupStage():void
        {
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
        }

        private function createChildrend():void
        {
            _catalog = new CatalogView();
            addChild(_catalog);

            _winodwLayer = new Sprite();
            addChild(_winodwLayer);

            _windowManager = new WindowManager(_winodwLayer);
            _windowManager.push(OrderWindow.TYPE, new OrderWindow());
        }

        private function configureParsley():void
        {
            _context = ContextBuilder.newSetup()
                .viewRoot(this)
                .description(Config.APPLICATION_NAME)
                .scope(Config.APPLICATION_NAME)
                .viewSettings()
                    .autoremoveComponents(false)
                .newBuilder()
                    .config(ActionScriptConfig.forClass(Config))
                    .build();

            MappedCommands.create(BuyCommand)
                .messageType(ProductEvent)
                .selector(ProductEvent.BUY)
                .register(_context);

            MappedCommands.create(CancelProductCommand)
                .messageType(ProductEvent)
                .selector(ProductEvent.CANCEL)
                .register(_context);

            MappedCommands.create(SearchCommand)
                .messageType(SearchEvent)
                .selector(SearchEvent.SEARCH)
                .register(_context);

            MappedCommands.create(SendOrderCommand)
                .messageType(OrderEvent)
                .selector(OrderEvent.CREATE)
                .register(_context);

            MappedCommands.create(LoadCatalogCommand)
                .messageType(LoadCatalogEvent)
                .register(_context);
        }


        private function addedToStageHandler(event : Event) : void
        {
            trace("[INFO] Main.addedToStageHandler()");

            setupStage();
            configureParsley();
            createChildrend();

            removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
        }
    }
}

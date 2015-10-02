package {
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;

    import org.spicefactory.lib.logging.Appender;
    import org.spicefactory.lib.logging.LogContext;
    import org.spicefactory.lib.logging.LogFactory;

    import org.spicefactory.lib.logging.LogLevel;
    import org.spicefactory.lib.logging.SpiceLogFactory;
    import org.spicefactory.lib.logging.flex.FlexLogFactory;

    import org.spicefactory.lib.logging.impl.DefaultLogFactory;

    import org.spicefactory.parsley.asconfig.ActionScriptContextBuilder;
    import org.spicefactory.parsley.command.MappedCommands;
    import org.spicefactory.parsley.core.context.Context;

    import ua.com.froggy.flash.client.controller.BuyCommand;
    import ua.com.froggy.flash.client.controller.CancelProductCommand;
    import ua.com.froggy.flash.client.controller.SearchCommand;
    import ua.com.froggy.flash.client.events.ProductEvent;
    import ua.com.froggy.flash.client.events.SearchEvent;
    import ua.com.froggy.flash.client.view.CatalogView;
    import ua.com.froggy.flash.client.view.froggy_components.ShoppingCartLine;

    public class Main extends Sprite
    {
        private var _context:Context;
        private var _catalog:CatalogView;
        private var _miniCart:ShoppingCartLine;

        public function Main()
        {
            trace("[INFO] Main Created");
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

            _miniCart = new ShoppingCartLine();
            addChild(_miniCart);
        }

        private function configureParsley():void
        {
           _context = ActionScriptContextBuilder.build(Config, this);

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

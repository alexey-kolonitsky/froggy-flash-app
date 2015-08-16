/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.controller
{
    import org.robotlegs.mvcs.Command;

    import ua.com.froggy.flash.client.service.IFroggyService;

    public class StartupCommand extends Command
    {
        [Inject]
        public var froggyService:IFroggyService;

        override public function execute():void
        {
            trace("[INFO] [StartupCommand]");

            // load new products catalog
            froggyService.load();

            // restore previous session
        }
    }
}

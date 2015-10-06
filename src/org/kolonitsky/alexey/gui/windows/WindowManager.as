/**
 * Created by Aliaksei_Kalanitski on 10/2/2015.
 */
package org.kolonitsky.alexey.gui.windows
{
    import flash.display.Sprite;

    import org.kolonitsky.alexey.gui.events.WindowEvent;

    public class WindowManager
    {
        private var _windowsPool:Object;
        private var _root:Sprite;


        //-----------------------------
        // Constructor
        //-----------------------------

        public function WindowManager(root:Sprite)
        {
            _windowsPool = {};
            _root = root;
            _root.stage.addEventListener(WindowEvent.OPEN_WINDOW, root_openWindowHandler);
            _root.stage.addEventListener(WindowEvent.CLOSE_WINDOW, root_closeWindowHandler);
        }

        public function push(windowType:String, window:WindowBase):void
        {
            if (windowType in _windowsPool)
            {
                trace("ERROR: WindowManager.push() Window with type " + window + " already registered");
                return;
            }

            _windowsPool[windowType] = window;
        }

        public function remove(windowType:String):void
        {
            if (windowType in _windowsPool)
            {
                _windowsPool[windowType] = null;
                delete _windowsPool[windowType];
            }
        }

        public function getWindowByType(windowType:String):WindowBase
        {
            if (windowType in _windowsPool)
            {
                var window:WindowBase = _windowsPool[windowType];
                return window;
            }
            return null;
        }

        public function openWindow(definition:WindowDefinition):void
        {
            if (definition == null)
            {
                trace("ERROR: WindowManager.openWindow(definition == null)");
                return;
            }

            var window:WindowBase = getWindowByType(definition.type);
            if (window == null)
            {
                trace("ERROR: WindowManager.openWindow(), window with id '" + definition.type + "' not found");
                return;
            }

            window.definition = definition;
            _root.addChild(window);
        }

        public function closeWindow(definition:WindowDefinition):void
        {
            if (definition == null)
            {
                trace("ERROR: WindowManager.closeWindow(definition == null)");
                return;
            }

            var window:WindowBase = getWindowByType(definition.type);
            if (window == null)
            {
                trace("ERROR: WindowManager.closeWindow(), window with id '" + definition.type + "' not found");
                return;
            }

            if (window.parent == _root)
            {
                window.definition = null;
                _root.removeChild(window);
            }
        }

        //-------------------------------------------------------------------
        // Event Handlers
        //-------------------------------------------------------------------

        private function root_openWindowHandler(event:WindowEvent):void
        {
            openWindow(event.definition);
        }

        private function root_closeWindowHandler(event:WindowEvent):void
        {
            closeWindow(event.definition);
        }
    }
}

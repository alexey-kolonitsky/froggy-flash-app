/**
 * Created by Aliaksei_Kalanitski on 10/5/2015.
 */
package org.kolonitsky.alexey.data
{
    import flash.events.EventDispatcher;
    import flash.events.NetStatusEvent;
    import flash.net.SharedObject;
    import flash.net.SharedObjectFlushStatus;
    import flash.system.Capabilities;

    import org.kolonitsky.alexey.date.W3Date;

    public class LocalStorage extends EventDispatcher
    {
        private var _so:SharedObject;
        private var _vid:String;
        public var applicationId:String;
        public var applicationVersion:String;


        public function LocalStorage()
        {
            var now:Date = new Date();
            _vid = W3Date.toW3CDateTime(now) + " " + Capabilities.language + ":" + Capabilities.os + ":" + Capabilities.playerType;
            _vid += (Math.random() * 1000).toFixed(0);
        }

        public function init():void
        {
            _so = SharedObject.getLocal(applicationId + "-" + applicationVersion);
            if ("vid" in _so.data)
            {
                _vid = _so.data["vid"] as String;
            }
            else
            {
                _so.data["vid"] = _vid;
                flush();
            }
        }

        public function save(key:String, value:Object):void
        {
            var fullkey:String = getKey(key);
            _so.data[fullkey] = value;
            flush();
        }

        public function read(key:String):Object
        {
            var fullkey:String = getKey(key);
            if (fullkey in _so.data)
                return _so.data[fullkey];
            return null;
        }

        public function readString(key:String):String
        {
            var result:* = read(key);
            if (result == null || result == undefined)
                return "";
            return String(result);
        }

        private function getKey(key:String):String
        {
            return applicationId + ":" + applicationVersion + ":" + _vid + ":" + key;
        }

        private function flush():void
        {
            var flushStatus:String = null;

            try
            {
                flushStatus = _so.flush();
            }
            catch (error:Error)
            {
                trace("ERROR: LocalStorage: Could not write SharedObject to disk" + error.message);
            }

            if (flushStatus != null)
            {
                switch (flushStatus)
                {
                    case SharedObjectFlushStatus.PENDING:
                        trace("INFO: LocalStorage: Requesting permission to save object");
                        _so.addEventListener(NetStatusEvent.NET_STATUS, onFlushStatus);
                        break;
                    case SharedObjectFlushStatus.FLUSHED:
                        trace("INFO: LocalStorage: Value flushed to disk.\n");
                        break;
                    default:
                        trace("INFO: LocalStorage: status =  " + flushStatus);
                        break;
                }
            }
        }

        private function onFlushStatus(event:NetStatusEvent):void
        {
            trace("INFO: LocalStorage: User closed permission dialog");
            switch (event.info.code)
            {
                case "SharedObject.Flush.Success":
                    trace("INFO: LocalStorage: User granted permission -- value saved");
                    break;
                case "SharedObject.Flush.Failed":
                    trace("INFO: LocalStorage: User denied permission -- value not saved");
                    break;
            }

            _so.removeEventListener(NetStatusEvent.NET_STATUS, onFlushStatus);
        }

    }
}

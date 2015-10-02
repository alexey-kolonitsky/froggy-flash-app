/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.events
{
    import flash.events.Event;

    public class SearchEvent extends Event
    {
        public static const SEARCH:String = "search";
        public static const CLEAR:String = "clear";

        public var mask:String;

        public function SearchEvent(type:String, mask:String = "")
        {
            super(type, true, false);
            this.mask = mask;
        }
    }
}

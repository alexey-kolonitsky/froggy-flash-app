/**
 * Created by Alexey on 12.09.2015.
 */
package ua.com.froggy.flash.client.signals
{
    import org.osflash.signals.Signal;

    public class SearchSignal extends Signal
    {
        public function SearchSignal()
        {
            super(String);
        }
    }
}

/**
 * Created by Alexey on 12.09.2015.
 */
package ua.com.froggy.flash.client.signals
{
    import org.osflash.signals.Signal;

    import ua.com.froggy.flash.client.model.vo.ProductVO;

    public class CancelProductSignal extends Signal
    {
        public function CancelProductSignal()
        {
            super(ProductVO);
        }
    }
}

/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.model
{
    import org.robotlegs.mvcs.Actor;

    import ua.com.froggy.flash.client.model.vo.OrderVO;
    import ua.com.froggy.flash.client.model.vo.ProductVO;
    import ua.com.froggy.flash.client.signals.ShoppingCartChangedSignal;

    public class ShoppingCartProxy extends Actor
    {
        [Inject]
        public var shoppingCartChangedSignal:ShoppingCartChangedSignal;

        private var _orders:Vector.<OrderVO>;

        public function get orders():Vector.<Object>
        {
            var source:Vector.<OrderVO> = _orders;

            var n:int = source ? source.length : 0;
            var result:Vector.<Object> = new Vector.<Object>(n, true);
            for (var i:int = 0; i < n; i++)
                result[i] = source[i];

            return result;
        }

        public function ShoppingCartProxy()
        {
            _orders = new Vector.<OrderVO>();
        }

        public function remove(product:ProductVO, count:int = 1):void
        {
            if (product == null || count == 0)
                return;

            var order:OrderVO = getOrderById(product.id);
            if (order == null)
            {
                trace("[WARNING] [ShoppingCartProxy] remove");
            }
            else
            {
                if (order.count >= count)
                    order.count -= count;
                else
                    order.count = 0;

                shoppingCartChangedSignal.dispatch();
            }
        }

        public function add(product:ProductVO, count:int = 1):void
        {
            if (product == null || count == 0)
                return;

            var order:OrderVO = getOrderById(product.id);
            if (order == null)
            {
                order = new OrderVO();
                order.count = count;
                order.productId = product.id;
                order.product = product;
                _orders.push(order);
            }
            else
            {
                order.count += count;
            }

            shoppingCartChangedSignal.dispatch();
        }

        public function getOrderById(productId:String):OrderVO
        {
            var n:int = _orders.length;
            for (var i:int = 0; i < n; i++)
                if (_orders[i].productId == productId)
                    return _orders[i];
            return null;
        }

    }
}

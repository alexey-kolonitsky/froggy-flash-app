/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.model
{
    import flash.events.EventDispatcher;

    import ua.com.froggy.flash.client.events.CartEvent;

    import ua.com.froggy.flash.client.model.vo.OrderVO;
    import ua.com.froggy.flash.client.model.vo.ProductVO;

    [Event(name="cartChanged", type="ua.com.froggy.flash.client.events.CartEvent")]

    public class ShoppingCartProxy extends EventDispatcher
    {

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

                dispatchEvent(new CartEvent(CartEvent.CHANGED));
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

            dispatchEvent(new CartEvent(CartEvent.CHANGED));
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

/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.model
{
    import flash.utils.Proxy;

    import org.robotlegs.mvcs.Actor;

    import ua.com.froggy.flash.client.events.ShopEvent;

    import ua.com.froggy.flash.client.model.vo.ProductVO;

    public class CatalogProxy extends Actor
    {
        private var _products:Vector.<ProductVO>;
        private var _filterProducts:Vector.<ProductVO>;
        private var _filter:String;

        /**
         * Full or filtered vector of object
         */
        public function get products():Vector.<Object>
        {
            var source:Vector.<ProductVO> = _filter ? _filterProducts : _products;

            var n:int = source ? source.length : 0;
            var result:Vector.<Object> = new Vector.<Object>(n, true);
            for (var i:int = 0; i < n; i++)
                result[i] = source[i];

            return result;
        }

        public function CatalogProxy()
        {
            super();
        }

        public function updateCatalog(products:Vector.<ProductVO>)
        {
            _products = products;
            dispatch(new ShopEvent(ShopEvent.CATALOG_CHAHNGED));
        }

        public function filter(maskString:String)
        {
            _filter = maskString;
            _filterProducts = new Vector.<ProductVO>();

            if (_filter == "" || _filter == null)
                return;

            var index:int = -1;
            var n:int = _products.length;
            for (var i:int = 0; i < n; i++)
            {
                var product:ProductVO = _products[i];
                if (product == null)
                    continue;

                index = product.title.indexOf(_filter);
                if (index != -1)
                {
                    _filterProducts.push(product);
                    continue;
                }

                index = product.description.indexOf(_filter);
                if (index != -1)
                {
                    _filterProducts.push(product);
                    continue;
                }
            }
        }

    }
}

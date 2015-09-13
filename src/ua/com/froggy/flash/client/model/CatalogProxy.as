/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.model
{
    import org.robotlegs.mvcs.Actor;

    import ua.com.froggy.flash.client.model.vo.ProductVO;
    import ua.com.froggy.flash.client.signals.CatalogChangedSignal;

    public class CatalogProxy extends Actor
    {
        [Inject]
        public var catalogChangedSignal:CatalogChangedSignal;

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

        public function updateCatalog(products:Vector.<ProductVO>):void
        {
            _products = products;
            if (catalogChangedSignal)
                catalogChangedSignal.dispatch();
        }

        public function filter(maskString:String):void
        {
            _filter = maskString.toLowerCase();
            _filterProducts = new Vector.<ProductVO>();

            if (_filter == "" || _filter == null)
            {
                if (catalogChangedSignal)
                    catalogChangedSignal.dispatch();
                return;
            }

            var index:int = -1;
            var n:int = _products.length;
            for (var i:int = 0; i < n; i++)
            {
                var product:ProductVO = _products[i];
                if (product == null)
                    continue;

                var strTitle:String = product.title.toLowerCase();
                index = strTitle.indexOf(_filter);
                if (index != -1)
                {
                    _filterProducts.push(product);
                    continue;
                }

                var strDescription:String = product.description.toLowerCase();
                index = strDescription.indexOf(_filter);
                if (index != -1)
                {
                    _filterProducts.push(product);
                    continue;
                }
            }

            if (catalogChangedSignal)
                catalogChangedSignal.dispatch();
        }

    }
}

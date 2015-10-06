/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.model
{
    import flash.events.EventDispatcher;

    import ua.com.froggy.flash.client.events.CatalogChangedEvent;
    import org.kolonitsky.alexey.events.ServiceEvent;

    import ua.com.froggy.flash.client.model.vo.ProductVO;
    import org.kolonitsky.alexey.service.FroggyService;

    [Event(name="catalogChanged", type="ua.com.froggy.flash.client.events.CatalogChangedEvent")]

    [ManagedEvents("catalogChanged")]

    public class CatalogProxy extends EventDispatcher
    {
        private var _products:Vector.<ProductVO>;
        private var _filterProducts:Vector.<ProductVO>;
        private var _filter:String;


        //-----------------------------
        // Constructor
        //-----------------------------

        public function CatalogProxy()
        {
            super();
        }


        //-----------------------------
        // products read-only-property
        //-----------------------------

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

        public function filter(maskString:String):void
        {
            _filter = maskString.toLowerCase();
            _filterProducts = new Vector.<ProductVO>();

            if (_filter == "" || _filter == null)
            {
                dispatchEvent(new CatalogChangedEvent());
                return;
            }

            if (_products == null)
            {
                trace("[WARNING] Using search while catalog is unavailable");
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

            dispatchEvent(new CatalogChangedEvent());
        }

        public function updateProducts(products:Vector.<ProductVO>):void
        {
            _products = products;

            dispatchEvent(new CatalogChangedEvent());
        }
    }
}

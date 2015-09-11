/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.events
{
    import flash.events.Event;

    import ua.com.froggy.flash.client.model.vo.ProductVO;

    public class ShopEvent extends Event
    {
        public static const STARTUP:String = "startup";
        public static const CATALOG_LOADED:String = "catalogLoaded";
        public static const CATALOG_CHAHNGED:String = "catalogChanged";
        public static const BUY_PRODUCT:String = "buyProduct";
        public static const CANCEL_PRODUCT:String = "cancelProduct";
        public static const SHOPPING_CART_CHANGED:String = "shoppingCartChanged";

        public var product:ProductVO;

        public function ShopEvent(type:String, product:ProductVO = null)
        {
            super(type, true, false);
            this.product = product;
        }

        override public function clone():Event
        {
            var result:ShopEvent = new ShopEvent(type, product);
            return result as Event;
        }
    }
}

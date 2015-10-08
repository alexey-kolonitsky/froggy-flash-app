/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.model.vo
{
    import flash.display.BitmapData;

    public class ProductVO
    {
        /* Unique identifier of product. Character limit 50 */
        public var id:String;

        public var imageURL:String;

        /* Original name of product. Character limit 150 */
        public var title:String;

        /* Full product desription. Character limit	5000 */
        public var description:String;

        /* Full product desription. Character limit	5000 */
        public var price:Number;

        public var currency:String;

        /** Cache of loaded image */
        public var imageBitmap:BitmapData;

        public function toString():String
        {
            return "[ProductVO " + id + " '" + title + "']";
        }

        public function get localPrice():String
        {
            var strCurrency:String = currency ? currency : "грн";
            return price + " " + strCurrency;
        }
    }
}

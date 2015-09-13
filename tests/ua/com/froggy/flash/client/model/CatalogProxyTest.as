/**
 * Created by Alexey on 11.09.2015.
 */
package ua.com.froggy.flash.client.model
{
    import org.flexunit.asserts.assertEquals;

    import ua.com.froggy.flash.client.model.vo.ProductVO;

    public class CatalogProxyTest
    {
        public var products:Vector.<ProductVO>;
        public var proxy:CatalogProxy;

        public function CatalogProxyTest()
        {
            products = new <ProductVO>[
                createProduct("1", "Снежинка", "Пушистая, мягкая", "image01.jpg", "50 грн."),
                createProduct("2", "Сосулька", "Острая, опасная, ледяная", "image02.jpg", "50 грн."),
                createProduct("3", "Снегурочка", "Ледяная девочка", "image03.jpg", "50 грн."),
                createProduct("4", "Зайка", "Мягкий и пушистый", "image04.jpg", "50 грн.")
            ];
        }

        public function createProduct(id:String, title:String, description:String, image:String, price:String)
        {
            var result:ProductVO = new ProductVO();
            result.id = id;
            result.description = description;
            result.imageURL = image;
            result.price = price;
            result.title = title;
            return result;
        }

        [Before]
        public function setUp():void
        {
            proxy = new CatalogProxy();
        }

        [After]
        public function tearDown():void
        {
            proxy = null;
            products = null;
        }

        [Test]
        public function testUpdateCatalog():void
        {
            proxy.updateCatalog(products);
            assertEquals(proxy.products.length, 4);
        }

        [Test]
        public function testFilter():void
        {
            proxy.updateCatalog(products);
            proxy.filter("ледяная");
            assertEquals(proxy.products.length, 2);
        }

        [Test]
        public function testFilterNoResult():void
        {
            proxy.updateCatalog(products);
            proxy.filter("Дед Мороз");
            assertEquals(proxy.products.length, 0);
        }

        [Test]
        public function testFilterClear():void
        {
            proxy.updateCatalog(products);
            proxy.filter("");
            assertEquals(proxy.products.length, 4);
        }

    }
}

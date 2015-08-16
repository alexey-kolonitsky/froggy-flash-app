/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.view.froggy_components
{
    import ua.com.froggy.flash.client.view.components.*;
    import flash.display.Sprite;

    import ua.com.froggy.flash.client.model.vo.ProductVO;
    import ua.com.froggy.flash.client.view.renderers.ProductItemRenderer;

    public class CatalogList extends ScrollList
    {

        public function CatalogList()
        {
            super(ProductItemRenderer, 0, 0);
        }

    }
}

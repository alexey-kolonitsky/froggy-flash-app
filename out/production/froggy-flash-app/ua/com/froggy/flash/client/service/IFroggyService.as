/**
 * Created by Alexey on 16.08.2015.
 */
package ua.com.froggy.flash.client.service
{
    import ua.com.froggy.flash.client.model.vo.ProductVO;

    public interface IFroggyService
    {
        function load():void;
        function filter(mask:String):void;
        function get products():Vector.<ProductVO>;
    }
}

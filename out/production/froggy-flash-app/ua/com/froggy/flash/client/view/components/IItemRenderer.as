/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.view.components
{
    public interface IItemRenderer
    {
        function get data():Object;
        function set data(value:Object):void;
        function get index():int;
        function set index(value:int):void;
        function get id():int;
    }
}

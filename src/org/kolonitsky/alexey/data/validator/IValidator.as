/**
 * Created by Aliaksei_Kalanitski on 10/7/2015.
 */
package org.kolonitsky.alexey.data.validator
{
    public interface IValidator
    {
        function get isValid():Boolean;
        function get isInvalid():Boolean;
        function get invalidMessage():String;
        function validate(value:String):void;
    }
}

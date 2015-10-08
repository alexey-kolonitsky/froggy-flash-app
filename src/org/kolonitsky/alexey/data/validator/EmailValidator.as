/**
 * Created by Aliaksei_Kalanitski on 10/7/2015.
 */
package org.kolonitsky.alexey.data.validator
{
    public class EmailValidator implements IValidator
    {
        private static const EMAIL_REGEXPT:RegExp = /\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/;

        public function EmailValidator()
        {
        }

        public function get invalidMessage():String
        {

        }

        public function get isValid():Boolean
        {
            return false;
        }

        public function get isInvalid():Boolean
        {
            return false;
        }

        public function validate(value:String):void
        {
        }
    }
}

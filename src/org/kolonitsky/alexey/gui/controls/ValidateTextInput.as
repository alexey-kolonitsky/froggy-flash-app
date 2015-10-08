/**
 * Created by Aliaksei_Kalanitski on 10/7/2015.
 */
package org.kolonitsky.alexey.gui.controls
{
    import org.kolonitsky.alexey.data.validator.IValidator;

    public class ValidateTextInput extends TextInput
    {
        public var validators:Vector.<IValidator>;
        public var invalidMessage:String;

        public function ValidateTextInput(width:int, height:int)
        {
            super(width, height)
        }

        public function registerValidator(validator:IValidator):void
        {
            validators.push(validator);
        }

        public function removeValidator(validator:IValidator):void
        {
            var index:int = validators.indexOf(validator);
            if (index != -1)
                validators.splice(index, 1);
        }

        public function removeAllValidators():void
        {
            validators = new Vector.<IValidator>();
        }

        public function validate():void
        {
            for (var i:int = 0; i < validators; i++)
            {
                var validator = validators[i];
                validator.validate(text);
                if (validator.isInvalid)
                {
                    invalidMessage += validator.invalidMessage;
                    break;
                }
            }
        }
    }
}

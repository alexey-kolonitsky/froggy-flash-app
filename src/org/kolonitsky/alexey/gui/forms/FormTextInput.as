/**
 * Created by Aliaksei_Kalanitski on 10/7/2015.
 */
package org.kolonitsky.alexey.gui.forms
{
    import flash.text.TextField;

    import org.kolonitsky.alexey.gui.controls.ValidateTextInput;
    import org.kolonitsky.alexey.gui.core.GUIElement;

    public class FormTextInput extends GUIElement
    {
        private var input:ValidateTextInput;
        private var label:TextField;

        public function FormTextInput(labelText:String, inputPromptText:String, inputSuggestion:String)
        {
            super();
        }
    }
}

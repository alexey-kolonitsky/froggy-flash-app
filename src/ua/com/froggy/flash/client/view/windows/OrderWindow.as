/**
 * Created by Alexey on 12.08.2015.
 */
package ua.com.froggy.flash.client.view.windows
{
    import flash.display.Bitmap;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.text.TextField;

    import org.kolonitsky.alexey.data.LocalStorage;
    import org.kolonitsky.alexey.gui.core.GUIState;
    import org.kolonitsky.alexey.gui.events.GUIEvent;

    import org.kolonitsky.alexey.gui.windows.WindowBase;
    import org.spicefactory.lib.command.builder.Commands;

    import ua.com.froggy.flash.client.Images;
    import ua.com.froggy.flash.client.Styles;
    import ua.com.froggy.flash.client.controller.SendOrderCommand;
    import ua.com.froggy.flash.client.events.CartEvent;
    import ua.com.froggy.flash.client.events.CatalogChangedEvent;
    import ua.com.froggy.flash.client.events.OrderEvent;
    import ua.com.froggy.flash.client.events.ProductEvent;
    import ua.com.froggy.flash.client.events.SearchEvent;
    import ua.com.froggy.flash.client.model.CatalogProxy;
    import ua.com.froggy.flash.client.model.ShoppingCartProxy;
    import ua.com.froggy.flash.client.model.vo.CustomerDetailsVO;
    import ua.com.froggy.flash.client.model.vo.OrderProductVO;
    import ua.com.froggy.flash.client.model.vo.OrderVO;
    import org.kolonitsky.alexey.service.FroggyService;
    import ua.com.froggy.flash.client.view.components.LayoutType;
    import ua.com.froggy.flash.client.view.components.List;
    import org.kolonitsky.alexey.gui.controls.Button;
    import org.kolonitsky.alexey.gui.controls.Label;
    import org.kolonitsky.alexey.gui.controls.TextInput;
    import org.kolonitsky.alexey.gui.core.GUIElement;
    import org.kolonitsky.alexey.gui.core.GUIGroup;
    import org.kolonitsky.alexey.gui.core.ViewComponent;
    import ua.com.froggy.flash.client.view.froggy_components.CatalogList;
    import ua.com.froggy.flash.client.view.froggy_components.SearchField;
    import ua.com.froggy.flash.client.view.renderers.OrderProductRenderer;
    import ua.com.froggy.flash.client.view.renderers.OrderSmallRenderer;

    [Event(name="buyProduct",type="ua.com.froggy.flash.client.events.ProductEvent")]

    [Event(name="cancelProduct",type="ua.com.froggy.flash.client.events.ProductEvent")]

    [Event(name="createOrder",type="ua.com.froggy.flash.client.events.OrderEvent")]

    [ManagedEvents("buyProduct,cancelProduct,createOrder")]

    /**
     *
     */
    public class OrderWindow extends WindowBase
    {
        public static const TYPE:String = "OrderWindow";

        public static const DEFAULT_WIDTH:uint = 640;
        public static const DEFAULT_HEIGHT:uint = 480;

        private var _cartLabel:Label;
        private var _totalLabel:Label;
        private var _closeButton:Button;
        private var _nextButton:Button;

        private var _nameTextInput:TextInput;
        private var _emailTextInput:TextInput;
        private var _addressTextInput:TextInput;
        private var _phoneTextInput:TextInput;
        private var _detailsTextArea:TextInput;

        private var _shoppingCartList:List;
        private var _formGroup:GUIGroup;

        //-----------------------------
        // Stored Fields
        //-----------------------------
        private var _customer:CustomerDetailsVO;
        private var _order:OrderVO;

        [Inject]
        public var localStorage:LocalStorage;

        [Inject]
        public var cartProxy:ShoppingCartProxy;

        //-----------------------------
        // Constructor
        //-----------------------------

        public function OrderWindow()
        {
            super();
            _customer = new CustomerDetailsVO();

            _order = new OrderVO();
            _order.customer = _customer;

            createChildren();
            updateLayout(LayoutType.VERTICAL, 2, 2);
            updatePadding(8, 8, 40, 8);
            drawWireframe(Styles.BORDER_ACTIVE_COLOR, 1, 0xFFFFFF);
        }

        [Init]
        override public function initialize():void
        {
            // commit injected properties
            if (cartProxy == null)
                return;

            products = cartProxy.orders;

            // don't initialize more then one times
            if (state != GUIState.CREATED)
                return;

            // commit stored properties to form
            if (_nameTextInput)
                _nameTextInput.text = localStorage.readString("fn");

            if (_emailTextInput)
                _emailTextInput.text = localStorage.readString("email");

            if (_addressTextInput)
                _addressTextInput.text = localStorage.readString("address");

            if (_phoneTextInput)
                _phoneTextInput.text = localStorage.readString("phone");

            if (_detailsTextArea)
                _detailsTextArea.text = localStorage.readString("details");

            stage.addEventListener(Event.RESIZE, stage_resizeHandler);

            // commit GUIState.INITILIZED and updatePosition
            super.initialize();
        }

        [MessageHandler]
        public function shoppingCartChanged(event:CartEvent):void
        {
            products = cartProxy.orders;
        }

        //-----------------------------
        // products
        //-----------------------------

        public function get products():Vector.<Object>
        {
            return _shoppingCartList.dataProvider;
        }

        public function set products(value:Vector.<Object>):void
        {
            _shoppingCartList.dataProvider = value;

            _order.products = new Vector.<OrderProductVO>();
            for (var i:int = 0; i < products.length; i++)
                _order.products.push(products[i] as OrderProductVO);

            if (_totalLabel)
                _totalLabel.text = "Всего: " + _order.totalPrice;

            if (state != GUIState.CREATED)
                updatePosition();
        }

        //-------------------------------------------------------------------
        //
        // Private
        //
        //-------------------------------------------------------------------

        override protected function updatePosition():void
        {
            super.updatePosition();

            if (stage)
            {
                x = (stage.stageWidth - width) / 2;
                y = (stage.stageHeight - height) / 2;
            }

            if (_closeButton)
            {
                _closeButton.y = height - _closeButton.height - 2;
                _closeButton.x = width / 2 + 2;
            }

            if (_nextButton)
            {
                _nextButton.y = height - _closeButton.height - 2;
                _nextButton.x = width / 2 - Button.BUTTON_WIDTH - 2;
            }

            drawWireframe(Styles.BORDER_ACTIVE_COLOR, 1, 0xFFFFFF);
        }

        private function createChildren():void
        {
            _cartLabel = new Label(0, 0, DEFAULT_WIDTH, 32, Styles.TITLE_FORMAT);
            _cartLabel.text = "Корзина";
            addElement(_cartLabel);

            _shoppingCartList = new List(OrderProductRenderer, DEFAULT_WIDTH,
                OrderProductRenderer.DEFAULT_WIDTH,
                OrderProductRenderer.DEFAULT_HEIGHT,
                LayoutType.VERTICAL);
            addElement(_shoppingCartList);

            _totalLabel = new Label(0, 0, DEFAULT_WIDTH, 32, Styles.BASE_TEXT_FORMAT);
            _totalLabel.text = "";
            addElement(_totalLabel);

            _cartLabel = new Label(0, 0, DEFAULT_WIDTH, 32, Styles.TITLE_FORMAT);
            _cartLabel.text = "Адрес доставки";
            addElement(_cartLabel);

            _nameTextInput = new TextInput(512, 32);
            _nameTextInput.promptText = "ФИО";

            _emailTextInput = new TextInput(512, 32);
            _emailTextInput.promptText = "Email";

            _addressTextInput = new TextInput(512, 32);
            _addressTextInput.promptText = "Адрес";

            _phoneTextInput = new TextInput(512, 32);
            _phoneTextInput.promptText = "телефон";

            _detailsTextArea = new TextInput(512, 32);
            _detailsTextArea.promptText = "Все что угодно";

            _formGroup = new GUIGroup(480 - 8 - 8, -1);
            _formGroup.updateLayout(LayoutType.VERTICAL, 2, 2, 480 - 8 - 8, 32);
            _formGroup.addElement(_nameTextInput);
            _formGroup.addElement(_emailTextInput);
            _formGroup.addElement(_addressTextInput);
            _formGroup.addElement(_phoneTextInput);
            _formGroup.addElement(_detailsTextArea);
            addElement(_formGroup);

            // Untracked
            _closeButton = new Button("Закрыть");
            _closeButton.addEventListener(MouseEvent.CLICK, closeButton_clickHandler);
            addChild(_closeButton);

            _nextButton = new Button("Далее");
            _nextButton.addEventListener(MouseEvent.CLICK, nextButton_clickHandler);
            addChild(_nextButton);
        }

        private function nextButton_clickHandler(event:MouseEvent):void
        {
            _customer.email = _emailTextInput.text;
            _customer.name = _nameTextInput.text;
            _customer.phone = _phoneTextInput.text;
            _customer.address = _addressTextInput.text;

            _order = new OrderVO();
            _order.details = _detailsTextArea.text;

            localStorage.save("fn", _customer.name);
            localStorage.save("email", _customer.email);
            localStorage.save("address", _customer.address);
            localStorage.save("phone", _customer.phone);
            localStorage.save("details", _order.details);

            dispatchEvent(new OrderEvent(OrderEvent.CREATE, _order));
        }



        //-------------------------------------------------------------------
        // Event Handler
        //-------------------------------------------------------------------

        private function closeButton_clickHandler(event:MouseEvent):void
        {
            close();
        }

        private function stage_resizeHandler(event:Event):void
        {
            updatePosition()
        }
    }
}

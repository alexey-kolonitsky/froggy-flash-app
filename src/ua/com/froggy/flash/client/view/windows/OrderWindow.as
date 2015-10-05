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

    import org.kolonitsky.alexey.gui.windows.WindowBase;

    import ua.com.froggy.flash.client.Images;
    import ua.com.froggy.flash.client.Styles;
    import ua.com.froggy.flash.client.events.CatalogEvent;
    import ua.com.froggy.flash.client.events.ProductEvent;
    import ua.com.froggy.flash.client.events.SearchEvent;
    import ua.com.froggy.flash.client.model.CatalogProxy;
    import ua.com.froggy.flash.client.model.ShoppingCartProxy;
    import ua.com.froggy.flash.client.model.vo.CustomerDetailsVO;
    import ua.com.froggy.flash.client.model.vo.OrderProductVO;
    import ua.com.froggy.flash.client.model.vo.OrderVO;
    import ua.com.froggy.flash.client.service.FroggyService;
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

    [ManagedEvents("search,clear,buyProduct")]

    /**
     *
     */
    public class OrderWindow extends WindowBase
    {
        public static const TYPE:String = "OrderWindow";

        public static const DEFAULT_WIDTH:uint = 640;
        public static const DEFAULT_HEIGHT:uint = 480;

        private var _titleLabel:Label;
        private var _closeButton:Button;
        private var _nextButton:Button;

        private var _nameTextInput:TextInput;
        private var _emailTextInput:TextInput;
        private var _addressTextInput:TextInput;
        private var _phoneTextInput:TextInput;
        private var _detailsTextArea:TextInput;

        private var _catalogList:List;
        private var _formGroup:GUIGroup;

        [Inject(id="froggyService")]
        public var froggyService:FroggyService;

        [Inject]
        public var localStorage:LocalStorage;

        [Inject]
        public var shoppingCart:ShoppingCartProxy;

        //-----------------------------
        // Constructor
        //-----------------------------

        public function OrderWindow()
        {
            super();
            createChildren();
            drawBorder();
        }

        private function drawBorder():void
        {
            graphics.beginFill(Styles.BACKGROUND_COLOR);
            graphics.lineStyle(1, Styles.BORDER_ACTIVE_COLOR);
            graphics.drawRoundRect(0, 0, DEFAULT_WIDTH, DEFAULT_HEIGHT, Styles.TEXT_INPUT_CORDERN_RADIUS, Styles.TEXT_INPUT_CORDERN_RADIUS);
            graphics.lineStyle();
            graphics.endFill();
        }

        [Init]
        public function initialize():void
        {
            updatePosition();
            stage.addEventListener(Event.RESIZE, stage_resizeHandler);
        }


        //-----------------------------
        // products
        //-----------------------------

        public function get products():Vector.<Object>
        {
            return _catalogList.dataProvider;
        }

        public function set products(value:Vector.<Object>):void
        {
            _catalogList.dataProvider = value;
        }

        [Init]
        public function init():void
        {
            products = shoppingCart.orders;

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
        }


        //-------------------------------------------------------------------
        //
        // Private
        //
        //-------------------------------------------------------------------

        private function updatePosition()
        {
            x = (stage.stageWidth - width) / 2;
            y = (stage.stageHeight - height) / 2;

            if (_closeButton)
            {
                _closeButton.y = DEFAULT_HEIGHT - _closeButton.height - 2;
                _closeButton.x = DEFAULT_WIDTH / 2 + 2;
            }

            if (_nextButton)
            {
                _nextButton.y = DEFAULT_HEIGHT - _closeButton.height - 2;
                _nextButton.x = DEFAULT_WIDTH / 2 - Button.BUTTON_WIDTH - 2;
            }
        }

        private function createChildren():void
        {
            _titleLabel = new Label(0, 0, DEFAULT_WIDTH, 32, Styles.TITLE_FORMAT);
            _titleLabel.text = "Форма заказа";

            addChild(_titleLabel);

            _catalogList = new List(OrderSmallRenderer, DEFAULT_WIDTH,
                OrderSmallRenderer.DEFAULT_WIDTH,
                OrderSmallRenderer.DEFAULT_HEIGHT,
                LayoutType.TILE_LAYOUT);
            _catalogList.x = 0;
            _catalogList.y = 34;
            addChild(_catalogList);

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

            _formGroup = new GUIGroup(LayoutType.VERTICAL_LAYOUT, 512, 512, 32);
            _formGroup.addElement(_nameTextInput);
            _formGroup.addElement(_emailTextInput);
            _formGroup.addElement(_addressTextInput);
            _formGroup.addElement(_phoneTextInput);
            _formGroup.addElement(_detailsTextArea);
            _formGroup.x = 0;
            _formGroup.y = 32 + 64 + 4;
            addChild(_formGroup);

            _closeButton = new Button("Закрыть");
            _closeButton.addEventListener(MouseEvent.CLICK, closeButton_clickHandler);
            addChild(_closeButton);

            _nextButton = new Button("Далее");
            _nextButton.addEventListener(MouseEvent.CLICK, nextButton_clickHandler);
            addChild(_nextButton);
        }

        private function nextButton_clickHandler(event:MouseEvent):void
        {
            var customer:CustomerDetailsVO = new CustomerDetailsVO();
            customer.email = _emailTextInput.text;
            customer.name = _nameTextInput.text;
            customer.phone = _phoneTextInput.text;
            customer.address = _addressTextInput.text;

            var order:OrderVO = new OrderVO();
            order.customer = customer;
            order.details = _detailsTextArea.text;
            order.products = new Vector.<OrderProductVO>();
            for (var i:int = 0; i < products.length; i++)
                order.products.push(products[i] as OrderProductVO);

            localStorage.save("fn", customer.name);
            localStorage.save("email", customer.email);
            localStorage.save("address", customer.address);
            localStorage.save("phone", customer.phone);
            localStorage.save("details", order.details);

            froggyService.sendOrder(order)
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

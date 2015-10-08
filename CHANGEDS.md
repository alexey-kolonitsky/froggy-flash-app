10-10-2015 v1.0.2
-----------------
 - Order form
    * Order window
    * Order service layer
    * Order server side
    * Email notification to manager
 

20-09-2015 v1.0.1
-----------------
 - Shopping catalog with ability to search product by 
   name and small shopping cart in the top right corner


Backlog
-------
 - [1] Scroll in catalog
 - Order Form
    * [2]  Validation for text field with visual markers
    * [5]  Show google maps component when user go out from address field
    * [2]  Delivery methods (post parsel/courier/ex work)
    * [2]  Handle long shopping list. Now products added to shopping cart and 
    * [1]  Handle zero in as count of products in cart
    * [1]  Don't send order with empty cart
    * Payment options (credit card/liqui pay/cash)
 
 - Small Shoping Cart
    * [1]  Show shopping cart after first purchase
    * [1]  Limit shopping cart for 5 products

 - Promotion
    * robots.txt
    * humans.txt
    * VK group 
    * Facebook group, register application
    * Add likes and foll

 - Preloader with ability to switch to HTML version
 
 - Development process
    * Create a few different folder for each version of 
      updates and hardlink from main directory to the last 
      tested update [~php]
    * Create nice URL for each request and route them to real 
      scripts. [~php]
      POST /product           -> /php/product.php
      GET  /product?id=UT0054 -> /products/UT0054.html
      POST /order             -> /php/order.php
      GET  /order?id=15       -> /orders/order.html
      
    * Include Console text application

 - News (Check news by [~copywriter])
    * Admin part creation of news and save them as RSS
    * Publish news to server
    * Show news on client
    
 - Web site (Design it with [~designer])
    * Favorite Icon
    
 - HTML Version [~html]
    * Permanent link to product pages
    * Add likes on HTML verstion of product
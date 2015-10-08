/**
 * Created by Aliaksei_Kalanitski on 10/6/2015.
 */
package org.kolonitsky.alexey.service
{
    public class HTMLDocument
    {
        public var source:XML;
        public var title:String;
        public var description:String;
        public var keywords:String;

        public static function create():HTMLDocument
        {
            var result:HTMLDocument = new HTMLDocument();
            result.source =
            <html>
                <head>
                    <title></title>
                </head>
                <body>
                </body>
            </html>;
            return result;
        }

        public static function parse(document:XML):HTMLDocument
        {
            return null;
        }
    }
}

/**
 * Created by Aliaksei_Kalanitski on 10/5/2015.
 */
package org.kolonitsky.alexey.date
{
    public class W3Date
    {
        public static const W3C_DATE_PATTERN:RegExp = /\d{4}(-\d{2}(-\d{2}(T\d{2}:\d{2}(:\d{2}(\.\d{1,3})?)?(Z|[+\-]\d{2}:\d{2}))?)?)?/;

        public static function parseW3CDTF(source:String):Date
        {
            var r:Array = W3C_DATE_PATTERN.exec(source);
            if (r == null)
                return null;

            if (r.length >= 1 && r[0]) //year found
            {
                var strYear:String = r[0];
            }

            if (r.length >= 2 && r[1]) //month found
            {
                var strMonth:String = r[1];
                strYear = strYear.replace(strMonth, "");
                strMonth = strMonth.slice(1);
            }
            if (r.length >= 1 && r[2]) //date found
            {
                var strDate:String = r[2];
                strMonth = strMonth.replace(strDate, "");
                strDate = strDate.slice(1);
            }

            return new Date(strYear, parseInt(strMonth) - 1, strDate);
        }

        public static function toW3CDateTime(date:Date):String
        {
            return toW3CDate(date) + "T" + toW3CTime(date);
        }

        public static function toW3CDate(date:Date):String
        {
            if (date)
            {
                var monthString:String = String(date.month < 10 ? "0" + (date.month + 1) : date.month + 1);
                var dayString:String = String(date.day < 10 ? "0" + date.day : date.day);
                return date.fullYear.toString() + "-" + monthString + "-" + dayString;
            }
            return "<!INVALID_DATE>";
        }

        public static function toW3CTime(date:Date):String
        {
            if (date)
            {
                var secString:String = String(date.seconds < 10 ? "0" + date.seconds : date.seconds);
                var minString:String = String(date.minutes < 10 ? "0" + date.minutes : date.minutes);
                var hourString:String = String(date.hours < 10 ? "0" + date.hours : date.hours);
                return hourString + ":" + minString + ":" + secString;
            }
            return "<!INVALID_TIME>";
        }
    }
}

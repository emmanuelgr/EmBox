package gr.emmanuel.emBoxAS3.utils {

	public class Strings    {

		/**
		 * Validates a date in these two formats:
		 *
		 * DD MM YYYY
		 * MM DD YYYY
		 *
		 * The valid separators are dash "-", dot ".", front slash "/" and space " ".
		 *
		 * @param date The date to be validated.
		 * @return  Returns true if the date is valid or false otherwise.
		 */
		public static function checkDate(date:String):Boolean{
			var month:String        = "(0?[1-9]|1[012])";
			var day:String          = "(0?[1-9]|[12][0-9]|3[01])";
			var year:String         = "([1-9][0-9]{3})";
			var separator:String    = "([.\/ -]{1})";

			var usDate:RegExp = new RegExp("^" + month + separator + day + "\\2" + year + "$");
			var ukDate:RegExp = new RegExp("^" + day + separator + month + "\\2" + year + "$");

			return (usDate.test(date) || ukDate.test(date) ? true:false);
		}

		/**
		 * Validates an email address. The address should have the following
		 * format:
		 *
		 * [user]@[domain].[domain_extension]
		 *
		 * @param   emailAddress
		 * @return  Returns true if the address is valid or false otherwise.
		 */
		public static function checkEmailAddress(emailAddress:String):Boolean{
			var address:String      = "([a-z0-9._-]+)";
			var domainName:String   = "([a-z0-9.-]+)";
			var domainExt:String    = "(com|gr|net|org|info|tv|mobi|museum|gov|biz|tel|name|edu|asia|travel|pro)";
			var email:RegExp = new RegExp("^" + address + "@" + domainName + "\\." + domainExt + "$", "i");
			return email.test(emailAddress);
		}
		/**
		 * Validates a web address. The address should have the following
		 * format:
		 *
		 * [protocol://(optional)][domain].[domain_extension]
		 *
		 * @param   address The web address to be checked.
		 * @return  Returns true if the address is valid or false otherwise.
		 */
		public static function checkWebAddress(address:String):Boolean{
			var protocol:String     = "(https?:\/\/|ftp:\/\/)?";
			var domainName:String   = "([a-z0-9.-]{2,})";
			var domainExt:String    = "(com|gr|net|org|info|tv|mobi|museum|gov|biz|tel|name|edu|asia|travel|pro)";
			var web:RegExp          = new RegExp('^' + protocol + '?' + domainName + "\." + domainExt + '$', "i");
			return web.test(address);
		}

		/**
		 * Validates a phone number. The phone number should have the following
		 * format:
		 *
		 * [countryCode(optional)][XXX][YYY][ZZZZ]
		 *
		 * Separators between X's, Y's and Z's are optional.
		 * Valid separators are dash "-", dot "." and space " ".
		 *
		 * @param   phoneNumber The phone number to be checked.
		 * @return  Returns true if the number is valid or false otherwise.
		 */
		public static function checkPhoneNumber(phoneNumber:String):Boolean{
			var countryCode:String  = "((\\+|00)?([1-9]|[1-9][0-9]|[1-9][0-9]{2}))";
			var num:String      = "([0-9]{3,10})";
			phoneNumber = phoneNumber.match(/[\+\d]/g).join('');

			var phone:RegExp = new RegExp("^" + countryCode + num +"$");

			return phone.test(phoneNumber);
		}

		/**
		 * Checks if an ISBN-10 number passes the checksum.
		 *
		 * @param   isbn10 The ISBN-10 number to be validated.
		 * @return  Returns true if the number is valid or false otherwise.
		 */
		public static function validateISBN10(isbn10:String):Boolean{
			isbn10 = isbn10.replace(/[ -]/g, '');

			if (isbn10.length != 10){
				return false;
			}else{
				var valid:Boolean;
				var weights:Array   = [10, 9, 8, 7, 6, 5, 4, 3, 2];
				var digits:Array    = isbn10.split('');
				var control:String  = digits.pop();
				var result:uint     = 0;

				for (var i:uint = 0; i < 9; i++){
					digits[i] = digits[i] * weights[i];
					result += digits[i];
				}
				result = (result%11==0)?0:(11 - result % 11);
				switch(result)
				{
					case 10:
						valid = (control.toLowerCase() == 'x');
					break;
					default:
						valid = control == String(result);
					break;
				}
				return valid;
			}
		}

		/**
		 * Checks the format of an ISBN-13 number and validates it.
		 *
		 * @param   isbn13  The ISBN-13 number to be validated.
		 * @return  Returns true if the number is valid or false otherwise.
		 */
		public static function validateISBN13(isbn13:String):Boolean{
			var digits:Array    = isbn13.match(/\d/g);
			var control:uint    = digits.pop();
			var result:uint;
			var weight:uint;
			if (digits.length != 12){
				return false;
			}else {
				for (var i:uint = 0; i < 12; i++)
				{
					weight = (i % 2 == 0)?1:3;
					digits[i] = digits[i] * weight;
					result += digits[i];
				}
				result = (result % 10 == 0)?0:(10 - result % 10);
				return (result == control);
			}
		}

		/**
		 * Validates an IBAN number.
		 *
		 * @param   iban    The IBAN number to be validated.
		 * @return  Returns true if the number is valid or false otherwise.
		 */
		public static function validateIBAN(iban:String):Boolean{
			var nums:Object     = { A:10, B:11, C:12, D:13, E:14,
			F:15, G:16, H:17, I:18, J:19,
			K:20, L:21, M:22, N:23, O:24,
			P:25, Q:26, R:27, S:28, T:29,
			U:30, V:31, W:32, X:33, Y:34, Z:35 };
			var chars:Array     = iban.split('');

			for (var i:int = 0; i < 4; i++){
				chars.push(chars.shift());
			}

			var exp:RegExp = /[a-z]/i;
			for (var j:int = 0; j < chars.length; j++){
				chars[j] = exp.test(chars[j]) ? nums[chars[j].toUpperCase()] : chars[j];
			}
			iban = chars.join('');
			return modulus(iban, 97) == 1;
		}

		/**
		 * Checks if the provided Credit Card number is a correct one for each
		 * of these providers: American Express, Dinners Club, MasterCard and Visa.
		 *
		 * @param   ccNumber    The credit number to be validated.
		 * @return  Returns true if the number is valid or false otherwise
		 */
		public static function validateCardNumber(ccNumber:String):Boolean{
			var americanExpress:RegExp  = /^(34|37) ([0-9]{13})$/x;
			var dinnersClub:RegExp      = /^(30[0-5]) ([0-9]{13})$/x;
			var masterCard:RegExp       = /^(5[1-5]) ([0-9]{14})$/x;
			var visa:RegExp             = /^4 ([0-9]{12} | [0-9]{15})$/x;
			var valid:Boolean;
			ccNumber = ccNumber.match(/\d/g).join('');

			if (americanExpress.test(ccNumber) || dinnersClub.test(ccNumber) ||
			masterCard.test(ccNumber) || visa.test(ccNumber))
			valid = true;

			return valid && luhnChecksum(ccNumber);
		}

		/**
		 * Returns the modulus of a very large number.
		 *
		 * @param   largeNumber The divided number.
		 * @param   mod         The dividing number.
		 *
		 * @return  Returns the remainder.
		 */
		public static function modulus(largeNumber:String, mod:uint):Number{
			var tmp:String      = largeNumber.substr(0, 10);
			var number:String   = largeNumber.substr(tmp.length);
			var result:String;

			do {
				result = String(Number(tmp) % mod);
				number = result + number;
				tmp = number.substr(0, 10);
				number = number.substr(tmp.length);
			} while (number.length > 0);

			return Number(tmp) % mod;
		}

		/**
		 * Makes a Luhn mod 10 checksum for a specified number.
		 *
		 * @param   number  The number to be checked.
		 * @return  Returns true if the number passes the checksum or false otherwise.
		 */
		public static function luhnChecksum(number:String):Boolean{
			var digits:Array = number.split('');
			var start:uint = (number.length % 2 == 0) ? 0:1;
			var sum:int;

			while (start < digits.length){
				digits[start] = uint(digits[start]) * 2;
				start += 2;
			}

			digits = digits.join('').split('');

			for (var i:uint = 0; i < digits.length; i++){
				sum += uint(digits[i]);
			}
			return (sum % 10 == 0);
		}

		/**
		 * Takes a time as a string and returns that time in seconds.
		 * <p>
		 * The following time values are supported:<ul>
		 * <li>full clock format in "hours:minutes:seconds" (for example 00:03:00).</li>
		 * <li>offset time (for example 10s or 2m).</li>
		 * </ul></p>
		 * Note: Offset times without units (for example 10) are assumed to be seconds.
		 */
		public static function parseTime(value:String):Number{
			var time:Number = 0;
			var a:Array = value.split(":");

			if (a.length > 1){
				// Clock format, e.g. "hh:mm:ss"
				time = a[0] * 3600;
				time += a[1] * 60;
				time += Number(a[2]);
			}else{
				// Offset time format, e.g. "1h", "8m", "10s"
				var mul:int = 0;
				switch (value.charAt(value.length-1)){
					case 'h':
						mul = 3600;
					break;
					case 'm':
						mul = 60;
					break;
					case 's':
						mul = 1;
					break;
				}
				if (mul)  time = Number(value.substr(0, value.length-1)) * mul;
				else        time = Number(value);
			}
			return time;
		}
		/**
		 * Creates a random string.
		 *
		 * @param   number  The number to be checked.
		 * @return  Returns the random string.
		 */
		public static function randomString(length:int):String{
			var characters:String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
			var charaArray:Array = characters.split("");
			var randomString:String = "";
			for (var i:int = 0; i < length; i++){
				randomString = randomString + charaArray[Math.floor(Math.random() * charaArray.length)];
			}
			return randomString;
		}
		
	/**
	 * Takes time in seconds and returns a string in a time code
	 * format of hh:mm:ss.  If hours are not present, returns only
	 * mm:ss. For example, passing a value of <code>18750</code> will
	 * return <code>05:12:30</code>, but passing a value of <code>31</code>
	 * will return <code>00:31</code>. So in other words, minutes and seconds
	 * will always be present.
	 */
	public static function formatAsTimeCode(sec:Number):String {
		var h:Number = Math.floor(sec / 3600);
		h = isNaN(h) ? 0 : h;
		
		var m:Number = Math.floor((sec % 3600) / 60);
		m = isNaN(m) ? 0 : m;
		
		var s:Number = Math.floor((sec % 3600) % 60);
		s = isNaN(s) ? 0 : s;
		
		return (h == 0 ? "" : (h < 10 ? "0" + h.toString() + ":" : h.toString() + ":")) + (m < 10 ? "0" + m.toString() : m.toString()) + ":" + (s < 10 ? "0" + s.toString() : s.toString());
	}
	
	}
}


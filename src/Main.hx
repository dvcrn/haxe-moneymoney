import lua.Table;
import RequestHelper;
import JsonHelper;

enum abstract AccountType(String) {
	var AccountTypeGiro = "AccountTypeGiro";
	var AccountTypeSavings = "AccountTypeSavings";
	var AccountTypeFixedTermDeposit = "AccountTypeFixedTermDeposit";
	var AccountTypeLoan = "AccountTypeLoan";
	var AccountTypeCreditCard = "AccountTypeCreditCard";
	var AccountTypePortfolio = "AccountTypePortfolio";
	var AccountTypeOther = "AccountTypeOther";
}

typedef Account = {
	?name:String,
	?owner:String,
	?accountNumber:String,
	?subAccount:String,
	?portfolio:Bool,
	?bankCode:String,
	?currency:String,
	?iban:String,
	?bic:String,
	?balance:Float,
	type:AccountType
}

typedef Transaction = {
	?name:String,
	?accountNumber:String,
	?bankCode:String,
	?amount:Float,
	?currency:String,
	?bookingDate:Int,
	?valueDate:Int,
	?purpose:String,
	?transactionCode:Int,
	?textKeyExtension:Int,
	?purposeCode:String,
	?bookingKey:String,
	?bookingText:String,
	?primanotaNumber:String,
	?batchReference:String,
	?endToEndReference:String,
	?mandateReference:String,
	?creditorId:String,
	?returnReason:String,
	?booked:Bool
}

typedef Security = {
	?name:String,
	?isin:String,
	?securityNumber:String,
	?quantity:Float,
	?currencyOfQuantity:String,
	?purchasePrice:Float,
	?currencyOfPurchasePrice:String,
	?exchangeRateOfPurchasePrice:Float,
	?price:Float,
	?currencyOfPrice:String,
	?exchangeRateOfPrice:Float,
	?amount:Float,
	?originalAmount:Float,
	?currencyOfOriginalAmount:String,
	?market:String,
	?tradeTimestamp:Int
}

class Main {
	@:expose("dosomething")
	static function dosomething() {
		trace("dosomething dosomething");
	}

	@:luaDotMethod
	@:expose("SupportsBank")
	static function SupportsBank(protocol:String, bankCode:String) {
		trace("SupportsBank got called");
		trace(protocol);
		trace(bankCode);

		return bankCode == "HAXE TEST";
	}

	@:luaDotMethod
	@:expose("InitializeSession")
	static function InitializeSession(protocol:String, bankCode:String, username:String, reserved, password:String) {
		trace("InitializeSession got called");
		trace(protocol);
		trace(bankCode);
		trace(username);
		trace(reserved);
		trace(password);
	}

	@:luaDotMethod
	@:expose("ListAccounts")
	static function ListAccounts(knownAccounts) {
		trace("ListAccounts got called");
		trace(knownAccounts);

		var res = RequestHelper.makeRequest("http://www.randomnumberapi.com/api/v1.0/randomnumber", "GET", new Map<String, String>(), null);
		trace("res---");
		trace(res);
		trace("content---");
		trace(res.content);

		trace(JsonHelper.parse(res.content));

		var account:Account = {
			name: "ANA Pay",
			accountNumber: "12345",
			currency: "JPY",
			balance: 12345,
			type: AccountType.AccountTypeCreditCard,
		};

		var results = Table.fromArray([account]);

		trace(results);

		return results;
	}

	@:luaDotMethod
	@:expose("RefreshAccount")
	static function RefreshAccount(account:{
		iban:String,
		bic:String,
		comment:String,
		bankCode:String,
		owner:String,
		attributes:Dynamic,
		subAccount:String,
		currency:String,
		name:String,
		balance:Float,
		portfolio:Bool,
		type:String,
		balanceDate:Float,
		accountNumber:String
	}, since:Float) {
		trace("RefreshAccount got called");
		trace(account);
		trace(since);

		var transactions:Array<Transaction> = [
			{
				name: "Test transaction",
				accountNumber: "1234567890",
				bankCode: "12345",
				amount: 150.0,
				currency: "JPY",
				bookingDate: Std.int(Date.now().getTime()),
				valueDate: Std.int(Date.now().getTime()),
				purpose: "Test purpose",
				transactionCode: 123,
				textKeyExtension: 456,
				purposeCode: "OTHR",
				bookingKey: "Test booking key",
				bookingText: "Test booking text",
				primanotaNumber: "Test primanota number",
				batchReference: "Test batch reference",
				endToEndReference: "Test end to end reference",
				mandateReference: "Test mandate reference",
				creditorId: "Test creditor ID",
				returnReason: "Test return reason",
				booked: true
			}
		];

		trace(transactions);

		return {
			balance: 1234,
			transactions: Table.fromArray(transactions),
		}
	}

	@:luaDotMethod
	@:expose("EndSession")
	static function EndSession() {
		trace("EndSession got called");
	}

	function nonstatic() {
		trace("ooooo");
	}

	static function main() {
		trace("hello world");
		untyped __lua__("
        WebBanking {
            version = 1.0,
            url = 'https://ana.co.jp',
            description = 'Haxe Test',
            services = { 'HAXE TEST' },
        }
        ");

		untyped __lua__("
        function SupportsBank(protocol, bankCode)
            return _hx_exports.SupportsBank(protocol, bankCode)
        end
        ");

		untyped __lua__("
        function InitializeSession(protocol, bankCode, username, reserved, password)
            return _hx_exports.InitializeSession(protocol, bankCode, username, reserved, password)
        end
        ");

		untyped __lua__("
        function RefreshAccount(account, since)
            return _hx_exports.RefreshAccount(account, since)
        end
        ");

		untyped __lua__("
        function ListAccounts(knownAccounts)
            return _hx_exports.ListAccounts(knownAccounts)
        end
        ");

		untyped __lua__("
        function EndSession()
            return _hx_exports.EndSession()
        end
        ");
	}
}

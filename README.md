# Haxe quickstart for MoneyMoney 

Write [MoneyMoney](https://moneymoney-app.com/extensions/) extensions in Haxe

## What is this? 

I ended up building a few MoneyMoney extensions for myself but wanted something nicer to program in that's not Lua. Turns out Haxe can do this pretty well!


## How to use this? 

- Clone this repo
- Edit `src/Main.hx`, implement `SupportsBank`, `InitializeSession`, `ListAccounts`, `RefreshAccount`, `EndSession`
- run `make` to compile Haxe to Lua
- Copy `dist/out.lua` to your MoneyMoney extension folder

## Helpers

- JsonHelper: Use this to parse and stringify JSON within MoneyMoney
- RequestHelper: Use this to make HTTP requests within MoneyMoney
- Storage: Local storage wrapper 

## License

MIT

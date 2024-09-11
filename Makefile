dist/out.lua: src/Main.hx src/JsonHelper.hx src/RequestHelper.hx 
	mkdir -p dist
	haxe --lua dist/out.lua --main Main -D lua-vanilla -D lua-return


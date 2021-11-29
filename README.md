# Instantiatable flexible array implementation with familiar methods for Lua <img src="https://img.shields.io/github/license/stein197/luarray"/> <img src="https://img.shields.io/github/v/tag/stein197/luarray?label=Version"/> <img src="https://img.shields.io/luarocks/v/stein197/luarray"/>
Lua provides only a few methods to work with tables. This package is an attempt to extend Lua's capabilities to work with array-like structures by introducing new `array` type with a bunch of useful and common methods which other programming languages have.

## Installation
Via LuaRocks:
```
luarocks install luarray
```

## Usage
The usage is pretty similar to PHP's arrays as it's shown in the example below:
```lua
local array = require "luarray"
array("a", "b", "c") -- Creates {"a", "b", "c"}
```
The only function takes varargs and wraps them up. But what if you want to wrap tables with arbitrary keys? The ONLY
exception for that case is that if `array` takes only single argument AND it's a table, then the constructor wraps it:
```lua
array({
	a = 1,
	b = 2
}) -- {a = 1, b = 2}
```
You can pass other arrays as well and you'll get what you expect:
```lua
array(array(1)) -- {{1}}
```

## API

> To get more detailed documentation refer to the sources.

## Testing
Install luaunit package:
```
luarocks install luaunit
```

Then run from the console:
```
lua test.lua
```

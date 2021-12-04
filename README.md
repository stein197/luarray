# Instantiatable flexible array implementation with familiar methods for Lua
[![](https://img.shields.io/github/license/stein197/luarray)](LICENSE)
![](https://img.shields.io/github/v/tag/stein197/luarray?label=Version)
[![](https://img.shields.io/luarocks/v/stein197/luarray)](https://luarocks.org/modules/stein197/luarray)
[![](https://img.shields.io/github/size/stein197/luarray/init.lua)](init.lua)

Lua provides only a few methods to work with tables. This package is an attempt to extend Lua's capabilities to work with array-like structures by introducing new `array` type with a bunch of useful and common methods which other programming languages have. All instance methods can be chained instead of using static function call.

## Installation
Via LuaRocks:
```
luarocks install luarray
```

## Usage
Firstly let's begin with differences between two terms used in this package - table and array. Table is an ordinary Lua table while array is a type that is returned by `array()` constructor. The usage is pretty similar to PHP's arrays as it's shown in the example below:
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
You can pass other arrays as well and you'll get what you expect. Note that in this case the result will be different from that was in the previous one:
```lua
array(array(1)) -- {{1}} instead of {1}
```
The constructor wraps only tables without metatables. So if pass some kind of OOP table instance then in won't wrap it:
```lua
local instance = SomeClass:new() -- Let's assume there's a "class" named SomeClass
instance.field1 = "string"
local a = array(1, 2, instance)
a[3] -- Returns untouched instance object instead of wrapped as if it's a plain table
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

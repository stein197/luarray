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

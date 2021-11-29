# Instantiatable flexible array implementation with familiar methods for Lua <img src="https://img.shields.io/github/license/stein197/luarray"/> <img src="https://img.shields.io/github/v/tag/stein197/luarray?label=Version"/> <img src="https://img.shields.io/luarocks/v/stein197/luarray"/>
Lua provides only a few methods to work with tables. This package is an attempt to extend Lua's capabilities to work with array-like structures by introducing new `array` type with a bunch of useful and common methods which other programming languages have.

## Installation
Via LuaRocks:
```
luarocks install luarray
```

## Usage
```lua
local array = require "luarray"
array("a", "b", "c")
```

## API

## Testing
Install luaunit package:
```
luarocks install luaunit
```

Then run from the console:
```
lua test.lua
```

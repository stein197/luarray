# Instantiatable flexible array implementation with familiar methods for Lua
[![](https://img.shields.io/github/license/stein197/luarray)](LICENSE)
![](https://img.shields.io/github/v/tag/stein197/luarray?label=Version)
[![](https://img.shields.io/luarocks/v/stein197/luarray)](https://luarocks.org/modules/stein197/luarray)
[![](https://img.shields.io/github/size/stein197/luarray/init.lua)](init.lua)

![luarray](logo.svg)

Lua provides only a few methods to work with tables. This package is an attempt to extend Lua's capabilities to work with array-like structures by introducing new `array` type with a bunch of useful and common methods which other programming languages have.

## Installation
Via LuaRocks:
```
luarocks install luarray
```
Or directly download and include [init.lua](init.lua) file

## Usage
The module exports only one constructor function. If you ever worked with PHP then the usage will be very familiar:
```lua
local array = require "luarray" -- Require the module
local a = array("a", "b", "c") -- Instantiate an array, like in PHP
a:map(function (i, elt) return elt:upper() end):reverse():join() -- "CBA"
```

## Key features
- Negative indexing where indices are expected
- Object-oriented approach
- `nil` is a regular element
- Methods to work with arrays like with stacks
- Overloaded `[]`, `#`, `..`, `*`, `+` and `-` operators to short a few operations

## API

> To get more detailed documentation refer to the sources doc comments.

## Testing
Install luaunit:
```
luarocks install luaunit
```

Then run `lua test.lua` for Windows or `./lua test.lua` for Linux

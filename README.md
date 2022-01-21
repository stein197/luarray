# Arrays for Lua
[![](https://img.shields.io/github/license/stein197/luarray)](LICENSE)
[![](https://img.shields.io/luarocks/v/stein197/luarray)](https://luarocks.org/modules/stein197/luarray)

![luarray](logo.svg)

Lua provides only a few methods to work with tables. This package is an attempt to extend Lua's capabilities to work with array-like structures by introducing a wrapper with a bunch of useful and common methods which other programming languages have.

## Table of contents
- [Installation](#installation)
- [Usage](#usage)
- [Key features](#key-features)
- [Documentation](#documentation)
- [Testing](#testing)

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
- [Negative indexing](#negative-indexing)
- [Object-oriented approach](#object-oriented-approach)
- [`nil` as an element](#nil-as-an-element)
- [Stack methods](#stack-methods)
- [Overloaded operators](#overloaded-operators)
- [Consistency](#consistency)

### Negative indexing
Methods that accept indexes can also accept negative ones. In such case the counting starts from the end of an array:
```lua
array("a", "b", "c"):slice(-2) -- array("b", "c")
```
It also applies to the index operator:
```lua
array("a", "b", "c")[-1] -- "c"
```

### Object-oriented approach
Each call to `array()` function creates a table with methods that can be chained:
```lua
array("a", "b", "c"):reverse():join() -- "cba"
```

### `nil` as an element
Ordinary lua tables consider nils as a gap, which means that the behaviour of length operator or loops could be confusing at first glance. The constructor and methods consider `nil` as a regular element:
```lua
local a = array("a", nil, "c", nil)
a:len() -- 4
```

### Stack methods
An array could also be used as a stack - the library provides such methods:
```lua
local a = array()
a:addend("a")
a:addend("b")
a:delend()
print(a) -- array("a")
```

### Overloaded operators
The library overloads the next metamethods for arrays:
- `__index()` for indexing
- `__newindex()` for direct assigning
- `__len()` for retrieving length
- `__concat()` for concatenating arrays
- `__pairs()` for usage in `pairs()` function
- `__eq()` for deep comparison between arrays
- `__mul()` for intersecting
- `__add()` for union
- `__sub()` for subtraction

Example:
```lua
local a = array("a")
a = a..array("b") -- array("a", "b")
a[2] -- "b"
a[3] = "c"
print(a == array("a", "b", "c"))
> true
a = a - array("b") -- array("a", "c")
```

### Consistency
Methods that accept closures will pass index and value to them in that order only - the same way as `pairs()` and other functions return key in first place and then the value:
```lua
array():map(function (i, elt) --[[ ... ]] end)
```
Also, methods that operate with array ends are named appropriately: `reduceend`, `addend`, `delstart`, `addstart` and so on.

## Documentation
To get all available API, please refer to [api.md](api.md) or run `node api.js` to generate documentation.
> **NOTE:** Methods that return an array create a new one instead of modifying the current array (for a few exceptions) - the same way as JavaScript or PHP do.

## Testing
Install luaunit:
```
luarocks install luaunit
```

Then run `lua test.lua` on Windows or `./lua test.lua` on Linux

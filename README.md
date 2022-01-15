# Instantiatable flexible array implementation with familiar methods for Lua
[![](https://img.shields.io/github/license/stein197/luarray)](LICENSE)
![](https://img.shields.io/github/v/tag/stein197/luarray?label=Version)
[![](https://img.shields.io/luarocks/v/stein197/luarray)](https://luarocks.org/modules/stein197/luarray)

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
- [Negative indexing](#negative-indexing)
- [Object-oriented approach](#object-oriented-approach)
- [`nil` as an element](#nil-as-an-element)
- [Stack methods](#stack-methods)
- [Overloaded operators](#overloaded-operators)

### Negative indexing
Methods that accept indices can also accept negative ones. In such case the counting starts from the end of an array:
```lua
array("a", "b", "c"):slice(-2) -- array("b", "c")
```
It also applies to index operator:
```lua
array("a", "b", "c")[-1] -- "c"
```

### Object-oriented approach
Instead of calling separate functions on tables, created ones has methods that allow to chain them:
```lua
array("a", "b", "c"):reverse():join() -- "cba"
```

### `nil` as an element
Oridnary lua tables consider nils as a gap, so if a table has nil in the middle and if you'd like to determine it's length, it'll finish at first nil. The library consider `nil` as a regular element which doesn't break a sequence of elements:
```lua
local a = array("a", nil, "c", nil)
a:len() -- 4
```

### Stack methods
An array could be used as a stack - the library provides such methods:
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

## API

> To get more detailed documentation refer to the sources doc comments.

## Testing
Install luaunit:
```
luarocks install luaunit
```

Then run `lua test.lua` for Windows or `./lua test.lua` for Linux

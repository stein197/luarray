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

## Features
- Negative indexing
- Considering `nil` as a regular element
- Methods that return a new array which contain nested arrays keep a reference to the original nested array. If you want method to return deep copy - clone them first with deep flag and then apply the method you want.
- Has methods to work with arrays like with stacks
- Overloaded `[]`, `#`, `..`, `*`, `+` and `-` operators
- Object-oriented approach

## API

> To get more detailed documentation refer to the sources doc comments.

## Testing
Install luaunit package:
```
luarocks install luaunit
```

Then run from the console:
```
lua test.lua
```

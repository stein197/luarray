# API

## Table of contents
- [__add](#__add)
- [__concat](#__concat)
- [__eq](#__eq)
- [__index](#__index)
- [__len](#__len)
- [__mul](#__mul)
- [__newindex](#__newindex)
- [__pairs](#__pairs)
- [__sub](#__sub)
- [addafter](#addafter)
- [addbefore](#addbefore)
- [addend](#addend)
- [addstart](#addstart)
- [chunk](#chunk)
- [clone](#clone)
- [contains](#contains)
- [del](#del)
- [delend](#delend)
- [delstart](#delstart)
- [each](#each)
- [every](#every)
- [filter](#filter)
- [find](#find)
- [first](#first)
- [firstindexof](#firstindexof)
- [flat](#flat)
- [intersect](#intersect)
- [isempty](#isempty)
- [join](#join)
- [last](#last)
- [lastindexof](#lastindexof)
- [len](#len)
- [map](#map)
- [only](#only)
- [padend](#padend)
- [padstart](#padstart)
- [reduceend](#reduceend)
- [reducestart](#reducestart)
- [reverse](#reverse)
- [shuffle](#shuffle)
- [slice](#slice)
- [some](#some)
- [sort](#sort)
- [subtract](#subtract)
- [totable](#totable)
- [uniq](#uniq)
- [unite](#unite)

## __add
Performs union between two arrays. Same as `unite` method. Raises an error if there's an attempt to unite with non array. Preserves an order of elements of the first array.

**Parameters**

`a` `array` - Array to unite with.

**Returns**

`array` - Array that contains elements from both arrays.

```lua
array("a") + array("b") -- array("a", "b")
```

## __concat
Concatenates the array with another one returning a new one. Passing another types will raise an error.

**Parameters**

`a` `array` - Array to concatenate.

**Returns**

`array` - New array which is a result of concatenating the current array with another one.

```lua
array("a")..array("b") -- array("a", "b")
```

## __eq
Overloads `==` operator. Deeply compares arrays.

**Parameters**

`t` `array` - An array to compare with.

**Returns**

`boolean` - `true` if two arrays are deeply equal.

```lua
array("a", array("b")) == array("a", array("b")) -- true
```

## __index
Overloads index access to the array. Works the same way as an accessing an arbitrary table but in addition to that it's also possible to access elements with negative indices. In such cases the counting starts from the end of the. array.

**Generics**

`T` - Type of elements the array contains.

**Parameters**

`i` `number` - An index.

**Returns**

`T` - The element associated with the index.

```lua
array("a", "b", "c")[1] -- "a"
array("a", "b", "c")[-1] -- "c"
```

## __len
Overloads `#` operator. Same as `len()` method.

**Returns**

`number` - The length of the table.

```lua
#array("a") -- 1
```

## __mul
Performs intersection between two arrays. Same as `intersect` method. Raises an error if there's an attempt to intersect with non array. Preserves an order of elements of the first array.

**Parameters**

`a` `array` - Array to intersect with.

**Returns**

`array` - Array with elements that both arrays contain.

```lua
array("a", "b") * array("b", "c") -- array("b")
```

## __newindex
Overloads index assigning. Works the same way as an assigning in arbitrary table but in addition to that it's also possible to assign elements at negative indices. In such cases the counting starts from the end of the array. Does. nothing if there's an attempt to assign at non numeric or 0 index.

**Generics**

`T` - Type of elements the array contains.

**Parameters**

`i` `number` - Index at which to assign the element.

`elt` `T` - Element to assign.

```lua
array("a")[2] = "b" -- array("a", "b")
```

## __pairs
Overloads call to `pairs()` function. Returns an iterator through the entire array including nils.

```lua
for i, v in pairs(array("a", "b", "c")) do
	print(i, v)
end
> 1, "a"
> 2, "b"
> 3, "c"
```

## __sub
Performs subtraction between arrays. Same as `subtract` method. Raises an error if there's an attempt to subtract on/from non array.

**Parameters**

`a` `array` - Array to subtract.

**Returns**

`array` - Array whose elements were subtracted with another one.

```lua
array("a", "b") - array("b") -- array("a")
```

## addafter
Adds an element after specified index. Does nothing if the index is out of bounds.

**Generics**

`T` - Type of elements the array contains.

**Parameters**

`i` `number` - Index after which add the element.

`elt` `T` - An element to add.

```lua
local a = array("a", "b")
a:addafter(2, "c")
a -- array("a", "b", "c")
```

## addbefore
Adds an element before specified index. Does nothing if the index is out of bounds.

**Generics**

`T` - Type of elements the array contains.

**Parameters**

`i` `number` - Index before which add the element.

`elt` `T` - An element to add.

```lua
local a = array("b", "c")
a:addbefore(1, "a")
a -- array("a", "b", "c")
```

## addend
Adds an element to the end of the array.

**Generics**

`T` - Type of elements the array contains.

**Parameters**

`elt` `T` - Element to add.

```lua
local a = array("a", "b")
a:addend("c")
a -- array("a", "b", "c")
```

## addstart
Adds an element to the start of the array shifting all the elements to the end.

**Generics**

`T` - Type of elements the array contains.

**Parameters**

`elt` `T` - Element to add.

```lua
local a = array("b", "c")
a:addstart("a")
a -- array("a", "b", "c")
```

## chunk
Splits the array into chunks of the same size. Raises an error if `size` is less than 1.

**Parameters**

`size` `number` - Size of chunks.

**Returns**

`array` - Chunked array.

```lua
local a = array("a", "b", "c")
a:chunk(2)
a -- array(array("a", "b"), array("c"))
```

## clone
Makes a clone of the table.

**Parameters**

`deep` `boolean` - Nested arrays will be deeply cloned if this element is set to `true`. `false` by default. Other methods that use this method perform a shallow one.

**Returns**

`array` - Cloned array.

```lua
array("a", "b", "c"):clone() -- array("a", "b", "c")
```

## contains
Checks if the array has specified element. Primitive types and arrays are compared by value and others by reference.

**Generics**

`T` - Type of elements the array contains.

**Parameters**

`elt` `T` - Element against which to test.

**Returns**

`boolean` - `true` if the array contains the element.

```lua
array("a", "b", "c"):contains("c") -- true
```

## del
Deletes an element at the specified index shifting rightmost elements to the left.

**Generics**

`T` - Type of elements the array contains.

**Parameters**

`i` `number` - Index at which an element will be deleted.

**Returns**

`T` - Deleted element.

```lua
local a = array("a", "b", "c")
a:del(2)
a -- array("a", "c")
```

## delend
Deletes an element from the end.

**Generics**

`T` - Type of elements the array contains.

**Returns**

`T` - Deleted element.

```lua
local a = array("a", "b", "c")
a:delend() -- "c"
```

## delstart
Deletes an element from the start shifting all elements to the left.

**Generics**

`T` - Type of elements the array contains.

**Returns**

`T` - Deleted element.

```lua
local a = array("a", "b", "c")
a:delstart() -- "a"
```

## each
Applies passed closure to all elements.

**Generics**

`T` - Type of element the array contains.

**Parameters**

`f` `fun(i: number, elt: T)` - Closure.

```lua
array("a", "b", "c"):each(function (i, elt) print(i, elt) end)
```

## every
Checks if every element in the array satisfies the predicate.

**Generics**

`T` - Type of elements the array contains.

**Parameters**

`f` `fun(i: number, elt: T): boolean` - Predicate.

**Returns**

`boolean` - `true` if all elements satisfy the predicate.

```lua
array("a", "b", "c"):every(function (i, elt) return type(elt) == "string" end) -- true
```

## filter
Filters all the elements preserving only those that pass the predicate. Returns a new array.

**Generics**

`T` - Type of elements the array contains.

**Parameters**

`f` `fun(i: number, elt: T): boolean` - Predicate.

**Returns**

`array` - New array containing every element that satisfies the predicate.

```lua
array("a", "b", "c"):filter(function (i, elt) return i % 2 == 0 end) -- array("b")
```

## find
Returns the first entry that satisfies a predicate.

**Generics**

`T` - Type of elements the array contains.

**Parameters**

`f` `fun(i: number, elt: T): boolean` - Predicate.

**Returns**

`number` - Index of the element that satisfies predicate.

`any` - Element that satisfies predicate.

```lua
array("a", "b", "c"):find(function (i, elt) return elt < "c" end) -- "a"
```

## first
Returns the first index and element of the array.

**Generics**

`T` - Type of elements the array contains.

**Returns**

`number` - The first index of the array. -1 if the array is empty.

`T` - The first element of the array. nil if the array is empty.

```lua
array("a", "b", "c"):first() -- 1, "a"
```

## firstindexof
Returns the first index at which the given element can be found.

**Generics**

`T` - Type of elements the array contains.

**Parameters**

`elt` `T` - Element to find.

`i?` `number` - Index at which to start searching. 1 by default.

**Returns**

`number` - First index at which the element found, otherwise -1.

```lua
array("a", "b", "c"):firstindexof("b") -- 2
```

## flat
Flattens the array to the specified depth.

**Parameters**

`depth` `number` - Max depth at which flatten the array. 1 by default.

**Returns**

`array` - Flattened array. Returns the same array when `depth` is 0.

```lua
array("a", "b", array("c")):flat() -- array("a", "b", "c")
```

## intersect
Performs intersection between two arrays. Same as `*` operator. Raises an error if there's an attempt to intersect with non array. Preserves an order of elements of the first array.

**Parameters**

`a` `array` - Array to intersect with.

**Returns**

`array` - Array with elements that both arrays contain.

```lua
array("a", "b"):intersect(array("b", "c")) -- array("b")
```

## isempty
Checks if the array is empty.

**Returns**

`boolean` - `true` if the array does not contain elements.

```lua
array("a", "b", "c"):isempty() -- false
```

## join
Joins all the elements into a string with specified separator.

**Returns**

`string` - Joined string.

```lua
array("a", "b", "c"):join(", ") -- "a, b, c"
```

## last
Returns the last index and element of the array.

**Generics**

`T` - Type of elements the array contains.

**Returns**

`number` - The last index of the array. -1 if the array is empty.

`T` - The last element of the array. nil if the array is empty.

```lua
array("a", "b", "c"):last() -- 3, "c"
```

## lastindexof
Returns the last index at which the given element can be found.

**Generics**

`T` - Type of elements the array contains.

**Parameters**

`elt` `T` - Element to find.

`i?` `number` - Index at which to start searching. #self by default.

**Returns**

`number` - Last index at which the element found, otherwise -1.

```lua
array("a", "b", "c"):lastindexof("b") -- 2
```

## len
Returns length of the table. Same as `#` operator.

**Returns**

`number` - The length of the table.

```lua
array("a", "b", "c"):len() -- 3
```

## map
Applies given function to every element in the array and returns a new one with elements returned by the function.

**Generics**

`T` - Type of element the array contains.

`U` - Type of elements the new array will contain.

**Parameters**

`f` `fun(i: number, elt: T): U` - Function to apply to each element.

**Returns**

`array` - New array.

```lua
array("a", "b", "c"):map(function (i, elt) return elt:upper() end) -- array("A", "B", "C")
```

## only
Returns the only element that distinct from others by any parameter. Could be used for retrieving min or max values.

**Generics**

`T` - Type of elements the array contains.

**Parameters**

`f` `fun(a: T, b: T): T` - Comparison function. Should return the highest element.

**Returns**

`T` - The only element that has the most precedence over others.

```lua
array(1, 10, 50):only(function (a, b) return a > b and a or b end) -- 50
```

## padend
Pads the end of the array with the given element to the specified length.

**Generics**

`T` - Type of elements the array contains.

**Parameters**

`len` `number` - Length to which pad the array.

`elt` `T` - Item to add.

**Returns**

`array` - Padded array.

```lua
array("a", "b", "c"):padend(6, "d") -- array("a", "b", "c", "d", "d", "d")
```

## padstart
Pads the start of the array with the given element to the specified length.

**Generics**

`T` - Type of elements the array contains.

**Parameters**

`len` `number` - Length to which pad the array.

`elt` `T` - Item to add.

**Returns**

`array` - Padded array.

```lua
array("a", "b", "c"):padstart(6, "d") -- array("d", "d", "d", "a", "b", "c")
```

## reduceend
Applies the given function to each element from the end to the start in the array returning an accumulate element.

**Generics**

`T` - Type of element the array contains.

`U` - Type of an accumulated element.

**Parameters**

`f` `fun(rs: U, i: number, elt: T): U` - Function to apply.

`init?` `U` - An element to start with.

**Returns**

`U` - Accumulated element.

```lua
array("a", "b", "c"):reduceend(function (prev, i, elt) return prev..elt end) -- "cba"
```

## reducestart
Applies the given function to each element from the start to the end in the array returning an accumulate element.

**Generics**

`T` - Type of elements the array contains.

`U` - Type of an accumulated element.

**Parameters**

`f` `fun(rs: U, i: number, elt: T): U` - Function to apply.

`init?` `U` - An element to start with.

**Returns**

`U` - Accumulated element.

```lua
array("a", "b", "c"):reducestart(function (prev, i, elt) return prev..elt end) -- "abc"
```

## reverse
Reverses the order of elements in the array.

**Returns**

`array` - Reversed array.

```lua
array("a", "b", "c"):reverse() -- array("c", "b", "c")
```

## shuffle
Shuffles the array.

**Returns**

`array` - Suffled array.

```lua
array("a", "b", "c"):shuffle() -- Could be array("b", "c", "a") for example
```

## slice
Slices a part of the array. Raises an error if the argument `to` is less than `from`.

**Parameters**

`from` `number` - Start index of the sliced array. If negative index is supplied then the real index is calculated relative to the end of the array. 1 by default.

`to` `number` - End index of the sliced array. If negative index is supplied then the real index is calculated relative to the end of the array. #self by default.

**Returns**

`array` - Slice of the array.

```lua
array("a", "b", "c"):slice(-3, 2) -- array("a", "b")
```

## some
Check if at least one element in the array satisfies the predicate.

**Generics**

`T` - Type of elements the array contains.

**Parameters**

`f` `fun(i: number, elt: T): boolean` - Predicate.

**Returns**

`boolean` - `true` if at least one element satisfies the predicate.

```lua
array("a", "b", "c"):some(function (i, elt) return elt == "a" end) -- true
```

## sort
Sorts the array.

**Generics**

`T` - Type of elements the array contains.

**Parameters**

`f?` `fun(a: T, b: T): boolean` - Closure that should return true if `a` should come before `b`.

**Returns**

`array` - Sorted array.

```lua
array("c", "a", "b"):sort() -- array("a", "b", "c")
```

## subtract
Performs subtraction between arrays. Same as `-` operator. Raises an error if there's an attempt to subtract on/from non array.

**Parameters**

`a` `array` - Array to subtract.

**Returns**

`array` - Array whose elements were subtracted with another one.

```lua
array("a", "b"):subtract(array("b") -- array("a")
```

## totable
Converts the array into an ordinary Lua table.

**Parameters**

`deep` `boolean` - Set to `true` for converting nested arrays into table too. `false` by default.

**Returns**

`table` - Table.

```lua
array("a", "b", "c"):totable() -- {"a", "b", "c"}
```

## uniq
Removes duplicates from the array.

**Returns**

`array` - Array without duplicates.

```lua
array("a", "b", "c", "b"):uniq() -- array("a", "b", "c")
```

## unite
Performs union between two arrays. Same as `+` operator. Raises an error if there's an attempt to unite with non array. Preserves an order of elements of the first array.

**Parameters**

`a` `array` - Array to unite with.

**Returns**

`array` - Array that contains elements from both arrays.

```lua
array("a", "b"):unite(array("b", "c")) -- array("a", "b", "c")
```

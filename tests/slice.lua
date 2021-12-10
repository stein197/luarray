TestSlice = {
	["test: array():slice() == {}"] = function () error "Not implemented"end;
	["test: array():slice(0) == {}"] = function () error "Not implemented"end;
	["test: array():slice(0, 0) == {}"] = function () error "Not implemented"end;
	["test: array():slice(0, 1) -> error"] = function () error "Not implemented"end;
	["test: array(\"a\"):slice() == {\"a\"}"] = function () error "Not implemented"end;
	["test: array(\"a\"):slice(0) == {\"a\"}"] = function () error "Not implemented"end;
	["test: array(\"a\"):slice(1) == {\"a\"}"] = function () error "Not implemented"end;
	["test: array(\"a\"):slice(-1) == {\"a\"}"] = function () error "Not implemented"end;
	["test: array(\"a\"):slice(2) -> error"] = function () error "Not implemented"end;
	["test: array(\"a\"):slice(-2) -> error"] = function () error "Not implemented"end;
	["test: array(\"a\"):slice(0, 0) == {}"] = function () error "Not implemented"end;
	["test: array(\"a\"):slice(1, 1) == {\"a\"}"] = function () error "Not implemented"end;
	["test: array(\"a\"):slice(-1, -1) == {\"a\"}"] = function () error "Not implemented"end;
	["test: array(\"a\"):slice(1, -1) == {\"a\"}"] = function () error "Not implemented"end;
	["test: array(\"a\"):slice(-1, 1) == {\"a\"}"] = function () error "Not implemented"end;
	["test: array(\"a\"):slice(2, -2) -> error"] = function () error "Not implemented"end;
	["test: array({{...}}):slice(...) copies the inner array"] = function () error "Not implemented"end;
	["test: array(obj):slice(...) copies only reference"] = function () error "Not implemented"end;
	["test: array(\"a\", \"b\", \"c\", \"d\", \"e\", \"f\"):slice() == {\"a\", \"b\", \"c\", \"d\", \"e\", \"f\"}"] = function () error "Not implemented"end;
	["test: array(\"a\", \"b\", \"c\", \"d\", \"e\", \"f\"):slice(0) == {\"a\", \"b\", \"c\", \"d\", \"e\", \"f\"}"] = function () error "Not implemented"end;
	["test: array(\"a\", \"b\", \"c\", \"d\", \"e\", \"f\"):slice(1) == {\"a\", \"b\", \"c\", \"d\", \"e\", \"f\"}"] = function () error "Not implemented"end;
	["test: array(\"a\", \"b\", \"c\", \"d\", \"e\", \"f\"):slice(3) == {\"c\", \"d\", \"e\", \"f\"}"] = function () error "Not implemented"end;
	["test: array(\"a\", \"b\", \"c\", \"d\", \"e\", \"f\"):slice(-3) == {\"d\", \"e\", \"f\"}"] = function () error "Not implemented"end;
	["test: array(\"a\", \"b\", \"c\", \"d\", \"e\", \"f\"):slice(-8) -> error"] = function () error "Not implemented"end;
	["test: array(\"a\", \"b\", \"c\", \"d\", \"e\", \"f\"):slice(8) -> error"] = function () error "Not implemented"end;
	["test: array(\"a\", \"b\", \"c\", \"d\", \"e\", \"f\"):slice(0, 0) == {}"] = function () error "Not implemented"end;
	["test: array(\"a\", \"b\", \"c\", \"d\", \"e\", \"f\"):slice(1, 4) == {\"a\", \"b\", \"c\", \"d\"}"] = function () error "Not implemented"end;
	["test: array(\"a\", \"b\", \"c\", \"d\", \"e\", \"f\"):slice(-5, 5) == {\"b\", \"c\", \"d\", \"e\"}"] = function () error "Not implemented"end;
	["test: array(\"a\", \"b\", \"c\", \"d\", \"e\", \"f\"):slice(5, 3) -> error"] = function () error "Not implemented"end;
	["test: array(\"a\", \"b\", \"c\", \"d\", \"e\", \"f\"):slice(1, 6) == {\"a\", \"b\", \"c\", \"d\", \"e\", \"f\"}"] = function () error "Not implemented"end;
	["test: array(\"a\", \"b\", \"c\", \"d\", \"e\", \"f\"):slice(-6, -1) == {\"a\", \"b\", \"c\", \"d\", \"e\", \"f\"}"] = function () error "Not implemented"end;
	["test: array(...):slice(...) does not modify the current array"] = function () error "Not implemented"end;
	["test: array(...):slice(...) returns a new array"] = function () error "Not implemented"end;
}
/// @description string_split(string, letter)
/// @param string
/// @param  letter
function string_split(argument0, argument1) {

	var _string = argument0;
	var _letter = argument1;

	var _result = noone;

	var _index = string_pos(_letter, _string);
	var _i = 0;
	while(_index != 0)
	{
	    _result[_i++] = string_copy(_string, 1, _index - 1);
	    _string = string_delete(_string, 1, _index);
	    _index = string_pos(_letter, _string);
	}
	_result[_i] = _string;

	return _result;



}

/// @description error(string)
/// @param string
function error(argument0) {

	var _string = argument0;

	var _t = date_current_datetime();
	var _ts = string(date_get_hour(_t)) + ":" + string(date_get_minute(_t)) + ":" + string(date_get_second(_t));

	if(!is_string(_string))
	    show_error(_ts + "   [" + object_get_name(object_index) + "] -> " + string(_string), true);
	else
	    show_error(_ts + "   [" + object_get_name(object_index) + "] -> " + _string, true);



}

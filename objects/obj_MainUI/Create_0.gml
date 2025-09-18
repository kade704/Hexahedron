/// @description 변수 초기화

TEXT_SIZE = 1.7;
TEXT_SCALE_SMOOTH = 0.1;

Text = "";
TextSize = 1.7;
TextColor = c_white;

showText = function(str, color) {
	Text = str;
	TextColor = color;
	TextSize *= 1.2;
}




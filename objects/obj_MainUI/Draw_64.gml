var halfWidth = window_get_width() / 2;
var halfHeight = window_get_height() / 2; 

draw_set_alpha(1);

// Draw Timeline
draw_set_colour(c_gray);
var songLengthMs = audio_sound_length(obj_MainSystem.Song.sound) * 1000;
var percentage = (current_time - obj_MainSystem.SongStartTime) / songLengthMs;
draw_rectangle(0, 0, window_get_width() * percentage, 10, false);

if (percentage > 1)
{
	draw_set_colour(c_white);
	draw_set_halign(fa_right);
	draw_set_valign(fa_top);
	draw_text_transformed(window_get_width() - 10, 30, "Press ESC to Exit", 1, 1, 0);
}

// Draw Score
draw_set_font(ft_Square);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_colour(c_white);
draw_text_transformed(30, 30, obj_MainSystem.Score, 1, 1, 0);

// Draw Result
if (obj_MainSystem) 
{
	draw_set_valign(fa_middle);
	draw_text_transformed(60, halfHeight - 90, "Perfect: " + string(obj_MainSystem.PerfectCount), 0.8, 0.8, 0);
	draw_text_transformed(60, halfHeight - 30, "Good: " + string(obj_MainSystem.GoodCount), 0.8, 0.8, 0);
	draw_text_transformed(60, halfHeight + 30, "Bad: " + string(obj_MainSystem.BadCount), 0.8, 0.8, 0);
	draw_text_transformed(60, halfHeight + 90, "Miss: " + string(obj_MainSystem.MissCount), 0.8, 0.8, 0);
}

// Draw Main Text
draw_set_colour(TextColor);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_text_transformed(halfWidth, halfHeight - 300, string(Text), TextSize, TextSize, 0);


// Draw Hit Offsets


draw_set_colour(c_red);
draw_rectangle(halfWidth - obj_MainSystem.BAD_WINDOW_MS - 50, window_get_height() - 20, halfWidth + obj_MainSystem.BAD_WINDOW_MS + 50, window_get_height() - 10, false);
draw_set_colour(c_yellow);
draw_rectangle(halfWidth - obj_MainSystem.BAD_WINDOW_MS, window_get_height() - 20, halfWidth + obj_MainSystem.BAD_WINDOW_MS, window_get_height() - 10, false);
draw_set_colour(c_green);
draw_rectangle(halfWidth - obj_MainSystem.GOOD_WINDOW_MS, window_get_height() - 20, halfWidth + obj_MainSystem.GOOD_WINDOW_MS, window_get_height() - 10, false);
draw_set_colour(c_aqua);
draw_rectangle(halfWidth - obj_MainSystem.PERFECT_WINDOW_MS, window_get_height() - 20, halfWidth + obj_MainSystem.PERFECT_WINDOW_MS, window_get_height() - 10, false);

for (var i = 0; i < array_length(obj_MainSystem.HitOffsets); i++) 
{
	var offset = obj_MainSystem.HitOffsets[i];
	var alpha = obj_MainSystem.HitOffsetAlphas[i];
	draw_set_colour(c_white);
	draw_set_alpha(alpha);
	draw_rectangle(halfWidth + offset - 2, window_get_height() - 30, halfWidth + offset + 2, window_get_height(), false);
}
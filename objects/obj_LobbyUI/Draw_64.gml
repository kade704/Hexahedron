/// @description  노래 제목 표시

draw_set_colour(make_colour_rgb(255, 0, 132));
draw_set_font(ft_Square);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var s = string_copy(Text, 1, TextTypingCount + 1);
if(0 < TextTypingCount && TextTypingCount < string_length(Text) - 1) s += chr(random_range(33, 126));
    
draw_text_transformed(window_get_width() / 2, window_get_height() - 150, string_hash_to_newline(s), 1.0, 1.0, 0);

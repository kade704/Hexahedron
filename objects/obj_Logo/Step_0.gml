if (keyboard_check(vk_left)) {
	Position.x -= 5;
}
if (keyboard_check(vk_right)) {
	Position.x += 5;
}
if (keyboard_check(vk_up)) {
	Position.y += 5;
}
if (keyboard_check(vk_down)) {
	Position.y -= 5;
}
if (keyboard_check(vk_add)) {
	Scale.x += 0.1;
	Scale.y += 0.1;
	Scale.z += 0.1;
}
if (keyboard_check(vk_subtract)) {
	Scale.x -= 0.1;
	Scale.y -= 0.1;
	Scale.z -= 0.1;
}
if (keyboard_check(vk_divide)) {
	Rotation = quaternion_multiply(Rotation, quaternion_from_angle_axis(vector3_create(0, 0, 1), 1));
}
	
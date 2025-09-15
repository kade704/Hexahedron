/// @description 카메라 배치

var xAxis = quaternion_vector3_forward(Rotation);
var yAxis = quaternion_vector3_right(Rotation);
var zAxis = quaternion_vector3_up(Rotation);

var xFrom = Position.x - xAxis.x * Scale + yAxis.x * Scale + zAxis.x * Scale;
var yFrom = Position.y - xAxis.y * Scale + yAxis.y * Scale + zAxis.y * Scale;
var zFrom = Position.z - xAxis.z * Scale + yAxis.z * Scale + zAxis.z * Scale;

var xTo = Position.x;
var yTo = Position.y;
var zTo = Position.z;

var xUp = zAxis.x;
var yUp = zAxis.y;
var zUp = zAxis.z;

var aspect = window_get_width() / window_get_height();

d3d_set_projection_ext(xFrom, yFrom, zFrom, xTo, yTo, zTo, xUp, yUp, zUp, 45, aspect, 0.1, 100000);


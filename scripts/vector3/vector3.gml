function vector3_zero() {
	return { x: 0, y: 0, z: 0 }
}

function vector3_one() {
	return { x: 1, y: 1, z: 1 }
}

function vector3_x() {
	return { x: 1, y: 0, z: 0 }
}

function vector3_y() {
	return { x: 0, y: 1, z: 0 }
}

function vector3_z() {
	return { x: 0, y: 0, z: 1 }
}

function vector3_create(x, y, z) {
	return { x: x, y: y, z: z }
}

function vector3_add(v1, v2) {
    return {
        x: v1.x + v2.x,
        y: v1.y + v2.y,
        z: v1.z + v2.z
    };
}

function vector3_subtract(v1, v2) {
    return {
        x: v1.x - v2.x,
        y: v1.y - v2.y,
        z: v1.z - v2.z
    };
}

function vector3_multiply_scalar(v, scalar) {
    return {
        x: v.x * scalar,
        y: v.y * scalar,
        z: v.z * scalar
    };
}

function vector3_divide_scalar(v, scalar) {
    if (scalar == 0) return { x: 0, y: 0, z: 0 };
	
    return {
        x: v.x / scalar,
        y: v.y / scalar,
        z: v.z / scalar
    };
}

function vector3_magnitude(v) {
    return sqrt(sqr(v.x) + sqr(v.y) + sqr(v.z));
}

function vector3_normalize(v) {
    var mag = vector3_magnitude(v);
    if (mag == 0) return { x: 0, y: 0, z: 0 };
	
    return vector3_divide_scalar(v, mag);
}

function vector3_dot_product(v1, v2) {
    return (v1.x * v2.x) + (v1.y * v2.y) + (v1.z * v2.z);
}

function vector3_cross_product(v1, v2) {
    return {
        x: v1.y * v2.z - v1.z * v2.y,
        y: v1.z * v2.x - v1.x * v2.z,
        z: v1.x * v2.y - v1.y * v2.x
    };
}

function vector3_lerp(v1, v2, t) {
	var a = vector3_multiply_scalar(v1, 1.0 - t);
	var b = vector3_multiply_scalar(v2, t);
	return vector3_add(a, b);
}
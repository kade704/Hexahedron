function quaternion_identity() {
	return {x: 0, y: 0, z: 0, w: 1};
}

function quaternion_create(x, y, z, w) {
	return {x, y, z, w};
}

function quaternion_multiply(q1, q2) {
    var res_w = q1.w * q2.w - q1.x * q2.x - q1.y * q2.y - q1.z * q2.z;
    var res_x = q1.w * q2.x + q1.x * q2.w + q1.y * q2.z - q1.z * q2.y;
    var res_y = q1.w * q2.y - q1.x * q2.z + q1.y * q2.w + q1.z * q2.x;
    var res_z = q1.w * q2.z + q1.x * q2.y - q1.y * q2.x + q1.z * q2.w;

    return { x: res_x, y: res_y, z: res_z, w: res_w };
}

function quaternion_normalize(q) {
    var mag_sq = sqr(q.x) + sqr(q.y) + sqr(q.z) + sqr(q.w);
    if (mag_sq > 0) {
        var inv_mag = 1.0 / sqrt(mag_sq);
        return {
            x: q.x * inv_mag,
            y: q.y * inv_mag,
            z: q.z * inv_mag,
            w: q.w * inv_mag
        };
    }
    return quaternion_identity();
}

function quaternion_from_angle_axis(axis, angle) {
	var half_angle = angle * 0.5;
    var s = dsin(half_angle);
    var c = dcos(half_angle);
	
	var len = sqrt(sqr(axis.x) + sqr(axis.y) + sqr(axis.z));
	
	if (len == 0) {
        return { x: 0, y: 0, z: 0, w: 1 };
    }
	
	var inv_len = 1.0 / len;
    var nx = axis.x * inv_len;
    var ny = axis.y * inv_len;
    var nz = axis.z * inv_len;

    var qx = nx * s;
    var qy = ny * s;
    var qz = nz * s;
    var qw = c;

    return { x: qx, y: qy, z: qz, w: qw };
}

function quaternion_from_euler_angle(pitch, yaw, roll) {
	var half_pitch = pitch * 0.5;
    var half_yaw   = yaw   * 0.5;
    var half_roll  = roll  * 0.5;

    var sp = dsin(half_pitch); var cp = dcos(half_pitch);
    var sy = dsin(half_yaw);   var cy = dcos(half_yaw);
    var sr = dsin(half_roll);  var cr = dcos(half_roll);

    var qw = cr * cp * cy + sr * sp * sy;
    var qx = sr * cp * cy - cr * sp * sy;
    var qy = cr * sp * cy + sr * cp * sy;
    var qz = cr * cp * sy - sr * sp * cy;

    return { x: qx, y: qy, z: qz, w: qw };	
}

function quaternion_vector3_multiply(vec, quat) {
    var qx = quat.x;
    var qy = quat.y;
    var qz = quat.z;
    var qw = quat.w;

    var tx = 2 * (qy * vec.z - qz * vec.y);
    var ty = 2 * (qz * vec.x - qx * vec.z);
    var tz = 2 * (qx * vec.y - qy * vec.x);

    var final_x = vec.x + qw * tx + (qy * tz - qz * ty);
    var final_y = vec.y + qw * ty + (qz * tx - qx * tz);
    var final_z = vec.z + qw * tz + (qx * ty - qy * tx);

    return { x: final_x, y: final_y, z: final_z };
}

function quaternion_dot(q1, q2) {
	return q1.x * q2.x + q1.y * q2.y + q1.z * q2.z + q1.w * q2.w;
}

function quaternion_slerp(q1, q2, amount) {
    if (amount <= 0) return q1;
    if (amount >= 1) return q2;
    
    var dot = quaternion_dot(q1, q2);
    
    var q2_temp_x = q2.x;
    var q2_temp_y = q2.y;
    var q2_temp_z = q2.z;
    var q2_temp_w = q2.w;

    if (dot < 0) {
        dot = -dot;
        q2_temp_x = -q2_temp_x;
        q2_temp_y = -q2_temp_y;
        q2_temp_z = -q2_temp_z;
        q2_temp_w = -q2_temp_w;
    }

    var scale0, scale1;

    if (dot > 0.9995) {
        scale0 = 1.0 - amount;
        scale1 = amount;
    } else {
        var omega = arccos(dot);          
        var sin_omega = sin(omega);

        scale0 = sin((1.0 - amount) * omega) / sin_omega;
        scale1 = sin(amount * omega) / sin_omega;
    }

    var res_x = scale0 * q1.x + scale1 * q2_temp_x;
    var res_y = scale0 * q1.y + scale1 * q2_temp_y;
    var res_z = scale0 * q1.z + scale1 * q2_temp_z;
    var res_w = scale0 * q1.w + scale1 * q2_temp_w;
    
    return { x: res_x, y: res_y, z: res_z, w: res_w };
}

function quaternion_vector3_forward(q) {
	return quaternion_vector3_multiply(vector3_x(), q);
}

function quaternion_vector3_right(q) {
	return quaternion_vector3_multiply(vector3_y(), q);
}

function quaternion_vector3_up(q) {
	return quaternion_vector3_multiply(vector3_z(), q);
}
	
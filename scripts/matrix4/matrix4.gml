function matrix4_identity() {
	var res = array_create(16, 0);
	res[0] = 1;
	res[5] = 1;
	res[10] = 1;
	res[15] = 1;
	return res;
}

function matrix4_translation(v) {
    var res = matrix4_identity();
    res[12] = v.x;
    res[13] = v.y;
    res[14] = v.z;
    return res;
}

function matrix4_scale(v) {
    var res = matrix4_identity();
	res[0] = v.x;
	res[5] = v.y;
	res[10] = v.z;
    return res;
}

function matrix4_multiply(m1, m2) {
	var mat = array_create(16, 0);
	
	res[0]  = m1[0] * m2[0] + m1[4] * m2[1] + m1[8] * m2[2]  + m1[12] * m2[3];
    res[1]  = m1[1] * m2[0] + m1[5] * m2[1] + m1[9] * m2[2]  + m1[13] * m2[3];
    res[2]  = m1[2] * m2[0] + m1[6] * m2[1] + m1[10] * m2[2] + m1[14] * m2[3];
    res[3]  = m1[3] * m2[0] + m1[7] * m2[1] + m1[11] * m2[2] + m1[15] * m2[3];

    res[4]  = m1[0] * m2[4] + m1[4] * m2[5] + m1[8] * m2[6]  + m1[12] * m2[7];
    res[5]  = m1[1] * m2[4] + m1[5] * m2[5] + m1[9] * m2[6]  + m1[13] * m2[7];
    res[6]  = m1[2] * m2[4] + m1[6] * m2[5] + m1[10] * m2[6] + m1[14] * m2[7];
    res[7]  = m1[3] * m2[4] + m1[7] * m2[5] + m1[11] * m2[6] + m1[15] * m2[7];

    res[8]  = m1[0] * m2[8] + m1[4] * m2[9] + m1[8] * m2[10] + m1[12] * m2[11];
    res[9]  = m1[1] * m2[8] + m1[5] * m2[9] + m1[9] * m2[10] + m1[13] * m2[11];
    res[10] = m1[2] * m2[8] + m1[6] * m2[9] + m1[10] * m2[10] + m1[14] * m2[11];
    res[11] = m1[3] * m2[8] + m1[7] * m2[9] + m1[11] * m2[10] + m1[15] * m2[11];

    res[12] = m1[0] * m2[12] + m1[4] * m2[13] + m1[8] * m2[14] + m1[12] * m2[15];
    res[13] = m1[1] * m2[12] + m1[5] * m2[13] + m1[9] * m2[14] + m1[13] * m2[15];
    res[14] = m1[2] * m2[12] + m1[6] * m2[13] + m1[10] * m2[14] + m1[14] * m2[15];
    res[15] = m1[3] * m2[12] + m1[7] * m2[13] + m1[11] * m2[14] + m1[15] * m2[15];
	
    return res;	
}

function matrix4_from_quat(quat) {
    var qx = quat.x;
    var qy = quat.y;
    var qz = quat.z;
    var qw = quat.w;

    var x2 = qx * qx;
    var y2 = qy * qy;
    var z2 = qz * qz;
    
    var xy = qx * qy;
    var xz = qx * qz;
    var yz = qy * qz;
    
    var wx = qw * qx;
    var wy = qw * qy;
    var wz = qw * qz;

    var m;
    m[0] = 1.0 - 2.0 * (y2 + z2);
    m[1] = 2.0 * (xy + wz);
    m[2] = 2.0 * (xz - wy);
    m[3] = 0.0;

    m[4] = 2.0 * (xy - wz);
    m[5] = 1.0 - 2.0 * (x2 + z2);
    m[6] = 2.0 * (yz + wx);
    m[7] = 0.0;

    m[8] = 2.0 * (xz + wy);
    m[9] = 2.0 * (yz - wx);
    m[10] = 1.0 - 2.0 * (x2 + y2);
    m[11] = 0.0;

    m[12] = 0.0;
    m[13] = 0.0;
    m[14] = 0.0;
    m[15] = 1.0;

    return m;
}
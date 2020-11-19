// Contains useful math constants, functions, and structures. 

#region global
#macro EPSILON global._EPSILON
#macro e 2.71828
#macro PERMUTATION_TABLE global._PERMUTATION_TABLE
#macro PERMUTATION_TABLE_SIZE array_length(global._PERMUTATION_TABLE)

// Global variables hidden behind macros
global._EPSILON = math_get_epsilon();
global._PERMUTATION_TABLE = [ 151, 160, 137, 91, 90, 15, 131, 13, 201, 95, 96, 53, 194, 233, 7,
225, 140, 36, 103, 30, 69, 142, 8, 99, 37, 240, 21, 10, 23, 190, 6, 148, 247,
120, 234, 75, 0, 26, 197, 62, 94, 252, 219, 203, 117, 35, 11, 32, 57, 177, 33,
88, 237, 149, 56, 87, 174, 20, 125, 136, 171, 168, 68, 175, 74, 165, 71, 134,
139, 48, 27, 166, 77, 146, 158, 231, 83, 111, 229, 122, 60, 211, 133, 230, 220,
105, 92, 41, 55, 46, 245, 40, 244, 102, 143, 54, 65, 25, 63, 161, 1, 216, 80,
73, 209, 76, 132, 187, 208, 89, 18, 169, 200, 196, 135, 130, 116, 188, 159, 86,
164, 100, 109, 198, 173, 186, 3, 64, 52, 217, 226, 250, 124, 123, 5, 202, 38,
147, 118, 126, 255, 82, 85, 212, 207, 206, 59, 227, 47, 16, 58, 17, 182, 189,
28, 42, 223, 183, 170, 213, 119, 248, 152, 2, 44, 154, 163, 70, 221, 153, 101,
155, 167, 43, 172, 9, 129, 22, 39, 253, 19, 98, 108, 110, 79, 113, 224, 232,
178, 185, 112, 104, 218, 246, 97, 228, 251, 34, 242, 193, 238, 210, 144, 12,
191, 179, 162, 241, 81, 51, 145, 235, 249, 14, 239, 107, 49, 192, 214, 31, 181,
199, 106, 157, 184, 84, 204, 176, 115, 121, 50, 45, 127, 4, 150, 254, 138, 236,
205, 93, 222, 114, 67, 29, 24, 72, 243, 141, 128, 195, 78, 66, 215, 61, 156, 180 ];
#endregion

#region structures
///@func vec2(_x, _y)
///@desc Creates a 2-dimensional vector structure.
///@param {real} _x The X component of the vector.
///@param {real} _y The Y component of the vector.
///@returns {vec2} A 2-dimensional vector data structure.
function vec2(_x, _y) constructor {
	x = _x;
	y = _y;
	
	///@func add(v)
	///@desc 2-dimensional vector addition.
	///@param {vec2} v The vector to add.
	function add(v) {
		x += v.x;
		y += v.y;
	}
	
	///@func subtract(v)
	///@desc 2-dimensional vector subtraction.
	///@param {vec2} v The vector to subtract.
	function subtract(v) {
		x -= v.x;
		y -= v.y;
	}
	
	///@func multiply(v)
	///@desc 2-dimensional vector multiplication.
	///@param {vec2} v The vector to multiply by.
	function multiply(v) {
		x *= v.x;
		y *= v.y;
	}
	
	///@func divide(v)
	///@desc 2-dimensional vector division.
	///@param {vec2} v The vector to divide by.
	function divide(v) {
		x /= v.x;
		y /= v.y;
	}
	
	///@func lt(v)
	///@desc Less-than comparison for 2-dimensional vectors.
	///@param {vec2} v The vector to compare.
	///@returns {bool}
	function lt(v) {
		return length() < v.length();
	}
	
	///@func le(v)
	///@desc Less-than or equal-to comparison for 2-dimensional vectors.
	///@param {vec2} v The vector to compare.
	///@returns {bool}
	function le(v) {
		return length() <= v.length();
	}
	
	///@func gt(v)
	///@desc Greater-than comparison for 2-dimensional vectors.
	///@param {vec2} v The vector to compare.
	///@returns {bool}
	function gt(v) {
		return length() > v.length();
	}
	
	///@func ge(v)
	///@desc Greater-than or equal-to comparison for 2-dimensional vectors.
	///@param {vec2} v The vector to compare.
	///@returns {bool}
	function ge(v) {
		return length() >= v.length();
	}
	
	///@func angle()
	///@desc Gets the angle of the vector.
	///@returns {real} The angle of the vector, expressed in degrees.
	function angle() {
		return darctan2(y, x);
	}
	
	///@func angle()
	///@desc Gets the angle of the vector in radians.
	///@returns {real} The angle of the vector, expressed in radians.
	function angle_radians() {
		return arctan2(y, x);
	}
	
	///@func length()
	///@desc Gets the length or magnitude of the vector.
	///@returns {real} The length of the vector.
	function length() {
		return sqrt(x * x + y * y);
	}
	
	///@func dot(v)
	///@desc Gets the dot product of the current and provided vectors.
	///@param {vec2} v 
	///@returns {real}
	function dot(v) {
		return (x * v.x) + (y * v.y);
	}
}

///@func vec2_from_angle_length(_angle, _length)
///@desc Creates a 2-dimensional vector structure.
///@param {real} _angle The angle of the vector in degrees.
///@param {real} _length The length or magnitude of the vector.
///@returns {vec2} A 2-dimensional vector data structure.
function vec2_from_angle_length(_angle, _length) {
	return new vec2(lengthdir_x(_length, _angle), lengthdir_y(_length, _angle))
}

///@func vec3(_x, _y, _z)
///@desc Creates a 3-dimensional vector structure.
///@param {real} _x The X component of the vector.
///@param {real} _y The Y component of the vector.
///@param {real} _z The Z component of the vector.
///@returns {vec3} A 3-dimensional vector data structure.
function vec3(_x, _y, _z) constructor {
	x = _x;
	y = _y;
	z = _z;
	
	///@func add(v)
	///@desc 3-dimensional vector addition.
	///@param {vec3} v The vector to add.
	function add(v) {
		x += v.x;
		y += v.y;
		z += v.z;
	}
	
	///@func subtract(v)
	///@desc 3-dimensional vector subtraction.
	///@param {vec3} v The vector to subtract.
	function subtract(v) {
		x -= v.x;
		y -= v.y;
		z -= v.z;
	}
	
	///@func multiply(v)
	///@desc 3-dimensional vector multiplication.
	///@param {vec3} v The vector to multiply by.
	function multiply(v) {
		x *= v.x;
		y *= v.y;
		z *= v.z;
	}
	
	///@func divide(v)
	///@desc 3-dimensional vector division.
	///@param {vec3} v The vector to divide by.
	function divide(v) {
		x /= v.x;
		y /= v.y;
		z /= v.z;
	}
	
	///@func lt(v)
	///@desc Less-than comparison for 3-dimensional vectors.
	///@param {vec3} v The vector to compare.
	///@returns {bool}
	function lt(v) {
		return length() < v.length();
	}
	
	///@func le(v)
	///@desc Less-than or equal-to comparison for 3-dimensional vectors.
	///@param {vec3} v The vector to compare.
	///@returns {bool}
	function le(v) {
		return length() <= v.length();
	}
	
	///@func gt(v)
	///@desc Greater-than comparison for 3-dimensional vectors.
	///@param {vec3} v The vector to compare.
	///@returns {bool}
	function gt(v) {
		return length() > v.length();
	}
	
	///@func ge(v)
	///@desc Greater-than or equal-to comparison for 3-dimensional vectors.
	///@param {vec3} v The vector to compare.
	///@returns {bool}
	function ge(v) {
		return length() >= v.length();
	}
	
	///@func length()
	///@desc Gets the length or magnitude of the vector.
	///@returns {real} The length of the vector.
	function length() {
		return sqrt(x * x + y * y + z * z);
	}
	
	///@func dot(v)
	///@desc Gets the dot product of the current and provided vectors.
	///@param {vec3} v 
	///@returns {real}
	function dot(v) {
		return (x * v.x) + (y * v.y) + (z * v.z);
	}
	
	///@func pitch()
	///@desc Gets the pitch angle of the vector.
	///@returns {real} The pitch of the vector, expressed in degrees.
	function pitch() {
		return darcsin(-y);
	}
	
	///@func yaw()
	///@desc Gets the yaw angle of the vector.
	///@returns {real} The yaw of the vector, expressed in degrees.
	function yaw() {
		return darctan2(x, z)
	}
	
	///@func pitch_radians()
	///@desc Gets the pitch angle of the vector.
	///@returns {real} The pitch of the vector, expressed in radians.
	function pitch_radians() {
		return arcsin(-y);
	}
	
	///@func yaw_radians()
	///@desc Gets the yaw angle of the vector.
	///@returns {real} The yaw of the vector, expressed in radians.
	function yaw_radians() {
		return arctan2(x, z)
	}
}

///@func vec4(_x, _y, _z, _w)
///@desc Creates a 4-dimensional vector structure.
///@param {real} _x The X component of the vector.
///@param {real} _y The Y component of the vector.
///@param {real} _z The Z component of the vector.
///@param {real} _w The W component of the vector.
///@returns {vec4} A 4-dimensional vector data structure.
function vec4(_x, _y, _z, _w) constructor {
	x = _x;
	y = _y;
	z = _z;
	w = _w;
	
	///@func add(v)
	///@desc 4-dimensional vector addition.
	///@param {vec4} v The vector to add.
	function add(v) {
		x += v.x;
		y += v.y;
		z += v.z;
		w += v.w;
	}
	
	///@func subtract(v)
	///@desc 4-dimensional vector subtraction.
	///@param {vec4} v The vector to subtract.
	function subtract(v) {
		x -= v.x;
		y -= v.y;
		z -= v.z;
		w -= v.w;
	}
	
	///@func multiply(v)
	///@desc 4-dimensional vector multiplication.
	///@param {vec4} v The vector to multiply by.
	function multiply(v) {
		x *= v.x;
		y *= v.y;
		z *= v.z;
		w *= v.w;
	}
	
	///@func divide(v)
	///@desc 4-dimensional vector division.
	///@param {vec4} v The vector to divide by.
	function divide(v) {
		x /= v.x;
		y /= v.y;
		z /= v.z;
		w /= v.w;
	}
	
	///@func lt(v)
	///@desc Less-than comparison for 4-dimensional vectors.
	///@param {vec4} v The vector to compare.
	///@returns {bool}
	function lt(v) {
		return length() < v.length();
	}
	
	///@func le(v)
	///@desc Less-than or equal-to comparison for 4-dimensional vectors.
	///@param {vec4} v The vector to compare.
	///@returns {bool}
	function le(v) {
		return length() <= v.length();
	}
	
	///@func gt(v)
	///@desc Greater-than comparison for 4-dimensional vectors.
	///@param {vec4} v The vector to compare.
	///@returns {bool}
	function gt(v) {
		return length() > v.length();
	}
	
	///@func ge(v)
	///@desc Greater-than or equal-to comparison for 4-dimensional vectors.
	///@param {vec4} v The vector to compare.
	///@returns {bool}
	function ge(v) {
		return length() >= v.length();
	}
	
	///@func length()
	///@desc Gets the length or magnitude of the vector.
	///@returns {real} The length of the vector.
	function length() {
		return sqrt(x * x + y * y + z * z + w * w);
	}
	
	///@func dot(v)
	///@desc Gets the dot product of the current and provided vectors.
	///@param {vec4} v 
	///@returns {real}
	function dot(v) {
		return (x * v.x) + (y * v.y) + (z * v.z) + (w * v.w);
	}
}

#endregion

#region functions
///@func bell(width)
///@desc Returns a random number following a bell-like distribution.
function bell() {
	a = random_range(-1, 1);
	return sigmoid(1 - a * a - 2 * pi * power(abs(a), 0.5));
}

///@func chance(probability)
///@desc Returns true with the probability provided.
///@param {real} percent The probability, between 0 and 1.
///@returns	{bool}	Either true or false.
function chance(probability) {
	return probability >= random(1);
}

///@func gauss(standard_deviation)
///@desc Returns a random number following a normal distribution.
///@param {real} standard_deviation The standard deviation of the distribution.
///@returns {sample} A sample from the normal distribution.
function gauss(standard_deviation) {
	var u, v, s;
	do {
		u = random_range(-1, 1);
		v = random_range(-1, 1);
		s = u * u * v * v;
	} until (s >= 1 || s == 0);
	s = sqrt(-2 * log10(s) / s);
	return u * s * standard_deviation / 2;
}


function noise(n, p) {
	///@func fade(t)
	///@desc Improved Perlin Noise smooth interpolation function.
	///@param {real} t
	///@returns {real} Interpolated value.
	function fade(t) {
		return 6 * power(t, 5) - 15 * power(t, 4) + 10 * power(t, 3);
	}
	
	var seed = random_get_seed();
	n /= p * PERMUTATION_TABLE_SIZE;
	while (n < 0) {
		n += PERMUTATION_TABLE_SIZE;
	}
	var p0 = floor(n);
	var p1 = (p0 + 1);
	var relative_position = n - p0;
	var weight_position = relative_position - 1;
	random_set_seed(PERMUTATION_TABLE[@ p0 mod PERMUTATION_TABLE_SIZE])
	var gradient0 = random_range(-1, 1);
	random_set_seed(PERMUTATION_TABLE[@ p1 mod PERMUTATION_TABLE_SIZE])
	var gradient1 = random_range(-1, 1);
	random_set_seed(seed);
	var weight0 = relative_position;
	var weight1 = weight_position;
	var sample = lerp(gradient0 * weight0, gradient1 * weight1, relative_position);
	return sample;
}

///@func sigmoid(a)
///@desc A sigmoid function that limits most numbers to between 1 and -1.
///@param {real} a An input number.
///@returns {real} A number modified by the sigmoid function.
function sigmoid(a) {
	return 1 / (1 + power(e, -a * e));
}

#endregion

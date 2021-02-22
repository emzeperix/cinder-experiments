#version 150

uniform mat4	ciModelViewProjection;
uniform float   uTime;
uniform float	uResolution;
in vec4			ciPosition;
in vec2			ciTexCoord0;
out vec2		TexCoord0;

// 2D Random
float random (in vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(1.9898,78.233)))
                 * 430758.5453123);
}

// 2D Noise based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
float noise (in vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    // Four corners in 2D of a tile
    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));

    // Smooth Interpolation

    // Cubic Hermine Curve.  Same as SmoothStep()
    vec2 u = f*f*(3.0-2.0*f);
    // u = smoothstep(0.,1.,f);

    // Mix 4 coorners percentages
    return mix(a, b, u.x) +
            (c - a)* u.y * (1.0 - u.x) +
            (d - b) * u.x * u.y;
}


void main()
{
	vec4 pos = ciPosition;
	pos.y = noise(ciTexCoord0 * 3.0 + uTime / 100) / 3.0;
	gl_Position = ciModelViewProjection * pos;
	TexCoord0 = ciTexCoord0;
};
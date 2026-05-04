uniform float wave_sine;
uniform float wave_mag;
uniform float wave_height;
uniform vec2 texsize;
vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
{
	float i = texture_coords.y * texsize.y;
	vec2 coords1 = vec2(max(0.0, min(1.0, texture_coords.x + (sin((i / wave_height) + (wave_sine / 30.0)) * wave_mag) / texsize.x)), max(0.0, min(1.0, texture_coords.y + 0.0)));
	vec2 coords2 = vec2(max(0.0, min(1.0, texture_coords.x - (sin((i / wave_height) + (wave_sine / 30.0)) * wave_mag) / texsize.x)), max(0.0, min(1.0, texture_coords.y + 0.0)));
	vec2 coords3 = vec2(max(0.0, min(1.0, texture_coords.x + (cos((i / wave_height) + (wave_sine / 30.0)) * wave_mag) / texsize.x)), max(0.0, min(1.0, texture_coords.y + 0.0)));
	vec2 coords4 = vec2(max(0.0, min(1.0, texture_coords.x - (cos((i / wave_height) + (wave_sine / 30.0)) * wave_mag) / texsize.x)), max(0.0, min(1.0, texture_coords.y + 0.0)));
	vec4 color1 = Texel(texture, coords1) * color;
	vec4 color2 = Texel(texture, coords2) * color;
	vec4 color3 = Texel(texture, coords3) * color;
	vec4 color4 = Texel(texture, coords4) * color;
	color1 = color1 * 0.25;
	color2 = color2 * 0.25;
	color3 = color3 * 0.25;
	color4 = color4 * 0.25;
	return color1 + color2 + color3 + color4;
}

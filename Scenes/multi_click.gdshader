shader_type canvas_item;
render_mode unshaded;

uniform sampler2D gradient: hint_default_black;
uniform float mix_amount = 1.0;

void fragment() {
	vec4 input_colour = texture(TEXTURE, UV);
	float grayscale_value = dot(input_colour.rgb, vec3(0.229, 0.587, 0.114));
	vec3 sampler_colour = texture(gradient, vec2(grayscale_value, 0.0)).rgb;
	
	COLOR.rgb = mix(input_colour.rgb, sampler_colour, mix_amount);
	COLOR.a = input_colour.a;
}

shader_type canvas_item;

void fragment() {
	vec4 tex_color = texture(TEXTURE, UV);
	COLOR = vec4(vec3(tex_color.r * 1.5, tex_color.g * 1.5, tex_color.b * 1.5), tex_color.a);
}
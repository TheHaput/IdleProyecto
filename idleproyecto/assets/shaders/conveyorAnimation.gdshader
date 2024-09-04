shader_type canvas_item;

uniform float scroll_speed = 1;
uniform float texture_scale = 125;

void fragment() {
    // Calculate the UV offset to create the scrolling effect
    vec2 uv = FRAGCOORD.xy / texture_scale;
    uv.x -= TIME * scroll_speed;
    uv.x = fract(uv.x); // Keep UV within [0,1] to repeat the texture

    COLOR = texture(TEXTURE, uv);
}
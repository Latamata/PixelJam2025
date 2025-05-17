shader_type canvas_item;

uniform float radius : hint_range(0.0, 1.0) = 0.3;
uniform float edge_softness : hint_range(0.001, 0.5) = 0.05;
uniform vec4 color : source_color = vec4(0.2, 1.0, 1.0, 0.5);

void fragment() {
    vec2 uv = (UV - vec2(0.5)) * 2.0; // center at 0,0
    float dist = length(uv);
    float alpha = smoothstep(radius, radius - edge_softness, dist);
    COLOR = vec4(color.rgb, color.a * alpha);
}

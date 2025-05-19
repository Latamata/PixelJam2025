shader_type canvas_item;

uniform vec3 wave_color = vec3(0.0, 0.8, 1.0);
uniform float wave_speed = 1.0; // Speed of the waves
uniform float wave_amplitude = 10.0; // Height of the waves
uniform float wave_frequency = 5.0; // Frequency of the waves

void fragment() {
    vec2 uv = UV;

    // Flip the y-axis (vertical flip)
    uv.y = 1.0 - uv.y;

    // Apply the wave distortion (moving vertically for a side-scroller)
    float wave_distortion = sin(uv.x * wave_frequency + TIME * wave_speed) * wave_amplitude;

    // Distort the y-axis based on the sine wave function
    uv.y += wave_distortion / 100.0;  // Adjust /100.0 to control wave height

    // Get the texture color
    vec4 tex_color = texture(TEXTURE, uv);

    // Apply a blue tint to the water

    tex_color.rgb = wave_color; // Light cyan


    // Optionally apply an alpha gradient (more opacity at the top and less at the bottom)
    tex_color.a *= (1.0 - uv.y);

    // Output the final color
    COLOR = tex_color;
}

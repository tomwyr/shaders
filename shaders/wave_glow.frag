void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;
    
    // Wave along the y axis
    float waveHeight = 0.05;
    float waveFrequency = 0.3;
    float waveSpeed = 1.5;
    
    // Apply wave to the y coordinate
    float waveFrequencyAmp = 10.0;
    float waveStaticValue = uv.x * waveFrequencyAmp * waveFrequency;
    float waveTimeShift = iTime * waveSpeed;
    // Modify current y to change the color intensity along the axis
    //uv.y += waveHeight * sin(waveStaticValue + waveTimeShift);
    
    // Masked wave color
    float waveMask = pow(1.0 - uv.y, 4.0);
    vec3 waveColStaticGradient = uv.xyx + vec3(0, 2, 4);
    vec3 waveCol = 0.5 + 0.5 * cos(waveColStaticGradient + iTime);
    vec3 wave = waveCol * waveMask;

    // Masked glow color
    float glowMask = pow(1.0 - uv.y, 6.0);
	  vec3 glowCol = vec3(1.0, 1.0 - uv.y, 1.0 - uv.y);
    vec3 glow = glowCol * glowMask;
    
    
    // Output to screen
    fragColor = vec4(wave, 1.0);
}

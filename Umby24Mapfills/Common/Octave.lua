function ComputeOctaveNoise(numOctaves, x, y)
    local amplitude = 1
    local frequency = 1
    local sum = 0

    for i = 1, numOctaves do
        sum = sum + perlin:noise(x*frequency, y*frequency, 0) * amplitude
        amplitude = amplitude * 2.0
        frequency = frequency * 0.5
    end

    return sum
end

function ComputeCombinedNoise(numOctaves, x, y)
    local offset = ComputeOctaveNoise(numOctaves, x, y)
    return ComputeOctaveNoise(numOctaves, x+offset, y)
end
System.msgAll(-1, "&6----Octave Noise Reloaded")
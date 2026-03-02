vec4 effect(vec4 colour, Image tex, vec2 tc, vec2 sc)
{
    vec4 base = Texel(tex, tc);

    base.rgb *= 0;

    return base;
}

#ifdef VERTEX
vec4 position(mat4 t, vec4 v)
{
    return t * v;
}
#endif
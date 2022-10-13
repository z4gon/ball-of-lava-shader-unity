Shader "Unlit/3_BallOfLava"
{
    Properties
    {
        _Radius("Radius", Range(0.4, 1.1)) = 0.6
        _Displacement("Displacement", Range(0.1, 1)) = 0.5
        _ColorA("Color A", Color) = (1,1,1,1)
        _ColorB("Color B", Color) = (1,1,0,1)
        _ColorC("Color C", Color) = (1,0,0,1)
        _ColorD("Color D", Color) = (0,0,0,1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "UnityLightingCommon.cginc"
            #include "./shared/SimpleV2F.cginc"
            #include "./shared/PerlinNoise.cginc"

            float _Radius;
            float _Displacement;

            v2f vert (appdata_base v)
            {
                v2f output;

                // calculate position of vertices in a sphere of radius
                float3 normalizedRadialRay = normalize(v.vertex.xyz);
                float4 spherePos = float4(normalizedRadialRay * _Radius, v.vertex.w);

                // displace the vertex given the noise function value
                // use 8x8 grid, with a static time
                float noise = (perlin(v.texcoord, 8, 8, _Time.z) - 0.5) * _Displacement;
                float4 vertexPosition = spherePos * (1 + noise);

                output.vertex = UnityObjectToClipPos(vertexPosition);
                output.position = v.vertex;
                output.uv = v.texcoord;

                return output;
            }

            fixed4 frag (v2f i) : COLOR
            {
                return fixed4(1,1,1,1);
            }
            ENDCG
        }
    }
}

Shader "Unlit/3_BallOfLava"
{
    Properties
    {
        _Displacement("Displacement", Range(0.01, 0.22)) = 0.1
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

            float _Displacement;

            v2f vert (appdata_base v)
            {
                v2f output;

                // use 8x8 grid, with a changing time to animate the lava
                float perlinNoise = (perlin(v.texcoord, 12, 12, _Time.z) - 0.5) * 2; // from -1.0 to 1.0
                float noise = perlinNoise * _Displacement;
                // displace the vertex given the noise function value
                float3 displacedPos = v.vertex * (1 + noise);
                float4 vertexPosition = float4(displacedPos * 80.0, v.vertex.w);

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

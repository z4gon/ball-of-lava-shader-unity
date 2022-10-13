# Ball of Lava Shader

Ball of Lava Shader implemented with the **Cg** shader programming language for the Built-In RP in **Unity 2021.3.10f1**

### References

- [Learn Unity Shaders from Scratch course by Nik Lever](https://www.udemy.com/course/learn-unity-shaders-from-scratch)

## Shaders

- [Oscillating shape-shifting](#oscillating-shape-shifting)

## Screenshots

---

## Oscillating shape-shifting

1. Calculate a normalized ray vector from the center of the object, to the vertex.
1. Multiply by the desired shpere radius, to shape the intended sphere object.
1. Use `lerp` and a `sin` of `_Time` to oscillate between the cube and sphere shapes.

```c
v2f vert (appdata_base v)
{
      v2f output;

      // calculate position of vertices in a sphere of radius
      float3 normalizedRadialRay = normalize(v.vertex.xyz);
      float4 spherePos = float4(normalizedRadialRay * _Radius, v.vertex.w);

      // oscillate between the two positions
      float delta = (sin(_Time.w) + 1.0) / 2.0;
      float4 oscillatingPos = lerp(v.vertex * 50.0, spherePos, delta);

      output.vertex = UnityObjectToClipPos(oscillatingPos);
      // output.position = v.vertex;
      // output.uv = v.texcoord;

      return output;
}
```

![Gif](./docs/1.gif)

---

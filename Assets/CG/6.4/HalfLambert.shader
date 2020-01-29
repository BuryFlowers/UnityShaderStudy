// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Unity Shaders Book/Chapter 6/Diffuse Half-Lambert"{

	Properties{

		//设置漫反射度标签，名称为Diffuse，类型为颜色，初值为全1
		_Diffuse("Diffuse", Color) = (1,1,1,1)

	}

		SubShader{

			Pass{

		//定义pass在流水线中的角色
		Tags {"LightMode" = "ForwardBase"}

		CGPROGRAM

		#pragma vertex vert
		#pragma fragment frag

		#include "Lighting.cginc"

		//反射度
		fixed4 _Diffuse;

		struct a2v {

			float4 vertex : POSITION;
			float3 normal : NORMAL;

		};

		struct v2f {

			float4 pos : SV_POSITION;
			float3 normal : NORMAL;

		};

		v2f vert(a2v v) {

			v2f o;
			o.pos = UnityObjectToClipPos(v.vertex);
			o.normal = v.normal;

			return o;

		}

		fixed4 frag(v2f i) : SV_Target{

			//环境光参数
			fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT;

		//将模型空间的法线坐标转换为世界空间的法线坐标
		fixed3 worldNormal = normalize(mul(i.normal, (float3x3)unity_WorldToObject));
		//得到世界空间的指向第一个光源的向量坐标（如果有多个光源则不适用）
		fixed3 worldLight = normalize(_WorldSpaceLightPos0.xyz);
		//环境光*漫反射度*法线与指向第一个光源的向量的点积
		fixed3 diffuse = _LightColor0.rgb*_Diffuse.rgb*(0.5*dot(worldNormal, worldLight)+0.5);

		fixed3 color = ambient + diffuse;

		return fixed4(color,1.0);

	}


	ENDCG

}

	}

		Fallback "diffuse"

}
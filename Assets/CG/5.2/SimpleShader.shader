// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Unity Shaders Book/Chapter 5/SimpleShader"{

	Properties{

		//在材质面板中声明Color选项，注意末尾没有引号
		_Color ("Color Tint", Color) = (1.0,1.0,1.0,1.0)

	}

	SubShader{
		
		PASS{

			CGPROGRAM

			#pragma vertex vert
			// 顶点着色器函数名
			#pragma fragment frag
			// 片元着色器函数名

			// 选项Color
			fixed4 _Color;

			struct a2v {

				float4 vertex : POSITION;
				// 顶点的模型空间坐标
				float3 normal : NORMAL;
				// 模型空间的法线方向
				float4 texcoord : TEXCOORD0;
				// 第一套纹理


			};

			// 顶点着色器函数的输出
			struct v2f {

				// 裁剪空间的位置
				float4 pos : POSITION;
				// 颜色
				fixed3 color : COLOR0;


			};

			v2f vert(a2v v){
				
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				// 根据法线方向的不同，决定该点的颜色，两次计算是为了对齐取值范围
				o.color = v.normal*0.5 + fixed3(0.5, 0.5, 0.5);
				return o;

				//转换模型空间到裁剪空间

			}

			fixed4 frag(v2f i) : SV_Target{
				
				fixed3 c = i.color;
			    
			    // 使输出颜色受选项Color控制
				c*=_Color.rgb;
				// i即为vert函数计算返回的o
				return fixed4(c,1.0);

				//输出目标颜色

			}

			ENDCG

		}

	}

}
/*
 * ------------------------------------------------------------
 * "THE BEERWARE LICENSE" (Revision 42):
 * maple <maple@maple.pet> wrote this code. As long as you retain this 
 * notice, you can do whatever you want with this stuff. If we
 * meet someday, and you think this stuff is worth it, you can
 * buy me a beer in return.
 * ------------------------------------------------------------
 */

varying vec2 texcoord;
varying vec2 lmcoord;
varying vec4 color;
varying mat3 TBN;
attribute vec4 at_tangent;

uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;

void main() {
	vec3 normal   = gl_NormalMatrix * gl_Normal;
	vec3 tangent  = gl_NormalMatrix * (at_tangent.xyz / at_tangent.w);
	TBN = mat3(tangent, cross(tangent, normal), normal);
	
	//gl_Position = ftransform();
	//color = gl_Color;

	texcoord = mat2(gl_TextureMatrix[0]) * gl_MultiTexCoord0.st + gl_TextureMatrix[0][3].xy;
	//texcoord = gl_TextureMatrix[0] * gl_MultiTexCoord0;
	vec4 position = gl_ModelViewMatrix * gl_Vertex;
	
	position = gbufferModelViewInverse * position;
	vec3 worldpos = position.xyz;

	position = gbufferModelView * position;
	gl_Position = gl_ProjectionMatrix * position;
	color = gl_Color;
	//texcoord = gl_TextureMatrix[0] * gl_MultiTexCoord0;
	lmcoord = mat2(gl_TextureMatrix[1]) * gl_MultiTexCoord1.st + gl_TextureMatrix[1][3].xy;
	//lmcoord = gl_TextureMatrix[1] * gl_MultiTexCoord1;
	gl_FogFragCoord = gl_Position.z;
}
shader_type spatial;
render_mode blend_mix,depth_draw_opaque,cull_back,diffuse_burley,specular_schlick_ggx,world_vertex_coords;
uniform vec4 albedo : hint_color;
uniform sampler2D texture_albedo : hint_albedo;
uniform float specular;
uniform float metallic;
uniform float roughness : hint_range(0,1);
uniform float point_size : hint_range(0,128);
uniform sampler2D texture_metallic : hint_white;
uniform vec4 metallic_texture_channel;
uniform sampler2D texture_roughness : hint_white;
uniform vec4 roughness_texture_channel;
uniform sampler2D texture_emission : hint_black_albedo;
uniform vec4 emission : hint_color;
uniform float emission_energy;
varying vec3 uv1_triplanar_pos;
uniform float uv1_blend_sharpness;
varying vec3 uv1_power_normal;
uniform vec3 uv1_scale;
uniform vec3 uv1_offset;
uniform vec3 uv2_scale;
uniform vec3 uv2_offset;


void vertex() {
	vec3 VEC_TIME = TIME*vec3(0.001,0.001,0.001)*5.0;
	uv1_power_normal=pow(abs(NORMAL),vec3(uv1_blend_sharpness));
	uv1_power_normal/=dot(uv1_power_normal,vec3(1.0));
	uv1_triplanar_pos = VERTEX * uv1_scale + uv1_offset;
	if ((cos(TIME)>0.0&&(cos(TIME)<0.1))){
		
		uv1_triplanar_pos += VEC_TIME * vec3(1.0,-1.0, 1.0)*3.0*cos(TIME);
		
	}
	if ((cos(TIME)<0.3)&&(cos(TIME)>0.2)){
		uv1_triplanar_pos += VEC_TIME * vec3(1.0,-1.0, 1.0)*6.0*sin(TIME);}
		else
		{
		uv1_triplanar_pos += VEC_TIME * vec3(1.0,-1.0, 1.0)*5.0*tan(TIME);
		}
		
	if ((cos(TIME)<0.4)&&(cos(TIME)>0.3))
		{
		uv1_triplanar_pos += VEC_TIME * vec3(1.0,-1.0, 1.0)*cos(TIME);
		}
		else
		uv1_triplanar_pos += VEC_TIME * vec3(1.0,-1.0, 1.0)*3.0*tan(TIME);
}

vec4 triplanar_texture(sampler2D p_sampler,vec3 p_weights,vec3 p_triplanar_pos) {
	vec4 samp=vec4(0.0);
	samp+= texture(p_sampler,p_triplanar_pos.xy) * p_weights.z;
	samp+= texture(p_sampler,p_triplanar_pos.xz) * p_weights.y;
	samp+= texture(p_sampler,p_triplanar_pos.zy * vec2(-1.0,1.0)) * p_weights.x;
	return samp;
}


void fragment() {
	
	vec4 albedo_tex = triplanar_texture(texture_albedo,uv1_power_normal,uv1_triplanar_pos);
	ALBEDO = albedo.rgb * albedo_tex.rgb;
	float metallic_tex = dot(triplanar_texture(texture_metallic,uv1_power_normal,uv1_triplanar_pos),metallic_texture_channel);
	METALLIC = metallic_tex * metallic;
	float roughness_tex = dot(triplanar_texture(texture_roughness,uv1_power_normal,uv1_triplanar_pos),roughness_texture_channel);
	ROUGHNESS = roughness_tex * roughness;
	SPECULAR = specular;
	vec3 emission_tex = triplanar_texture(texture_emission,uv1_power_normal,uv1_triplanar_pos).rgb;
	EMISSION = (emission.rgb+emission_tex)*emission_energy;
}

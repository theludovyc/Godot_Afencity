extends Node

static func vector2_clamp(vec, pos_min, pos_max):
	vec.x = clamp(vec.x, pos_min, pos_max)
	vec.y = clamp(vec.y, pos_min, pos_max)
	return vec

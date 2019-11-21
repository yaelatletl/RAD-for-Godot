extends Node
var as = AStar.new()

func ASTAR_create(object):
	assert(object is Path)
	if not object is Path:
		print("Object must be a Path!")
	var AstarPath = object.get_curve()
	for  x in AstarPath.get_point_count(): #Get all points in the Curve 3D
		var Point = AstarPath.get_point_position(x) #Get their positions
		as.add_point(x, Point) #Add them to the A* calculation
		if x != 0:
			as.connect_points(x,x-1) #If they are not out of index, connect them
	
func Astar_Move(Position):
	#if it is not on the path, look for the closest point to the path
	var closest = as.get_closest_point_in_segment(Position)
	var clos_point = as.get_closest_point(Position)
	if RAD.vec_distance(translation, closest)<1: 
		while RAD.vec_distance(translation, closest) > 0.2: 
			Spatial_Move_to(closest)
	else:
		
		for point in as.get_point_path(as.get_closest_point(translation), clos_point):
			while RAD.vec_distance(translation, point)>0.3:
				Spatial_Move_to(point)
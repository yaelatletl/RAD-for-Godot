extends Path
class_name AStar_path 
var astar = AStar.new()

func _ready():
	var AstarPath = get_curve()
	for  x in AstarPath.get_point_count(): #Get all points in the Curve 3D
		var Point = AstarPath.get_point_position(x) #Get their positions
		astar.add_point(x, Point) #Add them to the A* calculation
		if x != 0:
			astar.connect_points(x,x-1) #If they are not out of index, connect them
	print(astar.get_points())
	astar.connect_points(0,astar.get_points()[-1])

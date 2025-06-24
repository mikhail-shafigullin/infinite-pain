class_name LevelController
extends Node3D

@export var platforms: Array;
@onready var cylinderMeshInstance: MeshInstance3D = %CylinderMeshWalls;
@onready var player: PlayerController = %Player

var playerHeight = 0;
var playerGeneratedFloors = 0;
var amountOfFloorsGenerated = 5;
var platformAmountGeneratedByFloor: Array[int];
var currentPlatformAmount = 30;
# one floor - 20 m

var arenaRadius;
var floorHeight = 20;
var currentFloor = 0;

var rnd: RandomNumberGenerator;

func _ready():
	if(!platforms || platforms.is_empty()):
		var platformTemplatesLocation = get_node("%PlatformTemplates");
		platforms = platformTemplatesLocation.get_children();
	var cylinderMesh = cylinderMeshInstance.mesh as CylinderMesh;
	arenaRadius = cylinderMesh.bottom_radius;
	
	rnd = RandomNumberGenerator.new();
	if(CheatController.startsFromFloor != 0):
		player.global_position.y = CheatController.startsFromFloor * floorHeight;
	generatePlatformsFromPlayerPosition();
	pass;

func _process(delta):
	if(player.position.y >= floorHeight * (currentFloor + 1)):
		print("Current floor: ", currentFloor);
		currentFloor+=1;
		BpmController.bpm += 5;
		generatePlatformsFromPlayerPosition();
		
	pass;

func generatePlatformsFromPlayerPosition():
	for i in range(playerGeneratedFloors, currentFloor + amountOfFloorsGenerated):
			generatePlatformsForFloor(i);
			playerGeneratedFloors = i;

func generatePlatformsForFloor(floor: int):
	for i in currentPlatformAmount:
		var l = rnd.randf_range(0, arenaRadius);
		var angle = rnd.randf_range(0, 2*PI);
		var x = l * cos(angle);
		var y = floorHeight*floor + rnd.randf_range(0, floorHeight);
		var z = l * sin(angle);
		
		if(floor == 0 && y < 3. && abs(x) < 1 && abs(z) < 1.):
			continue;
			
		
		var platformTemplate: StaticBody3D = platforms.pick_random();
		var platformInstance: StaticBody3D = platformTemplate.duplicate();
		platformInstance.position = Vector3(x, y, z);
		self.add_child(platformInstance)
	pass;
	

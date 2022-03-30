VioletOutskirtsHouseOfMemoriesB1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, VioletOutskirtsHouseOfMemoriesB1FCallback

	def_warp_events
	warp_event  2,  2, VIOLET_OUTSKIRTS_HOUSE_OF_MEMORIES, 1
	warp_event 21,  2, VIOLET_OUTSKIRTS_HOUSE_OF_MEMORIES, 1

	def_coord_events

	def_bg_events

	def_object_events

VioletOutskirtsHouseOfMemoriesB1FCallback:
	special RestartMapMusic
	endcallback
VioletOutskirtsHouseOfMemories_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, HouseOfMemoriesUnderground

	def_warp_events
	warp_event  4,  9, VIOLET_OUTSKIRTS, 2
	warp_event  5,  9, VIOLET_OUTSKIRTS, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event 5,  2, SPRITE_CHANNELER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ChannelerScript, -1
    
	object_const_def

HouseOfMemoriesUnderground:
	endcallback

ChannelerScript:
	jumpthistextfaceplayer
	text "Hello."
	done

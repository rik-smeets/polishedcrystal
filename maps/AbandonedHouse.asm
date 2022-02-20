VioletOutskirtsAbandonedHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, VioletOutskirtsMisdreavusCallback

	def_warp_events
	warp_event  3,  7, VIOLET_OUTSKIRTS, 1
	warp_event  4,  7, VIOLET_OUTSKIRTS, 1
	warp_event  2,  2, SOUL_HOUSE_B1F, 1
	warp_event  3,  2, SOUL_HOUSE_B1F, 1
	warp_event  4,  2, SOUL_HOUSE_B1F, 1
	warp_event  4,  2, SOUL_HOUSE_B1F, 1
	warp_event  6,  1, SOUL_HOUSE_B1F, 1
	warp_event  7,  1, SOUL_HOUSE_B1F, 1

	def_coord_events

	def_bg_events
	bg_event  6,  0, BGEVENT_READ, FamilyPhotoScript
	bg_event  7,  0, BGEVENT_READ, FamilyPhotoScript
	bg_event  3,  1, BGEVENT_READ, FireplaceScript
	bg_event  4,  1, BGEVENT_READ, FireplaceScript
	bg_event  2,  1, BGEVENT_READ, WoodenLogScript
	bg_event 0,  1, BGEVENT_JUMPTEXT, AncientIncenseBurnerText
	bg_event 1,  1, BGEVENT_JUMPTEXT, OldBooksText
	bg_event  5,  1, BGEVENT_JUMPTEXT, WoodenLogText

	def_object_events
	pokemon_event  0, 0, MISDREAVUS, -1, -1, PAL_NPC_PURPLE, -1, EVENT_VIOLET_OUTSKIRTS_HIDDEN_MISDREAVUS_ABANDONED_HOUSE

	object_const_def
	const HIDDEN_MISDREAVUS

VioletOutskirtsMisdreavusCallback:
	disappear HIDDEN_MISDREAVUS
	checkevent EVENT_VIOLET_OUTSKIRTS_MISDREAVUS_SEARCH_STARTED
	iftrue .end
	setevent EVENT_VIOLET_OUTSKIRTS_MISDREAVUS_SEARCH_STARTED
	random 2
	ifequal 1, .set1
	ifequal 2, .set2
.set1
	setevent EVENT_VIOLET_OUTSKIRTS_HIDDEN_MISDREAVUS_FIREPLACE
	setevent EVENT_VIOLET_OUTSKIRTS_HIDDEN_MISDREAVUS_PHOTO
	setevent EVENT_VIOLET_OUTSKIRTS_HIDDEN_MISDREAVUS_WOOD
.set2
	setevent EVENT_VIOLET_OUTSKIRTS_HIDDEN_MISDREAVUS_FIREPLACE
	setevent EVENT_VIOLET_OUTSKIRTS_HIDDEN_MISDREAVUS_PHOTO
	setevent EVENT_VIOLET_OUTSKIRTS_HIDDEN_MISDREAVUS_WOOD
.end
	endcallback

WoodenLogScript:
	showtext WoodenLogText
	checkevent EVENT_VIOLET_OUTSKIRTS_MISDREAVUS_SEARCH_STARTED
	iffalse .done
	checkevent EVENT_VIOLET_OUTSKIRTS_HIDDEN_MISDREAVUS_WOOD
	iffalse .done
	moveobject HIDDEN_MISDREAVUS, 0, 7
	clearevent EVENT_VIOLET_OUTSKIRTS_HIDDEN_MISDREAVUS_WOOD
	sjump MakeMisdreavusAppear
.done
	end

FireplaceScript:
	showtext FireplaceText
	checkevent EVENT_VIOLET_OUTSKIRTS_MISDREAVUS_SEARCH_STARTED
	iffalse .done
	checkevent EVENT_VIOLET_OUTSKIRTS_HIDDEN_MISDREAVUS_FIREPLACE
	iffalse .done
	readvar VAR_XCOORD
	ifequal 3, .move
	moveobject HIDDEN_MISDREAVUS, 4, 1
	sjump .continue
.move
	moveobject HIDDEN_MISDREAVUS, 3, 1
.continue
	clearevent EVENT_VIOLET_OUTSKIRTS_HIDDEN_MISDREAVUS_FIREPLACE
	sjump MakeMisdreavusAppear
.done
	end

FamilyPhotoScript:
	showtext FamilyPhotoText
	checkevent EVENT_VIOLET_OUTSKIRTS_MISDREAVUS_SEARCH_STARTED
	iffalse .done
	checkevent EVENT_VIOLET_OUTSKIRTS_HIDDEN_MISDREAVUS_PHOTO
	iffalse .done
	readvar VAR_XCOORD
	ifequal 6, .move
	moveobject HIDDEN_MISDREAVUS, 7, 0
	sjump .continue
.move
	moveobject HIDDEN_MISDREAVUS, 6, 0
.continue
	clearevent EVENT_VIOLET_OUTSKIRTS_HIDDEN_MISDREAVUS_PHOTO
	sjump MakeMisdreavusAppear
.done
	end

MakeMisdreavusAppear:
	special Special_FadeOutMusic
	pause 20
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeBlackQuickly
	pause 10
	cry MISDREAVUS
	appear HIDDEN_MISDREAVUS
	special UpdateSprites
	pause 15
	special Special_FadeInQuickly
	special RestartMapMusic
	showtext ItsMisdreavusText
	checkevent EVENT_VIOLET_OUTSKIRTS_MISDREAVUS_FIRST_ENCOUNTER
	iffalse .first
	scall IsMisdreavusSearchCompleted
	checkevent EVENT_VIOLET_OUTSKIRTS_MISDREAVUS_SEARCH_COMPLETED
	iftrue .finished
	sjump .disappear
.first
	setevent EVENT_VIOLET_OUTSKIRTS_MISDREAVUS_FIRST_ENCOUNTER
	showemote EMOTE_HAPPY, HIDDEN_MISDREAVUS, 15
	showtext MisdreavusHappyText
.disappear
	special Special_FadeBlackQuickly
	disappear HIDDEN_MISDREAVUS
	cry MISDREAVUS
	pause 15
	special Special_FadeInQuickly
	showtext MisdreavusContinuePlayingText
	end
.finished
	readvar VAR_XCOORD
	ifequal 2, .hole_left_2_2
	ifequal 3, .hole_right_2_2
	ifequal 4, .hole_left_4_2
	ifequal 6, .hole_left_6_0
	changeblock 6, 0, $47 ; hole right below picture on wall
	sjump .falling
	; showemote EMOTE_HEART, HIDDEN_MISDREAVUS, 15
	; showtext MisdreavusFinishedPlayingText
	; cry MISDREAVUS
	; opentext
	; writetext MisdreavusWantToJoinText
	; yesorno
	; iffalse .misdreavus_leaves
	; writetext OnlyOneWayText
	; waitbutton
	; closetext
	; loadwildmon MISDREAVUS, 27
	; startbattle
	; disappear HIDDEN_MISDREAVUS
	; reloadmapafterbattle
	end
.hole_left_2_2
	changeblock 2, 2, $45 ; hole top left
	sjump .falling
.hole_right_2_2
	changeblock 2, 2, $44 ; hole top right
	sjump .falling
.hole_left_4_2
	changeblock 4, 2, $45 ; hole top left
	sjump .falling
.hole_left_6_0
	changeblock 6, 0, $46 ; hole top left below picture on wall
.falling
	special Special_FadeOutMusic
	pause 15
	showemote EMOTE_SHOCK, PLAYER, 15
	playsound SFX_ENTER_DOOR
	waitsfx
	reloadmappart
	pause 15
	applyonemovement PLAYER, skyfall_top
	playsound SFX_KINESIS
	showemote EMOTE_HAPPY, HIDDEN_MISDREAVUS, 30
	pause 15
	warpcheck
	end
.misdreavus_leaves
	closetext
	special Special_FadeBlackQuickly
	disappear HIDDEN_MISDREAVUS
	cry MISDREAVUS
	pause 15
	special Special_FadeInQuickly
	showtext MisdreavusLeftText
	end

IsMisdreavusSearchCompleted:
	checkevent EVENT_VIOLET_OUTSKIRTS_MISDREAVUS_SEARCH_STARTED
	iffalse .done
	checkevent EVENT_VIOLET_OUTSKIRTS_HIDDEN_MISDREAVUS_PHOTO
	iftrue .done
	checkevent EVENT_VIOLET_OUTSKIRTS_HIDDEN_MISDREAVUS_FIREPLACE
	iftrue .done
	checkevent EVENT_VIOLET_OUTSKIRTS_HIDDEN_MISDREAVUS_WOOD
	iftrue .done
	setevent EVENT_VIOLET_OUTSKIRTS_MISDREAVUS_SEARCH_COMPLETED
	end
.done
	end

OnlyOneWayText:
	text "There's only one"
	line "way…"

	para "Time to catch"
	line "it!"
	done

MisdreavusHappyText:
	text "It seems to be"
	line "happy!"
	done

MisdreavusContinuePlayingText:
	text "Looks like it's"
	line "playing hide and"
	cont "seek!"
	done

MisdreavusWantToJoinText:
	text "Oh? Misdreavus"
	line "wants to join"
	cont "your party!"

	para "Will you take"
	line "it with you?"
	done

MisdreavusLeftText:
	text "Misdreavus went"
	line "back into the"
	cont "wild."
	done

MisdreavusFinishedPlayingText:
	text "It seems to be"
	line "very happy!"

	para "All it wanted was"
	line "to have a bit of"
	cont "fun."
	done

FireplaceText:
	text "It's an old fire-"
	line "place."

	para "It hasn't been used"
	line "for a long while."
	done

FamilyPhotoText:
	text "An old photograph"
	line "of a family."

	para "Their eyes seem to"
	line "follow you around…"

	para "It's probably just"
	line "an optical illu-"
	cont "sion."
	done

ItsMisdreavusText:
	text "It's the mischie-"
	line "vous Misdreavus!"
	done

OldBooksText:
	text "Old, dusty books"
	line "line the shelf."

	para "Most are studies"
	line "on Ghost #mon…"
	done

AncientIncenseBurnerText:
	text "It's an incense"
	line "burner."

	para "It looks ancient."
	done

WoodenLogText:
	text "A wooden log lies"
	line "on the floor."
	done
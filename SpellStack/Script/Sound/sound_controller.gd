extends Node

@export var muted: bool = false

func play_music():
	if not muted:
		$Music.play()

func play_win_game():
	if not muted:
		$Music.stop()
		$Win.play()

func play_game_over():
	if not muted:
		$Music.stop()
		$GameOver.play()

func dead_skeleton():
	if not muted:
		$SkeletonGettingHit.play()
		
func dead_Witch():
	if not muted:
		$DeadWitch.play()

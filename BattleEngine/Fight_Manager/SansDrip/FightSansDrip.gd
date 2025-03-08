extends Fight_Manager

# MAKE CUSTOM CUTSCENES AS YOU WISH
var cutscene_counter = 0

func cutscene(box): #YOU CAN CHOOSE WHAT PARAMETERS TO PASS IN
	soul.position = box.position + (box.size / 2)
	match cutscene_counter:
		0:
			$SansDrip1.bubble("Hey kiddo wanna see inside my heart")
			await $SansDrip1.blitter.next
			$SansDrip1/Bubble.visible = false
			
			$SansDrip2.bubble("Yea, inside his big-ass heart")
			await $SansDrip2.blitter.next
			$SansDrip2/Bubble.visible = false
			cutscene_counter += 1
		1:
			$SansDrip1.blitter.skippable = false
			$SansDrip1.bubble("Stop interrupting me")
			await get_tree().create_timer(1).timeout
			$SansDrip1.blitter.freeze()
			$SansDrip1/Bubble.visible = false
			
			$SansDrip2.bubble("Yea, stop interrupting him.")
			await $SansDrip2.blitter.next
			$SansDrip2/Bubble.visible = false
	
	emit_signal("cutscene_end")
	
func attack():
	soul.changeMovement("blue")
	await get_tree().create_timer(5).timeout
#	emit_signal("cutscene_end")

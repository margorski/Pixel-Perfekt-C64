;============================================================
; Updates horizontal position and Sprite Shape number within 
; animation of Sprite#0 - Sprite moves from right to left
;============================================================
 
update_player	    nop
animate_player      dec delay_animation_pointer     
                    bne apply_gravity      
					lda #sprite_animation_delay
					sta delay_animation_pointer
					lda sprite_player_current_frame  ; load current frame number
                    bne dec_player_frame             ; if not progress animation
reset_player_frames lda #sprite_frames_player        ; load number of frames for player
                    sta sprite_player_current_frame  ; store into current frame counter
                    lda #sprite_pointer_player       ; load original sprite shape pinter
                    sta screen_ram + $3f8            ; store in Sprite#0 pointer register
dec_player_frame    inc screen_ram + $3f8            ; increase current pointer position
                    dec sprite_player_current_frame  ; decrease current Frame
                    beq reset_player_frames          ; if current frame is zero, reset					
					
apply_gravity		lda player_state_byte
					and #$0F					
					beq change_direction					
					tay
					and #$08
					bne increase_y_speed
					dey									
					jmp save_y_speed
change_direction	ora #$08
					tay
increase_y_speed	cpy #$0F
					bcs vertical_move
					iny 
save_y_speed		sty player_state_byte				
vertical_move		tya 
					and #$07
					sta $fe
					tya
					and #$08
					bne going_down
going_up			lda $d001
					sec
					sbc $fe
					sta $d001
					jmp horizontal_move
going_down			lda $d001 
					adc $fe
					sta $d001
horizontal_move		nop				 
;check_co					lda $d01f
;					and #1
;					beq exit_update_player
;					dec $d001
exit_update_player  rts                            ; do nothing in this refresh, return
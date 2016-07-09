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
					and #$0f
					beq change_direction
					cmp #$08
					bcs increment_value
decrement_value		tay
					dey
					tya
					and #%00000111
					tay
					jmp save_y_speed
change_direction	ora #$08
increment_value		tay
					iny 
					tya 
					and #%00001111
					tay					
save_y_speed		sty $fe
					lda player_state_byte
					and #$f0
					ora $fe
					sta player_state_byte
vertical_move		tya
					and #$07
					sta $fe
					tya
					and #$08
					bne going_down
going_up			lda $d001
					tay
					sec
					sbc $fe
					sta $d001
					;jsr check_collision
					;beq horizontal_move					
;hit_ceiling			;tya
;					sta $d001
;					lda player_state_byte
;					and #%11111000
;					sta player_state_byte
					jmp horizontal_move
going_down			lda $d001 
					tay
					clc
					adc $fe
					sta $d001
					jsr check_collision
					beq horizontal_move
hit_ground			tya
					sta $d001
					lda player_state_byte
					and #%10111000
					sta player_state_byte
horizontal_move		lda player_state_byte
					and #$30
					beq exit_update_player
					cmp #$30			
					bcc go_right
go_left				dec $d000
					lda $d000
					cmp #$ff					
					bcc not_wrapped_left
					jsr toggle_postion_bit
not_wrapped_left	jsr check_collision
					beq exit_update_player
					inc $d000
					jmp exit_update_player					
go_right			inc $d000
					bne not_wrapped_right
					jsr toggle_postion_bit
not_wrapped_right	jsr check_collision
					beq exit_update_player
					dec $d000
exit_update_player  rts                            ; do nothing in this refresh, return
check_collision		lda $d01f
					and #$01
					rts
toggle_postion_bit  lda $d010
					eor #$01
					sta $d010
					rts					
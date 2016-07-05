;============================================================
; Updates horizontal position and Sprite Shape number within 
; animation of Sprite#0 - Sprite moves from right to left
;============================================================
 
;ship_x_high         lda $d010                      ; load 9th Bit
;                    eor #$01                       ; eor against #$01
;                    sta $d010                      ; store into 9th bit;
;
;update_ship         dec $d000                      ; decrease X-Coord until zero
;                    beq ship_x_high                ; switch 9th Bit of X-Coord

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
apply_gravity		inc $d001
					lda $d01f
					and #1
					beq exit_update_player
					dec $d001
exit_update_player  rts                            ; do nothing in this refresh, return
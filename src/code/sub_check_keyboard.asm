
;===============================
; check for a single key press
;===============================


check_keyboard          lda player_state_byte
						and #$cf 
						sta player_state_byte		
						lda #%11111111  ; CIA#1 Port A set to output 
                        sta ddra             
                        lda #%00000000  ; CIA#1 Port B set to inputt
                        sta ddrb             
            
check_space             lda #%01111111  ; select row 8
                        sta pra 
                        lda prb         ; load column information
                        and #%00010000  ; test 'space' key to exit 
                        bne check_j
jump					lda player_state_byte
						and #%01000000
						bne check_j
						lda player_state_byte
						and #$f0
						ora #$47
						sta player_state_byte			
check_j                 lda #%11101111  ; select row 5
                        sta pra 
                        lda prb         ; load column information
                        and #%00000100  ; test 'j' key  
                        beq left
check_l                 lda #%11011111  ; select row 6
                        sta pra 
                        lda prb         ; load column information
                        and #%00000100  ; test 'l' key 
                        beq right
                        rts             ; return     
left					lda player_state_byte
						and #$cf
						ora #$30
						sta player_state_byte		
						rts
right					lda player_state_byte
						and #$cf
						ora #$10
						sta player_state_byte		
						rts
exit_to_basic           lda #$00
                        sta $d015        ; turn off all sprites
                        jmp $ea81        ; jmp to regular interrupt routine
                        rts
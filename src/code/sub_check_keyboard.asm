
;===============================
; check for a single key press
;===============================


check_keyboard              

                        lda #%11111111  ; CIA#1 Port A set to output 
                        sta ddra             
                        lda #%00000000  ; CIA#1 Port B set to inputt
                        sta ddrb             
            
check_space             lda #%01111111  ; select row 8
                        sta pra 
                        lda prb         ; load column information
                        and #%00010000  ; test 'space' key to exit 
                        beq exit_to_basic

check_d                 lda #%11111011  ; select row 3
                        sta pra 
                        lda prb         ; load column information
                        and #%00000100  ; test 'd' key  
                        beq go_left

check_u                 lda #%11110111  ; select row 4
                        sta pra 
                        lda prb         ; load column information
                        and #%01000000  ; test 'u' key 
                        beq go_right
                        rts             ; return     

go_left                 lda $d000
                        cmp #$00        ; check Y-coord whether we are too high
                        bne left        ; if top of screen reached, skip
						lda #$ff
						sta $d000
						jmp toggle_postion_bit
						rts
left                    dec $d000       ; decrease y-coord for sprite 1
                        rts

go_right                lda $d000       ; increase y-coord for sprite 1
                        cmp #$ff        ; check Y-coord whether whether we are too low
                        bne right       ; if bottom of border was reached, skip
                        lda #$00
						sta $d000
						jmp toggle_postion_bit
						rts
right					inc $d000
                        rts

exit_to_basic           lda #$00
                        sta $d015        ; turn off all sprites
                        jmp $ea81        ; jmp to regular interrupt routine
                        rts
toggle_postion_bit      lda $d010
						eor #$01 
						sta $d010
						rts
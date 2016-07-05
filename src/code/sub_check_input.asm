check_input             lda $dc01	
						and #$01
						bne go_left
check_right				lda $dc01
						and #$08
						bne go_right
check_keyboard          lda #%11111111  ; CIA#1 Port A set to output 
                        sta ddra             
                        lda #%00000000  ; CIA#1 Port B set to inputt
                        sta ddrb             
check_space             lda #%01111111  ; select row 8
                        sta pra 
                        lda prb         ; load column information
                        and #%00010000  ; test 'space' key to exit 
                        beq exit_to_basic
exit_to_basic           lda #$00
                        sta $d015        ; turn off all sprites
                        jmp $ea81        ; jmp to regular interrupt routine
                        rts
go_left					lda $d000
						cmp #$00
						beq skip
						dec $d000
						rts
go_right				lda $d000
						cmp #$ff
						beq skip
						inc $d000
						rts
skip                    rts              ; don't change Y-Coordinate
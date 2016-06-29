;============================================================
; clear screen and turn black
;============================================================

draw_map lda $d018
           ora #$0e       ; set chars location to $3800 for displaying the custom font
           sta $d018      ; Bits 1-3 ($400+512bytes * low nibble value) of $d018 sets char location
                          ; $400 + $200*$0E = $3800
           lda $d016      ; turn off multicolor for characters
           and #$ef       ; by cleaing Bit#4 of $D016
           sta $d016
         ldx #$00     ; start of loop
map_loop         lda address_maps, x    
                 sta $0400,x  ; fill four areas with 250 map maps
				 lda address_maps+$FA, x   
                 sta $04FA,x 
				 lda address_maps+$1F4, x   				 
                 sta $05F4,x 
				 lda address_maps+$2EE, x   
                 sta $06EE,x                  
                 inx        
				 cpx #$fa
                 bne map_loop   
                 rts
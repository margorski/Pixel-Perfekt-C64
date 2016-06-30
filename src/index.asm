;============================================================
;
;	Pixel Perfekt C64
;	 
;============================================================
;    specify output file so all we need to do to build is 
;      to either run 'acme index.asm'
;============================================================

!cpu 6502
!to "build/pixelperfekt.prg",cbm    ; output file

;============================================================
; resourcefiles like character sets, music or sprite shapes
;============================================================

!source "code/config_resources.asm"

;============================================================
; a BASIC loader will help us RUN the intro when loaded
; into the C64 as opposed to manually type SYS50153
;============================================================

* = $0801                               ; BASIC start address (#2049)
!byte $0d,$08,$dc,$07,$9e,$20,$35,$30   ; BASIC loader to start at $c3e9...
!byte $31,$35,$33,$00,$00,$00           ; puts BASIC line 2012 SYS 50153


;============================================================
;  we assemble all our actual 6502 code starting at $c3e9
;============================================================

* = $c3e9     ; start_address were all the assembled 
			  ; code will be consecutively written to

;============================================================
; config files to define and initialize symbols/sprite data 
;============================================================

!source "code/config_symbols.asm"
!source "code/config_sprites.asm"

;============================================================
;  main routine with our custom interrupt
;============================================================
!source "code/main.asm"

;============================================================
; one-time called subroutines
;============================================================

!source "code/sub_clear_screen.asm"
!source "code/sub_draw_map.asm"
;!source "code/sub_write_text.asm"

;============================================================
;    subroutines called repeatly during custom 
;============================================================

!source "code/sub_update_player.asm"
!source "code/sub_check_keyboard.asm"
;!source "code/sub_color_cycle.asm"

;============================================================
; any data like strings of text or tables of information
;============================================================

!source "code/data_text.asm"

;------------------------------------------------------------
;                         THE END                             
;------------------------------------------------------------









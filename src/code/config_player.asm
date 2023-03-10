sprite_player_current_frame	= $fb
delay_animation_pointer     = $fc
player_state_byte			= $fd

sprite_frames_player		= 6
sprite_animation_delay = 6
; the sprite pointer for Sprite#0
sprite_pointer_player		= address_sprites / $40

sprite_background_color = $00
sprite_player_color		= $01

gravity_value = $01

;============================================================
; Initialize Memory Locations not related to VIC-II registers
;============================================================

lda #sprite_animation_delay
sta delay_animation_pointer

; initialize counters with frame numbers
lda #sprite_frames_player
sta sprite_player_current_frame

; store the pointer in the sprite pointer register for Sprite#0
; Sprite Pointers are the last 8 bytes of Screen RAM, e.g. $07f8-$07ff
lda #sprite_pointer_player
sta screen_ram + $3f8 		

lda #0 
sta player_state_byte

;============================================================
; Initialize involved VIC-II registers
;============================================================

lda #$01     ; enable Sprite#0
sta $d015 

lda #$00     ; set single mode for Sprite#0
sta $d01c

lda #$00     ; Sprite#0 has priority over background
sta $d01b

lda #sprite_background_color ; shared background color
sta $d021

lda #sprite_player_color 	 	 ; individual Sprite#0 color
sta $d027

lda #$00     ; set X-Coord high bit (9th Bit) for Sprite#0
sta $d010

lda #$aa 	; set Sprite#0 positions with X/Y coords to
sta $d000   
lda #$a0    ; $d000 corresponds to X-Coord (0-504 incl 9th Bit on PAL systems)
sta $d001   ; $d001 corresponds to Y-Coord (0-255 on PAL systems)





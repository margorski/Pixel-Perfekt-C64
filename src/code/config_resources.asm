; load external binaries

address_sprites = $2000	  ;loading address for ship sprite
address_chars = $3800     ; loading address for charset ($3800: last possible location for the 512bytes in Bank 3)
address_maps = $C000	  ; loading address for map

* = address_sprites                  
!bin "resources/sprites.bin",1024,3  	 ; skip first three bytes which is encoded Color Information
										 ; then load 16x64 Bytes from file
* = address_chars                     
!bin "resources/charset.bin",,0   ; skip first 24 bytes which is CharPad format information 

* = address_maps
!bin "resources/map1.bin",,
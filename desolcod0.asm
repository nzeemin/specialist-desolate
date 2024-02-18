
; Game binary file structure:
; 1. desolcod0.bin from $0000
; 2. desolcoda.zx0 to unpack to $0100
; 3. desolroom.zx0 to unpack to $9000

MirrorTab	EQU 08100h

;----------------------------------------------------------------------------

  org 0000h

  ld sp,$9000

; Unpack desolroom.zx0 to screen
  ld de, DesolateRoomBeg	; from
  ld bc, $9000			; to = screen
  call dzx0

; Move desolcode.zx0 block
  ld hl, DesolateRoomBeg	; from
  ld de, 08200h			; to
  ld bc, DesolateCodePacked	; size
Unpack_1:
  dec hl
  dec de
  ld a,(hl)
  ld (de),a
  dec bc
  ld a,c
  or b
  jp nz, Unpack_1

; Unpack desolcode.zx0 block to Start
  ld de, 08200h - DesolateCodePacked	; from
  ld bc, Start			; to
  call dzx0

; Prepare MirrorTab table, 256 bytes
  ld de,MirrorTab
GenMirrorTab:
  ld h,e
  add hl,hl
  rra       ; 0
  add hl,hl
  rra       ; 1
  add hl,hl
  rra       ; 2
  add hl,hl
  rra       ; 3
  add hl,hl
  rra       ; 4
  add hl,hl
  rra       ; 5
  add hl,hl
  rra       ; 6
  add hl,hl
  rra       ; 7
  ld (de),a
  inc e
  jp nz,GenMirrorTab

  jp Start

;----------------------------------------------------------------------------
; ZX0 decompressor code by Ivan Gorodetsky
; https://github.com/ivagorRetrocomp/DeZX/blob/main/ZX0/8080/OLD_V1/dzx0_CLASSIC.asm
; input:	de=compressed data start
;		bc=uncompressed destination start
; Распаковщик для сжатия ZX0 forward, код для 8080 в мнемонике Z80
dzx0:
		ld hl,0FFFFh
		push hl
		inc hl
		ld a,080h
dzx0_literals:
		call dzx0_elias
		call dzx0_ldir
		jp c,dzx0_new_offset
		call dzx0_elias
dzx0_copy:
		ex de,hl
		ex (sp),hl
		push hl
		add hl,bc
		ex de,hl
		call dzx0_ldir
		ex de,hl
		pop hl
		ex (sp),hl
		ex de,hl
		jp nc,dzx0_literals
dzx0_new_offset:
		call dzx0_elias
		ld h,a
		pop af
		xor a
		sub l
		ret z
		push hl
		rra
		ld h,a
		ld a,(de)
		rra
		ld l,a
		inc de
		ex (sp),hl
		ld a,h
		ld hl,1
		call nc,dzx0_elias_backtrack
		inc hl
		jp dzx0_copy
dzx0_elias:
		inc l
dzx0_elias_loop:
		add a,a
		jp nz,dzx0_elias_skip
		ld a,(de)
		inc de
		rla
dzx0_elias_skip:
		ret c
dzx0_elias_backtrack:
		add hl,hl
		add a,a
		jp nc,dzx0_elias_loop
		jp dzx0_elias
dzx0_ldir:
		push af
dzx0_ldir1:
		ld a,(de)
		ld (bc),a
		inc de
		inc bc
		dec hl
		ld a,h
		or l
		jp nz,dzx0_ldir1
		pop af
		add a,a
		ret

;----------------------------------------------------------------------------

  DS 16
  DEFM "DESOLATE Specialist nzeemin "
  INCLUDE "desolvers.asm"

;----------------------------------------------------------------------------
; desolcode.zx0
  org 0100h
Start:
  org Start
  INCBIN "desolcode.zx0"

DesolateCodePacked EQU DesolateRoomBeg - Start

;----------------------------------------------------------------------------
; desolroom.zx0
DesolateRoomBeg:
  INCBIN "desolroom.zx0"
DesolateRoomEnd:

DesolateRoomPacked EQU DesolateRoomEnd - DesolateRoomBeg

;----------------------------------------------------------------------------

END

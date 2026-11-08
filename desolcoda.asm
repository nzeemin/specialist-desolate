
; Turn on/off cheat codes
CHEAT_SHOW_ROOM_NUMBER  EQU 0
CHEAT_ALL_ACCESS        EQU 0
CHEAT_ALL_INVENTORY     EQU 0
CHEAT_HAVE_WEAPON       EQU 0
CHEAT_HEALTH_999        EQU 0

;----------------------------------------------------------------------------

  org 0x0100

Start:
  ld sp,$9000

;
; Clear the whole screen RAM $9000-$BFFF (it is not cleared by anything else)
  ld sp,$C000
  ld hl,0
  ld a,24
Start_clr1:
  ld b,128
Start_clr2:
  push hl
  push hl
  dec b
  jp nz,Start_clr2
  dec a
  jp nz,Start_clr1
  ld sp,$9000

;
; Draw DESOLATE title sign on top of the screen: unpack the menu image to the shadow screen
; and copy the sign (shadow lines 8..37) to the screen
  call MenuUnpackImage
  call CopyTitleSign
  call ClearShadowScreen

  call LBA07  ; Show titles and go to Menu

; Cheat code to get all door access codes
  IF CHEAT_ALL_ACCESS = 1
  LD HL,LDCA2
  LD B,$48
start_1:
  LD (HL),$01
  INC HL
  dec b
  jp NZ,start_1
  ENDIF

; Cheat code to have all inventory items
  IF CHEAT_ALL_INVENTORY = 1
  LD HL,LDB9C
  LD B,26
start_2:
  LD (HL),$01
  INC HL
  dec b
  jp NZ,start_2
  ENDIF

; Cheat code to have the weapon
  IF CHEAT_HAVE_WEAPON = 1
  ld a,$01
  ld (LDCF7),a
  ENDIF

  IF CHEAT_HEALTH_999 = 1
  ld hl,999
  ld (LDB7A),hl
  ENDIF

;  call LB0A2  ; Inventory
;  call LBBEC  ; Info menu item, show Controls
;  call LBADE  ; New game
;  call LBB7E  ; Game start
;  call LB9A2  ; Player is dead
;  call LBD85  ; Final
;  call LBF6F  ; The End

;  call ShowShadowScreen
;  halt

;  call WaitAnyKey
;  call ClearShadowScreen
;  call ShowShadowScreen

  jp Start

; Compare HL and DE
CpHLDE:
	push hl
	ld a,l
	sbc a,e
	ld l,a
	ld a,h
	sbc a,d
	ld h,a
	jp c,$+7
	or l
	jp $+5
	scf
	pop hl
	ret

SoundLookShoot:
        ld      l, $10
        ld      a, $0B
SoundLookShoot_1:
        ld      c, $D0
        ld      ($0ff03), a
SoundLookShoot_2:
        dec     c
        jp      nz, SoundLookShoot_2
        xor     1
        dec     l
        jp      nz, SoundLookShoot_1
	ret

;----------------------------------------------------------------------------
; dzx0 (ZX0 decompressor) lives in the boot loader, desolcod0.asm; its address is exported
; to desolcod0.inc on the first pass of compiling desolcod0.asm
;   input:  de=compressed data start, bc=uncompressed destination start
  INCLUDE "desolcod0.inc"

DesolateCodeBeg:

; Wait for any key
WaitAnyKey:
  call ReadKeyboard
;  or a
  jp nz,WaitAnyKey	; Wait for unpress
WaitAnyKey_1:
  call ReadKeyboard
;  or a
  jp z,WaitAnyKey_1	; Wait for press
  ret

; Wait until no key pressed - to put after ReadKeyboard calls to prevent double-reads of the same key
WaitKeyUp:
  call ReadKeyboard
;  or a
  jp nz,WaitKeyUp	; Wait for unpress
  ret

; Returns: A=key code, $00 no key; Z=0 for key, Z=1 for no key
; Key codes: Down=$01, Up=$02, Right=$04, Left=$10, Look/shoot=$20, Escape=$40, Switch look/shoot=$80
;            Inventory=$49, Enter=??, Menu=$ff
ReadKeyboard:
	ld  a, $91		; Программируем ППИ КР580ВВ55А
	ld  ($ff03),a		; Порты A и C - на ввод, порт B - на вывод
; Сначала проверяем клавиши Q/M (выход в меню) и I/T/X/B (Inventory)
	ld  a,$f7		; 0 в 3-м бите
	ld  ($ff01),a		; Отправляем 0 в строку матрицы с нужными клавишами
	ld  a,($ff02)		; Встречаем 0 в левой половине клавиатуры
	cpl
	and $09			; Q/M
	jp z,ReadKeyboard_1
	ld a,$ff		; Menu key code
	ret
ReadKeyboard_1:
	ld  a,($ff00)		; Встречаем 0 в правой половине клавиатуры
	cpl
	ld b,a
	and 1			; ЗБ ?
	jp z,ReadKeyboard_2
	ld a,$40		; Excape key code
	ret
ReadKeyboard_2:
	ld a,b
	and $f0			; I/T/X/B
	jp z,ReadKeyboard_3
	ld a,$49		; Inventory key code
	ret
ReadKeyboard_3:
	ld a,b
	and $06			; . ? keys
	jp z,ReadKeyboard_5
	ld a,$80		; Switch key code
	ret
; Теперь получаем все остальные клавиши
ReadKeyboard_5:
	ld  a,$fb
	ld  ($ff01),a		; Отправляем 0 в строку матрицы с нужными клавишами
	ld  a,($ff02)		; Встречаем 0 в левой половине клавиатуры
	cpl
	and $03			; Up/Down
	ld  b,a
	ld  a,($ff00)		; Встречаем 0 в правой половине клавиатуры
	cpl
	and $f4			; Tab/Esc/Space/Left/Right
	or  b
	ret

; Get shadow screen address using penCol in L86D7
;   A = row 0..137
;   (L86D7) = penCol 0..191
; Returns HL = address
; Clock timing: (208-228 on v06c)
GetScreenAddr:
  push de
  ld l,a
  ld h,$00      ; now HL = A
  add hl,hl     ; now HL = A * 2
  ld e,l
  ld d,h        ; now DE = A * 2
  add hl,hl     ; now HL = A * 4
  add hl,de     ; now HL = A * 6
  add hl,hl     ; now HL = A * 12
  add hl,hl     ; now HL = A * 24
  ld de,ShadowScreen
  add hl,de
  ld a,(L86D7)  ; get penCol
  rrca
  rrca
  rrca
  and 00011111b
                ; now A = 8px column
  pop de
    add a,l
    ld l,a      ; now HL = line address + column
  ret nc
  inc h
  ret

; Draw tile with mask 16x16 -> 16x16 on shadow screen - for Tileset2 tiles
;   A = penRow; L86D7 = penCol; HL = tile address
DrawTileMasked:
  ld (SetSP7+1),hl
  ex de,hl      ; now DE = tile address
 	ld hl,0
	add hl,sp
	ld (SetSP8+1),hl
  call GetScreenAddr	; now HL = screen addr
  ld bc,24-1    ; increment to the next line
;	di
SetSP7:
	ld sp,0

	pop de
	ld a,(hl)
	and e
	or d
	ld (hl),a
	inc hl

	pop de
	ld a,(hl)
	and e
	or d
	ld (hl),a
	add hl,bc

	pop de
	ld a,(hl)
	and e
	or d
	ld (hl),a
	inc hl

	pop de
	ld a,(hl)
	and e
	or d
	ld (hl),a
	add hl,bc

	pop de
	ld a,(hl)
	and e
	or d
	ld (hl),a
	inc hl

	pop de
	ld a,(hl)
	and e
	or d
	ld (hl),a
	add hl,bc

	pop de
	ld a,(hl)
	and e
	or d
	ld (hl),a
	inc hl

	pop de
	ld a,(hl)
	and e
	or d
	ld (hl),a
	add hl,bc

	pop de
	ld a,(hl)
	and e
	or d
	ld (hl),a
	inc hl

	pop de
	ld a,(hl)
	and e
	or d
	ld (hl),a
	add hl,bc

	pop de
	ld a,(hl)
	and e
	or d
	ld (hl),a
	inc hl

	pop de
	ld a,(hl)
	and e
	or d
	ld (hl),a
	add hl,bc

	pop de
	ld a,(hl)
	and e
	or d
	ld (hl),a
	inc hl

	pop de
	ld a,(hl)
	and e
	or d
	ld (hl),a
	add hl,bc

	pop de
	ld a,(hl)
	and e
	or d
	ld (hl),a
	inc hl

	pop de
	ld a,(hl)
	and e
	or d
	ld (hl),a
	add hl,bc

	pop de
	ld a,(hl)
	and e
	or d
	ld (hl),a
	inc hl

	pop de
	ld a,(hl)
	and e
	or d
	ld (hl),a
	add hl,bc

	pop de
	ld a,(hl)
	and e
	or d
	ld (hl),a
	inc hl

	pop de
	ld a,(hl)
	and e
	or d
	ld (hl),a
	add hl,bc

	pop de
	ld a,(hl)
	and e
	or d
	ld (hl),a
	inc hl

	pop de
	ld a,(hl)
	and e
	or d
	ld (hl),a
	add hl,bc

	pop de
	ld a,(hl)
	and e
	or d
	ld (hl),a
	inc hl

	pop de
	ld a,(hl)
	and e
	or d
	ld (hl),a
	add hl,bc

	pop de
	ld a,(hl)
	and e
	or d
	ld (hl),a
	inc hl

	pop de
	ld a,(hl)
	and e
	or d
	ld (hl),a
	add hl,bc

	pop de
	ld a,(hl)
	and e
	or d
	ld (hl),a
	inc hl

	pop de
	ld a,(hl)
	and e
	or d
	ld (hl),a
	add hl,bc

	pop de
	ld a,(hl)
	and e
	or d
	ld (hl),a
	inc hl

	pop de
	ld a,(hl)
	and e
	or d
	ld (hl),a
	add hl,bc

	pop de
	ld a,(hl)
	and e
	or d
	ld (hl),a
	inc hl

	pop de
	ld a,(hl)
	and e
	or d
	ld (hl),a

SetSP8:
	ld sp,0
;	ei
  ret

; Draw string  on shadow screen using FontProto
;   HL = string addr
DrawString:
  ld a,(hl)
  inc hl
  or a
  ret z
  push hl
  call DrawChar
  pop hl
  jp DrawString

; Draw character on the screen using FontProto
;   A = character to show: $00-$1F space with A width; $20 space
DrawChar:
  push hl
  push bc
  cp $20        ; $00-$1F ?
  jp c,DrawChar_00  ; yes => set char width and process like space char
  jp nz,DrawChar_0  ; not space char => jump
  ld a,$03      ; space char gap size
DrawChar_00:
  ld (DrawChar_width),a
  jp DrawChar_fin
DrawChar_0:
  cp $27        ; char less than apostroph?
  jp nc,DrawChar_1
  add a,$3A     ; for '!', quotes, '#' '$' '%' '&'
  jp DrawChar_2
DrawChar_1:
  cp $2A        ; char less than '*'?
  jp nc,DrawChar_2
  add a,$15     ; for apostroph, '(' ')' chars
DrawChar_2:
  sub $2C       ; font starts from ','
  ld e,a        ; calculating the symbol address
  ld l,a        ;
  ld h,$00      ;
  ld d,h        ;
  add hl,hl     ; now hl = a * 2
  add hl,hl     ; now hl = a * 4
  add hl,de     ; now hl = a * 5
  add hl,hl     ; now hl = a * 10
  add hl,de     ; now hl = a * 11
  ld de,FontProto
  add hl,de     ; now hl = addr of the symbol
  ex de,hl      ; now de=symbol addr
  ld a,(L86D8)  ; get penRow
  ld (DrawChar_row),a
  ld a,(de)     ; get flag/width byte
  inc de
  or a          ; test for bit 7
;  bit 7,a       ; lowered symbol?
  jp p,DrawChar_3  ; not lowered symbol => skip
  ld hl,DrawChar_row
  inc (hl)      ; start on the next line
DrawChar_3:
  and $0f       ; keep width 1..8
  add a,$02     ; gap 2px after the symbol
  ld (DrawChar_width),a
  ld a,(DrawChar_row)
  call GetScreenAddr
  push hl       ; store addr on the screen
  push de       ; store symbol data addr
  ld a,(L86D7)	; get penCol
  and $07       ; shift 0..7
  inc a
  ld c,a
  ld b,10       ; 10 lines
DrawChar_4:     ; loop by lines
  push bc       ; save counter
  ld a,(de)
  inc de
DrawChar_5:     ; loop for shift
  dec c
  jp z, DrawChar_6
  or a
  rra           ; shift right
  jp DrawChar_5
DrawChar_6:
  or (hl)
  ld (hl),a     ; put on the screen
  ld a,(DrawChar_row)
  inc a
  ld (DrawChar_row),a
  call GetScreenAddr
  pop bc        ; restore counter and shift
  dec b
  jp nz,DrawChar_4
  pop de        ; restore symbol data addr
  pop hl        ; restore addr on the screen
  ld a,(L86D7)  ; get penCol
  and $7        ; shift 0..7
  ld b,a
  ld a,(DrawChar_width)
  add a,b
  cp $08        ; shift + width <= 8 ?
  jp c,DrawChar_fin	; yes => no need for 2nd pass
; Second pass
  ld a,(L86D7)  ; get penCol
  and $07       ; shift 1..7
  ld c,a
  ld a,$09
  sub c         ; a = 9 - shift; result is 2..8
  ld c,a
  ld a,(DrawChar_row)
  add a,-10
  ld (DrawChar_row),a
  inc hl
  ld b,10       ; 10 lines
DrawChar_8:     ; loop by lines
  push bc       ; save counter
  ld a,(de)
  inc de
DrawChar_9:     ; loop for shift
  dec c
  jp z, DrawChar_A
  or a
  rla           ; shift left
  jp DrawChar_9
DrawChar_A:
  or (hl)
  ld (hl),a     ; put on the screen
  ld a,(DrawChar_row)
  inc a
  ld (DrawChar_row),a
  call GetScreenAddr
  inc hl
  pop bc        ; restore counter
  dec b
  jp nz,DrawChar_8
; All done, finalizing
DrawChar_fin:
  ld hl,L86D7   ; penCol address
  ld a,(DrawChar_width)
  add a,(hl)
  ld (hl),a     ; updating penCol
  pop bc
  pop hl
  ret
DrawChar_width:   DB 0    ; Saved symbol width
DrawChar_row0:    DB 0    ; Saved first row number
DrawChar_row:     DB 0    ; Saved current row number

; Draw decimal number HL in 5 digits
DrawNumber5:
	ld	bc,-10000
	call	DrawNumber_1
	ld	bc,-1000
	call	DrawNumber_1
; Draw decimal number HL in 3 digits
DrawNumber3:
	ld	bc,-100
	call	DrawNumber_1
	ld	c,-10
	call	DrawNumber_1
	ld	c,-1
DrawNumber_1:
	ld	a,'0'-1
DrawNumber_2:
	inc	a
  ld (DrawNumber_3+1),hl
	add	hl,bc
	jp	c,DrawNumber_2
DrawNumber_3:
	ld	hl,$0000
	call DrawChar
	ret

;
ScreenThemeNite:
  xor a
  jp ScreenTheme_0
;
ScreenThemeLite:
  ld a,$FF
ScreenTheme_0:
  ld (ScreenTheme),a      ; Save the theme flag
  ld hl,$9B40             ; Screen addresses, top-left
  ld b,128+16             ; lines count
ScreenTheme_1:
  ld c,13                 ; number of column pairs, 26 columns
  push hl                 ; save screen address
ScreenTheme_2:
  ld (hl),a
  inc h
  ld (hl),a
  inc h
  dec c
  jp nz,ScreenTheme_2
  pop hl                  ; restore screen address
  inc l
  dec b
  jp nz,ScreenTheme_1
  ret
ScreenTheme: DB 0	; Screen theme flag: 0=nite, ff=day

; Main Menu image and mask, 192x128 each, in the shadow screen layout (24 bytes per line),
; ZX0-packed in desolmenu.asm. Only one of them can be in the shadow screen at a time.
MenuUnpackImage:
  ld de,MenuImagePacked
  ld bc,ShadowScreen
  jp dzx0

MenuUnpackMask:
  ld de,MenuMaskPacked
  ld bc,ShadowScreen
  jp dzx0

; Copy DESOLATE title from the menu image in the shadow screen to the Specialist screen
CopyTitleSign:
;  di
  ld hl,0
  add hl,sp
  ld (SetSP1+1),hl
  ld hl,$9C18                   ; Vector screen addresses, top-left
  ld sp,ShadowScreen+24*8       ; shadow screen address
  ld a,30                       ; 30 lines
  jp ShowShadowScreen_1

; Main Menu background animation on the Specialist screen, through the mask in the shadow screen.
; The screen already has the menu image; the background is a 16x16 tile $47+phase from Tileset1
; in the cells marked $47 in LF515. Instead of redrawing, toggle the difference between
; the previous and the new phase, only where the mask allows: screen ^= (old ^ new) & mask.
; The first call after MenuBgPrev = 0 draws the whole background (tile 0 is empty).
MenuBgStep:
  ld a,(MenuBgPrev)
  call MenuBgTileAddr           ; HL = previous tile
  push hl
  ld a,(LDC55)                  ; menu background phase 0..7
  add a,$47
  ld (MenuBgPrev),a
  call MenuBgTileAddr           ; HL = new tile
  pop de                        ; DE = previous tile
  ld bc,MenuBgDelta
MenuBgStep_1:
  ld a,(de)
  xor (hl)
  ld (bc),a
  inc hl
  inc de
  inc c
  ld a,c
  cp MenuBgDelta+32 & 255
  jp nz,MenuBgStep_1
; Go through the 96 cells 12 x 8
  ld hl,LF515
  ld (MenuBgMap),hl
  ld a,$48                      ; first screen line of the game window
  ld (MenuBgLine),a
  ld hl,ShadowScreen
  ld (MenuBgMaskRow),hl
  ld a,8
  ld (MenuBgRows),a
MenuBgStep_row:
  ld a,12
  ld (MenuBgCols),a
  ld a,$9C                      ; first screen column of the game window
  ld (MenuBgCol),a
  ld hl,(MenuBgMaskRow)
  ld (MenuBgMask),hl
MenuBgStep_cell:
  ld hl,(MenuBgMap)
  ld a,(hl)
  inc hl
  ld (MenuBgMap),hl
  cp $47
  call z,MenuBgCell
  ld a,(MenuBgCol)
  add a,2
  ld (MenuBgCol),a
  ld hl,(MenuBgMask)
  inc hl
  inc hl
  ld (MenuBgMask),hl
  ld hl,MenuBgCols
  dec (hl)
  jp nz,MenuBgStep_cell
  ld a,(MenuBgLine)
  add a,16
  ld (MenuBgLine),a
  ld hl,(MenuBgMaskRow)
  ld de,16*24
  add hl,de
  ld (MenuBgMaskRow),hl
  ld hl,MenuBgRows
  dec (hl)
  jp nz,MenuBgStep_row
  ret

; A = tile number; returns HL = Tileset1 + A * 32
MenuBgTileAddr:
  ld l,a
  ld h,0
  add hl,hl
  add hl,hl
  add hl,hl
  add hl,hl
  add hl,hl
  ld bc,Tileset1
  add hl,bc
  ret

; Toggle one 16x16 cell: screen column MenuBgCol (+1), lines from MenuBgLine,
; mask in the shadow screen at MenuBgMask (2 bytes per line, 24 bytes between lines)
MenuBgCell:
  ld hl,0
  add hl,sp
  ld (MenuBgSP),hl
  ld sp,MenuBgDelta             ; delta bytes come with POP
  ld a,(MenuBgLine)
  ld c,a
  ld a,(MenuBgCol)
  ld b,a                        ; BC = screen address, left byte
  ld hl,(MenuBgMask)
MenuBgCell_1:
  pop de                        ; E = delta left, D = delta right
  ld a,(hl)
  and e
  ld e,a
  inc hl
  ld a,(hl)
  and d
  ld d,a
  ld a,(bc)
  xor e
  ld (bc),a                      ; left byte
  inc b
  ld a,(bc)
  xor d
  ld (bc),a                      ; right byte
  dec b
  inc c                         ; next line
  ld de,24-1
  add hl,de                     ; next mask line
  ld a,c                        ; cell lines start at $48 + 16 * n
  and 15
  cp $48 & 15
  jp nz,MenuBgCell_1
  ld hl,(MenuBgSP)
  ld sp,hl
  ret

; Variables are placed at the unused end of RAM before the stack (shadow screen ends at $8F20)
MenuBgDelta   EQU $8F20         ; 32 bytes: previous tile XOR new tile
MenuBgPrev    EQU $8F40         ; tile number of the background drawn on the screen, 0 = nothing
MenuBgMap     EQU $8F41         ; DW
MenuBgMask    EQU $8F43         ; DW
MenuBgMaskRow EQU $8F45         ; DW
MenuBgSP      EQU $8F47         ; DW
MenuBgLine    EQU $8F49
MenuBgCol     EQU $8F4B
MenuBgCols    EQU $8F4C
MenuBgRows    EQU $8F4D
ArrowMask     EQU $8F4A         ; $FF >> shift
ArrowEnd      EQU $8F4E         ; line after the last arrow line

; Menu selection arrows are XORed directly onto the Specialist screen (drawing twice erases).
; Left arrow: Tileset3, screen byte column 1, shifted 3 pixels; right arrow: Tileset3+32,
; column 9, shifted 5. The arrow is 8 pixels wide and 10 lines high, lines at LDB8F + $48.
ArrowsToggle:
  ld de,Tileset3
  ld h,$9C+1
  ld c,3
  call ArrowXor
  ld de,Tileset3+32
  ld h,$9C+9
  ld c,5
; DE = tile (2 bytes per line, the first is the pattern), H = screen column address, C = shift
ArrowXor:
  ld a,(LDB8F)                  ; menu Y pos
  add a,$48                     ; first screen line of the game window
  ld l,a
  add a,10
  ld (ArrowEnd),a
  ld a,$FF
  ld b,c
ArrowXor_1:
  or a
  rra
  dec b
  jp nz,ArrowXor_1
  ld (ArrowMask),a              ; $FF >> shift
ArrowXor_2:
  ld a,(de)                     ; pattern
  inc de
  inc de
  ld b,c
ArrowXor_3:
  rrca                          ; rotate right by shift
  dec b
  jp nz,ArrowXor_3
  ld b,a
  ld a,(ArrowMask)
  and b                         ; the part in the first column
  xor (hl)
  ld (hl),a
  inc h
  ld a,(ArrowMask)
  cpl
  and b                         ; the part in the next column
  xor (hl)
  ld (hl),a
  dec h
  inc l                         ; next line
  ld a,(ArrowEnd)
  cp l
  jp nz,ArrowXor_2
  ret

; A = new menu Y pos: erase the arrows, set the new position, draw the arrows, short delay
MenuMoveArrows:
  push af
  call ArrowsToggle
  pop af
  ld (LDB8F),a
  call ArrowsToggle
  ld bc,4200                    ; fixed delay about 0.1 s, does not depend on LDC59 (the game sets 150)
MenuMoveArrows_1:
  dec bc
  ld a,b
  or c
  jp nz,MenuMoveArrows_1
  ret
;
; Copy shadow screen 24*128=3072 bytes to Specialist screen
ShowShadowScreen:
  ld hl,0
  add hl,sp
  ld (SetSP1+1),hl
  ld hl,$9C48                   ; Vector screen addresses, top-left
  ld sp,ShadowScreen            ; shadow screen address
  ld a,(ScreenTheme)
  or a
  jp nz,ShowShadowScreen_2	; Day theme
  ld a,128                      ; 128 lines
ShowShadowScreen_1:             ; loop by A
	pop bc
	ld (hl),c
	inc h
	ld (hl),b
	inc h

	pop bc
	ld (hl),c
	inc h
	ld (hl),b
	inc h

	pop bc
	ld (hl),c
	inc h
	ld (hl),b
	inc h

	pop bc
	ld (hl),c
	inc h
	ld (hl),b
	inc h

	pop bc
	ld (hl),c
	inc h
	ld (hl),b
	inc h

	pop bc
	ld (hl),c
	inc h
	ld (hl),b
	inc h

	pop bc
	ld (hl),c
	inc h
	ld (hl),b
	inc h

	pop bc
	ld (hl),c
	inc h
	ld (hl),b
	inc h

	pop bc
	ld (hl),c
	inc h
	ld (hl),b
	inc h

	pop bc
	ld (hl),c
	inc h
	ld (hl),b
	inc h

	pop bc
	ld (hl),c
	inc h
	ld (hl),b
	inc h

	pop bc
	ld (hl),c
	inc h
	ld (hl),b

	ld bc,0E901h
	add hl,bc

  dec a                         ; loop counter for line pairs
  jp nz,ShowShadowScreen_1      ; continue the loop
SetSP1:
	ld sp,0
  ret
ShowShadowScreen_2
  ld e,128                      ; 128 lines
ShowShadowScreen_3:             ; loop by A
	pop bc
	ld a,c
	cpl
	ld (hl),a
	inc h
	ld a,b
	cpl
	ld (hl),a
	inc h

	pop bc
	ld a,c
	cpl
	ld (hl),a
	inc h
	ld a,b
	cpl
	ld (hl),a
	inc h

	pop bc
	ld a,c
	cpl
	ld (hl),a
	inc h
	ld a,b
	cpl
	ld (hl),a
	inc h

	pop bc
	ld a,c
	cpl
	ld (hl),a
	inc h
	ld a,b
	cpl
	ld (hl),a
	inc h

	pop bc
	ld a,c
	cpl
	ld (hl),a
	inc h
	ld a,b
	cpl
	ld (hl),a
	inc h

	pop bc
	ld a,c
	cpl
	ld (hl),a
	inc h
	ld a,b
	cpl
	ld (hl),a
	inc h

	pop bc
	ld a,c
	cpl
	ld (hl),a
	inc h
	ld a,b
	cpl
	ld (hl),a
	inc h

	pop bc
	ld a,c
	cpl
	ld (hl),a
	inc h
	ld a,b
	cpl
	ld (hl),a
	inc h

	pop bc
	ld a,c
	cpl
	ld (hl),a
	inc h
	ld a,b
	cpl
	ld (hl),a
	inc h

	pop bc
	ld a,c
	cpl
	ld (hl),a
	inc h
	ld a,b
	cpl
	ld (hl),a
	inc h

	pop bc
	ld a,c
	cpl
	ld (hl),a
	inc h
	ld a,b
	cpl
	ld (hl),a
	inc h

	pop bc
	ld a,c
	cpl
	ld (hl),a
	inc h
	ld a,b
	cpl
	ld (hl),a

	ld bc,0E901h
	add hl,bc

  dec e                         ; loop counter for line pairs
  jp nz,ShowShadowScreen_3      ; continue the loop
  jp SetSP1

; Clear block on the shadow screen
;   HL=row/col, DE=rows/cols
;   columns are 8px wide; rows=1..128, row=0..127; col=0..23, cols=1..24
ClearScreenBlock:
  push bc
  ld a,l    ; column
  ld c,h    ; row
  ld l,h    ; row
  ld h,$00
  ld b,h
  add hl,hl               ; now HL = row * 2
  add hl,bc               ; now HL = row * 3
  add hl,hl
  add hl,hl
  add hl,hl               ; now HL = row * 24
  ld c,a
  add hl,bc               ; now HL = row * 24 + col
  ld bc,ShadowScreen
  add hl,bc               ; now HL = start address
  ld c,24                 ; line width in columns
  xor a
;  ld a,$01   ;DEBUG
ClearScreenBlock_1        ; loop by rows
  push hl
  ld b,e    ; cols
ClearScreenBlock_2:       ; loop by columns
  ld (hl),a
  inc hl
  dec b
  jp nz,ClearScreenBlock_2
  pop hl
  add hl,bc               ; next line
  dec d     ; rows
  jp nz,ClearScreenBlock_1
  pop bc
  ret

;Inputs:
;   (seed1) contains a 16-bit seed value
;   (seed2) contains a NON-ZERO 16-bit seed value
;Outputs:
;   HL is the result
;   BC is the result of the LCG, so not that great of quality
;   DE is preserved
;Destroys:
;   AF
;cycle: 4,294,901,760 (almost 4.3 billion)
; https://wikiti.brandonw.net/index.php?title=Z80_Routines:Math:Random#Combined_LFSR.2FLCG.2C_16-bit_seeds
Random16:
    ld hl,(Random16_seed1)
    ld b,h
    ld c,l
    add hl,hl
    add hl,hl
    inc l
    add hl,bc
    ld (Random16_seed1),hl
    ld hl,(Random16_seed2)
    add hl,hl
    sbc a,a
    and %00101101
    xor l
    ld l,a
    ld (Random16_seed2),hl
    add hl,bc
    ret
Random16_seed1: dw 12345
Random16_seed2: dw 54321

GetRandomByte:
  push bc
  call Random16
  pop bc
  ld a,h
  xor l
  ret
;
; Get random number 0..7
GetRandom8:
  call GetRandomByte
  rra
  rra
  and $07
  ret
;
; Get random number 0..10 for door access codes
; value 10 is for '-' char and we made its probability lower by 1/3
GetRandom11:
  call GetRandomByte
  rra
  and $1F                 ; 0..31
GetRandom11_1:
  cp 11                   ; less than 11?
  ret c                   ; yes => return 0..10
  sub 11                  ; 0..20, then 0..9
  jp GetRandom11_1

;----------------------------------------------------------------------------

  INCLUDE "desolcodb.asm"

;----------------------------------------------------------------------------

DesolateFontBeg:
  INCLUDE "desolfont.asm"

DesolateStrsBeg:
  INCLUDE "desolstrs.asm"

DesolateDataBeg:
  INCLUDE "desoldata.asm"

;----------------------------------------------------------------------------
DesolateDataEnd:

IF DesolateDataEnd > 08100h
  .ERROR DesolateDataEnd overlaps $8100
ENDIF

MirrorTab    EQU 08100h

; Shadow screen, 192 x 140 pixels
;   12*2*(64*2+12) = 3360 bytes
ShadowScreen EQU 08200h

;----------------------------------------------------------------------------

END

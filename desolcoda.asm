
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
; Draw DESOLATE title sign on top of the screen
; LDBF5 buffer already pre-filled with 3 lines of the title screen with the big DESOLATE sign
  LD HL,LDBF5
  call LB177              ; Display screen from tiles with Tileset2
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

; Copy DEDSOLATE title from Main Menu shadow screen to Vector screen
CopyTitleSign:
;  di
  ld hl,0
  add hl,sp
  ld (SetSP1+1),hl
  ld hl,$9C18                   ; Vector screen addresses, top-left
  ld sp,ShadowScreen+24*8            ; shadow screen address
  ld a,30                      ; 30 lines
  jp ShowShadowScreen_1
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

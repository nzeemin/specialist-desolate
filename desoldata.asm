;
DesolateVarsBeg:
;
; Variables
;
L86D7:  DEFB $00          ; penCol
L86D8:  DEFB $00          ; penRow
;
LDB73:  DEFB $00          ; ?? $00 $01
;LDB74:  DEFB $0C          ; Line width in tiles
LDB75:  DEFB $00          ; Player Direction/orientation: $00 down, $01 up, $02 left, $03 right
LDB76:  DEFB $06          ; X coord in tiles: $01 $06 $0A INC/DEC
LDB77:  DEFB $30          ; Y coord/line on the screen: 0..127
LDB78:  DEFB $03          ; Y coord in tiles: $03 $06 INC/DEC
LDB79:  DEFB $00          ; Room number
LDB7A:  DEFW $0064        ; Health; initially $64
LDB7C:  DEFB $00          ; ??
LDB7D:  DEFB $00          ; Look/shoot switch: $00 look, $01 shoot
LDB7E:  DEFB $00          ; Alien X coord ??
LDB7F:  DEFB $00          ; Alien Y coord ??
LDB80:  DEFB $00          ; Alien Y tile coord ??
LDB81:  DEFB $00          ; Alien type: $02
LDB82:  DEFB $00          ; Alien: $01 = we already have an alien in the room
LDB83:  DEFB $00          ; Alien tile phase
LDB84:  DEFB $02          ; Alien $01 = alive, $00 = dead
LDB85:  DEFB $03          ; Alien health: $03, then DEC to $00
LDB86:  DEFB $00          ; Alien direction/orientation: $00 down, $01 up, $02 left, $03 right
LDB87:  DEFB $00          ; Alien position within the room, calculated in LB6ED
LDB88:  DEFB $00          ; Bullet X coord in tiles
LDB89:  DEFB $00          ; Bullet Y coord/line on the screen
LDB8A:  DEFB $00          ; Bullet Y coord in tiles
LDB8B:  DEFB $00          ; Bullet Direction/orientation: $00 down, $01 up, $02 left, $03 right
LDB8C:  DEFB $00          ; shooting flag ??
LDB8D:  DEFB $00          ; $01 = shooting in process, bullet in the air
;  DEFB $00
LDB8F:  DEFB $3A          ; Menu Y pos: $3A $46 $52 $5E $6A
LDB90:                    ; Flags about performed progress
  DEFB $00
  DEFB $00                ; +$01: $01 = the Generator is working
  DEFB $00                ; +$02: $01 = the Workstation is working
  DEFB $00
  DEFB $00                ; +$04: $01 = Life-Support System is working
  DEFB $00                ; +$05: $01 = Evacuation Deck re-pressurised
  DEFB $00                ; +$06: $01 = Guidance System working
  DEFB $00
  DEFB $00,$00,$00,$00
LDB9C:                    ; Inventory items: $00 = not having, $01 = have it
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00
LDBC3:  DEFW $0000        ; Player Deaths count
LDBC5:  DEFW $0000        ; Enemies Killed count
LDBC7:  DEFB $00          ; Items Found count
LDBF4:  DEFB $00          ; Counter of achievements on the Stats screen
;
; Screen/room buffer, 12 * 8 = 96 bytes
LDBF5:
  DEFB $2E,$2F,$30,$31,$32,$33,$34,$35    ; Pre-filled with big DESOLATE sign
  DEFB $35,$36,$37,$38,$39,$3A,$3B,$3C
  DEFB $3D,$3E,$3F,$40,$41,$42,$43,$44
  DEFB $5F,$60,$61,$62,$63,$64,$46,$46
  DEFB $47,$48,$49,$4A,$01,$01,$01,$01
  DEFB $01,$01,$01,$01,$01,$01,$01,$01
  DEFB $01,$01,$01,$01,$01,$01,$01,$01
  DEFB $01,$01,$01,$01,$01,$01,$01,$01
  DEFB $01,$01,$01,$01,$01,$01,$01,$01
  DEFB $01,$01,$01,$01,$01,$01,$01,$01
  DEFB $01,$01,$01,$01,$01,$01,$01,$01
  DEFB $01,$01,$01,$01,$01,$01,$01,$01
LDC55:  DEFB $03          ; Menu background phase: $00..$07
LDC56:  DEFB $00          ; Offset in the room, in tiles ??
LDC57:  DEFB $00          ; Door Lock pos ?? $06 DEC
;  DEFB $00
LDC59:  DEFB $44          ; Delay factor: $64 $28 $00 $44 $96 $FF
LDC5A:  DEFB $00          ; Inventory items count??
LDC5B:                    ; Inventory list
  DEFB $63,$63,$63,$63,$63,$63,$63,$63
  DEFB $63,$63,$63,$63,$63,$63,$63,$63
  DEFB $63,$63,$63,$63,$63,$63,$63,$63
  DEFB $63,$63,$63,$63,$63,$63,$63,$63
  DEFB $63,$63,$63,$63,$63,$63,$63
LDC82:  DEFB $00          ; Inventory current
LDC83:  DEFB $00          ; Inventory X
LDC84:  DEFB $00          ; Inventory Y
LDC85:  DEFB $00          ; Delay and copy screen flag used in LBEDE
LDC86:  DEFB $00          ; new room number??
LDC87:  DEFB $00          ; ??
LDC88:  DEFB $00          ; current offset in the room description $00..$30
LDC89:  DEFB $00          ; Current inventory item / Picked up item??
LDC8A:  DEFB $00          ; Direction to other room ?? $01 down, $02 up, $03 left, $04 right
LDC8B:  DEFB $FF          ; Access code slot number - see LDCA2 table
LDC8C:  DEFB $00          ; Access code level ??
LDC8D:  DEFB $00,$00,$00,$00,$00    ; Buffer for entering access code
LDC92:  DEFB $1E,$1A,$1F,$21    ; level 1 access code buffer
LDC96:  DEFB $1E,$1A,$1F,$21    ; level 2 access code buffer
LDC9A:  DEFB $1E,$1A,$1F,$21    ; level 3 access code buffer
LDC9E:  DEFB $1E,$1A,$1F,$21    ; level 4 access code buffer
LDCA2:    ; Table with Access code slots - marks where door locks codes accepted
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00
LDCF2:  DEFB $00          ; ?? $00 $01
LDCF3:  DEFB $00          ; Left margin size for text
LDCF4:  DEFB $0E          ; Line interval for text: 12 or 14
LDCF5:  DEFB $00          ; ?? $00 $01
;  DEFB $00
LDCF7:  DEFB $00          ; Weapon: $00 $01
LDCF8:  DEFB $00          ; $01 = Data cartridge selected, used on the Data cartridge reader screen
LDCF9:
  DEFB $20,$20,$20,$20,$20,$20,$20,$20
  DEFB $20,$20,$20,$20,$20,$20,$20,$20
  DEFB $20,$20,$20,$20,$20,$20,$20,$20
  DEFB $20,$20,$20,$20,$20,$20,$20,$20
  DEFB $20,$20,$20,$20,$20,$20,$20,$20
  DEFB $20,$20,$20,$20,$20,$20,$20,$20
  DEFB $20,$20,$20,$20,$20,$20,$20,$20
  DEFB $20,$20,$20,$20,$20,$20,$20,$20
  DEFB $20,$20,$20,$20,$20,$20,$20,$20
  DEFB $20,$20,$20,$20,$20,$20,$20,$20
  DEFB $20,$20,$20,$20,$20,$20,$20,$20
  DEFB $20,$00
SE029:  ; Empty string
LDD53:  DEFB $00          ; empty string
LDD54:  DEFB $00          ; Player's animation phase 0..3
LDD55:  DEFB $00          ; shooting flag for player's animation ?? $00 $01
LDD56:  DEFB $00          ; Credits counter within one line: 0..11
LDD57:  DEFB $00          ; Credits line number
;
LDD58:                    ; Table of Credits strings
  ; DEFW SE02B,SE02D,SE029,SE02F,SE031
  ; DEFW SE033,SE035,SE037,SE039,SE03B
  ; DEFW SE029,SE03D,SE03F,SE041,SE043
  ; DEFW SE045,SE047,SE049,SE04B,SE04D
  ; DEFW SE04F,SE051,SE053,SE055,SE057
  ; DEFW SE059,SE05B,SE071,SE073,SE075
  ; DEFW SE029,SE05D,SE05F,SE061,SE063
  ; DEFW SE029,SE029,SE065,SE067,SE069
  ; DEFW SE029,SE06B,SE029,SE029,SE06D
  ; DEFW SE077,SE029,SE029,SE029,SE029
  ; DEFW SE029,SE029,SE029,SE029,SE029
  ; DEFW SE029,SE029,SE029,SE06F,SE029
  ; DEFW SE029,SE029,SE029,SE029,SE029
  ; DEFW SE029,SE029,SE029,SE029,SE029
  ; DEFW SCR40,SCR41,SCR42,SCR43 ; 74
; LDDF2:                    ; Table of left margins for Credits strings
;   DEFB $1C,$1C,$00,$20,$10,$16,$1E,$0C,$14,$18,$00,$4A,$38,$3A,$3A,$2E
;   DEFB $26,$44,$40,$38,$38,$44,$46,$40,$32,$26,$36,$40,$32,$30,$00,$10
;   DEFB $14,$08,$3E,$00,$00,$08,$1E,$20,$00,$32,$00,$00,$22,$0E,$00,$00
;   DEFB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$08,$00,$00,$00,$00,$00
;   DEFB $00,$00,$00,$00,$00,$00,$18,$28,$0A,$2E
;
LDE47:                    ; Player's tile numbers for shooting animation
  DEFB $00,$01,$02,$03, $00,$01,$04,$05    ; $00 down, four phases
  DEFB $00,$01,$02,$03, $00,$01,$06,$07
  DEFB $08,$01,$09,$03, $08,$01,$0A,$05    ; $01 up
  DEFB $08,$01,$09,$03, $08,$01,$0B,$07
  DEFB $0C,$0D,$0E,$12, $0C,$0D,$0F,$11    ; $02 left
  DEFB $0C,$0D,$0E,$12, $0C,$0D,$10,$11
  DEFB $0C,$0D,$0E,$12, $0C,$0D,$0F,$11    ; $03 right
  DEFB $0C,$0D,$0E,$12, $0C,$0D,$10,$11
LDE87:                    ; Player's tile numbers by Player's direction/orientation
  DEFB $00,$01,$13,$03    ; $00 down
  DEFB $08,$01,$09,$14    ; $01 up
  DEFB $0C,$0D,$15,$16    ; $02 left
  DEFB $0C,$0D,$15,$16    ; $03 right

;
; Room descriptions, RLE encoded, for 72 rooms, 49 decoded bytes per description
LD243:
  DEFB $4D,$4E,$00,$61,$61,$61,$40,$41,$01,$01,$01,$44,$50,$03,$00,$FF ; Room #0
  DEFB $05,$61,$33,$36,$39,$FF,$05,$61,$01,$00,$00,$00,$61,$61,$61,$01 ; desc
  DEFB $61,$61,$61,$00,$FF,$07,$61,$00,$61
LD26C:
  DEFB $4D,$4E,$00,$29,$2A,$01,$61,$61,$61,$00,$FF,$12,$61,$00,$01,$00 ; Room #1
  DEFB $00,$61,$61,$61,$02,$00,$61,$61,$01,$00,$FF,$06,$61,$00,$61     ; desc
LD28B:
  DEFB $4D,$4E,$00,$29,$2A,$01,$32,$33,$01,$01,$05,$FF,$09,$61,$31,$34 ; Room #2
  DEFB $FF,$06,$61,$01,$00,$00,$01,$2E,$3A,$03,$05,$01,$61,$03,$04,$01 ; desc
  DEFB $61,$02,$FF,$04,$61,$00,$61                                     ;
LD2B2:
  DEFB $61,$61,$61,$29,$2A,$01,$61,$61,$61,$00,$FF,$0F,$61,$25,$31,$02 ; Room #3
  DEFB $00,$01,$01,$00,$FF,$04,$61,$04,$02,$61,$61,$03,$02,$FF,$05,$61 ; desc
  DEFB $00,$61                                                         ;
LD2D4:
  DEFB $4D,$4E,$00,$FF,$06,$61,$00,$FF,$05,$61,$35,$36,$01,$13,$01,$34 ; Room #4
  DEFB $37,$FF,$06,$61,$01,$00,$00,$00,$61,$61,$61,$03,$61,$61,$61,$03 ; desc
  DEFB $FF,$07,$61,$00,$61                                             ;
LD2F9:
  DEFB $4D,$4E,$00,$29,$2A,$01,$61,$61,$61,$00,$FF,$05,$61,$4C,$4C,$01 ; Room #5
  DEFB $00,$02,$FF,$08,$61,$00,$01,$00,$00,$61,$61,$61,$08,$02,$61,$61 ; desc
  DEFB $07,$04,$FF,$06,$61,$00,$02                                     ;
LD320:
  DEFB $4D,$4E,$00,$29,$2A,$01,$4F,$50,$01,$00,$00,$FF,$09,$61,$3D,$61 ; Room #7
  DEFB $61,$FF,$05,$61,$01,$00,$00,$00,$61,$61,$61,$09,$0A,$61,$61,$09 ; desc
  DEFB $0A,$FF,$06,$61,$00,$61                                         ;
LD346:
  DEFB $61,$61,$61,$29,$2A,$01,$61,$61,$61,$00,$FF,$12,$61,$FF,$04,$00 ; Room #8
  DEFB $2E,$3A,$03,$61,$05,$61,$09,$61,$07,$61,$08,$FF,$04,$61,$00,$61 ; desc
LD366:
  DEFB $61,$61,$61,$29,$2A,$01,$FF,$05,$00,$44,$44,$00,$19,$FF,$0A,$61 ; Room #9
  DEFB $25,$31,$02,$00,$01,$00,$00,$FF,$04,$61,$07,$08,$61,$61,$09,$08 ; desc
  DEFB $FF,$05,$61,$00,$61                                             ;
LD38B:
  DEFB $4D,$4E,$00,$FF,$06,$61,$00,$FF,$12,$61,$00,$00,$00,$01,$2E,$3A ; Room #10
  DEFB $03,$07,$61,$61,$0B,$0A,$61,$61,$0B,$FF,$04,$61,$00,$61         ; desc
LD3A9:
  DEFB $4D,$4E,$00,$29,$2A,$01,$44,$45,$01,$01,$06,$FF,$09,$61,$43,$FF ; Room #11
  DEFB $04,$61,$25,$31,$02,$02,$01,$01,$00,$61,$61,$61,$1C,$0C,$0A,$61 ; desc
  DEFB $1C,$0C,$0B,$FF,$05,$61,$00,$61                                 ;
LD3D1:
  DEFB $4D,$4E,$00,$29,$2A,$01,$FF,$05,$00,$3D,$3E,$01,$13,$FF,$05,$61 ; Room #12
  DEFB $33,$3F,$FF,$06,$61,$01,$00,$00,$00,$61,$61,$61,$0B,$0D,$61,$61 ; desc
  DEFB $0C,$0D,$FF,$06,$61,$00,$61                                     ;
LD3F8:
  DEFB $4D,$4E,$00,$29,$2A,$01,$61,$61,$61,$00,$FF,$12,$61,$00,$02,$00 ; Room #13
  DEFB $00,$61,$61,$61,$0C,$0E,$61,$61,$0D,$0E,$FF,$06,$61,$00,$61     ; desc
LD417:
  DEFB $4D,$4E,$00,$FF,$06,$61,$00,$FF,$0F,$61,$25,$31,$02,$02,$00,$03 ; Room #14
  DEFB $01,$2E,$3A,$03,$0D,$61,$0F,$10,$0E,$61,$0F,$10,$FF,$04,$61,$00 ; desc
  DEFB $61                                                             ;
LD438:
  DEFB $FF,$06,$61,$38,$39,$01,$01,$14,$FF,$09,$61,$2B,$37,$FF,$06,$61 ; Room #15
  DEFB $00,$00,$00,$03,$2E,$3A,$03,$61,$61,$61,$0E,$61,$61,$61,$0F,$FF ; desc
  DEFB $04,$61,$00,$61                                                 ;
LD45C:
  DEFB $4D,$4E,$00,$61,$61,$61,$FF,$05,$00,$36,$42,$03,$07,$FF,$0A,$61 ; Room #16
  DEFB $25,$31,$02,$00,$00,$01,$04,$2E,$3A,$03,$11,$61,$0E,$16,$11,$61 ; desc
  DEFB $10,$16,$FF,$04,$61,$00,$61                                     ;
LD483:
  DEFB $4D,$4E,$00,$29,$2A,$01,$4B,$4C,$01,$00,$00,$FF,$11,$61,$FF,$04 ; Room #17
  DEFB $00,$61,$61,$61,$12,$10,$61,$61,$12,$11,$FF,$06,$61,$00,$61     ; desc
LD4A2:
  DEFB $4D,$4E,$00,$29,$2A,$01,$61,$61,$61,$00,$FF,$12,$61,$02,$00,$00 ; Room #18
  DEFB $02,$2E,$3A,$03,$13,$11,$61,$18,$13,$12,$61,$1F,$02,$30,$06,$01 ; desc
  DEFB $01,$61                                                         ;
LD4C4:
  DEFB $61,$61,$61,$29,$2A,$01,$4A,$4B,$01,$01,$0A,$44,$50,$03,$23,$FF ; Room #19
  DEFB $0D,$61,$00,$02,$00,$00,$FF,$04,$61,$12,$61,$61,$61,$13,$FF,$06 ; desc
  DEFB $61,$00,$61                                                     ;
LD4E7:
  DEFB $4D,$4E,$00,$FF,$06,$61,$00,$FF,$0F,$61,$25,$31,$02,$01,$00,$00 ; Room #20
  DEFB $00,$2E,$3A,$03,$15,$61,$1C,$1A,$15,$61,$14,$4A,$FF,$04,$61,$00 ; desc
  DEFB $61                                                             ;
LD508:
  DEFB $61,$61,$61,$29,$2A,$01,$61,$61,$61,$00,$FF,$12,$61,$00,$01,$00 ; Room #21
  DEFB $00,$2E,$3A,$03,$61,$14,$61,$1B,$61,$15,$61,$1B,$FF,$04,$61,$00 ; desc
  DEFB $61                                                             ;
LD529:
  DEFB $4D,$4E,$00,$61,$61,$61,$FF,$05,$00,$39,$45,$03,$16,$FF,$05,$61 ; Room #22
  DEFB $2E,$FF,$04,$61,$25,$31,$02,$04,$00,$04,$00,$61,$61,$61,$18,$61 ; desc
  DEFB $10,$61,$18,$61,$16,$61,$05,$20,$04,$02,$01,$61                 ;
LD555:
  DEFB $4D,$4E,$00,$29,$2A,$01,$4B,$4C,$01,$01,$0B,$FF,$0E,$61,$25,$31 ; Room #24
  DEFB $02,$00,$04,$02,$00,$61,$61,$61,$1A,$16,$12,$61,$1A,$18,$1F,$FF ; desc
  DEFB $05,$61,$00,$61                                                 ;
LD579:
  DEFB $61,$61,$61,$29,$2A,$01,$4D,$4E,$01,$00,$00,$FF,$0E,$61,$25,$31 ; Room #26
  DEFB $02,$FF,$04,$00,$FF,$04,$61,$18,$14,$61,$61,$1A,$4A,$61,$03,$30 ; desc
  DEFB $06,$01,$01,$61                                                 ;
LD59D:
  DEFB $4D,$4E,$00,$61,$61,$61,$38,$39,$01,$01,$0F,$FF,$09,$61,$2B,$37 ; Room #27
  DEFB $61,$61,$61,$25,$31,$02,$FF,$04,$00,$61,$61,$61,$1E,$61,$15,$61 ; desc
  DEFB $1E,$61,$1B,$FF,$05,$61,$00,$61                                 ;
LD5C5:
  DEFB $4D,$4E,$00,$29,$2A,$01,$61,$61,$61,$00,$FF,$12,$61,$02,$02,$00 ; Room #28
  DEFB $00,$2E,$3A,$03,$1D,$0B,$61,$14,$1D,$1C,$61,$14,$FF,$04,$61,$00 ; desc
  DEFB $61                                                             ;
LD5E6:
  DEFB $61,$61,$61,$29,$2A,$01,$3F,$40,$01,$01,$08,$FF,$09,$61,$32,$35 ; Room #29
  DEFB $FF,$06,$61,$00,$02,$00,$00,$FF,$04,$61,$1C,$61,$61,$61,$1D,$61 ; desc
  DEFB $61,$09,$28,$05,$01,$01,$61                                     ;
LD60D:
  DEFB $61,$61,$61,$29,$2A,$01,$61,$61,$61,$00,$FF,$0F,$61,$25,$31,$02 ; Room #30
  DEFB $FF,$04,$00,$FF,$04,$61,$1B,$1F,$61,$61,$1E,$1F,$61,$06,$30,$06 ; desc
  DEFB $01,$01,$61                                                     ;
LD630:
  DEFB $FF,$06,$61,$4B,$4C,$01,$01,$09,$FF,$09,$61,$3E,$41,$61,$61,$61 ; Room #31
  DEFB $25,$31,$02,$00,$00,$02,$00,$2E,$3A,$03,$61,$61,$20,$1E,$61,$61 ; desc
  DEFB $20,$1F,$FF,$04,$61,$00,$61                                     ;
LD657:
  DEFB $4D,$4E,$00,$FF,$06,$61,$00,$FF,$05,$61,$35,$36,$01,$14,$04,$34 ; Room #32
  DEFB $37,$61,$61,$61,$25,$31,$02,$00,$00,$04,$02,$2E,$3A,$03,$21,$61 ; desc
  DEFB $23,$1F,$21,$61,$22,$20,$02,$30,$06,$01,$01,$00                 ;
LD683:
  DEFB $61,$61,$61,$29,$2A,$01,$61,$61,$61,$00,$FF,$0F,$61,$25,$31,$02 ; Room #33
  DEFB $00,$00,$03,$02,$2E,$3A,$03,$61,$20,$25,$2A,$61,$21,$24,$29,$03 ; desc
  DEFB $30,$06,$01,$01,$61                                             ;
LD6A8:
  DEFB $FF,$09,$61,$00,$FF,$05,$61,$32,$3E,$02,$15,$05,$26,$4A,$FF,$06 ; Room #35
  DEFB $61,$00,$00,$00,$04,$2E,$3A,$03,$61,$61,$61,$20,$61,$61,$61,$22 ; desc
  DEFB $05,$18,$03,$01,$01,$00                                         ;
LD6CE:
  DEFB $FF,$09,$61,$00,$FF,$0F,$61,$25,$31,$02,$00,$00,$00,$03,$2E,$3A ; Room #37
  DEFB $03,$61,$61,$26,$21,$61,$61,$25,$24,$05,$30,$06,$02,$01,$61     ; desc
LD6ED:
  DEFB $4D,$4E,$00,$FF,$06,$61,$00,$FF,$12,$61,$FF,$04,$00,$2E,$3A,$03 ; Room #38
  DEFB $27,$61,$61,$25,$26,$61,$61,$25,$04,$28,$05,$02,$01,$61         ; desc
LD70B:
  DEFB $4D,$4E,$00,$29,$2A,$01,$32,$33,$01,$00,$00,$FF,$11,$61,$00,$00 ; Room #39
  DEFB $00,$03,$2E,$3A,$03,$28,$26,$61,$30,$27,$26,$61,$2F,$02,$30,$06 ; desc
  DEFB $01,$01,$61                                                     ;
LD72E:
  DEFB $4D,$4E,$00,$29,$2A,$01,$61,$61,$61,$00,$FF,$12,$61,$FF,$04,$00 ; Room #40
  DEFB $2E,$3A,$03,$29,$27,$61,$31,$28,$27,$61,$30,$04,$28,$05,$02,$01 ; desc
  DEFB $61                                                             ;
LD74F:
  DEFB $61,$61,$61,$29,$2A,$01,$FF,$05,$00,$3F,$4B,$02,$0D,$FF,$05,$61 ; Room #41
  DEFB $31,$32,$FF,$06,$61,$FF,$04,$00,$2E,$3A,$03,$61,$28,$61,$32,$61 ; desc
  DEFB $28,$61,$31,$07,$28,$05,$02,$01,$61                             ;
LD778:
  DEFB $4D,$4E,$00,$61,$61,$61,$41,$42,$01,$00,$00,$FF,$0E,$61,$25,$31 ; Room #42
  DEFB $02,$00,$00,$02,$04,$2E,$3A,$03,$2C,$61,$21,$2B,$2B,$61,$29,$2A ; desc
  DEFB $FF,$04,$61,$00,$61                                             ;
LD79D:
  DEFB $FF,$06,$61,$FF,$05,$00,$39,$39,$03,$17,$FF,$05,$61,$38,$FF,$04 ; Room #43
  DEFB $61,$25,$31,$02,$00,$00,$04,$00,$FF,$05,$61,$2A,$61,$61,$61,$2A ; desc
  DEFB $61,$03,$30,$06,$01,$01,$61                                     ;
LD7C4:
  DEFB $61,$61,$61,$29,$2A,$01,$61,$61,$61,$00,$FF,$0F,$61,$25,$31,$02 ; Room #44
  DEFB $FF,$04,$00,$2E,$3A,$03,$61,$2A,$2E,$2D,$61,$2B,$2D,$2C,$FF,$04 ; desc
  DEFB $61,$00,$61                                                     ;
LD7E7:
  DEFB $FF,$06,$61,$FF,$05,$00,$41,$42,$01,$0C,$FF,$0A,$61,$25,$31,$02 ; Room #45
  DEFB $FF,$04,$00,$FF,$05,$61,$2C,$61,$61,$61,$2C,$61,$06,$30,$06,$01 ; desc
  DEFB $01,$61                                                         ;
LD809:
  DEFB $4D,$4E,$00,$61,$61,$61,$4A,$4B,$01,$00,$00,$FF,$11,$61,$02,$00 ; Room #46
  DEFB $00,$00,$2E,$3A,$03,$2F,$61,$61,$2C,$2E,$61,$61,$2D,$FF,$04,$61 ; desc
  DEFB $00,$61                                                         ;
LD82B:
  DEFB $61,$61,$61,$29,$2A,$01,$38,$39,$01,$01,$03,$FF,$09,$61,$2B,$37 ; Room #47
  DEFB $FF,$06,$61,$00,$02,$00,$00,$FF,$04,$61,$2E,$61,$61,$61,$2E,$61 ; desc
  DEFB $61,$04,$28,$05,$02,$01,$61                                     ;
LD852:
  DEFB $FF,$06,$61,$4C,$4D,$01,$01,$10,$FF,$0E,$61,$25,$31,$02,$00,$00 ; Room #48
  DEFB $03,$00,$FF,$05,$61,$27,$61,$61,$61,$2F,$61,$08,$28,$05,$01,$01 ; desc
  DEFB $61                                                             ;
LD873:
  DEFB $4D,$4E,$00,$FF,$06,$61,$00,$FF,$0F,$61,$25,$31,$02,$FF,$04,$00 ; Room #49
  DEFB $61,$61,$61,$32,$61,$28,$61,$32,$61,$30,$61,$07,$28,$05,$01,$01 ; desc
  DEFB $61                                                             ;
LD894:
  DEFB $61,$61,$61,$29,$2A,$01,$61,$61,$61,$00,$FF,$0F,$61,$25,$31,$02 ; Room #50
  DEFB $00,$00,$00,$02,$2E,$3A,$03,$61,$31,$29,$33,$61,$32,$31,$33,$FF ; desc
  DEFB $04,$61,$00,$61                                                 ;
LD8B8:
  DEFB $FF,$06,$61,$4D,$4E,$01,$00,$00,$FF,$0E,$61,$25,$31,$02,$00,$00 ; Room #51
  DEFB $02,$00,$2E,$3A,$03,$61,$61,$32,$34,$61,$61,$33,$34,$04,$18,$03 ; desc
  DEFB $01,$01,$61                                                     ;
LD8DB:
  DEFB $61,$61,$61,$29,$2A,$01,$61,$61,$61,$00,$FF,$0F,$61,$25,$31,$02 ; Room #52
  DEFB $00,$01,$00,$00,$FF,$04,$61,$35,$33,$61,$61,$35,$34,$61,$08,$20 ; desc
  DEFB $04,$02,$01,$61                                                 ;
LD8FF:
  DEFB $4D,$4E,$00,$FF,$06,$61,$00,$FF,$12,$61,$01,$00,$00,$00,$2E,$3A ; Room #53
  DEFB $03,$34,$61,$61,$36,$35,$61,$61,$36,$06,$20,$04,$02,$01,$61     ; desc
LD91E:
  DEFB $4D,$4E,$00,$61,$61,$61,$50,$51,$01,$00,$00,$FF,$0E,$61,$25,$31 ; Room #54
  DEFB $02,$03,$00,$00,$00,$61,$61,$61,$37,$61,$35,$61,$37,$61,$36,$61 ; desc
  DEFB $05,$18,$03,$01,$01,$61                                         ;
LD944:
  DEFB $4D,$4E,$00,$29,$2A,$01,$50,$51,$01,$01,$04,$FF,$09,$61,$43,$4F ; Room #55
  DEFB $FF,$06,$61,$04,$03,$00,$00,$61,$61,$61,$38,$36,$61,$61,$38,$37 ; desc
  DEFB $FF,$06,$61,$00,$61                                             ;
LD969:
  DEFB $61,$61,$61,$29,$2A,$01,$61,$61,$61,$00,$FF,$0F,$61,$25,$31,$02 ; Room #56
  DEFB $00,$04,$00,$00,$FF,$04,$61,$37,$39,$61,$61,$38,$39,$61,$07,$30 ; desc
  DEFB $06,$02,$01,$61                                                 ;
LD98D:
  DEFB $4D,$4E,$00,$FF,$06,$61,$00,$FF,$0F,$61,$25,$31,$02,$FF,$04,$00 ; Room #57
  DEFB $2E,$3A,$03,$40,$61,$3B,$38,$3A,$61,$48,$39,$06,$20,$04,$02,$01 ; desc
  DEFB $61                                                             ;
LD9AE:
  DEFB $4D,$4E,$00,$FF,$06,$61,$00,$FF,$0F,$61,$25,$31,$02,$00,$00,$04 ; Room #59
  DEFB $00,$2E,$3A,$03,$3E,$61,$3C,$39,$42,$61,$3C,$48,$FF,$04,$61,$00 ; desc
  DEFB $61                                                             ;
LD9CF:
  DEFB $FF,$06,$61,$FF,$05,$00,$3D,$3D,$00,$18,$FF,$0D,$61,$00,$00,$00 ; Room #60
  DEFB $04,$2E,$3A,$03,$61,$61,$61,$3B,$61,$61,$61,$3C,$FF,$04,$61,$00 ; desc
  DEFB $61                                                             ;
LD9F0:
  DEFB $4D,$4E,$00,$FF,$06,$61,$00,$FF,$12,$61,$04,$00,$00,$00,$2E,$3A ; Room #61
  DEFB $03,$42,$61,$61,$3E,$46,$61,$61,$45,$04,$20,$04,$02,$01,$61     ; desc
LDA0F:
  DEFB $4D,$4E,$00,$29,$2A,$01,$61,$61,$61,$00,$FF,$0F,$61,$25,$31,$02 ; Room #62
  DEFB $FF,$04,$00,$61,$61,$61,$43,$3B,$3D,$61,$44,$42,$45,$FF,$05,$61 ; desc
  DEFB $00,$61                                                         ;
LDA31:
  DEFB $4D,$4E,$00,$FF,$06,$61,$00,$FF,$12,$61,$FF,$04,$00,$2E,$3A,$03 ; Room #63
  DEFB $44,$61,$61,$40,$41,$61,$61,$47,$FF,$04,$61,$00,$61             ; desc
LDA4E:
  DEFB $4D,$4E,$00,$29,$2A,$01,$4B,$4C,$01,$00,$00,$FF,$0E,$61,$25,$31 ; Room #64
  DEFB $02,$04,$00,$00,$00,$2E,$3A,$03,$45,$39,$3F,$41,$3E,$3A,$47,$3D ; desc
  DEFB $08,$18,$03,$02,$01,$61                                         ;
LDA74:
  DEFB $FF,$09,$61,$00,$FF,$0F,$61,$25,$31,$02,$FF,$04,$00,$FF,$05,$61 ; Room #65
  DEFB $40,$61,$61,$61,$3D,$61,$05,$28,$05,$02,$01,$61                 ; desc
LDA90:
  DEFB $61,$61,$61,$29,$2A,$01,$44,$45,$01,$01,$15,$FF,$09,$61,$2B,$37 ; Room #66
  DEFB $FF,$06,$61,$00,$04,$00,$00,$FF,$04,$61,$3D,$61,$61,$61,$46,$61 ; desc
  DEFB $61,$04,$18,$03,$02,$01,$61                                     ;
LDAB7:
  DEFB $61,$61,$61,$29,$2A,$01,$4D,$4E,$01,$00,$00,$FF,$11,$61,$00,$00 ; Room #67
  DEFB $00,$02,$2E,$3A,$03,$61,$3E,$61,$44,$61,$44,$61,$43,$03,$18,$03 ; desc
  DEFB $01,$01,$61                                                     ;
LDADA:
  DEFB $61,$61,$61,$29,$2A,$01,$37,$38,$01,$01,$0E,$FF,$09,$61,$2D,$FF ; Room #68
  DEFB $04,$61,$25,$31,$02,$00,$00,$02,$00,$FF,$04,$61,$3F,$43,$61,$61 ; desc
  DEFB $41,$43,$61,$07,$28,$05,$01,$01,$61                             ;
LDB03:
  DEFB $61,$61,$61,$29,$2A,$01,$61,$61,$61,$00,$FF,$12,$61,$00,$04,$00 ; Room #69
  DEFB $04,$2E,$3A,$03,$61,$40,$61,$46,$61,$3E,$61,$3F,$03,$30,$06,$02 ; desc
  DEFB $01,$61                                                         ;
LDB25:
  DEFB $FF,$09,$61,$00,$FF,$05,$61,$37,$43,$02,$00,$07,$FF,$05,$61,$25 ; Room #70
  DEFB $31,$02,$00,$00,$04,$04,$2E,$3A,$03,$61,$61,$45,$47,$61,$61,$3F ; desc
  DEFB $4B,$03,$28,$05,$01,$01,$00                                     ;
LDB4C:
  DEFB $FF,$09,$61,$00,$FF,$05,$61,$35,$36,$00,$00,$06,$33,$34,$37,$38 ; Room #71
  DEFB $61,$25,$31,$02,$00,$00,$04,$00,$FF,$05,$61,$46,$61,$61,$61,$4B ; desc
  DEFB $61,$04,$20,$04,$02,$01,$00                                     ;

;
  INCLUDE "desolroom.inc"
;
; List of encoded room addresses, for 72 rooms
LDE97:
  DEFW LBFF8
  DEFW LC04D
  DEFW LC09D
  DEFW LC0F4
  DEFW LC141
  DEFW LC18D
  DEFW LC1DE
  DEFW LC1DE
  DEFW LC22E
  DEFW LC276
  DEFW LC2BC
  DEFW LC2F4
  DEFW LC33F
  DEFW LC38D
  DEFW LC3D3
  DEFW LC41E
  DEFW LC467
  DEFW LC4AA
  DEFW LC4F7
  DEFW LC538
  DEFW LC584
  DEFW LC5C6
  DEFW LC609
  DEFW LC645
  DEFW LC645
  DEFW LC692
  DEFW LC692
  DEFW LC6DC
  DEFW LC720
  DEFW LC766
  DEFW LC7B3
  DEFW LC7F5
  DEFW LC837
  DEFW LC87A
  DEFW LC8C3
  DEFW LC8C3
  DEFW LD6CE
  DEFW LC903
  DEFW LC93B
  DEFW LC979
  DEFW LC9C1
  DEFW LCA07
  DEFW LCA4E
  DEFW LCA92
  DEFW LCAD4
  DEFW LCB19
  DEFW LCB5B
  DEFW LCBA2
  DEFW LCBEA
  DEFW LCC28
  DEFW LCC68
  DEFW LCCA9
  DEFW LCCEF
  DEFW LCD36
  DEFW LCD7B
  DEFW LCDBC
  DEFW LCE09
  DEFW LCE4D
  DEFW LCE93
  DEFW LCE93
  DEFW LCED9
  DEFW LCF20
  DEFW LCF59
  DEFW LCFA0
  DEFW LCFDE
  DEFW LD03E
  DEFW LD082
  DEFW LD0D3
  DEFW LD11F
  DEFW LD17F
  DEFW LD1BB
  DEFW LD204
LDF27:                    ; Room description address table, for 72 rooms
  DEFW LD243
  DEFW LD26C
  DEFW LD28B
  DEFW LD2B2
  DEFW LD2D4
  DEFW LD2F9
  DEFW LD320
  DEFW LD320
  DEFW LD346
  DEFW LD366
  DEFW LD38B
  DEFW LD3A9
  DEFW LD3D1
  DEFW LD3F8
  DEFW LD417
  DEFW LD438
  DEFW LD45C
  DEFW LD483
  DEFW LD4A2
  DEFW LD4C4
  DEFW LD4E7
  DEFW LD508
  DEFW LD529
  DEFW LD555
  DEFW LD555
  DEFW LD579
  DEFW LD579
  DEFW LD59D
  DEFW LD5C5
  DEFW LD5E6
  DEFW LD60D
  DEFW LD630
  DEFW LD657
  DEFW LD683
  DEFW LD6A8
  DEFW LD6A8
  DEFW LD6CE
  DEFW LD6CE
  DEFW LD6ED
  DEFW LD70B
  DEFW LD72E
  DEFW LD74F
  DEFW LD778
  DEFW LD79D
  DEFW LD7C4
  DEFW LD7E7
  DEFW LD809
  DEFW LD82B
  DEFW LD852
  DEFW LD873
  DEFW LD894
  DEFW LD8B8
  DEFW LD8DB
  DEFW LD8FF
  DEFW LD91E
  DEFW LD944
  DEFW LD969
  DEFW LD98D
  DEFW LD9AE
  DEFW LD9AE
  DEFW LD9CF
  DEFW LD9F0
  DEFW LDA0F
  DEFW LDA31
  DEFW LDA4E
  DEFW LDA74
  DEFW LDA90
  DEFW LDAB7
  DEFW LDADA
  DEFW LDB03
  DEFW LDB25
  DEFW LDB4C

LDFB7:
  DEFW SE0E5    ; Data cartridge reader
  DEFW SE0E7    ; Data Cartridge 1
  DEFW SE0E9
  DEFW SE0EB
  DEFW SE0ED
  DEFW SE0EF
  DEFW SE0F1
  DEFW SE0F3
  DEFW SE0F5
  DEFW SE0F7
  DEFW SE0F9
  DEFW SE0FB
  DEFW SE0FD
  DEFW SE0FF
  DEFW SE101
  DEFW SE103
  DEFW SE105
  DEFW LDD53    ; empty string
  DEFW LDD53    ; empty string
  DEFW SE107
  DEFW SE109    ; Data Cartridge 16
  DEFW SE10B
  DEFW SE10D
  DEFW SE10F
  DEFW SE111
  DEFW SE113    ; Rubik's Cube
  DEFW LDD53    ; empty string
  DEFW LDD53    ; empty string
  DEFW LDD53    ; empty string
  DEFW LDD53    ; empty string
LDFF3:          ; Table of strings: Data cartridge messages
  DEFW SE079    ; "Im hurt bad . . .
  DEFW SE079    ; "Im hurt bad . . .
  DEFW SE07B    ; "For security reasons I had to change ...
  DEFW SE07D    ; "The system is going|haywire. ...
  DEFW SE07F    ; "Crew I am honoured to|have served ...
  DEFW SE081
  DEFW SE083
  DEFW SE085
  DEFW SE087
  DEFW SE089
  DEFW SE08B
  DEFW SE08D
  DEFW SE08F
  DEFW SE091
  DEFW SE093
  DEFW SE095
  DEFW SE097
LE015:          ; Table of access code buffers
  DEFW LDC92
  DEFW LDC92
  DEFW LDC96    ; level 2 access code buffer
  DEFW LDC9A    ; level 3 access code buffer
  DEFW LDC9E    ; level 4 access code buffer
LE01F:          ; Table of strings: access code messages
  DEFW SAccessLevel1
  DEFW SAccessLevel1
  DEFW SAccessLevel2
  DEFW SAccessLevel3
  DEFW SAccessLevel4
DoorLockLevelEntered:  ; Table of flags on which levels access codes was already entered
  DEFB $01
  DEFB $00    ; level 1 code entered
  DEFB $00    ; level 2 code entered
  DEFB $00    ; level 3 code entered
  DEFB $00    ; level 4 code entered

;----------------------------------------------------------------------------

  INCLUDE "desoltils.asm"

;----------------------------------------------------------------------------

; Encoded screen for Small message popup, in Tileset #2
LEB27:
  DEFB $FF,$3C,$01,$26,$FF,$0A,$2A,$27
  DEFB $2D,$FF,$0A,$00,$2C,$28,$FF,$0A
  DEFB $2B,$29
; Encoded screen for Inventory/Info popup, in Tileset #2
LF329:
  DEFB $FF,$0C,$01,$26,$FF,$0A,$2A,$27
  DEFB $2D,$FF,$0A,$00,$2C,$2D,$FF,$0A
  DEFB $00,$2C,$2D,$FF,$0A,$00,$2C,$2D
  DEFB $FF,$0A,$00,$2C,$2D,$FF,$0A,$00
  DEFB $2C,$28,$FF,$0A,$2B,$29
LF42F:
; Encoded screen: Data cartridge reader screen, in Tileset #2
  DEFB $03,$FF,$09,$04,$15,$05,$07,$11,$FF,$08,$0F,$12,$0B,$07,$0D,$FF
  DEFB $08,$00,$0E,$06,$07,$0D,$FF,$08,$00,$0E,$06,$07,$0D,$FF,$08,$00
  DEFB $0E,$06,$07,$13,$FF,$08,$10,$14,$06,$07,$00,$0C,$00,$FF,$04,$16
  DEFB $00,$0C,$00,$06,$09,$FF,$0A,$08,$0A
LF468:
; Encoded screen: Door Lock panel popup, in Tileset #2
  DEFB $03,$FF,$05,$04,$17,$FF,$05,$01,$07,$FF,$05,$00,$06,$FF,$05,$01
  DEFB $07,$00,$FF,$04,$0F,$06,$03,$04,$04,$15,$05,$07,$FF,$05,$00,$06
  DEFB $07,$1A,$1B,$1C,$0B,$07,$FF,$05,$00,$06,$07,$1D,$1E,$1F,$06,$07
  DEFB $FF,$05,$00,$18,$19,$20,$21,$22,$06,$07,$FF,$05,$00,$06,$07,$23
  DEFB $24,$25,$06,$09,$FF,$05,$08,$0A,$09,$08,$08,$08,$0A
; Main menu screen, 96 tiles in Tileset #2
LF4B5:
  DEFB $2E,$2F,$30,$31,$32,$33,$34,$35,$35,$36,$37,$38,$39,$3A,$3B,$3C
  DEFB $3D,$3E,$3F,$40,$41,$42,$43,$44,$5F,$60,$61,$62,$63,$64,$46,$46
  DEFB $47,$48,$49,$4A,$65,$66,$67,$68,$69,$6A,$01,$01,$4C,$4D,$4E,$4F
  DEFB $6B,$6C,$6D,$6E,$6F,$70,$01,$01,$50,$51,$52,$53,$6B,$71,$72,$73
  DEFB $74,$70,$01,$01,$01,$54,$55,$56,$6B,$75,$76,$77,$78,$70,$01,$01
  DEFB $57,$58,$59,$5A,$79,$7A,$7B,$7C,$7A,$7D,$01,$01,$5B,$5C,$5D,$5E
; Main menu screen moving background, 96 tiles
LF515:
  DEFB $47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$47,$47,$47,$47,$47,$47,$47,$47
  DEFB $47,$00,$00,$00,$47,$00,$00,$00,$00,$47,$47,$47,$47,$00,$00,$00
  DEFB $47,$00,$00,$00,$00,$47,$47,$47,$47,$47,$00,$00,$47,$00,$00,$00
  DEFB $00,$47,$47,$47,$47,$47,$47,$00,$47,$00,$00,$00,$00,$47,$47,$47
  DEFB $47,$47,$47,$00,$47,$47,$47,$47,$47,$47,$47,$47,$47,$00,$00,$00


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
  DS 96                   ; zero-filled, always unpacked before use
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
; Room descriptions, ZX0 packed, for 72 rooms, 49 decoded bytes per description
LD243:
  DEFB $08,$4D,$4E,$00,$61,$98,$40,$41,$01,$9F,$44,$50,$03,$E9,$E0,$FE
  DEFB $82,$33,$36,$39,$61,$23,$01,$00,$FB,$F2,$BE,$9F,$CE,$F0,$C0,$00
  DEFB $20
LD26C:
  DEFB $58,$4D,$4E,$00,$29,$2A,$01,$61,$88,$00,$61,$06,$6E,$00,$01,$00
  DEFB $F0,$AE,$02,$C3,$97,$01,$C0,$B5,$00,$20
LD28B:
  DEFB $06,$4D,$4E,$00,$29,$2A,$01,$32,$33,$01,$88,$05,$61,$08,$E6,$31
  DEFB $34,$EC,$06,$01,$00,$00,$01,$2E,$3A,$03,$05,$01,$8E,$03,$04,$F9
  DEFB $FA,$02,$D6,$00,$C0,$00,$20
LD2B2:
  DEFB $88,$61,$22,$29,$2A,$01,$61,$25,$00,$61,$21,$B8,$25,$31,$02,$00
  DEFB $01,$D4,$8E,$04,$02,$F9,$9E,$03,$B4,$30,$00,$08
LD2D4:
  DEFB $08,$4D,$4E,$00,$61,$79,$F2,$97,$35,$36,$01,$13,$01,$34,$37,$99
  DEFB $DA,$FB,$01,$00,$00,$C6,$03,$8F,$F8,$B4,$70,$00,$08
LD2F9:
  DEFB $58,$4D,$4E,$00,$29,$2A,$01,$61,$88,$00,$61,$2A,$4C,$09,$01,$00
  DEFB $02,$61,$6F,$00,$E9,$EE,$D4,$08,$DE,$8F,$07,$04,$DA,$2C,$02,$00
  DEFB $02
LD320:
  DEFB $12,$4D,$4E,$00,$29,$2A,$01,$4F,$50,$01,$00,$A0,$61,$2F,$3D,$EC
  DEFB $3E,$D9,$D6,$23,$09,$0A,$F9,$F8,$C4,$F0,$B7,$00,$08
LD346:
  DEFB $88,$61,$22,$29,$2A,$01,$61,$20,$00,$61,$1A,$00,$E1,$FD,$AA,$2E
  DEFB $3A,$03,$61,$05,$09,$AB,$07,$08,$8C,$B4,$00,$02
LD366:
  DEFB $88,$61,$20,$29,$2A,$01,$00,$A9,$44,$81,$00,$19,$61,$83,$25,$31
  DEFB $02,$00,$BE,$D0,$EA,$38,$07,$08,$D5,$87,$09,$08,$C0,$E1,$00,$20
LD38B:
  DEFB $08,$4D,$4E,$00,$61,$7E,$F3,$FE,$02,$88,$00,$78,$01,$2E,$3A,$03
  DEFB $07,$BF,$EE,$0B,$0A,$F8,$B4,$70,$00,$08
LD3A9:
  DEFB $06,$4D,$4E,$00,$29,$2A,$01,$44,$45,$01,$88,$06,$61,$08,$99,$43
  DEFB $61,$BA,$25,$31,$02,$D7,$00,$67,$1C,$0C,$0A,$AE,$F8,$0B,$C2,$3C
  DEFB $E1,$00,$02
LD3D1:
  DEFB $58,$4D,$4E,$00,$29,$2A,$01,$00,$21,$82,$3D,$3E,$01,$13,$61,$61
  DEFB $33,$3F,$61,$FE,$D2,$F2,$8E,$0B,$0D,$F9,$B9,$0C,$DA,$F0,$E1,$00
  DEFB $08
LD3F8:
  DEFB $58,$4D,$4E,$00,$29,$2A,$01,$61,$88,$00,$61,$06,$7E,$00,$02,$00
  DEFB $D4,$22,$0C,$0E,$24,$0D,$0E,$F0,$B5,$00,$08
LD417:
  DEFB $08,$4D,$4E,$00,$61,$78,$F2,$E4,$F8,$95,$9E,$25,$31,$02,$02,$00
  DEFB $03,$01,$2E,$3A,$03,$0D,$61,$0F,$10,$0E,$B4,$70,$00,$08
LD438:
  DEFB $86,$61,$68,$38,$39,$01,$80,$14,$61,$98,$2B,$37,$61,$68,$00,$83
  DEFB $03,$2E,$3A,$03,$A9,$D4,$0E,$B8,$0F,$DA,$B0,$61,$00,$08
LD45C:
  DEFB $08,$4D,$4E,$00,$61,$A0,$00,$86,$36,$42,$03,$07,$61,$06,$78,$25
  DEFB $31,$02,$D7,$2A,$01,$04,$2E,$3A,$11,$8E,$0E,$16,$F9,$BF,$10,$D4
  DEFB $C0,$A7,$00,$20
LD483:
  DEFB $12,$4D,$4E,$00,$29,$2A,$01,$4B,$4C,$01,$00,$A0,$61,$0F,$DB,$88
  DEFB $D6,$88,$12,$10,$93,$12,$11,$C0,$B7,$00,$20
LD4A2:
  DEFB $58,$4D,$4E,$00,$29,$2A,$01,$61,$88,$00,$61,$06,$28,$02,$00,$03
  DEFB $02,$2E,$3A,$03,$13,$11,$61,$18,$13,$12,$61,$1F,$02,$30,$06,$01
  DEFB $C0,$AD,$00,$20
LD4C4:
  DEFB $89,$61,$29,$29,$2A,$01,$4A,$4B,$01,$24,$0A,$44,$50,$03,$23,$61
  DEFB $26,$00,$02,$00,$FA,$E8,$12,$6F,$13,$DA,$2C,$61,$00,$02
LD4E7:
  DEFB $08,$4D,$4E,$00,$61,$7F,$F3,$FE,$18,$62,$25,$31,$02,$01,$00,$5E
  DEFB $2E,$3A,$03,$15,$61,$1C,$1A,$F9,$39,$14,$4A,$B4,$C0,$00,$20
LD508:
  DEFB $88,$61,$22,$29,$2A,$01,$61,$25,$00,$61,$3E,$DA,$4A,$01,$00,$00
  DEFB $2E,$3A,$03,$AA,$14,$1B,$EE,$15,$F8,$B4,$30,$00,$08
LD529:
  DEFB $08,$4D,$4E,$00,$61,$A0,$00,$86,$39,$45,$03,$16,$61,$0B,$2E,$E1
  DEFB $F6,$FA,$25,$31,$02,$04,$00,$FD,$E2,$AE,$18,$10,$F8,$E1,$CB,$B0
  DEFB $05,$20,$04,$02,$01,$00,$08
LD555:
  DEFB $06,$4D,$4E,$00,$29,$2A,$01,$4B,$4C,$01,$89,$0B,$61,$18,$7E,$25
  DEFB $31,$02,$00,$04,$FB,$EC,$9E,$1A,$16,$12,$F9,$38,$18,$1F,$C2,$F0
  DEFB $E1,$00,$08
LD579:
  DEFB $89,$61,$6A,$29,$2A,$01,$4D,$4E,$01,$00,$61,$46,$7E,$25,$31,$02
  DEFB $DB,$D6,$62,$18,$14,$22,$1A,$4A,$93,$03,$30,$06,$01,$01,$61,$00
  DEFB $00,$80
LD59D:
  DEFB $08,$4D,$4E,$00,$61,$9A,$38,$39,$01,$20,$0F,$61,$26,$2B,$37,$61
  DEFB $20,$9E,$25,$31,$02,$00,$DE,$AB,$1E,$15,$AE,$F8,$1B,$C2,$3C,$A7
  DEFB $00,$02
LD5C5:
  DEFB $58,$4D,$4E,$00,$29,$2A,$01,$61,$88,$00,$61,$06,$AA,$02,$00,$07
  DEFB $2E,$3A,$03,$1D,$0B,$61,$14,$1D,$1C,$FF,$F9,$DB,$B4,$00,$00,$80
LD5E6:
  DEFB $89,$61,$28,$29,$2A,$01,$3F,$40,$01,$80,$08,$61,$98,$32,$35,$61
  DEFB $66,$00,$02,$00,$FA,$D8,$1C,$6E,$1D,$E3,$7B,$09,$28,$05,$B5,$61
  DEFB $00,$00,$80
LD60D:
  DEFB $88,$61,$22,$29,$2A,$01,$61,$25,$00,$61,$20,$9F,$25,$31,$02,$00
  DEFB $E2,$88,$1B,$1F,$B8,$1E,$F9,$3C,$06,$30,$06,$01,$AD,$00,$02
LD630:
  DEFB $86,$61,$68,$4B,$4C,$01,$80,$09,$61,$98,$3E,$41,$61,$82,$25,$31
  DEFB $02,$00,$E7,$FB,$2E,$3A,$03,$8E,$E9,$20,$1E,$F8,$BE,$1F,$C6,$B0
  DEFB $00,$00,$08
LD657:
  DEFB $08,$4D,$4E,$00,$61,$79,$F2,$97,$35,$36,$01,$14,$04,$34,$37,$A6
  DEFB $DA,$25,$31,$02,$81,$6C,$00,$04,$02,$2E,$3A,$03,$21,$61,$23,$1F
  DEFB $21,$61,$22,$20,$02,$30,$06,$01,$01,$00,$02
LD683:
  DEFB $88,$61,$22,$29,$2A,$01,$61,$25,$00,$61,$21,$4F,$25,$31,$02,$00
  DEFB $00,$03,$02,$2E,$3A,$03,$61,$20,$25,$2A,$61,$21,$24,$29,$03,$30
  DEFB $06,$01,$AD,$00,$00,$80
LD6A8:
  DEFB $80,$61,$B8,$00,$EC,$97,$32,$3E,$02,$15,$05,$26,$4A,$CE,$DA,$FF
  DEFB $0E,$04,$2E,$3A,$03,$C6,$A6,$20,$5C,$22,$05,$18,$03,$01,$01,$00
  DEFB $00,$02
LD6CE:
  DEFB $80,$61,$89,$00,$61,$48,$22,$25,$31,$02,$00,$0E,$03,$2E,$3A,$03
  DEFB $E1,$26,$26,$21,$5C,$24,$05,$30,$06,$02,$01,$61,$00,$02
LD6ED:
  DEFB $08,$4D,$4E,$00,$61,$7E,$F3,$FE,$02,$98,$00,$38,$2E,$3A,$03,$27
  DEFB $C7,$89,$25,$26,$2C,$25,$04,$28,$05,$02,$01,$00,$02
LD70B:
  DEFB $12,$4D,$4E,$00,$29,$2A,$01,$32,$33,$01,$00,$A0,$61,$0A,$00,$20
  DEFB $0A,$03,$2E,$3A,$03,$28,$26,$61,$30,$27,$26,$61,$2F,$02,$30,$06
  DEFB $01,$C0,$61,$00,$20
LD72E:
  DEFB $58,$4D,$4E,$00,$29,$2A,$01,$61,$88,$00,$61,$06,$99,$00,$5F,$2E
  DEFB $3A,$03,$29,$27,$61,$31,$28,$27,$61,$30,$04,$28,$05,$02,$AD,$00
  DEFB $00,$80
LD74F:
  DEFB $88,$61,$20,$29,$2A,$01,$00,$86,$3F,$4B,$02,$0D,$61,$09,$87,$31
  DEFB $32,$61,$E1,$D4,$AA,$2E,$3A,$03,$61,$28,$32,$88,$28,$6C,$07,$28
  DEFB $05,$02,$01,$00,$02
LD778:
  DEFB $08,$4D,$4E,$00,$61,$82,$41,$42,$01,$00,$A4,$61,$67,$25,$31,$02
  DEFB $92,$DB,$02,$04,$2E,$3A,$03,$2C,$9A,$21,$2B,$2B,$3F,$29,$2A,$D4
  DEFB $C0,$A7,$00,$20
LD79D:
  DEFB $86,$61,$82,$00,$A3,$39,$03,$17,$8B,$E4,$38,$E6,$D6,$25,$31,$02
  DEFB $2B,$04,$8B,$C2,$2A,$89,$F8,$30,$03,$30,$06,$01,$01,$61,$00,$08
LD7C4:
  DEFB $88,$61,$22,$29,$2A,$01,$61,$25,$00,$61,$20,$99,$25,$31,$02,$00
  DEFB $0E,$2E,$3A,$03,$61,$2A,$2E,$2D,$61,$2B,$2D,$2C,$61,$B4,$30,$00
  DEFB $08
LD7E7:
  DEFB $86,$61,$82,$00,$18,$41,$42,$01,$0C,$61,$19,$FE,$25,$31,$02,$D4
  DEFB $E8,$2E,$2C,$F8,$24,$C0,$06,$30,$06,$01,$01,$61,$00,$20
LD809:
  DEFB $08,$4D,$4E,$00,$61,$82,$4A,$4B,$01,$00,$A0,$61,$0B,$02,$86,$D9
  DEFB $00,$2E,$3A,$03,$2F,$22,$2C,$2E,$28,$2D,$3C,$A7,$00,$02
LD82B:
  DEFB $89,$61,$28,$29,$2A,$01,$38,$39,$01,$80,$03,$61,$98,$2B,$37,$61
  DEFB $66,$00,$02,$00,$FB,$E0,$2E,$99,$F8,$30,$04,$28,$05,$02,$01,$61
  DEFB $00,$08
LD852:
  DEFB $86,$61,$68,$4C,$4D,$01,$91,$10,$61,$82,$25,$31,$02,$00,$8E,$03
  DEFB $00,$DC,$29,$27,$A9,$2F,$EC,$08,$28,$05,$B5,$61,$00,$02
LD873:
  DEFB $08,$4D,$4E,$00,$61,$7F,$F3,$FE,$18,$27,$25,$31,$02,$00,$AA,$C8
  DEFB $32,$AA,$28,$32,$A1,$30,$B0,$07,$28,$05,$01,$01,$00,$08
LD894:
  DEFB $88,$61,$22,$29,$2A,$01,$61,$25,$00,$61,$20,$88,$25,$31,$02,$00
  DEFB $5F,$02,$2E,$3A,$03,$61,$31,$29,$33,$61,$32,$31,$F9,$8C,$B4,$00
  DEFB $02
LD8B8:
  DEFB $86,$61,$0A,$4D,$4E,$01,$00,$91,$61,$9F,$25,$31,$02,$DB,$9E,$FB
  DEFB $2E,$3A,$03,$D1,$22,$32,$34,$5B,$33,$34,$04,$18,$03,$01,$01,$00
  DEFB $00,$80
LD8DB:
  DEFB $88,$61,$22,$29,$2A,$01,$61,$25,$00,$61,$24,$BE,$25,$31,$02,$00
  DEFB $01,$00,$DA,$22,$35,$33,$29,$35,$34,$BC,$08,$20,$04,$AD,$00,$02
LD8FF:
  DEFB $08,$4D,$4E,$00,$61,$7E,$F3,$FE,$02,$22,$01,$00,$0E,$2E,$3A,$03
  DEFB $34,$D7,$22,$36,$35,$4B,$36,$06,$20,$04,$02,$01,$00,$00,$80
LD91E:
  DEFB $08,$4D,$4E,$00,$61,$82,$50,$51,$01,$00,$A4,$61,$61,$E2,$25,$31
  DEFB $02,$03,$00,$D6,$AE,$37,$35,$F8,$A9,$36,$30,$05,$18,$03,$01,$01
  DEFB $61,$00,$08
LD944:
  DEFB $06,$4D,$4E,$00,$29,$2A,$01,$50,$51,$01,$88,$04,$61,$09,$86,$43
  DEFB $4F,$61,$6E,$04,$03,$00,$DA,$88,$38,$36,$89,$38,$37,$3C,$E1,$00
  DEFB $02
LD969:
  DEFB $88,$61,$22,$29,$2A,$01,$61,$25,$00,$61,$24,$BE,$25,$31,$02,$00
  DEFB $04,$00,$DA,$22,$37,$39,$29,$38,$39,$BC,$07,$30,$06,$AD,$00,$02
LD98D:
  DEFB $08,$4D,$4E,$00,$61,$7F,$F3,$FE,$18,$26,$25,$31,$02,$00,$01,$C0
  DEFB $2E,$3A,$03,$40,$61,$3B,$38,$3A,$61,$48,$39,$06,$20,$04,$02,$01
  DEFB $61,$00,$20
LD9AE:
  DEFB $08,$4D,$4E,$00,$61,$78,$F2,$E4,$F8,$95,$8B,$25,$31,$02,$00,$00
  DEFB $04,$00,$2E,$3A,$03,$3E,$61,$3C,$39,$42,$48,$9C,$B4,$00,$02
LD9CF:
  DEFB $86,$61,$82,$00,$A6,$3D,$00,$18,$61,$43,$86,$DB,$00,$04,$2E,$3A
  DEFB $03,$69,$3B,$A1,$3C,$B0,$61,$00,$08
LD9F0:
  DEFB $08,$4D,$4E,$00,$61,$7E,$F3,$FE,$02,$22,$04,$00,$0E,$2E,$3A,$03
  DEFB $42,$BF,$22,$3E,$46,$4B,$45,$04,$20,$04,$02,$01,$00,$00,$80
LDA0F:
  DEFB $58,$4D,$4E,$00,$29,$2A,$01,$61,$89,$00,$61,$48,$23,$25,$31,$02
  DEFB $00,$E6,$D4,$43,$3B,$3D,$99,$44,$42,$45,$FC,$B4,$00,$02
LDA31:
  DEFB $08,$4D,$4E,$00,$61,$7E,$F3,$FE,$02,$98,$00,$38,$2E,$3A,$03,$44
  DEFB $BF,$8B,$40,$41,$47,$9C,$B4,$00,$02
LDA4E:
  DEFB $12,$4D,$4E,$00,$29,$2A,$01,$4B,$4C,$01,$00,$A4,$61,$61,$88,$25
  DEFB $31,$02,$04,$00,$07,$2E,$3A,$03,$45,$39,$3F,$41,$3E,$3A,$47,$3D
  DEFB $08,$18,$03,$02,$01,$61,$00,$00,$80
LDA74:
  DEFB $80,$61,$89,$00,$61,$48,$27,$25,$31,$02,$00,$8A,$C0,$40,$6A,$3D
  DEFB $1B,$05,$28,$05,$02,$01,$00,$00,$80
LDA90:
  DEFB $89,$61,$28,$29,$2A,$01,$44,$45,$01,$80,$15,$61,$98,$2B,$37,$61
  DEFB $66,$00,$04,$00,$FA,$D8,$3D,$6E,$46,$E3,$1B,$04,$18,$03,$02,$01
  DEFB $00,$00,$80
LDAB7:
  DEFB $89,$61,$6A,$29,$2A,$01,$4D,$4E,$01,$00,$61,$00,$E1,$DB,$AA,$00
  DEFB $02,$2E,$3A,$03,$3E,$E9,$44,$FC,$A7,$43,$03,$18,$01,$01,$61,$00
  DEFB $00,$80
LDADA:
  DEFB $89,$61,$28,$29,$2A,$01,$37,$38,$01,$80,$0E,$61,$89,$2D,$61,$82
  DEFB $25,$31,$02,$00,$FE,$FB,$E0,$22,$3F,$43,$E7,$41,$F9,$07,$28,$05
  DEFB $B0,$B5,$61,$00,$08
LDB03:
  DEFB $89,$61,$EB,$29,$2A,$01,$F4,$00,$F5,$ED,$FC,$88,$00,$04,$86,$2E
  DEFB $3A,$03,$61,$40,$AA,$46,$3E,$87,$3F,$03,$30,$06,$02,$C0,$AD,$00
  DEFB $20
LDB25:
  DEFB $80,$61,$B8,$00,$EC,$86,$37,$43,$02,$00,$07,$18,$89,$25,$31,$38
  DEFB $00,$04,$04,$2E,$3A,$03,$BB,$E5,$45,$47,$B3,$B0,$3F,$4B,$03,$28
  DEFB $05,$01,$01,$00,$08
LDB4C:
  DEFB $80,$61,$B8,$00,$EC,$81,$A7,$35,$36,$00,$00,$06,$33,$34,$37,$38
  DEFB $25,$31,$02,$B9,$EB,$04,$D4,$BA,$46,$F8,$A4,$4B,$C0,$04,$20,$04
  DEFB $02,$01,$00,$00,$20

;
  INCLUDE "desolroom.asm"
;
; Main menu image and mask, ZX0-packed
  INCLUDE "desolmenu.asm"
;
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
DesolateRoomEnd:

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
  DEFB $94,$01,$58,$81,$26,$2A,$98,$27,$2D,$00,$19,$81,$2C,$28,$2B,$B0
  DEFB $29,$00,$08
; Encoded screen for Inventory/Info popup, in Tileset #2
LF329:
  DEFB $85,$01,$88,$26,$2A,$19,$81,$27,$2D,$00,$B9,$2C,$E8,$56,$38,$28
  DEFB $2B,$FE,$2C,$29,$00,$02
LF42F:
; Encoded screen: Data cartridge reader screen, in Tileset #2
  DEFB $20,$03,$04,$21,$96,$15,$05,$07,$11,$0F,$19,$12,$0B,$07,$0D,$00
  DEFB $63,$0E,$06,$C0,$E8,$8F,$13,$10,$FE,$2E,$14,$B9,$2B,$00,$0C,$16
  DEFB $BA,$FE,$F2,$78,$06,$09,$08,$FE,$2C,$0A,$00,$02
LF468:
; Encoded screen: Door Lock panel popup, in Tileset #2
  DEFB $20,$03,$04,$88,$17,$01,$22,$07,$00,$0B,$06,$CB,$E8,$0F,$AE,$FE
  DEFB $06,$C2,$8F,$15,$05,$D0,$21,$F6,$07,$1A,$1B,$1C,$0B,$E8,$09,$1D
  DEFB $1E,$1F,$06,$21,$BD,$18,$19,$20,$21,$22,$D0,$9A,$23,$24,$25,$3E
  DEFB $09,$08,$FE,$3F,$0A,$09,$F6,$00,$00,$80
; Main menu screen moving background, 96 tiles
LF515:
  DEFB $47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$00,$00,$00,$00
  DEFB $00,$00,$00,$00,$00,$00,$00,$00,$47,$47,$47,$47,$47,$47,$47,$47
  DEFB $47,$00,$00,$00,$47,$00,$00,$00,$00,$47,$47,$47,$47,$00,$00,$00
  DEFB $47,$00,$00,$00,$00,$47,$47,$47,$47,$47,$00,$00,$47,$00,$00,$00
  DEFB $00,$47,$47,$47,$47,$47,$47,$00,$47,$00,$00,$00,$00,$47,$47,$47
  DEFB $47,$47,$47,$00,$47,$47,$47,$47,$47,$47,$47,$47,$47,$00,$00,$00


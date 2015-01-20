header
lorom

;Prevent the leading zero routine from doing anything
ORG $008EE5
    NOP #2
    
;Set up a NOP sled so I don't have to do math
ORG $008EC6
    NOP #37
    NOP #4

ORG $008EC6
    JSR $9012 ;Jump to our code and get the first two X's
    
    LDX #$06
    ShellLoop: ;Loop through the shell positions and make sure they're right
    LDA ShellData, X
    CMP $7E00E4, X
    BNE Skip3
    DEX
    BPL ShellLoop
    
    DEC $0F2B
    BRA Skip3
    
    ShellData:
    db $0A,$68,$68,$4A,$92,$75,$60
    
    Skip3:

;Set up a NOP sled so I don't have to do math
ORG $009012
    NOP #$32
    

ORG $009012
    LDA #$27 ;Set a bunch of dashes
    LDX #$03
    ClearScore:
    STA $0F28, X
    DEX
    BNE ClearScore
    
    REP #$20
    
    LDA $7E1805 ;Thow Block
    CMP.w #$00e5 ;$d8 to $e5 
    BCS Skip1
    CMP.w #$00d9 ;$d8 to $e5
    BCC Skip1
    DEC $0F2A
    
    Skip1:
    LDA.w #$370D ;Mushroom
    CMP $7E00E2
    BNE Skip2
    DEC $0F29
    
    Skip2:
    
    SEP #$20
    
    ;Busy Wait to maintain compatibility with TAS movies
    LDA #$E0 ;Loop 224 times for a total of 896 cycles
    LoopPoint:
    DEA
    BNE LoopPoint
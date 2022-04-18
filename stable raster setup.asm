                        //------------------------------------------------------------------------------
                        // side border removal
                        //
                        // 10/05/2020 
                        //------------------------------------------------------------------------------

BasicUpstart2(main)

                        //------------------------------------------------------------------------------
						// import music.
                        //------------------------------------------------------------------------------

                        //.var music = LoadSid("Soldier_of_Fortune.sid")

                        //------------------------------------------------------------------------------
						// import standard library definitions
                        //------------------------------------------------------------------------------
						#import "standardLibrary.asm"
                        //------------------------------------------------------------------------------
                        
                        *=$080d "Main Code"

main: 

                        jsr $e544


                        sei		 
                        lda #$7f
                        sta $dc0d
                        sta $dd0d
                        lda #$35
                        sta $01	
                        lda #<irq1
                        ldx #>irq1
                        sta $fffe
                        stx $ffff
                        lda #$01
                        sta $d01a
                        lda #$30
                        sta $d012
                        lda #$1b
                        sta $d011
                        lda #$00
                        sta $d020
                        sta $d021
                        lda #%11111111
                        sta $d015
                        asl $d019
                        bit $dc0d 
                        bit $dd0d
                        cli
 c45e:                  jmp c45e

                        //------------------------------------------------------------------------------ 
irq1:
                                        
                        sta areg
                        stx xreg
                        sty yreg
                
                        lda #<irq2	    
                        ldx #>irq2	    
                        sta $fffe	    
                        stx $ffff   	
                        inc $d012	    
                        asl $d019	    
                        // jmp return_mid

                        //------------------------------------------------------------------------------
                        // Part 2 of the Main interrupt handler
                        //------------------------------------------------------------------------------            
irq2:
                        ldx #$09	    
                        dex		        
                        bne *-1	        
                
                        lda #WHITE
                        sta $d020	

                        // this is where the code will go to open the side border, we have a stable raster now to use it.

                        ldx #$08
                    !:  dex 
                        bne !-
                        bit $01
                        lda $d012    // Raster Position
                        cmp $d012    // Raster Position
                        beq irq2a

irq2a: 
                        lda #$CD
                        ldx #$C0

                        ldy #$00
                        jsr timing04

                        ldy #$3D
                        sty sp0y
                        dey 
                        iny 
                        sty sp1y
                        dey 
                        iny 
                        sty sp2y
                        dey 
                        iny 
                        sty sp3y

                        lda #$CD
                        ldx #$C0
                        ldy #$00
                        jsr timing02a
                        jsr timing03
                        jsr timing03
                        jsr timing03
                        jsr timing03
                        jsr timing03
                        jsr timing03
                        jsr timing01
                        jsr timing03
                        jsr timing03
                        jsr timing03
                        jsr timing03
                        jsr timing03
                        jsr timing03
                        jsr timing01
                        jsr timing03
                        jsr timing03
                        
                        ldy #$00
                        jsr timing03a
                        
                        ldy #$00
                        jsr timing03b
                        jsr timing03
                        jsr timing03
                        jsr timing01
                        jsr timing03
                        jsr timing03
                
                        lda #<irq3	    
                        ldx #>irq3	    
                        ldy #$88    
                        asl $d019	  
                        jmp return_irq

                        //------------------------------------------------------------------------------
                        // Part 3 of the Main interrupt handler
                        //------------------------------------------------------------------------------     
irq3:
                        sta areg
                        stx xreg
                        sty yreg
                        ldy #$13	
                        dey		    
                        bne *-1	    
                       
                        lda #BLACK	
                        sta $d020
 
                        lda #LIGHT_BLUE
                        sta spritecolors
                        sta spritecolors+1
                        sta spritecolors+2
                        sta spritecolors+3
                        sta spritecolors+4
                        sta spritecolors+5
                        sta spritecolors+6
                        sta spritecolors+7

						// define '..case..' sprites
						
                        lda #(spr_imgSTOP / 64)
						sta 2040
						sta 2041
                        lda #(spr_imgC / 64)
						sta 2042
                        lda #(spr_imgA / 64) 
						sta 2043
                        lda #(spr_imgS / 64) 
						sta 2044
                        lda #(spr_imgE / 64)
						sta 2045
                        lda #(spr_imgSTOP / 64)
                        sta 2046
                        sta 2047
                        				
						// define x position of sprites
                        
						lda #10
						sta sprite0x
						adc #26
						sta sprite1x
						adc #26
						sta sprite2x
						adc #26
						sta sprite3x
						adc #26
						sta sprite4x
						adc #26
						sta sprite5x
						adc #26
						sta sprite6x
						adc #26
						sta sprite7x
						
                        lda #80
                        sta sprite0y
                        sta sprite1y
                        sta sprite2y
                        sta sprite3y
                        sta sprite4y
                        sta sprite5y
                        sta sprite6y
						sta sprite7y

                        lda #<irq1	
                        ldx #>irq1	
                        ldy #$34
                        asl $d019	  
                        jmp return_irq


                        //-----------------------------------------------------------
                        // IRQ Process Routines.
                        //-----------------------------------------------------------
return_irq:
                    	sty $d012
return_mid:
                        sta $fffe
                        stx $ffff
return_last:
                        lda areg
                        ldx xreg
                        ldy yreg
rti_vector:
	                    rti                        
                        //-----------------------------------------------------------

timing01:               nop
                        nop 
                        nop 
                        nop 
                        nop 
                        nop 
                        nop 
                        nop 
                        nop 
                        nop 
                        nop 
                        nop 
                        nop 
                        nop 
                        nop 
                        nop 
                        stx $d016    // VIC Control Register 2
                        sta $d016    // VIC Control Register 2
                        stx $d016    // VIC Control Register 2
                        sta $d016    // VIC Control Register 2
                        rts 
                        //-----------------------------------------------------------

timing02:               nop 
                        nop 
                        nop 
                        nop 
                        nop 
                        nop 
                        nop 
                        nop 
                        nop 
                        nop 
                        nop 
                        nop 
                        nop 
                        nop 
                        nop 
                        nop 
timing02a:              nop 
                        nop 
                        nop 
                        nop 
                        bit $01
                        stx $d016    // VIC Control Register 2
                        sta $d016    // VIC Control Register 2
                        stx $d016    // VIC Control Register 2
                        sta $d016    // VIC Control Register 2
                        rts 
                        //-----------------------------------------------------------

timing03:               nop 
                        nop 
                        nop 
                        nop 
                        nop 
                        nop 
                        nop 
                        nop 
                        nop 
                        nop 
timing03a:              nop 
                        nop 
                        nop 
timing03b:              nop 
                        nop 
                        nop 
                        stx $d016    // VIC Control Register 2
                        sta $d016    // VIC Control Register 2
                        rts 
                        //-----------------------------------------------------------

timing04:               nop 
                        nop 
                        nop 
                        nop 
                        nop 
                        nop 
                        nop 
                        nop 
                        bit $01
                        stx $d016    // VIC Control Register 2
                        sta $d016    // VIC Control Register 2
                        rts 
                        //-----------------------------------------------------------


                        //-----------------------------------------------------------


                        //-----------------------------------------------------------
areg:                   .byte $00
xreg:                   .byte $00
yreg:                   .byte $00 

sp0y:                   .byte $3E
sp1y:                   .byte $3E
sp2y:                   .byte $3E
sp3y:                   .byte $3E

X_POS: 					.byte $a0,$00
                        //-----------------------------------------------------------
                        
                        
                        *=$3000 "sprite font"
                        #import "spriteSet.asm"
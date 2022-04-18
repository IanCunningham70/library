                        //------------------------------------------------------------------------------						
						// fade from white to black
                        //------------------------------------------------------------------------------
white2blue:				ldy white2blue_number
						cpy #7					// maximum number in colour table
						bne !+
						lda #BLACK
						sta fade_border+1
						sta fade_screen+1			
						rts
			!:			lda white2blue_table,y
						sta fade_border+1
						sta fade_screen+1
						jsr pauseQuick
						inc white2blue_number
						jmp white2blue
                        //------------------------------------------------------------------------------
white2blue_number:		.byte $00
white2blue_table:		.byte $01,$0d,$03,$0c,$04,$02,$09,$00					//  white to black
                        //------------------------------------------------------------------------------

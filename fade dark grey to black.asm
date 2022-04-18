                        //------------------------------------------------------------------------------						
						// fade from grey to black
                        //------------------------------------------------------------------------------						
fade2black:				lda fade2delay
						sec
						sbc #$03
						and #$07
						sta fade2delay
						bcc !+
						rts
                        //------------------------------------------------------------------------------
			!:			ldx fade2count
						cpx fade2max
						beq !+
						lda fade2black_table,x
						sta fade_color+1
						inc fade2count
						rts
			!:			lda #$ad
						sta fader_black
						sta BlackPause
						rts
                        //------------------------------------------------------------------------------						
fade2black_table:		.byte $b,$b,$9,$9,$0,$0,$0,$0,$0,$0,$0,$0		// from dark grey to black
						.byte $ff,$ff
                        //------------------------------------------------------------------------------						

                        //------------------------------------------------------------------------------						
						// fade from blue to dark grey
                        //------------------------------------------------------------------------------						
fade2dark_grey:			lda fade2delay
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
						lda fade2grey_table,x
						sta fade_color+1
						inc fade2count
						rts
			!:			lda #$ad
						sta fader_grey
						sta GreyPause
						rts
                        //------------------------------------------------------------------------------						
fade2grey_table:		.byte $5,$5,$8,$8,$9,$9,$b,$b,$b,$b,$b,$b		// from green to dark grey
						.byte $ff,$ff
                        //------------------------------------------------------------------------------						

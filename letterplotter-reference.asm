text_screen01:			// what if you only had five chars ?
						lda #BLACK
						jsr blacken
						ldx #$00
						ldy #$08
						stx word_count
						sty word_max
						jsr color_blocks
						inc screen_number
						jmp screen01

                        //------------------------------------------------------------------------------
color_blocks:			ldx word_count
						cpx word_max 
						bne color_block2
						rts
color_block2:			lda x_table,x
						ldy y_table,x
						sta y_counter
						sty x_counter
						lda plot_load_lo,x
						ldy plot_load_hi,x
						sta color_load+1
						sty color_load+2
						lda plot_save_lo,x
						ldy plot_save_hi,x
						sta color_save+1
						sty color_save+2
						jsr color_plotter
						jsr pauseLoop
						jsr pauseLoop
						inc word_count
						jmp color_blocks
                        //------------------------------------------------------------------------------
						// this routine plots color from memory to the screen in any size, defined by
						// the values in x_counter and y_counter before calling.
                        //------------------------------------------------------------------------------
color_plotter:			ldy #$00
						ldx #$00
color_load:				lda $2800,x
color_save:				sta $d800,x
						inx
						cpx x_counter
						bne color_load
						lda color_load+1						// add 40 to get next line pointers
						clc
						adc #40
						sta color_load+1
						lda color_load+2
						adc #$00
						sta color_load+2
						lda color_save+1
						clc
						adc #40
						sta color_save+1
						lda color_save+2
						adc #$00
						sta color_save+2
						iny
						cpy y_counter
						bne color_plotter+2
						rts
                        //------------------------------------------------------------------------------
x_table:				.byte 08,08,08,08,08,08,08,08					// what if you only had 5 chars ?
						.byte 10,06,06,06,08,08							// * could that be enough
						.byte 08,08,08									// lets find out

y_table:				.byte 18,06,11,13,12,13,20,03					// what if you only had 5 chars ?
						.byte 10,17,15,08,23,03							// * could that be enough
						.byte 16,14,19									// lets find out
x_counter:				.byte $00										// how many chars to plot
y_counter:				.byte $00										// how many lines to plot

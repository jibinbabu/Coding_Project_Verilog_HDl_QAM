module qam_top(CLOCK_50,
               VGA_CLK,
               VGA_VS,
               VGA_HS,
				   VGA_BLANK_n,
               VGA_B ,
               VGA_G ,
				   VGA_R, 
               KEY,
					swi);
					
input CLOCK_50;
output VGA_CLK;
output VGA_VS;
output VGA_HS;
output VGA_BLANK_n;
output wire [7:0] VGA_B ;
output wire [7:0] VGA_G ;  
output wire [7:0] VGA_R;  
input KEY;
input swi;
							


wire VGA_BLANK_n,VGA_HS,VGA_VS,VGA_CLK;

////////////////////////////////////////////
//wire to hold the signal
wire signed[18:0] ValSignal;

wire signed[3:0] isig;
wire signed[3:0] qsig;


///////////////////////////////////////////
// signal_generator instance

Signal_Generator SIG_GEN(.CLOCK_50(CLOCK_50),.signal(ValSignal),.i(isig),.q(qsig));

/////////////////////////////////////////////
//oscilloscope instance
		OScilloscope osc_instance(.CLOCK_50(CLOCK_50),.signal(ValSignal),.oVGA_CLK(VGA_CLK),
		.oVS(VGA_VS),.oHS(VGA_HS),.oBLANK_n(VGA_BLANK_n),.b_data(VGA_B),.g_data(VGA_G),.r_data(VGA_R),.i(isig),.q(qsig),.k(KEY),.s(swi));

endmodule 
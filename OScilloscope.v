module OScilloscope( CLOCK_50 ,
							signal ,
							oVGA_CLK,
							oVS,oHS,
							oBLANK_n,
							b_data,
							g_data,
							r_data,
							i,
							q,
							k,
							s);

input CLOCK_50;
input wire signed[18:0] signal;
output oVGA_CLK;
output oVS;
output oHS;
output oBLANK_n;
output reg [7:0] b_data;
output reg [7:0] g_data ;  
output reg [7:0] r_data;
input k;
input wire signed[3:0] i;
input wire signed[3:0] q; 
input s;

	//wire signed[3:0] isignal;
	//wire signed[3:0] qsignal;                   

	//assign isignal=i;
	//assign qsignal=q;
	// Variables for VGA Clock 
	reg vga_clk_reg;                   
	wire iVGA_CLK;

	//Variables for (x,y) coordinates VGA
	wire [10:0] CX;
	wire [9:0] CY;

	integer cf=2;
	 integer cf_count=0;
	integer mov=0;
	 

	//Oscilloscope parameters
		//Horizontal
		parameter DivX=9;
	parameter Ttotal=0.000025;   		// total time represented in the screen
	parameter pixelsH=640.0;  		// number of horizontal pixels
   parameter IncPixX= 0.000025/DivX;				// time between two consecutive pixels
	
	//Amplitude
	parameter DivY=7;
	parameter Atotal=16.0;				// total volts represented in the screen
	parameter pixelsV=480.0;  			// number of vertical pixels	
	parameter IncPixY=Atotal/(pixelsV-1.0);	// volts between two consecutive pixels

// Sinusoidal wave amplitude	
	parameter Amp=3.0;					// maximum amplitude of sinusoidal wave [-Amp, Amp]
	parameter integer Apixels=Amp/IncPixY;	// number of pixels to represent the maximum amplitude	

//Vector to store the input signal 
	parameter integer nc=5;					
	reg signed[18:0] capturedVals[nc*256-1:0]; 		// vector with values of input signal
	integer index;							// index of the vector

		reg signed[3:0] isignal[nc*256-1:0]; 
		reg signed[3:0] qsignal[nc*256-1:0];
		reg signed[3:0] Ic;
		reg signed [3:0] Qc;
		
		integer iq;//index for cap i n q
	
	
//Read the signal values from the vector 
	integer j; 								// read the correct element of the vector
	parameter integer nf=1; 					//Vector points between two consecutive pixels total*50000000/pixelsH-1.0
	integer jiq; 
//Value of the current pixel 
	reg [9:0] ValforVGA; 
	reg [9:0] oldValforVGA; 



//////////////////////////////////////////////////////////////////////////////////////////

// 25 MHz clock for the VGA clock

always @(posedge CLOCK_50)
begin
	vga_clk_reg =~vga_clk_reg;
end

assign iVGA_CLK =vga_clk_reg  ;
assign oVGA_CLK =~iVGA_CLK;


// instance VGA controller

VGA_Controller VGA_ins( .vga_clk(iVGA_CLK),
                        .reset(1'b0),
                        .BLANK_n(oBLANK_n),
                    		.HS(oHS),
                        .VS(oVS),
								.CoorX(CX),
								.CoorY(CY));
						

// Store input signal in a vector 		

		always@(negedge CLOCK_50)

		begin
		capturedVals[index]<=signal;
		if(index<nc*256-1)
		begin
		index<=index+1;
		end
		//else
		//index<=0;

		end
		
		always@(negedge CLOCK_50)

		begin
		isignal[iq]<=i;
		qsignal[iq]<=q;
		if(iq<nc*256-1)
		begin
		iq<=iq+1;
		end
		//else
		//iq<=0;

		end



// Read the correct point of the signal stored in the vector and calculate the pixel associated 
//given the amplitude and the parameters of the oscilloscope 
		always@(negedge iVGA_CLK)
begin
	if (oBLANK_n==1)
	begin
	
		if(j>=nc*256-nf)
			j<=0;
		else
			j<=j+nf;
			
		if(jiq>=nc*256-1)
		begin
		jiq<=0;
		end
		else
		jiq<=jiq+1;
			
		ValforVGA <=239-((2*Apixels*capturedVals[j])>>17);
		//ValforVGA <=100*isignal[jiq];
		Ic<=isignal[jiq];
		Qc<=qsignal[jiq];
		
	end
	else
		j<=mov;
		jiq<=mov;
end


		always @(negedge oVS)
			
		begin
		if(s==1'd0)
		begin
				if (cf_count==cf)
				begin
				cf_count<=0;
				if(mov<nc*256-nf)
				begin
				 mov<=mov+nf;
				end
				else
				begin
					mov<=0;
				end
				end
			else	
			begin  
			cf_count<=cf_count+1;
			end
end
	   end




always@(negedge iVGA_CLK)

begin

if (k==1)
begin

if ((CX==320)||(CY==240))
    begin
    b_data<=8'd255;
    g_data<=8'd255;
    r_data<=8'd255;
    end
	 
	
   else
	 begin
	 b_data<=8'd0;
	 g_data<=8'd0;
	 r_data<=8'd0;
	 end 
	 
	
	 if (Ic==1 && Qc ==1 )
	 begin
	 
	 if ((CX==400&&CY==180)||(CX==401&&CY==180)||(CX==399&&CY==180)||(CX==400&&CY==179)||(CX==401&&CY==179)||
	 (CX==399&&CY==179)||(CX==400&&CY==181)||(CX==401&&CY==181)||(CX==399&&CY==181))

    begin

         b_data<=8'd0;
			g_data<=8'd255;
			r_data<=8'd0;

		end
		end

 
		if (Ic==1 && Qc ==2 )
		begin
	 
	 
		if ((CX==400&&CY==60)||(CX==401&&CY==60)||(CX==399&&CY==60)||(CX==400&&CY==59)||
		(CX==401&&CY==59)||(CX==399&&CY==59)||(CX==400&&CY==61)||(CX==401&&CY==61)||(CX==399&&CY==61))

       begin
			b_data<=8'd0;
			g_data<=8'd255;
			r_data<=8'd0;
		 end
		 end

 

		if (Ic==2 && Qc ==1)
		begin
	 
	
		if ((CX==560&&CY==180)||(CX==561&&CY==180)||(CX==559&&CY==180)||
		(CX==560&&CY==179)||(CX==561&&CY==179)||(CX==559&&CY==179)||
		(CX==560&&CY==181)||(CX==561&&CY==181)||(CX==559&&CY==181))

       begin
		b_data<=8'd0;
		g_data<=8'd255;
		r_data<=8'd0;

		end
		end

		if (Ic==2 && Qc ==2 )
		begin
	 

		if ((CX==560&&CY==60)||(CX==561&&CY==60)||(CX==559&&CY==60)||
		(CX==560&&CY==59)||(CX==561&&CY==59)||(CX==559&&CY==59)||
		(CX==560&&CY==61)||(CX==561&&CY==61)||(CX==559&&CY==61))

       begin

         b_data<=8'd0;
			g_data<=8'd255;
			r_data<=8'd0;

		end
		end

		if (Ic==-1 && Qc ==1 )
		begin
	 
	 
		 
		 if ((CX==240&&CY==180)||(CX==240&&CY==179)||(CX==240&&CY==181)||
		 (CX==241&&CY==180)||(CX==241&&CY==179)||(CX==241&&CY==181)||
		 (CX==239&&CY==180)||(CX==239&&CY==181)||(CX==239&&CY==179))
       begin
       b_data<=8'd0;
		 g_data<=8'd255;
		 r_data<=8'd0;
		 
		 end
		 end
		 
		if (Ic==-1 && Qc ==2 )
			 begin
			 
		 
		 if ((CX==240&&CY==60)||(CX==240&&CY==61)||(CX==240&&CY==59)||
		 (CX==241&&CY==60)||(CX==241&&CY==61)||(CX==241&&CY==59)||
		 (CX==239&&CY==60)||(CX==239&&CY==61)||(CX==239&&CY==59))
				 begin
				 b_data<=8'd0;
		 g_data<=8'd255;
		 r_data<=8'd0;
		 
		 end
		 end
		 
		if (Ic==-2 && Qc ==1 )
			 begin
			 
		 
		 if ((CX==80&&CY==180)||(CX==80&&CY==181)||(CX==80&&CY==179)||
		 (CX==81&&CY==180)||(CX==81&&CY==181)||(CX==81&&CY==179)||
		 (CX==79&&CY==180)||(CX==79&&CY==179)||(CX==79&&CY==181))
				 begin
				 b_data<=8'd0;
		 g_data<=8'd255;
		 r_data<=8'd0;
		 
		 end
		 end
		 
		if (Ic==-2 && Qc == 2)
			 begin
			 
		 
		 if ((CX==80&&CY==60)||(CX==80&&CY==61)||(CX==80&&CY==59)||(CX==81&&CY==60)||(CX==81&&CY==61)||
		 (CX==81&&CY==59)||(CX==79&&CY==60)||(CX==79&&CY==61)||(CX==79&&CY==59))
				 begin
				 b_data<=8'd0;
		 g_data<=8'd255;
		 r_data<=8'd0;
		 
		 end
		 end
			
			
			if (Ic==-1 && Qc  ==-1 )
			 begin
			 
		 
		 if ((CX==240&&CY==300)||(CX==240&&CY==301)||(CX==240&&CY==299)||
		 (CX==241&&CY==300)||(CX==241&&CY==301)||(CX==241&&CY==299)||
		 (CX==239&&CY==300)||(CX==239&&CY==301)||(CX==239&&CY==299))
				 begin
				 b_data<=8'd0;
		 g_data<=8'd255;
		 r_data<=8'd0;
		 
		 end
		 end
		 
		if (Ic==-1 && Qc  == -2)
			 begin
			 
		 
		 if ((CX==240&&CY==420)||(CX==240&&CY==421)||(CX==240&&CY==419)||
		 (CX==241&&CY==420)||(CX==241&&CY==421)||(CX==241&&CY==419)||
		 (CX==239&&CY==420)||(CX==239&&CY==419)||(CX==239&&CY==421))
				 begin
				 b_data<=8'd0;
		 g_data<=8'd255;
		 r_data<=8'd0;
		 
		 end
		 end
		 
		if (Ic==-2 && Qc  ==-1 )
			 begin
			 
		 
		 if ((CX==80&&CY==300)||(CX==80&&CY==301)||(CX==80&&CY==299)||
		 (CX==81&&CY==300)||(CX==81&&CY==301)||(CX==81&&CY==299)||
		 (CX==79&&CY==300)||(CX==79&&CY==301)||(CX==79&&CY==299))
				 begin
				 b_data<=8'd0;
		 g_data<=8'd255;
		 r_data<=8'd0;
		 
		 end
		 end
		
		if (Ic==-2 && Qc  == -2)
			 begin
			 
		 if ((CX==80&&CY==420)||(CX==80&&CY==421)||(CX==80&&CY==419)||(CX==81&&CY==420)||(CX==81&&CY==421)||
		 (CX==81&&CY==59)||(CX==79&&CY==420)||(CX==79&&CY==421)||(CX==79&&CY==419))
				 begin
				 b_data<=8'd0;
		 g_data<=8'd255;
		 r_data<=8'd0;
		 
		 end
		 end
			
			
			

		 if (Ic==1 && Qc  ==-1 )
			 begin
			 

		 if ((CX==400&&CY==300)||(CX==401&&CY==300)||(CX==399&&CY==300)||
		 (CX==400&&CY==301)||(CX==401&&CY==301)||(CX==399&&CY==301)||
		 (CX==400&&CY==299)||(CX==401&&CY==299)||(CX==399&&CY==299))

				 begin

		 b_data<=8'd0;
		 g_data<=8'd255;
		 r_data<=8'd0;

		 end
		 end

		if (Ic==1 && Qc  == -2)
			 begin
			 
		 

		 if ((CX==400&&CY==420)||(CX==401&&CY==420)||(CX==399&&CY==420)||
		 (CX==400&&CY==421)||(CX==401&&CY==421)||(CX==399&&CY==421)||
		 (CX==400&&CY==419)||(CX==401&&CY==419)||(CX==399&&CY==419))

				 begin
				 
		 b_data<=8'd0;
		 g_data<=8'd255;
		 r_data<=8'd0;
		 
		 end
		 end

		 
		if (Ic==2 && Qc ==-1 )
			 begin

		 if ((CX==560&&CY==300)||(CX==561&&CY==300)||(CX==559&&CY==300)||
		 (CX==560&&CY==301)||(CX==561&&CY==301)||(CX==559&&CY==301)||
		 (CX==560&&CY==299)||(CX==561&&CY==299)||(CX==559&&CY==299))

				 begin

		 b_data<=8'd0;
		 g_data<=8'd255;
		 r_data<=8'd0;

		 end
		 end
		 
		if (Ic==2 && Qc == -2)
			 begin
	
		 if ((CX==560&&CY==420)||(CX==561&&CY==420)||(CX==559&&CY==420)||
		 (CX==560&&CY==421)||(CX==561&&CY==421)||(CX==559&&CY==421)||
		 (CX==560&&CY==419)||(CX==561&&CY==419)||(CX==559&&CY==419))

			 begin

		 b_data<=8'd0;
		 g_data<=8'd255;
		 r_data<=8'd0;

		 end
       end

end
// SIGNAL WAVEFORM


else 
begin

oldValforVGA<=ValforVGA; //Update the value of oldValforVGA
//Display the Coordinate Y of the current Coordinate X
if (CY==ValforVGA)
begin
		//Connect points with vertical lines (old value <current value)
		r_data<=8'b11111111;
		g_data<=8'b00000000;
		b_data<=8'b00000000;
end
else if (oldValforVGA<CY && CY<ValforVGA) 
			begin
			r_data<=8'b11111111;
			g_data<=8'b00000000;
			b_data<=8'b00000000;//connect points with vertical lines (old value >current value)
			end
else if (oldValforVGA>CY && CY>ValforVGA) 
			begin
			r_data<=8'b11111111;
			g_data<=8'b00000000;
			b_data<=8'b00000000;//connect points with vertical lines (old value >current value)
			end
else if (CX==63 || CX==127 ||CX==191 ||CX==255 ||CX==319 ||CX==383 || CX==447 ||CX==511 ||CX==575 ||CX==639)
		begin
		b_data<=8'b11111111 ;
		g_data<=8'b11111111;
		r_data<=8'b11111111;
		end
else if (CY==59 || CY==119 ||CY==179 ||CY==239 ||CY==299 ||CY==359 ||CY==419||CY==479)
		begin
		b_data<=8'b11111111;
		g_data<=8'b11111111;
		r_data<=8'b11111111;
		end
else
begin
		b_data<=8'b00000000 ;
		g_data<=8'b00000000;
		r_data<=8'b00000000;
end

end
end

endmodule 

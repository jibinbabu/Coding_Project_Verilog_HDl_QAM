








module  Signal_Generator(CLOCK_50,			  
				             i,
				             q,
				             signal);
 
 input CLOCK_50;

reg signed[3:0] inphase_signal=0;
reg signed[3:0] quadrature_signal=0; //signed


output  reg signed[18:0] signal;
output  reg signed[3:0] i;
output  reg signed[3:0]  q;

 
reg [15:0] data=16'b0001011100110101;
 integer bit_ctl=0;

reg [2:0] symbol_count=0;
reg [7:0] sineaddr=0	;
reg[7:0] cosaddr=64	;
reg signed[15:0] sineMod;
reg signed[15:0] cosMod;

integer timing=0;
wire[3:0] var;






	always@(posedge CLOCK_50)
	begin
				if(timing<=255)
					begin
						timing<=timing+1;
					if (bit_ctl<=12)
					begin
					
						 i<=inphase_signal;
					   q<=quadrature_signal; //should update 4 times
						
									
						signal<=i*cosMod-q*sineMod;//signal wave form
				
						cosaddr<=cosaddr+1;
					sineaddr<=sineaddr+1;
					
					end
					
					else 
					begin
					bit_ctl<=0;
					//timing<=0;
					end
														
					
				end
				
				else
				begin
				bit_ctl<=bit_ctl+4;
				timing<=0;
				//i<=i+1;
				end
		end			
				
			
			
	assign var={data[bit_ctl+3],data[bit_ctl+2],data[bit_ctl+1],data[bit_ctl]};

				always @(var)
				begin 

				case (var)
							4'b0000:begin		inphase_signal<= 4'b0001 ;
													quadrature_signal<=4'b0001 ;
							end

							4'b0001 :begin   	inphase_signal<=4'b0010 ;
													quadrature_signal<=4'b0001 ;
							end
							4'b0010 :begin inphase_signal=4'b0001 ;
												quadrature_signal=4'b0010 ;
							end
							4'b0011 :begin inphase_signal=4'b0010 ;
												quadrature_signal=4'b0010 ;
							
							end
							4'b0100 :begin inphase_signal=4'b1111 ;
										 quadrature_signal=4'b0001 ;
							end
							4'b0101 :begin inphase_signal=4'b1110 ;
										 quadrature_signal=4'b0001 ;
							end
							4'b0110 :begin inphase_signal=4'b1110 ;
										 quadrature_signal=4'b1110 ;
							end
							4'b0111 :begin inphase_signal=4'b1111 ;
										 quadrature_signal=4'b0010 ;
							end
							4'b1000 :begin inphase_signal=4'b1111 ;
										 quadrature_signal=4'b1111 ;
							end
							4'b1001 :begin inphase_signal=4'b1110 ;
										 quadrature_signal=4'b1111 ;
							end
							4'b1010 :begin inphase_signal=4'b1110 ;
										 quadrature_signal=4'b1110 ;
							end
							4'b1011 :begin inphase_signal=4'b1111 ;
										 quadrature_signal=4'b1110 ;
							end
							4'b1100 :begin inphase_signal=4'b0001 ;
										 quadrature_signal=4'b1111 ;
							end
							4'b1101 :begin inphase_signal=4'b0010 ;
										 quadrature_signal=4'b1111 ;
							end
							4'b1110 :begin inphase_signal=4'b0001 ;
										 quadrature_signal=4'b1110 ;
							end
							4'b1111 :begin inphase_signal=4'b0010 ;
										 quadrature_signal=4'b1110 ;
							end
							
							endcase
							
							
						end	
							/*4'b0000:
						begin	inphase_signal<= 1 ;
										quadrature_signal<=1 ;
										end

							4'b0001 :
							begin
							inphase_signal<=2 ;
										quadrature_signal<=1 ;
							end
							4'b0010 :begin inphase_signal=1 ;
										 quadrature_signal=2 ;
							end
							4'b0011 :begin inphase_signal=2 ;
										 quadrature_signal=2 ;
							
							end
							4'b0100 :begin inphase_signal=-1 ;
										 quadrature_signal=1 ;
							end
							4'b0101 :begin inphase_signal=-2 ;
										 quadrature_signal=1 ;
							end
							4'b0110 :begin inphase_signal=-2 ;
										 quadrature_signal=-2 ;
							end
							4'b0111 :begin inphase_signal=-1 ;
										 quadrature_signal=2 ;
							end
							4'b1000 :begin inphase_signal=-1 ;
										 quadrature_signal=-1 ;
							end
							4'b1001 :begin inphase_signal=-2 ;
										 quadrature_signal=-1 ;
							end
							4'b1010 :begin inphase_signal=-2 ;
										 quadrature_signal=-2 ;
							end
							4'b1011 :begin inphase_signal=-1 ;
										 quadrature_signal=-2 ;
							end
							4'b1100 :begin inphase_signal=1 ;
										 quadrature_signal=-1 ;
							end
							4'b1101 :begin inphase_signal=2 ;
										 quadrature_signal=-1 ;
							end
							4'b1110 :begin inphase_signal=1 ;
										 quadrature_signal=-2 ;
							end
							4'b1111 :begin inphase_signal=2 ;
										 quadrature_signal=-2 ;
							end
							
							endcase
							
							
						end	*/
							

always@(sineaddr)
begin

case(sineaddr)
/*8'd0: sineMod=4'b0000;
8'd1: sineMod=4'b0001;
8'd2: sineMod=4'b0010;
8'd3: sineMod=4'b0011;
8'd4: sineMod=4'b0100;
8'd5: sineMod=4'b0011;
8'd6: sineMod=4'b0010;
8'd7: sineMod=4'b0001;
8'd8: sineMod=4'b0000;
8'd9: sineMod=4'b1111;
8'd10: sineMod=4'b1110;
8'd11: sineMod=4'b1100;
8'd12: sineMod=4'b1101;
8'd13: sineMod=4'b1110;
8'd15: sineMod=4'b1111;

*/
8'd0: sineMod= 16'd0 ;
8'd1: sineMod = 16'd804 ;
8'd2: sineMod = 16'd1608 ;
8'd3: sineMod = 16'd2411 ;
8'd4: sineMod = 16'd3212 ;
8'd5: sineMod = 16'd4011 ;
8'd6: sineMod = 16'd4808 ;
8'd7: sineMod = 16'd5062 ;
8'd8: sineMod = 16'd6393;
8'd9: sineMod = 16'd6080 ;
8'd10: sineMod = 16'd7962 ;
8'd11: sineMod = 16'd8740 ;
8'd12: sineMod = 16'd9512 ;
8'd13: sineMod = 16'd10279 ;
8'd14: sineMod = 16'd11039 ;
8'd15: sineMod = 16'd11793 ;
8'd16: sineMod = 16'd12540 ;
8'd17: sineMod = 16'd13279 ;
8'd18: sineMod = 16'd14010 ;
8'd19: sineMod = 16'd14733;
8'd20: sineMod = 16'd15447;
8'd21: sineMod = 16'd16151 ;
8'd22: sineMod = 16'd16846 ;
8'd23: sineMod = 16'd17531 ;
8'd24: sineMod = 16'd18205 ;
8'd25: sineMod = 16'd18868 ;
8'd26: sineMod = 16'd19520 ;
8'd27: sineMod = 16'd20160 ;
8'd28: sineMod = 16'd20788 ;
8'd29: sineMod = 16'd21403 ;
8'd30: sineMod = 16'd22006 ;
8'd31: sineMod = 16'd22595 ;
8'd32: sineMod = 16'd23170;
8'd33: sineMod = 16'd23732 ;
8'd34: sineMod = 16'd24279 ;
8'd35: sineMod = 16'd24812 ;
8'd36: sineMod = 16'd25330 ;
8'd37: sineMod = 16'd 25833;
8'd38: sineMod = 16'd26320 ;
8'd39: sineMod = 16'd 26791;
8'd40: sineMod = 16'd27246;
8'd41: sineMod = 16'd 27684;
8'd42: sineMod = 16'd28106 ;
8'd43: sineMod = 16'd28511;
8'd44: sineMod = 16'd28899;
8'd45: sineMod = 16'd 29269;
8'd46: sineMod = 16'd29622 ;
8'd47: sineMod = 16'd29957 ;
8'd48: sineMod = 16'd30274 ;
8'd49: sineMod = 16'd 30572;
8'd50: sineMod = 16'd30853 ;
8'd51: sineMod = 16'd 31114;
8'd52: sineMod = 16'd31350 ;
8'd53: sineMod = 16'd31581 ;
8'd54: sineMod = 16'd31786 ;
8'd55: sineMod = 16'd31972 ;
8'd56: sineMod = 16'd32138;
8'd57: sineMod = 16'd32286 ;
8'd58: sineMod = 16'd 32413;
8'd59: sineMod = 16'd32522 ;
8'd60: sineMod = 16'd32610 ;
8'd61: sineMod = 16'd 32679;
8'd62: sineMod = 16'd32729 ;
8'd63: sineMod = 16'd 32758;
8'd64: sineMod = 16'd32767 ;
8'd65: sineMod = 16'd32758 ;
8'd66: sineMod = 16'd32729 ;
8'd67: sineMod = 16'd32679;
8'd68: sineMod = 16'd32610;
8'd69: sineMod = 16'd32522 ;
8'd70: sineMod = 16'd32413;
8'd71: sineMod = 16'd32286 ;
8'd72: sineMod = 16'd32138 ;
8'd73: sineMod = 16'd31972;
8'd74: sineMod = 16'd31786 ;
8'd75: sineMod = 16'd 31581;
8'd76: sineMod = 16'd 31357;
8'd77: sineMod = 16'd 31114 ;
8'd78: sineMod = 16'd30853 ;
8'd79: sineMod = 16'd 30572 ;
8'd80: sineMod = 16'd30274;
8'd81: sineMod = 16'd29957;
8'd82: sineMod = 16'd 29622;
8'd83: sineMod = 16'd29269 ;
8'd84: sineMod = 16'd 28899;
8'd85: sineMod = 16'd28511 ;
8'd86: sineMod = 16'd28106;
8'd87: sineMod = 16'd27684 ;
8'd88: sineMod = 16'd27246;
8'd89: sineMod = 16'd26791;
8'd90: sineMod = 16'd26320 ;
8'd91: sineMod = 16'd25833;
8'd92: sineMod = 16'd25330;
8'd93: sineMod = 16'd24812;
8'd94: sineMod = 16'd24279 ;
8'd95: sineMod = 16'd23732 ;
8'd96: sineMod = 16'd 23170;
8'd97: sineMod = 16'd22595;
8'd98: sineMod = 16'd22006 ;
8'd99: sineMod = 16'd 21403;
8'd100: sineMod =16'd20788 ;
8'd101: sineMod =16'd 20160;
8'd102: sineMod =16'd19520 ;
8'd103: sineMod =16'd 18868;
8'd104: sineMod =16'd18205;
8'd105: sineMod =16'd 17531;
8'd106: sineMod =16'd16846 ;
8'd107: sineMod = 16'd 16151;
8'd108: sineMod = 16'd15447 ;
8'd109: sineMod = 16'd 14733;
8'd110: sineMod = 16'd 14010;
8'd111: sineMod = 16'd13279 ;
8'd112: sineMod = 16'd12540 ;
8'd113: sineMod = 16'd11793 ;
8'd114: sineMod = 16'd11039 ;
8'd115: sineMod = 16'd10279;
8'd116: sineMod = 16'd9512;
8'd117: sineMod = 16'd8740 ;
8'd118: sineMod = 16'd7962 ;
8'd119: sineMod = 16'd7180 ;
8'd120: sineMod = 16'd6393 ;
8'd121: sineMod = 16'd 5062;
8'd122: sineMod = 16'd 4808;
8'd123: sineMod = 16'd 4011;
8'd124: sineMod = 16'd3212 ;
8'd125: sineMod = 16'd2411 ;
8'd126: sineMod = 16'd1608 ;
8'd127: sineMod = 16'd804 ;
8'd128: sineMod = 16'd0;
 
8'd129: sineMod = 16'd64732 ;
8'd130: sineMod = 16'd63928 ;
8'd131: sineMod = 16'd 63125;
8'd132: sineMod = 16'd62324 ;
8'd133: sineMod = 16'd 61525;
8'd134: sineMod = 16'd60728 ;
8'd135: sineMod = 16'd59934;
8'd136: sineMod = 16'd59143;
8'd137: sineMod = 16'd58356 ;
8'd138: sineMod = 16'd57574 ;
8'd139: sineMod = 16'd56796;
8'd140: sineMod = 16'd56024;
8'd141: sineMod = 16'd 55257;
8'd142: sineMod = 16'd54497 ;
8'd143: sineMod = 16'd 53743;
8'd144: sineMod = 16'd 52996;
8'd145: sineMod = 16'd 52257;
8'd146: sineMod = 16'd 51526;
8'd147: sineMod = 16'd 50803;
8'd148: sineMod = 16'd 50089;
8'd149: sineMod = 16'd49385;
8'd150: sineMod = 16'd 48690;
8'd151: sineMod = 16'd 48005;
8'd152: sineMod = 16'd47331;
8'd153: sineMod = 16'd46668;
8'd154: sineMod = 16'd46016;
8'd155: sineMod = 16'd45376;
8'd156: sineMod = 16'd44748 ;
8'd157: sineMod = 16'd 44133;
8'd158: sineMod = 16'd43530 ;
8'd159: sineMod = 16'd 42941;
8'd160: sineMod = 16'd 42366;
8'd161: sineMod = 16'd41804 ;
8'd162: sineMod = 16'd 41257;
8'd163: sineMod = 16'd40724;
8'd164: sineMod = 16'd40206;
8'd165: sineMod = 16'd 39703;
8'd166: sineMod = 16'd39216 ;
8'd167: sineMod = 16'd 38745;
8'd168: sineMod = 16'd38290 ;
8'd169: sineMod = 16'd37852;
8'd170: sineMod = 16'd 37430;
8'd171: sineMod = 16'd37025 ;
8'd172: sineMod = 16'd 36637;
8'd173: sineMod = 16'd 36267;
8'd174: sineMod = 16'd 35914;
8'd175: sineMod = 16'd 35579;
8'd176: sineMod = 16'd35262;
8'd177: sineMod = 16'd34964;
8'd178: sineMod = 16'd 34683;
8'd179: sineMod = 16'd34422 ;
8'd180: sineMod = 16'd 34179;
8'd181: sineMod = 16'd 33955;
8'd182: sineMod = 16'd33750 ;
8'd183: sineMod = 16'd 33564;
8'd184: sineMod = 16'd33398;
8'd185: sineMod = 16'd 33250;
8'd186: sineMod = 16'd33123 ;
8'd187: sineMod = 16'd33014;
8'd188: sineMod = 16'd32926;
8'd189: sineMod = 16'd32857;
8'd190: sineMod = 16'd32807 ;
8'd191: sineMod = 16'd 32778;
8'd192: sineMod = 16'd 32768;
8'd193: sineMod = 16'd32778 ;
8'd194: sineMod = 16'd32807 ;
8'd195: sineMod = 16'd 32857;
8'd196: sineMod = 16'd 32926;
8'd197: sineMod = 16'd 33014;
8'd198: sineMod = 16'd 33123;
8'd199: sineMod = 16'd33250;
8'd200: sineMod = 16'd33398;
8'd201: sineMod = 16'd 33564;
8'd202: sineMod = 16'd 33750;
8'd203: sineMod = 16'd 33955;
8'd204: sineMod = 16'd 34179;
8'd205: sineMod = 16'd 34422;
8'd206: sineMod = 16'd34683 ;
8'd207: sineMod = 16'd34964;
8'd208: sineMod = 16'd35262;
8'd209: sineMod = 16'd35579;
8'd210: sineMod = 16'd35914 ;
8'd211: sineMod = 16'd36267;
8'd212: sineMod = 16'd36637;
8'd213: sineMod = 16'd37025 ;
8'd214: sineMod = 16'd37430 ;
8'd215: sineMod = 16'd37852 ;
8'd216: sineMod = 16'd38290 ;
8'd217: sineMod = 16'd38745 ;
8'd218: sineMod = 16'd39216 ;
8'd219: sineMod = 16'd39703;
8'd220: sineMod = 16'd40206;
8'd221: sineMod = 16'd40724 ;
8'd222: sineMod = 16'd41257;
8'd223: sineMod = 16'd41804 ;
8'd224: sineMod = 16'd42366;
8'd225: sineMod = 16'd42941 ;
8'd226: sineMod = 16'd43530;
8'd227: sineMod = 16'd44133 ;
8'd228: sineMod = 16'd44748 ;
8'd229: sineMod = 16'd45376 ;
8'd230: sineMod = 16'd46016 ;
8'd231: sineMod = 16'd46668 ;
8'd232: sineMod = 16'd47331;
8'd233: sineMod = 16'd48005 ;
8'd234: sineMod = 16'd48690 ;
8'd235: sineMod = 16'd49385;
8'd236: sineMod = 16'd50089;
8'd237: sineMod = 16'd50803 ;
8'd238: sineMod = 16'd51526 ;
8'd239: sineMod = 16'd52257 ;
8'd240: sineMod = 16'd52996 ;
8'd241: sineMod = 16'd53743 ;
8'd242: sineMod = 16'd54497 ;
8'd243: sineMod = 16'd55257 ;
8'd244: sineMod = 16'd56024 ;
8'd245: sineMod = 16'd56796 ;
8'd246: sineMod = 16'd57574 ;
8'd247: sineMod = 16'd58356 ;
8'd248: sineMod = 16'd59143;
8'd249: sineMod = 16'd59934 ;
8'd250: sineMod = 16'd60728 ;
8'd251: sineMod = 16'd61525 ;
8'd252: sineMod = 16'd62324 ;
8'd253: sineMod = 16'd63125 ;
8'd254: sineMod = 16'd63928 ;
8'd255: sineMod = 16'd64732 ;
 
default: sineMod = 16'd0;



endcase
end


always @(cosaddr)
begin
case (cosaddr)
/*
8'd0: cosMod=4'b0000;
8'd1: cosMod=4'b0001;
8'd2: cosMod=4'b0010;
8'd3: cosMod=4'b0011;
8'd4: cosMod=4'b0100;
8'd5: cosMod=4'b0011;
8'd6: cosMod=4'b0010;
8'd7: cosMod=4'b0001;
8'd8: cosMod=4'b0000;
8'd9: cosMod=4'b1111;
8'd10: cosMod=4'b1110;
8'd11: cosMod=4'b1100;
8'd12: cosMod=4'b1101;
8'd13: cosMod=4'b1110;
8'd15: cosMod=4'b1111;

*/
8'd0: cosMod= 16'd0 ;
8'd1: cosMod = 16'd804 ;
8'd2: cosMod = 16'd1608 ;
8'd3: cosMod = 16'd2411 ;
8'd4: cosMod = 16'd3212 ;
8'd5: cosMod = 16'd4011 ;
8'd6: cosMod = 16'd4808 ;
8'd7: cosMod = 16'd5062 ;
8'd8: cosMod = 16'd6393;
8'd9: cosMod = 16'd6080 ;
8'd10: cosMod = 16'd7962 ;
8'd11: cosMod = 16'd8740 ;
8'd12: cosMod = 16'd9512 ;
8'd13: cosMod = 16'd10279 ;
8'd14: cosMod = 16'd11039 ;
8'd15: cosMod = 16'd11793 ;
8'd16: cosMod = 16'd12540 ;
8'd17: cosMod = 16'd13279 ;
8'd18: cosMod = 16'd14010 ;
8'd19: cosMod = 16'd14733;
8'd20: cosMod = 16'd15447;
8'd21: cosMod = 16'd16151 ;
8'd22: cosMod = 16'd16846 ;
8'd23: cosMod = 16'd17531 ;
8'd24: cosMod = 16'd18205 ;
8'd25: cosMod = 16'd18868 ;
8'd26: cosMod = 16'd19520 ;
8'd27: cosMod = 16'd20160 ;
8'd28: cosMod = 16'd20788 ;
8'd29: cosMod = 16'd21403 ;
8'd30: cosMod = 16'd22006 ;
8'd31: cosMod = 16'd22595 ;
8'd32: cosMod = 16'd23170;
8'd33: cosMod = 16'd23732 ;
8'd34: cosMod = 16'd24279 ;
8'd35: cosMod = 16'd24812 ;
8'd36: cosMod = 16'd25330 ;
8'd37: cosMod = 16'd 25833;
8'd38: cosMod = 16'd26320 ;
8'd39: cosMod = 16'd 26791;
8'd40: cosMod = 16'd27246;
8'd41: cosMod = 16'd 27684;
8'd42: cosMod = 16'd28106 ;
8'd43: cosMod = 16'd28511;
8'd44: cosMod = 16'd28899;
8'd45: cosMod = 16'd 29269;
8'd46: cosMod = 16'd29622 ;
8'd47: cosMod = 16'd29957 ;
8'd48: cosMod = 16'd30274 ;
8'd49: cosMod = 16'd 30572;
8'd50: cosMod = 16'd30853 ;
8'd51: cosMod = 16'd 31114;
8'd52: cosMod = 16'd31350 ;
8'd53: cosMod = 16'd31581 ;
8'd54: cosMod = 16'd31786 ;
8'd55: cosMod = 16'd31972 ;
8'd56: cosMod = 16'd32138;
8'd57: cosMod = 16'd32286 ;
8'd58: cosMod = 16'd 32413;
8'd59: cosMod = 16'd32522 ;
8'd60: cosMod = 16'd32610 ;
8'd61: cosMod = 16'd 32679;
8'd62: cosMod = 16'd32729 ;
8'd63: cosMod = 16'd 32758;
8'd64: cosMod = 16'd32767 ;
8'd65: cosMod = 16'd32758 ;
8'd66: cosMod = 16'd32729 ;
8'd67: cosMod = 16'd32679;
8'd68: cosMod = 16'd32610;
8'd69: cosMod = 16'd32522 ;
8'd70: cosMod = 16'd32413;
8'd71: cosMod = 16'd32286 ;
8'd72: cosMod = 16'd32138 ;
8'd73: cosMod = 16'd31972;
8'd74: cosMod = 16'd31786 ;
8'd75: cosMod = 16'd 31581;
8'd76: cosMod = 16'd 31357;
8'd77: cosMod = 16'd 31114 ;
8'd78: cosMod = 16'd30853 ;
8'd79: cosMod = 16'd 30572 ;
8'd80: cosMod = 16'd30274;
8'd81: cosMod = 16'd29957;
8'd82: cosMod = 16'd 29622;
8'd83: cosMod = 16'd29269 ;
8'd84: cosMod = 16'd 28899;
8'd85: cosMod = 16'd28511 ;
8'd86: cosMod = 16'd28106;
8'd87: cosMod = 16'd27684 ;
8'd88: cosMod = 16'd27246;
8'd89: cosMod = 16'd26791;
8'd90: cosMod = 16'd26320 ;
8'd91: cosMod = 16'd25833;
8'd92: cosMod = 16'd25330;
8'd93: cosMod = 16'd24812;
8'd94: cosMod = 16'd24279 ;
8'd95: cosMod = 16'd23732 ;
8'd96: cosMod = 16'd 23170;
8'd97: cosMod = 16'd22595;
8'd98: cosMod = 16'd22006 ;
8'd99: cosMod = 16'd 21403;
8'd100: cosMod =16'd20788 ;
8'd101: cosMod =16'd 20160;
8'd102: cosMod =16'd19520 ;
8'd103: cosMod =16'd 18868;
8'd104: cosMod =16'd18205;
8'd105: cosMod =16'd 17531;
8'd106: cosMod =16'd16846 ;
8'd107: cosMod = 16'd 16151;
8'd108: cosMod = 16'd15447 ;
8'd109: cosMod = 16'd 14733;
8'd110: cosMod = 16'd 14010;
8'd111: cosMod = 16'd13279 ;
8'd112: cosMod = 16'd12540 ;
8'd113: cosMod = 16'd11793 ;
8'd114: cosMod = 16'd11039 ;
8'd115: cosMod = 16'd10279;
8'd116: cosMod = 16'd9512;
8'd117: cosMod = 16'd8740 ;
8'd118: cosMod = 16'd7962 ;
8'd119: cosMod = 16'd7180 ;
8'd120: cosMod = 16'd6393 ;
8'd121: cosMod = 16'd 5062;
8'd122: cosMod = 16'd 4808;
8'd123: cosMod = 16'd 4011;
8'd124: cosMod = 16'd3212 ;
8'd125: cosMod = 16'd2411 ;
8'd126: cosMod = 16'd1608 ;
8'd127: cosMod = 16'd804 ;
8'd128: cosMod = 16'd0;
 
8'd129: cosMod = 16'd64732 ;
8'd130: cosMod = 16'd63928 ;
8'd131: cosMod = 16'd 63125;
8'd132: cosMod = 16'd62324 ;
8'd133: cosMod = 16'd 61525;
8'd134: cosMod = 16'd60728 ;
8'd135: cosMod = 16'd59934;
8'd136: cosMod = 16'd59143;
8'd137: cosMod = 16'd58356 ;
8'd138: cosMod = 16'd57574 ;
8'd139: cosMod = 16'd56796;
8'd140: cosMod = 16'd56024;
8'd141: cosMod = 16'd 55257;
8'd142: cosMod = 16'd54497 ;
8'd143: cosMod = 16'd 53743;
8'd144: cosMod = 16'd 52996;
8'd145: cosMod = 16'd 52257;
8'd146: cosMod = 16'd 51526;
8'd147: cosMod = 16'd 50803;
8'd148: cosMod = 16'd 50089;
8'd149: cosMod = 16'd49385;
8'd150: cosMod = 16'd 48690;
8'd151: cosMod = 16'd 48005;
8'd152: cosMod = 16'd47331;
8'd153: cosMod = 16'd46668;
8'd154: cosMod = 16'd46016;
8'd155: cosMod = 16'd45376;
8'd156: cosMod = 16'd44748 ;
8'd157: cosMod = 16'd 44133;
8'd158: cosMod = 16'd43530 ;
8'd159: cosMod = 16'd 42941;
8'd160: cosMod = 16'd 42366;
8'd161: cosMod = 16'd41804 ;
8'd162: cosMod = 16'd 41257;
8'd163: cosMod = 16'd40724;
8'd164: cosMod = 16'd40206;
8'd165: cosMod = 16'd 39703;
8'd166: cosMod = 16'd39216 ;
8'd167: cosMod = 16'd 38745;
8'd168: cosMod = 16'd38290 ;
8'd169: cosMod = 16'd37852;
8'd170: cosMod = 16'd 37430;
8'd171: cosMod = 16'd37025 ;
8'd172: cosMod = 16'd 36637;
8'd173: cosMod = 16'd 36267;
8'd174: cosMod = 16'd 35914;
8'd175: cosMod = 16'd 35579;
8'd176: cosMod = 16'd35262;
8'd177: cosMod = 16'd34964;
8'd178: cosMod = 16'd 34683;
8'd179: cosMod = 16'd34422 ;
8'd180: cosMod = 16'd 34179;
8'd181: cosMod = 16'd 33955;
8'd182: cosMod = 16'd33750 ;
8'd183: cosMod = 16'd 33564;
8'd184: cosMod = 16'd33398;
8'd185: cosMod = 16'd 33250;
8'd186: cosMod = 16'd33123 ;
8'd187: cosMod = 16'd33014;
8'd188: cosMod = 16'd32926;
8'd189: cosMod = 16'd32857;
8'd190: cosMod = 16'd32807 ;
8'd191: cosMod = 16'd 32778;
8'd192: cosMod = 16'd 32768;
8'd193: cosMod = 16'd32778 ;
8'd194: cosMod = 16'd32807 ;
8'd195: cosMod = 16'd 32857;
8'd196: cosMod = 16'd 32926;
8'd197: cosMod = 16'd 33014;
8'd198: cosMod = 16'd 33123;
8'd199: cosMod = 16'd33250;
8'd200: cosMod = 16'd33398;
8'd201: cosMod = 16'd 33564;
8'd202: cosMod = 16'd 33750;
8'd203: cosMod = 16'd 33955;
8'd204: cosMod = 16'd 34179;
8'd205: cosMod = 16'd 34422;
8'd206: cosMod = 16'd34683 ;
8'd207: cosMod = 16'd34964;
8'd208: cosMod = 16'd35262;
8'd209: cosMod = 16'd35579;
8'd210: cosMod = 16'd35914 ;
8'd211: cosMod = 16'd36267;
8'd212: cosMod = 16'd36637;
8'd213: cosMod = 16'd37025 ;
8'd214: cosMod = 16'd37430 ;
8'd215: cosMod = 16'd37852 ;
8'd216: cosMod = 16'd38290 ;
8'd217: cosMod = 16'd38745 ;
8'd218: cosMod = 16'd39216 ;
8'd219: cosMod = 16'd39703;
8'd220: cosMod = 16'd40206;
8'd221: cosMod = 16'd40724 ;
8'd222: cosMod = 16'd41257;
8'd223: cosMod = 16'd41804 ;
8'd224: cosMod = 16'd42366;
8'd225: cosMod = 16'd42941 ;
8'd226: cosMod = 16'd43530;
8'd227: cosMod = 16'd44133 ;
8'd228: cosMod = 16'd44748 ;
8'd229: cosMod = 16'd45376 ;
8'd230: cosMod = 16'd46016 ;
8'd231: cosMod = 16'd46668 ;
8'd232: cosMod = 16'd47331;
8'd233: cosMod = 16'd48005 ;
8'd234: cosMod = 16'd48690 ;
8'd235: cosMod = 16'd49385;
8'd236: cosMod = 16'd50089;
8'd237: cosMod = 16'd50803 ;
8'd238: cosMod = 16'd51526 ;
8'd239: cosMod = 16'd52257 ;
8'd240: cosMod = 16'd52996 ;
8'd241: cosMod = 16'd53743 ;
8'd242: cosMod = 16'd54497 ;
8'd243: cosMod = 16'd55257 ;
8'd244: cosMod = 16'd56024 ;
8'd245: cosMod = 16'd56796 ;
8'd246: cosMod = 16'd57574 ;
8'd247: cosMod = 16'd58356 ;
8'd248: cosMod = 16'd59143;
8'd249: cosMod = 16'd59934 ;
8'd250: cosMod = 16'd60728 ;
8'd251: cosMod = 16'd61525 ;
8'd252: cosMod = 16'd62324 ;
8'd253: cosMod = 16'd63125 ;
8'd254: cosMod = 16'd63928 ;
8'd255: cosMod = 16'd64732 ;
 
default: cosMod = 16'd0;


endcase

end



endmodule


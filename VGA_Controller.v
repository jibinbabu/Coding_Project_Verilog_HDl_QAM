	module VGA_Controller(reset,
                      vga_clk,
                      BLANK_n,
                      HS,
                      VS,
		    		       CoorX,
		     		       CoorY);
                            
input reset;
input vga_clk;
output reg BLANK_n;
output reg HS;
output reg VS;
output [10:0] CoorX;
output [9:0] CoorY;



   
//Resoultion: 640x480

parameter hori_line  =800 ;       //Total number of clock period in a line including the visible and not visible                
parameter hori_back  =48;
parameter hori_front = 16;
parameter vert_line  =525 ;      //Total number of lines in a frame including the visible and not visible
parameter vert_back  = 33;
parameter vert_front =10 ;
parameter H_sync_cycle =96;
parameter V_sync_cycle =2 ;

//////////////////////////

reg  [10:0] h_cnt;
reg  [10:0] v_cnt;
wire cHD,cVD,cDEN,hori_valid,vert_valid;

////////////////////////
//Calculate CoorX and CoorY

assign CoorX  = (h_cnt<(hori_line-hori_front) &&h_cnt>=hori_back+H_sync_cycle)	?	h_cnt-hori_back-H_sync_cycle	:	11'd640;

assign CoorY  = (v_cnt<(vert_line-vert_front)&& v_cnt>=vert_back+V_sync_cycle)	?	v_cnt-vert_back-V_sync_cycle:	10'd480; 

//////////////////////////
//Calculate H_count and v_count

always@(negedge vga_clk,posedge reset)
begin
  if (reset)
  begin
     h_cnt<=11'd0;
     v_cnt<=10'd0;
  end
    else
    begin
      if (h_cnt==hori_line-1)
      begin 
         h_cnt<=0;
         if (v_cnt==vert_line-1)
            v_cnt<=0;
         else
            v_cnt<=v_cnt+1;
      end
      else
         h_cnt<=h_cnt+1;
    end
end

////////////////
//Calculate HS and VS

assign cHD = (h_cnt<H_sync_cycle)?1'b0:1'b1;
assign cVD = (v_cnt<V_sync_cycle)? 1'b0:1'b1 ;

///////////////////
//Calculate BLANK_N

assign hori_valid = (h_cnt<(hori_line-hori_front)&& h_cnt>=hori_back+H_sync_cycle)? 1'b1: 1'b0;
assign vert_valid = (v_cnt<(vert_line-vert_front)&& v_cnt>=vert_back+V_sync_cycle)? 1'b1:1'b0 ;

assign cDEN = hori_valid &&vert_valid?1'b1:1'b0;

//////////////Update values

always@(negedge vga_clk)
begin
  HS<=cHD;
  VS<=cVD;
  BLANK_n<=cDEN;
end

endmodule

module PWM_LED(clk,btn,reset,LEDG);

input clk;
input btn;
input reset;
output [2:0] LEDG; 

reg [26:0] counter; 
reg [5:0] PWM_adj; 
reg [6:0] PWM_width; 
reg [2:0] LEDG; 

always @(posedge clk or posedge reset) begin
	if (reset) 
		begin
	    	counter <= 0; 
		end
	else if (btn) 
		begin
			counter <= counter+1;
		end
end

always @(posedge clk or posedge reset)
   begin 
    if(reset)     
      begin 

        LEDG[0] <= 0;
        LEDG[1] <= 0; 
        LEDG[2] <= 0;       
      end  
    else begin 
        PWM_width <= PWM_width[5:0]+ PWM_adj;    
        if(counter[26]) 
			begin 
				PWM_adj <=  counter[25:20]; 
			end            
			else begin 
				PWM_adj <= ~counter[25:20]; 
			end     
		LEDG[0] <= PWM_width[6]; 
		LEDG[1] <= PWM_width[6]; 
		LEDG[2] <= PWM_width[6];           
       end 
   end 
   
endmodule
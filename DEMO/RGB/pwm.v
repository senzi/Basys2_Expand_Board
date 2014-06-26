module PWM_LED(clk,btn,reset,LEDG);

input        clk;
input  [2:0] btn;
input        reset;
output [2:0] LEDG; 

reg [2:0]  counter ;

reg [26:0] counter_R; 
reg [5:0]  PWM_adj_R; 
reg [6:0]  PWM_width_R; 

reg [26:0] counter_G; 
reg [5:0]  PWM_adj_G; 
reg [6:0]  PWM_width_G; 

reg [26:0] counter_B; 
reg [5:0]  PWM_adj_B; 
reg [6:0]  PWM_width_B; 

reg [2:0] LEDG; 

always @(posedge clk or posedge reset) 
begin
	if (reset) 
	begin
		counter <= 0 ;
	end
	else begin
		counter <= counter + 1 ; 
	end
end

wire clk_div ;
assign clk_div = counter[2]&&counter[1];

always @(posedge clk_div or posedge reset) begin
	if (reset) 
		begin
	    	counter_R <= 0;
	    	counter_G <= 0;
	    	counter_B <= 0; 
		end
	else if (btn[0]) begin counter_R <= counter_R+1;end
	else if (btn[1]) begin counter_G <= counter_G+1;end
	else if (btn[2]) begin counter_B <= counter_B+1;end
end

always @(posedge clk or posedge reset)
   begin 
    if(reset)     
      begin 
        LEDG[0] <= 1;      
      end  
    else begin 
        PWM_width_R <= PWM_width_R[5:0]+ PWM_adj_R;    
        if(counter_R[26]) 
			begin 
				PWM_adj_R <=  counter_R[25:20]; 
			end            
			else begin 
				PWM_adj_R <= ~counter_R[25:20]; 
			end     
		LEDG[0] <= PWM_width_R[6];         
       end 
   end 

always @(posedge clk or posedge reset)
   begin 
    if(reset)     
      begin 
        LEDG[1] <= 1;      
      end  
    else begin 
        PWM_width_G <= PWM_width_G[5:0]+ PWM_adj_G;    
        if(counter_G[26]) 
			begin 
				PWM_adj_G <=  counter_G[25:20]; 
			end            
			else begin 
				PWM_adj_G <= ~counter_G[25:20]; 
			end     
		LEDG[1] <= PWM_width_G[6];         
       end 
   end

always @(posedge clk or posedge reset)
   begin 
    if(reset)     
      begin 
        LEDG[2] <= 1;      
      end  
    else begin 
        PWM_width_B <= PWM_width_B[5:0]+ PWM_adj_B;    
        if(counter_B[26]) 
			begin 
				PWM_adj_B <=  counter_B[25:20]; 
			end            
			else begin 
				PWM_adj_B <= ~counter_B[25:20]; 
			end     
		LEDG[2] <= PWM_width_B[6];         
       end 
   end
   
endmodule
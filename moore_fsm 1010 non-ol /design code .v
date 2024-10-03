// Code your design here

module moore_fsm_non_overlap (clk,rst,din,q) ;
  
  input clk,rst,din ;
  output reg q ;
     parameter s0=3'b000;
       parameter s1=3'b001; 
  	    parameter	s2=3'b010;
  		parameter	s3=3'b011;
  		parameter	s4=3'b100;
  reg [2:0] c_st ,n_st ;
  
  // sequential block to update state based on clk
  always @(posedge clk or posedge rst) 
    begin 
      if(rst) 
        c_st <= s0;   //ideal or reset state 
        //n_st <= s0;
      else 
        c_st <= n_st ; //move to next state 
    end
  //combinational logic to determine next state 
  always @ (c_st or din ) begin 
    case (c_st) 
      s0 : begin 
        if (din==1) n_st = s1 ;
            else n_st = s0 ;
             end
      s1 : begin 
        if(din==0) n_st = s2;
        	else n_st = s1 ;
      		end 
      s2 : begin 
        if (din==1) n_st = s3;
          else n_st = s0 ; 
           end
      s3 : begin 
        if (din==0) n_st = s4;
        else n_st = s1 ;
        
           end
      s4 : begin                        // since it is non-overlap next incoming bit is compared with 1 bit state (=s1 ) else moves to ideal state (=s0)
        
          if (din == 1) n_st = s1;
              else n_st = s0;
             end
        default : n_st =  s0 ;
     endcase
    //output logic depends on c_st or present state -- moore  
    
    always @ (c_st ) begin 
      case (c_st) 
        s4 : q =1 ;          // output=1 when sequence 1010 is detected 
        default : q = 0 ;   //output =0 for all other states 
      endcase 
    end 
       
endmodule 
    
    ///////////////////////////////////////
    // also we can write as below for 2 bit overlap 
    // so at s4 (last stage ) next bit (=1) is compared with 3 stage/state if matches moves to s3 else s0 ;
    case (cst)
   S0: if (din == 1'b1)
          begin
         nst = S1;
          y=1'b0;
          end
        else nst = cst;
   S1: if (din == 1'b0)
          begin
        nst = S2;
          y=1'b0;
          end
       else
          begin
          nst = cst;
          y=1'b0;
          end
   S2: if (din == 1'b1)
          begin
         nst = S3;
          y=1'b0;
          end    
            else
          begin
          nst = S0;
          y=1'b0;
          end
   S3: if (din == 1'b0)
          begin
         nst = S4;
          y=1'b0;
          end
       else
          begin
          nst = S1;
          y=1'b0;
          end
      S4: if (din == 1'b0)   //if incoming bit matches then moves to s3 else s0
          begin
         nst = S0;
          y=1'b1;
          end
          else
          begin
          nst = S3;
          y=1'b1;
          end
   default: nst = S0;
  endcase

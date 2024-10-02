//  code ur design here 

module FA(a, b, c, sum, co);
input a,b,c ;
output sum, co;
assign sum = a ^ b ^ c ;
  assign  co=(a&b) | (b&c) | (a &c);
endmodule

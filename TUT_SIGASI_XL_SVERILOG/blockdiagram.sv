module foobar (a, b, c);
input  integer   a,b;
output integer    c;

wire integer sa,sb,sc,sd;

assign sd = a;
	
foobari block1(.a(sd), .b(b),  .c(sa));
foobari block2(.a(sa), .b(sa), .c(sb));
foobari block3(.a(sa), .b(sb), .c(sc));
foobari block4(.a(sc), .b(sc), .c(c));
	

endmodule


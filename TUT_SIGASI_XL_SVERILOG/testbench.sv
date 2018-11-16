//--------------------------------------------------------------------------------
// Welcome to the Sigasi XL tutorial.
//--------------------------------------------------------------------------------


module testbench;
	parameter integer half_iterations = 50;

	wire logic [7:0] data_out;
	wire logic [7:0] data_in;
	wire logic valid;
	wire logic start; // @suppress "Unused"
	wire logic clk  ;
	wire logic rst  ;

	dut  #(.iterations (half_iterations *2)) 
		dut_instance (.data_out (data_out),.data_in(data_in),.valid(valid),.start(start),.clk(clk),.rst(rst));
	check  #(.iterations (half_iterations *2)) 
		checker_instance (.data_out (data_out),.data_in(data_in),.valid(valid),.start(start),.clk(clk),.rst(rst));
     
	stimgen stimgen_instance
			(
			.clk       (clk),
			.rst       (rst),
			//------------------------------------------------------------------
			// TODO "Live update"  
			//      Uncomment the line below. Save the file and notice that the
			//      block diagram view updates.
			//------------------------------------------------------------------
			.start (start),
			.stim_data (data_in)
		);

	clock_generator #(.PERIOD (20ns)) clk_gen_instance  (.clk (clk),.rst (rst));
    
    always 
    begin : label
		if( valid == 0 || data_out != 0) begin
			$error;
		end
	    @(posedge(clk));
	end
	
endmodule

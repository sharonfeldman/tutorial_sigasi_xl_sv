module clock_generator (output logic clk, output logic rst);
	timeunit 1ns;
	timeprecision 10ps;

	// TODO "Rename a local element"
	//      Click on `PERIOD` and press **Shift+Alt+R** to rename this
	//      parameter to e.g. `PERIOD25`.
	
	parameter PERIOD = 2.5ns;
	bit sclk = 0;

	always
	begin: CLOCK_DRIVER
		#(PERIOD) sclk=~sclk;
	end
	
	assign clk = sclk;
	
endmodule : clock_generator

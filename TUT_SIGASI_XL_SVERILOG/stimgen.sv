module stimgen (
		input logic clk ,
		input logic rst ,
		output logic start ,
		output bit [7:0] stim_data 
	);

	always @(posedge clk) begin
			if (rst) begin
				stim_data <= 0;
		    end
			else
			begin
				stim_data <= ~ stim_data;
			end;
    end

	initial begin
		for(int i=0; i<10; i=i+1) begin
			@(posedge clk);
		end
		start <= 1;
    end


endmodule : stimgen

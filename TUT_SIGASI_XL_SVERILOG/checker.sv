`include "constants.svh"

typedef int unused_type;


/* This is the checker" */
module check#(iterations = `MAGIC_NUMBER)  (input logic valid, logic[7:0] data_out, input logic start, clk, rst, input [7:0] data_in);

	logic [7:0] count;
	logic [7:0] result;

	always_ff @(count)

	if (count >= `MAX_COUNT)
		begin
			$display ("count out of range");
			$stop;
		end

	typedef enum {idle, starting, comparing,ready} states_t;
	states_t state;

	always_ff @(posedge rst or posedge clk) begin : sm
		if (rst)
			begin
				state = idle;
				count <= 0;
				result <= 0;
			end
		else
			case (state)

				idle:
				begin

					result <= {8{1'b0}};

					state = starting;
				end
				starting:
				if (start == 1'b1)
					begin
						count <= 0;
						state = comparing;
					end
				comparing:
				begin
					if (count == iterations)
						begin
							state = ready;
							result <= result * data_in;
						end
					count <= count + 1;
				end
				ready:
				begin
				if ((valid ==1) && (data_out==result))
					$write(".");
				else
					$error("not expected valid(%b) data_out(%x)", valid,data_out);
				state = idle;
				end
			endcase
	end
endmodule


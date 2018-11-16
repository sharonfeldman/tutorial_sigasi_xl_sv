//------------------------------------------------------------------------------
// TODO "State Machines View"  
//      Right-click and select **Show in > State Machines**.
//
// The **State Machines View** shows all state machines in the current file.
//
// You can change the position and size of the State Machines view if you like.
//------------------------------------------------------------------------------
`include "constants.svh"

typedef int unused_type;

// TODO "Hover on preprocessor directive"
//      Hovering over "`MAGIC_NUMBER" shows the initialization of the macro!
//
//      Click on the link at the bottom of the hover to open the preprocessor view.
//      This shows what the file looks like after macro expansion.

/* This is the device under test "dut" */
module dut#(iterations = `MAGIC_NUMBER)(output logic valid, logic[7:0] data_out, input logic start, clk, rst, [7:0] data_in);

	logic [7:0] count;
	logic [7:0] result;

	always_ff @(count)
	// TODO "Navigate to declaration"
	//      Click on `MAX_COUNT and press **F3** (or **Ctrl+Left click**) to
	//      go to the declaration of the macro.
	//
	//      Go ahead and F3 on count and other things as well.
	if (count >= `MAX_COUNT)
		begin
			$display ("count out of range");
			$stop;
		end

	typedef enum {idle, preparing, running, ready} states_t;
	states_t state;

	always_ff @(posedge rst or posedge clk) begin : sm
		if (rst)
			begin
				state = idle;
				count <= 0;
				valid <= 0;
				result <= 0;
			end
		else
			case (state)
				// TODO "Auto complete state"
				//      Press **Ctrl+Space** before the `:` and start typing
				//      `idle`. The missing state will be suggested.
				idle:
				begin
					// TODO "Navigate using Quick Outline"
					//      Press **Ctrl+O** and type `valid` to find the
					//      declaration of `valid`
					valid <= 1'b0;
					result <= {8{1'b0}};
					//--------------------------------------------------------------
				    // TODO "Type-time update"  
				    //      Uncomment the next line and see how State Machines
				    //      view updates.
				    //--------------------------------------------------------------
					state = preparing;
				end
				preparing:
				if (start == 1'b1)
					begin
						count <= 0;
						state = running;
					end
				running:
				begin
					if (count == iterations)
						begin
							state = ready;
							result <= result * data_in;
						end
					count <= count + 1;
				end
				
				//--------------------------------------------------------------
				// TODO "Navigate from FSM to state in code"  
				//      In the State Machines View, double-click on the node
				//      **ready**. The when-clause for state `ready` will be
				//      selected in the VHDL editor.
				//--------------------------------------------------------------
				
				ready:
				begin
					data_out <= result;
					valid <= 1'b1;
					
					//----------------------------------------------------------
					// TODO "Navigate from FSM to transition in code"  
					//      In the State Machines View, double-click on the
					//      arrow between **ready** and **idle**.
					//      The assignment on the line below will be highlighted.
					//----------------------------------------------------------
					
					state = idle;
				end
			endcase
	end
endmodule

//------------------------------------------------------------------------------
// TODO "Configure FSM"  
//      Navigate to dut.statemachine to configure your FSM
//------------------------------------------------------------------------------
// {{cookiecutter.module_name}}.v
// 
// {{cookiecutter.email}}, {{cookiecutter.date}}
//
// Purpose:
//   {{cookiecutter.purpose}}


module {{cookiecutter.module_name}} (
	input             clk,
	input             reset,

	output reg [31:0] counter
);

always @(posedge clk) begin
	if (reset == 1) begin
		counter <= 0;
	end else begin
		counter <= counter + 1;
	end
end

endmodule
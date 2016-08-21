`timescale 1ns/100ps

module {{cookiecutter.module_name}}_tb;

reg clock = 0;
reg reset = 0;

// -------------------------------------------------------
// CLOCK GENERATION
// ------------------------------------------------------- 

always begin
	clock=0; #4;  // 125 MHz
	clock=1; #4;
end

// -------------------------------------------------------
// TERMINATION
// ------------------------------------------------------- 

initial begin
	#100 $finish;	
end

// -------------------------------------------------------
// INITIALIZATION
// ------------------------------------------------------- 

initial begin
	if ($test$plusargs("vcd")) begin
		$dumpfile ("{{cookiecutter.module_name}}_tb.vcd");
		$dumpvars (5, {{cookiecutter.module_name}}_tb, dut);
	end
end

// -------------------------------------------------------
// TEST CASES
// ------------------------------------------------------- 

initial begin
	// Provide dut stimulus here
	#8 reset = 1;
	#8 reset = 0;
end

{{cookiecutter.module_name}} dut (
	.clk(clock),
	.reset(reset),

	.counter()
);

endmodule
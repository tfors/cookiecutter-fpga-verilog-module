`timescale 1ns/100ps

module {{cookiecutter.module_name}}_tb;

reg clock = 0;
reg reset = 0;

{%- if cookiecutter.include_avalon_mm_interface == 'True' %}

reg [1:0] address = 0;
reg read = 0;
wire [31:0] readdata;
reg write = 0;
reg [31:0] writedata = 0;
{%- endif %}

{%- if cookiecutter.include_avalon_st_interface == 'True' %}

reg [7:0] st_data = 0;
reg st_valid = 0;
{%- endif %}

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
	{%- if cookiecutter.include_avalon_mm_interface == 'True' %}
	#2000 $finish;
	{%- else %}
	#100 $finish;
	{%- endif %}
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

{%- if cookiecutter.include_avalon_mm_interface == 'True' %}

initial begin
	#1000 @(negedge clock)
	address = 0;
	writedata = 32'h80000000;
	write = 1;
	#8
	write = 0;
end
{%- endif %}

{%- if cookiecutter.include_avalon_st_interface == 'True' %}

always begin
	@(posedge clock)
	st_data <= st_data + 1;
	st_valid <= ~st_valid;
end
{%- endif %}


{{cookiecutter.module_name}} dut (
	.clk(clock),
	.reset(reset),

	{%- if cookiecutter.include_avalon_mm_interface == 'True' %}

	.address(address),
	.read(read),
	.readdata(readdata),
	.write(write),
	.writedata(writedata),
	{%- endif %}

	{%- if cookiecutter.include_avalon_st_interface == 'True' %}

	.asi_data(st_data),
	.asi_valid(st_valid),

	.aso_data(),
	.aso_valid(),
	{%- endif %}

	.counter()
);

endmodule

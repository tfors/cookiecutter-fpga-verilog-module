// {{cookiecutter.module_name}}.v
//
// {{cookiecutter.email}}, {{cookiecutter.date}}
//
// Purpose:
//   {{cookiecutter.purpose}}


module {{cookiecutter.module_name}} (
	input             clk,
	input             reset,

	{%- if cookiecutter.include_avalon_mm_interface == 'True' %}

	// Avalon-MM Interface
	input       [1:0] address,
	input             write,
	input      [31:0] writedata,
	input             read,
	output reg [31:0] readdata = 0,
	{%- endif %}

	{%- if cookiecutter.include_avalon_st_interface == 'True' %}

	// Avalon-ST Sink Interface
	input       [7:0] asi_data,
	input             asi_valid,

	// Avalon-ST Source Interface
	output reg  [7:0] aso_data = 0,
	output reg        aso_valid = 0,
	{%- endif %}

	output reg [31:0] counter
);

{%- if cookiecutter.include_avalon_mm_interface == 'True' %}

reg [31:0] csr_reg [0:3];
wire enable_counter;

assign enable_counter = csr_reg[0][31];
{%- endif %}

always @(posedge clk) begin
	if (reset == 1) begin
		counter <= 0;
	end else begin
		{%- if cookiecutter.include_avalon_mm_interface == 'True' %}
		if (enable_counter == 1) begin
			counter <= counter + 1;
		end

		{%- else %}
		counter <= counter + 1;
		{%- endif %}
	end

{%- if cookiecutter.include_avalon_st_interface == 'True' %}

	// Avalon-ST Processing
	aso_valid <= 0;
	if (asi_valid == 1) begin
		aso_valid <= 1;
		aso_data <= ~asi_data;
	end
{%- endif %}

{%- if cookiecutter.include_avalon_mm_interface == 'True' %}

	// Avalon-MM Read Interface
	if (read == 1) begin
		case (address)
			0:	readdata <= csr_reg[0];
			1:	readdata <= csr_reg[1];
			2:	readdata <= csr_reg[2];
			3:	readdata <= csr_reg[3];
		endcase
	end

	// Avalon-MM Write Interface
	if (write == 1) begin
		case (address)
			0:	csr_reg[0] <= writedata;
			1:	csr_reg[1] <= writedata;
			2:	csr_reg[2] <= writedata;
			3:	csr_reg[3] <= writedata;
		endcase
	end
{%- endif %}
end

endmodule

TESTBENCH = {{cookiecutter.module_name}}_tb

SRC += $(TESTBENCH).v
SRC += {{cookiecutter.module_name}}.v

.PHONY: test
test: $(SRC)
	iverilog -o $(TESTBENCH).vvp $^
	vvp -n $(TESTBENCH).vvp +vcd -lxt2
	gtkwave $(TESTBENCH).vcd $(TESTBENCH).sav

.PHONY: clean
clean:
	rm -rf *.vvp *.vcd *~

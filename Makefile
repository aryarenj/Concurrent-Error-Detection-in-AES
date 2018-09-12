compile:
	python work.py
	vlogan -full64 -sverilog sbox.v aes_128.v aes_128_tb.v
	vhdlan -full64 keyXor_128.vhd sbox_128.vhd shiftRow_128.vhd mixColumn_128.vhd mixColumn.vhd keyExpansion.vhd fault_injector.vhd state_machine.vhd
	vcs -full64 aes_128_tb -debug_all

run: simv
	./simv

clean:
	rm -rf simv out.txt simv.daidir/ ucli.key work csrc/ synopsys_sim.setup 64 .vlogan* ._* AN.DB


module aes_128_tb();

// testbench signals
reg [127:0] key_tb_sig;
reg [127:0] data_tb_sig;

// input signals
reg clock_sig;
reg reset_sig;
reg faulty_sig;
reg [7:0] key_sig [3:0][3:0];
reg [7:0] data_sig [3:0][3:0];
reg [3:0] fault_round_sig;
reg [5:0] fault_time_sig;
reg [3:0] fault_round2_sig;
reg [2:0] fault_bit_sig;
reg [2:0] fault_bit2_sig;
reg [2:0] fault_bit3_sig;
reg [2:0] fault_bit4_sig;
reg [2:0] fault_bit5_sig;
reg [2:0] fault_bit6_sig;
reg [2:0] fault_bit7_sig;
reg [2:0] fault_bit8_sig;
reg [1:0] fault_function_sig;
reg [1:0] fault_word_sig;
reg [1:0] fault_word2_sig;
reg [1:0] fault_word3_sig;
reg [1:0] fault_word4_sig;
reg [1:0] fault_word5_sig;
reg [1:0] fault_word6_sig;
reg [1:0] fault_word7_sig;
reg [1:0] fault_word8_sig;
reg [1:0] fault_byte_sig;
reg [1:0] fault_byte2_sig;
reg [1:0] fault_byte3_sig;
reg [1:0] fault_byte4_sig;
reg [1:0] fault_byte5_sig;
reg [1:0] fault_byte6_sig;
reg [1:0] fault_byte7_sig;
reg [1:0] fault_byte8_sig;
reg [1:0] MODE;
reg [3:0] CED_round;
   
// output signals
wire [7:0] ciphertext_sig [3:0][3:0];
wire done_sig, fault_sig;

// file handlers
integer data_file, scan_file, out_file, count;

// design under test
aes_128 DUT (.clock(clock_sig), .reset(reset_sig), .data(data_sig), .key(key_sig), .ciphertext(ciphertext_sig), .done(done_sig), .fault_detected(fault_sig), .faulty(faulty_sig), .fault_round(fault_round_sig), .fault_time(fault_time_sig), .fault_function(fault_function_sig), .fault_word(fault_word_sig), .fault_byte(fault_byte_sig), .fault_bit(fault_bit_sig), .fault_word2(fault_word2_sig), .fault_byte2(fault_byte2_sig), .fault_bit2(fault_bit2_sig), .fault_word3(fault_word3_sig), .fault_byte3(fault_byte3_sig), .fault_bit3(fault_bit3_sig), .fault_word4(fault_word4_sig), .fault_byte4(fault_byte4_sig), .fault_bit4(fault_bit4_sig), .fault_word5(fault_word5_sig), .fault_byte5(fault_byte5_sig), .fault_bit5(fault_bit5_sig), .fault_word6(fault_word6_sig), .fault_byte6(fault_byte6_sig), .fault_bit6(fault_bit6_sig), .fault_word7(fault_word7_sig), .fault_byte7(fault_byte7_sig), .fault_bit7(fault_bit7_sig), .fault_word8(fault_word8_sig), .fault_byte8(fault_byte8_sig), .fault_bit8(fault_bit8_sig), .CED(MODE), .CED_round(CED_round));

initial begin

	data_file = $fopen("./in.txt", "r");
	if (!data_file) begin
		$display("error opening input file for reading");
		$finish;
	end
	
	out_file = $fopen("./out.txt", "w");
	if (!out_file) begin
		$display("error opening output file for writing");
		$finish;
	end

	scan_file = $fscanf(data_file, "%x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %x %b %x\n", faulty_sig, fault_round_sig, fault_time_sig, fault_function_sig, fault_word_sig, fault_byte_sig, fault_bit_sig, fault_word2_sig, fault_byte2_sig, fault_bit2_sig, fault_word3_sig, fault_byte3_sig, fault_bit3_sig, fault_word4_sig, fault_byte4_sig, fault_bit4_sig, fault_word5_sig, fault_byte5_sig, fault_bit5_sig, fault_word6_sig, fault_byte6_sig, fault_bit6_sig, fault_word7_sig, fault_byte7_sig, fault_bit7_sig, fault_word8_sig, fault_byte8_sig, fault_bit8_sig, MODE, CED_round); 
	#2
	
	scan_file = $fscanf(data_file, "%x\n", key_tb_sig);
	#2
	key_sig[3][3] = key_tb_sig[127:120];
	key_sig[2][3] = key_tb_sig[119:112];
	key_sig[1][3] = key_tb_sig[111:104];
	key_sig[0][3] = key_tb_sig[103:96];
	key_sig[3][2] = key_tb_sig[95:88];
	key_sig[2][2] = key_tb_sig[87:80];
	key_sig[1][2] = key_tb_sig[79:72];
	key_sig[0][2] = key_tb_sig[71:64];
	key_sig[3][1] = key_tb_sig[63:56];
	key_sig[2][1] = key_tb_sig[55:48];
	key_sig[1][1] = key_tb_sig[47:40];
	key_sig[0][1] = key_tb_sig[39:32];
	key_sig[3][0] = key_tb_sig[31:24];
	key_sig[2][0] = key_tb_sig[23:16];
	key_sig[1][0] = key_tb_sig[15:8];
	key_sig[0][0] = key_tb_sig[7:0];
	
	scan_file = $fscanf(data_file, "%x\n", data_tb_sig);
	#2
	data_sig[3][3] = data_tb_sig[127:120];
	data_sig[2][3] = data_tb_sig[119:112];
	data_sig[1][3] = data_tb_sig[111:104];
	data_sig[0][3] = data_tb_sig[103:96];
	data_sig[3][2] = data_tb_sig[95:88];
	data_sig[2][2] = data_tb_sig[87:80];
	data_sig[1][2] = data_tb_sig[79:72];
	data_sig[0][2] = data_tb_sig[71:64];
	data_sig[3][1] = data_tb_sig[63:56];
	data_sig[2][1] = data_tb_sig[55:48];
	data_sig[1][1] = data_tb_sig[47:40];
	data_sig[0][1] = data_tb_sig[39:32];
	data_sig[3][0] = data_tb_sig[31:24];
	data_sig[2][0] = data_tb_sig[23:16];
	data_sig[1][0] = data_tb_sig[15:8];
	data_sig[0][0] = data_tb_sig[7:0];
	
	clock_sig <= 1'b0;
	reset_sig <= 1'b0;
	#40;
	reset_sig <= 1'b1;
	#40;
	reset_sig <= 1'b0;
	count = 0;
	clock_sig <= 1'b0;
		
	#900
	$fwrite(out_file, "%x", ciphertext_sig[3][3]);
	$fwrite(out_file, "%x", ciphertext_sig[2][3]);
	$fwrite(out_file, "%x", ciphertext_sig[1][3]);
	$fwrite(out_file, "%x", ciphertext_sig[0][3]);
	$fwrite(out_file, "%x", ciphertext_sig[3][2]);
	$fwrite(out_file, "%x", ciphertext_sig[2][2]);
	$fwrite(out_file, "%x", ciphertext_sig[1][2]);
	$fwrite(out_file, "%x", ciphertext_sig[0][2]);
	$fwrite(out_file, "%x", ciphertext_sig[3][1]);
	$fwrite(out_file, "%x", ciphertext_sig[2][1]);
	$fwrite(out_file, "%x", ciphertext_sig[1][1]);
	$fwrite(out_file, "%x", ciphertext_sig[0][1]);
	$fwrite(out_file, "%x", ciphertext_sig[3][0]);
	$fwrite(out_file, "%x", ciphertext_sig[2][0]);
	$fwrite(out_file, "%x", ciphertext_sig[1][0]);
	$fwrite(out_file, "%x\n", ciphertext_sig[0][0]);
	$fwrite(out_file, "%b\n", fault_sig);
	
	$display("----------------------------------------");
	$display("Done - ciphertext written to out.txt");
	$display("----------------------------------------");
  
	$finish;
		
end

always #20 clock_sig <= ~clock_sig;

endmodule

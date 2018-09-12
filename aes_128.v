
module aes_128 (
		input 		 clock,
		input 		 reset,
		input [7:0] 	 data [3:0][3:0],
		input [7:0] 	 key [3:0][3:0],
		output reg [7:0] ciphertext [3:0][3:0],
		output reg 	 done,
		output reg 	 fault_detected, 
		input 		 faulty,
		input [3:0] 	 fault_round,
		input [5:0] 	 fault_time, 
		input [1:0] 	 fault_function,
		input [1:0] 	 fault_word,
		input [1:0] 	 fault_byte,
		input [2:0] 	 fault_bit,
		input [1:0] 	 fault_word2,
		input [1:0] 	 fault_byte2,
		input [2:0] 	 fault_bit2,
		input [1:0] 	 fault_word3,
		input [1:0] 	 fault_byte3,
		input [2:0] 	 fault_bit3,
		input [1:0] 	 fault_word4,
		input [1:0] 	 fault_byte4,
		input [2:0] 	 fault_bit4,
		input [1:0] 	 fault_word5,
		input [1:0] 	 fault_byte5,
		input [2:0] 	 fault_bit5,
		input [1:0] 	 fault_word6,
		input [1:0] 	 fault_byte6,
		input [2:0] 	 fault_bit6,
		input [1:0] 	 fault_word7,
		input [1:0] 	 fault_byte7,
		input [2:0] 	 fault_bit7,
		input [1:0] 	 fault_word8,
		input [1:0] 	 fault_byte8,
		input [2:0] 	 fault_bit8,
		input [1:0] 	 CED,
		input [3:0] 	 CED_round
		);

   wire 			 done_sig;
   wire 			 faulty_sig;
   wire 			 clock_sig;
   wire 			 reset_sig;
   wire [7:0] 			 key_sig [10:0][3:0][3:0];
   wire [7:0] 			 data_sig [3:0][3:0];
   wire [7:0] 			 data_reg_sig [3:0][3:0];
   wire [15:0]			 parity_sig;
   wire [7:0] 			 user_key_sig [3:0][3:0];
   wire [7:0] 			 key_round [3:0][3:0];
   wire [7:0] 			 keyXor_0_out_sig [3:0][3:0];
   wire [7:0] 			 keyXor_0_out_eff_sig [3:0][3:0];
   wire [7:0] 			 keyXor_10_out_sig [3:0][3:0];
   wire [7:0] 			 keyXor_10_out_eff_sig [3:0][3:0];
   wire [7:0] 			 keyXor_out_sig [3:0][3:0];
   wire [7:0] 			 keyXor_out_eff_sig [3:0][3:0];
   wire [7:0] 			 sbox_out_sig [3:0][3:0];
   wire [7:0] 			 sbox_out_eff_sig [3:0][3:0];
   wire [7:0] 			 shiftRow_out_sig [3:0][3:0];
   wire [7:0] 			 shiftRow_out_eff_sig [3:0][3:0];
   wire [7:0] 			 mixColumn_out_sig [3:0][3:0];
   wire [7:0] 			 mixColumn_out_eff_sig [3:0][3:0];
   wire [3:0] 			 fault_round_sig;
   wire [1:0] 			 fault_function_sig;
   wire [1:0] 			 fault_word_sig;
   wire [1:0] 			 fault_byte_sig;
   wire [2:0] 			 fault_bit_sig;
   wire [1:0] 			 fault_word2_sig;
   wire [1:0] 			 fault_byte2_sig;
   wire [2:0] 			 fault_bit2_sig;
   wire [1:0] 			 fault_word3_sig;
   wire [1:0] 			 fault_byte3_sig;
   wire [2:0] 			 fault_bit3_sig;
   wire [1:0] 			 fault_word4_sig;
   wire [1:0] 			 fault_byte4_sig;
   wire [2:0] 			 fault_bit4_sig;
   wire [1:0] 			 fault_word5_sig;
   wire [1:0] 			 fault_byte5_sig;
   wire [2:0] 			 fault_bit5_sig;
   wire [1:0] 			 fault_word6_sig;
   wire [1:0] 			 fault_byte6_sig;
   wire [2:0] 			 fault_bit6_sig;
   wire [1:0] 			 fault_word7_sig;
   wire [1:0] 			 fault_byte7_sig;
   wire [2:0] 			 fault_bit7_sig;
   wire [1:0] 			 fault_word8_sig;
   wire [1:0] 			 fault_byte8_sig;
   wire [2:0] 			 fault_bit8_sig;
   wire [3:0] 			 key_index_vector_sig;
   integer 			 key_index;
   wire 			 keyXor_fault, shift_fault, mix_fault, sbox_fault;
   wire [7:0] 			 alpha_data1[3:0][3:0];
   wire [7:0] 			 alpha_data2[3:0][3:0];
   wire [7:0] 			 data_mux1[1:0][3:0][3:0];
   wire [7:0] 			 data_mux2[1:0][3:0][3:0];
   wire 			 mode; 		
   wire 			 cmp;
   wire 			 state_sm;
   wire [7:0]			 alpha_data_reg_sig[3:0][3:0];
   
   assign alpha_data1[0][0] = data[0][3];
   assign alpha_data1[0][1] = data[0][0];
   assign alpha_data1[0][2] = data[0][1];
   assign alpha_data1[0][3] = data[0][2];
   assign alpha_data1[1][0] = data[1][3];
   assign alpha_data1[1][1] = data[1][0];
   assign alpha_data1[1][2] = data[1][1];
   assign alpha_data1[1][3] = data[1][2];
   assign alpha_data1[2][0] = data[2][3];
   assign alpha_data1[2][1] = data[2][0];
   assign alpha_data1[2][2] = data[2][1];
   assign alpha_data1[2][3] = data[2][2];
   assign alpha_data1[3][0] = data[3][3];
   assign alpha_data1[3][1] = data[3][0];
   assign alpha_data1[3][2] = data[3][1];
   assign alpha_data1[3][3] = data[3][2];

   assign alpha_data2[0][0] = data_reg_sig[0][1];
   assign alpha_data2[0][1] = data_reg_sig[0][2];
   assign alpha_data2[0][2] = data_reg_sig[0][3];
   assign alpha_data2[0][3] = data_reg_sig[0][0];
   assign alpha_data2[1][0] = data_reg_sig[1][1];
   assign alpha_data2[1][1] = data_reg_sig[1][2];
   assign alpha_data2[1][2] = data_reg_sig[1][3];
   assign alpha_data2[1][3] = data_reg_sig[1][0];
   assign alpha_data2[2][0] = data_reg_sig[2][1];
   assign alpha_data2[2][1] = data_reg_sig[2][2];
   assign alpha_data2[2][2] = data_reg_sig[2][3];
   assign alpha_data2[2][3] = data_reg_sig[2][0];
   assign alpha_data2[3][0] = data_reg_sig[3][1];
   assign alpha_data2[3][1] = data_reg_sig[3][2];
   assign alpha_data2[3][2] = data_reg_sig[3][3];
   assign alpha_data2[3][3] = data_reg_sig[3][0];
   
   assign data_mux1[0] = data;
   assign data_mux1[1] = alpha_data1;
   assign data_mux2[0] = data_reg_sig;
   assign data_mux2[1] = alpha_data2;
   
   assign clock_sig = clock;
   assign reset_sig = reset;
   assign data_sig = data_mux1[mode];
   assign user_key_sig = key;
   assign key_sig[0] = key;	
   assign key_round = key_sig[key_index];
   assign ciphertext = data_reg_sig;
   assign done = done_sig;
   assign faulty_sig = faulty;
   assign fault_round_sig =  fault_round;
   assign fault_function_sig = fault_function;
   assign fault_word_sig = fault_word;
   assign fault_byte_sig = fault_byte;
   assign fault_bit_sig = fault_bit;
   assign fault_word2_sig = fault_word2;
   assign fault_byte2_sig = fault_byte2;
   assign fault_bit2_sig = fault_bit2;
   assign fault_word3_sig = fault_word3;
   assign fault_byte3_sig = fault_byte3;
   assign fault_bit3_sig = fault_bit3;
   assign fault_word4_sig = fault_word4;
   assign fault_byte4_sig = fault_byte4;
   assign fault_bit4_sig = fault_bit4;
   assign fault_word5_sig = fault_word5;
   assign fault_byte5_sig = fault_byte5;
   assign fault_bit5_sig = fault_bit5;
   assign fault_word6_sig = fault_word6;
   assign fault_byte6_sig = fault_byte6;
   assign fault_bit6_sig = fault_bit6;
   assign fault_word7_sig = fault_word7;
   assign fault_byte7_sig = fault_byte7;
   assign fault_bit7_sig = fault_bit7;
   assign fault_word8_sig = fault_word8;
   assign fault_byte8_sig = fault_byte8;
   assign fault_bit8_sig = fault_bit8;
   assign key_index = key_index_vector_sig;
   assign alpha_data_reg_sig = data_mux2[mode];

   /* You should build your components around the following input/output signals:-
    -- data_reg_sig/sbox_out_eff_sig: input/output of sbox operation for rounds 1-9
    -- sbox_out_eff_sig/shiftRow_out_eff_sig: input/output shiftrow operation for rounds 1-9
    -- shiftRow_out_eff_sig/mixColumn_out_eff_sig: input/output of mixcolumn operation for rounds 1-9
    -- mixColumn_out_eff_sig/keyXor_out_eff_sig: input/output of keyXor operation for rounds 1-9
    */
   state_machine state_machine_x (clock_sig, reset_sig, keyXor_0_out_eff_sig, keyXor_out_eff_sig, keyXor_10_out_sig, data_reg_sig, done_sig, key_index_vector_sig, CED, CED_round, mode, state_sm, fault_detected);
   keyExpansion keyExpansion_x (user_key_sig,key_sig[1],key_sig[2],key_sig[3],key_sig[4],key_sig[5],key_sig[6],key_sig[7],key_sig[8],key_sig[9],key_sig[10]);
   keyXor_128 keyXor_128_a (data_sig, key_sig[0], mode, keyXor_0_out_sig);
   sbox_128 sbox_128_x (alpha_data_reg_sig, sbox_out_sig, parity_sig);
   shiftRow_128 shiftRow_128_x (sbox_out_eff_sig, shiftRow_out_sig);
   mixColumn_128 mixColumn_128_x (shiftRow_out_eff_sig, mixColumn_out_sig);
   keyXor_128 keyXor_128_b (mixColumn_out_eff_sig, key_round, mode, keyXor_out_sig);
   keyXor_128 keyXor_128_c (shiftRow_out_eff_sig, key_sig[10], mode, keyXor_10_out_sig);
   fault_injector fault_injector_x (faulty_sig, fault_round_sig, fault_time, fault_function_sig, fault_word_sig, fault_byte_sig, fault_bit_sig, fault_word2_sig, fault_byte2_sig, fault_bit2_sig, fault_word3_sig, fault_byte3_sig, fault_bit3_sig, fault_word4_sig, fault_byte4_sig, fault_bit4_sig, fault_word5_sig, fault_byte5_sig, fault_bit5_sig, fault_word6_sig, fault_byte6_sig, fault_bit6_sig, fault_word7_sig, fault_byte7_sig, fault_bit7_sig, fault_word8_sig, fault_byte8_sig, fault_bit8_sig, key_index_vector_sig, keyXor_0_out_sig, keyXor_10_out_sig, keyXor_out_sig, sbox_out_sig, shiftRow_out_sig, mixColumn_out_sig, keyXor_0_out_eff_sig, keyXor_10_out_eff_sig, keyXor_out_eff_sig, sbox_out_eff_sig, shiftRow_out_eff_sig, mixColumn_out_eff_sig, state_sm);
   
endmodule

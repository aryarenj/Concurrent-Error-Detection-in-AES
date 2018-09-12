library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.numeric_std.all;
use work.STD_LOGIC_UNSIGNED.ALL;
use work.aes128Pkg.all;

entity fault_injector is
  port (
	faulty : in std_logic;
	fault_round : in std_logic_vector (3 downto 0);
        fault_time : in std_logic_vector (5 downto 0);
	fault_function : in std_logic_vector (1 downto 0);
	fault_word : in std_logic_vector (1 downto 0);
	fault_byte : in std_logic_vector (1 downto 0);
	fault_bit : in std_logic_vector (2 downto 0);
	fault_word2 : in std_logic_vector (1 downto 0);
	fault_byte2 : in std_logic_vector (1 downto 0);
	fault_bit2 : in std_logic_vector (2 downto 0);
	fault_word3 : in std_logic_vector (1 downto 0);
	fault_byte3 : in std_logic_vector (1 downto 0);
	fault_bit3 : in std_logic_vector (2 downto 0);
	fault_word4 : in std_logic_vector (1 downto 0);
	fault_byte4 : in std_logic_vector (1 downto 0);
	fault_bit4 : in std_logic_vector (2 downto 0);
	fault_word5 : in std_logic_vector (1 downto 0);
	fault_byte5 : in std_logic_vector (1 downto 0);
	fault_bit5 : in std_logic_vector (2 downto 0);
	fault_word6 : in std_logic_vector (1 downto 0);
	fault_byte6 : in std_logic_vector (1 downto 0);
	fault_bit6 : in std_logic_vector (2 downto 0);
	fault_word7 : in std_logic_vector (1 downto 0);
	fault_byte7 : in std_logic_vector (1 downto 0);
	fault_bit7 : in std_logic_vector (2 downto 0);
	fault_word8 : in std_logic_vector (1 downto 0);
	fault_byte8 : in std_logic_vector (1 downto 0);
	fault_bit8 : in std_logic_vector (2 downto 0);
	key_index_vector : in std_logic_vector (3 downto 0);
	keyXor_0_out : in Matrix;
	keyXor_10_out : in Matrix;
	keyXor_out : in Matrix;
	sbox_out : in Matrix;
	shiftRow_out : in Matrix;
	mixColumn_out : in Matrix;
	keyXor_0_out_eff : out Matrix;
	keyXor_10_out_eff : out Matrix;
	keyXor_out_eff : out Matrix;
	sbox_out_eff : out Matrix;
	shiftRow_out_eff : out Matrix;
	mixColumn_out_eff : out Matrix;
        state_sm : in std_logic_vector (0 downto 0)
	);
end entity fault_injector;

architecture Behavioral of fault_injector is

signal sbox_out_flt : Matrix;
signal shiftRow_out_flt : Matrix;
signal mixColumn_out_flt : Matrix;
signal keyXor_out_flt : Matrix;
signal keyXor_0_out_flt : Matrix;
signal keyXor_10_out_flt : Matrix;
signal temp_bit : std_logic;
signal key_index : integer range 0 to 11;
signal fault_round_index : integer range 0 to 10;
signal fault_function_index : integer range 0 to 3;
signal fault_word_index : integer range 0 to 3;
signal fault_byte_index : integer range 0 to 3;
signal fault_bit_index : integer range 0 to 7;
signal fault_word2_index : integer range 0 to 3;
signal fault_byte2_index : integer range 0 to 3;
signal fault_bit2_index : integer range 0 to 7;
signal fault_word3_index : integer range 0 to 3;
signal fault_byte3_index : integer range 0 to 3;
signal fault_bit3_index : integer range 0 to 7;
signal fault_word4_index : integer range 0 to 3;
signal fault_byte4_index : integer range 0 to 3;
signal fault_bit4_index : integer range 0 to 7;
signal fault_word5_index : integer range 0 to 3;
signal fault_byte5_index : integer range 0 to 3;
signal fault_bit5_index : integer range 0 to 7;
signal fault_word6_index : integer range 0 to 3;
signal fault_byte6_index : integer range 0 to 3;
signal fault_bit6_index : integer range 0 to 7;
signal fault_word7_index : integer range 0 to 3;
signal fault_byte7_index : integer range 0 to 3;
signal fault_bit7_index : integer range 0 to 7;
signal fault_word8_index : integer range 0 to 3;
signal fault_byte8_index : integer range 0 to 3;
signal fault_bit8_index : integer range 0 to 7;

begin

key_index <= (2 * to_integer(unsigned(key_index_vector))) + to_integer(unsigned(state_sm));
fault_round_index <= to_integer(unsigned(fault_round));
fault_function_index <= to_integer(unsigned(fault_function));
fault_word_index <= to_integer(unsigned(fault_word));
fault_byte_index <= to_integer(unsigned(fault_byte));
fault_bit_index <= to_integer(unsigned(fault_bit));
fault_word2_index <= to_integer(unsigned(fault_word2));
fault_byte2_index <= to_integer(unsigned(fault_byte2));
fault_bit2_index <= to_integer(unsigned(fault_bit2));
fault_word3_index <= to_integer(unsigned(fault_word3));
fault_byte3_index <= to_integer(unsigned(fault_byte3));
fault_bit3_index <= to_integer(unsigned(fault_bit3));
fault_word4_index <= to_integer(unsigned(fault_word4));
fault_byte4_index <= to_integer(unsigned(fault_byte4));
fault_bit4_index <= to_integer(unsigned(fault_bit4));
fault_word5_index <= to_integer(unsigned(fault_word5));
fault_byte5_index <= to_integer(unsigned(fault_byte5));
fault_bit5_index <= to_integer(unsigned(fault_bit5));
fault_word6_index <= to_integer(unsigned(fault_word6));
fault_byte6_index <= to_integer(unsigned(fault_byte6));
fault_bit6_index <= to_integer(unsigned(fault_bit6));
fault_word7_index <= to_integer(unsigned(fault_word7));
fault_byte7_index <= to_integer(unsigned(fault_byte7));
fault_bit7_index <= to_integer(unsigned(fault_bit7));
fault_word8_index <= to_integer(unsigned(fault_word8));
fault_byte8_index <= to_integer(unsigned(fault_byte8));
fault_bit8_index <= to_integer(unsigned(fault_bit8));

process(keyXor_0_out, fault_word_index, fault_byte_index, fault_bit_index, fault_word2_index, fault_byte2_index, fault_bit2_index, fault_word3_index, fault_byte3_index, fault_bit3_index, fault_word4_index, fault_byte4_index, fault_bit4_index, fault_word5_index, fault_byte5_index, fault_bit5_index, fault_word6_index, fault_byte6_index, fault_bit6_index, fault_word7_index, fault_byte7_index, fault_bit7_index, fault_word8_index, fault_byte8_index, fault_bit8_index)
begin
	keyXor_0_out_flt <= keyXor_0_out;
	keyXor_0_out_flt(fault_word_index)(fault_byte_index)(7 - fault_bit_index) <= not keyXor_0_out(fault_word_index)(fault_byte_index)(7 - fault_bit_index);
	if (fault_word_index /= fault_word2_index or fault_byte_index /= fault_byte2_index or fault_bit_index /= fault_bit2_index) then
		keyXor_0_out_flt(fault_word2_index)(fault_byte2_index)(7 - fault_bit2_index) <= not keyXor_0_out(fault_word2_index)(fault_byte2_index)(7 - fault_bit2_index);
	end if;
	if (fault_word_index /= fault_word3_index or fault_byte_index /= fault_byte3_index or fault_bit_index /= fault_bit3_index) then
		keyXor_0_out_flt(fault_word3_index)(fault_byte3_index)(7 - fault_bit3_index) <= not keyXor_0_out(fault_word3_index)(fault_byte3_index)(7 - fault_bit3_index);
	end if;
	if (fault_word_index /= fault_word4_index or fault_byte_index /= fault_byte4_index or fault_bit_index /= fault_bit4_index) then
		keyXor_0_out_flt(fault_word4_index)(fault_byte4_index)(7 - fault_bit4_index) <= not keyXor_0_out(fault_word4_index)(fault_byte4_index)(7 - fault_bit4_index);
	end if;
	if (fault_word_index /= fault_word5_index or fault_byte_index /= fault_byte5_index or fault_bit_index /= fault_bit5_index) then
		keyXor_0_out_flt(fault_word5_index)(fault_byte5_index)(7 - fault_bit5_index) <= not keyXor_0_out(fault_word5_index)(fault_byte5_index)(7 - fault_bit5_index);
	end if;
	if (fault_word_index /= fault_word6_index or fault_byte_index /= fault_byte6_index or fault_bit_index /= fault_bit6_index) then
		keyXor_0_out_flt(fault_word6_index)(fault_byte6_index)(7 - fault_bit6_index) <= not keyXor_0_out(fault_word6_index)(fault_byte6_index)(7 - fault_bit6_index);
	end if;
	if (fault_word_index /= fault_word7_index or fault_byte_index /= fault_byte7_index or fault_bit_index /= fault_bit7_index) then
		keyXor_0_out_flt(fault_word7_index)(fault_byte7_index)(7 - fault_bit7_index) <= not keyXor_0_out(fault_word7_index)(fault_byte7_index)(7 - fault_bit7_index);
	end if;
	if (fault_word_index /= fault_word8_index or fault_byte_index /= fault_byte8_index or fault_bit_index /= fault_bit8_index) then
		keyXor_0_out_flt(fault_word8_index)(fault_byte8_index)(7 - fault_bit8_index) <= not keyXor_0_out(fault_word8_index)(fault_byte8_index)(7 - fault_bit8_index);
	end if;
end process;
keyXor_0_out_eff <= keyXor_0_out_flt when (faulty = '1' and key_index >= fault_round_index and key_index < (fault_round_index + fault_time) and fault_function_index = 3) else
				  keyXor_0_out;
					  
process(keyXor_out, fault_word_index, fault_byte_index, fault_bit_index, fault_word2_index, fault_byte2_index, fault_bit2_index, fault_word3_index, fault_byte3_index, fault_bit3_index, fault_word4_index, fault_byte4_index, fault_bit4_index, fault_word5_index, fault_byte5_index, fault_bit5_index, fault_word6_index, fault_byte6_index, fault_bit6_index, fault_word7_index, fault_byte7_index, fault_bit7_index, fault_word8_index, fault_byte8_index, fault_bit8_index)
begin
	keyXor_out_flt <= keyXor_out;
	keyXor_out_flt(fault_word_index)(fault_byte_index)(7 - fault_bit_index) <= not keyXor_out(fault_word_index)(fault_byte_index)(7 - fault_bit_index);
	if (fault_word_index /= fault_word2_index or fault_byte_index /= fault_byte2_index or fault_bit_index /= fault_bit2_index) then
		keyXor_out_flt(fault_word2_index)(fault_byte2_index)(7 - fault_bit2_index) <= not keyXor_out(fault_word2_index)(fault_byte2_index)(7 - fault_bit2_index);
	end if;
	if (fault_word_index /= fault_word3_index or fault_byte_index /= fault_byte3_index or fault_bit_index /= fault_bit3_index) then
		keyXor_out_flt(fault_word3_index)(fault_byte3_index)(7 - fault_bit3_index) <= not keyXor_out(fault_word3_index)(fault_byte3_index)(7 - fault_bit3_index);
	end if;
	if (fault_word_index /= fault_word4_index or fault_byte_index /= fault_byte4_index or fault_bit_index /= fault_bit4_index) then
		keyXor_out_flt(fault_word4_index)(fault_byte4_index)(7 - fault_bit4_index) <= not keyXor_out(fault_word4_index)(fault_byte4_index)(7 - fault_bit4_index);
	end if;
	if (fault_word_index /= fault_word5_index or fault_byte_index /= fault_byte5_index or fault_bit_index /= fault_bit5_index) then
		keyXor_out_flt(fault_word5_index)(fault_byte5_index)(7 - fault_bit5_index) <= not keyXor_out(fault_word5_index)(fault_byte5_index)(7 - fault_bit5_index);
	end if;
	if (fault_word_index /= fault_word6_index or fault_byte_index /= fault_byte6_index or fault_bit_index /= fault_bit6_index) then
		keyXor_out_flt(fault_word6_index)(fault_byte6_index)(7 - fault_bit6_index) <= not keyXor_out(fault_word6_index)(fault_byte6_index)(7 - fault_bit6_index);
	end if;
	if (fault_word_index /= fault_word7_index or fault_byte_index /= fault_byte7_index or fault_bit_index /= fault_bit7_index) then
		keyXor_out_flt(fault_word7_index)(fault_byte7_index)(7 - fault_bit7_index) <= not keyXor_out(fault_word7_index)(fault_byte7_index)(7 - fault_bit7_index);
	end if;
	if (fault_word_index /= fault_word8_index or fault_byte_index /= fault_byte8_index or fault_bit_index /= fault_bit8_index) then
		keyXor_out_flt(fault_word8_index)(fault_byte8_index)(7 - fault_bit8_index) <= not keyXor_out(fault_word8_index)(fault_byte8_index)(7 - fault_bit8_index);
	end if;
end process;
keyXor_out_eff <= keyXor_out_flt when (faulty = '1' and key_index >= fault_round_index and key_index < (fault_round_index + fault_time) and fault_function_index = 3) else
				  keyXor_out;
				  
process(sbox_out, fault_word_index, fault_byte_index, fault_bit_index, fault_word2_index, fault_byte2_index, fault_bit2_index, fault_word3_index, fault_byte3_index, fault_bit3_index, fault_word4_index, fault_byte4_index, fault_bit4_index, fault_word5_index, fault_byte5_index, fault_bit5_index, fault_word6_index, fault_byte6_index, fault_bit6_index, fault_word7_index, fault_byte7_index, fault_bit7_index, fault_word8_index, fault_byte8_index, fault_bit8_index)
begin
	sbox_out_flt <= sbox_out;
	sbox_out_flt(fault_word_index)(fault_byte_index)(7 - fault_bit_index) <= not sbox_out(fault_word_index)(fault_byte_index)(7 - fault_bit_index);
	if (fault_word_index /= fault_word2_index or fault_byte_index /= fault_byte2_index or fault_bit_index /= fault_bit2_index) then
		sbox_out_flt(fault_word2_index)(fault_byte2_index)(7 - fault_bit2_index) <= not sbox_out(fault_word2_index)(fault_byte2_index)(7 - fault_bit2_index);
	end if;
	if (fault_word_index /= fault_word3_index or fault_byte_index /= fault_byte3_index or fault_bit_index /= fault_bit3_index) then
		sbox_out_flt(fault_word3_index)(fault_byte3_index)(7 - fault_bit3_index) <= not sbox_out(fault_word3_index)(fault_byte3_index)(7 - fault_bit3_index);
	end if;
	if (fault_word_index /= fault_word4_index or fault_byte_index /= fault_byte4_index or fault_bit_index /= fault_bit4_index) then
		sbox_out_flt(fault_word4_index)(fault_byte4_index)(7 - fault_bit4_index) <= not sbox_out(fault_word4_index)(fault_byte4_index)(7 - fault_bit4_index);
	end if;
	if (fault_word_index /= fault_word5_index or fault_byte_index /= fault_byte5_index or fault_bit_index /= fault_bit5_index) then
		sbox_out_flt(fault_word5_index)(fault_byte5_index)(7 - fault_bit5_index) <= not sbox_out(fault_word5_index)(fault_byte5_index)(7 - fault_bit5_index);
	end if;
	if (fault_word_index /= fault_word6_index or fault_byte_index /= fault_byte6_index or fault_bit_index /= fault_bit6_index) then
		sbox_out_flt(fault_word6_index)(fault_byte6_index)(7 - fault_bit6_index) <= not sbox_out(fault_word6_index)(fault_byte6_index)(7 - fault_bit6_index);
	end if;
	if (fault_word_index /= fault_word7_index or fault_byte_index /= fault_byte7_index or fault_bit_index /= fault_bit7_index) then
		sbox_out_flt(fault_word7_index)(fault_byte7_index)(7 - fault_bit7_index) <= not sbox_out(fault_word7_index)(fault_byte7_index)(7 - fault_bit7_index);
	end if;
	if (fault_word_index /= fault_word8_index or fault_byte_index /= fault_byte8_index or fault_bit_index /= fault_bit8_index) then
		sbox_out_flt(fault_word8_index)(fault_byte8_index)(7 - fault_bit8_index) <= not sbox_out(fault_word8_index)(fault_byte8_index)(7 - fault_bit8_index);
	end if;
end process;
sbox_out_eff <= sbox_out_flt when (faulty = '1' and key_index >= fault_round_index and key_index < (fault_round_index + fault_time) and fault_function_index = 0) else
				  sbox_out;
				  
process(shiftRow_out, fault_word_index, fault_byte_index, fault_bit_index, fault_word2_index, fault_byte2_index, fault_bit2_index, fault_word3_index, fault_byte3_index, fault_bit3_index, fault_word4_index, fault_byte4_index, fault_bit4_index, fault_word5_index, fault_byte5_index, fault_bit5_index, fault_word6_index, fault_byte6_index, fault_bit6_index, fault_word7_index, fault_byte7_index, fault_bit7_index, fault_word8_index, fault_byte8_index, fault_bit8_index)
begin
	shiftRow_out_flt <= shiftRow_out;
	shiftRow_out_flt(fault_word_index)(fault_byte_index)(7 - fault_bit_index) <= not shiftRow_out(fault_word_index)(fault_byte_index)(7 - fault_bit_index);
	if (fault_word_index /= fault_word2_index or fault_byte_index /= fault_byte2_index or fault_bit_index /= fault_bit2_index) then
		shiftRow_out_flt(fault_word2_index)(fault_byte2_index)(7 - fault_bit2_index) <= not shiftRow_out(fault_word2_index)(fault_byte2_index)(7 - fault_bit2_index);
	end if;
	if (fault_word_index /= fault_word3_index or fault_byte_index /= fault_byte3_index or fault_bit_index /= fault_bit3_index) then
		shiftRow_out_flt(fault_word3_index)(fault_byte3_index)(7 - fault_bit3_index) <= not shiftRow_out(fault_word3_index)(fault_byte3_index)(7 - fault_bit3_index);
	end if;
	if (fault_word_index /= fault_word4_index or fault_byte_index /= fault_byte4_index or fault_bit_index /= fault_bit4_index) then
		shiftRow_out_flt(fault_word4_index)(fault_byte4_index)(7 - fault_bit4_index) <= not shiftRow_out(fault_word4_index)(fault_byte4_index)(7 - fault_bit4_index);
	end if;
	if (fault_word_index /= fault_word5_index or fault_byte_index /= fault_byte5_index or fault_bit_index /= fault_bit5_index) then
		shiftRow_out_flt(fault_word5_index)(fault_byte5_index)(7 - fault_bit5_index) <= not shiftRow_out(fault_word5_index)(fault_byte5_index)(7 - fault_bit5_index);
	end if;
	if (fault_word_index /= fault_word6_index or fault_byte_index /= fault_byte6_index or fault_bit_index /= fault_bit6_index) then
		shiftRow_out_flt(fault_word6_index)(fault_byte6_index)(7 - fault_bit6_index) <= not shiftRow_out(fault_word6_index)(fault_byte6_index)(7 - fault_bit6_index);
	end if;
	if (fault_word_index /= fault_word7_index or fault_byte_index /= fault_byte7_index or fault_bit_index /= fault_bit7_index) then
		shiftRow_out_flt(fault_word7_index)(fault_byte7_index)(7 - fault_bit7_index) <= not shiftRow_out(fault_word7_index)(fault_byte7_index)(7 - fault_bit7_index);
	end if;
	if (fault_word_index /= fault_word8_index or fault_byte_index /= fault_byte8_index or fault_bit_index /= fault_bit8_index) then
		shiftRow_out_flt(fault_word8_index)(fault_byte8_index)(7 - fault_bit8_index) <= not shiftRow_out(fault_word8_index)(fault_byte8_index)(7 - fault_bit8_index);
	end if;
end process;
shiftRow_out_eff <= shiftRow_out_flt when (faulty = '1' and key_index >= fault_round_index and key_index < (fault_round_index + fault_time) and fault_function_index = 1) else
				  shiftRow_out;
		  
process(mixColumn_out, fault_word_index, fault_byte_index, fault_bit_index, fault_word2_index, fault_byte2_index, fault_bit2_index, fault_word3_index, fault_byte3_index, fault_bit3_index, fault_word4_index, fault_byte4_index, fault_bit4_index, fault_word5_index, fault_byte5_index, fault_bit5_index, fault_word6_index, fault_byte6_index, fault_bit6_index, fault_word7_index, fault_byte7_index, fault_bit7_index, fault_word8_index, fault_byte8_index, fault_bit8_index)
begin
	mixColumn_out_flt <= mixColumn_out;
	mixColumn_out_flt(fault_word_index)(fault_byte_index)(7 - fault_bit_index) <= not mixColumn_out(fault_word_index)(fault_byte_index)(7 - fault_bit_index);
	if (fault_word_index /= fault_word2_index or fault_byte_index /= fault_byte2_index or fault_bit_index /= fault_bit2_index) then
		mixColumn_out_flt(fault_word2_index)(fault_byte2_index)(7 - fault_bit2_index) <= not mixColumn_out(fault_word2_index)(fault_byte2_index)(7 - fault_bit2_index);
	end if;
	if (fault_word_index /= fault_word3_index or fault_byte_index /= fault_byte3_index or fault_bit_index /= fault_bit3_index) then
		mixColumn_out_flt(fault_word3_index)(fault_byte3_index)(7 - fault_bit3_index) <= not mixColumn_out(fault_word3_index)(fault_byte3_index)(7 - fault_bit3_index);
	end if;
	if (fault_word_index /= fault_word4_index or fault_byte_index /= fault_byte4_index or fault_bit_index /= fault_bit4_index) then
		mixColumn_out_flt(fault_word4_index)(fault_byte4_index)(7 - fault_bit4_index) <= not mixColumn_out(fault_word4_index)(fault_byte4_index)(7 - fault_bit4_index);
	end if;
	if (fault_word_index /= fault_word5_index or fault_byte_index /= fault_byte5_index or fault_bit_index /= fault_bit5_index) then
		mixColumn_out_flt(fault_word5_index)(fault_byte5_index)(7 - fault_bit5_index) <= not mixColumn_out(fault_word5_index)(fault_byte5_index)(7 - fault_bit5_index);
	end if;
	if (fault_word_index /= fault_word6_index or fault_byte_index /= fault_byte6_index or fault_bit_index /= fault_bit6_index) then
		mixColumn_out_flt(fault_word6_index)(fault_byte6_index)(7 - fault_bit6_index) <= not mixColumn_out(fault_word6_index)(fault_byte6_index)(7 - fault_bit6_index);
	end if;
	if (fault_word_index /= fault_word7_index or fault_byte_index /= fault_byte7_index or fault_bit_index /= fault_bit7_index) then
		mixColumn_out_flt(fault_word7_index)(fault_byte7_index)(7 - fault_bit7_index) <= not mixColumn_out(fault_word7_index)(fault_byte7_index)(7 - fault_bit7_index);
	end if;
	if (fault_word_index /= fault_word8_index or fault_byte_index /= fault_byte8_index or fault_bit_index /= fault_bit8_index) then
		mixColumn_out_flt(fault_word8_index)(fault_byte8_index)(7 - fault_bit8_index) <= not mixColumn_out(fault_word8_index)(fault_byte8_index)(7 - fault_bit8_index);
	end if;
end process;
mixColumn_out_eff <= mixColumn_out_flt when (faulty = '1' and key_index >= fault_round_index and key_index < (fault_round_index + fault_time) and fault_function_index = 2) else
				  mixColumn_out;			  
				  
end architecture Behavioral;

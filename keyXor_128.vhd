
library ieee;
use ieee.std_logic_1164.all;
use work.std_logic_textio.all;
use ieee.numeric_std.all;
use std.textio.all;
use work.aes128Pkg.all;

entity keyXor_128 is
  port (
    In_DI_data : in Matrix;
	In_DI_key : in Matrix;
        In_DI_mode : in std_logic_vector(0 downto 0);
    Out_DO : out Matrix);
end entity keyXor_128;

architecture Behavioral of keyXor_128 is

signal alpha_key : Matrix;
signal key_mux : Matrix_mux;
signal key_out : Matrix;

begin
  
alpha_key(0)(0) <= In_DI_key(0)(3);
alpha_key(0)(1) <= In_DI_key(0)(0);
alpha_key(0)(2) <= In_DI_key(0)(1);
alpha_key(0)(3) <= In_DI_key(0)(2);
alpha_key(1)(0) <= In_DI_key(1)(3);
alpha_key(1)(1) <= In_DI_key(1)(0);
alpha_key(1)(2) <= In_DI_key(1)(1);
alpha_key(1)(3) <= In_DI_key(1)(2);
alpha_key(2)(0) <= In_DI_key(2)(3);
alpha_key(2)(1) <= In_DI_key(2)(0);
alpha_key(2)(2) <= In_DI_key(2)(1);
alpha_key(2)(3) <= In_DI_key(2)(2);
alpha_key(3)(0) <= In_DI_key(3)(3);
alpha_key(3)(1) <= In_DI_key(3)(0);
alpha_key(3)(2) <= In_DI_key(3)(1);
alpha_key(3)(3) <= In_DI_key(3)(2);

key_mux(0) <= In_DI_key;
key_mux(1) <= alpha_key;

key_out <= key_mux(to_integer(unsigned(In_DI_mode)));

Out_DO(0)(0) <= In_DI_data(0)(0) xor key_out(0)(0);
Out_DO(0)(1) <= In_DI_data(0)(1) xor key_out(0)(1);
Out_DO(0)(2) <= In_DI_data(0)(2) xor key_out(0)(2);
Out_DO(0)(3) <= In_DI_data(0)(3) xor key_out(0)(3);

Out_DO(1)(0) <= In_DI_data(1)(0) xor key_out(1)(0);
Out_DO(1)(1) <= In_DI_data(1)(1) xor key_out(1)(1);
Out_DO(1)(2) <= In_DI_data(1)(2) xor key_out(1)(2);
Out_DO(1)(3) <= In_DI_data(1)(3) xor key_out(1)(3);

Out_DO(2)(0) <= In_DI_data(2)(0) xor key_out(2)(0);
Out_DO(2)(1) <= In_DI_data(2)(1) xor key_out(2)(1);
Out_DO(2)(2) <= In_DI_data(2)(2) xor key_out(2)(2);
Out_DO(2)(3) <= In_DI_data(2)(3) xor key_out(2)(3);

Out_DO(3)(0) <= In_DI_data(3)(0) xor key_out(3)(0);
Out_DO(3)(1) <= In_DI_data(3)(1) xor key_out(3)(1);
Out_DO(3)(2) <= In_DI_data(3)(2) xor key_out(3)(2);
Out_DO(3)(3) <= In_DI_data(3)(3) xor key_out(3)(3);

end architecture Behavioral;

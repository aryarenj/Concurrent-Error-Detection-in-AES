library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.numeric_std.all;
use work.STD_LOGIC_UNSIGNED.ALL;
use work.aes128Pkg.all;

entity state_machine is
  port (
	clock_sm : in std_logic;
	reset_sm : in std_logic;
	keyXor_0_out_eff_sm : in Matrix;
	keyXor_out_eff_sm : in Matrix;
	keyXor_10_out_sm : in Matrix;
        data_reg_sm : out Matrix;
	done_sm : out std_logic;
	key_index_vector_sm : out std_logic_vector(3 downto 0);
        CED : in std_logic_vector(1 downto 0);
        CED_round: in std_logic_vector(3 downto 0);
        mode : out std_logic_vector(0 downto 0);
        state_sm : out std_logic;
        err : out std_logic
	);
end entity state_machine;

architecture Behavioral of state_machine is

-- signals
signal data_reg_sig : Matrix;
signal temp_data_reg_sig : Matrix;
signal done_sig, clock_sig, reset_sig : std_logic;
signal state : std_logic;
signal key_index : integer range 0 to 11;
signal key_index_vector_sig : std_logic_vector(3 downto 0);
signal keyXor_0_out_eff_sig : Matrix;
signal keyXor_out_eff_sig : Matrix;
signal keyXor_10_out_sig : Matrix;
signal inv_keyXor_0_out_eff_sig : Matrix;
signal inv_keyXor_out_eff_sig : Matrix;
signal inv_keyXor_10_out_sig : Matrix;
signal mode_sm : std_logic_vector(0 downto 0);

function To_Std_Logic(L: BOOLEAN) return std_ulogic is
begin
  if L then
    return('1');
  else
    return('0');
  end if;
end function To_Std_Logic;

begin
 
	-- output register
	T: process(clock_sig,reset_sig)
	begin
		if(reset_sig='1') then
			done_sig <= '0';
			key_index <= 0;
			state <= '0';
                        err <= '0';
                        mode_sm <= "0";
		elsif(clock_sig'event and clock_sig='1') then
			if(state='0') then
				if(key_index < 11) then
					if(key_index = 0) then
						data_reg_sig <= keyXor_0_out_eff_sig;
					elsif(key_index = 10) then
						temp_data_reg_sig <= keyXor_10_out_sig;
					else
						temp_data_reg_sig <= keyXor_out_eff_sig;
					end if;
				end if;
				if (done_sig='0') then state <= '1'; end if;
                                
                                if(CED = "01") then mode_sm <= "1";
                                elsif(CED = "10") then mode_sm(0) <= To_Std_Logic(key_index = CED_round);
                                else
                                  mode_sm <= "0";
                                end if;
			else
                                if(mode_sm = "1") then
                                  if(key_index = 0) then
                                    err <= To_Std_Logic(data_reg_sig /= inv_keyXor_0_out_eff_sig);
                                  elsif(key_index = 10) then
                                    if(temp_data_reg_sig /= inv_keyXor_10_out_sig) then
                                      err <= '1';
                                    else
                                      data_reg_sig <= temp_data_reg_sig;
                                      done_sig <= '1';
                                    end if;
                                  else
                                    if(temp_data_reg_sig /= inv_keyXor_out_eff_sig) then
                                      err <= '1';
                                    else
                                      data_reg_sig <= temp_data_reg_sig;
                                    end if;
                                  end if;
                                end if;
                                
				if(done_sig='0') then
					key_index <= key_index + 1;
					state <= '0';
				end if;

                                mode_sm <= "0";
			end if;
		end if;
	end process;
	
clock_sig <= clock_sm;
reset_sig <= reset_sm;
done_sm <= done_sig;
mode <= mode_sm;
state_sm <= state;
keyXor_0_out_eff_sig <= keyXor_0_out_eff_sm;
keyXor_out_eff_sig <= keyXor_out_eff_sm;
keyXor_10_out_sig <= keyXor_10_out_sm;
data_reg_sm <= data_reg_sig;
key_index_vector_sig <= std_logic_vector(to_unsigned(key_index, key_index_vector_sig'length));
key_index_vector_sm <= key_index_vector_sig;

inv_keyXor_0_out_eff_sig(0)(0) <= keyXor_0_out_eff_sig(0)(1);
inv_keyXor_0_out_eff_sig(0)(1) <= keyXor_0_out_eff_sig(0)(2);
inv_keyXor_0_out_eff_sig(0)(2) <= keyXor_0_out_eff_sig(0)(3);
inv_keyXor_0_out_eff_sig(0)(3) <= keyXor_0_out_eff_sig(0)(0);
inv_keyXor_0_out_eff_sig(1)(0) <= keyXor_0_out_eff_sig(1)(1);
inv_keyXor_0_out_eff_sig(1)(1) <= keyXor_0_out_eff_sig(1)(2);
inv_keyXor_0_out_eff_sig(1)(2) <= keyXor_0_out_eff_sig(1)(3);
inv_keyXor_0_out_eff_sig(1)(3) <= keyXor_0_out_eff_sig(1)(0);
inv_keyXor_0_out_eff_sig(2)(0) <= keyXor_0_out_eff_sig(2)(1);
inv_keyXor_0_out_eff_sig(2)(1) <= keyXor_0_out_eff_sig(2)(2);
inv_keyXor_0_out_eff_sig(2)(2) <= keyXor_0_out_eff_sig(2)(3);
inv_keyXor_0_out_eff_sig(2)(3) <= keyXor_0_out_eff_sig(2)(0);
inv_keyXor_0_out_eff_sig(3)(0) <= keyXor_0_out_eff_sig(3)(1);
inv_keyXor_0_out_eff_sig(3)(1) <= keyXor_0_out_eff_sig(3)(2);
inv_keyXor_0_out_eff_sig(3)(2) <= keyXor_0_out_eff_sig(3)(3);
inv_keyXor_0_out_eff_sig(3)(3) <= keyXor_0_out_eff_sig(3)(0);
          
inv_keyXor_out_eff_sig(0)(0) <= keyXor_out_eff_sig(0)(1);
inv_keyXor_out_eff_sig(0)(1) <= keyXor_out_eff_sig(0)(2);
inv_keyXor_out_eff_sig(0)(2) <= keyXor_out_eff_sig(0)(3);
inv_keyXor_out_eff_sig(0)(3) <= keyXor_out_eff_sig(0)(0);
inv_keyXor_out_eff_sig(1)(0) <= keyXor_out_eff_sig(1)(1);
inv_keyXor_out_eff_sig(1)(1) <= keyXor_out_eff_sig(1)(2);
inv_keyXor_out_eff_sig(1)(2) <= keyXor_out_eff_sig(1)(3);
inv_keyXor_out_eff_sig(1)(3) <= keyXor_out_eff_sig(1)(0);
inv_keyXor_out_eff_sig(2)(0) <= keyXor_out_eff_sig(2)(1);
inv_keyXor_out_eff_sig(2)(1) <= keyXor_out_eff_sig(2)(2);
inv_keyXor_out_eff_sig(2)(2) <= keyXor_out_eff_sig(2)(3);
inv_keyXor_out_eff_sig(2)(3) <= keyXor_out_eff_sig(2)(0);
inv_keyXor_out_eff_sig(3)(0) <= keyXor_out_eff_sig(3)(1);
inv_keyXor_out_eff_sig(3)(1) <= keyXor_out_eff_sig(3)(2);
inv_keyXor_out_eff_sig(3)(2) <= keyXor_out_eff_sig(3)(3);
inv_keyXor_out_eff_sig(3)(3) <= keyXor_out_eff_sig(3)(0);
          
inv_keyXor_10_out_sig(0)(0) <= keyXor_10_out_sig(0)(1);
inv_keyXor_10_out_sig(0)(1) <= keyXor_10_out_sig(0)(2);
inv_keyXor_10_out_sig(0)(2) <= keyXor_10_out_sig(0)(3);
inv_keyXor_10_out_sig(0)(3) <= keyXor_10_out_sig(0)(0);
inv_keyXor_10_out_sig(1)(0) <= keyXor_10_out_sig(1)(1);
inv_keyXor_10_out_sig(1)(1) <= keyXor_10_out_sig(1)(2);
inv_keyXor_10_out_sig(1)(2) <= keyXor_10_out_sig(1)(3);
inv_keyXor_10_out_sig(1)(3) <= keyXor_10_out_sig(1)(0);
inv_keyXor_10_out_sig(2)(0) <= keyXor_10_out_sig(2)(1);
inv_keyXor_10_out_sig(2)(1) <= keyXor_10_out_sig(2)(2);
inv_keyXor_10_out_sig(2)(2) <= keyXor_10_out_sig(2)(3);
inv_keyXor_10_out_sig(2)(3) <= keyXor_10_out_sig(2)(0);
inv_keyXor_10_out_sig(3)(0) <= keyXor_10_out_sig(3)(1);
inv_keyXor_10_out_sig(3)(1) <= keyXor_10_out_sig(3)(2);
inv_keyXor_10_out_sig(3)(2) <= keyXor_10_out_sig(3)(3);
inv_keyXor_10_out_sig(3)(3) <= keyXor_10_out_sig(3)(0);
end architecture Behavioral;

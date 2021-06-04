-- new_component.vhd

-- This file was auto-generated as a prototype implementation of a module
-- created in component editor.  It ties off all outputs to ground and
-- ignores all inputs.  It needs to be edited to make it do something
-- useful.
-- 
-- This file will not be automatically regenerated.  You should check it in
-- to your version control system if you want to keep it.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity my_dsp_instruction is
	port (
		data_b : in  std_logic_vector(31 downto 0) := (others => '0'); -- nios_custom_instruction_slave.datab
		result : out std_logic_vector(31 downto 0);                    --                              .result
		data_a : in  std_logic_vector(31 downto 0) := (others => '0')  --                              .dataa
	);
end entity my_dsp_instruction;

architecture rtl of my_dsp_instruction is

	signal r0_top : unsigned(15 downto 0);
	signal r0_bot : unsigned(15 downto 0);
	signal r1_top : unsigned(15 downto 0);
	signal r1_bot : unsigned(15 downto 0);
	signal result_unsig : unsigned(31 downto 0);

begin
	r0_top <= unsigned(data_a(31 downto 16));
	r1_top <= unsigned(data_b(31 downto 16));
	r0_bot <= unsigned(data_a(15 downto 0));
	r1_bot <= unsigned(data_b(15 downto 0));

	smuad: process (r0_top)
		begin
		result_unsig <= ((r0_top * r1_top)+(r0_bot * r1_bot));
		end process;
		
	result <= std_logic_vector(result_unsig);

end architecture rtl; -- of my_dsp_instruction

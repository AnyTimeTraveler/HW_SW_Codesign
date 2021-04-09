-- my_dsp_instruction.vhd
-- Example: Nios II and Custom Instruction
-- 	12.04.2013 | C.Koch | initial version
--	13.05.2019 | C.Koch | result squared: smuad2

-- This file was auto-generated as a prototype implementation of a module
-- created in component editor (SOPC Builder/Qsys).  

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity my_dsp_instruction is
	port (
		dataa : in  std_logic_vector(31 downto 0) := (others => '0'); -- nios_custom_instruction_slave.dataa
		datab : in  std_logic_vector(31 downto 0) := (others => '0'); --                              .datab
		result   : out std_logic_vector(31 downto 0)                  --                              .result
	);
end entity my_dsp_instruction;

architecture rtl of my_dsp_instruction is


signal r0_top : unsigned(15 downto 0);
signal r0_bot : unsigned(15 downto 0);
signal r1_top : unsigned(15 downto 0);
signal r1_bot : unsigned(15 downto 0);
signal result_unsig : unsigned(31 downto 0);

begin
	r0_top <= unsigned(dataa(31 downto 16));
	r1_top <= unsigned(datab(31 downto 16));
	r0_bot <= unsigned(dataa(15 downto 0));
	r1_bot <= unsigned(datab(15 downto 0));

	smuad: process (r0_top)
		begin
		result_unsig <= ((r0_top * r1_top)+(r0_bot * r1_bot)) * ((r0_top * r1_top)+(r0_bot * r1_bot));
		end process;
		
	result <= std_logic_vector(result_unsig);

end architecture rtl; -- of my_dsp_instruction

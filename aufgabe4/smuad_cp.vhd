-- avalon_pwm.vhd
-- used in SOPC Training course | http://www.alse-fr.com 
-- --------------------------------------------------------
--   PWM Avalon MM-Slave Module
-- --------------------------------------------------------

Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

Entity smuad_cp is
  port (clk        : in  std_logic;
        reset_n    : in  std_logic;
        chipselect : in  std_logic;
        write_n    : in  std_logic;
        address    : in  std_logic;
        writedata  : in  std_logic_vector (31 downto 0);
        readdata   : out std_logic_vector (31 downto 0)
      );
end smuad_cp;

architecture RTL of smuad_cp is
	
	component my_dsp_instruction is
		port (
			data_b : in  std_logic_vector(31 downto 0) := (others => '0'); -- nios_custom_instruction_slave.datab
			result : out std_logic_vector(31 downto 0);                    --                              .result
			data_a : in  std_logic_vector(31 downto 0) := (others => '0')  --                              .dataa
		);
		end component my_dsp_instruction;

  signal input_a : unsigned (31 downto 0);
  signal input_b : unsigned (31 downto 0);

begin

	my_dsp_instruction_inst : my_dsp_instruction
		PORT MAP(
			data_a => std_logic_vector(input_a),
			data_b => std_logic_vector(input_b),
			result => readdata
		);

-- Avalon register write 
reg_write: process (clk, reset_n)
  begin
    if reset_n = '0' then
      input_a  <= (others => '0');
      input_b  <= (others => '0');
      
    elsif rising_edge(clk) then
    
      if chipselect ='1' and write_n = '0' then
      
        if address = '0' then
          input_a <= unsigned(writedata);
        else
          input_b <= unsigned(writedata);
        end if;
      end if;
    end if;
  end process;

end RTL;




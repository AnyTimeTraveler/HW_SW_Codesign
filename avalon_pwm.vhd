-- avalon_pwm.vhd
-- used in SOPC Training course | http://www.alse-fr.com 
-- --------------------------------------------------------
--   PWM Avalon MM-Slave Module
-- --------------------------------------------------------

Library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.numeric_std.all;

Entity avalon_pwm is
  port (clk        : in  std_logic;
        reset_n    : in  std_logic;
        chipselect : in  std_logic;
        write_n    : in  std_logic;
        address    : in  std_logic_vector (1 downto 0);
        writedata  : in  std_logic_vector (31 downto 0);
        readdata   : out std_logic_vector (31 downto 0);
        out_port_a   : out std_logic;
        out_port_b   : out std_logic
      );
end avalon_pwm;

Architecture RTL of avalon_pwm is

  signal div     : unsigned (31 downto 0);
  signal duty    : unsigned (31 downto 0);
  signal counter : unsigned (31 downto 0);
  signal pwm_on  : std_logic;
  
  signal div_b     : unsigned (31 downto 0);
  signal duty_b    : unsigned (31 downto 0);
  signal counter_b : unsigned (31 downto 0);
  signal pwm_on_b  : std_logic;

Begin

-- Avalon register read 
  readdata <= std_logic_vector(div) when address = "00" else
  	      std_logic_vector(duty) when address = "01" else
  	      std_logic_vector(div_b) when address = "10"else
        	 std_logic_vector(duty_b);

-- Avalon register write 
reg_write: process (clk, reset_n)
  begin
    if reset_n = '0' then
      div  <= (others => '0');
      duty <= (others => '0');
      
      div_b  <= (others => '0');
      duty_b <= (others => '0');
      
    elsif rising_edge(clk) then
    
      if chipselect ='1' and write_n = '0' then
      
        if address = "00" then
          div  <= unsigned(writedata);
        elsif  address = "01" then
          duty <= unsigned(writedata);
        elsif address = "10" then
          div_b <= unsigned(writedata);
        else 
        duty_b <= unsigned(writedata); 
        end if;
      end if;
    end if;
  end process;

-- PWM generator
pwm_gen: process (clk, reset_n)
  begin
    if reset_n = '0' then
      counter <= (others => '0');
      pwm_on <= '0';
    elsif rising_edge(clk) then
      counter <= counter - 1; -- by default;
      if counter = 0 then
        counter <= div;
        pwm_on <= '0';
      elsif counter <= duty then
        pwm_on <= '1';
      end if;
    end if;
  end process;
 
 pwm_gen_b: process (clk, reset_n)
  begin
    if reset_n = '0' then
      counter_b <= (others => '0');
      pwm_on_b <= '0';
    elsif rising_edge(clk) then
      counter_b <= counter_b - 1; -- by default;
      if counter_b = 0 then
        counter_b <= div_b;
        pwm_on_b <= '0';
      elsif counter_b <= duty_b then
        pwm_on_b <= '1';
      end if;
    end if;
  end process;


-- set output
out_port_a <= pwm_on;
out_port_b <= pwm_on_b;


end RTL;




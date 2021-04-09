--Quelldatei

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity Radsensor is
  port (
			clk          : in  std_logic;  -- 50MHz Takt
        
	-----------------------------------------------------------------------

        chipselect : in  std_logic;
        write_n    : in  std_logic;
		  reset_n    : in  std_logic;
        address    : in  std_logic_vector (1 downto 0);
        irq  	   : out  std_logic;
        writedata  : in  std_logic_vector (31 downto 0);
        readdata   : out std_logic_vector (31 downto 0);


	-----------------------------------------------------------------------

		  sensor1 : in  std_logic;  -- Radsensor hinten links, erstes Signal
        sensor2 : in  std_logic  -- Radsensor hinten links, erstes Signal
	);
end Radsensor;

architecture VERHALTEN of Radsensor is
  type   Zustaende is (IDLE, Z1, Z2, Z3);
 
  signal STATE         : Zustaende;
  signal Richtung      : std_logic_vector(1 downto 0);
  signal S_SEN_DATA    : std_logic_vector(1 downto 0)  ;
  signal S_SEN_DATA_puffer    : std_logic_vector(1 downto 0)  ;
  signal S_SIGN1_OK    : std_logic_vector(3 downto 0)  ;
  signal S_SIGN2_OK    : std_logic_vector(3 downto 0)  ;
  signal counter_clock : integer range 0 to 4000;
  signal clock2500  : std_logic;
  signal irq_s  : std_logic;
  signal irq_repeat  : std_logic;
  signal irq_enable  : std_logic		    := '0';
  signal sig_reset_n     : std_logic    := '0';
  signal Tics	     : std_logic_vector (31 downto 0);
  signal irq_counter : std_logic_vector (31 downto 0);
  signal mode	     : std_logic_vector(7 downto 0) := (others => '0');

  signal wrapper_Richtung : std_logic_vector (31 downto 0) := (others => '0');
  signal wrapper_mode	  : std_logic_vector (31 downto 0) := (others => '0');





begin

-------------------------------------------------------------------------------
--Erzeugung einer Abtastfrequenz von 14285 Herz
-------------------------------------------------------------------------------
  clock_neu : process (clk, sig_reset_n) is
  begin	 -- process clock_neu
    if sig_reset_n = '0' then		-- asynchronous reset (active low)
      counter_clock <= 0;
      clock2500	    <= '0';

    elsif clk'event and clk = '1' then	-- rising clock edge
      counter_clock <= counter_clock + 1;
      if (counter_clock = 3500) then
	counter_clock <= 0;
	clock2500     <= not clock2500;
      end if;


    end if;
  end process clock_neu;
-------------------------------------------------------------------------------
-- Abtastung der Sensorsignalen

-- Das Signal muss vier Mal den gleichen Zustand liefern, um als stabil detektiert
-- zu werden
-------------------------------------------------------------------------------


  Abtastung : process (clock2500, sig_reset_n) is
  begin	 -- process Abtastung
    if sig_reset_n = '0' then		-- asynchronous reset (active low)
      S_SIGN2_OK <= "0000";
      S_SIGN1_OK <= "0000";
    elsif clock2500'event and clock2500 = '1' then  -- rising clock edge

      if (S_SIGN1_OK = "0000") then
	S_SEN_DATA(0) <= '0';
      end if;
      if (S_SIGN1_OK = "1111") then
	S_SEN_DATA(0) <= '1';
      end if;

      if (S_SIGN2_OK = "0000") then
	S_SEN_DATA(1) <= '0';
      end if;
      if (S_SIGN2_OK = "1111") then
	S_SEN_DATA(1) <= '1';
      end if;

      S_SIGN2_OK <= S_SIGN2_OK(2 downto 0) & sensor1;
      S_SIGN1_OK <= S_SIGN1_OK(2 downto 0) & sensor2;

    end if;
  end process Abtastung;

-------------------------------------------------------------------------------
-- 
-------------------------------------------------------------------------------	 

  -- purpose: <[description]>
  Ablaufkette : process (clk, sig_reset_n) is
  begin	 -- process Ablaufkette
    if sig_reset_n = '0' then		-- asynchronous reset (active low)
      STATE    <= IDLE;
      Richtung <= "00";
      Tics     <= (others => '0');
    elsif clk'event and clk = '1' then
      case STATE is

	when IDLE =>
	  if(S_SEN_DATA = "00") then
	    Tics  <= Tics + 1;
		if irq_repeat = '1' and irq_s = '1'  then Tics<=(others => '0'); end if;
	    STATE <= Z1;
	  else
	    STATE <= IDLE;
	  end if;

	when Z1 =>

	  if(S_SEN_DATA = "01") then
	    Tics     <= Tics + 1;
		if irq_repeat = '1' and irq_s = '1'  then Tics<=(others => '0'); end if;
	    STATE    <= Z2;
	    Richtung <= "10";
	  elsif(S_SEN_DATA = "10") then
	    Tics     <= Tics + 1;
		if irq_repeat = '1' and irq_s = '1'  then Tics<=(others => '0'); end if;
	    STATE    <= Z2;
	    Richtung <= "01";
	  else
	    STATE <= Z1;
	  end if;

	when Z2 =>

	  if(S_SEN_DATA = "11") then
	    Tics  <= Tics + 1;
		if irq_repeat = '1' and irq_s = '1'  then Tics<=(others => '0'); end if;
	    STATE <= Z3;
	  else
	    STATE <= Z2;
	  end if;

	when Z3 =>
	  if(S_SEN_DATA = "01") then
	    Tics  <= Tics + 1;
		if irq_repeat = '1' and irq_s = '1'  then Tics<=(others => '0'); end if;
	    STATE <= IDLE;
	  elsif(S_SEN_DATA = "10") then
	    Tics  <= Tics + 1;
		if irq_repeat = '1' and irq_s = '1'  then Tics<=(others => '0'); end if;
	    STATE <= IDLE;
	  else
	    STATE <= Z3;
	  end if;

      end case;

      
    
    end if;

  end process Ablaufkette;
--------------------------------------------------------------------------

  wrapper_mode(7 downto 0)	<= mode;
  wrapper_Richtung (1 downto 0) <= Richtung;
  sig_reset_n			<= mode(0) and reset_n;
  irq_enable			<= mode(1);
  irq_repeat			<= mode(2);


  irq_s <= '1' when irq_counter = Tics and irq_enable = '1'else
	   '0' when irq_enable = '0'else
	   '0' when irq_enable = '1' and irq_repeat ='1' and irq_s = '1'and Tics = (Tics'range =>'0');
	   
  irq <= irq_s;

  mode <= writedata(7 downto 0) when
	  chipselect = '1' and write_n = '0' and address = "00" else
	  "00001011" when irq_s = '1';

  irq_counter <= writedata when
		 chipselect = '1' and write_n = '0' and address = "01";
		

 

 readdata <= Tics when
	     chipselect = '1' and write_n = '1' and address = "00" else
	     wrapper_Richtung when
	     chipselect = '1' and write_n = '1' and address = "01" else
	     irq_counter when
	     chipselect = '1' and write_n = '1' and address = "10" else
	     wrapper_mode  when
	    chipselect = '1' and write_n = '1' and address = "11"; 
end architecture VERHALTEN;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:02:27 05/01/2021 
-- Design Name: 
-- Module Name:    REG_PIPELINE - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity REG_PIPELINE is
    Port (
           Din1 : in STD_LOGIC_VECTOR (31 downto 0);
			  Din2 : in STD_LOGIC_VECTOR (31 downto 0);
			  Din3 : in STD_LOGIC_VECTOR (31 downto 0);
			  Din4 : in STD_LOGIC_VECTOR (31 downto 0);
			  Din5 : in STD_LOGIC_VECTOR (4 downto 0);
           Dout1 : out STD_LOGIC_VECTOR (31 downto 0);
			  Dout2 : out STD_LOGIC_VECTOR (31 downto 0);
			  Dout3 : out STD_LOGIC_VECTOR (31 downto 0);
			  Dout4 : out STD_LOGIC_VECTOR (31 downto 0);
			  Dout5 : out STD_LOGIC_VECTOR (4 downto 0);
			  CLK : in STD_LOGIC;
           WrEn : in STD_LOGIC;
           RST : in STD_LOGIC);
end REG_PIPELINE;


architecture Behavioral of REG_PIPELINE is

signal temp_out1: std_logic_vector(31 downto 0);
signal temp_out2: std_logic_vector(31 downto 0);
signal temp_out3: std_logic_vector(31 downto 0);
signal temp_out4: std_logic_vector(31 downto 0);
signal temp_out5: std_logic_vector(4 downto 0);

begin
process(CLK,WrEn,RST)
begin
	if RST='1' then
		temp_out1<=x"00000000"; 
	   temp_out2<=x"00000000"; 
		temp_out3<=x"00000000"; 
		temp_out4<=x"00000000"; 
		temp_out5<="00000"; 
		 
	else
	   if (WrEn='1' and rising_edge(CLK)) then
	       temp_out1<=Din1;
			 temp_out2<=Din2;
			 temp_out3<=Din3;
			 temp_out4<=Din4;
			 temp_out5<=Din5;
	   else
	       temp_out1<=temp_out1;
			 temp_out2<=temp_out2;
			 temp_out3<=temp_out3;
			 temp_out4<=temp_out4;
			 temp_out5<=temp_out5;
	   end if;
    end if;
end process;

Dout1<=temp_out1 after 10 ns;
Dout2<=temp_out2 after 10 ns;
Dout3<=temp_out3 after 10 ns;
Dout4<=temp_out4 after 10 ns;
Dout5<=temp_out5 after 10 ns;

end Behavioral;


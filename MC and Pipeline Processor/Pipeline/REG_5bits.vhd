----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:17:30 05/01/2021 
-- Design Name: 
-- Module Name:    REG_5bits - Behavioral 
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

entity REG_5bits is
Port ( CLK : in STD_LOGIC;
           WrEn : in STD_LOGIC;
           RST : in STD_LOGIC;
           Datain : in STD_LOGIC_VECTOR(4 downto 0);
           Dataout : out STD_LOGIC_VECTOR(4 downto 0));
end REG_5bits;

architecture Behavioral of REG_5bits is

signal temp_out: std_logic_vector(4 downto 0);

begin
process(CLK,WrEn,RST)
begin
	if RST='1' then
	   temp_out<="00000"; 		 
	else		
	   if (WrEn='1' and rising_edge(CLK))then
	       temp_out<=Datain;
	   else
	       temp_out<=temp_out;
	   end if;
    end if;
end process;

Dataout<=temp_out;

end Behavioral;


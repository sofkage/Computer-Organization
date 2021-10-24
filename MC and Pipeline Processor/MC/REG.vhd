----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:31:08 04/11/2021 
-- Design Name: 
-- Module Name:    REG - Behavioral 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity REG is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           WrEn : in STD_LOGIC;
           Datain : in STD_LOGIC_VECTOR (31 downto 0);
           Dataout : out STD_LOGIC_VECTOR (31 downto 0));
end REG;

architecture Behavioral of REG is

signal temp_reg_out : std_logic_vector(31 downto 0);
begin
process
begin 
	wait until CLK'EVENT AND CLK='1';
	if RST='0' then
	   if WrEn='1' then
	       temp_reg_out <= Datain;
	   else    
	       temp_reg_out <= temp_reg_out;
	   end if;

	else
	   temp_reg_out <= x"00000000";
 
    end if;
end process;

Dataout <= temp_reg_out after 10 ns;


end Behavioral;




----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:44:37 05/02/2021 
-- Design Name: 
-- Module Name:    INSTR_CONTROLLER - Behavioral 
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

entity INSTR_CONTROLLER is
     Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           enable : out  STD_LOGIC); --syndeetai sth or
end INSTR_CONTROLLER;

architecture Behavioral of INSTR_CONTROLLER is

signal temp_enable:std_logic;

begin
process(Instr)
begin
	if Instr=x"00000000" then --edw h OR dinei 1 sto control MUX aneksairetws toy hdu
		temp_enable<='1';
	else 
		temp_enable<='0';
	end if;
end process;

enable <= temp_enable;

end Behavioral;


----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:31:37 04/11/2021 
-- Design Name: 
-- Module Name:    DEC - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DEC is
    Port ( Awr : in STD_LOGIC_VECTOR (4 downto 0);
           Dataout : out STD_LOGIC_VECTOR (31 downto 0));
end DEC;

architecture Behavioral of DEC is 
signal temp_dec_out: std_logic_vector(31 downto 0);
    
begin
decode:
	for i in 0 to 31 generate 
		temp_dec_out(i) <= '1' when to_integer(unsigned(Awr)) = i else '0';			
	end generate;

Dataout <= temp_dec_out after 10 ns;

end Behavioral;


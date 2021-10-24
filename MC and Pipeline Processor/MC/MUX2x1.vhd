----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:32:33 04/11/2021 
-- Design Name: 
-- Module Name:    MUX2x1 - Behavioral 
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

entity MUX2x1 is
    Port ( Din0 : in STD_LOGIC_VECTOR (31 downto 0);
           Din1 : in STD_LOGIC_VECTOR (31 downto 0);
           sel : in STD_LOGIC;
           Dout : out STD_LOGIC_VECTOR (31 downto 0));
end MUX2x1;

architecture Behavioral of MUX2x1 is
signal temp_Dout: std_logic_vector(31 downto 0);

begin
process(sel,Din0, Din1,temp_Dout)
begin

    if(sel='0') then 
         temp_Dout <= Din0;
     else
         temp_Dout <= Din1;
     end if;
end process;

Dout <= temp_Dout;

end Behavioral;


----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:30:29 04/11/2021 
-- Design Name: 
-- Module Name:    MUXsmall - Behavioral 
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

entity MUXsmall is
    Port ( Din0_small : in STD_LOGIC_VECTOR (4 downto 0);
           Din1_small : in STD_LOGIC_VECTOR (4 downto 0);
           sel_small : in STD_LOGIC;
           Dout_small : out STD_LOGIC_VECTOR (4 downto 0));
end MUXsmall;

architecture Behavioral of MUXsmall is
signal temp_Dout: std_logic_vector(4 downto 0);

begin
process(sel_small,Din0_small, Din1_small,temp_Dout)
begin

    if(sel_small='0') then 
         temp_Dout <= Din0_small;
     else
         temp_Dout <= Din1_small;
     end if;
end process;

Dout_small <= temp_Dout;

end Behavioral;



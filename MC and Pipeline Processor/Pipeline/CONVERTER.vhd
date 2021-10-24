----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:35:09 04/11/2021 
-- Design Name: 
-- Module Name:    CONVERTER - Behavioral 
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

entity CONVERTER is
    Port ( ImmExt : in  STD_LOGIC_VECTOR (1 downto 0);
           DataIn : in  STD_LOGIC_VECTOR (15 downto 0);  -- immediate entolis -> Instr LSB
           Immed : out  STD_LOGIC_VECTOR (31 downto 0));
end CONVERTER;

architecture Behavioral of CONVERTER is

 signal temp_Immed :  STD_LOGIC_VECTOR (31 downto 0);

begin
process(ImmExt, DataIn, temp_Immed)
begin

    if ImmExt = "00" then  --zero fill 
        temp_Immed(31 downto 16) <= x"0000";
        temp_Immed(15 downto 0)  <= DataIn(15 downto 0);
    
    elsif ImmExt = "01" then  -- sign extend 
         for i in 16 to 31 loop
		      temp_Immed(i)<=DataIn(15);
	     end loop;
	     
         temp_Immed(15 downto 0) <= DataIn(15 downto 0);

    elsif ImmExt = "10" then 
          for i in 16 to 31 loop
		      temp_Immed(i) <= DataIn(15);
	      end loop;
	      
          temp_Immed(17 downto 2) <= DataIn(15 downto 0);
          temp_Immed(1 downto 0)  <= "00";    
        
    elsif ImmExt = "11" then   
          temp_Immed(31 downto 16) <= DataIn(15 downto 0);
	      temp_Immed(15 downto 0)  <= x"0000";
    
    end if;

end process;

    Immed <= temp_Immed;  --apo edw sto pc_immed
    
end Behavioral;




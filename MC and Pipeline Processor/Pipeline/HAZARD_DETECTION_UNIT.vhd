----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:37:47 05/02/2021 
-- Design Name: 
-- Module Name:    HAZARD_DETECTION_UNIT - Behavioral 
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

entity HAZARD_DETECTION_UNIT is
    Port ( rs : in  STD_LOGIC_VECTOR (4 downto 0);
           rd_rt : in  STD_LOGIC_VECTOR (4 downto 0);
           rd_idex : in  STD_LOGIC_VECTOR (4 downto 0);
           memread : in  STD_LOGIC;
           control_sel : out  STD_LOGIC;
           PC_LdEn_hdu : out  STD_LOGIC;
           we_ifid_hdu : out  STD_LOGIC);
end HAZARD_DETECTION_UNIT;

architecture Behavioral of HAZARD_DETECTION_UNIT is

begin
process (rs,rd_rt,rd_idex,memread)
begin
	if (memread='1' and (rs=rd_idex or rd_rt=rd_idex)) then
		
		control_sel<='1'; --zero control signals
		PC_LdEn_hdu<='0';
		
		we_ifid_hdu<='0';
	else	
		
		control_sel<='0'; --correct control signals
		PC_LdEn_hdu<='1';
		we_ifid_hdu<='1';
		
	end if;
end process; 


end Behavioral;


----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:38:51 05/02/2021 
-- Design Name: 
-- Module Name:    FORWARD_UNIT - Behavioral 
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

--rs kai rdrt eksodoi idex

entity FORWARD_UNIT is
    Port ( rs : in  STD_LOGIC_VECTOR (4 downto 0);
           rd_rt : in  STD_LOGIC_VECTOR (4 downto 0); --out of mux rd_rt_hdu pou elegxetai apo to rfbsel
           
			  --eisodoi rd apo vathmides ex/mem kai mem/wb
			  rd_2 : in  STD_LOGIC_VECTOR (4 downto 0);
           rd_3 : in  STD_LOGIC_VECTOR (4 downto 0);
			  
			  --eisodoi rf einai eksodoi apo kataxwrhth rf_we 
			  RFwe2:in std_logic;
			  RFwe3:in std_logic;
			  
           forwardA : out  STD_LOGIC_VECTOR (1 downto 0); -- for exstage mux
           forwardB : out  STD_LOGIC_VECTOR (1 downto 0) -- for exstage mux
			  );
end FORWARD_UNIT;

architecture Behavioral of FORWARD_UNIT is

signal temp_forwardA: std_logic_vector(1 downto 0);
signal temp_forwardB : std_logic_vector(1 downto 0);

begin

process(rs,rd_rt,rd_2,rd_3,RFwe2,RFwe3)
begin
--forwardA
	if(RFwe2='1' and rd_2/="00000" and rd_2=rs) --EX hazard
		then temp_forwardA<="00"; --alu_out, comes from the register file. 
	elsif(RFwe3='1' and rd_3/="00000" and rd_3=rs) 
		then temp_forwardA<="01"; --MEM hazard, comes from data memory or an early ALU result
	else temp_forwardA<="10";  --EX hazard, comes from the prior ALU result. 
	end if;
	
--forwardB

	if(RFwe2='1' and rd_2/="00000" and rd_2=rd_rt) 
		then temp_forwardB<="00"; --alu_out, comes from the register file. 
	elsif(RFwe3='1' and rd_3/="00000"and rd_3=rd_rt) 
		then temp_forwardB<="01"; --MEM hazard, comes from data memory or an early ALU result
	else temp_forwardB<="10"; --EX hazard,  comes from the prior ALU result. 
	end if;

end process;

forwardA <= temp_forwardA;
forwardB <= temp_forwardB;

end Behavioral;

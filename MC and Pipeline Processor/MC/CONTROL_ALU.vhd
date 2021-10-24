----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:42:17 04/11/2021 
-- Design Name: 
-- Module Name:    CONTROL_ALU - Behavioral 
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

entity CONTROL_ALU is
    Port ( func : in  STD_LOGIC_VECTOR (5 downto 0);
           ALU_op : in  STD_LOGIC_VECTOR (3 downto 0); --eksodos tou control if, 5 ypoperiptwseis
           ALU_func : out  STD_LOGIC_VECTOR (3 downto 0));
end CONTROL_ALU;

architecture Behavioral of CONTROL_ALU is

	signal temp :std_logic_vector(3 downto 0);
	
	begin
	process(func,ALU_op)
		begin 
			temp(3)<=ALU_op(3) and func(3);
			temp(2)<=((not ALU_op(3)) and ALU_op(2)) or (ALU_op(3) and func(2));
			temp(1)<=((not ALU_op(3)) and (not ALU_op(2)) and ALU_op(1)) or (ALU_op(3) and func(1));
			temp(0)<=((not ALU_op(3)) and ALU_op(0))  or (ALU_op(3) and func(0));
	end process;
	
	ALU_func<=temp;


end Behavioral;


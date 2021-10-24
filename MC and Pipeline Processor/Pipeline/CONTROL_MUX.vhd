----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:35:45 05/02/2021 
-- Design Name: 
-- Module Name:    CONTROL_MUX - Behavioral 
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

entity ControlMUX is
Port ( sel : in  STD_LOGIC;
           RFwe1 : in  STD_LOGIC;
           RFwds1 : in  STD_LOGIC;
			  MemWrEn1 : in  STD_LOGIC;
			  ByteOp1 : in  STD_LOGIC;
           ALUfunc : in  STD_LOGIC_VECTOR (3 downto 0);
			  ALU_Bin_sel : in  STD_LOGIC;
			  MemRead : in  STD_LOGIC;
			  
			  RFwe1_out : out  STD_LOGIC;
           RFwds1_out : out  STD_LOGIC;
			  MemWrEn1_out : out  STD_LOGIC;
			  ByteOp1_out : out  STD_LOGIC;
           ALUfunc_out : out  STD_LOGIC_VECTOR (3 downto 0);
			  ALU_Bin_sel_out : out  STD_LOGIC;
			  MemRead_out : out  STD_LOGIC);
end ControlMUX;

architecture Behavioral of ControlMUX is

signal temp_RFwe1 : std_logic;
signal temp_RFwds1 : std_logic;
signal temp_MemWrEn1 : std_logic;
signal temp_ByteOp1 : std_logic;
signal temp_ALUfunc : std_logic_vector(3 downto 0);
signal temp_ALU_Bin_sel : std_logic;
signal temp_MemRead : std_logic;

begin
process(sel,RFwe1,RFwds1,MemWrEn1,ByteOp1,ALUfunc,ALU_Bin_sel,MemRead)
begin
	if(sel = '0') then
	
	--pernane ta shmata tou control pou aforoun thn entoli pou kanoyme decode. 
		temp_RFwe1			<= RFwe1;
	   temp_RFwds1 		<= RFwds1 ;
	   temp_MemWrEn1		<= MemWrEn1 ; 
	   temp_ByteOp1		<= ByteOp1;
	   temp_ALUfunc 	   <= ALUfunc;
		temp_ALU_Bin_sel  <= ALU_Bin_sel;
		temp_MemRead 		<= MemRead ;
	else
	
	--otan to koino shma elegxou einai 1 tote sthn prwth vathmida kataxwrhtwn 
	--elegxou ola ta shmata pairnoun 0 times
	--stall ston kyklo pou eimai tha dwsw mhdenika ara kanena apo ayta den tha ginei enable
		temp_RFwe1		<='0';
	   temp_RFwds1 	<='0';
	   temp_MemWrEn1	<='0' ; 
	   temp_ByteOp1	<='0';
	   temp_ALUfunc 	<="0000";
		temp_ALU_Bin_sel <='0';
		temp_MemRead 	<='0';
		
	end if;
end process;

RFwe1_out 		 <= temp_RFwe1;
RFwds1_out 		 <= temp_RFwds1;
MemWrEn1_out 	 <= temp_MemWrEn1; 
ByteOp1_out		 <= temp_ByteOp1;
ALUfunc_out 	 <= temp_ALUfunc ;
ALU_Bin_sel_out <= temp_ALU_Bin_sel;
MemRead_out 	 <= temp_MemRead ;

end Behavioral;


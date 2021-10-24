----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:21:13 04/30/2021 
-- Design Name: 
-- Module Name:    MUX_4x1 - Behavioral 
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

entity MUX_4x1 is
    Port ( sel : in  STD_LOGIC_VECTOR(1 downto 0);
			  Datain0 : in  STD_LOGIC_VECTOR (31 downto 0);
           Datain1 : in  STD_LOGIC_VECTOR (31 downto 0);
			  Datain2 : in  STD_LOGIC_VECTOR (31 downto 0);
           Datain3 : in  STD_LOGIC_VECTOR (31 downto 0);
           Dataout : out  STD_LOGIC_VECTOR (31 downto 0));
end MUX_4x1;

architecture Behavioral of MUX_4x1 is

signal temp_out: std_logic_vector(31 downto 0);

begin

process(sel,Datain0, Datain1,Datain2,Datain3,temp_out)
begin
	if(sel = "00") then 
	    temp_out <= Datain0;
	elsif(sel = "01") then 
	    temp_out <= Datain1;
	elsif(sel = "10") then 
	    temp_out <= Datain2;
	else
	    temp_out <= Datain3;
	end if;
	
end process; 

Dataout <= temp_out;
end Behavioral;


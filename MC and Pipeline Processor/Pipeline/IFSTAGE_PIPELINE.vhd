----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:16:19 05/01/2021 
-- Design Name: 
-- Module Name:    IFSTAGE_PIPELINE - Behavioral 
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

entity IFSTAGE_PIPELINE is
Port ( PC_4_Immediate : in  STD_LOGIC_VECTOR (31 downto 0);
        PC_4 : out  STD_LOGIC_VECTOR (31 downto 0);
           PC_LdEn : in  STD_LOGIC;
			  PC_Sel : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           PC : out  STD_LOGIC_VECTOR (31 downto 0));
end IFSTAGE_PIPELINE;

architecture Behavioral of IFSTAGE_PIPELINE is

component MUX2x1 is
    Port ( Din0 : in STD_LOGIC_VECTOR (31 downto 0);
           Din1 : in STD_LOGIC_VECTOR (31 downto 0);
           sel : in STD_LOGIC;
           Dout : out STD_LOGIC_VECTOR(31 downto 0));
end component;

component REG is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           WrEn : in STD_LOGIC;
           Datain : in STD_LOGIC_VECTOR (31 downto 0);
           Dataout : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component adder_incre is
    Port ( Din : in STD_LOGIC_VECTOR (31 downto 0);
           Dout : out STD_LOGIC_VECTOR (31 downto 0));
end component;

signal temp_PC_in : std_logic_vector(31 downto 0);
signal temp_PC_out : std_logic_vector(31 downto 0);
signal temp_add : std_logic_vector(31 downto 0);

begin
PC_register: 
            REG port map (WrEn=>PC_LdEn,
										RST=>Rst,
										Datain=>temp_PC_in,
										Dataout=>temp_PC_out,
										CLK=>Clk);
            
PC<=temp_PC_out;
PC_4<=temp_add;

adder_4:    
        adder_incre port map (Din=>temp_PC_out,
									Dout=>temp_add);

mux:
        MUX2x1 port map(sel=>PC_Sel,
								Din0=>temp_add,
								Din1=>PC_4_Immediate,
								Dout=>temp_PC_in);


end Behavioral;


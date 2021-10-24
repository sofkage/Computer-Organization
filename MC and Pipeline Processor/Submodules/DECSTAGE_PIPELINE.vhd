----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:16:50 05/01/2021 
-- Design Name: 
-- Module Name:    DECSTAGE_PIPELINE - Behavioral 
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

entity DECSTAGE_PIPELINE is
    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrEn : in  STD_LOGIC;
			  write_reg:in  STD_LOGIC_VECTOR (4 downto 0);

           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           ImmExt : in  STD_LOGIC_VECTOR (1 downto 0);
           Clk : in  STD_LOGIC;
			  Rst : in STD_LOGIC;
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0);
			  rd_rt: out  STD_LOGIC_VECTOR (4 downto 0);
			  AM_out: out  STD_LOGIC_VECTOR (31 downto 0));
end DECSTAGE_PIPELINE;

architecture Behavioral of DECSTAGE_PIPELINE is


component MUX2x1 is
	 Port ( Din0 : in STD_LOGIC_VECTOR (31 downto 0);
           Din1 : in STD_LOGIC_VECTOR (31 downto 0);
           sel : in STD_LOGIC;
           Dout : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component MUXsmall is
Port (  Din0_small : in STD_LOGIC_VECTOR (4 downto 0);
           Din1_small : in STD_LOGIC_VECTOR (4 downto 0);
           sel_small : in STD_LOGIC;
           Dout_small : out STD_LOGIC_VECTOR (4 downto 0));
end component;

component RF is
	 Port ( Ard1 : in STD_LOGIC_VECTOR (4 downto 0);
           Ard2 : in STD_LOGIC_VECTOR (4 downto 0);
           Awr : in STD_LOGIC_VECTOR (4 downto 0);
           Dout1 : out STD_LOGIC_VECTOR (31 downto 0);
           Dout2 : out STD_LOGIC_VECTOR (31 downto 0);
           Din : in STD_LOGIC_VECTOR (31 downto 0);
           WrEn : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Rst : in STD_LOGIC);
end component;

component CONVERTER is 
	 Port ( ImmExt : in  STD_LOGIC_VECTOR (1 downto 0);
           DataIn : in  STD_LOGIC_VECTOR (15 downto 0);
           Immed : out  STD_LOGIC_VECTOR (31 downto 0));
end component;


signal temp_1 : std_logic_vector(4 downto 0);
signal temp_2 : std_logic_vector(31 downto 0);

begin

msmall:
	MUXsmall port map(sel_small=>RF_B_sel, 
						Din0_small=>Instr(15 downto 11), 
						Din1_small=>Instr(20 downto 16),
						Dout_small=>temp_1);
						
rd_rt<=temp_1;

mbig: 
	MUX2x1 port map(sel=>RF_WrData_sel,
					Din1=> MEM_out, 
					Din0=>ALU_out,
					Dout=>temp_2);
exten:
	CONVERTER port map(ImmExt=>ImmExt,
					DataIn=>Instr(15 downto 0),
					Immed=>Immed);
regf:
	RF port map( Clk=>Clk,
							Ard1=>Instr(25 downto 21),
							Ard2=>temp_1,
							Awr=>write_reg, -- instr before
							Dout1=>RF_A,
							Dout2=>RF_B,
							Din=>temp_2,
							WrEn=>RF_WrEn,
							Rst=>Rst);

AM_out<=temp_2;

end Behavioral;


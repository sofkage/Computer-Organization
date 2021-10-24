----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:17:03 05/01/2021 
-- Design Name: 
-- Module Name:    EXSTAGE_PIPELINE - Behavioral 
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

entity EXSTAGE_PIPELINE is
    Port ( --RF_A : in STD_LOGIC_VECTOR (31 downto 0);
           --RF_B : in STD_LOGIC_VECTOR (31 downto 0);
			  In_A : in  STD_LOGIC_VECTOR (31 downto 0);
           In_B : in  STD_LOGIC_VECTOR (31 downto 0);
			  In_C : in  STD_LOGIC_VECTOR (31 downto 0);
			  In_D : in  STD_LOGIC_VECTOR (31 downto 0);
			  srcA : in  STD_LOGIC_VECTOR(1 downto 0);
			  srcB: in  STD_LOGIC_VECTOR(1 downto 0);
			  
           Immed : in STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in STD_LOGIC;
           ALU_func : in STD_LOGIC_VECTOR (3 downto 0); --ti praksh tha kanei h ALU
           ALU_out : out STD_LOGIC_VECTOR (31 downto 0);
           ALU_zero : out STD_LOGIC;
			  In_B_out: out  STD_LOGIC_VECTOR (31 downto 0));

end EXSTAGE_PIPELINE;

architecture Behavioral of EXSTAGE_PIPELINE is

component ALU is
    Port ( A : in STD_LOGIC_VECTOR (31 downto 0);
           B : in STD_LOGIC_VECTOR (31 downto 0);
           Op : in STD_LOGIC_VECTOR (3 downto 0);
           Output : out STD_LOGIC_VECTOR (31 downto 0);
           Zero : out STD_LOGIC;
           Cout : out STD_LOGIC;
           Ovf : out STD_LOGIC);
end component;

component MUX2x1 is
    Port ( Din0 : in STD_LOGIC_VECTOR (31 downto 0);
           Din1 : in STD_LOGIC_VECTOR (31 downto 0);
           sel : in STD_LOGIC;
           Dout : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component MUX_4x1 is
    Port ( sel : in  STD_LOGIC_VECTOR(1 downto 0);
			  Datain0 : in  STD_LOGIC_VECTOR (31 downto 0);
           Datain1 : in  STD_LOGIC_VECTOR (31 downto 0);
			  Datain2 : in  STD_LOGIC_VECTOR (31 downto 0);
           Datain3 : in  STD_LOGIC_VECTOR (31 downto 0);
           Dataout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;


signal temp_mux_out_a : STD_LOGIC_VECTOR(31 downto 0);
signal temp_mux_out_b : STD_LOGIC_VECTOR(31 downto 0);
signal temp_mux_out_c : STD_LOGIC_VECTOR(31 downto 0);

begin
muxa_41:
	MUX_4x1 port map(sel=>srcA,
							datain0=>In_C, 
							datain1=>In_D, 
							datain2=>In_A,
							datain3=>x"00000000", 
							dataout=> temp_mux_out_a);
muxb_41:
	MUX_4x1 port map(sel=>srcB,
						datain0=>In_C, 
						datain1=>In_D, 
						datain2=>In_B,
						datain3=>x"00000000",
						dataout=>temp_mux_out_b);
	
	In_B_out <= temp_mux_out_b;
	
muxc_21:
	MUX2x1 port map(sel=>ALU_Bin_sel,
							Din0=>temp_mux_out_b, 
							Din1=>Immed,
							Dout=>temp_mux_out_c);
alu_comp:
    ALU port map(A=>temp_mux_out_a, 
						B=>temp_mux_out_c,
						Op=>ALU_func,
						Output=>ALU_out,
						Zero=>ALU_zero,
						Cout=>open,
						Ovf=>open);


end Behavioral;


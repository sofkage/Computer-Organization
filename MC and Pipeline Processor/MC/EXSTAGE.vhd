----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:35:58 04/11/2021 
-- Design Name: 
-- Module Name:    EXSTAGE - Behavioral 
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

-- in_a in_b kainouria, pleon dden proerxontai mono apo ton rf 
--prosthesa mux se kathe eksodo ths alu

entity EXSTAGE is
    Port ( --RF_A : in STD_LOGIC_VECTOR (31 downto 0);
           --RF_B : in STD_LOGIC_VECTOR (31 downto 0);
			  In_A : in  STD_LOGIC_VECTOR (31 downto 0);
           In_B : in  STD_LOGIC_VECTOR (31 downto 0);
			  PC_out : in  STD_LOGIC_VECTOR (31 downto 0);
			  srcA : in  STD_LOGIC;
			  srcB: in  STD_LOGIC_VECTOR(1 downto 0);
			  
           Immed : in STD_LOGIC_VECTOR (31 downto 0);
           --ALU_Bin_sel : in STD_LOGIC;
           ALU_func : in STD_LOGIC_VECTOR (3 downto 0); --ti praksh tha kanei h ALU
           ALU_out : out STD_LOGIC_VECTOR (31 downto 0);
           ALU_zero : out STD_LOGIC);
end EXSTAGE;

architecture Behavioral of EXSTAGE is

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

signal temp_mux_out_A : STD_LOGIC_VECTOR(31 downto 0);
signal temp_mux_out_B : STD_LOGIC_VECTOR(31 downto 0);

begin
 
 alu_comp: 
  ALU Port map ( A   => temp_mux_out_A , 
                 B   => temp_mux_out_B,
                 Op  => ALU_func,
                 Output => ALU_out,
                 Zero => ALU_zero,
                 Cout => open,
                 Ovf  => open); 
                 

-- prosthetw mux se kathe eisodo ths alu. 
--srcA,srcB : 
   
 mux_A:
  MUX2x1 port map ( Din0 => PC_out, -- h timh pou exei o PC sto IFSTAGE
                    Din1 => In_A,   -- 1h eksodos rf
                    sel  => srcA,
                    Dout => temp_mux_out_A);
 
 mux_B:
  MUX_4x1 port map ( Datain0 => In_B ,  
                    Datain1 => x"00000004",  -- gia praksi
						  Datain2 => Immed,   --opws einai apo to DECSTAGE
						  Datain3 => x"00000000",  --geiwsh
                    sel  => srcB,
                    Dataout => temp_mux_out_B);
end Behavioral;

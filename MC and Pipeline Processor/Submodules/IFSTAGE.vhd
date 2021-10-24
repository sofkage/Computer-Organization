----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:37:36 04/11/2021 
-- Design Name: 
-- Module Name:    IFSTAGE - Behavioral 
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

-- afairesa athroistes kai allaksa th thesi toy polyplekth gia na ginetai parallhla h alu

entity IFSTAGE is
    Port ( --PC_Immed : in STD_LOGIC_VECTOR (31 downto 0);
	 		  PC_In : in  STD_LOGIC_VECTOR (31 downto 0);
			  PC_out : out  STD_LOGIC_VECTOR (31 downto 0);
			  ALU_reg_out : in  STD_LOGIC_VECTOR (31 downto 0); 

           PC_sel : in STD_LOGIC;
           PC_LdEn : in STD_LOGIC;
           Reset : in STD_LOGIC;
           Clk : in STD_LOGIC;
           PC : out STD_LOGIC_VECTOR (31 downto 0)
           --instr : out STD_LOGIC_VECTOR(31 downto 0)
           );
end IFSTAGE;

architecture Behavioral of IFSTAGE is

component REG is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           WrEn : in STD_LOGIC;
           Datain : in STD_LOGIC_VECTOR (31 downto 0);
           Dataout : out STD_LOGIC_VECTOR (31 downto 0));
end component;


 
 --       component RAM
--      port  (
--             clk : in std_logic;
--             inst_addr : in std_logic_vector(10 downto 0);
--             inst_dout : out std_logic_vector(31 downto 0);
--             data_we : in std_logic;
--             data_addr : in std_logic_vector(10 downto 0);
--             data_din : in std_logic_vector(31 downto 0);
--             data_dout : out std_logic_vector(31 downto 0));
--     end component;   
     
 
component MUX2x1 is
    Port ( Din0 : in STD_LOGIC_VECTOR (31 downto 0);
           Din1 : in STD_LOGIC_VECTOR (31 downto 0);
           sel : in STD_LOGIC;
           Dout : out STD_LOGIC_VECTOR(31 downto 0));
end component;

--component adder_incre is
 --   Port ( Din : in STD_LOGIC_VECTOR (31 downto 0);
 --          Dout : out STD_LOGIC_VECTOR (31 downto 0));
--end component;

--component adder_immed is
 --   Port ( Din : in STD_LOGIC_VECTOR (31 downto 0);
 --          PC_Immed : in STD_LOGIC_VECTOR (31 downto 0);
 --          Dout : out STD_LOGIC_VECTOR (31 downto 0));
--end component;

signal temp_PC_in : std_logic_vector(31 downto 0);
signal temp_PC_out : std_logic_vector(31 downto 0);
signal temp_adder_incre_out : std_logic_vector(31 downto 0); 
signal temp_adder_immed_out : std_logic_vector(31 downto 0);  --branch


begin
    
PC_register:
    REG port map ( Datain  =>PC_In,                                   
                     WrEn  =>PC_LdEn,   -- energopoihsh eggrafhs
                     CLK     =>Clk,
                     RST     =>Reset, 
                     Dataout =>temp_PC_out);
							
	-- PC<=temp_PC_out;
    
	 -- edw evala na dialegei apo alu out kai pc out 
    mux2to1:  
    MUX2x1 port map( Din0  => temp_PC_out, --immed or incre
                     Din1  => ALU_reg_out,
                     sel   => PC_sel,               -- select 0 or 1
                     Dout  => PC);          --update PC
							
PC_out <= temp_PC_out;
    
  --  add_incre:
   --     adder_incre port map ( Din  => temp_PC_out,
  --                             Dout => temp_adder_incre_out);
    
    
  --  add_immed:    
   --     adder_immed port map ( Din  => temp_adder_incre_out,
    --                           PC_Immed => PC_Immed,
    --                           Dout => temp_adder_immed_out);  
    

                      
      --memory:
--    RAM port map(clk => Clk,
--                inst_addr => temp_PC(12 downto 2), --without 2 lsb
--                 inst_dout => instr,
--                 data_we   => '0',
--				 data_addr => "00000000000",
--				 data_din  => x"00000000",
--				 data_dout => open);


               
end Behavioral;

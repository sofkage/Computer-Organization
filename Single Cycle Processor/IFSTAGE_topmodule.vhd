----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:32:10 04/11/2021 
-- Design Name: 
-- Module Name:    IFSTAGE_topmodule - Behavioral 
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

entity IFSTAGE_topmodule is
    Port ( PC_Immed : in STD_LOGIC_VECTOR (31 downto 0); --same as RF
           PC_sel : in STD_LOGIC;
           PC_LdEn : in STD_LOGIC;
           Reset : in STD_LOGIC;
           Clk : in STD_LOGIC;
           instr : out STD_LOGIC_VECTOR(31 downto 0)
           );end IFSTAGE_topmodule;
           
architecture Behavioral of IFSTAGE_topmodule is

    component IFSTAGE 
        Port ( PC_Immed : in STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in STD_LOGIC;
           PC_LdEn : in STD_LOGIC;
           Reset : in STD_LOGIC;
           Clk : in STD_LOGIC;
           PC : out STD_LOGIC_VECTOR (31 downto 0)
           );
     end component;
     
     component RAM
      port  (
             clk : in std_logic;
             inst_addr : in std_logic_vector(10 downto 0);
             inst_dout : out std_logic_vector(31 downto 0);
             data_we : in std_logic;
             data_addr : in std_logic_vector(10 downto 0);
             data_din : in std_logic_vector(31 downto 0);
             data_dout : out std_logic_vector(31 downto 0));
     end component;
     

signal temp_PC: std_logic_vector(31 downto 0);

begin

ifst:
    IFSTAGE port map ( PC_Immed => PC_Immed,
                       PC_sel   => PC_sel,
                       PC_LdEn  => PC_LdEn,
                       Reset    => Reset,
                       Clk      => Clk,
                       PC       => temp_PC);

memory:
    RAM port map(clk => Clk,
                 inst_addr => temp_PC(12 downto 2), --without 2 lsb
                 inst_dout => instr,
                 data_we   => '0',
				 data_addr => "00000000000",
				 data_din  => x"00000000",
				 data_dout => open);



end Behavioral;



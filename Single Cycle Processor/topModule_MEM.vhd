----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:33:22 04/11/2021 
-- Design Name: 
-- Module Name:    topModule_MEM - Behavioral 
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

entity topModule_MEM is
    Port ( ByteOp : in STD_LOGIC;
            Mem_WrEn : in STD_LOGIC;
            ALU_MEM_Addr : in STD_LOGIC_VECTOR (31 downto 0);
            MEM_DataIn : in STD_LOGIC_VECTOR (31 downto 0);
            MEM_DataOut : out STD_LOGIC_VECTOR (31 downto 0);
            clk : in STD_LOGIC);
end topModule_MEM;


architecture Behavioral of topModule_MEM is

component MEMSTAGE 
    Port ( --clk : in STD_LOGIC;  --ti kanw me to roloi
           Mem_WrEn : in STD_LOGIC;
           ALU_MEM_Addr : in STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataIn : in STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataOut : out STD_LOGIC_VECTOR (31 downto 0);
           MM_Addr : out STD_LOGIC_VECTOR (31 downto 0);
           MM_WrEn : out STD_LOGIC;
           MM_WrData : out STD_LOGIC_VECTOR (31 downto 0);
           MM_RdData : in STD_LOGIC_VECTOR (31 downto 0);
           ByteOp : in STD_LOGIC
           );
end component;

component RAM
    port(
    	clk : in std_logic;
		inst_addr : in std_logic_vector(10 downto 0);
		inst_dout : out std_logic_vector(31 downto 0);
		data_we : in std_logic;
		data_addr : in std_logic_vector(10 downto 0);
		data_din : in std_logic_vector(31 downto 0);
		data_dout : out std_logic_vector(31 downto 0)
    );
    end component;
    
signal temp_MM_WrEn : std_logic;
signal temp_MM_Addr : std_logic_vector(31 downto 0);
signal temp_MM_WrData : std_logic_vector(31 downto 0);
signal temp_MM_RdData : std_logic_vector(31 downto 0);

begin


    memst:
        MEMSTAGE port map (Mem_WrEn => Mem_WrEn,
								  ALU_MEM_Addr => ALU_MEM_Addr,
								  MEM_DataIn => MEM_DataIn,
								  MEM_DataOut => MEM_DataOut,
								  MM_Addr => temp_MM_Addr,
								  MM_WrEn => temp_MM_WrEn,
								  MM_WrData => temp_MM_WrData,
								  MM_RdData => temp_MM_RdData,
								  ByteOp => ByteOp);
            
    
    memory_ram:  
       RAM port map(clk=>Clk, 
							data_we => temp_MM_WrEn,
							data_addr => temp_MM_Addr(12 downto 2),
							data_din  => temp_MM_WrData,
							data_dout => temp_MM_RdData, 
							inst_addr => "00000000000",
						   inst_dout => open);
    





end Behavioral;



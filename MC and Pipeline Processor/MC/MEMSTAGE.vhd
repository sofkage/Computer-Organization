----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:37:59 04/11/2021 
-- Design Name: 
-- Module Name:    MEMSTAGE - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MEMSTAGE is
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
end MEMSTAGE;

architecture Behavioral of MEMSTAGE is


signal temp_MM_Addr :   STD_LOGIC_VECTOR(31 downto 0);
signal temp_MM_WrData : STD_LOGIC_VECTOR(31 downto 0);
signal temp_MM_RdData : STD_LOGIC_VECTOR(31 downto 0);
signal temp_sb : STD_LOGIC_VECTOR(7 downto 0);
signal temp_lb : STD_LOGIC_VECTOR(7 downto 0);


begin
process(ALU_MEM_Addr, Mem_WrEn, MEM_DataIn, MM_RdData,temp_sb,temp_lb,ByteOp )
begin

     MM_Addr <= ALU_MEM_Addr + x"400";  -- offset
     MM_WrEn   <= Mem_WrEn;
     
     if ByteOp = '0' then
        MM_WrData   <= MEM_DataIn; --sw
        MEM_DataOut <= MM_RdData;  --lw  
     else
        temp_sb   <= MEM_DataIn(7 downto 0); --sb
        MM_WrData <= ("000000000000000000000000" & temp_sb);
        
        temp_lb     <= MM_RdData(7 downto 0); --lb
        MEM_DataOut <= ("000000000000000000000000" & temp_lb);
    end if;  
    
end process;

end Behavioral;

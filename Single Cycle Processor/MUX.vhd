----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:38:22 04/11/2021 
-- Design Name: 
-- Module Name:    MUX - Behavioral 
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

package mux_pack is
       type muxIn is array (31 downto 0) of std_logic_vector(31 downto 0);
end mux_pack;

use work.mux_pack.all;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity MUX is 
    Port ( in_mux : in muxIn;
           Control : in STD_LOGIC_VECTOR (4 downto 0);
           out_mux : out STD_LOGIC_VECTOR (31 downto 0));
 end MUX;

architecture Behavioral of MUX is

signal temp_mux_out: std_logic_vector(31 downto 0);
begin

process(in_mux,temp_mux_out,Control)
begin
    temp_mux_out <= std_logic_vector(in_mux(to_integer(unsigned(Control))));
end process;

out_mux <= temp_mux_out after 10 ns;


end Behavioral;

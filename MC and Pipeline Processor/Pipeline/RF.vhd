----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:32:54 04/11/2021 
-- Design Name: 
-- Module Name:    RF - Behavioral 
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
use work.mux_pack.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RF is
    Port ( Ard1 : in STD_LOGIC_VECTOR (4 downto 0);
           Ard2 : in STD_LOGIC_VECTOR (4 downto 0);
           Awr : in STD_LOGIC_VECTOR (4 downto 0);
           Dout1 : out STD_LOGIC_VECTOR (31 downto 0);  -- from MUX1
           Dout2 : out STD_LOGIC_VECTOR (31 downto 0);  -- from MUX2
           Din : in STD_LOGIC_VECTOR (31 downto 0);
           WrEn : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Rst : in STD_LOGIC);

end RF;

architecture Behavioral of RF is

 COMPONENT REG
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           WrEn : in STD_LOGIC;
           Datain : in STD_LOGIC_VECTOR (31 downto 0);
           Dataout : out STD_LOGIC_VECTOR (31 downto 0));  -- imput of mux
    END COMPONENT;
    
 COMPONENT MUX
    Port ( in_mux  : in muxIn;  
           Control : in STD_LOGIC_VECTOR (4 downto 0);
           out_mux : out STD_LOGIC_VECTOR (31 downto 0));
    END COMPONENT;
    
 COMPONENT DEC
    Port ( Awr : in STD_LOGIC_VECTOR (4 downto 0);
           Dataout : out STD_LOGIC_VECTOR (31 downto 0));
    END COMPONENT;
   
 signal temp_WrEn : std_logic_vector(31 downto 0);
 signal temp_dec_out: std_logic_vector(31 downto 0);
     signal temp_reg_out:  muxIn;
  
  
 begin
  
    ----------------- WRITE ENABLE --------------------------
  write_enable:
      for i in 1 to 31 generate
        temp_WrEn(i) <= (WrEn AND temp_dec_out(i)) after 2 ns;  -- AND gates
      end generate write_enable;
      
	  temp_WrEn(0)<='0' after 2 ns;  --R0
	  
  ---------------   REGISTERS --------------------------
  Register_Generator:
    for j in 0 to 31 generate
        regx : REG port map( Datain  =>Din,                                   
                             WrEn    =>temp_WrEn(j),
                             CLK     =>Clk,
                             RST     =>Rst, 
                             Dataout =>temp_reg_out(j));
  
  end generate Register_Generator;
  
  ----------------- DECODER ------------------------------
  Decoder:
        DEC port map(Awr     => Awr,
                     Dataout => temp_dec_out);


  ----------------- MULTIPLEXERS -------------------------
  
  mux1:
    MUX port map( in_mux  => temp_reg_out,
                  Control => Ard1,
                  out_mux => Dout1);  -- MUX1 TO DOUT1

  mux2:
    MUX port map( in_mux  => temp_reg_out,
                  Control => Ard2,
                  out_mux => Dout2);  -- MUX2 TO DOUT2 
 


end Behavioral;


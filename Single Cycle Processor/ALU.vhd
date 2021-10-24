----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:34:48 04/11/2021 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( A : in STD_LOGIC_VECTOR (31 downto 0);
           B : in STD_LOGIC_VECTOR (31 downto 0);
           Op : in STD_LOGIC_VECTOR (3 downto 0);
           Output : out STD_LOGIC_VECTOR (31 downto 0);
           Zero : out STD_LOGIC;
           Cout : out STD_LOGIC;
           Ovf : out STD_LOGIC);
end ALU;

architecture Behavioral of ALU is
    signal temp_Out: std_logic_vector(31 downto 0);
    signal temp_Cout: std_logic_vector(32 downto 0);
    signal temp_Ovf: std_logic;
    signal temp_Zero: std_logic;
    
begin
    process(A,B,Op,temp_Out,temp_Cout,temp_Ovf,temp_Zero)

begin 

    case Op is
        when "0000" => 
            temp_Out <= A+B;
            temp_Cout <= ('0'& A) + ('0' & B);	  
        when "0001" => 
            temp_Out <= A-B;
        when "0010" => 
            temp_Out <= A and B;
        when "0011" => 
            temp_Out <= A or B;
         when "0100" => 
            temp_Out <= not A;
         when "0101" => 
            temp_Out<= A nand B;
         when "0110" => 
            temp_Out<= A nor B;
        when "1000" => 
            temp_Out(31) <= A(31);
            temp_Out(30 downto 0) <= A(31 downto 1);
        when "1001" =>
            temp_Out(31) <='0';
            temp_Out(30 downto 0) <= A(31 downto 1);
        when "1010" =>
            temp_Out(31 downto 1) <= A(30 downto 0);
            temp_Out(0)<='0';
        when "1100" =>
            temp_Out(31 downto 1) <= A(30 downto 0);
            temp_Out(0) <= A(31);
        when "1101" =>
            temp_Out(30 downto 0) <= A(31 downto 1);
            temp_Out(31) <= A(0);
         when others =>
              null;
    end case; 
---------------- ZERO ------------------------------    
    if(temp_Out = x"00000000") then
        temp_Zero <= '1';
    else
        temp_Zero <= '0';
    end if;

----------------  OVF ----------------------------------  
    if(((A(31) = '0') and (B(31)= '0') and (temp_Out(31) = '1'))OR ((A(31) ='1') and (B(31)='1') and (temp_Out(31)='0')))  then
        temp_Ovf <= '1';
    else
        temp_Ovf <= '0';
    end if;
    	
  ------------- OUTPUTS ------------------------ 
    Output <= temp_Out      after 10 ns;
    Cout   <= temp_Cout(32) after 10 ns;  --MSB
    Ovf    <= temp_Ovf      after 10 ns;
    Zero   <= temp_Zero     after 10 ns;
    end process;
    
end Behavioral;



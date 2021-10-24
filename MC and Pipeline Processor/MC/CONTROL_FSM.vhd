----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:25:36 05/01/2021 
-- Design Name: 
-- Module Name:    CONTROL_FSM - Behavioral 
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

--moore fsm giati h timh ths epomenis katastasis eksartatai mono apo to current state
entity CONTROL_FSM is
Port ( OpCode : in  STD_LOGIC_VECTOR (5 downto 0);
           ALU_Op : out  STD_LOGIC_VECTOR (3 downto 0);
           bne : out  STD_LOGIC;
           b_beq : out  STD_LOGIC;
           PC_LdEn : out  STD_LOGIC;
			  PC_source :out STD_LOGIC;
           ImmExt : out  STD_LOGIC_VECTOR (1 downto 0);
           RF_B_Sel : out  STD_LOGIC;
           RF_WrEn : out  STD_LOGIC;
           RF_WrData_Sel : out  STD_LOGIC;
           Mem_WrEn : out  STD_LOGIC;
			  we_reg_dec_a : out STD_LOGIC;
			  we_reg_dec_b : out STD_LOGIC;
			  we_reg_ALU : out STD_LOGIC;
			  we_reg_PC : out STD_LOGIC;
			  we_reg_MemOut : out STD_LOGIC;
			  PC_sel : in std_logic;
			  srcA : out  STD_LOGIC;
			  srcB: out  STD_LOGIC_VECTOR(1 downto 0);
           Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC);
end CONTROL_FSM;

architecture Behavioral of CONTROL_FSM is

	type state_type is (state_1,state_2,state_3,state_4,state_5,state_6,state_7,state_8,state_9, state_10); 
	signal current_state, next_state : state_type; 


begin
fsm: process(OpCode,current_state, PC_sel)
begin
	case current_state is
------------------------------STATE 1 --------------------------------------------			
		when state_1 => --same for every instruction 
			--instruction fetch
			
				b_beq<='0';
				bne<='0';
				
				
				PC_source<='0';  -- giati h alu xrhsim gia PC=PC+4
				srcA<='0';
				srcB<="01"; -- h 2h eisodos ths alu einai h stathera 4
				-----------
				we_reg_PC <='1';
				PC_LdEn   <='1'; 
				
				RF_B_Sel<='0';
				RF_WrEn<='0';
				RF_WrData_Sel<='0';
				ALU_Op<="0000"; --add
				Mem_WrEn<='0';
				ImmExt<="00";
				
				we_reg_dec_a<='0';
				we_reg_dec_b<='0';
				we_reg_ALU<='0';
				we_reg_MemOut<='0';
				
				next_state <= state_2;
			
			
------------------------------STATE 2  --------------------------------------------			
			
		when state_2 => --same for every instr
		--decode state -> states according to opcode
			
				PC_LdEn<='0';
				we_reg_PC<='0';
				we_reg_dec_a<='1';
				we_reg_dec_b<='1';
				we_reg_ALU<='0';
				we_reg_MemOut<='0';
				
				if OpCode="100000" then --R-type cmd
					
					ImmExt<="00";
					RF_B_Sel<='0';
					RF_WrData_Sel<='0';
					
					next_state <= state_3; 
			
			elsif (OpCode="110010" or OpCode="110011" or OpCode="111001" 	or OpCode="110000" or OpCode="111000") then 
			--nandi,ori, lui,addi, li 
				
				RF_B_Sel<='1'; --rd
				RF_WrData_Sel<='0'; --alu out
				
				if (OpCode(3 downto 0)="0011" or OpCode(3 downto 0)="0010") then --func for ori,nandi
					ImmExt<="00"; --zf
				elsif OpCode(3 downto 0)="1001" then --lui
					ImmExt<="11"; --zf<< 
				else 
					ImmExt<="01"; --se
				end if;
			
				next_state<=state_4;
				
			elsif (OpCode="111111" or OpCode="000000" or OpCode="000001") then 
			--b, beq, bne
			
				RF_B_Sel<='1';
				RF_WrData_Sel<='0'; --dc
				ImmExt<="10"; --se << 
				-- PC=PC+Immediate (PC already +4)
				srcA<='0';
				srcB<="10"; -- h deytreh eisodos ths alu einai ta xamhlotera 16b toy ir afou exei ypostei epektash proshmoy ksi ol kata 2b
				we_reg_ALU<='1';

				next_state <= state_5;	
				
			elsif (OpCode="000011" or OpCode="001111"  or OpCode="000111" or OpCode="011111") then  
			--lb, lw	--sb, sw
			
				ImmExt<="01"; --se
				RF_WrData_Sel<='1';

				next_state <= state_6;
				
			else
				next_state <= state_1;
			end if;
			
------------------------------STATE 3 --------------------------------------------			

		when state_3 =>
		--exstage for R-type
	
			ALU_Op<="1000";
			we_reg_ALU<='0';
			we_reg_ALU<='1';
			we_reg_dec_a<='0';
			we_reg_dec_b<='0';
			RF_WrEn<='0';
			srcA<='1'; --rfa
			srcB<="00"; -- proerxetai apo ton katax rfb
			
			next_state <= state_9; --write back state

------------------------------STATE 4  --------------------------------------------			

		when state_4 =>
		--exstage for I-type
		
			if OpCode(3 downto 0)="0011" then
				ALU_Op<="0011";
			elsif OpCode(3 downto 0)="0010" then
				ALU_op<="0101";
			else 
				ALU_op<="0000";
			end if;
			
			we_reg_ALU<='0';
			we_reg_ALU<='1';
			
			we_reg_dec_a<='0';
			we_reg_dec_b<='0';
			RF_WrEn<='0';
			srcA<='1'; --rfa
			srcB<="10"; --immed
			next_state <= state_9; --write back state


------------------------------STATE 5 --------------------------------------------			
			
		when state_5 => 
		
		--exstage for branch
		
			--edw vazw timh sta shmata branch pou orisa. meta gia to pcsel syndyazontai me zero
			if OpCode(1 downto 0)="01" then --bne
				b_beq<='0';
				bne<='1';
			else 										--beq,b
				b_beq<='1';
				bne<='0';
			end if;
			
			if PC_Sel='1' then 
				PC_LdEn<='1';
				PC_source<='1';--regALU_out=PC+4+Immed phgainoun ston pc
				we_reg_PC<='1'; 
				
			else 
				PC_LdEn<='0';
				PC_source<='0';
			end if;
						
			ALU_Op<="0001";
			we_reg_ALU<='0';
			
			we_reg_dec_a<='0';
			we_reg_dec_b<='0';
			RF_WrEn<='0';
			srcA<='1'; --rfa
			srcB<="00"; --rfb
			
			we_reg_PC<='0'; --maybe
			next_state <= state_1;


------------------------------STATE 6 --------------------------------------------			
		
		when state_6 => 
		--exstage l,s

			ALU_Op<="0000";
			we_reg_ALU<='0';
			we_reg_ALU<='1';
			srcA<='1'; --rfa
			srcB<="10"; --immed
			we_reg_dec_a<='0';
			we_reg_dec_b<='0';
			RF_WrEn<='0';
			
			--seperate store from load - MEM
			if (OpCode(4 downto 2)="000" or OpCode(4 downto 2)="011") then --load
				next_state<=state_7; --memstage
			elsif (OpCode(4 downto 2)="001" or OpCode(4 downto 2)="111") then --store
				next_state <= state_8; --memstage
			end if;
			--------------------------

------------------------------STATE 7 --------------------------------------------			
			
		when state_7 => -- memstage lb lw
			we_reg_ALU<='0';
			we_reg_MemOut<='1';
			next_state <= state_10;

------------------------------STATE 8 --------------------------------------------			
			
		when state_8 => --memstage sb, sw
	
			we_reg_ALU<='0';
			we_reg_MemOut<='0';
			Mem_WrEn<='1';
			next_state <= state_1;

------------------------------STATE 9 --------------------------------------------			
			
		when state_9 => --write back rtype and itype
			RF_WrData_sel<='0'; --reg alu out
			RF_WrEn<='1';
			we_reg_ALU<='0';
			next_state <= state_1;

------------------------------STATE 10 --------------------------------------------			
			
		when state_10=>
			we_reg_MemOut<='0';
			RF_WrData_sel<='1'; --reg mem out
			RF_WrEn<='1';			
			next_state <= state_1;
		
		when others =>
			next_state <= state_1;
		end case;
		
end process fsm;

sync: process(Clk)
begin
	if rising_edge(Clk) then
		if Rst='1' then current_state<=state_1;
		else current_state<=next_state;
		end if;
	end if;
end process sync;
end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pwm is
generic(
    clk_freq    : integer := 50000000;  -- clock frequency (Hz)
    duty_freq   : integer := 50         -- frequency of pwm_out signal (Hz)
);
Port (
    clk     : in std_logic;
    duty    : in std_logic_vector (3 downto 0); -- Level of duty cycle
    pwm_out : buffer std_logic                  
);
end pwm;

architecture Behavioral of pwm is

    signal counter          : integer := 0;
    signal counter_limit    : integer;                          -- % of duty cycle
    signal div_number       : integer := clk_freq/duty_freq;    -- adjustment for counter_limit 
                                                                -- in order to meet duty cycle time according to clk_freq and duty_time
    
    begin
    
    counter_limit <= (to_integer(unsigned(duty)))*(div_number)/15;  -- % of duty cycle since there are 16 levels
    
    process(clk) begin
        if rising_edge(clk) then
            if(counter = (div_number-1)) then
                counter <= 0;
            else
                if(counter < counter_limit) then
                    pwm_out <= '1';
                else
                    pwm_out <= '0';
                end if;
                counter <= counter + 1;
            end if;
        end if;
    end process;

end Behavioral;

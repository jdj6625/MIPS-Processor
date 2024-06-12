-- ----------------------------------------------------
-- Company : Rochester Institute of Technology (RIT )
-- Engineer : <YOUR_NAME_HERE > ( < YOUR_EMAIL_HERE >)
--
-- Create Date : <CREATION_TIME_HERE >
-- Design Name : globals
-- Module Name : globals - package ( library )
-- Project Name : <PROJECT_NAME_HERE >
-- Target Devices : Basys3
--
-- Description : Constants used in top and test bench level
-- Xilinx does not like generics in the top level of a design
-- ----------------------------------------------------
library ieee ;
use ieee . std_logic_1164 .all;
package globals is
constant N : INTEGER := 32;
constant M : INTEGER := 5;
end;
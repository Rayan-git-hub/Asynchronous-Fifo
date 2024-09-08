# Asynchronous-Fifo
The provided Verilog code implements an asynchronous FIFO (First-In-First-Out) buffer with separate clocks for write and read operations (wr_clk and rd_clk). The FIFO operates with two primary features: the ability to store data asynchronously using distinct clock domains and the capacity to manage data flow with full and empty flags.

# Key Components:
Memory: A 64-entry deep memory (Mem[63:0]), each entry 8 bits wide, is used to store data.  
Pointers: The write pointer (wr_ptr) tracks the position for writing data, and the read pointer (rd_ptr) tracks the position for reading data.  
FIFO Counter: The fifo_counter monitors the number of elements in the FIFO, determining if it's full or empty. It increments on a write and decrements on a read.  

# Control Signals:
full: Asserted when the FIFO is full (64 entries).    
empty: Asserted when the FIFO is empty (0 entries).
wr_en and rd_en: Control signals for enabling writing and reading, respectively. 

# Operation:
Writing: Data is written to the FIFO when wr_en is high and the FIFO is not full. The data is stored at the wr_ptr location in memory, and the pointer is incremented.  
Reading: Data is read from the FIFO when rd_en is high and the FIFO is not empty. The data is fetched from the rd_ptr location, and the pointer is incremented.  

# Testbench:
A testbench verifies the FIFO’s functionality by simulating write and read operations under different clock conditions. It writes and reads data, ensuring proper synchronization across the two clocks.  

The FIFO is useful in asynchronous clock domains for buffering data without data loss or timing issues, critical in multi-clock systems like DSPs or communication interfaces.

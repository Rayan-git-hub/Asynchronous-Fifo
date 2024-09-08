`timescale 1ns / 1ps

module tb_Asynchronous_Fifo;

    // Inputs
    reg wr_clk;
    reg rd_clk;
    reg rst;
    reg wr_en;
    reg rd_en;
    reg [7:0] buf_in;

    // Outputs
    wire [7:0] buf_out;
    wire empty;
    wire full;
    wire [7:0] fifo_counter;

    // Instantiate the FIFO module
    Asynchronous_Fifo uut (
        .wr_clk(wr_clk), 
        .rd_clk(rd_clk), 
        .rst(rst), 
        .wr_en(wr_en), 
        .rd_en(rd_en), 
        .buf_in(buf_in), 
        .buf_out(buf_out), 
        .empty(empty), 
        .full(full), 
        .fifo_counter(fifo_counter)
    );

    // Clock generation for wr_clk (write clock) and rd_clk (read clock)
    initial begin
        wr_clk = 0;
        forever #5 wr_clk = ~wr_clk; // 100 MHz clock (10 ns period)
    end

    initial begin
        rd_clk = 0;
        forever #7 rd_clk = ~rd_clk; // 71.42 MHz clock (14 ns period)
    end

    // Test sequence
    initial begin
        // Initialize inputs
        rst = 1;
        wr_en = 0;
        rd_en = 0;
        buf_in = 8'd0;

        // Reset the FIFO
        #20 rst = 0;

        // Write some data into the FIFO
        #10 wr_en = 1;
        buf_in = 8'hA1; // Write first byte
        #10 buf_in = 8'hB2; // Write second byte
        #10 buf_in = 8'hC3; // Write third byte
        #10 wr_en = 0; // Stop writing

        // Wait a little before reading data
        #50 rd_en = 1;

        // Read the data out of the FIFO
        #20 rd_en = 0; // Stop reading

        // Write more data to the FIFO
        #20 wr_en = 1;
        buf_in = 8'hD4;
        #10 buf_in = 8'hE5;
        #10 buf_in = 8'hF6;
        #10 wr_en = 0;

        // Read again
        #50 rd_en = 1;
        #30 rd_en = 0;

        // End simulation
        #100 $finish;
    end

    // Monitor the signals to observe the output
    initial begin
        $monitor("Time = %0d, rst = %b, wr_en = %b, rd_en = %b, buf_in = %h, buf_out = %h, empty = %b, full = %b, fifo_counter = %d", 
                 $time, rst, wr_en, rd_en, buf_in, buf_out, empty, full, fifo_counter);
    end
endmodule
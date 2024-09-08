`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.09.2024 22:36:22
// Design Name: 
// Module Name: Synchronous_Fifo
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Asynchronous_Fifo(wr_clk, rd_clk, rst, buf_in, buf_out, empty, full, wr_en, rd_en, fifo_counter);
    input rd_clk, wr_clk;
    input rst,rd_en,wr_en;
    input [7:0]buf_in;
    output empty,full;
    output [7:0]buf_out;
    output [7:0]fifo_counter;
    
    reg[7:0]buf_out;
    reg empty,full;
    reg[7:0] fifo_counter;
    reg [3:0]rd_ptr, wr_ptr;
    reg [7:0] Mem [63:0];
    
    always @(fifo_counter) begin
        empty=(fifo_counter==0);
        full=(fifo_counter==64);
    end
    
    always @(posedge wr_clk or posedge rst) begin
        if (rst)
            fifo_counter <= 0;
        else if ((!full && wr_en) && (!empty && rd_en))
            fifo_counter <= fifo_counter;
        else if (!full && wr_en)
            fifo_counter <= fifo_counter + 1;
    end
        
     always @(posedge rd_clk or posedge rst) begin
        if (rst) 
            fifo_counter <= 0;
            
        else if(!empty && rd_en)
            fifo_counter <= fifo_counter - 1;
        else
            fifo_counter <= fifo_counter;
        end 
     
     always @(posedge wr_clk or posedge rst) begin 
            if(!full && wr_en)
                Mem[wr_ptr]<=buf_in;
            else 
                Mem[wr_ptr]<=Mem[wr_ptr];
            end
            
      always @(posedge rd_clk or posedge rst) begin
        if(rst)
            buf_out<=0;
        else begin    
            if(!empty && rd_en)
                buf_out<=Mem[rd_ptr];
            else
                buf_out<=buf_out;
        end
        end
        
        always @(posedge wr_clk or posedge rst) begin
        if(rst)begin
            wr_ptr<=0;
            rd_ptr<=0; end
        else begin
            if(wr_en && !full)
                wr_ptr<=wr_ptr+1;
            else 
                wr_ptr<=wr_ptr;
              end
              end
         
         always @(posedge rd_clk or posedge rst) begin
            if(rst) begin
                wr_ptr<=0;
                rd_ptr<=0; end
            else
                if(rd_en && !empty) begin
                    rd_ptr<=rd_ptr+1; end
                else begin
                    rd_ptr<=rd_ptr; end
                
            end 
endmodule

module tb;
    reg [2:0] i_1, i_2;
    reg [15:0] write_data;
    reg clk = 0;
    reg RegWrite;
    wire [15:0] o_1, o_2;

    regfile u1(.i_1(i_1), .i_2(i_2), .write_data(write_data), .clk(clk), .RegWrite(RegWrite), .o_1(o_1), .o_2(o_2));
    
    always #5 clk = ~clk;

    initial begin
        RegWrite = 1;
        i_1 = 16'b0000000000000001;
        write_data = 3'b011;
        $display("i_1 = %d, write_data = %d, RegWrite = %d", i_1, write_data, RegWrite);
        #10

        i_1 = 3'b010;
        write_data = 16'b0000000000000100;
        $display("i_1 = %d, write_data = %d, RegWrite = %d", i_1, write_data, RegWrite);
        #10

        RegWrite = 0;
        i_1 = 3'b001;
        i_2 = 3'b010;
        $display("i_1 = %d, i_2 = %d, RegWrite = %d", i_1, i_2, RegWrite);
        #5
        $display("o_1 = %d, o_2 = %d", o_1, o_2);
        
        $finish;
    end
endmodule
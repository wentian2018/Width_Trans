module bin_to_gray 
#(
    parameter WIDTH = 8
)

(
    input [WIDTH-1:0] bin,
    output [WIDTH-1:0] gray
);

    
    wire [WIDTH-1:0] gray;

    assign gray = bin ^ (bin >> 1);

endmodule
module gray_counter
#(
    parameter WIDTH = 8
)
(
    input clk,
    input rst_n,
    input cen, //counter add enable 
    output [WIDTH-1:0] gray_dout
);
    
    

    reg  [WIDTH-1:0] gray_dout;
    wire [WIDTH-1:0] gray_temp;
    wire [WIDTH-1:0] bin_dout;
    wire [WIDTH-1:0] bin_add;

    always@(*) begin

        if (cen) begin
            bin_add = bin_dout + 1'b1;
        end
        
    end

    bin_to_gray #(WIDTH) btg(.bin(bin_add), .gray(gray_temp));

    

    always@(posedge clk or negedge rst_n) begin
        if(!rst_n)
            gray_dout <= {WIDTH{1'b0}};
        else
            gray_dout <= gray_temp;
    end

    gray_to_bin #(WIDTH) gtb(.gray(gray_dout), .bin(bin_dout));
    

endmodule
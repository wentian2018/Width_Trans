module wptr_full
#(
    parameter ADDSIZE = 4
)
(
    input wr_req,
    input clk_wr,rstn,
    input [ADDSIZE-1:0] wq2_rptr,

    output full,
    output wen,
    output [ADDSIZE-1:0] wptr


);

    wire cen;

    reg [ADDSIZE-1:0] gray_dout;
    reg [ADDSIZE-1:0] wptr;

    assign cen = wr_req && (!full) ;


    gray_counter #(ADDSIZE) GC(.clk(clk_wr), .rst_n(rstn), .cen(cen), .gray_dout(gray_dout));

    always @(posedge clk_wr or negedge rstn) begin
        if (!rstn) begin
            
            wptr <= 0;

        end else begin

            wptr <= gray_dout;

        end
    end

    wire full_val;

    assign full_val = (gray_dout == {~wq2_rptr[ADDRSIZE:ADDRSIZE-1],
                    wq2_rptr[ADDRSIZE-2:0]}) && (wr_req == 1); //FIFO write Full ，while the MSB and the next bit is not equal，the rest bit is equal

    always @(posedge clk_wr or negedge rstn) begin

        if (!rstn) begin

            full <= 1'b0;
      
        end else begin

            full <= full_val;
            
        end
    end 

    assign wen = !full ? 1 : 0;              
endmodule
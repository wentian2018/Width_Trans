module sync_w2r
#(
    parameter ADDSIZE = 4
)

(
    input clk_rd,rstn,
    input [ADDSIZE-1:0] wptr,

    output [ADDSIZE-1:0] rq2_wptr
);

reg [ADDSIZE-1:0] rq1_wptr;
reg [ADDSIZE-1:0] rq2_wptr;

always @(posedge clk_rd ornegedge rstn) begin
    if (!rstn) begin
        {rq2_wptr,rq1_wptr} <= 0;
    end else begin
        {rq2_wptr,rq1_wptr} <= {rq1_wptr,wptr};
    end
end

endmodule
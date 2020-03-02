module sync_r2w

#(
    parameter ADDSIZE = 4 
)

(
    input [ADDSIZE-1:0] rptr,
    input clk_wr,rstn,
    
    output  [ADDSIZE-1:0] wq2_rptr

);

//use two DFF 

reg [ADDSIZE-1:0] wq1_rptr;
reg [ADDSIZE-1:0] wq2_rptr;

always @(posedge clk_wr or negedge rstn) begin

    if (!rstn) begin
        {wq2_rptr,wq1_rptr} <= 0;
    end
    else begin
        {wq2_rptr,wq1_rptr} <= {wq1_rptr,rptr};// synchronize read pointer to write clock domain
    end
    
end


endmodule
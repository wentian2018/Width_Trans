module async_fifo
#(
    parameter WRDATA_SIZE = 4,// Write data width
    parameter RDDATA_SIZE = 3,// Read data width
    parameter ADDR_SIZE  = 4  // Address width
)

(
    input [WRDATA_SIZE-1:0] wdata,
    input wr_req,rd_req,// write and read request
    input clk_wr,clk_rd,//write and read clock

    output full,empty,

    output [RDDATA_SIZE-1:0] rdata
);


//---In order to perform FIFO full and FIFO empty tests using  this FIFO 
//---The read and write pointers must be passed to the opposite clock domain 
//---for pointer comparison


sync_r2w #(ADDR_SIZE) I1_sync_r2w (
    .wq2_rptr(wq2_rptr),
    .rptr(rptr),
    .clk_wr(clk_wr),
    .rstn(rstn)
);

sync_w2r #(ADDR_SIZE) I2_sync_w2r (
    .rq2_rptr(rq2_rptr),
    .wptr(wptr),
    .clk_wd(clk_rd),
    .rstn(rstn)
);

//----Dual RAM----//

dualport_ram #(WRDATA_SIZE,RDDATA_SIZE,ADDR_SIZE) I3_dualport_ram (
    .rdclk(clk_rd),
    .wrclk(clk_wr),
    .wren(wen),
    .rden(ren),
    .waddr(wptr),
    .raddr(rptr),
    .wdata(wdata),
    .rdata(rdata)

);


//---Full and empty judge---//

rptr_empty #(ADDR_SIZE) I4_rptr_empty(
    .empty(empty),
    .rptr(rptr),
    .rq2_wptr(rq2_wptr),
    .clk_rd(clk_rd),
    .rstn(rstn),
    .rd_req(rd_req),
    .ren(ren)

);

wptr_full #(ADDR_SIZE) I5_wptr_full(
    .full(full),
    .wptr(wptr),
    .wq2_rptr(wq2_rptr),
    .clk_wr(clk_wr),
    .rstn(rstn),
    .wr_req(wr_req),
    .wen(wen)
);
    
endmodule
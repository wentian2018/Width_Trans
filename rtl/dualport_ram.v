module dualport_ram
#(
    parameter WRDATA_SIZE = 4,// Write data width
    parameter RDDATA_SIZE = 3,// Read data width
    parameter ADDR_SIZE  = 4  // Address width

)
(
    input wrclk,rdclk, // clock for write and read 
    input wren,rden, // enable signal for write and read

    input [ADDR_SIZE-1:0] raddr, //RAM read address
    input [ADDR_SIZE-1:0] waddr, //RAM write address

    input [WRDATA_SIZE-1:0] wdata, //data input

    output [RDDATA_SIZE-1:0] rdata //data output
    
);

localparam RAM_DEPTH = 1 << ADDR_SIZE;// RAM depth = 2^ADDR_WIDTH

reg [WRDATA_SIZE-1:0] Mem [RAM_DEPTH-1:0];

always @ (posedge wrclk) begin
    
    if (wren) begin

    Mem[waddr] <= wdata ;
        
    end

end

always @ (posedge rdclk ) begin

    if (rden) begin

    rdata = Mem[raddr];
        
    end

end
    
endmodule
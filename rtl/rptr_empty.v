module rptr_empty
#(
    parameter  ADDSIZE = 4;
)

(
    input rd_req,
    input clk_rd,rstn,
    input [ADDSIZE-1:0] rq2_wptr,


    output empty,
    output ren,
    output [ADDSIZE-1:0] rptr
    
);

    wire cen;

    reg [ADDSIZE-1:0] gray_dout;
    reg [ADDSIZE-1:0] rptr;

    assign cen = wd_req && (!empty) ;

    gray_counter #(ADDSIZE) GC(.clk(clk_rd), .rst_n(rstn), .cen(cen), .gray_dout(gray_dout));

    always @(posedge clk_wr or negedge rstn) begin
        if (!rstn) begin
            
            rptr <= 0;

        end else begin

            rptr <= gray_dout;

        end
    end
    
    wire empty_val;

    assign empty_val = (gray_dout == rq2_wptr) && (rd_req == 1); //FIFO write Full ，while the MSB and the next bit is not equal，the rest bit is equal

    always @(posedge clk_rd or negedge rstn) begin

        if (!rstn) begin

            empty <= 1'b0;
      
        end else begin

            empty <= empty_val;
            
        end
    end 

    assign ren = !empty ? 1 : 0; 
    
endmodule
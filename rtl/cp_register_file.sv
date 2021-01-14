module cp_register_file #(
)(
    input  logic        clk,
    input  logic [4:0]  rs1_addr_i,
    input  logic [4:0]  rs2_addr_i,
    output logic [31:0] rs1_data_o,
    output logic [31:0] rs2_data_o,
    input  logic [4:0]  rd_addr_i,
    input  logic [31:0] rd_data_i,
    input  logic        rd_we_i
);

    logic [31:0] mem[0:31];
    always_ff @(posedge clk) begin
        if(rd_we_i) begin
            mem[rd_addr_i] <= rd_data_i;
        end
    end
    assign rs1_data_o = mem[rs1_addr_i];
    assign rs2_data_o = mem[rs2_addr_i];

endmodule

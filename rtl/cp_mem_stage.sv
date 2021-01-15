module cp_mem_stage #(
)(
    input  logic        clk,

    //signals for ID stage
    output logic        ready_id_o,
    input  logic        valid_id_i,
    input  logic [31:0] rs1_data_id_i,
    input  logic [31:0] rs2_data_id_i,
    input  logic [4:0]  rd_addr_i,
    input  logic [2:0]  func3_id_i,
    input  logic [6:0]  opcode_id_i,
    input  logic [11:0] imm_i_id_i,
    input  logic [11:0] imm_s_id_i,
    input  logic        rd_we_id_i,
    input  logic        dmem_we_id_i,
    input  logic        ld_be_id_i,
    input  logic        st_be_id_i,

    //signals for EX stage
    output logic        valid_ex_o,
    input  logic        ready_ex_i,
    output logic [31:0] rs1_data_ex_o,
    output logic [31:0] rs2_data_ex_o,
    output logic        rd_we_ex_o,
    output logic [4:0]  rd_addr_ex_o,
    output logic [2:0]  func3_ex_o,
    output logic [6:0]  opcode_ex_o,
    output logic [31:0] rdata_ex_o,

    //signals for data mem
    input  logic        valid_dmem_i,
    output logic        ready_dmem_o,
    output logic [31:0] addr_dmem_o,
    output logic [31:0] data_dmem_o,
    output logic        we_dmem_o,
    input  logic [31:0] data_dmem_i,
);
    
    //for memory
    assign addr_dmem_o  = rs1_data_id_i;
    assign data_dmem_o  = rs2_data_id_i;
    assign we_dmem_o    = dmem_we_id_i;

    logic cke;
    logic valid_buf;

    assign cke = ~valid_ex_o | ready_ex_i;
    always_ff @(posedge clk) begin
        if(cke) begin
            rs1_data_ex_o   <= rs1_data_id_i;
            rs2_data_ex_o   <= rs2_data_id_i;
            rd_addr_ex_o    <= rd_addr_id_i;
            rd_we_ex_o      <= rd_we_id_i;
            func3_ex_o      <= func3_id_i;
            opcode_ex_o     <= opcode_id_i;
            valid_buf       <= valid_id_i;
            valid_dmem_buf  <= valid_dmem_i;
        end
    end
    assign valid_ex_o = valid_buf & valid_dmem_buf;
    assign rdata_ex_o = data_dmem_i;

endmodule

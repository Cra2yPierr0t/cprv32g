module cp_ex_stage #(
)(
    input  logic        clk,

    //signals for ID stage
    output logic        ready_id_o,
    input  logic        valid_id_i,
    input  logic [31:0] rs1_data_id_o,
    input  logic [31:0] rs2_data_id_o,
    input  logic [4:0]  rd_addr_id_o,
    input  logic [2:0]  func3_id_i,
    input  logic [6:0]  opcode_id_i,
    input  logic [11:0] imm_i_id_i,
    input  logic [11:0] imm_s_id_i,
    input  logic        rd_we_id_i,
    input  logic        dmem_we_id_i,
    input  logic [3:0]  ld_be_id_i,
    input  logic [3:0]  st_be_id_i,

    //signals for MEM stage
    output logic [31:0] alu_rs_mem_o,
);

    parameter OP_LOAD   = 7'b0000011;
    parameter OP_STORE  = 7'b0100011;
    parameter OP_IMM    = 7'b0010011;

    parameter F3_ADDI   = 3'b000;
    parameter F3_XORI   = 3'b100;
    parameter F3_ORI    = 3'b110;
    parameter F3_ANDI   = 3'b111;

    logic [31:0] alu_out;

    always_comb begin
        case(opcode_id_i)
            OP_IMM: begin
                case(func3_id_i)
                    F3_ADDI: alu_out = rs1_data_id_o + {20'h00000, imm_i_id_i};
                    F3_XORI: alu_out = rs1_data_id_o ^ {20'h00000, imm_i_id_i};
                    F3_ORI : alu_out = rs1_data_id_o | {20'h00000, imm_i_id_i};
                    F3_ANDI: alu_out = rs1_data_id_o & {20'h00000, imm_i_id_i};
                endcase
            end
            OP_LOAD : alu_out = 32'h0000_0000;
            OP_STORE: alu_out = 32'h0000_0000;
            default : alu_out = 32'h0000_0000;
        endcase
    end

    always_ff @(posedge clk) begin
        if(cke) begin
            alu_rs_mem_o <= alu_out;
        end
    end
endmodule

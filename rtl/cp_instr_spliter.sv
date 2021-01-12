module cp_instr_spliter #(
)(
    input  logic [31:0]     instr_data_i,
    output logic [4:0]      rs1_addr_o,
    output logic [4:0]      rs2_addr_o,
    output logic [4:0]      rd_addr_o,
    output logic [2:0]      func3_o,
    output logic [6:0]      opcode_o,
    output logic [11:0]     imm_i_o,
    output logic [11:0]     imm_s_o
);

    always_comb begin
        rs1_addr_o  = instr_data_i[19:15];
        rs2_addr_o  = instr_data_i[24:20];
        rd_addr_o   = instr_data_i[11:7];
        func3_o     = instr_data_i[14:12];
        opcode_o    = instr_data_i[6:0];
        imm_i_o     = instr_data_i[31:12];
        imm_s_o     = {instr_data_i[31:25], instr_data_i[11:7]};
    end
endmodule

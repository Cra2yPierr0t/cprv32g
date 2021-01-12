module cp_id_stage #(
)(
    input  logic            clk,

    //signals for IF stage
    input  logic [31:0]     instr_data_if_i,
    input  logic            instr_valid_if_i,
    output logic            instr_ready_if_o,

    //signals for EX stage
    input  logic            ready_ex_i,
    output logic            valid_ex_o,
    output logic [31:0]     rs1_data_ex_o,
    output logic [31:0]     rs2_data_ex_o,
    output logic [4:0]      rd_addr_ex_o,
    output logic [2:0]      func3_ex_o,
    output logic [6:0]      opcode_ex_o,
    output logic [11:0]     imm_i_ex_o,
    output logic [11:0]     imm_s_ex_o,

    //signals for Register
    output logic [4:0]      rs1_addr_rf_o,
    output logic [4:0]      rs2_addr_rf_o,
    input  logic [31:0]     rs1_data_rf_i,
    input  logic [31:0]     rs2_data_rf_i,
);

    cp_instr_spliter instr_spliter #(
    )(
        .instr_data_i   (instr_data_i   ),
        .rs1_addr_o     (rs1_addr_o     ),
        .rs2_addr_o     (rs2_addr_o     ),
        .rd_addr_o      (rd_addr_o      ),
        .func3_o        (func3_o        ),
        .opcode_o       (opcode_o       ),
        .imm_i_o        (imm_i_o        ),
        .imm_s_o        (imm_s_o        ),
    );

    logic cke;

    assign rs1_addr_rf_o = rs1_addr_o;
    assign rs2_addr_rf_o = rs2_addr_o;

    assign cke = ~valid_ex_o | ready_ex_o;
    assign instr_ready_if_o = cke;
    always_ff @(posedge clk) begin
        if(cke) begin
            valid_ex_o <= instr_valid_if_i;
            rs1_data_ex_o <= rs1_data_rf_i;
            rs2_data_ex_o <= rs2_data_rf_i;
            rd_addr_ex_o  <= rd_addr_o;
            func3_ex_o    <= func3_o;
            opcode_ex_o   <= opcode_o;
            imm_i_ex_o    <= imm_i_ex;
            imm_s_ex_o    <= imm_s_ex;
        end
    end
    
endmodule

module cp_id_stage #(
)(
    input  logic            clk,

    //signals for IF stage
    input  logic [31:0]     instr_data_if_i,
    input  logic            instr_valid_if_i,
    output logic            instr_ready_if_o,

    //signals for MEM stage
    input  logic            ready_mem_i,
    output logic            valid_mem_o,
    output logic [31:0]     rs1_data_mem_o,
    output logic [31:0]     rs2_data_mem_o,
    output logic [4:0]      rd_addr_mem_o,
    output logic [2:0]      func3_mem_o,
    output logic [6:0]      opcode_mem_o,
    output logic [11:0]     imm_i_mem_o,
    output logic [11:0]     imm_s_mem_o,
    output logic            rd_we_mem_o,
    output logic            dmem_we_mem_o,
    output logic            ld_be_mem_o,
    output logic            st_be_mem_o,

    //signals for Register
    output logic [4:0]      rs1_addr_rf_o,
    output logic [4:0]      rs2_addr_rf_o,
    input  logic [31:0]     rs1_data_rf_i,
    input  logic [31:0]     rs2_data_rf_i,
);

    logic [2:0]     func3_o;
    logic [6:0]     opcode_o;

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

    logic           rd_we_o;
    logic           dmem_we_o;
    logic           ld_be_o;
    logic           st_be_o;

    cp_gen_ctrl gen_ctrl #(
    )(
        .func3_i        (func3_o        ),
        .opcode_i       (opcode_o       ),
        .rd_we_o        (rd_we_o        ),
        .dmem_we_o      (dmem_we_o      ),
        .ld_be_o        (ld_be_o        ),
        .st_be_o        (st_be_o        ),
    );

    logic cke;

    assign rs1_addr_rf_o = rs1_addr_o;
    assign rs2_addr_rf_o = rs2_addr_o;

    assign cke = ~valid_ex_o | ready_ex_o;
    assign instr_ready_if_o = cke;
    always_ff @(posedge clk) begin
        if(cke) begin
            valid_mem_o     <= instr_valid_if_i;
            rs1_data_mem_o  <= rs1_data_rf_i;
            rs2_data_mem_o  <= rs2_data_rf_i;
            rd_addr_mem_o   <= rd_addr_o;
            func3_mem_o     <= func3_o;
            opcode_mem_o    <= opcode_o;
            imm_i_mem_o     <= imm_i_o;
            imm_s_mem_o     <= imm_s_o;
            dmem_we_mem_o   <= dmem_we_o;
            rd_we_mem_o     <= rd_we_o;
            ld_be_mem_o     <= ld_be_o;
            st_be_mem_o     <= st_be_o;
        end
    end
    
endmodule

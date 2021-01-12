module cp_if_stage #(
) (
    input  logic        clk,

    //signals for instr mem
    output logic        instr_ready_o,
    input  logic        instr_valid_i
    output logic [31:0] instr_addr_o,
    input  logic [31:0] instr_data_i,

    //signals for ID stage
    output logic [31:0] instr_data_id_o,
    output logic        instr_valid_id_o,
    input  logic        instr_ready_id_i,
);

    logic [31:0] pc;

    assign instr_addr_o = pc;
    always_ff @(posedge clk) begin
        pc <= instr_addr_o + 4;
    end

    logic valid_buf;
    logic [31:0] instr_buf;
    logic cke = ~instr_valid_id_o | instr_ready_id_i;

    assign instr_valid_id_o = valid_buf;
    assign instr_data_id_o  = instr_buf;
    assign instr_ready_o    = cke;
    always_ff @(posedge clk) begin
        if(cke) begin
            valid_buf <= instr_valid_i;
            instr_buf <= instr_data_i;
        end
    end
endmodule

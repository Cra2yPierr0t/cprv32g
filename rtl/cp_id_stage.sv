module cp_id_stage #(
)(
    input  logic            clk,

    //signals for IF stage
    input  logic [31:0]     instr_data_i,
    input  logic            instr_valid_i,
    output logic            instr_ready_o,

    //signals for EX stage
    input  logic            id_ready_i,
    output logic            id_valid_o,
    output logic
);
endmodule

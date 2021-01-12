module cp_core #(
) (
    input  logic [31:0] boot_addr,
    
    output logic        instr_req_o,    //instr mem io
    input  logic        instr_rvalid_i,
    output logic [31:0] instr_raddr_o,
    input  logic [31:0] instr_rdata_i,

    output logic [31:0] data_waddr_o,   //data mem io
    output logic [31:0] data_wdata_o,
    output logic        data_we_o,
    output logic [3:0]  data_be_o,
    output logic [31:0] data_raddr_o,
    input  logic [31:0] data_rdata_i,
    output logic        data_req_o,
    input  logic        data_rvalid_i,

    input  logic        irq_software_i, //interrupts
    input  logic        irq_timer_i,
    input  logic        irq_external_i,
    input  logic        irq_fast_i,
    input  logic        irq_nm_i,
);

    cp_if_stage #(
    ) if_stage (
    );
    
    cp_id_stage #(
    ) id_stage (
    );

    cp_ex_stage #(
    ) ex_stage (
    );

    cp_mem_stage #(
    ) mem_stage (
    );

    cp_wb_stage #(
    ) wb_stage (
    );

endmodule

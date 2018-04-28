// NPC control signal
`define NPC_PLUS4   2'b00
`define NPC_BRANCH  2'b01
`define NPC_JUMP    2'b10   

// EXT control signal
`define EXT_ZERO    2'b00
`define EXT_SIGNED  2'b01
`define EXT_HIGHPOS 2'b10

// ALU control signal
`define ALUOp_NOP   5'b00000 
`define ALUOp_ADDU  5'b00001
`define ALUOp_ADD   5'b00010
`define ALUOp_SUBU  5'b00011
`define ALUOp_SUB   5'b00100 
`define ALUOp_AND   5'b00101
`define ALUOp_OR    5'b00110
`define ALUOp_NOR   5'b00111
`define ALUOp_XOR   5'b01000
`define ALUOp_SLT   5'b01001
`define ALUOp_SLTU  5'b01010 
`define ALUOp_EQL   5'b01011
`define ALUOp_BNE   5'b01100
`define ALUOp_GT0   5'b01101
`define ALUOp_GE0   5'b01110
`define ALUOp_LT0   5'b01111
`define ALUOp_LE0   5'b10000
`define ALUOp_SLL   5'b10001
`define ALUOp_SRL   5'b10010
`define ALUOp_SRA   5'b10011

`define INSTR_ADD    6'b100000
`define INSTR_ADDU   6'b100001
`define INSTR_SUB     6'b100010
`define INSTR_SUBU    6'b100011

`define INSTR_AND     6'b100100
`define INSTR_OR      6'b100101
`define INSTR_XOR     6'b100110
`define INSTR_SLL   6'b000000
`define INSTR_SRL    6'b000010
`define INSTR_SRA     6'b000011     
`define INSTR_JR      6'b001000
`define INSTR_SLT   6'b101010



`define INSTR_LW     6'b100011


`define INSTR_SW         6'b101011

`define INSTR_ADDI       6'b001000

`define INSTR_ANDI       6'b001100
`define INSTR_ORI        6'b001101 

`define INSTR_LUI       6'b001111

`define INSTR_BEQ        6'b000100
`define INSTR_BNE        6'b000101

`define INSTR_J          6'b000010
`define INSTR_JAL        6'b000011  
 

// GPR control signal
`define GPRSel_RD   2'b00
`define GPRSel_RT   2'b01
`define GPRSel_31   2'b10

`define WDSel_FromALU 2'b00
`define WDSel_FromMEM 2'b01
`define WDSel_FromPC  2'b10 

// Memory control signal
`define BE_SB  2'b00
`define BE_SH  2'b01
`define BE_SW  2'b10

`define ME_LB  3'b000
`define ME_LBU 3'b001
`define ME_LH  3'b010
`define ME_LHU 3'b011
`define ME_LW  3'b100
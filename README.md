# ALU Control Encoding

Custom 4-bit `alu_control` encoding used by `control_unit.sv` to tell the ALU (in `execute_stage.sv`) which operation to perform. This is not part of the RISC-V ISA spec — it's an internal design choice for this project, so `control_unit.sv` (producer) and the ALU inside `execute_stage.sv` (consumer) must stay in sync with this table.

## R-type (opcode `0110011`)

| Instruction | funct3 | funct7    | alu_control (4-bit) |
|-------------|--------|-----------|----------------------|
| add         | 000    | 0000000   | `0000`               |
| sub         | 000    | 0100000   | `0001`               |
| sll         | 001    | 0000000   | `0010`               |
| slt         | 010    | 0000000   | `0011`               |
| sltu        | 011    | 0000000   | `0100`               |
| xor         | 100    | 0000000   | `0101`               |
| srl         | 101    | 0000000   | `0110`               |
| sra         | 101    | 0100000   | `0111`               |
| or          | 110    | 0000000   | `1000`               |
| and         | 111    | 0000000   | `1001`               |

## I-Type ALU-Immediate (opcode `0010011`)

Computes `rs1 OP imm`, writes result to `rd`. No memory access.

| Instruction | funct3 | imm[11:5] (shift-type field, only for slli/srli/srai) | alu_control (4-bit) |
|-------------|--------|--------------------------------------------------------|----------------------|
| addi        | 000    | —                                                       | `0000` (ALU_ADD)     |
| slli        | 001    | 0000000                                                 | `0010` (ALU_SLL)     |
| slti        | 010    | —                                                       | `0011` (ALU_SLT)     |
| sltiu       | 011    | —                                                       | `0100` (ALU_SLTU)    |
| xori        | 100    | —                                                       | `0101` (ALU_XOR)     |
| srli        | 101    | 0000000                                                 | `0110` (ALU_SRL)     |
| srai        | 101    | 0100000                                                 | `0111` (ALU_SRA)     |
| ori         | 110    | —                                                       | `1000` (ALU_OR)      |
| andi        | 111    | —                                                       | `1001` (ALU_AND)     |

## I-Type Load (opcode `0000011`)

Computes address `rs1 + imm`, reads from memory, writes result to `rd`.

| Instruction | funct3 | Meaning              |
|-------------|--------|----------------------|
| lb          | 000    | load byte, sign-ext  |
| lh          | 001    | load halfword, sign-ext |
| lw          | 010    | load word            |
| lbu         | 100    | load byte, zero-ext  |
| lhu         | 101    | load halfword, zero-ext |

For alu_control purposes, all loads just use `ALU_ADD` (`0000`) to compute the address — funct3 here is instead consumed by memory_stage.sv to decide how much data to read and whether to sign- or zero-extend it, not by the ALU.
markdown
## Control Signal Reference

### `result_src` — WB stage mux select (2 bits)

| Value | Meaning | Used by |
|-------|---------|---------|
| `00` | ALU result | R-type, I-type ALU-imm |
| `01` | Memory data (load) | Load instructions |
| `10` | PC + 4 | JAL, JALR |
| `11` | Immediate | LUI |

### `alu_src` — ALU operand select (2 bits)

| Value | Operand A | Operand B | Used by |
|-------|-----------|-----------|---------|
| `00` | `rs1` | `rs2` | R-type |
| `01` | `rs1` | `imm` | I-type ALU-imm, loads, stores |
| `10` | `PC` | `imm` | AUIPC, branches, JAL |
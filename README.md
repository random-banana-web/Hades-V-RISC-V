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


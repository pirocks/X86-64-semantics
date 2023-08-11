requires "x86-configuration.k"
requires "x86-flag-checks.k"

/*@
  Push R: 
  1. ValTostore = R
  2. *(RSP-8)  = ValTostore
  3. RSP = RSP - 8
*/  
module PUSHQ-IMM32
  imports X86-CONFIGURATION
  imports X86-FLAG-CHECKS

  rule <k> 
    execinstr (pushq Imm32:Imm, .Operands) =>
      storeToMemory(
          handleImmediateWithSignExtend(Imm32, 32, 64), 
          subMInt(getRegisterValue(%rsp, RSMap), mi(64, 8)), 
          64)  ~>  
      decRSPInBytes(8)
  ...</k>
  <regstate> RSMap </regstate>
endmodule

// Autogenerated using stratification.
requires "x86-configuration.k"
requires "x86-flag-checks.k"
module VMOVDQU-YMM-YMM
  imports X86-CONFIGURATION
  imports X86-FLAG-CHECKS
  rule <k>
    execinstr (vmovdqu R1:Ymm, R2:Ymm,  .Operands) => .
  ...</k>
    <regstate>
RSMap:Map => updateMap(RSMap,
convToRegKeys(R2) |-> getParentValue(R1, RSMap)
)

    </regstate>
    
endmodule

module VMOVDQU-YMM-YMM-SEMANTICS
  imports VMOVDQU-YMM-YMM
endmodule

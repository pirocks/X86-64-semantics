// Autogenerated using stratification.
requires "x86-configuration.k"
requires "x86-flag-checks.k"
module VXORPS-YMM-YMM-YMM
  imports X86-CONFIGURATION
  imports X86-FLAG-CHECKS
  rule <k>
    execinstr (vxorps R1:Ymm, R2:Ymm, R3:Ymm,  .Operands) => .
  ...</k>
    <regstate>
RSMap:Map => updateMap(RSMap,
convToRegKeys(R3) |-> xorMInt( getParentValue(R2, RSMap), getParentValue(R1, RSMap))
)

    </regstate>
    
endmodule

module VXORPS-YMM-YMM-YMM-SEMANTICS
  imports VXORPS-YMM-YMM-YMM
endmodule

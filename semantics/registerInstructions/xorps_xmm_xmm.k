// Autogenerated using stratification.
requires "x86-configuration.k"
requires "x86-flag-checks.k"
module XORPS-XMM-XMM
  imports X86-CONFIGURATION
  imports X86-FLAG-CHECKS
  rule <k>
    execinstr (xorps R1:Xmm, R2:Xmm,  .Operands) => .
  ...</k>
    <regstate>
RSMap:Map => updateMap(RSMap,
convToRegKeys(R2) |-> concatenateMInt( extractMInt( getParentValue(R2, RSMap), 0, 128), xorMInt( extractMInt( getParentValue(R2, RSMap), 128, 256), extractMInt( getParentValue(R1, RSMap), 128, 256)))
)

    </regstate>
    
endmodule

module XORPS-XMM-XMM-SEMANTICS
  imports XORPS-XMM-XMM
endmodule

// Autogenerated using stratification.
requires "x86-configuration.k"
requires "x86-flag-checks.k"
module CMOVNSQ-R64-R64
  imports X86-CONFIGURATION
  imports X86-FLAG-CHECKS
  rule <k>
    execinstr (cmovns R1:R64, R2:R64,  .Operands) => execinstr (cmovnsq R1:R64, R2:R64,  .Operands)
  ...</k>
  rule <k>
    execinstr (cmovnsq R1:R64, R2:R64,  .Operands) => .
  ...</k>
    <regstate>
RSMap:Map => updateMap(RSMap,
convToRegKeys(R2) |-> (#ifMInt (notBool eqMInt(getFlag("SF", RSMap), mi(1,1))) #then getParentValue(R1, RSMap) #else getParentValue(R2, RSMap) #fi)
)

    </regstate>
    
endmodule

module CMOVNSQ-R64-R64-SEMANTICS
  imports CMOVNSQ-R64-R64
endmodule

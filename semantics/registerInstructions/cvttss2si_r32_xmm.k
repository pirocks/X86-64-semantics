// Autogenerated using stratification.
requires "x86-configuration.k"
requires "x86-flag-checks.k"
module CVTTSS2SI-R32-XMM
  imports X86-CONFIGURATION
  imports X86-FLAG-CHECKS
  rule <k>
    execinstr (cvttss2si R1:Xmm, R2:R32,  .Operands) => .
  ...</k>
    <regstate>
RSMap:Map => updateMap(RSMap,
convToRegKeys(R2) |-> concatenateMInt( mi(32, 0), cvt_single_to_int32_truncate(extractMInt( getParentValue(R1, RSMap), 224, 256)))
)

    </regstate>
    
endmodule

module CVTTSS2SI-R32-XMM-SEMANTICS
  imports CVTTSS2SI-R32-XMM
endmodule

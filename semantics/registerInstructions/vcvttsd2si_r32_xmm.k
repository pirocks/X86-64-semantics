// Autogenerated using stratification.
requires "x86-configuration.k"
requires "x86-flag-checks.k"
module VCVTTSD2SI-R32-XMM
  imports X86-CONFIGURATION
  imports X86-FLAG-CHECKS
  rule <k>
    execinstr (vcvttsd2si R1:Xmm, R2:R32,  .Operands) => .
  ...</k>
    <regstate>
RSMap:Map => updateMap(RSMap,
convToRegKeys(R2) |-> concatenateMInt( mi(32, 0), cvt_double_to_int32_truncate(extractMInt( getParentValue(R1, RSMap), 192, 256)))
)

    </regstate>
    
endmodule

module VCVTTSD2SI-R32-XMM-SEMANTICS
  imports VCVTTSD2SI-R32-XMM
endmodule

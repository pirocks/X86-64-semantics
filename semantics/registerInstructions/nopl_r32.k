// Autogenerated using stratification.
requires "x86-configuration.k"
requires "x86-flag-checks.k"
module NOPL-R32
  imports X86-CONFIGURATION
  imports X86-FLAG-CHECKS
  rule <k>
    execinstr (nopl R1:R32,  .Operands) => .
  ...</k>
endmodule

module NOPL-R32-SEMANTICS
  imports NOPL-R32
endmodule

// Autogenerated using stratification.
requires "x86-configuration.k"
requires "x86-flag-checks.k"
module NOPW-R16
  imports X86-CONFIGURATION
  imports X86-FLAG-CHECKS
  rule <k>
    execinstr (nopw R1:R16,  .Operands) => .
  ...</k>
endmodule

module NOPW-R16-SEMANTICS
  imports NOPW-R16
endmodule

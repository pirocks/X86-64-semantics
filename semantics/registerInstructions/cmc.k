// Autogenerated using stratification.
requires "x86-configuration.k"
requires "x86-flag-checks.k"
module CMC
  imports X86-CONFIGURATION
  imports X86-FLAG-CHECKS
  rule <k>
    execinstr (cmc  .Operands) => .
  ...</k>
    <regstate>
RSMap:Map => updateMap(RSMap,
"CF" |-> (#ifMInt eqMInt(getFlag("CF", RSMap), mi(1,1)) #then mi(1, 0) #else mi(1, 1) #fi)
)

    </regstate>
    
endmodule

module CMC-SEMANTICS
  imports CMC
endmodule

// Autogenerated using stratification.
requires "x86-configuration.k"
requires "x86-flag-checks.k"
module CMPXCHGL-R32-R32
  imports X86-CONFIGURATION
  imports X86-FLAG-CHECKS
  rule <k>
    execinstr (cmpxchgl R1:R32, R2:R32,  .Operands) => .
  ...</k>
    <regstate>
RSMap:Map => updateMap(RSMap,
"RAX" |-> (#ifMInt eqMInt( extractMInt( getParentValue(%rax, RSMap), 32, 64), extractMInt( getParentValue(R2, RSMap), 32, 64)) #then getParentValue(%rax, RSMap) #else concatenateMInt( mi(32, 0), extractMInt( getParentValue(R2, RSMap), 32, 64)) #fi)

convToRegKeys(R2) |-> (#ifMInt eqMInt( extractMInt( getParentValue(%rax, RSMap), 32, 64), extractMInt( getParentValue(R2, RSMap), 32, 64)) #then concatenateMInt( mi(32, 0), extractMInt( getParentValue(R1, RSMap), 32, 64)) #else getParentValue(R2, RSMap) #fi)

"CF" |-> (#ifMInt (notBool eqMInt( extractMInt( addMInt( addMInt( concatenateMInt( mi(1, 0), negMInt( extractMInt( getParentValue(R2, RSMap), 32, 64))), mi(33, 1)), concatenateMInt( mi(1, 0), extractMInt( getParentValue(%rax, RSMap), 32, 64))), 0, 1), mi(1, 1))) #then mi(1, 1) #else mi(1, 0) #fi)

"PF" |-> (#ifMInt (notBool (((((((eqMInt( extractMInt( addMInt( addMInt( concatenateMInt( mi(1, 0), negMInt( extractMInt( getParentValue(R2, RSMap), 32, 64))), mi(33, 1)), concatenateMInt( mi(1, 0), extractMInt( getParentValue(%rax, RSMap), 32, 64))), 32, 33), mi(1, 1)) xorBool eqMInt( extractMInt( addMInt( addMInt( concatenateMInt( mi(1, 0), negMInt( extractMInt( getParentValue(R2, RSMap), 32, 64))), mi(33, 1)), concatenateMInt( mi(1, 0), extractMInt( getParentValue(%rax, RSMap), 32, 64))), 31, 32), mi(1, 1))) xorBool eqMInt( extractMInt( addMInt( addMInt( concatenateMInt( mi(1, 0), negMInt( extractMInt( getParentValue(R2, RSMap), 32, 64))), mi(33, 1)), concatenateMInt( mi(1, 0), extractMInt( getParentValue(%rax, RSMap), 32, 64))), 30, 31), mi(1, 1))) xorBool eqMInt( extractMInt( addMInt( addMInt( concatenateMInt( mi(1, 0), negMInt( extractMInt( getParentValue(R2, RSMap), 32, 64))), mi(33, 1)), concatenateMInt( mi(1, 0), extractMInt( getParentValue(%rax, RSMap), 32, 64))), 29, 30), mi(1, 1))) xorBool eqMInt( extractMInt( addMInt( addMInt( concatenateMInt( mi(1, 0), negMInt( extractMInt( getParentValue(R2, RSMap), 32, 64))), mi(33, 1)), concatenateMInt( mi(1, 0), extractMInt( getParentValue(%rax, RSMap), 32, 64))), 28, 29), mi(1, 1))) xorBool eqMInt( extractMInt( addMInt( addMInt( concatenateMInt( mi(1, 0), negMInt( extractMInt( getParentValue(R2, RSMap), 32, 64))), mi(33, 1)), concatenateMInt( mi(1, 0), extractMInt( getParentValue(%rax, RSMap), 32, 64))), 27, 28), mi(1, 1))) xorBool eqMInt( extractMInt( addMInt( addMInt( concatenateMInt( mi(1, 0), negMInt( extractMInt( getParentValue(R2, RSMap), 32, 64))), mi(33, 1)), concatenateMInt( mi(1, 0), extractMInt( getParentValue(%rax, RSMap), 32, 64))), 26, 27), mi(1, 1))) xorBool eqMInt( extractMInt( addMInt( addMInt( concatenateMInt( mi(1, 0), negMInt( extractMInt( getParentValue(R2, RSMap), 32, 64))), mi(33, 1)), concatenateMInt( mi(1, 0), extractMInt( getParentValue(%rax, RSMap), 32, 64))), 25, 26), mi(1, 1)))) #then mi(1, 1) #else mi(1, 0) #fi)

"AF" |-> (#ifMInt eqMInt( xorMInt( xorMInt( extractMInt( getParentValue(R2, RSMap), 59, 60), extractMInt( getParentValue(%rax, RSMap), 59, 60)), extractMInt( addMInt( addMInt( concatenateMInt( mi(1, 0), negMInt( extractMInt( getParentValue(R2, RSMap), 32, 64))), mi(33, 1)), concatenateMInt( mi(1, 0), extractMInt( getParentValue(%rax, RSMap), 32, 64))), 28, 29)), mi(1, 1)) #then mi(1, 1) #else mi(1, 0) #fi)

"ZF" |-> (#ifMInt eqMInt( extractMInt( addMInt( addMInt( concatenateMInt( mi(1, 0), negMInt( extractMInt( getParentValue(R2, RSMap), 32, 64))), mi(33, 1)), concatenateMInt( mi(1, 0), extractMInt( getParentValue(%rax, RSMap), 32, 64))), 1, 33), mi(32, 0)) #then mi(1, 1) #else mi(1, 0) #fi)

"SF" |-> (#ifMInt eqMInt( extractMInt( addMInt( addMInt( concatenateMInt( mi(1, 0), negMInt( extractMInt( getParentValue(R2, RSMap), 32, 64))), mi(33, 1)), concatenateMInt( mi(1, 0), extractMInt( getParentValue(%rax, RSMap), 32, 64))), 1, 2), mi(1, 1)) #then mi(1, 1) #else mi(1, 0) #fi)

"OF" |-> (#ifMInt ((eqMInt( negMInt( extractMInt( getParentValue(R2, RSMap), 32, 33)), mi(1, 1)) ==Bool eqMInt( extractMInt( getParentValue(%rax, RSMap), 32, 33), mi(1, 1))) andBool (notBool (eqMInt( negMInt( extractMInt( getParentValue(R2, RSMap), 32, 33)), mi(1, 1)) ==Bool eqMInt( extractMInt( addMInt( addMInt( concatenateMInt( mi(1, 0), negMInt( extractMInt( getParentValue(R2, RSMap), 32, 64))), mi(33, 1)), concatenateMInt( mi(1, 0), extractMInt( getParentValue(%rax, RSMap), 32, 64))), 1, 2), mi(1, 1))))) #then mi(1, 1) #else mi(1, 0) #fi)
)

    </regstate>
      requires notBool sameRegisters(%eax, R2)

  rule <k>
    execinstr (cmpxchgl R1:R32, R2:R32,  .Operands) => .
  ...</k>
    <regstate>
RSMap:Map => updateMap(RSMap,
convToRegKeys(R2) |-> concatenateMInt( mi(32, 0), extractMInt( getParentValue(R1, RSMap), 32, 64))

"CF" |-> (#ifMInt (notBool eqMInt( extractMInt( addMInt( addMInt( concatenateMInt( mi(1, 0), negMInt( extractMInt( getParentValue(R2, RSMap), 32, 64))), mi(33, 1)), concatenateMInt( mi(1, 0), extractMInt( getParentValue(R2, RSMap), 32, 64))), 0, 1), mi(1, 1))) #then mi(1, 1) #else mi(1, 0) #fi)

"PF" |-> (#ifMInt (notBool (((((((eqMInt( extractMInt( addMInt( addMInt( concatenateMInt( mi(1, 0), negMInt( extractMInt( getParentValue(R2, RSMap), 32, 64))), mi(33, 1)), concatenateMInt( mi(1, 0), extractMInt( getParentValue(R2, RSMap), 32, 64))), 32, 33), mi(1, 1)) xorBool eqMInt( extractMInt( addMInt( addMInt( concatenateMInt( mi(1, 0), negMInt( extractMInt( getParentValue(R2, RSMap), 32, 64))), mi(33, 1)), concatenateMInt( mi(1, 0), extractMInt( getParentValue(R2, RSMap), 32, 64))), 31, 32), mi(1, 1))) xorBool eqMInt( extractMInt( addMInt( addMInt( concatenateMInt( mi(1, 0), negMInt( extractMInt( getParentValue(R2, RSMap), 32, 64))), mi(33, 1)), concatenateMInt( mi(1, 0), extractMInt( getParentValue(R2, RSMap), 32, 64))), 30, 31), mi(1, 1))) xorBool eqMInt( extractMInt( addMInt( addMInt( concatenateMInt( mi(1, 0), negMInt( extractMInt( getParentValue(R2, RSMap), 32, 64))), mi(33, 1)), concatenateMInt( mi(1, 0), extractMInt( getParentValue(R2, RSMap), 32, 64))), 29, 30), mi(1, 1))) xorBool eqMInt( extractMInt( addMInt( addMInt( concatenateMInt( mi(1, 0), negMInt( extractMInt( getParentValue(R2, RSMap), 32, 64))), mi(33, 1)), concatenateMInt( mi(1, 0), extractMInt( getParentValue(R2, RSMap), 32, 64))), 28, 29), mi(1, 1))) xorBool eqMInt( extractMInt( addMInt( addMInt( concatenateMInt( mi(1, 0), negMInt( extractMInt( getParentValue(R2, RSMap), 32, 64))), mi(33, 1)), concatenateMInt( mi(1, 0), extractMInt( getParentValue(R2, RSMap), 32, 64))), 27, 28), mi(1, 1))) xorBool eqMInt( extractMInt( addMInt( addMInt( concatenateMInt( mi(1, 0), negMInt( extractMInt( getParentValue(R2, RSMap), 32, 64))), mi(33, 1)), concatenateMInt( mi(1, 0), extractMInt( getParentValue(R2, RSMap), 32, 64))), 26, 27), mi(1, 1))) xorBool eqMInt( extractMInt( addMInt( addMInt( concatenateMInt( mi(1, 0), negMInt( extractMInt( getParentValue(R2, RSMap), 32, 64))), mi(33, 1)), concatenateMInt( mi(1, 0), extractMInt( getParentValue(R2, RSMap), 32, 64))), 25, 26), mi(1, 1)))) #then mi(1, 1) #else mi(1, 0) #fi)

"AF" |-> (#ifMInt eqMInt( xorMInt( mi(1, 0), extractMInt( addMInt( addMInt( concatenateMInt( mi(1, 0), negMInt( extractMInt( getParentValue(R2, RSMap), 32, 64))), mi(33, 1)), concatenateMInt( mi(1, 0), extractMInt( getParentValue(R2, RSMap), 32, 64))), 28, 29)), mi(1, 1)) #then mi(1, 1) #else mi(1, 0) #fi)

"ZF" |-> (#ifMInt eqMInt( extractMInt( addMInt( addMInt( concatenateMInt( mi(1, 0), negMInt( extractMInt( getParentValue(R2, RSMap), 32, 64))), mi(33, 1)), concatenateMInt( mi(1, 0), extractMInt( getParentValue(R2, RSMap), 32, 64))), 1, 33), mi(32, 0)) #then mi(1, 1) #else mi(1, 0) #fi)

"SF" |-> (#ifMInt eqMInt( extractMInt( addMInt( addMInt( concatenateMInt( mi(1, 0), negMInt( extractMInt( getParentValue(R2, RSMap), 32, 64))), mi(33, 1)), concatenateMInt( mi(1, 0), extractMInt( getParentValue(R2, RSMap), 32, 64))), 1, 2), mi(1, 1)) #then mi(1, 1) #else mi(1, 0) #fi)

"OF" |-> (#ifMInt ((eqMInt( negMInt( extractMInt( getParentValue(R2, RSMap), 32, 33)), mi(1, 1)) ==Bool eqMInt( extractMInt( getParentValue(R2, RSMap), 32, 33), mi(1, 1))) andBool (notBool (eqMInt( negMInt( extractMInt( getParentValue(R2, RSMap), 32, 33)), mi(1, 1)) ==Bool eqMInt( extractMInt( addMInt( addMInt( concatenateMInt( mi(1, 0), negMInt( extractMInt( getParentValue(R2, RSMap), 32, 64))), mi(33, 1)), concatenateMInt( mi(1, 0), extractMInt( getParentValue(R2, RSMap), 32, 64))), 1, 2), mi(1, 1))))) #then mi(1, 1) #else mi(1, 0) #fi)
)

    </regstate>
      requires sameRegisters(%eax, R2)
  
endmodule

module CMPXCHGL-R32-R32-SEMANTICS
  imports CMPXCHGL-R32-R32
endmodule

package uk.co.francisnixon

import java.io.File
import java.lang.IllegalStateException
import java.util.concurrent.ForkJoinPool
import java.util.concurrent.TimeUnit

fun main() {
    val forkJoinPool = ForkJoinPool(8);
        (system_requires + register_requires + immediate_requires + memory_requires).zip(
            system_imports + register_imports + immediate_imports + memory_imports
        ).parallelStream().forEach { (require, import) ->
            forkJoinPool.submit {
            try {
                println(import)
                val semantics_file_contents = """
require "x86-loader.k"
require "x86-env-init.k"
require "x86-fetch-execute.k"
require "x86-abstract-semantics.k"
require "x86-flag-checks.k"
require "x86-verification-lemmas.k"
require "x86-instructions-semantics.k"
require "x86-memory.k"
require "x86-mint-wrapper.k"
require "common/common.k"
require "x86-builtin.k"
require "x86-c-library.k"
require "${require}"

module X86-SEMANTICS
    imports X86-LOADER
    imports X86-INIT
    imports X86-FETCH-EXECUTE
    imports X86-ABSTRACT-SEMANTICS
    imports X86-FLAG-CHECKS
    imports X86-VERIFICATION-LEMMAS
    imports X86-INSTRUCTIONS-SEMANTICS
    imports X86-MEMORY
    imports MINT-WRAPPER
    imports COMMON
    imports X86-BUILTIN
    imports X86-C-LIBRARY
    imports X86-FLAG-CHECKS
    imports ${import}

endmodule
"""
                val semantics_file: File = File("semantics/x86-semantics.k");
                if (!semantics_file.exists()) {
                    throw IllegalStateException()
                }
                semantics_file.writeBytes(semantics_file_contents.encodeToByteArray())
                run_compilation(import)
            }catch (_: Throwable) { }
        }.get()
    }
}

fun run_compilation(import_name: String) {
    val working_dir = File("semantics")
    if(!working_dir.exists()){
        throw IllegalStateException()
    }
    val process = ProcessBuilder(
        listOf(
            "/home/user/k/k-distribution/target/release/k/bin/kompile",
            "x86-semantics.k",
            "--parse-only",
            "--emit-json",
            "--emit-json-prefix",
            import_name,
            "--syntax-module",
            "X86-SYNTAX",
            "--main-module",
            "X86-SEMANTICS",
            "--backend",
            "java",
            "-I",
            ".",
            "-I",
            "common/x86-config/"
        ),
    ).directory(working_dir).inheritIO().start()
    process.waitFor(10, TimeUnit.HOURS)
    try {
        if (process.exitValue() != 0) {

            throw IllegalStateException()
        }
    } catch (e: IllegalStateException) {
        process.destroyForcibly()
        throw e
    }
    return
}
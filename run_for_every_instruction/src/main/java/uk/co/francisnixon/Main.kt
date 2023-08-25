package uk.co.francisnixon

import java.io.File
import java.lang.IllegalStateException
import java.util.concurrent.TimeUnit

import com.xenomachina.argparser.ArgParser
import com.xenomachina.argparser.default
import java.util.concurrent.Executors

class Args(parser: ArgParser) {
    val num: Boolean by parser.flagging("Count number of instructions in semantics")
    val range_start: Int? by parser.storing("Numeric start of semantics to extract") { toInt() }.default(null)
    val range_end: Int? by parser.storing("Numeric end of semantics to extract") { toInt() }.default(null)
    val concurrency: Int by parser.storing("Maximum allowable concurrency") { toInt() }.default(1)
}

fun semanticsFileContentsCreate(require: String, import: String): String {
    val semanticsFileContents = """
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
    return semanticsFileContents
}


fun setupWorkDir(require: String, import: String): File {
    val work = File("workdir-$import")
    work.mkdir()
    val semanticsFile = File(work,"x86-semantics.k")
    semanticsFile.createNewFile()
    val semanticsFileContents = semanticsFileContentsCreate(require, import);
    semanticsFile.writeText(semanticsFileContents)
    return work
}

fun main(args: Array<String>) {
    val allRequires = system_requires + register_requires + immediate_requires + memory_requires
    val allImports = system_imports + register_imports + immediate_imports + memory_imports
    val parsedArgs = Args(ArgParser(args))
    assert(allRequires.size == allImports.size)
    if (parsedArgs.num) {
        println(allImports.size)
        return
    }


    val requireImportPairs = allRequires.zip(allImports)
    val rangeStart = parsedArgs.range_start ?: 0;
    val rangeEnd = parsedArgs.range_end ?: requireImportPairs.size;


    val threadPool = Executors.newFixedThreadPool(parsedArgs.concurrency)

    requireImportPairs.subList(rangeStart, rangeEnd).stream().forEach { (require, import) ->
        threadPool.submit {
            try {
                println("`$import`")
                val workDir = setupWorkDir(require, import)
                runCompilation(workDir, import)
            } catch (_: Throwable) {

            }
        }
    }
    threadPool.shutdown()
    threadPool.awaitTermination(100L, TimeUnit.DAYS);
}

fun runCompilation(semanticsFileDir: File, importName: String) {
    val workingDir = File("semantics")
    if (!workingDir.exists()) {
        throw IllegalStateException()
    }
    val argList = listOf(
        "/home/user/k/k-distribution/target/release/k/bin/kompile",
        "${semanticsFileDir.absolutePath}/x86-semantics.k",
        "--parse-only",
        "--emit-json",
        "--emit-json-prefix",
        importName,
        "--syntax-module",
        "X86-SYNTAX",
        "--main-module",
        "X86-SEMANTICS",
        "--backend",
        "java",
        "-I",
        ".",
        "-I",
        "common/x86-config/",
        "-I",
        semanticsFileDir.absoluteFile.toString()
    )
    println(argList)
    val process = ProcessBuilder(
        argList,
    ).directory(workingDir).inheritIO().start()
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
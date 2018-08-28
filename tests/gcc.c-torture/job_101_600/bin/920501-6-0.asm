    .text
    .globl	strchr
strchr:
    pushq	%rbp
    movq	%rsp, %rbp
    movq	%rdi, -8(%rbp)
    movl	%esi, -12(%rbp)
    nop
    movq	-8(%rbp), %rax
    movzbl	(%rax), %eax
    movl	-12(%rbp), %edx
    cmpb	%dl, %al
    je	L6
    movq	-8(%rbp), %rax
    leaq	1(%rax), %rdx
    movq	%rdx, -8(%rbp)
    movzbl	(%rax), %eax
    testb	%al, %al
    jne	L3
    movl	$0, %eax
    jmp	L1
L3:
    movq	-8(%rbp), %rax
    jmp	L1
L6:
L1:
    popq	%rbp
    ret
    .globl	strlen
strlen:
    pushq	%rbp
    movq	%rsp, %rbp
    movq	%rdi, -24(%rbp)
    movq	$0, -8(%rbp)
    jmp	L8
L9:
    addq	$1, -8(%rbp)
L8:
    movq	-24(%rbp), %rdx
    movq	-8(%rbp), %rax
    addq	%rdx, %rax
    movzbl	(%rax), %eax
    testb	%al, %al
    jne	L9
    movq	-8(%rbp), %rax
    popq	%rbp
    ret
    .globl	strcpy
strcpy:
    pushq	%rbp
    movq	%rsp, %rbp
    movq	%rdi, -24(%rbp)
    movq	%rsi, -32(%rbp)
    movq	-24(%rbp), %rax
    movq	%rax, -8(%rbp)
    nop
L12:
    movq	-24(%rbp), %rax
    leaq	1(%rax), %rdx
    movq	%rdx, -24(%rbp)
    movq	-32(%rbp), %rdx
    leaq	1(%rdx), %rcx
    movq	%rcx, -32(%rbp)
    movzbl	(%rdx), %edx
    movb	%dl, (%rax)
    movzbl	(%rax), %eax
    testb	%al, %al
    jne	L12
    movq	-8(%rbp), %rax
    popq	%rbp
    ret
    .globl	memcmp
memcmp:
    pushq	%rbp
    movq	%rsp, %rbp
    movq	%rdi, -24(%rbp)
    movq	%rsi, -32(%rbp)
    movq	%rdx, -40(%rbp)
    movq	-24(%rbp), %rax
    movq	%rax, -16(%rbp)
    movq	-32(%rbp), %rax
    movq	%rax, -8(%rbp)
    jmp	L15
L18:
    movq	-16(%rbp), %rax
    movzbl	(%rax), %edx
    movq	-8(%rbp), %rax
    movzbl	(%rax), %eax
    cmpb	%al, %dl
    je	L16
    movq	-16(%rbp), %rax
    movzbl	(%rax), %eax
    movzbl	%al, %edx
    movq	-8(%rbp), %rax
    movzbl	(%rax), %eax
    movzbl	%al, %eax
    subl	%eax, %edx
    movl	%edx, %eax
    jmp	L17
L16:
    addq	$1, -16(%rbp)
    addq	$1, -8(%rbp)
L15:
    movq	-40(%rbp), %rax
    leaq	-1(%rax), %rdx
    movq	%rdx, -40(%rbp)
    testq	%rax, %rax
    jne	L18
    movl	$0, %eax
L17:
    popq	%rbp
    ret
    .globl	exit
exit:
    pushq	%rbp
    movq	%rsp, %rbp
    movl	%edi, -4(%rbp)
    movq $-1, %rax
    jmp %rax
    
    nop
    popq	%rbp
    ret
    .globl	abort
abort:
    pushq	%rbp
    movq	%rsp, %rbp
    movq $-1, %rax
    jmp %rax
    
    nop
    popq	%rbp
    ret
    .globl	memset
memset:
    pushq	%rbp
    movq	%rsp, %rbp
    movq	%rdi, -24(%rbp)
    movl	%esi, -28(%rbp)
    movq	%rdx, -40(%rbp)
    movq	-24(%rbp), %rax
    movq	%rax, -8(%rbp)
    jmp	L22
L23:
    movq	-8(%rbp), %rax
    leaq	1(%rax), %rdx
    movq	%rdx, -8(%rbp)
    movl	-28(%rbp), %edx
    movb	%dl, (%rax)
L22:
    movq	-40(%rbp), %rax
    leaq	-1(%rax), %rdx
    movq	%rdx, -40(%rbp)
    testq	%rax, %rax
    jne	L23
    movq	-24(%rbp), %rax
    popq	%rbp
    ret
    .globl	memcpy
memcpy:
    pushq	%rbp
    movq	%rsp, %rbp
    movq	%rdi, -24(%rbp)
    movq	%rsi, -32(%rbp)
    movq	%rdx, -40(%rbp)
    movq	-24(%rbp), %rax
    movq	%rax, -16(%rbp)
    movq	-32(%rbp), %rax
    movq	%rax, -8(%rbp)
    jmp	L26
L27:
    movq	-16(%rbp), %rax
    leaq	1(%rax), %rdx
    movq	%rdx, -16(%rbp)
    movq	-8(%rbp), %rdx
    leaq	1(%rdx), %rcx
    movq	%rcx, -8(%rbp)
    movzbl	(%rdx), %edx
    movb	%dl, (%rax)
L26:
    movq	-40(%rbp), %rax
    leaq	-1(%rax), %rdx
    movq	%rdx, -40(%rbp)
    testq	%rax, %rax
    jne	L27
    movq	-24(%rbp), %rax
    popq	%rbp
    ret
    .globl	malloc
malloc:
    pushq	%rbp
    movq	%rsp, %rbp
    movq	%rdi, -8(%rbp)
    movl	$1000, %eax
    popq	%rbp
    ret
    .globl	calloc
calloc:
    pushq	%rbp
    movq	%rsp, %rbp
    movq	%rdi, -8(%rbp)
    movq	%rsi, -16(%rbp)
    movl	$1000, %eax
    popq	%rbp
    ret
    .globl	free
free:
    pushq	%rbp
    movq	%rsp, %rbp
    movq	%rdi, -8(%rbp)
    nop
    popq	%rbp
    ret
    .globl	isprint
isprint:
    pushq	%rbp
    movq	%rsp, %rbp
    movl	%edi, -4(%rbp)
    cmpl	$96, -4(%rbp)
    jle	L35
    cmpl	$122, -4(%rbp)
    jg	L35
    movl	$1, %eax
    jmp	L36
L35:
    cmpl	$64, -4(%rbp)
    jle	L37
    cmpl	$90, -4(%rbp)
    jg	L37
    movl	$1, %eax
    jmp	L36
L37:
    cmpl	$47, -4(%rbp)
    jle	L38
    cmpl	$57, -4(%rbp)
    jg	L38
    movl	$1, %eax
    jmp	L36
L38:
    movl	$0, %eax
L36:
    popq	%rbp
    ret
    .globl	str2llu
str2llu:
    pushq	%rbp
    movq	%rsp, %rbp
    movq	%rdi, -24(%rbp)
    movq	-24(%rbp), %rax
    leaq	1(%rax), %rdx
    movq	%rdx, -24(%rbp)
    movzbl	(%rax), %eax
    movsbl	%al, %eax
    subl	$48, %eax
    cltq
    movq	%rax, -8(%rbp)
L42:
    movq	-24(%rbp), %rax
    leaq	1(%rax), %rdx
    movq	%rdx, -24(%rbp)
    movzbl	(%rax), %eax
    movsbl	%al, %eax
    movl	%eax, -12(%rbp)
    cmpl	$0, -12(%rbp)
    je	L45
    subl	$48, -12(%rbp)
    movq	-8(%rbp), %rdx
    movq	%rdx, %rax
    salq	$2, %rax
    addq	%rdx, %rax
    addq	%rax, %rax
    movq	%rax, %rdx
    movl	-12(%rbp), %eax
    cltq
    addq	%rdx, %rax
    movq	%rax, -8(%rbp)
    jmp	L42
L45:
    nop
    movq	-8(%rbp), %rax
    popq	%rbp
    ret
    .globl	sqrtllu
sqrtllu:
    pushq	%rbp
    movq	%rsp, %rbp
    movq	%rdi, -24(%rbp)
    movq	$0, -8(%rbp)
    movq	-24(%rbp), %rax
    movq	%rax, -16(%rbp)
    nop
L47:
    addq	$1, -8(%rbp)
    shrq	-16(%rbp)
    cmpq	$0, -16(%rbp)
    jne	L47
    movq	-8(%rbp), %rax
    shrq	%rax
    movl	$1, %edx
    shlx	%rax, %rdx, %rax
    movq	%rax, -16(%rbp)
    movq	-8(%rbp), %rax
    andl	$1, %eax
    testq	%rax, %rax
    je	L48
    movq	-16(%rbp), %rax
    shrq	%rax
    addq	%rax, -16(%rbp)
L48:
    movq	-24(%rbp), %rax
    movl	$0, %edx
    divq	-16(%rbp)
    movq	%rax, -8(%rbp)
    movq	-16(%rbp), %rdx
    movq	-8(%rbp), %rax
    addq	%rdx, %rax
    shrq	%rax
    movq	%rax, -16(%rbp)
    movq	-8(%rbp), %rax
    cmpq	-16(%rbp), %rax
    jb	L48
    movq	-16(%rbp), %rax
    popq	%rbp
    ret
    .globl	plist
plist:
    pushq	%rbp
    movq	%rsp, %rbp
    subq	$72, %rsp
    movq	%rdi, -56(%rbp)
    movq	%rsi, -64(%rbp)
    movq	%rdx, -72(%rbp)
    movq	-72(%rbp), %rax
    movq	%rax, -24(%rbp)
    movq	-56(%rbp), %rax
    movq	%rax, -40(%rbp)
    jmp	L51
L56:
    movq	-40(%rbp), %rax
    movq	%rax, %rdi
    call	sqrtllu
    movq	%rax, -16(%rbp)
    movq	$3, -32(%rbp)
    jmp	L52
L55:
    movq	-40(%rbp), %rax
    movl	$0, %edx
    divq	-32(%rbp)
    movq	%rdx, -8(%rbp)
    cmpq	$0, -8(%rbp)
    je	L58
    addq	$2, -32(%rbp)
L52:
    movq	-32(%rbp), %rax
    cmpq	-16(%rbp), %rax
    jbe	L55
    movq	-24(%rbp), %rax
    leaq	8(%rax), %rdx
    movq	%rdx, -24(%rbp)
    movq	-40(%rbp), %rdx
    movq	%rdx, (%rax)
    jmp	L54
L58:
    nop
L54:
    addq	$2, -40(%rbp)
L51:
    movq	-40(%rbp), %rax
    cmpq	-64(%rbp), %rax
    jbe	L56
    movq	-24(%rbp), %rax
    movq	$0, (%rax)
    movq	-24(%rbp), %rdx
    movq	-72(%rbp), %rax
    subq	%rax, %rdx
    movq	%rdx, %rax
    sarq	$3, %rax
    leave
    ret
    .section	.rodata
LC0:
    .string	"1234111127"
LC1:
    .string	"1234111111"
    .text
    .globl	main
.globl _start
_start:
    pushq	%rbp
    movq	%rsp, %rbp
    pushq	%rbx
    subq	$136, %rsp
    movl	%edi, -132(%rbp)
    movq	%rsi, -144(%rbp)
    movq	$40, %rax
    movq	%rax, -24(%rbp)
    xorl	%eax, %eax
    movl	$LC0, %edi
    movl	$0, %eax
    call	str2llu
    movq	%rax, %rbx
    movl	$LC1, %edi
    movl	$0, %eax
    call	str2llu
    movq	%rax, %rcx
    leaq	-112(%rbp), %rax
    movq	%rax, %rdx
    movq	%rbx, %rsi
    movq	%rcx, %rdi
    movl	$0, %eax
    call	plist
    movl	%eax, -116(%rbp)
    movq	-112(%rbp), %rax
    cmpq	$1234111117, %rax
    jne	L60
    movq	-104(%rbp), %rax
    cmpq	$1234111121, %rax
    jne	L60
    movq	-96(%rbp), %rax
    cmpq	$1234111127, %rax
    jne	L60
    movq	-88(%rbp), %rax
    testq	%rax, %rax
    je	L61
L60:
    call	abort
L61:
    movl	$0, %edi
    call	exit

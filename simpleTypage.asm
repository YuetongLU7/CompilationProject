extern printf, atoi, atof

section .data

X: dq 0
Y: dq 0
Z: dq 0
E: dq 0
LC0: dq 0x3DDB7CDFD9D7BDBB ; 1.0e-10

argv: dq 0
fmt_int:db "%d", 10, 0
fmt_double: db "%.12f", 10, 0

global main
section .text

main:
push rbp
mov [argv], rsi

mov rbx, [argv]
mov rdi, [rbx + 8]
call atoi
mov [X], rax
mov rbx, [argv]
mov rdi, [rbx + 16]
call atof
movsd [Y], xmm0
mov rbx, [argv]
mov rdi, [rbx + 24]
call atof
movsd [Z], xmm0

movsd xmm0, [LC0]
movsd [E], xmm0
mov rax, [X]
cvtsi2sd xmm0, rax
movsd xmm1, xmm0
movsd xmm0, [Y]
addsd xmm0, xmm1
movsd xmm1, xmm0
movsd xmm0, [E]
subsd xmm0, xmm1
movsd [Z], xmm0

movsd xmm0, [Z]
cvttsd2si rax, xmm0
mov rdi, fmt_int
mov rsi, rax
xor rax, rax
call printf


pop rbp
ret



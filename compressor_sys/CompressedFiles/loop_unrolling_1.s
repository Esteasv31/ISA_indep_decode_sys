# Compilation provided by Compiler Explorer at https://godbolt.org/
iirfilter:
push    {r7}
sub     sp, sp, #36
add     r7, sp, #0
str     r0, [r7, #20]
str     r1, [r7, #16]
str     r2, [r7, #12]
str     r3, [r7, #8]
vstr.32 s0, [r7, #4]
0
0
b       .L2
.L3:
2
4
6
8
10
12
14
16
18
20
22
24
26
28
30
32
16
32
vldr.32 s14, [r3]
6
34
36
vmul.f32        s15, s13, s15
32
38
32
12
adds    r3, r3, #8
34
40
32
38
32
42
34
adds    r3, r3, #16
40
32
44
32
vldr.32 s14, [r3]
22
34
adds    r3, r3, #12
40
32
44
46
ldr     r3, [r7, #20]
10
48
2
4
6
8
10
12
14
16
18
20
22
24
26
28
30
32
16
32
vldr.32 s14, [r3]
6
34
36
vmul.f32        s15, s13, s15
32
38
32
12
adds    r3, r3, #8
34
40
32
38
32
42
34
adds    r3, r3, #16
40
32
44
32
vldr.32 s14, [r3]
22
34
adds    r3, r3, #12
40
32
44
46
ldr     r3, [r7, #20]
10
48
ldr     r3, [r7, #28]
adds    r3, r3, #2
str     r3, [r7, #28]
.L2:
ldr     r2, [r7, #28]
ldr     r3, [r7, #16]
cmp     r2, r3
blt     .L3
nop
nop
adds    r7, r7, #36
mov     sp, r7
ldr     r7, [sp], #4
bx      lr

.archarmv8-a
.file "dot_and_cross_product.c"
0
.global dotProduct
.type dotProduct,%function
dotProduct:
sub sp,sp,#32
str x0,[sp,8]
str x1,[sp]
str wzr,[sp,24]
str wzr,[sp,28]
b .L2
.L3:
2
4
ldr w1,[x0]
2
6
8
10
str w0,[sp,24]
12
lsl x0,x0,2
4
ldr w1,[x0]
12
lsl x0,x0,2
6
8
10
str w0,[sp,24]
ldr w0,[sp,28]
add w0,w0,2
str w0,[sp,28]
.L2:
ldr w0,[sp,28]
cmp w0,2
ble .L3
ldr w0,[sp,24]
14
.size dotProduct,.-dotProduct
.align 2
.global crossProduct
.type crossProduct,%function
crossProduct:
sub sp,sp,#32
str x0,[sp,24]
str x1,[sp,16]
str x2,[sp,8]
16
18
20
mul w1,w1,w0
22
ldr w2,[x0]
ldr x0,[sp,16]
24
mul w0,w2,w0
sub w1,w1,w0
ldr x0,[sp,8]
str w1,[x0]
22
18
ldr w0,[x0]
mul w2,w1,w0
ldr x0,[sp,24]
18
20
26
add x0,x0,4
28
ldr x0,[sp,24]
18
24
mul w2,w1,w0
16
18
ldr w0,[x0]
26
add x0,x0,8
28
nop
14
.size crossProduct,.-crossProduct
30
.LC2:
.string "Dotproduct:"
.align 3
.LC3:
.string "%d\n"
.align 3
.LC4:
.string "Crossproduct:"
.align 3
.LC5:
.string "%d"
0
.global main
.type main,%function
main:
stp x29,x30,[sp,-80]!
add x29,sp,0
adrp x0,:got:__stack_chk_guard
ldr x0,[x0,#:got_lo12:__stack_chk_guard]
ldr x1,[x0]
str x1,[x29,72]
mov x1,0
adrp x0,.LC0
add x1,x0,:lo12:.LC0
add x0,x29,24
32
34
adrp x0,.LC1
add x1,x0,:lo12:.LC1
add x0,x29,40
32
34
adrp x0,.LC2
add x0,x0,:lo12:.LC2
bl puts
36
bl dotProduct
mov w1,w0
adrp x0,.LC3
add x0,x0,:lo12:.LC3
bl printf
adrp x0,.LC4
add x0,x0,:lo12:.LC4
bl puts
add x2,x29,56
36
bl crossProduct
str wzr,[x29,20]
b .L7
.L8:
ldrsw x0,[x29,20]
lsl x0,x0,2
add x1,x29,56
ldr w1,[x1,x0]
adrp x0,.LC5
add x0,x0,:lo12:.LC5
bl printf
ldr w0,[x29,20]
add w0,w0,1
str w0,[x29,20]
.L7:
ldr w0,[x29,20]
cmp w0,2
ble .L8
mov w0,10
bl putchar
mov w0,0
adrp x1,:got:__stack_chk_guard
ldr x1,[x1,#:got_lo12:__stack_chk_guard]
ldr x2,[x29,72]
ldr x1,[x1]
eor x1,x2,x1
cmp x1,0
beq .L10
bl __stack_chk_fail
.L10:
ldp x29,x30,[sp],80
ret
.size main,.-main
30
.LC0:
.word 3
.word -5
.word 4
.align 3
.LC1:
.word 2
.word 6
.word 5
.text
.ident "GCC:(Ubuntu/Linaro7.5.0-3ubuntu1~18.04)7.5.0"
.section .note.GNU-stack,"",@progbits

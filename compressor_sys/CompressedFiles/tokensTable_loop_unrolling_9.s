movs    r3, #0
str     r3, [r7, #28]
ldr     r3, [r7, #12]
ldr     r2, [r3, #4]      @ float
ldr     r3, [r7, #12]
str     r2, [r3]  @ float
ldr     r3, [r7, #12]
adds    r3, r3, #4
ldr     r2, [r7, #12]
ldr     r2, [r2, #8]      @ float
str     r2, [r3]  @ float
ldr     r3, [r7, #20]
vldr.32 s14, [r3]
ldr     r3, [r7, #12]
adds    r3, r3, #8
vldr.32 s15, [r7, #4]
vmul.f32        s15, s14, s15
vstr.32 s15, [r3]
ldr     r3, [r7, #8]
ldr     r2, [r3, #4]      @ float
ldr     r3, [r7, #8]
str     r2, [r3]  @ float
ldr     r3, [r7, #8]
adds    r3, r3, #4
ldr     r2, [r7, #8]
ldr     r2, [r2, #8]      @ float
str     r2, [r3]  @ float
ldr     r3, [r7, #12]
vldr.32 s14, [r3]
ldr     r3, [r7, #40]
adds    r3, r3, #8
vldr.32 s15, [r3]
ldr     r3, [r7, #8]
adds    r3, r3, #8
vldr.32 s13, [r3]
ldr     r3, [r7, #40]
adds    r3, r3, #4
vldr.32 s15, [r3]
vadd.f32        s15, s14, s15
vstr.32 s15, [r3]
vldr.32 s15, [r3]
vmul.f32        s15, s13, s15
vldr.32 s14, [r3]
ldr     r3, [r7, #8]
vsub.f32        s15, s14, s15
vstr.32 s15, [r3]
ldr     r3, [r7, #8]
ldr     r2, [r3, #8]      @ float
adds    r3, r3, #4
str     r3, [r7, #20]

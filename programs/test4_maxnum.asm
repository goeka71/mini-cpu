ADDI r0 r6 4
ST r0 r6 10
ADDI r0 r6 9
ST r0 r6 11
ADDI r0 r6 2
ST r0 r6 12
ADDI r0 r6 7
ST r0 r6 13
ADDI r0 r6 5
ST r0 r6 14

ADDI r0 r1 16
ADDI r0 r2 11
ADD r1 r1 r1
ADDI r2 r2 -1
BNE r2 r0 -3

ADD r0 r0 r3
ADD r0 r0 r4
ADDI r0 r5 5

ADDI r5 r5 -1
LD r5 r4 10
SUB r3 r4 r7
AND r1 r7 r6
BEQ r6 r0 1
ADD r4 r0 r3
BNE r5 r0 -7
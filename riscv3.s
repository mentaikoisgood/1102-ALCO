###########
#Fibonacci#
###########

.globl __start

.data
      inputStr: .string "Input a number: ";
      outputStr: .string "fibonacci: ";
      
.text

__start:
    li t0, 0
    li t1, 1
    #print "Input a number:"
    li a7, 4
    la a1, inputStr
    ecall
    #read an integer and moves it to register  t3
    li a7, 5
    ecall
    mv t3, a0
    #print new line
    li a7, 11
    li a1, '\n'
    ecall
    #print value in t3
    li a7, 1
    mv a1, t3
    ecall
    
    #fib
fib:
    beq t3, zero, finish
    add t2, t1, t0
    mv t0, t1
    mv t1, t2
    addi t3, t3, -1
    j fib
finish:
    #print output
    li a7, 4
    la a1, outputStr
    ecall
    #print result in t0
    li a7, 1
    mv a1, t0
    ecall
    #end program with 0
    li a7, 10
    ecall
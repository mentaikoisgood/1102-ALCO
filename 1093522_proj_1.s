.globl main

.data
      inputStr: .string "Input a number: ";
      outputStr: .string "The damage: ";
      
.text

main:

    #print "Input a number:"
    li a0, 4
    la a1, inputStr
    ecall
    #read an integer and moves it to register  t3
    li a0, 5
    ecall
    mv t3, a0
    #print new line
    li a0, 11
    li a1, '\n'
    ecall
    #print value in t3
    li a0, 1
    mv a1, t3
    ecall

        addi    sp,sp,-32
        sw      ra,28(sp)
        sw      s0,24(sp)
        addi    s0,sp,32
        #li      a5,1000
        mv      a5, t3
        sw      a5,-20(s0)
        

        
        lw      t4,-20(s0)
        call    F
        sw      t4,-24(s0)
        lw      ra,28(sp)
        lw      s0,24(sp)
        addi    sp,sp,32
        jr      ra

              
F:      
        addi    sp,sp,-32
        sw      ra,28(sp)
        sw      s0,24(sp)
        sw      s1,20(sp)
         
        addi    s0,sp,32 
        sw      t4,-20(s0)
        lw      a4,-20(s0)
        li      a5,20     
     
        ble     a4,a5,L2          #if x<=20, GOTO L2

        lw      a5,-20(s0)        #a5 = x 
        slli    s1,a5,1           #a5 = 2*x

        lw      a4,-20(s0)        #a4 = x
        li      a5,5              
        div     a5,a4,a5          #a5 = x / 5
       
        mv      t4,a5             #t4 = x / 5
        call    F                 #call F(x/5)  
        mv      a5,t4             #a5 = t4
        add     a5,s1,a5          #a5 = 2*x + F(x/5)
        j       L3
L2:
        lw      a4,-20(s0)
        li      a5,10
        ble     a4,a5,L4          #if x<=10, GOTO L4
        lw      a4,-20(s0)        #a4 = x
        li      a5,20             
        bgt     a4,a5,L4          #if x>20, GOTO L4
        lw      a5,-20(s0)        
        addi    a5,a5,-2          #a5 = x-2
        mv      t4,a5             #t4 = x-2
        call    F                 #call F(x-2)
        mv      s1,t4             #s1 = t4
        lw      a5,-20(s0)        #a5 = x 
        addi    a5,a5,-3          #a5 = x-3
        mv      t4,a5             #t4 = x-3
        call    F                 #call F(x-3)
        mv      a5,t4             #a5 = t4
        add     a5,s1,a5          #a5 = F(x-2) + F(x-3)
        j       L3
L4:
        lw      a4,-20(s0)        #a4 = x
        li      a5,1                 
        ble     a4,a5,L5          #if x<=1, GOTO L5

        lw      a4,-20(s0)        
        li      a5,10             
        bgt     a4,a5,L5          #if x>10, GOTO L5

        lw      a5,-20(s0)        #a5 = x
        addi    a5,a5,-1          #a5 = x-1
        mv      t4,a5             #t4 = x-1

        call    F                 #call F(x-1) ,並存到t4

        mv      s1,t4             #s1 = t4

        lw      a5,-20(s0)        
        addi    a5,a5,-2          #a5 = x-2
        mv      t4,a5             #t4 = x-2
        call    F                 #call F(x-2)
        
        mv      a5,t4             #a5 =  t4
        
        add     a5,s1,a5          #a5 = F(x-1)+ F(x-2)
                     
        j       L3                
L5:
        lw      a5,-20(s0)          
        bnez    a5,L6             #GOTO L6
        li      a5,1              
        j       L3
L6:
        lw      a4,-20(s0)
        li      a5,1
        bne     a4,a5,L7          #if x!=1, GOTO L7
        li      a5,5
        j       L3
L7:
        li      a5,-1
L3:
        mv      t4, a5            #t4 = a5
        mv      a1, t4            #a1 = t4

        j  finish


        

        
L10: 
        li a5, -100
        j  finish


finish:

    #print output
    li a0, 4
    la a1, outputStr
    ecall

    #print result in t0
    li a0, 1
    mv a1, t4
    ecall
        lw      ra,28(sp)
        lw      s0,24(sp)
        lw      s1,20(sp)
        addi    sp,sp,32
        jr      ra

    #end program with 0
    li a0, 10
    ecall

    


          

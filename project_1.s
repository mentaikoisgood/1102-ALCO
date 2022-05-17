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

    addi    sp,sp,-20    #空出空間儲存變數 因為在這個main裡面 ，有3個暫存器ra,s0,t3  只存活在這個main裡
    sw      ra,16(sp)   
    sw      s0,12(sp)       
    sw      t3, 8(sp)    #Register的東西(x) 放到 Memory
    lw      t4, 8(sp)    #Memory的東西 載到 Register
    call    F            #call F(x) 
    sw      t4, 4(sp)    #F(x) return 的值(t4)
    call    finish
    lw      t3, 8(sp)
    lw      s0,12(sp)        
    lw      ra,16(sp)       
    addi    sp,sp,20
    jr      ra           #jr 會跳到 某行程式 (某行程式就是下一個指令。某行程式的地址會存到$ra變數)
                         #使用stack pointer可以讓Register的內容回到跟還沒call F(x)的一樣
              
F:      
    addi    sp,sp,-20        
    sw      ra,16(sp)
    sw      s0,12(sp)
    sw      s1,8(sp)     
    sw      t4,4(sp)
    lw      a4,4(sp)
    li      a5,20      
    ble     a4,a5,L2          #if x<=20, GOTO L2
    lw      a5,4(sp)          #a5 = x                      ############################
    slli    s1,a5,1           #a5 = 2*x                    ###compute 2 * x + F(x/5)###
    lw      a4,4(sp)          #a4 = x                      ###compute 2 * x + F(x/5)###
    li      a5,5                                           ###compute 2 * x + F(x/5)###
    div     a5,a4,a5          #a5 = x / 5                  ###compute 2 * x + F(x/5)###
    mv      t4,a5             #t4 = x / 5                  ###compute 2 * x + F(x/5)###
    call    F                 #call F(x/5)                 ###compute 2 * x + F(x/5)###
    mv      a5,t4             #a5 = t4                     ###compute 2 * x + F(x/5)###
    add     a5,s1,a5          #a5 = 2*x + F(x/5)           ############################
    j       L3
L2:
    lw      a4,4(sp)
    li      a5,10
    ble     a4,a5,L4          #if x<=10, GOTO L4          
    lw      a4,4(sp)          #a4 = x                      
    li      a5,20                                          
    bgt     a4,a5,L4          #if x>20, GOTO L4            
    lw      a5,4(sp)                                       ###############################
    addi    a5,a5,-2          #a5 = x-2                    ###compute F(x - 2) + F(x - 3)#
    mv      t4,a5             #t4 = x-2                    ###compute F(x - 2) + F(x - 3)#
    call    F                 #call F(x-2)                 ###compute F(x - 2) + F(x - 3)#
    mv      s1,t4             #s1 = t4                     ###compute F(x - 2) + F(x - 3)#
    lw      a5,4(sp)          #a5 = x                      ###compute F(x - 2) + F(x - 3)#
    addi    a5,a5,-3          #a5 = x-3                    ###compute F(x - 2) + F(x - 3)#
    mv      t4,a5             #t4 = x-3                    ###compute F(x - 2) + F(x - 3)#
    call    F                 #call F(x-3)                 ###compute F(x - 2) + F(x - 3)#
    mv      a5,t4             #a5 = t4                     ###compute F(x - 2) + F(x - 3)#
    add     a5,s1,a5          #a5 = F(x-2) + F(x-3)        ###############################
    j       L3
L4:
    lw      a4,4(sp)        #a4 = x                
    li      a5,1                 
    ble     a4,a5,L5          #if x<=1, GOTO L5
    lw      a4,4(sp)        
    li      a5,10             
    bgt     a4,a5,L5          #if x>10, GOTO L5                    
    lw      a5,4(sp)          #a5 = x                      ###############################
    addi    a5,a5,-1          #a5 = x-1                    ###compute F(x - 1) + F(x - 2)#
    mv      t4,a5             #t4 = x-1                    ###compute F(x - 1) + F(x - 2)#
    call    F                 #call F(x-1) ,並存到t4        ###compute F(x - 1) + F(x - 2)#
    mv      s1,t4             #s1 = t4                     ###compute F(x - 1) + F(x - 2)#
    lw      a5,4(sp)                                       ###compute F(x - 1) + F(x - 2)#
    addi    a5,a5,-2          #a5 = x-2                    ###compute F(x - 1) + F(x - 2)#
    mv      t4,a5             #t4 = x-2                    ###compute F(x - 1) + F(x - 2)#
    call    F                 #call F(x-2)                 ###compute F(x - 1) + F(x - 2)#
    mv      a5,t4             #a5 =  t4                    ###compute F(x - 1) + F(x - 2)#
    add     a5,s1,a5          #a5 = F(x-1)+ F(x-2)         ###############################
    j       L3                
L5:
    lw      a5,4(sp)                                     
    bne     a5, zero, L6      #GOTO L6 if a5!=0            
    li      a5,1                                           ###x=0, return 1###
    j       L3
L6:
    lw      a4,4(sp)
    li      a5,1
    bne     a4,a5,L7          #if x!=1, GOTO L7             
    li      a5,5                                           ###x=1, return 5###
    j       L3
L7:                                                        
    li      a5,-1                                          ###x=-1, otherwise###

L3:                                                        
    mv      t4, a5            #t4 = a5
    lw      s1,8(sp)
    lw      s0,12(sp)
    lw      ra,16(sp)
    addi    sp,sp,20
    jr      ra


finish:
    #print output
    li a0, 4
    la a1, outputStr
    ecall

    #print result in t4
    li a0, 1
    mv a1, t4
    ecall

    #end program with 0
    li a0, 10
    ecal

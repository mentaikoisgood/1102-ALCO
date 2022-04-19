# 1102-ALCO PROJECT1

## Introduction

$$
F(x) =
\begin{cases} 
2 \cdot x + F(\frac{x}{5}),\quad x > 20\\
F(x-2) + F(x-3),\quad  10 < x \leq 20\\
F(x-1) + F(x-2),\quad  1 < x \leq 10\\
1,\quad  x = 0\\
5,\quad  x = 1\\
-1,\quad otherwise
\end{cases}
$$

## Example

+ Input Format
    + The input file consists of 1 line which gives the value of x. The input of the above example is:
			Input a number:
			3

+ Output Format
    + The program will only print the F(x) (damage value) you calculated. The output of the above example is:
			The damage:
			11

+ More Example

| Input  | The damage |
| ------------- | ------------- |
| 8  | 118  |
| 56 | 421  |
| 123 | 311  |
| -500  | -1  |

## RISC-V Simulator

使用 jupiter [下載點](https://github.com/andrescv/Jupiter "下載點")



## 程式碼說明
> a0: 固定為存system call 的call Number
> t3: 儲存Input number: (x)的 Register
> t4: 儲存The damage: f(x)的 Register

C++ code -  main:

	int main(){
		int num;
		cin >> num;
		cout << F(num) << endl;
		return 0;
	}
	

RISC-V - main:

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
    	addi    sp,sp,-32      #空出位置儲存變數
    	sw      ra,28(sp)
    	sw      s0,24(sp)
    	addi    s0,sp,32
    	sw      t3,-20(s0)
    	lw      t4,-20(s0)
    	call    F
    	sw      t4,-24(s0)
    	call    finish
    	lw      ra,28(sp)
    	lw      s0,24(sp)
    	addi    sp,sp,32
    	jr      ra

RISC-V - finish:

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
    	ecall



C++ code -  F(x):
		
	int F(int x){
		if ( x > 20 )                        // F(x) = 2 * x + F(x/5), x > 20 
			return 2 * x + F(x/5);
	
		else if ( x > 10 && x <= 20 )        // F(x) = F(x-2) + F(x-3), 10 < x <= 20 
			return F(x - 2) + F(x - 3);
	
		else if ( x > 1 && x <= 10)          // F(x) = F(x-1) + F(x-2), 1 < x <= 10 
			return F(x - 1) + F(x - 2);
	
		else if( x == 0 )                    // F(x) = 1, x = 0 
			return 1;
	
		else if( x == 1 )                    // F(x) = 5, x = 1 
			return 5;
			
		else                                 // F(x) = -1, otherwise 
			return -1;
	}

RISC-V - F(x):

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
    	lw      ra,28(sp)
    	lw      s0,24(sp)
    	lw      s1,20(sp)
    	addi    sp,sp,32
    	jr      ra        



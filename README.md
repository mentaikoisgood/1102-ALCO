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




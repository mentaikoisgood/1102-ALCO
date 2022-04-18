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

>a0 固定為存system call 的call Number

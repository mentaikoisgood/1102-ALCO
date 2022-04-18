# 1102-ALCO PROJECT1

## Introduction
 $$\bar{x}$$


$$
f(x)=
\begin{cases}
1/d_{ij} & \quad \text{when $d_{ij} \leq 160$}\\ 
0 & \quad \text{otherwise}
\end{cases}
$$

## Example
Assume x is 3. By the equation shown above, the condition 1<x ≤10 holds for F(3) and the program has to calculate F(x-1) + F(x-2) = F(2) + F(1). Then the program will recursively calculate F(2) and F(1), respectively. F(2) also satisfy the condition 1<x ≤10 and will be calculated as F(2) = F(1) + F(0) = 5 + 1 = 6. We then obtain F(1) = 5. Finally, the recursive program will give the final result F(3) = F(2) + F(1) = 6 + 5 = 11.

Input Format
The input file consists of 1 line which gives the value of x. The input of the above example is:
Input a number:
3
Output Format
The program will only print the F(x) (damage value) you calculated. The output of the above example is:
The damage:
11
## RISC-V Simulator

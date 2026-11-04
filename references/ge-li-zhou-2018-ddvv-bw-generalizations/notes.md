# Notes: Ge, Li, Zhou, arXiv:1807.07307

> **Theorem 4.4.** Let $\{E_1,\dots,E_{m-1}\}$ be a Clifford algebra on $\mathbb R^l$, i.e. $E_1,\dots,E_{m-1}\in O(l)$ are real skew-symmetric orthogonal matrices satisfying $E_iE_j+E_jE_i=-2\delta_{ij}I_l$. Let $B_1,\dots,B_M\in\mathop{\mathrm{span}}\{E_1,\dots,E_{m-1}\}$. Then $\sum_{r,s=1}^M\lVert[B_r,B_s]\rVert^2\le\frac4l\big(1-\frac1N\big)\big(\sum_{r=1}^M\lVert B_r\rVert^2\big)^2$, $N=\min\{m-1,M\}$. Equality (case $m-1\le M$) iff $e_1,\dots,e_{m-1}$ are orthogonal with the same norm, $e_i:=(\langle E_i,B_1\rangle,\dots,\langle E_i,B_M\rangle)\in\mathbb R^M$. (p. 17, line 1000 of the text dump)

> **Theorem 4.3.** The symmetric analogue for a Clifford system $(P_0,\dots,P_m)$ on $\mathbb R^{2l}$, constant $\tfrac2l(1-\tfrac1N)$, $N=\min\{m+1,M\}$.

**Proof ingredient.** Lemma 4.1: $\sum_{r,s}\big(\sum_ib_i^rb_i^s\big)^2\ge\tfrac1N\big(\sum_{r,i}(b_i^r)^2\big)^2$, $N=\min\{\lvert I\rvert,\lvert R\rvert\}$, the Cauchy–Schwarz step on the Gram matrix of coefficients.

**Also in the paper.** DDVV for arbitrary real, complex and quaternionic matrices (Section 2), and the Böttcher–Wenzel inequality for quaternionic matrices, $\lVert[X,Y]\rVert^2\le4\lVert X\rVert^2\lVert Y\rVert^2$ (Theorem 3.5).

**For this project.** With $B_r=E_r/\sqrt l$ orthonormal, the bound is $\tfrac4l(1-\tfrac1q)q^2$ for a $q$-dimensional Clifford subspace, whose isotropy $\sum_rB_r^{\mathsf T}B_r=\tfrac ql I$ is exactly spread. This is the extreme opposite to the star and matches the bracket identity of [the D6 note](../../reviews/2026-09-26-I73-class-ceiling.md) at $\mathop{\mathrm{tr}}(A^2)=q^2/l$.

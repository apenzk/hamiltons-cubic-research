# Notes, Ge–Tao–Zhou 2024

$Q(p,q)$: symmetric $n\times n$ matrices $\begin{pmatrix}0&A\\A^{\mathsf T}&0\end{pmatrix}$ with $A$ of size $p\times q$, $n=p+q$ (p. 3).

> **Theorem 1.1.** Suppose $B_1,\dots,B_m\in Q(p,q)$. Then $\sum_{r,s=1}^m\lVert[B_r,B_s]\rVert^2\le\tfrac12\big(\sum_{r=1}^m\lVert B_r\rVert^2\big)^2$. Equality iff, up to the $O(n)\times O(m)$ action, $(B_1,\dots,B_m)=(\lambda\,\mathrm{diag}(C_1,0),\lambda\,\mathrm{diag}(C_2,0),0,\dots,0)$ with $C_1,C_2$ the explicit $4\times4$ matrices of p. 4; only possible when $p,q\ge2$.

> **Theorem 1.2.** Suppose $B_1,\dots,B_m\in Q(n-1,1)$ with $n\ge3$. Then $\sum_{r,s=1}^m\lVert[B_r,B_s]\rVert^2\le\tfrac{d-1}{2d}\big(\sum_{r=1}^m\lVert B_r\rVert^2\big)^2$, where $d=\dim\mathop{\mathrm{Span}}\{B_1,\dots,B_m\}$.

Proof method (section 2): Ge–Tang, reducing to $f_Q(x)=\sum x_\alpha x_\beta\lVert[\hat Q_\alpha,\hat Q_\beta]\rVert^2\le c(\sum x_\alpha)^2$ on the simplex for $Q\in O(N)$, with a Lagrange/induction step on the active index set $I$ (Lemmas 2.1–2.3).

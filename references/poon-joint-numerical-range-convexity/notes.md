# Notes, Poon, Convexity of the joint numerical range

For an $m$-tuple $A=(A_1,\dots,A_m)$ of $n\times n$ Hermitian matrices, the $k$-th joint numerical range is $W_k(A)=\{(\operatorname{tr}(X^*A_1X),\dots,\operatorname{tr}(X^*A_mX)):X\in\mathbb C^{n\times k},X^*X=I_k\}$. $J_k$ is the rank-$k$ projection $I_k\oplus0$ and $U(J_k)$ its unitary orbit.

> **Theorem 1.2.** Let $A=(A_1,\dots,A_m)$ be an $m$-tuple of $n\times n$ Hermitian matrices. Then $W_k(A)$ is convex if and only if for any $X\in\operatorname{conv}U(J_k)$ there exists $P\in U(J_k)$ so that $\operatorname{tr}A_jP=\operatorname{tr}A_jX$ for all $j=1,\dots,m$.

(page 2.) *This is the "relaxation to the convex hull is exact" statement, in the form the record's three-alignment relaxation tested and refuted at $\lvert J\rvert=3$.*

> **Theorem 4.2.** Suppose $A_1,A_2,A_3$ are $n\times n$ Hermitian matrices such that $\{I,A_1,A_2,A_3\}$ is linearly independent. Then there exists an $n\times n$ Hermitian matrix $A_4$ such that $W_1(A_1,A_2,A_3,A_4)$ is not convex.

(page 8.) *Three operators is where convexity of the joint range is generic; four is where it breaks.*

> **Theorem 5.1.** Let $A=(A_1,\dots,A_m)$ be an $m$-tuple of real symmetric matrices. Suppose $1\le k\le n/2$ and [the off-diagonal block condition of Theorem 2.2 holds over the reals]. Then $W_k(A)$ is convex.

(page 9, hypothesis abbreviated; the display is the real analogue of Theorem 2.2's $\lVert X\rVert\le\tfrac12$ condition on the off-diagonal block of a rank-$k$ projection.) *The real symmetric case is the record's.*

**What the paper cites**: Au-Yeung and Poon 1979 for the three-operator convexity, Westwick for the $c$-numerical range, and the projection-orbit tangent space computation of Theorem 2.3.

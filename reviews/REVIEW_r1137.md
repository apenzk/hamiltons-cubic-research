# REVIEW r1137: L246 Corollary 2, the support bound

Brief: [2026-09-25-L246c2-gate2-brief.md](2026-09-25-L246c2-gate2-brief.md). Log: [agent_logs/r1137.log](../agent_logs/r1137.log).

**Verdict: the inequality $s(s-1)\ge2(1+r)p$ is CONFIRMED and sharp. It follows without L246. The gloss "an extreme eigenspace fills at most a $\tfrac1{1+r}$ share" is false for $E_2$ when $r>1$ and needs rewording.**

## Item 1, step validity: CONFIRMED

- $A_2=rA_0$: from $\sum_c\lambda_cA_c=0$ with $\lambda_1=0$, $\lambda_0A_0+\lambda_2A_2=0$. Since $\lambda_0<0<\lambda_2$, $A_2=(-\lambda_0/\lambda_2)A_0=rA_0$ with $r>0$.
- Pair form: apply L246 to $F=E_0\oplus E_2$. An orthonormal basis of $F$ is the union of bases of $E_0,E_2$, so $A_F=A_0+A_2=(1+r)A_0$ and $\beta_i=(1+r)\alpha_i$ with the same eigenvectors. Dividing $(1+r)\alpha_j\le\sum_{i\ne j}\min(1,(1+r)\alpha_i)$ by $1+r>0$ gives the stated form.
- Support: $\psi^{\mathsf T}\psi=-\psi^2\succeq0$, so $\operatorname{range}A_0=\sum_{\psi}\operatorname{range}\psi$ (range of a sum of PSD matrices is the sum of ranges). A skew $\psi$ lies in $\Lambda^2S$ iff $\operatorname{range}\psi\subseteq S$. Hence $E_0\subseteq\Lambda^2S$ iff $\operatorname{range}A_0\subseteq S$, and such $S$ of dimension $s$ exists iff $\operatorname{rank}A_0\le s\le n$. The minimal choice is $S=\operatorname{range}A_0$.
- $\alpha_{\max}\le\tfrac{s-1}{1+r}$: take $j$ with $\alpha_j=\alpha_{\max}>0$ (if $\alpha_{\max}=0$ then $p=0$). Among the other $n-1$ eigenvalues at most $s-1$ are nonzero, each term is at most $\tfrac1{1+r}$, the zero ones contribute $0$.
- $2p\le s\,\alpha_{\max}$: $\operatorname{tr}\psi^{\mathsf T}\psi=2$ for unit $\psi$ under $\tfrac12\operatorname{tr}(x^{\mathsf T}y)$, so $\operatorname{tr}A_0=2p$, and the trace is a sum of at most $s$ nonzero eigenvalues each at most $\alpha_{\max}$.
- Lean: [support_bound](../lean/HamiltonsCubic/Results/L246PairIsotropy.lean) proves $2(1+r)p\le s(s-1)$ from $(1+r)a_{\max}\le s-1$, $2p\le s\,a_{\max}$, $s\ge0$, $r>0$. That is exactly the final arithmetic, and it is correct.

## Item 2, exclusion of $E_0=\Lambda^2\mathbb R^s$: CONFIRMED

- $p=\tfrac{s(s-1)}2$ in the bound gives $s(s-1)\ge(1+r)s(s-1)$, false for $s\ge2$ since $r>0$. For $s\le1$, $\Lambda^2\mathbb R^s=0$ is no eigenspace. So it is excluded for every $2\le s\le n$, for every $\Lambda^2S$ (not only the coordinate $\mathbb R^s$), under the hypothesis $\lambda_1=0$.
- $s=n$: $E_0=\Lambda^2\mathbb R^n$ leaves $E_1=E_2=0$, which the three-eigenvalue setting already excludes. The bound excludes it too, consistently. At $s=n$ the bound itself says $p\le\tfrac{n(n-1)}{2(1+r)}$, which is nontrivial.
- A direct argument: $\operatorname{range}A_2=\operatorname{range}A_0\subseteq S$ forces $E_2\subseteq\Lambda^2S=E_0$, contradicting $E_2\perp E_0$, $E_2\ne0$.

## Item 3, attainment and a simpler route: CONFIRMED sharp, and the corollary follows without L246

- **Simpler proof.** $\operatorname{range}A_2=\operatorname{range}(rA_0)\subseteq S$, so by the support equivalence $E_2\subseteq\Lambda^2S$ as well. $E_0\perp E_2$ gives $p+q\le\tfrac{s(s-1)}2$ with $q=\dim E_2=\tfrac12\operatorname{tr}A_2=rp$. Hence $(1+r)p\le\tfrac{s(s-1)}2$, the same bound, using only $A_2=rA_0$ and the support fact. It also gives the extra constraint that $rp$ is an integer. The L246 route is valid but unnecessary.
- Against the trivial $\dim E_0\le\dim\Lambda^2S$ ($2p\le s(s-1)$) the corollary is strictly stronger by the factor $1+r$.
- **Equality** holds iff $E_0\oplus E_2=\Lambda^2S$ (from the simpler proof). Examples in the givens' setting, $n\ge5$, $S=\mathbb R^4$, $E_1=\Lambda^2\mathbb R^n\ominus\Lambda^2\mathbb R^4$:
  - $r=1$: $E_0=\Lambda^+$, $E_2=\Lambda^-$, $A_0=A_2=\tfrac32I_4$, $12=2\cdot2\cdot3$.
  - $r=2$: $E_0=\operatorname{span}\{(e_{12}+e_{34})/\sqrt2,(e_{13}-e_{24})/\sqrt2\}$, $E_2$ its complement in $\Lambda^2\mathbb R^4$, $A_0=I_4$, $A_2=2I_4$, $\lambda_0=-2$, $\lambda_2=1$: $12=2\cdot3\cdot2$.
  - Both satisfy $\sum_cA_c=(n-1)I$ and $\sum_c\lambda_cA_c=0$. **Screen** (seconds, $n=5$, numpy): orthonormality, both identities and the equality confirmed for the $r=2$ case. Whether these operators satisfy the Bianchi identity is outside the givens and was not checked.

## Item 4, the share wording: REFUTED as worded, inequality unaffected

- For $E_0$ the gloss is faithful: $p\le\tfrac1{1+r}\cdot\tfrac{s(s-1)}2$.
- "**an** extreme eigenspace fills at most a $\tfrac1{1+r}$ share" is false for $E_2$ when $r>1$. In the $r=2$ example $E_2$ fills $4/6=\tfrac23$ of $\Lambda^2\mathbb R^4$, above $\tfrac1{1+r}=\tfrac13$. The correct share for $E_2$ is $\tfrac r{1+r}$ (by the simpler proof, or by $W\mapsto-W$, which sends $r\mapsto1/r$).
- **Correction, exact wording**: "$E_0$ fills at most a $\tfrac1{1+r}$ share of any $\Lambda^2S$ containing it, and $E_2$ at most an $\tfrac r{1+r}$ share. Each extreme eigenspace $E_c$ fills at most a $\tfrac{\lvert\lambda_c\rvert^{-1}}{\lvert\lambda_0\rvert^{-1}+\lambda_2^{-1}}$ share, attained exactly when $E_0\oplus E_2=\Lambda^2S$."

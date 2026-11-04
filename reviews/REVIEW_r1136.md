# REVIEW r1136: L246 Corollary 2, the support bound

Brief: [2026-09-25-L246c2-gate2-brief.md](2026-09-25-L246c2-gate2-brief.md). Log: [agent_logs/r1136.log](../agent_logs/r1136.log). Lean: `support_bound` in [L246PairIsotropy.lean](../lean/HamiltonsCubic/Results/L246PairIsotropy.lean) is the final arithmetic only (`nlinarith`), and it is correct as stated.

**Summary.** The inequality is TRUE and the proof is valid, but L246 is not needed: it follows from $A_2=rA_0$ and a dimension count. The bound is attained by a genuine algebraic Weyl tensor. The phrase "an extreme eigenspace" overstates for $E_2$ when $r>1$.

## 1. Step validity: CONFIRMED

- $A_2=rA_0$: at $\lambda_1=0$ the Ricci relation reads $\lambda_0A_0+\lambda_2A_2=0$, and $\lambda_0<0<\lambda_2$, so $A_2=(\lvert\lambda_0\rvert/\lambda_2)A_0=rA_0$ with $r>0$.
- Pair form: $A_{E_0\oplus E_2}=A_0+A_2=(1+r)A_0$ (isotropy is additive over an orthogonal sum), so $\beta_i=(1+r)\alpha_i$ with common eigenvectors, and dividing L246 by $1+r$ gives $\alpha_j\le\sum_{i\ne j}\min(\tfrac1{1+r},\alpha_i)$.
- Rank and support: $\psi^{\mathsf T}\psi=-\psi^2\succeq0$ has range equal to $\mathop{\mathrm{range}}\psi$, so $\mathop{\mathrm{range}}A_0=\sum_{\psi}\mathop{\mathrm{range}}\psi=:S_0$. A skew $\psi$ lies in $\Lambda^2S$ iff $\mathop{\mathrm{range}}\psi\subseteq S$. Hence $E_0\subseteq\Lambda^2S$ iff $S_0\subseteq S$, and some $S$ of dimension $s$ exists iff $\mathop{\mathrm{rank}}A_0\le s\le n$.
- $\alpha_{\max}\le\tfrac{s-1}{1+r}$: take $j$ at the maximum. At most $s-1$ other $\alpha_i$ are nonzero, each capped term is at most $\tfrac1{1+r}$, zeros contribute nothing.
- $2p=\mathop{\mathrm{tr}}A_0\le\mathop{\mathrm{rank}}A_0\cdot\alpha_{\max}\le s\,\alpha_{\max}$, since $A_0\succeq0$. Combining gives $2(1+r)p\le s(s-1)$.

## 2. Exclusion of $E_0=\Lambda^2\mathbb R^s$: CONFIRMED, with the range of $s$ made explicit

- With $p=\tfrac{s(s-1)}2$ the bound reads $r\,s(s-1)\le0$, false for every $s\ge2$ because $r>0$. For $s\le1$ the space $\Lambda^2S$ is zero and cannot be an eigenspace.
- At $s=n$ the case is excluded more cheaply: $E_0=\Lambda^2\mathbb R^n$ leaves no room for $E_1,E_2$, contradicting three eigenvalues. At $s=n$ the whole corollary is the trace identity: $\mathop{\mathrm{tr}}A_2=r\mathop{\mathrm{tr}}A_0$ gives $\dim E_2=rp$, and $p+rp+\dim E_1=\tfrac{n(n-1)}2$ gives the bound, strictly because $E_1\ne0$.

## 3. Attainment and simpler implication: REFUTED as a question of necessity (L246 is not needed); the bound is sharp

- **Simpler proof.** $A_2=rA_0$ with $r>0$ gives $\mathop{\mathrm{range}}A_2=\mathop{\mathrm{range}}A_0\subseteq S$, so by the support lemma of item 1, $E_2\subseteq\Lambda^2S$ as well. Also $\dim E_2=\tfrac12\mathop{\mathrm{tr}}A_2=rp$. The orthogonal sum $E_0\oplus E_2\subseteq\Lambda^2S$ then gives $p+rp\le\tfrac{s(s-1)}2$, which is Corollary 2. The L246 route yields the same inequality and no more.
- **Equality** holds iff $\Lambda^2S=E_0\oplus E_2$ (from the simpler proof), and then $A_0=\tfrac{s-1}{1+r}I_S$.
- **Attained by a Weyl tensor.** On $\mathbb R^4\subset\mathbb R^5$ take $W^+=W^-=\mathop{\mathrm{diag}}(2,-1,-1)$ in an orthonormal frame of $\Lambda^\pm$, extended by zero. Eigenvalues $-1$ (multiplicity 4), $0$ (4), $2$ (2), so $r=\tfrac12$, $s=4$, $p=4$: $s(s-1)=12=2(1+r)p$. Screen (seconds of numpy on this constructed object, a screen and nothing more): $A_0=2I_S$, $A_2=I_S$, $A_1=\mathop{\mathrm{diag}}(1,1,1,1,4)$, first Bianchi and Ricci both zero to machine precision.
- The bound is not implied by $\dim E_0\le\dim\Lambda^2S$ alone, which it strengthens by the factor $1+r$.

## 4. The share wording: PLAUSIBLE, correction required

- For $E_0$ the wording is faithful: $s(s-1)\ge2(1+r)p$ is $p\le\tfrac1{1+r}\dim\Lambda^2S$.
- "An extreme eigenspace" is not: the mirror argument for $E_2$ (with $A_0=\tfrac1rA_2$) gives $\dim E_2\le\tfrac r{1+r}\dim\Lambda^2S$, which exceeds $\tfrac1{1+r}$ when $r>1$.
- Correction, exact wording: replace "an extreme eigenspace fills at most a $\tfrac1{1+r}$ share of any $\Lambda^2S$ containing it" by "$E_0$ fills at most a $\tfrac1{1+r}$ share, and $E_2$ at most a $\tfrac r{1+r}$ share, of any $\Lambda^2S$ containing it (the two together fill at most all of it, since $E_0\oplus E_2\subseteq\Lambda^2S$)".
- Recommended addition to the proof line: "Equivalently, without L246: $\mathop{\mathrm{range}}A_2=\mathop{\mathrm{range}}A_0$, so $E_0\oplus E_2\subseteq\Lambda^2S$ and $\dim E_2=rp$; the bound is attained by $W^\pm=\mathop{\mathrm{diag}}(2,-1,-1)$ on $\mathbb R^4$."

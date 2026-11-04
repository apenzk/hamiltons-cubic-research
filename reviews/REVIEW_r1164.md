# REVIEW r1164: the Ricci requirement of the band and the product reduction

*Gate 2 on [the working file](2026-09-25-I73c-per-vector-rows.md) at 35c6a7eb, lines 197 and 199 to 201, brief [2026-09-25-ricci-requirement-gate2-brief.md](2026-09-25-ricci-requirement-gate2-brief.md). Argued from the definitions and the audited givens ([r1160](REVIEW_r1160.md), [r1146](REVIEW_r1146.md), the working file's lines 165, 181 to 189 and 195). One screen of a few seconds at $n=7$ on random skew matrices (no Weyl structure needed), reported as a screen only: $\lVert k\owedge g\rVert_{\mathrm{op}}^2=(n-2)\lvert k\rvert_F^2$ to $10^{-16}$, and the product identity to $10^{-16}$.*

## Verdict

| item | verdict |
|---|---|
| 1. the quantitative paragraph | PLAUSIBLE: the bound $n/(4\kappa)$ and the margin $(\kappa-n+5)/(32\kappa)$ are CONFIRMED, the stated source of $\lvert h_x\rvert^2\le\tfrac{n-2}2$ is wrong (it is $G\succeq0$, not $G\preceq\tfrac12I$) |
| 2. skew and symmetric parts, conventions | CONFIRMED |
| 3. the equivalence and "$Cx$ is large" | PLAUSIBLE: the equivalence is exact (and needs nothing about $Cx$), "$Cx$ is large" does not follow from $x^{\mathsf T}M_0x>x^{\mathsf T}M_2x$ and holds only on average over $V_+$, from $4T>p$ |
| 4. overreach | REFUTED in two places (the dichotomy "only through one of two facts", the two-sided balance), plus the unquantified "$O(1)$" |

## Item 1: the quantitative paragraph

- **$x^{\mathsf T}B_{\mathrm{Ric}}x=-\tfrac1{2(n-2)}\langle h_x,\mathring eh_x\rangle$**: bilinearity of $B_{\mathrm{Ric}}=-\tfrac1{2(n-2)}(\langle h_\alpha,\mathring eh_\beta\rangle)$ in the family's coefficients. CONFIRMED. $h_x$ is traceless ($\mathop{\mathrm{tr}}(uv)=-2\langle u,v\rangle=0$ for $u\in E_0$, $v\in E_2$), so r1160's bound applies to it.
- **The source of $\lvert h_x\rvert^2/(n-2)\le\tfrac12$ is misattributed.** $G\preceq\tfrac12I$ says $x^{\mathsf T}Gx\le\tfrac12$, which bounds nothing about $H$ from above. The bound comes from the other side: $G$ is the Gram matrix of the projected family, so $G\succeq0$, and for unit $x$, $0\le x^{\mathsf T}Gx=\tfrac12-\lvert h_x\rvert^2/(n-2)-\lVert\omega_x\rVert^2$, hence $\lvert h_x\rvert^2\le\tfrac{n-2}2-(n-2)\lVert\omega_x\rVert^2\le\tfrac{n-2}2$, i.e. $H\preceq\tfrac{n-2}2I$. The brief's hint names the right source. The units are those of the Gram: $x$ unit in the Euclidean coefficient norm, each pair $u\odot v$ of norm squared $\tfrac12$.
- **$\lvert x^{\mathsf T}B_{\mathrm{Ric}}x\rvert\le\tfrac1{2(n-2)}\cdot\tfrac n\kappa\cdot\tfrac{n-2}2=\tfrac n{4\kappa}$: CONFIRMED.** In the band $n-5<\kappa\lesssim n-2$, so this is $\tfrac14(1+O(1/n))$.
- **The margin in the same units: CONFIRMED.** Line 165 gives $\lambda_{\max}(L_e)\ge2\lambda_{\max}(B_{\mathrm{full}})$, so the factor between the two scales is $2$: $\lambda_{\max}(L_e)>\tfrac12$ is certified by $\lambda_{\max}(B)>\tfrac14$, and the $L_e$ margin $(\kappa-n+5)/(16\kappa)$ of line 182 becomes $(\kappa-n+5)/(32\kappa)$ per unit vector of $B$. This matches line 189's $T-\tfrac p4\ge p(\kappa-n+5)/(32\kappa)$ divided by $p$. With $\kappa\lesssim n-2$ at $\theta_0$ the margin is at most $3/(32(n-2))\approx3/(32n)$.
- **"About $n$ times too large"**: the ratio is $\tfrac n{4\kappa}\big/\tfrac3{32n}\approx\tfrac{8n}3$. Right in order, the constant is $8/3$.
- **The per-vector comparison is the right one for the trace route.** Line 188 averages over $V_+$ ($\dim V_+\le p$), so a per-unit-vector bound on $\lvert x^{\mathsf T}B_{\mathrm{Ric}}x\rvert$ on $V_+$ transfers to $\mathop{\mathrm{tr}}_{V_+}B_{\mathrm{Ric}}\ge-\dim V_+\cdot\max$, against $p$ times the margin.

## Item 2: the product paragraph

- **$(uv)^{\mathsf T}=v^{\mathsf T}u^{\mathsf T}=(-v)(-u)=vu$**, so $\tfrac12(X_x-X_x^{\mathsf T})=\tfrac12\sum x_{uv}[u,v]=\tfrac12Cx$ and $\tfrac12(X_x+X_x^{\mathsf T})=\sum x_{uv}\cdot\tfrac12\{u,v\}=-h_x$ with $h_{uv}=-\tfrac12\{u,v\}$ ([the projected-pair note](2026-09-23-I73c-projected-pair.md), line 9, $h=\mathop{\mathrm{Ric}}(Y_0)=-\tfrac12(UV+VU)$). CONFIRMED.
- **Orthogonality**: `skew_sym_split` in [ClassTraceTest.lean](../lean/HamiltonsCubic/Results/ClassTraceTest.lean) (line 99) states $\mathop{\mathrm{tr}}(X^{\mathsf T}X)=\mathop{\mathrm{tr}}(S^{\mathsf T}S)+\mathop{\mathrm{tr}}(K^{\mathsf T}K)$ for $S,K$ the skew and symmetric halves of any real square $X$, which is exactly $\lVert X_x\rVert_F^2=\tfrac14\lVert Cx\rVert_F^2+\lvert h_x\rvert_F^2$. The proof is a correct trace manipulation.
- **Conventions are consistent.** The record's $\lvert h\rvert$ is the Frobenius norm: the projected-pair note's $\lVert k\owedge g\rVert^2_{\mathrm{op}}=(n-2)\lvert k\rvert^2$ holds with $\lvert k\rvert=\lvert k\rvert_F$ (screened at $n=7$), and r1160's Casimir mass $2n\lvert h\rvert^2$ is also Frobenius. The display uses Frobenius on all three terms. **One caution for later use**: $M_c$ and $P_c$ live in the record's $\Lambda^2$ norm $\tfrac12\mathop{\mathrm{tr}}X^{\mathsf T}Y$, so $\lVert Cx\rVert_F^2=2\lVert Cx\rVert^2_{\Lambda^2}$ and $x^{\mathsf T}M_0x=\tfrac1{4\kappa}\lVert P_0Cx\rVert^2_{\Lambda^2}$ (with $a/\theta=1/\kappa$).

## Item 3: the equivalence and the size of $Cx$

- **The equivalence is exact and unconditional.** Given the identity, $\lvert h_x\rvert^2\le c\iff\lVert X_x\rVert_F^2\le\tfrac14\lVert Cx\rVert_F^2+c$ at every $x$, for every $c$. It uses nothing about $V_+$ and nothing about the size of $Cx$. It is a restatement, and the file should call it that.
- **"$Cx$ is large" does not follow from $x^{\mathsf T}M_0x>x^{\mathsf T}M_2x$.** That inequality with $M_2\succeq0$ gives only $P_0Cx\ne0$. An eigenvector of $B_{\mathrm{lead}}$ with a small positive eigenvalue can have small $P_0Cx$.
- **It does hold on average over $V_+$, from $4T>p$.** For an orthonormal eigenbasis $x_i$ of $V_+$, $\sum_ix_i^{\mathsf T}M_0x_i\ge\sum_ix_i^{\mathsf T}B_{\mathrm{lead}}x_i\ge T>\tfrac p4$, so $\sum_i\lVert P_0Cx_i\rVert^2_{\Lambda^2}>\kappa p$ and, with $\dim V_+\le p$, the mean of $\tfrac14\lVert Cx\rVert_F^2$ over the basis exceeds $\kappa/2\approx n/2$. So "almost entirely skew" is the right reading on average: the symmetric part must be small against a skew part of order $n$. The sentence should cite $4T>p$, not $x^{\mathsf T}M_0x>x^{\mathsf T}M_2x$, and say "on average over $V_+$".

## Item 4: conclusions beyond the support

- **"The band closes only through one of two facts": REFUTED as a dichotomy.** The harmful quantity is, per unit $x\in V_+$, $\tfrac1{4\kappa(n-2)}\big(C_0(h_x)-C_2(h_x)\big)$ (line 195's diagonal, polarised), and it enters only through its trace over $V_+$. It is small when the PRODUCT of the size of $h_x$ and the relative imbalance of its commutator masses is small on average over $V_+$. Moderate values of both (for instance $\lvert h_x\rvert^2$ of order $\sqrt n$ with relative imbalance of order $n^{-1/2}$) are neither of the two stated facts and suffice. Beyond that, the certificate route itself has other slack: positive contributions of $B_{\Lambda^4}$ or of $B_{\mathrm{Ric}}$ on part of $V_+$, and the gap between $\lambda_{\max}$ and the trace average over $V_+$. Correction: "the band closes through the trace route when $\mathop{\mathrm{tr}}_{V_+}$ of $(C_0-C_2)(h_x)$ is below $4\kappa(n-2)$ times $p$ times the margin, which holds in particular if the $h_x$ are small on $V_+$ or their masses lean to $E_2$".
- **The balance condition is one-sided: REFUTED as stated.** With r1160's sign, $x^{\mathsf T}B_{\mathrm{Ric}}x=\tfrac1{4\kappa(n-2)}(C_2-C_0)(h_x)$ is harmful only where $C_0>C_2$. $C_2(h_x)\ge C_0(h_x)$ helps. So the second fact should read $C_0(h_x)\le C_2(h_x)+$ (small), not $C_0\approx C_2$.
- **"$O(1)$ rather than $O(n)$" understates the first route.** Alone, with r1160's bound, the requirement is $\tfrac n{2\kappa(n-2)}\lvert h_x\rvert^2<\tfrac{\kappa-n+5}{32\kappa}$, i.e. $\lvert h_x\rvert^2<\tfrac{(n-2)(\kappa-n+5)}{16n}\lesssim\tfrac3{16}$ near $\theta_0$ and zero at the band's lower edge. So it is a small explicit constant that vanishes at $\kappa=n-5$, not merely $O(1)$. The same quantification carries into the product paragraph's "$+O(1)$".
- **"The requirement of the band" in paragraph 2** should be "the first route's requirement", following the correction above.
- **"Neither follows from the rows on file"**: consistent with what is on file (r1146 item 2 gives $\mathop{\mathrm{rank}}P_0C=p$ and nothing about anticommutators on $V_+$). PLAUSIBLE, unchecked beyond that.
- The Lean row "none: the pair matrix is not a layer object" is accurate. Only the identity is typed.

## Corrections owed to the working file

1. Line 197: "$G\preceq\tfrac12I$ (which gives $\lvert h_x\rvert^2/(n-2)\le\tfrac12$)" becomes "$G\succeq0$ (a Gram matrix), which gives $\lvert h_x\rvert^2/(n-2)\le\tfrac12$".
2. Line 197: replace "closes only through one of two facts" by the trace condition of item 4, with the two facts as sufficient special cases, and make the balance one-sided, $C_0(h_x)\le C_2(h_x)+$ small.
3. Lines 197 and 201: quantify "$O(1)$" as $\lvert h_x\rvert^2<(n-2)(\kappa-n+5)/(16n)$, vanishing at the lower edge.
4. Line 201: call the equivalence a restatement of the identity, and base "$Cx$ is large" on $4T>p$, on average over $V_+$ (mean $\tfrac14\lVert Cx\rVert_F^2>\kappa/2$), not on $x^{\mathsf T}M_0x>x^{\mathsf T}M_2x$.

# REVIEW r1167: blindness to anticommutators and the criticality prefactor

*Gate 2 reviewer r1167, brief [2026-09-25-blindness-prefactor-gate2-brief.md](2026-09-25-blindness-prefactor-gate2-brief.md), target [2026-09-25-I73c-per-vector-rows.md](2026-09-25-I73c-per-vector-rows.md) at a011da9c, the two paragraphs at lines 203 and 205–207. Analysis-only. One screen of seconds at $n=5$ on constructed objects, reported as a screen.*

## Verdicts

| item | verdict |
|---|---|
| 1. blindness paragraph | trace fact CONFIRMED, "only identity on file" REFUTED as worded, conclusion about $V_+$ PLAUSIBLE once restated |
| 2. prefactor identity | CONFIRMED |
| 3. crude bound and Casimir constant | CONFIRMED |
| 4. the stated gap | PLAUSIBLE: necessary, stated as sufficient, with the needed constant missing |

## Item 1

- **The trace fact is right.** $uv=\tfrac12[u,v]+\tfrac12\{u,v\}$, $\{u,v\}^{\mathsf T}=\{u,v\}$ for skew $u,v$, and $\operatorname{tr}(Sw)=\operatorname{tr}(w^{\mathsf T}S)=-\operatorname{tr}(Sw)$ for $S$ symmetric and $w$ skew. With $h_{uv}=-\tfrac12\{U,V\}$ (line 133) the symmetric part is $-2h_{uv}$.
- **The rows see only commutators, correctly.** $b_{ab}(x)=\tfrac12\sum\langle[\psi_\gamma,\psi_\delta],x\rangle^2$ is a square of a trilinear pairing of three skew matrices, and each such pairing is $\operatorname{tr}(\psi_\gamma\psi_\delta x)$ up to a constant, which sees only $[\psi_\gamma,\psi_\delta]$. The scope should read "pairings of a product against an element of $\Lambda^2$": a pairing of two products, $\operatorname{tr}(uv\,wz)$, contains $\tfrac14\operatorname{tr}(\{u,v\}\{w,z\})$ and sees the anticommutators.
- **"The only identity on file pairing anticommutators is criticality on symmetric directions" is false.** Two others are on file in the same note.
  - Line 91: $\mathcal R_x+\mathcal S_x=D(xx^{\mathsf T})$, giving $R_a(x)+S_a(x)=\operatorname{tr}(A_axx^{\mathsf T})$ with $S_a(x)$ the anticommutator mass of $x$ against $E_a$. Since $R_a(x)=\sum_bb_{ab}(x)$ (line 29), **the row sums fix the per-vector anticommutator masses** $S_a(x)=\operatorname{tr}(A_axx^{\mathsf T})-\sum_bb_{ab}(x)$. Line 141 already uses this: $\sum_v\lvert h_{uv}\rvert^2=S_2(u)$ is per-vector.
  - Line 193: Ricci-flatness, $\sum_\psi\lambda_\psi\psi\psi^{\mathsf T}=0$, is an identity on $\psi\psi^{\mathsf T}=-\tfrac12\{\psi,\psi\}$, giving $A_0=A_2$ on the symmetric family.
- **What survives.** The rows determine the diagonal of the anticommutator Gram (the masses $\sum_v\lvert h_{uv}\rvert^2$, hence its trace $S_{02}$) and nothing about its off-diagonal entries $\langle h_{uv},h_{u'v'}\rangle$, which are quartic. The band needs $\lvert h_x\rvert^2$ for $x$ in $V_+$, a restriction of the Gram that its diagonal does not control. **Correction**: replace "is invisible to them" and "the only one on file" by "the rows constrain the anticommutators only through the masses $S_a(x)$, via $\mathcal R_x+\mathcal S_x=D(xx^{\mathsf T})$. The restriction of the Gram $(\langle h_{uv},h_{u'v'}\rangle)$ to $V_+$ needs an identity with the cross terms, and the only one on file with them is criticality on symmetric directions."

## Item 2

- The action $T\mapsto\mathring T$, $\mathring T(h,h)=\sum_{\alpha,\beta}T_{\alpha\beta}\operatorname{tr}(e_\alpha he_\beta h)$ over a $\Lambda^2$-orthonormal basis, is linear and basis-independent, and it sends $\omega\otimes\omega$ to $\operatorname{tr}(\omega h\omega h)$. That is the record's convention: $P_c\mapsto Q_c$ and $W\mapsto\sum\lambda_cQ_c=\mathring W$.
- So $W^2\mapsto\sum\lambda_c^2Q_c$, and $W^\#=\sum\lambda_a\lambda_bB_{ab}\mapsto\sum\lambda_a\lambda_b\mathring B_{ab}$ with $\mathring B_{ab}$ as stated. Applying it to $W^\#=\theta W-W^2$ is legitimate because the identity holds as operators.
- At $\lambda=(-a,0,a)$, with $B_{20}=B_{02}$: $a^2(\mathring B_{00}+\mathring B_{22}-2\mathring B_{02})=\theta a(Q_2-Q_0)-a^2(Q_0+Q_2)$. Dividing by $a\theta$ gives the displayed formula with the stated signs, and $a/\theta=1/\kappa$ is the note's own definition (line 189: $e$ has norm $1/\kappa$).
- The sign bookkeeping to the Ricci correction also holds: in $B_{\mathrm{Ric}}$'s convention $\langle h,\mathring eh\rangle=\tfrac1\kappa(Q_0-Q_2)=-\tfrac1{\kappa^2}\big(Q_0+Q_2+(\mathring B_{00}+\mathring B_{22}-2\mathring B_{02})\big)(h,h)$.
- Screen ($n=5$, $\psi=\varphi_{ij}$): $\sum_{a,b}\mathring B_{ab}=(n-2)\mathring{\mathrm{Id}}$ and $\mathring{\mathrm{Id}}(h,h)=\lvert h\rvert^2-(\operatorname{tr}h)^2$, both to machine precision.

## Item 3

- **The bound holds.** For skew $\omega$ and symmetric $h$, $\operatorname{tr}(\omega h\omega h)=\operatorname{tr}(M^2)$ with $M=\omega h$, and $\lvert\operatorname{tr}(M^2)\rvert=\lvert\langle M^{\mathsf T},M\rangle_F\rvert\le\lVert M\rVert_F^2=\operatorname{tr}(h^2\omega^{\mathsf T}\omega)$. Summing with the factor $\tfrac12$ gives $\lvert\mathring B_{ab}(h,h)\rvert\le\tfrac12\operatorname{tr}(h^2A_{ab})$.
- **The constant is right.** $\sum_{a,b}A_{ab}=\sum_{\gamma,\delta}[\psi_\gamma,\psi_\delta]^{\mathsf T}[\psi_\gamma,\psi_\delta]$ is $O(n)$-invariant, hence $cI$. Its trace is $\sum_\gamma 2(n-2)\lVert\psi_\gamma\rVert_F^2=4(n-2)\binom n2$ by `casimir_skew_lt` ([Casimir.lean](../lean/HamiltonsCubic/Results/Casimir.lean), with $\lVert\varphi_{ij}\rVert_F^2=2$, the normalisation that gives $\sum B_{ab}=(n-2)\mathrm{Id}$). So $c=2(n-1)(n-2)$. Screen at $n=5$: $24I$.
- **Precision.** `casimir_skew_lt` types the trace only. The scalar form rests on invariance, which is untyped.
- **Consequence as stated.** $\lvert(\mathring B_{00}+\mathring B_{22}-2\mathring B_{02})(h,h)\rvert\le\tfrac12\operatorname{tr}\big(h^2(A_{00}+A_{22}+2A_{02})\big)\le(n-1)(n-2)\lvert h\rvert^2$. So $\lvert Q_2-Q_0\rvert\lesssim n\lvert h\rvert^2$, which is the a priori $\tfrac n\kappa$ bound of line 195 again: the prefactor is spent.

## Item 4

- **Correct as a necessary condition.** $\lvert Q_0+Q_2\rvert\le\operatorname{tr}\big(h^2(A_0+A_2)\big)\le(n-1)\lvert h\rvert^2$, since $\sum_cA_c=(n-1)I$. So the bracket combination is the only term not already $O(n)$, and the total $(n-2)\mathring{\mathrm{Id}}$ does suggest a cancellation without forcing it.
- **Beyond support: "$O(n)$" is stated as if it were enough.** With $\lvert x^{\mathsf T}B_{\mathrm{Ric}}x\rvert=\lvert(Q_0+Q_2+\mathring B_{\mathrm{comb}})(h_x,h_x)\rvert/\big(2(n-2)\kappa^2\big)$ and $\lvert h_x\rvert^2\le\tfrac{n-2}2$, a bound $c\lvert h_x\rvert^2$ on the whole bracket gives $\lvert x^{\mathsf T}B_{\mathrm{Ric}}x\rvert\le c/(4\kappa^2)$. Against the margin $(\kappa-n+5)/(32\kappa)$ this needs $c<\kappa(\kappa-n+5)/8$, about $3n/8$ near $\theta_0$ and tending to $0$ at the band's lower edge.
- **Even the harmless-looking term fails that constant.** The crude $\lvert Q_0+Q_2\rvert\le(n-1)\lvert h\rvert^2$ alone overshoots $3n/8$ by about $8/3$. That is the same $8n/(\kappa-n+5)$ ratio of line 197, reduced from order $n$ to order one, not removed.
- **"The extra factor of $n$ the band needs" (line 207) is right in order only.** The gain is a factor $\kappa\approx n$ against a shortfall $8n/(\kappa-n+5)$. It closes nothing at the lower edge unless the constant is controlled.
- **Correction**: the gap is a one-sided bound $(Q_0+Q_2+\mathring B_{00}+\mathring B_{22}-2\mathring B_{02})(h_x,h_x)\ge-c\lvert h_x\rvert^2$ (the sign making the $B_{\mathrm{Ric}}$ contribution negative, since only its negative part enters $\operatorname{tr}B_{\mathrm{Ric}}^-$), or its trace over $V_+$, with $c$ below about $\kappa(\kappa-n+5)/8$. With $\lvert h_x\rvert^2$ smaller than its Gram ceiling, $c$ relaxes in proportion. "$O(n)$" names the order and drops the constant that decides the band.

## Lean

- $\operatorname{tr}(\{u,v\}w)=0$: worth typing as a two-line lemma (symmetric times skew has zero trace) if the blindness paragraph is cited downstream. Otherwise it is too elementary to be load-bearing.
- The prefactor identity needs the action $\mathring{}$ as a declaration. The useful typed pieces would be its linearity, $\mathring P_c=Q_c$, and $\sum_{a,b}A_{ab}=2(n-1)(n-2)I$ as a matrix identity, which `casimir_skew_lt` gives only in trace.

## Bottom line

- The algebra of both paragraphs is correct.
- Two statements need rewording before they enter the record: the "only identity on file" claim, which misses $\mathcal R_x+\mathcal S_x=D(xx^{\mathsf T})$ and Ricci-flatness, and the "$O(n)$" gap, which omits the constant $\kappa(\kappa-n+5)/8$ that the band actually needs.

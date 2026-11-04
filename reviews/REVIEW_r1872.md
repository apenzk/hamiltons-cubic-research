# Review r1872: I121, the index-concentration bound on Weyl tensors and $\Sigma_4$ at $n=4$ (reader two of two)

Brief: [BRIEF_I121_sigma4.md](BRIEF_I121_sigma4.md). Log: [r1872-i121-sigma4.log](../agent_logs/r1872-i121-sigma4.log). Footing: analysis only, with the brief's screening allowance. Written without reading r1871.

**Verdict: the algebra stands and the failure from $n=5$ is reproduced, but the $n=6$ witness is a critical point.** An independently built tensor carrying every invariant the block states for the witness polishes, by a move of $10^{-4}$, to a critical point of $P$ with $\theta=0$ exactly (residual $8\times10^{-16}$), keeping $\Sigma_4/\mathop{\mathrm{tr}}W^4=-\tfrac23$. So "it is not a critical point" is refuted, and "at critical points $\Sigma_4\ge0$ is open" is false as worded. What stays open is $\Sigma_4\ge0$ at critical points with $\theta>0$, which is the scope the $E$ route needs.

| item | claim | verdict |
|---|---|---|
| 1 | $\Sigma_4=2\mathop{\mathrm{tr}}W^4-6\lVert\mathrm{Alt}(W^2)\rVert^2$, sigma4_comp's reading, the equivalence and the L204 sentence | CONFIRMED, one wording correction |
| 2 | $\Sigma_4=2\lVert W^+\rVert^2\lVert W^-\rVert^2$ at $n=4$, zero exactly at one-sided $W$, the $P_+$ example | CONFIRMED |
| 3 | a Weyl tensor with $\Sigma_4<0$ from $n=5$, the $n=6$ witness | CONFIRMED on values, with a normalisation correction. The witness is critical at $\theta=0$ |
| 4 | nothing on the record supplies $\Sigma_4\ge0$ at critical points | CONFIRMED, and sharpened: criticality alone cannot supply it, since a critical point at $\theta=0$ has $\Sigma_4<0$ |
| 5 | scope and wording | REFUTED in two places: "not a critical point", and "at critical points $\Sigma_4\ge0$ is open" without $\theta>0$ |

## Item 1: the $\Sigma_4$ reduction

- **sigma4_eq by hand.** Write $A=\sum T_{ijkl}^2$ and $B=\sum T_{ijkl}T_{iklj}$. The three cyclic terms of alt4 have equal squared sums and equal cross sums by relabelling, so $\lVert\mathrm{Alt}\,T\rVert^2=\tfrac14\cdot\tfrac19(3A+6B)=\tfrac{A+2B}{12}$. Pair symmetry and first-pair antisymmetry give $T_{jkli}=T_{lijk}=-T_{iljk}$, so $\sum T_{ijkl}T_{jkli}=-B$. And $2\cdot\tfrac A4-6\cdot\tfrac{A+2B}{12}=-B$. The Lean proof follows this route.
- **The reading at $R=W^2$.** inner2 is $\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$ and $\langle\varphi_{ij},\varphi_{ij}\rangle=1$, so comp R is the matrix of $R$ in the orthonormal pair basis. At $R=W\circ W$ that is $(W^2)_{ijkl}=\tfrac12\sum_{pq}W_{ijpq}W_{pqkl}$, the left side of sigma4_comp is the block's $\Sigma_4$ (the global sign of phi cancels in a product of two components), fourNormSq (comp R) is the Hilbert–Schmidt norm $\mathop{\mathrm{tr}}W^4$ (by normSq_eq_fourNormSq_comp, whose hypothesis is that $R$ maps each $\varphi_{ij}$ to a skew matrix), and altNormSq R is fourNormSq of alt4 (comp R), the record's $\lVert\mathrm{Alt}(W^2)\rVert^2$. The block's second form $\tfrac14\sum W_{ijpq}W_{jkrs}W_{klpq}W_{lirs}$ is the product of the two half-sums.
- **Hypotheses at $R=W^2$.** hneg holds for any linear map. hsym holds because $W$ is symmetric and maps skew matrices to skew matrices, so $\langle WWX,Y\rangle=\langle WX,WY\rangle=\langle X,WWY\rangle$. No declaration instantiates $R=W\circ W$: the reading is in the docstring, and it discharges in one line.
- **The equivalence** follows at once from the given identity: $\mathop{\mathrm{tr}}(W^2\#W^2)\le\tfrac18\lVert N\rVert_F^2$ iff $\Sigma_4\ge0$ iff $\lVert\mathrm{Alt}(W^2)\rVert^2\le\tfrac13\mathop{\mathrm{tr}}W^4$, the mass being $\lVert W^2\rVert^2=\mathop{\mathrm{tr}}W^4$.
- **The L204 sentence is right.** At $A=W^2$, $\mathop{\mathrm{tr}}A=1$, so L204 gives $\lVert\mathrm{Alt}(W^2)\rVert^2\le\tfrac{m-1}{3m}$, which is at most $\tfrac13\mathop{\mathrm{tr}}W^4$ exactly when $\mathop{\mathrm{tr}}W^4\ge1-\tfrac1m$.
- **Wording correction.** "The index map $G_{ijkl}\mapsto G_{jkli}$ acts by $\tfrac12$ on the Bianchi part" states an operator eigenvalue. What holds is the quadratic-form statement: $\sum b_{ijkl}b_{jkli}=\tfrac12\sum b_{ijkl}^2$ on a Bianchi $b$ (from $A+2B=0$), $-\sum a_{ijkl}^2$ on $a\in\Lambda^4$, and the cross term vanishes because the pairing $\langle G,H\rangle\mapsto\sum G_{ijkl}H_{jkli}$ is symmetric on pair-symmetric arrays and $a$ is sent to $-a$. Suggested wording: "the quartic form $\sum G_{ijkl}G_{jkli}$ is $\tfrac12$ of the squared norm on the Bianchi part and $-1$ times it on $\Lambda^4$, with no cross term".

## Item 2: the $n=4$ formula

- $W=W^+\oplus W^-$ on $\Lambda^+\oplus\Lambda^-$, each block traceless because $W$ is scalar-flat, so $W^2=(W^+)^2\oplus(W^-)^2$ and $\mathop{\mathrm{tr}}W^4=\tfrac12(s_+^2+s_-^2)$ with $s_\pm=\mathop{\mathrm{tr}}(W^\pm)^2$. The block identity $\mathop{\mathrm{tr}}X^4=\tfrac12(\mathop{\mathrm{tr}}X^2)^2$ is Newton's $p_4=-e_2p_2$ at $e_1=0$ with $p_2=-2e_2$.
- $\mathrm{Alt}$ is the projection onto $\star$: $\mathrm{Alt}(W^2)=\tfrac{\mathop{\mathrm{tr}}(W^2\star)}{6}\star=\tfrac{s_+-s_-}6\star$, which is L199's remark, and $\lVert\mathrm{Alt}(W^2)\rVert^2=\tfrac{(s_+-s_-)^2}6$.
- $\Sigma_4=(s_+^2+s_-^2)-(s_+-s_-)^2=2s_+s_-$, zero exactly when $s_+=0$ or $s_-=0$, the one-sided $W$. CONFIRMED.
- **The $P_+$ example.** $I\#I=2I$ on $\mathfrak{so}(4)$, and $[\Lambda^+,\Lambda^-]=0$ kills the cross terms, so $P_+\#P_+=2P_+$ and $\mathop{\mathrm{tr}}=6$. $P_+$ is $SO(4)$-invariant with $\mathop{\mathrm{tr}}N=4\lVert P_+\rVert^2=12$, so $N=3I_4$ and $\tfrac18\lVert N\rVert_F^2=\tfrac92$. Consistency: $\Sigma_4=2\cdot3-6\cdot\tfrac96=-3$ and $\tfrac92+\tfrac32=6$. CONFIRMED.

## Item 3: the failure from $n=5$

Own construction: the Weyl space as the null space of the Bianchi and Ricci maps on symmetric operators on $\Lambda^2\mathbb R^n$ (dimension $35$ at $n=5$, $84$ at $n=6$), orthonormal in the record's norm. $\#$ from the structure constants with $I\#I=(n-2)I$ checked to $0$. Budget stated in advance and kept: BFGS on $\Sigma_4/\mathop{\mathrm{tr}}W^4$, $10$ starts, at most $300$ iterations, at $n=5$ and $n=6$ only, seconds each.

| | $n=5$ | $n=6$ |
|---|---|---|
| minimum of $\Sigma_4/\mathop{\mathrm{tr}}W^4$ (record norm) | $-0.18210$ (all $10$ starts) | $-\tfrac23$ ($6$ starts), $-0.6099$ ($4$ starts) |
| same over $\sum_{ijkl}(W^2)_{ijkl}^2=4\mathop{\mathrm{tr}}W^4$ | $-0.04553$ | $-\tfrac16$ |
| $\Lambda^4$ fraction $\lVert\mathrm{Alt}(W^2)\rVert^2/\mathop{\mathrm{tr}}W^4$ | $0.36368$ | $0.44444=\tfrac49$ |
| critical residual $\lVert\pi_{\mathrm{Weyl}}(W^2+W^\#)-\theta W\rVert$ | $0.77$, not critical | $4\times10^{-5}$ before polishing, $8\times10^{-16}$ after |

- **The $n=6$ values are reproduced**: spectrum $\pm\tfrac1{2\sqrt2}$ on two four-dimensional eigenspaces with a seven-dimensional kernel, $N=\tfrac23I_6$, $\mathop{\mathrm{tr}}(W^2\#W^2)=0.375$ against $\tfrac18\lVert N\rVert_F^2=0.33333$, $\Sigma_4=-\tfrac1{12}$, $\mathop{\mathrm{tr}}W^4=\tfrac18$, Bianchi residual $2\times10^{-16}$, Ricci $3\times10^{-15}$. The given identity checks there to $10^{-16}$.
- **Normalisation correction.** The block's $-0.046$ and $-\tfrac16$ are $\Sigma_4$ over the full sum $\sum(W^2)_{ijkl}^2$, which is $4\lVert W^2\rVert^2$ in the record's norm. Read in the record's norm, which the same bullet uses for $\mathrm{Alt}$, the ratios are $-0.182$ and $-\tfrac23$. The block should write the denominator as $\sum_{ijkl}(W^2)_{ijkl}^2$ or quote the record-norm values. The $\Lambda^4$ fractions are normalisation-free and agree.
- **The witness is a critical point at $\theta=0$.** $P(W)=-1.7\times10^{-10}$ at the descent output (the spectrum is symmetric, so $\mathop{\mathrm{tr}}W^3=0$), and the Weyl projection of $W^2+W^\#$ is $4\times10^{-5}$, the descent's own accuracy. One bounded least-squares polish on the critical residual (at most $200$ evaluations) moves the tensor by $9.8\times10^{-5}$ and reaches residual $8.3\times10^{-16}$ with $\theta=-8\times10^{-18}$, spectrum $\pm0.353553390$ to nine digits and $\Sigma_4/\mathop{\mathrm{tr}}W^4=-0.66666666666666$. The $n=5$ minimiser is far from critical (residual $0.77$). This is a screen, and its content is that a critical point with $\Sigma_4<0$ exists at $\theta=0$, reported as found rather than proved.
- **Partial closed form.** Numerically, the $\pm$ eigenspaces together span a copy of $\mathfrak{su}(3)\subset\mathfrak{so}(6)$: their common commutant in $\mathfrak{gl}(6)$ is one-dimensional, spanned by a complex structure $J$ ($J^2=-I$ to $10^{-4}$) that lies in the kernel, so $\mathbb R^6=\mathbb C^3$ and the kernel is $\mathbb RJ\oplus[\![\Lambda^{2,0}]\!]$. The brackets obey $[V_+,V_+]\subset V_-$, $[V_-,V_-]\subset V_+$, $[V_+,V_-]\subset V_+\oplus V_-$. So $W=\tfrac1{2\sqrt2}(\Pi_{V_+}-\Pi_{V_-})$ on $\mathfrak{su}(3)$ and zero on its complement. I did not pin the split of $\mathfrak{su}(3)$ into $V_\pm$ in closed form.

## Item 4: the consequence

- **Search.** [findings/](../findings/), [results.md](../results.md) and the reviews carry no lower bound on $\Sigma_4$ or $Q$ and no upper bound on $\lVert\mathrm{Alt}(W^2)\rVert$ at critical points beyond [L204](../findings/bounds.md). The mentions of $\Sigma_4$ are the working note, the two sweeps, the position file, r1869 and [findings/INDEX.md](../findings/INDEX.md)'s obstruction row. [L199](../findings/bounds.md)'s $G_W\succeq0$ contains $12\,\mathrm{Alt}(W^2)$ but its recorded moments are blind to it.
- **The critical equation.** Hamilton's identity makes $W^2+W^\#$ Bianchi at every algebraic curvature tensor, so $\mathrm{Alt}(W^\#)=-\mathrm{Alt}(W^2)$ holds everywhere and is no constraint of criticality. The critical equation fixes the Weyl part of a Bianchi tensor and says nothing further about its $\Lambda^4$ content. [The 28h sweep](2026-09-28h-LIT-step8-sweep.md) records the same point.
- **Sharpened.** The $\theta=0$ critical point above shows criticality alone cannot give $\Sigma_4\ge0$. Any proof must consume $\theta>0$, or the band's value range, or second-order information. The block's sentence stands, and should say that.

## Item 5: scope and wording

- **"It is a Weyl tensor and not a critical point" is REFUTED** for the tensor carrying the stated invariants: it is within $10^{-4}$ of, and polishes to, a critical point with $\theta=0$. The block's own tensor was not inspected (the brief forbids importing the screen), but every invariant it names matches, and the burden for "not critical" is a residual the block does not report.
- **"At critical points $\Sigma_4\ge0$ is open" is false as worded**, since $\Sigma_4<0$ at that critical point. Correct to "at critical points with $\theta>0$", which is the scope of the display in the first bullet and all the $E$ route needs. The same correction applies to the table row in [the position file](2026-09-28h-step8-position.md), which calls the witnesses non-critical.
- **The $n=5,7,8$ values** are stated as what descent "reaches", which is the right strength. The $n=6$ value $-\tfrac16$ is a descent minimum too, reproduced here from $6$ of $10$ starts, and the block does not claim it as a proved minimum.
- **Ratio normalisation**: see item 3.
- **"Acts by $\tfrac12$"**: see item 1.

## Corrections for the author

1. Replace "It is a Weyl tensor and not a critical point" with "It is a critical point of $P$ at $\theta=0$ (residual $10^{-15}$ after polishing), outside the $\theta>0$ scope of the display".
2. Replace "At critical points $\Sigma_4\ge0$ is open" with "At critical points with $\theta>0$, $\Sigma_4\ge0$ is open. Criticality alone does not give it: the $n=6$ witness is critical at $\theta=0$". Carry this to the position file's row and to [findings/INDEX.md](../findings/INDEX.md)'s obstruction row if it repeats "non-critical".
3. Write the ratio's denominator as $\sum_{ijkl}(W^2)_{ijkl}^2$, or quote $-0.182$, $-\tfrac23$ in the record's norm.
4. Replace "the index map acts by $\tfrac12$ on the Bianchi part and by $-1$ on $\Lambda^4$" with the quadratic-form statement of item 1.

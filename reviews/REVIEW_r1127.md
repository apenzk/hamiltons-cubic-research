# Review r1127: gate 2 on L243, the Gaussian subspace cap in class form

Brief: [2026-09-25-L243-gate2-brief.md](2026-09-25-L243-gate2-brief.md). Log: [agent_logs/r1127.log](../agent_logs/r1127.log). Analysis only, plus a seconds-long exact-rational screen of the two recorded points against all seven class unions.

| Item | Verdict |
|---|---|
| 1. Generalisation of L238 (i) | CONFIRMED (add $k\ge1$) |
| 2. The rank step | CONFIRMED |
| 3. Isserlis | CONFIRMED |
| 4. Class form | CONFIRMED |
| 5. Checks | CONFIRMED |
| 6. Scope | PLAUSIBLE, one sentence to repair |
| Lean statements | CONFIRMED |

## 1. Generalisation of L238 (i): CONFIRMED

- For skew $X,Y$: $\mathop{\mathrm{tr}}[X,Y]^2=2\mathop{\mathrm{tr}}XYXY-2\mathop{\mathrm{tr}}X^2Y^2$, so $\lVert[X,Y]\rVert^2=\mathop{\mathrm{tr}}X^2Y^2-\mathop{\mathrm{tr}}XYXY$ in the record's norm.
- $\lvert Xv\rvert^2=v^{\mathsf T}Qv$ with $Q=-X^2$, $\mathop{\mathrm{tr}}Q=2\lVert X\rVert^2=2$. Isserlis gives $\mathbb E[G_{ii}G_{jj}]=4+2\mathop{\mathrm{tr}}Q_iQ_j$.
- $Xv\cdot Yv=-\tfrac12v^{\mathsf T}Sv$, $\mathop{\mathrm{tr}}S=2\mathop{\mathrm{tr}}XY=-4\langle X,Y\rangle=0$, so $\mathbb EG_{ij}^2=\tfrac14\cdot2\mathop{\mathrm{tr}}S^2=\mathop{\mathrm{tr}}XYXY+\mathop{\mathrm{tr}}X^2Y^2$.
- Difference minus $4$: $\mathop{\mathrm{tr}}X^2Y^2-\mathop{\mathrm{tr}}XYXY$, the bracket. The inputs are $\lVert X_i\rVert=1$ and $\langle X_i,X_j\rangle=0$ for the pair only.
- $\sum_{i\ne j}(G_{ii}G_{jj}-G_{ij}^2)=(\mathop{\mathrm{tr}}G)^2-\lVert G\rVert_F^2$ holds for any $k$. The constant is $4k(k-1)$.
- Correction: "any $k$" should read $k\ge1$, since $k=0$ gives $r=0$. At $k=1$ both sides are $0$.

## 2. The rank step: CONFIRMED

- $X_iv\perp v$ for every $v$ by skewness, so $\mathop{\mathrm{rank}}G(v)\le\min(k,n-1)$ for every $v$, not only almost surely.
- For PSD $G$ of rank at most $r$, Cauchy–Schwarz gives $\lVert G\rVert_F^2\ge(\mathop{\mathrm{tr}}G)^2/r$, and $\mathop{\mathrm{tr}}G=v^{\mathsf T}Pv$.
- $d=\mathop{\mathrm{rank}}P\le n$ gives $d-1\le n-1$, and $1-\tfrac1r$ increases in $r$ while $(\mathop{\mathrm{tr}}G)^2\ge0$, so $r=\min(k,n-1)$ is valid and weaker than L238's $\min(k,d-1)$. It is the right choice for a class form, where $\mathop{\mathrm{rank}}P$ is not a class variable.

## 3. Isserlis: CONFIRMED

- $\mathbb E(v^{\mathsf T}Pv)^2=(\mathop{\mathrm{tr}}P)^2+2\mathop{\mathrm{tr}}P^2$ for symmetric $P$ and $v\sim N(0,I_n)$.
- $\mathop{\mathrm{tr}}P=\sum_i-\mathop{\mathrm{tr}}X_i^2=2\sum_i\lVert X_i\rVert^2=2k$, so $(\mathop{\mathrm{tr}}P)^2=4k^2$, matching L238's $196$ at $k=7$. Taking $v$ in $\mathbb R^n$ rather than on $\mathop{\mathrm{ran}}P$ leaves $v^{\mathsf T}Pv$ unchanged.

## 4. Class form: CONFIRMED

- $A_a=\sum_{\alpha\in a}\Psi_\alpha\Psi_\alpha^{\mathsf T}=\sum_{\alpha\in a}(-\Psi_\alpha^2)$, so $P=\sum_{a\in S}A_a$ and $\mathop{\mathrm{tr}}P^2=\sum_{a,b\in S}G_{ab}$. $P$ is independent of the orthonormal basis chosen for $V$.
- $[\Psi_\alpha,\Psi_\beta]=\sum_\gamma c_{\alpha\beta\gamma}\Psi_\gamma$ over the full orthonormal eigenbasis of $\mathfrak{so}(n)$, so $\lVert[\Psi_\alpha,\Psi_\beta]\rVert^2=\sum_\gamma c_{\alpha\beta\gamma}^2$, and summing $\alpha\in a$, $\beta\in b$ over ordered $(a,b)\in S^2$ gives $\sum_{a,b\in S}\sum_c\tau_{abc}$, the ordered total. The sum over $c$ runs over every class, $c\notin S$ included, which is what $T$ needs.
- $\alpha=\beta$ contributes $c_{\alpha\alpha\gamma}=0$, so including the diagonal is harmless.
- Normalisation screen: both recorded Gram matrices sum to $1452=12\cdot11^2=\mathop{\mathrm{tr}}\big((n-1)I\big)^2$, and at $S=\{0,1,2\}$ both recorded points give left side $1320$ equal to the right side, as the whole algebra must.

## 5. Checks: CONFIRMED

- $\mathfrak{so}(12)$: $e_i\wedge e_j$ has norm $1$, $P=11I$, $\mathop{\mathrm{tr}}P^2=1452$. Right side $\tfrac{10}{11}(17424+2904)-17160=1320$. Left side $66\cdot2(n-2)=1320$. Equality is the expected case, since $G(v)$ has all nonzero eigenvalues $\lvert v\rvert^2$.
- L242, $S=\{0,2\}$: $3\cdot104+3\cdot24+80=464$ from triples inside $S$. The terms with $c=1$ are $\tau_{001},\tau_{012},\tau_{122}$, all zero in L242, so the left side is $464$ exactly. Right side $\tfrac{10}{11}\cdot2880-2208=\tfrac{28800}{11}-2208\approx410.18$. Excluded.
- L241, $S=\{0,2\}$ with $m=(7,52,7)$, $k_S=14$: inside $S$, $3\cdot42+14=140$. With $c=1$: $2\tau_{012}+\tau_{122}=28+28=56$. Total $196$. $\sum G=154$, right side $\tfrac{10}{11}\cdot1092-728\approx264.73$. Satisfied.
- Screen on all unions (exact rationals, a scratch script outside the repo): L241 satisfies all six proper unions. **L242 also violates at $S=\{1\}$**, $824>770.18$, which the record may add as a second witness to the exclusion.

## 6. Scope: PLAUSIBLE

- The screen is labelled as a screen, and the script's `gauss` block implements exactly the displayed inequality over the six proper unions, with $\tau$ symmetric and $\sum_bG_{ab}=2(n-1)m_a$ as in the class Gram. The count 234 against 237 is consistent with L241's scope, where section 5 removed none of 237. I did not rerun the 2080-triple screen.
- **Repair:** "It removes points far above $\sqrt{3/2}$ and leaves those near the threshold" is overbroad. The screen measures only $\theta=1.2248$. L241's point, at $\theta\approx1.336$, satisfies the cap on every union, so the cap does not remove all points far above the threshold. Suggested text: "It excludes L242's point ($\theta\approx1.361$), leaves L241's ($\theta\approx1.336$), and at $\theta=1.2248$ removes three of 237 screened triples."
- The owed item (partial-class frames, per-element $\mathop{\mathrm{tr}}(\Psi\Psi^{\mathsf T})^2\le2$) is labelled owed. The per-element bound itself is true: $\mathop{\mathrm{tr}}Q^2=2\sum\lambda_j^4\le2(\sum\lambda_j^2)^2=2$.

## Lean statements: CONFIRMED

- `gaussian_cap` takes the Gaussian form and the rank/Isserlis bound as `hT` and `hE`, as the table says, and concludes the displayed cap.
- `whole_algebra_tight` types only the right side equal to $1320$. The left side $1320$ stays prose, which the docstring's wording "both sides" slightly overstates.
- `L242_excluded` and `L241_satisfies` state the right side at $(24,11,288)$ and $(14,11,154)$ against $464$ and $196$, matching the prose. The left sides are prose from L241 and L242's values, confirmed in item 5.

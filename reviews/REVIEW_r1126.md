# REVIEW r1126: gate 2 on L243, the Gaussian subspace cap in class form

Brief: [2026-09-25-L243-gate2-brief.md](2026-09-25-L243-gate2-brief.md). Log: [agent_logs/r1126.log](../agent_logs/r1126.log).

**Verdict: the cap and its class form are CONFIRMED. The checks are CONFIRMED. The scope sentence "It removes points far above $\sqrt{3/2}$ and leaves those near the threshold" is overstated and wants rewording (item 6, PLAUSIBLE).**

| Item | Verdict |
|---|---|
| 1. Generalisation of L238 (i) | CONFIRMED |
| 2. The rank step | CONFIRMED |
| 3. Isserlis | CONFIRMED |
| 4. Class form | CONFIRMED |
| 5. Checks | CONFIRMED, with one clarification |
| 6. Scope | PLAUSIBLE, one sentence to repair |
| Lean statements | CONFIRMED |

## 1. Generalisation of L238 (i): CONFIRMED

- For skew $X,Y$: $\mathop{\mathrm{tr}}[X,Y]^2=2\mathop{\mathrm{tr}}XYXY-2\mathop{\mathrm{tr}}X^2Y^2$, so $\lVert[X,Y]\rVert^2=\mathop{\mathrm{tr}}X^2Y^2-\mathop{\mathrm{tr}}XYXY$ in the record's norm.
- $\lvert X_iv\rvert^2=v^{\mathsf T}Q_iv$ with $\mathop{\mathrm{tr}}Q_i=-\mathop{\mathrm{tr}}X_i^2=2\lVert X_i\rVert^2=2$, so $\mathbb E\lvert X_iv\rvert^2\lvert X_jv\rvert^2=4+2\mathop{\mathrm{tr}}Q_iQ_j$. $X_iv\cdot X_jv=-\tfrac12v^{\mathsf T}S_{ij}v$ and $\mathop{\mathrm{tr}}S_{ij}=-4\langle X_i,X_j\rangle=0$, so $\mathbb E(X_iv\cdot X_jv)^2=\tfrac12\lVert S_{ij}\rVert_F^2$. The difference minus $4$ is $2\mathop{\mathrm{tr}}X_i^2X_j^2-\tfrac12(2\mathop{\mathrm{tr}}X_iX_jX_iX_j+2\mathop{\mathrm{tr}}X_i^2X_j^2)$, which is the bracket norm.
- The inputs are unit norm (the constant $4$) and pairwise orthogonality ($\mathop{\mathrm{tr}}S_{ij}=0$). Nothing uses $k=7$. Summing $G_{ii}G_{jj}-G_{ij}^2$ over ordered $i\ne j$ gives $(\mathop{\mathrm{tr}}G)^2-\lVert G\rVert_F^2$ and the constant $4k(k-1)$.
- Screen: random orthonormal frames at $(n,k)=(5,4),(6,10),(7,3),(12,24)$ reproduce the trace form to machine precision and the Gaussian form to Monte Carlo accuracy ($2\cdot10^5$ samples), with the cap holding in every case.

## 2. The rank step: CONFIRMED

- Each $X_iv$ is orthogonal to $v$ by skewness, so for $v\ne0$ (almost surely) the $k$ vectors lie in the $(n-1)$-space $v^\perp$ and $\mathop{\mathrm{rank}}G(v)\le\min(k,n-1)=r$.
- For positive semidefinite $G$ of rank at most $r\ge1$, $(\mathop{\mathrm{tr}}G)^2\le r\lVert G\rVert_F^2$, giving $(\mathop{\mathrm{tr}}G)^2-\lVert G\rVert_F^2\le(1-\tfrac1r)(\mathop{\mathrm{tr}}G)^2$ with $\mathop{\mathrm{tr}}G=v^{\mathsf T}Pv$.
- L238's $r=\min(7,d-1)$ with $d=\mathop{\mathrm{rank}}P\le n$ is the sharper value. L243 uses $r=\min(k,n-1)\ge\min(k,d-1)$, valid because $1-\tfrac1r$ increases in $r$ and $(v^{\mathsf T}Pv)^2\ge0$. Taking $v$ Gaussian on all of $\mathbb R^n$ instead of on $\mathop{\mathrm{ran}}P$ changes nothing, since $P$ vanishes on $\ker P$.
- Edge cases: $k=1$ gives $r=1$ and a right side $0=T$. $n\ge2$ keeps $r\ge1$.

## 3. Isserlis: CONFIRMED

- $\mathbb E(v^{\mathsf T}Pv)^2=(\mathop{\mathrm{tr}}P)^2+2\mathop{\mathrm{tr}}P^2$ for symmetric $P$ and standard Gaussian $v$. $\mathop{\mathrm{tr}}P=\sum_i\mathop{\mathrm{tr}}Q_i=2k$ in the record's norm, so $(\mathop{\mathrm{tr}}P)^2=4k^2$. At $k=7$ this is L238's $196$.

## 4. Class form: CONFIRMED

- The $\Psi_\alpha$ are unit in the record's norm (the summed-pair note's Lemma uses $\lVert[U,V]\rVert_F^2=2\sum_\gamma T_{\alpha\beta\gamma}$, the Frobenius norm being twice the record's). So $\Psi_\alpha\Psi_\alpha^{\mathsf T}=-\Psi_\alpha^2=Q_\alpha$, $P=\sum_{a\in S}A_a$ and $\mathop{\mathrm{tr}}P^2=\sum_{a,b\in S}\mathop{\mathrm{tr}}A_aA_b=\sum_{a,b\in S}G_{ab}$, ordered, so the off-diagonal $G_{ab}$ counts twice.
- $\lVert[\Psi_\alpha,\Psi_\beta]\rVert^2=\sum_\gamma c_{\alpha\beta\gamma}^2$ with $\gamma$ over the whole orthonormal eigenbasis of $\mathfrak{so}(n)$, so every class $c$, including classes outside $S$. Summing over ordered $(\alpha,\beta)$ in $V$ gives $\sum_{a,b\in S}\sum_c\tau_{abc}$.
- The diagonal $\alpha=\beta$ is included in $\tau$'s sum and contributes $c_{\alpha\alpha\gamma}=0$, so it is harmless. $T$ over an orthonormal basis of $V$ is basis-independent, so the eigenbasis is a legitimate frame.
- Linear in $(\tau,G)$: $k_S$ and $r_S$ depend only on the multiplicities, fixed per spectrum.

## 5. Checks: CONFIRMED, with one clarification

- **Whole algebra.** $k=66$, $\mathop{\mathrm{tr}}P^2=12\cdot121=1452$, $r=11$: $\tfrac{10}{11}(17424+2904)-17160=18480-17160=1320$. The left side is $66\cdot2(n-2)=1320$ (each coordinate element shares one index with $2(n-2)$ others). *The cap is in fact tight on $\mathfrak{so}(n)$ at every $n\ge3$*: both sides equal $n(n-1)(n-2)$, since the right side factors as $n(n-1)(n-2)[(n+2)-(n+1)]$.
- **L242.** $\sum_{a,b\in\{0,2\}}G_{ab}=72+2\cdot72+72=288$, $r=\min(24,11)=11$, right side $\tfrac{10}{11}\cdot2880-2208=\tfrac{28800}{11}-2208\approx410.18$. Left side over $\{0,2\}^3$: $3\cdot104+3\cdot24+80=464$.
- **Clarification.** The left side sums $c$ over all three classes. At L242 the $c=1$ terms are $\tau_{001},\tau_{012},\tau_{122}$ (with their permutations), all zero, so $464$ is the full left side. The brief's phrase "others in $\{0,2\}^3$ zero" leaves these unstated, and the check needs them. The inequality $464>410.2$ would survive any nonzero values anyway, since $\tau\ge0$.
- **L241.** $m=(7,52,7)$, $S=\{0,2\}$, $k=14$, $\sum G=4\cdot\tfrac{77}2=154$, right side $\tfrac{10}{11}\cdot1092-728\approx264.73$. The left side is $3\tau_{002}+\tau_{222}=140$ inside $\{0,2\}^3$ plus $56$ from $c=1$: $\tau_{021},\tau_{201}$ ($14$ each) and $\tau_{221}$ ($28$). Total $196$, as stated. Here the $c=1$ terms matter, so a reader recomputing the check from $\{0,2\}^3$ alone would get $140$.

## 6. Scope: PLAUSIBLE, one sentence to repair

- The screen is labelled as one ("What it does to (c), on a screen") and the script matches the stated constraint: six proper unions, $\tau$ symmetric over ordered triples, $\sum_c$ over all classes, $G$ summed ordered, $r=\min(k,n-1)$ ([screen_I73c_capped_offray.py](../scripts/misc/screen_I73c_capped_offray.py), lines 18 to 21). I did not rerun it.
- The baseline $237$ is L241's count without section 5, which section 5 did not reduce, so "against 237 without it" compares like with like.
- **Overstated:** "It removes points far above $\sqrt{3/2}$ and leaves those near the threshold." The screen tests one $\theta=1.2248$ and says nothing about how the cap acts at larger $\theta$. The only exhibit far above is L242 ($\theta\approx1.361$), and L241 at $\theta\approx1.336$ **satisfies** the cap. *Suggested text: "It excludes L242's point ($\theta\approx1.361$), keeps L241's ($\theta\approx1.336$), and at $\theta=1.2248$ removes 3 of 237 surviving triples."*
- The Owed line (frames drawn partly from a class) is correctly left open.

## Lean statements: CONFIRMED

- `gaussian_cap` takes the Gaussian form and the combined rank, Cauchy–Schwarz and Isserlis step as hypotheses, and concludes the displayed cap. The statement is the arithmetic step the prose needs, as the untyped row says.
- `whole_algebra_tight` checks the right side only ($1320=66\cdot20$). The left side is prose (verified in item 5).
- `L242_excluded` and `L241_satisfies` use $(k,r,\sum G)=(24,11,288)$ and $(14,11,154)$ against hard-coded left sides $464$ and $196$, both verified in item 5 from the lemmas' class values.

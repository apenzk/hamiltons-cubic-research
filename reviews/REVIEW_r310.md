# Review r310, the diagonal fold-in: normalisation, invariance, the disconnected repair, admissibility, the sign trap

Adversarial Gate 2 audit of the five claims committed as 2293bc0 and e852c66 into [findings/diagonal-half.md](../findings/diagonal-half.md). Built from the definitions, not from the repository's scripts. Reviewer 309 audited the identical brief independently; no coordination.

## The build this verdict rests on

[scripts/reviewers/r310/lib310.py](../scripts/reviewers/r310/lib310.py), written from scratch. Conventions fixed independently and then checked against invariants rather than against the record:

| item | choice | check that fixed it |
|---|---|---|
| basis of $\Lambda^2(\mathbb R^n)$ | $\varphi_{ab}=E_{ab}=e_ae_b^{\mathsf T}-e_be_a^{\mathsf T}$, orthonormal under $\langle A,B\rangle=\tfrac12\mathop{\mathrm{tr}}(A^{\mathsf T}B)$ | $[\varphi_{ab},\varphi_{bd}]=\varphi_{ad}$ |
| structure constants | $c_{\alpha\beta\gamma}=\langle[b_\alpha,b_\beta],b_\gamma\rangle\in\{0,\pm1\}$ | derived from $[E_{ij},E_{kl}]$ |
| Hamilton sharp | $(R\#S)_{\alpha\beta}=\tfrac12\sum c_{\alpha\gamma\mu}c_{\beta\delta\nu}R_{\gamma\delta}S_{\mu\nu}$ | $I\#I=(n-2)I$ exactly, which is [BW08](../references/boehm-wilking-2008-space-forms/) Lemma 2.1 with $W\#I=-W$ |
| $\mathrm{Weyl}_n$ | nullspace of first Bianchi + Ricci, orthonormalised | dimension $\tfrac{n(n+1)(n+2)(n-3)}{12}$ hit exactly: 35, 84, 168, 300 at $n=5,6,7,8$ |
| $L_W$ | $H\mapsto\tfrac12(WH+HW)+\#(W,H)$ | self-adjoint to $10^{-16}$; maps $\mathrm{Weyl}_n\to\mathrm{Weyl}_n$ to $5\times10^{-15}$ |
| $\Delta$ | $\sum_{\lambda_\gamma>0}\lVert[\mathrm{ad}(v_\gamma),W]\rVert^2$ | reproduces the record's diagonal closed form $g_{ab}=2\lVert M_a-M_b\rVert^2-4M_{ab}^2$ to $2\times10^{-16}$ |

Independent cross-checks before any claim was touched: the graph functional $\sum_{a<b}w_{ab}^3+3\sum_{a<b<c}w_{ab}w_{bc}w_{ca}$ reproduces $P(W)$ to $10^{-16}$ on the diagonal locus, and $\theta(S^{n/2}\times S^{n/2})=\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ to machine precision. The record's own lossy table came back digit for digit on my build, $S^3\times S^3$ $(0.250/0.500)$, $S^3\times S^5$ $(0.375/0.500)$, $S^6\times S^6$ $(0.400/0.500)$, $S^2\times S^4$ $(0.3\overline3/0.6\overline6)$, $S^2\times S^6$ $(0.400/0.600)$, so my normalisation and the record's agree before the disputed claims are reached.

Throughout, **$\lambda_{\max}(L_e)$ means $\lambda_{\max}(L_W|_{W^\perp})/\theta$**, and "diagonal" versus "full" says which subspace of $W^\perp\cap\mathrm{Weyl}_n$ the maximum is taken over.

---

## D1. NORMALISATION, **CONFIRMED as a normalisation claim, REFUTED on the number 1.025**

### The witness number is exact

[scripts/data/w_n8_nondiagonal_witness.npy](../scripts/data/w_n8_nondiagonal_witness.npy) on my build:

| quantity | value |
|---|---|
| distance to $\mathrm{Weyl}_8$ | $2.1\times10^{-15}$ |
| $\lVert W\rVert^2$ | $1.000000000000$ |
| $\theta=P(W)$ | $1.088948052505048$ (record: $1.088948053$) |
| criticality residual $\lVert Q(W)-\theta W\rVert_\infty$ | $5.0\times10^{-16}$ |
| off-diagonal mass | $0.967$ |
| $\lambda_{\max}(L_W|_{W^\perp})$ | $0.6630446219$ |
| $\lambda_{\max}(L_e)$ | $\mathbf{0.6088854472}$ |
| $\Delta$ | $1.512$ |

The spectrum of $L_e$ near the top is $0.5$ with high multiplicity (the orbit directions, exactly as Lemma L24's sharpness clause predicts) and then the single value $0.60889$. So $0.608885$ is confirmed, and it is $\lambda_{\max}(L_W|_{W^\perp})/\theta$, one division by $\theta$, not two. Dividing a second time would give $0.5592$, which appears nowhere.

### The two numbers are the same quantity, that part of the repair holds

The census figure cannot be $\lambda_{\max}(L_W)$ un-normalised: across my own diagonal $\Delta>0$ population, $\lambda_{\max}(L_W)$ runs $0.55$–$0.81$, always below $1$, so a reported floor of $1.025$ can only be $\lambda_{\max}(L_W)/\theta=\lambda_{\max}(L_e)$. **The repair identified the quantity correctly and introduced no new factor of $\theta$ in either direction.**

### But $1.025$ is not a floor, witness below it

My own census of block-constant blow-up critical points (224 distinct diagonal critical points with $\theta>0$ at $n=5\ldots12$, 77 of them with $\Delta>0$) reaches lower. The cleanest witness, verified end to end:

> **$n=10$, connected ($\dim\ker M=1$), $\theta=0.735372377$, criticality residual in the full $\mathrm{Weyl}_{10}$ of $5.6\times10^{-17}$, $\lVert W\rVert^2=1$ to $10^{-12}$, $\Delta=1.8025751073$, agreeing to $2\times10^{-16}$ between the $\mathrm{ad}(v_\gamma)$ definition and the $g_{ab}$ closed form, and $\lambda_{\max}(L_e)=1.011904762$ on the diagonal locus **and** on the full space.**

Saved at [scripts/reviewers/r310/witness_low_n10.npy](../scripts/reviewers/r310/witness_low_n10.npy). A wider sweep (571 distinct $\Delta>0$ diagonal critical points, $n=6\ldots16$) drives it lower still, and **the minima are exact rationals with an evident law**:

$$\min\lambda_{\max}(L_e)\ \overset{?}{=}\ 1+\frac1{2(n-3)(n-4)}$$

| $n$ | 10 | 11 | 12 | 13 | 14 | 15 | 16 |
|---|---|---|---|---|---|---|---|
| observed minimum | $1+\tfrac1{84}$ | $1+\tfrac1{112}$ | $1+\tfrac1{144}$ | $1+\tfrac1{180}$ | $1+\tfrac1{220}$ | $1+\tfrac1{264}$ | $1+\tfrac1{312}$ |
| | $1.011905$ | $1.008929$ | $1.006944$ | $1.005556$ | $1.004545$ | $1.003788$ | $1.003205$ |

Seven dimensions, exact to $10^{-9}$, every minimiser **connected**. The $n=16$ end is verified end to end as well: blocks $1,1,2,4,4,4$, $\theta=0.776176217$, criticality residual in the full $\mathrm{Weyl}_{16}$ of $2.2\times10^{-16}$, unit norm, $\Delta=1.577844$ by both definitions, $\dim\ker M=1$ ([witness_low_n16.npy](../scripts/reviewers/r310/witness_low_n16.npy)).

**So the diagonal cushion is not a factor of two, it converges to exactly $1$, i.e. to a margin of $2.000\times$ over $\tfrac12$ and to zero margin over $\theta$.** Every value is still above $1$, so the stronger conjecture $\Delta>0\Rightarrow\lambda_{\max}\ge\theta$ survives, but it is **sharp in the limit**, not comfortable, and $1.025$ and $1.0417$ are artefacts of populations that stopped at small $n$.

**Consequence for the argument the claim is making.** The margin comparison degrades from $2.05\times$ to $2.01\times$ against the witness's $1.22\times$, so the *conclusion* the record draws ("a cycle taking the cushion as general would be relying on a diagonal statement to prove a non-diagonal one") survives intact and is if anything strengthened. What fails is the presentation of $1.025$ as a fact about the diagonal locus rather than about one population of points. **The number should be quoted with its population and treated as an upper bound on the true floor.**

### One precision issue the brief did not ask about

The two compared numbers are the same *quantity* but not over the same *subspace*: $1.025$ is a maximum over the diagonal locus, $0.608885$ is a maximum over all of $W^\perp\cap\mathrm{Weyl}_8$. Since the locus is a subspace, the diagonal figure is a lower bound for the full one at those points, so the comparison errs in the conservative direction and the record's use of it is sound. It should still say which restriction each side is.

---

## D2. THE INVARIANCE ARGUMENT, **CONFIRMED, with the argument's load-bearing step misattributed**

### Invariance at non-critical $W$: a theorem, verified

Measured at $n=5,\dots,9$ on random diagonal $W$ with criticality residual $0.15$–$0.34$: the off-diagonal mass of $L_WH$ is **exactly $0.0$**, not a tolerance. It stays $0.0$ when $H$ has non-zero row sums, i.e. when $H$ leaves $\mathrm{Weyl}_n$ entirely.

The proof is two lines and needs neither criticality nor Ricci-flatness. For $W,H$ both diagonal, $\#(W,H)_{\alpha\beta}=\tfrac12\sum_{\gamma\mu}c_{\alpha\gamma\mu}c_{\beta\gamma\mu}w_\gamma h_\mu$; $c_{\alpha\gamma\mu}\ne0$ forces $\{\gamma,\mu\}=\{(a,e),(b,e)\}$ for $\alpha=(a,b)$, and $c_{\beta\gamma\mu}\ne0$ forces $\{\gamma,\mu\}=\{(c,f),(d,f)\}$ for $\beta=(c,d)$; the two coincide only when $\alpha=\beta$. And $\tfrac12(WH+HW)$ is diagonal outright. This is the same combinatorial proof the record already records, and it is correct.

Ricci-flatness travels with it: $\sum_{b\ne a}(MN+NM)_{ab}=-2\langle M_a,N_a\rangle$, which cancels the $\sum_{b}M_{ab}N_{ab}$ term exactly, so the row sums of $L_WH$ vanish whenever those of $H$ do. Measured at $10^{-16}$.

### The inequality is true, but invariance is not what gives it

The record writes "the diagonal locus is an $L_W$-invariant subspace … **so** the full $\lambda_{\max}$ is never below the diagonal one". The implication does not need invariance. $L_W$ is self-adjoint on $\mathrm{Sym}(\Lambda^2)$ (measured $\lVert L-L^{\mathsf T}\rVert=10^{-16}$), so the maximum Rayleigh quotient over *any* subspace of $W^\perp$ is at most the maximum over $W^\perp$. Invariance buys only the statement that the compression $\Pi L\Pi$ equals the restriction $L|_V$, a convenience for reading the spectrum, not the inequality. Confirmed numerically at non-critical diagonal $W$: $n=6,7,8$ give diagonal $=$ full at $0.751232$, $0.714266$, $0.693890$.

**One scope note.** Invariance at non-critical $W$ is true and worth having, but it does no work for the certification claim: Lemma L24 applies only at critical points, so "exceeding $\tfrac12$ on the locus certifies second-order failure" is a statement about critical $W$ regardless. The record presents the non-critical extension as the thing that makes the certification valid; it is a separate, true, unused fact.

---

## D3. THE DISCONNECTED-LEMMA REPAIR, **counterexamples REPRODUCED; the repaired statement CONFIRMED, with a proof**

### The counterexamples, digit for digit

| point | $n$ | $\theta$ | #components | carrying an edge | $\dim\ker M$ | $\Delta$ | $\lambda_{\max}(L_e)$ diag $=$ full | $\cos(N,M)$ |
|---|---|---|---|---|---|---|---|---|
| $S^4\times S^4$ + isolated vertex | 9 | $1.145643924$ | 2 | **1** | 2 | $0$ | $0.571428571$ | $+1.000000$ |
| $S^3\times S^3$ + isolated vertex | 7 | $1.054092553$ | 2 | **1** | 2 | $0$ | $0.600000$ | $+1.000000$ |
| $S^3\times S^4$ + isolated vertex | 8 | $1.095445115$ | 2 | **1** | 2 | $0$ | $0.583333$ | $+1.000000$ |
| $S^4\times S^4$ + 2 isolated vertices | 10 | $1.145643924$ | 3 | **1** | 3 | $0$ | $0.571428571$ | $+1.000000$ |

Every reported figure reproduces, including $\cos(N,M)=+1.000000$ exactly, the indicator direction *is* the radial one, because the only component carrying an edge is the whole of $M$'s support. So both the original consequence and the "non-radial" patch fail exactly as the record says.

### The repaired statement is a theorem, not a survivor of testing

Let $M$ be a diagonal critical point with $\theta>0$ whose support graph has components $C_1,\dots,C_k$, of which $k'\ge2$ carry an edge. Writing $M_c=t_cU_c$ with $\lVert U_c\rVert=1$, criticality $M^{\circ2}+M^2=\theta M+\mathop{\mathrm{diag}}(s)$ restricts to each block and scales as $t_c^2$ against $t_c$, so $U_c$ is itself critical with $\theta_c=\theta/t_c>0$; unit norm gives $\theta=(\sum_c\theta_c^{-2})^{-1/2}$, the sum running over the edge-carrying components only. Take $a\in\mathbb R^{k'}$ non-zero with $\sum_ca_c\theta_c^{-2}=0$ (possible since $k'\ge2$) and set $N=\sum_ca_cM_c$. Then $N$ is hollow, symmetric, zero-row-sum, non-zero, orthogonal to $M$, **non-radial** (constant $a$ would force $a=0$), and $\mathcal LN=\theta N$ exactly. Hence $\lambda_{\max}(L_e)\ge1>\tfrac12$.

Tested against padded configurations, which is what broke the old statement, three of the six deliberately carry isolated vertices:

| construction | $n$ | #comp | edge-comp | $\dim\ker M$ | diag $\lambda_{\max}(L_e)$ |
|---|---|---|---|---|---|
| $S^3\!\times\!S^3\oplus S^4\!\times\!S^4$ + 1 isolated | 15 | 3 | 2 | 3 | $1.171428571$ |
| $S^3\!\times\!S^3\oplus S^3\!\times\!S^3$ + 2 isolated | 14 | 4 | 2 | 4 | $1.200000000$ |
| $S^2\!\times\!S^4\oplus S^3\!\times\!S^3$ + 3 isolated | 15 | 5 | 2 | 5 | $1.200000000$ |
| $S^2\!\times\!S^3\oplus S^2\!\times\!S^3$ + 1 isolated | 11 | 3 | 2 | 3 | $1.250000000$ |
| $S^3\!\times\!S^3\oplus S^3\!\times\!S^5$ | 14 | 2 | 2 | 2 | $1.171428571$ |
| $S^3\!\times\!S^3\oplus S^4\!\times\!S^4\oplus S^3\!\times\!S^3$ | 20 | 3 | 3 | 3 | $1.200000000$ |

All $\ge1$, criticality residuals $\le8.3\times10^{-17}$, and $\theta=(\sum\theta_c^{-2})^{-1/2}$ reproduced to nine digits. **No further padded configuration breaks it, and none can: padding adds isolated vertices, which contribute $t_c=0$ and drop out of the construction entirely.**

### The detection criterion, however, is still wrong

The record diagnoses disconnection by $\dim\ker M\ge2$. I confirm $\dim\ker M=\#\text{components}$ (zero mismatches over 230 of my own diagonal critical points) but that is precisely why the test is unfit for the repaired hypothesis: **isolated vertices inflate $\dim\ker M$ without contributing an edge-carrying component.** All four counterexamples above have $\dim\ker M\ge2$ and only one edge-carrying component. The correct test is a component analysis of the support graph $\{ab:M_{ab}\ne0\}$ counting only components with an edge; $\dim\ker M$ over-counts by exactly the number of isolated vertices. *The repair fixed the statement and left the test that produced the counterexamples in place.*

---

## D4. ADMISSIBILITY, **exponent CONFIRMED; the constant 8 REFUTED**

### Derivation

With $M=\bigoplus_c(\theta/\theta_c)U_c$ and $N=\sum_ca_cM_c$, the components are mutually orthogonal, so
$$\langle N,M\rangle=\sum_ca_c\lVert M_c\rVert^2=\sum_ca_c\frac{\theta^2}{\theta_c^2}\lVert U_c\rVert^2=\theta^2\sum_c\frac{a_c}{\theta_c^2}.$$

### Measurement

Over four direct sums ($S^3\!\times\!S^3\oplus S^4\!\times\!S^4$, $S^3\!\times\!S^3\oplus S^3\!\times\!S^5$, $S^4\!\times\!S^4\oplus S^5\!\times\!S^5$, and a three-summand case) with random $a$:

| inner product | $\langle N,M\rangle\,/\,\big(\theta^2\sum_ca_c\theta_c^{-2}\big)$ |
|---|---|
| $\Lambda^2$, $\langle A,B\rangle=\sum_{a<b}A_{ab}B_{ab}$ | $1.000000000$ |
| $n\times n$ Frobenius, $\sum_{ij}A_{ij}B_{ij}$ | $2.000000000$ |

**The constant is $1$ in the $\Lambda^2$ normalisation the rest of the file uses, or $2$ in the Frobenius normalisation. It is not $8$ in either, and no third normalisation in this repository produces $8$.** The exponent $-2$ is confirmed exactly.

Nothing downstream moves: the admissibility *condition* $\sum_ca_c\theta_c^{-2}=0$ is the vanishing locus of the pairing and is insensitive to the constant. Verified directly, the repaired $a$ gives $\cos(N,M)=10^{-16}$, $\lVert\mathcal LN-\theta N\rVert=10^{-17}$, row sums $10^{-17}$. **The reason to correct it is that a wrong constant invites a reader to re-derive and conclude the condition is wrong too.**

### "$\sum_ca_c=0$ enforces nothing", confirmed, and now with a formula

For two components, $\sum a_c=0$ forces $a=(t,-t)$ and gives
$$\cos(N,M)=\frac{\theta_2^2-\theta_1^2}{\theta_2^2+\theta_1^2},$$
verified to six digits at every sum tested. So the weak condition constrains nothing except when $\theta_1=\theta_2$. Measured: $0.842105$, $0.864693$, $0.875931$ for a $\theta=0.3086$ component paired with $S^3\!\times\!S^3$, $S^4\!\times\!S^4$, $S^5\!\times\!S^5$; and **$0.999868$** for a $\theta=0.009766$ census point paired with $S^5\times S^5$. The record's "reaches $0.99$" is confirmed, and the formula says the supremum is $1$, approached as the two $\theta_c$ separate.

---

## D5. THE SIGN TRAP, **CONFIRMED in full**

Padded $W_{\mathbb{CP}^2}$ built independently as the self-dual operator $\tfrac1{\sqrt6}(2\omega_1\omega_1^{\mathsf T}-\omega_2\omega_2^{\mathsf T}-\omega_3\omega_3^{\mathsf T})$ on $\Lambda^+(\mathbb R^4)\subset\Lambda^2(\mathbb R^n)$; distance to $\mathrm{Weyl}_n$ is $10^{-15}$, criticality residual $1.7\times10^{-16}$, spectrum $(2,-1,-1)/\sqrt6$.

| $n$ | branch | $\theta$ | $\Delta$ | $\lambda_{\max}(L_e|_{W^\perp})$ |
|---|---|---|---|---|
| 5, 6, 8 | $+W$ | $+1.224744871392=\sqrt{3/2}$ | $\mathbf{0.000000000}$ | $\mathbf{0.500000000}$ |
| 5, 6, 8 | $-W$ | $-1.224744871392$ | $\mathbf{12.000000000}$ | $\mathbf{0.500000000}$ |

Both $\Delta$ values and $\lambda_{\max}=\tfrac12$ confirmed exactly, at every padding.

**The mechanism, stated positively.** $\Delta$ traces over the strictly positive eigenspace of $W$. For $+W$ that eigenspace is the line $\mathbb R\omega_1$, and $\omega_1$ is an infinitesimal symmetry, so $g=0$. For $-W$ it is the plane $\langle\omega_2,\omega_3\rangle$, giving $12$. The eigenspace is what changes under $W\mapsto-W$; the operator does not.

**Which convention makes the record's statements true, stated precisely.**

1. **$\theta>0$ is forced, and forced by Lemma L24 itself.** The constrained Hessian is $6\theta(L_e-\tfrac12\mathrm{Id})$. Its sign as a maximality condition depends on $\mathop{\mathrm{sign}}\theta$: at $\theta>0$ maximality reads $\lambda_{\max}(L_e|_{W^\perp})\le\tfrac12$; at $\theta<0$ the inequality reverses to $\lambda_{\min}(L_e|_{W^\perp})\ge\tfrac12$. Only the first is the record's V3.
2. **$\lambda_{\max}(L_e)$ is branch-independent; $\Delta$ is not.** $L_{-W}=-L_W$ and $\theta_{-W}=-\theta$, so $L_e=L_W/\theta$ is *literally the same operator* on both branches. That is why the table's $\tfrac12$ appears twice. Any apparent branch-dependence of $\lambda_{\max}(L_e)$ is a sign slip from computing $\lambda_{\max}(L_{-W})/\theta_{-W}$, which is $\lambda_{\min}(L_e)$, not $\lambda_{\max}(L_e)$, the order reverses on division by a negative number. **This is a second, independent way the same trap fabricates a counterexample, and it is not on the record.**
3. So the fabrication is exactly: read $\Delta=12$ off $-W$, read $\lambda_{\max}(L_e)=\tfrac12$ off the operator (which is branch-blind), and report a point with $\Delta>0$ and $\lambda_{\max}\le\tfrac12$. The record's diagnosis is right and its convention ($\Delta$ evaluated on the branch with $\theta>0$), is the correct repair.

---

## Summary of verdicts

| claim | verdict |
|---|---|
| **D1** normalisation | **CONFIRMED** that $\lambda_{\max}(L_e)$ is the comparable quantity and that $0.608885$ at $\theta=1.088948053$ is exact with no residual factor of $\theta$. **REFUTED** that $1.025$ is a floor: connected $\Delta>0$ witnesses at $1.011905$ ($n=10$) down to $1.003205$ ($n=16$), critical to $10^{-16}$, with the minima following $1+\frac1{2(n-3)(n-4)}\to1$. |
| **D2** invariance | **CONFIRMED.** Invariance holds at non-critical, non-Ricci-flat diagonal $W$, with off-diagonal mass exactly $0$ and a two-line combinatorial proof. The inequality it is invoked for follows from self-adjointness alone and does not need it. |
| **D3** disconnected repair | Counterexamples **REPRODUCED** exactly, including $\cos(N,M)=+1.000000$. Repaired statement **CONFIRMED as a theorem**, with the proof above; no padded configuration can break it. The detection criterion $\dim\ker M\ge2$ was left unrepaired and still admits every counterexample. |
| **D4** admissibility | Exponent $-2$ **CONFIRMED**; constant $8$ **REFUTED**, it is $1$ ($\Lambda^2$) or $2$ (Frobenius). "$\sum a_c=0$ enforces nothing" **CONFIRMED**, with closed form $\cos=(\theta_2^2-\theta_1^2)/(\theta_2^2+\theta_1^2)$ and a measured $0.999868$. |
| **D5** sign trap | **CONFIRMED** in full: $\Delta=0$ / $\Delta=12$ and $\lambda_{\max}(L_e)=\tfrac12$ exactly, at $n=5,6,8$. |

## Claims found that the brief did not ask about

1. **Both diagonal census floors are population artefacts, and the true floor is $1$.** The file quotes $\lambda_{\max}(L_e)\ge1.025$ over 282 points and $\ge1.0417$ over 66 points, and reads the second as a factor-two cushion. Over 571 $\Delta>0$ diagonal critical points at $n=6\ldots16$ the minimum follows $1+\frac1{2(n-3)(n-4)}$ exactly in seven consecutive dimensions and tends to $1$. Every minimiser is **connected**, so the direct-sum lemma does not explain them. The stronger conjecture $\Delta>0\Rightarrow\lambda_{\max}\ge\theta$ survives unrefuted but is **sharp**, which changes what a proof of it would have to look like: no slack is available to spend.
2. **The constant $8$ in the admissibility pairing is wrong by a factor of $8$ or $4$** depending on normalisation. See D4.
3. **The $\Lambda^2$-versus-Frobenius factor of $2$ recurs here.** The file already records "the $\Lambda^2$ pairing is half of it" for the Rayleigh form; the same factor governs $\langle N,M\rangle$, and the two places should quote the same convention.
4. **A second face of the sign trap.** Beyond $\Delta$, the quantity $\lambda_{\max}(L_W)/\theta$ silently becomes $\lambda_{\min}(L_e)$ when $\theta<0$. Any script that computes $\lambda_{\max}$ then divides by $\theta$ will report the wrong end of the spectrum on the negative branch.
5. **The invariance argument's stated implication is over-strong.** "Invariant, so the full maximum dominates" reads as if invariance were load-bearing; self-adjointness alone gives it for any subspace. Worth correcting because it suggests the diagonal comparison would fail without invariance, when it would not.
6. **$\dim\ker M$ is the wrong instrument for the repaired hypothesis.** It counts isolated vertices, which are exactly what the repair excludes.

## Scripts

All under [scripts/reviewers/r310/](../scripts/reviewers/r310/): [lib310.py](../scripts/reviewers/r310/lib310.py) (the build), [census.py](../scripts/reviewers/r310/census.py) (random diagonal critical points), [blowups.py](../scripts/reviewers/r310/blowups.py) and [blowups2.py](../scripts/reviewers/r310/blowups2.py) (block-constant blow-up censuses), [d2b.py](../scripts/reviewers/r310/d2b.py) (D2), [d3d4.py](../scripts/reviewers/r310/d3d4.py) and [d3b.py](../scripts/reviewers/r310/d3b.py) (D3, D4), [d5.py](../scripts/reviewers/r310/d5.py) (D5). Log at [agent_logs/r310-diagonal-foldin.log](../agent_logs/r310-diagonal-foldin.log).

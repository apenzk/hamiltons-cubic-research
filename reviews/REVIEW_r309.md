# Review r309, the diagonal fold-in, five claims of [findings/diagonal-half.md](../findings/diagonal-half.md)

Adversarial Gate 2 audit of commits `2293bc0` and `e852c66`. Everything below is computed on an implementation written from the definitions in [scripts/reviewers/r309/](../scripts/reviewers/r309/); nothing is imported from [scripts/lib/](../scripts/lib/) and no number was taken from the record's prose.

**Verdicts: D1 CONFIRMED, D2 CONFIRMED, D3 CONFIRMED, D4 CONFIRMED (with a convention caveat), D5 CONFIRMED.** Three unasked-for findings are in the last section, one of them an arithmetic error in the same paragraph as D1.

---

## Independent implementation and its calibration

Basis of $\Lambda^2(\mathbb R^n)$: the orthonormal $\varphi_{ab}=e_a\wedge e_b$, realised as $E_{ab}-E_{ba}$ with $\langle A,B\rangle=\tfrac12\mathop{\mathrm{tr}}(A^{\mathsf T}B)$, structure constants $c_{\alpha\beta\gamma}=\langle[\varphi_\alpha,\varphi_\beta],\varphi_\gamma\rangle$ computed by matrix commutator. Sharp taken as $(R\#S)_{\alpha\beta}=\tfrac12\sum c_{\alpha\gamma\delta}c_{\beta\varepsilon\zeta}R_{\gamma\varepsilon}S_{\delta\zeta}$, $Q(W)=W^2+W^{\#}$, $P(W)=\langle W,Q(W)\rangle$, $L_WH=\tfrac12(WH+HW)+W\#H$, $L_e=L_W/\theta$. Weyl space built as the null space of (first Bianchi, Ricci) on $\mathrm{Sym}(\Lambda^2)$, dimensions came out $10,35,84,168,300$ at $n=4,\dots,8$, matching $n(n+1)(n+2)(n-3)/12$.

Calibration, all reproduced without reference to the record:

| check | result |
|---|---|
| $\theta$ at $S^3\!\times\!S^3$, $S^6\!\times\!S^6$ | $1.054092553$, $1.236033081$, equal to the closed form $\sqrt2c_n+2\sqrt2/(n\sqrt{(n-1)(n-2)})$ |
| criticality $Q(W)=\theta W$ at five sphere products | residual $\le1.7\times10^{-16}$ |
| graph formula $\theta=\tfrac12(\sum M_{ab}^3+\mathop{\mathrm{tr}}M^3)$ | agrees with $\langle W,Q(W)\rangle$ to $10^{-16}$ |
| symmetry defect: $\Lambda^2$ definition vs. the closed form $g_{ab}=2\sum_{d}(M_{ad}-M_{bd})^2$ | agree to $10^{-12}$ at a random diagonal $W$ ($\Delta=4.757638162981$ both ways) |

That fixes the normalisation before any claim is tested.

---

## D1, NORMALISATION. **CONFIRMED.**

**The witness.** [w_n8_nondiagonal_witness.npy](../scripts/data/w_n8_nondiagonal_witness.npy) is a genuine non-diagonal Weyl critical point on my own machinery: symmetric, Bianchi $2.6\times10^{-16}$, Ricci $5.1\times10^{-16}$, $\lVert W\rVert^2=1$, off-diagonal mass $0.164$, criticality residual $5.0\times10^{-16}$, and

$$\theta=1.0889480525050481$$

against the brief's $1.088948053$. On $\mathrm{Weyl}_8\cap W^\perp$ (dimension $299$ of $300$):

- $\lambda_{\max}(L_W|_{W^\perp})=0.663044622$ (raw, undivided)
- $\lambda_{\max}(L_e|_{W^\perp})=0.663044622/1.088948053=\mathbf{0.608885447}$
- $\lambda_{\max}(L_e)/\theta=0.559150132$

So the record's $0.608885$ **is** $\lambda_{\max}(L_e)=\lambda_{\max}(L_W)/\theta$. The rest of that eigenvalue's spectrum is a wall of exact $\tfrac12$'s (the orbit directions), with $0.608885$ the single value above them.

**The diagonal floor.** I built my own census: solve the projected criticality equation $P_{\mathcal B}[M^{\circ2}+M^2]=\theta M$ on the space of hollow symmetric zero-row-sum matrices from $250$ random starts at each $n=5,\dots,10$, keeping solutions with residual $\le10^{-11}$, deduplicated by spectrum and sorted entry list. That gives **272 distinct diagonal critical points, 114 of them with $\theta>0$ and $\Delta>0$**, and

| $n$ | 5 | 6 | 7 | 8 | 9 | 10 |
|---|---|---|---|---|---|---|
| $\Delta>0$, $\theta>0$ points | 0 | 1 | 5 | 17 | 31 | 60 |
| $\min\lambda_{\max}(L_e)$ |, | $2.3155218$ | $\mathbf{1.0416666667}$ | $\mathbf{1.0250000000}$ | $1.0519484$ | $1.3035838$ |

The overall floor is $1.0250000000$, hit at an $n=8$ point with $\theta=0.681429$, $\Delta=2.0896$. **Both of the record's quoted figures land exactly**: $1.025$ and, at $n=7$, $1.0416666667$, the $1.0417$ the record quotes elsewhere as "$\lambda_{\max}/\theta$". Two more of the record's numbers fall out of the same census as free corroboration: an $n=10$ point with $\Delta=12.074836$ and $\lambda_{\max}(L_e)=1.303583780$, which is the record's "unpadded $n=9$ witness, $\Delta=12.07$, diagonal $\lambda_{\max}=1.303584$" carrying one padding vertex.

**Same quantity as each other?** Yes. The decisive cross-check is the lossiness table, which I reproduced digit for digit on my own code without looking at it first:

| point | my diagonal $\lambda_{\max}(L_e)$ | my full $\lambda_{\max}(L_e)$ | record |
|---|---|---|---|
| $S^2\!\times\!S^3$ | $0.250000$ | $0.750000$ | $0.250000$ / $0.750000$ |
| $S^2\!\times\!S^4$ | $0.333333$ | $0.666667$ | $0.333333$ / $0.666667$ |
| $S^2\!\times\!S^6$ | $0.400000$ | $0.600000$ | $0.400000$ / $0.600000$ |
| $S^3\!\times\!S^5$ | $0.375000$ | $0.500000$ | $0.375$ / $0.500$ |
| $S^6\!\times\!S^6$ | $0.400000$ | $0.500000$ | $0.400$ / $0.500$ |

Those are $\lambda_{\max}(L_W)/\theta$ in my code. So the census column, the lossiness table and the witness are all one quantity, $\lambda_{\max}(L_e)$, and the repair introduced no new factor of $\theta$ in either direction. **The claim as stated is correct.** (The record's own $0.608885$ vs $1.025$ comparison is nonetheless mis-worded, see finding F1 below.)

---

## D2, THE INVARIANCE ARGUMENT. **CONFIRMED**, and the invariance is stronger than critical.

**Invariance at non-critical $W$.** For $W=\mathrm{diag}(w)$ and $H=\mathrm{diag}(h)$ both in $\mathcal W_n$, the off-diagonal mass of $L_WH$ is **exactly $0.0$** (bit-exact, not merely small), at $n=5,6,7$ with criticality residual $0.24$ to $0.32$, i.e. genuinely non-critical $W$. It stays exactly $0.0$ when $W$ and $H$ are diagonal but **not Ricci-flat** (row sums up to $4.66$). The $n\times n$ compression matches the pair matrix of $L_WH$ to $\le9\times10^{-16}$:

$$(L_WH)_{(ab)(ab)}=M_{ab}N_{ab}+\tfrac12(MN+NM)_{ab}.$$

I also re-derived the combinatorial reason rather than measuring it: $c_{\alpha\gamma\delta}\ne0$ requires $\gamma,\delta$ to share exactly one index and $\alpha$ to be the third pair on those three vertices, so $\gamma,\delta$ **determine** $\alpha$; hence $(W\#H)_{\alpha\beta}=\tfrac12\sum_{\gamma\delta}c_{\alpha\gamma\delta}c_{\beta\gamma\delta}w_\gamma h_\delta$ vanishes for $\alpha\ne\beta$. No criticality, no Ricci-flatness, no Bianchi enters. The hollowing is likewise forced: the off-diagonal row sums of $M\circ N+\tfrac12(MN+NM)$ come to $\langle M_a,N_a\rangle+0-\langle M_a,N_a\rangle=0$ exactly when $M\mathbf1=N\mathbf1=0$, which is Ricci-flatness being preserved.

**The inequality.** Tested at 14 diagonal critical points at $n=6,7$ and at 6 non-critical diagonal $W$: diagonal $\lambda_{\max}(L_e)\le$ full $\lambda_{\max}(L_e)$ in every case, no violation. Equality at every $\Delta>0$ point in the sample; strict loss at every $\Delta=0$ sphere product. So exceeding $\tfrac12$ inside the locus does certify second-order failure, given the standing hypotheses of Lemma L24 ($W$ critical, $\theta>0$).

**One over-claim, not an error.** The record derives the inequality *from* invariance ("the diagonal locus is an $L_W$-invariant subspace … so the full $\lambda_{\max}$ is never below the diagonal one"). The inequality needs no invariance at all: for a symmetric operator, the top eigenvalue of the compression to *any* subspace is a max of Rayleigh quotients over that subspace, hence $\le$ the top eigenvalue on the whole space. What invariance actually buys is that the locus's top eigenvector is a genuine eigenvector of the full $L_W$ with the same eigenvalue, which is why the $\Delta>0$ rows above come out *equal* rather than merely bounded. The conclusion stands; the stated reason is sufficient but not necessary.

---

## D3, THE DISCONNECTED-LEMMA REPAIR. **CONFIRMED**, and the repaired statement is a theorem, not just an unbroken guess.

**The counterexamples reproduce exactly.** Padding a sphere product with isolated vertices preserves criticality (the padded rows are identically zero, so both sides of the off-diagonal equation vanish) and preserves $\theta$ (it does not change $\mathop{\mathrm{tr}}M^2$):

| point | $n$ | $\theta$ | crit. residual | $\dim\ker M$ | components | $\Delta$ | $\lambda_{\max}(L_e)$ diag = full | record |
|---|---|---|---|---|---|---|---|---|
| $S^4\!\times\!S^4$ + 1 vertex | 9 | $1.145644$ | $8.3\times10^{-17}$ | 2 | 2 | $0$ | $\mathbf{0.571429}$ $(=4/7)$ | $0.5714$ |
| $S^3\!\times\!S^3$ + 1 vertex | 7 | $1.054093$ | $2.8\times10^{-17}$ | 2 | 2 | $0$ | $\mathbf{0.600000}$ | $0.600$ |
| $S^3\!\times\!S^4$ + 1 vertex | 8 | $1.095445$ | $2.8\times10^{-17}$ | 2 | 2 | $0$ | $\mathbf{0.583333}$ | $0.583$ |

All three are disconnected by the criterion, all have $\theta>0$, and all sit far below $\lambda_{\max}(L_e)=1$. The old statement ("every disconnected diagonal critical point with $\theta>0$ has $\lambda_{\max}\ge\theta$"), is refuted by each of them. The $\cos(N,M)=+1$ observation is right and is structural, not numerical: the isolated vertex's component contributes $M^{(c)}=0$, so the component-indicator family degenerates to $N=a_1M$, which is the radial direction and carries $\langle N,M\rangle=2a_1\ne0$.

**The repaired statement is true, with a proof.** Let $M$ be a diagonal critical point, $G$ its support graph, and $M^{(c)}$ the restriction of $M$ to component $c$. Because $M$ is block diagonal over the components, $(M^2)_{ab}=((M^{(c)})^2)_{ab}$ for $a,b\in c$, so the ambient off-diagonal equation restricts verbatim: **each component block satisfies $M^{(c)\circ2}+(M^{(c)})^2=\theta M^{(c)}+\mathrm{diag}(\cdot)$ with the same $\theta$**, with no appeal to any direct-sum construction. Hence for $a$ constant on components, $N=\sum_ca_cM^{(c)}$ is hollow, has zero row sums, and

$$\mathcal L N=\mathrm{hollow}\Big(\sum_ca_c\big[M^{(c)\circ2}+(M^{(c)})^2\big]\Big)=\theta N .$$

If at least two components carry an edge, $M^{(1)},M^{(2)}\ne0$ and $a=(\lVert M^{(2)}\rVert^2,-\lVert M^{(1)}\rVert^2,0,\dots)$ gives $N\ne0$ with $\langle N,M\rangle=0$, so $\lambda_{\max}(L_e|_{W^\perp})\ge1>\tfrac12$. Edge-free components (exactly what padding creates), contribute nothing, which is precisely why "carrying an edge" is the right qualifier.

Verified numerically at six direct sums, including ones padded with 1, 2 and 3 isolated vertices: row sums of $N$ at $10^{-16}$, $\cos(N,M)$ at $10^{-17}$, $\lVert\mathcal LN-\theta N\rVert_\infty\le1.1\times10^{-16}$, Rayleigh quotient $/\theta=1.000000000$, and $\lambda_{\max}(L_e)$ between $1.171$ and $1.225$. The value law $1/\theta^2=\sum_i1/\theta_i^2$ held exactly at every one.

**No further padded configuration can break it**, because padding only ever adds edge-free components and the proof above quantifies over edge-carrying ones only. I looked for a break in the other direction too and found none.

**Side claim checked while here.** $\dim\ker M=\#\text{components}$ held at **all 272** of my distinct diagonal critical points, zero exceptions. The inequality $\ge$ is free (each $\mathbf1_c\in\ker M$); the $\le$ direction (the one the disconnectedness criterion actually consumes), remains verified rather than proved.

---

## D4, ADMISSIBILITY. **CONFIRMED**, with the constant's convention needing to be named.

**The inner product, derived.** With $M=\bigoplus_c M^{(c)}$ and $\lVert M^{(c)}\rVert_F^2=2\theta^2/\theta_c^2$ (criticality forces the block scaling $\theta/\theta_c$, and each unit block has $\mathop{\mathrm{tr}}M_c^2=2$),

$$\Big\langle \sum_ca_cM^{(c)},\,M\Big\rangle_F=\sum_ca_c\lVert M^{(c)}\rVert_F^2=2\theta^2\sum_c\frac{a_c}{\theta_c^{2}} .$$

**Exponent $-2$: CONFIRMED, exactly.** Fitting $\langle N,M\rangle/(\theta^2\sum a_c\theta_c^{-p})$ over five direct sums with 2, 3 and 4 blocks gives a constant ratio only at $p=2$ ($2.000000000$ every time); $p=1$ and $p=3$ scatter over $0.749,\,1.262,\,1.625,\,2.219,\,5.467$ and $-5.140,\,1.319,\,1.854,\,2.547,\,3.613$.

**Constant $8$: right under one convention, and the record does not say which.** The constant is fixed by how $N$ is built from $a$, and the record leaves that implicit:

| definition of $N$ | $\langle N,M\rangle_F/(\theta^2\sum_ca_c\theta_c^{-2})$ |
|---|---|
| $N=\sum_ca_cM^{(c)}$, equivalently $\tfrac12(AM+MA)$ | $2$ |
| $N=AM+MA$, $A=\mathrm{diag}(a)$ | $4$ |
| $N=D_AW+WD_A$ at the $\Lambda^2$ level, $D_A\varphi_{ab}=(a_a+a_b)\varphi_{ab}$ | $\mathbf{8}$ |

So $8$ is correct for the $\Lambda^2$-level anticommutator with the induced diagonal operator, measured with the $n\times n$ Frobenius pairing, a natural reading, but one of three, and the sanity check $a_c\equiv1$ pins it instantly ($N=2M$ at the $\Lambda^2$ level, $\langle N,M\rangle_F=8$, $\theta^2\sum\theta_c^{-2}=1$). I mark this CONFIRMED rather than refuted, with the recommendation that the definition of $N$ be written next to the formula.

**Which family the record used, settled from its own numbers.** The three cosines quoted for the earlier inadmissible deformation reproduce on my code only for $A=\mathrm{diag}(a)$ with $a$ constant on components and $\mathop{\mathrm{tr}}A=0$ (vertex-weighted, not $\sum_ca_c=0$):

| sum | my $\cos(N,M)$ | record |
|---|---|---|
| $S^3\!\times\!S^3\oplus S^4\!\times\!S^4$, $a=(8,-6)$ | $+0.221123$ | $+0.221$ |
| $S^3\!\times\!S^5\oplus S^3\!\times\!S^3$, $a=(6,-8)$ | $-0.195910$ | $-0.196$ |
| $S^4\!\times\!S^4\oplus S^5\!\times\!S^5$, $a=(10,-8)$ | $+0.155680$ | $+0.156$ |

**"$\sum_ca_c=0$ enforces nothing": CONFIRMED, and my bound is tighter than the record's.** For two blocks with $a=(1,-1)$ the cosine is $\lvert\theta_2^2-\theta_1^2\rvert/(\theta_1^2+\theta_2^2)$, which $\to1$ as the $\theta$'s separate. Over pairs drawn from my own 128 positive-$\theta$ census blocks the maximum reached is $\mathbf{0.999987}$ (blocks at $\theta=0.002688$ and $\theta=1.054093$), against the record's $0.99$. Row sums are zero for *every* $a$ constant on components, so the row-sum check the earlier work performed is vacuous as a test of admissibility, the record's diagnosis is right.

---

## D5, THE SIGN TRAP. **CONFIRMED**, and it is sharper than stated.

I built $W_{\mathbb{CP}^2}$ myself from the self-dual forms, $W=2\omega_1\otimes\omega_1-\omega_2\otimes\omega_2-\omega_3\otimes\omega_3$ on $\Lambda^+$, zero on $\Lambda^-$, with $\omega_1=(e_1\wedge e_2+e_3\wedge e_4)/\sqrt2$ and its cyclic partners, checked Bianchi and Ricci vanish identically, then normalised and padded into $\mathbb R^n$.

| $n$ | 4 | 5 | 6 | 7 | 8 | 9 |
|---|---|---|---|---|---|---|
| $\theta$ | $+1.224744871$ | $+1.224744871$ | $+1.224744871$ | $+1.224744871$ | $+1.224744871$ | $+1.224744871$ |
| crit. residual | $\le1.7\times10^{-16}$ at every $n$ | | | | | |
| $\Delta(+W)$ | $0.000000$ | $0.000000$ | $0.000000$ | $0.000000$ | $0.000000$ | $0.000000$ |
| $\Delta(-W)$ | $12.000000$ | $12.000000$ | $12.000000$ | $12.000000$ | $12.000000$ | $12.000000$ |
| $\lambda_{\max}(L_e\vert_{W^\perp})$ | $0.500000000000$ | $0.500000000000$ | $0.500000000000$ | $0.500000000000$ | $0.500000000000$ | $0.500000000000$ |

Both $\Delta$ values and the $\lambda_{\max}=\tfrac12$ are exact, and $\theta=\sqrt{3/2}$ in closed form. $\Delta(+W)=0$ because the positive eigenspace of $W$ is the single line $\omega_1$, whose $\mathrm{ad}$ commutes with $W$; $\Delta(-W)=12$ because the positive eigenspace of $-W$ is the two-dimensional $\{\omega_2,\omega_3\}$, which does not.

**The precise convention, and why it is forced.** $Q$ is quadratic, so $Q(-W)=Q(W)$ and $-W$ is critical whenever $W$ is, with $P(-W)=-P(W)$. But $e=W/\theta$ is *the same element* for the pair ($(-W)/(-\theta)=W/\theta$) so $L_e$, and hence the entire spectrum including $\lambda_{\max}$, is **literally identical on the two branches**. $\Delta$ is the only thing that differs, because it traces over the strictly positive eigenspace and that swaps. So the record's statement is exactly right and admits no weaker reading:

> $\Delta$ must be evaluated at the representative of the pair $\{W,-W\}$ for which $\theta=P(W)>0$, the representative Lemma L24's hypothesis names. Reading $\Delta$ at $-W$ while reading $\lambda_{\max}(L_e)$ at either produces $\Delta=12>0$ alongside $\lambda_{\max}(L_e)=\tfrac12$, an apparent counterexample to "$\Delta>0\Rightarrow\lambda_{\max}(L_e)>\tfrac12$" that is an artefact of mixing branches.

On the correct branch the point reads $\Delta=0$, $\lambda_{\max}(L_e)=\tfrac12$, the equality case, consistent with the conjecture in its strict form.

---

## Findings the brief did not ask for

**F1, an arithmetic error in the D1 paragraph itself.** The record writes that the witness at $\lambda_{\max}(L_e)=0.608885$ is "**less than half the diagonal floor**" of $1.025$. Half of $1.025$ is $0.5125$, and $0.608885>0.5125$: the witness is $59.4\%$ of the floor, not less than half. The two companion figures in the same sentence are right, $0.608885/0.5=1.2178\approx1.22\times$ and $1.025/0.5=2.05\times$, so only the "less than half" phrase needs to go, to something like "under $60\%$ of the diagonal floor". The claim it supports (the cushion is diagonal-only) is unaffected.

**F2, "$a_c\propto\theta_c^2$" is false as written.** The admissibility condition $\sum_ca_c\theta_c^{-2}=0$ is a hyperplane; $a_c=k\theta_c^2$ gives $\sum_ca_c\theta_c^{-2}=k\cdot\#\text{components}\ne0$ for $k\ne0$. The intended reading must be $\lvert a_c\rvert\propto\theta_c^2$ with signs summing to zero, for two components, $a\propto(\theta_1^2,-\theta_2^2)$, which is what I used above and which does give orthogonality at $10^{-17}$. As a one-line gloss on the condition it is misleading and should be dropped or corrected.

**F3, the notation "$\lambda_{\max}/\theta$" is used for $\lambda_{\max}(L_e)$ in three places, including the paragraph that declares quoting it the error.** Every printed number in [findings/diagonal-half.md](../findings/diagonal-half.md) is in the $L_e$ normalisation, I verified this at the sphere-product table, at the $1.025$ and $1.0417$ census floors, at the $1.303584$ witness, and at the padded points' $0.5714/0.600/0.583$, so there is no residual factor-of-$\theta$ defect anywhere. But the file writes "$\lambda_{\max}/\theta=0.5714$" and "the minimum of $\lambda_{\max}/\theta$ is $1.0417$" for quantities it elsewhere insists must be called $\lambda_{\max}(L_e)$ and not $\lambda_{\max}/\theta$. Since bare "$\lambda_{\max}$" is used for both $\lambda_{\max}(\mathcal L)$ and $\lambda_{\max}(L_e)$ depending on the paragraph, the file is one careless read away from re-introducing the very error it just repaired. A single sentence fixing $\lambda_{\max}:=\lambda_{\max}(L_e)=\lambda_{\max}(\mathcal L)/\theta$ throughout would close it.

**F4, no counterexample to the diagonal half of V3.** Across my 114 independent diagonal critical points with $\theta>0$ and $\Delta>0$ at $n=5,\dots,10$, none has $\lambda_{\max}(L_e)\le\tfrac12$; the minimum is $1.025$, and every one of them clears $1$, corroborating the stronger form $\Delta>0\Rightarrow\lambda_{\max}(L_e)\ge1$ the record notes.

---

*Scripts: [scripts/reviewers/r309/core.py](../scripts/reviewers/r309/core.py) (structure constants, sharp, Weyl basis, $L_W$, defect, the $n\times n$ compression) and [scripts/reviewers/r309/census.py](../scripts/reviewers/r309/census.py) (critical-point solver, closed-form defect, deduplication). Log: [agent_logs/r309-diagonal-foldin.log](../agent_logs/r309-diagonal-foldin.log).*

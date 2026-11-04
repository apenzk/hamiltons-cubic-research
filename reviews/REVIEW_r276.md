# REVIEW r276, Gate 2, route M's reduction chain

Reviewer 276. Commits under review: `e5f8cbe` (primary), `72c73d2` / `e84e9af`, `7136a12` / `6b7eae1`.
Primary files: [run_m_falsifier.py](../scripts/runs/run_m_falsifier.py), [plan.md](../plan.md), [fence-posts.md](../findings/fence-posts.md) post F34, [second-order.md](../findings/second-order.md), [ad-form-attempt.md](../findings/ad-form-attempt.md).
Scripts: [scripts/reviewers/r276/](../scripts/reviewers/r276/). Reviewer 275 runs the identical brief concurrently and independently.

Every number below comes from machinery written for this review, [r276_core.py](../scripts/reviewers/r276/r276_core.py): structure constants from matrix commutators, `sharp` cross-checked against [curvature_operator.py](../scripts/curvature_operator.py)'s slow quadratic-form reference to $9\times10^{-15}$ at $n=5,6,7$, gradients finite-difference checked to $10^{-9}$, and the maximisation done by **quasi-Newton (L-BFGS-B)** rather than projected-gradient ascent. Nothing outside [r276_c3d_randweyl.py](../scripts/reviewers/r276/r276_c3d_randweyl.py), which exists to test [r274](../scripts/reviewers/r274/)'s `rand_weyl`, claim 3(d), touches `scripts/reviewers/r274/`.

| # | Claim | Verdict |
|---|---|---|
| 1 | Route M's reduction chain | **REFUTED AT LINK (b), AND NO CONSTANT REPAIRS IT AT ANY EVEN $n\le354$.** The $\sqrt2$ is the harmonic-square law's $1/\sqrt k$ with $k\ge2$ $\circ$-summands, so it applies to $\circ$-**decomposable** points only, the complement of the residual the cap is stated on. On the residual the cap gives $\theta\le\sqrt3=1.732$, above $\theta_0(n)$ at every $n$. And the quantity itself is too big on the residual: padded $W_{\mathbb{CP}^2}$ is $\circ$-indecomposable ($\dim E(1)=1$, recomputed), non-diagonal, critical to $1.4\times10^{-16}$, with $\theta=\sqrt{3/2}$ but $\mathop{\mathrm{tr}}(M^3)+\lVert M^\#\rVert_F=1+\tfrac1{\sqrt6}=1.408248290464$ **at every $n$**, and $\theta_0(n)$ does not reach that until $n=356$. Links (a), (c), (d) hold |
| 2 | Is the target a rearrangement? | **NOT A RESTATEMENT, AND POST F11'S FENCE DOES TRANSFER, AS A METHOD.** $F=\mathop{\mathrm{tr}}(M^3)+\lVert M^\#\rVert_F$ is not $\theta$ with symbols substituted: at the $n=12$ maximiser $F/\theta=1.185$, $\cos\varphi=0.7617$. So post F34's identity mechanism does not apply and plan.md is right that the *statement* is new. But the *split* floor does transfer verbatim: $\sup\mathop{\mathrm{tr}}(M^3)+\sup\lVert M^\#\rVert_F$ measures $1.5547,\,1.6802,\,\mathbf{1.8415},\,\mathbf{1.9454}$ at $n=6,8,10,12$, **past $\sqrt3$ from $n=10$ on**, climbing to post F11's $1+\sqrt2$. Any proof that estimates the two terms separately is fenced |
| 3 | The falsifier screen | **(a) REPRODUCED EXACTLY** by an independent optimiser: $1.412822,\,1.420489,\,1.425703,\,1.429351,\,1.432024$ against the plan's $1.4128,\,1.4205,\,1.4257,\,1.4294,\,1.4320$. **(b) the maximum looks global**, 135/75/42 starts including sphere products, $\mathbb{CP}^2$ paddings, r274's saved optima and perturbations all land on the same value. **(c) THE EXTRAPOLATION IS NOT DEFENSIBLE**: the increment ratios *rise* ($0.680,0.700,0.733$), so the tail is sub-geometric, and a fit with $F_\infty$ **fixed at $\sqrt3$** matches the five points to $6\times10^{-4}$. **(d) `rand_weyl` is sound**, Bianchi $10^{-17}$, Ricci $5\times10^{-17}$ |
| 4 | Post F34's exact excess formula | **CORRECT AS THE *RELATIVE* EXCESS, MISLABELLED AS THE EXCESS.** $m/[(2m-1)(u+\sqrt{u^2+m^2-m})]$ reproduces $F/\theta_0-1$ to ten digits at $n=6\dots1000$; the excess of the displayed inequality $F\le\theta_0$ is $\theta_0$ times larger ($0.0062266$ against $0.0050376$ at $n=12$). Asymptotics $\tfrac1{2n^2}$ right for the ratio. **Separately, ad-form-attempt.md's $\lVert M^\#\rVert_F$ closed form is wrong by a factor $\sqrt m$** |
| 5 | Route N's premise | **STRUCTURAL, AND THE MARGIN AT THE CROSSOVER IS EXACTLY ZERO.** Theorem 4.17's only $n$-dependent input is "$f\le1$ on $[0,\pi]$", i.e. $W_{\mathbb{CP}^2}$ is the global maximiser, true below $n=6+2\sqrt7$, false at $n\ge12$. With the correct $\Gamma_1(\alpha)=(1+\alpha)\sqrt{1-2\alpha}$ the closing estimate is $\tilde f(\pi/6)\big|_{\alpha=1/3}=0$ **identically**, so every $c>1$ turns it positive. Route M's own cap as the replacement constant makes it $+0.372$ |
| 6 | The validation ledger (r261/r262) | **VALIDATED.** Computed from scratch: on $V^{\otimes4}$ with $V=\mathbb R^4$, $\dim\mathrm{Inv}_{SO(4)}=4$ against $\dim\mathrm{Inv}_{O(4)}=3=$ the Brauer-diagram rank, the gap being exactly $\varepsilon$. So Brauer $\to\mathrm{End}_{SO}$ is not surjective in type $D$, and the record's rescue (the programme's group is $O(n)$), is the right one, and load-bearing |

---

## Claim 1, route M's reduction chain

Evidence: [r276_c1_e1.py](../scripts/reviewers/r276/r276_c1_e1.py), [out_c1_e1.txt](../scripts/reviewers/r276/out_c1_e1.txt), [r276_c3_opt.py](../scripts/reviewers/r276/r276_c3_opt.py).

### (a) The sum law does reduce to indecomposables, under three hypotheses

Re-derived from the definitions. $Q$ is the quadratic form of $\circ$, so for $W=\sum_ia_iA_i$ with the $A_i$ pairwise $\circ$-orthogonal, unit, and **each critical** ($Q(A_i)=\theta_iA_i$), $Q(W)=\sum_ia_i^2\theta_iA_i$; criticality of $W$ forces $a_i\theta_i=\theta$ for every $i$ with $a_i\ne0$, and $\sum a_i^2=1$ gives

$$\frac1{\theta^2}=\sum_i\frac1{\theta_i^2},\qquad\text{hence}\qquad|\theta|\le\frac{\max_i|\theta_i|}{\sqrt k}.$$

The three hypotheses, pairwise $\circ$-orthogonality, **criticality of each piece**, and $k\ge2$ pieces with $a_i\ne0$, are all load-bearing, and the third is the one the chain later loses. Granting them, decomposable critical points cannot set a new maximum and the residual is the $\circ$-indecomposable ones. **Link (a) holds.**

### (b) The $\sqrt2$ belongs to the complement of the residual, REFUTED

$M(n)\le\sqrt3$ *does* follow from a cap on indecomposables: the global maximiser of $P$ on the unit sphere is a critical point, either indecomposable (so $\theta\le\mathop{\mathrm{tr}}(M^3)+\lVert M^\#\rVert_F\le\sqrt3$ by hypothesis) or decomposable (so $\theta\le M(n)/\sqrt2$, which forces $M(n)\le0$ unless the first branch binds). That much of link (b) is sound.

**The next step is not.** $|\theta|\le M(n)/\sqrt2$ is the display above with $k\ge2$, so it speaks about $\circ$-**decomposable** critical points and about nothing else. An indecomposable critical point has $k=1$ and inherits only $\theta\le\sqrt3=1.7321$, which exceeds $\theta_0(n)$ at every $n$ (indeed $\theta_0<\sqrt2$ always). plan.md's *"hence every non-diagonal critical point has $\theta\le\sqrt{3/2}$"* therefore applies the factor exactly where its hypothesis fails, on the residual the sum law was invoked to isolate. [second-order.md](../findings/second-order.md) states the two facts four sentences apart ("the residual narrows to $\circ$-**indecomposable** non-diagonal $S=0$ points … What the cap needs is $|\theta|\le M(n)/\sqrt2$"); the plan reads them as one chain.

**The standing witness is the record's own sharp case.** Padded $W_{\mathbb{CP}^2}$ at $n=12$, rebuilt here from the self-dual $(2,-1,-1)/\sqrt6$ form on $\mathbb R^4\subset\mathbb R^{12}$:

| | value |
|---|---|
| in $\mathrm{Weyl}_{12}$ | fixed by the Weyl projector to $0$ |
| critical | $\lVert Q(W)-\theta W\rVert=1.4\times10^{-16}$ |
| $\theta$ | $1.2247449=\sqrt{3/2}$, i.e. $0.99087\,\theta_0(12)$ |
| $\circ$-indecomposable | $\dim E(1)$ of $L_e$ on $\mathrm{Weyl}_{12}$ $=\mathbf1$ (also $1$ at $n=6,8$) |
| non-diagonal | frame-minimal off-diagonal mass $0.707$, Plücker obstruction $0.50$ (record) |
| $\mathop{\mathrm{tr}}(M^3)+\lVert M^\#\rVert_F$ | $\mathbf{1.408248}$ |

So at the one point the residual is sharp at, the target quantity is $1.4082$, not $\sqrt{3/2}=1.2247$ and not $\theta_0(12)=1.2360$.

**And this is why no constant repairs the chain.** Whatever cap $C$ is proved on $\mathop{\mathrm{tr}}(M^3)+\lVert M^\#\rVert_F$ over indecomposables, the conclusion it yields on the residual is $\theta\le C$, and $C\ge1.408248$ is forced by an indecomposable **critical** point already on file. Since $1.408248>\theta_0(12)=1.236033$, **the $\lVert M^\#\rVert_F$ relaxation cannot close Conjecture A on the residual at $n=12$, at any constant.**

**The obstruction is exact, and it persists to $n=355$.** Zero-padding $W_{\mathbb{CP}^2}$ lands in $\mathrm{Weyl}_n$ for every $n\ge4$ (fixed by the projector to $0$) and leaves all three quantities untouched, measured identical to twelve digits at $n=4,6,8,10,12,14,16$:

$$\mathop{\mathrm{tr}}(M^3)=\tfrac1{\sqrt6},\qquad \lVert M^\#\rVert_F=1,\qquad \cos\varphi=\sqrt{\tfrac23},\qquad \theta=\tfrac3{\sqrt6}=\sqrt{\tfrac32},\qquad F=1+\tfrac1{\sqrt6}.$$

So $\sup_{\text{residual}}F\ge1+\frac1{\sqrt6}$ at every even $n$, while $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ first reaches $1+\frac1{\sqrt6}$ at $n=355.695$: $\theta_0(354)=1.4082197<1.4082483<1.4082534=\theta_0(356)$. **For every even $n$ from $12$ to $354$, no cap on $\mathop{\mathrm{tr}}(M^3)+\lVert M^\#\rVert_F$ over the residual can imply $\theta\le\theta_0(n)$ there.** The loss is the one post F34 names, now at the residual's sharp point: $\cos\varphi=\sqrt{2/3}$ exactly, so dropping it costs $15.0\%$ where the conjecture has $0.913\%$ of room.

### (c) The $n$-range is right, and $n=12$ is the tight case, CONFIRMED

$\theta_0(n)^2=2(n-1)(n-2)/n^2>3/2\iff n^2-12n+8>0\iff n>6+2\sqrt7=11.291503$. So $\sqrt{3/2}<\theta_0(n)$ for every even $n\ge12$ and the crossover is exactly the plan's $6+2\sqrt7$. At $n=12$, $\theta_0(12)=\sqrt{55}/6=1.2360330$ against $\sqrt{3/2}=1.2247449$, a margin of $0.0112881$, **$0.913\%$**, and padded $W_{\mathbb{CP}^2}$ realises $\theta=\sqrt{3/2}$ there. $n=12$ is not merely the first case; it is the one with almost no room.

### (d) The grant is legitimate as a hypothesis, with the record's own caveat, CONFIRMED

[README.md](../README.md) grants the diagonal case, so plan.md may assume it. The record is honest about what that costs: [problem.md](../findings/problem.md) records that Jäger's Theorem A covers only even $n\ge16$, so $n=12,14$ (the dimensions the conjecture first bites in), are granted rather than published, with [LEDGER.md](../findings/LEDGER.md) marking Lemma L1 never audited and deliberately out of scope. Legitimate, and correctly flagged.

---

## Claim 2, is the target inequality a rearrangement?

Evidence: [r276_c2_split.py](../scripts/reviewers/r276/r276_c2_split.py), [out_c2.txt](../scripts/reviewers/r276/out_c2.txt).

**It is not post F34's mechanism.** Post F28 and post F34 both fail because a defined quantity is substituted back in: $\cos\varphi:=\langle M^\#,M\rangle/\lVert M^\#\rVert_F$ makes $\mathop{\mathrm{tr}}(M^3)+\lVert M^\#\rVert_F\cos\varphi\le\theta_0$ literally $\theta\le\theta_0$. Route M's $F=\mathop{\mathrm{tr}}(M^3)+\lVert M^\#\rVert_F$ drops $\cos\varphi$ instead of naming it, and the two functions are genuinely different: at the $n=12$ maximiser of $F$, $F=1.429351$ while $\theta=1.206055$, a ratio of $1.185$ with $\cos\varphi=0.7617$. **No restatement.**

**Its logical position.** $F\ge\theta$ pointwise, so $F\le\sqrt3$ is strictly stronger than $M(n)\le\sqrt3$; and it is strictly weaker than $F\le\theta_0(n)$, which post F34 refutes at every even $n\ge4$. It neither implies nor follows from Conjecture A ($\sqrt3>\theta_0(n)$ always). So plan.md is right that the statement is open and new.

**Post F11 fences it as a method, from $n=10$ on.** Post F11's floor is about splitting $\theta$'s two terms; the same split applied to $F$ gives $\sup F\le\sup\mathop{\mathrm{tr}}(M^3)+\sup\lVert M^\#\rVert_F$, and both suprema are measurable:

| $n$ | $\sup\lVert M^\#\rVert_F$ | $\sup\mathop{\mathrm{tr}}(M^3)$ | split bound | $\sqrt3$ | $\sup F$ |
|---|---|---|---|---|---|
| 6 | 1.010072 | 0.544614 | 1.554686 | 1.732051 | 1.412822 |
| 8 | 1.107335 | 0.572827 | 1.680162 | 1.732051 | 1.420489 |
| 10 | 1.176152 | 0.665375 | **1.841527** | 1.732051 | 1.425703 |
| 12 | 1.219786 | 0.725637 | **1.945424** | 1.732051 | 1.429351 |

$\sup\lVert M^\#\rVert_F$ is attained at the balanced sphere product itself (it equals that point's $1.219786$ at $n=12$ to twelve digits) and tends to $\sqrt2$; $\sup\mathop{\mathrm{tr}}(M^3)$ rises toward $1$. So the split bound passes $\sqrt3$ at $n=10$ and climbs to $1+\sqrt2$, **post F11's floor holds verbatim for the joint quantity.** plan.md's *"the joint bound is unfenced"* is true of the statement and false of every separating proof of it; M2's "treat the two terms together" is therefore mandatory, not preferred.

**And per claim 1 the statement, if proved, does not buy the conclusion the plan attaches to it.**

---

## Claim 3, the falsifier screen

Evidence: [r276_c3_opt.py](../scripts/reviewers/r276/r276_c3_opt.py), [out_c3_small.txt](../scripts/reviewers/r276/out_c3_small.txt), [out_c3_big.txt](../scripts/reviewers/r276/out_c3_big.txt), [r276_c3_fit.py](../scripts/reviewers/r276/r276_c3_fit.py), [r276_c3d_randweyl.py](../scripts/reviewers/r276/r276_c3d_randweyl.py).

### (a) Reproduced, to every digit the plan prints

| $n$ | plan.md | r276 (L-BFGS, own machinery) | $F/\sqrt3$ |
|---|---|---|---|
| 6 | 1.4128 | 1.412822 | 0.8157 |
| 8 | 1.4205 | 1.420489 | 0.8201 |
| 10 | 1.4257 | 1.425703 | 0.8231 |
| 12 | 1.4294 | 1.429351 | 0.8252 |
| 14 | 1.4320 | 1.432024 | 0.8268 |
| 16 |, (post F34: $1.1196\,\theta_0$) | 1.434059 ($=1.119599\,\theta_0$) | 0.8280 |

**No falsifier.** Nothing above $\sqrt3$ at any $n$, and nothing close.

### (b) The maximum is very likely global

135 starts at $n\le10$, 75 at $n=12$, 42 at $n=14$, random symmetric seeds plus the balanced sphere product, $S^2\times S^{n-2}$, an unbalanced product, padded $W_{\mathbb{CP}^2}$, r274's saved optima loaded as `.npy` data, and $\varepsilon=0.15,0.5$ perturbations of each. The top five values at every $n$ agree to six decimals, and the winning start is a *structured seed* at $n=8,10,12,14$ and a random one at $n=6$, a different method, a different seeding scheme and a different implementation reaching the identical number. The maximiser is not extremal for $\theta$ ($\theta=1.206$ against $\theta_0=1.236$ at $n=12$), reproducing post F34's "the loss runs the wrong way".

### (c) The extrapolation to $\approx1.44$ is not defensible, the data do not exclude $\sqrt3$

The increments are $0.007667,\,0.005214,\,0.003648,\,0.002673,\,0.002035$ and their ratios are $0.6801,\,0.6997,\,0.7327,\,0.7613$, **rising**, not the constant $\approx0.7$ a geometric tail would give. A rising ratio is the signature of a power-law tail, whose extrapolated limit is strictly larger:

| model | $F_\infty$ | max residual |
|---|---|---|
| Aitken $\Delta^2$ on consecutive triples | 1.436786, 1.437849, 1.439352, **1.440550** (drifting up, so it is not a geometric limit |), |
| $F_\infty-An^{-q}$, $q$ free | **1.456211** ($q=0.689$) | $1.1\times10^{-4}$ |
| $F_\infty-An^{-1}$ | 1.446480 | $4.5\times10^{-4}$ |
| $F_\infty-An^{-2}$ | 1.435815 | $1.7\times10^{-3}$ |
| $\sqrt3-An^{-q}$, **$F_\infty$ fixed at $\sqrt3$** | $1.732051$ ($A=0.361$, $q=0.0705$) | $8.7\times10^{-4}$ |

The last row is the point: with $F_\infty$ pinned at $\sqrt3$ the six measurements are still fitted to $9\times10^{-4}$, only $8.1\times$ worse than the free fit and better than the $q=2$ model the record would prefer. Six points at $n\le16$ cannot separate a limit of $1.44$ from a limit of $\sqrt3$ approached like $n^{-0.07}$. **What the screen establishes is what its own docstring says (no falsifier at $n\le14$) and the sentence *"the maximum is stable in $n$ … so the $\approx17\%$ margin does not close as $n$ grows"* claims more than five points support.**

### (d) `rand_weyl` is sound, CONFIRMED

Tested through my own 4-tensor conversion: Bianchi $\le2.8\times10^{-17}$, Ricci $\le5.6\times10^{-17}$, antisymmetry and pair symmetry exact, and every sample is fixed by my independent Weyl projector to $3\times10^{-17}$, at $n=6,8,10,12$. That projector is idempotent ($10^{-16}$), self-adjoint ($10^{-15}$), and its range has dimension exactly $(n+2)(n+1)n(n-3)/12$ at $n=5,6,7,8$. The Kulkarni–Nomizu subtraction after the Bianchi projection preserves the Bianchi identity, which is the step that could have gone wrong; it does not.

---

## Claim 4, post F34's exact excess formula

Evidence: [r276_c4_excess.py](../scripts/reviewers/r276/r276_c4_excess.py), [out_c4.txt](../scripts/reviewers/r276/out_c4.txt).

**The formula is right about the ratio and mislabelled as the difference.** Post F34 displays the inequality $\mathop{\mathrm{tr}}(M^3)+\lVert M^\#\rVert_F\le\theta_0(n)$ and calls

$$\frac{m}{(2m-1)\big(u+\sqrt{u^2+m^2-m}\big)},\qquad u=m(2m-3),$$

its *exact excess*. Computed on the actual sphere-product Weyl operator it is $F/\theta_0-1$, to ten digits at $n=6,8,10,12,14,16$ and to the same accuracy against the closed forms at $n=40,100,1000$. The excess of the displayed inequality is $F-\theta_0=\theta_0\cdot(F/\theta_0-1)$:

| $n$ | $F-\theta_0$ (the displayed inequality) | $F/\theta_0-1$ = post F34's formula |
|---|---|---|
| 12 | 0.0062266173 | 0.0050375815 |
| 16 | 0.0032800390 | 0.0025607922 |
| 1000 | $7.089\times10^{-7}$ | $5.020\times10^{-7}$ |

The difference has its own closed form, verified against the tensor to fourteen digits at $n=6\dots1000$:

$$F-\theta_0(n)=\frac{\sqrt{(m-1)/(2m-1)}}{u+\sqrt{u^2+m^2-m}},\qquad u=m(2m-3).$$

Asymptotics: the ratio form $\to\frac1{8m^2}=\frac1{2n^2}$ exactly as claimed ($5.020\times10^{-7}$ against $5.000\times10^{-7}$ at $n=1000$); the difference form $\to\sqrt2/(2n^2)=1/(\sqrt2n^2)$. **Both are $\Theta(n^{-2})$, so post F34's downstream demand (a successor sharp to $O(n^{-2})$ uniformly), is unaffected.** The fix is one word.

**A separate error, in [ad-form-attempt.md](../findings/ad-form-attempt.md).** Its closed form

$$\lVert M^\#\rVert_F=\frac{\sqrt{mE}}{\sqrt{m(m-1)}\,(2m-1)},\qquad E=(2m-1)\big[m(2m-3)^2+m-1\big]$$

is **too large by a factor $\sqrt m$**: it returns $1.702939,\,2.214670,\,2.629956,\,2.987854$ at $n=6,8,10,12$ against the true $0.983192,\,1.107335,\,1.176152,\,1.219786$. The denominator should be $m\sqrt{m-1}\,(2m-1)$, i.e.

$$\lVert M^\#\rVert_F=\frac{\sqrt{u^2+m^2-m}}{m\sqrt{(m-1)(2m-1)}},$$

which reproduces all six dimensions to $10^{-12}$. The companion forms $\mathop{\mathrm{tr}}(M^3)=1/(m\sqrt{(m-1)(2m-1)})$ and $\langle M^\#,M\rangle=(2m-3)/\sqrt{(m-1)(2m-1)}$ are **both correct**, and $\theta=\theta_0(n)$ identically in $m$ as claimed. The error is confined to the one display; post F34's excess formula is computed from the correct expression.

---

## Claim 5, route N's premise: Nienhaus's $n=12$ flip is STRUCTURAL

Evidence: [r276_c5_nienhaus.py](../scripts/reviewers/r276/r276_c5_nienhaus.py), [out_c5.txt](../scripts/reviewers/r276/out_c5.txt); source at [nienhaus-2311.02404.txt](https://arxiv.org/abs/2311.02404) L4698–4790.

**Where the dimension enters.** With $W\perp\mathbb RW_{\mathbb{CP}^2}\oplus T(SO(n).W_{\mathbb{CP}^2})$ and $f(\varphi)=\sqrt{2/3}P(\cos\varphi\,W_{\mathbb{CP}^2}+\sin\varphi\,W)$,

$$f(\varphi)=\cos^3\varphi+3\alpha\cos\varphi\sin^2\varphi+\gamma\sin^3\varphi,\qquad \alpha=\sqrt{2/3}\langle Q(W),W_{\mathbb{CP}^2}\rangle\le\tfrac13,\ \gamma=\sqrt{2/3}P(W).$$

$\alpha\le\frac13$ comes from Theorem 4.14 case (c), which is stated for **all** $n\ge9$, no flip there. The single $n$-dependent input is the next line, *"the fact that $f(\varphi)\le1$ on $[0,\pi]$"*, which is $\sqrt{2/3}\sup_{\mathrm{Weyl}^1_n}P\le1$, i.e. $\sup P\le\sqrt{3/2}$, i.e. **$W_{\mathbb{CP}^2}$ is the global maximiser**. That is true exactly for $n<6+2\sqrt7=11.2915$ and false from $n=12$: the same crossover as everywhere else in this programme.

**The estimate it feeds has exactly zero margin.** Minimising $g(\varphi)=(c-\cos^3\varphi-3\alpha\cos\varphi\sin^2\varphi)/\sin^3\varphi$ at $c=1$ over the stationary point $\cos\varphi_0=\alpha/(1-\alpha)$ gives, in closed form,

$$\gamma\le\Gamma_1(\alpha)=(1+\alpha)\sqrt{1-2\alpha}\qquad\big(\Gamma_1(\tfrac13)=\tfrac{4\sqrt3}9=0.7698\big),$$

verified symbolically and against a $4\times10^6$-point minimisation. *(The extraction prints this as $1-\sqrt{2\alpha(1+\alpha)}$, which is a mangling of $\sqrt{(1-2\alpha)(1+\alpha)^2}$, the correct form is the one that reproduces the paper's own two constants, $g_1(1/3)=0$ and $g_2(1/3)=5\sqrt3/9=0.9622504486$, both exactly.)* The monotonicity step then needs

$$\tilde f(\pi/6)=\tfrac34(3\alpha-1)+\tfrac{\sqrt3}4\Gamma-\alpha<0,\qquad\text{and at }\alpha=\tfrac13,\ c=1:\quad \tilde f(\pi/6)=\tfrac{\sqrt3}4\cdot\tfrac{4\sqrt3}9-\tfrac13=\mathbf0 .$$

**Zero, identically.** The theorem's endpoint is borderline by construction, so *any* $c>1$ breaks it:

| $n$ | $c=\sqrt{2/3}\sup P$ | $\Gamma_c(1/3)$ | $\tilde f(\pi/6)$ | $f(\pi/6)$ bound | $\sqrt{2/3}\,\Theta$ |
|---|---|---|---|---|---|
| $\le11$ | 1.000000 | 0.769800 | $0$ | 0.962250 | 0.9798 ($n{=}10$), 0.9938 ($n{=}11$) |
| 12 | 1.009217 | 0.783806 | $\mathbf{+0.006064}$ | 0.964001 | 1.009217 |
| 14 | 1.030158 | 0.814468 | $+0.019342$ | 0.967834 | 1.030158 |
| 20 | 1.067708 | 0.866542 | $+0.041890$ | 0.974343 | 1.067708 |

**So the flip is structural.** It is not slack in an estimate: the input that fails is a *false statement* at $n\ge12$, and the estimate it feeds has no margin at the crossover to absorb the correction. Three further observations settle I3:

- **The failure is confined to monotonicity, and only near the endpoint.** At $n=12$ the argument still gives $f'<0$ on $(0,0.9712\cdot\pi/6)$; the second estimate, $f(\pi/6)<\sqrt{2/3}\,\Theta$, actually gets *easier* above $n=11$ ($0.9640$ against $1.0092$, $4.7\%$ of room) because $\Theta$ grows. This is the same shape as Remark 4.18's own $n\le9$ gap, and it names the same repair: a better $\gamma$ bound for $\alpha$ near $\frac13$.
- **The replacement constant is not free.** $c$ must be an *a priori* bound on $\sup P$; taking $c=\sqrt{2/3}\,\theta_0(n)$ assumes Conjecture A. So route N's tube estimate needs exactly the object route M is trying to build.
- **And route M's own target would not supply it.** At $c=\sqrt{2/3}\cdot\sqrt3=1.4142$, $\tilde f(\pi/6)=+0.2217$; at $c=\sqrt{2/3}\cdot\sqrt3$ pushed to $\sqrt3$ itself, $+0.3719$. A cap of $\sqrt3$ is nowhere near tight enough to restore 4.17.

**Verdict for I3: structural, the premise is false at $n\ge12$ and the estimate is zero-margin at the crossover, so 4.17 cannot be inherited.** What survives is Remark 4.18's programme (sharpen $\gamma$ for $\alpha\approx\frac13$), which is a new estimate rather than a continuation.

---

## Claim 6, the validation ledger: r261/r262 VALIDATED

Evidence: [r276_c6_ledger.py](../scripts/reviewers/r276/r276_c6_ledger.py), [out_c6.txt](../scripts/reviewers/r276/out_c6.txt).

The entry says ASWT Theorem 3.17(b) is stated per type (surjectivity in type $B_m$ ($n$ odd), only injectivity in type $D_m$) so citing it at $n=12$ (type $D_6$) fails, and the conclusion survives only because this programme's group is $O(n)$ rather than $SO(n)$. I validated the mathematical core independently, without reading the reviewers' scripts.

**The decisive small case.** Invariants computed as the kernel of the $\mathfrak{so}(n)$ derivation action on $V^{\otimes k}$ (legitimate since $SO(n)$ is connected), then intersected with the $+1$ eigenspace of one reflection to get $O(n)$:

| $n$, legs | $\dim\mathrm{Inv}_{SO}$ | $\dim\mathrm{Inv}_{O}$ | Brauer diagrams | their rank |
|---|---|---|---|---|
| $4$, $4$ | **4** | **3** | 3 | 3 |
| $3$, $4$ | 3 | 3 | 3 | 3 |
| $5$, $4$ | 3 | 3 | 3 | 3 |
| $2$, $2$ | **2** | **1** | 1 | 1 |

At $n=k=4$ the diagram span has rank $3$ and the $SO$-invariants have dimension $4$; adjoining $\varepsilon_{ijkl}$ raises the rank from $3$ to $4$, so $\varepsilon$ is **outside** the diagram span and is $SO$- but not $O$-invariant. That is precisely the type-$D$ failure of surjectivity, exhibited rather than cited, and it appears exactly when the leg count reaches $n$, which at $n=12$ is $V^{\otimes12}$, the case in play, where $\varepsilon_{i_1\dots i_{12}}$ sits outside the span of the $10{,}395$ diagrams.

**So both halves of the entry hold**: the $SO$ statement genuinely fails at $n=12$, and the $O$/$SO$ distinction is what rescues the citation, load-bearing, not bookkeeping. One number in [brauer-pairing.md](../findings/brauer-pairing.md) reads oddly: *"for $SO(4)$, $\dim\mathrm{Inv}(V^{\otimes4})=4$ while $\mathop{\mathrm{span}}\{\nu(D)\varepsilon\}=1$."* The diagram span is $3$ and the **gap** is $1$; if the $1$ is the gap the sentence is right, if it is the span it is wrong. Worth one word.

---

## What this leaves

- **Route M's stated theorem does not close the conjecture even if proved.** The $\sqrt2$ is unavailable on the residual, and the residual's own sharp point has $\mathop{\mathrm{tr}}(M^3)+\lVert M^\#\rVert_F=1.408248>\theta_0(12)$, so no constant repairs it. M3 as written cannot be discharged.
- **A fence post is owed**, in the shape of the record's own: *padded $W_{\mathbb{CP}^2}$ pins $\mathop{\mathrm{tr}}(M^3)+\lVert M^\#\rVert_F\ge1+\frac1{\sqrt6}$ on the $\circ$-indecomposable residual at **every** even $n$, and $\theta_0(n)$ stays below that until $n=356$, so no cap on that quantity closes Conjecture A for any even $12\le n\le354$.*
- **What would survive** is the same reduction with the $\cos\varphi$ kept (which is post F34's closed route) or a cap proved directly on $\theta$ over indecomposables. The $\lVert M^\#\rVert_F$ relaxation costs $15.0\%$ at padded $W_{\mathbb{CP}^2}$ against $0.913\%$ of room at $n=12$.
- **Route N's premise is structurally blocked at the same crossover $6+2\sqrt7$**, and its repair needs an a priori $\sup P$ bound that route M does not supply.
- **Two corrections owed to the record**: post F34's formula is the relative excess, and ad-form-attempt.md's $\lVert M^\#\rVert_F$ is off by $\sqrt m$.


---

## Index-row summary, preserved

*The REVIEW.md index row carried figures not repeated in this report; kept verbatim.*

ROUTE M's REDUCTION CHAIN and the falsifier screen, commits `e5f8cbe` (primary) / `72c73d2`,`e84e9af` / `7136a12`,`6b7eae1`. **Link (b) is a non sequitur, and the relaxation is too lossy to close any even $n\le354$.** *Claim 1 REFUTED*: $|\theta|\le M(n)/\sqrt2$ is the harmonic-square law $1/\theta^2=\sum1/\theta_i^2$ with $k\ge2$ $\circ$-orthogonal **critical** pieces, so it lives on $\circ$-decomposables (exactly the set the sum law deletes) while the residual inherits only $\theta\le\sqrt3=1.7321$ against $\theta_0(12)=1.2360$. No constant repairs it: zero-padding is exact, so padded $W_{\mathbb{CP}^2}$ ($\circ$-**indecomposable**, $\dim E(1)=1$ recomputed over all $1638$ dimensions of $\mathrm{Weyl}_{12}$ and $=1$ at $n=6,8$ too; critical to $1.4\times10^{-16}$; non-diagonal) carries $\mathop{\mathrm{tr}}(M^3)=\tfrac1{\sqrt6}$, $\lVert M^\#\rVert_F=1$, $\cos\varphi=\sqrt{2/3}$, $\theta=\sqrt{3/2}$ and $F=1+\tfrac1{\sqrt6}=1.408248290464$ **identically at $n=4\dots16$**, while $\theta_0(n)$ first reaches $1+\tfrac1{\sqrt6}$ at $n=355.695$, $\theta_0(354)=1.4082197<1.4082483<1.4082534=\theta_0(356)$. **So no cap on $\mathop{\mathrm{tr}}(M^3)+\lVert M^\#\rVert_F$ over the residual implies $\theta\le\theta_0(n)$ for any even $12\le n\le354$**, a fence post. Links (a), (c), (d) confirmed: the sum law's three hypotheses named and re-derived; crossover exactly $n>6+2\sqrt7=11.2915$ with $0.913\%$ margin at $n=12$; the diagonal grant legitimate and correctly caveated in [LEDGER.md](findings/LEDGER.md). *Claim 2*: **not** a restatement, $F/\theta=1.185$ with $\cos\varphi=0.7617$ at the $n=12$ maximiser, so post F28/34's substitution mechanism does not apply, but post F11 fences it **as a method**: $\sup\mathop{\mathrm{tr}}(M^3)+\sup\lVert M^\#\rVert_F$ measures $1.5547,1.6802,\mathbf{1.8415},\mathbf{1.9454}$ at $n=6,8,10,12$, past $\sqrt3$ from $n=10$ and climbing to $1+\sqrt2$, with $\sup\lVert M^\#\rVert_F$ attained at the balanced sphere product itself. *Claim 3*: **(a) reproduced exactly** by L-BFGS on the ambient scale-invariant form with own structure constants and own gradient, $1.412822,1.420489,1.425703,1.429351,1.432024,1.434059$ at $n=6\dots16$, matching the screen and post F34's $1.1196\,\theta_0$ at $n=16$; **(b)** 135/75/42 starts from random, sphere-product, $\mathbb{CP}^2$-padded, unbalanced and r274-seeded points all land on one value; **(c) THE EXTRAPOLATION IS NOT DEFENSIBLE**, the increment ratios *rise* ($0.680,0.700,0.733,0.761$), Aitken drifts up ($1.4368\to1.4406$), a free power-law fit gives $F_\infty=1.4562$ at $q=0.689$, and a fit with $F_\infty$ **pinned at $\sqrt3$** still matches all six points to $8.7\times10^{-4}$, $8.1\times$ the free residual and better than $q=2$; **(d)** `rand_weyl` is sound (Bianchi $3\times10^{-17}$, Ricci $6\times10^{-17}$, fixed by an independent projector of rank exactly $(n+2)(n+1)n(n-3)/12$). *Claim 4*: post F34's formula is **the relative excess mislabelled as the excess**, it reproduces $F/\theta_0-1$ to ten digits at $n=6\dots1000$, while the displayed inequality's excess is $\theta_0$ times larger, $\sqrt{(m-1)/(2m-1)}/(u+\sqrt{u^2+m^2-m})$, verified to fourteen digits; rate $\tfrac1{2n^2}$ for the ratio and $\tfrac1{\sqrt2n^2}$ for the difference, so the $O(n^{-2})$ demand stands. **And [ad-form-attempt.md](findings/ad-form-attempt.md)'s $\lVert M^\#\rVert_F$ closed form is too large by $\sqrt m$**, $2.9879$ against $1.2198$ at $n=12$; the $\mathop{\mathrm{tr}}(M^3)$ and $\langle M^\#,M\rangle$ forms are right. *Claim 5 (I3)*: **structural, with exactly zero margin at the crossover.** Theorem 4.17's only $n$-dependent input is "$f\le1$ on $[0,\pi]$" $=$ "$W_{\mathbb{CP}^2}$ is the global maximiser", true below $6+2\sqrt7$ and false at $n\ge12$; with the correct $\Gamma_1(\alpha)=(1+\alpha)\sqrt{1-2\alpha}$, which reproduces the paper's own $g_1(1/3)=0$ and $g_2(1/3)=5\sqrt3/9$ exactly, and shows the extraction's $1-\sqrt{2\alpha(1+\alpha)}$ to be a mangled $\sqrt{(1-2\alpha)(1+\alpha)^2}$, the closing estimate $\tilde f(\pi/6)$ vanishes identically at $\alpha=1/3$, so every $c>1$ turns it positive ($+0.0061$ at $n=12$, $+0.0193$ at $n=14$). Only monotonicity fails, and only past $0.9712\,\pi/6$; the second estimate gets *easier* above $n=11$. The replacement constant is an a priori $\sup P$ bound, i.e. route M's object, and route M's own $\sqrt3$ gives $\tilde f(\pi/6)=+0.372$, nowhere near. *Claim 6 VALIDATED* (r261/r262): computed from the $\mathfrak{so}(n)$ derivation kernel, $\dim\mathrm{Inv}_{SO(4)}(V^{\otimes4})=4$ against $\dim\mathrm{Inv}_{O(4)}=3=$ the Brauer rank, and adjoining $\varepsilon$ raises the rank $3\to4$, the type-$D$ surjectivity failure exhibited, appearing exactly when the leg count reaches $n$, which at $n=12$ is $V^{\otimes12}$. The $O$-versus-$SO$ rescue is load-bearing; [brauer-pairing.md](findings/brauer-pairing.md)'s "$\mathop{\mathrm{span}}\{\nu(D)\varepsilon\}=1$" is the gap, not the span, which is $3$

# Review r299, two closures on the way to V3, and the identity behind them

Everything below is built from the definitions as the brief states them, $\phi_{ij}=E_{ij}-E_{ji}$, $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$, $c_{abg}=\langle[\phi_a,\phi_b],\phi_g\rangle$, $(W^\#)_{ab}=-\tfrac12\mathop{\mathrm{tr}}(A_aWA_bW)$, $Q=W^2+W^\#$, $\mathcal W_n=\ker(\text{Bianchi})\cap\ker(\text{Ricci})$, in [scripts/reviewers/r299/core.py](../scripts/reviewers/r299/core.py). Nothing under review was imported: [review_r30_core.py](../scripts/lib/review_r30_core.py) and [weyl.py](../scripts/lib/weyl.py) were read for the conventions and then set aside. The three test points were rebuilt from geometry, not loaded.

## Verdicts

| Claim | Verdict | One line |
|---|---|---|
| **G1**, the averaging attempt over $\mathrm{Sym}_0$ fails | **CONFIRMED**, one sentence of it **REFUTED** | all three numbers reproduce and the closure holds far more widely than claimed, but *"$0.600$ at $\mathbb{CP}^4$ … below the $\tfrac12$"* is false, and at $\mathbb{CP}^4$ the averaging argument **succeeds** |
| **G2**, the Weyl projection is load-bearing | **CONFIRMED**, and now explained | $0.571429=\tfrac47$ exactly, and the reason is that $\lambda_{\max}(L_e)$ on the **ambient** $\mathrm{Sym}^2(\Lambda^2)$ is $1.000000$; projection *order* is provably irrelevant |
| **G3** (the $\mathrm{Sym}_0$ lead is narrower than reported | **PLAUSIBLE**), arithmetic exact, conclusion wrong | both numbers land to six digits, but $\lambda_{\max}\vert_V=0.820541>\tfrac12$ **already certifies** the failure at $C_5$, so the lead is not narrower where it counts; and "the violating direction" is undefined at both points (multiplicity $15$ and $2$) |
| **G4**, the global first moment is inert | **CONFIRMED**, and understated | derived here rather than measured; it needs **none** of criticality, unit norm, $\theta>0$ or Weyl-ness *of the argument*, and $\tau=0$ exactly, so the trace vanishes for **every** $x\in\mathrm{Sym}^2(\Lambda^2)$. It is also a one-line corollary of an identity this record landed at Gate 2 long ago |
| **G5**, the reconciliation | **CONFIRMED** | the misread premise is verbatim in commit `7ee03c0` of [bounds.md](../findings/bounds.md); the contradiction with Observation L25 is real and not a scoping artefact. One location error: Observation L25 is in [second-order.md](../findings/second-order.md), **not** the same file |

**No critical point with $\Delta>0$ and $\lambda_{\max}\le\tfrac12$ was found**, over the $15$ distinct such points on file plus an independent random hunt. V3 survives everything I could throw at it.

## The machinery and its controls

| control | value |
|---|---|
| $c_{abg}$ totally antisymmetric | $0.0$ exactly |
| $\dim\mathcal W_n$ against $\tfrac{n(n+1)(n+2)(n-3)}{12}$ | exact at $n=4\ldots10$ |
| $\mathcal W_n$ Frobenius-orthonormal | $8.9\times10^{-16}$ |
| $\mathcal W_n$ closed under $\circ$ | relative $6.4\times10^{-16}$ |
| $d(A)$ on skew $A$ against $\mathrm{ad}$ | $0.0$ exactly (the record's $A_a$ is $-\mathrm{ad}(\phi_a)$; $\#$ is quadratic in $A$, so nothing downstream moves) |

The derivation action is built independently as $d(M)(e_i\wedge e_j)=(Me_i)\wedge e_j+e_i\wedge(Me_j)$ for an arbitrary $n\times n$ matrix $M$, which specialises to $\mathrm{ad}$ on the skew part and to $D_A$ on the symmetric part, one implementation, two uses, and the agreement on the skew half is the check on both.

| point | $n$ | $\theta$ | criticality | $\Delta$ | $\sum_\gamma g_\gamma$ | $\lambda_{\max}(L_e\vert_{e^\perp})$ |
|---|---|---|---|---|---|---|
| $S^3\times S^5$ | $8$ | $1.115546702$ | $2.7\times10^{-16}$ | $0$ | $28=4(n-1)$ | $0.500000000$ |
| $\mathbb{CP}^4$ | $8$ | $0.986013297$ | $9.4\times10^{-16}$ | $0$ | $28$ | $0.600000000$ |
| $C_5$ blow-up | $10$ | $0.670820393$ | $1.3\times10^{-16}$ | $12$ | $36=4(n-1)$ | $1.206011330$ |
| $S^5\times S^5$ | $10$ | $1.200000000$ | $1.9\times10^{-16}$ | $0$ | $36$ | $0.500000000$ |

$\mathbb{CP}^4$ was built from the Fubini–Study curvature tensor $R_{ijkl}=g_{ik}g_{jl}-g_{il}g_{jk}+J_{ik}J_{jl}-J_{il}J_{jk}+2J_{ij}J_{kl}$ and projected into $\mathcal W_8$; the $C_5$ blow-up from the cycle graph directly, entries $4/-2/+1$. Both land on the record's $\theta$ to nine digits with no fitting.

## G1, CONFIRMED, and one sentence of it refuted

**The three numbers reproduce exactly.** With $H_A=D_AW+WD_A$ projected into $\mathcal W_n$ and then into $e^\perp$:

| point | $\dim V$ | $\mathop{\mathrm{tr}}(L_e\vert_V)/\dim V$ | brief |
|---|---|---|---|
| $S^3\times S^5$ | $34$ | $0.411765$ | $0.412$ |
| $\mathbb{CP}^4$ | $15$ | $0.600000$ | $0.600$ |
| $C_5$ blow-up | $54$ | $0.446362$ | $0.446$ |

**But $0.600>\tfrac12$.** The brief calls all three *"below the $\tfrac12$ an averaging argument needs"*; the $\mathbb{CP}^4$ value is above it, and there the averaging argument **works**, $\lambda_{\max}\ge0.600>\tfrac12$ excludes $\mathbb{CP}^4$ as a maximizer on the trace alone. So *"the averaging attempt over symmetric deformations fails"* is stated too widely. What is true is the narrower thing: it fails **on the $\Delta>0$ set**, which is V3's target, and one witness there is enough to kill it. [bounds.md](../findings/bounds.md) writes it correctly as *"against the $\tfrac12$ needed"*; the brief's gloss is the defect.

**The closure is far stronger than three points.** I swept every genuine $\Delta>0$ critical point saved under [scripts/reviewers/r295/](../scripts/reviewers/r295/) and [scripts/reviewers/r296/](../scripts/reviewers/r296/), ($17$ stored operators, $14$ of them distinct in $\theta$), re-verifying each against my own $Q$ (criticality residual $\le1.5\times10^{-14}$, Weyl error $\le1.1\times10^{-15}$):

- $\mathop{\mathrm{tr}}(L_e\vert_V)/\dim V\in[0.330221,\,0.381244]$ across all $14$;
- at the **maximizers** the same statistic is $0.320000$ (padded $W_{\mathbb{CP}^2}$), $0.333333$ ($S^4\times S^4$), $0.375000$ ($S^5\times S^5$), $0.411765$ ($S^3\times S^5$).

**The two ranges interleave**, so no threshold whatever on the $V$-average separates a $\Delta>0$ point from a maximizer, a much harder closure than "below $\tfrac12$", and one that also rules out any rescaled or shifted version of the trace test.

**The one candidate third subspace, and why it dies.** At the $C_5$ blow-up $L_e\vert_V$ has a **$10$-dimensional kernel**; deleting it lifts the average to $0.547808>\tfrac12$, and at $S^3\times S^5$ the same recipe changes nothing ($0.411765$, no kernel). That looked like a refutation of G1's reach for about ten minutes. It is not: at all $14$ $n=8$ points $L_e\vert_V$ has **trivial** kernel, so the refinement is identically the plain average there and stays at $0.33$–$0.38$. Two further recipes fail the same way, $V\ominus\mathcal O$ gives $0.342105$ at $S^3\times S^5$ and $0.446362$ at $C_5$; the $\lVert H_A\rVert^2$-weighted average (the one the $A$-parametrisation hands you, rather than the orthonormal trace) gives $0.340820$, $0.600000$, $0.404762$. **G1's reach stands.**

## G2, CONFIRMED, and the mechanism identified

Without the Weyl projection, $\lambda_{\max}$ over the span of the raw $H_A$ (still projected into $e^\perp$) is $0.571429=\tfrac47$ at $S^3\times S^5$, against a full-space $0.500000$. Reproduced to $15$ digits. The inference is sound: for $V\subseteq\mathcal W_n\cap e^\perp$ the compression of a self-adjoint operator cannot exceed its restriction's top eigenvalue, so $0.571>0.500$ proves $V\not\subseteq\mathcal W_n$.

**Why $\tfrac47$ is possible at all.** $\lambda_{\max}$ of $H\mapsto\tfrac1\theta[\tfrac12(WH+HW)+\mathrm{sharp\_bilin}(n,W,H)]$ on the **ambient** $\mathrm{Sym}^2(\Lambda^2)$ (dimension $406$) is $1.000000$ at $S^3\times S^5$ and $1.000000$ at $\mathbb{CP}^4$. The unprojected $V$ is drawing on ambient directions where $L_e$ is twice as large as anything inside $\mathcal W_n$. At the $C_5$ blow-up the ambient maximum is $1.206011$ (the same as the Weyl one, its eigenvector already lying in $\mathcal W_{10}$) which is why the tell does **not** fire there ($0.814324<1.206011$). One point is enough to catch the bug, but the diagnostic is not universal, and that is worth recording before someone relies on it.

**$H_A$ genuinely leaves $\mathcal W_n$**, so the projection is not cosmetic: $\lVert H_A-\Pi_{\mathcal W}H_A\rVert/\lVert H_A\rVert$ over an orthonormal basis of $\mathrm{Sym}_0(\mathbb R^n)$ runs $0.141$–$0.660$ (mean $0.319$) at $S^3\times S^5$, $0.308$–$1.000$ (mean $0.432$) at $\mathbb{CP}^4$ (some $H_A$ is **entirely** outside $\mathcal W_8$) and $0.076$–$0.500$ at $C_5$. The dimension collapse says the same: at $\mathbb{CP}^4$ the $35$ deformations span only $15$ dimensions after projection.

**The projection order does not matter, and this is a proof rather than a measurement.** $\Pi_{e^\perp}=\mathrm{Id}-P_W$ with $W\in\mathcal W_n$, so $\Pi_{\mathcal W}P_W=P_W\Pi_{\mathcal W}=P_W$ and the two projections commute; being linear, they carry the span either way. Measured agreement: $\mathop{\mathrm{tr}}/\dim$ and $\lambda_{\max}$ identical to $10^{-15}$ at all three points. So the brief's question has the answer "neither, it commutes"; what is load-bearing is that $\Pi_{\mathcal W}$ is applied *at all*.

## G3, PLAUSIBLE: the arithmetic is exact, the conclusion drawn from it is not

Both numbers land: $\lambda_{\max}\vert_V=0.600000000$ at $\mathbb{CP}^4$ against a full-space $0.600000000$, and $0.820541$ against $1.206011330$ at the $C_5$ blow-up.

**"The violating direction" is not well defined at either point.** At $\mathbb{CP}^4$ the top eigenvalue $0.6$ has **multiplicity $15$**; at the $C_5$ blow-up $1.206011330$ has **multiplicity $2$**. The statements that survive are about eigenspaces, and they are sharper than the ones in the brief:

- at $\mathbb{CP}^4$, $V$ **is** $E(\lambda_{\max})$, $\dim V=15$ and every eigenvalue of $L_e\vert_V$ equals $0.600000$, all $15$ principal cosines with $E_{\text{top}}$ equal to $1$;
- at the $C_5$ blow-up, $V\cap E_{\text{top}}=0$, both principal cosines being $0.649457$; the spectrum of $L_e\vert_V$ is $0$ ($\times10$), $0.412281$ ($\times20$), $0.441754$ ($\times2$), $0.666667$ ($\times20$), $0.820541$ ($\times2$), so **$22$ of $54$ directions already exceed $\tfrac12$**.

**And that is why "narrower" is the wrong lesson.** V3 needs *a* direction above $\tfrac12$, not the largest one. $0.820541>\tfrac12$ certifies the second-order failure at $C_5$ from inside $\mathrm{Sym}_0$ alone, so the record's derived sentence (*"a proof of V3 needs directions outside it too"*), is **false**. The correct statement runs the other way, and I checked it across the whole catalogue:

$$\lambda_{\max}(L_e\vert_V)>\tfrac12\ \text{ at every one of the }15\text{ }\Delta>0\text{ critical points on file.}$$

Values $0.500251$, $0.519655$, $0.526467$, $0.530282$, $0.535993$, $0.539934$, $0.550634$, $0.556643$, $0.588721$, $0.689843$, $0.820076$, $0.820541$, $0.821319$, $0.872777$, $0.891791$, against exactly $0.500000$ at $S^3\times S^5$ and padded $W_{\mathbb{CP}^2}$, $0.375000$ at $S^5\times S^5$, $0.333333$ at $S^4\times S^4$. **So the symmetric deformations suffice for V3 everywhere it has ever been tested**, and the lead is live rather than narrow.

**The lead is fragile at exactly one point, and that number is new.** At [sol_1.0836886.npy](../scripts/reviewers/r295/sol_1.0836886.npy) ($n=8$, $\Delta=3.025161$, $S_{\mathfrak{mmm}}=4.6\times10^{-28}$, full-space $\lambda_{\max}=0.568781$) the $V$-restricted maximum is $0.5002507$, **$2.5\times10^{-4}$ above the bound**, with the rest of the spectrum topping out at $0.469059$. I re-solved criticality there to residual $1.7\times10^{-16}$ before believing it. Any proof of V3 that runs through $\mathrm{Sym}_0$ has to survive a margin of that size, which is a real constraint on the shape of the argument.

## G4, CONFIRMED, derived rather than measured, and wider than stated

**The derivation.** Write $T(x,y,z)=\langle x\circ y,z\rangle$, totally symmetric, and let $\{B_k\}$ be an orthonormal basis of $\mathcal W_n$. Then

$$\mathop{\mathrm{tr}}\big(\Pi_{\mathcal W}L_x\Pi_{\mathcal W}\big)=\sum_k\langle x\circ B_k,B_k\rangle=\Big\langle x,\ \underbrace{\sum_kB_k\circ B_k}_{=:\ \tau}\Big\rangle .$$

$\tau$ is $O(n)$-invariant, because $\circ$ is equivariant and $\{gB_k\}$ is another orthonormal basis of the same submodule. $\Lambda^2\mathbb R^n$ is $O(n)$-irreducible, so its commutant is $\mathbb R\,\mathrm{Id}$ and $\mathrm{Sym}^2(\Lambda^2)^{O(n)}=\mathbb R\,\mathrm{Id}_{\Lambda^2}$, hence $\tau=c\,\mathrm{Id}$. Two independent finishes:

1. **$c$ never matters.** $\langle x,\mathrm{Id}\rangle=\mathop{\mathrm{tr}}(x)=0$ for every Weyl tensor, since Ricci-flat forces scalar-flat. So $\mathop{\mathrm{tr}}(L_x)=c\mathop{\mathrm{tr}}(x)=0$.
2. **$c=0$ anyway.** $\langle\mathrm{Id},X\circ X\rangle=\mathop{\mathrm{tr}}(X^2)+\mathop{\mathrm{tr}}(X^\#)=\lVert X\rVert^2-\lVert X\rVert^2=0$ on $\mathcal W_n$ by the record's own $\mathop{\mathrm{tr}}(X^\#)=-\lVert X\rVert^2$; by symmetry $\langle\mathrm{Id}\circ X,X\rangle=0$, and $\mathrm{Id}\circ(\cdot)$ is an equivariant endomorphism of the irreducible $\mathcal W_n$, hence a scalar, which must be $0$. So $L_{\mathrm{Id}}\equiv0$ on $\mathcal W_n$ and $cN=\sum_k\langle\mathrm{Id}\circ B_k,B_k\rangle=0$.

Checks: $\mathrm{sharp\_bilin}(n,\mathrm{Id},Y)=-Y$ to $8.3\times10^{-16}$ on $\mathcal W_n$ at $n=4\ldots8$, so $\mathrm{Id}\circ Y=0$; $\mathrm{Id}^\#=(n-2)\mathrm{Id}$ **bitwise**; $\lVert\tau\rVert\le1.1\times10^{-14}$ at $n=4\ldots8$ with individual summands $\lVert B_k\circ B_k\rVert$ up to $1.009$, so it is cancellation and not smallness.

**Exactly which hypotheses it needs.**

| hypothesis | needed? |
|---|---|
| $\mathcal W_n$ closed under $\circ$, and $O(n)$-irreducible | **yes**, both, this is the whole argument |
| $\mathop{\mathrm{tr}}(X^\#)=-\lVert X\rVert^2$ on $\mathcal W_n$ | only for finish 2; finish 1 replaces it with $\mathop{\mathrm{tr}}(x)=0$ |
| Ricci-flatness / Weyl-ness of the **argument** $x$ | **no**, since $c=0$, $\mathop{\mathrm{tr}}(\Pi_{\mathcal W}L_x\Pi_{\mathcal W})=0$ for **every** $x\in\mathrm{Sym}^2(\Lambda^2)$; verified at random non-Weyl symmetric $x$ ($8\times10^{-17}$, $6\times10^{-16}$) |
| criticality | **no**, checked at random non-critical unit Weyl tensors, $\mathop{\mathrm{tr}}(L_e)\le7\times10^{-15}$ |
| unit norm, $\theta>0$ | **no**, $\mathop{\mathrm{tr}}(L_W)=0$ is linear in $W$; the $-1$ needs only $\theta:=P(W)/\lVert W\rVert^2\ne0$ |

**And $\mathop{\mathrm{tr}}(L_e\vert_{e^\perp})=-1$ follows in one line**: $\langle L_eW,W\rangle=\langle Q(W),W\rangle/\theta=P(W)/\theta=\lVert W\rVert^2$, so the compression removes exactly $1$. Measured $-1.000000000000$ at every point tested, including random non-critical $W$ with criticality residual $0.49$ and $\lambda_{\max}=159.38$.

**Wider still than the brief:** $\mathop{\mathrm{tr}}(L_e)=0$ on the whole **ambient** $\mathrm{Sym}^2(\Lambda^2)$ too, at all three test points.

**The honest caveat on novelty.** $\mathop{\mathrm{tr}}(L_x)=0$ on $\mathcal W_n$ is **already in this record**, [second-order.md](../findings/second-order.md) carries it as Fox's Theorem 1.3, Gate 2 landed by Reviewers 28 and 29, with the same "$\tau$ invariant hence zero" argument. G4 is a one-line corollary of it. So it is true, correctly stated, and *cheap*: it closes a route that nobody could have walked since that identity landed. It should be recorded as a corollary, not as a new closure. (The published argument does have a small gap that the version above repairs: invariance gives $\tau\in\mathbb R\,\mathrm{Id}$, not $\tau=0$; the step from there needs either $\mathop{\mathrm{tr}}(x)=0$ or $L_{\mathrm{Id}}=0$.)

## G5, CONFIRMED

**The misread premise is verbatim.** Commit `7ee03c0` of [findings/bounds.md](../findings/bounds.md) wrote:

> Since Lemma L24 reads $\lambda_{\max}(L_e\vert_{e^\perp})\le\tfrac12$, **a large $\Delta$ piles directions up AT the bound and can never push one above it.** So "$\Delta>0\Rightarrow$ the second-order condition fails $\Rightarrow$ not a local maximum" … cannot work

The word "never" is where the conclusion of a conditional becomes a standing fact: the orbit-tangent mechanism gives *"the directions $\Delta$ measures sit at exactly $\tfrac12$"*, and only the misread premise upgrades that to *"nothing can exceed $\tfrac12$"*. G5's diagnosis is exact.

**The contradiction is real, not a scoping artefact.** [Observation L25](../findings/second-order.md) is scoped to *converged critical points* ("$155$ … at $n=6$), all ungraded, together with every structured ungraded point on record, $\lambda_{\max}$ ranges over $[1.17,96.3]$". Under the misread premise every one of those is impossible. Independently here, at $n=8$, the catalogued critical points reach $\lambda_{\max}=1.599849$, $1.362572$, $1.175704$, $1.130364$, and the $C_5$ blow-up reaches $1.206011330$ at $n=10$, none of them maximizers, all of them critical.

**One location error to fix.** The brief says Observation L25 is "in the same file"; commit 0895ccc says "two sections above it". Observation L25 lives in [findings/second-order.md](../findings/second-order.md) and the erroneous sentence itself links there. The correction is right; the pointer is not.

**What survives is verified, and is a theorem rather than a measurement.** The orbit tangent lies in $E_{L_e}(\tfrac12)$ **exactly**, spectrum of $L_e$ restricted to it is $[0.500000000000,\,0.500000000000]$ at all three points, and the orbit lies inside $\mathcal W_n$ to $6\times10^{-15}$. Consequently the "orbit component $1.1\times10^{-15}$" of the violating direction at $C_5$ is not evidence but a corollary: $L_e$ is self-adjoint, so **every** eigendirection with eigenvalue $\ne\tfrac12$ is exactly orthogonal to the orbit. I measure $1.29\times10^{-15}$, and the same quantity at $S^3\times S^5$ is $3.87$, large, because there $E_{\text{top}}=E(\tfrac12)$ *contains* the orbit. The direction is genuinely ascending: $(P(W_t)-\theta)/t^2=1.420819$ against $3\theta(\lambda_{\max}-\tfrac12)=1.420820$ along the geodesic.

## The falsifier hunt, nothing found, and V3 is not tight

A critical point with $\Delta>0$ and $\lambda_{\max}\le\tfrac12$ refutes V3 outright. I looked in two places.

**The catalogue.** All $15$ distinct $\Delta>0$ critical points on file (the $14$ at $n=8$ under [r295](../scripts/reviewers/r295/) and [r296](../scripts/reviewers/r296/), plus the $C_5$ blow-up) violate, with $\lambda_{\max}\in[0.547292,\,1.599849]$.

**The margin does not close as $\Delta\to0$**, which is the shape of evidence that matters for a proof: the excess $\lambda_{\max}-\tfrac12$ is $0.089305$ at $\Delta=0.7912$, $0.047292$ at $\Delta=1.2176$, $0.108885$ at $\Delta=1.5122$, $0.068781$ at $\Delta=3.0252$, bounded below by $0.047$ over the catalogue with no trend toward $0$. So V3 is **not** a boundary-case statement, and a proof need not be quantitative in $\Delta$.

**An independent random hunt.** Levenberg--Marquardt on $\Pi_{\mathcal W}Q(W)-\langle W,Q(W)\rangle W=0$ over the unit sphere of $\mathcal W_6$, from random starts, converged $100$ times to residual $\le10^{-10}$. **Every one has $\Delta>0$**, and $\lambda_{\max}(L_e\vert_{e^\perp})$ ranges over $[1.479500,\,96.291798]$ with $\theta\in[0.0069,0.5016]$. No falsifier. The top value **$96.291798$ independently reproduces [Observation L25](../findings/second-order.md)'s recorded ceiling of $96.3$** from code that has never read it, which is a second confirmation of that observation on top of the G5 argument.

## Scripts

[core.py](../scripts/reviewers/r299/core.py) (machinery), [points.py](../scripts/reviewers/r299/points.py) (the three points, $\Delta$), [le.py](../scripts/reviewers/r299/le.py) ($L_e$ and its restriction), [g4.py](../scripts/reviewers/r299/g4.py) and [g4b.py](../scripts/reviewers/r299/g4b.py) and [g4c.py](../scripts/reviewers/r299/g4c.py) (G4), [g123.py](../scripts/reviewers/r299/g123.py) (G1/G2, all projection variants), [g1b.py](../scripts/reviewers/r299/g1b.py) (the candidate third subspaces), [g3.py](../scripts/reviewers/r299/g3.py) (eigenspace geometry), [g5.py](../scripts/reviewers/r299/g5.py) (orbit facts and the ascent), [sweep.py](../scripts/reviewers/r299/sweep.py) (the catalogue), [hunt.py](../scripts/reviewers/r299/hunt.py) (the falsifier hunt).

# Review 102, the frame-optimised diagonal, five claims

Independent rebuild from the brief's definitions only. Code in [scripts/reviewers/r102/](../scripts/reviewers/r102/); log at [agent_logs/reviewer102.log](../agent_logs/reviewer102.log).

## Verdicts

| claim | verdict |
|---|---|
| 1, the Schur–Horn constraint is vacuous with $d$ free | **CONFIRMED as a fact, REFUTED as a diagnosis.** Vacuity is far stronger than recorded and has a different cause; the repair the record proposes would not lift it |
| 2, $\kappa$ well defined, $\kappa^2\le2$, $=2$ iff coordinate-diagonal | **CONFIRMED**, with a one-line proof; the ascent is sound and I could not beat any quoted value |
| 3, $\kappa^2(\mathbb{CP}^m)=3/(m+1)$ | **CONFIRMED** to $10^{-15}$, $m=2..7$; $\theta^2(\mathbb{CP}^m)$ re-derived independently and confirmed |
| 4, both lemma forms refuted | **CONFIRMED**, both witnesses reproduce |
| 5, Claims 1–4 retire the Schur–Horn lead | **REFUTED as an inference.** Its premise is false, its witness points the wrong way, and its conclusion, which I do believe on other evidence, rests on facts the claim does not state |

Two corrections to the record are larger than any verdict, and both make Schur–Horn **stronger** than recorded, not weaker. They are in the last section.

## The build, and why its numbers can be trusted

Everything below comes from one module written from the brief's definitions: Weyl projector (Kulkarni–Nomizu trace removal after a $\Lambda^4$ projection), $M$ over pairs $i<j$, Hamilton's $\#$ from structure constants $c_{a\gamma\delta}=\tfrac12\mathop{\mathrm{tr}}(B_a^\top[B_\gamma,B_\delta])$ in $\phi_{ij}=E_{ij}-E_{ji}$, and $\mathring W$ on $S^2_0$ in Li's convention. Five independent checks pin the conventions:

- Weyl symmetries and $\mathop{\mathrm{Ric}}=0$ hold to $3\times10^{-16}$ at $n=5,6,8$.
- Sample rank equals $\dim\mathcal W_n=n(n+1)(n+2)(n-3)/12$ exactly at $n=5,6,7,8,11,12$, $35,84,168,300,1144,1638$, with the first discarded singular value at $10^{-13}$.
- $\#$ on a $\phi$-diagonal operator returns $(M^\#)_{(ij)(ij)}=\sum_kw_{ik}w_{jk}$ to $2\times10^{-16}$.
- $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$ holds to $4\times10^{-16}$ at $n=5,6,7,8$ on random Weyl tensors. This single check validates $M$, $\#$, $\mathring W$ and the normalisation simultaneously.
- Unpenalised ascent on $\theta$ lands at $\sqrt{3/2}=1.224745$ with $\kappa^2=1$ at $n=6,8$ (padded $W_{\mathbb{CP}^2}$) and at $\theta_0(12)=1.2360331$ with $\kappa^2=2$ at $n=12$ ($S^6\times S^6$), the expected champions at both sides of the crossover.

**Spanning is load-bearing for exactly one number in this report**, the constant $c(n)$ below, which is a normalised trace over an orthonormal basis of $\mathcal W_n$; its rank was verified at every $n$ used. Claims 1–4 are per-tensor or analytic and spanning is inert for them.

## Claim 2, CONFIRMED, and it is a two-line theorem rather than a computation

Write $P$ for the pairs $i<j$. Then $\lVert K(F)\rVert_F^2=\sum_{a\ne b}W_{abab}^2=2\sum_{p\in P}M_{pp}^2\le2\sum_{p,q}M_{pq}^2=2\lVert W\rVert^2$, with equality exactly when every off-diagonal entry of $M$ vanishes. That is the bound and the "iff" together, with no numerics; $O(n)$-invariance of $\kappa$ is immediate because the frame set is an $O(n)$-orbit, and the maximum is attained because $O(n)$ is compact. **The claim is true and its computational support is inert**, the "verified at $n=4..12$" adds nothing to an identity.

The ascent is the part worth attacking, and it survives. My implementation (Riemannian ascent with a Cayley retraction and an analytic $\mathfrak{so}(n)$ gradient, finite-difference validated to $10^{-10}$) reproduces every quoted value and cannot beat one: $\kappa^2=3/(m+1)$ at $\mathbb{CP}^m$ from 40 starts and 1200 iterations leaves an excess of $\le3.6\times10^{-15}$, i.e. the standard frame is already optimal there. The sharper test is recovery: a random rotation of $S^3\times S^3$ has $\lVert K\rVert_F^2=0.1358$ in the given frame, and the ascent returns $2.000000000$ from 15 starts. The same at $n=8$ from $0.1272$. **A hidden diagonal frame is found, so the ascent is not returning local maxima on the cases that matter.**

## Claim 3, CONFIRMED, both closed forms

Built $\mathbb{CP}^m$ from $T_{ijkl}=J_{ik}J_{jl}-J_{il}J_{jk}+2J_{ij}J_{kl}$, projected and normalised. Both closed forms agree to $10^{-15}$ at $m=2,\dots,7$: $\kappa^2=3/(m+1)$, and $\theta=\sqrt{(m+1)(2m-1)/(3m(m-1))}$ re-derived rather than assumed. $\theta(\mathbb{CP}^3)=\theta_0(6)$ exactly, which is worth noting as a coincidence the record can use.

## Claim 4, CONFIRMED, both parts

(i) Rotating padded $W_{\mathbb{CP}^2}$ leaves $\theta=1.224744871$ fixed while $\lVert K(F)\rVert_F$ ranges over $[0.126,0.809]$ across 400 Haar frames at $n=6$ (the record's $[0.105,1.000]$ used descent and the standard frame; same phenomenon, and the endpoints are not load-bearing). No inequality between an invariant and a non-invariant survives.

(ii) $\theta/\kappa=(m+1)\sqrt{2m-1}/(3\sqrt{m(m-1)})$ follows from the two closed forms and diverges. Ratios $1.27292$ at $\mathbb{CP}^4$ and $1.34164$ at $\mathbb{CP}^5$ confirmed; both exceed $\sqrt{3/2}$.

**But part (ii) proves less than it is used for, and that is where Claim 5 fails.** The divergence is in $m$, hence in $n$: it says no constant works *uniformly in dimension*. Read the same family at fixed $n$ and it says the opposite of what Claim 5 needs.

## Claim 1, the fact is CONFIRMED and understated; the diagnosis is REFUTED

**Vacuity is total, not partial, and the recorded cause is not the cause.** Let $\omega^\star=(a,\dots,a,-(N-1)a)$ with $a=\sqrt{3/(N(N-1))}$, $N=\dim S^2_0$, the Okumura minimiser of $p_3(\omega)$ under $\sum\omega=0,\sum\omega^2=3$. For every $t\in[0,1]$ the vector $t\,\omega^\star$ has the same ordering and partial sums scaled by $t$, so $\omega^\star\succ t\,\omega^\star$. Hence a $d$ with $\sum d^2=3t^2$ that the constraint cannot see exists **at every spread level up to the maximum**. Confirmed at $n=12$: with $d$ Okumura-shaped and $\sum d^2\in\{0.0659,0.5,1,2,3\}$ the constrained minimum is $-5.094376$ each time, the unconstrained value to six figures. The same holds on the $\Lambda^2$ side: a spike-shaped $d$ leaves $\max p_3(\mu)=0.977128$ at every level.

Two consequences, both against the record:

- The recorded explanation, "$\sum d^2$ falls to $0.03$–$0.14$ at random Weyl tensors", **is not why the constraint fails**. It would fail identically if $\sum d^2$ were pinned at its maximum $3$.
- Therefore the "missing ingredient" the record names, a lemma $\theta$ large $\Rightarrow\lVert K\rVert_F$ large, **would not lift the vacuity even if proved.** It supplies a norm; the constraint is moved by a shape.

**And "vacuous" is the wrong word for the constraint itself.** $d$ is never an arbitrary vector: it is $(\text{off-diagonal entries of }K;\ -\mathop{\mathrm{spec}}K|_{\mathbf1^\perp})$ with $K$ hollow, symmetric and zero-row-sum. Holding only that structure and $\lVert K\rVert_F^2=s$ ($d$ constrained, nowhere pinned), the $n=12$ relaxation moves:

| $s=\lVert K\rVert_F^2$ | relaxation (worst $K$ found) |
|---|---|
| $12/182=0.0659$ (the unconditional floor) | $4.008$ |
| $0.5$ | $3.480$ |
| $1.0$ | $2.691$ |
| $1.5$ | $1.911$ |
| $2.0$ (coordinate-diagonal) | $1.236=\theta_0(12)$ |

against the unconstrained $4.0129$. That is a formulation with $d$ constrained but not pinned that bites, so the answer to the brief's question is **yes**.

**A second Schur–Horn constraint is available and the record does not use it.** $\mathop{\mathrm{diag}}M$ in the $\phi$-basis of $\Lambda^2$ is *also* exactly $K$ (verified to $0$), so $\mu\succ d_\varphi$ as well. It bites hard because the maximiser of $p_3(\mu)$ is a single spike, which fails to majorize a spread vector: at $S^6\times S^6$ it takes $\max p_3(\mu)$ from $0.9771$ to $0.0225$. Every entry in the table above already uses it.

## Claim 5, REFUTED as an inference

The conclusion may well be right. The argument given for it is not, and it fails in the same shape as the two prior errors the brief names: a correct computation about one regime is read as a statement about a different one.

### 1. The premise is false, an invariant lower bound on the spread exists, in closed form

$W\mapsto\sum_{a\ne b}W_{abab}^2$ averaged over Haar $O(n)$ is an $O(n)$-invariant quadratic form on $\mathcal W_n$, which is an irreducible $O(n)$-module, so the average is a fixed multiple of $\lVert W\rVert^2$. Computing that multiple as a normalised trace over an orthonormal basis of $\mathcal W_n$ gives an exact rational at every dimension tested:

$$\mathbb E_F\lVert K(F)\rVert_F^2=\frac{12}{(n+1)(n+2)}\lVert W\rVert^2 \qquad\Longrightarrow\qquad \boxed{\ \kappa^2(W)\ \ge\ \frac{12}{(n+1)(n+2)}\lVert W\rVert^2\ }$$

Verified to 12 digits at $n=5,6,7,8,9,10,11,12$, $\tfrac27,\tfrac3{14},\tfrac16,\tfrac2{15},\tfrac6{55},\tfrac1{11},\tfrac1{13},\tfrac6{91}$. Independently, Monte Carlo over $4000$ Haar frames returns the same constant for $S^6\times S^6$, $\mathbb{CP}^6$ and a random Weyl tensor at $n=12$ ($0.0657$, $0.0657$, $0.0660$ against $0.065934$), the $W$-independence is the irreducibility showing up in the arithmetic.

So **"no invariant of $W$ supplies the spread" is false as stated**: $\kappa$ itself is an invariant and it is bounded below by an explicit function of $n$ alone. What Claim 4(ii) exhibits is $\kappa\to0$ along a sequence with $n\to\infty$, which is consistent with the bound and says nothing at any fixed $n$.

### 2. $\mathbb{CP}^m$ is a *high*-spread family, so it is the wrong witness

$$\frac{\kappa^2(\mathbb{CP}^m)}{\mathbb E_F\lVert K\rVert_F^2\ \text{at}\ n=2m}=\frac{3/(m+1)}{12/((2m+1)(2m+2))}=\frac{2m+1}2\ \longrightarrow\ \infty .$$

At $n=12$, $\mathbb{CP}^6$ carries $6.5$ times the generic spread, and a random Weyl tensor at $n=12$ has $\lVert K\rVert_F^2\approx0.05$ against $\mathbb{CP}^6$'s $0.4286$. The family whose spread "vanishes" is *more* diagonal than a typical tensor by a factor growing linearly in $m$.

### 3. $\mathbb{CP}^m$ is not in the region the bound must cover, and moves further out as its spread falls

| $m$ | $n=2m$ | $\theta(\mathbb{CP}^m)$ | $\theta_0(n)$ | $\theta/\theta_0$ | $\kappa^2$ |
|---|---|---|---|---|---|
| 2 | 4 | 1.224745 | 0.866025 | **1.4142** | 1.0000 |
| 3 | 6 | 1.054093 | 1.054093 | **1.0000** | 0.7500 |
| 4 | 8 | 0.986013 | 1.145644 | 0.8607 | 0.6000 |
| 6 | 12 | 0.924962 | 1.236033 | 0.7483 | 0.4286 |
| 8 | 16 | 0.896421 | 1.280869 | 0.6999 | 0.3333 |
| 12 | 24 | 0.868936 | 1.325498 | 0.6556 | 0.2308 |
| $\to\infty$ | | $\sqrt6/3=0.8165$ | $\to\sqrt2$ | $\to0.5774$ | $\to0$ |

$\theta$ falls and $\theta_0$ rises, so the members with small $\kappa$ are exactly the members furthest below threshold. Padded into a **fixed** $n\ge12$ the whole family has $\theta\le\sqrt{3/2}=1.2247<\theta_0(12)$, and its minimum spread there is $\kappa^2\ge6/(n+2)$, bounded away from zero. **The divergence in Claim 4(ii) is bought entirely by leaving the region of interest.**

### 4. Applying it per $n$ is the correct reading, and $\mathbb{CP}^m$ is that lemma's sharpness case

$C_n:=\max_{\lVert W\rVert=1}\theta/\kappa$ is finite at every $n$ by compactness, and the conjecture is a per-$n$ statement with an $n$-dependent constant, so $\theta\ge\theta_0(n)\Rightarrow\kappa\ge\theta_0(n)/C_n$ is all the route ever needed. A 14-start ratio ascent approaches the $\mathbb{CP}^{n/2}$ value from below at every $n$ tested and never beats it, so $\mathbb{CP}^{n/2}$ appears to *be* the extremiser:

| $n$ | best $\theta/\kappa$ found by ascent | $\mathbb{CP}^{n/2}$ value | implied $\kappa^2$ at $\theta=\theta_0(n)$ |
|---|---|---|---|
| 6 | 1.198644 | 1.217161 | 0.7500 |
| 8 | 1.261815 | 1.272938 | 0.8100 |
| 10 | 1.322118 | 1.341641 | 0.8000 |
| 12 | 1.394424 | 1.412903 | 0.7653 |
| 14 | 1.466031 | 1.483596 | 0.7232 |

At $n=12$ the ascent's best point is $\theta=0.923941$, $\kappa^2=0.439035$, $\mathbb{CP}^6$ itself to within its own convergence tolerance. **So the family the record uses to refute the lemma is the family that would make it sharp.** That is the specific inversion Claim 5 rests on, and the implied spread at threshold, $\kappa^2\ge0.765$ at $n=12$, is $11.6$ times the unconditional floor.

### What is actually true about the lead, on the evidence I have

The lead does fail to close, and here is the reason, which is not Claim 5's:

- With the honest per-$n$ spread bound $\kappa^2\ge(\theta_0(12)/C_{12})^2=0.765$ fed into the structural relaxation, $n=12$ gives $\ge3.066$, a factor $2.48$ above $\theta_0(12)$. At the unconditional floor $\kappa^2\ge0.0659$ it gives $4.008$ against the unconstrained $4.0129$, so the guaranteed spread alone buys $0.13\%$.
- The relaxation reaches $\theta_0(12)$ only at $s\approx2$, i.e. only under exact coordinate-diagonality, which is Jäger's already-granted diagonal case. **Schur–Horn closes the conjecture precisely when it is handed the diagonal case.**
- And the rigidity it would need is false right up against threshold, on a witness already in the record. **Padded $W_{\mathbb{CP}^2}$ at $n=12$ has $\theta=1.224745=0.99087\,\theta_0(12)$ with $\kappa^2=1.0000000000$ exactly** (40 starts), half the maximum, where the relaxation gives $2.691$. Penalised ascent fills in below it, $\theta=0.9004\,\theta_0(12)$ at $\kappa^2=0.6261$, stable to $2\times10^{-4}$ under a 40-start re-optimisation of $\kappa$. So $\kappa^2$ is near $1$, not near $2$, at $99\%$ of threshold, and no continuous spread lemma can deliver $s\approx2$ at $\theta=\theta_0$.

That is a defensible retirement of the lead. It rests on the $\theta$-vs-$\kappa$ frontier near threshold at fixed $n$, and on the shape of the relaxation, and it uses $\mathbb{CP}^m$ nowhere.

## Two corrections to the record, both making Schur–Horn stronger than recorded

**(A) $\sum d^2=\tfrac32\lVert K\rVert_F^2$, not $\tfrac12\lVert K\rVert_F^2$, the record undercounts by a factor 3.** For diagonal $h=\mathop{\mathrm{diag}}(v)$, $\langle\mathring Wh,h\rangle=-v^\top Kv$, so **the $\psi$-block of $\mathring W$ in the NPW basis is exactly $-K$ restricted to $\mathbf1^\perp$** (verified to $6\times10^{-17}$ at $n=5,6,8,10$). Since $K$ has zero row sums, $K\mathbf1=0$ and $K|_{\mathbf1^\perp}$ carries the whole spectrum; taking the $\psi$'s to be its eigenvectors (a legitimate NPW basis, and Schur–Horn holds in every one), gives $\sum_\psi d^2=\lVert K\rVert_F^2$ on top of the recorded $\sum_\varphi d^2=\tfrac12\lVert K\rVert_F^2$.

**(B) The conditional Schur–Horn bound is exact at the sphere product, not "a factor $2.4$ short".** Two further exact identities, both verified at $n=5,6,8,10$: $\mathop{\mathrm{tr}}\mathring W=0$ and $\lVert\mathring W\rVert_F^2=3\lVert W\rVert_F^2$. So at $\lVert K\rVert_F^2=2$ one has $\sum d^2=3=\sum\omega^2$, and majorization with equal $2$-norms forces $\omega=d$ as multisets, the second spectrum is *determined* by the vertex matrix. Running the corrected diagonal through my rebuild at $n=12$:

| | $\max p_3(\mu)$ | $\min p_3(\omega)$ | relaxation |
|---|---|---|---|
| unconstrained | 0.9771 | $-5.0944$ | $4.0129$ (record: $4.013$) |
| $S^6\times S^6$, $\varphi$-block diagonal only | 0.9771 | $-3.3609$ | $3.1462$ (record: $2.947$) |
| $S^6\times S^6$, full corrected diagonal | 0.0225 | $-2.4046$ | $\mathbf{1.2360}=\theta_0(12)$ |

The middle row's $-3.36$ against the record's $-2.963$ is the only number I do not reproduce; the bottom row's $-2.4046$ matches the record's own "truth $-2.405$" exactly, which is what the pinning predicts. **So the recorded "$2.947$ against $\theta_0(12)=1.236$, still a factor $2.4$" is an artefact of the $\varphi$-only diagonal.** Corrected, the conditional bound is tight. What remains true is that the condition is unavailable, which is a different objection and the one that should be on record.

## Sample adequacy

| claim | spanning load-bearing? | evidence |
|---|---|---|
| 1 | no (analytic plus per-$K$ optimisation |), |
| 2 | no (the bound and the "iff" are identities |), |
| 3 | no (single named tensors |), |
| 4 | no (single named witnesses |), |
| 5 | **yes**, for $c(n)$ only | sample rank $=\dim\mathcal W_n$ exactly at $n=5,6,7,8,11,12$ ($35,84,168,300,1144,1638$); discarded singular value $\le1.2\times10^{-13}$ |

## Claims true but inert

- Claim 2's numerics. $\kappa^2\le2$ with equality iff coordinate-diagonal is a two-line identity; "verified at $n=4,6,8,10,12$" confirms arithmetic, not mathematics.
- Claim 4(i). $\theta$ is invariant and $\lVert K(F)\rVert_F$ is not, so no such inequality can exist for reasons prior to any witness. The rotation experiment is a demonstration rather than a refutation.

## Reliability limits of my own numbers

- The $\kappa$ ascent is a maximisation, so every $\kappa$ reported is a **lower bound**. It recovers hidden diagonal frames from $\lVert K\rVert_F^2=0.13$, which is the strongest evidence I can give that it is not returning local maxima.
- $C_n$ values are lower bounds from a 14-start ascent; that $\mathbb{CP}^{n/2}$ is the exact extremiser is a conjecture supported at $n=6,8,10$, not a theorem.
- The relaxation table maximises over sampled $K$ at each $s$, so those entries are lower bounds on the true worst case; the honest bound is therefore no better than shown.
- Penalised-ascent points at large $\lambda$ are unreliable, at $n=12$ they stall at $\kappa^2\approx0.34$ with $\theta\approx0.01$, well above the known floor $0.0659$, so minimising $\kappa^2$ is not solved and only the small-$\lambda$ frontier is quoted.


---

## Synthesis carried in REVIEW.md

### Reviewer 102: the same five claims, on an identical brief

Full report: [reviews/REVIEW_r102.md](reviews/REVIEW_r102.md). Independent build validated by the bi-spectral identity to $4\times10^{-16}$ and by unpenalised ascent landing on $\sqrt{3/2}$ at $n=6,8$ and $\theta_0(12)$ at $n=12$. **Agrees with 101 on all five verdicts**, by different routes.

**Its own reasons for refuting Claim 5.** The premise is false: $\mathbb E_F\lVert K(F)\rVert_F^2=\frac{12}{(n+1)(n+2)}\lVert M\rVert_F^2$ exactly (an invariant quadratic form on the irreducible $\mathcal W_n$) so $\kappa^2\ge\frac{12}{(n+1)(n+2)}$ **unconditionally**, and an invariant of $W$ does supply spread. The witness is wrong twice over: $\mathbb{CP}^m$ is a *high*-spread family at $(2m+1)/2$ times generic, and it is not a competitor, $\theta(\mathbb{CP}^m)/\theta_0(2m)$ falling monotonically from $1.414$ to $0.577$. Per $n$, $\mathbb{CP}^{n/2}$ is the lemma's **sharpness case**, ratio ascent converging onto $\mathbb{CP}^6$ itself at $n=12$.

**Two corrections larger than any verdict, both of which strengthen Schur–Horn rather than weakening it.** $\sum d^2=\tfrac32\lVert K\rVert_F^2$, not $\tfrac12$, a threefold undercount, the $\psi$-block of $\mathring W$ being exactly $-K|_{\mathbf1^\perp}$ to $6\times10^{-17}$. And **the conditional bound is exact, not $2.4\times$ short**: with the corrected diagonal, $\sum d^2=3=\sum\omega^2$ at $S^6\times S^6$ forces $\omega=d$ and the relaxation returns $1.2360=\theta_0(12)$; the recorded $2.947$ was a $\varphi$-only artefact.

**The unused constraint, and it is the cycle's most valuable output.** $\mathop{\mathrm{diag}}M$ in the $\varphi$-basis of $\Lambda^2$ is *also* exactly $K$, so $\mu\succ d_\varphi$ is a second Schur–Horn constraint the record has never used, taking $p_3(\mu)$ from $0.9771$ to $0.0225$ at $S^6\times S^6$. Against Reviewer 101's finding that $\tfrac32\max p_3(\mu)=1.4657$ alone exceeds $\theta_0(12)$, this is the difference between a hopeless formulation and a sharp one, and **both constraints run off the same $K$**, the coupling between the two spectra the route has wanted since its first cycle.

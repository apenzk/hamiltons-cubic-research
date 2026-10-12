# Review 101, the frame-optimised diagonal $\kappa$, and whether it retires the Schur–Horn lead

Independent rebuild from the brief's definitions only. Code in [scripts/reviewers/r101/](../scripts/reviewers/r101/); log in [agent_logs/reviewer101.log](../agent_logs/reviewer101.log).

## Verdicts

| Claim | Verdict |
|---|---|
| 1, Schur–Horn vacuous with $d$ free | **CONFIRMED, and strengthened to a proof.** An $\ell^2$ lower bound on $d$ is vacuous for *every* value up to the hard ceiling $\lVert d\rVert^2\le3$. |
| 2, $\kappa$ well defined, $\kappa^2\le2$, $=2$ iff coordinate-diagonal | **CONFIRMED** (the bound and the "iff" are one line, below). Ascent: reliable with $\ge60$ starts, **unreliable single-start** (7% low at $n=12$). |
| 3, $\kappa^2(\mathbb{CP}^m)=3/(m+1)$ | **CONFIRMED**, and now with a closed-form derivation of the standard-frame value; global maximality remains numerical. $\theta^2(\mathbb{CP}^m)$ re-derived independently. |
| 4, both lemma forms refuted | **CONFIRMED as conclusions, but (i)'s stated reason is a non sequitur and its witness is a sampling artifact.** The true fact is much stronger: $\min_F\lVert K(F)\rVert_F=0$. |
| 5, Claims 1–4 retire the Schur–Horn lead | **REFUTED as stated.** Two independent errors; the conclusion happens to survive, for a reason the author did not identify. |

## Validation of my implementation

Built from scratch: $\mathcal W_n$ by projection (Riemann symmetries $\to$ first Bianchi $\to$ orthogonal complement of the Kulkarni–Nomizu image), $M$ on $\Lambda^2$, $\mathfrak{so}(n)$ structure constants in the unnormalised $\phi_{ij}$, $M^\#$, $\mathring W$ in Li's convention, $K(F)$, and a Riemannian ascent on $O(n)$ for $\kappa$.

- **Sample rank $=\dim\mathcal W_n$** exactly at $n=4,5,6,8$ (10, 35, 84, 300). Ricci traces and first Bianchi to $10^{-15}$.
- $\theta=\theta_0(n)$ to $10^{-14}$ at balanced $S^{n/2}\times S^{n/2}$, $n=6,8,12$.
- The established identity $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$ reproduces $\theta$ to $10^{-9}$, an independent check on both $M^\#$ and my $\mathring W$.
- Both analytic gradients ($\partial_F\lVert K\rVert^2$, $\partial_W\theta$, $\partial_W\lVert K\rVert^2$) agree with central differences to $10^{-11}$. In passing this confirms $\nabla_M\theta=3(M^2+M^\#)$, i.e. the sharp trilinear form is fully symmetric.

**Spanning is load-bearing only for Claim 1** (the "$\sum d^2$ at random Weyl" figure) and for my frontier search (Claim 5), where a sample that missed a subspace could hide a witness. Claims 2, 3, 4 are statements about named tensors and need no spanning.

## Claim 2, confirmed, and the proof is one line

In any frame, $K(F)_{ab}=W^F_{abab}=M(F)_{(ab),(ab)}$, so

$$\lVert K(F)\rVert_F^2=\sum_{a\neq b}(W^F_{abab})^2=2\sum_{\alpha}M(F)_{\alpha\alpha}^2 .$$

Verified to $10^{-12}$ at $n=6,8,12$. Since $M(F)=\Lambda^2(F)\,M\,\Lambda^2(F)^{\mathsf T}$ is an orthogonal conjugation, $\sum_\alpha M(F)_{\alpha\alpha}^2\le\lVert M\rVert_F^2$ with equality iff $M(F)$ is diagonal, which is exactly coordinate-diagonality of $W$. $O(n)$ is compact and the objective continuous, so the max is attained. **Both halves of the claim follow immediately**; no computation was needed for either.

Two corrections:

- **Normalisation.** "$\kappa^2\le2\lVert W\rVert^2$" is sharp only if $\lVert W\rVert$ means $\lVert M\rVert_F$. Read as the tensor Frobenius norm it is slack by a factor 4 ($\lVert W\rVert^2=4\lVert M\rVert^2$).
- **Ascent quality.** At $n=12$ on a random Weyl tensor the ascent returns $0.35508$ from 1 start, $0.38091$ from 20, and is stable at $0.380979$ from 60 through 300. **A single start under-reports $\kappa^2$ by 7%.** Every quoted $\kappa$ should carry a start count. I could not beat any quoted value anywhere: 60-start ascent plus 40 rounds of basin-hopping reproduces $3/(m+1)$ at $m=3,4,5$ to $2\times10^{-15}$ and $2.000000$ at every sphere product.

## Claim 3, confirmed, and now analytic on the standard frame

For Fubini–Study ($R_{ijkl}=g_{ik}g_{jl}-g_{il}g_{jk}+J_{ik}J_{jl}-J_{il}J_{jk}+2J_{ij}J_{kl}$), the Weyl vertex matrix in the standard frame is

$$K_{ab}=3J_{ab}^2-\frac{3}{2m-1},\qquad \lVert K\rVert_F^2=\frac{36m(m-1)}{2m-1},\qquad \lVert W\rVert^2=\frac{48m(m-1)(m+1)}{2m-1},$$

all three verified exactly at $m=2,\dots,7$. Hence $4\lVert K\rVert^2/\lVert W\rVert^2=3/(m+1)$: the claimed value is the *standard-frame* value, derivable in closed form. That it is the **global** maximum over $O(2m)$ remains numerical (basin-hopping, $m\le5$).

$\theta^2(\mathbb{CP}^m)=\frac{(m+1)(2m-1)}{3m(m-1)}$ re-derived independently: agrees to $10^{-10}$ at $m=2,\dots,7$.

## Claim 4, right conclusions, wrong reason for (i)

**(i) The stated argument is invalid.** "$\theta$ is $O(n)$-invariant and $\lVert K(F)\rVert_F$ is not, therefore no constant works" does not follow: if $\inf_F\lVert K(F)\rVert_F\ge c>0$ uniformly on the unit sphere, then $\theta\le(\theta_{\max}/c)\lVert K(F)\rVert_F$ holds in every frame. The quoted witness, $\lVert K\rVert_F$ ranging over $[0.105,1.000]$, only forces $C\ge11.7$; it refutes nothing.

**The claim is nevertheless true, by a much stronger fact.** Minimising $\lVert K(F)\rVert_F^2$ over $O(n)$ by gradient descent from 25 random starts:

| tensor | $\theta$ | $\min_F\lVert K(F)\rVert_F$ |
|---|---|---|
| padded $W_{\mathbb{CP}^2}$, $n=4$ | 1.224745 | $6\times10^{-12}$ |
| padded $W_{\mathbb{CP}^2}$, $n=6,8,10,12$ | 1.224745 | $3$–$5\times10^{-4}$ (still descending) |
| balanced $S^{n/2}\times S^{n/2}$, $n=6,10,12$ | $\theta_0(n)$ | $1$–$7\times10^{-10}$ |
| random Weyl, $n=6,8,10$ |, | $10^{-9}$ |

**The vertex matrix vanishes identically in some frame, for every tensor tested, including the conjectured maximiser.** The dimension count agrees: $K=0$ is $\binom n2$ equations with $n$ row-sum dependencies, against $\dim O(n)=\binom n2$. So $\inf_F\lVert K(F)\rVert_F=0$ and no fixed-frame constant exists, for a reason the brief does not give. **The interval $[0.105,1.000]$ is an artifact of sampling rotations rather than minimising over them, and should not be quoted as a range.**

**(ii) Confirmed** on the numbers, with a caveat carried into Claim 5: the ratio $\theta/\kappa\to\infty$ requires $m\to\infty$, i.e. $n\to\infty$. It refutes a constant $C$ **uniform in $n$**. It does not touch a per-$n$ constant $C_n$, and $C_n=\theta_0(n)\sqrt{(n+2)/6}$ is consistent with every $\mathbb{CP}^m$ data point.

## Claim 5, REFUTED as stated

I reproduced the lead's two anchor numbers exactly from my own build: the free relaxation $\max\tfrac32p_3(\mu)-\tfrac12\min p_3(\omega)$ subject to $\sum\mu=\sum\omega=0$, $\sum\mu^2=1$, $\sum\omega^2=3$ gives $1.4657+2.5472=\mathbf{4.0129}$ at $n=12$, and imposing $\omega\succ d$ with $d$ the full $S^2_0$-diagonal at $S^6\times S^6$ gives $\mathbf{2.9474}$. So I am auditing the same object.

### Error 1, $\kappa$ is not the quantity the majorization bound uses, and a perfect bound on it is worth nothing

Claim 5's premise is "the majorization bound needs the diagonal to be spread". Spread **in which norm** is the whole question, and $\kappa$ measures $\ell^2$. Let $\Phi(c)$ be the relaxation when $d$ is required only to satisfy $\sum d=0$ and $\lVert d\rVert^2\ge c$ (worst case over admissible $d$, this is exactly the information $\kappa$ supplies, since $\lVert K\rVert_F^2=2\lVert d_K\rVert^2$):

| $c$ | 0 | 0.3 | 0.6 | 1.0 | 1.225 | 2.0 | 2.5 | 2.9 |
|---|---|---|---|---|---|---|---|---|
| $\Phi(c)$ | 4.0129 | 4.0129 | 4.0129 | 4.0129 | 4.0129 | 4.0129 | 4.0129 | 4.0129 |

**Flat, at the unconstrained value, all the way to the ceiling.** This is not a numerical accident; it is a proof. With $D=\dim S^2_0$, let

$$d_c=(a,\dots,a,-(D-1)a),\ a=\sqrt{\tfrac{c}{D(D-1)}},\qquad \omega^\star=(b,\dots,b,-(D-1)b),\ b=\sqrt{\tfrac{3}{D(D-1)}}$$

where $\omega^\star$ is the free minimiser of $p_3$ on $\{\sum\omega=0,\sum\omega^2=3\}$. Then $\sum d_c=0$, $\lVert d_c\rVert^2=c$, and $\sum_{k\le j}\omega^\star_k=jb\ge ja=\sum_{k\le j}(d_c)_k$ for all $j\le D-1$ whenever $c\le3$. So $\omega^\star\succ d_c$: the constraint is satisfied by the unconstrained optimum. And $\lVert d\rVert^2\le\sum\omega^2=3$ holds automatically for any genuine diagonal. **Therefore an $\ell^2$ lower bound on the diagonal is vacuous at every attainable value, including $\kappa^2=2$, the maximum $\kappa$ can ever be.**

The consequence for the record: **the entire $\kappa$ programme is inert.** Even if the lemma $\theta\le C_n\kappa$ had been true, and even if one proved $\kappa^2=2$ at the maximiser, the relaxation would not move off $4.0129$. Claims 2–4 refute a lemma that could not have helped.

### What the bound actually uses

The binding feature is the **bulk cumulative sums** $\sum_{k\le j}d^\downarrow_k$ at moderate $j$. At the optimum for $d(S^6\times S^6)$, 37 of the 76 majorization inequalities are active, spread over $j=1\ldots40$. Cumulative profiles, $n=12$, $D=77$:

| $j$ | 5 | 10 | 20 | 30 | 40 | 50 | $\lVert d\rVert_1$ |
|---|---|---|---|---|---|---|---|
| $S^6\times S^6$ | 0.674 | 1.348 | 2.697 | 4.045 | **4.405** | 3.281 | 9.439 |
| $\mathbb{CP}^6$ | 0.901 | 1.341 | 1.201 | 1.021 | 0.841 | 0.661 | 2.691 |
| padded $\mathbb{CP}^2$ | 1.225 | 1.225 | 1.225 | 1.225 | 1.225 | 1.225 | 2.449 |
| free $p_3$-minimiser $\omega^\star$ | 0.113 | 0.226 | 0.453 | 0.679 | 0.906 | 1.132 |, |

The single most efficient index is $j=40$: imposing $\sum_{k\le40}\omega^\downarrow_k\ge4.4048$ alone gives $3.1723$, versus $2.9474$ for the whole profile. Note $\mathbb{CP}^6$ has a *larger* top entry than $S^6\times S^6$ (0.180 vs 0.135) and still yields only $3.7481$, so it is neither $\lVert d\rVert_2$ nor $d^\downarrow_1$ that matters. **The honest answer to the brief's question is: yes, there is a formulation with $d$ constrained but not pinned that still bites, a lower bound on $\sum_{k\le j}d^\downarrow_k$ for $j\approx D/2$. Nobody has tried to prove one.**

### Error 2, $\mathbb{CP}^m$ is not in the region the bound has to cover

$\theta(\mathbb{CP}^m)$ against $\theta_0(2m)$:

| $m$ | 2 | 3 | 4 | 5 | 6 | 7 |
|---|---|---|---|---|---|---|
| $n=2m$ | 4 | 6 | 8 | 10 | 12 | 14 |
| $\theta(\mathbb{CP}^m)$ | 1.2247 | 1.0541 | 0.9860 | 0.9487 | 0.9250 | 0.9085 |
| $\theta_0(n)$ | 0.8660 | 1.0541 | 1.1456 | 1.2000 | 1.2360 | 1.2617 |

$\mathbb{CP}^m$ **ties** the balanced sphere product at $m=3$ and falls strictly below it for every $m\ge4$, by 25% at $n=12$. The Schur–Horn bound is only ever applied to exclude $\theta\ge\theta_0(n)$; $\mathbb{CP}^m$ with small $\kappa$ lives at $\theta\approx0.92$, far outside. Exhibiting it as proof that "no invariant supplies what the bound needs" tests a lemma strictly stronger than the one required, the same shape of error the brief warned about.

**The restricted lemma is not merely unrefuted; it looks true.** I searched for $\max\{\theta:\kappa^2\le c\}$ at $n=8$ and $n=12$ by Riemannian ascent on the unit sphere in $\mathcal W_n$ with an exact penalty on $\kappa^2$ (3 random starts per $c$, $\kappa$ re-maximised by warm-started ascent every step, 20-start refresh at the end). Combining that with an exhaustive catalogue of the named critical points at $n=12$:

| $\kappa^2\le$ | 0.4286 | 0.60 | 0.75 | 1.00 | 2.00 |
|---|---|---|---|---|---|
| best $\theta$ found | 0.9250 | 0.9860 | 1.0541 | 1.2247 | **1.2360** |
| attained at | $\mathbb{CP}^6$ | $\mathbb{CP}^4$ pad | $\mathbb{CP}^3$ pad | $\mathbb{CP}^2$ pad | $S^6\times S^6$ |

Every one of the 18 catalogued objects at $n=12$ with $\theta\ge1.14$ has $\kappa^2\ge1$; every sphere product, padded or not, has $\kappa^2=2.000000$ exactly. **The optimiser recovered $\theta=1.236033=\theta_0(12)$ at $\kappa^2=2$ as the unconstrained global maximum** (an independent numerical corroboration of Conjecture A at $n=12$) and found nothing above $1.2247$ anywhere below $\kappa^2=2$. The search is local and gives lower bounds only, so this is evidence, not proof; but it points the opposite way from Claim 5.

### One more correction

$\mathbb{CP}^m$ is not the low-$\kappa$ extreme. Random unit Weyl tensors at $n=12$ have $\kappa^2\approx0.372$ (min over 12 samples, 20-start ascent), **below** $\mathbb{CP}^6$'s $0.4286$. What distinguishes $\mathbb{CP}^m$ is combining small $\kappa$ with $\theta$ of order 1, not small $\kappa$ as such.

### What survives

The *conclusion* "the $\kappa$ repair is dead" is right, for a reason Claim 5 does not state: $\kappa$ is an $\ell^2$ meter and the bound consumes $\ell^1$-like bulk cumulative sums, so a lower bound on $\kappa$ is provably worthless even at its ceiling. The *inference* in Claim 5 (that this retires the Schur–Horn lead because no invariant can supply what the bound needs), **does not follow, and my numerics point against it.**

Separately, and independently of everything above: with $d$ pinned at the maximiser the relaxation still reads $2.9474$ against a target of $\theta_0(12)=1.2360$, a factor $2.385$. **No $d$-side improvement can close Conjecture A in this formulation, because the gap is on the $\mu$ side too**, $\tfrac32\max p_3(\mu)=1.4657$ already exceeds $\theta_0(12)$ on its own. That, not $\mathbb{CP}^m$, is the reason to be pessimistic about the lead as currently posed.

## Claim 1, confirmed, and it is the same theorem as Error 1

With $d$ genuinely free the constraint is satisfiable by $d=0$, so it is vacuous; correct. My reproduction of the supporting figure: at $n=12$ over 20 random unit Weyl tensors, $\lVert d\rVert^2\in[0.026,0.052]$ and $\lVert K\rVert_F^2\in[0.051,0.094]$ in the identity frame, the same order as the quoted $0.03$.

The word "vacuous" is right but understates the situation, and the brief's own follow-up question has a sharp answer. Two things are worth putting in the record:

1. **$d_K$ is a genuine two-sided coupling variable.** $K_{ab}=W_{abab}$ is simultaneously the $\Lambda^2$-diagonal of $M$ (so $\mu\succ d_K$, same length $\binom n2$) and the $\varphi$-part of the $S^2_0$-diagonal of $\mathring W$ (so $\omega\succ(d_K,e)$), verified to $10^{-16}$. Existentially quantifying over $d_K$ couples $\mu$ and $\omega$ with no a priori knowledge. It is still vacuous, because $d_K=0$ satisfies both.
2. **Adding $\lVert d\rVert^2\ge c$ does not repair it, at any $c$**, proved above. **Adding a bulk cumulative-sum lower bound does.** That is the formulation the brief asks for, and it is the open problem the lead should be reduced to.

## Summary of corrections owed to the record

1. Claim 4(i)'s stated reason is a non sequitur; the range $[0.105,1.000]$ is a sampling artifact. The true fact is $\min_F\lVert K(F)\rVert_F=0$, including at the conjectured maximiser.
2. Claim 4(ii) refutes a constant uniform in $n$, not a per-$n$ constant.
3. Claim 5's premise is false: the majorization bound does not use $\ell^2$ spread. $\Phi(c)=4.0129$ for every $c\le3$, provably. The $\kappa$ programme was inert before $\mathbb{CP}^m$ was ever consulted.
4. Claim 5's witness is out of region: $\theta(\mathbb{CP}^m)<\theta_0(2m)$ for all $m\ge4$, by 25% at $n=12$.
5. Claim 2 needs "$\lVert W\rVert$" fixed to $\lVert M\rVert_F$, and every quoted $\kappa$ needs a start count, single-start ascent is 7% low at $n=12$.
6. $\mathbb{CP}^m$ is not the $\kappa$-minimiser; random Weyl tensors go lower.


---

## Synthesis carried in REVIEW.md

### Reviewer 101: $\kappa$, the closed form, and the route-closing inference

Full report: [reviews/REVIEW_r101.md](reviews/REVIEW_r101.md). Own build; sample rank $=\dim\mathcal W_n$ at $n=4,5,6,8$, $\theta=\theta_0(n)$ to $10^{-14}$, all gradients finite-difference checked to $10^{-11}$.

**All five claims addressed; the fifth refuted.** Claims 1–4 CONFIRMED, with Claim 1 upgraded from numerics to a proof and Claim 3 given a closed-form derivation. Claim 5 (that Claims 1–4 retire the Schur–Horn lead), **REFUTED as stated**, on two independent errors.

**The load-bearing finding, and it is worse than the refutation.** Reviewer 101 reproduced both anchor numbers from its own build ($4.0129$ free, $2.9474$ with $d$ pinned) and then asked what the majorization actually consumes. **A lower bound on $\kappa$ is worth exactly nothing:** with $d$ constrained only by $\sum d=0$ and $\lVert d\rVert^2\ge c$ (precisely what $\kappa$ supplies), the relaxation stays at $4.0129$ for every $c$ up to the hard ceiling $\lVert d\rVert^2\le\sum\omega^2=3$, **including at $\kappa^2=2$**. This is provable: the free $p_3$-minimiser $\omega^\star=(b,\dots,b,-(D-1)b)$ majorizes the flat $d_c=(a,\dots,a,-(D-1)a)$ whenever $c\le3$. **So the whole $\kappa$ programme was inert before $\mathbb{CP}^m$ was ever consulted**, the lemma the cycle chased would have bought nothing had it been proved.

**What the bound does consume:** bulk cumulative sums $\sum_{k\le j}d^\downarrow_k$ at $j\approx D/2$, with $37$ of $76$ constraints active at $n=12$ and $j=40$ alone giving $3.1723$. That is the "$d$ constrained but not pinned" formulation, and nobody has attempted one.

**The real reason for pessimism, which nothing in the cycle had identified.** Independently of all the above, $\tfrac32\max p_3(\mu)=1.4657$ already exceeds $\theta_0(12)=1.2360$, so **no $\omega$-side improvement can close the conjecture in this formulation.**

**Corrections owed.** Claim 4(i)'s witness is an artefact: $\min_F\lVert K(F)\rVert_F=0$ for every tensor tested, the conjectured maximiser included, so the recorded range $[0.105,1.000]$ came from *sampling* rotations rather than minimising over them. Claim 4(ii) kills only a constant uniform in $n$, not a per-$n$ $C_n$. In Claim 2 the norm must be $\lVert M\rVert_F$ or the bound is slack by $4$, and single-start ascent runs $7\%$ low at $n=12$. $\mathbb{CP}^m$ is not the $\kappa$-minimiser, random Weyl tensors reach $\kappa^2\approx0.372$ against $\mathbb{CP}^6$'s $0.4286$.

# Gate 2 review r241 -- A2 rationality of the certificate data

Reviewer 241. Assigned claims: 1 (reducedness discharge) and 3 (Casimir-difference denominators).
Commits under review: 4676381 (primary), 848d184, 0eb360f, 0df3dff. Primary file: [scripts/runs/run_a2_rational_data.py](../scripts/runs/run_a2_rational_data.py).

## Verdict table

| Claim | Subject | Verdict |
|---|---|---|
| 1 | Reducedness of the diagram spanning set closed in two lines | **NOT EXHAUSTIVE**, the dichotomy misses metric cycles of length $\ge2$ and Weyl self-traces routed through a metric, and the first of those is an explicit counterexample to $L\le\min(a_P,a_Q)$. Conclusion survives; a four-case replacement is supplied |
| 3 | Casimir-difference denominators root-free on [12, infinity) | **REFUTED as stated**, the single-Casimir Lagrange denominator vanishes at $n=12$ itself, and for 204 of the 2485 block pairs *all six* invariant differences have a root in $[12,\infty)$. The route survives: the gcd denominators are root-free by a proof, so A5 gains nothing here |

---

## Claim 3, the Casimir-difference denominators. **REFUTED as written; the route survives, and the repair makes A5's checklist shorter rather than longer.**

Scripts: [c3_casimir_differences.py](../scripts/reviewers/r241/c3_casimir_differences.py), [c3_gcd_repair.py](../scripts/reviewers/r241/c3_gcd_repair.py), output [out_c3.txt](../scripts/reviewers/r241/out_c3.txt).

### Setup, re-derived

The block table is constant for $n\ge12$ ([A1](../plan.md)), so a block is a partition $\lambda$ with at most six rows and $\lvert\lambda\rvert\in\{0,2,\dots,12\}$: the $77$ $SO(12)$ constituents in [n12_sym3_blocks.pkl](../scripts/runs/n12_sym3_blocks.pkl) with the six chirality pairs fused, **71 $O(n)$ blocks**, reproduced by this reviewer from the pickle. Infinitesimal character $\ell_i(\lambda;n)=\lambda_i+n/2-i$, uniform across $B_r$ and $D_r$, since $\rho_i=n/2-i$ either way. The six separating invariants are $p_2,p_4,\dots,p_{12}$ ([sym3-blocks.md](../findings/sym3-blocks.md)). Entries $i>6$ are common to both labels and cancel, so

$$D_k^{\lambda\mu}(n)\;=\;\sum_{i=1}^{6}\Big[\ell_i(\lambda)^{2k}-\ell_i(\mu)^{2k}\Big],\qquad k=1,\dots,6,$$

a polynomial in $n$ of degree $2k-1$. **These differences are polynomials; the higher eigenvalues themselves are not**, $p_{2k}(\ell)$ summed over $i=1..\lfloor n/2\rfloor$ carries a tail $\sum_{i>6}(n/2-i)^{2k}$ that is not a polynomial in $n$. A2's "whose eigenvalues $c_i(\lambda)$ are POLYNOMIALS in $n$" is true for the quadratic one it writes out and needs a normalisation for the other five. Harmless (only differences enter the denominators) but it should be stated.

### The witness: the projector is singular at $n=12$ itself

$$\lambda=(6,4,0,0,0,0),\qquad \mu=(6,2,2,2,0,0),\qquad D_1(n)=-2(n-12).$$

From A2's own formula $c_2(\lambda)=\sum_k\lambda_k(\lambda_k+n-2k)$ at $n=12$: $6\cdot16+4\cdot12=144$ and $6\cdot16+2\cdot10+2\cdot8+2\cdot6=144$. **Equal.** So $\prod_j(C-c_j)/(c_i-c_j)$ in the quadratic Casimir divides by zero at the base dimension, the one dimension where A3 does its exact SDP. This witness is normalisation-free: $c_2=\langle\lambda,\lambda+2\rho\rangle$ is canonical.

### The scan, exact

| statement | count |
|---|---|
| block pairs, $\binom{71}{2}$ | $2485$ |
| pairs whose **quadratic** difference has a real root in $[12,\infty)$ | $204$ |
|, of those, roots at an **integer** $n\ge12$ | $202$ |
|, of those, roots **at $n=12$** | $5$ |
| pairs where $D_1\equiv0$: $c_2$ never separates them at any $n$ | $21$ |
| pairs where **all six** differences have a root in $[12,\infty)$ | $\mathbf{204}$ |
| pairs where all six vanish identically | $0$ |
| largest root of any quadratic difference | $n=42$, at $(6,4,0^4)$ vs $(2^6)$ |

Root counting is exact Sturm ([count_roots](https://docs.sympy.org/latest/modules/polys/reference.html#sympy.polys.polytools.count_roots) over $\mathbb Q$), not sampling.

**The two $204$s are the same $204$ pairs**, checked as a set equality. Structurally: each $D_k$ has leading term $2k(n/2)^{2k-1}(\lvert\lambda\rvert-\lvert\mu\rvert)$, so all six agree in sign at infinity, and on these pairs all six also agree in sign at $n=12$ and disagree with it, an intermediate-value root for every one of them at once. That is why "use a different Casimir for that pair" cannot work here.

**Two things follow, and the brief anticipated both.**

1. The formula as A2 writes it (Lagrange interpolation in *one* Casimir), is singular on $[12,\infty)$, at $n=12$ among other places. Not "a longer checklist": a checklist those $204\times6$ polynomials **fail**.
2. The obvious repair, *choose a different one of the six for that pair*, also fails. For the same $204$ pairs there is **no** root-free choice among $p_2,\dots,p_{12}$.

### Why the route is nevertheless not damaged

Univariate differences have a gcd. Writing $g_{\lambda\mu}=\gcd(D_1,\dots,D_6)\in\mathbb Q[n]$, Bezout gives $u_k\in\mathbb Q[n]$ with $\sum_ku_kD_k=g$, so $Z=\sum_ku_k(n)\,(C^{(2k)}-c^{(2k)}_\mu)$ is a central element, rational in $n$, vanishing on $\mu$ and equal to $g(n)$ on $\lambda$. The projector

$$P_\lambda=\prod_{\mu\ne\lambda}\frac{Z_{\lambda\mu}}{g_{\lambda\mu}(n)}$$

has the gcds as its only denominators.

**THEOREM. $g_{\lambda\mu}$ has no real root in $[12,\infty)$, for every pair.** If $g(n_0)=0$ then every $D_k(n_0)=0$, i.e. $p_k(x)=p_k(y)$ for $k=1,\dots,6$ where $x_i=\ell_i(\lambda;n_0)^2$ and $y_i=\ell_i(\mu;n_0)^2$, $i\le6$. Six power sums of six quantities give six elementary symmetric functions by Newton in characteristic zero, so $\{x_i\}=\{y_i\}$ as multisets. For real $n_0\ge12$ and $i\le6$, $\ell_i=\lambda_i+n_0/2-i\ge\lambda_6+n_0/2-6\ge0$ and $\ell_i-\ell_{i+1}=(\lambda_i-\lambda_{i+1})+1\ge1$, so both $\ell$-vectors are nonnegative and strictly decreasing. Equal multisets of squares then force $\ell(\lambda)=\ell(\mu)$ entrywise, hence $\lambda=\mu$. $\square$

Checked independently by exact Sturm on all $2485$ gcds: **every gcd has degree $0$ or $1$** ($1881$ constant, $604$ linear) and **not one has a root in $[12,\infty)$**. The same check on $\sum_kD_k^2$ over a $300$-pair sample agrees.

**The threshold $12$ is sharp, and the sharpness has the same cause as A1's.** The largest root of any gcd is $n=10$, at $(4,4,1,1,1,1)$ vs $(4,4,1,1,0,0)$: there $\ell=(8,7,3,2,1,0)$ against $(8,7,3,2,0,-1)$, squares $\{64,49,9,4,1,0\}$ both ways, a genuine collision of all six invariants, caused by $\ell_6=n/2-6<0$. The hypothesis $\ell_6\ge0$ is exactly $n\ge12$.

### Verdict

**Claim 3 REFUTED as stated, in three parts, with the route repaired.**

- "the differences are nonzero at every integer $n\ge12$", **false** for a single Casimir: $202$ pairs collide at integers, five of them at $n=12$. It is true for the six taken together, and that is a different statement.
- "each difference joins A5's checklist", **the wrong obligation**: $204$ pairs supply six polynomials each that would be *reported as having roots*, and adding a failing polynomial to a checklist does not certify it.
- "Sturm runs on the real interval, and a polynomial nonzero at the integers can still vanish between them", **the worry is real for the individual differences and vacuous for the right denominator.** Separation holds at every REAL $n\ge12$, by the theorem above; the gcd denominators are root-free by proof, so **A5's checklist gains nothing from block projection at all.**

*What A2 should say:* the block-projection denominators are the $\gcd$s $g_{\lambda\mu}$, of degree at most one, root-free on $[12,\infty)$ by the $\ell$-monotonicity argument, not a Sturm obligation, and not the single-Casimir Lagrange product, which is singular at $n=12$.

**One caveat stated honestly.** The negative results use the normalisation in which the central elements have Harish-Chandra image exactly $p_{2k}(\ell)$. Corrections of lower order would move the individual $D_k$ for $k\ge2$. Two things are immune: the $n=12$ quadratic collision, since $c_2$ is canonical, and the theorem, since it uses only that the six generate the $W$-invariant ring.
---

## Claim 1, the reducedness discharge. **NOT EXHAUSTIVE. The conclusion survives; the two-line argument does not, and the case it misses is the one that breaks the theorem the precondition exists to protect.**

Script: [c1_reducedness.py](../scripts/reviewers/r241/c1_reducedness.py). Exact over $\mathbb Q$ throughout, on a Weyl tensor built at $n_0=4$ and padded, so every $n$-dependence seen is the diagram's.

### What the discharge has to cover

A degree-$6$ diagram is a partial matching on $24$ Weyl slots plus $2a$ bare-metric slots, leaving $f$ free positions. **The number of bare metrics is not bounded by the degree** (chains and closed chains of $\delta$'s can be inserted at will) so a case list indexed by "which single factor carries the loop" has to reach configurations of unbounded size.

### The two cases A2 states are correct, and case (i) is exhaustive per factor

| configuration | value | reason |
|---|---|---|
| trace of $W$ on slots $1,2$ | $0$ | antisymmetry, first pair |
| slots $3,4$ | $0$ | antisymmetry, second pair |
| slots $1,3$; $1,4$; $2,3$; $2,4$ | $0$ | Ricci-flatness |
| $\delta^a{}_a$ | $n$ |, |

Six slot pairs, six vanishings, verified identically zero as $2$-tensors at $n=7$. **Within one Weyl factor the case list is complete.**

### Three configurations the dichotomy does not reach

Each is unreduced, and in each **no factor carries an edge with both ends on itself**, so none is a "self-loop" in A2's sense.

1. **A metric cycle of length two.** $g_{ab}g^{ab}=n$. Two *distinct* metric factors.
2. **Metric cycles of every length.** $g_{ab}g^{bc}g_{ca}=n$; the family is infinite, so this is not one omitted case but an omitted family.
3. **A Weyl self-trace routed through a metric.** $W_{abxy}\,g^{ab}\equiv0$. Two distinct factors, and the chain returns to the *same* Weyl factor.

A2's two cases are the length-minimal members of two infinite families: cycles of $\delta$'s, and paths of $\delta$'s with both terminals on one Weyl factor.

### The omission is not cosmetic, it breaks $L\le\min(a_P,a_Q)$

The precondition exists to protect the monomial theorem of [brauer-pairing.md](../findings/brauer-pairing.md), $\langle P,Q\rangle=n^L q_D$ with $L\le\min(a_P,a_Q)$. Take $P$ carrying a metric $2$-cycle ($a_P=2$) times a pure-Weyl part with two free indices, and $Q$ pure Weyl with two free indices ($a_Q=0$):

| $n$ | $\langle P_0,Q\rangle$, reduced | $\langle P,Q\rangle$, with the $2$-cycle |
|---|---|---|
| $5$ | $273529/2304$ | $1367645/2304$ |
| $6$ | $273529/2304$ | $273529/384$ |
| $7$ | $273529/2304$ | $1914703/2304$ |
| $8$ | $273529/2304$ | $273529/288$ |
| $9$ | $273529/2304$ | $273529/256$ |

The reduced entry is constant; the unreduced entry is exactly $n$ times it. $\min(a_P,a_Q)=0$ predicts **degree $0$**; the true degree is $\mathbf1$. **So the diagram A2's dichotomy fails to remove is precisely a counterexample to the bound the removal is for.**

*Rebuilt at the stated degree.* The table above uses a degree-$2$ covariant for cheapness. [c1_degree6_witness.py](../scripts/reviewers/r241/c1_degree6_witness.py) repeats it with $T_{ij}=(S^3)_{ij}$ (degree $6$, all $24$ Weyl slots occupied, $f=2$), at $n=5,\dots,10$: $\langle T,T\rangle=20464923860814889/195689447424$ constant, and $\langle(g_{ab}g^{ab})T,\,T\rangle$ exactly $n$ times it. The witness is not an artefact of the low degree.

### "already counted by the monomial theorem" is false

A2 discharges the metric self-loop by saying its $n$ "is the L-count already in the monomial theorem". $L$ counts cycles of the **pairing graph of $P$ against $Q$**. A loop internal to $P$ is not a pairing cycle: it factors out *before* the pairing, giving $\langle P,Q\rangle=n\cdot\langle P',Q\rangle=n^{1+L'}q_D$. It is an extra factor on top of the theorem's count, not an instance of it, which is exactly what the table above measures. The $n^6$ ceiling rests on the same identification and inherits the defect.

### The brief's second question: a loop touching two different Weyl factors

**Genuinely handled by the path/cycle decomposition, but A2 never invokes that decomposition, so within A2 it is assumed away.** Verified: $W^{(1)}_{abcd}W^{(2)}_{cdef}W^{(3)}_{efab}$, a closed contraction through three distinct Weyl factors, is constant $3847/1152$ at $n=5,6,7,8,9$, no factor of $n$.

**The reason, which appears in neither file.** A bare metric is the only factor that *composes*: $g_{ab}x^b=x_a$. A Weyl factor does not transmit a chain (entering on one slot and leaving on another is not a composition) so in the graph whose interior vertices are metric factors and whose terminals are Weyl slots, **every Weyl slot has degree $1$ and no cycle can contain one.** That asymmetric vertex convention is what makes "disjoint union of paths and cycles" true, and [brauer-pairing.md](../findings/brauer-pairing.md) asserts the degrees without it. It also states the decomposition only for the *pairing* graph of two diagrams; the reducedness discharge needs it for the *internal* structure of one diagram, and A2 supplies no decomposition step at all.

### The discharge, corrected

**Lemma (reduction).** In the graph on a single diagram whose interior vertices are the bare metric factors and whose terminals are Weyl slots and free positions, every component is a path or a cycle. Then:

- a **cycle** (all metrics, length $\ge1$) contributes $\delta^a{}_a=n$ and deletes those metrics;
- a **path with both terminals on the same Weyl factor** (length $\ge0$) is a trace of $W$ on two of its own slots, hence $0$;
- a **path between different Weyl factors** collapses to a direct contraction, no $n$, no metric;
- a **path with a free terminal** collapses to a free Weyl slot, or, with two free terminals, to a single $g_{ij}$.

Induction on the metric count terminates in a **normal form in which every surviving bare metric has both indices free**, which is the statement the monomial theorem actually needs, since it forces $a_P\le\lfloor f/2\rfloor$ and confines metrics to pairing cycles. A2's version delivers neither the normal form nor that inequality.

### Verdict

**Claim 1 REFUTED as an exhaustive case analysis; the underlying assertion "the spanning set may be taken reduced with no loss" is TRUE and is re-established here with four cases and a normal-form step.** Reviewer 240 was right to leave it owed: two lines are not enough, and the shortfall is not a technicality, the uncovered configuration falsifies $L\le\min(a_P,a_Q)$ by an explicit Gram entry of degree $1$ against a predicted degree $0$.

*What A2 should say:* state the path/cycle decomposition for a single diagram first, with the reason (only $\delta$ composes, so Weyl slots are terminals), then run the four cases, then record the normal form "every bare metric has both indices free", which is the hypothesis [brauer-pairing.md](../findings/brauer-pairing.md) consumes.

# Review r172, Gate 2 on the crux localisation and the S=0 Ansatz

Cold review of claims 1–3 of [brief14](../plan.md), worked from the definitions with one second of arithmetic at $n=5$ and $n=6$. Verdicts first.

| claim | verdict |
| --- | --- |
| 1. The crux is the $\ge3$-negative stratum | **Half right.** The eigenvalue counting is sound; the set is stated wrongly and the two sets compared are incomparable |
| 2. The Ansatz is retired by the LP optimum $1.306498$ | **The reasoning is refuted.** The verdict survives, on evidence the record already holds and the retirement did not use |
| 3a. An ascent bounds from below | **Confirmed**, and the uncorrected sentence still stands ten lines below the correction, carrying 3c's sub-step-2 premise |
| 3b. $546\times$ larger, not $2809\times$ smaller | **Confirmed exactly**, and honestly scoped |
| 3c. The orbit forces $45.9\%$ into $\ker G$ | **Confirmed**, derivation sound |
| (b) 3c's grade | **The record gives two grades.** The rubric table says $6$, the section header says $9$. $6$ is the defensible one |

---

## Claim 2, the retirement is a category error, and the Ansatz dies to something else

### The LP cannot refute the Ansatz, in either of its readings

[bounds.md](../findings/bounds.md)'s LP maximises $\theta$ over every nonnegative totally symmetric $T$ with row marginals $2(n-2)$, pair caps $\le2$, $S_{\mathfrak{mmm}}=0$ and $R\lambda=-2\lambda$. That is a **relaxation**: the set of Weyl spectra is *contained* in the LP-feasible set. So "the LP optimum reaches $1.306498$ at eight negative eigenvalues" carries exactly one implication, the relaxed feasible set is nonempty at $d=8$ and some relaxed point there scores $1.306$. Containment runs the wrong way to conclude anything about $\mathrm{Weyl}_n$ at $d=8$.

[plan.md](../plan.md) draws the conclusion anyway: *"at $d=8$ the region survives, and $8>3$."* The region that survives is the relaxation's. An upper bound that lands above a target fails to prove the target; it never disproves it.

### The Ansatz's own screen said this, and the retirement reversed it without an argument

The proposal at `64ae388` screened itself against precisely this number:

> *not the LP bound at [bounds.md](../findings/bounds.md) line 199, which reaches $1.306$ and is a **different quantity***

`319ec0a` then retired the Ansatz on that quantity, without saying why the screen was wrong. The screen was right.

### The record flags the number by name

[findings/INDEX.md](../findings/INDEX.md) line 86: *"**Recurring numbers that are not a $\theta$**, listed because they have been mistaken for one: $0.5748$ the tube radius; $1.206011$ …; $1.7227$, $1.5305$, $1.413614$, **$1.306498$** linear-programming optima."*

The index carries a standing warning against this exact number, placed there because it had already been mistaken for a $\theta$, and the retirement mistook it for one. [bounds.md](../findings/bounds.md) itself scopes the number correctly one sentence later, *"So no LP argument on this constraint set proves item B's bound, which is the fence post's operational content"*, a statement about what a **method** can prove. [plan.md](../plan.md) promoted it to a statement about what is **true**.

### And the number is unsourced

$1.306498$ occurs once in the whole repository, at [bounds.md:199](../findings/bounds.md), with no dimension $n$, no spectrum, and no script. Nothing in [scripts/](../scripts/) produces it. A retirement rests on it.

### The Ansatz is dead anyway, killed by exact Weyl tensors, in one second

The Ansatz asks for the least $k$ such that $S=0$ removes every spectrum with $\ge k$ negative eigenvalues. No such $k$ exists, at any dimension. Built from [run_sphere.py](../scripts/run_sphere.py)'s closed form and [weyl.py](../scripts/weyl.py)'s structure constants:

| point | $n$ | $N$ | $d$ = negatives | $S_{\mathfrak{mmm}}$ | row marginal | $\lVert R\lambda+2\lambda\rVert_\infty$ | criticality residual | $\theta$ |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| $S^2\times S^3$ | 5 | 10 | **6** | $0.000$ | $6.000000$ | $5.6\times10^{-17}$ | $1.1\times10^{-16}$ | $0.942809042$ |
| $S^3\times S^3$ | 6 | 15 | **9** | $0.000$ | $8.000000$ | $1.1\times10^{-16}$ | $1.7\times10^{-16}$ | $1.054092553$ |

These are genuine Weyl tensors, exactly critical, satisfying **every constraint the retiring LP imposes** (marginals, pair caps, $S=0$, and the vector identity), with $6$ and $9$ negative eigenvalues. The second saturates [Lemma L36](../response.md) exactly: $9=\lfloor6^2/4\rfloor$. Since Lemma L36's cap $\lfloor n^2/4\rfloor$ is **attained**, $S=0$ removes nothing at the top of its own range, and the threshold the Ansatz hunts is provably absent rather than merely unlocated.

### Both halves of the Ansatz were empty

The "inert where Lemma L35 works" half is not merely inert, it is **vacuous**. On the $\le2$-negative stratum there is no triple of negative indices at all, so $S_{\mathfrak{mmm}}=0$ is an empty sum. Lemma L35 also carries no $S=0$ hypothesis. So the claimed complementarity was a tautology on one side and, on the other, a statement the record's own equality case refutes.

### And the counterexample sits fifteen lines below in the same file

[plan.md](../plan.md) item 3c cites *"$S^2\times S^3$, an exact critical point at $\theta=2\sqrt2/3$, residual $2.0\times10^{-16}$"*. The Ansatz was proposed and retired in item 3, immediately above.

**Verdict.** Retire the Ansatz, keep the conclusion, and replace the ground. The recorded reason (an LP optimum), is not a refutation of anything and reuses a number the index warns is not a $\theta$. The real reason is Lemma L36's equality case, an exact Weyl tensor, and it is one grep away.

---

## Claim 1, the counting is right, the set is not

### $\dim\mathfrak m$ is the negative-eigenvalue count, with multiplicity

The brief's worry is unfounded. [Lemma L36](../response.md) defines $\mathfrak m$ as *"the negative eigenspace of a Weyl operator with $S=0$"*, so $\dim\mathfrak m$ counts negative eigenvalues with multiplicity; [Lemma L35](../response.md)'s chain carries exactly two negative magnitudes $b,c$ through the $(+\!-\!-)$ transport, so its hypothesis is the same count. The $n=6$ computation above closes the loop: $d=9$ against Lemma L36's $\lfloor n^2/4\rfloor=9$. **Confirmed.**

### The two sets compared are incomparable

`848c7e5` replaced the header *"THE I1, correctly stated, $\sup\{\theta:Q(W)=\theta W,\ S=0,\ \text{non-diagonal}\}\le\sqrt{3/2}$"* with *"the open region is now exactly the $\ge3$-negative stratum"*, dropping both $S=0$ and non-diagonality, and asserting *"the crux is localised, and it is smaller than 'non-diagonal'."*

- $\{d\ge3\}\not\subset\{\text{non-diagonal}\}$: $S^3\times S^3$ at $n=6$ is diagonal in the coordinate pair basis and has $d=9$.
- $\{\text{non-diagonal}\}\not\subset\{d\ge3\}$: padded $W_{\mathbb{CP}^2}$ is the canonical non-diagonal point and has $d=2$.

Neither contains the other, so "smaller" is false. The open region is the **intersection** $\{\text{critical}\}\cap\{S=0\}\cap\{\text{non-diagonal}\}\cap\{d\ge3\}$, which is a genuine narrowing of the target, and it is what the header should say. [findings/INDEX.md](../findings/INDEX.md) still carries the target in its correct three-hypothesis form, so [plan.md](../plan.md) and the index now disagree on the definition of the live target. The index also says, in the same table, *"The load-bearing hypothesis is diagonality, not $S$"*, which is the sentence the new header drops.

### How much the localisation actually removes

By [Lemma L30](../response.md) a small negative eigenspace forces a small support, so the $d\le2$ part of the target set is essentially the padded $W_{\mathbb{CP}^2}$ family, the known attainment point, whose orbit and a tube of radius $0.5748$ around it are already excluded unconditionally by Lemma L20 for $n\ge12$. So the slice Lemma L35 removes from the target overlaps heavily with what the record already had. The localisation is real but thin, and the framing oversells it.

### The $2.07$ factor checks out, and its home is $n=5$

$8/\sqrt{90}=0.8432740$ against $\sqrt{3/2}/3=0.4082483$, ratio $2.0657$. **Confirmed.** Two things worth adding:

- **On $d\le2$ at $n=5$ the spectral relaxation is exactly tight, and Lemma L35 there is two lines.** By Lovelock $\theta=3p_3$ at $n=5$. Maximise $p_3$ over traceless unit spectra with at most two negative entries: $\sum a^3\le(\max a)\sum a^2$ makes concentration on a single positive optimal, leaving $\lambda=(a,-b,-c,0^7)$ with $a=b+c$, whose maximum is at $b=c$ and equals $0.40824829=\sqrt{3/2}/3$, attained precisely at $(2,-1,-1,0^7)/\sqrt6$. So the overshoot genuinely lives in $d\ge3$, as claimed.
- **The Okumura extremiser is not a Weyl spectrum.** $\lambda=(9,-1^9)/\sqrt{90}$ fails $R\lambda=-2\lambda$ outright: row $1$ needs $-2\lambda_1=-1.897366$, while a nonnegative row with sum $2(n-2)=6$ against entries all equal to $-1/\sqrt{90}$ can only deliver $-0.632456$. So the factor $2.07$ is an upper bound on the overshoot that the linear realisability filter already cuts.

---

## Claim 3, the three folded corrections, verified independently

### (i) Direction of an ascent, confirmed, and the error survives elsewhere

An ascent returns a point; its value bounds the maximum from **below**. [plan.md:283](../plan.md) states the correction. [plan.md:293](../plan.md), ten lines later, still reads: *"The nonnegativity itself comes from the ascent, which bounds the maximum from above; the screen cannot."*

This matters beyond bookkeeping, because that sentence is the only support offered for $F_5\ge0$ on $\mathrm{Weyl}_5$, and 3c's header claims *"SUB-STEP 2 IS SPECIFIED, and its target is **verified sharp** before any solver runs."* Nothing verifies it. Lemma L35 covers only $d\le2$, and $\mathrm{Weyl}_5$ contains $d=6$ critical points, the same $S^2\times S^3$ that all $300$ ascents missed. If $\sup\theta$ at $n=5$ exceeded $\sqrt{3/2}$, $F_5$ would be negative somewhere and no SOS certificate could exist, so this is 3c's feasibility premise and it is conjectural.

### (ii) The size comparison, confirmed exactly

$\dim\mathrm{Weyl}_{12}=\frac{12\cdot13\cdot14\cdot9}{12}=1638$, so $\dim\mathrm{Sym}^3=\binom{1640}3=733\,813\,080$ and $733\,813\,080/1\,343\,980=546.0$ **exactly**. The figure it replaces, $2809$, is $1\,343\,980/477\approx2818$, 3c's *reduced* unknown count against the earlier attempt's *unreduced* Gram, which is the unit mismatch the correction names. The correction is also honestly scoped: [plan.md](../plan.md) concedes in the next sentence that the reduction is exactly what the earlier attempt lacked, so $546\times$ is a fact about raw problems rather than a verdict on 3c.

### (iii) The orbit obstruction, confirmed, derivation sound

$F$ is a degree-six form, so $F(W)=v(W)^{\mathsf T}Gv(W)$ with $v(W)\in\mathrm{Sym}^3(\mathrm{Weyl}_5)$. If $G\succeq0$ and $F(W_0)=0$ then $Gv(W_0)=0$, hence $G$ annihilates the whole orbit-evaluation span. With that span measured at $3570$ inside $\dim\mathrm{Sym}^3=\binom{37}3=7770$: $3570/7770=45.946\%$ and $\operatorname{rank}G\le4200$. **Both figures reproduce.** The trivial block is forced to zero because the trivial multiplicity at $n=5$ is $1$ and $\operatorname{tr}(W_0^3)=1/\sqrt6\ne0$. Sound.

*One gap in the summary.* "$24$ blocks, multiplicities $1\ldots4$ summing to $41$, $65$ scalar unknowns" does not determine the multiplicity profile, three profiles satisfy all three aggregates: $(14,3,7,0)$, $(13,6,4,1)$ and $(12,9,1,2)$ counts of multiplicity $1,2,3,4$. Since [plan.md](../plan.md) calls the profile *"the object that matters"*, the profile itself belongs on the record, not its three aggregates.

---

## (a) Asserted as new, already on the record

The Ansatz's screen sentence at `64ae388` (*"The record states the bite and never locates its threshold"*), is false. [findings/INDEX.md](../findings/INDEX.md) locates it at the maximum, in the index: *"The $S=0$ class contains the balanced sphere products, running up to $\sqrt2$; only diagonality keeps them out of the target."* [Lemma L36](../response.md) supplies the cap $\lfloor n^2/4\rfloor$ **with its equality case**, which is what "the threshold" means. The answer was in the one file the index says a cycle must read whole.

## (b) 3c's grade

The record gives two, and they disagree.

| location | grade |
| --- | --- |
| the rubric table at [plan.md:83](../plan.md) | $3\times2\times1=\mathbf6$, `attackable` $=2$, *"sub-step 1 done, but the $n\ge12$ projection is unpriced"* |
| the 3c section header at [plan.md:249](../plan.md) | $3\times3\times1=\mathbf9$ |

**$6$ is the defensible figure**, and the header's upgrade to $9$ is unexplained. If anything $2$ is generous: [plan.md](../plan.md)'s own 3c section says *"the explicit isotypic projections do not [come free], and neither Sage's symmetric functions nor cvxpy supplies them"*, so the projections are missing at $n=5$, not only at $n\ge12$, and that is the step between *"the SDP is small"* and *"the SDP is posed"*. The `closes` $=3$ additionally assumes an SOS certificate exists; nothing on the record argues that $F$ is a sum of squares rather than merely nonnegative, and by (i) above even its nonnegativity at $n=5$ is unproved.

## (c) Why proposals keep dying to the record, and the cheap fix

**Size is not the mechanism.** The core record is about $239\,000$ words and [reviews/](.) another $229\,000$, but the material that killed this session's proposals was not buried, it was in [findings/INDEX.md](../findings/INDEX.md), the shortest file, the one the index says to read whole, and in one case fifteen lines away in the same section.

**The mechanism is that the index is a novelty filter and the failures are provenance failures.** [findings/INDEX.md](../findings/INDEX.md)'s rule 3 reads *"**Before claiming anything is new**, check the value table below"*, one direction only. The deaths run the other way. Both the Ansatz and its retirement re-used recorded material as **evidence** without checking what quantity it was:

| step | material re-used | what it actually is |
| --- | --- | --- |
| the proposal | *"removes them from the feasible set entirely"* | a statement about the marginals-only **LP** feasible set |
| the retirement | $1.306498$ | an **LP optimum**, listed by name in the index's "not a $\theta$" paragraph |

Every number in this record carries an implicit type ($\theta$ at a Weyl point, a bound's value, a relaxation optimum, a structural parameter) and that type currently lives in the prose beside the number rather than attached to it. A reader scanning for a number to lean on picks up the digits and drops the type. The index anticipated this well enough to write the warning paragraph; it did not attach the warning to the table where a grep lands.

**Three changes, none of them mathematics.**

1. **Make rule 3 bidirectional.** *"Check the value table before claiming a number is new **and before using one as evidence**."* One clause.
2. **Give the value table a `kind` column** ($\theta$ at a Weyl point / bound / relaxation optimum / structural parameter) and fold the "Recurring numbers that are not a $\theta$" paragraph into it as rows with `kind = relaxation optimum`. The data already exists; it is prose where it should be rows, so a grep for $1.306498$ lands on the number and not on its warning.
3. **Add a standing-witness check to the proposal screen.** A hypothesis-shaped proposal, *"does hypothesis $H$ force structural bound $B$?"*, gets instantiated at three named points before it is ranked: padded $W_{\mathbb{CP}^2}$ ($d=2$, non-diagonal, $S=0$), $S^{n/2}\times S^{n/2}$ ($d=n^2/4$, diagonal, $S=0$, graded), and $S^2\times S^3$ at $n=5$ ($d=6$, $S=0$, $\theta=2\sqrt2/3$). That is the table at the top of claim 2; it took one second to compute and it kills this Ansatz before it is written, and its retirement before that is written.

**The prediction the record's own framing invites.** [plan.md](../plan.md) records the retirement as *"the first time the correction was found before any cycle was spent on it, which is the only difference that matters."* The correction found that way was itself of the wrong kind. Speed of screening is not the variable; what is screened against is.

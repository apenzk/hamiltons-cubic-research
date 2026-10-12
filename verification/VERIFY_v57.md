# Verifier v57, Lemma L61, $M(5)=\sqrt{3/2}$ and its sum-of-squares certificate

*Verifier v57 of the three on [ROUND_L61](ROUND_L61.md), phase 1. The brief was cold and every derivation below was built from [findings/conventions.md](../findings/conventions.md) rather than from any prior verdict. **No numerical work was done and every value in this report is exact**: the constants were derived by hand from the $\Lambda^2$ spectrum, the parameter counts by hand from the recorded shape, the representation dimensions by hand from Weyl's formula for $B_2$. No script was executed. One `python3` invocation was used solely as a JSON key-lister on [n5_rows_1099511627873.json](../scripts/runs/n5_rows_1099511627873.json), to learn that the file holds `rows`, `rhs`, `blocks`, `shape`; it performed no arithmetic and evaluated no mathematical object. Log: [agent_logs/verify-L61-v57.log](../agent_logs/verify-L61-v57.log).*

*Independence, declared. [findings/sym3-blocks.md](../findings/sym3-blocks.md) was not opened. Three of its lines (42, 78 and 283, all on the Lovelock collapse), surfaced inside a repository-wide grep before I could exclude the file; they carry no audit verdict and are cited below where they bear on step 1. Prior reviews were likewise not opened, though grep returned single lines from [REVIEW_r597](../reviews/REVIEW_r597.md), [REVIEW_r598](../reviews/REVIEW_r598.md), [REVIEW_r684](../reviews/REVIEW_r684.md) and [REVIEW_r690](../reviews/REVIEW_r690.md). Nothing below rests on any of them; where a conclusion of mine coincides with one of those lines I say so.*

## The claim table

| # | claim attacked | verdict | reason, in a clause |
|---|---|---|---|
| 1 | Step 1: $(\mathrm{Sym}^3\mathcal W_5)^{O(5)}$ is one-dimensional | **SUPPORTED, MIS-CITED** | a real proof exists (the $\delta^{[6]}$ pigeonhole at $n\le5$) and the canonical entry cites [L50](../results.md) instead, which does not supply the constant |
| 2 | Step 2: the anchor pins $c=2$ | **CONFIRMED** | $\operatorname{tr}(W_0^3)=1/\sqrt6$ and $P(W_0)=3/\sqrt6$ both follow from the conventions file; $c=2$ exactly, and the padded anchor's kernel is harmless |
| 3 | Step 3: $P(W)=3\operatorname{tr}(W^3)$ on $\mathcal W_5$ | **CONFIRMED** | $\langle W,W^2\rangle=\operatorname{tr}(W^3)$ under this record's operator pairing, then step 2 |
| 4 | Step 4: $F_5\ge0\iff\theta\le\sqrt{3/2}$ | **CONFIRMED, SCOPE WIDER** | $F_5\ge0$ is the two-sided $\lvert\theta\rvert\le\sqrt{3/2}$; homogeneity carries it off the unit sphere; $W=0$ is outside $\theta$'s domain |
| 5 | Step 5: positive-definiteness of the 16 blocks | **CONFIRMED, EXACT** | the sign-alternation test is a correct criterion for a Hermitian matrix, run over $\mathbb Q$ with no elimination, on both the packed and the halved form |
| 6 | Step 6: the Gram's sextic *is* $F_5$ | **GAP** | the injectivity that turns 40 equations into an identity is a **float64 SVD rank at threshold `1e-10`**, and the record owns an exact instrument it did not use |
| 7 | "with equality exactly on that orbit" | **HYPOTHESIS-DEBT** | an SOS gives $Z(F_5)\supseteq$ the orbit cone; the reverse inclusion needs the degree-3 part of the orbit ideal to cut the cone out, which is on file nowhere |
| 8 | Forms A–D state the same thing | **BROKEN** | [results.md:23](../results.md) says the equality case is unproven while [results.md:204](../results.md), [results.md:625](../results.md) and [sym3-blocks.md:326](../findings/sym3-blocks.md) assert it; and the caveat that exists names the wrong two links |
| 9 | "an exact rational certificate" ([results.md:40](../results.md)) | **OVERSTATED** | the coefficients are exact rationals; the proof that they represent $F_5$ is not, and the same pipeline records float64 failing at $W_0$ |

## One-line summary

**The positive-definiteness half of L61 is exact and stands; the identity half rests on a floating-point rank that the record's own mod-$p$ instrument could replace in one run, and the equality clause has no argument on file at all, so the lemma as written at [results.md:204](../results.md) claims two things its certificate does not deliver.**

## 0. Conventions, fixed once

Quoted from [findings/conventions.md](../findings/conventions.md), not restated.

- $\mathcal W_n$, "the space of algebraic Weyl curvature operators on $\mathbb R^n$", with $\dim\mathcal W_n=\frac{n(n-3)(n+1)(n+2)}{12}$. At $n=5$ that is $\frac{5\cdot2\cdot6\cdot7}{12}=35$.
- $Q(W)$, "Hamilton's quadratic map $W^2+W^\#$, sending $\mathcal W_n$ to itself".
- $P(W)$, "the cubic form $\langle W,Q(W)\rangle$".
- $\theta$, "$P(W)/\lVert W\rVert^3$".
- $M(n)$, "**the global maximum** of $P$ on the unit sphere of $\mathcal W_n$, $M(n)=\max\{P(A):\lVert A\rVert=1\}$ … padded $W_{\mathbb{CP}^2}$ giving $M(n)\ge\sqrt{3/2}$". Distinct from $\Theta_n$, "the *diagonal* maximum".
- $\Theta_n$, at odd $n$, $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$; at $n=5$ that is $\sqrt{16/18}=2\sqrt2/3$.
- $W_0$, $H$, "the $n=5$ base point of the $\mathrm{Sym}^3$ machinery and its stabiliser $H\subset O(5)$, the orbit $O(5)\cdot W_0$ being the zero set a certificate must vanish on. … *Cubics are odd, so vanishing on $O(5)\cdot W_0$ forces vanishing on the orbit of $-W_0$ automatically.*"
- The operator pairing, "$W$ is the operator on $\Lambda^2$, where $\sum_\alpha\lambda_\alpha^2=\operatorname{tr}(W^2)=1$", and "**The $\tfrac12$ goes at the $\Lambda^2$ level, not the operator level.**"
- Padding, "**Padding commutes with $Q$**, and preserves both the norm and $\theta$."
- Structure constants, "$c_{abc}=\langle[v_a,v_b],v_c\rangle$ are **totally antisymmetric**", which is what makes $W^\#$ an $O(n)$-equivariant quadratic map and hence $\langle W,W^\#\rangle$ an invariant cubic.

Two consequences I will use and which the conventions file does not state.

- **The operator inner product carries no $\tfrac12$.** The file pins $\langle W,W\rangle=\operatorname{tr}(W^2)$, so $\langle W,W^2\rangle=\operatorname{tr}(W^3)$ with no factor. The half-trace lives one level down, on bivectors.
- **At $n=5$, $O(5)$-invariance and $SO(5)$-invariance coincide on $\mathcal W_5$.** $O(5)=SO(5)\times\{\pm\mathrm{Id}\}$ and $-\mathrm{Id}$ acts trivially on $\Lambda^2\mathbb R^5$, hence trivially on $\mathcal W_5$. So the $O$ in "$O(5)$-orbit", "$(\mathrm{Sym}^3\mathcal W_5)^{O(5)}$" and "$(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$" adds nothing at this $n$, and $O(5)\cdot W_0=SO(5)\cdot W_0$. This is a place a reader could expect content and find none; it is worth one line in the block.

## 1. The hypothesis inventory

### 1.1 Hypotheses the statement itself carries

| # | hypothesis | where stated | checked against | used? |
|---|---|---|---|---|
| H1 | $W\in\mathcal W_5$: symmetric on $\Lambda^2\mathbb R^5$, first Bianchi, Ricci-flat | all four forms | the object is the whole of $\mathcal W_5$ | **used, and indispensable**, see §1.4 |
| H2 | $n=5$ exactly | all four forms | $\mathcal W_5$ | **used three times**, the cubic collapse, $\dim=14$, the 16-block shape |
| H3 | the norm is $\operatorname{tr}(W^2)^{1/2}$ on $\Lambda^2$ | conventions, not restated in the forms | $F_5$'s coefficients $\tfrac32$ and $9$ | **used**; the constants are normalisation-specific |
| H4 | "critical or not" | Form B only | scope widening, not a hypothesis | correctly widens |
| H5 | "with exact rational coefficients" | Forms B, D | a property of the artefact | **stated, and misleading**, §9 |

### 1.2 Hypotheses of the imported theorems

| # | imported | its hypothesis | met? | where the argument uses it |
|---|---|---|---|---|
| T1 | the cubic collapse $\langle W,W^\#\rangle=2\operatorname{tr}(W^3)$ | $n\le5$ (the generalised Kronecker $\delta^{[6]}$ vanishes by pigeonhole) | ✔ at $n=5$ | steps 1–3 |
| T2 | $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$ | none stated; three machine routes | machine only | step 6's cap |
| T3 | Weyl's first fundamental theorem for $O(n)$ | none binding | ✔ | step 6, to know the 120 contractions are invariant sextics |
| T4 | a Hermitian PSD Gram of a **real** form is a real sum of squares | $F_5$ real, the basis real | ✔ | step 5 → the word "squares" in the statement |
| T5 | a Hermitian matrix is positive definite iff its characteristic polynomial's coefficients alternate | the spectrum is real | ✔, and asserted at runtime | step 5 |
| T6 | $M\succ0\Rightarrow\tfrac12(M+\operatorname{diag}M)\succ0$ | $M$ Hermitian | ✔ | step 5's second pass |

**T5 checked from scratch.** For $p(x)=x^k+c_1x^{k-1}+\dots+c_k$ with all roots real, $c_m=(-1)^me_m(\lambda)$, so "all $(-1)^mc_m>0$" is "all $e_m(\lambda)>0$". If every root is positive every $e_m>0$; conversely $e_m>0$ for all $m$ makes $p(-x)$ positive for $x\ge0$, so $p$ has no root in $(-\infty,0]$, and reality of the spectrum then forces every root positive. The criterion is correct, and it needs Hermiticity for exactly one thing (reality of the roots) which [run_n5_verify.py](../scripts/runs/run_n5_verify.py) both enforces by construction in `blocks()` and re-checks by asserting each Faddeev–LeVerrier trace is real. **T6 checked**: $\tfrac12(M+D)$ with $D=\operatorname{diag}M$; $M\succ0$ forces $D_{ii}=e_i^*Me_i>0$, so $D\succ0$ and the average of two positive-definite forms is positive definite. Both are sound.

### 1.3 Hypotheses used and nowhere stated

| # | silently used | who needs it |
|---|---|---|
| U1 | evaluation at the certificate's 40 points is injective on $(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$ | **step 6, the whole identity**, present in the verify script's prose, absent from Forms A, B and D |
| U2 | the cubics the Gram is written in genuinely vanish on $O(5)\cdot W_0$ ("membership by construction") | the phrase "cubics vanishing on the $O(5)$-orbit" in every form |
| U3 | the Hermitian-to-real bridge T4 | the word "squares" |
| U4 | the degree-3 part of $I(O(5)\cdot W_0)$ cuts out the orbit cone set-theoretically | **the equality clause alone**, §7 |
| U5 | $\operatorname{tr}(W^3)\not\equiv0$ on $\mathcal W_5$ | step 2, so that one anchor pins $c$ |

### 1.4 Hypotheses stated and unused, and the one that looks decorative and is not

**H1 is the load-bearing hypothesis and no form says why.** $F_5\ge0$ is *false* on the ambient space of trace-free symmetric operators on $\Lambda^2\mathbb R^5$. For such an operator with spectrum $\mu$ and $\sum\mu^2=1$ the maximum of $\sum\mu^3$ is $(N-2)/\sqrt{N(N-1)}$ at $N=\dim\Lambda^2\mathbb R^5=10$, i.e. $8/\sqrt{90}=0.8433$, against the claimed ceiling $1/\sqrt6=0.4082$. Restricting to rank $\le r$ the ceiling is $(r-2)/\sqrt{r(r-1)}$, which already exceeds $1/\sqrt6$ at $r=4$ ($2/\sqrt{12}=0.5774$), and equals $1/\sqrt6$ exactly at $r=3$. **So $W_0$, of $\Lambda^2$-rank three, is the unconstrained champion of its own rank stratum, and the entire content of L61 is that the Weyl conditions forbid every rank-$\ge4$ spectrum from doing better.** That is worth saying in the block, because it tells a reader what the certificate is actually buying.

**Nothing in the inventory is stated and unused**, with the single exception of H5, which is stated as though it were a hypothesis discharging the proof's rigour and is not (§9).

## 2. Quantifier order and scope

**Nothing is distributed.** The claim is $\forall W\in\mathcal W_5:F_5(W)\ge0$, and the certificate route proves the stronger quantifier-free statement $F_5=\sum_aq_a^2$ as an identity of polynomials; no supremum is taken over a variable shared with another term. The one $\max$ in sight is $M(5)$, which needs $\le$ from the certificate and attainment from the padded competitor, and both are present, attainment via "padding commutes with $Q$" from the conventions file.

The one place a quantifier could invert is step 6, and it does not: "agreement at 40 points" is a statement about the pair $(G,F_5)$, while injectivity is a statement quantified over the whole 14-dimensional space, and the record quantifies it that way. The defect at step 6 is evidential, not logical (§6).

## 3. The edge of every range, $\ker W\ne0$

**The extremal object is the maximally degenerate one.** $W_0$ padded into $\mathcal W_5$ acts on $\Lambda^2\mathbb R^5$ with spectrum $(2a,-a,-a,0,0,0,0,0,0,0)$, so $\dim\ker W_0=7$ of $10$. Every step must therefore survive at a rank-3 operator.

- Steps 1–4 are polynomial identities; a kernel is invisible to them. ✔
- Step 5 is a statement about a fixed $47$-parameter matrix; no $W$ enters. ✔
- Step 6's 40 sample points are drawn as integer combinations of a basis of $\mathcal W_5$ ([run_n5_assemble.py:894-901](../scripts/runs/run_n5_assemble.py)) and are therefore generic, trivial kernel almost surely. **This is harmless here**, because what the samples are asked to do is pin a polynomial identity, and once injectivity holds the identity is global, degenerate points included. A screen that only ever looked at nondegenerate objects would be the trap; this is not one.

**But the record itself says float64 breaks at $W_0$.** [run_n5_lift.py](../scripts/runs/run_n5_lift.py)'s docstring: *"Float64 cannot compute these rows: run_n5_psd.py records the measurement, the per-weight solve runs at condition number 2.9e14 and the restriction comes out doing NOTHING at $W_0$, where it must be exactly zero."* The pipeline diagnosed float64 failing precisely at the degenerate point, moved the row computation to mod-$p$ arithmetic in response, and then left the injectivity step, which is the one that converts a finite check into a theorem, in float64 (§6). The two stages are different, so this is not a contradiction; it is the reason the phrase "exact rational certificate" cannot stand unqualified.

## 4. What is proven on a subfamily and cited in general

One thing, and it is the central one.

**The identity "the Gram's sextic is $F_5$" is verified on a 40-point subfamily and cited as a global identity.** The bridge is U1. The verify script's own out-of-sample confirmations (reviewer 213 at 80 points with 40 held out, reviewer 214 at 12 fresh points), are *more* subfamily, not the bridge: they raise confidence that the solve was performed correctly and say nothing about whether finite agreement forces identity. The bridge is U1 and only U1.

Two further machine-only inputs cited in general: $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$ (three routes, all machine) and the block shape itself.

## 5. Steps 1 to 5, checked

### 5.1 Step 1, is one-dimensionality argued, or asserted?

**Neither of the two answers the round expects. It is argued, but not where the canonical entry points, and the canonical entry's actual citation does not support what it states.**

The canonical detail entry, [results.md:625](../results.md), reads:

> Since $\langle W,W^\#\rangle=2\operatorname{tr}(W^3)$ on $\mathcal W_5$ (the cubic collapses to one spectrum, Lemma L50) …

[Lemma L50](../results.md)'s detail entry at [results.md:723](../results.md) states $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$ with the two normalisations and the index-order warning, **and contains no collapse clause at all**; the clause "*Collapses to one spectrum exactly for $n\le5$*" lives only in L50's one-line glance at [results.md:244](../results.md). Even taken there, it delivers "$\theta$ is *a* multiple of $\operatorname{tr}(W^3)$" and not the multiple. **L61's parenthetical cites a lemma that does not carry the constant the sentence asserts.**

The real argument is elsewhere and is a genuine proof: the generalised Kronecker delta $\delta^{[6]}$ antisymmetrises over six indices and so vanishes identically at $n\le5$ by pigeonhole, which is a one-sentence theorem, and the difference of the two cubic contractions is a $\delta^{[6]}$-contraction. That is the Lovelock syzygy, recorded at [findings/sym3-blocks.md:78](../findings/sym3-blocks.md), with the same file at [:42](../findings/sym3-blocks.md) drawing the trivial-multiplicity conclusion and at [:283](../findings/sym3-blocks.md) noting the dimension is $1$ here against $2$ from $n\ge6$. Independently, [run_cubic_invariant_dimension.py](../scripts/runs/run_cubic_invariant_dimension.py) records three routes to the same fact, of which route **(B)** is an *exact integer* polarisation certificate showing $s-2t\equiv0$ at $n=4,5$ and rank $2$ at $n=6$, with $s(W)=W_{ijkl}W_{klpq}W_{pqij}$ and $t(W)=W_{ipkq}W_{jplq}W_{ijkl}$. Route (C), Newell–Littlewood $N_{(2,2),(2,2),(2,2)}=2$, is a **stable-range** count and does not reach $n=5$; the script says so.

Three observations follow.

- **The route the round's brief reconstructs (one-dimensionality plus a single anchor), is strictly weaker than the route the record actually has.** The syzygy delivers the identity *with its constant*, derived. The dimension-plus-anchor route delivers the identity with a constant *measured at one point*. Both reach the same place here, and the second is the one the canonical entry gestures at.
- **One-dimensionality is more than the argument needs.** All L61 consumes is the single identity $\langle W,W^\#\rangle=2\operatorname{tr}(W^3)$. Spanning is not required, which matters because [sym3-blocks.md:78](../findings/sym3-blocks.md) itself records that the *"so"* between the collapse and the dimension count "owes the step that $\alpha,\beta$ **span** the cubic invariants". That debt does not touch L61.
- **The exactness of route (B) is real and is the strongest thing on the record here.** It is integer arithmetic on an integer basis, not a rank read off a tolerance.

**Verdict on step 1: SUPPORTED, MIS-CITED.** The fact holds and has a proof; the canonical entry cites a lemma that does not carry it.

### 5.2 Step 2, does one point pin the constant, and do the two values match the conventions?

**Both quoted values are exactly right, and I rebuilt them from the conventions file alone.**

$W_{\mathbb{CP}^2}$ is self-dual Einstein: $W_-=0$, and $W_+$ on $\Lambda^2_+$ has eigenvalues proportional to $(2,-1,-1)$, the $+2$ eigenvector being the Kähler form and the sign fixed by $\operatorname{scal}>0$. So on $\Lambda^2\mathbb R^4$ the spectrum is $(2a,-a,-a,0,0,0)$. The conventions file pins $\operatorname{tr}(W^2)=\lVert W\rVert^2$, so

$$6a^2=1,\qquad a=\tfrac1{\sqrt6},\qquad \operatorname{tr}(W^3)=8a^3-a^3-a^3=6a^3=\tfrac{6}{6\sqrt6}=\tfrac1{\sqrt6}. \qquad\checkmark$$

$\theta(W_0)=\sqrt{3/2}=3/\sqrt6$ is proved independently of this chain: [lean/INDEX.md](../lean/INDEX.md) records `θ² = 3/2` at the competitor at $n=4$ machine-checked **from $Q$**, with $W_{\mathbb{CP}^2}$ first verified to lie in $\mathcal W_4$. Padding carries both to $n=5$, the conventions file's "padding commutes with $Q$, and preserves both the norm and $\theta$", and $\operatorname{tr}(W^3)$ is padding-invariant outright. Hence

$$\langle W_0,W_0^\#\rangle=P(W_0)-\operatorname{tr}(W_0^3)=\tfrac3{\sqrt6}-\tfrac1{\sqrt6}=\tfrac2{\sqrt6}=2\operatorname{tr}(W_0^3),\qquad c=2. \qquad\checkmark$$

And $F_5(W_0)=\tfrac32-9\cdot\tfrac16=\tfrac32-\tfrac32=0$, so the certificate's target does vanish at the point it must. ✓

**Does one point suffice?** Yes, given step 1. A one-dimensional space of invariant cubics with $\operatorname{tr}(W^3)$ a nonzero member makes $\operatorname{tr}(W^3)$ a spanning vector, and $c$ is then determined by any point where $\operatorname{tr}(W^3)\ne0$, U5, which holds at $W_0$. **The padded anchor's kernel is harmless here**: the identity being pinned is linear in the coefficient, so nothing about the anchor's degeneracy propagates. This is the one place in the round where I expected the kernel to bite and it does not.

**Verdict on step 2: CONFIRMED.** The two quoted values are consistent with the conventions file's normalisations and with each other.

### 5.3 Step 3, $P(W)=3\operatorname{tr}(W^3)$

$P(W)=\langle W,W^2+W^\#\rangle=\langle W,W^2\rangle+\langle W,W^\#\rangle$. The first term is $\operatorname{tr}(W^3)$ because the operator pairing on $\Lambda^2$ carries no $\tfrac12$ (§0). With step 2, $P=3\operatorname{tr}(W^3)$. **CONFIRMED**, and this is the step where a reader who applied the $\tfrac12$ at the operator level instead of the $\Lambda^2$ level (the trap the conventions file flags), would arrive at a different constant and a different $F_5$.

### 5.4 Step 4, the equivalence, at every $W$

$F_5=\tfrac32\lVert W\rVert^6-9\operatorname{tr}(W^3)^2=\tfrac32\lVert W\rVert^6-P(W)^2$ by step 3.

- **At $\lVert W\rVert\ne1$:** $F_5$ is homogeneous of degree six and $P^2/\lVert W\rVert^6=\theta^2$, so $F_5\ge0\iff\theta^2\le\tfrac32$ at every nonzero $W$, with no restriction to the unit sphere. The forms' "on all of $\mathcal W_5$" is honest. ✔
- **At $W=0$:** $F_5(0)=0$ and $\theta$ is $0/0$. The claim "$\theta\le\sqrt{3/2}$ on all of $\mathcal W_5$" is literally a claim about $\mathcal W_5\setminus\{0\}$. Cosmetic, and worth a parenthesis nowhere.
- **The scope is wider than stated.** $F_5\ge0$ says $\lvert\theta\rvert\le\sqrt{3/2}$, a two-sided bound. Since $P$ is odd the lower half is the image of the upper under $W\mapsto-W$, so nothing new is asserted, but it is the reason the zero set of $F_5$ is *two* orbits and not one, which is the hinge of §7.

**Verdict: CONFIRMED, with the scope wider than the forms say.**

### 5.5 Step 5, exactly what the verify script checks, and what it does not

I read [run_n5_verify.py](../scripts/runs/run_n5_verify.py) line by line and [n5_certificate.json](../scripts/runs/n5_certificate.json) entry by entry.

**What it checks, exactly and over $\mathbb Q$:**

1. `sum(k*k for k in SHAPE) == len(pt)`, i.e. $47$ parameters against the shape $[3,3,2,1,2,1,2,1,2,2,1,1,1,1,1,1]$. I verified by hand: two $3$-blocks, five $2$-blocks, nine $1$-blocks, $9\cdot2+4\cdot5+1\cdot9=47$. ✔
2. Hermiticity, by construction in `blocks()` and re-asserted through the reality of every Faddeev–LeVerrier trace.
3. Positive definiteness of all 16 blocks **as packed**, by characteristic-polynomial sign alternation, in exact `Fraction` arithmetic, with no elimination anywhere.
4. Positive definiteness of the same blocks with off-diagonals halved ("the form the certificate actually represents"), asserted rather than inferred, though T6 makes the inference sound anyway.

**What it does not check, and this is the part the round needs named:**

- **It never evaluates the Gram's sextic.** It contains no map from the $47$ parameters to a polynomial and no row data; everything after the positive-definiteness pass is `print` statements. The file's own docstring promises verification "from the file alone", and what it verifies from the file alone is that an abstract $47$-parameter Hermitian matrix is positive definite. **Which cubics those parameters index is not in the file, and not in [n5_certificate.json](../scripts/runs/n5_certificate.json) either**, the JSON's `blocks` field is loaded and then never referenced.
- **It never checks U2**, that the cubics vanish on the orbit.
- **It never re-runs the 40 equations.** It reports that reviewers 213 and 214 did.
- **`charpoly` carries a dead inner function `mul`** whose body is an unreachable generator expression; only `cm` is used. Harmless, and worth deleting so a reader does not try to parse it.

**Three positive consistency checks I derived by hand from the recorded artefacts.**

- **The recorded shape reconciles $47$ with the record's $36$.** A $k\times k$ Hermitian block holds $k^2$ real parameters and a $k\times k$ real-symmetric one holds $k(k+1)/2$. On this shape the second count is $6+6+3\cdot5+1\cdot9=36$ and the antisymmetric remainder is $3+3+1\cdot5=11$, with $36+11=47$. **So [Lemma L59](../results.md)'s "$65=36+29$" and the certificate's $47$ are the same object counted twice**, and the apparent Hermitian-versus-real discrepancy dissolves arithmetically. (Grep surfaced one line of [REVIEW_r684](../reviews/REVIEW_r684.md) reaching the same conclusion by a different route; I derived the $36$ before seeing it, from the shape alone.)
- **The trivial block is correctly absent.** The JSON's `blocks` field lists sixteen $SO(5)$ labels, $(2,2),(4,2),(3,2),(2,0),(2,1),(3,0),(3,1),(4,0),(4,1),(4,3),(4,4),(5,2),(3,3),(5,1),(5,3),(6,3)$, and $(0,0)$ is not among them. It must not be: the trivial isotypic component of $\mathrm{Sym}^3\mathcal W_5$ is spanned by $\operatorname{tr}(W^3)$, which is $1/\sqrt6\ne0$ at $W_0$, so no invariant cubic vanishes on the orbit and the trivial multiplicity space contributes nothing to $K$. ✔
- **The blocks are genuinely complex.** Reading the packing order off `blocks()`, the imaginary slots are indices $\{2,4,7,11,13,16,20,25,30,35,39\}$, eleven of them, matching the count above. Of these, four are nonzero: block $0$ has purely imaginary $(0,1)$ and $(1,2)$ entries and block $2$ a purely imaginary off-diagonal. **So T4, the Hermitian-to-real bridge, is genuinely load-bearing and is stated in none of Forms A–D.**

**A fourth figure, which I record without being able to close it.** Using Weyl's dimension formula for $B_2$, $\dim V_{(a,b)}=(a-b+1)\cdot\frac{a+b+2}2\cdot\frac{2a+3}3\cdot(2b+1)$ (checked against $\dim V_{(2,2)}=35=\dim\mathcal W_5$), the certificate's sixteen blocks carry $\sum_\lambda m_\lambda\dim V_\lambda=4200$, against $\dim\mathrm{Sym}^3\mathcal W_5=\binom{37}3=7770$. The space of cubics vanishing on the orbit has codimension $\sum_\lambda m_\lambda\dim V_\lambda^H$, which is bounded by the number of blocks with $\dim V_\lambda^H=1$ and is therefore of order tens, not thousands. **So the certificate is supported on roughly half of $K$, not on all of it.** That is entirely legitimate for the inequality (an SOS need only use cubics *from* $K$, not all of them) and I raise it only because §7 needs the opposite. Closing the figure needs the $\mathrm{Sym}^3\mathcal W_5$ block table, which lives in the file this brief excludes.

**Verdict on step 5: CONFIRMED, EXACT**, for what it covers, which is positive-definiteness and nothing else.

## 6. Step 6, the injectivity, and what kind of object the evidence is

**This is the finding of the round.**

### The argument, restated so its shape is visible

Let $V=(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$, $\dim V=14$. The Gram's sextic $G$ and $F_5$ both lie in $V$; they agree at the certificate's 40 solve points; if $\mathrm{ev}_{40}\colon V\to\mathbb R^{40}$ is injective then $G=F_5$ outright. Injectivity is argued by building 120 explicit invariant sextics as complete contractions of six copies of $W$, evaluating them at the 40 points, and reading rank $14$ against the cap of $14$: rank $14$ forces $\dim\mathrm{ev}_{40}(V)\ge14=\dim V$, hence injectivity.

**The logic is correct and I have no complaint with it.** Note in particular that the 120 sextics are *not* required to span $V$ (the rank alone does the work) and that the conclusion needed is a **lower** bound on a rank, which is the direction evidence can safely establish. [run_n5_verify.py](../scripts/runs/run_n5_verify.py) is right that this replaces the earlier circular comparison of $\mathrm{rank}(\mathrm{ev}\circ\mu)$ with $\mathrm{rank}(\mu)$, and right that it needs no statement about $\mu$.

### What the evidence actually is

[scripts/reviewers/r213/c4_ev_injective.py](../scripts/reviewers/r213/c4_ev_injective.py) builds the 40 sample tensors in exact `Fraction` arithmetic (integer coefficients drawn from $[-4,4]$ against a rational basis of $\mathcal W_5$) and then throws the exactness away:

```
TSn = [t/s for t, s in zip(TS, sc)]      # float64 from here on
...
M = np.array(COLS).T                     # 40 x 120
sv = np.linalg.svd(M, compute_uv=False)
rk = int((sv > sv[0]*1e-10).sum())
```

**The rank is a float64 SVD read at a relative threshold of `1e-10`.** Everything upstream of the `float(...)` cast is exact and rational, and nothing downstream is.

### Three-step discrepancy record

**1. Located.** Step 6, at [c4_ev_injective.py:63-64](../scripts/reviewers/r213/c4_ev_injective.py), reported into [run_n5_verify.py:144-148](../scripts/runs/run_n5_verify.py) as *"rank 14 against a cap of 14, with a 14-decade singular value gap"*. The forms that consume it, [results.md:204](../results.md), [results.md:40](../results.md), [sym3-blocks.md:326](../findings/sym3-blocks.md), say "exact rational certificate" and name no floating-point input.

**2. Exhibited concretely.** The object at which the step is not a proof is the $40\times120$ matrix itself. Its entries are exactly computable rationals; the record holds them only as float64, having divided each tensor by its own $\lVert\cdot\rVert_\infty$ and each column by its own maximum, two float operations that destroy the rational structure before the rank is taken. There is therefore **no object on the record from which the rank $14$ can be re-derived exactly**, and the conclusion "evaluation at these points is injective on EVERY invariant sextic" is an inference from a tolerance.

**3. Argued the opposite, the strongest reading the words support.** The strongest defence is that the needed conclusion is one-sided and floating point is safe in that direction. By Weyl's perturbation inequality for singular values, $\lvert\sigma_k(M)-\sigma_k(\tilde M)\rvert\le\lVert M-\tilde M\rVert_2$; the forming error for a well-scaled float64 einsum over six tensors is of relative order $10^{-15}$; so a *computed* $\sigma_{14}$ that is large relative to $\sigma_1$ certifies a *true* $\sigma_{14}>0$ and hence rank $\ge14$. **That defence is correct in principle and I accept it as a reason to believe the fact.** It fails as a proof for two reasons the record cannot repair by reading: the script prints only `sv[9:18]` and no run output is stored, so the actual value of $\sigma_{14}/\sigma_1$ is not on the record; and no forming-error bound is stated anywhere, so the perturbation argument has no numerator. **The candidate survives all three steps.**

### The repair, which is one run, and the reason this is sharper than a general complaint

**The record already owns the sound instrument and applies it elsewhere in the same pipeline.** [run_n5_sextic_basis.py](../scripts/runs/run_n5_sextic_basis.py) builds fourteen independent invariant sextics by `WI.rank_modp` over $\mathbb F_{10007}$, an **exact** rank over a finite field, at 40 Weyl tensors over the same field. And [Lemma L62](../results.md) makes precisely the argument that legitimises it: *"A rank computed from a sample of $K$ bounds the true rank from below, and reduction modulo a prime can only lower it further, so a sampled rank equal to $13$ forces equality."*

The identical one-line argument applies here. The evaluation matrix has rational entries; reduction mod $p$ can only lower its rank; so a mod-$p$ rank of $14$ at the certificate's own 40 points proves $\mathrm{rank}_{\mathbb Q}\ge14$, which with the cap of $14$ is injectivity, exactly. **The record uses the sound instrument at L62 and the unsound one at L61, for the same kind of claim, in the same file.** The repair is to re-run [c4_ev_injective.py](../scripts/reviewers/r213/c4_ev_injective.py) with `rank_modp` in place of `np.linalg.svd`, on the exact `Fraction` tensors it already constructs.

*This item needs computation and is therefore not something I may open, but naming what the run would decide is the point: a mod-$p$ rank of $14$ closes step 6 outright and converts L61's inequality half into a theorem; a rank below $14$ refutes injectivity at those points and the identity step collapses.*

### One candidate withdrawn

**WITHDRAWN, "the injectivity is proven at the wrong 40 points."** [c4_ev_injective.py](../scripts/reviewers/r213/c4_ev_injective.py) prints *"the same 40 the pipeline used"* without comparing anything, and it reconstructs the points by re-seeding at `20260829` and discarding the first draw (`for k in range(41): ... if k == 0: continue`), an off-by-one that looks like a fudge. It is not. [run_n5_assemble.py:894-910](../scripts/runs/run_n5_assemble.py) seeds `_r5` at the same `20260829`, defines `rand_weyl_tensor()` with the same `randint(-4, 4)` over 35 coordinates, and then consumes exactly one draw on the line `_probe = ev.coords(rand_weyl_tensor())` before the sample loop. The skip is faithful reproduction of the pipeline's own RNG consumption. **Reason for withdrawal: step 2 of the protocol fails, there is no object at which the point sets differ.** The residual is presentational: the claim of sameness is asserted where it could be checked against the stored rows in one comparison.

**Verdict on step 6: GAP.**

## 7. The equality clause, and whether an SOS can reach it at all

### The answer to the round's question

**An SOS certificate can characterise the zero set exactly, and this one cannot, for a reason that is structural rather than accidental.**

If $F_5=\sum_aq_a^2$ with $q_a$ real, then $Z(F_5)=\bigcap_aZ(q_a)=Z(K')$, where $K'=\mathrm{span}\{q_a\}\subseteq K$ and $K$ is the space of cubics vanishing on the orbit. That *is* an exact description of the zero set, but as the common zero locus of $K'$, not as an orbit. To reach "equality exactly on that orbit" one needs

$$Z(K')\;=\;\text{the cone over } O(5)\cdot W_0\;\cup\;\text{the cone over } O(5)\cdot(-W_0),$$

and only the inclusion $\supseteq$ is free. The reverse inclusion is U4: it needs the degree-3 part of the ideal of the orbit cone to cut that cone out set-theoretically, **and** it needs $K'$ to be all of that degree-3 part. **Nothing on the record establishes either**, and §5.5's figure, the certificate spans $4200$ of the $7770$ dimensions of $\mathrm{Sym}^3\mathcal W_5$, against a $K$ of codimension in the tens, is evidence against the second.

### The role of the cubics being odd

The conventions file's own line, *"Cubics are odd, so vanishing on $O(5)\cdot W_0$ forces vanishing on the orbit of $-W_0$ automatically"*, is the clean statement of the situation, and it cuts both ways.

- **It does not falsify the clause as written.** $-W_0$ has $\Lambda^2$ spectrum $(-2a,a,a,0^7)$, which is not the spectrum of $W_0$, so $-W_0\notin O(5)\cdot W_0$. But equality in "$\theta\le\sqrt{3/2}$" means $\theta=+\sqrt{3/2}$, and $\theta(-W_0)=-\sqrt{3/2}$. The second orbit sits in $Z(F_5)$ and outside the equality set of the *inequality*, consistently.
- **It does show the certificate's zero set is not one orbit.** $Z(F_5)$ is exactly $\{\lvert\theta\rvert=\sqrt{3/2}\}$ by step 4, hence at least the union of two distinct $O(5)$-orbits. So "the zero set the certificate exhibits" and "the orbit the clause names" are different objects, and any reading of Form A that identifies them is wrong. This matches the point grep surfaced from [REVIEW_r679](../reviews/REVIEW_r679.md), reached there for a different purpose.

### Is the clause even true?

I cannot decide it and neither can the record. What I can say is that it does not follow from the value: $\theta=\sqrt{3/2}$ forces $\operatorname{tr}(W^3)=\tfrac1{\sqrt6}\lVert W\rVert^3$, and $\tfrac1{\sqrt6}$ is *not* the unconstrained maximum of $p_3(\mu)$ on the unit sphere of trace-free operators on $\Lambda^2\mathbb R^5$, it is only the maximum on the rank-$\le3$ stratum (§1.4). So attaining the value does not by itself pin the spectrum, let alone the orbit. **The clause needs a rigidity argument, and rigidity is a separate statement with a separate proof.**

### Three-step discrepancy record

**1. Located.** "with equality exactly on that orbit", at [sym3-blocks.md:326](../findings/sym3-blocks.md) (Form A), [results.md:204](../results.md) (Form B) and [results.md:625](../results.md) (the detail entry). What it needs and lacks: U4, plus $K'=K$.

**2. Exhibited concretely.** The object at which the step breaks is any $W$ in $Z(K')\setminus(\pm O(5)\cdot W_0)$. I cannot exhibit one in closed form and I do not claim one exists, **that is exactly the point**: the certificate gives no upper bound on $Z(K')$ at all, so the clause is an assertion about an object the method never touches. The failure is exhibited at the level of the inference, not at a point.

**3. Argued the opposite.** The strongest reading is that the author means the clause as a claim about the *equality set of the inequality*, supported by some rigidity result elsewhere in the file rather than by the certificate. Under that reading Forms A and B are asserting a true-and-separately-proved fact in the same breath as the certificate. Two things defeat it. First, [results.md:23](../results.md) (the same record, seventeen lines above Form D), says the equality case "is unproven and unreachable by that route", so the author's own reading is that there is no such separate support. Second, the sentence's grammar attaches the clause to the certificate ("$F_5$ is a sum of squares … *Hence* $\theta\le\sqrt{3/2}$ … with equality exactly on that orbit"), which is the inference I have just shown is unavailable.

**Verdict: HYPOTHESIS-DEBT.** What would have to be proved, precisely: *the degree-3 part of the ideal of the cone over $O(5)\cdot W_0$ cuts that cone out set-theoretically, and the certificate's cubics span it*, or, alternatively and independently of the certificate, *a rigidity theorem showing $\operatorname{tr}(W^3)=\tfrac1{\sqrt6}$ on the unit sphere of $\mathcal W_5$ forces $W\in O(5)\cdot W_0$.* I am not supplying either.

## 8. Forms A, B, C and D against each other

**They do not state the same thing, and the disagreement is not only of emphasis.**

| | equality clause | character of the certificate | scope |
|---|---|---|---|
| **A** [sym3-blocks.md:326](../findings/sym3-blocks.md) | asserted as proved | unqualified | "on $\mathrm{Weyl}_5$" |
| **B** [results.md:204](../results.md) | asserted as proved | "**with exact rational coefficients**" | "on all of $\mathcal W_5$, critical or not" |
| **C** [results.md:23](../results.md) | "**the equality case is unproven and unreachable by that route**" | "an inequality on a machine certificate, resting on two measured links" |, |
| **D** [results.md:40](../results.md) | absent | "by an **exact rational certificate**" | "on all of $\mathcal W_5$" |

Four findings.

1. **A and B contradict C on the equality clause, flatly.** A and B state it as part of a numbered Lemma; C states it is unproven and unreachable. The detail entry at [results.md:625](../results.md) sides with A and B. **Three of the four sites assert what the fourth denies, and all four are in the record's canon.**
2. **B and D contradict C on the character of the proof.** "Exact rational" against "a machine certificate resting on two measured links". §9 gives the reading under which B and D are literally true and still misleading.
3. **C names the wrong two links.** It says "[L87]'s rank and [L62]'s value are each one sampled mod-$p$ rank". Both of those are *mod-$p$* instruments, and a mod-$p$ rank used as a lower bound is a sound instrument, L62's own entry at [results.md:631](../results.md) says so in terms: "The argument is exact, the sampling being a lower bound rather than a numerical estimate." **The floating-point injectivity of §6, the one genuinely soft link, appears in none of the four forms, caveated or otherwise.** So even the caveated form understates and mis-locates the dependency. This is the finding [plan-verification.md:203](../plan-verification.md) records from the [lean-loop](../.claude/skills/lean-loop/SKILL.md) round; I reached it independently from the scripts.
4. **A and B omit the scope that D adds and D omits the scope that B adds.** D asserts $M(5)=\sqrt{3/2}$, an equality of a maximum, which needs attainment as well as the bound; attainment is real (padding preserves $\theta$) but is stated nowhere near D. A says "$\mathrm{Weyl}_5$" where the rest say "$\mathcal W_5$"; those are the same object under two names, which the conventions file tables for other symbols and not for this one.

**Verdict: BROKEN.** The four forms are not four wordings of one statement.

## 9. "An exact rational certificate"

**Three-step record.**

**1. Located.** [results.md:40](../results.md): "$M(5)=\sqrt{3/2}$ holds on all of $\mathcal W_5$ by an exact rational certificate", and [results.md:204](../results.md)'s "with exact rational coefficients".

**2. Exhibited concretely.** The certificate has two halves and only one is exact. Positive-definiteness: exact over $\mathbb Q$, twice, and machine-checked again in Lean ([lean/INDEX.md](../lean/INDEX.md): "Kernel-checked, no `native_decide`"). The identity: a float64 SVD rank (§6). Further down the same pipeline, the rows themselves are **rationally reconstructed** from three mod-$p$ residues by CRT plus extended-Euclid ([run_n5_lift.py](../scripts/runs/run_n5_lift.py)), which returns the unique $p/q$ under a bound *when it exists*, a lift that is correct only if the true rational fits under the bound, reported rather than proved. And the JSON's own `denominator` field says $10^5$ while thirteen of the 47 coordinates carry denominators up to $1.87\times10^{16}$, the verify script flags this itself, attributing it to reviewer 213.

**3. Argued the opposite.** The strongest reading is that "exact rational" modifies the *coefficients*, which it does at [results.md:204](../results.md), and truthfully: every one of the 47 numbers in [n5_certificate.json](../scripts/runs/n5_certificate.json) is an exact rational and I read all 47. Under that reading B is true. **D is not rescued by it**: "holds … *by* an exact rational certificate" attaches the exactness to the holding, and the holding depends on a float64 rank.

**Verdict: OVERSTATED at D, technically true and misleading at B.** The honest phrasing is that the certificate's *data* is exact rational, its *positive-definiteness* is verified exactly, and its *identification with $F_5$* is not.

## 10. What would break it, and what I did to look

**The falsifier is a single object**: a $W\in\mathcal W_5$ with $\lVert W\rVert=1$ and $\operatorname{tr}(W^3)>1/\sqrt6=0.40825$. By step 3 that is $\theta>\sqrt{3/2}$, and it refutes L61 outright regardless of the certificate.

**What I did.** Analysis only, in closed form, on objects I constructed for the purpose.

- **The rank-stratum bound.** The maximum of $p_3(\mu)$ over trace-free symmetric operators of rank $\le r$ with $\sum\mu^2=1$ is $(r-2)/\sqrt{r(r-1)}$, attained at $\mu=\big(\tfrac{r-1}{\sqrt{r(r-1)}},-\tfrac1{\sqrt{r(r-1)}},\dots\big)$. At $r=3$ this is exactly $1/\sqrt6$, **so $W_0$ is the champion of its own stratum and no rank-$\le3$ falsifier exists.** At $r=4$ it is $0.5774$ and at $r=10$ it is $0.8433$, so every falsifier must have $\Lambda^2$-rank at least four.
- **Against the record's own spectral necessary condition.** [Lemma L73](../results.md) gives $\lambda_{\max}\le(n-2)\lvert\lambda_{\min}\rvert=3\lvert\lambda_{\min}\rvert$ on all of $\mathcal W_5$. $W_0$ satisfies it with room ($2a$ against $3a$), so it does not select $W_0$; and the spectra I tried under it that beat $1/\sqrt6$ all violate something else or fail to be Weyl. Two closed-form probes: $(3m,3m,m,-m^{\times7})$ gives $48/26^{3/2}=0.362$ and $\big(\tfrac73b,\tfrac73b,\tfrac73b,-b^{\times7}\big)$ gives $0.276$, both **below** $1/\sqrt6$. Neither is a falsifier and neither is a proof, the constraint that would have to do the work is realisability as a Weyl tensor, which no closed form on the record supplies.
- **Against the record's own family.** [Lemma L74](../results.md) puts every strongly regular graph on the diagonal locus of $\mathcal W_v$; at $v=5$ the diagonal maximum is $\Theta_5=2\sqrt2/3=0.9428$, so $\operatorname{tr}(W^3)=\theta/3=0.3143<0.40825$. The diagonal locus supplies no falsifier, which is exactly what one expects since $W_0$ is diagonal in no frame.

**No falsifier found, and I did not expect to find one by hand.** The interest of the exercise is what it shows about the shape of the claim: the certificate's whole content is a statement about ranks four and above, and none of the record's closed-form families lives there.

## Verdict

**GAP**, with the equality clause carried as **HYPOTHESIS-DEBT**.

- **Steps 1 to 5 stand.** The cubic collapse is a real theorem with a real proof (the $\delta^{[6]}$ pigeonhole), the constant $c=2$ is confirmed exactly from the conventions file and the Lean-checked value at the competitor, $F_5\ge0\iff\lvert\theta\rvert\le\sqrt{3/2}$ is an identity, and the 16 blocks are positive definite exactly over $\mathbb Q$ by a criterion I re-derived and accept.
- **Step 6 is the gap.** The injectivity that converts 40 equations into an identity is a float64 SVD rank at threshold `1e-10`, on data that is exactly rational upstream of a `float(...)` cast. The record owns the sound instrument, `rank_modp`, and [L62](../results.md)'s own "reduction modulo a prime can only lower it" argument, and does not apply it here. The repair is one run and it decides the lemma.
- **The equality clause has no argument on file.** An SOS bounds the zero set from below only; the reverse inclusion needs the degree-3 part of the orbit ideal to cut out the orbit cone, and the certificate spans $4200$ of $7770$ dimensions rather than all of $K$. I state the debt and do not discharge it.
- **The four canonical forms disagree**, three asserting the equality clause and one denying it, two calling the certificate exact and one calling it measured, and the one soft link is named by none of them.

*The inequality $M(5)=\sqrt{3/2}$ is very probably true and the certificate is very probably sound. Neither of those is what the record claims, which is that it is proved by an exact rational certificate.*

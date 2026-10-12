# Review r642, Lemma L111, criticality in bracket coordinates

**Reviewer B of an independent pair on identical briefs (the other takes r641; neither report, log nor scratch was read).** Target: [findings/bounds.md](../findings/bounds.md) line 409, `#### Lemma L111, criticality in bracket coordinates is $M_{kl}=2\lambda_k(\lambda_k-\theta)\delta_{kl}$, and the bracket form is strictly weaker`.

**Verdict: GAP.** The matrix form is CONFIRMED, it is criticality, both directions, by a two-line identity. The block's own correction (the "equivalently" is false, the bracket form is $[W,Q(W)]=0$, the diagonal locus is the witness, the "$\lambda_k\ne\lambda_l$" restriction is wrong) is CONFIRMED in every clause but one. What the block still owes: **the strictness is never quantified**, the count was deleted rather than repaired, and it is $\sum_i\binom{m_i+1}2$; **the repair sentence overstates**, the diagonal locus contains the conjecture's own extremiser, so "every diagonal Weyl tensor … nowhere near critical" is false; **one of [r326](REVIEW_r326.md)'s four corrections was never folded in**; and **the record held the counterexample's mechanism eight days before the false claim was written**, in [problem.md](../findings/problem.md), which is the transferable finding here.

**Analysis-only footing observed. No computation was run**, the witness is established structurally, and the counting is combinatorial. Nothing below rests on a screen, mine or the record's.

---

## 0. Symbols, read before deriving, since [conventions.md](../findings/conventions.md) is unreliable

| symbol | the reading used here | why this one |
| --- | --- | --- |
| $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$ | orthonormal $\{\varphi_{ab}\}_{a<b}$ under $\langle A,B\rangle=\tfrac12\operatorname{tr}(A^{\mathsf T}B)$, $N=\binom n2$ | [conventions.md](../findings/conventions.md), "a bivector's norm", the record runs in the half-trace pairing |
| $c_{k\alpha\beta}$ | $\langle[\varphi_k,\varphi_\alpha],\varphi_\beta\rangle$, totally antisymmetric | [conventions.md](../findings/conventions.md), structure constants |
| $W^\#$ | $W^\#_{kl}=\tfrac12\sum_{\alpha\beta\gamma\delta}c_{k\alpha\beta}c_{l\gamma\delta}W_{\alpha\gamma}W_{\beta\delta}$ | forced by the block's own polarisation, and matching [r323](REVIEW_r323.md)'s independent build $W^\#_{ab}=-\tfrac12\operatorname{tr}(\mathrm{ad}_aW\,\mathrm{ad}_bW)$ |
| criticality | $Q(W)=W^2+W^\#=\theta W$ at $\lVert W\rVert=1$ | [conventions.md](../findings/conventions.md), "critical point" |
| $\lambda_k$ | the eigenvalue of $W$ on $\Lambda^2$ at the eigenvector $\varphi_k$; $k$ runs over $1..N$, **not** over coordinate pairs | the block's $M_{kl}$ is indexed by an eigenbasis |
| $M_{kl}$ | $\operatorname{tr}(\mathrm{ad}(\varphi_k)W\,\mathrm{ad}(\varphi_l)W)$ | the block's own definition |
| $m_1..m_r$ | multiplicities of the $r$ **distinct** eigenvalues of $W$ on $\Lambda^2$, $\sum_im_i=N$ | mine, for §2c |

**$M_{kl}$ is not $M(n)$ and is not the sectional matrix.** [conventions.md](../findings/conventions.md) tables a bare $M$ as the sectional matrix $K$ and separately $M(n)$ as the global maximum of $P$; this block's $M_{kl}$ is a third object, an $N\times N$ Gram-type matrix on $\mathfrak{so}(n)$. The block never says so. **That is a live collision, and it is the one [conventions.md](../findings/conventions.md) warns about by name.**

**The "$\varphi_k$ is a $W$-eigenvector" hypothesis is silent in the block and is load-bearing.** Everything in §1 fails in an arbitrary orthonormal basis.

---

## 1. The matrix form, **CONFIRMED**, and the $\delta_{kl}$ is a conclusion

**The identity, on all of $\mathrm{Sym}(\Lambda^2)$ and in any orthonormal basis.** With $(\mathrm{ad}\,\varphi_k)_{\alpha\beta}=\langle\varphi_\alpha,[\varphi_k,\varphi_\beta]\rangle=c_{k\beta\alpha}$,

$$\operatorname{tr}(\mathrm{ad}(\varphi_k)W\,\mathrm{ad}(\varphi_l)W)=\sum_{\alpha\beta\gamma\delta}c_{k\beta\alpha}c_{l\delta\gamma}W_{\beta\gamma}W_{\delta\alpha} =\sum_{\alpha\beta\gamma\delta}c_{k\alpha\beta}c_{l\gamma\delta}W_{\alpha\delta}W_{\beta\gamma},$$

relabelling $\alpha\!\leftrightarrow\!\beta$, $\gamma\!\leftrightarrow\!\delta$ and using $W$ symmetric. Against $2W^\#_{kl}=\sum c_{k\alpha\beta}c_{l\gamma\delta}W_{\alpha\gamma}W_{\beta\delta}$ the two differ by the single transposition $\gamma\!\leftrightarrow\!\delta$, which $c_{l\gamma\delta}$ answers with a sign. Hence

$$\boxed{\;M_{kl}=-2\,W^\#_{kl}\;}$$

identically. **No criticality, no unit norm, no trace-freeness, no Bianchi identity enters**, it is total antisymmetry of $c$ and symmetry of $W$, nothing else. In a $W$-eigenbasis this is $M_{kl}=-\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta c_{k\alpha\beta}c_{l\alpha\beta}$, the block's bracket expression, and it reproduces the block's stated polarisation $\langle v,W^\#v\rangle=-\tfrac12\operatorname{tr}(\mathrm{ad}(v)W\mathrm{ad}(v)W)$ on the diagonal.

**The equivalence.** In a $W$-eigenbasis $W$ and $W^2$ are diagonal with entries $\lambda_k,\lambda_k^2$, so

$$Q(W)=\theta W\iff W^\#=\theta W-W^2\iff W^\#_{kl}=\lambda_k(\theta-\lambda_k)\delta_{kl}\iff M_{kl}=2\lambda_k(\lambda_k-\theta)\delta_{kl}.$$

Both directions are immediate; nothing is lost either way. The block's self-assessment (*"a change of language, not new information"*), is exactly right for this form.

**The $\delta_{kl}$ is a conclusion, and it is where the content sits.** The equation is $N$ diagonal *value* statements plus $\binom N2$ off-diagonal *vanishings*; the vanishings say $W^\#$ has no matrix element between distinct eigenvectors, i.e. $W^\#$ is diagonal in $W$'s eigenbasis. Neither half is a hypothesis: the eigenbasis is fixed by $W$ before $W^\#$ is looked at.

**One caveat the block owes and does not pay.** Inside a degenerate eigenspace the eigenbasis is not unique. The statement survives this, criticality forces $W^\#|_{E_\lambda}=\lambda(\theta-\lambda)\mathrm{Id}$, which is basis-free on the block, so the equation holds in **every** eigenbasis of $W$. **But the block's phrase "basis-independently" is false as it literally reads**: in a basis that is not a $W$-eigenbasis, $M_{kl}=-2(\theta W-W^2)_{kl}$ is generically nonzero off the diagonal. The correct phrase is *in every eigenbasis of $W$*. The same loose word is in [r326](REVIEW_r326.md); this pair of reviews is where it should be caught.

---

## 2. The bracket form, and the strictness

### 2a. The bracket relations from the matrix form, **CONFIRMED**, and the identification is exact

Dropping the diagonal equations and keeping $M_{kl}=0$ only for $\lambda_k\ne\lambda_l$ leaves: $W^\#_{kl}=0$ whenever $\lambda_k\ne\lambda_l$, i.e. $W^\#$ preserves every eigenspace of $W$, i.e. $[W,W^\#]=0$. Since $[W,W^2]=0$ always, this is exactly

$$[W,Q(W)]=0 .$$

It uses the boxed identity and nothing more. **The block's identification of the bracket form with $[W,Q(W)]=0$ is correct**, and [conventions.md](../findings/conventions.md) now carries it under "critical point".

### 2b. The failure of the converse, **CONFIRMED**, and the witness is structural, not numerical

The block's witness is the coordinate-diagonal locus. I check it rather than repeat it, and it needs no arithmetic.

**Step 1, the locus is $n(n-3)/2$-dimensional and consists of genuine Weyl operators.** Let $W\varphi_{ab}=K_{ab}\varphi_{ab}$ with $K$ symmetric hollow. First Bianchi is automatic: $R_{ijkl}$ is supported on $\{ij\}=\{kl\}$, so each of the three cyclic terms vanishes on distinct indices. Ricci-flatness is $\sum_bK_{ab}=0$. So the locus is $\mathcal D_n=\{K$ symmetric, hollow, $K\mathbf 1=0\}$, [conventions.md](../findings/conventions.md)'s own $\mathcal D_n$, of dimension $\binom n2-n=n(n-3)/2$. **The block's $n(n-3)/2$ is right**, as a linear space; the witness family is its complement of a proper subvariety, and the block should say "generic member of an $n(n-3)/2$-dimensional space", not "an $n(n-3)/2$-dimensional family", since the critical members are inside it.

**Step 2, $W^\#$ is coordinate-diagonal whenever $W$ is.** $c_{(ab)\alpha\beta}\ne0$ forces $\{\alpha,\beta\}=\{(ac),(bc)\}$ for some $c\notin\{a,b\}$. For $W^\#_{(ab),(cd)}\ne0$ the two index pairs must admit a *common* such $\{\alpha,\beta\}$. Suppose $(ab)\ne(cd)$. If they share one index, say $b=c$, then $\{(ax),(bx)\}=\{(by),(dy)\}$ forces either $a=d$ or $x\in\{a,b\}$, both excluded. If they are disjoint the same matching is impossible outright. Hence $W^\#$ is diagonal, with $W^\#_{(ab),(ab)}=\sum_{c\ne a,b}K_{ac}K_{bc}$.

**Step 3, so $[W,Q(W)]=0$ on all of $\mathcal D_n$, while $Q(W)=\theta W$ is $N$ equations on $n(n-3)/2$ unknowns.** At $n=6$: $15$ equations, $9$ unknowns (plus $\theta$). Generic members fail. The strictness holds.

**And the record proved Step 2 eight days before it wrote the false claim.** [findings/problem.md](../findings/problem.md) line 118, committed `51ab61f8` on 2026-08-24: *"For $W$ diagonal on coordinate $2$-planes $e_i\wedge e_j$, **$Q$ preserves diagonality** and reduces to $(Q(W))_{ij,ij}=\lambda_{ij}^2+\sum_{k\ne i,j}\lambda_{ik}\lambda_{jk}$, this is the tractable 'diagonal case' already solved."* That sentence *is* the counterexample: $Q$ preserving diagonality is $[W,Q(W)]=0$, and "already solved" means criticality there is a nontrivial equation with a small solution set. The claim was written on 2026-09-01 (`a90940db`) and refuted the same evening. **This is the finding to carry out of this audit**: the refutation stood in the file the block's conjecture statement comes from, and the block reached for a screen instead of a grep. (The same mechanism is stated again, later and independently, at [verification/VERIFY_v1.md](../verification/VERIFY_v1.md) Finding 7, with the same closed form.)

### 2c. **How much weaker, the number the record does not state**

Let $W$ have distinct eigenvalues $\nu_1..\nu_r$ with multiplicities $m_1..m_r$, $\sum m_i=N$. As a symmetric-matrix equation, the matrix form is $\tfrac12N(N+1)$ scalar equations. The bracket form keeps exactly the off-diagonal pairs across distinct eigenvalues:

$$\text{kept}=\sum_{i<j}m_im_j=\frac{N^2-\sum_im_i^2}{2},\qquad \textbf{dropped}=\underbrace{N}_{\text{the values}}+\underbrace{\sum_i\binom{m_i}2}_{\text{within-block off-diagonals}}=\frac{\sum_im_i^2+N}{2}=\boxed{\sum_i\binom{m_i+1}2}.$$

**And that closed form is the right one conceptually, not just arithmetically**: $\sum_i\binom{m_i+1}2$ is the dimension of the space of symmetric operators commuting with $W$. The bracket form says the residual $W^\#-(\theta W-W^2)$ has no component *across* eigenblocks; criticality says its block-diagonal part vanishes too, and that part lives in $\bigoplus_i\mathrm{Sym}(m_i)$. **The strictness is exactly one $W$-commutant.**

Two readings that make it concrete:

| point | multiplicities | total equations | kept by the bracket form | **dropped** |
| --- | --- | --- | --- | --- |
| generic $W$ (all $m_i=1$), any $n$ | $1^N$ | $\tfrac12N(N+1)$ | $\tfrac12N(N-1)$ | $N$ |
| generic coordinate-diagonal $W$, $n=6$ | $1^{15}$ | $120$ | $105$ | $15$ |
| balanced $S^3\times S^3$, $n=6$ ($\dim\mathfrak m=9$, $\dim\mathfrak h=6$) | $(9,6)$ | $120$ | $54$ | **$66$** |

So at the conjecture's own extremiser the bracket form carries **45%** of criticality's equations. The block's clause *"whenever $\lambda_k\ne\lambda_l$"* is not a small hedge at the points the programme cares about, the more degenerate the spectrum, the more it throws away, and the balanced product is maximally degenerate for its dimension.

*Counting caveat, stated because the record's habit is to omit it: this counts equations, not codimension in $\mathcal W_n$; independence as constraints on $W$ is not claimed and is not needed for the strictness statement.*

**This number is owed and absent.** The block originally said *"a family of $\tfrac12N(N-1)$ scalar relations"* (`a90940db`); [r326](REVIEW_r326.md) caught that $\tfrac12N(N-1)$ counts all $k<l$, contradicting the "$\lambda_k\ne\lambda_l$" restriction in the same sentence. **The repair deleted the count**, the block now reads "a family of scalar relations" and states no number anywhere. That is a repair that removed the contradiction by removing the information.

---

## 3. The withdrawn motivation, **withdrawal CONFIRMED, and it is clean**

- **The withdrawal is right.** [r326](REVIEW_r326.md) I1 shows [post F41](../findings/fence-posts.md)'s marginal LP omitted the proved Weyl identity $\sum_a\lambda_am_a=-2\langle v,Wv\rangle$, and that restoring it returns the exact $\theta$ at all four maximal tori, at $\mathrm{ad}(\mathfrak{su}(3))$, at both $\mathbb{CP}^m$ and at both unbalanced products, the gains matching post F41's tabulated slacks digit for digit. [post F41](../findings/fence-posts.md) carries the same withdrawal in its own blockquote, consistently.
- **The block does not lean on the withdrawn claim.** §1's derivation is the boxed identity plus the definition of $Q$; F41 enters nowhere in it. The block's sentence *"only the reason for reaching for it was wrong"* is accurate.
- **What the result is for now.** Its **diagonal half is already relation (C)** at [bounds.md](../findings/bounds.md) line 237, $\sum_{\beta\gamma}\lambda_\beta\lambda_\gamma T_{k\beta\gamma}=2\lambda_k(\theta-\lambda_k)$, *"(C) is criticality"*, stated $172$ lines above L111 in the same file, and that half is what [L112](../findings/bounds.md), [L73](../findings/bounds.md) and every LP in [bounds-relaxations.md](../findings/bounds-relaxations.md) actually consume. **Its off-diagonal half is consumed by nothing**: no file outside [bounds.md](../findings/bounds.md) cites L111, and inside the block every consumer is withdrawn (the sharpness reading, the bilinear spectrum maximum, and the deficiency reformulation, which [r323](REVIEW_r323.md) closed as a tautology).
- **Blast radius: zero.** The only live content unique to L111 is the off-diagonal family, which the block itself calls *"the untouched reserve"*. A result whose entire novel half is untouched reserve, whose motivation is withdrawn and whose stated consumers are all withdrawn is carrying a `Lemma` label on no current work. That is a bookkeeping verdict, not a mathematical one, and I record it as such.

**A cross-block inconsistency the withdrawal exposes.** [bounds.md](../findings/bounds.md) line 236 says the three per-index relations (A), (B), (C) *"are the whole of what the Killing form, Ricci-flatness and criticality give"*. **L111's own repaired statement refutes that**: criticality also gives $\binom N2$ off-diagonal relations, and, [r326](REVIEW_r326.md)'s point, they are not expressible in $T=c^2$ at all, so they are not in the span of (A), (B), (C) under any weight. The two blocks are $172$ lines apart in one file and disagree. The scope word *"per-index"* half-rescues line 236; the sentence as written does not.

---

## 4. The screen that was blind

**What the screen was, from the commit that introduced it** (`a90940db`, [bounds.md](../findings/bounds.md), since replaced): *"Verified: the off-diagonal residual is $\le1.3\times10^{-16}$ at the balanced products, the maximal tori, $\mathrm{ad}(\mathfrak{su}(3))$ and padded $W_{\mathbb{CP}^2}$, and $1.1\times10^{-1}$ at random non-critical $W$, so the relations are consequences of criticality and of nothing weaker."*

**Why it could not fail.** It has two halves and neither tests the claim:

- The first half samples **critical** points and confirms the relations hold there. That is necessity, the direction that follows from the boxed identity for free. It cannot bear on the converse.
- The second half samples **random** $W\in\mathcal W_n$ and observes the residual is large. The converse asserted is *"no non-critical $W$ satisfies the relations"*. A random sample verifies that on a full-measure set; the solution set of $[W,Q(W)]=0$ that is not critical has positive codimension, so **a full-measure sampler is structurally incapable of returning a counterexample, whatever it returns**. The screen's passing was determined before it ran.

**What it would have had to test.** Sample **the solution set of the relations**, not the ambient space, i.e. condition on the bracket relations and measure the criticality residual there. Concretely: pick any stratum on which $Q$ is known to preserve $W$'s eigenspaces and check criticality on it. The coordinate-diagonal locus is that stratum, it is the record's principal study object ([diagonal-half.md](../findings/diagonal-half.md)), and [problem.md](../findings/problem.md) line 118 already names the property that puts it there. **The general rule: a screen for "$A\Rightarrow B$ and nothing weaker" must sample $\{B\}$, and sampling the ambient space tests nothing.** The block does not state this, and it does not state what its screen covered, it says only which population was drawn.

**Other claims in the block resting on the same screen.** None. The screen supported only the deleted sentence *"of criticality and of nothing weaker"*. The block's remaining figures come from other runs: the LP table (independently reproduced to nine digits by [r326](REVIEW_r326.md) I3 and CONFIRMED there), [run_bilinear_spectrum_max.py](../scripts/runs/run_bilinear_spectrum_max.py) (withdrawn in the block for omitting relation (B)) and the $\le2\times10^{-16}$ identity check on $D$. **But one claim in the block rests on nothing at all**, see §5, item 3.

---

## 5. What the half-repaired block still owes

Ordered by how load-bearing the defect is.

1. **"Every diagonal Weyl tensor satisfies it while being nowhere near critical" is FALSE.** The coordinate-diagonal locus contains the conjecture's own extremiser: [problem.md](../findings/problem.md) quotes Jäger's Theorem A on $W\in\langle W\rangle_d$ concluding *"$W$ is the normalized Weyl curvature of $S^{n/2}\times S^{n/2}$"*, so the balanced sphere product and every $S^p\times S^q$ are diagonal **and critical**. The true statement is that the *generic* member of $\mathcal D_n$ satisfies the bracket form and fails criticality; the locus is not disjoint from the critical set, it strictly contains a piece of it. As written the sentence contradicts the record's own diagonal case, and it does so inside the blockquote that exists to correct an overstatement. **This is the second defect the brief predicted, and it is in the repair itself.**

2. **The strictness is unquantified.** §2c supplies $\sum_i\binom{m_i+1}2$, with the reading "one $W$-commutant" and the $66$-of-$120$ figure at the balanced product. The old count was deleted rather than corrected.

3. **[r326](REVIEW_r326.md)'s fourth correction was never folded in.** The block still asserts *"What it buys is that criticality and $D$ are now expressed in the same variables $c_{k\alpha\beta}$"* and, in the same breath, that the off-diagonal entries *"are the only place the Jacobi identity can enter a bound on $D$"*. [r326](REVIEW_r326.md) refuted the first: $D$ and the diagonal relations are functions of $T=c^2$, whereas the off-diagonal relations involve the **signed** products $c_{k\alpha\beta}c_{l\alpha\beta}$, which are not functions of $T$. I confirm that independently, $M_{kl}$ for $k\ne l$ changes sign under $\varphi_l\mapsto-\varphi_l$ while $T$ does not, so no function of $T$ can express it. **The reserve lives in different variables from the quantity it is advertised as bounding**, and the block's line *"expressed in the same variables"* is the one sentence in the block that survives its own correction blockquote while having been refuted by the reviewer that blockquote cites.

4. **"Basis-independently" is wrong as written** (§1): read *in every eigenbasis of $W$*.

5. **A misquotation of the record's own screen.** The block states the random-$W$ control gives off-diagonal $1.5\times10^{-1}$. The screen it is describing recorded $1.1\times10^{-1}$ (`a90940db`, quoted in §4), and [r326](REVIEW_r326.md) measured $7.6\times10^{-2}$ at $n=6$ and $3.4\times10^{-2}$ at $n=8$. The $1.5\times10^{-1}$ is a fresh measurement of the block's own presented as a statement about what the old screen returned. Small, but it is a number a reader checking the history will not find.

6. **$M_{kl}$ is undeclared against two other $M$'s** on the record (§0), in a block whose title is the symbol.

7. **Label hygiene.** [INDEX-results.md](../findings/INDEX-results.md) row **111** reads *"Gate 2: no verdict on the record"* under the kind `Lemma`, whose stated meaning in that file's own header is *"proven, Gate 1 and Gate 2 passed"*. Rows 111–114 share this. Out of scope for the mathematics; in scope for whether the label can be trusted.

## Provenance, checked, and **clean**, breaking the run

| attribution in the block | checked against | verdict |
| --- | --- | --- |
| *"[Reviewer 326](REVIEW_r326.md), verified here"* on the false "equivalently" | [REVIEW_r326.md](REVIEW_r326.md) §I2, verdict *"REFUTED AS STATED"* | **accurate**, every clause of the block's blockquote is in I2, including the diagonal witness, the random-$W$ diagnosis and the "$\lambda_k\ne\lambda_l$" correction |
| *"[Reviewer 326](REVIEW_r326.md)"* on the withdrawn F41 motivation | [REVIEW_r326.md](REVIEW_r326.md) §I1 | **accurate**, the omitted marginal and the exact-$\theta$ collapse are I1's |
| *"[Reviewer 326](REVIEW_r326.md)"* on the withdrawn sharpness reading | [REVIEW_r326.md](REVIEW_r326.md) §I4, verdict *"REFUTED"* | **accurate**, including the ablation and the $4.05\times$ figure |
| *"[Reviewer 323](REVIEW_r323.md), verified here by elimination"* on the tautology | [REVIEW_r323.md](REVIEW_r323.md) §L4, *"TAUTOLOGY. Reviewer 118's failure, repeated"* | **accurate**; and the tautology itself checks by hand, [L70](../findings/bounds.md) is $\theta=\lambda_{\min}+(n-2)\lambda_{\max}-D/\lvert\lambda_{\min}\rvert$, so the displayed equivalence is that identity with $\theta_0$ subtracted from both sides |
| the commit message for `0d14e8dd` | the block as it now stands | **matches**, apart from item 5 above |

**Pointers.** All resolve: [REVIEW_r326.md](REVIEW_r326.md), [REVIEW_r323.md](REVIEW_r323.md), [REVIEW_r331.md](REVIEW_r331.md), [run_diag_criticality_lp.py](../scripts/runs/run_diag_criticality_lp.py), [run_bilinear_spectrum_max.py](../scripts/runs/run_bilinear_spectrum_max.py), [run_pinned_lp_spectra.py](../scripts/runs/run_pinned_lp_spectra.py), posts F10/F34/F40/F41 in [fence-posts.md](../findings/fence-posts.md), and the [L70](../findings/bounds.md) anchor. One is weak rather than broken: *"[Reviewer 118](INDEX.md)"* points at the review index while [REVIEW_r118.md](REVIEW_r118.md) exists and is the actual source.

## Does the block's own file settle it?

**Partly, twice.** The diagonal half is relation (C) at [bounds.md](../findings/bounds.md) line 237, above the block. And the counterexample's mechanism is at [problem.md](../findings/problem.md) line 118, in a different file, dated eight days earlier (another instance of the record already holding the answer), one file over rather than in the block's own, and one where the pre-existing sentence is a *positive* statement of the exact property the later claim denies.

## What would settle nothing, and needs no run

Every item above is decided analytically. **No computation is requested and none is owed**, in particular the diagonal witness needs no measurement, the $0.527$–$0.741$ residuals in the block being corroboration of a structural fact rather than its evidence. The one place a run could add anything is item 2's caveat, whether the $\sum_i\binom{m_i+1}2$ dropped equations are independent as constraints on $\mathcal W_n$, which a rank computation of the differential would decide, and which **no claim in this review depends on**.

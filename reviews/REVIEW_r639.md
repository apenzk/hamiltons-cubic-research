# Reviewer 639, Lemma L114, the block-mass identity, and the $S_{XYZ}$ normalisation it fixes

**Review number: r639.** Target: [Lemma L114](../findings/bounds-relaxations.md), the block-mass identity at line 126 of [bounds-relaxations.md](../findings/bounds-relaxations.md). Reviewer A of an independent pair on identical briefs. Derived cold from [conventions.md](../findings/conventions.md); the block's own reasoning was read only after the derivation closed. **Analysis only**, nothing here was computed; the two arithmetic checks below are hand computations in $\mathfrak{so}(6)$, exact, and are presented as derivation rather than measurement.

## Verdict

**CONFIRMED**, the identity is a **theorem**, at every $n$, every $d$ and every orthogonal two-block split, with coefficients $6/4/2$ exactly right in the **unordered-triple** reading. **One clause of the block is REFUTED**: *"Both reviewers rejected the inference"* is false against [r65](REVIEW_r65.md), which accepted it. Four further gaps are listed in §6.

## 1. The convention finding, lead item

| question | answer |
| --- | --- |
| Which reading is L114 in? | **Unordered triples.** $S_{XYZ}$ counts each unordered index triple $\{a,b,c\}$ **once**. |
| Are its coefficients right in that reading? | **Yes**, $6/4/2$ and the twin's $6/4/2$, exactly and for a reason (§2). |
| Is the display true in the ordered reading? | **No.** Witness in §2.3: it overshoots by a factor $3$ at $\mathfrak{so}(3)\oplus\mathfrak{so}(3)\subset\mathfrak{so}(6)$. |
| Which reading does the rest of the record use? | **Ordered slots**, [nondegeneracy.md](../findings/nondegeneracy.md), [bounds.md](../findings/bounds.md), [LEDGER.md](../findings/LEDGER.md), and decisively the record's only instrument, [run_grading_test.py](../scripts/runs/run_grading_test.py). |
| What should [conventions.md](../findings/conventions.md) adopt? | **Ordered slots**, for five reasons in §4. **No number on the record changes**; four displays in [bounds-relaxations.md](../findings/bounds-relaxations.md) and two in [isotropy-cap.md](../findings/isotropy-cap.md) do. |

**The three readings that are in play, named once so they can be told apart.** For blocks $X,Y,Z\in\{\mathfrak m,\mathfrak h\}$ and $T_{abc}=c_{abc}^2$ with $c_{abc}=\langle[v_a,v_b],v_c\rangle$:

- **(A) unordered**, $A_{XYZ}=\sum T_{abc}$ over unordered triples $\{a,b,c\}$ whose block-label multiset is $\{X,Y,Z\}$.
- **(B) ordered slots**, $S_{XYZ}=\sum_{a\in X}\sum_{b\in Y}\sum_{c\in Z}T_{abc}$, the block-restricted contraction.
- **(C) fully ordered by label**, all ordered triples with label multiset $\{X,Y,Z\}$; this is $6A_{XYZ}$ for every pattern, a single global factor, and it is **not** what any file here uses.

## 2. The derivation

### 2.1 The two inputs

**Total symmetry and hollowness of $T$.** [conventions.md](../findings/conventions.md) fixes $c_{abc}=\langle[v_a,v_b],v_c\rangle$ totally antisymmetric (the inner product is ad-invariant), so $T_{abc}=c_{abc}^2$ is **totally symmetric and vanishes whenever two indices coincide**.

**The row marginal.** $\sum_c T_{abc}=\lVert[v_a,v_b]\rVert^2$, hence

$$\sum_{b,c}T_{abc}=\sum_b\lVert[v_a,v_b]\rVert^2=\operatorname{tr}\!\big(\mathrm{ad}(v_a)^{\mathsf T}\mathrm{ad}(v_a)\big)=-\operatorname{tr}\big(\mathrm{ad}(v_a)^2\big)=-B(v_a,v_a)=-(n-2)\operatorname{tr}(v_a^2)=2(n-2),$$

using the Killing form $B(X,Y)=(n-2)\operatorname{tr}(XY)$ of $\mathfrak{so}(n)$ and $\operatorname{tr}(v^2)=-2$ for a unit bivector. **Confirmed.** It is a Killing-form fact needing only $\lVert v_a\rVert=1$, no criticality, no Weyl-ness. Hand check at $n=6$, $v_a=\varphi_{12}$: the six $\varphi_{ab}$ with $a,b\in\{3,4,5,6\}$ commute with it, and each $k\in\{3,4,5,6\}$ contributes $\lVert[\varphi_{12},\varphi_{1k}]\rVert^2+\lVert[\varphi_{12},\varphi_{2k}]\rVert^2=2$, giving $8=2(6-2)$.

**Where it is stated, and it carries no result number.** [conventions.md](../findings/conventions.md), the *"pair cap and the Killing marginal"* bullet: *"$\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=2(n-2)$. Both are standing facts, used across several files."* The pair cap beside it is [Lemma L31](../findings/stratum-two-negative.md); **the marginal is numbered nowhere**, [INDEX-results.md](../findings/INDEX-results.md) has no row for it. The block's pointer resolves; the fact is unnumbered and should be, since [L109](../findings/bounds-relaxations.md), [L36](../findings/isotropy-cap.md), [post F18](../findings/bounds-relaxations.md) and L114 all consume it.

### 2.2 The identity, and every coefficient accounted for

Let $\mathfrak{so}(n)=\mathfrak m\oplus\mathfrak h$ be **any** orthogonal splitting, $d=\dim\mathfrak m$, $N=\binom n2$. Sum the marginal over $\mathfrak m$-rows and split the free ordered pair $(b,c)$ by block:

$$2d(n-2)=\sum_{a\in\mathfrak m}\sum_{b,c}T_{abc}=S_{\mathfrak{mmm}}+S_{\mathfrak{mmh}}+S_{\mathfrak{mhm}}+S_{\mathfrak{mhh}}=S_{\mathfrak{mmm}}+2S_{\mathfrak{mmh}}+S_{\mathfrak{mhh}},$$

in reading **(B)**. Converting to reading **(A)** with $\sigma_{XYZ}:=S_{XYZ}/A_{XYZ}$, the number of slot-orderings realising the pattern, which is $3!$ when all three labels agree and $2$ when two do, gives $S_{\mathfrak{mmm}}=6A_{\mathfrak{mmm}}$, $S_{\mathfrak{mmh}}=2A_{\mathfrak{mmh}}$, $S_{\mathfrak{mhh}}=2A_{\mathfrak{mhh}}$, hence

$$\boxed{6A_{\mathfrak{mmm}}+4A_{\mathfrak{mmh}}+2A_{\mathfrak{mhh}}=2d(n-2)}$$

**the display, verbatim.** The coefficients have a one-line meaning: the coefficient of $A_{XYZ}$ is the number of ordered triples with **first index in $\mathfrak m$** that one unordered triple of that pattern produces, namely $(\text{multiplicity of }\mathfrak m\text{ in the pattern})\times 2$, $3\times2=6$, $2\times2=4$, $1\times2=2$, and $0$ for $\mathfrak{hhh}$. They are a multiplicity times the marginal, as the brief anticipated, and are not fittable ([r66](REVIEW_r66.md) shows four perturbed triples missing).

**The $\mathfrak h$-row twin** is the same computation with the roles exchanged:

$$6A_{\mathfrak{hhh}}+4A_{\mathfrak{mhh}}+2A_{\mathfrak{mmh}}=2(N-d)(n-2),$$

which is **exactly what the block states** twelve lines below, under the heading *"On $\{S=0\}$ the block structure is a one-parameter family"*. **Correct as stated.** Its two solved forms are also correct: with $A_{\mathfrak{mmm}}=0$, $A_{\mathfrak{mmh}}=\tfrac12[d(n-2)-A_{\mathfrak{mhh}}]$ and $6A_{\mathfrak{hhh}}=(n-2)(2N-3d)-3A_{\mathfrak{mhh}}$, both re-derived here.

**Adding the two row identities** gives $6\big(A_{\mathfrak{mmm}}+A_{\mathfrak{mmh}}+A_{\mathfrak{mhh}}+A_{\mathfrak{hhh}}\big)=2N(n-2)$, which in reading (B) is $S_{\mathfrak{mmm}}+3S_{\mathfrak{mmh}}+3S_{\mathfrak{mhh}}+S_{\mathfrak{hhh}}=2N(n-2)$, §3's rule.

### 2.3 Hand witness, and it settles the reading

Take $n=6$, $N=15$, $\mathfrak m=\mathfrak{so}(3)\oplus\mathfrak{so}(3)$ (so $d=6$) and $\mathfrak h$ its $9$-dimensional complement, the flipped sign of $S^3\times S^3$, the calibration point the record uses. In the basis $\varphi_{ab}=E_{ab}-E_{ba}$ with $\lVert\varphi_{ab}\rVert=1$, $[\varphi_{12},\varphi_{13}]=-\varphi_{23}$, so each $\mathfrak{so}(3)$ contributes one unordered triple at $T=1$:

| | $A$ (unordered) | $S$ (ordered slots) |
| --- | --- | --- |
| $\mathfrak{mmm}$ | $2$ | $12$ |
| $\mathfrak{mmh}$ | $0$ (a subalgebra: $[\mathfrak m,\mathfrak m]\perp\mathfrak h$) | $0$ |
| $\mathfrak{mhh}$ | $18$ | $36$ |
| $\mathfrak{hhh}$ | $0$ (symmetric pair: $[\mathfrak h,\mathfrak h]\subseteq\mathfrak m$) | $0$ |

$S_{\mathfrak{mhh}}$ independently: $[\mathfrak m,\mathfrak h]\subseteq\mathfrak h$, so $S_{\mathfrak{mhh}}=\sum_{x\in\mathfrak m}\sum_{y\in\mathfrak h}\lVert[x,y]\rVert^2=\sum_{x\in\mathfrak m}\big(2(n-2)-2\big)=6\times6=36$.

- **L114 in reading (A):** $6(2)+4(0)+2(18)=48=2\cdot6\cdot4$. **Holds.**
- **L114 in reading (B):** $6(12)+4(0)+2(36)=144\ne48$. **False by a factor $3$**, the witness the brief asks for.
- **The twin in (A):** $6(0)+4(18)+2(0)=72=2\cdot9\cdot4$. **Holds.**
- **§3's rule in (B):** $12+3(0)+3(36)+0=120=2\cdot15\cdot4$. **Holds.**

**And $S_{\mathfrak{mmm}}=12$ here is the ordered value**, the unordered value is $2$. So [nondegeneracy.md](../findings/nondegeneracy.md)'s calibration figure pins that file to reading (B), and the brief's premise is confirmed by an independent count.

### 2.4 Is total symmetry of $T$ really needed, and where does it enter?

**It enters in three distinct places, at three different strengths, and the block cites it once without saying which.**

| step | what is actually consumed |
| --- | --- |
| $S_{\mathfrak{mhm}}=S_{\mathfrak{mmh}}$, collapsing four slot-patterns to three | symmetry in **slots 2 and 3 only** |
| the unordered reading being defined at all, hence the form $6/4/2$ | **full** symmetry, plus **hollowness** |
| the $1/3/3/1$ form of §3, needing $S_{\mathfrak{mmh}}=S_{\mathfrak{mhm}}=S_{\mathfrak{hmm}}$ | **full** symmetry |

So the raw content (the ordered $1/2/1$ identity), needs only the slot-1 marginal and a slot-(2,3) swap. **The $6/4/2$ display needs full symmetry, and it also needs hollowness, which the block does not cite.** Without $T_{aab}=0$ the pair sum $\sum_{b,c}$ picks up diagonal terms that no unordered-triple sum contains, and the factors $6$ and $2$ are wrong. Both hypotheses are free here (antisymmetry of $c_{abc}$ gives them) so this is a citation gap rather than a defect, but [conventions.md](../findings/conventions.md) already records that *"hollow"* of a $3$-tensor was tabled only for matrices, and this is a fourth consumer.

## 3. Reconciliation with [nondegeneracy.md](../findings/nondegeneracy.md)'s rule

### 3.1 Are they the same identity?

**No, and this is the sharper half of the answer.** They differ in **two** independent ways, and reading the difference as convention alone is a trap.

1. **Different statements.** L114 and its twin are the **two row-restricted** identities; $S_{\mathfrak{mmm}}+3S_{\mathfrak{mmh}}+3S_{\mathfrak{mhh}}+S_{\mathfrak{hhh}}=2N(n-2)$ is their **sum**, the whole-space marginal. L114 is strictly stronger: it resolves $d$ from the total, and the $1/3/3/1$ rule cannot recover it. This is exactly why [run_grading_test.py](../scripts/runs/run_grading_test.py) calls the $1/3/3/1$ rule a *"sum rule"* that *"checks the projector bookkeeping without depending on any one block"*, it is a weaker, block-agnostic check by design.
2. **Different conventions.** L114 is in (A), the $1/3/3/1$ rule in (B).

Derived cold, the $1/3/3/1$ rule is one line: $\sum_{a,b,c}T_{abc}=N\cdot2(n-2)=2N(n-2)$, and splitting all three slots by block gives eight patterns collapsing under full symmetry to $1+3+3+1$. **It is the binomial expansion of $(\mathfrak m+\mathfrak h)^3$ against a constant marginal, and needs full symmetry.** Confirmed.

### 3.2 The conversion factor, per index pattern

$$S_{\mathfrak{mmm}}=6A_{\mathfrak{mmm}},\qquad S_{\mathfrak{mmh}}=2A_{\mathfrak{mmh}},\qquad S_{\mathfrak{mhh}}=2A_{\mathfrak{mhh}},\qquad S_{\mathfrak{hhh}}=6A_{\mathfrak{hhh}}.$$

**Not a global constant**, as the brief predicts: $\sigma=|\mathrm{Sym}_3|/|\mathrm{Stab}|$ is $6$ for the homogeneous patterns and $2$ for the mixed ones. The two mixed patterns share the factor $2$, so a reader who calibrates on $\mathfrak{mhh}$ alone will conclude *"the two readings differ by $2$"* and be wrong on $\mathfrak{mmm}$ by a further $3$, which is precisely the shape of the open *"factor of two"* thread [LEDGER.md](../findings/LEDGER.md) records against [r492](REVIEW_r492.md) on L23's $S_{\mathfrak{mmm}}=280$. **That thread cannot be an ordered/unordered collision on $\mathfrak{mmm}$: the only available factor there is $6$.** It is a different defect and should be re-opened as one.

### 3.3 This closes the [L77](../findings/isotropy-cap.md) dispute, independently

[r609](REVIEW_r609.md) derived $\gamma=S_{\mathfrak{mhh}}$ and [r610](REVIEW_r610.md) derived $\gamma=2S_{\mathfrak{mhh}}$. With $\gamma=X-\mu$, $\mu=\sum_{a,b\in\mathfrak m}\lVert[e_a,e_b]\rVert^2=6A_{\mathfrak{mmm}}+2A_{\mathfrak{mmh}}$ and $X=\sum_{a\in\mathfrak m,b\in\mathfrak h}\lVert[e_a,e_b]\rVert^2=2A_{\mathfrak{mmh}}+2A_{\mathfrak{mhh}}$,

$$\gamma=2A_{\mathfrak{mhh}}-6A_{\mathfrak{mmm}}=S_{\mathfrak{mhh}}-S_{\mathfrak{mmm}}.$$

**Both reviewers were right, each in one reading, and neither made an error.** r610's diagnosis is confirmed. Two consequences the L77 audit did not have:

- **The general law is $\gamma=S_{\mathfrak{mhh}}-S_{\mathfrak{mmm}}$ in the ordered reading**, coefficient $1$ on both terms, against $2S_{\mathfrak{mhh}}-6S_{\mathfrak{mmm}}$ unordered. This is the cleanest form on the record and is another argument for (B).
- **[L36](../findings/isotropy-cap.md)'s Killing block identity $\mu+X=2(n-2)d$ IS L114.** Substituting the two expansions gives $6A_{\mathfrak{mmm}}+4A_{\mathfrak{mmh}}+2A_{\mathfrak{mhh}}=2d(n-2)$ identically. **L114 is a re-derivation of a relation [isotropy-cap.md](../findings/isotropy-cap.md) already proves and uses**, recorded as a separate lemma in a different file with no cross-reference either way. One of the two should become a pointer.

### 3.4 What [conventions.md](../findings/conventions.md) should adopt, **ordered slots, reading (B)**

**Five reasons, in decreasing weight.**

1. **Every measured number on the record is already ordered.** [run_grading_test.py](../scripts/runs/run_grading_test.py) defines `S(setA,setB,setC)` as $\sum_{a\in A,b\in B,c\in C}\langle[X_a,X_b],X_c\rangle^2$, reading (B) exactly. Adopting (A) would falsify $S_{\mathfrak{mmm}}=12$, $21.5213$, $25.6525$, $17.0000$, $84$, $60.75$, the $96/90/360/120$ table in [bounds.md](../findings/bounds.md), $S_{\mathfrak{hhm}}=4(n-4)$ at padded $W_{\mathbb{CP}^2}$, and L23's closed form $S_{\mathfrak{mmm}}=(N-r)[2(n-2)-4(n-1)r/N]$, which [LEDGER.md](../findings/LEDGER.md) states is *"its normalisation over ordered distinct triples"*. Adopting (B) falsifies **no number anywhere**.
2. **It is the convention [conventions.md](../findings/conventions.md) already declares.** *"Sums over pairs are over ORDERED pairs unless the line says otherwise."* A triple convention contradicting the file's own pair convention is a trap by construction, and it is the same trap the file settled for $t$, as [diagonal-half.md](../findings/diagonal-half.md) notes at line 406.
3. **Reading (B) needs no combinatorics to define.** It is a block-restricted contraction, defined for any triple of subspaces, requiring neither distinctness of indices nor a stabiliser count, and it extends to the three-block split $\mathfrak m/\mathfrak h/\mathfrak r$ with no new cases. Reading (A) is defined only because $T$ is hollow and totally symmetric, so the notation silently carries two hypotheses.
4. **The identities become one Pascal row.** $1/2/1$ on $\mathfrak m$-rows, $1/2/1$ on $\mathfrak h$-rows, $1/3/3/1$ in total, against $6/4/2$, $6/4/2$ and $6/6/6/6$. The twin becomes manifest instead of needing a separate display.
5. **The $\gamma$ law simplifies** to $\gamma=S_{\mathfrak{mhh}}-S_{\mathfrak{mmm}}$, and $\mu=S_{\mathfrak{mmm}}+S_{\mathfrak{mmh}}$, $X=S_{\mathfrak{mmh}}+S_{\mathfrak{mhh}}$, all unit coefficients.

**The row to add to [conventions.md](../findings/conventions.md)'s object table**, concrete enough to apply:

> $S_{XYZ}$, for a splitting $\mathfrak{so}(n)=\mathfrak m\oplus\mathfrak h$ and an orthonormal basis, $S_{XYZ}=\sum_{a\in X,b\in Y,c\in Z}T_{abc}$ with $T_{abc}=\langle[v_a,v_b],v_c\rangle^2$, the sum over **ORDERED slots**, matching the file's ordered-pairs rule and the record's instrument [run_grading_test.py](../scripts/runs/run_grading_test.py). Total symmetry of $T$ makes it depend on the label multiset only. **The unordered-triple count $A_{XYZ}$ differs per pattern, not globally**: $S=6A$ at $\mathfrak{mmm}$ and $\mathfrak{hhh}$, $S=2A$ at $\mathfrak{mmh}$ and $\mathfrak{mhh}$. [bounds-relaxations.md](../findings/bounds-relaxations.md) and [isotropy-cap.md](../findings/isotropy-cap.md) were written in $A$ and are converted; the factor-$2$ dispute at [L77](../findings/isotropy-cap.md) was this and nothing else. *(Paths in this quoted row are written relative to [reviews/](.); relativise them to [findings/](../findings/) on paste.)*

**Exactly what changes if it is adopted, six displays, no numbers.**

| file | now | becomes |
| --- | --- | --- |
| [bounds-relaxations.md](../findings/bounds-relaxations.md) L114 | $6S_{\mathfrak{mmm}}+4S_{\mathfrak{mmh}}+2S_{\mathfrak{mhh}}=2d(n-2)$ | $S_{\mathfrak{mmm}}+2S_{\mathfrak{mmh}}+S_{\mathfrak{mhh}}=2d(n-2)$ |
| same, the twin | $6S_{\mathfrak{hhh}}+4S_{\mathfrak{mhh}}+2S_{\mathfrak{mmh}}=2(N-d)(n-2)$ | $S_{\mathfrak{hhh}}+2S_{\mathfrak{mhh}}+S_{\mathfrak{mmh}}=2(N-d)(n-2)$ |
| same, the solved forms | $S_{\mathfrak{mmh}}=\tfrac12[d(n-2)-S_{\mathfrak{mhh}}]$, $S_{\mathfrak{hhh}}=\tfrac16[(n-2)(2N-3d)-3S_{\mathfrak{mhh}}]$ | $S_{\mathfrak{mmh}}=d(n-2)-\tfrac12S_{\mathfrak{mhh}}$, $S_{\mathfrak{hhh}}=(n-2)(2N-3d)-\tfrac32S_{\mathfrak{mhh}}$ |
| same, the L36 mass bound | $4d^2/n-2d\le2S_{\mathfrak{mmh}}\le(n-2)d$ | $4d^2/n-2d\le S_{\mathfrak{mmh}}\le(n-2)d$ |
| same, the $\gamma$ law | $\gamma=2S_{\mathfrak{mhh}}$, general $2S_{\mathfrak{mhh}}-6S_{\mathfrak{mmm}}$ | $\gamma=S_{\mathfrak{mhh}}$, general $S_{\mathfrak{mhh}}-S_{\mathfrak{mmm}}$ |
| [isotropy-cap.md](../findings/isotropy-cap.md) L77 and [INDEX-results.md](../findings/INDEX-results.md) row 77 | $\mu=2S_{\mathfrak{mmh}}$, $X=2S_{\mathfrak{mmh}}+2S_{\mathfrak{mhh}}$, $\gamma=2S_{\mathfrak{mhh}}$ | $\mu=S_{\mathfrak{mmm}}+S_{\mathfrak{mmh}}$, $X=S_{\mathfrak{mmh}}+S_{\mathfrak{mhh}}$, $\gamma=S_{\mathfrak{mhh}}-S_{\mathfrak{mmm}}$ |

**Two things that do NOT change, and both were checked.** The $\theta$ bounds in [bounds-relaxations.md](../findings/bounds-relaxations.md) ($\theta\le\sum\lambda^3+\tfrac32\lambda_1b^2(n-2)d+\tfrac12\lambda_1^3(n-2)(2N-3d)$), are stated through the **mass caps** $\mu\le(n-2)d$ and $6A_{\mathfrak{hhh}}\le(n-2)(2N-3d)$, which are convention-free numbers; their $\tfrac32$ and $\tfrac12$ arise from $\theta=\operatorname{tr}W^3+3\sum^{\text{unord}}\lambda_a\lambda_b\lambda_cT_{abc}$ and are **unaffected**. And [bounds.md](../findings/bounds.md)'s $\theta=\operatorname{tr}W^3+3\sum\lambda_a\lambda_b\lambda_ct_{abc}$ is the unordered form of $\langle W,W^\#\rangle=\tfrac12\sum^{\text{ord}}\lambda\lambda\lambda T$; it is a **triple sum, not a block mass**, so the $S_{XYZ}$ convention does not touch it, but the line should say *unordered* since the file's default is ordered.

## 4. The withdrawn inference, both halves

### 4.1 The withdrawal is correct, and there is a shorter reason than the block's

**The block's reason is sound.** With $A_{\mathfrak{mmm}}=0$ the identity pins only $2A_{\mathfrak{mmh}}+A_{\mathfrak{mhh}}=d(n-2)$, and the split is free. The sign claim checks: with $\mathfrak m$ negative and $\mathfrak h$ non-negative, $(mmh)$ carries $\lambda_a\lambda_b\lambda_c>0$ and $(mhh)$ carries $<0$, so the two blocks enter $\theta$ with opposite signs and the released $6A_{\mathfrak{mmm}}$ of budget can be absorbed by $A_{\mathfrak{mhh}}$, which **lowers** $\theta$. **Confirmed.**

**One line settles it more cleanly, and it is not in the block.** $\{S_{\mathfrak{mmm}}=0\}$ is a **constraint**: the maximum of $\theta$ over a smaller feasible set cannot exceed the maximum over the larger one. So $S=0$ can never *mechanically raise* $\theta$ in any optimisation reading, whatever the mass bookkeeping does; and at a fixed configuration $\theta$ is simply what it is, so there is nothing to raise. **The same file already carries the numerical form of this two paragraphs above**, [post F17](../findings/bounds-relaxations.md): imposing $S=0$ makes the $n=6$ LP maximiser **infeasible** and drops the optimum from $1.5305$ to $1.306498$. *The answer was in the block's own file, twenty lines up.*

**This also refutes [r65](REVIEW_r65.md)'s rescue.** r65 wrote that the rider is *"right for the relaxation … a statement about the LP optimum"*. It is wrong there too, for the monotonicity reason, and F17's own numbers contradict it.

### 4.2 The provenance clause is FALSE

> *"Both reviewers rejected the inference while confirming the identity."*

- [r66](REVIEW_r66.md), line 19: *"**CONFIRMED**; the inference drawn from it is **not** … 'S = 0 pushes mass into (+−−)' does not follow from it."*, **rejected**.
- [r65](REVIEW_r65.md), line 127: *"The qualitative rider … is **right** for the relaxation; it is a statement about the LP optimum, not about genuine Weyl tensors, and should be phrased that way."*, **accepted, with a rephrasing request**.

**One reviewer rejected it, one accepted it.** The sentence should read *"Reviewer 66 rejected the inference; Reviewer 65 accepted it for the relaxation, and that rescue fails too, a constraint cannot raise a maximum."* The *identity* half of the provenance is **TRUE**: r65 C6(b) *"CONFIRMED, multiplicities correct"* and r66 C6(b) *"CONFIRMED; the identity and its multiplicities are exactly right"*, both independent, both explicit about the multiplicities, and r65 line 127 states the unordered reading in so many words, **so the reading was on the record from the day the block was written and was never carried into the block.** Commit `d1fc8810` is the block's origin and its message repeats the same two claims.

### 4.3 Nothing on the record still cites the withdrawn inference

Swept [findings/](../findings/), [results.md](../results.md), [plan.md](../plan.md), [report/](../report/) and [ATTEMPTS.md](../ATTEMPTS.md) for *"frees"*, *"mechanically"* and the $(+--)$ reallocation. The **only** occurrence is the withdrawal sentence itself at line 134. The prior commit `640c2013` (*"S=0 raises theta mechanically, so no mass argument can bound it"*), was superseded by `d1fc8810` and leaves no live consumer. **Clean.**

## 5. The evidence's status

**The derivation succeeds, so the identity is a theorem and the numbers are a check.** It holds at every $n\ge3$, every $d$, and for **every** orthogonal two-block splitting of $\mathfrak{so}(n)$, no criticality, no Weyl-ness, no eigenvalue interpretation, no isotropy. This is what [r65](REVIEW_r65.md) already said (*"holds for every subspace, isotropic or not"*) and the block does not.

**Does the label match?** The **label does**, it is filed as *Lemma* L114, and a lemma is what it is. **The wording does not.** *"Exact to $10^{-13}$ at $n=5,6,7$"* is a measurement's sentence, *"the block-mass identity **stands**"* is a measurement's hedge, and **the file carries no proof**, *"total symmetry of $T$ and the row marginal $2(n-2)$ give"* gestures at a two-line derivation without writing it, which is why nobody noticed that the sentence is only true under a convention the file never names. The repair is the two lines of §2.2 plus the convention, after which $10^{-13}$ at three dimensions becomes what it should be: a check.

This is the fifth measured table promoted to a corollary in this round of audits, so the outcome is expected rather than surprising.

## 6. Defect list

| # | defect | severity |
| --- | --- | --- |
| 1 | **The convention is unstated and collides with the rest of the record.** L114 is in unordered triples; [nondegeneracy.md](../findings/nondegeneracy.md), [bounds.md](../findings/bounds.md), [LEDGER.md](../findings/LEDGER.md) and [run_grading_test.py](../scripts/runs/run_grading_test.py) are in ordered slots. **This is the live collision the [L77](../findings/isotropy-cap.md) audit traced here.** Fix per §3.4. | **high** |
| 2 | *"Both reviewers rejected the inference"* is **false**, [r65](REVIEW_r65.md) accepted it. | **high** |
| 3 | **No proof, and the wording is a measurement's.** Two lines fix it. | medium |
| 4 | **L114 is [L36](../findings/isotropy-cap.md)'s $\mu+X=2(n-2)d$**, re-derived in another file with no cross-reference either way. | medium |
| 5 | **Hollowness of $T$ is load-bearing for $6/4/2$ and uncited**; total symmetry is cited without saying which of its three uses is meant (§2.4). | low |
| 6 | **The $\mathfrak h$-row twin is named in the heading but stated only twelve lines below**, under a different heading and a different hypothesis ($S=0$). The lemma's own block should carry it. | low |
| 7 | **Scope understated.** The identity needs no criticality and no Weyl tensor; $\mathfrak h=\mathfrak m^\perp$ (kernel included) is assumed and never said, and [conventions.md](../findings/conventions.md) warns that $\mathfrak m$ carries three senses and $\mathfrak h=E_{\max}$ in one of them, under which the display is **false**, an $\mathfrak r$ block being unaccounted. | medium |
| 8 | The **row marginal $2(n-2)$ carries no result number** though four results consume it. | low |
| 9 | [INDEX-results.md](../findings/INDEX-results.md) row 114 reads *"Gate 2: no verdict on the record"*, which is right, while the block claims reviewer confirmation, the two are consistent but read as contradictory. | low |
| 10 | Two empty `(#)` anchors survive in [bounds-relaxations.md](../findings/bounds-relaxations.md) (lines 314 and 408), and one in [isotropy-cap.md](../findings/isotropy-cap.md) at line 382. Outside L114's block. | low |
| 11 | The open *"factor of two"* thread at [LEDGER.md](../findings/LEDGER.md) against [r492](REVIEW_r492.md) on L23's $S_{\mathfrak{mmm}}=280$ **cannot** be an ordered/unordered collision, the only factor available on $\mathfrak{mmm}$ is $6$. Re-open it as a distinct defect. | medium |

## 7. Blocked on computation, nothing

Every claim here is derived or is a hand computation in $\mathfrak{so}(6)$. **No item in this brief needed a run**, and the block's $10^{-13}$ figures were neither reproduced nor relied on.

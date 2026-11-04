# REVIEW r466, Observation L102 (route-a)

**Reviewer:** r466 (independent; twin [r465](REVIEW_r465.md) deliberately unread)
**Claim under audit:** [Observation L102](../findings/route-a.md), $M_{W_1}\cdot\Pi_{\ker}Q(W_1)=0$, residual $\le8.5\times10^{-15}$ at $n=12,14,16$, control $0.33$.
**Standing rule:** analysis only ([analysis-only.md](../.claude/rules/analysis-only.md)). **Nothing was run for this review**, every number quoted below is read off the record's own logs and scripts, and the two derivations are by hand.

## Verdict, PLAUSIBLE

Split by what is being asserted, because the block asserts three inequivalent things under one display:

| reading | verdict |
| --- | --- |
| as a **measurement** at $n=12,14,16$ over random $W_1\in V_{1/3}$ | **CONFIRMED**, the evidence exists, is at the dimensions named, has a non-vacuous control, and is stronger than the block reports |
| as an **identity for every $W_1\in V_{1/3}$** at those $n$ | **PLAUSIBLE**, 40 samples of a cubic map on a $136$-dimensional space is good evidence and no proof; one cheap test could still refute it and has never been run |
| as an input to [Observation L22](../findings/route-a.md) **for every $n\ge12$** | **REFUTED as support**, zero-padding, the only argument offered past $n=16$, gives nothing for this statement; see finding 6 |

**The label `Observation` is right. The heading is not**: it carries no quantifier over $W_1$, and it names the weaker of the two facts the record measured. **And the record contains three misstatements of its own result, one of which closed the proof search on a misreading** (findings 3–5).

## Findings

### 1. $W_1$ is one object per $n$, but the file uses the same letter for a different tensor

$W_1$ in L102 is **not** a particular tensor: it ranges over $V_{1/3}$, the $\tfrac13\theta^*$-eigenspace of $F_u=L_u$ at the $\mathbb{CP}^2$-type competitor $u$, and the statement is universally quantified over it. That is well posed, and the quantifier is present in the body (*"For every $W_1\in V_{1/3}$"*), but **absent from the heading**, which is what [INDEX-results.md](../findings/INDEX-results.md) row 102 and [LEDGER.md](../findings/LEDGER.md) row 151 propagate.

**The collision.** [Observation L103](../findings/route-a.md), 350 lines earlier in the same file, defines $W_1$ as *one specific tensor* (the balanced $S^6\times S^6$ operator at $n=12$) and line 289 uses $W_1,W_2$ as free variables in a Lipschitz bound. Three meanings, one letter, one file. [conventions.md](../findings/conventions.md) already warns that *"the letter $M$ carries two objects"*; $W_1$ now needs the same warning, or L102's heading needs *"for every $W_1$ in the $\tfrac13\theta^*$-eigenspace"* spelled out.

$V_{1/3}$ is a genuine continuum, of dimension $36,78,136,300$ at $n=8,10,12,16$ (from [p0_neg.log](../agent_logs/p0_neg.log), [p0_opid4.log](../agent_logs/p0_opid4.log), [p0_joint3.log](../agent_logs/p0_joint3.log)). Those four values fit $\dim V_{1/3}=(2n-7)(n-4)$ exactly, which predicts $210$ at $n=14$.

### 2. The evidence is real, at the dimensions claimed, with a control that can fail

The residual $8.5\times10^{-15}$ traces to [review_r21_report.md](../agent_logs/review_r21_report.md) line 24, not to any committed pipeline:

> $M_{W_1}q(W_1)=0$ for every $W_1\in V_{1/3}$ … Relative residual $\le2.2\times10^{-15}$ over 40 random $W_1$ at $n=12$, $\le7.5\times10^{-15}$ at $n=14$ and $\le8.5\times10^{-15}$ at $n=16$, against a control (the same quantity with $W_1$ drawn from $\ker F_u$) of $0.33$.

**The control is legitimate**, same code path, same projector, $W_1$ drawn from the wrong eigenspace, answer $0.33$. It could have failed and did not, which is what the screening rule asks of a screen. **Sampling is the right instrument here**: the map $W_1\mapsto M_{W_1}\Pi_{\ker}Q(W_1)$ is a homogeneous *cubic* map, so a nonzero one vanishing at 40 independent Gaussian draws is a measure-zero coincidence. The gap between the measurement and the assertion is smaller than "three dimensions, asserted for all" suggests, **for fixed $n$**.

**And the record understates itself**: the same line reports the **unsymmetrised trilinear** form $\Pi_{\ker}F(x,\Pi_{\ker}F(y,z))=0$ for *all triples* $x,y,z\in V_{1/3}$ at $1.9\times10^{-15}$. That is strictly stronger than the displayed diagonal identity and is what finding 3 shows the whole cluster reduces to.

### 3. The identity is one subspace orthogonality, derived here, and it subsumes all three of the record's readings

Write $U=V_{1/3}$, $Z=\ker F_u$, $\Pi_Z$ its projector, $x\circ y$ the polarisation of $Q$ ([conventions.md](../findings/conventions.md)), so $Q(x)=x\circ x$ and $T(x,y,z)=\langle x\circ y,z\rangle$ is symmetric. With $M_{W_1}K=\Pi_Z(W_1\circ K)$ and $b(W_1)=\Pi_ZQ(W_1)$, for $K\in Z$

$$\langle M_{W_1}b,K\rangle=\langle W_1\circ b,K\rangle=T(W_1,b,K)=\langle b,W_1\circ K\rangle=\langle\Pi_ZQ(W_1),\Pi_Z(W_1\circ K)\rangle .$$

So $M_{W_1}b=0$ says exactly $b(W_1)\perp\mathop{\mathrm{range}}(M_{W_1})$, and the polarised version r21 also measured is

$$\boxed{\ \Pi_Z\big(V_{1/3}\circ V_{1/3}\big)\ \perp\ \Pi_Z\big(V_{1/3}\circ\ker F_u\big)\ }$$

**an orthogonality between two fixed subspaces of $\ker F_u$**, with no free parameter. Equivalently, moving the projector to the other side, $\Pi_{V_{1/3}}\big(\ker F_u\circ\Pi_{\ker}Q(W_1)\big)=0$, which puts L102 in the same family as the coupling table's measured row $T(W_1,K,N)=0$.

This single statement implies, in one step each: (i) the displayed L102; (ii) the hard-case condition, since a top eigenvector of $M_{W_1}$ with $\lambda_{\max}\ne0$ lies in $\mathop{\mathrm{range}}(M_{W_1})\subseteq\Pi_Z(U\circ Z)$; (iii) the **cross-pair** bilinear identity $\langle\Pi_{\ker}Q(W_1),\mathop{\mathrm{top}}(W_1')\rangle=0$ of [route-a.md](../findings/route-a.md) line 381; and (iv) the cross-pair annihilation $M_{W_1}b(W_1')=0$, which the record never states.

### 4. "Not a subspace condition" is false, and it is what closed the proof search

[ATTEMPTS.md](../ATTEMPTS.md) §*Characterising the hard-case identity* is titled *"a bilinear orthogonality, **not a subspace condition**"*, and its table refutes the third reading:

> $\mathop{\mathrm{span}}(b)\perp\mathop{\mathrm{span}}(\text{tops})$ as fixed subspaces (**No**), neither saturates: $48$ dimensions from $24$ samples and $24$ from $24$, both growing linearly

**That is a non sequitur, and the run's own output says so.** [p0_opid4.log](../agent_logs/p0_opid4.log) ends both dimensions with

> `dim span(top planes) = 48 from 24 samples   dim span(b) = 24   ambient ker = 483` … `max |<span(b), span(tops)>| = 1.669e-15   -> the two spans are ORTHOGONAL`

The spans *not saturating $\ker F_u$* is not evidence against a subspace condition, it is **required** by one, since two orthogonal subspaces of $Z$ cannot both fill it. The verdict inverted its own datum. The consequence is not cosmetic: on the strength of that table [route-a.md](../findings/route-a.md) line 381 records the target as *"a narrower target than any of the above addressed"* and the search as **"Recorded as blocked; a sixth symmetry argument is not worth attempting."** The correct reading, finding 3's boxed line, is a **fusion-rule–shaped statement about a Peirce decomposition**, exactly the kind of thing the record's own literature proves (Krasnov–Tkachev Prop. 6.7 and [Tkachev's Theorem B](../references/tkachev-2024-metrized-slides/notes.md), $A_c(\tfrac12)A_c(\tfrac12)\subset A_c(\tfrac12)^\perp$, proved by third and fourth variations). **The block should be reopened, with the boxed statement as the target.** *I did not prove it: the Tkachev/Krasnov–Tkachev fusion law is driven by degeneracy at $\lambda=\tfrac12$, and $V_{1/3}$ is strictly inside the second-order-negative range, so that particular mechanism does not transfer.*

### 5. "Not annihilated by the operator" contradicts the record's own measurement

[ATTEMPTS.md](../ATTEMPTS.md) line 1678 records, as a correction:

> And the hard case is $b=\Pi_{\ker}Q(W_1)$ orthogonal to the **top eigenspace**, not annihilated by the operator.

and [p0_operator_identity.py](../scripts/pipelines/p0_operator_identity.py), the script whose docstring is titled *"Is $M_{W_1}\cdot\Pi_{\ker}Q(W_1)=0$ an operator identity with a structural cause?"*, **never computes $\lVert M_{W_1}b\rVert$**. It measures `|<b, top eigenspace>| / |b|` only. So the committed script named after L102 does not test L102; the only test of L102 as displayed is an uncommitted reviewer script from an earlier cycle. Annihilation **is** what r21 measured, at $2.2\times10^{-15}$ (finding 2), and it is strictly stronger than the top-eigenspace condition. **One of the two statements is wrong on the record and it is the later one.**

*Nomenclature, while there:* "hard case" is a misnomer for what the closed form uses. r21's split needs $b$ to be an **eigenvector** of $M_{W_1}$; the trust-region subproblem is globally solvable in every case, hard or not, so *"a hard-case trust-region problem, globally solvable rather than ascended"* names the wrong reason. What buys $V(t)$ is the eigenvalue being **zero**, with $b$ an eigenvector at $\mu>0$ the value rises to $\max_c[ca+t(c^2\mu+\lambda(1-c^2))]$; with $b$ not an eigenvector at all the only surviving bound is $a+t\lambda=\sqrt{5/6}+2t/3$, which is $1.246$ against $V(0.5)=0.913$. **L102 is load-bearing in the strong sense: its failure does not weaken the frontier bound, it deletes it.**

### 6. Three dimensions asserted for all, and padding is not evidence *for this statement*

[route-a.md](../findings/route-a.md) line 410 offers zero-padding as the argument past $n=16$: *"zero-padding the $n=12$ pair into $m=14,16,20,24$ preserves everything exactly, which gives monotonicity in $n$ but only as a lower bound."* r21's own wording is careful, it pads **the optimal pair $(W_1^*,K^*)$**, giving $V_n(t)$ monotone non-decreasing in $n$, a statement about the *constants*.

**For L102 padding gives nothing, and cannot.** L102 is universally quantified over $V_{1/3}(m)$, and the padded image of $V_{1/3}(12)$ is a $136$-dimensional subspace of a $(2m-7)(m-4)$-dimensional space, $300$ at $m=16$, $792$ at $m=24$. Padding verifies the claim on a set of measure zero in the space it quantifies over. **The hedge "monotonicity in $n$ as a lower bound" is true of the constants and is not applicable to the vanishing**, yet both [route-a.md](../findings/route-a.md) line 410 and [Observation L22](../findings/route-a.md)'s *Scope* attach it to the vanishing. So the honest range for L102 is **$n\in\{12,14,16\}$, full stop.**

**Odd $n$ was never tested, and for L102 it looks harmless.** $u$ is a padded $\Lambda^2\mathbb R^4$ object and padding commutes with $Q$ ([conventions.md](../findings/conventions.md)); every Peirce multiplicity in the record is a polynomial in $n$ that stays integral at odd $n$, $\dim V_{1/3}=(2n-7)(n-4)$, $\dim V_{1/2}=4n-14$, $\dim V_{-1}=2$, $\dim V_{-1/2}=4n-16$, all reproducing $n=8,10,12,16$, so no parity obstruction is visible. **Parity bites one step later, in [Observation L22](../findings/route-a.md), not here**: that bound charges $\sup\lvert P\rvert$ on $\ker F_u$ at $\theta_0(n)$, justified in [ATTEMPTS.md](../ATTEMPTS.md) by *"the kernel contains the sphere product itself"*, and the **balanced** sphere product exists only at even $n$. At odd $n$ the diagonal maximum is $\Theta_n$ with $\Theta_n^2=2(n-1)(n-3)/((n+1)(n-2))$, marginally below $\theta_0(n)^2$ ([conventions.md](../findings/conventions.md)), so the constant is probably safe and its stated justification is not.

### 7. The other three vanishings have *less* dimensional support than L102, not more

The brief asks whether L102 is the only one of the four with numerical support. **It is not, it is the only one with support at the dimensions the record names.** Locating each:

| vanishing | statement | where measured |
| --- | --- | --- |
| $T(W_1,W_1',N)$, three negative eigenspaces | $\Pi_N Q(V_{1/3})=0$ | exhaustive on the $770\times770$ build at $n=10$; random $x$ at $n=8,10$ in [p0_neg.log](../agent_logs/p0_neg.log), $\le3.7\times10^{-16}$ |
| $T(W_1,W_1',W_1'')$, i.e. $P\equiv0$ on $V_{1/3}$ | $\Pi_{V_{1/3}}Q(V_{1/3})=0$ | same $n=10$ table, $\le8\times10^{-16}$ |
| $T(W_1,K,N)$ | $\Pi_N(V_{1/3}\circ\ker F_u)=0$ | same $n=10$ table, $\le6\times10^{-16}$ |
| **L102** | finding 3's boxed line | $n=12,14,16$ (r21), $n=10,12$ (opid/bilin logs) |

I could find **no run of the first three above $n=10$**. So [Observation L22](../findings/route-a.md)'s relabelling box (*"this one's four vanishings are measured at $n=12,14,16$"*) and [r463](REVIEW_r463.md)'s hypothesis list both over-state the range of the three, while [route-a.md](../findings/route-a.md)'s own line 370 calls all four *"exhaustively verified numerics"* when only the $n=10$ table is exhaustive. **The correct statement of L22's dimensional hypothesis is $n=10$ for three of its four inputs.** *This strengthens r463's verdict rather than contradicting it.*

### 8. Vacuity, the two cheapest questions were posed by the record and never answered

Neither side of the product is trivial: $\lVert b\rVert$ reaches $\sup_KT(W_1,W_1,K)=\sqrt{5/6}$ and $\lambda_{\max}(M_{W_1^*})=2/3$ with $\lambda_{\min}=-2/3$ ([review_r21_report.md](../agent_logs/review_r21_report.md)), so neither factor vanishes and the identity is not empty. The remaining vacuity route (**$M_{W_1}$ having so large a kernel that any $b$ lands in it**), is exactly item 2 of [p0_operator_identity.py](../scripts/pipelines/p0_operator_identity.py)'s docstring (*"is the kernel large and this vector unremarkable inside it? The kernel dimension against the ambient dimension says which"*), and **the script never computes it**; the variable that would have held it (`kerdims`) holds the top-eigenspace dimension instead. Item 3 (*"whether $u$ is needed"*, test at a non-critical base point) is likewise posed and never implemented.

**The cross-pair data already blocks the cheap version of vacuity**: a large $\ker M_{W_1}$ explains $M_{W_1}b(W_1)=0$ but says nothing about $b(W_1')$ for $24$ other draws, and the orthogonality survives all $24\times24$ pairs at $1.3\times10^{-15}$.

**The decisive test, named and not run.** Finding 3's form forces $\dim\Pi_Z(U\circ U)+\dim\Pi_Z(U\circ Z)\le\dim\ker F_u$, $483$ at $n=10$, $1161$ at $n=12$. Both spans were still **growing linearly** at the record's 24 samples ($24$ and $48$). Two one-line additions to an existing script decide it: (a) $\mathop{\mathrm{rank}}(M_{W_1})$ for a single $W_1$ at $n=10$, the $483\times483$ eigendecomposition is already computed there, and any rank above $483-\dim\Pi_Z(U\circ U)$ refutes L102 outright; (b) push the sample count until both spans saturate and check the sum against $\dim\ker F_u$. **Outcome if the sum exceeds the ambient dimension: L102 is false and the frontier branch of L22 goes with it. If both saturate well short: the two pieces are a genuine refinement of the Peirce component $\ker F_u$, and that refinement is the theorem to prove.** *No such run was made for this review.*

### 9. Two internal inconsistencies inside the L102 block

- *"The frontier has an exact closed form, and it is the **true maximum** rather than an estimate"* against, four paragraphs later, *"the bound overshoots the truth by a factor $1.40$"*. Both are defensible only if the first is read as being about $V(t)$ alone and the second about $\gamma_{\text{coupled}}$; as written the block asserts exactness of the thing it then measures as $40\%$ loose.
- *"The remaining loss is taking $\sup$ over $W_1$ separately in the two terms while the same $W_1$ must serve both"*, **the wrong variable.** r21's item 3 establishes that $\sup a$ and $\sup\lambda$ are attained at the *same* $W_1^*$, so there is no loss over $W_1$; the loss is over $K$, because $\gamma_{\text{coupled}}$'s third term charges $\sup_K\lvert P(K)\rvert=\theta_0(n)$ at a $K$ that is not the one realising $A$ and $B$.

## What breaks if L102 is false

**Contained, and the record already says so.** [LEDGER.md](../findings/LEDGER.md) row 249 records *"[L22] relabelled (nothing cites it), no radius"*, and [r463](REVIEW_r463.md)/[r464](REVIEW_r464.md) established that [Lemma L20](../findings/route-a.md), this programme's one unconditional tube theorem, invokes neither L22 nor L102. So the blast radius is: **L102 → the frontier branch of [Observation L22](../findings/route-a.md) → the repair of Nienhaus's Theorem 4.17 near $\alpha\approx\tfrac13$ → the extension of his localization Theorem 4.19 past $n=11$.** All of that is service to an external theorem, and L22 is in any case circular against Conjecture A (both branches charge the sphere-product constant). **Nothing on this programme's own chain moves.**

## Hypotheses L102 actually needs, and the label it deserves

- $n\in\{12,14,16\}$, **not** $n\ge12$, and padding does not extend it (finding 6).
- $W_1$ ranging over $V_{1/3}(F_u)$ at the $\mathbb{CP}^2$-type competitor $u$; genericity of the 40 draws.
- Nothing else. The statement is intrinsic to the algebra $(\mathcal W_n,\circ)$ and its Peirce decomposition at $u$; it needs neither Conjecture A nor any constant.

**Label:** `Observation` is correct and should stay. **Heading repair:** state the quantifier and prefer the subspace form, e.g. *"Observation L102, $\Pi_{\ker}Q(V_{1/3})\perp\Pi_{\ker}(V_{1/3}\circ\ker F_u)$, equivalently $M_{W_1}\Pi_{\ker}Q(W_1)=0$ for every $W_1\in V_{1/3}$; residual $\le8.5\times10^{-15}$ at $n=12,14,16$, control $0.33$"*. **Reopen** the proof block closed by finding 4.

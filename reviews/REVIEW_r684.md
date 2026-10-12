# Review r684, Lemma L88, $\dim\mathrm{Sym}^2=65$, $\dim\Lambda^2=24$, and the $24$ as gauge

**Reviewer B of an independent pair on identical briefs. Target: [findings/sym3-blocks.md](../findings/sym3-blocks.md) line 104, `#### Lemma L88, $\dim\mathrm{Sym}^2=65$, $\dim\Lambda^2=24$, and the $24$ are gauge`, with the `## The unknown count is real symmetric` section beneath it.**

## Verdict: GAP

**All three numbers are correct, and I re-derived every one of them by hand in four lines from the multiplicity multiset alone, the block needs no run at all.** **And the question the brief says the record most needs settled is settled affirmatively: the certificate's $47$ Hermitian parameters are entirely consistent with this block's $65$, and with [L86](../findings/sym3-blocks.md)'s $36$.** The three are one construction read at two levels, $\sum m^2$, $\sum\binom{m+1}2$ and $\sum\binom m2$ before the orbit constraint gives $89/65/24$, and after it gives $47/36/11$. I verified the restricted shape block-for-block against [n5_certificate.json](../scripts/runs/n5_certificate.json)'s own `shape` field.

What fails is the block's account of itself, on four counts: **"Weyl integration settles it" is a run, where a one-line hand derivation exists and is already recorded in this same file**; **$89$ is a formal identity presented as a third number**; **"gauge" is true of the linear map and false of the PSD cone**, which is the one place the word could mislead a builder; and **the $O(5)$-versus-$SO(5)$ step is unstated**, its third unstated sighting in this file. **Provenance is clean.**

## Readings adopted

| symbol | reading I use | why |
| --- | --- | --- |
| $(\lambda_1,\lambda_2)$ | **$e$-coordinates**, forced by $(2,2)_{35}=\mathcal W_5$ | the $\omega$-basis reading makes $(4,2)$ dimension $260$, failing the table. The block does not say; [L83](../findings/sym3-blocks.md)'s note already flags this |
| $m_\lambda$, "the measured multiplicities" | the multiplicity column of [L83](../findings/sym3-blocks.md)'s table: twelve blocks at $m=1$, nine at $m=2$, one at $m=3$, two at $m=4$ | the block restates the multiset without citing [L83](../findings/sym3-blocks.md) |
| $\mathrm{Sym}^2(U)^{O(5)}$ | $O(5)$-invariant **symmetric bilinear forms** on $U=\mathrm{Sym}^3\mathcal W_5$, over $\mathbb R$ | this is the block's own gloss, "an invariant quadratic form", and it is the right object |
| block extent | a `####` block runs to the next `####`, absorbing any `##` between | L88 has no content otherwise; flagged because two audits have read this boundary two ways |
| $\mathbb Q(i)$ basis | a $\mathbb C$-basis $c=Rr$ of $U_{\mathbb C}$ with $R\in GL$ **not** real | this is exactly reviewer 204's point, and it is what makes the coordinate question non-trivial |

**The three conventions repaired in [conventions.md](../findings/conventions.md) on 2026-09-04 ($\theta_0(n)$, $\Theta_n$, $S_{XYZ}$), do not appear in L88 and do not bear on it.** The one convention entry that does bear is **"THE LETTER $B$ MEANS TWO THINGS, live"**, since the real-type argument runs through $B(X,Y)=-\tfrac12\operatorname{tr}(XY)$ on $\mathfrak{so}(5)$ rather than the Killing form; the block inherits the section header's normalisation and is consistent with it.

## 1. The derivation, by hand, with no Weyl integration

Write $U=\mathrm{Sym}^3(\mathcal W_5)=\bigoplus_\lambda M_\lambda\otimes V_\lambda$ over $\mathbb R$, $m_\lambda=\dim M_\lambda$.

**Step 1, every $V_\lambda$ here is of real type.** $\mathfrak{so}(5)\cong\mathfrak{sp}(4)$ has quaternionic irreducibles exactly at half-integral highest weight (the spin representations of $\mathrm{Spin}(5)$); every constituent of $\mathrm{Sym}^3$ of a tensor representation is integral, so the Frobenius–Schur indicator is $+1$ throughout. **The block states this and it is correct.** *It is load-bearing rather than decorative: indicator $-1$ would make the invariant form on $V_\lambda$ antisymmetric and would swap that block's contribution between $\mathrm{Sym}^2$ and $\Lambda^2$.*

**Step 2, Schur.** Real type gives $\mathrm{End}_{O(5)}(V_\lambda)=\mathbb R$ and a unique invariant bilinear form $b_\lambda$ on $V_\lambda$, which is **symmetric**. Hence

$$(U^*\otimes U^*)^{O(5)}=\bigoplus_\lambda\big(M_\lambda^*\otimes M_\lambda^*\big)\otimes\mathbb R\,b_\lambda,$$

no cross terms surviving because $(V_\lambda^*\otimes V_\mu^*)^{O(5)}=0$ for $\lambda\ne\mu$.

**Step 3, the swap.** The transposition on $U\otimes U$ acts on both tensor factors. $b_\lambda$ being symmetric, a form $\sum_\lambda c_\lambda\otimes b_\lambda$ is symmetric iff every $c_\lambda$ is. Therefore

$$\dim\mathrm{Sym}^2(U)^{O(5)}=\sum_\lambda\binom{m_\lambda+1}2,\qquad \dim\Lambda^2(U)^{O(5)}=\sum_\lambda\binom{m_\lambda}2,\qquad \dim(U^*\otimes U^*)^{O(5)}=\sum_\lambda m_\lambda^2.$$

**Step 4, arithmetic on the multiset $\{1^{12},2^9,3,4^2\}$.**

| $m$ | count | $\binom{m+1}2$ | $\binom m2$ | $m^2$ |
| --- | --- | --- | --- | --- |
| $1$ | $12$ | $12$ | $0$ | $12$ |
| $2$ | $9$ | $27$ | $9$ | $36$ |
| $3$ | $1$ | $6$ | $3$ | $9$ |
| $4$ | $2$ | $20$ | $12$ | $32$ |
| | **$24$ blocks, $\sum m=41$** | **$65$** | **$24$** | **$89$** |

$$\boxed{\ \dim\mathrm{Sym}^2=65,\qquad \dim\Lambda^2=24,\qquad \sum m^2=89.\ }$$

**CONFIRMED, and reachable in four lines by a reader with the table.**

## 2. "Weyl integration settles it" is a run, and the same file already holds the hand derivation

**It is a run.** I read [run_n5_unknown_count.py](../scripts/runs/run_n5_unknown_count.py) rather than executing it, the programme being on an analysis-only footing. It builds the $\mathrm{Sym}^3$ character of $\mathcal W_5$ from `cc.CHI`, forms the $\mathrm{Sym}^2$ and $\Lambda^2$ characters by Newton and by $\tfrac12(p_1^2-p_2)$, and applies the constant-term Weyl integration of [run_n5_constraint_count.py](../scripts/runs/run_n5_constraint_count.py). **No reader follows a constant-term extraction against a $7770$-dimensional character by hand.**

**Two honest points in the script's favour.** Its `MULTS` list is used **only** for the printed comparison, the two dimensions `ds` and `dl` come from Weyl integration alone. **So the run genuinely is independent of [L83](../findings/sym3-blocks.md)'s multiplicity column**, and the block's "touching none of the certificate machinery" is accurate: no adapted basis, no prime, no highest-weight vectors. *The residual shared dependency is `cc.CHI`, the character of $\mathcal W_5$, common to this route and to the character-ring run that produced the table; an error there moves both together.*

**But the block sends the reader to a run for something already hand-derived 105 lines below it.** [L59](../findings/sym3-blocks.md)'s Gate 2 note records that **both** [r651](REVIEW_r651.md) and [r652](REVIEW_r652.md) verified $65=20+6+27+12$ by hand, block by block, which is precisely my Step 4 column. **The record therefore contains a hand derivation of $65$ under a lemma that is not L88, while L88 says a machine settles it.** That is the "does the file already settle it" hit, and it is the block's single most fixable defect: one sentence naming $\sum_\lambda\binom{m_\lambda+1}2$ would make L88 checkable by a reader with a pencil.

## 3. $65$, $24$ and $89$ are two facts and an identity, not three

**$89=65+24$ carries no information.** $\binom{m+1}2+\binom m2=m^2$ holds termwise, at every single block, for every integer $m$. Displaying it as a third figure alongside the other two is the same overstatement [L83](../findings/sym3-blocks.md)'s audit found in "closing four independent ways", one heading-block away in the same file.

**What the two genuine numbers pin.** $65-24=41=\sum m_\lambda$ and $65+24=89=\sum m_\lambda^2$, the first and second moments of the multiplicity multiset, and nothing else.

**They inherit L83's blind spot in full, and worse.** [L83](../findings/sym3-blocks.md)'s $24/41/65$ are invariant under swapping the multiplicities of the two dimension-$35$ blocks. **L88's $65$, $24$ and $89$ are invariant under permuting the multiplicity column arbitrarily**, since each is a symmetric function of $\{m_\lambda\}$ that never touches $\lambda$ or $d_\lambda$. So as a check on the table these three numbers are *strictly weaker* than L83's own four, and the block should not read as an independent confirmation of the block structure. **It is an independent confirmation of two moments of one column.**

### The $24$ that is not this $24$

**[L83](../findings/sym3-blocks.md)'s heading says "the $24$-block table"; L88's heading says $\dim\Lambda^2=24$. These are different objects that happen to agree numerically.** L83's is $\sum_\lambda m_\lambda^0$, the block count; L88's is $\sum_\lambda\binom{m_\lambda}2$. Both equal $24$ on this table by coincidence, no structural reason produces the agreement, and it would break under any change to the multiplicity column that preserved the block count.

**The two headings sit $89$ lines apart in one file and nothing anywhere flags the collision.** This is the class of hazard [conventions.md](../findings/conventions.md) exists to table, alongside the $B$, $M$, $d$ and $\mu$ entries. *L83's own Gate 2 note names its $24$ as $\sum m^0$; a reader who carries that reading into L88 will believe L88's $24$ is the block count and that $65+24=89$ is a coincidence rather than an identity.*

## 4. Why an SOS Gram is symmetric, and what "gauge" is true of

**Symmetry is forced, and it is one line.** For cubics $c_a$ and a Gram $G$, the sextic is $\sum_{a,b}G_{ab}c_ac_b$; polynomial multiplication is commutative, so $c_ac_b=c_bc_a$ and only the symmetric part of $G$ survives. Equivalently the multiplication map $\mu$ factors through $\mathrm{Sym}^2$ and kills $\Lambda^2$ identically. **The block's "an antisymmetric form contributes nothing to a quadratic, hence nothing to the sextic" is exactly this and is correct.**

**The transformation the word "gauge" names, which the block does not name.** It is the additive action of the abelian group $\Lambda^2(U)^{O(5)}\cong\mathbb R^{24}$ by translation, $G\mapsto G+A$, on the $89$-dimensional space of invariant bilinear forms. $\mu$ is constant on its orbits. **So the word is earned for $\mu$**, this is a derivation, compressed to a clause, rather than an assertion.

**And the dimension is basis-independent, which is the half of reviewer 204's finding the block leaves implicit.** Let $r$ be a real basis of $U$ and $c=Rr$ the $\mathbb Q(i)$ basis, $R$ invertible and not real. Then $\bar c_ac_b=\sum_{j,k}\bar R_{aj}R_{bk}\,r_jr_k$, so the sextic attached to a Hermitian $H$ is $\sum_{j,k}(R^\dagger HR)_{jk}r_jr_k$ and depends on $H$ **only through $\operatorname{Re}(R^\dagger HR)$**, the real part of a Hermitian matrix being symmetric. The kernel is $\{H:R^\dagger HR=iA,\ A\text{ real antisymmetric}\}$, of real dimension $\sum\binom{m_\lambda}2=24$ **for every invertible $R$**. **So the count $24$ survives any change of basis and only the coordinates move, which is precisely reviewer 204's verdict, now with a derivation behind it rather than a sampling experiment over $4000$ bases.** *That derivation belongs in the block; it makes 204's refutation a theorem rather than a measurement.*

### Where "gauge" over-reaches, and it is the one place a builder would be misled

**The $24$ are gauge for the linear map $\mu$. They are not gauge for the PSD cone, and an SOS certificate lives in the cone.**

$H=S+iA$ Hermitian is positive semidefinite **strictly more often false** than $S\succeq0$. Witness, at $m=2$:

$$S=\begin{pmatrix}1&0\\0&1\end{pmatrix},\qquad A=\begin{pmatrix}0&t\\-t&0\end{pmatrix},\qquad H=\begin{pmatrix}1&it\\-it&1\end{pmatrix},\quad \operatorname{spec}H=\{1-t,\,1+t\}.$$

$S\succeq0$ always; $H\succeq0$ **iff $\lvert t\rvert\le1$**. So the fibre of the "gauge" direction over a feasible symmetric point is a bounded convex set containing $0$, not a copy of $\mathbb R$. **The feasible set of the Hermitian problem is not a product of the real feasible set with $\mathbb R^{24}$**, and a reader told flatly that "the $24$ are gauge" would expect it to be.

**The saving statement, which the record nowhere makes.** Congruence preserves positivity, so $H\succeq0\Rightarrow R^\dagger HR\succeq0\Rightarrow\operatorname{Re}(R^\dagger HR)\succeq0$. Hence

$$H\ \text{Hermitian PSD with}\ \mu(H)=F_5\quad\Longmapsto\quad \operatorname{Re}(R^\dagger HR)\ \text{real symmetric PSD with the same sextic},$$

and conversely any real symmetric PSD solution is Hermitian PSD with $A=0$. **The two problems are equivalent for solvability, so a Hermitian certificate is a sound certificate for a real SOS.** *That sentence is what closes the alarm [L61](../findings/sym3-blocks.md) raises, and it is absent from both blocks.*

**Verdict on the word: GAP rather than REFUTED.** The block's own clause is correctly scoped to the sextic; the bare "they are gauge" is not, and the brief is right that it is the load-bearing word.

## 5. The real-versus-Hermitian axis: $65$, $36$ and $47$ reconcile exactly

**This is the brief's central question and the answer is unambiguous.**

**The one mechanism.** For a shape $\{m_\lambda\}$ of multiplicity spaces over a real-type isotypic decomposition, three counts sit on it: real symmetric $\sum\binom{m+1}2$, real antisymmetric $\sum\binom m2$, and Hermitian $\sum m^2$, the last being the real dimension of the Hermitian forms on the complexification, and equal to the sum of the first two by the termwise identity. **L88 states this at the unrestricted shape. The certificate lives at the restricted shape, and nobody has written the second row down.**

**The restricted shape, derived.** [L86](../findings/sym3-blocks.md)'s parity rule kills the constraint on odd-$\lambda_2$ blocks entirely and cuts one multiplicity from each even block; [L87](../findings/sym3-blocks.md) proves the cut is exactly one. Splitting L83's table by the parity of $\lambda_2$:

| | blocks | $\sum m$ | after the cut |
| --- | --- | --- | --- |
| $\lambda_2$ even | $16$, dimensions summing to $3570$ | $29$ | $29-16=13$ |
| $\lambda_2$ odd | $8$ | $12$ | $12$ (untouched) |
| **total** | **$24$** | **$41$** | **$25$** |

*I re-derived all of this cold: the sixteen even blocks are $(4,2),(2,2),(3,2),(5,2),(4,4),(4,0),(3,0),(2,0),(6,6),(6,4),(6,2),(6,0),(5,4),(5,0),(1,0),(0,0)$, their dimensions sum to exactly $3570$, and the eight blocks dying outright are the eight multiplicity-$1$ even ones, matching [L86](../findings/sym3-blocks.md)'s list.*

The surviving shape is **two $3$'s, five $2$'s, nine $1$'s**, sixteen blocks. Then

$$\sum\binom{m'+1}2=6+6+3+5\cdot1+4\cdot3+4\cdot1=\mathbf{36},\qquad \sum\binom{m'}2=3+3+5\cdot1=\mathbf{11},\qquad \sum m'^2=18+20+9=\mathbf{47}.$$

$$\boxed{\ \text{unrestricted } 65+24=89;\qquad \text{restricted } 36+11=47.\ }$$

### Verified against the certificate's own data file

[n5_certificate.json](../scripts/runs/n5_certificate.json) carries `"shape": [3,3,2,1,2,1,2,1,2,2,1,1,1,1,1,1]` against `"blocks": [[2,2],[4,2],[3,2],[2,0],[2,1],[3,0],[3,1],[4,0],[4,1],[4,3],[4,4],[5,2],[3,3],[5,1],[5,3],[6,3]]`, and its `point` array has **exactly $47$ coordinates**. **Every one of the sixteen block labels and every one of the sixteen multiplicities matches what I derived by hand from [L83](../findings/sym3-blocks.md) plus [L86](../findings/sym3-blocks.md), with no exceptions**: the two $3$'s are the even mult-$4$ blocks $(2,2)$ and $(4,2)$, the five $2$'s are the even mult-$3$ block $(3,2)$ together with the four odd mult-$2$ blocks $(2,1),(3,1),(4,1),(4,3)$, and the nine $1$'s are the five even mult-$2$ blocks and the four odd mult-$1$ blocks.

**So the answer the brief asks for, stated plainly: the certificate's $47$ Hermitian parameters are CONSISTENT with this block's $65$, and no reconciliation problem exists.** $65$ counts real symmetric invariant forms on all of $\mathrm{Sym}^3\mathcal W_5$, over $\mathbb R$; $36$ counts them on the orbit-constrained subspace $K$, over $\mathbb R$; $47$ counts **Hermitian** forms on the same $K$, over $\mathbb C$. The field is $\mathbb R$ for the first two and $\mathbb C$ for the third, and **$\mathbb R$ is the right field for an SOS certificate over $\mathbb R$**, with §4's projection $\operatorname{Re}(R^\dagger HR)$ showing that the $\mathbb C$ computation loses nothing.

### An independent confirmation from the record's own two kernel dimensions

The record states two figures that have never been compared: [L90](../findings/sym3-blocks.md)'s certificate table gives **"an exact $34$-dimensional kernel"**, and the same file gives **"the affine family is $36-13=23$ dimensional"**. Both are the null space of a rank-$13$ system, one counted in Hermitian coordinates and one in real symmetric ones:

$$47-13=34,\qquad 36-13=23,\qquad 34-23=\mathbf{11}=\sum\binom{m'}2.$$

**The record's own arithmetic reproduces the restricted gauge dimension to the digit, from two numbers written for unrelated purposes.** I regard this as the strongest single confirmation available here, because neither figure was computed with the other in view.

### What this means for [L61](../findings/sym3-blocks.md)'s note

**[L61](../findings/sym3-blocks.md)'s Gate 2 note reports "$47$ Hermitian parameters ... against the file's stated $36$ real-symmetric unknowns" as though it were a discrepancy. It is not one, it is L88's own mechanism, evaluated at the restricted shape.** The note is right that the disparity is unstated; it is wrong to leave the reader with the impression that a real-versus-Hermitian inconsistency stands. **L88 is where the axis is supposed to be settled, and it settles it, for the shape L88 happens not to be about.** *The repair is two sentences in L88: the same three-count identity at the restricted shape, $36+11=47$, and the projection that makes a Hermitian certificate a real one. Neither changes a number anywhere.*

## 6. $O(5)$ against $SO(5)$: the step is correct and unstated, third sighting in this file

**Why it is legitimate at $n=5$.** $\det(-I)=(-1)^5=-1$, so $-I\notin SO(5)$ and $O(5)=SO(5)\times\{\pm I\}$. $-I$ acts on $\Lambda^2\mathbb R^5$ as $(-1)^2=+1$, hence trivially on $\mathcal W_5\subset\mathrm{Sym}^2(\Lambda^2\mathbb R^5)$ and on every $\mathrm{Sym}^k\mathcal W_5$. **So each $SO(5)$-constituent extends to $O(5)$ by the trivial character on $-I$, the multiplicities agree, and $O(5)$-invariants coincide with $SO(5)$-invariants.** The Frobenius–Schur indicator is unaffected, so §1's real-type step is untouched.

**Why it fails at even $n$.** There $-I\in SO(n)$, $O(n)$ is not that direct product, and $SO(n)$-irreducibles with $\lambda_{n/2}\ne0$ fuse in pairs under $O(n)$, so an $SO(n)$ block table is not an $O(n)$ block table.

**The block does not say any of it.** L88 writes $O(5)$ throughout while its supporting data, L83's $B_2$ highest-weight table, the "integral weight of $B_2$" real-type argument, and the script's constant-term integration over the $B_2$ torus, which computes $\mathfrak{so}(5)$-invariants, are all $SO(5)$ objects. **[L83](../findings/sym3-blocks.md)'s Gate 2 note already files exactly this omission against the table**, and [L86](../findings/sym3-blocks.md) handles the neighbouring reflection $\varepsilon$ explicitly. **So this is the third sighting in one file of one unstated step, and L88 is the block that names $O(5)$ in its own displayed formulas.** One clause fixes it.

## 7. Provenance, pointers, and the hedging clauses

**Provenance is clean, a rarity on this file, and it should be recorded as such.**

| clause | check | verdict |
| --- | --- | --- |
| originating commit | `git log -S` puts $65$, $24$, $89$ and "are gauge" at `5af38a68`, *"docs(findings): the unknowns are real symmetric, and rank 14 is a theorem"* | **clean at birth**, the commit body states the claim in the same terms as the block, with the real-type reason, and makes no claim the block drops |
| the r204 repair | `ec35c0b9`, *"fix(n5): apply Gate 2 r203/r204"* | **folded correctly**, the commit body distinguishes count from labelling exactly as the block now does |
| the heading | `8d869d2c`, *"docs(sym3-blocks): place headings for Lemmas 83-92"* | headings only, as promised |
| the id prefix | `fe85b5bd` | mechanical |

**Pointers.** The block carries **exactly one link**, [run_n5_unknown_count.py](../scripts/runs/run_n5_unknown_count.py), and it resolves; the script's docstring matches the block sentence for sentence. **It cites no numbered result at all**, not [L83](../findings/sym3-blocks.md), whose multiplicity column is the block's entire input, and not [L86](../findings/sym3-blocks.md) or [L87](../findings/sym3-blocks.md), which are what turn "measured" into "proved". *[L59](../findings/sym3-blocks.md)'s note already records that L85, L86, L87 and L88 are consumed uncited; the uncitation runs in both directions.*

**The hedging clauses, one by one.**

- **"a dimension rather than a basis convention"**, **true, and the block's best sentence.** §4 shows the kernel has dimension $24$ under every invertible change of basis; only its coordinates move. **The block asserts this and reviewer 204 verified the coordinate half numerically; the dimension half has a two-line proof that nobody has written down.**
- **"Weyl integration settles it"**, **true of a run, and misleading as guidance.** §2: the hand derivation is four lines and is already in this file under [L59](../findings/sym3-blocks.md).
- **"a Hermitian ansatz over $\mathbb Q(i)$ inflates it"**, **true**, and §5 gives the exact inflation factor at both shapes: $+24$ unrestricted, $+11$ restricted. *"Inflates" is the right verb for the parameter count and the wrong one for the feasible set, which the extra directions shrink.*
- **"the $24$ are gauge"**, **true for $\mu$, false for the PSD cone**, §4, with a $2\times2$ witness.
- **"the measured multiplicities"**, **stale in one direction.** [L87](../findings/sym3-blocks.md) now proves the rank-one step that was measured, and [L83](../findings/sym3-blocks.md)'s audit finds the table re-derivable by hand; the word survives from `5af38a68`, which predates both.

## 8. What blocks nothing, and what I did not do

**Nothing here was blocked by the analysis-only rule.** Every number in this review was derived by hand and then screened, the multiset moments and the certificate `shape` sums, seconds of arithmetic on objects I constructed for the purpose, reported as a screen and never as evidence for a positive claim. I read [run_n5_unknown_count.py](../scripts/runs/run_n5_unknown_count.py) and [n5_certificate.json](../scripts/runs/n5_certificate.json) rather than executing the pipeline.

**One item would need computation and I stop at it.** Whether `cc.CHI` is the correct character of $\mathcal W_5$ is the single shared root of both routes to $65$, the Weyl-integration run and L83's table. *A run comparing `cc.CHI` against the branching of $[2,2]$ built independently would decide it: agreement makes the two routes to $65$ genuinely independent; disagreement moves the table, the $65$, the $36$ and the certificate's shape together.* **I do not have approval for it and did not open it.** *The dimension check $\sum_\lambda m_\lambda d_\lambda=7770=\binom{37}3$, which [L83](../findings/sym3-blocks.md) already carries, is a partial substitute and is the only external anchor in the neighbourhood.*

## Summary of findings

| # | finding | severity |
| --- | --- | --- |
| 1 | $65$, $24$, $89$ all **CONFIRMED**, hand-derived in four lines from the multiplicity multiset and real type |, |
| 2 | **The certificate's $47$ is consistent with $65$ and with $36$**: $47=\sum m'^2$, $36=\sum\binom{m'+1}2$, $11=\sum\binom{m'}2$ on the restricted shape, verified block-for-block against [n5_certificate.json](../scripts/runs/n5_certificate.json) |, |
| 3 | The record's own $34$ and $23$ differ by exactly $11$, confirming finding 2 from two figures written for unrelated purposes |, |
| 4 | **"the $24$ are gauge" is false of the PSD cone**, $H=S+iA\succeq0$ is strictly stronger than $S\succeq0$; witness $\operatorname{spec}=\{1\pm t\}$ | GAP, load-bearing |
| 5 | **"Weyl integration settles it" sends the reader to a run** where [L59](../findings/sym3-blocks.md)'s note, 105 lines below, records two reviewers deriving $65$ by hand | GAP |
| 6 | **$89=65+24$ is the termwise identity $\binom{m+1}2+\binom m2=m^2$**, the three displayed numbers are two moments and a tautology, and all three are blind to which block carries which multiplicity | GAP |
| 7 | **L83's "$24$-block table" and L88's $\dim\Lambda^2=24$ are different objects agreeing by coincidence**, $89$ lines apart, unflagged anywhere | GAP, collision hazard |
| 8 | **The $O(5)$-versus-$SO(5)$ step is unstated**, correct at odd $n$ by $\det(-I)=-1$, false at even $n$; third unstated sighting in this file | GAP |
| 9 | **[L61](../findings/sym3-blocks.md)'s $47$-against-$36$ alarm is dissolved by L88's own mechanism**, and neither block says so | GAP, cross-block |
| 10 | The basis-independence of the count $24$ has a two-line proof via $\operatorname{Re}(R^\dagger HR)$, which would promote reviewer 204's numerical refutation to a theorem | improvement |
| 11 | Provenance **clean** at all four touching commits; the single pointer resolves; **no numbered result is cited** | mixed |

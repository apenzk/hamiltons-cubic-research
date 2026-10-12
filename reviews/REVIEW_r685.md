# Review r685, Lemma L89, $\mathrm{rank}(\mu\vert_{\mathrm{inv}})=14$ by exactness of the invariants functor

**Reviewer A of an independent pair on identical briefs. Target: [findings/sym3-blocks.md](../findings/sym3-blocks.md) line 118, `#### Lemma L89, $\mathrm{rank}(\mu\vert_{\mathrm{inv}})=14$, nullity $51$, by exactness of the invariants functor`, and the `## The rank is a theorem on the full space, and an open question on the restricted one` section beneath it (lines 120–128).**

**Standing rule observed: analysis only. Nothing below was computed. Every arithmetic step is a subtraction or a two-line hand argument, and I state where a number is a machine dimension I did not and could not re-derive by hand.**

## Verdict: GAP

**The exactness step is a genuine theorem and it is correctly argued.** Surjectivity of $\mu$ is elementary (it is not imported and it is not measured), equivariance is immediate, and exactness of $(-)^{O(5)}$ in characteristic zero is standard. So $\mathrm{rank}(\mu\vert_{\mathrm{inv}})=\dim(\mathrm{Sym}^6\mathcal W_5^*)^{O(5)}$ holds, and it is the block's own contribution.

**What the block does with it fails in three places.** (i) The displayed equation asserts $\mathrm{rank}(A)=14$ **exactly** for the *sampled matrix* $A$, and the block's own next-but-one paragraph says $\mathrm{rank}(A)\le14$ with equality unproven, a contradiction six lines wide, and the display is the object the heading and the index quote. (ii) **"No sample points are needed for it" was refuted by reviewer 204, `git` shows the refuting commit says so in its own body, and the sentence is still there verbatim**, three lines above the correction that names it. (iii) The $14$ and the $65$ are both imported, uncited, machine Weyl-integration dimensions ([L85](../findings/sym3-blocks.md), [L88](../findings/sym3-blocks.md)), so **the nullity $51$ is a subtraction, not a result**, the block's whole original content is the two-line functorial step, which is real but small.

**On the chain: no measured link drops.** [L87](../findings/sym3-blocks.md)'s $3570$ and [L62](../findings/sym3-blocks.md)'s $\mathrm{rank}\ge13$ are both statements about the *restricted* space, and L89's theorem lives entirely on the full one. I derive below why exactness cannot reach either, and what it *does* give on the restricted side that the block failed to claim.

## Readings adopted

| symbol | reading I use | why |
| --- | --- | --- |
| $\mu$ | **the multiplication map** $\mathrm{Sym}^2(\mathrm{Sym}^3\mathcal W_5^*)\to\mathrm{Sym}^6\mathcal W_5^*$ of cubic forms into sextic forms | The block's own definition. **This is a fourth sense of $\mu$ on the record**, [conventions.md](../findings/conventions.md) tables the $\Lambda^2$ spectrum, the scalar $-\min\omega$ and a third in [target.md](../findings/target.md), and has no row for this one. [L59](../findings/sym3-blocks.md)'s audit already noted the collision; conventions.md still does not carry it. |
| $\mathrm{Sym}^k\mathcal W_5$ vs $\mathrm{Sym}^k\mathcal W_5^*$ | **interchangeable for dimension purposes**, $\mathcal W_5$ being a real orthogonal $O(5)$-module and so self-dual | The block writes the starred space in the prose and the unstarred one in the display four lines later. Harmless here, and I flag it only because this file's audits keep finding one symbol carrying two objects at that distance. |
| $\mathrm{rank}(\mu\vert_{\mathrm{inv}})$ | the rank of the induced map $(\mathrm{Sym}^2\mathrm{Sym}^3\mathcal W_5^*)^{O(5)}\to(\mathrm{Sym}^6\mathcal W_5^*)^{O(5)}$ | the heading's object |
| $A$ | **the sampled coefficient matrix of the *unrestricted* problem, $65$ columns** | Fixed by the block's own line 128 ("the pipeline's $A$ is the *sampled* coefficient matrix") together with [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py):648, which prints "the UNRESTRICTED family is $65-14$". The nullity $51$ in the display only parses under this reading. |
| $K$ | the $O(5)$-submodule of cubics with $\sigma_\lambda(W_0)=0$, i.e. vanishing on the orbit of the padded $W_{\mathbb{CP}^2}$ | line 159 of the same file |
| "the restricted map" | $\mu\vert_{\mathrm{Sym}^2K}:\mathrm{Sym}^2K\to\mathrm{Sym}^6\mathcal W_5^*$, whose invariant domain has dimension $36$ | [L86](../findings/sym3-blocks.md)/[L59](../findings/sym3-blocks.md)'s $65=36+29$ |
| block extent | a `####` block runs to the next `####`, absorbing an intervening `##` | the reading under which L89 has content; flagged because [L62](../findings/sym3-blocks.md)'s audit records two reviewers reading this boundary two ways |

**The three conventions repaired on 2026-09-04 ($\theta_0(n)$ as the closed form alone, $\Theta_n$'s square root, $S_{XYZ}$ over ordered slots), do not appear in L89 and bear on nothing in it.** $\theta_0$ and $S_{XYZ}$ are absent from the whole block; $\Theta_5$ appears only in the *next* section's heading, which is [L61](../findings/sym3-blocks.md)'s territory and already carries its own W5 finding.

## 1. The exactness argument, derived cold

**Three hypotheses, checked one at a time.**

### 1.1 $\mu$ is surjective, elementary, and neither imported nor measured

Write $V=\mathcal W_5$, $\dim V=35$, and identify $\mathrm{Sym}^dV^*$ with the degree-$d$ homogeneous polynomial functions on $V$. Fix any basis $x_1,\dots,x_{35}$ of $V^*$. A degree-$6$ monomial is a multiset of six letters from that basis; split the multiset into two halves of size three, and the monomial is the image under $\mu$ of the corresponding element of $\mathrm{Sym}^2(\mathrm{Sym}^3V^*)$. Monomials span $\mathrm{Sym}^6V^*$, so $\mu$ is onto.

$$\boxed{\ \mu:\mathrm{Sym}^2(\mathrm{Sym}^3V^*)\twoheadrightarrow\mathrm{Sym}^6V^*\ \text{ for every }V\ \text{ over every field.}\ }$$

**This answers the brief's central worry in the negative: surjectivity is not an imported or measured input.** It is a one-line fact about splitting a multiset, true in any dimension and any characteristic, and the theorem inherits nothing from it. The block does not give the line, but nothing is hidden by its absence.

### 1.2 $\mu$ is $O(5)$-equivariant, immediate

$O(5)$ acts on functions by $(g\cdot f)(W)=f(g^{-1}W)$, which is a ring action: $(g\cdot p)(g\cdot q)=g\cdot(pq)$. Multiplication of functions therefore intertwines. **Checked, and the block states it correctly.**

### 1.3 $(-)^{O(5)}$ is exact, and the block's justification is heavier than it needs

The block argues by reductivity in characteristic zero. That is correct for $O(5,\mathbb C)$ and correct for $O(5,\mathbb R)$ read as a linearly reductive group. **The shorter route, and the one that matches the record's real setting, is averaging.** $O(5)$ is compact, so the Reynolds operator $R(v)=\int_{O(5)}g\cdot v\,dg$ is defined on every finite-dimensional $O(5)$-module, is an equivariant projection onto $V^{O(5)}$, and is natural: $R\circ\varphi=\varphi\circ R$ for every module map $\varphi$. Given a surjection $\varphi:M\twoheadrightarrow N$ and $n\in N^{O(5)}$, choose $m$ with $\varphi(m)=n$; then

$$\varphi(R(m))=R(\varphi(m))=R(n)=n,\qquad R(m)\in M^{O(5)}.$$

So $\varphi$ restricted to invariants is onto. **Confirmed, by a route sharing no machinery with the block's.** The two routes are the same theorem, and I record the second because it needs no algebraic-group theory and a reader can check it in four lines.

### 1.4 The conclusion

Combining 1.1–1.3, $\mu\vert_{\mathrm{inv}}$ is onto $(\mathrm{Sym}^6\mathcal W_5^*)^{O(5)}$, so

$$\mathrm{rank}(\mu\vert_{\mathrm{inv}})=\dim(\mathrm{Sym}^6\mathcal W_5^*)^{O(5)},\qquad \mathrm{nullity}=\dim(\mathrm{Sym}^2\mathrm{Sym}^3\mathcal W_5^*)^{O(5)}-\mathrm{rank}.$$

**That is the whole theorem, and it is correct.** Everything after this is a matter of which numbers go in the slots, and of which map the block is talking about when it puts them there.

## 2. The numbers in the slots, both imported, both machine, neither cited

| slot | value | where it comes from | status |
| --- | --- | --- | --- |
| $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$ | $14$ | [L85](../findings/sym3-blocks.md), Weyl integration in [run_n5_constraint_count.py](../scripts/runs/run_n5_constraint_count.py) | **machine dimension.** L85's index row reads *"Gate 2: no verdict on the record."* |
| $\dim\mathrm{Sym}^2(\mathrm{Sym}^3\mathcal W_5)^{O(5)}$ | $65$ | [L88](../findings/sym3-blocks.md), Weyl integration in [run_n5_unknown_count.py](../scripts/runs/run_n5_unknown_count.py) | **machine dimension**, index row *"no verdict on the record."* |
| nullity | $51$ | $65-14$ | **a subtraction** |

**L89 cites neither L85 nor L88.** Its block contains no link at all. The $14$ appears in the display as though it were being established there, and the $65$ appears bare inside the subtraction. This is the same defect [L59](../findings/sym3-blocks.md)'s audit recorded of its own block (*"the $14$ is imported without attribution"*), repeated fourteen lines further up the same file, by a block that sits **immediately below** L88 and fifty lines below L85.

**The $65$ does have a second, independent support that the block does not use.** By Schur, with every $V_\lambda$ occurring of real type,
$$(\mathrm{Sym}^2\mathrm{Sym}^3\mathcal W_5)^{O(5)}\cong\bigoplus_\lambda\mathrm{Sym}^2(M_\lambda),\qquad \dim=\sum_\lambda\tfrac{m_\lambda(m_\lambda+1)}2,$$
and [L83](../findings/sym3-blocks.md)'s table gives $20+6+27+12=65$ directly. I verified that column by hand: two blocks at $m=4$ give $2\times10$, one at $m=3$ gives $6$, nine at $m=2$ give $9\times3$, twelve at $m=1$ give $12$. **So the $65$ is cross-checked; the $14$ is not.** L83's own audit records that the multiplicity column is a single imported plethysm, so the two supports for $65$ are one Weyl integration and one moment of an imported column, better than nothing, and less than independent.

**No such cross-check exists for the $14$.** It is one Weyl-integration run. A reader should also be told that the $14$ appearing in [L83](../findings/sym3-blocks.md)'s table as the dimension of the block $(2,0)_{14}$ is an unrelated coincidence and is not a confirmation.

**Answering the brief's question 3 directly: yes. The $65$ is L88's, the $14$ is L85's, both are imported, and the $51$ is a subtraction.** The block's own content is the exactness step of §1, which is a real theorem, and a short one. *That is not nothing, but the heading advertises a rank and a nullity, and the block establishes neither number, only the identity that relates them.*

## 3. The slide: $\mathrm{rank}$ and the object it is a rank of, six lines apart

**The brief asked me to check for the same slide a companion audit found on [L59](../findings/sym3-blocks.md). It is here, and it is in the displayed equation.**

The block's display reads

$$\mathrm{rank}(A)=\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14\quad\text{exactly, with nullity }65-14=51,$$

and its third paragraph reads

> **The theorem is about $\mu$, not about the sampled matrix $A$.** *Reviewer 204.* … the pipeline's $A$ is the *sampled* coefficient matrix, whose rank is $\le14$ with equality only when the sample points are unisolvent for the $14$ invariants. No theorem supplies unisolvence.

**These two sentences cannot both be true of the same $A$.** The display asserts equality "exactly"; the paragraph asserts inequality with the equality case open. The correct statements are $\mathrm{rank}(\mu\vert_{\mathrm{inv}})=14$ and $\mathrm{rank}(A)\le14$, nullity of $A$ at least $51$. **The heading gets it right and the display gets it wrong**, and the display is the line a reader takes away.

**`git` gives the mechanism.** The display and the "no sample points" sentence entered at `5af38a68` (2026-08-28, *"the unknowns are real symmetric, and rank 14 is a theorem"*). The correcting paragraph entered later the same day at `ec35c0b9`, whose diff on this file is **purely additive**, it adds the r204 paragraph and rewrites the restricted paragraph, and touches neither the display nor the sentence above it. The heading naming $\mu\vert_{\mathrm{inv}}$ was attached later still, by `fe85b5bd` (*"every result and fence post carries a prefixed id"*), and was never reconciled with the display it sits over.

**The same doubled statement is in the code.** [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py):630 carries the display verbatim, `rank(A) = dim (Sym^6 Weyl_5)^{O(5)} = 14 exactly, kernel 65 - 14 = 51`, with the r204 correction appended below it at :636–644. **The script is nonetheless the better document**: its *printed* output at :646–650 separates the two cleanly, `rank(mu|inv) = 14 … (a theorem about the abstract map)` and `rank(A) for the SAMPLED matrix still needs unisolvent points and is NOT retired`. **The block imported the script's wrong comment and dropped the script's right prints.**

## 4. A refuted sentence left standing, with the refutation's own commit message naming it

The block's second paragraph still reads, in full:

> **No sample points are needed for it.** The task list carried "evaluate $B_{ij}$ at $\ge15$ points and read off the rank", which asks a computation for what complete reducibility gives; reviewer 200's observation that rank $14$ *implies* consistency collapses the two stated tests into one, and both are now theorems.

**`git show ec35c0b9` says of itself, in its own body:**

> `r204 also refuted "no sample points needed".  Surjectivity gives rank 14 for the ABSTRACT map mu; the pipeline's A is the SAMPLED coefficient matrix, whose rank is 14 only when the points are unisolvent.  Retiring it removed r194's only end-to-end falsification, so the check comes back, sharper for knowing its answer.`

**So the commit that applied the refutation left the refuted sentence in place, three lines above the paragraph that refutes it.** This is the fourth kind of provenance defect this file's audits have collected, and it is the cheapest to repair: the sentence deletes.

**Two further defects inside that sentence, independent of the above.**

- **"both are now theorems" is false, and the attribution to reviewer 200 overreaches.** [r200](REVIEW_r200.md) §5 says only that *observing* $\mathrm{rank}(A)=14$ makes the consistency test vacuous, and it is careful in the opposite direction from the block: *"$\mathrm{rank}_p\le\mathrm{rank}_{\mathbb Q}$, so rank 14 mod $p$ certifies $\mathrm{rank}_{\mathbb Q}\ge14$ soundly, while 'never more than 14' is precisely what reduction cannot certify."* The collapse is r200's; **"both are now theorems" is not**, and it is exactly what r204 struck out.
- **Consistency is a theorem on the full space and open on the restricted one, and the certificate lives on the restricted one.** The pipeline's stage 4 carries the orbit constraint (commit `c2ffea9e`, *"carry the orbit constraint into stage 4, and stop claiming rank 14 there"*) and [L91](../findings/sym3-blocks.md):166 of this same file says *"$36-\mathrm{rank}$ is the dimension of the solution set only when the system is consistent, and consistency is exactly the open necessary condition."* **The file contradicts L89's sentence forty lines below it.** *That the record had already stopped claiming rank 14 in the restricted stage, in a commit dated before the one that wrote this block, is the sharpest form of the finding.*

## 5. "A theorem on the full space, an open question on the restricted one"

**The section heading is the block's most accurate line, and the block delivers only its first half.** Lines 120–128 are entirely about the full space. The restricted discussion sits at line 159, thirty-one lines lower, **under [L90](../findings/sym3-blocks.md)'s heading and immediately above [L91](../findings/sym3-blocks.md)'s**, so a reader who trusts the heading finds the promised open question nowhere beneath it, and a reader who finds it has left L89's block.

### 5.1 What the restricted map is, precisely

Let $K\subset\mathrm{Sym}^3\mathcal W_5^*$ be the cubics vanishing on the $O(5)$-orbit of $W_0$. **$K$ is an $O(5)$-submodule**, [L90](../findings/sym3-blocks.md):156 gives the reason, that the restriction cuts the copy index and leaves $V_\lambda$ whole. The restricted map is $\mu\vert_{\mathrm{Sym}^2K}$, with $\dim(\mathrm{Sym}^2K)^{O(5)}=36$.

### 5.2 Why exactness does not settle it, and what it does give, which the block gives up too early

Put $J:=\mu(\mathrm{Sym}^2K)\subseteq\mathrm{Sym}^6\mathcal W_5^*$, an $O(5)$-submodule. Then $\mathrm{Sym}^2K\twoheadrightarrow J$ is a surjection of $O(5)$-modules, so **§1.3 applies verbatim** and

$$\boxed{\ \mathrm{rank}\big(\mu\vert_{\mathrm{Sym}^2K,\ \mathrm{inv}}\big)=\dim J^{O(5)}.\ }$$

**This is a positive result the block does not claim, and it sharpens the record's statement of the open question.** The block says only that $\mu$ restricted "need not stay onto", which invites the reading that invariance itself might lose something. It does not: **exactness holds on the restricted side too**, and it converts the open question into a single clean one, *how many invariant sextics lie in the submodule generated by products of orbit-vanishing cubics?* No dimension count answers that; it is a question about the ring structure of the invariants, and I see no route to it that does not evaluate something.

$J$ sits inside the $13$-dimensional space of invariant sextics vanishing at $W_0$ ([L62](../findings/sym3-blocks.md)'s cap, a theorem). So $\dim J^{O(5)}\in[1,13]$, the lower end from [L91](../findings/sym3-blocks.md)'s $\Delta$. **A Nullstellensatz route fails at the obvious place**: even if $K$ cut out the orbit cone set-theoretically, an invariant sextic vanishing on it would give only $F^m\in(K)$ for some $m$, which says nothing about membership in $K\cdot K$ in degree six.

### 5.3 Which of the two the number $14$ belongs to

**The full space, unambiguously.** The restricted rank is capped at $13$ by a theorem and measured at $13$. **The certificate route consumes the restricted number, not the $14$**, [L62](../findings/sym3-blocks.md), [L90](../findings/sym3-blocks.md) and the affine family $36-13=23$ all run on $13$. So L89's theorem, correct as it is, is about the number the route does not use.

### 5.4 A third stratum, which L89 joins on the losing side

This file states the restricted rank three ways: **open in $[1,13]$** (line 159), **exactly $13$** ([L90](../findings/sym3-blocks.md):149 and [L62](../findings/sym3-blocks.md):244), and **"an open question"** (L89's own section heading). [L62](../findings/sym3-blocks.md)'s audit already recorded the first two as unreconciled; **L89's heading is a third voice on the "open" side, and it is the one the index quotes.** *This is bookkeeping rather than mathematics, but the index row for L89 is what a reader meets first, and the heading it carries contradicts the index row for L62 four rows above it.*

## 6. What this does to the chain, the brief's question 4

**Nothing. No measured link drops.** I take the two links named in [L59](../findings/sym3-blocks.md)'s audit, *"the chain [L87](../findings/sym3-blocks.md) → L59 → [L62](../findings/sym3-blocks.md) has two measured links, not one, the $36$ and the codimension-one step coming from a mod-$p$ Gram rank"*, and test each against L89.

### 6.1 The $36$, [L87](../findings/sym3-blocks.md)'s mod-$p$ Gram rank $3570$. **Does not drop.**

What is measured there is that each of the sixteen evaluation maps $M_\lambda\to V_\lambda^H$ has rank exactly $1$ rather than $0$. Frobenius reciprocity plus [L86](../findings/sym3-blocks.md) gives $\dim V_\lambda^H\le1$, an upper bound; **rank $1$ rather than rank $0$ is the question of whether $V_\lambda$ actually occurs in the functions on the orbit $O(5)/H$**, which is harmonic analysis on a specific homogeneous space. L89 concerns $\mu$ on all of $\mathrm{Sym}^3$ and never mentions $K$, $W_0$, $H$ or the orbit. **There is no contact.** The measurement stands where it was.

### 6.2 The codimension-one step / $\mathrm{rank}\ge13$, [L62](../findings/sym3-blocks.md)'s sampled mod-$p$ rank. **Does not drop.**

By §5.2 the restricted rank is $\dim J^{O(5)}$. Exactness has already been used, and it is silent on $J$. The full-space surjectivity gives an upper bound of $14$ on any sub-map's rank and no lower bound whatever. **So the lower half of L62 remains one measurement**, exactly as [r633](REVIEW_r633.md)/[r634](REVIEW_r634.md) found.

### 6.3 What L89 *does* buy, which nothing on the record collects

- **It is the missing citation for [L59](../findings/sym3-blocks.md)'s adjoint step.** L59's body (line 205) reads *"$\mathrm{Cat}$ is injective on the invariant sextics --- $\mu$ is surjective, so its adjoint is injective --- placing a copy of the $14$ inside the $65$."* That surjectivity is L89's §1.1, and L59's formula $\mathrm{rank}=14-\dim\mathrm{ANN}$ needs it. **L59 sits eighty-seven lines below L89 and cites nothing; L89 does not say it has a consumer.** *So the record holds this dependency in both directions and states it in neither.*
- **It converts one measurement into a certificate of something else.** Given $\mathrm{rank}(\mu\vert_{\mathrm{inv}})=14$ as a cap, a sampled run *attaining* $14$ no longer measures the rank, it certifies that the sample points are unisolvent for the $14$ invariants. The block's third paragraph says as much ("sharper rather than unnecessary") and is right. **[L90](../findings/sym3-blocks.md) is the block that supplies that unisolvence** and sits twelve lines below; neither block points at the other.

**Answering the brief's question 4 as the deliverable it asked for: [L59](../findings/sym3-blocks.md), [L62](../findings/sym3-blocks.md) and [L87](../findings/sym3-blocks.md) each keep every measured link they had.** The consequential thing L89 was hoped to do, it does not do, and the reason is structural rather than a defect in it: **its theorem is about a map whose domain the certificate route does not range over.**

## 7. The checklist

**Provenance, checked, and mixed.**

| clause | `git` says | verdict |
| --- | --- | --- |
| the exactness paragraph and the display | both entered at `5af38a68`, 2026-08-28, commit subject *"rank 14 is a theorem"* | **clean and truthfully headlined** |
| "No sample points are needed for it" | same commit; refuted by r204 at `ec35c0b9` the same day, whose body names the sentence | **stale, the refutation was applied additively and the sentence survives** |
| "reviewer 200's observation that rank $14$ implies consistency" | [r200](REVIEW_r200.md) §5 says exactly this | **attribution accurate** |
| "…and both are now theorems" | r200 says the opposite about the mod-$p$ direction; r204 struck it | **overreach, not manufactured** |
| "*Reviewer 204*" on the third paragraph | `ec35c0b9`, *"apply Gate 2 r203/r204"*; [REVIEW_r204.md](REVIEW_r204.md) exists | **clean** |

*So no manufactured provenance here, the failure is of a different kind: a refuted claim that was never deleted, in a file where the refutation is recorded three lines below it.*

**Duplication, in four kinds, all four present.**

1. **Verbatim, in scripts, six times.** The exactness paragraph appears in [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py):627, [run_n5_unknown_count.py](../scripts/runs/run_n5_unknown_count.py):34, and three reviewer copies at [dump_state.py](../scripts/reviewers/r210/dump_state.py):612, [r213_assemble_80.py](../scripts/reviewers/r213/r213_assemble_80.py):628 and [assemble_r214_freshpoint.py](../scripts/reviewers/r214/assemble_r214_freshpoint.py):627.
2. **Unnumbered, in another block of the same file.** The surjectivity half is consumed inside [L59](../findings/sym3-blocks.md)'s body at line 205 without citation.
3. **In the report.** [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex):899 carries L59's sentence verbatim, so the surjectivity fact reached the report while **L89 itself did not**, no report file mentions the exactness argument, the nullity $51$, or L89.
4. **In a run's docstring.** [run_n5_necessary.py](../scripts/runs/run_n5_necessary.py):22 repeats *"mu is surjective, so its adjoint is injective"*.

**Does the file settle it above or below?** *Yes, in three places, and in one of them the block's own claim is undone.* [L85](../findings/sym3-blocks.md) fifty lines above holds the $14$; [L88](../findings/sym3-blocks.md) fourteen lines above holds the $65$; and [L91](../findings/sym3-blocks.md):166 forty lines below contradicts the *"both are now theorems"* clause. **The pattern this file's audits keep finding holds again.**

**Pointers.** The block contains **no links at all**, no cite to L85, L88, L86, L90 or L59, none to the reviews it names by number, none to the script whose comment it reproduces. So nothing resolves falsely, and nothing resolves. *Every other Lemma block in this file carries links; L89 is the one that carries none.*

**Index.** [INDEX-results.md](../findings/INDEX-results.md):104 carries row **89**, short name *"$\mathrm{rank}(\mu|_{\mathrm{inv}})=14$ by exactness of the invariants functor"*, verdict *"Gate 2: no verdict on the record."* **The index's short name is more accurate than the block's own display**, it names $\mu\vert_{\mathrm{inv}}$, which is the object the theorem is about. It drops the nullity $51$, which is the right call given §3. The row uses `\mu|_` where the heading uses `\mu\vert_`; cosmetic.

## 8. What I would have the record do

*Recorded as findings for the owner, not applied, this review edits nothing.*

1. **Delete "No sample points are needed for it." and the sentence after it.** `git` shows r204 refuted it and the deletion was simply not made. Nothing downstream uses it.
2. **Change the display's $\mathrm{rank}(A)$ to $\mathrm{rank}(\mu\vert_{\mathrm{inv}})$**, matching the heading and the index, and state the nullity as $65-14=51$ *of the invariant multiplication map*. Then the third paragraph reads as the caveat it is rather than as a contradiction.
3. **Cite [L85](../findings/sym3-blocks.md) for the $14$ and [L88](../findings/sym3-blocks.md) for the $65$**, and say in one clause that both are Weyl-integration dimensions with no Gate 2 verdict. **The block is then honest about being an exactness step over two imported numbers**, which is what it is.
4. **Move the restricted paragraph at line 159 under L89's heading**, or narrow the heading to the full space. As it stands the heading promises a half it does not carry and the half sits under [L90](../findings/sym3-blocks.md).
5. **Add the $\mathrm{rank}=\dim J^{O(5)}$ statement of §5.2.** It is free, it is a theorem, and it states the open question in the form that can be attacked.
6. **Add $\mu$-as-multiplication to [conventions.md](../findings/conventions.md).** The table already warns that $\mu$ carries three senses; this is a fourth, and it is the one the whole $n=5$ file runs on.

## 9. Screening

**None performed, and none needed.** Every step above is a hand derivation or a `git`/`grep` reading of what is on disk. The two numbers I could not check by hand (the $14$ and the $65$ as Weyl-integration outputs), are named as imports throughout rather than screened, since screening them would be the computation the standing rule reserves and would in any case be evidence for nothing.

**What a run would decide, if one were ever approved.** The single question that would move the record is §5.2's: $\dim J^{O(5)}$, the number of invariant sextics in $\mu(\mathrm{Sym}^2K)$. **Outcome $13$** would confirm [L62](../findings/sym3-blocks.md)'s measured half by an independent route and let the chain drop one of its two measured links. **Outcome below $13$** would refute [L62](../findings/sym3-blocks.md)'s value, leave the cap standing, and shrink the affine family the certificate lives in. *That is the run to ask for; it is not one L89 makes unnecessary.*

# Review r686, Lemma L89, $\mathrm{rank}(\mu\vert_{\mathrm{inv}})=14$ by exactness of the invariants functor

**Reviewer B of a pair on identical briefs. Target: the block headed `#### Lemma L89` at [findings/sym3-blocks.md:118](../findings/sym3-blocks.md), together with the section `## The rank is a theorem on the full space, and an open question on the restricted one` beneath it, lines 118–128 at the state I audited (sha1 `a10b9a2e` over lines 118–129). Analysis only; no computation was run. Every number below is hand arithmetic on objects I built for the purpose, reported as a screen.**

## Verdict: GAP

**The exactness step is a theorem, and (against the brief's suspicion), surjectivity is *not* imported and *not* measured.** It is the one-line monomial fact that every degree-$6$ monomial splits as a product of two degree-$3$ monomials. I rebuilt the whole argument cold and it holds with room to spare. The heading is correct as stated.

**The block cannot be checked as written**, for four reasons, of which the first is the one the record needs to know about.

| # | defect | severity |
| --- | --- | --- |
| D1 | **The displayed equation states the claim the block itself refutes six lines later.** The display reads $\mathrm{rank}(A)=14$ *exactly*; the paragraph at [line 128](../findings/sym3-blocks.md) says the pipeline's $A$ is the **sampled** matrix, whose rank is $\le14$. `git` shows the repair inserted the correcting paragraph and left the display standing. | self-contradiction, manufactured by a partial repair |
| D2 | **"both are now theorems" overstates its own source.** [r200](REVIEW_r200.md) argues the two tests are *one* test and calls the mod-$p$ consistency reading **"a screen"**; it says nothing that survives as "theorem". | attribution inflated |
| D3 | **The heading promises a restricted half the section no longer contains.** The restricted paragraph was moved out and now sits at [line 159](../findings/sym3-blocks.md), under [L90](../findings/sym3-blocks.md)'s heading. | empty heading |
| D4 | **"an open question on the restricted one" is stale in its own file**: [L62](../findings/sym3-blocks.md), 109 lines below, settles the restricted rank at $13$. | superseded by the file |

**On the brief's headline question, does L89 let the chain drop a measured link? No, and I can say exactly why.** Both measured links live on the restricted side; exactness is a full-space statement, and what it transports is surjectivity, which on the restricted side is precisely the open question. Section 5 below.

**On the brief's question 3, is this a theorem or a well-dressed subtraction?** It is a theorem whose two inputs are imported, but the two are of different epistemic classes and the block flattens them. The $65$ is not an independent measurement at all: it is $\sum\binom{m_\lambda+1}{2}$ on [L83](../findings/sym3-blocks.md)'s multiplicity column, and I reproduce it, and the $36$ and the $29$ and the block shape, by hand below. Only the $14$ is a genuinely separate computation, and it has three independent confirmations. The $51$ is a subtraction.

## Readings adopted, as the brief requires

I read [findings/conventions.md](../findings/conventions.md) first and adopt these.

| symbol | reading taken here | why |
| --- | --- | --- |
| $\mathcal W_5$ | the $O(5)$-irreducible $[2,2]$, $\dim=35$, highest weight $(2,2)$ in the $e$-basis | [conventions.md](../findings/conventions.md) and [sym3-blocks.md:7](../findings/sym3-blocks.md) |
| $\mathrm{Sym}^k\mathcal W_5^*$ | degree-$k$ polynomial **functions** on $\mathcal W_5$ | forced by "the map carrying a Gram to its sextic" |
| $\mu$ | the **unrestricted** multiplication $\mathrm{Sym}^2(\mathrm{Sym}^3\mathcal W_5^*)\to\mathrm{Sym}^6\mathcal W_5^*$ | the block's own line 122 |
| $\mu\vert_{\mathrm{inv}}$ | its restriction to $O(5)$-invariants, $65\to14$ | the heading |
| $A$ | the **sampled** coefficient matrix of the $B_{ij}$ at sample points | [r200](REVIEW_r200.md) line 113 and [r204](REVIEW_r204.md) line 89, which is the only place the block defines it |
| $K$ | the cubics vanishing on the $O(5)$-orbit of $W_0$, $\dim K=4200$ | [sym3-blocks.md:205](../findings/sym3-blocks.md) and [r204](REVIEW_r204.md) line 131 |
| the restricted map | $\mathrm{Sym}^2(K)^{O(5)}\to(\mathrm{Sym}^6\mathcal W_5^*)^{O(5)}$, i.e. $36\to14$ | the certificate is a Gram on $K$ |
| ground field | $\mathbb R$, the certificate being a real PSD Gram; the group is the **compact** $O(5,\mathbb R)$ | the SOS problem |
| $B$ | **not used here.** [conventions.md](../findings/conventions.md) tables three objects under it and this file adds $B(X,Y)=-\tfrac12\operatorname{tr}(XY)$; the $B_{ij}$ of the retired task are a fifth. I write $B_{ij}$ only inside quotation. | the standing collision |

Two conventions I checked do **not** bite here. The $\theta_0$ repair and the ordered-slot reading of $S_{XYZ}$ touch nothing in this block, no $\theta$, no $S$, no norm and no pairing enters it, which is unusual for this record and is why the block is comparatively safe.

## 1. The exactness argument, derived cold

The block asks for three hypotheses. All three are available, and one of them is cheaper than the block suggests.

**(a) $\mu$ is surjective, elementary, not imported.** Fix any linear coordinates $x_1,\dots,x_{35}$ on $\mathcal W_5$. A monomial $x^\alpha$ with $|\alpha|=6$ can be written $x^\beta x^\gamma$ with $|\beta|=|\gamma|=3$: peel three of the six letters, with multiplicity, into $\beta$ and the rest into $\gamma$. So every degree-$6$ monomial is $\mu(x^\beta\odot x^\gamma)$, and monomials span $\mathrm{Sym}^6\mathcal W_5^*$. Multiplication of functions is commutative, so $S^3\otimes S^3\to S^6$ factors through $\mathrm{Sym}^2(S^3)$ and the factored map is onto.

*This needs no character theory, no dimension count and no run.* It also holds over any commutative ring, so nothing about it is char-$0$-specific. **The brief's worry that surjectivity might itself be measured is unfounded, and the block deserves the credit it does not claim.** A second route, if one prefers it: $\mathrm{Sym}^6V^*$ is spanned by sixth powers $\ell^6$ of linear forms in char $0$, and $\ell^6=\mu(\ell^3\odot\ell^3)$.

**(b) $\mu$ is $O(5)$-equivariant.** $O(5)$ acts on functions by $(g\cdot f)(W)=f(g^{-1}W)$, and $g\cdot(fh)=(g\cdot f)(g\cdot h)$ pointwise. Equivariance is the multiplicativity of the action, which is automatic for any subgroup of $GL(\mathcal W_5)$.

**(c) Taking invariants is exact.** Over $\mathbb R$ with $O(5,\mathbb R)$ compact this is one line and needs no reductivity theory: the Reynolds operator $R(v)=\int_{O(5)}g\cdot v\,dg$ (Haar, normalised) is a projection onto $V^{O(5)}$, natural in $V$ and identity on invariants. Given $y\in(\mathrm{Sym}^6\mathcal W_5^*)^{O(5)}$, pick any $x$ with $\mu(x)=y$; then $R(x)$ is invariant and $\mu(R(x))=R(\mu(x))=R(y)=y$ by equivariance and invariance of $y$. So $\mu\vert_{\mathrm{inv}}$ is onto.

Hence $\mathrm{rank}(\mu\vert_{\mathrm{inv}})=\dim(\mathrm{Sym}^6\mathcal W_5^*)^{O(5)}=14$ and $\dim\ker(\mu\vert_{\mathrm{inv}})=65-14=51$. **Sound.**

**One precision point, not a defect.** The block writes *"$O(5)$ is reductive and the characteristic is zero, so taking invariants is an exact functor"*. What exactness needs is **linear** reductivity; reductive $\Rightarrow$ linearly reductive in characteristic zero is Weyl's theorem, which the block leans on without naming. [r204](REVIEW_r204.md) writes "linearly reductive" and is more precise. Over the ground field the certificate actually lives in, the compact-group Reynolds route above avoids the question entirely. Also, only *right*-exactness is in play ($(-)^G$ is left exact for free) so the block invokes strictly more than it uses.

**A second inert slip.** Line 122's target is $\mathrm{Sym}^6\mathcal W_5^{*}$ and line 124's display drops the star, writing $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$. $\mathcal W_5$ carries an invariant inner product and is self-dual, so the dimensions agree; I record it because this record has been bitten by exactly this class of silent identification elsewhere, and because the same identification is the one that makes "Gram space $=\mathrm{Sym}^2(\mathrm{Sym}^3\mathcal W_5^*)$" legitimate in the first place.

**A third, also inert.** The $14$ and $65$ are real dimensions in the certificate's setting and complex dimensions in the plethysm computations that produce them. They coincide because every $\lambda$ occurring in $\mathrm{Sym}^3\mathcal W_5$ is integral for $B_2$ and hence of **real** type, which is [L88](../findings/sym3-blocks.md)'s own argument, at [line 116](../findings/sym3-blocks.md). The block does not invoke it and would need to if a quaternionic constituent ever occurred.

## 2. D1, the display names the wrong object, and its own block says so

This is the finding. The block's display is

$$\mathrm{rank}(A)=\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14\quad\text{exactly, with nullity }65-14=51.$$

and the paragraph six lines below reads *"the pipeline's $A$ is the **sampled** coefficient matrix, whose rank is $\le14$ with equality only when the sample points are unisolvent for the $14$ invariants. No theorem supplies unisolvence."*

**The display asserts what that paragraph refutes, using the letter that paragraph exists to disown.** The word *exactly* is the collision point.

**There is no reading of $A$ on which the display is true.**

| reading of $A$ | what the display says | what is true |
| --- | --- | --- |
| the abstract $\mu\vert_{\mathrm{inv}}$ | rank $14$, nullity $51$ | **correct**, but this object is called $\mu\vert_{\mathrm{inv}}$, never $A$ |
| the sampled matrix, full system | rank $14$, nullity $51$ | rank $\le14$, nullity $\ge51$ |
| the sampled matrix, restricted system | rank $14$, nullity $51$ | rank $13$, nullity $23$ on a domain of $36$ |

The only object for which the display is right is the one the display does not name, and the heading names it correctly. **This is the same slide the companion audit found on [L59](../findings/sym3-blocks.md), where the note records *"the canon's copy is more precise than this canonical block"*.** It is here in a sharper form: not two maps sharing a letter, but a canonical display asserting the refuted half.

**Provenance, checked and reported either way.** `git log -S` over [findings/sym3-blocks.md](../findings/sym3-blocks.md) gives two commits touching the display, and they explain the defect exactly.

| commit | date | what it did |
| --- | --- | --- |
| `5af38a68` *docs(findings): the unknowns are real symmetric, and rank 14 is a theorem* | 2026-08-28 | wrote the section, the display with $\mathrm{rank}(A)$, and "both are now theorems". Its own commit body says *"rank(A) = 14 exactly on the full space"* and *"The sampler the task list called for is unnecessary"* |
| `ec35c0b9` *fix(n5): apply Gate 2 r203/r204* | 2026-08-28 | replaced the restricted paragraph and **inserted** the correcting paragraph attributed to reviewer 204, and left the display and "both are now theorems" untouched |

So the contradiction was manufactured by a partial repair, on the same day, in the second of two commits. **The provenance clause the block does carry is honest**, reviewer 204 did say this, at [r204](REVIEW_r204.md) line 89, under the heading *"The overreach is in the word `A`"*. Nothing here is fabricated. What failed is that the repair reached the prose and not the display.

**Repair, one character-level edit:** the display should read $\mathrm{rank}(\mu\vert_{\mathrm{inv}})$, matching the heading and the index row. No number moves.

## 3. D2, "both are now theorems" against what r200 wrote

The block: *"reviewer 200's observation that rank $14$ implies consistency collapses the two stated tests into one, and both are now theorems."*

[r200](REVIEW_r200.md) §5, line 142, in full force:

- **The implication is right, and conditional.** *"$\operatorname{rank}(A)=14$ means the $B_{ij}$ span the whole space, so $F_5$ lies in the span... The consistency test... cannot fail **once rank 14 is observed**."* I re-derive it: if the columns of $A$ span the $14$-dimensional target, every right-hand side is in the column space, $F_5$ included, Rouché–Capelli with full row rank.
- **And r200 immediately limits it.** *"the direction that matters is only half available mod $p$: $\operatorname{rank}_p\le\operatorname{rank}_{\mathbb Q}$... Inconsistency mod $p$ does refute over $\mathbb Q$; **consistency mod $p$ is a screen**."*

**"Both are now theorems" is a strengthening of a source that says one of the two is a screen.** The correcting paragraph below restores r200's reading (*"the sampled rank check is not retired"*), so the block holds both the inflated sentence and its correction, unreconciled, in adjacent paragraphs.

**And the collapse is a statement about the full system only.** For the restricted system the rank is $13$, strictly below the target's $14$, so consistency does **not** follow from the rank, it is exactly the condition $F_5\perp\mathrm{ANN}$ that [L62](../findings/sym3-blocks.md) measures. Since the certificate route runs on the restricted system, *the sentence retires a task on the side of the problem where its argument does not reach*. The block knows this (its heading says so) which makes the unqualified "both" the failure.

**What the theorem does legitimately buy, and the block undersells it.** The retired task was stage 3's *"rank $\le14$ is the right bound but vacuous below $15$ samples"* (recovered from `728012c5`, which is where the quoted task list lived). Before L89 the sampled rank was a **source of a number**; after it, the number is known in advance and the sampled rank becomes a **falsification test of the pipeline**, which is strictly more useful. That is [r204](REVIEW_r204.md)'s line 95 (*"the theorem tells you what the answer must be, which makes it a sharper test than before"*) and the block's own closing clause says it. The block should lead with that instead of with "both are now theorems".

## 4. D3 and D4, the heading writes a cheque two other blocks cash

**D3.** The section heading is *"The rank is a theorem on the full space, and an open question on the restricted one"*. The section beneath it contains three paragraphs, and **none of them says what the restricted map is**. `git` shows why: `5af38a68` put the restricted paragraph directly under the display, and the later heading placement plus `ec35c0b9`'s rewrite left it stranded at [line 159](../findings/sym3-blocks.md), thirty lines below, under [L90](../findings/sym3-blocks.md)'s `####` heading and after the whole $\Theta_5$ certificate section. A reader who trusts L89's heading finds the restricted half nowhere in L89's block.

**D4.** *"An open question on the restricted one"* is also stale. The file settles it below:

| site | what it says about the restricted rank |
| --- | --- |
| L89's heading, [line 120](../findings/sym3-blocks.md) | "an open question" |
| [line 159](../findings/sym3-blocks.md), under L90 | "open in $[1,13]$" |
| [L91](../findings/sym3-blocks.md), [line 167](../findings/sym3-blocks.md) | "tightness is open... $13$ holds unless a second coincidence occurs" |
| [L90](../findings/sym3-blocks.md), [line 147](../findings/sym3-blocks.md) | "**THE RESTRICTED RANK IS $13$**" |
| [L62](../findings/sym3-blocks.md), [line 227](../findings/sym3-blocks.md) ff. | rank $=13$, with the cap a theorem and the value a measurement |

That is four unreconciled strata in one file, of which L89 carries the oldest. [L62](../findings/sym3-blocks.md)'s own Gate 2 note names three of them; L89's heading is the fourth and no note mentions it. **The honest heading is "a theorem on the full space, and a measurement on the restricted one",** which is also the shape [r633](REVIEW_r633.md)/[r634](REVIEW_r634.md) proposed for L62.

## 5. The restricted map, stated precisely, and why exactness does not settle it

The brief asks for this explicitly, so here it is in the form I would put on the record.

**The map.** $K\subset\mathrm{Sym}^3\mathcal W_5^*$ is the subspace of cubics vanishing on the $O(5)$-orbit of $W_0$. It is an $O(5)$-submodule, a point the file proves only at [line 156](../findings/sym3-blocks.md), by the observation that the orbit condition is $p\perp\operatorname{span}\{(gW_0)^3\}$ and that span is a submodule. The restricted map is

$$\mu_K:=\mu\vert_{\mathrm{Sym}^2(K)}\colon\ \mathrm{Sym}^2(K)^{O(5)}\ \longrightarrow\ (\mathrm{Sym}^6\mathcal W_5^*)^{O(5)},\qquad 36\longrightarrow14 .$$

**Why exactness does not settle it, and the block's phrasing is imprecise about which half fails.** Exactness *does* apply to $\mu_K$: it gives $\mathrm{Sym}^2(K)^{O(5)}\twoheadrightarrow(\operatorname{im}\mu_K)^{O(5)}$, so

$$\mathrm{rank}(\mu_K\vert_{\mathrm{inv}})=\dim(\operatorname{im}\mu_K)^{O(5)}.$$

The functor works perfectly. **What is missing is the input hypothesis: $\mu_K$ is not onto $\mathrm{Sym}^6\mathcal W_5^*$**, because every element of its image vanishes at $W_0$ while $\lVert W\rVert^6$ does not. The block's *"the argument does not carry"* is true but reads as though the functor failed. It did not; the surjection it was fed is gone, and the surjectivity of $\mu_K$ onto the vanishing hyperplane is exactly the open statement. [r204](REVIEW_r204.md) line 147 puts the same thing in ideal-theoretic terms: the restricted rank is $13$ iff *the degree-$6$ part of the ideal of the orbit cone is generated by its degree-$3$ part, on invariants*. **That is a generation-in-degree statement, and no exactness argument reaches it.**

**Which of the two the $14$ belongs to: the full one.** So does the $51$. The restricted pair is $(13,23)$ on a domain of $36$.

## 6. The arithmetic, and where each number comes from

The brief asks whether the $65$ is [L88](../findings/sym3-blocks.md)'s and the $14$ [L85](../findings/sym3-blocks.md)'s. Both, uncited, the block carries **no link and no citation at all**. But the two are not equally imported, and that is the more useful answer.

**The $65$ is a moment of [L83](../findings/sym3-blocks.md)'s multiplicity column, and I reproduce it by hand.** With twelve blocks at $m=1$, nine at $m=2$, one at $m=3$ and two at $m=4$:

$$\textstyle\sum_\lambda\binom{m_\lambda+1}{2}=12\cdot1+9\cdot3+1\cdot6+2\cdot10=12+27+6+20=65,$$

with $\sum m_\lambda^2=12+36+9+32=89$ and $\Lambda^2$ taking $89-65=24$, and $\sum m_\lambda=41$. **This is why the $65$ is not an independent check on anything**, precisely the blind spot [r663](REVIEW_r663.md)/[r664](REVIEW_r664.md) found on L83, where $24$, $41$ and $65$ are three moments of one imported column. L89 inherits it.

**The rest of the chain also reproduces by hand, and it all coheres.** I list it because it is the strongest corroboration available for L89's inputs and no block assembles it.

- Even blocks ($\lambda_2$ even) number $16$, carrying $4+4+3+2\cdot5+1\cdot8=8+3+10+8=29$ multiplicities; odd carry $41-29=12$.
- $K$ loses one multiplicity per even block, leaving $m^K$: two blocks at $3$, five at $2$, nine at $1$, eight at $0$. Then $\dim\mathrm{Sym}^2(K)^{O(5)}=2\cdot6+5\cdot3+9\cdot1=12+15+9=36$, and the shape is **two $3\times3$, five $2\times2$, nine scalars**, exactly what [L86](../findings/sym3-blocks.md) states.
- $65=36+29$ is then forced, and $29=13+16$ splits as $(K\otimes N)^{O(5)}$ and $\mathrm{Sym}^2(N)^{O(5)}$ with $N$ the lost line in each even block, since $\sum_{\text{even}}(m_\lambda-1)=29-16=13$. That is [r204](REVIEW_r204.md) line 149's split, reproduced.
- $\sum m_\lambda d_\lambda=1020+315+2310+4125=7770=\binom{37}{3}=\dim\mathrm{Sym}^3\mathcal W_5$.

**Only the $14$ is a computation of its own, and it is the best-supported figure in the block.** Three independent routes: Weyl integration by constant-term extraction in [run_n5_constraint_count.py](../scripts/runs/run_n5_constraint_count.py); Sage's Weyl character ring by Brauer–Klimyk plethysm, sharing no method, in [r204](REVIEW_r204.md) line 28; and [r200](REVIEW_r200.md) line 142 naming a third in `run_n5_sextic_basis.py`. **None is by hand**, and I did not run one, this is the point at which the analysis-only rule bites, and I say so rather than working around it. What a hand derivation of $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$ would buy is the last unclosed input to L89; what it would cost is a Molien/Weyl constant-term extraction over $B_2$, which is a real afternoon's work and not a run.

**So: theorem, or well-dressed subtraction?** The exactness step is a theorem, and the brief's framing lets it off too lightly in one direction and too harshly in the other. Too harshly, because surjectivity is elementary and the $65$ is hand-derivable from a table this record has already audited. Too lightly, because the $51$ is a subtraction of two imported numbers *and* the display attaches it to an object for which it is false. **The honest one-line statement: given [L85](../findings/sym3-blocks.md)'s $14$, $\mathrm{rank}(\mu\vert_{\mathrm{inv}})=14$ is a theorem in four lines with no computation, and the nullity $51$ is that theorem minus [L83](../findings/sym3-blocks.md)'s column.**

## 7. What this does to the chain, the brief's deliverable

**No measured link drops. Not [L59](../findings/sym3-blocks.md)'s, not [L62](../findings/sym3-blocks.md)'s, not [L87](../findings/sym3-blocks.md)'s.** I want this stated flatly because the brief hoped otherwise.

The two measured links the companion audit found in [L87](../findings/sym3-blocks.md) → [L59](../findings/sym3-blocks.md) → [L62](../findings/sym3-blocks.md) are:

| link | what measures it | does L89 reach it? |
| --- | --- | --- |
| the $36$, via the rank-one step, every even block's evaluation map is nonzero | [L87](../findings/sym3-blocks.md)'s mod-$\mathbb F_{46337}$ Gram rank of $3570$ on $3700$ orbit points, meeting the $\sum d_\lambda$ cap | **No.** This is a statement about which cubics vanish at $W_0$. Exactness of $(-)^{O(5)}$ says nothing about the evaluation functional at a point, and $\mu$ does not appear in it. |
| $\mathrm{rank}(\mu_K\vert_{\mathrm{inv}})\ge13$, hence $\dim\mathrm{ANN}=1$ and $F_5\in\operatorname{image}$ | [L62](../findings/sym3-blocks.md)'s sampled mod-$p$ rank attaining the proved cap of $13$ | **No.** The cap is a theorem already; the *lower* bound is what is measured, and a lower bound on a restricted rank needs surjectivity onto the hyperplane, which is the open question §5 names. |

**And the transversality route, which is the only place L89's numbers touch the restricted problem, does not get there either.** Inside the $65$, the kernel of $\mu\vert_{\mathrm{inv}}$ has dimension $51$ and $\mathrm{Sym}^2(K)^{O(5)}$ has dimension $36$, so

$$\dim\!\big(\ker(\mu\vert_{\mathrm{inv}})\cap\mathrm{Sym}^2(K)^{O(5)}\big)\ \ge\ 51+36-65\ =\ 22,\qquad\text{hence}\qquad \mathrm{rank}(\mu_K\vert_{\mathrm{inv}})\ \le\ 36-22\ =\ 14 .$$

That is weaker than the proved $13$, so it closes nothing. **It does earn one thing the record should keep**, and it is the only new content I can offer L89: with the measured rank $13$, the intersection is $23$, exactly **one dimension above transverse**, and that single excess dimension *is* $\dim\mathrm{ANN}=1$. So L89's $51$ turns [L62](../findings/sym3-blocks.md)'s $\dim\mathrm{ANN}=1$ and [L91](../findings/sym3-blocks.md)'s *"$13$ holds unless a second coincidence occurs"* into a quantitative statement, the order-$1$ vanishing theorem is exactly what forces the failure of transversality, and it forces at most one dimension of it. Three separately-recorded facts become one picture. **It is corroboration, not a proof, and it does not move a measured link to the proved side.**

**One link L89 *does* supply, and nobody claims it.** [L59](../findings/sym3-blocks.md)'s body, at [line 205](../findings/sym3-blocks.md), argues *"$\mathrm{Cat}$ is injective on the invariant sextics --- $\mu$ is surjective, so its adjoint is injective --- placing a copy of the $14$ inside the $65$."* **That "$\mu$ is surjective" is L89's hypothesis, used uncited, one hundred lines below the block that owns it.** L89 is cited nowhere on the record. So the correct chain edge is L89 $\to$ L59, currently unrecorded in both directions, and it costs the record nothing to add: L89's surjectivity was already load-bearing for L59 before L89 existed.

## 8. The checklist the brief supplies

**Provenance.** Checked with `git log -S` on the display, the heading, the exactness sentence and the quoted task list; reported in §2 and §3. **Nothing is manufactured here**, the r204 attribution is accurate to its source and the r200 attribution overstates its source without inventing it. This is a better result than the neighbouring blocks, where [L83](../findings/sym3-blocks.md) and [L84](../findings/sym3-blocks.md) each carry a provenance clause `git` refutes.

**Hedging clauses**, each taken in turn.

| clause | verdict |
| --- | --- |
| *"by exactness"* | **earned.** The functor argument is exactly what is used, correctly, and needs only right-exactness. |
| *"which is surjective and $O(5)$-equivariant"* | **earned, and cheap**, one monomial line and one multiplicativity line. Stated as if imported; it is not. |
| *"a theorem on the full space"* | **earned**, once the display is corrected to name $\mu\vert_{\mathrm{inv}}$. |
| *"$14$ exactly"* | **false of $A$**, true of $\mu\vert_{\mathrm{inv}}$. D1. |
| *"open question on the restricted one"* | **stale.** D4. |
| *"No sample points are needed for it"* | **true of the abstract rank, and the sentence it opens then over-reaches.** |
| *"both are now theorems"* | **refuted by its own source and by the paragraph below it.** D2. |
| *"which makes it sharper rather than unnecessary"* | **earned**, and it is the block's best sentence. |

**Duplication, in the four kinds.** Numbered duplication: none, no other numbered result states the full-space rank. Unnumbered restatement: **yes**, twice, both in [L59](../findings/sym3-blocks.md)'s block, the surjectivity step at [line 205](../findings/sym3-blocks.md), and the $51$ at [line 189](../findings/sym3-blocks.md) (*"$\ker\mu$ is $23$-dimensional restricted and $51$ unrestricted"*). Cross-file: none; the only other "reductive in characteristic zero" on the record is [brauer-pairing.md:58](../findings/brauer-pairing.md), which uses it for semisimplicity of $V^{\otimes f}$ and is a different statement. Report copy: none, [report/](../report/) carries no L89 and no $51$.

**Does the block's own file settle it, above or below?** Below, twice, and against the heading: [L90](../findings/sym3-blocks.md) and [L62](../findings/sym3-blocks.md) both close the restricted question the heading calls open. Above, [L88](../findings/sym3-blocks.md) supplies the $65$ and [L85](../findings/sym3-blocks.md) the $14$, neither cited. **This is the file's recurring shape**, the companion audits found L84's consumer retired twice below it, and L59's proof living under L90's heading. L89 is the same defect a third time.

**Do all pointers resolve?** **The block has no pointers.** No link to [L85](../findings/sym3-blocks.md), [L88](../findings/sym3-blocks.md) or [L83](../findings/sym3-blocks.md); no script; no review file for either of the two reviewers it names in prose. The two reviewer numbers do resolve to real files, [REVIEW_r200.md](REVIEW_r200.md) and [REVIEW_r204.md](REVIEW_r204.md), and both say substantially what the block attributes to them, subject to D2. The index row at [INDEX-results.md](../findings/INDEX-results.md) resolves and (as on L59), **states the result more precisely than the block does**, writing $\mathrm{rank}(\mu\vert_{\mathrm{inv}})=14$ where the block's display writes $\mathrm{rank}(A)$.

## 9. Owed repairs, in the order I would make them

1. **The display becomes $\mathrm{rank}(\mu\vert_{\mathrm{inv}})=\dim(\mathrm{Sym}^6\mathcal W_5^*)^{O(5)}=14$, nullity $51$.** One symbol, and D1 closes. No number moves.
2. **"both are now theorems" becomes "the sampled rank check now has a predicted answer, which makes it a test of the pipeline rather than a source of the number"**, r200's reading and r204's, and the block's own closing clause already says it.
3. **The heading's second half becomes "and a measurement on the restricted one"**, and the section gains one sentence naming $\mu_K:\mathrm{Sym}^2(K)^{O(5)}\to(\mathrm{Sym}^6)^{O(5)}$ and saying that what fails there is surjectivity, not exactness.
4. **Cite [L85](../findings/sym3-blocks.md) for the $14$ and [L88](../findings/sym3-blocks.md) for the $65$**, and record the edge L89 $\to$ [L59](../findings/sym3-blocks.md) in both blocks.
5. **Add the one line surjectivity actually needs** (every degree-$6$ monomial splits into two of degree $3$) so the reader is not left wondering whether it was imported. Two dozen words, and it is the only step a sceptical reader will stop at.

**None of these moves a number.** $14$, $65$, $51$, $36$, $29$ and $13$ all stand exactly as written.

## 10. Standing rule

**Analysis only. I ran no computation**, no plethysm, no rank, no character sum, no search. Every arithmetic check above is by hand on objects I constructed for the purpose and is reported as a screen. One item is blocked by the rule and I name it rather than working round it: **an independent confirmation of $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$**, which is the last input to L89 with no hand derivation on the record. A run would decide it; agreement would leave L89 resting on a figure with four computational confirmations and no hand one, and disagreement would refute [L85](../findings/sym3-blocks.md) and take L89, [L62](../findings/sym3-blocks.md) and the certificate's cap with it. **The better answer is a hand Weyl-integration derivation, which is analysis and which nobody has written.**

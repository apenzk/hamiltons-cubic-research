# Review r691, Lemma L92, the highest-weight route needs no Casimir separation

**Reviewer A of an independent pair on identical briefs. Target: [findings/sym3-blocks.md:173](../findings/sym3-blocks.md#L173), `#### Lemma L92, the highest-weight route needs no Casimir separation`, whose whole body is the single paragraph at [:175](../findings/sym3-blocks.md#L175).** Anchored by heading text, then by line, as the brief requires.

## Verdict: CONFIRMED

**The claim is true, the root arithmetic is right, and the proof is two lines. It is one of the few blocks in this file that is exactly as strong as it says it is.** I re-derived every number by hand and found no mathematical error anywhere in the block or in the paragraph it depends on.

What I did find is structural, and there are five items:

- **The displayed argument does not prove the heading; the sentence that does is in an italic aside.** The root-lattice computation shows only that two particular highest weights are not weights of each other. The heading is a statement about the *construction*, and it follows from the aside ("*a weight-$\lambda$ vector killed by the raising operators generates $V_\lambda$*") which is universal and needs no collision, no pair, and no $B_2$. The block's evidence and its conclusion are in the wrong relation.
- **The weight basis is unstated, and under the other reading the claim is false in one direction.** In $\omega$-coordinates $(3,3)-(4,1)=\alpha_2$ exactly, which *is* in the cone. The block is nonetheless self-pinning (its own $\alpha_1=(1,-1)$, $\alpha_2=(0,1)$ are $e$-coordinates and can be read back) so the $e$/$\omega$ trap that bit [L83](../findings/sym3-blocks.md) does not bite here. It is still one word of repair.
- **The attribution is wrong.** The figures $45$, $46$, $44$ and *thirteen* are [r180](REVIEW_r180.md)'s, not [r179](REVIEW_r179.md)'s, and the introducing commit says so in terms.
- **"Non-colliding" is a lossy compression.** Four of the thirteen blocks named are members of colliding pairs. [r180](REVIEW_r180.md) wrote "*none of which shares $(4,1)$'s Casimir value*", which is true; the block dropped the qualifier.
- **The block's own antecedent lives under another lemma's heading.** "even that one" refers to [:171](../findings/sym3-blocks.md#L171), which sits inside [L91](../findings/sym3-blocks.md)'s block and is [L87](../findings/sym3-blocks.md)'s subject.

**Provenance is clean, and this is worth stating against the run this audit is in.** The block's correction clause describes a correction that really happened, in a commit that really says what the clause says. That is the second clean provenance in this file against [L84](../findings/sym3-blocks.md)'s manufactured one.

## Readings adopted

| symbol | reading I use | why |
| --- | --- | --- |
| $(\lambda_1,\lambda_2)$ | **$e$-coordinates**, $\lambda=\lambda_1e_1+\lambda_2e_2$; dominance is $\lambda_1\ge\lambda_2\ge0$ | forced three ways: the block's own $\alpha_1=(1,-1)$ and $\alpha_2=(0,1)$ are $e$-coordinates; $\dim V_{(2,2)}=35=\dim\mathcal W_5$; and $c_2(\lambda)=\lambda_1(\lambda_1+3)+\lambda_2(\lambda_2+1)$ holds only there. **Unstated in the block** |
| $\alpha_1,\alpha_2$ | the **simple roots** $e_1-e_2$ and $e_2$ of $B_2$, long and short, *not* the fundamental weights, which are $\omega_1=(1,0)$ and $\omega_2=(\tfrac12,\tfrac12)$ | positive roots of $B_2$ are $e_1-e_2$, $e_2$, $e_1$, $e_1+e_2$; the two indecomposables are the first two. The block's coordinates are exactly these |
| $V_\lambda$ | the irreducible $\mathfrak{so}(5)$-module of highest weight $\lambda$ | the file's use throughout |
| "a weight of $V_\lambda$" | $\mu$ with $V_\lambda[\mu]\ne0$ | the only reading under which the quoted saturation statement is the standard theorem |
| $\dim V_{(a,b)}$ | $\tfrac16(2a+3)(2b+1)(a-b+1)(a+b+2)$ | Weyl's formula at $B_2$ with $\rho=(3/2,1/2)$; re-derived, and it reproduces every subscript in [L83](../findings/sym3-blocks.md)'s table |
| block extent | a `####` heading runs to the next `####` | otherwise L92 has one line and no antecedent. **The record does not fix this**, and [r633](REVIEW_r633.md)/[r634](REVIEW_r634.md) read it two ways on [L62](../findings/sym3-blocks.md). It does not change any verdict here |

**No convention repaired in [conventions.md](../findings/conventions.md) bears on L92.** $\theta_0(n)$, $\Theta_n$ and $S_{XYZ}$ are metric objects and this block is pure representation theory. The one entry that touches this file, *"THE LETTER $B$ MEANS TWO THINGS"*, this file's $B(X,Y)=-\tfrac12\operatorname{tr}(XY)$ against the Killing $B_K=-6B$, does not enter L92, which never evaluates a Casimir. The [conventions.md](../findings/conventions.md) Casimir-sign entry $C=-\sum_a\rho(A_a)^2$ is what makes the $c_2$ values I use below positive, and I adopt it.

## 1. The derivation, cold

### 1.1 The saturation theorem is the right one and it is standard

For $V_\lambda$ irreducible with highest weight $\lambda$, every weight $\mu$ of $V_\lambda$ satisfies

$$\lambda-\mu\in\mathbb Z_{\ge0}\alpha_1+\mathbb Z_{\ge0}\alpha_2 .$$

*Proof.* $V_\lambda=U(\mathfrak n^-)v_\lambda$ for a highest-weight vector $v_\lambda$, and $U(\mathfrak n^-)$ is spanned by monomials in the negative root vectors, each of which lowers the weight by a positive root. Every positive root is a non-negative integer combination of $\alpha_1,\alpha_2$. $\square$

This is the correct statement to invoke and the block invokes it correctly. It needs $\lambda$ to be *the* highest weight and $V_\lambda$ irreducible; both hold.

### 1.2 The simple roots, verified

$B_2=\mathfrak{so}(5)$ has positive roots $e_1-e_2$, $e_2$, $e_1$, $e_1+e_2$, two long, two short. The indecomposable ones are $\alpha_1=e_1-e_2=(1,-1)$ and $\alpha_2=e_2=(0,1)$; indeed $e_1=\alpha_1+\alpha_2$ and $e_1+e_2=\alpha_1+2\alpha_2$, so neither is simple. **The block's $\alpha_1,\alpha_2$ are the simple roots in the $e$-basis, and they are not the fundamental weights**, which are $\omega_1=e_1=(1,0)$ and $\omega_2=\tfrac12(e_1+e_2)=(\tfrac12,\tfrac12)$. As a cross-check, $\rho=\omega_1+\omega_2=(3/2,1/2)$, which is the half-sum of the four positive roots. ✓

### 1.3 The surviving collision is $(4,1)$ against $(3,3)$, and I derived the whole multiset

The brief asks me to name the pair and check the argument against exactly that pair. I computed $c_2(\lambda)=\lambda_1(\lambda_1+3)+\lambda_2(\lambda_2+1)$ over all $24$ blocks of [L83](../findings/sym3-blocks.md)'s table:

| $c_2$ | blocks |
| --- | --- |
| $0,4,10,12,16,18,20,24,28,34,42,46,48,52,54,66,74,96$ | $(0,0)$, $(1,0)$, $(2,0)$, $(2,1)$, $(2,2)$, $(3,0)$, $(3,1)$, $(3,2)$, $(4,0)$, $(4,2)$, $(5,1)$, $(5,2)$, $(4,4)$, $(5,3)$, $(6,0)$, $(6,3)$, $(6,4)$, $(6,6)$, one each |
| **$30$** | $(4,1)$ and $(3,3)$ |
| **$40$** | $(4,3)$ and $(5,0)$ |
| **$60$** | $(5,4)$ and $(6,2)$ |

$21$ distinct values, exactly three colliding pairs, [L84](../findings/sym3-blocks.md)'s figures reproduce, independently of that block.

Which survive is [L86](../findings/sym3-blocks.md)'s parity rule plus [L87](../findings/sym3-blocks.md), and I checked it by hand rather than taking it: a block dies iff $\lambda_2$ is even and its multiplicity is $1$. At $c=60$ both $(5,4)$ and $(6,2)$ have even $\lambda_2$ and multiplicity $1$, so both die. At $c=40$, $(5,0)$ dies and $(4,3)$ has $\lambda_2=3$ odd, so it survives alone. At $c=30$, $(4,1)$ and $(3,3)$ both have odd $\lambda_2$ and both survive. **The surviving collision is $(4,1)$ against $(3,3)$, exactly as [:171](../findings/sym3-blocks.md#L171) says.** ✓

Two free confirmations fell out while doing this, and both hold: the $\lambda_2$-even blocks number exactly $16$ and their dimensions sum to exactly $3570$; and exactly eight of the twelve multiplicity-$1$ blocks are even, namely the eight [L86](../findings/sym3-blocks.md) names.

### 1.4 The root-lattice check on that pair

Writing $a\alpha_1+b\alpha_2=(a,\,b-a)$:

$$(4,1)-(3,3)=(1,-2)=1\cdot\alpha_1+(-1)\cdot\alpha_2,\qquad (3,3)-(4,1)=(-1,2)=(-1)\cdot\alpha_1+1\cdot\alpha_2 .$$

Each has a coefficient $-1$, so neither lies in $\mathbb Z_{\ge0}\alpha_1+\mathbb Z_{\ge0}\alpha_2$. By §1.1, **$(3,3)$ is not a weight of $V_{(4,1)}$ and $(4,1)$ is not a weight of $V_{(3,3)}$.** The block's two displayed identities are correct as printed. ✓

Dimensions check the labels are the ones meant: $\dim V_{(4,1)}=\tfrac16\cdot11\cdot3\cdot4\cdot7=154$ and $\dim V_{(3,3)}=\tfrac16\cdot9\cdot7\cdot1\cdot8=84$, matching the table.

### 1.5 What the display does *not* give, and what does

**The heading is a statement about the construction at [:78](../findings/sym3-blocks.md#L78)**, which "*intersects the kernels of both raising operators on each block's weight space*". §1.4 says nothing about that construction. What settles it is one line:

> In any finite-dimensional $\mathfrak g$-module $M$, $\ker e_1\cap\ker e_2$ restricted to the weight-$\lambda$ space is exactly the multiplicity space $M_\lambda$ of $V_\lambda$ in $M$.

*Proof.* Decompose $M=\bigoplus_\nu M_\nu\otimes V_\nu$ by complete reducibility. A weight-$\lambda$ vector killed by both raising operators generates a highest-weight module of highest weight $\lambda$, finite-dimensional, hence $\cong V_\lambda$, so it lies in $M_\lambda\otimes v_\lambda$; conversely every vector of $M_\lambda\otimes v_\lambda$ is such. $\square$

**No Casimir eigenvalue is read at any point.** This holds for every block, colliding or not, at every $n$, and does not care whether $(3,3)$ contributes to the weight-$(4,1)$ space of $\mathrm{Sym}^3\mathcal W_5$. So the heading is true, and its proof is shorter and stronger than the block's display.

The block *has* this argument, compressed into an italic aside as "*a weight-$\lambda$ vector killed by the raising operators generates $V_\lambda$ by definition*". Two small imprecisions in it:

- **"by definition" is not right.** Such a vector generates a highest-weight module by definition; that it is irreducible and $\cong V_\lambda$ needs finite-dimensionality (equivalently Weyl's complete reducibility). One clause.
- **It is a statement about one vector, and the construction needs the statement about the whole space.** The $\supseteq$ half is trivial and the block does not say it. One more clause.

Neither is a defect in the claim. Both are why the aside reads as weaker than it is.

### 1.6 The basis, and the one place it would bite

The block never says which basis its weight labels are in, and the same file's prose at [:7](../findings/sym3-blocks.md#L7) works in $\omega$-coordinates ("$[2,2]=2e_1+2e_2$ solves to $4\omega_2$"). **Under an $\omega$ reading the block's own conclusion fails in one direction**: $3\omega_1+3\omega_2=(4\tfrac12,1\tfrac12)$ and $4\omega_1+\omega_2=(4\tfrac12,\tfrac12)$ differ by $(0,1)=\alpha_2$ exactly, so $(4,1)$ *would* be a weight of $V_{(3,3)}$ and "neither difference qualifies" would be false.

**It does not bite, because the block pins its own basis.** $\alpha_1=(1,-1)$ and $\alpha_2=(0,1)$ are $e$-coordinates; in $\omega$-coordinates the simple roots read $(2,-2)$ and $(-1,2)$. A reader who takes the $\alpha$'s at face value is in the right basis. **This is a strictly better position than [L83](../findings/sym3-blocks.md)'s table, whose labels carry no such internal anchor**, and it is worth one word of repair rather than a defect grade.

## 2. What it retires

### 2.1 Two audits are right: L92 retires [L84](../findings/sym3-blocks.md)'s purpose

**Confirmed.** The chain is:

| step | what remains needing Casimir separation |
| --- | --- |
| [L84](../findings/sym3-blocks.md) as stated | all $24$ blocks, three colliding pairs, the pair $(C_2,C_4)$ forced |
| after [L86](../findings/sym3-blocks.md)/[L87](../findings/sym3-blocks.md) | one pair, $(4,1)$ against $(3,3)$, §1.3, hand-derived |
| after L92 | **none**, §1.5, and the argument never consults a Casimir for any block |

**So on the route actually built, nothing consumes L84.** The correct record of this is that [L84](../findings/sym3-blocks.md) is **superseded as a dependency and untouched as a theorem**: its forcing statement is a genuine theorem about $Z(U(\mathfrak{so}(5)))$, confirmed by [r673](REVIEW_r673.md) and [r674](REVIEW_r674.md) and independent of anything L92 says. Marking it "superseded" without that qualifier would be wrong, nothing in L92 casts any doubt on it.

**The direction of the retirement matters and the block gets it backwards in presentation.** L92 does not defeat L84; it makes L84 unnecessary *for one particular construction*. A Casimir-projector method would still need L84 in full. The block's aside says this ("*the highest-weight method, which is the one built here*" in the original phrasing, now dropped) and the current text does not.

### 2.2 The cross-reference, one direction of two

[L84](../findings/sym3-blocks.md) points down at L92, at [:56](../findings/sym3-blocks.md#L56). `git log` dates that line to [b4cccb80](../findings/sym3-blocks.md) on 2026-09-04, it is one day old, added by the audit that produced [r673](REVIEW_r673.md)/[r674](REVIEW_r674.md), which is exactly the finding the brief anticipated.

**L92 points at nothing.** Its block carries **zero markdown links**, no [L84](../findings/sym3-blocks.md), no [L87](../findings/sym3-blocks.md), no [L91](../findings/sym3-blocks.md), no [REVIEW_r179.md](REVIEW_r179.md) or [REVIEW_r180.md](REVIEW_r180.md) for the reviewers it names by number, and no [run_n5_highest_weight.py](../scripts/runs/run_n5_highest_weight.py) for the construction the heading is about. Nothing is broken, because there is nothing to break; the pointer question has no failures to report and no successes either. Every neighbouring block in this file links its reviews.

### 2.3 Is L92 used anywhere? No.

I searched the whole repository outside [reviews/](.) and [agent_logs/](../agent_logs/):

| where | L92 or its content |
| --- | --- |
| [findings/sym3-blocks.md](../findings/sym3-blocks.md) | the block itself, and [L84](../findings/sym3-blocks.md)'s one-day-old note |
| [findings/INDEX-results.md:107](../findings/INDEX-results.md#L107) | the row, `Lemma`, *"Gate 2: no verdict on the record"*, short name matching the heading. **Resolves** |
| [results.md](../results.md) | nothing |
| [plan.md](../plan.md) | nothing |
| [report/](../report/) | nothing |
| the rest of [findings/](../findings/) | nothing |

**It is an observation about a construction, consumed by no argument.** Its only function on the record is to bound [L84](../findings/sym3-blocks.md)'s scope, a function [L84](../findings/sym3-blocks.md) now performs on its own behalf. That is a legitimate thing for a block to be, and the honest description is a scope note on the method rather than a result about the objects; the `Lemma` label is defensible, since the statement is true and proved, but it is method-hygiene, not mathematics about $\mathcal W_5$.

### 2.4 The file settles it above, and the block does not point there

The brief asks whether the file already answers its own question. **It does, ninety-five lines above**, at [:78](../findings/sym3-blocks.md#L78): the construction is described as complexifying, splitting into Cartan eigenspaces, and intersecting the kernels of the two raising operators. **That description contains no Casimir**, so a reader who has read it already knows L92's conclusion. This is the seventeenth instance of the pattern the brief names.

## 3. Scope

**$B_2=\mathfrak{so}(5)$, so $n=5$, but the true scope is wider than the block's, not narrower.**

- **What the display licenses**: nothing beyond the two named blocks at $n=5$.
- **What the block's aside licenses**: the heading, at every $n$, for every reductive $\mathfrak g$ and every finite-dimensional module. §1.5 uses no property of $B_2$. **The block states at $n=5$ a fact that is not about $n=5$**, which is the opposite of this file's usual failure mode.
- **What it does not license, and nobody has claimed it does**: anything about Conjecture A. [L61](../findings/sym3-blocks.md)'s scope note and the file's own *"It does not lift"* at [:181](../findings/sym3-blocks.md#L181) apply: the $n=5$ machinery carries the Lovelock syzygy, the cubic invariant space being one-dimensional at $n\le5$ and two-dimensional from $n\ge6$.

### 3.1 The route register, which is the finding

**[routes.md](../routes.md) has no row for the $n=5$ certificate route at all**, so it cannot say whether the highest-weight route is live, dormant or closed. The nearest row is **R1**, *"universal certificate"*, closed, but R1's mechanism is *"one SOS certificate rational in $n$, PSD for all $n\ge12$"*, a different object at a different dimension. The entire apparatus of [sym3-blocks.md](../findings/sym3-blocks.md), twelve numbered results, [L59](../findings/sym3-blocks.md) and [L61](../findings/sym3-blocks.md) through [L62](../findings/sym3-blocks.md), [L83](../findings/sym3-blocks.md) through L92, is unregistered.

**My reading of the status, offered because the register does not carry one:** the route is **finished and dormant**. It produced an exact rational certificate, its conclusion is recorded ([L61](../findings/sym3-blocks.md), [L62](../findings/sym3-blocks.md)), and the file states in its own words that it does not lift. That is not "closed" in the register's sense (nothing killed it) and not "live" either, since no open item consumes it. **The register has no third status, which is why the row is missing.** A row would owe: mechanism, the certificate it produced, and the clearance criterion a successor at $n\ge12$ must meet, which the file already knows (the Lovelock syzygy at $n\le5$ against a two-dimensional cubic invariant space from $n\ge6$).

## 4. Hedging clauses, one at a time

| clause | verdict |
| --- | --- |
| "**never meets even that one**" | **True**, and "even that one" is doing honest work, it concedes that two of three collisions died elsewhere. Its antecedent is at [:171](../findings/sym3-blocks.md#L171), under [L91](../findings/sym3-blocks.md)'s heading; see §5 |
| "**neither difference qualifies**" | **True in the $e$-basis** (§1.4), **false in one direction under an $\omega$ reading** (§1.6). Self-pinned, so not a defect in substance |
| "**needs no Casimir separation**" (heading) | **True**, and provable in two lines. Not proved by the block's display; proved by its aside |
| "**needs no Casimir to separate any block, colliding or not**" | **True**, and this is the strongest sentence in the block. The word "therefore" attaches it to the aside, not to the display two sentences earlier, a reader following the argument left to right is being pointed at the wrong premise |
| "**they share $45$ weights**" | **True, and I verified it by hand.** The common dominant weights of $V_{(4,1)}$ and $V_{(3,3)}$ are $(3,2),(3,1),(3,0),(2,2),(2,1),(2,0),(1,1),(1,0),(0,0)$, with $W(B_2)$-orbits of sizes $8,8,4,4,8,4,4,4,1$, summing to **$45$** exactly. Neither highest weight is shared, as §1.4 requires |
| "**thirteen other … blocks**" | **True, and I verified it by hand.** $(4,1)$ is a weight of $V_{(a,b)}$ iff $a\ge4$ and $a+b\ge5$; over the $24$ blocks that gives $(4,1)$ itself and exactly thirteen others ($(4,2),(4,3),(4,4),(5,0),(5,1),(5,2),(5,3),(5,4),(6,0),(6,2),(6,3),(6,4),(6,6)$), matching [r180](REVIEW_r180.md)'s list element for element |
| "**non-colliding**" | **Lossy.** Four of those thirteen ($(4,3)$, $(5,0)$, $(5,4)$, $(6,2)$), *are* members of colliding pairs. **The intended and correct sense is "sharing no Casimir value with $(4,1)$"**, which holds: their $c_2$ values are $34,40,48,40,42,46,52,60,54,60,66,74,96$ and none is $30$. [r180](REVIEW_r180.md) wrote the qualifier; the block dropped it |
| "**$44$ of the $46$ dimensions**" | **Not checkable by hand at reasonable cost, and not load-bearing.** See §7 |

## 5. Structure, the antecedent under another heading

**L92's first sentence begins "And" and refers to "even that one", and neither the conjunction nor the demonstrative has a referent inside L92's block.** The referent is [:171](../findings/sym3-blocks.md#L171), *"Only $c=30$ survives, the pair $(4,1)$ and $(3,3)$"*, which sits between [L91](../findings/sym3-blocks.md)'s heading at [:163](../findings/sym3-blocks.md#L163) and L92's at [:173](../findings/sym3-blocks.md#L173), and is therefore inside [L91](../findings/sym3-blocks.md)'s block under any reading of the `####` boundary.

**That paragraph is [L87](../findings/sym3-blocks.md)'s subject, not [L91](../findings/sym3-blocks.md)'s.** [L91](../findings/sym3-blocks.md) is the identity Gram and the lower bound $1$; the paragraph is a consequence of the orbit constraint killing eight blocks. It is the brief's "one block's proof under another's heading", in the mild form where what is misfiled is a premise rather than a proof.

**This is a heading-placement artefact, not a rewrite.** [8d869d2c](../findings/sym3-blocks.md) placed ten `####` headings on 2026-09-02 over narrative that predates them, promising "*headings only: no statement, proof or ordering is altered*", and it kept that promise. The paragraph was already where it is; the heading arrived above it. **The promise is exactly why the defect exists**: placing headings on continuous prose without moving anything guarantees that some paragraphs land under the wrong one.

The repair is to move [:171](../findings/sym3-blocks.md#L171) into L92's block, where it is the premise, or into [L87](../findings/sym3-blocks.md)'s, where it is the conclusion. It reads as [L91](../findings/sym3-blocks.md)'s in neither.

## 6. Provenance, checked on `git`, and clean

The brief flags that a provenance clause in this file was found manufactured today. **L92's is not.** Three commits, all real, all saying what the block says they say:

| commit | what it did | does the block's account match? |
| --- | --- | --- |
| [20cb594d](../findings/sym3-blocks.md), 2026-08-28 | introduced the paragraph. Its body printed **$(3,3)-(4,1)=-\alpha_1+2\alpha_2$**, which is $(-1,3)$ and wrong, and claimed "*their $\mathrm{Sym}^3$ weight spaces are disjoint*", which is false |, |
| [40c8d4d2](../findings/sym3-blocks.md) | reviewer 179's fix: corrected the coefficient to $-\alpha_1+\alpha_2$, deleted the disjointness claim, and added the universal argument. Its commit body states all three in terms | **Yes.** The block's "*Reviewer 179 corrects two things here*" describes this commit accurately |
| [601cef76](../findings/sym3-blocks.md) | replaced "*they share $(0,0)$*" with "*they share $45$ weights, and $44$ of the $46$ dimensions … thirteen other, non-colliding blocks*" | **Partly, see below** |

**The one provenance defect is an attribution, and it is small.** [601cef76](../findings/sym3-blocks.md)'s own body reads "*180 sharpens claim 3: the two modules share 45 weights, and 44 of the 46 dimensions at weight (4,1) come from thirteen other non-colliding blocks*", and [REVIEW_r180.md:118](REVIEW_r180.md#L118) carries those figures while [REVIEW_r179.md:115](REVIEW_r179.md#L115) carries only "*(0,0) is dominant and below both*". **The block attributes [r180](REVIEW_r180.md)'s sharpening to reviewer 179**, because the sentence was edited in place and kept its original attribution. Both reviewers are real, both reviews exist, and neither is misrepresented in substance, only the credit is wrong.

**One thing [r180](REVIEW_r180.md) asked for was not done.** [REVIEW_r180.md:120](REVIEW_r180.md#L120) gives the real reason as "*$\ker(e_1)\cap\ker(e_2)$ on the weight-$\lambda$ space of any finite-dimensional module is exactly the multiplicity space $M_\lambda$*", and [REVIEW_r180.md:181](REVIEW_r180.md#L181) recommends putting that in the block. **The block carries [r179](REVIEW_r179.md)'s weaker one-vector version instead**, which is §1.5's first imprecision, traced to its source.

## 7. What I could not decide, and what would decide it

**Per the analysis-only rule I ran nothing, and one figure needs a run.**

- **"$44$ of the $46$ dimensions at weight $(4,1)$".** Verifying $46$ means computing $\sum_\lambda m_\lambda\dim V_\lambda[(4,1)]$ over the fourteen contributing blocks, i.e. fourteen Freudenthal recursions on modules up to dimension $810$. That is a computation and I have no approval for it.
  - **What a run would decide**: whether the figures $46$ and $44$ are right.
  - **What each outcome would mean**: *nothing for the verdict either way.* The sentence is a corrective aside explaining why disjointness was the wrong reason; the heading's proof (§1.5) is independent of it, and holds whatever those numbers are. The two structural halves of the same sentence (the thirteen blocks and their Casimir values), I verified by hand in §4, and both check.
  - **The figures also stand in [REVIEW_r180.md:120](REVIEW_r180.md#L120)** with the thirteen blocks enumerated, and that enumeration matches my hand derivation exactly, which is corroboration short of a check.
- **No screening was needed.** Every positive claim in this review is derived by hand above; none rests on a machine.

## 8. Summary of what I would change

| # | change | why |
| --- | --- | --- |
| 1 | **Lead with the universal argument and demote the display.** State $\ker e_1\cap\ker e_2$ on the weight-$\lambda$ space $=M_\lambda$, then keep the $(4,1)$/$(3,3)$ computation as the illustration it is | §1.5. The block's conclusion currently follows from its aside, not from its display |
| 2 | **Say "in $e$-coordinates"** | §1.6. One word; the claim is false in one direction under the $\omega$ reading the same file uses |
| 3 | **Re-attribute the $45$/$46$/$44$/thirteen to [r180](REVIEW_r180.md)**, and link both reviews | §6. [601cef76](../findings/sym3-blocks.md)'s own body names 180 |
| 4 | **Restore [r180](REVIEW_r180.md)'s qualifier**: "*thirteen other blocks, none sharing $(4,1)$'s Casimir value*" | §4. Four of the thirteen are colliding blocks in this file's own sense |
| 5 | **Move [:171](../findings/sym3-blocks.md#L171) out of [L91](../findings/sym3-blocks.md)'s block**, into L92's or [L87](../findings/sym3-blocks.md)'s | §5. L92's opening demonstrative has no referent in its own block |
| 6 | **Point back at [L84](../findings/sym3-blocks.md)**, one clause saying the theorem stands and its consumer does not, and that a Casimir-projector method would still need it in full | §2.1, §2.2. The pointer exists downward only, and is one day old |
| 7 | **Open a [routes.md](../routes.md) row for the $n=5$ certificate route** and give it a status | §3.1. Twelve numbered results sit in no route |
| 8 | *(optional)* **Say the scope is wider than $n=5$** | §3. The aside's argument uses nothing about $B_2$ |

**None of these changes a number, and none changes the verdict.** The mathematics of L92 is correct, short, and correctly concluded.

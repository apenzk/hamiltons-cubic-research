# Review r692, Lemma L92, the highest-weight route needs no Casimir separation

**Reviewer B of an independent pair on identical briefs. Target: [findings/sym3-blocks.md](../findings/sym3-blocks.md), `#### Lemma L92, the highest-weight route needs no Casimir separation` (line 173 as of this audit), and the paragraph it continues from, `**Two of the three Casimir collisions vanish with them.**` (line 171), which sits under [L91](../findings/sym3-blocks.md)'s heading.**

**Standing rule inherited and obeyed: analysis only. No search, sweep, plethysm or rank computation was run. Everything below is by hand from the definitions.**

## Verdict: CONFIRMED

**The claim is true, the arithmetic is right in both directions, and the block is exactly as strong as it says it is.** The brief asked for this to be said plainly when it holds, and it holds: after [L87](../findings/sym3-blocks.md) exactly one $c_2$ collision survives, it is the pair $(4,1)$ / $(3,3)$, neither of those weights is a weight of the other's module, and the highest-weight construction needs no Casimir at any block, colliding or not.

Five defects, none of them mathematical:

- **The argument is basis-sensitive and the block never names the basis, and the one available misreading flips the second half to false.** In the $\omega$-basis the vector $(-1,2)$ *is* $\alpha_2$, so a reader taking the printed labels in $\omega$-coordinates concludes that $(3,3)-(4,1)$ **does** lie in the non-negative root cone. Detail below; this is the sharpest finding here.
- **The reviewer attribution is wrong for the numbers it carries.** "$45$ weights", "$44$ of the $46$", "thirteen other blocks" are [r180](REVIEW_r180.md)'s figures, not [r179](REVIEW_r179.md)'s. r179 exhibits only $(0,0)$ as a shared weight and gives no count.
- **"needs no Casimir separation at all" over-reaches by one use.** The file's own opening separates $\mathcal W_5=V_{(2,2)}$ from $V_{(2,1)}$ by the Casimir, at $16$ against $12$, both of dimension $35$. That use is untouched by L92.
- **The block carries zero links**, no [REVIEW_r179.md](REVIEW_r179.md), no [L84](../findings/sym3-blocks.md), no [L87](../findings/sym3-blocks.md), no [L91](../findings/sym3-blocks.md). Nothing is broken because there is nothing to break, the same defect [r673](REVIEW_r673.md) recorded for L84.
- **"even that one" has no antecedent inside the block.** Its referent is defined in a paragraph filed under [L91](../findings/sym3-blocks.md)'s heading whose content belongs to [L87](../findings/sym3-blocks.md), sixty-nine lines above. A reader arriving at L92 by number from [INDEX-results.md](../findings/INDEX-results.md) cannot resolve it.

**Provenance is clean.** Reported either way per the brief: it is clean, and the current text is a *repair* of a genuine arithmetic error in its own originating commit.

## Readings adopted

| symbol | reading I use | why |
| --- | --- | --- |
| $(\lambda_1,\lambda_2)$ | **$e$-coordinates**, $\lambda=\lambda_1e_1+\lambda_2e_2$ | forced three ways: $c_2(\lambda)=\lambda_1(\lambda_1+3)+\lambda_2(\lambda_2+1)$ is $\langle\lambda,\lambda+2\rho\rangle$ only there; the Weyl formula $\dim V_{(a,b)}=\tfrac16(2a{+}3)(2b{+}1)(a{-}b{+}1)(a{+}b{+}2)$ reproduces [L83](../findings/sym3-blocks.md)'s table only there; and the block's own $\alpha_1=(1,-1)$, $\alpha_2=(0,1)$ are $e$-vectors. **The block states none of this** |
| $\alpha_1,\alpha_2$ | the simple roots of $B_2$, $\alpha_1=e_1-e_2$ (long), $\alpha_2=e_2$ (short), **roots, not fundamental weights** | the fundamental weights are $\omega_1=e_1=(1,0)$ and $\omega_2=\tfrac12(e_1+e_2)=(\tfrac12,\tfrac12)$, neither of which is $(1,-1)$ or $(0,1)$. So the block's vectors are the roots, as claimed |
| $\rho$ | $(3/2,1/2)$ | positive roots $e_1-e_2,\ e_2,\ e_1,\ e_1+e_2$; half-sum $(3/2,1/2)$. Independently confirmed by $c_2$ reproducing [L84](../findings/sym3-blocks.md)'s $21$ distinct values |
| "Casimir separation" | **degree-two separation of the $24$ blocks of $\mathrm{Sym}^3\mathcal W_5$** | the only sense under which "even that one" parses. The phrase carries three senses in this file; [r673](REVIEW_r673.md) already recorded that |
| $B_2$ Killing normalisation | [sym3-blocks.md](../findings/sym3-blocks.md)'s $B(X,Y)=-\tfrac12\operatorname{tr}(XY)$, **not** [conventions.md](../findings/conventions.md)'s $B_K=(n-2)\operatorname{tr}$ | conventions.md tables the collision explicitly; $B_K=-6B$ here. Nothing in L92 consumes it |

## 1. The derivation, cold

**The general fact.** For $\mathfrak g$ semisimple over $\mathbb C$ and $V_\lambda$ the irreducible of highest weight $\lambda$, every weight $\mu$ of $V_\lambda$ satisfies $\lambda-\mu\in\mathbb Z_{\ge0}\alpha_1+\cdots+\mathbb Z_{\ge0}\alpha_\ell$. This is immediate from $V_\lambda=U(\mathfrak n^-)v_\lambda$: $U(\mathfrak n^-)$ is spanned by monomials in the negative root vectors, each of which lowers the weight by a positive root, and every positive root is a non-negative integer combination of the simple ones. **Correct as the block states it.**

**The simple roots.** $B_2=\mathfrak{so}(5)$ has simple roots $\alpha_1=e_1-e_2$ and $\alpha_2=e_2$, so $(1,-1)$ and $(0,1)$ in $e$-coordinates. **Verified against the file's own arithmetic**: the half-sum of the four positive roots $e_1-e_2,\ e_2,\ e_1,\ e_1+e_2$ is $\rho=(3/2,1/2)$, and $\langle\lambda,\lambda+2\rho\rangle=\lambda_1(\lambda_1+3)+\lambda_2(\lambda_2+1)$ is the $c_2$ that [L83](../findings/sym3-blocks.md) and [L84](../findings/sym3-blocks.md) use. Consistent.

**Which pair.** Writing $c_2$ over all $24$ labels of [L83](../findings/sym3-blocks.md)'s table by hand gives

$$0,4,10,12,16,18,20,24,28,30,30,34,40,40,42,46,48,52,54,60,60,66,74,96$$

$21$ distinct values with exactly three coincidences, at $30$, $40$ and $60$, reproducing [L84](../findings/sym3-blocks.md). The parity rule of [L86](../findings/sym3-blocks.md) plus [L87](../findings/sym3-blocks.md) kills every multiplicity-$1$ block with $\lambda_2$ even, which is exactly $(6,6),(6,4),(6,2),(6,0),(5,4),(5,0),(1,0),(0,0)$, **the eight deaths, derived rather than taken on trust.** At $c=60$ that removes both $(6,2)$ and $(5,4)$; at $c=40$ it removes $(5,0)$ and leaves $(4,3)$; at $c=30$ it removes neither, $(4,1)$ and $(3,3)$ both having odd $\lambda_2$. **So the surviving collision is $(4,1)$ against $(3,3)$, and the paragraph above L92 is right.** The multiplicity bookkeeping closes too: $41-16=25$ and $\sum\tfrac{m(m+1)}2=36$ on the survivors, both as [L87](../findings/sym3-blocks.md) states.

**The two differences.** With $a\alpha_1+b\alpha_2=(a,\,b-a)$:

$$(4,1)-(3,3)=(1,-2)=\alpha_1-\alpha_2,\qquad (3,3)-(4,1)=(-1,2)=-\alpha_1+\alpha_2.$$

Each carries one negative coefficient, so neither lies in $\mathbb Z_{\ge0}\alpha_1+\mathbb Z_{\ge0}\alpha_2$. **Both expansions are exactly as the block prints them. Correct.**

**Two independent confirmations, neither of which the block uses.** Weights of $V_\lambda$ lie in the convex hull of the Weyl orbit $W(B_2)\lambda$, and $W(B_2)$ is the signed permutations.

- $\|(3,3)\|^2=18>17=\|(4,1)\|^2$, and every point of the hull has norm at most $\|\lambda\|$, so $(3,3)$ is not a weight of $V_{(4,1)}$.
- Every point of $\mathrm{conv}\,W(3,3)$ has $|\mu_1|\le3$, while $(4,1)$ has $\mu_1=4$, so $(4,1)$ is not a weight of $V_{(3,3)}$.

**Both directions therefore hold on a second, disjoint argument.** The block's claim is as robust as a claim of this size gets.

**Why it needs no Casimir, in the form that actually carries it.** The block's own last clause is the real theorem and it is universal: for any finite-dimensional module $M$ over a semisimple $\mathfrak g$, $M\cong\bigoplus_\lambda V_\lambda\otimes M_\lambda$, and

$$\big(M[\lambda]\big)^{\mathfrak n^+}=\bigoplus_\mu\big((V_\mu)^{\mathfrak n^+}\big)[\lambda]\otimes M_\mu=M_\lambda,$$

since $(V_\mu)^{\mathfrak n^+}$ is one-dimensional in weight $\mu$ and zero in every other weight. **Solving $e_1v=e_2v=0$ on the weight-$\lambda$ space returns the multiplicity space $M_\lambda$ on the nose, and consults no central character.** [r180](REVIEW_r180.md) states it in exactly this form and it is right.

**One clause the block owes a line.** *"a weight-$\lambda$ vector killed by the raising operators generates $V_\lambda$ **by definition**"* is not by definition: $U(\mathfrak g)v$ is a quotient of the Verma $M(\lambda)$, hence has one-dimensional $\lambda$-weight space, and complete reducibility then forces a single summand. One line, in characteristic zero, but it is a theorem and not a definition.

## 2. The basis trap, which is the finding

**In the $\omega$-basis the second half of the block's argument comes out false, and by an exact coincidence rather than a near miss.** In $\omega$-coordinates the simple roots are $\alpha_1=2\omega_1-2\omega_2=(2,-2)$ and $\alpha_2=-\omega_1+2\omega_2=(-1,2)$. So the printed difference

$$(3,3)-(4,1)=(-1,2)$$

is, read in $\omega$-coordinates, **$\alpha_2$ itself**, coefficients $(0,1)$, both non-negative. A reader who takes the table's labels as $\omega$-coordinates and the printed differences at face value concludes that $(4,1)$ *is* a weight of $V_{(3,3)}$, and the block's second sentence reads as refuted. The first half survives: $(1,-2)$ expands as $0\cdot\alpha_1-1\cdot\alpha_2$ there and still carries a negative coefficient.

**This is not a hypothetical misreading.** [r663](REVIEW_r663.md) and [r664](REVIEW_r664.md) both recorded that this file's table is $e$-basis while the prose eight lines above it is $\omega$-basis, and that the ambiguity changes dimensions outright, $(4,2)$ reading as $260$ rather than $220$. L92 sits $158$ lines below that prose and states no basis of its own. **The block is correct as written and is one sentence away from being read as false.** The repair is four words: *"in the $e$-basis, $\alpha_1=e_1-e_2=(1,-1)$ and $\alpha_2=e_2=(0,1)$"*.

## 3. Provenance

**Clean, and better than clean, the current text is a repair.** `git log -S "never meets even that one"` returns one commit, [20cb594d](../findings/sym3-blocks.md), *"feat(n=5): the surviving collision is invisible to the method actually built"*, 2026-08-28, two lines added to this file. Its message reads

> `(3,3) - (4,1) = -alpha_1 + 2 alpha_2`

which is $(-1,3)$, **not** $(-1,2)$, a real arithmetic error, caught by [r179](REVIEW_r179.md) and [r180](REVIEW_r180.md) independently, and the block now prints the corrected $-\alpha_1+\alpha_2$. The same commit claimed *"their $\mathrm{Sym}^3$ weight spaces are disjoint"*, which is false and which the block now explicitly retracts.

**So no provenance clause here is manufactured.** That breaks the run the brief warned of. The one defect is attribution rather than invention:

| the block says | where it actually comes from |
| --- | --- |
| the modules are not weight-disjoint | [r179](REVIEW_r179.md) *and* [r180](REVIEW_r180.md); r179 exhibits $(0,0)$ only |
| **they share $45$ weights** | **[r180](REVIEW_r180.md) alone**, "$V_{(4,1)}$ has $57$ distinct weights and $V_{(3,3)}$ has $49$; $45$ of them are shared" |
| **$44$ of the $46$ dimensions at weight $(4,1)$, from thirteen other blocks** | **[r180](REVIEW_r180.md) alone**, which names all thirteen |
| the argument is a special case of a universal one | both; [r180](REVIEW_r180.md) gives the sharper $\ker e_1\cap\ker e_2=M_\lambda$ form |
| the root-coefficient fix, incorporated silently | [r179](REVIEW_r179.md) and [r180](REVIEW_r180.md) |

*"Reviewer 179 corrects two things here"* therefore credits one reviewer for two other reviewers' work and undercounts the repairs at two when three landed. **I did not re-derive the $45$, $46$, $44$ or the thirteen**, that is a weight-multiplicity computation and this brief is analysis-only. What I can say without a run is that they cohere: $46-44=2$ is exactly $m_{(4,1)}$ in [L83](../findings/sym3-blocks.md)'s table, and $\dim V_{(3,3)}[(4,1)]=0$ is what the block itself proves, so $(3,3)$ contributing nothing to the $46$ is forced by the lemma. **Consistent, and unverified as to the totals.**

## 4. What it retires

**Confirmed: L92 retires [L84](../findings/sym3-blocks.md)'s entire purpose on the live route.** The chain is unconditional and I reproduce it without leaning on either previous audit.

| level | what still needs a Casimir | why |
| --- | --- | --- |
| [L84](../findings/sym3-blocks.md) as stated | separating all $24$ | the theorem, and it is a theorem |
| after [L87](../findings/sym3-blocks.md) | one pair, $(4,1)$ vs $(3,3)$ | eight blocks die and two of the three collisions die with them |
| after L92 | **nothing** | a weight-$\lambda$ vector in $\ker\mathfrak n^+$ is $M_\lambda$, and this holds at every block, colliding or not |

**How L84 should be recorded: true in itself, superseded as a dependency.** Its statement is a theorem about $Z(U(\mathfrak{so}(5)))$ and stays one; what fails is the implicit claim that the pipeline consumes it. **L92's own conclusion does not depend on L84, L87 or L91**, the universal argument is unconditional, so even if the collision count were wrong, L92's headline would stand. The block presents itself as the last link in a three-lemma chain when it is independent of the chain, which is the one place it *understates* its support.

**Is L92 used anywhere? No.** Its only inbound reference on the whole record is one bullet inside [L84](../findings/sym3-blocks.md)'s own review blockquote, added by [r673](REVIEW_r673.md)/[r674](REVIEW_r674.md). It has an [INDEX-results.md](../findings/INDEX-results.md) row (`92`, *"Gate 2: no verdict on the record"*), and nothing in [results.md](../results.md), [plan.md](../plan.md), [routes.md](../routes.md) or [report/](../report/) cites it. **L92 points at nothing and nothing points at L92 except the block it retires.** That is the no-cross-reference pattern the brief describes, in its one-directional form.

**And the retirement has not reached the report.** [report/sections/07-gradedness-split.tex:892](../report/sections/07-gradedness-split.tex#L892) still reads *"The quartic Casimir generator separates them, and separation is forced rather than measured"* and *"$C_2^2$ is a legal degree-four central element and separates nothing"*, the first refuted by [r673](REVIEW_r673.md)/[r674](REVIEW_r674.md) as a claim about a single element, the second refuted outright ($C_2^2$ separates the same $21$ classes $C_2$ does). **The report presents as load-bearing a step L92 shows the route never takes, and mentions L92 nowhere.**

## 5. Scope

**$n=5$, and the block is stated at a scope narrower than its own argument.**

- **What the arithmetic licenses:** the $(4,1)$/$(3,3)$ root computation is $B_2$-specific and licenses nothing beyond $\mathfrak{so}(5)$.
- **What the argument licenses:** $\big(M[\lambda]\big)^{\mathfrak n^+}=M_\lambda$ holds for every semisimple $\mathfrak g$ and every finite-dimensional $M$. It applies verbatim to [Lemma L63](../results.md#L604)'s $n=12$ table ($77$ $SO(12)$-constituents, $191$ multiplicities) where the record separately debates $D_6$ Casimir separation. **The block should say the general statement is $n$-free; instead it files a universal lemma under an $n=5$ heading.**
- **What it does not license:** nothing about Conjecture A. The file's own closing says the $n=5$ certificate *"does not lift"*, trace-word transfer needing the stable range while $n=5$ carries the Lovelock syzygy.

**Live, dormant or closed, the route register does not say, and that is the finding.** [routes.md](../routes.md) has **no row at all** for the $n=5$ SOS certificate or the highest-weight construction. The nearest entry, **R1** *"universal certificate"*, is a different object (one certificate rational in $n$, PSD for all $n\ge12$) and is closed. **The register's `NEXT ROUTE ID: R18` line and its own stated purpose (*"every route the programme has taken, live or closed, in one table"*) are both violated by the omission.** Read off the file rather than the register, the honest status is *succeeded and terminal*: the certificate exists at denominator $10^5$, verified two ways, and it does not lift, so the highest-weight route is **closed by success at $n=5$** with no successor criterion recorded.

## 6. The remaining checklist items

- **Every hedging clause.** *"never meets"*, **holds**, on the derivation above. *"needs no"*, **holds** at the block level, **over-reaches at the file level**, the opening's $16$-against-$12$ separation of $\mathcal W_5$ from $V_{(2,1)}$ being a Casimir use L92 does not touch (both have dimension $35$, so no dimension count replaces it). *"even that one"*, **holds**, and its antecedent is outside the block. *"by definition"*, **owes one line of complete reducibility.**
- **Duplication, four kinds.** The content appears **nowhere else, numbered or not**, not in [results.md](../results.md), not in [report/](../report/), not in another findings file. The neighbouring pathology is present though: the paragraph carrying L92's own premise sits under [L91](../findings/sym3-blocks.md)'s heading while its content is [L87](../findings/sym3-blocks.md)'s, alongside a $\Delta$ paragraph that belongs to neither. **[L91](../findings/sym3-blocks.md) is currently three unrelated results under one heading**, and L92 opens with *"And"*, continuing a sentence from the third of them.
- **Does the file settle it above or below?** **Yes, above**, [L87](../findings/sym3-blocks.md) at line 100 supplies the premise, seventy-three lines up, and the block does not point there. The universal argument the block ends on is settled nowhere else in the file.
- **Do all pointers resolve?** **Vacuously, there are none.** Every neighbouring numbered block in this file links its reviews; this one links nothing, including the reviewer it names in italics.

## What I would change, in order

1. **Name the basis.** *"in the $e$-basis, where $\alpha_1=e_1-e_2$ and $\alpha_2=e_2$"*, four words that close the one misreading under which the lemma reads as false.
2. **Lead with the universal argument and demote the arithmetic to an illustration.** The block's last sentence proves the heading; its first three sentences prove a corollary of it.
3. **Fix the attribution** to [r180](REVIEW_r180.md) for the $45$/$46$/$44$/thirteen, and link [REVIEW_r179.md](REVIEW_r179.md) and [REVIEW_r180.md](REVIEW_r180.md).
4. **Link [L87](../findings/sym3-blocks.md) for "even that one"**, and move the collision-death paragraph out from under [L91](../findings/sym3-blocks.md) to where L87 lives.
5. **Add the scope line to [L84](../findings/sym3-blocks.md)** (theorem stands, consumer does not) and **repair [report/sections/07-gradedness-split.tex:892](../report/sections/07-gradedness-split.tex#L892)**, which still carries the refuted single-generator wording with no mention of L92.
6. **Open a [routes.md](../routes.md) row** for the $n=5$ certificate route, closed-by-success, with the non-lifting reason as its clearance criterion.

## What I did not check, and what would settle it

**Blocked by the analysis-only rule, stated rather than worked around:**

- **The $45$ shared weights, and the $46$-dimensional weight-$(4,1)$ space with $44$ from thirteen other blocks.** These need a weight-multiplicity computation across $24$ $B_2$-modules, a Freudenthal or Kostant run. **What it would decide:** whether [r180](REVIEW_r180.md)'s figures are right, hence whether the block's retraction sentence is quantitatively accurate. **If they check**, the block is right in every particular and only its attribution is wrong. **If they do not**, the retraction is a wrong number attached to a correct retraction, and the correction stands either way, **so nothing in the verdict turns on the outcome.** That is why I have recorded it as unverified rather than treating it as a gap.

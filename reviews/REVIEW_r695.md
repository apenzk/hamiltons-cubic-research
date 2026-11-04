# Review r695, Lemma L153, the Killing row marginal

**Review number: r695.** Reviewer A of a two-reviewer pair on identical cold briefs. Target: the block `#### Lemma L153, the Killing row marginal` in [findings/bounds.md](../findings/bounds.md). Analysis only, per the standing rule; **no computation was run at all**, every check below is by hand, and nothing here needed a screen.

## Verdict

**GAP.** The theorem is true, unconditionally, at every $n\ge2$, and I rebuilt it cold two independent ways. **Three of the block's non-mathematical claims do not hold**: its provenance clause names a review that never flagged the gap, its consumer list omits four consumers including one 263 lines above it in the same file, and one listed consumer does not depend on the marginal at all. **And the block does not do the thing it was written to do**, its commit changed three files, none of them a consumer and none of them [conventions.md](../findings/conventions.md), so every consumer still cites a convention rather than a result and the fact now exists twice.

**The block should exist.** Numbering was right; the execution stopped one commit short.

| claim | verdict |
| --- | --- |
| $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=2(n-2)$ | **CONFIRMED**, and it is stronger than stated |
| the three-line proof as written | **CONFIRMED**, with one step dropped that both source reviews carry |
| "a fact about the basis, not about any $W$" | **CONFIRMED**, and no $n\ge3$ is needed |
| the seven-name consumer list | **GAP**, six sound, [L35](../findings/stratum-two-negative.md) overstated, at least four omitted |
| "flagged independently by r639, r640, r647, r649, r650" | **REFUTED** on [r647](REVIEW_r647.md); the true set is four |
| "[L31](../findings/stratum-two-negative.md) has always had a number" | **CONFIRMED** |
| collision with [L114](../findings/bounds-relaxations.md) or [L112](../findings/bounds.md) | **none**, both consume it; neither restates it |
| [bounds.md](../findings/bounds.md) as the home | **CONFIRMED** as the best available |

## 1. The derivation, cold

### 1.1 The three steps

Work in $\mathfrak g=\mathfrak{so}(n)$ with the record's pairing $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)=-\tfrac12\mathop{\mathrm{tr}}(XY)$, fixed at [conventions.md](../findings/conventions.md) under "Norms and pairings".

**Step 1, the trace.** For a fixed $v$, write $A=\mathop{\mathrm{ad}}(v)$. For any orthonormal basis $\{v_\beta\}$,

$$\sum_\beta\lVert Av_\beta\rVert^2=\sum_\beta\langle A^{*}Av_\beta,v_\beta\rangle=\mathop{\mathrm{tr}}(A^{*}A).$$

**Two hypotheses enter and the block states one.** Orthonormality of $\{v_\beta\}$ is in the statement. **Ad-invariance is not mentioned anywhere in the block**, and it is what turns $\mathop{\mathrm{tr}}(A^{*}A)$ into $-\mathop{\mathrm{tr}}(A^2)$: invariance of $\langle\cdot,\cdot\rangle$ gives $\mathop{\mathrm{ad}}(v)^{*}=-\mathop{\mathrm{ad}}(v)$. The record's pairing is a multiple of the trace form and so is invariant, but the block's chain writes $=-\mathop{\mathrm{tr}}(\mathop{\mathrm{ad}}(v_\alpha)^2)$ with nothing between. **Both source reviews carry the missing step explicitly**, [r639](REVIEW_r639.md) line 33 and [r640](REVIEW_r640.md) line 46 both write $\mathop{\mathrm{tr}}(\mathop{\mathrm{ad}}(v)^{\mathsf T}\mathop{\mathrm{ad}}(v))$ before dropping the transpose. *The block's proof is less complete than the two reviews it was assembled from, at the one step where a reader could go wrong.*

**Step 2, the Killing form.** $-\mathop{\mathrm{tr}}(\mathop{\mathrm{ad}}(v)^2)=-B(v,v)$ is the definition of $B$, so nothing is owed here. **$B(X,Y)=(n-2)\mathop{\mathrm{tr}}(XY)$ is the only non-trivial input, and neither this block nor [conventions.md](../findings/conventions.md) proves it or gives it a range.** It is true at every $n\ge2$; here is the check. Diagonalise $X\in\mathfrak{so}(2m)$ to angles $\theta_1,\dots,\theta_m$, so $X$ has eigenvalues $\pm i\theta_j$ on $V\otimes\mathbb C$ and $\mathop{\mathrm{tr}}_V(X^2)=-2\sum_j\theta_j^2$. On $\Lambda^2V$ the eigenvalues are the pairwise sums, so

$$\mathop{\mathrm{tr}}_{\Lambda^2}(\mathop{\mathrm{ad}}X)^2=\sum_{i<j}\big[(i\theta_i+i\theta_j)^2+(i\theta_i-i\theta_j)^2\big]\cdot2=-4\sum_{i<j}(\theta_i^2+\theta_j^2)=-4(m-1)\sum_k\theta_k^2,$$

the $m$ zero weights contributing nothing, and $(n-2)\mathop{\mathrm{tr}}(X^2)=(2m-2)\big(-2\sum\theta^2\big)$ agrees. Odd $n$ adds the weights $\pm\theta_j$ to $V$ and the pairs $\pm\theta_i\pm\theta_j$, $\pm\theta_j$ to $\Lambda^2$, and the same count closes.

**One trap this route avoids and a reader might not.** The shortcut *"the invariant form on a simple algebra is unique up to scale, so $B\propto\mathop{\mathrm{tr}}$"* **fails at $n=4$**, where $\mathfrak{so}(4)=\mathfrak{su}(2)\oplus\mathfrak{su}(2)$ carries a two-dimensional space of invariant forms. The identity survives (I confirm it below by direct count) but the argument for it does not, and $n=4$ is a dimension this programme lives in.

**Step 3, the normalisation.** $\mathop{\mathrm{tr}}(v^2)=-2\lVert v\rVert^2$ is an identity, not a fact about bivectors: for skew $v$, $\mathop{\mathrm{tr}}(v^2)=-\mathop{\mathrm{tr}}(v^{\mathsf T}v)=-2\langle v,v\rangle$. At $\lVert v\rVert=1$ it is $-2$. So $-B(v,v)=2(n-2)$.

### 1.2 An independent check that shares nothing with the Killing form

Take $\{v_\beta\}=\{\varphi_{ab}\}_{a<b}$, $\varphi_{ab}=E_{ab}-E_{ba}$, orthonormal under the half-trace pairing since $\varphi^{\mathsf T}\varphi=E_{aa}+E_{bb}$. Then $[\varphi_{ab},\varphi_{cd}]=0$ when $\{a,b\}\cap\{c,d\}=\emptyset$ or $\{a,b\}=\{c,d\}$, and when the pairs share exactly one index the bracket is $\pm\varphi$ on the two remaining indices, of norm $1$. Computing one: $\varphi_{12}\varphi_{13}=-E_{23}$ and $\varphi_{13}\varphi_{12}=-E_{32}$, so $[\varphi_{12},\varphi_{13}]=-\varphi_{23}$.

**The partners of $\varphi_{ab}$ sharing exactly one index number $2(n-2)$**, so the marginal is $2(n-2)\cdot1$. At $n=3$ this is $0+1+1=2$; at $n=4$ it is $4$, the two vanishing partners being $\varphi_{12}$ itself and the disjoint $\varphi_{34}$. **This never touches the Killing form** and it settles $n=4$ despite the non-simplicity above.

### 1.3 The statement is stronger than the block says

$-B(v,v)=2(n-2)\lVert v\rVert^2$ for **every** $v$, so:

- **$v_\alpha$ need not be a member of $\{v_\beta\}$.** Any unit $v\in\mathfrak{so}(n)$ works against any orthonormal basis. Both [r639](REVIEW_r639.md) and [r640](REVIEW_r640.md) state it in that form; the block ties $\alpha$ to the basis and loses the generality for nothing.
- **"for a unit bivector" is the wrong noun.** An arbitrary orthonormal basis of $\Lambda^2\mathbb R^n$ has members that are not decomposable, and the identity holds for them too, it is an identity about the pairing. Read strictly, the phrase restricts the proof to a case the statement does not assume. [conventions.md](../findings/conventions.md) carries the same wording, so this is inherited rather than introduced.

### 1.4 Under plain Frobenius the marginal is $(n-2)$, a factor $2$, not $\sqrt2$

The brief asks, and the answer is not the $\sqrt2$ that caught a singular value elsewhere today.

Under $\lVert X\rVert_F^2=\mathop{\mathrm{tr}}(X^{\mathsf T}X)$ the orthonormal basis is $u_{ab}=\varphi_{ab}/\sqrt2$, and $\mathop{\mathrm{tr}}(u^2)=-1$, so $-B(u,u)=(n-2)$. Directly: $[u_{12},u_{13}]=-\tfrac12\varphi_{23}$ has $\lVert\cdot\rVert_F^2=\tfrac12$, and $2(n-2)$ partners give $(n-2)$. **The quantity is quadratic in each of two normalised vectors, so it scales by $\tfrac12\cdot2=\dots$**, concretely, $\lVert[v/\sqrt2,v'/\sqrt2]\rVert_F^2=\tfrac14\lVert[v,v']\rVert_F^2=\tfrac12\lVert[v,v']\rVert^2$. **A $\sqrt2$ is the wrong correction here; the factor is exactly $2$.**

**What this does and does not reach downstream.** The pair cap [L31](../findings/stratum-two-negative.md) reads $\le1$ under Frobenius and relation (B)'s constant halves with it, so **[L112](../findings/bounds.md)'s headline $-\tfrac1{n-2}$ is convention-free**, being the ratio of two constants that halve together, as [r650](REVIEW_r650.md) line 96 already observes from the other side. **[L109](../findings/bounds-relaxations.md)'s $2(n-2)(\lambda_{\max}-\lambda_{\min})^2$ and [L114](../findings/bounds-relaxations.md)'s $2d(n-2)$ are not**, and both would halve.

### 1.5 The one ambiguity the block does escape, and where it re-enters

**As written, $\sum_\beta$ runs over basis vectors, so the ordered/unordered question does not arise** and $2(n-2)$ is unambiguous. It arises the moment the marginal is written in $T$: $\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)$ against $\sum_{\beta<\gamma}T_{\alpha\beta\gamma}=n-2$. **[L35](../findings/stratum-two-negative.md) uses the second form and prints $m-2$**, so a reader chasing the consumer list from L153 meets a different constant with no conversion stated anywhere on the path. *One line in the block naming the $T$-form would remove this; today's repair of $S_{XYZ}$ in [conventions.md](../findings/conventions.md) did not reach it.*

## 2. Hypotheses, "a fact about the basis" is right, and no $n\ge3$ is needed

**Confirmed.** Nothing in §1 mentions $W$. Criticality, first Bianchi, trace-freeness, Weyl membership and $\lVert W\rVert=1$ are all absent, exactly as claimed, and the four are the specific hypotheses this record has lost and regrown elsewhere, [L70](../findings/bounds.md) lost unit norm, [L35](../findings/stratum-two-negative.md) lost it too, so naming them is worth the line.

**At small $n$ it degenerates gracefully and stays true.**

| $n$ | value | status |
| --- | --- | --- |
| $2$ | $0$ | true and empty, $\mathfrak{so}(2)$ is abelian and one-dimensional, and $B\equiv0$ |
| $3$ | $2$ | true, checked in §1.2; $\mathfrak{so}(3)$ has one unordered triple with $T=1$ |
| $4$ | $4$ | true, checked in §1.2, **and the "simple, hence unique invariant form" route to it is invalid here** |
| $\ge5$ | $2(n-2)$ | true |

**So no range hypothesis is owed on the statement.** One is owed on its *proof* if that proof ever gets compressed to the uniqueness argument, and a `$n\ge2$` on the heading would cost nothing.

## 3. The consumer list, six sound, one overstated, at least four missing

This is the block's real content and it is where the block is weakest.

### 3.1 The six that hold

| result | how it consumes the marginal | verdict |
| --- | --- | --- |
| [L70](../findings/bounds.md) | *"spends the fixed mass $\sum c_{vab}^2=2(n-2)$"*, and again in the dimension theorem, *"from the pair cap [L31](../findings/stratum-two-negative.md) and the Killing marginal alone"* | **sound**, and load-bearing twice |
| [L107](../findings/bounds.md) | $\mu_a=T_{a\bullet\bullet}/2(n-2)$ is a probability measure only because of it; the block itself says *"the $(n-2)$ coming from (A)'s Killing mass"* | **sound**; "L107's measure" is the right description |
| [L109](../findings/bounds-relaxations.md) | *"using $T\ge0$ with the row marginal $\rho_\alpha=2(n-2)$"*, the constant in the boxed cap **is** the marginal | **sound**; "per-coordinate cap" is right |
| [L114](../findings/bounds-relaxations.md) | see §3.3 | **sound**, and *"the same relation contracted"* is exactly right |
| [L112](../findings/bounds.md) | the row sum $2(n-2)$ is what normalises $\hat S$ to doubly stochastic; [r650](REVIEW_r650.md) line 78 settles that it is the marginal and **not** the pair cap that supplies it | **sound**; "doubly stochastic normalisation" is right |
| [L78](../findings/isotropy-cap.md) | its floor rests on $\alpha+2S_{\mathfrak{mmh}}+S_{\mathfrak{mhh}}=2(n-2)d$, which [r647](REVIEW_r647.md) line 50 derives as *"the Killing marginal summed over $\{e_a\}$"* | **sound**; "residual floor" is right |

**The brief's warning about confusing this with the pair cap does not bite.** Every one of the six turns on a row sum $2(n-2)$, never on $\lVert[v_\alpha,v_\beta]\rVert^2\le2$, and in the two places both appear ([L70](../findings/bounds.md)'s dimension theorem, [L143](../findings/bounds.md)) they are named separately and correctly.

### 3.2 [L35](../findings/stratum-two-negative.md) is overstated, it names the marginal and then discards it

The chain reads: *"Relaxing $T$ to any nonnegative totally symmetric tensor with row marginals $m-2$ and pair caps $\sum_\gamma T_{\alpha\beta\gamma}\le2$ gives $\theta\le\mathrm{LP}(\lambda)$. **Dropping the marginals** (legitimate, since dropping constraints only enlarges a maximum), gives $\mathrm{LP}\le G$."*

**One sentence after the marginal enters, it is thrown away, and every step from there to $\sqrt{3/2}$ runs on $G$**, a pair-capped fractional triangle packing that the block itself describes as *"free of $m$ and of $\binom m2$"*. The only other constant in the closing argument, $bc=(s^2+u-1)/2$, comes from $\lVert W\rVert=1$. **So the marginal is load-bearing for nothing in L35**, and its constant $\sqrt{3/2}$ would survive the marginal being false.

*Calling this "[L35](../findings/stratum-two-negative.md)'s relaxation" is defensible as a description of where the symbol appears; as an entry in a list headed "known consumers, none of which could cite it" it asserts a dependence that is not there.* **The honest entry is that L35 states the marginal in an intermediate relaxation and then drops it.**

### 3.3 The contraction claim, checked

*"[L114](../findings/bounds-relaxations.md)'s block-mass identity, which is the same relation contracted"* is **exactly right**, and here is the contraction. Each unordered triple $\{a,b,c\}$ of distinct indices contributes to $\sum_{\alpha\in\mathfrak m}\sum_{\beta\gamma}T_{\alpha\beta\gamma}$ once for each of its members lying in $\mathfrak m$, times the $2$ orderings of the remaining slots. Writing $k=\lvert\{a,b,c\}\cap\mathfrak m\rvert$,

$$2d(n-2)=\sum_{\alpha\in\mathfrak m}\sum_{\beta\gamma}T_{\alpha\beta\gamma}=\sum_{\text{unordered triples}}2k\,T=6S_{\mathfrak{mmm}}+4S_{\mathfrak{mmh}}+2S_{\mathfrak{mhh}},$$

which is L114's display, its coefficients being the $2k$, and its own gloss *"slot-occupancy counts, $3\times2$, $2\times2$, $1\times2$"* is this, correctly.

**A factor-$2$ tension between [L78](../findings/isotropy-cap.md) and [L114](../findings/bounds-relaxations.md) looks live and is not.** The two carry the same right-hand side $2d(n-2)$ but left-hand coefficients $(\alpha,2,1)$ against $(6,4,2)$. It resolves: L78 reads its mixed terms in **ordered** slots, where $S^{\mathrm{ord}}=2S^{\mathrm{unord}}$ on the mixed patterns, and $\alpha=S^{\mathrm{ord}}_{\mathfrak{mmm}}=6S^{\mathrm{unord}}_{\mathfrak{mmm}}$, consistent with L78's own note that its value reads $8.4$ ordered and $1.4$ unordered, since $8.4/1.4=6$. *Reported because it is the shape of thing this record has been wrong about four times today, and it is right here.*

### 3.4 The list is incomplete, and its own cited reviews say so

**At least four further results consume the marginal, and one of them is in this file.**

| omitted consumer | evidence |
| --- | --- |
| [L143](../findings/bounds.md) | **[bounds.md](../findings/bounds.md) line 31, 263 lines above L153 in the same file**, names it *"the **Killing row mass** $\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)$"* and cites it to [conventions.md](../findings/conventions.md). [INDEX-results.md](../findings/INDEX-results.md) row 143 says the same in its summary |
| [L23](../findings/ungraded-slack.md) | its proof opens *"with $\kappa=2(n-2)$ the Killing constant … $\sum_{b,c}c_{abc}^2=\kappa$ for every $a$"*, the marginal, under a fifth name. **[r640](REVIEW_r640.md) line 29 names L23 as a consumer to the process that wrote this block** |
| [L36](../findings/isotropy-cap.md) | *"the Killing block identity $2\mu+\gamma=2(n-2)d$"*, at [isotropy-cap.md](../findings/isotropy-cap.md) lines 40 and 68, the same contraction as L114. **[r639](REVIEW_r639.md) line 37 names it** |
| [L73](../findings/bounds.md) | **[r650](REVIEW_r650.md) line 68 names it**, *"load-bearing here and in L70, L73 and L107"* |

**Also named and omitted: [post F18](../findings/bounds-relaxations.md)**, by [r639](REVIEW_r639.md) line 37.

*The block hedges with "Known consumers", so this is incompleteness rather than falsity.* **But the four cited reviews between them name four more consumers, and the block folded none of them in**, the same failure mode a companion audit found today in a block that cited a review for something the review did not say. **[L143](../findings/bounds.md) is the sharpest case**: it is in the same file, it already calls the fact by a name one word from the block's own heading, and it went unlisted and uncited.

### 3.5 Five names for one fact, and the number did not reduce them

Killing marginal ([conventions.md](../findings/conventions.md)), Killing row mass ([L143](../findings/bounds.md)), row marginal ([L109](../findings/bounds-relaxations.md), [L114](../findings/bounds-relaxations.md)), Killing block identity ([L36](../findings/isotropy-cap.md)), Killing constant $\kappa$ ([L23](../findings/ungraded-slack.md)), and now Killing row marginal. **A sixth name is not obviously progress over a number that no block cites.** *And $\kappa$ collides inside [conventions.md](../findings/conventions.md) itself, where "the algebra's Killing constant" is $\kappa_n=(2n-1)(n-1)/4$, a different object under the same letter two bullets away.*

## 4. Was numbering right, and is [bounds.md](../findings/bounds.md) the home?

**Numbering was right, on the record's own stated grounds.**

- **The marginal is a theorem, not a convention.** [conventions.md](../findings/conventions.md)'s own normalisations section says *"Killing constants come from the definition, never from an index convention"*, which is a statement that this fact is derived. A file whose purpose is *"every definition, normalisation and index convention"* was the wrong home for a proposition with a proof.
- **The asymmetry with [L31](../findings/stratum-two-negative.md) was real and visible.** The two sit in one bullet of [conventions.md](../findings/conventions.md); one had an id and one did not.
- **Four reviewers in one day recommended it** (§5), independently, three of them without prompting.

**[bounds.md](../findings/bounds.md) is the best available home.** Relation (A), which [bounds.md](../findings/bounds.md) line 237 identifies as *"[conventions.md](../findings/conventions.md)'s Killing marginal"*, lives there, three of the seven listed consumers live there, and so does the omitted [L143](../findings/bounds.md). [algebra.md](../findings/algebra.md) is Fox's algebra and is not it; [bounds-relaxations.md](../findings/bounds-relaxations.md) would split it from relation (A). **The placement *within* the file is arbitrary**, the block lands between the $S_{22}$ discussion and [L108](../findings/bounds.md), in the middle of the $g$-moment thread, while relation (A) is 43 lines earlier. *Immediately after the (A)/(B)/(C) display would put it where its first reader needs it.*

## 5. Provenance, the five-reviewer claim is false, and it is false on one name

The block states: *"having carried at least five results with **no number anywhere on the record**, flagged independently by [r639](REVIEW_r639.md), [r640](REVIEW_r640.md), [r647](REVIEW_r647.md), [r649](REVIEW_r649.md) and [r650](REVIEW_r650.md) in one day."*

**I read all five end to end for a statement that the marginal carries no number. Four have one; [r647](REVIEW_r647.md) does not.**

| review | what it says | flags the gap? |
| --- | --- | --- |
| [r639](REVIEW_r639.md) | line 37: *"the marginal is numbered nowhere, [INDEX-results.md](../findings/INDEX-results.md) has no row for it … it should be, since L109, L36, post F18 and L114 all consume it"* | **yes** |
| [r640](REVIEW_r640.md) | §1a is headed *"The row marginal $2(n-2)$, confirmed, and it has no result number"* | **yes** |
| [r647](REVIEW_r647.md) | line 27 lists it among the block's **inputs**, *"from the [pair cap](../findings/conventions.md) bullet"*; line 50 uses it to derive L78's identity. **The word "number" appears in r647 only about $8.4$ and $16.6$, and its consumers section is about L78's consumers, not the marginal's** | **no** |
| [r649](REVIEW_r649.md) | line 90: *"the brief is right that it carries no result number … It is doing load-bearing work in four lemmas unnumbered"* | **yes** |
| [r650](REVIEW_r650.md) | line 68: *"the brief is right that it carries no result number … it should be numbered"* | **yes** |

**So it is four, and the block names five by adding a review that used the fact without complaint.** *[r648](REVIEW_r648.md) is in the same position, its input table row 19 cites the marginal to [conventions.md](../findings/conventions.md) and it flags nothing, so "used it silently" describes two reviews of the day, and the block promoted one of them to a flag.*

**The error is in three places and propagates.** The block, [LEDGER.md](../findings/LEDGER.md) line 1319 (*"five reviewers flagged that independently in one day"*), and [INDEX-results.md](../findings/INDEX-results.md) row 153 (*"flagged by five reviewers in one day"*). **The commit body carries it too.** *The repair is to write four and drop [r647](REVIEW_r647.md), or to widen the verb to "named it" and keep all five, the second being weaker and, on the evidence, the accurate one.*

### The other hedges

- **"at least five results with no number anywhere"**, **true**, and oddly weak: the block's own list has seven and the real figure is at least eleven. *A clause hedged below its own next sentence reads as a hedge nobody checked.*
- **"none of which could cite it before"**, **true before the commit**, and **still true after it**. See §6.
- **"[L31](../findings/stratum-two-negative.md) is its companion and has always had a number"**, **CONFIRMED.** `git log -S "Lemma 31"` puts the first occurrence at `d1406bcf`, 2026-08-23, the same day the bracket cap first appears (`1c1a9dac`, `24ca4c27`). *The `L` prefix itself dates only to the bulk retrofit `fe85b5bd` of 2026-09-02, so "always" is true of the number and not of the id as written today, a distinction with no consequence here.*

## 6. The block did not do what it was for

`be42a476`, *"feat(L153): the Killing row marginal finally has a number"*, touches **three files**: [findings/bounds.md](../findings/bounds.md), [findings/INDEX-results.md](../findings/INDEX-results.md), [findings/LEDGER.md](../findings/LEDGER.md).

**It touches no consumer, and it does not touch [conventions.md](../findings/conventions.md).** Its own body states the purpose (*"what was missing was an id, so every consumer cited a convention instead of a result"*) and after the commit **every consumer still cites a convention**. `L153` appears nowhere in the repository except its own heading, its [LEDGER.md](../findings/LEDGER.md) entry and its index row.

**Two consequences, and the second is a rule this record wrote for itself.**

- **The eleven-plus consumers are untouched**, so the citable id exists and nothing cites it. The record is in the state it was in, plus a heading.
- **[conventions.md](../findings/conventions.md) now restates a numbered result.** That file's opening rule is *"definitions and conventions are quoted, never restated"*, with the reason given: *"a convention restated in two files is a convention that will disagree with itself"*. The statement and its normalisation now stand in full in two files with no pointer either way. **This is the unnumbered-twin pattern the brief warns of, created rather than removed**, and the marginal is not a convention at all, so the [conventions.md](../findings/conventions.md) copy should become a pointer, not a duplicate.

*I note the block is honest that it owes Gate 2, and correct not to appear in [results.md](../results.md), which by its own spec admits results only after Gate 2 passes.*

## 7. Collisions, none

- **Against [L114](../findings/bounds-relaxations.md)**: L114 is the marginal summed over a $d$-dimensional block, split by pattern. It is a corollary with genuine content (the $6/4/2$ split), it consumes L153, and L153 says so. **No duplication.**
- **Against [L112](../findings/bounds.md)**: L112's content is $S\lambda=-2\lambda$ with $\hat S$ doubly stochastic. The marginal supplies only the normalisation; L112 adds relation (B), which L153 does not carry. **No duplication.**
- **Against [L36](../findings/isotropy-cap.md)**: L36 and L114 duplicate *each other*, [L114](../findings/bounds-relaxations.md)'s own block says so, *"re-derived as a separate lemma in a different file, cross-referenced neither way"*. **That is a pre-existing defect between two consumers and is not L153's**, though a block whose job is to be the single home of this relation is the natural place to record it.
- **Against [conventions.md](../findings/conventions.md)**: this is the one duplication, and L153 created it. §6.

## 8. Pointers

**All ten targets resolve**, five reviews and five findings files, checked. **Eight of the nine markdown links in the block are anchorless**, and three of those ([L70](../findings/bounds.md), [L107](../findings/bounds.md), [L112](../findings/bounds.md)) point at [bounds.md](../findings/bounds.md) from inside [bounds.md](../findings/bounds.md), self-links to the file, resolving to the top of the page. **The file's own convention gives all three heading anchors**, used a dozen times elsewhere in it. *Cosmetic, and it makes a consumer list built for chasing unchaseable.*

## 9. What is owed

1. **Fix the provenance in three places**, [bounds.md](../findings/bounds.md), [LEDGER.md](../findings/LEDGER.md) line 1319, [INDEX-results.md](../findings/INDEX-results.md) row 153. Four reviews flagged it; [r647](REVIEW_r647.md) used it.
2. **Point the consumers at L153.** Eleven-plus blocks, each a one-phrase edit. **Without this the block is inert**, and the gap it was written to close is open.
3. **Turn [conventions.md](../findings/conventions.md)'s bullet into a pointer**, per that file's own quoting rule.
4. **Correct the [L35](../findings/stratum-two-negative.md) entry** to say the marginal is stated in an intermediate relaxation and dropped, or remove it.
5. **Add [L143](../findings/bounds.md), [L23](../findings/ungraded-slack.md), [L36](../findings/isotropy-cap.md), [L73](../findings/bounds.md) and [post F18](../findings/bounds-relaxations.md)** to the list, all five named by the block's own cited reviews.
6. **Restore the invariance step**, $\mathop{\mathrm{ad}}(v)^{*}=-\mathop{\mathrm{ad}}(v)$, hence $\mathop{\mathrm{tr}}(A^{*}A)=-\mathop{\mathrm{tr}}(A^2)$, as both [r639](REVIEW_r639.md) and [r640](REVIEW_r640.md) wrote it.
7. **Generalise the statement to any unit $v\in\mathfrak{so}(n)$** and drop "bivector", which the proof does not use.
8. **Add the $T$-form and the Frobenius value**: $\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)$, halving to $n-2$ under $\sum_{\beta<\gamma}$, and $(n-2)$ under plain Frobenius.
9. **Anchor the nine links**, and move the block to sit beside relation (A).

*None of the nine needs computation, and none of this review did.*

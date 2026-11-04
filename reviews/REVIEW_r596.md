# Review r596, Lemma L13 (the spectral-moment method)

Reviewer r596, reviewer B of an independent pair on identical briefs, working from the definitions. Target: `Lemma L13 (spectral-moment method), canonical statement and proof`, [findings/curvature-invariants.md](../findings/curvature-invariants.md) lines 48–52, and the statement at [results.md](../results.md) line 538 that points here for the proof.

**Verdict: GAP, the block contains no proof, its provenance note is false, one of its three ingredients is refuted by the record itself, and its three margin figures are measurements at named dimensions that the block does not name.** The conclusion is nonetheless true and I derive it below from the definitions: the second-moment bound has ceiling $\theta\le2-o(1)$ at every $n$, against a true value below $\sqrt2$, so it cannot decide Conjecture A. That surviving statement is a Lemma at even $n\ge6$ and an Observation at odd $n$, because the constant it consumes is proved only at even $n$. The headline impossibility claim ("spectral moments of $L_u$ are the wrong invariants"), is **false as quantified** and needs a named family before it is a theorem.

Analysis-only footing observed. Nothing was searched, swept or optimised. Three lines of arithmetic were run to check numbers I was about to record against a table already on the record; they are reported as a screen and marked as such.

## 0. The one-line map of what is where

| copy | what it holds |
| --- | --- |
| [findings/curvature-invariants.md](../findings/curvature-invariants.md) line 52, the block under audit | the ingredient list and the conclusion, one paragraph, no derivation, no pointer of any kind |
| [results.md](../results.md) line 538 | **the identical paragraph, verbatim**, followed by `Proof: curvature-invariants.md` |
| [report/sections/08-fence-posts.tex](../report/sections/08-fence-posts.tex) lines 3–14 | the same statement **and a real proof**, the summing-squares step the findings block omits |
| [ATTEMPTS.md](../ATTEMPTS.md) lines 637–675 | the full account: setup, the three trace identities, the cap lemma with its one-line reason, the kill-criterion table the numbers come from, the level-4 assessment, and the diagnosis |

The block that the record designates canonical is the thinnest of the four.

## 1. Does the promised proof exist, and does it prove the headed statement?

**No, and the provenance note that explains why it must be here is false, the seventh such note in this programme, after the brief's six.**

### 1a. What is actually present

The block is a single paragraph. It names three ingredients, $\mathop{\mathrm{tr}}(L_W)=0$; $\mathop{\mathrm{tr}}(L_W^2)=\tfrac{(n-1)(2n-1)}4\lVert W\rVert^2$; a cap at $\lambda/2$ attained on a $k_0$-dimensional subspace, asserts that "together" they yield $\lambda^2(1+\tfrac{k_0}4)\le\tfrac{(n-1)(2n-1)}4$, and states the conclusion. **Not one of the three is derived, and the step that combines them is not shown.** Every one of the three is a result in its own right: the first two are [Fox](../references/fox-2019-nonassociative-curvature-algebra/notes.md) Theorem 1.3 with a constant Fox leaves open, and the third is [Lemma L24](../results.md), credited at [results.md](../results.md) line 242 to Krasnov–Tkachev Proposition 6.6. **The block cites none of them.** It carries no link, no result number and no script path: there is nothing in it to resolve, which is why the pointer audit below is short.

### 1b. The provenance note

> *Moved here from [results.md](../results.md) on 2026-08-31, where the argument was the only copy. That file now carries the statement and points here.*

Both sentences are false, and `git` settles it.

- **It was copied, not moved, and the pointer is circular.** [results.md](../results.md) line 538 today carries the paragraph *word for word*, then ends `**Proof:** [curvature-invariants.md](findings/curvature-invariants.md)`. Diffed against `git show a9e4b8c0^:results.md` (line 742, the pre-move text): the paragraph is byte-identical to both the pre-move original and the block. So results.md points at findings for a proof, and findings holds results.md's own paragraph. Nothing was gained by the move and nothing is proved at either end.
- **results.md was not the only copy.** `git show a9e4b8c0^:ATTEMPTS.md` already contained the section *Spectral trace method at idempotents* (the fuller account, with the table the block's numbers come from), **before** the move commit [a9e4b8c0](../ATTEMPTS.md) ran. The move commit's own body claims sentence-level verification of "zero loss"; the loss here is not of sentences but of the *argument*, which was never in results.md to begin with and which the note asserts was.

Nothing was lost in the move. What the note conceals is that nothing was ever there.

### 1c. The argument, derived cold, what is true and by what route

I derive the whole thing from [conventions.md](../findings/conventions.md) so that the block can be graded against it. Write $T(x,y,z)=\langle x\circ y,z\rangle$ with $\circ$ the polarisation of $Q$ from conventions.md, so $T$ is totally symmetric, $P(x)=T(x,x,x)$, $\nabla P=3Q(x)$, and $L_x=x\circ(\cdot)$ is self-adjoint.

**(i) $\mathop{\mathrm{tr}}(L_x)=0$ and $\mathop{\mathrm{tr}}(L_xL_y)=\kappa_n\langle x,y\rangle$, by Schur, with no computation.** $x\mapsto\mathop{\mathrm{tr}}(L_x)=\sum_iT(x,B_i,B_i)$ is an $O(n)$-invariant linear functional on $\mathcal W_n$, and $\mathcal W_n$ carries no trivial summand ($n\ge5$ irreducible; at $n=4$ the two summands are non-trivial and swapped by an orientation-reversing isometry), so it vanishes identically. $(x,y)\mapsto\mathop{\mathrm{tr}}(L_xL_y)=\sum_{i,j}T(x,B_i,B_j)T(y,B_i,B_j)$ is an invariant symmetric bilinear form, hence a multiple of $\langle\cdot,\cdot\rangle$. **So the block's structural claim ($\mathop{\mathrm{tr}}(L_W^2)$ is a function of $\lVert W\rVert$ alone), is a theorem at every $n$, and needs no fit.** The *value* $\kappa_n$ is the part that does; see §3.

**(ii) The displayed inequality, from criticality alone, by compression, not by the cap.** Let $W$ be a unit critical point, $\theta=P(W)>0$, so $L_WW=W\circ W=Q(W)=\theta W$. For $A\in\mathfrak{so}(n)$ the curve $\gamma(t)=\exp(tA)\cdot W$ lies on the unit sphere with $P\circ\gamma\equiv\theta$, since $Q$ is $O(n)$-equivariant. Differentiating twice at $t=0$ with $H=\dot\gamma(0)=[\mathop{\mathrm{ad}}A,W]$, and using $\langle\ddot\gamma(0),W\rangle=-\lVert H\rVert^2$ and $\nabla P=3\theta W$:

$$0=6\langle L_WH,H\rangle-3\theta\lVert H\rVert^2,\qquad\text{so}\qquad \langle L_WH,H\rangle=\tfrac\theta2\lVert H\rVert^2\ \ \text{on the whole orbit tangent }V,\ \dim V=k_0 .$$

By polarisation the compression of $L_W$ to $V$ is exactly $\tfrac\theta2\mathrm{Id}_V$, and $L_WW=\theta W\perp V$, so on $V'=\mathbb RW\oplus V$ the compression is $\mathop{\mathrm{diag}}(\theta,\tfrac\theta2\mathrm{Id}_{k_0})$. Since $\lVert P_{V'}L_WP_{V'}\rVert_F\le\lVert L_W\rVert_F$,

$$\theta^2\Big(1+\tfrac{k_0}4\Big)\ \le\ \mathop{\mathrm{tr}}(L_W^2)=\tfrac{(n-1)(2n-1)}4 .$$

**"From criticality alone" is therefore correct for the inequality, but not by the route the block gives.** The block reaches it through a *cap*, and a cap ($L_W\preceq\tfrac\theta2$ on $W^\perp$) is the second-variation condition at a **local maximum**, which is how [conventions.md](../findings/conventions.md) itself defines $B=\tfrac\theta2\mathrm{Id}-L_W$ and how [08-fence-posts.tex](../report/sections/08-fence-posts.tex) states it inside its own proof. The block asserts a criticality-only conclusion from an ingredient list containing a maximality-only ingredient; the conclusion is rescued by a step the block does not display. This is repairable in two lines and I give them above.

**(iii) The ceiling.** $k_0\le\dim\mathfrak{so}(n)=\binom n2$, so $\theta^2\le\frac{2(n-1)(2n-1)}{8+n(n-1)}$, which increases to $4$. Hence $\theta\le2-o(1)$ at every $n$, while $\theta_0(n)<\sqrt2<2$ at every $n$, the second-moment bound excludes no candidate value above $\theta_0(n)$, at any $n$. **That is a genuine all-$n$ closure and it is exact, not measured.** The word "measured" in the block belongs to the numbers, not to this.

### 1d. What "Peirce" is doing here

Nothing, and it should go. A Peirce decomposition with eigenvalues in $\{0,\tfrac12,1\}$ is a **Jordan-algebra theorem**, and this record has already established that $(\mathcal W_n,\circ)$ is not that kind of algebra, [findings/fence-posts.md](../findings/fence-posts.md) line 181 proves it has no unit, precisely from $\mathop{\mathrm{tr}}(L_x)\equiv0$. The inequality $L_W\preceq\tfrac\theta2$ on $W^\perp$ is the Hessian condition at a maximum and holds for that reason alone; calling it a Peirce cap attributes it to a structure the record elsewhere rules out.

## 2. Is "closed with a measured margin" a Lemma?

**Partly. The closure is derived; the three multipliers beside it are measurements, at dimensions the block does not name, against a denominator the block does not disclose.**

### 2a. Where the numbers come from, and what they are ratios of

The block: *"an excess of $49.7\times$ at $n=12$ and $3.09\times$ asymptotically, and the fourth moment reaches only $14\times$ even granting an oracle."* Read as written, "against a true $\sqrt2$: an excess of $49.7\times$", this says the ceiling overshoots the true value by a factor of fifty. It does not: the block's own inequality gives $\theta\le1.9011$ at $n=12$, which overshoots $\theta_0(12)=1.23603$ by $1.54\times$.

All three figures are the **kill-criterion table** at [ATTEMPTS.md](../ATTEMPTS.md) line 663, whose column is `excess / gap*` with

$$\mathrm{gap}^*=\theta_0(n)-\sqrt{3/2},$$

the margin separating the conjectured maximiser from Fox's $\mathcal S^4(\alpha)$. *Screen (three lines of arithmetic, checking numbers already on the record):* $(1.7974-1.23603)/0.01129=49.73$; $(2-\sqrt2)/(\sqrt2-\sqrt{3/2})=3.0917$; $(1.3951-1.23603)/0.01129=14.09$. All three reproduce. The denominator is $\mathrm{gap}^*$, and [scripts/runs/run_lw_spectral_bound.py](../scripts/runs/run_lw_spectral_bound.py) says so in its own header: *"PART 4 The kill-criterion table: bound − theta0(n) measured in units of the S^4(alpha)-to-W* gap theta0(n) − sqrt(3/2)"*.

Three consequences, each a defect of the block rather than of the mathematics:

- **The denominator is load-bearing and undisclosed.** $\mathrm{gap}^*=0.01129$ at $n=12$ is two orders of magnitude below $\theta_0$, which is the whole of the factor $49.7$. A reader given only the block cannot recover it. [reviews/ELIM-bounds.md](ELIM-bounds.md) line 157 is the proof of that: a previous reader worked from the block alone, got $1.9012$ and $1.34\times$, and concluded the two multipliers "are not reconstructible from it" and that a *decreasing* excess contradicts a *rising* ceiling. With the right denominator both objections dissolve, $\mathrm{gap}^*$ grows from $0.011$ to $0.189$, so the ratio does fall. **The numbers are right and the block makes them look wrong.**
- **$49.7$ and $14$ are not consequences of the inequality the block displays.** $49.7$ uses `bound_level3(n, N)`, the **level-3** bound, which consumes $\mathop{\mathrm{tr}}(L_W^3)$ and is obtained by a grid search (`ngrid=40001, nsamp=61`), giving $1.7974$ at $n=12$. The block's own level-2 inequality gives $1.9011$, i.e. $58.9\times$, not $49.7\times$. The block displays one inequality and quotes another's numbers.
- **$3.09$ is the only one of the three that is derivable**, being the $n\to\infty$ limit of the displayed inequality against $\sqrt2$ in $\mathrm{gap}^*$ units.

### 2b. Which dimensions, and does the block say so

**The margin was measured at $n=12$, and the source table also carries $n=14$ ($15.4$), $n=20$ ($7.0$) and $n=100$ ($3.4$). The block names $n=12$ for the first figure and no dimension at all for the third**, which is also an $n=12$ number. The level-4 figure is worse than that: it is a *counterfactual* at $n=12$ from precomputed $\mathop{\mathrm{tr}}(L_u^4)$ values, and the sentence it comes from ends *"the honest version is worse ($30\times$), because $\mathcal S^4(\alpha)$ carries a strictly larger $\mathop{\mathrm{tr}}(L^4)$ at every $n$"*. The block keeps the oracle number and drops the honest one.

### 2c. The label

| clause | status | correct label |
| --- | --- | --- |
| $\mathop{\mathrm{tr}}(L_W)=0$, $\mathop{\mathrm{tr}}(L_W^2)=\kappa_n\lVert W\rVert^2$ *as a form* | derived (Schur, §1c(i)); it is Fox Theorem 1.3 | Lemma, all $n$ |
| the value $\kappa_n=\tfrac{(n-1)(2n-1)}4$ | **derived at even $n\ge6$ only**, [REVIEW_r140](REVIEW_r140.md) sums the six Peirce families; [second-order.md](../findings/second-order.md) line 95 records it was "first fitted to those four points and then checked at them, which is no derivation", and flags the even-$n$ derivation as disputed for circularity | Lemma at even $n$; Observation at odd $n$, at $n=5,7$ and the held-out dimensions |
| $\theta^2(1+\tfrac{k_0}4)\le\kappa_n$ from criticality | derived (§1c(ii)) | Lemma, all $n$ |
| ceiling $\theta\le2-o(1)>\sqrt2$ | derived (§1c(iii)), conditional on $\kappa_n$ | inherits the row above |
| $49.7\times$, $14\times$ | measured, $n=12$, grid search, undisclosed denominator | Observation, $n=12$ |
| $3.09\times$ | derived | Lemma |

**So the block is mislabelled twice over, and in opposite directions.** It is a `Lemma` at odd $n$ where its constant is a fit, the sibling failure the brief names, and the conjecture's range $n\ge12$ contains odd $n$. And it is a `Lemma` over three numerical clauses that belong in an `Observation` naming $n=12$. What is not mislabelled is the core: the ceiling argument is a theorem at even $n$ and would be one at every $n$ the day the rational-function lemma sketched at [REVIEW_r139](REVIEW_r139.md) §A.2 is written down.

## 3. What "the wrong invariants" means precisely, the impossibility claim is false as quantified

The block states its headline twice, opening and closing: *"spectral moments of $L_u$ are the wrong invariants for this problem"*. Quantified over the family it names (the spectral moments of $L_u$), **this is false, and its own setting refutes it**:

- The full moment sequence $\{\mathop{\mathrm{tr}}(L_W^k)\}_{k\ge1}$ determines $\mathop{\mathrm{spec}}(L_W)$ as a multiset. At a maximiser the cap gives every eigenvalue on $W^\perp$ at most $\tfrac\theta2$, and $L_WW=\theta W$ with $\theta>0$, so $\theta=\lambda_{\max}(L_W)$ **exactly**. The moments determine $\theta$ outright.
- The record says so in its own words. [findings/second-order.md](../findings/second-order.md) line 113: *"one moment already determines $\theta$ exactly, via $\mathop{\mathrm{tr}}(L_e^2)=\kappa_n/\theta^2$"*, and line 229 turns it into the reformulation *"Maximising $P$ over the critical set is exactly minimising the Frobenius norm of the multiplication operator"*. The block's "carries no information beyond the norm" is true of $\mathop{\mathrm{tr}}(L_W^2)$ at $\lVert W\rVert=1$ and false of the same identity read at the idempotent $e=W/\theta$, where it is the whole conjecture.

**Worse for the label: the block's stated diagnosis is an inference this record has already downgraded.** [second-order.md](../findings/second-order.md) lines 107–115 carry the same argument (a fixed $O(n^2)$ budget spread over $O(n^4)$ eigenvalues), under the heading **"DOWNGRADED to a heuristic"**, Gate 2, reviewers 145 and 146 agreeing, with three reasons, the first of which is the one above. The conclusion is endorsed there; the reasoning L13 gives for it is not. L13 carries as its proof the part that was struck.

**What the closure would need in order to be a theorem.** Name the family and name what it fails to separate:

> *For every $n$, the bound obtained by relaxing over the moments of $L_W$ that are universal functions of $(\lVert W\rVert,\mathop{\mathrm{tr}}W^3,\langle W^\#,W\rangle)$ (orders $\le3$), using as side data only $\lVert W\rVert=1$ and a lower bound $k_0\ge\dim(O(n)\cdot W)$, exceeds $\theta_0(n)$. Hence no such bound separates the balanced sphere product from Fox's $\mathcal S^4(\alpha)$.*

That statement is provable, §1c(iii) proves the order-$2$ case at every $n$, and the $\mathrm{gap}^*$ denominator shows separation from $\mathcal S^4(\alpha)$ was what the measurement was about all along. The stronger form the record actually wants lives elsewhere: [second-order.md](../findings/second-order.md) line 231, *"the bound is not merely loose, it is the exact optimum of its moment problem, so the route is closed"*, with *"no moment-based sharpening exists"* (reviewers 28 and 29, independently) and *"No bound in this family drops below $\theta_0$ at any $n$"*. **That is L13's headline, proved, in another file, and L13 neither states it nor points at it.**

## 4. Scope

The block names no range. From §1c: the ceiling holds at **every** $n\ge4$ where $\kappa_n$ holds, so at every even $n\ge6$ unconditionally and at odd $n$ on a fitted constant. It is not restricted to $n\ge12$ and should not be written as if it were. The margin figures are $n=12$ (and, in the source, $14$, $20$, $100$).

## 5. One clause refuted outright, with witnesses

> *"a Peirce cap at $\lambda/2$ on $u^\perp$ **attained on a subspace of dimension exactly** $\dim(O(n)\cdot u)$"*

**"Exactly" is false, and the counterexamples are on the record.** [second-order.md](../findings/second-order.md) line 223: *"The multiplicity can exceed the orbit dimension ($18$ against $9$ at $S^3\times S^3$, and $60$ against $21$ at $S^2\times S^3\times S^3$) but the inclusion itself is a theorem."* Line 229 repeats it with $m(1)=\binom k2$ and $m(\tfrac12)=k\cdot\mathrm{orb}$ at $(S^3)^k$. [ATTEMPTS.md](../ATTEMPTS.md) line 657 says "exactly" too, but its support is *"verified numerically… at both known families for $n=8,10,12$"*, an observation at three dimensions on two families, which the $n=6$ witness contradicts.

**Harmless, and that is the point.** §1c(ii) uses the orbit tangent only as a *lower* bound on the multiplicity of $\tfrac\theta2$, and the inequality is monotone in $k_0$, so replacing "exactly" by "at least" costs nothing and makes the clause true. A `Lemma` should not carry a false clause it does not need.

## 6. Hedging clauses

Eight, and each is concealing something.

| clause | what it conceals |
| --- | --- |
| "closed with a **measured margin** rather than left as a maybe" | the margin is a grid search (`bound_level3`, `ngrid=40001`) at four dimensions, in units of an undisclosed $\mathrm{gap}^*$; the part that is *not* measured (the exact ceiling $2-o(1)$), is the part that closes the route |
| "**from criticality alone**" | true of the inequality, false of the route offered: the cap is a local-max condition. [08-fence-posts.tex](../report/sections/08-fence-posts.tex) says "at a local maximum" inside its proof while its statement says "from criticality alone" |
| "a **Peirce** cap" | a Jordan-algebra structure the record shows is absent ([fence-posts.md](../findings/fence-posts.md) line 181: no unit) |
| "attained… **exactly**" | refuted; see §5 |
| "**even granting an oracle**" | the oracle is counterfactual, it pretends $\max_u\mathop{\mathrm{tr}}(L_u^4)$ sits at $W^*$, and the same source line records that $\mathcal S^4(\alpha)$ is strictly larger at every $n$, making the honest figure $30\times$, which is dropped |
| "against a **true $\sqrt2$**" | $\sqrt2$ is $\lim\theta_0(n)$, attained nowhere; the actual comparison is against $\mathrm{gap}^*$ at finite $n$ |
| "the diagnosis is **structural**" | the structural half (constancy by Schur) is true; the inference drawn from it is the one Gate 2 downgraded to a heuristic at [second-order.md](../findings/second-order.md) line 107 |
| "**simply** the wrong invariants" | restates the headline in place of proving it, and as quantified it is false (§3) |

Add the glance entry at [results.md](../results.md) line 186 (*"a hard ceiling that **no refinement of it escapes**"*), a strictly stronger claim than anything in the block, whose load-bearing version ("the exact optimum of its moment problem") lives in [second-order.md](../findings/second-order.md).

## 7. Pointers

There is nothing to resolve: **the block carries no link, no result id and no script path.** What that costs, listed so a repair can pay it:

| owed pointer | target |
| --- | --- |
| the trace identities | [Fox](../references/fox-2019-nonassociative-curvature-algebra/notes.md) Theorem 1.3, and [second-order.md](../findings/second-order.md) line 91, which states it owns them |
| the constant $\kappa_n$ | Fox Remark 1.4 leaves it open; [REVIEW_r140](REVIEW_r140.md) derives it at even $n$ and anchors $n=4$ to Fox Theorem 1.5(2) |
| the cap | **[Lemma L24](../results.md)**, Krasnov–Tkachev Proposition 6.6, a numbered result of this record, consumed silently |
| the cap's attainment | [second-order.md](../findings/second-order.md) line 223, which also corrects "exactly" |
| the numbers | [ATTEMPTS.md](../ATTEMPTS.md) line 663 and [run_lw_spectral_bound.py](../scripts/runs/run_lw_spectral_bound.py) |

Two pointers *into* the block resolve correctly: the anchor at [curvature-invariants.md](../findings/curvature-invariants.md) line 5 and `Proof:` at [results.md](../results.md) line 540, the latter to a verbatim copy of its own text.

**And the block is in the wrong file.** [curvature-invariants.md](../findings/curvature-invariants.md)'s own preamble says the file "represents $\theta$ through *sectional-curvature moments* and the second-kind operator". L13 is about the spectrum of the multiplication operator on $\mathcal W_n$ and touches sectional curvature nowhere. Its subject-owning file is [second-order.md](../findings/second-order.md), which already carries the audited version of every one of its ingredients. [LEDGER.md](../findings/LEDGER.md) line 1680 records L13 as one of three results "wrong in the canon" from a single displacement out of bounds.md, none of them audited since.

## 8. What is owed, and whether it is reachable

All of it is reachable, and most of it is already written somewhere on the record.

1. **Replace the ingredient list with the two-line derivation of §1c(ii)** (compression, not cap) and cite [L24](../results.md) for the cap. *Reachable now; done above.*
2. **Strike "exactly"** in favour of "at least". *Reachable now; required by §5.*
3. **State the family.** Put §3's displayed statement in place of "the wrong invariants", or point at [second-order.md](../findings/second-order.md) line 231 for the stronger form. *Reachable now.*
4. **Split the label.** Keep `Lemma` for the ceiling at even $n\ge6$; move $49.7\times$ and $14\times$ into an `Observation` naming $n=12$, the $\mathrm{gap}^*$ denominator, and the level-3 grid search; carry the honest $30\times$ beside the oracle's $14\times$. *Reachable now.*
5. **Correct the provenance note**, or delete it. *Reachable now.*
6. **Prove $\kappa_n$ at odd $n$**, which upgrades the whole block to a `Lemma` at every $n$ and settles Fox's Remark 1.4. The route is the rational-function argument of [REVIEW_r139](REVIEW_r139.md) §A.2, $\kappa_nN(n)=\lVert\mu_n\rVert^2$ with both sides rational in $n$, agreeing at infinitely many even $n$. *One lemma away, analytic, no computation.*

**Nothing here needs a run.** Items 1–5 are edits; item 6 is a derivation. The one place where this audit stopped short of a decision, reconstructing the level-3 bound $1.7974$ from the record rather than from the script, would need a numerical optimisation, and I did not open it: it would decide only whether the block's $49.7$ should be $49.7$ or something near it, and the closure holds at $58.9$ from the block's own weaker inequality either way.

---

*Reviewer r596. Log: [agent_logs/audit-L13-b.log](../agent_logs/audit-L13-b.log). Written without reading r595 or its log.*

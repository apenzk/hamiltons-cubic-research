# Reviewer 767, Gate 2 on [Lemma L175](../findings/bounds-relaxations.md), the $(A),(B)$ fence, and on the rewritten sectional-norm bullet in [conventions.md](../findings/conventions.md)

*Brief read cold, from [BRIEF-g2-l175.md](BRIEF-g2-l175.md), before any file of the record was opened. **No numerical work was done**: every value below is exact (rational, or a closed-form surd) and the only compute is one screen of four Lean statements I wrote myself for the purpose, reported as a screen in §5 and never as evidence for a positive claim. The record's Lean layer was built rather than read: `lake build`, 8996 jobs, completed successfully, warnings only. Log at [agent_logs/g2-l175-r767.log](../agent_logs/g2-l175-r767.log).*

## The claim table

| # | Claim, as the record states it | Verdict |
| --- | --- | --- |
| 1.1 | $\theta$ occurs in (C) and nowhere else; the set cut out by (A) and (B) does not move with $\theta$ | **CONFIRMED** |
| 1.2 | *"any bound derived from membership in it alone holds at every $\theta$ at once (which is to say it bounds nothing"* | **EQUIVOCAL), true only of $\gamma=0$ certificates, and the reading the conclusion needs is REFUTED** |
| 1.3 | *"Hence no Schur-convexity argument from the SDIEP toolbox reaches $\theta$"* | **REFUTED**, two exhibits, §3 and §4, and the record's own [L104](../findings/bounds-relaxations.md) compactness proof is a third |
| 1.4 | *"convexity arguments consume the marginals, and the marginals are (A) and (B)"* | **REFUTED**, (C) is the second-moment marginal of the same rows |
| 1.5 | *"every object that toolbox produces being built from (A) and (B)"* | **HYPOTHESIS-DEBT**, no argument on file, and none is sketched |
| 1.6 | the majorisation half is a recognition and stands | **CONFIRMED**, and independent of the fence, so the closure leaves it intact |
| 1.7 | [L175.lean](../lean/HamiltonsCubic/Results/L175.lean) machine-checks the fence | **REFUTED**, three of its four theorems state nothing; [lean/INDEX.md](../lean/INDEX.md)'s row credits two of them |
| 2.1 | the $M$ bullet carried the diagonal-locus value without its scope, and needed the scope | **CONFIRMED** |
| 2.2 | *"$K$ captures only the entries $W_{abab}$, so equality is exactly the case where those determine $W$"* | **REFUTED as worded**, the fibre of $W\mapsto K$ is never a point; the correct equality clause is in §7 |
| 2.3 | the ground offered: *"the unqualified reading contradicts this table's own $t\le2$ eleven bullets above"* | **CIRCULAR**, second occurrence of [proposal 73](../.claude/skill-proposals.md), in the file the first occurrence was in |
| 2.4 | *"taken at the sectional matrix off the diagonal locus, L94's bound would read $\kappa^2\le4$"* | **CONFIRMED with a mis-attached clause**, the $4$ comes from the unscoped value, not from being off the locus |
| 2.5 | the headline *"their norms differ by $\sqrt2$ on the diagonal locus and by less off it"* | **CONFIRMED**, the ratio is $\sqrt{t}$, and $t\le2$ with equality only on the locus |

**Claim 1 verdict: BROKEN.** **Claim 2 verdict: PROVEN, hypotheses corrected.** **Overall: BROKEN.**

**Actionable summary in one line.** L175's true content is that a $\gamma=0$ multiplier certificate bounds nothing, restate it that way and delete the "hence", because a bound on (C)'s left-hand side proved from (A), (B) and $T\ge0$ *does* bound $\theta$, which is how [L104](../findings/bounds-relaxations.md), [L70](../findings/bounds.md) and the $\Pi$-bound all work; and in [conventions.md](../findings/conventions.md) keep the new scope but replace its reason with [L94](../findings/bispectral.md)'s proved equality case.

## 0. Conventions, fixed once

Everything below runs in the record's own normalisations, taken from [conventions.md](../findings/conventions.md) and used without rescaling.

- **The $\Lambda^2$ pairing.** $\lVert Z\rVert^2=\tfrac12\mathop{\mathrm{tr}}(Z^{\mathsf T}Z)$ at the $\Lambda^2$ level, making $\{\varphi_{ab}\}_{a<b}$ orthonormal; a unit Weyl operator has $\sum_\alpha\lambda_\alpha^2=\mathop{\mathrm{tr}}(W^2)=\lVert M\rVert_F^2=1$, the sum over the $N=\binom n2$ unordered pairs.
- **The sectional matrix.** $K_{ab}=W_{abab}$ for $a\ne b$, symmetric and hollow, and $t=\lVert K\rVert_F^2=\sum_{a\ne b}K_{ab}^2$ over **ordered** pairs. $t$ is per frame unless said otherwise, and $\kappa^2=\max_Ft_F$.
- **The spectrum.** Distinct eigenvalues $\nu_1,\dots,\nu_d$ of the $\Lambda^2$ operator with multiplicities $m_i$ summing to $N$, subject to $\sum_im_i\nu_i=0$ (tracelessness) and $\sum_im_i\nu_i^2=1$ (unit norm). Both are $\theta$-free, and both are load-bearing below.
- **The reduced system.** [L104](../findings/bounds-relaxations.md)'s $t_{ijk}\ge0$ on admissible class-multisets, $\mu_j=m_j-\delta_{ij}$, and (A$_i$), (B$_i$), (C$_i$) exactly as displayed there. $\Pi(\lambda)$ is the feasible set in the **pair** $(T,\theta)$.
- **Certificates.** A multiplier certificate is a triple $(\alpha_i,\beta_i,\gamma_i)$ on the three rows of class $i$, per [L104](../findings/bounds-relaxations.md)'s duality paragraph. "$\gamma=0$" below means every (C) row carries multiplier zero.

## The hypothesis inventory

What the two claims need, and where each comes from.

| H | Hypothesis | Where it is on the record | Status |
| --- | --- | --- | --- |
| H1 | $\nu$ is data of the relaxation, constrained only by tracelessness and unit norm, both $\theta$-free | [L104](../findings/bounds-relaxations.md), statement | stated |
| H2 | $T\ge0$, totally symmetric, hollow | [L104](../findings/bounds-relaxations.md) | stated |
| H3 | (C) holds only at critical points, (A) and (B) on all of $\mathcal W_n$ | [L73](../findings/bounds.md)'s block | stated, and **L175 never uses it**, it is the fence's real content |
| H4 | some $\nu_i>0$ | forced by H1 with $\nu\ne0$ | unstated, used in §3 |
| H5 | "the SDIEP toolbox" denotes a definite set of objects | nowhere | **absent**, and 1.5 cannot be assessed without it |
| H6 | $\lVert M\rVert_F=1$ for the $\Lambda^2$ operator at a unit Weyl tensor | [conventions.md](../findings/conventions.md), the two-spectra bullet | stated |
| H7 | the diagonal locus is inhabited at unit norm | [L55](../results.md)'s perfect-matching extremiser, $t=2$ | stated |
| H8 | the fibre of $W\mapsto K$ is positive-dimensional | derivable, §7; corroborated by [second-order.md](../findings/second-order.md)'s *"the hollow zero-row-sum $4\times4$ space is $2$-dimensional"* | derived here |

## 1. Item 1, is $\theta$ really absent from (A) and (B)?

**Yes, and I checked the reduction at source rather than from the brief.** The three relations are stated unreduced in [bounds.md](../findings/bounds.md) as $\sum_{\beta\gamma}T_{k\beta\gamma}=2(n-2)$, $\sum_{\beta\gamma}\lambda_\beta T_{k\beta\gamma}=-2\lambda_k$ and $\sum_{\beta\gamma}\lambda_\beta\lambda_\gamma T_{k\beta\gamma}=2\lambda_k(\theta-\lambda_k)$, with (A) the Killing row marginal ([L153](../findings/bounds.md)), (B) the identity $A(W)=2W$, and (C) criticality. The reduction to class variables replaces $\lambda$ by $\nu$ and carries the right-hand sides across unchanged. So $\theta$ enters only through (C)'s right side.

**The two routes by which $\theta$ could have leaked in are both closed.** *Through $\nu$*: the spectrum is data of $\Pi(\lambda)$, and $\theta$ ranges over a variable at fixed $\lambda$, that is precisely what makes $\theta^\ast(\lambda)$ a supremum rather than a value. *Through the normalisation*: the two constraints on $\nu$ are $\sum_im_i\nu_i=0$ and $\sum_im_i\nu_i^2=1$, neither carrying $\theta$.

**One check that the $\theta$-dependence is where it is claimed.** [L104](../findings/bounds-relaxations.md)'s second dependency is $\sum_im_i(\text{C}_i)=\sum_im_i\nu_i(\text{B}_i)$. Reading both sides at the right-hand sides: $\sum_im_i\cdot2\nu_i(\theta-\nu_i)=2\theta\sum_im_i\nu_i-2\sum_im_i\nu_i^2=0-2=-2$, and $\sum_im_i\nu_i(-2\nu_i)=-2\sum_im_i\nu_i^2=-2$. They agree, and the $\theta$ term cancels **by tracelessness**, exactly as the block says. So one combination of the (C) rows is itself $\theta$-free, consistent with, and slightly sharper than, the claim as stated: $\theta$ survives in $d-1$ independent (C) rows, not $d$.

**Verdict 1.1: CONFIRMED.**

## 2. Item 2, the inference, pressed hardest

The sentence under test: *"the feasible set cut out by (A) and (B) does not move with $\theta$, and any bound derived from membership in it alone holds at every $\theta$ at once, which is to say it bounds nothing."*

**Locate it exactly.** Write $S_{AB}:=\{T\ge0\ \text{totally symmetric hollow}:\text{(A)},\text{(B)}\}$. The fence's premise is the set identity $\{(T,\theta):T\in S_{AB}\}=S_{AB}\times\mathbb R$, whose $\theta$-projection is all of $\mathbb R$. That is true and I do not contest it.

**Argue the opposite, in the strongest form the words support.** The strongest defence is that "derived from membership in it alone" excludes every derivation that writes (C) down; on that reading the sentence is a tautology (an inequality whose two sides are both $\theta$-free constrains $\theta$ not at all) and it is exactly the statement *a $\gamma=0$ multiplier certificate produces no $\theta$ bound*, which is true and worth recording. **But that reading cannot carry the "hence".** No argument anywhere on this record proposes to bound $\theta$ without ever writing the relation that connects $\theta$ to the data: $\theta$ is not a function of $T$ at all until (C) is written. So the reading under which the fence is true is the reading under which it fences nothing, and the reading under which it fences something is the one refuted in §3 and §4.

**Exhibit the failure concretely.** The structure the fence overlooks is: a bound proved *on* $S_{AB}$ for the functional that (C) evaluates. (C$_i$)'s left-hand side is a linear functional of $T$; (C$_i$) says it equals $2\nu_i(\theta-\nu_i)$. Any upper bound on that functional, proved from $\theta$-free constraints alone, is therefore an upper bound on $\theta$ at every row with $\nu_i>0$. §3 carries one in closed form.

**And the record already contains this exact derivation, three sections above the fence.** [L104](../findings/bounds-relaxations.md)'s own compactness proof reads: *"$T\ge0$ with row sum $2(n-2)$ gives $0\le T_{abc}\le2(n-2)$, and (C) at a row with $\lambda_a\ne0$ then bounds $\theta$."* Every input there is (A) and $T\ge0$ (the $\theta$-free set), with (C) used only to name $\theta$. Under L175's inference that argument bounds nothing; in fact it is what makes $\Pi(\lambda)$ compact and $\theta^\ast(\lambda)$ finite, which the whole relaxation programme rests on. **This is an internal contradiction, not a disagreement of taste.**

**Verdict 1.2: EQUIVOCAL, and the load-bearing reading is REFUTED. The fence is too strong.**

## 3. Exhibit A, a $\theta$ bound from (A) and $T\ge0$, in closed form

**Claim.** Let $V:=\max_j\nu_j^2$. Then for every $i$ with $\nu_i>0$ and every $T$ satisfying (A$_i$) with $T\ge0$,
$$\theta\ \le\ \nu_i+\frac{(n-2)V}{\nu_i}.$$

**Proof.** Every coefficient in (A$_i$) is nonnegative ($2\mu_j\mu_k\ge0$ and $\mu_j(\mu_j-1)\ge0$, the $\mu$'s being nonnegative integers) and every variable is nonnegative. (C$_i$) is (A$_i$) reweighted term by term, the $\{i,j,k\}$ term by $\nu_j\nu_k$ and the $\{i,j,j\}$ term by $\nu_j^2$, and each weight is at most $V$ since $\nu_j\nu_k\le\lvert\nu_j\rvert\lvert\nu_k\rvert\le V$. Hence
$$\sum_{j<k}2\mu_j\mu_k\nu_j\nu_kt_{ijk}+\sum_j\mu_j(\mu_j-1)\nu_j^2t_{ijj}\ \le\ V\Big(\sum_{j<k}2\mu_j\mu_kt_{ijk}+\sum_j\mu_j(\mu_j-1)t_{ijj}\Big)=2(n-2)V.$$
Reading the left side through (C$_i$) gives $2\nu_i(\theta-\nu_i)\le2(n-2)V$, and dividing by $2\nu_i>0$ gives the display. $\square$

**Nothing $\theta$-carrying is used to constrain $T$.** The hypotheses are (A$_i$) and $T\ge0$; (C$_i$) appears once, as the equation that names $\theta$. Some $\nu_i>0$ exists at every nonzero traceless spectrum (H4), so the bound is available at every spectrum the relaxation admits.

**Evaluated exactly, at the record's own hardest spectrum.** Take [L173](../findings/bounds-relaxations.md)'s witness: $n=12$, $\nu=a\,(-1,\tfrac43,0)$ with $a=\sqrt{3/28}$, multiplicities $(4,3,59)$. Then $V=\big(\tfrac43a\big)^2=\tfrac{16}9\cdot\tfrac3{28}=\tfrac4{21}$, and row $2$ has $\nu_2=\tfrac43a>0$, so
$$\theta\ \le\ \tfrac43a+\frac{10\cdot\tfrac{16}9a^2}{\tfrac43a}=\tfrac43a+\tfrac{40}3a=\tfrac{44}3a=\frac{22\sqrt{21}}{21}=4.800793\ldots$$
against the witness's own $\theta=\tfrac{\sqrt{21}}2=2.291287\ldots$ and $\theta_0(12)=\tfrac{\sqrt{220}}{12}=1.236033\ldots$ The bound is **finite and non-vacuous**, it excludes $\theta>4.8008$ at that spectrum, and it is weak, which is a different complaint from the one the fence makes. **The fence claims impossibility; what is true is weakness.**

## 4. Exhibit B, the same, at the toolbox's own object

Exhibit A works in the reduced variables. The fence's conclusion is about the **SDIEP toolbox**, whose object is [L112](../findings/bounds.md)'s matrix $S_{ab}:=\sum_cT_{abc}$, symmetric, hollow, nonnegative, with row sums $2(n-2)$ by (A) and $S\lambda=-2\lambda$ by (B). So the refutation is owed at that level too.

**Step 1, from $T\ge0$ and (A) alone.** For each pair $(a,b)$, $\sum_c\lambda_cT_{abc}$ is an average of $\lambda$'s against nonnegative weights summing to $S_{ab}$, so
$$\lambda_{\min}S_{ab}\ \le\ \sum_c\lambda_cT_{abc}\ \le\ \lambda_{\max}S_{ab}.$$

**Step 2, multiply by $\lambda_a\lambda_b$ and sum, taking the endpoint that the sign of $\lambda_a\lambda_b$ selects.**
$$\sum_{abc}\lambda_a\lambda_b\lambda_cT_{abc}\ \le\ \lambda_{\max}\!\!\sum_{\lambda_a\lambda_b>0}\!\!\lambda_a\lambda_bS_{ab}\ +\ \lambda_{\min}\!\!\sum_{\lambda_a\lambda_b<0}\!\!\lambda_a\lambda_bS_{ab}\ =:\ \Xi(\lambda,S).$$

**Step 3, the read-out.** [bounds.md](../findings/bounds.md) records $\sum_{abc}\lambda_a\lambda_b\lambda_cT_{abc}=2\theta-2\mathop{\mathrm{tr}}W^3$, and says in the same paragraph that this **is** (C) contracted against $\lambda$, the cubic identity and (C) are one equation. Hence
$$\theta\ \le\ \mathop{\mathrm{tr}}W^3+\tfrac12\,\Xi(\lambda,S).$$

$\Xi$ is a linear functional of $S$ alone. Maximising it over $\{S:\ S\ge0\ \text{entrywise, symmetric, hollow},\ S\mathbf1=2(n-2)\mathbf1,\ S\lambda=-2\lambda\}$ (a compact set, entries confined to $[0,2(n-2)]$), returns a finite number at every spectrum, and *that* maximisation is a question about a scaled doubly stochastic matrix with a prescribed eigenvector, which is the toolbox's subject matter. **A Schur-convexity or majorisation bound on $\Xi$ is therefore a Schur-convexity bound on $\theta$.** The impossibility claim is refuted at the level it was made.

**The prior form of the fence does not rescue this one.** [bounds.md](../findings/bounds.md) already carries *"every $\lambda$-weighted contraction of $S_{ab}$ is a $\{p,q,0\}$ pattern of $T$, while $\theta$'s $T$-dependence is the $\{1,1,1\}$ pattern"*, a genuine reason, and a sharper one. But it forbids *equalities*: it says $\theta$ is not a function of $S$. Step 1 above is an **inequality** between a $\{1,1,1\}$ contraction and $S$-data, and the pattern argument says nothing against it. **So the record's older fence is sound in what it claims and does not extend to what L175 claims.**

**Verdict 1.3: REFUTED.**

## 5. Items 3 and 4, the prose clause, and the Lean file

**Item 3, the toolbox clause.** *"Every object that toolbox produces being built from (A) and (B)"* is a universally quantified claim over an open-ended body of technique, with no definition of the range of the quantifier (H5) and no argument on file. **This claim has no argument on file** (full stop) and the debt is: fix a list of the toolbox's objects, and prove for each that it is a function of $S$ (or of the marginals) alone. The gloss the block offers instead is *"convexity arguments consume the marginals, and the marginals are (A) and (B)"*, and **that is false in the very system the lemma is stated in**: (A$_i$), (B$_i$) and (C$_i$) are the zeroth, first and second $\lambda$-moment marginals of the same row, identical in shape and differing only in weight. Calling two of the three "the marginals" is a description of the $S$-level object smuggled into a statement about L104's reduced system. **Verdicts 1.4 REFUTED, 1.5 HYPOTHESIS-DEBT.**

**Item 4, the Lean file.** [L175.lean](../lean/HamiltonsCubic/Results/L175.lean) builds, `lake build`, 8996 jobs, successful. It contains four theorems, and **only one of them states anything**.

- `C_determines_theta`, content, though trivial: $2\nu(\theta-\nu)=2\nu(\theta'-\nu)$ with $\nu\ne0$ gives $\theta=\theta'$. Sound.
- `A_theta_free` and `B_theta_free`, each is $x=x$ closed by `rfl`, with $\theta$ and $\theta'$ bound and unused. **A statement of this shape is provable for an $x$ that *does* mention $\theta$**, so it expresses nothing about $\theta$-freeness.
- `theta_free_bounds_nothing`, `(∃ d, P d) ↔ (∃ d, P d)` by `Iff.rfl`, with $\theta,\theta'$ unused. The docstring's hypothesis (*"if a predicate $P$ on the data is independent of $\theta$"*), is not expressible, because $P$ takes no $\theta$ argument. **The same `Iff.rfl` closes the statement for a predicate that depends on $\theta$.**
- `bound_must_come_from_C`, the conclusion is the hypothesis instantiated (`h d hd`). Worse: the hypothesis `∀ d, P d → ∀ θ : ℝ, θ ≤ f d` **is self-contradictory** whenever $P$ is inhabited, since it yields $f(d)+1\le f(d)$. A theorem under an unsatisfiable hypothesis states nothing.

*Screen, reported as a screen.* I wrote the three counter-shapes, an $x=x$ carrying $\theta$, an `Iff.rfl` over a $\theta$-dependent predicate, and a derivation of `False` from `bound_must_come_from_C`'s hypothesis, into a scratch file and compiled it against the project's own toolchain. All three compile, warnings only. This screens my reading of the four theorems; it is not evidence for any positive claim.

**And [lean/INDEX.md](../lean/INDEX.md) overstates the file.** Its row credits *"that (A)'s and (B)'s do not mention it, and that a $\theta$-free constraint set bounds $\theta$ only vacuously"*, the two claims the file does **not** state. The honest row is: *checks that (C)'s right side is injective in $\theta$ when $\nu_i\ne0$; the rest of the file is commentary in theorem position.*

**This is a second occurrence of a rule already filed in [.claude/skill-proposals.md](../.claude/skill-proposals.md)**, the bullet instructing the Lean layer to grep new statements for `rfl`, `:= h` and *"a hypothesis applied to its own arguments"* and delete every hit. L175.lean carries all three patterns. **Verdict 1.7: REFUTED.**

## 6. Item 5, the majorisation half

**It is a recognition, and it stands.** Set $\hat S:=S/(2(n-2))$. By (A) the row sums of $S$ are $2(n-2)$, so $\hat S$ is nonnegative with unit row sums and symmetric, hence doubly stochastic; by (B), $S\lambda=-2\lambda$, so $\hat S\lambda=-\lambda/(n-2)$. Hardy–Littlewood–Pólya then gives $-\lambda/(n-2)\prec\lambda$ immediately, and the subset-sum family is that majorisation read at each $k$, with $k=1$ recovering [L73](../findings/bounds.md) in both directions. Nothing in it mentions $\theta$, so nothing the fence says (true or false), reaches it. **The closure leaves it intact. Verdict 1.6: CONFIRMED.**

**One observation the block should carry instead of its "hence".** The correct fence is already on the record, in [L73](../findings/bounds.md)'s own block, with the right reason: *(A) and (B) hold on all of $\mathcal W_n$ while **(C) is the diagonal of $W^\#=\theta W-W^2$ and holds only at critical points**, so the per-row $\theta$-bounds cannot extend off the critical set, and a family of spectral conditions strong enough to force $\theta\le\theta_0(n)$ must read the interior rows of (C).* That passage concedes what L175 denies: (C) is available, and reading it is what a bound must do. **L175 adds no fence over that passage; it adds a false generalisation of it.**

## 7. Items 6 and 7, the conventions bullet, and whether its reason is right

**Item 6: is there a reading on which both bullets stand?** Yes, one, and it is the scope the edit makes explicit. The old bullet locates its object, *"$M$ (or $K$) is the $n\times n$ sectional matrix **in [diagonal-half.md](../findings/diagonal-half.md)**"*, and that file is the diagonal-locus file, where $W$ is coordinate-diagonal by construction and $\lVert K\rVert_F^2=2$ is exact. So the two bullets were never in conflict *as meant*. **But the letter is a universally quantified falsehood**: *"$\lVert K\rVert_F^2=2$ at a unit Weyl tensor"* is refuted by [L94](../findings/bispectral.md)'s equality clause (equality iff coordinate-diagonal in some frame, Gate 2 confirmed by [r101](REVIEW_r101.md) and [r102](REVIEW_r102.md)) and by [L95](../findings/bispectral.md)'s closed form $\kappa^2(\mathbb{CP}^m)=3/(m+1)$, which at $m=2$ gives $\max_Ft_F=1<2$, so at $\mathbb{CP}^2$ **no frame** attains $2$. A table entry is read by its letter. **The edit's substance is right: verdict 2.1 CONFIRMED.**

**No rival normalisation rescues the $=2$.** The ordered reading is what produces $2$; the unordered reading produces $1$; neither produces $2$ off the diagonal locus. Nothing in the record scales $K$ otherwise.

**Item 7: the reason, derived, then refuted as worded.** In the frame's pair basis, the $\Lambda^2$ operator has matrix $M_{\alpha\beta}$ with $\alpha,\beta$ ranging over the $N$ unordered pairs, and $M_{\alpha\alpha}=W_{abab}=K_{ab}$ for $\alpha=(a<b)$. So
$$t=\lVert K\rVert_F^2=\sum_{a\ne b}K_{ab}^2=2\sum_{\alpha}M_{\alpha\alpha}^2\ \le\ 2\sum_{\alpha,\beta}M_{\alpha\beta}^2=2\lVert M\rVert_F^2=2,$$
**with equality iff $M_{\alpha\beta}=0$ for all $\alpha\ne\beta$**, that is, iff $W_{abcd}=0$ unless $\{a,b\}=\{c,d\}$, which is coordinate-diagonality in that frame. The mechanism is that the diagonal of a symmetric matrix has Frobenius norm at most the matrix's; the record already carries it, eleven bullets above the one edited, as *"$t=2\lVert\mathop{\mathrm{diag}}W\rVert^2$"*. (*The word "Cauchy–Schwarz" there is loose (it is the orthogonal projection onto diagonal matrices) but the inequality and its equality case are right.*)

**Now the edit's clause.** *"Equality is exactly the case where those determine $W$."* Read literally (the entries $W_{abab}$ pin down $W$), **it is false, and it is false at the equality case itself.** The map $W\mapsto K$ is linear from the Weyl space into $\mathcal D_n=\{K$ hollow symmetric, $K\mathbf1=0\}$, the row sums vanishing because $\mathop{\mathrm{Ric}}_{aa}=\sum_bW_{abab}=0$. At $n=4$ the Weyl space has dimension $10$ while $\dim\mathcal D_4=\binom42-4=2$, a figure [second-order.md](../findings/second-order.md) states independently (*"the hollow zero-row-sum $4\times4$ space is $2$-dimensional"*), so the fibre through **every** $W$, coordinate-diagonal ones included, has dimension at least $8$. The gap only widens with $n$. **So no unit Weyl tensor is ever determined by its coordinate sectional curvatures, and a criterion that says "equality holds exactly where they determine $W$" would place the equality case nowhere**, contradicting [L94](../findings/bispectral.md) and [L55](../results.md)'s perfect-matching extremiser, which attains $t=2$.

**What is true, and is what the clause is reaching for**: equality holds exactly where those entries **exhaust $W$'s mass**, where $W$ has no other component in the frame. *Exhaust*, not *determine*. **Verdict 2.2: REFUTED as worded; the conclusion it supports stands on the derivation above.**

**Item 7, second half, the ground offered for the repair.** *"The unqualified reading contradicts this table's own $t=\lVert K\rVert_F^2\le2$ eleven bullets above."* This settles which reading a symbol carries by pointing at a **written numeral in the same table**, which is the exact move [proposal 73](../.claude/skill-proposals.md) was filed against, *"Refute a convention against a derived identity, never against a written numeral"*, after an occurrence in this same file, quoted into a Gate 2 brief, and re-raised by [r765](REVIEW_r765.md) and [r766](REVIEW_r766.md) days ago. **This is its second occurrence, one commit after the brief that quoted the first.** The derived ground was available and is one clause long: [L94](../findings/bispectral.md)'s equality case, which the unqualified reading makes false rather than rescales. *Mitigating: the edit's own "$K$ captures only the entries $W_{abab}$" gestures at the projection argument, so the circular clause is a redundant second ground rather than the only one.* **Verdict 2.3: CIRCULAR, repairable in one clause.**

## 8. Item 8, was the original bullet load-bearing?

**Three consumers, and the edit touches one of them.**

- **[second-order.md](../findings/second-order.md)'s L174 block** normalises $\lVert M\rVert_F=1$ *"for the operator L94's bound is stated over"* and cites this bullet's $\Lambda^2$ half as tabling it. The edit changes only the sectional half, so L174 is untouched.
- **[second-order.md](../findings/second-order.md)'s withdrawn-L150 entry** reads *"[conventions.md](../findings/conventions.md) **fixes** $\lVert K\rVert_F^2=2$ over ordered pairs, so $\lVert M\rVert\le\lVert W\rVert=1$ is false as written."* That consumer took the bullet unqualified. **Its conclusion survives**, the diagonal locus is inhabited at unit norm (H7), where $\lVert K\rVert_F=\sqrt2>1$, so the threshold is still false as written, **but its stated ground no longer reads**: after the edit the file *permits* $\lVert K\rVert_F^2=2$ at coordinate-diagonal $W$ rather than fixing it everywhere, and the consumer's sentence needs "and such $W$ exist" appended. One clause, and it is owed.
- **[INDEX-traps.md](../findings/INDEX-traps.md)'s row W6** names this exact repair as outstanding, *"the live reopening route is the letter $M$, not the index set: [L94](../findings/bispectral.md) is safe only in the $\Lambda^2$ sense, the sectional sense giving $\kappa^2\le4$, and **a row for $M$ is still owed**."* The edit discharges that debt, and W6 should now be updated to say so; as it stands the traps index still advertises an open hazard that has been closed.

## 9. Item 9, the consequence $\kappa^2\le4$

**The arithmetic is right.** [L94](../findings/bispectral.md) reads $\kappa^2\le2\lVert M\rVert_F^2$. Reading $M$ as the sectional matrix and inserting the unscoped value $\lVert K\rVert_F^2=2$ gives $\kappa^2\le4$. The same reading is recorded independently at [second-order.md](../findings/second-order.md) (*"under the table's one attached sense of $M$, L94 would read $\kappa^2\le4$"*) and in [INDEX-traps.md](../findings/INDEX-traps.md)'s W6, so the edit is importing a conclusion the record already held, correctly.

**Two riders the sentence needs.** *(i) The clause is mis-attached.* The $4$ comes from the **unscoped value**, not from being off the diagonal locus: read in the sectional sense off the locus, where $t<2$, the bound would read $\kappa^2\le2t<4$. The precise statement is *"read in the sectional sense at all, L94's bound reads $\kappa^2\le4$"*, which is how the two other sites on the record put it. *(ii) The failure mode is vacuity, not falsity.* $\kappa^2\le4$ is a true inequality ($\kappa^2\le2$ always) so a consumer who takes the sectional sense does not derive a falsehood; it loses the bound. That matters for triage: the hazard is a silently weakened bound, which no consistency check catches. **Verdict 2.4: CONFIRMED, with the attachment to fix.**

## 10. Item 10, what would show the edit wrong

**Four falsifiers, in the order they could bite.**

1. **A unit Weyl tensor, coordinate-diagonal in no frame, with $\lVert K\rVert_F^2=2$ in some frame.** That would refute the scope directly, and would refute [L94](../findings/bispectral.md)'s equality clause with it. *Foreclosed by the derivation in §7, whose equality case is exact.*
2. **A rival normalisation of $K$ under which the diagonal-locus value is not $2$**, for instance the unordered sum, giving $1$. This would leave the scope right and the numeral wrong. *Foreclosed by [conventions.md](../findings/conventions.md)'s ordered reading, which [r765](REVIEW_r765.md) and [r766](REVIEW_r766.md) both pinned against derived identities.*
3. **A consumer in [diagonal-half.md](../findings/diagonal-half.md) that needs $\lVert K\rVert_F^2=2$ off the diagonal locus.** It would show the edit narrows a sense the record actually uses. *I found none: that file's uses are $\sum\kappa^2=\lVert K\rVert_F^2=t\le2$ and the extremal $t=2$ at a genuine coordinate-diagonal witness, both compatible.*
4. **The $\Lambda^2$ half being what was wrong.** If $\lVert M\rVert_F=1$ were the mis-scoped value, the edit would have repaired the wrong half. *Foreclosed: unit norm is the definition of $\mathcal W_n\cap S$, not a locus-dependent value.*

**And what would show my own verdict on claim 1 wrong.** A definition of "the SDIEP toolbox" narrow enough that every one of its objects is provably a function of $S$, **together with** an argument that no inequality of Exhibit B's shape counts as an argument *from* the toolbox. The first is a real research task; the second I believe cannot be sustained, since Step 1 of Exhibit B uses nothing but $T\ge0$ and (A).

## 11. What I checked and found nothing wrong with

*Silence is not a verdict, so these are recorded as clean.* The coefficients of (A$_i$), (B$_i$), (C$_i$) against [bounds.md](../findings/bounds.md)'s unreduced forms, including the $(\nu_j+\nu_k)$ weight in (B$_i$); the two dependencies of L104 read at their right-hand sides, both closing exactly; the injectivity of $\theta\mapsto2\nu_i(\theta-\nu_i)$ at $\nu_i\ne0$; L173's spectrum data used in §3 ($a^2=3/28$, $\tfrac{28}3a^2=1$, $4+3+59=66=\binom{12}2$); the doubly-stochastic normalisation $\hat S=S/(2(n-2))$ and its eigenvalue $-1/(n-2)$; the headline ratio $\sqrt t\le\sqrt2$ of claim 2.5; and the whole Lean layer's build.

## Overall

**Claim 1, BROKEN.** Its first sentence is true and its operative consequence is refuted, by two exhibits and by the record's own compactness proof. What survives is worth one sentence: *a multiplier certificate with $\gamma=0$ produces no bound on $\theta$.* What must go is *"which is to say it bounds nothing"* and the *"hence"* that follows it, together with the false gloss that the marginals are (A) and (B).

**Claim 2 (PROVEN), hypotheses corrected.** The scope belonged in the bullet and the edit puts it there, discharging a debt [INDEX-traps.md](../findings/INDEX-traps.md) had open. Its reason must be replaced: *equality is where the entries exhaust $W$'s mass*, cited to [L94](../findings/bispectral.md)'s proved equality case rather than to the neighbouring table row.

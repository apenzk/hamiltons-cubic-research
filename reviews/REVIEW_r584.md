# Review r584, Lemma L4 (a generator for critical points, and a new family)

Reviewer r584, independent adversarial audit. Target: `Lemma L4 (a generator for critical points, and a new family), canonical statement and proof`, in [findings/ungraded-slack.md](../findings/ungraded-slack.md).

Analysis-only footing: no sweeps, no falsifier hunts, no censuses. Screens (seconds of compute on objects constructed for the purpose) are labelled as screens and never cited as evidence for a positive claim.

Verdicts are appended below as they are reached.

## Verdicts

### Summary

**Overall: REFUTED as stated.** The block's two paragraphs carry four false clauses, two of which are refuted by the block's own contents. The criterion is true but for a reason the block does not give, with one hypothesis redundant and one missing. Two supporting numbers are wrong. What survives intact is the closed form and the cap, which I rebuilt from the definitions.

| # | clause | verdict |
| --- | --- | --- |
| D1 | provenance, second clause | **REFUTED** |
| D2 | heading promises a proof | **CONFIRMED defect**, no proof in the block |
| D3 | the criticality criterion | **REPAIRED**, $(\Lambda^4)^K=0$ redundant, $(\mathrm{Sym}^2)^K=\mathbb R\,\mathrm{Id}$ missing |
| D4 | "None is coordinate-diagonalizable" | **REFUTED** at every even $n$ |
| D5 | padding vs "every member has just two eigenvalues" | **REFUTED**, mutually inconsistent |
| D6 | "$\theta$ increases with $\dim\mathfrak h$" | **REPAIRED**, true at fixed $n$, false across the family |
| D7 | maximum attained at $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ | **REPAIRED**, needs $n$ even |
| D8 | simple-isotropy ceiling $0.8367$ | **REFUTED**, $\mathfrak{spin}(9)\subset\mathfrak{so}(16)$ gives $0.896421$ |
| D9 | "Two non-members exceed $\theta_0$ harmlessly" | **REFUTED** on the count, **CONFIRMED** on *harmlessly* |
| D10 | the block above the heading | **CONFIRMED defect**, carries a claim withdrawn 20 lines below it |
| D11 | closed form, cap, equality case | **CONFIRMED**, rebuilt from definitions |
| D12 | citation count | **REFUTED**, 2 genuine, not 26 |

## D1, the provenance note is false in its second clause

The note reads *"Moved here from [results.md](../results.md) on 2026-08-31, where the argument was the only copy. That file now carries the statement and points here."*

- **Clause 1 is true.** The move is `a9e4b8c0` (2026-08-31, *refactor(results): the proofs move to findings*), which landed the text in [graded-half.md](../findings/graded-half.md); `7ad0455d` split it out the same day.
- **Clause 3 is true but empty.** [results.md](../results.md) line 314 is **byte-identical** to [ungraded-slack.md](../findings/ungraded-slack.md) line 109. `diff` returns one difference and it is the blank line. So the move duplicated rather than relocated; nothing distinguishes "the statement" in the one file from "the proof" in the other.
- **Clause 2 is false.** `git show a9e4b8c0^:findings/graded-half.md` shows that the destination file **already carried the argument**, in fuller form and with a proof, at lines 272–302: the family definition, the theorem, the closed form, the derivation of $S_{\mathfrak{hmm}}$ and $S_{\mathfrak{mmm}}$, the cap, the equality case, and the three-hypothesis criticality criterion. What moved from results.md was the two-paragraph *statement*, and it was not the only copy of anything.

**Same failure mode as [L5](../findings/graded-half.md): a byte-identical copy sits in the file the note names, and the argument the note claims to be unique already stood 30 lines above the landing site.**

## D2, the heading promises a proof the block does not contain

The heading is *"canonical statement and proof"*. The block is: the provenance line, one paragraph byte-identical to results.md, one paragraph asserting the maximum and ending *"Lemma L23 proves both statements"*. The criterion's justification is the two words *"by equivariance"*. **There is no proof of anything in the block.** Both proofs live elsewhere, the closed form and the cap in [L23](../findings/ungraded-slack.md) below it, the criticality criterion in the unnumbered subalgebra-family block above it.

## D3, the criterion: one hypothesis redundant, one missing

**As stated, the criterion is true and $(\Lambda^4\mathbb R^n)^K=0$ does no work.** By [conventions.md](../findings/conventions.md), $\mathcal W_n$ is the space of algebraic Weyl curvature operators (Ricci-flatness and the first Bianchi identity are built into membership) and $Q$ sends $\mathcal W_n$ to itself. $Q$ is $O(n)$-equivariant, since $W^2$ and $W^\#$ are both natural in $W$. So if $\dim\mathcal W_n^K=1$ and $W$ spans $\mathcal W_n^K$, then $Q(W)\in\mathcal W_n$ and $Q(W)$ is $K$-invariant, hence $Q(W)\in\mathcal W_n^K=\mathbb R W$, hence $Q(W)=\theta W$. **The $4$-form hypothesis is never used.**

**What $(\Lambda^4)^K=0$ actually buys** is admission to $\mathcal W_n$, and only for a candidate not already known to be a Weyl operator. For the Casimir $W_{\mathfrak h}=c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$, which is a priori only a symmetric operator on $\Lambda^2$, $\mathrm{Alt}(W_{\mathfrak h})\in\Lambda^4$ is $K$-invariant, so $(\Lambda^4)^K=0$ forces $\mathrm{Alt}(W_{\mathfrak h})=0$. **But the same candidate also needs $\mathrm{Ric}(W_{\mathfrak h})=0$, which needs $(\mathrm{Sym}^2\mathbb R^n)^K=\mathbb R\,\mathrm{Id}$, the family block's (F2), which L4 omits entirely.**

**So the block is caught between two readings and neither is what it claims.** Read with $W$ the generator of $\mathcal W_n^K$, the conclusion holds and the $4$-form hypothesis is decoration. Read with $W$ the Casimir, which is the reading the rest of the block needs, since $r=\dim\mathfrak h$ and the closed form are about $W_{\mathfrak h}$, the criterion is **incomplete**, missing exactly the hypothesis whose necessity the file demonstrates 3 lines above the heading: *"which is why (F2) matters: $\mathfrak{so}(3)+\mathfrak{so}(5)\subset\mathfrak{so}(8)$ … both with $\lVert\mathrm{Ric}\rVert\approx1$, so neither is a Weyl operator."*

**Neither hypothesis is used anywhere else in the block.** Repaired statement: *if $K\subseteq O(n)$ satisfies $(\mathrm{Sym}^2\mathbb R^n)^K=\mathbb R\,\mathrm{Id}$ and $(\Lambda^4\mathbb R^n)^K=0$, and the $K$-invariant traceless operators on $\Lambda^2$ are one-dimensional, then their generator is a Weyl operator and is critical.*

*Note on $K\subseteq SO(n)$:* the family block warns that "taking $K$ connected loses the equality case" at $n=8$ and restores it with "the $O(4)\times O(4)$ reflections and the block swap". The single-block reflections lie outside $SO(8)$, but the **pair** of reflections does not: it has determinant $+1$, negates both block volume forms, and exchanges self-dual with anti-self-dual in both $\mathfrak{so}(4)$ factors. Together with the block swap (four transpositions, determinant $+1$) it restores both conditions inside $SO(8)$. So L4's $K\subseteq SO(n)$ survives at $n=8$; the record's warning is about connectedness, not about $SO$ against $O$.

## D4, "None is coordinate-diagonalizable" is refuted by the block's own second paragraph

The block's paragraph 2 states that $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ attains the cap, so *"the balanced sphere product is itself a member and the family's maximiser."*

[conventions.md](../findings/conventions.md) records $\Theta_n$, **the diagonal maximum**, as equal to $\theta_0(n)$ at even $n$, so $\theta_0(n)$ is attained **on the diagonal locus** $\mathcal D_n$, and its attainer is coordinate-diagonal. That attainer is $W_{S^{n/2}\times S^{n/2}}$, which the block has just admitted as a member.

**So the family contains a coordinate-diagonal member at every even $n$, and "None is coordinate-diagonalizable" is false at every even $n\ge6$.** The block treats $\mathfrak{su}(2)\oplus\mathfrak{su}(2)$ at $n=6$ as *"the lone exception"*; $\mathfrak{so}(4)\oplus\mathfrak{so}(4)\subset\mathfrak{so}(8)$, $\mathfrak{so}(5)\oplus\mathfrak{so}(5)\subset\mathfrak{so}(10)$ and the whole balanced tower are the same exception at every even $n$, and the block names their generator itself two sentences later. The route is disjoint from the block's: it uses only the $\Theta_n$ row of conventions.md and the block's own attainment claim.

*Secondary:* $\mathfrak{su}(2)\oplus\mathfrak{su}(2)$ is **semisimple, not simple**, so it is not among the "bi-invariant metrics on compact simple Lie groups" the sentence scopes itself to. The exception clause does not type-check against its own quantifier.

## D5, padding and "every member has just two eigenvalues" cannot both hold

Sentence 2: *"zero-padding preserves everything, so they persist into $n=12$."* Sentence 3: *"Every member has just two eigenvalues, giving the closed form $P/\lVert W\rVert^3=\tfrac2n\sqrt{rN/(N-r)}$."*

$W_{\mathfrak h}$ padded from $\Lambda^2\mathbb R^8$ into $\Lambda^2\mathbb R^{12}$ has **three** eigenvalues: $u$ on $\mathfrak h$, $v\ne0$ on $\mathfrak m\subset\Lambda^2\mathbb R^8$, and $0$ on the $\binom{12}2-\binom82=38$-dimensional complement. And [conventions.md](../findings/conventions.md) states that padding preserves $\theta$, so the padded $SU(3)$ point sits at $\theta=0.8367$ at $n=12$, while the closed form at $n=12$ with $r=8$, $N=66$ returns

$$\tfrac{2}{12}\sqrt{\tfrac{8\cdot66}{58}}=0.502870 .$$

**So either the padded points are members, and both sentence 3's eigenvalue count and its closed form are false on them; or they are not members, and sentence 2 is about points outside the family it is introducing.** Either way the paragraph is inconsistent with itself.

## D6, "$\theta$ increases with $\dim\mathfrak h$" holds only at fixed $n$

**Derivation, at fixed $n$.** From $\theta^2=\tfrac{4}{n^2}\cdot\tfrac{rN}{N-r}$ and $\tfrac{d}{dr}\tfrac{r}{N-r}=\tfrac{N}{(N-r)^2}>0$, $\theta$ is strictly increasing in $r$ on $(0,N)$. Two lines, so the monotonicity is derivable rather than merely assertible.

**Across the family it is false, and the block's own two members refute it.** $\mathfrak{su}(3)\subset\mathfrak{so}(8)$ has $r=8$ and $\theta=0.8367$; $\mathfrak{sp}(3)\subset\mathfrak{so}(14)$ has $r=21$ and $\theta=0.7464$. **Larger $\dim\mathfrak h$, smaller $\theta$.** The clause needs "at fixed $n$", and the maximum claim inherits that scope.

**The maximum claim itself is per-$n$, and the block does not say so.** $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ increases in $n$ with supremum $\sqrt2$, so "the family's maximiser" is a maximiser at each $n$, and the family has no global maximum.

## D7, the parity quantifier is dropped

L4 asserts the cap is *"attained by $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$"* with no restriction on $n$. Both neighbouring blocks in the same file carry the restriction: *"Equality needs $n$ even; for odd $n$ the cap is not an integer and $\theta<\theta_0$ strictly."* At odd $n$, $n(n-2)/4\notin\mathbb Z$ and the maximiser does not exist. L4 is the canonical statement and is the one place the qualifier is missing.

L4 also drops the $n=8$ uniqueness caveat that [L23](../findings/ungraded-slack.md) records: triality places $\mathfrak{spin}(7)$ ($r=21$) and $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$ ($r=13$) outside the usual enumeration, both above the cap $12$.

## D8, the simple-isotropy ceiling $0.8367$ is refuted by $\mathfrak{spin}(9)\subset\mathfrak{so}(16)$

The claim: *"The members with **simple** isotropy … top out far below at $0.8367$."* It is also the figure results.md's [L5](../results.md) consumes as $P\le0.837$.

**Witness: the Cayley plane $\mathbb{OP}^2=F_4/\mathrm{Spin}(9)$.** It is one of the two sources of members L4 itself names, an isotropy-irreducible symmetric space with $b_4=0$.

- $n=\dim\mathbb{OP}^2=16$, $\mathfrak h=\mathfrak{spin}(9)$ acting by the real $16$-dimensional spin representation $\Delta_9$, $r=36$, $N=\binom{16}2=120$.
- $\mathfrak h$ is **simple**.
- $b_4=0$: $\mathbb{OP}^2$ has real cohomology in degrees $0,8,16$ only. For a compact symmetric space $H^k(G/K;\mathbb R)\cong(\Lambda^k\mathfrak m)^K$, so $(\Lambda^4\mathbb R^{16})^{\mathrm{Spin}(9)}=H^4(\mathbb{OP}^2;\mathbb R)=0$, **(F3) holds**.
- $\mathrm{Sym}^2\Delta_9=\Lambda^0\oplus\Lambda^1\oplus\Lambda^4$ of $\mathbb R^9$, dimensions $1+9+126=136$, so the trivial summand appears once, **(F2) holds**.
- $\Lambda^2\Delta_9=\Lambda^2\mathbb R^9\oplus\Lambda^3\mathbb R^9$, dimensions $36+84=120$, both irreducible and inequivalent, and $\mathfrak h$ is the $36$, **(F1) holds**.
- Passing from $\mathrm{Spin}(9)$ to the full normaliser only shrinks the invariant spaces, so all three survive.

So it is a member, and the closed form gives

$$\theta=\frac{2}{16}\sqrt{\frac{36\cdot120}{84}}=\frac34\sqrt{\frac{10}{7}}=0.896421>0.836660 .$$

**The stated ceiling is exceeded by $0.0598$.** It is also consistent with the cap: $r=36\le n(n-2)/4=56$, and $\theta<\theta_0(16)=1.280869$.

**Impact.** The corrected simple-isotropy ceiling is $\ge0.896421$; I make no claim that it is exactly that, which would need a census. [L5](../results.md)'s conclusion survives, $0.8964$ still loses to both named competitors, $\sqrt{3/2}=1.224745$ and $\theta_0(n)$, but its stated figure $P\le0.837$ is wrong, in results.md line 320 and in its duplicate at [graded-half.md](../findings/graded-half.md) line 69.

*This is a second, independent refutation of the same figure: the file already records $\theta=0.8519,0.8577,0.8700$ for $U(m)$- and $Sp(m)$-block members 43 lines above the L4 heading. Those have non-simple $\mathfrak h$ and so leave the "simple isotropy" clause standing; $\mathfrak{spin}(9)$ does not.*

## D9, "Two non-members exceed $\theta_0$" is refuted on the count; *harmlessly* is earned

The hedge, 3 lines above the L4 heading, names $\mathfrak{so}(3)+\mathfrak{so}(5)\subset\mathfrak{so}(8)$ at $1.151371$ and $\mathfrak{so}(4)+\mathfrak{so}(6)\subset\mathfrak{so}(10)$ at $1.203766$.

**Both numbers are right, and they are $P$, not the closed form.** I rebuilt $P$ from the definitions for $\mathfrak h=\mathfrak{so}(p)\oplus\mathfrak{so}(q)$: with $u,v$ the two eigenvalues, $T_{abc}=c_{abc}^2$ totally symmetric, and $T$ vanishing on two-$\mathfrak h$-one-$\mathfrak m$ index types,

$$P=r u^3+(N-r)v^3+\tfrac12\big[S_{\mathfrak{hhh}}u^3+3S_{\mathfrak{hmm}}uv^2+S_{\mathfrak{mmm}}v^3\big],$$

with $S_{\mathfrak{hhh}}=2(p-2)\binom p2+2(q-2)\binom q2$, $S_{\mathfrak{hmm}}=2(n-2)r-S_{\mathfrak{hhh}}$, $S_{\mathfrak{mmm}}=2(n-2)(N-r)-2S_{\mathfrak{hmm}}$. This reproduces $1.151371$ and $1.203766$ exactly, and returns $S_{\mathfrak{mmm}}=0$ throughout, as a symmetric pair must. It also confirms the block's normalisation is the record's, since it returns $\theta_0(n)$ at the balanced splits.

**A third non-member, hand-checkable in full: $\mathfrak{so}(2)\oplus\mathfrak{so}(3)\subset\mathfrak{so}(5)$.** Here $n=5$, $N=10$, $r=1+3=4$, $c^2=5/12$, $u=\tfrac35c$, $v=-\tfrac25c$, $S_{\mathfrak{hhh}}=0+6=6$, $\kappa=6$, $S_{\mathfrak{hmm}}=24-6=18$, $S_{\mathfrak{mmm}}=36-36=0$. Then

$$P=c^3\Big[\tfrac{108-48}{125}+\tfrac12\Big(\tfrac{6\cdot27}{125}+\tfrac{54\cdot12}{125}\Big)\Big]=\tfrac{93}{25}c^3=\frac{93}{25}\cdot\frac{5\sqrt{15}}{72}=\frac{31\sqrt{15}}{120}=1.000521,$$

against $\theta_0(5)=\tfrac{2\sqrt6}{5}=\tfrac{48\sqrt6}{120}=0.979796$. **Exactly:** $31^2\cdot15=14415>13824=48^2\cdot6$. So $P>\theta_0(5)$, with no numerics anywhere in the check.

**A screen**, seconds of compute on the $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ operators I constructed for the purpose, reported as a screen and not as evidence for any positive claim, finds a split exceeding $\theta_0(n)$ at **every** $n$ from $5$ to $16$ except $n=4$: $(2,3)$, $(2,4)$, $(3,4)$, $(3,5)$, $(4,5)$, $(4,6)$, $(5,6)$, $(5,7)$, $(5,8)$ and $(6,7)$, $(6,8)$, $(6,9)$ and $(7,8)$, $(7,9)$. **"Two" is not a count of anything; the phenomenon is generic in the near-balanced unbalanced splits, and the honest statement is a mechanism rather than a list.**

***harmlessly* is earned.** Every one of these fails (F2) ($(\mathrm{Sym}^2\mathbb R^n)^{O(p)\times O(q)}$ is two-dimensional) so $\mathrm{Ric}\ne0$ and none is a Weyl operator; and each has $S_{\mathfrak{mmm}}=0$ with $r>n(n-2)/4$, so by [L23](../findings/ungraded-slack.md)'s own equality analysis a symmetric pair is critical only *at* the cap and these are not critical. The mechanism the sentence gives is right; only its count is wrong.

## D10, the text above the heading carries a claim withdrawn 20 lines below it

The brief directs that L4's boundaries run above the heading. The unnumbered subalgebra-family block immediately above ([ungraded-slack.md](../findings/ungraded-slack.md) lines 74–104) is the same subject and still reads:

> *"Every one of them carries a parallel $4$-form, so **(F3) says exactly that $\mathfrak h$ is not a special-holonomy algebra**, and the theorem restates as a Lie-theoretic bound: an irreducible non-special-holonomy subalgebra of $\mathfrak{so}(n)$ has dimension at most $n(n-2)/4$, with equality only for the balanced split."*

[L23](../findings/ungraded-slack.md), in the same file, withdraws **both** halves of that sentence, the Lie-theoretic bound explicitly (*"and that is withdrawn"*, on the ground that the balanced split is reducible on $\mathbb R^n$ and so lies outside the stated domain), and the mechanism (*"only $\mathfrak g_2$ and $\mathfrak{spin}(7)$ are excluded by the $4$-form"*, against the earlier block's *"failing only (F3)"* / *"failing only (F2)"* attributions). **The withdrawn text stands unmarked, and it is what a reader arriving at L4 reads first.**

## D11, the closed form, the cap and the equality case are CONFIRMED

Rebuilt from the definitions, using only: $c_{abc}=\langle[\varphi_a,\varphi_b],\varphi_c\rangle$ totally antisymmetric, $\kappa=2(n-2)$, $\sum_{b,c}c_{abc}^2=\kappa$, and $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$.

$\lVert W_{\mathfrak h}\rVert^2=ru^2+(N-r)v^2=c^2r(N-r)/N=1$ and $ru+(N-r)v=0$. Tracing $Q(W)=\theta W$ against $\Pi_{\mathfrak h}$ and $\Pi_{\mathfrak m}$, substituting $S_{\mathfrak{hhh}}=\kappa r-S_{\mathfrak{hmm}}$ and $S_{\mathfrak{mmm}}=\kappa(N-r)-2S_{\mathfrak{hmm}}$, and writing $\rho=r/(N-r)$, $\sigma=1+\kappa/2=n-1$:

$$\theta=u\Big[\sigma+\tfrac{S_{\mathfrak{hmm}}}{2r}(\rho^2-1)\Big]=u\Big[-\sigma\rho+\tfrac{S_{\mathfrak{hmm}}N}{(N-r)^2}\Big] \;\Longrightarrow\; S_{\mathfrak{hmm}}\cdot\frac{N^2}{2r(N-r)^2}=\frac{\sigma N}{N-r},$$

so $S_{\mathfrak{hmm}}=2\sigma r(N-r)/N$ and $\theta=\sigma ur/(N-r)=(n-1)\sqrt{r/(N(N-r))}$, which equals $\tfrac2n\sqrt{rN/(N-r)}$ since $(n-1)n/(2N)=1$. Back-substitution gives $S_{\mathfrak{mmm}}=(N-r)[2(n-2)-4(n-1)r/N]$, and $S_{\mathfrak{mmm}}\ge0$ gives $r\le N(n-2)/(2(n-1))=n(n-2)/4$. At the cap $N-r=n^2/4$ and $\theta=\sqrt{2(n-1)(n-2)}/n=\theta_0(n)$. **Every step checks.**

**On brief item (4): L4 does not inherit [L105](../findings/bounds-relaxations.md)'s problem.** The cap L4 consumes is [L23](../findings/ungraded-slack.md)'s, and its only ingredient is that $S_{\mathfrak{mmm}}$ is a sum of squares of structure constants. It uses neither $T\ge0$ as an LP relaxation nor $t_{112}=0$; there is no hypothesis to discharge. The two derivations reach the same number by disjoint routes, which is a genuine cross-check and is what the file's *"What it does not reach"* paragraph correctly calls a sum-of-squares re-derivation.

## D12, what cites L4, by the corrected rule

| pattern | count |
| --- | --- |
| raw `L4` substring in [findings/](../findings/), [results.md](../results.md), [report/](../report/) | 87 |
| after discarding `L40`–`L49` | 5 |
| after discarding L4's own heading, its detail heading and its glance entry | **2** |

**The two genuine citations are the same sentence in two places**, [L5](../results.md) at results.md line 320 and its duplicate at [graded-half.md](../findings/graded-half.md) line 69, and both consume the figure D8 refutes. **No citation of L4 exists in [report/](../report/).** The brief's figure of 26 is between the raw substring count and the corrected one; the inflation is entirely $L40$–$L49$ (`L43` alone accounts for 13 hits). The `L4` occurrences in [reviews/INDEX.md](INDEX.md) are brief-local labels for sub-claims of a review of [L70](../findings/bounds.md) and are correctly discounted.

**Every use is inside L4's hypotheses**, since neither citation invokes the criterion, they invoke the ceiling, which is where the defect is.

## What the block leans on that is still undefined

- **$\mathfrak h$.** The block's only formula reads $r=\dim\mathfrak h$, and $\mathfrak h$ is never introduced in the block. [conventions.md](../findings/conventions.md) tables $\mathfrak h$ only as $E_{\max}$ at a critical point; L4 needs it as *an arbitrary subalgebra of $\mathfrak{so}(n)$*, which happens to coincide with $E_{\max}$ on this family but is a different definition. $\mathfrak m$ likewise, and conventions.md already warns that $\mathfrak m$ carries three incompatible senses.
- **$b_4$.** Used as the selection condition on symmetric spaces and defined nowhere on the record. It is the fourth Betti number, and the step that makes it usable ($H^4(G/K;\mathbb R)\cong(\Lambda^4\mathfrak m)^K$ for a compact symmetric space), is the whole bridge from L4's stated hypothesis to its named examples, and is stated nowhere.
- **The relation between L4's $K$ and the family's $K$.** L4 says $K\subseteq SO(n)$; the family says $K=N_{O(n)}(\mathfrak h)$, the full normaliser. Nothing on the record connects them.
- **"$P=0.8367$" against "$P/\lVert W\rVert^3$".** Both appear in one paragraph. They agree only at $\lVert W\rVert=1$, which the block never states. Given the live $\sqrt2$ and factor-$2$ normalisation traps tabled in conventions.md, this is worth one clause. *I checked the normalisation independently: my rebuild returns $\theta_0(n)$ at the balanced splits and $1.151371$ at $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$, so the block is in the record's pairing.*

## What the record already knew

[plan-verification.md](../plan-verification.md) line 136 records that a verification round on **L04** ran on 2026-09-02 and **stopped at three of five**, with four broken claims G1–G4 filed in [ROUND_L04.md](../verification/ROUND_L04.md) and **none written into the record**. The block therefore stands today in the state that round found it in, with its defects on file and unmarked in the block itself. *My findings above were derived before reading that file.*

### Cross-check against [ROUND_L04.md](../verification/ROUND_L04.md), read after the above was written

The stopped round's four candidates G1–G4 overlap this audit at three points and **all three agree**: G3 is D3's redundancy finding, G4 is D4, and G1 is the eigenvalue-count finding I reached through padding. G2 (the cap is delegated to result 23 and this entry does not carry its hypotheses) is compatible with D11, I confirm the cap's derivation is sound and self-contained, and G2's complaint is about L4 not carrying it, which is D2.

**G1's route is better than D5's and I confirm it independently.** L4's criterion produces the generator of $\mathcal W_n^K$, which need not be a Casimir. Take $K=O(5)\times O(7)\subset SO(12)$. Over $K$, $\Lambda^2\mathbb R^{12}=\Lambda^2\mathbb R^5\oplus(\mathbb R^5\otimes\mathbb R^7)\oplus\Lambda^2\mathbb R^7$, three irreducible inequivalent summands, so the $K$-invariant symmetric operators are $3$-dimensional, the traceless ones $2$-dimensional, and Ricci-flatness (one condition, since $(\mathrm{Sym}^2\mathbb R^{12})^K$ is $2$-dimensional), cuts that to **one**. And $(\Lambda^4\mathbb R^{12})^K=0$, since an invariant would need $\Lambda^pR^5\otimes\Lambda^qR^7$ with $p+q=4$ and an $O(5)$-invariant in $\Lambda^p\mathbb R^5$, forcing $p=0$, leaving $(\Lambda^4\mathbb R^7)^{O(7)}\cong(\Lambda^3\mathbb R^7)^{O(7)}=0$.

**So L4's hypotheses hold at $K=O(5)\times O(7)$, and the $W$ they produce is $W_{S^5\times S^7}$, whose spectrum has three distinct values.** *"Every member has just two eigenvalues" is refuted by L4's own criterion, at $n=12$, the dimension the previous sentence sends the family to.* The same file says as much 20 lines below the block: *"any graded critical point whose Weyl operator has three or more distinct eigenvalues is not a Casimir"*, naming $S^5\times S^7$. This is the sharpest instance of the record already holding what settles the block.

**Standing after this audit.** Three of the four candidates from the stopped round are independently reconfirmed here, and D1, D6, D7, D8, D9, D10 and D12 are new.

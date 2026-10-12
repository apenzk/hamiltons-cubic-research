# ROUND L23, the subalgebra family's closed form, the cap $r\le n(n-2)/4$, and its equality case

**Id:** L23. **Source:** [findings/ungraded-slack.md](../findings/ungraded-slack.md):124–150. **Date:** 2026-09-07. **Verifiers allocated:** v137, v138, v139. **Phase:** 6, closed. **Verdict:** `PROVEN, hypotheses corrected`, repaired, impact `PROPAGATES`.

**Why this id.** Tier 1, cited eight or more times. **A round on [Lemma L4](../findings/ungraded-slack.md) found that the closed form it advertises is derived here and nowhere else**, three verifiers rebuilt that derivation from this block without the block having been checked itself.

**Pre-registered questions.** *(Questions, not verdicts. No adjudication has run on any.)*

1. **Does the closed form follow?** **Derive $\theta=\tfrac2n\sqrt{rN/(N-r)}$ and the companion $S_{\mathfrak{mmm}}$ expression, check the elimination is forced rather than one solution among several, and say which normalisations the constants depend on.**
2. **Is the cap right, and is its equality case what the block says?** *The claim is $r\le n(n-2)/4$ and $\theta\le\theta_0(n)$, with equality in either place exactly when $S_{\mathfrak{mmm}}=0$.* **Check the two inequalities separately, check that the two equality cases really coincide, and check the stated characterisation of that locus.**
3. **What does the family require of $\mathfrak h$?** **List every hypothesis the derivation uses (subalgebra, dimension bounds, irreducibility, anything on $\mathfrak m$) and say which the statement carries and which it does not.**

**A source is read, never cited from memory.** *If a source is not in [references/](../references/), say the claim rests on an unread source.*

## The brief as dispatched

*Provenance stripped, mathematics verbatim, quoted from the current source.*

Needed because the open half of the core is a statement about gradedness, and the only population that could test it (the multi-block sphere products), confounds gradedness perfectly with the number of factors: there, ungraded means $k\ge3$ and the value is a function of $k$ alone. A population is needed on which the two vary independently. Critical points indexed by a **subalgebra** supply one, since no block count enters the construction.
**Statement.** Let $\mathfrak h\subseteq\mathfrak{so}(n)=\Lambda^2\mathbb R^n$ be a subalgebra with $\mathfrak m=\mathfrak h^\perp$, $r=\dim\mathfrak h$, $N=\binom n2$ and $0<r<N$, and let $W_{\mathfrak h}$ be the unit-norm multiple of $\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$. If $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$, then
$$\theta=\frac2n\sqrt{\frac{rN}{N-r}},\qquad S_{\mathfrak{mmm}}:=\sum_{a,b,c\in\mathfrak m}\langle[\varphi_a,\varphi_b],\varphi_c\rangle^2=(N-r)\Big[2(n-2)-\frac{4(n-1)r}{N}\Big],$$
hence $r\le n(n-2)/4$ and $\theta\le\theta_0(n)$, with equality in either place exactly when $S_{\mathfrak{mmm}}=0$, that is, when $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$, when $W_{\mathfrak h}$ is $\mathbb Z_2$-graded in the sense settled elsewhere in this file, and when $(\mathfrak{so}(n),\mathfrak h)$ is a symmetric pair. **The one arrow needing an argument is $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$**: the others are definitions, and this one uses $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$, which holds because $\mathfrak h$ is a subalgebra and the form is invariant. For $n$ even the equality case is $\mathfrak h=\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ alone, **at $n=8$ by a separate check, since [trap W2](INDEX-traps.md) records that triality puts $\mathfrak{spin}(7)$ and $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$ outside the usual enumeration, and their dimensions $21$ and $13$ both exceed the cap $12$**, so the maximum over the family is attained exactly at the Weyl operator of $S^{n/2}\times S^{n/2}$; for $n$ odd the cap is not an integer and the inequality is strict.
**Proof.** Write $u=c(1-r/N)>0$ and $v=-cr/N<0$ for the two eigenvalues. Because $\mathfrak h$ is a subalgebra, $[\mathfrak h,\mathfrak h]\perp\mathfrak m$, so with $\kappa=2(n-2)$ the Killing constant of $\mathfrak{so}(n)$ in an orthonormal basis, $S_{\mathfrak{hhh}}+S_{\mathfrak{hmm}}=\kappa r$ and $2S_{\mathfrak{hmm}}+S_{\mathfrak{mmm}}=\kappa(N-r)$. Since $W_{\mathfrak h}$ has two eigenvalues, $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$ yields the two scalar equations, as the traces of the eigen-equation against $\Pi_{\mathfrak h}$ and $\Pi_{\mathfrak m}$, $u^2+\tfrac1{2r}(S_{\mathfrak{hhh}}u^2+S_{\mathfrak{hmm}}v^2)=\theta u$ and $v^2+\tfrac1{2(N-r)}(2S_{\mathfrak{hmm}}uv+S_{\mathfrak{mmm}}v^2)=\theta v$. Eliminating $S_{\mathfrak{hhh}}$ and $S_{\mathfrak{mmm}}$ through the two relations and using $ru+(N-r)v=0$ gives $S_{\mathfrak{hmm}}=2\sigma r(N-r)/N$ and $\theta=\sigma ur/(N-r)$ with $\sigma=1+\kappa/2=n-1$, which is the closed form, and back-substitution gives $S_{\mathfrak{mmm}}$. That quantity is a sum of squares, so it is non-negative, which is the cap; at $r=n(n-2)/4$ one has $N-r=n^2/4$ and the closed form evaluates to $\sqrt{2(n-1)(n-2)}/n=\theta_0(n)$. Among symmetric pairs, $\binom p2+\binom q2=n(n-2)/4$ with $p+q=n$ forces $(p-q)^2=0$, and $\mathfrak u(m)\subset\mathfrak{so}(2m)$ has $r=m^2\ne m(m-1)$. $\square$
**Producing members.** Criticality is not an extra assumption to check case by case. With $K=N_{O(n)}(\mathfrak h)$ the full normaliser, it suffices that $\mathfrak h$ and $\mathfrak m$ be $K$-irreducible **and inequivalent as $K$-modules**, that $(\mathrm{Sym}^2\mathbb R^n)^K=\mathbb R\,\mathrm{Id}$, and that $(\Lambda^4\mathbb R^n)^K=0$: the second makes $W_{\mathfrak h}$ Ricci-flat, the third Bianchi-free, and since $Q$ preserves the Weyl space and the $K$-invariant traceless Weyl operators are $\mathbb R\,W_{\mathfrak h}$, the eigen-equation follows.
**What the hypotheses exclude is the Berger list.** The subalgebras that exceed the cap are $\mathfrak g_2\subset\mathfrak{so}(7)$ at $r=14$ against $8.75$, $\mathfrak{spin}(7)\subset\mathfrak{so}(8)$ at $r=21$ against $12$, $\mathfrak{so}(n-1)\subset\mathfrak{so}(n)$, and $\mathfrak u(m)$, $\mathfrak{su}(m)$, $\mathfrak{sp}(m)\oplus\mathfrak{sp}(1)$ at $m\le2$, together with the unbalanced splits.
**Each of the three conditions does its own excluding, and only $\mathfrak g_2$ and $\mathfrak{spin}(7)$ are excluded by the $4$-form.** $\mathfrak{so}(n-1)$ and every unbalanced split have $(\Lambda^4\mathbb R^n)^K=0$ identically, since $\Lambda^4\mathbb R^n=\Lambda^4\mathbb R^{n-1}\oplus\Lambda^3\mathbb R^{n-1}$ over $O(n-1)$ and neither summand carries an invariant for $n\ge6$; they fail (F2) instead, which is what this file's own hypotheses paragraph says of $\mathfrak{so}(n-1)$. **And the symmetric pairs among them are excluded by the eigen-equation itself**: $S_{\mathfrak{mmm}}=0$ turns the closed form into $r=n(n-2)/4$ exactly, so a symmetric pair is critical only *at* the cap, which is why $\mathfrak u(m)$, at $r=m^2$ against $m(m-1)$, never enters the family. *So the cap is not a bound on symmetric pairs: $\mathfrak{so}(5)\oplus\mathfrak{so}(7)$ is one, at $r=31$ against $30$.*
**Verification and independent audit.** [p5_casimir_family.py](../scripts/lib/p5_casimir_family.py) reproduces $\theta_0(n)$ at $n=6,8,10,12,14$ and $0.836660$ at the $\mathfrak{su}(3)$ bi-invariant, and matches both closed forms against structure-constant sums measured by index projection, with unit norm, Ricci-flatness, $\mathrm{Alt}(W)=0$ and criticality residual all at $10^{-16}$. Reviewer 25 rebuilt the machinery from the definitions, confirmed the closed forms, the cap and the equality case, found no counterexample, and supplied the normaliser correction, the $0<r<N$ and $\mathfrak h\not\cong\mathfrak m$ hypotheses and the odd-$n$ strictness.
**What it does not reach.** On this family the graded-compression slack has the closed form $S=\tfrac{r}{nN}[4(N-r)-n^2]$, non-negative under the same condition, so the cap is that inequality restricted here, a sum-of-squares re-derivation and a cross-check rather than independent leverage. The family also has no near-extremal member other than the extremum: the ratios $\theta/\theta_0$ run $1.000$ at the balanced two-block products and then $0.845$, $0.730$, $0.671$, $0.655$ and below. Unbalanced products, $\mathbb{CP}^m$, $\mathbb{HP}^m$, the complex Grassmannians and every symmetry-free critical point lie outside it, and $W_{\mathbb{CP}^3}$ ties $\theta_0(6)$ at $n=6$ from outside, so uniqueness of the maximiser within the family is not uniqueness of the maximiser of $P$.

## Phase 2, the clustering

**Reports:** [VERIFY_v137](VERIFY_v137.md) `PROVEN, hypotheses corrected`, [VERIFY_v138](VERIFY_v138.md) `PROVEN, hypotheses corrected`, [VERIFY_v139](VERIFY_v139.md) `GAP`.

| # | clause attacked | mechanism | support |
|---|---|---|---|
| **C1** | the closed form | *no defect, and **forced***: a linear $2\times2$ solve whose determinant is nonzero for every $0<r<N$, so the formula is the unique solution rather than one among several. **Three verifiers computed that determinant independently** | v137, v138, v139 |
| **C2** | the constants' provenance | not convention-free: $\sigma=1+\kappa/2$ adds a $1$ from $W^2$ to a $\kappa/2$ from $\#$, so bracket and norm cannot be rescaled independently, and a general $\kappa$ gives the cap as $\kappa N/2(\kappa+2)$. **No copy of the statement says so** | v137, v139 |
| **C3** | $\theta\le\theta_0(n)$ | a **second** step, needing strict monotonicity of $r\mapsto rN/(N-r)$, used and never stated, and it is what makes the two equality cases coincide | v137, v138, v139 |
| **C4** | [results.md](../results.md):134 | **broken standalone**: it drops the eigen-equation, so it reads as a Lie-theoretic dimension bound the findings file explicitly withdraws. Witnesses: $\mathfrak{so}(5)\subset\mathfrak{so}(6)$ at $r=10$ against $6$, $\mathfrak u(3)$ at $9$ against $6$, $\mathfrak g_2\subset\mathfrak{so}(7)$ at $14$ against $35/4$ | v137, v138, v139 |
| **C5** | [Lemma L4](../findings/ungraded-slack.md)'s citation | advertises the closed form **with no criticality hypothesis**, at both its sites. At $\mathfrak{so}(5)\subset\mathfrak{so}(6)$, $P=\tfrac2{15}\sqrt{30}$ against the formula's $\tfrac13\sqrt{30}$, short by exactly two fifths | v137, v138 |
| **C6** | "**the** unit-norm multiple" | names **two** objects; at the negative one the multiplier is $-\theta$. The proof fixes $c>0$ in its first line and the statement never does, *and the notebook records a cycle lost to that flip* | v137, v138 |
| **C7** | the even-$n$ uniqueness | exact arithmetic exhausting over **Cartan's classification, which [references/](../references/) does not hold**. The $n=8$ half is secure by an inner-versus-outer determinant argument elsewhere, **not** by the dimension count the block gives, which the ledger certifies as insufficient at that very dimension | v137, v138, v139 |
| **C8** | attainment | that the family's maximum is the balanced sphere product's Weyl operator is an import, unargued here, as is $Q(\mathcal W_n)\subseteq\mathcal W_n$, which [Lemma L4](../findings/ungraded-slack.md)'s own round recorded as derived nowhere | v137, v139 |
| **C9** | the Berger paragraph | "exactly the Berger list" fails **in both directions**: $\mathfrak{sp}(m)$ is below the cap from $m=2$, and $\mathfrak{sp}(2)\subset\mathfrak{so}(8)$ is below it while carrying an invariant $4$-form. And "$m\le2$" is false distributively | v137, v138, v139 |
| **C10** | the graded pointer | *"in the sense settled elsewhere in this file"*, the senses are settled in a **different file** | v139 |
| **C11** | the Lean layer | **no row states L23**, and the row named as its extension evaluates $\theta^2$ at $r=7,8$ with $n=6$, **above the cap the derivation permits** | v138, v139 |
| **C12** | the block's shape | [ungraded-slack.md](../findings/ungraded-slack.md) carries **two full statements of this one theorem, forty lines apart**, a correction applied to one will not reach the other | v137 |

**Withdrawn with reasons:** the $4$-form exclusion claim (no failure exhibitable without computation), by one verifier who declined rather than guessed.

## Phase 3, adjudication

**The derivation is confirmed and it is forced.** All three rebuilt both trace equations and both Killing relations cold, and each computed the elimination's determinant independently. **This closes what [ROUND_L04](ROUND_L04b.md) left open**: the closed form L4 advertises is genuinely derived, here, and the earlier round's verifiers were right to rebuild it from this block.

**C4 and C5 are one failure at two addresses.** The theorem is conditional on criticality; **both places a consumer reads it drop that condition**, and each becomes false at a named subalgebra. *The block is right and neither citation of it is.*

**C6 is the third lemma tonight broken by the same structure**, a "the" in front of an object that comes in a $\pm$ pair, with the sign fixed inside the proof and nowhere in the statement.

**C7 is a debt, not an error.** The arithmetic is exact; the exhaustion is over a classification this record cannot check. **And the block's own warrant for the hard case is the wrong one**, the ledger says the dimension count is insufficient at exactly $n=8$ and supplies a different argument.

**Two things are handed on rather than folded in.** A verifier derived a *lower* bound $r\ge n/2$ with equality exactly at abelian $\mathfrak h$, **new mathematics, not a check**, so it goes to the queue for Gate 2 rather than into the block. And the out-of-range Lean evaluation is the lean loop's.

**No adjudication split, and no finding required computation.**

## Phase 4, the fix

**Verdict: `PROVEN, hypotheses corrected`. Impact: `PROPAGATES`**, the theorem and its proof stand; both citations of it were unconditional and are repaired, and one clause is booked as owed.

- **[results.md](../results.md):134 carries the eigen-equation**, with the witnesses that make the unconditional reading false and the note that the cap is not convention-free.
- **[Lemma L4](../findings/ungraded-slack.md)'s display carries the criticality hypothesis**, with the $\mathfrak{so}(5)\subset\mathfrak{so}(6)$ discrepancy written in.
- **The sign is fixed in the statement**, the monotonicity step named, and the forced elimination and its normalisations recorded in the proof.
- **The uniqueness clause is booked as owed**, naming Cartan's absence and the ledger's replacement argument for $n=8$.
- **The Berger paragraph is corrected in both directions**, and the graded pointer sent to the right file.
- **Two findings are queued**: the new lower bound, for the research loop; the out-of-range Lean row, for the lean loop.

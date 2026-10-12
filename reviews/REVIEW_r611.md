# Review r611, Conjecture L6 (the zero-defect set, and why it hides no rival)

Reviewer r611, independent adversarial audit. Target: `Conjecture L6` at [findings/curvature-invariants.md](../findings/curvature-invariants.md) lines 89–95, with its statement copy at [results.md](../results.md) lines 324–330 and its glance line at [results.md](../results.md) line 120. Worked from [findings/conventions.md](../findings/conventions.md) and the definitions; the record is not assumed correct. The concurrent reviewer on this brief (r612) was not read, nor their log.

Standing rule for this audit: **analysis only**. No sweep, census, optimisation or falsifier hunt was run. Two screens appear below, seconds of arithmetic on closed forms already on the record, run to check discrepancies I was about to record. They are reported as screens and never as evidence for a positive claim. Every positive claim below is a derivation or a citation of an existing record entry.

## Verdict

**The block is a mixture, and it grades three ways: one clause REFUTED, one clause CONFIRMED-but-weakened, one clause REFUTED AS ARGUED with the conclusion recoverable from a lemma already on the record.** Nothing in the block is a proof; the heading's *"canonical statement and proof"* promise fails, as it did at the sibling audited today.

| item | verdict |
| --- | --- |
| **D1** *"The defect vanishing is **exactly** the condition under which the diagonal argument transfers unchanged"* | **REFUTED**, by the record's own Gate 2 on [Observation L15](../results.md#L218): there is a **second** obstruction, $X_{\mathrm{inv}}\succeq0$. Zero defect is necessary, not sufficient. §2 |
| **D2** which defect the block means | **AMBIGUOUS, AND THE BLOCK'S POSITION PICKS THE WRONG ONE.** The block sits four lines under the definition of $\Delta$ (the Petersen–Wink *symmetry* defect) and says *"the defect"*; every quantity in it belongs to $\delta^2=\lVert\mathrm{Alt}(W_-)\rVert^2$ (the *Bianchi* defect of [Observation L15](../results.md#L622)). Under the reading its own position forces, the codimension claim is false. §1 |
| **D3** *"zero defect precisely on the diagonal orbit, is false"* | **CONFIRMED.** Proven on the record, not merely tested: [ATTEMPTS.md](../ATTEMPTS.md) Result 3 exhibits zero-defect non-diagonalisable critical points with non-diagonalisability *proved* (rank of $\mathrm{ad}_Z$). §3 |
| **D4** *"The set has codimension $\binom n4$"* | **CONFIRMED AS AN UPPER BOUND, unproven as an equality, and FALSE AS A UNIFORM STATEMENT.** $\mathrm{codim}\le\binom n4$ is free (§4). Equality is surjectivity of $dF$, on the record only numerically. The record's own caveat says the rank is point-dependent and **drops exactly on the diagonal locus**, the locus the sentence is comparing against. §4 |
| **D5** the hinge: *"reaching $\sqrt{3/2}$ would demand an isotropy algebra large enough to contain a unitary factor, which reintroduces the defect"* | **REFUTED**, twice over, with an infinite witness family and with a logical gap. §5, §6 |
| **D6** *"For the symmetric family this is proven"* | **NOT PROVEN BY THE ARGUMENT GIVEN, but the conclusion is recoverable** from [Lemma L47](../findings/graded-half.md), already on the record. What is owed is a citation swap, and it is reachable. §8 |
| **D7** *"For the symmetry-free remainder it is tested rather than proven"* | **HONEST AND CORRECT**, and it is the conjecture's actual content. The coverage is thinner than the sentence suggests: 17 seeds at $n=12$, 14 converging. §9 |
| **D8** the label `Conjecture` against the heading *"canonical statement and proof"* | **MISLABELLED HEADING.** Already flagged at [findings/LEDGER.md:1700](../findings/LEDGER.md) as one of three such blocks; nothing has been done to this one. §1 |
| **D9** the provenance note | **FALSE IN CLAUSE 1, TRUE AND HOLLOW IN CLAUSE 2.** [ATTEMPTS.md](../ATTEMPTS.md) held a **fuller** derivation at the move commit's parent, and so did [report/sections/90-appendix.tex](../report/sections/90-appendix.tex) and [reviews/REVIEW_r8.md](REVIEW_r8.md). §10 |
| **D10** the target constant $\Theta_n$ vs $\theta_0(n)$ | **NOT LOAD-BEARING HERE.** The block's threshold is the fixed $\sqrt{3/2}$, not the diagonal maximum. One consequence is recorded in §11 anyway. |

---

## 1. What the block actually says, and under which symbol

The whole block is six lines. Stripped to a proposition, and with the symbol ambiguity resolved the only way that makes the numbers true, it reads:

> **Proposition (L6, as stated).** Let $\mathcal A_n:=\{W\in\mathcal W_n:\mathrm{Alt}(W_-)=0\}$.
> (i) $\mathrm{Alt}(W_-)=0$ is necessary *and sufficient* for Jäger's §3.2 diagonal argument to transfer unchanged.
> (ii) $\mathcal A_n\ne O(n)\cdot\{\text{coordinate-diagonal}\}$.
> (iii) $\mathrm{codim}\,\mathcal A_n=\binom n4$.
> (iv) Every non-diagonalisable critical point in $\mathcal A_n$ has $\theta<\sqrt{3/2}$, **proven** for the "symmetric family" and **tested** for the rest.

**The symbol is wrong.** [conventions.md](../findings/conventions.md) tables two objects both called *the defect*:

- $\Delta$, *"the symmetry defect"*, sourced to [diagonal-half.md](../findings/diagonal-half.md);
- $\delta^2=\lVert\mathrm{Alt}(W_-)\rVert^2$, the Bianchi defect of [Observation L15](../results.md#L622).

The block is preceded, four lines above, by the display defining $\Delta(W):=\sum_{\delta\in\mathfrak p}g_\delta$ with $g_\delta=\lVert[\mathrm{ad}(v_\delta),W]\rVert^2$, and then opens with *"The defect vanishing…"*. A reader takes $\Delta$. **Every number in the block belongs to $\delta^2$**: the source ([ATTEMPTS.md](../ATTEMPTS.md), *"The Bianchi-defect set $\mathcal A_n$"*) solves $\mathrm{Alt}(W_-)=0$, and the report's copy of this very paragraph writes it out, [90-appendix.tex:83](../report/sections/90-appendix.tex) says *"The set $\{\delta^2=0\}$ has codimension $\binom n4$"*. The findings block lost the symbol in transcription.

This is not cosmetic. Under the $\Delta$ reading, $\Delta(W)=0$ forces $[\mathrm{ad}(v_\delta),W]=0$ for every $v_\delta$ spanning $\mathfrak p$, i.e. $\mathfrak p\subseteq\mathfrak k(W)$, every positive eigenbivector, read as an element of $\mathfrak{so}(n)$, lies in the isotropy algebra of $W$. For a Weyl tensor $\operatorname{tr}W=0$, so $\mathfrak p\ne0$, and the condition forces $\dim\mathfrak k(W)\ge\dim\mathfrak p\ge1$, which already excludes the generic $W$, whose stabiliser is trivial. That is not a codimension-$\binom n4$ condition; it is the subalgebra condition, and [ATTEMPTS.md](../ATTEMPTS.md) Result 6 records $17$ of $20$ unpenalised $n=6$ critical points having $\dim\mathrm{Stab}(W)=0$. **So under the reading the block's own placement forces, (iii) is false.**

**The heading.** `Conjecture` is the record's label for a candidate; *"canonical statement and proof"* claims what would make it a `Lemma`. [findings/LEDGER.md:1700](../findings/LEDGER.md) already names L6 as one of three blocks with this contradiction. The block contains no derivation of any of (i)–(iv).

## 2. (i), the word "exactly" is refuted by the record's own Gate 2

The claim is that zero defect is *exactly* the condition for the transfer. The record settles this against the block. [results.md:218](../results.md#L218), the glance entry for `Observation L15`:

> **the Bianchi defect of the spectral parts, and its price in Jäger's §3.2, TWO OBSTRUCTIONS, NOT ONE.** *This read "what stops the diagonal proof from lifting, identified exactly" and named one term.* **The second is $X_{\mathrm{inv}}\succeq0$**, free on the diagonal locus by the entrywise triangle inequality, a coordinate mechanism, not a Bianchi one, and refuted off it.

L6's clause (i) is the same sentence L15's audit refuted, one file over, and it still stands here. Zero defect is **necessary** for the transfer and not sufficient; the second obstruction is a coordinate mechanism that no defect condition sees. [findings/LEDGER.md:275](../findings/LEDGER.md) records what is owed on L15 (*"either a replacement for it off the diagonal locus or a proof that none exists"*) and L6 inherits that debt without acknowledging it.

*The checklist item "every hedging clause" pays again: "exactly" is the eighth-and-something, and it conceals the same missing half.*

## 3. (ii), confirmed, and stronger than the block says

The block calls this *"false"* of the hoped-for answer and leaves it there. It is settled affirmatively and by proof, in [ATTEMPTS.md](../ATTEMPTS.md) Result 3: if $K\subseteq SO(n)$ acts irreducibly with $(\Lambda^4)^K=0$ and $\dim\mathcal W_n^K=1$, the invariant $W$ is critical by equivariance and has zero defect because $\mathrm{Alt}(W_-)$ is a $\mathrm{Stab}(W)$-invariant $4$-form. Non-diagonalisability of the resulting points is **proved**, not measured: the positive eigenspace is $\{\mathrm{ad}_Z\}$, a coordinate-diagonal $W$ has every eigenspace spanned by decomposables, and $\mathrm{rank}\,\mathrm{ad}_Z\ge4$ for $Z\ne0$ once $\mathrm{rank}\,\mathfrak g\ge2$. The lone exception $\mathfrak{su}(2)$ is why $S^3\times S^3$ *is* diagonal, recovered as a control.

**So (ii) is a Lemma, and the block files it as part of a Conjecture.** The block also never states the invariant-$4$-form mechanism, which is the whole reason the family exists and the thing every later clause leans on.

## 4. (iii), the codimension, derived

**Step 1, the map.** Every $W\in\mathcal W_n$ satisfies the first Bianchi identity, so $\mathrm{Alt}(W)=0$ ([conventions.md](../findings/conventions.md): $\mathrm{Alt}$ is the orthogonal projection $S^2(\Lambda^2)\to\Lambda^4$, and $\mathrm{Alt}(H)=0$ for every $H$ satisfying first Bianchi). Writing $W=W_+-W_-$ with $W_\pm\succeq0$ orthogonally supported,
$$\mathrm{Alt}(W_+)-\mathrm{Alt}(W_-)=\mathrm{Alt}(W)=0\quad\Longrightarrow\quad \mathrm{Alt}(W_+)=\mathrm{Alt}(W_-)=\tfrac12\mathrm{Alt}(\lvert W\rvert).$$
So the defining map is
$$F:\mathcal W_n\longrightarrow\Lambda^4\mathbb R^n,\qquad F(W)=\mathrm{Alt}(W_-),$$
and $\mathcal A_n=F^{-1}(0)=\{W:\lvert W\rvert\text{ is Bianchi}\}$, the characterisation [ATTEMPTS.md](../ATTEMPTS.md) Result 2 states.

*(An aside the record should carry: this identity is why [results.md:218](../results.md#L218)'s remark "$\mathrm{Alt}(W_+)=\mathrm{Alt}(W_-)$, so naming only the negative part is a narrowing" is right, and it is one line.)*

**Step 2, the count.** $\dim\Lambda^4\mathbb R^n=\binom n4$, so the vanishing of $F$ is at most $\binom n4$ scalar conditions and
$$\boxed{\ \mathrm{codim}\,\mathcal A_n\ \le\ \binom n4\ }$$
holds everywhere, with **no computation at all**. The $\binom n4$ is therefore *the dimension of the target*, not a count of independent conditions established independently. Equality at a point $W$ is exactly **surjectivity of $dF_W$**, and that is the content the record actually needs.

**Step 3, what the record has for equality.** Only numerics. [reviews/REVIEW_r8.md:13](REVIEW_r8.md) reports $\mathrm{rank}\,dF=15,35,70$ at $n=6,7,8$ by central differences, matching $\binom n4$; [ATTEMPTS.md](../ATTEMPTS.md) Result 2 tabulates $\dim\mathcal A_n=69,230,\sim\!1143$ at $n=6,8,12$.

*Screen (arithmetic on the record's own closed forms, seconds, reported as a screen).* $\dim\mathcal W_n=\frac{n(n-3)(n+1)(n+2)}{12}$ gives $84,168,300,1638$ at $n=6,7,8,12$; $\binom n4$ gives $15,35,70,495$; the differences are $69,133,230,1143$. The table's $n=6,8,12$ rows reproduce exactly. **This screens the arithmetic and is not evidence that the rank is full.**

**Step 4, and this is the defect in the statement.** The equality is *not uniform*, and the record says so, in the paragraph the block did not carry across. [ATTEMPTS.md](../ATTEMPTS.md), *"Caveat on the dimension estimate"*:

> the local dimension of $\mathcal A_n$ [is] point-dependent rather than a single clean number: rank $\binom n4$ at symmetric minimization outputs, but rank $6,10,15$ at low-symmetry rotated sphere products. […] The codimension-$\binom n4$ figure in Result 2 should therefore be read as the *generic* value, not a uniform one.

and Result 2 itself: *"at sphere products the rank drops to exactly $\binom p2\binom q2$ […] so **the diagonal locus sits at singular points of $\mathcal A_n$**"*.

**The sentence being compared is "codimension $\binom n4$, far larger than the orbit", and the orbit is precisely where the codimension is not $\binom n4$.** The block states a generic figure flat, at a locus where the record's own measurement says it fails. The direction of the failure happens to strengthen the qualitative point, smaller rank means $\mathcal A_n$ is locally *bigger* near the diagonal locus, so it exceeds the orbit in every neighbourhood of the conjectured maximiser, as Result 2 also records, but the stated number is wrong as written, and a reader who takes it uniformly will get the geometry near the maximiser wrong.

**Step 5, a hypothesis nobody states.** $F$ is not differentiable where $W$ has a zero eigenvalue, since $\lvert\cdot\rvert$ is not; [conventions.md](../findings/conventions.md) already flags $\Delta$ as *"discontinuous at eigenvalue zero-crossings"* and the same applies to $\delta^2$'s smoothness. Every rank computation therefore presumes $\ker W=0$. **The record's zero-defect examples are largely padded tensors, which have kernel by construction**, the padded $SU(3)$ tensor at $n=12$ is the block's own headline example. The codimension claim, as a claim about $\mathcal A_{12}$ near that point, is stated where its own differential does not exist.

**Verdict on (iii):** the inequality is free and correct; the equality is an **Observation at $n=6,7,8$ (and $12$ by dimension count)** and is stated as a theorem; and it is false as a uniform statement, by the record's own caveat, exactly on the locus the sentence compares to.

## 5. (iv), the hinge, REFUTED, with an infinite family of witnesses

This is the load-bearing sentence and it is the one to kill. Unpacked from [ATTEMPTS.md](../ATTEMPTS.md)'s *"Why $0.837$ is a genuine ceiling"* and [REVIEW_r8.md:15](REVIEW_r8.md), the argument is three steps:

1. **Inversion.** $\theta\ge\sqrt{3/2}$ forces $\dim\mathfrak h\ge\frac{3n}{7n-4}\binom n2=\frac{3n^2(n-1)}{2(7n-4)}$. *This step is sound*, it is the contrapositive of the **Dimension Lemma**, [graded-half.md:108](../findings/graded-half.md), which is proved there by Cauchy–Schwarz with the isotropy-block multiplicities as weights, and is [Lemma L47](../findings/problem.md).
2. **Enumeration.** *"the only subalgebras of $\mathfrak{so}(n)$ that large are $\mathfrak{so}(n)$ itself and $\mathfrak u(n/2)$."*
3. **Conclusion.** A $\mathfrak u$ factor carries the invariant $4$-form $\omega\wedge\omega$, hence nonzero defect.

**Step 2 is false, and its sharpest counterexample is the conjectured maximiser itself.** The isotropy of the balanced sphere product is $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)\subset\mathfrak{so}(n)$, of dimension $\frac{n(n-2)}4$, and
$$\frac{n(n-2)}4>\frac{3n^2(n-1)}{2(7n-4)}\iff n(n^2-12n+8)>0\iff n\ge12,$$
the record's own polynomial in its fourth appearance ([graded-half.md:150](../findings/graded-half.md)). $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ contains **no unitary factor**, admits no invariant $4$-form under the full normaliser, and sphere products are **provably defect-free at every dimension and every split**, the projection onto $\mathfrak m$ is a sum over decomposable bivectors whose $4$-form parts vanish ([graded-half.md:427](../findings/graded-half.md)).

And it is not one point. Sphere products exceed $\sqrt{3/2}$ **exactly when $p,q\ge5$** ([graded-half.md:427](../findings/graded-half.md), reducing to the same $n^2-7n-54\ge0$), so $\{\mathfrak{so}(p)\oplus\mathfrak{so}(q):p,q\ge5\}$ is an infinite family of large isotropy algebras with $\theta>\sqrt{3/2}$, no unitary factor and zero defect.

*Screen (arithmetic, seconds).* Threshold $\frac{3n^2(n-1)}{2(7n-4)}$ against $\frac{n(n-2)}4$: $12.92$ vs $12.0$ at $n=8$; $20.46$ vs $20.0$ at $n=10$; $24.86$ vs $24.75$ at $n=11$; $29.70$ vs $30.0$ at $n=12$; $53.33$ vs $56.0$ at $n=16$; $83.82$ vs $90.0$ at $n=20$. The crossing is at $n=12$ and the excess grows. $\theta_0(n)^2=2(n-1)(n-2)/n^2$ is $1.5278$ at $n=12$ against $3/2$. **Reported as a screen; the derivation above is the evidence.**

**The record already knows this, in three places, and the correction never reached the block.**

- [report/sections/90-appendix.tex:47](../report/sections/90-appendix.tex): *"The structural argument that stood here, that a subalgebra beyond $0.44\binom n2$ forces a unitary factor, reintroducing the invariant $4$-form and destroying the hypothesis, **fails at the balanced split itself**, which exceeds that threshold with no unitary factor. Large isotropy does make $P$ large; it does not disqualify the maximiser."*
- [reviews/REVIEW_r583.md:120](REVIEW_r583.md), same witness, same arithmetic.
- [findings/LEDGER.md:1654](../findings/LEDGER.md), recording the repair.

The report section was corrected. [findings/curvature-invariants.md:95](../findings/curvature-invariants.md) and [results.md:120](../results.md#L120) were not. **A refutation that landed in the report and never crossed back into the findings file it came from**, the same failure mode as the stale pointers of [LEDGER.md:1680](../findings/LEDGER.md), and invisible for the same reason: no gate compares a findings block against the report paragraph derived from it.

**Two further counterexamples to step 2**, both already on the record and both simple algebras with no unitary factor:

- $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)\subset\mathfrak{so}(8)$, the isotropy of $\mathbb{HP}^2$: $\dim=13$ against the $n=8$ threshold $12.923$ ([graded-half.md:150](../findings/graded-half.md), *"REFUTATION, same line"*).
- $\mathfrak{spin}(9)\subset\mathfrak{so}(16)$, isotropy of the Cayley plane, whose value $0.896421$ refutes the *other* leg, the $0.8367$ ceiling ([90-appendix.tex:47](../report/sections/90-appendix.tex)). *(It sits at $\dim36$ below the $n=16$ threshold $53.33$, so it refutes the ceiling and not the enumeration; recorded here so the two are not conflated.)*

## 6. The hinge fails a second time, independently: step 3 is a converse

Even granting step 2, step 3 does not follow. The mechanism on the record is [ATTEMPTS.md](../ATTEMPTS.md) Result 1(c):
$$(\Lambda^4\mathbb R^n)^{\mathrm{Stab}(W)}=0\ \Longrightarrow\ \mathrm{Alt}(W_-)=0,$$
because $\mathrm{Alt}(W_-)$ *is* a $\mathrm{Stab}(W)$-invariant $4$-form. Its contrapositive is *defect $\ne0\Rightarrow$ invariant $4$-form exists*. **The block needs the converse** (*invariant $4$-form exists $\Rightarrow$ defect $\ne0$*) which is a non sequitur: an invariant $4$-form makes zero defect non-automatic, it does not make it impossible.

The record refutes the converse outright. [ATTEMPTS.md](../ATTEMPTS.md) Result 6, point 2:

> **The $(\Lambda^4)^{\mathrm{Stab}(W)}=0$ mechanism of Result 1(c) is sufficient but far from necessary.** The zero-defect critical set is not "the symmetric family plus the diagonal orbit"; it has a generic, symmetry-free component too.

Those witnesses have $\mathrm{Stab}(W)=0$, so $(\Lambda^4)^{\mathrm{Stab}}=\Lambda^4\ne0$ in the largest possible way, and defect $\sim4\times10^{-32}$ at full residual $10^{-16}$. **The implication the hinge rests on is contradicted by the same document's next result.** The two computed instances the record does have ($\mathcal S^4(\alpha)$ at $24\delta^2=8/3$ and $W_{\mathbb{CP}^2}$ at $\delta^2=1/9$), are computations at two points, never a theorem, and they are what *"which reintroduces the defect"* is standing on.

**And "unitary factor" is the wrong name even where the conclusion holds.** $\mathfrak{spin}(7)\subset\mathfrak{so}(8)$ acting irreducibly on the $8$-dimensional spin representation has $\dim=21$, above the $n=8$ threshold $12.923$, is simple, and is not contained in $\mathfrak u(4)$ ($\dim16<21$). It does carry an invariant $4$-form (the **Cayley form**) which arrives from a $\mathrm{Spin}(7)$ structure and not from any $\omega\wedge\omega$. So the mechanism the block names is one instance of a phenomenon it mistakes for the whole.

## 7. Cartan, $SO(n)$-conjugacy, and $n=8$

**The argument does run through Cartan's list**, at step 2 in two places: the enumeration *"the compact symmetric spaces with $b_4=0$ are exactly the group manifolds, $SU(k)/SO(k)$, $SU(2k)/Sp(k)$, $E_6/F_4$ and spheres"*, and the enumeration of large subalgebras of $\mathfrak{so}(n)$. [conventions.md](../findings/conventions.md) flags the trap: Cartan's classification is up to $\mathrm{Aut}(\mathfrak g)$, the argument consumes **$SO(n)$-conjugacy**, and the two differ at $n=8$ by triality. The record cites Cartan to **no source anywhere**, [references/](../references/) holds no Helgason or Cartan entry.

**It consumes $SO(n)$-conjugacy.** "Which subalgebras of $\mathfrak{so}(n)$ exceed $\dim\mathfrak h\ge\frac{3n}{7n-4}\binom n2$, and do they contain a unitary factor" is a question about embedded subalgebras of $\mathfrak{so}(n)$ and their action on $\mathbb R^n$; conjugating by an outer automorphism changes the embedding and hence the answer to *"does it fix a $4$-form"*.

**$n=8$ is affected, concretely.** $\mathfrak{spin}(7)\subset\mathfrak{so}(8)$ has **three** $SO(8)$-conjugacy classes (vector, and the two spinor embeddings), fused into one by triality; an enumeration read off a list classified up to $\mathrm{Aut}$ sees one class where the argument needs three. And $n=8$ is exactly where the two independent counterexamples to the enumeration live ($\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$ at $\dim13$ against a threshold of $12.923$, a margin of $0.08$, well inside the range where a fused conjugacy class changes the census).

Since step 2 is already refuted in §5, this does not add a fourth refutation; it explains why the enumeration was never safe to state, and it means **any repair of step 2 must be done over $SO(n)$-conjugacy classes with $n=8$ treated separately.**

## 8. What actually covers the symmetric family, the repair, and it is reachable

The hinge is broken. The **conclusion** it was defending is not, for most of the family, and the repair is a citation swap rather than new mathematics.

**(a) The bi-invariant compact simple Lie groups are closed by a closed form and monotonicity, with no isotropy argument at all.** [graded-half.md](../findings/graded-half.md), Class 3.1 Type II: the adjoint representation has $c_{\rm hol}=2$ for every $\mathfrak g$, so
$$\theta^2=\frac{4(n-1)}{n(n-3)},\qquad n=\dim\mathfrak g,$$
strictly decreasing. The non-diagonal members start at $n=\dim\mathfrak{su}(3)=8$, $\mathfrak{su}(2)$ at $n=3$ and $\mathfrak{so}(4)=\mathfrak{su}(2)^2$ at $n=6$ being the diagonal exceptions, giving a maximum of $\theta=0.836660$ against $\sqrt{3/2}=1.224745$. *Screen: $1.054093,0.836660,0.717137,0.581087,0.557773$ at $n=6,8,10,14,15$, matching the record's tabulated $P$ values.* This leg is a proof and does not use the unitary-factor claim.

**(b) The symmetric members are closed by [Lemma L47](../findings/problem.md), already proved.** [graded-half.md:112](../findings/graded-half.md):

> **Theorem.** On every compact irreducible symmetric space, $\lVert W\rVert^2\ge\tfrac16$, with equality exactly at $\mathbb{CP}^2$. Equivalently $\theta\le\sqrt{3/2}$, attained only there.

Every member of the block's "symmetric family" that is a compact irreducible symmetric space (the group manifolds, $SU(k)/SO(k)$, $SU(2k)/Sp(k)$, $E_6/F_4$), falls under it. The unique equality case $\mathbb{CP}^2$ has $b_4\ne0$ and defect exactly $1/9$, so it is outside the zero-defect set, and **the inequality is strict on the family**. That is the whole of (iv)'s "proven" clause, obtained from a theorem the record already holds, with the Dimension Lemma used *as a lemma* rather than inverted into a false enumeration.

**So D6's verdict: the argument in the block is refuted; the conclusion survives via L47, and what is owed is two sentences replacing the hinge with a citation.**

**(c) The residual gap, and it should be stated as the conjecture's content.** [ATTEMPTS.md](../ATTEMPTS.md) Result 3 defines the family **algebraically**: $K\subseteq SO(n)$ acting irreducibly with $(\Lambda^4)^K=0$ and $\dim\mathcal W_n^K=1$. Its *realisations* are named as bi-invariant Lie groups and isotropy-irreducible symmetric spaces, but the hypothesis does not say "symmetric". Strongly isotropy irreducible **non-symmetric** homogeneous spaces satisfy it too, and for those the curvature is not $-\mathrm{ad}\circ\mathrm{ad}$, so L47's proof, whose step 1 uses $\operatorname{tr}R=n/4$ and eigenvalues supported on $\dim\mathfrak h$ directions of $\Lambda^2$, both symmetric-space facts, does not reach them. **Neither (a) nor (b) covers that part of the family, and the block's "proven" covers it only by an enumeration that assumes symmetry.** This is a genuine gap, it is narrow, and closing it is a classification question (Wolf's list) rather than a run.

## 9. Beyond the symmetric family, what covers the rest, and the honest answer

Nothing does, and the block says so: *"For the symmetry-free remainder it is tested rather than proven."* That clause is correct and is the only place the block's own label is accurate. Two qualifications the block omits and a reader needs:

- **The remainder is the bulk of the set.** $\mathcal A_n$ has dimension $\sim n^4/24$ against the orbit's $\sim n^2$, and [ATTEMPTS.md](../ATTEMPTS.md) Result 6 found the zero-defect critical set to be *"exponentially large, and mostly symmetry-free"*, $17$ distinct critical values from $20$ restarts at $n=6$, every one with $\dim\mathrm{Stab}(W)=0$. So the "proven" clause covers a measure-zero, highly non-generic slice of what the conjecture is about.
- **The coverage behind "at $n=12$ produced no non-diagonalizable zero-defect critical point at all" is thinner than the sentence reads.** [ATTEMPTS.md](../ATTEMPTS.md), *"Coverage caveat, stated plainly"*: **$n=12$ carried only $17$ seeds, $14$ converging**, each costing $\approx9.5$ s. The source's own closing words are *"Nothing here is a proof."* The block reports the null result and drops the seed count.

**So the conjecture's actual content, stated honestly, is:** *every critical point with $\theta\ge\sqrt{3/2}$ and $\mathrm{Alt}(W_-)=0$ is coordinate-diagonalisable*, which is the form [ATTEMPTS.md](../ATTEMPTS.md) Result 4 already identified as the salvageable target and the form Jäger's §3.2 needs. The block never states it. **That sentence should be the block, and the two paragraphs currently there are its provenance.**

## 10. The provenance note, checked against `git`

The note reads: *"Moved here from [results.md](../results.md) on 2026-08-31, where the argument was the only copy. That file now carries the statement and points here."*

Checked by distinctive-phrase grep at the move commit and its parent, `a9e4b8c0`, *"refactor(results): the proofs move to findings, results.md states and points"*.

**Clause 1, FALSE.** `git grep "hoped-for clean answer" a9e4b8c0^` and `git grep 'binom n4' a9e4b8c0^` return, at the parent:

| file at `a9e4b8c0^` | what it held |
| --- | --- |
| [ATTEMPTS.md](../ATTEMPTS.md) lines 706, 729, 739 | the **entire derivation**, the $\mathcal A_n$ characterisation, the rank table, Result 4, and the codimension caveat. Strictly fuller than what moved |
| [report/sections/90-appendix.tex](../report/sections/90-appendix.tex) line 83 | the *"sits low"* paragraph, in the correct symbol $\{\delta^2=0\}$ |
| [reviews/REVIEW_r8.md](REVIEW_r8.md) line 13 | the rank verification $15,35,70$ |
| [results.md](../results.md) lines 140, 250, 252 | the glance line and both paragraphs |

`results.md` was one of four copies and the thinnest of them. **Five of these notes have now been audited on this record and five are false in clause 1.** The reason is on the record and it is not five separate errors: [findings/LEDGER.md:1674](../findings/LEDGER.md), *"the sentence is a boilerplate stamp applied to $42$ blocks in one commit […] It was never $42$ claims about $42$ histories."*

**Clause 2, TRUE, and hollow.** [results.md:326](../results.md#L326) does carry a statement and [results.md:330](../results.md#L330) does point here. But what it carries is **paragraph 1 verbatim, byte for byte**, so the findings block's entire contribution over `results.md` is paragraph 2, the four sentences §5–§8 refute or qualify. It is the L13 pattern in a milder form: not byte-identical, but the added text is an assertion of results rather than a derivation of them, and the derivation is in [ATTEMPTS.md](../ATTEMPTS.md), **which the record bars from carrying a numbered result's proof**. As at L13, the repair is transcription, and it is owed.

**Pointers.** All resolve: [INDEX-results.md](../findings/INDEX-results.md) row 6, [results.md:330](../results.md#L330)'s `Proof:` and the block's own link to [results.md](../results.md) all land on the right files, [LEDGER.md:1680](../findings/LEDGER.md) records L6's pointer as having been *"wrong in both index and canon"* and repaired, and the repair holds. The block cites **no** script for the $n=12$ searches its last clause rests on; the relevant one is [scripts/lib/run_bianchi_defect.py](../scripts/lib/run_bianchi_defect.py), reachable only through [ATTEMPTS.md](../ATTEMPTS.md).

## 11. The target constant

Nothing here turns on $\Theta_n$. The block's threshold is the **fixed** $\sqrt{3/2}$, the $\mathbb{CP}^2$-type rival's value, and $\sqrt{3/2}$ is correct for that object; the diagonal maximum $\Theta_n$ never enters. One consequence of the distinction is worth recording anyway, since the block states **no dimension hypothesis at all**:

- The zero-defect set contains the balanced sphere product itself, at $\theta_0(n)$. For $n\ge12$ that is **above** $\sqrt{3/2}$ ($\theta_0(12)^2=55/36$ against $54/36$), so *"all of them sit low"* is literally false unless "them" is read as *the non-diagonalisable members*, which is the charitable reading and the intended one, but the block's antecedent is two sentences away and the sentence does not restrict itself.
- Using $\Theta_n$ rather than $\theta_0(n)$ changes nothing: $\Theta_n>\sqrt{3/2}$ for every even $n\ge12$ and, at odd $n$, from $n=13$ on ($\Theta_{13}^2=2\cdot12\cdot10/(14\cdot11)=240/154=1.558$).

## 12. What is owed, and whether it is reachable

| owed | reachable |
| --- | --- |
| **Say which defect.** Replace *"the defect"* with $\delta^2=\lVert\mathrm{Alt}(W_-)\rVert^2$, or move the block away from $\Delta$'s definition | one word; do it first, it is what makes the rest readable |
| **Drop "exactly" from clause (i)**, or name the second obstruction $X_{\mathrm{inv}}\succeq0$ | one clause, from [results.md:218](../results.md#L218) |
| **Qualify the codimension as generic**, with the sphere-product rank drop, and state $\mathrm{codim}\le\binom n4$ as the free part | §4 supplies the derivation; the caveat is a quote from [ATTEMPTS.md](../ATTEMPTS.md) |
| **Delete the unitary-factor hinge** and cite [Lemma L47](../findings/problem.md) plus the Lie-group closed form in its place | §8; both are proved on the record already |
| **State the conjecture as [ATTEMPTS.md](../ATTEMPTS.md) Result 4 does** (*every critical point with $\theta\ge\sqrt{3/2}$ and zero defect is coordinate-diagonalisable*) and label the block `Conjecture` with a heading that does not promise a proof | free |
| **Transcribe the derivation** out of [ATTEMPTS.md](../ATTEMPTS.md), which the record bars from holding it | a page; the same debt L13 carries |
| **Carry the $n=12$ seed count** ($17$ seeds, $14$ converging) into the tested clause | free |
| **Decide the non-symmetric isotropy-irreducible members** of Result 3's family, which neither leg of §8 reaches | a classification question over Wolf's list, **analysis, not a run**, and the one item here that is new mathematics |
| **Re-run the enumeration over $SO(n)$-conjugacy** if step 2 is ever repaired rather than deleted, with $n=8$ separate | only if someone wants the hinge back; §8 makes it unnecessary |

**Nothing on this record cites L6**, so the impact of every finding above is confined to the block, its `results.md` copy at line 120 and line 324, and [90-appendix.tex:83](../report/sections/90-appendix.tex), which carries the same refuted hinge two paragraphs after [90-appendix.tex:47](../report/sections/90-appendix.tex) records that it fails.

---

*Analysis only. Two screens, both arithmetic on closed forms already on the record, both reported as screens. No sweep, census, optimisation or falsifier hunt was run, and no positive claim above rests on one.*

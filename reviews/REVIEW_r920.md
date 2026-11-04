# Review r920, Lemma L211, does a compact Einstein symmetric space with $W\ne0$ have $\lambda>0$?

This round read one written derivation link by link and asked of each step whether it follows from the step above it and from the hypotheses actually stated. Read: the L211 and L210 blocks at [findings/problem.md:241](../findings/problem.md#L241) and [findings/problem.md:259](../findings/problem.md#L259), the record's transcription at [references/gorodski-symmetric-spaces-intro/notes.md](../references/gorodski-symmetric-spaces-intro/notes.md), the source extraction [gorodski-symmetric-spaces.txt](https://www.ime.usp.br/~gorodski/ps/symmetric-spaces.pdf) at its Corollary 2.4.7 (line 1624), its section 5.5 and Corollary 5.5.2 (line 3172) and its type definition (line 1194), the Theorem at [results.md:643](../results.md#L643), the L47 and L48 blocks, and [verification/VERIFY_v193.md:181](../verification/VERIFY_v193.md#L181). Analysis only, no computation of any kind. Log: [agent_logs/gate2-l211-r920.log](../agent_logs/gate2-l211-r920.log).

| # | Item | Verdict | Reason |
| --- | --- | --- | --- |
| 1 | Step 1, $\lambda\ne0$ | GAP | true, and Cartan--Ambrose--Hicks is the wrong instrument for it, the work being done by the OIL decomposition plus definite Ricci on an irreducible factor |
| 2 | Step 2 normalisation, $\lambda_i$ against the Einstein constant | CONFIRMED | the two constants are kept apart throughout, $\mathop{\mathrm{sign}}K=-\mathop{\mathrm{sign}}\lambda_i$ is right, and the type equivalence follows from $B$ being an inner product |
| 3 | Step 2's tracing clause and strictness | CONFIRMED | the contradiction needs only $\mathop{\mathrm{Ric}}\ge0$ against a strictly negative $\lambda$, and strictness is available in any case |
| 4 | Step 3, definiteness across factors and semisimplicity | GAP | $\beta|_{\mathfrak p}$ positive definite is true and load-bearing for step 4, resting on two inputs the block leaves unwritten, and semisimplicity needs a fifth citation, Corollary 2.1.5 |
| 5 | Step 4, the load-bearing step | CONFIRMED | step 3 establishes exactly Corollary 2.4.7's hypothesis, 2.4.7 is stated about the transvection group, and the bundle argument is valid for a Lie group over a compact base |
| 6 | Group against algebra compactness | CONFIRMED | the source DEFINES a compact Lie algebra as the algebra of some compact Lie group, so $G$ compact gives $\mathfrak g$ compact outright, and centres and coverings cannot reach an existential definition |
| 7 | The hyperbolic witness | REFUTED | a closed hyperbolic manifold has constant curvature, hence $W=0$, which the record's own L48 clause states, so the named witness fails the clause it was named for |
| 8 | Hypothesis inventory | CONFIRMED | compactness and global symmetry do enter only at step 4, $W\ne0$ only at step 1, and $\dim M>0$ is used at step 3 without appearing in the statement |
| 9 | The reach | GAP | the Theorem quantifies over "symmetric" while L211 needs GLOBALLY symmetric, and compactness of the factors is derivable from inputs in hand yet nowhere written |
| 10 | Already on the record? | CONFIRMED as new | the conclusion is asserted at [VERIFY_v193.md:181](../verification/VERIFY_v193.md#L181) with a FALSE reason, "compactness gives $\mathop{\mathrm{Ric}}\ge0$", so L211 supersedes rather than duplicates |
| 11 | What would break it | NO FALSIFIER | a compact globally symmetric Einstein space of noncompact type, blocked structurally by 2.4.6's $G\cong K\times\mathbb R^n$, and four evasion routes checked and closed |

**Summary.** The conclusion $\lambda>0$ is TRUE and the spine, steps 2 to 5, is sound, and what the block owes is step 1's instrument, two unwritten inputs behind step 3's definiteness clause, an accurate account of where its four inputs actually live, and a replacement for a tightness witness that is false.

## 1. Step 1, $\lambda\ne0$

**GAP.** The conclusion is true and the named instrument does not deliver it. What step 1 needs is the pointwise algebraic statement $\mathop{\mathrm{Ric}}=0\Rightarrow R=0$ at a point, from which $W=0$ is immediate. Cartan--Ambrose--Hicks is a rigidity theorem about local isometry between two spaces with matching curvature under parallel transport, so its output is *this space is locally isometric to Euclidean space*, which is both more than is needed and dependent on completeness that the step never invokes.

The argument that does the work is already inside the source on file. Proposition 2.1.3 splits the OIL-algebra with no hypothesis on $\lambda$ at all. On an irreducible factor, Corollary 3.1.4 with Lemma 2.1.2(b) gives $\mathop{\mathrm{Ric}}(X,X)=\lambda_i\sum_j\beta([X,e_j],[X,e_j])$ of one sign, and it vanishes only when $[X,\mathfrak p_i]=0$. That set is $\mathrm{ad}_{\mathfrak k}$-invariant, by the Jacobi identity, so irreducibility of the isotropy representation makes it $0$ or $\mathfrak p_i$, and $\mathfrak p_i$ would make the factor Euclidean, which irreducible excludes. So Ricci is DEFINITE on every irreducible factor, $\mathop{\mathrm{Ric}}=0$ leaves only $\mathfrak g_0$, and $[\mathfrak p,\mathfrak p]=0$ with Proposition 3.1.2 gives $R=0$. That route needs no topology and no theorem off the record.

The block cites the parenthetical at [findings/problem.md:584](../findings/problem.md#L584), which says the same thing with the same misnaming, "flat by Cartan--Ambrose--Hicks with de Rham", so the citation is faithful to the record and the record is where the defect sits. Cartan--Ambrose--Hicks appears in no reference folder, so this is the block's only step reaching outside its sources.

**A strictly stronger statement is available for free.** For a locally symmetric space $W\ne0$ implies $\lambda\ne0$, by exactly this step, so stating L211 with $\lambda\ne0$ in place of $W\ne0$ would weaken the hypothesis, strengthen the lemma, and remove the dependence on step 1 entirely.

## 2. The normalisation in step 2

**CONFIRMED, no finding.** I checked every occurrence of the two constants. The block writes $\lambda_i$ for Corollary 3.1.4's scaling in $B=\lambda_i\beta|_{\mathfrak p}$ and $\lambda$ for the Einstein constant, and it never substitutes one for the other. The only place they meet is the inference *the sign of $\lambda_i$ fixes the sign of $K$, and tracing carries that to $\lambda$*, which relates them without identifying them. The source's own Corollary 3.1.4 uses the letter $\lambda$ for the scaling, so renaming it $\lambda_i$ in the block is the right defensive move and it was made.

$\mathop{\mathrm{sign}}K=-\mathop{\mathrm{sign}}\lambda_i$ holds: $X,Y\in\mathfrak p$ gives $[X,Y]\in\mathfrak k$ by the $\pm1$ eigenspace grading, Lemma 2.1.2(b) makes $\beta([X,Y],[X,Y])\le0$, and $K=\lambda_i\beta([X,Y],[X,Y])$ then has the sign opposite to $\lambda_i$ wherever the bracket is nonzero.

The type equivalence holds and it turns on the clause the transcription flags as load-bearing. $B$ is an INNER PRODUCT, so positive definite, and $B=\lambda_i\beta|_{\mathfrak p}$ with $\lambda_i\ne0$ makes $\beta|_{\mathfrak p}=\lambda_i^{-1}B$ definite, negative exactly when $\lambda_i<0$. The source's definition at line 1194 of the extraction is *compact type when the Killing form is negative definite on the $-1$-eigenspace*, so $\lambda_i<0$ is compact type and $\lambda_i>0$ is noncompact type, as written. Both readings of a possible sign slip were tested against the source and neither appears.

## 3. The tracing clause and strictness

**CONFIRMED, no finding, and the strictness worry does not bite.** The clause "the sign of the Einstein constant follows by tracing" is loose if read as a two-way strict statement, and the direction the proof consumes is the non-strict one: compact type gives $K\ge0$ on every 2-plane of the factor, hence $\mathop{\mathrm{Ric}}_i\ge0$, hence $\lambda\ge0$ by L210's shared constant, which already contradicts a strictly negative $\lambda$. Step 5 uses the mirror direction the same way, noncompact type giving $\lambda\le0$ against $\lambda>0$. So the block never needs strict positivity, and the loose phrasing costs it nothing.

Strictness is nevertheless available, by §1's invariant-subspace argument, which makes Ricci definite rather than semidefinite on every irreducible factor.

**A flat irreducible factor is impossible twice over**, and the block should say which reason it is spending. Gorodski's *irreducible* is defined as *not Euclidean and the isotropy representation irreducible*, so an irreducible factor has $[\mathfrak p_i,\mathfrak p_i]\ne0$ by definition, and Corollary 3.1.4's $\lambda_i\ne0$ says the same again. L210's removal of the Euclidean factor is a separate job: it removes $\mathfrak g_0$, where flat DIRECTIONS live, and the two together leave a decomposition whose every factor has definite curvature.

## 4. Step 3, definiteness across the factors and semisimplicity

**GAP, in the definiteness clause, and it is load-bearing rather than decorative.** The block writes "every factor is of noncompact type, so $\beta$ is positive definite on $\mathfrak p$" with no intervening reason, and this clause is what makes $M$ a space of NONCOMPACT TYPE in the source's sense, which is the hypothesis step 4's Corollary 2.4.7 demands. Two inputs stand behind it and neither is on the page.

- **The Killing form restricts.** For a direct sum of ideals, $\beta_{\mathfrak g}|_{\mathfrak g_i}=\beta_{\mathfrak g_i}$, which is what lets a per-factor type statement be read off the ambient $\beta$. This identity appears nowhere in the record.
- **The $\mathfrak p_i$ are mutually $\beta$-orthogonal**, so positive definiteness on each summand adds up to positive definiteness on $\mathfrak p$. This is derivable from what the transcription already carries: 2.1.3's proof builds the $\mathfrak p_i$ $B$-orthogonal from eigenspaces of $A$ defined by $B(AX,Y)=\beta(X,Y)$, with $A$ scalar on each, so $\beta(X,Y)=B(AX,Y)=\lambda_i'B(X,Y)=0$ across factors. The L210 block states the $B$-orthogonality at [findings/problem.md:278](../findings/problem.md#L278) and L211 does not carry it across.

**Semisimplicity is sound and its citation is missing.** "By L210 there is no Euclidean factor, so $\mathfrak g$ is semisimple" is exactly the third sentence of Corollary 2.1.5, *$\mathfrak g$ is semisimple if and only if $(\mathfrak g,s,B)$ has no Euclidean factor*, which the transcription carries. The block's own inventory says "the inputs, all four", so 2.1.5 is a fifth input used and uncredited. The previous round's worry, that $\mathfrak p_0=0$ reaches $\mathfrak g_0=0$ only through the effectiveness clause, is discharged upstream rather than here: L210 step 3 spends that clause and its statement delivers *no Euclidean factor* as a conclusion, so L211 is entitled to it as a given.

The remaining pieces of step 3 are clean. $\mathfrak p\ne0$ from $\dim M>0$ is right, $\mathfrak p\cong T_xM$. And "$\beta$ is not negative definite on $\mathfrak g$" needs only one vector of positive $\beta$, which any single noncompact-type factor supplies, so that sub-inference would survive even if the across-factors clause were weakened.

## 5. Step 4, the load-bearing step

**CONFIRMED, no finding, and the brief's suspicion about 2.4.7 resolves in the block's favour.** The worry is that 2.4.7 is stated for a space of noncompact type while step 4 sits inside a proof by contradiction assuming that. This is legitimate use rather than circularity. The source's type is a property of the OIL-algebra, positive definiteness of $\beta$ on $\mathfrak p$, which step 3 establishes as a CONSEQUENCE of $\lambda<0$, so within the branch $M$ genuinely IS a symmetric space of noncompact type and 2.4.7 applies to it as stated. Nothing in 2.4.7 or in its parent 2.4.6 presumes the space noncompact, so no proposition is being asked to assume what is under dispute.

**The group is the right one.** 2.4.7 is stated about *the isotropy subgroup of its transvection group*, and step 4's $G$ is the transvection group, which global symmetry makes transitive by definition. Connectedness of $G$ is not needed by the bundle argument, and 2.4.7 supplies it anyway along with connectedness of $K$, both unused.

**The bundle argument is valid and its inputs deserve naming.** Precisely: $G$ is a Lie group, $K=G_x$ is a closed subgroup, the orbit map induces a diffeomorphism $G/K\to M$ for a transitive smooth action of a Lie group on a manifold, and $\pi:G\to G/K$ is a locally trivial principal $K$-bundle. Cover the compact $M$ by finitely many compact sets each inside a trivialising open set, so $G$ is a finite union of sets homeomorphic to $\mathrm{compact}\times K$, hence compact. What this needs of $G$ is that it is a Lie group, which gives local compactness, Hausdorffness and the local triviality in one stroke. Properness of the action is not needed, the fibre being compact. The block states neither the local triviality nor the homeomorphism $G/G_x\cong M$, and both are standard enough that I record them as inputs rather than as a gap.

**A shorter contradiction is available from the same corollary.** 2.4.7 rests on Theorem 2.4.6, which gives $G$ diffeomorphic to $K\times\mathbb R^n$, whence $M=G/K\cong\mathbb R^{\dim M}$, which is not compact for $\dim M>0$. The block's route reaches the same contradiction the long way round and is correct either way.

## 6. Group compactness against algebra compactness

**CONFIRMED, no finding, and the bridge is a definition rather than a theorem.** Section 5.5 of the source opens *a Lie algebra $\mathfrak g$ is called compact if there exists a compact Lie group whose Lie algebra is isomorphic to $\mathfrak g$*. So if $G$ were compact then $\mathfrak g$ would be a compact Lie algebra immediately, and step 3's *$\mathfrak g$ is not compact* gives *$G$ is not compact* by contraposition with nothing in between.

**Neither the centre nor a covering can break it**, because the definition is existential over compact groups with that algebra rather than a statement about one group. The alternative bridge would have been Theorem 5.5.1(c), that a compact algebra admits an $\mathrm{ad}$-invariant inner product, reached by averaging over Haar measure, and it gives the same implication. The block's phrasing runs the two nouns together in one clause, "$\mathfrak g$ is not compact and the transvection group $G$ is noncompact", which reads as an assertion of two facts where it means an inference, and one added clause would fix that.

**The transcription does not carry the definition**, see §10 below.

## 7. The hyperbolic witness

**REFUTED.** The block's witness fails on the $W\ne0$ clause, and the record contains its own refutation. Take the clauses in turn.

| Clause | Holds? | Reason |
| --- | --- | --- |
| Compact | yes | closed by hypothesis |
| Locally symmetric | yes | constant curvature gives $\nabla R=0$ |
| Einstein with $\lambda<0$ | yes | $\mathop{\mathrm{Ric}}=-(n-1)g$ at curvature $-1$ |
| $W\ne0$ | **NO** | constant sectional curvature makes $R$ a multiple of the identity on $\Lambda^2$, so $W=0$ in every dimension |
| Excluded by failing homogeneity | yes | $\mathop{\mathrm{Isom}}$ of a closed manifold with $\mathop{\mathrm{Ric}}<0$ is finite, so no transitive action |

The record states the fourth row against itself twice within the same file. [L48](../findings/problem.md#L298) says each $\lVert W_a\rVert^2$ "vanishes exactly when that factor has constant curvature", and [L47](../findings/problem.md#L231) says $S^n$ and $\mathbb{RP}^n$ have $W=0$ for the same reason. A hyperbolic space form is constant curvature, so it is on the $W=0$ side of the record's own biconditional. I triple-checked by the three available readings: the pointwise curvature operator of a space form is $\kappa\,\mathrm{Id}$ on $\Lambda^2$ so its trace-free Weyl part is zero, conformal flatness of space forms says the same, and at $n=3$ the Weyl tensor vanishes for every metric. The witness fails in all three.

**The existence claim the witness was carrying is TRUE, with a different object.** A closed quotient of complex hyperbolic space $\mathbb{CH}^m$ with $m\ge2$ is compact, locally symmetric, Einstein with $\lambda<0$, and has $W\ne0$, and cocompact lattices exist in $SU(m,1)$. The nonvanishing is the record's own closed form read through Cartan duality: $\lVert W\rVert^2=\frac{3m(m-1)}{4(m+1)(2m-1)}$ for $\mathbb{CP}^m$ is positive for $m\ge2$, and duality negates the curvature operator without changing that magnitude, so $\mathbb{CH}^6$ gives a witness at $n=12$ with $\lVert W\rVert^2=\frac{45}{154}$. So the hypothesis-location claim survives and the object named for it must be replaced, at [findings/problem.md:255](../findings/problem.md#L255), at [findings/INDEX-results.md:221](../findings/INDEX-results.md#L221) and at [ATTEMPTS.md:6890](../ATTEMPTS.md#L6890), where the same false witness is written three times.

**Why it matters beyond tidiness.** The witness is the block's evidence that its hypotheses are tight, and a false witness would leave the block not knowing which hypothesis it is spending. Here the correction changes no verdict, the corrected witness being locally symmetric and non-homogeneous in exactly the same way, so the location claim is confirmed rather than weakened. The $W\ne0$ hypothesis is not what excludes the hyperbolic case for the Theorem, and it is what excludes it for THIS lemma, which is a distinction the block currently blurs.

## 8. Hypothesis inventory

**CONFIRMED, with one hypothesis used and unstated.**

| Hypothesis | Where it enters | Only there? |
| --- | --- | --- |
| Locally symmetric | steps 2 and 3, via 3.1.4 and L210 | yes |
| $\mathop{\mathrm{Ric}}=\lambda g$ | steps 2, 3 and 5, and L210's shared constant | no, and it is needed throughout |
| $W\ne0$ | step 1 alone | yes |
| $\lambda\ne0$ | step 3, as L210's hypothesis, supplied by step 1 | yes |
| Compact | step 4, as the base of the bundle | yes |
| Globally symmetric | step 4, transitivity of $G$, and the applicability of 2.4.7 to $M$ | yes |
| $\dim M>0$ | step 3, for $\mathfrak p\ne0$ | used, and absent from the statement |

So the block's location claim is accurate as far as it goes. Two refinements. Global symmetry does a second job at step 4 beyond transitivity, since 2.4.7 is a statement about symmetric spaces in the global sense, and the block credits it only with transitivity. And $\dim M>0$ belongs in the statement, a $0$-dimensional $M$ being vacuous but formally outside step 3.

## 9. The reach

**GAP, and the gap is a word in the Theorem.** The Theorem at [results.md:643](../results.md#L643) quantifies over "every compact **Einstein** symmetric space of dimension $n$ **with $W\ne0$**", and L211 requires GLOBALLY symmetric. Those differ on a nonempty class, the corrected witness of §7 being in it: a closed quotient of $\mathbb{CH}^6$ is a compact Einstein symmetric space of dimension $12$ with $W\ne0$ under the local reading, and no lemma on the record covers it. The residue is probably harmless, since duality sends $\theta$ to $-\theta$ and a negative $\theta$ satisfies the bound trivially, and that observation is nowhere on the record and is not what L211 provides. **What is owed is either the word *globally* in both copies of the Theorem, or a separate line covering the locally symmetric $\lambda<0$ case.**

**Compactness of the factors is derivable from inputs in hand and is not written.** L47's census is of compact irreducible symmetric SPACES, so a consumer needs the factors compact rather than merely of compact type. The chain is short: compact type gives $\beta$ negative definite on $\mathfrak p_i$, Lemma 2.1.2(b) gives it negative definite on $\mathfrak k_i$, Lemma 2.1.2(a) gives $\beta(\mathfrak k,\mathfrak p)=0$, so $\beta$ is negative definite on $\mathfrak g_i$, and Corollary 5.5.2 makes $\mathfrak g_i$ a compact Lie algebra, so the factor's transvection group is compact and the factor is a quotient of it. Every input is one the block already cites. The block's claim at [findings/problem.md:286](../findings/problem.md#L286), that "compactness of the factors follows from compact type once that is established", is therefore right and belongs inside L211 as a line rather than in a note attached to L210.

**One further item for the consumer**, and it is L210's rather than L211's: L210 delivers a splitting of the CURVATURE at the algebra, and L48 is written for a space that IS a Riemannian product. That is sufficient for $\lVert W\rVert^2$, which is pointwise, and L47's census is a statement about spaces, so the passage from an algebra factor to a space needs the previous paragraph's chain.

## 10. Is any of it already on the record?

**New as a derivation, and the conclusion is already asserted elsewhere with a FALSE reason.** I searched [findings/](../findings/) and [verification/](../verification/) for $\lambda>0$ and compact-type statements about symmetric spaces. Two hits matter.

- [VERIFY_v193.md:181](../verification/VERIFY_v193.md#L181) asserts "The universal covering of a compact symmetric space splits as $\mathbb R^j\times M_1\times\cdots\times M_r$ with $M_i$ irreducible of compact type" and closes with "**Compactness gives $\mathop{\mathrm{Ric}}\ge0$, so $\lambda\ne0$ and $\lambda>0$ coincide here**". The final sentence is FALSE: a closed hyperbolic manifold is compact with $\mathop{\mathrm{Ric}}<0$. So the record held L211's conclusion on a reason that does not hold, and L211 supersedes it. That sentence should be struck when L211 lands.
- The L210 block's own note at [findings/problem.md:282](../findings/problem.md#L282) states the mechanism and explicitly declines to have derived it, calling $\lambda>0$ "what is genuinely owed". That is consistent with L211 being new.

**The four-input citation is wrong for two of the four, and this is the block's most checkable defect.** [findings/problem.md:245](../findings/problem.md#L245) says "The inputs, all four from [Gorodski](../references/gorodski-symmetric-spaces-intro/notes.md) and none from outside it". The transcription [notes.md](../references/gorodski-symmetric-spaces-intro/notes.md) carries Corollary 3.1.4 and Lemma 2.1.2 and carries NEITHER Corollary 2.4.7 NOR Corollary 5.5.2 nor section 5.5's definition of a compact Lie algebra, and it says so itself at its *Not transcribed* section, "everything about noncompact type beyond the definition". Both statements are in the raw extraction in the same folder, at lines 1624 and 3172, which I read and quoted above, so the mathematics is sourced and the record's transcription is short by three statements. **The repair is to add 2.4.7, 5.5.2 and 5.5's definition to notes.md and to point the citation at them**, which is the same failure mode the notes file already records once, of a transcription dropping clauses its own proofs use.

## 11. What would break it

**No falsifier found.** The object that would refute L211 is a compact GLOBALLY symmetric Einstein space of noncompact type, equivalently one whose $\beta$ is positive definite on $\mathfrak p$ and whose transvection group still acts transitively on a compact manifold. Theorem 2.4.6 blocks it structurally, giving $G\cong K\times\mathbb R^{\dim M}$ and hence $M\cong\mathbb R^{\dim M}$.

Four evasion routes were checked by hand and each closes.

1. **An irreducible factor with $\beta|_{\mathfrak p_i}$ indefinite**, which would break the type dichotomy and let a mixed-type product carry $\lambda<0$. Closed by Corollary 3.1.4's $B=\lambda_i\beta|_{\mathfrak p}$ with $B$ an inner product, so $\beta|_{\mathfrak p_i}$ is definite on every irreducible factor.
2. **Factors of different types under one Einstein constant.** Closed by L210's shared $\lambda$ together with §3's one-signed Ricci per factor.
3. **A non-semisimple $\mathfrak g$ evading step 3**, a compact Einstein symmetric space with a flat direction. Closed by L210's removal of the Euclidean factor, which is where $\lambda\ne0$ and the effectiveness clause are spent.
4. **$B$ merely nondegenerate rather than positive definite**, the pseudo-Riemannian reading, which would break step 2's type equivalence outright. Closed by the OIL definition on file, which says INNER PRODUCT, a clause the transcription flags as load-bearing and which an earlier version of it had dropped.

The nearest genuine object is the corrected witness of §7, a closed quotient of $\mathbb{CH}^m$, which satisfies every hypothesis except global symmetry and confirms that step 4 is where the lemma's weight sits.

## Verdict for L211

**GAP.** The statement is TRUE, and steps 2 to 5 establish it, so the lemma may be relied on for its conclusion. Four repairs are owed before the block reads as written.

1. **Step 1's instrument.** Replace Cartan--Ambrose--Hicks with the OIL route of §1, which stays inside the cited source, or state the lemma with $\lambda\ne0$ in place of $W\ne0$ and drop the step. The same misnaming stands at [findings/problem.md:584](../findings/problem.md#L584) and should go with it.
2. **Step 3's definiteness clause.** Add the $\beta$-orthogonality of the $\mathfrak p_i$ and the restriction of the Killing form to an ideal, and credit Corollary 2.1.5 for semisimplicity, which makes the input count five.
3. **The witness.** A closed hyperbolic manifold has $W=0$, by the record's own L48 clause. Replace it with a closed quotient of $\mathbb{CH}^m$, $m\ge2$, at all three places the false witness appears.
4. **The citation and the transcription.** Corollary 2.4.7 and Corollary 5.5.2 are in the source and not in notes.md, so transcribe them with section 5.5's definition of a compact Lie algebra, which is the bridge from the algebra to the group.

And one item beyond the block: the Theorem's quantifier still says "symmetric" where L211 needs "globally symmetric", so the quantifier is closed for the global reading and open for the local one.

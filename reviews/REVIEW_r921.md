# Review r921, does Lemma L211 establish that a compact Einstein symmetric space has $\lambda>0$?

Reviewer r921, Gate 2 on [Lemma L211](../findings/problem.md) (the block at lines 241 to 257). The round read a written derivation link by link and asked of each step whether it follows from the step above it and from the hypotheses actually stated. Read: the L211 and [L210](../findings/problem.md) blocks, [L46](../findings/problem.md)'s $\lambda=0$ parenthetical, [L47](../findings/problem.md) and [L48](../findings/problem.md) with the Theorem at [results.md](../results.md) line 643, the record's transcription at [notes.md](../references/gorodski-symmetric-spaces-intro/notes.md), and the raw extraction [gorodski-symmetric-spaces.txt](https://www.ime.usp.br/~gorodski/ps/symmetric-spaces.pdf) at the four cited statements and at the definitions of transvection group, type and compact Lie algebra. Analysis only, no run of any kind. Log: [agent_logs/gate2-l211-r921.log](../agent_logs/gate2-l211-r921.log).

## Claim table

| # | Item | Verdict | Reason |
|---|------|---------|--------|
| 1 | Step 1, $\lambda\ne0$ | GAP | Ricci-flat plus locally symmetric does give flat, but Cartan--Ambrose--Hicks is not the instrument that gives it, and [L46](../findings/problem.md)'s parenthetical carries the same attribution with no argument behind it |
| 2 | Step 2 normalisation, $\lambda_i$ against the Einstein constant | CONFIRMED | The two constants are kept apart throughout, $\mathop{\mathrm{sign}}K=-\mathop{\mathrm{sign}}\lambda_i$ reproduces by hand, and the type equivalence is exact because $B$ is an inner product |
| 3 | Step 2's tracing clause and strictness | GAP | No strictness is needed anywhere, and the flat factor dies by irreducibility, but the pass from per-factor tracing to the GLOBAL $\lambda$ runs through [L210](../findings/problem.md)'s shared constant, which step 2 never cites |
| 4 | Step 3, definiteness across factors and semisimplicity | GAP | Both conclusions hold, and L210 does deliver $\mathfrak g_0=0$ rather than only $\mathfrak p_0=0$, but $\beta(\mathfrak p_i,\mathfrak p_j)=0$ and Corollary 2.1.5 are the two links that carry them and neither is named |
| 5 | Step 4, transvection group, Corollary 2.4.7, bundle topology | CONFIRMED | Step 3 establishes noncompact type, which is exactly 2.4.7's hypothesis, so the contradiction hypothesis supplies it without circularity, and the bundle argument is valid for a Lie group with a compact isotropy subgroup |
| 6 | $G$ noncompact against $\mathfrak g$ noncompact | CONFIRMED | The block uses the contrapositive of "$G$ compact implies $\mathfrak g$ compact", which is Gorodski's own definition of a compact Lie algebra, so neither the centre nor a covering can reach it |
| 7 | The hyperbolic witness | REFUTED | A closed hyperbolic manifold has constant curvature, hence $W=0$, so it is excluded by step 1 and never reaches step 4, and the block's account of which hypothesis it spends is wrong on its own example |
| 8 | Hypothesis inventory | CONFIRMED | Compactness and global symmetry are spent at step 4 alone and $W\ne0$ at step 1 alone, where it is used only to reach $\lambda\ne0$ |
| 9 | The reach, does the Theorem's quantifier close | GAP | The Theorem quantifies over compact Einstein SYMMETRIC spaces while L211 needs GLOBALLY symmetric, and [L47](../findings/problem.md) needs each factor COMPACT where L211 delivers compact TYPE |
| 10 | Already on the record | CONFIRMED, the statement is | [VERIFY_v193.md](../verification/VERIFY_v193.md) line 181 already asserts the compact-type splitting of a compact symmetric space, unargued and on a false reason, so what L211 adds is the argument |
| 11 | What would break it | CONFIRMED, none found | The falsifier is a compact globally symmetric space with one noncompact-type factor, and three independent routes each close it |

**Summary in one line.** L211's conclusion is true and its load-bearing step 4 is valid, and what the block owes is four repairs: the instrument at step 1, three uncited links, the quantifier that carries it to the Theorem, and one side claim that is false as written.

## 1. Step 1, $\lambda\ne0$, and what actually gives it

The conclusion is right and the named instrument is wrong. Cartan--Ambrose--Hicks is a rigidity statement, that a curvature tensor matched along parallel transport determines the metric locally, so it is the tool for "$R=0$ implies locally Euclidean", which is the step nobody disputes. The step in dispute is $\mathop{\mathrm{Ric}}=0\Rightarrow R=0$, and CAH says nothing about it.

The record's own inputs give it in two lines, and they are already in [notes.md](../references/gorodski-symmetric-spaces-intro/notes.md). Proposition 2.1.3 needs no $\lambda\ne0$, so $\mathfrak p=\mathfrak p_0\oplus\bigoplus_i\mathfrak p_i$ is available at $\lambda=0$, and L210's steps 1 and 2 need no $\lambda\ne0$ either, so the curvature is block-diagonal. On an irreducible factor Corollary 3.1.4 with Lemma 2.1.2(b) makes every $K(X,e)=\lambda_i\beta([X,e],[X,e])$ of one sign, so $\mathop{\mathrm{Ric}}(X,X)=\sum_eK(X,e)=0$ forces every $[X,e]=0$, hence $[\mathfrak p_i,\mathfrak p_i]=0$, hence that factor Euclidean, which irreducibility forbids unless $\mathfrak p_i=0$. With (2.1.4)'s $[\mathfrak p_0,\mathfrak p]=0$ the remaining curvature vanishes, so $R=0$. The engine is the definiteness of $\beta$ on each factor, and that is what the citation should name.

The same misattribution sits at [L46](../findings/problem.md) line 584, "at $\lambda=0$ a locally symmetric Ricci-flat space is flat by Cartan--Ambrose--Hicks with de Rham", with no argument attached. So the parenthetical L211 cites is not enough to cite: it imports the conclusion and not a derivation, and the de Rham half of it gets as far as reducing to irreducible factors and then still needs the argument above. **GAP**, repairable in two lines from material the record holds.

## 2. The normalisation, and whether the two $\lambda$s are ever conflated

They are not. The block writes $\lambda_i$ for Corollary 3.1.4's scaling at line 245 and at every use inside step 2, and reserves $\lambda$ for the Einstein constant. The one loose place is step 2's heading, "the type of a factor is the sign of its curvature, and that is the sign of $\lambda$", where the bare $\lambda$ is the Einstein constant while the body's relation is $\mathop{\mathrm{sign}}K=-\mathop{\mathrm{sign}}\lambda_i$. The body is right and the heading is a heading.

I rederived 3.1.4 rather than take it. With $A=[X,Y]\in\mathfrak k$ and $B$ being $\mathrm{ad}_{\mathfrak k}$-invariant, so $\mathrm{ad}_A$ skew on $(\mathfrak p,B)$, Proposition 3.1.2 gives $\langle R(X,Y)Y,X\rangle=-B([A,Y],X)=B(Y,[A,X])=\lambda_i\beta(Y,[A,X])$, and the invariance identity $\beta(a,[b,c])=\beta([a,b],c)$ turns $\beta(Y,[A,X])$ into $-\beta([A,Y],X)=\beta(A,A)$. So $K=\lambda_i\beta([X,Y],[X,Y])$, exactly as quoted. With $[\mathfrak p,\mathfrak p]\subseteq\mathfrak k$, which follows from $s[X,Y]=[sX,sY]=[X,Y]$, and Lemma 2.1.2(b), $\beta(A,A)\le0$, so $\mathop{\mathrm{sign}}K=-\mathop{\mathrm{sign}}\lambda_i$ wherever $A\ne0$.

The type equivalence is exact for the reason the block gives. $B|_{\mathfrak p_i}=\lambda_i\beta|_{\mathfrak p_i}$ is an inner product by the OIL definition, so $\beta|_{\mathfrak p_i}$ is definite of the sign of $\lambda_i$, which is compact type at $\lambda_i<0$ and noncompact type at $\lambda_i>0$ against the vocabulary at [gorodski-symmetric-spaces.txt](https://www.ime.usp.br/~gorodski/ps/symmetric-spaces.pdf) lines 1194 to 1197. The source agrees at line 1637, where the noncompact classes carry $B=\lambda\beta$ with $\lambda>0$. The dichotomy is exhaustive on an irreducible factor, which matters at step 3, and one link goes unsaid: the $\beta$ appearing in 3.1.4 for the factor is the Killing form of $\mathfrak g_i$, and it agrees with $\beta_{\mathfrak g}|_{\mathfrak g_i}$ because $\mathfrak g_i$ is an ideal of an internal direct sum. **CONFIRMED**.

## 3. The tracing clause, and where strictness is and is not needed

Strict positivity is needed nowhere, so the $\mathop{\mathrm{Ric}}\ge0$ against $\mathop{\mathrm{Ric}}>0$ objection does not bite. The contradiction runs on the weak direction alone: a compact-type factor gives $K\ge0$, hence $\mathop{\mathrm{Ric}}\ge0$, hence its Einstein constant is $\ge0$, and step 1 has already removed the boundary case $\lambda=0$. A flat irreducible factor would break the equivalence, and what removes it is irreducibility itself, since Gorodski's *irreducible* is defined at line 15 of [notes.md](../references/gorodski-symmetric-spaces-intro/notes.md) as "not Euclidean and $\mathrm{ad}_{\mathfrak k}$ irreducible on $\mathfrak p$", so $[\mathfrak p_i,\mathfrak p_i]\ne0$ and some $K>0$ strictly. L210's removal of the Euclidean factor is what rules out the flat factor that is not irreducible, so both halves are covered and the block needs neither.

What the written chain does omit is the step from the per-factor constant to the global one. Tracing on a factor bounds that factor's own Einstein constant, and the hypothesis is $\mathop{\mathrm{Ric}}=\lambda g$ on $M$. The bridge is L210's fourth step, that every factor inherits the SAME $\lambda$, and step 2 does not cite it while step 3 cites L210 only for the Euclidean factor. One clause repairs it. **GAP**.

## 4. Step 3, definiteness across factors and semisimplicity

Both conclusions hold and both rest on links the block leaves implicit.

- **$\beta$ positive definite on all of $\mathfrak p$.** Needs $\beta(\mathfrak p_i,\mathfrak p_j)=0$ for $i\ne j$, which holds because $\mathfrak g=\bigoplus\mathfrak g_i$ is a sum of ideals, so $\mathrm{ad}_X\mathrm{ad}_Y=0$ for $X\in\mathfrak g_i$ and $Y\in\mathfrak g_j$ and the trace vanishes. The block asserts the conclusion with no such reason, and without orthogonality "positive definite on each summand" would not compose.
- **Semisimplicity.** L210 does deliver more than $\mathfrak p_0=0$: its step 3 states $\mathfrak g_0=0$ explicitly, by the effectiveness clause, and $\mathfrak g_0=0$ is what "no Euclidean factor" means. The passage from there to semisimple is Corollary 2.1.5's third sentence, which [notes.md](../references/gorodski-symmetric-spaces-intro/notes.md) line 34 carries, and the block cites L210 alone. The worry that 2.1.5 is circular here does not apply: L210's own block says 2.1.5 restates its conclusion regarding $\mathfrak p_0=0\Rightarrow\mathfrak g_0=0$, whereas what is used now is the different clause of 2.1.5, no Euclidean factor implies semisimple.
- **The rest of the step is clean.** $\mathfrak p\ne0$ follows from $\dim M>0$, which $W\ne0$ already forces, so $\beta$ is not negative definite on $\mathfrak g$, and Corollary 5.5.2 applies because semisimplicity is in hand.

**GAP**, two citations owed, no mathematical defect.

## 5. Step 4, the load-bearing one

**The transvection group is the right $G$ and it is connected.** [gorodski-symmetric-spaces.txt](https://www.ime.usp.br/~gorodski/ps/symmetric-spaces.pdf) line 802 defines it as the connected subgroup of $\mathrm{Isom}(M)$ generated by all transvections, and lines 376 to 378 give that for a globally symmetric $M$ it acts transitively, which is the brief's definition of globally symmetric. It is also the group whose algebra 3.1.2 and the OIL structure are built from, so the $\mathfrak g$ of steps 2 and 3 and the $G$ of step 4 are the same object.

**Corollary 2.4.7 is applicable, and the circularity worry dissolves.** 2.4.7 is stated for a space of noncompact type, and step 3 has just established that $\beta$ is positive definite on all of $\mathfrak p$, which is precisely the definition of noncompact type for the whole OIL-algebra, reducible or not. A proof by contradiction is entitled to its own hypothesis, so invoking a corollary whose hypothesis the contradiction supplies is ordinary, not circular. What would be circular is invoking 2.4.7 to establish noncompact type, and the block does not.

**The bundle argument is valid, and here is what it needs.** $K$ compact implies $K$ closed in $G$, so $G\to G/K$ is a principal $K$-bundle of smooth manifolds. A transitive smooth action of a Lie group on $M$ identifies $G/K$ with $M$ diffeomorphically, which needs $G$ second countable and locally compact and a Lie group is both. A fibre bundle projection with compact fibre is proper, so the preimage of the compact $M$ is compact, and $G$ is compact. Nothing beyond local compactness and properness is used, and properness is a consequence here rather than an assumption.

**Two observations that strengthen the step rather than weaken it.** First, 2.4.7 is over-strength for what is drawn from it: compactness of the isotropy of any isometry group at a point is Myers--Steenrod, recorded in the same source at line 568. The one thing 2.4.7 adds is that $K$ is compact IN $G$, which matters because a subgroup generated by a set need not carry the subspace topology. Under L210's no-Euclidean-factor conclusion that worry also goes, since lines 378 to 381 say the transvection group coincides with $\mathrm{Isom}(M)^0$ when there is no flat de Rham factor. Second, 2.4.7 carries simple connectivity, and with 2.4.6's $G$ diffeomorphic to $K\times\mathbb R^n$ it gives $M=G/K$ diffeomorphic to $\mathbb R^n$, which contradicts compactness in one line. Either route closes.

**One citation defect, and it is about hygiene rather than truth.** The block says its four inputs are "all four from [Gorodski](../references/gorodski-symmetric-spaces-intro/notes.md)", and Corollary 2.4.7 and Corollary 5.5.2 appear nowhere in that transcription. They are in the raw extraction at lines 1624 and 3172, and the transcription's own "Not transcribed" section excludes "everything about noncompact type beyond the definition", which is exactly where 2.4.7 lives. Both statements check out verbatim against the extraction, so the mathematics stands and the transcription is two quotations short of the citation the block makes. **CONFIRMED** on the mathematics.

## 6. From the algebra to the group

Gorodski defines a compact Lie algebra at line 3136 of the extraction: $\mathfrak g$ is compact when some compact Lie group has Lie algebra isomorphic to $\mathfrak g$. The direction the block needs is therefore immediate by definition, $G$ compact implies $\mathfrak g$ compact, and step 3 uses its contrapositive. The centre and coverings threaten only the converse, that a compact algebra gives a compact group, and step 4 never asserts it: step 4 derives compactness of $G$ from the topology of $M$, not from $\mathfrak g$. So the two steps meet at the group and the crossing is safe in the one direction it is made. The block does state "so $\mathfrak g$ is not compact and the transvection group $G$ is noncompact" without a word for the implication, and the word is the definition. **CONFIRMED**.

## 7. The hyperbolic witness is false

A closed hyperbolic manifold has constant sectional curvature, so its curvature operator is a multiple of the identity on $\Lambda^2$, so $W=0$ identically. The block's own neighbouring lemma says as much for the positive case at [L47](../findings/problem.md) line 231, where $S^n$ and $\mathbb{RP}^n$ have $W=0$ for that reason. So the closed hyperbolic manifold satisfies compact, locally symmetric, Einstein with $\lambda=-(n-1)<0$ and not homogeneous, and fails $W\ne0$, the one hypothesis the block needed it to satisfy.

The consequence is worse than a wrong example. The block offers it as evidence that step 4 is the step doing the work, and the object it names is excluded at STEP 1, by $W\ne0$, and never reaches step 4. So the block's own account of which hypothesis it is spending is unsupported by its own witness.

The claim it was meant to support is nonetheless true, and a correct witness is available inside the record. Take a compact quotient of complex hyperbolic space $\mathbb{CH}^m$ with $m\ge2$, which exists because cocompact lattices exist in $\mathrm{PU}(m,1)$. It is compact, locally symmetric, Einstein with $\lambda<0$, and $W\ne0$ because its curvature operator is that of the dual $\mathbb{CP}^m$ up to sign, whose Weyl norm the record itself carries at [L47](../findings/problem.md) line 231 as $\lVert W\rVert^2=\frac{3m(m-1)}{4(m+1)(2m-1)}>0$ for $m\ge2$. Such a quotient has finite isometry group, so it is not homogeneous, and it is excluded by step 4 alone. At $m=6$ it even sits at $n=12$, the Theorem's first admissible dimension. **REFUTED** as written, repairable by replacing the example.

## 8. Hypothesis inventory

| Hypothesis | Where it is used |
|---|---|
| Locally symmetric | Step 1 (Proposition 3.1.2 and 2.1.3), step 2 (Corollary 3.1.4), step 3 through L210 |
| $\mathop{\mathrm{Ric}}=\lambda g$ | Step 1, step 2's tracing, step 3 through L210's shared constant |
| $W\ne0$ | Step 1 only, and only to reach $\lambda\ne0$ |
| $\lambda\ne0$, derived | Step 3, as L210's hypothesis, and step 5's strict sign |
| Compact | Step 4 only, as the compact base |
| Globally symmetric | Step 4 only, as transitivity of the transvection group |
| $\dim M>0$ | Step 3, and it is free, since $W\ne0$ forces $\dim M\ge4$ |
| Connected | Throughout, unstated, and needed for homogeneity and for Myers--Steenrod |

Two consequences. $W\ne0$ is spent only on $\lambda\ne0$, so the lemma would be true and cleaner with $\lambda\ne0$ as the hypothesis, and then step 1 disappears together with its misattributed instrument. And the localisation claim in the block's closing paragraph is correct as an inventory, whatever the witness does. **CONFIRMED**.

## 9. The reach

Two things stand between L211 plus L210 and the Theorem's quantifier at [results.md](../results.md) line 643, "every compact **Einstein** symmetric space of dimension $n$ **with $W\ne0$**".

- **Globally symmetric against symmetric.** L211 needs the transvection group to act transitively, and the Theorem says "symmetric space" with no adverb. On the reading where that means locally symmetric, L211 does not apply, and the residual branch is a compact locally symmetric Einstein space with $\lambda<0$ and $W\ne0$, which exists, as section 7 exhibits. That branch satisfies the Theorem's inequality for a reason the record already holds and never connects here: $\theta=\lambda/\lVert W\rVert<0<\theta_0(n)$, the signed reading being [L46](../findings/problem.md)'s own, "$\lambda<0$ is harmless, the identity surviving with $\theta=\lambda/\lVert W\rVert<0$". So the quantifier is closable either by restating the Theorem with "globally symmetric" or by one line on the negative branch, and the block claims the first without making the Theorem say it.
- **Compact type against compact.** L211 concludes that every irreducible factor is of compact TYPE, while [L47](../findings/problem.md)'s census is over compact irreducible symmetric spaces. Compact type does give compactness, since $\beta$ is then negative definite on $\mathfrak k$ by 2.1.2(b) and on $\mathfrak p$ by the type, hence on $\mathfrak g$, so $\mathfrak g$ is compact semisimple, its transvection group is compact and $M=G/K$ is compact. Nothing on file says this. L210's block asserts it in passing at line 286, "compactness of the factors follows from compact type once that is established", with no argument, so the record holds the sentence and not the step.

The rest of the reach is sound. L48 works pointwise off the block-diagonal curvature and one shared constant, both of which L210 supplies, so it needs no metric product theorem. **GAP**.

## 10. Is any of it already on the record

The statement is, the argument is not. [VERIFY_v193.md](../verification/VERIFY_v193.md) line 181 says "The universal cover of a compact symmetric space splits as $\mathbb R^j\times M_1\times\cdots\times M_r$ with $M_i$ irreducible of compact type", which is L211's conclusion plus a de Rham splitting, asserted with no proof and no citation inside a verification round. The sentence that follows it, "Compactness gives $\mathop{\mathrm{Ric}}\ge0$, so $\lambda\ne0$ and $\lambda>0$ coincide here", is false as a general claim and circular as a reason in context: compactness alone gives nothing about the sign of the Ricci curvature, a closed hyperbolic manifold being the standard witness, and the statement becomes true for a compact globally symmetric space only through what L211 proves.

So L211 is not a duplicate, and it should be recorded as also retiring a false clause that a verification round has been carrying. Searching [findings/](../findings/) and [verification/](../verification/) for "compact type" turns up only [problem.md](../findings/problem.md), the two indexes, [LEDGER.md](../findings/LEDGER.md) and that one v193 passage, so nothing else competes. **CONFIRMED as new for the argument.**

## 11. What would break it, and what I did to look

The falsifier is a single object: a compact globally symmetric space carrying one irreducible factor of noncompact type, equivalently a compact homogeneous space whose transvection group is noncompact. Three independent closures, of which the block uses one:

1. **Topology of the group.** $M$ compact makes $\mathrm{Isom}(M)$ compact by Myers--Steenrod, and with no flat factor the transvection group is $\mathrm{Isom}(M)^0$, so it is compact and $\mathfrak g$ is compact and $\beta$ is negative definite on $\mathfrak p$.
2. **Topology of the space.** 2.4.7 with 2.4.6 makes a noncompact-type $M$ diffeomorphic to $\mathbb R^{\dim M}$, which is not compact.
3. **The algebra.** An irreducible factor has $\beta|_{\mathfrak p_i}$ definite of the sign of $\lambda_i$, so an indefinite $\beta|_{\mathfrak p_i}$ is impossible, and a mixed-type product is impossible against a single $\lambda\ne0$ because the two types give Ricci curvatures of opposite sign.

I also probed the places where a sign or a factor could hide: the sign convention of 3.1.2, which the extraction fixes at line 2122 and which I carried through the rederivation of 3.1.4 in section 2; whether $\beta$ for the factor is $\beta$ for $\mathfrak g$, which holds for ideals of a direct sum; whether an irreducible factor could have $\beta|_{\mathfrak p_i}=0$, which 2.1.3's proof excludes by putting the zero eigenvalue of $A$ into $\mathfrak g_0$; and the block's own witness, which is where the search found its one falsehood, reported in section 7. No falsifier for the lemma.

## Verdict for L211

**CONFIRMED, with one REFUTED side claim and four repairs owed, none of which touches the conclusion.** The lemma is true, step 4 is valid and is correctly identified as the load-bearing step, and Corollary 2.4.7 is legitimately applied inside the contradiction. What the block owes is the instrument at step 1, the shared-constant citation at step 2, the two links at step 3, a witness that satisfies $W\ne0$, and either "globally symmetric" in the Theorem or one line on the negative branch. The compact-type-implies-compact step that [L47](../findings/problem.md) needs is on the record as a sentence and not as an argument.

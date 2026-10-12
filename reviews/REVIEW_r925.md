# Review r925, does Lemma L213 establish that each irreducible factor of a compact Einstein symmetric space is itself compact?

Reviewer r925, Gate 2 on [Lemma L213](../findings/problem.md) (the block at lines 265 to 283). The round read a written citation chain link by link and asked of every quoted statement whether the object it is applied to meets its hypotheses. Read: the L213 block, [L211](../findings/problem.md), [L210](../findings/problem.md), [L47](../findings/problem.md), [L48](../findings/problem.md) with the Theorem, both transcriptions ([Gorodski](../references/gorodski-symmetric-spaces-intro/notes.md), [Ziller](../references/ziller-2010-lie-groups-symmetric-spaces/notes.md)), the raw extractions [gorodski-symmetric-spaces.txt](https://www.ime.usp.br/~gorodski/ps/symmetric-spaces.pdf) at Definition 6.31's analogue, §1.5, Lemma 2.1.1, Theorem 2.3.8 and the four cited statements, and [ziller-lie-groups-reps.txt](https://www2.math.upenn.edu/~wziller/math650/LieGroupsReps.pdf) at Definition 6.31, Definition 6.37 and the full printed proof of Proposition 6.38, plus [L213FactorCompact.lean](../lean/HamiltonsCubic/Results/L213FactorCompact.lean), which I re-ran. Analysis only, one type-check of a file already in hand and no other run. Log: [agent_logs/gate2-l213-r925.log](../agent_logs/gate2-l213-r925.log).

## Claim table

| # | Item | Verdict | Reason |
| --- | --- | --- | --- |
| 1 | Proposition 6.38(c) applicable hypothesis by hypothesis | GAP | its $(G,K)$ needs $K$ compact by Definition 6.31 and the record supplies that nowhere, the no-shared-ideal clause being the only one of the two that item 2 delivers, and the block's steps never in fact apply 6.38(c) |
| 2 | Effectiveness clause inherited by the summands | CONFIRMED | derivable in two lines from the summands being ideals of an internal direct sum, which is stronger support than the block's appeal to their being called OIL-algebras |
| 3 | Step 3's linear algebra, and the $B$ versus $\beta$ question | CONFIRMED | $\mathfrak g_i=\mathfrak k_i\oplus\mathfrak p_i$ comes from 2.1.3(a)'s $s$-invariance and the cross term vanishes on all pairs by bilinearity, and the brief's premise is backwards, Ziller's $B$ in Definition 6.37 IS the Killing form |
| 4 | Step 4's group, transvection group versus $\mathrm{Inn}(\mathfrak g_i)$ | GAP | $\mathrm{Inn}(\mathfrak g_i)=G_i/Z(G_i)$ is not the group that presents $M_i$, and closing the difference is Weyl's finiteness of $Z(G_i)$, cited nowhere on the record |
| 5 | $K_i$ compact and closed | CONFIRMED, and not load-bearing | true once $G_i$ is compact, needs no faithful isotropy representation, and the quotient's compactness needs neither it nor closedness |
| 6 | Step 5, $\theta(M)=\theta(\widetilde M)$, and what the census consumes | GAP | step 5 itself is exact, and the surrounding claim that L47's census applies to each factor by name is wrong, L47 needing $W_a\ne0$ per factor and L48 needing no per-factor compactness at all |
| 7 | Simple connectivity of the factors | CONFIRMED | $\pi_1$ of a Riemannian product is the product of the $\pi_1$, so every factor of the simply connected $\widetilde M$ is simply connected, and 6.38(c) needs none of it |
| 8 | The inventory of hypotheses the block claims to spend | REFUTED | step 2 spends GLOBAL symmetry of $M$ directly rather than through L211, Gorodski's *symmetric space* being the global notion, and five further inputs are off the list |
| 9 | The $\mathbb{CH}^m\times\mathbb{CH}^m$ counterexample | CONFIRMED | every clause holds, cocompact lattices in $\mathrm{PU}(m,1)$ give a product of two closed complex-hyperbolic manifolds whose de Rham factors are noncompact |
| 10 | Already on the record | CONFIRMED, both the claim and the argument are | the claim stands unargued at three places and the full chain is written out in [r921](REVIEW_r921.md)'s section 11, the review the block credits only with leaving the clause owed |
| 11 | Does it close what it claims to close | GAP | what it genuinely closes is the one-factor branch, where $\widetilde M$ must be compact for L47, and the multi-factor branch never needed factor compactness |
| 12 | What would break it | CONFIRMED, none found | a falsifier must break L210, L211 or 6.38(c), and three routes to one were tried and each closes |

## Summary

The conclusion is true and the statement should stand, and as a citation chain it is one theorem short: step 4 passes from a compact Lie algebra to a compact group through $\mathrm{Inn}(\mathfrak g_i)$, which is not the group presenting $M_i$, and the block's inventory of what it spends is wrong about global symmetry.

## 1. Proposition 6.38(c), hypothesis by hypothesis

**The source's definition is stricter than the transcription's summary, and I read it at the page.** [ziller-lie-groups-reps.txt](https://www2.math.upenn.edu/~wziller/math650/LieGroupsReps.pdf) line 6748, Definition 6.31: *"$(G,K,\sigma)$ is called a symmetric pair if $K$ is compact, $\sigma$ is an involution of $G$ with $G^\sigma_0\subset K\subset G^\sigma$, and $G$ acts almost effectively on $G/K$."* Remark 6.32 then reads the last clause at the algebra, and the printed text says *"$\mathfrak g$ and $\mathfrak p$ do not have any ideal in common"* where the proof of 6.38(c) six pages later says *"$\mathfrak g$ and $\mathfrak k$ have no ideals in common"*. **The $\mathfrak p$ is a slip in the source or the extraction and the proof says which form it uses**, so the clause an application must meet is the $\mathfrak k$ one, which is exactly the OIL effectiveness clause.

So an application to $(G_i,K_i)$ owes three things.

- **$G^{\sigma}_0\subset K\subset G^{\sigma}$.** Available. The geodesic symmetry at the base point conjugates to an involution of the transvection group whose fixed algebra is $\mathfrak k_i$, which is Gorodski's Proposition 1.5.1(ii) at [gorodski-symmetric-spaces.txt](https://www.ime.usp.br/~gorodski/ps/symmetric-spaces.pdf) line 576 read on the factor.
- **No ideal shared between $\mathfrak g_i$ and $\mathfrak k_i$.** Available, and it is item 2, where I derive it rather than take it.
- **$K_i$ compact.** **Nothing on the record supplies it.** Gorodski's Corollary 2.4.7, the record's only statement giving an isotropy group compact, is stated for noncompact type, which is the type L211 has just excluded, and [L211](../findings/problem.md)'s step 4 spends it inside a contradiction hypothesis. The statement that does supply it is in the same source and is untranscribed: §1.5, at [gorodski-symmetric-spaces.txt](https://www.ime.usp.br/~gorodski/ps/symmetric-spaces.pdf) line 568, records Myers--Steenrod and ends *"Finally, the isotropy group $G_x$ at a point $x\in M$ is compact."* With the identification of the transvection group with $\mathrm{Isom}(M)^0$ in the absence of a flat de Rham factor (line 378, and L210 supplies the absence), $K_i$ is closed in that compact isotropy group and so compact.

**GAP, and it is a gap of two citations rather than of mathematics.** The applicability is repairable entirely inside the shelf, by transcribing §1.5 and citing it for $K_i$ compact.

**A second observation about item 1 that matters more than the hypotheses.** The block's headline says the lemma IS Proposition 6.38(c) and its steps 3 and 4 never use it. They rebuild its proof from Gorodski's Lemma 2.1.2(b), Corollary 5.5.2 and Theorem 5.5.1(b) instead. That choice is what opens item 4, since the source asserts the conclusion for the pair's own $G$ while the reconstruction reaches only $\mathrm{Inn}(\mathfrak g_i)$.

## 2. The effectiveness clause is genuinely inherited, and here is the derivation

**The block's reason is that Proposition 2.1.3's summands are OIL-algebras, which is support by naming.** It is not wrong, since *irreducible* is defined only for an OIL-algebra and 2.1.3(c) calls each triple irreducible, so the source's statement does presuppose it. It is weaker than what is available, and the record has already paid once for treating this clause as decorative, $\mathfrak p_0=0$ giving $\mathfrak g_0=0$ only through it at [L210](../findings/problem.md)'s step 3.

**Direct derivation, two lines.** Let $\mathfrak a\subseteq\mathfrak k_i$ be an ideal of $\mathfrak g_i$. The decomposition $\mathfrak g=\bigoplus_j\mathfrak g_j$ is into ideals of an internal direct sum, so $[\mathfrak g_j,\mathfrak g_i]=0$ for $j\ne i$, and therefore $[\mathfrak g,\mathfrak a]=[\mathfrak g_i,\mathfrak a]+\sum_{j\ne i}[\mathfrak g_j,\mathfrak a]=[\mathfrak g_i,\mathfrak a]\subseteq\mathfrak a$. So $\mathfrak a$ is an ideal of $\mathfrak g$ contained in $\mathfrak k_i\subseteq\mathfrak k$, and $\mathfrak g$'s own effectiveness clause forces $\mathfrak a=0$. **CONFIRMED**, and the derivation uses only that the summands are ideals, which is 2.1.3's own word.

**One unstated identification sits next to this and is load-bearing.** Step 2 asserts that each de Rham factor $M_i$ *carries* the OIL-algebra $(\mathfrak g_i,s_i,B_i)$ of 2.1.3's decomposition, matching a geometric splitting to an algebraic one. That is true and standard, and Remark 2.1.6's uniqueness up to permutation is what makes it well posed, and the block cites nothing for it. Everything in steps 3 and 4 is stated for the algebraic summand while the conclusion is about the geometric factor, so the identification carries the whole lemma. Recorded under item 8.

## 3. Step 3's linear algebra, and what the two $B$'s are

**The decomposition is available.** $\mathfrak k_i=\mathfrak g_i\cap\mathfrak k$ and $\mathfrak p_i=\mathfrak g_i\cap\mathfrak p$, and 2.1.3(a) gives each $\mathfrak g_i$ $s$-invariant, so $s|_{\mathfrak g_i}$ is an involution of $\mathfrak g_i$ and $\mathfrak g_i$ is the direct sum of its $\pm1$ eigenspaces, $X=\tfrac12(X+sX)+\tfrac12(X-sX)$. So every $X\in\mathfrak g_i$ is $X_{\mathfrak k}+X_{\mathfrak p}$ with both parts in $\mathfrak g_i$, which is what step 3 needs and what the block does not say.

**The cross term vanishes for every pair, not only for eigenvectors.** Lemma 2.1.2(a) is a statement about the subspaces $\mathfrak k$ and $\mathfrak p$, so $\beta(X,Y)=0$ for all $X\in\mathfrak k$ and $Y\in\mathfrak p$, and bilinearity does the rest. **No eigenvector hypothesis is anywhere in it.** With that, $\beta(X,X)=\beta(X_{\mathfrak k},X_{\mathfrak k})+\beta(X_{\mathfrak p},X_{\mathfrak p})<0$ whenever $X\ne0$, since at least one part is nonzero and neither term is positive.

**One identification the block does not state, and it is needed under the brief's own reading of $\beta$.** The brief fixes $\beta$ as the Killing form of $\mathfrak g$, while Corollary 5.5.2 is then applied to $\mathfrak g_i$ and wants the Killing form of $\mathfrak g_i$. The two agree: for $X,Y\in\mathfrak g_i$ the operator $\mathrm{ad}X\,\mathrm{ad}Y$ annihilates every $\mathfrak g_j$ with $j\ne i$, so its trace over $\mathfrak g$ equals its trace over $\mathfrak g_i$, giving $\beta_{\mathfrak g}|_{\mathfrak g_i}=\beta_{\mathfrak g_i}$. [r921](REVIEW_r921.md) made the same observation at L211's step 2, so this is the second round in which the record has needed it and not written it.

**On $B$ against $\beta$, the brief's premise is backwards and I checked it at both pages.** Ziller's Definition 6.37, at [ziller-lie-groups-reps.txt](https://www2.math.upenn.edu/~wziller/math650/LieGroupsReps.pdf) line 6887, reads *"Let $(G,K)$ be a symmetric pair with $B$ the Killing form of $\mathfrak g$"*, so **Ziller's $B$ IS the Killing form** and his metric is written $\langle\cdot,\cdot\rangle$, as his proof of 6.38(a) shows by concluding $B|_{\mathfrak p}=\lambda\langle\cdot,\cdot\rangle$. Gorodski's $B$ is the $\mathrm{ad}_{\mathfrak k}$-invariant inner product and his Killing form is $\beta$. So **the symbol collides across the two transcriptions while the condition they state is identical**, and both define type by the sign of the Killing form on $\mathfrak p$. The block writes $\beta$ throughout and does not conflate them. **CONFIRMED, with the hazard recorded rather than found realised.**

**The Lean declaration types this step with one hypothesis short of the claim.** I re-ran [L213FactorCompact.lean](../lean/HamiltonsCubic/Results/L213FactorCompact.lean): both declarations elaborate, and `#print axioms` gives `[propext, Classical.choice, Quot.sound]` for each, which is the block's Gate 1 claim exactly. `negDef_of_orthogonal_parts` takes `hx : x ∈ K`, `hy : y ∈ P` and concludes `B (x + y) (x + y) < 0`. **It never needs $V=K\oplus P$ and it never gives negative definiteness on $V$ either**, only negativity on the set of sums. The missing half is that every element of $\mathfrak g_i$ is such a sum, which is the eigenspace argument above and appears in neither the theorem nor the file's prose. So the declaration types the linear algebra of the step and leaves the spanning fact, which is the part a reader would want reassurance about, outside. `hsymm` is legitimate, the Killing form being symmetric.

## 4. Step 4's group, and the round's decisive finding

**Theorem 5.5.1(b) reaches $\mathrm{Inn}(\mathfrak g_i)$, and $\mathrm{Inn}(\mathfrak g_i)$ is not the group that presents $M_i$.** $\mathrm{Inn}(\mathfrak g)$ is the connected subgroup of $\mathrm{Aut}(\mathfrak g)$ generated by the $e^{\mathrm{ad}X}$, so for the connected transvection group $G_i$ with Lie algebra $\mathfrak g_i$ it is $\mathrm{Ad}(G_i)=G_i/Z(G_i)$. Since $\mathfrak g_i$ is semisimple its centre is zero and $Z(G_i)$ is discrete. Hence:

- $\mathrm{Inn}(\mathfrak g_i)$ compact gives $G_i$ compact **if and only if $Z(G_i)$ is finite**, the projection $G_i\to\mathrm{Inn}(\mathfrak g_i)$ being a covering with fibre $Z(G_i)$.
- **That finiteness is Weyl's theorem** (a compact semisimple Lie algebra's simply connected group is compact, equivalently the fundamental group of the adjoint group is finite), and it is cited nowhere in the block, nowhere in either transcription, and nowhere in the record I searched.

**The block's phrase "$M_i=G_i/K_i$ is a quotient of a compact group" therefore names a group it has not shown compact.** $\mathrm{Inn}(\mathfrak g_i)$ does not act on $G_i/K_i$ in general, since $Z(G_i)\cap K_i=0$ by effectiveness of the action, so passing to $G_i/Z(G_i)$ changes the isotropy and $M_i$ only covers the space $\mathrm{Inn}(\mathfrak g_i)$ does act on. Closing that covering is the same finiteness again.

**The source elides the identical step, which is why the citation route is the honest one.** Ziller's printed proof of 6.38(c) ends *"If it is of compact type, then $B<0$ and hence $G$, and thus also $M$, is compact"*, with no argument between $B<0$ and $G$ compact. A citation chain is entitled to a source's conclusion once it lands the source's hypotheses. **So the repair is to cite 6.38(c) for the conclusion, with $K_i$ compact supplied per item 1, and to stop rebuilding the proof from 5.5.1(b)**, which reaches a different group and makes the elision the record's own.

**Two other repairs exist and each costs something the block says it does not spend.**

- **Weyl's finiteness**, one new citation, no new hypothesis. This is the minimal repair and I recommend it alongside the 6.38(c) citation.
- **Myers.** $\widetilde M$ is complete, being a Riemannian covering of a compact hence complete $M$, each factor of a complete product is complete, and L210 gives each factor the same $\lambda$ with L211 giving $\lambda>0$. Myers then makes $M_i$ compact in one line, with no group theory at all. **The record struck Myers as "owed by neither route" at [L210](../findings/problem.md) line 312 and in [r918](REVIEW_r918.md)'s section 10, on the ground that "compactness of the factors follows from compact type once that is established"**, and that ground is the very step now found unargued. So the strike was premature, and Myers is in fact the cheapest closure available to this lemma.

**GAP.** The conclusion is true, and the written support does not reach it.

## 5. $K_i$ compact and closed, and why the clause is decoration

**The clause as written is true and in the wrong order.** *"$K_i$ the isotropy group, compact as a closed subgroup fixing a point"* works only after $G_i$ is compact: the isotropy group of a continuous action on a Hausdorff space is closed, and a closed subgroup of a compact group is compact. So it is a consequence of step 4's conclusion and not an input to it.

**It is not load-bearing for step 4 as the block runs it.** A quotient of a compact topological group by any subgroup is compact, the quotient map being continuous and surjective, and neither closedness nor compactness of $K_i$ enters. The block's own note says this and `quotient_compactSpace` types it. **Cheaper still, the presentation is unnecessary**: a transitive continuous action of a compact group on a Hausdorff space makes the space a continuous image of the group, hence compact, so global symmetry of $M_i$ plus $G_i$ compact is already enough.

**Faithfulness of the isotropy representation is needed nowhere here.** It is what Gorodski's page uses to justify the OIL effectiveness clause geometrically ([notes.md](../references/gorodski-symmetric-spaces-intro/notes.md) line 11), so it belongs to item 2's clause and not to this one.

**The warning attached to this item.** If the repair chosen is to cite 6.38(c), then $K_i$ compact becomes a hypothesis and deriving it from $G_i$ compact is circular. Item 1's route through Myers--Steenrod is independent of $G_i$ and does not close the loop. **CONFIRMED as written, with the direction of the implication flagged.**

## 6. Step 5, and what the census actually consumes

**Step 5 is exact.** The covering $\pi\colon\widetilde M\to M$ is a local isometry, so $R$, and with it $W$, at any lift is the pullback of $R$ and $W$ at the point, and $\theta=P(W)/\lVert W\rVert^3$ is a pointwise algebraic invariant of $W$ alone. Both spaces are homogeneous, $M$ by global symmetry and a product of homogeneous factors likewise, so $\theta$ is a number rather than a function on each, and the two numbers agree. Nothing about products is needed for this and nothing about compactness. **CONFIRMED as a step.**

**The claim wrapped around it does not hold.** The statement's rider says *"L47's census, which is of compact spaces, applies to each factor by name, and L48's product argument is entitled to its objects"*. Taking those in turn:

- **L47 per factor needs $W_a\ne0$, which L213 does not deliver.** L211 and L213 carry $W\ne0$ for $M$, hence for $\widetilde M$, and a single factor may perfectly well have $W_a=0$, a round $S^{n_a}$ being the standard case, where L47's $\theta$ is $0/0$ and the census says nothing. So the census does not apply to each factor by name.
- **At $r\ge2$ nothing needs the factors compact.** [L48](../findings/problem.md) bounds $\lVert W\rVert^2=\sum_a\lVert W_a\rVert^2+B\ge B$ and reads $B$ off the partition. That chain uses each factor Einstein with the shared constant (L210's step 4 plus L211), $n_a\ge2$, and $\lVert W_a\rVert^2\ge0$ with equality exactly at constant curvature. **Compactness of a factor enters none of it**, all four being pointwise curvature statements.
- **$n_a\ge2$ is available and unstated.** A one-dimensional $\mathfrak p_i$ has $[\mathfrak p_i,\mathfrak p_i]=0$ and is Euclidean, which L210 excludes, so every surviving factor has $n_a\ge2$. [r918](REVIEW_r918.md) recorded the same point at L210.

So the entitlement to L48 is real and the entitlement to L47 per factor is not. **GAP on the rider, the step itself being CONFIRMED.**

## 7. Simple connectivity

**Established, and in one line.** $\widetilde M$ is a universal cover, so simply connected, and $\pi_1(\prod_iM_i)\cong\prod_i\pi_1(M_i)$, so every factor has trivial $\pi_1$. The de Rham theorem gives the product decomposition and simple connectivity of the factors comes from $\widetilde M$'s, not from de Rham.

**What needs it.** Step 2's splitting statement needs $\widetilde M$ simply connected, which is why the universal cover is taken at all, and Gorodski's numbered form of that statement, Theorem 2.3.8 at [gorodski-symmetric-spaces.txt](https://www.ime.usp.br/~gorodski/ps/symmetric-spaces.pdf) line 1471, is stated for simply connected spaces and identifies the factors with the classification tables. **Proposition 6.38(c) needs no simple connectivity at all**, which the record's Ziller notes say and which the printed proof confirms, and 6.38(b) is the clause that needs it. **CONFIRMED.**

**An available upgrade to step 2's citation.** The block cites the unnumbered introduction prose at [gorodski-symmetric-spaces.txt](https://www.ime.usp.br/~gorodski/ps/symmetric-spaces.pdf) line 45, and the same source carries the numbered Theorem 2.3.8 for the same statement, untranscribed. The transcription's own note explains the choice of the algebraic route by the prose carrying no theorem number, and that reason lapses at line 1471.

## 8. The inventory of what the lemma spends

**The block claims that steps 2 to 4 use only compact type and the effectiveness clause. That is REFUTED, and by its own step 2.**

- **Global symmetry of $M$ is spent in step 2, directly.** Gorodski's *symmetric space*, and the statement quoted in step 2, are the GLOBAL notion, geodesic symmetries being isometries of the whole space. A locally symmetric space has no universal cover that is a symmetric space in that sense without it. So *globally symmetric* is a hypothesis of step 2 and not something spent inside L211, and the block's sentence that L211 is *"where they were already spent"* is wrong for global symmetry. Compactness of $M$ is indeed used only through L211, as the block says.
- **Global symmetry of each factor** is used again in step 4, to have $M_i=G_i/K_i$ at all, which is Proposition 1.5.1 and is stated for globally symmetric spaces. That each de Rham factor of a globally symmetric space is globally symmetric is true, the symmetry splitting along the factors, and it is asserted nowhere.
- **The identification of the de Rham factors with 2.1.3's ideals**, per item 2, on which every use of compact type and effectiveness rests.
- **Connectedness of $M$**, without which "the de Rham decomposition of its universal cover" names nothing.
- **Finite dimension**, carried by the OIL definition and by the trace arguments in 2.1.2(b) and 5.5.1.
- **Homogeneity of $M$ and $\widetilde M$** in step 5, for $\theta(M)$ and $\theta(\widetilde M)$ to be numbers rather than functions.
- **Weyl's finiteness theorem** at step 4, per item 4, which is the missing link rather than an unlisted input.

**Completeness is not on the list and is not needed as the block runs.** It would be needed by the Myers repair of step 4, and it is available there from compactness of $M$.

## 9. The $\mathbb{CH}^m\times\mathbb{CH}^m$ witness

**Every clause checks, and the witness survives the trap that sank its predecessor.**

- **It exists.** Cocompact lattices exist in $\mathrm{PU}(m,1)$, so pick a torsion-free one, $\Gamma_1$, and set $N=\mathbb{CH}^m/\Gamma_1$, a closed complex-hyperbolic manifold. Then $M'=N\times N$ is a compact quotient of $\mathbb{CH}^m\times\mathbb{CH}^m$ by $\Gamma_1\times\Gamma_1$. Reducible lattices suffice, so no irreducibility question arises.
- **It is compact**, being a product of two compact manifolds.
- **Its de Rham factors are noncompact.** Its universal cover is $\mathbb{CH}^m\times\mathbb{CH}^m$, whose de Rham factors are two copies of $\mathbb{CH}^m$, each diffeomorphic to $\mathbb R^{2m}$ and noncompact.
- **At $m\ge2$ it is also Einstein with $W\ne0$** under equal normalisation of the two factors, $\lVert W\rVert^2>0$ following from the record's own $\mathbb{CP}^m$ closed form at [L47](../findings/problem.md) by duality, which is [r921](REVIEW_r921.md)'s repair of L211's witness. So it does not fail the way the withdrawn closed hyperbolic manifold failed, on $W=0$.

**It is outside L213's hypotheses**, having $\lambda<0$ and no transitive isometry group, and that is exactly what makes it a valid demonstration that compactness of $M$ alone cannot reach step 4. **CONFIRMED.**

## 10. It is already on the record, the argument included

**The claim stands unargued in three places that predate the lemma.**

- [problem.md](../findings/problem.md) line 312, in L210's block: *"compactness of the factors follows from compact type once that is established"*, offered as the reason Myers is owed by neither route.
- [INDEX-results.md](../findings/INDEX-results.md) row 210, carrying the same sentence.
- [r918](REVIEW_r918.md) section 10: *"the factors of a compact-type algebra are compact automatically (classes 1 and 2 have compact $\tilde G$)"*. That parenthetical is the Weyl fact of item 4, named once and never again.

**And the argument is on the record too.** [r921](REVIEW_r921.md) section 11 writes the chain out: *"Compact type does give compactness, since $\beta$ is then negative definite on $\mathfrak k$ by 2.1.2(b) and on $\mathfrak p$ by the type, hence on $\mathfrak g$, so $\mathfrak g$ is compact semisimple, its transvection group is compact and $M=G/K$ is compact. Nothing on file says this."* **Steps 3 and 4 of L213 are that sentence expanded**, and they inherit its one weak link, *"its transvection group is compact"*. The block credits r921 with leaving the clause owed and does not record that r921 also supplied the route, which matters because an independent second look at the route is then what Gate 2 owes rather than what it has had. **CONFIRMED that it is on the record**, and what L213 adds is a canonical home and the Ziller citation.

## 11. What it closes, and what stays open

**The lemma closes the one-factor branch and that is a real closure.** At $r=1$, $\widetilde M=M_1$ is irreducible and $\theta(M)=\theta(M_1)$, and L47's census is over compact irreducible symmetric spaces, so $M_1$ must be compact for $M$ to be covered. $W(M_1)\ne0$ transfers from $M$ by local isometry, so L47's hypotheses are all met on $M_1$: compact, irreducible, symmetric, $W\ne0$. **That branch is where L213 is indispensable**, and it is also the branch that makes non-simply-connected $M$ reachable, $\theta$ being a local invariant.

**The multi-factor branch never needed it**, per item 6. So the claim that L213 is *the Theorem's last owed clause* overstates its role at $r\ge2$ and states it correctly at $r=1$.

**Outstanding against the Theorem after this lemma.**

- **The word *globally***, which the block records and which is the Theorem's debt rather than the lemma's. A compact $\mathbb{CH}^6$ quotient sits in the gap at $n=12$.
- **L47's own two open items**, which L213 hands work to and does not touch: the monotonicity of the $\mathbb{CP}^m$ and $\mathbb{HP}^m$ closed forms on $m\ge2$, recorded as owed in L47's own banner, and the completeness of the type-I classification list, which the record says no source on file gives.
- **Step 4's missing link**, per item 4, which is against this lemma.

## 12. What would break it, and what I did to look

**The falsifier would be a compact globally symmetric Einstein space with $W\ne0$ one of whose de Rham factors of the cover is noncompact.** Such a factor is Euclidean, of noncompact type, or of compact type and noncompact. L210 removes the first at $\lambda\ne0$, L211 removes the second, and the third would refute Proposition 6.38(c) itself.

**Three routes tried, each closes.**

- **A connected Lie group with compact semisimple Lie algebra that is noncompact.** None exists, by Weyl's finiteness, which is why item 4 is a gap in the writing and not a falsification. Had $Z(G_i)$ been able to be infinite, step 4 would have been refuted rather than short.
- **An isotropy group $K_i$ failing to be compact.** Blocked by Myers--Steenrod at [gorodski-symmetric-spaces.txt](https://www.ime.usp.br/~gorodski/ps/symmetric-spaces.pdf) line 568, which holds for the isometry group of any Riemannian manifold.
- **A de Rham factor of a globally symmetric space failing to be globally symmetric**, which would deny $M_i$ an OIL-algebra and break step 2 at the root. The geodesic symmetry at a product point splits along the factors by uniqueness of the de Rham decomposition, so each factor carries its own, and the route closes.

**No falsifier found.** The one place I expected one, an infinite centre at step 4, is exactly where the missing citation lives.

## Verdict for L213 as a whole

**CONFIRMED as a statement and GAP as a citation chain.** Every $M_i$ is a compact simply connected irreducible symmetric space of compact type and $\theta(M)=\theta(\widetilde M)$, and the argument on disk does not reach the compactness clause: step 4 stops at $\mathrm{Inn}(\mathfrak g_i)$, which is not the group presenting $M_i$.

**Four repairs, in the order I recommend them.**

1. **Cite Proposition 6.38(c) for the conclusion** rather than rebuilding it, and transcribe Gorodski §1.5 to supply $K_i$ compact, which is the hypothesis Definition 6.31 demands and the record lacks. Add Weyl's finiteness where the block keeps the $\mathrm{Inn}(\mathfrak g_i)$ route, since the source elides the same step.
2. **Correct the hypothesis inventory**: global symmetry is spent in step 2 as well as inside L211, and the identification of the de Rham factors with 2.1.3's ideals is an unstated input on which the whole chain rests.
3. **Withdraw "L47's census applies to each factor by name"**, L47 needing $W_a\ne0$ per factor, and say instead that L213 closes the irreducible branch while L48's bound needs no factor compactness.
4. **Add the two available one-liners**: $\mathfrak g_i=\mathfrak k_i\oplus\mathfrak p_i$ from 2.1.3(a), which step 3 needs and the Lean declaration does not carry, and $\beta_{\mathfrak g}|_{\mathfrak g_i}=\beta_{\mathfrak g_i}$, which Corollary 5.5.2's application needs and which the record has now wanted twice.

**On the Lean.** Both declarations elaborate and both rest on `[propext, Classical.choice, Quot.sound]` only, so Gate 1's claim is accurate. `negDef_of_orthogonal_parts` types the step's arithmetic and leaves the spanning fact outside, so it is short of "negative definite on $\mathfrak g_i$". `quotient_compactSpace` is `inferInstance`, a Mathlib instance restated, so it carries no content of its own beyond recording which instance the step uses, and the step it stands for is not the step where the difficulty is.

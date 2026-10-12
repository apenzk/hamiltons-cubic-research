# REVIEW r924, L213, every irreducible factor of the universal cover is compact

The round read a written citation chain link by link and asked of each step whether it follows from the step above it and from the hypotheses actually stated. Read: the [L213 block](../findings/problem.md) with [L210](../findings/problem.md), [L211](../findings/problem.md), [L47](../findings/problem.md) and [L48](../findings/problem.md) around it, both transcriptions ([Gorodski](../references/gorodski-symmetric-spaces-intro/notes.md), [Ziller](../references/ziller-2010-lie-groups-symmetric-spaces/notes.md)), Ziller's Definition 6.31, Definition 6.37 and Proposition 6.38 with its proof verbatim from [ziller-lie-groups-reps.txt](https://www2.math.upenn.edu/~wziller/math650/LieGroupsReps.pdf) lines 6748 and 6895, the two Lean declarations in [L213FactorCompact.lean](../lean/HamiltonsCubic/Results/L213FactorCompact.lean), and the record's own index entries for the lemma in [LEDGER.md](../findings/LEDGER.md), [INDEX-results.md](../findings/INDEX-results.md) and [results.md](../results.md). No computation was run and none was needed. Log: [agent_logs/gate2-l213-r924.log](../agent_logs/gate2-l213-r924.log).

| # | Item | Verdict | Reason |
|---|---|---|---|
| 1 | Proposition 6.38(c) applicable hypothesis by hypothesis | GAP | $K_i$ compact is a hypothesis of Ziller's Definition 6.31 and nothing on the record supplies it, while steps 2 to 4 never use 6.38(c) at all |
| 2 | Effectiveness inherited by each summand | CONFIRMED | true and two lines from the summands being commuting ideals, where the block instead reads it off the source's word *irreducible* |
| 3 | Step 3's linear algebra, and $B$ against $\beta$ | CONFIRMED | $\mathfrak g_i=\mathfrak k_i\oplus\mathfrak p_i$ comes from $s$-invariance and the cross term vanishes bilinearly, and the block writes $\beta$ throughout so the two meanings of the letter $B$ never meet |
| 4 | Step 4's group | GAP | $\mathrm{Inn}(\mathfrak g_i)$ is not the group that presents $M_i$, $S^3$ with $SO(4)$ over $SO(3)\times SO(3)$ being the witness, and Corollary 5.5.2's semisimplicity hypothesis is never checked |
| 5 | $K_i$ compact and closed | CONFIRMED | closed as the preimage of a point under the orbit map, compact once $G_i$ is, and step 4's conclusion needs neither |
| 6 | Step 5, $\theta$ on the cover | CONFIRMED | pointwise algebraic invariant under a local isometry, and it is a transfer rather than a bound, with L48 the consumer at $r\ge2$ |
| 7 | Simple connectivity of the factors | CONFIRMED | $\pi_1$ of a product is the product of the $\pi_1$, so each factor of a simply connected product is simply connected |
| 8 | The inventory of hypotheses | REFUTED | steps 2 to 4 additionally use completeness, simple connectivity of the cover, and homogeneity of each factor, so global symmetry is spent again here and not only inside L211 |
| 9 | The offered counterexample | CONFIRMED | a product of two cocompact torsion-free lattices in $PU(m,1)$ gives a compact quotient of $\mathbb{CH}^m\times\mathbb{CH}^m$ whose de Rham factors are noncompact |
| 10 | Already on the record | CONFIRMED | new as an argument, with the bare assertion standing unargued at [problem.md](../findings/problem.md) line 312 and the full chain already written into the Gorodski notes at Proposition 2.2.1(b) |
| 11 | Does it close what it claims | GAP | L47 also needs $W_i\ne0$ per factor, which this lemma does not deliver and which fails at $S^{n/2}\times S^{n/2}$ |
| 12 | What would break it | ANSWERED | the live falsifier is a de Rham factor that is not one of Proposition 2.1.3's summands, since that is what carries the type across |

**Summary.** The conclusion stands and is true, and four repairs are owed: step 4's group, Corollary 5.5.2's unchecked semisimplicity, the hypothesis inventory, and the identification of the de Rham factors with Proposition 2.1.3's summands.

## 1. Proposition 6.38(c), hypothesis by hypothesis

Ziller's Definition 6.31 reads, verbatim from line 6748 of the extraction: *"$(G,K,\sigma)$ is called a symmetric pair if $K$ is compact, $\sigma$ is an involution of $G$ with $G^\sigma_0\subset K\subset G^\sigma$, and $G$ acts almost effectively on $G/K$."* Remark 6.32 then identifies almost effective with *"$\mathfrak g$ and $\mathfrak p$ do not have any ideal in common"*, which the proof of 6.38(c) uses in the form *"$\mathfrak g$ and $\mathfrak k$ have no ideals in common"*, so the printed $\mathfrak p$ is a typo for $\mathfrak k$ and the clause is the OIL effectiveness clause.

Against $(G_i,K_i)$:

- **Almost effectiveness is supplied**, by item 2 below, since effectiveness of $(\mathfrak g_i,s_i,B_i)$ is exactly that clause.
- **The involution is supplied**, $s_i$ being $s|_{\mathfrak g_i}$ with $\mathfrak g_i$ $s$-invariant by Proposition 2.1.3(a), and the group-level $\sigma_i$ being the geodesic symmetry of the factor.
- **Compact type in Ziller's sense is supplied**, his Definition 6.37 being stated for the Killing form, which for an ideal of a direct sum restricts from the Killing form of $\mathfrak g$.
- **$K_i$ compact is NOT supplied by anything on the record.** Gorodski's Corollary 2.4.7 gives a maximal compact isotropy group only for noncompact type, which is the opposite case. The honest source is properness of the isometric action of a complete Riemannian manifold, so $K_i$ compact follows from completeness of $M_i$, which follows from $M$ compact. That chain is nowhere written, and it is not free, because it spends completeness (see item 8).

The deeper point is that **steps 2 to 4 do not use 6.38(c)**. They rebuild its proof out of Gorodski's Lemma 2.1.2, Corollary 5.5.2 and Theorem 5.5.1(b), which is why the missing $K_i$ compact does no damage to the argument: Lemma 2.1.2(b) delivers $\beta|_{\mathfrak k_i}<0$ from effectiveness alone, where Ziller's proof of the same sign goes through compactness of $K$. So the lemma is a derivation wearing the label of a citation. That label is repeated in the block's preamble, in [LEDGER.md](../findings/LEDGER.md), in [INDEX-results.md](../findings/INDEX-results.md) and twice in [results.md](../results.md), and it is the one clause of the write-up that an outside reader would check first.

## 2. Effectiveness is genuinely inherited, and the derivation is two lines

The block grounds it on the summands being called OIL-algebras. That reading is legitimate, since Gorodski defines *irreducible* only for an OIL-algebra and 2.1.3(c) calls each $(\mathfrak g_i,s_i,B_i)$ irreducible, so effectiveness is part of what the source asserts. It is also derivable, and the derivation is better, because it does not depend on how much the source packs into a word:

Let $\mathfrak a\subseteq\mathfrak k_i$ be an ideal of $\mathfrak g_i$. The $\mathfrak g_j$ are ideals of an internal direct sum, so $[\mathfrak g_j,\mathfrak g_i]=0$ for $j\ne i$, whence $[\mathfrak g,\mathfrak a]=[\mathfrak g_i,\mathfrak a]\subseteq\mathfrak a$ and $\mathfrak a$ is an ideal of $\mathfrak g$. And $\mathfrak a\subseteq\mathfrak k_i\subseteq\mathfrak k$. Effectiveness of $(\mathfrak g,s,B)$ therefore gives $\mathfrak a=0$. $\square$

This matters more than the block says, for two reasons. First, **Lemma 2.1.2(b) is definiteness rather than semidefiniteness, and effectiveness is what makes it definite**: the standard proof gives $\beta(X,X)=\operatorname{tr}\mathrm{ad}_X^2\le0$ for $X\in\mathfrak k$ with equality exactly on $\mathfrak z(\mathfrak g)\cap\mathfrak k$, which is an ideal inside $\mathfrak k$. Step 3 therefore rests on item 2 and not only on step 2's citation. Second, the record has already paid once for this clause, at [L210](../findings/problem.md) step 3, where $\mathfrak p_0=0$ reaches $\mathfrak g_0=0$ through it and nothing else.

## 3. Step 3 is right, and the letter $B$ carries two meanings that the block avoids

**The decomposition is available.** $\mathfrak g_i$ is $s$-invariant, so $s|_{\mathfrak g_i}$ is an involution of $\mathfrak g_i$ and $\mathfrak g_i=(\mathfrak g_i\cap\mathfrak k)\oplus(\mathfrak g_i\cap\mathfrak p)=\mathfrak k_i\oplus\mathfrak p_i$ by eigenspace decomposition of an involution on a space it preserves. No further hypothesis enters.

**The cross term vanishes for every pair.** Lemma 2.1.2(a) is a statement about subspaces, $\beta(\mathfrak k,\mathfrak p)=0$, so for $X=X_{\mathfrak k}+X_{\mathfrak p}$ bilinearity gives $\beta(X,X)=\beta(X_{\mathfrak k},X_{\mathfrak k})+2\beta(X_{\mathfrak k},X_{\mathfrak p})+\beta(X_{\mathfrak p},X_{\mathfrak p})=\beta(X_{\mathfrak k},X_{\mathfrak k})+\beta(X_{\mathfrak p},X_{\mathfrak p})<0$ unless both parts vanish. Nothing is restricted to eigenvectors of anything.

**One identification is used and not stated.** Lemma 2.1.2(b) applied to the OIL-algebra $(\mathfrak g_i,s_i,B_i)$ speaks of the Killing form of $\mathfrak g_i$, while L211 delivers the sign of the Killing form of $\mathfrak g$ on $\mathfrak p_i$. These agree because $\mathfrak g_i$ is an ideal with $[\mathfrak g_i,\mathfrak g_j]=0$ for $j\ne i$, so $\mathrm{ad}_X$ for $X\in\mathfrak g_i$ annihilates the other summands and the trace over $\mathfrak g$ equals the trace over $\mathfrak g_i$. One clause would close it.

**On $B$ against $\beta$.** The brief supposes Ziller's $B$ to be metric-related. It is not: Definition 6.37 says *"with $B$ the Killing form of $\mathfrak g$"*, verbatim at line 6887, so Ziller's type condition and Gorodski's are the same condition. The letter collision is between Ziller's $B$, the Killing form, and Gorodski's OIL $B$, a positive definite inner product on $\mathfrak p$. Corollary 3.1.4's $B=\lambda\beta|_{\mathfrak p}$ is what ties them, and $B$ positive definite makes $\lambda<0$ equivalent to $\beta|_{\mathfrak p}<0$, which is the type. **The block is immune because step 3 is written in $\beta$ throughout.** No finding.

**The Lean declaration types part of the step and not the step.** [negDef_of_orthogonal_parts](../lean/HamiltonsCubic/Results/L213FactorCompact.lean) concludes `B (x + y) (x + y) < 0` for `x ∈ K` and `y ∈ P`, so it never needs `V = K ⊔ P` and it never delivers it. Negative definiteness on all of $\mathfrak g_i$ is the conjunction of that inequality with surjectivity of $\mathfrak k_i\times\mathfrak p_i\to\mathfrak g_i$, and the surjectivity is the $s$-eigenspace argument above, which stays in prose. So the answer to the brief's question is: the declaration is correctly stated without the direct sum, and precisely for that reason it types the pointwise inequality rather than the definiteness claim. Independence $K\cap P=0$ is also absent and is correctly absent, the hypothesis `hne : x + y ≠ 0` doing that work. The proof is honest, `hexp` expanding the form and `linarith` closing the three cases.

**And the second declaration is a Mathlib instance restated.** [quotient_compactSpace](../lean/HamiltonsCubic/Results/L213FactorCompact.lean) is proved by `inferInstance`, so its content is Mathlib's instance that a topological quotient of a compact group is compact. It types step 4's last inch truthfully and adds no mathematics. The load-bearing part of step 4, that $G_i$ is compact, is typed nowhere, which the file's own docstring says.

## 4. Step 4's group is the wrong group, and one hypothesis is unchecked

Two defects, both repairable, neither touching the conclusion.

**Corollary 5.5.2's hypothesis is semisimplicity and step 4 does not check it.** The corollary reads *"a semisimple Lie algebra is compact if and only if its Killing form is negative definite"*. Step 4 writes *"Corollary 5.5.2 makes $\mathfrak g_i$ a compact Lie algebra"* from step 3's sign alone. The hypothesis is available twice over, from Corollary 2.1.5 (*"$\mathfrak g$ is semisimple if and only if $(\mathfrak g,s,B)$ has no Euclidean factor"*) applied to the irreducible $(\mathfrak g_i,s_i,B_i)$, which is the citation [L211](../findings/problem.md) step 3 already makes for the same purpose, and from Cartan's criterion, a negative definite Killing form being nondegenerate. It is not optional: the abelian $\mathfrak g=\mathbb R$ has $\beta=0$, which is not negative definite, and the point of the check is exactly to exclude a centre, which is the failure mode of the whole step.

**$\mathrm{Inn}(\mathfrak g_i)$ is not the group that presents $M_i$.** Theorem 5.5.1(b) gives compactness of $\mathrm{Inn}(\mathfrak g_i)$, the adjoint group. The group that acts transitively on $M_i$ is the transvection group $G_i$, and that is a connected group with Lie algebra $\mathfrak g_i$, hence a cover of the adjoint group, possibly proper. **$S^3$ is the witness**: it is a compact simply connected irreducible symmetric space, its transvection group is $SO(4)$, and $\mathrm{Inn}(\mathfrak{so}(4))=SO(3)\times SO(3)$, which $SO(4)$ double covers. So *"$M_i=G_i/K_i$ is a quotient of a compact group"* names a compact group that is not the one in the quotient.

The conclusion survives, by either of two repairs, and the block is entitled to neither as written:

- **Weyl.** $\mathfrak g_i$ compact and semisimple makes the simply connected group $\tilde G_i$ compact, so every connected group with that algebra, $G_i$ among them, is a quotient of a compact group and compact. This is the finiteness of the fundamental group of a compact semisimple group, and nothing on the record cites it.
- **Ziller's own conclusion.** Proposition 6.38(c) concludes *"$G$ is semisimple and $G$ and $M$ are compact"* for the pair itself, bypassing $\mathrm{Inn}$ entirely. Its proof does the same thing in one clause, *"then $B<0$ and hence $G$, and thus also $M$, is compact"*, so the source glosses the covering question rather than settling it. Taking this route costs the $K_i$ compact hypothesis of item 1.

**Recommendation: take Weyl.** It repairs the existing chain with one sentence, keeps the argument inside the derivation the block actually performs, and avoids reopening item 1's unsupplied hypothesis.

## 5. $K_i$ is closed and compact, and step 4 needs neither

$K_i=\{g\in G_i:g\cdot x_i=x_i\}$ is the preimage of $\{x_i\}$ under the continuous map $g\mapsto g\cdot x_i$ into a Hausdorff space, hence closed. Once $G_i$ is compact, a closed subgroup of it is compact, so the block's sentence is correct as stated. **It is also idle**: $M_i=G_i/K_i$ is the image of the compact $G_i$ under the quotient map, so compactness of the quotient follows for any subgroup whatever, which is what the Lean note and Mathlib's instance both say. The whole load of step 4 sits on $G_i$ compact, which is item 4.

**Faithfulness of the isotropy representation is not needed here.** It is what makes the geometric OIL-algebra effective, per the Gorodski notes, so it stands behind item 2 and behind Lemma 2.1.2(b), and it plays no part in closedness or compactness of $K_i$.

## 6. Step 5 is correct, and it is a transfer rather than a bound

$P(W)=\langle W,Q(W)\rangle$ and $\lVert W\rVert$ are pointwise algebraic invariants of the curvature at a point, the covering $\widetilde M\to M$ is a local isometry, so $W$ at $x$ and $W$ at any lift $\tilde x$ correspond under the isometry of tangent spaces and $\theta$ agrees. Both spaces are locally symmetric, so $W$ is parallel and $\theta$ is constant on each, which is what makes $\theta(M)$ and $\theta(\widetilde M)$ numbers at all. No finding.

**What the census consumes is $\theta(\widetilde M)$, and $\widetilde M$ is a product, so the consumer is L48 and not L47 per factor.** $\theta$ of a product is not the maximum of the factors' $\theta$, and [L48](../findings/problem.md) is explicit about it, $\lVert W\rVert^2=\sum_a\lVert W_a\rVert^2+B$ with $B$ a function of the partition. The block's own wording, *"L48's product argument is entitled to its objects"*, has the structure right. The entitlement holds: L48 needs $k\ge2$ factors each Einstein with one shared constant and $n_a\ge2$, the shared constant comes from [L210](../findings/problem.md) step 4 applied to $\widetilde M$, which is locally symmetric and Einstein because $M$ is, and $n_a\ge2$ holds because a one-dimensional factor is flat and so of Euclidean type, excluded at $\lambda\ne0$. And $\dim\widetilde M=\dim M=n$, so the partition L48 consumes is a partition of the right integer. Step 5 is therefore enough for what L48 needs, and the sentence about L47 is item 11.

## 7. Simple connectivity of each factor is free

$\widetilde M=\prod_iM_i$ with every factor path connected, so $\pi_1(\widetilde M)\cong\prod_i\pi_1(M_i)$, and a trivial product of groups has trivial factors. Each $M_i$ is simply connected. De Rham gives the product decomposition of $\widetilde M$, and simple connectivity of the factors is this one-line consequence rather than a further input.

It is used. Gorodski's splitting prose is stated for a simply connected symmetric space, and Ziller's 6.38(b) says *"if $M=G/K$ is simply connected"* and proves the splitting from Corollary 6.12. Clause (c), the one the block names, needs no simple connectivity, which the Ziller notes already record.

## 8. The inventory is wrong, and the conclusion is untouched

The block says compactness of $M$ and global symmetry are spent inside L211 and that *"steps 2 to 4 use only compact type and the effectiveness clause"*. Steps 2 to 5 in fact use, beyond those two:

- **Completeness**, so that $M$ has a universal cover that is a complete symmetric space and de Rham applies. It comes from $M$ compact, so compactness of $M$ is spent again here, in a different currency from L211's.
- **Simple connectivity of $\widetilde M$**, which is what licenses the splitting in step 2 and which item 7 shows the statement's own *simply connected* clause then inherits.
- **Homogeneity of each factor**, which is the sharpest omission. Step 4 writes $M_i=G_i/K_i$, and that presentation exists because $M_i$ is globally symmetric, which holds because $\widetilde M$ is (the universal cover of a symmetric space being symmetric, which is the prose the block quotes) and because a Riemannian product is homogeneous factorwise. **So global symmetry is spent at step 4 and not only inside L211.** A compact-type OIL-algebra alone gives an algebra, not a transitive action.
- **Semisimplicity of $\mathfrak g_i$**, item 4, which is a further citation rather than a consequence of compact type and effectiveness.
- **Finite dimension**, which the OIL definition carries explicitly (*"a real finite-dimensional Lie algebra"*) and which in the application comes from $M$ being a finite-dimensional manifold. Traces and definiteness arguments need it, and Theorem 5.5.1 is a statement about finite-dimensional Lie algebras.

The sentence is therefore false as an accounting, which is what the verdict records. **What is true, and is what the block seems to mean, is the useful thing**: the lemma introduces no hypothesis beyond those already in its own statement, and in particular compactness of $M$ is never used as compactness of $M$ to reach compactness of a factor, which is the point item 9 defends.

## 9. The witness is genuine, clause by clause

- **It exists.** Cocompact torsion-free lattices $\Gamma_1,\Gamma_2\subset PU(m,1)$ exist for every $m\ge1$, by the standard arithmetic constructions, and $\Gamma_1\times\Gamma_2$ acts freely and cocompactly on $\mathbb{CH}^m\times\mathbb{CH}^m$ by isometries.
- **It is compact.** The quotient of a cocompact free proper action is a closed manifold.
- **Its de Rham factors are noncompact.** The universal cover is $\mathbb{CH}^m\times\mathbb{CH}^m$ and each $\mathbb{CH}^m$ is irreducible of noncompact type, diffeomorphic to $\mathbb R^{2m}$.
- **It meets the lemma's other hypotheses except the type.** $\mathbb{CH}^m$ is Einstein, the two factors carry the same constant because they are isometric, so the product is Einstein with $\lambda<0$, and $W\ne0$ because the mixed blocks of a product of two Einstein factors with a common constant carry $-c\,\mathrm{Id}$ with $c\ne0$, the $B$ term of L48.
- **It fails global symmetry**, being a non-homogeneous compact locally symmetric space, and it fails $\lambda>0$.

So the witness does the job it is offered for: compactness of $M$ plus the de Rham splitting does not reach compactness of the factors, and no argument at step 4 may be read as coming from $M$'s own compactness. Unlike the witness withdrawn at [L211](../findings/problem.md), this one is not excluded by $W\ne0$, and its shape is the same as the $\mathbb{CH}^6$ quotient the record uses against the local reading, which is consistent.

## 10. The statement is on the record twice already, unargued both times

- **[problem.md](../findings/problem.md) line 312**, inside the L210 block and credited to [r918](../reviews/REVIEW_r918.md): *"compactness of the factors follows from compact type once that is established"*. That is L213's conclusion asserted with no argument and no citation, one lemma away.
- **The Gorodski notes**, in the section headed *"The compact-type statements, which carry each factor's own compactness"*, which was filed against this question and already carries the whole chain, including one statement the block does not use. **Proposition 2.2.1(b)** says that for an irreducible OIL-algebra precisely one of $\mathfrak g$, $\mathfrak g^*$ is compact, and the note under it spells out step 3 and half of step 4 in one sentence, *"compact type is exactly $\mathfrak g$ being a compact Lie algebra rather than a separate condition"*. Citing 2.2.1(b) would replace step 3 and the 5.5.2 step, and it carries no semisimplicity hypothesis to check.
- **[REVIEW_r921](../reviews/REVIEW_r921.md) and the Ziller [README](../references/ziller-2010-lie-groups-symmetric-spaces/README.md)** record the clause as owed and name 6.38(c) as the answer, which is where the lemma's framing comes from.

So the lemma is new as an argument and not as a claim, and the block should link the L210 aside and Proposition 2.2.1(b). No verdict against the mathematics.

## 11. It closes the bridge and the sentence about L47 over-reaches

L47's quantifier is *every compact irreducible symmetric space with $W\ne0$*. Against a factor $M_i$:

- **compact**, now supplied by this lemma, which is the point of it,
- **irreducible symmetric**, supplied by step 2,
- **$W_i\ne0$, NOT supplied.** $M$ has $W\ne0$ and a single factor may still have $W_i=0$. The record's own equality case is the example: at $S^{n/2}\times S^{n/2}$ each factor has constant curvature and $W_a=0$, and L47 excludes exactly that, *"$S^n$ and $\mathbb{RP}^n$ have $W=0$, which is why $W\ne0$ is a hypothesis and not a remark"*.

So *"L47's census applies to each factor by name"*, which stands in the block, in [INDEX-results.md](../findings/INDEX-results.md) and in [results.md](../results.md), is too strong. **No damage follows**, because the product case never needs L47 per factor: L48 uses only $\lVert W_a\rVert^2\ge0$ with the vanishing case characterised as constant curvature, and L47 is consumed at $r=1$, where $W_1=W\ne0$ holds by hypothesis. The repair is to say that L47 applies to an irreducible cover, $r=1$, and that L48 consumes the factors at $r\ge2$.

**What remains outstanding against the Theorem**, after this lemma:

- **The word *globally***, which the block records and which is the $\mathbb{CH}^6$ quotient at $n=12$. Unchanged by this lemma.
- **The identification of the de Rham factors with Proposition 2.1.3's summands**, item 12, which is what carries L211's type statement onto the geometric factors.
- **L47's own two debts**, the monotonicity of the $\mathbb{CP}^m$ and $\mathbb{HP}^m$ closed forms on $m\ge2$ and the completeness of the type-I classification list with the twelve exceptional dimensions, both already recorded there.

## 12. What would break it, and what I did to look

**The live falsifier is a de Rham factor that is not one of Proposition 2.1.3's summands.** Step 2 asserts *"each $M_i$ carries the OIL-algebra $(\mathfrak g_i,s_i,B_i)$ of Proposition 2.1.3's decomposition"*, and that identification is what transports L211's conclusion, which is about the algebraic summands, onto the geometric factors of $\widetilde M$. If the two decompositions differed, a de Rham factor could carry a mixture of summands and the words *irreducible of compact type* would not attach to it. The identification is true, the geometric factors of a symmetric space each being symmetric with an irreducible OIL-algebra whose sum is an OIL decomposition of $\mathfrak g$, matched to 2.1.3's by the uniqueness of Remark 2.1.6 and by the equality of isotropy and holonomy on a symmetric space. **The block cites neither the uniqueness nor the holonomy fact, so this is the one step of the chain that is asserted rather than sourced**, and it is the hinge on which the type stands.

Three other candidates I checked and discarded:

- **A centre in $\mathfrak g_i$.** Theorem 5.5.1(d) allows a compact Lie algebra $\mathfrak z\oplus[\mathfrak g,\mathfrak g]$, and $\mathbb R$ is compact as an algebra with the noncompact group $\mathbb R$, so a centre would break step 4 outright. It is excluded by $\beta$ negative definite, and the exclusion has to be written, which is item 4's first defect.
- **A noncompact transvection group over a compact adjoint group.** Excluded by Weyl, so item 4's defect is a citation defect rather than a truth defect. The existence of the covering itself is real, per $S^3$.
- **A summand failing effectiveness.** Derived impossible in item 2, and it would break Lemma 2.1.2(b)'s definiteness rather than only the quotation.

I looked for a counterexample to the conclusion by asking what a compact globally symmetric Einstein space with $W\ne0$ and a noncompact cover factor would need: by L211 it would need a factor of noncompact or Euclidean type, so it would need L211 to fail. The candidates are the $\mathbb{CH}^m$ quotients, which fail homogeneity, and spaces with a flat factor, which fail the shared $\lambda\ne0$ of L210. Neither survives the hypotheses. **No falsifier of the conclusion.**

## Verdict for L213 as a whole

**CONFIRMED, with four repairs owed and none of them touching the conclusion.** Every de Rham factor of the universal cover of a compact globally symmetric Einstein space with $W\ne0$ is indeed a compact simply connected irreducible symmetric space of compact type, and $\theta(M)=\theta(\widetilde M)$.

What the block owes:

1. **Step 4, the group.** Add that $\mathfrak g_i$ is semisimple, by Corollary 2.1.5 as L211 already cites it, and that every connected group with a compact semisimple Lie algebra is compact, by Weyl, since the transvection group $G_i$ can properly cover $\mathrm{Inn}(\mathfrak g_i)$ and $S^3$ shows it does.
2. **The hypothesis inventory.** Completeness, simple connectivity and homogeneity of the factors are used in steps 2 to 4, so the sentence that those steps use only compact type and effectiveness goes, and with it the claim that global symmetry is spent entirely inside L211.
3. **The identification of the de Rham factors with 2.1.3's summands**, which is asserted and is what carries the type.
4. **The L47 sentence.** L47 applies at $r=1$, where $W\ne0$ is the hypothesis, and the factors at $r\ge2$ are consumed by L48, which needs only $\lVert W_a\rVert^2\ge0$.

Two framing corrections, worth making because three index files repeat them: the lemma is a derivation from Gorodski rather than a citation of Ziller's 6.38(c), whose $K$ compact hypothesis the record does not supply, and the two Lean declarations type the pointwise inequality and a Mathlib instance rather than either half of the load, which the Lean file's own docstring already says more plainly than the record does.

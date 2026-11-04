# Review r779, L183, rank three as collinearity of the images

**Cold brief.** I worked from [BRIEF-g2-l183.md](BRIEF-g2-l183.md) and the two coordinator messages that reached me mid-review, and from nothing else; [findings/](../findings/) was not opened. **No numerical work was done. Every value in this report is exact and was computed by hand**, no script was run, no sweep, search, census or falsifier hunt was opened. Log: [agent_logs/g2-l183-r779.log](../agent_logs/g2-l183-r779.log).

## Claim table

| # | Claim as the block makes it | Verdict |
|---|---|---|
| 1 | Ricci-flatness and first Bianchi together are the single equation $\sum_i\lambda_i\Phi(\omega_i)=0$ | **SOUND** |
| 2 | Tracelessness "adds $\sum\lambda_i=0$ rather than a further constraint" | **SOUND** (and it is where normalisation is load-bearing) |
| 3 | Forward direction: $W\in\mathcal W_n$ $\Rightarrow$ the three images are collinear | **SOUND** |
| 4 | Converse as written, from $\Phi_1-\Phi_3=t(\Phi_2-\Phi_3)$ with $t\ne0,1$ | **ALGEBRA SOUND, COVERAGE INCOMPLETE** |
| 5 | The biconditional "lies in $\mathcal W_n$ **iff** the images are collinear" | **REFUTED**, exhibit in §3 |
| 6 | "The weights are then determined up to scale by the collinearity ratio" | **REFUTED**, the block's own $n=4$ paragraph is the counterexample |
| 7 | "Collinear" in $S^2\oplus\Lambda^4$, factor unspecified | **AMBIGUOUS**; the factorwise reading is **REFUTED**, exhibit in §4 |
| 8 | Orthonormality of the $\omega_i$ | **STATED AND UNUSED** in the algebra; *equal norms* are used |
| 9 | $n=4$: every unit self-dual $\omega$ has $\omega^2=-\tfrac12\mathrm{Id}_4$, $\omega\wedge\omega=f_{1234}$ | **SOUND** |
| 10 | $n=4$: "the family is therefore two-parameter" | **SOUND AS A WEIGHT COUNT**; projectively one-parameter; the L178 attribution is **UNVERIFIABLE** from a cold brief |
| 11 | $\omega\omega^{\mathsf T}=cI\Rightarrow\omega/\sqrt c$ is a complex structure | **SOUND** (and $c=1/3$ is forced at $n=6$) |
| 12 | "Equal squares at full rank forces each $\omega_i$ to be a scaled complex structure" | **REFUTED** as reasoning, exhibit in §8; the triple version is **HYPOTHESIS-DEBT** |
| 13 | $\mathop{\mathrm{tr}}(J_iJ_j)=0$ is the right rendering of orthogonality | **SOUND** |
| 14 | "The first two conditions are the quaternionic relations, which need a dimension divisible by four" | **REFUTED**, explicit triple on $\mathbb R^6$ in §9 |
| 15 | No step assumes $\ker W=0$ | **SOUND**, no defect found |
| 16 | Repair 1 (coordinator): the criterion is "all coincide, or distinct and collinear" | **RIGHT**, it is exactly what I derived independently |
| 17 | Repair 2 (coordinator): the equivalence holds for *any three 2-forms* | **WRONG AS GENERALISED**, §10, the criterion stops being well defined |
| 18 | Repair 3 (coordinator): trace-orthogonality is not anticommutation | **RIGHT**, I reached it independently and exhibited the witness |
| 19 | Repair 4 (coordinator): equal squares do not force a complex structure | **RIGHT**, with one over-statement corrected in §8 |
| 20 | New claim: $\star(J\wedge J)=2\varepsilon_JJ$ on $\mathbb R^6$ closes the scalar sub-case | **SOUND**, verified, including off the standard frame |

**One-line actionable summary.** The lemma's biconditional is false as written and the repair the coordinator proposes for it is right, but the second repair over-generalises and breaks that very criterion, restore "three 2-forms **of equal norm**", keep "distinct and collinear or all coincident", restrict the uniqueness clause to the distinct case, and delete the quaternionic sentence outright; the new $\star(J\wedge J)$ claim survives audit and closes the scalar sub-case at $\dim V=6$.

## 0. Conventions, fixed once

I use the brief's conventions and add nothing to them.

A $2$-form $\omega=\sum_{a<b}\omega_{ab}f_a\wedge f_b$ is read as the skew matrix under $f_a\wedge f_b\mapsto E_{ab}-E_{ba}$, so that $f_a\wedge f_b$ sends $e_b\mapsto e_a$ and $e_a\mapsto -e_b$. This is the correspondence the brief's two normalisations force: $\lVert f_a\wedge f_b\rVert^2=1$ and $\lVert\omega\rVert^2=-\tfrac12\mathop{\mathrm{tr}}(\omega^2)$ agree on it, since $(E_{12}-E_{21})^2=-(E_{11}+E_{22})$ has trace $-2$.

Three consequences used throughout, each one line:

- $\langle\omega,\eta\rangle=\tfrac12\mathop{\mathrm{tr}}(\omega\eta^{\mathsf T})=-\tfrac12\mathop{\mathrm{tr}}(\omega\eta)$, so orthogonality of two $2$-forms is exactly $\mathop{\mathrm{tr}}(\omega\eta)=0$.
- $A:=\omega\omega^{\mathsf T}=-\omega^2$ is positive semidefinite with $\mathop{\mathrm{tr}}A=2\lVert\omega\rVert^2$, so a **unit** $\omega$ has $\mathop{\mathrm{tr}}A=2$.
- $\Phi(c\,\omega)=c^2\Phi(\omega)$ and $(c\omega)\otimes(c\omega)=c^2\,\omega\otimes\omega$. **$\Phi$ is homogeneous of degree two.** This single fact decides §10.

Given A is stated with $A_i=\omega_i\omega_i^{\mathsf T}$ and the proof writes $\omega_i^2$; these differ by one global sign and the equation $\sum_i\lambda_iA_i=0$ is unaffected. I record the discrepancy and treat it as harmless.

**Constants.** The brief asks whether $\sqrt{3/2}$, $\theta_0(12)=1.236033$ or $6+2\sqrt7$ appear. None appears in the argument. $\sqrt{3/2}$ does appear once as literal text inside the anchor slug of the L178 cross-reference. That is a link target, not a step, and I report it only because the brief asked.

## Hypothesis inventory

**Stated in the statement.** (h1) the $\omega_i$ are orthonormal in $\Lambda^2\mathbb R^n$; (h2) every $\lambda_i\ne0$; (h3) $W=\sum_{i=1}^3\lambda_i\,\omega_i\otimes\omega_i$, the sum running over exactly three terms; (h4) implicitly, an $n$ admitting three orthonormal $2$-forms, so $n\ge3$.

**Used.** The **unit norm** of each $\omega_i$, once, in the derivation of $\sum_i\lambda_i=0$, and it is used as *equality of norms*, not as their common value being one. (h2) in both directions. **The count three** is essential and unremarked: affine dependence of $k$ points means they span an affine subspace of dimension at most $k-2$, which is a *line* only at $k=3$. At four eigenvalues the same argument gives coplanarity, and the lemma's shape would change.

**Stated and unused.** Mutual orthogonality $\langle\omega_i,\omega_j\rangle=0$. It appears nowhere in the affine-dependence argument. What it supplies is outside that argument: it makes $\sum\lambda_i\omega_i\otimes\omega_i$ a *spectral* decomposition, so that the $\lambda_i$ are $W$'s eigenvalues and the $\Lambda^2$-rank is three rather than merely at most three. This is item 5 and I agree with the coordinator's repair 2 up to the correction in §10.

**Used and unstated.** (u1) In the converse, the case assumption $\Phi_2\ne\Phi_3$, without which the parametrisation by $t$ does not exist. This is the defect of §3. (u2) In the $n=6$ remark, that each $\omega_i$ has full rank. This one is *true but unargued*: equal squares force equal supports, since $\mathop{\mathrm{supp}}\omega_i=\mathop{\mathrm{im}}(A_i)$ and the $A_i$ coincide, so $\dim V=6$ forces $\mathop{\mathrm{rank}}A=6$. The block asserts "at full rank" as a hypothesis where it is a consequence. (u3) In the same remark, that the constant $c$ is common to the three, see §8, where it is not a consequence at all.

## 1. The reduction to $\sum_i\lambda_i\Phi(\omega_i)=0$, SOUND

Given A is $\sum_i\lambda_i\omega_i^2=0$ in $S^2$, Given B is $\sum_i\lambda_i\,\omega_i\wedge\omega_i=0$ in $\Lambda^4$. A pair of simultaneous linear equations in disjoint target spaces is one equation in the direct sum, and $\Phi(\omega)=(\omega^2,\omega\wedge\omega)$ is exactly the map that packages them. Nothing is smuggled in. Membership in $\mathcal W_n$ also needs the Riemann symmetries, which are carried by "$W$ acts self-adjointly on $\Lambda^2$" and are part of the ambient set-up rather than of this reduction.

## 2. Tracelessness and $\sum_i\lambda_i=0$, SOUND, and it is where normalisation lives

Take the trace of Given A. With $A_i=\omega_i\omega_i^{\mathsf T}$ and $\lVert\omega_i\rVert=1$ we have $\mathop{\mathrm{tr}}A_i=2$, so $0=\mathop{\mathrm{tr}}\big(\sum_i\lambda_iA_i\big)=2\sum_i\lambda_i$, hence $\sum_i\lambda_i=0$.

The block's content is right: this is a consequence of Given A, not an independent constraint. Its *phrasing* is muddled ("adds $\sum\lambda_i=0$" describes as an addition something that is a derived corollary) but no step depends on the phrasing.

What the step does depend on is that $\mathop{\mathrm{tr}}A_i$ is the **same** for all three. With unequal norms the trace yields $\sum_i\lambda_i\lVert\omega_i\rVert^2=0$, which is a different linear functional of $\lambda$ and does **not** make the weights affine. Flagging this is the whole of §10.

## 3. The converse, and the exhibit that refutes the biconditional, REFUTED

**The forward direction first, since it is clean.** With $\lambda_3=-(\lambda_1+\lambda_2)$,

$$\lambda_1(\Phi_1-\Phi_3)+\lambda_2(\Phi_2-\Phi_3)=0 .$$

Both $\lambda_1,\lambda_2\ne0$, so $\Phi_1-\Phi_3$ and $\Phi_2-\Phi_3$ are parallel and the three points lie on a line. The brief's three degenerate configurations:

- **All three equal.** Collinear; a point lies on a line. No failure.
- **Exactly two equal.** *This cannot happen on the Weyl side.* If $\Phi_1=\Phi_3$ the displayed identity gives $\lambda_2(\Phi_2-\Phi_3)=0$, and $\lambda_2\ne0$ forces $\Phi_2=\Phi_3$ as well. So a rank-three Weyl tensor has its three images either pairwise distinct or all three coincident, never in between. This is the sharpest structural fact in the lemma and the block does not state it.
- **An image at the origin.** Impossible. $\Phi(\omega)=0$ forces $\omega^2=0$, hence $\mathop{\mathrm{tr}}(\omega\omega^{\mathsf T})=0$, hence $\omega=0$, and the $\omega_i$ are unit. Equivalently the $S^2$ component always has trace $-2$.

**The converse as written is correct algebra.** From $\Phi_1-\Phi_3=t(\Phi_2-\Phi_3)$, the vector $(1,-t,t-1)$ sums to zero and annihilates the triple, and it has no zero entry precisely when $t\notin\{0,1\}$. So the exclusion is the right one *for that parametrisation*.

**But the parametrisation does not cover every collinear triple, and the uncovered case is a genuine counterexample.** The block writes the line as "$\Phi_1-\Phi_3=t(\Phi_2-\Phi_3)$", which presupposes $\Phi_2\ne\Phi_3$. Three points with exactly two coincident are collinear (they lie on the line through the two distinct values) and if the coincident pair is $\{\Phi_2,\Phi_3\}$ no such $t$ exists at all.

**Exhibit, in closed form, in $\mathbb R^5$** (and hence in every $\mathbb R^n$, $n\ge5$, by padding with zeros; it therefore reaches the conjecture's range $n\ge12$). Put

$$\omega_1=\tfrac{1}{\sqrt2}(f_{12}+f_{34}),\qquad \omega_3=\tfrac{1}{\sqrt2}(f_{13}+f_{42}),\qquad \omega_2=f_{45}.$$

*Orthonormality.* Each is a unit vector: $\lVert\omega_1\rVert^2=\tfrac12(1+1)=1$, likewise $\omega_3$, and $\lVert f_{45}\rVert=1$. The three expand in the pairwise disjoint sets of basis $2$-forms $\{f_{12},f_{34}\}$, $\{f_{13},f_{24}\}$, $\{f_{45}\}$, so all inner products vanish.

*Images.* $\omega_1$ and $\omega_3$ are two of the three self-dual forms on $\mathop{\mathrm{span}}(e_1,\dots,e_4)$, so by §7 below $\omega_1^2=\omega_3^2=-\tfrac12\mathrm{Id}_{1234}$ and $\omega_1\wedge\omega_1=\omega_3\wedge\omega_3=f_{1234}$. Hence $\Phi_1=\Phi_3$. And $\omega_2^2=-(E_{44}+E_{55})$ with $f_{45}\wedge f_{45}=0$, so $\Phi_2=\big(-(E_{44}+E_{55}),\,0\big)\ne\Phi_1$.

*The triple is collinear*, two distinct points, and every point of a two-point set lies on the line through them.

*No admissible weights exist.* Any $\lambda$ with $\sum_i\lambda_i\Phi_i=0$ gives, in the $\Lambda^4$ component, $(\lambda_1+\lambda_3)f_{1234}=0$, so $\lambda_1+\lambda_3=0$; the $S^2$ component then reads $-\lambda_2(E_{44}+E_{55})=0$, so $\lambda_2=0$. The rank-three hypothesis is violated. $\square$

So bare collinearity is **not** sufficient and the "if" half of the biconditional is false. Note that this exhibit is not a rank-three Weyl tensor with four-dimensional support, so **Given C does not touch it**: it is a triple of $2$-forms for which the right-hand side holds and the left-hand side has no solution, and its support is five-dimensional.

**A second, independent defect in the same sentence: the quantifier on $\lambda$.** Read literally, the statement fixes $\lambda$ on the left ("$W=\sum\lambda_i\omega_i\otimes\omega_i$ … lies in $\mathcal W_n$") and asserts equivalence with a condition on the right that mentions only the $\omega_i$. Under that reading the "if" half fails *generically*, not only degenerately: if the images are distinct and collinear with ratio $t$, then by §6 the admissible weights are exactly the multiples of $(1,-t,t-1)$, so any other nonzero $\lambda$ (for instance $(1,1,1)$ when $t\ne-1$), gives a collinear triple and a $W$ outside $\mathcal W_n$. The trailing clause "and the weights are then determined up to scale" shows the intended reading is existential in $\lambda$. The statement should bind $\lambda$ existentially and say so.

## 4. "Collinear" in a direct sum, the joint reading is meant, the factorwise reading is refuted

$\Phi$ lands in $S^2(\mathbb R^n)\oplus\Lambda^4\mathbb R^n$, and collinearity of three points of a vector space (they lie on a common affine line), is the notion the proof's algebra uses, since $\sum_i\lambda_i\Phi_i=0$ is one equation in the direct sum. That is the **joint** reading and it is the right one. The block never says so.

The two readings genuinely differ, and the factorwise one is strictly weaker: in $\mathbb R\oplus\mathbb R$ the points $(0,0),(1,1),(2,3)$ are collinear in each factor separately and not jointly.

**The difference is realised by an orthonormal triple of $2$-forms, so the ambiguity is not academic.** In $\mathbb R^6$ (and every larger $\mathbb R^n$) take

$$\omega_1=\tfrac{1}{\sqrt2}(f_{12}+f_{34}),\qquad \omega_2=\tfrac{1}{\sqrt2}(f_{12}-f_{34}),\qquad \omega_3=f_{56}.$$

*Orthonormality.* $\langle\omega_1,\omega_2\rangle=\tfrac12(1-1)=0$; both are unit; $\omega_3$ is unit and shares no basis $2$-form with either.

*Squares.* Writing $\omega_1$ and $\omega_2$ as matrices, each is a sum of two commuting rotations in the disjoint planes $(e_1,e_2)$ and $(e_3,e_4)$ with coefficients $\pm1/\sqrt2$, so $\omega_1^2=\omega_2^2=-\tfrac12\mathrm{Id}_{1234}$, while $\omega_3^2=-(E_{55}+E_{66})$.

*Wedges.* $\omega_1\wedge\omega_1=f_{12}\wedge f_{34}=f_{1234}$; $\omega_2\wedge\omega_2=\tfrac12(f_{12}-f_{34})\wedge(f_{12}-f_{34})=-f_{1234}$; $\omega_3\wedge\omega_3=0$.

*Factorwise collinear.* In $S^2$ the three points are $\{P,P,Q\}$, collinear. In $\Lambda^4$ they are $f_{1234},-f_{1234},0$, three points of a one-dimensional space, collinear.

*Not jointly collinear.* $\Phi_1-\Phi_3=(P-Q,\;f_{1234})$ and $\Phi_2-\Phi_3=(P-Q,\;-f_{1234})$. Parallelism would need a scalar $k$ with $P-Q=k(P-Q)$ and $f_{1234}=-k\,f_{1234}$, giving $k=1$ and $k=-1$. $\square$

Consistently with §1, this triple carries no Weyl tensor: $\sum\lambda_i\Phi_i=0$ forces $\lambda_1+\lambda_2=0$ from $S^2$ and $\lambda_3=0$ from $S^2$ as well, killing the rank hypothesis.

I record one limitation honestly: in this exhibit the $S^2$ collinearity is witnessed by a coincidence rather than by three distinct points. That is enough (the factorwise condition holds and the joint one fails) but I did not look for a version with three distinct squares, because looking would be a search and the standing rule forbids it.

## 5. Orthonormality, stated and unused, with a caveat that matters

Answered in the hypothesis inventory: mutual orthogonality enters nowhere in the affine-dependence argument; equality of the norms enters once, in §2. The caveat (that the honest generalisation is to *equal-norm* triples and not to arbitrary ones), is §10, because the coordinator's repair 2 states the stronger version.

## 6. Uniqueness of the weights, true exactly in the distinct case, and the block contradicts itself

Suppose the images are pairwise distinct and collinear, $D:=\Phi_2-\Phi_3\ne0$ and $\Phi_1-\Phi_3=tD$. Any admissible $\lambda$ has $\lambda_3=-(\lambda_1+\lambda_2)$ and $(\lambda_1t+\lambda_2)D=0$, so $\lambda_2=-t\lambda_1$ and $\lambda_3=(t-1)\lambda_1$: the solution space is one-dimensional and $\lambda\propto(1,-t,t-1)$. The clause is correct here.

**It is false when the three images coincide,** and the block refutes it two lines later. If $\Phi_1=\Phi_2=\Phi_3$ the only condition left is $\sum_i\lambda_i=0$, whose solution space is two-dimensional. The block's own $n=4$ display says exactly this, "**every** weight vector summing to zero gives a Weyl tensor" and "a whole $2$-parameter set". A statement and its own worked example cannot both stand. The clause must read "determined up to scale when the three images are distinct".

## 7. The $n=4$ coincidence, SOUND, and the parameter count needs one qualification

Set $J_1=\sqrt2\,\eta_1$, $J_2=\sqrt2\,\eta_2$, $J_3=\sqrt2\,\eta_3$ for the self-dual basis $\eta_1=\tfrac{1}{\sqrt2}(f_{12}+f_{34})$, $\eta_2=\tfrac{1}{\sqrt2}(f_{13}+f_{42})$, $\eta_3=\tfrac{1}{\sqrt2}(f_{14}+f_{23})$. Each $J_k$ is a sum of two rotations in complementary planes, so $J_k^2=-\mathrm{Id}_4$. They anticommute: $J_1e_1=-e_2$, $J_2e_1=-e_3$, so $J_1J_2e_1=e_4$ and $J_2J_1e_1=-e_4$, and likewise on the remaining basis vectors. Hence for a unit self-dual $\omega=a\eta_1+b\eta_2+c\eta_3$, $a^2+b^2+c^2=1$,

$$\omega^2=\tfrac12(aJ_1+bJ_2+cJ_3)^2=\tfrac12\big(a^2J_1^2+b^2J_2^2+c^2J_3^2\big)=-\tfrac12\mathrm{Id}_4 ,$$

the cross terms cancelling in pairs. **Correct, and for every unit self-dual form, not merely the basis.**

For the wedge, $\eta_i\wedge\eta_j=0$ whenever $i\ne j$: each of the four products of basis $2$-forms repeats an index, for instance $\eta_1\wedge\eta_2=\tfrac12(f_{12}\wedge f_{13}+f_{12}\wedge f_{42}+f_{34}\wedge f_{13}+f_{34}\wedge f_{42})=0$. And $\eta_1\wedge\eta_1=f_{12}\wedge f_{34}=f_{1234}$, $\eta_2\wedge\eta_2=f_{13}\wedge f_{42}=f_{1342}=f_{1234}$ (the cycle $2\to3\to4\to2$ is even), $\eta_3\wedge\eta_3=f_{14}\wedge f_{23}=f_{1423}=f_{1234}$ (likewise). Hence $\omega\wedge\omega=(a^2+b^2+c^2)f_{1234}=f_{1234}$. **Correct.**

*Consistency of the constants.* $-\tfrac12\mathop{\mathrm{tr}}(-\tfrac12\mathrm{Id}_4)=1$, so $\omega^2=-\tfrac12\mathrm{Id}_4$ is exactly the unit normalisation in dimension four. At $n=6$ the same computation gives $\omega^2=-\tfrac13\mathrm{Id}_6$; see §8.

*The parameter count.* $\{\lambda\in\mathbb R^3:\sum\lambda_i=0\}$ is a two-dimensional vector space, and deleting the three coordinate hyperplanes to enforce rank three leaves an open dense subset of it. So "two-parameter set" is right **as a count of weight vectors**. If $\theta$ is scale-invariant (the brief does not say, and I decline to assume), the family of $\theta$-values is one-parameter. Whether this is what L178's family is, I cannot check: L178 is not in my brief. Recorded as **UNVERIFIABLE**, not as an error.

*Anti-self-dual forms behave identically* with $\omega\wedge\omega=-f_{1234}$, so an all-ASD triple also has coincident images. A **mixed** triple at $n=4$ (two self-dual and one anti-self-dual), is precisely the "exactly two coincide" configuration of §3.

## 8. The complex-structure reduction, the implication is a non sequitur

**What is correct.** If $\omega\omega^{\mathsf T}=cI$ with $c>0$ then $J:=\omega/\sqrt c$ satisfies $JJ^{\mathsf T}=I$ and $J^{\mathsf T}=-J$, so $-J^2=I$, so $J^2=-I$: a metric-compatible complex structure. **SOUND.** Under the unit normalisation the constant is not free: $1=-\tfrac12\mathop{\mathrm{tr}}(\omega^2)=\tfrac12\cdot 6c$ gives $c=1/3$ at $n=6$. The block leaves $c$ unpinned; it should not.

**What is correct about "full rank".** As noted in the inventory, equal squares force equal supports, so $\dim V=6$ already gives each $\omega_i$ rank six. The block states this as a hypothesis where it is a consequence, harmless, but it hides that no extra assumption was needed.

**What is wrong.** The sub-case is "three orthonormal $\omega_i$ with equal $\omega_i^2$". That gives a **common** matrix $S$ with $\omega_i^2=-S$ for each $i$. The complex-structure conclusion needs $S=cI$, and nothing in the sub-case supplies it. The block's justification ("$\omega\omega^{\mathsf T}=cI_6$ says $\omega/\sqrt c$ is both orthogonal and skew"), assumes exactly the point at issue. The Weyl condition adds nothing here: with all $A_i$ equal to $A$, the equation $\sum_i\lambda_iA=0$ collapses to $\sum_i\lambda_i=0$, which §2 already gives.

**Exhibit that equal squares at full rank do not force a scaled complex structure.** In $\mathbb R^6$, for $p+q=\tfrac12$ with $p\ne q$, $p,q>0$, put

$$\omega_1=\sqrt p\,f_{12}+\sqrt q\,f_{34}+\tfrac{1}{\sqrt2}f_{56},\qquad \omega_2=\sqrt p\,f_{12}+\sqrt q\,f_{34}-\tfrac{1}{\sqrt2}f_{56}.$$

Both are unit ($p+q+\tfrac12=1$) and orthogonal ($p+q-\tfrac12=0$). Both have the same square, $\omega_i^2=-\mathop{\mathrm{diag}}(p,p,q,q,\tfrac12,\tfrac12)$, which is invertible and **not** a multiple of the identity, so neither $\omega_i$ is a scaled complex structure. $\square$

**One correction to the coordinator's repair 4.** It says $\omega\omega^{\mathsf T}=A$ "with $A$ merely positive definite of trace 2 has solutions for many non-scalar $A$". The existential is right, the qualification is too loose: since $\omega$ is real skew, $\omega^2$ has every eigenvalue of even multiplicity, so $A$ is realisable **exactly when every eigenvalue of $A$ has even multiplicity**. Say that, or say "for many non-scalar $A$" without "merely".

**What remains open.** Whether *three* orthonormal $2$-forms on $\mathbb R^6$ can share a common non-scalar square is a question with **no argument on file**, and finding out would be a search. Verdict on that sub-question: **HYPOTHESIS-DEBT**. It matters, because §9 and the new $\star$-claim only dispose of the scalar case.

## 9. The quaternionic remark, REFUTED, in closed form

The block writes: "The first two conditions are the quaternionic relations, which need a dimension divisible by four." The first two conditions are (i) each $J_i$ is a metric-compatible complex structure and (ii) $\mathop{\mathrm{tr}}(J_iJ_j)=0$ for $i\ne j$. These are **not** the quaternionic relations. The quaternionic relations are $J_iJ_j=-J_jJ_i$ for $i\ne j$ with $J_1J_2=\pm J_3$; they make $\mathbb R^n$ a module over $\mathbb H$ and so do force $4\mid n$. Anticommutation *implies* trace-orthogonality, since $J_1J_2=\pm J_3$ is skew and skew matrices are traceless. **The converse fails, and there is no dimension obstruction at $\mathbb R^6$.**

**Exhibit: three pairwise trace-orthogonal complex structures on $\mathbb R^6$.**

$$J_1=f_{12}+f_{34}+f_{56},\qquad J_2=f_{24}+f_{36}+f_{51},\qquad J_3=f_{13}+f_{46}+f_{25}.$$

Each is the sum of three basis $2$-forms whose index pairs partition $\{1,\dots,6\}$ (a perfect matching of $K_6$), hence each is a rotation by a quarter turn in three mutually orthogonal planes, so $J_k^2=-\mathrm{Id}_6$, $J_k^{\mathsf T}=-J_k$ and $J_kJ_k^{\mathsf T}=\mathrm{Id}_6$. The three matchings $\{12,34,56\}$, $\{24,36,15\}$, $\{13,46,25\}$ are pairwise edge-disjoint, so the $J_k$ have disjoint supports in the basis $\{f_{ab}\}$ and $\langle J_i,J_j\rangle=0$ for $i\ne j$, that is $\mathop{\mathrm{tr}}(J_iJ_j)=-2\langle J_i,J_j\rangle=0$. $\square$

Normalised, $\omega_k=J_k/\sqrt3$ is an orthonormal triple with the common scalar square $\omega_k^2=-\tfrac13\mathrm{Id}_6$. So the block's asserted obstruction does not exist: what obstructs the coincident sub-case at $\dim V=6$ has to come from the shared $4$-form, which is exactly where the new claim goes. The block's own following clause, "whether the weaker trace condition can be met on $\mathbb R^6$ together with the shared $4$-form is the question", is inconsistent with the sentence before it, and my exhibit settles half of it: the trace condition alone **is** met.

I agree with the coordinator's repair 3 without reservation, and I reached it independently before the message arrived.

## 10. Repair 2 is over-general, and it breaks repair 1's criterion

This is the item the coordinator asked me to look hardest at, and it is where I disagree.

Repair 2 says the equivalence "holds for any three $2$-forms". It does not. Two reasons, the second decisive.

**(a) The trace step needs equal norms.** §2 derives $\sum_i\lambda_i=0$ from $\mathop{\mathrm{tr}}A_i=2$. For arbitrary $2$-forms the trace of Given A yields $\sum_i\lambda_i\lVert\omega_i\rVert^2=0$. That is a linear dependence among the $\Phi_i$ with one weight vector and an affine condition on a *different* one, and the affine-dependence argument (which needs the same $\lambda$ in both roles), does not run.

**(b) $\Phi$ is homogeneous of degree two, so the criterion is not well defined on unnormalised triples.** Both $\omega\otimes\omega$ and $\Phi(\omega)$ scale by $c^2$, so replacing $\omega_1$ by $c\,\omega_1$ and $\lambda_1$ by $\lambda_1/c^2$ leaves $W$ **unchanged** while moving the first image from $\Phi_1$ to $c^2\Phi_1$ along its ray. Collinearity is not preserved by rescaling one point of a triple along its ray, so the same Weyl tensor is assigned both answers depending on how its sum is written.

**Instantiating (b) against the corrected criterion.** Take any rank-three $W$ whose three images coincide at a common $P$, the block's own $n=4$ display supplies one, and Given C tells me $n=4$ is settled, so I am asserting nothing new about it. Rewrite the same $W$ with $\omega_1$ replaced by $2\omega_1$ and $\lambda_1$ by $\lambda_1/4$. The rank-three hypothesis still holds, the three forms are still $2$-forms, and $W$ is the same element of $\mathcal W_4$. Its images are now $\{4P,P,P\}$: **exactly two coincide**, so the corrected criterion "all coincide, or distinct and collinear" declares $W$ not to be a Weyl tensor. Contradiction. $\square$

I flag the Given C tension in the open: I am not exhibiting a rank-three Weyl tensor with four-dimensional support as a finding against L183. I am applying repair 2's *generalised* criterion to a Weyl tensor whose existence the brief and the block already grant, and the generalised criterion returns the wrong answer. The structural argument (b) is independent of $n$ and bites wherever a rank-three Weyl tensor exists at all.

**The correct generalisation, which is still stronger than the block's statement.** Mutual orthogonality is genuinely unused, so the equivalence holds for **any three $2$-forms of equal (nonzero) norm**, equivalently, for any three nonzero $2$-forms after normalising them and absorbing $\lVert\omega_i\rVert^2$ into the weights, since $W=\sum_i\big(\lambda_i\lVert\omega_i\rVert^2\big)\,\hat\omega_i\otimes\hat\omega_i$. What orthogonality buys, separately, is that the $\lambda_i$ are eigenvalues and the rank is three. Repair 2 should say "equal norm", not "any".

## 11. The new claim, $\star(J\wedge J)=2\varepsilon_JJ$ on $\mathbb R^6$, SOUND

I attacked the three points named.

**The adapted frame exists and its orientation is well defined.** For a metric-compatible $J$ on $\mathbb R^6$, choose a unit $u_1$; then $Ju_1\perp u_1$ by skewness and is unit; the orthogonal complement of $\mathop{\mathrm{span}}(u_1,Ju_1)$ is $J$-invariant, and iterating gives an orthonormal frame $(u_1,Ju_1,u_2,Ju_2,u_3,Ju_3)$ in which $J$ is the $2$-form $\varepsilon^1+\varepsilon^2+\varepsilon^3$, the three block area forms. All such frames differ by an element of $U(3)\subset SO(6)$, so they all carry the same orientation and $\varepsilon_J=\pm1$, comparing that orientation to the fixed one, is well defined.

**The Hodge computation.** $J\wedge J=2(\varepsilon^1\wedge\varepsilon^2+\varepsilon^1\wedge\varepsilon^3+\varepsilon^2\wedge\varepsilon^3)$, since $\varepsilon^k\wedge\varepsilon^k=0$. With $\beta=\varepsilon^1\wedge\varepsilon^2$ one has $\lvert\beta\rvert=1$ and $\beta\wedge\varepsilon^3=\mathrm{vol}$, so $\star\beta=\varepsilon^3$ in the adapted orientation, and likewise for the other two. Hence $\star(J\wedge J)=2J$ with respect to the adapted orientation, and $\star(J\wedge J)=2\varepsilon_JJ$ with respect to the fixed one, the star changing sign with the orientation. **SOUND.**

**The deduction from equal wedges.** $\star$ is a linear isomorphism $\Lambda^4\to\Lambda^2$ on $\mathbb R^6$, so $J_i\wedge J_i=J_j\wedge J_j$ gives $\varepsilon_iJ_i=\varepsilon_jJ_j$, hence $J_j=\pm J_i$. This is equality of $\varepsilon_iJ_i$, not something weaker, precisely because $\star$ is injective. **SOUND**, and it is the step where "equal wedges" is genuinely stronger than "equal up to sign".

**The sign of the trace.** $K^2=-\mathrm{Id}_6$ gives $\mathop{\mathrm{tr}}(K^2)=-6$. With $J_i=s_iK$, $s_i=\pm1$, one gets $\mathop{\mathrm{tr}}(J_iJ_j)=s_is_j\mathop{\mathrm{tr}}(K^2)=\mp6\ne0$, contradicting trace-orthogonality. **SOUND.** In fact the contradiction is available one step earlier and without the constant: $J_i=\pm J_j$ makes $\omega_i$ and $\omega_j$ parallel unit vectors, which no orthonormal pair can be. I would state it that way, since it removes the sign bookkeeping from the conclusion.

**An independent check, off the standard frame.** For $J_2=f_{24}+f_{36}+f_{51}$ from §9, $J_2\wedge J_2=2(f_{24}\wedge f_{36}+f_{24}\wedge f_{51}+f_{36}\wedge f_{51})=2(-f_{2346}-f_{1245}+f_{1356})$, counting $1$, $3$ and $4$ inversions respectively. Then $\star f_{2346}=-f_{15}$ ($5$ inversions in $234615$), $\star f_{1245}=f_{36}$ ($2$ inversions in $124536$), $\star f_{1356}=-f_{24}$ ($5$ inversions in $135624$). So $\star(J_2\wedge J_2)=2(f_{15}-f_{36}-f_{24})=-2J_2$, i.e. $\varepsilon_{J_2}=-1$. The claim holds on a complex structure that is not the standard one and whose $\varepsilon$ is the non-trivial sign. This is the strongest check I can make without opening a search.

**Consistency with §9.** My three trace-orthogonal complex structures must, by the new claim, have pairwise different $J\wedge J$, and by the computation above $J_1\wedge J_1=2(f_{1234}+f_{1256}+f_{3456})$ while $J_2\wedge J_2=2(-f_{2346}-f_{1245}+f_{1356})$, which differ. The two results agree, and together they locate the obstruction exactly: at $\dim V=6$ the scalar sub-case dies on the shared $4$-form, never on the dimension.

**What the new claim does not reach**, and the corrected block must not claim it does: it closes only the **scalar** sub-case $A=cI$ of the coincident case. The non-scalar equal-squares case of §8 and the entire non-coincident case remain untouched.

## 12. Kernel, boundary, overreach

**Kernel (item 10).** No step assumes $\ker W=0$ on $\Lambda^2$, and none could survive doing so, since a rank-three $W$ on $\Lambda^2\mathbb R^n$ has kernel of dimension $\tfrac12n(n-1)-3$. Both Givens are stated over the nonzero eigenvalues and the zero ones drop out by construction. The only kernels in play are those of the individual $\omega_i$ as matrices, that is the complements of their supports, and §8 handles them. **No defect.**

**Boundary (item 11).** The argument is uniform in $n$: no step, constant or dimension count depends on $n$. Concretely, $n=3$: $\Lambda^4\mathbb R^3=0$ and $\Phi(\omega)=(\omega^2,0)$; identifying $\Lambda^2\mathbb R^3\cong\mathbb R^3$ by $\omega\leftrightarrow v$ gives $\omega^2=vv^{\mathsf T}-\lvert v\rvert^2I$, so $\sum_i\lambda_i\Phi_i=\sum_i\lambda_iv_iv_i^{\mathsf T}-(\sum_i\lambda_i)I=\sum_i\lambda_iv_iv_i^{\mathsf T}$, which for an orthonormal $v_i$ vanishes only at $\lambda=0$. Both sides of the lemma are then always false and the equivalence is vacuously true, matching $\mathcal W_3=0$. $n=4$: §7, images coincide, statement holds under the corrected criterion. $n=5$ and $n=6$: the defect of §3 is realised, as exhibited. Odd $n$ and $n$ below the conjecture's range: nothing distinguishes them; the exhibits pad up to every $n\ge5$ and so reach $n\ge12$.

**Overreach (item 12).** Four places.

- The biconditional over-claims: bare collinearity is not sufficient (§3).
- "The weights are then determined up to scale" over-claims: false when the images coincide (§6).
- "Equal squares at full rank forces each $\omega_i$ to be a scaled complex structure" over-claims: it forces a common square, not a scalar one (§8).
- "The first two conditions are the quaternionic relations, which need a dimension divisible by four" is simply false (§9), and it is the most damaging of the four because it declares a line of attack blocked that is in fact open.

Against that, the block is **honest about what it has not done**: it labels the $n=6$ remarks "Unaudited", and says the non-coincident sub-case is untouched. Both statements are accurate and I found nothing that contradicts them.

## Would I have found the four defects independently

- **Defect 1 (the criterion).** Yes. It is §3, derived before either message arrived, with the $\mathbb R^5$ exhibit and the extra observation that "exactly two coincide" is impossible on the Weyl side. **The repair is right**, and I would add the quantifier fix and the restriction of the uniqueness clause, neither of which the repair mentions.
- **Defect 2 (orthonormality).** Yes, it is §5 and the inventory. **The repair is right in substance and wrong as generalised**, see §10, which is the finding I would most want carried back.
- **Defect 3 (quaternionic).** Yes, §9, with the explicit $K_6$-matching triple. **The repair is right.**
- **Defect 4 (complex structures).** Yes, §8, with the explicit non-scalar equal-squares pair. **The repair is right**, with the even-multiplicity correction to its phrasing.

## Name what would break it

The object that falsifies the equivalence as the block states it is **an orthonormal triple $\omega_1,\omega_2,\omega_3$ whose images $\Phi_i$ are collinear with exactly two of them coincident.** I did not hunt for one. I constructed one directly from the block's own $n=4$ display by placing two self-dual forms of $\mathbb R^4$ alongside a disjoint decomposable form, and verified its four defining properties by hand in §3.

The object that falsifies the *factorwise* reading of "collinear" is **an orthonormal triple collinear in $S^2$ and in $\Lambda^4$ with different ratios**; §4 exhibits one, with ratios $1$ and $-1$.

The object that would falsify the block's quaternionic sentence is **a trace-orthogonal triple of complex structures on $\mathbb R^6$**; §9 exhibits one, from the standard $1$-factorisation of $K_6$.

The object that would falsify the corrected criterion under repair 2's generalisation is **any rank-three Weyl tensor written with one factor rescaled**; §10 explains why the criterion is not even well defined there.

In every case the object was written down in closed form and checked by exact hand computation. **No search, sweep, census or numerical falsifier hunt was opened, and no script was run.**

## Verdict

**REFUTED AS STATED, REPAIRABLE, AND ONE REPAIR IS ITSELF WRONG.**

The reduction of the Weyl conditions to $\sum_i\lambda_i\Phi(\omega_i)=0$ and the forward direction are correct and are the real content of the lemma. The biconditional is false: bare collinearity is not sufficient, and the uniqueness clause is contradicted by the block's own $n=4$ paragraph. The coordinator's repairs 1, 3 and 4 are right; **repair 2 is over-general and, taken literally, breaks repair 1's criterion**, because $\Phi$ is homogeneous of degree two, it must read "any three $2$-forms of equal norm". The new $\star(J\wedge J)=2\varepsilon_JJ$ claim survives every attack I could bring, including a check on a complex structure with $\varepsilon=-1$, and it closes the **scalar** sub-case at $\dim V=6$ and nothing beyond it. What is left open, with no argument on file, is whether three orthonormal $2$-forms on $\mathbb R^6$ can share a common **non-scalar** square, and the whole non-coincident sub-case.

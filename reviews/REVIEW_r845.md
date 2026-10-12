# REVIEW r845, Lemma L200: the $\Lambda^4$ projection against the Bianchi obstruction map

*Cold brief, Gate 2. The claim reached r845 as a statement and a two-line proof, with the givens quoted into the brief and no access to the reviews that passed its neighbours. Everything below is argued from the definitions of $\mathrm{Alt}$, of the wedge and of $S^2\Lambda^2$, and the two normalisation questions are settled against files on disk rather than against the block's own display. One screen was run, on objects built for it, and it is labelled as a screen where it appears.*

## Claim table

| # | claim | verdict | reason |
| --- | --- | --- | --- |
| 1 | $\mathrm{Alt}(A)=\tfrac13\sum_\alpha\mu_\alpha\,\beta(\omega_\alpha)$, with $\beta(\omega)_{ijkl}=\omega_{ij}\omega_{kl}-\omega_{ik}\omega_{jl}+\omega_{il}\omega_{jk}$ the block's own display | CONFIRMED AS ALGEBRA | the cyclic sum of $\omega_{ij}\omega_{kl}$ is $\beta$ exactly, and linearity carries it off the generators |
| 2 | that display is the record's $\omega\wedge\omega$ | REFUTED | the record's wedge is [SelfDual.lean:105](../lean/HamiltonsCubic/Base/SelfDual.lean#L105)'s `wedgeSelf`, which is $2\beta$, and [PhiSphere.lean](../lean/HamiltonsCubic/Results/PhiSphere.lean) needs that $2$ for the $\Phi$-sphere constant |
| 3 | $\mathrm{Alt}=\tfrac13\,\mathfrak b$ | REFUTED AS STATED | in the record's wedge the factor is $\tfrac16$, machine-checked twice over |
| 4 | $\mathrm{Alt}$ is idempotent and lands in $\Lambda^4$ | CONFIRMED | the image is totally antisymmetric and the cyclic sum fixes it |
| 5 | the rank-one $\omega\otimes\omega$ span $S^2\Lambda^2$, so linearity suffices | CONFIRMED | polarisation |
| 6 | the argument needs an orthonormal eigenbasis | REFUTED AS STATED | the identity holds for any rank-one decomposition, and orthonormality is load-bearing only in the consequence at $W^2$ |
| 7 | the middle step, $\omega_{ik}\omega_{lj}=-\omega_{ik}\omega_{jl}$, with no flip on the first and third | CONFIRMED | index by index |
| 8 | the zero eigenvalues drop out | CONFIRMED | the term is a scalar multiple of the eigenvalue |
| 9 | it re-derives L179(b) rather than asserting it, in both directions | CONFIRMED | first Bianchi is $\mathrm{Alt}(W)=0$ by definition, and a nonzero multiple preserves an iff |
| 10 | $\mathrm{Alt}$ and $\mathfrak b$ stood in two files that do not cite each other | GAP | [L179Statement.lean:138](../lean/HamiltonsCubic/Results/L179Statement.lean#L138) already proves the identification, with the factor $\tfrac16$ |
| 11 | $\mathrm{Alt}(W^2)=\tfrac13\sum_\alpha\lambda_\alpha^2\,\omega_\alpha\wedge\omega_\alpha$ | REFUTED AS STATED | it doubles the record's own $n=4$ closed form and its own $\mathbb{CP}^m$ value, the truth being $\tfrac16$ |
| 12 | $\mathrm{Alt}(W^2)$ is well defined across a degenerate eigenspace | CONFIRMED | through $\Pi_E$, a step the block skips and which holds |
| 13 | $\lVert\mathrm{Alt}(W^2)\rVert\le\tfrac13\sum_\alpha\lambda_\alpha^2\lVert\omega_\alpha\wedge\omega_\alpha\rVert$ | REFUTED AS STATED | false at $W_{\mathbb{CP}^2}$ under the norm the same sentence invokes, and twice too large under the other reading |
| 14 | $\omega\wedge\omega=0$ exactly at a decomposable $\omega$ | CONFIRMED | the condition is scale-free, so it survives every normalisation in play |
| 15 | the identity has content in both directions | CONFIRMED | two closed-form witnesses in section 10 |

## One-line action

**Both $\tfrac13$'s become $\tfrac16$ against the record's own wedge**, or the display's trilinear form is named as an object of its own and kept apart from $\wedge$: with $\tfrac16$ in place the estimate becomes $\lVert\mathrm{Alt}(W^2)\rVert\le\sqrt{(m-1)/(3m)}\,\lVert W\rVert^2$ at $m=\lfloor n/2\rfloor$, which is sharp at $n=4$ and is the numerical bound [I71](../plan.md) is owed.

## Conventions, quoted from the brief

- **$\mathrm{Alt}$** is the projection onto the $\Lambda^4$ summand of $S^2\Lambda^2$, in components $\mathrm{Alt}(R)_{ijkl}=\tfrac13(R_{ijkl}+R_{iklj}+R_{iljk})$, appearing in [L131](../findings/isotropy-cap.md) as $\mathrm{Ric}(R)\wedge\mathrm{id}=R+R\#I-3\,\mathrm{Alt}(R)$.
- **[L179](../findings/diagonal-half.md)(b)**: "The Bianchi obstruction is the map $\mathfrak b:S^2\Lambda^2\to\Lambda^4$ sending $\omega\odot\eta$ to $\omega\wedge\eta$, so first Bianchi $\iff\sum_{\lambda_\alpha\ne0}\lambda_\alpha\,\omega_\alpha\wedge\omega_\alpha=0\in\Lambda^4$. The zero eigenvalues drop out, so at rank $r$ this is a condition on $r$ terms and no more."
- **[L199](../findings/bounds.md)**: $G_W=4(W^2\#I)-4(W\#W)$, and with L131 at $R=W^2$, $G_W=4(\mathrm{Ric}(W^2)\wedge\mathrm{id})+12\,\mathrm{Alt}(W^2)-4W^2-4W^\#$.
- **[conventions.md](../findings/conventions.md)**: the inner product on $\Lambda^2$ is $\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$, making $\{\varphi_{ab}\}_{a<b}$ orthonormal, with $\varphi_{ab}=E_{ba}-E_{ab}$; "diagonal" means diagonal in the coordinate $2$-planes $e_i\wedge e_j$; sums over pairs are over ordered pairs unless stated.
- A $2$-form satisfies $\omega\wedge\omega=0$ exactly when it is decomposable, $\omega=u\wedge v$.

Two further conventions are load-bearing here and reached this review from disk rather than from the brief, and section 1 is where they are pinned: the $\Lambda^4$ norm $\lVert R\rVert^2=\tfrac14\sum_{ijkl}R_{ijkl}^2$, six times the multi-index norm $\lVert\cdot\rVert_\perp^2=\sum_{i<j<k<l}$ on the same array, and the wedge itself.

## Hypothesis inventory

| hypothesis the block carries | where it is used | verdict |
| --- | --- | --- |
| $A$ symmetric on $\Lambda^2\mathbb R^n$, that is $A\in S^2\Lambda^2$ | needed, so that $A_{ijkl}$ has the pair symmetries the component formula for $\mathrm{Alt}$ is written against | used |
| a spectral decomposition $A=\sum_\alpha\mu_\alpha\,\omega_\alpha\otimes\omega_\alpha$ exists | needed, and it does for every symmetric $A$ | used |
| the $\omega_\alpha$ are an ORTHONORMAL eigenbasis | unused by the identity, which holds for any rank-one decomposition, and load-bearing in the consequence, where $W^2=\sum\lambda_\alpha^2\,\omega_\alpha\otimes\omega_\alpha$ requires $\langle\omega_\alpha,\omega_\beta\rangle=\delta_{\alpha\beta}$ | over-stated in the statement, needed in the note |
| $(\omega\otimes\omega)_{ijkl}=\omega_{ij}\omega_{kl}$ | needed, and true under the record's pairing | used, checked in section 3 |
| the wedge normalisation of the display | needed, and it is the defect | section 1 |
| no hypothesis of Bianchi, of Ricci-flatness, of tracelessness or of a dimension | correctly absent, the identity being one about $S^2\Lambda^2$ | clean |

Two objects the block names and never constrains are worth an explicit line. $\mathfrak b$ is used only through its diagonal $\omega\odot\omega\mapsto\omega\wedge\omega$, so the polarised half of L179(b)'s definition idles here. And $n$ is free throughout, including $n\le3$, where $\Lambda^4=0$ and both sides vanish, which is a degenerate instance rather than a counterexample.

## 1. The wedge normalisation

**The claim lives or dies here, and it dies here.** The block asserts $(\omega\wedge\omega)_{ijkl}=\omega_{ij}\omega_{kl}-\omega_{ik}\omega_{jl}+\omega_{il}\omega_{jk}$. Write $\beta(\omega)$ for that trilinear expression, so the assertion is $\omega\wedge\omega=\beta(\omega)$. **The record's wedge is $2\beta(\omega)$**, and three independent sites on disk say so.

**The definition, which is where the brief asks me to pin it.** [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean) defines `wedge2 X Y` as the symmetrised sum of two halves and `wedgeSelf X` as `wedge2 X X`, and proves at [SelfDual.lean:112](../lean/HamiltonsCubic/Base/SelfDual.lean#L112)

```
theorem wedgeSelf_apply (X : Matrix ι ι ℝ) (a b c d : ι) :
    wedgeSelf X a b c d = 2 * (X a b * X c d - X a c * X b d + X a d * X b c)
```

so $(\omega\wedge\omega)_{abcd}=2\beta(\omega)_{abcd}$, kernel-checked. This is the wedge L179 itself runs on: [L179Statement.lean:36](../lean/HamiltonsCubic/Results/L179Statement.lean#L36) says $\mathfrak b$ "is `bObs` below, the symmetric bilinear map built on SelfDual.lean's `wedge2`, whose diagonal value $\mathfrak b(\omega\odot\omega)$ is the `wedgeSelf` that (b) sums", and adds that "the wedge is SelfDual.lean's, so the convention is fixed once for the layer". **So the $\mathfrak b$ that L200 names has a fixed and machine-readable normalisation, and it carries the $2$.**

**The second pinning is the $\Phi$-sphere identity, which the block's own estimate invokes.** [conventions.md](../findings/conventions.md) tables $\operatorname{tr}(\omega^4)+\lVert\omega\wedge\omega\rVert_\perp^2=2\langle\omega,\omega\rangle^2$, and [PhiSphere.lean](../lean/HamiltonsCubic/Results/PhiSphere.lean) proves it at $\dim=4$ and $\dim=6$ in the form $\operatorname{tr}(\omega^4)+4\sum_{i<j<k<l}\mathrm{w4}^2=2\langle\omega,\omega\rangle^2$, with `w4` the block's $\beta$ and the file's own comment reading "the $4\times4$ Pfaffian at $i<j<k<l$, which is $(\omega\wedge\omega)_{ijkl}/2$". **The constant $4$ in front of $\sum\beta^2$ is exactly the statement that $\omega\wedge\omega=2\beta$.** Read the closed form: at $n=4$ with $\sigma_1=\sigma_2=\tfrac1{\sqrt2}$ the identity forces $\lVert\omega\wedge\omega\rVert_\perp^2=2-\operatorname{tr}(\omega^4)=1$, while $\beta(\omega)_{1234}=\sigma_1\sigma_2=\tfrac12$. **A factor of two, in closed form, with no numerics in it.**

**The third is the consequence the record already publishes**, and section 11 runs it.

**What follows for the constant.** Composing the record's own two machine-checked facts, [AltPart.lean:383](../lean/HamiltonsCubic/Base/AltPart.lean#L383)'s `altCoeff_eq_third_bianchi`, which is $\mathrm{Alt}=\tfrac13\cdot\mathrm{bianchi}$ against the unnormalised cyclic sum, and [L179Statement.lean:138](../lean/HamiltonsCubic/Results/L179Statement.lean#L138)'s

```
theorem bianchi_rankSumOp ... :
    bianchi (rankSumOp lam om) a b c d = (1 / 2) * ∑ i, lam i * wedgeSelf (om i) a b c d
```

gives

$$\mathrm{Alt}(A)=\tfrac13\cdot\tfrac12\sum_\alpha\mu_\alpha\,\omega_\alpha\wedge\omega_\alpha=\tfrac16\,\mathfrak b(A).$$

**So the record's answer to L200's question was already $\tfrac16$, proved, before L200 was written.**

**The self-consistent reading of the block.** With $\wedge$ read as $\beta$ throughout, L200's $\tfrac13$ is right, because $\tfrac13\beta=\tfrac16\cdot 2\beta$. The two readings are one identity at two normalisations, and the arithmetic never disagrees with itself. What disagrees is the record: L200 introduces a third wedge convention into a file whose neighbours run on the layer's, and states its constant against that third convention while naming L179's map.

**Collateral, outside L200's scope and worth one line.** [review_r57_diag.py:107](../scripts/lib/review_r57_diag.py#L107)'s `wedge_norm` computes $\lVert\beta\rVert_\perp$, half of $\lVert\omega\wedge\omega\rVert_\perp$, against conventions.md's line that "the wedge routines on disk report $\lVert\cdot\rVert_\perp$". It is used there as a decomposability test and in a minimisation, where the scale is inert, and a value quoted from it beside a $\Phi$-sphere number would be out by two.

## 2. Is $\mathrm{Alt}$ a projection

**Yes, and the check is three lines.** Write $b(R)_{ijkl}=\tfrac13(R_{ijkl}+R_{iklj}+R_{iljk})$, the cyclic sum over the last three indices at fixed $i$.

**Its image is totally antisymmetric.** On the generators, $b(\omega\otimes\omega)=\tfrac13\beta(\omega)$, and $\beta(\omega)$ is antisymmetric in $i\leftrightarrow j$: substituting gives $\omega_{ji}\omega_{kl}-\omega_{jk}\omega_{il}+\omega_{jl}\omega_{ik}=-(\omega_{ij}\omega_{kl}-\omega_{ik}\omega_{jl}+\omega_{il}\omega_{jk})$, using $\omega_{ji}=-\omega_{ij}$ on the first term and commuting the scalar factors on the other two. Antisymmetry in $k\leftrightarrow l$ is the same computation, and invariance under the cyclic permutation of $(j,k,l)$ is visible in the display. Those generate the full alternating action of $S_4$.

**It fixes what it produces.** For a totally antisymmetric $T$, the permutations $(jkl)\mapsto(klj)$ and $(jkl)\mapsto(ljk)$ are both even, so $T_{iklj}=T_{iljk}=T_{ijkl}$ and $b(T)=\tfrac13\cdot3\,T=T$. **Hence $b\circ b=b$ on the generators, and by linearity on $S^2\Lambda^2$.**

**And it lands where the claim says.** The image is $\Lambda^4$ realised inside $S^2\Lambda^2$ by its components, which is exactly the realisation [L179Statement.lean:46](../lean/HamiltonsCubic/Results/L179Statement.lean#L46) records for the same object. Self-adjointness is the remaining half of "orthogonal projection", it is tabled in conventions.md, and the claim under review consumes idempotence rather than self-adjointness, so this review checks the half that is used. **Screen: the idempotence residual at a random symmetric $A$ on $\Lambda^2\mathbb R^5$ came back at $5.6\times10^{-17}$, which agrees with the derivation and is reported as a screen.**

## 3. The spanning step

**The generators span, so linearity does suffice.** For $\omega,\eta\in\Lambda^2$, polarisation gives $\omega\odot\eta=\tfrac12\big((\omega+\eta)\otimes(\omega+\eta)-\omega\otimes\omega-\eta\otimes\eta\big)$, and the $\omega\odot\eta$ span $S^2\Lambda^2$ by definition of the symmetric square. **So $\{\omega\otimes\omega\}$ spans over $\mathbb R$**, with no positivity obstruction, since the coefficients in that expansion are free in sign.

**The component convention is consistent, which is a place a factor of two could have entered and does not.** Under the half-trace pairing an operator $S$ has array $S_{ijkl}=\langle S\varphi_{ij},\varphi_{kl}\rangle$ and acts by $(SX)_{ij}=\tfrac12\sum_{kl}S_{ijkl}X_{kl}$. With $\varphi_{ab}=E_{ba}-E_{ab}$ one gets $\langle\omega,\varphi_{ij}\rangle=-\omega_{ij}$, and the two signs square away: $\langle(\omega\otimes\omega)\varphi_{ij},\varphi_{kl}\rangle=\omega_{ij}\omega_{kl}$, which is the block's line. The same pairing gives $\lVert\omega\otimes\omega\rVert^2=\tfrac14\sum_{ijkl}\omega_{ij}^2\omega_{kl}^2=1$ at unit $\omega$, matching the Hilbert–Schmidt norm of a rank-one projection, so the $\tfrac14$ norm and the array convention agree.

**The block claims more hypothesis than it uses.** Nothing in the derivation touches orthonormality or the eigen-property: for any decomposition $A=\sum_\alpha c_\alpha\,\omega_\alpha\otimes\omega_\alpha$ whatever, $\mathrm{Alt}(A)=\tfrac13\sum_\alpha c_\alpha\beta(\omega_\alpha)$. Orthonormality earns its place one paragraph later, at $W^2=\sum\lambda_\alpha^2\,\omega_\alpha\otimes\omega_\alpha$, which needs $(\omega_\alpha\otimes\omega_\alpha)(\omega_\beta\otimes\omega_\beta)=\langle\omega_\alpha,\omega_\beta\rangle\,\omega_\alpha\otimes\omega_\beta$ to collapse. **Stating the identity at any rank-one decomposition strengthens it and costs nothing.**

## 4. The middle step

**Correct, and the two terms that need no flip genuinely need none.** With $R=\omega\otimes\omega$ the three summands of the cyclic sum are read off $R_{ijkl}=\omega_{ij}\omega_{kl}$ by substitution of index names:

- $R_{ijkl}=\omega_{ij}\omega_{kl}$, already the first term of $\beta$, no flip;
- $R_{iklj}=\omega_{ik}\omega_{lj}=-\omega_{ik}\omega_{jl}$, the one flip, by $\omega_{lj}=-\omega_{jl}$, which is antisymmetry of $\omega$ in its own two slots exactly as the block says;
- $R_{iljk}=\omega_{il}\omega_{jk}$, the third term of $\beta$, no flip.

**So the sign pattern $(+,-,+)$ is right and the index slip the brief asks after is absent.**

## 5. The zero eigenvalues

**True as stated, and it needs nothing the block skips.** The term indexed by $\alpha$ is $\mu_\alpha\,\beta(\omega_\alpha)$, a scalar multiple, so $\mu_\alpha=0$ kills it whatever $\omega_\alpha$ is, decomposable or not. The sum therefore runs over the nonzero spectrum with multiplicity, giving one term per unit of rank. **This is weaker than it may look and that is the honest reading**: it says the eigenforms in $\ker A$ contribute nothing, and it says nothing about the $\Lambda^4$ directions those forms occupy.

## 6. Does it re-derive L179(b)

**It re-derives it, both ways, and it does not assume it.**

**The forward direction.** First Bianchi for $R\in S^2\Lambda^2$ is the cyclic identity $R_{ijkl}+R_{iklj}+R_{iljk}=0$, which is $\mathrm{Alt}(R)=0$ by the definition of $\mathrm{Alt}$ and by nothing else. Applying the identity at $\mu=\lambda$ turns that into $\sum_\alpha\lambda_\alpha\,\omega_\alpha\wedge\omega_\alpha=0$.

**The converse.** $\mathrm{Alt}$ and $\mathfrak b$ differ by a nonzero scalar, whichever of the two normalisations is in force, so $\mathfrak b(W)=0$ returns $\mathrm{Alt}(W)=0$, which is first Bianchi. **The equivalence L179(b) asserts is therefore an equivalence, and it survives the factor dispute of section 1 untouched**, a nonzero constant being invisible to a vanishing statement.

**Nothing in the two-line proof cites L179(b)**, the input being the component formula for $\mathrm{Alt}$ and the antisymmetry of $\omega$. So the re-derivation claim is sound in substance. What it re-derives, precisely, is the step from the cyclic identity to the spectral equation, which L179(b) had stated as a definition-plus-consequence with no derivation attached.

## 7. Novelty, searched by the object

**GAP. The record already carries the identification, in a file dedicated to L179 itself, and there it carries $\tfrac16$.**

I searched by object rather than by letter: `Alt` across [findings/](../findings/) and [lean/](../lean/), `wedge` and `wedgeSelf` across both plus [scripts/](../scripts/), the Bianchi projector under the names `bianchi`, `bianchi_defect`, `alt_part`, `alt_norm` and `lam4_basis` in [scripts/lib/](../scripts/lib/), and the factor $3$ beside `Alt` in [conventions.md](../findings/conventions.md), [isotropy-cap.md](../findings/isotropy-cap.md), [bounds.md](../findings/bounds.md) and [INDEX-traps.md](../findings/INDEX-traps.md). The sites that matter:

- **[L179Statement.lean:136-158](../lean/HamiltonsCubic/Results/L179Statement.lean#L136)**, `bianchi_rankSumOp`, proving that the unnormalised Bianchi map of a spectral operator is $\tfrac12\sum_i\lambda_i(\omega_i\wedge\omega_i)$, with its header saying in words that "the factor $\tfrac12$ relating `bianchi` to it is proved rather than assumed".
- **[AltPart.lean:383](../lean/HamiltonsCubic/Base/AltPart.lean#L383)**, `altCoeff_eq_third_bianchi`, proving $\mathrm{Alt}=\tfrac13\cdot\mathrm{bianchi}$.

Those two compose to L200's statement with the constant $\tfrac16$. **They also refute the novelty note's own wording.** The note says the two names "stood in two files that do not cite each other": [L179Statement.lean](../lean/HamiltonsCubic/Results/L179Statement.lean) cites both objects, in one file, and relates them by a proved constant. The identification is prior art on the record, in the layer whose job is to settle exactly this kind of question, and the block reaches it by hand and lands on the other factor. **What is genuinely new in L200 is the prose route to it, which is worth keeping, and the extension from a Weyl tensor to an arbitrary symmetric $A$, which the Lean bridge already has, being stated at `rankSumOp` with free $\lambda$.**

## 8. The consequence for L199

**Well defined, and the block skips the step that makes it so.**

**The eigenbasis question is real and it resolves.** Any orthonormal eigenbasis of $W$ is an eigenbasis of $W^2$ with eigenvalues $\lambda_\alpha^2$, so $W^2=\sum_\alpha\lambda_\alpha^2\,\omega_\alpha\otimes\omega_\alpha$ holds for every such choice. The converse fails, since $W^2$ has a larger eigenspace wherever $\lambda$ and $-\lambda$ both occur in the spectrum of $W$, and that costs nothing here because the formula is written in $W$'s basis.

**The invariance argument, in one line.** Inside an eigenspace $E$ of $W$ with common eigenvalue $\lambda$, the contribution to the sum is $\lambda^2\,\mathfrak b\big(\sum_{\alpha\in E}\omega_\alpha\otimes\omega_\alpha\big)=\lambda^2\,\mathfrak b(\Pi_E)$, and $\Pi_E$, the orthogonal projection onto $E$, depends on $E$ and not on the basis chosen inside it. **So the sum is a function of the operator $W^2$ alone.** The deeper reason is that $\mathrm{Alt}$ is a linear map on $S^2\Lambda^2$ applied to $W^2$, so basis independence is automatic and the spectral form is a way of computing it rather than a definition of it. The block asserts the formula without either remark, and both hold.

**The constant is the defect.** With section 1's wedge, the correct statement is

$$\mathrm{Alt}(W^2)=\tfrac16\sum_\alpha\lambda_\alpha^2\,\omega_\alpha\wedge\omega_\alpha.$$

## 9. The estimate

**Which norm, and what is lost.**

**The left side is fixed by the record.** [conventions.md](../findings/conventions.md) states that "$\mathrm{Alt}$ projects $S^2(\Lambda^2)$ onto $\Lambda^4$ INSIDE $S^2(\Lambda^2)$, so $\lVert\mathrm{Alt}(R)\rVert$ is measured in that same norm rather than in a second one", the norm being $\lVert R\rVert^2=\tfrac14\sum_{ijkl}R_{ijkl}^2$. On a totally antisymmetric array each unordered quadruple carries $24$ equal-magnitude entries, so $\lVert T\rVert^2=6\lVert T\rVert_\perp^2$, which is conventions.md's own "six times smaller" and its anchor $\lVert\star\rVert^2=6$.

**The right side is left ambiguous, and the same sentence pulls it two ways.** It writes $\lVert\omega\wedge\omega\rVert$ and then says "$\lVert\omega\wedge\omega\rVert$ is what the $\Phi$-sphere identity controls at unit $\omega$", and the $\Phi$-sphere identity controls $\lVert\cdot\rVert_\perp$. **That is the mixing conventions.md warns is "false rather than rescaled", and here it is false.** Three readings, with the truth beside each:

| reading | the block's right side | the truth |
| --- | --- | --- |
| record wedge $2\beta$, record norm both sides | $\tfrac13\sum\lambda_\alpha^2\lVert\omega_\alpha\wedge\omega_\alpha\rVert$ | valid, and exactly twice the sharp constant $\tfrac16$ |
| record wedge, $\lVert\cdot\rVert_\perp$ on the right as the $\Phi$-sphere supplies it | $\tfrac1{3\sqrt6}\sum\lambda_\alpha^2\lVert\omega_\alpha\wedge\omega_\alpha\rVert$ | **false**, the sharp constant in those units being $\tfrac1{\sqrt6}$ |
| the block's own $\beta$ as the wedge, record norm both sides | $\tfrac13\sum\lambda_\alpha^2\lVert\beta(\omega_\alpha)\rVert$ | valid and sharp at rank one |

**The closed-form falsifier for the middle row, at a Weyl tensor the record already carries.** Take $W_{\mathbb{CP}^2}$ at $n=4$, of unit norm, self-dual spectrum $\tfrac1{\sqrt6}(2,-1,-1)$ on an orthonormal self-dual eigenbasis and zero on $\Lambda^-$. Then $W^2$ is $\tfrac16\operatorname{diag}(4,1,1)$ on $\Lambda^+$, and since $\Lambda^4\mathbb R^4$ is the line spanned by $\star$ with $\lVert\star\rVert^2=6$, orthogonal projection gives $\mathrm{Alt}(W^2)=\tfrac{\langle W^2,\star\rangle}{6}\star=\tfrac16\star$, using $\star=+1$ on $\Lambda^+$ and $\operatorname{tr}W^2=1$. **So $\lVert\mathrm{Alt}(W^2)\rVert=\tfrac{\sqrt6}{6}=0.4082$.** Each unit self-dual $\omega$ has $\lVert\omega\wedge\omega\rVert_\perp=1$, so the middle row's right side is $\tfrac13\sum\lambda_\alpha^2=\tfrac13=0.3333$. **A bound of $0.3333$ on a quantity equal to $0.4082$, at a point on the record, with every number in closed form.**

**What the triangle inequality loses, over and above the constant.** The weights $\lambda_\alpha^2$ are all positive, so no cancellation is available from them, and the $\Lambda^4$ vectors $\omega_\alpha\wedge\omega_\alpha$ supply all of it. Two losses, both real:

- **Orthogonality.** At $n\ge6$ two eigenforms can have self-wedges on disjoint quadruples, $\omega_1$ supported on $e_1,\dots,e_4$ and $\omega_2$ on $e_3,\dots,e_6$ giving arrays on $\{1234\}$ and $\{3456\}$, hence orthogonal in $\Lambda^4$. Across $r$ mutually orthogonal terms the inequality loses $\sqrt r$.
- **Cancellation, which is unbounded.** At $n=4$ the record's own reading of L199 says $\mathrm{Alt}(W^2)=\tfrac{\lVert W^+\rVert^2-\lVert W^-\rVert^2}{6}\star$, so every Weyl tensor with $\lVert W^+\rVert=\lVert W^-\rVert$ has $\mathrm{Alt}(W^2)=0$ while the right side stays at its full positive value. **The ratio between bound and truth is unbounded, and the sign structure in $\Lambda^4$ is precisely what the triangle inequality throws away.** Since the $\Lambda^4$ defect is what L199 wants controlled, an estimate blind to that structure is weak exactly where the question lives.

**The corrected bound, which is a real if modest deliverable.** In the record's wedge and the record's norm,

$$\lVert\mathrm{Alt}(W^2)\rVert\le\tfrac16\sum_\alpha\lambda_\alpha^2\lVert\omega_\alpha\wedge\omega_\alpha\rVert=\tfrac1{\sqrt6}\sum_\alpha\lambda_\alpha^2\lVert\omega_\alpha\wedge\omega_\alpha\rVert_\perp .$$

The $\Phi$-sphere identity at unit $\omega$ gives $\lVert\omega\wedge\omega\rVert_\perp^2=2-\operatorname{tr}(\omega^4)=2\big(1-\sum_i\sigma_i^4\big)$, and $\sum_i\sigma_i^4\ge\tfrac1m$ at $\sum_i\sigma_i^2=1$ with $m=\lfloor n/2\rfloor$ singular pairs, by Cauchy–Schwarz. With $\sum_\alpha\lambda_\alpha^2=\lVert W\rVert^2$,

$$\lVert\mathrm{Alt}(W^2)\rVert\le\sqrt{\tfrac{m-1}{3m}}\;\lVert W\rVert^2,\qquad m=\lfloor n/2\rfloor .$$

**At $n=4$ that is $\lVert W\rVert^2/\sqrt6$ and it is attained**, at $W_{\mathbb{CP}^2}$, where both inequalities are equalities: every eigenform has $\sum\sigma_i^4=\tfrac12=\tfrac1m$, and the three self-wedges are all $+\star$, so the triangle inequality is tight. It rises to $\lVert W\rVert^2/\sqrt3$ as $n$ grows. **This derivation is r845's own and no independent reader has checked it**, so it belongs in the block as a reviewer's contribution rather than as a passed result.

## 10. Vacuity and non-vacuity

**Both directions have closed-form content, and neither witness needs a computer.**

**A symmetric operator with $\mathrm{Alt}(A)\ne0$.** At $n=4$ take the unit self-dual form $\omega$ with $\omega_{12}=\omega_{34}=\tfrac1{\sqrt2}$ and all other independent entries zero, and set $A=\omega\otimes\omega$. Then $\beta(\omega)_{1234}=\tfrac12$, so $\omega\wedge\omega=\star$ and $\mathrm{Alt}(A)=\tfrac16\star\ne0$, with $\lVert\mathrm{Alt}(A)\rVert=\tfrac1{\sqrt6}$. The same value comes out of the projection definition without any wedge at all, $\mathrm{Alt}(A)=\tfrac{\langle A,\star\rangle}{6}\star$ with $\langle A,\star\rangle=1$, which is an independent check of the constant.

**A symmetric operator with $\mathrm{Alt}(A)=0$ that is coordinate-diagonal in no frame.** Take two orthonormal self-dual forms at $n=4$, $\omega_1$ as above and $\omega_2$ with $\omega_{13}=-\omega_{24}=\tfrac1{\sqrt2}$, and set $A=\omega_1\otimes\omega_1-\omega_2\otimes\omega_2$. Every unit self-dual form has $\omega\wedge\omega=\star$, so $\mathfrak b(A)=\star-\star=0$ and $\mathrm{Alt}(A)=0$. **It is coordinate-diagonal in no orthonormal frame**: its $+1$ eigenspace is the line $\mathbb R\omega_1$, a coordinate-diagonal operator is diagonal in the basis $\{\varphi_{ab}\}$ and so has a one-dimensional eigenspace spanned by a single decomposable $\varphi_{ab}$, and $\omega_1$ is non-decomposable since $\omega_1\wedge\omega_1=\star\ne0$. Decomposability is frame-independent, so no rotation repairs it. **$W_{\mathbb{CP}^2}$ is a second witness of the same kind**, with the cancellation coming from tracelessness across three aligned self-wedges rather than from two opposed ones.

**So the identity has content in both directions**, and the mechanism it exposes is visible: vanishing comes either from decomposable eigenforms, which contribute nothing termwise, or from cancellation among non-decomposable ones, which is the case the block's own dichotomy sentence does not name.

## 11. Arguing the opposite

**Against the factor defect, the strongest case for the block.** L200 defines its wedge in its own display, and under that definition every equation it writes is true. conventions.md tables no component formula for $\wedge$, so the block contradicts no tabled line of the conventions file. On that reading L200 is a second normalisation rather than an error.

**Why that defence fails, on three counts.** First, $\mathfrak b$ is not L200's to renormalise: it is L179(b)'s map, and L179's own formalisation fixes it to `wedgeSelf`, factor two included, with the header saying the convention is fixed once for the layer. Second, the block's estimate names the $\Phi$-sphere identity as its source of $\lVert\omega\wedge\omega\rVert$, and that identity is stated and machine-checked against the factor-two wedge, so the block itself reaches across the two conventions inside one sentence. Third, section 8's consequence is checkable against a number the record already publishes, and it comes out wrong by exactly two.

**Against the consequence defect, the case for the block.** Perhaps bounds.md's $n=4$ closed form and its $\mathbb{CP}^m$ value were themselves derived in the block's normalisation, in which case $\tfrac13$ would agree with them.

**Why that fails.** Both record values agree with $\tfrac16$ and disagree with $\tfrac13$, and both can be recomputed from the projection definition with no wedge in play. At $W_{\mathbb{CP}^2}$, $\mathrm{Alt}(W^2)=\tfrac{\langle W^2,\star\rangle}{6}\star=\tfrac16\star$, whose diagonal entry against a self-dual eigenform is $\tfrac16$, so $12\,\mathrm{Alt}(W^2)_{\gamma\gamma}=2$, which is bounds.md's $\tfrac{4(2m-1)}{3m}$ at $m=2$ and diagonal-half.md's measured $2.00$. **The $\tfrac16$ route reproduces it and the $\tfrac13$ route returns $4$.** The general $n=4$ statement goes the same way: $\tfrac16\sum\lambda_\alpha^2\,\omega_\alpha\wedge\omega_\alpha=\tfrac{\lVert W^+\rVert^2-\lVert W^-\rVert^2}{6}\star$, since self-dual eigenforms give $+\star$ and anti-self-dual ones $-\star$, which is [bounds.md](../findings/bounds.md)'s recorded closed form verbatim. **A block that doubled it would contradict a Gate-2-passed lemma two files away.**

**Against the novelty defect, the case for the block.** The Lean bridge is typed at a spectral operator `rankSumOp` and phrased in `bianchi` rather than in `Alt`, so a reader of the prose record could reasonably miss it.

**Why it still stands as a GAP.** The site exists, it is proved, and it is named in the header of the file that formalises the very lemma L200 cites. The honest form of the novelty note is that the prose record lacked the identification while the Lean layer had it, which is a finding about the two layers rather than about the map.

**Withdrawn candidates.** I considered three further defects and can defend none of them, so they are recorded as withdrawn: that the spanning step needs positive coefficients, refuted by polarisation in section 3; that $\mathrm{Alt}(W^2)$ might depend on the basis chosen inside a degenerate eigenspace, refuted by the $\Pi_E$ argument in section 8; and that "zero eigenvalues drop out" needs the eigenform to be decomposable, refuted in section 5, the term being a scalar multiple.

## 12. What would break it, and what I did to look

**What would break the corrected identity $\mathrm{Alt}=\tfrac16\mathfrak b$.** A wedge convention on the record carrying a factor other than the `wedgeSelf` two. A failure of idempotence for the cyclic formula, which would mean $\mathrm{Alt}$ and $\mathfrak b$ have different images and the identification is between different objects. A generator set that fails to span $S^2\Lambda^2$, which would void the linearity argument. An $S^2\Lambda^2$ element outside the span of symmetric operators on $\Lambda^2$, which would leave the statement about a proper subspace.

**What I did.** I read the wedge from its definition in [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean) rather than from any display, cross-checked it against [PhiSphere.lean](../lean/HamiltonsCubic/Results/PhiSphere.lean)'s machine-checked constant $4$ and against conventions.md's $\Phi$-sphere line, and cross-checked the composite constant against two independent record values, the $n=4$ closed form and the $\mathbb{CP}^m$ number, both of which are recomputable from the projection definition with no wedge. I verified idempotence by hand on the generators, spanning by polarisation, and the component convention $(\omega\otimes\omega)_{ijkl}=\omega_{ij}\omega_{kl}$ against the half-trace pairing and the $\tfrac14$ norm. I searched [findings/](../findings/), [lean/](../lean/) and [scripts/lib/](../scripts/lib/) by object for prior statements of the identification.

**One screen, reported as a screen.** On a random symmetric operator on $\Lambda^2\mathbb R^5$ built for the purpose, $\mathrm{Alt}(A)-\tfrac13\sum_\alpha\mu_\alpha\beta(\omega_\alpha)$ came back at $7.2\times10^{-16}$, $\mathrm{Alt}(A)-\tfrac16\sum_\alpha\mu_\alpha(\omega_\alpha\wedge\omega_\alpha)$ at the same $7.2\times10^{-16}$, and $\mathrm{Alt}(A)-\tfrac13\sum_\alpha\mu_\alpha(\omega_\alpha\wedge\omega_\alpha)$ at $0.45$, which is what makes the screen able to fail. **It screens the factor. Sections 1 and 11 are what establish it**, and nothing positive in this review rests on the screen.

## Verdict

**REFUTED AS STATED, with the mathematics behind it CONFIRMED AS ALGEBRA and the constant halved.**

- **The identity is true**, and its proof is correct line by line, including the middle step, the spanning step and the treatment of the zero eigenvalues.
- **The constant is $\tfrac16$ and not $\tfrac13$** against the record's own wedge, which is fixed by [SelfDual.lean:105](../lean/HamiltonsCubic/Base/SelfDual.lean#L105), needed by [PhiSphere.lean](../lean/HamiltonsCubic/Results/PhiSphere.lean)'s constant, and already composed into $\tfrac16$ by [L179Statement.lean:138](../lean/HamiltonsCubic/Results/L179Statement.lean#L138) with [AltPart.lean:383](../lean/HamiltonsCubic/Base/AltPart.lean#L383).
- **The consequence for L199 is doubled**, and it contradicts two values the record already publishes, both recoverable from the projection definition alone.
- **The estimate is false** under the reading its own sentence invites, and loose by a factor of two under the other, and it discards the $\Lambda^4$ sign structure that carries the whole question.
- **The novelty note is a GAP**: the identification is prior art in the Lean layer, in the file formalising L179.
- **The re-derivation of L179(b) stands**, in both directions and under either normalisation, and it is the part of L200 worth keeping as written.

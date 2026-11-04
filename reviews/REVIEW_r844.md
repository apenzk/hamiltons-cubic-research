# REVIEW r844 on Lemma L200, the $\Lambda^4$ projection against the Bianchi obstruction map

**Cold Gate 2 brief.** This reviewer was given the statement, the proof, the surrounding notes and the quoted givens, and argued from the definitions. The record was then read on disk to pin the one free parameter the proof has, the normalisation of $\wedge$ on $\Lambda^2\times\Lambda^2\to\Lambda^4$. The programme is on an analysis-only footing, so every positive statement below is derived by hand. Two seconds of arithmetic were spent screening the two witnesses this review records, and that screen is reported as a screen.

## Claim table

| # | Claim | Verdict | Reason |
| --- | --- | --- | --- |
| 1 | $\mathrm{Alt}(A)=\tfrac13\mathfrak b(A)$ | **REFUTED AS STATED** | the constant is $\tfrac16$ under the record's own wedge, which [PhiSphere.lean](../lean/HamiltonsCubic/Results/PhiSphere.lean) and [conventions.md](../findings/conventions.md) both pin at $(\omega\wedge\omega)_{ijkl}=2\,\mathrm{Pf}_{ijkl}(\omega)$, twice the block's display |
| 2 | $\mathrm{Alt}$ and $\mathfrak b$ are proportional, with the constant nonzero | **CONFIRMED AS ALGEBRA** | the two-line computation is right up to the wedge factor, and every index step in it checks |
| 3 | $\mathrm{Alt}$ is an orthogonal projection of $S^2\Lambda^2$ onto its $\Lambda^4$ summand | **CONFIRMED** | total antisymmetry of the cyclic sum, idempotence and self-adjointness all derived below from the component formula alone |
| 4 | The middle step, $\omega_{ik}\omega_{lj}=-\omega_{ik}\omega_{jl}$, with the first and third terms needing no flip | **CONFIRMED** | the cyclic shift $(jkl)\to(klj)$ puts the two free indices of the second term in reversed order and leaves the other two terms in the order $\omega\otimes\omega$ already carries |
| 5 | The rank-one $\omega\otimes\omega$ span $S^2\Lambda^2$, so linearity suffices | **CONFIRMED** | polarisation in $\Lambda^2\mathbb R^n$, and the argument uses no eigenbasis, no orthonormality and no spectral theorem |
| 6 | The statement's appeal to an orthonormal eigenbasis | **REFUTED AS STATED** | the hypothesis is inert, the identity holding for every decomposition of $A$ into rank-one symmetric pieces, so the block claims strictly more than it uses |
| 7 | "The zero eigenvalues drop out" | **CONFIRMED** | $\mu_\alpha=0$ annihilates its own term with nothing skipped, and the surviving count is the operator rank |
| 8 | It re-derives [L179](../findings/diagonal-half.md#L642)(b) rather than assuming it, in both directions | **CONFIRMED** | the proof consumes only the component definitions, and a nonzero proportionality constant carries the equivalence both ways, so L179(b) survives the refutation of the constant untouched |
| 9 | The novelty: two names for one map in two files that do not cite each other | **GAP** | the identification is already on the record in at least four places, one of which names $\mathrm{Alt}$ "projector b" outright |
| 10 | $\mathrm{Alt}(W^2)=\tfrac13\sum_\alpha\lambda_\alpha^2\,\omega_\alpha\wedge\omega_\alpha$ | **REFUTED AS STATED** | same factor of two, and it propagates into [L199](../findings/bounds.md)'s $12\,\mathrm{Alt}(W^2)$ as $4\sum$ where the truth is $2\sum$ |
| 11 | $\mathrm{Alt}(W^2)$ is well defined despite eigenbasis freedom in a degenerate eigenspace | **CONFIRMED** | the left side is built from $W^2$ alone, and claim 5 is what makes the right side independent of the decomposition |
| 12 | $\lVert\mathrm{Alt}(W^2)\rVert\le\tfrac13\sum_\alpha\lambda_\alpha^2\lVert\omega_\alpha\wedge\omega_\alpha\rVert$ | **REFUTED** under the reading the block's own citation invites | with $\lVert\cdot\rVert_\perp$, the norm the $\Phi$-sphere identity carries and the wedge routines report, a rank-two self-dual Weyl tensor on $\mathbb R^4$ gives $0.8165>0.6667$ |
| 13 | A form with $\omega\wedge\omega=0$ is exactly a decomposable one, so the defect sits on the non-decomposable part | **CONFIRMED** | the characterisation is invariant under rescaling $\wedge$, so this clause is the one part of the estimate paragraph the normalisation cannot touch |
| 14 | The identity has content in both directions | **CONFIRMED** | two closed-form witnesses below, one with $\mathrm{Alt}(A)\ne0$ and one with $\mathrm{Alt}(A)=0$ that is a genuine Weyl tensor and is not coordinate-diagonal |

## One-line actionable summary

Replace $\tfrac13$ by $\tfrac16$ throughout the block, delete the orthonormal-eigenbasis hypothesis, restate the estimate in one named norm, and demote the novelty note to a cross-reference, after which the lemma is true and its sharp form is $\lVert\mathrm{Alt}(W^2)\rVert\le\sqrt{(n-2)/3n}\,\lVert W\rVert^2$, attained at $n=4$.

## Conventions, quoted from the brief and from the record

- **$\mathrm{Alt}$** is the projection onto the $\Lambda^4$ summand of $S^2\Lambda^2$, in components $\mathrm{Alt}(R)_{ijkl}=\tfrac13(R_{ijkl}+R_{iklj}+R_{iljk})$, as used by [L131](../findings/isotropy-cap.md).
- **$\mathfrak b:S^2\Lambda^2\to\Lambda^4$** sends $\omega\odot\eta$ to $\omega\wedge\eta$, from [L179](../findings/diagonal-half.md#L642)(b).
- The inner product on $\Lambda^2$ is $\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$, making $\{\varphi_{ab}\}_{a<b}$ orthonormal, with $\varphi_{ab}=E_{ba}-E_{ab}$. "Diagonal" means diagonal in the coordinate $2$-planes $e_i\wedge e_j$ rather than diagonal as an operator on $\Lambda^2$. Sums over pairs are over ordered pairs unless stated.
- A $2$-form satisfies $\omega\wedge\omega=0$ exactly when it is decomposable, $\omega=u\wedge v$.
- Read off [conventions.md](../findings/conventions.md) during this review, and load-bearing below: **the norm on $\Lambda^4$ is $\lVert R\rVert^2=\tfrac14\sum_{ijkl}R_{ijkl}^2$**, in which $\mathrm{Alt}(R)$ is measured, while **$\lVert\cdot\rVert_\perp$ is the multi-index-orthonormal norm $\sum_{i<j<k<l}$, six times smaller in square on the same array**, and it is $\lVert\cdot\rVert_\perp$ that the $\Phi$-sphere identity $\mathop{\mathrm{tr}}(\omega^4)+\lVert\omega\wedge\omega\rVert_\perp^2=2\langle\omega,\omega\rangle^2$ carries and that the wedge routines report.

## Hypothesis inventory, checked against the objects

| Hypothesis as written | Where it is used | Status |
| --- | --- | --- |
| $A$ symmetric on $\Lambda^2\mathbb R^n$ | needed, so that $A$ lies in $S^2\Lambda^2$ and the cyclic sum is totally antisymmetric | **used, and load-bearing** |
| $A$ has pair symmetry $A_{ijkl}=A_{klij}$ | needed for antisymmetry of $\mathrm{Alt}(A)$ in $i,j$, which is where pair symmetry enters and the block does not say so | **used, and unstated** |
| The $\omega_\alpha$ are an eigenbasis of $A$ | nowhere | **inert** |
| The $\omega_\alpha$ are orthonormal | nowhere | **inert** |
| The $\omega_\alpha$ are unit | nowhere in the identity, and it enters only in the $\Phi$-sphere step of the estimate | **inert in the lemma, live in the estimate** |
| $\mu_\alpha\ne0$ | nowhere | **inert, and this is exactly why the zero eigenvalues drop out** |
| $W^2$ shares $W$'s eigenbasis | in the consequence for L199 only, and in the harmless direction | **used, and true** |
| The normalisation of $\wedge$ | in the constant, and nowhere else | **unstated, and it decides the lemma** |
| $n\ge4$ | nowhere, and at $n<4$ both sides are zero because $\Lambda^4\mathbb R^n=0$ | **inert, the lemma reading as $0=0$** |

## 1. The wedge normalisation, which is where the claim lives or dies

Write $\mathrm{Pf}_{ijkl}(\omega):=\omega_{ij}\omega_{kl}-\omega_{ik}\omega_{jl}+\omega_{il}\omega_{jk}$, the Pfaffian of the principal $4\times4$ skew submatrix at $(i,j,k,l)$. The block's display asserts $(\omega\wedge\omega)_{ijkl}=\mathrm{Pf}_{ijkl}(\omega)$. Three normalisations of $\wedge$ on $\Lambda^2\times\Lambda^2$ are in circulation and they give three different constants:

| convention for $\alpha\wedge\beta$ | $(\omega\wedge\omega)_{ijkl}$ | the constant $c$ in $\mathrm{Alt}=c\,\mathfrak b$ |
| --- | --- | --- |
| shuffle, also called determinant: one term per $(2,2)$-shuffle | $2\,\mathrm{Pf}_{ijkl}(\omega)$ | $\tfrac16$ |
| the block's display | $\mathrm{Pf}_{ijkl}(\omega)$ | $\tfrac13$ |
| $\alpha\wedge\beta:=\mathrm{Alt}_{p+q}(\alpha\otimes\beta)$, the $1/(p+q)!$ full antisymmetriser | $\tfrac13\mathrm{Pf}_{ijkl}(\omega)$ | $1$ |

The shuffle count is six for $p=q=2$, and at $\eta=\omega$ the six terms pair off, since $\omega_{ij}\omega_{kl}$ and $\omega_{kl}\omega_{ij}$ are the same number, and likewise for the other two pairs. That is the whole of the factor two between rows one and two.

**The record's convention is the first, and it is pinned by a definition rather than by a display.** [PhiSphere.lean](../lean/HamiltonsCubic/Results/PhiSphere.lean) defines

```
def w4 (w : Matrix (Fin 6) (Fin 6) ℝ) (i j k l : Fin 6) : ℝ :=
  w i j * w k l - w i k * w j l + w i l * w j k
```

and documents it as "the $4\times4$ Pfaffian on the principal submatrix at $i<j<k<l$, **which is $(\omega\wedge\omega)_{ijkl}/2$**", with the companion sentence "$4\,\mathrm{Pf}(\omega)^2$ is $\lVert\omega\wedge\omega\rVert^2$, $\Lambda^4\mathbb R^4$ being a line spanned by the volume form and $\omega\wedge\omega$ being $2\mathrm{Pf}(\omega)$ times it". Both theorems in that file are machine-checked, and [conventions.md](../findings/conventions.md) cites it as the record's authority for the $\Phi$-sphere identity, which two reviewers agreed on.

**A second, independent pin, from the arithmetic rather than from the docstring.** Take $n=4$ and $\omega$ with $\omega_{12}=\omega_{34}=1$, extended antisymmetrically. Then $\langle\omega,\omega\rangle=\tfrac12\sum_{ij}\omega_{ij}^2=2$, and $\omega^2=-\mathrm{Id}$ gives $\mathop{\mathrm{tr}}(\omega^4)=4$. The $\Phi$-sphere identity forces $\lVert\omega\wedge\omega\rVert_\perp^2=2\cdot4-4=4$, so $\lvert(\omega\wedge\omega)_{1234}\rvert=2$. And $\mathrm{Pf}_{1234}(\omega)=1$. So the record's wedge is twice the block's display, and the block's display is not the record's wedge.

**A third pin, from the routines on disk.** [b_bianchi_constraint.py](../scripts/lib/b_bianchi_constraint.py)'s `wedge_map` sums over ordered pairs of index-pairs, so at the quad $\{1,2,3,4\}$ it collects $W_{12,34}+W_{34,12}-W_{13,24}-W_{24,13}+W_{14,23}+W_{23,14}$, which is $2\,\mathrm{Pf}$ on a rank-one $\omega\otimes\omega$. Same factor two, reached by a different road.

**Therefore the constant is $\tfrac16$.** The identity the record should carry is
$$\mathrm{Alt}(A)=\tfrac16\,\mathfrak b(A)=\tfrac16\sum_\alpha\mu_\alpha\,\omega_\alpha\wedge\omega_\alpha .$$

**Screen.** Machine arithmetic at $n=4$ on the $\omega$ above returns $\mathrm{Alt}(\omega\otimes\omega)=\tfrac13\mathrm{Pf}(\omega)$ and $=\tfrac16\cdot2\mathrm{Pf}(\omega)$ to floating precision, and returns the $\Phi$-sphere left side as $2.000$ with the wedge taken as $2\mathrm{Pf}$ against $1.250$ with it taken as $\mathrm{Pf}$, the target being $2\langle\omega,\omega\rangle^2=2$. This screens the factor. The derivation above is what establishes it.

**On "$\omega\wedge\omega=0$ iff decomposable".** True under all three rows of the table, the three wedges being nonzero multiples of each other, so this clause carries no information about the normalisation and cannot be used to pin it. The block's estimate paragraph reads as if it could.

## 2. Is $\mathrm{Alt}$ a projection, and does it land where the claim says

Write $S_{ijkl}=R_{ijkl}+R_{iklj}+R_{iljk}$ for $R\in S^2\Lambda^2$, so $\mathrm{Alt}(R)=\tfrac13S$.

**$S$ is totally antisymmetric.** Swapping $k$ and $l$ gives $R_{ijlk}+R_{ilkj}+R_{ikjl}=-R_{ijkl}-R_{iljk}-R_{iklj}=-S_{ijkl}$, using antisymmetry in the last pair three times. Swapping $j$ and $k$ gives $R_{ikjl}+R_{ijlk}+R_{ilkj}=-R_{iklj}-R_{ijkl}-R_{iljk}=-S_{ijkl}$, the same way. Swapping $i$ and $j$ is the step that consumes pair symmetry: $S_{jikl}=R_{jikl}+R_{jkli}+R_{jlik}$, and $R_{jikl}=-R_{ijkl}$, $R_{jkli}=R_{lijk}=-R_{iljk}$, $R_{jlik}=R_{ikjl}=-R_{iklj}$, so $S_{jikl}=-S_{ijkl}$. Adjacent transpositions generate $S_4$, so $S$ is alternating in all four slots.

**$\mathrm{Alt}$ is idempotent.** On a totally antisymmetric $T$ the cyclic shift $(jkl)\to(klj)$ is a three-cycle, hence even, so $T_{iklj}=T_{ijkl}=T_{iljk}$ and $\mathrm{Alt}(T)=\tfrac13\cdot3T=T$. Combined with the previous paragraph, $\mathrm{Alt}\circ\mathrm{Alt}=\mathrm{Alt}$.

**$\mathrm{Alt}$ is self-adjoint, so the projection is orthogonal.** For $T$ totally antisymmetric and any $R\in S^2\Lambda^2$, relabel $(j,k,l)\to(l,j,k)$ in $\sum_{ijkl}R_{iklj}T_{ijkl}$ to get $\sum R_{ijkl}T_{iljk}=\sum R_{ijkl}T_{ijkl}$, and likewise for the third term. Hence $\langle R,T\rangle=\langle\mathrm{Alt}(R),T\rangle$, so $\ker\mathrm{Alt}\perp\mathop{\mathrm{im}}\mathrm{Alt}$ in the record's $\tfrac14\sum_{ijkl}$ norm.

So the object the identity is about is the right one, and the two sides of the claim are both totally antisymmetric arrays. What separates them is a scalar, and only a scalar. **CONFIRMED**, and this is the half of the block that stands.

## 3. The spanning step, and what the hypotheses do

Every element of $S^2V$ is a real combination of $v\otimes v$, by $u\odot v=\tfrac12\big((u+v)\otimes(u+v)-u\otimes u-v\otimes v\big)$, at $V=\Lambda^2\mathbb R^n$ as anywhere. And $(\omega\otimes\omega)_{ijkl}=\omega_{ij}\omega_{kl}$ has both antisymmetries and the pair symmetry, so it does lie in $S^2\Lambda^2$. The spanning step is sound.

**What follows is that the eigenbasis is inert.** Both sides being linear, the identity holds for *every* expression $A=\sum_\alpha\mu_\alpha\,\omega_\alpha\otimes\omega_\alpha$ with real $\mu_\alpha$ and arbitrary $\omega_\alpha\in\Lambda^2\mathbb R^n$, orthonormal or not, eigenforms or not. The spectral theorem supplies one such expression and is otherwise unused. The block therefore states a special case of what it proves, and it states it with two hypotheses that do no work. **REFUTED AS STATED** on the hypotheses, in the direction of the statement being weaker than the proof.

## 4. The middle step, index by index

$(\omega\otimes\omega)_{iklj}=\omega_{ik}\omega_{lj}$, and $\omega_{lj}=-\omega_{jl}$, so the second term is $-\omega_{ik}\omega_{jl}$. Correct.

The first and third need no flip and it is worth saying why, since the asymmetry looks like a slip. The first term is $(\omega\otimes\omega)_{ijkl}=\omega_{ij}\omega_{kl}$, already in the order $\mathrm{Pf}$ wants. The third is $(\omega\otimes\omega)_{iljk}=\omega_{il}\omega_{jk}$, also already in that order. The reason is that the cyclic shift $(j,k,l)\mapsto(k,l,j)$ places $j$, the smaller free index of the surviving pair, in the second slot of its own factor for the first and third terms and in the *first* slot for the second. So exactly one of the three needs the flip, and it is the one the block flips. **CONFIRMED.**

## 5. The zero eigenvalues

$\mu_\alpha=0$ makes $\mu_\alpha\,\omega_\alpha\wedge\omega_\alpha$ the zero element of $\Lambda^4$ whatever $\omega_\alpha$ is, so the clause is true and needs nothing the block skips. The stronger reading, that the surviving count is the operator rank, is also right: the number of nonzero $\mu_\alpha$ counted with multiplicity is $\mathop{\mathrm{rank}}(A)$ as an operator on $\Lambda^2$. **CONFIRMED.**

## 6. Re-derivation of L179(b), and both directions

The first Bianchi identity in components is $R_{ijkl}+R_{iklj}+R_{iljk}=0$, which is $\mathrm{Alt}(R)=0$ verbatim. The identity of section 1, at any nonzero constant $c$, gives $\mathrm{Alt}(W)=c\,\sum_\alpha\lambda_\alpha\,\omega_\alpha\wedge\omega_\alpha$, and $c\ne0$ makes the vanishing of the two sides equivalent. So L179(b)'s "if and only if" comes out in full, in both directions, and the wrong constant does not touch it: a nonzero multiple of zero is zero either way.

**And it is a re-derivation rather than an assumption.** The proof of L200 quotes only the component definition of $\mathrm{Alt}$, the component form of $\omega\otimes\omega$, and the antisymmetry of $\omega$. L179(b) is nowhere in it. The only import from L179 is the *name* $\mathfrak b$, which is a definition rather than a claim. **CONFIRMED**, and this is the second half of the block that stands.

## 7. The novelty claim: is the identification already on the record

The block writes that "two names for one map stood in two files that do not cite each other". Searching the record by the object rather than by the letter, the identification is already stated in at least four places, and one of them is in the same file as L200.

| site | what it says |
| --- | --- |
| [conventions.md](../findings/conventions.md) | "$\mathrm{Alt}$ is the ORTHOGONAL PROJECTION of $S^2(\Lambda^2)$ onto $\Lambda^4$, carrying its $\tfrac13$" |
| [diagonal-half.md](../findings/diagonal-half.md#L800), about a hundred and fifty lines below L200 | "$S^2(\Lambda^2)$ splits as the Weyl part plus a symmetric part plus $\Lambda^4$, and L179 and L180 identify those last two on a spectral decomposition: **the $\Lambda^4$ component is $\sum_i\lambda_i\,\omega_i\wedge\omega_i$**" |
| [b_bianchi_constraint.py](../scripts/lib/b_bianchi_constraint.py) | "The first Bianchi identity is the vanishing of the Lambda^4 component of W in Sym^2(Lambda^2), and that component is the image of v (x) v under v -> v ^ v" |
| [review_r32_n78.py](../scripts/reviewers/r32/review_r32_n78.py) | `def bianchi_part(n, R): """The Lambda^4 component of a symmetric operator R (projector b)."""`, computing the same $\tfrac13$ cyclic sum |

[run_bianchi_defect.py](../scripts/lib/run_bianchi_defect.py) computes $\mathrm{Alt}$ by the same $\tfrac13$ cyclic sum under the docstring "the Lambda^4 component of the symmetric operator". So the record's own numerical layer has treated $\mathrm{Alt}$ as the Bianchi projector throughout, and the third site names it "projector b" outright.

**GAP.** What is genuinely new in L200 is the constant relating $\mathrm{Alt}$ to a *normalised* $\wedge$, and section 1 refutes the value the block gives it. The claim of a missing cross-reference should become a cross-reference to the four sites above.

## 8. The consequence for L199, and well-definedness

**The eigenbasis question dissolves.** If $\{\omega_\alpha\}$ is an orthonormal eigenbasis of $W$ with eigenvalues $\lambda_\alpha$, then $W^2\omega_\alpha=\lambda_\alpha^2\omega_\alpha$, so $\{\omega_\alpha\}$ is an eigenbasis of $W^2$ and $W^2=\sum_\alpha\lambda_\alpha^2\,\omega_\alpha\otimes\omega_\alpha$. The converse fails when $W$ has eigenvalues $\pm\lambda$, but the converse is not used. So the block's clause is true.

**And the arbitrary-basis worry has no bite, for the reason section 3 gives.** $\mathrm{Alt}(W^2)$ is built from the operator $W^2$ alone, so it is basis-free by construction. The identity then *proves* that $\sum_\alpha\lambda_\alpha^2\,\omega_\alpha\wedge\omega_\alpha$ is independent of the choice inside a degenerate eigenspace, rather than needing that independence as an input. **CONFIRMED.**

**The constant propagates.** With $\mathrm{Alt}=\tfrac16\mathfrak b$, L199's $\Lambda^4$ term reads
$$12\,\mathrm{Alt}(W^2)=2\sum_\alpha\lambda_\alpha^2\,\omega_\alpha\wedge\omega_\alpha ,$$
against the $4\sum$ the block's constant would give. That is a factor of two inside $G_W=4(\mathrm{Ric}(W^2)\wedge\mathrm{id})+12\,\mathrm{Alt}(W^2)-4W^2-4W^\#$, on the one term of $G_W$ the record had no handle on. **REFUTED AS STATED**, and this is where the defect costs something.

## 9. The estimate, and which norm

The block writes $\lVert\mathrm{Alt}(W^2)\rVert\le\tfrac13\sum_\alpha\lambda_\alpha^2\lVert\omega_\alpha\wedge\omega_\alpha\rVert$ and then says that $\lVert\omega\wedge\omega\rVert$ is what the $\Phi$-sphere identity controls at unit $\omega$. **Those are two different norms**, and [conventions.md](../findings/conventions.md) says in capitals that a statement mixing them is false rather than rescaled. $\lVert\mathrm{Alt}(X)\rVert$ is measured in the record's $\Lambda^4$ norm $\tfrac14\sum_{ijkl}$, while the $\Phi$-sphere identity and the wedge routines report $\lVert\cdot\rVert_\perp=\sum_{i<j<k<l}$, and on a totally antisymmetric array $\lVert X\rVert=\sqrt6\,\lVert X\rVert_\perp$.

**Under the reading the block's own citation invites the inequality is false.** Take $n=4$ and the two unit self-dual forms
$$\omega:\ \omega_{12}=\omega_{34}=\tfrac1{\sqrt2},\qquad \eta:\ \eta_{13}=\tfrac1{\sqrt2},\ \eta_{24}=-\tfrac1{\sqrt2},$$
extended antisymmetrically. Then $A=\omega\otimes\omega-\eta\otimes\eta$ has $\mathrm{Alt}(A)=0$ and $\omega\omega^{\mathsf T}=\eta\eta^{\mathsf T}=\tfrac12\mathrm{Id}$, so $A$ is Ricci-flat and traceless, and $A$ is a genuine rank-two Weyl tensor on $\mathbb R^4$. Its square is $A^2=\omega\otimes\omega+\eta\otimes\eta$, and $\mathrm{Pf}_{1234}(\omega)=\mathrm{Pf}_{1234}(\eta)=\tfrac12$, so $\mathrm{Alt}(A^2)=\tfrac13\star$ and
$$\lVert\mathrm{Alt}(A^2)\rVert=\tfrac13\sqrt6=0.816\ldots,\qquad \tfrac13\sum_\alpha\lambda_\alpha^2\lVert\omega_\alpha\wedge\omega_\alpha\rVert_\perp=\tfrac13(1+1)=0.666\ldots$$
The claimed bound is violated by a factor $\sqrt6/2$. **REFUTED.** Read instead with both norms taken as the record's $\Lambda^4$ norm the inequality is true, at twice the correct constant, so under that reading it is valid and slack rather than false. The block does not say which reading it means, and the reading it invites is the one that fails.

**What the triangle inequality costs, and it is not what one would guess.** The $\omega_\alpha\wedge\omega_\alpha$ are generally far from orthogonal in $\Lambda^4$, so one expects heavy loss. On a Weyl tensor there is a free sharpening available from Bianchi itself: since $\sum_\alpha\lambda_\alpha\,\omega_\alpha\wedge\omega_\alpha=0$, for every real $c$
$$\mathrm{Alt}(W^2)=\tfrac16\sum_\alpha(\lambda_\alpha^2-c\lambda_\alpha)\,\omega_\alpha\wedge\omega_\alpha ,\qquad\text{so}\qquad \lVert\mathrm{Alt}(W^2)\rVert\le\tfrac16\min_c\sum_\alpha\lvert\lambda_\alpha^2-c\lambda_\alpha\rvert\,\lVert\omega_\alpha\wedge\omega_\alpha\rVert .$$
That is a genuine gain in general and no gain on the witness above, where the two wedges are equal and the inequality is already an equality. Which is the point: **the falsifier of section 9 works because the estimate is tight there, so it isolates the constant rather than the slackness.**

**And the numerical bound the block says is owed comes out in closed form.** At unit $\omega$ the $\Phi$-sphere identity gives $\lVert\omega\wedge\omega\rVert_\perp^2=2-\mathop{\mathrm{tr}}(\omega^4)=2(1-\sum_i\sigma_i^4)$ at singular values with $\sum\sigma_i^2=1$, and a skew form on $\mathbb R^n$ has at most $\lfloor n/2\rfloor$ nonzero singular value pairs, so $\sum\sigma_i^4\ge2/n$ by Cauchy–Schwarz. Hence $\lVert\omega\wedge\omega\rVert_\perp\le\sqrt{2(1-2/n)}$, and with the corrected constant and one named norm,
$$\lVert\mathrm{Alt}(W^2)\rVert\ \le\ \tfrac16\sqrt6\,\sqrt{2(1-2/n)}\sum_\alpha\lambda_\alpha^2\ =\ \sqrt{\frac{n-2}{3n}}\ \lVert W\rVert^2 .$$
At $n=4$ this reads $\lVert\mathrm{Alt}(W^2)\rVert\le\lVert W\rVert^2/\sqrt6$, and the witness $A/\sqrt2$ above attains it exactly. **So the bound is sharp at $n=4$**, which is also a check on the constant $\tfrac16$: at $\tfrac13$ the same chain would produce a bound the record's own $\mathbb R^4$ Weyl tensors violate.

**Screen.** Machine arithmetic at $n=4$ returns $\lVert\mathrm{Alt}(A^2)\rVert=0.4082482904638\ldots$ for the normalised witness against $\sqrt{(n-2)/3n}=0.4082482904638\ldots$, agreeing to the last digit shown. This screens the sharpness. The derivation above is what establishes it.

## 10. Vacuity and non-vacuity, in closed form

**Non-vacuous with $\mathrm{Alt}(A)\ne0$.** $n=4$, $\omega$ with $\omega_{12}=\omega_{34}=1$, and $A=\omega\otimes\omega$. Then $\mathrm{Alt}(A)_{1234}=\tfrac13\mathrm{Pf}_{1234}(\omega)=\tfrac13$, so $\mathrm{Alt}(A)=\tfrac13\star\ne0$. This $A$ is positive semidefinite of rank one and is not a Weyl tensor, which is the point: the identity is about every symmetric operator.

**Non-vacuous with $\mathrm{Alt}(A)=0$ away from the coordinate-diagonal locus.** The witness $A=\omega\otimes\omega-\eta\otimes\eta$ of section 9. Its $\mathrm{Alt}$ vanishes because $\mathrm{Pf}(\omega)=\mathrm{Pf}(\eta)$, and it is not coordinate-diagonal, since $A_{1234}=\omega_{12}\omega_{34}-\eta_{12}\eta_{34}=\tfrac12$ is a nonzero entry at $\{1,2\}\ne\{3,4\}$. It is Ricci-flat and traceless, so it is a rank-two Weyl tensor whose Bianchi equation the identity delivers as a cancellation between two nonzero terms rather than as two vanishing ones. **Both directions have content, and the second one has it on a genuine member of $\mathcal W_4$.**

**A third, showing the decomposable clause is not vacuous either.** $\omega=\tfrac1{\sqrt2}(e_1+e_3)\wedge e_2$ is decomposable, so $\omega\wedge\omega=0$ and $\mathrm{Alt}(\omega\otimes\omega)=0$, while $A_{1223}=\omega_{12}\omega_{23}=-\tfrac12\ne0$ puts it off the coordinate-diagonal locus. So a vanishing $\mathrm{Alt}$ is reached in two different ways, by a decomposable form and by cancellation, and the block's dichotomy is real.

## 11. Arguing the opposite, and what is withdrawn

**Against the refutation of the constant.** The best defence is that $\mathfrak b$ is defined in [L179](../findings/diagonal-half.md#L642)(b) by the words "$\omega\odot\eta\mapsto\omega\wedge\eta$" with no normalisation attached, so the block is entitled to fix one, and if it fixes $(\omega\wedge\omega)_{ijkl}:=\mathrm{Pf}_{ijkl}(\omega)$ then $\tfrac13$ is correct and internally consistent. **The defence fails on the block's own citation.** Three lines below the identity the block invokes the $\Phi$-sphere identity to control $\lVert\omega\wedge\omega\rVert$, and that identity is stated in [conventions.md](../findings/conventions.md) and proved in [PhiSphere.lean](../lean/HamiltonsCubic/Results/PhiSphere.lean) at the *other* normalisation. A block may pick a convention, and it may not pick one and then quote a result stated in another. The defect stands, and its cost is section 9's false inequality and section 8's factor of two in L199.

**Against the refutation of the estimate.** One could argue that $\lVert\cdot\rVert$ in the estimate means the record's $\Lambda^4$ norm on both sides, under which the inequality is true and merely loose. That reading is available and I record it: **the estimate is not false under every reading, only under the one its own citation invites.** The verdict in the claim table is stated with that qualification, and the actionable fix is to name the norm rather than to delete the line.

**Withdrawn.** I considered flagging the phrase "the rank-one $\omega\otimes\omega$ that span $S^2\Lambda^2$" on the ground that the $\omega\otimes\omega$ are a cone rather than a subspace, so "span" would need the polarisation identity spelled out. I withdraw it. The word "span" is the standard usage for a generating set, polarisation is one line, and no step of the proof depends on the phrasing.

**Withdrawn.** I considered flagging "the zero eigenvalues drop out" as needing $\omega_\alpha$ to be defined at all when $\mu_\alpha=0$. I withdraw it. An orthonormal basis supplies an $\omega_\alpha$ at every index whatever the eigenvalue, and the term vanishes because of the scalar rather than because of the form.

**Withdrawn.** I considered whether $\mathrm{Alt}$ could fail to be self-adjoint under the record's $\tfrac14\sum_{ijkl}$ norm, which would break [conventions.md](../findings/conventions.md)'s $\lVert\mathrm{Alt}(X)\rVert\le\lVert X\rVert$ and with it section 9's whole chain. Section 2 derives self-adjointness, so I withdraw it.

## 12. What would break the lemma, and what was done to look for it

The identity is a component computation with exactly one free parameter, the normalisation of $\wedge$, and a single sign convention, the order of the cyclic shift. So there are exactly two ways to break it, and both were pursued.

- **The normalisation.** Pursued by finding a definition of $\wedge$ on the record rather than a display. Three independent pins were found and all three agree: the docstring and theorem statements in [PhiSphere.lean](../lean/HamiltonsCubic/Results/PhiSphere.lean), the arithmetic of the $\Phi$-sphere identity in [conventions.md](../findings/conventions.md) evaluated by hand at $\omega_{12}=\omega_{34}=1$, and the ordered-pair sum in [b_bianchi_constraint.py](../scripts/lib/b_bianchi_constraint.py). This is what breaks the constant.
- **The sign and index order.** Pursued by re-deriving total antisymmetry of the cyclic sum from scratch in section 2, including the pair-symmetry step the block does not mention, and by walking the three terms of the middle step separately in section 4. Nothing broke.
- **The hypotheses.** Pursued by asking of each what step consumes it, in the inventory above. Four are inert, which weakens the statement rather than falsifying it.
- **The consequences.** Pursued by constructing a Weyl tensor in closed form on $\mathbb R^4$ and evaluating both sides of the estimate exactly. This is what breaks the estimate under the $\lVert\cdot\rVert_\perp$ reading.
- **The novelty.** Pursued by grepping the record for the object under three names, "Alt", "$\Lambda^4$ component" and "Bianchi projector", across [findings/](../findings/) and [scripts/](../scripts/). Four prior sites were found, so the novelty claim is a GAP rather than a defect in the mathematics.

**What would still break the corrected lemma.** A place in the record where $\wedge$ on $\Lambda^2\times\Lambda^2$ is fixed at a third normalisation and consumed by a numbered result. I looked for one and found none: every wedge on disk that I read reports $\mathrm{Pf}$ or $2\mathrm{Pf}$, and the two are the pair section 1 distinguishes.

## Overall verdict

**REFUTED AS STATED, and repairable in one character.** The algebra is right, the projector is right, the index steps are right, the re-derivation of [L179](../findings/diagonal-half.md#L642)(b) is right and runs in both directions, and the well-definedness worry dissolves. The constant is wrong by a factor of two against the record's own machine-checked wedge, the orthonormal-eigenbasis hypothesis is inert and makes the statement weaker than the proof, the novelty note is a GAP against four prior sites, and the estimate is false under the reading its own citation invites. With $\tfrac16$ in place of $\tfrac13$, the hypotheses trimmed to "any decomposition into rank-one symmetric pieces", and one named norm, the lemma is true and its estimate sharpens to $\lVert\mathrm{Alt}(W^2)\rVert\le\sqrt{(n-2)/3n}\,\lVert W\rVert^2$, attained at $n=4$ by the rank-two self-dual Weyl tensor of section 9. That closes the numerical bound the block records as owed.

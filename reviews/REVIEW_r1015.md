# r1015, the Lean layer for the first variation: `trOp` is the trace, `phiTri` is $\Phi$, and the $\Phi$ half reaches nothing

*Cold brief, sole reviewer on the round. **No numerical work beyond three screens**, each reported as a screen and never as evidence for a positive claim: two of them are the repository's own scripts re-run unchanged, the third is three Lean declarations written here and kernel-checked. Every value is exact, rational or symbolic. The build is clean over 9219 jobs and every check ran through `lake env lean` under the project toolchain, Lean 4.33.1. Log: [agent_logs/r1015.log](../agent_logs/r1015.log).*

| # | claim | verdict |
|---|---|---|
| 1 | `trOp` is the trace on $\operatorname{End}(\Lambda^2)$ in `innerOp2`'s normalisation, `trOp_comp_comm` genuine cyclicity | **CONFIRMED** |
| 2 | `innerOp2_eq_trOp`'s hypothesis is on the correct argument and is necessary | **CONFIRMED FOR THE THEOREM, REFUTED FOR "AND ONLY THERE"** |
| 3 | `trCube2_first_variation` is the composition half of step 4 | **TRUE AS AN IDENTITY, HYPOTHESIS-DEBT AS A $t$-COEFFICIENT** |
| 4 | `phiTri` is the derivation's $\Phi$, sign and constant | **CONFIRMED, EXACTLY** |
| 5 | `phiTri_swap_outer` is the outer swap and is hypothesis-free | **CONFIRMED** |
| 6 | `crossPair2_eq_trOp` and `crossPair2_comm` with no hypothesis on $R$ | **CONFIRMED, AND THE SURPRISE IS REAL** |
| 7 | `inner2_sharpMap` and the linearity under `sharpBilRight` | **CONFIRMED** |
| 8 | `sharpPair2_eq_phiTri`'s constant, and whether it owes a hypothesis | **CONFIRMED INDEPENDENTLY, NO HYPOTHESIS OWED** |
| 9 | the three `sorry`s are true, and each states what the derivation proves | **ALL THREE TRUE, TWO FAITHFUL, `phiTri_rotate` NARROWER BY DESIGN AND ITS BINDER LOAD-BEARING** |
| 10 | `phiTri_first_variation` is the $\Phi$ half and is connected to `Pcubic2` | **HYPOTHESIS-DEBT: TWO NAMED LEMMAS ARE MISSING AND THE RECORD SAYS ONE** |
| 11 | `#print axioms` on every declaration | **31 ON THE STANDARD THREE, 4 ON `sorryAx`** |
| 12 | prose claiming more than is established | **FOUR OVERREACHES, TWO OF THEM REFUTED CONSTRUCTIVELY** |

**Actionable summary.** Every proved declaration in the three files is correct and every `sorry` sits on a true statement, but the record's headline sentence, *"the whole $\Phi$ half now rests on ONE unproved lemma"*, is short by two: trilinearity of `phiTri` and the off-diagonal pairing $\langle S,R^\#\rangle=-\tfrac12\Phi(S;R,R)$ are both absent, and without them `phiTri_first_variation` reaches `Pcubic2` through nothing at all.

## 0. Conventions, fixed once

$\Lambda^2$ is `skewSub ι`, the skew matrices as a submodule, with $\langle A,B\rangle=\tfrac12\operatorname{tr}(A^{\mathsf T}B)$, which is [inner2](../lean/HamiltonsCubic/Base/WeylReal.lean#L39). $\varphi_{ij}=E_{ji}-E_{ij}$, which is [phi](../lean/HamiltonsCubic/Base/WeylReal.lean#L45). At $i\ne j$, $\langle\varphi_{ij},\varphi_{ij}\rangle=\tfrac12\operatorname{tr}\big((E_{ij}-E_{ji})(E_{ji}-E_{ij})\big)=\tfrac12\operatorname{tr}(E_{ii}+E_{jj})=1$, distinct pairs are orthogonal, and $\varphi_{ii}=0$, so $\{\varphi_{ij}\}_{i<j}$ is an orthonormal basis of $\Lambda^2$.

**The ordered-pair doubling.** For $f$ even in each bivector slot and vanishing at $0$, $\sum_{i<j}f(\varphi_{ij})=\tfrac12\sum_{i,j}f(\varphi_{ij})$, because $\varphi_{ji}=-\varphi_{ij}$ and $\varphi_{ii}=0$. Every summand audited below is of that shape, each bivector entering to total degree two. This is the $\tfrac12$ in [innerOp2](../lean/HamiltonsCubic/Base/Bivectors2.lean#L279) and in [trOp](../lean/HamiltonsCubic/Results/TraceOp.lean#L30), and the $\tfrac14$ wherever two such sums are nested.

**Adjoints.** $A^*$ is the adjoint against $\langle\,,\rangle$ on $\Lambda^2$. [IsSelfAdjoint2](../lean/HamiltonsCubic/Results/TraceOp.lean#L116) says $\langle AX,Y\rangle=\langle X,AY\rangle$ at every pair, which is $A=A^*$. Since $\langle\,,\rangle$ is symmetric, $\operatorname{Tr}M^*=\sum_e\langle M^*e,e\rangle=\sum_e\langle e,Me\rangle=\operatorname{Tr}M$ over $\mathbb R$, a fact used twice below and stated nowhere in the layer.

**Types.** `CurvOp2 ι` is `skewSub ι →L[ℝ] skewSub ι`, so linearity and continuity of every operator argument are carried by the TYPE. Wherever a docstring below says *"with no hypothesis"* this is what it means, and the phrase is safe here in a way it was not for the record's bare `Matrix → Matrix` operators ([r1013](REVIEW_r1013.md), [r1014](REVIEW_r1014.md)).

## Hypothesis inventory

| where | hypothesis carried | needed for truth | reach of the statement |
|---|---|---|---|
| `innerOp2_eq_trOp` | `IsSelfAdjoint2 A` | sufficient, NOT necessary | holds equally at `IsSelfAdjoint2 B`, and exactly when $\operatorname{Tr}\big((A^*-A)B\big)=0$ |
| `trCube2_first_variation` | `IsSelfAdjoint2 R` | yes, used at `h1` and `h3` | an identity among four `innerOp2` values, never a derivative |
| `phiTri_swap_outer` | none | none needed | every triple of `CurvOp2` |
| `crossPair2_comm`, `crossPair2_eq_trOp` | none | none needed | every `R`, every `X`, `Y` |
| `sharpPair2_eq_phiTri` | none | none needed | every `R`, and correctly so |
| `phiTri_rotate` | `IsSelfAdjoint2 A`, bound as `_hA` | YES, the statement is FALSE without it | the specialisation, the unconditional form being $\Phi(A;B,C)=\Phi(B;C,A^*)$ |
| `hasDerivAt_Pcubic2_line` | `IsSelfAdjoint2 R`, `S` free | yes on `R`, nothing on `S` | the line derivative, never the Fréchet one |
| `foxTri2_symm_right` | all three self-adjoint | sufficient, with minimality left unchecked because checking it is a falsifier hunt | the last-two-slot swap only |

## 1. `trOp` IS the trace, in `innerOp2`'s normalisation

[trOp](../lean/HamiltonsCubic/Results/TraceOp.lean#L30) is $\tfrac12\sum_{i,j}\langle M\varphi_{ij},\varphi_{ij}\rangle$. The summand is even in $\varphi_{ij}$, being of degree two in it, and vanishes at $\varphi_{ii}=0$, so the doubling of section 0 applies and $\operatorname{trOp}M=\sum_{i<j}\langle M\varphi_{ij},\varphi_{ij}\rangle=\sum_e\langle Me,e\rangle$ over the orthonormal basis. **That is the trace, and it is the same normalisation as [innerOp2](../lean/HamiltonsCubic/Base/Bivectors2.lean#L279)**, which is $\tfrac12\sum_{i,j}\langle A\varphi_{ij},B\varphi_{ij}\rangle=\sum_e\langle Ae,Be\rangle$: the two agree on the nose at $B=\mathrm{id}$. *Screened at $n=4$ by the repository's own [screen_traceop_hypothesis.py](../scripts/misc/screen_traceop_hypothesis.py), re-run unchanged here, which returns $\operatorname{trOp}(\mathrm{id})=6=\dim\Lambda^2(\mathbb R^4)$. That is a screen of the constant and not of the identification.*

**The $\tfrac14$ in [trOp_comp_entries](../lean/HamiltonsCubic/Results/TraceOp.lean#L71) is right.** Expanding the inner value, $B\varphi_{ij}=\tfrac12\sum_{k,l}\langle B\varphi_{ij},\varphi_{kl}\rangle\varphi_{kl}$, which is `skew_expand` read through [sum_phi_inner_sub](../lean/HamiltonsCubic/Results/TraceOp.lean#L53), gives $\langle A(B\varphi_{ij}),\varphi_{ij}\rangle=\tfrac12\sum_{k,l}\mathrm{matOp}\,B\,ijkl\cdot\mathrm{matOp}\,A\,klij$, and the outer $\tfrac12$ of `trOp` multiplies it to $\tfrac14$. Two nested doublings, two halves.

**[sum4_swap](../lean/HamiltonsCubic/Results/TraceOp.lean#L93) swaps the two index PAIRS.** Its statement is $\sum_{ijkl}F(i,j,k,l)=\sum_{ijkl}F(k,l,i,j)$, and its proof goes through $\iota\times\iota$ and [Finset.sum_comm](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Algebra/BigOperators/Group/Finset/Defs.html#Finset.sum_comm) on the two product variables, so $(i,j)\leftrightarrow(k,l)$ and never $i\leftrightarrow j$. That distinction is exactly the one the identification needs, since a bare $i\leftrightarrow j$ would be a relabelling inside one basis element rather than an exchange of the two bases.

**[trOp_comp_comm](../lean/HamiltonsCubic/Results/TraceOp.lean#L105) is genuine cyclicity.** $\operatorname{trOp}(A\circ B)=\tfrac14\sum B_{ij,kl}A_{kl,ij}$ and $\operatorname{trOp}(B\circ A)=\tfrac14\sum A_{ij,kl}B_{kl,ij}$, and `sum4_swap` applied to $F(i,j,k,l)=A_{ij,kl}B_{kl,ij}$ turns the second into the first after commuting a product of reals. This is $\operatorname{Tr}(AB)=\operatorname{Tr}(BA)$ and nothing weaker: both sides are full traces of composites, with no restriction on either factor.

**Verdict: CONFIRMED.**

## 2. `innerOp2_eq_trOp`, where the hypothesis really sits

**The theorem is correct.** $\operatorname{innerOp2}(A,B)=\sum_e\langle Ae,Be\rangle=\operatorname{Tr}(A^*B)$ and $\operatorname{trOp}(A\circ B)=\operatorname{Tr}(AB)$, so the residual is
$$\operatorname{innerOp2}(A,B)-\operatorname{trOp}(A\circ B)=\operatorname{Tr}\big((A^*-A)B\big),$$
which `IsSelfAdjoint2 A` kills. **That is the exact condition, and it is weaker than either self-adjointness.**

**The hypothesis MOVES to the second argument, and the move is three rewrites from the file's own lemmas.** Because $\operatorname{Tr}M^*=\operatorname{Tr}M$, at self-adjoint $B$ one has $\operatorname{Tr}(A^*B)=\operatorname{Tr}\big((B^*A)^*\big)=\operatorname{Tr}(BA)=\operatorname{Tr}(AB)$. Screened by writing it, kernel-checked under `lake env lean` on the standard three axioms:

```lean
theorem innerOp2_eq_trOp_right (A : CurvOp2 ι) {B : CurvOp2 ι} (hB : IsSelfAdjoint2 B) :
    innerOp2 A B = trOp (A.comp B) := by
  rw [innerOp2_comm, innerOp2_eq_trOp hB A, trOp_comp_comm]
```

**So *"and only there"* is FALSE.** A concrete witness in closed form, at $n=3$: take $A=\operatorname{ad}_{\varphi_{01}}+\Pi$, where $\Pi$ is the orthogonal projection onto $\mathbb R\varphi_{01}$, and $B=\Pi$. Direct computation of the bracket at $n=3$ gives $[\varphi_{01},\varphi_{02}]=\varphi_{12}$ and $[\varphi_{01},\varphi_{12}]=-\varphi_{02}$, so $A$ is NOT self-adjoint, $\langle A\varphi_{02},\varphi_{12}\rangle=1$ against $\langle\varphi_{02},A\varphi_{12}\rangle=-1$. Both sides of the identity equal $1$: $\operatorname{innerOp2}(A,B)=\langle A\varphi_{01},\varphi_{01}\rangle=\langle\varphi_{01},\varphi_{01}\rangle=1$, and $\operatorname{trOp}(A\circ B)=\langle A\Pi\varphi_{01},\varphi_{01}\rangle=1$, the other two basis terms vanishing on both sides.

**The hypothesis cannot be dropped altogether, and the failure is generic rather than accidental.** At any skew-adjoint $A$, $\operatorname{trOp}(A\circ A)=-\operatorname{innerOp2}(A,A)$, so the two sides agree only when $\lVert A\rVert^2=0$, that is when $A=0$ by [normSq2_eq_zero](../lean/HamiltonsCubic/Base/Bivectors2.lean#L288). Screened by writing it, all three kernel-clean on the standard three axioms:

```lean
theorem trOp_comp_self_of_skewAdjoint {A : CurvOp2 ι} (hA : IsSkewAdjoint2 A) :
    trOp (A.comp A) = - innerOp2 A A
theorem innerOp2_ne_trOp_of_skewAdjoint {A : CurvOp2 ι} (hA : IsSkewAdjoint2 A) (hne : A ≠ 0) :
    innerOp2 A A ≠ trOp (A.comp A)
theorem isSkewAdjoint2_adS (X : skewSub ι) : IsSkewAdjoint2 (adS X)
```

The third inhabits the first two: `adS X` is skew-adjoint at every $X$ by [ad_skewAdjoint](../lean/HamiltonsCubic/Results/L33Statement.lean) alone, and $\operatorname{ad}_{\varphi_{01}}\ne0$ at $n\ge3$ by the bracket computed above.

**Arguing the opposite.** The strongest reading of *"and only there"* is that the identity needs a self-adjointness hypothesis SOMEWHERE rather than at $A$ specifically. Even that reading fails, since `innerOp2_eq_trOp_right` puts it at the other argument and the residual formula shows the sharp condition is a single scalar equation on the pair. The reading also has to survive $B=0$, where the identity is $0=0$ at every $A$.

**Verdict: CONFIRMED FOR THE THEOREM, REFUTED FOR "AND ONLY THERE".**

## 3. `trCube2_first_variation` is an identity, and the layer never calls it a $t$-coefficient

**The identity is what the derivation's step 4 needs on the trace side.** Expanding $(R+tS)\circ(R+tS)=R^2+t(RS+SR)+t^2S^2$ and pairing against $R+tS$, the coefficient of $t$ in $\operatorname{innerOp2}\big((R+tS)^2,R+tS\big)$ is $\operatorname{innerOp2}(SR,R)+\operatorname{innerOp2}(RS,R)+\operatorname{innerOp2}(R^2,S)$, which is exactly [trCube2_first_variation](../lean/HamiltonsCubic/Results/TraceOp.lean#L151)'s left side, and $3\operatorname{innerOp2}(S,R^2)$ is the derivation's $3\operatorname{Tr}(S^*R^2)$. **So the theorem states the right three terms and the right value.**

**NOTHING ON FILE SAYS THEY ARE THE $t$-COEFFICIENT, AND THE OBSTRUCTION IS NAMEABLE.** The expansion above needs `innerOp2` to be additive and homogeneous in each slot, and **the layer has no such lemma anywhere**: the only `innerOp2` lemmas in the whole tree are [innerOp2_comm](../lean/HamiltonsCubic/Base/Bivectors2.lean#L327) and [innerOp2_eq_trOp](../lean/HamiltonsCubic/Results/TraceOp.lean#L134), confirmed by grep over `lean/`. It also needs the distribution of `ContinuousLinearMap.comp` over the sum, which is Mathlib's and is not the issue. **`trCube2_first_variation` has no Lean consumer**, its only other occurrence in the tree being a docstring mention in [FirstVariation.lean](../lean/HamiltonsCubic/Results/FirstVariation.lean#L34).

**Where the hypothesis does work.** `hR` is consumed at `h1`, through `innerOp2_eq_trOp hR`, and at `h3`, through `hR.compOp2`. The file's own note that exactly one of the three terms needs cyclicity is correct: only `h1` calls `trOp_comp_comm`, `h2` being associativity and `h3` a bare application. *Screened by the repository's [screen_traceop_hypothesis.py](../scripts/misc/screen_traceop_hypothesis.py), re-run unchanged: the residual at the self-adjoint Weyl witness is $0$, at a non-self-adjoint $R$ with direction $S$ it is $0$ as well, and at that same $R$ with direction $W$ it is $\tfrac12$. The script's own remark that a single direction can clear a false identity by accident is borne out by its own output.*

**Verdict: TRUE AS AN IDENTITY, HYPOTHESIS-DEBT AS A $t$-COEFFICIENT.** *Owed: additivity and homogeneity of `innerOp2` in each slot, and the polynomial expansion built on them.*

## 4. `phiTri` IS $\Phi$, on the nose

The derivation defines $\Phi(A;B,C)=\sum_e\operatorname{Tr}(\operatorname{ad}_eB\operatorname{ad}_{Ae}C)$. Expanding the trace over a second basis, $\operatorname{Tr}(\operatorname{ad}_eB\operatorname{ad}_{Ae}C)=\sum_f\langle[e,B[Ae,Cf]],f\rangle$, and moving $\operatorname{ad}_e$ across by [ad_skewAdjoint](../lean/HamiltonsCubic/Results/L33Statement.lean),
$$\Phi(A;B,C)=-\sum_{e,f}\big\langle B[Ae,Cf],[e,f]\big\rangle .$$
The summand is of degree two in $e$, through $Ae$ and through $[e,f]$, and of degree two in $f$, through $Cf$ and through $[e,f]$, so each of the two basis sums doubles: $\sum_{e,f}=\tfrac14\sum_{i,j,k,l}$. **That gives exactly [phiTri](../lean/HamiltonsCubic/Results/PhiTri.lean#L52)**, with $e=\varphi_{ij}$ in the first slot of both brackets and $f=\varphi_{kl}$ in the second, and the same $-\tfrac14$. No sign and no factor is left over.

*Cross-check, independent of the file: at $R=\mathrm{id}$ the derivation's own anchor gives $\Phi(S;\mathrm{id},\mathrm{id})=-2(n-2)\operatorname{Tr}S$, and at $S=\mathrm{id}$, $n=4$, that is $-2\cdot2\cdot6=-24$, which is the value section 8 needs.*

**Verdict: CONFIRMED, EXACTLY.**

## 5. `phiTri_swap_outer` is the outer swap, and it is hypothesis-free

**The argument is sound.** Apply `sum4_swap` to the four-index summand of $\Phi(C;B,A)$, which exchanges $(i,j)$ with $(k,l)$ and leaves the summand's shape intact. The result carries $B[C\varphi_{kl},A\varphi_{ij}]$ paired against $[\varphi_{kl},\varphi_{ij}]$. [brS_neg](../lean/HamiltonsCubic/Results/PhiTri.lean#L31) reverses each bracket at the cost of a sign, $B$ carries the first sign out by its linearity, and [inner2](../lean/HamiltonsCubic/Base/WeylReal.lean#L39) is bilinear, so $(-1)(-1)=1$ and the summand is the one of $\Phi(A;B,C)$. **No structure constant is named and no index inside a pair is relabelled**, which is the file's claim and is what the proof does.

**It is really hypothesis-free**, in the precise sense that the only properties used are antisymmetry of `br`, which `brS_neg` proves by `simp [br]` at every pair, and linearity of $B$, which the type `CurvOp2` supplies. *This is genuinely cheaper than [second-order.md](../findings/second-order.md)'s step 3, which renames $g\leftrightarrow h$ and $e\leftrightarrow f$ against two copies of the totally antisymmetric $c$.* `brS_neg` itself is correct: $XY-YX=-(YX-XY)$ at every pair of matrices, skew or not.

*Screened by the repository's [screen_phitri_constants.py](../scripts/misc/screen_phitri_constants.py), re-run unchanged: $\Phi(W;W,S)-\Phi(S;W,W)=0$ exactly at $n=4$.*

**Verdict: CONFIRMED.**

## 6. `crossPair2` is a trace, and the surprise is real

**The trace identification is term by term.** Write $M=(\operatorname{ad}_X\circ R)\circ(\operatorname{ad}_Y\circ R)$. Then $M\varphi_{ij}=[X,R[Y,R\varphi_{ij}]]$, which is [crossTerm2](../lean/HamiltonsCubic/Base/Bivectors2.lean#L551) at the same indices, definitionally: the file's `hterm` is `rfl` and I confirm it is. Hence
$$\operatorname{crossPair2}(R,X,Y)=-\tfrac14\sum_{i,j}\langle M\varphi_{ij},\varphi_{ij}\rangle=-\tfrac12\cdot\tfrac12\sum_{i,j}\langle M\varphi_{ij},\varphi_{ij}\rangle=-\tfrac12\operatorname{trOp}M,$$
the two halves being the definition's $-\tfrac14$ split as $-\tfrac12$ times `trOp`'s own $\tfrac12$. **That is $-\tfrac12\operatorname{Tr}(\operatorname{ad}_XR\operatorname{ad}_YR)$**, section 1 having identified `trOp` with $\operatorname{Tr}$.

**[adS](../lean/HamiltonsCubic/Results/PhiTri.lean#L88) is the right $\operatorname{ad}$.** `adS X Y = brS X Y = [X,Y]` by `rfl`, bundled through [LinearMap.toContinuousLinearMap](https://leanprover-community.github.io/mathlib4_docs/Mathlib/Topology/Algebra/Module/FiniteDimension.html#LinearMap.toContinuousLinearMap) with `brS_add_right` and `brS_smul_right` as its two fields, which are the right slot in both cases. The bracket's first slot holds $X$, as $\operatorname{ad}_X$ requires.

**The symmetry follows with no hypothesis on $R$, and the claim is not too strong.** $\operatorname{Tr}(AB)=\operatorname{Tr}(BA)$ at $A=\operatorname{ad}_X\circ R$ and $B=\operatorname{ad}_Y\circ R$ is `trOp_comp_comm`, which section 1 confirmed is full cyclicity. *Nothing about $R$ enters beyond linearity, which is in the type.* **So [sharpBil2_eq_crossPair2](../lean/HamiltonsCubic/Results/PhiTri.lean#L115) holds and the $\tfrac12(cp+cp)$ of [sharpBil2_eq](../lean/HamiltonsCubic/Base/Bivectors2.lean#L646) was symmetrising something already symmetric.** This agrees with the derivation's step 1, which also reaches $\mathrm{sharpBil}(R,X,Y)=-\tfrac12\operatorname{Tr}(\operatorname{ad}_XR\operatorname{ad}_YR)$ *"using cyclicity for the two cross terms"*: the file has found the same fact one step earlier, before polarisation rather than after.

**Verdict: CONFIRMED, AND THE SURPRISE IS REAL.**

## 7. `inner2_sharpMap` and the linearity beneath it

[sharpMap](../lean/HamiltonsCubic/Base/Bivectors2.lean#L694) is $\tfrac12\sum_{k,l}\mathrm{sharpBil2}(R,X,\varphi_{kl})\,\varphi_{kl}$, so $\langle R^\#X,Y\rangle=\tfrac12\sum_{k,l}\mathrm{sharpBil2}(R,X,\varphi_{kl})\langle\varphi_{kl},Y\rangle$. [sum_phi_inner_sub](../lean/HamiltonsCubic/Results/TraceOp.lean#L53) says $\tfrac12\sum_{k,l}\langle Y,\varphi_{kl}\rangle f(\varphi_{kl})=f(Y)$ for a LINEAR functional $f$, which is the expansion $Y=\tfrac12\sum_{k,l}\langle Y,\varphi_{kl}\rangle\varphi_{kl}$ read against $f$. **The two $\tfrac12$s are the same one**, the ordered-pair doubling of the basis expansion, appearing once in `sharpMap`'s definition and once in the reconstruction. No second factor is needed and none is present.

**[sharpBilRight](../lean/HamiltonsCubic/Results/PhiTri.lean#L131) really is linear.** Its two fields are [sharpBil2_add_right](../lean/HamiltonsCubic/Base/Bivectors2.lean#L679) and [sharpBil2_smul_right](../lean/HamiltonsCubic/Base/Bivectors2.lean#L684), each proved by conjugating the left-slot version with [sharpBil2_comm](../lean/HamiltonsCubic/Base/Bivectors2.lean#L654), and `sharpBil2_comm` is `ring` on top of `sharpBil2_eq`, whose right side $\tfrac12(cp\,XY+cp\,YX)$ is visibly symmetric. The left-slot versions rest on [crossPair2_add_left](../lean/HamiltonsCubic/Base/Bivectors2.lean#L591) and its three siblings, each a bracket-slot linearity carried through `R` and `inner2`. **The chain closes with no circularity**: `sharpBil2_comm` does not use either right-slot lemma.

*Normalisation check: at $Y=X$ the theorem gives $\langle R^\#X,X\rangle=\mathrm{sharpBil2}(R,X,X)=\mathrm{sharpQF2}(R,X)$, which is the derivation's $\mathrm{sharpQF}$, so no factor of two hides in the polarisation.*

**Verdict: CONFIRMED.**

## 8. `sharpPair2_eq_phiTri`, the constant verified independently

**The chain, with every constant carried.** [sharpPair2_eq_sum](../lean/HamiltonsCubic/Results/PhiTri.lean#L159) turns $\operatorname{sharpPair2}R=\tfrac12\sum_{i,j}\langle R\varphi_{ij},R^\#\varphi_{ij}\rangle$ into $\tfrac12\sum_{i,j}\mathrm{sharpBil2}(R,\varphi_{ij},R\varphi_{ij})$ by `inner2_comm` and section 7. [crossPair2_bracket](../lean/HamiltonsCubic/Results/PhiTri.lean#L169) moves the outer bracket across by one `ad_skewAdjoint` per term, $\langle[X,U],\varphi_{pq}\rangle=-\langle U,[X,\varphi_{pq}]\rangle$, turning $-\tfrac14$ into $+\tfrac14$. With $X=\varphi_{ij}$ and $Y=R\varphi_{ij}$, and section 6's `sharpBil2 = crossPair2`,
$$\operatorname{sharpPair2}R=\tfrac12\cdot\tfrac14\sum_{i,j}\sum_{p,q}\big\langle R[R\varphi_{ij},R\varphi_{pq}],[\varphi_{ij},\varphi_{pq}]\big\rangle=\tfrac18\sum_{i,j,p,q}(\cdots),$$
while $\operatorname{phiTri}(R,R,R)=-\tfrac14\sum_{i,j,k,l}(\cdots)$ over the same summand. **Hence $\operatorname{sharpPair2}R=-\tfrac12\operatorname{phiTri}(R,R,R)$, and $\tfrac18=-\tfrac12\cdot(-\tfrac14)$ is where the constant comes from.** This is the derivation's $\langle S,R^\#\rangle_{\mathrm{op}}=-\tfrac12\Phi(S;R,R)$ at $S=R$.

**It owes no hypothesis it does not carry.** Every step is linearity of `R`, which the type supplies, plus `ad_skewAdjoint`, whose three skewness side conditions are all discharged by membership in `skewSub`. Self-adjointness enters nowhere, and correctly so: the identity is a definitional unfolding, not a symmetry.

*Screened by the repository's [screen_phitri_constants.py](../scripts/misc/screen_phitri_constants.py), re-run unchanged at $n=4$ on the self-dual witness $\mathrm{diag}(2,-1,-1)$: $\operatorname{sharpPair2}=12$ against $\Phi=-24$, ratio exactly $-\tfrac12$. That witness is the one [r1011](REVIEW_r1011.md) independently checked against all three `IsWeyl2` clauses, so the script's phrase "a genuine Weyl operator" is supported elsewhere rather than in the script, which asserts it without checking.*

**Verdict: CONFIRMED INDEPENDENTLY, NO HYPOTHESIS OWED.**

## 9. The three `sorry`s: each is TRUE, and what each states

**[phiTri_rotate](../lean/HamiltonsCubic/Results/PhiTri.lean#L232). TRUE, and NARROWER than the derivation by design.** Step 3's second bullet proves $\Phi(A;B,C)=\Phi(B;C,A^*)$ with no hypothesis, verified twice by [r1014](REVIEW_r1014.md) by independent routes. At `IsSelfAdjoint2 A` the adjoint is the operator itself, so $\Phi(A;B,C)=\Phi(B;C,A)$, which is what is typed. **The unused binder `_hA` is genuinely load-bearing for the TRUTH of the statement, not for its proof**: without it the plain rotation is false. *Screened by the repository's [screen_phitri_constants.py](../scripts/misc/screen_phitri_constants.py), re-run unchanged: over twelve random rational triples at $n=4$ the plain rotation fails $12/12$ and the starred form fails $0/12$.* The file's own account of why the narrower form is typed, that stating the starred one needs an adjoint on `CurvOp2` which the layer lacks, is accurate: no `adjoint` exists anywhere in the layer, and the script builds one by hand out of the $i<j$ basis. **The debt is payable.**

**[hasDerivAt_Pcubic2_line](../lean/HamiltonsCubic/Results/FirstVariation.lean#L42). TRUE, and faithful to step 4.** $\operatorname{Pcubic2}=\operatorname{trCube2}+\operatorname{sharpPair2}$ is the derivation's $P(R)=\operatorname{Tr}(R^*R^*R)-\tfrac12\Phi(R;R,R)$, since $\operatorname{innerOp2}(R\circ R,R)=\operatorname{Tr}\big((R^2)^*R\big)=\operatorname{Tr}(R^*R^*R)$ and section 8 identifies the second half. $\operatorname{Qop2}R=R^2+R^\#$, so $3\operatorname{innerOp2}(S,\operatorname{Qop2}R)=3\operatorname{Tr}(S^*R^2)-\tfrac32\Phi(S;R,R)$, which is the boxed value. The function is a cubic polynomial in $t$ on a finite-dimensional space, hence differentiable, so the `HasDerivAt` form holds. **`hR` is needed and `S` is free, exactly as stated.**

**[foxTri2_symm_right](../lean/HamiltonsCubic/Results/FirstVariation.lean#L65). TRUE under its three hypotheses.** Step 5 gives $T(X,Y,Z)=\tfrac12\operatorname{Tr}(Z^*XY)+\tfrac12\operatorname{Tr}(Z^*YX)-\tfrac14[\Phi(Z;X,Y)+\Phi(Z;Y,X)]$. At self-adjoint arguments the trace half swaps $Y$ and $Z$ by cyclicity alone, $\operatorname{Tr}(ZXY)=\operatorname{Tr}(YZX)$ and $\operatorname{Tr}(ZYX)=\operatorname{Tr}(YXZ)$, and the $\Phi$ half swaps by the outer swap for one term, $\Phi(Z;X,Y)=\Phi(Y;X,Z)$, and by the rotation for the other, $\Phi(Z;Y,X)=\Phi(X;Y,Z)=\Phi(Y;Z,X)$. **Whether all three hypotheses are individually necessary I did not test**, that being a falsifier hunt the standing rule closes. [foxTri2_comm](../lean/HamiltonsCubic/Results/FirstVariation.lean#L56) is proved with none and correctly so, `foxProd2` being symmetric in $X,Y$ by `add_comm` alone.

**Verdict: ALL THREE TRUE, TWO FAITHFUL, `phiTri_rotate` NARROWER BY DESIGN AND ITS BINDER LOAD-BEARING.**

## 10. Vacuity and use: `phiTri_first_variation` reaches nothing

**It IS the $\Phi$ half, as an identity about `phiTri`.** $\Phi(R;R,S)=\Phi(S;R,R)$ is `phiTri_swap_outer R R S`, and $\Phi(R;S,R)=\Phi(S;R,R)$ is `phiTri_rotate hR S R`, the two instantiations the derivation names. The arithmetic collapses three terms to $3\Phi(S;R,R)$.

**AND IT IS CONNECTED TO `Pcubic2` BY NOTHING.** Grep over the whole of `lean/` finds `phiTri` mentioned in no file but [PhiTri.lean](../lean/HamiltonsCubic/Results/PhiTri.lean), and `phiTri_first_variation`, `sharpPair2_eq_phiTri` and `trCube2_first_variation` each occur exactly at their own declaration, with no consumer. **There is no declaration taking the $t$-coefficient of $\operatorname{sharpPair2}(R+t\cdot S)$ to $\Phi(S;R,R)+\Phi(R;S,R)+\Phi(R;R,S)$.** *This claim has no argument on file, full stop.*

**Two named lemmas would have to be proved, and the record names neither.**

1. **`phiTri` is trilinear**, additive and homogeneous in each of its three operator slots. Without it, `sharpPair2_eq_phiTri` is a value identity at one operator and says nothing about $\operatorname{sharpPair2}(R+tS)$. *It is true and each half is one rewrite, the summand being linear in $A$, in $B$ and in $C$ separately, but no declaration states it.*
2. **The off-diagonal pairing**, $\operatorname{innerOp2}\big(S,\operatorname{sharpMapCL}R\big)=-\tfrac12\operatorname{phiTri}(S,R,R)$ at every $S$. **`sharpPair2_eq_phiTri` is only its diagonal $S=R$**, and the derivation's step 1 states the general one separately for exactly that reason. *Its proof is section 8's chain with $\varphi_{ij}$ replaced by $S\varphi_{ij}$ in the pairing slot, which the existing `crossPair2_bracket` already supports.*

Beyond those two sits the `innerOp2` bilinearity of section 3 and the polynomial expansion. **So the $\Phi$ half rests on three unproved lemmas and the record says one.**

**Verdict: HYPOTHESIS-DEBT.**

## 11. `#print axioms`, all 35 declarations

Run through `lake env lean` under the project toolchain, Lean 4.33.1, after a clean build of 9219 jobs. **Thirty-one declarations carry `[propext, Classical.choice, Quot.sound]` and nothing else.** Four carry `sorryAx`:

| declaration | file | why |
|---|---|---|
| `phiTri_rotate` | [PhiTri.lean](../lean/HamiltonsCubic/Results/PhiTri.lean#L232) | its own named `sorry` |
| `phiTri_first_variation` | [PhiTri.lean](../lean/HamiltonsCubic/Results/PhiTri.lean#L239) | **INHERITED**, its proof calls `phiTri_rotate` |
| `hasDerivAt_Pcubic2_line` | [FirstVariation.lean](../lean/HamiltonsCubic/Results/FirstVariation.lean#L42) | its own named `sorry` |
| `foxTri2_symm_right` | [FirstVariation.lean](../lean/HamiltonsCubic/Results/FirstVariation.lean#L65) | its own named `sorry` |

**The second row is the one worth stating aloud.** `phiTri_first_variation` is described everywhere as *proved*, which it is in the sense that its own proof term is complete, and it is nonetheless `sorryAx`-carrying: the round's three `sorry`s taint four declarations. *Every other declaration in all three files, including `trCube2_first_variation`, `sharpPair2_eq_phiTri`, `crossPair2_eq_trOp`, `inner2_sharpMap` and `phiTri_swap_outer`, is clean.*

**Verdict: 31 ON THE STANDARD THREE, 4 ON `sorryAx`.**

## 12. Prose that claims more than is established

**(a) *"and only there"*, THREE PLACES, REFUTED.** [TraceOp.lean](../lean/HamiltonsCubic/Results/TraceOp.lean)'s module docstring, *"Then `innerOp2 A B = trOp (A ∘ B)` AT A SELF-ADJOINT `A`, and only there, since the pairing carries an adjoint the trace does not"*; the same phrase on [innerOp2_eq_trOp](../lean/HamiltonsCubic/Results/TraceOp.lean#L134); and [lean/INDEX.md](../lean/INDEX.md)'s row 137, *"`innerOp2 A B = trOp(A∘B)` AT A SELF-ADJOINT `A` and only there"*. **Refuted in section 2 by `innerOp2_eq_trOp_right`, three rewrites from the file's own lemmas, kernel-clean.** *The correct sentence is that the identity holds exactly when $\operatorname{Tr}\big((A^*-A)B\big)=0$, for which self-adjointness of EITHER argument is sufficient.*

**(b) *"the whole $\Phi$ half now rests on ONE unproved lemma"*, THREE PLACES, SHORT BY TWO.** [plan.md](../plan.md)'s I36 item twice, *"THE $\Phi$ HALF NOW RESTS ON ONE UNPROVED LEMMA"* and *"So the whole $\Phi$ half now rests on ONE unproved lemma, `phiTri_rotate`"*, and [lean/INDEX.md](../lean/INDEX.md)'s row 138, *"so the whole $\Phi$ half rests on that one lemma"*. **Section 10 names the two that are missing**, trilinearity of `phiTri` and the off-diagonal pairing, neither of which appears on any owed list. *Arguing the opposite: read narrowly, as "`phiTri_first_variation` rests only on `phiTri_rotate`", the sentence is true. It is not written narrowly, it is written about the $\Phi$ half of the first variation, and that half is an identity about `Pcubic2`.*

**(c) *"which with it discharges both `sorry`s in FirstVariation.lean"*, [plan.md](../plan.md)'s owed list.** The two items named are `phiTri_rotate` and *"the expansion of $t\mapsto P(R+tS)$ as a cubic polynomial"*. **Those two do not discharge `foxTri2_symm_right`, which consumes no expansion in $t$ at all.** What it consumes is step 5: the polarised pairing $\langle Z,X\# Y\rangle=-\tfrac14[\Phi(Z;X,Y)+\Phi(Z;Y,X)]$, which is item 1 of section 10 in polarised form; $\operatorname{Tr}M=\operatorname{Tr}M^*$, which exists nowhere in the layer; and bilinearity of `innerOp2`, likewise absent. *The second `sorry` is the more expensive of the two and the list prices it at zero.*

**(d) *"the three terms of the $t$-coefficient"*, THREE PLACES, ATTRIBUTION BEYOND THE THEOREM.** [trCube2_first_variation](../lean/HamiltonsCubic/Results/TraceOp.lean#L151)'s docstring, [FirstVariation.lean](../lean/HamiltonsCubic/Results/FirstVariation.lean#L34)'s, and [lean/INDEX.md](../lean/INDEX.md)'s row 137. **The theorem states an identity among four `innerOp2` values and never that they are a $t$-coefficient**, and section 3 shows the missing step is nameable. *This is the mildest of the four, the mathematics being correct and the sentence being about the derivation, but the sentence sits beside a theorem and reads as its content.*

**What I checked and found CLEAN.** [lean/INDEX.md](../lean/INDEX.md) row 139's *"NOT stated"* list for [FirstVariation.lean](../lean/HamiltonsCubic/Results/FirstVariation.lean) is accurate on all three counts. Row 138's *"one named `sorry`"* and row 139's *"two named `sorry`s"* are both correct counts. [scripts/INDEX.md](../scripts/INDEX.md) row 426 is accurate, including the residual $\tfrac12$ and the admission that its first direction passed at $0$, which the re-run reproduces. Row 427's *"fails $12/12$"* and *"fails $0/12$"* both reproduce exactly. The *"$12$ against $-24$"* reproduces, and *"a genuine Weyl operator"* is supported by [r1011](REVIEW_r1011.md) rather than by the script.

**Verdict: FOUR OVERREACHES, TWO OF THEM REFUTED CONSTRUCTIVELY.**

## Dead weight, noted without a verdict

[inner2_brS_cyc](../lean/HamiltonsCubic/Results/PhiTri.lean#L37), [adS_apply](../lean/HamiltonsCubic/Results/PhiTri.lean#L94) and [IsWeyl2.isSelfAdjoint2](../lean/HamiltonsCubic/Results/TraceOp.lean) each occur exactly once in the tree, at their own declaration. *The third is the bridge from the record's Weyl class to the round's hypothesis and will be needed the moment any of this meets `IsWeyl2`, so it is provision rather than waste. The first is superseded by `crossPair2_bracket`'s direct call to `ad_skewAdjoint`.*

---

**Overall verdict: PROVEN (hypotheses corrected).** *Every one of the thirty-one proved declarations is correct, the three `sorry`s sit on true statements, and `phiTri` is $\Phi$ with no discrepancy of sign or constant anywhere in the chain. Two rows carry their own HYPOTHESIS-DEBT: `trCube2_first_variation` is an identity that nothing on file calls a $t$-coefficient, and `phiTri_first_variation` reaches `Pcubic2` through nothing, the two missing lemmas being trilinearity of `phiTri` and the off-diagonal pairing $\langle S,R^\#\rangle=-\tfrac12\Phi(S;R,R)$.*

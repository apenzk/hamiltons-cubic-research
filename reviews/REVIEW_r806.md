# r806, Gate 2 on L190 (the witness at $\dim V=4$, the cross term, and the pairing identity)

*Cold brief: I was given the three claims and the pointers, and read [findings/diagonal-half.md](../findings/diagonal-half.md), [L187Statement.lean](../lean/HamiltonsCubic/Results/L187Statement.lean), [Families.lean](../lean/HamiltonsCubic/Base/Families.lean), [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean), [CP2.lean](../lean/HamiltonsCubic/Base/CP2.lean) and [Padding.lean](../lean/HamiltonsCubic/Base/Padding.lean) from scratch. **No numerical work was done**; every value below is exact and every derivation is by hand. One machine action was a screen, reported as a screen and never as evidence for a positive claim: `lake build HamiltonsCubic.Base.CP2 HamiltonsCubic.Base.SelfDual HamiltonsCubic.Results.L187Statement`, which completed 8713 jobs with exit 0, no `sorry` in any of the four files, and lint warnings only. Log: [agent_logs/g2-l190-r806.log](../agent_logs/g2-l190-r806.log).*

| Claim | Verdict |
|---|---|
| **A**, the three-non-decomposable case is INHABITED at $\dim V=4$ by padded $W_{\mathbb{CP}^2}$ | **CONFIRMED**, every hypothesis checked and two independent non-decomposability certificates machine-checked, §1–§3 |
| **A.1**, $\omega^2=-\tfrac12\lVert\omega\rVert^2\mathrm{Id}$ on a nonzero self-dual $2$-form, hence rank four, and it applies to all three eigenforms | **CONFIRMED**, §2 |
| **B.1**, the L189 rescaling gives $NN^{\mathsf T}=M_2M_2^{\mathsf T}+M_3M_3^{\mathsf T}$ and $N\wedge N=M_2\wedge M_2+M_3\wedge M_3$, and squaring Bianchi leaves $2(M_2^{\wedge2}\wedge M_3^{\wedge2})$ | **CONFIRMED as algebra**, §4 |
| **B.2**, *that cross term* is why the determinant argument does not close | **REFUTED as the diagnosis.** The argument fails first, and independently, on the **Ricci** side; and the cross term is identically zero at $\dim V\in\{4,6\}$, so at the dimension where the witness lives there is no cross term to price, §4.2, §4.3 |
| **C.1**, $\langle\sigma(\omega),\omega\rangle=3\,\mathrm{Pf}(\omega)$, and $3\,\mathrm{Pf}(N)=\langle\sigma(M_2),N\rangle+\langle\sigma(M_3),N\rangle$ | **CONFIRMED at $\dim V=6$ and there only**, signs and conventions recomputed, §5.1, §5.2 |
| **C.2**, *"so the cross terms become inner products rather than wedges"*, offered as the instrument for pricing B's cross term | **REFUTED.** The scalar relation is **linear** in Bianchi and contains no cross term at all; and its dimension ($6$) is **disjoint** from the cross term's ($\ge8$), §5.3 |
| **The $(+,-,-)$ sign pattern** | **REFUTED as forced.** $-W_{\mathbb{CP}^2}$ realises $(+,+,-)$ with all three forms non-decomposable, and L189's proof of the pattern used the third form's decomposability. **Harmless**, because relabelling the minority form recovers the same equations (but it is inherited, not proved, and the block does not say WLOG), §6 |
| **Novelty of the block's two headline sentences** | **Both are already in the [L186](../findings/diagonal-half.md) block**, recorded two lemmas earlier, §7 |

**One line.** *The witness is real and survives every hypothesis I could put to it (this is the first result of the line that is about a class holding something) but **both instruments the block offers a successor are mis-scoped**: the cross term it says a successor must price does not exist at $\dim V\in\{4,6\}$ and is not what breaks the determinant argument anyway (the Ricci side breaks it first, at every dimension), and the pairing identity offered to price it exists only at $\dim V=6$, is linear in Bianchi, and has no cross term in it.*

## 0. Conventions, fixed once

- $W=\sum_{i=1}^{3}\lambda_i\,\omega_i\otimes\omega_i$ on $\mathbb R^n$, the $\omega_i$ orthonormal in $\Lambda^2$, every $\lambda_i\ne0$, $W$ Ricci-flat and satisfying first Bianchi; $V$ the span of the supports.
- **The $\Lambda^2$ inner product** makes $\{e_{ab}\}_{a<b}$ orthonormal, so $\lVert\omega\rVert^2=\sum_{a<b}\omega_{ab}^2$ and $\mathop{\mathrm{tr}}(\omega\omega^{\mathsf T})=2\lVert\omega\rVert^2$. *That is [L180](../findings/diagonal-half.md)(2)'s convention and Lean's `inner2`, and every constant below is stated in it.* **All three of $\omega^2=-\tfrac12\lVert\omega\rVert^2\mathrm{Id}$, $\mathop{\mathrm{tr}}A_i=2$ and $\langle\sigma(\omega),\omega\rangle=3\mathrm{Pf}(\omega)$ move if this convention moves**, so it is fixed here before anything is checked.
- A $2$-form's **support** is the image of the skew map it names. **Decomposable** $\iff\omega\wedge\omega=0\iff\mathop{\mathrm{rank}}\le2$.
- On an oriented $2m$-dimensional space, $\omega^{\wedge m}=m!\,\mathrm{Pf}(\omega)\,\mathrm{vol}$ and $\det\omega=\mathrm{Pf}(\omega)^2$.
- On $\mathbb R^6$, $\sigma(\omega)=\star(\omega\wedge\omega)/2$; $\mathrm{Padj}$ in [plan.md](../plan.md)'s I38 note is the same operator.

## 1. Claim A. The witness satisfies every hypothesis. CONFIRMED

I put the surviving case's hypotheses to padded $W_{\mathbb{CP}^2}$ one at a time. Nothing failed.

| Hypothesis of the surviving case | At padded $W_{\mathbb{CP}^2}$ | Where |
|---|---|---|
| $\Lambda^2$-rank exactly three | eigenvalues $2,-1,-1$ on $\Lambda^+$ and $0,0,0$ on $\Lambda^-$ | `WCP2_bivA`, `WCP2_bivB`, `WCP2_bivC`, `WCP2_bivA'`, `WCP2_bivB'`, `WCP2_bivC'` in [Families.lean](../lean/HamiltonsCubic/Base/Families.lean) |
| eigenforms orthonormal in $\Lambda^2$ | $\lVert a\rVert^2=\lVert b\rVert^2=\lVert c\rVert^2=2$, pairwise $0$, and each orthogonal to all of $\Lambda^-$; the unit forms are $a/\sqrt2,b/\sqrt2,c/\sqrt2$ | `gram`, `gram_minus`, `inner2_unitSD` |
| every $\lambda_i\ne0$ | $2,-1,-1$ | above |
| Ricci-flat | $\sum_i\lambda_i\,\omega_i\omega_i^{\mathsf T}=(2-1-1)\cdot\tfrac12\mathrm{Id}=0$ | `WCP2_ricciFlat` over $\mathbb R$ and over $\mathbb Q$ |
| first Bianchi | $\sum_i\lambda_i\,\omega_i\wedge\omega_i=(2-1-1)\,f_{1234}=0$ | by hand from `wedgeSelf_unitSD_apply`$=1$; `WCP2_bianchi` over $\mathbb Q$ |
| all three image forms non-decomposable | $\omega_i\wedge\omega_i=f_{1234}\ne0$, and separately $\omega_i^2=-\tfrac12\mathrm{Id}$ so $\omega_i$ is invertible | `wedgeSelf_unitSD_apply`, `unitSD_sq`, `nondecomposable_of_sq_eq_neg_smul` |
| $\dim V=4$ | each $\omega_i$ is invertible, so $\mathop{\mathrm{supp}}\omega_i=\mathbb R^4$ and $V=\mathbb R^4$ | §3 |
| the padding preserves all of it | `IsWeylOf_padOp` | [Padding.lean](../lean/HamiltonsCubic/Base/Padding.lean) |

**Two things I checked because the block asserts them and the Lean does not quite say them.**

*First, Bianchi is a HYPOTHESIS in [Families.lean](../lean/HamiltonsCubic/Base/Families.lean), not a theorem there*, `WCP2_isWeyl (hb : ∀ i j k l, bianchi WCP2 i j k l = 0)` takes it in, and the module docstring says so plainly: *"the $\Lambda^4$ identity is not typed here, so `WCP2` is given its symmetry and Ricci clauses and the Bianchi clause is taken as a hypothesis where it is needed"*. It is discharged over $\mathbb Q$ in the $6\times6$ pair basis by `WCP2_bianchi`, a `native_decide` in a **different representation** of the same object. **So the $\mathbb R$-side Bianchi is not machine-checked**, and the block's *"machine-checked"* covers the spectrum and $\theta$, not this. *It is nonetheless true by two lines of hand argument, given below, and every ingredient of those two lines IS machine-checked*, which is why this is a provenance note and not a defect.

**The hand proof of Bianchi at the witness.** Each unit self-dual form has $\omega_i\wedge\omega_i=f_{1234}$, the **same** generator of the one-dimensional $\Lambda^4\mathbb R^4$ for all three, that is `wedgeSelf_unitSD_apply (k : Fin 3) = 1`, checked for each $k$. So $\sum_i\lambda_i\,\omega_i\wedge\omega_i=\big(\sum_i\lambda_i\big)f_{1234}$, and $\sum_i\lambda_i=0$ is tracelessness. **At a self-dual operator, first Bianchi IS the vanishing of the trace over $\Lambda^+$**, which is exactly what the Families docstring says, and it holds here for a reason with no arithmetic in it: the three self-wedges coincide, so Bianchi degenerates into the trace condition Ricci-flatness already supplies.

*Second, $\theta=\sqrt{3/2}$ is conditional in [Families.lean](../lean/HamiltonsCubic/Base/Families.lean)* (`WCP2_theta (hP : Pcubic WCP2 = 18)`) and discharged over $\mathbb Q$ by `WCP2_theta_sq`, in [CP2.lean](../lean/HamiltonsCubic/Base/CP2.lean) rather than in Families as the block's sentence reads. **Immaterial to Claim A**, which needs no $\theta$ at all: the witness's inhabiting the case is independent of its $\theta$ value.

## 2. Claim A.1. The rank-four step. CONFIRMED

**The identity.** $\Lambda^+\mathbb R^4$ is spanned by $e_{12}+e_{34}$, $e_{13}-e_{24}$, $e_{14}+e_{23}$, Lean's `sdForm`, and the same three as `bivA`, `bivB`, `bivC` up to the sign convention $\phi_{31}=-\phi_{13}$. On $\omega=\alpha(e_{12}+e_{34})+\beta(e_{13}-e_{24})+\gamma(e_{14}+e_{23})$ the skew square is $\omega^2=-(\alpha^2+\beta^2+\gamma^2)\mathrm{Id}$, and $\lVert\omega\rVert^2=2(\alpha^2+\beta^2+\gamma^2)$ in §0's convention, so $\omega^2=-\tfrac12\lVert\omega\rVert^2\mathrm{Id}$ **exactly**. *At $\alpha=\beta=\gamma$ replaced by the unit normalisation this is `unitSD_sq`: $\omega^2=-\tfrac12\mathrm{Id}$.*

**The step to rank four.** $\omega\cdot(-c^{-1}\omega)=\mathrm{Id}$ with $c=\tfrac12\lVert\omega\rVert^2\ne0$, so $\omega$ is invertible and has rank four; a rank-four form is not decomposable. That is `isUnit_of_sq_eq_neg_smul` and `nondecomposable_of_sq_eq_neg_smul` in [L187Statement.lean](../lean/HamiltonsCubic/Results/L187Statement.lean), and it is right.

**Does it apply to all three eigenforms?** Yes, and the reason is worth stating precisely because the block's phrasing invites a weaker one. *In dimension four the Weyl operator is block-diagonal for $\Lambda^2=\Lambda^+\oplus\Lambda^-$ **always***, so self-duality ($W^-=0$) puts $\mathop{\mathrm{Im}}W\subseteq\Lambda^+$, and every eigenform of a nonzero eigenvalue lies in the image. All three therefore lie in $\Lambda^+$, and each is a nonzero self-dual form. **The Einstein hypothesis is not needed for this**: it is needed for the full curvature operator to split, not for the Weyl operator's own $\Lambda^\pm$ blocks. *The block's "self-dual Einstein, so $W^-=0$" reads as though Einstein bought the conclusion; self-duality is the definition of $W^-=0$ and the rest is dimension four.* **Second certificate, independent of the identity**: $\omega_i\wedge\omega_i=f_{1234}\ne0$ directly, which is non-decomposability by definition, and it is machine-checked for each of the three.

**A cheaper route to the same fact, worth recording.** On $\Lambda^+$, $\mathrm{Pf}(\omega)=\alpha^2+\beta^2+\gamma^2=\tfrac12\lVert\omega\rVert^2>0$. *A positive Pfaffian is full rank in one step and needs no inverse.*

## 3. $\dim V=4$, and it is exact

$V$ is the span of the supports of the three eigenforms. Each is invertible, so each support is all of $\mathbb R^4$ and $V=\mathbb R^4$: $\dim V=4$, **not merely $\le4$**. *After padding into $\mathbb R^n$ the same three forms lie in $\Lambda^2\mathbb R^4\subseteq\Lambda^2\mathbb R^n$ with unchanged supports, so $\dim V=4$ at every $n\ge4$*, which is what makes the witness a witness for the case rather than for one dimension of it. **Consistency check against [L180](../findings/diagonal-half.md)(3)**: the minority form is $\omega_1$ (weight $+2$), its support is $\mathbb R^4$, and indeed $\mathop{\mathrm{supp}}\omega_2+\mathop{\mathrm{supp}}\omega_3=\mathbb R^4=\mathop{\mathrm{supp}}\omega_1$, with $\dim V$ even and $\ge4$. The witness sits inside every structural statement the line has proved.

## 4. Claim B

### 4.1 The rescaling and the cross term. CONFIRMED as algebra

Under $(+,-,-)$ with $\lambda_1>0>\lambda_2,\lambda_3$, Ricci-flatness $\sum_i\lambda_i\omega_i\omega_i^{\mathsf T}=0$ rearranges to $\lambda_1\omega_1\omega_1^{\mathsf T}=\lvert\lambda_2\rvert\omega_2\omega_2^{\mathsf T}+\lvert\lambda_3\rvert\omega_3\omega_3^{\mathsf T}$, which is $NN^{\mathsf T}=M_2M_2^{\mathsf T}+M_3M_3^{\mathsf T}$; Bianchi $\sum_i\lambda_i\omega_i\wedge\omega_i=0$ rearranges to $N\wedge N=M_2\wedge M_2+M_3\wedge M_3$. **The same two square roots linearise both, exactly as at [L189](../findings/diagonal-half.md)**, because both equations are quadratic in each form with the weight in front. Correct.

Wedging Bianchi with itself: $M_2^{\wedge2}$ and $M_3^{\wedge2}$ are $4$-forms and wedge commutatively, so
$$N^{\wedge4}=\big(M_2^{\wedge2}+M_3^{\wedge2}\big)^{\wedge2}=M_2^{\wedge4}+2\big(M_2^{\wedge2}\wedge M_3^{\wedge2}\big)+M_3^{\wedge4},$$
the cross term with the coefficient $2$ the block states. **Correct.**

### 4.2 But the cross term does not exist where the case does. REFUTED as stated

$M_2^{\wedge2}\wedge M_3^{\wedge2}$ lies in $\Lambda^8V$. **At $\dim V=4$ and at $\dim V=6$ that space is zero**, so the cross term vanishes identically, and so does every other term: squaring Bianchi at those dimensions gives $0=0$. *The block writes the cross term with no dimension attached, immediately after establishing a witness at $\dim V=4$, where it is not merely small but absent.* The term is a $\dim V\ge8$ object, and under L189's own parity requirement (that $m$ be even, so that $N^{\wedge4}=(N\wedge N)^{\wedge2}$) it is a $\dim V\in\{8,12,\dots\}$ object. **The open range is $\dim V\in\{6,8,10,\dots\}$, so the block prices an obstruction that is empty on the first open dimension.**

### 4.3 And the cross term is not what breaks the determinant argument. REFUTED as the diagnosis

**L189's argument has two legs and the block replaces the wrong one.**

- *Wedge leg*: $m$ even makes $N^{\wedge m}=(N\wedge N)^{\wedge m/2}$, so Bianchi gives $\mathrm{Pf}(N)=\mathrm{Pf}(M)$, hence $\det(NN^{\mathsf T})=\det(MM^{\mathsf T})$.
- *Ricci leg*: $NN^{\mathsf T}=MM^{\mathsf T}+\lvert\lambda_3\rvert\Pi_3$ is a **nonzero positive-semidefinite bump on a positive definite matrix**, so $\det(NN^{\mathsf T})>\det(MM^{\mathsf T})$ strictly. Contradiction.

At three non-decomposable forms the Ricci leg reads $NN^{\mathsf T}=M_2M_2^{\mathsf T}+M_3M_3^{\mathsf T}$, **there is no leftover bump and no single $M$ to compare $N$ against**. The strict monotonicity has nothing to be strict about. *That failure is at every dimension, needs no wedge at all, and is visible at the witness.*

**Run the whole chain at the witness and watch it stay consistent.** At $\dim V=4$, $m=2$, so the wedge leg runs in its cleanest form: $N^{\wedge2}=N\wedge N=M_2\wedge M_2+M_3\wedge M_3$ gives $\mathrm{Pf}(N)=\mathrm{Pf}(M_2)+\mathrm{Pf}(M_3)$, **with no cross term anywhere**. With $\lambda=(2,-1,-1)$ and unit self-dual $\omega_i$: $N=\sqrt2\,\omega_1$, $M_2=\omega_2$, $M_3=\omega_3$; $\mathrm{Pf}(\omega_i)=\tfrac12$, and $\mathrm{Pf}$ is homogeneous of degree $2$ in dimension four, so $\mathrm{Pf}(N)=2\cdot\tfrac12=1$ and $\mathrm{Pf}(M_2)+\mathrm{Pf}(M_3)=\tfrac12+\tfrac12=1$. **Equal.** The Ricci leg: $NN^{\mathsf T}=2\cdot\tfrac12\mathrm{Id}=\mathrm{Id}$ and $M_2M_2^{\mathsf T}+M_3M_3^{\mathsf T}=\tfrac12\mathrm{Id}+\tfrac12\mathrm{Id}=\mathrm{Id}$. **Equal, and $\det=1=\mathrm{Pf}(N)^2$.** *Both legs are satisfied, in exact arithmetic, with no cross term in play.*

**So the honest statement of B.2 is:** *the determinant argument does not close because Ricci-flatness no longer presents one form plus a bump, and the witness shows both legs can be satisfied simultaneously; the cross term is a separate complication arising only at $\dim V\ge8$.* **The block's version attributes the failure entirely to the cross term, which at $\dim V=4$ is not there and at $\dim V=6$ is not there either.**

## 5. Claim C

### 5.1 The identity. CONFIRMED, with the signs recomputed from scratch

On $\mathbb R^6$ with $\omega=s_1e_{12}+s_2e_{34}+s_3e_{56}$:
$$\omega\wedge\omega=2\big(s_1s_2\,e_{1234}+s_1s_3\,e_{1256}+s_2s_3\,e_{3456}\big).$$
The three Hodge stars, by permutation sign against $e_{123456}$: $[1,2,3,4,5,6]$ is even so $\star e_{1234}=+e_{56}$; $[1,2,5,6,3,4]$ moves the block $(3,4)$ past $(5,6)$, four transpositions, even, so $\star e_{1256}=+e_{34}$; $[3,4,5,6,1,2]$ moves $(1,2)$ past four elements, eight transpositions, even, so $\star e_{3456}=+e_{12}$. **All three signs are $+$**, so
$$\sigma(\omega)=\tfrac12\star(\omega\wedge\omega)=s_2s_3\,e_{12}+s_1s_3\,e_{34}+s_1s_2\,e_{56},$$
the adjugate on pair spectra, and Lean's `sigma s = (s₂s₃, s₁s₃, s₁s₂)` matches it componentwise. Then
$$\langle\sigma(\omega),\omega\rangle=s_1s_2s_3+s_1s_2s_3+s_1s_2s_3=3\,s_1s_2s_3=3\,\mathrm{Pf}(\omega),$$
each of the three terms being $s_1s_2s_3$ as the block says. **`inner_sigma_self` states exactly this and it elaborates.** *This agrees with [r802](REVIEW_r802.md) and [r803](REVIEW_r803.md) on the $\star$ signs, reached here independently.*

**Frame-independence.** Both sides are $SO(6)$-invariant functions of $\omega$ ($\sigma$ is equivariant, $\mathrm{Pf}$ invariant, the inner product invariant) and every $\omega$ has a positively-oriented adapted frame (flip one $s_j$'s sign to fix the orientation). *So the identity is a statement about $\Lambda^2\mathbb R^6$ and not only about pair spectra, which the Lean layer does not carry and which the block's "on pair spectra" hedges correctly.*

### 5.2 The derived scalar relation. CONFIRMED, at $\dim V=6$

Applying $\tfrac12\star$ to Bianchi (a linear operation on the $\Lambda^4$ equation), gives $\sigma(N)=\sigma(M_2)+\sigma(M_3)$; pairing with $N$ and using §5.1 on the left gives
$$3\,\mathrm{Pf}(N)=\langle\sigma(M_2),N\rangle+\langle\sigma(M_3),N\rangle .$$
**Exactly the block's display.** *Note that $\sigma(M_2)$ and $\sigma(M_3)$ are evaluated invariantly, not in $N$'s frame, which is legitimate because $\sigma=\tfrac12\star(\cdot\wedge\cdot)$ is defined without reference to any frame.*

### 5.3 The framing around it. REFUTED

Three defects, in increasing order of seriousness.

- **The dimension is never stated in the block.** $\sigma$ is defined *"on $\Lambda^2\mathbb R^6$"* in the [L187](../findings/diagonal-half.md) block and *"at `dim 6`"* in [L187Statement.lean](../lean/HamiltonsCubic/Results/L187Statement.lean)'s section heading, and the L190 block restates neither while applying it in a setting whose whole content is $\dim V>4$. *[r802](REVIEW_r802.md) already recorded that above six dimensions $\star(\omega\wedge\omega)$ is an $(n-4)$-form and $\sigma$ does not exist; L190 reintroduces the operator with that limit dropped.*
- **At $\dim V\ge8$ the display does not typecheck.** $\sigma(M_2)\in\Lambda^{2m-4}$ there, so $\langle\sigma(M_2),N\rangle$ pairs a $(2m-4)$-form against a $2$-form and is undefined; and $\mathrm{Pf}(N)$ is read off $N^{\wedge m}$, not off $N\wedge N$, so the constant $3$ is wrong too, the general constant is $m$.
- **The sentence "so the cross terms become inner products rather than wedges" has no referent.** *The scalar relation is obtained by pairing Bianchi, an operation **linear** in the Bianchi equation. The cross term of §4.1 is obtained by **squaring** Bianchi. They are different operations, and the relation displayed contains no cross term of any kind.* **And their dimensions are disjoint**: the pairing identity exists only at $\dim V=6$, the cross term only at $\dim V\ge8$. *So the block offers, as the instrument for pricing an obstruction, an identity that is not defined at any dimension where that obstruction exists.*

**What survives.** $3\,\mathrm{Pf}(N)=\langle\sigma(M_2),N\rangle+\langle\sigma(M_3),N\rangle$ is a **correct and possibly useful scalar consequence of Bianchi at $\dim V=6$** (the first open dimension) and should be recorded as that, beside [plan.md](../plan.md)'s existing $\mathrm{Padj}$ formulation of the same case, which is the same operator under another name. *It is not an instrument for the cross term.*

## 6. The $(+,-,-)$ sign pattern. Not forced, and inherited rather than proved

**[L189](../findings/diagonal-half.md)'s block records the pattern as a theorem**, *"two hypotheses were load-bearing and unstated, and both are theorems: the $(+,-,-)$ sign pattern making $\omega_1$ the minority form, and $c>0$"*, and the L190 block carries the phrase *"under the $(+,-,-)$ sign pattern"* forward with no argument. **The proof of it does not survive the case change.** It is [L186](../findings/diagonal-half.md)'s rank count: same-signed weights on two non-decomposable forms make $\lvert\lambda_1\rvert A_1+\lvert\lambda_2\rvert A_2=\lvert\lambda_3\rvert\Pi_3$, rank $\ge4$ against rank $2$. **That count needs $\omega_3$ decomposable**, so that the right side is a projection of rank two. In the three-non-decomposable case $A_3$ has rank $\ge4$ and both sides are of rank $\ge4$: **no contradiction, and the count says nothing.**

**A falsifier in closed form.** $-W_{\mathbb{CP}^2}$ has spectrum $(-2,1,1,0,0,0)$ (weights $(+,+,-)$ after relabelling), the **same three self-dual eigenforms**, all non-decomposable, and it is a Weyl tensor because $\mathcal W_n$ is a linear space and Ricci-flatness, Bianchi and the symmetries are all linear conditions. *So the pattern $(+,+,-)$ is inhabited in exactly this case, and $(+,-,-)$ is not forced.* **This is the L187 failure mode in miniature, a hypothesis carried from a neighbouring configuration whose justification lived in that configuration's decomposable form.**

**It is nonetheless harmless, and here is why.** Under $(+,+,-)$ the minority form is the negative one, say $\omega_3$; putting $N=\sqrt{\lvert\lambda_3\rvert}\,\omega_3$, $M_2=\sqrt{\lambda_1}\,\omega_1$, $M_3=\sqrt{\lambda_2}\,\omega_2$ gives $NN^{\mathsf T}=M_2M_2^{\mathsf T}+M_3M_3^{\mathsf T}$ and $N\wedge N=M_2\wedge M_2+M_3\wedge M_3$, **the identical pair of equations**. *The shape depends only on $N$ being the minority form, and one of the three always is, by $\sum\lambda_i=0$.* So the block's equations are right; **what is wrong is the word "the", which should be "WLOG, after relabelling the minority form as $N$"**, and that WLOG is worth one line, because it is what makes the block's analysis cover both patterns rather than half the case.

## 7. Provenance: the two headline sentences are already in the record

The [L186](../findings/diagonal-half.md) block, in its own closing notes, already carries both of L190's headline claims verbatim in substance: *"three is the only case, and it is where padded $W_{\mathbb{CP}^2}$ lives, self-dual Einstein, its $W^+$ carrying three self-dual eigenforms"* and *"[I38](../plan.md)'s question is therefore exactly: can a rank-three Weyl tensor with three non-decomposable image forms have $\dim V>4$? That is the whole of it"*. The [L185](../findings/diagonal-half.md) block carries the non-decomposability of the witness's eigenforms too. **So L190's Claim A is a promotion of an existing note to a numbered lemma, not new mathematics**, legitimate, and worth saying, since the census that surrounded those notes was later corrected while these two sentences were not. *The genuinely new material in the block is §4 and §5's two instruments, and that is where both defects are.*

## 8. What would falsify each claim, and what I did to look for it

| Claim | Falsifier | What I did |
|---|---|---|
| **A** | any hypothesis of the surviving case that the witness fails | put all eight to it one at a time (§1's table): rank exactly three, orthonormality, $\lambda_i\ne0$, Ricci, Bianchi, non-decomposability of **all three**, $\dim V=4$ exactly, and preservation under padding. **All hold**, six of them machine-checked, Bianchi by a two-line hand argument whose every ingredient is machine-checked. Also checked consistency with [L180](../findings/diagonal-half.md)(3)'s minority-support statement (§3) |
| **A.1** | a self-dual form of rank $<4$; the identity failing in the record's norm convention; an eigenform outside $\Lambda^+$ | recomputed $\omega^2$ on a general element of $\Lambda^+$ and got $-(\alpha^2+\beta^2+\gamma^2)\mathrm{Id}$ against $\lVert\omega\rVert^2=2(\alpha^2+\beta^2+\gamma^2)$, so the $\tfrac12$ is exact in §0's convention; found a second, convention-free certificate ($\mathrm{Pf}=\alpha^2+\beta^2+\gamma^2>0$); confirmed the $\Lambda^\pm$ block-diagonality of the Weyl operator is automatic at $n=4$, so all three eigenforms of nonzero eigenvalue lie in $\Lambda^+$ |
| **B.1** | a wrong coefficient on the cross term, or a wedge non-commutativity spoiling it | expanded $(A+B)^{\wedge2}$ with $A,B\in\Lambda^4$, which commute; coefficient $2$ confirmed |
| **B.2** | the cross term vanishing; the determinant argument closing anyway | **found it vanishing identically at $\dim V\in\{4,6\}$**, so it is absent on the whole lower half of the open range; then ran both legs of L189's argument at the witness in exact arithmetic and found them **simultaneously satisfiable with no cross term present** ($\mathrm{Pf}(N)=1=\tfrac12+\tfrac12$, $\det(NN^{\mathsf T})=1=\mathrm{Pf}(N)^2$), which locates the real break on the Ricci leg |
| **C.1** | a wrong $\star$ sign turning $3\mathrm{Pf}$ into $s_1s_2s_3$ with a cancellation; a norm convention moving the constant | recomputed all three permutation signs from scratch and got $+,+,+$; fixed the $\Lambda^2$ convention against [L180](../findings/diagonal-half.md)(2) and Lean's `inner2_unitSD` before computing; checked $SO(6)$-invariance so the pair-spectrum identity is really a statement about $\Lambda^2\mathbb R^6$ |
| **C.2** | the relation containing a cross term after all; the identity extending past dimension six | checked the derivation is **linear** in Bianchi, so no cross term can appear; checked the degrees at $\dim V=2m$ and found $\sigma(M_2)\in\Lambda^{2m-4}$, so the pairing is undefined for $m>3$ and the constant is $m$ rather than $3$; **the instrument's dimension and the obstruction's dimension are disjoint** |
| **the sign pattern** | a proof that $(+,-,-)$ is forced here, or a witness at $(+,+,-)$ | traced L189's justification back to [L186](../findings/diagonal-half.md)'s rank count and found it uses $\omega_3$ decomposable; exhibited $-W_{\mathbb{CP}^2}$ at $(+,+,-)$, all three forms non-decomposable; then checked the equations survive relabelling, so the defect is in the recording rather than the mathematics |

**The screen, reported as a screen.** `lake build HamiltonsCubic.Base.CP2 HamiltonsCubic.Base.SelfDual HamiltonsCubic.Results.L187Statement` completed 8713 jobs, exit 0. No `sorry` occurs in [CP2.lean](../lean/HamiltonsCubic/Base/CP2.lean), [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean), [Families.lean](../lean/HamiltonsCubic/Base/Families.lean) or [L187Statement.lean](../lean/HamiltonsCubic/Results/L187Statement.lean), the one occurrence is the word inside a Families docstring. Warnings are lint only: one long line at L187Statement.lean:14 and unused-variable notes in [L186Statement.lean](../lean/HamiltonsCubic/Results/L186Statement.lean). *This establishes that the cited declarations elaborate; it establishes nothing about whether they say what the record says, which §1, §2 and §5.1 check by hand.*

## 9. Recommended repairs

1. **Attach dimensions to both instruments.** The cross term is a $\dim V\in\{8,12,\dots\}$ object; the pairing identity is a $\dim V=6$ object. **Say so in the block**, since the open range starts at six.
2. **Restate why the determinant argument fails.** The operative reason is that Ricci-flatness now reads $NN^{\mathsf T}=M_2M_2^{\mathsf T}+M_3M_3^{\mathsf T}$, with no leftover positive-semidefinite bump for L189's strict monotonicity to bite on, a failure at every dimension, and one the witness exhibits.
3. **Delete "so the cross terms become inner products rather than wedges"**, in the block and in [L187Statement.lean](../lean/HamiltonsCubic/Results/L187Statement.lean)'s closing docstring. Replace with what the relation is: a scalar consequence of first Bianchi at $\dim V=6$, to be used beside [plan.md](../plan.md)'s $\mathrm{Padj}$ formulation of the same case.
4. **Write the sign pattern as WLOG**, with the one-line reason (the minority form plays $N$ under either pattern), and record that L186's rank count does not reach this case.
5. **Say where Bianchi at the witness is discharged**, over $\mathbb Q$ in [CP2.lean](../lean/HamiltonsCubic/Base/CP2.lean), taken as a hypothesis over $\mathbb R$ in [Families.lean](../lean/HamiltonsCubic/Base/Families.lean), and record the two-line hand proof, which is shorter than either.
6. **Credit the [L186](../findings/diagonal-half.md) block** for the witness observation and the statement of the remaining question.

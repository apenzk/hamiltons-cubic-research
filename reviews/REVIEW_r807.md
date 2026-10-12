# r807, Gate 2 on L190 (the surviving case is inhabited, and the question is exactly $\dim V>4$)

*Cold brief: I was given the three claims and the pointers, and read [findings/diagonal-half.md](../findings/diagonal-half.md), [L187Statement.lean](../lean/HamiltonsCubic/Results/L187Statement.lean), [Families.lean](../lean/HamiltonsCubic/Base/Families.lean), [CP2.lean](../lean/HamiltonsCubic/Base/CP2.lean) and [plan.md](../plan.md) from scratch. **The programme is on an analysis-only footing and I opened no numerical line of work.** Every value below is exact and every derivation is by hand. One machine action was a screen, reported as a screen: [lake build](../lean/HamiltonsCubic/Results/L187Statement.lean) over `HamiltonsCubic.Results.L187Statement` and `HamiltonsCubic.Base.CP2`, 8712 jobs, no `sorry`, two style lints and three `native_decide` lints. Log: [agent_logs/g2-l190-r807.log](../agent_logs/g2-l190-r807.log).*

| Claim | Verdict |
|---|---|
| **A**, the three-non-decomposable case is inhabited at $\dim V=4$, padded $W_{\mathbb{CP}^2}$ being the witness | **CONFIRMED**, and understated: the inhabited set at $\dim V=4$ is a five-parameter family, not a point |
| **A.1**, $\omega^2=-\tfrac12\lVert\omega\rVert^2\mathrm{Id}\Rightarrow$ rank four, and it applies to all three eigenforms | **CONFIRMED**, and it holds for every nonzero element of $\Lambda^+\mathbb R^4$, so the degenerate $(-1)$-eigenplane needs no eigenbasis choice |
| **B**, the L189 rescaling applies and the determinant argument does not close | **CONFIRMED in its conclusion**, and the cross term is bounded strictly away from zero at $\dim V=8$; **the stated mechanism carries an unstated dimension hypothesis** and is vacuous at $\dim V\in\{4,6\}$ |
| **B.1**, the cross term $2(M_2^{\wedge2}\wedge M_3^{\wedge2})$ | **CONFIRMED at $\dim V=8$ only.** At $\dim V\in\{4,6\}$ the wedge-square of Bianchi is an $8$-form on a space of dimension $<8$, so the identity reads $0=0$ and there is no cross term at all |
| **B.2**, the block's diagnosis is complete | **REFUTED.** L189's contradiction has two halves and L190 breaks both: the Ricci side loses its residual rank-two bump entirely, and the witness **saturates** the inequality that replaces it |
| **C**, $\langle\sigma(\omega),\omega\rangle=3\,\mathrm{Pf}(\omega)$, giving $3\,\mathrm{Pf}(N)=\langle\sigma(M_2),N\rangle+\langle\sigma(M_3),N\rangle$ | **CONFIRMED**, constants and convention verified independently of the pair-spectrum computation |
| **The $(+,-,-)$ sign pattern** | **NOT FORCED, it is WLOG only**, by $W\mapsto-W$, and the L186 rank count that makes it a theorem at two non-decomposable forms does **not** extend. Explicit configuration with $(+,+,-)$ below |
| **"Every other branch is closed"** | **REFUTED as a statement about [I38](../plan.md).** The rank-**two** configuration is closed in the record only at $\dim V=4$; at $\dim V\ge6$ it is exactly the pair statement [plan.md](../plan.md) records as unaudited and not citable |
| **The "L178 import is sound and not circular" note under L190** | **MISFILED**, its content is [L186](../findings/diagonal-half.md)'s step, and its "both reviewers cleared it" is r800/r801 on L186, under a heading whose Gate 2 is this round |

**One line.** *This is the first result of the line whose main claim survives Gate 2 intact, the witness satisfies every hypothesis, verified by hand and machine-checked, and the case is inhabited by a five-parameter family rather than by one tensor, but two of the block's supporting sentences overreach: the cross term it names exists only at $\dim V=8$ and is vacuous at the first open dimension, and "every other branch is closed" drops the rank-two branch, which the record closes only at $\dim V=4$.*

## 0. Conventions, fixed once

- $W=\sum_{i=1}^3\lambda_i\,\omega_i\otimes\omega_i$ on $\mathbb R^n$, the $\omega_i$ orthonormal in $\Lambda^2$, every $\lambda_i\ne0$, $W$ Ricci-flat and satisfying first Bianchi; $V$ the span of the supports.
- **The inner product is $\langle\omega,\eta\rangle=\sum_{a<b}\omega_{ab}\eta_{ab}$**, which is the convention [L180](../findings/diagonal-half.md) fixes by $\operatorname{tr}(\omega\omega^{\mathsf T})=2\lVert\omega\rVert^2$ and the one `inner2` carries in [Families.lean](../lean/HamiltonsCubic/Base/Families.lean) (`gram` returns $2$ on $a=e_{01}+e_{23}$). Every constant below is in this convention.
- $\mathrm{Pf}$ on an oriented $2m$-space is fixed by $\omega^{\wedge m}=m!\,\mathrm{Pf}(\omega)\,\mathrm{vol}$; $\det\omega=\mathrm{Pf}(\omega)^2$, so $\det(\omega\omega^{\mathsf T})=\mathrm{Pf}(\omega)^4$.
- Decomposable $\iff\omega\wedge\omega=0\iff\operatorname{rank}\omega\le2$; $A_i=\omega_i\omega_i^{\mathsf T}=-\omega_i^2$, PSD of trace $2$.
- The rescaling: $N=\sqrt{\lambda_1}\,\omega_1$, $M_2=\sqrt{\lvert\lambda_2\rvert}\,\omega_2$, $M_3=\sqrt{\lvert\lambda_3\rvert}\,\omega_3$ under $\lambda_1>0>\lambda_2,\lambda_3$.

## 1. Claim A, the witness, checked hypothesis by hypothesis

**Located.** The witness is [Families.lean](../lean/HamiltonsCubic/Base/Families.lean)'s `CP2` namespace at $n=4$, $W=aa^{\mathsf T}-\tfrac12(bb^{\mathsf T}+cc^{\mathsf T})$ with $a=\varphi_{01}+\varphi_{23}$, $b=\varphi_{02}+\varphi_{31}$, $c=\varphi_{03}+\varphi_{12}$, and its pair-basis twin in [CP2.lean](../lean/HamiltonsCubic/Base/CP2.lean). I checked the $6\times6$ matrix there entry by entry against $aa^{\mathsf T}-\tfrac12(bb^{\mathsf T}+cc^{\mathsf T})$ in the ordering $(01),(02),(03),(12),(13),(23)$ and it is that operator exactly.

**Exhibited in closed form.** Normalised to the record's convention the eigenforms are $\omega_1=a/\sqrt2$, $\omega_2=b/\sqrt2$, $\omega_3=c/\sqrt2$ with $\lambda=(2,-1,-1)$:

| Hypothesis | Value | How it checks |
|---|---|---|
| Orthonormal in $\Lambda^2$ | $\langle a,a\rangle=\langle b,b\rangle=\langle c,c\rangle=2$, pairwise $0$ | `gram`, and by hand from the four nonzero coefficients of each |
| $\lambda_i\ne0$, $\Lambda^2$-rank three | $(2,-1,-1,0,0,0)$ | $aa^{\mathsf T}$ has eigenvalue $\lVert a\rVert^2=2$ on $a$; $-\tfrac12 bb^{\mathsf T}$ has $-1$ on $b$. `WCP2_bivA`, `WCP2_bivB`, `WCP2_bivC`, `WCP2_bivA'`… |
| Ricci-flat | $\sum_i\lambda_iA_i=\tfrac12(2-1-1)\mathrm{Id}=0$ | $a,b,c$ are the quaternionic triple, $aa^{\mathsf T}=bb^{\mathsf T}=cc^{\mathsf T}=\mathrm{Id}$; `bivA_gram_row` and its two siblings give exactly this, entrywise |
| First Bianchi | $\sum_i\lambda_i\,\omega_i\wedge\omega_i=(2-1-1)\,e_{0123}=0$ | $a\wedge a=b\wedge b=c\wedge c=2e_{0123}$ by hand, the two orientation-sign checks are $e_{02}\wedge e_{31}=e_{0231}=e_{0123}$ and $e_{03}\wedge e_{12}=e_{0312}=e_{0123}$, both even permutations |
| All three non-decomposable | $\omega_i\wedge\omega_i=e_{0123}\ne0$; equivalently $\omega_i^2=-\tfrac12\mathrm{Id}$, invertible | §2 |
| $\dim V=4$ | each $\omega_i$ invertible, so $\operatorname{supp}\omega_i=\mathbb R^4$ | immediate |

**Padding changes none of it.** Ricci-flatness and first Bianchi are the identities $\sum\lambda_i\omega_i^2=0$ in $S^2$ and $\sum\lambda_i\,\omega_i\wedge\omega_i=0$ in $\Lambda^4$; with every $\omega_i$ supported in the $4$-block both read block-wise, and every entry outside the block is zero on both sides. $V$ is the same four-space. **So the padded tensor is in $\mathcal W_n$ for every $n\ge4$, with $\dim V=4$.**

**Machine corroboration, and its limit.** [CP2.lean](../lean/HamiltonsCubic/Base/CP2.lean) carries `WCP2_bianchi`, `WCP2_ricciFlat`, `WCP2_isSymm` and `WCP2_normSq`, and [Bridge.lean](../lean/HamiltonsCubic/Base/Bridge.lean) bridges the pair-basis `IsBianchi` to the operator-level `bianchiOf`. *All four are `native_decide`, which trusts the compiler rather than the kernel*, so the corroboration is real but is not a kernel proof, and the hand computation above is what the verdict rests on.

**Argued the opposite.** To refute Claim A I would need one hypothesis to fail at the witness. The only candidates are first Bianchi, the one clause [Families.lean](../lean/HamiltonsCubic/Base/Families.lean) declines to type, carrying it as a hypothesis in `WCP2_isWeyl`, and the eigenbasis of the degenerate $(-1)$-eigenplane. Bianchi is the $2-1-1=0$ above, computed from the coefficients without reference to the Lean; the degeneracy is handled in §2. **Neither fails.**

**And the claim is weaker than the truth.** At $\dim V=4$ every unit $\omega\in\Lambda^+$ has $\omega^2=-\tfrac12\mathrm{Id}$ and $\omega\wedge\omega=e_{0123}$, so for **any** orthonormal basis $(\omega_1,\omega_2,\omega_3)$ of $\Lambda^+\mathbb R^4$ and **any** $\lambda$ with $\sum\lambda_i=0$ and every $\lambda_i\ne0$, both conditions hold identically. The inhabited set is therefore $SO(3)\times\{\lambda\ne0:\sum\lambda_i=0\}$ (five parameters, times scale and the $\Lambda^-$ mirror), of which $W_{\mathbb{CP}^2}$ is one ray. *[plan.md](../plan.md) already records this ("every weight vector works and L178's family is two-parameter"); the L190 block exhibits a point where the record holds a family, and does not cross-reference it.*

## 2. Claim A.1, $\omega^2=-\tfrac12\lVert\omega\rVert^2\mathrm{Id}$ and rank four

**The implication is right and is one line.** If $\omega^2=-c\,\mathrm{Id}$ with $c\ne0$ then $\omega\cdot(-c^{-1}\omega)=\mathrm{Id}$, so $\omega$ is invertible and has rank four; a decomposable form has rank two. **This is `isUnit_of_sq_eq_neg_smul` and `nondecomposable_of_sq_eq_neg_smul` in [L187Statement.lean](../lean/HamiltonsCubic/Results/L187Statement.lean)**, and both build with no `sorry`.

**The hypothesis holds at every nonzero element of $\Lambda^+\mathbb R^4$, not merely at the three named forms.** Writing $\omega=\alpha a+\beta b+\gamma c$, the triple $(a,b,c)$ satisfies $a^2=b^2=c^2=-\mathrm{Id}$ and $ab+ba=0$ and cyclically (it is a quaternionic triple) so $\omega^2=-(\alpha^2+\beta^2+\gamma^2)\mathrm{Id}$, while $\lVert\omega\rVert^2=2(\alpha^2+\beta^2+\gamma^2)$ by `gram`. Hence $\omega^2=-\tfrac12\lVert\omega\rVert^2\mathrm{Id}$ **for the whole of $\Lambda^+$**.

**Why that matters here and the block does not say it.** $W_{\mathbb{CP}^2}$ has $\lambda_2=\lambda_3=-1$, so its $(-1)$-eigenspace is a plane and its eigenbasis is not unique. *Were the identity available only at $b$ and $c$, the claim "all three image forms are non-decomposable" would depend on a choice.* Because it holds on all of $\Lambda^+$, **every** orthonormal eigenbasis gives three non-decomposable forms, and $V$ is independent of the choice, which is the step [L180](../findings/diagonal-half.md) names as owed and which is discharged here.

**Argued the opposite.** The only way to break A.1 would be a self-dual form of rank two, i.e. a decomposable $\omega\in\Lambda^+$. A decomposable $\omega=u\wedge v$ has $\omega\wedge\omega=0$, while a self-dual $\omega$ has $\omega\wedge\omega=\langle\omega,\star\omega\rangle\,\mathrm{vol}=\lVert\omega\rVert^2\mathrm{vol}$. **So the only decomposable self-dual form is zero**, and the two routes agree.

## 3. Claim B, the cross term, and what the block's diagnosis misses

### 3.1 The rescaling is correct

Under $\lambda_1>0>\lambda_2,\lambda_3$, Ricci-flatness $\sum\lambda_iA_i=0$ reads $\lambda_1\omega_1\omega_1^{\mathsf T}=\lvert\lambda_2\rvert\omega_2\omega_2^{\mathsf T}+\lvert\lambda_3\rvert\omega_3\omega_3^{\mathsf T}$, which is $NN^{\mathsf T}=M_2M_2^{\mathsf T}+M_3M_3^{\mathsf T}$; Bianchi $\sum\lambda_i\,\omega_i\wedge\omega_i=0$ reads $N\wedge N=M_2\wedge M_2+M_3\wedge M_3$, the square roots passing through because each term is quadratic in its own form. **Both are exact.**

### 3.2 The cross term exists only at $\dim V=8$

At $\dim V=2m$, wedging Bianchi with itself is $(N\wedge N)^{\wedge2}\in\Lambda^8$. **So the identity the block writes is $0=0$ unless $2m\ge8$**, and the binomial it displays,
$$N^{\wedge4}=M_2^{\wedge4}+2\,(M_2^{\wedge2}\wedge M_3^{\wedge2})+M_3^{\wedge4},$$
is the $m=4$ instance and only that: at $m=6$ the same operation is $(N\wedge N)^{\wedge3}$ with **two** distinct cross terms $3M_2^{\wedge4}\wedge M_3^{\wedge2}$ and $3M_2^{\wedge2}\wedge M_3^{\wedge4}$, and at odd $m$ the wedge-square is not the route to $\mathrm{Pf}$ at all. **The block states the formula with no dimension attached.**

*This matters because of where the open dimensions are.* By [L180](../findings/diagonal-half.md)(3) $\dim V$ is even and at least four, and L190's own question starts at $\dim V=6$. **At $\dim V=6$ (the first open dimension), the sentence has no content**, and the instrument that does exist there is Claim C's $\sigma$. **This is the L187 failure mode in miniature**: a formula exact in one configuration, written as though general. It needs "at $\dim V=8$" on its face.

### 3.3 At $\dim V=8$ the cross term is not merely present, it is bounded below

*Recorded as a positive amendment rather than a defect.* Ricci gives $NN^{\mathsf T}=M_2M_2^{\mathsf T}+M_3M_3^{\mathsf T}$, a sum of two PSD matrices, so **Minkowski's determinant inequality** applies at size $2m$:
$$\det(NN^{\mathsf T})^{1/2m}\ \ge\ \det(M_2M_2^{\mathsf T})^{1/2m}+\det(M_3M_3^{\mathsf T})^{1/2m},\qquad\text{i.e.}\qquad \lvert\mathrm{Pf}(N)\rvert^{2/m}\ \ge\ \lvert\mathrm{Pf}(M_2)\rvert^{2/m}+\lvert\mathrm{Pf}(M_3)\rvert^{2/m}.$$
At $m=4$ this is $\lvert\mathrm{Pf}(N)\rvert^{1/2}\ge\lvert\mathrm{Pf}(M_2)\rvert^{1/2}+\lvert\mathrm{Pf}(M_3)\rvert^{1/2}$, so with $x=\mathrm{Pf}(M_2)$ and $y=\mathrm{Pf}(M_3)$ both positive, $\mathrm{Pf}(N)\ge x+y+2\sqrt{xy}$. Bianchi's wedge-square, divided by $4!$, is $\mathrm{Pf}(N)=x+y+C$ with $C=(M_2^{\wedge2}\wedge M_3^{\wedge2})/(12\,\mathrm{vol})$. **Hence $C\ge2\sqrt{xy}>0$ whenever both forms are full rank and the Pfaffians share a sign.** *So the cross term cannot be made to vanish at $\dim V=8$, and a successor "pricing" it has a quantitative target rather than an unknown sign.*

### 3.4 But the block's diagnosis is incomplete, and the omission is the load-bearing half

L189's contradiction is a pair of statements about one determinant: Bianchi forces $\det(NN^{\mathsf T})=\det(MM^{\mathsf T})$, and Ricci, $NN^{\mathsf T}=MM^{\mathsf T}+\lvert\lambda_3\rvert\Pi_3$, a **nonzero rank-two PSD bump on a positive definite matrix**, forces the strict inequality. **L190 breaks both halves, and the block names only the first.**

*The Ricci half is gone because the residual bump is gone.* At three non-decomposable forms the identity is $NN^{\mathsf T}=M_2M_2^{\mathsf T}+M_3M_3^{\mathsf T}$ with **no** leftover term, so there is no "bump on a positive definite matrix" and no strict comparison to make; the correct general statement is the Minkowski inequality of §3.3, which is not strict.

**And the witness saturates it.** At $\dim V=4$, $M_2M_2^{\mathsf T}=M_3M_3^{\mathsf T}=\tfrac12\mathrm{Id}$ and $NN^{\mathsf T}=\mathrm{Id}$, so
$$\det(NN^{\mathsf T})^{1/4}=1=\left(\tfrac1{16}\right)^{1/4}+\left(\tfrac1{16}\right)^{1/4}=\tfrac12+\tfrac12,$$
**equality in Minkowski**, which holds exactly when the two PSD matrices are proportional, and here they are equal. The Bianchi half is an equality too: $\mathrm{Pf}(N)=1=\tfrac12+\tfrac12=\mathrm{Pf}(M_2)+\mathrm{Pf}(M_3)$. *So padded $W_{\mathbb{CP}^2}$ sits at the equality case of both halves of L189's argument at once.* **That is a stronger reason for Claim B than the one the block gives, and it is dimension-free**: it says the determinant route is dead at $\dim V=4$ for a reason no cross term can repair, since at $\dim V=4$ there is no cross term.

**Argued the opposite.** I tried to close the case with the determinant route anyway. Setting the cross term to zero at $m=4$ (the block's implicit "if only this vanished"), Bianchi would give $\mathrm{Pf}(N)=x+y$ against Minkowski's $\mathrm{Pf}(N)\ge x+y+2\sqrt{xy}$, **which is a contradiction whenever $xy>0$.** *So the cross term is genuinely the whole of what stands between L189's argument and closure at $\dim V=8$, and Claim B is right there.* At $\dim V=4$ the same attempt fails at once, the two inequalities being the same equality; at $\dim V=6$ there is no wedge-square to attempt. **Verdict: Claim B's conclusion CONFIRMED, its stated mechanism CONFIRMED at $\dim V=8$ and vacuous elsewhere, its diagnosis incomplete.**

## 4. Claim C, the pairing identity

**Verified twice, by routes that share no convention.** On pair spectra, $\sigma(s)=(s_2s_3,s_1s_3,s_1s_2)$ and $\langle\sigma(s),s\rangle=3s_1s_2s_3=3\,\mathrm{Pf}(s)$, `inner_sigma_self` in [L187Statement.lean](../lean/HamiltonsCubic/Results/L187Statement.lean), which builds clean. **Independently and without an adapted frame**: for $\alpha\in\Lambda^4\mathbb R^6$ the Hodge pairing is $\langle\star\alpha,\omega\rangle\,\mathrm{vol}=\omega\wedge\alpha$ (using $\star\star=+1$ on $\Lambda^4\mathbb R^6$), so
$$\langle\sigma(\omega),\omega\rangle\,\mathrm{vol}=\tfrac12\,\omega\wedge\omega\wedge\omega=\tfrac12\cdot3!\,\mathrm{Pf}(\omega)\,\mathrm{vol}=3\,\mathrm{Pf}(\omega)\,\mathrm{vol}.$$
**The identity is orientation-safe**: reversing orientation flips $\star$, hence $\sigma$, and flips $\mathrm{Pf}$ through $\omega^{\wedge3}=3!\,\mathrm{Pf}\,\mathrm{vol}$, so both sides change sign together.

**The derived relation is what the block says.** Applying $\star(\cdot)/2$ to $N\wedge N=M_2\wedge M_2+M_3\wedge M_3$ gives $\sigma(N)=\sigma(M_2)+\sigma(M_3)$ in $\Lambda^2\mathbb R^6$; pairing with $N$ gives
$$3\,\mathrm{Pf}(N)=\langle\sigma(M_2),N\rangle+\langle\sigma(M_3),N\rangle,$$
**exactly as printed, constant included.** *The $\sigma$ machinery exists only at $\dim V=6$, since $\star(\omega\wedge\omega)$ is an $(n-4)$-form, the point [r802](REVIEW_r802.md) made against L187, so this instrument and §3.2's cross term address disjoint dimensions and neither is general.*

**Two framing corrections, neither a defect in the identity.**

- **Pairing is wedging.** $\langle\sigma(M_2),N\rangle\,\mathrm{vol}=\tfrac12\,N\wedge M_2\wedge M_2$, so the scalar relation is Bianchi wedged with $N$ and read at the top degree. *"The cross terms become inner products rather than wedges" is a change of notation, not new leverage.*
- **The scalar relation is strictly weaker than what is available.** At $\dim V=6$ the star is an isomorphism $\Lambda^4\to\Lambda^2$, so Bianchi **is** the $\Lambda^2$ identity $\sigma(N)=\sigma(M_2)+\sigma(M_3)$, fifteen equations, of which the block uses one projection. *[plan.md](../plan.md) already carries this operator as $\mathrm{Padj}$ and states Bianchi in exactly that form.* Pairing against $M_2$ and $M_3$ as well gives three relations rather than one, and the full identity gives more again.

**Verdict: CONFIRMED.**

## 5. The $(+,-,-)$ sign pattern, not forced, and the carry is real

**The block writes "under the $(+,-,-)$ sign pattern" with no justification, two paragraphs below [L189](../findings/diagonal-half.md)'s note that the pattern "was load-bearing and unstated, and is a theorem".** That note is true in L189's configuration and its proof does not reach L190's.

**The L186 rank count needs a decomposable form.** It runs: two non-decomposable forms with same-signed weights put the third alone on the other side, and Ricci reads $\lvert\lambda_1\rvert A_1+\lvert\lambda_2\rvert A_2=\lvert\lambda_3\rvert\Pi_3$, rank at least four against **rank two**. *The rank-two right side is $\omega_3$ being decomposable.* At three non-decomposable forms the right side is $\lvert\lambda_3\rvert A_3$ of rank at least four and the count says nothing.

**Exhibited: a $(+,+,-)$ configuration satisfying every hypothesis.** Take any orthonormal basis $(\omega_1,\omega_2,\omega_3)$ of $\Lambda^+\mathbb R^4$ and $\lambda=(1,1,-2)$. By §1 and §2 all three forms are non-decomposable, Ricci-flatness is $\tfrac12(1+1-2)\mathrm{Id}=0$ and Bianchi is $(1+1-2)e_{0123}=0$. **So the pattern is not forced, and the majority-sign side can be the non-decomposable pair.**

**What is legitimate is a WLOG, and it costs a sign.** Relabelling the minority-sign form as $\omega_1$ and replacing $W$ by $-W$ turns $(+,+,-)$ into $(+,-,-)$; Ricci-flatness and first Bianchi are linear in $W$, the eigenforms are unchanged, and $V$ is unchanged. **So the normalisation is sound for L190's question, which is about $\dim V$ alone.** *It is not sound for anything about $\theta$*: [L178](../findings/diagonal-half.md) records that $\theta$ is odd, so $-W_{\mathbb{CP}^2}$ attains $-\sqrt{3/2}$, and the same block was corrected once already for listing sign as a symmetry. **The block should say "WLOG, by $W\mapsto-W$, which is available because the question is $\dim V$", in one clause.**

## 6. "Every other branch is closed", the rank-two branch is not

**L190 concludes: "So [I38](../plan.md)'s question is exactly: can the three-non-decomposable case have $\dim V>4$? Every other branch is closed."** I38's theorem is about $\Lambda^2$-rank **at most** three, and the census L185–L189 runs is over rank **exactly** three.

- Rank zero is $W=0$; rank one is impossible by [L179](../findings/diagonal-half.md)(c).
- **Rank two is closed in the record only at $\dim V=4$.** [L180](../findings/diagonal-half.md)'s closing note gives $\lambda_2=-\lambda_1$, hence $A_1=A_2$ and a common support $V$, and then cites "[L178](../findings/diagonal-half.md)'s step 1 already returns $\theta=0$ there", but **L178 hypothesises four-dimensional support**, which is the very thing at issue. At $\dim V\ge6$ nothing in that note runs.
- **And the rank-two configuration at $\dim V=6$ is a statement the record has explicitly declined to adopt.** It is a pair $\omega_1,\omega_2$, orthonormal, with $\omega_1\omega_1^{\mathsf T}=\omega_2\omega_2^{\mathsf T}$ and $\omega_1\wedge\omega_1=\omega_2\wedge\omega_2$, coincident squares and coincident self-wedges on a common six-dimensional support, which is [L184](../findings/diagonal-half.md)'s hypothesis **for a pair rather than a triple**. [plan.md](../plan.md) records that L184's contradictions each use only a pair and that [r783](REVIEW_r783.md) "flagged it and declined to adopt it, which is right, it is unaudited and must not be cited as the lemma."

**So the sentence claims for I38 what the census establishes for rank three.** *The repair is one word of scope*: "I38's **rank-three** question is exactly …", with the rank-two branch at $\dim V\ge6$ named as the remaining piece, or, if the pair form of L184 is put through Gate 2 and holds, cited there.

## 7. The misfiled clearance note

The final block under L190 reads "**THE L178 IMPORT IS SOUND AND NOT CIRCULAR** … step 1 is applied UNDER the hypothesis $\dim V=4$ to derive a contradiction with *exactly two non-decomposable* … Both reviewers checked it independently and both cleared it."

**Its content belongs to [L186](../findings/diagonal-half.md)**, whose block contains the two-case exclusion by L178 step 1, and its "both reviewers" are [r800](REVIEW_r800.md) and [r801](REVIEW_r801.md), who reviewed L186. **L190's own argument does not use L178 step 1 at all**, the witness is self-dual by construction, not by an implication from rank. *Left where it is, under a heading whose Gate 2 was pending, it reads as a Gate 2 clearance of L190.* **Move it to L186's block.**

## 8. Hypothesis inventory

| Hypothesis | Used where | Status |
|---|---|---|
| Orthonormality of the triple | Claim A's $\lambda$ reading off the coefficients; §5's WLOG | used |
| $\lambda_i\ne0$ | rank three; §1's five-parameter family | used |
| Ricci-flatness | Claim B's $NN^{\mathsf T}=M_2M_2^{\mathsf T}+M_3M_3^{\mathsf T}$; §3.3's Minkowski | used, load-bearing |
| First Bianchi | Claim A's witness check; Claim B's wedge; Claim C | used, load-bearing |
| $(+,-,-)$ | the three square roots in the rescaling | **assumed, WLOG-recoverable, unstated** (§5) |
| $\dim V=8$ | the cross-term formula | **used and unstated** (§3.2) |
| $\dim V=6$ | the whole of Claim C, $\sigma$ existing only there | used, and the block says so |
| [L189](../findings/diagonal-half.md) closing the two-non-decomposable case | "leaves one case" | inherited; [r804](REVIEW_r804.md) and [r805](REVIEW_r805.md) confirmed it, not re-audited here |
| [L178](../findings/diagonal-half.md) covering $\dim V=4$ | "the question is exactly $\dim V>4$" | inherited, and sound for rank three |

## 9. Falsifiers, and what was done to look for each

| Claim | What would falsify it | What I did |
|---|---|---|
| **A** | any hypothesis failing at padded $W_{\mathbb{CP}^2}$, a non-orthonormal or decomposable eigenform, a nonzero Ricci contraction, a nonzero Bianchi sum, $\dim V\ne4$, or padding breaking one of them | recomputed all six from the coefficients of $a,b,c$, including the two orientation signs in the Bianchi sum; checked the pair-basis matrix in [CP2.lean](../lean/HamiltonsCubic/Base/CP2.lean) entry by entry against $aa^{\mathsf T}-\tfrac12(bb^{\mathsf T}+cc^{\mathsf T})$; checked the padding block-wise. **None fails** |
| **A.1** | a decomposable self-dual form, or the identity holding only at the three named forms and not across the degenerate eigenplane | proved $\omega^2=-\tfrac12\lVert\omega\rVert^2\mathrm{Id}$ on all of $\Lambda^+$ from the quaternionic relations; cross-checked non-decomposability by $\omega\wedge\omega=\lVert\omega\rVert^2\mathrm{vol}$, a second route. **No such form** |
| **B** | the cross term vanishing identically, or the determinant argument closing despite it | set the cross term to zero and pushed L189's argument through: at $\dim V=8$ it **does** close, so the term is exactly the obstruction and cannot vanish (§3.3 bounds it below by $2\sqrt{\mathrm{Pf}(M_2)\mathrm{Pf}(M_3)}$); at $\dim V\in\{4,6\}$ the wedge-square is identically zero, so the stated mechanism is vacuous there, **the claim's conclusion survives, its sentence needs a dimension** |
| **B.2** | the Ricci half of L189 surviving into L190 | replaced the missing bump with Minkowski's inequality and evaluated it at the witness: **equality**, $1=\tfrac12+\tfrac12$, so the Ricci half is dead at $\dim V=4$ independently of any cross term |
| **C** | a wrong constant, a convention mismatch between $\langle\cdot,\cdot\rangle$ and $\mathrm{Pf}$, or an orientation sign | re-derived $\langle\sigma(\omega),\omega\rangle=\tfrac12\omega^{\wedge3}/\mathrm{vol}=3\mathrm{Pf}$ frame-free via $\langle\star\alpha,\omega\rangle\mathrm{vol}=\omega\wedge\alpha$, independent of the pair-spectrum computation; checked orientation reversal flips both sides. **Clean** |
| **the sign pattern** | the pattern being forced after all | constructed a $(+,+,-)$ configuration satisfying every hypothesis (§5), and traced the L186 rank count to the decomposable form it needs. **Not forced; WLOG only** |
| **the scope sentence** | rank two being closed somewhere in the record at $\dim V\ge6$ | searched [findings/](../findings/) for every treatment of rank two; the only one is [L180](../findings/diagonal-half.md)'s closing note, which routes through L178's $\dim V=4$ hypothesis. **Not closed** |

## 10. What the line's record now reads

**Four consecutive results of this line were correct about a class holding nothing or rested on a circular premise, and none of the four defects was found by the author.** L190 inverts the risk and survives it: the witness is real, satisfies every hypothesis, and the case is inhabited more widely than the block claims. *The two defects found here are of a different kind (scope and unstated hypotheses in supporting sentences, not a false main claim*) and one of them, the dimension-free formula, is the same mistake [L187](../findings/diagonal-half.md) was refuted for.

**Required amendments, in order of weight.**

1. **"Every other branch is closed" must be narrowed to rank three** (§6), with the rank-two branch at $\dim V\ge6$ named as open.
2. **The cross-term sentence needs "at $\dim V=8$"** (§3.2), and the block should say that at $\dim V=6$ (the first open dimension), the instrument is Claim C's $\sigma$ and not the wedge-square.
3. **The diagnosis should name both halves of L189's argument** (§3.4), with the witness's Minkowski equality as the dimension-free reason the determinant route is dead at four.
4. **The $(+,-,-)$ pattern should be marked WLOG-by-$W\mapsto-W$**, valid because the question is $\dim V$ (§5).
5. **The "L178 import" note belongs under [L186](../findings/diagonal-half.md)** (§7).

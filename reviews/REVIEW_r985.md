# Review r985: I53, the third orbit identity $\langle Bu,u\rangle = 0$

Gate 2, independent adversarial review, cold read from [BRIEF_I53_orbit_identity.md](BRIEF_I53_orbit_identity.md) alone. The findings files and `lean/HamiltonsCubic/Results/I53OrbitIdentity.lean` were not opened.

Log: [agent_logs/r985-i53-orbit.log](../agent_logs/r985-i53-orbit.log)

## Verdicts

| # | claim | verdict |
|---|---|---|
| 1 | $P(e^{tX}\!\cdot\!W)$ constant, from isometry plus automorphism | CONFIRMED, with one step used and not stated |
| 2 | $f^{(4)}(0) = 3T(X^4W,W,W) + 24T(X^3W,z,W) + 18T(u,u,W) + 36T(u,z,z)$ | CONFIRMED |
| 3 | $T(a,W,W) = \theta\langle a,W\rangle$ | CONFIRMED |
| 4 | $T(a,z,W) = \tfrac\theta2\langle a,z\rangle$ | CONFIRMED |
| 5 | $T(a,u,W) = \tfrac\theta2\langle a,u\rangle - T(a,z,z)$ | CONFIRMED |
| 6 | $\langle X^4W,W\rangle = \lVert u\rVert^2$ and $\langle X^3W,z\rangle = -\lVert u\rVert^2$ | CONFIRMED, both signs right |
| 7 | $\langle u,z\rangle = 0$ | CONFIRMED as a statement, and unused by the chain under review |
| 8 | the substitution yields $18\,T(u,z,z) = 0$, hence $T(u,z,z) = 0$ | CONFIRMED, the extraction is legitimate |
| 9 | $T(u,z,z) = \langle Bu,u\rangle$ | CONFIRMED, direction right |
| 10 | the record's $2$-jet objection does not bite on the orbit argument | CONFIRMED |
| 11 | non-vacuity: some critical point carries an $X$ with $z\neq0$, $u\neq0$ | CONFIRMED for the abstract theorem, witness supplied below, and the Lean gap is REAL |

Two corrections and one strengthening are in [What the round should carry away](#what-the-round-should-carry-away). Nothing in the derivation is wrong.

## Claim 2, the load-bearing step

**Route one, the multinomial theorem.** For trilinear $T$ and a smooth curve $w$, the Leibniz rule for a multilinear map gives $f^{(n)} = \sum_{i+j+k=n} \frac{n!}{i!\,j!\,k!}\,T(w^{(i)},w^{(j)},w^{(k)})$ summed over ORDERED triples. Full symmetry then merges each unordered partition of $4$, and the count of orderings is where a coefficient error would hide:

| partition | orderings | $4!/(i!j!k!)$ | product |
|---|---|---|---|
| $(4,0,0)$ | 3 | 1 | 3 |
| $(3,1,0)$ | 6 | 4 | 24 |
| $(2,2,0)$ | 3 | 6 | 18 |
| $(2,1,1)$ | 3 | 12 | 36 |

**Route two, four turns of the product rule**, carried out independently of the table. $f' = 3T(w',w,w)$, then $f'' = 3T(w'',w,w) + 6T(w',w',w)$, then $f''' = 3T(w''',w,w) + 18T(w'',w',w) + 6T(w',w',w')$, and finally $f'''' = 3T(w'''',w,w) + 24T(w''',w',w) + 18T(w'',w'',w) + 36T(w'',w',w')$. The two routes agree.

**Control.** The ordered coefficients at order $n$ sum to $3^n$, since $\sum_{i+j+k=n}\binom{n}{i,j,k} = 3^n$. Here $3+24+18+36 = 81 = 3^4$, and at order three $3+18+6 = 27$. A screen on a random symmetric $T$ on $\mathbb{R}^4$ and a random degree-six curve reproduced all of orders one to four symbolically, and four perturbation controls (each coefficient raised by one in turn) each break the match. **CONFIRMED.**

**Whether Mathlib reaches it, since the brief asks.** There is no single lemma. Mathlib carries no iterated Leibniz rule for a general bounded bilinear or trilinear map (a search for `iteratedFDeriv_bilinear` and its variants finds nothing), and [iteratedDeriv_mul](../lean/.lake/packages/mathlib/Mathlib/Analysis/Calculus/IteratedDeriv/Lemmas.lean#L420) is the binomial rule for a normed algebra's own multiplication with two factors, so it does not apply. The four-step hand route is fully supported: [IsBoundedBilinearMap.hasFDerivAt](../lean/.lake/packages/mathlib/Mathlib/Analysis/Calculus/FDeriv/Bilinear.lean#L71) and [ContinuousLinearMap.hasFDerivAt_of_bilinear](../lean/.lake/packages/mathlib/Mathlib/Analysis/Calculus/FDeriv/Bilinear.lean#L120) for the product rule on $\circ$, [IsBoundedBilinearMap.contDiff](../lean/.lake/packages/mathlib/Mathlib/Analysis/Calculus/ContDiff/Basic.lean#L194) for the smoothness side conditions, [HasDerivAt.inner](../lean/.lake/packages/mathlib/Mathlib/Analysis/InnerProductSpace/Calculus.lean#L109) for the outer pairing, and [hasDerivAt_exp_smul_const](../lean/.lake/packages/mathlib/Mathlib/Analysis/SpecialFunctions/Exponential.lean#L382) for $w' = Xw$. **So claim 2 is an obligation rather than an impossibility, and it should be recorded as one.** Until it is discharged, the Lean theorem assumes the expansion instead of deriving it, which means the kernel is checking the algebra of claim 8 and nothing about the calculus.

## Claim 8, the circularity attack

**The relation is linear in one unknown scalar with a nonzero coefficient, so the extraction is legitimate.** Write $\tau = T(u,z,z)$. The substitutions give $3\theta\lVert u\rVert^2$ from term one, $-12\theta\lVert u\rVert^2$ from term two, $9\theta\lVert u\rVert^2 - 18\tau$ from term three, and $+36\tau$ from term four. The $\theta$ part cancels and the rest is $(36-18)\tau = 18\tau = 0$. Claim 5 is a universally quantified identity specialised at $a = u$, which is legal, and neither claim 5 nor the multinomial expansion presupposes $\tau = 0$ anywhere in its own derivation. **CONFIRMED.**

**What it would look like if the two coefficients agreed, which is the brief's question.** Had term three carried $36$ rather than $18$, the $\tau$ contributions would be $-36\tau + 36\tau = 0$ and the relation would read $0 = 0$: the entire fourth-derivative identity would be a tautology and the round would have produced nothing. The check that separates the two cases is $36 \neq 18$, and the surviving coefficient is exactly $18$.

**A sharper reason the $\theta$ cancellation is not itself evidence.** $3 - 12 + 9 = 0$ is forced, not lucky. Before skew-adjointness is applied, the $\theta$ part of the substituted relation is $\theta\big(3\langle X^4W,W\rangle + 12\langle X^3W,z\rangle + 9\langle u,u\rangle\big)$, which is exactly $\tfrac32\theta\cdot\frac{d^4}{dt^4}\lVert w(t)\rVert^2\big|_0$, since that fourth derivative is $2\langle w'''',w\rangle + 8\langle w''',w'\rangle + 6\langle w'',w''\rangle$ and $(3,12,9) = \tfrac32(2,8,6)$. The action is by isometries, so $\lVert w(t)\rVert$ is constant and the $\theta$ part vanishes for that reason alone. **The consequence is that the whole content of the fourth-derivative relation is the surviving $18\,T(u,z,z)$, and the record's emphasis on the cancellation as "the whole content" inverts this.** The cancellation is the part that was always going to happen. The finding is that the remainder did not.

## Claim 9, the restatement

$Bu = z\circ z$ paired against $u$ gives $\langle Bu,u\rangle = \langle z\circ z, u\rangle = T(z,z,u) = T(u,z,z)$ by full symmetry. Independently, $\langle Bu,a\rangle = \tfrac\theta2\langle u,a\rangle - T(W,u,a)$, and claim 5 says that right side is $T(a,z,z)$, so at $a=u$ the sign is positive and the direction is as stated. **CONFIRMED.**

## Claims 3, 4, 5 and 6, the statements rather than the proofs

**Claim 3.** $T(a,W,W) = \langle a, W\circ W\rangle = \theta\langle a,W\rangle$, an exact restatement of $Q(W) = \theta W$ under full symmetry. **CONFIRMED.**

**Claim 4.** $T(a,z,W) = \langle a, z\circ W\rangle = \langle a, L_Wz\rangle$, so the paired form is equivalent to $L_Wz = \tfrac\theta2 z$. Differentiating $Q(w) = \theta w$ once gives $2z\circ W = \theta z$, which is the same thing. **CONFIRMED.**

**Claim 5.** Differentiating twice gives $2u\circ W + 2z\circ z = \theta u$, hence $L_Wu = \tfrac\theta2 u - z\circ z$ and $Bu = \tfrac\theta2 u - L_Wu = z\circ z$. Pairing against $a$ returns the brief's form exactly. **CONFIRMED.**

**Claim 6, checking the statements and not the kernel.** $X^2$ is self-adjoint because $X$ is skew, so $\langle X^4W,W\rangle = \langle X^2(X^2W),W\rangle = \langle X^2W,X^2W\rangle = \lVert u\rVert^2$, positive as stated. For the other, $\langle X^3W,z\rangle = \langle X(X^2W),XW\rangle = -\langle X^2W,X^2W\rangle = -\lVert u\rVert^2$, so the sign is negative and it is the sign the derivation needs: it is what turns the $+24$ of term two into $-12\theta\lVert u\rVert^2$. Flipping that one sign would give $3+12+9 = 24 \neq 0$ and leave a spurious $\theta$ term in the conclusion, so the statement is load-bearing and correct. **CONFIRMED.**

**Claim 7, correct but not used here.** $\langle Xv,v\rangle = 0$ for every $v$ when $X$ is skew, so $\langle u,z\rangle = \langle X(XW),XW\rangle = 0$. It is a triviality about skew operators and needs nothing about $W$. **It does not appear anywhere in the substitution chain under review**, which uses only $\langle X^4W,W\rangle$, $\langle X^3W,z\rangle$ and $\langle u,u\rangle$. The brief's gloss is right about where it does work: the third-order relation $3T(X^3W,W,W) + 18T(u,z,W) + 6T(z,z,z) = 0$ becomes $6\theta\langle u,z\rangle + 6T(z,z,z) = 0$ after the same substitutions, and claim 7 is exactly what removes its $\theta$ part, leaving $T(z,z,z) = 0$. That last also follows from $Bz = 0$ and $\langle z\circ z, z\rangle = \langle Bu,z\rangle = \langle u,Bz\rangle$, which is a consistency control the third order passes. **CONFIRMED as a statement, with the note that the record should not list it as a dependency of this argument.**

## Claim 1, the hypothesis

For $g$ an isometry and an automorphism of $\circ$, $P(g\cdot v) = \langle (gv)\circ(gv), gv\rangle = \langle g(v\circ v), gv\rangle = \langle v\circ v, v\rangle = P(v)$. Preserving the inner product and the product is therefore enough, and no derivation identity for $X$ is needed. **CONFIRMED.**

**One step is used without being stated.** The substitutions treat $\theta$ as a constant of the curve, and that needs $Q(w(t)) = \theta\,w(t)$ with the SAME $\theta$ at every $t$, not merely at $t=0$. It does hold, because $Q(gW) = g\,Q(W) = \theta\,gW$ for an automorphism $g$, so the whole orbit is critical at one value of $\theta$. It is nonetheless the step that licenses differentiating criticality at all, and the brief's three "given" identities are its first three derivatives. It should be written down. The other silent requirement is that the action be linear and smooth in $t$ so that $w^{(k)}(0) = X^kW$, which is what makes $w''' = X^3W$ and $w'''' = X^4W$ true rather than definitional.

## Claim 10, whether the objection was answered or relocated

**Answered.** The record's objection is that the parabolic $2$-jet agrees with the orbit only to $O(t^2)$, so its $t^3$ error feeds $[t^4]$. This argument never truncates: $w(t) = e^{tX}\cdot W$ is the orbit itself, and its third and fourth derivatives are the exact vectors $X^3W$ and $X^4W$, which are retained in terms one and two rather than dropped. They are then eliminated exactly, and this is the point that decides the claim: $X^3W$ and $X^4W$ enter the relation only through the two scalars $\langle X^4W,W\rangle$ and $\langle X^3W,z\rangle$, because claims 3 and 4 hold for EVERY $a$ and so apply at $a = X^4W$ and $a = X^3W$. Both scalars are determined by $\lVert u\rVert^2$. No residue of the unknown higher jets survives, so the contamination is removed rather than moved. **CONFIRMED.**

## Claim 11, vacuity

**The pair condition is a single condition, which the brief does not say and which settles most of the question.** For skew $X$, $\langle u,W\rangle = \langle X^2W,W\rangle = -\lVert XW\rVert^2 = -\lVert z\rVert^2$. Hence $u = 0$ forces $z = 0$, and $z = 0$ forces $u = Xz = 0$. **So $z\neq0$ and $u\neq0$ are equivalent, and the hypothesis reduces to: $W$ is not a fixed point of the one-parameter subgroup $e^{tX}$.** The theorem is vacuous only if every critical point is fixed by the whole group.

**A witness satisfying every hypothesis, built for this review.** Take $V = \mathbb{R}^4 \cong \mathbb{C}^2$ with coordinates $\zeta_1,\zeta_2$ and the standard inner product, the circle acting by $(\zeta_1,\zeta_2)\mapsto(e^{i\varphi}\zeta_1, e^{2i\varphi}\zeta_2)$, and $P = \mathrm{Re}(\overline{\zeta_2}\zeta_1^2)$, with $T$ the polarisation of $P$ and $\circ$ defined by $\langle a\circ b,c\rangle = T(a,b,c)$, which makes $\circ$ commutative and $T$ fully symmetric by construction. The action is by isometries and preserves $P$, hence is by automorphisms of $\circ$. Then $W = (\sqrt2,0,1,0)$ is critical with $\theta = 2/3$, and for the generator $X$,

$$z = (0,\sqrt2,0,2)\neq0,\qquad u = (-\sqrt2,0,-4,0)\neq0,\qquad \lVert u\rVert^2 = 18 .$$

**The witness is non-degenerate in the three ways that matter.** $T$ does not vanish on the vectors involved, since $T(u,u,u) = -8$. $z\circ z = (4\sqrt2/3,\,0,\,-2/3,\,0) \neq 0$, so $u$ is outside $\ker B$ and $\langle Bu,u\rangle = 0$ is not the statement that $Bu$ itself vanishes. And the vanishing is a cancellation rather than a support accident: the four summands of $\langle z\circ z, u\rangle$ are $-8/3,\,0,\,+8/3,\,0$. **The identity therefore has content, and claim 11 is CONFIRMED at the level of the abstract theorem.**

**The gap the brief names is real and I confirm it.** A witness inside the Lean file would close it, and the one above is small enough to type. **Two obligations should be recorded, because the witness above does not discharge the second.** The abstract theorem is non-vacuous, which the witness settles. Whether the programme's own $V$, product and group carry a critical point that the group moves is a separate question I cannot reach from the brief, since the brief gives the abstract setting only. If every critical point of the real problem were group-fixed, the identity would be true and useless there, and only an inspection of that setting decides it.

## What the round should carry away

**A shorter proof exists, and it needs neither the fourth derivative nor skew-adjointness.** Differentiate $Q(w) = \theta w$ three times: $\frac{d^3}{dt^3}(w\circ w) = 2w'''\circ w + 6w''\circ w'$, so at $t=0$, $2L_W(X^3W) + 6\,u\circ z = \theta X^3W$, that is

$$B(X^3W) = 3\,u\circ z .$$

Pair with $z$ and move $B$ across, which is allowed because $B$ is self-adjoint: $\langle B(X^3W), z\rangle = \langle X^3W, Bz\rangle = 0$, since $Bz = \tfrac\theta2 z - L_Wz = 0$ by claim 4. The left side is $3\langle u\circ z, z\rangle = 3\,T(u,z,z)$, so $T(u,z,z) = 0$. This uses claims 4 and 5's parent equation and the self-adjointness of $L_W$, and it uses nothing about $X$ being skew, no fourth derivative, and no multinomial coefficients. **It makes claims 2, 6 and 7 unnecessary, which removes the only unformalised obligation in the chain.** I verified every step of it on the witness above as a screen.

**The record's standing warning survives intact and is answered precisely.** The warning says the identity is not implied by $Bu = z\circ z$ together with self-adjointness, and that is correct: the short route needs $B(X^3W) = 3\,u\circ z$, which is the THIRD derivative of criticality and strictly more information than $Bu = z\circ z$. The warning also asked for the fourth derivative of $P$ along the orbit or for $D^2g(W)z = 0$. The derivation under review supplies the first. The short route supplies a third option the warning did not list, the third derivative of criticality paired with $z$.

**Two things to fix in the write-up.** Claim 7 is listed as though the argument depends on it and it does not. And the claim that the $\theta$ cancellation "is the whole content" should be reversed: that cancellation is forced by the action being isometric, and the content is the $18\,T(u,z,z)$ that does not cancel.

## Method

Every verdict above is a derivation. The symbolic work was a screen on objects built for the purpose and ran in 1.4 seconds: the fourth-derivative coefficients against a random symmetric trilinear form and a random polynomial curve with four perturbation controls, and the witness instance with all of criticality, the two derivative identities, both skew statements, $Bu = z\circ z$, $\langle Bu,u\rangle = T(u,z,z) = 0$, the term-by-term substitution, and the short route asserted rather than printed. No screen is offered as evidence for a positive claim.

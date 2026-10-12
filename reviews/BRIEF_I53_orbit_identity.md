# Gate 2 brief: I53, the third orbit identity $\langle Bu,u\rangle=0$

You are an adversarial reviewer. **Work from the definitions below and from the mathematics alone.** Do not read the findings files these objects come from, and do not import the scripts or the Lean file under review.

**Two reviewers on identical briefs, and deliberately.** This is new mathematics: a derivation is being made rather than read, so two readers sample a wide distribution of reasoning errors and rarely find each other's.

## The setting, given because every attack item below needs it

$V$ is a real inner product space carrying a commutative bilinear product $\circ$, and

$$T(a,b,c)=\langle a\circ b,\,c\rangle$$

is **fully symmetric** in its three arguments. Write $Q(W)=W\circ W$, $L_Wa=W\circ a$, and $P(W)=T(W,W,W)$.

A **critical point** is a $W$ with $Q(W)=\theta W$ for a real $\theta$. Set

$$B=\tfrac\theta2-L_W,$$

which is self-adjoint because $L_W$ is.

A compact group acts on $V$ by **isometries that are automorphisms of $\circ$**. For $X$ in its Lie algebra, $X$ acts on $V$ as a **skew-adjoint** operator, $\langle Xa,b\rangle=-\langle a,Xb\rangle$. Write

$$z=X\!\cdot\!W,\qquad u=X^2\!\cdot\!W.$$

**Three identities are GIVEN, already on the record, and are not what this round audits.** They come from differentiating $Q(e^{tX}\!\cdot\!W)=\theta\,e^{tX}\!\cdot\!W$ at $t=0$, which holds because the action is by automorphisms of $\circ$:

- **criticality**, $T(a,W,W)=\theta\langle a,W\rangle$ for every $a$;
- **first derivative**, $L_Wz=\tfrac\theta2z$, equivalently $T(a,z,W)=\tfrac\theta2\langle a,z\rangle$ for every $a$;
- **second derivative**, $Bu=z\circ z$, equivalently $T(a,u,W)=\tfrac\theta2\langle a,u\rangle-T(a,z,z)$ for every $a$.

**What the record says about the target, quoted verbatim, and it is the reason this round exists:**

> **It is the whole of L51's fourth-order clause**, the value at the stationary corrector being $\tfrac34\langle Bu,u\rangle$, *and it is not implied by $Bu=z\circ z$ together with self-adjointness.* **The appeal to "$P$ is constant along the orbit" does not supply it**: the parabolic curve is the orbit's $2$-jet and differs at $O(t^3)$, contaminating $[t^4]$ at the same order. **Two routes would close it, the fourth derivative of $P$ along the orbit itself, or $D^2g(W)z=0$, and neither is written.**

## The derivation under review, quoted verbatim from disk

> Write `w(t) = exp(tX) · W`, so `w' = z`, `w'' = u`, `w''' = X³W`, `w'''' = X⁴W`. Since the action preserves the inner product and the product, `P(w) = T(w,w,w)` is CONSTANT along the orbit, with `T a b c = ⟪a ∘ b, c⟫` fully symmetric. The multinomial expansion of the fourth derivative at `t = 0` is then
>
>   `3 T(X⁴W, W, W) + 24 T(X³W, z, W) + 18 T(u, u, W) + 36 T(u, z, z) = 0`,
>
> the coefficients being `4!/(i!j!k!)` summed over the arrangements of `(4,0,0)`, `(3,1,0)`, `(2,2,0)` and `(2,1,1)`. Four substitutions, each an identity the record already carries, collapse it:
>
> * `T(a, W, W) = θ ⟪a, W⟫`, criticality `Q(W) = θ W`;
> * `T(a, z, W) = (θ/2) ⟪a, z⟫`, the first derivative, `L_W z = (θ/2) z`;
> * `T(a, u, W) = (θ/2) ⟪a, u⟫ - T(a, z, z)`, the second derivative, `B u = z ∘ z`, paired with `a`;
> * `⟪X⁴W, W⟫ = ⟪u, u⟫` and `⟪X³W, z⟫ = -⟪u, u⟫`, from `X` being skew-adjoint.
>
> **The `θ` terms then cancel identically**, `3 - 12 + 9 = 0`, leaving `18 T(u, z, z) = 0`. *That cancellation is the whole content, and it is visible in the statement below as the ABSENCE of `θ` from the conclusion: the identity holds at every real `θ`, so no bound on `θ` is being used.*

## The claims to attack, one row per claim, with the Lean declaration that types it

| # | claim | Lean |
|---|---|---|
| 1 | $P(e^{tX}\!\cdot\!W)$ is constant in $t$, because the action preserves $\langle\,,\rangle$ and $\circ$ | none: quantifies over a group action on $V$, which the base layer does not carry; it enters the theorem as the hypothesis `horbit` |
| 2 | $f^{(4)}(0)=3T(X^4W,W,W)+24T(X^3W,z,W)+18T(u,u,W)+36T(u,z,z)$ for $f(t)=T(w,w,w)$, coefficients $4!/(i!j!k!)$ | none: a fourth derivative of a trilinear form along a smooth curve, needing `iteratedDeriv` on a multilinear map; **say whether Mathlib reaches it, because if it does this is an obligation** |
| 3 | $T(a,W,W)=\theta\langle a,W\rangle$ at a critical point | `hcrit`, a hypothesis binder of `pairing_vanishes`, on the record and not audited here |
| 4 | $T(a,z,W)=\tfrac\theta2\langle a,z\rangle$ | `hfirst`, a hypothesis binder, on the record and not audited here |
| 5 | $T(a,u,W)=\tfrac\theta2\langle a,u\rangle-T(a,z,z)$, which is $Bu=z\circ z$ paired against $a$ | `hB`, a hypothesis binder, on the record and not audited here |
| 6 | $\langle X^4W,W\rangle=\lVert u\rVert^2$ and $\langle X^3W,z\rangle=-\lVert u\rVert^2$ for skew-adjoint $X$ | `skew_four` and `skew_three`, **proved**, standard axioms |
| 7 | $\langle u,z\rangle=0$, which is what makes the THIRD derivative's own relation consistent | `inner_u_z_eq_zero`, **proved**, standard axioms |
| 8 | Substituting 3 to 6 into 2 gives $3\theta\lVert u\rVert^2-12\theta\lVert u\rVert^2+9\theta\lVert u\rVert^2+18T(u,z,z)=0$, hence $T(u,z,z)=0$ | `pairing_vanishes`, **proved**, standard axioms, $\theta$ a free real absent from the conclusion |
| 9 | $T(u,z,z)=\langle Bu,u\rangle$, so claim 8 IS the item | none: needs $B$ and $\circ$ as layer objects; it is $\langle Bu,u\rangle=\langle z\circ z,u\rangle$ by claim 5 and then full symmetry of $T$ |
| 10 | The record's warning does not bite, because this argument differentiates the ORBIT, whose third and fourth derivatives are $X^3W$ and $X^4W$, rather than the parabolic $2$-jet | none: a claim about which curve the argument uses, not about an object |
| 11 | The theorem is not vacuous: some critical point carries an $X$ with $z\ne0$ and $u\ne0$ | none, **AND THIS IS A GAP**: no witness is in the Lean file, so nothing rules out every instance being trivial. *If you confirm the gap, say so, because it becomes an obligation* |

## What to do

1. **Claim 2 is the load-bearing step and the one to settle first.** Derive $f^{(4)}(0)$ yourself for a fully symmetric trilinear $T$ along an arbitrary smooth curve, and say whether the four coefficients are $3,24,18,36$. **Do it from the multinomial theorem AND once by hand from the product rule**, since a coefficient error here is invisible downstream and changes the conclusion.
2. **Claim 8 is where the argument could be circular, and that is the subtle point.** Claim 5 puts the unknown $T(u,z,z)$ on BOTH sides of the relation, once inside $T(u,u,W)$ with coefficient $18$ and once standing alone with coefficient $36$. Say whether extracting $18\,T(u,z,z)=0$ from that is legitimate, or whether it is an identity that holds for any value of the unknown. **State what the conclusion would look like if the two coefficients had been equal**, and check that they are not.
3. **Claim 11 is the vacuity check and the brief expects it to be REAL.** A forced identity about quantities that are always zero buys nothing. Say whether a critical point of this problem admits an $X$ with $X^2\!\cdot\!W\ne0$, and if you cannot settle it in general, say what the smallest instance would be.
4. **Claim 6 and claim 7 are proved in Lean and you should still check the STATEMENTS**, not the proofs: does $\langle X^4W,W\rangle=\lVert X^2W\rVert^2$ say what the derivation needs, and is the sign of $\langle X^3W,XW\rangle$ right? *A statement that type-checks can be the wrong statement, and that is the only error a kernel cannot catch.*
5. **Claim 1 is a hypothesis and hypotheses are where claims hide.** Confirm that preserving the inner product and the product is enough to make $P$ constant, and say whether anything further is needed (an automorphism property of the Lie algebra element, a derivation identity) that the derivation uses without stating.
6. **Claim 10 asks whether the record's own objection has been answered or side-stepped.** The record says the parabolic $2$-jet contaminates $[t^4]$ at $O(t^3)$. Say whether using the genuine orbit removes that contamination, or merely relocates it.
7. **Claim 9 is a restatement and restatements invert.** Derive $\langle Bu,u\rangle=T(u,z,z)$ yourself and confirm the direction.
8. Return **CONFIRMED**, **PLAUSIBLE** or **REFUTED** per claim, with corrections.

**State what a claim would look like if it were vacuous, and check that it is not.** Claim 8 in particular: an identity forced on a quantity that is identically zero for an unrelated reason is not a finding.

## Standing rules

**Analysis only.** A LONG or OPEN-ENDED run needs the user's approval for the specific task. **Permitted without asking**: screening a claim you are about to record, seconds of compute on objects you construct for that purpose, and any run finishing in a few minutes on objects already in hand. **The deliverable is a derivation, and a number is a screen.**

**A control is an assertion, never a printed expectation.**

**Report.** Write `reviews/REVIEW_r<N>.md`, skeleton committed in your FIRST phase with every verdict `NOT REACHED`. **Commit with an explicit PATHSPEC**, `git commit -m "<msg>" -- reviews/REVIEW_r<N>.md`, never `git add -A` and never `git commit -a`. **Never amend.** **Do not write to reviews/INDEX.md.**

**Two traps in the commit gate, found by the previous reviewer and worth knowing before you hit them.** [cycle_deliverable.py](../.claude/hooks/cycle_deliverable.py) reads the first physical line of the bash command for `refut\w+`, so a subject line containing "refutes" trips its opens-an-item tripwire while the parent has `plan.md` staged. Its `SEARCHED` regex anchors on `$` under `re.M`, so a trailer works only when the closing shell quote sits on the next line.

**Log** to `agent_logs/<task-name>.log`: PID and phase plan on the first line, a line per phase, a heartbeat carrying live state at least every 3 minutes, and a closing line OPENING with `DONE ` or `FAILED `.

# Gate 2 brief: the face of the orthostochastic image, its first-order condition, and what R28 actually needs

You are an adversarial reviewer. **Work from the definitions below and from the mathematics alone.** Do not read the working note this block was drawn from, do not import the script under review, and do not read the other reviewer's report. Your independence comes from your implementation, not from your instructions.

**This round audits a derivation, a refutation, and one claim that is a SHAPE rather than a theorem.** Say clearly which of your verdicts bear on which, and do not let the derivation carry the shape.

## The setting, as a given

$\varphi_r:O(k)\to B_k$ is the entrywise square $Q\mapsto Q^{\circ2}$, whose image is the orthostochastic set. Write $X_k=\varphi_r(O(k))$.

**Given, R28's frame dependence, verbatim from the route register.** The value depends on the frame through
$$\sum_k\Big(\beta\nu_k^2\,p_k^{\mathsf T}\hat Up_k+\nu_k\,p_k^{\mathsf T}Cp_k\Big)$$
over an orthonormal frame $P$ with columns $p_k$, where $\hat U$ and $C$ are **diagonal** in the field frame with diagonals $u$ and $c$, the $\nu_k$ are the eigenvalues of $V$, and $\beta=\tfrac94$.

**Given, what R28's induction does.** It excludes an interior tangency, concludes the maximum sits on the boundary, and wants that boundary to be the SPLIT locus, which is the previous rung of the induction.

**Given, from [L230](../findings/second-order.md) and its Gate 2 round** ([r974](REVIEW_r974.md), [r975](REVIEW_r975.md)), and **not under review**: the singular-locus route to that conclusion fails, and the obstruction is instead the face $\{\operatorname{tr}=0\}\cap X_k$, which contains non-split points at $k=4$ and $k=6$. An orthogonal matrix **splits** when, up to **independent** row and column permutations, it is a direct sum of two smaller orthogonal matrices.

## The block under review, quoted verbatim from disk

> **The theorem, named before any work.** *If the value's maximum over the orthostochastic image is attained at a zero-diagonal $Q$, then it is also attained at a splitting one.* **The rung does not need the face to be avoided, only that landing on it costs nothing**, so the step can still hand down to the previous rung. Stating it as avoidance would be a strictly stronger claim than the route needs.
>
> With $R=P^{\circ2}$, $p_k^{\mathsf T}\hat Up_k=(R^{\mathsf T}u)_k$ and likewise for $C$, so the value is $\langle R,A\rangle$ with $A_{ik}=\beta\nu_k^2u_i+\nu_kc_i$. **A linear functional on a compact set.**
>
> $\operatorname{tr}$ is nonnegative on the image, vanishes exactly on images of zero-diagonal $Q$, and is nonconstant, so $\{\operatorname{tr}=0\}$ is a face relative to the affine hull.
>
> **Maximising the value over the image is maximising a quadratic form over the group.** Writing $f(Q)=\langle A,Q\circ Q\rangle=\sum_{i,k}A_{ik}Q_{ik}^2$, the problem is $\max_{Q\in O(k)}f(Q)$, and the image never has to be parametrised.
>
> **First order.** Along $Q\Omega$ with $\Omega$ skew, $\mathrm df_Q[Q\Omega]=2\langle A,Q\circ(Q\Omega)\rangle=2\langle A\circ Q,Q\Omega\rangle=2\langle Q^{\mathsf T}(A\circ Q),\Omega\rangle$. Since $\Omega$ ranges over all skew matrices, criticality is that $Q^{\mathsf T}(A\circ Q)$ is symmetric.
>
> **Second order.** The second variation along the same direction gives the analogue of batch 21, and **that is the observation worth having**: the rung at general $\lvert J\rvert$ has the same two-condition shape the record already worked out at $\lvert J\rvert=3$, with the frame in place of $(\hat U,V)$.
>
> **The expectation that the face is avoided is REFUTED.** Maximisers land on it: $8$ of $12$ at $k=4$, $4$ of $12$ at $k=5$, $1$ of $12$ at $k=6$.

## The claims to attack

| # | claim | kind |
|---|---|---|
| 1 | The value equals $\langle R,A\rangle$ with $A_{ik}=\beta\nu_k^2u_i+\nu_kc_i$, so it is linear in the orthostochastic matrix | mathematics |
| 2 | That $A$ has rank at most $2$, being $u(\beta\nu^{\circ2})^{\mathsf T}+c\nu^{\mathsf T}$ | mathematics |
| 3 | Maximising $\langle R,A\rangle$ over $X_k$ is maximising $f(Q)=\sum_{i,k}A_{ik}Q_{ik}^2$ over $O(k)$ | mathematics |
| 4 | $\mathrm df_Q[Q\Omega]=2\langle Q^{\mathsf T}(A\circ Q),\Omega\rangle$ | mathematics |
| 5 | Hence criticality is exactly that $Q^{\mathsf T}(A\circ Q)$ is symmetric | mathematics |
| 6 | $\{\operatorname{tr}=0\}$ is a face of $X_k$ relative to its affine hull | mathematics |
| 7 | The second-order condition is batch 21 transported, with the frame in place of $(\hat U,V)$ | **a shape, not a theorem** |
| 8 | Avoidance is false, so the hand-down statement is the right thing for R28 to need | mixed |

## The Lean declarations, one row per claim

Every claim has a row. A cell names the declaration that types it, or the reason none can exist. File: [I106bFace.lean](../lean/HamiltonsCubic/Results/I106bFace.lean).

| # | Lean |
|---|---|
| 1 | none: it identifies a frame expression with a pairing, and neither the frame nor the field matrices are objects in this layer. `value` types $\langle R,A\rangle$ itself as `(Aᵀ * R).trace` |
| 2 | none: a rank statement, and rank is not typed in this layer |
| 3 | none: it quantifies over the IMAGE of a map between manifolds, which the base layer does not carry |
| 4 | `grad_pairing`, stated for EVERY `W` rather than only skew ones, since the restriction to skew is what turns the identity into the condition rather than part of the identity |
| 5 | none as an equivalence: "criticality" needs a differential, which the layer has no object for. `grad_pairing` is its algebraic half |
| 6 | `trace_image_eq`, `trace_image_nonneg` and `trace_image_eq_zero_iff` type the three facts about $\operatorname{tr}$, none needing a hypothesis. That these three make the set a FACE is not typed, affine hulls and relative interiors being absent |
| 7 | none: a claim about what a computation would resemble, which is not a proposition |
| 8 | `Splits` types the source's two-sided splitting predicate and `face_hands_down` the conclusion R28 needs, with a NAMED `sorry`. That maximisers land on the face is numerical and is not a proposition |

## What to do

1. **Claim 4 is the load-bearing algebra and you should re-derive it, not check it.** In particular verify the step $\langle A,Q\circ Z\rangle=\langle A\circ Q,Z\rangle$ and the step moving $Q$ across the pairing, and say whether the tangent should be $Q\Omega$ or $\Omega Q$ and whether it matters.
2. **Claim 5 is where a reader nods.** It reads as a definition. Ask whether symmetry of $Q^{\mathsf T}(A\circ Q)$ is really equivalent to criticality or only implied by it, and in particular whether $\Omega\mapsto\langle S,\Omega\rangle$ vanishing for all skew $\Omega$ gives symmetry of $S$ or something weaker.
3. **Claim 3 hides a quantifier.** $\max_R\langle R,A\rangle$ over the image and $\max_Q f(Q)$ over the group have the same value, but the block also uses the correspondence to talk about WHERE the maximum is. Say whether a maximiser of one gives a maximiser of the other in both directions, and whether the fibres of $\varphi_r$ cause trouble.
4. **Claim 6 is the one whose failure would be quietest.** The three facts about $\operatorname{tr}$ are easy. The inference to "face relative to the affine hull" is not, and it needs $\operatorname{tr}$ to be affine on the affine hull and nonconstant THERE. Check it.
5. **Claim 7 is NOT mathematics and must not be graded as one.** Decide whether the block is right to flag it as a shape, and whether the correspondence it asserts is plausible, exact, or wrong. **If you can derive the second-order condition, that is worth more than any verdict here.**
6. **Claim 2 matters more than it looks.** A screen run at generic full-rank $A$ would answer a different question from one run at R28's own $A$. Verify the rank claim, and say what breaks if it is wrong.
7. Return **CONFIRMED**, **PLAUSIBLE** or **REFUTED** per claim, with corrections.

**State what a claim would look like if it were vacuous, and check that it is not.** Claim 8 in particular: a theorem whose hypothesis is never met is unrefuted and useless, so say whether the hypothesis is genuinely met and whether the block is entitled to say so.

**The most useful thing you can do is derive the second-order condition** and say whether it is batch 21 transported. If it is, the levers already fenced at $\lvert J\rvert=3$ are fenced here too, and naming which is worth more than any verdict.

## Standing rules

**Analysis only.** A LONG or OPEN-ENDED run needs the user's approval for the specific task. **Permitted without asking**: screening a claim you are about to record, seconds of compute on objects you construct for that purpose, reported as a screen and never as evidence for a positive claim, and any run finishing in a few minutes on objects already in hand. **What waits**: a sweep over a parameter range, a census of a family, an optimisation whose cost is unknown before it starts. *The test is whether you can say in advance what it will cost and what it will decide.*

**A control is an assertion, never a printed expectation.** Where your screen prints an expected value, assert it, so a broken measurement ends the run instead of decorating it. *The block's own screen printed a control reading `6.089` beside the words "0 expected" and was read anyway.*

**Report.** Write `reviews/REVIEW_r<N>.md`. **Commit a skeleton in your first phase**: the title, the claim table with every verdict `NOT REACHED`, and the log path. Update one row per phase. **Commit with an explicit PATHSPEC**, `git commit -m "<msg>" -- reviews/REVIEW_r<N>.md`, never `git add -A` and never `git commit -a`, because the git index is shared with a parent that may have staged its own work. **Never amend.**

**Do not write to [reviews/INDEX.md](INDEX.md).** The parent files every row after the last report lands, so neither reviewer publishes verdicts where the other will read them.

**Log** to `agent_logs/<task-name>.log`: first line carrying your PID and phase plan, a line at every phase transition, a heartbeat at least every 3 minutes carrying live state, and a closing line that **OPENS** with `DONE ` or `FAILED `, after at most a timestamp, as the last line written to the file.

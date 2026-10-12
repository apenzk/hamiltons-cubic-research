# Gate 2 brief: the coupling constraint between the two orthostochastic factors

You are an adversarial reviewer. **Work from the definitions below and from the mathematics alone.** Do not read the derivation note this is drawn from, do not import or run the scripts under review, and do not read the other reviewer's report. Your independence comes from your implementation, not from your instructions.

## The setting, as a given

$P$, $E$, $F$ are real $3\times3$ orthogonal matrices. $\hat U=E\operatorname{diag}(u)E^{\mathsf T}$ and $C=F\operatorname{diag}(c)F^{\mathsf T}$ are symmetric, $P$ carries a third matrix's eigenvectors. Define

$$R:=(E^{\mathsf T}P)^{\circ2},\qquad S:=(F^{\mathsf T}P)^{\circ2},\qquad G:=E^{\mathsf T}F,$$

where $X^{\circ2}$ is the entrywise square, $(X^{\circ2})_{ab}=X_{ab}^2$. Indices run $1,2,3$ throughout; $j<l$ ranges over the three pairs $(1,2)$, $(1,3)$, $(2,3)$.

**Given, already on the record and NOT under review here.** The $3\times3$ orthostochastic variety's equation $(ab-xy-zw)^2=4xyzw$ holds for the entrywise squares of any real matrix whose first two columns are orthogonal, and its converse holds: a bistochastic pair of columns satisfying the equation is realised by two orthonormal real vectors with those entrywise squares. Both are proved and typed.

## The block under review, quoted verbatim from disk

> **Derived.** Write $Q=E^{\mathsf T}P$, so $R=Q^{\circ2}$ and $F^{\mathsf T}P=G^{\mathsf T}Q$, giving $S_{ik}=\big(\sum_jG_{ji}Q_{jk}\big)^2$. Expanding the square separates the part that sees only $R$ from the part that carries the coupling:
> $$S_{ik}=\big((G^{\circ2})^{\mathsf T}R\big)_{ik}+2\sum_{j<l}G_{ji}G_{li}\,T^{(jl)}_k,\qquad T^{(jl)}_k:=Q_{jk}Q_{lk}.$$
> **The three $T^{(jl)}_k$ are exactly the coupling**, and each is a SIGNED square root of a product of $R$'s own entries:
> $$\big(T^{(jl)}_k\big)^2=R_{jk}R_{lk},\qquad T^{(12)}_kT^{(13)}_kT^{(23)}_k=R_{1k}R_{2k}R_{3k}\ \ge\ 0.$$
> **This is the constraint the item owed**: $S$ is determined by $R$, the fixed $G$, and a finite sign choice, rather than free beside it.
>
> **It needs NO orthogonality**, being the expansion of a square.
>
> **Gate 1.** (b) *Reached a second way*: the identity is the expansion of $(\sum_jG_{ji}Q_{jk})^2$ and is checked symbolically by `ring` in Lean. (c) *Screened* over $20000$ random $(E,F,P)\in O(3)^3$: the identity to $2.9\cdot10^{-15}$, the squares to $8.3\cdot10^{-17}$, the parity to $2.1\cdot10^{-17}$, and zero sign violations. (d) *Ceiling*: at $G=I$ it collapses to $S=R$.

## The claims to attack

| # | claim |
|---|---|
| 1 | $F^{\mathsf T}P=G^{\mathsf T}Q$ with $Q=E^{\mathsf T}P$ and $G=E^{\mathsf T}F$, so $S=(G^{\mathsf T}Q)^{\circ2}$ |
| 2 | $S_{ik}=\big((G^{\circ2})^{\mathsf T}R\big)_{ik}+2\sum_{j<l}G_{ji}G_{li}T^{(jl)}_k$ with $T^{(jl)}_k=Q_{jk}Q_{lk}$ |
| 3 | $\big(T^{(jl)}_k\big)^2=R_{jk}R_{lk}$ for each of the three pairs |
| 4 | $T^{(12)}_kT^{(13)}_kT^{(23)}_k=R_{1k}R_{2k}R_{3k}$, and this quantity is non-negative |
| 5 | Claim 2 uses no orthogonality of $E$, $F$ or $P$, being the expansion of a square |
| 6 | At $G=I$ the display collapses to $S=R$ |
| 7 | $S$ is determined by $R$, by the fixed $G$, and by a choice of finitely many signs |
| 8 | The record does not already hold this pair of objects under another name |

## The Lean declarations, one row per claim

Every claim above has a row. A cell names the declaration that types the claim, or the reason no declaration can exist. File: [I106aOrthostochastic.lean](../lean/HamiltonsCubic/Results/I106aOrthostochastic.lean).

| # | Lean |
|---|---|
| 1 | none: it is an identity between products of three matrix variables, typeable, but nothing in the file states it and the layer carries no `O(3)` frame object to state it over |
| 2 | `coupling_decomposition`, stated at one entry with `g j = G j i` and `q j = Q j k` |
| 3 | `coupling_square` |
| 4 | `coupling_parity` types the equality; **the non-negativity is NOT typed**, no declaration asserts `0 ≤ q₁^2 * (q₂^2 * q₃^2)` |
| 5 | visible in `coupling_decomposition`'s signature, whose binders are six unconstrained reals with no orthogonality hypothesis |
| 6 | none: no declaration specialises the display at `G = I` |
| 7 | none: it asserts a finite sign choice SUFFICES to recover `S`, which is a converse for the pair and is not typed. `columns_from_equation` is the converse for ONE factor only |
| 8 | none: a claim about what the record contains is not a proposition |

## What to do

1. **Derive, do not reimplement.** Settle claims 1 to 6 symbolically or by hand. Where a number is genuinely needed, compute the smallest one that does the job and say why an argument could not.
2. **Attack the quantifiers.** Claims 3, 4 and 7 involve signs and square roots. Ask what happens when entries vanish, when $R$ has zero entries, and whether claim 7 survives the cases where the signs are not determined.
3. **Claim 4's inequality is the one to press.** Say whether the non-negativity is a consequence of the equality or an independent fact, and whether it can fail.
4. **Claim 7 is the weakest and is stated loosely on purpose.** Decide what it actually says, and whether what it says is true. If it admits two readings, give both.
5. **Claim 5**: check whether orthogonality is used implicitly anywhere, including in the step reaching $S=(G^{\mathsf T}Q)^{\circ2}$.
6. Return **CONFIRMED**, **PLAUSIBLE** or **REFUTED** per claim, with corrections.

**State what a claim would look like if it were vacuous, and check that it is not.**

## Standing rules

**Analysis only.** This programme is on an analysis-only footing. A LONG or OPEN-ENDED run needs the user's approval for the specific task. **What is permitted without asking**: screening a claim you are about to record, seconds of compute on objects you construct for that purpose, reported as a screen and never as evidence for a positive claim, and any run finishing in a few minutes on objects already in hand. **What waits**: a sweep over a parameter range, a census of a family, an optimisation whose cost is unknown before it starts. *The test is whether you can say in advance what it will cost and what it will decide.* When you cannot, name it and stop.

**Report.** Write `reviews/REVIEW_r<N>.md`. **Commit a skeleton in your first phase**: the title, the claim table with every verdict `NOT REACHED`, and the log path. Update one row per phase. **Commit that file by path only**, never `git add -A` and never `git commit -a`, since a concurrent reviewer and the parent are writing the same repository. **Never amend.**

**Do not write to [reviews/INDEX.md](INDEX.md).** The parent files every row after the last report lands, so that neither reviewer publishes verdicts where the other will read them.

**Log** to `agent_logs/<task-name>.log`: first line carrying your PID and phase plan, a line at every phase transition, a heartbeat at least every 3 minutes carrying live state rather than "still working", and a closing line that **OPENS** with `DONE ` or `FAILED `, after at most a timestamp, as the last line written to the file.

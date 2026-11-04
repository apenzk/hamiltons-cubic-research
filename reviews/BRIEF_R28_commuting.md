# Gate 2 brief: does R28's rung hand down exactly on the commuting stratum?

You are an adversarial reviewer. **Work from the definitions below and from the mathematics alone.** Do not read the working note this block was drawn from, do not import the scripts under review, and do not read the other reviewer's report. Your independence comes from your implementation, not from your instructions.

**This round audits a REDUCTION: a claim that one route's remaining obligation is identical to a statement the record already aims at.** Getting it wrong either way is expensive, because it redirects every later attempt.

## The object, quoted verbatim from the route register, and NOT restated

*A previous brief in this programme paraphrased this object as a single matrix, and two cold readers then returned a correct answer to a different question. So it is quoted rather than summarised.*

> **R28**, the orthostochastic rung: at every $\lvert J\rvert$ the frame dependence of the value on $\mathcal S_J$ is a linear functional on the image of $O(\lvert J\rvert)$ under $P\mapsto\big((E^{\mathsf T}P)^{\circ2},(F^{\mathsf T}P)^{\circ2}\big)$, a COUPLED PAIR of orthostochastic matrices rather than one, the coupling being the fixed rotation $G=E^{\mathsf T}F$ between the eigenframes of $\hat U$ and of $C$; its BOUNDARY is the split locus, the previous rung, and its interior is one hyperplane tangency to be excluded at fixed total norm.

> the $V$-frame dependence of the value is $\sum_k\big(\beta\nu_k^2\,p_k^{\mathsf T}\hat Up_k+\nu_k\,p_k^{\mathsf T}Cp_k\big)$ over an orthonormal frame

**Given, and not under review**, from a landed Gate 2 round: $\Pi_k\subseteq X_k\subseteq B_k=\mathop{\mathrm{conv}}(\Pi_k)$ where $X_k=\varphi_r(O(k))$, $B_k$ is Birkhoff's polytope and $\Pi_k$ the permutation matrices, so $\mathop{\mathrm{conv}}(X_k)=B_k$ and a linear functional on a SINGLE orthostochastic matrix attains its maximum at a permutation matrix. Every permutation matrix splits.

**Given, verbatim from the record**, and this is the sentence the reduction claims to meet:

> **The statement to aim at is therefore $[\hat U,C]=0$ at every global maximum, which closes the $\lvert J\rvert=3$ node outright rather than one stratum of it.**

## The block under review, quoted verbatim from disk

> **The equivalence.** $G=E^{\mathsf T}F$ is a signed permutation exactly when $\hat U$ and $C$ share an eigenframe, which is exactly $[\hat U,C]=0$. *Signed permutations are the only orthogonal matrices whose entrywise square is a permutation matrix, and $R=(E^{\mathsf T}P)^{\circ2}$ and $S=(F^{\mathsf T}P)^{\circ2}$ can be simultaneously vertex only when $G$ is one.* **And vertex-optimality holds exactly there**, checked at $k=3$ and $k=4$: $G$ the identity or a permutation gives $\lvert[\hat U,C]\rvert$ at machine zero and a group-minus-vertex gap of at most $10^{-14}$, while a small or generic rotation gives a nonzero commutator and the vertex is beaten.
>
> **So the rung's remaining obligation IS the node's own target, and once the commutator vanishes the rung needs no face argument, no tangency exclusion and no second-order condition**, only Birkhoff.
>
> *It does NOT prove $[\hat U,C]=0$.* What it removes is the belief that R28 owes something SEPARATE at general $\lvert J\rvert$. **Any effort spent on the face, on the coupled convex hull, or on transporting batch 21 is spent on a problem that $[\hat U,C]=0$ dissolves.**

## The claims to attack

| # | claim | kind |
|---|---|---|
| 1 | The value is $\langle R,A_1\rangle+\langle S,A_2\rangle$, linear in the coupled pair jointly | mathematics |
| 2 | Signed permutations are the ONLY orthogonal matrices whose entrywise square is a permutation matrix | mathematics |
| 3 | $R$ and $S$ can be simultaneously permutation matrices only when $G$ is a signed permutation | mathematics |
| 4 | $G$ is a signed permutation iff $\hat U$ and $C$ share an eigenframe, iff $[\hat U,C]=0$ | mathematics |
| 5 | The maximum is attained at a splitting frame exactly when $[\hat U,C]=0$ | mathematics |
| 6 | Hence once $[\hat U,C]=0$ the rung needs only Birkhoff, with no face, tangency or second-order input | a reduction |
| 7 | Hence R28 owes nothing separate at general $\lvert J\rvert$, and work on the coupled hull is misdirected | about a route |

## The Lean declarations, one row per claim

Every claim has a row. A cell names the declaration that types it, or the reason none can exist.

| # | Lean |
|---|---|
| 1 | none: it identifies a frame expression with a pairing and the field matrices are not objects in the base layer. `value` in [I106bFace.lean](../lean/HamiltonsCubic/Results/I106bFace.lean) types $\langle R,A\rangle$ for the single-matrix case only |
| 2 | **none, and this is the gap that matters**: it is a clean finite statement about orthogonal matrices and is TYPEABLE, and it is not typed. *If you confirm it, say so, because it becomes an obligation* |
| 3 | none: it quantifies over simultaneous vertex-ness of a coupled pair, an object the layer does not carry |
| 4 | none: eigenframes are not typed here. The forward direction, that a shared eigenframe gives $[\hat U,C]=0$, is `Matrix.commute` and would be one line |
| 5 | none: an attainment statement over $O(k)$, which the base layer has no object for |
| 6 | none: a claim about what a route needs, not a proposition about matrices |
| 7 | none: same, and it is the block's own stated consequence rather than its mathematics |

## What to do

1. **Claim 2 is the load-bearing algebra and the one thing you should try to prove or break.** An orthogonal $Q$ with $Q^{\circ2}$ a permutation matrix: does that force each row to have a single nonzero entry of modulus $1$? Give the proof or a counterexample. **If it is true, say whether it is one line, because the brief records it as typeable and untyped.**
2. **Claim 3 is where the coupling actually enters and where a reader is most likely to nod.** It says simultaneity forces $G$. Check whether $R$ and $S$ could both be vertices with $G$ NOT a signed permutation, for instance by $P$ being chosen to make each factor vertex through different mechanisms.
3. **Claim 5 is an "exactly when", so attack BOTH directions.** The block's evidence is a screen at $k=3,4$ over four values of $G$. Is the forward direction ($[\hat U,C]=0$ implies a splitting maximiser) a theorem, and is the converse anything more than four data points? **A single $G$ that is not a signed permutation but whose maximum is still at a splitting frame refutes the converse.**
4. **Claim 6 asks what a reduction is entitled to.** Granting claims 1 to 5, does the rung really need nothing else, or does it still need that the previous rung's hypothesis transfers? Name anything the reduction quietly assumes.
5. **Claim 7 is about a route.** Decide whether "work on the coupled hull is misdirected" follows, or whether the coupled hull remains the right object on the complement of the commuting stratum, which is where the node's difficulty lives.
6. Return **CONFIRMED**, **PLAUSIBLE** or **REFUTED** per claim, with corrections.

**State what a claim would look like if it were vacuous, and check that it is not.** Claim 6 in particular: a reduction to a statement nobody can prove is still a reduction, but if $[\hat U,C]=0$ were ALREADY known on the relevant stratum the claim would be empty, so say which.

**The most useful thing you can do is settle claim 2 and then claim 3**, because together they are the whole equivalence and everything else is bookkeeping around them.

## Standing rules

**Analysis only.** A LONG or OPEN-ENDED run needs the user's approval for the specific task. **Permitted without asking**: screening a claim you are about to record, seconds of compute on objects you construct for that purpose, reported as a screen and never as evidence for a positive claim, and any run finishing in a few minutes on objects already in hand. **What waits**: a sweep over a parameter range, a census of a family, an optimisation whose cost is unknown before it starts.

**A control is an assertion, never a printed expectation.** Where your screen prints an expected value, assert it, so a broken measurement ends the run instead of decorating it.

**Report.** Write `reviews/REVIEW_r<N>.md`. **Commit a skeleton in your first phase**: the title, the claim table with every verdict `NOT REACHED`, and the log path. Update one row per phase. **Commit with an explicit PATHSPEC**, `git commit -m "<msg>" -- reviews/REVIEW_r<N>.md`, never `git add -A` and never `git commit -a`, because the git index is shared with a parent that may have staged its own work. **Never amend.**

**Do not write to [reviews/INDEX.md](INDEX.md).** The parent files every row after the last report lands.

**Log** to `agent_logs/<task-name>.log`: first line carrying your PID and phase plan, a line at every phase transition, a heartbeat at least every 3 minutes carrying live state, and a closing line that **OPENS** with `DONE ` or `FAILED `, after at most a timestamp, as the last line written to the file.

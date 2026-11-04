# Gate 2 brief: does the singular locus of the entrywise square strictly contain the split locus, and from which $k$?

You are an adversarial reviewer. **Work from the definitions below and from the mathematics alone.** Do not read the working note or the findings block this claim was drawn from, do not import the script under review, and do not read the other reviewer's report. Your independence comes from your implementation, not from your instructions.

**This round audits a short argument with an explicit witness, so it is cheap to check and cheap to get wrong in one specific way.** The mechanism is three lines and the conclusion is about a route. Say clearly which of your verdicts bear on the mathematics and which on the route.

## The setting, as a given

$\varphi_r:O(k)\to B_k$ is the entrywise square $Q\mapsto Q^{\circ2}$, with $B_k$ Birkhoff's polytope. Its image is the set of orthostochastic matrices. A **singular point** of $\varphi_r$ is a $Q$ at which the differential $d\varphi_r$ fails to be injective on the tangent space of $O(k)$.

An orthogonal matrix **splits** when, up to permutations of rows and columns, it is a direct sum of two smaller orthogonal matrices.

**Given, verbatim from [Bengtsson, Ericsson, Kuś, Tadej and Życzkowski](../references/au-yeung-poon-1979-orthostochastic-numerical-ranges/notes.md), carrying Au-Yeung and Poon 1979.** These are the source statements and are **not** under review:

> **Theorem 2.2.** If an orthogonal matrix splits, then it is a singular point of the map $\varphi_r$.

> **Theorem 2.4.** Let $n=3$. The singular points of the map $\varphi_r$ are the matrices that split.

> **Theorem 2.6.** Let $n=4$. There are two types of singular points of the map $\varphi_r$. The first are the matrices that split. The second type are the matrices which are equivalent to a matrix having all diagonal entries zero and all other entries nonzero.

**Given, the route this bears on.** [R28](../routes.md) climbs an induction on $\lvert J\rvert$ by excluding an interior tangency, concluding the maximum sits on the BOUNDARY of the image, and then identifying that boundary with the SPLIT locus, which is the previous rung of the induction.

**Given, dimensions.** $\dim O(k)=\binom k2$. The tangent space to the bistochastic matrices at an interior point has dimension $(k-1)^2$, cut out by zero row sums and zero column sums.

## The block under review, quoted verbatim from disk

> **Statement.** *Let $Q\in O(k)$ have $Q_{ii}=0$ for every $i$. Then $Q$ is a singular point of $\varphi_r$, at every $k$. At $k=3$ no such $Q$ has all its off-diagonal entries nonzero. At $k=4$ one does, it does not split, and $\mathop{\mathrm{rank}}d\varphi_r=5$ there against $\dim O(4)=6$.* **So "singular implies splits" is a theorem at $k=3$ and FALSE at $k=4$.**
>
> 1. **The mechanism.** The tangent space to $O(k)$ at $Q$ is $\{Q\Omega:\Omega^{\mathsf T}=-\Omega\}$, and $\varphi_r$ has differential $Z\mapsto2\,Q\circ Z$ at $Q$, so a tangent vector maps to $2\,Q\circ(Q\Omega)$. Its $i$-th diagonal entry is $2Q_{ii}(Q\Omega)_{ii}$, which vanishes for every $\Omega$ once $Q_{ii}=0$. The image of $d\varphi_r$ therefore lies in the zero-diagonal subspace, on top of the zero row sums and zero column sums that every tangent to the bistochastic matrices already satisfies. That is $k$ further linear conditions on a space of dimension $(k-1)^2$, so the image has dimension at most $(k-1)^2-k$, and $d\varphi_r$ fails to be injective as soon as $(k-1)^2-k<\tbinom k2$, which holds at every $k\ge3$.
>
> 2. **Emptiness at $k=3$.** Write the first two rows of a zero-diagonal $3\times3$ matrix as $(0,a,b)$ and $(c,0,d)$. Their inner product is $0\cdot c+a\cdot0+bd=bd$, so orthogonality forces $b=0$ or $d=0$ and some off-diagonal entry vanishes.
>
> 3. **The witness at $k=4$.** Take $Q=3^{-1/2}M$ with $M$ the matrix of rows $(0,1,1,1)$, $(1,0,-1,1)$, $(1,1,0,-1)$ and $(1,-1,1,0)$. Then $MM^{\mathsf T}=3I$, so $Q\in O(4)$, its diagonal is zero, and every other entry is $\pm3^{-1/2}$. Its image is $Q^{\circ2}=\tfrac13(J-I)$, which is bistochastic and has no zero off the diagonal, so its support graph is connected and it does not split.
>
> **The kernel is explicit.** $M\odot(M\Omega)=0$ needs $(M\Omega)_{ij}=0$ at every $i\ne j$, because every off-diagonal entry of $M$ is nonzero, so $M\Omega$ must be DIAGONAL. With $MM^{\mathsf T}=3I$ that forces $\Omega=\tfrac13M^{\mathsf T}D$ for diagonal $D$, and skewness pins $D=3\mathop{\mathrm{diag}}(1,-1,-1,-1)$, leaving $\Omega=\mathop{\mathrm{diag}}(-1,1,1,1)M$ and $M\Omega=\mathop{\mathrm{diag}}(3,-3,-3,-3)$.
>
> **What it does to R28.** The rung's step reads *exclude the interior tangency, therefore the maximum is on the boundary, therefore it is on the split locus, which is the previous rung*. **The last arrow is a theorem at $\lvert J\rvert=3$ and fails at $\lvert J\rvert=4$**, so from there the step acquires a second stratum rather than an unproved lemma.

## The claims to attack

| # | claim | kind |
|---|---|---|
| 1 | The tangent space to $O(k)$ at $Q$ is $\{Q\Omega:\Omega$ skew$\}$ and $d\varphi_r$ sends it to $2\,Q\circ(Q\Omega)$ | mathematics |
| 2 | At a zero-diagonal $Q$ every diagonal entry of that image vanishes, for every $\Omega$ and every $k$ | mathematics |
| 3 | Hence the image has dimension at most $(k-1)^2-k$, so $d\varphi_r$ is non-injective at every $k\ge3$ | mathematics |
| 4 | At $k=3$ a zero-diagonal orthogonal matrix cannot have all off-diagonal entries nonzero | mathematics |
| 5 | The stated $4\times4$ $M$ satisfies $MM^{\mathsf T}=3I$, has zero diagonal, and every other entry nonzero | mathematics |
| 6 | $\Omega=\mathop{\mathrm{diag}}(-1,1,1,1)M$ is skew, nonzero, and satisfies $M\odot(M\Omega)=0$, so the witness is singular | mathematics |
| 7 | The witness does not split | mathematics |
| 8 | Hence "singular implies splits" is false at $k=4$, and R28's boundary-to-split-locus step fails from $\lvert J\rvert=4$ | about a route |

## The Lean declarations, one row per claim

Every claim has a row. A cell names the declaration that types it, or the reason none can exist. File: [I106bSingularLocus.lean](../lean/HamiltonsCubic/Results/I106bSingularLocus.lean).

| # | Lean |
|---|---|
| 1 | none: the tangent space of a Lie group and the differential of a map between manifolds are not objects in this base layer, which carries matrices and no smooth structure |
| 2 | `dphi_diag_eq_zero`, stated at every size with `Q i i = 0` as its ONLY hypothesis, so it takes neither orthogonality of `Q` nor skewness of `Ω` |
| 3 | none: a rank and dimension statement, and rank is not typed in this layer. It is screened at $k=4$ only ([screen_I106b_zero_diagonal.py](../scripts/misc/screen_I106b_zero_diagonal.py)) |
| 4 | `no_second_type_at_three`, over four plain reals, the orthogonality hypothesis written out as `0 * c + a * 0 + b * d = 0` |
| 5 | `witness_mul_transpose` for $MM^{\mathsf T}=3I$ stated unnormalised so no square root enters, with `witness_diag` and `witness_offdiag_ne` |
| 6 | `Om` with `Om_skew`, `Om_ne_zero`, `witness_mul_Om` and `witness_singular`, so the kernel element is exhibited rather than the rank measured |
| 7 | `image_offdiag_ne` types that every off-diagonal entry of $M\circ M$ is nonzero. The passage from that to the absence of any permuted direct-sum decomposition is NOT typed |
| 8 | none: a claim about what a route's step can and cannot reach, which is not a proposition about matrices |

## What to do

1. **Claim 3 is the load-bearing step and the one most likely to be wrong.** The argument imposes $k$ zero-diagonal conditions on a $(k-1)^2$-dimensional space and subtracts. **Check whether those $k$ conditions are independent of the zero row-sum and column-sum conditions, and of each other.** If they are not, the bound $(k-1)^2-k$ is too strong. Note the claim only needs SOME drop below $\binom k2$, so say separately whether the bound is right and whether the conclusion survives a weaker bound. Check the inequality $(k-1)^2-k<\binom k2$ at $k=3,4,5,6$ and say where it actually holds.
2. **Claim 2 is where a reader nods.** Verify that $\varphi_r$'s differential really is $Z\mapsto2\,Q\circ Z$ and not something with a second term, and that "tangent vector $=Q\Omega$" is the right parametrisation rather than $\Omega Q$. **If the correct tangent is $\Omega Q$, does the diagonal argument still work?** That is the cheapest way this could fail.
3. **Claim 6 is checkable by hand and you should check it by hand**, including that $\Omega$ is genuinely skew and genuinely nonzero, and that the derivation pinning $\Omega$ is valid rather than one solution among many. Say whether the kernel is one-dimensional or larger.
4. **Claim 7 asks about a definition.** "Does not split" is stated via a connected support graph. **Is connectivity of the support graph actually equivalent to non-splitting as the source defines it**, up to permutations of rows AND columns independently? Say whether the block's argument establishes the source's notion or a different one.
5. **Claim 4**: confirm the pairing, and check whether the conclusion needs the matrix to be orthogonal or only to have two orthogonal rows.
6. **Claim 8 is a claim about a route.** Decide whether it follows from claims 1 to 7. In particular, R28 needs the maximum to sit on the boundary of the IMAGE, and the block argues about singular points of the MAP. **Are those the same set?** A singular point need not map to a boundary point, and a boundary point need not be the image of a singular point. Say whether the block has established what the route actually needs.
7. Return **CONFIRMED**, **PLAUSIBLE** or **REFUTED** per claim, with corrections.

**State what a claim would look like if it were vacuous, and check that it is not.** Claim 2 in particular: a statement with one hypothesis and a one-line proof may be a genuine mechanism or a restatement of the hypothesis, so say which.

**The most useful thing you can do is settle item 6**, whether singular points of the map and boundary points of the image are the same set here. If they are not, the block's conclusion about R28 does not follow even though every mathematical claim beneath it is true.

## Standing rules

**Analysis only.** A LONG or OPEN-ENDED run needs the user's approval for the specific task. **Permitted without asking**: screening a claim you are about to record, seconds of compute on objects you construct for that purpose, reported as a screen and never as evidence for a positive claim, and any run finishing in a few minutes on objects already in hand. **What waits**: a sweep over a parameter range, a census of a family, an optimisation whose cost is unknown before it starts. *The test is whether you can say in advance what it will cost and what it will decide.*

**Report.** Write `reviews/REVIEW_r<N>.md`. **Commit a skeleton in your first phase**: the title, the claim table with every verdict `NOT REACHED`, and the log path. Update one row per phase. **Commit that file with an explicit pathspec**, `git commit -m "<msg>" -- reviews/REVIEW_r<N>.md`, never `git add -A` and never `git commit -a`, because the git index is shared with a parent that may have staged its own work. **Never amend.**

**Do not write to [reviews/INDEX.md](INDEX.md).** The parent files every row after the last report lands, so neither reviewer publishes verdicts where the other will read them.

**Log** to `agent_logs/<task-name>.log`: first line carrying your PID and phase plan, a line at every phase transition, a heartbeat at least every 3 minutes carrying live state, and a closing line that **OPENS** with `DONE ` or `FAILED `, after at most a timestamp, as the last line written to the file.

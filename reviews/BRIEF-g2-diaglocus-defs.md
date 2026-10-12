# Gate 2 brief: do the Lean layer's diagonal-locus definitions mean what the record means?

**You are a cold reviewer.** You have not seen the work that produced the theorems below and you are
not being told what its author concluded. Read the sources and the record and answer the attack
items from them.

**Your subject is the DEFINITIONS, not the proofs.** Every theorem named here is checked by Lean's
kernel on the standard three axioms, so a manipulation error is not available to you and hunting one
is wasted effort. What the kernel cannot check is whether the objects the statements quantify over
are the objects the record means. **A theorem about the wrong object is a true theorem and an empty
one.** Two defects of exactly that shape reached commits in this repository in the last week: a
closed form derived from a definition quoted with one application of an operator where the layer
applies two, and a statement whose binder quantified over every matrix where the derivation needed a
symmetric one.

Read [reviews/_g2-standing.md](_g2-standing.md) first and follow it. **Analysis only**: computation
needs the user's approval for a specific task and it has not been given here. The one allowance is
screening a claim you are about to record, seconds of compute on objects you construct for that
purpose, reported as a screen and never as evidence for a positive claim. A run of a few minutes on
objects already in hand is permitted. Sweeps, censuses and unbounded searches are not: name them and
stop.

**Log** to `agent_logs/r1001.log`.

## What to read

- [lean/HamiltonsCubic/Base/WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean), the
  definitions of `inner2`, `br`, `phi`, `sharpQF`, `innerOp`, `compOp`, `trCube`, `sharpBil`,
  `sharpOp`, `sharpPair`, `Pcubic`, `normSq`, `theta`.
- [lean/HamiltonsCubic/Base/Families.lean](../lean/HamiltonsCubic/Base/Families.lean), the
  definitions of `diagOp`, `IsWeight`, `sphereWeight`, `diagP`, `thetaSplitSq`, `thetaSplit`,
  `DiagCubicFormula`, `SphereProductValue`, `IsSphereProduct`.
- [lean/HamiltonsCubic/Base/SharpDiag.lean](../lean/HamiltonsCubic/Base/SharpDiag.lean) and
  [lean/HamiltonsCubic/Base/SphereValue.lean](../lean/HamiltonsCubic/Base/SphereValue.lean), the
  statements proved. Read the statements. You may skip the tactic blocks.
- The record's own account of the same objects: [findings/INDEX.md](../findings/INDEX.md) and the
  findings file it names for the diagonal locus, [results.md](../results.md) for any numbered result
  quantifying over the locus or the sphere product, and [README.md](../README.md) for the goal.

## Attack items

Answer every one in writing, including where you find nothing.

1. **`Pcubic`.** Is `Pcubic R` as defined the cubic form the record maximises, including its
   normalisation? The definition carries a `1/2` in `innerOp`, a `1/2` in `inner2` and a `1/4` in
   `sharpQF`. Track each against the record's own statement of `P` and of `theta`. A factor that is
   wrong by a constant makes every value below wrong by a constant and every equality between two of
   them still true.
2. **`diagOp` and `IsWeight`.** Is `diagOp w` the record's curvature operator on the diagonal locus,
   and is `IsWeight` the record's `D_n`? `IsWeight` has three clauses, symmetry, hollowness and zero
   row sums. Does the record's locus have exactly these? Name any clause the record has that
   `IsWeight` lacks, and any `IsWeight` has that the record does not.
3. **`diagP`.** Is `diagP w` the weighted-graph functional the record states for the locus, term for
   term, including the `1/2` and the relation between the entrywise cube sum and the trace term?
4. **`DiagCubicFormula` and `SphereProductValue` as `Prop`s.** Does each say what the record means by
   the obligation it is named for? **Apply the trap named in
   [plan-lean.md](../plan-lean.md)**: exhibit an object each `Prop`'s hypotheses rule out. A
   hypothesis satisfied by every object in range makes a discharge empty.
5. **The hypotheses of the new theorems.** `sharpQF_diagOp` binds symmetry of `w` and `a ≠ b` and
   binds neither hollowness nor zero row sums. `trCube_diagOp` and `sharpPair_diagOp` bind symmetry
   and hollowness and not the row sums. `sphereWeight_diagP` binds `2 ≤ p` and `2 ≤ q`. For each:
   is the hypothesis set sufficient for the conclusion as stated, and does dropping any one of them
   make the statement false? Where you claim a hypothesis is unnecessary, say so as a claim about
   the statement and not about the proof.
6. **`sphereWeight` and `thetaSplit`.** Is `sphereWeight S` the record's sphere-product weight at the
   scale the record uses, and is `thetaSplit p q` the record's `theta_{p,q}`? Check the scale
   explicitly: the file's own comment says the entries are `pq` times the record's.
7. **The `L57` claim.** The record states in several places that `DiagCubicFormula` and L57's
   `tr W^3` bridge are the same statement under another name, so that proving the first discharges
   the second. Is that true as stated? Locate L57's bridge in the record and compare it with
   `DiagCubicFormula` directly.

## Verdict

Per claim, one of `confirmed`, `refuted`, `withdrawn`, or `no argument on file`. **Silence is not a
verdict.** File `reviews/REVIEW_r1001.md` and add your row to [reviews/INDEX.md](INDEX.md),
committing only those two paths.

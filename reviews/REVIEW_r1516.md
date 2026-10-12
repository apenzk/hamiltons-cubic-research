# Review r1516: L44's heading with no imported value, and the repair of r1515's statement-row gaps (commits 731d4f5f and 7a498b05)

*Gate 2, one reviewer, Lean layer. Subject: commit 731d4f5f, which adds [L44Witness.lean](../lean/HamiltonsCubic/Results/L44Witness.lean) (`witness`, `L44_heading`) and names it in the L44 main row of [lean/INDEX.md](../lean/INDEX.md), and commit 7a498b05, which answers [REVIEW_r1515.md](REVIEW_r1515.md)'s gaps L44-1r, L157-3r, L37-1r and the open L44-3 in the L44, L157 and L37 statement rows and in the headers of [L44Statement.lean](../lean/HamiltonsCubic/Results/L44Statement.lean) and [L157Statement.lean](../lean/HamiltonsCubic/Results/L157Statement.lean). Analysis only: one build and one axiom audit were run, nothing numerical.*

| item | claim | verdict |
| --- | --- | --- |
| A-1 | `witness` derives IsWeyl, normSq 1 and Pcubic = √(3/2) for `Wc n` at every n ≥ 4 from CP2Real's `Wc_weyl`, `Wc_values` and `Wc_theta` | **CONFIRMED** |
| A-2 | `Wc n` is the record's zero-padded W_{CP²} | **CONFIRMED** |
| A-3 | `IsWeyl`, `normSq` and `Pcubic` are the definitions `hwitness` uses | **CONFIRMED** |
| A-4 | `L44_heading` proves L44's heading with no imported value, and `hub`, `hatt` are neither vacuous nor the conclusion | **CONFIRMED** |
| B | build, no `sorry`, axiom audit | **CONFIRMED** |
| L44-1r | the L44 statement row reads partial and claims the heading only | **CONFIRMED WITH GAP** |
| L44-3 | L44Statement.lean's header no longer calls the value imported and unproved | **CONFIRMED WITH GAP** |
| L157-3r | the L157 statement row and file header say every algebraic clause, the branches' derivation owed | **CONFIRMED** |
| L37-1r | the L37 statement row places the corollary at a diagonal W | **CONFIRMED** |
| D | style of the changed rows, headers and the new file | **CONFIRMED WITH GAP** |

**Summary: the witness and the unconditional heading are correct and sound (2/2 on the standard three axioms), and the four index rows now say what the files prove, but L44Statement.lean's own header still says the elementary route "delivers the lemma's conclusion" from "one imported value", the overstatement L44-1r removed from the row, and the edited L37 row keeps a semicolon splice.**

## A. L44Witness.lean

- **A-1.** `witness` ([L44Witness.lean:25](../lean/HamiltonsCubic/Results/L44Witness.lean)) takes IsWeyl from `Wc_weyl` ([CP2Real.lean:186](../lean/HamiltonsCubic/Results/CP2Real.lean)) and normSq = 1 from `Wc_values`'s first conjunct ([CP2Real.lean:303](../lean/HamiltonsCubic/Results/CP2Real.lean)). For P it unfolds `theta` and `norm` in `Wc_theta` ([CP2Real.lean:329](../lean/HamiltonsCubic/Results/CP2Real.lean)), which gives Pcubic(Wc n)/√(normSq)³ = √(3/2), then rewrites normSq = 1, √1 = 1, 1³ = 1 and division by 1. With θ = P/‖W‖³ ([WeylReal.lean:180](../lean/HamiltonsCubic/Base/WeylReal.lean)) that is exactly P = √(3/2) at unit norm. Correct, and the kernel accepts it.
- **A-2.** `Wc n` ([CP2Real.lean:177](../lean/HamiltonsCubic/Results/CP2Real.lean)) is Σ_a μ_a⟨·, ω_a⟩ω_a with μ = (2, -1, -1)/√6 and ω_a = E J_a Eᵀ/√2, where E embeds ℝ⁴ as the first four coordinates of ℝⁿ. The three J_a are e₁₂+e₃₄, e₁₃-e₂₄ and e₁₄+e₂₃ up to sign, a basis of the self-dual forms, and `om_inner` makes the ω_a orthonormal for `inner2`. So `Wc n` acts as diag(2, -1, -1)/√6 on Λ⁺ℝ⁴ and as zero on Λ⁻ℝ⁴ and on every bivector leaving the first four coordinates, which is the record's W_{CP²} = diag(0,0,0,-1,-1,2)/√6 on Λ²(ℝ⁴), zero-padded ([problem.md:342](../findings/problem.md)), and the operator the L44 block uses ([problem.md:205](../findings/problem.md), [problem.md:213](../findings/problem.md)).
- **A-3.** L44Statement.lean imports `HamiltonsCubic.Base.WeylReal` and opens `HamiltonsCubic.RealLayer`, and so do CP2Real.lean and L44Witness.lean. `IsWeyl` ([WeylReal.lean:126](../lean/HamiltonsCubic/Base/WeylReal.lean)), `Pcubic` (line 170) and `normSq` (line 173) are the one set of definitions in all three. The other `IsWeyl` in the layer ([L94Statement.lean:71](../lean/HamiltonsCubic/Results/L94Statement.lean)) lives in a namespace L44Witness does not open. That `⟨Wc n, witness h4⟩` typechecks as `hwitness` confirms the match mechanically.
- **A-4.** `L44_heading` ([L44Witness.lean:36](../lean/HamiltonsCubic/Results/L44Witness.lean)) is `L44_elementary` with `hwitness` supplied, so its binders are `h4`, `h11`, `M`, `hub` and `hatt`, and none of them carries θ(S⁴) = √(3/2). The conclusion is a unit Weyl W with M < P(W)², which at unit norm is θ(W)² > M, the heading's "the conjecture's conclusion fails" once M is Θₙ². `hub` and `hatt` together say M is the maximum of `thetaSpSq` over splits p + q = n with p, q ≥ 2, satisfiable at every n ≥ 4 (the split 2 + (n-2) exists, and a finite set has a maximum). Neither mentions a Weyl tensor, so neither assumes the conclusion. *Observation, not a gap*: `hub` is not spent (`have _ := hub` in [L44Statement.lean:142](../lean/HamiltonsCubic/Results/L44Statement.lean)), because every split value lies below 3/2. The theorem therefore holds for any attained split value M, which is stronger than the stated form, and `hub` only pins M to Θₙ².

## B. Soundness

- `~/.elan/bin/lake build HamiltonsCubic.Results.L44Witness` completed successfully (8716 jobs). The only warnings are four longLine warnings in L44Witness.lean (see D-2).
- `grep` finds no `sorry`, `native_decide` or `axiom` in L44Witness.lean.
- `python3 scripts/misc/axiom_audit.py --only L44Witness`: **2/2 clean**, resting on the standard three axioms alone. The audit is transitive, so `Wc_weyl`, `Wc_values` and `Wc_theta` are covered.

## C. The records

### L44

- **L44 main row** ([lean/INDEX.md:612](../lean/INDEX.md)): reads **partial**, names L44Witness.lean beside L44.lean, says the statement row proves the heading, owes the cone conclusion, and says `hwitness` is discharged by `witness` and that `L44_heading` is the elementary route with no imported value. Accurate against section A.
- **L44-1r, statement row** ([lean/INDEX.md:613](../lean/INDEX.md)): now **partial**, *"delivers the heading, that the conjecture's conclusion fails for 4 ≤ n ≤ 11, and leaves the cone conclusion untyped"*. The phrase *"the conclusion outright"* is gone. Repaired in the row.
- **Gap L44-1f** ([L44Statement.lean:28](../lean/HamiltonsCubic/Results/L44Statement.lean) to line 29): the file header still reads *"It delivers the lemma's conclusion (the hypothesis n ≥ 12 is the problem's)"*. The lemma's stated conclusion is that Ω₀ is non-invariant for 4 ≤ n ≤ 11 ([problem.md:205](../findings/problem.md)), which the same header says at line 40 *"is not stated"* and which [problem.md:213](../findings/problem.md) says the elementary witness does not give. This is r1513's L44-1 overstatement, repaired in both index rows and left standing in the docstring they describe. It should read *"the heading"*, as the row does.
- **Gap L44-1s** ([lean/INDEX.md:613](../lean/INDEX.md)): r1515 asked the row to say the heading is delivered *"conditional on `hwitness`"*. The row names neither the binder nor L44Witness.lean, so it reads as if L44Statement.lean alone proves the heading. The claim is true of the layer through `L44_heading`, and the main row carries the pointer, so this is minor.
- **L44-3** ([L44Statement.lean:52](../lean/HamiltonsCubic/Results/L44Statement.lean) to line 53): *"imported, not proved"* is replaced by *"It is proved in the same types by CP2Real.lean's `Wc_theta`, and L44Witness.lean discharges the binder."* Accurate. **Gap L44-3r**: the rest of the file still presents the value as external. The section heading at [L44Statement.lean:47](../lean/HamiltonsCubic/Results/L44Statement.lean) reads *"The imported value, and it is the only one"*, line 29 says *"from one imported value"*, line 128 *"Given the imported witness"*, and the `L44_elementary` docstring at [L44Statement.lean:133](../lean/HamiltonsCubic/Results/L44Statement.lean) to line 134 says the binder *"is imported (Nienhaus Thm 4.14(a) plus zero-padding) and is the only input beyond arithmetic"*, with no pointer to `witness`. Read as "enters this file as a hypothesis" each is defensible, but the docstring names Nienhaus as the source of a value the layer proves, which is the reading L44-3 flagged.

### L157

- **L157-3r: repaired.** The statement row ([lean/INDEX.md:504](../lean/INDEX.md)) reads *"Every algebraic clause of the boxed lemma, with no `sorry`, the two branches taken as the lemma's setting and their derivation owed"*, and the file header ([L157Statement.lean:19](../lean/HamiltonsCubic/Results/L157Statement.lean) to line 21) says the same and adds *"the location and uniqueness in (0,1)"*, which `unique_root` now supplies. Both agree with the main row's owed clause at [lean/INDEX.md:503](../lean/INDEX.md). The **proved** tag stays on a statement row whose owed part is the setting, which r1515 already judged defensible.

### L37

- **L37-1r: repaired.** [lean/INDEX.md:615](../lean/INDEX.md) now reads *"The corollary: at a diagonal W, `diagIn g` is an n-dimensional subspace of ker Φ_W"*, with g the diagonalising frame of the preceding sentence. That is the step inside `criterion'`'s second conjunct ([L37Statement.lean:484](../lean/HamiltonsCubic/Results/L37Statement.lean) to line 490), and it no longer reads as an unconditional lower bound. *Remark, not charged*: the proposition the theorem states is the contrapositive dimension test, dim ker Φ_W < n ⇒ not diagonal ([L37Statement.lean:511](../lean/HamiltonsCubic/Results/L37Statement.lean)), which the row still does not name.

## D. Style

- The added lines of both commits carry no em dash and no backtick inside markdown link text. Rows 504, 612, 613 and 615 of lean/INDEX.md are single lines closed by a pipe.
- **Gap D-1** ([lean/INDEX.md:615](../lean/INDEX.md)): the L37 statement row, rewritten by 7a498b05, keeps *"and $a_i=2^i$ has distinct sums; conversely conjugation turns"*, a semicolon splicing two independent clauses. It predates the commit, and r1515's D-2 repaired the same splice pattern in the main row directly above.
- **Gap D-2** ([L44Witness.lean:8](../lean/HamiltonsCubic/Results/L44Witness.lean), lines 9, 13 and 34): four lines exceed 100 characters and the build reports them, since the file, unlike CP2Real.lean and L44Statement.lean, does not set `linter.style.longLine false`. Cosmetic.
- *Remark*: [L157Statement.lean:21](../lean/HamiltonsCubic/Results/L157Statement.lean) is a short dangling docstring line (*"uniqueness in `(0,1)`,"*) left by the rewrap. It is a Lean docstring, not markdown, so it is not charged.

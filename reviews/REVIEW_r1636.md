# REVIEW r1636: L120's cut by ⟨M⟩ and the block size, repairs to r1635 (commits 3ad2ff39, 8aaba6a9)

**Verdict: CONFIRMED WITH GAPS.** Every new declaration is sound and faithful to its docstring, and r1635's G1 and G2 are closed. What remains is representational: the two halves of "e lies in D_n and L_e e = e" and the perp theorems live on `CurvLin` and bare operators, while `L_e` and `W^⊥` live on `CurvOp2`. The bridges are one-liners (screened below) and are not declared. One propositional tautology survives in L120.lean.

Source: [findings/second-order.md](../findings/second-order.md), Lemma L120 (line 1181), the box at line 1187 and the block-size clause at line 1185. Footing: analysis only. Runs made: one scratch compile (a screen, two `example`s) and the axiom audit.

## Claim table

| # | Claim | Verdict | Evidence |
|---|---|---|---|
| 1 | L120.lean header states the record's reason for the cut | CONFIRMED | L120.lean:15–21 now reads `e = M/θ ∈ D_n`, `L_e e = e`, `λ_max ≥ 1 > ½`, matching second-order.md:1187. The false "P constant along ⟨M⟩" and both tautologies (`¬((0:ℚ)<0)`, `∃ x < 0`) are gone. |
| 2 | L120.lean header, "Criticality is unused" | CONFIRMED WITH GAPS | The statement is true (`L120_block_diag` carries no criticality hypothesis), but the file's only declaration for it, `criticality_unused` (L120.lean:51–52), is `(Diag → Concl) → Diag → Crit → Concl`, a propositional tautology true of every triple of propositions. It certifies nothing about L120, the same defect r1635 found in the removed pair (G-A). |
| 3 | `diag_e_eigen` gives L_e e = e | CONFIRMED WITH GAPS | Sound: it is `Le_self` (L24Eigen.lean:139) instantiated at `restrict (diagOp_isWeyl hwt)`. `LeLin a v = foxProd2 (P(a)⁻¹ • a) v` (L24Restrict.lean:87), and `Le_self` derives `P(a) = lam`, so θ is the record's θ. The typed statement is `L_e M = M`, and `L_e e = e` follows by dividing by θ ≠ 0, which is by reading and harmless. |
| 4 | `diag_in_trivial` gives e ∈ D_n | CONFIRMED WITH GAPS | Sound (`diagS_flip`). It states flip-fixedness only. Membership in `weylModuleS` is `diagS_mem` and the D_n characterisation is `diagSummand_iff` in L120Diag.lean, neither cited in the statement. By reading. |
| 5 | Items 3 and 4 together say "e lies in D_n and L_e e = e" | CONFIRMED WITH GAPS | They are about different objects: `restrict (diagOp_isWeyl hwt) : CurvOp2` (L120Cut.lean:33–39) and `diagS w = diagOpL w ∘ skewProj : CurvLin` (L120Cut.lean:42–44, L120Diag.lean:31). D_n is typed only on `CurvLin`, so `λ_max(L_e|_{D_n})` has no Lean meaning yet. The bridge holds: **screen** `((restrict (diagOp_isWeyl hwt) X) : Matrix) = diagS w X` for `X : skewSub`, by `restrict_apply`, `skewProj_skew`, `rfl`, compiled clean. Undeclared (G-B). |
| 6 | `blockSize_eq` ties `blockSize` to the proved dimensions | CONFIRMED | L120Cut.lean:48–55 rewrites with `fourSummand_finrank` and `pairSummand_finrank` and closes by `rfl`, so `max 2 (n−3)` is the max of the two proved finranks at any distinct `i,j,k,l` and `j' ≠ k'`. All blocks of one kind share a dimension, so this is the largest non-diagonal block. r1635 G1 closed. |
| 7 | `innerOp_diagS_eq_zero` | CONFIRMED | L120Cut.lean:59–67: `diagS w (φ_ab) = w_ab φ_ab` (`diagS_phi`), so every summand of `innerOp` is `w_ab · B_abab`, zero by hypothesis. Needs only symmetry of `w`. |
| 8 | `pair_perp_diag`, `four_perp_diag` | CONFIRMED | L120Cut.lean:71–87. `(a,b,a,b)` fails `pairForm_shape`'s first conjunct and `fourForm_shape`'s `a ≠ c`. Faithful to "isotypic orthogonality". |
| 9 | These are "W^⊥ cuts D_n and nothing else" | CONFIRMED WITH GAPS | The perp theorems use bare `innerOp` on `CurvLin` operators. `W^⊥` is `weylPerpR a ⊆ CurvOp2` with `innerOp2` (L24Restrict.lean:107). **Screen**: `innerOp2 (restrict hR) (restrict hS) = innerOp R S` is `rfl` (compiled clean, and L122Cap.lean:137 has the same fact for `restrictLin`). With item 5's bridge the membership of each pair and four summand in `W^⊥` follows, but it is not typed. The "cuts D_n" half (D_n ∩ W^⊥ is proper) needs M ≠ 0 and M ∈ D_n, again by reading. The row presents the clause as declared while its own Owed entry admits the sign action is not carried to `CurvOp2`, and this clause has the same transport gap in milder form (G-B). |
| 10 | INDEX row: status partial, Owed = Hessian block-diagonality as one declaration | CONFIRMED WITH GAPS | Status **partial** is right. The Owed entry is accurate for the Hessian. Two section clauses are neither declared nor owed: "$\binom n4$ of them have size 2" (second-order.md:1185, no count of four-set summands anywhere in L120Direct.lean or L120Span.lean, and `L120_dim_sum` treats $\binom n4$ as a polynomial) and "checkable block by block", which rides on the owed Hessian item and should be named with it (G-C). |
| 11 | Axiom audit | CONFIRMED | `axiom_audit.py --only L120Cut.lean`: 6/6 standard three. `--only L120.lean`: 4/4 standard three. No `sorry`, no `native_decide`. |

## What would break each claim, and what I did to look

- Item 3: a `foxProd2` that is not `L_e` up to θ, or θ differing from P(M). Read `LeLin` and `Le_self`'s proof of `P(a) = lam`. Neither breaks it.
- Items 5 and 9: `restrict (diagOp w)` and `diagS w` disagreeing on Λ², or `innerOp2` differing from `innerOp` on restrictions. Compiled both identities in a scratch file. Both hold, so the gaps are unassembled steps and not errors.
- Item 6: a hidden off-by-one in `pairSummand_finrank`'s `3 ≤ n` side condition. It is discharged by `omega` from `4 ≤ n`, and the final `rfl` matches `max 2 (n−3)` exactly.
- Item 8: a diagonal coordinate that is a PairForm or four-distinct position. The shape lemmas exclude `a = c` directly.
- Item 2: a declaration whose statement mentions L120's objects. `criticality_unused` mentions none. The same pattern sits in L128.lean:65 and L155.lean:52 (outside this review's scope).

## Gaps

- **G-A** (L120.lean:23–24, 49–52): replace `criticality_unused` with a citation of `L120_block_diag`'s hypothesis list, or delete it. As it stands it is the kind of tautology r1635 had removed.
- **G-B** (L120Cut.lean:33–44, 71–87, INDEX.md:475): declare the two bridges, `restrict (diagOp_isWeyl hwt)` agreeing with `diagS w` on `skewSub`, and the perp theorems restated as membership in `weylPerpR (restrict (diagOp_isWeyl hwt))` for the restriction of each pair and four summand. The screen shows each is a few lines. Until then the row should say the cut is declared on `CurvLin` and the transport to `W^⊥` is by reading.
- **G-C** (INDEX.md:475): list "$\binom n4$ of them have size 2" and "checkable block by block" in Owed, or declare the count.

**One line**: r1635's G1 and G2 are closed and every new theorem is sound, but "e ∈ D_n with L_e e = e" and "W^⊥ cuts D_n and nothing else" are assembled across `CurvLin` and `CurvOp2` by an undeclared one-line bridge, and a propositional tautology still stands in for "criticality is unused".

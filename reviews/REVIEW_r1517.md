# Review r1517: L160's displayed identity in Lean, and the repair of r1516's gaps (commits 229b682f and ad1db72c)

*Gate 2, one reviewer, Lean layer. Subject: commit 229b682f, which adds [L160Identity.lean](../lean/HamiltonsCubic/Results/L160Identity.lean) (`zPerpV`, `Pm`, `proj_comm`, `Pm_comm`, `L160_identity`) and moves the L160 row of [lean/INDEX.md](../lean/INDEX.md) to **proved**, and commit ad1db72c, which answers [REVIEW_r1516.md](REVIEW_r1516.md)'s gaps L44-1f, L44-1s, L44-3r, D-1 and D-2 in [L44Statement.lean](../lean/HamiltonsCubic/Results/L44Statement.lean), [L44Witness.lean](../lean/HamiltonsCubic/Results/L44Witness.lean) and the L44 and L37 statement rows. Analysis only: two builds and one axiom audit were run, nothing numerical.*

| item | claim | verdict |
| --- | --- | --- |
| A-1 | `zPerpV x` is the block's right side, with so(V) the skew matrices killing K = ker x and c_V = c ∩ so(V) | **CONFIRMED** |
| A-2 | c_V as the so(V)-component of c = c_V ⊕ so(K) agrees with c ∩ so(V) | **CONFIRMED** |
| A-3 | taking the centraliser and orthogonal complement inside so(m) rather than so(V) changes nothing | **CONFIRMED** |
| A-4 | `L160_identity` at m ≠ 3 is the displayed identity | **CONFIRMED** |
| A-5 | a witness satisfies both sides | **CONFIRMED** |
| B | build, no `sorry`, axiom audit, the converse's Pc + (1 − P)c split, no hidden hypotheses | **CONFIRMED** |
| C-L160 | the L160 row of lean/INDEX.md, INDEX-results row 160 and isotropy-cap.md's machine-checked line | **CONFIRMED WITH GAP** |
| L44-1f | L44Statement.lean's header says the route delivers the heading | **CONFIRMED** |
| L44-1s | the L44 statement row names `hwitness` and L44Witness.lean | **CONFIRMED** |
| L44-3r | L44Statement.lean no longer presents the value as imported without a pointer to its proof | **CONFIRMED** |
| D-1 | the L37 statement row's semicolon splice is split | **CONFIRMED** |
| D-2 | L44Witness.lean's long-line warnings are gone | **REFUTED** |
| D | style of the changed rows, lines and files | **CONFIRMED WITH GAP** |

**Summary: `L160_identity` is L160's displayed identity, correctly read and soundly proved (11/11 on the standard three axioms, generalising to every skew x at m ≠ 3), and four of r1516's five gaps stand repaired, but D-2 does not: the `set_option` was placed after the module docstring, so the build still warns on L44Witness.lean lines 8, 9 and 13, and the same commit adds two new warnings at L44Statement.lean lines 30 and 31.**

## A. Fidelity of L160Identity.lean

The source is [isotropy-cap.md:111](../findings/isotropy-cap.md) to line 112: for nonzero x ∈ so(m), V = im x, K = ker x and c = z(x) ∩ x^⊥, the display z(c) ∩ c^⊥ = z_{so(V)}(c_V) ∩ c_V^{⊥_V}, and the proof at line 114 writes c = c_V ⊕ so(K).

- **A-1.** `zPerpV x` ([L160Identity.lean:30](../lean/HamiltonsCubic/Results/L160Identity.lean)) is the set of y that are `Skew`, kill every z with x z = 0, and have `br y c = 0` and `inner2 y c = 0` for every c ∈ `cc x` killing ker x. A skew matrix killing K maps V into V (for v ∈ V and k ∈ K, ⟨y v, k⟩ = −⟨v, y k⟩ = 0), so "skew and killing K" is exactly so(V) embedded in so(m) as the block-diagonal matrices zero on K. With `cc x` = {u skew, inner2 x u = 0, br x u = 0} ([L81Statement.lean:129](../lean/HamiltonsCubic/Results/L81Statement.lean)), the quantifier ranges over c ∩ so(V). That is the block's right side with c_V read as c ∩ so(V).
- **A-2.** Every c ∈ c commutes with x, so it preserves K and, being skew, preserves V = K^⊥. Hence c = PcP + (1 − P)c(1 − P) with P the orthogonal projection onto V, and the so(V)-component is Pc. The file proves Pc ∈ c ([L160Identity.lean:151](../lean/HamiltonsCubic/Results/L160Identity.lean)) and that it kills K, so the so(V)-component of every element of c lies in c ∩ so(V). Conversely c ∩ so(V) is its own component. So the projection of c onto so(V) equals c ∩ so(V), and the block's c_V is the file's. The K-part (1 − P)c is skew, commutes with x and is orthogonal to x (x(1 − P) = 0), so it lies in c ∩ so(K), and every element of so(K) lies in c for the same reason, which is the block's c = c_V ⊕ so(K).
- **A-3.** For y and c both supported on V, the m × m bracket yc − cy is the embedding of the so(V) bracket, and inner2 y c = ½ tr(yᵀc) is the trace of a product of V-supported matrices, equal to the trace form on V. So "commutes with and orthogonal to c_V" means the same in so(m) and in so(V), and z_{so(V)}(c_V) ∩ c_V^{⊥_V}, embedded, is `zPerpV x`. The ½ in `inner2` scales the form and leaves orthogonality unchanged. No difference matters.
- **A-4.** `L160_identity` ([L160Identity.lean:126](../lean/HamiltonsCubic/Results/L160Identity.lean)) states, for skew x and m ≠ 3, y ∈ `zPerp x` iff y ∈ `zPerpV x`, and `zPerp x` ([L81Statement.lean:150](../lean/HamiltonsCubic/Results/L81Statement.lean)) is z(c) ∩ c^⊥ inside so(m). That is the displayed identity as a set equality. The block's hypothesis x ≠ 0 is dropped: at x = 0 both sides are {0} (c = so(m), and a skew y orthogonal to all of so(m) is orthogonal to itself, while killing K = ℝ^m forces y = 0 on the right), so the theorem is slightly stronger than the display. The restriction m ≠ 3 is the lemma's own and is necessary, as L160.lean's `L160_three` shows.
- **A-5. Witness.** m = 5, x = (E₁₂ − E₂₁) + 2(E₃₄ − E₄₃). Then V = span(e₁,…,e₄), K = span(e₅). The eigenvalues ±i, ±2i, 0 are distinct, so z(x) = span(E₁₂ − E₂₁, E₃₄ − E₄₃), and c = ℝ·(2(E₁₂ − E₂₁) − (E₃₄ − E₄₃)), since ½ tr(xᵀc) = ½(2 + 2 − 2 − 2) = 0. Take y = x. It is skew, kills e₅, commutes with c, and is orthogonal to it, so y ∈ z(c) ∩ c^⊥. Every element of c kills e₅, so c_V = c and the same checks put y in `zPerpV x`. This is the corank-1 case, the one the block says runs on c_V's trivial common kernel. A non-member of both sides is E₁₅ − E₅₁, which moves e₅.

## B. Soundness

- `~/.elan/bin/lake build HamiltonsCubic.Results.L160Identity` completed successfully (8712 jobs). The file is imported by [HamiltonsCubic.lean:770](../lean/HamiltonsCubic.lean).
- `grep` finds no `sorry`, `admit`, `native_decide` or `axiom` in the file. `python3 scripts/misc/axiom_audit.py --only L160Identity`: **11/11 clean, resting on the standard three axioms alone**.
- **The forward direction** ([L160Identity.lean:132](../lean/HamiltonsCubic/Results/L160Identity.lean) to line 133) is `L160_support` for killing K and a restriction of the quantifier for the rest. Correct.
- **The converse.** `proj_comm` ([L160Identity.lean:79](../lean/HamiltonsCubic/Results/L160Identity.lean)) shows that a skew A preserving K commutes with `proj`: writing v = p + k, the residual q = Ap − P(Ap) lies in K and is orthogonal to itself, since q · Ap = −(Aq) · p = 0 by skewness and A q ∈ K. `Pm_comm` (line 105) lifts that to matrices through `Pm_mulVec` and `mat_ext`. `mul_Pm` (line 110) gives AP = A for A killing K. In `L160_identity`, c ∈ c preserves K because xc = cx, so Pc = cP. Then Pc is skew (`Pm_symm`), orthogonal to x (x(c − Pc) = x(1 − P)c = 0 since xP = x), and commutes with x (xPc = xc = cx = cPx = Pcx using Px = x = xP), so Pc ∈ c and kills K. The hypothesis gives [y, Pc] = 0 and ⟨y, Pc⟩ = 0. The remainder is invisible to y: y(c − Pc) = yc − yPc = 0 from yP = y, and (c − Pc)y = cy − cPy = 0 from Py = y (line 172 to line 175), and ½ tr(yᵀ(c − Pc)) = −½ tr(y(c − Pc)) = 0. The `<;> first | … | …` combinator at line 176 dispatches the bracket and inner-product goals with the shared setup, each branch closing exactly one. Correct.
- **Hidden hypotheses: none.** The binders are `hx : Skew x`, `hm : m ≠ 3` and y. The normal form `N` is obtained inside from `nf_exists`, and `kerK` ties `x *ᵥ z = 0` to `InK N z` both ways, so the statement does not depend on the choice of `N`.

## C. Records

### L160

- **The L160 row** ([lean/INDEX.md:415](../lean/INDEX.md)) reads **proved**, names both files, and says `L160_identity` gives, at m ≠ 3, y ∈ z(c) ∩ c^⊥ iff y ∈ so(V) commutes with and is orthogonal to c_V = c ∩ so(V), with so(V) the skew matrices killing ker x, and describes the Pc + (1 − P)c split. Accurate against sections A and B. Its closing sentence, that at m = 3 the identity is false with sides of dimension 3 and 1, is prose rather than a Lean claim. It holds (c = 0 there, and V is a plane) and it follows from `L160_three`, which exhibits an element of the left side moving ker x.
- **INDEX-results row 160** ([findings/INDEX-results.md:176](../findings/INDEX-results.md)): *"Lean: proved, L160.lean for the iff and L160Identity.lean for the displayed identity at m ≠ 3"*. Accurate.
- **The machine-checked line** ([isotropy-cap.md:126](../findings/isotropy-cap.md)): adds *"The displayed identity at m ≠ 3 is `L160_identity` in L160Identity.lean"*. Accurate.
- **Gap L160-R1** ([L160.lean:27](../lean/HamiltonsCubic/Results/L160.lean) to line 29): L160.lean's header still says the displayed identity *"is stated in the block on 𝔰𝔬(V) and is not typed here"* and points only at `L160_support`. The sentence is true of the file, but the commit that typed the identity left the file that a reader opens first for L160 without a pointer to L160Identity.lean, the kind of stale header r1516 charged as L44-3r. Minor.

### r1516's gaps, ad1db72c

- **L44-1f: repaired.** [L44Statement.lean:28](../lean/HamiltonsCubic/Results/L44Statement.lean) to line 31 now reads *"It delivers the lemma's heading, that the conjecture's conclusion fails for 4 ≤ n ≤ 11 … from the padded ℂP² value as the binder `hwitness` and the arithmetic"*, and names L44Witness.lean as discharging the binder. The overstatement "the lemma's conclusion" is gone.
- **L44-1s: repaired.** The L44 statement row ([lean/INDEX.md:613](../lean/INDEX.md)) now says the heading comes *"from the padded value as the binder `hwitness`, which L44Witness.lean discharges"*.
- **L44-3r: repaired.** The section heading at [L44Statement.lean:48](../lean/HamiltonsCubic/Results/L44Statement.lean) is *"The padded value, the one input beyond arithmetic"*, line 129 reads *"Given the padded witness"*, and the `L44_elementary` docstring (line 134 to line 136) keeps Nienhaus as the provenance of the value but adds that `L44_heading` supplies it from CP2Real.lean's `Wc_theta`. No line calls the value imported any more, and every mention of its source carries the pointer to its proof.
- **D-1: repaired.** [lean/INDEX.md:615](../lean/INDEX.md) now reads *"… has distinct sums. Conversely, conjugation turns …"*.
- **Gap D-2r, D-2 NOT repaired** ([L44Witness.lean:20](../lean/HamiltonsCubic/Results/L44Witness.lean)): `set_option linter.style.longLine false` is inserted after the module docstring, so it covers only line 36. `lake build HamiltonsCubic.Results.L44Witness` still reports *"This line exceeds the 100 character limit"* at [L44Witness.lean:8](../lean/HamiltonsCubic/Results/L44Witness.lean), line 9 and line 13, three of r1516's four. The commit message's *"D-2: L44Witness sets the long-line option"* is literally true and does not deliver the repair D-2 asked for. Cosmetic.

## D. Style

- The added markdown lines of both commits (lean/INDEX.md rows 415, 613 and 615, INDEX-results row 176, isotropy-cap.md line 126) carry no em dash, no semicolon splice and no backtick inside link text. Each row is a single line closed by a pipe, and the machine-checked line is one unwrapped paragraph. The semicolons added to plan-lean.md and STATUS.md are in generated tables and separate list items.
- **Gap D-3** ([L44Statement.lean:30](../lean/HamiltonsCubic/Results/L44Statement.lean) and line 31): ad1db72c's rewrite of the header produces two new lines of 102 and 104 characters, above the file's `set_option` at line 64, and the build now warns on both, beside the pre-existing warning at line 54. The repair of D-2 in one file introduced the same defect in another. Cosmetic.
- **Gap D-4** ([L160Identity.lean:14](../lean/HamiltonsCubic/Results/L160Identity.lean) to line 16, and line 69): the same placement in the new file, `set_option` at line 20 after the docstring, leaves three long-line warnings in the header, and the `show` at line 69 changes the goal, for which the style linter asks `change`. Cosmetic, neither affects soundness.

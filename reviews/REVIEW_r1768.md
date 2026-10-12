# REVIEW r1768: L1 (L1Statement.lean) and L270 (3) / L264 (3) (L270Simple.lean), commit b892f26e

| Claim | Verdict | Reason |
|---|---|---|
| A. `L1`: at n = 12, 14 every diagonal Weyl operator has `Pcubic W ≤ θ₀(n)‖W‖³` | CONFIRMED WITH OBSERVATIONS | the three bridge lemmas are sound for a nonlinear `W`, the constant is attained in the class at n = 12 (kernel-checked screen), and the class is the coordinate-frame one with the equality clause left untyped |
| B. `L270_H_iff_Us_simple`: at n ≥ 9, H iff the bound on stable PSD idempotents with simple range | CONFIRMED WITH OBSERVATIONS | both directions check at source, the right side is inhabited at every n ≥ 9 (kernel-checked witness), and the proof uses only n ≥ 3 |

Summary: both statements are correct as typed, rest on the standard three axioms, and match the record and lean/INDEX.md, with three observations and no defect.

Standing rule honoured: analysis only. The one compiled check file (below) constructs objects and reads `#print axioms`. No sweep or numerical search was run.

## 1. Is `IsDiagonalOp` the record's "diagonal Weyl tensor"? (Q1)

- The record's definition, [problem.md](../findings/problem.md) line 118: *"For $W$ diagonal on coordinate 2-planes $e_i \wedge e_j$, $Q$ preserves diagonality..."*. `IsDiagonalOp R := ∃ c, ∀ i j, R (phi i j) = c i j • phi i j` is exactly that, in the fixed coordinate frame.
- `IsWeyl ∧ IsDiagonalOp` is the record's class in that frame. `c` is an arbitrary function: `c i i` is unconstrained because `phi i i = 0`, and `wOf` zeroes it. Symmetry `c a b = c b a` for a ≠ b is derived in `wOf_isWeight` from `diag_entry` read at `phi a b`'s `(b,a)` entry, and it does not need to be assumed.
- Sign convention: `phi i j = single j i 1 − single i j 1`, so entry `(i,j)` is −1 and entry `(j,i)` is +1. `diagOp w X = (w_ab X_ab)`, so `diagOp w (phi i j)` has −w_ij at `(i,j)` and +w_ji at `(j,i)`. That equals `w_ij • phi i j` exactly when `w` is symmetric, which is `diagOp_phi`'s hypothesis. `diag_eq` never relies on the sign, because it compares entries at an arbitrary skew `X`.
- **Observation O1 (scope).** The class is narrower than "diagonal in some orthonormal frame" (the reading [diagonal-half.md](../findings/diagonal-half.md) line 557 uses for L176). The two are equivalent through O(n)-invariance of `Pcubic` and `norm`, but L1 does not type that equivalence. [FrameTransfer.lean](../lean/HamiltonsCubic/Results/FrameTransfer.lean) does it for L176 only. The typed class matches problem.md line 118's wording, so this is a scope note and not a defect.

## 2. Does `diag_entry` use only `IsWeyl`'s clauses, soundly for a nonlinear `W`? (Q2)

- Yes. `h1 := inner2_phi (W X) (hW.1 X hX) i j` gives `⟨WX, φᵢⱼ⟩ = −(WX)ᵢⱼ`. This is a fact about the skew matrix `WX`, which clause 1 supplies. It uses no property of `W` as a map.
- `h2 := hW.2.1 X (phi i j) hX (phi_isSkew i j)` gives `⟨WX, φᵢⱼ⟩ = ⟨X, W φᵢⱼ⟩ = ⟨X, cᵢⱼ φᵢⱼ⟩ = cᵢⱼ(−Xᵢⱼ)`. It uses the symmetry clause, the eigen-hypothesis and `inner2_smul_right` (linearity of `inner2`, not of `W`).
- Combining the two gives `(WX)ᵢⱼ = cᵢⱼXᵢⱼ`. The derivation is sound without linearity. Its consequence is that `IsWeyl ∧ IsDiagonalOp` forces `W` to be linear on bivectors. Values of `W` off the skew matrices stay unconstrained, and Q3 shows they are never read.
- `wOf_isWeight.rowSum` uses clause 4, `Ric W a a = 0`, with `inner2 (c•φ_ab) φ_ab = c` (`inner2_self_phi`, a ≠ b) and `phi_self` at b = a. Clause 3 (Bianchi) is unused, which is correct: the diagonal ansatz satisfies it automatically.

## 3. Does `pcubic_congr` cover every evaluation? (Q3)

Every evaluation of `R` inside `Pcubic` and `normSq` has a skew argument. None is at a non-skew argument.

| Site | Arguments of `R` | Skew by |
|---|---|---|
| `normSq`, `innerOp` | `φᵢⱼ` | `phi_isSkew` |
| `trCube = innerOp (compOp R) R` | `φᵢⱼ`, `R φᵢⱼ` | `hR` |
| `sharpQF R η` | `φᵢⱼ`, `br η (R φᵢⱼ)` | `hbr` with `hR`, η skew |
| `sharpBil R X Y` | `sharpQF` at `X+Y`, `X`, `Y` | `hadd` |
| `sharpOp R X` | `sharpBil R X φᵢⱼ` | X skew |
| `sharpPair = innerOp R (sharpOp R)` | `R φᵢⱼ`, `sharpOp R φᵢⱼ` | `phi_isSkew` |

- `sharpOp R X` is itself not required to be skew, and it is never fed back into `R`.
- The rewrite order is sound with `hR` stated for `R` alone: `R (R φ)` becomes `S (R φ)` by `h` at the skew `R φ`, then `S (S φ)` by `h` at `φ`, and likewise inside `sharpQF`.

## 4. Does `L1` state what the record's L1 states? (Q4)

- Constant: `theta0 n = √(2(n−1)(n−2))/n`, which is the record's Θₙ at even n. `theta0_values` pins θ₀(12)² = 55/36 and θ₀(14)² = 78/49.
- Dimensions: `hn : n = 12 ∨ n = 14`, `hcard : Fintype.card ι = n`. Direction: `≤`. Norm: `norm = √(innerOp R R)`, the Λ² operator norm with `inner2 = ½ tr(XᵀY)` and the ordered-pair ½. `Pcubic = trCube + sharpPair`, which is ⟨Q(W), W⟩ by the layer's `Pcubic_eq_inner_Qop`.
- **Screen, kernel-checked: the normalisation is the sharp one.** I built `W = diagOp (t • sphereWeight (firstP 12 6))` with `normSq W = 1` from `sphere_unit` and proved `IsWeyl W ∧ IsDiagonalOp W ∧ W ≠ 0 ∧ Pcubic W = √(2·11·10)/12 · norm W ³` (`diagOp_isWeyl`, `diagOp_phi`, `theta_sphereProduct_value`, `thetaSplitSq_balanced`). So `L1` is attained in its own hypothesis class at S⁶ × S⁶. A layer normalisation that differed from the record's would have shown up here as a loose constant, and none does. This answers the caveat L1Statement.lean's header leaves open ("faithful to the extent that those agree") at the one point where it matters.
- **Observation O2 (omission).** The equality clause (*"with equality exactly at $S^{\lfloor n/2\rfloor}\times S^{\lceil n/2\rceil}$ (up to sign and permutation, uniquely for $n\ge5$)"*) is not stated in L1. The file says so, as do problem.md line 540, [INDEX-results.md](../findings/INDEX-results.md) row 1 and the INDEX row. Its pieces exist at the weight level (`L57_unit_eq`, `L57_attained_even`). Transporting them through `diag_eq` would close the gap in a few lines, and my screen above is the attainment half of that at n = 12.
- **Observation O3 (the proof route).** The record's L1 argument (Jäger's expression, the dual certificate, the interval run, Result 5b) is not what the Lean checks. The Lean proves the statement through L57. [problem.md](../findings/problem.md) line 540 (commit 1056472f) now says so: *"So the route above through Jäger's expression carries nothing L1 needs"*. One sentence above it still reads the other way. Line 530 says *"**Result 5b is unnumbered, unindexed and has never been through Gate 2**, so L1 is conditional on it until it is"*. After line 540, that conditionality belongs to the Jäger route and not to L1. This is a one-clause prose repair for the research loop, and it is outside the Lean layer's remit.

## 5. Is `L270_H_iff_Us_simple` correct, and is its right side non-vacuous? (Q5)

- Forward (`L270_H_of_bound`): at a self-adjoint idempotent, `Ftri C C C = normSq2 C` (`Ftri_idem`). H then reads `q ≤ κₙ q^{3/2}` with q > 0, so `1 ≤ κₙ√q`, that is `q ≥ N/(n−2)²` with κₙ = (n−2)/√N. The step was checked line by line. It needs neither PSD nor stability nor simplicity, so the right side's extra hypotheses only weaken what it asks.
- Backward (`L270_H_of_Us_simple`): take a maximiser (`exists_sa_maximiser`), make it PSD (`L260_psd_cone`), and dispose of F ≤ 0 by κ ≥ 0. Otherwise `C = Y/F(Y)` is an idempotent and stable (`L264_maximiser_stable`), nonzero, PSD, with simple range (`L264_three_simple`), so the hypothesis applies and `maximiser_le_kappa` concludes.
- Fidelity to the record: L270 (3)'s U_s' is *"every stable positive-definite idempotent on a compact simple $\mathfrak h$ has $\lVert C\rVert^2\ge d/c^2$"*, composed with L256's `d/c² ≥ N/(n−2)²`. In the Lean, PSD with range 𝔥 is positive definite on 𝔥 (`L260_range_subalgebra`), and `IsStable` ranges over all self-adjoint H ⊥ C on so(n). That is ambient stability, which is at least as strong as 𝔥-stability. So the Lean hypothesis quantifies over a subset of the C that U_s' ∘ L256 covers. The Lean theorem is therefore at least as strong as the record's L264 (3)/L270 (3) in the direction H needs. The L256 composition stays prose, as INDEX says.
- **Non-vacuity, kernel-checked.** For every `ι` with `9 ≤ card ι`, I proved `∃ C, IsSelfAdjoint2 C ∧ IsPSD2 C ∧ IsIdem C ∧ C ≠ 0 ∧ IsStable C ∧ ∃ hbr, LieAlgebra.IsSimple ℝ (lieOf _ hbr)`, witnessed by `C = X/F(X)` from `L264_one_exists`, `maximiser_pos`, `L264_maximiser_stable` and `L264_three_simple`. A second, explicit candidate is I/(n−2): it is idempotent and PD (`idem_Ic`, `pd_Ic`) and stable (`L265_I_sharp`, per the record). Its range simplicity in Mathlib's sense is not typed, so I did not use it.
- **Observation (hypothesis strength).** `hn : 9 ≤ card ι` is used only through `omega` to reach `3 ≤ card ι` (and `2 ≤` for the maximiser). So the equivalence holds as proved at every n ≥ 3. The 9 is the record's threshold for H, and nothing is lost by it. It is worth a word in the header, since it shows the reduction is dimension-free.

## 6. `#print axioms` (Q6)

```
'HamiltonsCubic.L1Statement.L1' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L270Simple.L270_H_iff_Us_simple' depends on axioms: [propext, Classical.choice, Quot.sound]
```

The standard three axioms, with no `sorryAx` and no `native_decide`. The check file is kept outside the repo, at `/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/02e525cf-c3d5-4040-a8be-a716103a9bb2/scratchpad/r1768_Check.lean`. It compiled with `lake env lean` against the committed oleans, with no errors and no `sorry`.

## 7. lean/INDEX.md rows (Q7)

- **L1 (statement)**, line 560: *"`L1` PROVED ... for every diagonal Weyl operator at n = 12, 14 ... `diag_entry` ... linearity on bivectors is supplied rather than assumed ... The equality clause is not typed."* Every clause matches the code. "Proved" is right for the typed bound. The untyped equality clause is disclosed in the row, and the coordinate-frame scope (O1) is not mentioned.
- **L264**, line 115: *"the reduction to simple subalgebras is `L270_H_of_Us_simple` ... and `L270_H_iff_Us_simple` there makes that hypothesis equivalent to H"*. This matches, and the remainder (L256's comparison folded into the bound) is correctly listed as prose. Status "partial" is right: (2) and (3) still read 𝔥's own # as the ambient one.
- **L270**, line 121: *"`L270_H_of_Us_simple`, statement H at n ≥ 9 from the bound ‖C‖² ≥ N/(n−2)² at the stable positive semidefinite idempotents whose range is a simple subalgebra ... **`L270_H_iff_Us_simple`**, that bound is equivalent to H, since F(C,C,C) = ‖C‖² at every self-adjoint idempotent (`L270_H_of_bound`)"*. This matches the code. `L270_H_of_bound` takes `3 ≤ card ι`, consistent with the row.

## 8. Falsifiers, and what I did to look for them (Q8)

| Statement | Falsifier | Search |
|---|---|---|
| A, as typed | an `IsWeyl ∧ IsDiagonalOp` W at card 12 or 14 with `Pcubic W > θ₀(n)·norm W³` | none can exist: kernel-checked on the standard axioms |
| A, as a reading of the record | an operator the record calls diagonal that is outside `IsDiagonalOp`, or a normalisation making `L1` looser than the record | frame: O1 (equivalent by invariance, untyped). Normalisation: the n = 12 attainment screen shows the bound is tight in-class |
| A, bridge | a nonlinear `W` where `diag_eq` fails, or a non-skew evaluation in `Pcubic` | derivation checked by hand (sections 2 and 3). No such evaluation exists |
| B, forward | a nonzero SA idempotent with `normSq2 C < N/(n−2)²` while H holds | impossible by the algebra of section 5 |
| B, backward | H false at some n ≥ 9 while every stable PSD simple-range idempotent obeys the bound | impossible by the proof. A counterexample to H must be such an idempotent below N/(n−2)², and the record's known idempotents (L263's g₂ pair, L267's, the torus solutions) are all heavier. No numerical search was run, per the standing rule |
| B, vacuity | right side with no inhabitant | refuted by the kernel-checked witness above |

## Overall verdict

**CONFIRMED WITH OBSERVATIONS.** O1: L1's class is the coordinate frame, and the frame transfer is untyped. O2: the equality clause is untyped, although attainment at n = 12 now checks in a few lines. O3: problem.md line 530 still calls L1 conditional on Result 5b, which line 540 supersedes. And `L270_H_iff_Us_simple` needs only n ≥ 3.

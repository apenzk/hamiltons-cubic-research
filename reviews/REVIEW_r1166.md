# REVIEW r1166: the Casimir identity in Lean

Brief: [2026-09-25-casimir-gate2-brief.md](2026-09-25-casimir-gate2-brief.md). File under review: [Casimir.lean](../lean/HamiltonsCubic/Results/Casimir.lean). Analysis-only. The computation here is the Lean build of the named module, the axiom audit, and one scratch Lean file outside the repository (a bridging screen for item 2).

## Summary

| item | verdict |
|---|---|
| 1. statements faithful, no weakening or vacuity; halving gives r1160's `2n\|h\|²` | CONFIRMED |
| 2. `phi` against the layer's `phi` | CONFIRMED as a separate definition, equal propositionally and not definitionally. A bridging lemma is needed for use elsewhere and closes in two lines |
| 3. build and axiom audit | CONFIRMED: build succeeds with 0 errors, and the audit reports 5/5 clean on the standard three |

## Item 1: the statements. CONFIRMED

- **`phi`.** `phi i j a b = [a = j ∧ b = i] − [a = i ∧ b = j]`, which is `E_ji − E_ij`: entry `+1` at `(j,i)` and `−1` at `(i,j)`. This matches the claim.
- **`completeness`.** By hand, `∑_{i,j} (δ_aj δ_bi − δ_ai δ_bj)(δ_cj δ_di − δ_ci δ_dj) = δ_ac δ_bd − δ_ad δ_bc − δ_ad δ_bc + δ_ac δ_bd`, which equals the stated `2(δ_ac δ_bd − δ_ad δ_bc)`. The sum runs over all ordered pairs `(i,j) ∈ Fin n × Fin n`, including the diagonal, where `phi i i = 0`. It holds for every `n` and every `a,b,c,d`, so it is not vacuous.
- **`sum_phi_M_phi`.** Entry `(a,d)` is `∑_{b,c} M_bc ∑_{i,j} φ_ab φ_cd = 2(∑_{b,c} M_bc δ_ac δ_bd − δ_ad ∑_b M_bb) = 2(M_da − δ_ad tr M)`, which is `2(Mᵀ − (tr M) I)`. It holds for arbitrary `M` with no hypothesis.
- **`phi_transpose`.** `(phi i j)ᵀ = −phi i j`, exactly skewness.
- **`casimir`.** The left side is `∑_{i,j} tr(Cᵀ C)` with `C = [φ_ij, h]`, which is the ordered-pair Frobenius mass. The right side is `4n tr(h²) − 4(tr h)²`. The only hypothesis is `hᵀ = h`, and tracelessness is not assumed, so the theorem is stronger than the record needs. By hand, `C` is symmetric, so `tr(CᵀC) = 2 tr(φhφh) − 2 tr(φ²h²)`. Contracting the operator form with `h` gives `∑ tr(φhφh) = 2(tr h² − (tr h)²)`. With `M = I`, `∑ φ² = 2(1 − n)I` gives `∑ tr(φ²h²) = 2(1 − n) tr h²`. Hence `4 tr h² − 4(tr h)² − 4(1 − n) tr h² = 4n tr h² − 4(tr h)²`, which agrees with the declaration.
- **Halving to r1160.** `φ_ii = 0` and `φ_ji = −φ_ij`, so each unordered pair contributes twice to the ordered sum with the same commutator norm. Summing over `i < j` therefore gives `2n tr(h²) − 2(tr h)²`. Under `⟨X,Y⟩ = ½ tr XᵀY` each `φ_ij` has `½ tr(φᵀφ) = ½ · 2 = 1`, and distinct `i < j` have disjoint supports, so `{φ_ij : i < j}` is the orthonormal basis of the record's normalisation. This is the formula of [r1160](REVIEW_r1160.md) item 4, `∑_ψ ‖[ψ,h]‖_F² = 2n|h|² − 2(tr h)²`, with `|h|² = tr(h²)` (Frobenius, consistent with r1160's screen ratio `12 = 2n` at `n = 6`). For traceless `h` it is `2n|h|²`.
- **One gap in the file, a missing corollary.** The `i < j` restriction and the traceless specialisation are stated in the docstring ("half of it over `i < j`") and nowhere typed. A consumer that needs r1160's form in Lean needs a corollary. It follows from `casimir` by the symmetry `phi j i = −phi i j`, which this file does not state (the layer's `phi_swap` does).

## Item 2: the two `phi`. Separate definitions, propositionally equal, bridging lemma needed

- [Casimir.lean](../lean/HamiltonsCubic/Results/Casimir.lean) defines `HamiltonsCubic.Casimir.phi` on `Fin n` as `Matrix.of fun a b => (if a = j ∧ b = i then 1 else 0) − (if a = i ∧ b = j then 1 else 0)`.
- [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) defines `HamiltonsCubic.RealLayer.phi` on a general `Fintype`, `DecidableEq` index `ι` as `Matrix.single j i 1 − Matrix.single i j 1`.
- They coincide entrywise and are the same mathematical object, with matching sign convention. As Lean terms they are two distinct constants. `Matrix.single` tests `j = a ∧ i = b` where `Casimir.phi` tests `a = j ∧ b = i`, so the equality is propositional. **Screen**, in a scratch file outside the repository importing both modules, at `ι = Fin n`: `rfl` fails with "not definitionally equal", and the following closes:

```lean
example {n : ℕ} (i j : Fin n) :
    HamiltonsCubic.Casimir.phi i j = HamiltonsCubic.RealLayer.phi i j := by
  ext a b
  simp [HamiltonsCubic.Casimir.phi, HamiltonsCubic.RealLayer.phi, Matrix.single_apply, eq_comm]
```

- **Consequence.** No theorem stated with `RealLayer.phi`, `inner2` or `br` can use `casimir` until this lemma is in the layer. The file's `phi` is also specialised to `Fin n` where the layer is generic in `ι`. The cheaper repair is to restate `casimir` over the layer's `phi` (generic `ι`, via the lemma above) rather than keep a second primitive. Nothing in the layer uses `Casimir.phi` today (the other hits for "Casimir" in `lean/HamiltonsCubic/Results/` are unrelated Casimir operators in L58, L166 and others).

## Item 3: build and axiom audit. CONFIRMED

- `lake build HamiltonsCubic.Results.Casimir` ran from `lean/` after a concurrent full build finished. The result was "Build completed successfully (8707 jobs)", with 0 errors.
- Warnings on the file are cosmetic: unused simp arguments at lines 29, 31, 55, 58, 74, 84 and 90, and one line over 100 characters at line 37.
- `python3 scripts/misc/axiom_audit.py --only Casimir` reported "auditing 5 declarations across 1 files, 5/5 clean -- resting on the standard three alone". There is no `sorry` and no `native_decide`.

## Corrections

- None to the statements. Recommended follow-ups: (a) a bridging lemma `Casimir.phi = RealLayer.phi` at `ι = Fin n`, or restate over the layer's `phi`; (b) a typed corollary for `i < j` and traceless `h` giving `2n tr(h²)`, so r1160's form is checked rather than read off a docstring.

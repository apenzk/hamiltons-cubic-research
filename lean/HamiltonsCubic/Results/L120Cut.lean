import HamiltonsCubic.Results.L120
import HamiltonsCubic.Results.L120Direct
import HamiltonsCubic.Results.L24Eigen

set_option linter.style.longLine false

/-!
# L120's cut by `⟨M⟩`, and the block size from the summand dimensions

[findings/second-order.md](../../../findings/second-order.md), Lemma L120: *"`e = M/θ` lies in `𝒟ₙ` and `L_e e = e`,
so read without it the criterion gives `λ_max(L_e|_{𝒟ₙ}) ≥ 1 > ½` and no diagonal critical point is a maximiser"*,
and *"the largest block a non-diagonal direction occupies has size `max(2, n − 3)`"*. On `Fin n`:

* **`diag_e_eigen`**: at a unit critical diagonal Weyl operator `M = diagOp w` with `P(M) ≠ 0`, `L_e e = e` for
  `e = M/θ`, the eigenvalue `1` that the uncut criterion meets, by [L24Eigen.lean](L24Eigen.lean)'s `Le_self`;
* **`diag_in_trivial`**: the diagonal operator of a weight is fixed by every coordinate flip, so it lies in the
  trivial summand `𝒟ₙ` ([L120Diag.lean](L120Diag.lean)'s `diagS_flip`);
* **`blockSize_eq`**: at `n ≥ 4`, [L120.lean](L120.lean)'s `blockSize n = max 2 (n − 3)` is the larger of the proved
  four-set dimension `2` and pair dimension `n − 3`;
* **`innerOp_diagS_eq_zero`**, **`pair_perp_diag`**, **`four_perp_diag`**: the pair and four-set summands are orthogonal
  to every diagonal operator, `M` included, so `W^⊥` cuts `𝒟ₙ` and nothing else, the record's reason the cut touches
  only the trivial summand;
* **`restrict_diag_eq`**, **`innerOp2_diag_restrict`**, **`pair_mem_weylPerp`**, **`four_mem_weylPerp`**: the bridge
  between `restrict (diagOp w)` on `CurvOp2` and `diagS w` on `CurvLin`, and the two summands as members of
  [L24Restrict.lean](L24Restrict.lean)'s `weylPerp M`, the tangent space `W^⊥` of the Hessian.
-/

namespace HamiltonsCubic.Results

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L121Block HamiltonsCubic.TensorBridge

variable {n : ℕ}

/-- **`L_e e = e` at a unit critical diagonal Weyl operator**: the eigenvalue `1 > ½` inside `𝒟ₙ`, which is why the
criterion must cut `𝒟ₙ` by `⟨M⟩`. -/
theorem diag_e_eigen {w : Matrix (Fin n) (Fin n) ℝ} (hwt : IsWeight w) {lam : ℝ}
    (ha : normSq2 (restrict (diagOp_isWeyl hwt)) = 1)
    (hcrit : Qop2 (restrict (diagOp_isWeyl hwt)) = lam • restrict (diagOp_isWeyl hwt))
    (hθ : Pcubic2 (restrict (diagOp_isWeyl hwt)) ≠ 0) :
    foxProd2 ((Pcubic2 (restrict (diagOp_isWeyl hwt)))⁻¹ • restrict (diagOp_isWeyl hwt))
      (restrict (diagOp_isWeyl hwt)) = restrict (diagOp_isWeyl hwt) :=
  Le_self ha hcrit hθ

/-- **The diagonal operator lies in `𝒟ₙ`**: it is fixed by every coordinate flip. -/
theorem diag_in_trivial {w : Matrix (Fin n) (Fin n) ℝ} (hwt : IsWeight w) (m : Fin n) :
    act (flip m) (diagS w) = diagS w :=
  diagS_flip hwt m

/-- **The block size is the larger summand dimension**: at `n ≥ 4`, distinct `i, j, k, l` and `j' ≠ k'`,
`max 2 (n − 3)` is the larger of the four-set summand's dimension and the pair summand's. -/
theorem blockSize_eq (hn : 4 ≤ n) {i j k l : Fin n} (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k)
    (hjl : j ≠ l) (hkl : k ≠ l) {j' k' : Fin n} (hjk' : j' ≠ k') :
    HamiltonsCubic.SignCharacters.blockSize n
      = max (Module.finrank ℝ (LinearMap.range (fourMap i j k l)))
          (Module.finrank ℝ ((LinearMap.ker (blockSums1 (univ.filter (fun x => j' ≠ x ∧ k' ≠ x)))).map
            (pairMap j' k'))) := by
  rw [fourSummand_finrank hij hik hil hjk hjl hkl, pairSummand_finrank hjk' (by omega)]
  rfl

/-- **An operator with no diagonal coordinates is orthogonal to every diagonal operator**: `⟨diagOp w, B⟩ = 0` when
`B_{abab} = 0` for all `a, b`. -/
theorem innerOp_diagS_eq_zero {w : Matrix (Fin n) (Fin n) ℝ} (hs : ∀ a b, w a b = w b a) (B : CurvLin (Fin n))
    (hB : ∀ a b, coord B a b a b = 0) : innerOp (fun Z => diagS w Z) (fun Z => B Z) = 0 := by
  unfold innerOp
  rw [mul_eq_zero]; right
  refine Finset.sum_eq_zero fun a _ => Finset.sum_eq_zero fun b _ => ?_
  change inner2 (diagS w (phi a b)) (B (phi a b)) = 0
  rw [diagS_phi hs, inner2_smul_left'', inner2_comm]
  change w a b * coord B a b a b = 0
  rw [hB a b, mul_zero]

/-- **The pair summand is orthogonal to every diagonal operator**, `M` included: a `{j, k}`-isotypic Weyl `B` has no
diagonal coordinates, `(a, b, a, b)` never being a `PairForm` position. -/
theorem pair_perp_diag {w : Matrix (Fin n) (Fin n) ℝ} (hs : ∀ a b, w a b = w b a) (B : CurvLin (Fin n))
    (hB : B ∈ weylModuleS (Fin n)) {j k : Fin n} (hjk : j ≠ k) (hiso : ∀ m, act (flip m) B = (sgn m j * sgn m k) • B) :
    innerOp (fun Z => diagS w Z) (fun Z => B Z) = 0 :=
  innerOp_diagS_eq_zero hs B fun a b => by
    by_contra hne
    exact (pairForm_shape hjk (iso_coord_form B hB hjk hiso hne)).1 (Or.inl ⟨rfl, rfl⟩)

/-- **The four-set summand is orthogonal to every diagonal operator**: `(a, b, a, b)` is never four-distinct. -/
theorem four_perp_diag {w : Matrix (Fin n) (Fin n) ℝ} (hs : ∀ a b, w a b = w b a) (B : CurvLin (Fin n))
    {i j k l : Fin n} (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l) (hkl : k ≠ l)
    (hiso : ∀ m, act (flip m) B = (sgn m i * sgn m j * sgn m k * sgn m l) • B) :
    innerOp (fun Z => diagS w Z) (fun Z => B Z) = 0 :=
  innerOp_diagS_eq_zero hs B fun a b => by
    by_contra hne
    obtain ⟨_, hac, _, _, _, _⟩ := fourForm_shape ⟨hij, hik, hil, hjk, hjl, hkl⟩
      (four_coord_form B hij hik hil hjk hjl hkl hiso hne)
    exact hac rfl

/-- **The two readings of `M` agree on bivectors**: `restrict (diagOp w)` on `CurvOp2` and `diagS w` on `CurvLin`. -/
theorem restrict_diag_eq {w : Matrix (Fin n) (Fin n) ℝ} (hwt : IsWeight w) (X : skewSub (Fin n)) :
    ((restrict (diagOp_isWeyl hwt) X : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ) = diagS w (X : Matrix (Fin n) (Fin n) ℝ) := by
  rw [restrict_apply]
  change diagOp w (X : Matrix (Fin n) (Fin n) ℝ)
    = diagOp w (HamiltonsCubic.WeylModuleSNonzero.skewProj (Fin n) (X : Matrix (Fin n) (Fin n) ℝ))
  rw [HamiltonsCubic.WeylModuleSNonzero.skewProj_skew _ X.2]

/-- `⟨M, B⟩` on `CurvOp2` is the bare pairing of `diagS w` with `B`. -/
theorem innerOp2_diag_restrict {w : Matrix (Fin n) (Fin n) ℝ} (hwt : IsWeight w) (B : CurvLin (Fin n))
    (hB : IsWeyl (fun X => B X)) :
    innerOp2 (restrict (diagOp_isWeyl hwt)) (restrict hB) = innerOp (fun Z => diagS w Z) (fun Z => B Z) := by
  change innerOp (diagOp w) (fun X => B X) = _
  unfold innerOp
  refine congrArg _ (Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => ?_)
  change inner2 (diagOp w (phi a b)) (B (phi a b))
    = inner2 (diagOp w (HamiltonsCubic.WeylModuleSNonzero.skewProj (Fin n) (phi a b))) (B (phi a b))
  rw [HamiltonsCubic.WeylModuleSNonzero.skewProj_skew _ (phi_isSkew a b)]

/-- **The pair summand lies in `W^⊥`**: a `{j, k}`-isotypic Weyl `B`, carried to `CurvOp2`, is in `weylPerp M` at
every diagonal Weyl `M = diagOp w`. -/
theorem pair_mem_weylPerp {w : Matrix (Fin n) (Fin n) ℝ} (hwt : IsWeight w) (B : CurvLin (Fin n))
    (hB : B ∈ weylModuleS (Fin n)) {j k : Fin n} (hjk : j ≠ k) (hiso : ∀ m, act (flip m) B = (sgn m j * sgn m k) • B) :
    restrict (hB.1 : IsWeyl (fun X => B X)) ∈ weylPerp (restrict (diagOp_isWeyl hwt)) :=
  ⟨isWeyl2_restrict (hB.1 : IsWeyl (fun X => B X)), by rw [innerOp2_diag_restrict hwt B (hB.1 : IsWeyl (fun X => B X)), pair_perp_diag hwt.symm B hB hjk hiso]⟩

/-- **The four-set summand lies in `W^⊥`**. -/
theorem four_mem_weylPerp {w : Matrix (Fin n) (Fin n) ℝ} (hwt : IsWeight w) (B : CurvLin (Fin n))
    (hB : B ∈ weylModuleS (Fin n)) {i j k l : Fin n} (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k)
    (hjl : j ≠ l) (hkl : k ≠ l) (hiso : ∀ m, act (flip m) B = (sgn m i * sgn m j * sgn m k * sgn m l) • B) :
    restrict (hB.1 : IsWeyl (fun X => B X)) ∈ weylPerp (restrict (diagOp_isWeyl hwt)) :=
  ⟨isWeyl2_restrict (hB.1 : IsWeyl (fun X => B X)), by
    rw [innerOp2_diag_restrict hwt B (hB.1 : IsWeyl (fun X => B X)), four_perp_diag hwt.symm B hij hik hil hjk hjl hkl hiso]⟩

end HamiltonsCubic.Results

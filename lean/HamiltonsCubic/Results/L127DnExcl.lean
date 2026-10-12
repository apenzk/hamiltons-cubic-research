import HamiltonsCubic.Results.L127DnSpan

set_option linter.style.longLine false

/-!
# L127's `𝒟ₙ` row admits no other eigenvalue

[findings/second-order.md](../../../findings/second-order.md), Lemma L127's table, `𝒟ₙ` row:
`σ(L_e|_{𝒟ₙ}) = {1, λ_p^{p−1}, λ_q^{q−1}, (−μ)^{(p−1)(q−1)}, 0^{rest}}`. [L127DnSpan.lean](L127DnSpan.lean)'s `dn_spectrum`
writes every weight as a sum of eigenvectors carrying these values. This file draws the consequence the row states,
through the independence of eigenspaces (Mathlib's `Module.End.eigenspaces_iSupIndep`):

* **`KL`**: the weight map `u ↦ K u` off the diagonal, as a linear endomorphism of matrices;
* **`K_of_fox`**: an eigen-relation of `M ∘ diagOp u` on the `φ_{ac}` gives `K u = ν u` at `a ≠ c`;
* **`mem_eigenspace_KL`**: a hollow weight with `K u = ν u` off the diagonal lies in `KL`'s `ν`-eigenspace;
* **`dn_excl`**: at the sphere product, `p, q ≥ 2`, every nonzero weight `u` with `K u = ν u` off the diagonal, which
  is `M ∘ diagOp u = ν diagOp u` on bivectors by `foxProd_diag`, has `ν` among `θ` times `1`, `λ_p`, `λ_q`, `−μ`, `0`.
* **`dn_excl_fox`**: the same with the hypothesis in the record's operator form, through `K_of_fox`.

[L127DnEig.lean](L127DnEig.lean) and [L127DnLam.lean](L127DnLam.lean) give the eigenspaces and their dimensions at `t ≠ 0`.
-/

namespace HamiltonsCubic.Results

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.WeylRadical HamiltonsCubic.L126Assembly

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- The weight map off the diagonal, as a linear endomorphism. -/
noncomputable def KL (w : Matrix ι ι ℝ) : Module.End ℝ (Matrix ι ι ℝ) where
  toFun u := Matrix.of fun a b => if a = b then 0 else Kmat w u a b
  map_add' u v := by
    ext a b
    simp only [Matrix.of_apply, Matrix.add_apply, Kmat, Matrix.mul_add, Matrix.add_mul]
    split_ifs <;> ring
  map_smul' c u := by
    ext a b
    simp only [Matrix.of_apply, Matrix.smul_apply, smul_eq_mul, Kmat, Matrix.mul_smul, Matrix.smul_mul,
      RingHom.id_apply]
    split_ifs <;> ring

omit [Fintype ι] in
theorem smul_phi_inj {a c : ι} (hac : a ≠ c) {r s : ℝ} (h : r • phi a c = s • phi a c) : r = s := by
  have := congrFun (congrFun h c) a
  simpa [phi, Matrix.sub_apply, Matrix.single_apply, hac, Ne.symm hac] using this

/-- **From `M ∘` back to `K`**: an eigen-relation on `φ_{ac}` is `K u = ν u` at `a ≠ c`. -/
theorem K_of_fox (w u : Matrix ι ι ℝ) (hw : ∀ p q, w p q = w q p) (hu : ∀ p q, u p q = u q p)
    (hhw : ∀ a, w a a = 0) (hhu : ∀ a, u a a = 0) (ν : ℝ)
    (h : ∀ a b, foxProd (diagOp w) (diagOp u) (phi a b) = ν • diagOp u (phi a b)) {a c : ι} (hac : a ≠ c) :
    Kmat w u a c = ν * u a c := by
  have e := h a c
  rw [foxProd_diag w u hw hu hhw hhu a c, diagOp_phi u hu, smul_smul] at e
  exact smul_phi_inj hac e

omit [Fintype ι] in
theorem mem_eigenspace_KL [Fintype ι] (w u : Matrix ι ι ℝ) (hhu : ∀ a, u a a = 0) (ν : ℝ)
    (h : ∀ a c, a ≠ c → Kmat w u a c = ν * u a c) : u ∈ (KL w).eigenspace ν := by
  rw [Module.End.mem_eigenspace_iff]
  ext a b
  change (if a = b then 0 else Kmat w u a b) = ν * u a b
  split_ifs with hab
  · rw [hab, hhu, mul_zero]
  · exact h a b hab

/-- **The `𝒟ₙ` row admits no other eigenvalue**: at a sphere product with `p, q ≥ 2`, a nonzero weight `u` with
`K u = ν u` off the diagonal has `ν = θ · 1`, `θ λ_p`, `θ λ_q`, `θ(−μ)` or `0`, `θ = t(p + q − 1)`. -/
theorem dn_excl (T : Finset ι) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) {u : Matrix ι ι ℝ} (hu : IsWeight u)
    (hu0 : u ≠ 0) {ν : ℝ} (hK : ∀ a c, a ≠ c → Kmat (t • sphereWeight T) u a c = ν * u a c) :
    ν ∈ ({t * ((T.card : ℝ) + Tᶜ.card - 1) * 1,
      t * ((T.card : ℝ) + Tᶜ.card - 1) * (((T.card : ℝ) - 2) / (2 * ((T.card : ℝ) - 1))),
      t * ((T.card : ℝ) + Tᶜ.card - 1) * (((Tᶜ.card : ℝ) - 2) / (2 * ((Tᶜ.card : ℝ) - 1))),
      t * ((T.card : ℝ) + Tᶜ.card - 1) * (-(((T.card : ℝ) + Tᶜ.card - 2)
        / (2 * ((T.card : ℝ) - 1) * ((Tᶜ.card : ℝ) - 1)))), 0} : Set ℝ) := by
  by_contra hν
  have hc := sphere_diagCrit T (by omega) (by omega) t
  obtain ⟨c, h, h', X, Z, Z', hh, hh', hX, hZ, hZ', he⟩ := dn_decomp2 T hu hp hq
  set S : Set ℝ := {t * ((T.card : ℝ) + Tᶜ.card - 1) * 1, t * ((T.card : ℝ) + Tᶜ.card - 1) * (((T.card : ℝ) - 2) / (2 * ((T.card : ℝ) - 1))),
      t * ((T.card : ℝ) + Tᶜ.card - 1) * (((Tᶜ.card : ℝ) - 2) / (2 * ((Tᶜ.card : ℝ) - 1))),
      t * ((T.card : ℝ) + Tᶜ.card - 1) * (-(((T.card : ℝ) + Tᶜ.card - 2) / (2 * ((T.card : ℝ) - 1) * ((Tᶜ.card : ℝ) - 1)))), 0} with hS
  have piece : ∀ (v : Matrix ι ι ℝ) (μ : ℝ), μ ∈ S → (∀ p q, v p q = v q p) → (∀ a, v a a = 0) →
      (∀ a b, foxProd (diagOp (t • sphereWeight T)) (diagOp v) (phi a b) = μ • diagOp v (phi a b)) →
      v ∈ ⨆ i ∈ S, (KL (t • sphereWeight T)).eigenspace i := fun v μ hμ hs hv hf =>
    le_biSup (fun i => (KL (t • sphereWeight T)).eigenspace i) hμ
      (mem_eigenspace_KL _ v hv μ fun a c hac => K_of_fox _ v hc.1 hs hc.2.1 hv μ hf hac)
  have hK' : dnK Tᶜ = -((Tᶜ.card : ℝ) - 2) / T.card := by unfold dnK; rw [compl_compl]
  have hmem : u ∈ ⨆ i ∈ S, (KL (t • sphereWeight T)).eigenspace i := by
    rw [he]
    refine add_mem (add_mem (add_mem (add_mem (add_mem ?_ ?_) ?_) ?_) ?_) ?_
    · exact piece _ _ (Set.mem_insert _ _) (fun p q => by simp [sphereWeight_symm T p q])
        (fun a => by simp [sphereWeight_hollow]) (sphere_line T (by omega) (by omega) t c)
    · exact piece _ _ (Set.mem_insert_of_mem _ (Set.mem_insert _ _)) (lamW_symm T _ h) (fun a => by simp [lamW])
        (sphere_lam T (by omega) (by omega) t h hh)
    · refine piece _ _ (Set.mem_insert_of_mem _ (Set.mem_insert_of_mem _ (Set.mem_insert _ _))) (lamW_symm Tᶜ _ h') (fun a => by simp [lamW]) ?_
      rw [hK']; exact sphere_lam_compl T (by omega) (by omega) t h' hh'
    · exact piece _ _ (Set.mem_insert_of_mem _ (Set.mem_insert_of_mem _ (Set.mem_insert_of_mem _ (Set.mem_insert _ _)))) hX.1 (fun a => hX.2.1 a a Iff.rfl) (sphere_crossW T (by omega) (by omega) t hX)
    · exact piece _ _ (Set.mem_insert_of_mem _ (Set.mem_insert_of_mem _ (Set.mem_insert_of_mem _ (Set.mem_insert_of_mem _ rfl)))) hZ.1 hZ.2.1
        (sphere_zero T (by omega) (by omega) t Z hZ.1 hZ.2.1 hZ.2.2.1 hZ.2.2.2)
    · exact piece _ _ (Set.mem_insert_of_mem _ (Set.mem_insert_of_mem _ (Set.mem_insert_of_mem _ (Set.mem_insert_of_mem _ rfl)))) hZ'.1 hZ'.2.1
        (sphere_zero_compl T (by omega) (by omega) t Z' hZ'.1 hZ'.2.1 hZ'.2.2.1 hZ'.2.2.2)
  have hν' : u ∈ (KL (t • sphereWeight T)).eigenspace ν := mem_eigenspace_KL _ u hu.hollow ν hK
  exact hu0 (Submodule.disjoint_def.mp
    ((Module.End.eigenspaces_iSupIndep (KL (t • sphereWeight T))).disjoint_biSup hν) u hν' hmem)

/-- **The same in the record's operator form**: a nonzero weight `u` with `M ∘ diagOp u = ν diagOp u` on every
`φ_{ab}` has `ν` among `θ` times `1`, `λ_p`, `λ_q`, `−μ`, `0`. -/
theorem dn_excl_fox (T : Finset ι) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) {u : Matrix ι ι ℝ} (hu : IsWeight u)
    (hu0 : u ≠ 0) {ν : ℝ}
    (hf : ∀ a b, foxProd (diagOp (t • sphereWeight T)) (diagOp u) (phi a b) = ν • diagOp u (phi a b)) :
    ν ∈ ({t * ((T.card : ℝ) + Tᶜ.card - 1) * 1,
      t * ((T.card : ℝ) + Tᶜ.card - 1) * (((T.card : ℝ) - 2) / (2 * ((T.card : ℝ) - 1))),
      t * ((T.card : ℝ) + Tᶜ.card - 1) * (((Tᶜ.card : ℝ) - 2) / (2 * ((Tᶜ.card : ℝ) - 1))),
      t * ((T.card : ℝ) + Tᶜ.card - 1) * (-(((T.card : ℝ) + Tᶜ.card - 2)
        / (2 * ((T.card : ℝ) - 1) * ((Tᶜ.card : ℝ) - 1)))), 0} : Set ℝ) := by
  have hc := sphere_diagCrit T (by omega) (by omega) t
  exact dn_excl T hp hq t hu hu0 fun a c hac => K_of_fox _ u hc.1 hu.symm hc.2.1 hu.hollow ν hf hac

end HamiltonsCubic.Results

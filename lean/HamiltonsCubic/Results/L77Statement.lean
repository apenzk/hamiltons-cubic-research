import Mathlib
import HamiltonsCubic.Results.FrameExtension
import HamiltonsCubic.Results.L41Statement

set_option linter.style.longLine false

/-!
# L77, under isotropy, `γ = 2 S_𝔪𝔥𝔥`, so `γ = 0` iff `𝔪^⊥` is a subalgebra, STATED

[isotropy-cap.md](../../../findings/isotropy-cap.md)'s Lemma L77, quoted verbatim:

> The Killing marginal gives `μ + X = 2(n-2)d` with `X` the `𝔪`-to-`𝔪^⊥` bracket mass, so
> `γ = X - μ`; counting triples by type gives `μ = 2S_𝔪𝔪𝔥` and `X = 2S_𝔪𝔪𝔥 + 2S_𝔪𝔥𝔥`, whence
>
> `γ = 2S_𝔪𝔥𝔥`, so `γ = 0 ⟺ [𝔥,𝔥] ⊆ 𝔥 ⟺ 𝔪^⊥ is a subalgebra`.

with the audit's two findings, both of which shape what is typed here:

> **ISOTROPY IS A HYPOTHESIS, NOT A SETTING, AND WITHOUT IT BOTH HALVES FAIL.** In general the
> identity carries a second term in `S_𝔪𝔪𝔪`, which isotropy kills. **Two independent hand
> witnesses, in three and four dimensions.** At `n = 3` with `𝔪 = 𝔰𝔬(3)`, `𝔥 = {0}` **is** a
> subalgebra while `γ = -6`. At `n = 4` with `𝔪 = 𝔰𝔬(3)`, `d = 3`: `μ = 6` and `γ = 0`, yet
> `S_𝔪𝔥𝔥 = 3` and `𝔪^⊥ = span(φ₁₄, φ₂₄, φ₃₄)` **is not a subalgebra**.
>
> **THE LOAD-BEARING ARROW HOLDS, AND THE BLOCK NEVER SAYS WHY.** The brief's suspicion, a
> `ℤ₂`-grading needs *three* bracket relations while only two masses are killed, **resolves in
> the block's favour**: by total antisymmetry of `c`, `[𝔥,𝔪] ⊆ 𝔪` is *the same* structure
> constants as `[𝔥,𝔥] ⊆ 𝔥`. **Two conditions, both directions, "exactly" earned.**

## What IS typed here

**The step the audit says the block never argues, proved.** `grading_conditions_agree` is the
identification of `[𝔥,𝔥] ⊆ 𝔥` with `[𝔥,𝔪] ⊆ 𝔪` by total antisymmetry of the Cartan three-form,
which is what earns the word *"exactly"* in the record's iff-chain. Total antisymmetry itself is
derived here from the trace form (`ad_skew_adjoint`, `three_form_antisymm`), not assumed.

**The `n = 4` witness, proved.** `witness_not_subalgebra` computes `[φ₀₃, φ₁₃] = -φ₀₁`, which
lands in `𝔪 = 𝔰𝔬(3)` and so exhibits `𝔪^⊥` failing to be a subalgebra, the object the record
names as the hand witness that isotropy is a hypothesis rather than a setting.

**`L77`, the load-bearing arrow, PROVED:** under isotropy, `γ = 0 ⟺ 𝔪^⊥ is a subalgebra`, with
`γ = 2(n-2)d - 2μ` and `μ = ∑_{a,b} ‖[e_a,e_b]‖²` spelled out. *[FrameExtension.lean](FrameExtension.lean)
completes `e` to a frame `e ∪ g` with `g` spanning `𝔥`, [L41Statement.lean](L41Statement.lean)'s
Killing row `∑ c_{xab}² = 2(n-2)` holds on it, and isotropy kills the `𝔪𝔪𝔪` constants, so
`γ = ∑_{a,c,c'} ⟨[e_a,g_c],g_{c'}⟩²`: zero exactly when `[𝔥,𝔥] ⊥ 𝔪`.* The proof runs in
`HamiltonsCubic.L77Proof`, in the base layer's vocabulary, since this file's `inner2`, `br` and
`Skew` are [WeylReal.lean](../Base/WeylReal.lean)'s character for character.

## What is NOT typed here

**The factor in `γ = 2 S_𝔪𝔥𝔥`, and `S_𝔪𝔥𝔥` itself.** The audit records the normalisation as
**live and unresolved**: r609 derives `γ = S_𝔪𝔥𝔥` counting *ordered* slots, r610 derives
`γ = 2S_𝔪𝔥𝔥` counting *unordered* triples, *"each rule is right in its own reading and false in
the other's"*, and *"fixing `S_XYZ` in conventions.md is what closes this, and it is owed."*
Typing either factor would settle on the record's behalf a convention the record has not fixed,
so the numerical identity is absent and only the vanishing criterion, which is invariant under
the choice, is stated.

**The Killing marginal and the triple count.** `μ + X = 2(n-2)d`, `μ = 2S_𝔪𝔪𝔥` and
`X = 2S_𝔪𝔪𝔥 + 2S_𝔪𝔥𝔥` are [L153](../../../findings/bounds.md)'s row marginal and a
counting-by-type argument; neither is typed.

**The odd-`n` debt.** *"What is owed for odd `n` is that the cap forces `S_𝔪𝔥𝔥 = 0` there too"*,
an extremal question about `P₀`'s isotypic profile, and no part of this file.
-/

namespace HamiltonsCubic.L77Statement

open Matrix

variable {n : ℕ}

/-- The `Λ²` inner product `⟨X, Y⟩ = ½ tr(Xᵀ Y)`. -/
noncomputable def inner2 (X Y : Matrix (Fin n) (Fin n) ℝ) : ℝ := (1 / 2) * (Xᵀ * Y).trace

/-- The bracket on `𝔰𝔬(n)`. -/
def br (X Y : Matrix (Fin n) (Fin n) ℝ) : Matrix (Fin n) (Fin n) ℝ := X * Y - Y * X

/-- Membership in `𝔰𝔬(n)`. -/
def Skew (X : Matrix (Fin n) (Fin n) ℝ) : Prop := Xᵀ = -X

/-! ## The pairing and the Cartan three-form -/

theorem inner2_comm (X Y : Matrix (Fin n) (Fin n) ℝ) : inner2 X Y = inner2 Y X := by
  unfold inner2
  rw [← Matrix.trace_transpose (Xᵀ * Y), Matrix.transpose_mul, Matrix.transpose_transpose]

theorem br_transpose {v a : Matrix (Fin n) (Fin n) ℝ} (hv : Skew v) (ha : Skew a) :
    (br v a)ᵀ = br a v := by
  unfold Skew br at *
  simp only [Matrix.transpose_sub, Matrix.transpose_mul, hv, ha]
  noncomm_ring

/-- **`ad(v)` is skew-adjoint for the trace form**, `⟨[v,a],b⟩ = −⟨a,[v,b]⟩`, from cyclicity of
the trace alone. -/
theorem ad_skew_adjoint {v a b : Matrix (Fin n) (Fin n) ℝ} (hv : Skew v) (ha : Skew a) :
    inner2 (br v a) b = - inner2 a (br v b) := by
  have hcyc : (v * a * b).trace = (a * b * v).trace := (Matrix.trace_mul_cycle a b v).symm
  unfold inner2
  rw [br_transpose hv ha]
  have haT : aᵀ = -a := ha
  rw [haT]
  unfold br
  simp only [Matrix.sub_mul, Matrix.mul_sub, Matrix.neg_mul, Matrix.trace_sub, Matrix.trace_neg,
    Matrix.mul_assoc]
  have h1 : (a * (v * b)).trace = (a * v * b).trace := by rw [Matrix.mul_assoc]
  have h2 : (v * (a * b)).trace = (v * a * b).trace := by rw [Matrix.mul_assoc]
  have h3 : (a * (b * v)).trace = (a * b * v).trace := by rw [Matrix.mul_assoc]
  rw [h1, h2, h3, hcyc]
  ring

/-- **Total antisymmetry of `c(x,y,z) = ⟨[x,y],z⟩` in its last two slots**, which is the form the
grading argument uses. -/
theorem three_form_antisymm {x y z : Matrix (Fin n) (Fin n) ℝ} (hx : Skew x) (hy : Skew y) :
    inner2 (br x y) z = - inner2 (br x z) y := by
  rw [ad_skew_adjoint hx hy, inner2_comm]

/-! ## The step the record's chain needs and the block never argues

A `ℤ₂`-grading asks for `[𝔥,𝔥] ⊆ 𝔥` *and* `[𝔥,𝔪] ⊆ 𝔪`, while the mass count kills only
`S_𝔪𝔪𝔪` and `S_𝔪𝔥𝔥`. The two conditions are the same structure constants, so nothing is
missing. -/

/-- **`[𝔥,𝔥] ⊆ 𝔥` and `[𝔥,𝔪] ⊆ 𝔪` are one condition.** The hypotheses say only that `𝔪` and `𝔥`
are orthogonal complements of each other inside `𝔰𝔬(n)`, which is how the record introduces them
(`𝔥 = 𝔪^⊥`). -/
theorem grading_conditions_agree
    (m h : Submodule ℝ (Matrix (Fin n) (Fin n) ℝ))
    (hmskew : ∀ A ∈ m, Skew A) (hhskew : ∀ A ∈ h, Skew A)
    (hbr : ∀ x y : Matrix (Fin n) (Fin n) ℝ, Skew x → Skew y → Skew (br x y))
    (hmperp : ∀ A : Matrix (Fin n) (Fin n) ℝ, Skew A → (A ∈ m ↔ ∀ y ∈ h, inner2 A y = 0))
    (hhperp : ∀ A : Matrix (Fin n) (Fin n) ℝ, Skew A → (A ∈ h ↔ ∀ u ∈ m, inner2 A u = 0)) :
    (∀ x ∈ h, ∀ y ∈ h, br x y ∈ h) ↔ (∀ x ∈ h, ∀ u ∈ m, br x u ∈ m) := by
  constructor
  · intro H x hx u hu
    rw [hmperp _ (hbr _ _ (hhskew x hx) (hmskew u hu))]
    intro y hy
    have := three_form_antisymm (z := u) (hhskew x hx) (hhskew y hy)
    have h0 : inner2 (br x y) u = 0 := by
      have := (hhperp _ (hbr _ _ (hhskew x hx) (hhskew y hy))).mp (H x hx y hy) u hu
      exact this
    have h1 : inner2 (br x u) y = - inner2 (br x y) u := by
      rw [three_form_antisymm (z := u) (hhskew x hx) (hhskew y hy)]; ring
    rw [h1, h0, neg_zero]
  · intro H x hx y hy
    rw [hhperp _ (hbr _ _ (hhskew x hx) (hhskew y hy))]
    intro u hu
    have h0 : inner2 (br x u) y = 0 :=
      (hmperp _ (hbr _ _ (hhskew x hx) (hmskew u hu))).mp (H x hx u hu) y hy
    rw [three_form_antisymm (z := u) (hhskew x hx) (hhskew y hy), h0, neg_zero]

/-! ## The `n = 4` witness that isotropy is a hypothesis

With `𝔪 = 𝔰𝔬(3) ⊂ 𝔰𝔬(4)` (which is **not** isotropic), the record records `γ = 0` while
`𝔪^⊥ = span(φ₀₃, φ₁₃, φ₂₃)` is not a subalgebra. The failure is one bracket. -/

/-- `φ₀₃ = E₀₃ - E₃₀`. -/
def phi03 : Matrix (Fin 4) (Fin 4) ℝ := !![0,0,0,1; 0,0,0,0; 0,0,0,0; -1,0,0,0]

/-- `φ₁₃ = E₁₃ - E₃₁`. -/
def phi13 : Matrix (Fin 4) (Fin 4) ℝ := !![0,0,0,0; 0,0,0,1; 0,0,0,0; 0,-1,0,0]

/-- `φ₀₁ = E₀₁ - E₁₀`, which spans a direction of `𝔪 = 𝔰𝔬(3)`. -/
def phi01 : Matrix (Fin 4) (Fin 4) ℝ := !![0,1,0,0; -1,0,0,0; 0,0,0,0; 0,0,0,0]

/-- **`[φ₀₃, φ₁₃] = -φ₀₁`.** The bracket of two members of `𝔪^⊥` lands in `𝔪`, so `𝔪^⊥` is not a
subalgebra, the witness the record gives for `n = 4`. -/
theorem witness_not_subalgebra : br phi03 phi13 = -phi01 := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [br, phi03, phi13, phi01, Matrix.mul_apply, Fin.sum_univ_four]

/-- And `φ₀₁` is orthogonal to both members, so the bracket genuinely leaves their span. -/
theorem witness_orthogonal : inner2 phi01 phi03 = 0 ∧ inner2 phi01 phi13 = 0 := by
  constructor <;>
    simp [inner2, phi01, phi03, phi13, Matrix.trace, Matrix.mul_apply, Fin.sum_univ_four]

/-! ## The masses -/

/-- `μ = ∑_{a,b} ‖[e_a,e_b]‖²` over a basis `e` of `𝔪`. -/
noncomputable def mu {d : ℕ} (e : Fin d → Matrix (Fin n) (Fin n) ℝ) : ℝ :=
  ∑ a, ∑ b, inner2 (br (e a) (e b)) (br (e a) (e b))

/-- `γ = 2(n-2)d - 2μ`, the residual the record's chain bounds. -/
noncomputable def gamma (n : ℕ) {d : ℕ} (e : Fin d → Matrix (Fin n) (Fin n) ℝ) : ℝ :=
  2 * ((n : ℝ) - 2) * (d : ℝ) - 2 * mu e

end HamiltonsCubic.L77Statement

namespace HamiltonsCubic.L77Proof

open Matrix HamiltonsCubic.RealLayer

variable {n : ℕ}

theorem zero_weyl : IsWeyl (fun _ : Matrix (Fin n) (Fin n) ℝ => (0 : Matrix (Fin n) (Fin n) ℝ)) := by
  refine ⟨fun X _ => ?_, fun X Y _ _ => ?_, fun i j k l => ?_, fun a b => ?_⟩
  · unfold IsSkew; simp
  · simp [inner2]
  · simp [bianchi, inner2]
  · simp [Ric, inner2]

theorem br_add_l' (x y z : Matrix (Fin n) (Fin n) ℝ) : br (x + y) z = br x z + br y z := by
  unfold br; rw [Matrix.add_mul, Matrix.mul_add]; abel
theorem br_add_r' (x y z : Matrix (Fin n) (Fin n) ℝ) : br x (y + z) = br x y + br x z := by
  unfold br; rw [Matrix.add_mul, Matrix.mul_add]; abel
theorem br_smul_l' (c : ℝ) (x y : Matrix (Fin n) (Fin n) ℝ) : br (c • x) y = c • br x y := by
  unfold br; rw [Matrix.smul_mul, Matrix.mul_smul, smul_sub]
theorem br_smul_r' (c : ℝ) (x y : Matrix (Fin n) (Fin n) ℝ) : br x (c • y) = c • br x y := by
  unfold br; rw [Matrix.smul_mul, Matrix.mul_smul, smul_sub]
theorem br_zero_l' (y : Matrix (Fin n) (Fin n) ℝ) : br 0 y = 0 := by unfold br; simp
theorem br_zero_r' (y : Matrix (Fin n) (Fin n) ℝ) : br y 0 = 0 := by unfold br; simp

open HamiltonsCubic.L41Statement.Frame in
theorem L77' {d : ℕ} (m h : Submodule ℝ (Matrix (Fin n) (Fin n) ℝ))
    (e : Fin d → Matrix (Fin n) (Fin n) ℝ)
    (hmskew : ∀ A ∈ m, HamiltonsCubic.L77Statement.Skew A)
    (hhskew : ∀ A ∈ h, HamiltonsCubic.L77Statement.Skew A)
    (he : ∀ a, e a ∈ m)
    (heon : ∀ a b, HamiltonsCubic.L77Statement.inner2 (e a) (e b) = if a = b then 1 else 0)
    (hespan : m = Submodule.span ℝ (Set.range e))
    (hmperp : ∀ A : Matrix (Fin n) (Fin n) ℝ, HamiltonsCubic.L77Statement.Skew A →
      (A ∈ m ↔ ∀ y ∈ h, HamiltonsCubic.L77Statement.inner2 A y = 0))
    (hhperp : ∀ A : Matrix (Fin n) (Fin n) ℝ, HamiltonsCubic.L77Statement.Skew A →
      (A ∈ h ↔ ∀ u ∈ m, HamiltonsCubic.L77Statement.inner2 A u = 0))
    (hisotropic : ∀ u ∈ m, ∀ v ∈ m, ∀ w ∈ m,
      HamiltonsCubic.L77Statement.inner2 (HamiltonsCubic.L77Statement.br u v) w = 0) :
    HamiltonsCubic.L77Statement.gamma n e = 0 ↔
      (∀ x ∈ h, ∀ y ∈ h, HamiltonsCubic.L77Statement.br x y ∈ h) := by
  classical
  have heS : ∀ a, IsSkew (e a) := fun a => hmskew _ (he a)
  have heon' : ∀ a b, inner2 (e a) (e b) = if a = b then 1 else 0 := heon
  obtain ⟨r, g, hgs, hgon, heg, hcomp⟩ := HamiltonsCubic.FrameExtension.extend_frame e heS heon'
  let v : Fin d ⊕ Fin r → Matrix (Fin n) (Fin n) ℝ := Sum.elim e g
  have hge : ∀ c a, inner2 (g c) (e a) = 0 := fun c a => by rw [inner2_comm]; exact heg a c
  have hf : HamiltonsCubic.L41Statement.EigenFrame (fun _ => (0 : Matrix (Fin n) (Fin n) ℝ)) v
      (fun _ => 0) := by
    refine ⟨?_, ?_, fun γ => by simp, fun X hX => ?_⟩
    · rintro (a|c); exacts [heS a, hgs c]
    · rintro (a|c) (b|c') <;> simp [v, heon', hgon, heg, hge]
    · rw [Fintype.sum_sum_type]; exact hcomp X hX
  -- isotropy kills the m-m-m constants
  have hiso0 : ∀ a b b', cst v (Sum.inl a) (Sum.inl b) (Sum.inl b') = 0 := fun a b b' =>
    hisotropic _ (he a) _ (he b) _ (he b')
  have hkill : ∀ a, ∑ α, ∑ β, cst v (Sum.inl a) α β ^ 2 = 2 * ((n : ℝ) - 2) := fun a => by
    have := killing_frame zero_weyl hf (Sum.inl a)
    simpa using this
  have hmu_a : ∀ a b, HamiltonsCubic.L77Statement.inner2 (HamiltonsCubic.L77Statement.br (e a) (e b))
      (HamiltonsCubic.L77Statement.br (e a) (e b)) = ∑ c, cst v (Sum.inl a) (Sum.inl b) (Sum.inr c) ^ 2 := by
    intro a b
    have := brnorm_frame hf (Sum.inl a) (Sum.inl b)
    rw [Fintype.sum_sum_type] at this
    simp only [hiso0, ne_eq, OfNat.ofNat_ne_zero, not_false_eq_true, zero_pow, Finset.sum_const_zero,
      zero_add] at this
    exact this
  have hsplit : ∀ a, ∑ α, ∑ β, cst v (Sum.inl a) α β ^ 2
      = 2 * ∑ b, ∑ c, cst v (Sum.inl a) (Sum.inl b) (Sum.inr c) ^ 2
        + ∑ c, ∑ c', cst v (Sum.inl a) (Sum.inr c) (Sum.inr c') ^ 2 := by
    intro a
    simp only [Fintype.sum_sum_type, hiso0, ne_eq, OfNat.ofNat_ne_zero, not_false_eq_true, zero_pow,
      Finset.sum_const_zero, zero_add, Finset.sum_add_distrib]
    have hswap : ∑ c, ∑ b, cst v (Sum.inl a) (Sum.inr c) (Sum.inl b) ^ 2
        = ∑ b, ∑ c, cst v (Sum.inl a) (Sum.inl b) (Sum.inr c) ^ 2 := by
      rw [Finset.sum_comm]
      exact Finset.sum_congr rfl fun b _ => Finset.sum_congr rfl fun c _ => (T23 hf _ _ _).symm
    rw [hswap]; ring
  -- γ is the m-h-h mass
  have hgamma : HamiltonsCubic.L77Statement.gamma n e
      = ∑ a, ∑ c, ∑ c', cst v (Sum.inl a) (Sum.inr c) (Sum.inr c') ^ 2 := by
    unfold HamiltonsCubic.L77Statement.gamma HamiltonsCubic.L77Statement.mu
    simp only [hmu_a]
    have h1 : 2 * ((n : ℝ) - 2) * (d : ℝ) = ∑ a : Fin d, ∑ α, ∑ β, cst v (Sum.inl a) α β ^ 2 := by
      simp only [hkill, Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]; ring
    rw [h1]
    simp only [hsplit, Finset.sum_add_distrib, ← Finset.mul_sum]
    ring
  -- h is spanned by the completing family
  have hgh : ∀ c, g c ∈ h := fun c => (hhperp _ (hgs c)).mpr fun u hu => by
    rw [hespan] at hu
    induction hu using Submodule.span_induction with
    | mem x hx => obtain ⟨a, rfl⟩ := hx; exact hge c a
    | zero => simp [HamiltonsCubic.L77Statement.inner2]
    | add x y _ _ hx hy =>
      show inner2 (g c) (x + y) = 0
      rw [inner2_add_right, show inner2 (g c) x = 0 from hx, show inner2 (g c) y = 0 from hy, add_zero]
    | smul t x _ hx =>
      show inner2 (g c) (t • x) = 0
      rw [inner2_smul_r, show inner2 (g c) x = 0 from hx, mul_zero]
  have hT_iff : (∑ a, ∑ c, ∑ c', cst v (Sum.inl a) (Sum.inr c) (Sum.inr c') ^ 2 = 0) ↔
      ∀ a c c', cst v (Sum.inl a) (Sum.inr c) (Sum.inr c') = 0 := by
    constructor
    · intro h0 a c c'
      have h1 := (Finset.sum_eq_zero_iff_of_nonneg (fun a _ => Finset.sum_nonneg fun c _ =>
        Finset.sum_nonneg fun c' _ => sq_nonneg _)).mp h0 a (Finset.mem_univ a)
      have h2 := (Finset.sum_eq_zero_iff_of_nonneg (fun c _ => Finset.sum_nonneg fun c' _ =>
        sq_nonneg _)).mp h1 c (Finset.mem_univ c)
      have h3 := (Finset.sum_eq_zero_iff_of_nonneg (fun c' _ => sq_nonneg _)).mp h2 c'
        (Finset.mem_univ c')
      exact pow_eq_zero_iff (n := 2) (by norm_num) |>.mp h3
    · intro h0; simp [h0]
  have hcyc : ∀ a c c', cst v (Sum.inl a) (Sum.inr c) (Sum.inr c') = inner2 (br (g c) (g c')) (e a) := by
    intro a c c'
    rw [cst_swap12 hf, cst_swap23 hf, neg_neg]
    rfl
  rw [hgamma, hT_iff]
  simp only [hcyc]
  constructor
  · intro hz x hx y hy
    have hxS : IsSkew x := hhskew x hx
    have hyS : IsSkew y := hhskew y hy
    have inG : ∀ z ∈ h, z ∈ Submodule.span ℝ (Set.range g) := by
      intro z hz'
      have hzS : IsSkew z := hhskew z hz'
      have hze : ∀ a, inner2 z (e a) = 0 := fun a => (hhperp z hzS).mp hz' _ (he a)
      have hexp := hcomp z hzS
      simp only [hze, zero_smul, Finset.sum_const_zero, zero_add] at hexp
      rw [hexp]
      exact Submodule.sum_mem _ fun c _ => Submodule.smul_mem _ _ (Submodule.subset_span ⟨c, rfl⟩)
    have key : ∀ x' ∈ Submodule.span ℝ (Set.range g), ∀ y' ∈ Submodule.span ℝ (Set.range g),
        ∀ a, inner2 (br x' y') (e a) = 0 := by
      intro x' hx' y' hy' a
      induction hx' using Submodule.span_induction with
      | mem x₀ hx₀ =>
        obtain ⟨c, rfl⟩ := hx₀
        induction hy' using Submodule.span_induction with
        | mem y₀ hy₀ => obtain ⟨c', rfl⟩ := hy₀; exact hz a c c'
        | zero => rw [br_zero_r']; simp [inner2]
        | add y₁ y₂ _ _ h1 h2 => rw [br_add_r', inner2_add_l, h1, h2, add_zero]
        | smul t y₁ _ h1 => rw [br_smul_r', inner2_smul_l, h1, mul_zero]
      | zero => rw [br_zero_l']; simp [inner2]
      | add x₁ x₂ _ _ h1 h2 => rw [br_add_l', inner2_add_l, h1, h2, add_zero]
      | smul t x₁ _ h1 => rw [br_smul_l', inner2_smul_l, h1, mul_zero]
    refine (hhperp _ (br_skew hxS hyS)).mpr fun u hu => ?_
    rw [hespan] at hu
    induction hu using Submodule.span_induction with
    | mem u₀ hu₀ => obtain ⟨a, rfl⟩ := hu₀; exact key x (inG x hx) y (inG y hy) a
    | zero => simp [HamiltonsCubic.L77Statement.inner2]
    | add u₁ u₂ _ _ h1 h2 =>
      show inner2 (br x y) (u₁ + u₂) = 0
      rw [inner2_add_right]; exact (by rw [show inner2 (br x y) u₁ = 0 from h1,
        show inner2 (br x y) u₂ = 0 from h2, add_zero])
    | smul t u₁ _ h1 =>
      show inner2 (br x y) (t • u₁) = 0
      rw [inner2_smul_r, show inner2 (br x y) u₁ = 0 from h1, mul_zero]
  · intro hsub a c c'
    exact (hhperp _ (br_skew (hgs c) (hgs c'))).mp (hsub _ (hgh c) _ (hgh c')) _ (he a)

end HamiltonsCubic.L77Proof

namespace HamiltonsCubic.L77Statement

/-! ## The statement -/

/-- **L77, the load-bearing arrow.** Let `𝔪 ⊆ 𝔰𝔬(n)` be **isotropic** with orthonormal basis `e`,
and let `𝔥 = 𝔪^⊥` inside `𝔰𝔬(n)`. Then `γ = 0` exactly when `𝔪^⊥` is a subalgebra.

*Isotropy is a hypothesis and not a setting: `witness_not_subalgebra` above is the `n = 4` object
on which the conclusion fails without it.* -/
theorem L77 {d : ℕ} (m h : Submodule ℝ (Matrix (Fin n) (Fin n) ℝ))
    (e : Fin d → Matrix (Fin n) (Fin n) ℝ)
    (hmskew : ∀ A ∈ m, Skew A) (hhskew : ∀ A ∈ h, Skew A)
    (he : ∀ a, e a ∈ m) (heon : ∀ a b, inner2 (e a) (e b) = if a = b then 1 else 0)
    (hespan : m = Submodule.span ℝ (Set.range e))
    (hmperp : ∀ A : Matrix (Fin n) (Fin n) ℝ, Skew A → (A ∈ m ↔ ∀ y ∈ h, inner2 A y = 0))
    (hhperp : ∀ A : Matrix (Fin n) (Fin n) ℝ, Skew A → (A ∈ h ↔ ∀ u ∈ m, inner2 A u = 0))
    (hisotropic : ∀ u ∈ m, ∀ v ∈ m, ∀ w ∈ m, inner2 (br u v) w = 0) :
    gamma n e = 0 ↔ (∀ x ∈ h, ∀ y ∈ h, br x y ∈ h) :=
  HamiltonsCubic.L77Proof.L77' m h e hmskew hhskew he heon hespan hmperp hhperp hisotropic

end HamiltonsCubic.L77Statement

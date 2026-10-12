import HamiltonsCubic.Results.L160

set_option linter.style.longLine false

/-!
# L160's displayed identity

[isotropy-cap.md](../../../findings/isotropy-cap.md), Lemma L160, displays
`𝔷(𝔠) ∩ 𝔠^⊥ = 𝔷_{𝔰𝔬(V)}(𝔠_V) ∩ 𝔠_V^{⊥_V}` for `V = im x`, the reduction of every corank onto the maximal-rank
branch. Inside `𝔰𝔬(m)`, `𝔰𝔬(V)` is the skew matrices killing `K = ker x`, and `𝔠_V = 𝔠 ∩ 𝔰𝔬(V)`.

* **`zPerpV`**: the right side, the skew `y` killing `K` that commute with and are orthogonal to every
  `c ∈ 𝔠` killing `K`;
* **`L160_identity`**: at `m ≠ 3`, `y ∈ 𝔷(𝔠) ∩ 𝔠^⊥` if and only if `y ∈ zPerpV x`.

The inclusion into `𝔰𝔬(V)` is [L160.lean](L160.lean)'s `L160_support`. The converse splits each `c ∈ 𝔠` as
`Pc + (1 - P)c` with `P` the orthogonal projection onto `V`: `c` commutes with `x`, so it preserves `K` and
`V` and commutes with `P`, which puts `Pc` in `𝔠_V` and leaves `(1 - P)c` supported on `K`, where a `y`
killing `K` neither sees it in a bracket nor pairs with it.
-/

namespace HamiltonsCubic.MixedSummand

open Matrix Module HamiltonsCubic.SkewNormalForm HamiltonsCubic.SkewCentraliser HamiltonsCubic.L81Statement

variable {m : ℕ} {x : Matrix (Fin m) (Fin m) ℝ}

/-- **The right side of the identity**, inside `𝔰𝔬(m)`: skew `y` killing `ker x`, commuting with and orthogonal
to every element of `𝔠` that kills `ker x`. -/
def zPerpV (x : Matrix (Fin m) (Fin m) ℝ) : Set (Matrix (Fin m) (Fin m) ℝ) :=
  {y | Skew y ∧ (∀ z, x *ᵥ z = 0 → y *ᵥ z = 0) ∧
    ∀ c ∈ cc x, (∀ z, x *ᵥ z = 0 → c *ᵥ z = 0) → br y c = 0 ∧ inner2 y c = 0}

theorem mat_ext {A B : Matrix (Fin m) (Fin m) ℝ} (h : ∀ q, A *ᵥ q = B *ᵥ q) : A = B := by
  rw [← sub_eq_zero]
  apply co_eq_zero
  intro p q
  unfold co
  rw [Matrix.sub_mulVec, h q, sub_self, dotProduct_zero]

section Proj

variable (N : NF x)

/-- The orthogonal projection onto the planes, `V = im x`. -/
noncomputable def Pm : Matrix (Fin m) (Fin m) ℝ :=
  ∑ j, (vecMulVec (N.u j) (N.u j) + vecMulVec (N.w j) (N.w j))

theorem Pm_mulVec (v : Fin m → ℝ) : Pm N *ᵥ v = proj N v := by
  unfold Pm proj
  rw [Matrix.sum_mulVec]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [Matrix.add_mulVec, vecMulVec_mulVec, vecMulVec_mulVec, dotProduct_comm (N.u j), dotProduct_comm (N.w j)]
  simp [op_smul_eq_smul]

theorem proj_inK {z : Fin m → ℝ} (hz : InK N z) : proj N z = 0 := by
  unfold proj
  exact Finset.sum_eq_zero fun j _ => by rw [(hz j).1, (hz j).2, zero_smul, zero_smul, add_zero]

theorem inK_dot_proj {z : Fin m → ℝ} (hz : InK N z) (v : Fin m → ℝ) : z ⬝ᵥ proj N v = 0 := by
  unfold proj
  rw [dotProduct_sum]
  exact Finset.sum_eq_zero fun j _ => by
    have h1 : z ⬝ᵥ N.u j = 0 := by rw [dotProduct_comm]; exact (hz j).1
    have h2 : z ⬝ᵥ N.w j = 0 := by rw [dotProduct_comm]; exact (hz j).2
    rw [dotProduct_add, dotProduct_smul, dotProduct_smul, h1, h2]; simp

theorem proj_proj (v : Fin m → ℝ) : proj N (proj N v) = proj N v := by
  change ∑ j, ((N.u j ⬝ᵥ proj N v) • N.u j + (N.w j ⬝ᵥ proj N v) • N.w j) = proj N v
  simp only [u_proj, w_proj]; rfl

theorem proj_sub (v w : Fin m → ℝ) : proj N (v - w) = proj N v - proj N w := by
  unfold proj
  rw [← Finset.sum_sub_distrib]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [dotProduct_sub, dotProduct_sub, sub_smul, sub_smul]; abel

/-- **A skew map preserving `K` commutes with the projection onto `V`.** -/
theorem proj_comm {A : Matrix (Fin m) (Fin m) ℝ} (hA : Skew A) (hK : ∀ z, InK N z → InK N (A *ᵥ z))
    (v : Fin m → ℝ) : proj N (A *ᵥ v) = A *ᵥ proj N v := by
  set p := proj N v
  set k := v - p
  have hk : InK N k := kp_inK N v
  have hv : v = p + k := by simp [p, k]
  -- `A p` lies in `V`
  set q := A *ᵥ p - proj N (A *ᵥ p)
  have hq : InK N q := kp_inK N _
  have hqq : q ⬝ᵥ q = 0 := by
    have e1 : q ⬝ᵥ proj N (A *ᵥ p) = 0 := inK_dot_proj N hq _
    have e2 : q ⬝ᵥ (A *ᵥ p) = 0 := by
      rw [dot_skew' hA]
      have := inK_dot_proj N (hK q hq) v
      rw [show (A *ᵥ q) ⬝ᵥ p = (A *ᵥ q) ⬝ᵥ proj N v from rfl, this, neg_zero]
    calc q ⬝ᵥ q = q ⬝ᵥ (A *ᵥ p) - q ⬝ᵥ proj N (A *ᵥ p) := by rw [← dotProduct_sub]
      _ = 0 := by rw [e1, e2, sub_zero]
  have hq0 : q = 0 := dotProduct_self_eq_zero.mp hqq
  have hAp : proj N (A *ᵥ p) = A *ᵥ p := by
    have := sub_eq_zero.mp hq0; exact this.symm
  rw [hv, Matrix.mulVec_add, show proj N (A *ᵥ p + A *ᵥ k) = proj N (A *ᵥ p) + proj N (A *ᵥ k) by
    have := proj_sub N (A *ᵥ p + A *ᵥ k) (A *ᵥ k)
    rw [add_sub_cancel_right] at this
    rw [this]; abel, hAp, proj_inK N (hK k hk), add_zero]

/-- `P` is the matrix of `proj`, so a skew `A` preserving `K` commutes with it. -/
theorem Pm_comm {A : Matrix (Fin m) (Fin m) ℝ} (hA : Skew A) (hK : ∀ z, InK N z → InK N (A *ᵥ z)) :
    Pm N * A = A * Pm N :=
  mat_ext fun q => by rw [← Matrix.mulVec_mulVec, ← Matrix.mulVec_mulVec, Pm_mulVec, Pm_mulVec, proj_comm N hA hK]

/-- A map killing `K` satisfies `A P = A`. -/
theorem mul_Pm {A : Matrix (Fin m) (Fin m) ℝ} (hK : ∀ z, InK N z → A *ᵥ z = 0) : A * Pm N = A :=
  mat_ext fun q => by
    rw [← Matrix.mulVec_mulVec, Pm_mulVec]
    have := hK _ (kp_inK N q)
    rw [Matrix.mulVec_sub, sub_eq_zero] at this
    exact this.symm

theorem Pm_symm : (Pm N)ᵀ = Pm N := by
  unfold Pm
  rw [Matrix.transpose_sum]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [Matrix.transpose_add, transpose_vecMulVec, transpose_vecMulVec]

end Proj

/-- **L160's displayed identity**, inside `𝔰𝔬(m)`: at `m ≠ 3`, `𝔷(𝔠) ∩ 𝔠^⊥ = 𝔷_{𝔰𝔬(V)}(𝔠_V) ∩ 𝔠_V^{⊥_V}`. -/
theorem L160_identity (hx : Skew x) (hm : m ≠ 3) (y : Matrix (Fin m) (Fin m) ℝ) :
    y ∈ zPerp x ↔ y ∈ zPerpV x := by
  obtain ⟨N⟩ := nf_exists hx
  have kerK : ∀ z, x *ᵥ z = 0 ↔ InK N z := fun z =>
    ⟨inK_of_ker N hx, fun hz => by rw [x_eq_T N]; exact T_K N N.a hz⟩
  constructor
  · intro hy
    exact ⟨hy.1, fun z hz => L160_support hx hm hy hz, fun c hc _ => ⟨hy.2.1 c hc, hy.2.2 c hc⟩⟩
  · rintro ⟨hys, hyK, hyc⟩
    have hyK' : ∀ z, InK N z → y *ᵥ z = 0 := fun z hz => hyK z ((kerK z).mpr hz)
    have hyP : y * Pm N = y := mul_Pm N hyK'
    have hPy : Pm N * y = y := by
      rw [Pm_comm N hys (fun z hz => by rw [hyK' z hz]; exact fun j => by simp), hyP]
    refine ⟨hys, fun c hc => ?_, fun c hc => ?_⟩ <;>
    · obtain ⟨hcs, hci, hcb⟩ := hc
      have hcK : ∀ z, InK N z → InK N (c *ᵥ z) := fun z hz => by
        rw [← kerK]
        have : x * c = c * x := by unfold br at hcb; exact sub_eq_zero.mp hcb
        rw [Matrix.mulVec_mulVec, this, ← Matrix.mulVec_mulVec, (kerK z).mpr hz, Matrix.mulVec_zero]
      have hPc := Pm_comm N hcs hcK
      have hxK : ∀ z, InK N z → x *ᵥ z = 0 := fun z hz => (kerK z).mpr hz
      have hxP : x * Pm N = x := mul_Pm N hxK
      have hPx : Pm N * x = x := by
        rw [Pm_comm N hx (fun z hz => by rw [hxK z hz]; exact fun j => by simp), hxP]
      -- `cV = P c` lies in `𝔠` and kills `K`
      have hcV : Pm N * c ∈ cc x := by
        refine ⟨?_, ?_, ?_⟩
        · unfold Skew at hcs ⊢
          rw [Matrix.transpose_mul, hcs, Pm_symm, Matrix.neg_mul, ← hPc]
        · have hsplit : inner2 x c = inner2 x (Pm N * c) + inner2 x (c - Pm N * c) := by
            unfold inner2; rw [← mul_add, ← Matrix.trace_add, ← Matrix.mul_add, add_sub_cancel]
          have h0 : inner2 x (c - Pm N * c) = 0 := by
            unfold inner2
            have : xᵀ * (c - Pm N * c) = 0 := by
              unfold Skew at hx
              rw [hx, Matrix.neg_mul, Matrix.mul_sub, ← Matrix.mul_assoc, hxP, sub_self, neg_zero]
            rw [this, Matrix.trace_zero, mul_zero]
          rw [hsplit, h0, add_zero] at hci; exact hci
        · have hxc : c * x = x * c := by unfold br at hcb; exact (sub_eq_zero.mp hcb).symm
          unfold br
          rw [← Matrix.mul_assoc, hxP, Matrix.mul_assoc (Pm N) c x, hxc, ← Matrix.mul_assoc, hPx, sub_self]
      have hcVK : ∀ z, x *ᵥ z = 0 → (Pm N * c) *ᵥ z = 0 := fun z hz => by
        rw [← Matrix.mulVec_mulVec, Pm_mulVec]
        exact proj_inK N (hcK z ((kerK z).mp hz))
      obtain ⟨hb, hi⟩ := hyc _ hcV hcVK
      -- the `K`-part is invisible to `y`
      have hyR : y * (c - Pm N * c) = 0 := by
        rw [Matrix.mul_sub, ← Matrix.mul_assoc, hyP, sub_self]
      have hRy : (c - Pm N * c) * y = 0 := by
        rw [Matrix.sub_mul, hPc, Matrix.mul_assoc, hPy, sub_self]
      first
        | (have : br y c = br y (Pm N * c) + (y * (c - Pm N * c) - (c - Pm N * c) * y) := by
             unfold br; noncomm_ring
           rw [this, hb, hyR, hRy, sub_self, add_zero])
        | (have : inner2 y c = inner2 y (Pm N * c) + inner2 y (c - Pm N * c) := by
             unfold inner2; rw [← mul_add, ← Matrix.trace_add, ← Matrix.mul_add, add_sub_cancel]
           have h0 : inner2 y (c - Pm N * c) = 0 := by
             unfold inner2
             unfold Skew at hys
             rw [hys, Matrix.neg_mul, hyR, neg_zero, Matrix.trace_zero, mul_zero]
           rw [this, hi, h0, add_zero])

end HamiltonsCubic.MixedSummand

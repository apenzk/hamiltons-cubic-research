import Mathlib
import HamiltonsCubic.Results.L221Crit

set_option linter.style.longLine false

/-!
# L221 (a) on the operators: disjoint four-set blocks, their subalgebra and the split of criticality

[findings/second-order.md](../../../findings/second-order.md), Lemma L221 (a): *if $Q_1,\dots,Q_m$ are pairwise disjoint four-sets,
... the space is a subalgebra, $\nu_i\circ\nu_j=0$ for $i\ne j$, and $\nu_i\circ\nu_i\in\Pi_{Q_i}$.* The split of criticality on it is
L220's step 3 block by block. With the characters of pairwise disjoint nonempty sets, one flip at an index of $Q_i$ separates
$\chi_{Q_i}$ from $1$ and from every other $\chi_{Q_j}$:

* `foxProd2_sum_left`, `foxProd2_sum_right`, `extend_sum`: the product and `extend` distribute over finite sums;
* `multi_split_zero`: an operator of character $1$ plus operators of characters $\chi_{Q_i}$ summing to zero all vanish;
* **`L221a_split`**: at $W=D+\sum_i\nu_i$ with $Q(W)=\theta W$, $D\circ D+\sum_i\nu_i\circ\nu_i=\theta D$ and $2\,D\circ\nu_i=\theta\nu_i$ for every $i$,
  the cross terms vanishing by [L221Ops.lean](L221Ops.lean)'s `disjoint_prod_zero`;
* `InM`, **`M_mul`**, `SM`, **`L221a_crit`**: $\mathcal D_n\oplus V_{Q_1}\oplus\cdots\oplus V_{Q_m}$ is closed under $\circ$, and a local maximiser of
  $P$ on the unit sphere of its Weyl part is critical in $\mathcal W_n$ and satisfies the split with $\theta=P(W)$.
-/

namespace HamiltonsCubic.L221a

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.L120Hess HamiltonsCubic.L120Blocks
  HamiltonsCubic.L222Op HamiltonsCubic.BlockSub HamiltonsCubic.L221Ops HamiltonsCubic.SubFermat

variable {ι : Type*} [Fintype ι] [DecidableEq ι] {m : ℕ}

theorem foxProd2_zero_right (X : CurvOp2 ι) : foxProd2 X 0 = 0 := by
  have e : (0 : CurvOp2 ι) = (0 : ℝ) • (0 : CurvOp2 ι) := by module
  calc foxProd2 X (0 : CurvOp2 ι) = foxProd2 X ((0 : ℝ) • (0 : CurvOp2 ι)) := congrArg (foxProd2 X) e
    _ = (0 : ℝ) • foxProd2 X (0 : CurvOp2 ι) := foxProd2_smul_right _ _ _
    _ = 0 := by module

theorem foxProd2_sum_right (X : CurvOp2 ι) (s : Finset (Fin m)) (f : Fin m → CurvOp2 ι) :
    foxProd2 X (∑ i ∈ s, f i) = ∑ i ∈ s, foxProd2 X (f i) := by
  induction s using Finset.induction_on with
  | empty => rw [Finset.sum_empty, Finset.sum_empty, foxProd2_zero_right]
  | insert a s ha ih => rw [Finset.sum_insert ha, Finset.sum_insert ha, foxProd2_add_right, ih]

theorem foxProd2_sum_left (s : Finset (Fin m)) (f : Fin m → CurvOp2 ι) (Y : CurvOp2 ι) :
    foxProd2 (∑ i ∈ s, f i) Y = ∑ i ∈ s, foxProd2 (f i) Y := by
  rw [foxProd2_comm, foxProd2_sum_right]
  exact Finset.sum_congr rfl fun i _ => foxProd2_comm _ _

theorem extend_sum (s : Finset (Fin m)) (f : Fin m → CurvOp2 ι) (Y : Matrix ι ι ℝ) :
    extend (∑ i ∈ s, f i) Y = ∑ i ∈ s, extend (f i) Y := by
  induction s using Finset.induction_on with
  | empty => rw [Finset.sum_empty, Finset.sum_empty, extend_zero']
  | insert a s ha ih => rw [Finset.sum_insert ha, Finset.sum_insert ha, extend_add, ih]

theorem signChar_sum {c : (ι → ℝ) → ℝ} (s : Finset (Fin m)) (f : Fin m → CurvOp2 ι) (h : ∀ i ∈ s, SignChar c (f i)) :
    SignChar c (∑ i ∈ s, f i) := by
  induction s using Finset.induction_on with
  | empty => rw [Finset.sum_empty]; exact signChar_zero c
  | insert a s ha ih =>
    rw [Finset.sum_insert ha]
    exact signChar_add (h a (Finset.mem_insert_self a s)) (ih fun i hi => h i (Finset.mem_insert_of_mem hi))

/-- **An operator of character `1` plus operators of the characters of pairwise disjoint nonempty sets, summing to zero,
all vanish.** -/
theorem multi_split_zero {Q : Fin m → Finset ι} (hdis : ∀ i j, i ≠ j → Disjoint (Q i) (Q j))
    (hne : ∀ i, (Q i).Nonempty) {A₀ : CurvOp2 ι} {A : Fin m → CurvOp2 ι} (h₀ : SignChar (fun _ => 1) A₀)
    (hA : ∀ i, SignChar (setChar (Q i)) (A i)) (hsum : A₀ + ∑ i, A i = 0) : A₀ = 0 ∧ ∀ i, A i = 0 := by
  have zero_of : ∀ B : CurvOp2 ι, (∀ Z : Matrix ι ι ℝ, IsSkew Z → extend B Z = 0) → B = 0 := fun B h =>
    ContinuousLinearMap.ext fun X => Subtype.ext (by rw [← extend_apply, h _ X.2]; rfl)
  have hS : ∀ Y : Matrix ι ι ℝ, extend A₀ Y + ∑ i, extend (A i) Y = 0 := fun Y => by
    rw [← extend_sum, ← extend_add, hsum, extend_zero']
  have hAi : ∀ i, A i = 0 := by
    intro i
    obtain ⟨p, hp⟩ := hne i
    have hε := Results.sgn_mul_self p
    have hχ : ∀ j, setChar (Q j) (Results.sgn p) = if j = i then -1 else 1 := fun j => by
      rw [setChar_sgn]
      by_cases hj : j = i
      · rw [if_pos (hj ▸ hp), if_pos hj]
      · have hpj : p ∉ Q j := fun hpj => Finset.disjoint_left.mp (hdis i j (Ne.symm hj)) hp hpj
        rw [if_neg hpj, if_neg hj]
    refine zero_of _ fun Z hZ => ?_
    have e := congrArg (fun M => signMat (Results.sgn p) * M * (signMat (Results.sgn p))ᵀ)
      (hS ((signMat (Results.sgn p))ᵀ * Z * signMat (Results.sgn p)))
    simp only [Matrix.mul_add, Matrix.add_mul, Matrix.mul_zero, Matrix.zero_mul, Matrix.mul_sum, Matrix.sum_mul] at e
    rw [h₀ _ hε Z hZ, one_smul] at e
    have e2 : ∀ j, signMat (Results.sgn p) * extend (A j) ((signMat (Results.sgn p))ᵀ * Z * signMat (Results.sgn p))
        * (signMat (Results.sgn p))ᵀ = (if j = i then (-1 : ℝ) else 1) • extend (A j) Z := fun j => by
      rw [(hA j) _ hε Z hZ, hχ j]
    simp only [e2] at e
    have f0 := hS Z
    rw [← Finset.add_sum_erase _ _ (Finset.mem_univ i)] at f0 e
    rw [if_pos rfl] at e
    have hrest : ∑ j ∈ Finset.univ.erase i, (if j = i then (-1 : ℝ) else 1) • extend (A j) Z
        = ∑ j ∈ Finset.univ.erase i, extend (A j) Z :=
      Finset.sum_congr rfl fun j hj => by rw [if_neg (Finset.ne_of_mem_erase hj), one_smul]
    rw [hrest] at e
    have h2 : (2 : ℝ) • extend (A i) Z = 0 := by
      calc (2 : ℝ) • extend (A i) Z
          = (extend A₀ Z + (extend (A i) Z + ∑ j ∈ Finset.univ.erase i, extend (A j) Z))
            - (extend A₀ Z + ((-1 : ℝ) • extend (A i) Z + ∑ j ∈ Finset.univ.erase i, extend (A j) Z)) := by module
        _ = 0 := by rw [f0, e]; module
    calc extend (A i) Z = (1 / 2 : ℝ) • ((2 : ℝ) • extend (A i) Z) := by module
      _ = 0 := by rw [h2]; module
  refine ⟨?_, hAi⟩
  have : ∑ i, A i = 0 := Finset.sum_eq_zero fun i _ => hAi i
  rw [this] at hsum
  calc A₀ = A₀ + 0 := by module
    _ = 0 := hsum

/-- **L221 (a), the split of criticality**: at pairwise disjoint four-sets and `W = D + Σ ν_i` with `Q(W) = θW`,
`D∘D + Σ ν_i∘ν_i = θD` and `2 D∘ν_i = θν_i` for every `i`. -/
theorem L221a_split {Q : Fin m → Finset ι} (hdis : ∀ i j, i ≠ j → Disjoint (Q i) (Q j)) (hcard : ∀ i, (Q i).card = 4)
    {D : CurvOp2 ι} {ν : Fin m → CurvOp2 ι} (hD : SignChar (fun _ => 1) D) (hν : ∀ i, SignChar (setChar (Q i)) (ν i))
    {θ : ℝ} (hQ : Qop2 (D + ∑ i, ν i) = θ • (D + ∑ i, ν i)) :
    foxProd2 D D + ∑ i, foxProd2 (ν i) (ν i) = θ • D ∧ ∀ i, (2 : ℝ) • foxProd2 D (ν i) = θ • ν i := by
  have hne : ∀ i, (Q i).Nonempty := fun i => Finset.card_pos.mp (by rw [hcard i]; norm_num)
  have hoff : ∀ i j, i ≠ j → foxProd2 (ν i) (ν j) = 0 := fun i j hij =>
    disjoint_prod_zero (hdis i j hij) (hcard i) (hcard j) (hν i) (hν j)
  have hdiag : ∀ i, ∑ j, foxProd2 (ν i) (ν j) = foxProd2 (ν i) (ν i) := fun i => by
    rw [← Finset.add_sum_erase _ _ (Finset.mem_univ i),
      Finset.sum_eq_zero fun j hj => hoff i j (Ne.symm (Finset.ne_of_mem_erase hj)), add_zero]
  have hexp : Qop2 (D + ∑ i, ν i)
      = foxProd2 D D + ∑ i, foxProd2 (ν i) (ν i) + (2 : ℝ) • ∑ i, foxProd2 D (ν i) := by
    rw [← foxProd2_self, foxProd2_add_left, foxProd2_add_right, foxProd2_add_right, foxProd2_sum_right,
      foxProd2_sum_left, foxProd2_sum_left]
    simp only [foxProd2_sum_right, hdiag]
    have hc : ∑ i, foxProd2 (ν i) D = ∑ i, foxProd2 D (ν i) := Finset.sum_congr rfl fun i _ => foxProd2_comm _ _
    rw [hc]
    module
  have hA₀ : SignChar (fun _ => 1) (foxProd2 D D + ∑ i, foxProd2 (ν i) (ν i) + (-1 : ℝ) • (θ • D)) :=
    signChar_add (signChar_add (signChar_congr (foxProd2_char2 hD hD) fun _ _ => by ring)
      (signChar_sum _ _ fun i _ => signChar_congr (foxProd2_char2 (hν i) (hν i)) fun ε hε => setChar_sq _ ε hε))
      (signChar_smul (signChar_smul hD _) _)
  have hA : ∀ i, SignChar (setChar (Q i)) ((2 : ℝ) • foxProd2 D (ν i) + (-1 : ℝ) • (θ • ν i)) := fun i =>
    signChar_add (signChar_smul (signChar_congr (foxProd2_char2 hD (hν i)) fun _ _ => by ring) _)
      (signChar_smul (signChar_smul (hν i) _) _)
  have hsum : (foxProd2 D D + ∑ i, foxProd2 (ν i) (ν i) + (-1 : ℝ) • (θ • D))
      + ∑ i, ((2 : ℝ) • foxProd2 D (ν i) + (-1 : ℝ) • (θ • ν i)) = 0 := by
    rw [Finset.sum_add_distrib, ← Finset.smul_sum, ← Finset.smul_sum, ← Finset.smul_sum]
    calc foxProd2 D D + ∑ i, foxProd2 (ν i) (ν i) + (-1 : ℝ) • (θ • D)
          + ((2 : ℝ) • ∑ i, foxProd2 D (ν i) + (-1 : ℝ) • (θ • ∑ i, ν i))
        = Qop2 (D + ∑ i, ν i) + (-1 : ℝ) • (θ • (D + ∑ i, ν i)) := by rw [hexp]; module
      _ = 0 := by rw [hQ]; module
  obtain ⟨z₀, z⟩ := multi_split_zero hdis hne hA₀ hA hsum
  refine ⟨?_, fun i => ?_⟩
  · calc foxProd2 D D + ∑ i, foxProd2 (ν i) (ν i)
        = (foxProd2 D D + ∑ i, foxProd2 (ν i) (ν i) + (-1 : ℝ) • (θ • D)) + θ • D := by module
      _ = θ • D := by rw [z₀]; module
  · calc (2 : ℝ) • foxProd2 D (ν i) = ((2 : ℝ) • foxProd2 D (ν i) + (-1 : ℝ) • (θ • ν i)) + θ • ν i := by module
      _ = θ • ν i := by rw [z i]; module

/-- **`𝒟ₙ ⊕ V_{Q_1} ⊕ ⋯ ⊕ V_{Q_m}`**, an operator of character `1` plus operators of the characters `χ_{Q_i}`. -/
def InM (Q : Fin m → Finset ι) (R : CurvOp2 ι) : Prop :=
  ∃ (D : CurvOp2 ι) (ν : Fin m → CurvOp2 ι), SignChar (fun _ => 1) D ∧ (∀ i, SignChar (setChar (Q i)) (ν i)) ∧
    R = D + ∑ i, ν i

/-- **L221 (a), the subalgebra clause**: at pairwise disjoint four-sets the space is closed under `∘`. -/
theorem M_mul {Q : Fin m → Finset ι} (hdis : ∀ i j, i ≠ j → Disjoint (Q i) (Q j)) (hcard : ∀ i, (Q i).card = 4)
    {x y : CurvOp2 ι} (hx : InM Q x) (hy : InM Q y) : InM Q (foxProd2 x y) := by
  obtain ⟨D, ν, hD, hν, rfl⟩ := hx
  obtain ⟨D', ν', hD', hν', rfl⟩ := hy
  have hdiag : ∀ i, ∑ j, foxProd2 (ν i) (ν' j) = foxProd2 (ν i) (ν' i) := fun i => by
    rw [← Finset.add_sum_erase _ _ (Finset.mem_univ i),
      Finset.sum_eq_zero fun j hj => disjoint_prod_zero (hdis i j (Ne.symm (Finset.ne_of_mem_erase hj)))
        (hcard i) (hcard j) (hν i) (hν' j), add_zero]
  refine ⟨foxProd2 D D' + ∑ i, foxProd2 (ν i) (ν' i), fun i => foxProd2 D (ν' i) + foxProd2 (ν i) D', ?_, fun i => ?_, ?_⟩
  · exact signChar_add (signChar_congr (foxProd2_char2 hD hD') fun _ _ => by ring)
      (signChar_sum _ _ fun i _ => signChar_congr (foxProd2_char2 (hν i) (hν' i)) fun ε hε => setChar_sq _ ε hε)
  · exact signChar_add (signChar_congr (foxProd2_char2 hD (hν' i)) fun _ _ => by ring)
      (signChar_congr (foxProd2_char2 (hν i) hD') fun _ _ => by ring)
  · rw [foxProd2_add_left, foxProd2_add_right, foxProd2_add_right, foxProd2_sum_right, foxProd2_sum_left,
      foxProd2_sum_left]
    simp only [foxProd2_sum_right, hdiag]
    rw [Finset.sum_add_distrib]
    abel

/-- **The Weyl part of `𝒟ₙ ⊕ V_{Q_1} ⊕ ⋯ ⊕ V_{Q_m}`** as a submodule. -/
def SM (Q : Fin m → Finset ι) : Submodule ℝ (CurvOp2 ι) where
  carrier := {R | IsWeyl2 R ∧ InM Q R}
  add_mem' := by
    rintro x y ⟨hxW, D, ν, hD, hν, rfl⟩ ⟨hyW, D', ν', hD', hν', rfl⟩
    refine ⟨isWeyl2_add hxW hyW, D + D', fun i => ν i + ν' i, signChar_add hD hD', fun i => signChar_add (hν i) (hν' i), ?_⟩
    rw [Finset.sum_add_distrib]
    abel
  zero_mem' := ⟨isWeyl2_zero, 0, fun _ => 0, signChar_zero _, fun _ => signChar_zero _, by
    rw [Finset.sum_const_zero]; abel⟩
  smul_mem' := by
    rintro c x ⟨hxW, D, ν, hD, hν, rfl⟩
    refine ⟨isWeyl2_smul c hxW, c • D, fun i => c • ν i, signChar_smul hD c, fun i => signChar_smul (hν i) c, ?_⟩
    rw [← Finset.smul_sum]
    module

theorem SM_Qop2 {Q : Fin m → Finset ι} (hdis : ∀ i j, i ≠ j → Disjoint (Q i) (Q j)) (hcard : ∀ i, (Q i).card = 4) :
    ∀ R ∈ SM Q, Qop2 R ∈ SM Q := by
  rintro _R ⟨hRW, hR⟩
  refine ⟨isWeyl2_Qop2 hRW, ?_⟩
  rw [← foxProd2_self]
  exact M_mul hdis hcard hR hR

/-- **L221 (a), from a maximiser**: a local maximiser of `P` on the unit sphere of the Weyl part of
`𝒟ₙ ⊕ V_{Q_1} ⊕ ⋯ ⊕ V_{Q_m}`, at pairwise disjoint four-sets, is critical in `𝒲ₙ` with `θ = P(W)` and its components
satisfy `D∘D + Σ ν_i∘ν_i = θD` and `2 D∘ν_i = θν_i`. -/
theorem L221a_crit {Q : Fin m → Finset ι} (hdis : ∀ i j, i ≠ j → Disjoint (Q i) (Q j)) (hcard : ∀ i, (Q i).card = 4)
    {W : CurvOp2 ι} (hW1 : normSq2 W = 1) (hWS : W ∈ SM Q)
    (hmax : IsLocalMaxOn Pcubic2 {R | normSq2 R = 1 ∧ R ∈ SM Q} W) :
    Qop2 W = Pcubic2 W • W ∧ ∃ (D : CurvOp2 ι) (ν : Fin m → CurvOp2 ι), W = D + ∑ i, ν i ∧
      foxProd2 D D + ∑ i, foxProd2 (ν i) (ν i) = Pcubic2 W • D ∧ ∀ i, (2 : ℝ) • foxProd2 D (ν i) = Pcubic2 W • ν i := by
  have hcrit := crit_sub (SM Q) (fun R hR => hR.1.isSelfAdjoint2) (SM_Qop2 hdis hcard) hW1 hWS hmax
  refine ⟨hcrit, ?_⟩
  obtain ⟨-, D, ν, hD, hν, hWeq⟩ := hWS
  rw [hWeq] at hcrit
  have hs := L221a_split hdis hcard hD hν hcrit
  rw [← hWeq] at hs
  exact ⟨D, ν, hWeq, hs⟩

end HamiltonsCubic.L221a

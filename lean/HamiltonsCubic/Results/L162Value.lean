import HamiltonsCubic.Results.L162Mono

set_option linter.style.longLine false

/-!
# L162's value at `n = 12`, bracketed exactly

[second-order.md](../../../findings/second-order.md), Lemma L162: *"with `F(12) = 0.38673`"*, a figure the Lean row
recorded as a measurement. `F` is a closed form in `√220`, `√6` and `√(3/2)`, so the figure is a theorem: rational
enclosures of the radicals propagate through `F`'s monotonicity in `s` and `β`
([L162.lean](L162.lean)'s `F_strictMono_s` and `F_antitone_beta`) to

* **`F12_bounds`**: `0.386727 < F(12) < 0.386728`, so the printed `0.38673` is `F(12)` to five places.
-/

namespace HamiltonsCubic.L162

/-- `F(12)`, the record's composed constant at `n = 12`. -/
noncomputable def F12 : ℝ :=
  4 * Real.sqrt (Sfun 12) / (Real.sqrt (4 * (lam 12 / (2 * (2 * (2 * 12 - 3) / (12 - 1)))) * Real.sqrt (Sfun 12) + 1) + 1) ^ 2

theorem F12_bounds : 386727 / 1000000 < F12 ∧ F12 < 386728 / 1000000 := by
  -- the radicals
  have q12 : q 12 = Real.sqrt 220 := by unfold q; norm_num
  have h220 : (1483239697419 / 100000000000 : ℝ) < Real.sqrt 220 ∧ Real.sqrt 220 < 14832396974193 / 1000000000000 :=
    ⟨(Real.lt_sqrt (by norm_num)).mpr (by norm_num), (Real.sqrt_lt' (by norm_num)).mpr (by norm_num)⟩
  have h6 : (1224744871391 / 500000000000 : ℝ) < Real.sqrt 6 ∧ Real.sqrt 6 < 489897948557 / 200000000000 :=
    ⟨(Real.lt_sqrt (by norm_num)).mpr (by norm_num), (Real.sqrt_lt' (by norm_num)).mpr (by norm_num)⟩
  have hth : (494413232473 / 400000000000 : ℝ) < Real.sqrt (2 * (12 - 1) * (12 - 2) / 12 ^ 2) ∧
      Real.sqrt (2 * (12 - 1) * (12 - 2) / 12 ^ 2) < 3090082702957 / 2500000000000 :=
    ⟨(Real.lt_sqrt (by norm_num)).mpr (by norm_num), (Real.sqrt_lt' (by norm_num)).mpr (by norm_num)⟩
  have h32 : (122474487139 / 100000000000 : ℝ) < Real.sqrt (3 / 2) ∧ Real.sqrt (3 / 2) < 1224744871393 / 1000000000000 :=
    ⟨(Real.lt_sqrt (by norm_num)).mpr (by norm_num), (Real.sqrt_lt' (by norm_num)).mpr (by norm_num)⟩
  -- `S(12)` and `s = √S(12)`
  have hS : Sfun 12 = 4 / 9 * Real.sqrt 6 - 29 / 1080 * Real.sqrt 220 := by
    unfold Sfun; rw [q12]; ring
  set S := Sfun 12 with hSdef
  have hSlo : (69038478173 / 100000000000 : ℝ) < S := by rw [hS]; linarith [h220.2, h6.1]
  have hShi : S < 2157452443 / 3125000000 := by rw [hS]; linarith [h220.1, h6.2]
  have hs : (2077234913 / 2500000000 : ℝ) < Real.sqrt S ∧ Real.sqrt S < 1038617457 / 1250000000 :=
    ⟨(Real.lt_sqrt (by norm_num)).mpr (by linarith), (Real.sqrt_lt' (by norm_num)).mpr (by linarith)⟩
  -- `λ(12)` and `β = λ/(2C)` with `C = 42/11`
  set d := Real.sqrt (2 * (12 - 1) * (12 - 2) / 12 ^ 2) - Real.sqrt (3 / 2) with hd
  have hdlo : (2822052447 / 250000000000 : ℝ) < d := by rw [hd]; linarith [hth.1, h32.2]
  have hdhi : d < 5644104897 / 500000000000 := by rw [hd]; linarith [hth.2, h32.1]
  have hr : (31873796147 / 100000000000 : ℝ) < Real.sqrt (9 * d) ∧ Real.sqrt (9 * d) < 31873796159 / 100000000000 :=
    ⟨(Real.lt_sqrt (by norm_num)).mpr (by linarith), (Real.sqrt_lt' (by norm_num)).mpr (by linarith)⟩
  have hlam : lam 12 = 2 / Real.sqrt (9 * d) := rfl
  set β := lam 12 / (2 * (2 * (2 * 12 - 3) / (12 - 1))) with hβ
  have hβe : β = 11 / 42 / Real.sqrt (9 * d) := by rw [hβ, hlam]; field_simp; ring
  have hr0 : 0 < Real.sqrt (9 * d) := by linarith [hr.1]
  have hβlo : (82169303 / 100000000 : ℝ) < β := by
    rw [hβe, lt_div_iff₀ hr0]; nlinarith [hr.2]
  have hβhi : β < 821693033 / 1000000000 := by
    rw [hβe, div_lt_iff₀ hr0]; nlinarith [hr.1]
  -- `F` through its monotone form
  set s := Real.sqrt S with hsdef
  have hs0 : 0 < s := by linarith [hs.1]
  have hF : F12 = 2 * s / (1 + 2 * β * s + Real.sqrt (1 + 4 * β * s)) := by
    unfold F12; rw [← hSdef, ← hsdef, ← hβ, F_form hs0.le (by linarith)]
  rw [hF]
  have hlow : 2 * (2077234913 / 2500000000) / (1 + 2 * (821693033 / 1000000000) * (2077234913 / 2500000000)
        + Real.sqrt (1 + 4 * (821693033 / 1000000000) * (2077234913 / 2500000000)))
      ≤ 2 * s / (1 + 2 * β * s + Real.sqrt (1 + 4 * β * s)) := by
    have a1 := F_strictMono_s (s := 2077234913 / 2500000000) (s' := s) (β := 821693033 / 1000000000)
      (by norm_num) hs.1 (by norm_num)
    have a2 := F_antitone_beta (s := s) (β := β) (β' := 821693033 / 1000000000) hs0 (by linarith) hβhi
    linarith
  have hhigh : 2 * s / (1 + 2 * β * s + Real.sqrt (1 + 4 * β * s))
      ≤ 2 * (1038617457 / 1250000000) / (1 + 2 * (82169303 / 100000000) * (1038617457 / 1250000000)
        + Real.sqrt (1 + 4 * (82169303 / 100000000) * (1038617457 / 1250000000))) := by
    have a1 := F_strictMono_s (s := s) (s' := 1038617457 / 1250000000) (β := 82169303 / 100000000)
      hs0.le hs.2 (by norm_num)
    have a2 := F_antitone_beta (s := s) (β := 82169303 / 100000000) (β' := β) hs0 (by norm_num) hβlo
    linarith
  have tU : Real.sqrt (1 + 4 * (821693033 / 1000000000 : ℝ) * (2077234913 / 2500000000)) < 19315691 / 10000000 :=
    (Real.sqrt_lt' (by norm_num)).mpr (by norm_num)
  have tL : (193156907 / 100000000 : ℝ) < Real.sqrt (1 + 4 * (82169303 / 100000000) * (1038617457 / 1250000000)) :=
    (Real.lt_sqrt (by norm_num)).mpr (by norm_num)
  have tU0 : 0 ≤ Real.sqrt (1 + 4 * (821693033 / 1000000000 : ℝ) * (2077234913 / 2500000000)) := Real.sqrt_nonneg _
  constructor
  · refine lt_of_lt_of_le ?_ hlow
    rw [lt_div_iff₀ (by positivity)]
    nlinarith [tU]
  · refine lt_of_le_of_lt hhigh ?_
    rw [div_lt_iff₀ (by positivity)]
    nlinarith [tL]

end HamiltonsCubic.L162

# Adjudication brief, round L20-r2, step G4

**Cold brief. The passages are quoted verbatim with their source lines.**

## The step

From the sentence "Three further hypotheses are used and are stated here rather than assumed" in Passage A's proof.

**The step: invariance of $d$ under $SO(n)$, the orbit being a compact embedded submanifold with a nearest point satisfying the first-variation condition, and $\varphi>0$, are hypotheses the lemma needs beyond its setting, as the sentence presents them.**

## Passage A, the heading, setting and proof ([findings/route-a.md](../findings/route-a.md) lines 103 and 121-135, odd lines)

#### Lemma L20, no maximizer lies near the rival maximizer's orbit, for every $n\ge12$

Write $\theta^*=\sqrt{3/2}=P(W_{\mathbb{CP}^2})$ and $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ as fixed in [conventions.md](../findings/conventions.md), so that $\theta_0(n)>\theta^*$ exactly when $n>6+2\sqrt7$.

**$d$ is geodesic angular distance on the unit sphere of $\mathrm{Weyl}_n$**, $\cos d(X,Y)=\langle X,Y\rangle$, the expansion below commits the proof to it, and **the radius depends on the choice**: read as a chord, $0.5748$ is the angle $0.5830224$, where $\psi=1.0020125>1$ and the argument reaches no contradiction. *This is the one input the statement cannot be read without, and it is now in [conventions.md](../findings/conventions.md).*

*Proof.* The unit sphere of $\mathrm{Weyl}_n$ is compact, so $m:=\sqrt{2/3}\max P$ is attained, at some $W^*$. **Three further hypotheses are used and are stated here rather than assumed**: that $d$ is $SO(n)$-invariant, that the orbit is a compact embedded submanifold so a nearest point exists and its first-variation condition holds, and that $\varphi>0$ for that condition to be non-vacuous, the degenerate branch is treated separately below. Suppose $\varphi:=d(W^*,SO(n).W_{\mathbb{CP}^2})\le0.5748$. Since $P$ is invariant under the conjugation action of $SO(n)$ on $\Lambda^2(\mathbb{R}^n)$, rotate so that the nearest orbit point is $u=W_{\mathbb{CP}^2}$ itself, and write $W^*=\cos\varphi\,u+\sin\varphi\,V$. The vector $V$ is a unit vector orthogonal to $u$, and orthogonal also to $T_u(SO(n).u)$ by the first-variation condition for a nearest point on the orbit. Since $P$ is a cubic form with polarization $T$, and $Q(u)=\theta^*u$ makes $T(u,u,V)=\theta^*\langle u,V\rangle=0$, the expansion is exact and has no linear term:

$$m=\cos^3\varphi+3\cos\varphi\sin^2\varphi\,\alpha+\sin^3\varphi\,\gamma_V,\qquad \alpha=\sqrt{\tfrac23}\langle F_uV,V\rangle,\quad \gamma_V=\sqrt{\tfrac23}P(V),$$

where $F_u(h)=\tfrac12(uh+hu)+u\# h$. The largest eigenvalue of $F_u$ on $u^\perp\cap T_u(SO(n).u)^\perp$ is $\tfrac13\theta^*$, so $\alpha\le1/3$. **This is the lemma's one unproved input, and the citation given for it does not carry it.** [Nienhaus](../references/nienhaus-2023-second-best-einstein/notes.md) Theorem 4.14(c) states *one* eigenvalue on *one* subspace; that it is the largest on $u^\perp\cap T_u\mathcal O^\perp$ needs 4.14(a) and (d)–(g) to be exhaustive **and** Remark 4.16, which identifies the $\tfrac12\theta^*$-eigenspace with $T_u\mathcal O$ and so removes the larger eigenvalue, neither cited here. **Without the first-variation step the bound would be $\alpha\le\tfrac12$, at which the interval is empty and the theorem is vacuous**, so this input is load-bearing rather than a convenience. *And 4.14's own proof runs through a Schur step whose multiplicity-free hypothesis this record's own [Lemma L21](../findings/route-a.md#lemma-l21-the-eigenvalue-bound-alphaletfrac13-structural-at-every-nge9) says fails here.* **What would discharge the debt**: that the four rational $F_\lambda$ matrices have the tabulated spectra, by rank certificates over $\mathbb Q$, and that their entries do not depend on $m=n-4$. And $\gamma_V\le m$ because $V$ is itself a unit Weyl operator and $m$ is the maximum over all of them. Substituting both and using $\cos^3\varphi+\cos\varphi\sin^2\varphi=\cos\varphi$,

$$m\le\cos\varphi+m\sin^3\varphi,\qquad\text{i.e.}\qquad m\le\psi(\varphi):=\frac{\cos\varphi}{1-\sin^3\varphi}.$$

On $[0,0.5748]$ one has $\psi\le1$. **The reduction is exact**: with $s=\sin\varphi$, both $\cos\varphi$ and $1-s^3$ are positive, so $\psi\le1$ is $1-s^2\le(1-s^3)^2$, that is $s^2(1-s)(1-s-s^2-s^3)\ge0$, which for $0\le s<1$ is $s\le s^*$ with $s^*$ the real root of $s^3+s^2+s=1$, unique because $3s^2+2s+1>0$. **And $\sin\varphi\le\sin(0.5748)<s^*$ exactly**: $\sin$ increases on $[0,0.5748]$, $\sin x\le x-\tfrac{x^3}6+\tfrac{x^5}{120}$ for $x\ge0$ gives $\sin(0.5748)<0.543672$ in exact rationals, and $0.5436890<s^*$ is kernel-checked in [TubeRadius.lean](../lean/HamiltonsCubic/Results/TubeRadius.lean). The minimum is $0.9785933$, at $\sin\varphi=\tfrac{\sqrt3-1}2$, i.e. $\varphi=0.3747372$. $\psi$ rises again and first exceeds $1$ at $\varphi=0.5748263$, so **the stated radius is the true crossing truncated in the safe direction** and $\psi(0.5748)=0.9999937$. Hence $m\le1$, i.e. $\max P\le\sqrt{3/2}$. **The contradiction needs a unit Weyl operator with $P>\sqrt{3/2}$, and at odd $n$ the balanced sphere product is not one, it does not exist.** The witness is the best split: $\Theta_n^2=\frac{2(n-1)(n-3)}{(n-2)(n+1)}$ at odd $n$, exceeding $\tfrac32$ exactly when $n^2-13n+18>0$, so from $n=13$; at even $n$ it is $\theta_0(n)$, exceeding $\tfrac32$ when $n^2-12n+8>0$, so from $n=12$. **The two parities carry different polynomials and both clear from $n\ge12$.** Therefore $\varphi>0.5748$. $\square$

The degenerate branch $\varphi=0$ is covered: there $W^*$ lies on the orbit, $\max P=\sqrt{3/2}$, and the same contradiction applies. Note that the contradiction is with the *value*, not the location, nothing is assumed about where the sphere product sits, and that it too lies outside the tube follows afterwards.

## Passage B, Lemma L21's statement, a given ([findings/route-a.md](../findings/route-a.md) line 174)

**Statement.** Let $n\ge9$, $m=n-4$, and let $u=W_{\mathbb{CP}^2}$ padded to $\mathcal W_n$, of unit norm with $\theta^*=P(u)=\sqrt{3/2}$. Write $F_u(h)=\tfrac12(uh+hu)+u\#h$ and $\alpha=\sqrt{2/3}\,\langle F_uV,V\rangle$ for a unit $V\in u^\perp\cap T_u(SO(n).u)^\perp$. Then $\alpha\le\tfrac13$, and $\tfrac13$ is attained.

## Passage C, the canonical statement ([results.md](../results.md) line 321, landscape, and lines 1063 and 1065, detail)

- **Lemma L20 (localization). No maximizer lies within $0.5748$ **geodesic angular** distance of the rival maximizer's orbit, for every $n\ge12$.** The chain from the expansion to $\max P\le\sqrt{3/2}$ is proved by bootstrap on the attained maximum and is **conditional on one input nothing on the record proves**, that $\tfrac13\theta^*$ is the largest eigenvalue of $F_u$ on $u^\perp\cap T_u\mathcal O^\perp$: inside the tube the exact cubic expansion forces $\max P\le\sqrt{3/2}$, contradicting the sphere product's larger value. The contradiction is with the value, not the location.

##### Lemma L20, no maximizer lies near the rival maximizer's orbit, for every $n\ge12$

Write $\theta^*=\sqrt{3/2}=P(W_{\mathbb{CP}^2})$ and $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$, so that $\theta_0(n)>\theta^*$ exactly when $n>6+2\sqrt7$. For every $n\ge12$, no maximizer of $P$ on the unit sphere of $\mathcal W_n$ lies within angular distance $0.5748$ of the orbit $SO(n).W_{\mathbb{CP}^2}$. The proof is a bootstrap on the attained maximum: inside the tube the exact cubic expansion about the orbit, with the eigenvalue bound $\alpha\le\tfrac13$ of [Lemma L21](../findings/route-a.md) and the self-bootstrap $\gamma_V\le m$, forces $\max P\le\theta^*$, contradicting the value $\theta_0(n)>\theta^*$ the sphere product attains. The contradiction is with the value.

## Passage D, the Lean files, declarations with docstrings removed ([L20Statement.lean](../lean/HamiltonsCubic/Results/L20Statement.lean), [TubeRadius.lean](../lean/HamiltonsCubic/Results/TubeRadius.lean), [OddWitness.lean](../lean/HamiltonsCubic/Results/OddWitness.lean))

```lean
import Mathlib

set_option linter.style.longLine false


namespace HamiltonsCubic.L20Statement

open Real


noncomputable def psi (φ : ℝ) : ℝ := Real.cos φ / (1 - Real.sin φ ^ 3)

theorem psi_at_zero : psi 0 = 1 := by simp [psi]

theorem sStar_bracket :
    (0.54368:ℝ) ^ 3 + 0.54368 ^ 2 + 0.54368 < 1 ∧ 1 < (0.54369:ℝ) ^ 3 + 0.54369 ^ 2 + 0.54369 := by
  constructor <;> norm_num

theorem cos_add_sin_cube_le_one {s c : ℝ} (hs0 : 0 ≤ s) (hsb : s ≤ 0.54368)
    (hc0 : 0 ≤ c) (hc : c ^ 2 = 1 - s ^ 2) : c + s ^ 3 ≤ 1 := by
  have hcubic : s ^ 3 + s ^ 2 + s ≤ 1 := by nlinarith [sStar_bracket.1, sq_nonneg s]
  have hs1 : s < 1 := by nlinarith
  have hkey : s ^ 2 * (1 + s) ≤ 1 - s := by nlinarith
  have hsq : (s * c) ^ 2 ≤ (1 - s) ^ 2 := by nlinarith
  have hsc : s * c ≤ 1 - s := by nlinarith [mul_nonneg hs0 hc0]
  have hone : s * (1 + c) ≤ 1 := by nlinarith
  have hcpos : (0:ℝ) < 1 + c := by linarith
  have hres : (1 - c) * (1 + c) = s ^ 2 := by nlinarith
  nlinarith [mul_nonneg (mul_nonneg hs0 hs0) hc0, sq_nonneg s, mul_nonneg hs0 hc0]


theorem max_le_one_of_sin_le {m φ α γ : ℝ}
    (hcos : 0 ≤ Real.cos φ) (hsin : 0 ≤ Real.sin φ) (hsb : Real.sin φ ≤ 0.54368)
    (hexp : m = Real.cos φ ^ 3 + 3 * Real.cos φ * Real.sin φ ^ 2 * α + Real.sin φ ^ 3 * γ)
    (hα : α ≤ 1 / 3) (hγ : γ ≤ m) : m ≤ 1 := by
  have hpyth : Real.cos φ ^ 2 = 1 - Real.sin φ ^ 2 := by
    have := Real.sin_sq_add_cos_sq φ; linarith
  have hcs : Real.cos φ + Real.sin φ ^ 3 ≤ 1 :=
    cos_add_sin_cube_le_one hsin hsb hcos hpyth
  have hsin3 : 0 ≤ Real.sin φ ^ 3 := by positivity
  have hstep : m ≤ Real.cos φ + m * Real.sin φ ^ 3 := by
    have h1 : 3 * Real.cos φ * Real.sin φ ^ 2 * α ≤ 3 * Real.cos φ * Real.sin φ ^ 2 * (1 / 3) := by
      have : (0:ℝ) ≤ 3 * Real.cos φ * Real.sin φ ^ 2 := by positivity
      nlinarith
    have h2 : Real.sin φ ^ 3 * γ ≤ Real.sin φ ^ 3 * m := by nlinarith
    have h3 : Real.cos φ ^ 3 + 3 * Real.cos φ * Real.sin φ ^ 2 * (1 / 3) = Real.cos φ := by
      nlinarith [hpyth]
    nlinarith
  have hs3lt : Real.sin φ ^ 3 < 1 := by nlinarith
  by_contra hcon
  push_neg at hcon
  nlinarith [mul_pos (sub_pos.mpr hcon) (sub_pos.mpr hs3lt)]


theorem sin_radius_le : Real.sin 0.5748 ≤ 0.54368 := by
  sorry

theorem sin_le_of_le_radius {φ : ℝ} (h0 : 0 ≤ φ) (h : φ ≤ 0.5748) : Real.sin φ ≤ 0.54368 := by
  have hpi : (0.5748:ℝ) ≤ Real.pi / 2 := by nlinarith [Real.pi_gt_three]
  have hmono : Real.sin φ ≤ Real.sin 0.5748 :=
    Real.sin_le_sin_of_le_of_le_pi_div_two (by nlinarith [Real.pi_gt_three]) hpi h
  linarith [sin_radius_le]

theorem trig_nonneg {φ : ℝ} (h0 : 0 ≤ φ) (h : φ ≤ 0.5748) :
    0 ≤ Real.cos φ ∧ 0 ≤ Real.sin φ := by
  have hpi : (0.5748:ℝ) ≤ Real.pi / 2 := by nlinarith [Real.pi_gt_three]
  refine ⟨Real.cos_nonneg_of_mem_Icc ⟨by nlinarith [Real.pi_gt_three], by linarith⟩, ?_⟩
  exact Real.sin_nonneg_of_nonneg_of_le_pi h0 (by nlinarith [Real.pi_gt_three])

theorem max_le_one {m φ α γ : ℝ} (h0 : 0 ≤ φ) (h : φ ≤ 0.5748)
    (hexp : m = Real.cos φ ^ 3 + 3 * Real.cos φ * Real.sin φ ^ 2 * α + Real.sin φ ^ 3 * γ)
    (hα : α ≤ 1 / 3) (hγ : γ ≤ m) : m ≤ 1 :=
  max_le_one_of_sin_le (trig_nonneg h0 h).1 (trig_nonneg h0 h).2
    (sin_le_of_le_radius h0 h) hexp hα hγ

theorem tube_exclusion {m φ α γ : ℝ} (h0 : 0 ≤ φ)
    (hexp : m = Real.cos φ ^ 3 + 3 * Real.cos φ * Real.sin φ ^ 2 * α + Real.sin φ ^ 3 * γ)
    (hα : α ≤ 1 / 3) (hγ : γ ≤ m) (hm : 1 < m) : 0.5748 < φ := by
  by_contra hcon
  push_neg at hcon
  linarith [max_le_one h0 hcon hexp hα hγ]


noncomputable def theta0Sq (n : ℝ) : ℝ := 2 * (n - 1) * (n - 2) / n ^ 2

noncomputable def thetaOddSq (n : ℝ) : ℝ := 2 * (n - 1) * (n - 3) / ((n - 2) * (n + 1))

theorem even_threshold (n : ℝ) (hn : 3 ≤ n) : 3 / 2 < theta0Sq n ↔ 0 < n ^ 2 - 12 * n + 8 := by
  have hn2 : (0:ℝ) < n ^ 2 := by nlinarith
  simp only [theta0Sq]
  rw [lt_div_iff₀ hn2]
  constructor <;> intro h <;> nlinarith

theorem odd_threshold (n : ℝ) (hn : 3 < n) : 3 / 2 < thetaOddSq n ↔ 0 < n ^ 2 - 13 * n + 18 := by
  have hd : (0:ℝ) < (n - 2) * (n + 1) := by nlinarith
  simp only [thetaOddSq]
  rw [lt_div_iff₀ hd]
  constructor <;> intro h <;> nlinarith

theorem thresholds_at_eleven_twelve :
    ((11:ℝ) ^ 2 - 12 * 11 + 8 = -3) ∧ ((12:ℝ) ^ 2 - 12 * 12 + 8 = 8) ∧
    ((11:ℝ) ^ 2 - 13 * 11 + 18 = -4) ∧ ((12:ℝ) ^ 2 - 13 * 12 + 18 = 6) ∧
    ((13:ℝ) ^ 2 - 13 * 13 + 18 = 18) := by
  refine ⟨by norm_num, by norm_num, by norm_num, by norm_num, by norm_num⟩

theorem thresholds_positive (n : ℝ) (hn : 12 ≤ n) :
    0 < n ^ 2 - 12 * n + 8 ∧ 0 < n ^ 2 - 13 * n + 18 := by
  constructor <;> nlinarith

theorem crossover_bracket : (11:ℝ) < 6 + 2 * Real.sqrt 7 ∧ 6 + 2 * Real.sqrt 7 < 12 := by
  have h7 : Real.sqrt 7 ^ 2 = 7 := Real.sq_sqrt (by norm_num)
  have hpos : (0:ℝ) ≤ Real.sqrt 7 := Real.sqrt_nonneg 7
  constructor <;> nlinarith


example : (1:ℝ) = Real.cos 0 ^ 3 + 3 * Real.cos 0 * Real.sin 0 ^ 2 * (1 / 3)
    + Real.sin 0 ^ 3 * 1 := by norm_num

example : (0:ℝ) < 0.5748 ∧ (0.5748:ℝ) < Real.pi / 2 := by
  refine ⟨by norm_num, by nlinarith [Real.pi_gt_three]⟩

end HamiltonsCubic.L20Statement
```

```lean
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith


namespace HamiltonsCubic.TubeRadius

def quartic (s : ℚ) : ℚ := s ^ 4 - 2 * s + 1

def cubic (s : ℚ) : ℚ := s ^ 3 + s ^ 2 + s - 1

theorem quartic_factors (s : ℚ) : quartic s = (s - 1) * cubic s := by
  unfold quartic cubic; ring


theorem cubic_strict_mono {a b : ℚ} (ha : 0 ≤ a) (hab : a < b) : cubic a < cubic b := by
  have key : cubic b - cubic a
      = (b - a) * (b ^ 2 + a * b + a ^ 2 + (b + a) + 1) := by
    unfold cubic; ring
  have h1 : 0 < b - a := by linarith
  have hb : 0 ≤ b := by linarith
  have h2 : 0 < b ^ 2 + a * b + a ^ 2 + (b + a) + 1 := by positivity
  nlinarith [mul_pos h1 h2]

theorem cubic_neg_at_zero : cubic 0 < 0 := by norm_num [cubic]
theorem cubic_pos_at_one : 0 < cubic 1 := by norm_num [cubic]


theorem bracket_lower : cubic (5436 / 10000) < 0 := by norm_num [cubic]
theorem bracket_upper : 0 < cubic (5437 / 10000) := by norm_num [cubic]

theorem root_bracket :
    cubic (5436 / 10000) < 0 ∧ 0 < cubic (5437 / 10000) := ⟨bracket_lower, bracket_upper⟩

theorem bracket_tight :
    cubic (5436890 / 10000000) < 0 ∧ 0 < cubic (5436891 / 10000000) := by
  constructor <;> norm_num [cubic]


theorem no_rational_root_one : cubic 1 ≠ 0 := by norm_num [cubic]
theorem no_rational_root_neg_one : cubic (-1) ≠ 0 := by norm_num [cubic]

theorem candidates_fail : cubic 1 = 2 ∧ cubic (-1) = -2 := by
  constructor <;> norm_num [cubic]


end HamiltonsCubic.TubeRadius
```

```lean
import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring


namespace HamiltonsCubic.OddWitness

def ThetaOddSq (n : ℚ) : ℚ := 2 * (n - 1) * (n - 3) / ((n + 1) * (n - 2))

theorem witness_condition (n : ℚ) (hn : 4 ≤ n) :
    3 / 2 < ThetaOddSq n ↔ 0 < n ^ 2 - 13 * n + 18 := by
  unfold ThetaOddSq
  have hpos : (0:ℚ) < (n + 1) * (n - 2) := by nlinarith
  rw [div_lt_div_iff₀ (by norm_num : (0:ℚ) < 2) hpos]
  constructor <;> intro h <;> nlinarith [h]

theorem threshold_at_twelve :
    (11 : ℚ) ^ 2 - 13 * 11 + 18 = -4 ∧ (12 : ℚ) ^ 2 - 13 * 12 + 18 = 6 := by
  refine ⟨by norm_num, by norm_num⟩

theorem polynomials_differ (n : ℚ) :
    (n ^ 2 - 13 * n + 18) - (n ^ 2 - 12 * n + 8) = 10 - n := by ring

theorem discriminants_differ :
    (13 : ℚ) ^ 2 - 4 * 18 = 97 ∧ (12 : ℚ) ^ 2 - 4 * 8 = 112 ∧ (97 : ℚ) ≠ 112 := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

theorem both_cross_between_eleven_and_twelve :
    (11 : ℚ) ^ 2 - 12 * 11 + 8 = -3 ∧ (12 : ℚ) ^ 2 - 12 * 12 + 8 = 8 := by
  refine ⟨by norm_num, by norm_num⟩

theorem thirteen_witness : ThetaOddSq 13 = 120 / 77 ∧ (3 : ℚ) / 2 < 120 / 77 := by
  refine ⟨by unfold ThetaOddSq; norm_num, by norm_num⟩

end HamiltonsCubic.OddWitness
```

## Definitions and sources

- $\mathcal W_n=\mathrm{Weyl}_n$ is the space of algebraic Weyl tensors on $\mathbb R^n$ with the Frobenius inner product, $Q(W)=W^2+W^\#$, $P(W)=\langle W,Q(W)\rangle$, $T$ its fully symmetric polarisation with $T(X,X,X)=P(X)$, and $u=W_{\mathbb{CP}^2}$ padded to unit norm, with $Q(u)=\theta^*u$.
- $\Theta_n$ is the value of the best two-factor sphere product: $\theta_0(n)$ at even $n$, and $\Theta_n^2=\frac{2(n-1)(n-3)}{(n-2)(n+1)}$ at odd $n$.
- Lemma L21 is a given, as quoted, with the debt its own block records.
- **This task does no numerical work.** Write no scripts and run no computations. An argument or an exact closed form settles the question, and a decimal is not an argument.

## The question

**Prove the step above valid as written, from the passages and standard mathematics, or exhibit in closed form exactly where it fails.** Give the strongest reading the words support, including a hypothesis the author may have meant but not written, and say which hypotheses that reading needs. Return a verdict of VALID or FAILS, with the argument.

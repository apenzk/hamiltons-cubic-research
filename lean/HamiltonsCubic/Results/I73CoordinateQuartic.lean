import Mathlib

set_option linter.style.longLine false

/-!
# The quartic bound on coordinate subspaces: the scalar chain

[The D6 working note](../../../reviews/2026-09-26-I73-class-ceiling.md), batch 24. For a graph on `n` vertices with
adjacency `A`, `e` edges and degrees `dᵢ`, `S = ∑_{i<k} codeg(i,k)² = (tr A⁴ - ∑ dᵢ²)/2`. With `t = tr A² = 2e`:

* the classical bound for a traceless symmetric matrix, `tr A⁴ ≤ c · t²` with `c = (n²-3n+3)/(n(n-1))`
  (the maximum of `∑ xᵢ⁴` under `∑ xᵢ = 0`, `∑ xᵢ² = 1`, one eigenvalue against `n-1` equal ones);
* Cauchy–Schwarz, `∑ dᵢ² ≥ t²/n`.

## What is proved

* `coordinate_quartic`: from those two inequalities, `2S ≤ (n-2)² t² / (n(n-1))`, i.e. `S ≤ (n-2)² e²/N`.

## What is NOT stated

The eigenvalue inequality and Cauchy–Schwarz on the degrees enter as hypotheses, as does the identity
`tr A⁴ = ∑ dᵢ² + 2S`; the reading of `Π#Π` as the codegree diagonal is the note's.
-/

namespace HamiltonsCubic.I73CoordinateQuartic

theorem coordinate_quartic (n t T4 D2 S : ℝ) (hn : 2 < n)
    (hid : T4 = D2 + 2 * S)
    (heig : T4 * (n * (n - 1)) ≤ (n ^ 2 - 3 * n + 3) * t ^ 2)
    (hcs : t ^ 2 ≤ n * D2) :
    2 * S * (n * (n - 1)) ≤ (n - 2) ^ 2 * t ^ 2 := by
  have hn1 : 0 < n - 1 := by linarith
  have hpos : 0 < n * (n - 1) := by positivity
  have h1 : 2 * S * (n * (n - 1)) = T4 * (n * (n - 1)) - D2 * (n * (n - 1)) := by rw [hid]; ring
  have h2 : t ^ 2 * (n - 1) ≤ D2 * (n * (n - 1)) := by nlinarith
  nlinarith

end HamiltonsCubic.I73CoordinateQuartic

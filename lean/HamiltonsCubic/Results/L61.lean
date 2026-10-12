import Mathlib

/-!
# L61, the `M(5) = √(3/2)` certificate, positive-definiteness half

`F₅ = (3/2)‖W‖⁶ - 9 tr(W³)²` is exhibited as a sum of squares by a Gram matrix
that is block diagonal over the `O(5)`-isotypes, sixteen Hermitian blocks of
sizes `3,3,2,1,2,1,2,1,2,2,1,1,1,1,1,1` carrying 47 rational parameters.

The data is `scripts/runs/n5_certificate.json`, transcribed here verbatim, with
the off-diagonals halved, the packing stores `M` where the form is
`(M + diag M)/2`.

Each block is positive definite iff its leading principal minors are positive
(Sylvester). For a Hermitian block those minors are rational, so `norm_num`
settles them in the kernel.

**This file carries the positive-definiteness half only.** The identity half,
that this Gram's sextic *is* `F₅`, is stated at the foot with its support
named, and is not proved here.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.L61

-- block 0, size 3, O(5) label (2, 2)
theorem block0_pd :
    (0:ℚ) < (498801911015797 / 18710981289000000 : ℚ) ∧
    (0:ℚ) < (498801911015797 / 18710981289000000 : ℚ) * (6266112032632873 / 13305586694400000 : ℚ) - ((0 : ℚ)^2 + (-1895855669041799 / 99791900208000000 : ℚ)^2) ∧
    (0:ℚ) < (498801911015797 / 18710981289000000 : ℚ) * (6266112032632873 / 13305586694400000 : ℚ) * (2284484884943 / 71922090240000 : ℚ) - (498801911015797 / 18710981289000000 : ℚ) * ((0 : ℚ)^2 + (162875194582189 / 5322234677760000 : ℚ)^2) - (6266112032632873 / 13305586694400000 : ℚ) * ((249939566535947 / 99791900208000000 : ℚ)^2 + (0 : ℚ)^2) - (2284484884943 / 71922090240000 : ℚ) * ((0 : ℚ)^2 + (-1895855669041799 / 99791900208000000 : ℚ)^2) + 2 * (((0 : ℚ) * (0 : ℚ) - (-1895855669041799 / 99791900208000000 : ℚ) * (162875194582189 / 5322234677760000 : ℚ)) * (249939566535947 / 99791900208000000 : ℚ) + ((0 : ℚ) * (162875194582189 / 5322234677760000 : ℚ) + (-1895855669041799 / 99791900208000000 : ℚ) * (0 : ℚ)) * (0 : ℚ)) := by
  norm_num

-- block 1, size 3, O(5) label (4, 2)
theorem block1_pd :
    (0:ℚ) < (2076396332515639 / 5708102400000000 : ℚ) ∧
    (0:ℚ) < (2076396332515639 / 5708102400000000 : ℚ) * (7458517830502159 / 5779453680000000 : ℚ) - ((11256495459482407 / 34248614400000000 : ℚ)^2 + (0 : ℚ)^2) ∧
    (0:ℚ) < (2076396332515639 / 5708102400000000 : ℚ) * (7458517830502159 / 5779453680000000 : ℚ) * (225792968742749 / 3852969120000000 : ℚ) - (2076396332515639 / 5708102400000000 : ℚ) * ((249176231751809 / 2311781472000000 : ℚ)^2 + (0 : ℚ)^2) - (7458517830502159 / 5779453680000000 : ℚ) * ((2836022042720057 / 51372921600000000 : ℚ)^2 + (0 : ℚ)^2) - (225792968742749 / 3852969120000000 : ℚ) * ((11256495459482407 / 34248614400000000 : ℚ)^2 + (0 : ℚ)^2) + 2 * (((11256495459482407 / 34248614400000000 : ℚ) * (249176231751809 / 2311781472000000 : ℚ) - (0 : ℚ) * (0 : ℚ)) * (2836022042720057 / 51372921600000000 : ℚ) + ((11256495459482407 / 34248614400000000 : ℚ) * (0 : ℚ) + (0 : ℚ) * (249176231751809 / 2311781472000000 : ℚ)) * (0 : ℚ)) := by
  norm_num

-- block 2, size 2, O(5) label (3, 2)
theorem block2_pd :
    (0:ℚ) < (66829 / 100000 : ℚ) ∧
    (0:ℚ) < (66829 / 100000 : ℚ) * (100879 / 6250 : ℚ) - ((0 : ℚ)^2 + (80601 / 50000 : ℚ)^2) := by
  norm_num

-- block 3, size 1, O(5) label (2, 0)
theorem block3_pd : (0:ℚ) < (11319 / 20000 : ℚ) := by norm_num

-- block 4, size 2, O(5) label (2, 1)
theorem block4_pd :
    (0:ℚ) < (2337 / 100000 : ℚ) ∧
    (0:ℚ) < (2337 / 100000 : ℚ) * (2337 / 100000 : ℚ) - ((0 : ℚ)^2 + (0 : ℚ)^2) := by
  norm_num

-- block 5, size 1, O(5) label (3, 0)
theorem block5_pd : (0:ℚ) < (2337 / 100000 : ℚ) := by norm_num

-- block 6, size 2, O(5) label (3, 1)
theorem block6_pd :
    (0:ℚ) < (1171 / 50000 : ℚ) ∧
    (0:ℚ) < (1171 / 50000 : ℚ) * (12809 / 25000 : ℚ) - ((0 : ℚ)^2 + (503 / 200000 : ℚ)^2) := by
  norm_num

-- block 7, size 1, O(5) label (4, 0)
theorem block7_pd : (0:ℚ) < (2337 / 100000 : ℚ) := by norm_num

-- block 8, size 2, O(5) label (4, 1)
theorem block8_pd :
    (0:ℚ) < (8601 / 100000 : ℚ) ∧
    (0:ℚ) < (8601 / 100000 : ℚ) * (127 / 4000 : ℚ) - ((-573 / 50000 : ℚ)^2 + (0 : ℚ)^2) := by
  norm_num

-- block 9, size 2, O(5) label (4, 3)
theorem block9_pd :
    (0:ℚ) < (1637585551 / 633600000 : ℚ) ∧
    (0:ℚ) < (1637585551 / 633600000 : ℚ) * (4927 / 20000 : ℚ) - ((35803 / 200000 : ℚ)^2 + (0 : ℚ)^2) := by
  norm_num

-- block 10, size 1, O(5) label (4, 4)
theorem block10_pd : (0:ℚ) < (2337 / 100000 : ℚ) := by norm_num

-- block 11, size 1, O(5) label (5, 2)
theorem block11_pd : (0:ℚ) < (2337 / 100000 : ℚ) := by norm_num

-- block 12, size 1, O(5) label (3, 3)
theorem block12_pd : (0:ℚ) < (3283 / 2500 : ℚ) := by norm_num

-- block 13, size 1, O(5) label (5, 1)
theorem block13_pd : (0:ℚ) < (2337 / 100000 : ℚ) := by norm_num

-- block 14, size 1, O(5) label (5, 3)
theorem block14_pd : (0:ℚ) < (2337 / 100000 : ℚ) := by norm_num

-- block 15, size 1, O(5) label (6, 3)
theorem block15_pd : (0:ℚ) < (2337 / 100000 : ℚ) := by norm_num

/-! ## The identity half, unproved

The Gram above reproduces `F₅` only if evaluation at the 40 sample points used
to solve for it is injective on `(Sym⁶ 𝒲₅)^O(5)`, which is 14-dimensional.
The record's support for that injectivity is a **floating-point** rank: 120
explicit invariant sextics evaluated at the 40 points give numerical rank 14
against a cap of 14, read off a singular-value gap.

Closing this in Lean means an exact rank over `ℚ` of that 120 × 40 evaluation
matrix, which needs the invariant sextics as data. They are not in the record.
-/

end HamiltonsCubic.L61

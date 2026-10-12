import HamiltonsCubic.Base.Families

set_option linter.style.longLine false

/-!
# The positive scale that makes a diagonal operator's norm one is unique

**This is the last piece `L74Bridge` was missing, and it is not about curvature at all.**

*The bridge is handed an arbitrary `t > 0` with `normSq (diagOp (t • w)) = 1`, while
[L74Statement.lean](L74Statement.lean)'s witness theorem carries a NAMED square root. Those two
scales have to be the same number before the theorem can be applied to the operator in hand.*

**They are, and the reason is that `normSq` on `diagOp` is homogeneous of degree two**, which
[Families.lean](../Base/Families.lean)'s `diagOp_normSq_smul` already proves. *Two positive
numbers whose squares agree are equal, so the scale is pinned by the normalisation and nothing
else about the operator enters.*

*Written as its own file rather than inside the bridge's, because the statement is about a
positive real and a degree-two function and mentions no curvature object.*
-/

namespace HamiltonsCubic.Results

open Matrix HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **TWO POSITIVE SCALES THAT BOTH NORMALISE THE SAME WEIGHT ARE EQUAL.**

*Only symmetry and hollowness of `w` enter, which is what `diagOp_normSq_smul` asks for, and they
are properties of the weight rather than of either scale.* -/
theorem scale_unique_of_normSq_one {w : Matrix ι ι ℝ}
    (hw : ∀ a b, w a b = w b a) (hh : ∀ a, w a a = 0)
    {s t : ℝ} (hs : 0 < s) (ht : 0 < t)
    (hsn : normSq (diagOp (s • w)) = 1) (htn : normSq (diagOp (t • w)) = 1) :
    s = t := by
  rw [diagOp_normSq_smul s w hw hh] at hsn
  rw [diagOp_normSq_smul t w hw hh] at htn
  have hsq : s ^ 2 = t ^ 2 := by
    rcases eq_or_ne (normSq (diagOp w)) 0 with h0 | h0
    · rw [h0] at hsn; norm_num at hsn
    · field_simp at hsn htn
      nlinarith [hsn, htn]
  nlinarith [hsq, hs, ht]

end HamiltonsCubic.Results

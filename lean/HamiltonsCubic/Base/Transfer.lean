import HamiltonsCubic.Base.RoundTrip
import HamiltonsCubic.Base.CP2
import HamiltonsCubic.Results.L33
import HamiltonsCubic.Results.L34
import HamiltonsCubic.Results.L34c

/-!
# The transfer: a matrix witness becomes a map witness

The last link. With the round trip and the orthonormal basis, a pair-basis
operator's own symmetry gives `IsWeylOf`'s narrowed clause, and the two named
witnesses cross into the encoding where the structural theorems live.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Base

open Matrix

/-- **`W_{ℂP²}` is a Weyl operator in the map encoding.** -/
theorem WCP2_isWeylOf : IsWeylOf (ofMatrix WCP2) :=
  ⟨fun _ _ hX hY => ofMatrix_symm WCP2_isSymm hX hY, WCP2_bianchiOf, WCP2_RicOf⟩

/-- And so is [L33](../Results/L33.lean)'s witness. -/
theorem W33_isWeylOf : IsWeylOf (ofMatrix W33) :=
  ⟨fun _ _ hX hY => ofMatrix_symm W33_isSymm hX hY, W33_bianchiOf, W33_RicOf⟩

/-- **The sum of the two is a Weyl operator**, by L34's closure, the first time
a named witness and a structural theorem meet. -/
theorem WCP2_add_W33_isWeylOf :
    IsWeylOf (fun X => ofMatrix WCP2 X + ofMatrix W33 X) :=
  WCP2_isWeylOf.add W33_isWeylOf

end HamiltonsCubic.Base

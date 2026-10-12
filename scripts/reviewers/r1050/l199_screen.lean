import HamiltonsCubic.Results.L199Statement

open Matrix HamiltonsCubic.Base HamiltonsCubic.Results

/-- The residual of `G_eq_sharp` at `R`: zero exactly when the claim holds there. -/
def resid (R : Matrix (Fin 6) (Fin 6) ℚ) : Matrix (Fin 6) (Fin 6) ℚ :=
  Matrix.of fun j k => Gmat R j k - (4 * sharpBil (R * R) 1 j k - 4 * sharpMat R j k)

/-- A second symmetric test matrix, independent of `diagTest`. -/
def testB : Matrix (Fin 6) (Fin 6) ℚ :=
  Matrix.of fun a b =>
    if a = b then (a.val + 1 : ℚ) / 3
    else (a.val + b.val : ℚ) / 7 - 1

/-- A third, with negative and zero entries. -/
def testC : Matrix (Fin 6) (Fin 6) ℚ :=
  Matrix.of fun a b =>
    if a = b then (if a.val % 2 = 0 then (2 : ℚ) else -3)
    else if a.val + b.val = 5 then (1 : ℚ)/2 else 0

/-- All 36 residual entries at `R`, as a list of rows. -/
def residRows (R : Matrix (Fin 6) (Fin 6) ℚ) : List (List ℚ) :=
  (List.finRange 6).map (fun j => (List.finRange 6).map (fun k => resid R j k))

/-- Is `R` symmetric? A vacuous screen is the trap here: the claim binds `R.IsSymm`. -/
def isSymmCheck (R : Matrix (Fin 6) (Fin 6) ℚ) : Bool :=
  (List.finRange 6).all (fun a => (List.finRange 6).all (fun b => decide (R a b = R b a)))

#eval "symmetry of diagTest, testB, testC (all must be true, or the screen is vacuous)"
#eval (isSymmCheck diagTest, isSymmCheck testB, isSymmCheck testC)
#eval "A: diagTest, all 36 residual entries"
#eval residRows diagTest
#eval "B: testB, all 36 residual entries"
#eval residRows testB
#eval "C: testC, all 36 residual entries"
#eval residRows testC
#eval "NULL CONTROL: a deliberately wrong right-hand side must NOT give zeros"
#eval (List.finRange 6).map (fun j => (List.finRange 6).map (fun k =>
  Gmat testB j k - (4 * sharpBil (testB * testB) 1 j k - 5 * sharpMat testB j k)))

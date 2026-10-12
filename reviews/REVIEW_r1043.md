# r1043: the repair of the I106b face statement, audited, and the general statement is STILL FALSE

**Scope.** `6eff524e` and `64005452`, both on [I106bFace.lean](../lean/HamiltonsCubic/Results/I106bFace.lean), plus the rows they wrote in [lean/INDEX.md](../lean/INDEX.md), [plan.md](../plan.md) and [ATTEMPTS.md](../ATTEMPTS.md).

**Log.** [agent_logs/r-i106b-repair.log](../agent_logs/r-i106b-repair.log)

**The headline is a second refutation of the same declaration.** [zero_diag_critical_is_isSignedPerm](../lean/HamiltonsCubic/Results/I106bFace.lean) carries `CriticalityGeneric` now and is FALSE at `k = 5` regardless: a zero-diagonal orthogonal `Q` with every off-diagonal entry at least `0.116` in modulus, `ν` injective with minimum gap `0.311`, and every complementary weight gap at least `0.050`, satisfying the criticality relation at all twenty-five `(l,m)` and failing `IsSignedPerm`. The repair fixed `k = 4` and left the defect it was made to remove standing one dimension higher.

| # | claim | verdict |
|---|---|---|
| 1 | `CriticalityGeneric` excludes both refuting witnesses, for the stated reason | **CONFIRMED**, in exact rational arithmetic, with the failing clause and indices named |
| 2 | the hypothesis set of `zero_diag_critical_is_isSignedPerm_four` is inhabited | **CONFIRMED**, one explicit quadruple, all twenty-four scalar conditions checked |
| 3 | `isSignedPerm_of_rows_disjoint` is correct at every `k` and means what it says | **CONFIRMED.** The hypothesis is exactly `q_l ∘ q_m = 0` for `l ≠ m`, and unit COLUMNS carry the injectivity |
| 4 | `zero_diag_critical_is_isSignedPerm_four` has no `sorry` beneath it | **CONFIRMED** by `#print axioms` on all twenty-nine declarations of the file |
| 5 | the corrected attribution of the dimension count is right | **CONFIRMED**, and sharpened: at `k = 5` a nonvanishing `h_lm` must have FULL support on its complement |
| 6 | Jin Theorem 1(i) follows from `row_offdiag_eq_sq_sub_quartic` plus orthonormality | **CONFIRMED.** Unit rows give the bound, unit COLUMNS give the equality case |
| 7 | the general-`k` statement is no longer false under its new hypotheses | **REFUTED at `k = 5`**, by an explicit witness carried to 60 digits, residual `5e-62` against margins of `5e-2` |

## 1. The `k = 5` counterexample

**Take `β = 1` and, to twenty digits,**

```
nu = ( 0,
       1,
      -1.0730005703177699767,
       0.5836238129143659775,
      -0.7617495618959574845 )

u  = (-0.2851088669233858098, -0.4284747344351851934, -0.0973756367260459615,
       0.4692057127774182067,  0.3417535253071987580 )

c  = (-0.0076747257258022922, -0.4576072484143468650,  0.3559045209716415579,
      -0.0979183038345809117,  0.2072957570030885110 )

Q  = [ 0                      0.3708536103913555688 -0.6455680744943662175 -0.3333600600127459413 -0.5784293658188798278
       0.3359332542439948809  0                     -0.5896845045222959788 -0.1163419014082557667  0.7251796989685008299
      -0.5767105380746792444 -0.3892942545812732253  0                     -0.7013872554214502938  0.1546313569622604631
      -0.4541737386991793340  0.8078893344536610210  0.1594303043517675158  0                      0.3400338459717399893
       0.5901525387920168976  0.2413139164775378696  0.4583623287032143343 -0.6191862000217506178  0                    ]
```

**Every hypothesis of the declaration holds and the conclusion fails.** At 60 working digits, after Newton refinement on a square 18-by-18 slice of the defining system:

| hypothesis | check |
|---|---|
| `2 ≤ k` | `k = 5` |
| `Q * Qᵀ = 1` | `max ¦(QQᵀ − I)_ij¦ = 5.0e−62` |
| `∀ i, Q i i = 0` | `max ¦Q_ii¦ = 3.4e−62` |
| `Function.Injective nu` | `min ¦ν_i − ν_j¦ = 0.31125` |
| the weight clause of `CriticalityGeneric` | `min ¦w_a − w_b¦ = 0.05031`, over ALL `(l,m,a,b)` with `a,b ∉ {l,m}` and `a ≠ b`, `l = m` included |
| `hcrit` at all 25 `(l,m)` | `max residual = 5.4e−62`, against `max ¦X_lm¦, ¦Y_lm¦ ≈ 0.19` |
| **conclusion** `IsSignedPerm Q` | **FAILS.** Row `0` carries four nonzero entries, `‖Q‖₄⁴ = 1.9018` against `k = 5` |

**The most faithful check is upstream of the typed relation.** Building `A_{ik} = u_i(βν_k²) + c_i ν_k` directly and forming `Qᵀ(A ∘ Q)` gives a matrix symmetric to `8.5e−41`, so `Q` is a genuine critical point of `f(Q) = ⟪A, Q ∘ Q⟫` on `O(5)` by the file's own [first_order_antisymm](../lean/HamiltonsCubic/Results/I106bFace.lean), with the whole of `CriticalityGeneric` in force.

**Epistemic status of the witness, stated plainly.** It is a verified numerical witness and not an exact rational one, because the solution variety is cut out by three algebraic conditions whose real points are irrational. What makes it a refutation rather than a near-miss: the defining system was solved by Newton to residual `4e−62` from a float start at `2e−16`, the Jacobian of the square slice at the solution has smallest singular value `1.8e−3` and condition number `1.2e3`, so Newton-Kantorovich puts an exact real solution within about `1e−59` of the printed point, and every hypothesis that could fail under perturbation is an OPEN condition with margin at least `5e−2`. The conclusion fails by `3.1` in `‖Q‖₄⁴`. Certifying this with interval arithmetic, or finding an exact algebraic witness, is a worthwhile follow-up and would change nothing in the verdict.

**It costs [face_hands_down](../lean/HamiltonsCubic/Results/I106bFace.lean) nothing, exactly as r1041's witness did not.** The value at the witness is `0.3828`, while the best signed permutation on the same `A` gives `1.4688`, so the critical point is nowhere near maximal. What falls is the ROUTE at `k ≥ 5`: first-order information plus genericity of this shape does not separate, and only the `k = 4` case survives.

### Why the witness looks the way it does, and why a smaller one could not exist

**A structural lemma, proved by hand, predicts its shape.** At `k = 5` the complement of a pair `{l,m}` is three coordinates `{a,b,d}`, and `h_lm` restricted there satisfies `h_a + h_b + h_d = 0` and `w_a h_a + w_b h_b + w_d h_d = 0` with `w_a, w_b, w_d` pairwise distinct by the weight clause. That two-by-three system has a one-dimensional kernel spanned by `(w_b − w_d, w_d − w_a, w_a − w_b)`, whose three entries are ALL nonzero. **So a nonvanishing `h_lm` has full support on its complement**, and the following are forced at `k = 5`:

- every off-diagonal entry of `Q` is nonzero, since `Q_il = 0` for one `i ≠ l` would put a zero in the complementary support of `h_lm` for every `m ∉ {l,i}` and collapse all of them;
- the pair graph is complete or empty, the empty case being the signed permutations;
- a block construction cannot work. Putting r1041's `4 × 4` witness beside a `2 × 2` swap at `k = 6` gives `h_lm` of complementary support two, which needs `w_a = w_b` and is exactly what the weight clause forbids.

The witness has all twenty off-diagonal entries nonzero, minimum modulus `0.116`, and every one of its ten Hadamard products has exactly three nonzeros. **It occupies the `k − 4 = 1` free dimension the file's own docstring identifies**, which is why the count in that docstring is right and its conclusion, that the statement is merely OPEN there, is wrong.

**The parameter count agrees.** Zero-diagonal orthogonal `Q` at `k = 5` is a `5`-dimensional family, `ν` contributes `3` after its shift and scale are absorbed, the rank-drop that a nonconstant `(u,c)` requires is `3` conditions on a map from a `4`-dimensional space to a `6`-dimensional one, and the symmetry group acting on `(β,ν,u,c)` has dimension `5`. Solutions of dimension `5` are expected, and were found.

## 2. Claim 1, the exclusion mechanism, checked index by index

**Both witnesses are excluded, each by the clause its own docstring names, at the indices that carry the failure.** Exact rational arithmetic, `fractions.Fraction`, on the published witnesses.

| witness | clause that fails | where |
|---|---|---|
| r1040, `ν ≡ 0` | `Function.Injective nu` | all six index pairs |
| r1040, `ν = (1/2, 1/2, −6/5, 12/5)` | `Function.Injective nu` | the pair `(0,1)`, which is the pair whose criticality factor vanishes |
| r1041, `ν = (0,1,2,3)`, `u = (1,0,1,2)`, `c = (0,5,3,7)` | the weight clause ONLY | `(l,m,a,b) = (2,3,0,1)` and its three relabellings, `w = (5,5,8,17)` |

**The r1041 witness passes clause one.** Its `ν` is injective, and its criticality residuals are all exactly zero, so the weight clause is doing the work alone, at exactly the surviving pair `{2,3}` whose complement is `{0,1}`. **Nothing is excluded by accident**: in each case the clause that fails is the one that would have been divided by or inverted in the collapse.

## 3. Claim 2, vacuity, with a complete quadruple

**Take `β = 1`, `ν = (0,1,2,3)`, `u = (0,1,3,7)`, `c = (0,2,5,11)` and the signed 4-cycle**

```
Q = [ 0  1  0  0 ]
    [ 0  0  1  0 ]
    [ 0  0  0 -1 ]
    [ 1  0  0  0 ]
```

In exact rational arithmetic: `Q Qᵀ = I`, the diagonal is zero, all twenty-five criticality expressions are exactly `0`, `ν` is injective on all six pairs, and the weight clause holds at all eighteen distinct `({l,m},{a,b})` instances. **So the hypothesis set of [zero_diag_critical_is_isSignedPerm_four](../lean/HamiltonsCubic/Results/I106bFace.lean) is inhabited and the theorem is not vacuous.** The docstring's "holds off a proper closed set of `(β, ν, u, c)`" is right, the failure locus being a finite union of hyperplanes in `(u,c)` for each fixed `(β,ν)`.

**But the advertised COUNT of that cost is wrong, and the fix is one binder.** [CriticalityGeneric](../lean/HamiltonsCubic/Results/I106bFace.lean) quantifies `∀ l m a b` with no `l ≠ m`, so the case `l = m` is included and the weight vector `β(2ν_l)u + c` must separate all three complementary indices as well. At `k = 4` that is `6` injectivity conditions plus `6 + 12 = 18` weight conditions, **twenty-four distinct scalar conditions rather than the twelve claimed in the commit message, in [lean/INDEX.md](../lean/INDEX.md), in [plan.md](../plan.md) and in [ATTEMPTS.md](../ATTEMPTS.md)**. The `k = 4` proof invokes `hwsep` only at `l ≠ m`, so adding `l ≠ m →` to the definition costs the proof nothing and makes "twelve" exactly right. Recommended.

## 4. Claim 3, what the disjointness lemma says and what it proves

**The hypothesis is the intended one.** `∀ i l m, l ≠ m → Q i l * Q i m = 0` quantifies over a ROW index and two distinct COLUMN indices, which is `q_l ∘ q_m = 0` for every `l ≠ m` read one coordinate at a time, and equivalently that no row carries two nonzero entries. The docstring states both readings and both are correct.

**The conclusion is the intended one.** [IsSignedPerm](../lean/HamiltonsCubic/Results/I106bFace.lean) says `Q i j = if j = σ i then ε i else 0` with `ε i = ±1`, one nonzero per row at `σ i` of modulus one. The proof chooses `f i` with `Q i (f i) ≠ 0`, kills the rest of the row from the hypothesis, gets `Q i (f i)² = 1` from the unit row sum, and `Equiv.ofBijective f _` unfolds to `f`, so the permutation produced is the one the statement claims.

**The injectivity of `f` is where orthonormality of the COLUMNS enters, and it is load-bearing.** Two rows sharing a column would put two unit squares in that column against `∑_i Q i j ² = 1`, which comes from `Qᵀ * Q = 1` via `mul_eq_one_comm`. Without it the lemma is false: `[[1,0],[1,0]]` has unit rows and disjoint row supports and is not a signed permutation. The friction r1041 flagged, `Q * Qᵀ = 1` against `Qᵀ * Q = 1`, is discharged inside the lemma.

**At `k = 0` the lemma is vacuously true and at `k = 1` it is true with a free hypothesis**, since no distinct `l, m` exist there and the conclusion comes from `hQ` alone. Neither matters: the statement is consumed at `k = 4`, and `2 ≤ k` is carried by the callers that need it.

## 5. Claim 4, axioms

`#print axioms` appended to the source, run with `lake env lean` on the file itself so no stale `.olean` could answer, then the file restored. **All twenty-nine declarations report.** Exactly two carry `sorryAx`, [face_hands_down](../lean/HamiltonsCubic/Results/I106bFace.lean) and [zero_diag_critical_is_isSignedPerm](../lean/HamiltonsCubic/Results/I106bFace.lean), both named as open in the file. The other twenty-seven depend on `propext`, `Classical.choice` and `Quot.sound` alone, [zero_diag_critical_is_isSignedPerm_four](../lean/HamiltonsCubic/Results/I106bFace.lean) and [isSignedPerm_of_rows_disjoint](../lean/HamiltonsCubic/Results/I106bFace.lean) among them. **No declaration outside the two depends on either `sorry`.**

## 6. Claim 5, the count redone from the declarations

| condition on `h_lm`, `l ≠ m` | source | dimensions removed |
|---|---|---|
| `h_lm(l) = h_lm(m) = 0` | `hadamard_vanishes_at_own_indices`, structural at any zero-diagonal `Q` | ambient `k` drops to `k − 2` |
| `⟨h_lm, 1⟩ = 0` | `hadamard_inner_one`, orthogonality of the columns | one, for `k ≥ 3` |
| `⟨h_lm, β(ν_l+ν_m)u + c⟩ = 0` | criticality, after cancelling `(ν_m − ν_l)` | one, and one only |

**`(k − 2) − 2 = k − 4`, with orthogonality removing one and criticality one.** The corrected attribution is right. Two conditionals sit inside it and both are now carried by `CriticalityGeneric`: the criticality row is empty unless `ν_l ≠ ν_m`, and the second removal is a removal only if `w` restricted to the complement is nonconstant, which is the weight clause. **The count is a bound on the SPACE that `h_lm` may occupy and not a proof that it is occupied**, which is why `k = 4` closes and why the `k = 5` witness of section 1 is the expected object rather than a surprise.

## 7. Claim 6, Jin Theorem 1(i) from the file's own identity

**Re-derived from scratch, and it holds.** [row_offdiag_eq_sq_sub_quartic](../lean/HamiltonsCubic/Results/I106bFace.lean) at the `i`th row gives `∑_{l≠m} q_il² q_im² = (∑_l q_il²)² − ∑_l q_il⁴`. Summing over rows with `∑_l q_il² = 1` gives `∑_i ∑_{l≠m} q_il² q_im² = k − ‖Q‖₄⁴`. The left side is a sum of squares, so **`‖Q‖₄⁴ ≤ k`**, and equality holds exactly when `q_il q_im = 0` for every row and every `l ≠ m`, which is the hypothesis of [isSignedPerm_of_rows_disjoint](../lean/HamiltonsCubic/Results/I106bFace.lean). That lemma returns the signed permutation, and a signed permutation has `‖Q‖₄⁴ = k`, closing the iff.

**Where orthonormality really enters, since the brief asked for the quiet step.** The bound needs unit ROWS only. The equality case needs unit COLUMNS as well, inside the disjointness lemma, and without them "every Hadamard product vanishes" does NOT give a signed permutation. The file supplies both from `Q * Qᵀ = 1`, so **dropping the citation for part (i) is honest**, and the source's contribution to this item is its parts (ii) and (iii).

## 8. Overreach sweep, sentence by sentence

**Every quoted sentence below is one the declarations do not support.**

1. In the file, on [zero_diag_critical_is_isSignedPerm](../lean/HamiltonsCubic/Results/I106bFace.lean): *"At `k ≥ 5` the two conditions per pair act on `k - 2` coordinates and leave `k - 4` free, so no genericity of this shape can close it and this statement is OPEN rather than nearly proved."* **The diagnosis is exactly right and the conclusion is wrong.** The statement is FALSE at `k = 5`, not open, and it is false because the `k − 4` free dimension is occupied. The declaration should be restricted to `k = 4`, which is `zero_diag_critical_is_isSignedPerm_four` and already proved, or deleted.

2. In [lean/INDEX.md](../lean/INDEX.md): *"from `k=5` the count leaves `k-4>0` and no genericity of this shape closes it"*, in the same place as 1 and wrong the same way.

3. In [plan.md](../plan.md): *"What is OWED now is the `k = 4` proof and then the general case, where the two conditions leave `k-4` coordinates alive."* **Both halves are stale.** The `k = 4` proof landed in `64005452`, which did not touch [plan.md](../plan.md), and the general case is not owed, it is refuted.

4. In the commit message of `6eff524e`, in [lean/INDEX.md](../lean/INDEX.md), in [plan.md](../plan.md) and in [ATTEMPTS.md](../ATTEMPTS.md): *"twelve scalar conditions at `k = 4`"*. **Twenty-four, as [CriticalityGeneric](../lean/HamiltonsCubic/Results/I106bFace.lean) is written**, because `l = m` is not excluded. Section 3 has the arithmetic and the one-binder repair.

5. In [lean/INDEX.md](../lean/INDEX.md): *"Gate 2 CLEARED by r1040 and r1041"*. Those readers cleared the version they read. **The repaired general statement was written after both reports and has never been reviewed until now**, which is how a refuted proposition survived a cleared gate.

6. A transient, already repaired at HEAD and recorded for the pattern. `64005452` took the file from three `sorry` to two and updated the [lean/INDEX.md](../lean/INDEX.md) row, but left [plan-lean.md](../plan-lean.md) at `57 open sorry` with a phantom table row for `zero_diag_critical_is_isSignedPerm_four`. A later regeneration fixed both.

**Claims in those passages that DO hold.** The `M Mᵀ = 3I` arithmetic on r1040's witness and the six residuals of r1041's, the attribution of one dimension to orthogonality and one to criticality, the "not vacuous" paragraph on the `k = 4` theorem, the account of what `isSignedPerm_of_rows_disjoint` proves, and the Jin part (i) claim. All checked above.

## 9. What to do

1. **Restrict [zero_diag_critical_is_isSignedPerm](../lean/HamiltonsCubic/Results/I106bFace.lean) to `k = 4`, which means deleting it**, since `zero_diag_critical_is_isSignedPerm_four` already is that statement and is proved. Leaving a false proposition behind a `sorry` is the exact defect `6eff524e` was written to remove.
2. **Add `l ≠ m →` to [CriticalityGeneric](../lean/HamiltonsCubic/Results/I106bFace.lean)**, which costs the `k = 4` proof nothing and makes the advertised count of twelve conditions true.
3. **Record the structural lemma of section 1** as the reason the first-order route stops at `k = 4`: at `k = 5` a nonvanishing Hadamard product has full complementary support, so every off-diagonal entry of `Q` is nonzero and the pair graph is complete, and that regime is inhabited.
4. **The route needs maximality at `k ≥ 5`.** The witness is critical and far from maximal, `0.3828` against `1.4688`, which is r1041's recommendation 2 arriving by a second road.

## 10. How the analysis-only rule was honoured

**No sweep, no census, no unbounded hunt.** The structural lemma, the parameter count, the exclusion mechanism, the dimension count and the Jin derivation are all by hand. The computation was bounded in advance and stated in advance: a search over a three-parameter `ν` and a ten-parameter skew chart for the vanishing of one singular value, which is the "solve the system of known size" the brief authorised, followed by a Newton refinement of an eighteen-by-eighteen square system. Every run finished in minutes.

- Exact rational arithmetic, `fractions.Fraction`, for sections 2 and 3, which is where the verdicts on claims 1 and 2 rest.
- One Lean invocation, `lake env lean` on the file itself with `#print axioms` appended and the file restored afterwards, never `lake build`, never concurrent with another.
- The `k = 5` witness came from a bounded numerical search and is reported as a verified numerical witness with its margins, its residual and its Jacobian conditioning, not as an exact object. Section 1 says so in those words.

# Review r848, I36DiagTest.lean against the claim its index row makes

**This round was a single comparison, not an argument check.** The question asked was whether [I36DiagTest.lean](../lean/HamiltonsCubic/Results/I36DiagTest.lean) states the result its row in [lean/INDEX.md](../lean/INDEX.md) line 95 claims it states, measured against parts (i) and (ii) of the I36 block at [findings/diagonal-half.md](../findings/diagonal-half.md) lines 1082 to 1099. No proof was audited for mathematical correctness. The file was built, its declarations were run through `#print axioms` and `#print`, and one throwaway file was compiled to test vacuity and to test the sorried statement, then deleted. Log: [agent_logs/g2-lean-r848.log](../agent_logs/g2-lean-r848.log).

**Everything below that is called a check was machine-checked by the Lean kernel.** Nothing here rests on a numerical run, and no search, sweep or census was opened.

## Claim table

| # | Claim under test | Verdict |
| --- | --- | --- |
| 1 | Build is clean, and `sorryAx` reaches exactly one declaration | **CONFIRMED**, because there are three `unusedSectionVars` warnings and one `declaration uses sorry` at line 78, and only [alt_pow_iff_alt_proj](../lean/HamiltonsCubic/Results/I36DiagTest.lean#L78) carries `sorryAx` |
| 2 | [bianchi_diagOp_pow](../lean/HamiltonsCubic/Results/I36DiagTest.lean#L68) states part (i) | **REFUTED AS STATED**, because its subject is the diagonal operator of the entrywise power, never a power of an operator, and quantified over all symmetric `w` it is logically identical to [diagOp_bianchi](../lean/HamiltonsCubic/Base/Families.lean#L190) with `hpow w k` substituted for `w` |
| 3 | The row's dependency list, "from `diagOp_comp`, `diagOp_iterate` and `hpow_symm`" | **REFUTED**, because the printed proof term is `diagOp_bianchi (hpow w k) (hpow_symm hw k) i j l m`, so [diagOp_iterate](../lean/HamiltonsCubic/Results/I36DiagTest.lean#L52) is unused and [diagOp_comp](../lean/HamiltonsCubic/Results/I36DiagTest.lean#L41) is unused by every declaration in the repository |
| 4 | `Alt` and `bianchi` agree up to a nonzero factor, so the currency is harmless | **CONFIRMED**, because [altCoeff_eq_third_bianchi](../lean/HamiltonsCubic/Base/AltPart.lean#L383) is `rfl`, and the factor is `1/3`. The file should still state the `Alt` form, because (ii) is stated in `altCoeff` and (i) in `bianchi`, so the two halves of one result speak different languages |
| 5 | "At every dimension", from the binders | **CONFIRMED**, because the binders are `ι : Type*` with `[Fintype ι] [DecidableEq ι]`, both genuinely used by the theorem that carries the claim, and the three helper lemmas carry them unused |
| 6 | The hypotheses admit a nonzero object | **CONFIRMED, NOT VACUOUS**, because the four-cycle weight at `n = 4` is a full [IsWeight](../lean/HamiltonsCubic/Base/Families.lean#L153), its operator sends `phi 0 1` to a matrix with entry `1`, and its entrywise square is still nonzero |
| 7 | `hpow` is the entrywise power with the right base case | **CONFIRMED**, because `hpow w 0` is all-ones, `diagOp (hpow w 0)` is the identity, and [diagOp_iterate](../lean/HamiltonsCubic/Results/I36DiagTest.lean#L52) at `k = 0` proves it agrees with `(diagOp w)^[0]`. No off-by-one |
| 8 | [alt_pow_iff_alt_proj](../lean/HamiltonsCubic/Results/I36DiagTest.lean#L78) is part (ii) | **REFUTED**, because `P` carries no projector hypothesis and the stated `iff` is FALSE, a Lean proof of `False` from it compiled, depending on `sorryAx` and nothing else beyond the standard three |
| 9 | The row's "what the file does NOT state" clause is accurate and complete | **REFUTED**, because it omits the false dependency list, omits that (i)'s bridge is never composed with (i)'s conclusion, omits that the quantifier is over symmetric weights rather than the record's locus, and omits that the sorried proposition is refutable. The file's own docstring also calls the converse "open" where the record has it FALSE off the Weyl cone |
| 10 | `native_decide` | **CONFIRMED ABSENT**, with no occurrence in the file, and the one proved theorem is a term-mode application, kernel-checked |

## Summary, one line an editor can act on

**The file's proved half is [diagOp_bianchi](../lean/HamiltonsCubic/Base/Families.lean#L190) wearing a decorative `k`, since no declaration in it states that a power of a diagonal operator is Bianchi-free and the bridge lemma that would make it one is proved and then never used, and the file's sorried half is a proposition from which `False` compiles, so the row must stop crediting the dependency and must record that the owed statement is false as written.**

## 1. The build, and where `sorryAx` reaches

`lake env lean HamiltonsCubic/Results/I36DiagTest.lean` exits `0`. Four warnings, no errors:

- `unusedSectionVars` at line 41 ([diagOp_comp](../lean/HamiltonsCubic/Results/I36DiagTest.lean#L41)), line 52 ([diagOp_iterate](../lean/HamiltonsCubic/Results/I36DiagTest.lean#L52)) and line 64 ([hpow_symm](../lean/HamiltonsCubic/Results/I36DiagTest.lean#L61)), each naming both `[Fintype ι]` and `[DecidableEq ι]` and each suggesting an `omit`.
- `declaration uses 'sorry'` at line 78, which is [alt_pow_iff_alt_proj](../lean/HamiltonsCubic/Results/I36DiagTest.lean#L78).

`#print axioms` on all five declarations, from a scratch file since deleted:

| Declaration | Axioms |
| --- | --- |
| [diagOp_comp](../lean/HamiltonsCubic/Results/I36DiagTest.lean#L41) | `propext, Classical.choice, Quot.sound` |
| [diagOp_iterate](../lean/HamiltonsCubic/Results/I36DiagTest.lean#L52) | `propext, Classical.choice, Quot.sound` |
| [hpow_symm](../lean/HamiltonsCubic/Results/I36DiagTest.lean#L61) | `propext, Classical.choice, Quot.sound` |
| [bianchi_diagOp_pow](../lean/HamiltonsCubic/Results/I36DiagTest.lean#L68) | `propext, Classical.choice, Quot.sound` |
| [alt_pow_iff_alt_proj](../lean/HamiltonsCubic/Results/I36DiagTest.lean#L78) | `propext, sorryAx, Classical.choice, Quot.sound` |

**So the row's "No `sorry` in any of the four" is true, and there is no `sorry` hiding behind a name.** That is the one part of the row this round confirms without qualification.

## 2. What `bianchi_diagOp_pow` actually says

The printed statement, verbatim from `#print`:

```
theorem HamiltonsCubic.Results.bianchi_diagOp_pow.{u_1} : ∀ {ι : Type u_1} [inst : Fintype ι]
  [inst_1 : DecidableEq ι] (w : Matrix ι ι ℝ), (∀ (a b : ι), w a b = w b a) →
  ∀ (k : ℕ) (i j l m : ι), bianchi (diagOp (hpow w k)) i j l m = 0
```

The subject is `diagOp (hpow w k)`, the coordinate-diagonal operator whose weight is the entrywise `k`-th power. **It is not a power of an operator, and the statement contains no iteration.** The two are the same operator only through [diagOp_iterate](../lean/HamiltonsCubic/Results/I36DiagTest.lean#L52), which the statement does not mention.

The sharper point is what the outer quantifier does to the content. Over all symmetric `w` and all `k`, the family of subjects `{diagOp (hpow w k)}` is exactly the family `{diagOp v : v symmetric}`, because `hpow w 1` is `w` on the nose ([hpow_one_eq](../lean/HamiltonsCubic/Results/I36DiagTest.lean#L46) is the definitional unfolding, checked). **So the theorem is interdeducible with [diagOp_bianchi](../lean/HamiltonsCubic/Base/Families.lean#L190), the base layer's lemma, in one line in each direction.** The `k` adds no proposition. Part (i)'s content, the observation that a coordinate-diagonal operator's *powers* stay in the diagonal family, lives entirely in [diagOp_iterate](../lean/HamiltonsCubic/Results/I36DiagTest.lean#L52) and is never joined to a Bianchi conclusion.

Verdict on item 2: **a different claim that happens to be equivalent to part (i) by a lemma the statement does not reference**, and weaker than part (i) as a formalisation, since a reader of the theorem alone learns nothing about powers.

The repair is one declaration, stated here so the row can name it as owed:

```lean
theorem bianchi_diagOp_iter (w : Matrix ι ι ℝ) (hw : ∀ a b, w a b = w b a) (k : ℕ) (i j l m : ι) :
    bianchi (fun X => (diagOp w)^[k] X) i j l m = 0 := by
  rw [show (fun X => (diagOp w)^[k] X) = diagOp (hpow w k) from funext (diagOp_iterate w k)]
  exact bianchi_diagOp_pow w hw k i j l m
```

That statement is part (i), and it uses [diagOp_iterate](../lean/HamiltonsCubic/Results/I36DiagTest.lean#L52) as the row already claims the existing theorem does.

## 3. The dependency list in the row is false

The full proof term, printed by the kernel:

```
fun {ι} [Fintype ι] [DecidableEq ι] w hw k i j l m => diagOp_bianchi (hpow w k) (hpow_symm hw k) i j l m
```

Two of the three lemmas the row credits do not appear.

- [diagOp_iterate](../lean/HamiltonsCubic/Results/I36DiagTest.lean#L52) is invoked by nothing except its own recursive call. A `grep` for it across [lean/](../lean/) finds hits in this one file only.
- [diagOp_comp](../lean/HamiltonsCubic/Results/I36DiagTest.lean#L41) is invoked by nothing at all, this file included. The successor step of [diagOp_iterate](../lean/HamiltonsCubic/Results/I36DiagTest.lean#L52) is closed by `simp [diagOp, hmul, hpow, ...]` rather than by [diagOp_comp](../lean/HamiltonsCubic/Results/I36DiagTest.lean#L41), so the lemma the row calls "the whole reason the test survives powers" is dead weight in the file.
- [hpow_symm](../lean/HamiltonsCubic/Results/I36DiagTest.lean#L61) is used, and it is the only one of the three that is.

**So the row's "from `diagOp_comp`, `diagOp_iterate` and `hpow_symm`, closing on the base layer's `diagOp_bianchi`" describes a proof the file does not contain.** The two unused lemmas are true and proved, which is why this is a documentation defect and not a soundness one, and it is exactly the defect that makes the `k` look load-bearing when it is decorative.

## 4. `Alt` against `bianchi`

Read from source rather than assumed. [altCoeff](../lean/HamiltonsCubic/Base/AltPart.lean#L378) is `alt4 (comp R)`, [alt4](../lean/HamiltonsCubic/Base/AltPart.lean#L311) is the `1/3`-normalised cyclic average, and [altCoeff_eq_third_bianchi](../lean/HamiltonsCubic/Base/AltPart.lean#L383) states `altCoeff R i j k l = (1/3) * bianchi R i j k l` by `rfl`. A round trip through it compiled in the scratch file. **The factor is nonzero, so `bianchi = 0` and `Alt = 0` are the same condition at every index quadruple**, and item 4 raises no correctness objection.

It does raise a coherence one. Part (i) is typed in `bianchi` and part (ii) in [altCoeff](../lean/HamiltonsCubic/Base/AltPart.lean#L378), and the two are meant to compose into one test. **The file should state (i) in the `Alt` form**, or state the bridge, so that the two halves of the same result are comparable without the reader supplying [altCoeff_eq_third_bianchi](../lean/HamiltonsCubic/Base/AltPart.lean#L383) themselves. Nothing in the file mentions it.

## 5. The quantifier over dimension

The section variables are `{ι : Type*} [Fintype ι] [DecidableEq ι]`, with no cardinality bound anywhere in the file and no `Fin n`. **[bianchi_diagOp_pow](../lean/HamiltonsCubic/Results/I36DiagTest.lean#L68) draws no `unusedSectionVars` warning**, which is the positive evidence that both instances are genuinely consumed, as they must be: [bianchi](../lean/HamiltonsCubic/Base/WeylReal.lean#L110) pairs through [inner2](../lean/HamiltonsCubic/Base/WeylReal.lean#L39), which takes a trace and so needs `Fintype`, and [phi](../lean/HamiltonsCubic/Base/WeylReal.lean#L45) is built from `Matrix.single`, which needs `DecidableEq`.

The three helpers are a different matter. [diagOp_comp](../lean/HamiltonsCubic/Results/I36DiagTest.lean#L41), [diagOp_iterate](../lean/HamiltonsCubic/Results/I36DiagTest.lean#L52) and [hpow_symm](../lean/HamiltonsCubic/Results/I36DiagTest.lean#L61) each carry both instances without using either, and the linter says so three times. The base layer handles the same situation with explicit `omit` lines, as at [diagOp_phi](../lean/HamiltonsCubic/Base/Families.lean#L160) and [diagOp_smul](../lean/HamiltonsCubic/Base/Families.lean#L175), so the house style for the fix already exists. **The row's "at every dimension" is accurate.**

## 6. Vacuity, with a witness

The hypotheses are symmetry of the weight and nothing else, so vacuity was never likely, and the test was run anyway on an object that also satisfies the record's locus conditions. At `n = 4`, the four-cycle weight

```lean
def w4 : Matrix (Fin 4) (Fin 4) ℝ := !![0,1,-1,0; 1,0,0,-1; -1,0,0,1; 0,-1,1,0]
```

compiled as a full [IsWeight](../lean/HamiltonsCubic/Base/Families.lean#L153): symmetric by `fin_cases`, hollow by `fin_cases`, and zero row sums by `Fin.sum_univ_four`. Three further checks compiled.

- `diagOp w4 (phi 0 1) 1 0 = 1`, so `diagOp w4` is a nonzero operator, which was then turned into `diagOp w4 ≠ fun _ => 0` outright.
- `bianchi_diagOp_pow w4 w4_symm k i j l m` typechecks at every `k` and every index quadruple, so the theorem applies to it.
- `hpow w4 2 0 1 = 1`, so the subject stays a nonzero operator at `k = 2` and beyond, which forecloses the reading where the higher powers collapse to zero and the theorem becomes empty above `k = 1`.

**NOT VACUOUS.** One scope note the row does not make: the theorem's hypothesis is symmetry alone, so it is quantified over every symmetric weight rather than over the record's locus $\mathcal D_n$, which also demands hollowness and vanishing row sums. That is a widening in the safe direction, since the locus is a subset, and it means the theorem proves more than part (i) asks. It also means the `k = 0` instance is a statement about the identity operator, whose weight is the all-ones matrix and so is outside the locus entirely.

## 7. `hpow` at `0` and `1`

Checked by compilation, all four:

- `hpow w4 0 a b = 1` by `rfl`, so `hpow w 0` is the all-ones matrix.
- `hpow w4 1 a b = w4 a b`, so `hpow w 1` is `w` and the indexing is the entrywise power with no shift.
- `diagOp (hpow w4 0) X = X`, so the `k = 0` operator is the identity on all of `Λ²`.
- `(diagOp w4)^[0] X = diagOp (hpow w4 0) X`, which is [diagOp_iterate](../lean/HamiltonsCubic/Results/I36DiagTest.lean#L52) at `k = 0` and confirms the base case matches `Function.iterate`.

**No off-by-one.** `hpow` is the entrywise power and the `k = 0` case lines up with `(diagOp w)^[0]` exactly as the row implies. The residual mismatch is only in range: the prose restricts to $k \ge 1$ and the theorem includes `k = 0`, where it asserts that the identity operator is Bianchi-free. That is true and harmless, and it is the one place where the file is wider than the prose.

## 8. The `sorry` sits on a false proposition

The statement, verbatim:

```lean
theorem alt_pow_iff_alt_proj {r : ℕ} (P : Fin r → Matrix ι ι ℝ → Matrix ι ι ℝ)
    (mu : Fin r → ℝ) (_hne : ∀ a, mu a ≠ 0) (_hinj : Function.Injective mu)
    (R : Matrix ι ι ℝ → Matrix ι ι ℝ)
    (_hspec : ∀ X, R X = ∑ a, mu a • P a X) :
    (∀ k : ℕ, 1 ≤ k → ∀ i j l m, altCoeff (fun X => R^[k] X) i j l m = 0)
      ↔ (∀ a i j l m, altCoeff (P a) i j l m = 0)
```

**`P` is an arbitrary family of functions from matrices to matrices.** It is not constrained to be linear, self-adjoint, idempotent, mutually annihilating, or complete. `_hspec` says only that `R` is one particular `mu`-weighted sum of the `P a`, which is a statement about `R` and not a spectral decomposition: a spectral decomposition needs `P a ∘ P a = P a`, `P a ∘ P b = 0` for `a ≠ b`, and each `P a` self-adjoint and linear. **None of the three is present**, and `_hne` and `_hinj`, the two hypotheses that do appear, constrain only the scalars.

That gap is not cosmetic. The following compiled against the file as it stands.

```lean
noncomputable def Q : Matrix (Fin 4) (Fin 4) ℝ → Matrix (Fin 4) (Fin 4) ℝ :=
  fun X => inner2 (phi 0 1) X • phi 2 3          -- altCoeff Q 0 1 2 3 = 1/3, checked

noncomputable def muW : Fin 2 → ℝ := fun a => if a = 0 then 1 else -1
noncomputable def Rz : Matrix (Fin 4) (Fin 4) ℝ → Matrix (Fin 4) (Fin 4) ℝ := fun _ => 0

theorem alt_pow_iff_is_false : False := by
  have h := (alt_pow_iff_alt_proj (fun (_ : Fin 2) => Q) muW muW_ne muW_inj Rz Rz_spec).mp
    lhs_holds
  have := h 0 0 1 2 3
  rw [altCoeff_Q_ne] at this
  norm_num at this
```

Every side condition was proved, not assumed: `muW_ne` gives `mu a ≠ 0` at both indices, `muW_inj` gives injectivity because `1 ≠ -1`, `Rz_spec` gives `_hspec` because `1 • Q X + (-1) • Q X = 0`, and `lhs_holds` gives the left side of the `iff` because `Rz` is the zero map, whose every iterate from `k = 1` on is the zero map, whose [altCoeff](../lean/HamiltonsCubic/Base/AltPart.lean#L378) vanishes identically. The right side then forces `altCoeff Q 0 1 2 3 = 0`, and that value is `1/3`: the only surviving term of the cyclic sum is `inner2 (phi 0 1) (phi 0 1) * inner2 (phi 2 3) (phi 2 3) = 1`, by [inner2_phi_phi](../lean/HamiltonsCubic/Base/Families.lean#L84), the other two vanishing because `phi 0 1` is orthogonal to `phi 0 2` and to `phi 0 3`.

`#print axioms alt_pow_iff_is_false` returns `propext, sorryAx, Classical.choice, Quot.sound`. **The `sorryAx` is the one imported from [alt_pow_iff_alt_proj](../lean/HamiltonsCubic/Results/I36DiagTest.lean#L78), and everything else in the derivation is kernel-checked, so the forward direction of the stated `iff` is refuted at `n = 4` with `r = 2`.**

The reverse direction fails for a second, independent reason worth recording even though the refutation above already settles the proposition. With `P` unconstrained there is nothing that makes `R^[k]` equal `∑ a, mu a ^ k • P a`, and that identity is the whole engine of part (ii). It needs idempotence and mutual annihilation of the projectors, and neither is available.

What part (ii) claims, for comparison: with $\mathrm{Alt}(W^k)=\tfrac16\sum_\mu \mu^k\,\mathfrak b(P_\mu)$ over the distinct eigenvalues and $P_\mu$ the genuine eigenprojectors, invertibility of the Vandermonde matrix on distinct nonzero $\mu$ gives the equivalence. **The file keeps the distinctness hypothesis, which is the Vandermonde input, and drops every hypothesis that makes $P_\mu$ a projector, which is what turns the sum into a functional calculus.** Nothing in the file is named for Vandermonde and no invertibility appears, so the row's "types the Vandermonde step" describes the step's intended conclusion rather than the step.

One further correction to the file's stated reason for the abstraction. The docstring says the hypothesis is abstract "because the base layer carries no spectral projectors". The base layer carries [specOp](../lean/HamiltonsCubic/Base/AltPart.lean#L541), $\sum_i \lambda_i\,\omega_i \otimes \omega_i$ as an operator on bivectors, together with the orthonormality hypothesis that makes the $\lambda_i$ eigenvalues, used exactly that way at [posPartOp_comp_negPartOp](../lean/HamiltonsCubic/Base/AltPart.lean#L667). **A rank-one projector is [specOp](../lean/HamiltonsCubic/Base/AltPart.lean#L541) at an indicator spectrum**, so the material for a faithful hypothesis is present and the abstraction is a choice rather than a constraint of the layer.

## 9. What else the row leaves a reader to discover

The clause "What the file does NOT state: the converse" is accurate about the converse and incomplete about everything else. Five omissions, in descending order of how much they mislead.

- **The sorried statement is false**, so it cannot be discharged and its presence in the file is a liability rather than a debt. A reader of the row expects a true statement awaiting a proof.
- **No declaration in the file states part (i)**, because the Bianchi conclusion is never composed with the iteration bridge, and the row's dependency list actively obscures that by crediting the bridge.
- **[diagOp_comp](../lean/HamiltonsCubic/Results/I36DiagTest.lean#L41) is used nowhere**, so the row's parenthetical presentation of it as the mechanism is unsupported by the proof term.
- **The quantifier is over symmetric weights, not over the record's locus**, so "coordinate-diagonal operator" in the row means the base layer's diagonal family and not $\mathcal D_n$, and the `k = 0` instance falls outside the locus altogether.
- **The currencies differ between the two halves**, `bianchi` in (i) and [altCoeff](../lean/HamiltonsCubic/Base/AltPart.lean#L378) in (ii), with the bridge unstated.

One item outside the row, in the file's own docstring, because it contradicts the record. Lines 20 to 25 say "Whether `𝔟(P_μ) = 0` at every eigenprojector forces a coordinate frame is open". **The record has that question answered in the negative for general symmetric operators**, at part (iii) of the same block in [findings/diagonal-half.md](../findings/diagonal-half.md), by the six-eigenform witness at $n = 4$ whose eigenforms are all decomposable and which is coordinate-diagonal in no frame. What is open is the restriction to $\mathcal W_n$, and the record also says what a proof there must consume, namely Ricci-flatness. The docstring as written invites a reader to attempt a statement the record has already retired.

## 10. `native_decide`

**Absent.** A `grep` for `native_decide` across [lean/](../lean/) returns hits in [F53.lean](../lean/HamiltonsCubic/Results/F53.lean), [L34l.lean](../lean/HamiltonsCubic/Results/L34l.lean), [L34f.lean](../lean/HamiltonsCubic/Results/L34f.lean), [L33.lean](../lean/HamiltonsCubic/Results/L33.lean), [L199Statement.lean](../lean/HamiltonsCubic/Results/L199Statement.lean) and [W4.lean](../lean/HamiltonsCubic/Results/W4.lean), and none in [I36DiagTest.lean](../lean/HamiltonsCubic/Results/I36DiagTest.lean). The one proved theorem is a bare term-mode application, so it is kernel-checked with no compiler in the trust path, and the row's "proved outright" is right on that count. The vacuity witness of item 6 was closed by `fin_cases`, `norm_num` and `Fin.sum_univ_four`, also kernel-checked, with `decide +kernel` tried first and rejected by Lean because the entries are reals.

## Overall verdict

**REFUTED AS STATED.** The row overstates the file in two distinct ways and understates the risk in a third.

- What is genuinely there: a kernel-checked, `sorry`-free, dimension-general statement that every coordinate-diagonal operator with a symmetric weight is Bianchi-free, plus a kernel-checked, `sorry`-free bridge saying a power of such an operator is again one. Both are true, both are non-vacuous, and together they are part (i).
- What is not there: any single declaration that says a *power* is Bianchi-free, which is what part (i) claims and what the row asserts is proved. The composition is one `rw` away and it has not been made.
- What is worse than the row says: the owed half is stated as a proposition from which `False` follows, because its projector family is unconstrained.

The proved content survives. The description of it does not, and the sorried statement needs replacing rather than proving.

## Exact replacement text for the index row

The cell for I36 in [lean/INDEX.md](../lean/INDEX.md), status column staying **partial**:

> *statement: typed.* **BIANCHI-FREENESS OF THE DIAGONAL FAMILY IS PROVED OUTRIGHT, AT EVERY DIMENSION, AND THE POWER IS NOT YET COMPOSED.** *`bianchi_diagOp_pow` is `diagOp_bianchi` at the weight `hpow w k`, its whole proof term being `diagOp_bianchi (hpow w k) (hpow_symm hw k)`, so it states Bianchi-freeness of the diagonal operator OF the entrywise power rather than of a power of an operator, and quantified over all symmetric `w` it is interdeducible with the base layer's `diagOp_bianchi`.* **`diagOp_iterate` is the missing half and it is proved**: `(diagOp w)^[k] = diagOp (hpow w k)`, base case checked against `Function.iterate`, with `hpow w 0` the all-ones weight and `diagOp (hpow w 0)` the identity. **The two are never composed, so no declaration in the file states I36(i)**, and `diagOp_comp` is invoked by nothing in the repository. *Non-vacuous: the four-cycle weight at `n = 4` is a full `IsWeight` with `diagOp w4 (phi 0 1) 1 0 = 1` and `hpow w4 2 0 1 = 1`. Quantified over symmetric weights alone, so wider than the record's `𝒟ₙ`, and stated in `bianchi` where I36(ii) is stated in `altCoeff`, the two agreeing by `altCoeff_eq_third_bianchi` at a factor `1/3`.* **What the file does NOT state**: the converse, which is the whole of what a characterisation of the coordinate-diagonal locus needs, and which the record has FALSE for general symmetric operators at [findings/diagonal-half.md](../findings/diagonal-half.md) part (iii), open only inside `𝒲ₙ`. **`alt_pow_iff_alt_proj` IS FALSE AS WRITTEN and carries the file's single `sorry`** ([r848](../reviews/REVIEW_r848.md)): its `P` is an arbitrary family of maps with no idempotence, no mutual annihilation, no linearity and no self-adjointness, so `R^[k] = ∑ mu a ^ k • P a` never follows, and `P ≡ Q` with `mu = (1, -1)` makes `R` the zero map while `altCoeff Q 0 1 2 3 = 1/3`, from which `False` compiles. *No `native_decide` in the file. Three `unusedSectionVars` warnings, on `diagOp_comp`, `diagOp_iterate` and `hpow_symm`.*

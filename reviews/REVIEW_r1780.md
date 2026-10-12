# Review r1780: L214Diag.lean (e05cecbe)

| Claim | Verdict | Reason |
|---|---|---|
| `sig_of_hasChar_c` | CONFIRMED | a character `c` under `flip k` gives `sig k V = c • V`, the c = 1 case being `sig_of_hasChar` |
| `comp_empty_fix` | CONFIRMED | `setChar ∅ ε` is the empty product, 1 |
| `comp_sig_neg` | CONFIRMED | `setChar t (sgn m)` is the product over t of `sgn m i`, where only i = m contributes −1 |
| `L214_diag` | CONFIRMED | ⟨D,N⟩ = 0 and T(D,D,N) = 0 are proved from `comp_char` and `Tsym_sig` alone, and the relations come from `L214_op` |
| `L214_diag_max` | CONFIRMED | it feeds the same two facts to `L214_op_max` with `comp_isWeyl2 ∅` for D Weyl |
| comp ∅ W is the record's D | CONFIRMED | the sign-group average is the orthogonal projection onto the Γ-fixed operators, which are exactly the pair-diagonal ones |
| lean/INDEX.md L214 row | CONFIRMED WITH OBSERVATIONS | accurate, but the row does not name the arbitrary-frame clause as owed |
| lean/INDEX.md L219 row (r1779 note) | CONFIRMED | `even_odd_orth` exists with the stated content and the note matches r1779 |

**Summary:** the file proves L214 at the coordinate frame with the frame input T(D,D,N) = 0 discharged, sorry-free on the three standard axioms. The record's "any orthonormal frame F" is covered only at F = the coordinate frame, and the INDEX row should say so.

## 1. Is comp ∅ W the record's coordinate-diagonal part D?

Record, second-order.md Lemma L214: "split a unit critical point as $W=D+N$, where $D=\pi_FW$ is its coordinate-diagonal part in $F$ and $N=W-D$", with "$\mathcal D_n$ is exactly the $\Gamma$-fixed subspace: a sign flip $\varepsilon$ acts on the pair basis by $\varepsilon_i\varepsilon_j$, so an entry off the pair diagonal is fixed only if it vanishes."

- `comp ∅ W` is `restrict (proj ∅ (extendL W))`, and `proj ∅ B = 2^{-n} ∑_u act (diagSet u) B` since `chi ∅ u = 1`. This is the average over the sign group Γ.
- The average is the orthogonal projection onto the Γ-fixed operators. It lands in the fixed space (`comp_empty_fix`), and W − comp ∅ W = ∑_{t≠∅} comp t W is orthogonal to every fixed operator (`comp_perp_ne`). Both are used in the file.
- The Γ-fixed operators are exactly the pair-diagonal ones. The entry R_{ij,kl} (i<j, k<l) transforms by ε_iε_jε_kε_l, which is 1 for every ε exactly when every index occurs an even number of times, that is {i,j} = {k,l}. So averaging keeps the entries R_{ijij} and zeroes the rest.
- The two readings are therefore one operator: the orthogonal projection of W onto D_n equals reading off R_{ijij}. The truncation is Weyl (`comp_isWeyl2`), in line with the record's appeal to L123.
- On Fin n, `trivial_block_iff` identifies the Γ-fixed Weyl operators with `restrict (diagOp w)` for a weight w, matching the record's D_n.

Observations:

- **O1 (scope).** The record fixes "any orthonormal frame F". The Lean takes the coordinate frame only. The general frame reduces to it by conjugating W with an orthogonal matrix, which needs P, Q, the norm and the Weyl condition to be O(n)-equivariant on `CurvOp2`. The L219 row already names that reduction ("a general unit u (frame rotation)") as owed. The L214 row marks the result **partial** but does not say this clause is what is missing. Recommend adding "Owed: an arbitrary frame F (frame rotation)" to the row.
- **O2 (docstring).** The module docstring and the INDEX row cite `trivial_block_iff` for "the diagonal operator of a weight". That theorem is stated on `Fin n`, while L214Diag is over a general `ι`. No proof depends on it, since the file uses only the sign-fixed property, but the gloss holds verbatim only at `ι = Fin n`.

## 2. Is comp_sig_neg sound?

Yes. `comp_char t W h (sgn m) _` gives `HasChar (setChar t (sgn m)) (signMat (sgn m)) (comp t W h)`. Here `setChar t (sgn m) = ∏_{i∈t} (if i = m then −1 else 1)`, which is −1 exactly when m ∈ t. `signMat (sgn m)` is `diagonal (sgn m)` and `flip m` is `diagonal (fun i => if i = m then −1 else 1)`, which is the same term by unfolding. The type ascription in the source is accepted by the kernel, so the two agree definitionally. `sig_of_hasChar_c` then turns the character into `sig m (comp t W h) = −comp t W h`.

- **O3 (minor duplication).** `sig_of_hasChar_c` repeats the proof of `L219Diag.sig_of_hasChar` with 1 replaced by c. The c = 1 case could be derived from it. This is housekeeping only.

## 3. Is T(D,D,N) = 0 proved without hidden hypotheses, and is it L120's fact?

- The route: N = ∑_{t≠∅} comp t W, T is linear in its third slot (`TsymL`, `map_sum`), and for each t ≠ ∅ a chosen m ∈ t gives σ_m D = D and σ_m N_t = −N_t. `Tsym_sig` gives T(D,D,N_t) = T(σD,σD,σN_t) = −T(D,D,N_t), hence 0.
- The only hypothesis used is `IsWeyl2 W`, needed for `comp` to be defined. Neither criticality nor the norm enters this conjunct.
- It is the same fact as the record's. The record uses L120: L_M preserves each Γ-isotypic summand when M is Γ-fixed, so D∘D lies in D_n and pairs to 0 with N. Both are consequences of the product being equivariant under the sign group. The Lean uses the equivariance under one reflection per component, which is the specialisation of L120's argument to the scalar ⟨D∘D, N_t⟩ that the record says is all the proof needs ("the proof below needs only ⟨D∘D,N⟩ = 0").

## 4. Hypotheses of L214_diag

- `hWW` (Weyl): needed for `comp` and for `isSelfAdjoint2`, which `L214_op` takes.
- `hQ` (Q(W) = θW): needed for both relations.
- `hW1` (unit norm): needed for ‖N‖² = 1 − t, which `L214_op` takes as `htN` and which the second relation uses. The first relation alone would not need it, since ⟨W,D⟩ = ‖D‖² follows from ⟨D,N⟩ = 0.
- Nothing is redundant. `L214_diag` needs nothing beyond what `L214_op` needs: it discharges `hsplit`, `hDN`, `ht`, `htN` and `hperp` from the three hypotheses above.
- In `L214_diag_max`, `hW1` stays necessary because `IsLocalMaxOn` does not put W in the constraint set. `hθ` matches the record's scope ("at a local one with θ > 0"). `hQ` is plausibly derivable from the maximiser hypothesis, as r1779 noted for `odd_mass_max`, and is taken as a hypothesis. That is harmless.
- **O4 (minor).** `L214_diag_max` recomputes `hsplit` and `hNN` word for word from `L214_diag`'s body. A shared lemma would remove the duplication.

## 5. Axioms

Run with `lake env lean` on a check file importing the module:

```
'HamiltonsCubic.L214Diag.L214_diag' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L214Diag.L214_diag_max' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L214Diag.comp_sig_neg' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L214Diag.sig_of_hasChar_c' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L214Diag.comp_empty_fix' depends on axioms: [propext, Classical.choice, Quot.sound]
```

No `sorryAx` and no `Lean.ofReduceBool`. `#check @L214_diag` shows the statement as quoted in the brief.

## 6. lean/INDEX.md rows

- **L214 (statement).** The new sentence states that `L214_diag` proves ⟨D,N⟩ = 0, T(D,D,N) = 0 and the two relations, and that `L214_diag_max` proves the inequality at a local maximiser with θ > 0, on the standard three axioms. All of this matches the code. The earlier sentence saying the frame input "stays a hypothesis" was removed, correctly. The status stays **partial**, and O1 asks the row to name what keeps it partial. plan-lean.md's row 13 still reads "statement only" in its status column. That column may measure something else, but it disagrees with **partial** on its face and should be checked when plan-lean.md is regenerated.
- **L219 (statement).** The r1779 note says `odd_mass_max` comes with `even_odd_orth`, ⟨b,c⟩ = 0, and that `hQ` and θ > 0 are derivable from the maximiser hypothesis and taken as hypotheses. `even_odd_orth (m) (W)` in L219Max.lean states exactly ⟨½(W + σW), ½(W − σW)⟩ = 0, and `odd_mass_max` takes `hQ` and `hθ` explicitly. The note is accurate.

## 7. Falsifiers and the search for them

- `comp_sig_neg`: a finite set t ∋ m and a Weyl W whose component comp t W is not odd under σ_m. That would require `setChar t (sgn m)` ≠ −1 for m ∈ t. I checked the product by hand: exactly one factor is −1.
- `L214_diag`, conjunct T(D,D,N) = 0: a Weyl W whose pair-diagonal truncation D has D∘D with a nonzero off-pair-diagonal entry. Sign equivariance rules this out for any product built from conjugation-equivariant operations. I checked that `Tsym_sig` holds for all three arguments with no hypothesis.
- `L214_diag`, the relations: a unit Weyl critical point where θt ≠ P(D) + T(D,N,N). Given the two frame inputs, this reduces to `L214_op`, which passed Gate 2 (r1741). The record's Gate 1 screen at S⁴×S⁴ over sixty frames also bears on it.
- `L214_diag_max`: a local maximiser with θ > 0 and T(D,N,N) < (θ/2)t(1−t). This reduces to `L214_op_max` in the same way.
- For comp ∅ W ≠ the R_{ijij} truncation, a falsifier would need an off-pair-diagonal entry fixed by every sign flip. I showed by the character count in section 1 that none exists.
- No numerical screen was run. The kernel check plus these hand arguments cover every conjunct, and a screen would add nothing to them.

## Overall verdict

**CONFIRMED WITH OBSERVATIONS.**

- O1: the arbitrary-frame clause should be recorded as owed in the L214 row.
- O2: the `trivial_block_iff` gloss is stated at `Fin n`.
- O3 and O4: minor duplication.
- plan-lean.md's "statement only" disagrees with the row's **partial**.

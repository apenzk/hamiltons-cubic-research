# REVIEW r1783: FrameOp2.lean, L219Gen.lean and L245Op.lean's star clauses (1e47e83f)

Gate 2 reader for the Lean layer. Analysis only: the one compute was a `lake env lean` check file for `#print axioms`, `#check` and a one-line screen of `Su` at a concrete unit vector.

| Claim | Verdict | Reason |
|---|---|---|
| `rotR U` is the $O(n)$ action $R\mapsto UR(U^{\mathsf T}\cdot U)U^{\mathsf T}$ | CONFIRMED | `rotR_coe` states it pointwise, and `cU U X` is $U^{\mathsf T}XU$ |
| `rotR_eq_restrict`, `rotR_isWeyl2` | CONFIRMED | orthogonality is a hypothesis and every caller supplies it |
| `normSq2_rotR`, `Pcubic2_rotR` | CONFIRMED | carried from `invariants_conj` at `extend V`, which is Weyl on `Fin n` by `isWeyl_extend` |
| `innerOp2_rotR` | CONFIRMED | polarisation of the norm on Weyl pairs, $A+B$ Weyl |
| `Tsym_polar` | CONFIRMED | inclusion and exclusion over $\{A,B,C\}$ leaves the six orderings of $(A,B,C)$, hence the 6 and the signs |
| `Tsym_rotR` | CONFIRMED | restricted to Weyl triples, which is all `L219_gen` uses |
| `Su`, `Su_symm`, `Su_sq`, `Su_orth`, `rotR_Su_Su` | CONFIRMED | $S_u=I-2uu^{\mathsf T}$ is the reflection in $u^\perp$ at unit $u$ |
| `L219_gen` against the record's L219 at every unit $u$ | CONFIRMED WITH OBSERVATIONS | the six pairing clauses at every unit $u$, with the unconditional three placed under criticality |
| Record: "$O(n)$ acts on $\mathcal W_n$ by isometric algebra automorphisms" | CONFIRMED WITH OBSERVATIONS | isometry, $\mathcal W_n$-invariance and $T$-invariance are typed, the automorphism property $\sigma(x\circ y)=\sigma x\circ\sigma y$ is not |
| `star_weight`, `L245_star_two`, `L245_star_one` | CONFIRMED | $h_2$ and both halves of $h_1$ at $a_c\ge d$ |
| L245's star clause "for every $E_c$" | CONFIRMED | with `L245_star` at $E_0$ all three classes are typed |
| lean/INDEX.md rows L219 (statement), L245 | CONFIRMED WITH OBSERVATIONS | the L219 row keeps a stale "not done" sentence, and the L245 row credits r1782 with theorems it did not see |

**Summary**: every theorem under review is sound, axiom-clean and says what the commit says. Four observations concern bookkeeping and one concerns the scope of the INDEX's forward claim.

## 1. `rotR` and orthogonality

- `rotR U V = cU Uᵀ ∘ V ∘ cU U`, with `cU U X = Uᵀ X U` and `cU Uᵀ Y = U Y Uᵀ`, so `rotR U V X = U V(Uᵀ X U) Uᵀ`. `rotR_coe` states exactly this.
- At orthogonal $U$ this is $\Lambda^2U\circ V\circ(\Lambda^2U)^{-1}$, the standard $O(n)$ action on curvature operators. At non-orthogonal $U$ it is still a linear map on `CurvOp2` but not a conjugation, and nothing in the commit uses it there.
- `rotR_eq_restrict` takes `hU : IsOrth U`. The equation's proof uses only `rotR_coe`, `restrict_apply`, `cU_coe` and `extend_apply`, but `hU` is needed to type the right-hand side, since `restrict` requires `IsWeyl (conjOp U (extend V))` from `isWeyl_conj hU`.
- Every caller (`rotR_isWeyl2`, `normSq2_rotR`, `Pcubic2_rotR`, and through them `innerOp2_rotR`, `Tsym_rotR`, `L219_gen`) passes an `IsOrth` witness. `rotR_Su_Su` avoids `rotR_eq_restrict` and uses only `Su_sq`. No use at non-orthogonal $U$.
- `conjOp U R X = U * R (Uᵀ * X * U) * Uᵀ` in [Frames.lean](../lean/HamiltonsCubic/Base/Frames.lean) is the same formula, so the two sides agree definitionally on $\Lambda^2$ after `extend_apply`.

## 2. `Pcubic2_rotR`

- **Case split sound.** At `normSq (extend V) = 0`, `normSq_extend` and the definiteness `normSq2_eq_zero` give `V = 0`. The goal is rewritten back to `Pcubic2 (rotR U V) = Pcubic2 V` and closed by `map_zero` on both sides.
- **Inversion correct.** `theta R = Pcubic R / norm R ^ 3` ([WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean)). The norms agree by `hN`, the common norm is positive from `normSq2_nonneg` and `h0`, and `field_simp` with `norm ^ 3 ≠ 0` clears the denominator to `Pcubic (conjOp U (extend V)) = Pcubic (extend V)`.
- **`invariants_conj` applies.** Its hypotheses are `IsOrth U` and `IsWeyl R` for `R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ` with no eigenframe hypothesis. `isWeyl_extend hV` supplies the Weyl property at `extend V` on `Fin n`.
- The bridge to `Pcubic2` goes through `Pcubic2_restrict`, which needs `IsLinOp` of the bare operator. `isLinOp_conj_extend` proves it from `isLinOp_extend`. `hP2` uses `restrict_extend` to identify `V` with `restrict (isWeyl_extend hV)`.

## 3. Polarisation

- `Tsym` is the symmetrisation of `cubicTri` over the six orderings, with `Tsym R R R = Pcubic2 R` (`Tsym_diag`). Expanding $P(A+B+C)$ trilinearly gives all 27 ordered triples from $\{A,B,C\}$. Subtracting the three pair expansions and adding back the three singletons removes every triple missing a letter, leaving the $3!=6$ triples using all three, each equal to $T(A,B,C)$ by symmetry. So $6T(A,B,C)=P(A{+}B{+}C)-P(A{+}B)-P(A{+}C)-P(B{+}C)+P(A)+P(B)+P(C)$, which is the statement.
- `Tsym_rotR` requires `IsWeyl2` on $A$, $B$, $C$, and uses `Pcubic2_rotR` on all seven sums, each Weyl by `isWeyl2_add`. This is enough for `L219_gen`: it applies `Tsym_rotR` at $(b,b,c)$ and $(c,c,c)$, and `innerOp2_rotR` at $(b,c)$, where `hb`, `hc` show $b,c\in\mathcal W_n$.
- **T is the record's $\langle x\circ y,z\rangle$ on self-adjoint arguments**: `Tsym_quad` with `Pcubic2Quad_selfAdjoint` gives $T(u,v,v)=\langle u,Q(v)\rangle$ ([L217Le.lean](../lean/HamiltonsCubic/Results/L217Le.lean), `Tsym_eq_Le`'s first step), and total symmetry fixes the rest. So the INDEX's "$T(b,b,c)=0$ is $\langle b\circ b,c\rangle=0$" is right.

## 4. `Su u` and $\sigma_u$

- `Su u = 1 - 2 • vecMulVec u u` is $I-2uu^{\mathsf T}$. At unit $u$ it fixes $u^\perp$ and sends $u\mapsto-u$, the reflection in $u^\perp$. `Su_symm` holds for every $u$, and `Su_sq` and `Su_orth` use `hu`.
- *Screen*: at $u=(1,0)$ the check file proves `Su ![1,0] = !![-1,0;0,1]`.
- `rotR (Su u)` is $R\mapsto S_uR(S_u\cdot S_u)S_u$, which is $\sigma_u$ acting on $\mathcal W_n$ by §1. `rotR_Su_Su` gives $\sigma_u^2=1$ on all of `CurvOp2`, and `hsb`, `hsc` give $\sigma_ub=b$, $\sigma_uc=-c$.

## 5. `L219_gen` against the record

Record, [findings/second-order.md](../findings/second-order.md) Lemma L219: "*Let $u\in\mathbb R^n$ be a unit vector, $\sigma_u\in O(n)$ the reflection in $u^\perp$, and split $W\in\mathcal W_n$ as $W=b+c$ with $\sigma_ub=b$ and $\sigma_uc=-c$. Then* $P(W)=P(b)+3\langle L_bc,c\rangle,\ P(c)=0,\ \langle b\circ b,c\rangle=0$. *If $W$ is a critical point, $Q(W)=\theta W$, then* $b\circ b+c\circ c=\theta b,\ 2\,b\circ c=\theta c,\ \langle L_bc,c\rangle=\tfrac\theta2\lVert c\rVert^2,\ P(b)=\theta(\lVert b\rVert^2-\tfrac12\lVert c\rVert^2)$. **And $W$ is coordinate-diagonal in an orthonormal frame $(e_1,\dots,e_n)$ exactly when its $\sigma_{e_k}$-odd part vanishes for $k=1,\dots,n-1$** … **At a unit global maximiser, $\lVert c_u\rVert^2\le\tfrac34$ for every unit $u$.**"

- **Typed at every unit $u$**: $\langle b,c\rangle=0$, $T(b,b,c)=0$, $P(c)=0$, $P(W)=P(b)+3T(b,c,c)$, $T(b,c,c)=\tfrac\theta2\lVert c\rVert^2$, $P(b)=\theta(\lVert b\rVert^2-\tfrac12\lVert c\rVert^2)$, with `#check` confirming the statement as described.
- **Hypotheses**: unit $u$, Weyl $W$, $Q(W)=\theta W$ for any real $\theta$. No norm hypothesis, matching the record.
- **Coordinate-only still**: the operator identities $b\circ b+c\circ c=\theta b$ and $2b\circ c=\theta c$ (`L219_ops`), diagonality (`diagonal_iff_even_but_one`, in the coordinate frame, where the record says "an orthonormal frame"), and $\lVert c_u\rVert^2\le\tfrac34$ (`odd_mass_max`, `odd_mass_global`, at `sig m`). The INDEX row records these three as **Owed**.
- **Observation O1**: the record's first display holds for every $W\in\mathcal W_n$. `L219_gen` bundles its three clauses, and $\langle b,c\rangle=0$, under `hQ`, although their proofs (`horth`, `hbbc`, `hccc`, `hsplit`) never touch `hQ`. The Lean is therefore weaker than the record for those clauses. Splitting off an unconditional theorem is a restatement of lines 79 to 119 of [L219Gen.lean](../lean/HamiltonsCubic/Results/L219Gen.lean).
- **Observation O2 (the proof's "isometric algebra automorphisms")**: typed are $\mathcal W_n$-invariance (`rotR_isWeyl2`), isometry on Weyl pairs (`innerOp2_rotR`) and $T$-invariance on Weyl triples (`Tsym_rotR`). The automorphism property $\sigma(x\circ y)=\sigma x\circ\sigma y$ and the group law are untyped. The Lean route replaces the automorphism with $T$-invariance, which is exactly what the pairing clauses need, so the typed clauses are complete. The operator identities are where the gap matters (O3).

## 6. L245's star clause in $E_2$ and $E_1$

Record, Lemma L245: "**In particular, if $E_c\supseteq e\wedge U$ for a unit $e$ and a subspace $U\perp e$, then $\dim U\le h_c$**", with $h_2=\frac{(n-1)\lvert\lambda_0\rvert}{\lambda_2-\lambda_0}$ and $h_1=\frac{(n-1)\lvert\lambda_0\rvert}{\lambda_1-\lambda_0}$ if $\lambda_1\ge0$, $\frac{(n-1)\lambda_2}{\lambda_2-\lambda_1}$ otherwise.

- `star_weight`: $P\succeq\sum_i\pi_{e\wedge u_i}$ gives $\operatorname{Ric}(P)(e,e)\ge d$ by `isoW_mono`, `isoW_sum` and `isoW_rk1_star`. Correct in any class.
- `L245_star_two`: $(\lambda_2-\lambda_0)d\le(n-1)(-\lambda_0)$ from `ceiling_h2` and $d\le a_2$. This is $d\le h_2$ multiplied out. The Lean's $-\lambda_0$ is at most $\lvert\lambda_0\rvert$, so it is at least as strong as the record's.
- `L245_star_one`: both $(\lambda_1-\lambda_0)d\le(n-1)(-\lambda_0)$ and $(\lambda_2-\lambda_1)d\le(n-1)\lambda_2$. The record's case split picks the smaller of the two bounds: the first is the smaller exactly when $\lvert\lambda_0\rvert(\lambda_2-\lambda_1)\le\lambda_2(\lambda_1-\lambda_0)$, which reduces to $\lambda_1(\lambda_2-\lambda_0)\ge0$, that is $\lambda_1\ge0$. So the conjunction is $d\le h_1$.
- **Hypotheses**: the Lean takes $\lambda_0\le\lambda_1\le\lambda_2$, weaker than the record's strict order, and PSD $P_c$ resolving the identity with $\sum\lambda_cP_c=W$, weaker than spectral projections. The $u_i$ are unit and orthogonal to $e$ but not required mutually orthogonal. At an orthonormal basis of $U$ and $P_c$ the eigenprojector, the hypothesis `hstar` is $E_c\supseteq e\wedge U$. With `L245_star` at $E_0$, all three classes are typed.

## 7. Axioms

`#print axioms` on `Pcubic2_rotR`, `Tsym_rotR`, `Tsym_polar`, `innerOp2_rotR`, `L219_gen`, `L245_star_one`, `L245_star_two`: each depends on `[propext, Classical.choice, Quot.sound]` only. The check file compiled with exit 0.

## 8. lean/INDEX.md

- **L219 (statement)**, `proved`: the new "At every unit $u$, PROVED" passage matches `L219_gen`, `Su_orth`, `rotR_Su_Su`, `Pcubic2_rotR`, `Tsym_rotR`, and the Owed list is accurate.
- **Observation O3**: the row still carries, in the L219Op passage, "*A general unit $u$ needs `CurvOp2` carried through a frame rotation, not done.*", which the new passage contradicts. The record's provenance line in [findings/second-order.md](../findings/second-order.md) also still reads "The Lean owes a general unit $u$, which needs a frame rotation carried through `CurvOp2`", now true only of the operator identities, diagonality and the bound.
- **Observation O4**: the Owed list says each outstanding clause "transfers by the same invariances". This holds for the maximiser bound, since `odd_mass_max` consumes only `L219_op`'s pairing outputs, which `L219_gen` now supplies. It does not hold as stated for the operator identities: $T$-invariance on Weyl triples fixes $\sigma(x\circ y)$ only through its pairings with $\mathcal W_n$, so the identities need either $Q\circ\sigma=\sigma\circ Q$ on `CurvOp2` (the analogue of `Qop2_sig`) or the closure of $\mathcal W_n$ under $\circ$ (L209). Diagonality in a general frame additionally needs `rotR` to carry $\mathcal D_n$ in the coordinate frame to the diagonal space of the rotated frame.
- **L245**, `partial`: the star-clause passage matches the code. **Observation O5**: "Gate 2 on the star clause: r1782, CONFIRMED WITH OBSERVATIONS" follows the mention of `L245_star_two` and `L245_star_one`, which r1782 did not see (they enter in 1e47e83f). This review is their Gate 2.

## 9. Falsifiers and the search for them

| Statement | Falsifying object | What was done |
|---|---|---|
| `rotR` is the $O(n)$ action | a $U$, $V$, $X$ with `rotR U V X` $\ne UV(U^{\mathsf T}XU)U^{\mathsf T}$ | read `rotR_coe` and `cU_coe`, both definitional |
| `Pcubic2_rotR` | orthogonal $U$, Weyl $V$ with $P$ changing | read the case split and the `theta` inversion, confirmed `invariants_conj` has no frame hypothesis |
| `Tsym_polar` | a triple where the constant or a sign fails | derived the inclusion and exclusion count by hand (§3) |
| `Su` is $\sigma_u$ | a unit $u$ where $S_u$ does not fix $u^\perp$ | screen at $u=(1,0)$ in the check file |
| `L219_gen` matches the record | a record clause at general $u$ absent from the Lean | clause-by-clause comparison (§5), found O1 |
| `L245_star_one` is $d\le h_1$ | a spectrum where the conjunction differs from the record's case split | reduced the comparison to $\lambda_1(\lambda_2-\lambda_0)\ge0$ by hand (§6) |
| INDEX rows | a row sentence the code contradicts | read both rows in full, found O3, O4, O5 |

No falsifier found. The kernel settles each statement, so a falsifier could only be a mismatch between statement and record, and the observations above are the mismatches found.

## Overall verdict

**CONFIRMED WITH OBSERVATIONS.** O1 (unconditional clauses under `hQ`), O2 (the automorphism property untyped, bypassed by $T$-invariance), O3 (stale "not done" sentence in the INDEX and the record's stale "owes a general unit $u$"), O4 (the operator identities need $Q$-equivariance or L209, beyond $T$-invariance) and O5 (r1782 credited with theorems it did not review) are repairs to statements and bookkeeping. None affects a theorem's truth.

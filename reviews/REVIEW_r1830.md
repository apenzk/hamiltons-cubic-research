# r1830: FourProd.lean, L220 step 2's ν∘ν ∈ Π_Q with the record's pattern

*Gate 2 review of [FourProd.lean](../lean/HamiltonsCubic/Results/FourProd.lean) at commit 8fd77703, against [findings/second-order.md](../findings/second-order.md), Lemma L220, Setting and step 2. The file proves that every Weyl ν of character χ_Q satisfies ν∘ν = coordOp(PiQ(x,y,z)) with the record's pattern in the record's signed coordinates. That equality is membership in Π_Q, since PiQ is hollow, supported on Q, and its three values sum to zero identically. Π_Q as a subalgebra and D∘ν ∈ V_Q remain owed, and the lean/INDEX.md row still lists ν∘ν ∈ Π_Q among the owed items after marking it PROVED.*

| # | Claim | Verdict |
|---|---|---|
| 1 | `sigC_mat`: on skew Y, S_il Y S_jk + S_jk Y S_il = spanVec(−1,1,0) Y | CONFIRMED |
| 2 | `sig_sum`: σ_A + σ_B = −σ_C | CONFIRMED |
| 3 | `Q_lin`: Q(xσ_A + yσ_B) = x²Q_A + y²Q_B + xy(Q_C − Q_A − Q_B), sound polarisation (question c) | CONFIRMED |
| 4 | `E2`, `PiQ`: the record's Π_Q element, x at ij/kl, y at ik/jl, z at il/jk (question b) | CONFIRMED |
| 5 | `Wcomb_pattern`: polarised weight equals PiQ off the diagonal at (a,b,c) = (x,−y,y−x) | CONFIRMED |
| 6 | `nu_sq`: (a,b,c) are the record's signed coordinates of ν (question a) | CONFIRMED |
| 7 | `nu_sq` proves the record's "ν∘ν ∈ Π_Q, with x = 2a² − b² − c² and cyclically" in full (question d) | CONFIRMED WITH OBSERVATIONS |
| 8 | lean/INDEX.md's L220 result row states accurately what of step 2 remains (question e) | REFUTED AS STATED |

**Summary.** The mathematics of FourProd.lean is sound and faithful to the record's step 2 second product, the build is clean on the standard three axioms, and the only defect is a stale owed list in the lean/INDEX.md row.

## 1. The record, verbatim

The Setting of L220:

> **Setting.** $\Pi_Q\subset\mathcal D_n$ is the plane of sectional matrices supported on $Q$, $K_{ij}=K_{kl}=x$, $K_{ik}=K_{jl}=y$, $K_{il}=K_{jk}=z$ with $x+y+z=0$, unit when $2(x^2+y^2+z^2)=1$. Write $D=q+r$ with $q\in\Pi_Q$, $r\in\mathcal D_n\ominus\Pi_Q$, and in the pairing basis of $V_Q$ with signed coordinates $\nu=a\,e_{ij}\odot e_{kl}+b\,e_{ik}\odot e_{jl}+c\,e_{il}\odot e_{jk}$, $a+b+c=0$.

Step 2:

> 2. **Three products.** $\Pi_Q$ is a subalgebra of $\mathcal D_n$, since a hollow matrix supported on $Q$ with zero row sums has $S^{\circ2}+S^2$ supported on $Q$ off the diagonal with zero row sums. $\nu\circ\nu\in\Pi_Q$, with $x=2a^2-b^2-c^2$ and cyclically: it has character $\chi_Q^2=1$, so it lies in $\mathcal D_n$, in $(\nu\#\nu)_{\alpha\alpha}$ a pair $\alpha$ leaving $Q$ forces a factor of $\nu$ outside its support, and on $Q$ the pattern is $(\nu\#\nu)_{ij,ij}=2bc$ plus $(\nu^2)_{ij,ij}=a^2$. And $D\circ\nu\in V_Q$ by L120.

## 2. Build and axioms

- `lake env lean HamiltonsCubic/Results/FourProd.lean` from lean/: exit 0, no errors, no `sorry`, 41.6 s wall. It emits 78 linter warnings (unreachable or unused `linarith` and `ring` branches of the generated case trees, and `<;>` where `;` would do). They are style only. Recorded as O7.
- `python3 scripts/misc/axiom_audit.py --only FourProd.lean`: "auditing 5 declarations across 1 files ... 5/5 clean -- resting on the standard three alone", exit 0.
- The working tree's FourProd.lean is identical to commit 8fd77703 (empty `git diff HEAD` on the path), so the build checks the reviewed text.

## 3. Question (a): the signed coordinates

- [spanVec](../lean/HamiltonsCubic/Results/L126GenBridge.lean#L30) is `x • rk2 (phi i j) (phi k l) Y + y • rk2 (phi k i) (phi j l) Y + z • rk2 (phi i l) (phi j k) Y`. Its second slot is written with φ_ki, the cyclic orientation in which the first Bianchi identity reads R(ij,kl) + R(jk,il) + R(ki,jl) = 0, which is exactly the record's constraint "$a+b+c=0$". So spanVec's (x,y,z) are the record's signed coordinates (a,b,c), as [r1826](REVIEW_r1826.md) O1 already recorded.
- In FourIdent, `sigA_mat` gives σ_A = sig4 i k j l = spanVec(1,0,−1) and `sigB_mat` gives σ_B = sig4 i j k l = spanVec(0,−1,1). Then a σ_A + (−b) σ_B = spanVec(a, b, −a−b), which is spanVec(a,b,c) exactly when c = −a−b.
- `nu_sq`'s proof takes (x,y) from `four_eq_sig` and sets (a,b,c) = (x, −y, y−x). So ν = x σ_A + y σ_B = spanVec(x, −y, y−x) = spanVec(a,b,c), and a+b+c = 0 by `ring`. The existential's a, b, c are the record's signed coordinates of ν. CONFIRMED.
- An independent hand check of `sigA_mat`'s zero middle slot: with S_ik = u_i u_kᵀ + u_k u_iᵀ and φ_ik = u_i u_kᵀ − u_k u_iᵀ, S_ik φ_ik = u_k u_kᵀ − u_i u_iᵀ, which S_jl annihilates on either side since {j,l} is disjoint from {i,k}. So the sandwich S_ik·S_jl kills φ_ik, and its coordinate on the ki|jl slot is 0, as spanVec(1,0,−1) says.

## 4. Question (b): the pattern and x + y + z = 0

- `PiQ i j k l x y z = x • (E2 i j + E2 k l) + y • (E2 i k + E2 j l) + z • (E2 i l + E2 j k)`, with `E2 p q` the symmetric unit weight on {p,q}. This is the record's "$K_{ij}=K_{kl}=x$, $K_{ik}=K_{jl}=y$, $K_{il}=K_{jk}=z$", slot for slot.
- `nu_sq` feeds PiQ the triple (2a²−b²−c², 2b²−c²−a², 2c²−a²−b²). The first is the record's "$x=2a^2-b^2-c^2$", and the other two are its cyclic images under (a,b,c) ↦ (b,c,a), matching "and cyclically" with y on the ik/jl slot carrying b and z on the il/jk slot carrying c.
- The sum is (2a²−b²−c²) + (2b²−c²−a²) + (2c²−a²−b²) = 0 as a polynomial identity, with no use of a+b+c = 0. Every row of PiQ restricted to Q sums to x+y+z = 0, and PiQ vanishes off Q and on the diagonal. So the value lies in the record's plane Π_Q. CONFIRMED.
- Cross-check of the record's own formula against the Lean polynomial: under a+b+c = 0, a² = (b+c)², so a² + 2bc = a² + (b+c)² − b² − c² = 2a² − b² − c². The record's two expressions for x agree exactly on the constraint surface, which is the surface `nu_sq` lives on.

## 5. Question (c): the polarisation in `Q_lin`

- [Qop2_add](../lean/HamiltonsCubic/Results/L219Prod.lean#L41) is Q(x+y) = Qx + Qy + 2 foxProd2 x y, proved by unfolding foxProd2 = ½(Q(X+Y) − QX − QY). This is the definition of the Jordan-type product rearranged, and holds for any operators.
- `hAB` rewrites σ_A + σ_B = −σ_C by `sig_sum`, then Q(−σ_C) = (−1)²Q(σ_C) by `Qop2_smul`, then `Q_sig` for σ_C. So Q(σ_A + σ_B) = Q_C, the brief's "Q(σ_A+σ_B) = Q(−σ_C) = Q(σ_C)".
- `hfox` then gives 2 σ_A∘σ_B = Q_C − Q_A − Q_B, and the main line expands Q(xσ_A + yσ_B) = x²Q_A + y²Q_B + 2xy σ_A∘σ_B using `Qop2_smul` and bilinearity of foxProd2 (`foxProd2_smul_left`, `foxProd2_smul_right`). Sound. CONFIRMED.
- The three `Q_sig` instances carry the right index orders. `Q_sig` states Qop2 (sig4 i k j l) = coordOp (W4 i k j l), and W4 i k j l has off-diagonal weight 1 on ij, il, kj, kl (from the ind2 outer products) and −2 on ik, jl (from 2 u u ᵀ with u = e_i − e_k, e_j − e_l). So Q_A has −2 on ik/jl, Q_B = W4 i j k l has −2 on ij/kl, Q_C = W4 i l j k has −2 on il/jk.

## 6. Question (d): does the file prove "ν∘ν ∈ Π_Q" in full

- The operator ν∘ν in the record is ν² + ν#ν. `Qop2 R = compOp2 R + sharpMapCL R` ([Bivectors2.lean:825](../lean/HamiltonsCubic/Base/Bivectors2.lean#L825)) is that operator.
- Π_Q ⊂ 𝒟_n is a set of diagonal operators, the image of the sectional plane under the map K ↦ coordOp(K). `coordOp a` acts by X ↦ skewPart(a ⊙ X), so on skew X it reads only the off-diagonal entries of a, which is why `Wcomb_pattern` can match W4's nonzero diagonal against PiQ's zero diagonal through `coordOp_congr_off`.
- Hence `Qop2 ν = coordOp (PiQ i j k l x y z)` with x+y+z = 0 is the statement ν∘ν ∈ Π_Q with the named pattern, not merely something weaker. The equality with a specific element is stronger than membership, because it also fixes which element.
- What the file does not do: it defines no set or predicate for Π_Q, and it does not state x+y+z = 0 as a lemma. A reader must supply both, the second being `ring`. Recorded as O1.
- The record's route (character χ_Q² = 1 puts ν∘ν in 𝒟_n, support leaves Q only through factors outside ν's support, then the pattern on Q) is replaced by a different and complete route: V_Q = span(σ_A, σ_B) from `four_eq_sig`, the three squares from `Q_sig`, and polarisation. It is a proof of the same conclusion by other means. Recorded as O2.
- Verdict: CONFIRMED WITH OBSERVATIONS.

## 7. Question (e): what remains, and the INDEX row

- Of step 2's "Three products", FourProd.lean supplies the second. "$\Pi_Q$ is a subalgebra of $\mathcal D_n$" and "$D\circ\nu\in V_Q$ by L120" are not in FourProd.lean. BlockSub.lean's `S_mul` gives closure of S_Q under ∘, per the record's status note, which is weaker than D∘ν ∈ V_Q. Neither owed statement appears as a lemma in the files the row cites.
- lean/INDEX.md's L220 result row (line 152, beginning `| [L220](../findings/second-order.md)`) says, correctly: "**Step 2's $\nu\circ\nu\in\Pi_Q$ with its pattern, PROVED** in FourProd.lean".
- The same row's **Owed** list then says: "step 2's products, that $\Pi_Q$ is a subalgebra of $\mathcal D_n$, $\nu\circ\nu\in\Pi_Q$ with its pattern, and $D\circ\nu\in V_Q$ as an operator statement". The middle item is the one this commit proved. The row therefore contradicts itself, and the commit message's own account ("Step 2 still owes Π_Q as a subalgebra and D∘ν ∈ V_Q") is the accurate one. REFUTED AS STATED. Recorded as O3, with the fix: delete "$\nu\circ\nu\in\Pi_Q$ with its pattern," from the owed list.
- The record's L220 italic status note in findings/second-order.md likewise still says "The Lean owes step 2's products ($\Pi_Q$ a subalgebra, $\nu\circ\nu\in\Pi_Q$ with its pattern, $D\circ\nu\in V_Q$)". Recorded as O4.

## 8. Hand evaluation (exact, by hand, a screen only)

Take n = 4, Q = {0,1,2,3} with (i,j,k,l) = (0,1,2,3), and ν with signed coordinates (a,b,c) = (1,1,−2), so a+b+c = 0.

- Record's formula at 01 = ij: (ν²)_{ij,ij} = a² = 1 and (ν#ν)_{ij,ij} = 2bc = 2·1·(−2) = −4, so (ν∘ν)_{01} = −3.
- `nu_sq`'s value at ij: 2a² − b² − c² = 2 − 1 − 4 = −3. Agrees.
- Cyclically, the record gives y = b² + 2ca = 1 − 4 = −3 at 02 = ik and z = c² + 2ab = 4 + 2 = 6 at 03 = il. `nu_sq` gives 2b² − c² − a² = 2 − 4 − 1 = −3 and 2c² − a² − b² = 8 − 1 − 1 = 6. Both agree, and x + y + z = −3 − 3 + 6 = 0.
- Through the Lean route: ν = a σ_A − b σ_B = σ_A − σ_B, so (x,y) = (1,−1) in `Q_lin`, and at ij the polarised weight is x²·1 + y²·(−2) + xy·(1 − 1 + 2) = 1 − 2 − 2 = −3. Agrees again.
- This is a screen of one point. It supports no claim beyond the kernel-checked identity.

## 9. Observations

- **O1.** Π_Q has no Lean definition as a set, and x+y+z = 0 for `nu_sq`'s triple is left to the reader. A one-line corollary, `nu_sq_mem`, stating ∃ x y z, x+y+z = 0 ∧ Qop2 ν = coordOp (PiQ i j k l x y z), would make "∈ Π_Q" literal and give the later steps (step 4's ν∘ν' ∈ Π_Q ⊥ r) a named handle.
- **O2.** The proof route differs from the record's: the record argues by character and support, the file by span, three squares and polarisation. The conclusion is the same, so the record needs no change, but the INDEX row could say the route is polarisation over the three pairings rather than the record's character argument.
- **O3.** lean/INDEX.md line 152: the **Owed** list still carries "$\nu\circ\nu\in\Pi_Q$ with its pattern", contradicting the PROVED entry in the same row. Delete that item.
- **O4.** findings/second-order.md, L220's status note, still lists "$\nu\circ\nu\in\Pi_Q$ with its pattern" among what the Lean owes, and does not cite FourProd.lean. It should name `nu_sq` and drop the item.
- **O5.** `nu_sq` covers ν∘ν only. Step 4 uses ν∘ν' ∈ Π_Q for ν, ν' ∈ V_Q, the mixed product. It follows from `nu_sq` by polarisation (ν∘ν' = ½(Q(ν+ν') − Qν − Qν') with ν+ν' ∈ V_Q, and Π_Q a linear space), but it is not stated. The owed list should carry it, or a corollary should prove it.
- **O6.** `nu_sq` assumes only distinctness of i,j,k,l, not the record's n ≥ 5. This is a harmless generalisation.
- **O7.** The 25-case trees in `sigC_mat` and `Wcomb_pattern` carry dead `linarith` and `ring` tails (78 linter warnings). The proofs stand, and trimming them is optional hygiene.

## 10. What would falsify each headline

- Claims 1 to 5: a compile error or a `sorryAx` or nonstandard axiom in the audit of FourProd.lean.
- Claim 6: a demonstration that spanVec's second slot orientation (φ_ki) is not the one in which the record's a+b+c = 0 holds, that is, a Weyl element of V_Q whose record-convention coordinates fail a+b+c = 0 while its spanVec coordinates satisfy it.
- Claim 7: a Weyl ν of character χ_Q and a pair p ≠ q where (ν∘ν)_{pq,pq} differs from PiQ's entry, or a definition of Π_Q in the record admitting a diagonal part or a support off Q that PiQ lacks.
- Claim 8: a reading of the row under which the owed "ν∘ν ∈ Π_Q with its pattern" refers to something `nu_sq` does not prove. The mixed product of O5 is the only candidate, and the row does not name it.

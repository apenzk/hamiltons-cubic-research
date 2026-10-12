# r1815: L224Rank.lean, step 5's rank-one pairing, and the r1814 repairs to L57Bridge.lean

*Gate 2 review of [L224Rank.lean](../lean/HamiltonsCubic/Results/L224Rank.lean) and the [L57Bridge.lean](../lean/HamiltonsCubic/Results/L57Bridge.lean) edits at commit ad625a3c, against [findings/second-order.md](../findings/second-order.md), Lemma L224, step 5. Analysis only: one file compiled, one axiom audit, one hand evaluation labelled as such.*

| # | Claim | Verdict |
|---|---|---|
| 1 | `innerOp2_coordOp`: the pairing of two coordinate-diagonal operators at symmetric weights is ½Σ_{i≠l} a_il b_il | CONFIRMED |
| 2 | `uj_swap`, `vy_swap`, `Gy_swap`: G_z is swap-even, the record's "G_z is swap-even" | CONFIRMED |
| 3 | `inner_Zp_Gy` is the record's q_{B'}(z) = c⟨ū, z⟩² at even n, with c = 4t/n | CONFIRMED WITH OBSERVATIONS |
| 4 | v_j + v_k = 0 encodes "j and k lie in different blocks" | CONFIRMED WITH OBSERVATIONS |
| 5 | L57Bridge.lean edits (r1814 O2, O4) | CONFIRMED |
| 6 | lean/INDEX.md's L224 row: the L224Rank sentence, the r1814 sentences, and the owed list | CONFIRMED WITH OBSERVATIONS |

**Summary: the file proves what it says, and the pairing identity matches the record's constant exactly at even n (c = 4t/n). The odd-n case, where L57's maximiser has v_a² ≠ 1/n, is outside `inner_Zp_Gy`'s hypotheses, and the INDEX row owes it.**

## 1. The record

Step 5 reads, verbatim: "Since $G_z$ is swap-even, $q_E=q_{B'}$, and expanding, $q_{B'}(z)=(\alpha_A+\alpha_B-2\gamma)\big(\sum_{a\in A'}z_a\big)^2$ with $A'=A\setminus\{j\}$. On $\{\sum z=0\}$ this is $c\langle\bar u,z\rangle^2$ with $\bar u$ the centred indicator of $A'$".

The preceding sentence fixes the setting: "$W'$ is an L57 maximiser $B'$ with swap-even part $E$ and nonzero odd part, so $j$ and $k$ lie in different blocks $A\ni j$, $B\ni k$ of $B'$, which is block-constant with values $\alpha_A,\alpha_B$ inside the blocks and $\gamma$ across."

## 2. The declarations

- `innerOp2_coordOp`. Unfolds `innerOp2` to the sum over basis pairs, uses `hadamard_phi` to write each image as c_il φ_il, and `inner2_phi_phi` to read the Gram entries. The diagonal term vanishes because φ_ii = 0. Correct, and the factor ½ is the double count of unordered pairs.
- `uj_swap`. u = e_j − e_k is negated by the swap (j ≠ k needed at p = j). `vy_swap`: y vanishes on {j, k} and is unchanged off it. Both by case split, both correct.
- `Gy_swap`. Through `rotR_swap_coordOp`, which states rotR(swapM) of a symmetric-weight coordOp is coordOp of the entry-permuted weight. Every term of `Gy` is quadratic in u or free of it, so the sign from `uj_swap` squares away. This is exactly "G_z is swap-even" in the operator sense in which E is swap-even (`pair_swap_even` uses the same `rotR (swapM j k)`).
- `inner_Zp_Gy`. Off the diagonal Zp(v)_il = v_i v_l + κ with κ = 2/(n(n−2)) − 1/((n−1)(n−2)) at v_a² = 1/n (the `hZ` step). The constant κ part vanishes because the row sums of G_z off the diagonal vanish on the plane (Σu = 0, Σz = 0, uz = 0). The v_i v_l part expands, through `svu2` (Σ v u² = v_j + v_k = 0) and `svu` ((v_j − v_k)² = 4/n), to t⟨v, z⟩².

I re-derived the identity by hand for general v, as a check on the hypotheses. With V = ‖z‖², on the plane,

    ½ Σ_{i≠l} Zp(v)_il G_il = (v_j + v_k) Σ_a v_a z_a² − V v_j v_k − Σ_a v_a² z_a² + ⟨v, z⟩²,

since the (v_i² + v_l²)/(n−2) and constant parts of Zp meet zero off-diagonal row sums of G_z. At v_a² = 1/n and v_j = −v_k the first term is zero and the middle two cancel (V/n − V/n), leaving ⟨v, z⟩². This agrees with the Lean.

## 3. Question 1: the record's constant

Take v = ε/√n on A and −ε/√n on B (ε = ±1), j ∈ A, k ∈ B. Off the diagonal Zp = v_a v_b + κ, so

- α_A = t(1/n + κ), α_B = t(1/n + κ), γ = t(−1/n + κ),
- α_A + α_B − 2γ = 4t/n.

I checked the record's expansion from G_z's entries (K_ja = K_ka = z_a², K_jk = −‖z‖², K_ab = 2z_a z_b) with pairing Σ_{i<l}: the γ-weighted diagonal squares cancel against −γ‖z‖², each block's 2Σ_{a<b} z_a z_b combines with its squares to α(Σ z)², and the cross term 2γ S_{A'} S_{B'} with S_{B'} = −S_{A'} gives (α_A + α_B − 2γ) S_{A'}². The record's formula is right.

With Σz = 0 and z zero at j, k, ⟨v, z⟩ = (ε/√n)(S_{A'} − S_{B'}) = (2ε/√n) S_{A'}, so t⟨v, z⟩² = (4t/n) S_{A'}² = (α_A + α_B − 2γ) S_{A'}². On the plane ⟨ū, z⟩ = S_{A'} (the centring term meets Σz = 0), so **c = 4t/n**, positive since `charOne_eq_even` gives t > 0. `inner_Zp_Gy` is the record's identity at even n, stated through ⟨v, z⟩ rather than ⟨ū, z⟩. The two directions agree on the plane: v restricted off {j, k} is (2ε/√n)ū when Σv = 0, since |A'| = |B'| = n/2 − 1.

## 4. Question 2: the encoding of "different blocks"

At v_a² = 1/n every v_a is ±1/√n, and the blocks of L57's even maximiser are the two sign classes of v. So v_j + v_k = 0 holds exactly when v_j ≠ v_k, that is when j and k lie in different blocks. The encoding is right at even n.

The record's inference to it ("nonzero odd part, so $j$ and $k$ lie in different blocks") also holds: the swap-odd part of t Zp(v) has weight t(v_j − v_k)v_a at (j, a) when v_j² = v_k², which is nonzero exactly when v_j ≠ v_k. That derivation is owed, and the row names it (§6).

At odd n the encoding fails (O1): `charOne_eq_odd` gives v two-valued with values a ≠ −b in general, so v_j + v_k ≠ 0 across the blocks and v_a² ≠ 1/n. The theorem's hypotheses are unsatisfiable by L57's odd maximiser.

## 5. Question 3: swap-even

Yes, see §2. `Gy_swap` is the operator statement rotR(swapM j k)(coordOp G_z) = coordOp G_z, the same frame change under which E is swap-even and D^-_y swap-odd. The deduction q_E = q_{B'} (⟨D^-_y', G_z⟩ = 0 by the swap being an isometry that fixes G_z and negates D^-) is not in the file, and the owed list names it ("$q_E=q_{B'}$ through `Gy_swap`").

## 6. Question 4: the INDEX row

- **L224Rank sentence.** "`innerOp2_coordOp` … `Gy_swap`, $G_z$ is swap-even; **`inner_Zp_Gy`**, $\langle t\,Z'(v)\odot\cdot,G_z\rangle=t\langle v,z\rangle^2$ for $z$ in the plane at $v_a^2=1/n$ and $v_j+v_k=0$, the record's $q_{B'}(z)=c\langle\bar u,z\rangle^2$". Accurate, and the hypotheses are named. Its heading "**Step 5, the rank-one pairing, PROVED**" is accurate to the declaration but does not say even n (O2).
- **r1814 sentences.** "`charOne_eq_odd` … $w=t\,Z'(v)$ with $t>0$, $\sum v=0$, $\sum v^2=1$ and $v$ two-valued on sets whose sizes differ by one (… r1814 O4)" matches the odd statement and r1814's suggested wording. "it carries the forcing half of L57's equality clause, which is the half step 5 uses (O1)" matches r1814 O1. "$\lVert W'\rVert\ne0$ from $s>0$ (r1814 O5)" is valid: ‖W'‖² = ‖E‖² + 2s by `L224_norm` and `L224_step4`, a different route from r1814's (unit W) but sound.
- **Owed list.** It names: the application of the bridge to W', ‖W'‖ ≠ 0, v_j = −v_k from the nonzero odd part, q_E = q_{B'} through `Gy_swap`, the Cauchy-Schwarz equality putting y, x on the line of ū, the odd-n analogue of `inner_Zp_Gy`, the rotation e^{φξ}, the operator equality clause, the L57Block link, and L57's equality clause in block-constant form. Everything that remains is there. The sentence is garbled at one join (O3), and one item is now arguably moot for step 5 (O4).

## 7. Compilation and axioms

- `lake env lean HamiltonsCubic/Results/L224Rank.lean`: exit 0, no errors and no warnings (the files are unchanged between ad625a3c and HEAD).
- `python3 scripts/misc/axiom_audit.py --only L224Rank.lean`: "auditing 5 declarations across 1 files", "5/5 clean -- resting on the standard three alone".

## 8. Hand evaluation (exact, by hand, a screen)

n = 4, j = 0, k = 2, v = (½, ½, −½, −½), t = 1, z = (0, 1, 0, −1). Then v_j + v_k = 0, v_a² = ¼ = 1/n, z_j = z_k = 0, Σz = 0.

- κ = (¼ + ¼)/2 − 1/(3·2) = ¼ − ⅙ = 1/12, and Zp_il = v_i v_l + 1/12 off the diagonal: Zp_01 = ⅓, Zp_02 = −⅙, Zp_03 = −⅙, Zp_12 = −⅙, Zp_13 = −⅙, Zp_23 = ⅓.
- u = (1, 0, −1, 0), V = 2, G_il = u_i² z_l² + z_i² u_l² + V u_i u_l + 2 z_i z_l: G_01 = 1, G_02 = −2, G_03 = 1, G_12 = 1, G_13 = −2, G_23 = 1. These are the record's K_ja = K_ka = z_a², K_jk = −‖z‖², K_ab = 2z_a z_b.
- ½Σ_{i≠l} Zp_il G_il = Σ_{i<l} = ⅓ + ⅓ − ⅙ − ⅙ + ⅓ + ⅓ = **1**.
- ⟨v, z⟩ = ½·1 + (−½)(−1) = 1, so t⟨v, z⟩² = **1**. Equal.
- The record's form: A = {0, 1}, B = {2, 3}, A' = {1}, α_A = α_B = ⅓, γ = −⅙, α_A + α_B − 2γ = 1 = 4t/n, (Σ_{A'} z)² = 1. Equal.

This is one point, a screen of the identity, and establishes nothing by itself.

## 9. Observations

- **O1, even n only.** `inner_Zp_Gy` assumes v_a² = 1/n, which L57's odd maximiser (`charOne_eq_odd`, v two-valued with Σv² = 1 on sets of sizes differing by one) does not satisfy. By the general expansion in §2 the identity does hold at odd n: with v = a on A, b on B, v_j = a, v_k = b, the extra terms are (a + b)(aV_A + bV_B) − ab(V_A + V_B) − (a²V_A + b²V_B) = 0, so ½Σ_{i≠l} t Zp(v)_il G_il = t⟨v, z⟩² = t(a − b)² S_{A'}², giving c = t(a − b)². So the odd analogue is true and a one-hypothesis change (two-valued v with v_j ≠ v_k, in place of v_a² = 1/n and v_j + v_k = 0) would cover both parities in one theorem. The row lists the odd analogue as owed.
- **O2, the heading.** "Step 5, the rank-one pairing, PROVED" could read "at even $n$" so the parity is visible without reading the hypotheses.
- **O3, a garbled join in the owed list.** "…and the odd-$n$ analogue of `inner_Zp_Gy` whose block-constant form gives $q_E=q_{B'}$ of rank one with the line of $\bar u$ as the whole top eigenspace, and the rotation…" splices the new item into the old clause, and "whose" now attaches to `inner_Zp_Gy`. Suggested: "the odd-$n$ analogue of `inner_Zp_Gy`, and the rotation…", the rank-one and eigenspace content being covered by the preceding items.
- **O4, block-constant form bypassed.** `inner_Zp_Gy` works directly with t Zp(v) and never passes through α_A, α_B, γ. So r1814 O3's "L57's equality clause in block-constant form" is no longer needed for step 5. It stays owed for the record's statement of L57, and the row could say it is off step 5's path.
- **O5, Σv = 0 unused.** `inner_Zp_Gy` holds without Σv = 0. It enters only when identifying the top eigenvector of t⟨v, ·⟩² on the plane with ū, which needs v restricted off {j, k} to be centred (true at even n given Σv = 0 and v_j + v_k = 0). At odd n the restriction is not centred and its projection onto the plane is ū up to scale. The owed Cauchy-Schwarz item must take the projection.

## 10. What would falsify each headline

- Claims 1 and 2: a symmetric weight pair, or a z, where the Lean statement fails, which the kernel excludes given a clean compile and audit.
- Claim 3: a block-constant L57 maximiser at even n where α_A + α_B − 2γ ≠ 4t/n, or a z on the plane with ⟨ū, z⟩ ≠ S_{A'}. §3 derives both.
- Claim 4: an even-n maximiser with j, k in different blocks and v_j + v_k ≠ 0, impossible at v_a² = 1/n.
- Claim 5: a change in the L57Bridge statements, which the diff shows is docstring and a dead line only.
- Claim 6: a step of the record's step 5 absent from both the proved declarations and the owed list.

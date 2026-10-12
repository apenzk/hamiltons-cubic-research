# REVIEW r1804: statement fidelity of PairNorm.lean against Lemma L222 items 2 and 3

**Verdict: CONFIRMED WITH OBSERVATIONS.** The four headline declarations of [PairNorm.lean](../lean/HamiltonsCubic/Results/PairNorm.lean) (commit ab08c3c7) state what [Lemma L222](../findings/second-order.md) items 2 and 3 say, in the record's norm convention, and `Sjk_pin_uncond` is a strict generalisation of item 3's pinning. The observations are wording and packaging: one stale clause in the [lean/INDEX.md](../lean/INDEX.md) row, one overstated phrase there, one removable hypothesis, and item 2's last clause living only as an internal `have`.

Footing: analysis only. The one compile was `#print axioms`/`#check` on a scratch file, plus `python3 scripts/misc/axiom_audit.py --only PairNorm.lean`. No screen was run. The n = 4 evaluation below is by hand.

## The record, verbatim

- Preamble, [second-order.md:1591](../findings/second-order.md#L1591): "$\nu=\sum_ax_a\,e_{ja}\odot e_{ka}$ ($a\notin\{j,k\}$, $\sum x=0$, $\lVert\nu\rVert^2=2\lVert x\rVert^2$)".
- Item 2, [second-order.md:1593](../findings/second-order.md#L1593): "$\lVert G_x\rVert^2=3\lVert x\rVert^4$, so $\lVert\nu\circ\nu\rVert=\tfrac{\sqrt3}2\lVert\nu\rVert^2$".
- Item 3, [second-order.md:1594](../findings/second-order.md#L1594): "If $W=D+\nu$ is a unit critical point with $\nu\ne0$, then $\langle D,\hat g\rangle=\theta/\sqrt3$ for $\hat g=G_x/\lVert G_x\rVert$, and $2L_{D^+}D^-=\theta D^-$."
- Norm convention, [conventions.md:85](../findings/conventions.md#L85) and [conventions.md:88](../findings/conventions.md#L88): the half-trace pairing at the $\Lambda^2$ level, making $\{\varphi_{ab}\}_{a<b}$ orthonormal, and plain Frobenius on the pair matrix.

## Claim table

| # | Claim | Verdict |
|---|---|---|
| 1 | `normSq2_coordOp`: $\lVert a\odot\cdot\rVert^2=\tfrac12\sum_{i\ne l}a_{il}^2$, the record's norm on diagonal operators | CONFIRMED |
| 2 | `normSq2_nuX`: $\lVert\nu_x\rVert^2=2\lVert x\rVert^2$ at $\sum x=0$, $x$ read off $\{j,k\}$ | CONFIRMED WITH OBSERVATIONS (O2) |
| 3 | `normSq2_Gy`: $\lVert G_x\rVert^2=3\lVert x\rVert^4$, no sum hypothesis | CONFIRMED |
| 4 | `Sjk_pin_uncond`: item 3's pinning $\langle D,\hat g\rangle=\theta/\sqrt3$ | CONFIRMED WITH OBSERVATIONS (O3, O4) |
| 5 | Helpers `sum_sq_rank_two`, `Dminus_hollow`, `normSq2_Dminus`, `sum_offdiag`, `Gy_sym`, `uj_four` | CONFIRMED (correct as stated, each an elementary identity read against its definition) |
| 6 | [lean/INDEX.md:152](../lean/INDEX.md#L152), the L222 (statement) row on items 1 to 6 | CONFIRMED WITH OBSERVATIONS (O1, O5, O6) |
| 7 | Axioms | CONFIRMED: `normSq2_Gy`, `normSq2_nuX`, `Sjk_pin_uncond`, `normSq2_coordOp` each print `[propext, Classical.choice, Quot.sound]`, and the audit reports 10/10 clean |

## Check 1: the norm convention

- `normSq2 R = innerOp2 R R = ½ Σ_{i,l} inner2(Rφ_il, Rφ_il)` ([Bivectors2.lean:279](../lean/HamiltonsCubic/Base/Bivectors2.lean#L279), [Bivectors2.lean:283](../lean/HamiltonsCubic/Base/Bivectors2.lean#L283)), with `inner2 X Y = ½ tr(XᵀY)`, so `inner2(φ_il, φ_il) = 1` at `i ≠ l` (`inner2_phi_phi`, [WeylTraceSchur.lean:42](../lean/HamiltonsCubic/Results/WeylTraceSchur.lean#L42)).
- The ordered double sum counts each unordered pair twice and the ½ cancels that, so `normSq2 R = Σ_{i<l} ‖Rφ_il‖²`, the Frobenius norm of the pair matrix in the orthonormal basis $\{\varphi_{ab}\}_{a<b}$. That is conventions.md:85/88.
- On `coordOp a`, `Rφ_il = a_il φ_il` (`hadamard_phi`), so the norm is $\sum_{i<l}a_{il}^2=\tfrac12\sum_{i\ne l}a_{il}^2$: the sum over unordered pairs of the sectional values squared, as the record's own proof of item 2 computes it ("The norm over unordered pairs", [second-order.md:1601](../findings/second-order.md#L1601)). The diagonal of `a` is dropped, which matters for `Gy`, whose diagonal is nonzero ([DiagSquare.lean:94](../lean/HamiltonsCubic/Results/DiagSquare.lean#L94) docstring).

## Check 2: the two norms

- `x` enters both theorems only through `vy j k x`, the vector zeroed at `j, k` ([DiagSquare.lean:88](../lean/HamiltonsCubic/Results/DiagSquare.lean#L88)), so $\lVert x\rVert^2$ is `∑ c, vy j k x c ^ 2`, the sum over $a\notin\{j,k\}$ that the record means.
- `normSq2_Gy` carries no sum hypothesis, correctly: the record's computation $2\sum x^4+\lVert x\rVert^4+4\sum_{a<b}x_a^2x_b^2$ never uses $\sum x=0$. Lean's form is the record's at every $x$, a strict generalisation.
- `normSq2_nuX` carries `hsum`, which enters only through `Dminus_weyl` for `normSq2_rotR`'s Weyl hypothesis ([FrameOp2.lean:81](../lean/HamiltonsCubic/Results/FrameOp2.lean#L81)). The record assumes $\sum x=0$ in the preamble, so the statement matches. See O2 on the hypothesis being removable.

## Check 3: `Sjk_pin_uncond` against item 3

- Hypotheses ([PairNorm.lean:133](../lean/HamiltonsCubic/Results/PairNorm.lean#L134)): `D` of character 1, `ν` Weyl of character $\varepsilon_j\varepsilon_k$, `D` self-adjoint, `Qop2 (D + ν) = θ • (D + ν)`, `ν ≠ 0`. Conclusion: `innerOp2 D (Qop2 ν) / √(normSq2 (Qop2 ν)) = θ / √3`.
- ĝ. Lean's is $\nu\circ\nu/\lVert\nu\circ\nu\rVert$. The record's is $G_x/\lVert G_x\rVert$ with $x$ the coordinates of $\nu$. They are the same object by `Q_pair` ([PairIdent.lean:115](../lean/HamiltonsCubic/Results/PairIdent.lean#L115)), which the proof invokes: every such $\nu$ is `nuX j k c` for its coefficients `c` and `Qop2 ν = coordOp (Gy j k c)`. That is item 2's first clause, so the two ĝ agree exactly on the objects the hypotheses admit.
- What the record assumes and Lean drops, and the effect of each:
  - **Unit $W$.** Both sides are homogeneous of degree 1 under $W\mapsto\lambda W$ (then $\theta\mapsto\lambda\theta$, $D\mapsto\lambda D$, ĝ fixed). Dropping it is a strict generalisation.
  - **$D$ Weyl ($D\in\mathcal D_n$).** Lean needs `D` only self-adjoint of character 1. Strictly weaker hypothesis, so a stronger theorem.
  - **$\theta>0$.** The record's item 3 does not assume it, and Lean does not either.
  - **Criticality.** The record's "critical point" is $Q(W)=\theta W$, and for Weyl $W$ this is the unprojected equation since $\mathcal W_n$ is closed under $\circ$ (`isWeyl2_foxProd2`). Lean's `hQ` is that equation with no projection, so it neither weakens nor mismatches.
- Net: every record instance of item 3's pinning is an instance of `Sjk_pin_uncond`, and the Lean is stronger. The second clause of item 3, $2L_{D^+}D^-=\theta D^-$, is `Sjk_odd` in L222Swap.lean and lies outside this file.

## Hand evaluation (not a screen): n = 4, j = 0, k = 1, x = (·, ·, 1, −1)

$\lVert x\rVert^2=2$, $\sum x=0$.

- **$\nu_x$.** `nuX` is $X\mapsto SXD_x+D_xXS$ with $S=E_{01}+E_{10}$ and $D_x=\mathrm{diag}(0,0,1,-1)$. It sends $\varphi_{0a}\mapsto x_a\varphi_{1a}$ and $\varphi_{1a}\mapsto x_a\varphi_{0a}$ for $a\in\{2,3\}$. It kills $\varphi_{01}$, since $\varphi_{01}D_x=D_x\varphi_{01}=0$. It kills $\varphi_{23}$, since $S\varphi_{23}=\varphi_{23}S=0$. The nonzero ordered pairs are $(0,2),(2,0),(0,3),(3,0),(1,2),(2,1),(1,3),(3,1)$, each with `inner2` value $x_a^2=1$. So `normSq2` $=\tfrac12\cdot8=4=2\lVert x\rVert^2$.
- **$G_x$.** Here $u=(1,-1,0,0)$, $v=(0,0,1,-1)$, $U_2=V_2=2$, and `Gy` off the diagonal gives:
  - `Gy(0,2) = Gy(0,3) = Gy(1,2) = Gy(1,3) = 1`, which is $x_a^2$;
  - `Gy(0,1)` $=V_2u_0u_1=-2=-\lVert x\rVert^2$;
  - `Gy(2,3)` $=U_2v_2v_3=-2=2x_2x_3$.
  
  These match the record's $K$. The sum over unordered pairs is $4\cdot1+4+4=12=3\lVert x\rVert^4$.
- **Pinning.** $\langle D,\nu\circ\nu\rangle=\tfrac\theta2\cdot4=2\theta$ and $\lVert\nu\circ\nu\rVert=\sqrt{12}$, so $\langle D,\hat g\rangle=2\theta/\sqrt{12}=\theta/\sqrt3$. $\lVert\nu\circ\nu\rVert^2=12=\tfrac34\cdot16$, which is item 2's last clause.

## Observations

1. **A stale clause remains in the INDEX row.** [lean/INDEX.md:152](../lean/INDEX.md#L152) still describes `crit_pair`'s $G=\nu\circ\nu$ as the operator "which item 2 (owed) identifies with $G_x$". `Q_pair` in PairIdent.lean discharged that identification, and so did `Q_nuX` before it. The clause should read that item 2 (`Q_pair`) identifies it.
2. **The `hsum` hypothesis of `normSq2_nuX` can be dropped** ([PairNorm.lean:73](../lean/HamiltonsCubic/Results/PairNorm.lean#L74)). $\lVert\nu_x\rVert^2=2\lVert x\rVert^2$ holds at every $x$ off $\{j,k\}$, directly from $\nu_x\varphi_{ja}=x_a\varphi_{ka}$, as the hand evaluation shows without using $\sum x=0$. The hypothesis is an artefact of routing through `normSq2_rotR`, which asks for a Weyl operator although a frame change is an isometry on every operator. It matches the record's standing assumption, so fidelity holds. The observation concerns generality only.
3. **Item 2's last clause is not an exported declaration.** $\lVert\nu\circ\nu\rVert^2=\tfrac34\lVert\nu\rVert^4$, the "so" clause of item 2, exists only as `have hG` inside `Sjk_pin_uncond` ([PairNorm.lean:140](../lean/HamiltonsCubic/Results/PairNorm.lean#L140)), at `nuX j k c`. The record's provenance line ([second-order.md:1589](../findings/second-order.md#L1589), commit a97a08a5) says "item 2 is proved in full". The mathematics is proved, but a consumer who wants the clause for an arbitrary $\nu\in V_{jk}$ has no name to cite. A standalone `normSq2_Q_pair` (Weyl $\nu$ of character $\varepsilon_j\varepsilon_k$ ⇒ `normSq2 (Qop2 ν) = 3/4 * normSq2 ν ^ 2`) would close this. It is a two-line lift of `hG`.
4. **The Lean ĝ is written as $\nu\circ\nu/\lVert\nu\circ\nu\rVert$, and the record's as $G_x/\lVert G_x\rVert$.** The statement itself never mentions $G_x$. The two agree through `Q_pair`, which the docstring at [PairNorm.lean:131](../lean/HamiltonsCubic/Results/PairNorm.lean#L132) states. A reader matching the statement to item 3 needs `Q_pair` alongside it, and the INDEX row should name it at the pinning.
5. **"with nothing assumed" overstates** ([lean/INDEX.md:152](../lean/INDEX.md#L152), at `Sjk_pin_uncond`). The theorem assumes criticality, the two characters, $\nu$ Weyl, $D$ self-adjoint and $\nu\ne0$. What it no longer assumes is item 2's norm. The phrase should read "with item 2's norm now proved rather than assumed", which is the file docstring's own wording ([PairNorm.lean:20](../lean/HamiltonsCubic/Results/PairNorm.lean#L19)).
6. **Row ordering and spacing.** In [lean/INDEX.md:152](../lean/INDEX.md#L152) the sentence "Gate 2 on PairSquare: r1800" comes after the PairNorm paragraph rather than after PairSquare's. "item 1's rotation invariance;  item 4" has a double space. Neither changes content. Items 1 to 6 are otherwise accurately split:

   | Item | Status |
   |---|---|
   | 1 | Subalgebra clause proved, rotation invariance owed |
   | 2 | Proved: square, the $G_x$ entries and both norms |
   | 3 | Proved: pinning, and the odd clause via `Sjk_odd` |
   | 4 | Owed |
   | 5 | Only `pair_mass_le` typed |
   | 6 | `crit_pair` |

   **partial** is the right status.

## What would falsify each headline

- `normSq2_coordOp`: the record's operator norm being plain Frobenius on $\Lambda^2$ (conventions.md:88's second reading, $\lVert\varphi_{ab}\rVert^2=2$), which would double every value. conventions.md:85/88 pins the half-trace reading, so this does not occur.
- `normSq2_nuX`: an $x$ off $\{j,k\}$ with $\sum x=0$ and $\lVert\nu_x\rVert^2\ne2\lVert x\rVert^2$, or `nuX` differing from the record's $\sum_ax_a\,e_{ja}\odot e_{ka}$. The second is settled by `nuX_phi_ja`/`nuX_phi_ka` and r1800.
- `normSq2_Gy`: an $x$ with the unordered-pair sum of $G_x$'s off-diagonal entries squared differing from $3\lVert x\rVert^4$. The n = 4 case gives 12 = 12.
- `Sjk_pin_uncond`: a self-adjoint character-1 $D$ and a Weyl character-$\varepsilon_j\varepsilon_k$ $\nu\ne0$ with $Q(D+\nu)=\theta(D+\nu)$ and $\langle D,\hat g\rangle\ne\theta/\sqrt3$. Alternatively, a record instance of item 3 outside the Lean hypotheses: none exists, since each record hypothesis implies the corresponding Lean one.

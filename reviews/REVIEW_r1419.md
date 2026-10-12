# REVIEW r1419: L66 at every n ≥ 4 in Lean, `L66_weyl_n4`, `Pcubic2_restrict_Wc`, `normSq2_restrict_Wc`

Log [agent_logs/r1419.log](../agent_logs/r1419.log). One reviewer, statement fidelity only (the kernel has checked the proofs). Analysis-only: one scratch file elaborated for `#print axioms` and `#check`, and the source file re-elaborated once, each finishing in seconds, no screens beyond that. Record: [findings/support-dichotomy.md](../findings/support-dichotomy.md), Lemma L66 ("no maximizer is $\circ$-decomposable") and its proof's positivity step, with $M(n)$ and the padded $W_{\mathbb{CP}^2}$ read from [findings/conventions.md](../findings/conventions.md). Lean: commit 9fc1ab7f, [L66Positive.lean](../lean/HamiltonsCubic/Results/L66Positive.lean) and the L66 row of [lean/INDEX.md](../lean/INDEX.md). Read against [CP2Real.lean](../lean/HamiltonsCubic/Results/CP2Real.lean) (`Wc`, `mu`, `Wc_weyl`, `Wc_values`, `sqrt32`), [L66Weyl.lean](../lean/HamiltonsCubic/Results/L66Weyl.lean) (`weylR`, `cv`, `weylSphere`, `IsCircDecompWeyl`, `L66_weyl`), [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean) (`restrict`, `isWeyl2_restrict`, `normSq2`, `Pcubic2`) and [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) (`IsWeyl`, `innerOp`, `normSq`, `Pcubic`). `L66_weyl` itself belongs to [r1408](REVIEW_r1408.md) and is cited here, not re-reviewed.

**Standfirst.** `L66_weyl_n4` is the record's Lemma L66 at every $n\ge4$ with the hypothesis $M(n)>0$ discharged. `Wc n` is $\sum_a\mu_a\langle\cdot,\omega_a\rangle\omega_a$ with $\omega_a$ the three self-dual forms on the first four coordinates, orthonormal in the record's pairing, and $\mu=(2,-1,-1)/\sqrt6$, which is padded $W_{\mathbb{CP}^2}$ at unit norm. `Wc_values` gives $\lVert W\rVert=1$, $\operatorname{tr}W^3=1/\sqrt6$ and $\langle W,W^\#\rangle=2/\sqrt6$, so $P=3/\sqrt6=\sqrt{3/2}$, the record's value. The two transfer lemmas carry norm and $P$ to `restrict (Wc_weyl hn)` in `CurvOp2`, where `isWeyl2_restrict` places it in `weylR`. It is therefore a point of the unit Weyl sphere with $P=\sqrt{3/2}$, and `hM` at that point gives $M\ge\sqrt{3/2}>0$. The Lean range $4\le n$ is the record's. The theorem is slightly stronger than the record, since `W` need not be a unit operator and `M` need only be an upper bound attained at `W`. Standard three axioms. **The gaps are textual**: the INDEX row still stamps L66 **partial** and its Gate 2 **pending** although nothing in L66's statement is now owed, it calls `M` "the maximum itself" where the theorem asks only for an attained upper bound, and the file header omits `Pcubic_Wc` and the generalisation.

| Item | Verdict | Reason |
| --- | --- | --- |
| 1a. `Wc n` is padded $W_{\mathbb{CP}^2}$ | CONFIRMED | $\sum_a\mu_a\langle\cdot,\omega_a\rangle\omega_a$, $\omega_a=EJ_aE^{\mathsf T}/\sqrt2$ over the self-dual $J_a$ on $\mathbb R^4$, zero off the first four coordinates, eigenvalues $(2,-1,-1)/\sqrt6$ on $\Lambda^2_+$ and $0$ elsewhere: the $\mathbb{CP}^2$ Weyl tensor padded and normalised. |
| 1b. `Wc n` is a unit Weyl operator with $P=\sqrt{3/2}$ | CONFIRMED | `Wc_weyl` gives all four `IsWeyl` clauses. `Wc_values.1` gives `normSq = 1`, and `Pcubic_Wc` gives $1/\sqrt6+2/\sqrt6=3/\sqrt6=\sqrt{3/2}$ (`sqrt32`), the $\theta$ of [conventions.md](../findings/conventions.md). |
| 1c. `restrict (Wc_weyl hn)` on the unit Weyl sphere | CONFIRMED | `isWeyl2_restrict` is the membership proof for `weylR`, `cv` is the identity on the carrier, and `normSq2_restrict_Wc` with `Wc_values.1` gives `normSq2 (cv B) = 1`, which is `weylSphere`'s defining condition. |
| 1d. $M\ge\sqrt{3/2}>0$ from `hM` | CONFIRMED | `hM B hB1` with `hBP` rewrites to $\sqrt{3/2}\le M$, and $0<\sqrt{3/2}$ by `positivity`. The `rw [← hBP]; rw [hBP]` pair in the first argument is a no-op round trip, cosmetic only. |
| 1e. `L66_weyl_n4` against L66 | CONFIRMED (GENERALISATION) | Conclusion `¬ IsCircDecompWeyl W`, the record's five-clause $\circ$-decomposability (r1408). `hM` is "$M$ bounds $P$ on the unit Weyl sphere" and `hmax` is $P(W)=M$. A record maximizer satisfies both with $M=M(n)$. `W` need not be unit, so the theorem also covers off-sphere operators attaining the bound. |
| 2. Range | CONFIRMED | The record states L66 "for $n\ge4$" and takes $M(n)>0$ "at every $n\ge4$". The Lean hypothesis is `4 ≤ n`, the same range. The record's positivity witness is the sphere products $S^k\times S^l$, $k,l\ge2$, and the Lean one is padded $W_{\mathbb{CP}^2}$, which conventions.md names as giving $M(n)\ge\sqrt{3/2}$. Only $M>0$ enters the argument, so the choice of witness is immaterial. |
| 3a. `Pcubic2_restrict_Wc` | CONFIRMED | `Pcubic2 (restrict _) = Pcubic (Wc n)`, through `Pcubic2_eq_innerOp2`, `foxProd2_self` and the trilinear transfer `foxTri_eq_foxTri2_restrictLin`, with `restrict_eq_restrictLin` identifying the two restrictions by `rfl`. A correct transfer of the cubic form between the bare and bundled layers. |
| 3b. `normSq2_restrict_Wc` | CONFIRMED | `normSq2 (restrict _) = normSq (Wc n)` via `normSq_extend` and `extend_restrictLin_on_skew` on each `phi i j`, so both sides are $\tfrac12\sum_{i,j}\langle W\varphi_{ij},W\varphi_{ij}\rangle$, the same pairing. |
| 3c. `Wc_isLinOp` | CONFIRMED | Additivity and homogeneity of the finite sum, from linearity of `inner2` in its left slot. |
| 4a. L66 row, new passage | CONFIRMED WITH GAP | The objects, lemma names and the claim that `L66_weyl_n4` needs no hypothesis beyond $n\ge4$ are accurate. "the maximum itself" overstates the hypothesis, which is an upper bound attained at `W`, and the generalisation to non-unit `W` is unstated. |
| 4b. L66 row status | CONFIRMED WITH GAP | The row reads **partial** and Gate 2 [r1419](REVIEW_r1419.md) "pending". L66's whole statement (additivity, the strict chain, the instantiation at $\mathcal W_n$, and $M(n)>0$) is now derived, so the row can be marked **proved**, statement typed, with Gate 2 r1408 and r1419. Nothing in L66's statement remains owed. Existence of a maximizer is outside L66's claim, which quantifies over maximizers. |
| 4c. File header | CONFIRMED WITH GAP | Accurate on the four names it lists. It omits `Pcubic_Wc`, which the row cites, and describes `W` as "attaining the maximum `M` of `P` on the unit Weyl sphere" where the theorem asks less. |
| 4d. Punctuation | CONFIRMED | No em dash in the commit's additions. The header's semicolons end bullet items of a list. |
| 5. `#print axioms` | CONFIRMED | `L66_weyl_n4`, `Pcubic2_restrict_Wc` and `normSq2_restrict_Wc` each depend on `[propext, Classical.choice, Quot.sound]`. |

**One-line summary: CONFIRMED WITH GAP.** `L66_weyl_n4` is the record's L66 at every $n\ge4$, with $M(n)\ge\sqrt{3/2}>0$ derived from padded $W_{\mathbb{CP}^2}$ as a unit point of the Weyl sphere, correctly transferred to `CurvOp2`, on the standard three axioms. The gaps are the INDEX row still marked **partial** and pending, its phrase "the maximum itself", and a header that omits `Pcubic_Wc` and the generalisation.

## 1. The witness and the positivity step

**The operator.** [CP2Real.lean](../lean/HamiltonsCubic/Results/CP2Real.lean) builds `Wc n X = Σ_a (μ_a ⟨X, ω_a⟩) ω_a`. The $J_a$ are the three self-dual complex structures on $\mathbb R^4$, and `Emb n` includes $\mathbb R^4$ as the first four coordinates, so `Wc n` vanishes on every bivector orthogonal to $\Lambda^2\mathbb R^4$. With $\mu=(2,-1,-1)/\sqrt6$ this is the $\mathbb{CP}^2$ Weyl tensor, eigenvalues in ratio $2:-1:-1$ on $\Lambda^2_+$ and zero on $\Lambda^2_-$, scaled to $\sum\mu^2=1$. It matches [conventions.md](../findings/conventions.md)'s $u=W_{\mathbb{CP}^2}$ padded to unit norm, $\theta^*=P(u)=\sqrt{3/2}$.

**The values.** `Wc_values` gives `normSq = 1`, `trCube = 1/√6` and `sharpPair = 2/√6`. Read against the eigenvalues: $\operatorname{tr}W^3=\sum\mu^3=(8-1-1)/6\sqrt6=1/\sqrt6$, and $\langle W,W^\#\rangle=2/\sqrt6$ is the $\#$ contribution of the $\mathfrak{su}(2)$ structure, so $P=3/\sqrt6=\sqrt{3/2}$. `Pcubic_Wc` records this and `Wc_theta` (already in CP2Real) is the same fact as $\theta$.

**Into `weylR`.** `B := ⟨restrict (Wc_weyl hn), isWeyl2_restrict _⟩`. The two transfer lemmas give `normSq2 (cv B) = 1` and `Pcubic2 (cv B) = √(3/2)`. So `hM B hB1` is $\sqrt{3/2}\le M$, and $M>0$ follows. `L66_weyl` then applies with every hypothesis supplied.

## 2. Range

The record: "Then for $n\ge4$ no maximizer of $P$ on the unit sphere of $\mathrm{Weyl}_n$ is $\circ$-decomposable", and in the proof "$M(n)>0$ at every $n\ge4$". The Lean theorem takes `hn : 4 ≤ n` and nothing else about $n$. The record's positivity citation is Nienhaus's Proposition 2.25 on $S^k\times S^l$. The Lean witness differs, but the record's own conventions table asserts the same witness and bound, and the proof uses $M>0$ alone.

## 3. The transfers

`restrict_eq_restrictLin` identifies `restrict (Wc_weyl hn)` with `restrictLin Wc_isLinOp (Wc_weyl hn).1` by extensionality and `rfl`, both being `Wc n` on skew matrices. `Pcubic2_restrict_Wc` rewrites `Pcubic2` as $\langle R\circ R,R\rangle$ and applies the layer's trilinear transfer at three copies of the same operator, returning `Pcubic (Wc n)`. `normSq2_restrict_Wc` goes through `normSq_extend` and agrees termwise on the basis `phi i j`. Both are equalities of the record's quantities across the two representations, not approximations, and `lake env lean` re-elaborates the file cleanly at the commit.

## 4. The L66 row and the header

The row's new sentence names `Wc n`, the three lemmas and `L66_weyl_n4` accurately. Two corrections are owed to the row: the status should move from **partial** to **proved** (additivity, the strict chain, the instantiation at $\mathcal W_n$ and now $M(n)>0$ are all derived, and existence of a maximizer is not part of L66), and "the maximum itself" should read "an upper bound $M$ of $P$ on the unit Weyl sphere attained at $W$", with the note that $W$ need not be unit. The Gate 2 cell should cite r1408 and this review with their verdicts. The header should list `Pcubic_Wc` and state the same weaker hypotheses.

## 5. Axioms

```
'HamiltonsCubic.RealLayer.L66_weyl_n4' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.RealLayer.Pcubic2_restrict_Wc' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.RealLayer.normSq2_restrict_Wc' depends on axioms: [propext, Classical.choice, Quot.sound]
```

No `sorryAx`, no `native_decide` (`Lean.ofReduceBool` absent).

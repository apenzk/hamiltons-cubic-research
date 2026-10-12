# r1101: L209's Bianchi half in Lean against the L209 block

Log: [agent_logs/r1101-L209-bianchi.log](../agent_logs/r1101-L209-bianchi.log). Sole reviewer of a comparison round, reading [L209BianchiHalf.lean](../lean/HamiltonsCubic/Results/L209BianchiHalf.lean) at HEAD 34036693 against the L209 block of [curvature-invariants.md](../findings/curvature-invariants.md) (line 141). What [r1100](REVIEW_r1100.md) settled (`R4`, `R4_pair`, `R4_anti2`, `ric_Qop_eq`, the `Qop`/`sharpOp` normalisation) is taken as settled. All computation below is a screen.

**Verdict: every Lean statement is the block's formula, index for index, in the block's Bianchi convention, under the block's four hypotheses, with Bianchi spent in the $R^2$ form and nowhere in the $\#$ form. The texts claiming it are accurate in what they say is proved. Their list of what `IsWeyl (Qop R)` still owes is incomplete, and two prose places are silent on what is left out.**

| # | claim | verdict |
|---|---|---|
| 1 | B4 is the block's B_ijkl | CONFIRMED |
| 2 | Step 2 four-index forms and R4_sharpOp | CONFIRMED |
| 3 | bianchi_Qop and ric_Qop_flat | CONFIRMED |
| 4 | non-vacuity witness | CONFIRMED (typed witness, plus a screen that the conclusion has content) |
| 5 | axioms | CONFIRMED: propext, Classical.choice, Quot.sound |
| 6 | index, ledger and Gate 2 texts | PLAUSIBLE: accurate on what is proved, incomplete on what is owed (F1, F2, F3) |

## Claim 1, B4

The block, Step 2 verbatim: "$(R^\#)_{ij,kl}=B_{ijkl}-B_{ijlk},\qquad B_{ijkl}:=\sum_{p,q}R_{ip,kq}\,R_{jp,lq}$".

- Lean line 37: `B4 R i j k l = ∑ p, ∑ q, R4 R i p k q * R4 R j p l q`, with `R4 R i j k l = inner2 (R (phi i j)) (phi k l)` $=R_{ij,kl}$. So the factors are $R_{ip,kq}$ and $R_{jp,lq}$, both sums over all of $\iota$, matching the block's Latin indices over $1,\dots,n$.
- The sign of `phi` ($E_{ji}-E_{ij}$, the negative of the block's $e_{ij}$) cancels: each factor is even in each of its two $\varphi$'s.

## Claim 2, the Step 2 forms

The block, verbatim: "$(R^2)_{ij,kl}=B_{ikjl}-B_{iljk},\qquad\text{so}\qquad Q(R)_{ij,kl}=B_{ijkl}-B_{ijlk}+B_{ikjl}-B_{iljk}$", obtained by "Two applications of first Bianchi inside $(R^2)_{ij,kl}=\tfrac12\sum_{pq}R_{ij,pq}R_{pq,kl}$, first $R_{ij,pq}=R_{ip,jq}-R_{iq,jp}$ and then $R_{pq,kl}=R_{pk,ql}-R_{pl,qk}$". The block's "What was used" paragraph: "The Bianchi hypothesis is spent in exactly two places, the $R^2$ four-index form of Step 2 and the rewrite of $A_2$ in Step 4".

| theorem | statement (from `#check`) | hypotheses |
|---|---|---|
| `sharpBil_phi_B` | `sharpBil R (phi i j) (phi k l) = B4 R i j k l - B4 R i j l k` | `IsLinOp R`, bivector-preserving, self-adjoint on bivectors. No Bianchi |
| `R4_sharpOp` | `R4 (sharpOp R) i j k l = sharpBil R (phi i j) (phi k l)` | `IsLinOp R` only |
| `R4_compOp_B` | `R4 (compOp R) i j k l = B4 R i k j l - B4 R i l j k` | all four, Bianchi included |

- Composing the first two rows gives $(R^\#)_{ij,kl}=B_{ijkl}-B_{ijlk}$ exactly. The third is $(R^2)_{ij,kl}=B_{ikjl}-B_{iljk}$ exactly.
- `R4_sharpOp` is the right identification: `sharpOp R X = ½ ∑_{x,y} sharpBil R X φ_xy • φ_xy`, pairing with `φ_kl` picks $\tfrac12(\text{sharpBil}(X,\varphi_{kl})-\text{sharpBil}(X,\varphi_{lk}))$, and `sharpBil_neg_right` folds the two. So `R4 (sharpOp R)` is the four-index form of the layer's $R^\#$, whose agreement with the record's $\#$ r1100 settled.
- Bianchi placement matches the block. `hB` is not in scope for `sharpBil_phi_B` (the section's `include` lists only `hR hskew hsym`), and in `R4_compOp_B` it enters only through `hBi2`, $R_{ab,cd}=R_{ac,bd}-R_{ad,bc}$, applied twice (`h1` at $(i,j,p,q)$, `h2` at $(k,l,p,q)$), which are the block's two rewrites up to pair symmetry. Self-adjointness is additionally spent in `hsq` to write $R_{pq,kl}$ as $R_{kl,pq}$, which the block's matrix-product formula carries implicitly.

## Claim 3, bianchi_Qop and ric_Qop_flat

The block, Step 3 verbatim: "Cyclically summing $Q(R)_{ij,kl}$ over $(j,k,l)$ produces twelve $B$ terms that cancel in pairs identically, by relabelling alone with no symmetry of $B$ used, so $b(Q(R))=0$ for every $R\in S^2_B$."

- `bianchi` (WeylReal line 110) is `inner2 (R φ_ij) φ_kl + inner2 (R φ_ik) φ_lj + inner2 (R φ_il) φ_jk`, the block's $R_{ij,kl}+R_{ik,lj}+R_{il,jk}$ term for term. So `bianchi (Qop R) i j k l = 0` for all indices is $b(Q(R))=0$.
- Hypotheses: `IsLinOp R`, bivector-preserving, self-adjoint on bivectors, first Bianchi. That is $S^2_B$ as the block's "What was used" paragraph lists it, the same set r1100 confirmed for `ric_Qop_eq`.
- The proof is the block's: `hQ` writes $Q(R)_{ab,cd}$ as the four-$B$ combination, three rewrites produce twelve `B4` atoms, and `ring` closes it with the atoms opaque, which is "no symmetry of $B$ used". Hand check of the cancellation: the $\#$ parts of the three cyclic terms cancel the $R^2$ parts pairwise ($B_{ijkl}$, $B_{ijlk}$, $B_{ikjl}$, $B_{iklj}$, $B_{iljk}$, $B_{ilkj}$ each once with each sign).
- `ric_Qop_flat` adds exactly `hRic : ∀ a b, Ric R a b = 0` to the four and concludes `Ric (Qop R) a b = 0`, by rewriting with `ric_Qop_eq`. No further hypothesis.

## Claim 4, non-vacuity

- Typed (scratch file importing the module, not committed): `diagW_bianchiQ` and `diagW_B` apply `bianchi_Qop` and `R4_compOp_B` to `diagOp w` for every symmetric `w`, discharging the four hypotheses by `RealLayer.isLinOp_diagOp`, `diagOp_skew`, `diagOp_selfAdjoint`, `diagOp_bianchi`. Exit 0, both on the standard three axioms. This is r1100's witness family.
- On the pair-diagonal locus $b(R^2)$ vanishes by itself ([curvature-invariants.md](../findings/curvature-invariants.md) line 194), so that witness shows the hypotheses satisfiable but not that the cancellation does work. Screen (numpy, seconds, $n=4$, $R$ a sum of four Kulkarni–Nomizu squares of random symmetric matrices, $|b(R)|\le4\times10^{-15}$): $\max|b(R^2)|=79.8$ while $\max|b(R^2+R^\#)|=1.1\times10^{-13}$, and the $B$ form of $R^2$ agrees to $2\times10^{-13}$. So on generic $S^2_B$ the conclusion is a genuine cancellation, as the block's closing paragraph says.

## Claim 5, axioms

`lake env lean` from the lean directory on the scratch file (after the pre-commit tree build had finished, no other Lean process running), exit 0:

```
'HamiltonsCubic.Results.bianchi_Qop' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.Results.ric_Qop_flat' depends on axioms: [propext, Classical.choice, Quot.sound]
'diagW_bianchiQ' depends on axioms: [propext, Classical.choice, Quot.sound]
'diagW_B' depends on axioms: [propext, Classical.choice, Quot.sound]
```

The tree build log (/tmp/lean_tree_build.log) prints the same three for `R4_compOp_B`, `bianchi_Qop` and `ric_Qop_flat` at the file's own lines 216 to 218, and the file is in the root import ([HamiltonsCubic.lean](../lean/HamiltonsCubic.lean) line 484).

## Claim 6, the texts

- [lean/INDEX.md](../lean/INDEX.md) "L209 (statement)" row (line 167): accurate on what is proved (each theorem's content and hypothesis placement as above). State `partial` is right.
- [lean/INDEX.md](../lean/INDEX.md) L234 row (line 172): accurate that both halves are proved and that the orthogonal projection onto $\mathcal W_n$ is absent (grep for `weylProj`, `orthogonalProjection`: none). Owed list incomplete, F1.
- [findings/LEDGER.md](../findings/LEDGER.md) line 142: accurate on what is proved. Owed list incomplete, F1.
- [curvature-invariants.md](../findings/curvature-invariants.md) line 166, the Gate 2 paragraph: accurate on what is proved, silent on what is left out, F2.
- Stale "untyped" claims: none. Searched every git-tracked `.md` file outside reviews/ and ATTEMPTS.md (953 files) for "Bianchi half", `b(Q(R))`, `bianchi_Qop`, "Bianchi" within 40 to 60 characters of "untyped", and L209 near "untyped", "not typed" or "sorry", then every mention of `ric_Qop_eq`, L209FoxClosure or L209BianchiHalf. One omission, F3.

## Findings

- **F1, the owed list for `IsWeyl (Qop R)` names self-adjointness only.** By grep of the Lean tree (`IsSkew (Qop`, `IsSkew (sharpOp`, `IsSkew (compOp`, `Qop_isSkew`, `sharpOp_isSkew`: none), the first clause of `IsWeyl`, that `Qop R` maps bivectors to bivectors, is also untyped. It is easy (`compOp` by `hskew` twice, `sharpOp` as a combination of `phi`'s), but it is owed. And the record's $\mathcal W_n$ is `IsWeylOp` (FoxProduct line 110), which adds `IsLinOp (Qop R)`: additivity of `sharpOp R` in its argument is untyped by grep (`IsLinOp (Qop`, `IsLinOp (sharpOp`, `sharpOp_add`, `sharpBil_add_left`: none), `Qop_smul` being homogeneity in `R`. Places to correct: [findings/LEDGER.md](../findings/LEDGER.md) line 142 ("still owes self-adjointness"), [lean/INDEX.md](../lean/INDEX.md) line 172 ("self-adjointness of `Qop R` on bivectors is untyped", given as the whole of what blocks). Line 167's "which also owes self-adjointness" is literally true and would be complete with the bivector clause and linearity added.
- **F2, the Gate 2 paragraph states the proved halves and not the gap.** Line 166 ends "so both halves of this block are machine-checked". The block's headline is $Q(S^2_B)\subseteq S^2_B$, which also contains Step 3's pair antisymmetry and self-adjointness of $Q(R)$, and the polarisation $X\circ Y\in\mathcal W_n$, none typed. Suggested addition: "`IsWeyl (Qop R)` as one proposition (bivector preservation and self-adjointness of $Q(R)$) and the polarisation to $X\circ Y$ remain untyped".
- **F3, [results.md](../results.md) line 1287 names only the Ricci half.** It is not false, but it omits `bianchi_Qop` in [L209BianchiHalf.lean](../lean/HamiltonsCubic/Results/L209BianchiHalf.lean), so a reader of results.md would take the Bianchi half as untyped.
- **F4, note on the block, not on Lean.** Step 3's "It is a formal identity in $B$ rather than a consequence of Bianchi, and holds off $S^2_B$ too" is true of the $B$ combination and false if read as $b(Q(R))=0$ off $S^2_B$. Screen (numpy, $n=4$, random self-adjoint $R$ on $\Lambda^2$ with $\max|b(R)|=0.97$): $\max|b(R^2+R^\#)|=0.31$, while the $B$ combination's defect is $9\times10^{-16}$. The Lean statement takes the correct reading, carrying `hB` because `R4_compOp_B` needs it. Suggested rewording: "The cancellation is a formal identity in $B$ and holds for any four-index array, but the $B$ form of $R^2$ spends Bianchi, so $b(Q(R))=0$ needs $R\in S^2_B$."

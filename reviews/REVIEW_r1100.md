# r1100: L209's Ricci half in Lean against the L209 block

Log: [agent_logs/r1100-L209-ricci.log](../agent_logs/r1100-L209-ricci.log). Sole reviewer of a comparison round, reading [L209FoxClosure.lean](../lean/HamiltonsCubic/Results/L209FoxClosure.lean) at HEAD 51471545 against the L209 block of [curvature-invariants.md](../findings/curvature-invariants.md) (line 141). All computation below is a screen.

**Verdict: the Lean statement is the block's Ricci identity, in the block's convention and sign, under exactly the block's four hypotheses, and it is sorry-free. Three prose places outside the two audited rows still say it carries a named sorry.**

| # | claim | verdict |
|---|---|---|
| 1 | ric_Qop_eq states the block's Ricci identity, convention and sign | CONFIRMED |
| 2 | hypotheses match the block's proof, no hidden Ricci-flatness | CONFIRMED, one harmless strengthening noted |
| 3 | Qop/sharpOp are the record's Q = R² + R# | CONFIRMED: general-R identity is definitional, the kernel pins the normalisation only at R = id |
| 4 | non-vacuity witness | CONFIRMED by screen: every diagOp w with symmetric w, Ricci not zero |
| 5 | axioms of ric_Qop_eq | CONFIRMED: propext, Classical.choice, Quot.sound |
| 6 | lean/INDEX.md and LEDGER rows | CONFIRMED for both rows. Three stale "named sorry" claims elsewhere (F1) |

## Claim 1, the statement

The block, verbatim: "$Q(R)=R^2+R^\#$ carries $S^2_B(\mathfrak{so}(n))$ into itself with $\mathop{\mathrm{Ric}}(Q(R))_{ab}=\sum_{c,d}R_{ac,bd}\mathop{\mathrm{Ric}}(R)_{cd}$", with conventions "$R_{ij,kl}:=\langle R\varphi_{ij},\varphi_{kl}\rangle$ [...] $\mathop{\mathrm{Ric}}(R)_{ab}=\sum_cR_{ac,bc}$, first Bianchi $R_{ij,kl}+R_{ik,lj}+R_{il,jk}=0$", and $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$.

- Lean conclusion (line 365): `Ric (Qop R) a b = ∑ c, ∑ d, R4 R a c b d * Ric R c d`. Index placement is `R4 R a c b d` = $R_{ac,bd}$, as in the block.
- `R4 R i j k l = inner2 (R (phi i j)) (phi k l)` (line 43) is $\langle R\varphi_{ij},\varphi_{kl}\rangle$. `inner2` is `½ tr(XᵀY)` (WeylReal line 39), matching the block's pairing.
- `Ric R a b = ∑ c, inner2 (R (phi a c)) (phi b c)` (WeylReal line 106) is $\sum_cR_{ac,bc}$. `bianchi` (line 110) is the block's cyclic sum term for term.
- The overall sign of `phi` cancels: both sides are even in each $\varphi$.
- Sign pin: `ric_Qop_id` and `rhs_id` each prove $(n-1)^2\delta_{ab}$ at `R = fun Z => Z`, and `anchors_agree` rewrites by both. This is a real pin: a $-$ reading would give $-(n-1)^2\delta$ on the right against $(n-1)^2\delta$ on the left. It matches the block's "both sides are $(n-1)^2\delta_{ab}$".

## Claim 2, the hypotheses

The block: "Linearity, that $R$ maps bivectors to bivectors, self-adjointness, and first Bianchi: the record's four clauses of $\mathcal W_n$ minus Ricci-flatness."

- `hlin : IsLinOp R`, `hskew`, `hsym` (quantified over skew arguments only), `hB : ∀ i j k l, bianchi R i j k l = 0`. These are `IsWeylOp` (FoxProduct line 110) with the `Ric` clause deleted. No Ricci hypothesis appears anywhere in the chain. Read in `ric_Qop_eq`, `ric_sharpOp_eq`, `ric_sharpOp_eq'` and the `step3` section variables.
- Each is spent: `hlin` in `sharpBil_expand` and `ric_sharpOp_eq_sum`, `hskew` and `hsym` in `ric_compOp_eq` and `T_eq`, `hB` only in `quad_bianchi`. None is idle. r1099 showed by screen that dropping Bianchi makes the `#` half false.
- Note, harmless: `IsLinOp` asks additivity and homogeneity on all matrices, the block only on $\Lambda^2$. Both sides of the identity read `R` on skew inputs only (every argument is a `phi`, a bracket of skew matrices, or an `R`-image of one), so any $\Lambda^2$-linear map composed with the skew projection satisfies the Lean hypotheses with the same values. No generality is lost. Argued, not typed.
- Bianchi use differs in placement: the block spends it twice (the $R^2$ four-index form and $A_2$), Lean once (`quad_bianchi`), because Lean's $R^2$ half `ric_compOp_eq` runs in the $\varphi$ basis and needs only self-adjointness. Same hypothesis set.

## Claim 3, Qop and sharpOp

- `Qop R = fun X => compOp R X + sharpOp R X` (WeylReal line 189, docstring "Hamilton's map `Q(R) = R² + R#`"). `compOp R = R ∘ R`.
- `sharpOp` reassembles `R# X` from its coordinates `sharpBil R X φ_ij` with the ordered-pair ½ (line 153), `sharpBil` is the polarisation of `sharpQF`, and `sharpQF R η = -¼ ∑_{ij} ⟨[η, R[η, Rφ_ij]], φ_ij⟩`.
- Identification with the block's Step 1 compact form at general $R$, by hand: $\langle R^\#\eta,\eta\rangle=\tfrac12\sum_\gamma\langle R[\eta,\varphi_\gamma],[\eta,R\varphi_\gamma]\rangle$ (summing $\varepsilon$ with $\sum_\varepsilon R_{\gamma\varepsilon}\varphi_\varepsilon=R\varphi_\gamma$), then self-adjointness and ad-invariance give $-\tfrac12\sum_\gamma\langle\varphi_\gamma,[\eta,R[\eta,R\varphi_\gamma]]\rangle$, which is $-\tfrac14$ over ordered pairs. That is `sharpQF` exactly, sign and constant. Both steps use only hypotheses `ric_Qop_eq` carries.
- The kernel bridges `sharpOp` to the record's normalisation only at `R = id` (`sharpOp_id` in [StructureConstants.lean](../lean/HamiltonsCubic/Base/StructureConstants.lean) line 217, $\mathrm{id}^\#=(n-2)\mathrm{id}$), and to `Rsharp_full`-style matrices only through the separate $n=4$ rational `sharpMat` of Sharp.lean. Searched: every theorem mentioning `sharpOp` or `sharpQF` under lean/HamiltonsCubic. This does not change what `ric_Qop_eq` means: `sharpOp` is the layer's definition of $\#$ at every $R$, the id anchor fixes the one free constant, and the hand calculation above is the general-$R$ agreement. A reader wanting it in the kernel would need a structure-constant form of `sharpOp`, which the layer does not have.

## Claim 4, non-vacuity

- In the repository: `isWeylOp_zero` (FoxProduct line 116) and `indDir_isWeylOp` (L99Statement line 473) give `IsWeylOp`, which implies all four hypotheses. Both are Ricci-flat, so they witness the hypotheses but not a case where the right side is nonzero. The `id` anchors evaluate both sides at `id` but do not prove `id` satisfies the hypotheses.
- Screen (scratch file, not committed): `diagW_ric` applies `ric_Qop_eq` to `diagOp w` for every symmetric `w`, discharging the four hypotheses by `RealLayer.isLinOp_diagOp`, `diagOp_skew`, `diagOp_selfAdjoint`, `diagOp_bianchi`, and an `example` shows `Ric (diagOp 𝟙) 0 0 = 2` at `Fin 3`. Compiled with exit 0, `'diagW_ric' depends on axioms: [propext, Classical.choice, Quot.sound]`. So the hypotheses hold on a family with nonzero Ricci, and the theorem has content there.

## Claim 5, axioms

`lake env lean HamiltonsCubic/Results/L209FoxClosure.lean` from `lean/`, exit 0, warnings only (unused section variables and simp arguments). Output lines:

```
'HamiltonsCubic.Results.ric_sharpOp_eq' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.Results.T_eq' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.Results.quad_bianchi' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.Results.ric_Qop_eq' depends on axioms: [propext, Classical.choice, Quot.sound]
```

The other seven printed declarations (`ric_Qop_id`, `rhs_id`, `anchors_agree`, `ric_compOp_eq`, `ric_Qop_split`, `ric_sharpOp_eq_sum`, `br_phi_skew`) carry the same three. The file is in the root import ([HamiltonsCubic.lean](../lean/HamiltonsCubic.lean) line 483). The module docstring now says the Ricci half is proved, so r1099's stale-docstring defect is repaired.

## Claim 6, the index rows

- [lean/INDEX.md](../lean/INDEX.md) row "L209 (statement)" (line 167): accurate. It names the four hypotheses, the absence of a Ricci clause, the proof chain in the order the file runs it, both anchors, and leaves out exactly the Bianchi half and the polarisation. State `partial` is right, since those two are untyped (grep of the file: no `b(Q(R))` statement, no `∘` closure).
- [findings/LEDGER.md](../findings/LEDGER.md) line 142: accurate ("machine-checked, `ric_Qop_eq` on the standard three axioms; the Bianchi half is untyped").

## Findings

- **F1, stale absence claims (three places, repository-wide grep of `ric_Qop_eq` near `sorry` in markdown outside reviews/ and ATTEMPTS.md).** Each still says the Ricci half carries a named `sorry`:
  - [curvature-invariants.md](../findings/curvature-invariants.md) line 166, the L209 block's own Gate 2 paragraph: "the statement over the record's `Ric`, `Qop` and `bianchi` with a named `sorry`". Correction: proved, sorry-free on the three standard axioms.
  - [results.md](../results.md) line 1287: "typed as `ric_Qop_eq` [...] with a named `sorry`". Same correction.
  - [lean/INDEX.md](../lean/INDEX.md) line 172, the L234 row: "STATED as `ric_Qop_eq` [...] with a named `sorry` (blocked on the structure-constant form of `sharpOp`)", and "Discharging L209 is the shared blocker". The Ricci half is no longer a blocker there. The Bianchi half and the orthogonal projection still are. The row's state may deserve re-reading by its owner.
  - [ATTEMPTS.md](../ATTEMPTS.md) line 6886 says the same, but it is a dated log entry and correct as history.
- **F2, note.** The kernel's link between `sharpOp` and the record's $\#$ at general $R$ is definitional plus a two-line calculation, with only the `id` normalisation typed. This is adequate for the claim and is recorded so that nobody reads `anchors_agree` as more than a normalisation pin.

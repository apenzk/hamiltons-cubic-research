# REVIEW r1687: L226 item 2's Ricci half at |J| = 3, `ricciFlat_iff` (266aec65)

**Verdict: CONFIRMED WITH GAPS.** `ricciFlat_iff` in [L226Mixed.lean](../lean/HamiltonsCubic/Results/L226Mixed.lean) states the record's two Ricci conditions of item 2 at $k=3$, with $\rho(R_J)$ read through item 3's $(\mathop{\mathrm{tr}}S)I-S$, against the base layer's `Ric`, under exactly the symmetries the record's $S$, $M_a$ and $K$ carry, and it rests on the standard three axioms. "Ricci half" is accurate: of the four clauses of the base layer's `IsWeyl`, the theorem settles the fourth. Two gaps sit in the row's owed list, which names "tracelessness" where the base layer's $\mathcal W_n$ has skew-preservation and self-adjointness, and which leaves item 3's automatic Bianchi and item 3's closing assembly implicit. The record's own Lean paragraph, flagged stale by r1686 (G1), is still stale.

| # | Claim | Verdict |
|---|---|---|
| 1a | Both of item 2's Ricci conditions are stated, in the record's convention for $\mathop{\mathrm{Ric}}$ and $\rho$ | **CONFIRMED** |
| 1b | The hypotheses are the record's: $S$, $M_a$ symmetric, $K$ symmetric with zero diagonal | **CONFIRMED** |
| 1c | $\sum_bK_{ab}$ over all $b$ is the record's $\sum_{b\ne a}K_{ab}$ given $K_{aa}=0$ | **CONFIRMED** |
| 2a | The hypotheses are satisfiable, and both sides of the equivalence take both truth values at admissible data | **CONFIRMED** (by hand) |
| 2b | "Ricci half" describes what is proved relative to item 2 | **CONFIRMED** |
| 3a | The new row sentence claims exactly what the theorem proves | **CONFIRMED** |
| 3b | The owed list is complete and correctly named for item 2 and item 3 at $k=3$ | **CONFIRMED WITH GAPS** (G1, G2) |
| 3c | The record agrees with the row about what the Lean holds | **GAP** (G3, carried from r1686) |
| 4 | Axioms: standard three only | **CONFIRMED** (4/4 clean, a screen by the repo's audit script) |

One line: `ricciFlat_iff` is item 2's Ricci conditions at $k=3$ with no vacuity and no convention slip, while the owed list misnames the remaining $\mathcal W_n$ clauses as "tracelessness" and the record's Lean paragraph still reports `sorry` and the mixed entries as outside the file.

## Attack line 1: statement fidelity

- **Left side.** `∀ i j, Ric (blockOp S M K) i j = 0` over `Fin 3 ⊕ Fin m`, with `Ric R a b = ∑ c, inner2 (R (phi a c)) (phi b c)` ([WeylReal.lean:106](../lean/HamiltonsCubic/Base/WeylReal.lean#L106)). That is the record's $\mathop{\mathrm{Ric}}_{ij}=\sum_rW_{ir,jr}$, the same constant as the fourth clause of `IsWeyl` ([WeylReal.lean:126](../lean/HamiltonsCubic/Base/WeylReal.lean#L126)). Every entry is quantified, both orders included, which matters because `Ric` of a non-self-adjoint map need not be symmetric.
- **First condition.** `S.trace • 1 - S + ∑ a, M a = 0` is $\rho(R_J)+\sum_aM_a=0$ with $\rho(R_J)$ replaced by item 3's $(\mathop{\mathrm{tr}}S)I-S$. The replacement is sound: `Ric_blockOp_J` ([L226Statement.lean:1213](../lean/HamiltonsCubic/Results/L226Statement.lean#L1213)) computes the whole $J$ entry $\sum_{r}W_{pr,qr}$, whose $r\in J$ part is the record's definitional $\rho(R_J)_{pq}=\sum_{r\in J}\langle R_J\varphi_{pr},\varphi_{qr}\rangle$ and whose $r\in A$ part is $\sum_a(M_a)_{pq}$. The theorem therefore carries item 2's condition and item 3's identity for $\rho$ together, which is the record's own reading at $k=3$ (step 5).
- **Second condition.** `(M a).trace + ∑ b, K a b = 0` for every `a : Fin m` is $\mathop{\mathrm{tr}}M_a+\sum_{b\ne a}K_{ab}=0$ at every $a\in A$, via `Ric_blockOp_outer` ([L226Statement.lean:1230](../lean/HamiltonsCubic/Results/L226Statement.lean#L1230)).
- **Hypotheses.** `hS : S.IsSymm` and `hM : ∀ a, (M a).IsSymm` are the record's symmetric $R_J$ (so $S$) and symmetric $M_a$. `hK` and `hK0` are the record's $K$: $W\varphi_{ab}=K_{ab}\varphi_{ab}$ with $\varphi_{ba}=-\varphi_{ab}$ forces $K_{ab}=K_{ba}$, and $K_{aa}$ is undefined in the record, so zero is a normalisation. I checked that it costs no generality: every $K$ case of `blockCoeff` ([L226Statement.lean:64](../lean/HamiltonsCubic/Results/L226Statement.lean#L64)) is gated by `a ≠ b`, so `blockOp` never reads $K_{aa}$ and any record operator is `blockOp` at the zero-diagonal representative. `hK` is load-bearing for the identification: by hand, the `pairing` expansion of $W_{ab,ab}$ is $\tfrac14(2K_{ab}+2K_{ba})$, which is $K_{ab}$ exactly under symmetry.
- **$\sum_b$ versus $\sum_{b\ne a}$.** With `hK0`, the $b=a$ term of `∑ b, K a b` is zero, so the two sums agree term for term. `Ric_blockOp_outer`'s proof discharges exactly this case (`subst hab; simp [hK0]`).
- **Proof structure.** Forward: the $(p,q)$ entries give the matrix equation entrywise after `Ric_blockOp_J`, and the $(a,a)$ entries give the outer condition after `Ric_blockOp_outer`. Backward: four cases on `Sum`, the two mixed ones by `Ric_blockOp_Jout` and `Ric_blockOp_outJ`, the outer-outer one split on `a = b` into `Ric_blockOp_outer` and `Ric_blockOp_outer_ne`. No case is skipped, and the forward direction uses only diagonal outer entries, which is all the record's condition needs.

## Attack line 2: non-vacuity and scope

- **Satisfiable hypotheses.** $S=0$, $M=0$, $K=0$ meet all four, at every $m$.
- **A nontrivial true instance**, by hand at $m=1$ ($n=4$): $S=M_0=\mathop{\mathrm{diag}}(1,-1,0)$, $K=0$. Then $\mathop{\mathrm{tr}}S=0$, so $(\mathop{\mathrm{tr}}S)I-S+M_0=0$, and $\mathop{\mathrm{tr}}M_0+K_{00}=0$. The right side holds at a nonzero operator, the case of L227 and L228's $m=1$ remark (Gate 1 (d), $P=6\mathop{\mathrm{tr}}X_1^3$).
- **A false instance:** $S=I$, $M=0$, $K=0$ gives $(\mathop{\mathrm{tr}}S)I-S=2I\ne0$, so the right side fails and the theorem asserts a nonzero Ricci entry. The equivalence carries content in both directions.
- **"Ricci half".** The base layer's $\mathcal W_n$ is `IsWeyl`: skew-preservation, self-adjointness on bivectors, first Bianchi, and Ricci-flatness. Item 2 says $W\in\mathcal S_J$ is in $\mathcal W_n$ exactly when $R_J$ satisfies Bianchi and the two Ricci conditions hold. `ricciFlat_iff` proves "fourth clause iff the two Ricci conditions" for the block operator at $k=3$. The other half of item 2 is "first three clauses hold for every block operator whose $R_J$ satisfies Bianchi", which is unconditional at $k=3$ by step 5. The label is accurate.
- **The object that would break the claims.** A `blockCoeff` case that read $K_{aa}$ or a non-symmetric part of $K$ or $M_a$ while the theorem's right side did not, so that the conditions were stated for a different operator than the one `Ric` sees. I read all cases of `blockCoeff`: the $K$ cases are gated by `a ≠ b` and the $M$ cases by `a = b`, and the symmetrised $K$ reading is exactly what `hK` removes. A second candidate was a $J$ entry in which $\rho$ came out as $(\mathop{\mathrm{tr}}S)I-S^{\mathsf T}$, invisible under `hS`. It would differ from the record only at non-symmetric $S$, which the record never uses, so no mismatch arises.

## Attack line 3: the row

- **The new sentence** ("`ricciFlat_iff`, item 2's Ricci half at $\lvert J\rvert=3$: the block operator is Ricci-flat exactly when $\rho(R_J)+\sum_aM_a=0$, $\rho(R_J)=(\mathop{\mathrm{tr}}S)I-S$, and $\mathop{\mathrm{tr}}M_a+\sum_bK_{ab}=0$ at every outer $a$; standard three axioms") matches the theorem. It writes $\sum_b$ without mentioning the zero diagonal, which is harmless since the hypothesis is in the statement.
- **G1, "tracelessness" misnames what remains of $\mathcal W_n$.** The owed list reads "membership in $\mathcal W_n$ through first Bianchi and tracelessness". The base layer's `IsWeyl` has no tracelessness clause: tracelessness follows from Ricci-flatness, which this commit proves. What remains for `IsWeyl (blockOp S M K)` at $k=3$ is skew-preservation (`blockOp` outputs a combination of `phi k l`), self-adjointness on bivectors (from the symmetry of `blockCoeff` under `hS`, `hM`, `hK`), and Bianchi. I searched both L226 files and the whole Lean tree for any theorem about `blockOp` beyond the Ricci, cubic, norm, trace and action lemmas (`grep "theorem .*blockOp"`, `grep "IsWeyl (blockOp"`, `grep "bianchi.*blockOp"`) and found none, so all three are owed. The list should name them: "skew-preservation, self-adjointness and first Bianchi of `blockOp`".
- **G2, item 3 at $k=3$ is implicit in the owed list.** Item 3's four identities stand as follows.

| Item 3 clause at $k=3$ | Status |
|---|---|
| $P(R_J)=\mathop{\mathrm{tr}}S^3+3\det S$ and $\mathop{\mathrm{tr}}(R_J\Lambda^2M)=\mathop{\mathrm{tr}}(S\mathop{\mathrm{adj}}M)$ | proved inside `Pcubic_blockOp`, the full cubic with $S$ free |
| $\rho(R_J)=(\mathop{\mathrm{tr}}S)I-S$ | proved inside `Ric_blockOp_J` |
| Bianchi holds automatically | owed, no theorem, and covered only if "the Bianchi clause" is read as this |
| on $\mathcal S_J\cap\mathcal W_n$, $S=N-\tfrac12(\mathop{\mathrm{tr}}N)I$ and $P$ is the displayed formula | not stated as a theorem, now one assembly away (`ricciFlat_iff` forward, `ricciJ_inverse`, `Pcubic_blockOp`) and unnamed in the list |

  The row's "the Bianchi clause" is ambiguous between item 2's reduction to $R_J$'s Bianchi (general $k$) and item 3's "automatic at $k=3$" (a finite statement about `blockOp`). Naming both, and naming the item 3 assembly, would make the list complete. Nothing false is asserted.
- **Scope not in the list, noted for completeness.** That every $W\in\mathcal S_J$ at $k=3$ is some `blockOp S M K` is the block note's character argument, screened by [screen_blockcoeff_L226.py](../scripts/misc/screen_blockcoeff_L226.py) and accepted by earlier L226 reviews. The record takes it as its Setting rather than as part of item 2, so its absence from the owed list is defensible.
- **G3, the record's Lean paragraph.** [second-order.md:1578](../findings/second-order.md#L1578) still says `Ric_blockOp_J` and `Ric_blockOp_outer` are "each closed by a named `sorry`" and that "the vanishing of $\mathop{\mathrm{Ric}}_{pa}$ and $\mathop{\mathrm{Ric}}_{ab}$, the equivalence of item 2 ... are outside the file". r1686 raised this as its G1. This commit adds a third result the paragraph does not know about, the Ricci half of the equivalence, and leaves the paragraph unchanged, so the row and the record now disagree on three counts.

## Attack line 4: axioms

- `python3 scripts/misc/axiom_audit.py --only L226Mixed.lean`, run in the background, reported "auditing 4 declarations across 1 files, 4/4 clean -- resting on the standard three alone". This is a screen of the kernel's report and agrees with the commit message. The count of 4 matches the file: three mixed-entry theorems and `ricciFlat_iff`.

## Repairs owed

- G1: in [lean/INDEX.md](../lean/INDEX.md)'s L226 row, replace "first Bianchi and tracelessness" with "skew-preservation, self-adjointness and first Bianchi of `blockOp`".
- G2: name item 3's automatic Bianchi at $k=3$ and the item 3 assembly on $\mathcal S_J\cap\mathcal W_n$ in the owed list, or state the assembly, which is now a short corollary.
- G3: rewrite [second-order.md:1578](../findings/second-order.md#L1578) to the kernel's state: all four bridge theorems proved, the mixed entries proved in L226Mixed.lean, the Ricci half of item 2 at $k=3$ proved as `ricciFlat_iff`, and the remaining clauses owed as in the row.

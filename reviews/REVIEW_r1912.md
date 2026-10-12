# Review r1912: L199 at every n in Lean, G_eq_sharp_gen

Log: [agent_logs/review-r1912.log](../agent_logs/review-r1912.log). Target: [L199Gen.lean](../lean/HamiltonsCubic/Results/L199Gen.lean) at commit 7917bb60, theorem G_eq_sharp_gen. Source: [findings/bounds.md](../findings/bounds.md), Lemma L199. Index rows: [lean/INDEX.md](../lean/INDEX.md) lines 101 and 102.

*The Lean theorem is exactly the record's quadratic-form content of L199 at every n, in the record's normalisation, under exactly the record's hypotheses, with the standard three axioms. Two stale or underqualified index sentences are the only defects found, and neither touches the theorem.*

| # | claim | verdict |
|---|---|---|
| 1 | innerOp, sharpQF and mixSym carry the record's normalisations, so the Lean identity reads ⟨G_W η,η⟩ = 4⟨(W²#I)η,η⟩ − 4⟨(W#W)η,η⟩ | CONFIRMED |
| 2 | the form identity at every skew η is the operator identity G_W = 4(W²#I) − 4W#W | CONFIRMED WITH OBSERVATIONS |
| 3 | hypotheses match "any symmetric operator on Λ²ℝⁿ" | CONFIRMED |
| 4 | proof steps hexp, hS, hM1, hM2 | CONFIRMED |
| 5 | #print axioms is the standard three | CONFIRMED |
| 6 | INDEX row 102 text and its owed clause | CONFIRMED WITH OBSERVATIONS |

**Summary: CONFIRMED. The theorem is the record's L199 at every n, and the index needs two small edits (O1, O2).**

## Conventions

- inner2 X Y = ½ tr(XᵀY), so each φ_ij with i ≠ j has unit norm and {φ_ij : i < j} is an orthonormal basis of Λ².
- innerOp R S = ½ Σ over ordered (i,j) of inner2 (R φ_ij) (S φ_ij). Since φ_ji = −φ_ij and φ_ii = 0, this is Σ over i < j, the Hilbert–Schmidt pairing on Λ². The record's operator norm ‖R‖² = ¼ Σ R_ijkl² is the same number.
- With A = ad η on Λ², the record's index formula (A#B)_jk = ½ Σ c_jcd c_kef A_ce B_df gives ⟨(A#B)η,η⟩ = ½ Σ ad_dc A_ce ad_fe B_df = −½ tr(ad η · A · ad η · B), using ad_fe = −ad_ef. The sign convention of c cancels because c enters twice.
- mixQF A B η = −¼ Σ_ordered ⟨[η, A[η, Bφ]], φ⟩ = −½ tr_Λ²(ad η · A · ad η · B). So mixQF A B η = ⟨(A#B)η,η⟩, sharpQF W η = mixQF W W η = ⟨(W#W)η,η⟩, and mixSym A B η = ⟨(A#B)η,η⟩ + ⟨(B#A)η,η⟩ = 2⟨(A#B)η,η⟩ since the index formula is symmetric in (A,B) after relabelling c↔d, e↔f.
- Anchor: at A = B = I and η = φ_12, −½ tr(ad²) = ½ ‖ad φ_12‖² = ½ · 2(n−2) = n − 2, the record's id# = (n−2) id. The screen in section 1 confirms id# = (n−2) id at n = 4, 5 through the index formula with the matrix commutator.

## Hypothesis inventory

| hypothesis | Lean | record | used where |
|---|---|---|---|
| W linear | hlin : IsLinOp W, on all matrices | operator on Λ² | hM2, through trace_cyc |
| W preserves Λ² | hskew | operator on Λ² | hS, hM1, e1, trace_cyc side conditions |
| W symmetric on Λ² | hsym, quantified over skew X, Y | "symmetric" | hS, hM1, e1 |
| η a bivector | hη : IsSkew η | x ∈ Λ² | inner2_br_skew, br_skew |

Nothing extra and nothing missing. Linearity on all matrices is no loss, since any linear map on Λ² extends linearly (compose with the skew projection), and W is only ever evaluated at skew arguments (φ_ij, [η, φ_ij], W φ_ij and their brackets). Symmetry is load-bearing: the non-symmetric control in section 1 breaks the identity.

## 1. Normalisations

The Conventions section derives each reading. The Lean right side 2·mixSym(W², I)(η) − 4·sharpQF W η is therefore 4⟨(W²#I)η,η⟩ − 4⟨(W#W)η,η⟩, and the left side innerOp(adComm η W, adComm η W) is ‖[ad η, W]‖² in the record's operator norm. adComm η W X = [η, W X] − W[η, X] is ad η ∘ W − W ∘ ad η. Applied to an eigenvector v_α and paired with v_β it gives (λ_α − λ_β)⟨[η,v_α],v_β⟩, the record's proof line.

The record's statement, verbatim: *"Let $W$ be any symmetric operator on $\Lambda^2\mathbb R^n$ and let $G_W$ be the symmetric operator with $\langle G_Wx,x\rangle=\lVert[\mathrm{ad}(x),W]\rVert^2$, whose diagonal in an eigenbasis is the record's $g_k$. Then $$G_W=4\,(W^2\#I)-4\,(W\#W),$$ with no hypothesis of any kind, not first Bianchi, not Ricci-flatness, not criticality, not a dimension."*

Screen (exact rational arithmetic, seconds, objects built for the purpose). A random integer symmetric matrix S on the φ_ij basis, W X := Σ_a (S c(X))_a φ_a with c(X) the φ-coordinates, a random integer skew η. The Lean definitions evaluated literally (ordered-pair sums, inner2 with the ½):

| n | Lean LHS | Lean RHS | ηᵀ(4(W²#I) − 4W#W)η from the record's index formula | coordinate ‖[ad η, S]‖²_HS | id# = (n−2)id |
|---|---|---|---|---|---|
| 4 | 14040 | 14040 | 14040 | 14040 | yes |
| 5 | 82494 | 82494 | 82494 | 82494 | yes |

Control at n = 4 with S non-symmetric: Lean LHS 10027 against RHS −1936. So the screen can see a failure, and hsym is needed, matching the row-101 note that the n = 4 identity fails at non-symmetric R. This is a screen of the constants, and the derivation in section 4 is what establishes them.

Cross-check with the n = 4 theorem: G_eq_sharp in [L199Statement.lean:210](../lean/HamiltonsCubic/Results/L199Statement.lean#L210) states Gmat R = 4 sharpBil(R², 1) − 4 sharpMat R as a matrix identity at symmetric R over ℚ, and it carries no sorry. Its form (4, −4, W²#I, W#W) agrees with the general statement.

## 2. Form identity against operator identity

G_eq_sharp_gen is a quadratic-form identity: a scalar equation at every skew η. The record defines G_W only through its quadratic form, ⟨G_W x,x⟩ = ‖[ad(x),W]‖², as "the symmetric operator" with that form. W²#I and W#W are symmetric by the index formula. Two symmetric operators with equal quadratic forms on all of Λ² are equal by polarisation, so the form identity at every skew η is equivalent to the operator identity.

Whether it matters: only formally. The Lean file never types G_W or W²#I as operators, so the off-diagonal entries the record credits as new ("which make the statement an operator identity rather than N scalar ones") are one polarisation step from the theorem and are not themselves a Lean statement. See O3.

## 3. Hypotheses

Covered by the inventory. The record's "no hypothesis of any kind" means none beyond W being a symmetric operator on Λ², and the Lean asks exactly that. No Bianchi, Ricci, criticality or dimension clause appears, and n is a free natural number (n = 0, 1 are vacuous but harmless).

## 4. The proof, derived by hand

Write A = ad η, skew on Λ² for the HS pairing. With T the three sums over ordered (i,j):

- A1 = Σ ‖[η, Wφ]‖² = 2‖A W‖²_HS, A2 = Σ ⟨[η,Wφ], W[η,φ]⟩ = 2⟨AW, WA⟩, A3 = Σ ‖W[η,φ]‖² = 2‖WA‖²_HS.
- hexp: ‖AW − WA‖² expands with inner2 symmetric (inner2_comm) to ½(A1 − 2A2 + A3). Correct.
- hS: sharpQF = −¼ Σ ⟨[η, W[η,Wφ]], φ⟩. inner2_br_skew (L209FoxClosure form ⟨[X,A],B⟩ = −⟨A,[X,B]⟩ at skew X) gives ¼ Σ ⟨W[η,Wφ], [η,φ]⟩, and hsym moves W across to ¼ Σ ⟨[η,Wφ], W[η,φ]⟩ = ¼ A2. Both arguments of hsym are skew by br_skew. Correct.
- hM1: mixQF(W², I) = −¼ Σ ⟨[η, W W[η,φ]], φ⟩ = ¼ Σ ⟨W(W[η,φ]), [η,φ]⟩ = ¼ A3 by one hsym. Correct.
- hM2: mixQF(I, W²) = −¼ Σ ⟨[η,[η, W Wφ]], φ⟩ = ¼ Σ ⟨T(Wφ), φ⟩ with T = −ad²η ∘ W. trace_cyc (S := W, T) swaps it to ¼ Σ ⟨W(T φ), φ⟩ once T is linear and both have skew values on the basis. e1 identifies ⟨W(−[η,[η,Wφ]]), φ⟩ with ‖[η,Wφ]‖² through hsym, inner2_br_skew and the sign. So hM2 = ¼ A1. Correct.
- Assembly: 2(¼A3 + ¼A1) − 4·¼A2 = ½A1 − A2 + ½A3, equal to hexp. Correct.

Independent route: ‖AW − WA‖² = −tr(A²W²) − tr(W²A²) + 2 tr(AWAW) = −2 tr(A W² A) + 2 tr(AWAW) using Aᵀ = −A and cyclicity. By the Conventions, 4⟨(W²#I)η,η⟩ = −2 tr(A W² A) and −4⟨(W#W)η,η⟩ = 2 tr(AWAW). The identity holds.

## 5. Axioms

`#print axioms HamiltonsCubic.L199Gen.G_eq_sharp_gen` gives [propext, Classical.choice, Quot.sound]. Run with lake env lean in lean/ after the running lake exited. The olean (22:22:52) postdates the source (22:21:50), the source is unmodified against 7917bb60, and the file is imported from [HamiltonsCubic.lean](../lean/HamiltonsCubic.lean) line 1076.

## 6. INDEX row 102

Row 102's formula, hypotheses, reading as ⟨G_W η,η⟩ = 4⟨(W²#I)η,η⟩ − 4⟨(W#W)η,η⟩, the named lemmas (inner2_br_skew, trace_cyc) and "standard three axioms" all match the file. "partial" is the right status, since the L131-composed form and the deficit are untyped. The owed clause names both correctly, with one qualifier missing (O2). Row 101 carries a stale sentence (O1).

## Verdict

**CONFIRMED.** G_eq_sharp_gen is the record's L199 at every n as a quadratic-form identity, equivalent by polarisation to the operator identity, under exactly the record's hypotheses, with standard axioms.

Falsifying object: a linear, Λ²-preserving, Λ²-symmetric W on n×n real matrices and a skew η at which innerOp(adComm η W, adComm η W) ≠ 2 mixSym(W², I)(η) − 4 sharpQF W η, or a normalisation under which the Lean right side differs from the record's 4⟨(W²#I)η,η⟩ − 4⟨(W#W)η,η⟩. Looked for by a hand derivation through HS traces sharing nothing with the Lean route, by an exact rational screen at n = 4 and n = 5 evaluating the Lean definitions and the record's index formula side by side on a generic symmetric W (neither Bianchi nor Ricci-flat), and by a non-symmetric control showing the screen detects failure. None found.

## Observations

- **O1.** [lean/INDEX.md](../lean/INDEX.md) row 101 (L199 statement) marks the row **proved** and its text says G_eq_sharp was proved 2026-09-24, while its last column still says "G_eq_sharp keeps its sorry". The file has no sorry at [L199Statement.lean:210](../lean/HamiltonsCubic/Results/L199Statement.lean#L210). That clause is stale and should go.
- **O2.** Row 102's owed clause writes "the deficit 12 Alt(W²)_γγ = 4(2m−1)/(3m)" with no locus. The value holds at W_CP^m only (bounds.md: "At W_CP^m that is 4(2m−1)/(3m)"). The clause should read "at W_CP^m".
- **O3.** The Lean gives the form identity, and the operator identity with its off-diagonal entries is one polarisation away. If the index or record wants to credit the operator form as machine-checked, a corollary polarising through sharpBil and the mixSym analogue would close it. As written the row claims only the form, which is accurate.
- **O4.** The gloss "mixSym A B η = 2⟨(A#B)η,η⟩" in the file's docstring is exact because the record's index formula is symmetric in (A,B). In the Lean itself, mixQF(W², I) and mixQF(I, W²) come out as ¼A3 and ¼A1, which are equal (‖AW‖_HS = ‖WA‖_HS for skew A) but are never shown equal. Nothing depends on it, since the theorem is stated through the sum.
- **O5.** The adComm name is reused with a different meaning in [L199Statement.lean:41](../lean/HamiltonsCubic/Results/L199Statement.lean#L41) (a Fin 6 matrix indexed by j). The namespaces separate them, so this is a readability note only.

# REVIEW r1809: L224's inequality on the operators (L224Bound.lean, commit 4f67778d)

**Verdict: CONFIRMED WITH OBSERVATIONS.** `L224_bound` and `L224_bound_odd` state the inequality half of Lemma L224's Statement on the record's objects, in a homogeneous form equivalent to the record's unit form, with $\theta_0(n)$ at every $n\ge4$ and the record's $\Theta_n$ at odd $n\ge5$. Nothing in the file, the commit message or the index row claims $\Theta_n$ for `L224_bound` at odd $n$, and nothing touches the equality clause. The observations are one stale sentence in the record's L224 block and a converse inclusion that rests on a hand argument.

Footing: analysis only. The runs were one compile with `lake env lean HamiltonsCubic/Results/L224Bound.lean` (exit 0, no output) and one call of `python3 scripts/misc/axiom_audit.py --only L224Bound.lean`. The $n=4$ and $n=5$ objects in section 6 are hand evaluations in exact arithmetic, a screen of tightness at one point each and no evidence for the general claim.

## The record, verbatim

- L224 Statement, [second-order.md:1612](../findings/second-order.md#L1612): "*Let $n\ge4$, $j\ne k$ and $\mathcal S_{jk}=\mathcal D_n\oplus V_{jk}$. Every unit $W\in\mathcal S_{jk}$ has $P(W)\le\Theta_n$. Equality holds exactly when $W=e^{\varphi\xi}\cdot B$ for a unit diagonal $B$ attaining [L57](problem.md)'s equality and an angle $\varphi$, where $\xi$ generates the rotations of the $(j,k)$-plane.*"
- L224 step 4, [second-order.md:1619](../findings/second-order.md#L1619): "Then $q_E(y)+q_E(x)\le\lambda s=q_E(\sqrt s\,z_*)$, so $W'=E+D^-_{\sqrt sz_*}$ is a unit diagonal tensor with $P(W)\le P(E)+3\lambda s=P(W')\le\Theta_n$ by L57."
- L224 step 1, [second-order.md:1616](../findings/second-order.md#L1616): "Every element of $V_{jk}$ is $\nu_x=\sum_ax_a\,e_{ja}\odot e_{ka}$ with $\lVert\nu_x\rVert^2=2\lVert x\rVert^2$, and $\sigma$ fixes it."
- $\theta_0(n)$ row, [conventions.md:18](../findings/conventions.md#L18): "**the closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$, and nothing more.** *It is the value at the balanced sphere product **at even $n$ only**, at odd $n$ the balanced split gives $\Theta_n<\theta_0(n)$, the gap being $\theta_0^2-\Theta_n^2=8(n-1)/(n^2(n+1)(n-2))$ from the identity $(n-2)^2(n+1)-n^2(n-3)=4$.*"
- $\Theta_n$ row, [conventions.md:19](../findings/conventions.md#L19): "the diagonal maximum; equals $\theta_0(n)$ at even $n$, and $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$, **the value is the root, not the radicand**, and dropping it makes $\Theta_n>\theta_0(n)$ at every odd $n$ and so made the diagonal maximum exceed a value attained on the diagonal locus"
- L57, [problem.md:648](../findings/problem.md#L648) (row 57 of [INDEX-results.md](../findings/INDEX-results.md) points to [problem.md](../findings/problem.md)): "Let $\mathcal D_n=\{S\ \text{symmetric, hollow},\ S\mathbf1=0\}$ be the vertex matrices of coordinate-diagonal Weyl operators. Then $\langle Q(W),W\rangle\le\Theta_n\,\|W\|^3$ for every diagonal $W$ at every $n\ge4$, $\Theta_n^2=\frac{2(n-1)(n-2)}{n^2}$ ($n$ even), $\Theta_n^2=\frac{2(n-1)(n-3)}{(n+1)(n-2)}$ ($n$ odd), with equality exactly at $S^{n/2}\times S^{n/2}$ for even $n$ and at $S^{\lfloor n/2\rfloor}\times S^{\lceil n/2\rceil}$ for odd $n$" (display markup flattened, words and symbols as written).

## Claim table

| # | Claim | Verdict |
|---|---|---|
| 1 | `charOne_diag`: a Weyl operator of character $1$ is `restrict (diagOp w)` with `IsWeight w`, and its `Pcubic2`, `normSq2` equal `Pcubic`, `normSq` of `diagOp w` | CONFIRMED |
| 2 | `L224_bound`: $P(D+\nu)\le\frac{\sqrt{2(n-1)(n-2)}}n\,\lVert D+\nu\rVert^3$ at $n\ge4$ | CONFIRMED |
| 3 | `L224_bound_odd`: $P(D+\nu)\le\sqrt{\tfrac{2(n-1)(n-3)}{(n+1)(n-2)}}\,\lVert D+\nu\rVert^3$ at odd $n\ge5$ | CONFIRMED |
| 4 | Q1: the hypotheses "D Weyl of character $1$, $\nu$ Weyl of character $\varepsilon_j\varepsilon_k$" are the record's $W\in\mathcal S_{jk}$ | CONFIRMED WITH OBSERVATIONS (O2) |
| 5 | Q2: homogeneous form equivalent to the unit form | CONFIRMED |
| 6 | Q3: the constants are $\theta_0(n)$ and the record's odd $\Theta_n$, and no text claims $\Theta_n$ for `L224_bound` at odd $n$ | CONFIRMED |
| 7 | Q4: `L57_diagonal`, `L57_diagonal_odd` applied with hypotheses met, `Fintype.card (Fin n) = n` handled | CONFIRMED |
| 8 | Q5: `Pcubic2_restrict`, `normSq2_restrict` are the right bridges | CONFIRMED |
| 9 | Q6: nothing said or implied about the equality clause | CONFIRMED |
| 10 | [lean/INDEX.md:155](../lean/INDEX.md#L155), the L224 row: L224Bound sentence, owed list, state **partial** | CONFIRMED |
| 11 | Axiom audit of L224Bound.lean | CONFIRMED (3/3 on the standard three) |

**Summary:** the file proves exactly the Statement's inequality at both parities under the record's norm, the index row describes it accurately and keeps the four owed items, and the record's own L224 block now understates what the Lean holds (O1).

## 1. The proof chain

Each theorem is four moves. `L224_step4` gives a Weyl $W'$ of character $1$ with `normSq2 W' = normSq2 (D + ν)` and `Pcubic2 (D + ν) ≤ Pcubic2 W'`. `charOne_diag` writes $W'$ as `restrict (diagOp w)` for `IsWeight w` through `L120Ident.trivial_block_iff` and transports `Pcubic2`, `normSq2` to `Pcubic`, `normSq` of `diagOp w`. L57 bounds `Pcubic (diagOp w)` by the constant times `RealLayer.norm (diagOp w) ^ 3`, and `RealLayer.norm` unfolds to `Real.sqrt (normSq ·)` ([WeylReal.lean:177](../lean/HamiltonsCubic/Base/WeylReal.lean#L177)). After `rw [← hnorm, hN]` the goal's right side is exactly L57's, and `linarith` closes the chain $P(D+\nu)\le P(W')=P(\mathrm{diagOp}\,w)\le c\,\sqrt{\cdot}^3$, every term an atom. This is step 4's chain "$P(W)\le\dots=P(W')\le\Theta_n$ by L57" with the unit normalisation replaced by the equality of norms.

## 2. Q1, the domain

- **$\mathcal D_n$.** `trivial_block_iff` is an iff, so "Weyl of character $1$" is exactly the set of `restrict (diagOp w)` with `IsWeight w`, and `IsWeight` ([Families.lean:153](../lean/HamiltonsCubic/Base/Families.lean#L153)) is symmetric, hollow, zero row sums, L57's "$\{S$ symmetric, hollow, $S\mathbf1=0\}$".
- **$V_{jk}$.** The Lean direction is `pair_eq_nuX` ([PairIdent.lean:92](../lean/HamiltonsCubic/Results/PairIdent.lean#L92)): every Weyl operator of character $\varepsilon_j\varepsilon_k$ is some $\nu_x$ with $\sum x=0$. That direction makes the Lean's domain a subset of the record's. The converse, that every record $\nu_x$ with $\sum x=0$ meets the Lean hypotheses, is what makes the Lean theorem cover every record $W$. It holds by hand (O2).
- **Sum form.** The Lean quantifies over the pair $(D,\nu)$ and bounds $D+\nu$, which is every element of the direct sum $\mathcal D_n\oplus V_{jk}$.

## 3. Q2 and Q3, form and constants

- **Homogeneity.** Both sides are homogeneous of degree $3$ under $W\mapsto tW$, $t>0$, and both character sets are closed under positive scaling. At `normSq2 (D + ν) = 1` the Lean reads $P(W)\le c$, the record's unit form. Conversely the unit form at $W/\lVert W\rVert$ gives the homogeneous form at $W\ne0$, and $W=0$ gives $0\le0$. The Lean form carries no nonzero hypothesis, so it is the stronger reading and the two are equivalent.
- **Even $n$.** `L224_bound`'s constant is $\sqrt{2(n-1)(n-2)}/n=\theta_0(n)$, the $\Theta_n$ row's value at even $n$.
- **Odd $n$.** `thetaOddSq n` is $2(n-1)(n-3)/((n+1)(n-2))$ ([L57Odd.lean:26](../lean/HamiltonsCubic/Results/L57Odd.lean#L26)) and the theorem takes `Real.sqrt` of it, the root and not the radicand, as the $\Theta_n$ row insists.
- **No overclaim.** At odd $n$, `L224_bound` gives $\theta_0(n)>\Theta_n$, strictly weaker. The file's docstring says "the record's $\Theta_n$ at even $n$", the commit message says "This is the record's Θ_n at even n", and [lean/INDEX.md:155](../lean/INDEX.md#L155) says "(the record's $\Theta_n$ at even $n$)". None claims $\Theta_n$ at odd $n$ for `L224_bound`.

## 4. Q4 and Q5, the imports

- `L57_diagonal` ([L57Diagonal.lean:443](../lean/HamiltonsCubic/Results/L57Diagonal.lean#L443)) needs `4 ≤ Fintype.card ι` and `IsWeight w`. The first is `hn` after `rw [Fintype.card_fin]`, the second is `charOne_diag`'s output.
- `L57_diagonal_odd` ([L57Odd.lean:82](../lean/HamiltonsCubic/Results/L57Odd.lean#L82)) needs `5 ≤ Fintype.card ι`, `¬ Even (Fintype.card ι)` and `IsWeight w`, each supplied the same way.
- `rw [Fintype.card_fin] at hL` turns the casts `((Fintype.card (Fin n) : ℕ) : ℝ)` into `(n : ℝ)`, so the constant in `hL` is syntactically the goal's. The compile confirms it.
- `Pcubic2_restrict` and `normSq2_restrict` ([L0Witness.lean:35](../lean/HamiltonsCubic/Results/L0Witness.lean#L35)) take `IsLinOp W` and `IsWeyl W` at `W = diagOp w`, supplied by `isLinOp_diagOp w` and the Weyl witness inside `trivial_block_iff`'s `restrict`. They are the bridges from `CurvOp2` to the matrix-operator layer on which L57 is stated, and they preserve both the cubic and the norm, so the constant survives unchanged.
- The norm is the record's: `diagOp_normSq` ([Families.lean:274](../lean/HamiltonsCubic/Base/Families.lean#L274)) gives $\tfrac12\sum_{a,b}w_{ab}^2=\sum_{a<b}w_{ab}^2$, L57's normalisation, which section 6 checks at tightness.

## 5. Q6, the equality clause

The file states two inequalities and `charOne_diag`, no equality, no attainment and no characterisation of maximisers. The docstring quotes only the inequality sentence of the Statement. The index row lists "the Statement's equality clause on the operators" as owed. Nothing says or implies the equality clause.

## 6. Hand evaluations

**Hand evaluation, $n=4$, tight.** Take $\nu=0$ (character $\varepsilon_j\varepsilon_k$ and Weyl trivially) and $D=$ `restrict (diagOp w)` with $w$ the $S^2\times S^2$ vertex matrix, blocks $\{1,2\},\{3,4\}$, $w_{ab}=2$ inside a block and $-1$ across. Row sums $2-1-1=0$, hollow, symmetric.
- $\sum_{a,b}w_{ab}^3=4\cdot8+8\cdot(-1)=24$.
- $w$ has eigenvalues $0,-2,-2,4$ (on $\mathbf1$, on $(1,-1,0,0)$ and $(0,0,1,-1)$, on $(1,1,-1,-1)$), so $\operatorname{tr}w^3=-8-8+64=48$.
- `diagP` ([Families.lean:666](../lean/HamiltonsCubic/Base/Families.lean#L666)) gives $P=\tfrac12(24+48)=36$.
- `diagOp_normSq` gives $\lVert D\rVert^2=\tfrac12(4\cdot4+8\cdot1)=12$.
- $P/\lVert D\rVert^3=36/(12\sqrt{12})=3/\sqrt{12}=\sqrt{12}/4=\theta_0(4)=\Theta_4\approx0.866$, the conventions table's $\Theta_4=0.866$.

So `L224_bound` holds with equality at this $(D,\nu)$, and the constant cannot be lowered at $n=4$.

**Hand evaluation, $n=5$, the two constants.** $\theta_0(5)^2=24/25=0.96$ and $\Theta_5^2=16/18\approx0.889$ from `thetaOddSq 5`$=2\cdot4\cdot2/(6\cdot3)$. The gap $0.96-0.8889=0.0711$ matches conventions.md's $8(n-1)/(n^2(n+1)(n-2))=32/450$. L57's sphere-product formula at $S^2\times S^3$ gives $2\cdot4\cdot1\cdot2/(3\cdot2\cdot3)=16/18$, so `L224_bound_odd` is tight at $\nu=0$ on that product and `L224_bound` is not.

## 7. The index row

[lean/INDEX.md:155](../lean/INDEX.md#L155):
- The sentence "**The Statement's inequality, PROVED on the operators** in L224Bound.lean: `charOne_diag` ... **`L224_bound`**, $P(D+\nu)\le\theta_0(n)\lVert D+\nu\rVert^3$ at $n\ge4$ (the record's $\Theta_n$ at even $n$), and **`L224_bound_odd`** ... at odd $n\ge5$ (the record's $\Theta_n$ at odd $n$)" is accurate declaration by declaration.
- The owed list reads "step 5's $q_E=q_{B'}$ and rotation action, and the Statement's equality clause on the operators; the link from L57Block.lean's proved L57 to the polynomial core `pair_value_le`'s hypothesis (the operator bound above takes L57 directly); L57's equality clause in block-constant form". All four required items are named.
- The state is **partial** and L224Bound.lean is in the file column.

## 8. Axiom audit

`python3 scripts/misc/axiom_audit.py --only L224Bound.lean`: "auditing 3 declarations across 1 files", "3/3 clean -- resting on the standard three alone".

## Observations

- **O1. The record's L224 block lags the Lean.** [second-order.md:1611](../findings/second-order.md#L1611) still ends "The Lean owes step 5 ..., the link from L57Block.lean's proved theorems to `pair_value_le`'s hypothesis ..., and the statement assembled at the operators", and names no L224Bound.lean. The inequality half is now assembled. The block should name `L224_bound`, `L224_bound_odd` and narrow the owed item to the equality clause.
- **O2. The converse inclusion $V_{jk}\subseteq$ {Weyl of character $\varepsilon_j\varepsilon_k$} is a hand fact here.** A sign change $\varepsilon$ scales $e_{ja}$ by $\varepsilon_j\varepsilon_a$ and $e_{ka}$ by $\varepsilon_k\varepsilon_a$, so $\nu_x$ by $\varepsilon_j\varepsilon_k$. First Bianchi is automatic for $e_{ja}\odot e_{ka}$ with distinct $j,k,a$ paired only at equal $a$, and the Ricci contraction's only entry is the $(j,k)$ one, $\sum_ax_a$, which vanishes at $\sum x=0$. The claim is unaffected, since [lean/INDEX.md](../lean/INDEX.md)'s L222 row takes $V_{jk}$ in Lean to be the character-$\varepsilon_j\varepsilon_k$ operators, but a reader reading $V_{jk}$ as the span of the $\nu_x$ has no Lean declaration for this direction.
- **O3. `L224_bound_odd`'s `5 ≤ n` is implied by oddness and $n\ge4$.** It mirrors `L57_diagonal_odd`'s hypothesis and costs nothing.
- **O4. `L224_step4` carries no dimension bound**, so the $n\ge4$ hypothesis enters only through L57, as in the record, where step 4 alone uses no bound on $n$.

## What would falsify each headline

- **Claims 2, 3:** a compile error or a non-standard axiom in the audit of L224Bound.lean, or a `IsWeight w` whose `diagOp` beats L57's constant (which would refute L57Diagonal or L57Odd, not this file).
- **Claim 4:** a record element $W\in\mathcal S_{jk}$ outside $\{D+\nu\}$ with the Lean hypotheses, which would need a $\nu_x$ with $\sum x=0$ failing Weyl or the character, against O2's computation.
- **Claim 5:** a scaling under which one side is not cubic, which would need `normSq2` not to be quadratic.
- **Claim 6:** any sentence in the file, commit 4f67778d or [lean/INDEX.md:155](../lean/INDEX.md#L155) attributing $\Theta_n$ at odd $n$ to `L224_bound`. None was found.
- **Claim 9:** a declaration in the file concluding an equality or an attainment. None exists.
- **Claim 10:** an owed item among the four missing from the row, or a state other than **partial**. Neither holds at commit 4f67778d.

# REVIEW r1790: statement fidelity of commit 7fd117da (BlockSub.lean against L220 steps 1 and 3)

Gate 2 reader, Lean layer. Analysis-only footing: the only computation run was one scratch file of `#print axioms` and `#check` compiled with plain `lake env lean`, which finished in under a minute. No numerical screen was run.

## The record, verbatim

[second-order.md:1528](../findings/second-order.md), Statement: *Let $n\ge5$, $Q=\{i,j,k,l\}$, $V_Q$ the four-set block of character $\chi_Q$ and $\mathcal S_Q=\mathcal D_n\oplus V_Q$. Every unit critical point $W=D+\nu$ of $P$ in $\mathcal S_Q$ with $\nu\in V_Q$, $\nu\ne0$ and $\theta>0$ has $\theta\le\sqrt{3/2}$, with equality exactly at padded $W_{\mathbb{CP}^2}$ on $Q$. Hence at $n\ge12$, $\sup P=\Theta_n$ on the unit sphere of $\mathcal S_Q$, attained only on $\mathcal D_n$.*

[second-order.md:1532](../findings/second-order.md), Setting: $\Pi_Q\subset\mathcal D_n$ is the plane of sectional matrices supported on $Q$, $K_{ij}=K_{kl}=x$, $K_{ik}=K_{jl}=y$, $K_{il}=K_{jk}=z$ with $x+y+z=0$, unit when $2(x^2+y^2+z^2)=1$. Write $D=q+r$ with $q\in\Pi_Q$, $r\in\mathcal D_n\ominus\Pi_Q$, and in the pairing basis of $V_Q$ with signed coordinates $\nu=a\,e_{ij}\odot e_{kl}+b\,e_{ik}\odot e_{jl}+c\,e_{il}\odot e_{jk}$, $a+b+c=0$.

[second-order.md:1536](../findings/second-order.md), step 1: **$\mathcal S_Q$ is a subalgebra and its maximum is critical.** $\mathcal S_Q$ is the fixed space of $\ker\chi_Q\subset\Gamma$, since the only characters of L120's decomposition trivial on $\ker\chi_Q$ are $1$ and $\chi_Q$: a four-set character $\chi_{Q'}$, $Q'\ne Q$, is $-1$ on the single flip at an index of $Q'\setminus Q$, which lies in $\ker\chi_Q$, and a pair character $\varepsilon_a\varepsilon_b$ is $-1$ on the flip at $a$ when $a\notin Q$, or on $\varepsilon_a\varepsilon_c$ with $c\in Q\setminus\{a,b\}$ when $a,b\in Q$. A fixed space of automorphisms is a subalgebra, so the maximum of $P$ on its unit sphere satisfies $Q(W)=\theta W$ in $\mathcal W_n$. *Where the maximiser has $\nu=0$ it is diagonal and L57 bounds it by $\Theta_n$.*

[second-order.md:1538](../findings/second-order.md), step 3: **Split the equation.** $Q(W)=D\circ D+2D\circ\nu+\nu\circ\nu$, so $D\circ D+\nu\circ\nu=\theta D$ and $L_D\nu=\tfrac\theta2\nu$.

## Claim table

| # | Claim | Verdict | Note |
|---|---|---|---|
| 1a | `InS {i,j,k,l}` is the record's $\mathcal S_Q=\mathcal D_n\oplus V_Q$ | CONFIRMED WITH OBSERVATIONS | `InS` is a strictly larger space (no Weyl condition). $\mathcal S_Q=\mathrm{InS}\,Q\cap\mathcal W_n$ holds but is unstated (O1) |
| 1b | `L220_sub` is step 1's subalgebra clause | CONFIRMED WITH OBSERVATIONS | closes `InS`, which with `isWeyl2_foxProd2` closes $\mathcal S_Q$. The Weyl-intersected form is not typed, unlike the pair case's `Sjk_mul_weyl` (O1). Non-distinct indices degrade $Q$ to a smaller set without making anything false (O2) |
| 2a | `fixed_of_S`: $\mathcal S_t$ is fixed by $\ker\chi_t$ | CONFIRMED | proved on all of `InS`, a superset of the record's inclusion |
| 2b | `ker_sep`: a sign vector in $\ker\chi_t$ with $\chi_u=-1$, every nonempty $u\ne t$ | CONFIRMED | correct at $u\subsetneq t$, $u\not\subseteq t$ and $t=\varnothing$ (O3) |
| 2c | `comp_zero_of_fixed` with `sum_comp` gives step 1's fixed-space identification | CONFIRMED WITH OBSERVATIONS | the reverse inclusion follows in three lines and is mathematically complete, but it is not assembled as a theorem, while lean/INDEX.md:149 calls `comp_zero_of_fixed` "step 1's identification" (O4) |
| 3 | `L220_split` is step 3 | CONFIRMED | a genuine strengthening: no Weyl, unit norm, $\nu\ne0$ or $\theta>0$. True in that generality, since the character argument uses only sign-equivariance of `Qop2` (O5) |
| 4 | lean/INDEX.md:149 describes what BlockSub proves and what is owed | CONFIRMED WITH OBSERVATIONS | the proved part overstates in two small ways (O1, O4). The owed list omits items the scalar chain takes as hypotheses (O6). The record's L220 note does not cite BlockSub.lean (O7) |

**Summary**: the statements are faithful, and `L220_split` is strictly stronger than step 3. The defects are all on the index and record side: two missing assembly corollaries that the INDEX speaks as if typed, an incomplete owed list, and a stale citation in the record.

## Axioms

`#print axioms` from a scratch file compiled with `lake env lean`:

| Declaration | Axioms |
|---|---|
| `HamiltonsCubic.BlockSub.L220_sub` | propext, Classical.choice, Quot.sound |
| `HamiltonsCubic.BlockSub.L220_split` | propext, Classical.choice, Quot.sound |
| `HamiltonsCubic.BlockSub.comp_zero_of_fixed` | propext, Classical.choice, Quot.sound |
| `HamiltonsCubic.BlockSub.char_split_zero_t` | propext, Classical.choice, Quot.sound |
| `HamiltonsCubic.BlockSub.ker_sep` | propext, Classical.choice, Quot.sound |
| `HamiltonsCubic.BlockSub.fixed_of_S` | propext, Classical.choice, Quot.sound |

`#check @L220_split` prints the statement as in [BlockSub.lean:190-192](../lean/HamiltonsCubic/Results/BlockSub.lean): `SignChar (fun _ => 1) D → SignChar (setChar {i,j,k,l}) ν → Qop2 (D + ν) = θ • (D + ν) → foxProd2 D D + foxProd2 ν ν = θ • D ∧ 2 • foxProd2 D ν = θ • ν`.

## Observations

**O1. `InS` is larger than $\mathcal S_Q$, and the identification with the Weyl intersection is unstated.** [BlockSub.lean:78-79](../lean/HamiltonsCubic/Results/BlockSub.lean) defines `InS t R` as $R=D+\nu$ with $D$ of character $1$ and $\nu$ of character $\chi_t$, over `CurvOp2 ι`, which is every continuous linear map on $\Lambda^2$ ([Bivectors2.lean:247](../lean/HamiltonsCubic/Base/Bivectors2.lean)). Character $1$ forces $D$ diagonal in the basis $e_{ab}$ (two distinct pairs have nonempty symmetric difference, so some sign vector separates them), with arbitrary weights $K_{ab}$. The record's $\mathcal D_n$ adds zero row sums, which is what [trivial_block_iff](../lean/HamiltonsCubic/Results/L120Ident.lean) (L120Ident.lean:49) reads under `IsWeyl2 V`. Character $\chi_Q$ forces $\nu$ to map each $e_{ij}$ to its complementary pairing $e_{kl}$ with six free coefficients, where $V_Q$ is two-dimensional ([four_block_iff](../lean/HamiltonsCubic/Results/L120Ident.lean), L120Ident.lean:72, again under `IsWeyl2 V`). So `InS Q ∩ IsWeyl2` $=\mathcal S_Q$ is the correct reading, and it is true: for Weyl $R=D+\nu$, $D=$ `comp ∅ R` and $\nu=$ `comp Q R` by uniqueness of the isotypic split, so each summand is Weyl by `comp_isWeyl2`, and the two `_iff` lemmas then apply summand by summand. None of this is stated. `L220_sub` closes `InS`, and with `isWeyl2_foxProd2` ([L24Restrict.lean:64](../lean/HamiltonsCubic/Results/L24Restrict.lean)) closes $\mathcal S_Q$, but the pair case has `Sjk_mul_weyl` for exactly this and BlockSub has no four-set analogue. This is r1789 O5 recurring at the four-set. **Falsifier of 1a as the INDEX reads it**: none for the mathematics. The gap is a missing corollary, `InS t R ∧ IsWeyl2 R ↔ ∃ D ν, IsWeyl2 D ∧ IsWeyl2 ν ∧ ...`.

**O2. Non-distinct indices.** `L220_sub` and `L220_split` take `{i, j, k, l} : Finset ι` with no distinctness hypothesis ([BlockSub.lean:184](../lean/HamiltonsCubic/Results/BlockSub.lean), [190](../lean/HamiltonsCubic/Results/BlockSub.lean)). Both are instances of `S_mul` and `S_crit` for arbitrary (nonempty) $t$, so they remain true when the set collapses. At $\lvert t\rvert=2$ they restate the pair case of L222Op. At $\lvert t\rvert\in\{1,3\}$ every operator of character $\chi_t$ is zero even without Weyl, since $\{a,b\}\triangle\{c,d\}$ always has even size, so the theorems reduce to the diagonal case. Nothing is wrong. The docstrings' "at a four-set $Q$" (lines 183, 188) describe the intended instance and the hypotheses admit more.

**O3. `ker_sep` at the boundaries** ([BlockSub.lean:128-148](../lean/HamiltonsCubic/Results/BlockSub.lean)).
- $u\subsetneq t$: $a\in u$, $c\in t\setminus u$ (so $a\ne c$), $\varepsilon=\mathrm{sgn}_a\mathrm{sgn}_c$. Then $\chi_t(\varepsilon)=(-1)(-1)=1$ and $\chi_u(\varepsilon)=-1$. Correct.
- $u\not\subseteq t$: $m\in u\setminus t$, $\varepsilon=\mathrm{sgn}_m$. Then $\chi_t=1$ and $\chi_u=-1$. Correct, and this branch covers the record's $Q'\setminus Q$ flip and its "flip at $a\notin Q$".
- $t=\varnothing$: every nonempty $u$ falls in the second branch, and $\ker\chi_\varnothing$ is the whole group. Correct.
- $u=\varnothing$ is excluded by `hu`, rightly, since $\chi_\varnothing=1$ is trivial on everything.

The lemma is stronger than the record's witness list, which names only four-set and pair characters. It separates every character $\chi_u$ from $\{1,\chi_t\}$, which is what L120Decomp's projectors over all of `Finset ι` need.

**O4. The fixed-space identification is complete in substance and unassembled.** With `hfix` for a Weyl $R$, `comp_zero_of_fixed` ([BlockSub.lean:166-181](../lean/HamiltonsCubic/Results/BlockSub.lean)) zeroes `comp u R` for every nonempty $u\ne t$. `sum_comp` ([L120Decomp.lean:169](../lean/HamiltonsCubic/Results/L120Decomp.lean)) then gives $R=$ `comp ∅ R` $+$ `comp t R` for nonempty $t$. `comp_char` (L120Decomp.lean:162) gives characters `setChar ∅` $=1$ (empty product) and `setChar t`. So $R\in$ `InS t`, with Weyl summands (O1). Together with `fixed_of_S` this is exactly step 1's "$\mathcal S_Q$ is the fixed space of $\ker\chi_Q$" inside $\mathcal W_n$. The corollary is a few lines and is not in the file. lean/INDEX.md:149 describes `comp_zero_of_fixed` as "step 1's identification of $\mathcal S_Q$ as the fixed space", which is true only after this assembly. The proof route also differs from the record's: the record derives closure from "a fixed space of automorphisms is a subalgebra", while `S_mul` multiplies characters directly (`foxProd2_char2`, [L222Op.lean:52](../lean/HamiltonsCubic/Results/L222Op.lean)). Both are valid, and the Lean route does not depend on the fixed-space identity. **Falsifier**: a Weyl $R$ fixed by $\ker\chi_Q$ with a nonzero pair component. `comp_zero_of_fixed` excludes it.

**O5. `L220_split` is a true strengthening.** Step 3 in the record uses only $Q(W)=\theta W$ and the characters of $D$ and $\nu$. Unit norm, $\nu\ne0$ and $\theta>0$ first enter at steps 5 and 9. The Weyl condition is also unneeded: `foxProd2_char2` needs only that `Qop2` commutes with conjugation by the orthogonal sign matrices, which holds on every `CurvOp2`. `char_split_zero_t` then separates the character-$1$ and character-$\chi_Q$ parts using one sign vector with $\chi_Q=-1$. The hypothesis is the unprojected `Qop2 (D + ν) = θ • (D + ν)`. For Weyl $W$ this is the record's criticality in $\mathcal W_n$ with no loss, because $Q(W)\in\mathcal W_n$ (`isWeyl2_foxProd2`). The conclusion `2 • foxProd2 D ν = θ • ν` is $L_D\nu=\tfrac\theta2\nu$ with $L_D=D\circ\cdot$. **Falsifier**: a $D$ of character $1$ and $\nu$ of character $\chi_Q$ with $Q(D+\nu)=\theta(D+\nu)$ and $D\circ D+\nu\circ\nu\ne\theta D$. None exists, since the difference has character $1$, equals minus a character-$\chi_Q$ operator, and so vanishes.

**Non-vacuity.** The layer has no padded $W_{\mathbb{CP}^2}$ as a `CurvOp2` carrying `SignChar` proofs. `grep CP2` finds `WCP2` in [Base/CP2.lean](../lean/HamiltonsCubic/Base/CP2.lean) (a rational $6\times6$ matrix), [Families.lean:826](../lean/HamiltonsCubic/Base/Families.lean) (a map on $4\times4$ matrices) and `omU` in [DefectCP2.lean](../lean/HamiltonsCubic/Results/DefectCP2.lean), and no file that mentions `SignChar` mentions CP2. So the record's equality case is not cheaply available at operator level, and no non-trivial witness was built. The hypotheses are inhabited trivially ($D=\nu=0$ at any $\theta$), and by any diagonal critical point with $\nu=0$. Since the conclusion is proved for all inputs, a witness bears only on vacuity, and the hypotheses are plainly satisfiable.

**O6. INDEX:149's owed list is incomplete against the chain's hypotheses.** The row lists as owed "step 1's criticality of the maximiser on $\mathcal S_Q$'s sphere in $\mathcal W_n$, $\nu\circ\nu\in\Pi_Q$ and the pattern of step 2, $L_r\nu=0$, and the eigenvalue step, which enter as the chain's hypotheses". The chain `theta_sq_le` ([L220Statement.lean:28-31](../lean/HamiltonsCubic/Results/L220Statement.lean)) also takes `hunit` (the orthogonal split $\lVert q\rVert^2+\lVert r\rVert^2+\lVert\nu\rVert^2=1$), `hpair` (step 6's pairing of the $\mathcal D_n$ equation with $q$), `hp` (step 7 at operator level, $P(q)=18xyz$, of which only the polynomial inequality is typed) and `hκ` (step 8 at operator level, the spectrum $\{0,2x,2y,2z\}$ of $\hat q$ and $\kappa\le\max(x,y,z)\lVert q\rVert\lVert r\rVert^2$, of which only the two scalar lemmas are typed). Step 2's first clause, $\Pi_Q$ a subalgebra of $\mathcal D_n$, is also absent from the list. Step 2's third clause, $D\circ\nu\in V_Q$, is covered by `foxProd2_char2`, and the row could say so. Separately, the row ends with a stray second "**statement: typed**" after the owed sentence.

**O7. The record's L220 note does not cite BlockSub.lean.** [second-order.md:1526](../findings/second-order.md) says "The scalar chain and both polynomial inequalities are kernel-checked in L220Statement.lean" and names nothing for steps 1 and 3. The L222 note at second-order.md:1575 cites L222Op.lean's operator lemmas by name. L220's note needs the same for `L220_sub`, `L220_split` and `comp_zero_of_fixed`. Minor, outside this commit: [L220Statement.lean:14-23](../lean/HamiltonsCubic/Results/L220Statement.lean) numbers the chain's hypotheses as "steps 3 to 6" and "step 5", from the I100 derivation's numbering. In the record they are steps 5 to 8.

## Falsifiers of the headline statements

| Statement | Object that would refute it |
|---|---|
| `L220_sub` | $x,y\in$ `InS Q` with $x\circ y$ having a component of character outside $\{1,\chi_Q\}$. Excluded because $\chi_Q^2=1$ |
| `comp_zero_of_fixed` | a Weyl $R$ fixed by $\ker\chi_t$ with `comp u R ≠ 0` for some nonempty $u\ne t$. Excluded by `ker_sep`'s separating vector |
| `L220_split` | $D$ of character $1$ and $\nu$ of character $\chi_Q$, critical, with the $\mathcal D_n$ or $V_Q$ equation failing. Excluded by `char_split_zero_t` |
| INDEX:149 "step 1's identification" | the absence of a stated `Fix(ker χ_Q) ∩ W_n = S_Q` theorem (O4). It is a documentation gap, and the statement itself holds |

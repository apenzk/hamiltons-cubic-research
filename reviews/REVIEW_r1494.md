# Review r1494: the bivector model of 𝒲ₙ ∩ T_uS identified with the layer's tangent Weyl operators in Lean, closing L17, and r1493's gap repaired

Gate 2 review of commit ea824cca: the new [Results/L17WeylIdent.lean](../lean/HamiltonsCubic/Results/L17WeylIdent.lean) (`ofB`, `ofB_apply`, `coords_ofB`, `opB_ofB`, `ofB_opB`, `opBEquiv`, `opB_mem_weylT`, `isWeyl2_ofB`, `weylT2`, `mem_weylT2`, `finrank_weylT2_12`), milestone 6 of [the Weyl-dimension plan](2026-09-26-lean-weyl-dimension-plan.md), the record edits for it ([lean/INDEX.md](../lean/INDEX.md) line 480, now **proved**, [INDEX-results.md](../findings/INDEX-results.md) line 32, [route-a.md](../findings/route-a.md) line 93), and the repair of [r1493](REVIEW_r1493.md)'s gap E-1. One reviewer. Analysis-only rule inherited: the only compute was the module build (8773 jobs, "Build completed successfully", the one `sorry` warning being L16Statement.lean's open conjecture) and `scripts/misc/axiom_audit.py`, once with `--only L17WeylIdent` and once with `--only L17` to cover the row's other files.

| item | claim | verdict |
| --- | --- | --- |
| A | `mem_weylT2` states that `weylT2 n` is exactly $\{R:\texttt{IsWeyl2}\,R,\ \langle R,u_2\rangle=0\}$, the record's $\mathcal W_n\cap T_uS$, and `finrank_weylT2_12` states the record's $1637$ | CONFIRMED |
| B | `ofB_opB`, `opB_ofB`, `opBEquiv`, `isWeyl2_ofB`, `opB_mem_weylT`, `mem_weylT2` and `finrank_weylT2_12` are sound, with no hypothesis missing or idle | CONFIRMED |
| C | every clause of Lemma L17's statement and of its "Its size" paragraph has a Lean theorem, so the row's **proved** is justified | CONFIRMED |
| D | every declaration of L17WeylIdent.lean rests on `propext`, `Classical.choice`, `Quot.sound` only | CONFIRMED |
| E | no edited sentence overstates, and r1493's E-1 is repaired | CONFIRMED WITH GAP |
| F | no em dash, no clause-splicing semicolon, no backticks in link text, no hard-wrapped markdown prose | CONFIRMED |

**Summary: the Lean is sound and on the standard three axioms, `opB` is a linear equivalence whose preimage of `weylT` is exactly the layer's tangent `IsWeyl2` operators, and `finrank_weylT2_12` gives $1637$ for them. Every clause of the lemma's statement and size paragraph now has a theorem, so **proved** is justified. r1493's E-1 is repaired. One gap: lean/INDEX.md line 480 says "every clause of the block is proved", while five prose claims of the block (route-a.md lines 83, 89, 91, 93 and 95) have no Lean theorem. CONFIRMED WITH GAP.**

## A. Fidelity

- **The space.** `mem_weylT2 (hn : 4 ≤ n) (R) : R ∈ weylT2 n ↔ IsWeyl2 R ∧ innerOp2 R (u2 hn) = 0` (L17WeylIdent.lean line 88). `IsWeyl2` (Base/Bivectors2.lean line 352) is the record's $\mathcal W_n$ on the domain $\Lambda^2$: self-adjoint against `inner2`, first Bianchi, Ricci-flat, the fourth clause (bivectors to bivectors) being the type `CurvOp2`. `innerOp2` is the record's pairing with the domain changed. **Faithful to $\mathcal W_n\cap T_uS$.**
- **The competitor.** route-a.md's Setting (line 182) takes $u$ the $\mathbb{CP}^2$-type competitor of unit norm, and the block commits to the padded reading (line 99). `u2 hn` is `restrict (Wc_weyl hn)`, CP2Real's padded $W_{\mathbb{CP}^2}$, and its norm is $1$: `normSq2_restrict_Wc` (L66Positive.lean line 56) with `Wc_values` gives `normSq2 u2 = 1`, used as such in WeylMaximiser.lean line 208. Tangency $\langle H,u\rangle=0$ is scale-invariant in $u$ anyway, so the tangent space is the record's under either normalisation. **Faithful.**
- **The count.** `finrank_weylT2_12 : finrank ℝ (weylT2 12) = 1637` (line 97) is then $\dim\mathcal W_{12}\cap T_uS=1637$ for the layer's own objects. **The record's number, on the record's space.**

## B. Soundness

- **`coords_ofB`, `opB_ofB`.** `ofB H X = toSkew (H (coords X))` by `rfl`. `coords_toSkew` gives `coords (ofB H X) = H (coords X)`, and `opB (ofB H) c = coords (ofB H (toSkew c)) = H (coords (toSkew c)) = H c`, the second use of `coords_toSkew`. **Sound.**
- **`ofB_opB`.** `ofB (opB R) X = toSkew (coords (R (toSkew (coords X))))`. `toSkew_coords X.2` collapses the inner `toSkew (coords X)` to `X`, then `toSkew_coords (R X).2` the outer pair, both needing only skewness, which the subtype carries. **Sound.**
- **`opBEquiv`.** Additivity is `opB_add_smul R S 1` with `one_smul`. Homogeneity unfolds `opB_apply` and pushes `c` through `coordsL` by `map_smul`. `left_inv` and `right_inv` are the two identities above. **Sound.**
- **`opB_mem_weylT`.** The four `weylT` clauses (L17WeylDim.lean line 154): symmetric by `opB_isSymmetric hR.selfAdjoint`, $\mathrm{Alt}=0$ by `alt4_opB_eq_zero hR`, $\mathrm{Ric}=0$ since `ric (opB R) a b = ∑ k compOf (opB R) a k b k = ∑ k inner2 (applyPhi R a k) (phi b k)` by `compOf_opB`, which is `hR.ric a b` verbatim, and $\operatorname{tr}(\mathrm{opB}\,R\circ u)=0$ by `innerOp2_eq_trace` and `opB_u2` applied to `hT`. **Sound.**
- **`isWeyl2_ofB`.** `hc` rewrites `inner2 (applyPhi (ofB H) i j) (phi k l)` as `compOf (opB (ofB H)) i j k l` and then `compOf H i j k l`. Self-adjointness: `inner_coords` turns both sides of `IsSelfAdjoint2` into Euclidean inner products of coordinates, `coords_ofB` moves `H` inside, and `hS` (symmetry of `H`) closes it. Bianchi: `alt4` is $\tfrac13$ of the three cyclic terms, so its vanishing gives the unscaled sum $=0$ by `linarith`, and after `hc` that sum is `IsWeyl2.bianchi`'s three terms with the same index order ($ijkl$, $iklj$, $iljk$ against $(ij,kl)$, $(ik,lj)$, $(il,jk)$). Ricci: `hc` makes it `ric H a b = 0`. Tangency: `innerOp2_eq_trace hsa`, `opB_ofB`, `opB_u2` turn it into `hT`. All four of `hS`, `hA`, `hR`, `hT` are used. **Sound.**
- **`mem_weylT2`.** `weylT2 n` is `(weylT n).map opBEquiv.symm`. `Submodule.mem_map_equiv` reads membership as `opBEquiv.symm.symm R ∈ weylT n`, and `LinearEquiv.symm_symm` makes it `opB R ∈ weylT n`. The reverse direction is `opB_mem_weylT`. The forward direction applies `isWeyl2_ofB` to `opB R` and rewrites `ofB (opB R) = R`. The direction of the equivalence is the right one. **Sound.**
- **`finrank_weylT2_12`.** `LinearEquiv.finrank_map_eq` gives `finrank (weylT2 12) = finrank (weylT 12)`, and `finrank_weylT_12_eq` gives $1637$. **Sound.**
- **Hypotheses.** `hn : 4 ≤ n` enters only through `u2 hn` and `opB_u2`, which need it. No hypothesis is idle, none missing. **CONFIRMED.**

## C. The row's new state

The block is route-a.md lines 65 to 99. Each clause of its statement and of "Its size", with the theorem that proves it, all audited clean (`axiom_audit.py --only L17`, 379/379 on the standard three):

| clause | Lean |
| --- | --- |
| $u$ critical, $Q(u)=\sqrt{3/2}\,u$ | `Wc_crit`, `innerOp2_Qop2_u2` (L17Phi.lean) |
| $d^+\delta^2(u;H)=-2aF(H)\le0$ at every $n\ge4$, $H\in\mathcal W_n$ tangent | `L17_at_u` (L17Close.lean), carried to `IsWeyl2` in `L17` |
| $d^+\Phi(u;H)=2a\kappa_nF(H)$, $\le0$ when $\kappa\le0$ | `L17` (L17Phi.lean line 280) |
| $d^+\Phi\le0$ at $n\ge12$ | `L17_ge12` with `kappaPen_neg` (L17Phi.lean line 323) |
| "exactly those $n$": $\kappa_n>0$ and a tangent Weyl $H$ with $d^+\Phi>0$ at $4\le n\le11$ | `L17_converse`, `kappaPen_pos`, `Wb_weyl`, `Wb_tangent`, `Wb_F_pos` (L17Converse.lean) |
| crossover $\Theta_{11}^2<\tfrac32<\Theta_{13}^2$, both parities | `theta_11_13`, `crossover_even`, `crossover_odd` (L17Statement.lean) |
| $\{F=0\}$ is a linear subspace, $\Pi_{ASD}H\Pi_{\ker u}=0$ | `F_eq_zero_iff`, `F_zero_add`, `F_zero_smul` (L17Cone.lean) |
| three families not closed, $8/9$ reading | `list_not_closed`, `eight_ninths_bracket` (L17.lean) |
| $\operatorname{codim}\{F=0\}\le186$ at $n=12$ | `L17_codim`, `L17_codim_12` (L17Codim.lean) |
| $\dim\mathcal W_{12}\cap T_uS=1637$ | `finrank_weylT_12`, `finrank_weylT_12_eq`, and for `IsWeyl2` `finrank_weylT2_12` |
| $\dim\{F=0\}\ge1451$ | `L17_dim_12` (L17WeylDim.lean line 306) |

- **`L17_dim_12` and the record's $\{F=0\}\subset\mathcal W_{12}\cap T_uS$.** `L17_dim_12` counts the kernel of `condMap` on `weylT 12` and identifies it with $\{H\in\texttt{weylT}\,12:\texttt{Fval}\,H=0\}$. `L17`'s $F$ at an `IsWeyl2` $R$ is `Fval` of `opB R` term for term (L17Cone.lean line 61 against L17Phi.lean lines 285 to 289). `opBEquiv.symm` carries that kernel onto $\{R\in\texttt{weylT2}\,12:F(R)=0\}$, so the dimension bound transfers by `LinearEquiv.finrank_map_eq`. **Yes, it is the record's set.** No theorem states the transported form, and the transport is one line. Noted, not a gap.
- **Clauses outside the statement and "Its size".** Five prose claims have no theorem, listed under E-1. None is part of the lemma's statement, and the lean-loop convention sets a row's state by the axiom audit of its theorems (SKILL.md line 86). **proved is justified.** **CONFIRMED.**

## D. Axioms

`python3 scripts/misc/axiom_audit.py --only L17WeylIdent`: "auditing 8 declarations across 1 files, 8/8 clean, resting on the standard three alone". `--only L17`: 379/379 clean across 30 files. The build's one `sorry` warning is L16Statement.lean line 123, the open conjecture `L16`, which no audited declaration reaches (`kappaPen` is a definition there). **CONFIRMED.**

## E. Record accuracy

- **INDEX-results.md line 32.** "Lean: proved: the lemma is proved", with each named theorem matching the table in C and "a bivector model identified with the layer's Weyl operators" linking L17WeylIdent.lean. Exact.
- **route-a.md line 93.** "`mem_weylT2` and `finrank_weylT2_12` ... identify that model with the layer's own tangent Weyl operators through the linear equivalence `opBEquiv`." Exact. The preceding "Equality needs those conditions independent ... which is not shown" still concerns the codimension $186$ and stays true.
- **The plan.** Milestone 6 is marked proved with the right three names, and "What it does not give" now names only the independence of the $186$ conditions. Exact.
- **r1493's E-1, repaired.** lean/INDEX.md line 480 no longer mentions `admissible_opB`, and its new sentence names `opBEquiv`, `mem_weylT2` and `finrank_weylT2_12` correctly.

**Gap E-1.** lean/INDEX.md line 480 ends "With the [L17 (statement)] row every clause of the block is proved." (the commit body says the same). The block carries five prose claims with no Lean theorem:

1. route-a.md line 83: tangency is load-bearing because $H=u$ gives $F=-\tfrac2{\sqrt6}$.
2. route-a.md line 89: $H=-\star$ is symmetric and tangent with $F=-2<0$ and $d^+\delta^2>0$, excluded only by $\mathrm{Alt}(-\star)\ne0$.
3. route-a.md line 91: $\{F=0\}$ is exactly the set of directions in which $\delta^2$ is two-sided differentiable.
4. route-a.md line 93: $\{F=0\}$ is a proper subspace at $n=12$. It follows in one line from `Wb_weyl`, `Wb_tangent` and `Wb_F_pos`, which hold at every $n\ge4$, but no theorem states it.
5. route-a.md line 95: $\delta^2(u+tH_0)=(1-\lvert t\rvert)^2/9$ at padded $\overline{\mathbb{CP}^2}$. L17Statement.lean line 173 defines `kinkProfile` as that scalar formula and differentiates it, without identifying it with `altNormSqOf` along the path.

The lemma's statement and size paragraph are fully proved (item C), so the state stands. Repair: "every clause of the lemma's statement and of its size paragraph is proved", optionally naming the five prose claims as unformalised.

## F. Style

- No em dash in any added line of the commit (grep count $0$).
- No backticks inside markdown link text in any added line (grep count $0$).
- The semicolons in lean/INDEX.md line 480's new sentence separate items of a list whose items carry commas, the convention r1491 to r1493 accepted.
- The edited markdown lines (route-a.md 93, lean/INDEX.md 480, INDEX-results.md 32, the plan's milestone 6 and "What it does not give") are each one unwrapped line. **CONFIRMED.**

## Verdict

**CONFIRMED WITH GAP.** `opBEquiv` is a linear equivalence with inverse `ofB` through `coords_toSkew` and `toSkew_coords`, `opB_mem_weylT` and `isWeyl2_ofB` carry the four `IsWeyl2`-plus-tangency conditions to the four `weylT` conditions and back, `mem_weylT2` is exact, and `finrank_weylT2_12` gives $\dim\mathcal W_{12}\cap T_uS=1637$ on the layer's own objects, all on the standard three axioms. Every clause of Lemma L17's statement and size paragraph has a theorem, so **proved** is justified. r1493's E-1 is repaired. Open: E-1, lean/INDEX.md line 480's "every clause of the block is proved" covers five prose claims of the block (route-a.md lines 83, 89, 91, 93, 95) that no theorem states.

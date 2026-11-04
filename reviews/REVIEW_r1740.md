# REVIEW r1740: L105's equality case (L105Eq.lean, L105Op.lean additions), L264_one repairs, L261 promotion

**Verdict: CONFIRMED WITH OBSERVATIONS.** Every new statement is faithful to the record in the direction it states, and every proof is sound as read. The observations concern one direction of the record's "exactly at" that is algebra outside Lean, and the operator-level statements taking the stronger hypothesis $\theta\ge\theta_0$ where the record speaks of the min.

Read from the working tree: [L105Eq.lean](../lean/HamiltonsCubic/Results/L105Eq.lean) (new), the diff of [L105Op.lean](../lean/HamiltonsCubic/Results/L105Op.lean), [L264Support.lean](../lean/HamiltonsCubic/Results/L264Support.lean), [lean/INDEX.md](../lean/INDEX.md), `L261_coord_diag` and `coordOp` in [I117Statements.lean](../lean/HamiltonsCubic/Results/I117Statements.lean), Lemma L105 in [bounds-relaxations.md](../findings/bounds-relaxations.md) and Lemma L261 in [second-order.md](../findings/second-order.md). No `lake build` was run. The build artefacts `L105Eq.olean` and `L105Op.olean` are dated 00:44 against sources dated 00:42, and `L264Support.olean` 00:12 against 00:11, so the files as read compiled in the other session's build. None of the three files contains `sorry`. Analysis-only footing: every check below is by hand, and the one numerical check is a screen.

## (1) "Equality in the second inequality" as "both branches $\ge\theta_0$"

- Faithful. With $A=(n-1)w$ and $B=Q/w$, $\min\{A,B\}=\theta_0$ holds exactly when $\min\le\theta_0$ (already `L105_closing`) and $A\ge\theta_0$ and $B\ge\theta_0$. Because $w>0$, $B\ge\theta_0$ is the same as $\theta_0w\le Q$, which is the typed second conjunct.
- The ← direction gives more than the record needs: at $(n-2)u=nw$ it proves $(n-1)w=\theta_0$ exactly (`hA`) and $Q=(n-1)w^2$, so both branches equal $\theta_0$. Hand check: $(n-2)u=nw$ with $uw\,n(n-1)=2$ gives $n^2(n-1)w^2=2(n-2)$, so $((n-1)w)^2n^2=2(n-1)(n-2)$. It also gives $(n-2)Q=n^2w^2-2nw^2-(n-2)w^2=(n-1)(n-2)w^2$.
- Falsifier: a real triple $(n,u,w)$ with $n\ge3$, $u,w>0$, $uwN=1$ and $(n-2)u\ne nw$ where both branches are $\ge\theta_0$. Or one with $(n-2)u=nw$ where a branch falls below $\theta_0$.

## (2) Direction of each strict branch

- **$(n-2)u>nw$ makes the $\Pi$-branch strict. Correct.** Multiplying by $(n-1)^2wn>0$ gives $(n-2)u(n-1)^2wn>n^2(n-1)^2w^2$. The left side is $(n-1)(n-2)\cdot uw\,n(n-1)=2(n-1)(n-2)$, so $((n-1)w)^2n^2<2(n-1)(n-2)$, which means $(n-1)w<\theta_0$.
- **$(n-2)u<nw$ makes the tangent branch strict. Correct.**
  - $Q-(n-1)w^2=((n-2)u-nw)(u+w)$, so $Q\le(n-1)w^2$ (checked by expansion).
  - The identity `iden` is `L105_identity` rearranged, with $Q>0$ taken from $\theta_0w\le Q$. It gives $nQ^2<(n-1)^2(n-2)uw^3$, and after multiplying by $n$ and using $uwN=1$, $n^2Q^2<2(n-1)(n-2)w^2=n^2\theta_0^2w^2$.
  - That contradicts $\theta_0w\le Q$, so $Q/w<\theta_0$.
- Falsifier: a triple with $(n-2)u>nw$ and $(n-1)w\ge\theta_0$, or one with $(n-2)u<nw$ and $Q\ge\theta_0w$.

## (3) `L105_mult` and the record's "exactly at"

- **The algebra is right.** From $ru=sw$ and $(n-2)u=nw$ one gets $rnw=s(n-2)w$ (the `linear_combination` coefficients check), so $rn=s(n-2)$. Substituting $s=N-r$ gives $2r(n-1)=N(n-2)$, and then $4r(n-1)=n(n-1)(n-2)$, so $4r=n(n-2)$. The `e3` combination $2e_2+2(n-2)\,h_{rs}$ expands to exactly $4r(n-1)-n(n-1)(n-2)$.
- **$4r=n(n-2)$ is the record's $r=n(n-2)/4$.**
- **O1. The converse half of "exactly at" is outside Lean.** The record says equality holds **exactly** at $r=n(n-2)/4$, which is an iff. The typed chain proves one direction: $\min=\theta_0$ gives $(n-2)u=nw$ (`L105_eq_iff` →), which gives $4r=n(n-2)$ (`L105_mult`). The other direction is untyped: $4r=n(n-2)$ gives $(n-2)u=nw$, which then gives $\min=\theta_0$ (`L105_eq_iff` ←). `L105_eq_iff`'s ← starts from $(n-2)u=nw$, and no theorem takes $r$ back to $u/w$.
- The missing step is true, as a screen by hand: $N-r=n(n-1)/2-n(n-2)/4=n^2/4$, so $u/w=s/r=n/(n-2)$. It is a two-line converse of `L105_mult` (`L105_mult_rev`: $ru=sw$, $r+s=N$, $4r=n(n-2)$ give $(n-2)u=nw$).
- Until that converse is typed, the row's "The equality case is PROVED" covers the forcing direction and the ← of `L105_eq_iff`, and leaves this link as prose.
- Falsifier of `L105_mult`: reals with $ru=sw$, $r+s=N$, $(n-2)u=nw$, $w>0$, $n\ge3$ and $4r\ne n(n-2)$.

## (4) `L105_odd` and `L105_op_odd`

- **`L105_odd` is correct at every odd $n\ge3$.** With $n=2k+1$, $n(n-2)=4k^2-1$, so $4r+1=4k^2$ over $\mathbb N$, which is impossible mod 4 (`omega` after generalising $k^2$). The cast step is linear in the monomials $r$, $k$ and $k\cdot k$, which `linarith`'s polynomial parser normalises. The hypothesis `hn` is unused and harmless.
- **`L105_op_odd` renders "At odd $n$ the inequality is strict" as $\theta<\theta_0$.** That is the substantive reading and it is proved soundly: $\theta\ge\theta_0$ with `L105_op_eq` gives $4r=n(n-2)$ with $r$ a natural cardinality, and `L105_odd` refutes that.
- **O2.** If "the inequality" means the second one, $\min<\theta_0$, the typed statement is the weaker $\theta<\theta_0$. The stronger form follows from the same parts: `L105_branches`, then `L105_eq_iff` →, `mult_rel`, `L105_mult` and `L105_odd`. It is not typed as such.
- Falsifier: an odd $n\ge3$ and a natural $r$ with $4r=n(n-2)$. At the operator, a unit critical two-eigenvalue linear Weyl operator at odd $n$ with $\theta=\theta_0(n)$.

## (5) `mult_rel`

- **Correct.**
  - `sum_two` with $g=\mathrm{id}$ gives $\sum_j\mu_j=ru-sw$, and `sum_mu_zero` (tracelessness) sets it to $0$.
  - With $g\equiv1$ it gives $r+s=$ the cardinality of the index type of `Mpair`'s eigenvalues.
  - `card_tri` with `Nat.cast_choose_two` identifies that cardinality with $\binom n2=n(n-1)/2=N$, the number of pairs.
- The multiplicities are `Finset.filter` cardinalities of the eigenvalue function, so $r$ is the multiplicity of $u$ as the record means it.
- Screen by hand at $n=6$: $r=6$, $s=9$, $N=15$, $u/w=3/2$, $w^2=2/45$ give $(n-1)w=5\sqrt{2/45}\approx1.0541=\sqrt{40}/6=\theta_0(6)$. This is consistent, reported as a screen.
- Falsifier: a linear Weyl operator whose two-valued `Mpair` spectrum has multiplicities with $r+s\ne N$ or $ru\ne sw$.

## (6) L261's promotion

- **Justified.**
  - `coordOp a` sends a skew $X$ to $\mathop{\mathrm{skew}}(a\odot X)$. For symmetric $a$ that sends $e_{ik}$ to $a_{ik}e_{ik}$, which is $C=\sum_{i<k}a_{ik}e_{ik}e_{ik}^{\mathsf T}$, and the diagonal of $a$ is inert (`coordOp_offDiag`).
  - The hypotheses `ha : aᵀ = a` and `hpos : ∀ i ≠ j, 0 < a i j` are the record's "every $a_{ik}>0$" in symmetric encoding, with no loss because $a_{ki}$ is the same weight.
  - `IsIdem (coordOp a)` is $C\#C=C$.
  - The conclusion `coordOp a = (1/(n-2)) • idOp` is $C=I/(n-2)$, and $n\ge3$ is the record's implicit range.
- The file's only `sorry` sits at line 1977 (`L254_conjA_12`), declared after `L261_coord_diag` at line 1586, so it cannot be a dependency. That is consistent with the author's standard-three axiom audit, which I did not rerun.
- Falsifier: a symmetric $a$ with positive off-diagonal entries at some $n\ge3$ with $\mathop{\mathrm{coordOp}}(a)\#\mathop{\mathrm{coordOp}}(a)=\mathop{\mathrm{coordOp}}(a)\ne I/(n-2)$.

## (7) The updated L105 row

- It claims what is typed, apart from the two readings above. `L105_op_eq` is described as "$\theta\ge\theta_0(n)$ forces $u/w=n/(n-2)$ and $r=n(n-2)/4$", which is what the theorem states (as $(n-2)u=nw$ and $4r=n(n-2)$).
- **O3.** The phrase "The equality case is PROVED" should carry O1's gap: the direction $r=n(n-2)/4\Rightarrow$ equality is untyped. Either type the converse of `L105_mult` or name it in **Owed**.
- **Hypothesis `L105_op_eq` takes.** It assumes $\theta\ge\theta_0$, the equality of the whole chain, where the record's equality is in the second inequality. The real-variable `L105_eq_iff` carries the record's form, so this is a precision point rather than a defect.

## `L264_one` and `L264_one_some` (r1739's O1 and O3)

- `IsSelfAdjoint2 C` is now in the conclusion, supplied by the `hCsa` already derived, and the anonymous constructor is extended in order.
- `L264_one_some` obtains the maximiser from `L264_one_exists` (its `2 ≤ card` from `3 ≤ card` by `omega`) and packs `L264_one`'s `let`-bound conclusion under `∃ C`. That unifies by zeta-reduction, and the olean confirms it.
- Both repairs are sound.

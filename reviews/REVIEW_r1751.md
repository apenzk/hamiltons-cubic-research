# REVIEW r1751: L228Relabel.lean and the L228 row's promotion to proved

**Verdict: CONFIRMED WITH OBSERVATIONS.** The relabelling is sound and every new theorem is faithful to the record's "for each $a$" and "for distinct $a, b$". The promotion to **proved** is justified. What remains is stale prose, in the INDEX row and in the record's Lean paragraph, which still call the relabelling prose.

Scope: [L228Relabel.lean](../lean/HamiltonsCubic/Results/L228Relabel.lean) as committed at 3a54880b (identical to the working tree), and the L228 row of [lean/INDEX.md](../lean/INDEX.md). L228Item1 to Item4, L228Attain and L226 are taken as given (r1743 to r1750). Analysis-only footing: the file was read by hand, and the only run was `#print axioms` on a scratch file importing the module.

## Build and axioms

- The olean (01:58) is newer than the source (01:57), and the build trace shows two warnings and no errors: `Fin.lt_iff_val_lt_val` is deprecated (line 58), and `Fin.ext_iff` is an unused simp argument (line 238).
- `#print axioms` on `L228_item2_any`, `L228_item3_any`, `L228_item4_any`, `blockP_perm` and `ricci_perm` gives `[propext, Classical.choice, Quot.sound]`. The file has no `sorry` and no `native_decide`.

## (1) six_orders, sum_distinct, sum_lt3_perm

- `six_orders` is correct. For distinct $a, b, c$ exactly one of the six strict orders holds. When two indices coincide none of them can hold, because each order is strict between all three pairs. Falsifier: a triple of `Fin m` for which zero or two of the six conjunctions hold while the left guard disagrees. No such triple exists.
- `sum_distinct` is correct. Pointwise, the distinct-guarded $h$ equals $G$ summed over the six argument orders, where $G$ is the increasing-guarded $h$. The five identities e1 to e5 use only the two transpositions h12 and h23, which generate $S_3$. Each reordered $S_3$ sum equals $S_3\,G$ by `Finset.sum_comm` at the outer or inner pair, and k3 to k5 compose these correctly. Falsifier: a totally symmetric $h$ on `Fin m` with $\sum_{\text{distinct}}h\ne6\sum_{a<b<c}h$.
- `sum_lt3_perm` is correct. Reindexing each variable by $\sigma^{-1}$ preserves distinctness by injectivity, so the distinct sum is invariant. Two uses of `sum_distinct` then transfer this to the increasing sums. Falsifier: $\sigma$ and a totally symmetric $h$ whose increasing-triple sum changes under $h\mapsto h\circ(\sigma,\sigma,\sigma)$.

## (2) blockP_perm, term by term

- `cubicJ S` does not involve $\sigma$.
- $\sum_a(\mathop{\mathrm{tr}}M_a^3+3\mathop{\mathrm{tr}}(S\mathop{\mathrm{adj}}M_a))$ is invariant by `Equiv.sum_comp`.
- For the pair term, the summand $K_{ab}^3+3K_{ab}\mathop{\mathrm{tr}}(M_aM_b)$ is symmetric by hK and `trace_mul_comm`. `sum_lt_perm` gives $\sum_{a<b}$ as $\tfrac12\sum_{a\ne b}$ via `sum_ne_eq_two_lt`, and $\sum_{a\ne b}$ is reindexing-invariant. This holds for any $M$, symmetric or not.
- For the triple term, $K_{ab}K_{ac}K_{bc}$ is invariant under $a\leftrightarrow b$ (by $K_{ab}=K_{ba}$ and $K_{ac}\leftrightarrow K_{bc}$) and under $b\leftrightarrow c$ (by $K_{bc}=K_{cb}$). The h12 and h23 discharges match, and the factor 3 is untouched.
- The lemma needs only hK. The zero diagonal is not used, which is harmless.
- Falsifier: symmetric $K$, any $S$, $M$ and a permutation $\sigma$ with `blockP` changed.

## (3) ricci_perm, perm_transfer, relabel_bound

- `ricci_perm` is sound. [ricciFlat_iff](../lean/HamiltonsCubic/Results/L226Mixed.lean) reduces Ricci-flatness to $(\mathop{\mathrm{tr}}S)I-S+\sum_aM_a=0$, which is permutation-invariant, and to $\mathop{\mathrm{tr}}M_a+\sum_bK_{ab}=0$ for every $a$. Relabelled, the second condition reads $\mathop{\mathrm{tr}}M_{\sigma a}+\sum_bK_{\sigma a,\sigma b}$, which is the original condition at $\sigma a$ after reindexing $b$. All of `ricciFlat_iff`'s hypotheses (S, M symmetric, K symmetric with zero diagonal) are carried over. Falsifier: a Ricci-flat `blockOp S M K` in the family whose relabelling has a non-zero Ricci entry.
- `perm_transfer` is sound. $P$ and the norm of the relabelled operator equal those of the original through `Pcubic_blockOp`, `normSq_blockOp` and the two invariance lemmas.
- `relabel_bound` is sound. The relabelled $S=\sum_aX_{\sigma a}-\tfrac12\sum_at_{\sigma a}I$ is rewritten to the unrelabelled $S$ by `Equiv.sum_comp`, and `perm_transfer` then rewrites both sides. This works for any real $c$ because only equalities are used. Falsifier: data where the relabelled operator obeys $P\le c\lVert\cdot\rVert^3$ and the original does not, which is impossible given equal $P$ and norm.

## (4) The _any forms

- `L228_item3_any` uses $\sigma=\mathop{\mathrm{swap}}(0,a)$, so $\sigma0=a$, including $a=0$ where the swap is the identity. The other blocks $\sigma(i.\mathrm{succ})$ differ from $a$: $\sigma(i.\mathrm{succ})=\sigma0$ would force $i.\mathrm{succ}=0$. They are therefore diagonal by hdiag. The hypotheses match the record's item 3: the blocks $X_c$, $c\ne a$, share an orthonormal frame, with $F^{\mathsf T}F=FF^{\mathsf T}=1$.
- `L228_item4_any` builds $\tau=\mathop{\mathrm{swap}}(0,a)$ and $\sigma=\tau\cdot\mathop{\mathrm{swap}}(1,\tau b)$.
  - hσ0 holds: $\tau b\ne0$ because $\tau b=0=\tau a$ gives $a=b$, and $0\ne1$ in `Fin (m+2)`, so the inner swap fixes 0 and $\tau0=a$.
  - hσ1 holds: $\sigma1=\tau(\tau b)=b$. The case $\tau b=1$ is covered, since the inner swap is then the identity.
  - $\sigma(i+2)\notin\{a,b\}$ holds by injectivity against $\sigma0$ and $\sigma1$.
  - `hUd` enters as $X_{\sigma0}+X_{\sigma1}=X_a+X_b$. `Fin (m+2)` is the record's $m\ge2$.
- `L228_item2_any` is faithful for every block $a$. It holds at $a=\sigma0$ for any $\sigma$, so every $a$ is reached, and $R$, $T$ sum over $\sigma(i+1)$, which enumerates $A\setminus\{a\}$ bijectively. `beta` of the relabelled data at $(0,i+1)$ equals $\beta_{\sigma0,\sigma(i+1)}$, because `beta` reads $\mu=\sum_dt_d$, which is permutation-invariant. $c_a$ and $n_a$ are `cA`, `nA` of the relabelled $t$, $K$ and the other blocks only, so they are free of $X_a$ as the record says.
- Falsifier for item 3 or 4 at a given $a$ (or $a, b$): a Ricci-flat block operator meeting the frame hypothesis at that $a$ (or at $a$ and $b$) with $P>c\lVert W\rVert^3$ for a $c$ that bounds every diagonal tensor. For item 2: a block operator whose $P$ or norm differs from the stated closed form at $a=\sigma0$.

## (5) The promotion

It is justified. Each part of the record's L228 now has a typed counterpart:

| Part of the record's L228 | Typed by |
|---|---|
| Item 1 | `L228_item1`, `L228_item1_ricci` |
| Item 2, every $a$ | `L228_item2_any` |
| Item 3, every $a$ | `L228_item3_any`, with the constants from `L228_item3` / `L228_item3_odd`'s diagonal bounds |
| Item 4, every $a\ne b$ | `L228_item4_any` |
| "At $m\le2$ item 3 covers every $W$" | `L57_block_le_two_of` |
| Attainment | `L228_attained_even`, `L228_attained_odd` |

The identification of $\mathcal S_J\cap\mathcal W_n$ with Ricci-flat `blockOp` data, and $\mathcal D_n\subseteq\mathcal S_J$, are L226's and the block note's. That leaves no untyped part of the Statement. From the Setting, the normal form $S=N-\tfrac12(\mathop{\mathrm{tr}}N)I$ is assumed at item 2 (the identity holds there without Ricci-flatness) and is derived from Ricci-flatness in `L228_item1_ricci`.

## Observations

- **O1: the row and the record contradict the promotion.** The L228 row of [lean/INDEX.md](../lean/INDEX.md) still says "The relabelling from $a=0$ to an arbitrary block is prose" in its item 2 sentence, and "(the relabelling to arbitrary distinct $a,b$ is prose, ...)" in its item 4 sentence. Both sit beside the new sentence that says it is proved. The record's Lean paragraph ([second-order.md](../findings/second-order.md), Lemma L228) still ends "L228 is typed at the operator except the relabelling to arbitrary blocks, which is prose" and does not cite L228Relabel.lean. All three need updating.
- **O2: no named $\Theta_n$ instance at an arbitrary block.** `L228_item3_any` and `L228_item4_any` are the `_of` forms, with $c$ supplied through hc. No theorem states $P\le\Theta_n\lVert W\rVert^3$ at an arbitrary $a$, or pair $a, b$, at even or odd $n$. The composition is one line through the same diagonal bounds that `L228_item3` and `L228_item3_odd` use. The row's wording "items 2, 3 and 4 at every block" is accurate for the `_of` form, but the record states items 3 and 4 with $\Theta_n$.
- **O3: `L228_item2_any` states $\beta$, $c_a$, $n_a$ through the relabelled data.** They appear as `beta (t ∘ σ) (K ∘ σ) 0 i.succ` and similar, and never as $\beta_{a c}$ over $c\ne a$. They are equal by reindexing, as shown above. This is cosmetic.
- **O4: two lint warnings.** Line 58 uses the deprecated `Fin.lt_iff_val_lt_val` (`Fin.lt_def` replaces it), and line 238 carries the unused simp argument `Fin.ext_iff`.

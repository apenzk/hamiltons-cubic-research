# Step 9 sweep, round 3 (2026-09-25): I73 (c) at every n

Worked from [the position file](2026-09-25-step9-position-round3.md).

## Batch A, stability of near-rank-two spaces of skew matrices

Searched: quantitative or stable versions of the classification of spaces of rank-two skew matrices; spaces whose every element has operator norm large against its Frobenius norm. **Found only exact results**: constant-rank spaces ([Manivel–Mezzetti](https://arxiv.org/pdf/1011.3779)), bounded-rank alternating spaces with their maximal dimensions and extremal classification ([Meshulam–Loewy–Radwan](https://arxiv.org/pdf/1507.06213), [Meshulam](https://arxiv.org/pdf/1703.05551)), and GIT-stable systems of generic rank at most four ([arXiv:2003.14201](https://arxiv.org/pdf/2003.14201)). **No quantitative version.** The bounded-rank extremals (stars and $\Lambda^2\mathbb R^{2s+1}$) are the exact skeleton the stability lemma would perturb.

## Batch B, Weyl tensors with $W^2\propto\mathrm{Id}$

Searched: algebraic curvature or Weyl operators whose square is a multiple of the identity on 2-forms. Nothing specific. The one hit in the neighbourhood, [Deninger–Grundhöfer–Kramer](../references/deninger-grundhoefer-kramer-2023-srg-quadratic/README.md), is already on file and covers the diagonal case, which is settled.

## Batch C, all-dimension spectral bounds at critical points of the cubic

Searched: critical points of the cubic on Weyl tensors, or of Böhm–Wilking's reaction term, with three eigenvalues, at every dimension. Nothing beyond the record's own sources; the hits concern Ricci solitons and harmonic Weyl curvature, a different object.

## Phase 3a, the screen

The stability lemma is not in the record (the [note](2026-09-25-I73c-per-vector-rows.md) states it as owed) nor in [ATTEMPTS.md](../ATTEMPTS.md) by mechanism; no fence post fences it; [F77](../findings/fence-posts.md) and the averaging barrier say only that the per-eigenspace and second-moment versions cannot replace it.

## Phase 3b, the routes, graded

| route | closes | attackable | margin | analytic | value | reach toward P |
|---|---|---|---|---|---|---|
| **R40, the stability lemma by hand**, perturbing the bounded-rank extremals, combined with L246 | 1 | 1 | 1 | 1 | **1** | the symmetric family at every $n$; leaves the asymmetric spectra and (b) |

**Chosen by the cycle under the rule of 2026-09-25** (the ranking decides, and the user holds strategy): R40, the one route with a path at every $n$. *The reach gate does not fire: its reach is a family at every $n$, not a census. The churn cap does not fire: [L246](../findings/second-order.md) is a derivation advancing I73 since the last route closed.* **The honest state recorded beside it: the asymmetric majority of (c) has no route at every $n$.**

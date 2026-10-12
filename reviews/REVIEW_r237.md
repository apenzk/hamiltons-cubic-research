# REVIEW r237 -- Gate 2, A1 canonical-lift reduction (claims 1, 2, 3)

Commit under review: fb10569, [run_a1_canonical_lift.py](../scripts/runs/run_a1_canonical_lift.py). Reviewer 237, scope claims 1-3 (the logic of the reduction); reviewer 238 holds 4-6. Scripts: [scripts/reviewers/r237/](../scripts/reviewers/r237/). Log: agent_logs/gate2_237.log.

## Verdict table

| # | Claim | Verdict |
|---|-------|---------|
| 1 | Direction of (ii): the file needs upward persistence and states the reverse | **CONFIRMED, and the brief's suspicion is itself backwards** -- (ii) is stated in the only direction that is true, and (iii) closes the gap validly. Witness built anyway: an exact relation valid at n_0=5 and violated at n=6 |
| 2 | "Canonical from n_0 <=> dim constant on [n_0,inf)" | **CONFIRMED, both directions** -- and true only because (i) holds at *every* n >= n_0, which the equivalence's statement hides. Two riders: the O(n)/SO(n) scope, where (iii) is outright false |
| 3 | Does k_B >= 24 really not enter? Real distinction or relabelling? | **The distinction is REAL** (a strictly smaller space, hence a strictly weaker hypothesis) **but the file's words for it are a relabelling**. And a finding beyond the claim: **post F32 does not bind at n_0 = 12 for either route** -- dim (Sym^6 W_n^*)^{B_n} is stationary from exactly n = 12 |

## Claim 1 -- the direction is right, the gap-closing is valid, and the failure mode is real

**Re-derived from definitions.** V is the free span of the finitely many degree-6 complete-contraction diagram symbols; eps_n : V -> (Sym^6 W_n^*)^{O(n)} evaluates them at dimension n. Padding pad : W_{n_0} -> W_n is zero-extension inside the tensor power (r232's trace-free padding lemma: a zero-padded Weyl tensor is Weyl, since the n-dimensional traces of a tensor supported in the first n_0 coordinates are its n_0-dimensional traces). Every complete contraction has all 4d slots on a W-factor, so no free delta-loop contributes a factor of n and

    q_D^{(n)} . pad  =  q_D^{(n_0)}   for every diagram D.

Hence `sum c_D q_D^{(n)} = 0` on W_n forces `sum c_D q_D^{(n_0)} = 0` on W_{n_0}: **ker eps_n is contained in ker eps_{n_0}**, which is what the file writes. The reverse is not available and the file does not assert it. Verified exactly in [r237_witness_base5.py](../scripts/reviewers/r237/r237_witness_base5.py): a padded W_5 gives diagram values `(-21333312, -10666656)` at n=6, identical to its values at n=5, in integer arithmetic with no rounding.

**The gap-closing is valid, and it is a two-line argument.** For n_0 <= m <= n, (ii) applied at base m makes `{ker eps_n}_{n >= n_0}` a *decreasing* chain of subspaces of the finite-dimensional V. The lift needs `ker eps_{n_0} subset ker eps_n`, i.e. equality. A decreasing chain with constant dimension is constant, and (i) gives `dim ker eps_n = dim V - dim (Sym^6 W_n)^{O(n)}`. So constancy of the dimension delivers exactly the missing containment. **No step is backwards and no step is missing.**

**The sharper formulation the file could have used.** Restriction along padding, `r_n : (Sym^6 W_n)^{O(n)} -> (Sym^6 W_{n_0})^{O(n_0)}`, satisfies `r_n . eps_n = eps_{n_0}`. Since eps_{n_0} is surjective (i), **r_n is always surjective**, and

    ker r_n = 0  <=>  ker eps_{n_0} subset ker eps_n  <=>  the lift is canonical.

So "the lift is canonical from n_0" is precisely "`r_n` is an isomorphism for all n >= n_0" -- the exact O(n)-analogue of the Proposition 2.9 statement the transfer route proved for B_n. This matters for claim 3.

**One consequence the file does not draw: canonicity is a property of the pair (n_0, n), not of the invariant being lifted.** The lift of a given `u` depends on the choice of expansion only through `ker eps_{n_0} mod ker eps_n`, which is the same coset space for every u. So there is no "this particular certificate might lift even if the general lift does not".

### The witness the brief asked for -- a relation valid at the base and violated above it

Built in the degree-3 miniature, in **exact integer arithmetic** (Weyl projection over Q, denominators cleared; both cubic contractions are `tr(M^3)` after a flattening, so the whole computation is 36x36 integer matrix multiplication). Random algebraic-curvature tensors, projected to Weyl and verified exactly against all curvature symmetries, first Bianchi and trace-freeness:

| n | ratio q2/q1 over 6 random Weyl tensors | rank |
|---|---|---|
| 4 | `1/2` (identical every sample) | 1 |
| 5 | `1/2` (identical every sample) | 1 |
| 6 | six distinct ratios | 2 |
| 7 | six distinct ratios | 2 |

    q1 - 2 q2 = 0   holds identically on W_4 and W_5
    q1 - 2 q2 = 3427683696, 865952496, 34573245840, ...   on W_6

with `q1 = W_ijkl W_klmn W_mnij` and `q2 = W_ikjl W_kmln W_minj`. This is the classical Lovelock-type degeneracy, and it is exactly the failure the reduction has to exclude: **`ker eps_5` is not contained in `ker eps_6`, so the diagram lift from base 5 is not well-defined**, while (ii)'s containment holds in the other direction throughout. The two containments are genuinely different statements, and the dimension count is the only thing separating them -- which is what the reduction claims and what makes its owed check load-bearing rather than decorative.

**The mechanism generalises, and it is why the owed check cannot be waved through.** Relations of this kind come from the vanishing of the generalised Kronecker delta on n+1 indices in dimension n. At degree 6 there are 24 slots, so antisymmetrising 13 of them produces candidate identities valid for every n <= 12 and violated at n = 13 -- precisely at the base the route wants. Nothing in the file's argument excludes them; only the dimension count does.

## Claim 2 -- the equivalence holds in both directions, and both hypotheses are load-bearing

**Both directions, written out.** Let `r_n(V) = ker eps_n`. (ii) makes `{ker eps_n}` decreasing in n; (i) makes `dim ker eps_n = dim V - dim (Sym^6 W_n)^{O(n)}`.

- (=>) Canonical from n_0 means `ker eps_{n_0} subset ker eps_n` for all n >= n_0; with (ii) the kernels are equal, so the ranks are equal, so by (i) the dimension is constant.
- (<=) Constant dimension gives constant `dim ker eps_n`; a decreasing chain of subspaces of a finite-dimensional space with constant dimension is constant, so `ker eps_{n_0} = ker eps_n` and the lift is well-defined.

So the answer to the brief's question -- *does constancy of the dimension really force equality of the kernels?* -- is **yes, and only because of (i) and (ii) together**. [r237_claim2_plants.py](../scripts/reviewers/r237/r237_claim2_plants.py) plants a violation of each, exactly over Q:

| plant | what is dropped | dim (Sym^6 W_n)^{O(n)} | lift |
|---|---|---|---|
| control | nothing | constant | well-defined, kernels equal |
| 1 | (ii), the nesting | still constant | **fails** -- `ker_12 = <(0,0,1)>`, `ker_13 = <(0,1,0)>` |
| 2 | (i), surjectivity | still constant | **fails** -- rank climbs 1 -> 2 underneath a constant target dimension |

Both plants leave every number in the file's statement intact, which is the point: the equivalence is a statement about the *rank* of eps_n disguised as a statement about the *dimension* of the target, and only (i) makes the disguise honest. **(i) is needed at every n >= n_0, not just at the base** -- the file states it that way ("surjective at every n") but the equivalence, read alone, does not show where it enters.

**The reduction to one finite number is legitimate.** `rank eps_n` is nondecreasing and bounded by `dim V`, so it converges, and its limit is the universal (stable) count. Hence *"the count at n_0 equals the universal count"* implies *"constant on [n_0, infinity)"* -- an infinite family of conditions genuinely collapses to one comparison. That is the strongest part of the file and it is correct.

**Rider 1 -- the owed check is narrower than the file says.** The file writes "the record's audited count at n = 12 is 89. If the universal count is also 89 ...", as though only n = 12 were known. The record already carries the whole low tail: [r180](REVIEW_r180.md) computes 88, 88, **89**, 89, 89 at n = 10, 11, 12, 13, 15, and [r181](REVIEW_r181.md) carries 89 to n = 14 and n = 16. What is actually owed is only the tail beyond 16, and that is exactly what the Littlewood universal count supplies.

**Rider 2 -- SCOPE. The equivalence is an O(n) statement and is FALSE for SO(n), and the record contemplates the SO variant.** A degree-6 det-twisted invariant carries one epsilon, using n of the 24 tensor slots and leaving `24 - n` to be paired off, so it exists only for **even** n <= 24. Two consequences:

- for odd n, `-I` acts trivially on W_n (four indices), so SO(n)- and O(n)-invariants coincide and `dim (Sym^6 W_13)^{SO(13)} = 89`;
- at n = 12 the record's audited chiral multiplicity is 3 ([r180](REVIEW_r180.md), [r182](REVIEW_r182.md)), so `dim (Sym^6 W_12)^{SO(12)} = 92`.

**92 at n = 12, 89 at n = 13: the SO count DECREASES**, so (iii) fails for SO(n), and with it the whole reduction. The mechanism is visible upstream: (ii) needs an n-independent diagram set, and the SO diagram set is not n-independent -- epsilon-diagrams exist at n = 12 and do not exist at n = 13. This is not hypothetical for the programme: [r180](REVIEW_r180.md) records that if the Gram matrix is only required SO(12)-invariant -- the 485-parameter reduction the plan calls "valid, merely coarser" -- the constraint count is 92. **If the certificate is ever fitted in that space, A1's reduction does not apply to it.** The file should say "O(n)-invariant" as a hypothesis, not as notation.

## Claim 3 -- k_B does not enter, and post F32 turns out not to bind the route it was aimed at either

### The two uniqueness statements, side by side

Padding `pad : W_{n_0} -> W_n` is `B_{n_0}`- and `O(n_0)`-equivariant, so precomposition gives one restriction map that acts on both invariant spaces at once:

| route | the statement it needs | how it is obtained | cost |
|---|---|---|---|
| post F32 / transfer | restriction is injective on `(Sym^6 W_n^*)^{B_n}` | Proposition 2.9, given `n_0 >= k_B` | `k_B >= 24` (r232) |
| A1 / direct | restriction is injective on `(Sym^6 W_n^*)^{O(n)}` | the dimension count, via (i)+(ii)+(iii) | the universal degree-6 count |

Because `(Sym^6 W_n^*)^{O(n)}` sits inside `(Sym^6 W_n^*)^{B_n}` and *the map is the same map*, the kernel on the O-side is the kernel on the B-side intersected with the O-side. **B-injectivity implies O-injectivity and not conversely: A1's hypothesis is strictly weaker.** So the distinction is real, and it is large -- at n = 12 the two spaces have dimensions **89** and **339 423** (computed below).

**But the file's words for it are a relabelling.** By fact (i), `V / ker eps_n` is isomorphic to `(Sym^6 W_n^*)^{O(n)}`, so *"uniqueness only modulo diagram relations"* **is** *"uniqueness in the O(n)-invariant space"*. The honest contrast is `O(n)` against `B_n` -- two spaces, one notion of uniqueness -- not "modulo relations" against "in a space", which suggests a weaker kind of uniqueness where in fact the kind is identical and only the space changes.

**Does `k_B` enter A1 anywhere?** No. A1 uses exactly three things: FFT spanning at every dimension (r232 1b, no stable range), the padding-collapse identity `q_D^{(n)} . pad = q_D^{(n_0)}` (r232 1a + the trace-free padding lemma 1c), and the dimension count. `B_n`, Definition 2.5, Proposition 2.9 and the presentation degree appear in none of them. **Confirmed: `k_B` does not enter.**

**What the file does not say is what the trade costs.** Proposition 2.9 is a theorem: one degree bound buys injectivity for *all* `n >= n_0` at once. A1 replaces it with a condition that must hold at every `n >= n_0`, and it is (iii) -- monotone and bounded, so the limit is the universal count -- that collapses that infinite family back to one number. The trade is fair, but it moves the debt from a degree bound to a universal-count computation, and the file presents this as a pure gain.

### Confronting post F32 directly: `k_B >= 24` bounds the hypothesis, not the conclusion

Post F32's mechanism, audited in [r232](REVIEW_r232.md) 1d(iii), is a **generation-degree** argument about the module: `W_4` contains a tensor with `W_1234 != 0`, so six Weyl tensors on disjoint 4-subsets give an element of `Sym^6(W_n)` with a coordinate of support 24, unreachable from any `d < 24`; hence `Sym^6 W` is generated -- and so presented -- in degree at least 24. That is correct and I do not dispute it.

**It does not follow that the B_n-invariants have not stabilised at 12, and they have.** The reason is a parity constraint that the generation argument does not see. The sign subgroup `(Z/2)^n < B_n` acts on the coordinate `W_{ijkl}` by `eps_i eps_j eps_k eps_l`, so averaging kills every monomial in which some coordinate index occurs an odd number of times. A degree-`d` monomial has `4d` slots, so **every surviving monomial has all multiplicities even and therefore support at most `2d`**: the invariants never see more than `2d` coordinates, while the module needs `4d` to be generated. The factor of two is exactly the gap between post F32's 24 and the route's 12.

Computed exactly, by Burnside over the conjugacy classes of `B_n` (pairs of partitions; `p_j(g)` read off the signed cycle type; the curvature module as the Schur functor `S_{(2,2)}` minus `Sym^2`; Newton for `h_d`; `Fraction` throughout) in [r237_bn_invariants.py](../scripts/reviewers/r237/r237_bn_invariants.py):

`dim (Sym^d W_n^*)^{B_n}`

| n \ d | 1 | 2 | 3 | 4 | 5 | 6 |
|---|---|---|---|---|---|---|
| 4 | 0 | **3** | 5 | 14 | 27 | 67 |
| 5 | 0 | 3 | 9 | 60 | 350 | 2163 |
| 6 | 0 | 3 | **17** | 167 | 1989 | 26630 |
| 8 | 0 | 3 | 17 | **241** | 6014 | 231741 |
| 10 | 0 | 3 | 17 | 241 | **6511** | 335171 |
| 11 | 0 | 3 | 17 | 241 | 6511 | 339014 |
| **12** | 0 | 3 | 17 | 241 | 6511 | **339423** |
| 13-16 | 0 | 3 | 17 | 241 | 6511 | 339423 |

The threshold is **`n = 2d` in every column, with no exception**: 4, 6, 8, 10, 12 -- exactly what the parity argument predicts, and exactly half of post F32's `4d`. The table is **cross-checked by a second computation sharing no code with the first** ([r237_bn_bruteforce.py](../scripts/reviewers/r237/r237_bn_bruteforce.py)): it builds `W_n` as an explicit matrix space, enumerates all `2^n n!` signed permutations, forms each element's matrix on that basis and averages `tr Sym^d` by Newton. It returns `(0, 3, 5)` at n = 4 over 384 group elements and `(0, 3, 9)` at n = 5 over 3840, agreeing with the character route to six decimals. The character machinery is validated twice inside its own script as well: the standard representation reproduces `dim (Sym^d R^n)^{B_n} = p(d/2)` (1, 2, 3 at `d = 2, 4, 6`), and `chi_W(1)` reproduces `n(n+1)(n+2)(n-3)/12` at n = 4, 5, 6, 12.

**So `dim (Sym^6 W_n^*)^{B_n} = 339 423` for every `n >= 12`.** Proposition 2.9's conclusion is that restriction `U_n^{B_n} -> U_{n_0}^{B_{n_0}}` is an isomorphism; the two sides already have the same dimension from `n_0 = 12` on. `k_B >= 24` shows the theorem's *antecedent* fails at 12; the numbers show the *consequent* is at least dimensionally intact there. **Post F32's headline in [fence-posts.md](../findings/fence-posts.md) -- "a transfer certificate must be built at `n_0 = 24`, not 12 -- the mechanism itself is proved" -- overstates what was proved.** What is proved is that Proposition 2.9 cannot be the reason. r232's own text is careful about this ("a true conditional whose antecedent is unsatisfiable"); the fence post is not.

This does not rescue the transfer route by itself -- equal dimensions give an isomorphism only once the map is known injective or surjective, and neither is established here -- but it removes `24` as a *proved* lower bound on the base for either route, and it identifies where a proof would come from: the parity/support argument, not the module's generation degree.

### Independent confirmation of the O-side numbers used above

[r180](REVIEW_r180.md)'s coset computation was re-run here from its own script rather than cited ([out_o12_k6.txt](../scripts/reviewers/r237/out_o12_k6.txt)):

    n=12  O(n)-invariants of Sym^k, k=1..6 : [0, 1, 2, 7, 19, 89]
          det-twisted (chiral) multiplicities: [0, 0, 0, 0, 0, 3]

so `89` is the `O(12)` count the file needs and `92` is the `SO(12)` count of rider 2 under claim 2.

## Summary of what should change in the file

1. **Nothing in the logic.** Facts (i), (ii), (iii) and the equivalence are correct as written, and (ii) is stated in the only direction that is true.
2. **Name the hypothesis `O(n)`.** The reduction is false for `SO(n)`, where the count drops 92 -> 89 from n = 12 to n = 13 and the diagram set is not n-independent. The record contemplates an SO-invariant Gram; that variant is outside A1.
3. **Say where (i) is used in the equivalence** -- at every n, not only at the base. Planted violations of (i) and of (ii) each break the equivalence with all the stated numbers intact.
4. **Reword the contrast with post F32** as `O(n)` versus `B_n`, since "modulo diagram relations" and "in the O(n)-invariant space" are the same thing.
5. **Narrow the owed check**: the record already has 89 at n = 13, 14, 15, 16; what is owed is the tail, which the universal count supplies.
6. **Record the new fact** that `dim (Sym^6 W_n^*)^{B_n}` is stationary from n = 12, so `k_B >= 24` does not lower-bound the base for either route.

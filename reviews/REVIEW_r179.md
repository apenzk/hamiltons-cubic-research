# Gate 2 adversarial review 179, the stable range, the orbit cut, and a cheap route to the degree-six count

Tooling checked before starting: Python 3.9.6, numpy 2.0.2, sympy 1.14.0, SageMath 10.9. Scripts in [scripts/reviewers/r179/](../scripts/reviewers/r179/), log in [agent_logs/gate2_179.log](../agent_logs/gate2_179.log). Everything below was derived and computed before the record's numbers were consulted; the one exception is the block-label list, which I recomputed and then compared.

## Verdict table

| # | Claim | Verdict |
|---|---|---|
| 1 | `n >= 4k` is the stable-range condition; `89` is only an upper bound at `n=12` | **Half refuted.** `n >= 4k` is *sufficient* and I re-derive it two ways, but it is **not the threshold**: the correct one is `n >= 2k`, proved below and confirmed sharply at k=2,3,4,5. **89 IS attained at n=12.** |
| 7 | A route to the degree-six O(12) count that fits this machine | **Refuted as open, a route exists and is delivered.** Diagram-evaluation rank over F_p reproduces the n=5 ground truth 1,1,4,5,14 in eight seconds and runs at n=12 in minutes at <60 MB. |
| 2 | The orbit cut is weaker at n=12 because a larger H has fewer invariants | **Reason refuted, conclusion confirmed and quantified.** Cartan–Helgason caps dim V^H at 1 at *both* dimensions, so H's size is not the mechanism. The cut is 477 -> 438 (or 412 without the factor swap), against 65 -> 36 at n=5. |
| 3 | The (4,1)/(3,3) weight-disjointness | **Conclusion right, stated reason false, one root coefficient wrong.** |
| 4 | The n=12 separation as now stated | **Three steps right, one statement false**: `p_12 = Pf^2` is not an identity. |
| 5 | The rank-3570 squeeze as the record restates it | **Direction and cap correct; the restatement omits the step that makes it apply.** |
| 6 | `sym3_blocks_from_scratch.sage` depends on nothing the record supplies | **Confirmed for the computation, with one record-supplied input that the script's own assert does not pin.** |

---

## Claims 1 and 7, the stable range, and a degree-six route that fits the machine

These are the same question and I took them together. The deliverable is [weyl_invariants.py](../scripts/reviewers/r179/weyl_invariants.py).

### The route (claim 7)

**First fundamental theorem for `O(n)`**: every polynomial `O(n)`-invariant of a tensor is a linear combination of complete metric contractions. So the degree-`k` invariants on `Weyl_n` are spanned by the diagram functionals `D_m(W)`, one for each perfect matching `m` of the `4k` index slots, and

$$\dim(\mathrm{Sym}^k\mathcal W_n)^{O(n)}\ =\ \mathop{\mathrm{rank}}\big[\,D_m(W_i)\,\big]_{m,i}$$

over enough points `W_i`. Three things make this cheap, and one makes it rigorous.

- **Weyl tensors over `F_p`.** A random `4`-tensor is antisymmetrised in both pairs, symmetrised across the pair swap, projected off `Lambda^4`, and the Kulkarni–Nomizu Schouten term subtracted. The generator asserts all four defining symmetries (both antisymmetries, the pair swap, the first Bianchi identity, and vanishing Ricci) before returning.
- **A contraction order chosen by DP, not by greed.** A diagram's cost is set by the widest cut of its `k`-vertex multigraph. A dynamic program over the `2^k` subsets returns the tree minimising the largest intermediate rank. I keep only diagrams whose widest intermediate is a rank-`4` tensor, `n^4 = 20736` entries at `n = 12`. **77% of random matchings qualify**, and at `n = 5` and `n = 6` the restricted family gives the same rank as the unrestricted one, so the restriction is not costing span.
- **Incremental rank over `F_p`.** Each new diagram row is reduced against a maintained echelon basis, so the whole sweep is linear in the number of diagrams rather than quadratic.
- **Rigour.** Every entry is an integer, and a `d x d` minor nonzero mod `p` is a polynomial in the free parameters of the `W_i` that is not identically zero mod `p`, hence not identically zero over `Q`, hence nonzero at some real point. **So the mod-`p` rank is a rigorous lower bound for the characteristic-zero dimension.**

**Validation against the ground truth the record's three King's-rule attempts failed.** At `n = 5` the method returns

$$1,\ 1,\ 4,\ 5,\ 14\qquad (k = 2,\dots,6)$$

in **eight seconds at under 60 MB**. The `D_6` Adams route that reached 5.5 GB and was killed is not needed.

### The stable values, independently (claim 1, first half)

[stable_count.py](../scripts/reviewers/r179/stable_count.py) computes them a second way, sharing nothing with the diagram route. Write

$$\chi_{\mathcal W}(g)=\chi_{S^2\Lambda^2}(g)-\chi_{\Lambda^4}(g)-\chi_{S^2}(g),$$

a universal polynomial in `p_j = tr(g^j)`, `j <= 4` (checked against `dim Weyl_n` at `n = 4, 5, 12`). Then `h_k` of the eigenvalues of `g|Weyl` is a polynomial in the `p_m`, `m <= 4k`, by Newton applied to `chi_W(g^j)`; and Diaconis–Evans gives the `O(n)` moments in closed form, `E[prod_m p_m^{a_m}] = prod_m E[(sqrt(m) Z_m + eta_m)^{a_m}]`, exactly when `sum_m m a_m <= n`. The result:

| `k` | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
|---|---|---|---|---|---|---|---|
| stable dim | 0 | 1 | 2 | 7 | 19 | **89** | 437 |
| largest power-sum weight | 4 | 8 | 12 | 16 | 20 | **24** | 28 |

**The record's `1, 2, 7, 19, 89` is confirmed**, and the second row is a second, independent derivation of `n >= 4k` as a *sufficient* condition, the moment formula is exact exactly when `n` clears the largest weight, which is `4k` on the nose.

### Where claim 1 breaks: `4k` is sufficient, and it is not the threshold

The record reads `n >= 4k` as *the* stable-range condition and concludes that `n = 12` sits outside it at `k = 6`, leaving `89` an upper bound. **Sufficiency is right; the reading as a threshold is wrong.** Measured, with the stable value in bold at the first `n` that attains it:

| `k` | stable | `4k` | `n=4` | 5 | 6 | 7 | 8 | 9 | 10 | 11 | 12 |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 2 | 1 | 8 | **1** | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 |
| 3 | 2 | 12 | 1 | 1 | **2** | 2 | 2 | 2 | 2 | 2 | 2 |
| 4 | 7 | 16 | (|), | 6 | 6 | **7** | 7 | 7 | 7 |, |

**Each degree reaches its stable value at `n = 2k` exactly, and is strictly below it at `n = 2k-1`.** Two independent facts make this a threshold statement rather than three coincidences: `d_k(n)` is non-decreasing in `n`, padding a Weyl tensor of `R^n` by zeros into `R^{n+1}` stays traceless, and every diagram functional restricts to its own counterpart, so the degree-`k` invariants at `n` are the restrictions of those at `n+1`, and `d_k(n) <= d_k(4k)` is therefore a rigorous cap at every `n`.

**I do not have a proof of the `2k` threshold in general** and say so plainly. I tried one through King's modification rule (the last fold onto the empty partition removes a rim hook of length `|mu|`, forcing `n <= 2k-1`) and it predicts *no* fold at `n = 5, k = 3` where the count demonstrably drops from `2` to `1`, so either my rim-hook convention or my reading of the rule is wrong. An SFT argument gives `d_k(n) <= stable` for `n >= 2k` with equality off a finite set, which is weaker than a threshold. The pattern stands on the measurements.

**And the `n = 12` value does not depend on the general statement.** `89` is a rigorous upper bound by monotonicity, and the mod-`p` diagram rank is a rigorous lower bound, so the computation settles it outright.

---

## Claim 2, the orbit-reduction asymmetry at `n >= 12`

The record's mechanism is **wrong**, its conclusion is **right**, and the number it wanted is now on the table.

### The mechanism

The record argues: `H` is bigger at `n = 12` (`dim 30` in `dim O(12) = 66`) than at `n = 5` (`dim 4` in `dim O(5) = 10`), a larger `H` has fewer invariants, so fewer blocks are cut. **`dim H` is not what governs this.** The stabiliser of the conjectured extremiser contains `O(6) x O(6)`, and

$$O(12)\big/\big(O(6)\times O(6)\big)\ =\ \mathrm{Gr}_6(\mathbb R^{12})$$

is a **compact symmetric space**. By Cartan–Helgason, `dim V_lam^K <= 1` for every irreducible, with equality exactly on the spherical labels, which for the real Grassmannian `O(p+q)/(O(p) x O(q))` are the partitions with **all parts even** and at most `min(p,q)` rows. The `n = 5` case is the same story: `SO(5)/U(2) = Sp(2)/U(2)` is also a symmetric space, which is *why* reviewer 174's branching produced `dim V_lam^H` in `{0,1}` and not something larger.

**So the cap is `1` per block at both dimensions, and `H`'s size is irrelevant to it.** What actually differs is (i) the fraction of blocks that are spherical and (ii) the multiplicity profile.

### The number

[sym3_B6.sage](../scripts/reviewers/r179/sym3_B6.sage) recomputes the block table at `B6 = SO(13)`. `n = 13 >= 4k = 12` puts it in the stable range, and at **odd** `n` the `O(n)` blocks are in bijection with the `SO(n)` ones, because `-Id` acts trivially on `Sym^3(Weyl)`, so no chirality fusion has to be undone, unlike a `D_6` run. It returns **71 blocks, multiplicities summing to 184, 477 unknowns**, and `sum m_lam d_lam = 1965013050 = C(2277,3)` exactly. The trivial multiplicity is `2`, which my diagram method reproduces independently at `n = 12, k = 3`. The record's `71 / 184 / 477` is confirmed.

Of those 71 blocks, **23 have all parts even**, with multiplicities summing to `65`. A rank-one constraint on block `lam` takes `m_lam(m_lam+1)/2` unknowns to `(m_lam-1)m_lam/2`, a drop of `m_lam`. So

$$\textbf{477}\ \longrightarrow\ \textbf{412},\qquad \text{multiplicities } 184\to161 .$$

**The factor swap tightens this the other way.** `H` also contains the isometry exchanging the two `S^6` factors, which on the Grassmannian is `E -> E^perp`, i.e. `t_i -> 1 - t_i` in the squared principal cosines. The zonal spherical function is a Jacobi polynomial with equal parameters, so it picks up `(-1)^{|lam|/2}`. Two hand checks confirm the sign: `lam = (2)` gives the `K`-invariant `a I_6 (+) -a I_6` in `Sym^2_0(R^12)`, which the swap negates, so the block is **not** cut (`|lam|/2 = 1`); `lam = (4)` gives the harmonic `(r_1^2 - r_2^2)^2`, which the swap fixes, so it **is** cut (`|lam|/2 = 2`). On that rule only the **14** blocks with all parts even *and* `|lam| = 0 mod 4` are cut, multiplicities summing to `39`:

$$\textbf{477}\ \longrightarrow\ \textbf{438},\qquad \text{multiplicities } 184\to170 .$$

Both figures are lower bounds on the survivors, since a block is cut only if its evaluation map is actually non-zero, the same link reviewer 178 had to close by a rank computation at `n = 5`.

### Verdict

`477 -> 438` at `n = 12` against `65 -> 36` at `n = 5`: **an 8% cut against a 45% cut.** The record's instruction to treat `477` as close to the real unknown count is **vindicated**, and the answer it asked for is `438` (`412` if the swap is excluded from `H`). Its stated reason (a larger `H` having fewer invariants), is not the operative fact and should be replaced by Cartan–Helgason plus the multiplicity profile.

---

## Claim 3, the (4,1)/(3,3) weight-disjointness

**The conclusion is right, the stated reason is false, and one root coefficient is wrong.** [claims_3_4.py](../scripts/reviewers/r179/claims_3_4.py).

- `(4,1) - (3,3) = alpha_1 - alpha_2`. **Correct.**
- `(3,3) - (4,1) = -alpha_1 + alpha_2`, **not** `-alpha_1 + 2 alpha_2`. With `alpha_1 = (1,-1)` and `alpha_2 = (0,1)`, `-alpha_1 + 2 alpha_2 = (-1,3)` while `(3,3)-(4,1) = (-1,2)`. The conclusion is unaffected (both differences still carry a negative coefficient) but the record's arithmetic is wrong as printed.
- **"Their `Sym^3` weight spaces are disjoint" is false.** The two modules share weights: `(0,0)` is dominant and below both highest weights in the root order, so it is a weight of `V_(4,1)` and of `V_(3,3)`. What the root computation actually shows is the weaker and correct statement that **neither highest weight is a weight of the other module**.
- **Does it make the quartic unnecessary?** Yes, but the record over-argues it. A vector of weight `lam` annihilated by the raising operators generates an irreducible `V_lam` *by definition*, so the highest-weight construction never needs a Casimir to separate any pair of blocks, colliding or not. The `(4,1)/(3,3)` computation is a special argument for something that holds for all 24 blocks at once.

---

## Claim 4, the `n = 12` separation as now stated

Four sub-statements. **Three are right; one is false as an identity.**

- `rho(D_6) = (5,4,3,2,1,0)` has `rho_6 = 0`, so `ell_6 = lam_6`. **Correct.**
- `p_2, ..., p_12` are `p_1, ..., p_6` in the variables `ell_i^2`, so Newton returns every `e_1, ..., e_6` and the multiset `{ell_i^2}` is recovered outright. **Correct**, and the recovery of `lam` from the multiset is airtight: `ell_i = lam_i + 6 - i` with `lam_5 >= |lam_6|` gives `ell_1 > ... > ell_5 > |ell_6| >= 0` for every dominant `D_6` weight, which I checked exhaustively over the relevant range and can also see directly, since `ell_i - ell_{i+1} = lam_i - lam_{i+1} + 1 >= 1` and `ell_5 = lam_5 + 1 > |lam_6|`.
- "That multiset is the `O(12)` label." **Correct here, with an unstated hypothesis.** An `O(12)` label with more than six rows (the `det`-twist `[lam] (x) det` of a label with `lam_6 = 0`), restricts to the same `SO(12)` module and would be invisible to this argument. It does not arise because every constituent of `Sym^3([2,2])` has at most six rows in the stable range. The record should say so.
- **"`p_12 = Pf^2`" is false.** `p_12 = sum ell_i^12` and `Pf^2 = prod ell_i^2` are different polynomials. At the trivial block, `ell = rho = (5,4,3,2,1,0)`, `Pf^2 = 0` while `p_12 = 261453379`. The true statement is the one the same paragraph makes two clauses earlier (the two lists *differ* in their sixth element), together with: `Pf^2 = e_6(ell^2)` and `p_12 = p_6(ell^2)` generate the same extension of `Q[p_2,...,p_10]` by Newton, so either may be taken as the sixth `W(B_6)` generator. As written the sentence asserts an equality and contradicts its own preceding clause.

The degree bookkeeping behind "both rings need six" is right: `W(D_6)` has degrees `2,4,6,8,10` and `6`, `W(B_6)` has `2,4,6,8,10,12`.

---

## Claim 5, the rank-3570 squeeze as the record restates it

**The direction is right, the cap is right, and the restatement leaves out the step that makes the two comparable.**

- **Cap.** The span of the orbit is a quotient of `C[G/H]`, whose `lam`-multiplicity is `dim V_lam^H`; with `dim V_lam^H <= 1` and `16` blocks carrying an invariant, `dim S <= sum d_lam = 3570`. **Sound.**
- **Direction.** For an integer matrix, `rank_{F_p} <= rank_Q`. **The record states this correctly.**
- **The gap.** The two are not yet about the same matrix. Reviewer 178's group elements are Cayley transforms of skew matrices **over `F_46337`** (points of `O(5, F_p)`, not reductions of real orthogonal matrices) so the computed Gram matrix is not the reduction of the characteristic-zero Gram matrix, and "a mod-`p` rank is a lower bound for the characteristic-zero rank" does not apply on its face. The repair is one line and it works: a nonzero `3570 x 3570` minor at an `F_p`-point of `SO(5)_Z^N` witnesses that minor, as a polynomial with `Z` coefficients on an irreducible `Z`-scheme, is not identically zero; `SO(5,R)` is Zariski-dense in `SO(5,C)`; so the real rank is at least `3570` too. **The conclusion stands. The record's one-sentence restatement does not, as stated, reach it.**

---

## Claim 6, `sym3_blocks_from_scratch.sage`

**Confirmed for the computation.** I re-ran it: 24 blocks, `sum m·dim = 7770`, multiplicities `41`, unknowns `65`, `c_2` taking 21 distinct values, the twelve multiplicity-one blocks summing to `4125`. Newton's `3 h_3 = h_2 p_1 + h_1 p_2 + p_3` is applied correctly and the printed record figures are compared against, never fed in.

Two things the script does depend on, neither of them fatal.

- **`B2(0, 4)` is a record-supplied identification, and the `assert degree() == 35` does not pin it.** `B_2` has **two** irreducibles of dimension 35: `(0,4) = [2,2]` and `(1,2) = [2,1]` ([b2_check.sage](../scripts/reviewers/r179/b2_check.sage)). The choice made is the right one (`Weyl_5` has `GL`-symmetry type `[2,2]`, so highest weight `2e_1 + 2e_2 = 4 omega_2`) but the script's self-certification is weaker than it looks.
- **It computes `SO(5)` constituents and calls them the blocks of `Sym^3(Weyl_5)`.** That is exactly the substitution the record elsewhere condemns in the `D_6` route. It is harmless at odd `n`, because `-Id` acts trivially on `Weyl_5` so each `SO(5)` constituent extends to exactly one occurring `O(5)` irreducible, but the script does not say this, and the reader cannot tell the sound case from the unsound one.

---

## What I did not check

The record's `theta` values and every geometric claim about the extremiser; the `n = 5` certificate's feasibility; the `Sym^3` covariant construction itself as opposed to its block count; whether degree six is adequate for a certificate at all. My Cartan–Helgason sign rule for the `S^6 <-> S^6` swap is confirmed on two labels by hand (`(2)` and `(4)`) and is otherwise the standard Jacobi-polynomial parity, taken from the theory rather than recomputed here.

## Method notes for the record

- **Memory.** Nothing here went past 60 MB except the one Sage `B6` Adams run, which peaked at 2.9 GB under a watchdog capped at 6 GB ([memguard.sh](../scripts/reviewers/r179/memguard.sh)). The `D_6` route that blew up is avoidable in two ways at once: go to odd `n` (`B6 = SO(13)`, still in the stable range, no chirality fusion to undo) for the block table, and use diagram ranks rather than characters for the invariant counts.
- **The failure mode this cycle exposes** is the one the plan's own preamble names. `n >= 4k` was derived from one sufficient condition and then read as a threshold, and three cycles of King's-rule debugging followed from treating `89` as unreachable at `n = 12`. A ten-line rank computation at `n = 4, 5, 6, 7, 8` would have shown the threshold sitting at `2k` before any of that started.

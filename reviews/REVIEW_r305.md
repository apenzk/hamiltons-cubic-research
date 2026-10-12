### Reviewer 305: the disconnected lemma, the `C_5`-edge family, and the diagonal-only cushion

**Verdicts.**

| | claim | verdict |
|---|---|---|
| **K1** | a direct sum of diagonal critical points is critical exactly under `M = ⊕ (θ/θ_i) M_i` with `θ = (Σ θ_i^-2)^(-1/2)`; the component-indicator `N` is admissible with `L N = θ N`, so every disconnected diagonal critical point with `θ > 0` fails second-order maximality, "with the violating eigenvector written down" | **CONFIRMED as mathematics, REFUTED as a lemma**, every part of it, *including the eigenvector*, is [ATTEMPTS.md](../ATTEMPTS.md)'s Theorem A, and the exhibited `N` is not in `e^⊥` |
| **K2** | the twenty `C_5`-edge directions are constant-Rayleigh at `2/3` and **not** an eigenspace, residual `1/(3 sqrt 2)` | **CONFIRMED**, and the residual is exact, not numerical: the Gram of the residual is `(1/18)·Id` on the whole 20-dimensional span |
| **K3** | the factor-two cushion is diagonal-only; the non-diagonal witness has `ratio 0.5592`, so `Δ > 0 ⇒ λ_max ≥ θ` is false off the diagonal locus | **CONFIRMED**, every figure reproduced from the `.npy` independently, **and three more such points found**, down to `ratio 0.5126` |

**The new objects.** The record has **one** non-diagonal `Δ > 0` critical point with `λ_max/θ < 1`. There are at least **four**, three of them found here, and the thinnest V3 margin is no longer the recorded witness's:

| point | `θ` | `Δ` | `λ_max` of `L_e` on `e^⊥` | `λ_max/θ` | **margin over `1/2`** | criticality |
|---|---|---|---|---|---|---|
| the record's witness | `1.088948052505048` | `1.512230534` | `0.608885447169` | `0.559150` | `1.2178×` | `5.0e-16` |
| new, `seed 9018` | `1.081549248013368` | `2.400930266` | `0.562754631717` | `0.520323` | `1.1255×` | `1.5e-12` |
| new, `seed 9003` | `1.079098984359752` | `1.239250302` | `0.555212537832` | `0.514515` | `1.1104×` | `1.9e-16` |
| **new, `seed 9033`** | `1.079758865610486` | `2.762849577` | `0.553480567238` | **`0.512596`** | **`1.1070×`** | `1.4e-12` |

All four are `∘`-indecomposable (`dim E(1) = 1`), all have `Δ` bounded well away from zero, and all are non-diagonal in *every* frame by the record's own certificate, a simple eigenvalue carrying an eigenvector of bivector rank above `2` (rank `4` at the recorded witness, rank `6` at all three new ones). `seed 9003` has `dim ker W = 7`; the other two have trivial kernel. The `λ_max` figures move by at most `1.1e-10` under random perturbations of size `1e-9`, so the `1.4e-12` residuals are nowhere near the `0.053` these points clear `1/2` by. Saved as [r305_n8_ratio_lt1.npy](../scripts/reviewers/r305/out/r305_n8_ratio_lt1.npy) (`seed 9003`), [r305_n8_seed9018.npy](../scripts/reviewers/r305/out/r305_n8_seed9018.npy) and [r305_n8_seed9033.npy](../scripts/reviewers/r305/out/r305_n8_seed9033.npy).

**The same sweep rediscovered the record's own witness**, from a blended start and a solver that had never seen it: `θ = 1.088948052505048`, `Δ = 1.512230534`, `λ_max = 0.608885447169`, `mult(1/2) = 23`, every digit matching the `.npy`, `<W, W_witness> = 0.956931`, so a different frame on the same orbit. That is the gate on this whole hunt.

**So the off-locus cushion is `1.107×`, not `2×`**, and it is falling as the population grows, which is the shape of a claim that has not yet found its floor.

**No refutation of V3 was found.** Across 66 independently solved full-space critical classes at `n = 6, 7, 8` (19, 14, 33), 63 of them with `Δ > 0`, the smallest `λ_max(L_e|e^⊥)` at a `Δ > 0` point is `0.553481`, against the `1/2` a maximiser needs.

---

#### Method, and the gates it passed first

Everything below runs on an implementation written from the definitions in [problem.md](../findings/problem.md), [second-order.md](../findings/second-order.md) and [bounds.md](../findings/bounds.md), importing nothing under review. Code in [scripts/reviewers/r305/](../scripts/reviewers/r305/); log at [agent_logs/r305-disconnected.log](../agent_logs/r305-disconnected.log).

`so(n)` structure constants `c[a,b,g] = <[φ_a, φ_b], φ_g>` for `φ_ij = E_ij - E_ji`; the sharp product as `T(R,S)_ab = (1/2) Σ c[a,g,d] c[b,e,z] R[g,e] S[d,z]`; `Q(R) = R² + T(R,R)`; `X∘Y = (Q(X+Y)-Q(X)-Q(Y))/2`; `Weyl_n` as the joint nullspace of the `C(n,4)` Bianchi conditions and `Ric = 0`. Gates, none of them tuned, all passed before any claim was tested:

- `dim Weyl_n = n(n+1)(n+2)(n-3)/12` at `n = 4…10`, `10, 35, 84, 168, 300, 495, 770`.
- `T` reproduces Jäger's published diagonal formula `(R#S)_ij = (1/2) Σ_k (r_ik s_jk + r_jk s_ik)` to `8.9e-16` on random non-critical diagonal inputs. External check, not a repo one.
- `θ(S^3×S^3) = 1.054092553 = θ_0(6)`, `θ(S^3×S^5) = 1.115546702`, `θ(S^4×S^4) = 1.145643924`.
- `λ_max(L_e|e^⊥) = 0.500000000` at `S^3×S^5`, `1.206011330` at the `C_5` blow-up.
- `Δ = 12.000000` at the `C_5` blow-up and `1.512231` at the `n = 8` witness. The normalisation is fixed with no freedom left by `Σ_γ g_γ = 4(n-1)`, which comes out at `20.000000` at `n = 6`.
- `mult(1/2) = 23` at the witness, matching Reviewer 302's orbit gate.

---

### K1, the statement is true, it is two lines long, and it is already on the record four times over

#### The scaling law and the `θ` formula reproduce exactly, including where the brief asked me to press

`M = ⊕ (θ/θ_i) M_i` with `θ = (Σ θ_i^-2)^(-1/2)`, criticality residual and the gap between predicted and measured `θ`:

| sum | `n` | comps | `θ` predicted | `θ` error | crit. residual |
|---|---|---|---|---|---|
| `S^2×S^2 (+) S^2×S^3` | 9 | 2 | `0.637792804143` | `0` | `5.6e-17` |
| `S^3×S^3 (+) S^3×S^4` | 13 | 2 | `0.759554525313` | `2.2e-16` | `1.1e-16` |
| `S^2×S^2 (+) S^2×S^3 (+) S^3×S^3` | 15 | 3 | `0.545680079698` | `1.1e-16` | `8.3e-17` |
| `S^2×S^2 (+) S^2×S^3 (+) S^3×S^3 (+) S^3×S^4` | 22 | 4 | `0.488434835438` | `0` | `8.3e-17` |
| **non-sphere `(+)` non-sphere** (`n=7`, `n=6` solved from random seeds) | 13 | 2 | `0.089383150183` | `1.4e-17` | `5.6e-17` |
| **`S^2×S^2 (+)` non-sphere `(+)` non-sphere** | 17 | 3 | `0.088910844895` | `1.4e-17` | `4.9e-17` |
| **three non-sphere summands** | 20 | 3 | `0.087762077716` | `1.4e-17` | `4.5e-17` |

So the answer to *"only for the sphere-product summands tested?"* is no, it holds for summands solved from random seeds with up to eight distinct entry values, and *"does it survive three or more summands?"* is yes, at three and four. Equal scaling instead: residual `1.36e-2` and `3.8e-3` at two mixed-`θ` pairs, and exactly `0` when the summands share a `θ`, as claimed.

#### And it needs no verification at all, it is a two-line consequence of a law already on the record

For `M = ⊕ M_c` block-diagonal, `(M∘N)` and `(MN+NM)/2` are both block-diagonal, so for **any** coefficients `b_c`,

    L(⊕ b_c M_c) = ⊕ b_c (M_c∘M_c + M_c²)|_offdiag = ⊕ b_c θ M_c = θ · (⊕ b_c M_c).

The component-indicator `N_ij = 2 M_ij (a_i + a_j)` **is** this, with `b_c = 4a_c`: across components `M_ij = 0`, and inside component `c` the factor `a_i + a_j` is the constant `2a_c`. *The deformation is an independent rescaling of the blocks, and the `(a_i + a_j)` form hides that.*

This is [second-order.md](../findings/second-order.md) lines 301 and 303 restricted to the diagonal locus, and both are stated there in **greater** generality:

- line 301, the harmonic-square law: *"Criticality of `W = aA + bB` reads `a²θ_A A + b²θ_B B = θ(aA+bB)`, so `aθ_A = bθ_B = θ` and `a²+b² = 1` give `1/θ² = Σ 1/θ_i²`"*, that is K1's forced scaling and K1's `θ` formula, for arbitrary `∘`-orthogonal critical pieces, with no diagonality and no connectivity anywhere in it.
- line 303: *"`A_i ∘ W = a_i Q(A_i) = θ A_i`, so **every `∘`-summand lies in `E(1)` of `L_e`**"*, that is K1's eigenvector.
- [target.md](../findings/target.md) line 166 carries `1/θ² = Σ 1/θ_i²` a third time, as the reason no direct sum climbs above `sqrt(3/2)`.

The commit message reads *"Searched: none, the scaling is forced by the criticality equation already in this file"*. It is forced, and it was already forced three files earlier.

**And the consequence is not the new line either, it is Theorem A, with the same eigenvector.** [ATTEMPTS.md](../ATTEMPTS.md) line 985:

> *Theorem A (direct-sum saddle lemma).* Any critical point with `θ > 0` that splits over disjoint coordinate blocks is a saddle: `H = ||W_2||² W_1 − ||W_1||² W_2` gives `Hess = +3θ||H||²` exactly. This kills the entire Fox plateau analytically, for every `k ≥ 2` and every `n`.

"Splits over disjoint coordinate blocks" **is** the disconnected diagonal case, and more; `k ≥ 2` and every `n` is the same range; and `H` is the same direction. I built that `H` independently before finding the line, and it checks out: `<H,W> = 0`, `L_e H = H` to `2.2e-16`, and

    Hess = 6θ(<H, L_e H> − ½||H||²) = 0.459279326772 = 3θ||H||²     at n = 8,
                                    = 0.474909206647 = 3θ||H||²     at n = 9,

relative error `8.5e-16` and `9.4e-16`. Theorem A is strictly stronger than K1's conclusion: `Hess > 0` says the point is a saddle with an explicit **ascent** direction, where `λ_max ≥ θ` says only that Lemma L24 fails.

So the record's current reconciliation ([diagonal-half.md](../findings/diagonal-half.md) line 155, added by Reviewer 306 mid-audit), *"what the re-derivation adds is the explicit eigenvector, which the recorded route does not name"*, is **also wrong**, by one line of [ATTEMPTS.md](../ATTEMPTS.md). K1 adds nothing at all. The chain of prior statements is four deep:

| where | what it says | relative strength |
|---|---|---|
| [ATTEMPTS.md](../ATTEMPTS.md) line 985, Theorem A | disjoint-block split `⇒` saddle, with `H` named and `Hess = +3θ·norm(H)²` | **strongest**, names the eigenvector *and* signs the Hessian |
| [nondegeneracy.md](../findings/nondegeneracy.md) line 403 | the same lemma, "decomposable maximizers excluded with no hypothesis at all" | excludes local maxima |
| [support-dichotomy.md](../findings/support-dichotomy.md), Lemma L66 | no maximiser of `P` is `∘`-decomposable | excludes global maxima only |
| [second-order.md](../findings/second-order.md) lines 301, 303 | the harmonic-square law; every `∘`-summand lies in `E(1)` | the scaling law and the eigenvector's home |

#### Correction 1, the exhibited eigenvector is NOT admissible, at the record's own three verification points

Lemma L24 bounds `λ_max(L_e|e^⊥)`. The record checks `N` against the **row sums** (`6e-17`) and calls it admissible. Row sums are automatic (every `⊕ b_c M_c` inherits them) and they are not the binding constraint. The binding one is `N ⊥ W`, and it fails:

| sum | `<W,N>`, `a = (+1,−1)` on components | `<W,N>`, `Σ_vertices a = 0` |
|---|---|---|
| `S^3×S^3 (+) S^4×S^4` | `+0.664756` (cosine `0.083`) | `+1.581662` (cosine `0.221`) |
| `S^3×S^5 (+) S^3×S^3` | `−0.452830` (cosine `0.057`) | `−1.861635` (cosine `0.196`) |
| `S^4×S^4 (+) S^5×S^5` | `+0.370572` (cosine `0.046`) | `+1.133515` (cosine `0.156`) |

Those are the three sums the record verifies at `1e-17`. On **all three**, under **both** readings of "`sum a = 0`", the written-down direction has a component along `W`, so as written it is a direction on the cone, not on the sphere, and it certifies nothing.

**The repair is exact and cheap.** `<W,N> = Σ_c b_c ||M_c||_F²` and `||M_c||_F² = 2(θ/θ_c)²`, verified to the digit, e.g. `[1.083095, 0.916905]` at `S^3×S^3 (+) S^4×S^4` against the predicted `2(θ/θ_c)²`, so the admissibility condition is

    Σ_c a_c θ_c^-2 = 0,     not     Σ a = 0,

which is a `(k−1)`-dimensional space of directions, nonzero as soon as there are two components. With it, `<W,N> ≤ 1.3e-15` and `||L N − θ N|| ≤ 2.2e-16` at all four sums tested. `Σ a = 0` coincides with it only when the summands share a `θ`, and **none** of the record's three verification sums does.

#### Correction 2, the consequence does follow, and the "diagonal is only a lower bound" worry runs the right way

The brief asks whether "fails second-order maximality" follows given that the diagonal `λ_max` is only a lower bound. It does, and the lower-bound direction is the favourable one: a diagonal `N` sits in `Weyl_n` (a diagonal pair matrix satisfies Bianchi vacuously (the three entries in every four-index relation are off-diagonal) and zero row sums *are* Ricci-flatness, confirmed at `4.4e-16`), so any Rayleigh quotient there is a genuine lower bound for the full-space `λ_max`. Checked in the full `Weyl_n`, not on the locus:

| point | `n` | `dim Weyl_n` | `θ` | diagonal `λ_max(L_e)` | **full** `λ_max` of `L_e` on `e^⊥` | `dim E(1)` | `Δ` |
|---|---|---|---|---|---|---|---|
| `S^2×S^2 (+) S^2×S^2` | 8 | 300 | `0.612372435696` | `1.333333333` | `1.333333333334` | 4 | `0` |
| `S^2×S^2 (+) S^2×S^3` | 9 | 495 | `0.637792804143` | `1.291666667` | `1.291666666668` | 3 | `0` |

with `A ∘ B = 0` **exactly** between the two blocks, and the repaired direction `v = ||B||²A − ||A||²B` satisfying `<v,W> = 0` and `L_e v = v` to `2.2e-16`. Note the top of the spectrum is `1.333` and `1.292`, not `1`, the `θ`-eigenvector the lemma writes down is **not** the violating direction, only *a* violating direction.

#### Correction 3, "disconnected" is not the hypothesis that does the work

`∘`-decomposability implies the failure; disconnectedness implies `∘`-decomposability; the converse fails, and it fails on connected points the lemma cannot see:

| point | comps | smallest entry in modulus | `dim E(1)` | diagonal `λ_max` of `L_e` on `M^⊥` | full `λ_max` of `L_e` on `e^⊥` |
|---|---|---|---|---|---|
| `S^2×S^2` (`n=4`) | **1** | `0.288675` | 2 | `−1.000000000` | `1.000000000` |
| `K_3` blow-up, blocks of 2 (`n=6`) | **1** | `0.129099` | 6 | `1.000000000` | `1.000000000` |
| `K_4` blow-up, blocks of 2 (`n=8`) | **1** | `0.077152` | 12 | `1.000000000` | `1.000000000` |
| `K_3` blow-up, blocks of 3 (`n=9`) | **1** | `0.096225` | 3 | `1.000000000` | `1.000000000` |
| `C_5` blow-up (`n=10`) | 1 | `0.074536` | 1 | `1.206011330` | `1.206011330` |

Every one of the first four is **connected** (every entry of `M` is nonzero) and every one carries an exact `1`-eigenvector of `L_e` in `e^⊥`. `S^2×S^2` is the sharpest: its splitting is the self-dual/anti-self-dual splitting of `Weyl_4`, entirely invisible on the diagonal locus, where the only admissible `M^⊥` direction sits at `−1`. **A diagonal-only, connectivity-keyed lemma misses it; the `E(1)` statement catches it.**

The `K_3` blow-up with blocks of `3` is `(S^3)^3`, and it is a further gate passed: `θ = 0.769800359` and `λ_max = 1` reproduce [nondegeneracy.md](../findings/nondegeneracy.md) line 379 (*"a saddle: `λ_max(L_e|W^⊥) = 1`, not `1/2`"*), to the digit, from a pipeline that never saw it.

#### Scope notes

- **Not vacuous for V3, but the three examples chosen to verify it are.** Every disconnected sum of *sphere products* tested has `Δ = 0`, outside V3's target set entirely, and that includes all three of the record's verification points. Sums with a non-sphere summand do reach `Δ > 0`: ten distinct such points, `Δ` from `5.070` to `10.620`, with `λ_max(L_e)` from `2.316` to `7.449`. So the lemma has work to do; the sums it was checked on have none.
- **`θ_i = 0` summands.** `155` of `600` random diagonal solves returned a genuine critical point with `θ = 0` (residual `< 1e-12`). `c_i θ_i = θ` has no solution there, so such a block can never appear in a `θ > 0` sum, the `θ` formula is undefined rather than wrong, but the lemma should say `θ_i ≠ 0`.
- **Criticality permits one more scaling than the lemma states.** `c_i² θ_i = θ c_i` gives `c_i ∈ {0, θ/θ_i}`, so blocks may also be *dropped*. "Only when scaled as criticality forces" is right up to dropping summands.

---

### K2, confirmed, and the residual is exact

At the `C_5` blow-up rebuilt from a block-constant ansatz (`θ = 0.670820393`, criticality `6.9e-16`, row sums `0`, entries `−0.149071198`, `0.074535599`, `0.298142397`, `Δ = 12.000000`, `λ_max(L_e|e^⊥) = 1.206011330`), the twenty `H_A = D_A W + W D_A` for `A = E_ab + E_ba` with `a`, `b` in `C_5`-adjacent blocks, projected to `Weyl_10`:

- they span exactly **20** dimensions, and `max |<g,W>|/||g|| = 3.8e-17`;
- the compression of `L_e` is `(2/3)·Id_20`, deviation `5.7e-15`, so **every** unit vector in the span has Rayleigh quotient `2/3`;
- the residual `r = L_e u − (2/3) u` has Gram matrix `(1/18)·Id_20`, **all twenty** eigenvalues equal `0.055555556`, so `||r|| = 0.235702260 = 1/(3 sqrt 2)` for every unit `u`, and the constant is the rational `sqrt(1/18)`, **exact rather than numerical**;
- the family is not invariant: the operator norm of `(I−P) L_e P` is `1/(3 sqrt 2)` itself.

The logic K2 retains is sound: a constant compression of `2/3` on a 20-dimensional subspace of `e^⊥` bounds `λ_max(L_e|e^⊥) ≥ 2/3 > 1/2` with no eigenvector extracted. Independently, the full `Sym_0` compression spectrum reproduces [bounds.md](../findings/bounds.md)'s table row exactly, `0` (×10), `0.412281` (×20), `0.441754` (×2), `2/3` (×20), `0.820541` (×2) on a 54-dimensional family.

**Other blow-ups, which the brief asked for.** The `C_5` pattern is *not* generic; at complete block graphs the same family is a **genuine** eigenspace:

| blow-up | `n` | `θ` | `Δ` | edge family | compression | residual |
|---|---|---|---|---|---|---|
| `C_5`, blocks of 2 | 10 | `0.670820393` | `12` | 20-dim | `(2/3)·Id` | `1/(3 sqrt 2)` |
| `K_4`, blocks of 2 | 8 | `0.540061725` | `0` | 24-dim | `(1/2)·Id` | **`0`** |
| `K_5`, blocks of 2 | 10 | `0.474341649` | `0` | 40-dim | `(1/2)·Id` | **`0`** |

`C_5` with blocks of size 1 (`n=5`), `C_7` and `C_9` with blocks of size 1, and the unbalanced `C_5` blow-up `(1,1,1,1,2)` at `n=6` admit **no** critical block-constant point at all, consistent with the record's "no `C_5` blow-up exists at `n=6`".

---

### K3, confirmed from the `.npy`, and the scoping conclusion is logically sound on one witness

Loaded `scripts/data/w_n8_nondiagonal_witness.npy` and recomputed everything:

| quantity | value |
|---|---|
| norm `<W,W>` | `1.000000000000` |
| in `Weyl_8` | error `2.2e-16` |
| `θ` | `1.088948053` |
| criticality residual, max entry of `Q(W) − θW` | `5.0e-16` |
| `Δ` | `1.512231` |
| `λ_max` of `L_e` on `e^⊥` | `0.608885447` |
| **ratio `λ_max/θ`** | **`0.559150132`** |
| `dim E(1)` | `1` (`∘`-indecomposable) |
| `mult(1/2)` | `23` |
| `dim ker W` | `0` |

Every figure matches the record. So `Δ > 0 ⇒ λ_max ≥ θ` is **false off the diagonal locus**, V3 holds at the witness with margin `0.608885/0.5 = 1.2178×`, and the "factor two" both censuses report is a property of the locus they censused. A universal claim needs one counterexample, so *one* witness is a complete basis for the **negative** claim K3 makes; what one witness cannot support is any *replacement* cushion, and K3 does not assert one.

**More witnesses, which is what the brief asked for, and they exist.** 66 full-space critical classes were solved at `n = 6, 7, 8` (19, 14, 33) by Gauss–Newton with the analytic Jacobian `DF[H] = 2 L_W H − (3<Q(W),H> − 2θ<W,H>) W − θH`, the record's fence post about numerical Jacobians does not apply, since the analytic one costs one `L_W` build per Newton step, so a sweep does finish. Random and power-iteration starts land in a low-`θ` regime (`θ` down to `0.0017`) where the ratio runs to `1.96e5` and says nothing; **starts blended from the witness, `S^3×S^5` and `S^4×S^4` at `5%`–`80%` noise are what reach the interesting band**, and three of them returned the points tabled at the head of this report, at `ratio` `0.520323`, `0.514515` and `0.512596`.

So "one is a thin basis" is answered outright: there are at least four, spread over `0.5126`–`0.5592` in `ratio`, and **three of them are closer to refuting V3 than the recorded one**. The scoping claim is not resting on a single accident, and the replacement figure a proof of V3 must survive is `1.107×`, not `1.22×` and certainly not `2×`.

---

### The bonus, and it was not found

A diagonal critical point with `Δ > 0` and **full-space** `λ_max ≤ 1/2` would refute V3 outright. Nothing found:

- 47 independently solved full-space critical classes at `n = 6, 7, 8` (19, 14, 14), 45 of them with `Δ > 0`, non-diagonal by certificate wherever a simple eigenvalue exists, minimum `λ_max` of `L_e` on `e^⊥` over the `Δ > 0` ones is `0.555213`;
- ten `Δ > 0` disconnected diagonal sums, `λ_max(L_e)` from `2.316` to `7.449`;
- the `C_5` blow-up at `1.206011330`, the recorded witness at `0.608885447`, and the three new points at `0.562754632`, `0.555212538` and `0.553480567`.

The closest approach to `1/2` anywhere in this audit is `0.553481`, a margin of `1.1070×`. It is a **thinner** cushion than anything on the record off the diagonal locus, and it still clears the bound.

---

### What I would change in the record

1. **Delete the disconnected lemma and cite Theorem A.** [diagonal-half.md](../findings/diagonal-half.md) line 155 currently retains it for "the explicit eigenvector, which the recorded route does not name", [ATTEMPTS.md](../ATTEMPTS.md) line 985 names it, and signs the Hessian on it. If a canonical home is wanted, the statement to promote is the `E(1)` form: *a critical point with `dim E(1) ≥ 2` has `λ_max(L_e|e^⊥) = 1 > 1/2`, hence is not a local maximiser*, one line from [second-order.md](../findings/second-order.md) line 303 plus Lemma L24, valid on all of `Weyl_n`, and it covers the connected `K_k` blow-ups and `S^2×S^2` that any coordinate-block statement misses. The three rows of that file's own `dim E(1)` table at `2, 3, 6` are then discharged where they sit.
2. **Fix the admissibility clause** in [diagonal-half.md](../findings/diagonal-half.md): the condition is `Σ_c a_c θ_c^-2 = 0`, and the row-sum check is not the one that matters.
3. **Withdraw the novelty framing completely, not by half.** The scaling and the `θ` formula are the harmonic-square law of [second-order.md](../findings/second-order.md) line 301 and appear again in [target.md](../findings/target.md) line 166; the consequence *and its eigenvector* are [ATTEMPTS.md](../ATTEMPTS.md)'s Theorem A. The `Searched: none` trailer on `a8b0597` is the internal-search miss the record's own convention exists to catch, and the correction filed against it this cycle stops one line short.

4. **File the three further non-diagonal witnesses**, tabled at the head of this report and saved in [scripts/reviewers/r305/out/](../scripts/reviewers/r305/out/). They cut the off-locus cushion from `1.2178×` to **`1.1070×`**, which is the number a proof of V3 now has to survive, and they turn the scoping claim from a one-point observation into a four-point one. `seed 9018` and `seed 9033` are worth re-solving to machine precision before being catalogued, mine sit at `1.4e-12`.

5. **Record where the falsifier hunt should look.** Blended starts from the known high-`θ` points reach the band; random and power-iteration starts do not, they returned `θ` as low as `0.0017` and never came near. That is a method note the I19 item can use directly, and it is the reason the record has one witness where there are at least four.

6. **Note the kernel.** `seed 9003` has `dim ker W = 7`, and [target.md](../findings/target.md) records that the gradedness test is valid only at `ker W = 0`, while `Δ` is discontinuous at a zero crossing. Its `Δ = 1.2393` is therefore a measured trace over `{λ > 0}` and should be read with that threshold attached, exactly as the record's domain note requires. `seed 9018` and `seed 9033` have trivial kernel and carry no such caveat.

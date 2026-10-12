### Reviewer 302: V3's branching reduction, its closed form, and the mechanism claimed for it

**Verdicts.**

| | claim | verdict |
|---|---|---|
| **H1** | `L_e` is scalar on each `k`-isotypic component, so V3 reduces to a branching computation | **REFUTED** |
| **H2** | `L_e = (p-2)/(2(p-1))` on `Sym_0(R^p)` and `1/2` on `R^p ⊗ R^q` at sphere products | **CONFIRMED**, and now derived rather than fitted; the second half is true but vacuous |
| **H3** | the balanced case is annihilated, margin `1/(2(k-1))` | **CONFIRMED as an eigenvalue statement; its stated mechanism REFUTED**, `H_A ≠ 0`, the *projection* of `H_A` is |
| **H4** | `Δ > 0` shrinks `k`, refines the decomposition, and a piece clears `1/2` | **REFUTED** as a mechanism; the underlying observation survives as a certificate |
| **H5** | the block-graph edge average separates violators from maximizers | **REFUTED** |

**No counterexample to V3 itself was found**, in 218 `Δ > 0` critical classes at `n = 6..10` (169 diagonal, 49 non-diagonal), plus the record's catalogued points. V3 stands; the route to it described in [bounds.md](../findings/bounds.md) does not.

---

#### Method, and what it was gated on

Everything below runs on an implementation written from the definitions in [second-order.md](../findings/second-order.md) and [b_symmetry_defect.py](../scripts/lib/b_symmetry_defect.py)'s prose, importing nothing under review. Code in [scripts/reviewers/r302/](../scripts/reviewers/r302/); log at [agent_logs/r302-v3-branching.log](../agent_logs/r302-v3-branching.log).

The sharp product was re-derived rather than copied: summing the record's quadratic form over an orthonormal basis collapses it to `<R# η, η> = -(1/2) tr(ad_η R ad_η R)`, whose polarisation is `(X#Y)_{ab} = -(1/4)[tr(A_a X A_b Y) + tr(A_b X A_a Y)]` with `A_a = ad(ω_a)`. `Weyl_n` was built as the joint nullspace of the Bianchi conditions `M[ij,kl] - M[ik,jl] + M[il,jk] = 0` and `Ric = 0`.

Gates passed before any claim was tested, none of them tuned:

- `dim Weyl_n = n(n+1)(n+2)(n-3)/12` at `n = 4..12`.
- `Q` agrees with Jäger's published diagonal formula `(R#S)_{ij} = (1/2) Σ_k (r_ik s_jk + r_jk s_ik)` to `2e-16`, an external check, not a repo one.
- `θ_0(6) = 1.054092553`, `θ(CP^2) = 1.224744871 = sqrt(3/2)`.
- `Δ = 12.000000` at the `C_5` blow-up and `1.512231` at the `n = 8` witness, matching the record exactly on the first attempt, which fixes the convention with no freedom left.
- The orbit gate: `mult(1/2)` in `spec(L_e)` must be at least `n(n-1)/2 - dim k(W)`, since orbit tangents are exact `1/2`-eigenvectors. It holds at every point, with equality at five of six, `S^3×S^5` 15/15, `S^4×S^4` 16/16, `CP^4` 12/12, the witness 23/23, the `n = 8` live-target point 28/28, the `C_5` blow-up 60 against 40. This gates `L_e`, the isotropy computation and the orbit theory against each other in one number.
- Every number in the record's two tables reproduced: `S^3×S^5` (`1/4`×5, `3/8`×14, `1/2`×15), `CP^4` (`3/5`×15), the witness (`0.588721`, full-space `0.608885`), the `C_5` blow-up (`0`×10, `0.412281`×20, `0.441754`×2, `2/3`×20, `0.820541`×2, full-space `1.206011330`), `S^4×S^6` (`1/3`, `2/5`, `1/2`), `S^3×S^7` (`1/4`, `5/12`, `1/2`), `S^5×S^5` (`3/8`×28), `S^4×S^4` (`1/3`×18).

**One thing the record's tables gloss.** `V = span Π_{e⊥} Π_Weyl H_A` is *not* `L_e`-invariant at either `Δ > 0` point: `||L_e U - U M|| = 1.24` at the `C_5` blow-up and `0.67` at the witness, against `1e-15` at every sphere product and at `CP^4`. So the tabulated "eigenvalues" at exactly the two points that carry V3's evidence are Rayleigh–Ritz values of a compression. That is harmless for certifying a violation (a Rayleigh quotient above `1/2` still bounds `λ_max` below) but it is not what "eigenvalue" means, and it matters for H1 below.

---

#### H1, REFUTED

**The theorem is not the one claimed.** Schur's lemma applied to `L_e` commuting with `k` gives `L_e = ⊕_λ F_λ ⊗ Id_{V_λ}` with `F_λ` an operator on the *multiplicity space* `M_λ`. It is a scalar exactly when `m_λ = 1`. The record states this correctly elsewhere, [route-a.md](../findings/route-a.md) says multiplicities "are exactly what the spaces `M_λ` absorb", and [nondegeneracy.md](../findings/nondegeneracy.md) says "multiplicity-freeness forces one scalar per piece". H1 drops the hypothesis, and the points where V3 needs it are precisely the points that fail it.

**Measured, at both of the record's own `Δ > 0` points.** The trivial `k`-isotype `V^k = {v : ρ(x)v = 0 for all x in k(W)}` is one isotypic component by definition, so if H1 held, `M` restricted to it would be a scalar matrix.

| point | `dim k(W)` | `dim V` | `dim V^k` | `L_e` on `V^k` |
|---|---|---|---|---|
| `S^3×S^5` | 13 | 34 | 0 |, |
| `S^4×S^4` | 12 | 18 | 0 |, |
| `CP^4` | 16 | 15 | 0 |, |
| the `n = 8` witness | 5 | 35 | **3** | **0.181254, 0.339368, 0.588721** |
| the `C_5` blow-up | 5 | 54 | **4** | **0.441754 ×2, 0.820541 ×2** |

`V^k` is `M`-invariant to `1e-15` in both cases, so these are exact restrictions, not compressions of compressions. **In each case the value that certifies the violation shares its isotypic component with a value far below `1/2`**, `0.588721` with `0.181254`, and `0.820541` with `0.441754`. Branching data cannot distinguish them, because branching data is what they have in common.

**The sharpest form, on the record's own live-target point.** The `n = 8` diagonal critical point with `S_mmm = 0`, `θ = 0.555683027`, `Δ = 11.044877` and `λ_max = 1.380653`, the one [bounds.md](../findings/bounds.md) singles out as "on the live target set", has **`k(W) = 0` exactly**. The map `x -> [ad x, W]` has smallest singular value `0.63568148` with `||W|| = 1`, so there is no tolerance question. With trivial isotropy, `Sym_0(R^8)` is 35 copies of the trivial representation: **one isotypic component, of multiplicity 35**. H1 predicts one value of `L_e` there. Measured: **eight**, `-0.426616`, `-0.073384`, `-0.061667`, `-0.016378`, `+0.201651`, `+0.556441`, `+0.792248`, `+0.832469`.

**A counting form that needs no representation theory.** At the witness the true number of `k`-isotypic pieces is **11** (`dim End_k(V) = 27`, `dim Z(End_k(V)) = 19`), while `L_e` takes **13** distinct values on `V`. More values than pieces is impossible if `L_e` is scalar per piece. At `S^3×S^5` and `CP^4`, where H1's hypothesis does hold, the counts agree exactly: 3 pieces / 3 values and 1 piece / 1 value.

**The stated motivation is also false.** "Which is why the `C_5`-edge family came out an exact eigenspace rather than merely a subspace with a large average", it is exactly the latter. For every unit `u` in the 20-dimensional edge family, `<u, L_e u> = 2/3` to `6e-15` (the quadratic form really is constant), but `L_e u = (2/3)u + r` with `||r|| = 0.235702 = 1/(3 sqrt 2)` for every one of the 20 directions. `2/3` is an eigenvalue of `L_e` on `Weyl_10`, with multiplicity 5; the edge family is not that eigenspace.

**And the reduction runs backwards under its own hypothesis.** Across the 20 `Δ > 0` diagonal classes at `n = 8`, `dim k(W)` runs `0..5`, and it is `0` at every one of the large-`Δ` points. At `dim k = 0` the isotypic decomposition of `Sym_0(R^n)` is a single piece of multiplicity `dim Sym_0(R^n)` and Schur constrains nothing whatsoever. So "V3 reduces to a finite branching computation over the possible isotropy algebras" reduces nothing in exactly the regime `Δ > 0` produces. What survives of the idea is much weaker and worth stating positively: **`L_e` restricted to `V` is a `k`-equivariant operator, so it is block-diagonal over the isotypic decomposition with blocks `F_λ` of size `m_λ`.** At `S^p×S^q` and `CP^m` every `m_λ` is 1 and the blocks are numbers; at every `Δ > 0` point on file they are not.

---

#### H2, CONFIRMED, and here is the derivation the brief asked for

**`L_e` on `Sym_0(R^p)` is `(p-2)/(2(p-1))`, proved.** Write `W` for the Weyl part of `S^p × S^q`: diagonal in the `ω` basis with `a` on `pp` pairs, `b` on `qq`, `c` on mixed, and Ricci-free, i.e. `(p-1)a + qc = 0` and `(q-1)b + pc = 0`. Put `c = -s`, so `a = qs/(p-1)`, `b = ps/(q-1)`, and criticality gives `θ = (n-1)s`.

For `A` symmetric traceless supported on the first block, diagonalise it inside the block as `diag(α_1..α_p, 0..0)`. Then `D_A` is diagonal with entries `α_i + α_j`, so `H_A` is diagonal with `h_ij = 2(α_i+α_j)λ_ij`. Its Ricci is `-2a·diag(α)`, trace-free; the scalar part vanishes; and since `Ric(D_E) = (n-2)E` for trace-free `E`, the Weyl projection is `H_A - D_E` with `E = -2a diag(α)/(n-2)`. That leaves a diagonal tensor of the shape

- `pp`: `β(α_i + α_j)`, `qq`: `0`, mixed: `γ α_i`, with the Weyl condition `β(p-2) + qγ = 0`.

The Weyl condition makes that shape one-dimensional for each `α`, so `L_e` is forced to act by a scalar on it. Computing `(W∘H)_{ij} = λ_ij h_ij + (1/2) Σ_{k≠i,j} (λ_ik h_jk + λ_jk h_ik)` (legitimate because `Q` is diagonal on diagonal operators), the `pp` entry comes out as `(α_i+α_j)[aβ(p-2) + cγq]/2`, and substituting `qγ = -β(p-2)` collapses it to

`λ = (p-2)(a-c) / (2θ) = (p-2) · s(n-1)/(p-1) / (2(n-1)s) = (p-2)/(2(p-1))`.

The mixed entry gives `[(n-2)(p-1) - q] / (2(n-1)(p-1))`, and `(p+q-2)(p-1) - q = (p-2)(p-1+q) = (p-2)(n-1)` makes the two agree identically, a consistency check the derivation had to pass and does. Confirmed out of sample at **14 pairs beyond the record's three**: `(2,4), (2,6), (2,3), (3,4), (3,6), (3,8), (4,5), (4,7), (5,6), (5,7), (6,7)` and the balanced `(3,3), (4,4), (5,5), (6,6)`, every value exact to `1e-9`.

**The second half is true and empty.** For mixed `A = E_uv + E_vu` the Weyl projection is *exactly proportional to an orbit tangent*:

`Π_Weyl H_A = c* · [D_X, W]`, with `X = E_vu - E_uv` and `c* = (q(q-1) - p(p-1)) / ((n-1)(n-2))`,

derived from the same two-block bookkeeping and verified to `5e-16` at `(3,5), (4,6), (3,7), (2,6), (5,7), (4,4), (5,5)`; the measured cosine between the two vectors is `1.000000000000` at every unbalanced pair. Orbit tangents are exact `1/2`-eigenvectors of `L_e` at *every* critical point, this record derives that twice, in [second-order.md](../findings/second-order.md) and in [bounds.md](../findings/bounds.md). So `L_e = 1/2` on `R^p ⊗ R^q` says nothing about sphere products; it is `O(n)`-equivariance, and it would hold at a counterexample too.

**Consequence for V3.** "No sphere product violates through `Sym_0`" is now a theorem, but a weaker one than it reads: the only piece that carries information is `Sym_0(R^p)`, where `(p-2)/(2(p-1)) < 1/2` because `p - 2 < p - 1`. The mixed piece saturates for a reason unrelated to the point.

---

#### H3, conclusion CONFIRMED, mechanism REFUTED

The brief asks whether `D_A W + W D_A` vanishes before projection or only after. **Only after, and the record's sentence is false as written.** At the normalised mixed generator:

| point | `||H_A||` | `||Π_Weyl H_A||` |
|---|---|---|
| `S^3×S^3` | 0.210819 | `2.2e-17` |
| `S^4×S^4` | 0.133631 | `5.2e-17` |
| `S^5×S^5` | 0.094281 | `4.6e-17` |
| `S^6×S^6` | 0.071067 | `6.6e-17` |

`H_A` is not zero; it is *exactly* the pure-Ricci direction `(2s/(n-2)) D_A`, which is orthogonal to `Weyl_n` by the standard decomposition. This is the `c* = 0` case of the H2 formula above: `q(q-1) - p(p-1)` vanishes at `p = q`.

**The trace-split direction dies by a third mechanism again.** For `A = diag(q,...,q,-p,...,-p)`, `Π_Weyl H_A` is nonzero at `p ≠ q` and is *exactly parallel to `W`*, the measured cosine is `1.000000000000` at `S^3×S^5` and `S^4×S^6`, so it is the `e⊥` projection, not the Weyl projection, that removes it. At `p = q` it is the Weyl projection again. One sentence of H3 therefore packs three different vanishings under one description.

**What is right.** `1/2 - (k-2)/(2(k-1)) = 1/(2(k-1))`, and the `Sym_0` spectrum at `S^k×S^k` is that single value with multiplicity `2·(k(k+1)/2 - 1)`, `1/4`×10, `1/3`×18, `3/8`×28, `2/5`×40 at `k = 3,4,5,6`, confirmed.

**What is overstated.** "Strictly stable in the symmetric directions" claims more than the computation supports. In the `R^k ⊗ R^k` directions the test vector is *zero*, so nothing is tested there at all, a margin cannot be read off a subspace the map annihilates. And `λ_max(L_e|e⊥) = 0.500000000` at `S^4×S^4` and `S^5×S^5` regardless: the point is still exactly at the bound overall, saturating on the orbit, so "strictly stable, where unbalanced products merely saturate" is a statement about a proper subspace and not about second-order behaviour.

**One trap, since the record's tables could carry it.** A purely relative rank tolerance on `span Π_Weyl H_A` returns *full rank on floating-point noise* exactly when the family is annihilated. My own first pass reported `dim 16` and an average of `0.0636` at `S^4×S^4` before an absolute floor was added; with the floor the dimension is `0`, as H3 says.

---

#### H4, REFUTED as a mechanism

**The count is wrong.** "Isotypic pieces go `3 -> 13`", the true `k`-isotypic piece count at the witness is **11**. `13` is the number of distinct `L_e` values, and `13 > 11` is H1's refutation restated. At `S^3×S^5` the two counts coincide at `3`, which is presumably how the conflation went unnoticed.

**The refinement does not isolate the violating piece.** The piece that clears the bound at the witness is the trivial isotype, and `L_e` also takes `0.181254` and `0.339368` on it. At the `C_5` blow-up the same holds for `0.820541` and `0.441754`.

**The correlation fails in both directions.** Across the 28 diagonal critical classes at `n = 8`:

- `Δ > 0` with a *coarse* decomposition still violates, hard. The largest-`Δ` classes have `dim k(W) = 0` (a single isotypic piece), with `λ_max` reaching `8.041272`. "Δ > 0 shrinks `k`, the decomposition refines" is inverted at the limit: shrinking `k` to zero makes the isotypic decomposition maximally coarse (one piece) while moving everything into the multiplicity space.
- `Δ = 0` with a coarse decomposition violates too, and `CP^4` is not the only witness. `θ = 0.720082` has `dim k = 7`, 3 distinct `L_e` values on `Sym_0` and `λ_max = 1.000000`; `θ = 0.690849` has `dim k = 8`, 3 values, `λ_max = 1.000000`; `θ = 0.612372` has `dim k = 4`, 5 values, `λ_max = 1.333333`.

Over the `Δ > 0` classes the correlation between `dim k(W)` and `λ_max` is `-0.57`, a trend, not a mechanism, and one that is confounded by `θ` (small `θ` goes with both small `k` and large `λ_max`).

**What survives.** The *observation* is robust and useful: at every `Δ > 0` point tested, `λ_max(L_e|Sym_0) > 1/2`, so `Sym_0` certifies non-maximality. That is a certificate, not a mechanism, and it was already recorded as such.

---

#### H5, REFUTED

*From the addendum, which arrived mid-task.*

I read "block graph" as the **negative** block graph, the one for which `C_5` is the edge set at the `C_5` blow-up, and which gives the single cross-block edge at `S^p × S^q`. Reproduced first: **`2/3` exactly on 20 dimensions** at the `C_5` blow-up, **`41/76 = 0.539474`** across all block pairs, **`1/2` exactly** at `S^3×S^5` and `S^4×S^6`, **empty** at `S^3×S^3`, `S^4×S^4`, `S^5×S^5`.

**The break.** Three `Δ > 0` critical points at `n = 12`, each critical to `1.6e-16`, Ricci-flat to `1.9e-16`, and inside `Weyl_12` to `4.4e-15`:

| point | `Δ` | `λ_max(L_e|e⊥)` | edge average | `dim` |
|---|---|---|---|---|
| six blocks of 2, `θ = 0.728768` | 8.9432 | **1.151927** | **0.424302** | 36 |
| six blocks of 2, `θ = 0.707223` | 12.4362 | **1.098195** | **0.496844** | 32 |
| four blocks, `θ = 0.693915` | 8.2179 | **1.044444** | **0.498347** | 28 |

The first is the `C_5` blow-up's closest possible sibling: six blocks of size 2, exactly three distinct off-block values (`+0.100866`, `-0.081098`, `-0.153884`) on a constant diagonal `+0.228696`, with a 3-regular negative block graph. Same construction, same shape, one more block, and the statistic reads `0.424302`, at a point whose `λ_max` is `1.152`. The edge family there does contain a piece above the bound (its spectrum is `{0.037765, 0.617571}`), which is exactly why an *average* is the wrong summary.

**And the third break survives every reading of "block graph".** Since a point found by solving does not come labelled with a graph, I computed the average for *every* non-empty subset of the off-block value classes. At the four-block point (`Δ = 8.2179`, `λ_max = 1.044444`) all seven readings fall at or below the bound, `0.484554`, `0.486969`, `0.491575`, `0.491981`, `0.494214`, `0.498347`, `0.500000`, so the criterion fails there whatever "edge" is taken to mean. At the six-block point six of seven readings fail; the exception is the 2-regular part of the negative graph on its own, at `0.617571`.

**The `1/2` at unbalanced maximizers is forced, so it separates nothing.** H2 above proves it: that family *is* the orbit tangent, to a cosine of `1.000000000000`, and orbit tangents are exact `1/2`-eigenvectors at every critical point. The statistic returns `1/2` there for the same reason it would at a counterexample.

**The `2/3` at `C_5` is not symmetry-forced, though its constancy is.** Holding the `D_5` block symmetry and the Ricci-free constraint but moving the parameters off criticality, `W∘(·)/θ` stays *constant* on the same 20-dimensional edge family (so constancy is the symmetry) while the value moves freely and crosses the bound:

| `(diag, adj, nonadj)` | criticality residual | edge average |
|---|---|---|
| `(4, -2, 1)` | `1.3e-16` | `0.666666667` |
| `(4, -1.5, 0.5)` | `1.0e-1` | `0.469357847` |
| `(4, -2.5, 1.5)` | `1.1e-1` | `0.812954102` |
| `(4, -3, 2)` | `1.9e-1` | `0.865237306` |

**And the class it covers is narrow.** "Block graph" is undefined at `CP^m` and at every non-diagonal point. At the `n = 8` witness, forcing the definition through (eight singleton blocks) gives an edge average of `0.359180`, below `1/2` at a `Δ > 0` violator, so extending the definition breaks the criterion rather than saving it. Separately, `Δ = 0` violators of Lemma L24 also sit below: the `n = 12` four-block point at `θ = 0.690849` has `Δ = 0`, `λ_max = 1.238095` and an edge average of `0.090476`.

So the direction "edge average `> 1/2` ⟹ not a maximizer" survives, it is a Rayleigh-quotient certificate and those are always sound. The converse, which is the whole content of "separates", does not.

---

#### The counterexample hunt, and a correction to the brief's framing

**The brief overstates what a `Sym_0` failure would do.** V3 is `Δ > 0 ⟹ λ_max(L_e|e⊥) > 1/2`. A `Δ > 0` point whose `Sym_0` maximum is at or below `1/2` would refute only the *`Sym_0` certificate*, since `Sym_0` is a proper subspace, the record itself notes `0.588721` against `0.608885` at the witness. Refuting V3 needs the full-space maximum at or below `1/2`. I searched for both.

**What was searched.** Diagonal-in-`ω` operators that are Ricci-free lie in `Weyl_n` automatically (Bianchi holds because `R_{ijkl} = 0` whenever `i,j,k,l` are distinct) and `Q` preserves the family, so criticality there is a closed polynomial system on `R^{n(n-3)/2}`, which is how the `C_5` blow-up was found in the first place. 2000 random starts at `n = 6,7,8,9,10` gave **191 distinct critical classes, 169 of them with `Δ > 0`**.

A second, non-diagonal sweep ran on the *full* `Weyl_6` through the precomputed trilinear tensor `T_ijk = <b_i ∘ b_j, b_k>` (gated: `T` totally symmetric to `3e-16`, reproducing `Q` to `7e-16`, and its analytic Jacobian matching a central difference to `1e-10`). 87 of 90 random starts converged to residual `< 4e-16`, giving **49 distinct `θ` classes, every one with `Δ > 0`**. Its reach is limited in one direction worth stating: random starts in the full space land at low `θ` (the largest found is `0.444937` against `θ_0(6) = 1.054093`), so it samples the far side of the landscape rather than the neighbourhood of the maximizer.

**Result: zero counterexamples of either kind, in either sweep.** Every `Δ > 0` class has `λ_max(L_e|e⊥) > 1/2`, and every one also has `λ_max(L_e|Sym_0) > 1/2`. The sweep independently rediscovered the record's `n = 8` live-target point (`θ = 0.555683`, `Δ = 11.0449`, `λ_max = 1.380653`) from code that never read it. So V3 is unrefuted and its `Sym_0` certificate held everywhere I could reach, including at the three `n = 12` points that break H5, where `Sym_0` still certifies while the edge average does not.

---

#### What the record should say instead

- **[bounds.md](../findings/bounds.md), the branching paragraph.** Replace "`L_e` acts as a scalar on each isotypic component" with "`L_e|_V` is block-diagonal over the isotypic decomposition, with a block of size `m_λ` on each; the blocks are scalars exactly where the decomposition is multiplicity-free". Then delete "which is why the `C_5`-edge family came out an exact eigenspace", it is not an eigenspace, and the constancy of its Rayleigh quotient comes from the point's full symmetry, discrete part included, not from `k(W)`.
- **The same paragraph's conclusion.** "V3 becomes a branching computation over the possible isotropy algebras" does not follow and should go. At the large-`Δ` points on file `k(W)` is `0`, so the branching data is a single trivial isotype of multiplicity 35 and constrains nothing; at the two `Δ > 0` points the record does quote, `k(W)` is 5-dimensional and the certifying value sits in a piece that also carries a sub-`1/2` value.
- **The closed form.** Both formulas can be upgraded from "exact at three points" to *derived*, with the derivations above; and the `R^p ⊗ R^q` half should be labelled as the orbit tangent, since as stated it reads like a fact about sphere products.
- **H3's sentence.** "`H_A = 0` on all of `R^k ⊗ R^k`" is false and should read "`Π_Weyl H_A = 0`, because `H_A` is exactly the pure-Ricci direction there"; the trace-split clause needs separating, since that one dies to the `e⊥` projection instead.
- **The `3 -> 13` table.** `13` is the number of distinct `L_e` values; the number of isotypic pieces is `11`.
- **H5.** Record the three `n = 12` counterexamples so the statistic is not retried as a criterion. What is worth keeping is the certificate direction and the `C_5` datum itself.

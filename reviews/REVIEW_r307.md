### Reviewer 307: the graded split of criticality, and the two-point mass conjecture

**Verdicts.**

| | claim | verdict |
|---|---|---|
| **L1** | the grading's bracket relations sort `W#` by block, hence `θ‖A‖² = tr A³ + ⟨A, W#|p⟩` and `θ‖B‖² = tr B³ + ⟨B, W#|m⟩` | **CONFIRMED as arithmetic, over-credited as a mechanism**, the sorting is exact and provable in three lines, but the two displayed equations follow from `W`-invariance of the splitting alone and contain exactly **one** scalar beyond the definition of `θ` |
| **L2** | the `m`-equation is the one to attack: its coupling is "the only place the non-equivariant structure of `A` can be made to pay" | **REFUTED**, the two couplings are the *same* scalar `C = tri(A,B,B)`, appearing as `C` in the `p`-equation and `2C` in the `m`-equation, and `C` is **linear** in `A`. The `m`-equation is the place where `A`'s non-equivariance pays *least* |
| **L3** | `‖A‖²` is pinned by `(p,q)` alone, so Lemma L8 extends off the equivariant locus | **REFUTED**, **8** graded critical points on `(so(8), so(3)+so(5))` spread `‖A‖²` over `[0.6190476, 0.6402034]`, and **9** on `(so(8), so(4)+so(4))` over `[0.5714286, 0.6230080]`, `3.4%` and `8.5%`, against the `0.95%` the conjecture was read off |

**No refutation of the target.** Across **18** distinct graded critical points at `n = 8` the largest `θ` is `1.1456439` (`S⁴×S⁴`), and the largest at a **non-equivariant** one is `1.0987530`. Nothing approaches `√(3/2) = 1.2247449`.

---

#### What was built

Everything is re-derived from the definitions in [core307.py](../scripts/reviewers/r307/core307.py): `Λ²ℝⁿ ≅ so(n)` with `⟨X,Y⟩ = ½ tr(XᵀY)`, structure constants `c[a,b,g] = ⟨[φ_a,φ_b],φ_g⟩`, and **the sharp as the structure-constant contraction** `(R#S)_{ab} = ½ c_{agd} c_{bez} R_{ge} S_{dz}`, deliberately a different expression from the trace form `-½ tr(A_a W A_b W)` this repo uses elsewhere. Gates passed before anything was claimed: the literature's diagonal formula `(R#S)_{ij} = ½ Σ_k (r_{ik}s_{jk} + r_{jk}s_{ik})` to `4e-16`; `tr(W#) = -‖W‖²` to `1e-14`; `W#I = -W` to `1e-15`; total symmetry of `tri` to `1e-14`; `dim Weyl_n = 84, 168, 300` at `n = 6, 7, 8`; and the sphere product returned critical at residual `1e-15`.

**The record's `‖A‖² = 0.624926` is the *spectral* split, and that is the right object.** `A` is `W` restricted to its own strictly positive eigenspace, not to the coordinate `so(3)+so(5)` block. The witness is block-diagonal for the coordinate `(3,5)` split too, but that block is **not** its positive eigenspace, its coordinate `A`-block has eigenvalues from `-0.302413` to `+0.316806` and gives `‖A‖² = 0.332496`. Reading the coordinate block as `A` compares two different quantities; the definition of gradedness quoted in the brief ("`p`, `m` its strictly positive and strictly negative eigenspaces") settles which one is meant.

---

#### L1, the sorting is real, the "hence" is not

**The sorting, proved rather than measured.** With `A` supported on `p` and `B` on `m`, in `(R#S)_{αβ} = ½ c_{αγδ} c_{βεζ} R_{γε} S_{δζ}` the index `γ,ε` run over `A`'s support and `δ,ζ` over `S`'s. Then `c_{αγδ} ≠ 0` with `γ,δ ∈ p` forces `α ∈ p`; with `γ ∈ p, δ ∈ m` forces `α ∈ m`; with `γ,δ ∈ m` forces `α ∈ p`. So `A#A` and `B#B` land in `p` and `A#B` lands in `m`, and this is exactly the three bracket relations, nothing more. Measured at all 18 census points: the off-support mass of each of the three is `≤ 3e-16`.

**But the two displayed equations do not need it.** `⟨A, Q(W)⟩ = θ⟨A,W⟩ = θ‖A‖²` and `⟨A, W²⟩ = ⟨A, A²+B²⟩ = tr A³` require only that the splitting be `W`-invariant, so that `W² = A² ⊕ B²`. Tested directly ([l1_split.py](../scripts/reviewers/r307/l1_split.py)): grouping `S³×S⁵`'s eigenspaces into three *arbitrary* `W`-invariant splittings that are **not** gradings, both equations still hold to `8e-16` while the sharp sorting leaks `0.11`–`0.43`. The grading buys the sorting; the sorting is descriptive of `W#|p`, and the separation happens without it.

**And the pair is one equation, not two.** They sum to `θ‖W‖² = tr W³ + ⟨W, W#⟩`, the definition of `θ`. Either one implies the other.

**`⟨A, W#|p⟩` does receive from `m×m`, and it is the larger half.** At `S³×S⁵`, `⟨A, B#B⟩ = 0.242840` against `⟨A, A#A⟩ = 0.240943`; at the witness, `0.244022` against `0.174815`. The brief's question is answered in the affirmative, and at the witness the `m×m` contribution is `58%` of the sharp term on `p`.

**The closed form the brief asked for, proved symbolically** ([closed_form.py](../scripts/reviewers/r307/closed_form.py)). For a diagonal curvature operator `W_ij = K_ij - (r_i+r_j)/(n-2) + scal/((n-1)(n-2))`, the Weyl operator of `S^a×S^b` has `W_aa = 1 - 2(a-1)/(n-2) + s`, `W_bb = 1 - 2(b-1)/(n-2) + s`, `W_ab = s - 1` with `s = scal/((n-1)(n-2))`, and `sympy` gives, identically in `a` and `b`,

$$\|A\|^2=\frac{\dim\mathfrak p}{\binom{n-1}{2}},\qquad \|B\|^2=\frac{\dim\mathfrak m-n+1}{\binom{n-1}{2}}.$$

At `S³×S⁵` that is `13/21 = 0.619047619…`, the record's `0.619048` exactly. Confirmed against the solver at `12/21`, `16/21` (`n = 8`), `3/5`, `7/10` (`n = 6`).

**On the coordinator's `N`-term question, settled.** `Q` maps `Weyl_n` into `Weyl_n`, verified constraint by constraint on random Weyl tensors at `n = 6, 7, 8`: Bianchi defect `4e-17`, Ricci defect `1e-16`, non-Weyl mass `8e-16` ([n_term.py](../scripts/reviewers/r307/n_term.py)). So the projected criticality equation forces `N := Q(W) - θW` to lie in `Weyl_n` *and* be orthogonal to it, hence `N = 0`; the full unprojected `‖Q(W) - θW‖_F` is `3e-15` at both test points. `A` is `62%` non-Weyl and it does not matter. **L1 needs no extra hypothesis.**

---

#### L2, the route claim is backwards

Write `C := tri(A,B,B) = ⟨A, B#B⟩`. The sorting kills two of the four cubics outright, `tri(A,A,B) = ⟨A#B, A⟩ = 0` because `A#B` lives in `m`, and `tri(B,B,B) = ⟨B#B, B⟩ = 0` because `B#B` lives in `p`, both measured at `1e-17`. So the whole content of L1 is

$$\theta\|A\|^2=\mathop{\mathrm{tr}}A^3+\mathrm{tri}(A,A,A)+C,\qquad \theta\|B\|^2=\mathop{\mathrm{tr}}B^3+2C .$$

Three consequences, all measured in [l2_route.py](../scripts/reviewers/r307/l2_route.py):

- **The two coupling terms are the same scalar.** `⟨B, 2(A#B)|m⟩ = 2⟨A, (B#B)|p⟩` by total symmetry of `tri`, `0.485680 = 2 × 0.242840` at `S³×S⁵`, `0.488044 = 2 × 0.244022` at the witness. There is no separate `m`-coupling to attack.
- **`C` is linear in `A`, so the `m`-equation probes `A` through one direction.** Every deformation of `A` orthogonal to the fixed matrix `B#B` is invisible to it. At the witness `‖A‖ = 0.790523`, of which `0.763281` is seen and `0.205736` is not; at `S³×S⁵`, `0.254824` is not.
- **The `p`-equation is the `A`-sensitive one.** It carries `tr A³ + tri(A,A,A)`, cubic in `A`. Those are what actually move off the equivariant locus: `tr A³` goes `0.206794 → 0.261675` and `tri(A,A,A)` goes `0.240943 → 0.174815` between `S³×S⁵` and the witness, while `C` moves only `0.242840 → 0.244022`, i.e. `0.5%`.

So `C` is the *least* non-equivariance-sensitive object in either equation, and it is shared. **What a successor should actually do**: treat the `m`-equation as the *elimination*, not the attack, it gives `C = ½(θ‖B‖² - tr B³)` in terms of `B` alone, and substituting into the `p`-equation leaves `θ(‖A‖² + ½‖B‖²) = tr A³ + tri(A,A,A) + ½ tr B³`, one equation with the coupling gone. That is the honest reduction, and it is a statement about `A`'s cubics (the `p`-side), not about the `m`-side.

---

#### L3, refuted, with the spread measured

**Method.** [scipy.optimize.least_squares](https://docs.scipy.org/doc/scipy/reference/generated/scipy.optimize.least_squares.html) is unusable in this environment: [scipy.linalg.svd](https://docs.scipy.org/doc/scipy/reference/generated/scipy.linalg.svd.html) of a `156×155` matrix costs **7.9 s** here against `14 ms` for [numpy.linalg.svd](https://numpy.org/doc/stable/reference/generated/numpy.linalg.svd.html), and `trf` calls it once per Jacobian, `170 s` per solve. Two changes made the census possible: the totally symmetric cubic tensor `TQ_{aij} = ⟨B_a, B_i ∘ B_j⟩` precomputed once per subspace ([cubic307.py](../scripts/reviewers/r307/cubic307.py), `0.8 s`, validated against direct evaluation of `P` and `∇P` to `4e-14`), and a damped Gauss–Newton on `numpy.lstsq` ([gn307.py](../scripts/reviewers/r307/gn307.py)). Result: **`0.4 s` per solve, a `400×` speed-up**, which is why the record has two graded points and this review has eighteen. [run_f4b_newton.py](../scripts/runs/run_f4b_newton.py) inherits the same `scipy` pathology.

**Where graded points live.** Random starts in the block-diagonal Weyl space are useless, `600` starts gave `300` critical points and **zero** graded, all at `θ ≤ 0.23`. Sign-biased starts (`A ≻ 0` on the `p`-block, `B ≺ 0` on the `m`-block) gave `200` critical points and zero graded. What works is **small kicks** (`0.02`–`0.12`) off known graded points with pool re-seeding ([graded_hunt3.py](../scripts/reviewers/r307/graded_hunt3.py)). Two independent subspaces (the `(3,5)` and the `(4,4)` coordinate block-diagonal Weyl spaces, `dim 155` and `156`), were swept separately and returned **the same list**, which is the cross-check that the census is of `Weyl_8` and not of a subspace. The record's own witness at `θ = 1.0889481` was rediscovered from scratch.

**Certification.** Every point in the table has full unprojected criticality residual `≤ 1e-14`, non-Weyl mass `≤ 1e-15`, trivial kernel, and all three grading relations on its own eigenspaces to `≤ 8e-15`. `Δ` is the symmetry defect `Σ_{δ∈p} ‖[ad v_δ, W]‖²`, so `Δ = 0` is equivariance.

**And every pair is a genuine `so(k)+so(8−k)`, not a triality twist** ([pair_type.py](../scripts/reviewers/r307/pair_type.py)): `m = ℝ^k ⊗ ℝ^{8-k}` contains decomposable bivectors, and minimising `‖X ∧ X‖²` over unit `X ∈ m` returns `≤ 5e-24` at all 18 points, against `2e-5` for a random `15`-dimensional subspace.

| `θ` | `dim p` | `#pos` | `‖A‖²` | `Δ` | equivariant |
|---|---|---|---|---|---|
| `1.1456439` | `12` | `1` | `0.5714286` | `0.0000` | **yes**, `S⁴×S⁴` |
| `1.1155467` | `13` | `2` | `0.6190476` | `0.0000` | **yes**, `S³×S⁵` |
| `1.0987530` | `12` | `3` | `0.5964225` | `1.9794` | no |
| `1.0889481` | `13` | `5` | `0.6249259` | `1.5122` | no, the record's witness |
| `1.0836886` | `12` | `2` | `0.6049352` | `3.0252` | no |
| `1.0836152` | `12` | `4` | `0.6049916` | `3.0184` | no |
| `1.0819970` | `12` | `3` | `0.6130952` | `3.5000` | no |
| `1.0817942` | `13` | `4` | `0.6231756` | `2.7740` | no |
| `1.0816998` | `13` | `4` | `0.6220042` | `2.4206` | no |
| `1.0815492` | `13` | `7` | `0.6223497` | `2.4009` | no |
| `1.0806446` | `12` | `3` | `0.6117103` | `3.4826` | no |
| `1.0802943` | `13` | `5` | `0.6230010` | `2.7641` | no |
| `1.0800922` | `12` | `6` | `0.6126161` | `3.4941` | no |
| `1.0797589` | `13` | `8` | `0.6240105` | `2.7628` | no |
| `1.0678254` | `12` | `4` | `0.6208897` | `3.3396` | no |
| `1.0667817` | `12` | `5` | `0.6230080` | `3.6123` | no |
| `1.0652289` | `13` | `6` | `0.6402034` | `2.7231` | no |
| `0.9860133` | `16` | `2` | `0.7619048` | `0.0000` | **yes**, `S²×S⁶` |

**The verdict, on one pair at a time.**

| pair | points | `‖A‖²` range | spread | equivariant value `dim p/21` |
|---|---|---|---|---|
| `so(3)+so(5)` | `8` (`7` non-equivariant) | `[0.6190476, 0.6402034]` | `3.39%` | `13/21 = 0.6190476` |
| `so(4)+so(4)` | `9` (`8` non-equivariant) | `[0.5714286, 0.6230080]` | `8.50%` | `12/21 = 0.5714286` |

`‖A‖²` is not a function of `(p,q)`. The equivariant value is the **minimum** of its pair's range in both cases, not its centre, so the closed form does not even bound the non-equivariant points from the useful side. Note too that L3 was already refuted by the two data points it was read from: `0.619048` and `0.624926` are each accurate to `1e-15` and differ by `0.0059`, thirteen orders of magnitude above their own precision. "Agreeing to `1%`" was never agreement.

**Two smaller corrections that fall out.**

- `#pos ≤ 2` is not a test for equivariance even at `dim p = 13`: it is a valid *consequence* of Schur, not a criterion. The `θ = 1.0836886` point has `dim p = 12`, `#pos = 2` and `Δ = 3.0252`. (The brief's own `p, q ≠ 4` caveat is why `so(4)+so(4)` is exempt from the count; the point stands as a warning against reading the column as a defect.)
- Fifteen new non-equivariant graded critical points at `n = 8` are recorded here that the enumeration did not have. Saved as [census_n8.npy](../scripts/reviewers/r307/census_n8.npy), `18 × 28 × 28`, ordered as the table.

---

#### What was looked for and not found

A graded non-equivariant critical point with `θ > √(3/2)`. The census maximum is `1.1456439` at the equivariant `S⁴×S⁴`, and `1.0987530` over the fifteen non-equivariant ones, every one of them below `√(3/2)` by at least `0.126`. Two independent sweeps of two different block-diagonal subspaces at `n = 8`, plus `n = 6` (which returns only the two equivariant sphere products), found nothing that threatens the target.

Scripts: [scripts/reviewers/r307/](../scripts/reviewers/r307/). Log: [agent_logs/r307-graded-split.log](../agent_logs/r307-graded-split.log).

# Reviewer 63, adversarial audit of C1–C6 (two-negative stratum, `G(λ)`, and the four refuted attempts)

All numbers below come from code I wrote from the brief's definitions alone, in [scripts/review_r63_core.py](../scripts/review_r63_core.py), [scripts/review_r63_c1c2.py](../scripts/reviewers/r63/review_r63_c1c2.py), [scripts/review_r63_c3.py](../scripts/reviewers/r63/review_r63_c3.py), [scripts/review_r63_G.py](../scripts/review_r63_G.py), [scripts/review_r63_c5_attack.py](../scripts/reviewers/r63/review_r63_c5_attack.py), [scripts/review_r63_relax.py](../scripts/reviewers/r63/review_r63_relax.py), [scripts/review_r63_c5_families.py](../scripts/reviewers/r63/review_r63_c5_families.py) and [scripts/review_r63_c6.py](../scripts/reviewers/r63/review_r63_c6.py). No `scripts/b0_*.py` file was read, imported or run.

**Headline.** C5 is true, and I have a proof of it that reduces to one explicit one-variable inequality in elementary functions, verified but not yet argued symbolically. Chained with C1 and C4 (`θ ≤ LP(λ) ≤ G(λ)`), that gives `θ ≤ √(3/2)` for **every** Weyl operator with exactly two negative eigenvalues, at every `m`, with no descent and no dependence on the number of positive eigenvalues. Two secondary claims are wrong: C2's derived inequality is Cauchy–Schwarz rather than new content, and C5's "`max G` decreases in `k`, equality only at `k = 1`" is a random-sampling artefact, the supremum is `√(3/2)` at every `k`.

## Verdicts

| Claim | Verdict | One-line reason |
|---|---|---|
| C1 eigenframe form | **CONFIRMED** | exact to `1.3e-15` at `m = 4,5,6,7`; holds for *any* symmetric operator, no Weyl hypothesis needed |
| C2 exact weighted row sum | **CONFIRMED as an identity; its derived inequality is REFUTED as new content** | the identity is exact to `5e-15`; but `(b+c)²+b²+c² ≥ 1` is Cauchy–Schwarz, and C3 never uses C2 |
| C3 `θ ≤ 9bc(b+c)` | **CONFIRMED** | every step valid and verified; the *tightness argument* is empty, the base-case family is entirely `k = 1` |
| C4 dimension-free reduction | **CONFIRMED, and stronger than stated** | `G` decouples exactly into a positive-block packing plus `6λ₁bc` |
| C5 `G ≤ √(3/2)` | **inequality CONFIRMED (proof below); the stated equality condition and the `k`-monotonicity are REFUTED** | `sup G = √(3/2)` at *every* `k`, not only `k = 1`; the reported table is a sampling artefact |
| C6 (a)(b)(c)(d) | **all four CONFIRMED as refuted**, duals **verified feasible** | reproduced `1.568775` exactly; both duals feasible to `-1.1e-16`; 158/979 merges decrease `G` |

---

## C1, eigenframe form. CONFIRMED.

I rebuilt `so(m)` with `φ_ij = E_ij − E_ji`, the structure constants `c_{ABC} = ⟨[φ_A,φ_B],φ_C⟩`, Hamilton's sharp as `(R^#)_{AB} = ½ c_{ACE} c_{BDF} R_{CD} R_{EF}`, and `Weyl_m` as the nullspace of (first Bianchi) ⊕ (Ricci), getting `dim Weyl_m = 10, 35, 84` at `m = 4,5,6`, the correct `(m+2)(m+1)m(m−3)/12`.

On random unit elements of `Weyl_m`:

| `m` | 4 | 5 | 6 | 7 |
|---|---|---|---|---|
| `max │θ − (Σλ³ + 3Σ_{a<b<g} T λλλ)│` | `4.7e-16` | `1.3e-15` | `3.7e-16` | `3.7e-16` |

and every structural property asserted for `T` held: total symmetry (`1e-10`), `T ≥ 0`, `T_{aab} = 0` exactly, `R` row sums `= 2(m−2)`, pair cap `max R_{ab} ≤ 2`, and `Rλ = −2λ` to `1e-8`.

**Gap worth recording (not an error):** C1 needs no Weyl hypothesis at all. With the tensorial `#` above, `R^# = ½ Σ_{a,b} λ_a λ_b [v_a,v_b] ⊗ [v_a,v_b]` for *any* symmetric `W`, so `⟨W,W^#⟩ = ½ Σ_{abg} T λλλ` is a two-line consequence of ad-invariance. Ricci-flatness and Bianchi enter only through the *constraints* on `T` (row sums, `Rλ = −2λ`), never through the form itself.

## C2, exact weighted row sum. Identity CONFIRMED; the inequality it "gives" is not new.

The three stated equalities hold exactly. On random `Weyl_4` operators restricted to exactly two negative eigenvalues (104 hits):

| quantity | max error |
|---|---|
| `Σ_P λ_a R_{a,N−1} = 2c + bR` | `3.1e-15` |
| `Σ_P λ_a R_{aN} = 2b + cR` | `4.7e-15` |
| `Σ_{a,b∈P} R_{ab} λ_a λ_b = 2b² + 2c² + 2bcR − 2u` | `2.2e-15` |

**Correction 1, the index convention is load-bearing and unstated.** The two row equations hold only with `λ_N = −b` (most negative) and `λ_{N−1} = −c`. Under the opposite labelling the two right-hand sides swap. The brief's "`−b ≤ −c < 0`" plus descending sort does give this, but it should be said.

**Correction 2, the derived inequality has no Weyl content.** `2b² + 2c² + 2bcR − 2u ≥ 0` together with `R ≤ 2` gives `u ≤ (b+c)² = s²`, i.e. `(b+c)² + b² + c² ≥ 1`. But `u ≤ s²` is just `Σ_P λ² ≤ (Σ_P λ)²` for nonnegative numbers, combined with trace-freeness `Σ_P λ = b + c`. It holds for every trace-free unit spectrum with two negatives, Weyl or not. Correspondingly, its being an "identity on the whole base-case family at every `q,r`" is not evidence of sharpness: I verified that `W4(q,r)` has spectrum `(q+r, −q, −r)` padded by three zeros, so it has **exactly one positive eigenvalue** at every `q,r`, and `u = s²` is simply the equality case of Cauchy–Schwarz for a single number. The family cannot distinguish this inequality from any other.

**Correction 3, C3 does not use C2.** The step the chain attributes to C2 is `3S₁ ≤ λ₁(s²−u)`. Both routes give exactly the same constant: via C2 one gets `(λ₁/2)(2b²+2c²+2bcR−2u) ≤ (λ₁/2)(2s²−2u)` after `R ≤ 2`; directly, `3S₁ = ½Σ_{a,b,g∈P}Tλλλ ≤ (λ₁/2)Σ_{a≠b∈P}λ_aλ_b·2 = λ₁(s²−u)` from the pair cap alone. So the exact identity is decorative in the chain, everything it contributes is thrown away by `R ≤ 2`. (It *would* be sharper if `R < 2` were exploited, which the chain does not do.)

## C3, `θ ≤ 9bc(b+c)` at any `k`. CONFIRMED, with the tightness argument voided.

Every step checks out, and I re-derived the whole chain independently:

`θ = Σλ³ + 3S`, `(−−−)` empty, `(++−) ≤ 0` termwise, `(+−−) = 3bc Σ_P T_{a,N−1,N} λ_a ≤ 6bc λ₁` (pair cap `R_{N−1,N} ≤ 2`), `Σ_P λ³ ≤ λ₁u`, `3S₁ ≤ λ₁(s²−u)`, then `θ ≤ λ₁(s²+6bc) − b³ − c³ ≤ s(s²+6bc) − b³ − c³ = 9bcs` using `s³ − b³ − c³ = 3bcs`.

On the base-case family every slack is `≲ 2e-16` (all six steps simultaneously). On 90 random two-negative `Weyl_4` operators the chain holds with minimum slack `1.37`, and `9bcs` reaches `3.27`, confirming the brief's own caveat that it does not close B0 without an `s` cap.

**The tightness claim is worthless as evidence, and this matters.** The base-case family is `k = 1` at every `q,r`. On it the `(+++)` block is *empty*, so `3S₁ ≤ λ₁(s²−u)` is `0 ≤ 0`; and `λ₁ = s` identically, so `λ₁ ≤ s` is `s ≤ s`. Those are precisely the two steps that are loose for `k ≥ 2`, the regime the extension is *for*. "Every step simultaneously tight on the base-case family" is a statement about `k = 1` only, and predicts nothing about `k ≥ 2`.

**A strictly better step exists.** `Σ_Pλ³ + 3S₁ ≤ su` follows from the dual `z_{ab} = ½λ_aλ_b(λ_a+λ_b)` (feasible by AM–GM). Since `u ≤ λ₁ s` always, `su ≤ λ₁ s²`, so this single bound dominates the chain's two steps. It is also the ingredient the failed repairs needed.

## C4, the dimension-free reduction. CONFIRMED, and the structure is stronger than claimed.

`θ ≤ LP(λ)` by construction (`T` from a real `W` is feasible: `T ≥ 0`, totally symmetric, `T_{aab}=0`, `Σ_{b<g}T_{abg} = m−2`, `Σ_g T_{abg} = R_{ab} ≤ 2`). `LP ≤ G` needs no hypothesis: dropping the row-marginal *equalities* enlarges the feasible set, and restricting `T` to the support loses no objective while its pair caps are implied. `G` contains no `m` and no `N`. Verified on eight `(m,k)` pairs: `LP ≤ G` in all, with equality in five.

**What the brief misses: `G` decouples exactly.** The `(+++)` triples consume only pair caps inside `P`; the `(+−−)` triples `{a, N−1, N}` consume only the caps `(a,N−1)`, `(a,N)`, `(N−1,N)`. The two constraint blocks are disjoint, and `(++−)`/`(−−−)` carry nonpositive objective. Hence, exactly,

```
G(λ) = Σ_P λ³ − b³ − c³ + 6 λ₁ b c + 3 M(λ_P),
M(λ_P) = max{ Σ_{a<b<g ∈ P} T λ_a λ_b λ_g : T ≥ 0, Σ_g T_{abg} ≤ 2 }
```

a **pair-capped weighted fractional triangle packing on the positives alone**, with the two negatives entering only through the scalar `6λ₁bc`. Verified to `3.3e-16` over 300 random spectra. In particular `M = 0` for `k ≤ 2`, which is what makes `k = 1` and `k = 2` solvable in closed form below.

## C5, `G ≤ √(3/2)`. THE INEQUALITY IS TRUE; the stated equality condition and `k`-monotonicity are wrong.

### (i) The reported `max G` table is a sampling artefact

SLSQP on the exact `G` (envelope gradients, 150 random starts per `k`, `k = 1…8`) returns **`√(3/2)` to within `2e-12` at every `k`**, with the argmax collapsing every time onto one positive eigenvalue at `(0.816497; −0.408248, −0.408248)`:

| `k` | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |
|---|---|---|---|---|---|---|---|---|
| my `max G` | `1.2247448714` | `1.2247448714` | `1.2247448714` | `1.2247448714` | `1.2247448714` | `1.2247448714` | `1.2247448714` | `1.2247448714` |
| reported | `1.224745` | `1.224584` | `1.223139` | `1.219470` | `1.210144` | `1.168175` | `1.124552` |, |

Reproducing the reported protocol (700 uniform random draws per `k`) recovers the reported profile, which pins the cause: random draws at larger `k` almost never land near the degenerate face, so the sampled maximum drifts down. **`max_k G` does not decrease in `k`**, the supremum is `√(3/2)` for every `k ≥ 1`, because padding a `k = 1` spectrum with zeros is a limit of `k`-positive spectra. FINDINGS' sentence *"the monotone decrease in `k` is the mechanism every failed attempt missed"* names a mechanism that does not exist.

**Proof at `k = 2` (closed form).** With `p = λ₁λ₂`, `q = bc`, trace-freeness and `‖λ‖=1` give `p + q = s² − ½`, and `M = 0`, so

```
G = 6q(s + λ₁) − 3s³ + (3/2)s,      λ₁ = (s + sqrt(2 − 3s² + 4q))/2 .
```

`G` is increasing in `q`, so `q = min(s²/4, s² − ½)`. For `s² ≥ 2/3` this is `q = s²/4` (`b = c`) and `G = −(3/4)s³ + (3/4)s²√(2−2s²) + (3/2)s`, whose derivative vanishes at `s² = 2/3` and which is a strict maximum there, value `√(3/2)`; at that point `p = 0`, i.e. `λ₂ = 0`. For `s² < 2/3` the binding `q` forces `p = 0` outright and `G = 9s³ − 4.5s`, increasing on `s ∈ [1/√2, √(2/3)]`. **So the `k = 2` supremum is exactly `√(3/2)` and is attained only in the `k → 1` degeneration.** The same argument at `k = 1` (`G = 9bcs`, `bc = (2s²−1)/2`, `s² ≤ 2/3` from `(b−c)² ≥ 0`) gives `√(3/2)` at `b = c = 1/√6`.

The correct statement of C5's equality clause is therefore: *the maximum over the closed two-negative stratum is `√(3/2)`, attained exactly at the padded `W_{CP²}` spectrum `(2,−1,−1)/√6`, i.e. only where exactly one eigenvalue is positive; for each fixed `k ≥ 2` the value is a supremum that is not attained.*

### (ii) A proof of the inequality, at any `k`

Five lemmas, each elementary; `A := λ₁`, `d := u − A²`, `σ := s − A`, `K₀ := 3/(2√2)`.

- **L1 (decoupling).** `G = Σ_Pλ³ − b³ − c³ + 6Abc + 3M(λ_P)`. Disjoint constraint blocks, as in C4.
- **L2 (LP duality).** `3M ≤ h·(s² − u)` with `h` the **harmonic mean of the three largest positives**. Dual `z_{ab} = μ λ_aλ_b`; the triple constraint `z_{ab}+z_{ag}+z_{bg} ≥ 3λ_aλ_bλ_g` reads `μ ≥ 3/(1/λ_a+1/λ_b+1/λ_g)`, maximised over triples at the top three; dual value `2Σ_{a<b}z = μ(s²−u)`. Tight for equal positives. Max violation over 1500 random positive spectra: `8.9e-16`.
- **L3.** `h ≤ min(A, K₀√d)`. `h ≤ max = A`; and dropping `1/λ₁` gives `h ≤ 3λ₂λ₃/(λ₂+λ₃)`, maximised subject to `λ₂²+λ₃² ≤ d` at `λ₂=λ₃=√(d/2)`, value `K₀√d`.
- **L4.** `Σ_Pλ³ ≤ A³ + min(A,√d)·d`, from `Σ_{a≥2}λ_a³ ≤ λ₂ Σ_{a≥2}λ_a²` and `λ₂ ≤ min(A,√d)`.
- **L5.** `d ≤ σ²` (Cauchy–Schwarz on the non-leading positives). `b,c` are fixed by `b+c=s`, `b²+c²=1−u`, so `bc = (s²−1+u)/2 ≥ 0` and `(b−c)² = 2−s²−2u ≥ 0`.

Together: `G ≤ R(A,s,u) := A³ + min(A,√d)d + min(A,K₀√d)(s²−u) − b³ − c³ + 6A·bc`.

**Monotonicity kills two variables.** Writing `−b³−c³+6Abc = −s³ + 3bc(s+2A)`:
`∂R/∂u ≥ 0 + (−A) + (3/2)(s+2A) = (3/2)s + 2A > 0` and `∂R/∂s = 2s·min(A,K₀√d) + 6sA + 3bc > 0`. So both sit at their upper bound, which is the single constraint `s² ≤ 2 − 2u`, i.e. **`b = c`**. Substituting `s = √(2−2u)`:

```
R2(A,u) = A³ + min(A,√d)d + min(A,K₀√d)(2−3u) − (2−2u)^{3/2}/4 + 3A(1−u),   d = u − A².
```

**Three branch regions, all closed except one 1-variable inequality.**

| region | bound | max |
|---|---|---|
| `d > A²` | `R2 = 5A(1−u) − (2−2u)^{3/2}/4`, `A ≤ √(u/2)` | **`1.017217`** |
| `8A²/9 < d ≤ A²` | `R2 ≤ 2A³ + A(5−6u) − (2−2u)^{3/2}/4`, `A ≤ 3√(u/17)` | **`1.067666`** |
| `0 < d ≤ 8A²/9` (`= K₀√d ≤ A`) | envelope below | **`√(3/2)`, only at `d = 0`** |

For the last region put `t = √d`. Using `(X−2t²)^{3/2} ≥ X^{3/2} − 3t²√X`,

```
R2 ≤ g(A) + ψ(t),   g(A) = A³ − (1−A²)^{3/2}/√2 + 3A(1−A²),
ψ(t) = α t + β t² + γ t³,   α = K₀(2−3A²),  β = (3/4)√(2−2A²) − 3A,  γ = 1 − 3K₀ < 0,
0 ≤ t ≤ (2√2/3) A .
```

`g` is exactly `R2` on `d = 0`, i.e. the `k = 1` slice; `g'(A) = 3 − 6A² + (3A/√2)√(1−A²)` vanishes at `A = √(2/3)` and `max g = g(√(2/3)) = √(3/2)` (checked on 4·10⁶ points, `g(√(2/3)) = 1.224744871391589`).

- For `A > √(2/3)`: `α ≤ 0`, `β < 0`, `γ < 0`, so `ψ(t) ≤ 0` for `t ≥ 0` and `R2 ≤ g(A) ≤ √(3/2)`. **Closed analytically.**
- For `A ≤ √(2/3)`: the residue is the explicit one-variable inequality `g(A) + max_{0≤t≤(2√2/3)A} ψ(t) ≤ √(3/2)`. Evaluated on `6·10⁴ × 4·10⁴` points, its maximum is `1.224744871392` attained **exactly at `A = √(2/3)`, `t = 0`**, excess `0.0e+00`. The inner max of a cubic with negative leading coefficient is elementary, so this is a finite calculus exercise, not a search.

**End-to-end check of my own chain.** Over 6000 random two-negative spectra with `k = 1…8`, `R(A,s,u) − G(λ) ≥ −1.6e-15` (i.e. `≥ 0` up to rounding; it is an equality on the `k = 1` face) and `R2(A,u) − G(λ) ≥ +6.6e-8`. So the five lemmas compose correctly.

**Independent global checks of the same relaxation.** 40 runs of `differential_evolution` on `R(A,s,u)` return `1.224744871392` (excess `+4.0e-15`) at `A = s = √(2/3)`, `u = 2/3`, `d = 0`, `disc = 0`; 60 runs on `R2(A,u)` return the same to `4.4e-16`; a `4.5·10⁶`-point grid agrees. Constrained to `d ≥ δ`, `sup R2 = √(3/2) − 0.613δ + O(δ²)` over `δ ∈ [10⁻⁶,10⁻¹]`, a clean transversal approach to the corner, no second local maximum anywhere.

### (iii) What I threw at C5 and failed to break

- SLSQP with envelope gradients, `k = 1…8`, 150 random starts each with power-law shape randomisation, max `√(3/2) + 1.2e-12` (optimiser tolerance), argmax always `k = 1`.
- One-dominant-plus-dust at `k = 2,3,5,10,16,24` with `ε` down to `10⁻⁶`, `b,c` swept: max `1.224744871390`, **excess `−1.6e-12`**, approaches the target from below and never crosses. (The dust limit is a genuine second extremal family: `Σλ³ → u^{3/2}`, `3M → 0`, `G → u^{3/2} − b³ − c³ + 6√u bc`, whose maximum over `b,c` is again `√(3/2)` at `b = c = 1/√6`, where the dust vanishes.)
- All-positives-equal `k = 1…14` (max `0.767`), geometric decay `q ∈ [0.1,0.99]`, `k = 3,6,11` (max `1.2120`), two-scale `j`-big/`(k−j)`-small (max `0.776`).
- `b/c` pinned and swept over nine positive-block shapes at `k = 1,2,3,5,6`: `c/b = 1` gives exactly `√(3/2)` at `k = 1`; `c/b = 0.5, 0.2, 0.1, 0.01, 10⁻⁴` give `1.030865, 0.553065, 0.299299, 0.031657, 0.000318`. `b ≫ c` is monotonically worse, so the true `G` shares the relaxation's `b = c` reduction.
- Everything stayed at or below `√(3/2)`; nothing exceeded it by more than optimiser noise.

**Residual gap in my own proof:** the one-variable inequality in region I is verified on a fine grid rather than by a symbolic argument. Because equality is attained at the endpoint, no Lipschitz certificate can substitute; a short monotonicity argument for `A ↦ g(A) + ψ*(A)` on `(0,√(2/3)]` would finish it. Regions II and III carry margins of `0.157` and `0.207`, which *are* Lipschitz-certifiable.

## C6, the four refuted attempts. All four confirmed refuted; the duals are feasible.

**(a) `λ₁ ≤ √u`. CONFIRMED, exactly.** `max √u(s²+6bc) − b³ − c³ = 1.568775` at `b = c = 0.546492`, the reported `1.5688` at `0.5465`. Imposing both caps `λ₁ ≤ min(s,√u)` changes nothing (`√u` binds there), also as reported. I add: the *better* version of the same repair, replacing the chain's two steps by `Σλ³+3S₁ ≤ su` and keeping `λ₁ ≤ √u`, gives `1.312763` at `b = c = 0.488750`, still `7 %` over target, so that route fails too.

**(b),(c) dual feasibility, INDEPENDENTLY VERIFIED, so the refutations stand.** Over 8000 random two-negative spectra with `k = 1…7`, checking *every* `C(k+2,3)` triple constraint of the dual `min 2Σ_p z_p s.t. z_{ab}+z_{ag}+z_{bg} ≥ 3λ_aλ_bλ_g`:

| attempt | infeasible draws | worst constraint slack | stated value vs my dual objective | exceedances of `√(3/2)` | max |
|---|---|---|---|---|---|
| (b) `z = (3/2)λ₁λ_aλ_b`, `z_{N−1,N} = 3λ₁bc` | `0 / 8000` | `−1.1e-16` | agree to `4.4e-16` | `1294 / 8000` | `1.635346` |
| (c) `z = λ₁λ_aλ_b` | `0 / 8000` | `−1.1e-16` | agree to `4.4e-16` | `631 / 8000` | `1.470443` |

I also assert-checked that the dual objective dominates `G` on every feasible draw. **Both duals are feasible; the refutations are meaningful.** My exceedance *rates* (16.2 %, 7.9 %) differ from the reported 9.9 % and 4.2 % purely through the sampling measure; the qualitative conclusion is identical.

Feasibility also has a one-line proof, which locates the waste precisely: with `z_{ab} = μλ_aλ_b`, the triple constraint is `μ ≥ 3/(1/λ_a+1/λ_b+1/λ_g)`, whose maximum over triples is the harmonic mean `h` of the three largest positives. `h ≤ λ₁` gives (c); (b) is feasible a fortiori with a factor `3/2` to spare. **Both are wasteful by up to `3λ₁/λ₃`, and the sharp choice `μ = h` is exactly lemma L2 above**, the ingredient that makes the C5 proof work. So the record's conclusion "a fifth attempt of that kind is not worth making" is *wrong in one respect*: an attempt of exactly that kind, with `μ = h` rather than a multiple of `λ₁`, is what closes it.

**(d) merge induction. CONFIRMED false as a step.** 158 of 979 single merges (16 %) strictly decreased `G`, worst drop `0.1571`. Reported: 26 of 120 (22 %). Same conclusion.

---

## Summary of corrections owed to FINDINGS.md

1. `(b+c)²+b²+c² ≥ 1` is Cauchy–Schwarz plus trace-freeness, **remove** the claim that the identity's nonnegativity supplies a new bound, and remove "identity on the whole base-case family" as evidence of sharpness (the family is `k = 1`, where Cauchy–Schwarz is an equality by definition).
2. C3's chain does not use C2. The step attributed to it follows from the pair cap alone, with the identical constant.
3. "Every step of the chain simultaneously tight on the base-case family" is true but vacuous: two of the six steps are `0 ≤ 0` and `s ≤ s` on that family.
4. The `max G` by `k` table is a random-sampling artefact. `sup G = √(3/2)` at **every** `k`. Delete "the monotone decrease in `k` is the mechanism every failed attempt missed"; the correct equality clause is *attained only where exactly one eigenvalue is positive*.
5. `G` decouples exactly into a positive-block triangle packing plus `6λ₁bc`; state it, since it is what makes `k ≤ 2` closed-form and drives the proof.
6. "A fifth attempt of that kind is not worth making", the harmonic-mean dual `μ = h` is exactly that kind of attempt and it works.


---

## Synthesis carried in REVIEW.md

### Reviewer 63: the same six claims, on an identical brief

Full report in [reviews/REVIEW_r63.md](reviews/REVIEW_r63.md). Agrees with Reviewer 62 on every verdict, by a different route, and all jobs killed.

**It proves $G\le\sqrt{3/2}$.** Five elementary lemmas, the exact $(+++)/(+--)$ decoupling; $3M\le h(s^2-u)$ with $h$ the harmonic mean of the three largest positives, by LP duality; $h\le\min(\lambda_1,\tfrac3{2\sqrt2}\sqrt d)$; $\sum\lambda^3\le\lambda_1^3+\min(\lambda_1,\sqrt d)d$; and $d\le(s-\lambda_1)^2$, give a three-parameter relaxation $R(A,s,u)\ge G$, strictly increasing in $s$ and $u$, so both sit at $s^2\le2-2u$, **forcing $b=c$** and leaving two variables. Three regions: $d>A^2$ caps at $1.017217$ and $8A^2/9<d\le A^2$ at $1.067666$, both in closed form; the third reduces to a one-variable envelope whose maximum is exactly $\sqrt{3/2}$ at $A=\sqrt{2/3}$, with all three cubic coefficients negative for $A>\sqrt{2/3}$. $k=1$ and $k=2$ close outright.

**The gap it names in its own proof**: the final one-variable inequality is verified on a $6\times10^4\times4\times10^4$ grid rather than symbolically, and equality at the endpoint means no Lipschitz certificate can substitute.

**And it overturns the standing advice** that "a fifth attempt of that kind is not worth making": the refuted duals are feasible ($0/8000$ violations, worst slack $-1.1\times10^{-16}$) but wasteful by up to $3\lambda_1/\lambda_3$, and the sharp choice $\mu=h$ **is** the lemma that closes the proof.

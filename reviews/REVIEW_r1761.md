# REVIEW r1761: L216Bern.lean, Bernstein on L216's great circle and step 5 along P

**Standfirst.** Cold Gate 2 reading of [L216Bern.lean](../lean/HamiltonsCubic/Results/L216Bern.lean) at commit 8fa7bb88 against [findings/second-order.md](../findings/second-order.md) Lemma L216, [L216IsolationRadius.lean](../lean/HamiltonsCubic/Results/L216IsolationRadius.lean) and the INDEX row. Statement fidelity only, the kernel having checked the proofs. Analysis-only footing: every check below is by hand, plus one small `#print axioms` file.

**Summary.** The Riesz formula, the Bernstein constant 27, the cubic-form coefficients and the two derivative values at 0 are all exactly the record's, and step 5 now holds along P itself. One hypothesis, `hM`, ranges over every unit `CurvOp2`, where L143 bounds P only on the unit Weyl sphere, so the file does not connect to the record's M = 1 + √(n−2) as typed.

## Claim table

| Claim | Verdict |
|---|---|
| `cub`, `Dq`, `hasDerivAt_cub`: σ ↦ F(cos σ, sin σ) differentiates to DF = F_x·(−y) + F_y·x | CONFIRMED |
| `ck`, `sk`, `lk`, `riesz`: M. Riesz's interpolation formula at degree 3 | CONFIRMED |
| `node_unit`, `sum_abs_lk`: unit nodes, Σ\|λ_k\| = 3 | CONFIRMED |
| `bern1`, `bern3`: \|DF\| ≤ 3 sup\|F\|, \|D³F\| ≤ 27 sup\|F\| on the unit circle | CONFIRMED |
| `no_critical_in_tube_cubic`: step 5 with `hbern` discharged for every binary cubic | CONFIRMED |
| `qP`, `P_plane`: P(xW + yH) has coefficients (P(W), 3T(W,W,H), 3T(W,H,H), P(H)) | CONFIRMED |
| `P_plane_bound`: orthonormal W, H and \|P\| ≤ M on the unit sphere bound the form by M on the circle | CONFIRMED |
| `hasDerivAt_P`: φ(σ) = P(cos σ W + sin σ H) has derivative (D qP)(cos σ, sin σ) | CONFIRMED |
| `no_critical_in_tube_P`: step 5 along φ from T(W,W,H) = 0 and 6T(W,H,H) − 3P(W) ≤ −6θγ | CONFIRMED (hypothesis `hM` stronger than L143, O1) |
| `no_critical_in_tube_crit` (5abd218f): h0 from `Tsym_crit`, h1 from the gap T(W,H,H) ≤ θ(½ − γ) | CONFIRMED (inherits O1) |
| INDEX row L216 as edited in 8fa7bb88 and 5abd218f | CONFIRMED WITH OBSERVATIONS (O1, O2) |

## The record

Statement (quoted): *"Let $W_0$ be a unit critical point of $P$ with $\theta_0=P(W_0)>0$ and $e=W_0/\theta_0$, and suppose that $\langle L_eH,H\rangle\le\tfrac12-\gamma$ for every unit $H\perp W_0$ orthogonal to the orbit tangent $T_{W_0}\mathcal O$, with $\gamma>0$. Then no critical point of $P$ on the unit sphere of $\mathcal W_n$ lies within geodesic distance $r=\frac{4\theta_0\gamma}{9(1+\sqrt{n-2})}$ of the orbit $\mathcal O=O(n)\cdot W_0$, other than the points of $\mathcal O$ itself."*

The brief's quoted phrase "|φ'''| ≤ 27M by Bernstein, M = 1 + √(n−2) being L143's global bound on |P|" is spread over the current text's steps 2, 4 and 5, which read (quoted in full):

- Step 2: *"Put $\phi(\sigma)=P(\cos\sigma\,W_1+\sin\sigma\,H)$. It is a homogeneous cubic in $(\cos\sigma,\sin\sigma)$, hence a trigonometric polynomial of degree at most $3$, and every point of the circle is a unit vector of $\mathcal W_n$, so [L143] gives $\lvert\phi\rvert\le M:=1+\sqrt{n-2}$ everywhere."*
- Step 4: *"For a trigonometric polynomial $T$ of degree $N$, $\lVert T'\rVert_\infty\le N\lVert T\rVert_\infty$ (Bernstein's inequality), and $T'$ is again of degree $N$, so iterating three times gives $\lVert\phi'''\rVert_\infty\le27M$."*
- Step 5: *"Taylor's theorem with the two bounds gives $\phi'(\sigma)\le-6\theta_0\gamma\,\sigma+\tfrac{27M}2\sigma^2$, which is negative for $0<\sigma<\frac{12\theta_0\gamma}{27M}=r$. If $W=\phi$'s point at $\sigma=s$ were critical, the Riemannian gradient of $P$ there would vanish, and $\phi'(s)$ is that gradient paired with the unit tangent of the circle, so $\phi'(s)=0$. That contradicts the negativity just shown whenever $0<s<r$."*

The Lean target is `no_critical_in_tube` with `hbern : ∀ u, 0 ≤ u → f2 u ≤ 27 * M`, and L143 is `L143_unconditional`, "$\lvert P\rvert\le1+\sqrt{n-2}$ on the unit Weyl sphere" (INDEX row L143).

## Q1. φ and the coefficient vector

- `hasDerivAt_P` differentiates `fun σ => Pcubic2 (cos σ • W + sin σ • H)`, which is the record's φ with W₁ written W. Exact.
- By hand: with T symmetric trilinear and T(R,R,R) = P(R) (`Tsym_diag`), P(xW + yH) = x³T(W,W,W) + 3x²y T(W,W,H) + 3xy² T(W,H,H) + y³T(H,H,H), so the coefficients of x³, x²y, xy², y³ are (P(W), 3T(W,W,H), 3T(W,H,H), P(H)). `Tsym` is the average of `cubicTri` over the six permutations, so it is symmetric and the factor 3 is right. `qP` is exactly this vector. CONFIRMED.

## Q2. Riesz's formula

- `Dq` by hand: F = q₀x³ + q₁x²y + q₂xy² + q₃y³ gives −yF_x + xF_y = q₁x³ + (2q₂ − 3q₀)x²y + (3q₃ − 2q₁)xy² − q₂y³, which is `![q 1, 2 * q 2 - 3 * q 0, 3 * q 3 - 2 * q 1, -q 2]`. At (x,y) = (cos σ, sin σ) this is d/dσ, since (x,y)' = (−y, x).
- Riesz: T′(σ) = (1/4n) Σ_{k=1}^{2n} (−1)^{k+1} T(σ + t_k)/sin²(t_k/2), t_k = (2k−1)π/(2n). At n = 3 the nodes are π/6, π/2, 5π/6, 7π/6, 3π/2, 11π/6, which is the file's (2k+1)π/6 for k = 0..5, and `ck`, `sk` are their cosines and sines, each checked.
- Weights 1/(12 sin²(t/2)) with alternating sign, by hand from sin²(t/2) = (1 − cos t)/2:

| t | sin²(t/2) | weight | `lk` |
|---|---|---|---|
| π/6 | (2−√3)/4 | +(2+√3)/3 | (2+√3)/3 |
| π/2 | 1/2 | −1/6 | −(1/6) |
| 5π/6 | (2+√3)/4 | +(2−√3)/3 | (2−√3)/3 |
| 7π/6 | (2+√3)/4 | −(2−√3)/3 | −((2−√3)/3) |
| 3π/2 | 1/2 | +1/6 | 1/6 |
| 11π/6 | (2−√3)/4 | −(2+√3)/3 | −((2+√3)/3) |

- Σ\|λ_k\| = 2(2+√3)/3 + 2(2−√3)/3 + 1/3 = 3 = n, the classical value.
- The rotation in `riesz`, (x cos t − y sin t, y cos t + x sin t), is rotation by +t, so at (cos σ, sin σ) it is (cos(σ+t), sin(σ+t)), the formula's T(σ + t_k).
- As a polynomial identity: both sides are homogeneous cubic forms in (x, y), so equality on the unit circle extends to the plane by scaling r³. A cubic form restricted to the circle is a trigonometric polynomial of degree 3 (frequencies 1 and 3), within Riesz's hypothesis. The polynomial identity is the stronger statement and the one `ring` closes, so its use is legitimate. CONFIRMED.

## Q3. The constant 27 and the sup

- `bern3` iterates `bern1` three times at bounds M, 3M, 9M, giving 27M = 3³M, the record's step 4 constant with N = 3.
- `hM` in `bern1`/`bern3` is sup over x² + y² = 1 of \|cub q x y\|, which is sup over σ of \|φ(σ)\|, the record's ‖φ‖_∞. Right sup.
- `P_plane_bound` requires `normSq2 W = 1`, `normSq2 H = 1`, `innerOp2 W H = 0` and `hM : ∀ R : CurvOp2 ι, normSq2 R = 1 → |Pcubic2 R| ≤ M`. Orthonormality is exactly what puts the circle on the unit sphere, matching step 2.
- `CurvOp2 ι` is `skewSub ι →L[ℝ] skewSub ι`, every linear operator on Λ², symmetric or not, Weyl or not. L143 (`L143_unconditional`) bounds \|P\| on the unit Weyl sphere only. So `hM` quantifies over a strictly larger set than L143 covers, and L143 does not supply it at M = 1 + √(n−2). This is O1.
- Does it matter? The theorem stays true and non-vacuous: P is continuous on the finite-dimensional unit sphere of `CurvOp2 ι`, so some M satisfies `hM`. But the record's radius uses L143's M, and the file's M is sup\|P\| over all unit operators, which is at least L143's and not established equal to it. Screens only, by hand in Hamilton's normalisation: the round-sphere operator Id/√N gives P = √(2(n−1)/n) and a rank-one projection gives P = 1, both below 1 + √(n−2), so no violation was found. The proof uses `hM` only on span(W, H), so the repair is to weaken `hM` to the plane (or to Weyl operators with W, H Weyl), after which `L143_unconditional` would instantiate it.

## Q4. h0 and h1

- φ′(0) = cub (Dq q) 1 0 = (Dq q)₀ = q₁ = 3T(W,W,H). So φ′(0) = 0 iff T(W,W,H) = 0, which is `h0`.
- φ″(0) = (Dq (Dq q))₀ = (Dq q)₁ = 2q₂ − 3q₀ = 6T(W,H,H) − 3P(W), which is `h1`'s left side.
- The record's step 3 gives φ″(0) = D²P[H,H] − DP_W[W] = 6T(W,H,H) − 3P(W), the same expression. CONFIRMED.
- `no_critical_in_tube_cubic` feeds `hbern` from `bern3` through `le_abs_self`. `bern3` gives the bound at every σ, stronger than the u ≥ 0 that `hbern` asks.

## Q5. Axioms

From a small check file run with `lake env lean` in lean:

- `bern3`, `P_plane`, `no_critical_in_tube_P`, `riesz`, `no_critical_in_tube_crit`: each depends on [propext, Classical.choice, Quot.sound], the standard three.
- The Q6 examples `cub (Dq ![1,0,0,0]) 1 0 = 0` and `cub (Dq (Dq ![1,0,0,0])) 1 0 = -3` both closed by `simp [cub, Dq]` (the second reported "No goals" at the trailing `norm_num`, meaning `simp` had already closed it).

## Q6. An object

- For `no_critical_in_tube_cubic`: q = (1, 0, 0, 0), F = x³, φ = cos³σ, M = 1. Then Dq q = (0, −3, 0, 0), φ′ = −3cos²σ sin σ, φ′(0) = 0, and Dq Dq q = (−3, 0, 6, 0), φ″(0) = −3. With θ = 1, γ = 1/2, `h1` reads −3 ≤ −3 and the radius is 2/9. The conclusion −3cos²s sin s < 0 on (0, 2/9) is true, and the example is kernel-checked in the Q5 file for the two derivative values.
- For `no_critical_in_tube_P`: a unit Weyl critical point W (the balanced product at n = 8, screened in the record's Gate 1) with H a unit normal direction orthogonal to the orbit tangent has T(W,W,H) = 0 by criticality and `h1` from the gap, and `hM` holds at M = sup\|P\| over the unit sphere of `CurvOp2`, finite by compactness. The object is non-vacuous at that M and unestablished at L143's.

## Q7. INDEX row L216

- The strike-through of "that φ is a trigonometric polynomial of degree three, and Bernstein's inequality for it" with "both PROVED" is accurate: `P_plane` gives the cubic form, `bern3` gives \|φ‴\| ≤ 27 sup\|φ\|.
- "L143's bound" remains in the row's list of what stays with the record. Accurate, but the row describes `no_critical_in_tube_P` as taking "\|P\| ≤ M on the unit sphere" without saying which sphere. It is the unit sphere of all of `CurvOp2`, where L143 says nothing (O1).
- The sentence carried over from r932, "no P, sphere, orbit or φ occurring in the file", now sits in a row naming two files, and it is false of L216Bern.lean, which contains P and φ. It is true of L216IsolationRadius.lean and should say so (O2).
- The residue named (step 1, the Hessian reading of h1, criticality of the point at distance s, L27's gap) is complete for L216Bern's contribution.

## Scope extension: `no_critical_in_tube_crit` (commit 5abd218f)

Hypotheses: `IsSelfAdjoint2 W`, `Qop2 W = θ • W`, W and H unit, `innerOp2 W H = 0`, `hM` as before, and `hgap : Tsym W H H ≤ θ * (1 / 2 - γ)`. Conclusion: φ′(s) < 0 on 0 < s < 4θγ/(9M).

- **h0 from criticality.** `Tsym_crit` gives T(W,W,x) = θ⟨W,x⟩, so T(W,W,H) = θ·0 = 0. This is the record's step 3, φ′(0) = 3⟨Q(W₁),H⟩ = 3θ⟨W₁,H⟩ = 0. CONFIRMED.
- **P(W) = θ.** T(W,W,W) = θ⟨W,W⟩ = θ at unit W. Then 6T(W,H,H) − 3θ ≤ 6θ(½ − γ) − 3θ = −6θγ, which is `h1`. CONFIRMED.
- **(a) The gap.** The record's hypothesis is ⟨L_eH,H⟩ ≤ ½ − γ, e = W₀/θ₀. The record's own identity T(u₁,V,V) = ⟨L_{u₁}V,V⟩ = θ⟨L_{e₁}V,V⟩ (L217 proof step (2), and L216 step 3's D²P_W[H,H] = 6θ⟨L_eH,H⟩) turns it into T(W,H,H) ≤ θ(½ − γ), multiplying by θ₀ > 0. So `hgap` is the gap read through L24's Hessian, the reading the header names as staying with the record. CONFIRMED.
- **H ⊥ the orbit tangent.** The record's gap quantifies over unit H ⊥ W₀ AND H ⊥ T_{W₀}𝒪, and it has to: on the orbit tangent ⟨L_eH,H⟩ = ½ (the ½-eigenspace, L27), so a gap over all H ⊥ W would be false for every γ > 0. The Lean theorem asks `hgap` for the single H at hand and asks only H ⊥ W. That is a correct per-direction form, not a weakening: any H satisfying `hgap` with γ > 0 is automatically off the tangent, and the record's step 1 supplies an H ⊥ T_{W₁}𝒪 at which the record's hypothesis delivers `hgap`. The orbit-tangent restriction therefore lives with step 1 and the record, and the file correctly states nothing about it.
- The theorem does not ask W or H to be Weyl, a harmless generalisation. It inherits O1 through `hM`, unchanged.
- **INDEX row after 5abd218f.** The added clause is accurate. Two carried phrases are now stale (O2): "enters as `h1`" (in `no_critical_in_tube_crit` it enters as `hgap`), and r932's "what type-checks is step 5's real-variable calculus, weaker than steps 4 and 5", since step 4 (Bernstein) now type-checks along P.

## Overall verdict: CONFIRMED WITH OBSERVATIONS

1. **O1.** `hM` in `P_plane_bound` and `no_critical_in_tube_P` ranges over every unit `CurvOp2`, while L143 bounds P on unit Weyl operators only. The file therefore does not accept L143's M = 1 + √(n−2) as typed. Weakening `hM` to span(W, H), or to Weyl R with W, H Weyl, would let `L143_unconditional` discharge it and close the record's M.
2. **O2.** The INDEX row's clause "no P, sphere, orbit or φ occurring in the file" now reads as covering L216Bern.lean, where it is false, and should name L216IsolationRadius.lean. After 5abd218f two more phrases are stale: "enters as `h1`" (it enters as `hgap` in `no_critical_in_tube_crit`), and "weaker than steps 4 and 5", step 4 now being typed along P.
3. **O3.** The docstring "L216's step 5 on P itself" sits on `hasDerivAt_P`, and `no_critical_in_tube_P`, the theorem it describes, has none.

## Falsifiers

- `riesz`: a cubic q and point (x, y) where the six-term sum differs from cub (Dq q) x y, for instance any sign or weight error in `lk` (none, table above).
- `bern3`: a cubic bounded by M on the circle with \|D³F\| > 27M somewhere (impossible by Bernstein, sharp at cos 3σ).
- `P_plane`: W, H with P(xW + yH) ≠ cub (qP W H) x y, requiring `Tsym` not symmetric or not P on the diagonal.
- `P_plane_bound`: orthonormal W, H and a unit (x, y) with \|P(xW + yH)\| > M while \|P\| ≤ M on the unit sphere.
- `no_critical_in_tube_P`: orthonormal W, H meeting h0, h1 and hM with φ′(s) ≥ 0 at some 0 < s < 4θγ/(9M).
- `no_critical_in_tube_crit`: a self-adjoint unit W with Q(W) = θW and a unit H ⊥ W with T(W,H,H) ≤ θ(½ − γ) and φ′(s) ≥ 0 inside the radius, or a critical W with T(W,W,H) ≠ θ⟨W,H⟩.
- O1 as a defect of fidelity: a unit non-Weyl operator in `CurvOp2` with \|P\| > 1 + √(n−2) would make `hM` fail at L143's M. None is exhibited here.

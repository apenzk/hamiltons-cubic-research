# REVIEW r1221: Gate 2 on I73 batch 30 (the norm of Hamilton's # on Sym²so(n))

Block under audit: [2026-09-26-I73-class-ceiling.md](2026-09-26-I73-class-ceiling.md), section "Batch 30". Log: [agent_logs/r1221.log](../agent_logs/r1221.log). Screens run by this reviewer (seconds each): scratchpad scripts r1221_screen.py and r1221_s2.py, outputs quoted below.

## Verdicts

| claim | verdict | reason |
|---|---|---|
| C1 Banach equivalence and the three reductions | CONFIRMED | Banach's polarization theorem applies (F symmetric trilinear on the real Hilbert space Sym²g, X#Y symmetric so sup over unit Z of F(X,Y,Z) is ‖X#Y‖). All three reductions re-derived, and θ = F(W,W,W) exactly on the family. |
| C2 automorphism family, I strict local max | CONFIRMED | ad∘(σ∧σ) = σ∘ad gives σ#σ = (n-2)σ, hence the ratio (n-2)N/N^{3/2}. Second variation re-derived: strict max iff every traceless scalar of I# is strictly below (n-2)/2, which holds exactly for n ≥ 7. |
| C3 screen, and "false at n ≤ 8" | REFUTED (narrow) | "False at n ≤ 8" fails at n = 3: κ_3 = 1/√3 = (n-2)/√N, so H holds there. Correct statement: false for 4 ≤ n ≤ 8. The screen itself is acceptable as a screen, with record gaps listed below. |
| C4 idempotent identity, window, Lean | REFUTED (narrow) | Identity, LP step, both window roots and the Lean file all confirmed. The claim that σ_{n/2} attains the lower window end holds only for even n. At odd n, including n = 9, no σ_k reaches it. |
| C5 realignment, Γ-cap | CONFIRMED | Every identity re-derived. The cap is Cauchy–Schwarz on ⟨Z, Q - Q^Γ⟩ = 2λ, with equality at Z_0 exact. Obstacle genuine: witness with ⟨Q,Q^Γ⟩ = -2. |
| C6 Casimir split | CONFIRMED | Z = (P⊗1 + 1⊗P - C)/2, tr_2 Z² = 2P and the M(V) formula re-derived. C ⪰ 0 and Z² ⪰ 0 give the bound, and the loss factor on so(k) is 2(k-1)/(k-2) exactly. One obstacle sub-claim is only PLAUSIBLE. |

## C1

- Banach: F(X,Y,Z) = ⟨X#Y, Z⟩ with X#Y ∈ Sym²g (A∧B symmetric on Λ²g when A, B are). So sup_Z F = ‖X#Y‖, giving κ = sup‖X#Y‖. Also sup‖X#X‖ lies between sup F(X,X,X) and sup‖X#Y‖. F is odd, so sup F = sup |F|.
- Quartic bound: ‖Π#Π‖ ≤ κ‖Π‖² = κd.
- Internal cap: in a basis adapted to V, F(Π,Π,Π) = Σ_γ⟨(Π#Π)u_γ,u_γ⟩ = (1/2)Σ_{α,β,γ∈V}⟨[b_α,b_β],u_γ⟩² = M(V)/2. So L255 gives θ ≤ F(Π)/d^{3/2} ≤ κ.
- Symmetric family: both multiplicities equal p (from a = 1/√(2p) and unit norm), so tr W³ = 0. Also ⟨W,W²⟩ = tr W³ in the Frobenius pairing. So θ = ⟨W, W²+W^#⟩ = F(W,W,W) ≤ κ.
- H implies θ ≤ (n-2)/√N < θ_0 by L256 as given.

## C2

- (σ∧σ)(u∧v) = σu∧σv, and ad of that is [σu,σv] = σ[u,v]. So σ#σ = σ ad adᵀ = (n-2)σ. Symmetry of σ is not needed for this.
- ‖σ‖² = N for orthogonal σ, so F(σ)/‖σ‖³ = (n-2)/√N.
- Ad_g is symmetric iff Ad_{g²} = 1 iff g² = ±1 (n ≥ 3). σ_k has g² = 1.
- Second variation at I along a traceless Y: f(I+tY)·N^{3/2} = (n-2)N + t²(3⟨I#Y,Y⟩ - (3/2)(n-2)‖Y‖²) + O(t³). The coefficient is negative iff each traceless scalar is < (n-2)/2. The scalars (n-4)/2 and -1 always pass. The scalar 2 passes iff n ≥ 7, and n = 6 is degenerate. The note's wording "at most" should read "strictly below" for strictness, but the conclusion n ≥ 7 is right.

## C3

- **Witness at n = 3.** On so(3), ad is the cross product, so X^# = cof X and F(X) = 3 det X. The maximum of 3 det X at ‖X‖ = 1 is 3·3^{-3/2} = 1/√3 = (n-2)/√N. Screen: 2000 shifted-power ascents give 0.57735027 against 1/√3 = 0.57735027, and F - 3 det X = 1.8e-15. Λ²_+ needs n ≥ 4.
- **4 ≤ n ≤ 8 established analytically.** F(Π_{Λ²+}) = 6 exactly at every n (checked n = 4..9). Ratio to (n-2)/√N is 1.414, 1.217, 1.118, 1.058, 1.018 for n = 4..8 and 0.990 at n = 9. This matches the note's values. The failure at n ≤ 8 rests on this construction, not on the screen.
- **Record gaps in the screen claim:**
  - The n = 6, 7, 8 run has no surviving log. The script opens its log with mode 'w', and [screen_sharp_cubic_norm.log](../agent_logs/screen_sharp_cubic_norm.log) holds only n = 9, 10, 12.
  - "From every random start" cannot be recorded by the script, which logs only the best of 24.
  - "An Ad-reflection" and "σ_6 at n = 12 by its trace" are not in the log. The log shows only eig min/max = ±1/√N. With ‖X‖ = 1, that forces X ∝ a symmetric orthogonal operator, but not an automorphism, and no trace is logged.
  - n = 12 is not converged (0.999995).
  - The PSD ascent uses a fixed relative step, so its values are lower bounds, not converged maxima.
  - The structured starts are fixed points (Π_h#Π_h = (k-2)Π_h on subalgebras), so they evaluate and do not ascend.
- **Could it miss a violator?** Yes, as any local search with 24 starts in a 666-dimensional space (n = 9) can miss a small basin. An independent check found none: n = 9, Riemannian gradient ascent with backtracking, 40 starts with half seeded near Λ²_+, gave best ratio 1.0000000. The scan Π_{Λ²+} + βI, β ∈ [-1,1], peaks at β = 0 with 0.9897. This is a screen, not evidence for H.

## C4

- Pairing C#C = C with I gives s = F(C,C,I) = ⟨I#C, C⟩ = Σ scalar·‖C_j‖², with ‖C_0‖² = s²/N. Eliminating ‖C_2‖² gives ‖C‖² = (n-1)s²/N - s + ((n-2)/2)‖C_1‖² + 3‖C_3‖², and (n-1)/N = 2/n. Confirmed.
- No idempotent is pure Weyl: if C = C_2 then s = 0, so ‖C‖² = 0. Confirmed.
- LP step: the cost per unit of the Weyl constraint is (n-2)/(n-4) for C_1 and 3/2 for C_3. So C_1 is no dearer iff n ≥ 8. For 0 < s < N/(n-2) this gives ‖C‖² ≥ 2s/(n-4)·(1 - s/(n-1)). I re-derived the s² coefficient as -2/((n-4)(n-1)).
- Window roots: (2s/(n-4))(1 - s/(n-1)) = N/(n-2)² has roots s = ((n-1)/2)(1 ± 2/(n-2)), namely s_- and N/(n-2). For s ≤ 0 the root of 2s²/n - s = N/(n-2)² is -n/(2(n-2)). For s ≥ N/(n-2), s²/N suffices, and 2s²/n - s ≥ s²/N holds there. All confirmed.
- Maximiser: the unit-sphere Lagrange condition gives X#X = F(X)X = κX. So C = X/κ is idempotent with ‖C‖ = 1/κ. Conversely every idempotent has F(C)/‖C‖³ = 1/‖C‖ ≤ κ. So H is equivalent to ‖C‖² ≥ N/(n-2)² for every nonzero idempotent. Confirmed.
- **Window ends, correction.** s(σ_k) = tr σ_k/(n-2), with tr σ_k = [k(k-1)+(n-k)(n-k-1)]/2 - k(n-k).
  - σ_1 gives s_- at every n. Confirmed.
  - σ_{n/2} gives -n/(2(n-2)) only for even n (n = 8: -0.6667 against end -0.6667).
  - For odd n the minimum over k is at k = (n±1)/2, with s = -(n-1)/(2(n-2)), strictly inside the window. At n = 9 that is -0.5714 against end -0.6429.
  - No Ad_g with g² = -1 exists at odd n.
  - So at odd n, including n = 9, the lower end is not attained by any automorphism of this form. The claim "both ends are attained with equality by automorphisms" holds for even n only. "Every σ_k sits in the window" is right for k ≥ 1 in the closed window. σ_0 = I lies outside it at s = N/(n-2).
- **Lean.** [I73SharpNorm.lean](../lean/HamiltonsCubic/Results/I73SharpNorm.lean) compiles clean with `lake env lean` in 15 s, with no sorry. The statements match the prose:
  - idem_norm_eq: the identity.
  - outer_bound: 2s²/n - s ≥ N/(n-2)² on s ≤ -n/(2(n-2)) or s ≥ N/(n-2). This is stronger than the prose's s²/N.
  - window_bound: n ≥ 8, with hweyl encoding ‖C_2‖² ≥ 0.
  - idem_norm_ge: n ≥ 9, with the operator identity as hypothesis hstar.
  - The ranges agree. n ≥ 9 in idem_norm_ge is conservative, since n ≥ 8 would suffice.

## C5

- Z = Σ μ_i v_i⊗v_i. Using ⟨[a,b],c⟩ = -tr(abc) on skew matrices:
  - tr Z³ = Σ μμμ ⟨[v_i,v_j],v_k⟩² = 2F(X).
  - tr Z² = Σ μ_iμ_j (tr v_iv_j)² = 4‖X‖².
  - tr Z = 0, SZS = Z, (v⊗v)^Γ = v⊗vᵀ = -v⊗v.
- Z_0 = Σ(E_ij - E_ji)⊗(E_ij - E_ji) = |Φ⟩⟨Φ| - S, with spectrum n-1, +1 on Λ², -1 on Sym²_0. Also tr Z_0² = 2n(n-1) = 4N and tr Z_0³ = (n-1)n(n-2) = 2(n-2)N. Consistent.
- H is equivalent to tr Z³ ≤ (n-2)/(4√N)·(tr Z²)^{3/2}. Confirmed.
- Cap: 2λ = ⟨Z, Q - Q^Γ⟩ ≤ ‖Z‖‖Q - Q^Γ‖, and ‖Q - Q^Γ‖² = 2 - 2⟨Q,Q^Γ⟩ with ⟨Q,Q^Γ⟩ = tr((ΨᵀΨ)²) = Σ s_k⁴. At Z_0's top eigenvector Φ/√n, the cap is (1/2)(1-1/n)·2n(n-1) = (n-1)², equal to λ². Confirmed.
- Obstacle:
  - It is genuine. The single-eigenvalue cap gives at best tr Z³ ≤ λ_max tr Z² ≤ 2^{-1/2}(tr Z²)^{3/2}.
  - The target coefficient is (n-2)/(4√N), which tends to 2^{-3/2}. So the loss is a factor 2 asymptotically, and 2.42 at n = 9 ("twice" understates it at finite n).
  - Joint version: ⟨Q,Q^Γ⟩ ≥ 0 fails. Witness at n = 4: Q is the projector onto span{vec I, vec J_1, vec J_2, vec J_3}/2 (quaternion complex structures). The Gram matrix is the identity, and ⟨Q,Q^Γ⟩ = -2, computed exactly. Random rank-2 projectors at n = 3 stayed positive (min 0.157), so the failure needs rank ≥ 4-type structure.
  - The Λ²_+ spectrum 3/2 (×4), -1/2 (×12) is confirmed by the Casimir: ΣJ_a⊗J_a = 3 on spin 0 and -1 on spin 1, halved.

## C6

- -D(v)² = -(v²⊗1 + 1⊗v² + 2v⊗v). Summing gives C = P⊗1 + 1⊗P - 2Z. C ⪰ 0 since D(v) is skew.
- tr_2 Z² = Σ v_iv_j tr(v_iv_j) = -2Σv_i² = 2P, and tr_1 likewise.
- M = tr Z³ = (1/2)tr((P⊗1 + 1⊗P)Z²) - (1/2)tr(CZ²) = 2 tr P² - (1/2)tr(CZ²). Since tr(CZ²) ≥ 0 (C ⪰ 0, Z² ⪰ 0), M ≤ 2 tr P².
- tr P = 2d. The eigenvalues are Σ|v_i x|², which is ≤ d because ‖v_i‖_op ≤ 1, and ≤ n-1 because P_V ≤ P_g = (n-1)·1.
- Loss factor on so(k): 2 tr P² = 2k(k-1)² and M(so(k)) = 2(k-2)·k(k-1)/2, so the ratio is 2(k-1)/(k-2). Exact.
- Obstacle:
  - The dropped-term bound genuinely fails the target. At n = 9, 2 tr P² = 24 against 2κd^{3/2} = 12.1 for so(3), and 1152 against 504 for V = g.
  - "Off by about 2 on the whole extremal family" is loose. Among projectors only V = g lies in H's equality set. σ_k (k ≥ 1) are not projectors, so Approach 3 does not see them.
  - "No lower bound in terms of P_V alone" is PLAUSIBLE only. I did not test it, since it would need an optimisation over V.

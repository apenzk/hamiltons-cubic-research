# Gate 2 review r1220, batch 30 of the I73 class-ceiling note (the norm of Hamilton's # on Sym² so(n))

Cold adversarial review of section "Batch 30" of [2026-09-26-I73-class-ceiling.md](2026-09-26-I73-class-ceiling.md). Log: [agent_logs/r1220.log](../agent_logs/r1220.log). Every identity below was rederived by hand from the definitions in the brief before the project's scripts were run. Numerical work in this review: the project's [check_I73_sharp_norm_identities.py](../scripts/misc/check_I73_sharp_norm_identities.py) (0.5 s), one targeted screen of my own at n = 9, 10 (3 min), and one explicit partial-transpose witness at n = 4 (under 1 s).

## Verdict table

| Claim | Verdict | One line |
|---|---|---|
| C1, Banach equivalence and the three reductions | **CONFIRMED**, with one overbroad sentence | all three reductions and θ = F(W,W,W) hold exactly. "At n ≤ 8 H is false" fails at n = 3, where κ₃ = 1/√3 = (n-2)/√N (AM-GM on the adjugate) |
| C2, σ#σ = (n-2)σ, the σ_k, I a strict local max for n ≥ 7 | **CONFIRMED** | ad∘(σ∧σ) = σ∘ad is immediate from the automorphism property. The second variation needs each traceless scalar of I# strictly below (n-2)/2, and 2 < (n-2)/2 exactly when n ≥ 7 |
| C3, the screen | **PLAUSIBLE** as a screen, with three coverage defects | no violator in my own 72 extra ascents plus a u(m)-family grid. But the n = 6, 7, 8 figures have no committed log, the script records only the best of each batch, and the structured starts are fixed points of the iteration. "False at n ≤ 8" is established exactly for 4 ≤ n ≤ 8 by Λ²₊ and is wrong at n = 3 |
| C4, Approach 1, idempotents and the trace window | **CONFIRMED except one sub-claim, REFUTED at odd n** | the pairing identity, the elimination, "no pure-Weyl idempotent", the LP ranges and the maximiser-to-idempotent step all hold. The lower end -n/(2(n-2)) is attained by σ_{n/2} only for even n. At n = 9 no σ_k reaches it (min is -4/7 against -9/14) |
| C5, Approach 2, realignment and partial transpose | **CONFIRMED**, obstacle genuine | every identity rederived. Witness for the obstacle: span{I, J, K}/2 at n = 4 has ⟨Q,Q^Γ⟩ = -3/4 |
| C6, Approach 3, the Casimir split | **CONFIRMED**, obstacle genuine as a loss factor | Z-split, tr₂Z² = 2P_V, M = 2trP² - ½tr(C_V Z²) and the factor 2(k-1)/(k-2) all rederived. "No lower bound in terms of P_V alone" is asserted, not shown |

## Lean section

| claim | declaration | verdict |
|---|---|---|
| C1 | none (operator-level) | judged by hand, above |
| C2 | none | judged by hand, above |
| C3 | none (a screen) | n/a |
| C4 | idem_norm_eq, outer_bound, window_bound, idem_norm_ge in [I73SharpNorm.lean](../lean/HamiltonsCubic/Results/I73SharpNorm.lean) | **MATCHES PROSE, COMPILES.** `lake env lean` exits 0 with no output. Hypotheses read as stated: `hstar` is the pairing identity, `hq` the orthogonal split, `hweyl` is c ≥ 0, ranges are n > 2 (outer), n ≥ 8 (inner) and n ≥ 9 (combined). `-n / (2 * (n - 2))` parses as (-n)/(2(n-2)), the same value. The vacuity example shows `hstar` is satisfiable. The file proves only the scalar consequence, as it says |
| C5 | none | judged by hand |
| C6 | none | judged by hand |

---

## C1

**Banach.** F is a symmetric trilinear form on the real Hilbert space Sym²g, so Banach's polarization theorem gives sup |F(X,Y,Z)| = sup |F(X,X,X)| over unit vectors. F is odd, so sup F = sup |F| on the diagonal. X#Y is symmetric when X, Y are (A∧B is symmetric on Λ²g), so sup over unit Z of F(X,Y,Z) is ‖X#Y‖. sup ‖X#X‖/‖X‖² is squeezed between the diagonal and the full sup. All three are κ_n.

**The three reductions.**
- L257: ‖Π‖_F² = d, so ‖Π#Π‖ ≤ κ_n d. Under H this is (n-2)d/√N.
- L255: with an orthonormal basis of V, F(Π,Π,Π) = Σ_w ⟨(Π#Π)w,w⟩ = ½ Σ_{u,v,w∈V} ⟨[u,v],w⟩² = M(V)/2. So M ≤ 2κ_n d^{3/2}, θ ≤ M/(2d^{3/2}) ≤ κ_n, and H with L256 gives θ < θ₀.
- Symmetric family: tr W = 0 forces the ±a multiplicities equal (p each), so tr W³ = a³(p - p) = 0. Pairing W² + W# = θW with W gives θ = tr W³ + F(W,W,W) = F(W,W,W) ≤ κ_n. Exact.

**Overbroad sentence.** "At n ≤ 8 it is false: Λ²₊ gives 2/√3" needs n ≥ 4. At n = 3, in an eigenbasis of X with unit structure constants, X#X = adj X, so F(X) = 3 det X ≤ 3(1/√3)³ = 1/√3 = (n-2)/√N on the unit sphere. **H holds at n = 3.** The correct statement is "false for 4 ≤ n ≤ 8". H is only claimed for n ≥ 9, so nothing downstream changes.

## C2

For an automorphism σ, ad(σ∧σ)(u∧v) = ½([σu,σv] + [σu,σv]) = σ[u,v]. Then σ#σ = σ ad ad^T = (n-2)σ. Orthogonal and symmetric give ‖σ‖² = N and F(σ) = (n-2)N, ratio (n-2)/√N. σ_k = Ad(diag(-1_k, 1_{n-k})) is an orthogonal involutive automorphism. [check_I73_sharp_norm_identities.py](../scripts/misc/check_I73_sharp_norm_identities.py) reruns σ#σ = (n-2)σ at residual 0 for k = 1…8 at n = 9. Ad_J at n = 10 (J² = -1) is another member (my screen: residual 0, ratio 1.000000, trace 5).

**Local maximum.** Take X = I + tY with tr Y = 0. Then F(I,I,Y) = (n-2)tr Y = 0 and ‖X‖² = N + t²‖Y‖². The t² coefficient of F/‖X‖³ is (3⟨I#Y,Y⟩ - (3/2)(n-2)‖Y‖²)/N^{3/2}. It is negative definite iff every traceless scalar of I# is below (n-2)/2. The scalars (n-4)/2 and -1 always are. The scalar 2 needs n > 6. The prose says "at most", but strictness is what a strict maximum needs, and it holds at n ≥ 7. At n = 6 the Λ⁴ direction is degenerate. The σ_k have the same value but are separate points, so this is local only.

## C3

**What the log supports.** [screen_sharp_cubic_norm.log](../agent_logs/screen_sharp_cubic_norm.log) covers n = 9, 10, 12 only and matches the note's numbers. The traces the note infers are consistent with the logged distances to I/√N (σ_4 or σ_5 at n = 9, σ_5 at n = 10, σ_6 at n = 12, from tr σ_k = N - 2k(n-k)).

**Three coverage defects.**
1. **The n = 6, 7, 8 figures have no committed log.** The script prints only the best ratio of each batch, so the words "from every random start" are not recorded anywhere, at any n.
2. **The structured starts test nothing.** Projectors onto so(k) and Λ²₊ are idempotent directions (Π#Π = (k-2)Π and 2Π), so they are fixed points of X ← normalise(X#X + αX). The log shows "ascended r" equal to the start in every row. Exact fixed points include saddles.
3. **Dense Gaussian starts sample one basin family.** In my screen r1220_screen.py (scratchpad, uncommitted, /private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d3790d3b-3383-4c5d-9548-46ea15965c86/scratchpad/r1220_screen.py), 16 of 16 low-rank indefinite starts at each of n = 9, 10 converged to the Λ²₊ local maximum (0.98974, 0.96825), never to ratio 1. Λ²₊ is thus a competing local maximum below 1 with its own basin. The project screen never sampled that basin from its general starts.

**No violator found.** In my screen, perturbed starts from Λ²₊, Λ²₊ ± I/4, so(3), so(5), so(7) (4 each), plus the low-rank starts, gave at most 1.000000 at n = 9, 10. A grid over the u(5) family aΠ_su + bΠ_center + cΠ_m at n = 10 also peaked at 1.000000. As a screen, "nothing exceeds 1 at n = 9, 10, 12" is **PLAUSIBLE**. It is not evidence for H.

**"False at n ≤ 8".** The check script confirms Λ²₊/2 is an exact idempotent, so F(Π) = 6 and the ratio is 2/√3 exactly. 2/√3 > (n-2)/√N holds for 4 ≤ n ≤ 8 (n = 8: 1.1547 > 1.1339) and fails at n = 9 (7/6). **Established analytically for 4 ≤ n ≤ 8, false at n = 3** (see C1).

## C4

**Identity.** ⟨C#C, I⟩ = F(C,C,I) = ⟨I#C, C⟩ = Σ λ_j‖C_j‖². Here ‖C₀‖² = s²/N and ⟨C,I⟩ = s. Eliminating c = ‖C₂‖² gives ‖C‖² = (n-1)s²/N - s + ((n-2)/2)a + 3b, and (n-1)/N = 2/n. Exact. It reruns at residual ≤ 4e-15 on all eight test idempotents.

**No pure-Weyl idempotent.** s = a = b = 0 forces 0 = -c. Correct.

**The LP.** Constraint c ≥ 0 reads ((n-4)/2)a + 2b ≥ R = s - (n-2)s²/N. The unit cost via a is (n-2)/(n-4) and via b is 3/2. The a-route is at least as cheap iff n ≥ 8. For 0 < s < N/(n-2), the bound works out to (2s/(n-4))(1 - s/(n-1)). The s² coefficient is 2/n - 2(n-2)²/((n-4)n(n-1)) = -2/((n-1)(n-4)).
- Its roots against the target N/(n-2)² are s_- and N/(n-2) (sum n-1, product checked).
- The outer quadratic 2s²/n - s - N/(n-2)² has discriminant root n/(n-2) and roots -n/(2(n-2)) and N/(n-2).
- "‖C‖² ≥ s²/N beyond N/(n-2)" is the trivial bound and suffices there. The Lean file uses the sharper outer quadratic, which is also valid.
- **The window is exactly (-n/(2(n-2)), s_-).**

**Maximiser to idempotent.** The Lagrange condition on the unit sphere is 3X#X = 2μX, so X#X = F(X)X = κ_nX. C = X/κ_n then has C#C = C and ‖C‖ = 1/κ_n. Conversely, every idempotent has F(C)/‖C‖³ = 1/‖C‖ ≤ κ_n. H is therefore equivalent to ‖C‖² ≥ N/(n-2)² for all nonzero idempotents. Confirmed.

**Window ends: REFUTED at odd n.** C = σ_k/(n-2) has s = (N - 2k(n-k))/(n-2).
- k = 1 gives s_-, as claimed.
- k = n/2 gives -n/(2(n-2)), **but only when n is even**.
- For odd n the minimum over k is at k = (n-1)/2, s = -(n-1)/(2(n-2)). That lies strictly inside the window. At n = 9, the first case of the Lean statement, it is -4/7 = -0.5714 against the end -9/14 = -0.6429.
- Ad_J needs J² = -1 and so n even. At odd n the lower end is not attained by any listed automorphism.
- **Correction:** "σ_{n/2} at the lower end (n even). At odd n the lowest σ_k sits at -(n-1)/(2(n-2)), inside the window". "Every σ_k sits in the window with equality" is right, with σ_1 at the closed upper end.

**Obstacle.** The LP relaxation is tight at every σ_k (b = c = 0 at σ_1, where σ_1 = I - 2Π_star is trace plus Ricci). So no inequality built from the trace pairing plus componentwise norms can close the window. The obstacle is genuine. "The trace is the only invariant pairing available from norms alone" is a judgement, reasonable but unproved.

## C5

- Z = Σ X_ab E_a⊗E_b is symmetric because (V⊗V)^T = (-V)⊗(-V).
- tr Z = Σμ(tr V)² = 0.
- tr(V_iV_j) = -2δ_ij gives tr Z² = 4‖X‖².
- For skew A, B, C, ⟨[A,B],C⟩ = -tr(ABC). So tr Z³ = Σ μμμ c² = 2F(X).
- SZS = Z and (V⊗V)^Γ = V⊗V^T = -V⊗V.
- H then reads tr Z³ ≤ ((n-2)/(4√N))(tr Z²)^{3/2}. Correct.

**Z₀.** Σ_{i<j}(E_ij - E_ji)⊗(E_ij - E_ji) = Σ_{i≠j}(E_ij⊗E_ij - E_ij⊗E_ji) = |Φ⟩⟨Φ| - S, since the diagonal terms cancel. The spectrum is n-1 on Φ, +1 on Λ² (dim N) and -1 on Sym²₀ (dim N+n-1). As stated.

**Γ cap.** Γ is a self-adjoint isometry. So ⟨Z, ψψ^T - (ψψ^T)^Γ⟩ = 2λ, with ‖ψψ^T - (ψψ^T)^Γ‖² = 2 - 2Σs_k⁴. The cross term is Σ s_k⁴, checked via the Schmidt form. This gives λ² ≤ ½(1 - Σs⁴)tr Z². At Z₀, tr Z₀² = 2n(n-1) and Σs⁴ = 1/n, so the cap is (n-1)², with equality. Confirmed (8 = 8 at n = 9 on rerun).

**Λ²₊ spectrum.** With V_i = J_i/√2 (quaternion units), the J_i⊗J_i commute, square to 1 and multiply to one another. The joint eigenvalues are 3 once and -1 three times, each on a 4-dimensional space. Halved, that is 3/2 four times and -1/2 twelve times. Confirmed.

**Obstacle.** The two-eigenvalue estimate 2(T/2)^{3/2} = 2^{-1/2}T^{3/2} is right, is spectrally compatible with tr Z = 0 once the negative mass is spread thin, and is about twice the target (n-2)/(4√N) → √2/4. **"⟨Q,Q^Γ⟩ ≥ 0 fails in general" is true, but random projectors do not show it.** 2000 random projectors at n = 4 all gave ≥ 0.55. The explicit witness is Q spanned by I/2, J/2, K/2 at n = 4 (J, K anticommuting complex structures). Here ⟨ψ_a ψ_a^T, (ψ_b ψ_b^T)^Γ⟩ = tr((Ψ_a^TΨ_b)²), so ⟨Q,Q^Γ⟩ = 3/4 - 6/4 = **-3/4** (computed). Genuine obstacle.

## C6

- D(v)² = v²⊗1 + 2v⊗v + 1⊗v² gives Z = ½(P⊗1 + 1⊗P - C_V).
- C_V = ΣD(v)^T D(v) ⪰ 0.
- tr₂Z² = Σ v_iv_j tr(v_iv_j) = 2P, and tr₁Z² = 2P by SZS = Z.
- Hence M = tr Z³ = 2trP² - ½tr(C_V Z²) ≤ 2trP². tr(C_V Z²) ≥ 0 as a trace of a product of two PSD matrices.
- The star-overlap eigenvalue bound min(d, n-1) is right.
- **On so(k):** M = 2F(Π) = k(k-1)(k-2), P = (k-1) on R^k, 2trP² = 2k(k-1)². The ratio 2(k-1)/(k-2) is confirmed.
- The rerun matches the split to six places at d = 3, 10, 20.

**Obstacle.** The loss is exact and tends to 2 for large k (it is 4 at k = 3, so "about 2" is a large-k statement). "The subtracted Casimir term has no lower bound in terms of P_V alone" is asserted without an example of two subspaces with equal P_V and different tr(C_V Z²). It is plausible but unproved as written.

## Summary of corrections owed to the note

1. "At n ≤ 8 it is false" becomes "for 4 ≤ n ≤ 8 it is false". At n = 3, κ₃ = (n-2)/√N.
2. "σ_{n/2} at the lower end" needs "n even". At odd n (including n = 9) no σ_k reaches -n/(2(n-2)), and the lowest sits at -(n-1)/(2(n-2)).
3. The screen paragraph's n = 6, 7, 8 figures and "from every random start" need a committed log that records every start. The structured starts should be described as fixed points. Λ²₊ is a competing local maximum with its own basin at n ≥ 9.

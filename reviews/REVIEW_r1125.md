# Review r1125: Gate 2 on L242 (2026-09-25)

Brief: [2026-09-25-L242-gate2-brief.md](2026-09-25-L242-gate2-brief.md). Log: agent_logs/r1125.log. Analysis only, with seconds of exact evaluation of the stated point and one numerical screen of two explicit subalgebras.

| Item | Verdict |
|---|---|
| 1. Exactness | CONFIRMED |
| 2. Section 5 below mu=1 | CONFIRMED, two stale Lean docstrings |
| 3. The octonion value | CONFIRMED |
| 4. Realisability of the boundary | REFUTED: G12 is interior, but the tau zero pattern forces an unrealisable configuration |
| 5. Scope and labels | PLAUSIBLE: "widest margin among the survivors" is wider than three bisected triples support |
| Lean section | CONFIRMED, with stale comments |

## 1. Exactness: CONFIRMED

Independent exact evaluation in Fractions (my own code, not the LP, with the builder of screen_I73c_I1_rowspan.py used only for I1):

- All nine rows vanish exactly. tau is nonnegative and totally symmetric.
- P values reproduce: P00=P22=26/33, P01=P12=1/63, P02=8/9, P11=412/861, by both the brief's N-formula and tau_ab/(m_a(m_b-delta_ab)).
- Pair caps: worst slack -10/9 (P02). Ky Fan over every profile with 1 <= R <= 6 (r_b bounds dropped, which is stronger): worst slack -10/9.
- Seven-frame over all 36 compositions: max 1172/33 at (4,0,3) and (3,0,4).
- G = [[72,120,72],[120,684,120],[72,120,72]], with eigenvalues 0 and 414 +- 30 sqrt(113), both positive, so G is PSD with det 0. tau_ab = [[104,8,128],[8,824,8],[128,8,104]]. G_ab >= tau_ab/2 with slacks 116, 8, 116. G_aa >= tau_aa/2 and >= 4m_a^2/n hold strictly, and G02 = 72 < 144. Only CS(0,2) and det are tight, both forced by A0=A2.
- Section 5 at mu=99/100: slacks 70821/500, 8099/250, 51921/500 on pairs 01, 02, 12.
- Window: I1 = -5901/250, Gamma/p = -216/5, so -43.2 <= -23.6 <= 0.
- theta^2 = 50/27 from sum m e^2 = 27/50.
- The script with arguments `120 42 12,42,12 -3/20,0,3/20` reproduces the point and reports 0 of 307 violated.

## 2. Section 5 below mu=1: CONFIRMED

- Section 5's derivation bounds the Ricci correction by (mu-ring/(2(n-2)))|h|^2 and then by the cap, so the valid class constraint is the inequality at mu = cap, the weakest one. Its mu coefficient multiplies sum |h|^2 = G_ab - tau_ab/2 >= 0, so the right side increases in mu and a check at 99/100 <= cap implies the check at the cap. The sign of the coefficient (negative below 1) is irrelevant to this monotonicity.
- cap^2 = 220 E2/121 = 5940/6050, and (99/100)^2 = 0.9801 <= 0.98182. Correct.
- `section5_at_cap` states exactly this: for real mu >= 99/100, hG and the check at 99/100 give the inequality at mu. Combined with `mu_cap_ge` it covers the cap.
- Defects (doc only): its docstring says "mu anywhere in [1, sqrt3080/55]" and "at least the right side at 1", both left over from L241. `mu_cap_ge` types 99/100 <= sqrt(5940/6050), and the identity cap = sqrt(5940/6050) from Theta_12 = sqrt220/12 and theta^2 = 50/27 is prose (checked here: sqrt220/(11 theta), squared 220*27/(121*50)).

## 3. The octonion value: CONFIRMED

- Left multiplications by imaginary unit octonions satisfy L_i L_j + L_j L_i = -2 delta_ij I (alternativity, polarised). So X_i = L_i/2 are orthonormal in the record's norm (half Frobenius, with ||L_i||_F^2 = 8), [X_i,X_j] = L_i L_j/2 for i != j, which is orthogonal/2 with half-Frobenius norm^2 exactly 1. Seven elements give 42 ordered pairs, total 42.
- The normalisation matches the record's T: row (A) at a coordinate 2-form gives 2(n-2), which is the half-Frobenius Casimir. At n=12 embed R^8 in R^12.
- So every valid seven-frame constant is >= 42 > 1172/33, and the conclusion "no sharpening of L240, down to the best constant, lets the class-level system exclude this spectrum" follows from the point. It is scoped to the seven-frame constant. It says nothing about other new constraints, and the block does not claim otherwise.

## 4. Realisability: REFUTED

**G12 is interior, as claimed.** At this tau, with G02 = G00 = G22 = (264-g)/2 and G11 = 924 - 2g, the constraints give g in [4, 136]: lower end G01 = tau01/2 (and G12 = tau12/2), upper end G02 = tau02/2. G02 <= m0 m2 needs only g >= -24, and CS, PSD, 4m^2/n need g <= 168. Section 5 and the window stay slack over the whole interval (I1 has g12 coefficient -3/4000). The Gram data alone is realisable by PSD isotropy matrices: A0 = A2 with eigenvalues 2 +- sqrt2 (six each), A1 = 11I - 2A0 (eigenvalues 7 -+ 2 sqrt2), which gives tr A_a = 2m_a, sum A = 11 I, e0 A0 + e2 A2 = 0 and exactly this G.

**But the tau zero pattern forces an unrealisable configuration.** T_{abg} = <[X_a,X_b],X_g>^2 >= 0 termwise, so a zero class sum kills every term:

- tau001 = 0 gives [E0,E0] perp E1; tau012 = 0 gives [E0,E2] perp E1 (ad-invariance); tau122 = 0 gives [E2,E2] perp E1.
- So V = E0 + E2 is a **24-dimensional Lie subalgebra of so(12)**, with E1 = V-perp.
- Its internal bracket mass from the class values: sum over alpha,beta,gamma in V of T = tau000 + 3 tau002 + 3 tau022 + tau222 = 0 + 312 + 72 + 80 = **464**, out of the 24 * 2(n-2) = 480 that row (A) assigns to V's basis. Only 16 = tau011 + tau211 goes to E1.
- For a compact subalgebra V = centre + simple ideals S, the internal fraction of each ideal is ind(ad S)/ind(Lambda^2 R^12) = ind(ad S)/(10 ind(R^12|S)), and the centre contributes 0. The simple algebras of dimension <= 24 with a faithful real module of dimension <= 12 are A1, A2, B2, A3, G2, B3, C3, A4, and ind(ad)/ind(rho) <= 5 for each (maximum at so(7) on R^7 or R^8, and su(5) on R^10). So the internal mass is at most 480/2 = 240 < 464.
- Screen (seconds, numerical, on two explicit subalgebras): su(5) in so(10) in so(12) gives internal 240 of 480, and so(7)+so(3) gives 216 of 480. Both confirm the normalisation of the index bound.

**Consequence.** No eigenspace decomposition of Lambda^2 R^12, from any Weyl tensor or otherwise, has these class values. The lemma's statement survives, since it is scoped to the class-level relaxation and says "a point of the relaxation, not a Weyl tensor". Corrections owed:

- The Scope line should say this point is **provably unrealisable** (the zero pattern makes E0+E2 a subalgebra with 29/30 of its Casimir internal, against at most 1/2), rather than leaving realisability untested.
- plan.md's "Owed next: R37's realisability question at L242's point" is answered at this point, negatively. The evidential weight of L242 for "no seven-frame cap closes (c)" therefore rests on the relaxation only. Whether a realisable class point with every seven-frame total below 42 exists above sqrt(3/2) is open.
- A cheap repair to try: a point on the same spectrum with tau012 (or tau001, tau122) positive, which breaks the subalgebra conclusion. It needs a new LP proposal and exact recheck, a bounded run.

## 5. Scope and labels: PLAUSIBLE

- Ceilings 1.43, 1.24, 1.27 are labelled "bisection screens". Correct label.
- **"The symmetric family carries the widest margin among the survivors of the T7 <= 42 screen"** is bold and unhedged but rests on ceilings at three of 190 survivors (ATTEMPTS.md line 8889), one of them symmetric, and each ceiling is computed on the survivor's own five directions, so it is a lower bound on that triple's true ceiling. Repair: "at the three triples bisected, the symmetric one has the widest margin (screens)". plan.md's "asymmetric survivors clear sqrt(3/2) by under 0.05" generalises from two triples to 181 and needs the same repair.
- "this point does not, because its larger eigenspaces spread the bracket mass" is an explanation with no argument behind it. Mark it as a reading.
- "L241 ... dies once T7 <= 44 (a screen)" is consistent with L241's "infeasible at T7 <= 45".
- The headline claim is correctly bounded to the seven-frame constant and to the class system.

## Lean section: CONFIRMED, with stale comments

- Rows, tau_nonneg, tau_symm (two transpositions generate S3), P as the brief's formula (N never zero here), pair_caps, kyfan_caps (odd kappa set to the next even value, which is what L237 proves, and r_b <= m_b - delta dropped, stronger), seven_frame_caps over every composition (k_a <= m_a dropped, stronger), G from section 3's formulas with gram_rows checking section 3's six equations, gram_constraints (including strict G02 < m0 m2), section5 on the three pairs a<b (section 5 is stated for a != b), theta_sq, theta_above: each says what the prose needs.
- rhs5 hardcodes eps_max = 3/20, which is e 2. Fine.
- Stale: the section header "The isotropy Gram at G12 = 56" (the value is 120), and section5_at_cap's docstring (see item 2).
- Untyped as declared: the octonion 42, the window, and the relaxation's derivation. The cap identity sqrt(5940/6050) is also prose.

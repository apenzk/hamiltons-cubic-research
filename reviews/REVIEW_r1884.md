# REVIEW r1884: I117, positive-definite idempotents on g₂'s torus family (reader one of two)

Brief: [BRIEF_I117_g2_torus.md](BRIEF_I117_g2_torus.md). Note: [2026-09-28l-I117-g2-torus.md](2026-09-28l-I117-g2-torus.md). Log: [r1884-i117-g2-torus.log](../agent_logs/r1884-i117-g2-torus.log).

**Verdict: every item holds. The product table, the system, the stabiliser argument and both exact solves are right, and the note's scope is honest. Two cosmetic corrections, none affecting a conclusion.**

| item | claim | verdict |
|---|---|---|
| 1 | the family is nine-dimensional and closed under # | CONFIRMED |
| 2 | the product table, with the long and short root lengths 2 and 2/3 | CONFIRMED |
| 3 | the system, and positive definiteness exactly when w > 0 | CONFIRMED |
| 4 | the stabiliser types S₃, reflection, trivial | CONFIRMED |
| 5 | the Weyl-invariant and reflection-invariant solves, identifications and norms | CONFIRMED |
| 6 | scope | CONFIRMED, with two wording corrections |

## Method

I built my own objects and did not import the scripts under review. g₂ is the stabiliser in so(7) of the 3-form 123+145+167+246−257−347−356, orthonormalised in the record's metric ½ tr XᵀY. The sharp comes from its structure constants, and the check I#I = 4I holds to 5e-15. The Cartan is the centraliser of a random element, which has dimension 2. The root planes are the eigenspaces of ad(h)² for a generic Cartan element h. The exact solves were written from my own root geometry: G₂'s roots in coordinates over Q(√3), dot products rescaled by 2/3, and the coefficient ½ or 2/3 assigned from the rule under test. The numerical g₂ checks that rule independently. Every run took seconds, apart from one QQbar variety call that I killed at my stated 5-minute bound and replaced by a triangular decomposition.

## Item 1

- By hand, as a real T-module g₂ is t (trivial, dimension 2) plus six pairwise inequivalent 2-dimensional rotation modules, one per positive root line. The symmetric endomorphisms commuting with T are therefore Sym²t (dimension 3) plus a scalar on each plane (6), which gives 9. The sharp is Ad(G₂)-equivariant because the structure constants are invariant, so the commutant is closed under #.
- Numerically, the symmetric operators commuting with ad(t₁) and ad(t₂) form a space of dimension exactly 9.

## Item 2

On my construction the root planes have |α|² = 2, 2, 2, 2/3, 2/3, 2/3. The table checks as follows, with residuals below 7e-15 throughout:

- A#A = 0.
- A#P_α = ½(αᵀAα)P_α for a random symmetric A on t, on all six planes.
- P_α#P_α = ααᵀ on t, on all six planes.
- All 15 mixed products P_α#P_β have no Cartan part. They are ½P_γ on each γ = ±α±β, and 2/3 exactly when α, β and γ are all short. The support matches the predicted γ in every case, and the product vanishes when α±β is not a root (for example on each orthogonal long–short pair).

As a hand cross-check, the table reproduces I#I = 4I. On t it gives Σ|α|² = 8 = 2·4. On a long plane it gives 2 + 2·(½+½) = 4. On a short plane it gives 2/3 + 2·(2/3+½+½) = 4.

## Item 3

- The cross terms of C#C appear twice, which turns the ordered sum into Σ over unordered pairs of 2·coef·w_α w_β.
- The Cartan equation is A = Σ w_α² ααᵀ, because A#A = 0 and neither A#P_α nor the mixed products have a Cartan part.
- The plane-γ equation is w_γ(1 − γᵀAγ) = Σ 2 coef w_α w_β with γᵀAγ = Σ w_α²(α·γ)², which is the note's form. The same structure produced the four reflection cubics of Item 5.
- C is positive definite exactly when A is positive definite and every w_α > 0. A = Σ w²ααᵀ is positive definite as soon as the nonzero weights span t, so positive definiteness is equivalent to w ∈ ℝ⁶ with every entry positive.
- A hand derivation of the Weyl-invariant equations gives the note's pair. On the long equation the dot-product squares are 4, 1, 1 (long) and 0, 1, 1 (short). On the short equation they are 1, 1, 0 (long) and 4/9, 1/9, 1/9 (short).

## Item 4

- W(G₂) is dihedral of order 12, and its central −1 maps each root to its negative, so it fixes every root line. The central −1 acts on t as −I, which fixes A.
- W/{±1} ≅ S₃ acts faithfully and compatibly on the three orthogonal long–short pairs. In coordinates with long roots (0,√3), (3/2,√3/2), (−3/2,√3/2) and short roots (1,0), (1/2,√3/2), (−1/2,√3/2), the pairs are L₁ ⊥ a, L₂ ⊥ c and L₃ ⊥ b.
- The reflection s_a fixes L₁ and a and swaps L₂ with L₃ and b with c. This is the note's parametrisation.
- The subgroups of S₃ are S₃, the three conjugate transpositions, A₃ and the trivial group. A₃ is transitive on each triple and forces uniform weights, and then A is scalar, so the stabiliser is all of S₃. The types are therefore S₃, a reflection (one representative up to conjugacy) or trivial.

## Item 5

**Weyl-invariant solve.** The ideal saturated by XY has degree 4. Its solutions are (¼, ¼), (9/28, 3/28), (−½, −2.8028) and (−½, 0.8028). So there are exactly two positive solutions, and the other two have x = −½, as the note says.

**Reflection-invariant solve.** The ideal is zero-dimensional with 53 solutions counted with multiplicity, of which 31 are real (distinct). The part with all four coordinates nonzero has degree 36 and 18 real points. Exactly four of them are positive:

| (x, z, u, y) | ‖C‖² exact | identification check |
|---|---|---|
| (¼, ¼, ¼, ¼) | 7/8 | I/4 |
| (9/28, 9/28, 3/28, 3/28) | 351/392 | A = (3x²+y²)I = 9/28 on t, which is L263's SU(3) |
| (11/29, √(77/1682), √(77/1682), 5/29) | 746/841 | A is 2x²+z²+u² = 11/29 on the long coroot and ⅔y²+3z²+u²/3 = 5/29 on the short one, which is L263's SO(4) |
| (0.3387527, 0.3119786, 0.1091570, 0.1052897) | 0.8954396, degree 6 | x has minimal polynomial of degree 6: x⁶ − 910/51 x⁵ + 637/6 x⁴ − … |

**End-to-end check on my own g₂.** All four C satisfy C#C = C to 7e-16 and are positive definite, with smallest eigenvalues ¼, 3/28, 5/29 and 0.1053. As a screen, the top eigenvalues on C⊥ in Sym²g₂ are 0.41667, 0.56610, 0.53571 and 0.53611, which reproduces the note's stability column.

## Item 6

- The note labels the trivial-stabiliser type as screened only and states that its exact exclusion is the full enumeration, which waits. It labels the stability values as screen output and says U_s' does not need them. It frames the claim as U_s' on the torus family. I found no overreach.
- The 409-solution count of the full system was not reproduced, since it is out of scope by the brief.
- **Correction 1 (cosmetic).** The fourth solution's norm is 0.8954396. The exact table's 0.895439 is truncated and the screen table's 0.895440 is rounded. Write 0.895440 in both places.
- **Correction 2 (wording).** "Every positive-definite torus-invariant idempotent with a nontrivial stabiliser is one of these four" should read "is Weyl-conjugate to one of these four". The SO(4) solution and the new one each have three conjugates, one per reflection. The 53 count is with multiplicity, and the note could say so.

# Review r228 -- Gate 2, the moment bound (claims 1 and 2)

Reviewer 228. Commits under review: 700c34c, d617153, 42f09c7, 73a74d2. Primary file: [scripts/runs/run_second_kind_moment.py](../scripts/runs/run_second_kind_moment.py). Claims 3-5 go to r229.

Scripts: [scripts/reviewers/r228/](../scripts/reviewers/r228/).

## Verdict table

| # | Claim | Verdict |
|---|---|---|
| 1 | p_1(omega) = 0 and p_2(omega) = 3/4 are pinned | **UPHELD, and stronger than stated** |
| 2 | Two-atom extremal, p_3^min = 9/(16mN) - 3m/4 | **UPHELD -- and it has a two-line proof the file does not give** |
| -- | Side finding A: the sign of p_3(omega) at the extremiser | **REFUTED -- the file's sign is flipped** |
| -- | Side finding B: "m ACTUAL = 0.0674", "cap loose by a factor of twenty" | **REFUTED -- the cap is ATTAINED, exactly** |

## Claim 1 -- the pinned moments. UPHELD, and the file undersells it.

**The identity is Bianchi's, not the sphere product's.** Re-derived here from the definitions rather than quoted. The second-kind operator on Sym^2 has symmetrised kernel A_{ijkl} = (1/2)(R_{ikjl} + R_{iljk}), for which tr A = sum_{ij} A_{ijij} and tr A^2 = sum_{ijkl} A_{ijkl}A_{klij}. Write a = |R|^2, b = R_{ijkl}R_{iklj}, c = R_{ijkl}R_{iljk}. The first Bianchi identity contracted against R gives a + b + c = 0, and the pair symmetries give b = c, hence b = c = -a/2. Then sum_{ijkl} R_{ikjl}R_{iljk} = -R_{pqrs}R_{psqr} = -c = +a/2, so

    tr(Wring^2) = (1/4)[ a + 2(a/2) + a ] = (3/4)|R|^2,

for **every** algebraic curvature tensor. Ricci-flatness is not used, and no symmetry of the point is used. Ricci-flatness enters only in splitting off the g-direction: Wring g = -Ric, so on Sym^2_0 the value is (3/4)|R|^2 minus the g-eigenvalue squared, which at Einstein is (n-1)^2 lambdabar^2 -- exactly the correction term the stored second-kind references carry, and it vanishes at Ricci-flat. Similarly tr(Wring) = -(1/2) sum_{ij} R_{ijij}, zero for a Weyl tensor.

**The symmetric-catalogue trap does not bite.** [r228_claim1.py](../scripts/reviewers/r228/r228_claim1.py) measures p_1 and p_2 through this repo's own `ring_matrix` convention (W_{iklj}, Li arXiv:2112.08465 eq. 2.2) at points chosen to lack the balanced product's symmetry. Every one returns p_2 = 0.750000000 and p_1 = 0 to 7e-16:

| point | p_2(Sym^2_0) at |W| = 1 |
|---|---|
| S^3xS^3, S^4xS^4, S^6xS^6 balanced | 0.750000000 |
| S^2xS^4, S^3xS^5, S^2xS^6, S^4xS^8 unbalanced | 0.750000000 |
| padded CP^2, n = 6, 8, 12 | 0.750000000 |
| random Weyl tensors, n = 5..9, 3 each | 0.750000000 |

**Planted violations, all three fire.**

- Keep the Ricci part (a non-Ricci-flat algebraic curvature tensor): p_1 = +0.0085 nonzero and p_2(Sym^2_0) = 0.697497, while p_2 on the **full** Sym^2 stays at 0.750000 -- which is the derivation's prediction, and it locates the correction in the g-direction exactly where the references put it.
- Break the first Bianchi identity (residual 0.113): p_2(Sym^2) drops to 0.661870. So the check is sensitive to the one hypothesis the derivation uses.
- Use the wrong normalisation (|M|_F = 1 rather than |W| = 1): p_2 = 3.000000. **This is the live hazard and it is not academic -- see side finding B.**

**Convention check.** The repo's `ring_matrix` uses (Wring h)_{ij} = W_{iklj}h_{kl}, the negative of the standard R̊ = R_{ikjl}h_{kl}. Both p_1 and p_2 are insensitive to that sign; p_3 is not.

## Claim 2 -- the closed form. UPHELD. Nothing beats it, and the justification given for it is wrong in a way that does not matter.

[r228_claim2.py](../scripts/reviewers/r228/r228_claim2.py), run for a general second moment c so the normalisation cannot hide inside it.

**The algebra is exact.** Solving the two equations symbolically gives a = km/(N-k), then k = Nc/(Nm^2 + c), r = k/(N-k) = c/(Nm^2), and

    p_3^min(m, N) = c^2/(Nm) - cm,

which at c = 3/4 is 9/(16mN) - 3m/4, difference from the file's expression identically 0. The file's alternative form N m^3 r(r-1) also matches identically. d/dm = -3/4 - 9/(16Nm^2) < 0, so p_3^min decreases in m and taking the cap is the weakest valid member of the family -- the file is right about that.

**The two-atom structure is right, but the file's reason for it is not.** The file says "with two equality constraints an extremal point of the moment body takes at most two distinct values". There are **three** constraints once the mass is counted, and the correct count admits three values {-m, y, z}; the KKT conditions of the raw problem give exactly that -- the boundary value plus the two roots of 3x^2 - 2*beta*x - alpha = 0. What actually forces two atoms is Krein-Markov: on the half-line [-m, infinity) the minimising principal representation for the third moment puts one atom at the finite endpoint and one free, and the parameter count against three moment equations is then exact. Verified by exhaustive sweep over the three-atom family (m, N) = (0.6742, 77), (1.3484, 77), (0.3, 30), (0.9, 12), (0.12, 200): the best three-atom value is above the two-atom value at every one, approaching it from above as the third atom merges.

**Better: the bound has a certificate, and the certificate needs no extremal structure at all.** For any t >= -m,

    q(t) = (t + m)(t - s/m)^2 >= 0.

Integrate against the empirical measure with mass 1, mean 0 and second moment s = c/N. The linear term integrates to zero, and what survives is

    0 <= int q = int t^3 + (m - 2s/m)s + s^2/m,   i.e.   int t^3 >= s^2/m - ms,

hence P_3 = N int t^3 >= c^2/(Nm) - cm, with equality exactly when the measure sits on {-m, c/(Nm)}. Confirmed symbolically. **This proves the file's bound in two lines, makes the two-atom claim a corollary rather than a premise, and makes the file's "k is not required to be an integer" paragraph unnecessary** -- the inequality is stated over arbitrary real N-tuples from the start.

**Nothing beats the bound.**

| test | result |
|---|---|
| exhaustive three-atom sweep, 5 (m, N) pairs | slack +1.7e-05 to +2.0e-03, never negative |
| SLSQP on the raw N-variable problem, 40 starts, 4 (m, N) pairs | best minus bound = +8.3e-03 to +3.7e-01, never negative |
| 20000 random feasible configurations at (0.6742, 77) | bound survives |

**Planted violations fire.** Allowing one entry below -m gives p_3 = -0.6368 against the bound -0.4948 -- broken, as it must be. Feeding a second moment of 3 (the |M|_F = 1 normalisation) against the c = 3/4 bound gives -1.8483 against -0.4948 -- broken, and it lands correctly above the matching c = 3 bound of -1.8492. **This second planted violation is the one the file itself walks into: it pairs c = 3/4 with an m quoted in |M|_F = 1 units.**

**The relaxation direction is as claimed.** The relaxed feasible set contains every N-tuple's empirical measure, so the relaxed minimum is a lower bound for the integer problem. Measured, the relaxation is not free: at (m, N) = (1.3484, 77) the true discrete minimum is -0.6368 while the relaxed closed form is -1.0059, because at large m the binding constraint is that the boundary atom must carry at least one whole entry rather than the support bound.

## Side finding A -- p_3(omega) at the extremiser has the OPPOSITE sign to the file's table

In this repo's own convention, at |W| = 1, measured through `ring_matrix`:

| n | file's p_3(omega) | measured here |
|---|---|---|
| 12 | +0.300581 | **-0.300581** |

and the closed-form omega-spectrum already on the record ([findings/bispectral.md](../findings/bispectral.md)) agrees with the measurement, not the file: with eigenvalues 6A (x40), -5A (x36), -60A (x1) at n = 12, A = 1/(6 sqrt 55), one gets p_3 = -211860 A^3 = -2.4046 at the |M|_F = 1 normalisation, i.e. -0.30058 at |W| = 1. It also closes the bi-spectral identity with the right sign: (3/2)(0.022473) - (1/2)(-2.4046) = 1.23603 = theta_0(12) exactly. With the file's +0.30058 the identity misses theta_0 by 2.4.

So the headline "p_3(omega) IS POSITIVE at the extremiser ... the bound has the wrong sign" is **false**. The bound and the measurement have the same sign, and the bound holds.

## Side finding B -- the "factor of twenty" is a units error, reconstructed exactly

The record **proves** ([findings/bispectral.md](../findings/bispectral.md), reviewer 131) that mu = -min omega equals n theta_0(n)/(n-1) *identically in m* at the balanced product S^m x S^m, and this reviewer reconfirms it numerically at n = 6, 8, 12. So the projection-estimate cap is **attained**, with zero slack, at exactly the point the file calls it loose by twenty.

The file's "m ACTUAL" column is the true mu divided by (n-2), and compared against a cap quoted in the *other* normalisation:

| n | cap, |M|_F = 1 | true mu, |W| = 1 (= cap/2) | mu/(n-2) | file's "m ACTUAL" |
|---|---|---|---|---|
| 12 | 1.348400 | 0.674200 | 0.067420 | 0.067420 |
| 14 | 1.358732 | 0.679366 | 0.056614 | 0.056614 |
| 16 | 1.366260 | 0.683130 | 0.048795 | 0.048795 |
| 24 | 1.383128 | 0.691564 | 0.031435 | 0.031435 |

Four-for-four to six decimals. The "factor of twenty" is (a factor 2 from |M|_F = 1 versus |W| = 1) times (a spurious division by (n-2)), and it is not a factor of twenty at all -- at n = 24 the same two errors would read as a factor of 44.

## What the two claims, taken together, do to the refutation

Claims 1 and 2 are both sound, so the bound is a theorem. Re-measuring it at the extremiser **in one consistent normalisation**, with the true m (which equals the cap) and the true sign of p_3(omega), gives a completely different picture from the file's table. Section 6 of [r228_claim2.py](../scripts/reviewers/r228/r228_claim2.py), at |W| = 1, N = n(n+1)/2 - 1, m = mu = cap:

| n | p_3(omega) actual | p_3^min | bound holds | p_3/p_3^min |
|---|---|---|---|---|
| 12 | -0.300581 | -0.494815 | yes | 0.6075 |
| 14 | -0.309354 | -0.501563 | yes | 0.6168 |
| 16 | -0.315643 | -0.506248 | yes | 0.6235 |
| 24 | -0.329410 | -0.515953 | yes | 0.6384 |
| 40 | -0.339578 | -0.522503 | yes | 0.6499 |
| 100 | -0.348138 | -0.527486 | yes | 0.6600 |

Three corrections to the recorded refutation follow, and they point in opposite directions.

- **The bound does not have the wrong sign.** It holds at the extremiser at every n, with a loss factor of 1.65 rather than a sign error.
- **The cap on m is not loose.** It is attained exactly at the balanced product; the recorded factor of twenty is the units error reconstructed above.
- **The loss does not grow with n.** p_3/p_3^min rises from 0.6075 at n = 12 to 0.6600 at n = 100, so the bound gets relatively *tighter*, which is the opposite of the direction the file says decides the matter.

**But the route still does not close, and the honest reason is a different one.** In the |M|_F = 1 units the identity uses, the bound delivers theta <= (3/2)p_3(nu) + 1.979 at n = 12 while theta_0(12) = 1.236, so it overshoots by +0.777 at the extremiser; at n = 24 by +0.746 and at n = 100 by +0.717. The overshoot is roughly constant in n rather than growing. So the file's conclusion "the derivation's margin was measured and found wanting" survives, and its *number* and its *diagnosis* do not: the deficit is a fixed ~0.75 in theta, it comes from the moment problem's own slack rather than from a loose cap, and it is not something a sharper bound on m could repair, because m is already sharp at the point that decides the conjecture.

**Recommended repair to [scripts/runs/run_second_kind_moment.py](../scripts/runs/run_second_kind_moment.py)** (not applied here -- files under review are not edited):

1. State the normalisation once, at the top. Either p_2 = 3/4 with m <= n theta_0(n)/(2(n-1)), or p_2 = 3 with m <= n theta_0(n)/(n-1). The file currently pairs the first with the second.
2. Replace the whole "MEASURED AT THE EXTREMISER" block: the sign is wrong, the m column is wrong, all four ratios are wrong, and the n-trend is backwards.
3. Replace the two-atom assertion with the certificate q(t) = (t+m)(t - s/m)^2 >= 0, which is shorter than the paragraph it replaces and removes the need for both the extremal-structure claim and the integer-relaxation remark.
4. The `assert lo < 0` in the script fires only for m below sqrt(3/(4N)) = 0.0987 at n = 12, while the m it is evaluated at is 1.3484 -- fourteen times the threshold. It is a check that cannot fire at the values in play. Worth noting that the file's own erroneous "m ACTUAL" of 0.0674 sits *below* that threshold, so had the assert been run at the number the file reports as the truth, it would have failed.

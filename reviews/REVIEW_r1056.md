# Review r1056: the pinned-class LP obstruction to the (30,20,16) spectrum at n=12

Reviewer r1056, attacking commit `6e7de0a1`. Log: [agent_logs/r1056-i24a.log](../agent_logs/r1056-i24a.log). Worked from the definitions in the brief and from an encoder written here, without reading the record's justification and without importing [scripts/misc/i24a_pinned_lp.py](../scripts/misc/i24a_pinned_lp.py).

| claim | verdict |
|---|---|
| Claim 1: max theta over the LP at (30,20,16) is 0.9242643, so the spectrum is not realisable at theta >= theta_0(12) | **CONFIRMED**, and strengthened to an exact rational statement with a Farkas certificate |
| Claim 2: post F43 stands, and the gap 1.2917 vs 0.9242643 measures what the cross-row system adds | **CONFIRMED** on the logic, with one wording correction: the gap lower-bounds rather than measures |
| Attack 1: LP is a valid relaxation, converse unused | clean |
| Attack 2: ordered-vs-unordered coefficients in (A), (B), (C) | all three correct as the script has them |
| Attack 3: no constraint added that a genuine T need not satisfy | clean |
| Attack 4: theta free, maximum attained | clean, and attainment is provable rather than assumed |
| Attack 5: logical form of the inference | valid, quantifiers correct |
| Attack 6: damage to post F43 | none |
| Attack 7: vacuity | **the attack fails decisively**: on two realisable n=12 spectra the LP returns the true theta exactly |

## 1. The coefficients, re-derived (attack 2)

T is totally symmetric and the sums run over ordered pairs (b,c) with b, c distinct from each other and from a. For a fixed unordered triple {a,b,c} the two orderings (b,c) and (c,b) both occur, so the coefficient of the single variable T_{abc} in row a is the sum of the two ordered contributions.

| relation | ordered contributions | coefficient of T_{abc} in row a | script |
|---|---|---|---|
| (A) | 1 + 1 | **2** | 2, correct |
| (B) | lambda_b + lambda_c | **lambda_b + lambda_c** | lambda_b + lambda_c, correct |
| (C) | lambda_b lambda_c + lambda_c lambda_b | **2 lambda_b lambda_c** | 2\*lambda_b\*lambda_c, correct |

No factor of two is misplaced. Three independent confirmations that the convention is the intended one:

- Summing (A) over a gives sum over unordered triples of T = N(n-2)/3 = binom(n,3) = 220 at n = 12, which is exactly the count of "triangles" {(ij),(jk),(ik)} in so(12) with the structure constants normalised so that c = ±1 on a triangle. That normalisation is forced by (A) itself, since row a of (A) counts 2(n-2) ordered triangle pairs.
- Summing (B) over a returns 0 = -2 tr W, consistent with the tracelessness of the candidate, and summing lambda_a times (A) returns the same identity.
- Building the genuine T of a product-of-spheres Weyl operator (section 5) and feeding it into the encoder gives a residual of 2.7e-15 on all 198 rows, which would be impossible under any other coefficient convention.

The setting decodes as follows, which is worth recording because it makes the relations checkable rather than quoted: W_n is the space of Ricci-flat algebraic curvature operators on R^n (Weyl operators), Q(W) = W^2 + W^# is Hamilton's cubic with W^#_{aa} = (1/2) sum_{c,d} T_{acd} lambda_c lambda_d, relation (A) is the so(n) Casimir value 2(n-2), relation (B) at index a = (ij) reads Ric_ii + Ric_jj - 2 R_ijij = -2 R_ijij, which is precisely Ricci-flatness, and relation (C) is the diagonal of Q(W) = theta W.

## 2. The relaxation is valid and the converse is unused (attacks 1, 3, 5)

Necessity holds in the right direction. If W in W_12 is unit-norm and theta-critical with the given spectrum, pick any real orthonormal eigenbasis (one exists because W is a real symmetric endomorphism of so(12)) and set T_abc = c_abc^2. Then T >= 0, T is totally symmetric, T vanishes on repeated indices because c_aab = <[v_a,v_a], v_b> = 0, and (A), (B), (C) hold at every index at that theta. So (T, theta) is LP-feasible and theta <= max_LP. The contrapositive is the claim. The converse, that an LP-feasible T comes from a genuine W, is nowhere used and would be false: the LP drops the Jacobi identity, drops the requirement that c be a Lie-algebra structure-constant array at all, and drops every relation beyond the three per-index ones.

The dangerous direction, an accidentally added constraint, is clean:

- **Indexing by unordered distinct triples is exactly right.** Every nonnegative function on unordered triples of distinct indices extends uniquely to a totally symmetric array vanishing on repeats, and repeated-index entries never appear in any of the three sums because b, c are constrained distinct from each other and from a. Nothing is lost and nothing is imposed.
- **Nonnegativity is genuine**, not an added convenience, because T is a square of a real number in a real eigenbasis.
- **(A)'s right-hand side 2(n-2) is basis-independent** (it is the Casimir quadratic form evaluated on a unit vector), so it holds for every eigenbasis, including every choice inside a degenerate eigenspace.
- **Degeneracy is handled correctly.** With multiplicities 30, 20 and 16 the eigenbasis is far from unique, but every admissible choice yields a feasible T, so LP-feasibility remains necessary. The LP also fixes which index carries which eigenvalue, and any two such assignments differ by a permutation of 1..66 that carries feasible points to feasible points, so no generality is lost.

On attack 4, theta enters only through the right-hand side 2 lambda_a (theta - lambda_a) of (C), so the problem is an LP in (T, theta) with theta unrestricted in sign, which is correct. Attainment is provable rather than assumed: (A) plus T >= 0 forces 0 <= T_abc <= 2(n-2) = 20, so the T-polytope is compact, and row a of (C) with lambda_a nonzero expresses theta as a continuous function of T, so the feasible set in (T, theta) is compact and the supremum is a maximum. The feasible theta-set is an interval, as the projection of a convex set must be, and here it is [-77/15, 74239/10280] in the units of section 3.

The inference in attack 5 has the form: for all W (W in W_12 and unit-norm and theta-critical and spec W = S) implies (there exists T, (T, theta) LP-feasible), hence theta <= 0.9242643. Contrapositive: theta > 0.9242643 implies no such W. Since theta_0(12) = 1.2360331 > 0.9242643, no such W exists at theta_0(12) or above. The quantifiers are in order, and the claim correctly refrains from asserting that the spectrum *is* realisable below 0.9242643.

## 3. The number, made exact (claim 1)

An independently written encoder returns max theta = 0.9242642699937841 on the candidate, which rounds to the reported 0.9242643.

The LP carries a symmetry group S_30 x S_20 x S_16, since every constraint coefficient depends on an index only through its eigenvalue class. Averaging an optimum over that group preserves feasibility and the objective, so the maximum is attained at a class-constant T, and the LP reduces to **10 variables and 9 equalities**. The reduced LP returns the same value. Writing lambda = m mu with mu in {-1, 6/5, 3/8} and tau = theta/m, the factor m cancels from all three relations and the reduced system is rational. Solving it exactly over Q on the optimal support gives

**tau = 74239/10280**, attained at T = (347/29812, 47/14906, 7/9766, 53/3855, 71/19532, 251/19532) on the class-triples (1,1,2), (1,1,3), (1,2,2), (1,3,3), (2,2,2), (2,2,3), with residual exactly 0 on all nine rows.

Since m^2 = 20/1221, this gives **theta^2 = 501039011/586515120 = 0.854264440787136**, so theta = 0.92426426999378, against **theta_0(12)^2 = 55/36**. The inequality 501039011/586515120 < 55/36 is a rational comparison, so the conclusion is exact and floating point plays no part in it.

A **Farkas dual for the full 45,760-variable LP** was extracted and verified over Q. It is class-constant, hence carried by nine rationals, listed as (y_A, y_B, y_C) on classes (1, 2, 3):

y_A = (21/41120, 2241/102800, 1089/328960), y_B = (-1267/41120, -1659/41120, 0), y_C = (97/3084, 19/1028, 0).

Taking that weighted sum of the 198 relations produces an identity whose left side is tau plus a nonnegative combination of the T variables (the minimum of the 45,760 column coefficients is exactly 0, and the tau coefficient is exactly 1) and whose right side is exactly 74239/10280. So tau <= 74239/10280 for every feasible point, by one weighted sum of the hypotheses and nothing more.

## 4. Vacuity, the decisive test (attack 7)

The attack fails, and it fails by a wide margin. Two Weyl operators of Einstein products of round spheres were built explicitly on Lambda^2 R^12, together with the so(12) structure constants in the E_ij basis, and both were verified to be **full** theta-critical unit-norm elements of W_12: the off-diagonal part of Q(W) - theta W is exactly zero, so criticality is not merely inferred from the diagonal relation (C).

| object | spectrum (multiplicities) | true theta | LP max theta at that spectrum |
|---|---|---|---|
| Weyl of S^6 x S^6 | 6 (30), -5 (36), scaled to unit norm | **1.2360330812 = theta_0(12) exactly** | 1.2360330812 |
| Weyl of S^5 x S^7 | 21 (10), 10 (21), -12 (35), scaled to unit norm | **1.2282391577** | 1.2282391577 |
| candidate under review | -1 (30), 6/5 (20), 3/8 (16), scaled to unit norm | none, by this result | 0.9242642700 |

Three points follow.

- **The LP is not generically small.** On a realisable spectrum it returns a value at or just below theta_0(12), not a value near 0.92.
- **The LP is tight on both controls**, returning the true critical theta exactly rather than a loose upper bound. It is therefore doing real work, and on these two points it loses nothing at all.
- **The comparison is like for like.** The S^5 x S^7 control has three distinct eigenvalues, the same regime as the candidate and the same regime post F43 speaks about, so the low value at (30,20,16) cannot be blamed on eigenvalue multiplicity structure.

For the S^5 x S^7 row the LP lower bound needs no solver at all: the genuine T, which is 1 on each so(12) triangle and 0 elsewhere, satisfies all 198 relations at theta = 1.2282391577 by direct substitution, so LP-feasibility at that theta is an exhibited witness rather than a computed optimum.

Two by-products worth keeping. First, **the Weyl operator of S^6 x S^6 attains theta_0(12) exactly**, which identifies the extremal object behind theta_0(n) = sqrt(2(n-1)(n-2))/n at n = 12 and gives the threshold conjecture a sharp case. Second, combining (C) with tracelessness and unit norm gives a closed form for theta on any critical point,

theta = sum_a lambda_a^3 + 3 sum over unordered triples of lambda_x lambda_y lambda_z T_xyz,

obtained by weighting row a of (C) by lambda_a and summing. It reproduces theta_0(12) from the S^6 x S^6 data by hand and reduces the whole LP objective to a linear functional of T.

## 5. Post F43 (claim 2, attack 6)

The claim is correct on its logic. A per-row condition is a necessary condition extracted from the relations at a single index, and the argument of post F43 is an exhibition: the spectrum satisfies every such condition at theta = 1.2917 > theta_0(12), so no member of that family excludes theta = 1.2917, and therefore no member forces theta <= theta_0(n) at three or more distinct eigenvalues. Realisability is a property of the *global* object, expressed in the LP by the single array T serving all 66 rows at once. A per-row argument never sees that coupling, so the witness discharges its duty without ever needing to exist as a curvature operator. The unrealisability does **no** damage to post F43's conclusion.

Two corrections.

- **"Measures" overstates it, and should read "lower-bounds".** The value 1.2917 is a theta at which the spectrum passes every per-row condition, which makes it a feasible value for the per-row family rather than that family's maximum. Unless 1.2917 was itself computed as the per-row maximum, the correct statement is that the cross-row system improves on the per-row family by at least a factor 1.2917/0.9242643 = 1.3975 on this point. If 1.2917 is a per-row optimum, say so at the point of use and "measures" becomes correct as written. The arithmetic of the stated factor is right.
- **The last sentence of claim 1 conflates two kinds of obstruction.** "The record's only recorded obstruction to a theta_0(n) threshold at n >= 12 is removed" is true only of an obstruction to the *statement*, that is, of a candidate counterexample. Post F43 is an obstruction to a *method*, and it stands, so the per-row route to proving the threshold remains closed. The two sentences are compatible on that reading and contradictory on any other, so the distinction belongs in the text. Whether it is the record's *only* such obstruction was not checked here, since checking it would require reading the record for the claim's own justification.

Note also what is not established. The result rules the spectrum out above 0.9242643 and says nothing about whether it is realisable at or below that value, and the LP being tight on two controls does not make it tight in general, so 0.9242643 is an upper bound on any theta this spectrum could carry rather than a value it attains.

## 6. Lean

A dual certificate does make the first row typable, and after the work above the certificate is small.

| row | status |
|---|---|
| max theta = 0.9242643 at (30,20,16) | typable now. The statement to prove is the upper bound alone, and it needs no LP theory: for T : Fin 66 -> Fin 66 -> Fin 66 -> Q with T >= 0 satisfying the 198 relations with parameter tau, the weighted sum of those relations with the nine rationals of section 3 yields tau + (nonnegative combination of the T entries) = 74239/10280, hence tau <= 74239/10280. Since A^T y depends on a triple only through its class multiset, the 45,760 sign checks collapse to 10 rational inequalities, all `norm_num`-sized. Matching equality needs the primal witness of section 3, also rational. |
| (30,20,16) is not realisable at theta >= theta_0(12) | typable as the contrapositive, plus the rational comparison 501039011/586515120 < 55/36 and the bridge lemma that a critical W yields a feasible T, which is the only part carrying mathematical content rather than arithmetic. |
| post F43 stands | agreed, no declaration can exist. It quantifies over a family of arguments, not over objects. |

The one thing the certificate cannot supply is the bridge lemma. Everything downstream of "a theta-critical unit W with this spectrum yields a nonnegative T satisfying (A), (B), (C) at every index" is rational arithmetic that the kernel can check outright.

## 7. Verdicts

- **Claim 1: CONFIRMED.** The relaxation is valid, the coefficients are right, nothing is added to the constraint set, theta is free, the maximum is attained, the inference is sound, and the value is now exact: theta_max^2 = 501039011/586515120 < 55/36 = theta_0(12)^2, with a verified Farkas certificate. Correct the final sentence to say that a candidate counterexample is removed while the per-row route remains closed.
- **Claim 2: CONFIRMED**, with "measures" replaced by "lower-bounds by a factor 1.3975" unless 1.2917 is independently a per-row maximum.

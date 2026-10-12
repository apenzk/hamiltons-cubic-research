# REVIEW r1225: Batch 34 (Lemma D, U's general form, the CP obstacle)

Log: agent_logs/r1225.log. Block audited: reviews/2026-09-26-I73-class-ceiling.md, section "Batch 34". Screen script: seconds at n = 5, objects constructed for the check (random positive a, random PSD C), reported as a screen.

| claim | verdict |
|---|---|
| C1 Lemma D | CONFIRMED (one unstated link, closed below) |
| C2 U's general form | CONFIRMED (the equivalence is in fact an identity) |
| C3 CP reading and obstacle | REFUTED as worded: the CP reading holds, "E acts as Delta" is false, and the obstacle is misidentified |

## C1 Lemma D: CONFIRMED

- Constant. In the coordinate basis C b_alpha = a_alpha b_alpha, so <(C#C)h,h'> = (1/2) sum a_alpha a_beta <[b_alpha,b_beta],h><[b_alpha,b_beta],h'>. Each bracket is 0 or a single plus/minus coordinate element, so the form is diagonal. For h = e_ik the contributing ordered pairs are ({i,j},{j,k}) and ({j,k},{i,j}) for j distinct from i, k, giving (1/2)(2 sum_j a_ij a_jk) = (W^2)_ik. At a = 1 this returns n - 2 = c, consistent with I#I = (n-2)I. Screen: exact match at random positive a.
- C#C = C reads (W^2)_ik = a_ik for i distinct from k, that is W^2 = W + Delta with Delta_ii = (W^2)_ii = sum_j a_ij^2. Holds.
- Perron-Frobenius: W symmetric, nonnegative, off-diagonal entries positive, n >= 3, hence irreducible (indeed primitive, W^2 has positive diagonal). Simple Perron root rho, eigenvector v > 0. Holds.
- Delta_ii v_i = (rho^2 - rho) v_i with v_i > 0 gives Delta = delta I, delta = rho^2 - rho. This is the Lean theorem delta_scalar, whose hypotheses match the prose.
- Unstated link: the block asserts that rho is simple AND distinct from 1 - rho without saying why they differ. It is closed because delta = Delta_ii = sum_j a_ij^2 > 0, so rho^2 - rho > 0 and rho > 1, hence 1 - rho < 0 < rho. The case rho = 1/2 (the brief's question) therefore never arises. Every eigenvalue of W is a root of x^2 - x - delta, so W = rho vv^T + (1 - rho)(I - vv^T) = (1 - rho)I + (2 rho - 1)vv^T. Holds.
- Zero diagonal: (1 - rho) + (2 rho - 1)v_i^2 = 0 gives v_i^2 = (rho - 1)/(2 rho - 1), constant, so v = 1/sqrt(n), rho = (n-1)/(n-2), W = (J - I)/(n-2). Back-substitution: delta = (n-1)/(n-2)^2 = rho(rho - 1) and sum_j a_ij^2 = (n-1)/(n-2)^2. Consistent.
- Scope: the conclusion covers positive-definite coordinate-diagonal C only, as stated. PSD coordinate-diagonal C with some a_ik = 0 (possibly reducible W) is outside it.
- Recommendation: add one clause, "rho > 1 since delta = sum_j a_ij^2 > 0, so 1 - rho differs from rho".

## C2 U's general form: CONFIRMED

- v_i v_j = A_ij + S_ij with A_ji = -A_ij, S_ji = S_ij. In sum_{i,j} lambda_i lambda_j (A_ij + S_ij)(x)(A_ij + S_ij) the cross terms A(x)S and S(x)A are odd under i <-> j and cancel. Holds.
- Skew part: sum lambda_i lambda_j A_ij(x)A_ij = (1/4) sum lambda_i lambda_j [v_i,v_j](x)[v_i,v_j]. In the eigenbasis of C, (C#C)_ab = (1/2) sum lambda_i lambda_j <[v_i,v_j],e_a><[v_i,v_j],e_b>, so iota(C#C) = (1/2) sum lambda_i lambda_j [v_i,v_j](x)[v_i,v_j], and the skew part is (1/2)iota(C#C). Holds for every symmetric C, any signs of lambda.
- iota is injective (the E_a(x)E_b are independent), so C#C = C iff Z^2 = Z/2 + E. Holds.
- Gamma: (E_a(x)E_b)^Gamma = -E_a(x)E_b, and S symmetric gives E^Gamma = E. Stronger than the block states: applying Gamma to the unconditional identity Z^2 = (1/2)iota(C#C) + E gives Z^2 - (Z^2)^Gamma = iota(C#C) for EVERY symmetric C, so the fixed-point equation Z = Z^2 - (Z^2)^Gamma is C#C = C verbatim, and the "equivalence" needs no argument.
- Screen at a random PSD C (n = 5): Z^2 = iota(C#C)/2 + E, Z^Gamma = -Z, E^Gamma = E, Z^2 - (Z^2)^Gamma = iota(C#C), and iota(I)/(n-2) solves the fixed-point equation. All exact to rounding.

## C3 CP reading and obstacle: REFUTED as worded

What holds:
- With Phi_X(Psi) = sum_r A_r Psi B_r^T for X = sum_r A_r(x)B_r, Phi_Z(Psi) = sum lambda_i v_i Psi v_i^T and Phi_E(Psi) = sum lambda_i lambda_j S_ij Psi S_ij, both completely positive for C PSD. The assignment X -> Phi_X is an algebra homomorphism ((A(x)B)(A'(x)B') = AA'(x)BB' maps to composition), so Z^2 = Z/2 + E is Phi_Z o Phi_Z = Phi_Z/2 + Phi_E. Screen confirms.
- Convention caveat: "Choi form" is right only up to realignment. Z as an operator on R^n(x)R^n is indefinite (screen: min eigenvalue -2.53 at a random PSD C), while the standard Choi matrix of Phi_Z is PSD. The block should name the correspondence X -> Phi_X.
- The obstacle's eigen-equation is correct: Phi_E(Psi_0) = (rho^2 - rho/2)Psi_0 at a Perron eigenmatrix of Phi_Z.

What fails:
- "Lemma D is the case ... where E acts as Delta" is false. On diagonal matrices Phi_Z acts as W and Phi_E acts as (W^2 + Delta)/2, which at an idempotent is W/2 + Delta. Derivation: S for alpha = beta = {i,k} is -(E_ii + E_kk), contributing Delta_ii psi_i, and S for ({i,j},{j,k}) is plus/minus (E_ik + E_ki)/2, contributing (1/2) sum_k (W^2)_ik psi_k over the off-diagonal part. Witness: n = 5, W = (J - I)/3, where (W^2 + Delta)/2 = W/2 + Delta differs from Delta. Screen confirms Phi_E|diag = (W^2 + Delta)/2 at random positive a and rejects Phi_E|diag = Delta. The analogue of Delta is Phi_E - Phi_Z/2 (= Phi_Z^2 - Phi_Z at an idempotent), not E.
- The obstacle is misidentified. The eigen-equation at Psi_0 is automatic: at any idempotent Phi_E = Phi_Z^2 - Phi_Z/2, so Phi_E Psi_0 = (rho^2 - rho/2)Psi_0 for every eigenmatrix, carrying no information beyond C#C = C. The same was true in Lemma D, where Delta v = (rho^2 - rho)v is equally a consequence of W^2 = W + Delta. The force in Lemma D came from a SECOND, independent description of Delta, namely a multiplication operator diagonal in the basis E_ii with entries sum_j a_ij^2, in which Psi_0 = diag(v) has full positive support. "A basis containing Psi_0" is therefore the wrong mechanism: Psi_0 is a positive combination of the diagonal basis, and diagonal action plus full support is what forces scalarity.
- Corrected statement: the missing ingredient off the coordinate family is an independent structural description of Phi_E - Phi_Z/2 computed from E = sum lambda_i lambda_j S_ij(x)S_ij (the analogue of "Delta is diagonal"), paired with a positivity or full-support property of Psi_0 in the basis where that description is diagonal. Whether such a description exists is open and this review does not decide it. The claim that the eigen-equation "no longer forces" scalarity is true but vacuous, since it forced nothing in Lemma D either.

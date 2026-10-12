# Review r1589: L272 (the Perron root of P + diag d on the torus family)

Log: agent_logs/r1589.log

| claim | verdict | reason in one line |
|---|---|---|
| P1 L272 (1) the matrix form | CONFIRMED | X^2 = P^2 + PD + DP + D^2 with D = diag d, P zero-diagonal: off-diagonal is L271's P equation, diagonal is pi_i + d_i^2, and x = (1/2) 1^T P 1 |
| P2 L272 (2) d_i >= rho - 1, equality off S | CONFIRMED | the correction -2 P o Q o Q is <= 0 since P > abs(Q) >= 0, the Perron row step holds at every row, pi_i + sum_l Q_il^2 = 2 d_i, and (rho - d - 1)(rho + d) <= 0 with rho + d > 0 for any sign of rho - 1 |
| P3 L272 (3) x <= m/2, equality only at I/c | CONFIRMED | Rayleigh at 1 gives m rho >= sum d + 2x. Equality forces every d_i = rho - 1, then pi_i = 2 d_i, so Q = 0 and L271 (3) gives I/c, which has x = m(m-1)/c = m/2 |
| P4 L272 (4) the support of (X - rho)(X + rho - 1) | CONFIRMED | (X - rho)(X + rho - 1) = X^2 - X - (rho^2 - rho) I, whose diagonal vanishes off S by (2) and whose off-diagonal -2 P_ij Q_ij^2 vanishes unless i, j in S, and rank <= abs(S) gives the eigenvalue count |
| P5 L272 what it gives and screens | CONFIRMED WITH A MINOR CORRECTION | q identity and q >= m(rho^2 - rho) hold, threshold rho = 1 + 1/c is exact since (c+1)/c^2 = (2m-1)/c^2. The quoted screen range "1.006 to 1.050" is not the range of all non-uniform solutions: a screen at m = 4 finds a positive non-uniform idempotent with rho = 1.08333 (still below 1 + 1/c = 1.1667) |
| LEAN fidelity | CONFIRMED | all five declarations state what the table says, generically in X, delta, w, with no hypothesis assuming the conclusion. The specialisation to X = P + diag d, delta_i = pi_i + d_i^2 - d_i is prose, as the table records |

Overall: CONFIRMED WITH A MINOR GAP (one prose correction in "What it gives").

## Method

Read the written chain link by link against L271's statement (read in findings/second-order.md, statement only, since the brief's quote was truncated at the system), derived each step by hand, then read the five Lean declarations. One bounded screen (about 20 s at m = 4, a few seconds at m = 5): least-squares solves of L271's P, Q system from 300 and 150 random seeds, keeping solutions with P_ij > abs(Q_ij). At m = 4 every kept solution was rebuilt as an operator on so(8) (Hamilton's product from structure constants, normalised so that I#I = 6I, root planes split by ad h_i ad h_j) and checked directly to satisfy C#C = C and C > 0. The screen is a screen only, and the confirmations rest on the hand derivation.

## P1

With D = diag d and P zero on the diagonal, (PD + DP)_ij = P_ij (d_i + d_j) off the diagonal and 0 on it, (D^2)_ij = d_i^2 delta_ij, (P^2)_ii = sum_l P_il^2 = pi_i. L271's P equation P_ij(1 - d_i - d_j - 2Q_ij^2) = (P^2)_ij rearranges to (P^2)_ij + P_ij(d_i + d_j) = P_ij - 2 P_ij Q_ij^2, so (X^2)_ij = X_ij - 2 (P o Q o Q)_ij for i != j, and (X^2 - X)_ii = pi_i + d_i^2 - d_i. The positive roots are e_i -+ e_j with i < j, so x = sum_{i<j} (U_ij + V_ij) = sum_{i<j} P_ij = (1/2) 1^T P 1.

## P2

X^2 = X + diag(delta) - 2 P o Q o Q with delta_i = pi_i + d_i^2 - d_i (the Hadamard term has zero diagonal). Positive definiteness is P_ij > abs(Q_ij), so P o Q o Q >= 0 entrywise and X^2 <= X + diag(delta), the sign as written. X has diagonal d_i >= 0 and off-diagonal P_ij > 0, so Perron-Frobenius applies: w > 0, Xw = rho w, rho > 0. Row i: rho^2 w_i = (X^2 w)_i <= (Xw)_i + delta_i w_i = (rho + delta_i) w_i, and w_i > 0 gives rho^2 - rho <= delta_i at every row. Since P^2 + Q^2 = 2(U^2 + V^2) entrywise, pi_i + sum_l Q_il^2 = 2 d_i, so pi_i <= 2 d_i and rho^2 - rho <= d_i^2 + d_i. That is (rho - d_i - 1)(rho + d_i) <= 0, and rho + d_i > 0, so d_i >= rho - 1, with no case split on the sign of rho - 1. For i outside S, row i of Q vanishes, so row i of P o Q o Q vanishes and row i of the entrywise bound is an equality, so the Perron step then gives equality rho^2 - rho = delta_i, and pi_i = 2 d_i, so (rho - d_i - 1)(rho + d_i) = 0 and d_i = rho - 1.

## P3

Summing (2), sum d_i >= m(rho - 1). Rayleigh: rho >= 1^T X 1 / m = (sum d_i + 2x)/m. Together 2x <= m. At I/c, mu = 1/c on all m(m-1) positive roots and c = 2(m-1), so x = m/2. Equality 2x = m forces sum d_i = m(rho - 1), so each d_i = rho - 1 (each is >= rho - 1). Then d_i^2 + d_i = rho^2 - rho, and rho^2 - rho <= pi_i + d_i^2 - d_i <= d_i^2 + d_i = rho^2 - rho forces pi_i = 2 d_i, so every row of Q vanishes, Q = 0, and L271 (3) makes C = I/c. The Rayleigh equality is not needed, which is harmless.

## P4

(X - rho)(X + rho - 1) = X^2 - X - (rho^2 - rho) I. Its diagonal is delta_i - (rho^2 - rho), zero off S by the equality in (2). Its off-diagonal is -2 P_ij Q_ij^2, nonzero only if Q_ij != 0, which puts both i and j in S (Q symmetric). So the matrix lives on S x S, has rank at most abs(S), and as f(X) with f(t) = (t - rho)(t + rho - 1) it has eigenvalues f(lambda_k). At least m - abs(S) of them are zero, and f(lambda) = 0 means lambda in {rho, 1 - rho}.

## P5

By L271 (1), q = norm(A)^2 + (1/2) norm(P)^2 + (1/2) norm(Q)^2 with A_ii = d_i, A_ij = -P_ij Q_ij, and (1/2)(norm(P)^2 + norm(Q)^2) = (1/2) sum_i (pi_i + sum_l Q_il^2) = sum d_i, which gives the stated q. From (2) (or directly perron_row with pi_i <= 2 d_i), d_i^2 + d_i >= rho^2 - rho, so q >= m(rho^2 - rho). I/c has q = N/c^2 = m(2m-1)/c^2 and rho = 1 + 1/c (X = (2/c)(J - I) + (1/c) I there). Also rho^2 - rho = (c+1)/c^2 = (2m-1)/c^2 at rho = 1 + 1/c and rho^2 - rho is increasing for rho >= 1/2, so the lower bound reaches I/c's value exactly when rho >= 1 + 1/c.

Screen (reported as a screen). m = 4, so(8): three positive non-uniform idempotents plus I/c, each confirmed as C#C = C, C > 0 on so(8):

| rho | abs(S) | min d - (rho - 1) | x - m/2 | q (direct) = q (formula) |
|---|---|---|---|---|
| 1.01887 | 3 | 0 | -0.525 | 0.8951 |
| 1.08333 | 2 | 0 | -0.279 | 0.8611 |
| 1.01877 | 3 | 0 | -0.526 | 0.8951 |
| 1.16667 = 1 + 1/c (I/c) | 0 | 0 | 0 | 0.7778 = N/c^2 |

m = 5 (system only, not rebuilt on so(10)): non-uniform solutions with rho = 1.00881 and 1.05000, both with d_i = rho - 1 off S and x < m/2. In every case the support claim of (4) held to 1e-15 and the eigenvalue count was met. The qualitative claims hold (rho < 1 + 1/c, min_i d_i = rho - 1, S a proper subset). **Correction:** the parenthetical range "1.006 to 1.050" understates what occurs: the m = 4 solution with rho = 1.08333 (abs(S) = 2, d = 1/12 off S) lies outside it. It is still below 1 + 1/c, so the conclusion drawn is unaffected. Suggested wording: "(1.006 to 1.084 against 1.10 to 1.17)", or scope the range to the solutions the author computed.

## LEAN

- perron_row: w > 0, Xw = rho w, (X*X)_ij <= X_ij + [i = j] delta_i for all i, j, conclusion rho^2 - rho <= delta_i. Exactly the Perron step, and the hypotheses are the ones the prose establishes. Faithful.
- perron_row_eq: same with row-i equality, conclusion equality. Faithful. (The docstring of perron_row mentions the equality case, which lives in perron_row_eq, a cosmetic point.)
- perron_d: d >= 0 and rho^2 - rho <= d^2 + d give rho - 1 <= d. It needs no rho > 0: if rho + d <= 0 then rho <= -d <= 0 <= d + 1. So no hypothesis is hidden. Faithful.
- perron_d_eq: d + rho > 0 and equality give d = rho - 1. Faithful.
- perron_x: m(rho - 1) <= sd and sd + 2x <= m rho give 2x <= m. A linarith step, honestly scoped as the trace step.

None is vacuous: each is a generic lemma instantiable at the torus data (the screen solutions instantiate all of them). The link from these generic statements to X = P + diag d, delta = pi + d^2 - d, and the existence of w is prose, as the table says.

# Gate 2 review 196, the two new checks are the twelfth and thirteenth entries, and the controls that separate them exist

Scope: [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py) as committed at f5105a3, priority as briefed, claim 4 first, then claim 2. Scripts under [scripts/reviewers/r196/](../scripts/reviewers/r196/). Claim 1 is out of scope at this priority and is untouched here; claim 3 is answered in passing, in the bonus row. Everything below is exact: Gaussian-rational arithmetic for the h determinants and minors, and exact linear algebra over F_p with p = 1000000009 and i = sqrt(-1) mod p for the per-weight ranks. A full-rank result mod p is a one-sided certificate of full rank over Q(i), so no rank claim here rests on floating point.

## Verdict table

| # | Claim | Verdict |
|---|---|---|
| 4a | "h must be Hermitian" is a check that can fail | **REFUTED, the twelfth entry.** Hermiticity of h is a theorem about the *form* ip3, true for **any** vectors whatsoever. Control: the shipped code reports `h Hermitian: True` on random garbage, on two coincident copies, and on a linearly dependent triple |
| 4b | "h is the identity nowhere" is a check that can fail | **REFUTED, worse than vacuous.** It passes on all the same garbage, and its *failure* mode is not an error state: h = I would mean the highest-weight vectors came out orthonormal, which is desirable. There is no wrong object it rejects |
| 4c | the squareness check "names the offending weight" | **REFUTED, the thirteenth entry.** The naming is fine; the check is a count, and the count is invariant under every corruption that preserves the number of vectors. Three controls pass it |
| 2 | every weight block is square, the adapted vectors of a weight are a basis | **The mathematical claim is CONFIRMED and is in fact stronger than checked**, all 169 weights square, all 169 per-weight matrices nonsingular over F_p, all 7770 vectors weight-homogeneous. **The shipped check verifies none of that**: it counts |
|, | bonus, claim 3 | **h is corroborated at a second probe.** h(1,1) equals h(0,0) *exactly* on all 12 blocks with m > 1, and every h is positive definite. The normalisation is sound because q00 is real |
|, | bonus | **The docstring still describes four checks that are not in the file.** B Hermitian, the trivial block, rank exactly 14, and rank(A) = rank[A &#124; F_5] appear only in the docstring. The file contains **zero** `assert` statements, `HMAT` is never read after it is printed, and the section headed "factoring the per-weight solve" factors nothing |

---

## Claim 4a, h Hermitian is a property of ip3, not of the adapted basis

### The derivation

H is built as H(a,b) = sum_ijkl T_a conj(T_b) over within-weight pairs, so H(b,a) = conj(H(a,b)). Under FISCHER,

    K(t,s) = sum over sigma in S_3 of prod_i H(t_i, s_sigma(i)).

Conjugating and reindexing sigma -> sigma^{-1} gives conj(K(s,t)) = K(t,s). Then for arbitrary monomial-indexed vectors u, v,

    ip3(u,v) = sum_{a,b} u_a conj(v_b) K(t_a, t_b),   so   conj(ip3(v,u)) = ip3(u,v).

Two consequences, both unconditional in the vectors:

1. `g = ip3(R_i[0], R_j[0])` satisfies g_ij = conj(g_ji) before any normalisation.
2. `q00 = ip3(R_0[0], R_0[0])` is **real**, so the shipped normalisation, which computes g·conj(q00)/|q00|^2, i.e. g/q00, divides by a real scalar and preserves the symmetry exactly.

So `herm` is a compound of "ip3 is a Hermitian form" and "q00 is real", and the second follows from the first. **It contains no information about the vectors it is applied to.** The one way it could report False is a complex q00, which the first consequence forbids.

### The control

[control_h.py](../scripts/reviewers/r196/control_h.py) rebuilds H and sym3_ip from the cache, bypassing the three-trial kappa block that [run_n5_evaluate.py](../scripts/runs/run_n5_evaluate.py) runs at import, and feeds the **verbatim** h-construction of lines 96–114 four known-wrong inputs:

| control | shipped "Hermitian?" | shipped "== I?" | det h | shipped checks |
|---|---|---|---|---|
| three unrelated random vectors | True | False | 10.4163 | **PASS** |
| two copies coincide, u_1 = u_0 | True | False | **0** | **PASS** |
| dependent triple, u_2 = u_0 + u_1 | True | False | **0** | **PASS** |
| mixed-weight junk, m = 4 | True | False | 8.95783 | **PASS** |

The second row is [plan.md](../plan.md)'s seventh vacuous entry (*"equal dimensions do not give a direct sum; two copies could coincide"*), reproduced exactly, and h is the object that detects it. The shipped code computes h and then tests the two properties that cannot see it.

### The control on the real object

[h_real.py](../scripts/reviewers/r196/h_real.py) sets copy 1 := copy 0 of block lambda = (2,2). Because `replay` applies a **fixed** word list, u_1 = u_0 reproduces copy 0 vector by vector, so this realises the coincident-copy failure exactly with no recomputation. Result: shipped "Hermitian" True, shipped "not I" True (**both pass**) and det h = 0.

## Claim 4b, the not-identity check has no error state

h_ij is the Gram of the highest-weight vectors u_i, normalised by |u_0|^2, since `word_list` starts from the empty word and R_i[0] = u_i. The u_i are whatever basis the null-space solve returned. h = I would mean that solve happened to return an orthonormal basis of the multiplicity space. That is a *better* state than the one the file is in, not a broken one, and nothing downstream would be wrong if it obtained. A check whose failure indicates no error cannot be a check.

What h is actually for is settling whether the 41 copies are independent, and that is a determinant. Measured exactly on the real basis, all 12 blocks with m > 1 are positive definite by leading principal minors:

| lambda | m | det h | Hermitian | == I | PD | h(1,1) == h(0,0) |
|---|---|---|---|---|---|---|
| (2,2) | 4 | 0.475413 | True | False | **True** | **True** |
| (4,2) | 4 | 229.32 | True | False | **True** | **True** |
| (3,2) | 3 | 51.0469 | True | False | **True** | **True** |
| (2,0) | 2 | 0.90768 | True | False | **True** | **True** |
| (3,0) | 2 | 0.335238 | True | False | **True** | **True** |
| (2,1) | 2 | 1.58203 | True | False | **True** | **True** |
| (4,0) | 2 | 0.0738237 | True | False | **True** | **True** |
| (3,1) | 2 | 1.08765 | True | False | **True** | **True** |
| (4,1) | 2 | 0.109739 | True | False | **True** | **True** |
| (4,4) | 2 | 0.0677083 | True | False | **True** | **True** |
| (4,3) | 2 | 0.356653 | True | False | **True** | **True** |
| (5,2) | 2 | 0.239258 | True | False | **True** | **True** |

The determinants are printed as floats for reading; the minors are compared as exact Gaussian rationals and every leading minor is a positive rational.

**The last column answers claim 3.** Schur forces `<R_i[t], R_j[s]> = h_ij Q_ts`, so the h read off a second probe must agree. Taking (t,s) = (1,1) reproduces h(0,0) **exactly, as rationals, on every block**. One probe is enough *here*; the shipped code has no right to that, since it never looks at a second one, and the second probe costs one extra call.

## Claim 2, the block counts are right, and the check does not test what the comment claims

### What the check does

    square = all(len(MONS.get(w, [])) == len(COLS[w]) for w in COLS)

with each vector labelled `mwt(max(v))`, the weight of the monomial of largest index in its support. The comment beside it asserts the vectors of a weight **ARE a basis of that weight space**. Being a basis needs three things: homogeneity, the right cardinality, and independence. The check tests cardinality.

### Why the cardinality cannot fail

`replay(u, words)` applies a fixed word list of lowering operators to u, so the weight of R_i[t] is lambda minus a fixed sum of negative roots, **determined by (lambda, words) alone, independent of the vector u_i**. The per-weight counts are therefore the same for every choice of the multiplicity-space basis, correct or not, and their agreement with dim Sym^3_mu is the character identity sum_lambda m_lambda dim V(lambda)_mu = dim Sym^3_mu. Totals close it off: both sides sum to 7770 = C(37,3), so no weight can be missed by the loop's iteration over `COLS` rather than `MONS`.

The only corruption the count sees is one that changes the *number* of vectors, and line 65's `if not v: continue` means that is precisely a vector reduced to zero.

### The controls

[control_square.py](../scripts/reviewers/r196/control_square.py) runs the shipped count and, on the same input, the check the comment's claim actually asserts, the per-weight matrix over F_p, tested for full rank against the monomials of that weight.

| corruption | shipped `square` | non-homogeneous vectors | rank check |
|---|---|---|---|
| true adapted basis | True | 0 | **PASS**, all 169 weights |
| one vector := another of the same weight | **True** | 0 | **FIRES**, weight (0,0) rank 233 of 234 |
| v += v' of another weight, max index preserved | **True** | 1 | **FIRES**, support leaves the weight space |
| copy 1 := copy 0 for lambda = (2,0) | **True** | 0 | **FIRES on 13 weights**, weight (0,0) rank 232 of 234 |
| one vector scaled by 7 | True | 0 | PASS, correctly, this is still a basis |
| one vector zeroed | **False** | 0 | FIRES |

Three known-wrong bases pass the shipped check. The fourth row is the coincident-copy failure again, and it is invisible to the count for the structural reason above. The scaling row is the positive control in the other direction: the rank check does not fire on a change that preserves the basis property.

### What a mismatch would diagnose, the brief's question

Given the argument above, a count mismatch admits exactly two diagnoses:

- a vector that collapsed to zero somewhere in `word_list` or `replay`, dropped by line 65;
- a vector that is not weight-homogeneous *and* whose largest-index monomial sits in a different weight from the bulk, so that `mwt(max(v))` mislabels it.

It can diagnose neither linear dependence nor non-homogeneity that preserves the largest index, the second row of the table is that case, and it slips through with the label untouched.

### The positive result

The claim itself holds, and more than the file asserts. Across all **169** weights, largest space **234**: every block is square, every block is nonsingular over F_p, and **0 of 7770** adapted vectors carry monomials of more than one weight. Homogeneity is tested nowhere in the pipeline; it happens to hold because `lower` maps weight vectors to weight vectors.

## The file against its own docstring

Lines 18–28 head a list "Checks that can fail, run before the solve": B Hermitian at every sample, the trivial block proportional to tr(W^3)^2, rank exactly 14, and consistency rank(A) = rank[A | F_5]. Grepping the file for `B_ij`, `rank`, `F_5`, `sample` and `assert` returns hits in the docstring only. The file builds the basis, measures h, measures supports, counts weights and builds Q, and stops at line 174. `HMAT` is printed and never read again; `COLS` and `MONS` feed only the count; the section announced as "factoring the per-weight solve" performs no factorisation. There are no assertions anywhere, so every check in the file is a print that the run continues past.

Line 30 of that same docstring records that 193 and 194 found exactly this, *"NONE OF THESE WAS IN THE CODE"*. The file has since grown from 64 lines to 174, and the four checks are still absent. What the growth added is the two checks this review refutes.

## Replacements, each one line, each with its control already run

Install in [run_n5_assemble.py](../scripts/runs/run_n5_assemble.py), replacing the two prints:

1. **h nonsingular**, per lambda: exact leading principal minors of `HMAT[lam]`, all positive. Fires on the coincident-copy and dependent-triple controls; closes plan.md's seventh entry, which is still open.
2. **per-weight rank**, per weight: reduce the |MONS[w]| x |COLS[w]| matrix mod a prime p == 1 (mod 4) with i = sqrt(-1), require full rank. Fires on three of the controls above and costs 13 s for all 169 weights.
3. **the second probe**, per lambda with m > 1: recompute h at (t,s) = (1,1) and require exact equality with h(0,0). This is the Schur identity the brief names, and it is the only one of the three that tests the *equivariance* of the basis rather than its independence.

The first two are what turn h and the weight bookkeeping from decoration into the checks the record has been missing since entry seven.

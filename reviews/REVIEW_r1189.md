# Review r1189: where mu_34 is small at n = 12

Log: agent_logs/r1189.log

| Item | Verdict |
|---|---|
| 1 spectrum | CONFIRMED |
| 2 fourteen labels | CONFIRMED (wording: labels, not pairs) |
| 3 cluster count | PLAUSIBLE (conclusion true, cluster argument has the chain gap; repair below) |
| 4 O(sqrt delta) | CONFIRMED with explicit constants, for delta <= 1/60 |

## 1. Spectrum

x = sum s_k e_{2k-1} wedge e_{2k}, so <x,x> = (1/2) tr(x^T x) = sum s_k^2: unit norm is sum s_k^2 = 1. Complexified, x has eigenvalues +-i s_k and so(12) = Lambda^2 C^12, so ad_x has eigenvalues i(+-s_j +- s_k) over j < k (sixty) and 0 from each pair {i s_k, -i s_k} (six). Hence -ad_x^2 has 0 six times and (s_j - s_k)^2, (s_j + s_k)^2 twice each (the signs (+,-) and (-,+) give the same square). 6 + 60 = 66 = dim so(12). Screen: a 66 x 66 matrix at one random unit x matches exactly.

## 2. Fourteen small labels

mu_34 = 0 (six zeros) + the 28 smallest of the sixty. All values are >= 0, so mu_34 < delta makes each of those 28 values < delta. Group the sixty by label (i,j,sign); each label carries exactly two equal entries, so at least 14 labels have value < delta. The claim says "fourteen pairs {i,j}", but its count 2 C(z,2) counts both signs of a pair, so the object counted is the label; the wording should say labels.

## 3. The cluster count

With eps = sqrt(delta), the small labels are the edges of G (|s_i - s_j| < eps) plus the edges of H (s_i + s_j < eps), and H is a subgraph of G. For well-separated clusters the partition table is right: z = 5 gives 20, z = 6 is excluded by norm, one cluster of six gives 15, z = 4 plus a pair gives 13, and everything else is lower.

The gap is the one the brief flags. G is a unit-interval graph, and "near-equal" is not transitive, so clusters are undefined on chains. Counterexample to "every other pattern gives at most 13": s = c + (1.05, .5, .5, .5, .5, 0) eps (normalised) has s_1 - s_6 > eps, so no single eps-cluster exists, and yet 14 labels are small (screen). The configuration sits within 2 eps of equal-angle, so the conclusion survives with a larger constant.

Repair, a threshold argument that needs no clusters. Take delta <= 1/60 and let A = {i : s_i < eps}, a = |A|. Every H edge lies in A, and a cross edge from j outside A into A needs s_j < 2 eps. Since s_1 >= 1/sqrt6 >= 3 eps, vertex 1 has no edge to any vertex below 2 eps. Case by case:

- a = 6: excluded by norm.
- a = 5: s_2 < eps.
- a = 4: if s_2 < 2 eps, five angles are < 2 eps. Otherwise there are no cross edges, and the count is at most 6 + 6 + 1 = 13.
- a = 3: two outside vertices below 2 eps give s_2 < 2 eps. Otherwise the count is at most 6 + 2 + 3 = 11.
- a = 2: three outside vertices below 2 eps give s_2 < 2 eps. Otherwise the count is at most 10.
- a = 1: four outside vertices below 2 eps give s_2 < 2 eps. Otherwise the count is at most 10.
- a = 0: the count equals |E(G)| >= 14, so at most one edge is missing. Any two vertices then share a neighbour, so s_1 - s_6 < 2 eps.

Result: for delta <= 1/60, mu_34(x) < delta gives s_2 < 2 sqrt(delta) or s_1 - s_6 < 2 sqrt(delta).

## 4. Constants

- Decomposable case: |x - s_1 e_12|^2 = sum_{i>=2} s_i^2 < 20 delta, so the distance is < 2 sqrt5 sqrt(delta).
- Equal-angle case: the distance to s-bar J is sqrt(sum (s_i - s-bar)^2) <= sqrt6 (range/2) < sqrt6 sqrt(delta).
- The order is sharp. At s = (1, t, ..., t), mu_34 = 32 t^2 and the distance is sqrt5 t, which is about 0.4 sqrt(delta).
- Random screen (32k hits with mu < delta): max of min(s_2, s_1 - s_6)/sqrt(delta) = 0.52. The constants above are therefore safe and not tight, because the bound on the sum is stronger than the per-value bound used here.
- A threshold on delta must be stated; the claim omits it.

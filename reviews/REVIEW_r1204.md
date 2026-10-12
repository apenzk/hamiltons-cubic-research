# REVIEW r1204: small p excluded by L249 at a single element

Reviewer r1204, adversarial Gate 2, working independently of r1205. Analysis-only footing: the screens below are bounded enumerations on objects built for this review, reported as screens.

Claim: the paragraph "**Small $p$ is excluded by L249 at a single element.**" in [2026-09-25-I73c-per-vector-rows.md](2026-09-25-I73c-per-vector-rows.md), and `small_p_scalar`, `p7_scalar` in [CoupledMoment.lean](../lean/HamiltonsCubic/Results/CoupledMoment.lean).

| Item | Verdict |
|---|---|
| 1. $\tfrac12\kappa_{2p}(x)$ is the sum of the $p$ largest of the thirty values | CONFIRMED |
| 2. $\kappa\le p-2$ at every $n$ | CONFIRMED |
| 3. $p\le6$ excluded at $n=12$, scalar check | CONFIRMED |
| 4. largest seven-sum $4+2\sqrt3$, and $1+2\sqrt3<\theta_0\sqrt{14}$ | CONFIRMED |
| 5. $8\le p\le13$, and the $p=8$ remark | CONFIRMED |
| 6. Lean statements match prose | CONFIRMED |

## Item 1

At $x$ with angles $s_1,\dots,s_6$ the operator $-\mathrm{ad}_x^2$ on $\mathfrak{so}(12)$ has the value $(s_i\mp s_j)^2$ on each two-dimensional root space and $0$ on the six-dimensional Cartan. Every nonzero value therefore occurs with even multiplicity, and the $2p$ largest eigenvalues are the $p$ largest entries of the thirty-value list, each taken twice (zeros included when $p$ exceeds the number of nonzero values, which changes nothing). So $\tfrac12\kappa_{2p}(x)$ is the sum of the $p$ largest of the thirty values. The trace check: the thirty values sum to $\sum_{i<j}2(s_i^2+s_j^2)=10$, so $\operatorname{tr}(-\mathrm{ad}_x^2)=20=2(n-2)$, and with $\mu_m+\kappa_{2p}=20$ ($2p+m=66$) the two forms of L249 agree: $n-5-\tfrac12\mu_m=7-10+\tfrac12\kappa_{2p}$. The same computation at general $n$ gives $n-5-\tfrac12(2(n-2)-\kappa_{2p})=\tfrac12\kappa_{2p}-3$.

## Item 2

At general $n$ the eigenvalues of $-\mathrm{ad}_x^2$ are $(s_i\mp s_j)^2$ twice each over the $\lfloor n/2\rfloor$ angles, plus $s_i^2$ twice each when $n$ is odd (the short roots $e_i$ of $B_k$), plus zeros. So $\tfrac12\kappa_{2p}$ is the sum of the $p$ largest of the listed values, each $\langle v,s\rangle^2$ with $v$ a distinct positive root. For $q$ such roots, $\sum\langle v,s\rangle^2=s^{\mathsf T}(\sum vv^{\mathsf T})s\le\lambda_{\max}$ of the Gram matrix $(v\cdot w)$, whose diagonal is $2$ (or $1$ for a short root) and whose off-diagonal entries lie in $\{0,\pm1\}$ (checked for long-long, long-short and short-short pairs). Row sums give $\lambda_{\max}\le q+1$, so $\tfrac12\kappa_{2p}\le p+1$ and $\kappa\le p-2$ at every $n$, under the same normalisation $\sum s_i^2=1$ that item 1 fixes through the trace. CONFIRMED.

## Item 3

$\kappa=\theta\sqrt{2p}$ with $\theta>\theta_0(12)$ gives $\kappa^2>\tfrac{55}{36}\cdot2p$. For $p\le2$, $\kappa\le p-2\le0$ contradicts $\kappa>0$ directly. For $3\le p\le6$, $0\le\kappa\le p-2$ gives $\kappa^2\le(p-2)^2$, and the table $(p-2)^2$ against $\tfrac{55}{18}p$ is $1<9.17$, $4<12.22$, $9<15.28$, $16<18.33$. At $p=7$ it is $25>21.39$, so the Gram bound fails there as stated. The squared inequality also holds at $p=1,2$ ($1<3.06$, $0<6.11$), so the Lean range $1\le p\le6$ is harmless. CONFIRMED.

## Item 4

*Screen* (independent rebuild, [r1204_enum.py] in the reviewer scratchpad, from root outer products, all $\binom{30}7=2{,}035{,}800$ subsets, `numpy.linalg.eigvalsh`): the largest $\lambda_{\max}(G_S)$ is $7.464101615$, matching $4+2\sqrt3$. The maximiser is a star: at vertex $a$, both roots $e_a\pm e_k$ for two $k$ and $e_a+e_j$ for the other three $j$. Exactly, $G_S$ on $\operatorname{span}\{e_a,(e_{j_1}+e_{j_2}+e_{j_3})/\sqrt3\}$ is $\begin{psmallmatrix}7&\sqrt3\\\sqrt3&1\end{psmallmatrix}$ with top eigenvalue $4+2\sqrt3$, and the orthogonal complement carries eigenvalues at most $2$. Also at $q=6$ the rebuild gives $6.70156=(7+\sqrt{41})/2$, matching the script's header. The use: the sum of the seven largest values at unit $s$ is $s^{\mathsf T}G_Ss$ for the maximising $S$, at most $4+2\sqrt3$, so $\kappa\le1+2\sqrt3\approx4.4641$ against $\theta_0\sqrt{14}\approx4.6248$, and $(1+2\sqrt3)^2=13+4\sqrt3\approx19.928<21.389$. Floating error is of order $10^{-13}$ against a margin of $0.16$. CONFIRMED, the maximum resting on the enumeration (a screen, with a hand proof of attainment but none of maximality).

## Item 5

Items 3 and 4 exclude $p\le7$, and L252 (with L251 beneath it) excludes $p\ge14$ at $n=12$, so $8\le p\le13$ on the symmetric family above $\theta_0(12)$. *Screen* (same rebuild, all $\binom{30}8=5{,}852{,}925$ subsets): the largest eight-sum is $8.274917=\tfrac92+\sqrt{57}/2$, from the star with three sign pairs and two single roots, whose $2\times2$ block is $\begin{psmallmatrix}8&\sqrt2\\\sqrt2&1\end{psmallmatrix}$. So the single-element bound is $\kappa\le5.2749$ against $\theta_0\sqrt{16}=4.9441$, and the remark "5.275 against 4.944" is exact to the digits given. The remark is right in the sense the paragraph uses, a bound uniform over all unit angle vectors: a choice of $x\in E_0$ steered away from the star configuration is a separate route and the remark does not speak to it. CONFIRMED.

## Item 6

`small_p_scalar (p : ℕ) (hp1 : 1 ≤ p) (hp : p ≤ 6) : ((p : ℝ) - 2) ^ 2 < 55 / 36 * (2 * p)` is the scalar inequality of item 3, and `p7_scalar : (1 + 2 * Real.sqrt 3) ^ 2 < 55 / 36 * 14` is the scalar of item 4. Both compile: `lake env lean HamiltonsCubic/Results/CoupledMoment.lean` exits 0 with no warnings (so no `sorry`). The docstrings state the hypotheses the prose supplies ($\kappa\le p-2$, the seven-sum maximum, L249) as context only, which matches the prose citing the two theorems for the scalar steps alone. CONFIRMED. *Bookkeeping*: the L252 row of [lean/INDEX.md](../lean/INDEX.md) lists the other theorems of the file and omits `small_p_scalar` and `p7_scalar`, and its "Not typed" column should name the seven-subset enumeration and the Gram row sum for this paragraph when the result is recorded.

## Most serious finding

No defect in the chain. The weakest link is item 4's maximality, which rests on a floating enumeration (reproduced independently, margin $0.16$ at the use) with no hand proof or exact certificate. An exact certificate is cheap: $\tfrac{76}{10}I-G_S\succ0$ at every seven-subset by integer elimination, as r1203 did for L252.

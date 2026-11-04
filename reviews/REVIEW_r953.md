# Review r953: Lemma L228 (the |J| = 3 step of R27 on two strata at every n)

Brief: [BRIEF_L228.md](BRIEF_L228.md). Claim: [findings/second-order.md](../findings/second-order.md) lines 1001-1027. Log: [agent_logs/review-r953.log](../agent_logs/review-r953.log).

**Verdict: the mathematics of L228 stands.** Items 1 to 4 were rederived by hand link by link and every coefficient holds. The findings are in the record's description of its own support: the Lean scope overstates what is kernel-checked for item 1, Gate 1 (a) says the norm was compared to the trusted operator when it was compared formula to formula, item 4 closes by citing sentences of item 3 whose justification ("by item 2") does not apply to it and uses a permutation it never introduces, and the block omits the L57 inheritance that L227 records.

| Item | Verdict | Reason |
|---|---|---|
| 1. Item 1 | CONFIRMED | Both Cayley–Hamilton identities, the four substituted terms, the zero coefficient of $\lvert X_a\rvert^2$, $\beta_{ab}$ over ordered pairs, the norm and $S=X-\tfrac12\mu I$ all rederive. |
| 2. Item 2 | CONFIRMED | Expansion coefficients $6$ and $9$, the completed square, the cancellation of $\mathop{\mathrm{tr}}(Y_a^2R_a)$ and $\ell'_a=\ell_a-\tfrac92R_a^2$ rederive, and $c_a,n_a$ depend on $X_c$ ($c\ne a$), $t$ and $K$ alone. |
| 3. Item 3 | CONFIRMED, C5 and C1 (inheritance) | Every step holds. The membership sentence compresses which of L226's conditions are scalar (C5), and the bound inherits L57's two underived identities, which the block does not record (C1). |
| 4. Item 4 | CONFIRMED with corrections C3, C4 | The frame-dependent part $\mathop{\mathrm{tr}}(V^2Z)+\mathop{\mathrm{tr}}(VL)$ and the equal norm hold. The permutation $\sigma$ is undefined in item 4, and "item 3's last three sentences" import "by item 2" for norm and value, which item 4 establishes by its own computation instead. |
| 5. Scope | CONFIRMED, C4 | $m\le2$ covers every $W$ (at $m=1$ vacuously, at $m=2$ one block is always diagonalisable), $m=1$ and every $n\ge4$ hold, no condition on $(t,K)$ is used. Item 4 needs $a\ne b$, hence $m\ge2$, which the statement leaves implicit. |
| 6. Gate 1 | CONFIRMED except (a)'s norm clause, REFUTED as written (C6), and (d) cosmetic (C7) | Reran both scripts: outputs match (a) and (c). The norm in [screen_I106.py](../scripts/misc/screen_I106.py) is compared with L226's block norm formula, never with the trusted operator. Item 4 has neither screen nor Lean (C8). |
| 7. Lean against the block | CONFIRMED for the four declarations, REFUTED for the scope sentence (C1, C2) | Build succeeds, all four depend only on propext, Classical.choice, Quot.sound, no weakening hypotheses. `cubicX` is a definition with no bridge to L226's `blockP`, so item 1's cubic part is outside the file too. |
| 8. What it gives | CONFIRMED | Both strata described correctly, L227 is the case $m=2$ of item 3 (and of item 4), and a general $W$ at $m\ge3$ lies in neither stratum. |
| 9. Counterexample hunt | CONFIRMED (no counterexample, screen only) | The proof admits none. A seconds-long screen of item 4 at $n=6,7,8$ found the frame formula exact and the move non-decreasing. |

## Item 1

- $N=\mu I+X$, $\mathop{\mathrm{tr}}N=3\mu$, so $S=N-\tfrac32\mu I=X-\tfrac12\mu I$. Correct.
- For traceless $3\times3$ $Z$ the characteristic polynomial is $\lambda^3-\tfrac12\lvert Z\rvert^2\lambda-\det Z$ with $\det Z=\tfrac13\mathop{\mathrm{tr}}Z^3$, so $\det(Z-cI)=-(c^3-\tfrac12\lvert Z\rvert^2c-\det Z)$, which is the written identity.
- $\mathop{\mathrm{adj}}A=A^2-(\mathop{\mathrm{tr}}A)A+e_2(A)I$ with $A=tI+Z$, $e_2=3t^2-\tfrac12\lvert Z\rvert^2$, gives $Z^2-tZ+(t^2-\tfrac12\lvert Z\rvert^2)I$. Correct.
- $\mathop{\mathrm{tr}}S^3=\mathop{\mathrm{tr}}X^3-3c\lvert X\rvert^2-3c^3$, plus $3\det S=\mathop{\mathrm{tr}}X^3+\tfrac32c\lvert X\rvert^2-3c^3$, gives $2\mathop{\mathrm{tr}}X^3-\tfrac32c\lvert X\rvert^2-6c^3$, which at $c=\tfrac12\mu$ is the written $-\tfrac34\mu\lvert X\rvert^2-\tfrac34\mu^3$.
- $3\mathop{\mathrm{tr}}\big((X-cI)(X_a^2-t_aX_a+(t_a^2-\tfrac12\lvert X_a\rvert^2)I)\big)=3\mathop{\mathrm{tr}}(XX_a^2)-3t_a\mathop{\mathrm{tr}}(XX_a)+\tfrac32c\lvert X_a\rvert^2-9ct_a^2$, the linear traces vanishing. At $c=\tfrac12\mu$ this is the written term.
- Collecting: $\lvert X_a\rvert^2$ gets $-\tfrac34\mu+3t_a-3t_a+\tfrac34\mu=0$. An unordered pair gets $-\tfrac32\mu-3t_a-3t_b+3K_{ab}$, which is $2\beta_{ab}$, so $\beta_{ab}$ per ordered pair. No term linear in the $X_a$ survives, since $\mathop{\mathrm{tr}}X_a=\mathop{\mathrm{tr}}X=0$.
- Norm: $\lvert S\rvert^2=\lvert X\rvert^2+3c^2=\lvert X\rvert^2+\tfrac34\mu^2$ and $\lvert M_a\rvert^2=3t_a^2+\lvert X_a\rvert^2$. Correct.
- The cubic $2\mathop{\mathrm{tr}}X^3+3\sum\mathop{\mathrm{tr}}(XX_a^2)+\sum\mathop{\mathrm{tr}}X_a^3$ equals the expanded form $6\sum C_{aaa}+9\sum_{a\ne b}C_{aab}+12\sum_{a<b<c}C_{abc}$ that [screen_I106.py](../scripts/misc/screen_I106.py) evaluates, using $\mathop{\mathrm{tr}}(ABC)=\mathop{\mathrm{tr}}(ACB)$ for symmetric matrices. Checked by hand.

## Item 2

- $2\mathop{\mathrm{tr}}(X_a+R_a)^3$ expands with the three cyclic words of each mixed type, so $2\mathop{\mathrm{tr}}X_a^3+6\mathop{\mathrm{tr}}(X_a^2R_a)+6\mathop{\mathrm{tr}}(X_aR_a^2)$ plus a constant. The $c=a$ term of $3\sum_c\mathop{\mathrm{tr}}(XX_c^2)$ gives $3\mathop{\mathrm{tr}}X_a^3+3\mathop{\mathrm{tr}}(X_a^2R_a)$ and the $c\ne a$ terms give $3\mathop{\mathrm{tr}}(X_aT_a)$ plus a constant. The Gram part gives $2\sum_{c\ne a}\beta_{ac}\mathop{\mathrm{tr}}(X_aX_c)$ because $\beta$ is symmetric. Totals $6$, $9$ and $\ell_a$ as written.
- $2\lvert Y_a\rvert^2=2\lvert X_a\rvert^2+2\mathop{\mathrm{tr}}(X_aR_a)+\tfrac12\lvert R_a\rvert^2$. Correct.
- $6\mathop{\mathrm{tr}}(Y-\tfrac12R)^3=6\mathop{\mathrm{tr}}Y^3-9\mathop{\mathrm{tr}}(Y^2R)+\tfrac92\mathop{\mathrm{tr}}(YR^2)-\tfrac34\mathop{\mathrm{tr}}R^3$ and $9\mathop{\mathrm{tr}}\big((Y-\tfrac12R)^2R\big)=9\mathop{\mathrm{tr}}(Y^2R)-9\mathop{\mathrm{tr}}(YR^2)+\tfrac94\mathop{\mathrm{tr}}R^3$. The sum is the written expression, and $\ell'_a=\ell_a-\tfrac92R_a^2$.
- $c_a$ collects $P_0$, the $X_a$-free terms of the expansion, $\tfrac32\mathop{\mathrm{tr}}R_a^3$ and $-\tfrac12\mathop{\mathrm{tr}}(R_a\ell_a)$, and $n_a$ collects $N_0$, $\lvert R_a\rvert^2$ terms and $\lvert X_c\rvert^2$ for $c\ne a$. Both are free of $X_a$, since the scalars $t,K$ are independent coordinates. $Y_a$ is traceless.

## Item 3

- $R_a$, $T_a$, $X_c$ diagonal in $F$ make $\ell'_a$ diagonal in $F$. $\mathop{\mathrm{tr}}(QD_yQ^{\mathsf T}FD_lF^{\mathsf T})=\mathop{\mathrm{tr}}(D_yBD_lB^{\mathsf T})=\sum_{i,k}y_iB_{ik}^2l_k$ with $B=Q^{\mathsf T}F$. The direction of Birkhoff is correct.
- $Y'=F\mathop{\mathrm{diag}}(y\circ\sigma^{-1})F^{\mathsf T}$ has diagonal entry $y_{\sigma^{-1}(k)}$ in position $k$, so $\mathop{\mathrm{tr}}(Y'\ell'_a)=\sum_ky_{\sigma^{-1}(k)}l_k=\sum_iy_il_{\sigma(i)}$. Trace invariants follow from the spectrum.
- Membership: at $k=3$ L226's item 3 makes Bianchi automatic, item 2's $J$-Ricci condition is solved by recomputing $S'=N'-\tfrac12(\mathop{\mathrm{tr}}N')I$, and the outer Ricci condition $3t_c+\sum_{d\ne c}K_{cd}=0$ involves scalars only. The written sentence ("the traceless blocks are free once the scalars satisfy L226's item 2") is correct but defers the recomputation of $S$ to the next sentence (C5, optional).
- Rotation: $g=F^{\mathsf T}\oplus\mathrm{id}_A\in O(n)$ acts on each $V_a$ by $F^{\mathsf T}$, on $\Lambda^2\mathbb R^J$ in the Hodge frame by $(\det F^{\mathsf T})F^{\mathsf T}$, whose sign cancels in a conjugation, and trivially on $\Lambda^2\mathbb R^A$. The image is diagonal in every $\varphi_{ij}$, so coordinate-diagonal, and $P$ and the norm are $\mathop{\mathrm{Ad}}$-invariant under all of $O(n)$ because $\Lambda^2g$ is a Lie algebra automorphism of $\mathfrak{so}(n)$.
- L57 applies at every $n\ge4$, including $n=4$ where $\Theta_4=\tfrac{\sqrt3}2$. **L57's block states that a consumer inherits its two underived identities.** L227's header records that inheritance, L228's does not (C1).
- Attainment: $H_J$ is the sign changes constant on $J$ ([block note](2026-09-14-I104-block-J.md) line 7), so every coordinate-diagonal operator is $H_J$-fixed and $\mathcal D_n\subseteq\mathcal S_J$, and a diagonal $W$ lies in both strata.

## Item 4

- $X_a^2+X_b^2=\tfrac12(U^2+V^2)$, $\mathop{\mathrm{tr}}X_a^3+\mathop{\mathrm{tr}}X_b^3=\tfrac14\mathop{\mathrm{tr}}U^3+\tfrac34\mathop{\mathrm{tr}}(UV^2)$, $\mathop{\mathrm{tr}}(X_aX_b)=\tfrac14(\lvert U\rvert^2-\lvert V\rvert^2)$ (the $\mathop{\mathrm{tr}}(UV)$ terms cancel), and $2\beta_{ac}\cdot\tfrac12\mathop{\mathrm{tr}}((U+V)X_c)+2\beta_{bc}\cdot\tfrac12\mathop{\mathrm{tr}}((U-V)X_c)$ gives the written Gram line. No $\mathop{\mathrm{tr}}V^3$ and no $\mathop{\mathrm{tr}}(UV)$ survives. $Z=\tfrac32X+\tfrac34U$ and $L$ are diagonal in $F$ because $X=U+\sum_{c\notin\{a,b\}}X_c$.
- $\sum_{i,k}(F^{\mathsf T}Q)_{ik}^2c_{ik}$ with $c_{ik}=z_i\nu_k^2+l_i\nu_k$ is linear in the doubly stochastic matrix but not of the product form $u_iw_k$ that Lean's `le_perm_pairing` covers. Birkhoff as quoted (any linear function) covers it, so the step holds.
- **Gap (C3).** The permutation $\sigma$ in "$V'=F\mathop{\mathrm{diag}}(\nu\circ\sigma^{-1})F^{\mathsf T}$" is introduced nowhere in item 4, and the rows of $F^{\mathsf T}Q$ are indexed by $F$, the reverse of item 3's $Q^{\mathsf T}F$, so importing item 3's $\sigma$ gives the wrong index convention. With $\pi$ the maximising vertex, $\sum_i c_{i\pi(i)}$, the right move is $V'=F\mathop{\mathrm{diag}}(\nu\circ\pi)F^{\mathsf T}$.
- **Gap (C3).** "Item 3's last three sentences finish" imports "by item 2 it has $\lVert W'\rVert=\lVert W\rVert$ and $P(W')\ge P(W)$". In item 4 these come from the $U,V$ computation, which the preceding sentence already states. The conclusion is right and the cited justification is the wrong one.

## Scope

- $m=1$: no other blocks, $R_a=T_a=0$, $\ell'_a=0$, any $F$ works. $m=2$: the single other block is diagonal in its eigenframe. So item 3 covers every $W$ at $m\le2$.
- $n\ge4$ gives $m\ge1$. Item 4 requires distinct $a,b$, so $m\ge2$ (C4). At $m=2$ item 4 also covers every $W$ and reduces to L227's step with $Z=\tfrac94U$, $L=0$, which matches the $2.25\mathop{\mathrm{tr}}(UV^2)$ of L227's step 2 formula in [screen_I106.py](../scripts/misc/screen_I106.py).
- No sign or relation of $(t,K)$ is used beyond the Ricci conditions.

## Gate 1

- Reran [screen_I106.py](../scripts/misc/screen_I106.py): trusted $P$ and item 1's traceless form agree to all printed digits at $n=5,6,7$. **The norm compared is `norm2_blocks`, L226's block norm formula, against the traceless norm, never against the trusted operator.** L227's Gate 1 says exactly this ("compared formula to formula"), L228's (a) says "agree with the trusted $Q$" (C6).
- Reran [screen_I106_m3.py](../scripts/misc/screen_I106_m3.py): batch 1 gives $dP$ trusted and predicted equal to ten digits at $n=6,7$ with $d\lVert W\rVert^2$ of $7\cdot10^{-15}$, and batch 2 raises $P$ ($7.37\to11.86$, $14.15\to20.33$) at equal norm with commutators $1.1\cdot10^{-16}$ and $3.1\cdot10^{-16}$. (a)'s second clause and (c) are true as written. Here the norm is the assembled operator's.
- (b) true: at $m=2$ item 3's conclusion is L227's.
- (d) true, but at $m=1$ $\mu=t_1=0$ and there is no $K$, so $P_0=N_0=0$, and writing them suggests otherwise (C7). $6\mathop{\mathrm{tr}}X_1^3\le\sqrt6\lvert X_1\rvert^3$ from L225 at $k=3$ over $\lVert W\rVert^3=2\sqrt2\lvert X_1\rvert^3$ gives $\tfrac{\sqrt3}2=\Theta_4$.
- Item 4 has no Gate 1 support and no Lean (C8 proposes recording r953's screen).

## Lean

- `lake build HamiltonsCubic.Results.L228Statement` succeeded. `#print axioms` on `cubic_split`, `complete_square`, `complete_square_norm`, `align_to_frame`: each `[propext, Classical.choice, Quot.sound]`.
- `cubic_split` has no hypotheses and is an identity for arbitrary matrices, correct since cyclicity suffices. `complete_square` takes a generic `L`, so the Gram part rides along inside `L`. `complete_square_norm` uses $\mathop{\mathrm{tr}}(X X)$, which is $\lvert X\rvert^2$ for the symmetric blocks of the application. `align_to_frame` assumes $F^{\mathsf T}F=FF^{\mathsf T}=1$ and $Y$ symmetric, with $l$ free, and concludes the three trace equalities and the pairing inequality in the direction item 3 uses. None of these hypotheses weakens or voids the statement.
- **Scope overstated (C1, C2).** `cubicX` is defined as $2\mathop{\mathrm{tr}}X^3+3\sum\mathop{\mathrm{tr}}(XX_c^2)+\sum\mathop{\mathrm{tr}}X_c^3$, and nothing in the file relates it to L226's `blockP` or `blockOp`. L227's file has `blockP_m2` for that bridge, L228's has no analogue. So the whole of item 1 is outside the file, while the Lean paragraph lists only "item 1's scalar and Gram parts" as outside, and the header calls "the polynomial cores" kernel-checked. The Gram part of item 2's expansion in $X_a$ is also outside. The same wording sits in the file's docstring and in [lean/INDEX.md](../lean/INDEX.md) line 117, which this review does not edit.

## What it gives

- The two strata are exactly items 3 and 4's hypotheses. L227 is item 3 at $m=2$. At $m\ge3$ item 3's stratum needs $m-1\ge2$ blocks to commute and item 4's needs $X_c$ to commute with $X_a+X_b$, both of positive codimension, so a general $W$ is in neither. The description of the open question is accurate.

## Counterexample hunt (screen only)

No unit $W$ in either stratum can exceed $\Theta_n$ given items 1 to 4, and no failure of item 2's identity was found. A seconds-long screen of item 4, the one item with no prior screen, on objects built for it at $n=6,7,8$ ($F$ random, $U$ and $X_c$ diagonal in $F$, $V$ random traceless, $K$ random):

- a random rotation of $V$ changes trusted $P$ by exactly the change of $\mathop{\mathrm{tr}}(V^2Z)+\mathop{\mathrm{tr}}(VL)$ to ten digits ($0.8075701751$, $-6.8666967458$, $2.3009398678$), with $d\lVert W\rVert^2\le4\cdot10^{-15}$,
- the best of the six permutations of $\nu$ in $F$ raises $P$ ($-0.0386\to1.9457$, $3.9715\to6.7924$, $-24.7696\to-5.7515$) at identical norm, all blocks commuting to $6\cdot10^{-16}$, $\theta$ below $\Theta_n$.

It is a screen of a derived move and establishes nothing by itself. The script, run from the repository root:

```python
import sys, itertools, numpy as np
sys.path.insert(0, 'scripts/lib')
from curvature_operator import Lambda2, Q_op
rng = np.random.default_rng(953)
hodge = {(0, 1): (2, 1.0), (0, 2): (1, -1.0), (1, 2): (0, 1.0)}
def tl(): A = rng.normal(size=(3, 3)); A = (A + A.T) / 2; return A - np.trace(A) / 3 * np.eye(3)
def rot(): Q, _ = np.linalg.qr(rng.normal(size=(3, 3))); return Q
def build(n, Xs, K):
    m = len(Xs); t = [-K[a].sum() / 3 for a in range(m)]; Ms = [t[a] * np.eye(3) + Xs[a] for a in range(m)]
    N = sum(Ms); S = N - 0.5 * np.trace(N) * np.eye(3); L2 = Lambda2(n); W = np.zeros((L2.N, L2.N))
    for p1, (h1, s1) in hodge.items():
        for p2, (h2, s2) in hodge.items(): W[L2.idx[p1], L2.idx[p2]] = s1 * s2 * S[h1, h2]
    for a in range(m):
        for p in range(3):
            for q in range(3): W[L2.idx[(p, a + 3)], L2.idx[(q, a + 3)]] = Ms[a][p, q]
    for a, b in itertools.combinations(range(m), 2): W[L2.idx[(a + 3, b + 3)], L2.idx[(a + 3, b + 3)]] = K[a, b]
    return np.sum(W * Q_op(L2, W)), np.sum(W * W), t
def Theta(n): return np.sqrt(2*(n-1)*(n-2))/n if n % 2 == 0 else np.sqrt(2*(n-1)*(n-3)/((n+1)*(n-2)))
for n in (6, 7, 8):
    m = n - 3; K = rng.normal(size=(m, m)); K = (K + K.T) / 2; np.fill_diagonal(K, 0)
    F = rot(); dg = lambda: F @ np.diag((lambda v: v - v.mean())(rng.normal(size=3))) @ F.T
    U = dg(); V = tl(); others = [dg() for _ in range(m - 2)]
    Xs = [(U + V) / 2, (U - V) / 2] + others
    P0, N0, t = build(n, Xs, K); mu = sum(t); beta = lambda a, c: 1.5 * (K[a, c] - t[a] - t[c] - 0.5 * mu)
    X = sum(Xs); Z = 1.5 * X + 0.75 * U; L = sum(((beta(0, c) - beta(1, c)) * Xs[c] for c in range(2, m)), np.zeros((3, 3)))
    f = lambda V: np.trace(V @ V @ Z) + np.trace(V @ L)
    G = rot(); V2 = G @ V @ G.T; P1, N1, _ = build(n, [(U + V2) / 2, (U - V2) / 2] + others, K)
    nu = np.linalg.eigvalsh(V); best = max((f(F @ np.diag(nu[list(p)]) @ F.T), p) for p in itertools.permutations(range(3)))
    Vp = F @ np.diag(nu[list(best[1])]) @ F.T; Xp = [(U + Vp) / 2, (U - Vp) / 2] + others; P2, N2, _ = build(n, Xp, K)
    comm = max(np.abs(A @ B - B @ A).max() for A in Xp for B in Xp)
    print(n, P1 - P0, f(V2) - f(V), N1 - N0, P0, P2, N0, N2, comm, P2 / N2**1.5, Theta(n))
```

## Corrections

All in [findings/second-order.md](../findings/second-order.md).

- **C1 (header, line 1003).** Replace "The polynomial cores and the alignment to a frame are kernel-checked in [L228Statement.lean](../lean/HamiltonsCubic/Results/L228Statement.lean)." with "Item 2's split of the cubic part, the shift to $Y_a$ and the alignment to a frame are kernel-checked in [L228Statement.lean](../lean/HamiltonsCubic/Results/L228Statement.lean). L228 inherits the two identities L57's block names as carrying L57: the vertex-matrix form of the cubic, which [L226](second-order.md)'s Gate 1 (b) reads at a coordinate-diagonal $W$, and the norm formula for $Z(v)$, which [L223](problem.md)'s block reports deriving."
- **C2 (Lean paragraph, line 1025).** Replace "Item 1's scalar and Gram parts, item 4, the rotation to a diagonal tensor, L57 and the bridges of L226 are outside the file." with "`cubicX` is item 1's cubic part taken as a definition, with no bridge to L226's `blockP`, so item 1 in full, the Gram part of item 2's expansion, item 4, the rotation to a diagonal tensor, L57 and the bridges of L226 are outside the file."
- **C3 (proof item 4, line 1019).** Replace "linear in one doubly stochastic matrix, so a permutation does at least as well, and $V'=F\mathop{\mathrm{diag}}(\nu\circ\sigma^{-1})F^{\mathsf T}$ makes $X_a',X_b'$ diagonal in $F$ at the same norm and no smaller value. Item 3's last three sentences finish." with "linear in one doubly stochastic matrix, so by Birkhoff's theorem some permutation $\pi$ has it at most $\sum_i\big(z_i\nu_{\pi(i)}^2+l_i\nu_{\pi(i)}\big)$, and $V'=F\mathop{\mathrm{diag}}(\nu\circ\pi)F^{\mathsf T}$, which has $V$'s spectrum, attains that value and makes $X_a'=\tfrac12(U+V')$ and $X_b'=\tfrac12(U-V')$ traceless and diagonal in $F$ at the same norm and no smaller value. $W'$ lies in $\mathcal S_J\cap\mathcal W_n$ as in item 3, and item 3's last two sentences finish."
- **C4 (Statement item 4, line 1011).** Replace "*If the blocks $X_c$, $c\notin\{a,b\}$, and $X_a+X_b$" with "*For distinct $a,b\in A$ (so $m\ge2$), if the blocks $X_c$, $c\notin\{a,b\}$, and $X_a+X_b$".
- **C5 (proof item 3, line 1018, optional precision).** Replace "since the traceless blocks are free once the scalars satisfy L226's item 2" with "since at $\lvert J\rvert=3$ L226's item 3 makes Bianchi automatic and item 2's Ricci conditions read $S=N-\tfrac12(\mathop{\mathrm{tr}}N)I$, recomputed from the new blocks, and $\mathop{\mathrm{tr}}M_c+\sum_{d\ne c}K_{cd}=0$, which involves the scalars alone".
- **C6 (Gate 1 (a), line 1023).** Replace "Item 1's cubic and norm agree with the trusted $Q$ of [curvature_operator.py](../scripts/lib/curvature_operator.py) at $n=5,6,7$ to ten digits ([screen_I106.py](../scripts/misc/screen_I106.py))" with "Item 1's cubic agrees with the trusted $Q$ of [curvature_operator.py](../scripts/lib/curvature_operator.py) at $n=5,6,7$ to ten digits, and item 1's norm with L226's block norm to ten digits, compared formula to formula ([screen_I106.py](../scripts/misc/screen_I106.py))".
- **C7 (Gate 1 (d), line 1023).** Replace "item 1 reads $P=6\mathop{\mathrm{tr}}X_1^3+P_0$ at $\lVert W\rVert^2=2\lvert X_1\rvert^2+N_0$ with $t_1=0$" with "item 1 reads $P=6\mathop{\mathrm{tr}}X_1^3$ at $\lVert W\rVert^2=2\lvert X_1\rvert^2$, since $t_1=\mu=0$ and the absence of $K$ make $P_0=N_0=0$".
- **C8 (Gate 1, line 1023, optional).** Append "(e) *A screen of item 4.* [r953](../reviews/REVIEW_r953.md) rotated $V$ at $n=6,7,8$ and matched the change of $\mathop{\mathrm{tr}}(V^2Z)+\mathop{\mathrm{tr}}(VL)$ to the trusted $Q$ to ten digits, and item 4's move raised $P$ at equal norm with every block commuting to $6\cdot10^{-16}$. A screen of a derived move."

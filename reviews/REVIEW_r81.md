# Reviewer 81, Gate 2 on the three derivations, 4a32434..b105eac

Independent of [Reviewer 82](REVIEW_r82.md), same brief. **Agrees with it on every verdict** and adds two findings it did not reach.

| # | claim | verdict |
|---|---|---|
| 1 | $\theta^2=\frac{m(m+1)}{(m-1)(m+2)}$ | **CONFIRMED**, and provable more strongly than committed |
| 2 | the general formula | **CONFIRMED** (formula) / **OVERSTATED** (what it settles) |
| 3 | $c=2h^\vee/I_\rho$ | CONFIRMED modulo an unstated convention; the companion $S_{\mathfrak{kkk}}=c_{\mathfrak k}p$ is **WRONG for $\mathfrak k$ with a centre** |
|, | "$\mathbb{CP}^m$ and $\mathbb{HP}^2$ are not of this form" | **REFUTED for $\mathbb{CP}^2$** (right for $\mathbb{CP}^{m\ge3}$ and $\mathbb{HP}^2$) |

## The two findings beyond Reviewer 82

**(A) Admissibility is provably NOT a function of the four invariants.** Two pairs with *identical* $(p,q,S_{\mathfrak{kkk}},S_{\mathfrak{kmm}})=(7,8,24,32)$ and *identical* $\theta^2=9245/8232$, $(\mathfrak{so}(6),\mathfrak{so}(2){+}\mathfrak{so}(4))$ and $(\mathfrak{su}(4),\mathfrak s(\mathfrak u(2){+}\mathfrak u(2)))$, have **different failure modes**: Ricci $0.69$ / Bianchi $0$ versus Ricci $0$ / Bianchi $0.345$. So no function of those four invariants can decide Weyl-ness. Of 16 pairs only 5 pass `is_weyl`. **This is exactly the trap [weyl_screen.py](../scripts/weyl_screen.py) exists to prevent, and the commits never mention Ricci-flatness.**

**(B) $\rho$ is a free INFINITE parameter, so the problem is not finite.** $p,q$ depend only on the abstract pair, but $S_{\mathfrak{kkk}},S_{\mathfrak{kmm}},c$ scale as $1/I_\rho$ while $-2p^3+2pq^2$ does not. Witness: $(\mathfrak{su}(2),\mathfrak u(1))$ on 1, 2, 3 copies of $\mathbb C^2$ gives $(p,q)=(1,2)$ throughout and $\theta^2=3/2,\ 2/3,\ 25/54$, with $S_{\mathfrak{kmm}}=4,2,4/3$, not even integral. The census is over (pair, $\rho$), infinitely many $\rho$ per pair. Also, **$\mathfrak g$ semisimple with non-isomorphic factors has no single $c$**: $\mathfrak{so}(3){+}\mathfrak{so}(5)$ in $\mathfrak{so}(8)$ gives $c\in\{2,6\}$, so the Killing relation simply fails.

## Where it agrees with R82

The formula, tested on **16 pairs across five families** (largest discrepancy $4.4\times10^{-16}$); $S_{\mathfrak{kkm}}=S_{\mathfrak{mmm}}=0$ exactly on all 16; the Killing relation at every simple $\mathfrak g$; the multinomial coefficients; the closed form at $m=9,10$ outside the fitted range. **The balanced split $\mathfrak{so}(k){+}\mathfrak{so}(k)$ returns exactly $\theta_0(n)^2=2(n-1)(n-2)/n^2$** ($55/36$ at $n=12$) so the unrestricted maximum over the class is $\sqrt2$, not $\sqrt{3/2}$, and **diagonality is what excludes it**. $\mathbb{CP}^2$ is the pair $(\mathfrak{su}(2),\mathfrak u(1))$ with $\lVert W_{\rm ansatz}-W_{\mathbb{CP}^2}\rVert=0$ **exactly**.

**Both reviewers independently supplied the same upgrade to step (c)**: $\mathfrak k=\mathfrak{so}(m)$ sits *diagonally*, so the induced metric is exactly twice $\mathfrak{so}(m)$'s, halving its Killing constant to $c_{\mathfrak k}=2(m-2)/2=m-2$; then $S_{\mathfrak{kmm}}=cp-S_{\mathfrak{kkk}}=(m+2)p=mq$ identically. **So the two "computed at $m=3..7$" inputs are theorems, not fits.**

A cross-check worth keeping: $(\mathfrak{so}(12),\mathfrak{so}(5){+}\mathfrak{so}(7))$ returns $1.238485798$ with Ricci residual $\mathbf{0.288}$, exactly the near-miss that [weyl_screen.py](../scripts/weyl_screen.py) was written about, reproducing that file's own recorded number from a completely different construction.

## Convention

$c=4h^\vee/I_\rho$ under the **standard** Dynkin normalisation ($I(\text{fund }\mathfrak{su})=1$, $I(\text{vec }\mathfrak{so})=2$, $I(\mathrm{adj})=2h^\vee$); the record's $c=2h^\vee/I$ is right only in the physics $T(R)$ convention it silently used. Sharpest confirmation: **the adjoint representation gives $c=2$ for every $\mathfrak g$**, independent of the algebra, checked at $\mathfrak{so}(4),\mathfrak{so}(5),\mathfrak{so}(6)$. Also verified on $\mathfrak{sp}(m)$ on $\mathbb H^m$ and on *reducible* $\rho$ ($\mathfrak{so}(3)$ on 2 and 3 copies of $\mathbb R^3$, giving $1$ and $2/3$).

$S_{\mathfrak{kkk}}=c_{\mathfrak k}p$ fails for every Hermitian pair: $(\mathfrak{su}(4),\mathfrak s(\mathfrak u(2){+}\mathfrak u(2)))$ has the constant taking values $\{4/3,8/3,4\}$ on $\mathfrak k$. Correct form $S_{\mathfrak{kkk}}=\sum_i c_ip_i$ over simple ideals, centre contributing $0$, reproducing $4\cdot3+4\cdot3+0=24$ and $6\cdot8+0=48$ exactly. **This matters because $\mathbb{CP}^2$ itself is the Hermitian pair $(\mathfrak{su}(2),\mathfrak u(1))$ with $S_{\mathfrak{kkk}}=0$.**

## Record hygiene it caught

- [b_sum_kahler_family.py](../scripts/route-b/b_sum_kahler_family.py) said the closed form was obtained "by sympy, EXACTLY" while **containing no sympy**; its executable content was the $m=3..8$ numerics.
- The same file's `main()` still printed *"the derivation is owed"*, contradicting its own header banner.
- Commit 4a32434's "PROVED, not pattern-matched" was premature: at that commit $S_{\mathfrak{kkk}}$ and $S_{\mathfrak{kmm}}$ were still spot values; the closing lemmas arrived in the later commits.

## Not raised (checked and clean)

The multinomial coefficients; $S_{\mathfrak{kkm}}=S_{\mathfrak{mmm}}=0$; the closed form off the tested range; orthonormality of the corrected basis and $[\mathfrak k,\mathfrak m]\subseteq\mathfrak m$; $a^2=q/(p(p+q))$; $T/(T-1)=\frac{m(m+1)}{(m-1)(m+2)}$; monotonicity in $m$.

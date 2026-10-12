# Reviewer 74, Gate 2 on the three commits since 4dc2b0b

Ran 2026-08-24, same brief as [Reviewer 73](REVIEW_r73.md), independently. $Q$ agrees with [review_r30_core.py](../scripts/review_r30_core.py) to $5.6\times10^{-17}$.

**Agrees with R73 on every verdict**, and adds three findings R73 did not reach.

| # | claim | verdict |
|---|---|---|
| 1 | identity and sharpened bound | **CONFIRMED**, and valid at *every* Weyl tensor, not only critical ones |
| 2 | the circulant family | mechanism CONFIRMED; **the three counts REFUTED** |
| 3 | direct sums | (a)–(d) CONFIRMED and proved; (e) OVERSTATED |
| 4 | the headline | **REFUTED, with two witnesses** |

## The counts are wrong, and there is a proof needing no numerics

$Q$ is **quadratic**, so $Q(-W)=Q(W)=\theta W=(-\theta)(-W)$: the critical locus is closed under $W\mapsto-W$, hence so is its $\theta$-set. **Nine of the recorded 37 have no negation partner in the list**, $-1.236033$, $-0.728136$, $-0.540062$, $-0.242685$, $-0.199761$, $-0.055176$, $-0.054876$, $+0.456435$, $+1.145644$. *Verified against the script's own output.* With 3000–4000 starts plus negation closure:

| quantity | recorded | actual |
|---|---|---|
| distinct critical points | 37 | $\ge$ **73** |
| with $\Delta>0$ | 32 | $\ge$ **61** |
| in the band | 9 | $\ge$ **22** (20 isolated; 2 degenerate at $\theta=0$, Jacobian corank 3) |

The recorded 37 is a strict subset. **What survives:** the sharpened bound is never violated across all 73 (worst $3.3\times10^{-16}$), and at all 22 band points both bounds give $\theta\le\sqrt{3/2}$, but **12 of the 22 have $\theta\le0$**, where that is vacuous; only three of the recorded nine have $\theta>0$, max $0.612372$.

## Witness 2, a hard-stratum point that escapes step H as well

The $C_5$ blow-up conjugated by a generic $g\in SO(10)$: $\theta=0.670820$, criticality $3.2\times10^{-16}$, Weyl, $\dim\mathfrak m=20<25$, $S=4.7\times10^{-29}$, $\dim E(1)=1$, **max off-diagonal $0.102$**. Because $\Delta=12>0$ it is **not graded**, so it escapes step **H** as well as B1 and B2, whereas $\mathbb{CP}^m$ ($m\ge3$) has $\Delta=0$, $G_0=0$, $\ker W=0$, $S=0$ and is therefore graded by the record's own lemma, i.e. already H's territory. Five of the 22 band points have $\dim E(1)=1$, so the rotation yields a family.

**A definitional bug this exposes.** The census tests non-diagonality by $\max|W-\mathrm{diag}\,W|$, which is **frame-dependent**, the only frame-dependent condition in the stratum's definition. Any point can be rotated to look non-diagonal. The definition should be R73's: the simple top eigenvector has bivector rank $>2$.

## Claim 1, confirmed and broader than claimed

Residual $\le1.5\times10^{-15}$ at all ten catalogued points, **and $\le3\times10^{-15}$ at twelve non-critical random Weyl tensors** (criticality residual $0.39$–$0.67$). Since $\sum_\gamma g_\gamma=4(n-1)$ is likewise an identity on $\mathrm{Weyl}_n$, the bound holds at **every** Weyl tensor, the record ties it to critical points unnecessarily. Can it be negative while $\theta>0$? **No, provably**: the bound dominates $\theta$ by construction. At $C_5$ *both* steps are equalities because $\mathfrak m$ carries a single eigenvalue of multiplicity 20 and $g|_{\mathfrak p}$ sits entirely on one $\lambda$, so "100% of the slack" is structural there, not luck, but still one witness.

## Claim 3, proved, with the same correction as R73

$[\phi_m,\phi_n]=0$ across disjoint blocks kills the bilinear $\#$ term, and $E_1E_2=E_2E_1=0$ from disjoint supports, so $E_1\circ E_2=0$ and $Q(\sum E_i)=\sum Q(E_i)$. Criticality forces $a_i\theta_i=\theta'$, **equal weights $\iff$ equal $\theta$**. The general solution $a_i=\theta'/\theta_i$, $\theta'=(\sum\theta_i^{-2})^{-1/2}$, gives $\mathbb{CP}^2\oplus S^3\times S^5$ at $n=12$ ($\theta=0.824719$, residual $1.3\times10^{-15}$) and $\mathbb{CP}^2\oplus\mathbb{CP}^3$ at $n=10$ ($\theta=0.798935$, residual $4.7\times10^{-16}$). With $f_i=E_i/\theta_i$: $f_i\circ f_j=\delta_{ij}f_i$ and $e=\sum f_i$, so $L_ef_j=f_j$ and $\dim E(1)\ge k$, which is what licenses "$\dim E(1)=1\Rightarrow$ indecomposable". Equality is measured, not proved.

## Also

- **Two of the 22 band points are degenerate** ($\theta=0$, Jacobian corank 3, possibly non-isolated); the honest isolated count is 20.
- **The $\mathrm{diag}(s_i)$ term is inert** in the circulant system (the operator never reads the $n\times n$ diagonal) and the $\lfloor n/2\rfloor$ system is rank-deficient by one from scale invariance (Jacobian rank $\lfloor n/2\rfloor-1$ at 100 of 104 solutions).
- **Independently cross-checked** the mid-review $S^4\times S^6$ claim: $\theta=1.185854$, $\dim\mathfrak m=24<25$, $S=3.1\times10^{-28}$, genuinely in the band. Also $S^3\times S^7$ ($1.133893$) and $S^2\times S^8$ ($0.992157$); balanced $S^5\times S^5$ sits at $d=25=$ cap and is excluded.
- **Provenance:** the census script and [plan.md](../plan.md) were rewritten on disk *during* this run with a retraction citing R73. Every verdict above was reached against the committed version, from its own code; the $\mathbb{CP}^m$ refutation was derived before seeing the retraction, and Witness 2 and the claim-3(e) correction are not in it.

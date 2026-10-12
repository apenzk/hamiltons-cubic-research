# Reviewer 73, Gate 2 on the three commits since 4dc2b0b

Ran 2026-08-24. All checks written from scratch; $Q$ matches [review_r30_core.py](../scripts/review_r30_core.py) to $1.8\times10^{-15}$.

| # | claim | verdict |
|---|---|---|
| 1 | identity $4\theta=A-B$ and the sharpened bound | **CONFIRMED**, all four parts |
| 2 | the circulant family | mechanism CONFIRMED; **counts are search yields, not censuses** |
| 3 | the direct-sum construction | (a)–(d) CONFIRMED, (a) **proved**; (e) OVERSTATED |
| 4 | **the headline** | **REFUTED** |

## 4. The headline, refuted by points in the record's own tables

> *Falsifier:* a witness that is non-diagonal, has $\dim E(1)=1$, $S=0$, and $\dim\mathfrak m$ in range.

$\mathbb{CP}^m$ for every $m\ge3$ is such a witness:

| point | $n$ | $\theta$ | crit res | $\dim\mathfrak m$ | cap | $S$ | $\dim E(1)$ |
|---|---|---|---|---|---|---|---|
| $\mathbb{CP}^3$ | 6 | $1.054093$ | $7\times10^{-17}$ | 6 | 9 | $1.0\times10^{-30}$ | **1** |
| $\mathbb{CP}^4$ | 8 | $0.986013$ | $2\times10^{-16}$ | 12 | 16 | $4.8\times10^{-30}$ | **1** |
| $\mathbb{CP}^5$ | 10 | $0.948683$ | $2\times10^{-16}$ | 20 | 25 | $7.5\times10^{-29}$ | **1** |

Each condition provable: $\dim\mathfrak m=m(m-1)=\dim\mathfrak{so}(2m)-\dim\mathfrak u(m)$, so $\mathfrak m$ is the tangent space of $SO(2m)/U(m)$ and $[\mathfrak m,\mathfrak m]\subseteq\mathfrak u(m)\perp\mathfrak m$; $3\le m(m-1)<m^2$; the top eigenvalue is simple with the **Kähler form** as eigenvector, of bivector rank $2m\ge6$, so $W$ is non-diagonal in *every* frame; $\dim E(1)=1$ with margin (next $L_e$ eigenvalue $0.625$, $0.600$).

**$\mathbb{CP}^2$ hid it** by escaping at the *lower* end, $\dim\mathfrak m=2<3$, and it was the indecomposable control. [findings/INDEX.md](../findings/INDEX.md) already stated "$\dim\mathfrak m$ is $6,12$ at $\mathbb{CP}^3$, $\mathbb{CP}^4$ against caps $9,16$" eleven hundred lines from the claim that nothing catalogued lies in the band.

**On scope:** the record's wording ("no known witness") is careful; the error is *factual*, "nothing in the catalogue" is false. The script docstring goes further and asserts about *all* constructible witnesses what was checked for two.

## A second, older error, the band is nearly tight, not low

[findings/INDEX.md](../findings/INDEX.md) records band values as "low, $0.671$ at the $C_5$ blow-up". Every **unbalanced** sphere product is in the band, screened Weyl and critical to $5\times10^{-15}$:

| point | $n$ | $\theta$ | $\dim\mathfrak m$ | cap |
|---|---|---|---|---|
| $S^4\times S^6$ | 10 | **1.185854** | 24 | 25 |
| $S^3\times S^7$ | 10 | $1.133893$ | 21 | 25 |
| $S^3\times S^5$ | 8 | $1.115547$ | 15 | 16 |

Balanced products sit *at* the cap and are outside; unbalanced fall short and are inside. **True band maximum $1.185854$, within $3.2\%$ of $\sqrt{3/2}$.** WRONG, not overstated, and it is what made the band look slack.

## 1–3 in brief

**Claim 1 CONFIRMED**, and stronger than stated: the identity holds at non-critical Weyl tensors too (residual $\le7.3\times10^{-16}$), and fails off $\mathrm{Weyl}_n$ ($0.20$). The bound can be negative but is never vacuous, six circulant band points have $M=0$, bound $-0.612372$, and $\theta=-0.612372$ there too. Over 1200 random Weyl tensors: no violation, no negative bound, $\text{new}\le\text{old}$ always.

**Claim 2**: the collapse to $\lfloor n/2\rfloor$ equations is CONFIRMED and provable, $Q(\mathrm{diag})$ is exactly diagonal, its $(i,j)$ entry is $(M^{\circ2}+M^2)_{ij}$, and $(i,i)$ is not a pair so the diagonal is unconstrained, which is the $\mathrm{diag}(s_i)$ term. All 37 re-screened Weyl and critical. **But 37/32/9 are what 60 starts found**: 400 starts give **68** and **18**. And the run **misses the $C_5$ blow-up itself**, which is a member of this family, the one witness the sharpening rested on. Also **6 of the 9 band points have $\theta<0$**, where "$\theta\le\sqrt{3/2}$" is vacuous.

**Claim 3(a) proved**, and it uses nothing about block sizes, verified at $4{+}5$ and $4{+}6{+}7$. **(e) OVERSTATED**: criticality needs $c_i\theta_i=\theta'$, so $c_i\propto1/\theta_i$ makes *any* collection critical with $\theta'=(\sum\theta_i^{-2})^{-1/2}$. Witness: $\mathbb{CP}^2+S^3\times S^5$ at $n=12$, weights $(0.673380,0.739296)$, criticality $1.35\times10^{-15}$, $\theta=0.824719312$ matching the formula, $S=1.2\times10^{-28}$, $d=17<36$, in the band. **(d)** $\dim E(1)\ge k$ is proved; $=k$ is measured.

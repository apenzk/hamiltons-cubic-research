# Reviewer 82, Gate 2 on the three derivations, 4a32434..b105eac

**Headline: all three pieces of *algebra* are correct and were re-derived by hand. What is wrong is the *conclusions drawn from them*.** All load-bearing arithmetic exact (`Fraction`/`sympy`), no floating point.

| # | claim | verdict |
|---|---|---|
| 1 | $\theta^2=\frac{m(m+1)}{(m-1)(m+2)}$ | formula **CONFIRMED**; **the cap REFUTED** |
| 2 | the general symmetric-pair formula | **CONFIRMED** on 16 pairs; three surrounding claims fail |
| 3 | $c=2h^\vee/I_\rho$ | **CONFIRMED as a theorem**, but the index normalisation is **mis-stated by a factor 2** |

## 1. The formula holds; the cap does not

Steps (a)–(d) all confirmed, and **(c) upgraded from spot values to a proof**: $S_{\mathfrak{kkk}}=c_{\mathfrak k}p$ with the embedding $X\mapsto X\oplus X$ doubling the inner product, so $c_{\mathfrak k}=2(m-2)/2=m-2$; and $S_{\mathfrak{kmm}}=\tfrac12\mathrm{Cas}_{\mathfrak{so}(m)}(\mathrm{Sym}^2_0)q$ with the Casimir at highest weight $2\varepsilon_1$ equal to $(\lambda,\lambda+2\rho)=2m$, giving $mq$. (d)'s $(1,3,3,1)$ coefficients are right because $T=c'^2$ is totally symmetric. Closed form verified exactly at $m=9,10,11,12$, outside the fitted range.

**REFUTED: $\sup\theta=\sqrt{6/5}$.** The construction runs verbatim at $m=2$: $p=\dim\mathfrak{so}(2)=1$, $q=2$, and it yields a genuine Weyl operator (Ricci-flat, Bianchi, critical, **non-diagonal**, $S=0$), at $\theta=1.224744871$. And $m(m+1)/((m-1)(m+2))$ at $m=2$ is exactly $\mathbf{3/2}$. Since $X/(X-2)$ is *decreasing*, **$m=2$ is the maximum, not an excluded case**; the commit never says why $m$ starts at 3.

**That $m=2$ member is $W_{\mathbb{CP}^2}$.** Its $\mathfrak k$ and $\mathfrak m$ are $\mathrm{span}\{e_{01}+e_{23}\}$ and $\mathrm{span}\{e_{02}-e_{13},e_{03}+e_{12}\}$, a $\mathfrak u(1)$ in the self-dual $\mathfrak{su}(2)$, the Nienhaus $2P_1-P_2-P_3$. Eigenvalues $(0.8165,-0.4082,-0.4082,0,0,0)$.

**So the scope claim "$\mathbb{CP}^m$ is NOT of this form" is false at $m=2$**, exactly the member that sets the threshold. In [b_cpm_closed_form.py](../scripts/b_cpm_closed_form.py) the $P_{\mathfrak{su}}$ coefficient $(m-2)/((m+1)(2m-1))$ vanishes **only** at $m=2$. **Consequence: the class's own supremum is $\sqrt{3/2}$, attained, so this formula can never cap the class strictly below the target.**

## 2. The general formula, confirmed, three surrounding claims fail

**CONFIRMED** analytically and at the *operator* level on **16 symmetric pairs** across four Cartan series, $(\mathfrak{su}(m),\mathfrak{so}(m))$, $(\mathfrak{so}(p{+}q),\mathfrak{so}(p){+}\mathfrak{so}(q))$, $(\mathfrak{so}(2m),\mathfrak u(m))$, $(\mathfrak{su}(m),\mathfrak s(\mathfrak u(k){+}\mathfrak u(m{-}k)))$, $(\mathfrak{sp}(2),\mathfrak u(2))$, $(\mathfrak{su}(2),\mathfrak u(1))$, computing $\theta$ from $W^2+W^\#$ in exact rationals. **Exact match on every one**, and $S_{\mathfrak{kkm}}=S_{\mathfrak{mmm}}=0$ on every one. The Killing relation holds exactly (e.g. $(\mathfrak{so}(6),\mathfrak u(3))$: $48+24=72=8\cdot9$).

**(i) $S_{\mathfrak{kkk}}=c_{\mathfrak k}p$ with $c_{\mathfrak k}=2h^\vee(\mathfrak k)/I$ is WRONG whenever $\mathfrak k$ is not simple.** A centre contributes nothing since $[\mathfrak z,\mathfrak k]=0$, and **every Hermitian symmetric pair has a centre in $\mathfrak k$**. Witness $(\mathfrak{so}(6),\mathfrak u(3))$: $S_{\mathfrak{kkk}}/p=48/9=16/3$, and $h^\vee(\mathfrak u(3))$ is undefined. The correct statement is $S_{\mathfrak{kkk}}=\sum_i c_i\dim\mathfrak k_i$ over the simple ideals. **Load-bearing**, since the "finite arithmetic" pitch runs through $c_{\mathfrak k}$ and most Cartan pairs have non-simple $\mathfrak k$.

**(ii) "$S_{\mathfrak{mmm}}=0$ is what puts this class in the target set" is WRONG, the mechanism is backwards.** $(\mathfrak{so}(2k),\mathfrak{so}(k){+}\mathfrak{so}(k))$ is a symmetric pair with $S=0$ whose two-eigenvalue point is **exactly the Weyl tensor of $S^k\times S^k$**, verified analytically that $a/b=-q/p=-k/(k-1)$ is the sphere product's ratio, and symbolically that the formula returns $\theta_0(2k)^2=2-3/k+1/k^2$:

| $k$ | $n$ | $\theta$ | vs $\sqrt{3/2}$ |
|---|---|---|---|
| 5 | 10 | $1.200000000$ | $<$ |
| **6** | **12** | **$1.236033081$** | $\mathbf>$ |
| 8 | 16 | $1.280868846$ | $>$ |
| $\to\infty$ | | $\to\sqrt2$ | $>$ |

**So the class contains $S=0$ points above the threshold. What keeps them out of the live target is DIAGONALITY, not $S$.**

**(iii) "a finite arithmetic problem over Cartan's list" is OVERSTATED, and misses the hard step.** The ansatz $W=a\Pi_{\mathfrak k}+b\Pi_{\mathfrak m}$ is **generically not a Weyl tensor at all**, only **3 of 16** pairs pass Ricci-flat + Bianchi + criticality:

| pair | Ricci-flat | Bianchi | critical | diagonal |
|---|---|---|---|---|
| $(\mathfrak{su}(m),\mathfrak{so}(m))$, $m=3,4,5$ | ✓ | ✓ | ✓ | no |
| $(\mathfrak{so}(2k),\mathfrak{so}(k){+}\mathfrak{so}(k))$ | ✓ | ✓ | ✓ | **yes** |
| $(\mathfrak{su}(2),\mathfrak{so}(2))=\mathbb{CP}^2$ | ✓ | ✓ | ✓ | no |
| $(\mathfrak{so}(p{+}q),\mathfrak{so}(p){+}\mathfrak{so}(q))$, $p\ne q$ | **✗** | ✓ |, | yes |
| $(\mathfrak{so}(2m),\mathfrak u(m))$ | ✓ | **✗** |, | no |
| $(\mathfrak{sp}(2),\mathfrak u(2))$ | ✓ | **✗** |, | no |

Trace-freeness is necessary and far from sufficient. **The real content of "which pairs threaten $\sqrt{3/2}$?" is which $(\mathfrak g,\mathfrak k,\rho)$ give a Weyl operator at all**, a question never posed. Also the invariants depend on $\rho$, which Cartan's list does not supply, and the list is 7 infinite families plus 12 exceptionals.

## 3. $c=2h^\vee/I_\rho$, a theorem, with a normalisation error

**Substance CONFIRMED, and it is a two-line derivation, not a three-point fit**: $B=2h^\vee(\,,)_{\rm norm}$ and $\mathrm{tr}_{\mathbb R}\rho(X)\rho(Y)=2I_\rho(\,,)_{\rm norm}$ give $\langle X,Y\rangle=-I_\rho(\,,)_{\rm norm}$, hence $c=2h^\vee/I_\rho$.

**MIS-STATED: the index values are half the standard ones.** The quoted $I=1,1,2$ are **half** the standard Dynkin index of the complexified representation ($2,2,4$). Derived rather than read off: $I(\Lambda^2V)=(\dim V-2)I(V)$ and $I(\mathrm{adj})=2h^\vee$ force $I(V)=2$ for the $\mathfrak{so}(n)$ vector. **Anyone taking indices from Slansky or LiE and applying the rule as written gets every $c$ wrong by a factor 2.** Correct: $c=4h^\vee/D_{\rho\otimes\mathbb C}$, or $c=2h^\vee/I$ with $I$ normalised so the $\mathfrak{so}(n)$ vector has index 1. Secondary: $h^\vee(\mathfrak{so}(m))=m-2$ fails at $m=3$ ($h^\vee=2$) and $m=4$ (not simple), though $c_{\mathfrak k}=m-2$ survives at both.

**Four further test cases, all exact**, with $c$ computed intrinsically as $-B/\langle,\rangle$ so nothing is circular:

| case | predicted | computed |
|---|---|---|
| $G_2\subset\mathfrak{so}(7)$, the exact 14-dim stabiliser of the octonionic 3-form | $2\cdot4/1=8$ | **8** ✓ |
| $\mathfrak{so}(3)$ on $\mathrm{Sym}^2_0(\mathbb R^3)=\mathbb R^5$ (index far from 1, the sharpest test) | $2\cdot2/10=\mathbf{2/5}$ | **2/5** ✓ |
| $\mathfrak{su}(2)$ on $\mathbb C^2_{\mathbb R}\subset\mathfrak{so}(4)$ | $4$ | 4 ✓ |
| any adjoint rep | $2$ | 2, identically ✓ |

## The orthonormalisation note

Independently confirmed, with a nitpick: $\mathrm{chol}(G^{-1})=L$ **does** orthonormalise, as $L^{\mathsf T}$, since $L^{\mathsf T}GL=I$. Applying $L$ on the wrong side is what failed. The substantive claim stands.

## WRONG vs OVERSTATED

**Wrong:** (1) $\sup\theta=\sqrt{6/5}$ "over the entire infinite family" ($m=2$ is at $\sqrt{3/2}$; (2) "$\mathbb{CP}^m$ is not of this form"), $\mathbb{CP}^2$ is the $m=2$ member; (3) $c_{\mathfrak k}=2h^\vee(\mathfrak k)/I$, fails for non-simple $\mathfrak k$; (4) "$S_{\mathfrak{mmm}}=0$ puts the class in the target set", diagonality does the excluding; (5) the index values $1,1,2$, half the standard.

**Overstated:** (6) "finite arithmetic problem, no searching", the ansatz is Weyl for 3 of 16 pairs, and the missing characterisation is the actual work; (7) framing $c=2h^\vee/I$ as an empirical fit understates it; (8) unstated side condition: $S=S_{\mathfrak{mmm}}$ only if the negative eigenspace *is* the pair's $\mathfrak m$-part, true on all 16, never argued.

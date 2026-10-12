# VERIFY_v226, Lemma L39, the two-eigenvalue formula for an arbitrary symmetric pair

Verifier v226, cold read of [BRIEF_L39.md](BRIEF_L39.md), sections A–C. **No numerical work was done**: no script, no Sage, no Python, no numeric evaluation. Every value below is exact rational or polynomial arithmetic carried out by hand in closed form, and every one of them is either a derivation or a screen of a claim recorded here. Log: [agent_logs/verify-L39-v226.log](../agent_logs/verify-L39-v226.log).

## Claim table

| # | claim | verdict |
| --- | --- | --- |
| 1 | $S_{\mathfrak{kkm}}=0$ from $[\mathfrak k,\mathfrak k]\subseteq\mathfrak k\perp\mathfrak m$, $W$-free | **PROVEN** |
| 2 | $S_{\mathfrak{mmm}}=0$ from $[\mathfrak m,\mathfrak m]\subseteq\mathfrak k\perp\mathfrak m$, $W$-free | **PROVEN** |
| 3 | $[\mathfrak k,\mathfrak m]\subseteq\mathfrak m$ used in neither vanishing; it closes the Killing split | **PROVEN** |
| 4 | the four-invariant form $\theta^2=(S_{\mathfrak{kkk}}q^2+3S_{\mathfrak{kmm}}p^2-2p^3+2pq^2)^2/(4p^3q(p+q)^3)$ | **PROVEN** (derived in full, §3) |
| 5 | the denominator is produced by $a^6$ rather than asserted | **PROVEN** |
| 6 | $S_{\mathfrak{kkk}}+S_{\mathfrak{kmm}}=cp$ for $\mathfrak g$ simple | **PROVEN** |
| 7 | $S_{\mathfrak{kmm}}=cq/2$, hence $S_{\mathfrak{kkk}}=c(p-q/2)$, by the same argument on $\mathfrak m$ | **PROVEN** (§4; the load-bearing step, and it holds) |
| 8 | the three-invariant form $\theta^2=(cq(3p-q)-4p(p-q))^2/(16p^3q(p+q))$ | **PROVEN**, and it is the exact reduction of #4 under #7 |
| 9 | the canonical entry's "$\theta$ depends on $p$, $q$, $S_{\mathfrak{kkk}}$ and $c$ alone" | **TRUE BUT NOT MINIMAL**, $S_{\mathfrak{kkk}}$ is determined by $(p,q,c)$; three invariants suffice |
| 10 | $q\le2p$ for every symmetric pair with $\mathfrak g$ simple | **PROVEN** |
| 11 | equality in #10 exactly when $\mathfrak k$ is abelian | **PROVEN**, witness $(\mathfrak{su}(2),\mathfrak u(1))$ at $(p,q)=(1,2)$ |
| 12 | the equal-$\theta$ pair is forced, both members at $(p,q,c)=(7,8,8)$ | **PROVEN**, and stronger than stated (§7) |
| 13 | maximiser numerator collapses to $4k^2(k-1)^2(2k-1)$ at $c=4(k-1)$ | **PROVEN** |
| 14 | the maximiser returns $2(n-1)(n-2)/n^2$ **exactly** | **PROVEN** |
| 15 | "the maximiser decides the $I_\rho$ normalisation rather than table data doing it" | **OVERSTATED**, the table's own $\mathfrak{so}(n)$ row already gives $I_\rho=1$; the maximiser confirms and pins uniquely among $c>0$, it does not decide |
| 16 | admissibility: the ansatz is generically not a Weyl tensor; this copy dropped the guard | **PROVEN** (the guard is in section A and absent from section C) |
| 17 | the overshoot figures $1.389084$ vs $\Theta_9^2=1.371429$, and $12.6\%$ at $n=5$ | **PROVEN**, both reproduce exactly as $64009/46080$ vs $48/35$, and $\tfrac{961/960}{8/9}=8649/7680$ |
| 18 | "at unbalanced sphere pairs it overshoots the true $\theta$ **every time**" | **BROKEN**, refuted as written by $(\mathfrak{so}(9),\mathfrak{so}(8))$, $\theta^2=7/18$ (§8) |
| 19 | $(1,3,3,1)$ are multinomial and close only in the ordered reading | **PROVEN** |
| 20 | "L114's $6/4/2$ identity is the *unordered* form of the same statement" | **BROKEN**, $6/4/2$ ordered is $(1,2,1)$, a single row; $(1,3,3,1)$ is the two-row sum (§9) |
| 21 | "$S_{XYZ}$ is defined nowhere on the record, conventions.md included" | **STALE / FALSE**, [conventions.md](../findings/conventions.md) line 20 defines it, adopted 2026-09-04 |
| 22 | $h^\vee(\mathfrak{so}(m))=m-2$, $I_\rho=2$ fail at $m=3$ and $m=4$ | **PROVEN** |
| 23 | $c=m-2$ survives at $m=3,4$ by a doubling argument | **PROVEN** (§10); **no value in the $c$ column moves**; the $h^\vee$ and $I_\rho$ cells do |
| 24 | hypotheses $p\ge1$, $q\ge1$, the $\Lambda^2$ metric normalisation, and the extension of $W$ to $\mathfrak g^\perp$ | **HYPOTHESIS-DEBT**, all four load-bearing, none stated in either copy (§11) |

**One line: the mathematics of L39 is correct and the three-invariant reduction is exact, but the statement is missing four load-bearing hypotheses and two of the five annotations assert things that are false.**

**Verdict: PROVEN, hypotheses corrected.**

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), not restated.

- Line 60, **"Structure constants $c_{abc}=\langle[v_a,v_b],v_c\rangle$ are totally antisymmetric, the inner product being ad-invariant; so $T_{abc}=c_{abc}^2$ is totally symmetric and vanishes when two indices coincide."**
- Line 20, $S_{XYZ}$ is **"the block-restricted contraction of $T$ over ORDERED slots"**, with **"conversion is per pattern, $S^{\mathrm{ord}}=6S^{\mathrm{unord}}$ on $\mathfrak{mmm}$ and $\mathfrak{hhh}$, $2\times$ on the mixed patterns, not a global constant."**
- Line 59, **"The Killing form of $\mathfrak{so}(n)$ is $B(X,Y)=(n-2)\operatorname{tr}(XY)$, with $\operatorname{tr}(v^2)=-2$ for a unit bivector, so $\kappa=2(n-2)$ in an orthonormal basis. Killing constants come from the definition, never from an index convention."**
- Line 118, **"$\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)$ over ordered pairs, $\sum_{\beta<\gamma}T_{\alpha\beta\gamma}=n-2$ over unordered, so convert before comparing constants."** This is [Lemma L153](../findings/bounds.md).
- Line 121, **"The Killing constant of a SUBALGEBRA $\mathfrak g$ simple: $\sum_{b\in\mathfrak g}\lVert[a,b]\rVert^2=c\lVert a\rVert^2$, with $c=2h^\vee(\mathfrak g)/I_\rho$ and $I$ normalised so the $\mathfrak{so}(n)$ vector representation has index $1$."**
- Line 19, $\Theta_n$ is **"the diagonal maximum; equals $\theta_0(n)$ at even $n$, and $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$."**
- Line 18, $\theta_0(n)^2=2(n-1)(n-2)/n^2$.
- Line 38, **"$\mathfrak m$ carries three incompatible senses across the record"**; L39 uses the third, [target.md](../findings/target.md)'s symmetric-pair odd part, and uses it consistently.

Line 59's closing sentence settles the $m=3$/$m=4$ question of §10 before it is asked: the record's own rule is that $c$ comes from the definition, and the $h^\vee/I_\rho$ table is a convenience.

## The hypothesis inventory

For the four-invariant form (section C's display, section A's statement):

| # | hypothesis | stated? | used? | where used |
| --- | --- | --- | --- | --- |
| H1 | $(\mathfrak g,\mathfrak k)$ a symmetric pair: $\mathfrak g=\mathfrak k\oplus\mathfrak m$ orthogonal, $[\mathfrak k,\mathfrak k]\subseteq\mathfrak k$, $[\mathfrak k,\mathfrak m]\subseteq\mathfrak m$, $[\mathfrak m,\mathfrak m]\subseteq\mathfrak k$ | yes | H1a, H1c yes; H1b **not** in the vanishings | §2 |
| H2 | $\mathfrak g\subseteq\mathfrak{so}(n)$ | yes | only to fix the inner product; $n$ appears nowhere in the formula | §11.2 |
| H3 | the inner product on $\Lambda^2\mathbb R^n$ has $e_i\wedge e_j$ orthonormal, i.e. $\langle A,B\rangle=\tfrac12\operatorname{tr}(A^{\mathsf T}B)$ | **no** | fixes $c$ (which scales as $1/\lambda$ under $\langle,\rangle\mapsto\lambda\langle,\rangle$) and the value of every $S$ | §11.2 |
| H4 | $W=a\Pi_{\mathfrak k}+b\Pi_{\mathfrak m}$ extended by **zero** on $\mathfrak g^\perp\subseteq\Lambda^2\mathbb R^n$ | **no** | pins the spectrum as $(a,b,0)$ whenever $\mathfrak g\subsetneq\mathfrak{so}(n)$, so the name "two-eigenvalue" holds only for $\mathfrak g=\mathfrak{so}(n)$ | §11.3 |
| H5 | $ap+bq=0$ and $a^2p+b^2q=1$ | yes | $b=-ap/q$, $a^2=q/(p(p+q))$ | §3 |
| H6 | $p\ge1$ and $q\ge1$ | **no** (the Lean file has them; the prose does not) | division by $p^3q$ | §11.1 |
| H7 | $P(W)=\operatorname{tr}(W^3)+\tfrac12\sum T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$, the Böhm–Wilking $\#$ normalisation | **no** | the whole cubic | §3.1 |
| H8 | $W\in\mathcal W_n$, Ricci-flat **and** first Bianchi | **in section A only, dropped from section C** | needed for $\theta$ to be a Weyl-tensor value at all | §6 |

Additional, for the three-invariant form only:

| # | hypothesis | stated? | used? |
| --- | --- | --- | --- |
| H9 | $\mathfrak g$ simple | in section A; **not restated on section C's display** | existence of a single $c$; $c>0$ for $q\le2p$ |

$\mathfrak k$ simple is **not** needed anywhere, see §5, which is a correction to the record's own emphasis.

## 1. What the block actually asserts

Section A (canonical, [results.md](../results.md) 525–531) states the four-invariant form and **carries the Weyl-ness guard**: *"The formula gives the value of the point and decides nothing about whether that point is a Weyl tensor."* Section B (landscape) states the same formula without the guard. Section C ([target.md](../findings/target.md) 655–677) states the same formula, again without the guard, and adds five annotations. Annotation 3 is a complaint that the guard is missing from section C. The complaint is correct about section C and wrong about the record: section A has it.

## 2. The two vanishings

Fix an orthonormal basis $\{v_\alpha\}$ of $\mathfrak{so}(n)$ adapted to $\mathfrak k\oplus\mathfrak m\oplus\mathfrak g^\perp$, and $T_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle^2$ per conventions line 60.

$S_{\mathfrak{kkm}}=\sum_{\alpha,\beta\in\mathfrak k}\sum_{\gamma\in\mathfrak m}\langle[v_\alpha,v_\beta],v_\gamma\rangle^2$. Every bracket lies in $[\mathfrak k,\mathfrak k]\subseteq\mathfrak k$, and $\mathfrak k\perp\mathfrak m$, so every summand is zero. $S_{\mathfrak{mmm}}=\sum_{\alpha,\beta,\gamma\in\mathfrak m}\langle[v_\alpha,v_\beta],v_\gamma\rangle^2$ with $[\mathfrak m,\mathfrak m]\subseteq\mathfrak k\perp\mathfrak m$, likewise zero.

Neither uses $W$, $a$, $b$, criticality, or the grading beyond the two inclusions. **Annotation 1 is correct, and "identically" does understate it**, these are statements about the decomposition, so they hold at every point of the two-parameter family and at every other operator too. $[\mathfrak k,\mathfrak m]\subseteq\mathfrak m$ is used in neither; §4 shows it is exactly what closes the Killing split. **Annotation 1: PROVEN in full.**

The full symmetry of $T$ makes the *pattern* $\mathfrak{kkm}$ cover all three slot placements, so no placement escapes.

## 3. The four-invariant formula, derived

### 3.1 The cubic

$P(W)=\langle W,W^2+W^\#\rangle=\operatorname{tr}(W^3)+\langle W,W^\#\rangle$. With the standard $\#$, $(W^\#)_{\alpha\beta}=\tfrac12\sum_{\gamma\delta\epsilon\zeta}c_{\alpha\gamma\delta}c_{\beta\epsilon\zeta}W_{\gamma\epsilon}W_{\delta\zeta}$; for $W$ diagonal with eigenvalues $\lambda_\gamma$ this is $\tfrac12\sum_{\gamma\delta}c_{\alpha\gamma\delta}c_{\beta\gamma\delta}\lambda_\gamma\lambda_\delta$, so

$$\langle W,W^\#\rangle=\tfrac12\sum_{\alpha\gamma\delta}c_{\alpha\gamma\delta}^2\lambda_\alpha\lambda_\gamma\lambda_\delta=\tfrac12\Sigma,\qquad \Sigma:=\sum_{\alpha\beta\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma.$$

The factor $\tfrac12$ is H7 and is nowhere on the record; it is the Böhm–Wilking normalisation and it is what the record's line "$\theta=\operatorname{tr}(W^3)+\tfrac12[a^3S_{\mathfrak{kkk}}+3ab^2S_{\mathfrak{kmm}}]$" silently uses.

### 3.2 The multinomial expansion

With $\lambda\equiv a$ on $\mathfrak k$, $b$ on $\mathfrak m$, $0$ on $\mathfrak g^\perp$, and $T$ totally symmetric,

$$\Sigma=a^3S_{\mathfrak{kkk}}+3a^2b\,S_{\mathfrak{kkm}}+3ab^2S_{\mathfrak{kmm}}+b^3S_{\mathfrak{mmm}},$$

the $3$'s counting the three slot placements of the odd index. Terms touching $\mathfrak g^\perp$ carry a factor $\lambda=0$ and drop, so the padding is harmless *for the value*. By §2 the middle-left and right terms vanish.

### 3.3 The elimination

$b=-ap/q$ and $a^2=q/(p(p+q))$. Then $\operatorname{tr}(W^3)=a^3p+b^3q=a^3p(q^2-p^2)/q^2$, and $ab^2=a^3p^2/q^2$, so

$$\theta=P(W)=\frac{a^3}{2q^2}\Big[S_{\mathfrak{kkk}}q^2+3S_{\mathfrak{kmm}}p^2+2p(q^2-p^2)\Big]=\frac{a^3}{2q^2}\,N,\quad N:=S_{\mathfrak{kkk}}q^2+3S_{\mathfrak{kmm}}p^2-2p^3+2pq^2.$$

Squaring, $a^6=q^3/(p^3(p+q)^3)$ gives

$$\theta^2=\frac{q^3}{4q^4p^3(p+q)^3}N^2=\frac{N^2}{4p^3q(p+q)^3}.$$

**The formula is correct, and annotation 1's remark that "the denominator $4p^3q(p+q)^3$ is produced by $a^6$ rather than asserted" is exactly right**, $a^6$ supplies $q^3/(p^3(p+q)^3)$ and the $1/(2q^2)$ supplies the $4$ and the surviving $q$.

## 4. The reduction to three invariants, the step the brief singles out

**The $\mathfrak k$ row.** For $\mathfrak g$ simple and $\langle,\rangle$ ad-invariant, $\sum_{b\in\mathfrak g}\lVert[a,b]\rVert^2=-B(a,a)=c\lVert a\rVert^2$ with $c$ constant, because $-B$ and $\langle,\rangle$ are both invariant forms and $\mathfrak g$ simple makes the invariant form unique up to scale. In index form, $\sum_{\beta,\gamma\in\mathfrak g}T_{\alpha\beta\gamma}=c$ for each unit $v_\alpha\in\mathfrak g$. Summing over $\alpha\in\mathfrak k$ and splitting the $(\beta,\gamma)$ range:

- $\beta\in\mathfrak k$: $[\mathfrak k,\mathfrak k]\subseteq\mathfrak k$ forces $\gamma\in\mathfrak k$, gives $S_{\mathfrak{kkk}}$;
- $\beta\in\mathfrak m$: $[\mathfrak k,\mathfrak m]\subseteq\mathfrak m$ forces $\gamma\in\mathfrak m$, gives $S_{\mathfrak{kmm}}$.

$$S_{\mathfrak{kkk}}+S_{\mathfrak{kmm}}=cp.$$

This is where $[\mathfrak k,\mathfrak m]\subseteq\mathfrak m$ enters, **annotation 1's "it closes the Killing split instead" is verified.**

**The $\mathfrak m$ row, the step the brief asks to be checked in particular.** Sum the same row identity over $\alpha\in\mathfrak m$, total $cq$:

- $\beta\in\mathfrak k$: $[\mathfrak m,\mathfrak k]\subseteq\mathfrak m$ forces $\gamma\in\mathfrak m$, the pattern is one $\mathfrak k$ index and two $\mathfrak m$ indices, and by the total symmetry of $T$ (conventions line 60) that block sum is $S_{\mathfrak{kmm}}$;
- $\beta\in\mathfrak m$: $[\mathfrak m,\mathfrak m]\subseteq\mathfrak k$ forces $\gamma\in\mathfrak k$, the same pattern again, so $S_{\mathfrak{kmm}}$.

$$2S_{\mathfrak{kmm}}=cq\ \Longrightarrow\ S_{\mathfrak{kmm}}=\frac{cq}{2},\qquad S_{\mathfrak{kkk}}=cp-\frac{cq}{2}=c\Big(p-\frac q2\Big).$$

**The step holds.** It leans on exactly two things: total symmetry of $T$, which is on the record; and $\mathfrak g$ simple, which is H9. It does **not** need $\mathfrak k$ simple, $\mathfrak k$ centreless, or anything about $W$.

**The reduction.** Substituting,

$$N=\frac{c(2p-q)q^2}{2}+\frac{3cqp^2}{2}-2p(p^2-q^2)=\frac{cq}{2}\big(3p^2+2pq-q^2\big)-2p(p-q)(p+q),$$

and $3p^2+2pq-q^2=(3p-q)(p+q)$, so

$$N=\frac{p+q}{2}\Big[cq(3p-q)-4p(p-q)\Big],\qquad \theta^2=\frac{(p+q)^2\big[cq(3p-q)-4p(p-q)\big]^2}{4\cdot4\,p^3q(p+q)^3}=\frac{\big[cq(3p-q)-4p(p-q)\big]^2}{16\,p^3q(p+q)}.$$

**The second formula reduces to the first, exactly, under H1 and H9 alone.** The $(p+q)^3$ drops to $(p+q)$ and the $4$ becomes $16$. This matches [L39.lean](../lean/HamiltonsCubic/Results/L39.lean)'s `numerator_factors` and `theta_sq_reduced`, which carry `0 < p` and `0 < q` as hypotheses, the Lean is stricter than the prose.

**Which should be canonical.** Both, with their hypotheses attached and the relationship stated:

- **four invariants**, the general form, valid for *any* symmetric pair inside $\mathfrak{so}(n)$, needing no $c$ and therefore no simplicity. It is the right fallback for $\mathfrak g$ semisimple with non-isomorphic factors, where [target.md](../findings/target.md) line 369 records that no single $c$ exists ($\mathfrak{so}(3)+\mathfrak{so}(5)$ in $\mathfrak{so}(8)$ giving $c\in\{2,6\}$);
- **three invariants**, the canonical form *for $\mathfrak g$ simple*, which is the only case in which the record's $c=2h^\vee/I_\rho$ machinery is meaningful, and strictly sharper there.

**Annotation 2's headline "THE REDUCTION IS TO THREE INVARIANTS, NOT FOUR" is correct, and it makes section A's "four invariants" sentence non-minimal, see §5.**

## 5. Consequence the record has not drawn: the $\mathfrak k$-centre correction is unnecessary here

[target.md](../findings/target.md)'s "Two corrections" and section A's clause *"when $\mathfrak k$ has a centre, $S_{\mathfrak{kkk}}$ is the sum over its simple ideals"* both address the route $S_{\mathfrak{kkk}}=c_{\mathfrak k}p$, which does fail when $\mathfrak k$ is not simple. Under §4 that route is not needed: $S_{\mathfrak{kkk}}=c_{\mathfrak g}(p-q/2)$ uses only $\mathfrak g$'s constant.

Screen against the record's own Hermitian witness $(\mathfrak{so}(6),\mathfrak u(3))$, where the record reports $S_{\mathfrak{kkk}}=48$, $p=9$: here $q=15-9=6$ and $c=2(6-2)=8$, so $c(p-q/2)=8(9-3)=48$. **Exact.** The pair that breaks the $c_{\mathfrak k}p$ route is handled by the reduction without a murmur.

So section A's sentence is true but redundant, and its "so $\theta$ depends on $p$, $q$, $S_{\mathfrak{kkk}}$ and $c$ alone" over-counts the free invariants by one.

## 6. Admissibility, what hypothesis the formula needs to be about Weyl tensors at all

**H8: $W\in\mathcal W_n$.** Concretely, under $\operatorname{Sym}^2(\Lambda^2\mathbb R^n)=\mathcal W_n\oplus(\text{Ricci part})\oplus(\text{scalar})\oplus\Lambda^4\mathbb R^n$, the ansatz must have

1. **vanishing $\Lambda^4$ component**, the first Bianchi identity; and
2. **vanishing trace-free Ricci component**, Ricci-flatness.

The normalisation $ap+bq=0$ is only $\operatorname{tr}W=0$, the scalar part. It is the weakest of the three and the only one the ansatz enforces. [target.md](../findings/target.md) records that of 16 pairs built, **three** pass: $(\mathfrak{su}(m),\mathfrak{so}(m))$, $(\mathfrak{so}(2k),\mathfrak{so}(k)+\mathfrak{so}(k))$, $(\mathfrak{su}(2),\mathfrak{so}(2))$; $(\mathfrak{so}(2m),\mathfrak u(m))$ and $(\mathfrak{sp}(2),\mathfrak u(2))$ fail Bianchi; unequal sphere pairs fail Ricci-flatness. **So the guard is load-bearing and annotation 3 is right that section C dropped it.** Section A carries it.

A sufficient structural condition already on the record is [target.md](../findings/target.md) line 470's $\dim\mathcal W_n^K=1$ (with $(\Lambda^4\mathbb R^n)^K=0$ doing other work there); this verifier does not endorse it as necessary, and it is not what L39 states.

**The overshoot figures, screened in closed form.** For $(\mathfrak{so}(n),\mathfrak{so}(a)\oplus\mathfrak{so}(b))$, $a+b=n$, $c=2(n-2)$:

- $n=9$, $(a,b)=(4,5)$: $p=6+10=16$, $q=20$, $p+q=36$, $3p-q=28$, $p-q=-4$; bracket $=14\cdot20\cdot28+4\cdot16\cdot4=7840+256=8096$; $\theta^2=8096^2/(16\cdot16^3\cdot20\cdot36)=64009/46080$. And $\Theta_9^2=2\cdot8\cdot6/(10\cdot7)=48/35$. $64009/46080=1.3890842\ldots$, $48/35=1.3714285\ldots$, **the annotation's $1.389084$ against $1.371429$ is exact.**
- $n=5$, $(a,b)=(2,3)$: $p=1+3=4$, $q=6$, $p+q=10$, $3p-q=6$, $p-q=-2$; bracket $=6\cdot6\cdot6+4\cdot4\cdot2=248$; $\theta^2=248^2/(16\cdot64\cdot6\cdot10)=961/960$. $\Theta_5^2=2\cdot4\cdot2/(6\cdot3)=8/9$. Ratio $\dfrac{961/960}{8/9}=\dfrac{8649}{7680}=1.126172\ldots$, **the annotation's $12.6\%$ is exact, and it is a ratio in $\theta^2$, not in $\theta$.**

**One logical caveat the annotation does not flag.** Reading the overshoot *as a refutation of admissibility* presupposes that $\Theta_n$ is the true supremum, which is Conjecture A, the thing the programme is trying to prove. The argument is therefore circular if used that way. The record's independent, non-circular witness is the direct failure of Ricci-flatness at $a\ne b$, and that is what should be cited.

## 7. The maximiser, and the forced pair

**Maximiser.** $(\mathfrak{so}(2k),\mathfrak{so}(k)\oplus\mathfrak{so}(k))$, $n=2k$: $p=2\binom k2=k(k-1)$, $q=k^2$ (as $\mathfrak m\cong\mathbb R^k\otimes\mathbb R^k$), $p+q=k(2k-1)$, $3p-q=k(2k-3)$, $p-q=-k$. General $c$:

$$cq(3p-q)-4p(p-q)=ck^3(2k-3)+4k^2(k-1).$$

At $c=4(k-1)$ this is $4k^2(k-1)\big[k(2k-3)+1\big]=4k^2(k-1)(2k-1)(k-1)=4k^2(k-1)^2(2k-1)$, **the stated collapse, exactly.** Then

$$\theta^2=\frac{16k^4(k-1)^4(2k-1)^2}{16\,k^3(k-1)^3\cdot k^2\cdot k(2k-1)}=\frac{(k-1)(2k-1)}{k^2},$$

and $2(n-1)(n-2)/n^2$ at $n=2k$ is $2(2k-1)(2k-2)/(4k^2)=(k-1)(2k-1)/k^2$. **Identical, exactly. Claims 13 and 14 hold.**

**On claim 15.** The equation $\theta^2(c)=\theta_0(2k)^2$ has two roots; the other is $c=-4(k-1)(2k^2-3k+2)/(k(2k-3))<0$ for $k\ge2$, excluded by $c>0$. So the maximiser pins $c=4(k-1)$ uniquely, and $I_\rho=2$ would give $\theta^2=(2k^2-3k+2)^2/(4k^2(k-1)(2k-1))$ ($121/360$ at $k=3$ against the correct $10/9$) so it does discriminate. But [target.md](../findings/target.md)'s own table row *"$\mathfrak{so}(n)$, standard, $h^\vee=n-2$, $I_\rho=1$, $c=2(n-2)$"* already fixes $c(\mathfrak{so}(2k))=4(k-1)$, as does conventions line 59 intrinsically. **The maximiser confirms the normalisation; it does not decide it. Annotation 4 overstates.** Note also that the check presupposes $\theta_0(2k)^2$ is the value at $S^k\times S^k$, which is external input.

**The $k=2$ boundary.** $\mathfrak{so}(4)$ is **not simple**, so H9 fails, but $\mathfrak{so}(4)=\mathfrak{su}(2)\oplus\mathfrak{su}(2)$ has *isomorphic* factors, so a single $c=4$ still exists and $\theta^2=3/4=\theta_0(4)^2$. The record's guard (no single $c$ for non-isomorphic factors) is exactly the right one and is satisfied. The $k=1$ boundary is $p=0$ and is excluded by H6.

**The crossover.** $\theta_0(n)^2=3/2$ at $n^2-12n+8=0$, $n=6\pm2\sqrt7$, and $6+2\sqrt7=11.2915\ldots$, so the balanced family exceeds $\sqrt{3/2}$ from $n=12$, i.e. $k=6$, matching [target.md](../findings/target.md) line 343's "exceeds $\sqrt{3/2}$ from $k=6$ on". At $k=5$, $\theta^2=4\cdot9/25=36/25=1.44<3/2$; at $k=6$, $5\cdot11/36=55/36>3/2$. **The boundary is consistent, and no contradiction with Conjecture A arises, because $\Theta_{12}^2=\theta_0(12)^2=55/36$ is the balanced value itself.**

**The forced pair.** $(\mathfrak{so}(6),\mathfrak{so}(2)\oplus\mathfrak{so}(4))$: $p=1+6=7$, $q=15-7=8$, $c=2(6-2)=8$. $(\mathfrak{su}(4),\mathfrak s(\mathfrak u(2)\oplus\mathfrak u(2)))$: $p=3+3+1=7$, $q=15-7=8$, $c=2h^\vee(\mathfrak{su}(4))=8$. Both $(7,8,8)$; $\theta^2$ is a function of $(p,q,c)$ alone by §4, so equality is forced. **Claim 12 holds.**

Screen against the record's independently computed values: $S_{\mathfrak{kmm}}=cq/2=32$ and $S_{\mathfrak{kkk}}=c(p-q/2)=8\cdot3=24$, which are precisely the $(24,32)$ [target.md](../findings/target.md) line 369 reports. And bracket $=8\cdot8\cdot13+4\cdot7=832+28=860$, $\theta^2=860^2/(16\cdot343\cdot8\cdot15)=739600/658560=9245/8232$, **exactly the record's $\theta^2=9245/8232$.** Three independent confirmations of the reduction.

**It is stronger than "forced".** $\mathfrak{so}(6)\cong\mathfrak{su}(4)$ (the $D_3=A_3$ isomorphism), under which $\mathfrak{so}(2)\oplus\mathfrak{so}(4)\cong\mathfrak u(1)\oplus\mathfrak{su}(2)\oplus\mathfrak{su}(2)\cong\mathfrak s(\mathfrak u(2)\oplus\mathfrak u(2))$, and $SO(6)/(SO(2)\times SO(4))=Q_4$ is $SU(4)/S(U(2)\times U(2))=G_2(\mathbb C^4)$, the Klein quadric. **These are one symmetric pair written twice.** That does not weaken §4 (it strengthens "forced" to "trivially forced") but it does mean section A's use of the pair as *"two pairs with identical $(p,q,S_{\mathfrak{kkk}},S_{\mathfrak{kmm}})$ can fail it differently"* is really *one pair under two embeddings $\rho$*, which is the $\rho$-dependence point [target.md](../findings/target.md) already makes separately. The wording should say "two embeddings", not "two pairs".

## 8. $q\le2p$, and the refutation of "every time"

**$q\le2p$.** $S_{\mathfrak{kkk}}=\sum_{\alpha,\beta\in\mathfrak k}\lVert\Pi_{\mathfrak k}[v_\alpha,v_\beta]\rVert^2=\sum_{\alpha,\beta\in\mathfrak k}\lVert[v_\alpha,v_\beta]\rVert^2\ge0$, using $[\mathfrak k,\mathfrak k]\subseteq\mathfrak k$. By §4 this is $c(p-q/2)$, and $c>0$ whenever $\mathfrak g$ is simple (hence non-abelian, so some bracket is nonzero). Therefore $p\ge q/2$. Equality forces $S_{\mathfrak{kkk}}=0$, i.e. every $[v_\alpha,v_\beta]=0$, i.e. $\mathfrak k$ abelian; conversely $\mathfrak k$ abelian gives $S_{\mathfrak{kkk}}=0$ and $q=2p$. **Claim 10 and claim 11 both hold.**

**The universal claim has a witness**, which the record does not supply: $(\mathfrak{su}(2),\mathfrak u(1))$, $p=1$, $q=2$, $\mathfrak k$ abelian, $\mathfrak g$ simple. This is also **the smallest admissible $(p,q)$**: $p=0$ forces $\mathfrak g$ abelian (since $[\mathfrak m,\mathfrak m]\subseteq\mathfrak k=0$ and $[\mathfrak k,\cdot]=0$), and $q=1$ with $q\le2p$ gives $\dim\mathfrak g=2$, never simple. Screen: $p=1$, $q=2$, $c=2h^\vee(\mathfrak{su}(2))=4$; bracket $=4\cdot2\cdot1+4\cdot1\cdot1=12$; $\theta^2=144/(16\cdot1\cdot2\cdot3)=3/2$. **The smallest member of the class sits on the $q=2p$ boundary and lands on $\sqrt{3/2}$ exactly**, it is [target.md](../findings/target.md)'s $m=2$ member, $W_{\mathbb{CP}^2}$.

**Claim 18, "at unbalanced sphere pairs it overshoots the true $\theta$ every time", BROKEN.**

*Located:* annotation 3, section C, the sentence beginning "The formula values an operator that is generically not a Weyl tensor".

*Exhibited in closed form:* take $n=9$ and the unbalanced split $(a,b)=(1,8)$, i.e. $(\mathfrak{so}(9),\mathfrak{so}(8))$, the round sphere $S^8$. Then $p=\binom82=28$, $q=8$, $c=2(9-2)=14$, $p+q=36$, $3p-q=76$, $p-q=20$:

$$\text{bracket}=14\cdot8\cdot76-4\cdot28\cdot20=8512-2240=6272,\qquad \theta^2=\frac{6272^2}{16\cdot28^3\cdot8\cdot36}=\frac{39337984}{101154816}=\frac{7}{18}.$$

$7/18=0.3888\ldots$, against $\Theta_9^2=48/35=1.3714\ldots$. **It undershoots by a factor of more than three.** The same happens at every strongly unbalanced split; nothing about the exhibit is special to $n=9$.

*Argued the opposite:* the charitable reading is that "unbalanced sphere pair" means the *near-balanced* odd-$n$ split $\{k,k+1\}$, which is what both quoted exhibits are. Under that reading the claim is not refuted, and I checked its sign in closed form. Writing $n=2k+1$, $a=k$, $b=k+1$: $p=(n^2-n-2s)/2$ with $s=ab=k^2+k$, and the general sphere-pair form is $\theta^2=(n-1)\big[3n^2s-8s^2-n^2(n-1)\big]^2\big/\big(n\,s\,(n(n-1)-2s)^3\big)$, which at $s=k^2+k$ becomes $(4k^3-k+1)^2/\big(4k^4(2k+1)(k+1)\big)$, against $\Theta_{2k+1}^2=4k(k-1)/\big((k+1)(2k-1)\big)$. Their difference is

$$\theta^2-\Theta_{2k+1}^2=\frac{24k^4-6k^3-5k^2+4k-1}{4k^4(2k+1)(k+1)(2k-1)}>0\quad\text{for all }k\ge1,$$

since $24k^4-6k^3=6k^3(4k-1)>0$ dominates $5k^2$ and $4k-1>0$. At $k=4$ this is $5695/322560=0.0176556$, matching $1.3890842-1.3714286$. **So the near-balanced claim is true and provable; the claim as written is false; and neither version has an argument on file.** The record carries only two screened data points where a two-line polynomial argument was available.

*Verdict:* the quantifier is BROKEN as written; the intended narrow statement is HYPOTHESIS-DEBT until the scope is stated.

## 9. The convention

**$(1,3,3,1)$ is multinomial and closes only in the ordered reading, correct.** §3.2's expansion has weights $1,3,3,1$ with $S$ read as ordered slots with the odd index in a fixed slot, which is exactly conventions line 20's reading. Converting per pattern ($6\times$ on $\mathfrak{kkk}$ and $\mathfrak{mmm}$, $2\times$ on the mixed), the unordered form is $6a^3S^{\rm un}_{\mathfrak{kkk}}+6a^2bS^{\rm un}_{\mathfrak{kkm}}+6ab^2S^{\rm un}_{\mathfrak{kmm}}+6b^3S^{\rm un}_{\mathfrak{mmm}}$, **all four coefficients equal, as annotation 5 says.** So far the annotation holds.

**"L114's $6/4/2$ identity is the *unordered* form of the same statement", BROKEN.**

*Located:* annotation 5, section C.

*Exhibited:* [L114](../findings/bounds-relaxations.md) is $6S_{\mathfrak{mmm}}+4S_{\mathfrak{mmh}}+2S_{\mathfrak{mhh}}=2d(n-2)$ **unordered**. Converting per pattern ($6S^{\rm un}_{\mathfrak{mmm}}=S^{\rm ord}_{\mathfrak{mmm}}$, $4S^{\rm un}_{\mathfrak{mmh}}=2S^{\rm ord}_{\mathfrak{mmh}}$, $2S^{\rm un}_{\mathfrak{mhh}}=S^{\rm ord}_{\mathfrak{mhh}}$):

$$S^{\rm ord}_{\mathfrak{mmm}}+2S^{\rm ord}_{\mathfrak{mmh}}+S^{\rm ord}_{\mathfrak{mhh}}=2d(n-2).$$

Weights $(1,2,1)$, **three** terms. This is the row marginal of conventions line 118 summed over $\alpha\in\mathfrak m$, with $(\beta,\gamma)$ ranging over $(\mathfrak m,\mathfrak m),(\mathfrak m,\mathfrak h),(\mathfrak h,\mathfrak m),(\mathfrak h,\mathfrak h)$. L39's $(1,3,3,1)$ has **four** terms. They cannot be the same statement in two readings: no per-pattern conversion turns $(1,2,1)$ into $(1,3,3,1)$.

What *is* true, and what [L114](../findings/bounds-relaxations.md)'s own annotation already says correctly, is that **L114 plus its $\mathfrak h$-row twin** sum to the $1/3/3/1$ identity: adding $S_{\mathfrak{hhh}}+2S_{\mathfrak{hhm}}+S_{\mathfrak{hmm}}=2(\dim\mathfrak h)(n-2)$ and using $S_{\mathfrak{mhh}}=S_{\mathfrak{hhm}}$, $S_{\mathfrak{mmh}}=S_{\mathfrak{hmm}}$ gives

$$S_{\mathfrak{mmm}}+3S_{\mathfrak{mmh}}+3S_{\mathfrak{mhh}}+S_{\mathfrak{hhh}}=2\tbinom n2(n-2),$$

which carries L39's weights. **So the correct identification is L39's $(1,3,3,1)$ with [nondegeneracy.md](../findings/nondegeneracy.md)'s $1/3/3/1$ identity, which is L114 + twin, not with L114 alone.** L39's annotation is the deviant copy; L114's file has it right.

*Argued the opposite:* if "the same statement" is meant loosely, as "the same block-mass bookkeeping under two conventions", the sentence is defensible. But the annotation's own gloss (*"under the unordered reading L39's two coefficients become equal"*), is about the weights, so the weights are what it is asserting about, and the assertion is arithmetically wrong.

**L39's own Killing split is L114's identity with the middle term killed.** $S^{\rm ord}_{\mathfrak{kkk}}+2S^{\rm ord}_{\mathfrak{kkm}}+S^{\rm ord}_{\mathfrak{kmm}}=cp$ is the same row marginal with $(\mathfrak m,\mathfrak h)\to(\mathfrak k,\mathfrak m)$ and $2(n-2)\to c$, and §2's $S_{\mathfrak{kkm}}=0$ collapses it to $S_{\mathfrak{kkk}}+S_{\mathfrak{kmm}}=cp$. **This is a positive cross-file consistency result the record does not state, and it confirms that L39 is in the ordered reading.**

**"$S_{XYZ}$ is defined nowhere on the record, conventions.md included", FALSE.** [conventions.md](../findings/conventions.md) line 20 defines it, "the reading adopted 2026-09-04 on the recommendation of [r639](../reviews/REVIEW_r639.md) and [r640](../reviews/REVIEW_r640.md)". Section C's own closing italic admits "This copy is the stalest of the three"; this sentence is one of the stale parts.

## 10. The table's two columns, and the doubling argument

Row 3 of [target.md](../findings/target.md)'s table is *"$\mathfrak{so}(m)\subset\mathfrak{su}(m)$, $\mathbb R^m\oplus\mathbb R^m$; $h^\vee=m-2$; $I_\rho=2$; $c=m-2$"*.

**The two cells do fail.** $h^\vee(\mathfrak{so}(m))=m-2$ holds for $m\ge5$ ($B_r$: $h^\vee=2r-1=m-2$; $D_r$: $h^\vee=2r-2=m-2$). At $m=3$, $\mathfrak{so}(3)\cong\mathfrak{su}(2)$ has $h^\vee=2\ne1$. At $m=4$, $\mathfrak{so}(4)=\mathfrak{su}(2)\oplus\mathfrak{su}(2)$ is not simple and $h^\vee$ is undefined. **Claim 22 holds.**

**The doubling argument, checked.** $c$ is metric data: under $\langle,\rangle\mapsto\lambda\langle,\rangle$ an orthonormal basis rescales by $\lambda^{-1/2}$ and $\sum_i\lVert[a,b'_i]\rVert'^2=\lambda\lambda^{-1}\sum_i\lVert[a,b_i]\rVert^2=c\lVert a\rVert^2=(c/\lambda)\lVert a\rVert'^2$, so $c\mapsto c/\lambda$. The embedding $\mathfrak{so}(m)\hookrightarrow\mathfrak{so}(2m)$ is $X\mapsto X\oplus X$ on $\mathbb R^m\oplus\mathbb R^m$, a Lie algebra map, and $\lVert X\oplus X\rVert^2_{\mathfrak{so}(2m)}=\tfrac12\operatorname{tr}\big((X\oplus X)^{\mathsf T}(X\oplus X)\big)=\operatorname{tr}(X^{\mathsf T}X)=2\lVert X\rVert^2_{\mathfrak{so}(m)}$. So $\lambda=2$ and $c=c_{\rm std}(\mathfrak{so}(m))/2$.

**And $c_{\rm std}(\mathfrak{so}(m))=2(m-2)$ needs no simplicity.** By direct count in the orthonormal basis $v_{ij}=E_{ij}-E_{ji}$ ($i<j$, unit under $\langle A,B\rangle=\tfrac12\operatorname{tr}(A^{\mathsf T}B)$, per conventions line 59): $[v_{12},v_{1k}]=-(v_{2k})$ for $k\ge3$ and likewise for $v_{2k}$, each of unit norm; the basis elements meeting $\{1,2\}$ in exactly one index number $2(m-2)$, and no other bracket with $v_{12}$ is nonzero. Hence $c_{\rm std}=2(m-2)$, valid at every $m\ge2$. This is conventions line 118's $\kappa=2(n-2)$, i.e. [Lemma L153](../findings/bounds.md).

**Therefore $c=m-2$ at every $m\ge2$, $m=3$ and $m=4$ included, and the argument never touches $h^\vee$ or $I_\rho$.** Consistency: at $m=2$, $c=0$ and $\mathfrak{so}(2)$ is abelian; at $m=4$, a single $c$ exists because the two $\mathfrak{su}(2)$ factors are isomorphic, which is exactly the guard [target.md](../findings/target.md) line 369 states.

**Does any value move?** Cross-check both routes to $S_{\mathfrak{kkk}}$ for $(\mathfrak{su}(m),\mathfrak{so}(m))$, where $p=\binom m2$, $q=\binom{m+1}2-1=(m+2)(m-1)/2$, $c_{\mathfrak g}=2m$:

| $m$ | $c_{\mathfrak k}p$ | $c_{\mathfrak g}(p-q/2)$ |
| --- | --- | --- |
| 2 | $0\cdot1=0$ | $4(1-1)=0$ |
| 3 | $1\cdot3=3$ | $6(3-5/2)=3$ |
| 4 | $2\cdot6=12$ | $8(6-9/2)=12$ |

**The $c$ column does not move. The $h^\vee$ and $I_\rho$ cells do**: at $m=3$ they are $2$ and $4$ (the rep $\mathbb R^3\oplus\mathbb R^3$ is adjoint $\oplus$ adjoint, index $2h^\vee$ doubled), not $1$ and $2$; at $m=4$ both are undefined. The product $c=m-2$ survives in both cases, but only because the derivation reads $c$, not the two cells, which is conventions line 59's standing instruction, *"Killing constants come from the definition, never from an index convention."* **Claim 23 holds; the table's caption should say the two middle columns are generic-$m$ data.**

The formula reproduces the family's independently derived value under this $c$: with $p+q=(m-1)(m+1)$, $3p-q=(m-1)^2$, $p-q=-(m-1)$, the bracket is $m(m-1)^2\big[(m+2)(m-1)+2\big]=m^2(m+1)(m-1)^2$, the denominator $16p^3q(p+q)=m^3(m-1)^5(m+2)(m+1)$, and $\theta^2=m(m+1)/\big((m-1)(m+2)\big)$, matching [target.md](../findings/target.md)'s $X/(X-2)$ with $X=m(m+1)$ exactly.

## 11. Hypothesis debt

### 11.1 $p\ge1$ and $q\ge1$

Never stated in section A, B, or C; present in [L39.lean](../lean/HamiltonsCubic/Results/L39.lean) as `0 < p`, `0 < q`. Both are needed: the denominator is $4p^3q(p+q)^3$. Both are automatic for a symmetric pair with $\mathfrak g$ simple ($p=0$ forces $\mathfrak g$ abelian; $q=0$ is the trivial involution $\mathfrak g=\mathfrak k$, which is a symmetric pair and gives $W=0$), so the debt is small but real, $q=0$ is a genuine symmetric pair the statement admits and the formula cannot evaluate.

### 11.2 The metric normalisation

$c$ and every $S$ scale with the inner product on $\Lambda^2\mathbb R^n$ (see §10). The value $c=2h^\vee/I_\rho$ and $c(\mathfrak{so}(n))=2(n-2)$ hold in the normalisation making $e_i\wedge e_j$ orthonormal, i.e. $\langle A,B\rangle=\tfrac12\operatorname{tr}(A^{\mathsf T}B)$, which conventions line 59 fixes ("$\operatorname{tr}(v^2)=-2$ for a unit bivector") but which **neither copy of L39 quotes**. Under the plain Frobenius form every $c$ halves and the formula returns different numbers. This is what H2 ($\mathfrak g\subseteq\mathfrak{so}(n)$) is actually for, $n$ appears nowhere in the formula, so the embedding hypothesis is doing metric work and saying so nowhere. **A hypothesis stated, and its real role never stated.**

### 11.3 $\ker W\ne0$ and padded objects

The trap fires here. If $\mathfrak g\subsetneq\mathfrak{so}(n)$, which is the case for every example on the record, including $\mathfrak{su}(m)\subset\mathfrak{so}(2m)$, then $\mathfrak k\oplus\mathfrak m$ is a proper subspace of $\Lambda^2\mathbb R^n$ and $W$ must be defined on the complement. The only reading under which the derivation works is extension by zero, so **$\ker W\supseteq\mathfrak g^\perp$ has dimension $\binom n2-(p+q)$ and "the two-eigenvalue operator" is a three-eigenvalue operator $(a,b,0)$ unless $\mathfrak g=\mathfrak{so}(n)$.** Consequences:

- **harmless for the value**, every $T$-term touching $\mathfrak g^\perp$ carries $\lambda=0$, and $\operatorname{tr}(W^3)$, $\operatorname{tr}(W^2)$, $\operatorname{tr}(W)$ are unaffected. So §3 stands;
- **not harmless for criticality**, $Q(W)=\theta W$ requires $Q(W)$ to vanish on $\mathfrak g^\perp$; $W^2$ does, but $(W^\#)_{\delta\delta}=\tfrac12\sum_{\gamma\epsilon}T_{\delta\gamma\epsilon}\lambda_\gamma\lambda_\epsilon$ for $\delta\in\mathfrak g^\perp$ is generically nonzero. L39 asserts only a value, so it does not fall over; but any consumer reading "the two-eigenvalue critical point" out of it is reading something L39 does not prove.

**H4 is unstated and load-bearing for the name of the object.**

### 11.4 $\mathfrak g$ simple, on the three-invariant display

Section C's annotation 2 presents the three-invariant display without restating "for $\mathfrak g$ simple". Section A does state it, for the four-invariant/$c$ sentence. Since the display is the annotation's headline and is meant to become canonical, the hypothesis must travel with it.

### 11.5 The $\tfrac12$

H7 is used in every line and stated in none. It is the standard $\#$ normalisation (§3.1), and it is independently pinned twice, by $(\mathfrak{su}(2),\mathfrak{so}(2))$ returning exactly $3/2$ and by the balanced pair returning exactly $\theta_0(2k)^2$, so it is right, but it is convention, and the record's own rule is that conventions are quoted.

## 12. The remaining named traps

- **A claim proven on a subfamily and used in general.** The two vanishings are *proved* from the bracket relations (§2), so [target.md](../findings/target.md)'s "confirmed on 16 pairs across four Cartan series" is a check, not the evidence, no defect. The admissibility statistics (3 of 16) *are* a sample used to support a generic claim, but the claim made from them ("generically not a Weyl tensor") is appropriately hedged. The one genuine instance of this trap is claim 18, §8.
- **A hypothesis stated but never used.** $\mathfrak g\subseteq\mathfrak{so}(n)$ (§11.2): $n$ is absent from the formula, and the hypothesis's real work is metric.
- **A step using a hypothesis never stated.** Three: H3, H4, H7 (§11.2, §11.3, §11.5).
- **A universal claim with no witness.** Claim 11's equality case had none; $(\mathfrak{su}(2),\mathfrak u(1))$ supplies it (§8), and it is also the smallest admissible pair.
- **An imported theorem whose hypotheses were never checked.** The only import is $c=2h^\vee(\mathfrak g)/I_\rho$. Its hypotheses are $\mathfrak g$ simple and the halved index normalisation the record flags in "Two corrections"; §10 checks the one place where they are violated ($m=3,4$) and finds the conclusion survives by an independent route. **No unital-algebra import appears anywhere in this block, so the failure mode that killed the earlier $\mathcal W_n$ route does not recur here.**
- **Symbol collisions.** $\mathfrak m$: L39 uses [conventions.md](../findings/conventions.md) line 38's third sense throughout, consistently; note that at a two-eigenvalue point with $a>0$ it also coincides with the first sense $E_{\min}$, since $b=-ap/q<0$. $S_{XYZ}$: the block's $(1,3,3,1)$ weights are consistent with line 20's ordered reading (§9). $c$: distinct from $\kappa_n=(2n-1)(n-1)/4$ (line 124) and from $c_{abc}$ (line 60), the block never disambiguates but never misuses. **One real collision: [target.md](../findings/target.md) line 369 writes "$(\mathfrak{so}(p+q),\mathfrak{so}(p)+\mathfrak{so}(q))$ with $p\ne q$ fails Ricci-flatness" in the same file, thirty lines from the block, using $p,q$ as sphere dimensions while L39 has fixed $p=\dim\mathfrak k$, $q=\dim\mathfrak m$.** Under L39's convention the sentence is unreadable: for that family $\dim\mathfrak k=\binom p2+\binom q2\ne p$. This needs different letters.
- **The sign of $\theta$.** Both $(a,b)$ and $(-a,-b)$ satisfy H5 and $\theta(-W)=-\theta(W)$. The block states only $\theta^2$, so conventions line 66's warning ("normalise $W$ to $\theta>0$ before measuring $S$") is not violated, but the formula does **not** determine $\theta$, only $\lvert\theta\rvert$, and section A's prose says "$\theta$ depends on $p$, $q$, $S_{\mathfrak{kkk}}$ and $c$ alone", which is true only up to sign.

## 13. What would break it

**The object that would falsify the reduction:** a symmetric pair $(\mathfrak g,\mathfrak k)$ with $\mathfrak g$ simple inside $\mathfrak{so}(n)$ for which $2S_{\mathfrak{kmm}}\ne cq$, equivalently, for which the two block sums in §4's $\mathfrak m$ row are unequal, or the row identity $\sum_{\beta\gamma\in\mathfrak g}T_{\alpha\beta\gamma}=c$ fails at some $\alpha\in\mathfrak m$. Concretely it would show as a pair with $S_{\mathfrak{kkk}}\ne c(p-q/2)$, or as one with $q>2p$.

**What I did to look for it.** I re-derived the $\mathfrak m$ row from the two ingredients it uses (total symmetry of $T$, uniqueness of the invariant form on a simple $\mathfrak g$) and found no place a pair could evade it: both blocks of the $\mathfrak m$ row carry the pattern "one $\mathfrak k$ index, two $\mathfrak m$ indices", and total symmetry makes them the same number. I then screened it against every case the record supplies an independent $S$ for, $(\mathfrak{su}(m),\mathfrak{so}(m))$ at general $m$ and at $m=2,3,4$; $(\mathfrak{so}(6),\mathfrak u(3))$, the Hermitian case with a centre in $\mathfrak k$ that breaks the rival route; and $(\mathfrak{so}(6),\mathfrak{so}(2)\oplus\mathfrak{so}(4))$ at $(24,32)$, and all four agree exactly. I checked $q\le2p$ against $(\mathfrak{so}(n),\mathfrak{so}(n-1))$, $(\mathfrak{su}(m),\mathfrak{so}(m))$, $(\mathfrak{so}(2m),\mathfrak u(m))$ and $(\mathfrak{so}(2k),\mathfrak{so}(k)^{\oplus2})$ and found the margins $(m-1)(m-2)/2$, $k(k-2)$ etc., vanishing only in the abelian cases. **Nothing surfaced.**

**The object that would falsify the maximiser claim:** a $k\ge2$ at which $ck^3(2k-3)+4k^2(k-1)\ne4k^2(k-1)^2(2k-1)$ for $c=4(k-1)$ (impossible, the identity is polynomial and I expanded it) or a $c\ne4(k-1)$ for $\mathfrak{so}(2k)$ in the standard rep. I checked the latter both against the table and intrinsically by the basis count of §10; they agree.

**The object that falsifies "every time":** it exists and I found it, $(\mathfrak{so}(9),\mathfrak{so}(8))$ at $\theta^2=7/18$ (§8). I looked for it by evaluating the sphere-pair form at the far end of the range the sentence quantifies over, having noticed the sentence quantifies over a range whose two quoted witnesses are both at the near-balanced end.

**The object that would falsify the whole lemma's usefulness:** an admissible pair (one whose ansatz really is a Weyl tensor), with $\theta^2>\Theta_n^2$. I did not search for one; that is Conjecture A and it is a computation this loop does not run.

## Verdict

**PROVEN, hypotheses corrected.**

The formula, the reduction, both vanishings, the Killing split, $q\le2p$ with its equality case, the forced pair and the maximiser's exact collapse are all correct and were re-derived here from the ground up. The repairs owed are:

1. **Restore H8** (the Weyl-ness guard) to section C; section A has it, section C does not.
2. **Attach H9** ($\mathfrak g$ simple) to the three-invariant display, and state both forms with the scope in §4.
3. **State H3, H4, H6, H7**, the metric normalisation, the extension by zero, $p,q\ge1$, and the $\tfrac12$.
4. **Fix annotation 3's "every time"**, refuted by $(\mathfrak{so}(9),\mathfrak{so}(8))$ at $7/18$; the true statement is about the near-balanced odd-$n$ split and has no proof on file.
5. **Fix annotation 5's L114 identification**, $6/4/2$ ordered is $(1,2,1)$; L39's $(1,3,3,1)$ is L114 **plus its twin**, which L114's own file already says.
6. **Delete annotation 5's "$S_{XYZ}$ is defined nowhere"**, [conventions.md](../findings/conventions.md) line 20 defines it.
7. **Soften annotation 4's "decides"** to "confirms, and rules out $I_\rho=2$".
8. **Rewrite section A's invariant count**: three, not four; and "two embeddings", not "two pairs".
9. **Rename $p,q$ at [target.md](../findings/target.md) line 369** to clear the collision with $\dim\mathfrak k$, $\dim\mathfrak m$.

# Review r636, Lemma L39, the two-eigenvalue formula for an arbitrary symmetric pair

**Reviewer B, cold brief, analysis only. Review number 636.** Target: [findings/target.md](../findings/target.md) line 651, together with the derivation named in its provenance note at [findings/target.md](../findings/target.md) line 337.

## Verdict: CONFIRMED

The vanishing is free from the grading, the displayed formula is correct as written under this record's own normalisation, and I rebuilt it cold from the definitions. It reproduces **six independent exact anchors** already on the record, three of which the block does not itself invoke. The Killing reduction is correct.

Six defects, none of which touches the truth of the display:

1. **The reduction is to THREE invariants, not four**, for simple $\mathfrak g$ the same Killing argument run on $\mathfrak m$ gives $S_{\mathfrak{kmm}}=cq/2$, so $S_{\mathfrak{kkk}}$ is *determined* by $(p,q,c)$. The lemma understates itself, and the sharpened form is displayed below.
2. **$S_{XYZ}$ is defined nowhere on the record.** My derivation pins the reading uniquely (fully ordered slots); under the unordered reading the formula is false.
3. **The normalisation of $I_\rho$ is dropped from the block**, though the same file corrects exactly that trap 300 lines above.
4. **$p>0$ and $q>0$ are unstated hypotheses.**
5. **$\mathfrak k\perp\mathfrak m$ is an unstated hypothesis** once $\mathfrak g$ is allowed to be non-simple.
6. **The provenance sentence is false**, by two days and two files.

---

## 1. The vanishing, and which bracket kills which

Fix the pair: $\mathfrak g\subseteq\mathfrak{so}(n)$, $\sigma$ an involutive automorphism, $\mathfrak k=\mathfrak g^\sigma$, $\mathfrak m$ the $(-1)$-eigenspace, $p=\dim\mathfrak k$, $q=\dim\mathfrak m$. Take an orthonormal basis of $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$ adapted to $\mathfrak k\oplus\mathfrak m\oplus(\mathfrak g^\perp)$, in the half-trace pairing of [conventions.md](../findings/conventions.md) under which $\{\varphi_{ab}\}_{a<b}$ is orthonormal. Write $T_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle^2$, totally symmetric and hollow ([conventions.md](../findings/conventions.md), structure constants).

Define, and this is the reading forced in §2,
$$S_{XYZ}:=\sum_{\alpha\in X}\sum_{\beta\in Y}\sum_{\gamma\in Z}T_{\alpha\beta\gamma},$$
one slot per named block, each slot ranging independently.

- $S_{\mathfrak{kkm}}=0$ **from $[\mathfrak k,\mathfrak k]\subseteq\mathfrak k$**: for $\alpha,\beta\in\mathfrak k$ the bracket lies in $\mathfrak k$, and $\mathfrak k\perp\mathfrak m$, so every $\gamma\in\mathfrak m$ term is $\langle\mathfrak k,\mathfrak m\rangle^2=0$.
- $S_{\mathfrak{mmm}}=0$ **from $[\mathfrak m,\mathfrak m]\subseteq\mathfrak k$**: for $\alpha,\beta\in\mathfrak m$ the bracket lies in $\mathfrak k$, again orthogonal to every $\gamma\in\mathfrak m$.
- $[\mathfrak k,\mathfrak m]\subseteq\mathfrak m$ is **not** used for either vanishing. It is used in §3, to close the Killing split.

**"Identically" is confirmed, and is in fact stronger than the block says.** Neither vanishing mentions $W$: both are properties of the $\mathbb Z_2$-grading alone, holding for every symmetric pair and independently of the two-eigenvalue ansatz. The block's phrasing *"the two-eigenvalue point has $S_{\mathfrak{kkm}}=S_{\mathfrak{mmm}}=0$"* attaches them to the point; they belong to the decomposition. The report copy and the derivation section both attribute the two brackets correctly.

**The unstated hypothesis.** Both arguments consume $\mathfrak k\perp\mathfrak m$ *in the ambient $\mathfrak{so}(n)$ pairing*, which is also what $W=a\Pi_{\mathfrak k}+b\Pi_{\mathfrak m}$ needs for $\Pi$ to be orthogonal projections. For $\mathfrak g$ simple this is automatic: the restricted pairing is $\mathrm{ad}$-invariant and nondegenerate, hence a multiple of the Killing form, hence $\sigma$-invariant. For $\mathfrak g$ merely semisimple it can fail, take $\mathfrak g=\mathfrak s\oplus\mathfrak s$ with the two copies embedded at *different* scales and $\sigma$ the swap; then $\langle(x,x),(y,-y)\rangle=(\lambda_1-\lambda_2)B(x,y)\ne0$ and $\mathfrak m$ is not $\mathfrak k^\perp$. The block says "any symmetric pair inside $\mathfrak{so}(n)$" with no such qualifier.

## 2. The formula, derived, and the coefficient $3$ pinned

### The reading of $S$, and the calibration

$\theta=\langle W,Q(W)\rangle=\mathop{\mathrm{tr}}(W^3)+\langle W,W^\#\rangle$, and in an eigenframe ([Lemma L49](../findings/target.md), whose coefficient $3=3!/2$ is itself confirmed three ways)
$$\langle W,W^\#\rangle=3\!\!\sum_{\alpha<\beta<\gamma}\!\!T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma=\tfrac12\sum_{\alpha,\beta,\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma,$$
the two agreeing because $T$ is hollow and totally symmetric, so each strictly ordered triple is counted $3!=6$ times in the free sum.

Split the free sum by block. On $\mathfrak g^\perp$ the eigenvalue is $0$, so only triples inside $\mathfrak g$ survive, and the multinomial expansion is
$$\sum_{\alpha\beta\gamma}T\lambda\lambda\lambda=a^3S_{\mathfrak{kkk}}+3a^2b\,S_{\mathfrak{kkm}}+3ab^2S_{\mathfrak{kmm}}+b^3S_{\mathfrak{mmm}}.$$

**This is the whole of the coefficient $3$**, and it is a multinomial weight on the *three slot placements* of the odd index. It is therefore consistent with the calibration the brief supplies: the record-wide identity $S_{\mathfrak{mmm}}+3S_{\mathfrak{mmh}}+3S_{\mathfrak{mhh}}+S_{\mathfrak{hhh}}$ is the same expansion over the same free sum, and closes for the same reason. **L39 is consistent with it.**

**What the other reading does.** Read $S_{XYZ}$ as a sum over *unordered index sets* with the stated block multiplicities, and ($T$ being hollow), $S^{\text{ord}}_{\mathfrak{kkk}}=6\,S^{\text{unord}}_{\mathfrak{kkk}}$ while $S^{\text{ord}}_{\mathfrak{kmm}}=2\,S^{\text{unord}}_{\mathfrak{kmm}}$. The numerator bracket would become $6S_{\mathfrak{kkk}}q^2+6S_{\mathfrak{kmm}}p^2-2p^3+2pq^2$, the relative weight $1:3$ flattening to $1:1$ and both terms picking up a factor $6$. **So the displayed formula is false under the unordered reading**, and the ratio $1:3$ is itself the certificate that the ordered-slot reading is meant. The Killing identity of §3 independently pins the same reading: in the unordered reading it would read $6S_{\mathfrak{kkk}}+2S_{\mathfrak{kmm}}=cp$.

*This is the defect the brief predicted, and it is real: $S_{XYZ}$ has no definition anywhere on the record. [conventions.md](../findings/conventions.md) does not table it; [results.md](../results.md) line 480 glosses it only as "the bracket mass on the named blocks", which does not distinguish the two readings; [findings/target.md](../findings/target.md) never states it. The formula is nevertheless self-calibrating, by the two checks just given.*

### The derivation

Ansatz $W=a\Pi_{\mathfrak k}+b\Pi_{\mathfrak m}$, so $\mathop{\mathrm{spec}}(W)=\{a^{(p)},b^{(q)},0^{(N-p-q)}\}$ with $N=\binom n2$. Trace-free and unit-norm:
$$ap+bq=0,\qquad a^2p+b^2q=1\ \Longrightarrow\ b=-\frac{ap}q,\quad a^2=\frac q{p(p+q)}.$$

With the two vanishings,
$$\theta=\underbrace{a^3p+b^3q}_{\mathop{\mathrm{tr}}(W^3)}+\tfrac12\big[a^3S_{\mathfrak{kkk}}+3ab^2S_{\mathfrak{kmm}}\big].$$

Substituting $b=-ap/q$: $\ a^3p+b^3q=a^3p(q^2-p^2)/q^2$ and $ab^2=a^3p^2/q^2$, so
$$\theta=\frac{a^3}{2q^2}\Big[\,S_{\mathfrak{kkk}}q^2+3S_{\mathfrak{kmm}}p^2-2p^3+2pq^2\,\Big]=:\frac{a^3}{2q^2}\,\mathcal N .$$

Squaring with $a^6=q^3/\big(p^3(p+q)^3\big)$:
$$\theta^2=\frac{q^3\,\mathcal N^2}{4q^4\,p^3(p+q)^3}=\boxed{\ \frac{\big(S_{\mathfrak{kkk}}q^2+3S_{\mathfrak{kmm}}p^2-2p^3+2pq^2\big)^2}{4p^3q(p+q)^3}\ }$$

which is the display, numerator and denominator both. **Confirmed.**

### Homogeneity, and the normalisation the block does not name

The formula is *not* homogeneous in $(p,q)$ and correctly so: $-2p^3+2pq^2$ is exactly $2q^2/a^3$ times the $\mathop{\mathrm{tr}}(W^3)$ contribution and carries no $S$, while the two $S$-terms come from $\langle W,W^\#\rangle$. **The two summands of $Q$ scale differently under a change of the $\Lambda^2$ pairing**, $\mathop{\mathrm{tr}}(W^3)$ is a pure operator trace and is pairing-independent, whereas $T_{\alpha\beta\gamma}$ is built from structure constants in an *orthonormal* basis and rescales with the pairing. So the constants $-2$ and $+2$ are convention constants, valid only under the record's half-trace pairing ($\lVert\varphi_{ab}\rVert^2=1$), and **under plain Frobenius the display is false**. [conventions.md](../findings/conventions.md) records this as the pairing where two builds have already disagreed. The block cites no normalisation at all.

The degree balance is otherwise sound: $\theta^2$'s denominator $4p^3q(p+q)^3$ has total degree $7$ against the numerator's $\mathcal N^2$ of degree $6$ in dimensions plus $2$ in $[S]$, and $[S]$ carries one dimension-unit (see §3, $S=c\cdot\text{dim}$), giving $8-7=1$ against the residual $c^2$ dependence, which is exactly the non-homogeneity just explained, not an error.

### Degenerate cases

- **$q=0$**: $\mathfrak m=0$, so $\mathfrak k=\mathfrak g$; then $ap=0$ forces $a=0$ and $W=0$, which has no unit representative. The denominator's vanishing is a symptom.
- **$p=0$**: $\mathfrak k=0$ forces $[\mathfrak m,\mathfrak m]\subseteq\mathfrak k=0$, i.e. $\mathfrak g$ abelian; then $bq=0$, $b=0$, $W=0$ again.
- **$\mathfrak k$ abelian**: fine, and interesting, $[\mathfrak k,\mathfrak k]=0$ gives $S_{\mathfrak{kkk}}=0$, the formula collapses to $\theta^2=(3S_{\mathfrak{kmm}}p^2-2p^3+2pq^2)^2/(4p^3q(p+q)^3)$, and by §3 this is exactly the case $q=2p$. $W_{\mathbb{CP}^2}$ is such a point.

So $p,q\ge1$ are hypotheses, and **the block states neither**. They are silently assumed away rather than excluded. This is a real but small omission: no genuine symmetric pair is lost.

### The generalisation claim

*"Nothing in the derivation above used $\mathfrak{su}(m)$."* **Checked step by step and true.** The $(\mathfrak{su}(m),\mathfrak{so}(m))$ derivation at [findings/target.md](../findings/target.md) line 389 consumes exactly four things: (i) $ap+bq=0$, $a^2p+b^2q=1$, the ansatz, generic; (ii) $[\mathfrak k,\mathfrak k]\subseteq\mathfrak k\perp\mathfrak m$ and $[\mathfrak m,\mathfrak m]\subseteq\mathfrak k\perp\mathfrak m$, grading only; (iii) $\theta=\mathop{\mathrm{tr}}(W^3)+\tfrac12[a^3S_{\mathfrak{kkk}}+3ab^2S_{\mathfrak{kmm}}]$, the block expansion, generic; (iv) the *values* $S_{\mathfrak{kkk}}=(m-2)p$, $S_{\mathfrak{kmm}}=mq$, which are family-specific and are precisely what the general formula leaves as symbols. Simplicity of $\mathfrak{su}(m)$ enters only at (iv), through the Killing constant, and only in §3's reduction. **No step smuggles in simplicity or the specific bracket structure.**

One caveat that belongs to line 389 rather than to L39: its inference *"$S_{\mathfrak{mmm}}=0$ is why $S=0$ holds on the whole family"* is exactly the trap [W4](../findings/INDEX-traps.md) records and this same file restates at line 498, the gradedness screen is vacuous when $\ker W\ne0$, and here $\dim\ker W=\binom{2m}2-(m^2-1)=m^2-m+1>0$ at every $m$. **L39's own vanishings are unaffected**, being grading facts rather than eigenspace facts, and kernel directions drop out of the derivation because $\lambda=0$ there.

## 3. The Killing reduction, correct, and it goes one invariant further than claimed

The Killing constant is defined at [conventions.md](../findings/conventions.md): $\mathfrak g$ simple, $\sum_{b\in\mathfrak g}\lVert[a,b]\rVert^2=c\lVert a\rVert^2$. Equivalently $-B_{\mathfrak g}(a,a)=c\langle a,a\rangle$, since $\sum_b\lVert[a,b]\rVert^2=-\mathop{\mathrm{tr}}(\mathrm{ad}_a^2)$. For $\mathfrak g$ simple the restricted ambient pairing is a multiple of $B_{\mathfrak g}$, so a **single** $c$ works on all of $\mathfrak g$, on $\mathfrak m$ as well as on $\mathfrak k$. That is the step the record takes on $\mathfrak k$ and stops.

**On $\mathfrak k$** (the record's relation). For $a\in\mathfrak k$, split $\sum_{b\in\mathfrak g}=\sum_{b\in\mathfrak k}+\sum_{b\in\mathfrak m}$. Since $[\mathfrak k,\mathfrak k]\subseteq\mathfrak k$, $\sum_{b\in\mathfrak k}\lVert[a,b]\rVert^2=\sum_{b,\gamma\in\mathfrak k}T_{ab\gamma}$; since $[\mathfrak k,\mathfrak m]\subseteq\mathfrak m$, $\sum_{b\in\mathfrak m}\lVert[a,b]\rVert^2=\sum_{b,\gamma\in\mathfrak m}T_{ab\gamma}$. Summing over an orthonormal basis of $\mathfrak k$:
$$S_{\mathfrak{kkk}}+S_{\mathfrak{kmm}}=cp .\qquad\text{\bf Confirmed.}$$

**On $\mathfrak m$ (new here).** For $b\in\mathfrak m$: $\sum_{x\in\mathfrak k}\lVert[b,x]\rVert^2=\sum_{x\in\mathfrak k,y\in\mathfrak m}T_{bxy}$ and $\sum_{x\in\mathfrak m}\lVert[b,x]\rVert^2=\sum_{x\in\mathfrak m,y\in\mathfrak k}T_{bxy}$. Both are, by the total symmetry of $T$, sums of $T$ over one $\mathfrak k$-index and two $\mathfrak m$-indices; summing over an orthonormal basis of $\mathfrak m$ each becomes $S_{\mathfrak{kmm}}$, and their total is $cq$. Hence
$$\boxed{\ S_{\mathfrak{kmm}}=\tfrac12cq,\qquad S_{\mathfrak{kkk}}=c\big(p-\tfrac12q\big).\ }$$

**So $\theta$ is a function of three invariants, not four.** Substituting and factoring out $(p+q)$ from the bracket:
$$\mathcal N=(p+q)\Big[\tfrac c2q(3p-q)-2p(p-q)\Big]\ \Longrightarrow\ \boxed{\ \theta^2=\frac{\big(cq(3p-q)-4p(p-q)\big)^2}{16\,p^3\,q\,(p+q)}\ }$$
for every symmetric pair with $\mathfrak g$ simple. **This is a strict sharpening of the lemma**, and it has two immediate corollaries the record does not carry:

- $S_{\mathfrak{kkk}}\ge0$ forces $q\le2p$ for every such pair, with **$q=2p\iff\mathfrak k$ abelian**.
- The equal-$\theta$ coincidence in [Reviewer 81](REVIEW_r81.md)'s pair $(\mathfrak{so}(6),\mathfrak{so}(2){+}\mathfrak{so}(4))$ / $(\mathfrak{su}(4),\mathfrak s(\mathfrak u(2){+}\mathfrak u(2)))$ is **forced, not coincidental**: both have $(p,q,c)=(7,8,8)$, so $\theta$ must agree. Reviewer 81's conclusion is untouched (admissibility still fails differently) but the mechanism is now explained.

### Six exact anchors, all reproduced from the three-invariant form

| pair | $(p,q,c)$ | $\theta^2$ from the formula | on the record |
| --- | --- | --- | --- |
| $(\mathfrak{so}(2k),\mathfrak{so}(k){+}\mathfrak{so}(k))$ | $\big(k(k{-}1),\,k^2,\,4(k{-}1)\big)$ | $\dfrac{(k-1)(2k-1)}{k^2}$ | $=\theta_0(2k)^2=2-\tfrac3k+\tfrac1{k^2}$ ✓ |
| $(\mathfrak{su}(m),\mathfrak{so}(m))$ | $\big(\binom m2,\,\binom{m+1}2{-}1,\,2m\big)$ | $\dfrac{m(m+1)}{(m-1)(m+2)}$ | [Lemma L38](../results.md) ✓ |
| $(\mathfrak{so}(6),\mathfrak{so}(2){+}\mathfrak{so}(4))$ | $(7,8,8)$ | $9245/8232$ | line 369 ✓ |
| $(\mathfrak{su}(4),\mathfrak s(\mathfrak u(2){+}\mathfrak u(2)))$ | $(7,8,8)$ | $9245/8232$ | line 369 ✓ |
| $(\mathfrak{su}(2),\mathfrak u(1))$ on $\mathbb C^2$ | $(1,2,4)$ | $3/2$ | $=W_{\mathbb{CP}^2}$, line 369 ✓ |
| same, on $2$ and $3$ copies | $(1,2,2)$, $(1,2,\tfrac43)$ | $2/3$, $25/54$ | line 369 ✓ |

Worked, for the first row: $3p-q=k(2k-3)$ and $p-q=-k$, so the bracket is $4k^2(k-1)\big[k(2k-3)+1\big]=4k^2(k-1)^2(2k-1)$; squared over $16p^3q(p+q)=16k^6(k-1)^3(2k-1)$ gives $(k-1)(2k-1)/k^2$. For the third: bracket $=8\cdot8\cdot13+4\cdot7=860$, and $860^2/(16\cdot343\cdot8\cdot15)=739600/658560=9245/8232$.

**The balanced sphere product is reproduced exactly**, so the answer to the brief's §4 is affirmative, and see §4 below for why simplicity is not the obstacle it looks like.

### $c=2h^\vee/I_\rho$, and what $I_\rho$ is

The two-line argument at [findings/target.md](../findings/target.md) line 351 is **correct**. With $(\cdot,\cdot)_{\rm norm}$ the invariant form normalised so long roots have squared length $2$: $B_{\mathfrak g}=2h^\vee(\cdot,\cdot)_{\rm norm}$, and $\mathop{\mathrm{tr}}_{\mathbb R}\rho(X)\rho(Y)=2I_\rho(\cdot,\cdot)_{\rm norm}$ defines $I_\rho$. The record's ambient pairing is the half-trace one, $\langle X,Y\rangle=-\tfrac12\mathop{\mathrm{tr}}_{\mathbb R}\rho(X)\rho(Y)=-I_\rho(\cdot,\cdot)_{\rm norm}$, so
$$c=\frac{-B_{\mathfrak g}}{\langle\cdot,\cdot\rangle}=\frac{-2h^\vee}{-I_\rho}=\frac{2h^\vee}{I_\rho}.$$

**$I_\rho$ is a real-trace Dynkin index, normalised so the $\mathfrak{so}(n)$ vector representation has index $1$, which is HALF the standard index of the complexified representation.** The anchor that fixes it is the record's own: $\mathfrak{so}(n)$ standard, $h^\vee=n-2$, $I=1$, giving $c=2(n-2)$, which is exactly the Killing row marginal $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=2(n-2)$ tabled in [conventions.md](../findings/conventions.md) and proved as $-\mathop{\mathrm{tr}}(\mathrm{ad}\,v_\alpha)^2=-(n-2)\mathop{\mathrm{tr}}(v_\alpha^2)$. **The match with the half-trace pairing is genuine and I checked it independently**: with $D$ the complex index normalised so $D_{\rm adj}=2h^\vee$, $\mathrm{adj}(\mathfrak{so}(n))=\Lambda^2V$ has $D=(n-2)D_V$, forcing $D_V=2$, and $c=4h^\vee/D_V=2(n-2)$ ✓; for $\mathfrak{su}(m)$ on $\mathbb C^m_{\mathbb R}$, $D_{\rho\otimes\mathbb C}=D_{\mathbb C^m}+D_{\overline{\mathbb C^m}}=2$ and $c=4m/2=2m$ ✓, matching the record's table.

> **DEFECT. The L39 block prints "$c=2h^\vee(\mathfrak g)/I_\rho$, dual Coxeter number over Dynkin index" with no normalisation attached**, and it is the *only* copy of the rule that does. The same file corrects exactly this at line 355 (*"anyone applying the rule with indices from Slansky or LiE gets every $c$ wrong by a factor 2"*), and the [report/](../report/) copy carries the correction inside its certificate. So the block is the weakest of the three copies and reintroduces a trap the record has already paid for once. **"Classical table data" is the hedging clause that makes it dangerous**: it invites the reader to a table, and every standard table is in the other normalisation.

### Is simplicity needed, or only semisimplicity?

**Simplicity of $\mathfrak g$ is used, and semisimplicity does not suffice**, but the hypothesis is weaker than it looks, and the brief's worry is misaimed.

- What is actually needed is that the ambient pairing restricted to $\mathfrak g$ be proportional to $B_{\mathfrak g}$, with **one** constant. That is automatic for $\mathfrak g$ simple. For $\mathfrak g$ semisimple it holds iff every simple ideal is embedded with the same $c$; when they are not, there is no single $c$ and the relation fails, the record's own witness $\mathfrak{so}(3)\oplus\mathfrak{so}(5)\subset\mathfrak{so}(8)$, $c\in\{2,6\}$, at line 369.
- **The brief's $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ is $\mathfrak k$, not $\mathfrak g$.** For the balanced sphere product the pair is $\big(\mathfrak{so}(2k),\,\mathfrak{so}(k)\oplus\mathfrak{so}(k)\big)$: $\mathfrak g=\mathfrak{so}(2k)$ **is simple** for $k\ge3$, and $\mathfrak k$ non-simple is harmless. Simplicity of $\mathfrak k$ is needed only for the *different*, subordinate rule $S_{\mathfrak{kkk}}=c_{\mathfrak k}p$, which the record already flags as failing whenever $\mathfrak k$ has a centre (line 355). **So the maximiser is inside the hypothesis, not outside it**, and §3's table confirms it by returning $\theta_0(2k)^2$ exactly.
- Consistency check on the non-simple $\mathfrak k$: $S_{\mathfrak{kkk}}=\sum_ic_i\dim\mathfrak k_i=2\cdot2(k-2)\binom k2=2k(k-1)(k-2)$, which equals $c(p-\tfrac q2)=4(k-1)\big(k(k-1)-\tfrac{k^2}2\big)$ ✓. The two routes agree.

## 4. Scope and use

### Does the formula reproduce $\Theta_n$?

**At even $n$, yes and exactly**, $\theta^2=(k-1)(2k-1)/k^2=2(n-1)(n-2)/n^2$ at $n=2k$, so $\theta=\theta_0(n)=\Theta_n$ ([conventions.md](../findings/conventions.md)).

**At odd $n$, it does not and cannot**, and this is a scope fact rather than a defect. At odd $n$ the diagonal maximiser is the *unbalanced* $S^{(n-1)/2}\times S^{(n+1)/2}$, at $\Theta_n=\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$. The Weyl operator of an unbalanced product has **three** distinct eigenvalues (one each on $\Lambda^2T_1$, $\Lambda^2T_2$ and $T_1\wedge T_2$), coinciding only when $n_1=n_2$. So the two-eigenvalue ansatz on $\big(\mathfrak{so}(n),\mathfrak{so}(n_1)\oplus\mathfrak{so}(n_2)\big)$ with $n_1\ne n_2$ is a *different operator*, and the record already records that it fails Ricci-flatness (line 369).

I checked the size of the discrepancy analytically at $(n_1,n_2)=(3,5)$: $(p,q,c)=(13,15,12)$ gives $\mathcal N=61936$ and $\theta^2=3836068096/2893712640\approx1.3256$, i.e. $\theta\approx1.1514$, against $S^3\times S^5$'s true $\sqrt{56/45}=1.1155$. **The formula's value at an unbalanced pair is the value of the cubic at a non-Weyl operator** and must not be read as a sphere-product $\theta$. Neither the block nor [results.md](../results.md) warns of this specific confusion, though [results.md](../results.md) does carry the general "decides nothing about whether that point is a Weyl tensor".

### $n=8$ and triality

**Sound, for a reason stronger than invariance.** The formula's inputs $(p,q,S_{\mathfrak{kkk}},S_{\mathfrak{kmm}})$ (equivalently $(p,q,c)$), are computed from brackets and the inner product, both of which the outer automorphism $\tau$ of $\mathfrak{so}(8)$ preserves. So the formula is **blind to triality by construction**, and that is consistent, because $\theta$ is itself $\tau$-invariant. What is *not* $\tau$-invariant is the defect and the $SO(8)$-orbit, and the formula never claims to see either.

More decisively, **neither member of the $n=8$ triality pair is in L39's scope at all**: $\mathbb{HP}^2$ has three distinct eigenvalues (line 369 says so, and its top eigenspace is the $3$-dimensional span of $I,J,K$), and $S^3\times S^5$ is unbalanced, so by the paragraph above its Weyl tensor is not the two-eigenvalue ansatz either. **L39 therefore cannot be used to enumerate $SO(n)$-orbits, and it is not: it reads a value off a pair, and the pair-to-orbit step is exactly the one [conventions.md](../findings/conventions.md) warns is $\mathrm{Aut}$-level rather than $SO(n)$-level.** No defect here, but the block should say it; only [results.md](../results.md) does.

### The block is the weakest of the three copies

[results.md](../results.md) line 480 carries three things this block drops, that $S_{\mathfrak{abc}}$ is "the bracket mass on the named blocks", that $S_{\mathfrak{kkk}}=\sum_ic_i\dim\mathfrak k_i$ when $\mathfrak k$ has a centre, and the whole scope sentence about Weyl-ness being a property of $\rho$. [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) line 1116 carries the $I_\rho$ normalisation trap and the centre correction in its certificate. **The [findings/](../findings/) block carries none of the four.** Everything is recoverable from the same file (lines 355 and 369), so this is a copy-fidelity defect rather than a mathematical one, but it is the copy a reader arriving by [INDEX-results.md](../findings/INDEX-results.md) opens first.

Minor: the block says *"confirmed on 16 pairs across four Cartan series"*; the report certificate says *"16 symmetric pairs across five Cartan series"*. **Four against five, on the same run.**

## 5. Provenance, FALSE, and the pointer is truncated

The block reads: *"the result was numbered in [report/](../report/) and **the mathematics has always been in this file**, but it carried no block."*

**Checked with `git log -S` and a distinctive-phrase grep. The sentence is false.**

| step | commit | date | file |
| --- | --- | --- | --- |
| mathematics first entered the record | `6a6a5c98` *feat(conjecture-a): theta for EVERY two-eigenvalue symmetric pair, in four invariants* | 2026-08-24 | `FINDINGS.md` (since split away), with [b_symmetric_pair_general.py](../scripts/route-b/b_symmetric_pair_general.py) |
| split into per-subject files | `51ab61f8` | 2026-08-24 | → `findings/live-front.md` |
| **`findings/target.md` created** | `ea7c61c4` | **2026-08-26** | first appearance of the file, by `--diff-filter=A` |
| block written, provenance sentence pasted | `86621751` *docs(findings): number the 24 results that only the report had numbered* | 2026-08-31 | [findings/target.md](../findings/target.md) |

**The file is two days younger than the mathematics, and the mathematics lived in two other files first.** The phrase was pasted in bulk by `86621751`; **17 copies survive across [findings/](../findings/)**, three in [target.md](../findings/target.md) alone, and further copies in [bispectral.md](../findings/bispectral.md), [ungraded-slack.md](../findings/ungraded-slack.md), [problem.md](../findings/problem.md), [sym3-blocks.md](../findings/sym3-blocks.md), [brauer-pairing.md](../findings/brauer-pairing.md), [diagonal-half.md](../findings/diagonal-half.md), [stratum-two-negative.md](../findings/stratum-two-negative.md) and [support-dichotomy.md](../findings/support-dichotomy.md).

*In fairness to this instance:* unlike [L45](../findings/target.md), whose argument was never in the file it sits in, **L39's argument really is in this file and really is about this subject**, it arrived by mechanical file-splitting, not by misfiling. The sentence is false as written and harmless in substance.

**The pointer is truncated.** The block names the section *"The $(\mathfrak{su}(m),\mathfrak{so}(m))$ derivation generalises to EV"*. The heading at [findings/target.md](../findings/target.md) line 337 reads *"…generalises to EVERY symmetric pair, giving $\theta$ in four Lie-theoretic invariants"*. It resolves by prefix, but it is cut mid-word and is a plain quotation rather than an anchored link, unlike every other pointer in this block. **All other pointers resolve**, including [b_symmetric_pair_general.py](../scripts/route-b/b_symmetric_pair_general.py), and [INDEX-results.md](../findings/INDEX-results.md) line 54 indexes L39 correctly with *"Gate 2: no verdict on the record"*, which this review and its independent partner are the first to supply.

## 6. Every hedging clause, adjudicated

| clause | verdict |
| --- | --- |
| *"$S_{\mathfrak{kkm}}=S_{\mathfrak{mmm}}=0$ **identically**"* | **TRUE, and understated**, a property of the $\mathbb Z_2$-grading, not of the two-eigenvalue point; holds for every symmetric pair. Needs the unstated $\mathfrak k\perp\mathfrak m$ |
| *"for **any** symmetric pair $(\mathfrak g,\mathfrak k)$ inside $\mathfrak{so}(n)$"* | **TRUE with $p,q\ge1$ and $\mathfrak k\perp\mathfrak m$**, neither stated |
| *"Nothing in the derivation above used $\mathfrak{su}(m)$"* | **TRUE**, checked step by step; simplicity enters only at the Killing reduction, which is separately hypothesised |
| *"$\theta$ depends on **four** invariants only"* | **TRUE but weak, it is three.** $S_{\mathfrak{kmm}}=cq/2$ and $S_{\mathfrak{kkk}}=c(p-q/2)$ |
| *"When $\mathfrak g$ is **simple** with Killing constant $c$"* | **NECESSARY as stated**; the true hypothesis is one $c$ across all simple ideals, and $\mathfrak k$'s simplicity is irrelevant here |
| *"The constant is **classical table data**"* | **MISLEADING without the normalisation**, every standard table is in the doubled convention, and the block omits the correction its own file carries |
| *"the mathematics has always been in this file"* | **FALSE**, see §5 |

## What is owed

Nothing to the mathematics. Four things to the block, all editorial and all reachable from material already in the same file:

1. **State the reading of $S_{XYZ}$** (the fully ordered slot sum) and table it in [conventions.md](../findings/conventions.md), where it belongs and where it is absent. Without it the display is ambiguous between two readings, one of which makes it false.
2. **Carry the $I_\rho$ normalisation into the block**, or drop "classical table data".
3. **State $p,q\ge1$**, and either state $\mathfrak k\perp\mathfrak m$ or restrict to $\mathfrak g$ simple throughout.
4. **Record the three-invariant form** $\theta^2=\big(cq(3p-q)-4p(p-q)\big)^2/\big(16p^3q(p+q)\big)$ and its two corollaries, $q\le2p$ always, with equality iff $\mathfrak k$ is abelian; and Reviewer 81's equal-$\theta$ pair being forced by $(p,q,c)=(7,8,8)$.

And **fix the provenance sentence**, here and in the other sixteen places `86621751` pasted it.

*No computation was run. Every check in this review is analytic: the derivation, the six anchors, the Killing identities, the index normalisation, and the $(3,5)$ discrepancy are all closed-form. The repository archaeology in §5 is `git log -S` and grep, not numerics.*

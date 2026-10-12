# Review r635, Lemma L39, the two-eigenvalue formula for an arbitrary symmetric pair

**Reviewer A of a Gate 2 pair on identical cold briefs (sibling: r636). Target: [findings/target.md:651](../findings/target.md#L651), with the canonical copies at [results.md:480](../results.md#L480) and [report/sections/07-gradedness-split.tex:1116](../report/sections/07-gradedness-split.tex#L1116). The derivation it generalises is at [findings/target.md:337](../findings/target.md#L337).**

## Verdict

**CONFIRMED on the mathematics (all three claims derive cold from the definitions and reproduce the boxed formula exactly), with one GAP that matters and three normalisations this copy drops.**

- **The vanishing $S_{\mathfrak{kkm}}=S_{\mathfrak{mmm}}=0$ is CONFIRMED**, from the $\mathbb Z_2$-grading alone, and "identically" is right in the strong sense: it is a property of the pair, holding for every $W$ and not only at the two-eigenvalue point. §2.
- **The formula is CONFIRMED**, derived line by line in §3 and reproduced symbolically. The coefficient $3$ on $S_{\mathfrak{kmm}}$ against $1$ on $S_{\mathfrak{kkk}}$ is the multinomial weight $\binom31$ of the same expansion, and it **pins the convention: L39 is in the FULLY ORDERED reading**, consistent with the calibration identity the brief supplies. §1.
- **$S_{\mathfrak{kkk}}+S_{\mathfrak{kmm}}=cp$ is CONFIRMED** and is exactly the statement $-B_{\mathfrak g}\vert_{\mathfrak k}=c\langle\cdot,\cdot\rangle\vert_{\mathfrak k}$ in trace. **Simplicity of $\mathfrak g$ is sufficient and more than is needed**; §5 gives the semisimple replacement, which is a definite number even where no single $c$ exists.
- **$c=2h^\vee(\mathfrak g)/I_\rho$ is CONFIRMED**, in two lines and against four intrinsic anchors I recomputed by hand. §6.
- **THE GAP: the block states no admissibility hypothesis, and the value it computes is the value of the cubic on an operator that is generically not a Weyl tensor.** [results.md:480](../results.md#L480) carries the sentence saying so and **this copy drops it**. The concrete cost is in §7: at every unbalanced sphere pair the formula overshoots the true $\theta$, by $1.29\%$ at $n=9$ and $12.6\%$ at $n=5$.
- **The four invariants reproduce $\Theta_n$ exactly at even $n$ and are structurally unable to reach it at odd $n$**, the odd maximiser being an unbalanced pair. §7.
- **Provenance is CLEAN**, the first clean one in the runs this brief cites. §9.

---

## 0. Symbols, each fixed before use

The brief instructs me to treat [conventions.md](../findings/conventions.md) as unreliable. Every symbol I use, with the reading adopted and where it is anchored:

| symbol | reading adopted | authority |
| --- | --- | --- |
| $\langle\cdot,\cdot\rangle$ on $\Lambda^2\cong\mathfrak{so}(n)$ | the **half-trace** pairing $\tfrac12\operatorname{tr}(X^{\mathsf T}Y)=-\tfrac12\operatorname{tr}(XY)$, under which $\{\varphi_{ab}\}_{a<b}$ is orthonormal | [conventions.md](../findings/conventions.md), "Norms and pairings", pinned by [r519](REVIEW_r519.md)/[r520](REVIEW_r520.md) |
| $c_{\alpha\beta\gamma}$, $T_{\alpha\beta\gamma}$ | $c_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle$, totally antisymmetric; $T=c^2$, totally symmetric and hollow | [conventions.md](../findings/conventions.md), "Structure constants" |
| $S_{XYZ}$ | **the FULLY ORDERED block mass** $\sum_{\alpha\in X}\sum_{\beta\in Y}\sum_{\gamma\in Z}T_{\alpha\beta\gamma}$, every slot ranges independently over its block. Forced by §1 | derived, not quoted; the record fixes it nowhere |
| $\theta$ | $P(W)/\lVert W\rVert^3$ with $P(W)=\langle W,Q(W)\rangle$, **defined for every $W$**, a critical value only when $Q(W)=\theta W$ | [conventions.md](../findings/conventions.md), "The objects" |
| $\mathfrak k$, $\mathfrak m$ | the $\pm1$ eigenspaces of the involution; **the third of the three senses of $\mathfrak m$ the record carries**, the symmetric-pair one | [conventions.md](../findings/conventions.md) tables the collision explicitly |
| $c$ | the Killing constant of a subalgebra: $\sum_{b\in\mathfrak g}\lVert[a,b]\rVert^2=c\lVert a\rVert^2$ for $a\in\mathfrak g$ | [conventions.md](../findings/conventions.md), "The Killing constant of a SUBALGEBRA" |
| $\rho_\alpha$ | the Killing row marginal $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=2(n-2)$ | see §8 for where it lives and that it has no number |

---

## 1. The convention for $S$ is forced, and the record carries both readings

**The brief is right that this is the live hazard, and the calibration it supplies decides it.** I derive the decision rather than adopt it.

The cubic in an eigenframe is

$$P(W)=\operatorname{tr}(W^3)+\langle W,W^\#\rangle,\qquad \langle W,W^\#\rangle=\tfrac12\sum_{\alpha,\beta,\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma,$$

the sum running over **all** ordered triples. Three independent anchors fix that $\tfrac12$, and I checked each:

1. **$\mathrm{Id}^\#=(n-2)\mathrm{Id}$ against the Killing marginal.** Put $\lambda\equiv1$: the right side is $\tfrac12\sum_{\alpha,\beta}\lVert[v_\alpha,v_\beta]\rVert^2=\tfrac12\cdot N\cdot2(n-2)=(n-2)N$, which is $\langle\mathrm{Id},\mathrm{Id}^\#\rangle$ exactly. This is my own check and uses only the marginal.
2. **[Lemma L49](../findings/target.md#L722)'s form** $\theta=\sum_\alpha\lambda_\alpha^3+3\sum_{\alpha<\beta<\gamma}T\lambda\lambda\lambda$: since $T$ is hollow, the all-ordered sum is $3!$ times the strictly-ordered one, and $6/2=3$. Confirmed three ways at [r623](REVIEW_r623.md)/[r624](REVIEW_r624.md).
3. **[Fence post F18](../findings/bounds-relaxations.md#L114) states it verbatim** ($\sum\lambda_\alpha\lambda_\beta\lambda_\gamma T_{\alpha\beta\gamma}=2\langle W,W^\#\rangle$) and, load-bearing for §7, records that it holds **off** $\mathrm{Weyl}_n$, free of Bianchi and Ricci-flatness.

Splitting that sum over $\mathfrak k$ and $\mathfrak m$ with $\lambda=a$ on $\mathfrak k$ and $b$ on $\mathfrak m$, and using the total symmetry of $T$ to collect the arrangements, gives

$$\langle W,W^\#\rangle=\tfrac12\big[a^3S_{\mathfrak{kkk}}+3a^2b\,S_{\mathfrak{kkm}}+3ab^2S_{\mathfrak{kmm}}+b^3S_{\mathfrak{mmm}}\big],$$

**weights $(1,3,3,1)$, the multinomial weights, and exactly what [target.md:389](../findings/target.md#L389) writes.** So L39's coefficient $3$ is $\binom31$, and it is right.

**This is the fully ordered reading, and only that reading closes the brief's calibration.** Splitting all ordered triples by how many indices lie in $\mathfrak h$ gives $S_{\mathfrak{mmm}}+3S_{\mathfrak{mmh}}+3S_{\mathfrak{mhh}}+S_{\mathfrak{hhh}}=2N(n-2)$. Under the unordered reading the same split reads $6(S^{\rm un}_{\mathfrak{mmm}}+S^{\rm un}_{\mathfrak{mmh}}+S^{\rm un}_{\mathfrak{mhh}}+S^{\rm un}_{\mathfrak{hhh}})$, all four weights equal, and the $(1,3,3,1)$ form fails. **L39 is consistent with the calibration.**

### What the formula becomes under the other reading

With $S_{\mathfrak{kkk}}=6S^{\rm un}_{\mathfrak{kkk}}$ and $S_{\mathfrak{kmm}}=2S^{\rm un}_{\mathfrak{kmm}}$, the numerator bracket becomes

$$6S^{\rm un}_{\mathfrak{kkk}}q^2+6S^{\rm un}_{\mathfrak{kmm}}p^2-2p^3+2pq^2,$$

**so under the unordered reading the two coefficients are equal and the printed $1:3$ ratio is wrong.** A reader who takes unordered values into the formula as printed gets nonsense: at $(\mathfrak{su}(3),\mathfrak{so}(3))$ the ordered data $(p,q,S_{\mathfrak{kkk}},S_{\mathfrak{kmm}})=(3,5,3,15)$ give the correct $\theta^2=6/5$, while the unordered $(\tfrac12,\tfrac{15}2)$ substituted into the printed formula give $0.3498$.

> **AND THE RECORD REALLY DOES CARRY BOTH READINGS OF THIS SYMBOL.** [Lemma L114](../findings/bounds-relaxations.md#L126) states $6S_{\mathfrak{mmm}}+4S_{\mathfrak{mmh}}+2S_{\mathfrak{mhh}}=2d(n-2)$. Deriving the same identity in the ordered reading gives $S_{\mathfrak{mmm}}+2S_{\mathfrak{mmh}}+S_{\mathfrak{mhh}}=2d(n-2)$, coefficient ratio $(1,2,1)$ against L114's $(3,2,1)$, so the two cannot be the same convention. Substituting $S_{\mathfrak{mmm}}=6S^{\rm un}$, $S_{\mathfrak{mmh}}=2S^{\rm un}$, $S_{\mathfrak{mhh}}=2S^{\rm un}$ turns mine into L114's **exactly**. *Both identities are correct in their own reading, and the symbol $S_{XYZ}$ means two different things in [target.md](../findings/target.md) and [bounds-relaxations.md](../findings/bounds-relaxations.md), with neither file saying which.* A third check that L39's numbers are ordered: it calls $S_{\mathfrak{kkk}}=(m-2)p$ and $S_{\mathfrak{kmm}}=mq$ "integers with closed forms", and the unordered values $(m-2)p/6$ are not integers.

**Owed to [conventions.md](../findings/conventions.md): one row fixing $S_{XYZ}$ as the fully ordered block mass, with L114 marked as the exception or restated.** Its existing bullet "sums over pairs are over ORDERED pairs unless the line says otherwise" points the right way and does not reach triples.

---

## 2. The vanishing, and it is free

Let $\sigma$ be the involution, $\mathfrak k=\ker(\sigma-1)$, $\mathfrak m=\ker(\sigma+1)$, and let $\mathfrak k\perp\mathfrak m$ (see the caveat below). The grading gives $[\mathfrak k,\mathfrak k]\subseteq\mathfrak k$, $[\mathfrak k,\mathfrak m]\subseteq\mathfrak m$, $[\mathfrak m,\mathfrak m]\subseteq\mathfrak k$. Then, for $c_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle$:

| block mass | the bracket relation that kills it |
| --- | --- |
| $S_{\mathfrak{kkm}}=0$ | $[\mathfrak k,\mathfrak k]\subseteq\mathfrak k$, and $\mathfrak k\perp\mathfrak m$, so every $c_{\alpha\beta\gamma}$ with $\alpha,\beta\in\mathfrak k$, $\gamma\in\mathfrak m$ vanishes |
| $S_{\mathfrak{mmm}}=0$ | $[\mathfrak m,\mathfrak m]\subseteq\mathfrak k$, and $\mathfrak k\perp\mathfrak m$, so every $c_{\alpha\beta\gamma}$ with all three in $\mathfrak m$ vanishes |

**"Identically" is correct, and in a stronger sense than the block claims.** Neither statement mentions $a$, $b$ or $W$: each is a vanishing of the structure constants of the pair. So it holds for every symmetric pair, at every point of the two-eigenvalue family, and indeed for every operator whatever. Total symmetry of $T$ makes the slot assignment immaterial, so "kkm" needs no ordering convention.

> **ONE HYPOTHESIS IS USED SILENTLY AND IS NOT IN THE BLOCK: $\mathfrak k\perp\mathfrak m$.** It is automatic for $\mathfrak g$ simple, where $\langle\cdot,\cdot\rangle\vert_{\mathfrak g}=-B_{\mathfrak g}/c$ and any automorphism preserves $B_{\mathfrak g}$; and it is anyway forced by the ansatz, since $W=a\Pi_{\mathfrak k}+b\Pi_{\mathfrak m}$ with *orthogonal* projections is the operator meant. **For $\mathfrak g$ merely semisimple with an involution exchanging isomorphic ideals it is a genuine hypothesis**, because $\langle\cdot,\cdot\rangle$ need not be a multiple of $B_{\mathfrak g}$ there. One clause, "the involution being an isometry of the induced pairing", discharges it.

---

## 3. The formula, derived

Fix an orthonormal basis of $\mathfrak{so}(n)$ adapted to $\mathfrak k\oplus\mathfrak m\oplus\mathfrak g^\perp$, and let $W=a\Pi_{\mathfrak k}+b\Pi_{\mathfrak m}$.

**Step 0, the operator has three eigenvalues, not two.** $W$ is $0$ on $\mathfrak g^\perp$, of dimension $\binom n2-p-q$. This costs nothing: every term of $\sum T\lambda\lambda\lambda$ touching $\mathfrak g^\perp$ carries a factor $0$, and $\operatorname{tr}(W^3)$, $\operatorname{tr}(W)$, $\lVert W\rVert^2$ are unaffected. **But the name "two-eigenvalue point" is inaccurate whenever $\mathfrak g\subsetneq\mathfrak{so}(n)$, which is the generic case**, and the record's own [trap W4](../findings/INDEX-traps.md) is about exactly what a kernel does to block bookkeeping.

**Step 1, the normalisation.** Trace-freeness $ap+bq=0$ gives $b=-ap/q$; unit norm $a^2p+b^2q=1$ then gives $a^2p(p+q)/q=1$, so

$$a^2=\frac{q}{p(p+q)},\qquad b=-\frac{ap}{q}.$$

**Step 2, the cube trace.** $\operatorname{tr}(W^3)=a^3p+b^3q=a^3\big(p-p^3/q^2\big)=a^3\,p\,(q^2-p^2)/q^2$.

**Step 3, the bracket part.** From §1 with $S_{\mathfrak{kkm}}=S_{\mathfrak{mmm}}=0$ and $b^2=a^2p^2/q^2$,

$$\langle W,W^\#\rangle=\tfrac12\big[a^3S_{\mathfrak{kkk}}+3ab^2S_{\mathfrak{kmm}}\big]=\frac{a^3}{2q^2}\big[S_{\mathfrak{kkk}}q^2+3S_{\mathfrak{kmm}}p^2\big].$$

**Step 4, collect.**

$$\theta=P(W)=\frac{a^3}{2q^2}\Big[S_{\mathfrak{kkk}}q^2+3S_{\mathfrak{kmm}}p^2-2p^3+2pq^2\Big],$$

the $-2p^3+2pq^2$ being $2q^2\operatorname{tr}(W^3)/a^3$. Squaring with $a^6=q^3/\big(p^3(p+q)^3\big)$:

$$\theta^2=\frac{q^3}{p^3(p+q)^3}\cdot\frac{1}{4q^4}\Big[\cdots\Big]^2=\frac{\big(S_{\mathfrak{kkk}}q^2+3S_{\mathfrak{kmm}}p^2-2p^3+2pq^2\big)^2}{4p^3q(p+q)^3}.\qquad\blacksquare$$

**Exactly the boxed formula.** *Screen (seconds, on objects constructed for the purpose): the same derivation carried out in sympy returns `derived == boxed: True` identically in $p,q,S_{\mathfrak{kkk}},S_{\mathfrak{kmm}}$.*

### The degree check the brief asks for

There is **no scaling symmetry in $(p,q)$ alone** to test against, because $S$ and $c$ are independent invariants that grow with $n$ rather than with $p,q$, so a naive degree count (numerator $6$, denominator $7$) is not a defect and not a check. **The check that does bite is the one the derivation supplies**: $\theta$ is degree $0$ under $W\mapsto tW$ by construction, and the denominator's $4p^3q(p+q)^3$ is exactly $a^6/(4q^4)$ inverted, i.e. it is *produced* by the normalisation rather than asserted alongside it. Substituting $a^2=q/(p(p+q))$ is the only place $p$ and $q$ enter the denominator, and they enter once.

### Degenerate cases

| case | what happens |
| --- | --- |
| $q=0$ | $\mathfrak m=0$, so $ap=0$, so $W=0$ and $\lVert W\rVert=1$ is unsatisfiable |
| $p=0$ | $\mathfrak k=0$, so $[\mathfrak m,\mathfrak m]=0$, $\mathfrak g$ abelian, $bq=0$, $W=0$ again |
| $\mathfrak k$ abelian | **fine, and it is the interesting case.** $[\mathfrak k,\mathfrak k]=0$ gives $S_{\mathfrak{kkk}}=0$ and the formula applies unchanged. At $(\mathfrak{su}(2),\mathfrak{so}(2))$, $(p,q)=(1,2)$, $S_{\mathfrak{kkk}}=0$, $S_{\mathfrak{kmm}}=4$: numerator $12-2+8=18$, denominator $216$, $\theta^2=\mathbf{3/2}$, $W_{\mathbb{CP}^2}$, matching [target.md](../findings/target.md#L397) |

**So the denominator's vanishing at $p=0$ or $q=0$ is a symptom of the ansatz collapsing to $W=0$, not a separate exclusion, and nothing is silently assumed away.** What is owed is one clause, "$p,q\ge1$", which the block does not carry. *Note that $c_{\mathfrak k}$ is undefined for abelian $\mathfrak k$ while $S_{\mathfrak{kkk}}=0$ is perfectly defined, so it is the shortcut $S_{\mathfrak{kkk}}=c_{\mathfrak k}p$ that fails there, never the formula.*

---

## 4. "Nothing in the derivation above used $\mathfrak{su}(m)$", checked, and true

The generalisation claim is the one the brief flags as the place a hidden hypothesis lives. Reading [target.md:389](../findings/target.md#L389) step by step, the $\mathfrak{su}(m)$-specific content is exactly three substitutions, and each is a specialisation of something the general derivation leaves as a symbol:

| step in the $\mathfrak{su}(m)$ derivation | what it uses | status in L39 |
| --- | --- | --- |
| $S_{\mathfrak{kkm}}=S_{\mathfrak{mmm}}=0$ | the grading only | general, §2 |
| $S_{\mathfrak{kkk}}=(m-2)p$, $S_{\mathfrak{kmm}}=mq$ | $\mathfrak k=\mathfrak{so}(m)$ simple, and the pair's Killing constant | **left as free symbols in L39** |
| $a^2=q/(p(m^2-1))$ | $m^2-1=\dim\mathfrak{su}(m)=p+q$ | the general $a^2=q/(p(p+q))$ |
| $\theta=\operatorname{tr}(W^3)+\tfrac12[a^3S_{\mathfrak{kkk}}+3ab^2S_{\mathfrak{kmm}}]$ | the cubic expansion | general, §1 |

**No step uses simplicity of $\mathfrak g$, the bracket structure of $\mathfrak{su}(m)$, or anything beyond the grading and the two normalisations.** Simplicity enters only at the *next* claim, the reduction to $cp$, and there it is stated. The generalisation is sound.

---

## 5. $S_{\mathfrak{kkk}}+S_{\mathfrak{kmm}}=cp$, derived, and what it needs

Take $a=v_\alpha$ with $\alpha\in\mathfrak k$ in $\sum_{b\in\mathfrak g}\lVert[a,b]\rVert^2=c\lVert a\rVert^2$ and sum over an orthonormal basis of $\mathfrak k$:

$$\sum_{\alpha\in\mathfrak k}\ \sum_{\beta\in\mathfrak g}\lVert[v_\alpha,v_\beta]\rVert^2=cp .$$

Split $\beta$ by block. For $\beta\in\mathfrak k$: $[\mathfrak k,\mathfrak k]\subseteq\mathfrak k$, so $\lVert[v_\alpha,v_\beta]\rVert^2=\sum_{\gamma\in\mathfrak k}T_{\alpha\beta\gamma}$ and the double sum is $S_{\mathfrak{kkk}}$. For $\beta\in\mathfrak m$: $[\mathfrak k,\mathfrak m]\subseteq\mathfrak m$, so $\lVert[v_\alpha,v_\beta]\rVert^2=\sum_{\gamma\in\mathfrak m}T_{\alpha\beta\gamma}$ and the double sum is $S_{\mathfrak{kmm}}$. Hence

$$S_{\mathfrak{kkk}}+S_{\mathfrak{kmm}}=cp.\qquad\blacksquare$$

**It is a Killing-form identity, as the brief expects**, since $\sum_{b\in\mathfrak g}\lVert[a,b]\rVert^2=-\operatorname{tr}_{\mathfrak g}(\mathrm{ad}_a^2)=-B_{\mathfrak g}(a,a)$. **And note it is stated in the fully ordered reading**: $S_{\mathfrak{kkk}}=c_{\mathfrak k}p$ for simple $\mathfrak k$ comes out of exactly the same computation with $\mathfrak g$ replaced by $\mathfrak k$, and $(m-2)p$ is what the record records.

### Simplicity is sufficient, and more than the identity needs

- **What is actually required is $\operatorname{tr}\big(-B_{\mathfrak g}\vert_{\mathfrak k}\big)=c\,p$**, a trace over $\mathfrak k$ only. **Simplicity of $\mathfrak g$ delivers it** because the space of $\mathrm{ad}$-invariant symmetric forms on a simple algebra is one-dimensional, so $-B_{\mathfrak g}=c\langle\cdot,\cdot\rangle$ on all of $\mathfrak g$.
- **Semisimplicity alone does not**, since each simple ideal $\mathfrak g_i$ carries its own $c_i$. **But the identity has a correct replacement rather than simply failing**:
$$S_{\mathfrak{kkk}}+S_{\mathfrak{kmm}}=\sum_i c_i\operatorname{tr}\big(\Pi_{\mathfrak g_i}\vert_{\mathfrak k}\big)=\sum_i c_i\sum_{\alpha\in\mathfrak k}\lVert\Pi_{\mathfrak g_i}v_\alpha\rVert^2 ,$$
which is a definite number at $\mathfrak{so}(3)\oplus\mathfrak{so}(5)\subset\mathfrak{so}(8)$ even though [target.md:369](../findings/target.md#L369)'s "$c\in\{2,6\}$ and the Killing relation fails outright" is correct about the *single-$c$* form. *It is the four-invariant reduction that fails there, not the identity: the count becomes $p$, $q$, $S_{\mathfrak{kkk}}$ and one $c_i$ per ideal.*

> **THE PAIR THE PROGRAMME CARES ABOUT IS NOT A COUNTEREXAMPLE, AND THE BRIEF'S FRAMING OF IT IS OFF BY ONE LEVEL.** The balanced sphere product's pair is $(\mathfrak{so}(2k),\ \mathfrak{so}(k)\oplus\mathfrak{so}(k))$: **the non-simple algebra is $\mathfrak k$, and the simplicity hypothesis is on $\mathfrak g=\mathfrak{so}(2k)$, which is simple** for $2k\ge6$. So the reduction applies at the maximiser. What $\mathfrak k$'s non-simplicity costs is only the shortcut $S_{\mathfrak{kkk}}=c_{\mathfrak k}p$, replaced by $\sum_ic_i\dim\mathfrak k_i$, the correction [target.md:355](../findings/target.md#L355) and [results.md:480](../results.md#L480) both carry and **this block does not**. §7 uses it and it works.

---

## 6. $c=2h^\vee(\mathfrak g)/I_\rho$, confirmed, and the block states it in the form its own file corrected

**The two-line derivation.** With $(\cdot,\cdot)_{\rm norm}$ normalised to long roots of squared length $2$: $B_{\mathfrak g}=2h^\vee(\cdot,\cdot)_{\rm norm}$ and $\operatorname{tr}_{\mathbb R}\rho(X)\rho(Y)=2I_\rho(\cdot,\cdot)_{\rm norm}$. The record's pairing is $\langle X,Y\rangle=-\tfrac12\operatorname{tr}_{\mathbb R}\rho(X)\rho(Y)=-I_\rho(\cdot,\cdot)_{\rm norm}$. Since $c=-B_{\mathfrak g}(a,a)/\langle a,a\rangle$,

$$c=\frac{-2h^\vee(a,a)_{\rm norm}}{-I_\rho(a,a)_{\rm norm}}=\frac{2h^\vee}{I_\rho}.$$

Signs are consistent: on a compact real form $(\cdot,\cdot)_{\rm norm}$ is negative definite, so $\langle a,a\rangle>0$ and $c>0$.

**$I_\rho$ is the Dynkin index of the real representation $\rho:\mathfrak g\hookrightarrow\mathfrak{so}(n)$, normalised so the $\mathfrak{so}(n)$ vector representation has index $1$, equivalently, half the standard index of the complexification.** I re-derived all four table anchors intrinsically from $c=-B/\langle\cdot,\cdot\rangle$, using no index tables at all:

| pair | intrinsic computation | $c$ | table $2h^\vee/I_\rho$ |
| --- | --- | --- | --- |
| $\mathfrak{so}(n)$, vector | $B=(n-2)\operatorname{tr}(XY)$, $\operatorname{tr}(a^2)=-2$ at $\lVert a\rVert=1$ | $2(n-2)$ | $2(n-2)/1$ ✓ |
| $\mathfrak{su}(m)$ on $\mathbb R^{2m}$ | $B=2m\operatorname{tr}_{\mathbb C}(XY)$, $\langle X,X\rangle=-\operatorname{tr}_{\mathbb C}(X^2)$ | $2m$ | $2m/1$ ✓ |
| $\mathfrak{so}(m)\subset\mathfrak{su}(m)$ on $\mathbb R^m\oplus\mathbb R^m$ | $\langle X,X\rangle=-\operatorname{tr}_{\mathbb R^m}(X^2)$, $B=(m-2)\operatorname{tr}_{\mathbb R^m}(X^2)$ | $m-2$ | $2(m-2)/2$ ✓ |
| $\mathfrak{so}(3)$ on $\mathrm{Sym}^2_0(\mathbb R^3)$ | $L_z$ has weights $im$, $\lvert m\rvert\le2$: $\langle X,X\rangle=5$, $B(X,X)=-2$ | $\mathbf{2/5}$ | matches the record's sharpest check ✓ |

**So the constant is right and the match to the half-trace pairing is exact**, the pairing enters only through $\langle X,Y\rangle=-I_\rho(\cdot,\cdot)_{\rm norm}$, and that is where the $\tfrac12$ of the half-trace is spent.

> **BUT THE BLOCK PRINTS THE PRE-CORRECTION FORM, 304 LINES BELOW THE CORRECTION.** L39 says only *"$c=2h^\vee(\mathfrak g)/I_\rho$, dual Coxeter number over Dynkin index"*. [target.md:355](../findings/target.md#L355) (in the same file), says in bold that **anyone applying the rule with indices from Slansky or LiE gets every $c$ wrong by a factor $2$**, and gives the fix. The block reproduces the sentence that correction was written against, with "classical table data" attached to it. *[report/sections/07-gradedness-split.tex:1116](../report/sections/07-gradedness-split.tex#L1116) carries both the normalisation trap and the $\mathfrak k$-centre correction in its certificate; [results.md:480](../results.md#L480) carries the centre correction. **This copy is the stalest of the three.***
>
> It also crosses [conventions.md](../findings/conventions.md)'s own bullet, *"Killing constants come from the definition, never from an index convention"*, and its standing rule that conventions are quoted rather than restated. **One clause, "with $I$ normalised so the $\mathfrak{so}(n)$ vector representation has index $1$ ([conventions.md](../findings/conventions.md))", closes it.**

---

## 7. THE GAP: the formula values an operator that is generically not a Weyl tensor

**This is the finding I would act on.** L39 says "the two-eigenvalue point has ... $\theta^2=\ldots$", and $\theta$ is defined on the record as $P(W)/\lVert W\rVert^3$ for *any* $W$. The formula is therefore correct as printed, §1's anchor 3 records that the expansion holds off $\mathrm{Weyl}_n$, free of Bianchi and Ricci-flatness, **but the block attaches no hypothesis, and its neighbours 285 lines above establish that the ansatz $a\Pi_{\mathfrak k}+b\Pi_{\mathfrak m}$ is a Weyl tensor for only three of sixteen pairs built.** [results.md:480](../results.md#L480) carries the guard sentence, *"the formula gives the value of the point and decides nothing about whether that point is a Weyl tensor"*, **and this copy drops it.**

**The cost is concrete, and it is exactly at the family the programme's threshold is set by.** Applying L39 to $(\mathfrak{so}(n),\ \mathfrak{so}(r)\oplus\mathfrak{so}(s))$ with $p=\binom r2+\binom s2$, $q=rs$, $S_{\mathfrak{kkk}}=2(r-2)\binom r2+2(s-2)\binom s2$ and $S_{\mathfrak{kmm}}=2(n-2)p-S_{\mathfrak{kkk}}$, against the true sphere-product value $\theta^2=\frac{2(r-1)(s-1)(n-1)}{rs(n-2)}$ ([target.md:494](../findings/target.md#L494)):

| pair | $n$ | L39 $\theta^2$ | true $\theta^2$ | $\Theta_n^2$ | |
| --- | --- | --- | --- | --- | --- |
| $S^3\times S^3$ | $6$ | $1.11111111$ | $1.11111111$ | $1.11111111$ | **exact** |
| $S^4\times S^4$ | $8$ | $1.31250000$ | $1.31250000$ | $1.31250000$ | **exact** |
| $S^5\times S^5$ | $10$ | $1.44000000$ | $1.44000000$ | $1.44000000$ | **exact** |
| $S^6\times S^6$ | $12$ | $1.52777778$ | $1.52777778$ | $1.52777778$ | **exact** |
| $S^2\times S^3$ | $5$ | $1.00104167$ | $0.88888889$ | $0.88888889$ | **over by $12.6\%$** |
| $S^3\times S^4$ | $7$ | $1.23853616$ | $1.20000000$ | $1.20000000$ | over by $3.2\%$ |
| $S^3\times S^5$ | $8$ | $1.32565620$ | $1.24444444$ | $1.31250000$ | over by $6.5\%$ |
| $S^4\times S^5$ | $9$ | $1.38908420$ | $1.37142857$ | $1.37142857$ | **over by $1.29\%$** |
| $S^4\times S^6$ | $10$ | $1.44905248$ | $1.40625000$ | $1.44000000$ | over by $3.0\%$ |
| $S^5\times S^6$ | $11$ | $1.49100606$ | $1.48148148$ | $1.48148148$ | over by $0.64\%$ |

*Screen only, exact rationals, seconds of arithmetic on pairs constructed for this check, reported as a screen.*

**Read the two halves.** At $r=s$ the ansatz **is** the sphere product's Weyl tensor and L39 returns $\theta_0(2k)^2=(k-1)(2k-1)/k^2=2(n-1)(n-2)/n^2$, which I derived in closed form, not only tabulated, and which is $\Theta_n$ at even $n$. At $r\ne s$ the ansatz fails Ricci-flatness ([target.md:363](../findings/target.md#L363)) and the number it returns belongs to no Weyl tensor. **It overshoots in every case checked.**

### The parity question the brief asks

$\Theta_n=\theta_0(n)$ **at even $n$ only**, and the odd-$n$ value is $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$. I confirmed that odd value is exactly the true $S^{(n-1)/2}\times S^{(n+1)/2}$ sphere product: substituting $r=(n-1)/2$, $s=(n+1)/2$ into $\frac{2(r-1)(s-1)(n-1)}{rs(n-2)}$ gives $\frac{2(n-3)(n-1)}{(n+1)(n-2)}$ identically. **The odd maximiser is therefore an unbalanced pair, and L39 cannot reach it**: there is no balanced symmetric pair at odd $n$, and at the nearest pair L39 returns the overshooting number in the table ($1.38908$ against $\Theta_9^2=1.37143$; $1.49101$ against $\Theta_{11}^2=1.48148$).

**Stated positively: L39 reproduces the programme's benchmark $\Theta_n$ exactly at every even $n$, by way of $\mathfrak g=\mathfrak{so}(2k)$ simple with $\mathfrak k$ non-simple, and at odd $n$ it prices a different operator.** Anyone maximising L39 over Cartan's list to bound $\theta$ on $\mathcal W_n$ would be bounding a set that contains non-Weyl operators, and the bound so obtained is not a bound on the conjecture.

### $n=8$ and triality

**L39 reads nothing off Cartan's list.** Its four invariants are computed from $(\mathfrak g,\mathfrak k,\rho)$ as embedded, and $\rho$ is precisely the datum Cartan's classification-up-to-$\mathrm{Aut}(\mathfrak g)$ discards, which is why [target.md:369](../findings/target.md#L369) can exhibit two pairs with identical $(p,q,S_{\mathfrak{kkk}},S_{\mathfrak{kmm}})$ failing admissibility differently. **So the $n=8$ hazard does not reach this Lemma**: $\theta$ is constant on the triality orbit, $\mathbb{HP}^2$ and $S^3\times S^5$ both sit at $\sqrt{56/45}=1.11554670$, which is the record's own figure, while the symmetry defect, which L39 never computes, is not. The hazard would bite only for a claim that the four invariants identify an $SO(n)$-orbit, and L39 makes no such claim. *It should say so; the brief's worry is a live one for the reduction the block invites, and it is closed only by the sentence this copy drops.*

---

## 8. Where the row marginal lives, and that it has no number

The brief asks. $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=2(n-2)$ is:

- **stated as a standing fact, unnumbered**, in [conventions.md](../findings/conventions.md), bullet "The pair cap and the Killing marginal";
- **proved in one line** inside [fence post F18](../findings/bounds-relaxations.md#L114), *"the Killing form $\operatorname{tr}(\mathrm{ad}X\,\mathrm{ad}Y)=(n-2)\operatorname{tr}(XY)$ makes every row marginal $\rho_\alpha=2(n-2)$, which needs only $\lVert v_\alpha\rVert=1$ and holds off $\mathrm{Weyl}_n$ too"*, so [target.md:626](../findings/target.md#L626)'s citation of it to F18 is fair;
- **consumed unnumbered** in [Lemma L114](../findings/bounds-relaxations.md#L126) and across [fence-posts.md](../findings/fence-posts.md).

**Its companion, the pair cap $\sum_\gamma T_{\alpha\beta\gamma}\le2$, IS numbered, [Lemma L31](../findings/stratum-two-negative.md).** The marginal, which is the stronger and more used of the two, is not. *Owed: a number, or an explicit note in [INDEX-results.md](../findings/INDEX-results.md) that it is a definitional consequence and deliberately unnumbered.*

---

## 9. Provenance, CLEAN, and it is the first clean one in this run

The block carries the boilerplate *"the result was numbered in report/ and the mathematics has always been in this file, but it carried no block"*. **Checked, and it holds.**

| check | result |
| --- | --- |
| `git log -S 'q^2+3S_{\mathfrak{kmm}}p^2-2p^3+2pq^2'` | origin **6a6a5c98**, 2026-08-24, *"feat(conjecture-a): theta for EVERY two-eigenvalue symmetric pair, in four invariants"* |
| file at origin | `FINDINGS.md` (pre-split), then `findings/live-front.md` at **51ab61f8** (same day), then `findings/target.md` at **ea7c61c4** (2026-08-26) |
| block created | **86621751**, 2026-08-31, *"number the 24 results that only the report had numbered"* |
| the named section | exists, 314 lines above the block, and **is** the derivation |

**So the mathematics has been in this file's lineage from the day it entered, and never in a different subject file.** The only pedantry available is that `findings/target.md` did not exist under that name until five days before the block, the lineage `FINDINGS.md` → `live-front.md` → `target.md` is a pure rename chain, so the sentence is true in substance. *This breaks the pattern the brief describes, and it is worth recording as a negative result about the boilerplate: the sentence is pasted, but it is not always false.*

**One pointer defect, cosmetic.** The block quotes the section as *"The $(\mathfrak{su}(m),\mathfrak{so}(m))$ derivation generalises to EV"*, truncated mid-word; the heading is *"... generalises to EVERY symmetric pair, giving $\theta$ in four Lie-theoretic invariants"*. It resolves by prefix grep and would not resolve as an anchor link.

**All other pointers resolve**: [report/](../report/) exists and holds L39 at [07-gradedness-split.tex:1116](../report/sections/07-gradedness-split.tex#L1116); [INDEX-results.md](../findings/INDEX-results.md) row **39** points at [target.md](../findings/target.md) and correctly reads *"Gate 2: no verdict on the record"*, which this review and its sibling supply.

---

## 10. The hedging clauses, one by one

| clause | verdict |
| --- | --- |
| *"$S_{\mathfrak{kkm}}=S_{\mathfrak{mmm}}=0$ **identically**"* | **TRUE, and understated**, it is a property of the pair, independent of $W$ and of the two-eigenvalue point |
| *"Nothing in the derivation above used $\mathfrak{su}(m)$"* | **TRUE**, checked step by step in §4 |
| *"When $\mathfrak g$ is simple"* | **TRUE and sufficient**; §5 gives the weaker hypothesis and the semisimple replacement |
| *"$\theta$ depends on four invariants only"* | **TRUE of the formula.** Silent on what four invariants do *not* determine, admissibility, and the $SO(n)$-orbit |
| *"The constant is classical table data"* | **TRUE only with the index normalisation the block omits**; §6 |
| *"the two-eigenvalue point"* | **inaccurate whenever $\mathfrak g\subsetneq\mathfrak{so}(n)$**, the operator has eigenvalues $a$, $b$ and $0$; harmless here, §3 step 0 |

## 11. Does the block's own file settle it?

**Yes, four times, all above the block:**

| what the block omits | where its own file has it |
| --- | --- |
| the derivation | [target.md:337](../findings/target.md#L337), 314 lines above |
| the $I_\rho$ normalisation | [target.md:355](../findings/target.md#L355), 296 lines above |
| $S_{\mathfrak{kkk}}=\sum_ic_i\dim\mathfrak k_i$ when $\mathfrak k$ has a centre | [target.md:355](../findings/target.md#L355) |
| the ansatz is generically not a Weyl tensor | [target.md:363](../findings/target.md#L363), 288 lines above |

*Every one of these is a sentence the block could carry in a clause.*

---

## What is owed, and all of it is reachable

1. **One row in [conventions.md](../findings/conventions.md) fixing $S_{XYZ}$ as the fully ordered block mass**, noting that [Lemma L114](../findings/bounds-relaxations.md#L126) is stated in the unordered reading. *The two are individually correct and the symbol is shared.*, one line, no computation.
2. **Restore to the block the scope sentence [results.md](../results.md#L480) carries**, the formula values a point and decides nothing about whether it is a Weyl tensor. **This is the gap.**, one sentence.
3. **Add the $I_\rho$ normalisation clause and the $\mathfrak k$-centre correction**, both already in the same file and in [report/](../report/)., two clauses.
4. **Add "$p,q\ge1$" and "the involution an isometry of the pairing"** to the hypotheses., two clauses.
5. **Fix the truncated section quotation.**, one word.
6. **Consider numbering the row marginal $2(n-2)$**, or recording deliberately that it stays unnumbered.

**No item requires computation.** The mathematics of L39 stands as written; what it lacks is the hypothesis that stops a reader turning a value formula into a bound.

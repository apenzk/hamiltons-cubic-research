# VERIFY v138, L23's closed forms $\theta=\tfrac2n\sqrt{rN/(N-r)}$ and $S_{\mathfrak{mmm}}=(N-r)[2(n-2)-4(n-1)r/N]$, the cap $r\le n(n-2)/4$, and the even-$n$ equality case

**Cold brief, analysis only.** Verifier v138 on [ROUND_L23.md](ROUND_L23.md), checking the block quoted from [ungraded-slack.md](../findings/ungraded-slack.md):124–150 against its canonical twin at [results.md](../results.md):395–403. **No numerical work was done: no script was run, no solver, no sweep.** Every value below is an exact hand evaluation, and each is shown as a rational or a surd before any decimal is quoted. Log: [agent_logs/verify-L23-v138.log](../agent_logs/verify-L23-v138.log). No other verifier's report was read.

## Claim table

| # | claim, as the block states it | verdict |
| --- | --- | --- |
| C1 | the two block-trace equations, $u^2+\tfrac1{2r}(S_{\mathfrak{hhh}}u^2+S_{\mathfrak{hmm}}v^2)=\theta u$ and $v^2+\tfrac1{2(N-r)}(2S_{\mathfrak{hmm}}uv+S_{\mathfrak{mmm}}v^2)=\theta v$ | **PROVEN** |
| C2 | the two Killing relations $S_{\mathfrak{hhh}}+S_{\mathfrak{hmm}}=\kappa r$ and $2S_{\mathfrak{hmm}}+S_{\mathfrak{mmm}}=\kappa(N-r)$, $\kappa=2(n-2)$ | **PROVEN** |
| C3 | the elimination gives $S_{\mathfrak{hmm}}=2\sigma r(N-r)/N$ and $\theta=\sigma ur/(N-r)$ with $\sigma=n-1$, and is forced | **PROVEN**, the reduced system is linear with nonvanishing determinant |
| C4 | $\theta=\tfrac2n\sqrt{rN/(N-r)}$ | **PROVEN** for the positive multiple |
| C5 | $S_{\mathfrak{mmm}}=(N-r)\big[2(n-2)-\tfrac{4(n-1)r}N\big]$ | **PROVEN** |
| C6 | $r\le n(n-2)/4$ | **PROVEN** |
| C7 | $\theta\le\theta_0(n)$, with $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ at the cap | **PROVEN**, the monotonicity step it turns on is not written in the proof |
| C8 | equality in either place exactly when $S_{\mathfrak{mmm}}=0$, and the two equality cases coincide | **PROVEN** |
| C9 | $S_{\mathfrak{mmm}}=0\iff[\mathfrak m,\mathfrak m]\subseteq\mathfrak h\iff(\mathfrak{so}(n),\mathfrak h)$ a symmetric pair | **PROVEN**, the block's label of which arrow needs the argument is inverted |
| C10 | for $n$ even the equality case is $\mathfrak h=\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ alone, $n=8$ included | **HYPOTHESIS-DEBT**, rests on Cartan's classification, which [references/](../references/) does not hold; and the $n=8$ warrant is a dimension count that the record itself certifies as insufficient at that dimension |
| C11 | for $n$ odd the cap is not an integer and the inequality is strict | **PROVEN** |
| C12 | the *Producing members* criterion, $K$-irreducible, inequivalent, $(\mathrm{Sym}^2\mathbb R^n)^K=\mathbb R\,\mathrm{Id}$, $(\Lambda^4\mathbb R^n)^K=0$ | **PROVEN** as stated, with two imports it does not name |
| C13 | "$W_{\mathfrak h}$ the unit-norm multiple of $\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$" | **BROKEN as stated**, there are two unit-norm multiples and the displayed $\theta$ is false at one of them; the proof fixes the sign, the statement does not |
| C14 | "the subalgebras that exceed the cap are … $\mathfrak u(m)$, $\mathfrak{su}(m)$, $\mathfrak{sp}(m)\oplus\mathfrak{sp}(1)$ at $m\le2$" | **BROKEN under the distributive reading**, and contradicted eight lines later by the block's own $\mathfrak u(m)$ sentence |
| C15 | "only $\mathfrak g_2$ and $\mathfrak{spin}(7)$ are excluded by the $4$-form" | **withdrawn** as a discrepancy, I could not exhibit the failure at a named object without computation |
| C16 | [Lemma L4](../findings/ungraded-slack.md)'s advertisement of the same closed form | **BROKEN**, criticality, the whole hypothesis of L23, is absent from L4's sentence at both of its sites, and the record holds two objects where the two readings give different numbers |
| C17 | Lean coverage | **no row states L23**, [lean/INDEX.md](../lean/INDEX.md):82 formalises a different inequality that shares L23's expression |

**One line.** The mathematics of the closed forms, the cap and the equality characterisation is correct and I rebuilt every step of it from the definitions; what fails is around the statement, the sign of the multiple, the classification the uniqueness clause imports without a readable source, one list that is false under its plain reading, and the consumer-facing copy at [Lemma L4](../findings/ungraded-slack.md), which drops the hypothesis that carries the whole result.

**Verdict: `PROVEN, hypotheses corrected`**, with C10 carved out as `HYPOTHESIS-DEBT` and C13, C14, C16 as defects in citable text. What a consumer may cite is set out in §7.

## 0. Conventions, fixed once

Every convention below is quoted from [conventions.md](../findings/conventions.md), which is the record's single source for them; none is restated from memory, and each is named where it becomes load-bearing.

| symbol | reading used here | where the block's constants depend on it |
| --- | --- | --- |
| $\langle X,Y\rangle$ on $\Lambda^2$ | the half-trace pairing, $\lVert\varphi_{ab}\rVert^2=1$, under which $\{\varphi_{ab}\}_{a<b}$ is orthonormal | this is the normalisation in which $\kappa=2(n-2)$ and in which $\lVert W\rVert=1$ reads $ru^2+(N-r)v^2=1$. Under plain Frobenius, $\lVert\varphi_{ab}\rVert^2=2$, every constant below moves |
| $c_{abc}=\langle[v_a,v_b],v_c\rangle$ | totally antisymmetric; $T_{abc}=c_{abc}^2$ totally symmetric, vanishing when two indices coincide | total symmetry of $T$ is what lets the mixed $\mathfrak{hmm}$ terms be collected as $2S_{\mathfrak{hmm}}$ in the $\mathfrak m$-row |
| $\kappa$ | $2(n-2)$, from $B(X,Y)=(n-2)\operatorname{tr}(XY)$ with $\operatorname{tr}(v^2)=-2$ at a unit bivector | the right-hand sides $\kappa r$ and $\kappa(N-r)$ of the two Killing relations |
| $\#$ | the **halved** Böhm–Wilking product, $vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$ | the $\tfrac12$ in $(W^\#)_{\gamma\gamma}=\tfrac12\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta T_{\gamma\alpha\beta}$, hence the $\tfrac1{2r}$ and $\tfrac1{2(N-r)}$ of the two trace equations, hence $\sigma=1+\kappa/2=n-1$. **Under an unhalved $\#$, $\sigma$ would read $1+\kappa=2n-3$ and every value below would change** |
| $S_{XYZ}$ | the block-restricted contraction of $T$ over **ordered** slots, the reading [conventions.md](../findings/conventions.md) adopted on 2026-09-04 | $S_{\mathfrak{mmm}}$'s displayed value. Under the unordered reading the same quantity is $S_{\mathfrak{mmm}}/6$, and the block's display is in the ordered one |
| the Killing row marginal | $\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)$ over **ordered** pairs, **[Lemma L153](../findings/bounds.md)** | both Killing relations are this summed over the $r$ rows of $\mathfrak h$ and the $N-r$ rows of $\mathfrak m$. [results.md](../results.md):399 says so in an italic line that [ungraded-slack.md](../findings/ungraded-slack.md) does not carry |
| $\theta_0(n)$ | $\theta_0(n)^2=2(n-1)(n-2)/n^2$ **and nothing more** | the value at the cap. It is $\Theta_n$ only at even $n$, which matters at C11 |
| $\theta$ | $P(W)/\lVert W\rVert^3$; at a critical point $Q(W)=\theta W$ | **the two readings separate off the critical locus**, which is the whole of C16 |
| "critical point" | $Q(W)=\theta W$, the first-order condition on the unit sphere | the block's hypothesis is exactly this, at $W_{\mathfrak h}$ |

**Two things the block does *not* need, and it is worth saying so because the surrounding file is about Weyl operators.** The derivation nowhere uses $\mathrm{Ric}(W_{\mathfrak h})=0$ and nowhere uses the first Bianchi identity. It is a statement about $Q$ on $\mathrm{Sym}^2(\Lambda^2\mathbb R^n)$, so it applies to a subalgebra whose Casimir operator lies outside $\mathcal W_n$, which is what makes the $\mathfrak g_2\subset\mathfrak{so}(7)$ test in §5 meaningful.

## 1. The hypothesis inventory

**Hypotheses the derivation uses.**

| # | hypothesis | where it is used | does the Statement carry it |
| --- | --- | --- | --- |
| H1 | $\mathfrak h$ is a Lie **subalgebra** of $\mathfrak{so}(n)$ | twice, and both uses are essential: it kills the mixed term in the $\mathfrak h$-row of $W^\#$, and it is what makes $S_{\mathfrak{hhm}}=0$ so that the two Killing relations close on three unknowns rather than four | **yes** |
| H2 | $\mathfrak m=\mathfrak h^\perp$ in the invariant pairing | the orthogonal splitting $\Lambda^2=\mathfrak h\oplus\mathfrak m$, and $\langle[h,m],h'\rangle=-\langle m,[h,h']\rangle$ at C9 | **yes** |
| H3 | $0<r<N$ | the divisions by $u$ and by $v$ in the elimination; $u=0$ at $r=N$ and $v=0$ at $r=0$ | **yes** |
| H4 | $\lVert W_{\mathfrak h}\rVert=1$ | converting $\theta=\sigma ur/(N-r)$ into the closed form, through $u^2=(N-r)/(rN)$ | **yes** |
| H5 | the multiple is the **positive** one, $c>0$ | the sign of $\theta$. The proof fixes it ("Write $u=c(1-r/N)>0$"), the statement does not | **no**, see C13 |
| H6 | $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$ | everything. The two displayed scalar equations are its traces against $\Pi_{\mathfrak h}$ and $\Pi_{\mathfrak m}$ | **yes** |
| H7 | the half-trace normalisation on $\Lambda^2$, the halved $\#$, and ordered $S_{XYZ}$ | every constant | **no**, and correctly so, they are [conventions.md](../findings/conventions.md)'s and are quoted rather than restated |

**Imported results, each checked against the object it is applied to.**

| import | statement | the object here | verdict |
| --- | --- | --- | --- |
| **[Lemma L153](../findings/bounds.md)**, the Killing row marginal | $\sum_\beta\lVert[v,v_\beta]\rVert^2=2(n-2)\lVert v\rVert^2$ for any $v\in\mathfrak{so}(n)$, $n\ge2$ | applied at each of the $N$ basis bivectors, which are unit vectors of $\Lambda^2$ in the half-trace pairing | **applies**, L153's hypothesis is $\lVert v\rVert=1$ and nothing else, and the ordered-pair reading is the one the block's $\kappa r$, $\kappa(N-r)$ need |
| the eigenbasis form of $W^\#$ | $(W^\#)_{\gamma\gamma}=\tfrac12\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta T_{\gamma\alpha\beta}$ | $W_{\mathfrak h}$ is diagonal in any orthonormal basis adapted to $\mathfrak h\oplus\mathfrak m$, so such a basis is an eigenbasis | **applies.** It is [bounds.md](../findings/bounds.md):188 read at a basis vector, and follows in one line from [conventions.md](../findings/conventions.md)'s halved $\#$ |
| **Cartan's classification** of the symmetric pairs of $\mathfrak{so}(n)$ | the involutions are BDI $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ and DIII $\mathfrak u(n/2)$, plus two more at $n=8$ | the equality case's uniqueness clause | **rests on an unread source.** [references/](../references/) holds no Helgason and no Cartan entry, [conventions.md](../findings/conventions.md) says so in its own table, and [LEDGER.md](../findings/LEDGER.md):1284 records acquiring one as blocked on the user. See §4 |
| **[trap W2](../findings/INDEX-traps.md)** | the $\mathbb Z_2$-grading enumeration carries "$n\ne8$"; at $n=8$ triality adds exactly $\mathfrak{spin}(7)$ and $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$ | the $n=8$ clause | **applies, and it is the exactly-two claim that the clause needs**, not the two dimensions the clause actually quotes. See §4 |

**Hypotheses the derivation does *not* use, and which the Statement correctly does not carry.** $\mathfrak h$ irreducible on $\mathbb R^n$; $\mathfrak h$ semisimple, simple, or non-abelian; $\mathfrak h$ maximal; $\mathfrak m$ irreducible; $\mathfrak h\not\cong\mathfrak m$; $(\Lambda^4\mathbb R^n)^K=0$; $\mathrm{Ric}(W_{\mathfrak h})=0$; the first Bianchi identity; $W_{\mathfrak h}\in\mathcal W_n$; any lower bound on $n$. The last four of these are hypotheses of the *Producing members* criterion, which is a separate statement in the same block and is checked at §6.

## 2. Pre-registered question 1, does the closed form follow?

**Yes. I rebuilt every step from the definitions before reading the block's own wording, and the block's four displays reproduce character for character.**

### 2.1 Setting

Fix an orthonormal basis $\{\varphi_\alpha\}_{\alpha=1}^N$ of $\Lambda^2\mathbb R^n$ adapted to $\Lambda^2=\mathfrak h\oplus\mathfrak m$, the first $r$ vectors spanning $\mathfrak h$. In it $W_{\mathfrak h}=c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$ is diagonal, with

$$u=c\Big(1-\frac rN\Big)\ \text{on }\mathfrak h\ (\text{multiplicity }r),\qquad v=-c\frac rN\ \text{on }\mathfrak m\ (\text{multiplicity }N-r).$$

Tracelessness is an identity rather than a hypothesis: $ru+(N-r)v=cr-\tfrac{cr^2}N-\tfrac{cr(N-r)}N=cr-cr=0$, so $v=-\rho u$ with $\rho=r/(N-r)$.

### 2.2 The two scalar equations, C1

$W^2$ is diagonal with $u^2$ on $\mathfrak h$ and $v^2$ on $\mathfrak m$. For $W^\#$, use $(W^\#)_{\gamma\gamma}=\tfrac12\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta T_{\gamma\alpha\beta}$ and split the $(\alpha,\beta)$ sum by block.

**For $\gamma\in\mathfrak h$.** The mixed terms carry $T_{\gamma\alpha\beta}$ with $\gamma,\alpha\in\mathfrak h$ and $\beta\in\mathfrak m$, which is $\langle[\varphi_\gamma,\varphi_\alpha],\varphi_\beta\rangle^2$; since $\mathfrak h$ is a subalgebra, $[\varphi_\gamma,\varphi_\alpha]\in\mathfrak h\perp\mathfrak m$ and the term vanishes. **This is H1's first use.** What survives is $u^2$ against the $\mathfrak{hh}$ block and $v^2$ against the $\mathfrak{mm}$ block, and summing over the $r$ rows of $\mathfrak h$,

$$\sum_{\gamma\in\mathfrak h}(W^\#)_{\gamma\gamma}=\tfrac12\big(S_{\mathfrak{hhh}}u^2+S_{\mathfrak{hmm}}v^2\big).$$

Tracing $Q(W)=\theta W$ against $\Pi_{\mathfrak h}$ and dividing by $r$ gives the first display exactly: $u^2+\tfrac1{2r}(S_{\mathfrak{hhh}}u^2+S_{\mathfrak{hmm}}v^2)=\theta u$.

**For $\gamma\in\mathfrak m$.** Now the $\mathfrak{hh}$ terms die, by the same inclusion read the other way, $T_{\gamma\alpha\beta}$ with $\alpha,\beta\in\mathfrak h$ and $\gamma\in\mathfrak m$ is $\langle[\varphi_\alpha,\varphi_\beta],\varphi_\gamma\rangle^2=0$, and the two mixed orders each contribute $S_{\mathfrak{hmm}}$ by total symmetry of $T$, so

$$\sum_{\gamma\in\mathfrak m}(W^\#)_{\gamma\gamma}=\tfrac12\big(2S_{\mathfrak{hmm}}uv+S_{\mathfrak{mmm}}v^2\big),$$

and dividing by $N-r$ gives the second display exactly. **C1 confirmed.** *Both equations are traces of the eigen-equation, hence strictly weaker than it; everything derived from them is therefore a necessary condition on a member and not a sufficient one. The block says "yields the two scalar equations, as the traces of", so it does not claim otherwise.*

### 2.3 The two Killing relations, C2

Summing the row marginal $\sum_{\beta\gamma}T_{\alpha\beta\gamma}=\kappa$ (**[Lemma L153](../findings/bounds.md)**, ordered pairs) over $\alpha\in\mathfrak h$ and splitting: the $\mathfrak{hh}$ pairs give $S_{\mathfrak{hhh}}$, the $\mathfrak{mm}$ pairs give $S_{\mathfrak{hmm}}$, and the mixed pairs vanish by H1. Hence $S_{\mathfrak{hhh}}+S_{\mathfrak{hmm}}=\kappa r$. Summing over $\alpha\in\mathfrak m$: the $\mathfrak{hh}$ pairs vanish, the two mixed orders give $2S_{\mathfrak{hmm}}$, the $\mathfrak{mm}$ pairs give $S_{\mathfrak{mmm}}$. Hence $2S_{\mathfrak{hmm}}+S_{\mathfrak{mmm}}=\kappa(N-r)$. **C2 confirmed**, and the block's parenthetical justification ("Because $\mathfrak h$ is a subalgebra, $[\mathfrak h,\mathfrak h]\perp\mathfrak m$"), is exactly the step both relations turn on.

### 2.4 The elimination, and that it is forced, C3

Substituting $S_{\mathfrak{hhh}}=\kappa r-S_{\mathfrak{hmm}}$ into the first equation and $S_{\mathfrak{mmm}}=\kappa(N-r)-2S_{\mathfrak{hmm}}$ into the second, and writing $\sigma=1+\kappa/2=n-1$:

$$\sigma u^2+\frac{S_{\mathfrak{hmm}}}{2r}(v^2-u^2)=\theta u,\qquad \sigma v^2+\frac{S_{\mathfrak{hmm}}}{N-r}\,v(u-v)=\theta v.$$

By H3, $u\ne0$ and $v\ne0$, so both may be divided through. With $v=-\rho u$, $1+\rho=N/(N-r)$ and $\rho^2-1=N(2r-N)/(N-r)^2$, the pair becomes

$$\theta=u\Big[\sigma+\frac{S_{\mathfrak{hmm}}N(2r-N)}{2r(N-r)^2}\Big],\qquad \theta=u\Big[-\sigma\rho+\frac{S_{\mathfrak{hmm}}N}{(N-r)^2}\Big].$$

**This is a linear system in the two unknowns $(\theta,S_{\mathfrak{hmm}})$, and its determinant does not vanish.** The coefficients of $S_{\mathfrak{hmm}}$ differ by

$$\frac{uN}{(N-r)^2}\Big[1-\frac{2r-N}{2r}\Big]=\frac{uN}{(N-r)^2}\cdot\frac N{2r}=\frac{uN^2}{2r(N-r)^2}\neq0,$$

since $u>0$ by H5 and $0<r<N$ by H3. **So the solution is unique, the elimination is forced, not one solution among several.** Subtracting,

$$\sigma\frac N{N-r}=\frac{S_{\mathfrak{hmm}}N^2}{2r(N-r)^2}\quad\Longrightarrow\quad S_{\mathfrak{hmm}}=\frac{2\sigma r(N-r)}N,$$

which is the block's display, and feeding it back into the second equation,

$$\theta=u\Big[-\frac{\sigma r}{N-r}+\frac{2\sigma r}{N-r}\Big]=\frac{\sigma ur}{N-r},$$

which is the block's other display. **C3 confirmed, including its forcedness.**

### 2.5 The closed form, C4

Unit norm gives $1=ru^2+(N-r)\rho^2u^2=u^2r\cdot\frac{N-r+r}{N-r}=\frac{u^2rN}{N-r}$, so $u^2=\dfrac{N-r}{rN}$ and, taking the positive root by H5,

$$\theta=\frac{\sigma r}{N-r}\sqrt{\frac{N-r}{rN}}=\sigma\sqrt{\frac{r}{N(N-r)}}.$$

That this is the block's $\tfrac2n\sqrt{rN/(N-r)}$ is the identity $\sigma/N=(n-1)\big/\tfrac{n(n-1)}2=2/n$, applied inside the root: $\sigma^2\frac r{N(N-r)}=\frac{\sigma^2}{N^2}\cdot\frac{rN}{N-r}=\frac4{n^2}\cdot\frac{rN}{N-r}$. **C4 confirmed.**

### 2.6 The companion, C5

Back-substitution into the second Killing relation:

$$S_{\mathfrak{mmm}}=\kappa(N-r)-\frac{4\sigma r(N-r)}N=(N-r)\Big[2(n-2)-\frac{4(n-1)r}N\Big].$$

**C5 confirmed**, character for character.

### 2.7 Which normalisations the constants depend on

Answering the pre-registered question's third clause directly, and each answer is read off §2 rather than asserted.

- **$\sigma=n-1$ is $1+\kappa/2$, and the $\tfrac12$ is the halved $\#$.** The $1$ is the $W^2$ term; the $\kappa/2$ is $\kappa$ times the $\tfrac12$ in $(W^\#)_{\gamma\gamma}$. Under an unhalved $\#$ the same derivation returns $\sigma=2n-3$, and $\theta$ at the balanced split would read $\frac{2n-3}{n-1}\theta_0(n)$, off by $9/5$ at $n=6$. So the closed form is not merely rescaled by that convention, it is a different function of $n$.
- **$\kappa=2(n-2)$ is the half-trace normalisation.** It comes from $B(X,Y)=(n-2)\operatorname{tr}(XY)$ with $\operatorname{tr}(v^2)=-2$ at a unit bivector, which is [conventions.md](../findings/conventions.md)'s statement that Killing constants come from the definition and never from an index convention.
- **The $\tfrac2n$ in the closed form is $\sigma/N$**, so it carries both the halved $\#$ and $N=\binom n2$; it is not an independent constant.
- **$S_{\mathfrak{mmm}}$'s display is in the ordered reading of $S_{XYZ}$.** In the unordered reading the same object is one sixth of it, and [conventions.md](../findings/conventions.md) records that the conversion is per-pattern rather than global, $6\times$ on $\mathfrak{mmm}$ and $\mathfrak{hhh}$, $2\times$ on the mixed patterns. **The block's two Killing relations are consistent only in the ordered reading**, since they mix $\mathfrak{hmm}$ with $\mathfrak{hhh}$ and $\mathfrak{mmm}$ at coefficient $1$ and $2$; converting one pattern and not the others breaks them. This is worth saying because [plan-verification.md](../plan-verification.md):403 records an open thread of exactly this shape, a factor of two between a slack figure in [nondegeneracy.md](../findings/nondegeneracy.md) and L23's $S_{\mathfrak{mmm}}=280$ at $\mathfrak{so}(5)\subset\mathfrak{so}(10)$.
- **Unit norm is in the $\Lambda^2$ half-trace pairing.** [conventions.md](../findings/conventions.md) records that applying the $\tfrac12$ at the operator level instead inflates every $\theta$ by $\sqrt2$, and has cost a cycle.

**No finding: the block does not state which normalisations it runs in.** It quotes none of them. Every constant above is recoverable from [conventions.md](../findings/conventions.md), so this is an omission of citation rather than of content, but the record's own $S_{\mathfrak{mmm}}=280$ thread shows the omission has already cost something once.

## 3. Pre-registered question 2, is the cap right, and is its equality case what the block says?

The question asks for the two inequalities separately, for the coincidence of the two equality cases, and for the characterisation of the locus. I take them in that order.

### 3.1 The first inequality, $r\le n(n-2)/4$, C6

$S_{\mathfrak{mmm}}=\sum_{a,b,c\in\mathfrak m}\langle[\varphi_a,\varphi_b],\varphi_c\rangle^2$ is a sum of squares of real numbers, so $S_{\mathfrak{mmm}}\ge0$ with no hypothesis at all. With $N-r>0$ by H3, C5 gives $2(n-2)\ge 4(n-1)r/N$, and

$$r\le\frac{2(n-2)N}{4(n-1)}=\frac{(n-2)}{2(n-1)}\cdot\frac{n(n-1)}2=\frac{n(n-2)}4 .$$

**C6 confirmed.** The block's one-sentence proof ("That quantity is a sum of squares, so it is non-negative, which is the cap"), is exactly this, and it is complete.

### 3.2 The second inequality, $\theta\le\theta_0(n)$, C7

**This one does not follow from C6 without a monotonicity step, and the step is not in the proof.** The block writes only "at $r=n(n-2)/4$ one has $N-r=n^2/4$ and the closed form evaluates to $\sqrt{2(n-1)(n-2)}/n=\theta_0(n)$", an evaluation at one point, which bounds nothing on its own. What is needed is that $r\mapsto\theta$ is increasing.

**The two halves that are written are both right.** At $r=n(n-2)/4$,

$$N-r=\frac{n(n-1)}2-\frac{n(n-2)}4=\frac{2n(n-1)-n(n-2)}4=\frac{n\big(2n-2-n+2\big)}4=\frac{n^2}4,$$

and then

$$\theta^2=\frac4{n^2}\cdot\frac{rN}{N-r}=\frac4{n^2}\cdot\frac{\tfrac{n(n-2)}4\cdot\tfrac{n(n-1)}2}{\tfrac{n^2}4}=\frac4{n^2}\cdot\frac{(n-1)(n-2)}2=\frac{2(n-1)(n-2)}{n^2}=\theta_0(n)^2 .$$

**The missing half is one line**: $\theta^2=\tfrac4{n^2}\cdot\tfrac{N}{N/r-1}$ is strictly increasing in $r$ on $(0,N)$ because $r\mapsto r/(N-r)$ is. *I record this as an omission and not as a repair: the step is not mine to supply into the block, and it is on the record twice already, at [ungraded-slack.md](../findings/ungraded-slack.md):115, "At fixed $n$, $\theta$ increases with $r$", and proved in Lean at [lean/INDEX.md](../lean/INDEX.md):151, where $\theta^2$ is "proved **strictly increasing in $r$**".* **C7 confirmed as a statement, with its proof one step short at the site.**

*A quantifier the block's own file flags and the block does not restate:* the monotonicity is **in $r$ at fixed $n$**, and across dimensions the family reverses it, $r=8$ at $n=8$ gives $\sqrt{7/10}$ against $r=21$ at $n=14$ giving $0.746\ldots$. Both numbers are checked exactly at §5.

### 3.3 Do the two equality cases coincide?, C8

Yes, and for a reason simpler than the block's phrasing suggests. Both are equivalent to the same equation on $r$:

- $S_{\mathfrak{mmm}}=0\iff 2(n-2)=4(n-1)r/N\iff r=n(n-2)/4$, by C5 with $N-r>0$;
- $\theta=\theta_0(n)\iff r=n(n-2)/4$, by the strict monotonicity of §3.2 together with §3.2's evaluation.

So the three statements *$r$ attains the cap*, *$\theta$ attains $\theta_0(n)$*, and *$S_{\mathfrak{mmm}}=0$* are one condition in three costumes. **C8 confirmed.** The block's "equality in either place exactly when $S_{\mathfrak{mmm}}=0$" is right, and note that the $\theta$ half of it inherits the unwritten monotonicity step of §3.2, the forward direction $\theta=\theta_0\Rightarrow r=\text{cap}$ needs *strict* monotonicity, not merely monotonicity.

### 3.4 The characterisation of the locus, C9

Three arrows, and I check each.

1. **$S_{\mathfrak{mmm}}=0\iff[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$.** A sum of squares vanishes iff every term does, so $S_{\mathfrak{mmm}}=0$ iff $\langle[\varphi_a,\varphi_b],\varphi_c\rangle=0$ for all $a,b,c\in\mathfrak m$, iff $\Pi_{\mathfrak m}[\mathfrak m,\mathfrak m]=0$, iff $[\mathfrak m,\mathfrak m]\subseteq\mathfrak m^\perp=\mathfrak h$ by H2. **Confirmed**, and this arrow is the one that is a definition unwound.
2. **$[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$.** For $h,h'\in\mathfrak h$ and $m\in\mathfrak m$, ad-invariance of the pairing gives $\langle[h,m],h'\rangle=-\langle m,[h,h']\rangle=0$ since $[h,h']\in\mathfrak h$ by H1 and $m\perp\mathfrak h$ by H2. **Confirmed**, and this is the block's own argument verbatim.
3. **The three inclusions $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$, $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$, $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$ are exactly a $\mathbb Z_2$-grading of $\mathfrak{so}(n)$ with even part $\mathfrak h$**, hence exactly the statement that $(\mathfrak{so}(n),\mathfrak h)$ is a symmetric pair. **Confirmed.**

**A mislabelling, and it is only that.** The block writes: "**The one arrow needing an argument is $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$**: the others are definitions, and this one uses $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$, which holds because $\mathfrak h$ is a subalgebra and the form is invariant." **The attribution is inverted.** Arrow 1 is the one that unwinds a definition; the arrow that needs the argument the block then supplies is arrow 3, the symmetric-pair conclusion, which is the only one that consumes $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$. Arrow 1 does not use it. *Both arrows hold and the supplied argument is correct and correctly placed for the arrow that needs it, so this changes no conclusion, it misnames which step the argument discharges.* **C9 confirmed with that note.**

**One reading of the Statement that a consumer could take and that is false without H6.** Read as a biconditional about subalgebras ("$(\mathfrak{so}(n),\mathfrak h)$ a symmetric pair $\iff$ $r=n(n-2)/4$"), it fails at a named object on the record's own page: $\mathfrak{so}(5)\oplus\mathfrak{so}(7)\subset\mathfrak{so}(12)$ is a symmetric pair with $r=\binom52+\binom72=10+21=31$ against the cap $12\cdot10/4=30$. **The block itself carries this witness**, at [ungraded-slack.md](../findings/ungraded-slack.md):144, and it carries it as the reason the cap is not a bound on symmetric pairs. So the reading is closed off, *inside the block*. The scope is correct because the Statement's "If $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$, then" governs every clause after it, the equality clause included.

**And that is the general shape of every symmetric pair off the cap.** For $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ with $p+q=n$,

$$r-\frac{n(n-2)}4=\frac{p^2+q^2-n}2-\frac{(p+q)^2-2(p+q)}4=\frac{2(p^2+q^2)-(p+q)^2}4=\frac{(p-q)^2}4 ,$$

so **every unbalanced split exceeds the cap, by exactly $(p-q)^2/4$**, and the block's "$(p-q)^2=0$" is this identity read at zero. At $(p,q)=(5,7)$ the excess is $1$, which is the $31$ against $30$. **The block's proof of the BDI case is confirmed.** For DIII, $\mathfrak u(m)\subset\mathfrak{so}(2m)$ has $r=m^2$ against the cap $\tfrac{2m(2m-2)}4=m(m-1)$, an excess of exactly $m$; so it misses at every $m\ge1$, and the block's "$r=m^2\ne m(m-1)$" is confirmed with the sharper reason.

### 3.5 The odd-$n$ clause, C11

$n$ odd makes $n$ and $n-2$ both odd, so $n(n-2)$ is odd and $n(n-2)/4$ is not an integer. Since $r=\dim\mathfrak h$ is an integer, $r<n(n-2)/4$ strictly, and by §3.2's strict monotonicity $\theta<\theta_0(n)$ strictly. **C11 confirmed.** *Equivalently: at odd $n$ no member of the family is a symmetric pair, so $S_{\mathfrak{mmm}}>0$ at every member.* Note that $\theta_0(n)$ is not $\Theta_n$ at odd $n$, [conventions.md](../findings/conventions.md) fixes $\Theta_n=\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ there, so the odd clause bounds against $\theta_0$ and says nothing about the diagonal maximum. The block does not claim otherwise.

## 4. The even-$n$ equality case, C10, and the sign of the multiple, C13

### 4.1 What the clause needs, and what the block gives it

The clause is: "For $n$ even the equality case is $\mathfrak h=\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ alone." By §3.4 the equality case is *a symmetric pair of $\mathfrak{so}(n)$ whose even part has dimension $n(n-2)/4$*, so the clause is an enumeration statement: **no other symmetric subalgebra of $\mathfrak{so}(n)$ has that dimension.** The block discharges it by checking two families, BDI and DIII, and I confirmed both arithmetic checks at §3.4. **What neither check supplies is that BDI and DIII are the whole list.** That is Cartan's classification.

**It is not read.** [conventions.md](../findings/conventions.md) states it in its own table: "**Cartan's classification**, invoked in four findings files and **cited to no source anywhere on the record**; [references/](../references/) holds no Helgason or Cartan entry." I checked [references/INDEX.md](../references/INDEX.md) and the folder listing: there is no Helgason, no Cartan, and nothing else carrying the classification of involutions of the compact classical algebras. [LEDGER.md](../findings/LEDGER.md):1284 records that acquiring one is blocked on the user, and that creating a notes folder without the source would assert a provenance that does not exist.

**So C10 rests on an unread source at every even $n$, not only at $n=8$.** *This does not touch C4 through C9 and C11*, those need no classification, and [LEDGER.md](../findings/LEDGER.md):1276 makes the same separation from the other side, calling the Cartan dependency "localise[d] … to one clause of the conclusion".

### 4.2 The $n=8$ clause, and the discrepancy

**Locate it exactly.** [ungraded-slack.md](../findings/ungraded-slack.md):134:

> **at $n=8$ by a separate check, since [trap W2](../findings/INDEX-traps.md) records that triality puts $\mathfrak{spin}(7)$ and $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$ outside the usual enumeration, and their dimensions $21$ and $13$ both exceed the cap $12$**

and the canonical copy at [results.md](../results.md):403:

> where triality's two extra $\mathbb Z_2$-gradings have dimensions $21$ and $13$ against the cap $12$

**Exhibit the failure concretely.** The inference offered is *this dimension does not occur among the extra classes, so the class at this dimension is unique*. **At $n=8$ that inference is invalid at a dimension the record itself names.** Dimension $13$ carries **two** $O(8)$-classes: $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$, reducible on $\mathbb R^8$, and $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$, which [graded-half.md](../findings/graded-half.md):412 records as acting **irreducibly**, so no element of $O(8)$ carries one to the other. [LEDGER.md](../findings/LEDGER.md):1268 states the consequence in the record's own words: "**Dimension cannot decide it, and the record holds the witness** … **two $O(8)$-classes at one fixed-point dimension.**" So a dimension count is precisely the move the record has already certified as insufficient at $n=8$, and both L23 sites make it.

**The completing argument exists and is at neither site.** [LEDGER.md](../findings/LEDGER.md):1272 gives it twice over: $\mathrm{Ad}(\mathrm{diag}(-1_4,1_4))$ has determinant $+1$, hence is **inner**, so Cartan up to $\mathrm{Aut}$ already delivers $SO(8)$-conjugacy ("**which is why dimension $12$ is safe and $13$ is not**") and independently, $\mathrm{diag}(I_4,-I_4)$ has weight pattern $(1^4,(-1)^4)$ on $V$, $S^+$ and $S^-$ alike, so its triality image is $SO(8)$-conjugate to itself. The same argument is written into [results.md](../results.md):589, inside **[Lemma L71](../findings/bounds.md)**. **Neither L23 site cites either.**

**Argue the opposite, the most charitable reading the words support.** The [ungraded-slack.md](../findings/ungraded-slack.md) sentence does not stand alone: it says "since [trap W2](../findings/INDEX-traps.md) **records** that triality puts $\mathfrak{spin}(7)$ and $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$ outside the usual enumeration". [trap W2](../findings/INDEX-traps.md) and its source table at [graded-half.md](../findings/graded-half.md):404–411 assert that the $n=8$ row is short by **exactly** two, and the completed table has $\dim12$ occurring once. Importing that exactness, the dimension count *is* sufficient, and the clause is correct. **Under this reading the conclusion holds and what fails is the warrant's self-containment.** I therefore do not call C10's conclusion false. Two things survive the charitable reading:

- **the [results.md](../results.md) copy cites nothing.** It says "triality's two extra $\mathbb Z_2$-gradings have dimensions $21$ and $13$ against the cap $12$" with no pointer to [trap W2](../findings/INDEX-traps.md), to [graded-half.md](../findings/graded-half.md), or to L71. A consumer reading the canonical statement alone gets a dimension count with no completeness import at all, in the one dimension where the record has proved a dimension count does not decide. **This is the round's named trap landing: the correction sits beside the statement it corrects, in a different file, and the citation inherits the defect.**
- **the exactly-two claim is itself Cartan's**, so the charitable reading relocates the debt of §4.1 rather than discharging it.

**Name what would break it.** The object that would falsify C10 is a symmetric subalgebra $\mathfrak h\subset\mathfrak{so}(n)$, $n$ even, with $\dim\mathfrak h=n(n-2)/4$ and $\mathfrak h$ not $O(n)$-conjugate to $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$, most plausibly a triality image at $n=8$, since that is the only $n\ge5$ with $\mathrm{Aut}(\mathfrak{so}(n))\supsetneq PO(n)$. **What I did to look for it.** I checked the record's complete $n=8$ enumeration at [graded-half.md](../findings/graded-half.md):408–411 for a second entry at dimension $12$ and found none; I checked whether the balanced involution is triality-stable and found the argument, at [LEDGER.md](../findings/LEDGER.md):1272 and [results.md](../results.md):589, on determinant and on weights, agreeing; and I checked the four BDI dimensions at $n=8$ by hand ($\binom12+\binom72=21$, $\binom22+\binom62=16$, $\binom32+\binom52=13$, $\binom42+\binom42=12$), against $\dim\mathfrak u(4)=16$, confirming that $12$ occurs once in the uncompleted list and that the two dimensions the completion adds are $21$ and $13$. **I found no falsifier, and I did not construct one, because a triality image is a computation this brief does not permit and does not need: the record's own two arguments settle it and L23 cites neither.**

### 4.3 "The unit-norm multiple", C13

**Locate it exactly.** The Statement, at both sites: "let $W_{\mathfrak h}$ be **the** unit-norm multiple of $\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$".

**Exhibit the failure concretely.** A multiple of $X$ is $cX$; the unit-norm ones are $c=\pm1/\lVert X\rVert$, so the definite article names two objects. $Q$ is quadratic, so $Q(-W)=Q(W)$: if $Q(W)=\theta W$ then $Q(-W)=-\theta\,(-W)$, and $-W$ satisfies the Statement's hypothesis with eigenvalue $-\theta$. At $\mathfrak h=\mathfrak{so}(3)\oplus\mathfrak{so}(3)\subset\mathfrak{so}(6)$ (a named object on this record, the Weyl operator of $S^3\times S^3$), the negative multiple satisfies $Q(W)=\theta W$ with $\theta=-\tfrac13\sqrt{10}$, while the Statement's display asserts $\theta=+\tfrac13\sqrt{10}$. **The Statement is false at that object under one of the two readings its own words permit.**

**Argue the opposite.** The Proof's first sentence fixes the sign ("Write $u=c(1-r/N)>0$ and $v=-cr/N<0$ for the two eigenvalues") so the intended object is unambiguous to a reader of the proof, and the record's normalisation habit points the same way ([conventions.md](../findings/conventions.md) instructs "Normalise $W$ to $\theta>0$ before measuring $S$", for a different purpose but in the same direction). **So the mathematics is untouched and the defect is confined to the Statement.** It survives all three steps because the Statement is the citable object and the fix does not appear in it: the repair is one clause, *the positive multiple*, or equivalently *with $\theta>0$*, and it belongs in the Statement's hypothesis list rather than in the proof's first line. **C13 stands as a defect of the citable form.**

## 5. A universal claim with no witness, one subalgebra from each structured family, and every edge of the range

The Statement is a conditional, so a falsifier is a subalgebra with $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$ whose $\theta$ misses the closed form, or whose $r$ exceeds the cap. **I found none.** What follows is the exact arithmetic, family by family; every entry is a rational or a surd computed by hand, and the decimals are quoted only to compare against the record's own catalogued figures.

### 5.1 The closed form against catalogued values, six exact agreements

| $\mathfrak h\subset\mathfrak{so}(n)$ | $n$ | $r$ | $N$ | $N-r$ | $\theta^2$ from the closed form | the record's value |
| --- | --- | --- | --- | --- | --- | --- |
| $\mathfrak{so}(2)\oplus\mathfrak{so}(2)$ | $4$ | $2$ | $6$ | $4$ | $\tfrac4{16}\cdot\tfrac{12}4=\tfrac34$ | $\Theta_4=0.866\ldots=\tfrac{\sqrt3}2$, [conventions.md](../findings/conventions.md) |
| $\mathfrak{so}(3)\oplus\mathfrak{so}(3)$ | $6$ | $6$ | $15$ | $9$ | $\tfrac4{36}\cdot\tfrac{90}9=\tfrac{10}9$ | $\theta_0(6)=1.054092553$, and $\tfrac{10}9$ exactly at [lean/INDEX.md](../lean/INDEX.md):125 |
| $\mathfrak{so}(4)\oplus\mathfrak{so}(4)$ | $8$ | $12$ | $28$ | $16$ | $\tfrac4{64}\cdot\tfrac{336}{16}=\tfrac{21}{16}$ | $\theta_0(8)^2=\tfrac{21}{16}$, [algebra.md](../findings/algebra.md) |
| $\mathrm{ad}(\mathfrak{su}(3))$ | $8$ | $8$ | $28$ | $20$ | $\tfrac4{64}\cdot\tfrac{224}{20}=\tfrac7{10}$ | $\sqrt{7/10}=0.836660$, [ungraded-slack.md](../findings/ungraded-slack.md):119 |
| $\mathfrak{sp}(3)$, the $SU(6)/Sp(3)$ isotropy | $14$ | $21$ | $91$ | $70$ | $\tfrac4{196}\cdot\tfrac{1911}{70}=\tfrac{39}{70}$ | $0.7464$, [ungraded-slack.md](../findings/ungraded-slack.md):109; $\sqrt{39/70}=0.7464204$ |
| $\mathfrak{spin}(9)$ | $16$ | $36$ | $120$ | $84$ | $\tfrac4{256}\cdot\tfrac{4320}{84}=\tfrac{45}{56}$ | $\tfrac34\sqrt{10/7}$, [ungraded-slack.md](../findings/ungraded-slack.md):121; $(\tfrac34)^2\tfrac{10}7=\tfrac{90}{112}=\tfrac{45}{56}$ |

**Two ratios the block prints, both exact.** $\mathfrak{so}(3)\subset\mathfrak{so}(5)$ principal has $r=3$, $N=10$, $\theta^2=\tfrac4{25}\cdot\tfrac{30}7=\tfrac{24}{35}$ against $\theta_0(5)^2=\tfrac{24}{25}$, so $\theta/\theta_0=\sqrt{5/7}=0.8451543$, the block's leading ratio $0.845$. The maximal torus at $n=8$ has $r=4$, $\theta^2=\tfrac4{64}\cdot\tfrac{112}{24}=\tfrac7{24}$, so $\theta/\theta_0=\sqrt{\tfrac{7/24}{21/16}}=\sqrt{2/9}=\tfrac{\sqrt2}3=0.4714045$, the trailing $0.471$ of the longer list at [ungraded-slack.md](../findings/ungraded-slack.md):101. **Both ends of the printed ratio list reproduce exactly.**

**And the one $S_{\mathfrak{mmm}}$ figure the record prints reproduces.** [plan-verification.md](../plan-verification.md):403 records $S_{\mathfrak{mmm}}=280$ at $\mathfrak{so}(5)\subset\mathfrak{so}(10)$, the adjoint embedding, $r=10$, $N=45$. C5 gives $35\big[2\cdot8-\tfrac{4\cdot9\cdot10}{45}\big]=35[16-8]=280$. **Exact**, in the ordered reading, which is [conventions.md](../findings/conventions.md)'s. *That thread is open in [plan-verification.md](../plan-verification.md) as a possible ordered-versus-unordered collision against a figure in [nondegeneracy.md](../findings/nondegeneracy.md); this check settles L23's side of it and leaves the other side untouched, since I did not read that figure's derivation.*

### 5.2 The structured families the brief names

| family | $r$ | cap $n(n-2)/4$ | what L23 asserts | check |
| --- | --- | --- | --- | --- |
| $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$, $p+q=n$ | $\binom p2+\binom q2$ |, | excess is exactly $(p-q)^2/4$, so **only the balanced split can be a member** | **no falsifier.** $\mathfrak{so}(3)\oplus\mathfrak{so}(5)\subset\mathfrak{so}(8)$ has $r=13>12$, so L23 says $W_{\mathfrak h}$ is not a $Q$-eigenvector, and [ungraded-slack.md](../findings/ungraded-slack.md):103 independently records it with $\lVert\mathrm{Ric}\rVert\approx1$, so it is not even a Weyl operator. **The two statements agree** |
| maximal torus, $n$ even | $n/2$ | $n(n-2)/4$ | a member is possible, and $n/2\le n(n-2)/4\iff n\ge4$ | **no falsifier**, and the family's own equations pin it: for **abelian** $\mathfrak h$, $S_{\mathfrak{hhh}}=0$, so C2 gives $S_{\mathfrak{hmm}}=\kappa r$, and C3's $S_{\mathfrak{hmm}}=2\sigma r(N-r)/N$ forces $(n-2)N=(n-1)(N-r)$, i.e. $r=N/(n-1)=n/2$. **Criticality forces the torus dimension exactly** |
| $\mathfrak{su}(m)\subset\mathfrak{so}(2m)$ | $m^2-1$ | $m(m-1)$ | excess $m-1$, so **no member at any $m\ge2$** | **no falsifier.** At $m=3$: $r=8$ against cap $6$ at $n=6$ |
| $\mathfrak u(m)\subset\mathfrak{so}(2m)$ | $m^2$ | $m(m-1)$ | excess $m$, so **no member at any $m\ge1$** | **no falsifier**, and the apparent one is resolved on the record: [Lemma L28](../findings/nondegeneracy.md) gives $\dim\mathcal W_{2m}^{U(m)}=1$ and a critical point, but [ungraded-slack.md](../findings/ungraded-slack.md):113 records that $U(3)$ at $n=6$ has **three** eigenvalues, so that critical point is not $W_{\mathfrak u(m)}$, which has two. **The two-eigenvalue property is what separates them** |
| $\mathfrak g_2\subset\mathfrak{so}(7)$ | $14$ | $35/4$ | **no member** | **no falsifier**, and C5 refutes it without appeal to the cap: $S_{\mathfrak{mmm}}$ would be $7[10-\tfrac{4\cdot6\cdot14}{21}]=7[10-16]=-42<0$, impossible for a sum of squares |
| $\mathfrak{spin}(7)\subset\mathfrak{so}(8)$ | $21$ | $12$ | **no member** | **no falsifier.** $S_{\mathfrak{mmm}}$ would be $7[12-21]=-63<0$ |
| $\mathfrak{sp}(m)\oplus\mathfrak{sp}(1)\subset\mathfrak{so}(4m)$ | $2m^2+m+3$ | $4m^2-2m$ | exceeds the cap exactly for $m\le2$, since $2m^2-3m-3>0\iff m>\tfrac{3+\sqrt{33}}4=2.186\ldots$ | **no falsifier, and it is not excluded by the cap at $m\ge3$.** At $m=3$, $r=24$ against cap $30$ at $n=12$, and the closed form would give $\theta^2=\tfrac4{144}\cdot\tfrac{24\cdot66}{42}=\tfrac{22}{21}$, i.e. $\theta=1.0235\ldots$, comfortably below $\theta_0(12)^2=\tfrac{55}{36}$. **So this Berger entry threatens nothing even if it were a member**, see C15 |

*The last row is where the block's "$m\le2$" is exactly right and where its neighbours are not; that is C14, at §6.3.*

### 5.3 Every edge of the range

- **$r\to0$.** Excluded by H3, and rightly: at $r=0$, $W_{\mathfrak h}=0$ and there is no unit multiple. For a nonzero subalgebra $r\ge1$, and $r=1$ forces $\mathfrak h$ abelian, hence $r=n/2$ by §5.2, hence $n=2$, where $N=1$ and H3 fails. **So no member has $r=1$ at any $n\ge3$**, which is consistent with the cap: $n(n-2)/4\ge1\iff n\ge2+\sqrt2$, so the cap alone admits $r=1$ from $n=4$ and it is the abelian relation that closes it.
- **$r\to N$.** Excluded by H3; $r=N$ gives $W_{\mathfrak h}=0$ and $v=0$, killing the division in §2.4. The cap makes the point moot ($n(n-2)/4<N=n(n-1)/2$ at every $n\ge1$) so no member comes near.
- **Smallest admissible $n$.** H3 needs $N\ge2$, so $n\ge3$. **At $n=3$ there is no member**: the cap is $3/4<1$. **At $n=4$ there is exactly one candidate dimension**, $r=2$, the cap; the subalgebra realising it is the maximal torus $\mathfrak{so}(2)\oplus\mathfrak{so}(2)$, which is also the balanced split, and $\theta^2=\tfrac34$ as tabled above. **So C10's "for $n$ even the equality case is the balanced split" is consistent down to $n=4$**, where it coincides with the abelian relation of §5.2, two independent constraints picking the same object. *This is the one place the derivation's edge behaviour is genuinely informative rather than merely admissible.*
- **Odd $n$.** §3.5. At $n=5$ the cap is $15/4$, so $r\le3$; $\mathfrak{so}(3)\subset\mathfrak{so}(5)$ at $r=3$ sits at $\sqrt{5/7}\,\theta_0(5)$, strictly under, as C11 requires.
- **$\mathfrak h$ abelian.** Handled in full at §5.2: **criticality forces $r=n/2$**, so no abelian member exists at odd $n$ at all, and at even $n$ the only candidate is a maximal torus. The block does not state this and does not need to; it is a consequence of the block's own C2 and C3, and it is the sharpest test of them I could run without computation. *At $n=4$ it returns $r=2=$ the cap, so the $n=4$ torus is simultaneously abelian and an equality case, $S_{\mathfrak{mmm}}=(N-r)\cdot2(n-4)=0$ there, from C5 at $r=n/2$, which is $\ge0$ exactly when $n\ge4$.*

**Name what would break the closed form.** A subalgebra $\mathfrak h$ with $0<r<N$, $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$ and $\theta\ne\tfrac2n\sqrt{rN/(N-r)}$. **What I did to look for it.** I checked the closed form against every catalogued family value on the record that names an $(n,r)$, the six of §5.1, and against the two printed ratios and the one printed $S_{\mathfrak{mmm}}$; all nine agree exactly. I checked the seven structured families of §5.2 for a member above the cap and found that in each case the block's prediction is corroborated by an independent record entry ($\lVert\mathrm{Ric}\rVert\approx1$ for the unbalanced split; three eigenvalues for $U(m)$; the $\Lambda^4$ invariant for $\mathfrak g_2$ and $\mathfrak{spin}(7)$). **No falsifier exists on the record, and the derivation of §2 shows none can exist, since the elimination is forced.**

## 6. Pre-registered question 3, what does the family require of $\mathfrak h$?

The inventory of §1 answers the question for the Statement. This section answers it for the two paragraphs the block adds around the Statement, since those are what a reader consults to decide whether a given $\mathfrak h$ is a member.

### 6.1 The *Producing members* criterion, C12

The criterion, at [ungraded-slack.md](../findings/ungraded-slack.md):138, is that with $K=N_{O(n)}(\mathfrak h)$ it suffices that **(F1)** $\mathfrak h$ and $\mathfrak m$ be $K$-irreducible and inequivalent as $K$-modules, **(F2)** $(\mathrm{Sym}^2\mathbb R^n)^K=\mathbb R\,\mathrm{Id}$, and **(F3)** $(\Lambda^4\mathbb R^n)^K=0$.

**It is correct, and every step checks.**

- $\mathfrak h$ is $K$-invariant by the definition of the normaliser, and $\mathfrak m=\mathfrak h^\perp$ is $K$-invariant because $K$ acts orthogonally. So the splitting is a $K$-module decomposition.
- **(F1) gives one traceless invariant direction.** Real Schur allows $\mathrm{End}_K$ of an irreducible real module to be $\mathbb R$, $\mathbb C$ or $\mathbb H$; in every case the **symmetric** invariant endomorphisms are $\mathbb R\,\mathrm{Id}$, since the extra generators of $\mathbb C$ and $\mathbb H$ are skew. Inequivalence kills the off-diagonal blocks. So the $K$-invariant symmetric operators on $\Lambda^2$ are exactly $\mathbb R\Pi_{\mathfrak h}\oplus\mathbb R\Pi_{\mathfrak m}$, a plane whose traceless line is $\mathbb R W_{\mathfrak h}$. **The inequivalence clause is genuinely load-bearing**, exactly as the blockquote at [ungraded-slack.md](../findings/ungraded-slack.md):140 says, and that blockquote's own consistency argument checks: $\mathfrak h\cong\mathfrak m$ forces $r=N/2=n(n-1)/4$, which exceeds the cap $n(n-2)/4$ by $n/4>0$, so the criterion without it would contradict the Statement above it.
- **(F2) gives Ricci-flatness**, in two steps rather than the one the block writes. $\mathrm{Ric}(W_{\mathfrak h})$ is a $K$-invariant symmetric matrix, so (F2) makes it a multiple of $\mathrm{Id}$; the multiple is $\operatorname{scal}/n=2\operatorname{tr}_{\Lambda^2}(W_{\mathfrak h})/n=0$ by tracelessness. **The second step is not written, and it is needed**, (F2) alone gives Einstein, not Ricci-flat.
- **(F3) gives first Bianchi**, since $\mathrm{Alt}(W_{\mathfrak h})$ lies in $(\Lambda^4\mathbb R^n)^K$ by equivariance of $\mathrm{Alt}$.
- **The conclusion.** $W_{\mathfrak h}\in\mathcal W_n$, and $Q(W_{\mathfrak h})$ is again $K$-invariant and again in $\mathcal W_n$; $\mathcal W_n^K$ sits inside the invariant plane and misses $\mathrm{Id}$, which is not Ricci-flat, so $\mathcal W_n^K=\mathbb R W_{\mathfrak h}$ and $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$.

**Two imports the criterion uses and does not name**, both of which [Lemma L4](../findings/ungraded-slack.md):107 names for its own version of the same argument: **$O(n)$-equivariance of $Q$**, and **$Q(\mathcal W_n)\subseteq\mathcal W_n$**. The second is sourced: [problem.md](../findings/problem.md):53 derives it from [Böhm–Wilking](../references/boehm-wilking-2008-space-forms/notes.md) equation (6), which **is** in [references/](../references/), together with $\Phi$ preserving first Bianchi, and [problem.md](../findings/problem.md):70 records that second half as an unnamed standard fact. *So the chain bottoms out in a read source plus one standard fact the record flags as unnamed; that is better than L23's Cartan dependency and worth distinguishing from it.* **C12 confirmed, with the trace step and the two imports written in.**

### 6.2 What the criterion demands that the Statement does not

**The Statement requires nothing of $\mathfrak m$ and nothing of $\mathfrak h$ beyond being a subalgebra with $0<r<N$.** The criterion requires $K$-irreducibility of both, inequivalence, and two invariant-theoretic vanishings. **These are hypotheses of a sufficient condition for membership, not of the lemma**, and the block keeps them in a separate paragraph, which is right. The one place the record has been caught confusing the two is recorded at [plan-verification.md](../plan-verification.md):483: (F2) **fails for every unbalanced $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$**, and a consumer that read the criterion's hypotheses as the family's would have concluded those splits are members. *The sentence recording that is in [ungraded-slack.md](../findings/ungraded-slack.md) because the L23 audit put it there, which is the correct location for it.*

### 6.3 The cap-exceeding list, C14

**Locate it exactly.** [ungraded-slack.md](../findings/ungraded-slack.md):142:

> The subalgebras that exceed the cap are $\mathfrak g_2\subset\mathfrak{so}(7)$ at $r=14$ against $8.75$, $\mathfrak{spin}(7)\subset\mathfrak{so}(8)$ at $r=21$ against $12$, $\mathfrak{so}(n-1)\subset\mathfrak{so}(n)$, and $\mathfrak u(m)$, $\mathfrak{su}(m)$, $\mathfrak{sp}(m)\oplus\mathfrak{sp}(1)$ at $m\le2$, together with the unbalanced splits.

**Exhibit the failure concretely.** Read distributively (the qualifier "$m\le2$" governing all three of the algebras it follows), the sentence says that $\mathfrak u(m)$ and $\mathfrak{su}(m)$ do **not** exceed the cap for $m\ge3$. Both are false, at named objects: $\mathfrak u(3)\subset\mathfrak{so}(6)$ has $r=9$ against the cap $6$, and $\mathfrak{su}(3)\subset\mathfrak{so}(6)$ has $r=8$ against the cap $6$. In general the excesses are exactly $m$ for $\mathfrak u(m)$ and $m-1$ for $\mathfrak{su}(m)$, so they exceed at every $m\ge1$ and every $m\ge2$ respectively. **The block contradicts itself two paragraphs later**: [ungraded-slack.md](../findings/ungraded-slack.md):144 says "$\mathfrak u(m)$, at $r=m^2$ against $m(m-1)$, **never** enters the family", with no restriction on $m$, and [ATTEMPTS.md](../ATTEMPTS.md):2601 names the two pinching excesses as "$(p-q)^2/4$ and $m$", the $m$ being $\mathfrak u(m)$'s, at every $m$.

**Argue the opposite.** The qualifier can be read as attaching to $\mathfrak{sp}(m)\oplus\mathfrak{sp}(1)$ alone, and under that reading the sentence is **true and sharp**: $2m^2+m+3>4m^2-2m\iff 2m^2-3m-3<0\iff m<\tfrac{3+\sqrt{33}}4=2.186\ldots$, so the exceedance holds at $m\le2$ and fails from $m=3$, where $r=24$ against the cap $30$ at $n=12$. **That is certainly the intended reading**, since it is the only one under which the qualifier does any work. **The defect is therefore of the citable form and not of the mathematics**, and it survives the three steps because the plain English reading is the false one and the block's own next paragraph is what refutes it. *The fix is punctuation: put $\mathfrak{sp}(m)\oplus\mathfrak{sp}(1)$ at $m\le2$ last, or repeat the qualifier.* **C14 stands.**

**Two entries of the list I confirmed while there.** $\mathfrak{so}(n-1)\subset\mathfrak{so}(n)$ has $r=\tfrac{(n-1)(n-2)}2$ against $\tfrac{n(n-2)}4$, exceeding iff $2(n-1)>n$, i.e. at every $n\ge3$. The unbalanced splits exceed by exactly $(p-q)^2/4$, as at §3.4.

### 6.4 "Only $\mathfrak g_2$ and $\mathfrak{spin}(7)$ are excluded by the $4$-form", C15, **withdrawn**

**The candidate.** [ungraded-slack.md](../findings/ungraded-slack.md):144 claims that of the cap-exceeding list, only $\mathfrak g_2$ and $\mathfrak{spin}(7)$ are excluded by (F3). The Berger entries $\mathfrak{sp}(m)\subset\mathfrak{so}(4m)$ and $\mathfrak{sp}(m)\oplus\mathfrak{sp}(1)\subset\mathfrak{so}(4m)$ at $m\ge3$ are **not** on the cap-exceeding list at all, §5.2 shows both sit below the cap, so under the paragraph's heading, "what the hypotheses exclude is the Berger list", something else must exclude them, and (F3) is the natural candidate, since both carry invariant $4$-forms.

**Why I withdraw it.** The discrepancy protocol requires the failure exhibited at a named object. For $\mathfrak{sp}(m)$ the exclusion is visibly (F1) rather than (F3): $\mathfrak m=\mathfrak{sp}(m)^\perp$ contains the $\mathfrak{sp}(1)$ summand as a proper $K$-submodule, since $K=N_{O(4m)}(\mathfrak{sp}(m))$ contains $Sp(m)Sp(1)$, so $\mathfrak m$ is $K$-reducible and the claim is unthreatened. For $\mathfrak{sp}(m)\oplus\mathfrak{sp}(1)$ at $m\ge3$ **I cannot decide which condition fails without computing the $K$-decomposition of $\mathfrak m$ and the invariants of $\Lambda^4\mathbb R^{4m}$**, and this brief forbids that. So the candidate fails step two and is `withdrawn`.

**What survives as a scope note, not a discrepancy.** The paragraph's heading claims the hypotheses exclude the Berger list; the paragraph itself accounts only for entries that exceed the cap; and $\mathfrak{sp}(m)\oplus\mathfrak{sp}(1)$ at $m\ge3$ is a Berger entry the cap does not reach and no sentence in the block accounts for. **It threatens nothing**: at $m=3$, $n=12$, $r=24$, the closed form would give $\theta^2=\tfrac4{144}\cdot\tfrac{24\cdot66}{42}=\tfrac{22}{21}$ against $\theta_0(12)^2=\tfrac{55}{36}$, so even as a member it would sit well below the cap value. *And the record already places the $\mathbb{HP}^m$ points outside the family, at [ungraded-slack.md](../findings/ungraded-slack.md):150.*

## 7. The forms compared, the gap between what is proven and what is used, and the named trap

### 7.1 Three forms of L23, and what changes between them

| site | what it carries | difference that matters |
| --- | --- | --- |
| [ungraded-slack.md](../findings/ungraded-slack.md):130–136 | Statement and Proof | the working copy. Cites [trap W2](../findings/INDEX-traps.md) for $n=8$; says "$\mathbb Z_2$-graded **in the sense settled elsewhere in this file**" |
| [results.md](../results.md):397–403 | Statement only, proof by pointer | **drops the [trap W2](../findings/INDEX-traps.md) citation** (§4.2); **drops the pointer fixing which sense of "graded"** is meant, where [conventions.md](../findings/conventions.md) records three incomparable senses; **adds** an italic line attributing the $2(n-2)$ to **[Lemma L153](../findings/bounds.md)**, which the working copy does not carry |
| [lean/INDEX.md](../lean/INDEX.md) | **no row states L23** | see §7.3 |

**On the dropped sense of "graded".** In L23 it is recoverable: the equality case is characterised three lines earlier by the bracket inclusions, which is [conventions.md](../findings/conventions.md)'s sense **(C)**, the pair sense. So the canonical copy is not wrong, it is under-specified, and [conventions.md](../findings/conventions.md) records that (C) and (A) are incomparable and that a claim proved in one transfers to the other only where they coincide, "which is the subalgebra family and nowhere guaranteed beyond it". **On this family the two coincide, so nothing breaks here**; what breaks is a consumer carrying the phrase off the family, which is the failure [ATTEMPTS.md](../ATTEMPTS.md):4737 records having already happened once, from this very block.

### 7.2 [Lemma L4](../findings/ungraded-slack.md) advertises this closed form, is what it uses what this block establishes?, C16

**No. L4 states the closed form without the hypothesis that carries it.**

**Locate it exactly.** [ungraded-slack.md](../findings/ungraded-slack.md):111–112:

> **The Casimir family and its closed form.** For a subalgebra $\mathfrak h\subseteq\mathfrak{so}(n)$ with $r=\dim\mathfrak h$, $N=\binom n2$ and $W_{\mathfrak h}$ the unit multiple of $\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$ (two eigenvalues by construction), $\theta=\frac2n\sqrt{\frac{rN}{N-r}}$

and the canonical copy, [results.md](../results.md):116:

> The two-eigenvalue Casimir family it draws on has the closed form $\theta=\tfrac2n\sqrt{rN/(N-r)}$, **derived** at Lemma L23.

**Neither sentence contains "if $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$", and neither contains $0<r<N$.** L23 proves the formula **only** under criticality; $\theta$ itself is defined at [conventions.md](../findings/conventions.md) as $P(W)/\lVert W\rVert^3$ **at every $W$**, so the two readings genuinely differ off the critical locus and the sentence has a false reading available.

**Exhibit the failure concretely, at objects on this record.** $\mathfrak h=\mathfrak{so}(3)\oplus\mathfrak{so}(5)\subset\mathfrak{so}(8)$ is a subalgebra with $0<r<N$; L4's sentence, read as written, gives $\theta^2=\tfrac4{64}\cdot\tfrac{13\cdot28}{15}=\tfrac{91}{60}$, i.e. $\theta=1.2315\ldots$. **The record's own value for that operator is $1.151371$**, at [ungraded-slack.md](../findings/ungraded-slack.md):103, where it is recorded with $\lVert\mathrm{Ric}\rVert\approx1$, not a Weyl operator, not critical, so L23's hypothesis fails and its conclusion does not hold. Second object: $\mathfrak g_2\subset\mathfrak{so}(7)$, where L4's sentence gives $\theta=\tfrac27\sqrt{42}$ while L23's own C5 shows no such critical point exists, $S_{\mathfrak{mmm}}$ coming out at $-42$.

**Argue the opposite.** The paragraph's heading is "**The Casimir family** and its closed form", and L4 is titled "a generator for critical points"; the family is the family of *critical* points indexed by subalgebras, so criticality is carried by the word "family". Under that reading the sentence is true and the hypothesis is contextual rather than absent. **Three things keep the candidate alive anyway.**

- The same file has to say, twenty lines later, that **reading the closed form at an object outside the family is an error**, [ungraded-slack.md](../findings/ungraded-slack.md):119, at padded $SU(3)$, where $(n,r)=(12,8)$ returns $\sqrt{22/87}$ against the true $\sqrt{7/10}$. A sentence whose intended scope had to be repaired downstream at a named object is a sentence whose scope is not on its own page.
- **The record has already made the mistake this reading permits**, twice, in Lean and in prose: [plan-verification.md](../plan-verification.md):939 records "the $S^5\times S^7$ row evaluates the family formula at $r=31$, above the cap $r\le30$ that L23 proves at $n=12$, and which that lemma states of this very subalgebra", graded **holds as an infelicity**; and :950 says the appeal "was invalid anyway".
- The [results.md](../results.md):116 copy has no "family" paragraph around it at all (it is one clause inside a landscape summary) so the contextual reading is unavailable there.

**C16 stands.** The gap between what is proven and what is used is exactly one hypothesis: **L23 proves the value at a critical Casimir; L4 states it at a Casimir.**

### 7.3 Lean, C17

**No row in [lean/INDEX.md](../lean/INDEX.md) states L23.** Three rows touch it and none claims it:

- [lean/INDEX.md](../lean/INDEX.md):62, "$pq$ is the family's complete invariant", uses L23's $N-r$ and identifies it with the orbit dimension $pq$ at a sphere product. **Not L23's claim.**
- [lean/INDEX.md](../lean/INDEX.md):82, "**[L23](../results.md)'s extension**", [L23bound.lean](../lean/HamiltonsCubic/Results/L23bound.lean), **proved**, this formalises the arithmetic of a bound $\theta^2\le\tfrac4{n^2}\tfrac{rN}{N-r}$ with $r=\dim E_+$, evaluated at four catalogued points. I checked its two headline values by hand and both are right: at $S^3\times S^5$, $n=8$, $r=13$, $\tfrac4{64}\cdot\tfrac{364}{15}=\tfrac{91}{60}$; at $S^5\times S^7$, $n=12$, $r=31$, $\tfrac4{144}\cdot\tfrac{31\cdot66}{35}=\tfrac{341}{210}$. **But both are evaluated at $r$ above L23's cap** ($13>12$ and $31>30$) so **this row is not L23 and must not be read as it**; the row is honest about this, saying "**Not claimed**: that $r=\dim E_+$ takes these values".
- [lean/INDEX.md](../lean/INDEX.md):151, [L105](../lean/HamiltonsCubic/Results/L105.lean)'s row, **proves $\theta^2$ strictly increasing in $r$**, which is precisely §3.2's missing step, formalised somewhere other than at L23.

**What a row for L23 would have to claim.** Given $n\ge3$, $0<r<N=\binom n2$, and the four scalars $(\theta,S_{\mathfrak{hhh}},S_{\mathfrak{hmm}},S_{\mathfrak{mmm}})$ satisfying the two block-trace equations of C1 and the two Killing relations of C2 with $u>0$, $v=-ru/(N-r)$ and $ru^2+(N-r)v^2=1$: **then** $\theta^2=\tfrac4{n^2}\tfrac{rN}{N-r}$ and $S_{\mathfrak{mmm}}=(N-r)[2(n-2)-4(n-1)r/N]$, and **the solution of that linear system is unique**. That is §2 in full and needs no Lie theory, the whole content is a $2\times2$ linear solve plus an algebraic identity, so it is squarely in reach of the same technique the rows above use. Adding $S_{\mathfrak{mmm}}\ge0$ as a hypothesis yields $r\le n(n-2)/4$ and, with the :151 monotonicity already proved, $\theta\le\theta_0(n)$ with the equality cases coinciding. **What such a row could not claim** is C9's characterisation, which needs the bracket, and C10, which needs Cartan.

### 7.4 The named trap, reading each citable claim alone

I read the five citable claims as a consumer with only that text in front of them.

| claim read alone | what a consumer gets | is a correction beside it |
| --- | --- | --- |
| the Statement at [results.md](../results.md):397 | the closed forms, the cap, the equality case, **all correct**, with the sign of the multiple undetermined (C13) and the $n=8$ warrant a bare dimension count (C10) | **no.** [trap W2](../findings/INDEX-traps.md) is not cited, and the completing $n=8$ argument is at [results.md](../results.md):589 under **[Lemma L71](../findings/bounds.md)**, one hundred and eighty lines below, with no pointer either way |
| the Statement at [ungraded-slack.md](../findings/ungraded-slack.md):130 | the same, with the [trap W2](../findings/INDEX-traps.md) citation present | **partly.** The citation is there; the argument that dimension does not decide at $n=8$, and why $12$ is nevertheless safe, is at [LEDGER.md](../findings/LEDGER.md):1272 |
| L4's closed form at [results.md](../results.md):116 | **a formula with no hypothesis**, false at two named objects (C16) | **no** |
| L4's closed form at [ungraded-slack.md](../findings/ungraded-slack.md):111 | the same, with the scope repair nine lines below at :119 | **yes, nine lines below, and it repairs a different instance**, padding, not non-criticality |
| the cap-exceeding list at [ungraded-slack.md](../findings/ungraded-slack.md):142 | a false claim about $\mathfrak u(m)$ and $\mathfrak{su}(m)$ under the plain reading (C14) | **yes, two paragraphs below**, where :144 says $\mathfrak u(m)$ never enters the family, so the citation would inherit the defect only if it stopped at :142 |

**The trap lands twice, and both times at [results.md](../results.md)**, the canonical file, which by design carries statements and points elsewhere for proofs, and which is therefore where a stripped statement does the most damage.

### 7.5 What a consumer may cite

**May be cited without qualification**, on the strength of §2 and §3:

- $\theta=\tfrac2n\sqrt{rN/(N-r)}$ and $S_{\mathfrak{mmm}}=(N-r)\big[2(n-2)-\tfrac{4(n-1)r}N\big]$, **for the positive unit multiple $W_{\mathfrak h}$ of $\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$ at a subalgebra $\mathfrak h$ with $0<r<N$ satisfying $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$**, and nowhere else. The criticality hypothesis is the whole of it.
- $r\le n(n-2)/4$ and $\theta\le\theta_0(n)$ under the same hypothesis, with equality in either place iff $S_{\mathfrak{mmm}}=0$ iff $r=n(n-2)/4$.
- $S_{\mathfrak{mmm}}=0\iff[\mathfrak m,\mathfrak m]\subseteq\mathfrak h\iff(\mathfrak{so}(n),\mathfrak h)$ is a symmetric pair, needing no classification.
- the strictness at odd $n$.
- the *Producing members* criterion, with the trace step of §6.1 written in and its two imports named.

**May be cited only with the debt named:** "for $n$ even the equality case is $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ alone". It rests on Cartan's classification, which [references/](../references/) does not hold, and at $n=8$ on the exactly-two claim of [trap W2](../findings/INDEX-traps.md) plus the triality-stability argument of [LEDGER.md](../findings/LEDGER.md):1272, which neither L23 site carries.

**Must not be cited:** the closed form at any $\mathfrak h$ not known to be critical, including every unbalanced $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$, every $\mathfrak u(m)$ and $\mathfrak{su}(m)$, $\mathfrak g_2$, $\mathfrak{spin}(7)$, and every padded object; and the cap-exceeding list of [ungraded-slack.md](../findings/ungraded-slack.md):142 in its distributive reading.

## 8. Verdict

**`PROVEN, hypotheses corrected`.**

The closed forms, the cap, the coincidence of the two equality cases and the characterisation of the equality locus are correct, and I rebuilt each from the definitions: the two trace equations, the two Killing relations, and an elimination whose determinant I computed and found nonzero, so the solution is forced. Six catalogued values, two printed ratios and one printed $S_{\mathfrak{mmm}}$ reproduce exactly by hand, and no falsifier exists among the seven structured families the brief names.

**The corrections the hypothesis list needs**, in the order they cost most:

1. **The Statement must say *positive* unit multiple** (C13). As written it is false at the negative multiple of every member, $\theta$ being $-\tfrac2n\sqrt{rN/(N-r)}$ there.
2. **The even-$n$ uniqueness clause carries an unread-source debt** (C10), and its $n=8$ warrant (a dimension count), is the move [LEDGER.md](../findings/LEDGER.md):1268 certifies as insufficient at exactly that dimension. The completing argument is on the record, at [LEDGER.md](../findings/LEDGER.md):1272 and [results.md](../results.md):589, and at neither L23 site.
3. **$\theta\le\theta_0(n)$ is stated with an evaluation where it needs a monotonicity** (C7). One line, already proved twice elsewhere on the record.
4. **[Lemma L4](../findings/ungraded-slack.md)'s advertisement of the closed form drops criticality** at both of its sites (C16), and the record holds two objects where the two readings disagree.
5. **The cap-exceeding list is false under its plain reading** (C14).
6. **Which arrow needs the argument is misnamed** at C9, and **the Ricci-flatness step of the criterion is one step short** at C12. Neither changes a conclusion.

*Nothing in this report supplies a step to the block. §3.2's monotonicity, §5.2's abelian relation and §6.1's trace step are marked where they are omissions, and each is either already on the record elsewhere or is a test of the block's own equations rather than a repair written into them.*

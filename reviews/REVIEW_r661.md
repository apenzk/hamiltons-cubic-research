# Review r661, Lemma L96, the weighted 2-class scheme

**Reviewer A of a pair on identical briefs. Target: [findings/diagonal-half.md:377](../findings/diagonal-half.md#L377), `#### Lemma L96, the weighted 2-class scheme maximises at $\theta_0(n)$, only at $K_{n/2,n/2}$`. Derived cold from [conventions.md](../findings/conventions.md); the block's own reasoning was read only after the closed form was in hand.**

**Analysis-only footing observed.** One screen was run, the block's own $\theta$ formula evaluated at twelve parameter sets, to check a closed form I had already derived by hand and to confirm witnesses I was about to record. It is reported as a screen; every positive claim below is derived, and each screened number is one a reader can reproduce by hand from the closed form in §2.

---

## Verdict: **REFUTED as stated**, on three counts, with attainment confirmed

| # | claim in the block | verdict |
| --- | --- | --- |
| 1 | the heading, unqualified in $n$ | **REFUTED at odd $n$**, the maximiser does not exist and $\theta_0(n)$ is not the maximum; at $n=9$ the true maximum is $0.769800$ against $\theta_0(9)=1.175889$ |
| 2 | "attained **only** at $(k,\lambda,\mu)=(n/2,0,n/2)$" | **REFUTED**, $(n/2-1,\,n/2-2,\,0)$, the complement $2K_{n/2}$, attains $\theta_0(n)$ at every even $n$ and is fully feasible |
| 3 | "a **superset** of the realisable strongly regular graphs, so the bound holds a fortiori" | **REFUTED**, $(6,3,2,0)$ gives $1.581139$ and $(24,22,21,0)$ gives $6.493587$, both inside the stated superset |
| 4 | $\theta=\theta_0(n)$ at the balanced point, even $n$ | **CONFIRMED**, derived in closed form below |
| 5 | the displayed $\theta$ formula and the two runner-up values | **CONFIRMED** exactly |
| 6 | "maximising … gives exactly $\theta_0(n)$" as a theorem | **GAP**, it is a finite enumeration, $6\le n\le24$, with no script on the record, and [L144](../findings/diagonal-half.md#L509) in the same file records the primitive half as *screened and not proved* |

---

## 1. Parity, taken first, as the brief directs

**$K_{n/2,n/2}$ exists only at even $n$, and the block's heading carries no parity qualifier.** The body is worse than silent: it verifies "at every even $n$ from $6$ to $24$" and then leaves the heading to quantify over all $n$.

At odd $n$ the statement is false twice over, not merely ill-posed:

- **The named maximiser does not exist.** More than that, the whole *near*-balanced substitute is absent from the family: complete bipartite $K_{p,q}$ is regular only when $p=q$, so at odd $n$ the best two-block sphere product $S^{(n-1)/2}\times S^{(n+1)/2}$ is **not a 2-class scheme at all**, its $M$ takes three distinct values ($1/(p(p-1))$, $1/(q(q-1))$, $-1/(pq)$), which is exactly why the same file's scheme table marks the unbalanced $S^4\times S^8$ "not a scheme".
- **$\theta_0(n)$ is not the right constant.** By §2's closed form the imprimitive schemes at $n$ odd are $mK_g$ with $g\mid n$, $1<g<n$, giving $\theta^2=2(n-1)(g-1)/\big(n(n-g)\big)$, increasing in $g$. At odd $n$ the largest proper divisor is at most $n/3$, so
  $$\theta\ \le\ \frac{\sqrt{(n-1)(n-3)}}{n}\qquad(3\mid n),$$
  and at odd $n$ with no divisor $1<g<n$ (every odd **prime** $n$), there is **no imprimitive 2-class scheme whatever**, leaving only the primitive ones, which [L144](../findings/diagonal-half.md#L509) screens below $\tfrac12$. At $n=9$ this gives $\sqrt{48}/9=0.769800$ against $\theta_0(9)=1.175889$: the block's constant overshoots by more than $50\%$.
- **The gap is not marginal even against the right target.** $\big(\sqrt{(n-1)(n-3)}/n\big)^2\big/\Theta_n^2=(n+1)(n-2)/(2n^2)<\tfrac12$, so the odd-$n$ 2-class maximum sits below $\Theta_n/\sqrt2$. The scheme family is *far* from the diagonal maximum at odd $n$, and saying so is content the block does not have.

**This is the same failure mode as the neighbouring result refuted this morning**, an even-$n$ statement carrying $\theta_0(n)$ as though it were parity-free. Under [conventions.md](../findings/conventions.md)'s repaired entry, $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ is the closed form and nothing more, equal to $\Theta_n$ at even $n$ only; L96's heading reads it as the parity-free maximum, which is precisely what regrew [L0](../findings/problem.md)'s refuted constant.

**Required.** The heading must read *at even $n$*, and the odd-$n$ maximum belongs in the body with its own constant.

---

## 2. The maximum, derived cold, and a closed form the block does not have

**Setup, quoted from [conventions.md](../findings/conventions.md) and the head of the file.** $M$ is the $n\times n$ symmetric hollow edge-weight matrix, $M\mathbf1=0$, $\mathop{\mathrm{tr}}M^2=2$ (the ordered-pair sum), and
$$\theta=\tfrac12\Big(\textstyle\sum_{a,b}M_{ab}^3+\mathop{\mathrm{tr}}M^3\Big).$$

**The family.** A weighted 2-class association scheme is $M=\alpha A+\beta(J-I-A)$ with $A$ the adjacency matrix of a strongly regular graph on $n$ vertices with parameters $(k,\lambda,\mu)$. Two hypotheses fix $\alpha,\beta$ up to one sign:

- $M\mathbf1=0$ gives $\alpha k+\beta k'=0$ with $k':=n-1-k$, so $\beta=-\alpha k/k'$;
- $\mathop{\mathrm{tr}}M^2=2$ gives $\alpha^2=\dfrac{2k'}{nk(n-1)}$.

So **the family is discrete, not continuous**: the word *weighted* buys exactly one scalar, and the two constraints spend it. The maximum is an enumeration over $(n,k,\lambda,\mu)$ together with a choice of sign, and needs no variational argument. The block never says this, and the brief was right to ask.

**The spectral side.** On $\mathbf1^\perp$, where $J$ acts as zero, $M=(\alpha-\beta)A-\beta I$, so an $A$-eigenvalue $\rho\in\{r,s\}$ gives $\mu_\rho=\gamma\big((n-1)\rho+k\big)$ with $\gamma:=\alpha/k'$. Writing $X=(n-1)r+k$, $Y=(n-1)s+k$ and using the standard traces $f+g=n-1$, $fr+gs=-k$, $fr^2+gs^2=k(n-k)$:

$$fX+gY=0,\qquad fX^2+gY^2=n(n-1)kk',\qquad fX^3+gY^3=(n-1)fg\,(g-f)\,(r-s)^3 .$$

The middle identity re-derives $\alpha^2$ above, an internal check. The third uses $fX=-gY$, whence $X=g\tau$, $Y=-f\tau$ with $\tau=X-Y=(n-1)(r-s)$ divided by $n-1$, i.e. $\tau=r-s$, and $\tau^2=nkk'/(fg)$.

**The entrywise side.** $\sum_{a,b}M_{ab}^3=nk\alpha^3+nk'\beta^3=n\alpha^3k(n-1)(k'-k)/k'^2$.

**Combining**, and substituting $(r-s)^2=nkk'/(fg)$ to clear $f,g$:
$$2\theta=\frac{\alpha^3(n-1)nk}{k'^2}\Big[(k'-k)+(g-f)(r-s)\Big],\qquad\text{so}\qquad \theta=\gamma\Big[(n-1-2k)+(g-f)(r-s)\Big].$$

**The bracket collapses.** The standard multiplicity formula gives $(g-f)(r-s)=2k+(n-1)(\lambda-\mu)$, so the bracket is $(n-1)(1+\lambda-\mu)$ and

$$\boxed{\ \theta(n,k,\lambda,\mu)=\bigl|1+\lambda-\mu\bigr|\sqrt{\frac{2(n-1)}{n\,k\,(n-1-k)}}\ }$$

on the sign branch making $\theta>0$.

**Three independent confirmations that this is right.**

1. It reproduces the block's own two recorded runner-up values *exactly*, not to nine digits but in closed form: at $(12,8,4,8)=K_{4,4,4}$, $\theta^2=2\cdot11\cdot9/(12\cdot8\cdot3)=11/16$ and $\theta=0.829156$; at $(12,9,6,9)=K_{3,3,3,3}$, $\theta^2=2\cdot11\cdot4/(12\cdot9\cdot2)=11/27$ and $\theta=0.638285$.
2. At $(n/2,0,n/2)$: $|1+0-n/2|=(n-2)/2$ and $kk'=n(n-2)/4$, giving $\theta^2=\frac{(n-2)^2}{4}\cdot\frac{8(n-1)}{n^2(n-2)}=\frac{2(n-1)(n-2)}{n^2}=\theta_0(n)^2$. **Attainment confirmed analytically at every even $n$**, with no enumeration.
3. Splitting the same computation term by term at that point gives $\tfrac12\mathop{\mathrm{tr}}M^3=\sqrt2\,c_n$ and $\tfrac12\sum M_{ab}^3=\dfrac{2\sqrt2}{n\sqrt{(n-1)(n-2)}}$, **exactly the two summands of the file's own $\theta_0$ decomposition** at [diagonal-half.md:55](../findings/diagonal-half.md#L55), reached from the scheme side rather than the sphere-product side.

**And the record already has this formula, 130 lines below the block.** [L144](../findings/diagonal-half.md#L509) prints $\theta(\Gamma)=\lvert1+\lambda-\mu\rvert\sqrt{2(n-1)/(nk(n-1-k))}$ verbatim, and [L74](../findings/diagonal-half.md#L451) gives the equivalent $F$-form. **L96 states as an unanalysed "explicit function of the parameters" what two later blocks in its own file reduce to one line.**

### Does it agree with the sphere-product monotonicity? No, the families barely meet

The brief asks whether L96 restates $\theta_{k,l}^2=2\frac{n-1}{n-2}\big(1-\frac{n-1}{kl}\big)$'s monotonicity in $kl$. **It does not, and the reason is structural.** That formula runs over two-factor products $S^k\times S^l$, $k+l=n$; the corresponding $M$ is a 2-class scheme **only when $k=l$**, because $K_{k,l}$ is regular only when balanced. So the two families intersect in the single point that both maximise, and neither result implies the other:

- the $kl$-monotonicity constrains a family of which all but one member lies **outside** L96's family;
- L96's family contains points (every $(S^c)^m$ with $m\ge3$, and every primitive strongly regular graph) that the $kl$-formula does not describe.

Agreement at the shared point is real and checks both: at $k=l=n/2$, $\theta_{k,l}^2=2\frac{n-1}{n-2}\cdot\frac{(n-2)^2}{n^2}=\theta_0(n)^2$.

---

## 3. "Only at", the rigidity half is **REFUTED**, and the file itself carries the counterexample

**Uniqueness is asserted, never proved.** No inequality is named, no equality case tracked; the word rests entirely on the enumeration's output. And the output is misreported.

**The counterexample.** $\theta$ depends on $(k,\lambda,\mu)$ only through $|1+\lambda-\mu|$ and $kk'$. Complementation sends $(k,\lambda,\mu)\mapsto(k',\,n-2-2k+\mu,\,n-2k+\lambda)$, under which $1+\lambda-\mu\mapsto-(1+\lambda-\mu)$ and $kk'\mapsto kk'$. **So $\theta$ is complement-invariant on the whole family**, and the complement of $K_{n/2,n/2}$ is
$$(k,\lambda,\mu)=\Big(\tfrac n2-1,\ \tfrac n2-2,\ 0\Big)\ =\ 2K_{n/2},$$
for which $|1+\lambda-\mu|=n/2-1$, $kk'=(n/2-1)(n/2)$ and $\theta^2=\dfrac{2(n-1)(n/2-1)}{n(n/2)}=\theta_0(n)^2$, **the same maximum, at every even $n$, at a second and fully feasible parameter set.** Screened at $(6,2,1,0)$ and $(12,5,4,0)$: the block's own displayed formula returns $1.054093$ and $1.236033$, with integral multiplicities $(f,g)=(1,4)$ and $(1,10)$.

**Up to what, then?** The honest statement has three layers, and the block states none of them:

- **up to complementation**, $A\mapsto J-I-A$, which is the identity on the *set of matrices* $\{M\}$, $2K_{n/2}$ and $K_{n/2,n/2}$ carry literally the same $M$, with $\alpha$ and $\beta$ trading roles ($\beta^2=2/((n-1)(n-2))$ in the first reading equals $\alpha^2$ in the second);
- **up to the sign branch** $M\mapsto-M$, under which $\theta\mapsto-\theta$;
- **up to graph isomorphism**, vacuous here because $\theta$ is a function of the parameters alone and $(n/2,0,n/2)$ has $K_{n/2,n/2}$ as its unique realisation.

So the defensible claim is *"attained exactly at the single weighted scheme $M$ whose two parameter presentations are $(n/2,0,n/2)$ and $(n/2-1,n/2-2,0)$"*. **[L74](../findings/diagonal-half.md#L451), below in the same file, gets this exactly right**, "$\mathrm{SRG}(2m,m,0,m)=K_{m,m}$ and $\mathrm{SRG}(2m,m-1,m-2,0)=2K_m$, which are complements of each other and are the two sign branches of one point", reached there by two independent reviewers, [r339](REVIEW_r339.md) and [r340](REVIEW_r340.md). **L96 contradicts L74 on a point L74 audited and got right.**

**The sign branch is a second, independent defect in the word "maximises".** The block's displayed formula carries no absolute value, and $\alpha$ is fixed only up to sign. Taking the positive root, the block's own formula returns $\theta=-\theta_0(n)$ at $K_{n/2,n/2}$ and $+\theta_0(n)$ at $2K_{n/2}$, screened: $-1.054093$ at $(6,3,0,3)$, $+1.054093$ at $(6,2,1,0)$. **Read literally, the block's formula makes its named maximiser the minimiser.** The balanced sphere product's $M$ is positive within blocks and negative across, so the negative graph is $K_{n/2,n/2}$ and the maximiser is the $\alpha<0$ branch, as L74 says and L96 does not.

---

## 4. The "superset ⇒ a fortiori" argument is **false as written**

The block: *"the enumeration runs over parameter sets satisfying integrality and $k(k-\lambda-1)=(n-k-1)\mu$, a **superset** of the realisable strongly regular graphs, so the bound holds a fortiori."*

**Over that set the bound fails, badly.** Take $\mu=0$, $\lambda=k-1$. The identity $k(k-\lambda-1)=k'\mu$ reads $0=0$, so *every* such $(k,k-1,0)$ is in the stated superset, and $|1+\lambda-\mu|=k$ gives
$$\theta=\sqrt{\frac{2k(n-1)}{n\,(n-1-k)}}\ \xrightarrow[k=n-2]{}\ \sqrt{\frac{2(n-1)(n-2)}{n}}\ =\ \sqrt n\;\theta_0(n).$$
**The overshoot is a factor $\sqrt n$, at every $n$ in the block's own range.** Witnesses, screened through the block's own formula: $(6,3,2,0)\to1.581139$ and $(6,4,3,0)\to2.581989$ against $\theta_0(6)=1.054093$; $(24,22,21,0)\to6.493587$ against $\theta_0(24)=1.325498$.

**What actually does the work is multiplicity integrality, which the block never names.** For $(k,k-1,0)$ one gets $r=k$, $s=-1$ and $f=n/(k+1)-1$, so $f\in\mathbb Z_{\ge0}$ forces $(k+1)\mid n$, the disjoint-clique condition. With it, $\theta^2=\frac{2(n-1)(g-1)}{n(n-g)}$ over divisors $g=k+1$ of $n$ is increasing in $g$ and maxes at $g=n/2$, returning $\theta_0(n)$. The screened non-integral $f$ at the three witnesses ($0.50$, $0.20$, $0.04$) is exactly the condition the block's description omits.

So one of two things is true, and both are findings:

- if the enumeration filtered on $f,g\in\mathbb Z_{\ge0}$, then **the stated search space is wrong** and the load-bearing hypothesis is missing from the record;
- if it did not, then **the reported maximum is wrong** and the witnesses above were inside the search.

Either way the sentence as written cannot stand. And the "a fortiori" rhetoric is inverted: enlarging the search space here *breaks* the bound rather than strengthening it.

---

## 5. Status of the maximisation: **GAP**, and the same file says so

Even granting the corrected feasibility set, **the block proves nothing**. It reports a check at $6\le n\le24$ even (ten values of $n$) and the heading asserts a theorem for all $n$. There is no argument in the block, and **no script on the record**: the originating commit commit `559a75a` (`feat(conjecture-a): B1 settled on the 2-class locus, by enumeration over SRG parameters`, 2026-08-23) touches only `FINDINGS.md` and [plan.md](../plan.md), and nothing in [scripts/](../scripts/) enumerates strongly regular parameter sets. **The enumeration is unreproducible.**

**And [L144](../findings/diagonal-half.md#L509), in this same file, records the honest split**, *"THE IMPRIMITIVE HALF, PROVED … THE PRIMITIVE HALF, SCREENED AND NOT PROVED. Primitive strongly regular graphs satisfy $\theta<\tfrac12$ over the range examined: screened to $n\le200$ … This is a census over a finite range, so it is evidence rather than a theorem, and a uniform bound over all primitive parameter sets is owed."*

So the record simultaneously holds:

- **L96**: the maximum over 2-class schemes is $\theta_0(n)$, settled, uniquely attained;
- **L144**: the imprimitive half is proved, the primitive half is a finite screen and a uniform bound is owed.

**These cannot both be the record's position.** L144 is the later block (migrated 2026-09-03), is answered analytically by [r393](REVIEW_r393.md) and [r394](REVIEW_r394.md), and is right. What L96 can honestly claim is the *imprimitive* maximum, which §2's closed form proves outright at even $n$; the rest is owed.

**What a computation would decide, and what each outcome means**, flagged, not run, per the standing rule. A uniform bound over primitive strongly regular parameter sets, $\theta<c<\theta_0(n)$, is the missing input. It is an analytic question, not a search: with $e=(k^2-(n-1)\mu)/k$ the objective is $\theta^2=\frac{2(n-1)(k^2-(n-1)\mu)^2}{nk^3k'}$, a convex parabola in $\mu$ at fixed $k$, so the maximum is at an endpoint of the $\mu$-range and the whole question reduces to the two endpoint families ($\mu=0$ (imprimitive, settled above) and $\mu=k$ (its complement)), **once one shows no primitive set sits at an endpoint**. That reduction is the derivation the record is missing, and it would close both L96 and L144's screened half.

---

## 6. Scope, consumers, and the correspondence to the sphere product

- **What the family is.** A countable, arithmetically-defined subset of the diagonal locus: one point per feasible parameter set, one scalar of freedom already spent by the two constraints. It is a **narrow slice**, and the block should say so rather than leaving "weighted" to suggest a continuum.
- **What consumes L96.** Nothing numbered, anywhere. A repository-wide search finds the string `L96` only in its own heading and in [r608](REVIEW_r608.md)'s pointer-resolution list; no findings file, script, plan item or report section cites it. **The blast radius is one unnumbered paragraph**: the very next section, [*"And the two halves of B1 now meet"*](../findings/diagonal-half.md#L389), declares its first branch **closed** on L96's strength. That "closed" inherits every defect above and should be downgraded.
  - *A separate weakness in that paragraph, noted in passing:* "exactly three distinct eigenvalues, which under the rigidity is precisely a 2-class scheme" runs the rigidity backwards. The rigidity was derived **on the vertex-transitive locus** ($s_i=2/n$), and three distinct eigenvalues alone gives a Bose–Mesner algebra only with that hypothesis re-imposed. The branch is conditional on vertex-transitivity, which the bullet does not carry.
- **$K_{n/2,n/2}$ against the balanced sphere product.** The correspondence **is** stated, twice, and is not assumed: at [diagonal-half.md:21](../findings/diagonal-half.md#L21) ("the weight $1/(p(p-1))$ inside the blocks and $-1/(pq)$ across, whose negative graph is $K_{p,q}$") and again in [L74](../findings/diagonal-half.md#L451). **The trap it hides** is that $K_{n/2,n/2}$ names the **negative** graph, so it is the $\alpha<0$ branch, see §3.
- **Duplication.** **Yes, this content appears elsewhere under other numbers.** [L74](../findings/diagonal-half.md#L451) carries the closed form and the correct two-parameter-set maximiser; [L144](../findings/diagonal-half.md#L509) carries the closed form verbatim, the proved imprimitive maximisation, and the honest status of the primitive half. **L96 is the weakest of the three copies and the only one that is wrong.** The heading check would not catch this: the three headings share no phrase.
- **Provenance.** L96 carries **no** boilerplate provenance note (none of the fifteen copies is here) so there is nothing of that form to falsify. Its self-historical content is the range claim "at every even $n$ from $6$ to $24$", which `git log -S` traces to commit `559a75a` unchanged through the `51ab61f` file split; the number was registered as a Lemma later, in `03bab2f`. **The heading and the body have therefore never agreed on parity**, from the first commit. [INDEX-results.md:111](../findings/INDEX-results.md#L111) records "Gate 2: no verdict on the record", which is accurate.
- **Section reading used for the boilerplate question.** I read a `####` block as **its own unit**, not as inheriting the `###` section's notes, the same reading under which L96's absent provenance note is absent rather than inherited from the file head. Stated because two prior audits disagreed on it.
- **Pointers.** The block contains no outbound links at all, so none can fail; that is itself a defect against the file's own practice, since the $\theta_0$ decomposition it depends on sits sixty lines above and the closed form that supersedes it sits a hundred and thirty below, both unlinked.

---

## 7. What the record should carry instead

A statement that is true, proved, and within reach of §2:

> **Lemma L96 (repaired).** *Over the weighted $2$-class association schemes on $n$ vertices, $\theta=\lvert1+\lambda-\mu\rvert\sqrt{2(n-1)/(nk(n-1-k))}$. Restricted to the **imprimitive** schemes ($mK_g$ and their complements $K_{m\times g}$, $mg=n$, $1<g<n$), this is $\theta=\sqrt{2(n-1)(g-1)/(n(n-g))}$, strictly increasing in $g$, so:*
>
> - *at **even** $n$ the maximum is $\theta_0(n)$, attained exactly at $g=n/2$, the single scheme presented either as $K_{n/2,n/2}$ (the negative graph, $\alpha<0$) or as its complement $2K_{n/2}$;*
> - *at **odd** $n$ the maximum is $\sqrt{2(n-1)(g^*-1)/(n(n-g^*))}$ at $g^*$ the largest proper divisor of $n$, at most $\sqrt{(n-1)(n-3)}/n<\Theta_n/\sqrt2$ when $3\mid n$, and the imprimitive family is **empty** at odd prime $n$.*
>
> *Extension to the primitive schemes is **owed**: [L144](../findings/diagonal-half.md#L509) screens $\theta<\tfrac12$ to $n\le200$ and no uniform bound is on the record.*

Three edits carry it: **parity into the heading**, **the complement into the uniqueness clause**, and **the deletion of the "superset ⇒ a fortiori" sentence** in favour of naming multiplicity integrality as the hypothesis that does the work.

---

## Screens run, and what they are worth

One batch, seconds of compute, on twelve parameter sets I constructed. It evaluates **the block's own displayed formula**, building $\alpha,\beta$ from $(n,k)$, $r,s$ from $(\lambda,\mu)$, $f,g$ from the multiplicity formula, then $\tfrac12[n(k\alpha^3+k'\beta^3)+f\mu_r^3+g\mu_s^3]$, and compares it against §2's closed form. They agree in absolute value at all twelve, the sign tracking the branch. **This is a screen: it confirms that the block's formula and my closed form are the same object, and it exhibits the witnesses. Every positive claim above is derived in §2 and §3 and stands without it.**

| $(n,k,\lambda,\mu)$ | block's formula | closed form | $(f,g)$ | $\theta_0(n)$ | reading |
| --- | --- | --- | --- | --- | --- |
| $(6,3,0,3)$ $K_{3,3}$ | $-1.054093$ | $1.054093$ | $(4,1)$ | $1.054093$ | attains; **sign branch** |
| $(6,2,1,0)$ $2K_3$ | $+1.054093$ | $1.054093$ | $(1,4)$ | $1.054093$ | **second maximiser** |
| $(6,3,2,0)$ | $+1.581139$ | $1.581139$ | $(0.5,4.5)$ | $1.054093$ | **superset witness** |
| $(6,4,3,0)$ | $+2.581989$ | $2.581989$ | $(0.2,4.8)$ | $1.054093$ | **superset witness** |
| $(24,22,21,0)$ | $+6.493587$ | $6.493587$ | $(0.04,22.96)$ | $1.325498$ | **superset witness, $\sqrt n$ over** |
| $(12,6,0,6)$ $K_{6,6}$ | $-1.236033$ | $1.236033$ | $(10,1)$ | $1.236033$ | attains |
| $(12,5,4,0)$ $2K_6$ | $+1.236033$ | $1.236033$ | $(1,10)$ | $1.236033$ | **second maximiser** |
| $(12,8,4,8)$ $K_{4,4,4}$ | $-0.829156$ | $0.829156$ | $(9,2)$ | $1.236033$ | block's runner-up, exact |
| $(12,9,6,9)$ $K_{3,3,3,3}$ | $-0.638285$ | $0.638285$ | $(8,3)$ | $1.236033$ | block's runner-up, exact |
| $(9,2,1,0)$ $3K_3$ | $+0.769800$ | $0.769800$ | $(2,6)$ | $1.175889$ | **odd-$n$ maximum** |
| $(9,6,3,6)$ $K_{3,3,3}$ | $-0.769800$ | $0.769800$ | $(6,2)$ | $1.175889$ | its complement |
| $(9,4,1,2)$ Paley$(9)$ | $0$ | $0$ | $(4,4)$ | $1.175889$ | conference graph, $\theta=0$ |

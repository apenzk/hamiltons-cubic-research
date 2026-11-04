# REVIEW r389, Gate 2 on the four-set clause: the reduction is sharp, the owed lemma is false, and a free identity repairs the route

*Adversarial review of the last two sections of [ATTEMPTS.md](../ATTEMPTS.md), "I18's four-set clause, opened" and "The concentration lemma: the pure case is exact". Analysis only; the one numerical run below is a screen of claims derived by hand, reported as a screen. Every number in it was computed symbolically first and the screen agreed to every digit shown.*

## Verdict table

| # | Claim | Verdict |
| --- | --- | --- |
| 1 | $\Sigma\le\tfrac32(A^2+B^2+C^2)$ and $A^2\le2(M_{ij}^2+M_{kl}^2)$, hence $\Sigma\le3m_4$ | **BOTH STEPS TRUE, and the composite constant $3$ is SHARP.** But the first step is an *identity minus a square*, and the section threw the square away, see claim 1b |
| 1b | *(new)* the sharp form | **$\Sigma=3m_4-\tfrac{\sigma^2}2-3\big[(M_{ij}-M_{kl})^2+(M_{ik}-M_{jl})^2+(M_{il}-M_{jk})^2\big]/2$**, $\sigma=\sum_{a<b\in S}M_{ab}$. So $\Sigma\le3m_4-\sigma^2/2$ free, **with equality on the whole two-factor family** |
| 2 | $m_4<\theta^2/3$ suffices; in band $m_4<\tfrac12$ suffices; $S^6\times S^6$ carries $0.0869$ against $0.509$ | **Logic correct. The $S^6\times S^6$ evaluation names the WRONG four-set**, the binding one is the $(4,0)$ split at $6\alpha^2=6/55=0.1091$, not the $(2,2)$ split at $0.0869$. Ratio $4.67$, not "a factor of six" |
| 3 | value formula $\theta=\tfrac12(\sum M_{ab}^3+\mathop{\mathrm{tr}}M^3)$, on record with the spectral cap and the $99.6\%$ figure | **Formula TRUE, derivation TRUE, on record TRUE. The cap quoted is the file's own SUPERSEDED one**, [diagonal-half.md:43](../findings/diagonal-half.md) ignores the forced zero eigenvalue that [diagonal-half.md:47](../findings/diagonal-half.md) uses. Correct cap $1.213562$, correct share $98.18\%$, and it is **exactly saturated** at $S^6\times S^6$. The "$0.0449$" is an un-halved quantity compared against halved ones |
| 4 | four-set-supported $\Rightarrow$ at most four nonzero eigenvalues, cap $\tfrac12\mathop{\mathrm{tr}}M^3\le0.8165$; $\Theta_4=\sqrt{12}/4$ from [Lemma L57](../findings/problem.md) | **Eigenvalue count WRONG (three, not four) and the cap WRONG: $\tfrac12\mathop{\mathrm{tr}}M^3\le1/\sqrt3=0.577350$, attained.** $\Theta_4=\sqrt{12}/4$ is **right** per L57, but the record carries a name collision, [support-dichotomy.md:25](../findings/support-dichotomy.md) using $\Theta_4$ for $\sqrt{3/2}$. **Yes, a four-set-supported critical point exists and attains $0.866$**: padded $S^2\times S^2$, verified from the criticality equation |
| 5 | the obstacle is that $M_S$ is not zero-row-sum | **NO, there is a worse one, and it is fatal. The owed lemma is FALSE** |
| 6 | fix by projecting $M_S$ with [Lemma L18](../findings/problem.md)(b)'s closed form | **MISATTRIBUTED and, as written, self-defeating.** The cited machinery is [Lemma L57](../findings/problem.md)'s **Step 2(b)** ([problem.md:234–250](../findings/problem.md)), not L18, which has no part (b). The orthogonality half *does* generalise; the closed form is $Z(v)$-specific. And projecting into $\mathcal D_n$ replaces $\Theta_4=0.866$ by $\Theta_n\to\sqrt2$, **above the band** |

## The headline: the lemma the section says is owed is FALSE

> *"A quantitative form of the concentration statement: $m_4(S)\ge\tfrac12$ at some four-subset forces $\theta$ below $\sqrt{3/2}$."*

**Counterexample: $S^5\times S^q$ for every $q\ge43$, with $S$ the four indices inside the $5$-factor.**

**The family.** Put $\alpha$ on within-factor-1 pairs, $\beta$ on within-factor-2 pairs, $\gamma$ across. $M\mathbf1=0$ gives $(p-1)\alpha+q\gamma=0$ and $(q-1)\beta+p\gamma=0$. Criticality holds at all three pair types and returns **the same** $\theta$ at each:

- within factor 1: $\alpha^2+(p-2)\alpha^2+q\gamma^2=\theta\alpha$, and $(p-1)\alpha^2=-q\gamma\alpha$, so $\theta=q\gamma(\gamma-\alpha)/\alpha=-\gamma(p-1+q)$;
- within factor 2: identically $-\gamma(n-1)$;
- across: $\gamma+(p-1)\alpha+(q-1)\beta=\theta$, i.e. $\gamma-q\gamma-p\gamma=-\gamma(n-1)$.

So $\boxed{\theta=(n-1)\lvert\gamma\rvert}$, and $\mathop{\mathrm{tr}}M^2=2$ gives $\gamma^2=1/D$ with $D=\dfrac{pq^2}{2(p-1)}+\dfrac{p^2q}{2(q-1)}+pq$. *Check at $p=q=6$: $\gamma^2=5/396$, $\theta=11/\sqrt{79.2}=1.236036=\theta_0(12)$, the brief's own $\gamma^2$, recovered.*

**The four-set.** Take $S$ inside factor 1 (needs $p\ge4$). All six entries equal $\alpha$, so $m_4=6\alpha^2=6q^2\gamma^2/(p-1)^2$ and

$$\frac{m_4}{\theta^2}=\frac{6q^2}{(p-1)^2(p+q-1)^2},\qquad m_4\ge\frac{\theta^2}{3}\iff \sqrt{18}\,q\ge(p-1)(p+q-1).$$

At $p=5$ this reads $4(q+4)\le4.2426\,q$, i.e. $q\ge66$. At $p=6$ it reads $5(q+5)\le4.2426\,q$, never. At $p=4$ it holds from $q\ge8$, but $p=4$ is **never in band**: $\tfrac32D=q^2+6q+\tfrac{12q}{q-1}$ against $(q+3)^2=q^2+6q+9$, and $9\ge12q/(q-1)$ fails for every $q>0$, so $\theta^2<\tfrac32$ always, approaching it from below. **So $p=5$ is the unique two-factor family where the reduction fails in band**, and it fails there by a fixed margin.

**The numbers** (screen, agreeing with the closed forms to every digit; criticality residual $\le2.4\times10^{-14}$, $\lVert M\mathbf1\rVert_\infty\le5.6\times10^{-16}$, $\mathop{\mathrm{tr}}M^2=2$):

| point | $n$ | $\theta$ | in band? | $m_4$ (the $(4,0)$ set) | $\theta^2/3$ | $\Sigma$ |
| --- | --- | --- | --- | --- | --- | --- |
| $S^6\times S^6$ | $12$ | $1.236033$ | yes | $0.109091$ | $0.509259$ | $0$ |
| $S^5\times S^{43}$ | $48$ | $1.263631$ | yes | $\mathbf{0.501203}$ | $0.532255$ | $0$ |
| $S^5\times S^{66}$ | $71$ | $1.264355$ | yes | $\mathbf{0.532919}$ | $0.532865$ | $0$ |
| $S^5\times S^{200}$ | $205$ | $1.264849$ | yes | $\mathbf{0.576644}$ | $0.533281$ | $0$ |
| $S^4\times S^{40}$ | $44$ | $1.223651$ | **no** | $0.863787$ | $0.499107$ | $0$ |

**$S^5\times S^{43}$ already refutes the owed lemma**, $\theta=1.2636\ge\sqrt{3/2}=1.224745$ with $m_4=0.5012\ge\tfrac12$. As $q\to\infty$ at $p=5$: $\theta^2\to\tfrac85$, $\theta\to1.264911$, $m_4\to\tfrac35$, $\theta^2/3\to0.533$. **So $m_4$ overshoots its own budget by $12.5\%$ in the limit, and no repair of the constant saves the criterion**: the band permits $\theta^2<2$, hence $\theta^2/3<2/3$, and $m_4=0.6$ sits inside that window at a point where $\theta^2/3=0.533$.

**And this is a failure of the METHOD, not of the clause.** At every one of those four-sets $M_{ij}=M_{kl}=M_{ik}=M_{jl}=M_{il}=M_{jk}=\alpha$, so $A=B=C=2\alpha$ and $\Sigma=0$, the clause $\Sigma\ne\theta^2$ holds with the widest possible margin, while the bound $3m_4=1.73$ overstates $\Sigma$ by $1.73$. **The reduction is lossy exactly where it is needed.**

## Claim 1, the reduction, re-derived, and where the section lost the good half

Write $q_2=A^2+B^2+C^2$ and $s=A+B+C$. Then $AB+BC+CA=(s^2-q_2)/2$, so

$$\Sigma=q_2-\frac{s^2-q_2}{2}=\frac{3q_2-s^2}{2}=\tfrac32 q_2-\tfrac12 s^2 .$$

**This is an identity, not an inequality.** Hence $\Sigma\le\tfrac32q_2$ **is** true in general, with equality **iff** $A+B+C=0$, which is what [Lemma L124](../findings/second-order.md)(i) records as the equality case, so the section's first step is correct and correctly attributed. *(Incidentally $\Sigma=\tfrac12[(A-B)^2+(B-C)^2+(C-A)^2]\ge0$, so $\Sigma$ is the spread of the three opposite-pair sums, not their size.)*

Second step: $A^2=(M_{ij}+M_{kl})^2\le2(M_{ij}^2+M_{kl}^2)$, equality iff $M_{ij}=M_{kl}$. Summing the three, $q_2\le2m_4$, so $\Sigma\le3m_4$. ✓

**The sharp constant is exactly $3$.** Given $(A,B,C)$, the minimum of $m_4$ is $q_2/2$, so $\max\{\Sigma:m_4=1\}=\max\{\tfrac32q_2-\tfrac12s^2:q_2=2\}=3$ at $s=0$; attained at $M_{ij}=M_{kl}=\tfrac12$, $M_{ik}=M_{jl}=-\tfrac12$, $M_{il}=M_{jk}=0$. **So no sharpening of the constant is available**, the two equality cases are compatible.

**But the section discarded a free term.** Note $s=A+B+C=\sigma:=\sum_{a<b\in S}M_{ab}$, the plain sum of the six entries. Keeping it:

$$\boxed{\ \Sigma\;=\;3m_4-\frac{\sigma^2}{2}-\frac32\Big[(M_{ij}-M_{kl})^2+(M_{ik}-M_{jl})^2+(M_{il}-M_{jk})^2\Big]\ }$$

whence **$\Sigma\le3m_4-\sigma^2/2$, at no cost**, and the repaired sufficient condition is

$$3\,m_4(S)-\tfrac12\sigma(S)^2\;<\;\theta^2\quad\Longrightarrow\quad\text{the clause at }S.$$

**This repair is EXACT on the whole two-factor family** (there $M_{ij}=M_{kl}$ etc. hold identically), and it clears every case the $m_4$-only version failed:

- $S^5\times S^{200}$, $(4,0)$ set: $3m_4=1.729933$, $\sigma^2/2=1.729933$, bound $=0=\Sigma$. **Cleared with the full budget intact.**
- $S^6\times S^6$, $(2,2)$ set: $3m_4=0.260606$, $\sigma^2/2=0.016162$, bound $=0.244444=\Sigma=(A-B)^2$ exactly.

**And it reproves [Lemma L126](../findings/second-order.md).** On a $(2,2)$ split $B=C=2\gamma$, so $\Sigma=(A-B)^2=(\alpha+\beta-2\gamma)^2$, and $\Sigma=\theta^2$ reads $q/(p-1)+p/(q-1)+2=p+q-1$; with $u=p-1,v=q-1$ that is $\frac{(u+v)^2}{uv}+\frac{u+v}{uv}=u+v+1$, i.e. $\frac1{p-1}+\frac1{q-1}=1$. On $(3,1)$ and $(4,0)$ splits $A=B=C$ and $\Sigma=0$. **L126 recovered in three lines.** *Which also means the section's $S^6\times S^6$ advertisement is redundant: L126 already settles the entire two-factor family exactly, so the $m_4$ criterion was being demonstrated on the one family where it was never needed.*

## Claim 2, the sufficiency logic, and the wrong four-set

The implication is correct: $m_4<\theta^2/3\Rightarrow\Sigma\le3m_4<\theta^2\Rightarrow\Sigma\ne\theta^2$; and $\theta\ge\sqrt{3/2}\Rightarrow\theta^2/3\ge\tfrac12$, so $m_4<\tfrac12$ suffices in band. ✓

**The evaluation is on the wrong four-set.** At $S^6\times S^6$, $\alpha^2=1/55$, $\gamma^2=5/396$ (both confirmed from $5\alpha+6\gamma=0$, $30\alpha^2+36\gamma^2=1$), and $2\alpha^2+4\gamma^2=0.086869$ is right **for the $(2,2)$ split**. The three splits give

| split | $m_4$ |
| --- | --- |
| $(2,2)$, the one the section names | $2\alpha^2+4\gamma^2=0.086869$ |
| $(3,1)$ | $3\alpha^2+3\gamma^2=0.092424$ |
| $(4,0)$, **the binding one** | $6\alpha^2=6/55=0.109091$ |

The budget $\theta^2/3=55/108=0.509259$ is correct. **The true margin is $4.67\times$, not $6\times$, and the section again picked the favourable sub-case of an unnamed choice**, the same pattern the previous Gate 2 recorded as item (3b) two sections earlier. *Harmless at $S^6\times S^6$; fatal at $S^5\times S^q$, where the $(4,0)$ split is the counterexample and the $(2,2)$ split would have shown nothing.*

## Claim 3, the value formula is right, the cap quoted is the record's own superseded one

**Derivation, rebuilt.** Multiply $M_{ij}^2+(M^2)_{ij}=\theta M_{ij}$ by $M_{ij}$ and sum over ordered $i\ne j$. Since $M$ is hollow, $\sum_{i\ne j}M_{ij}^2=\mathop{\mathrm{tr}}M^2=2$ and $\sum_{i\ne j}(M^2)_{ij}M_{ij}=\sum_{i,j}(M^2)_{ij}M_{ji}=\mathop{\mathrm{tr}}M^3$. Hence $\sum_{i\ne j}M_{ij}^3+\mathop{\mathrm{tr}}M^3=2\theta$. ✓ **Correct, and $\sum_{a,b}=\sum_{i\ne j}$ since the diagonal vanishes.** On record at [diagonal-half.md:29](../findings/diagonal-half.md). ✓

**The cap.** For $k$ reals with $\sum x=0$, $\sum x^2=s$, $\max\sum x^3=s^{3/2}(k-2)/\sqrt{k(k-1)}$ (one large against $k-1$ equal negatives). Applied with $k=n$ this gives $\tfrac12\mathop{\mathrm{tr}}M^3\le\sqrt2(n-2)/\sqrt{n(n-1)}=1.230915$ at $n=12$, the quoted figure. **But $M\mathbf1=0$ forces a zero eigenvalue**, so the correct application is $k=n-1$:

$$\tfrac12\mathop{\mathrm{tr}}M^3\;\le\;\frac{\sqrt2\,(n-3)}{\sqrt{(n-1)(n-2)}}\;=\;1.213562\ \ (n=12).$$

**The record already knows this**, [diagonal-half.md:47](../findings/diagonal-half.md) states it with $c_n=(n-3)/\sqrt{(n-1)(n-2)}$ and "$k=n-1$ after the forced zero". So [diagonal-half.md:43](../findings/diagonal-half.md), and the section quoting it, cite the file's own superseded line. **Three consequences:**

1. **The share is $98.18\%$, not $99.6\%$.** $1.213562/1.236033=0.98182$.
2. **The corrected cap is EXACTLY SATURATED at $S^6\times S^6$**, not "$98.6\%$ of the cap": $\mathop{\mathrm{spec}}(M)=\{10\alpha,(-\alpha)^{10},0\}$ with $\alpha=1/\sqrt{55}$ is precisely the $k=11$ extremiser, and $\tfrac12\mathop{\mathrm{tr}}M^3=495\alpha^3=1.2135624$. **A cleaner statement than the one on record.**
3. **The "$0.0449$" is a normalisation collision.** $\theta_0(12)-\tfrac12\mathop{\mathrm{tr}}M^3=0.0224707$; $0.0449$ is the *un-halved* $\sum_{a,b}M_{ab}^3=2\theta_0-\mathop{\mathrm{tr}}M^3$, [diagonal-half.md:47](../findings/diagonal-half.md)'s $E_0$. As the section writes it, "$1.2309$ against $1.236033$ … the entrywise cube sum supplying $0.0449$", the three numbers do not add up ($1.2309+0.0449=1.2758$). **The correct split is $1.236033=1.213562+0.022471$, i.e. $98.18\%+1.82\%$.**

*The section's own claim ("recorded as a confirmation, claiming nothing"), is honest, and the screen it reports did fire. What it did not do is check which of the file's two caps it was copying.*

## Claim 4, the pure-concentration case: the count is off by one eigenvalue and the cap by $41\%$

**The eigenvalue count is wrong.** If $M$ is supported on $S=\{i,j,k,l\}$ then $M_S\mathbf1_4=0$ **as well**, each row sum over $S$ *is* the full row sum. So $M$ has at most **three** nonzero eigenvalues, not four.

**Hence the cap is wrong.** With $k=3$: $a,-a/2,-a/2$ and $\tfrac32a^2=2$ give $a=2/\sqrt3$ and $\mathop{\mathrm{tr}}M^3=\tfrac34a^3$, so

$$\tfrac12\mathop{\mathrm{tr}}M^3\;\le\;\tfrac1{\sqrt3}\;=\;0.577350,\qquad\text{not }0.816497 .$$

The section's $0.8165$ comes from $a=\sqrt{3/2}$ against three equal negatives with $\mathop{\mathrm{tr}}M^3=\tfrac89a^3$, the $k=4$ problem, which the zero-row-sum condition forbids. *The arithmetic inside that computation is right; the constraint set is wrong.*

**And the corrected value is exactly attained.** Take $S=\{1,2,3,4\}$, $M_{12}=M_{34}=x$, the four cross entries $=-x/2$; then $x=1/\sqrt3$ from $\mathop{\mathrm{tr}}M^2=2$, and

- **criticality holds**: at $(1,2)$, $x^2+2(x/2)^2=\tfrac13+\tfrac16=\tfrac12=\theta x$ with $\theta=\sqrt3/2$; at $(1,3)$, $x^2/4+2x(-x/2)=\tfrac1{12}-\tfrac13=-\tfrac14=\theta\cdot(-x/2)$. ✓
- $\mathop{\mathrm{spec}}(M)=\{2x,-x,-x,0\}=\{2/\sqrt3,-1/\sqrt3,-1/\sqrt3,0\}$, the $k=3$ extremiser, $\tfrac12\mathop{\mathrm{tr}}M^3=1/\sqrt3=0.577350$;
- the entrywise half is $\sum_{a<b}M_{ab}^3=2x^3-4x^3/8=\tfrac1{2\sqrt3}=0.288675$;
- **$\theta=0.577350+0.288675=0.866025=\sqrt3/2$.** ✓

**So: yes, a four-set-supported hollow zero-row-sum $M$ can be critical, and $0.866$ is attained**, it is the padded $S^2\times S^2$, already in the record at [second-order.md:418](../findings/second-order.md).

**$\Theta_4=\sqrt{12}/4$ is the right constant from [Lemma L57](../findings/problem.md)**, whose even-$n$ formula $\Theta_n^2=2(n-1)(n-2)/n^2$ gives $\Theta_4^2=12/16$. ✓ **But the record collides on the symbol**: [support-dichotomy.md:25](../findings/support-dichotomy.md) writes "$\Theta_4=\sqrt{3/2}$ against $\theta_0(4)=0.866$", using $\Theta_4$ for the *full* Weyl$_4$ maximum attained at $W_{\mathbb{CP}^2}$, while L57 states "at even $n$, $\Theta_n=\theta_0(n)$". **The section is on L57's side and is therefore correct, but only because $M$ is frame-diagonal.** *This is load-bearing and unstated: with the other reading the constant would be $\sqrt{3/2}=1.224745$, which is the band's own lower endpoint, and the sentence "outside the band entirely" would be false at the endpoint the band includes.*

## Claim 5, the named obstacle is real, and it is the least of three

The named obstacle is correct as far as it goes: $M_S$ has row sums $r_i=\sum_{j\in S}M_{ij}=-\sum_{j\notin S}M_{ij}\ne0$, so [Lemma L57](../findings/problem.md), stated on $\mathcal D_n$, does not apply to it. **Two worse things are true.**

**(a) The perturbation is not small at the threshold the lemma needs.** $\lVert E\rVert^2=2(1-m_4)$, so at $m_4=\tfrac12$ we have $\lVert E\rVert=1$ against $\lVert M\rVert=\sqrt2$, **$71\%$ of the norm**. A cubic-continuity estimate $\lvert\theta(M)-\theta(M_S)\rvert\le C\lVert E\rVert$ would have to close a gap of $1.2247-0.866=0.359$ across a perturbation of that size. *The continuity step itself is sound in the only sense that matters, the value functional $V(M)=\tfrac12(\sum M_{ab}^3+\mathop{\mathrm{tr}}M^3)/(\lVert M\rVert^2/2)^{3/2}$ is smooth and degree-zero, and L57 bounds it on all of $\mathcal D_n$ rather than only at critical points, so applying it to a non-critical $M_S'$ is legitimate.* **The step is available and useless.**

**(b) The target is false.** The counterexample above ends the question: no repair of the interpolation can prove a statement with a counterexample at $m_4=0.5766$, $\theta=1.2648$. **The true threshold for "concentration forces $\theta$ out of band" lies in $(0.6,1]$, and $\theta^2/3<2/3$ throughout the band, so any true version is too weak to feed the clause.** *The $m_4$-only criterion is dead; the $\sigma$-corrected criterion of claim 1b is not.*

## Claim 6, the proposed fix is misattributed, and as written it destroys its own bound

**Misattribution.** [Lemma L18](../findings/problem.md) ([problem.md:252](../findings/problem.md)) is the defect-penalty lifting lemma, Bianchi correction, scalar-curvature split, the $1.0\times10^{-3}$ constant, and **has no part (b)**. The $Z(v)$ projection with residual $a_i+a_j+c$ is **Step 2(b) of the candidate diagonal theorem**, [problem.md:234–250](../findings/problem.md), i.e. machinery of [Lemma L57](../findings/problem.md) itself. *The section cites the wrong lemma for the right file.*

**Does it apply?** Split the question.

- **The orthogonality half generalises, and more cleanly than the section claims.** Hollow symmetric matrices have dimension $\binom n2$, $\mathcal D_n$ has $n(n-3)/2$, so the complement has dimension $n$, and $\{(a_i+a_j)_{i\ne j}:a\in\mathbb R^n\}$ has dimension exactly $n$ for $n\ge3$ (the constant $c$ is already inside it, $a_i=c/2$). So $\mathcal D_n^\perp=\{a_i+a_j\}$ **exactly**, and the projection of *any* hollow symmetric $X$ is $X-(a_i+a_j)$ with $r_i-(n-2)a_i-\textstyle\sum a=0$, $\sum a=\sum r/(2n-2)$, closed form, no rank-one hypothesis. **So the section is right that the machinery is general, for the wrong reason: what generalises is the orthogonality proof, not the formula $Z(v)$, which is specific to $(v_iv_j)$.**
- **But the projection as proposed defeats the argument.** Projecting $M_S$ onto $\mathcal D_n$ subtracts $(a_i+a_j)$ over **all** $\binom n2$ pairs, and $a_i=-\sum a/(n-2)\ne0$ for every $i\notin S$ whenever $\sigma(S)\ne0$. **The projected matrix is no longer four-set-supported**, so the only bound available to it is $\Theta_n\to\sqrt2$ (*above* the band) and the $0.866$ that the whole argument rests on is gone. **The projection must be taken inside $\mathcal D_4$, not $\mathcal D_n$, and the section does not say so.**

## What survives, and where the route should go

**Survives.** The reduction $\Sigma\le3m_4$ (true, sharp). The sufficiency logic. The value formula and its rederivation. The qualitative statement that full four-set concentration sits at $\theta=0.866$, outside the band, now with an explicit critical point attaining it.

**Dead.** The owed lemma ($m_4\ge\tfrac12\Rightarrow\theta<\sqrt{3/2}$), by counterexample. The $m_4$-only criterion, at any constant. The interpolation-by-continuity plan, twice over.

**The right next step is the identity of claim 1b, not the concentration lemma.** $\Sigma$ is the *spread* of $A,B,C$ ($\Sigma=\tfrac12\sum(A-B)^2$) and mass on a four-set with equal entries produces $\Sigma=0$. The correct invariant is therefore $3m_4-\tfrac12\sigma^2$, which is **exact on the entire two-factor family**, recovers [Lemma L126](../findings/second-order.md) in three lines, and clears the $S^5\times S^q$ family with the whole budget intact. **What is owed is the same statement with $\sigma$ in it**: $3m_4(S)-\tfrac12\sigma(S)^2<\theta^2$ at every four-subset of every in-band pure critical point. *That is a genuinely different question from the one the section posed, and it is not refuted by anything here.*

---

*Screen (permitted: seconds of compute on objects constructed for the check, reported as a screen and never as evidence for a positive claim). Built $M$ for $(p,q)\in\{(6,6),(5,43),(5,66),(5,200),(4,40)\}$ from the block ansatz, verified $M\mathbf1=0$ to $5.6\times10^{-16}$, $\mathop{\mathrm{tr}}M^2=2$, criticality residual $\max-\min$ of $(M_{ij}^2+(M^2)_{ij})/M_{ij}$ over all $i\ne j$ at $\le2.4\times10^{-14}$, and the value formula against the criticality $\theta$ to $10^{-15}$. Every entry of the table above was derived in closed form first; the screen agreed to all six digits.*

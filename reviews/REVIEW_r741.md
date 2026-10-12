# L165, the frontier requirement in closed form: $H_\theta(\sigma)$, the cubic on $\sigma\le\sigma^*$, and the $\sigma=\tfrac34$ witness

**Reviewer r741, Gate 2, cold.** I worked from [BRIEF-g2-l165.md](BRIEF-g2-l165.md) alone and formed a verdict on every claim before opening any file of the record; the provenance check in §11 was run last and changed no verdict, only the warrant attached to two imports. **No numerical work was done**: every value below is rational or symbolic, and the two places where a decimal appears (the minimum of the cubic, the crossing dimension) are stated with the exact object beside them and were screened with exact arithmetic on objects I constructed for that purpose. Log: [agent_logs/g2-l165-r741.log](../agent_logs/g2-l165-r741.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | $\sigma=s=\sin\beta$ forced by $s^2=3\varepsilon$ | **CONFIRMED**, and it fixes a normalisation the statement never declares (§1, §2c) |
| 2 | $3-5\alpha=\tfrac13(4+5\sigma^2)$ | **CONFIRMED** exactly |
| 3 | $t^{*2}=\tfrac{15}{32}\Rightarrow\sigma^{*2}=\tfrac{15}{47}\Rightarrow\alpha^*=\tfrac{32}{141}$ | **CONFIRMED** exactly |
| 4 | The expansion $P(W)=3c^2\sigma[A+tB]+\sigma^3P(K)$, every coefficient | **CONFIRMED**, including $3cs^2B=3c^2s\,tB$ |
| 5 | *"the $c^3$ term is absent because $P(W_1)=0$ on $V_{1/3}$"* | **CONFIRMED as an implication, CIRCULAR as a citation**, $P\equiv0$ on $V_{1/3}$ *is* the $V_{1/3}$ slot of the decomposition offered as its reason (§3) |
| 6 | *"so $H_\theta$ bounds $\gamma_{\max}$ from above"* | **FALSE AS WRITTEN, right in intent**, $H_\theta$ is a *lower* bound on the requirement's slack; the direction of use is correct (§4) |
| 7 | The two-piece collection in (2), and $3\sqrt{5/6}=\sqrt{30}/2$ | **CONFIRMED** exactly |
| 8 | The branches meet at $\sigma^*$, tangentially | **CONFIRMED**, common value $\tfrac{240\sqrt{94}}{2209}$, and $t^*$ is the *minimiser* of $\tfrac5{16t}+\tfrac{2t}3$, so $V\in C^1$ (§5) |
| 9 | $3\sqrt2\,H_\theta=(3\sqrt{15}-3\sqrt2\theta)\sigma^3+5\sigma^2-3\sqrt{15}\sigma+4$ | **CONFIRMED** exactly |
| 10 | $\theta<\sqrt2$ at both parities | **CONFIRMED**; even needs $n\ge2$, odd needs $n\ge3$ for the sign of the denominator (§7) |
| 11 | $\Delta=12312\sqrt{15}-48197$, and $\Delta<0$ | **CONFIRMED** term by term; $15\cdot12312^2=2{,}273{,}780{,}160<2{,}322{,}950{,}809=48197^2$ (§6) |
| 12 | $\Delta<0\Rightarrow$ one real root $\Rightarrow$ positive on $\sigma\ge0$ | **CONFIRMED**, convention right, argument complete; second proof from $r\lvert z\rvert^2=-d/a<0$ (§6) |
| 13 | Monotonicity in $\theta$ | **CONFIRMED**, and it uses $\sigma\ge0$ essentially, which the construction supplies (§8) |
| 14 | The requirement holds for every $\alpha\in[\tfrac{32}{141},\tfrac13)$, every $n$, both parities | **CONFIRMED conditionally**, thin margin ($\min 3\sqrt2H_{\sqrt2}=0.0389\ldots$), and *"at every $n$"* is not honest about three imports licensed at four dimensions in floating point (§9, §11) |
| 15 | $H_\theta(\tfrac34)=\tfrac{109\sqrt2}{96}-\tfrac{393\sqrt7}{1024}-\tfrac{27}{64}\theta$ and $\Theta_{3/4}=\tfrac{218\sqrt2}{81}-\tfrac{131\sqrt7}{144}$ | **CONFIRMED** exactly, and $\tfrac9{16}>\tfrac{15}{47}$ so the right branch is used |
| 16 | $\Theta_{3/4}<\sqrt2$ | **CONFIRMED** exactly: $19728^2\cdot2=778{,}387{,}968<788{,}153{,}247=10611^2\cdot7$ |
| 17 | *"the requirement at $\alpha=\tfrac7{48}$ holds **exactly when** $\theta<\Theta_{3/4}$"* | **REFUTED as written**, one direction only, and doubly so (§10) |
| 18 | *"the reach downward from $\tfrac13$ stops at some $\alpha\ge\tfrac7{48}$ once $n$ is large enough"* | **UNSUPPORTED under every reading**, it needs $\theta=\theta_0(n)$, and the record carries $\theta\le\theta_0(n)$ (§10) |
| 19 | *"$\theta_0(n)$ increases to $\sqrt2$ so it crosses $\Theta_{3/4}$"* | **CONFIRMED**, and *large enough* means $n\ge142$ even, $n\ge143$ odd, above every dimension the block is measured at (§10) |

**Actionable summary: every line of algebra in (0)–(4) is exactly right; replace *"holds exactly when"* in (4) by *"is delivered by this bound exactly when"*, add *"and $\theta=\theta_0(n)$"* to its conclusion or drop the conclusion, and attach to (3)'s *"at every $n$"* the three imports it rests on.**

## 0. Conventions, fixed once

$P$ is a cubic form with symmetric trilinear polarisation $T$ normalised by $P(X)=T(X,X,X)$, and $Q$ is the quadratic map defined by $\langle Q(X),Y\rangle=T(X,X,Y)$, so $P(X)=\langle Q(X),X\rangle$. $F_u$ is self-adjoint, with $\langle u\rangle$, $V_{1/3}$ and $\ker F_u$ mutually orthogonal as eigenspaces at distinct eigenvalues. $\alpha(X)=\sqrt{2/3}\langle F_uX,X\rangle$ is normalised so that $\alpha=1$ on unit $u$, $\alpha=\tfrac13$ on unit $V_{1/3}$ and $\alpha=0$ on $\ker F_u$; $\theta^*=\sqrt{3/2}$ is the scale that makes this so, $F_u$ acting as $\theta^*\cdot\mathrm{diag}(1,\tfrac13,0)$ on $\langle u\rangle\oplus V_{1/3}\oplus\ker F_u$. $W$ is a **unit** vector, $W=cW_1+\sigma K$ with $W_1,K$ unit and orthogonal, $\beta\in[0,\tfrac\pi2]$, $c=\cos\beta\ge0$, $\sigma=s=\sin\beta\ge0$, $t=\sigma/c\in[0,\infty]$. $\varepsilon=\tfrac13-\alpha$. $\theta=\sup\{P(K):K\in\ker F_u,\lVert K\rVert=1\}$. A cubic's discriminant is $\Delta=18abcd-4b^3d+b^2c^2-4ac^3-27a^2d^2$ for $a\sigma^3+b\sigma^2+c\sigma+d$.

**The normalisation in the third sentence is forced and is not declared anywhere in the statement.** See §2c: reading *"$V_{1/3}$ eigenspace of $F_u$"* as $F_uW_1=\tfrac13W_1$ with $\lVert W\rVert=1$ makes $s^2=3\varepsilon$ false at every $c\ne0$.

## Hypothesis inventory

**Hypotheses of the statement, and what each is used for.**

| Hypothesis | Where it is used | Status |
|---|---|---|
| $\alpha<\tfrac13$, i.e. $\sigma>0$ | nowhere essentially, every claim is proved on the closed $\sigma\in[0,1]$ | slack |
| $\sigma\ge0$ | (3)'s monotonicity in $\theta$, and (3)'s "the root is negative, so the cubic is positive on $\sigma\ge0$" | **load-bearing twice**; supplied by $\sigma=\sin\beta$, $\beta\in[0,\tfrac\pi2]$ |
| $\lVert W\rVert=1$, $W_1\perp K$ both unit | the expansion, and $P(K)\le\theta$ (a unit-sphere supremum) | **load-bearing, undeclared** |
| $W$ has **no** component outside $V_{1/3}\oplus\ker F_u$ | the whole expansion, three of the four terms would otherwise be missing | imported ($c_0=1$ at the maximiser) |
| $s^2=3\varepsilon$ | (0), and with it every later formula | imported |
| $V(t)$ as displayed | (1), (2), (4) | imported; carries the $\sqrt{5/6}$, the $\tfrac23$ and Observation L102's vanishing |
| $\theta\le\theta_0(n)$ / $\tilde\theta_0(n)$ | (3)'s $\theta<\sqrt2$, and (4)'s crossing | imported inequality; **the crossing claim needs the equality** |
| $Q(W_1)\in\langle u\rangle\oplus\ker F_u$, norms$^2$ $\tfrac16$ and $\tfrac56$ | $P(W_1)=0$ (the $\tfrac56$ additionally underwrites $V$'s flat branch) | imported; §3 and §11 |
| $P(X)=T(X,X,X)$ with $T$ symmetric | the factor $3$ on both cross terms | convention; §2b |

**Hypotheses the argument does not use.** The value $\tfrac16$ for the $\langle u\rangle$-component of $Q(W_1)$ appears nowhere in the statement, it enters the record only as $1-\tfrac56$ in the derivation of $\sqrt{5/6}$, and the statement could be written without it. $n\ge12$ is used nowhere: the algebra needs $n\ge2$ (even) or $n\ge3$ (odd), and nothing else. Parity enters only in selecting which $\theta_0$ formula to bound $\theta$ by, and the two formulas are used only through the single consequence $\theta<\sqrt2$. $\theta^*=\sqrt{3/2}$ enters only through the normalisation of §0 and never as a number. The strictly negative eigenspaces of $F_u$ are absent by hypothesis, not by argument.

**Imported facts whose own hypotheses I checked against the object here.** $\theta_0(n)^2=\frac{2(n-1)(n-2)}{n^2}$ and $\tilde\theta_0(n)^2=\frac{2(n-1)(n-3)}{(n+1)(n-2)}$ apply to a unit $K$ in $\ker F_u$, and $\theta$ is a supremum over exactly that set, the match is clean. The polarisation identity applies to any symmetric $T$. The decomposition of $Q(W_1)$ applies to unit $W_1\in V_{1/3}$, and $W_1$ here is unit and in $V_{1/3}$, clean, and its warrant is §11's business, not its scope's.

## 1. The change of variable (attack 1)

$\varepsilon=\tfrac13-\alpha$, so $3\varepsilon=1-3\alpha$. The imported $s^2=3\varepsilon$ therefore reads $s^2=1-3\alpha=\sigma^2$. Both $s=\sin\beta$ with $\beta\in[0,\tfrac\pi2]$ and $\sigma$ as the positive root are nonnegative, so $\sigma=s$, **forced, not chosen**. It also forces $c^2=1-\sigma^2=3\alpha$, hence $\alpha=\tfrac{c^2}3$, which is the identity §0's normalisation exists to make true.

$3-5\alpha$ with $\alpha=\tfrac{1-\sigma^2}3$ is $3-\tfrac53(1-\sigma^2)=\tfrac{9-5+5\sigma^2}3=\tfrac{4+5\sigma^2}3$. **Exact.**

$t^*=\tfrac34\sqrt{\tfrac56}=\tfrac34\cdot\tfrac{\sqrt{30}}6=\tfrac{\sqrt{30}}8$, so $t^{*2}=\tfrac{30}{64}=\tfrac{15}{32}$. From $t^2=\frac{\sigma^2}{1-\sigma^2}$, $\sigma^2=\frac{t^2}{1+t^2}=\frac{15/32}{47/32}=\tfrac{15}{47}$. Then $\alpha^*=\tfrac13(1-\tfrac{15}{47})=\tfrac13\cdot\tfrac{32}{47}=\tfrac{32}{141}$. **All exact.** The direction is worth stating: $\sigma\le\sigma^*\iff\alpha\ge\alpha^*$, since $\alpha$ decreases in $\sigma$; so (3)'s range $\sigma\in[0,\sigma^*]$ is $\alpha\in[\tfrac{32}{141},\tfrac13]$, as (3) says.

**Consistency of the $\sqrt{3/2}$ scaling, which the statement asserts and does not check.** $\frac{3-5\alpha}{\sqrt3}\cdot\sqrt{\tfrac32}=\frac{3-5\alpha}{\sqrt2}=\frac{4+5\sigma^2}{3\sqrt2}$, and $\gamma\cdot\sqrt{\tfrac32}=\sqrt{\tfrac23}\sqrt{\tfrac32}P(W)=P(W)$. So $H_\theta(\sigma)$ is exactly $\sqrt{3/2}$ times the requirement's slack with $P(W)$ replaced by its bound. Both halves of the multiplication are right.

## 2. The expansion (attack 2)

**(a) The coefficients.** With $T$ symmetric and $P(X)=T(X,X,X)$,
$$P(cW_1+\sigma K)=c^3P(W_1)+3c^2\sigma\,T(W_1,W_1,K)+3c\sigma^2\,T(W_1,K,K)+\sigma^3P(K),$$
the two $3$'s being the multinomial coefficients $\binom{3}{2,1}$. Writing $A=T(W_1,W_1,K)$ and $B=T(W_1,K,K)$, the middle two terms are $3c^2\sigma A+3c\sigma^2B$. And $3c^2\sigma\cdot tB=3c^2\sigma\cdot\tfrac\sigma c\cdot B=3c\sigma^2B$: **the identification $3cs^2B=3c^2s\,tB$ is exact**, and it is the only place $t$ is defined by. So $P(W)=c^3P(W_1)+3c^2\sigma[A+tB]+\sigma^3P(K)$, and the displayed form follows the moment $P(W_1)=0$.

**(b) The one convention that could break the factor.** If the record's $T$ were the *unnormalised* polarisation (the one satisfying $P(X)=6T(X,X,X)$, or the one with $\tfrac12(Q(x+y)-Q(x-y))=2T(x,y,\cdot)$), the $3$'s would change. The internal check that fixes the convention: $A=\langle Q(W_1),K\rangle$ under $\langle Q(X),Y\rangle=T(X,X,Y)$, so $\max_K A=\lVert\Pi_{\ker}Q(W_1)\rVert=\sqrt{5/6}$ from the imported norm$^2$ $\tfrac56$, **and that is exactly $V(t)$ on its flat branch.** The statement's $V$ and its $A$ therefore share one convention, and it is the one written above. This is the strongest evidence available for the factor $3$ and I record it as such rather than as an independent proof.

**(c) The normalisation the statement does not declare.** Take *"$V_{1/3}$ eigenspace of $F_u$"* literally as $F_uW_1=\tfrac13W_1$ and $\lVert W\rVert=1$. Then $\alpha=\sqrt{2/3}\cdot\tfrac{c^2}3$ and $1-3\alpha=1-\sqrt{2/3}\,c^2$, which equals $s^2=1-c^2$ only at $c=0$: **the imported $s^2=3\varepsilon$ is false under that reading at every $c\ne0$, and (0) collapses with it.** The alternative repair, keep the raw eigenvalue $\tfrac13$ and set $\lVert W\rVert^2=\theta^*=\sqrt{3/2}$, which does restore $s^2=3\varepsilon$, is worse: $P$ is homogeneous of degree three, so every cubic term in $H_\theta$ would acquire $\lVert W\rVert^3=(3/2)^{3/4}=1.3554\ldots$, while $A$, $B$, $V$ and $\theta$ are all unit-sphere quantities. That factor would multiply $3c^2\sigma V(t)+\sigma^3\theta$ and destroy every number in (2), (3) and (4). **So §0's normalisation is the only one under which the statement is true**, and the statement never says which it is using. I record this as a convention debt rather than a defect: the imported $s^2=3\varepsilon$ selects it uniquely.

**(d) $P(W_1)=0$, does it follow from the decomposition quoted?** As an implication, yes and in one line: $P(W_1)=\langle Q(W_1),W_1\rangle$, $Q(W_1)\in\langle u\rangle\oplus\ker F_u$, and $W_1\in V_{1/3}$ is orthogonal to both summands because $F_u$ is self-adjoint and $1,\tfrac13,0$ are distinct. **The norms $\tfrac16$ and $\tfrac56$ are not needed for it**, mere membership suffices. But see §3 and §11: the membership's $V_{1/3}$ slot *is* the statement $P\equiv0$ on $V_{1/3}$, so the citation is a restatement, not a derivation.

## 3. Whether the step survives the $V_{1/2}$ headline

The brief warns that the record's headline for the decomposition is about $V_{1/2}$. Having formed my verdict first, I looked (§11): the record's [Lemma L101](../findings/route-a.md) is headlined *"$P\equiv0$ on $V_{1/2}$"*, and the $Q(W_1)$ decomposition for $W_1\in V_{1/3}$ lives in an audit note beneath it, where it is assembled from three sources, the $\langle u\rangle$ component at $\theta^*/3$ (forced, norm$^2$ $\tfrac16$), the $V_{1/2}$ component vanishing **by L101 itself**, and *"the remaining components vanish by the table's own rows"*.

**The step survives the mismatch, and acquires a different defect.** L101's $V_{1/2}$ content is genuinely used, it kills one slot of the decomposition, and $V_{1/2}\perp V_{1/3}$ makes that slot a real one, so the headline being about another eigenspace is not by itself an error. What does not survive is the *order of derivation*: among "the remaining components" is the $V_{1/3}$ component of $Q(W_1)$, whose vanishing is the polarised form of $P\equiv0$ on $V_{1/3}$. **So the statement's *"because $P(W_1)=0$ on $V_{1/3}$"* cites, as its reason, a decomposition one of whose slots is that very fact.** The reason is not false and the circle is not vicious (the fact is on the record independently, as a table row) but it is a restatement, and it hides where the warrant actually sits. §11 says where.

## 4. The direction of the bound (attack 3)

Let $\Gamma=\sqrt{3/2}\,\gamma_{\max}(\alpha)=\max P(W)$ over admissible $W$ at that $\alpha$. For each admissible $K$,
$$P(W)=3c^2\sigma[A(K)+tB(K)]+\sigma^3P(K)\ \le\ 3c^2\sigma\max_{K'}[A+tB]+\sigma^3\max_{K''}P(K'')\ \le\ 3c^2\sigma V(t)+\sigma^3\theta,$$
because $3c^2\sigma\ge0$ and $\sigma^3\ge0$, **both nonnegativity facts are needed and both hold**, and the two maxima may be attained at different $K$ without harming the inequality, since a sum of maxima dominates the maximum of the sum. Hence $\Gamma\le3c^2\sigma V(t)+\sigma^3\theta$, and
$$H_\theta(\sigma)=\tfrac{4+5\sigma^2}{3\sqrt2}-\big[3c^2\sigma V(t)+\sigma^3\theta\big]\ \le\ \tfrac{4+5\sigma^2}{3\sqrt2}-\Gamma=\sqrt{\tfrac32}\Big[\tfrac{3-5\alpha}{\sqrt3}-\gamma_{\max}\Big].$$
**So $H_\theta>0$ implies the requirement, and $H_\theta\le0$ implies nothing.** (1)'s sentence *"so $H_\theta$ bounds $\gamma_{\max}$ from **above**"* is false on its face, $H_\theta$ is a slack, not a value of $\gamma$, and what it bounds it bounds from *below*. The intent is plainly *"the construction bounds $\gamma_{\max}$ from above"*, which is what the display proves, and every downstream use of (1) is in the sufficient direction. **I record it as a wrong word, not a wrong step**, but it is the same word confusion that (4) then commits with consequences (§10).

## 5. The collection, and the tangency (attack 4)

$3\sqrt{\tfrac56}=\tfrac{3\sqrt5}{\sqrt6}=\tfrac{3\sqrt{30}}6=\tfrac{\sqrt{30}}2$. **Exact.** So on $\sigma\le\sigma^*$, $3c^2\sigma V(t)=3\sqrt{\tfrac56}\,\sigma(1-\sigma^2)=\tfrac{\sqrt{30}}2\sigma(1-\sigma^2)$.

On $\sigma\ge\sigma^*$, with $t=\sigma/c$: $3c^2\sigma\cdot\tfrac5{16t}=3c^2\sigma\cdot\tfrac{5c}{16\sigma}=\tfrac{15c^3}{16}$ and $3c^2\sigma\cdot\tfrac{2t}3=2c^2\sigma\cdot\tfrac\sigma c=2c\sigma^2$. Then
$$\tfrac{15}{16}c^3+2c\sigma^2=\tfrac{c}{16}\big(15c^2+32\sigma^2\big)=\tfrac{c}{16}\big(15-15\sigma^2+32\sigma^2\big)=\tfrac{c(15+17\sigma^2)}{16}=\tfrac{\sqrt{1-\sigma^2}\,(15+17\sigma^2)}{16}.$$
**Exact**, and the $17$ is $32-15$, which is where a sign slip would land.

**The meeting at $\sigma^*$.** $V_2(t)=\tfrac5{16t}+\tfrac{2t}3$ has $V_2'(t)=-\tfrac5{16t^2}+\tfrac23$, zero exactly at $t^2=\tfrac{15}{32}$, i.e. $t=\tfrac{\sqrt{30}}8=t^*$, **so $t^*$ is not an arbitrary crossing but the minimiser of the second branch.** There $V_2(t^*)=\tfrac5{2\sqrt{30}}+\tfrac{\sqrt{30}}{12}=\tfrac{\sqrt{30}}{12}+\tfrac{\sqrt{30}}{12}=\tfrac{\sqrt{30}}6=\sqrt{\tfrac56}$. Hence $V$ is continuous **and** $C^1$ at $t^*$, with $V_2>\sqrt{5/6}$ on both sides, so $V$ is the constant on $[0,t^*]$ and rises after, nondecreasing throughout. Substituting $\sigma^{*2}=\tfrac{15}{47}$ into both branch formulas gives $\tfrac{240\sqrt{94}}{2209}$ from each. **No mismatch; the tangency is real, and it is the reason $t^*$ is where it is.**

## 6. The discriminant (attack 5)

$(a,b,c,d)=(3\sqrt{15}-6,\,5,\,-3\sqrt{15},\,4)$, from scratch, term by term:

| term | value |
|---|---|
| $18abcd$ | $18\cdot5\cdot4\cdot(-3\sqrt{15})(3\sqrt{15}-6)=360(-135+18\sqrt{15})=-48600+6480\sqrt{15}$ |
| $-4b^3d$ | $-4\cdot125\cdot4=-2000$ |
| $b^2c^2$ | $25\cdot135=3375$ |
| $-4ac^3$ | $-4(3\sqrt{15}-6)(-405\sqrt{15})=1620\sqrt{15}(3\sqrt{15}-6)=72900-9720\sqrt{15}$ |
| $-27a^2d^2$ | $-432(171-36\sqrt{15})=-73872+15552\sqrt{15}$ |

Rational part $-48600-2000+3375+72900-73872=-48197$; surd part $6480-9720+15552=12312$. **$\Delta=12312\sqrt{15}-48197$, exactly as claimed.** Sign: $12312\sqrt{15}<48197\iff15\cdot12312^2<48197^2$, and $12312^2=151{,}585{,}344$ so the left side is $2{,}273{,}780{,}160$, while $48197^2=2{,}322{,}950{,}809$. **$\Delta<0$**, confirmed, and by a margin of $49{,}170{,}649$ rather than a hair.

**The sign convention.** For $a\sigma^3+b\sigma^2+c\sigma+d$ over $\mathbb R$ with $a\ne0$, this $\Delta$ is $a^4\prod_{i<j}(r_i-r_j)^2$; it is positive for three distinct real roots, zero for a repeated root, negative for one real and two complex-conjugate roots. The formula quoted in the brief is that discriminant, so **$\Delta<0$ does mean one real root in the convention being used**, no sign flip, and no confusion with the $-27a^2d^2$-carrying "depressed" variant, which agrees anyway.

**From one real root to positivity on $\sigma\ge0$, completed two ways.** (i) $a=3\sqrt{15}-6>0$ since $\sqrt{15}>2$; the unique real root $r$ is simple ($\Delta\ne0$), so $p<0$ on $(-\infty,r)$ and $p>0$ on $(r,\infty)$; $p(0)=4>0$ forces $0>r$, hence $p>0$ on all of $[0,\infty)$. (ii) Independently, $r\lvert z\rvert^2=-d/a=-4/(3\sqrt{15}-6)<0$ with $\lvert z\rvert^2>0$, so $r<0$ directly. **The argument as written is complete**, and (ii) is the shorter route if the record wants one.

## 7. $\theta<\sqrt2$ at both parities (attack 8, 9)

Even: $\theta_0(n)^2=\frac{2(n-1)(n-2)}{n^2}=\frac{2n^2-6n+4}{n^2}=2-\frac{2(3n-2)}{n^2}$ (**the brief's rearrangement is exact**) so $\theta_0(n)^2<2$ for every $n\ge1$, and $\frac{d}{dn}\theta_0^2=\frac{2(3n-4)}{n^3}>0$ for $n\ge2$: **increasing to $\sqrt2$ needs $n\ge2$**, no more.

Odd: $(n-1)(n-3)-(n+1)(n-2)=(n^2-4n+3)-(n^2-n-2)=5-3n<0$ for $n\ge2$, **exact**. Converting that into $\tilde\theta_0(n)^2<2$ needs $(n+1)(n-2)>0$, i.e. $n>2$, an unstated side condition, harmless at $n\ge12$ but real: at $n=2$ the quotient is $+\infty\cdot$ nonsense and at $n$ below $3$ the inequality would reverse. Monotone too: $\frac{d}{dn}\tilde\theta_0^2=\frac{2(3n^2-10n+11)}{(n+1)^2(n-2)^2}$ and $3n^2-10n+11$ has discriminant $100-132<0$, so it is positive always, $\tilde\theta_0^2$ increases to $2$ on $n>2$.

**The gap between $\theta$ and $\theta_0$ is where the debt is.** (3) needs only $\theta\le\theta_0<\sqrt2$, an inequality, and gets it. (4) needs the reverse, and does not, §10.

## 8. Monotonicity in $\theta$ (attack 6)

$\partial_\theta\big[3\sqrt2H_\theta(\sigma)\big]=-3\sqrt2\,\sigma^3$, which is $\le0$ **exactly when $\sigma\ge0$**. So for $\theta\le\sqrt2$ and $\sigma\ge0$, $p_\theta(\sigma)\ge p_{\sqrt2}(\sigma)$, and positivity of $p_{\sqrt2}$ on $[0,\infty)$ transfers to every $\theta\le\sqrt2$. **Right, and it uses $\sigma\ge0$ in the only place it should.** On $\sigma<0$ the inequality reverses and the whole argument would fail, which matters not at all here, since $\sigma=\sin\beta\ge0$, but is worth the half sentence the statement does not spend. The claim is about the $\sigma^3$ coefficient only, and the other three coefficients are $\theta$-free, so nothing else can interfere.

## 9. Trying to break (3) (attacks 9, 10)

$p_{\sqrt2}(\sigma)=(3\sqrt{15}-6)\sigma^3+5\sigma^2-3\sqrt{15}\sigma+4$ has no real root on $[0,\infty)$ by §6, so the universal claim over $\sigma\in[0,\sigma^*]$ cannot be broken by a $\sigma$. **How close it comes is worth recording.** $p_{\sqrt2}'(\sigma)=3(3\sqrt{15}-6)\sigma^2+10\sigma-3\sqrt{15}$ vanishes on $\sigma>0$ at
$$\sigma_{\min}=\frac{-10+\sqrt{1720-216\sqrt{15}}}{18\sqrt{15}-36}=0.5850038525\ldots,\qquad p_{\sqrt2}(\sigma_{\min})=0.0389621557\ldots$$
against $p(0)=4$, **a margin of about one part in a hundred of the constant term.** And $\sigma_{\min}>\sigma^*=\sqrt{15/47}=0.5649\ldots$, so on the interval that (3) claims, $p_{\sqrt2}$ is decreasing and its minimum is the endpoint: $p_{\sqrt2}(\sigma^*)=0.0449036337\ldots$. Both numbers are exact algebraic quantities I evaluated symbolically; neither is a residual. The thinness is why the discriminant is needed at all, a cruder positivity argument (say, dropping the $\sigma^3$ term) fails here.

**Over $n$ the claim cannot be broken either**, because $n$ enters (3) only through $\theta\le\theta_0(n)<\sqrt2$, uniformly at both parities by §7, and the cubic's dependence on $\theta$ is monotone by §8. There is no dimension at which $\theta_0$ or $\tilde\theta_0$ reaches $\sqrt2$.

**What the claim is, once the imports are named.** (3) proves: *if* $V(t)$ is as displayed, *if* the maximiser has $c_0=1$ and $s^2=3\varepsilon$, and *if* $\theta\le\theta_0(n)$, then the requirement holds on $\alpha\in[\tfrac{32}{141},\tfrac13)$ at every $n\ge3$ and both parities. The bolded sentence in (3) states the conclusion and none of the three conditions. §11 says what each is worth.

## 10. The witness (attacks 7, 11)

**The arithmetic, recomputed from (2).** $\sigma=\tfrac34$: $\sigma^2=\tfrac9{16}$, and $\tfrac9{16}>\tfrac{15}{47}$ because $9\cdot47=423>240=15\cdot16$, **the branch used is the right one**. $c^2=\tfrac7{16}$, $c=\tfrac{\sqrt7}4$. Then $4+5\cdot\tfrac9{16}=\tfrac{109}{16}$, so the first term is $\tfrac{109}{48\sqrt2}=\tfrac{109\sqrt2}{96}$. And $15+17\cdot\tfrac9{16}=\tfrac{393}{16}$, so the second is $\tfrac{\sqrt7}4\cdot\tfrac{393}{16}\cdot\tfrac1{16}=\tfrac{393\sqrt7}{1024}$. With $\sigma^3=\tfrac{27}{64}$,
$$H_\theta(\tfrac34)=\tfrac{109\sqrt2}{96}-\tfrac{393\sqrt7}{1024}-\tfrac{27}{64}\theta,\qquad H_\theta(\tfrac34)>0\iff\theta<\tfrac{64}{27}\Big(\tfrac{109\sqrt2}{96}-\tfrac{393\sqrt7}{1024}\Big)=\tfrac{218\sqrt2}{81}-\tfrac{131\sqrt7}{144}.$$
**Both reductions exact**, $\tfrac{64}{96}=\tfrac23$ giving $\tfrac{218}{81}$, and $\tfrac{64}{1024}=\tfrac1{16}$ giving $\tfrac{393}{432}=\tfrac{131}{144}$. Value $1.39925625757\ldots$, and $\alpha=\tfrac13(1-\tfrac9{16})=\tfrac7{48}$ as claimed.

**$\Theta_{3/4}<\sqrt2$, exactly.** $\tfrac{218\sqrt2}{81}-\sqrt2=\tfrac{137\sqrt2}{81}$, so the claim is $\tfrac{137\sqrt2}{81}<\tfrac{131\sqrt7}{144}$, i.e. $19728\sqrt2<10611\sqrt7$, i.e. $778{,}387{,}968<788{,}153{,}247$. **True**, with $\tfrac{2-\Theta_{3/4}^2}{1}=0.04208\ldots$ of room, where $\Theta_{3/4}^2=\tfrac{95048}{6561}+\tfrac{120127}{20736}-\tfrac{57116\sqrt{14}}{11664}$.

**The crossing, and where it happens.** $\theta_0(n)^2>\Theta_{3/4}^2$ first at an even $n$ between $140$ and $142$: $\theta_0(140)^2=\tfrac{9591}{4900}=1.9573469\ldots<\Theta_{3/4}^2=1.9579181\ldots<\tfrac{9870}{5041}=1.9579449\ldots=\theta_0(142)^2$. Odd, between $141$ and $143$: $\tilde\theta_0(141)^2=\tfrac{19320}{9869}=1.9576452\ldots<\Theta_{3/4}^2<\tfrac{2485}{1269}=1.9582348\ldots=\tilde\theta_0(143)^2$. **So *"once $n$ is large enough"* means $n\ge142$ (even), $n\ge143$ (odd).** At $n=12$, the smallest dimension in scope, $\theta_0(12)=\sqrt{55/36}=1.2360\ldots$, comfortably below $\Theta_{3/4}$, **so the obstruction (4) points at is invisible at every dimension the surrounding block is measured at, and the bound in fact reaches $\alpha=\tfrac7{48}$ there.** The statement does not say this, and it is the single most useful number in (4).

**Now the two defects.**

*First, the iff.* *"the requirement at $\alpha=\tfrac7{48}$ holds exactly when $\theta<\Theta_{3/4}$"*. By §4, $H_\theta(\tfrac34)>0\Rightarrow$ requirement, and the converse is unavailable: the bound charges $\max_K[A+tB]$ and $\max_{K}P(K)$ at possibly different $K$, so $H_\theta(\tfrac34)\le0$ is consistent with a comfortable margin in the requirement itself. **Locating it exactly**: the word *"exactly"* in (4), first sentence. **Exhibiting the failure in closed form**: suppose the $A$-maximiser $K_A$ and the $P$-maximiser $K_P$ are orthogonal with $P(K_A)=0$; then the true maximum of $P(W)$ at $\sigma=\tfrac34$ over the two-parameter family $K=\cos\psi K_A+\sin\psi K_P$ is at most $3c^2\sigma V(t)\cos\psi+\sigma^3\theta\sin^3\psi$, whose maximum over $\psi$ is strictly below the sum of the two maxima whenever both terms are nonzero, the bound is strictly lossy on any such configuration, and nothing in the setting excludes it. **Arguing the opposite**: the strongest reading is that *"the requirement"* abbreviates *"the requirement as bounded here"*, i.e. $H_\theta(\tfrac34)>0$, under which the sentence is a correct restatement of the display. That reading is available and is probably intended. It does not rescue the second defect.

*Second, and this survives every reading.* The bolded conclusion needs $H_{\theta}(\tfrac34)\le0$ at the **true** $\theta$, and what §7 supplies is $\theta\le\theta_0(n)$. From $\theta_0(n)\ge\Theta_{3/4}$ one gets $H_{\theta_0(n)}(\tfrac34)\le0$, a statement about a number that is only an **upper bound** for $\theta$, and $H$ is *decreasing* in $\theta$, so this is exactly the direction that carries nothing. **Locating it**: (4), second sentence, the step from *"$\theta_0(n)$ crosses $\Theta_{3/4}$"* to *"the reach stops"*. **The hypothesis it lacks**: $\theta=\theta_0(n)$, i.e. attainment of the sphere-product value by $\sup\{P(K):K\in\ker F_u\}$ at this competitor. **Concretely**: if $\theta\le1.39$ uniformly in $n$ (nothing on the record forbids it, $\ker F_u$ being a proper subspace at one critical point) then $H_\theta(\tfrac34)>0$ at every $n$ and (4)'s conclusion is simply false while every displayed formula in (4) stays true. **Arguing the opposite**: one could read *"the reach"* as *"the reach of the bound as the record instantiates it, with $\theta_0(n)$ substituted"*, which is a true statement about a formula. But (4) says *"the reach downward from $\tfrac13$ stops"*, and a reach that stops is a claim about what can be proved, not about which constant was plugged in. **The repair is one clause**: *"once $n\ge142$, the bound with $\theta_0(n)$ in place of $\theta$ no longer reaches $\alpha=\tfrac7{48}$"*.

**What would falsify the statement, and what I did to look for it.** Four objects, and I looked for each analytically only, as the standing rule requires. (i) A unit $K\in\ker F_u$ with $P(K)\ge\sqrt2$, this would break (3) outright; §7 shows no $n$ and no parity permits it *given* $\theta\le\theta_0$, so the falsifier would have to break that import instead, and I did not search for one. (ii) A $\sigma\in[0,\sigma^*]$ with $p_{\sqrt2}(\sigma)\le0$, excluded by §6 and located by §9, the true minimum being $0.0389\ldots$ at $\sigma=0.5850\ldots$, outside the interval. (iii) A unit $W_1\in V_{1/3}$ with $P(W_1)\ne0$, or a $K$ with $A+tB>V(t)$ at some $t\le t^*$, either restores the $c^3$ term or raises the flat branch, and both are imports rather than claims of this statement; §11 records that the second is precisely what Observation L102 is measured to exclude. (iv) A competitor whose maximiser has $c_0<1$, putting weight on the strictly negative part of $F_u$, the expansion has no term for it. **I constructed no numerical object and ran no search**; the only compute was exact symbolic re-evaluation of identities I had already derived by hand, which is what the screening allowance covers.

## 11. Provenance, read after the verdicts were fixed

| import | where it sits on the record | what it is worth |
|---|---|---|
| $Q(W_1)\in\langle u\rangle\oplus\ker F_u$, norms$^2$ $\tfrac16,\tfrac56$ | audit note under [Lemma L101](../findings/route-a.md) | assembled from the forced $\langle u\rangle$ slot, L101's $V_{1/2}$ slot, and **table rows measured at $n=10$ in floating point** |
| $\sup T(W_1,W_1,K)=\sqrt{5/6}$ | same table | the record's own audit says *"exhaustively verified licenses the vanishings and not the suprema"*, $78$ basis vectors do not sample a $78$-sphere |
| $\sup T(W_1,K,K)=\tfrac23$, the $\tfrac{2t}3$ in $V$ | same table | same caveat |
| $V(t)$'s split of $K$ | needs [Observation L102](../findings/route-a.md), $M_{W_1}\Pi_{\ker}Q(W_1)=0$ | measured at $n=12,14,16$; **the record states it in two inequivalent forms, and the weaker one destroys $V(t)$** |
| $\theta\le\theta_0(n)$ | [Observation L22](../results.md) | an inequality *"weaker than Conjecture A and carrying its inequality half"*; **no attainment**, which is exactly what (4) needs |
| $c_0=1$, $s^2=3\varepsilon$ | the maximiser analysis in [route-a.md](../findings/route-a.md) | forced at the coupled bound's maximiser, on the record |

**So (3)'s *"at every $n$ and both parities"* is not honest about its scope.** The quantifier over $n$ is genuine for the *algebra* (§7 and §8 hold at every $n\ge3$) and is borrowed for everything else: $V(t)$ is licensed at $n=12,14,16$ in floating point, its constants at $n=10$, and $\theta\le\theta_0$ is an inequality that carries Conjecture A's own half. The statement inherits all of it and declares none of it. That is a scope defect in the writing rather than an error in the mathematics, and it is the reason for the overall verdict below rather than a clean `PROVEN`.

## Overall verdict

**HYPOTHESIS-DEBT.**

Every displayed identity in (0)–(4) is exactly right, and I confirmed each independently: the change of variable, the expansion and its factors of $3$, both branch collections, the tangency at $t^*$, the cubic, the discriminant term by term, the integer comparison, the monotonicity, and both closed forms in (4). The mathematics of (3) is a complete proof of its conclusion **from its imports**, and I could not break it.

What has to be repaired, in decreasing order of consequence:

1. **(4)'s conclusion has no argument on file.** It requires $\theta=\theta_0(n)$; the record carries $\theta\le\theta_0(n)$, and $H$ is decreasing in $\theta$, so the substitution runs the wrong way. **What would have to be proved**: that $\sup\{P(K):K\in\ker F_u,\lVert K\rVert=1\}$ is *attained at* $\theta_0(n)$ at this competitor, an attainment statement, not the bound the record has. Failing that, (4) states a property of the bound and must say so.
2. **(4)'s *"exactly when"* is a one-way implication.** Two separate maximisations are charged at possibly different $K$; the converse is unavailable.
3. **(3)'s *"at every $n$"* imports four facts licensed at $n=10,12,14,16$ in floating point and one inequality carrying Conjecture A's half, and names none of them.**
4. **(1)'s *"$H_\theta$ bounds $\gamma_{\max}$ from above"* is written backwards** ($H_\theta$ is a lower bound on the slack) and *"because $P(W_1)=0$ on $V_{1/3}$"* cites a decomposition whose $V_{1/3}$ slot is that same fact.
5. **The normalisation $\lVert W\rVert=1$ with $\alpha|_{V_{1/3}}=\tfrac13$ is load-bearing and undeclared**; the literal reading of *"$V_{1/3}$ eigenspace of $F_u$"* makes the imported $s^2=3\varepsilon$ false, and the repair that saves it inserts $(3/2)^{3/4}$ on every cubic term.

Two additions the record should keep: the crossing in (4) is at $n\ge142$ (even) and $n\ge143$ (odd), so the obstruction is invisible at every dimension the block is measured at; and $\min_{\sigma\ge0}3\sqrt2H_{\sqrt2}=0.0389\ldots$ at $\sigma=0.5850\ldots$, just outside $[0,\sigma^*]$, so (3) is true with about one percent of the constant term to spare and no cruder positivity argument will do.

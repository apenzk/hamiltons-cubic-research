# r742, Gate 2 on Lemma L165: the frontier requirement in closed form

*Cold review from [BRIEF-g2-l165.md](BRIEF-g2-l165.md), formed on every claim before any file of the record was opened. **No numerical work was done**: every value below is exact (rational, or in $\mathbb Q(\sqrt2,\sqrt7,\sqrt{15},\sqrt{30})$) and the three places where a decimal appears are screens of a claim being recorded, marked as screens. Log: [agent_logs/g2-l165-r742.log](../agent_logs/g2-l165-r742.log).*

| # | claim | verdict |
| --- | --- | --- |
| 1 | $\sigma=s=\sin\beta$ forced; $3-5\alpha=\tfrac13(4+5\sigma^2)$ | **CONFIRMED**, and forced twice over, $\alpha=c^2/3$ exactly, the $\sqrt{2/3}$ of $\alpha$ cancelling the $\theta^*/3$ eigenvalue |
| 2 | $\sigma^{*2}=15/47$ from $t^{*2}=15/32$, hence $\alpha^*=32/141$ | **CONFIRMED**, exact |
| 3 | $P(W)=3c^2\sigma[A+tB]+\sigma^3P(K)$, factor $3$ and $3cs^2B=3c^2s\,tB$ | **CONFIRMED**, every coefficient |
| 4 | $P(W_1)=0$ on $V_{1/3}$ from the quoted decomposition | **CONFIRMED as an implication, and the citation survives the $V_{1/2}$ mismatch**, but it needs only *one row* of the decomposition, and that row is [L101](../findings/route-a.md)'s unproved numerics |
| 5 | $H_\theta$ bounds $\gamma_{\max}$ from above | **CONFIRMED**, one-directional, and the brief's (1) has dropped the record's own caveat saying so |
| 6 | $\tfrac{15}{16}c^3+2c\sigma^2=\tfrac{c(15+17\sigma^2)}{16}$; $3\sqrt{5/6}=\tfrac{\sqrt{30}}2$; branches meet at $\sigma^*$ | **CONFIRMED**, and the meeting is tangential in $\sigma$ as well as in $t$ |
| 7 | $3\sqrt2H_\theta=(3\sqrt{15}-3\sqrt2\theta)\sigma^3+5\sigma^2-3\sqrt{15}\sigma+4$ | **CONFIRMED**, exact |
| 8 | $\Delta=12312\sqrt{15}-48197<0$, and $15\cdot12312^2<48197^2$ | **CONFIRMED from scratch**; sign convention checked, $\Delta<0$ is one real root |
| 9 | one real root $\Rightarrow$ positive on $\sigma\ge0$ | **CONFIRMED and complete**; the unique real root is $\sigma=-2.0608\ldots$ |
| 10 | monotone in $\theta$ because $\sigma^3\ge0$ | **CONFIRMED**, and $\sigma\ge0$ is used exactly where it must be |
| 11 | $\theta<\sqrt2$ at both parities | **CONFIRMED**, both formulas, at every $n\ge3$ |
| 12 | $H_\theta(\tfrac34)$ and $\Theta_{3/4}=\tfrac{218\sqrt2}{81}-\tfrac{131\sqrt7}{144}<\sqrt2$ | **CONFIRMED**, exact; $\Theta_{3/4}<\sqrt2$ reduces to $778{,}387{,}968<788{,}153{,}247$ |
| 13 | $\tfrac9{16}>\tfrac{15}{47}$, so $\sigma=\tfrac34$ is on the stated branch | **CONFIRMED**, $423>240$ |
| 14 | *"the requirement at $\alpha=\tfrac7{48}$ holds **exactly when** $\theta<\Theta_{3/4}$"* | **REFUTED as an equivalence**, one direction only, and the record contradicts it two paragraphs above |
| 15 | $\theta_0(n)$ crosses $\Theta_{3/4}$, so the reach stops at some $\alpha\ge\tfrac7{48}$ | **CONFIRMED under the headline's reading** ("no single constant carries the other piece"); as *"the bound fails"* it silently substitutes an upper bound for the constant itself |
| 16 | inherited-hypothesis list ($c_0=1$, $\lambda=\tfrac23$, the vanishing at three dimensions) | **INCOMPLETE, two more inputs, and one of them is Conjecture A** |

**Actionable summary: the mathematics is right in every line and every displayed constant is exact; replace *"holds exactly when"* in (4) by *"is certified exactly when"*, and add to the inherited list that $\theta\le\Theta_n$ is Conjecture A restricted to $\ker F_u$ and that $P(W_1)=0$ rests on one numerically-measured row of [L101](../findings/route-a.md)'s table.**

## 0. Conventions, fixed once

$T$ is the fully symmetric trilinear form $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ of [conventions.md](../findings/conventions.md), $Q(X)=X\circ X$, and $P(X)=T(X,X,X)=\langle Q(X),X\rangle$. $F_u$ is the linearisation of $Q$ at the competitor $u$, symmetric, with $\theta^*=\sqrt{3/2}$; $V_\mu$ denotes the $\mu\theta^*$-eigenspace, so $V_{1/3}$ carries eigenvalue $\theta^*/3$ and $\ker F_u=V_0$. $W=cW_1+\sigma K$ is a unit vector with $W_1\in V_{1/3}$, $K\in\ker F_u$, both unit, $c^2+\sigma^2=1$, $c=\cos\beta\ge0$, $\sigma=\sin\beta\ge0$, $t=\sigma/c$. $\theta=\sup\{P(K):K\in\ker F_u,\lVert K\rVert=1\}$. $\Theta_n$ is the diagonal maximum, equal to $\theta_0(n)$ at even $n$ and to $\tilde\theta_0(n)$ at odd $n$. For a cubic $a\sigma^3+b\sigma^2+c\sigma+d$ the discriminant is $\Delta=18abcd-4b^3d+b^2c^2-4ac^3-27a^2d^2$, in the convention where $\Delta>0$ is three distinct real roots and $\Delta<0$ is one real and two conjugate.

**Screening allowance, as exercised.** Three quantities below are screens in the sense the brief permits, seconds of exact symbolic arithmetic on objects constructed for the purpose, reported as screens: the location of the free minimum of $\Psi_{\sqrt2}$, the crossing dimension of $\theta_0$ against $\Theta_{3/4}$, and the coverage endpoint at $\theta=\sqrt2$. **None of them carries a positive claim.** Every claim in the table is settled by closed-form identity or by an integer comparison, and both are reproduced in full below.

## Hypothesis inventory

**Used by the statement, and named by it:**

| hypothesis | where consumed | status |
| --- | --- | --- |
| $s^2=3\varepsilon$ (equivalently $W$ confined to $V_{1/3}\oplus\ker F_u$ at the maximiser) | the change of variable; **everything downstream** | [L22](../findings/route-a.md), and it rests on $c_0=1$, asserted |
| $V(t)$ as displayed, with $a=\sqrt{5/6}$ and $\lambda=\tfrac23$ | both branches of $3c^2\sigma V(t)$ | $a$ derived in [L101](../findings/route-a.md) from measured rows; $\lambda=\tfrac23$ has no derivation |
| $P(W_1)=0$ for $W_1\in V_{1/3}$ | the absence of the $c^3$ term | needs one row of [L101](../findings/route-a.md)'s table, see §2 |
| $\theta\le\Theta_n$ | (a)'s $\theta<\sqrt2$, and (b)'s crossing | **Conjecture A restricted to $\ker F_u$; not listed by the statement** |
| $\sigma\ge0$ | the monotonicity in $\theta$, and the sign step in the root argument | free, from $\sigma=\sin\beta$ with $\beta\in[0,\pi/2]$ |
| $F_u$ symmetric, $u\perp V_{1/3}$, $\ker F_u\perp V_{1/3}$ | $P(W_1)=0$ | free, distinct eigenvalues of a symmetric operator |

**Stated and NOT used.** The dimension range $n\ge12$ is used nowhere in the algebra: (0)–(3) hold for any $\theta\le\sqrt2$ whatever $n$ is, and (4) is a single closed-form evaluation. $n$ enters only through the *value* of $\Theta_n$, and there only to decide whether $\Theta_n<\Theta_{3/4}$. Likewise the parity split is used only to check $\theta<\sqrt2$ twice; both checks are one line and neither needs $n\ge12$. **And $M_{W_1}\Pi_{\ker}Q(W_1)=0$ is used nowhere in L165 itself**, it is upstream, inside the derivation of $V(t)$, which L165 takes as given.

## 1. The change of variable (brief item 1)

**Forced, and by a cancellation the statement does not display.** [L22](../findings/route-a.md) puts $W_1$ in the $\tfrac13\theta^*$-eigenspace and the maximiser's $W_2$ entirely in $\ker F_u$. Then

$$\alpha=\sqrt{2/3}\,\langle F_uW,W\rangle=\sqrt{2/3}\cdot\tfrac{\theta^*}{3}c^2=\sqrt{\tfrac23}\cdot\tfrac13\sqrt{\tfrac32}\,c^2=\tfrac{c^2}{3},$$

the two radicals cancelling exactly. Hence $\varepsilon=\tfrac13-\alpha=\tfrac13(1-c^2)=\tfrac{s^2}3$, which **is** the equality $s^2=3\varepsilon$, and $\sigma^2=1-3\alpha=1-c^2=s^2$ with $\sigma,s\ge0$. So $\sigma=s=\sin\beta$ is forced, not chosen. The identity is then arithmetic:

$$3-5\alpha=3-\tfrac53(1-\sigma^2)=\tfrac{9-5+5\sigma^2}3=\tfrac{4+5\sigma^2}3 .$$

**The branch point transcribes.** $t^{*2}=\tfrac{30}{64}=\tfrac{15}{32}$, and $\sigma^2=t^2/(1+t^2)$ inverts $t=\sigma/c$ on $c>0$, so $\sigma^{*2}=\frac{15/32}{47/32}=\tfrac{15}{47}$ and $\alpha^*=\tfrac13(1-\tfrac{15}{47})=\tfrac13\cdot\tfrac{32}{47}=\tfrac{32}{141}$. **Both exact.** The multiplication of the requirement by $\sqrt{3/2}$ is likewise exact: $\frac{3-5\alpha}{\sqrt3}\cdot\sqrt{\tfrac32}=\frac{4+5\sigma^2}{3\sqrt3}\sqrt{\tfrac32}=\frac{4+5\sigma^2}{3\sqrt2}$, and $\gamma\sqrt{3/2}=P(W)$, so $H_\theta>0$ is the requirement with $P(W)$ replaced by its upper bound.

## 2. The expansion, and whether $P(W_1)=0$ survives the $V_{1/2}$ headline (brief item 2)

**The expansion is right in every coefficient.** $T$ is fully symmetric, so with $W=cW_1+\sigma K$,

$$P(W)=T(W,W,W)=c^3P(W_1)+3c^2\sigma\,T(W_1,W_1,K)+3c\sigma^2\,T(W_1,K,K)+\sigma^3P(K),$$

the two $3$'s being the multinomial coefficients $\binom{3}{2,1}$. The identification is exact: $3c\sigma^2B=3c^2\sigma\cdot\frac{\sigma}{c}\cdot B=3c^2\sigma\,tB$ for $c>0$. **So $P(W)=c^3P(W_1)+3c^2\sigma[A+tB]+\sigma^3P(K)$, and the display is the $P(W_1)=0$ case of it.**

**The step is a genuine consequence of the decomposition as quoted.** $P(W_1)=\langle Q(W_1),W_1\rangle$. Both $\langle u\rangle$ and $\ker F_u$ are $F_u$-eigenspaces at eigenvalues $\theta^*$ and $0$, distinct from $\theta^*/3$; $F_u$ is symmetric, so both are orthogonal to $V_{1/3}\ni W_1$. Hence $Q(W_1)\in\langle u\rangle\oplus\ker F_u$ gives $\langle Q(W_1),W_1\rangle=0$ directly. **It needs nothing else**, in particular it needs neither of the norms $\tfrac16$ and $\tfrac56$, which enter only through $V(t)$'s constant.

**The $V_{1/2}$ headline is not the difficulty, and the citation is sound.** [L101](../findings/route-a.md)'s headline result is *$P\equiv0$ on $V_{1/2}$*, a different eigenspace, and that clause is never used here. What L165 cites is a distinct clause of the same block (the decomposition of $Q(W_1)$ for unit $W_1\in V_{1/3}$) and that clause is where the reviewers of L101 put the closed form $\sqrt{1-\theta^{*2}/9}$. **So the step survives the mismatch.**

**What it does not survive is the status of that clause, and here the statement is silent.** L101's own Gate 2 verdict is **GAP**, and the decomposition it supplies is assembled from three parts of unequal standing: the $\langle u\rangle$ component at $\theta^*/3$ is forced; the $V_{1/2}$ component vanishes by L101's orbit-orthogonality **together with $V_{1/2}\subseteq T_u\mathcal O$**, held at $n\ge9$ by citation; and *"the remaining components vanish by the table's own rows"*, measured, not proved, and L101 records that the containment **fails on four rows at other eigenspaces**, $Q(x)$ having a $0.29$ component in $V_{1/3}$ for $x\in V_{-1/6}$. **So the vanishing is specific to $V_{1/3}$ and is a measurement.**

**A sharpening that reduces the debt.** $P(W_1)=0$ needs only $\Pi_{V_{1/3}}Q(W_1)\perp W_1$ (one entry of L101's table) and not the full containment in $\langle u\rangle\oplus\ker F_u$, and not the $\tfrac16,\tfrac56$ split. Citing the whole decomposition where one row suffices makes this step look as heavily conditioned as $V(t)$'s constant, which it is not. **Recording the weaker hypothesis would isolate exactly which measurement the $c^3$ term rests on.**

## 3. The direction of the bound (brief item 3)

**The bound is genuinely an upper bound, and it is one-directional.** For $\sigma\in[0,1]$ both $3c^2\sigma\ge0$ and $\sigma^3\ge0$, so from §2,

$$P(W)=3c^2\sigma[A+tB]+\sigma^3P(K)\ \le\ 3c^2\sigma\max_{K'}[A+tB]+\sigma^3\theta=3c^2\sigma V(t)+\sigma^3\theta,$$

the two maxima being taken at possibly different $K$. **The nonnegativity of both prefactors is exactly what licenses the split**, and it is available because $\sigma=\sin\beta\ge0$. Hence $H_\theta(\sigma)>0$ implies $\frac{4+5\sigma^2}{3\sqrt2}>P(W)$ for every admissible $W$ at that $\alpha$, which is the requirement.

**The converse fails, and the brief's (1) has lost the sentence that says so.** $H_\theta\le0$ says the *bound* no longer clears the requirement; it says nothing about $\gamma_{\max}$, because the bound is slack by however far apart the two maximisers sit. The record's own L165 states this correctly (*"its failure shows the record's bound does not establish the requirement), not that the requirement itself fails"*, and the brief's paraphrase of (1) drops that clause. **The claim as quoted in the brief therefore makes no assertion about the direction of failure, and the record's assertion is right.** This matters at §7, where the record then contradicts itself.

**One imported fact, flagged rather than checked.** $V(t)=\max_K[A+tB]$ is stated with no $W_1$-dependence, while $A$ and $B$ both depend on $W_1$. [L22](../findings/route-a.md) supplies the missing step (*"both suprema are attained at the same $W_1$"*) so the maximisation over $W_1$ is genuinely absorbed. **L165 consumes that and does not name it**, and it is a real hypothesis: were the two suprema attained at different $W_1$, the displayed $V$ would be an over-count in one variable and the bound would still be an upper bound, so the direction is safe either way.

## 4. The collection (brief item 4)

$$3c^2\sigma\Big[\tfrac5{16t}+\tfrac{2t}3\Big]=3c^2\sigma\cdot\tfrac{5c}{16\sigma}+3c^2\sigma\cdot\tfrac{2\sigma}{3c}=\tfrac{15}{16}c^3+2c\sigma^2=\tfrac{c}{16}\big(15(1-\sigma^2)+32\sigma^2\big)=\tfrac{c(15+17\sigma^2)}{16},$$

**confirmed**, and $3\sqrt{5/6}=\tfrac{3\sqrt5}{\sqrt6}=\tfrac{3\sqrt{30}}6=\tfrac{\sqrt{30}}2$, so the low branch is $\tfrac{\sqrt{30}}2\sigma(1-\sigma^2)$. **Confirmed.**

**The branches agree at $\sigma^*$, and tangentially.** At $\sigma^{*2}=\tfrac{15}{47}$ the low branch is $\tfrac{\sqrt{30}}2\cdot\tfrac{32}{47}\sigma^*=\tfrac{16\sqrt{30}}{47}\sigma^*$ and the high branch is $\tfrac{c^*}{16}\big(15+\tfrac{255}{47}\big)=\tfrac{c^*}{16}\cdot\tfrac{960}{47}=\tfrac{60}{47}c^*$; these are equal exactly when $\sigma^*/c^*=\tfrac{60}{16\sqrt{30}}=\tfrac{15}{4\sqrt{30}}=\tfrac{\sqrt{30}}8=t^*$, which is the definition of $\sigma^*$. **Exact.** The tangency is inherited from $t$: $\frac{d}{dt}\big[\tfrac5{16t}+\tfrac{2t}3\big]=-\tfrac5{16t^2}+\tfrac23$ vanishes at $t^2=\tfrac{15}{32}=t^{*2}$, and the branch value there is $2\sqrt{\tfrac5{16}\cdot\tfrac23}=\sqrt{\tfrac56}$, the constant branch. **So the frontier branch's minimum is the constant branch, which is why the meeting is at zero slope, and the collected functions of $\sigma$ inherit it**: their difference and its $\sigma$-derivative both vanish at $\sigma^*$. **Confirmed, no mismatch.**

## 5. The cubic and the discriminant (brief items 5, 6, 10)

**The cubic.** $3\sqrt2\big[\tfrac{4+5\sigma^2}{3\sqrt2}-\tfrac{\sqrt{30}}2\sigma(1-\sigma^2)-\theta\sigma^3\big]=4+5\sigma^2-\tfrac{3\sqrt{60}}2\sigma(1-\sigma^2)-3\sqrt2\theta\sigma^3$, and $\tfrac{3\sqrt{60}}2=\tfrac{3\cdot2\sqrt{15}}2=3\sqrt{15}$, giving

$$\Psi_\theta(\sigma)=(3\sqrt{15}-3\sqrt2\,\theta)\sigma^3+5\sigma^2-3\sqrt{15}\,\sigma+4 .$$

**Exact, term for term.**

**Monotonicity in $\theta$ (item 6).** Only the leading coefficient carries $\theta$, and $\partial_\theta\Psi_\theta(\sigma)=-3\sqrt2\,\sigma^3$. On $\sigma\ge0$ this is $\le0$, so $\theta\le\sqrt2\Rightarrow\Psi_\theta\ge\Psi_{\sqrt2}$ pointwise there. **The argument is right and it does use $\sigma\ge0$, at the only place it could**, on $\sigma<0$ the inequality reverses, so the conclusion would be false on the negative axis, which is harmless because $\sigma=\sin\beta\ge0$. The step is valid at $\sigma=0$ as an equality, and $\Psi_\theta(0)=4>0$ regardless.

**$\theta<\sqrt2$ at both parities.** $\theta_0(n)^2=\frac{2(n-1)(n-2)}{n^2}=\frac{2n^2-6n+4}{n^2}=2-\frac{2(3n-2)}{n^2}<2$ for every $n\ge1$. At odd $n$, $\tilde\theta_0(n)^2=\frac{2(n-1)(n-3)}{(n+1)(n-2)}<2$ because $(n-1)(n-3)-(n+1)(n-2)=(n^2-4n+3)-(n^2-n-2)=5-3n<0$ for $n\ge2$, the denominator $(n+1)(n-2)$ being positive for $n\ge3$. **Both confirmed, at every $n\ge3$, with no lower bound on $n$ needed beyond that.**

**The discriminant, recomputed from scratch.** With $r=\sqrt{15}$ and $(a,b,c,d)=(3r-6,5,-3r,4)$, using $r^2=15$ and $r^3=15r$:

| term | value |
| --- | --- |
| $18abcd$ | $360(3r-6)(-3r)=360(-9\cdot15+18r)=-48600+6480r$ |
| $-4b^3d$ | $-4\cdot125\cdot4=-2000$ |
| $b^2c^2$ | $25\cdot9\cdot15=3375$ |
| $-4ac^3$ | $-4(3r-6)(-405r)=1620r(3r-6)=4860\cdot15-9720r=72900-9720r$ |
| $-27a^2d^2$ | $-432(9\cdot15-36r+36)=-432(171-36r)=-73872+15552r$ |

Rational part $-48600-2000+3375+72900-73872=-48197$; $r$-part $6480-9720+15552=12312$. **So $\Delta=12312\sqrt{15}-48197$, exactly as claimed.** The comparison: $15\cdot12312^2=15\cdot151{,}585{,}344=2{,}273{,}780{,}160$ and $48197^2=2{,}322{,}950{,}809$; the first is smaller, so $12312\sqrt{15}<48197$ and **$\Delta<0$**.

**The sign convention is the one the argument needs.** With $\Delta$ written as above, $\Delta>0$ gives three distinct real roots and $\Delta<0$ gives one real root and a conjugate pair; $\Delta=0$ is the repeated-root locus. **The formula displayed in the statement is that convention's formula, so $\Delta<0$ does mean one real root here.** *Confirmed independently:* $\Psi_{\sqrt2}=A+\sqrt{15}\,B$ with $A=-6\sigma^3+5\sigma^2+4$ and $B=3\sigma^3-3\sigma$, and its norm $A^2-15B^2=-99\sigma^6-60\sigma^5+295\sigma^4-48\sigma^3-95\sigma^2+16$ has exactly two real roots, of which only $\sigma=-2.0608\ldots$ annihilates $\Psi_{\sqrt2}$ (the other belongs to the conjugate $A-\sqrt{15}B$). **One real root, and it is negative.**

**The argument from one real root to positivity is complete.** $\Delta\ne0$, so the real root $\rho$ is simple and $\Psi_{\sqrt2}(\sigma)=a(\sigma-\rho)(\sigma^2+p\sigma+q)$ with the quadratic factor having no real root, hence positive definite. So $\operatorname{sign}\Psi_{\sqrt2}(\sigma)=\operatorname{sign}\,a(\sigma-\rho)$. With $a=3(\sqrt{15}-2)>0$ and $\Psi_{\sqrt2}(0)=4>0$ this forces $\rho<0$, and then $\sigma\ge0\Rightarrow\sigma-\rho>0\Rightarrow\Psi_{\sqrt2}(\sigma)>0$. **No step is missing.** Exact bracketing corroborates the sign at rational points: $\Psi_{\sqrt2}(\tfrac12)=\tfrac92-\tfrac{9\sqrt{15}}8>0$ since $81\cdot15=1215<1296=36^2$, and $\Psi_{\sqrt2}(\tfrac34)=\tfrac{137}{32}-\tfrac{63\sqrt{15}}{64}>0$ since $63^2\cdot15=59{,}535<75{,}076=274^2$.

**Trying to break it (item 10).** The claim is universal over $\sigma\in[0,\sigma^*]$ and over $n$, so there are two axes.

- *Over $\sigma$.* $\Psi_{\sqrt2}'(\sigma)=3(3\sqrt{15}-6)\sigma^2+10\sigma-3\sqrt{15}$ has one positive root; **screened**, it is $\sigma=0.58500\ldots$, which lies to the **right** of $\sigma^*=0.56493\ldots$. So $\Psi_{\sqrt2}$ is strictly decreasing on $[0,\sigma^*]$ and the binding value is the endpoint, exactly $\Psi_{\sqrt2}(\sigma^*)=\tfrac{263}{47}-\tfrac{1440\sqrt{47}+90\sqrt{705}}{2209}$, which is positive (screened at $0.044904$). **No break, and the proof proves more than the statement needs**, positivity on all of $\sigma\ge0$, where a single endpoint evaluation would do.
- *Over $n$.* $n$ enters only as $\theta\le\Theta_n<\sqrt2$, so the claim cannot be broken by any $n$ while that inequality stands. **The exact tolerance is worth recording**: $\Psi_\theta(\sigma^*)>0$ holds precisely for
  $$\theta<\theta_{\mathrm{crit}}:=\frac{263\sqrt{1410}-1440\sqrt{30}}{1350}=1.4729158\ldots,$$
  which is $4.1509\%$ above $\sqrt2$ (screened), and the free critical point stays right of $\sigma^*$ throughout that range. **This reproduces [L22](../findings/route-a.md)'s otherwise unsourced *"the branch survives a constant about $4\%$ above $\sqrt2$"* as an exact closed form**, from a derivation that never saw it. So (a) is true with real headroom, and breaking it needs a unit $K\in\ker F_u$ with $P(K)>\theta_{\mathrm{crit}}$, an object that would refute Conjecture A outright, not merely this lemma.

## 6. The edges (brief item 9)

| edge | reading |
| --- | --- |
| $\sigma=0$, i.e. $\alpha=\tfrac13$ | $H_\theta(0)=\tfrac{4}{3\sqrt2}=\tfrac{2\sqrt2}3>0$ at every $\theta$. The requirement is stated for $\alpha<\tfrac13$, so this is the limit point and the low branch reaches it continuously. **[L22](../findings/route-a.md)'s *"borderline by construction"* is visible here**: $\tfrac{2\sqrt2}3$ is exactly what Nienhaus's bound returns |
| $\sigma=1$, i.e. $\alpha=0$ | $c=0$, so $3c^2\sigma V(t)\to0$ and $H_\theta(1)=\tfrac9{3\sqrt2}-\theta=\tfrac3{\sqrt2}-\theta$, positive for every $\theta<\tfrac3{\sqrt2}=2.1213\ldots$. **The high branch is comfortable at the far end and uncomfortable in the middle**, screened, $H_{\sqrt2}$ is negative on roughly $(0.6404,0.86)$ and positive again by $\sigma=0.9$. The statement's *"the failure is at the single point $\alpha=\tfrac7{48}$"* describes the **witness**, correctly; the failure set is an interval |
| $\alpha=\alpha^*$, $\sigma=\sigma^*$ | the two pieces agree, tangentially, §4. **$H_\theta$ is $C^1$ across the join and no case-boundary artefact exists** |
| $n=12$ | $\theta_0(12)=\sqrt{220/144}$, $\tilde\theta_0(13)=\sqrt{240/154}$; both are far below $\Theta_{3/4}$, and $H_{\theta_0(12)}(\tfrac34)=+0.0689$ (screened). **The (b) witness does not bite at the smallest dimension in scope**, which is consistent with (b) being a large-$n$ statement and worth saying, since the statement does not |
| odd $n$ | handled in (a) by the second formula. **In (b) only $\theta_0$ is named**, though at odd $n$ the constant is $\tilde\theta_0(n)<\theta_0(n)$. The conclusion survives (the odd sequence crosses too, at $n=143$ against the even $n=142$ (screened)) but the sentence as written applies an even-$n$ constant at odd $n$ |
| does *"$\theta_0(n)$ increases to $\sqrt2$"* need $n\ge$ something? | $\frac{d}{dn}\theta_0(n)^2=\frac{2(3n-4)}{n^3}>0$ for $n\ge2$, and $\frac{d}{dn}\tilde\theta_0(n)^2$ has numerator $2(3n^2-10n+11)$, whose discriminant $100-132<0$, so it is **positive at every $n$**. Both increase, both tend to $2$ in the square. **No hypothesis is needed beyond $n\ge3$**, and the statement's silence is harmless |

## 7. The witness at $\sigma=\tfrac34$ (brief item 7), and the one refuted clause

**The evaluation is exact.** $\sigma=\tfrac34$ gives $c=\sqrt{1-\tfrac9{16}}=\tfrac{\sqrt7}4$, and $\tfrac9{16}>\tfrac{15}{47}$ because $9\cdot47=423>240=15\cdot16$, so the **high** branch applies. Then $4+5\cdot\tfrac9{16}=\tfrac{109}{16}$, whence the first term is $\tfrac{109}{48\sqrt2}=\tfrac{109\sqrt2}{96}$; and $15+17\cdot\tfrac9{16}=\tfrac{393}{16}$, whence the second is $\tfrac{\sqrt7}4\cdot\tfrac{393}{16\cdot16}=\tfrac{393\sqrt7}{1024}$. **So $H_\theta(\tfrac34)=\tfrac{109\sqrt2}{96}-\tfrac{393\sqrt7}{1024}-\tfrac{27}{64}\theta$, confirmed.** Solving for the threshold, $\tfrac{64}{27}\cdot\tfrac{109\sqrt2}{96}=\tfrac{218\sqrt2}{81}$ and $\tfrac{64}{27}\cdot\tfrac{393\sqrt7}{1024}=\tfrac{393\sqrt7}{432}=\tfrac{131\sqrt7}{144}$, giving $\Theta_{3/4}=\tfrac{218\sqrt2}{81}-\tfrac{131\sqrt7}{144}$. **Confirmed, and $1.39925\ldots$ is a correct truncation of $1.3992562\ldots$.**

**$\Theta_{3/4}<\sqrt2$, exactly.** The inequality is $\big(\tfrac{218}{81}-1\big)\sqrt2<\tfrac{131}{144}\sqrt7$, i.e. $\tfrac{137}{81}\sqrt2<\tfrac{131}{144}\sqrt7$. Squaring (both sides positive) and clearing denominators, this is $2\cdot137^2\cdot144^2<7\cdot131^2\cdot81^2$, that is

$$778{,}387{,}968<788{,}153{,}247 .$$

**True, so $\Theta_{3/4}<\sqrt2$ with no appeal to a decimal.**

**The one refuted clause.** *"the requirement at $\alpha=\tfrac7{48}$ holds **exactly when** $\theta<\Theta_{3/4}$."*

- **Located.** Item (4) of the statement; in the record, the sentence introducing $\Theta_{3/4}$ in part (b) of [L165](../findings/route-a.md).
- **The failure, concretely.** $H_\theta$ is built from two separate maximisations, $\max_K[A+tB]$ and $\sup_KP(K)$, at possibly different $K$ (§3). So $\frac{4+5\sigma^2}{3\sqrt2}-P(W)\ \ge\ H_\theta(\sigma)$ with the inequality **strict** whenever the two maximisers differ, and $H_\theta(\tfrac34)\le0$ is compatible with $\gamma_{\max}(\tfrac7{48})$ sitting strictly below the requirement. An *"exactly when"* asserts both directions; only $H_\theta>0\Rightarrow$ requirement is available. **The clause therefore claims a converse the construction cannot supply**, and it does so about the requirement rather than about the bound.
- **The opposite argued.** The strongest reading is elliptical (*"the requirement [as this bound certifies it]"*), under which the sentence is true and the phrase is shorthand. Two things weigh against letting it stand. First, the record itself makes the distinction explicitly two paragraphs earlier, so the shorthand contradicts its own neighbour rather than compressing it; and the brief's paraphrase of (1) has already dropped that neighbour, which is exactly how the shorthand loses its anchor. Second, the section's own headline (*"no single constant carries the other piece"*), is the precise claim, and it is about **constants**, not about the requirement. **So the repair is one word: *is certified exactly when*.**

**The crossing, and what it does and does not establish (item 15).** $\theta_0(n)\uparrow\sqrt2$ and $\Theta_{3/4}<\sqrt2$, so the crossing exists; **screened**, it is at even $n=142$ and odd $n=143$, and the coverage endpoint at the limiting constant $\theta=\sqrt2$ is $\sigma=0.640393$, i.e. $\alpha=0.196632$, both reproducing the record's own screened figures from an independent computation. The conclusion *"the contiguous reach downward from $\tfrac13$ stops at some $\alpha\ge\tfrac7{48}$"* is then correct **and conservative**, since $0.1966>\tfrac7{48}=0.14583$.

**But one substitution is silent, and it runs the wrong way.** What the record has is $\theta\le\Theta_n$, an **upper** bound. To conclude that $H$ at $\sigma=\tfrac34$ is non-positive one needs $\theta>\Theta_{3/4}$, a **lower** bound on $\theta$, and the record has none. The honest content is therefore: *the constant the record is able to substitute no longer certifies*, which is what the headline says and what makes *"no single constant carries the other piece"* the right formulation. **The sentence *"the bound fails from there on"* is defensible only with "the bound" read as "$H$ at the record's own instantiated constant", and that reading should be written down rather than left to the reader.**

## 8. The inherited inputs, and whether the scope is honest (brief item 8)

**The statement's own list is three items and it is incomplete.** The record closes L165 with $c_0=1$, $\lambda=\tfrac23$, and $M_{W_1}\Pi_{\ker}Q(W_1)=0$ measured at three dimensions, **that much is honest, and better than the brief's quotation of (3), which carries *"at every $n$ and both parities"* in bold with no conditional attached.** Two further inputs are consumed and named nowhere:

1. **$\theta\le\Theta_n$ is Conjecture A restricted to $\ker F_u$.** Both headline claims consume it ((a) through $\theta<\sqrt2$, (b) through the crossing) and [L22](../findings/route-a.md) states the position in terms this statement does not repeat: *"both branches take the sphere-product value as their constant, which makes the estimate conditional on Conjecture A at critical points past $n=12$, circular against the goal this programme is for."* **A lemma whose two conclusions both rest on the conjecture the programme exists to prove should say so in its own scope line**, and L165's does not.
2. **$P(W_1)=0$ rests on a measured row.** §2: the vanishing is L101's, whose Gate 2 verdict is GAP, and whose containment is *"exhaustively verified numerics, not proofs"* at $n=8,10$, below the range. The list's third item names only the $M_{W_1}$ vanishing, which L165 does not itself use; **the vanishing it does use is a different one and is absent from the list.**

**And the two suprema are measured below the range they cap.** [L22](../findings/route-a.md) records that $\sqrt{5/6}$ and $\tfrac23$ were measured at $n=10$, and that padding to $n=20,24$ *"re-reports the datum of the dimension padded from"*, carrying a value upward as a lower bound, the wrong direction for a supremum. Both constants sit inside $V(t)$ and hence inside both pieces of $H_\theta$. **This is inherited and unnamed.**

**The scope of the algebra itself is honest.** Nothing in (0)–(4) needs $n\ge12$ or any dimension at all; the claims are identities in $\mathbb Q(\sqrt2,\sqrt7,\sqrt{15},\sqrt{30})$ plus one sign determination, conditional only on $\theta\le\sqrt2$. **So the correct scope line is: given the setting, (a) holds for every $\theta\le\theta_{\mathrm{crit}}$ and (b) is a statement about which constants the second piece admits, and the setting is what carries the debt.**

## 9. What would falsify it, and what was done to look (brief item 11)

**Three objects, in order of how much they would cost.**

1. **A unit $K\in\ker F_u$ at some critical point $u$, at some $n\ge12$, with $P(K)>\theta_{\mathrm{crit}}=\frac{263\sqrt{1410}-1440\sqrt{30}}{1350}$.** This is the exact object that breaks (a), and it is the whole of what breaks (a): the cubic piece depends on $n$ through nothing else. **It would also refute Conjecture A**, since $\theta_{\mathrm{crit}}>\sqrt2>\Theta_n$, so (a) is safe wherever the conjecture is, with $4.15\%$ of headroom.
2. **A unit $W_1\in V_{1/3}$ with $\langle Q(W_1),W_1\rangle\ne0$ at some $n\ge12$.** This restores the $c^3P(W_1)$ term and changes $H_\theta$ at every $\sigma$, low branch included. **The record's evidence against it is measured at $n=8,10$ and its sibling rows are known to fail at other eigenspaces** (§2), so this is the least-supported of the three.
3. **A configuration violating $c_0=1$, hence $s^2=3\varepsilon$.** This breaks the change of variable at the root and every displayed formula with it. [L22](../findings/route-a.md) records the force against it ($\sup T(W_1,N,N)=\sqrt{2/3}>\tfrac23$), from the block's own table.

**What was done to look.** Analysis only. **No search, sweep, census or falsifier hunt was run**, in accordance with the standing rule; the three decimals reported above are screens of quantities being recorded, each seconds of exact symbolic arithmetic on an object constructed for that purpose, and none is offered as evidence for a positive claim. Every claim in the table is settled by an identity in a real quadratic field or by an integer comparison, and each such comparison is displayed in full so it can be checked by hand. **The one place a decimal does work is the location of $\Psi_{\sqrt2}$'s free critical point relative to $\sigma^*$, and that conclusion is not load-bearing**, the positivity of $\Psi_{\sqrt2}$ on $[0,\sigma^*]$ follows from the discriminant argument alone, which needs no numerics at all.

## Verdict

**PROVEN, hypotheses corrected.**

Every derivation survives cold: the change of variable is forced rather than chosen, the cubic and its discriminant reproduce exactly, the sign convention is the one the argument needs, the root argument is complete, and both closed-form constants ($\alpha^*=\tfrac{32}{141}$ and $\Theta_{3/4}=\tfrac{218\sqrt2}{81}-\tfrac{131\sqrt7}{144}$), are right, with $\Theta_{3/4}<\sqrt2$ reducing to a nine-digit integer comparison. **Three corrections.**

1. **Replace *"holds exactly when"* by *"is certified exactly when"* in (b).** $H_\theta$ is a one-directional certificate and the record says so two paragraphs above; the clause as written claims a converse the construction cannot supply.
2. **Add two inputs to the inherited list**: $\theta\le\Theta_n$, which is Conjecture A restricted to $\ker F_u$ and is consumed by *both* headline claims; and the $V_{1/3}$ row of [L101](../findings/route-a.md)'s table, which is what makes $P(W_1)=0$ and is a different vanishing from the $M_{W_1}$ one the list names.
3. **Name the parity in (b)** (at odd $n$ the constant is $\tilde\theta_0(n)$, not $\theta_0(n)$) and note that the crossing is a large-$n$ phenomenon, the witness being comfortably positive at $n=12$.

**Two sharpenings, offered rather than owed.** The cubic piece holds for every $\theta<\theta_{\mathrm{crit}}=\frac{263\sqrt{1410}-1440\sqrt{30}}{1350}$, which is [L22](../findings/route-a.md)'s *"about $4\%$ above $\sqrt2$"* in closed form and puts an exact number on the headroom; and $P(W_1)=0$ needs only $\Pi_{V_{1/3}}Q(W_1)\perp W_1$, one entry of the table, rather than the whole decomposition, recording the weaker hypothesis isolates precisely which measurement the $c^3$ term rests on.

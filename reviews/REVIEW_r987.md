# Review r987: I104's $x\to\kappa_i$ link, and whether it can be spent

Gate 2, independent adversarial review, cold read from [BRIEF_I104_x_kappa_link.md](BRIEF_I104_x_kappa_link.md) alone. The findings files, the working note, the screens and `lean/HamiltonsCubic/Results/I104XKappaLink.lean` were not opened. Every derivation below is carried by hand and every constant is exact. Four assertion screens were run on sectional matrices constructed here for the purpose, and each is labelled a screen where it appears. No screen stands behind a positive claim.

Log: [agent_logs/r987-x-kappa-link.log](../agent_logs/r987-x-kappa-link.log)

## Verdicts

| # | claim | verdict |
|---|---|---|
| 1 | $(q_1)_{ij}=(q_1)_{kl}$, so $(q_1)_{ij}+(q_1)_{kl}=2c$ | CONFIRMED |
| 2 | $D_{ij}=x_1+x_2$ and $D_{kl}=x_1+x_3$ | CONFIRMED, in scope, and only under the component reading of $x_a$ |
| 3 | $c=x_1+\tfrac13(x_2+x_3)$ | CONFIRMED, but the stated reason is not enough |
| 4 | $p+p'=\tfrac13(x_2+x_3)$ | CONFIRMED, in scope |
| 5 | $p^2+p'^2\ge\tfrac1{18}(x_2+x_3)^2$ | CONFIRMED, constant right, and strictly weaker than the hypotheses give |
| 6 | the bound is attained exactly at $p=p'$ | CONFIRMED, and that locus is $x_2=x_3$ |
| 7 | $p,p'$ not separately determined by $x_2,x_3$ | **REFUTED**, both are pinned, so the link feeds an identity |
| 8 | the relation fails off the span of the three planes | CONFIRMED for $n\ge7$, sharper repair below, and it degenerates at $n=6$ |
| 9 | $0.039$ against a $0.0148$ deficit, same configuration | CONFIRMED as arithmetic, over-read as a conclusion |
| 10 | the link improves the upper bound on $\kappa$ | **REFUTED**, unusable without a sign condition, and short by a factor of $1.65$ even when it holds |

**Summary.** The algebra of claims 1 to 6 is correct and the link is real, but it is stated backwards in two places: it yields an identity rather than a bound, and it cannot be spent on $\kappa$ without $q_1$'s first-pairing coefficient being negative. Under the most generous accounting the improvement reaches $0.0090$ against a deficit of $0.0148$, so this route does not close the chain.

## 0. Conventions, fixed once

$\Pi_Q$ carries $(x,y,z)$ with $x+y+z=0$ on the pairings $\{ij,kl\},\{ik,jl\},\{il,jk\}$, and $\langle K,L\rangle=\sum_{a<b}K_{ab}L_{ab}$, so $\lVert K\rVert^2=2(x^2+y^2+z^2)$. Row $i$ of such a $K$ sums to $x+y+z=0$, so $\Pi_Q\subset\mathcal D_n$ as claimed.

**The sum of the three planes is direct, so the decomposition below is well posed.** The pair $ik$ lies in $Q_1$ and in neither $Q_2$ nor $Q_3$, and likewise $il$. So if $K_1+K_2+K_3=0$ with $K_a\in\Pi_{Q_a}$, reading the $ik$ and $il$ entries gives $y_1=z_1=0$, whence $x_1=-(y_1+z_1)=0$ and $K_1=0$. The same argument at $im,ip$ and at $km,kp$ kills $K_2$ and $K_3$. The span is therefore $6$-dimensional, which a screen reproduces as a rank at $n=6,7,8,9,10$.

**Two different quantities wear the symbol $x_a$ in this brief, and the derivation is coherent only if they are told apart.**

- **Component coefficients.** Write $P_{\text{span}}D=K_1+K_2+K_3$ with $K_a\in\Pi_{Q_a}$, unique by directness, and let $x_a$ be $K_a$'s first-pairing coefficient.
- **Projection coefficients.** Let $c_a$ be the first-pairing coefficient of $q_a=P_{\Pi_{Q_a}}D$. The brief's $c$ is $c_1$.

These are related by $c_a=\tfrac23x_a+\tfrac13S$ with $S=x_1+x_2+x_3$, proved at claim 3. Inverting, $S=\tfrac35(c_1+c_2+c_3)$ and $x_a=\tfrac32\!\left(c_a-\tfrac13S\right)$, so

$$x_2+x_3=\tfrac9{10}(c_2+c_3)-\tfrac35c_1.$$

**This collision is a defect in the write-up, not only in the brief.** The GIVEN at line 21 states the cross-Gram as $\langle q_1,q_2\rangle=x_1x_2$ with $q_a$ the projections. That statement is true of the projection coefficients, $\langle q_1,q_2\rangle=c_1c_2$, and it is immediate because $ij$ is the only entry the two planes share. Claim 3 then needs the component reading, because under the projection reading $c=c_1$ by definition and claim 3 collapses to $c_1=c_1+\tfrac13(x_2+x_3)$, forcing $x_2+x_3=0$ and emptying claim 4. A screen over $600$ draws at $n=6,7,8$ found $\langle q_1,q_2\rangle=c_1c_2$ in every draw and $\langle q_1,q_2\rangle\ne x_1x_2$ in every draw. **The record should fix one reading and rewrite the GIVEN in its letters.**

## Hypothesis inventory

| hypothesis | used by | status |
|---|---|---|
| $q_1\in\Pi_{Q_1}$, that is, $q_1$ is the orthogonal projection | 1, 3 | definitional |
| $D\in\Pi_{Q_1}\oplus\Pi_{Q_2}\oplus\Pi_{Q_3}$ | 2, 4, 5, 6, 7 | **unproved for a critical point**, see claim 8 |
| the cross-Gram factors through each plane's first-pairing functional | 3 | given, not audited, and strictly stronger than the cosine statement it is quoted as |
| $x_a$ read as component coefficients | 2, 3, 4 | **collides with the GIVEN's letters**, see section 0 |
| $\mathop{\mathrm{sign}}(c_1)<0$ | 10 | **absent, and claim 10 is false without it** |

## 1. The two entries of $q_1$ agree

$q_1\in\Pi_{Q_1}$, and every member of $\Pi_{Q_1}$ has $K_{ij}=K_{kl}=x$ by the definition of the pairing parametrisation. So $(q_1)_{ij}=(q_1)_{kl}=c$ and their sum is $2c$. **CONFIRMED.**

**Non-vacuity.** A vacuous version would define $c$ and never use the equality. It is used: it is what makes $p+p'$ depend on $q_1$ through the single scalar $2c$ instead of through two independent entries, and the whole derivation runs on that.

## 2. The two entries of $D$

The pair $ij$ lies in $Q_1$, on its first pairing, contributing $x_1$, and in $Q_2=\{i,j,m,p\}$, whose first pairing is $\{ij,mp\}$, contributing $x_2$. $Q_3=\{k,l,m,p\}$ contains neither $i$ nor $j$, so contributes nothing. Hence $D_{ij}=x_1+x_2$. Symmetrically $kl$ lies on $Q_1$'s first pairing and on $Q_3$'s first pairing $\{kl,mp\}$, and $Q_2$ misses $k$ and $l$, so $D_{kl}=x_1+x_3$. **CONFIRMED**, and the brief is right that this is the one step where the scope enters: it reads $D$ as exactly $K_1+K_2+K_3$ with nothing else.

## 3. The projection coefficient, and whether the cosine gives it

**The stated reason is insufficient as stated.** A principal cosine is a pair of numbers attached to a pair of subspaces. $c=x_1+\tfrac13(x_2+x_3)$ is a statement about one coordinate of one projection, so it needs the principal DIRECTIONS as well as the angle, and it needs them to be the same direction for both overlaps. The brief supplies exactly that at line 19 and in the GIVEN's rank-one wording. **So the claim follows, but from the rank-one factorisation through the first-pairing functional, not from the cosine.** Written as the cosine alone it is a non sequitur.

**Derivation, route one.** For any $K=(x,y,z)\in\Pi_{Q_1}$ and $K_2\in\Pi_{Q_2}$ with first coefficient $x_2$, the only shared entry is $ij$, so $\langle K,K_2\rangle=x\,x_2$. Seek $P_1K_2=(\alpha,\beta,\gamma)$ with $\alpha+\beta+\gamma=0$ and $2(\alpha x+\beta y+\gamma z)=x_2x$ for all sum-zero $(x,y,z)$. On the sum-zero plane the functional $(x,y,z)\mapsto x$ is represented by $(\tfrac23,-\tfrac13,-\tfrac13)$, so $(\alpha,\beta,\gamma)=\tfrac{x_2}2(\tfrac23,-\tfrac13,-\tfrac13)=(\tfrac{x_2}3,-\tfrac{x_2}6,-\tfrac{x_2}6)$. The first-pairing coefficient of $P_1K_2$ is $\tfrac{x_2}3$.

**Route two, through the unit principal directions, as a control on route one.** The unit vector of $\Pi_{Q_1}$ maximising the first coefficient is $\hat u_1=\tfrac1{\sqrt3}(1,-\tfrac12,-\tfrac12)$, of norm $2(\tfrac13+\tfrac1{12}+\tfrac1{12})=1$, with first coefficient $\tfrac1{\sqrt3}$. Since $\lVert K\rVert^2=2(x^2+y^2+z^2)\ge3x^2$ with equality at $y=z=-x/2$, this confirms the principal cosine is $\max\langle\hat K,\hat L\rangle=\tfrac13$ and the second is $0$ by rank one, matching the GIVEN. Now $\langle K_2,\hat u_2\rangle=\tfrac2{\sqrt3}(x_2-\tfrac{y_2+z_2}2)=\tfrac2{\sqrt3}\cdot\tfrac32x_2=\sqrt3\,x_2$, and $P_1\hat u_2=\tfrac13\hat u_1$, so $P_1K_2=\tfrac{x_2}{\sqrt3}\hat u_1$, whose first coefficient is $\tfrac{x_2}{\sqrt3}\cdot\tfrac1{\sqrt3}=\tfrac{x_2}3$. The two routes agree.

$K_3$ contributes $\tfrac{x_3}3$ along the SAME direction $\hat u_1$, because $Q_1$'s first pairing carries both overlaps, so the two contributions add rather than interfering. Hence $c=x_1+\tfrac13(x_2+x_3)$, equivalently $c_a=\tfrac23x_a+\tfrac13S$ by symmetry. **CONFIRMED, with the reason corrected.**

## 4. The sum

$$p+p'=(D_{ij}+D_{kl})-2c=(2x_1+x_2+x_3)-2x_1-\tfrac23(x_2+x_3)=\tfrac13(x_2+x_3).$$

**CONFIRMED**, in scope. Screened over $600$ draws at $n=6,7,8$.

## 5. The constant, and what it throws away

Minimising $p^2+p'^2$ subject to $p+p'=s$ gives $p=p'=s/2$ and the value $2(s/2)^2=s^2/2$, so with $s=\tfrac13(x_2+x_3)$ the bound is $\tfrac12\cdot\tfrac19(x_2+x_3)^2=\tfrac1{18}(x_2+x_3)^2$. **The constant is one half times one ninth and is correct.** The error the brief is guarding against would produce $\tfrac1{36}$, from writing $p^2+p'^2\ge\big(\tfrac{p+p'}2\big)^2$, which bounds one square rather than two. It is not present.

**The bound is strictly weaker than the same hypotheses give.** By claim 7 below, $p=\tfrac13(2x_2-x_3)$ and $p'=\tfrac13(2x_3-x_2)$, so

$$p^2+p'^2=\tfrac19\!\left(5x_2^2-8x_2x_3+5x_3^2\right),$$

and $18\big(p^2+p'^2\big)-(x_2+x_3)^2=9(x_2-x_3)^2\ge0$, which both re-proves claim 5 and locates the slack.

**Where $p^2+p'^2$ is used, since the brief asks.** In the quoted coupling expansion it appears once, in $2x(p^2+p'^2)$, and $p,p'$ appear once more linearly, through $p+p'$ inside $\Sigma$. Nothing else in the chain constrains them except the budget $p^2+p'^2\le\lVert r_1\rVert^2$.

**Vacuity, checked rather than asserted.** The bound is vacuous exactly when $x_2+x_3=0$, and nothing in the setup excludes that. The identity is not vacuous there: at $x_3=-x_2$ it gives $p^2+p'^2=2x_2^2$. **So the bound is empty in precisely the regime where the identity is most informative**, which is the sharpest reason to record the identity instead. **CONFIRMED.**

## 6. Sharpness

Equality in $p^2+p'^2\ge\tfrac{(p+p')^2}2$ holds iff $p=p'$, and $p-p'=x_2-x_3$, so the attaining locus is $x_2=x_3$. **CONFIRMED**, and screened by the vanishing of $9(x_2-x_3)^2$ in section 5.

## 7. The non-existence claim is false

**REFUTED.** In scope, subtracting $c=x_1+\tfrac13(x_2+x_3)$ from each entry gives

$$p=D_{ij}-c=\tfrac13(2x_2-x_3),\qquad p'=D_{kl}-c=\tfrac13(2x_3-x_2),$$

so each of $p$ and $p'$ is a linear function of $x_2$ and $x_3$ alone. The claim says they are not separately determined by $x_2,x_3$. They are. Screened over $600$ draws, with a perturbation control: the pinned formula shifted by $0.1$ fails in every draw.

**The companion sentence in the note falls with it.** "$p$ and $p'$ are NOT separately determined, only their sum, so this feeds a BOUND on $\kappa_1$ and cannot feed an identity" is wrong twice. The link does feed an identity, the one in section 5.

**The strongest reading the words support, and why it still fails.** If the intent is that $p$ and $p'$ are not determined by the SUM $x_2+x_3$ alone, that is true and trivial, and it is a statement about what the surrounding argument carries rather than about what the projection determines. If the downstream genuinely only knows $x_2+x_3$, or only $\sum_ax_a^2$, the note should say that, because it is a fact about the chain and is repairable by carrying $x_2$ and $x_3$ separately. Off the span the split is genuinely free, but there claims 2 to 4 fail as well, so **there is no regime in which "only the sum is determined" is the correct description.**

## 8. The scope, its exact repair, and a degeneracy at $n=6$

Write $D=K_1+K_2+K_3+D'$ with $D'$ orthogonal to all three planes. Since $P_1D'=0$, the constant $c$ is unchanged, so the whole failure sits in $D_{ij}+D_{kl}$.

**What orthogonality to $\Pi_{Q_1}$ actually says.** $\langle D',K\rangle=x(D'_{ij}+D'_{kl})+y(D'_{ik}+D'_{jl})+z(D'_{il}+D'_{jk})$, and requiring this to vanish for every $x+y+z=0$ forces the three pair-sums to be EQUAL, not zero. Write $\tau_1$ for the common value. Then

$$\boxed{\;p+p'=\tfrac13(x_2+x_3)+\tau_1\;}$$

**This is the honest repair, and it is better than the two the brief offers.** Splitting $r_1$ into its in-span part and the rest leaves a six-entry residue, and adding a hypothesis discards the general case. The correction is a single scalar, the common pair-sum of the off-span component, and it is an orthogonal invariant of $\Pi_{Q_1}$. Screened at $n=6,7,8$: the three pair-sums of $D'$ agree in every draw, and the corrected relation holds in every draw.

**What it costs claim 5.** The bound becomes $p^2+p'^2\ge\tfrac12\big(\tfrac13(x_2+x_3)+\tau_1\big)^2$, which is not a bound in the $x$'s at all, and it is zero whenever $\tau_1=-\tfrac13(x_2+x_3)$, for any values of $x_2$ and $x_3$ whatever. **So off the span the link buys nothing, rather than buying less.**

**The degeneracy, and it is a trap for anyone testing the scope.** At $n=6$ the complement of the span inside $\mathcal D_6$ is $3$-dimensional and $\tau_1$ vanishes identically on it, so the unscoped relation $p+p'=\tfrac13(x_2+x_3)$ holds for EVERY $D\in\mathcal D_6$. Screen, the supremum of $|\tau_1|$ over the unit sphere of that complement:

| $n$ | $\dim\mathcal D_n$ | $\dim$ complement | $\sup\lvert\tau_1\rvert$ |
|---|---|---|---|
| 6 | 9 | 3 | 0 |
| 7 | 14 | 8 | 0.258 |
| 8 | 20 | 14 | 0.352 |
| 9 | 27 | 21 | 0.414 |
| 10 | 35 | 29 | 0.459 |

**So the scope is real for $n\ge7$ and invisible at $n=6$**, and a six-vertex example is the natural thing to reach for. Claim 8 as stated is CONFIRMED with that qualification.

**Whether a critical point's $D$ has any reason to lie in the span.** Nothing here gives one. The span is $6$-dimensional inside a space of dimension $n(n-3)/2$, which is already $14$ at $n=7$ and grows quadratically, and $Q_1,Q_2,Q_3$ are three four-sets selected from a larger configuration rather than a decomposition of it. Membership is a strong coincidence that would have to be proved. **The item should carry $\tau_1$ explicitly, which costs one scalar and keeps the general case, rather than a hypothesis that cannot be discharged.**

## 9. The two numbers, and what comparing them licenses

At $t=0.346$ the bound $\tfrac{u}{\sqrt3}(t-u^2)$ takes the value $0.039044$ at $u=0.437539$ and $0.038925$ at $u=0.438432$, monotone across the interval. "About $0.039$" is right to the precision claimed.

**Same configuration, checked.** The brief fixes $t=0.346$, states the deficit $0.0148$ there, and states that the same configuration is where $\sum_iu_i^2$ confines $u$ to $[0.437539,0.438432]$. The bound is evaluated only on that interval and at that $t$. **There is no configuration mixing here. CONFIRMED as arithmetic.**

**What it does not license, and the file has been burned once already by exactly this kind of step.** $0.0148$ is $38.0\%$ of $0.039$. That the coupling term is large enough to matter in principle is all this comparison shows. The quantity that decides the item is the available IMPROVEMENT to the bound, not the bound's value, and section 10 computes it to be roughly a quarter of the bound. **"The coupling source is live" should be rewritten as "the coupling source is large enough that a sufficiently strong improvement to it would close the deficit", which is a weaker and true sentence.**

## 10. Whether the link can be spent

**REFUTED as stated.** Three obstacles, increasing in severity.

**(a) The sign, which is the brief's own suspicion and it is correct.** In the quoted expansion the $p,p'$ terms are $2x(p^2+p'^2)$, where $x$ is $\hat q$'s coefficient on the first pairing, the pairing carrying $ij$ and $kl$. So the terms and the link do refer to the same pairing and the match is right. But $x+y+z=0$ with $(x,y,z)\ne0$, so $x$ takes either sign. A LOWER bound on $p^2+p'^2$ bounds $x(p^2+p'^2)$ ABOVE only when $x<0$. When $x>0$ it moves the term the wrong way and cannot enter an upper bound on $\kappa$ at all. Since $x=c/\lVert q_1\rVert$, the condition is on $c$:

**the link tightens the upper bound on $\kappa_1$ exactly when $c=x_1+\tfrac13(x_2+x_3)<0$, and nothing on file establishes that sign.**

**(b) The substitution is not into the bound on file.** The bound to be improved is $\kappa\le\max(x,y,z)\lVert q\rVert\lVert r\rVert^2$, an operator-norm statement, and a lower bound on two ENTRIES of $r$ cannot be substituted into one. It can only be spent inside the explicit expansion. Carrying the expansion instead, with $\mu=\max(x,y,z)$, the term $\mu(p^2+p'^2)$ that the crude allocation charges is really $x(p^2+p'^2)$, so the gain is $(\mu-x)(p^2+p'^2)\lVert q\rVert$ and the usable condition weakens from $x<0$ to $x<\mu$. That is a genuine softening of (a), and it costs the step the record explicitly took: the expansion was "discarded in favour of" the crude bound, and it has to be un-discarded.

**(c) The size, and this is what retires the route.** Screen, with each factor pushed independently to its own extreme, which over-estimates the joint maximum because the factors are coupled through $c_1$:

- $\lVert K\rVert^2=2(x^2+y^2+z^2)\ge3x^2$ gives $\lvert c_a\rvert\le u_a/\sqrt3\le0.2531288$ at $u=0.438432$;
- $x_2+x_3=\tfrac9{10}(c_2+c_3)-\tfrac35c_1$ gives $\lvert x_2+x_3\rvert\le2.4\times0.2531288=0.6075092$;
- hence $\tfrac1{18}(x_2+x_3)^2\le0.0205037$, comfortably inside the budget $\lVert r_1\rVert^2=t-u^2=0.153777$, so the bound is not self-contradictory;
- $\max(\mu-x)=1$ over unit $\hat q$, attained at $(x,y,z)=(-\tfrac12,\tfrac12,0)$: writing $x=-a$ gives $\mu-x=\tfrac12\big(3a+\sqrt{1-3a^2}\big)$, maximal at $a=\tfrac12$;
- **gain $\le1\times0.0205037\times0.438432=0.0089895$, against a deficit of $0.0148$.**

**The most generous accounting reaches $61\%$ of the deficit, short by a factor of about $1.65$, and that is before the sign condition of (a) or the scope of section 8 is imposed.** Both of those only reduce it further.

**Stated as a screen and not as evidence.** The arithmetic assumes the crude bound has the shape the brief quotes and that the gain is $(\mu-x)(p^2+p'^2)\lVert q\rVert$. If the record's constant differs, the comparison scales with it, so the thing to recheck is the ratio to the deficit rather than the direction of the conclusion.

**What genuinely survives, and the item should record this instead.** The spendable content is not the quadratic lower bound. It is that $p+p'$ is pinned EXACTLY. Writing $s=\tfrac13(x_2+x_3)$ and $d=p-p'$, so that $p^2+p'^2=\tfrac12(s^2+d^2)$, the expansion's entire dependence on $p$ and $p'$ becomes

$$\tfrac{x}2\big(s^2+d^2\big)+s\big[z(a'+b')+y(c'+d')\big],$$

with $s$ known and one free parameter $d$ whose direction is governed by the sign of $x$. That is a cleaner and strictly stronger statement than the one on file, it makes the sign condition visible rather than hidden, and it shows that the linear term in $\Sigma$ is fully determined, which the bound version loses.

## What the round should carry away

- **Fix the symbol collision first.** Claim 3 and the GIVEN cross-Gram are written in different letters for $x_a$, and under the GIVEN's letters claim 3 forces $x_2+x_3=0$. Choose the component reading and restate the GIVEN as $\langle q_1,q_2\rangle=c_1c_2$.
- **Replace claim 7 with the identity it conceals**, $p=\tfrac13(2x_2-x_3)$ and $p'=\tfrac13(2x_3-x_2)$, hence $p^2+p'^2=\tfrac19(5x_2^2-8x_2x_3+5x_3^2)$. The note's "cannot feed an identity" is false, and the bound it settled for is vacuous exactly at $x_2+x_3=0$ where the identity is not.
- **Carry $\tau_1$ rather than a scope hypothesis**, giving $p+p'=\tfrac13(x_2+x_3)+\tau_1$ with $\tau_1$ the common pair-sum of the off-span component. Note for anyone screening the scope that $\tau_1\equiv0$ at $n=6$ and is nonzero from $n=7$.
- **Record the sign condition on $c$ as a hypothesis of any use of this link**, since without it the lower bound moves $\kappa$'s bound the wrong way.
- **The coupling source does not close the $0.0148$ deficit by this route.** The ceiling on the improvement is $0.0090$ under assumptions that favour it throughout.

**Overall verdict.** `GAP`. Claims 1 to 6 and 9 are correct and the derivation behind them is sound once claim 3's reason is restated. Claim 7 is refuted and understates the result. Claim 8 stands with a sharper repair. Claim 10 is refuted, and its quantitative failure retires this link as a route to the deficit, which is the finding the brief anticipated.

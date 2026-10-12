# VERIFY v54, L147-r2: the $\Theta(n^{-1})$ ceiling holds exactly, the refutation of $r_n\gtrsim n^{-1-\beta}$ does not, and the entry states both

**Cold brief, no numerical work, every value below is an exact hand evaluation.** Text under review: the "brief as dispatched" of [ROUND_L147r2](ROUND_L147r2.md), quoted verbatim from [findings/second-order.md](../findings/second-order.md):1163–1188 (checked line by line against the source; the quotation is faithful, provenance links restored). Reports read at source because the entry cites them for the steps in question: [r450](../reviews/REVIEW_r450.md), [r451](../reviews/REVIEW_r451.md), and the imports [L27](../findings/nondegeneracy.md), [L143](../findings/bounds.md), [L145](../findings/second-order.md), [L146](../findings/second-order.md), [L148](../findings/second-order.md). Log: [agent_logs/verify-L147r2-v54.log](../agent_logs/verify-L147r2-v54.log).

## Claim table

| # | claim as written in the entry | verdict |
|---|---|---|
| 1 | $r_n\gtrsim n^{-3/2}$ on $\beta\in[0,\tfrac12]$ | **PROVEN**, and strictly weaker than the entry's own ingredients give |
| 2 | the route is capped at $\Theta(n^{-1})$, by $c_p/S\le c_p/\theta_0=3/(n-2)$ | **PROVEN**, exact and unconditional in $\beta$ |
| 3 | "$\beta=\tfrac12$ gives $n^{-3/2}$ … $\beta=0$ gives $n^{-1}$ and is plausible with an unpinned constant" | **PROVEN**, it is [r451](../reviews/REVIEW_r451.md) A5 restated, and it is what the sweep returns |
| 4 | "the joint minimisation … does not reach $n^{-1-\beta}$: … its infimum is $2u^*/a=\Theta(n^{-3/2})$ at $w=\Theta(1)$" | **REFUTED** on the entry's own two sweep inequalities; the minimisation returns $\Theta(n^{-1-\beta})$ |
| 5 | "a single mixed direction with $u\asymp n^{-1/2}$, margin $\Theta(1/n)$ and $\lVert A''\rVert=\Theta(n)$ restores $n^{-3/2}$ at every $\beta$" | **REFUTED**, margin $\Theta(1/n)$ forces $w=O(n^{-1/2})$, which forces $\lVert A''\rVert=O(n^{1/2})$ |
| 6 | "the radius lives in $[n^{-3/2},n^{-1}]$"; "the validity cap $r_n\le\rho/2$" | **GAP**, a ceiling on the route stated as a bound on the radius, against [L145](../findings/second-order.md)'s explicit ruling in the same file |
| 7 | $M=O(\rho)$ because "$x\mapsto x_-$ is $1$-Lipschitz in Frobenius norm" | **GAP in the written reason**, that is a Hermitian fact and the Cauchy supremum runs over a complex circle; the valid derivation is in [r451](../reviews/REVIEW_r451.md) A2 and the entry cites the other one |
| 8 | four hypotheses, all used and now stated | **PROVEN, hypotheses corrected**: the inventory is complete and each is genuinely used |
| 9 | the two-branch calculus: $f'(0)=-ac_p/S^2<0$, $u^*=(\sqrt{S^2+a^2c_p}-S)/a$, $f(u^*)=2u^*/a=\Theta(\min(c_p/S,\sqrt{c_p}/a))$ | **PROVEN**, re-derived by hand |
| 10 | "$g_n$, $\rho$, $M$ and branches 2–3 do not exist" at $\ker W\ne0$ | **GAP (minor)**, the entry proves four lines below that there are two branches, not three |
| 11 | [results.md](../results.md) carries no canonical L147 | **correct as an absence**, but it carries L147's branch-1 clause inside its L149 paragraph with "$u=\Theta(1)$", which is false in closed form |

**One line the round can act on:** the displayed lemma and its ceiling stand exactly as written, but the paragraph that closes the radius debt "by refutation" is itself refuted by the two inequalities the entry states one paragraph above it, so the debt on $r_n\gtrsim n^{-1-\beta}$ re-opens, and the sweep in [r451](../reviews/REVIEW_r451.md) A1, which the entry cites, pays it.

## 0. Conventions, fixed once

- $W^*=S^m\times S^m$, $n=2m$, $\lVert W^*\rVert_F=1$; directions $H$ with $\lVert H\rVert_F=1$, $H\perp W^*$, $H\perp T_{W^*}\mathcal O$.
- $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$, increasing to $\sqrt2$. Exactly: $\theta_0(10)=6/5$ so $\theta_0(10)^2=1.44$; $\theta_0(12)=\sqrt{220}/12=1.236033\ldots$; $\tfrac32\theta_0(12)=1.854049\ldots$ Both reproduce [L145](../findings/second-order.md)'s numerals.
- $S=\sup\lvert P\rvert$, assumed $\Theta(n^\beta)$; $c_p=3\theta_0/(n-2)$, so $c_p(12)=\sqrt{220}/40=0.370809\ldots$ and $\kappa=nc_p=3\sqrt{2(n-1)/(n-2)}$, $\kappa(12)=4.4497\ldots$, reproducing [results.md](../results.md):363's $\approx4.45$.
- $g_n=\tfrac2n\sqrt{\tfrac{n-2}{2(n-1)}}=\Theta(1/n)$; $g_{12}=0.1123\ldots$
- $\rho$ = radius of the complex analyticity disc along $H$, $\rho=\Omega(g_n/\lVert H\rVert_{op})$; $A(z)=\mathrm{Alt}(W(z)_-)$ with $W(z)=W^*+zH$; $M=\sup_{\lvert z\rvert=\rho}\lVert A(z)\rVert$; $a=\lVert A''\rVert$.
- $w=\lVert H_r\rVert_F$ is the weight of $H$ off the joint $\lambda_m$-eigenspace $\Sigma$; $u=\lVert A'(0)[H]\rVert$ is the defect modulus. **These are two variables, related by $u\lesssim w$** ([r451](../reviews/REVIEW_r451.md), through [L133](../findings/second-order.md)'s $u\le\tfrac{\sqrt2}3v$). The whole of §3 turns on that.

## 1. Hypothesis inventory

**Carried by the statement.** (i) base point $W^*=S^m\times S^m$; (ii) $n=2m$ even; (iii) $n\ge12$; (iv) $\ker W^*=0$; (v) the hypothesis $\sup\lvert P\rvert=\Theta(n^\beta)$; (vi) implicitly, the quantifier of [L145](../findings/second-order.md), $\lVert H\rVert_F=1$ **with** $H\perp W^*$ and $H\perp T_{W^*}\mathcal O$.

**Used by the written proof.** (i) yes, for $c_p$ and for [L27](../findings/nondegeneracy.md)'s ten summands. (ii) yes, the balanced product needs it. (iii) yes: $m\ge5$ is what puts the margin on $S^2_0(\mathbb R^m)$, and $n\ge12$ gives $m=6$. (iv) yes, and only here: $g_n>0$ is what gives $\rho$, $M$ and the Cauchy estimate; the ceiling of claim 2 does not use it. (v) **used nowhere in the displayed conclusion**, $r_n\gtrsim n^{-3/2}$ carries no $\beta$, and the entry proves $\beta\in[0,\tfrac12]$ always, so the hypothesis restricts nothing. It is live only in the bold clause and in §3. (vi) yes, and the entry states its own use of it: dropping $H\perp W^*$ puts the margin floor at $-\tfrac32\theta_0$, dropping $H\perp T_{W^*}\mathcal O$ puts it at $0$.

**Imported hypotheses, each against the object it applies to.**

| import | its hypotheses | met here? |
|---|---|---|
| [L143](../findings/bounds.md) | gives $\sup\lvert P\rvert\le1+\sqrt{n-2}$ | yes; this is the whole of $\beta\le\tfrac12$ |
| [L145](../findings/second-order.md) | $n=2m\ge12$; $\lVert H\rVert_F=1$, $H\perp W^*$, $H\perp T_{W^*}\mathcal O$; two-valued spectrum with no kernel | yes, and (iv) is exactly its no-kernel clause |
| [L146](../findings/second-order.md) | $m\ge3$ for the norm identity, $m\ge5$ for the margin to sit on that summand; **stated for a single $h\in S^2_0(\mathbb R^m)$** | met at $n\ge12$. The entry uses the bound on the **joint two-copy** eigenspace. That is licensed, L146's cross-branch clause proves the supremum unchanged, the cross branch capping at $\sqrt{m-2}/m<1/\sqrt{m-1}$, but the licensing sentence names [L149](../findings/second-order.md) as the consumer and not L147. **No finding: the licence is on file; only its addressee is incomplete.** |
| [L148](../findings/second-order.md) | $m\ge3$, $m\ge5$ for the word "margin", frame chosen after $H$ | met; and its conclusion is used in the strong form (defect $\equiv0$ on $\Sigma$), which is what makes branch 2 absent at $w=0$ |
| [L27](../findings/nondegeneracy.md) | $p,q\ge3$ for multiplicity-freeness and hence for "$L_e$ is scalar on each summand" | met at $m=6$ |

**No finding: the proof uses no hypothesis the statement omits.** The four the entry lists are the four it uses, and I could not find a fifth. The one hypothesis in the statement that the proof does **not** use is (v).

**One import I read only through its citation.** "$c(H)\gtrsim c_p+w^2$ since $L_e$ is scalar on each summand" is attributed to r449 V4. I did not read r449; I reconstructed the fact from [L27](../findings/nondegeneracy.md) instead and it holds, see §5.

## 2. The ceiling: proved, and it is a ceiling on the route

Statement checked: "*The $\Theta(n^{-1})$ ceiling is proved, by $c_p/S\le c_p/\theta_0=3/(n-2)$ alone, exact and unconditional in $\beta$.*"

$\sup\lvert P\rvert\ge P(W^*)=\theta_0(n)$, and $c_p=3\theta_0/(n-2)$, so

$$\frac{c_p}{S}\;\le\;\frac{c_p}{\theta_0}\;=\;\frac{3\theta_0}{(n-2)\theta_0}\;=\;\frac3{n-2},$$

an identity, not an estimate: the $\theta_0$ cancels exactly and nothing about $P$ beyond $S\ge\theta_0$ is used. At $n=12$ this is $3/10$ exactly. Branch 1 evaluated at $u=0$ is $c_p/S$, so the chain's infimum is $\le3/(n-2)=\Theta(n^{-1})$ at every $n\ge3$ and every $\beta$. **PROVEN.**

**What kind of object this is.** It is an upper bound on $\inf_{H,u}$ of an expression every one of whose ingredients bounds a numerator below or a denominator above. It therefore bounds *what the chain can deliver*, and says nothing about $r_n$. [L145](../findings/second-order.md) states this in terms: "*the only "$\le$" on file is L147's $\Theta(n^{-1})$ ceiling, **which caps what the route can prove rather than the radius***", and "*The chain cannot yield an upper bound at all*". [r451](../reviews/REVIEW_r451.md) is equally careful, "$r_n=O(g_n)=O(n^{-1})$ **for this method**", and at its close, "*this audit establishes that the ceiling is $\Theta(n^{-1})$ … not that $\Theta(n^{-1})$ is attained*".

**Pre-registered question 2, answered.** It is a ceiling on the method. The entry draws the distinction once, correctly, in the box ("*and the route is capped at $\Theta(n^{-1})$*") and violates it twice:

1. "*So the radius lives in $[n^{-3/2},n^{-1}]$*". The upper end of that interval is not a fact about $r_n$.
2. "*the validity cap $r_n\le\rho/2$ is $O(g_n)$ on the directions where $\rho=\Theta(g_n)$*". Written as an inequality on $r_n$ itself. The source it comes from writes "*$r(H)\le\rho(H)/2$ for every $H$ … $r_n=O(g_n)=O(n^{-1})$ **for this method**, whatever the branches say*", the four words that make it a statement about the Cauchy estimate's domain of validity are the ones dropped.

*Three-step record.* **Located:** the two sentences quoted. **Failure exhibited:** each asserts an upper bound on $r_n$; no chain ingredient can produce one, because $c(H)$ enters only through a lower bound ($c\ge c_p$, $c\gtrsim c_p+w^2$) and $C(H)$ only through an upper bound (Cauchy), so the quotient is a lower bound for every $H$ and its infimum bounds $r_n$ only from below. **Argued the opposite:** the most charitable reading is "the radius *as this route bounds it* lives in $[n^{-3/2},n^{-1}]$", which is true and is what the surrounding paragraph is about. I keep the finding at **GAP** rather than withdrawing it, for one reason that is not stylistic: [L145](../findings/second-order.md) records that on the immediately preceding entry this exact elision (a box saying $\Theta$ while the step table said "lower bound"), is "*what the indexes propagated*". The charitable reading is available to a careful reader and was not available to the index.

**No finding on the four ways.** The paragraph "false four separate ways" carries three supports beyond the proved one; the ceiling rests on way one alone, which is claim 2, so nothing load-bearing sits on the other three. $\beta\ge0$ from $\sup\lvert P\rvert\ge\theta_0\uparrow\sqrt2$ is correct; $\beta\le\tfrac12$ from [L143](../findings/bounds.md) is correct.

## 3. The refutation of $r_n\gtrsim n^{-1-\beta}$ fails on the entry's own two inequalities

This is the finding of the round, and it answers pre-registered question 1 in the opposite direction to the one the question anticipates.

**Located.** "*The minimisation has now been done and it does not reach $n^{-1-\beta}$: branch 1 is $(c_p+u^2)/(S+au)$ with $f'(0)=-ac_p/S^2<0$, so its infimum is $2u^*/a=\Theta(n^{-3/2})$ at $w=\Theta(1)$, too large on all of $\beta\in[0,\tfrac12)$.*"

**The calculus itself is right.** With $f(u)=(c_p+u^2)/(S+au)$,

$$f'(u)=\frac{2u(S+au)-a(c_p+u^2)}{(S+au)^2},\qquad f'(0)=-\frac{ac_p}{S^2}<0,$$

the stationary point solves $au^2+2Su-ac_p=0$, giving $u^*=(\sqrt{S^2+a^2c_p}-S)/a$, and from $a(c_p+u^2)=2u(S+au)$ one gets $c_p+u^{*2}=(2u^*/a)(S+au^*)$, hence $f(u^*)=2u^*/a$. Since $\sqrt{S^2+a^2c_p}\le S+a\sqrt{c_p}$ and $\ge\max(S,a\sqrt{c_p})$, $f(u^*)=\Theta(\min(c_p/S,\sqrt{c_p}/a))$. All of claim 9 re-derived, **PROVEN**.

**The failure.** The same inequality gives, exactly,

$$u^*\;=\;\frac{\sqrt{S^2+a^2c_p}-S}{a}\;\le\;\sqrt{c_p}\;=\;\sqrt{\frac{3\theta_0}{n-2}}\;=\;\Theta(n^{-1/2}),$$

so the minimiser of branch 1 is at $u=\Theta(n^{-1/2})$ at every $a$ and every $S$, never at $\Theta(1)$. At $n=12$, $\sqrt{c_p}=0.608940\ldots$, which is why the bound looks unremarkable at the record's smallest dimension and is decisive asymptotically; the statement under test is asymptotic. The entry's own neighbouring paragraph agrees with $\Theta(n^{-1/2})$ and not with $\Theta(1)$: "*a single mixed direction with $u\asymp n^{-1/2}$*".

So the clause "at $w=\Theta(1)$" can only be read with $w\ne u$, which is correct as bookkeeping, since $w$ is the off-summand weight and $u\lesssim w$ the defect modulus. **And read that way it is refuted, because the two are coupled and the entry states the coupling.** The entry's two sweep inequalities, quoted one paragraph above the passage under test, are

$$\lVert H\rVert_{op}\le\Theta(n^{-1/2})+w,\qquad c(H)\gtrsim c_p+w^2\quad\text{uniformly in }w\in[0,1],$$

and its own Cauchy line gives $a=\lVert A''\rVert=O(1/\rho)=O(n\lVert H\rVert_{op})$. Combining:

$$a\;=\;O\big(n\max(n^{-1/2},w)\big),\qquad \text{numerator}\;=\;c(H)\;\gtrsim\;c_p+w^2 .$$

At $w=\Theta(1)$ the coefficient is indeed $a=\Theta(n)$, **and the numerator is then $\Theta(1)$, not $c_p+u^{*2}=\Theta(1/n)$.** With $u\le w\le1$ and $S\le1+\sqrt{n-2}$,

$$\text{branch 1 at }w=\Theta(1)\;\gtrsim\;\frac{\Theta(1)}{S+\Theta(n)}\;=\;\Theta(n^{-1}),$$

not $\Theta(n^{-3/2})$. The reported infimum is obtained by reading the numerator at $w\asymp n^{-1/2}$ and the coefficient $a$ at $w=\Theta(1)$, one variable substituted for another, at the two ends of a single fraction.

**And the joint minimisation, done as a joint minimisation, reaches $n^{-1-\beta}$.** Substituting the two sweep inequalities and $u\lesssim w$ into branch 1 gives the one-variable function [r451](../reviews/REVIEW_r451.md) A1 displays,

$$g(w)\;=\;\frac{c_p+w^2}{S+n\max(n^{-1/2},w)\,w},\qquad w\in[0,1].$$

Both regions, by hand, with $c_p=\Theta(1/n)$ and $\theta_0\le S=\Theta(n^\beta)$, $\beta\in[0,\tfrac12]$:

- $w\le n^{-1/2}$: denominator $=S+n^{1/2}w\in[S,S+1]=\Theta(S)$, numerator $\asymp c_p=\Theta(1/n)$. So $g=\Theta(1/(nS))=\Theta(n^{-1-\beta})$, with equality at $w=0$, where $g(0)=c_p/S$.
- $w\ge n^{-1/2}$: denominator $=S+nw^2$, numerator $\asymp w^2$ (as $w^2\ge1/n\gtrsim c_p/5$). If $nw^2\ge S$ then $g\gtrsim1/n\ge n^{-1-\beta}$; if $nw^2<S$ then $g\gtrsim w^2/S\ge1/(nS)=\Theta(n^{-1-\beta})$.

Hence $\min_{w}g=\Theta(n^{-1-\beta})$, attained at $w=0$; the quartic branch is $\sqrt{c_p+w^2}/a=\Theta(n^{-1})$ uniformly ($\sqrt{c_p}/n^{1/2}$ below $n^{-1/2}$, $w/(nw)$ above), and $\min(n^{-1-\beta},n^{-1})=n^{-1-\beta}$ for $\beta\ge0$. **The minimisation reaches $n^{-1-\beta}$ at every $\beta\in[0,\tfrac12]$**, which is the statement the entry says it refutes. At $\beta=\tfrac12$ that is $n^{-3/2}$ and at $\beta=0$ it is $n^{-1}$, the two values the entry's own box carries.

**Argued the opposite.** The most charitable reading is that "*it does not reach $n^{-1-\beta}$*" means the single-variable minimisation of A3, at $a$ held at the direction-blind $\Theta(n)$, does not reach it, which is true of that one-variable problem. But that problem is not the joint one the debt named, it holds $a$ at a value the sweep only permits at $w=\Theta(1)$, and the entry's next sentence, "*Both reviewers closed the sweep the lemma owed*", says explicitly that the joint one was done. It was; it returns $n^{-1-\beta}$. **REFUTED.**

**Pre-registered question 1, answered.** The entry does not state one thing about its radius: the box says $\beta=0$ gives $n^{-1}$ and the debt block says the $\beta$-dependent floor is refuted, and these cannot both hold, since $n^{-1}$ *is* $n^{-1-\beta}$ at $\beta=0$. The question's framing (that the surviving claim is the leftover and the refutation the correction), inverts the truth here: the box is faithful to [r451](../reviews/REVIEW_r451.md) A5, whose two rows read "$\Omega(n^{-3/2})$, CONFIRMED" and "$\Omega(n^{-1})$ with an unpinned constant, at the edge of validity"; it is the refutation sentence that is new and wrong. **The debt on $r_n\gtrsim n^{-1-\beta}$ is not closed by refutation. It re-opens, and the sweep the entry cites pays it.**

## 4. "Restores $n^{-3/2}$ at every $\beta$" is false, and the source states it conditionally

**Located.** "*A single mixed direction with $u\asymp n^{-1/2}$, margin $\Theta(1/n)$ and $\lVert A''\rVert=\Theta(n)$ restores $n^{-3/2}$ at every $\beta$.*"

**Failure exhibited.** The three attributes cannot co-exist under the entry's own inequalities. Margin $\Theta(1/n)$ requires $c_p+w^2=\Theta(1/n)$, hence $w=O(n^{-1/2})$; then $\lVert H\rVert_{op}\le\Theta(n^{-1/2})+w=\Theta(n^{-1/2})$, so $\rho=\Omega(n^{-1/2})$ and $a=O(1/\rho)=O(n^{1/2})$, a factor $n^{1/2}$ below the asserted $\Theta(n)$. Evaluating branch 1 at that admissible direction, with $u\le w=\Theta(n^{-1/2})$:

$$\frac{c_p+u^2}{S+au}\;=\;\frac{\Theta(1/n)}{S+O(n^{1/2})\cdot\Theta(n^{-1/2})}\;=\;\frac{\Theta(1/n)}{\Theta(S)}\;=\;\Theta(n^{-1-\beta}),$$

which at $\beta=0$ is $\Theta(n^{-1})$ and not $\Theta(n^{-3/2})$. The sentence therefore fails at exactly the endpoint that matters.

**Argued the opposite.** Read "$\lVert A''\rVert=\Theta(n)$" as naming the *coefficient* $a$ in $S+au$ rather than the value of $\lVert A''\rVert$ at the witness, and the arithmetic closes: $au=\Theta(n)\cdot\Theta(n^{-1/2})=\Theta(n^{1/2})$ and the quotient is $\Theta(n^{-3/2})$. That is the reading under which the entry's numbers cohere, and it is a constant read at the direction-blind $\rho=\Theta(g_n)$ and used at a direction whose $\rho$ is $\Theta(n^{-1/2})$, the failure mode this block has recorded twice, once as [L145](../findings/second-order.md)'s "*$M=O(g_n)$ … carried onto a disc where $O(\rho)$ is the content*" and once in the entry's own $M$ paragraph. Under either reading the sentence is unsound, so it is not withdrawn.

**And the source states it conditionally.** [r451](../reviews/REVIEW_r451.md) writes "*At that direction, $\lVert A''\rVert=\Theta(n)$ **would** restore $n^{-3/2}$ at every $\beta$*", in the paragraph arguing that the mixed directions are unpriced, and then prices them in the next paragraph, concluding "$\Theta(n^{-1})$ at $\beta=0$ and $\Theta(n^{-3/2})$ at $\beta=\tfrac12$". The entry keeps the conditional sentence as a flat assertion and then, in the same paragraph, writes that the sweep "*returns these values*", the box's two values, which are the sweep's, not this sentence's. **REFUTED**, and the contradiction is internal to one paragraph.

## 5. The two sweep inequalities, checked against [L27](../findings/nondegeneracy.md) rather than through the citation

The margin interpolation is the load-bearing import for §3 and the entry attributes it to a review. I reconstructed it from the record's own ten-summand table.

[L27](../findings/nondegeneracy.md) gives $\mathrm{Weyl}_n=\langle W\rangle\oplus\mathrm{Weyl}_p\oplus\mathrm{Weyl}_q\oplus(\mathbb R^p\otimes\mathbb R^q)\oplus S^2_0(\mathbb R^p)\oplus S^2_0(\mathbb R^q)\oplus(S^2_0\otimes S^2_0)\oplus(\Lambda^2\otimes\Lambda^2)\oplus(X_p\otimes\mathbb R^q)\oplus(X_q\otimes\mathbb R^p)$, multiplicity-free at $p,q\ge3$, with $L_e$ scalar on each: $1$ on $\langle W\rangle$; $\tfrac12$ on $\mathbb R^p\otimes\mathbb R^q$; $\lambda_m=\tfrac{m-2}{2(m-1)}$ on $S^2_0(\mathbb R^m)$; $-\mu$ on $S^2_0\otimes S^2_0$ and $+\mu$ on $\Lambda^2\otimes\Lambda^2$ with $\mu=1/(m-1)$; $0$ on $\mathrm{Weyl}_p,\mathrm{Weyl}_q,X_p\otimes\mathbb R^q,X_q\otimes\mathbb R^p$.

Reading the margin as $c_j=3\theta_0(\tfrac12-\lambda_j)$ reproduces three independent numerals of the record and so fixes the convention: $\langle W\rangle$ gives $-\tfrac32\theta_0$ ([L145](../findings/second-order.md)'s floor at $H=W^*$), the orbit summand gives $0$ ([L145](../findings/second-order.md)'s "$c(H)=0$ at an orbit tangent"), and $S^2_0$ gives $3\theta_0\cdot\tfrac1{2(m-1)}=3\theta_0/(n-2)=c_p$ ([L146](../findings/second-order.md)'s exact margin). Then, on the eight off-orbit summands:

| summand | $\lambda_j$ | $c_j$ |
|---|---|---|
| $\mathrm{Weyl}_p$, $\mathrm{Weyl}_q$, $X_p\otimes\mathbb R^q$, $X_q\otimes\mathbb R^p$ | $0$ | $\tfrac32\theta_0=\Theta(1)$ |
| $S^2_0(\mathbb R^p)$, $S^2_0(\mathbb R^q)$ | $\tfrac{m-2}{2(m-1)}$ | $3\theta_0/(n-2)=c_p=\Theta(1/n)$ |
| $S^2_0\otimes S^2_0$ | $-\tfrac1{m-1}$ | $3\theta_0(\tfrac12+\tfrac1{m-1})=\Theta(1)$ |
| $\Lambda^2\otimes\Lambda^2$ | $+\tfrac1{m-1}$ | $3\theta_0(\tfrac12-\tfrac1{m-1})=\Theta(1)$ at $m\ge5$ |

Every off-orbit $c_j$ is positive and only the two $S^2_0$ copies are $o(1)$, so $c(H)=\sum_jc_j\lVert H_j\rVert^2\ge c_p\lVert H_s\rVert^2+\Theta(1)w^2\gtrsim c_p+\Theta(1)w^2$. **No finding: the inequality holds, and it holds for the reason the entry gives.** Two by-products confirm the dimension floor: $\lambda_m-\mu=\tfrac{m-4}{2(m-1)}$ exactly, so $\lambda_m>\mu$ (the margin sitting on $S^2_0$), needs $m\ge5$, and at $m=3$ the $\Lambda^2\otimes\Lambda^2$ margin is $3\theta_0(\tfrac12-\tfrac12)=0$, which is [L145](../findings/second-order.md)'s "$m=3$ gives margin zero". The operator-norm interpolation $\lVert H\rVert_{op}\le\lVert H_s\rVert_{op}+\lVert H_r\rVert_{op}\le\Theta(n^{-1/2})+w$ is the triangle inequality together with $\lVert\cdot\rVert_{op}\le\lVert\cdot\rVert_F$ and [L146](../findings/second-order.md)'s supremum $1/\sqrt{m-1}$; **no finding**.

## 6. $M=O(\rho)$: the written reason is a Hermitian fact, the disc is complex, and the valid derivation is in the report the entry cites

**Located.** "*$M=\sup_{\lvert z\rvert=\rho}\lVert A\rVert$ is a supremum over the disc, so it grows with it: $x\mapsto x_-$ is $1$-Lipschitz in Frobenius norm and $\lVert\mathrm{Alt}\rVert\le1$, giving $M=O(\rho)$.*"

**Failure exhibited.** The 1-Lipschitz property of $x\mapsto x_-$ in Frobenius norm is the statement that $x\mapsto x_+$ is the metric projection onto the positive semidefinite cone, a closed convex cone **in the real space of self-adjoint operators**; that is where the projection is nonexpansive. The Cauchy supremum is taken over $\lvert z\rvert=\rho$, and at $z\notin\mathbb R$ the operator $W(z)=W^*+zH$ is complex symmetric and not self-adjoint: its spectrum is complex, $W(z)_-$ is a Riesz projection $-W\Pi$ rather than a spectral $\min(\cdot,0)$, there is no convex cone and no metric projection, and the cited fact has no content on the domain of the estimate. The entry's own source states the hypothesis and the entry drops it: [r450](../reviews/REVIEW_r450.md) writes "*$x\mapsto x_-$ $1$-Lipschitz in Frobenius norm **on Hermitian operators***" and then applies it at $\lvert z\rvert=\rho$, so the hypothesis is lost at the source and the loss is inherited.

**Argued the opposite, and this is why the verdict is a gap in the reason and not a debt.** The brief's instruction to read the cited reports before recording a debt is load-bearing here. [r451](../reviews/REVIEW_r451.md) A2 derives the same conclusion by a route that never mentions Hermiticity: with $A(0)=\mathrm{Alt}(W^*_-)=0$, $\lVert\mathrm{Alt}\rVert\le1$ and $W_-=-W\Pi$,

$$\lVert A(z)\rVert\le\underbrace{\lVert W(z)-W^*\rVert_F\lVert\Pi(z)\rVert_{op}}_{O(\rho)\cdot O(1)}+\underbrace{\lVert W^*\rVert_{op}\lVert\Pi(z)-\Pi(0)\rVert_F}_{\Theta(g_n)\cdot O(\rho/g_n)}=O(\rho),$$

every step of which is valid for complex $z$: the resolvent bound $\lVert(\zeta-W(z))^{-1}\rVert=O(1/g_n)$ holds by Neumann series once the perturbation is at most half the gap, which is precisely how the disc $\rho=\Omega(g_n/\lVert H\rVert_{op})$ is defined; the contour has length $\Theta(g_n)$, so $\lVert\Pi(z)\rVert_{op}=O(1)$; and $\lVert W^*\rVert_{op}=\Theta(g_n)$ because the balanced product's spectrum is two-valued with both values $\Theta(1/n)$ at $\lVert W^*\rVert_F=1$. **So $M=O(\rho)$ is established on file, for the complex disc, in a report this entry cites for this very step, and the entry chose the other report's one-line reason, which is the one that does not survive the domain.** Verdict: **GAP in the written reason**, not `HYPOTHESIS-DEBT`.

**What I could not do.** I looked for a closed-form violation of $M\le C\rho$ itself and did not find one. On the complex-symmetric family $W(z)=\begin{pmatrix}\epsilon&z\\z&-\epsilon\end{pmatrix}$, which is the nearest thing to a Jordan block reachable from a real-symmetric base along a real-symmetric direction, $W(z)_-=\tfrac12(W(z)-qI)$ with $q^2=\epsilon^2+z^2$, and $\lVert W(z)_--W^*_-\rVert_F/\lvert z\rvert$ stays at $\tfrac1{\sqrt2}$ or below all the way to the collision $q\to0$. So the failure I report is a failure of the stated *reason*, exhibited on the reason's own hypothesis, and not a counterexample to the conclusion.

**Downstream, the arithmetic is right.** $\lVert A''(0)\rVert\le2M/\rho^2=O(1/\rho)$; at $\rho=\Omega(n^{-1/2})$ that is $O(n^{1/2})$, and at $\rho=\Theta(g_n)$ it is $O(n)$, "*which returns the record's own $O(n)$*", reproduced. Note that on the margin summand the quantity bounded is identically zero by [L148](../findings/second-order.md), which the entry says itself when disowning reason (b); $0=O(n^{1/2})$, so there is no contradiction, only a bound priced on an absent quantity.

## 7. The edges of every range

- **Smallest admissible dimension.** "$n\ge12$, which the imports force through $n^2-12n+8>0$": the roots are $6\pm2\sqrt7$ and $2\sqrt7=5.29150\ldots$, so the condition is $n>11.29150\ldots$ and the smallest even $n$ is $12$. **Reproduced.** The quadratic itself is [L149](../findings/second-order.md)'s constant chain, carried in [results.md](../results.md):363 as the pole of $\lambda=2/\sqrt{\lvert\kappa_n\rvert}$ at $n=6+2\sqrt7$; L147 does not cite L149 for it. No load rests on the citation, since $n=2m\ge12$ is [L145](../findings/second-order.md)'s own hypothesis and $m\ge6$ dominates the $m\ge3$ and $m\ge5$ floors of [L146](../findings/second-order.md) and [L148](../findings/second-order.md). **No finding beyond the missing citation.**
- **$\beta=0$.** $\sup\lvert P\rvert\ge\theta_0\uparrow\sqrt2$ forces $\beta\ge0$; correct. The value the entry attaches, $n^{-1}$, is the sweep's and is right, see §3, where the entry's own debt block contradicts it.
- **$\beta=\tfrac12$.** $c_p/S=\Theta(n^{-1}/n^{1/2})=\Theta(n^{-3/2})$, so ceiling and floor coincide there and "*pinned by the $P$-side branch alone*" is right, for the reason given. **No finding.**
- **$\ker W\ne0$, at $W_{\mathbb{CP}^2}$ with $\dim\ker W=3$.** Correct that $g_n$, $\rho$ and $M$ do not exist there: a kernel puts an eigenvalue on the boundary between the positive and negative parts, so no contour separates them and $z\mapsto W(z)_-$ is not analytic at the base point. **One minor finding:** the entry writes "*branches 2–3 do not exist there*" and proves four lines below that "*The chain has two branches, not three*"; [L148](../findings/second-order.md) also fixes the count at two. "Branches 2–3" is a leftover of the superseded three-branch labelling. **GAP (minor), cosmetic in effect**, under the corrected count the sentence should name branch 2 alone, and branch 1, $c_p/S$, is a statement at $W^*$ that has no reading at $W_{\mathbb{CP}^2}$ anyway.

## 8. Quantifiers, singular against plural, and the two forms

- **The $\min$ is not distributed.** $f(u^*)=\Theta(\min(c_p/S,\sqrt{c_p}/a))$ is a single minimum of one function of $u$, correctly obtained; the two arguments of the $\min$ are its two asymptotic regimes and not two independent branches. **No finding.**
- **What *is* distributed wrongly** is the pair $(u,w)$ of §3: a numerator read at one value of the shared variable and a coefficient at another. That is the round's finding, recorded there.
- **Singular against plural.** [L146](../findings/second-order.md) is stated for a **single** $h$; L147 applies its supremum to $H_s$ in the **joint** two-copy eigenspace. The licence exists (L146's cross-branch clause) and is written as licensing [L149](../findings/second-order.md). **No finding: the argument is on file; only its addressee is incomplete.** The parallel slip [L148](../findings/second-order.md) records ("*written singular, used plural by every citation, which is the slip that cost L149 a factor of $n$*") is not committed here.
- **Eight of ten.** Removing $\langle W\rangle$ and the orbit summand from L27's ten leaves eight; $H\perp W^*$ and $H\perp T_{W^*}\mathcal O$ remove exactly those two; the margin floor at ten would be $-\tfrac32\theta_0$. All three checked in §5. **No finding.**
- **The two forms.** [results.md](../results.md) carries **no** canonical L147, and no entry of the L141–L158 block appears in its "results at a glance"; L147 is likewise absent from the "Audit owed" list, correctly, since that list is for results a single reviewer or none has audited and L147 carries [r450](../reviews/REVIEW_r450.md) and [r451](../reviews/REVIEW_r451.md). **The absence is correct** while the corrected text is unread, which is what this round exists to change. **But [results.md](../results.md):363 carries L147's branch-1 clause inside its L149 paragraph, and carries it in a different variant:** "*$f(u^*)=2u^*/a$ is $\Theta(n^{-3/2})$ **at $u=\Theta(1)$***", against L147's "at $w=\Theta(1)$". The results.md form is false in closed form and has no charitable reading, by $u^*\le\sqrt{c_p}=\Theta(n^{-1/2})$ of §3, there is no second variable to appeal to, the sentence having named $u$ as "its own variable" two clauses earlier. **This is a finding against [results.md](../results.md), reported here because the brief asks for the comparison: the correction owed to L147's clause is owed to its neighbour too, and in the neighbour it is unambiguous.**
- **"Too large".** "*its infimum is $\Theta(n^{-3/2})$ …, too large on all of $\beta\in[0,\tfrac12)$*", the infimum is *smaller* than the claimed $n^{-1-\beta}$ when $\beta<\tfrac12$, so "too large" is wrong of the value. **Candidate withdrawn:** the reading "the *exponent* is too large", which is true ($\tfrac32>1+\beta$ there), is available and natural. Recorded as imprecision, not as a defect.

## 9. What would falsify the statement, and what I did to look for it

The object that would break claim 1 is a unit $H$ with $H\perp W^*$, $H\perp T_{W^*}\mathcal O$ at some even $n\ge12$ whose margin-to-Cauchy quotient is $o(n^{-3/2})$, concretely, a direction combining margin $O(1/n)$ with $\lVert A''\rVert$ genuinely of order $n$, which is the direction §4's sentence asserts and the sweep forbids.

Where I looked. The sweep forbids it only through the two inequalities of §5, so I checked both at source rather than through their citation: the margin one against [L27](../findings/nondegeneracy.md)'s ten scalars, where every off-orbit value is positive and only $S^2_0$ is $o(1)$; the operator-norm one is the triangle inequality on [L146](../findings/second-order.md)'s corrected supremum. The remaining escape is a negative $c_j$ on one of the eight, which would collapse the floor exactly as $\langle W\rangle$'s $-\tfrac32\theta_0$ does; the table shows there is none at $m\ge5$, and at $m=3$ there is a zero (on $\Lambda^2\otimes\Lambda^2$) which is why the dimension floor is a hypothesis and not bookkeeping. I found no falsifier.

The second object, which would break claim 2, is a proof that $\lVert A''\rVert$ is *saturated* at $O(M/\rho^2)$ somewhere, the ceiling is an upper bound on a denominator throughout, so nothing on file says $\Theta(n^{-1})$ is attained. [r451](../reviews/REVIEW_r451.md) names this as [r443](../reviews/REVIEW_r443.md)'s open item (iii) and leaves it untouched; so do I. **This is the one quantity in the entry I could not reproduce in any form: every $\lVert A''\rVert$ on file is an $O$, and §4's witness needs a $\Theta$.**

## Verdict

**GAP.**

The displayed lemma is sound: $r_n\gtrsim n^{-3/2}$ on $\beta\in[0,\tfrac12]$ holds, the $\Theta(n^{-1})$ ceiling on the route is proved exactly and unconditionally by one cancellation, the hypothesis inventory is complete and each of the four is used, and the branch calculus is correct as written. What fails is the entry's account of its own debt. Two passages are refuted on the entry's own inequalities, the claim that the joint minimisation does not reach $n^{-1-\beta}$, and the mixed-direction witness said to restore $n^{-3/2}$ at every $\beta$, and they contradict the box's two values, which are right. **The radius debt is therefore not closed by refutation; it re-opens, and the sweep in [r451](../reviews/REVIEW_r451.md) A1 that the entry cites appears to pay it, giving $r_n\gtrsim\Theta(\min(c_p/\sup\lvert P\rvert,\;n^{-1}))$, which is $n^{-1-\beta}$ across the admissible range.** Recording that as the entry's conclusion is the round's business and not mine. Alongside these: the route ceiling is stated twice as a bound on the radius; the $M=O(\rho)$ step cites the one of its two available derivations that does not survive the complex disc; and the same branch-1 clause stands in [results.md](../results.md):363 in a variant with no charitable reading.

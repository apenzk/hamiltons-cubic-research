# VERIFY v56, L147-r2: the surviving lower bound $r_n\gtrsim n^{-3/2}$, the $\Theta(n^{-1})$ ceiling, the endpoint clause at $\beta=0$, and the $M=O(\rho)$ substitution

**Cold brief, [ROUND_L147r2](ROUND_L147r2.md), text quoted from [findings/second-order.md](../findings/second-order.md):1163–1188. No numerical work was done: no script was run, and every numeral below is an exact hand evaluation from the closed forms the record names. Log: [agent_logs/verify-L147r2-v56.log](../agent_logs/verify-L147r2-v56.log).**

## Claim table

| # | claim as written in the entry | verdict |
|---|---|---|
| 1 | $r_n\gtrsim n^{-3/2}$ on $\beta\in[0,\tfrac12]$ | **PROVEN, HYPOTHESES CORRECTED.** The inequality is [L145](../findings/second-order.md)'s and stands. The box states no condition on $H$; without $\|H\|_F=1$, $H\perp W^*$ and $H\perp T_{W^*}\mathcal O$ the quantity is $\le0$ |
| 2 | the route is capped at $\Theta(n^{-1})$, proved by $c_p/S\le c_p/\theta_0=3/(n-2)$ | **PROVEN AS $O(n^{-1})$, NOT AS $\Theta$.** The identity is exact and unconditional in $\beta$, and I reproduce it. The route's own infimum is $\Theta(n^{-3/2})$ by this entry's own minimisation, so the $\Theta$ asserts attainment the entry elsewhere denies |
| 3 | "$\beta=0$ gives $n^{-1}$ and is plausible with an unpinned constant" (boxed) | **BROKEN.** It is $n^{-1-\beta}$ at $\beta=0$, the exact claim the body of the same entry declares refuted and "too large on all of $\beta\in[0,\tfrac12)$" |
| 4 | "the radius lives in $[n^{-3/2},n^{-1}]$" | **BROKEN.** A statement of the form $r_n=O(\cdot)$, which [L145](../findings/second-order.md) states appears nowhere in L146–L158 and which no ingredient of the chain can produce |
| 5 | "a single mixed direction with $u\asymp n^{-1/2}$, margin $\Theta(1/n)$ and $\|A''\|=\Theta(n)$" | **BROKEN.** The two inputs quoted one sentence later exclude it in closed form; [L149](../findings/second-order.md) exists to record that it does not exist |
| 6 | $M=O(\rho)$ because $x\mapsto x_-$ is $1$-Lipschitz in Frobenius norm and $\|\mathrm{Alt}\|\le1$ | **GAP.** The Lipschitz fact holds on Hermitian operators; the consumer integrates over the complex circle $\lvert z\rvert=\rho$, where $W^*+zH$ is not Hermitian. The conclusion is carried by the Riesz route in [r450](../reviews/REVIEW_r450.md)/[r451](../reviews/REVIEW_r451.md) and by [L156](../results.md), neither cited for it here |
| 7 | "the radius $r_n\gtrsim n^{-1-\beta}$ is refuted" | **GAP.** What the minimisation shows is that the chain does not deliver $n^{-1-\beta}$. Every branch is a lower bound, so a small value of the $\min$ refutes nothing about $r_n$; the status is withdrawn for want of proof |
| 8 | "all four used and none stated" (hypothesis box) | **BROKEN as an inventory.** $H\perp W^*$ and $H\perp T_{W^*}\mathcal O$ are used explicitly two paragraphs above and are not among the four; $\|H\|_{op}\le1$, which the $M$ bound needs, is nowhere |
| 9 | eight of [L27](../findings/nondegeneracy.md)'s ten summands; at ten the floor is $-\tfrac32\theta_0$ | **PROVEN.** Reproduced from L27's ten values: $\lambda=1$ on $\langle W\rangle$ gives $3\theta_0(\tfrac12-1)=-\tfrac32\theta_0$, and $\lambda=\tfrac12$ on the orbit summand gives $0$ |
| 10 | $\beta\ge0$ from $\sup\lvert P\rvert\ge\theta_0\uparrow\sqrt2$; $\beta\le\tfrac12$ from [L143](../findings/bounds.md) | **PROVEN.** Both reproduced exactly |
| 11 | $n\ge12$ forced by the imports through $n^2-12n+8>0$ | **PROVEN.** It is $\theta_0(n)>\sqrt{3/2}$ cleared of denominators; I reproduce the algebra and the root $6+2\sqrt7=11.2915$ |
| 12 | witness $W_{\mathbb{CP}^2}$, Morse–Bott nondegenerate with $\dim\ker W=3$ | **PROVEN AT $n=4$, USED AT $n\ge12$.** The numeral $3$ is [bounds.md](../findings/bounds.md)'s native-dimension value; padding raises it, and the nondegeneracy measurement on file stops at $n=10$ |
| 13 | canonical L147 in [results.md](../results.md) | **ABSENT, AND THE ABSENCE IS CORRECT.** But the L147 machinery that results.md does carry, inside L158, puts branch 1's minimiser at $u=\Theta(1)$ where the algebra gives $u^*=\Theta(n^{-1/2})$ |

**One line the round can act on: the inequality $r_n\gtrsim n^{-3/2}$ and the $O(n^{-1})$ cap on the method both survive, but the boxed endpoint clause still asserts the $n^{-1-\beta}$ the body refutes, three passages state the ceiling as a bound on $r_n$ rather than on the route, and the refutation that closed the debt derives an upper bound from a chain of lower bounds.**

## 0. Conventions, fixed once

- $n=2m$, $W^*$ the unit-norm Weyl tensor of $S^m\times S^m$, $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n=P(W^*)$ ([second-order.md](../findings/second-order.md):887, [conventions.md](../findings/conventions.md)).
- $S:=\sup\lvert P\rvert=\sup_{\|W\|=1}\lvert P(W)\rvert$, assumed $\Theta(n^\beta)$.
- $c_p=3\theta_0/(n-2)$ the margin on the two $S^2_0(\mathbb R^m)$ summands; $c(H)$ the margin at $H$; $w$ the weight of $H$ outside both copies; $u$ the defect's linear rate, with $u\le w$ the only relation on file ([L149](../findings/second-order.md)).
- $g_n=\sqrt{2(n-2)}/(n\sqrt{n-1})=\Theta(1/n)$ the spectral gap; $\rho=\gamma g_n/\|H\|_{op}$ the radius of the disc in $z$ for $W(z)=W^*+zH$; $M=\sup_{\lvert z\rvert=\rho}\|A(z)\|$ with $A(z)=\mathrm{Alt}(W(z)_-)$; $a:=\|A''\|$.
- Branches, as [L149](../findings/second-order.md) displays them: $b_1=(c_p+u^2)/(S+au)$, $b_2=\sqrt{c_p+\rho^{\mathrm{eff}}_nw^2}\big/(n^{1/2}+nw)$, $b_3=\rho(H)/2$, with $r(H)\gtrsim\min(b_1,b_2,b_3)$ and $r_n=\inf_H r(H)$.
- I write **route ceiling** for an upper bound on $\min(b_1,b_2,b_3)$ and **radius ceiling** for an upper bound on $r_n$. The whole of §3 turns on the two being different objects.

**Two identities I use repeatedly, both reproduced by hand.** $\tfrac12-\lambda_m=\tfrac1{2(m-1)}=\tfrac1{n-2}$, so the margin $3\theta_0(\tfrac12-\lambda_m)$ is exactly $c_p=3\theta_0/(n-2)$. And $f(u)=(c_p+u^2)/(S+au)$ has $f'(u)$ of the sign of $au^2+2Su-ac_p$, negative at $u=0$ and increasing, so the minimum is interior at $u^*=(\sqrt{S^2+a^2c_p}-S)/a$; the stationarity relation $a(c_p+u^{*2})=2u^*(S+au^*)$ gives $f(u^*)=2u^*/a$ directly.

## 1. The hypothesis inventory

**Carried by the statement, as boxed.** Only $\sup\lvert P\rvert=\Theta(n^\beta)$ and the range $\beta\in[0,\tfrac12]$. The box names no base point, no dimension, no direction class.

**Carried by the entry's hypothesis paragraph.** $W^*=S^m\times S^m$; $n=2m$ even; $n\ge12$; $\ker W^*=0$, described there as "all four used and none stated until a prior round".

**Used by the written proof and absent from both lists.**

| hypothesis | where the entry uses it | where it is stated |
|---|---|---|
| $\|H\|_F=1$ | the whole chain; [L146](../findings/second-order.md)'s $\|H\|_{op}=O(n^{-1/2})$ is a statement at unit Frobenius norm | [L145](../findings/second-order.md), [L149](../findings/second-order.md); **not here** |
| $H\perp W^*$ | "$\langle W\rangle$ and the orbit summand are removed exactly by $H\perp W^*$ and $H\perp T_{W^*}\mathcal O$" | quoted in the proof, **absent from the hypothesis box** |
| $H\perp T_{W^*}\mathcal O$ | same sentence | same |
| $\|H\|_{op}\le1$ | needed by [L156](../results.md), which is what actually delivers $M\le C\gamma g_n$ | **nowhere in the entry** |

Without the two orthogonality conditions the displayed object is not merely loose but non-positive: at $H=W^*$ the margin is $3\theta_0(\tfrac12-1)=-\tfrac32\theta_0$, which is $-1.85405$ at $n=12$, and on the orbit summand it is $0$. That is L145's own correction, and it has not reached this entry's hypothesis box, which counts four and says so emphatically.

**Hypotheses of the imports, each against the object it applies to.**

| import | its hypotheses | met here? |
|---|---|---|
| [L27](../findings/nondegeneracy.md) (ten summands, scalar $L_e$) | $p,q\ge3$, $(p,q)\ne(3,3)$ | yes: $p=q=m\ge6$ |
| [L146](../findings/second-order.md) ($\|H\|_{op}$ on the summand) | $m\ge3$ for the formula, $m\ge5$ for the margin to sit there, **a single** $h\in S^2_0(\mathbb R^m)$ | yes at $n\ge12$; the extension to the joint two-copy eigenspace is licensed by L146's own cross-branch clause, $\sqrt{m-2}/m<1/\sqrt{m-1}$ |
| [L148](../findings/second-order.md) (defect vanishes) | $m\ge5$ for the word "margin" | yes |
| [L149](../findings/second-order.md) (the sweep and branch 2) | $m\ge6$, i.e. $n\ge12$ | yes, and exactly at the floor |
| [L143](../findings/bounds.md) ($\sup\lvert P\rvert\le1+\sqrt{n-2}$) | supremum at unit norm | yes, same object |
| [L156](../results.md) (the contour constant behind $M$) | $\|H\|_{op}\le1$, $0<\alpha<D$, $0<\gamma<\min(d,1)$ | **not checked in the entry, which does not cite it** |

**Which hypotheses the surviving conclusions actually use.** The route ceiling uses $S\ge\theta_0$ and nothing else, not $\Theta(n^\beta)$, not $\beta\le\tfrac12$. The lower bound $n^{-3/2}$ uses $S=O(\sqrt n)$, which [L143](../findings/bounds.md) supplies as a fact rather than as a hypothesis. **So the statement's headline hypothesis, $\sup\lvert P\rvert=\Theta(n^\beta)$, is used by neither of the two conclusions that survive, and both are uniform in $\beta$ across the whole closed interval.** That is the cleanest statement of what the refutation did to this entry, and §2 is its consequence.

No finding on the dimension floor: $n\ge12$ is exactly what the imports need, and the entry's stated reason for it is right, $\lvert\kappa_n\rvert=9(\theta_0-\sqrt{3/2})$ carries its sign iff $\theta_0>\sqrt{3/2}$, i.e. $2(n-1)(n-2)/n^2>3/2$, i.e. $4n^2-12n+8>3n^2$, i.e. $n^2-12n+8>0$, whose upper root is $6+2\sqrt7=11.29150$. At $n=12$ the expression is $8$.

## 2. Pre-registered question 1, the entry does not state one thing about its radius

### 2.1 The boxed endpoint clause is the refuted formula

**Locate.** The box: "***$\beta=\tfrac12$ gives $n^{-3/2}$ and is confirmed, pinned by the $P$-side branch alone. $\beta=0$ gives $n^{-1}$ and is plausible with an unpinned constant.***" The body: "**THE RADIUS $r_n\gtrsim n^{-1-\beta}$ IS REFUTED** … **The minimisation has now been done and it does not reach $n^{-1-\beta}$** … **too large on all of $\beta\in[0,\tfrac12)$**."

**Exhibit.** The two boxed values are $n^{-1-\beta}$ evaluated at the two endpoints: $n^{-1-1/2}=n^{-3/2}$ and $n^{-1-0}=n^{-1}$. The body's exclusion is stated on the half-open interval $[0,\tfrac12)$, whose left endpoint is $\beta=0$. So the box records as *plausible* precisely the value the body records as *too large*, and the two sentences sit fourteen lines apart in one entry. The provenance is visible: "plausible with an unpinned constant" is [r451](../reviews/REVIEW_r451.md)'s row-6 verdict, written before the joint minimisation was done; that same report's §A5 already reads "the $\beta=0$ conclusion is not established at the level where it would have to be checked".

**Argue the opposite.** The most charitable reading is that "plausible" is not an assertion, so the box claims only that $n^{-1}$ has not been excluded. This does not survive the body, which does not merely fail to establish $n^{-1}$ at $\beta=0$ but states the chain's infimum is $\Theta(n^{-3/2})$ and calls $n^{-1-\beta}$ too large there. A clause that says "plausible" where the same entry says "too large" is not a hedge; it is the sentence the refutation was supposed to remove. **Candidate stands.**

### 2.2 The $\beta$-dependence in the title and the interval survive the refutation that removed them

**Locate.** The title, "the tube radius **tracks** $\sup\lvert P\rvert$ on $\beta\in[0,\tfrac12]$"; and "*So the radius lives in $[n^{-3/2},n^{-1}]$*".

**Exhibit.** After the refutation the entry's own two conclusions are: $r_n\gtrsim n^{-3/2}$ *at every $\beta$ in the closed interval*, and a ceiling $c_p/S\le c_p/\theta_0=3/(n-2)$ that the entry itself calls "exact and unconditional in $\beta$". Neither depends on $\beta$. A quantity bounded below by $n^{-3/2}$ uniformly and capped by a $\beta$-free constant does not track $\sup\lvert P\rvert$; §1 makes the same point from the hypothesis side. The interval $[n^{-3/2},n^{-1}]$ is $[n^{-1-1/2},n^{-1-0}]$, the range of the refuted formula over the admissible $\beta$, written as a range for the radius.

**Argue the opposite.** "Tracks" could be read as naming the variable the *ceiling* depends on rather than the radius; and $[n^{-3/2},n^{-1}]$ could be read as the interval between the entry's floor and its ceiling rather than as a claim of $\beta$-dependence. Under that reading the title is loose rather than wrong. It still fails on the ceiling: the entry's ceiling is $\beta$-free by its own proof, so no reading of "tracks" is supported by anything the entry retains. **Candidate stands, at the level of a statement that outlived its content.**

### 2.3 The four-ways paragraph rests one of its four reasons on the refuted formula

**Locate.** "**The admissible range is a closed interval, and that is what makes the ceiling question empty.** … and $\beta\ge0$ empties the region regardless."

**Exhibit.** Reason (d) says a ceiling above $n^{-1}$ cannot bind because $\beta\ge0$. That inference needs the radius to reach $n^{-1}$ only at $\beta=0$ and to fall below it as $\beta$ rises, the $n^{-1-\beta}$ shape. With that shape refuted, $\beta\ge0$ says nothing about where a ceiling binds. The paragraph's own reason (a), $c_p/S\le c_p/\theta_0$, is $\beta$-free and does the work alone, which is what the entry says twelve lines later. So the headline sentence (that the *closed interval* is what empties the question), is contradicted by the entry's own proof of the ceiling.

**Argue the opposite.** Reason (d) may be a redundant fourth reason kept for completeness, in which case its failure costs nothing because (a) is sound. Accepted in part: the ceiling is not endangered. What is wrong is the paragraph's framing sentence, which attributes the emptiness to the range of $\beta$. **Candidate stands as a framing defect, not as a defect in the ceiling.**

### 2.4 The mixed direction the entry asserts is the one the record refuted

**Locate.** "*A single mixed direction with $u\asymp n^{-1/2}$, margin $\Theta(1/n)$ and $\lVert A''\rVert=\Theta(n)$ restores $n^{-3/2}$ at every $\beta$.*"

**Exhibit, in closed form.** Take any admissible $H$. Two facts, both quoted by the entry in the very next sentence:

$$\|H\|_{op}\le\Theta(n^{-1/2})+w,\qquad c(H)\gtrsim c_p+w^2 .$$

The Cauchy estimate gives $\|A''\|=O(1/\rho)$ with $\rho=\gamma g_n/\|H\|_{op}$ and $g_n=\Theta(1/n)$, hence $\|A''\|=O(n\|H\|_{op})$. Now suppose the direction has margin $c(H)=\Theta(1/n)$. Since $c_p=3\theta_0/(n-2)=\Theta(1/n)$, the second fact forces $w^2=O(1/n)$, i.e. $w=O(n^{-1/2})$; the first then gives $\|H\|_{op}=O(n^{-1/2})$; and the Cauchy estimate gives $\|A''\|=O(n^{1/2})$, not $\Theta(n)$. Contrapositively, $\|A''\|=\Theta(n)$ forces $\|H\|_{op}=\Omega(1)$, hence $w=\Omega(1)$, hence $c(H)=\Omega(1)$. **No admissible direction carries both attributes.** This is [L149](../findings/second-order.md)'s single sentence ("no direction is both low-margin and high-operator-norm") and L149's box says in terms that [r451](../reviews/REVIEW_r451.md)'s counterexample direction "does not exist".

**Argue the opposite.** The most charitable reading is that the sentence means the direction attaining branch 1's infimum, where $u^*=\Theta(n^{-1/2})$ and $a=\Theta(n)$ at $w=\Theta(1)$, and that "margin $\Theta(1/n)$" names the *numerator constant* $c_p$ that branch 1 carries rather than the direction's actual margin. Two of the three attributes then match the refutation paragraph exactly. Even so the sentence names $c_p$ as "margin" at a direction whose margin is $\Theta(1)$, which is the substitution §3.2 turns on; and it names the object L149 spent an entry removing, without saying it is removed. **Candidate stands.** Under the charitable reading it is a wording defect that reintroduces a refuted object; under the plain reading it is a false existence claim.

### 2.5 The singular "margin summand", flagged twice and still singular here

**Locate.** "$\lVert A''\rVert=O(M/\rho^2)=O(1/\rho)=O(n^{1/2})\quad\text{on the margin summand}$".

**Exhibit.** [L148](../findings/second-order.md) records that the vanishing "holds on **both** $S^2_0(\mathbb R^m)$ copies, *written singular, used plural by every citation, which is the slip that cost [L149] a factor of $n$*", and L149 records the same repair, $w$ being the weight outside **both**. This entry is one of those citations and still reads singular.

**Argue the opposite.** The value is unharmed: [L146](../findings/second-order.md)'s bound $\|H\|_{op}\le\sqrt{2/(n-2)}$ holds on each copy and its cross-plane branch on the joint eigenspace caps at $\sqrt{m-2}/m<1/\sqrt{m-1}$, so $O(n^{-1/2})$ and hence $O(n^{1/2})$ hold on the joint two-copy eigenspace as well. **Candidate withdrawn as a mathematical defect; recorded as the uncorrected wording of a correction made twice in neighbouring entries.**

## 3. Pre-registered question 2, the ceiling is on the method, and three uses do not respect it

**Answer, stated first.** It is a ceiling on **what the route can prove**. It is proved by bounding one branch of a $\min$ that lower-bounds $r(H)$; no ingredient of the chain bounds $r_n$ above. [L145](../findings/second-order.md) says so in terms, "the only '$\le$' on file is L147's $\Theta(n^{-1})$ ceiling, **which caps what the route can prove rather than the radius**" and "**the chain cannot yield an upper bound at all**, every ingredient bounds a denominator above or a numerator below", and [L149](../findings/second-order.md) closes with "a ceiling on a statement this local is a limit on the method rather than on the problem". **The distinction is drawn in the two neighbours and nowhere inside L147.**

### 3.1 Where L147 respects it and where it does not

| passage | reads as | verdict |
|---|---|---|
| title: "the route ends at $\Theta(n^{-1})$" | method | respects it, via the word "route" |
| box: "the route is capped at $\Theta(n^{-1})$" | method | respects it |
| "the $P$-side branch caps itself at $c_p/\theta_0\le3/(n-2)$" | method | respects it |
| "there is no region in which a ceiling above $n^{-1}$ could bind" | method | respects it |
| "*So the radius lives in $[n^{-3/2},n^{-1}]$*" | **quantity** | **violates it** |
| "the validity cap $r_n\le\rho/2$ is $O(g_n)$" | **quantity**, it writes $r_n\le\rho/2$ | **violates it** |
| box: "$\beta=0$ gives $n^{-1}$" | **quantity** | **violates it, and is §2.1's clause** |

**Exhibit for the second row.** The Cauchy estimate at an interior base point $s$ reads $\|A''(s)\|\le2M/(\rho-\lvert s\rvert)^2$, so the expansion is usable only for $t\le\rho/2$: the restriction is on where the *estimate* is valid, not on where the functional increases. [r451](../reviews/REVIEW_r451.md) words it correctly ("$r_n=O(g_n)=O(n^{-1})$ **for this method**, whatever the branches say") and this entry drops the three words that carry the whole distinction.

**Argue the opposite.** "The radius" in "the radius lives in $[n^{-3/2},n^{-1}]$" could denote the value the chain delivers rather than the true tube radius, and the paragraph around it is about which ceilings bind. That reading is available but costly: the entry's subject throughout is $r_n$, it never defines a second "radius", and L145's audit of the whole block rests on the assertion that no statement of the form $r_n=O(\cdot)$ appears in L146–L158, this sentence, read as its words run, falsifies that audit. **Candidates stand.**

### 3.2 The refutation that closed the debt is itself a route ceiling

**Locate.** "**THE RADIUS $r_n\gtrsim n^{-1-\beta}$ IS REFUTED, AND THE DEBT AGAINST IT IS CLOSED BY REFUTATION RATHER THAN PAID.** … branch 1 is $(c_p+u^2)/(S+au)$ with $f'(0)=-ac_p/S^2<0$, so its infimum is $2u^*/a=\Theta(n^{-3/2})$ at $w=\Theta(1)$, **too large on all of $\beta\in[0,\tfrac12)$**."

**The algebra first, which I confirm.** $f'(0)=-ac_p/S^2<0$ ✓; the stationary point is $u^*=(\sqrt{S^2+a^2c_p}-S)/a$ ✓; $f(u^*)=2u^*/a$ ✓, and $f(u^*)=\Theta(\min(c_p/S,\sqrt{c_p}/a))$ ✓, the two regimes being $a^2c_p\ll S^2$, where $u^*\approx ac_p/(2S)$ and $f\to c_p/S$, and $a^2c_p\gg S^2$, where $u^*\approx\sqrt{c_p}$ and $f\approx2\sqrt{c_p}/a$. At $w=\Theta(1)$, $a=\Theta(n)$ and $c_p=\Theta(1/n)$ give $a^2c_p=\Theta(n)$, so $u^*=\Theta(n^{1/2})/\Theta(n)=\Theta(n^{-1/2})$ and $f(u^*)=\Theta(n^{-3/2})$, at $\beta=0$ and $\beta=\tfrac12$ alike. **Every step of the displayed computation is correct.**

**Exhibit of the failure, which is in what the computation is then used for.** The chain is $r(H)\gtrsim\min(b_1,b_2,b_3)$: each branch is a *lower* bound on $r(H)$. Exhibiting a direction at which $\min(b_1,b_2,b_3)=\Theta(n^{-3/2})$ shows that the chain's output is $O(n^{-3/2})$; it is compatible with $r(H)$ being anything at all above that. A lower-bounding chain cannot refute a lower bound. Two independent places on the record say exactly this: [L145](../findings/second-order.md), "the chain cannot yield an upper bound at all"; and [r450](../reviews/REVIEW_r450.md)'s closing caveat, "what is established is that the chain's cap **is lost** at $n^{-3/2}$ and **relocated** to $n^{-1}$, **not that $n^{-1}$ is attained by the true tube radius**".

**And the looseness is exactly where the value is read.** Branch 1's numerator is the *floor* $c_p$, not the direction's margin $c(H)$: L149's display carries $c_p+u^2$ in branch 1 while carrying $c_p+\rho^{\mathrm{eff}}_nw^2$ in branch 2. The refutation reads that numerator at a direction with $w=\Theta(1)$, where the entry's own second input gives $c(H)\gtrsim c_p+w^2=\Omega(1)$, a factor $n$ above the numerator used. So the numerator is evaluated at $w\approx0$ and the denominator at $w=\Theta(1)$. Carrying the same margin bound through branch 1 that L149 already proves for branch 2 changes the arithmetic: with numerator $\Omega(1)$ and $a=\Theta(n)$, $a^2c=\Theta(n^2)\gg S^2$, so $u^*=\Theta(1)$ and $f(u^*)=2u^*/a=\Theta(n^{-1})$. **I do not repair the chain and I do not claim $n^{-1-\beta}$ holds**, I record that the $\Theta(n^{-3/2})$ on which the refutation rests is an artefact of a deliberately loose numerator read at a direction that makes it loose, and that [r453](../reviews/REVIEW_r453.md) already flagged the direction of the inequality: "relaxing the constrained $u=u(H)$ to an unconstrained $\min_{u\ge0}$ under-estimates $f(u(H))$, **which is the safe direction for a lower bound on $r$**". It is not the safe direction for a refutation.

**Argue the opposite.** The most charitable reading is method language throughout: "the minimisation … does not reach $n^{-1-\beta}$" is about the minimisation, and "too large" means "too large a claim for this chain to support". Under that reading the body is sound and only the heading ("IS REFUTED", "closed by refutation rather than paid"), overstates. I accept that reading for the body and record the finding at the heading: **the correct status of $r_n\gtrsim n^{-1-\beta}$ is withdrawn for want of proof, not refuted**, and the difference is that a withdrawn claim stays open while a refuted one is closed. The same wording, "too large on all of $\beta\in[0,\tfrac12)$", is carried in [L149](../findings/second-order.md), so the overstatement is already in two files.

### 3.3 The ceiling's own value

**What is proved.** $b_1\le f(0)=c_p/S\le c_p/\theta_0=3/(n-2)$, using $S=\sup\lvert P\rvert\ge P(W^*)=\theta_0(n)$ and $c_p=3\theta_0/(n-2)$. The $\theta_0$ cancels identically; the bound is exact, holds for every admissible $H$, and is free of $\beta$. At $n=12$ it is $0.3$, and I reproduce it the other way: $c_p=3\times1.236033/10=0.3708099$, $c_p/\theta_0=0.3708099/1.236033=0.3$. **Confirmed.**

**What is not proved is the $\Theta$.** Writing the ceiling as $\Theta(n^{-1})$ asserts the route reaches $n^{-1}$. The entry's own minimisation puts the route's infimum at $\Theta(n^{-3/2})$, which is a *smaller* route ceiling; both are true as upper bounds, and only the weaker one is displayed. The entry closes with a paragraph insisting on "$\gtrsim$, not $\Theta$" for the floor and keeps $\Theta$ for the ceiling four paragraphs above. The neighbour propagates the stronger reading: [L145](../findings/second-order.md)'s step-4 row still reads "$\Theta(n^{-1})$ **is reachable**", which is what this entry's refutation removes. **Finding: the ceiling should read $O(n^{-1})$, and L145's step table has not been updated.**

## 4. The trap named in the brief, $M=O(\rho)$ against the domain the consumer integrates over

**Locate.** "$M=\sup_{\lvert z\rvert=\rho}\lVert A\rVert$ is a supremum **over the disc**, so it grows with it: $x\mapsto x_-$ is $1$-Lipschitz in Frobenius norm and $\lVert\mathrm{Alt}\rVert\le1$, giving $M=O(\rho)$."

**What is true.** For Hermitian $X,Y$ and $1$-Lipschitz scalar $f$, $\|f(X)-f(Y)\|_F\le\|X-Y\|_F$; with $f(x)=x_-$ and $\mathrm{Alt}$ an orthogonal projection, $\|A(z)-A(0)\|\le\|W(z)-W^*\|_F=\lvert z\rvert$. With $A(0)=\mathrm{Alt}(W^*_-)=0$ this reads $M\le\rho$. **The real-variable statement is correct.**

**Exhibit of the failure.** The consumer is the Cauchy estimate $\|A''(0)\|\le2M/\rho^2$, whose $M$ is a supremum over the **complex** circle $\lvert z\rvert=\rho$. At $z=i\rho$ the matrix $W^*+i\rho H$ is complex symmetric and not Hermitian: it has no orthogonal spectral resolution, and $x\mapsto x_-$ has no functional calculus on it. The object $A(z)$ there is the analytic continuation through the Riesz projection $\Pi(z)=\tfrac1{2\pi i}\oint_\Gamma(\lambda-W(z))^{-1}d\lambda$, and its size is governed by the resolvent, not by a Lipschitz constant. The record's own sources say so: [r450](../reviews/REVIEW_r450.md) states the Lipschitz fact with the qualifier this entry drops ("$x\mapsto x_-$ $1$-Lipschitz in Frobenius norm **on Hermitian operators**") and immediately supplies the argument that does survive the disc,
$$\|A(z)\|\le\underbrace{\|W(z)-W^*\|_F\|\Pi(z)\|_{op}}_{O(\rho)\cdot O(1)}+\underbrace{\|W^*\|_{op}\|\Pi(z)-\Pi(0)\|_F}_{\Theta(g_n)\cdot O(\rho/g_n)}=O(\rho),$$
with $\|\Pi(z)-\Pi(0)\|_F\le\tfrac{\lvert\Gamma\rvert}{2\pi}\|R\|_{op}\|E\|_F\|R_0\|_{op}$; [r451](../reviews/REVIEW_r451.md) derives the same display independently. That route costs two constants the Lipschitz route hides ($\|\Pi(z)\|_{op}=O(1)$ and the resolvent bound $O(1/g_n)$) and they are exactly [L156](../results.md)'s contour constant $C(\alpha,\gamma)=\tfrac{\alpha(1+\alpha)}{d(d-\gamma)}$ in $M\le C\gamma g_n$, which is finite only on $0<\gamma<\min(d,1)$ and diverges as $\gamma\uparrow d$. **The entry's stated reason yields constant $1$ on a domain where the true constant is unbounded at the edge; the two coincide only in order, and only strictly inside the disc of analyticity.**

**Argue the opposite.** The most charitable reading is that "both reviewers derived the same replacement" points at [r450](../reviews/REVIEW_r450.md) and [r451](../reviews/REVIEW_r451.md), whose reports carry the Riesz derivation, so the entry is compressing a valid argument rather than substituting an invalid one; and the entry needs only the order $M=O(\rho)$ at a fixed admissible $\gamma$, which [L156](../results.md) supplies with $C^*=2+\tfrac{4(m-1)}{2m-1}$ at the optimal contour. I accept this for the **conclusion**: $M=O(\rho)$ stands on the record, and every downstream number ($\|A''\|=O(1/\rho)=O(n^{1/2})$ on the summand, $O(n)$ at $\rho=\Theta(g_n)$), is unaffected. I do not accept it for the **reason as transcribed**, which is the only justification the entry gives, which is a theorem about Hermitian matrices asserted on a complex circle, and which drops the qualifier its own source wrote. **Candidate stands as a GAP in the written justification, with the conclusion carried elsewhere on the record and [L156](../results.md) uncited here.**

## 5. Quantifier order and scope

**No finding on the two-variable minimisation as such.** $\min_w\min(b_1,b_2,b_3)=\min_i\min_w b_i$ holds identically, so the order of the $w$- and branch-minimisations is free, and [r453](../reviews/REVIEW_r453.md) checked it.

**Finding on the direction the relaxation is safe in.** $u$ and $w$ are not independent: $u\le w$ is the relation on file. Minimising $u$ freely under-estimates, which is safe for a lower bound on $r$ and unsafe for the upper-bound use §3.2 makes of it. This is the "$\min$ distributed across terms sharing a variable" failure the brief names, and it is committed by the refutation rather than by the chain.

**No finding on $u$ against $w$ inside the refutation**: the paragraph pairs $u^*=\Theta(n^{-1/2})$ with $a=\Theta(n)$ at $w=\Theta(1)$, and $u^*\le w$ is satisfied, so the minimiser is admissible.

**Singular against plural**: §2.5, recorded, harmless to the value here.

**One collision worth naming.** $\beta$ is this entry's exponent for $\sup\lvert P\rvert$ and is simultaneously the Kulkarni–Nomizu coefficient $\tfrac m{2(m-1)}$ in [L146](../findings/second-order.md) and [L148](../findings/second-order.md), the entries immediately above and below. Inside L147 only the exponent sense occurs, so there is no error here; across the block a reader meets two $\beta$s in adjacent paragraphs.

## 6. The edge of every range

- **Smallest admissible dimension, $n=12$ ($m=6$).** Every import clears it, and [L149](../findings/second-order.md)'s $m\ge6$ is met exactly at the floor. But the sweep this entry quotes as "$c(H)\gtrsim c_p+w^2$" is the form L149 itself corrects: the true coefficient is $3\theta_0\tfrac{n-8}{2(n-2)}$, which I evaluate by hand as $3\times1.236033\times\tfrac4{20}=0.741620$ at $n=12$, $3\times1.261678\times\tfrac6{24}=0.946259$ at $n=14$, and $3\times1.280869\times\tfrac8{28}=1.097888$ at $n=16$, reaching $1$ only from $n=16$, exactly as L149 records. Under the $\gtrsim$ reading the entry's form is safe as an order; read with coefficient $1$ it overstates by $26\%$ at $n=12$, which is the dimension the programme evaluates. **Recorded as a caveat present in the neighbour and absent here, not as an error.**
- **$\beta=\tfrac12$.** "gives $n^{-3/2}$ and is confirmed, pinned by the $P$-side branch alone": $c_p/S=\Theta(n^{-1})/\Theta(n^{1/2})=\Theta(n^{-3/2})$, and $\sqrt{c_p}/a=\Theta(n^{-1/2})/\Theta(n)=\Theta(n^{-3/2})$, so both regimes of $f(u^*)$ agree and the floor and the route ceiling coincide there. **No finding.**
- **$\beta=0$.** §2.1. **Broken.**
- **$\ker W\ne0$, witness $W_{\mathbb{CP}^2}$ with $\dim\ker W=3$.** The numeral is [bounds.md](../findings/bounds.md)'s, at $n=4$: $\dim E_+=1$, $\dim E_-=2$, $\dim\ker W=3$, summing to $\dim\Lambda^2\mathbb R^4=6$. **I reproduce it and it is right at $n=4$.** It is not right at the entry's own dimensions: padding $W_{\mathbb{CP}^2}$ into $\Lambda^2\mathbb R^{12}$ adds $66-6=60$ to the kernel. And the nondegeneracy half of the sentence is measured on file at $n=6,8,10$ only, with [LEDGER](../findings/LEDGER.md) recording that [L27](../findings/nondegeneracy.md) does **not** cover padded $W_{\mathbb{CP}^2}$ and that "the support is a measurement stopping at $n=10$". The qualitative use, that $\ker W^*=0$ is a real hypothesis, since a critical point can have a kernel, and where it does, $g_n$, $\rho$, $M$ and branches 2–3 have no definition, is untouched. **Recorded as a numeral read at one dimension and used at another, harmless to the point it serves.**

## 7. The two forms, [results.md](../results.md)

**There is no canonical L147 in results.md, and there is none for L145, L146, L148 or L149 either.** The absence is correct: the entry's box was rewritten by a refutation two days ago and its endpoint clause is §2.1's, so nothing here is ready to be canonised.

**But the machinery is in results.md, inside the canonical L158, and it disagrees with L147 on one value.** results.md reads "*$f(u^*)=2u^*/a$ is $\Theta(n^{-3/2})$ at $u=\Theta(1)$*"; L147 reads "$u\asymp n^{-1/2}$" and "at $w=\Theta(1)$". The algebra settles it: with $a=\Theta(n)$ and $c_p=\Theta(1/n)$, $a^2c_p=\Theta(n)$ dominates $S^2=\Theta(n^{2\beta})$ for every $\beta\le\tfrac12$ except at the boundary where they are comparable, so $u^*=(\sqrt{S^2+a^2c_p}-S)/a=\Theta(n^{1/2})/\Theta(n)=\Theta(n^{-1/2})$ at both ends of the range, never $\Theta(1)$. The value $f(u^*)=2u^*/a=\Theta(n^{-3/2})$ is the same either way, which is why the discrepancy has survived. **Finding: results.md's L158 locates branch 1's minimiser at $u=\Theta(1)$, which the stationarity relation contradicts; the reading consistent with $u^*\le\sqrt{c_p}=\Theta(n^{-1/2})$ is L147's.** The likeliest history is $w=\Theta(1)$ mis-transcribed as $u=\Theta(1)$, the exact $u$-for-$w$ substitution [L149](../findings/second-order.md) warns of.

## 8. What I could and could not reproduce

| numeral in or under the entry | reproduced by hand |
|---|---|
| $c_p=3\theta_0/(n-2)$ from $\tfrac12-\lambda_m=\tfrac1{n-2}$ | **yes**, identically |
| $c_p/\theta_0=3/(n-2)$; $=0.3$ at $n=12$ | **yes** |
| $-\tfrac32\theta_0$ as the ten-summand floor; $-1.85405$ at $n=12$ | **yes**, from $\lambda=1$ on $\langle W\rangle$ |
| $\theta_0(12)=\sqrt{220}/12=1.236033$, increasing to $\sqrt2$ | **yes**, $\theta_0^2=2(1-3/n+2/n^2)$ is increasing in $n$ for $n>4/3$ |
| $n^2-12n+8>0$ as the import floor; root $6+2\sqrt7=11.29150$ | **yes**, it is $\theta_0>\sqrt{3/2}$ cleared |
| $\beta\le\tfrac12$ from $\sup\lvert P\rvert\le1+\sqrt{n-2}$ | **yes** |
| $\|A''\|=O(1/\rho)=O(n^{1/2})$ on the summand, $O(n)$ at $\rho=\Theta(g_n)$ | **yes**, given $M=O(\rho)$, and the two $g_n$ forms on file, $\tfrac2n\sqrt{\tfrac{n-2}{2(n-1)}}$ and $\sqrt{2(n-2)}/(n\sqrt{n-1})$, are the same number |
| $\|H\|_{op}\le\sqrt{2/(n-2)}$ against L149's $a_0n^{-1/2}$ with $a_0=\sqrt{2n/(n-2)}$ | **yes**, they are equal |
| $f(u^*)=2u^*/a=\Theta(\min(c_p/S,\sqrt{c_p}/a))$, and $u^*=\Theta(n^{-1/2})$ at both ends | **yes** |
| the margin coefficient $0.741620$ / $0.946259$ / $1.097888$ at $n=12,14,16$ | **yes** |
| $\lvert\kappa_{12}\rvert=0.101592$, $\rho^{\mathrm{eff}}_{12}=0.719044$, limit $1.742382$, and the closed form $\sqrt6-\theta_0\tfrac{n+16}{2(n-2)}$ | **yes**, the closed form is an identity |
| $\dim\ker W_{\mathbb{CP}^2}=3$ | **yes at $n=4$**, and only there |
| the constant in $M=O(\rho)$ | **no**, the entry's reason gives $1$ and is invalid on the complex circle; [L156](../results.md)'s $C(\alpha,\gamma)$ is the constant, and the entry does not name a $\gamma$ |
| "$\Theta(n^{-1})$ is reachable" (L145 step 4) | **no**, the entry's own minimisation puts the route's infimum at $\Theta(n^{-3/2})$ |

## 9. What would break the statement, and what I did to look for it

**For the surviving inequality $r_n\gtrsim n^{-3/2}$**, the falsifier is an admissible direction ($\|H\|_F=1$, $H\perp W^*$, $H\perp T_{W^*}\mathcal O$, $n\ge12$), along which $\min(b_1,b_2,b_3)=o(n^{-3/2})$. By the branch forms that needs either $c(H)=o(1/n)$ or $a=\omega(n)$. I looked for both in the record's own parametrisation rather than numerically. The first is excluded by [L27](../findings/nondegeneracy.md): the margin $3\theta_0(\tfrac12-\lambda)$ is a convex combination of the eight surviving summand values, whose largest $\lambda$ at $m\ge5$ is $\lambda_m$ (since $\lambda_m>\mu$ exactly when $m-2>2$) so $c(H)\ge c_p=\Theta(1/n)$ with no admissible direction below it. The second is excluded by $a=O(n\|H\|_{op})$ together with $\|H\|_{op}\le\|H\|_F=1$. **I found no falsifier, and none can exist inside this parametrisation.**

**For the ceiling read as a statement about $r_n$**, the falsifier is any direction whose true tube radius exceeds $3/(n-2)$, and nothing on the record excludes one, because nothing on the record bounds $r_n$ above. I checked each branch for a hidden upper bound: $b_1$ and $b_2$ arise from Taylor remainders bounded in the safe direction, and $b_3=\rho/2$ restricts where the Cauchy estimate is valid rather than where the functional increases. **That is the concrete content of §3: the object that would falsify the ceiling-as-radius-bound is not excluded, which is why the ceiling must be read on the method.**

**For the boxed clause at $\beta=0$**, no search is needed: the falsifier is the entry's own body, fourteen lines below the box.

## Verdict

**BROKEN**, scoped as follows.

- **What survives, and is proven:** $r_n\gtrsim n^{-3/2}$ over admissible directions at $n\ge12$, uniformly in $\beta$ on the closed interval; and a ceiling on what the route can prove, $\min_i b_i\le c_p/S\le c_p/\theta_0=3/(n-2)$, exact and unconditional in $\beta$.
- **What is broken:** the boxed clause "$\beta=0$ gives $n^{-1}$ and is plausible", which the same entry's body declares too large; the sentence "the radius lives in $[n^{-3/2},n^{-1}]$", an upper bound on $r_n$ that no ingredient of the chain can produce and that [L145](../findings/second-order.md) states appears nowhere in the block; the asserted mixed direction with margin $\Theta(1/n)$ and $\|A''\|=\Theta(n)$, which the two inputs quoted beside it exclude in closed form; and the hypothesis box's count of four, which omits the two orthogonality conditions the proof uses by name.
- **What is a gap rather than a break:** the $M=O(\rho)$ justification, a Hermitian-matrix theorem asserted on a complex circle, whose conclusion is carried by the Riesz derivations in [r450](../reviews/REVIEW_r450.md) and [r451](../reviews/REVIEW_r451.md) and by [L156](../results.md), none cited here; and the heading "IS REFUTED", where the body establishes only that the chain does not deliver $n^{-1-\beta}$, a lower-bounding chain cannot refute a lower bound, so the correct status is withdrawn for want of proof, which leaves the claim open.
- **Two propagations to fix beyond this entry:** [L145](../findings/second-order.md)'s step-4 row still reads "$\Theta(n^{-1})$ is reachable"; and [results.md](../results.md)'s canonical L158 puts branch 1's minimiser at $u=\Theta(1)$ where the stationarity relation gives $u^*=\Theta(n^{-1/2})$.

# Review r735, L162's monotonicity proof, and the radius assembled from it

**Reviewer r735, Gate 2, cold from the definitions.** Target: [Lemma L162](../findings/second-order.md), its monotonicity proof, the radius $r_n\gtrsim0.38673/n$ it assembles, and the scope box that cuts the minimiser claim back to $n\in\{12,14\}$.

**Verdicts.**

| item | verdict |
|---|---|
| 1, the monotonicity proof | **CONFIRMED**, with one non-sequitur in the stated reason and one false parenthetical about the squaring step; the theorem and every constant reproduce |
| 2, the radius | **REFUTED.** The denominator substitution the brief flags is *licensed* and the entry is right for a reason it does not give. The radius is wrong for a different reason: it drops branch 2's prefactor $\lambda/(\sqrt2J)$, which the record prints twice. And the ordering runs the other way |
| 3, the scope correction | **CONFIRMED, and upgraded from screened to proved.** The $n\in\{12,14\}$ / $n\ge16$ split is a closed-form inequality, not a numerical observation |

**Analysis-only footing observed.** Everything below is exact rational or symbolic arithmetic in `sympy` on objects built from the definitions in the entry, each run a screen of a claim being recorded. No sweep, no search, no census.

---

## Item 1, the monotonicity proof: CONFIRMED

### The collapse and $h'$ are exactly right

With $q=\sqrt{4\beta s+1}$, $(q+1)^2=q^2+2q+1=4\beta s+2+2q$, so

$$F=\frac{4s}{(q+1)^2}=\frac{2s}{1+2\beta s+\sqrt{1+4\beta s}}=\frac2\beta\,h(\beta s),\qquad h(x)=\frac x{1+2x+\sqrt{1+4x}} .$$

Writing $u=\sqrt{4x+1}$ and $D=1+2x+u$, so $u'=2/u$ and $D'=2+2/u$:

$$D-xD'=1+2x+u-2x-\tfrac{2x}u=\frac{u+u^2-2x}u=\frac{u+2x+1}u=\frac Du,\qquad h'=\frac{D/u}{D^2}=\frac1{uD} .$$

Expanding $uD=\sqrt{4x+1}\,(1+2x+\sqrt{4x+1})=2x\sqrt{4x+1}+4x+\sqrt{4x+1}+1$, which is **the entry's display character for character**. Positive term by term on $x\ge0$. So $\partial_sF=2h'(\beta s)>0$.

### The $\beta$ half does not follow from $h'>0$, and the entry says it does

*"$h'(x)=\dots>0$ term by term. **So $F$ is strictly increasing in $s$ and strictly decreasing in $\beta$**"*, the second conjunct is a non-sequitur. $F=\tfrac2\beta h(\beta s)$ has $\tfrac2\beta$ falling and $h(\beta s)$ **rising** in $\beta$; positivity of $h'$ alone leaves the sign open. What is needed is that the elasticity is below one:

$$\partial_\beta F=\frac2{\beta^2}\big(\beta s\,h'(\beta s)-h(\beta s)\big),\qquad \frac{xh'(x)}{h(x)}=\frac{x/(uD)}{x/D}=\frac1u=\frac1{\sqrt{4x+1}}<1 .$$

**The missing step is one line and it is already on the record**, [L158](../findings/second-order.md) prints exactly $\mathrm d\log(K\sqrt{c_p+\rho^{\mathrm{eff}}_nw^2})/\mathrm d\log s=1/\sqrt{4t+1}\in(0,1)$ in the box that settles the r713/r714 dispute. The repair is a citation, not an argument. **The conclusion stands.**

### $\beta$ falls: confirmed, including the collapse of $C$

$C=\frac{4+2D}D$ with $D=\frac{2m-1}{m-1}=\frac{2(n-1)}{n-2}$ gives $\frac{2(n-2)}{n-1}+2=\frac{4n-6}{n-1}=\frac{2(2n-3)}{n-1}=4-\frac2{n-1}$, which is $\tfrac{42}{11}$ at $n=12$, [L156](../findings/second-order.md)'s printed value, so the collapse is verified against the one dimension the record carried. Increasing, limit $4$. And $\theta_0^2=2(1-3/n+2/n^2)$ has derivative $2(3n-4)/n^3>0$, so $\theta_0$ rises, $\lambda=2/\sqrt{9(\theta_0-\sqrt{3/2})}$ falls, and $\beta=\lambda/(2C)$ strictly falls. **All confirmed.**

### $s_0$ rises: the numerator identification, the squaring, and $D$

**$S'$ does pick up $w_0'$, and the entry handled it.** Differentiating $S=c_p+\rho^{\mathrm{eff}}_nw_0^2$ in $n$ with $w_0=(n-4)/n$ live, and dividing by the entry's stated numerator:

$$\frac{S'(n)}{\sqrt2\,P(n)+8n(n-2)(n-4)\sqrt{6(n-1)(n-2)}}=\frac{\sqrt{(n-1)(n-2)}}{n^4(n-2)^2(n-1)},$$

**manifestly positive on $n\ge12$**, so the entry's expression has the sign of $S'$ exactly. (Its own denominator is therefore $n^4(n-2)^2(n-1)/\sqrt{(n-1)(n-2)}$; the entry says only *"over a manifestly positive denominator"*, which is true.) The $\sqrt6$ part of the true numerator carries $(n-4)(n-2)^2(n-1)=n^4-9n^3+28n^2-36n+16$, which is what puts the entry's $8n(n-2)(n-4)$ under a radical rather than beside one.

**One parenthetical is false, and the conclusion survives it.** The entry writes *"$P(12)=-86976<0$ … Squaring both sides, legitimate since both are positive there"*. $P$ is quartic with positive leading coefficient and its real roots are $1.1832,\,1.7969,\,3.3906,\,85.2293$: **$P<0$ on $[12,85.23)$ and $P>0$ for $n\ge86$**, so $-\sqrt2P$ is negative there and the two sides are not both positive on the whole of $n\ge12$. It costs nothing: $D>0$ says $8n(n-2)(n-4)\sqrt{6(n-1)(n-2)}>\sqrt2\lvert P\rvert\ge-\sqrt2P$, so $D>0$ is sufficient in **both** sign regimes, and above $n=85.23$ the numerator is a sum of two positive terms with no squaring needed at all. *What the entry should say is that $D>0$ dominates $\lvert P\rvert$, not $P$.*

**$D$ and its shift reproduce exactly.** $[8n(n-2)(n-4)]^2\cdot6(n-1)(n-2)=384n^2(n-2)^3(n-4)^2(n-1)$ ✓, against $(\sqrt2P)^2=2P^2$ ✓. Recomputing $D(12+u)$ from scratch:

| $u^k$ | $8$ | $7$ | $6$ | $5$ | $4$ | $3$ | $2$ | $1$ | $0$ |
|---|---|---|---|---|---|---|---|---|---|
| coeff | $\tfrac{3047}8$ | $\tfrac{62753}2$ | $\tfrac{2209615}2$ | $21738544$ | $261338576$ | $1962270976$ | $8955411328$ | $22573025280$ | $23798734848$ |

Every one positive; the two the entry names, $23798734848$ at $u^0$ and $\tfrac{3047}8$ at $u^8$, are **exact**, and $\tfrac{3047}8=384-\tfrac{25}8$ is forced by the two leading coefficients alone. So $S'>0$ on $n\ge12$, $s_0=\sqrt S$ rises, $F(w_0)$ rises. **Proof CONFIRMED.**

**The endpoints check.** $F(w_0)$ at $n=12$ is $0.38672774$; $\lim_{n\to\infty}F(w_0)=0.9030352$, the entry's $0.90304$, reached from below ($0.8975$ at $n=1000$).

---

## Item 2, the radius: REFUTED, and not at the joint the brief names

### The denominator substitution IS licensed, and the record prints the licence without noticing

The brief is right that $a_0n^{1/2}+nw$ and $n\phi(w)$ are different functions, and right that the entry states the substitution without a reason. **But the substitution is sound, and the reason is an identity.**

$$a_0n^{1/2}+nw=n\big(a_0n^{-1/2}+w\big)=n\,\psi(w),\qquad \psi(w):=a_0n^{-1/2}+w,$$

and $\psi$ is precisely [L158](../findings/second-order.md)'s **triangle** envelope for $\lVert H\rVert_{op}$. So [L149](../findings/second-order.md)'s denominator is not an independent object: it is $n$ times whatever upper bound on $\lVert H\rVert_{op}$ is in force, because the branch is $\sqrt c\,\rho$-shaped with $\rho=\gamma g_n/\lVert H\rVert_{op}$ and $\lVert H\rVert_{op}$ enters the denominator **linearly and only there**. L158 replaces $\psi$ by the smaller admissible $\phi=\min(a_0n^{-1/2}\sqrt{1-w^2}+w,1)$; substituting $n\phi$ for $n\psi$ is that replacement and nothing else, and it moves the bound the safe way since $\phi\le\psi$ pointwise.

**The record already contains the arithmetic check and does not read it as the licence.** L162's own closing sentence prints the superseded denominator as $n(w_0+a_0n^{-1/2})=13.366$ at $n=12$; and $a_0\cdot12^{1/2}+12\cdot\tfrac23=\sqrt{2.4}\cdot\sqrt{12}+8=13.3666$. *The two forms agreeing to five digits at the one dimension the record evaluates is the identity $a_0n^{1/2}+nw=n\psi(w)$ being verified without being stated.* The $11\%$ the entry credits to the envelope correction is $13.3666/12-1=11.39\%$ ✓.

**So: right for a reason not given.** What the entry owes is the sentence *"the denominator is $n$ times the $\lVert H\rVert_{op}$ envelope, so correcting the envelope corrects the denominator"*.

### The $(1-\eta^*)^2$ is correctly placed, and the infimum does commute

From [L157](../findings/second-order.md)'s crossing identity $\eta^*\gamma=\frac{\lambda\sqrt{c_p+\rho^{\mathrm{eff}}_nw^2}}{2J}(1-\eta^*)^2$ and $r=\eta^*\rho$ with $\rho=\gamma g_n/\lVert H\rVert_{op}$, the $\gamma$ cancels and

$$\text{branch }2\;=\;\frac{\lambda g_n}{2J}\cdot\frac{(1-\eta^*)^2\sqrt{c_p+\rho^{\mathrm{eff}}_nw^2}}{\lVert H\rVert_{op}}\;\ge\;\frac{\lambda g_n}{2J}\cdot\frac{G(w)}{\phi(w)}\;=\;\frac{\lambda g_n}{2J}\,F(w).$$

$(1-\eta^*)^2$ sits in the numerator, inside $G$, exactly as the entry has it. **CONFIRMED.** And $\lambda,J,g_n$ carry no $w$, so $\inf_w$ passes through them; $\inf_w\min(b_1,b_2,b_3)=\min(\inf b_1,\inf b_2,\inf b_3)$ is an identity, and the branches' variables ($u$ for branch 1, $w$ for branches 2 and 3) have a constraint set $\{u\le w\}$ that projects onto the full range of each. **The commuting is CONFIRMED.**

### The defect: the radius drops branch 2's prefactor, and the record says so twice

Comparing the display above with L162's $r_n\gtrsim G(w)/(n\phi(w))=F(w)/n$: the entry has replaced $\frac{\lambda g_n}{2J}$ by $\frac1n$. **These are not equal.** Writing $ng_n=\sqrt{2(n-2)/(n-1)}$,

$$\frac{\lambda g_n}{2J}=\frac1n\cdot\frac{\lambda\,ng_n}{2J},\qquad \frac{\lambda\,ng_n}{2J}\Big\vert_{n=12}=0.609411,\qquad \frac{\lambda}{\sqrt2J}\Big\vert_{n=12}=0.639140 .$$

*The second is the $\sqrt2$-approximated form, $4.9\%$ high, which L158 flags as **in the unsafe direction**.* Either way the entry is short by a factor $\approx0.61$–$0.64$:

| quantity at $n=12$, $w_0=\tfrac23$ | value |
|---|---|
| $F(w_0)$ | $0.3867277$ |
| branch 2, exact ($ng_n$) | $\mathbf{0.0196388}$ |
| branch 2, $\sqrt2$ form | $\mathbf{0.0205974}$ |
| **L162's displayed $F(w_0)/n$** | $0.0322273$ |

**Three independent places in the record return the smaller number, and none returns L162's.**

- [L149](../findings/second-order.md) says it in words: *"**THE NUMERAL PRICES $g_\rho$, NOT BRANCH 2.** Branch 2 is $K\,g_\rho$ with $K=\lambda(1-\eta^*)^2/(\sqrt2J)$, and $K<1$ by better than an order of magnitude … the numeral does not, and **must not be read as a branch-2 floor***."
- [L158](../findings/second-order.md) prints the value: *"**neither is branch 2**, which carries a further $\lambda/(\sqrt2J)$ and $1/n$ and is $0.0206$ at $w_0$."* I reproduce $0.38672774\times0.6391272/12=0.0205974$, **$0.0206$ to four digits**.
- [L158](../findings/second-order.md)'s branch threshold is built from the same prefactor and pins it: $T=\frac{\kappa\sqrt2J}{\lambda(1-\eta^*)^2s_\rho(w_0)}=\kappa/\big(\tfrac\lambda{\sqrt2J}G(w_0)\big)=4.4497191/0.2471682=\mathbf{18.0025}$, the recorded $18.00$. **Under L162's radius the same threshold would read $\kappa/F(w_0)=11.506$**, and the record's $18$ would be wrong.

**And L162 refutes itself four lines below the display.** Its Scope paragraph reads *"What this does not do is turn $F$ into a radius: the reach carries further factors"*, which is exactly the objection, stated by the entry, against the entry's own display.

**Corrected radius at $n=12$:** $r_n\gtrsim0.2357/n$ on the exact $ng_n$, or $0.2472/n$ on the record's $\sqrt2$ convention, not $0.38673/n$. *Independent check by the raw route: $\rho=\gamma g_{12}/1=0.55\times0.1123666=0.0618016$, $\eta^*=0.317772$, $r=\eta^*\rho=0.0196385$.* ✓

### The second defect: the ordering runs the other way, so "$\ge0.38673/n$ at every $n\ge12$" fails twice

The entry proves $F(w_0)$ increasing and then reads that as the radius constant increasing. **The prefactor moves the other way and moves harder.** $\lambda=2/\sqrt{9(\theta_0-\sqrt{3/2})}$ falls by $4.07\times$ from $n=12$ to the limit while $J=4(1+\alpha)/\alpha^2$ rises from $6.9421$ to $8$; $F$ rises only by $2.34\times$. Screening $n\cdot(\text{branch 2 at }w_0)$:

| $n$ | 12 | 14 | 16 | 20 | 30 | 100 | 1000 |
|---|---|---|---|---|---|---|---|
| $F(w_0)$ | $0.38673$ | $0.51441$ | $0.57126$ | $0.63913$ | $0.72513$ | $0.84834$ | $0.89751$ |
| $\lambda$ | $6.2747$ | $3.4689$ | $2.8141$ | $2.3151$ | $1.9362$ | $1.6254$ | $1.5402$ |
| $n\cdot r^{\mathrm{br2}}$ (exact) | $\mathbf{0.23567}$ | $0.17073$ | $0.15215$ | $0.13800$ | $0.12851$ | $0.12312$ | $0.12231$ |

**$n\,r_n$ decreases monotonically to $\approx0.1223$.** So $n=12$ is the dimension where the radius constant is **largest**, not smallest, and the correct uniform statement over even $n\ge12$ is $r_n\gtrsim0.1223/n$, a factor $3.16$ below the entry's claim. *The lemma's headline "$n=12$ is the worst case" is true of $F(w_0)$, which is what it proves, and false of the radius, which is what the display asserts.*

### The third defect: the display is one branch, not $r_n$

[L149](../findings/second-order.md)'s radius is $r(H)\gtrsim\min\big(\tfrac{c_p+u^2}{S+au},\ \tfrac{\sqrt{c_p+\rho^{\mathrm{eff}}_nw^2}}{n^{1/2}+nw},\ \tfrac{\rho(H)}2\big)$. L162 writes $r_n\gtrsim\min_wF/n$ with **no hypothesis on $S=\sup\lvert P\rvert$** and no mention of the third branch. Branch 1's infimum is $\kappa/(nS)$, so branch 2 binds only while $S\le T=18.00$, which holds at $n=12$ against [L143](../findings/bounds.md)'s $S\le4.162$, but is a hypothesis the display should carry. *Branch 3 is slack: $\rho/2=0.0309$ against branch 2's $0.0196$.*

### Against $\Omega(n^{-3/2})$: no contradiction, different objects

$c/n$ exceeds $\Omega(n^{-3/2})$, so a valid $\Omega(n^{-1})$ strengthens rather than contradicts [L145](../findings/second-order.md). The two are different claims: L145's is the proved unconditional bound over every direction; the $n^{-1}$ is branch 2's floor, and $r_n$ inherits it only under the branch-1 threshold above. **No contradiction; the entry is right to keep both.**

---

## Item 3, the scope correction: CONFIRMED, and it can be proved rather than screened

**$G$ is increasing in $w$: CONFIRMED.** $G=\tfrac2\beta h(\beta s)$ with $s=\sqrt{c_p+\rho^{\mathrm{eff}}_nw^2}$ increasing in $w$ (as $\rho^{\mathrm{eff}}_n>0$, [L149](../findings/second-order.md)) and $h'>0$ from Item 1. Minimised at $w=0$ ✓. So L158's minimiser claim is necessarily about the ratio, as the box says.

**The drift is real, not an artefact of the $\min$.** The $\min$ makes the kink; the kink's status as a minimiser is decided by two smooth quantities crossing. Above $w_0$ the envelope is constant, so $F=G$ rises; below it, with $\phi(w_0)=1$,

$$\frac{\mathrm d\log F}{\mathrm dw}\Big\vert_{w_0^-}=\underbrace{\frac{\rho^{\mathrm{eff}}_nw_0}{s_0^2\sqrt{4\beta s_0+1}}}_{\text{from }G}-\underbrace{\frac n{2(n-2)}}_{\phi'(w_0)},\qquad \phi'(w_0)=1-\frac{n-4}{2(n-2)}=\frac n{2(n-2)} .$$

*The envelope slope is exact and closed form, $\tfrac35$ at $n=12$ as L158 records, falling to $\tfrac12$.* **The kink is a local minimum of $F$ exactly when $\dfrac{\rho^{\mathrm{eff}}_nw_0}{s_0^2\sqrt{4\beta s_0+1}}\le\dfrac n{2(n-2)}$**, and screening that inequality:

| $n$ | 12 | 14 | 16 | 18 | 20 | 30 | 100 |
|---|---|---|---|---|---|---|---|
| $\mathrm d\log G/\mathrm dw$ at $w_0$ | $0.35947$ | $0.51080$ | $0.58486$ | $0.62827$ | $0.65544$ | $0.70397$ | $0.71373$ |
| $\phi'(w_0)=\tfrac n{2(n-2)}$ | $0.60000$ | $0.58333$ | $0.57143$ | $0.56250$ | $0.55556$ | $0.53571$ | $0.51020$ |
| kink a local min | yes | yes | **no** | no | no | no | no |

**The split falls at exactly $n=16$**, reproducing the entry's *"minimised at $w_0$ exactly at $n=12$ and $n=14$ … from $n=16$ its minimiser drifts below"*, and turning it from a screened observation into a one-line closed-form criterion. *At $n=14$ the margin is thin, $0.51080$ against $0.58333$; at $n=16$ it has crossed.*

**The shortfall figures are consistent.** My $F(w_0)$ values against the entry's screened $\min_wF$ list: $n=16$, $0.571263$ vs $0.57122$ ($0.007\%$); $n=20$, $0.639127$ vs $0.63612$ ($0.47\%$); $n=30$, $0.725129$ vs $0.71468$ ($1.44\%$). *All $\min_wF\le F(w_0)$, as they must be, and the three the brief names land where the brief says.* At $n=12$ and $n=14$ the entry's list **equals** my $F(w_0)$ to five digits, confirming the claimed coincidence.

**$F$'s minimum at $n=12$ is global, not merely local.** Screening $F$ across $[0,1]$ at $n=12$: $0.72947$ at $w=0$, falling monotonically to $0.38836$ at $w=0.65$, $\mathbf{0.38673}$ at $w_0=\tfrac23$, then $0.39138$ at $w=0.70$ rising to $0.43312$ at $w=1$. ✓

**What consumes "the kink is the minimiser" above $n=14$.** L162 itself is careful, its radius and its $n\ge12$ claim both invoke $\min_wF$ rather than $F(w_0)$, and its list is the screened $\min_wF$. **The uncorrected consumer is [L158](../findings/second-order.md)'s own box**, headed *"THE MINIMISER IS THE HOMOGENEITY KINK $w_0=\frac{n-4}n$"* under Gate 2 [r715](REVIEW_r715.md)/[r716](REVIEW_r716.md), which carries **no $n$ restriction**, and the sufficient condition L158 proves ($\phi'(w_0)=\tfrac35$ against $\tfrac1s\tfrac{N'}N\le0.4019$ by AM–GM) is stated there as *"$n$-local and not claimed beyond $n=12$"*. **So L158's headline over-quantifies its own proof, and L162's scope box is the correction; the correction should be written back into L158's box, where readers will meet it first.**

---

## What would falsify each

- **Item 1.** A sign error in $D$'s shift, one negative coefficient in $D(12+u)$ would break $s_0$'s rise; I recomputed all nine from the definitions. Or a $\theta_0$ convention under which $\theta_0$ falls in $n$, which [conventions.md](../findings/conventions.md) excludes.
- **Item 2.** A place in the record where branch 2 is $g_\rho$ with **no** prefactor. I found the opposite twice in words and once in a number ($0.0206$), plus L158's $T=18.00$, which is arithmetically inconsistent with L162's radius. *To reinstate $0.38673/n$ one would have to show $\lambda g_n/(2J)=1/n$, i.e. $\lambda\,ng_n=2J$, which at $n=12$ reads $8.4612=13.884$.*
- **Item 3.** A value of $n\ge16$ at which $\frac{\rho^{\mathrm{eff}}_nw_0}{s_0^2\sqrt{4\beta s_0+1}}\le\frac n{2(n-2)}$, or one of $n\in\{12,14\}$ at which it fails.

## What the entry should say

1. **State the licence** for the denominator: $a_0n^{1/2}+nw=n\psi(w)$ with $\psi$ the triangle envelope, so the denominator is $n\times$ the $\lVert H\rVert_{op}$ bound and L158's $\phi\le\psi$ substitutes directly.
2. **Restore the prefactor**: $r_n\gtrsim\frac{\lambda\,ng_n}{2J}\cdot\frac{\min_wF}n$, which is $0.2357/n$ at $n=12$ ($0.2472/n$ on the $\sqrt2$ convention), and reconcile with L158's printed $0.0206$ and $T=18.00$.
3. **Reverse the ordering claim**: $n\,r_n$ **falls** from $0.2357$ to $\approx0.1223$, so the uniform statement over even $n\ge12$ is $r_n\gtrsim0.1223/n$ and $n=12$ is the best case for the radius while remaining the worst for $F$.
4. **Carry the branch hypothesis** $S\le T=18.00$ into the radius display.
5. **Cite $1/\sqrt{4x+1}<1$** for the $\beta$ half of the monotonicity, and replace *"both are positive there"* by *"$D>0$ dominates $\lvert P\rvert$"*, $P$ having a root at $n=85.229$.
6. **Write the $n\ge16$ restriction back into [L158](../findings/second-order.md)'s minimiser box**, and correct [INDEX-results.md](../findings/INDEX-results.md) row 162, which carries the uncorrected $0.38673/n$.

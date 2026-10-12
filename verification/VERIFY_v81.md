# VERIFY v81, L149's uniformity of branch 2, its $\rho^{\mathrm{eff}}_n$, and the $\tfrac29$ read as identity and as bound

*Cold read of [findings/second-order.md](../findings/second-order.md):1211–1264 on the brief of [ROUND_L149r2](ROUND_L149r2.md), with no passage marked as new. No numerical work: no script was run, and every value below is an exact hand evaluation from the constants the entry itself names. Log at [agent_logs/verify-L149r2-v81.log](../agent_logs/verify-L149r2-v81.log).*

| # | Claim | Verdict |
| --- | --- | --- |
| C1 | $\rho^{\mathrm{eff}}_n=3\theta_0\frac{n-8}{2(n-2)}-\frac29\lvert\kappa_n\rvert$ equals the closed form $\sqrt6-\theta_0\frac{n+16}{2(n-2)}$ | **CONFIRMED** |
| C2 | $\rho^{\mathrm{eff}}_n$ strictly increases in $n$, and is positive from $n=12$ | **CONFIRMED** |
| C3 | $\inf_{w\ge0}g_\rho=\frac1n\sqrt{\rho\kappa/(\rho a_0^2+\kappa)}$, with no case analysis needed | **CONFIRMED** |
| C4 | The $n$-free coefficient increases in $n$ and equals $0.7197978$ at $n=12$, so $g_\rho\ge0.71979/n$ on $w\in[0,1]$ | **CONFIRMED** |
| C5 | $c(H)\ge c_p+3\theta_0\frac{m-4}{2(m-1)}w^2$, the coefficient being $c_{\min}-c_p$ | **CONFIRMED** against [L27](../findings/nondegeneracy.md)'s ten values |
| C6 | $a_0n^{-1/2}$ is [L146](../findings/second-order.md)'s supremum, and no $\sqrt2$ is owed on the joint two-copy eigenspace | **CONFIRMED** |
| C7 | The $\tfrac29$ is an identity on $\Lambda^2\!\otimes\!\Lambda^2$ and a bound on $\mathcal W_n$, and the text uses each in its place | **CONFIRMED** |
| C8 | The hypothesis box at line 1247 lists the hypotheses the chain uses | **REFUTED**, three are used and unlisted |
| C9 | "the only relation on file being $u\le w$" | **REFUTED**, the same entry proves $u=\tfrac{\sqrt2}3\lVert\Pi_{\Lambda^2\otimes\Lambda^2}H\rVert$ |
| C10 | "the net coefficient is $\tfrac32\theta_0-\lvert\kappa_n\rvert\to0.416$" | **SUPERSEDED**, the coefficient-$1$ reading the entry itself excludes |
| C11 | The reported joint minimum "$\Theta(n^{-1-\beta})$ attained at $w=0$" | **ORDER CONFIRMED, ATTAINMENT REFUTED** |
| C12 | [results.md](../results.md):363's "branch 2's minimum sits at the homogeneity kink $w_0=(n-4)/n$" | **REFUTED** at $n=12$ |
| C13 | [results.md](../results.md) carries no canonical L149 | **ABSENCE CORRECT**, with one consequence recorded |

**One line.** Everything the entry actually proves, branch 2's uniform floor, its numeral, and $\rho^{\mathrm{eff}}_n$'s positivity and monotonicity, is correct and I reproduced every digit of it by hand; the debt the entry discloses is still owed, its hypothesis box is short by three, and two of its own numerals are stale against boxes standing four lines below them.

## 0. Conventions, fixed once

$n=2m$, $W^*=S^m\times S^m$, $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$. $H$ ranges over $T_{W^*}S\cap T_{W^*}\mathcal O^\perp$ with $\lVert H\rVert_F=1$; $H=H_s+H_r$ with $H_s$ in the joint $\lambda_m$-eigenspace (both $S^2_0(\mathbb R^m)$ copies) and $w=\lVert H_r\rVert\in[0,1]$, so $\lVert H_s\rVert_F^2=1-w^2$. $c_p=3\theta_0/(n-2)$, $\kappa=nc_p=3\sqrt{2(n-1)/(n-2)}$, $\lvert\kappa_n\rvert=9(\theta_0-\sqrt{3/2})$, $a_0=\sqrt{2n/(n-2)}$, $\rho=\rho^{\mathrm{eff}}_n$, $b:=a_0n^{-1/2}=\sqrt{2/(n-2)}=1/\sqrt{m-1}$.

At $n=12$, exactly: $\theta_0=\sqrt{220}/12=1.2360331$, $c_p=0.3708099$, $\kappa=3\sqrt{2.2}=4.4497191$, $\lvert\kappa_{12}\rvert=0.1015939$, $a_0^2=2.4$, $b=1/\sqrt5=0.4472136$, $\rho^{\mathrm{eff}}_{12}=0.7190434$.

Two symbols collide and the entry disambiguates only one of the collisions. It flags $\kappa$ against $\lvert\kappa_n\rvert$ at line 1249. It does not flag that the bare $\rho$ of line 1226 ("$\lVert A''\rVert=O(1/\rho)$") and of branch 3 ("$\rho(H)/2$") is the analyticity radius, while the bare $\rho$ of lines 1249–1253 is $\rho^{\mathrm{eff}}_n$; line 1249 sets "$\rho=\rho^{\mathrm{eff}}_n$" locally, which is enough to read the proof but not enough to read the display at line 1228 and the proof in one pass.

## 1. The hypothesis inventory

**Every hypothesis the statement carries.** The boxed statement at line 1232 carries $m\ge6$ and $w\in[0,1]$ and nothing else. The box at line 1247, headed "HYPOTHESES THE CHAIN USES", carries $H\perp W^*$, $H\perp T_{W^*}\mathcal O$ and $\ker W^*=0$.

**Every hypothesis of every imported result, checked against the object it applies to.**

| Import | Its hypotheses | Against the object here |
| --- | --- | --- |
| [L27](../findings/nondegeneracy.md), the ten-summand splitting and its $L_e$ values | $p,q\ge3$, $(p,q)\ne(3,3)$ | $p=q=m\ge6$: **holds** |
| [L27](../findings/nondegeneracy.md), multiplicity-freeness, used again in the $\tfrac29$ box | Young labels distinct; the $p,q\le4$ case supplied by commutant computation | $m\ge6$ is inside the source's own $p,q\ge5$ range: **holds** |
| [L146](../findings/second-order.md), $\lVert H\rVert_{op}$ on one $S^2_0$ copy | $m\ge3$ for the formula; $m\ge5$ for "the margin sits on this summand", where $\lambda_m>\mu$ | $\lambda_m>\mu\iff\frac{m-2}2>1\iff m\ge5$; $m\ge6$: **holds** |
| [L146](../findings/second-order.md), the joint two-copy extension | the cross-plane branch caps at $\sqrt{m-2}/m$ | $(m-1)(m-2)<m^2\iff 3m>2$: **holds** |
| [L148](../findings/second-order.md), the defect vanishes on the margin summand | $m\ge3$; $H$ in the **joint** $\lambda_m$-eigenspace $\Sigma$; the frame chosen after $H$ | **holds**, but see §6 for how L149 cites it |
| [L133](../findings/second-order.md) step 3, the signed $(2,2)$ coordinates and the $+\mu$ eigenvector | $n\ge12$ | **holds** |
| [L147](../findings/second-order.md), $M=O(\rho)$, hence $\lVert A''\rVert=O(1/\rho)$ | $n=2m\ge12$, $\lVert H\rVert_F=1$, $\lVert H\rVert_{op}\le1$, $H\perp W^*$, $H\perp T_{W^*}\mathcal O$ | **holds**, and $\lVert H\rVert_{op}\le1$ is free *given* $\lVert H\rVert_F=1$ |
| [L158](../findings/second-order.md), branch 2 is $Kg_\rho$ with $K$ bounded below | its own list at line 1296 | **holds in kind**; see §7 for what I could not reduce to a numeral |

**Then which the written proof uses, and which the box omits.** Three hypotheses are used by name in the proof and absent from the box at line 1247.

- **$\lVert H\rVert_F=1$.** Line 1224 uses it in the words "so on $\lVert H\rVert_F=1$ it is a **convex combination** of the summand margins". Without it the margin is a quadratic form and not a convex combination, $\lVert H_s\rVert_F^2=1-w^2$ fails, $w\in[0,1]$ is not a range, and the free import of $\lVert H\rVert_{op}\le1$ from L147 is lost. It is the single most load-bearing hypothesis in the entry and it is the one the box drops.
- **$W^*=S^m\times S^m$ with $p=q=m$.** Line 1219's whole correction ("there are **two** $S^2_0(\mathbb R^m)$ summands, both carrying $\lambda_m$), the swap of the factors fixes $W^*$", is an assertion about the balanced point. At $p\ne q$ the two copies carry $\lambda_p\ne\lambda_q$, the swap is not a symmetry, and $H_s$ is not an eigenspace.
- **$n=2m$ even.** Every conversion between the $m$-form $3\theta_0\frac{m-4}{2(m-1)}$ and the $n$-form $3\theta_0\frac{n-8}{2(n-2)}$ is the substitution $n=2m$, and $c_p=3\theta_0/(n-2)$ is $3\theta_0/(2(m-1))$ by the same substitution.

The two neighbouring entries in the same file carry the list the box is missing. [L147](../findings/second-order.md)'s box at line 1179 lists four ("Base point $W^*=S^m\times S^m$; $n=2m$ even; $n\ge12$ …; and $\ker W^*=0$), **all four used and none stated until [ROUND_L147](ROUND_L147.md)**". [L158](../findings/second-order.md)'s at line 1296 lists six, "$n=2m$ even with $n\ge12$; $W^*=S^m\times S^m$ with $\ker W^*=0$; $H\perp W^*$ and $H\perp T_{W^*}\mathcal O$; $\lVert H\rVert_F=1$; and $w\in[0,1]$." L149 sits between them and carries the shortest list of the three. This is the pattern the brief warns of, at one file's scale: a correction entered in the entries either side of the one being audited.

There is a small circularity worth stating positively. The box lists $\ker W^*=0$ and then discharges it, "it **holds**, the gap being $g_n=\sqrt{2(n-2)}/(n\sqrt{n-1})$". That discharge is a theorem about the *pinned* base point, so the hypothesis it omits ($W^*=S^m\times S^m$) is what pays the hypothesis it lists.

*No finding on the domain hypotheses:* $H\perp W^*$ and $H\perp T_{W^*}\mathcal O$ are exactly what removes the $\lambda=1$ summand (margin $-\tfrac32\theta_0$) and the $\lambda=\tfrac12$ orbit summand (margin $0$) from the convex combination, and the box says so. Both are supplied by the stated domain.

## 2. Pre-registered question 1, does the entry state one thing about its own conclusion?

**It does, and the thing it states is another lemma's.** No two statements in the entry contradict each other. The defect is of a different shape.

- The box at line 1232 is headed "**LEMMA L149**" and states three clauses: branch 2 is $\Omega(n^{-1})$ uniformly in $w\in[0,1]$; branch 1 is minimised at $w=0$; branch 3 is $\Omega(n^{-1})$. The second clause carries, inside the same italic run, "***this clause does not follow and is owed***". So the numbered box cannot be quoted as a lemma: one third of its statement is marked false where it stands.
- Line 1233 then says "**THE CONCLUSION THIS BOX DRAWS IS OWED RATHER THAN REFUTED**" and identifies the conclusion as $r_n\gtrsim n^{-1-\beta}$, which the box nowhere displays.
- The box's actual display, line 1234, is $r_n\gtrsim n^{-3/2}$, and line 1235 says of it "which is [L145](../findings/second-order.md)'s $\Theta(n^{-3/2})$ and is untouched by this correction". Line 1233 says the same in stronger terms: "**[L145](../findings/second-order.md)'s $r_n=\Omega(n^{-3/2})$ stands on its own proof and is unaffected either way.**"

So the box displays a result the entry twice says L149 does not touch, while the result L149 is about (the strengthening to $n^{-1-\beta}$), appears only in the prose that says it is owed. The withdrawal of the refutation is correctly reasoned and I confirm it: $r(H)$ is bounded below by every branch of a $\min$, so exhibiting a branch smaller than $n^{-1-\beta}$ falsifies nothing about $r_n$. That reasoning is sound and it is the third time in the file's history it has had to be written down.

**Answer:** the box asserts one thing; that thing is L145's; the entry's own content is stated around the box rather than in it. Nothing disagrees with anything.

## 3. Pre-registered question 2, identity or bound, and which does the text use?

**Both, and the text uses each in its own place, correctly.** The two roles are genuinely different and the entry needs them both.

**The identity, verified in full from the entry's own $\sigma$.** On a $(2,2)$ four-set the block is the plane $\{x+y+z=0\}$ and the entry gives $\sigma=x^2/\big(3(x^2+y^2+z^2)\big)$. Write a point of that plane in the orthogonal frame

$$(x,y,z)=\frac{\alpha}{\sqrt6}(2,-1,-1)+\frac{\beta}{\sqrt2}(0,1,-1),\qquad \lVert(x,y,z)\rVert^2=\alpha^2+\beta^2 .$$

Then $x=2\alpha/\sqrt6$, so $x^2/3=\tfrac49\alpha^2/\tfrac{6}{6}\cdot\tfrac13$, evaluated exactly, $x^2=\tfrac46\alpha^2=\tfrac23\alpha^2$ and $x^2/3=\tfrac29\alpha^2$. The $\beta$-component contributes nothing at all. Hence

$$\sigma\lVert(x,y,z)\rVert^2=\tfrac29\alpha^2=\tfrac29\lVert\Pi_{\mathbb RX_{ijkl}}(x,y,z)\rVert^2,$$

which is exactly the entry's $\lVert D(\mathrm{Alt}\,W_-)_{W^*}[H]\rVert^2=\tfrac29\lVert\Pi_{\Lambda^2\otimes\Lambda^2}H\rVert^2$, four-set by four-set. The maximum of $\sigma$ over the plane is $\tfrac29$, attained exactly on $\mathbb R(2,-1,-1)$: given $x$, $y^2+z^2$ is least at $y=z=-x/2$, worth $x^2/2$, so $x^2/(x^2+y^2+z^2)\le\tfrac23$ and $\sigma\le\tfrac29$. The projection $(1,0,0)-\tfrac13(1,1,1)=\tfrac13(2,-1,-1)$ is arithmetic and correct.

**Where the bound does the work.** The penalty enters the numerator as $-\lvert\kappa_n\rvert\,u^2$ against a margin $c_{\min}w^2$, and what is needed is an *upper* bound on the penalty: $u^2=\tfrac29\lVert\Pi_{\Lambda^2\otimes\Lambda^2}H\rVert^2\le\tfrac29w^2$, since $\Lambda^2\!\otimes\!\Lambda^2$ is one of the summands making up $H_r$ and is orthogonal to both $S^2_0$ copies. That gives

$$c(H)-\text{penalty}\ \ge\ c_p(1-w^2)+c_{\min}w^2-\tfrac29\lvert\kappa_n\rvert w^2\ =\ c_p+\rho^{\mathrm{eff}}_nw^2,$$

which is the display's numerator. The convex combination over summands needs only $\sigma\le\tfrac29$; **the bound alone makes the display valid.**

**Where the identity does the work.** Two places, both real.

- *Attainment.* The margin coefficient is a **minimum** over the surviving summands and the penalty coefficient is a **maximum** over directions. If those two landed on different summands, $c_{\min}-\tfrac29\lvert\kappa_n\rvert$ would be conservative rather than equal to the true coefficient. The entry proves they co-locate, $E_{L_e}(\mu)=\Lambda^2\!\otimes\!\Lambda^2$ by equal dimensions inside a containment, $\binom m2^2$ independent $X_{ijkl}$ against [L27](../findings/nondegeneracy.md)'s $\dim E_{L_e}(\mu)=\binom m2^2$, so the coefficient is attained. This is the sense in which "L149's convex combination has the form it claims".
- *Monotonicity in $n$.* Line 1243 is right, and I reproduce it: at penalty coefficient $1$ the coefficient runs $0.6400265$ at $n=12$ down to $\tfrac32\sqrt2-9(\sqrt2-\sqrt{3/2})=0.4161021$, so it **decreases** and $\rho^{\mathrm{eff}}_n\ge\rho^{\mathrm{eff}}_{12}$ would be false. Under $\tfrac29$ it increases (§7, C2). So the $\tfrac29$ is what turns the uniformity proof's "its minimum over even $n\ge12$" into a statement.

**And a consequence the entry does not draw, which is finding C9.** The identity pins $u$, not merely bounds it:

$$u=\lVert D(\mathrm{Alt}\,W_-)_{W^*}[H]\rVert=\tfrac{\sqrt2}3\lVert\Pi_{\Lambda^2\otimes\Lambda^2}H\rVert\ \le\ \tfrac{\sqrt2}3\,w=0.4714\,w .$$

That $u$ and this $u$ are the same object: line 1261 writes the penalty as $\lvert\kappa_n\rvert u^2t^2$ from $-\kappa_n\delta^2$ with $\delta$ the defect, so $u$ is the defect's linear rate, which is what line 1245 prices. Yet line 1230 says, in the present tense and unqualified, "**the only relation on file being $u\le w$**". The entry understates its own holding by a factor $\tfrac{\sqrt2}3$ and, worse, states as a one-sided bound something it has just proved to be an equality. This matters because the open debt is a **joint minimisation over the shared direction**, and the $u$–$w$ link is precisely the constraint that minimisation runs against.

## 4. The named trap, every place a branch is evaluated, and at which point of which variable each factor is read

The trap is real, it is in the entry, and the entry discloses it in seven words. Bullet 1 reads $H_s$'s contribution to the denominator at $\lVert H_s\rVert_F=1$, that is at $w=0$, while the numerator reads $H_s$'s contribution to the margin at $\lVert H_s\rVert_F^2=1-w^2$, that is at $w$. The disclosure is "which is homogeneous so $\lVert H_s\rVert_F<1$ only helps", and the direction is safe: an enlarged denominator understates $g_\rho$, and a lower bound survives being understated.

| Where | Numerator, read at | Denominator, read at | Direction |
| --- | --- | --- | --- |
| Line 1216, the sweep chain | $c(H)\ge c_p+\rho w^2$ at $w$ | $\lVert H\rVert_{op}\le b+w$, the $H_s$ term at $w=0$ | safe: the inflated $b$ makes $w=\Omega(1)$ **harder** to conclude, so the conclusion is conservative |
| Line 1217, the counterexample direction | margin $\Theta(1/n)$ forces $w=O(n^{-1/2})$, read at $w$ | $\lVert A''\rVert=O(n^{1/2}+nw)=O(n^{1/2})$, at the same $w=O(n^{-1/2})$ | safe **and tight**: at $w\lesssim n^{-1/2}$, $\sqrt{1-w^2}=1-O(1/n)$, so the dropped factor costs nothing |
| Line 1234, the display $r_n\gtrsim n^{-3/2}$ | not L149's; L145's own proof | (|), |
| Line 1241, "at $\rho=0$ … $\Theta(n^{-3/2})$ at $w=1$" | $\sqrt{c_p}$, $w$-free because $\rho=0$ | $a_0n^{1/2}+n$ at $w=1$ | correct: $g_0$ is decreasing in $w$, so $w=1$ is its infimum on $[0,1]$ |
| Line 1241, "bounded below it gives $\Theta(n^{-1})$" | $\sqrt{c_p+\rho w^2}$ at the stationary $w$ | $a_0n^{1/2}+nw$ at the same $w$ | consistent: both at $w^*$ |
| Lines 1249–1253, the uniformity proof | at $w$, with $\lVert H_s\rVert_F^2=1-w^2$ | at $w$ for the $nw$ term, at $w=0$ for the $a_0n^{1/2}$ term | **the trap**, disclosed, and safe |
| Line 1259, "$\Omega$, not $\Theta$" | $\sqrt{c_p}$ at $w=0$ | $a_0n^{1/2}$, whereas the true denominator is $0$ by L148 | this *is* the slack the trap creates, and the entry names it as the live resource |
| Line 1263, the ceiling $c_p/S\le c_p/\theta_0\le3/(n-2)$ | $c_p$, at $u=0$ | $S\ge\theta_0$ | correct as a **ceiling**: $\inf f\le f(0)=c_p/S$, so an upper bound on the branch's infimum is what is wanted |

Two of these deserve a sentence more.

**Line 1259 measures the trap's size.** At $w=0$ the true branch is unbounded and $g_\rho(0)=\sqrt{c_p}/(a_0n^{1/2})=0.6089418/5.3665631=0.1134680$ at $n=12$, against the proved floor $0.71979/12=0.0599825$. The written bound is finite where the object is infinite, which is exactly why the entry says $\Omega$ and not $\Theta$, and it is right to.

**The trap costs a constant and the sharper envelope is on file elsewhere.** [results.md](../results.md):363 carries $\lVert H\rVert_{op}\le\min(b\sqrt{1-w^2}+w,1)$, which is the consistent reading. At $n=12$, $w=1$: the entry's denominator is $n(b+1)=12\times1.4472136=17.3665632$ and the true one is at most $n=12$, so the entry's branch-2 floor is loose by up to $45\%$ at the top of the range. Loose in the safe direction, and the entry's numeral remains a valid floor.

## 5. The edge of every range

**The smallest admissible dimension.** $m\ge6$, i.e. $n\ge12$, and the entry's reason is exact: at $n=10$, $\theta_0=\sqrt{2\cdot9\cdot8}/10=\sqrt{144}/10=6/5=1.2$ exactly, against $\sqrt{3/2}=1.2247449$, so $\lvert\kappa_{10}\rvert=9(1.2-\sqrt{3/2})<0$ and $\rho^{\mathrm{eff}}_{10}$ is undefined as written. The general form: $\theta_0>\sqrt{3/2}\iff 4(n-1)(n-2)>3n^2\iff n^2-12n+8>0\iff n>6+2\sqrt7=11.2915$, so $n=12$ is the first even dimension and the boundary is strict there ($220/144=1.5\overline{27}>1.5$). "**The range matters**" at line 1224 is exact at all three of its edges: $3\theta_0\frac{m-3}{2(m-1)}$ is $0$ at $m=3$; at $m=4$ it is $3\theta_0/6$, which is exactly $c_p=3\theta_0/(2(m-1))=3\theta_0/6$, so they tie; at $m=5$ it is $3\theta_0\cdot\tfrac28=\tfrac34\theta_0$, so "$\ge\tfrac34\theta_0$ only from $m=5$" is an equality at the first admissible point and the quantity increases in $m$.

**$w$ at both ends.** At $w=0$: $g_\rho(0)=0.1134680$, above the floor. At $w=1$: $g_\rho(1)=\sqrt{0.3708099+0.7190434}/(5.3665631+12)=1.0439603/17.3665631=0.0601131$, also above the floor $0.0599825$, by $0.22\%$. This is the tightest point in the whole entry and it is on the right side. The reason it is tight and not attained is that the unconstrained stationary point sits just outside the interval: $w^*=\kappa/(\rho a_0n^{1/2})=4.4497191/(0.7190434\times5.3665631)=4.4497191/3.8587903=1.1531$. So the true minimum of $g_\rho$ on $[0,1]$ is at the endpoint $w=1$, worth $0.721357/n$, and the entry's $0.7197978/n$ is the relaxation's value. **The relaxation is what makes "no case analysis on the location of the stationary point is needed" true, and it is true.**

**$\ker W\ne0$, and $W_{\mathbb{CP}^2}$ with $\dim\ker W=3$.** No finding, and the reason is worth stating rather than passing over. L149's $W^*$ is pinned to $S^m\times S^m$, so $\ker W^*=0$ is not a restriction on a range but a theorem about the base point, and $W_{\mathbb{CP}^2}$ is simply not in the entry's domain. The box treats it correctly, it lists it as a hypothesis the chain uses and then discharges it with the gap $g_n=\sqrt{2(n-2)}/(n\sqrt{n-1})$, which is $\Theta(n^{-1})$ and positive throughout. What L149 does **not** carry, and both its neighbours do, is the statement of what happens off that base point: [L147](../findings/second-order.md):1179 says "$W_{\mathbb{CP}^2}$ is Morse–Bott nondegenerate with $\dim\ker W=3$, so $g_n$, $\rho$, $M$ and branches 2–3 **do not exist there**", and [L158](../findings/second-order.md):1296 says "At $\ker W\ne0$ the entry asserts nothing". Since L149's $W^*$ is pinned, the omission is correct rather than a gap, but it is the third entry in a row to price the same object and the only one that does not name the witness.

## 6. Quantifier order and scope

**Singular against plural: one residual, in the sentence that repairs the same error.** Line 1219 exists to fix a singular, "An earlier version wrote 'the margin summand', singular, and put the second copy into $H_r$". Thirteen lines later, line 1232 says "[L148](../findings/second-order.md) pins the **variable** $u$ to zero on **the named copy**". [L148](../findings/second-order.md)'s boxed statement at line 1199 pins it on the joint eigenspace $\Sigma$, "**both** $S^2_0(\mathbb R^m)$ copies, of dimension $(m+2)(m-1)$". At $n=12$ that set has dimension $8\times5=40$; "the named copy" names $20$ of them. The direction is understatement, and the sentence's purpose (to say that L148 constrains $u$ and not $a$) is unaffected, so nothing downstream moves. It is recorded because the entry's own history is this exact error and because the plural is used correctly in the four other places it appears (lines 1219, 1221, 1245 and L148's own box).

**One variable substituted for another: the entry is clean where it matters and states the danger.** Line 1230 says "$u$ is the defect's linear rate and is **not** $w$", and the display at line 1228 keeps branch 1 in $u$ and branch 2 in $w$. Line 1249 separates $\kappa$ from $\lvert\kappa_n\rvert$ explicitly and prices the confusion. The one collision left unflagged is $\rho$, noted in §0.

**Quantifier order in the headline.** "the second branch is $\Omega(n^{-1})$ **uniformly in $w\in[0,1]$**" is $\exists c>0\ \forall n\ \forall w$, and that is what the proof delivers: the coefficient $\big(\tfrac{\sqrt2n}{3\sqrt{(n-1)(n-2)}}+\tfrac1\rho\big)^{-1/2}$ is minimised over $n$ *before* $w$ is quantified, because the relaxation to $w\ge0$ has already removed $w$. The order is right and the relaxation is what makes it right.

## 7. Every numeral against the constants the entry names

**C1, the closed form.** $\tfrac29\lvert\kappa_n\rvert=2(\theta_0-\sqrt{3/2})=2\theta_0-\sqrt6$, so

$$\rho^{\mathrm{eff}}_n=3\theta_0\tfrac{n-8}{2(n-2)}-2\theta_0+\sqrt6=\sqrt6+\theta_0\cdot\tfrac{3(n-8)-4(n-2)}{2(n-2)}=\sqrt6-\theta_0\tfrac{n+16}{2(n-2)} .$$

Confirmed. The $m$/$n$ identity of line 1239 is also exact: $\frac{n-8}{2(n-2)}=\frac{2m-8}{2(2m-2)}=\frac{m-4}{2(m-1)}$.

**C2, monotonicity, then positivity.** $p(n)=\tfrac{n+16}{6n}\kappa=\tfrac{n+16}{6n}\cdot\tfrac{3\theta_0n}{n-2}=\tfrac{(n+16)\theta_0}{2(n-2)}$, so the entry's factorisation is an identity. $\tfrac{n+16}{6n}=\tfrac16(1+16/n)$ is positive and decreasing; $\kappa=3\sqrt{2(1+\tfrac1{n-2})}$ is positive and decreasing; so $p$ decreases and $\rho^{\mathrm{eff}}=\sqrt6-p$ strictly increases. **Confirmed, and the order "monotonicity comes first" is the right order**, with the floor in hand positivity is one comparison. $\rho^{\mathrm{eff}}_{12}=\sqrt6-\tfrac7{30}\sqrt{55}$: indeed $\theta_0(12)\cdot\tfrac{28}{20}=\tfrac{\sqrt{220}}{12}\cdot\tfrac75=\tfrac{14\sqrt{55}}{60}=\tfrac{7\sqrt{55}}{30}$, and positivity is $6>\tfrac{49\cdot55}{900}$, i.e. $5400>2695$. The cubic: squaring gives $12n^2(n-2)>(n-1)(n+16)^2$, and $12n^3-24n^2-(n^3+31n^2+224n-256)=11n^3-55n^2-224n+256$, worth $19008-7920-2688+256=8656$ at $n=12$. **Every step confirmed exactly.**

**C3, the infimum.** With $A=a_0n^{1/2}$, $B=n$, minimising $(c_p+\rho w^2)/(A+Bw)^2$ gives $\rho Aw=Bc_p$, so $w^*=Bc_p/(\rho A)$ and the value is $c_p\rho/(\rho A^2+B^2c_p)$. Substituting $A^2=a_0^2n$, $B^2=n^2$, $c_p=\kappa/n$: $\frac{\kappa\rho/n}{n(\rho a_0^2+\kappa)}$, so $\inf_{w\ge0}g_\rho=\frac1n\sqrt{\frac{\rho\kappa}{\rho a_0^2+\kappa}}$. **Exactly as displayed.** It is a minimum and not an infimum at $\infty$: $g_\rho\to\sqrt\rho/n$ as $w\to\infty$, and the stationary value is smaller by the factor $\sqrt{\kappa/(\rho a_0^2+\kappa)}<1$.

**C4, the $n$-free coefficient.** $\sqrt{\frac{\rho\kappa}{\rho a_0^2+\kappa}}=\big(\tfrac{a_0^2}{\kappa}+\tfrac1\rho\big)^{-1/2}$ and $\tfrac{a_0^2}{\kappa}=\tfrac{2n/(n-2)}{3\sqrt{2(n-1)/(n-2)}}=\tfrac{\sqrt2n}{3\sqrt{(n-1)(n-2)}}$, which is the entry's expression. Both terms decrease in $n$ ($n/\sqrt{(n-1)(n-2)}\downarrow1$ and $1/\rho\downarrow$ by C2) so the coefficient increases and its minimum over even $n\ge12$ is at $n=12$. There: $\tfrac{a_0^2}\kappa=2.4/4.4497191=0.5393603$, $1/\rho=1/0.7190434=1.3907371$, sum $1.9300974$, square root $1.3892794$, reciprocal $\mathbf{0.7197978}$. **The entry's digits, all seven.**

**The two collisions, one flagged and one not.**

- Flagged: substituting $\lvert\kappa_{12}\rvert$ for $\kappa$ gives $(2.4/0.1015939+1.3907371)^{-1/2}=(23.625537+1.390737)^{-1/2}=25.016274^{-1/2}=\mathbf{0.1999350}$, the entry's $0.19994$; and the ratio $4.4497191/0.1015939=\mathbf{43.799}$, the entry's $43.8$. With the **signed** $\kappa_{12}=-0.1015939$ the radicand is $\rho\kappa/(\rho a_0^2+\kappa)=-0.0730/1.6241<0$, so "makes the radicand negative" is right too.
- **Not flagged, and tighter.** $\rho^{\mathrm{eff}}_{12}=0.7190434$ and the uniformity coefficient $0.7197978$ agree to three decimals, are printed nine lines apart, and are different quantities. It is a coincidence and not an identity: the fixed point of $x=(0.5393603+1/x)^{-1/2}$ solves $0.5393603x^2+x-1=0$, i.e. $x=0.7202233\ne0.7190434$. Given that this entry's recorded history is two documented cases of readers substituting one near-equal constant for another, the pair $0.71904$ / $0.71980$ is the next one waiting, and only the $\kappa$ pair carries a warning.

**C5, the margin coefficient against L27.** [L27](../findings/nondegeneracy.md) gives $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$, which at $p=q=m$ is $\frac{(m-2)^2-1}{2(m-1)^2}=\frac{(m-3)(m-1)}{2(m-1)^2}=\frac{m-3}{2(m-1)}$, **exactly** the entry's smallest off-summand margin over $3\theta_0$. And $\lambda_m=\frac{m-2}{2(m-1)}$ gives $\tfrac12-\lambda_m=\frac1{2(m-1)}$, so $c_p=3\theta_0/(n-2)$, matching [L146](../findings/second-order.md)'s "the margin is **exactly** L145's $c_p$". Subtracting: $3\theta_0\frac{m-3}{2(m-1)}-3\theta_0\frac1{2(m-1)}=3\theta_0\frac{m-4}{2(m-1)}$, which is why "the two fractions differ by one in the numerator". Running L27's ten values through $3\theta_0(\tfrac12-\lambda)$ confirms the minimum is on $\Lambda^2\!\otimes\!\Lambda^2$ once $\langle W\rangle$ and the orbit are removed: $-\tfrac32\theta_0$ on $\langle W\rangle$ (excluded by $H\perp W^*$), $0$ on the orbit (excluded by $H\perp T_{W^*}\mathcal O$), $c_p$ on the two $S^2_0$ copies, $3\theta_0\frac{m-3}{2(m-1)}$ at $+\mu$, $3\theta_0(\tfrac12+\mu)$ at $-\mu$, and $\tfrac32\theta_0$ on the four summands at $0$. **The eight-of-ten count and the identification of the minimum both check out.** The numerals: at $n=12$, $3\theta_0\cdot0.2=0.7416199$ (entry: $0.7416$); at $n=14$, $\theta_0=\sqrt{312}/14=1.2616800$ and $3\theta_0\cdot0.25=0.9462600$ (entry: $0.9463$); at $n=16$, $\theta_0=\sqrt{420}/16=1.2808688$ and $3\theta_0\cdot\tfrac8{28}=1.0979$, so "reaching $1$ only from $n=16$" is right and "unsafe exactly on $n\in\{12,14\}$" is right.

**C6, $a_0$ against L146.** $a_0n^{-1/2}=\sqrt{2/(n-2)}=1/\sqrt{m-1}$, which is **exactly** L146's supremum "attained at the pair-concentrated $h$". The joint-eigenspace extension holds and its two ingredients are the right ones. Hilbert–Schmidt orthogonality: both images are diagonal on coordinate $2$-planes, they overlap only on the cross planes, and there the inner product is $\alpha^2\sum_{a,b}h_ak_b=\alpha^2(\sum_ah_a)(\sum_bk_b)=0$ by tracelessness, so $\lVert H_s\rVert_F^2$ splits and each in-block branch is bounded by $\lVert H_s\rVert_F/\sqrt{m-1}$. Cross branch: $\sqrt{m-2}/m<1/\sqrt{m-1}$ since $(m-1)(m-2)<m^2$. At $n=12$ the entry's figures are exact, $\sqrt4/6=1/3=0.333$ and $1/\sqrt5=0.447$. **No $\sqrt2$ is owed and the entry's reason is the correct reason.**

**The $n\to\infty$ values.** $\rho^{\mathrm{eff}}_\infty=\tfrac32\sqrt2-2(\sqrt2-\sqrt{3/2})=2.1213203-0.3789374=\mathbf{1.7423829}$, which also equals $\sqrt6-\tfrac{\sqrt2}2$ from the closed form. Coefficient-$1$: $2.1213203-1.7052182=\mathbf{0.4161021}$, at $n=12$ $0.7416199-0.1015939=\mathbf{0.6400260}$. Coefficient-$1$ uniformity constant at $n=12$: $(0.5393603+1/0.6400260)^{-1/2}=(0.5393603+1.5624356)^{-1/2}=2.1017959^{-1/2}=\mathbf{0.6897717}$, the entry's $0.689771$; its limit $(0.4714045+1/0.4161021)^{-1/2}=(0.4714045+2.4032570)^{-1/2}=2.8746615^{-1/2}=\mathbf{0.5898040}$, the entry's $0.589804$.

**The one numeral I could not reproduce.** The entry's superseded $0.582938$, described as "having held $\sqrt2n/(3\sqrt{(n-1)(n-2)})$ at its $n=12$ value inside an $n\to\infty$ limit". Reconstructing exactly that error gives $(0.5393603+2.4032570)^{-1/2}=2.9426173^{-1/2}=\mathbf{0.5829530}$, against the recorded $0.582938$, agreement to four significant figures and a disagreement in the fifth. I tried three other readings of the sentence (both constants at $n=12$; both at $\infty$; the $\tfrac29$ value of $\rho$ with the $n=12$ first term) and none lands nearer. Nothing turns on it: the value is withdrawn where it is recorded and appears in no chain. **Reported because the brief asks which numerals I could and could not reproduce, and this is the only one.**

**C10, line 1261's net coefficient.** "the net coefficient is $\tfrac32\theta_0-\lvert\kappa_n\rvert\to2.1213-1.7053=0.416>0$, **positive by 20%**". The arithmetic is exact ($0.4161021/2.1213203=19.6\%$), and $\tfrac32\theta_0$ is the $n\to\infty$ limit of $3\theta_0\frac{n-8}{2(n-2)}$, so both factors are read at $\infty$ and the sentence's $\to$ says so. What is wrong is the coefficient. Line 1243 names $0.4161$ as the value of "**penalty coefficient $1$**" and line 1245 says "**The coefficient-$1$ reading is excluded rather than disfavoured**". So line 1261 states, with the definite article and no qualification, a number that two boxes below it the entry declares excluded; the entry's own post-discharge value for the same limit is $1.7423829$, larger by the factor $4.1874$. The charitable reading is that line 1261 prices the penalty per unit $u^2$ at the pessimal $u=w$, which "$u\le w$" licenses, but C9 shows that pessimal case cannot occur, since $u\le\tfrac{\sqrt2}3w$ with equality only on $\Lambda^2\!\otimes\!\Lambda^2$. The direction is safe throughout: $0.416>0$ is a valid weaker statement and positivity is all line 1261 claims. **Recorded as a stale numeral, not as an error.**

**C11, the reported joint minimum, adjudicated.** Line 1233 reports, as unadjudicated, that "the minimisation of $(c_p+w^2)/(S+n\max(n^{-1/2},w)w)$ is reported by one reader as $\Theta(n^{-1-\beta})$ **attained at $w=0$**". Call that function $F$. On $w\in(0,n^{-1/2})$ the $\max$ is $n^{-1/2}$, so $F(w)=(c_p+w^2)/(S+n^{1/2}w)$ and $F'(0^+)=-c_pn^{1/2}/S^2<0$, **the entry's own $f'(0)<0$, two sentences above, applied to the entry's own function.** So the attainment clause is refuted by the sentence that precedes it. The minimum is interior at $w^*=(\sqrt{S^2+\kappa}-S)/n^{1/2}$ with value $2w^*/n^{1/2}=2(\sqrt{S^2+\kappa}-S)/n$.

Exhibited in closed form at $n=12$, with the record's own constants, $c_p=3\theta_0(12)/10=0.3708099$, $\kappa=4.4497191$, and $S=1+\sqrt{n-2}=1+\sqrt{10}=4.1622777$ from [Lemma L143](../findings/bounds.md) as [results.md](../results.md):363 uses it:

$$\sqrt{S^2+\kappa}=\sqrt{17.3245553+4.4497191}=\sqrt{21.7742744}=4.6662913,\quad w^*=\tfrac{0.5040136}{3.4641016}=0.1454959,$$

which is below $n^{-1/2}=0.2886751$, so it lies in the right branch of the $\max$. Then $F(w^*)=2\times0.1454959/3.4641016=\mathbf{0.0840020}$ against $F(0)=c_p/S=0.3708099/4.1622777=\mathbf{0.0890882}$. **The minimum is strictly below the value at $w=0$, by $5.71\%$.** The *order* survives untouched: $2(\sqrt{S^2+\kappa}-S)/n\asymp\kappa/(nS)=\Theta(n^{-1-\beta})$ whenever $S\gtrsim1$, and the ratio to $F(0)$ is $0.9429$ here. So the reader's report is right in its order and wrong in its attainment point, and the entry can record the first while striking the second. The entry's formulae behind this are all correct: $f'(0)=-ac_p/S^2$, $u^*=(\sqrt{S^2+a^2c_p}-S)/a$, and $f(u^*)=2u^*/a$ each check by direct differentiation, and $u^*\le\sqrt{c_p}$ follows from $(S+a\sqrt{c_p})^2\ge S^2+a^2c_p$.

**The one claim I could not reduce to a numeral.** Line 1255's "$K<1$ by better than an order of magnitude" and "$K$ being bounded below by a positive constant" are imported from [L158](../findings/second-order.md) and its constants $\lambda$, $\eta^*$, $J$ do not appear in lines 1211–1264. It is supported **in kind** by the canon entry at [results.md](../results.md):363, which gives $T=\kappa/(K s_\rho(w_0))$ running from $18.00$ at $n=12$ to about $35$ in the limit, with $\lambda=2/\sqrt{\lvert\kappa_n\rvert}$ finite on the admissible range; that bounds $K$ away from zero provided $s_\rho(w_0)$ is bounded, which is not stated in either place. I did not verify a numeral for $K$, and the entry's order claim "branch 2 is $\Omega(n^{-1})$" rests on it. This is **not** recorded as a debt: the claim is cited, the citation carries the supporting numbers, and the brief's instruction is to read the cited report before calling something unargued. It is recorded as the one step of the chain I checked by inheritance rather than by hand.

## 8. results.md and the canonical form

**There is no canonical L149, and the absence is correct.** [results.md](../results.md) carries numbered canon entries for L133, L140 and L154–L158 and none for L145–L149; its "Audit owed" closing section lists L0, L1, L68 and L72 only, and [findings/INDEX.md](../findings/INDEX.md)'s row for [second-order.md](../findings/second-order.md) does not name L149 either. Against results.md's own rule ("a result appears here once Gate 2 has passed"), L149 does not qualify: line 1213 records Gate 2 as "[r452](../reviews/REVIEW_r452.md) and [r453](../reviews/REVIEW_r453.md) … returned PLAUSIBLE **with the margin step REFUTED as stated and repairable**", and line 1257 records "[ROUND_L149](ROUND_L149.md), verdict `GAP` on the previous proof, repaired here; the repair is itself unaudited". Neither is a pass. **The absence is correct and I record it as correct.**

**One consequence, and it is structural.** [Lemma L158](../results.md) *is* in the canon, at [results.md](../results.md):361, with Gate 2 passed and a verification round behind it, and its first clause opens "In Lemma L149's parametrisation". So a Gate-2-passed canon entry rests on the parametrisation of an entry the canon does not carry, and a reader working from results.md alone cannot recover what $c_p$, $u$, $w$, $a$ and $\rho^{\mathrm{eff}}$ are.

**C12, and the canon entry disagrees with itself about branch 2.** [results.md](../results.md):363 states "**its minimum sits at the homogeneity kink $w_0=(n-4)/n$, which is $\tfrac23$ at $n=12$**, the envelope being $\lVert H\rVert_{op}\le\min(a_0n^{-1/2}\sqrt{1-w^2}+w,1)$ and equal to $1$ above $w_0$". The kink itself is exact: $b\sqrt{1-w^2}=1-w$ with $b^2=2/(n-2)$ gives $2(1+w)=(n-2)(1-w)$, hence $w_0=(n-4)/n$, which is $\tfrac23$ at $n=12$, and I confirm the envelope reaches exactly $1$ there, $0.4472136\times\sqrt{5/9}+\tfrac23=0.3333333+0.6666667=1$.

The **location** of the minimum is wrong. With $s(w)=\sqrt{c_p+\rho w^2}$ and denominator $n\big(b\sqrt{1-w^2}+w\big)$ below the kink, the logarithmic derivative at $w_0^-$ is

$$\frac{\rho w_0}{c_p+\rho w_0^2}-\Big(1-\frac{bw_0}{\sqrt{1-w_0^2}}\Big)=\frac{0.7190434\times\tfrac23}{0.6903847}-\Big(1-\frac{0.4472136\times\tfrac23}{0.7453560}\Big)=0.6943006-0.6=+0.0943006>0,$$

so the ratio is **increasing** at the kink; above the kink the denominator is the constant $n$ and the numerator increases, so it is increasing there too. The minimum is therefore strictly interior, at $w\approx0.605$: exact evaluations give $0.0690416$ at $w=0.6$ and $0.0692412$ at $w=w_0=\tfrac23$, so the kink is $0.29\%$ above the true floor. The finding is robust to which $\rho$ is meant, the threshold is $\rho>0.5562$, and both $\rho^{\mathrm{eff}}_{12}=0.7190434$ and the coefficient-$1$ value $0.6400260$ clear it. Nothing about the *order* changes, and results.md's floor coefficient $\approx0.8285$ is the sharper of the two on file (L149's is $0.7197978$, valid and looser because it drops the envelope's $\sqrt{1-w^2}$ and its cap). **The two files also name two different minimisers for branch 2, $w_0=\tfrac23$ in results.md, $w^*=1.1531$ relaxed and $w=1$ constrained in L149, because they minimise two different functions, and neither says so.**

## 9. Candidates raised and withdrawn

**Withdrawn: "$w=0$ is where branch 1 is largest rather than smallest" (line 1232) as a global claim.** Located, and the failure exhibits: $f(1)-f(0)=\frac{S(c_p+1)-c_p(S+a)}{S(S+a)}=\frac{S-ac_p}{S(S+a)}$, which is positive for every $a<S/c_p=11.2251$ at $n=12$ with $S=1+\sqrt{10}$, so at $a=1$, say, $f(1)>f(0)$ and $w=0$ is not the largest. But the third step rescues it: the sentence's only job is to deny minimality, "largest" reads naturally as "larger than its neighbours", which $f'(0)<0$ delivers, and nothing downstream uses a global maximum. **Withdrawn as a reading, not sustained as a defect.**

**Withdrawn: line 1239's "this $n$-form … equal to $c_{\min}-c_p$" as a claim about $\rho^{\mathrm{eff}}_n$.** Read as the display's left-hand side, the sentence is false by exactly $\tfrac29\lvert\kappa_n\rvert$, and the two numerals ($0.7190434$ against $0.7416199$ at $n=12$) are close enough to hide it. Read as the fraction $3\theta_0\frac{n-8}{2(n-2)}$ standing in the display, which is the only reading under which "**both** equal to $c_{\min}-c_p$" is true, and it is true, it is exact. The charitable reading is available and is the intended one. **Withdrawn**, with the note that the sentence would carry no risk if it named the fraction rather than "this $n$-form".

**Withdrawn: the trap as an error.** Located at bullet 1 and consumed by the uniformity proof; the failure is real (denominator's $H_s$ factor at $w=0$, numerator's at $w$); but the direction inflates the denominator, and an inflated denominator understates a lower bound. The entry discloses it in the clause "which is homogeneous so $\lVert H_s\rVert_F<1$ only helps", which is correct as written. **Withdrawn: the trap is present, disclosed, and safe.** Its cost is a constant of up to $45\%$ at $w=1$, and the sharper envelope is on file in [results.md](../results.md).

## 10. What would break it, and what I did to look

**Against the part that is proved.** The falsifier is a unit $H\in T_{W^*}S\cap T_{W^*}\mathcal O^\perp$ at some even $n\ge12$ with $g_\rho(w(H))<0.71979/n$. **No such object exists**, and the reason is that the proof relaxes to $w\ge0$ and computes the infimum in closed form: $\inf_{w\ge0}g_\rho=\frac1n(\tfrac{a_0^2}\kappa+\tfrac1\rho)^{-1/2}$, whose coefficient I showed increases in $n$ from $0.7197978$. I looked by minimising $g_\rho$ analytically rather than by sampling, and by checking both endpoints of $[0,1]$ against the floor ($0.1134680$ and $0.0601131$ against $0.0599825$), the second being the tight one.

**Against the conclusion that is owed.** The object that would settle it is a direction realising $w=\Theta(1)$ with $u\asymp n^{-1/2}$ and $\lVert A''\rVert=\Theta(n)$. At such a direction $f(u)=(c_p+u^2)/(S+au)$ with $a=\Theta(n)$ gives $\Theta(n^{-1})/\Theta(n^{1/2})=\Theta(n^{-3/2})$, below $n^{-1-\beta}$ for every $\beta<\tfrac12$, while branch 2 at the same direction is $\Theta(1)/\Theta(n)=\Theta(n^{-1})$, so the chain would yield $n^{-3/2}$ and no more. **[L147](../findings/second-order.md):1177 already names this object**: "A single mixed direction with $u\asymp n^{-1/2}$, margin $\Theta(1/n)$ and $\lVert A''\rVert=\Theta(n)$ restores $n^{-3/2}$ at every $\beta$." Line 1216's sweep answers the branch-2 half of that objection and is silent on the branch-1 half at the same direction, and that silence **is** the owed joint minimisation. Note that such a direction would not falsify $r_n\gtrsim n^{-1-\beta}$ (every branch is a lower bound on $r(H)$, which line 1233 states correctly), it would only close the chain's route to it. I looked for the object in the entry, in [L146](../findings/second-order.md), [L147](../findings/second-order.md) and [L148](../findings/second-order.md), and in [results.md](../results.md):363; no tensor is exhibited anywhere, and the new constraint $u\le\tfrac{\sqrt2}3w$ from C9 is the first thing on file that bears on whether it can exist.

## Verdict

**`HYPOTHESIS-DEBT`.**

What is proved is proved, and I verified all of it by hand: $\rho^{\mathrm{eff}}_n$'s closed form, its strict monotonicity and its positivity from $n=12$; the margin coefficient against [L27](../findings/nondegeneracy.md)'s ten values and $a_0$ against [L146](../findings/second-order.md)'s supremum; the $\tfrac29$ as an identity on $\Lambda^2\!\otimes\!\Lambda^2$ and a bound on $\mathcal W_n$; the infimum formula and the uniform floor $g_\rho\ge0.7197978/n$ over even $n\ge12$ and $w\in[0,1]$.

**What would have to be proved, exactly.**

1. **The joint minimisation.** $\inf_H\min\big(f(u(H)),\,K g_\rho(w(H)),\,\rho(H)/2\big)$ over $H\in T_{W^*}S\cap T_{W^*}\mathcal O^\perp$ with $\lVert H\rVert_F=1$, where $u$ and $w$ are functions of the same $H$ and $a$ is pinned to the direction rather than left free. The entry says this is owed and it is right. The new input available to it is $u=\tfrac{\sqrt2}3\lVert\Pi_{\Lambda^2\otimes\Lambda^2}H\rVert$, an equality, which line 1230 currently records as the one-sided $u\le w$.
2. **The hypothesis box at line 1247** must gain $\lVert H\rVert_F=1$, $W^*=S^m\times S^m$ with $p=q=m$, and $n=2m$ even, all three used by name in the proof, and all three carried by the entries either side of it.
3. **Two stale numerals** must be reconciled with the boxes standing below them: line 1261's net coefficient $0.416$, which is the coefficient-$1$ reading line 1245 excludes, and line 1233's "attained at $w=0$", which line 1233's own $f'(0)<0$ refutes while leaving the order $\Theta(n^{-1-\beta})$ intact.
4. **Outside the entry:** [results.md](../results.md):363's "branch 2's minimum sits at the homogeneity kink" is false at $n=12$ by a hand-checkable $0.29\%$, in a Gate-2-passed canon entry.

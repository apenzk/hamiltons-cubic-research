# VERIFY v40, L158: the branch threshold, the "$n$-free" headline, the corrected branch-2 minimum, and the extension to $n\approx1800$

**Cold brief, analysis only.** No script was run, no numerical work of any kind; every value below is an exact closed form evaluated by hand from constants the record itself names, and each is marked *reproduced* or *not reproduced*. Log: [agent_logs/verify-L158-v40.log](../agent_logs/verify-L158-v40.log). Sources read: the brief [verification/ROUND_L158.md](ROUND_L158.md) (Forms A and B), [findings/second-order.md](../findings/second-order.md):1272–1329 (L158), :1125–1240 (L146, L147, L148, L149), :883 (L133), [results.md](../results.md):355–369 (L156, L157, L158), [findings/bounds.md](../findings/bounds.md) (L143, L70), [findings/problem.md](../findings/problem.md):146,237,347, [findings/route-a.md](../findings/route-a.md):217.

## Claim table

| # | Claim as written | Verdict |
|---|---|---|
| 1 | "the branch comparison is $n$-free" / "an inequality between absolute constants" (title of both forms; body of Form B) | **REFUTED**, by the entry's own $\lambda(12)$ correction |
| 2 | "branch 1 can bind only if $\sup\lvert P\rvert$ grows past an absolute constant" | **CONFIRMED**, the threshold is $n$-dependent but bounded, $\sup_nS^*=34.71$ |
| 3 | "branch 2 binds at $n=12$" | **CONFIRMED**, $S\le4.162$ against $S^*=18.00$, factor $4.3$ |
| 4 | Threshold "$\approx17$–$19$ at $n=12$" | **REPRODUCED, NOT DERIVED**, I get $18.00$; no derivation on the page, and the width $17$–$19$ is unaccounted |
| 5 | "the threshold is disputed, $21$ against $3.98$" (Form B, and Form A's last paragraph) | **SUPERSEDED TEXT LEFT STANDING**, contradicts claim 4 inside the same entry |
| 6 | "$0.38673$ … is a lower bound on the tube radius" | **BROKEN**, the numeral is $(1-\eta^*)^2\sqrt{c_p+\rho^{\text{eff}}w_0^2}$; branch 2 at $w_0$ is $0.02060$, smaller by $18.8\times$ |
| 7 | Correction factor $1.04329$, corrected minimum $0.38673$ | **REPRODUCED EXACTLY** (five digits, both) |
| 8 | "provably so at every $n$ up to $\approx1800$" | **HYPOTHESIS-DEBT + NOT REPRODUCED**, no argument on the page; the entry's constants give $\approx1.1\times10^3$ |
| 9 | Minimiser $w_0=(n-4)/n$, strict minimum on $[0,1]$ | **CONFIRMED**, $w_0$, $\phi'(w_0)=3/5$ and the elasticity identity all exact |
| 10 | Form A's $w^*=\kappa n^{-1/2}$ vs Form B's $w^*=2\sqrt n/(n-8)$ vs the settled $w_0$ | **THREE MINIMISERS, ALL LIVE**, each reproduces, from a *different* numerator; no form says which is current |
| 11 | Hypotheses of the statement | **ABSENT**, $n=2m$, $n\ge12$, $W^*=S^m\times S^m$, $\ker W^*=0$, $H\perp W^*$, $H\perp T_{W^*}\mathcal O$, $\lVert H\rVert_F=1$ appear in neither form |
| 12 | $\ker W\ne0$ (named witness $W_{\mathbb{CP}^2}$, $\dim\ker W=3$) | **NOT ADDRESSED**, imports say branches 2–3 do not exist there; the entry is silent |
| 13 | Crossover $n=6+2\sqrt7$ | **NOT ADDRESSED, AND IT IS THE DOMAIN EDGE**, $\lambda=2/\sqrt{\lvert\kappa_n\rvert}$ has a pole there |
| 14 | "$52.92$" and the claim that the spread is "one constant" | **NOT REPRODUCED**, the entry's own formula at $\lambda=1.53$ gives $42$–$45$ |
| 15 | Prefactor numerals $1.24$ and $1.1075$ | **REPRODUCED AT SUPERSEDED CONSTANTS**, both are $\lambda=1.53$, $w^*=0.829$ values, kept beside their replacements |

**One line the round can act on:** the surviving conclusion, branch 2 binds at $n=12$, so [I31](../plan.md) is not load-bearing there, is sound and the threshold $18.00$ reproduces exactly; but the title's "$n$-free" is refuted by the entry's own $\lambda(12)$, the canonical [results.md](../results.md) form is pre-correction text, the headline numeral $0.38673$ is not a tube radius, the $n\approx1800$ extension has no argument and does not reproduce ($\approx1135$ from the same constants), and neither form states a single hypothesis.

**Verdict: `GAP`.**

---

## 0. Conventions, fixed once

All at $n=2m$ even, base point $W^*=S^m\times S^m$, $\lVert H\rVert_F=1$, $H\perp W^*$, $H\perp T_{W^*}\mathcal O$. Write $w=\lVert H_r\rVert$ for the weight outside **both** $S^2_0(\mathbb R^m)$ copies ([L149](../findings/second-order.md)).

$$\theta_0(n)=\frac{\sqrt{2(n-1)(n-2)}}n,\quad c_p=\frac{3\theta_0}{n-2},\quad \kappa:=nc_p=3\sqrt{\frac{2(n-1)}{n-2}},\quad A:=a_0n^{-1/2}=\sqrt{\frac2{n-2}}=\frac1{\sqrt{m-1}} .$$

$$\lvert\kappa_n\rvert=9\big(\theta_0(n)-\sqrt{3/2}\big),\quad \lambda=\frac2{\sqrt{\lvert\kappa_n\rvert}},\quad D=\frac{2(n-1)}{n-2},\quad \gamma^*=\frac D4,\quad C^*=2+\frac{2(n-2)}{n-1},\quad J^*=\frac{C^*}{\gamma^*} .$$

$$\rho^{\text{eff}}_n=2\sqrt{3/2}-\theta_0(n)\frac{n+16}{2(n-2)},\quad t=\frac{\lambda\sqrt{c_p+\rho^{\text{eff}}_nw^2}}{2C^*},\quad 1-\eta^*=\frac2{\sqrt{4t+1}+1},\quad K=\frac{\lambda(1-\eta^*)^2}{\sqrt2\,J^*} .$$

**At $n=12$, exactly:** $\theta_0=\tfrac{\sqrt{55}}6=1.2360331$; $\kappa=3\sqrt{2.2}=4.4497190$; $c_p=0.3708099$; $A=1/\sqrt5$; $\lvert\kappa_{12}\rvert=9(\tfrac{\sqrt{55}}6-\sqrt{3/2})=0.1015938$; $\lambda(12)=6.274745$; $\gamma^*=\tfrac{11}{20}$, $C^*=\tfrac{42}{11}$, $J^*=\tfrac{840}{121}=6.9421488$; $\rho^{\text{eff}}_{12}=\sqrt6-\tfrac7{30}\sqrt{55}=0.7190434$; $w_0=\tfrac23$.

Every one of those is a re-derivation, not a transcription: $\lvert\kappa_{12}\rvert$ from $9(\theta_0-\sqrt{3/2})$ in [L149](../findings/second-order.md) and [route-a.md](../findings/route-a.md):217; $C^*,J^*,\gamma^*$ from [L156](../results.md)'s closed forms at $m=6$; $\rho^{\text{eff}}$ checked below against L149's $n$-form.

**$\rho^{\text{eff}}$'s two forms agree.** L149 writes $\rho^{\text{eff}}_n=3\theta_0\frac{n-8}{2(n-2)}-\frac29\lvert\kappa_n\rvert$; L158 writes $2\sqrt{3/2}-\theta_0\frac{n+16}{2(n-2)}$. Substituting $\lvert\kappa_n\rvert=9(\theta_0-\sqrt{3/2})$,
$$\theta_0\Big[\frac{3(n-8)}{2(n-2)}-2\Big]+2\sqrt{3/2}=\theta_0\cdot\frac{-(n+16)}{2(n-2)}+2\sqrt{3/2},$$
identically. **No finding.** The four printed values reproduce: $0.7190434$, $0.8724$, $0.9856$ at $n=12,14,16$ and $1.0727$ at $n=18$, from $\theta_0=1.2360331,\,1.2616800,\,1.2808690,\,1.2957670$ and the multipliers $\tfrac{28}{20},\tfrac{30}{24},\tfrac{32}{28},\tfrac{34}{32}$.

---

## 1. The hypothesis inventory

**A pass without one is not a pass, so here it is in full.**

### 1.1 Hypotheses the statement carries

**Neither form carries any.** Form B is one paragraph of mathematics with no "for $n\ge$", no base point, no norm condition, no orthogonality, no kernel clause. Form A states $\lVert H\rVert_F=1$ only obliquely (inside the envelope argument, "$\lVert H\rVert_{op}\le\lVert H\rVert_F=1$ is legitimate") and states no dimension range anywhere.

### 1.2 Hypotheses the imports carry, each checked against the object it applies to

| Import | Its hypotheses | Does L158's object satisfy them? |
|---|---|---|
| [L149](../findings/second-order.md) (the parametrisation, $\rho^{\text{eff}}$, branch list) | $m\ge6$ i.e. $n\ge12$, stated, with the reason: at $n=10$, $\theta_0=6/5<\sqrt{3/2}$, so $\lvert\kappa_n\rvert<0$ and $\rho^{\text{eff}}$ **has no definition**; $H\perp W^*$; $H\perp T_{W^*}\mathcal O$; $\ker W^*=0$ | Yes at $n\ge12$, and the entry works only at $n\ge12$, but **it never says so**, and Form B is read by anyone at any $n$ |
| [L147](../findings/second-order.md) (branch 1's form $f(u)=(c_p+u^2)/(S+au)$) | Base point $W^*=S^m\times S^m$; $n=2m$; $n\ge12$ "which the imports force through $n^2-12n+8>0$"; **$\ker W^*=0$** | Yes at $W^*$; the kernel clause is where the entry is silent (§5) |
| [L148](../findings/second-order.md) (defect vanishes on the margin summand) | $n=2m$, $m\ge3$; $m\ge5$ for the word "margin" | Satisfied; used correctly (§3.2) |
| [L146](../findings/second-order.md) ($\lVert H\rVert_{op}$ on one $S^2_0$ copy) | Single $h\in S^2_0(\mathbb R^m)$, $\lVert H\rVert_F=1$, $m\ge3$ | Used as the **upper** bound $\lVert H_s\rVert_{op}\le1/\sqrt{m-1}$, which is what L158 needs. L146's own caveat that the attaining witness "loses at $m\ge7$ and the clause has no proof" touches attainment only, so it is **inert here**. *Recorded because a reader could mistake it for a live debt.* |
| [L156](../results.md) ($C$, $J^*$, $\gamma^*$) | $m\ge2$; $W^*=S^m\times S^m$; $W(z)=W^*+zH$ **affine**; $\lVert H\rVert_{op}\le1$ | Affineness and the base point are used and unstated in L158. $\lVert H\rVert_{op}\le1$ holds by $\lVert H\rVert_{op}\le\lVert H\rVert_F=1$, the very inequality L158 invokes for its envelope, so the two uses are consistent |
| [L157](../results.md) ($\eta^*$ fixed point, $t$) | The reach bound holds along the whole segment; $\eta=r/\rho$ | Used; the merge of branch 3 into $\eta^*$ (§3.3) is asserted, and L157's fixed-point construction does support it |
| [L143](../findings/bounds.md) ($S\le1+\sqrt{n-2}$) | Unit norm; $\sup\lvert P\rvert=\sup P$ attained at a critical point | Satisfied; $1+\sqrt{10}=4.162278$ **reproduced** |
| [L70](../findings/bounds.md) ($S\le n-2$) | Criticality | The entry cites "L70 caps $S\le n-2=10$". [bounds.md](../findings/bounds.md):35 makes the same attribution, so the entry is faithful to the record. *In [results.md](../results.md):39 the uniform spectral row is L73, not L70; the $n-2$ cap follows from L70's identity plus $\lambda_{\max}\le1$, so the attribution is loose but not wrong.* |
| [L133](../findings/second-order.md)/[L134](../findings/route-a.md) ($\lvert\kappa_{12}\rvert=0.10159$) | $n\ge12$; balanced orbit | Satisfied. **Reproduced**: $9(\sqrt{55}/6-\sqrt{3/2})=0.1015938$ |

### 1.3 Which hypotheses the written proof actually uses

Every one of $n=2m$, $n\ge12$, $W^*=S^m\times S^m$, $\ker W^*=0$, $H\perp W^*$, $H\perp T_{W^*}\mathcal O$ and $\lVert H\rVert_F=1$ is **used**: $\lVert H\rVert_F=1$ carries the whole envelope argument and the identity $\lVert H_s\rVert_F=\sqrt{1-w^2}$; $n\ge12$ is what makes $\rho^{\text{eff}}$ defined at all; $\ker W^*=0$ is what makes branch 2 exist. None is stated.

**Finding H1, the hypothesis inventory is empty in both forms.** *Locate*: [results.md](../results.md):365–369 in full, and Form A's opening "With Lemma L149's $c_p=\kappa/n$…". *Exhibit*: at $n=10$, $\theta_0=6/5=1.2<\sqrt{3/2}=1.2247449$, so $\lvert\kappa_{10}\rvert=9(1.2-1.2247449)=-0.2227$ is negative, $\lambda=2/\sqrt{\lvert\kappa_n\rvert}$ is imaginary, and every numeral in the entry, $K$, the threshold, $0.38673$, is undefined; Form B nonetheless reads as a statement about all $n$ and asserts "branch 2 binds at $n=12$" with no indication that $n=12$ is the *smallest* case. *Argue the opposite*: the hypotheses are inherited from L149, which Form B names in its first clause ("In Lemma L149's parametrisation"), so a reader who follows the pointer finds them. **That is the most charitable reading and it does not save the entry**: L149's own $m\ge6$ clause is a mid-block parenthesis, and [ROUND_L147](ROUND_L147.md) already forced L147 to write its four hypotheses out for exactly this reason. **Finding stands.**

---

## 2. Question 1, is the threshold a number or a range, and is it derived?

### 2.1 What is on the page

Both. Form A says, in a boxed block, "**THE THRESHOLD IS PINNED AT $\approx17$–$19$ AT $n=12$, AND THE ENTRY'S 'NOT PINNED' IS REFUTED**". Form A's **closing paragraph** then says "**THE DISAGREEMENT AS THE REVIEWERS LEFT IT.** The reviewers differ on the threshold's value … near $21$ … near $3.98$–$4.44$ … *The gap is whether $2J^*$ enters the branch-2 prefactor $K$, and settling it is the next task on this item.*", a task the entry settles four paragraphs earlier ("**SETTLED** … **$J$ divides $K$**"). Form B carries only the disagreement: "The threshold's value is disputed between the two audits, $21$ against $3.98$".

### 2.2 The threshold reproduces, at $18.00$

The threshold is not derived anywhere on the page. It **is** reproducible from the entry's own named constants, and I did so by hand. Branch 1's stated infimum is $\kappa/(nS)$; branch 2's, at $w_0$ where the envelope equals $1$, is $KN(w_0)/n$ with $N(w)=\sqrt{c_p+\rho^{\text{eff}}w^2}$. Branch 1 binds iff its infimum is the smaller:

$$\frac\kappa{nS}<\frac{K\,N(w_0)}n\iff S>S^*:=\frac\kappa{K\,N(w_0)} .$$

At $n=12$: $N(2/3)=\sqrt{0.3708099+0.7190434\cdot\tfrac49}=\sqrt{0.6903849}=0.8308930$; $t=\lambda N/(2C^*)=6.274745\cdot0.8308930/7.6363636=0.6826915$; $\sqrt{4t+1}=1.9314673$; $(1-\eta^*)^2=(2/2.9314673)^2=0.4654738$; $K=6.274745\cdot0.4654738/(\sqrt2\cdot6.9421488)=2.920684/9.817681=0.2974923$; $K N=0.2471935$;

$$\boxed{S^*(12)=\frac{4.4497190}{0.2471935}=18.00} .$$

In [r712](../reviews/REVIEW_r712.md)'s variable $s=S/\theta_0$: $18.00/1.2360331=14.56$, which is the entry's "$s^*\approx15$". **Reproduced.** The comparands also reproduce: $s\le3.37$ is $4.162278/1.2360331=3.3673$; the $3.1$–$3.6$ band is $[3.98,4.44]/1.2360331=[3.22,3.59]$.

**Finding T1, the width "$17$–$19$" is unaccounted.** *Locate*: "THE THRESHOLD IS PINNED AT $\approx17$–$19$ AT $n=12$". *Exhibit*: one evaluation at the entry's own constants gives a **point**, $18.00$. Widening $J^*$ across its in-scope range $[6.9421,8)$, which the entry names, moves $S^*$ to $[18.00,20.74)$, not $[17,19]$; opening the $\tfrac29$ debt moves it to $18.10$. No named quantity produces a lower endpoint of $17$. *Argue the opposite*: "$\approx17$–$19$" may be two reviewers' independently rounded figures reported as a band rather than a derived interval. That reading is available and is the likeliest truth, **so the finding is not that the band is wrong, but that it is an unlabelled report of two roundings where the entry's own constants give a single number.** Recorded as a presentation defect.

**Finding T2, "$52.92$", and "the spread is one constant", do not reproduce.** *Locate*: "*The spread between the two audits, $17$–$19$ against $52.92$, is one constant:* $\lambda=2/\sqrt{\lvert\kappa_n\rvert}$ was evaluated at the $n\to\infty$ value". *Exhibit*: rerun the entry's own formula changing **only** $\lambda$, from $6.274745$ to $1.5316$. Then $t=1.5316\cdot0.8308930/7.6363636=0.166655$, $\sqrt{4t+1}=1.290952$, $(1-\eta^*)^2=0.762168$, $K=1.5316\cdot0.762168/9.817681=0.118906$, $KN=0.098796$, $S^*=45.04$. With the un-repaired coefficient $1$ on $w^2$ instead, $S^*=42.3$. **Neither is $52.92$**; $\lambda$ alone moves the threshold by a factor $2.50$, where $52.92/18.00=2.94$ is wanted. *Argue the opposite*: the $52.92$ audit will also have differed in envelope and minimiser, so $\lambda$ may be the *largest* contributor without being the only one. **That is exactly the point**: the entry writes "is one constant", singular, and the residual factor $1.18$ is unexplained. Finding stands as *the diagnosis is directionally right and quantitatively unreproduced*.

### 2.3 The headline "$n$-free" is refuted by the entry's own body

**Finding T3, the title's mechanism is false, and the entry says so without withdrawing the title.**

*Locate*: the title of both forms, "the branch comparison is $n$-free"; Form B's body, "which branch binds is an inequality between absolute constants"; and the display
$$\frac{\inf_w\text{branch }1}{\inf_w\text{branch }2}=\frac{\sqrt{\kappa(1+\kappa)}}{S\cdot K} .$$

*Exhibit, in closed form.* Under a denominator envelope $A+w$, branch 2's stationary point is $w^*=c_p/A$ and its value $K\sqrt{c_p}/(n\sqrt{A^2+c_p})$, so the ratio is
$$\frac{\kappa/(nS)}{K\sqrt{c_p}\big/\big(n\sqrt{A^2+c_p}\big)}=\frac{\sqrt{\kappa\,(nA^2+\kappa)}}{S\,K}\ \xrightarrow{\ nA^2=1\ }\ \frac{\sqrt{\kappa(1+\kappa)}}{S\,K}.$$
**The display therefore holds only at $A=n^{-1/2}$**, the reading the same entry refutes three paragraphs later ("the repair is the record's $\lVert H_s\rVert_{op}\le1/\sqrt{m-1}$"). At the repaired $A=\sqrt{2/(n-2)}$, $nA^2=2n/(n-2)=2.4$ at $n=12$, so the bracket is $\sqrt{\kappa(2.4+\kappa)}$ and is $n$-dependent; and at the entry's own settled envelope $\min(A\sqrt{1-w^2}+w,1)$ the infimum sits at $w_0=(n-4)/n$, manifestly $n$-dependent. Independently, $\lambda(12)/\lambda(\infty)=6.2747/1.5316=4.10$, which the entry itself calls "**the largest $n$-dependence in a ratio this entry's title calls $n$-free**". Evaluating $S^*$ across the range: $S^*(12)=18.00$; $S^*(100)=34.46$; $S^*(\infty)=34.71$; and as $n\downarrow6+2\sqrt7$, $\lambda\to\infty$ while $\lambda(1-\eta^*)^2\to2C^*/N$, giving $S^*\to\kappa/(\sqrt2\gamma^*)=5.70$. **The "absolute constant" varies over roughly $[5.7,34.7]$, a factor $6$.**

*Argue the opposite.* The useful clause survives this: since $S^*(n)\le34.71$ for every $n$, "branch 1 can bind only if $\sup\lvert P\rvert$ grows past an absolute constant" is **true**, with the constant $34.71$. An $n$-dependent threshold that is *bounded* still supports the conclusion the entry wants. **So claim 2 in the table is CONFIRMED and claim 1 is REFUTED**: what fails is the stated mechanism and the title, not the consequence.

*Verification detail for $S^*(100)$, exact:* $\theta_0=\sqrt{19404}/100=1.3929825$, $\lvert\kappa\rvert=1.5141387$, $\lambda=1.6254063$, $\kappa=3\sqrt{2.0204082}=4.2642286$, $c_p=0.0426423$, $w_0=0.96$, $\rho^{\text{eff}}=2.4494897-1.3929825\cdot\tfrac{116}{196}=1.6251511$, $N=1.2411211$, $\gamma^*=\tfrac{99}{196}$, $C^*=2+\tfrac{196}{99}=3.9797980$, $J^*=7.8797980$, $t=0.2534435$, $(1-\eta^*)^2=0.6836165$, $K=0.0997073$, $S^*=34.46$.

---

## 3. Quantifier order and scope

### 3.1 The infimum identity is sound, and the comparison at each branch's own minimiser is correct

$\inf_w\min(f,g)=\min(\inf_wf,\inf_wg)$ is an identity. The radius bound is $r\ge\inf_w\min(\text{branches})$, so "which branch binds" is precisely "which separately-taken infimum is smaller". The brief's worry (a comparison made branch-by-branch at each branch's own minimiser, at different $w$), **is the right procedure here, not an error**: branch 1's infimum sits at $w=0$ and branch 2's at $w_0=\tfrac23$, and the min of the two is still the min of the pointwise min. **No finding.**

### 3.2 The L148 caveat is correctly withdrawn but only asserted

The entry writes "*the entry's caveat that L148 undermines this is withdrawn, L148 changes where the infimum is attained, not its value*". L148 makes branch 2 absent at $w=0$; branch 2's infimum sits at $w_0=\tfrac23>0$, so removing the point $w=0$ from branch 2's domain leaves $\inf_wg$ unchanged. The withdrawal is **correct**, and it is a one-clause assertion with no argument. *Recorded, not charged.*

### 3.3 Branch 3

"Dropping branch 3 is legitimate: L157's $\eta^*$ has already merged it into the prefactor." [L157](../results.md) does construct $\eta^*$ as the largest solution of the self-consistency condition $r\le\sqrt c/\sup_{\lvert s\rvert\le r}\lVert A''(s)\rVert$, which is the validity constraint, so the merge is supported at source. **No finding.**

### 3.4 Branch 1's infimum is overstated, and the entry says so and then uses it anyway

**Finding Q1.** *Locate*: "*Branch 1 is not $(c_p+w^2)/S$*: the chain's own form is $f(u)=(c_p+u^2)/(S+au)$ with $f'(0)<0$ …, so its infimum is **strictly below** $\kappa/(nS)$ and does not sit at $u=0$", followed, in the same entry, by the display and the threshold, both of which take $\inf_w\text{branch }1=\kappa/(nS)$.

*Exhibit*: $f'(0)=-ac_p/S^2<0$ for any $a>0$, and [L147](../findings/second-order.md) gives the interior value $f(u^*)=2u^*/a$ with $u^*=(\sqrt{S^2+a^2c_p}-S)/a$, strictly below $c_p/S$. Since $S^*=\kappa/(KN)$ was obtained by equating $\kappa/(nS)$ to $KN/n$, using an **overstated** $\inf_w$ branch 1 makes branch 1 look less binding, i.e. the error runs **toward** the entry's own conclusion.

*Argue the opposite*: [second-order.md](../findings/second-order.md):1270 prices this coupling at "about $5\%$", and $5\%$ against a factor $4.3$ margin at $n=12$ ($S\le4.162$ vs $S^*=18.00$) cannot reverse the verdict. **The finding is therefore not fatal at $n=12$**, but $a$ is pinned nowhere in the entry, so the page does not license the $5\%$, and at the far end of the extension (§4) the margin is by construction zero, where any overstatement matters. Finding stands as a **GAP**, not a refutation.

---

## 4. Question 2, does "branch 2 binds" survive, and where does the extension stop?

### 4.1 At $n=12$ it survives, and the correction strengthens it

$S\le1+\sqrt{10}=4.162278$ ([L143](../findings/bounds.md)) and $S\le10$ ([L70](../findings/bounds.md)), both far below $S^*=18.00$. Lowering branch 2 by the $\rho^{\text{eff}}$ correction lowers $\inf_wg$, hence lowers $S^*$, *no*: it lowers $KN$, which **raises** $S^*=\kappa/(KN)$, making branch 2 bind over a wider range of $S$. The entry's "the repair strengthens it" is **correct**, and the direction is worth stating because the sign is easy to get wrong: with the un-repaired coefficient $1$, $N=0.9029144$, $t=0.7419318$, $(1-\eta^*)^2=0.4468399$, $K=0.2855945$, $KN=0.2578551$, $S^*=17.256$; the repair moves it to $18.00$. **Claim 3: CONFIRMED.**

### 4.2 The correction factor $1.04329$ reproduces exactly

$$\frac{F_1}{F_\rho}=\frac{N_1}{N_\rho}\Big(\frac{s_\rho+1}{s_1+1}\Big)^2,\qquad s=\sqrt{4t+1}.$$
$N_1/N_\rho=0.9029144/0.8308930=1.086681$ (the entry's "$8.667\%$ inflation of $t$", reproduced: $8.668\%$). $t_\rho=0.6826915$, $s_\rho=1.9314673$; $t_1=1.086681\,t_\rho=0.7418705$, $s_1=1.9918266$; $(2.9314673/2.9918266)^2=0.9600802$. Product $=\mathbf{1.043297}$. **Reproduced to five digits.** And the elasticity claim $\tfrac1{s}\Rightarrow4.33\%$: $8.668\%\times0.5177=4.487\%$, against the entry's $4.33\%$, the small residual is the second-order term the elasticity drops, and $1-1/1.043297=4.15\%$, so the entry's $4.33\%$ sits between the two readings. *No charge; noted.*

### 4.3 The numeral $0.38673$ is not a tube radius

**Finding N1, the headline branch-2 numeral is a profile value, mislabelled.**

*Locate*: "**THE BRANCH-2 NUMERAL BELOW IS REFUTED AND OVERSTATED, AND IT IS A LOWER BOUND ON THE TUBE RADIUS** … the corrected minimum is $0.38673$."

*Exhibit, exactly.* $(1-\eta^*)^2\,N(w_0)=0.4654738\times0.8308930=\mathbf{0.386757}$, and with the un-repaired coefficient, $0.4468399\times0.9029144=\mathbf{0.403471}$. **Both recorded numerals are $(1-\eta^*)^2\sqrt{c_p+\text{coef}\cdot w_0^2}$ to five digits**, the branch-2 expression with the prefactor $\lambda/(\sqrt2J^*)$ and the factor $1/n$ both **absent**. Branch 2 itself, from the entry's own display, is
$$\frac{\lambda(1-\eta^*)^2}{\sqrt2\,J^*}\cdot\frac{\sqrt{c_p+\rho^{\text{eff}}w^2}}{n\min(\cdot)}\Big|_{w_0}=\frac{0.2974923\times0.8308930}{12}=\mathbf{0.0205995},$$
smaller by the factor $\sqrt2J^*n/\lambda=18.77$. The same convention explains every other branch-2 numeral in the entry: $0.38468$ is $(1-\eta^*)^2N$ at $w=0.5528$ with coefficient $1$ ($0.4677290\times0.8224345=0.384668$, **reproduced**); the "$27.8\%$ improvement over the endpoint at $\lambda(12)$" is $0.403471$ against $r714$'s endpoint $0.4568139/1.4472=0.3156535$, giving $27.82\%$ (**reproduced**); the "$19.4\%$ at the asymptotic $\lambda$" is $0.675134$ against $0.5654605$, giving $19.40\%$ (**reproduced**).

*Argue the opposite.* The entry may intend "$0.38673$" as the minimum of the $w$-**profile** (the only part that moves with $w$) and the sentence "it is a lower bound on the tube radius" as loose shorthand for "it enters one". **That reading is available for the number and not for the sentence**: [L149](../findings/second-order.md) issues a standing warning on precisely this hazard, "*THE NUMERAL PRICES $g_\rho$, NOT BRANCH 2* … the numeral does not, and must not be read as a branch-2 floor", and L158 then records a numeral that prices neither $g_\rho$ ($n g_\rho\ge0.71979$) nor branch 2 ($n\cdot0.0205995=0.2472$), and labels it a tube-radius lower bound in bold. **Finding stands. This is the single most misleading line in the entry.**

### 4.4 The minimiser $w_0=(n-4)/n$ is correct and the strict-minimum argument checks out

Solving $A\sqrt{1-w^2}+w=1$ with $w\ne1$: $A^2(1+w)=1-w$, so $w_0=\frac{1-A^2}{1+A^2}$; with $A^2=2/(n-2)$ this is $\frac{n-4}n$, **exact**, $\tfrac23$ at $n=12$. $\phi'(w)=1-Aw/\sqrt{1-w^2}$; at $w_0=\tfrac23$, $A=1/\sqrt5$: $Aw/\sqrt{1-w^2}=\tfrac{2/(3\sqrt5)}{\sqrt5/3}=\tfrac25$, so $\phi'(w_0)=\tfrac35$, **exact, as the entry says**.

Above $w_0$ the envelope is $1$ and the entry's elasticity identity governs. I re-derived it: with $u=\sqrt{4t+1}$, $t\propto N$,
$$\frac{\mathrm d\log\big(K(w)N(w)\big)}{\mathrm d\log N}=1-2\cdot\frac{u-1}{2u}=\frac1u=\frac1{\sqrt{4t+1}}\in(0,1),$$
**exactly the displayed identity, and it holds for every $\lambda,J,\gamma$ as claimed.** So $KN$ rises with $w$ above $w_0$. Below $w_0$, $\tfrac{\mathrm d}{\mathrm dw}\log N=\frac{\rho w}{2(c_p+\rho w^2)}\le\frac{\sqrt\rho}{4\sqrt{c_p}}=0.34813$ by AM–GM, so $\tfrac{\mathrm d}{\mathrm dw}\log(KN)\le0.5177\times0.34813=0.1802$, against $\phi'/\phi\ge\phi'(w_0)=0.6$. **Strict minimum at $w_0$: confirmed.**

*One numeral I could not reproduce:* the entry's uniform bound "$\tfrac1s\tfrac{N'}N\le\tfrac{\sqrt\rho}{2\sqrt{c_p}\,s_{\min}}=0.4019$". My AM–GM gives $0.34813$ for $\tfrac{\mathrm d\log N}{\mathrm dw}$ and $0.1802$ once the $1/u$ elasticity is included; no reading of $s_{\min}$ I tried returns $0.4019$. **The conclusion is unaffected**, every candidate is below $0.6$, so this is a recording defect, not a break.

### 4.5 The extension to $n\approx1800$

**Finding E1, no argument on the page, and the figure does not reproduce.**

*Locate*: "**branch 2 binds, and provably so at every $n$ up to $\approx1800$**". In Form A this is one clause with an attribution stripped by the brief; in the source the attribution is [r713](../reviews/REVIEW_r713.md). **Form B omits the claim entirely.** No derivation, no criterion, no statement of which bound on $S$ is being used, appears in either form.

*Exhibit.* The guarantee is $1+\sqrt{n-2}<S^*(n)$. $S^*$ is increasing and bounded: $S^*(12)=18.00$, $S^*(100)=34.46$, and at the limit $\theta_0\to\sqrt2$, $\lvert\kappa_n\rvert\to9(\sqrt2-\sqrt{3/2})=1.7052183$, $\lambda\to1.5316$, $\kappa\to3\sqrt2$, $w_0\to1$, $\rho^{\text{eff}}\to\sqrt6-\tfrac{\sqrt2}2=1.7423829$, $N\to1.3199935$, $C^*\to4$, $J^*\to8$, $t\to0.2527136$, $(1-\eta^*)^2\to0.6841822$, $K\to0.0926135$, so
$$S^*(\infty)=\frac{3\sqrt2}{0.0926135\times1.3199935}=34.71 .$$
Checked at $n=1138$ in full ($\theta_0=1.4123490$, $\lambda=1.5391690$, $\rho^{\text{eff}}=1.7321260$, $N=1.3128970$, $J^*=7.9894520$, $K=0.0932011$): $S^*=34.680$ against $1+\sqrt{1136}=34.705$. **The two cross at $n\approx1135$, not $1800.**

*Argue the opposite.* Three readings that could raise the crossing were tried and none reaches $1800$. (i) If $2J^*$ rather than $J^*$ divides $K$ (the very dispute the entry settles the other way) then $K$ halves, $S^*(\infty)=69.4$ and the crossing goes to $n\approx4700$: overshoots, and contradicts the entry's own settlement. (ii) If $J^*$ is read at the out-of-scope $m=2$ endpoint $\tfrac{40}9$, $S^*(\infty)=19.3$ and the crossing falls to $n\approx340$. (iii) If [L70](../findings/bounds.md)'s $S\le n-2$ is the bound used, the crossing is at $n\approx36$. **To land on $1800$ needs $S^*\approx43.4$, and no combination of the constants the entry names produces it.** Finding stands, doubly: as `HYPOTHESIS-DEBT` (the argument is off-page) and as a numeral that does not reproduce.

*And the honest positive statement the record can make instead:* the **conditional** claim survives untouched. Since $S^*(n)\ge5.70$ for every admissible $n$ and $\to34.71$, any dimension-free bound $S\le C$ with $C<5.70$ makes branch 2 bind at **every** $n$, which is exactly the entry's "if I31 succeeds … branch 2 alone governs the radius at every $n$". That clause needs no extension argument at all.

---

## 5. The edges of every range

| Edge | What the entry asserts | Verdict |
|---|---|---|
| $w=0$ | Branch 2 absent by [L148](../findings/second-order.md); branch 1 present and $=c_p/S$ | Correctly handled (§3.2) |
| $w=1$ | Envelope "equal to exactly $1$ at $w=1$" | **Correct**: $\lVert H_s\rVert_F=\sqrt{1-w^2}=0$, so $H=H_r$ and $\lVert H\rVert_{op}\le\lVert H\rVert_F=1$ |
| Smallest admissible $n$ | Nothing | **Absent.** It is $n=12$, forced by L149's $m\ge6$ |
| Crossover $n=6+2\sqrt7$ | Nothing | **Absent, and it is the domain edge**, see below |
| $\ker W\ne0$ | Nothing | **Absent**, see below |

**Finding E2, the crossover $n=6+2\sqrt7$ is where the entry's largest constant has a pole, and neither form mentions it.**

*Locate*: the entry's own "$\lambda=2/\sqrt{\lvert\kappa_n\rvert}$ … $\lambda(12)=6.275$", with no statement of $\lambda$'s $n$-dependence anywhere in either form.

*Exhibit.* [L149](../findings/second-order.md) fixes $\lvert\kappa_n\rvert=9(\theta_0(n)-\sqrt{3/2})$, and [graded-half.md](../findings/graded-half.md):138 fixes $\theta_0(n)^2\ge\tfrac32\iff n^2-12n+8\ge0$, larger root $6+2\sqrt7=11.2915$. So $\lvert\kappa_n\rvert\downarrow0$ and $\lambda\to\infty$ **as $n$ decreases to the crossover**, and $n=12$ sits $0.71$ above it. This is the entire reason $\lambda(12)=6.2747$ is four times $\lambda(\infty)=1.5316$: the entry's smallest admissible dimension is the one nearest a singularity of its own largest constant. It is also the reason the entry's threshold is $18.00$ at $n=12$ and $34.71$ asymptotically. **Neither form says that $\lambda$ depends on $n$ at all**, and Form B carries the $n\to\infty$-derived "$21$ against $3.98$" as its live figure.

*Argue the opposite*: $\lambda$'s finiteness is guaranteed by $n\ge12$, which the imports supply, so no statement in the entry is *false* on account of the pole. **Correct, the charge is not falsity but that the entry's headline is "the comparison is $n$-free" while its dominant constant is the one with a pole at the boundary of its own domain.** Finding stands as a scope defect.

**Finding E3, the named kernel witness is not addressed.**

*Locate*: nothing in either form. *Exhibit*: [L147](../findings/second-order.md)'s hypothesis block states "$\ker W^*=0$ … The kernel one has a named witness: $W_{\mathbb{CP}^2}$ is Morse–Bott nondegenerate with $\dim\ker W=3$, so $g_n$, $\rho$, $M$ and branches 2–3 **do not exist there**"; [L149](../findings/second-order.md) repeats it with the gap $g_n=\sqrt{2(n-2)}/(n\sqrt{n-1})$; [L133](../findings/second-order.md) flags the same scenario as untouched. Since $\rho=\gamma g_n/\lVert H\rVert_{op}$ and branch 2 is built from $\rho$, "branch 2 binds" has **no referent** at a kernel point, and Form B (an unquantified paragraph about "the radius"), offers a reader nothing to stop them applying it at padded $W_{\mathbb{CP}^2}$, which [problem.md](../findings/problem.md):237 records as sitting in $\mathcal W_n$ at $P=\sqrt{3/2}$ for **every** $n$. *Argue the opposite*: L148 is the one link that survives a kernel, and L158 does not depend on L148 for its conclusion, so nothing L158 says is wrong *at $W^*$*. **Correct, and the finding is about the statement's scope, which is empty.** Finding stands.

---

## 6. Two numerals priced twice, and two prefactors left at superseded constants

**Finding C1, the $w^2$ coefficient is priced at $0.74162$ and at $0.71904$ in adjacent paragraphs.** *Locate*: "$c(H)\ge c_p+3\theta_0\tfrac{m-4}{2(m-1)}w^2$ with coefficient $0.74162$ at $n=12$ … reaching $1$ only at $n=16$" against "$\rho^{\text{eff}}_n$ … is $0.7190434<1$ at $n=12$ … then $1.0727$ at $n=18$, from which the coefficient $1$ is valid". *Exhibit*: $3\theta_0(12)\cdot\tfrac4{20}=0.7416199$ and $0.7416199-\tfrac29(0.1015938)=0.7190439$, the two differ by **exactly** the $\tfrac29$ penalty. The entry presents both as corrections to the same numerator, and consequently gives two different answers to "where does the defect stop": "reaching $1$ only at $n=16$" (margin) and "confined to $n\in\{12,14,16\}$" (penalised), while [L149](../findings/second-order.md) says a third thing, "unsafe exactly on $n\in\{12,14\}$". *Argue the opposite*: these are genuinely two quantities (the margin coefficient and the penalised one) and the branch-2 numerator legitimately carries the penalised $\rho^{\text{eff}}$. **True, and it is why this is a presentation finding and not a break**, but the entry files the margin repair as "**TWO DEFECTS IN L149 NEITHER PARTY RAISED**" when $\rho^{\text{eff}}$ has already absorbed it, so a reader cannot tell which number belongs in $N(w)$. Compounding it, L149's own line "*The $m$-form … and this $n$-form are the same quantity*" is **false**: they differ by $\tfrac29\lvert\kappa_n\rvert$. Finding stands, and it is an L149 defect that L158 inherits.

**Finding C2, the $\tfrac29$ proviso reproduces at the wrong alternative.** *Locate*: "L149's open $\tfrac29$ debt moves the factor to $1.0391$ if it resolves the other way." *Exhibit*: with the penalty dropped entirely ($\rho=0.7416199$), $N=0.8369109$, $t=0.6876586$, $(1-\eta^*)^2=0.4638307$, $F_\rho=0.3883000$, and $0.4034710/0.3883000=1.03907$, **$1.0391$ reproduced**. But L149's stated alternative is not "penalty dropped": it is "**At coefficient $1$ the constant reads $0.689771$**", which gives $N=0.8230280$, $(1-\eta^*)^2=0.4675670$, $F_\rho=0.3848190$, and a factor $1.04847$. *Argue the opposite*: "resolves the other way" is ambiguous and could mean either. **It could, which is the finding: two readings, two factors, and the entry names neither reading.** Minor.

**Finding C3, superseded prefactor values left standing beside their replacements.** *Locate*: "*The prefactor $1.24$ is its $w=0$ value … at the minimiser it is $1.1075$*", and (in the source, dropped from Form A) "$\lambda(1-\eta^*)^2$ ranges over $[1.24,1.53]$". *Exhibit, exactly.* At $\lambda=1.53$, $w=0$: $N=\sqrt{c_p}=0.6089416$, $t=0.1220068$, $(1-\eta^*)^2=0.8117326$, $\lambda(1-\eta^*)^2=1.24195$, **$1.24$ reproduces at the superseded $\lambda$**. At $\lambda=1.53$, $w=0.82916$ (the superseded minimiser): $N=1.0287420$, $t=0.2061156$, $(1-\eta^*)^2=0.7238612$, product $=1.10751$, **$1.1075$ reproduces at the superseded $\lambda$ and the superseded $w^*$**. At the entry's own $\lambda(12)=6.2747$ and $w_0=\tfrac23$, the quantity is $6.2747\times0.4654738=2.9207$, outside the stated range by a factor $1.9$. *Argue the opposite*: these sentences may be describing what the *prior* audits computed rather than asserting current values. **The text gives no such marking**, they read as statements of fact in the same voice as the corrections. Finding stands; this is exactly the pathology the brief warns of.

---

## 7. The two forms

**Finding F1, Form B is pre-correction text and contradicts Form A.** Form B (= [results.md](../results.md):365–369, the canonical statement) contains **none** of: $\lambda(12)=6.275$; the threshold $\approx17$–$19$; $J^*$'s in-scope range; the minimiser $w_0=(n-4)/n$; the $\rho^{\text{eff}}$ repair; the corrected minimum $0.38673$; the $s^*\approx15$ reformulation; the extension to $n\approx1800$. It states the threshold as **still disputed**, "$21$ against $3.98$", which Form A declares refuted in bold. *Argue the opposite*: a canonical statement is meant to be short and may defer detail to the findings entry it cites. **It may defer detail; it may not assert as open a question the entry it cites declares closed.** Finding stands, and it is the round's first: **downstream reads Form B.**

**Finding F2, Form B's minimiser is a fourth value, and its own sentence mixes two numerators.** *Locate*: "*its stationary point $w^*=2\sqrt n/(n-8)$ … so the infimum is not the interior value $n^{-1}\sqrt{\kappa/(1+\kappa)}$*". *Exhibit.* Minimising $\sqrt{c_p+\text{coef}\cdot w^2}/(A+w)$ gives $w^*=c_p/(\text{coef}\cdot A)$. With $\text{coef}=3\theta_0\frac{n-8}{2(n-2)}$ (the **un-penalised margin**) and $A=n^{-1/2}$ (L149's *literal* reading), $w^*=\frac{2n}{(n-8)\sqrt n}=\frac{2\sqrt n}{n-8}$, **exact**. With $\text{coef}=1$ and $A=n^{-1/2}$, $w^*=\kappa n^{-1/2}$ (Form A's value, $1.2845$ at $n=12$) and the interior value is $n^{-1}\sqrt{\kappa/(1+\kappa)}$, **also exact**. **Form B therefore takes its minimiser from one numerator and its interior value from another, in one sentence.** The interior values differ: $\sqrt{\kappa/(1+\kappa)}=0.90361$ against $\sqrt{\rho\kappa/(\rho+\kappa)}=0.79726$ at $\rho=0.74162$, a $13\%$ gap. *Argue the opposite*: both are lower bounds on the same infimum, and the sentence's operative content ("which stands only as a lower bound"), is **true** for either, since an unconstrained stationary value bounds the constrained infimum from below when the stationary point falls outside $[0,1]$. **That defence holds for the logic and not for the arithmetic.** Finding stands, downgraded to a mismatched-constants defect.

*Withdrawn candidate.* Form B's "and above the saturation kink besides" is false from $n=20$ on ($w^*=0.7454$ against $w_0=0.8$), but the clause is grammatically attached to "for every $n<16$", where it is true ($3.464$ vs $\tfrac23$ at $n=12$; $1.247$ vs $0.714$ at $n=14$). **Withdrawn: a charitable reading of the scope survives.**

*Withdrawn candidate.* Form A's $w^*=3\sqrt{n-1}/n=0.82916$ and Form A's "$Bc/A=0.82916$ … unreachable and stationary for the wrong function" look like a flat contradiction. They are the same number reached twice: $c_p/A=\frac{3\theta_0}{n-2}\sqrt{\frac{n-2}2}=\frac{3\sqrt{n-1}}n$, and with $B=1/g_n=n^2c_p/6$, $c=c_p$, $A=n\sqrt{n-1}/(n-2)$ (which is $3.9799$ at $n=12$, [r711](../reviews/REVIEW_r711.md)'s "$A=3.980$"), $Bc/A=\kappa^2/(6A)=\frac{3\sqrt{n-1}}n$ identically. **So the entry is refuting its own earlier repair rather than contradicting itself**, the value is the affine-envelope stationary point, superseded by the $\min$-envelope kink $w_0$. **Withdrawn**, with the note that $A$, $B$ and $c$ are used before they are defined and $A=n\sqrt{n-1}/(n-2)$ is nowhere derived on the page.

*Withdrawn candidate.* Form A as dispatched drops the source's closing paragraph ("**A $w$-dependence the entry ignored**") and the Gate-2 line for $0.38673$, against a brief promising "mathematics verbatim". **Withdrawn as a briefing artefact rather than a defect in the entry**, though the dropped paragraph is the one carrying the superseded $[1.24,1.53]$ range of Finding C3.

---

## 8. The gap between what is proven and what is consumed

[L149](../findings/second-order.md) consumes L158's $K$ directly: "Branch 2 is $K\,g_\rho$ with $K=\lambda(1-\eta^*)^2/(\sqrt2J)$ from L158, and **$K<1$ by better than an order of magnitude**."

**Finding D1.** At $n=12$, $K=0.29749$, a factor $3.36$, not an order of magnitude. The gloss becomes true only asymptotically ($K\to0.09261$, factor $10.8$). *Exhibit*: the numbers of §2.2. *Argue the opposite*: L149's sentence is about the order $\Omega(n^{-1})$ surviving, for which any positive constant suffices, so nothing downstream breaks. **Correct, the order survives; the parenthetical is wrong at the only dimension the record evaluates.** Recorded.

**A second mismatch, inert.** L149's $g_\rho$ uses the affine denominator $a_0n^{1/2}+nw$ and proves $ng_\rho\ge0.71979$ (**reproduced**: $\sqrt{\rho\kappa/(\rho a_0^2+\kappa)}=\sqrt{3.199440/6.175351}=0.719785$ at $\rho=0.7190434$, $a_0^2=2.4$). L158 uses the tighter $\min(A\sqrt{1-w^2}+w,1)$, under which $ng_\rho=N(w_0)=0.830893$ at the minimum. The tighter envelope is a **smaller** upper bound on $\lVert H\rVert_{op}$, hence a **larger** radius, so L149's floor is the conservative one and the two are consistent. **No finding.**

---

## 9. What would falsify the statement, and what I did to look for it

**The object that would break it** is a direction $H$ at $W^*=S^{6}\times S^{6}$, unit Frobenius norm, orthogonal to $W^*$ and to $T_{W^*}\mathcal O$, at which branch 1 falls below branch 2, equivalently, a proof that $\sup\lvert P\rvert>18.00$ at $n=12$. **The parameter value that would break it** is any $w\in[0,1]$ at which $K(w)\sqrt{c_p+\rho^{\text{eff}}w^2}\big/\min(A\sqrt{1-w^2}+w,1)$ falls below its value at $w_0=\tfrac23$.

**What I did.** For the first: read [L143](../findings/bounds.md) and [L70](../findings/bounds.md) at source; both are **upper** bounds, $4.162$ and $10$, so no object in the record can push $S$ above $18.00$ and none could, as the entry itself correctly says, an upper bound on $S$ can only show branch 1 **fails** to bind. The falsifier would have to be a **lower** bound on $\sup\lvert P\rvert$ exceeding $18.00$, and the record's only lower bound is $S\ge\theta_0(12)=1.236$. For the second: I derived the stationarity condition in closed form, $\frac{w}{\sqrt{1-w^2}}=\frac{c_p}{A(1+c_p)}$ for the full envelope and $w^*=c_p/(\text{coef}\cdot A)$ for the affine one, checked $\phi'(w_0)=\tfrac35$ exactly, bounded $\mathrm d\log N/\mathrm dw\le\sqrt\rho/(4\sqrt{c_p})=0.348$ by AM–GM and $\mathrm d\log(KN)/\mathrm d\log N=1/\sqrt{4t+1}=0.518$ by the entry's own identity, re-derived; the product $0.180$ never approaches $0.6$. **No falsifier exists on $[0,1]$ at $n=12$.**

**Where a falsifier does exist** is at the top of the range: at $n\gtrsim1135$ the record's own bound $S\le1+\sqrt{n-2}$ exceeds $S^*(n)$, so "branch 2 binds" ceases to be certified. The entry places that point at $\approx1800$ and gives no argument for either figure.

---

## Verdict

**`GAP`.**

The surviving mathematics is sound and I confirm it: $\inf_w\min=\min(\inf_w,\inf_w)$ is used correctly; the minimiser $w_0=(n-4)/n$, the slope $\phi'(w_0)=\tfrac35$ and the elasticity identity $\mathrm d\log(KN)/\mathrm d\log s=1/\sqrt{4t+1}$ are all exact; the $\rho^{\text{eff}}$ repair, its factor $1.04329$ and its direction ("the repair strengthens the conclusion") are exact and correct; and **branch 2 binds at $n=12$**, with $S\le4.162$ against a threshold $S^*=18.00$ that reproduces to four digits from the entry's own constants. The useful reading, branch 1 can bind only if $\sup\lvert P\rvert$ grows past an absolute constant, that constant being $34.71$, is **confirmed**.

What is owed:

1. **The title clause is refuted.** "$n$-free" / "an inequality between absolute constants" holds only at $A=n^{-1/2}$, which the entry itself replaces; $S^*$ runs over $[5.70,34.71]$ and $\lambda(12)/\lambda(\infty)=4.10$.
2. **The canonical form is superseded text.** [results.md](../results.md):365–369 asserts the threshold still disputed and carries none of the corrections.
3. **`HYPOTHESIS-DEBT`: the extension to $n\approx1800$.** What is owed is the criterion, the bound on $S$ it uses, and the arithmetic. The record's own constants give $n\approx1135$.
4. **`HYPOTHESIS-DEBT`: the hypothesis inventory.** What is owed is a statement of $n=2m$, $n\ge12$, $W^*=S^m\times S^m$, $\ker W^*=0$, $H\perp W^*$, $H\perp T_{W^*}\mathcal O$, $\lVert H\rVert_F=1$, every one used, none stated.
5. **$0.38673$ must be relabelled.** It is $(1-\eta^*)^2\sqrt{c_p+\rho^{\text{eff}}w_0^2}$, not a tube radius; branch 2 at $w_0$ is $0.0206$.
6. **The superseded prefactors $1.24$ and $1.1075$, and the "$52.92$ is one constant" diagnosis, should go or be marked.**

**Reproduced from the entry's own constants:** $\kappa(12)=4.4497190$; $\theta_0(12)=\sqrt{55}/6$; $\lvert\kappa_{12}\rvert=0.1015938$ and $\lambda(12)=6.2747$; $C^*=\tfrac{42}{11}$, $J^*=\tfrac{840}{121}$, $2J^*=\tfrac{1680}{121}=13.884$, factor $\tfrac{189}{121}$; $\rho^{\text{eff}}$ at $n=12,14,16,18$; $w_0=(n-4)/n$; $\phi'(w_0)=\tfrac35$; the elasticity identity; $0.40347$, $0.38673$, $0.38468$, $1.04329$, $8.667\%$, $27.8\%$, $19.4\%$, $1.0391$; $Bc/A=3\sqrt{n-1}/n=0.82916$ and $A=3.980$; $\kappa n^{-1/2}=1.2845$ and its "$>1$ for all $n\le19$" ($n^2-20n+18\ge0$ at $n\ge19.06$); $2\sqrt n/(n-8)$; $1.24$ and $1.1075$ at superseded constants; $g_\rho\ge0.71979/n$; $1+\sqrt{n-2}=4.162$; $a_0=1.549$; $s\le3.37$, $s^*\approx15$; the threshold $18.00$.

**Not reproduced:** $52.92$ (the entry's own formula at $\lambda=1.53$ gives $42$–$45$); the band width $17$–$19$ (a point, $18.00$); the uniform slope bound $0.4019$ (I get $0.348$, and $0.180$ with the elasticity); $n\approx1800$ (I get $\approx1135$); $0.2793$ and $0.2209$, which the entry itself declares irreproducible and which I likewise could not force from any named constant.

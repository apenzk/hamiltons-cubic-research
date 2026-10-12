# Adjudication v41, Lemma L158, candidates E9 and E10

*Adjudicator v41, 2026-09-05. **No numerical work was done: no script was run, and every value below is an exact hand evaluation of a closed form**, carried to more digits than the record prints so that agreement can be judged rather than assumed. Log: [agent_logs/verify-L158-E9E10-v41.log](../agent_logs/verify-L158-E9E10-v41.log). The entry adjudicated is [Lemma L158](../findings/second-order.md), the sentence at line 1318.*

| CANDIDATE | VERDICT |
|---|---|
| **E9**, the $4.9\%$ comparison and the envelope at $w=0.5528$ | **UPHELD IN PART** |
| **E10**, the $27.8\%$ / $19.4\%$ improvement figures | **WITHDRAWN** |

**E9's envelope facts are established and its reversal is not.** $0.5528$ is the kink of the *superseded triangle* envelope, the record's current envelope gives $\phi(0.5528)=0.9254598<1$, and the objective there is $0.4156540$ against $0.403463$ at $w_0=\tfrac23$, so $w_0$ wins by $3.02\%$. But the entry's $4.9\%$ does not thereby reverse: it prices the *understatement of the entry's own earlier figure*, which is a true statement pointing the same way.

**E10 is refuted at its premise.** Both entry numerals reproduce exactly, $27.82\%$ and $19.40\%$, once the baseline is identified as [r714](../reviews/REVIEW_r714.md)'s endpoint *figure*, which carries r714's refuted $1.4472$. Against that baseline the improvement is $1.4472/R$ with $R=G(1)/G(w_0)$, and since $R$ decreases in $\lambda$ the improvement **increases** in $\lambda$. The candidate's own elasticity argument, applied to the entry's actual quantity, confirms the ordering it was raised to refute.

## The constants, all from the record

| symbol | value at $n=12$ | source |
|---|---|---|
| $m$ | $6$ | $a_0n^{-1/2}=1/\sqrt{m-1}$, [L146](../findings/second-order.md) |
| $\kappa=nc_p$ | $3\sqrt{11/5}=4.4497190$ | [L158](../findings/second-order.md) box |
| $c_p$ | $0.37080992$ | $\kappa/n$ |
| $b:=a_0n^{-1/2}=\sqrt{2/(n-2)}$ | $1/\sqrt5=0.4472136$ | [L146](../findings/second-order.md), [L149](../findings/second-order.md) |
| $w_0=(n-4)/n$ | $2/3$, with $\phi(w_0)=1$, $\phi'(w_0)=3/5$ | [L158](../findings/second-order.md) Gate-2 box |
| $D=\tfrac{2m-1}{m-1}$, $\alpha^*$, $\gamma^*$, $J^*$ | $11/5$, $1.1$, $0.55$, $8.4/1.21=6.9421488$ | [L156](../findings/second-order.md) |
| $2J^*\gamma^*=4(1+\alpha^*)/\alpha^*$ | $84/11=7.6363636$ | [L156](../findings/second-order.md) |
| $\lambda(12)=2/\sqrt{\lvert\kappa_{12}\rvert}$ | $6.274966$ | [L157](../findings/second-order.md), [L158](../findings/second-order.md) |
| $\lambda_\infty=2/\sqrt{1.7053}$ | $1.5315355$ | [L157](../findings/second-order.md) |
| $\rho^{\text{eff}}_{12}=\sqrt6-\tfrac7{30}\sqrt{55}$ | $0.7190434$ | [L149](../findings/second-order.md), [L158](../findings/second-order.md) |

Write $s(w)=\sqrt{c_p+\rho w^2}$, $\beta=\lambda/(2J\gamma)$, $t=\beta s$, $q=\sqrt{4t+1}$, and, from [L157](../findings/second-order.md)'s rationalised root $1-\eta^*=2/(q+1)$,

$$G(w):=(1-\eta^*)^2\,s=\frac{4s}{(q+1)^2},\qquad F(w):=\frac{G(w)}{\phi(w)},\qquad \phi(w)=\min\big(b\sqrt{1-w^2}+w,\ 1\big),$$

so that branch 2 is $\tfrac{\lambda}{\sqrt2 Jn}F(w)$ and the minimiser of branch 2 is the minimiser of $F$. At $n=12$, $\beta_{12}=6.274966/7.6363636=0.8217217$ and $\beta_\infty=1.5315355/7.6363636=0.2005582$.

**The evaluation table, exact by hand, coefficient $1$ on $w^2$** (the convention in which the entry's $0.40347$ is stated):

| $\lambda$ | $w$ | $s$ | $t$ | $q$ | $(1-\eta^*)^2$ | $G$ | $\phi$ | $F=G/\phi$ |
|---|---|---|---|---|---|---|---|---|
| $6.274966$ | $0.5527864$ | $0.8224249$ | $0.6758071$ | $1.9243774$ | $0.4677278$ | $0.384671$ | $0.9254598$ | $0.4156540$ |
| $6.274966$ | $2/3$ | $0.9029144$ | $0.7419443$ | $1.9919281$ | $0.4468455$ | $0.403463$ | $1$ | $0.403463$ |
| $6.274966$ | $1$ | $1.1708159$ | $0.9620849$ | $2.2018946$ | $0.3901627$ | $0.456809$ | $1$ | $0.456809$ |
| $1.5315355$ | $2/3$ | $0.9029144$ | $0.1810869$ | $1.3131442$ | $0.7475747$ | $0.674996$ | $1$ | $0.674996$ |
| $1.5315355$ | $1$ | $1.1708159$ | $0.2348168$ | $1.3925757$ | $0.6987609$ | $0.818120$ | $1$ | $0.818120$ |

**This table is validated against three of the record's own printed numerals before anything is concluded from it.** $G(2/3)=0.403463$ against the record's $0.40347$; $G(0.5528)=0.384671$ against $0.38468$; and, repeating the first row with $\rho^{\text{eff}}_{12}$ in place of $1$, $s=0.8308937$, $t=0.6827629$, $q=1.9315929$, $G=0.386721$ against the record's corrected $0.38673$, whose ratio to $G(2/3)$ is $1.043293$ against the record's $1.04329$. **The residual disagreements are at the sixth digit and are the record's own rounding**; nothing below turns on them.

**Two facts the table settles at once, and they run the whole adjudication.** *Both of the entry's numerals $0.40347$ and $0.38468$ are values of the envelope-free $G$, not of the objective $F$*, the envelope appears in neither. And *at $w_0=\tfrac23$ and at $w=1$ this is harmless, because $\phi=1$ at both*; it bites only at $w=0.5528$, where $\phi=0.9254598$.

## 1. Candidate E9, which envelope $0.5528$ belongs to, what $\phi$ is there, and the sign of the $4.9\%$

**Located.** [findings/second-order.md](../findings/second-order.md) line 1318, opening sentence: *"**And this entry's own kink understated the minimum by $4.9\%$, the exact charge it laid against r714.** At $n=12$ with $\lambda(12)=6.275$ the minimum was recorded as $0.40347$ at $w_0=\tfrac23$, against $0.38468$ at the entry's $0.5528$ and $r714$'s endpoint value."*

### 1a. $0.5528$ is the triangle envelope's kink, and the record has superseded that envelope

The two envelopes on the page are the **triangle** form at line 1308, $\phi_\triangle(w)=\min(b+w,1)$, and the **homogeneity** form at lines 1310–1312, $\phi(w)=\min(b\sqrt{1-w^2}+w,1)$, which the same box installs in its place on the ground that $\lVert H_s\rVert_F=\sqrt{1-w^2}$ is an *identity* under $H_s\perp H_r$ and $\lVert H\rVert_F=1$.

Their kinks are different points. $\phi_\triangle$ reaches $1$ at $w_\triangle=1-b$, which at $n=12$ is

$$w_\triangle=1-\tfrac1{\sqrt5}=0.5527864,$$

and $\phi$ reaches $1$ at $w_0=(1-b^2)/(1+b^2)=(n-4)/n=\tfrac23$. *So $0.5528$ is the kink of the envelope the entry itself refutes two paragraphs above the sentence, and $\tfrac23$ is the kink of the envelope it installs.* **The previous reader's identification was right and their inference from it was not**: it is true that $0.5528$ is the triangle kink, and false that this makes both points sit where "that envelope" equals $1$ under the record's current envelope.

### 1b. $\phi(0.5528)$ under the record's current envelope, in closed form

At $w=1-5^{-1/2}$ we have $1-w^2=\tfrac{2\sqrt5-1}5$, so

$$\phi(w_\triangle)=\frac1{\sqrt5}\sqrt{\frac{2\sqrt5-1}{5}}+1-\frac1{\sqrt5}=1-\frac{\sqrt5-\sqrt{2\sqrt5-1}}{5}=1-\frac{2.2360680-1.8633669}{5}=0.9254598 .$$

**So $\phi(0.5528)=0.9254598$, strictly below $1$**, exactly as E9 asserts to four digits ($0.9255$), and consistent with line 1312's own "never larger than the triangle form". *The candidate's numeral is right and its provenance is the record's own display.*

### 1c. The comparison of $0.40347$ against $0.38468$ is not a comparison of the objective at two points

$0.38468$ is $G(0.5528)$, computed with no envelope; the objective there is $F(0.5528)=0.384671/0.9254598=0.4156540$. Against $F(2/3)=0.403463$:

$$\frac{F(0.5528)}{F(2/3)}=\frac{0.4156540}{0.403463}=1.030217,$$

so **$w_0=\tfrac23$ beats $0.5528$ by $3.02\%$ of the larger value, equivalently the minimum lies $2.93\%$ below it**, E9's "about $2.9\%$", confirmed. *A local check agrees with the record's global argument*: at $w=0.5528$, $\tfrac{\mathrm d\log G}{\mathrm dw}=\tfrac1q\cdot\tfrac{\rho w}{s^2}=\tfrac{0.5527864}{1.9243774\times0.6763827}=0.42469$ against $\tfrac{\phi'}{\phi}=\tfrac{1-bw/\sqrt{1-w^2}}{\phi}=\tfrac{0.7033400}{0.9254598}=0.759994$, so $F$ is still falling at $0.5528$ and continues to fall to $w_0$.

**There is also a structural reason the $4.9\%$ carries no information about which point is better.** $\phi\le\phi_\triangle$ pointwise, so $G/\phi_\triangle\le G/\phi$ pointwise and $\min_w G/\phi_\triangle\le\min_w G/\phi$ **at every $n$ and every $\lambda$**. Comparing the correct envelope's minimum against the superseded envelope's minimum therefore has a sign fixed by construction; it prices the envelope repair, not a location.

### 1d. The strongest defence of the entry, and it holds

*Read the sentence as E9 reads it*, as asserting $F(0.5528)<F(2/3)$, and it is false, contradicts line 1310's own headline, and contradicts the strict-minimum argument four sentences later in the same paragraph.

*Read it as the entry's own words demand*, and it is true. The verb is **"understated the minimum"**: a figure understating a minimum is a wrong figure, not a better location. **"The exact charge it laid against r714"** fixes the meaning beyond doubt, because that charge (line 1312) is precisely *pricing an inadmissible envelope and so producing a value that is too low*. And $0.38468$ is exactly that: the entry's own earlier kink $0.5528$, evaluated with $\phi=1$ where the admissible envelope gives $0.9254598$, understating the true minimum $0.40347$ by

$$\frac{0.403463-0.384671}{0.384671}=0.048853\quad\longrightarrow\quad 4.9\% .$$

**So the entry says what E9 says, in the direction E9 says it, and its $4.9\%$ is the correct size of the understatement it names.** The one thing the entry does not do is print $\phi(0.5528)$ or $F(0.5528)$, which is what leaves the sentence open to E9's reading.

**Verdict E9: UPHELD IN PART.** Established: the envelope identification, $\phi(0.5528)=0.9254598$, the fact that $0.38468$ omits it, and $F(0.5528)=0.4156540$ exceeding the minimum by $3.02\%$. Refuted: that the direction of the $4.9\%$ claim reverses. **The defect is one of exposition (a numeral whose meaning the sentence leaves ambiguous) rather than of arithmetic.**

## 2. Candidate E10, the closed-form monotonicity, derived, and the two figures

**Located.** Same line 1318, continuing: *"the improvement over the endpoint is $27.8\%$ at $\lambda(12)$ and $19.4\%$ at the asymptotic $\lambda$, never the $26\%$ claimed."*

### 2a. The monotonicity, derived rather than asserted

Fix $s_0<s_1$ and set $R(\beta)=G(s_1)/G(s_0)$ with $G=4s/(q+1)^2$, $q=\sqrt{4\beta s+1}$. From $q^2=4\beta s+1$,

$$\frac{\mathrm dq}{\mathrm d\log\beta}=\frac{2\beta s}{q}=\frac{q^2-1}{2q}\quad\Longrightarrow\quad\frac{\partial\log(q+1)}{\partial\log\beta}=\frac{q-1}{2q},$$

and since $s_0,s_1$ do not depend on $\beta$,

$$\boxed{\ \frac{\partial\log R}{\partial\log\beta}=-2\Big[\frac{q_1-1}{2q_1}-\frac{q_0-1}{2q_0}\Big]=-\Big(\frac1{q_0}-\frac1{q_1}\Big)<0\ }$$

for every $\beta>0$, because $s_1>s_0$ forces $q_1>q_0>1$. **The same conclusion follows from the entry's own displayed elasticity** at line 1315: $\mathrm d\log G/\mathrm d\log s=1/q=1/\sqrt{4t+1}$ gives $\log R=\int_{s_0}^{s_1}q(s)^{-1}\,\mathrm d\log s$, and $q(s)$ rises pointwise with $\beta$, so the integrand falls pointwise and $\log R$ falls. **$R$ is strictly decreasing in $\lambda$.** *Checked against the table: $R=0.456809/0.403463=1.132198$ at $\lambda(12)$ and $0.818120/0.674996=1.212036$ at $\lambda_\infty$, and $6.275>1.532$.*

### 2b. The two figures, and what the entry's baseline actually is

$R-1$ is not what the entry reports. **The entry's baseline is [r714](../reviews/REVIEW_r714.md)'s endpoint figure**, which line 1312 records as carrying $1.4472=1+\sqrt{2/(n-2)}$, the triangle bound at $w=1$ with the $\min$ omitted, the "$H_s$ that $\lVert H\rVert_F=1$ has already emptied". r714's endpoint value is therefore $G(1)/1.4472$, and the improvement of the corrected minimum over it is $1.4472\,G(w_0)/G(1)=1.4472/R$:

$$\lambda(12):\quad\frac{1.4472\times0.403463}{0.456809}=\frac{0.583892}{0.456809}=1.278197\ \longrightarrow\ \mathbf{27.82\%},$$
$$\lambda_\infty:\quad\frac{1.4472\times0.674996}{0.818120}=\frac{0.976854}{0.818120}=1.194022\ \longrightarrow\ \mathbf{19.40\%}.$$

**Both reproduce the entry to every printed digit.** *Two independent three-significant-figure matches are not a coincidence*, and they settle the reading: "the improvement over the endpoint" means the improvement over r714's endpoint *claim*, not over the objective's value at $w=1$.

### 2c. The ordering has the right sign, by the candidate's own argument

The entry's quantity is $I(\lambda)=1.4472/R(\lambda)-1$, so

$$\frac{\partial\log(1+I)}{\partial\log\lambda}=-\frac{\partial\log R}{\partial\log\lambda}=\frac1{q_0}-\frac1{q_1}>0 .$$

**$I$ strictly increases in $\lambda$**, and $\lambda(12)=6.275>\lambda_\infty=1.532$ forces $I(\lambda(12))>I(\lambda_\infty)$, that is, $27.8>19.4$. *Numerically the elasticity is $1/1.9919-1/2.2019=0.04787$ at $\lambda(12)$ and $1/1.3131-1/1.3926=0.04344$ at $\lambda_\infty$, against the realised $\log(1.278197/1.194022)/\log(6.274966/1.5315355)=0.068146/1.410297=0.04832$, consistent, the integrand peaking near $\beta\approx0.45$ where it is $0.04990$.*

### 2d. The strongest defence of the candidate, and it fails

The candidate's mathematics is correct: $R$ does decrease in $\lambda$, and its figures $R-1=13.22\%$ at $\lambda(12)$ and $21.20\%$ at $\lambda_\infty$ are exactly right *for $R-1$*. **What fails is the identification of $R-1$ with the entry's quantity.** Two independent grounds:

- **$R-1$ cannot be an "improvement over the endpoint" at all.** $w_0$ is the minimiser and $w=1$ is an ordinary point of the same objective with $\phi=1$ at both, so $F(w_0)<F(1)$ necessarily; the minimum is $11.68\%$ *below* the endpoint, and calling that an improvement of $13.2\%$ inverts a lower bound on the radius, where larger is stronger.
- **$R-1$ reproduces neither printed figure**, while $1.4472/R-1$ reproduces both exactly.

*And the earlier review that called $27.8$ and $19.4$ unreproducible repeated a mistake rather than confirming one, the brief's warning, discharged in the direction it warned about.*

**Verdict E10: WITHDRAWN.** The candidate locates the claim, but its concrete failure does not hold and the entry's defence is decisive.

## 3. Whether the entry's conclusions survive

**Both survive, and neither depends on a numeral that is wrong.**

- **The conclusion under E9** (that the minimiser is the homogeneity kink $w_0=(n-4)/n$, strictly at $n=12$), is untouched and is *strengthened* by E9's own arithmetic, which supplies a second competing point, $0.5528$, and finds it $3.02\%$ worse. The record's uniform argument ($\phi'(w_0)=\tfrac35$ against $\tfrac1s\tfrac{N'}N\le0.4019$) is not in question here and was not examined.
- **The conclusion under E10**, that branch 2 binds at $n=12$, that the $\rho^{\text{eff}}_n$ repair lowers branch 2 and so makes it bind more surely, and that r714's $1.4472$ endpoint is refuted, is untouched, and its supporting numerals are correct as printed.
- **What is defective is exposition in one sentence**, not a conclusion: the sentence packs three different baselines (the corrected minimum, the entry's own earlier kink figure, r714's endpoint figure) into one clause and prints none of the envelope factors that distinguish them. *That is a repair to the sentence, not to the lemma.*

## 4. What the numerals should read

**Determinable, and correct as printed** (my hand values in brackets): $0.40347$ [$0.403463$]; $0.38468$ [$0.384671$]; $4.9\%$ [$4.885\%$]; $27.8\%$ [$27.82\%$]; $19.4\%$ [$19.40\%$]; and the corrected $0.38673$ [$0.386721$] with its factor $1.04329$ [$1.043293$]. **No numeral in the sentence needs changing.**

**Determinable, and missing**, the three the sentence needs so that it cannot be read as E9 read it: $\phi(0.5528)=1-\tfrac{\sqrt5-\sqrt{2\sqrt5-1}}5=0.92546$; the objective at that point, $F(0.5528)=0.41565$; and the margin by which $w_0$ beats it, $3.02\%$. **The sentence should also name its baselines**, "$0.38468$" as *the entry's own earlier figure at $0.5528$, computed with $\phi=1$*, and "the endpoint" as *r714's endpoint figure, which carries $1.4472$*.

**Determinable, if the sentence is restated in the $\rho^{\text{eff}}_{12}=0.7190434$ convention** the rest of the paragraph adopts: $4.9\%$ becomes $4.19\%$, $3.02\%$ becomes $3.71\%$, $27.8\%$ becomes $29.22\%$ and $19.4\%$ becomes $21.77\%$; the minimum is $0.386721$ and $F(0.5528)$ is $0.401074$. *The ordering is preserved.*

**Not determinable, and stated as such rather than estimated.** *Whether the $\rho^{\text{eff}}$ restatement of $27.8\%$ and $19.4\%$ should also restate r714's $1.4472$ baseline* is a convention question about a figure r714 computed under the old numerator, and the record does not fix it; the $29.22\%/21.77\%$ above hold $1.4472$ fixed and are labelled accordingly. *And whether "the asymptotic $\lambda$" means $\lambda_\infty$ with the remaining constants at $n=12$*: the reading used here reproduces $19.4\%$ exactly and is the one [L157](../findings/second-order.md) uses elsewhere, whereas taking every constant to its $n\to\infty$ limit sends $w_0=(n-4)/n\to1$, collapsing the kink onto the endpoint and the improvement to $0$, so that reading is excluded, but the record never says which is meant.

**Closing line.** *Every numeral in the sentence should read exactly as it now reads*; what should be added is $\phi(0.5528)=0.92546$, $F(0.5528)=0.41565$ and the $3.02\%$ margin, and what should be named is the two baselines, the entry's own earlier $0.5528$ figure for the $4.9\%$, and r714's $1.4472$-laden endpoint figure for the $27.8\%$ and $19.4\%$.

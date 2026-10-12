# VERIFY v37, D6: does Lemma L157's $t$ carry the wrong numerator, $\sqrt{c_p+w^2}$ where Lemma L149's repaired branch carries $\sqrt{c_p+\rho^{\mathrm{eff}}_nw^2}$?

*Adjudication of one candidate finding raised against [Lemma L157](../findings/second-order.md) by a single reader, unchecked before this round. **No numerical work was done: no script was run, and every value below is an exact hand evaluation from the record's own closed forms.*** Log: [agent_logs/verify-L157-D6-v37.log](../agent_logs/verify-L157-D6-v37.log).

## UPHELD

L157 writes the coefficient $1$ on $w^2$ where the record's own margin bound gives $\rho^{\mathrm{eff}}_{12}=\sqrt6-\tfrac7{30}\sqrt{55}=0.7190434<1$; no passage anywhere reconciles the two or states the $1$ deliberately; and the error runs in the unsafe direction, inflating $t$ by exactly $12.15\%$ at $w=1$ and $8.67\%$ at the record's own binding direction $w_0=\tfrac23$, hence inflating the reach and the recorded tube radius.

Two refinements the candidate did not state, neither of which rescues L157. **The defect is confined to $n\in\{12,14,16\}$**, $\rho^{\mathrm{eff}}_n$ crosses $1$ between $n=16$ and $n=18$, above which the coefficient $1$ is a valid, merely weaker, lower bound. And **L157 inherited the defect rather than inventing it**: [L149](../findings/second-order.md)'s own displayed chain still carries the coefficient $1$, contradicting L149's own margin bullet and its own proof, so the defect is shared by L149's display, L157, L158 and [results.md](../results.md).

## 1. What each lemma actually writes

**[L157](../findings/second-order.md), line 1257**, the lemma statement itself:

> *In units of $\rho$ the two coupled branches are $\eta$ and $t(1-\eta)^2$ with $t=\lambda\sqrt{c_p+w^2}/(2J\gamma)$; they cross at the unique root in $(0,1)$*

and its crossing identity at **line 1260**, $\eta^*\gamma=\frac{\lambda\sqrt{c_p+w^2}}{2J}(1-\eta^*)^2$.

**[L149](../findings/second-order.md), line 1229**, the repaired proof:

> **Proof of the uniformity.** Write $g_\rho(w)=\sqrt{c_p+\rho w^2}\big/\big(a_0n^{1/2}+nw\big)$ with $a_0=\sqrt{2n/(n-2)}$ from [Lemma L146], $c_p=\kappa/n$ and $\rho=\rho^{\mathrm{eff}}_n$.

**They differ in exactly one factor: the coefficient on $w^2$ under the square root.** L149's repaired numerator is $\sqrt{c_p+\rho^{\mathrm{eff}}_nw^2}$; L157's is $\sqrt{c_p+w^2}$, which is the $\rho=1$ specialisation. Nothing else differs, $c_p$ is the same $\kappa/n$, and $w$ is the same variable.

**L149 is internally split, and this matters for authorship.** L149's own displayed chain at **line 1214** still reads

$$r(H)\;\gtrsim\;\min\!\left(\frac{c_p+u^2}{S+au},\ \frac{\sqrt{c_p+w^2}}{n^{1/2}+nw},\ \frac{\rho(H)}2\right),$$

with the coefficient $1$, five lines above the proof that uses $\rho^{\mathrm{eff}}$. **L157 quotes that display faithfully.** But L149's own margin bullet at **line 1210** refutes its own display:

> *The bound once written here, $c(H)\gtrsim c_p+w^2$, is **a lower bound stated upward** at the dimensions that matter: the coefficient is $0.7416$ at $n=12$ and $0.9463$ at $n=14$, reaching $1$ only from $n=16$ ([r716]; reproduced here at six dimensions). **It is unsafe exactly on $n\in\{12,14\}$**, and repairing it lowers branch 2 there*

and [L158](../findings/second-order.md) repeats the charge at **line 1322**, in a box headed *"TWO DEFECTS IN L149 NEITHER PARTY RAISED, FROM [r716]"*. So the coefficient $1$ is on the record as refuted, twice, in the same file as L157.

## 2. Whether they are the same quantity

**They are the same quantity, and the record joins them in a single display.** [L158](../findings/second-order.md), **line 1301**, in the box marked *"SETTLED. GATE 2: r713 AND r714, AGREEING"*, writes branch 2 as one object built from L157's prefactor and L149's fraction:

$$\text{branch }2=\underbrace{\frac{\lambda(1-\eta^*)^2}{\sqrt2\,J}}_{K}\cdot\frac{\sqrt{c_p+w^2}}{a_0n^{1/2}+nw}.$$

The fraction on the right **is** L149's $g_\rho$ with $\rho$ set to $1$, same denominator $a_0n^{1/2}+nw$, character for character, same $c_p$. And L149 confirms the join from its own side at **line 1235**: *"Branch 2 is $K\,g_\rho$ with $K=\lambda(1-\eta^*)^2/(\sqrt2 J)$ from [L158]"*. So one object is written twice, once with $\rho^{\mathrm{eff}}$ and once with $1$.

**The same $w$, in the same normalisation.** L149 fixes it at **line 1209**: *"Write $H=H_s+H_r$ with $H_s$ in the **joint** $\lambda_m$-eigenspace, both copies, and $w:=\lVert H_r\rVert$ the weight outside **both**"*, on $\lVert H\rVert_F=1$, so $w\in[0,1]$. L157 uses that same range and that same envelope: it evaluates $\sup_wt$ at $w=1$ (line 1262), cites $w^*=0.829$, and its $w$-dependence is minimised over $[0,1]$ by L158 at the kink $w_0=(n-4)/n$. The r716 box at **line 1310** certifies the shared normalisation explicitly, *"confirming $w\in[0,1]$ and $a_0n^{-1/2}=\sqrt{2/(n-2)}=1/\sqrt{m-1}$ as one quantity written two ways"*, across L146, L149, L157 and L158 together.

**Each numerator is the numerator of the same thing: $\sqrt{c}$ in branch 2 $=\lambda\sqrt c/\lVert A''\rVert$.** L157 says so in its own words at line 1264 (*"Branch 2 is $\lambda\sqrt c/\lVert A''\rVert$"*) and then instantiates $\sqrt c$ as $\sqrt{c_p+w^2}$. L149 instantiates the same $\sqrt c$ as $\sqrt{c_p+\rho^{\mathrm{eff}}_nw^2}$, by the margin bound at line 1210, $c(H)\ge c_p+3\theta_0\tfrac{m-4}{2(m-1)}w^2$. **So this is not a difference of symbol, of branch, or of normalisation. It is one instantiation of one quantity, done two ways, one of which the record has already refuted.**

**And the branch-1 escape is closed.** Branch 1 carries $u$, not $w$, L149, line 1216: *"$u$ is the defect's linear rate and is **not** $w$, the only relation on file being $u\le w$"*, and branch 1's numerator is $c_p+u^2$ unsquare-rooted. L157's numerator sits under a square root and carries $w$, so it is branch 2's and no other's.

## 3. The value and sign of $\rho^{\mathrm{eff}}_n$

**Definition**, [L149](../findings/second-order.md) **line 1222**, in the box headed *"THE MARGIN COEFFICIENT"*:

$$\rho_n^{\mathrm{eff}}=3\theta_0\frac{n-8}{2(n-2)}-\frac29\lvert\kappa_n\rvert,\qquad\lvert\kappa_n\rvert=9\big(\theta_0(n)-\sqrt{3/2}\big),$$

*"increasing from $0.71904$ at $n=12$ to $\tfrac32\sqrt2-2(\sqrt2-\sqrt{3/2})=1.74238$."*

**Exact evaluation at $n=12$.** The record fixes $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ at even $n$, it prints $\theta_0(6)=1.054093$, $\theta_0(8)=1.145644$, $\theta_0(10)=6/5$ and $\theta_0(12)=1.236033$, all four of which this formula returns. So

$$\theta_0(12)=\frac{\sqrt{220}}{12}=\frac{\sqrt{55}}6,\qquad c_p=\frac{3\theta_0}{n-2}=\frac{\sqrt{55}}{20},\qquad \kappa=nc_p=\frac{3\sqrt{55}}5=4.4497191,$$

the last matching the record's $\kappa(12)=4.4497$ at **line 1281**. Then

$$\lvert\kappa_{12}\rvert=9\Big(\frac{\sqrt{55}}6-\frac{\sqrt6}2\Big)=\frac{3\sqrt{55}-9\sqrt6}2=0.10159389,$$

matching the $\lvert\kappa_{12}\rvert=0.10159$ the record prints in three places. The $m$-form coefficient at $m=6$ is $3\theta_0\tfrac{m-4}{2(m-1)}=\tfrac35\theta_0=\tfrac{\sqrt{55}}{10}=0.74161985$, matching r716's $0.74162$, and the $n$-form gives $3\theta_0\tfrac4{20}=\tfrac35\theta_0$ identically, the two forms are one quantity, as line 1222 asserts. Subtracting the penalty,

$$\rho^{\mathrm{eff}}_{12}=\frac{\sqrt{55}}{10}-\frac29\cdot\frac{3\sqrt{55}-9\sqrt6}2=\frac{\sqrt{55}}{10}-\frac{\sqrt{55}}3+\sqrt6=\boxed{\;\sqrt6-\frac7{30}\sqrt{55}\;}=0.71904343,$$

reproducing the record's $0.71904$ exactly.

**It is strictly below $1$, and the proof needs no decimals.** $\rho^{\mathrm{eff}}_{12}<1$ iff $30(\sqrt6-1)<7\sqrt{55}$; squaring, $900(7-2\sqrt6)<49\cdot55=2695$, i.e. $6300-1800\sqrt6<2695$, i.e. $\sqrt6>\tfrac{3605}{1800}=2.00278$, which holds since $6>4.0112$. $\square$

**A coefficient below $1$ makes L157's $t$ too large**, since $t$ is strictly increasing in the coefficient. **So L157's $t$ is overstated at $n=12$.**

**The record's own proof depends on this value and reproduces it.** L149's uniformity numeral at **line 1233** is $\big(\tfrac{\sqrt2n}{3\sqrt{(n-1)(n-2)}}+\tfrac1\rho\big)^{-1/2}$; at $n=12$ the first term is $\tfrac{12\sqrt2}{3\sqrt{110}}=0.5393564$, and with $1/\rho^{\mathrm{eff}}_{12}=1.3907373$ the sum is $1.9300937$, whose inverse square root is $0.7197978$, the record's stated $0.7197978$ to all seven digits. This is an independent confirmation that $\rho^{\mathrm{eff}}_{12}=0.71904343$ is the number L149's proof actually carries.

**The direction survives the open debt on the $\tfrac29$.** [Line 1225](../findings/second-order.md) flags the penalty coefficient as `HYPOTHESIS-DEBT` and records that *"three passages of this file price the same constant at $1$"*, giving $0.689771$ for the uniformity numeral instead, which is exactly what $\rho=\tfrac{\sqrt{55}}{10}-\lvert\kappa_{12}\rvert=0.6400269$ returns through the same formula, $(0.5393564+1.5624345)^{-1/2}=0.689771$. So the three readings of the coefficient on the record at $n=12$ are $0.74162$ (no penalty, r716), $0.71904$ (penalty $\tfrac29$) and $0.64003$ (penalty $1$). **Every one of them is below $1$, so the sign of the finding is independent of the debt; only the magnitude moves.**

**The range over which it bites.** Evaluating the same closed form at the next three even dimensions:

| $n$ | $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ | $3\theta_0\tfrac{n-8}{2(n-2)}$ | $\tfrac29\lvert\kappa_n\rvert$ | $\rho^{\mathrm{eff}}_n$ |
|---|---|---|---|---|
| 12 | $\sqrt{55}/6=1.2360331$ | $0.7416198$ | $0.0225764$ | **$0.7190434$** |
| 14 | $\sqrt{312}/14=1.2616801$ | $0.9462601$ | $0.0738705$ | **$0.8723896$** |
| 16 | $\sqrt{420}/16=1.2808689$ | $1.0978876$ | $0.1122480$ | **$0.9856396$** |
| 18 | $\sqrt{544}/18=1.2957671$ | $1.2147817$ | $0.1420444$ | **$1.0727372$** |

**So $\rho^{\mathrm{eff}}_n<1$ exactly on $n\in\{12,14,16\}$ and exceeds $1$ from $n=18$**, consistent with the record's stated monotone increase to $1.74238$. Under the penalty-free reading the crossing is earlier, at $n=16$, matching r716's *"reaching $1$ only at $n=16$"*. **At $n\ge18$ the coefficient $1$ is a valid but weaker lower bound, so L157's $t$ is there understated and safe. The defect lives exactly on the dimensions the programme quotes every figure at.**

## 4. The direction of the consequence

**$t$ is inflated by exactly the ratio of the numerators**, since $t=\lambda s/(2J\gamma)$ is linear in $s$ and none of $\lambda,J,\gamma$ carries $w$ or the margin coefficient. Writing $R(w)=\sqrt{(c_p+w^2)/(c_p+\rho^{\mathrm{eff}}_{12}w^2)}$, at $n=12$:

**At $w=1$**, where L157 reads $\sup_wt$:

$$c_p+1=\frac{\sqrt{55}+20}{20},\qquad c_p+\rho^{\mathrm{eff}}_{12}=\sqrt6-\frac{11}{60}\sqrt{55},\qquad R(1)^2=\frac{3(\sqrt{55}+20)}{60\sqrt6-11\sqrt{55}}=\frac{82.2485955}{65.3912020}=1.2577932,$$

so $R(1)=1.1215137$: **an inflation of $12.15\%$, which is the candidate's "about $12\%$".**

**At $w_0=\tfrac23$**, the record's own binding direction at $n=12$ (line 1310, *"THE MINIMISER IS THE HOMOGENEITY KINK $w_0=\tfrac{n-4}n$, WHICH IS $\tfrac23$ AT $n=12$"*):

$$c_p+\tfrac49=0.8152544,\qquad c_p+\tfrac49\rho^{\mathrm{eff}}_{12}=\tfrac49\sqrt6-\tfrac{29}{540}\sqrt{55}=0.6903848,\qquad R(\tfrac23)^2=1.1808701,$$

so $R(\tfrac23)=1.0866785$: **an inflation of $8.67\%$ where the minimum is actually attained.**

**A larger $t$ gives a larger $\eta^*$, hence a larger reach.** Rationalising L157's root, $1-\eta^*=2/(\sqrt{4t+1}+1)$, so $\eta^*=\frac{\sqrt{4t+1}-1}{\sqrt{4t+1}+1}$ is strictly increasing in $t$; the record states the derivative at **line 1443**, $\tfrac{d\eta^*}{dt}=4/(s(s+1)^2)>0$ with $s=\sqrt{1+4t}$. Since the reach is $r=\eta^*\rho$ and $\rho=\gamma g_n/\lVert H\rVert_{op}$ carries no margin, **an inflated numerator inflates the reach. The recorded tube radius comes out too large.**

**The size of the radius overstatement, bracketed exactly and without any open constant.** The record's own log-derivative identity at **line 1315** (*"for every $\lambda,J,\gamma$"*), gives, with $s:=\sqrt{c_p+w^2}$,

$$\frac{\mathrm d\log\big(K(w)\sqrt{c_p+w^2}\big)}{\mathrm d\log s}=\frac1{\sqrt{4t+1}}\in(0,1).$$

Branch 2 at fixed $w$ is $K(w)\,s/(a_0n^{1/2}+nw)$, and the substitution $\rho^{\mathrm{eff}}\mapsto1$ moves only $s$. By the mean value theorem in $\log s$, the overstatement factor of branch 2 is $R(w)^\vartheta$ for some $\vartheta\in(0,1)$. **Hence the branch-2 value is overstated by strictly more than $0$ and strictly less than $8.67\%$ at $w_0=\tfrac23$, and less than $12.15\%$ at $w=1$**, the $(1-\eta^*)^2$ inside $K$ absorbs part of the inflation but can never reverse it, which is precisely what r715's identity was established to show. Since $\inf_w$ of a pointwise-overstated function is overstated, **$\inf_w\text{branch }2$ is overstated too, by a factor in $(1,1.1215]$.**

**The downstream statements affected, named.**

- **[L157](../findings/second-order.md) line 1257** (the definition of $t$) and **line 1260**, the crossing identity $\eta^*\gamma=\frac{\lambda\sqrt{c_p+w^2}}{2J}(1-\eta^*)^2$. Both carry the wrong numerator at $n\in\{12,14,16\}$.
- **[results.md](../results.md) line 361**, L157's canonical statement, which repeats both displays verbatim. The canon carries the defect as well as the working file.
- **[L158](../findings/second-order.md) line 1301**, the settled branch-2 display, and **line 1318**, *"At $n=12$ with $\lambda(12)=6.275$ the minimum is $0.40347$ at $w_0=\tfrac23$"*. **This is the lower bound that fails.** Branch 2 is one of the three terms in L149's line-1214 minimum, which is a **lower** bound on the tube radius $r(H)$; L158 establishes that branch 2 is the binding one at $n=12$; so $0.40347$ is a lower bound on the radius at the dimension the programme works at, and it is overstated by a factor in $(1,1.0867]$. **A lower bound stated upward is not a lower bound.**
- **[L157](../findings/second-order.md) line 1266**, *"freezing $\eta=\tfrac12$ cost $2.9$–$3.4$"*, and **line 1328**, $\lambda(1-\eta^*)^2\in[1.24,1.53]$, both are functions of $t$ and move with it.

**What does not fail.**

- **[L149](../findings/second-order.md) line 1233's uniformity numeral $g_\rho\ge0.71979/n$ is untouched**, because L149's proof already carries $\rho^{\mathrm{eff}}$. The defect is in L149's *display* and in its two consumers, not in its proof.
- **[L158](../findings/second-order.md)'s binding conclusion runs the safe way.** Lowering branch 2 makes branch 2 smaller, hence more likely to be the minimum, so *"branch 2 binds at $n=12$, and provably so at every $n$ up to $\approx1800$"* is strengthened, as is the threshold $s^*\approx15$ and the conclusion that [I31](../plan.md)'s constant is not load-bearing. L149 states this direction itself at line 1210: *"repairing it lowers branch 2 there, which strengthens rather than weakens L158's conclusion that branch 2 binds."*
- **The order claims survive.** $\rho^{\mathrm{eff}}_n$ is a positive constant bounded away from zero and increasing, so $r_n\gtrsim n^{-1-\beta}$ and the $\Omega(n^{-1})$ ceiling are unaffected. **Only the constants move, and only downward.**

## 5. Whether the record already knows

**The record knows the fact and has never applied it to L157.** Searching [findings/second-order.md](../findings/second-order.md) for $\rho^{\mathrm{eff}}$ returns exactly four occurrences (**lines 1207, 1222, 1225 and 1229), all four inside L149.** The symbol does not occur in L157, in L158, or anywhere in [results.md](../results.md), [findings/LEDGER.md](../findings/LEDGER.md), [findings/INDEX.md](../findings/INDEX.md) or [plan.md](../plan.md). **There is no passage anywhere on the record that reconciles the two numerators, and none that states L157's coefficient $1$ deliberately, as a simplification or otherwise.**

**What the record does say, twice, is that the coefficient $1$ is wrong**, at **line 1210** (*"a lower bound stated upward… unsafe exactly on $n\in\{12,14\}$"*) and at **line 1322** (r716's box in L158, *"Its margin bound $c(H)\gtrsim c_p+w^2$ is a lower bound stated upward"*). Both charge it against L149. **Neither propagates the repair into L157's $t$, into L158's $K$ display, or into results.md.**

**This makes the verdict `UPHELD` rather than something softer, and it also makes it narrower than a fresh defect.** The setting of the coefficient to $1$ in L157 is genuinely silent, no line states it, no line defends it. But the underlying fact is not news to the file: **it is an unpropagated repair, and the propagation was already owed by line 1210's own sentence.** The candidate's contribution is identifying which downstream entries the owed repair reaches.

## The most charitable reading the words support, and why it does not save L157

**Reading 1, they are different branches, and both are right.** Refuted in §2: [line 1301](../findings/second-order.md) writes L157's $K$ against L149's fraction in a single display with the identical denominator $a_0n^{1/2}+nw$, and L149's line 1235 names the same product from the other side. One object, written twice.

**Reading 2, the two $w$'s differ, so the coefficients legitimately differ.** Refuted in §2: both are $\lVert H_r\rVert\in[0,1]$ on $\lVert H\rVert_F=1$, and r716's box at line 1310 certifies the shared normalisation across L146, L149, L157 and L158 by name.

**Reading 3, L157 inherited L149's line-1214 display and is quoting the record faithfully.** **This reading is correct, and it is the strongest thing that can be said for L157.** L149's display does carry the coefficient $1$, five lines above the proof that does not. **It does not save the claim**, because L149's own margin bullet at line 1210, in the same lemma, refutes that display and names the dimensions at which it is unsafe. Faithfully quoting a refuted display propagates the refutation.

**Reading 4, $\sqrt{c_p+w^2}$ is schematic, a placeholder for $\sqrt c$ rather than a committed value.** Refuted by L157's own text: line 1264 introduces $\sqrt c$ abstractly and then line 1257 instantiates it, and every numeral L157 and L158 quote at $n=12$, $\sup_wt\to\tfrac18$, $(1-\eta^*)^2\to0.808$, the minimum $0.40347$, is computed from the instantiation.

**Reading 5, $\rho^{\mathrm{eff}}$ is itself under debt, so the repair is not available.** True that the $\tfrac29$ is flagged `HYPOTHESIS-DEBT` at line 1225. **It does not save the claim**, because all three readings of the coefficient on the record at $n=12$, $0.74162$, $0.71904$, $0.64003$, are below $1$, so the direction is settled while the magnitude is not. Across those three the inflation at $w=1$ runs from $11.0\%$ to $16.5\%$.

**Reading 6, the coefficient $1$ is defensible as a weaker but valid lower bound.** **True from $n=18$ on, and false at $n\in\{12,14,16\}$**, by the table in §3. The programme's binding dimension is $n=12$.

## What the record would have to change if the candidate stands

**It stands.** The record would have to replace $\sqrt{c_p+w^2}$ by $\sqrt{c_p+\rho^{\mathrm{eff}}_nw^2}$ in four places, [L157](../findings/second-order.md) lines 1257 and 1260, [L149](../findings/second-order.md)'s displayed chain at line 1214, [L158](../findings/second-order.md)'s settled branch-2 display at line 1301, and [results.md](../results.md)'s canonical L157 statement at line 361, and state the substitution once, with its range $n\in\{12,14,16\}$ and the note that from $n=18$ the coefficient $1$ is merely loose. Every $n=12$ numeral computed from $t$ then moves down: $t$ by $8.67\%$ at $w_0=\tfrac23$ and $12.15\%$ at $w=1$, and $\eta^*$, the reach and branch 2 by strictly less, the exponent being $1/\sqrt{4t+1}\in(0,1)$.

**One downstream lower bound fails as stated: [L158](../findings/second-order.md) line 1318's branch-2 minimum $0.40347$ at $w_0=\tfrac23$, $n=12$**, which is a lower bound on the tube radius at the programme's own dimension and is overstated by a factor in $(1,1.0867]$. **The order claims, $r_n\gtrsim n^{-1-\beta}$, the $\Omega(n^{-1})$ ceiling, L149's own $g_\rho\ge0.71979/n$, and L158's conclusion that branch 2 binds, all survive**, the last of them strengthened by the repair.

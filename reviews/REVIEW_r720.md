# REVIEW r720, the branch-2 recomputation with $\rho^{\mathrm{eff}}$ in the numerator

*Gate 2, cold brief, single reviewer. The derivation reviewed is [branch2-recompute.md](/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d494340f-1dff-4003-801d-ae0e180c75c5/scratchpad/branch2-recompute.md), not on the record. **No numerical work was done beyond the permitted screening**: every figure below is a hand evaluation of a constant I was about to record, no script was run, no search or sweep was opened, and the one counterexample is exhibited in closed form at a named parameter value. Log: [r720.log](../agent_logs/r720.log).*

| Claim | Verdict |
| --- | --- |
| **A** ($F'/F=(1/s)(N'/N)-D'/D$ | **CONFIRMED AS ALGEBRA) AND ALREADY ON THE RECORD**, as [L158](../findings/second-order.md)'s settled r715/r716 box, in the same notation up to one letter |
| **B**, the inflation at $w=\tfrac23$, $n=12$ is $\approx1.043$, not $1.0867$ | **CONFIRMED**, at $1.04329$, and it is *stronger* than the derivation claims: it is the factor on the **minimum**, not merely on one abscissa |
| **B (as headlined)**, "about 4.1%" | **REFUTED AS STATED.** The section heading contradicts its own body by $0.2$ percentage points; the body's $1.04328$ is right |
| **C**, branch 2 alone is minimised at $w=1$ | **REFUTED.** On [L158](../findings/second-order.md)'s settled envelope the minimum is exactly the kink $w_0=\tfrac23$, and I prove it in closed form on both sides |
| **C (as argued)**, three point evaluations | **UNPROVEN.** Three points never give monotonicity; the conclusion *is* nevertheless true under the derivation's own superseded envelope, and §4.2 supplies the proof it lacks |
| **The closing reservation** ("says nothing against the record" | **REFUTED) and it is not cautious enough.** $w_0=(n-4)/n$ is a kink *inside branch 2's own denominator*, not a branch crossing; Result 2 therefore collides with the record head-on |

**The one line the cycle can act on.** Only Claim B is new, and it survives in a stronger form than written, the corrected branch-2 minimum at $n=12$ is the recorded one divided by $1.04329$, because the minimiser is fixed by the operator-norm envelope and is therefore the same $w_0=\tfrac23$ under both coefficients, but the derivation's $F$ must first be rewritten on [L158](../findings/second-order.md)'s envelope $\min(a_0n^{-1/2}\sqrt{1-w^2}+w,1)$ rather than the triangle form $a_0n^{-1/2}+w$, and on that envelope Result 2 is false.

## 0. Conventions, fixed once

Throughout, $n=2m$, $n=12$, $m=6$, and every constant is the one the record prints at that dimension.

| Symbol | Meaning here | Value at $n=12$ | Record source |
| --- | --- | --- | --- |
| $\kappa$ | $nc_p=3\sqrt{2(n-1)/(n-2)}=3\sqrt{11/5}$ | $4.4497191$ | [second-order.md](../findings/second-order.md), L158's $\kappa$ box |
| $c_p$ | $\kappa/n=3\theta_0/(n-2)$ | $0.37080993$ | L149, L156's numbers line |
| $\theta_0$ | $\sqrt{55}/6$ | $1.2360331$ | derived from $c_p$ above |
| $a_0$ | $\sqrt{2n/(n-2)}$ | $1.5491933$ | L146 via L149 |
| $b:=a_0n^{-1/2}$ | $\sqrt{2/(n-2)}=1/\sqrt{m-1}$ | $0.4472136$ | L158's r716 box, "one quantity written two ways" |
| $a_0n^{1/2}$ | $n/\sqrt{m-1}=12/\sqrt5$ | $5.3665631$ | same |
| $\lvert\kappa_n\rvert$ | $9(\theta_0-\sqrt{3/2})$ | $0.1015938$ | L133, L134, the ledger |
| $\lambda$ | $2/\sqrt{\lvert\kappa_n\rvert}$, **at finite $n$** | $6.274873$ | L158's threshold box |
| $\rho^{\mathrm{eff}}$ | $2\sqrt{3/2}-\theta_0\tfrac{n+16}{2(n-2)}=\sqrt6-\tfrac7{30}\sqrt{55}$ | $0.7190434$ | L149's margin-coefficient box |
| $C^*$ | $2+\tfrac{4(m-1)}{2m-1}=\tfrac{42}{11}$ | $3.8181818$ | L156's numbers line |
| $J^*$ | $4(1+\alpha^*)/\alpha^{*2}=\tfrac{840}{121}$ | $6.9421488$ | L156's numbers line |
| $\mu$ | $\lambda/(2C^*)$ | $0.8216847$ | composed from the two above |
| $N(w)$ | $\sqrt{c_p+\rho w^2}$ |, | L149's repaired numerator |
| $s$ | $\sqrt{1+4t}$, $t=\mu N$ |, | L157, $1-\eta^*=2/(s+1)$ |
| $D(w)$ | $n\lVert H\rVert_{op}$ |, | see §3.1 |

**A notation collision the reader must be warned of.** [L158](../findings/second-order.md)'s r713/r714-settling box writes $s=\sqrt{c_p+w^2}$, which is this review's $N$; [L157](../findings/second-order.md) and the derivation under review write $s=\sqrt{4t+1}$, which is this review's $s$. The two $s$'s are different quantities in adjacent paragraphs of the same entry. I keep $N$ and $s$ separate and never reuse either letter.

**Two constants I checked and found read at the right dimension**, against the brief's warning that both traps have been sprung here before:

- $\lambda=6.27474$ is the **finite-$n$** value $2/\sqrt{\lvert\kappa_{12}\rvert}$, not the $n\to\infty$ value $1.53$ that [L158](../findings/second-order.md) records as the largest single error in that entry's history. The derivation avoids that trap.
- $J^*=\tfrac{840}{121}$ is simultaneously the **value at $m=6$** and the **infimum of the in-scope interval** $6.9421\le J^*<8$, which [L156](../findings/second-order.md)'s corollary proves is attained at the low end because $J^*$ increases in $m$. The two readings coincide at $n=12$, so no supremum-for-row confusion arises. Likewise $C^*=\tfrac{42}{11}$ sits at the low end of $\tfrac{42}{11}\le C^*<4$. Both are read correctly.

**One constant inherited silently, and it is loose in the unsafe direction.** The prefactor $4\lambda/(\sqrt2 J)$ carries $g_n\approx\sqrt2/n$ where the exact value is $g_n=\sqrt{2(n-2)}/(n\sqrt{n-1})=0.1123675$ against $\sqrt2/12=0.1178511$. [L158](../findings/second-order.md) lists this among "four constants the entry had wrong", at $4.9\%$ **in the unsafe direction** for a lower bound. It is $w$-free, so it cancels from every ratio and from every monotonicity statement in the derivation; it does not cancel from the absolute figures. See §3.4.

**A cross-check that pins $\mu$ independently.** [L156](../findings/second-order.md) records $t\in[0.50036,\,0.96209]$ at $n=12$ from $c_p=0.37081$ and $2J^*\gamma^*=\tfrac{84}{11}$. With $\mu=0.8216847$ and $\rho=1$: $t(0)=\mu\sqrt{c_p}=0.500345$ and $t(1)=\mu\sqrt{1.37081}=0.962093$. The interval reproduces to five digits from the derivation's $\mu$, so $\mu=\lambda/(2C^*)$ is the record's own composition and not a fresh assembly. **This is the strongest single confirmation of Claim B's constant chain**, and the derivation did not notice it was available.

## 1. Claim A, the log-derivative identity

### 1.1 The algebra, step by step

Write $F(w)=N/\big((s+1)^2D\big)$ with $N=N(w)$, $s=s(N(w))$, $D=D(w)$, and $s=\sqrt{1+4\mu N}$ with $\mu$ constant in $w$. Then

$$\log F=\log N-2\log(s+1)-\log D,\qquad \frac{F'}F=\frac{N'}N-\frac{2s'}{s+1}-\frac{D'}D .$$

From $s^2=1+4\mu N$, differentiating gives $2ss'=4\mu N'$, hence $s'=2\mu N'/s$ and

$$\frac{2s'}{s+1}=\frac{4\mu N'}{s(s+1)} .$$

The substitution the brief asks about is $\mu N=(s^2-1)/4$, i.e. $4\mu=(s^2-1)/N$. Applying it,

$$\frac{2s'}{s+1}=\frac{(s^2-1)N'}{N\,s(s+1)}=\frac{(s-1)(s+1)N'}{N\,s(s+1)}=\frac{(s-1)N'}{N\,s},$$

and therefore

$$\frac{F'}F=\frac{N'}N\Big(1-\frac{s-1}s\Big)-\frac{D'}D=\frac1s\frac{N'}N-\frac{D'}D .\qquad\blacksquare$$

### 1.2 Is the substitution legitimate at every $w$?

**Yes, and the reason is that every denominator introduced is bounded away from zero on the whole of $[0,1]$.** The substitution divides by $N$ and cancels $(s+1)$. Both are safe:

- $N=\sqrt{c_p+\rho w^2}\ge\sqrt{c_p}=0.608942>0$ for every $w$, since $c_p>0$. It is smooth in $w$ for the same reason, the square root is never taken at $0$.
- $s=+\sqrt{1+4\mu N}\ge\sqrt{1+4\mu\sqrt{c_p}}=1.732450>1$, so $s+1\ge2.73$ and $s\ne0$.
- $\mu>0$ requires $\lambda>0$ and $C>0$, both of which hold.
- $\mu$ must be **$w$-free** for $s'=2\mu N'/s$. It is, at the level of values: $C^*=2+4(m-1)/(2m-1)$ and $\lambda=2/\sqrt{\lvert\kappa_n\rvert}$ depend on $m$ alone. §5.2 records the one sense in which this is nevertheless an assumption.

**The strongest defence I can find against Claim A, and it fails.** One might object that $s$ is defined through $t=\lambda N/(2C)$ where the record's L157 writes $t=\lambda\sqrt{c_p+w^2}/(2J\gamma)$ with coefficient $1$ on $w^2$, so that substituting $\rho^{\mathrm{eff}}$ inside $t$ as well as inside the numerator is a change of two things at once. It is not: L157's $t$ is $\lambda\sqrt{c}/(2C)$ with $c$ the **margin** $c(H)$, and L149's repaired margin *is* $c_p+\rho^{\mathrm{eff}}w^2$. Carrying $\rho^{\mathrm{eff}}$ into $t$ is the consistent repair; carrying it only into the numerator would be the inconsistent one. The objection fails.

### 1.3 The identity is on the record, and the derivation does not know it

The derivation says the identity "reproduces v36's elasticity $1/\sqrt{4t+1}$ independently, as a by-product rather than a citation." **It is not a verifier's by-product. It is the settled content of [L158](../findings/second-order.md)'s Gate-2 box**, which reads, with $s$ there denoting $\sqrt{c_p+w^2}$:

> Rationalising [L157]'s root to $1-\eta^*=2/(\sqrt{4t+1}+1)$ and writing $s=\sqrt{c_p+w^2}$, $t=\beta s$, $\ \dfrac{\mathrm d\log\big(K(w)\sqrt{c_p+w^2}\big)}{\mathrm d\log s}=\dfrac1{\sqrt{4t+1}}\in(0,1)$ for every $\lambda,J,\gamma$.

The two are the same statement. In this review's letters, $K(w)N\propto N/(s+1)^2$, and §1.1's intermediate line gives $\mathrm d\log(s+1)/\mathrm d\log N=(s-1)/(2s)$, so

$$\frac{\mathrm d\log\big(N/(s+1)^2\big)}{\mathrm d\log N}=1-2\cdot\frac{s-1}{2s}=\frac1s=\frac1{\sqrt{4t+1}} .$$

**Verdict: CONFIRMED AS ALGEBRA, but it is not new.** It is L158's line, restated with the $D$ factor carried along, and the record's version is the stronger one, because it is asserted "for every $\lambda,J,\gamma$" whereas the derivation evaluates at one triple. This is the record's own recurring failure mode: [L158](../findings/second-order.md) records three prior instances of "searching by vocabulary rather than by object" ($\eta$, $\kappa$, and L150's own) and this is a fourth, since the derivation searched for a *derivation* of the elasticity and found a verifier's note rather than the entry that carries it.

## 2. Claim B, the inflation factor

### 2.1 Every constant, checked against the record

I re-derived each from its record source rather than reading the derivation's line.

| Quantity | Derivation | My value | Verdict |
| --- | --- | --- | --- |
| $\kappa=3\sqrt{11/5}$ | $4.4497191$ | $4.4497191$ | correct, exact form correct |
| $c_p=\kappa/12$ | $0.37080993$ | $0.37080993$ | correct; L156 prints $0.37081$ |
| $a_0n^{1/2}=12/\sqrt5$ | $5.3665631$ | $5.3665631$ | correct; and $=n/\sqrt{m-1}$ as written, since $2/(n-2)=1/(m-1)$ |
| $\rho^{\mathrm{eff}}_{12}=\sqrt6-\tfrac7{30}\sqrt{55}$ | $0.71904344$ | $0.7190434$ | correct, and I re-derived the closed form from $2\sqrt{3/2}-\theta_0\tfrac{n+16}{2(n-2)}$ with $\theta_0=\sqrt{55}/6$ |
| $\lambda(12)$ | $6.27474$ | $6.274873$ | correct to five digits, at the **finite** $n$ |
| $C^*=42/11$ | $3.8181818$ | $3.8181818$ | correct, and it is the $m=6$ value, not an interval endpoint borrowed |
| $J^*=840/121$ | $6.9421488$ | $6.9421488$ | correct; $4(1+1.1)/1.21=840/121$ |
| $\mu=\lambda/(2C^*)$ | $0.82168470$ | $0.8216847$ | correct, and independently confirmed by L156's $t$-interval (§0) |

**Every constant is read at the right dimension and from the right entry.** The three traps the brief names (supremum for table row, asymptotic constant at finite $n$, bound rounded the wrong way), are all avoided. The one loose inheritance is $g_n\to\sqrt2/n$ (§0), which is $w$-free.

### 2.2 The two evaluations at $w=\tfrac23$

$D=a_0n^{1/2}+nw=5.3665631+8=13.3665631$, the same in both columns since the envelope does not involve $\rho$.

At $\rho=1$: $N^2=0.37080993+0.44444444=0.81525437$, $N=0.90291437$; $t=\mu N=0.74196$; $s=\sqrt{3.96784}=1.9918836$; $(s+1)^2=8.9513683$; $F=0.90291437/(8.9513683\cdot13.3665631)=0.00754630$.

At $\rho=\rho^{\mathrm{eff}}$: $N^2=0.37080993+0.31957484=0.69038477$, $N=0.83089396$; $t=0.682732$; $s=\sqrt{3.730928}=1.9315610$; $(s+1)^2=8.5940512$; $F=0.83089396/(8.5940512\cdot13.3665631)=0.00723306$.

$$\text{ratio}=\frac{0.00754630}{0.00723306}=1.043289 .$$

The derivation reports $1.04328$. **Confirmed.**

### 2.3 The ratio has a closed form, and $D$ cancels from it exactly

This is worth stating because it is what makes Claim B robust:

$$\frac{F_1}{F_\rho}=\frac{N_1}{N_\rho}\cdot\left(\frac{s_\rho+1}{s_1+1}\right)^{\!2},$$

with **no $D$**. So the factor is independent of which operator-norm envelope is used, the one place in this document where the envelope defect of §3 does not bite. Numerically $1.086678\times(2.9315610/2.9918836)^2=1.086678\times0.9600812=1.043289$.

The derivation's reading of the two pieces is correct: $1.086678=N_1/N_\rho=t_1/t_\rho$ is exactly the record's bracket endpoint $1.0867$, and the elasticity $1/s\approx0.51$ damps it, $1.086678^{0.50976}=1.043302$ against the exact $1.043289$. The derivation's $1.086678^{0.5}=1.042438$ is the same statement with the exponent rounded to $\tfrac12$; it agrees to three significant figures, as claimed, though only to two decimals.

### 2.4 The bracket $(1,\,1.0867]$ was honest, and the derivation reads it right

$1.0867$ is $N_1/N_\rho$ at $w=\tfrac23$, i.e. the factor with the $(1-\eta^*)^2$ correction **omitted**. Since lowering $\rho$ lowers $t$, lowers $s$, and *raises* $(1-\eta^*)^2=4/(s+1)^2$, the second factor runs the other way and the true value falls strictly inside $(1,1.0867]$. So the record's interval is a correct upper bound and the derivation's $1.0433$ is a correct pin inside it. **This part of Claim B is right and is a genuine tightening.**

### 2.5 Robustness to L149's open debt

$\rho^{\mathrm{eff}}$ carries a `HYPOTHESIS-DEBT` in [L149](../findings/second-order.md): the $\tfrac29$ in $\rho^{\mathrm{eff}}=3\theta_0\tfrac{n-8}{2(n-2)}-\tfrac29\lvert\kappa_n\rvert$ requires identifying the $(2,2)$ four-set block with $\Lambda^2\otimes\Lambda^2$, and "nothing on file joins the two decompositions". **The derivation states the value without the debt.** The consequence for Claim B is small and runs the safe way: with the penalty dropped entirely, $\rho=3\theta_0\tfrac{m-4}{2(m-1)}=0.74162$, giving $N_\rho=0.836910$, $t=0.687673$, $s=1.936670$, and

$$\text{ratio}=1.078866\times\left(\frac{2.936670}{2.9918836}\right)^{\!2}=1.078866\times0.963130=1.039091 .$$

**So the inflation factor lies in $[1.0391,\,1.0433]$ across the debt's two readings**, and "about $4.3\%$" is safe to quote only with $\rho^{\mathrm{eff}}$; "about $4\%$" is safe either way. The derivation should say which.

### 2.6 The heading is wrong

> `## RESULT 1, the radius inflation is about 4.1%, not 8.7%`

against its own body's $1.04328$, which is $4.33\%$. **REFUTED AS STATED**: the heading and the body of the same section differ by $0.2$ percentage points. The body is right. A number that appears once in a heading and never again is exactly the kind that survives into the record uncorrected, [L158](../findings/second-order.md) already carries "the figures $0.2793$ and $0.2209$ reproduce from no combination of the record's constants" as the standing example.

### 2.7 The number it corrects is never reproduced

The claim is that the recorded $0.40347$ "is too large by a factor $\approx1.043$". The derivation never evaluates $0.40347$ from its own $F$, and I could not reproduce it either: $n\cdot\text{branch }2$ at $w=\tfrac23$, $\rho=1$ is $0.257873$ with $D=n$ and $0.231497$ with $D=a_0n^{1/2}+nw$, and neither is $0.40347$ under any recombination of $\lambda$, $J^*$, $C^*$, $2J^*$ or $g_n$ I tried by hand. **This does not refute Claim B**, the correction factor is a ratio and is valid whatever normalisation $0.40347$ carries, provided that number was computed from the same functional form at $\rho=1$. It does mean the claim rests on a provenance nobody has checked, and §3.3 shows the recorded number cannot have used the derivation's $D$.

## 3. The envelope, the derivation's central defect

### 3.1 What $D$ is, and what the record says it is

Tracing L158's chain, $\lVert A''\rVert\le2J\lVert H\rVert_{op}/\big((1-\eta)^2g_n\big)$ and branch $2=\lambda\sqrt c/\lVert A''\rVert$, so with $(1-\eta^*)^2=4/(s+1)^2$ and $g_n\approx\sqrt2/n$,

$$\text{branch }2=\frac{4\lambda}{\sqrt2\,J}\cdot\frac{N}{(s+1)^2\,\big(n\lVert H\rVert_{op}\big)},\qquad\text{so }D=n\lVert H\rVert_{op}.$$

The derivation takes $\lVert H\rVert_{op}\le b+w$, giving $D=a_0n^{1/2}+nw$. **That is the triangle form, and [L158](../findings/second-order.md)'s settled Gate-2 box replaces it**:

> **What was wrong is the envelope.** $H_s\perp H_r$ makes $\lVert H_s\rVert_F=\sqrt{1-w^2}$ an *identity* and [L146] is homogeneous, so the admissible envelope is $\lVert H\rVert_{op}\le\min\big(a_0n^{-1/2}\sqrt{1-w^2}+w,\ 1\big)$, crossing $1$ at $w_0=\frac{1-a_0^2/n}{1+a_0^2/n}=\frac{n-4}n$, **never larger than the triangle form**.

Two independent corrections are dropped by the derivation: the homogeneity factor $\sqrt{1-w^2}$, and the cap at $1$. The cap alone is enough to decide Claim C. The record even lists the omission explicitly among "four constants the entry had wrong": "$\lVert H\rVert_{op}\le\min\big(\sqrt{2/(n-2)}+w,\,1\big)$ carries a kink the entry ignored". **The derivation ignores the same kink, and in the harsher of the two available forms**, it drops both r713's kink at $1-1/\sqrt5=0.5528$ and r715's at $\tfrac23$.

### 3.2 The kink algebra, verified

Write $\phi(w)=b\sqrt{1-w^2}+w$ with $b=1/\sqrt{m-1}$. Then $\phi(w)=1$ iff $b\sqrt{1-w^2}=1-w$, iff $b^2(1+w)=1-w$, iff $w=\frac{1-b^2}{1+b^2}$. With $b^2=a_0^2/n=2/(n-2)$ this is $\frac{n-4}{n}$, which at $n=12$ is $\tfrac23$. Directly: $\tfrac1{\sqrt5}\cdot\tfrac{\sqrt5}3+\tfrac23=\tfrac13+\tfrac23=1$. **The record's kink is exact.**

### 3.3 The derivation's $F$ values are not values of branch 2 at the kink

At $w_0=\tfrac23$ the true envelope gives $\lVert H\rVert_{op}=1$ exactly, so $D=n=12$, where the derivation uses $13.3665631$, the triangle form's $1.1139$, which exceeds $\lVert H\rVert_F=1$ and prices a direction the unit sphere has already emptied. **The derivation's $F$ is $11.4\%$ below branch 2's own shape at the very abscissa it evaluates.** The corrected values are $F_1=0.0084057$, $F_\rho=0.0080569$, ratio $1.043277$, the ratio is unmoved, by §2.3, and the absolute figures move by $11.4\%$. This is also why the derivation could not have reproduced $0.40347$ from its own $D$.

### 3.4 Direction of the two inherited looseness

Both run the same way and both are $w$-free at fixed envelope, so neither disturbs §2 or §4:

- $g_n\to\sqrt2/n$ makes branch 2 **$4.9\%$ too large**, unsafe for a lower bound, and the record says so.
- The triangle $D$ makes branch 2 **too small**, safe for a lower bound, which is why [L149](../findings/second-order.md)'s $g_\rho\ge0.71979/n$ stands unaffected. It is wrong only for locating the minimiser, which is what Claim C tries to do.

## 4. Claim C, REFUTED

### 4.1 The refutation, in closed form at $w=\tfrac23$, $n=12$

Take the record's envelope. On $[w_0,1]$, $\lVert H\rVert_{op}=1$ and so $D\equiv n$, whence $D'=0$ and Claim A gives

$$\frac{F'}F\bigg|_{w>w_0}=\frac1s\frac{N'}N=\frac{\rho w}{s\,(c_p+\rho w^2)}\;>\;0 .$$

**Branch 2 is strictly increasing on $(w_0,1]$**, for every $\rho>0$, every $\lambda$, every $J$, the prefactor being $w$-free and the $(1-\eta^*)^2$ decay already inside $F$. So $w=1$ is a **maximum** of branch 2 on that interval, not a minimum.

On $[0,w_0)$, $D=n\phi$ so $D'/D=\phi'/\phi$ with $\phi'(w)=1-bw/\sqrt{1-w^2}$. At $w_0=\tfrac23$, $n=12$: $\phi(w_0)=1$ and

$$\phi'(w_0)=1-\frac1{\sqrt5}\cdot\frac{2/3}{\sqrt5/3}=1-\frac25=\frac35 ,$$

an exact rational. Against it, at $\rho=\rho^{\mathrm{eff}}$,

$$\frac1s\frac{N'}N\bigg|_{w_0}=\frac{0.7190434\cdot\tfrac23}{1.9315610\cdot0.69038477}=\frac{0.4793623}{1.3333410}=0.359519\;<\;0.6 .$$

So $F'/F\to0.359519-0.6=-0.240<0$ as $w\uparrow w_0$, and $F'/F\to+0.359519>0$ as $w\downarrow w_0$. **$w_0=\tfrac23$ is a strict local minimum of branch 2, at a corner where the derivative jumps by exactly $\tfrac35$.** At $\rho=1$ the same computation gives $0.410548<0.6$ and the same conclusion. Both of the derivation's own coefficients.

**Global.** On $[0,w_0]$, $\phi'$ is decreasing and positive ($\phi'>0$ iff $w<\sqrt{5/6}=0.9129$) and $\phi$ is increasing, so $\phi'/\phi$ is decreasing, with minimum $\tfrac35$ at $w_0$. Meanwhile by AM–GM $\frac{\rho w}{c_p+\rho w^2}\le\frac{\sqrt\rho}{2\sqrt{c_p}}$ and $s\ge s_{\min}=\sqrt{1+4\mu\sqrt{c_p}}=1.732450$, so

$$\frac1s\frac{N'}N\;\le\;\frac{\sqrt\rho}{2\sqrt{c_p}\,s_{\min}}=\frac{0.8479643}{2\cdot0.608942\cdot1.732450}=0.401892\;<\;\frac35 ,$$

uniformly on $[0,1]$. Hence $F$ is **strictly decreasing on $[0,w_0)$ and strictly increasing on $(w_0,1]$**: $w_0=\tfrac23$ is the unique global minimiser of branch 2 on $[0,1]$, under both coefficients. At $\rho=1$ the same bound reads $1/(2\sqrt{c_p}\,s_{\min})=0.473950<\tfrac35$.

**This is a proof, not three points**, and it settles the interval the record's r715 argued only above the kink. Claim C is **REFUTED**, and the record's $w_0=(n-4)/n$ is confirmed as the genuine $\arg\min$ of branch 2 alone.

### 4.2 The strongest defence of Claim C, and how far it gets

**The defence.** [L149](../findings/second-order.md)'s own "Proof of the uniformity" writes $g_\rho(w)=\sqrt{c_p+\rho w^2}/(a_0n^{1/2}+nw)$, the triangle form, verbatim, as the record's current text. A derivation that takes L149 at its word is using a printed formula from a `PROVEN` entry.

**How far it gets: the conclusion is true under that formula, and I supply the proof it lacks.** With $D=a_0n^{1/2}+nw$, $D'/D=n/(a_0n^{1/2}+nw)$ is decreasing with minimum at $w=1$, namely $12/17.3665631=0.690983$. Against the uniform bound above, $0.401892<0.690983$ at $\rho=\rho^{\mathrm{eff}}$ and $0.473950<0.690983$ at $\rho=1$. **So $F$ is strictly decreasing on all of $[0,1]$ under the triangle envelope**, with $42\%$ and $31\%$ headroom respectively, and the derivation's Result 2 is correct *about the wrong function*. Its three point evaluations do not establish this; the two-line AM–GM bound does.

**Why the defence fails.** L149's formula is superseded within the same file. [L158](../findings/second-order.md)'s Gate-2 box is dated later, is adjudicated by two reviewers, states the correction as a correction ("What was wrong is the envelope"), and notes that L149 "says so in the very bullet that then drops it". A reader working from L149 alone has an excuse; a derivation that cites $w_0=(n-4)/n$ in its own closing paragraph (as this one does), has read the box that supersedes it.

### 4.3 What would break my refutation

Only a demonstration that $\lVert H\rVert_{op}$ can exceed $1$ on the unit Frobenius sphere, which is false, or that $D$ is not $n\lVert H\rVert_{op}$, which §3.1 traces from the record's own chain. I record the one place where a genuine alternative exists: if the $w$-coupling of $J$ in §5.2 is carried, branch 2 acquires an extra factor $4s/(s+1)^2$ and the elasticity becomes $1+\frac{s^2-1}{2s^2}-\frac{2(s-1)}{s}$, which is $0.401378$ at $w_0$, $\rho^{\mathrm{eff}}$, still strictly positive, so still $0<0.401<0.6$ and the kink is still a minimum. **The refutation survives that variation.**

## 5. Hypotheses the derivation uses and does not state

### 5.1 What $w$ ranges over, and why

$w:=\lVert H_r\rVert_F$ with $\lVert H\rVert_F=1$ and $H=H_s\oplus H_r$ orthogonal, so $w\in[0,1]$ by definition and $\lVert H_s\rVert_F=\sqrt{1-w^2}$ is an **identity**, not a bound. [L158](../findings/second-order.md) records r716 "confirming $w\in[0,1]$". The derivation writes $w$ with no domain and evaluates at $\tfrac23$ and $1$ as if they were free choices. This is not cosmetic: the identity $\lVert H_s\rVert_F=\sqrt{1-w^2}$ is precisely what generates the corrected envelope of §3.1, so stating the domain would have forced the correction.

### 5.2 Is holding $C$ at $C^*$ legitimate while $w$ varies?

**As a value, yes; as a licence, it is an unstated approximation whose error is $w$-dependent.**

$C^*=2+4(m-1)/(2m-1)$ and $\gamma^*=D/4$, $\alpha^*=D/2$ depend on $m$ alone, so no $w$ enters. But [L156](../findings/second-order.md)'s closing paragraph is explicit that $C^*$ and $J^*$ are "the reach's constants **to $O(t^2)$**", and that the licence for using $\gamma^*$ in the reach rather than the reach's own optimum $\gamma^\dagger$ is

$$\frac{J(\gamma^\dagger)}{J(\gamma^*)}=\frac1{1-\eta^{*2}}=\frac{(s+1)^2}{4s},$$

which is **a function of $w$ through $s$**, about $16\%$ at $n=12$. So the derivation's $\mu$ is $w$-free only because a $w$-dependent approximation has been frozen, and it is frozen at a $t$ that L156 itself records as lying in $[0.500,0.962]$: the $O(t^2)$ licence is being invoked at $t\approx0.7$, where $t^2\approx0.5$. **The record calls the error conservative** ($\gamma^*$ gives a smaller reach, so a lower bound stays sound) but "conservative" is a statement about sign, not about a $w$-derivative, and Claim C is a statement about a $w$-derivative. §4.3 checks the variation and finds the verdict unchanged; the derivation should have checked it rather than leaving the reader to.

Verifying L157's root, which the whole $s$-notation rests on: $\eta^*=\frac{2t+1-\sqrt{4t+1}}{2t}$ with $2t=(s^2-1)/2$ gives $\eta^*=\frac{s^2-2s+1}{s^2-1}=\frac{s-1}{s+1}$, hence $1-\eta^*=\frac2{s+1}$ and $1-\eta^{*2}=\frac{4s}{(s+1)^2}$. Both record forms reproduce.

### 5.3 Is $\ker W^*\ne0$ excluded?

**It is excluded, silently, and the record is not unanimous that it can be.** [L149](../findings/second-order.md)'s hypotheses box states $\ker W^*=0$ as used and holding at $W^*=S^m\times S^m$, "without which $W\mapsto W_-$ is not analytic at $W^*$ and branches 2 and 3 have no domain". [L147](../findings/second-order.md)'s box adds the sharper form: "The kernel one has a named witness: $W_{\mathbb{CP}^2}$ is Morse–Bott nondegenerate with $\dim\ker W=3$, so $g_n$, $\rho$, $M$ and branches 2–3 **do not exist there**." The two are consistent (the hypothesis holds *at the base point this chain uses* and fails at another critical point) but the derivation states neither, and it inherits $g_n$, $\rho$, $J$, $C$ and $\eta^*$, every one of which the witness kills. **The base point $W^*=S^m\times S^m$, $n=2m$ even, $n\ge12$, $H\perp W^*$, $H\perp T_{W^*}\mathcal O$ and $\ker W^*=0$ are all load-bearing and all unstated.** [ROUND_L147](../verification/ROUND_L147.md) is on the record precisely for the offence of leaving four of these unstated.

## 6. The closing reservation, REFUTED, and not cautious enough

The derivation closes:

> The record's $w_0=2/3=(n-4)/n$ is a *homogeneity kink*, not a stationary point of branch 2. So the chain's minimum is a minimum of $\min$(branch1, branch2, branch3), and the kink is where branches cross, which is a different object from $\arg\min$ of branch 2. **Result 2 says nothing against the record until that interaction is checked.**

Three things are wrong here, in increasing order of seriousness.

- **"the kink is where branches cross" is false.** $w_0=(n-4)/n$ is where the *operator-norm envelope* $b\sqrt{1-w^2}+w$ meets its own cap $\lVert H\rVert_F=1$. It lives entirely inside branch 2's denominator, and it has nothing to do with branches 1, 2 or 3 meeting one another. [L158](../findings/second-order.md)'s box says so in the sentence that introduces it. The genuine branch-crossing object on the record is [L157](../findings/second-order.md)'s $\eta^*$, at which branch 3 has *already been merged into the prefactor*, which is why L158 records "Why dropping branch 3 is legitimate".
- **"not a stationary point of branch 2" is true but misleading.** It is not a stationary point because $F$ is not differentiable there. It *is* the $\arg\min$, §4.1, reached by a sign change of a one-sided derivative rather than by a vanishing one. Treating non-stationarity as evidence of non-minimality is the error.
- **"says nothing against the record" is therefore not cautious enough.** Result 2 does not sit beside the record awaiting an interaction check; it **contradicts** the record, because it is r714's answer $w=1$, which [L158](../findings/second-order.md)'s Gate-2 box refutes "in general rather than at one dimension". The reservation reads as epistemic humility and functions as camouflage: it stops the reader from noticing that the two answers are answers to the *same* question, differing only in the envelope, and that the record's is the audited one.

The reservation is right about one thing, and it should be kept: $\arg\min$ of branch 2 and the chain's binding direction are distinct objects in general. They coincide here, because [L158](../findings/second-order.md) records "branch 2 beats branch 1 by about $58\times$" at $n=12$ and "branch 2 binds, and provably so at every $n$ up to $\approx1800$". So the chain's minimum *is* branch 2's minimum in the whole range this programme reaches, and the interaction the derivation wants checked is already checked.

## 7. What the record already had, and what is genuinely new

| The derivation's content | Where the record has it |
| --- | --- |
| The elasticity $1/\sqrt{4t+1}$ | [L158](../findings/second-order.md)'s r715/r716 box, verbatim as a $\mathrm d\log/\mathrm d\log$, "for every $\lambda,J,\gamma$" |
| $1-\eta^*=2/(s+1)$ and the rationalised root | [L157](../findings/second-order.md), and L158's box |
| $w_0=(n-4)/n$ as the minimiser | [L158](../findings/second-order.md)'s Gate-2 box, r715 and r716 agreeing |
| The bracket $(1,\,1.0867]$ | [L158](../findings/second-order.md)'s ROUND_L157-D6 box |
| $\rho^{\mathrm{eff}}$ inside the numerator | [L149](../findings/second-order.md)'s margin-coefficient box |
| **The pinned factor $1.04329$ at $w_0$** | **nowhere, this is the contribution** |
| **That the factor applies to the minimum, not just to one abscissa** | **nowhere, and it is not in the derivation either**, §8 |

## 8. The result the derivation should have written

Everything checked above composes into one clean statement, and it is strictly better than either of the derivation's two:

> **At $n=12$, the correction from coefficient $1$ to $\rho^{\mathrm{eff}}_{12}$ multiplies the branch-2 *minimum* by $1/1.04329$, not by $1/1.0867$, and the minimiser does not move.**

The proof is three lines. The minimiser is $w_0=(n-4)/n$ under both coefficients, by §4.1, because the kink is set by the operator-norm envelope, which does not involve $\rho$; the ratio of the two minima is therefore the ratio at the common abscissa $w_0$; and that ratio is $\frac{N_1}{N_\rho}\big(\frac{s_\rho+1}{s_1+1}\big)^2=1.043289$, in which $D$ cancels, so the envelope defect of §3 does not reach it.

**The corrected minimum owed by [L158](../findings/second-order.md) is thus $0.40347/1.04329=0.38673$**, subject to the two provisos that $0.40347$'s own provenance is unreproduced (§2.7) and that the debt on $\rho^{\mathrm{eff}}$'s $\tfrac29$ moves the divisor to $1.0391$ if resolved the other way (§2.5). That the minimiser is $\rho$-free is the reason Claim B is safe *despite* Claim C being false, rather than *modulo* it, and the derivation, having got Claim C wrong, could not have known its own Claim B was on firm ground.

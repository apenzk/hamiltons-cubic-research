# Verifier v13, L149's two inputs, its branch-2 uniformity proof, and the three clauses of its statement box

Checked: the operator-norm bullet $\lVert H\rVert_{op}\le\Theta(n^{-1/2})+w$; the margin bullet $c(H)\ge c_p+3\theta_0\frac{m-4}{2(m-1)}w^2$ and the range sentence around it; the penalised coefficient $\rho_n^{\mathrm{eff}}$ and its $\lvert\kappa_n\rvert$; the "Proof of the uniformity" and its displayed minimum; and each of the three clauses of the LEMMA L149 box.

Cold from the brief in [ROUND_L149.md](ROUND_L149.md), worked from the definitions. **I did no numerical work: no script was run, and every value below is exact arithmetic on closed forms carried by hand.** Where I quote a decimal it is a rounding of an exact expression I give alongside it. Log: [agent_logs/verify-L149-v13.log](../agent_logs/verify-L149-v13.log).

**One thing about the dispatch before the table.** The fenced block as first dispatched ended mid-sentence ("*so $g$ has a single interior minimum at $w^*=Bc/A=\kappa n^{-1/2}$, where*"), [findings/second-order.md](../findings/second-order.md):1213 being the last line quoted, with the proof's displayed value and endpoint check at 1214–1215. So there was no proof of the headline claim inside the brief. I read [findings/second-order.md](../findings/second-order.md):1214–1221 to obtain one, and ignored the provenance the brief had stripped. The round has since supplied those two lines as a correction to the brief; **they are verbatim the lines I had recovered, and §5.1–5.3 below are the check of them.** Nothing in this report moves as a result.

## The claim table

| # | Claim, as written | Verdict | Reason |
|---|---|---|---|
| C1 | $\lVert H\rVert_{op}\le\lVert H_s\rVert_{op}+\lVert H_r\rVert_{op}\le\Theta(n^{-1/2})+w$ | **CONFIRMED** | triangle inequality plus [L146](../findings/second-order.md); the constant is $1/\sqrt{m-1}$ |
| C2 | "no $\sqrt2$ is owed", the two-copy application of a one-copy lemma | **CONFIRMED** | in-block branch $1/\sqrt{m-1}$ beats cross-plane $\sqrt{m-2}/m$ at every $m\ge3$, not only $n=12$ |
| C3 | $c(H)\ge c_p+3\theta_0\frac{m-4}{2(m-1)}w^2$ | **CONFIRMED** | $(m-4)$ is exactly $\mu_{\min}-c_p$; the bound is an equality on every $S^2_0/\Lambda^2\!\otimes\!\Lambda^2$ mixture |
| C4 | the range sentence: $+\mu$ margin $3\theta_0\frac{m-3}{2(m-1)}$, zero at $m=3$, ties $c_p$ at $m=4$, $\ge\frac34\theta_0$ from $m=5$ | **CONFIRMED** | matches [L27](../findings/nondegeneracy.md)+[L26](../findings/nondegeneracy.md)'s $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$ exactly |
| C5 | $\rho_n^{\mathrm{eff}}=3\theta_0\frac{n-8}{2(n-2)}-\frac29\lvert\kappa_n\rvert$ | **CONFIRMED AS ALGEBRA** | reconstructs as $\mu_{\min}^{\text{pen}}-c_p$ from [L134](../findings/second-order.md):949's $\tfrac29$; all four printed values reproduce to five figures |
| C6 | $\lvert\kappa_n\rvert=9(\theta_0(n)-\sqrt{3/2})$, under "for $m\ge5$" | **REFUTED AS STATED** | negative at $n=10$, which $m\ge5$ admits and the entry itself evaluates; [L133](../findings/second-order.md) proves the constant only for $n\ge12$ |
| C7 | branch 2 is $\Omega(n^{-1})$ uniformly in $w\in[0,1]$ | **CONFIRMED** | the stationary value lower-bounds $g$ on all of $w\ge0$, so the order survives $w^*\notin[0,1]$ |
| C8 | "$g$ has a single interior minimum at $w^*$", with the endpoints as the comparison | **REFUTED AS STATED** | $w^*=\kappa n^{-1/2}>1$ for every $n\le19$; on $[0,1]$ the minimiser is the endpoint $w=1$ |
| C9 | the displayed value $g(w^*)=\frac1n\sqrt{\kappa/(1+\kappa)}$ | **REFUTED AS STATED** | $A=n^{1/2}$ discards the record's own $\lVert H_s\rVert_{op}\le1/\sqrt{m-1}$; a lower bound stated upward by $12.1\%$ at $n=12$ |
| C10 | "the first is minimised at $w=0$" | **REFUTED AS STATED** | [L147](../findings/second-order.md)'s branch 1 is $(c_p+u^2)/(S+au)$ with $f'(0)<0$; $u=0$ is never its minimum |
| C11 | "the validity branch is $\Omega(n^{-1})$ as well" | **CONFIRMED** | on the unstated $g_n=\Theta(n^{-1})$, i.e. on $\ker W^*=0$ |
| C12 | $r_n\gtrsim n^{-1-\beta}$ over every direction, $\Theta(n^{-1})$ the ceiling | **CONFIRMED** | at order level, for **even** $n$ only, and using $\beta\ge0$ eight lines before the entry supplies it |
| C13 | "a valid but lossy lower bound, $15.5\%$ low at $n=12$" | **NO ARGUMENT ON FILE** | unreproduced under all four readings of the reference value I could construct from the entry's own quantities |
| C14 | the headline chain $\lVert A''\rVert=\Theta(n)\Rightarrow\dots\Rightarrow c(H)=\Theta(1)$ | **CONFIRMED** | it is C1 and C3 read contrapositively; the refuted counterexample direction genuinely does not exist |

## One-line summary

The lemma's order conclusion $r_n\gtrsim n^{-1-\beta}$ and both of its two inputs are correct and, in the margin bullet's case, exactly tight, but the second clause of the statement box is refuted by the record's own [L147](../findings/second-order.md), the proof's displayed minimum is a lower bound stated upward by $12\%$, and the stated range $m\ge5$ reaches one dimension below where the penalty constant it carries is defined.

## 0. Conventions, fixed once

Quoted or fixed from the brief and from the sources it names:

- $n=2m$, the base point $W^*=S^m\times S^m$ with $p=q=m$ ([L146](../findings/second-order.md)'s "Setting", which fixes $n=2m$ in its own box).
- $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ ([conventions.md](../findings/conventions.md), as quoted at [bispectral.md](../findings/bispectral.md):270). $\theta_0\uparrow\sqrt2$.
- $\lambda_m=(m-2)/(2(m-1))$, the $L_e$-eigenvalue on each $S^2_0(\mathbb R^m)$ copy; $c_p=3\theta_0(\tfrac12-\lambda_m)=3\theta_0/(n-2)$.
- $\kappa:=nc_p=3\theta_0n/(n-2)$, the $\kappa$ of "$c=\kappa/n$" in the proof.
- $\kappa_n=9(\sqrt{3/2}-\theta_0(n))$, the quartic-tail constant of [L133](../findings/second-order.md):894, **a different quantity from $\kappa$**, as [L158](../findings/second-order.md):1276 itself records.
- $H=H_s+H_r$ on $\lVert H\rVert_F=1$, $H_s$ in the joint $\lambda_m$-eigenspace of **both** $S^2_0$ copies, $w:=\lVert H_r\rVert_F\in[0,1]$.
- $S:=\sup\lvert P\rvert=\Theta(n^\beta)$; $\rho$ carries two meanings in the entry (§7.6).

## The hypothesis inventory

**Carried by the statement.**

| Hypothesis | Used where | Status |
|---|---|---|
| $m\ge5$ | twice: for $\rho_n>0$ (C3's coefficient vanishes at $m=4$) and for the $\lambda_m$-eigenspace to be exactly the two $S^2_0$ copies | **used, and load-bearing both times** |
| $w\in[0,1]$ | the uniformity range | used |
| $\lVert H\rVert_F=1$ | the convex-combination step | used |
| $S=\Theta(n^\beta)$ | branch 1 and the conclusion | used; $\beta\ge0$ is used and not stated (§7.5) |

**Imported, with the object each is applied to.**

| Import | Its hypotheses | Checked against the object? |
|---|---|---|
| [L27](../findings/nondegeneracy.md), ten summands, $L_e$ scalar on each, $E(\tfrac12)=$ orbit | $p,q\ge3$, $(p,q)\ne(3,3)$ | **yes**: $p=q=m\ge5$ satisfies both |
| [L26](../findings/nondegeneracy.md), $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$ | $p,q\ge3$ | yes |
| [L146](../findings/second-order.md), $\lVert H\rVert_{op}$ on one $S^2_0$ copy, sup $1/\sqrt{m-1}$ | $H$ the Weyl image of $h\in S^2_0(\mathbb R^m)$, $\lVert H\rVert_F=1$, $n=2m$, $m\ge5$ | **applied to a two-copy space its statement does not cover**; the extension is claimed and I verified it independently (§2) |
| [L148](../findings/second-order.md), defect $\equiv0$ on the margin summand | $H\in S^2_0(\mathbb R^m)$ at $W^*$ | yes; used for $u\le w$ and for the $\Omega$-not-$\Theta$ remark |
| [L134](../findings/second-order.md):949, the $\tfrac29$ support bound | derived at $W^*$, $n=2m\ge12$ | **range overrun**: L149 claims $m\ge5$, i.e. $n\ge10$ (§4) |
| [L133](../findings/second-order.md):894, $\kappa_n=9(\sqrt{3/2}-\theta_0(n))$ | stated "for every $n\ge12$" | **range overrun**, and the sign inverts below it (§4) |
| $\rho(H)=g_n/\lVert H\rVert_{op}$, $g_n=\Theta(n^{-1})$ | $W^*$ has spectral gap $\Theta(n^{-1})$, i.e. $\ker W^*=0$ | **never stated in L149** (§6) |
| [L147](../findings/second-order.md), $\beta\in[0,\tfrac12]$ | $\sup\lvert P\rvert\ge P(W^*)=\theta_0$ | **the range is not restated in L149** (§7.5) |

**Stated but unused.** The swap argument ("*the swap of the factors fixes $W^*$ and commutes with $L_e$*"), is offered as the reason both copies carry $\lambda_m$. [L27](../findings/nondegeneracy.md)'s list already assigns $\lambda_p$ to $S^2_0(\mathbb R^p)$ and $\lambda_q$ to $S^2_0(\mathbb R^q)$, which are equal at $p=q$. The swap is therefore redundant rather than wrong. **No finding**, recorded because an inventory that reports only the used hypotheses is not an inventory.

## 1. The margin bullet, and why its $(m-4)$ is right

The entry writes $3\theta_0\frac{m-3}{2(m-1)}$ for the smallest off-summand margin in one sentence and $3\theta_0\frac{m-4}{2(m-1)}$ as the coefficient in the display one sentence earlier. I opened this as a contradiction and closed it: they are two different quantities and both are exact.

From [L27](../findings/nondegeneracy.md), at $p=q=m$ the ten $L_e$-eigenvalues are $1$ on $\langle W\rangle$; $\tfrac12$ on the orbit; $\lambda_m$ on each $S^2_0(\mathbb R^m)$; $+\mu$ on $\Lambda^2\!\otimes\!\Lambda^2$; $-\mu$ on $S^2_0\!\otimes\!S^2_0$; $0$ on $\mathrm{Weyl}_p$, $\mathrm{Weyl}_q$, $X_p\!\otimes\!\mathbb R^q$, $X_q\!\otimes\!\mathbb R^p$. With margin $3\theta_0(\tfrac12-\lambda)$ and [L26](../findings/nondegeneracy.md)'s $\tfrac12-\mu=\frac{(m-2)^2-1}{2(m-1)^2}=\frac{(m-1)(m-3)}{2(m-1)^2}=\frac{m-3}{2(m-1)}$, the margins written over the common denominator $2(m-1)$ have numerators

$$c_p\leftrightarrow1,\qquad \Lambda^2\!\otimes\!\Lambda^2\leftrightarrow m-3,\qquad \text{the four zero summands}\leftrightarrow m-1,\qquad S^2_0\!\otimes\!S^2_0\leftrightarrow m+1,$$

with $\langle W\rangle$ negative and the orbit zero, both removed by the domain $T_{W^*}S\cap T_{W^*}\mathcal O^\perp$, the first because $T_{W^*}S=W^{*\perp}$, the second because [L27](../findings/nondegeneracy.md) puts $E(\tfrac12)$ **exactly** on the orbit tangent. So $\mu_{\min}=3\theta_0\frac{m-3}{2(m-1)}$, which is the entry's range sentence, verbatim and correct: zero at $m=3$; equal to $c_p$ at $m=4$ (numerators $1$ and $1$); $=\tfrac34\theta_0$ at $m=5$ (numerator $2$ over $8$).

The decomposition is multiplicity-free and $L_e$ is scalar on each summand, so the form is block-diagonal and $c(H)=\sum_j\mu_j\lVert H_j\rVert^2$. Splitting at the two $S^2_0$ copies,

$$c(H)\ \ge\ c_p(1-w^2)+\mu_{\min}w^2\ =\ c_p+(\mu_{\min}-c_p)w^2,\qquad \mu_{\min}-c_p=3\theta_0\frac{(m-3)-1}{2(m-1)}=3\theta_0\frac{m-4}{2(m-1)}.$$

**The bullet's coefficient is exactly $\mu_{\min}-c_p$.** The two numbers are the summand margin and the coefficient of $w^2$ in the same bound, and the entry uses each in its own place. **CONFIRMED**, and tight: on $H=\alpha H_{S^2_0}+\beta H_{\Lambda^2\otimes\Lambda^2}$ with $\alpha^2+\beta^2=1$ the inequality is an equality at every $\beta$.

**Withdrawn candidate, "the bound should read $\mu_{\min}-c_p$".** It does. Reason for withdrawal: I mistook the $(m-3)$/$(m-4)$ pair for a contradiction before computing $\mu_{\min}-c_p$.

**Witness sweep over the structured family the record names.** One unit vector from each admissible summand, against the bound $c_p+3\theta_0\frac{m-4}{2(m-1)}w^2$:

| Witness | $w$ | $c(H)$, numerator over $2(m-1)$ | bound, same units | verdict |
|---|---|---|---|---|
| $S^2_0(\mathbb R^m)$, copy 1 | $0$ | $1$ | $1$ | equality |
| $S^2_0(\mathbb R^m)$, copy 2 | $0$ | $1$ | $1$ | equality, the direction that refuted the singular reading |
| $\Lambda^2\!\otimes\!\Lambda^2$ | $1$ | $m-3$ | $1+(m-4)=m-3$ | equality, attained |
| $\mathrm{Weyl}_p$ / $X_p\!\otimes\!\mathbb R^q$ | $1$ | $m-1$ | $m-3$ | slack $2$ |
| $S^2_0\!\otimes\!S^2_0$ | $1$ | $m+1$ | $m-3$ | slack $4$ |
| equal mix of copy 1 and $\Lambda^2\!\otimes\!\Lambda^2$ | $1/\sqrt2$ | $\tfrac12(1+(m-3))$ | $1+\tfrac12(m-4)$ | equality |

No witness violates it, and three attain it. Padded, subalgebra-Casimir, $\mathbb{CP}^m$ and torus objects are out of scope by construction: the statement is at the single base point $W^*$ and quantifies only over directions $H$ there.

**The $m\ge5$ range, checked at its own edge.** The joint $\lambda_m$-eigenspace is exactly the two $S^2_0$ copies only if no other summand shares $\lambda_m=(m-2)/(2(m-1))$. Against the list: $\lambda_m=1$ needs $m=0$; $\lambda_m=\tfrac12$ never; $\lambda_m=-\mu<0$ never for $m\ge3$; $\lambda_m=0$ needs $m=2$; and $\lambda_m=+\mu=1/(m-1)$ needs **$m=4$ exactly**. So at $m=4$ the $\Lambda^2\!\otimes\!\Lambda^2$ summand merges into $H_s$, which is the same dimension at which the entry's coefficient $(m-4)$ vanishes, and the same dimension its last blockquote names as the degradation point. The three facts are one fact, and $m\ge5$ is the right cut. **No finding.**

## 2. The operator-norm bullet, and the "$\sqrt2$" the entry says is not owed

The entry justifies applying a one-copy lemma to the two-copy eigenspace with a comparison quoted at $n=12$ only: "*the cross-plane branch reaching only $\sqrt{m-2}/m=0.333$ against $1/\sqrt{m-1}=0.447$*". A claim about all $m\ge5$ resting on one dimension is the shape this record's trap list warns about, so I derived it in closed form.

Take $H=H_1+H_2$, $H_i$ the Weyl image of $h\in S^2_0$ on block $B_1$ and $h'\in S^2_0$ on $B_2$. [L146](../findings/second-order.md)'s corrected embedding gives, for one copy, $\alpha h_a$ on $e_a\wedge e_b$ ($a\in B_1$, $b\in B_2$), $-\beta(h_a+h_{a'})$ on $e_a\wedge e_{a'}$ inside $B_1$, and $0$ inside $B_2$, with $\alpha=\frac{m-2}{2(m-1)}$, $\beta=\frac m{2(m-1)}$. Both copies are diagonal in the same frame, so the sum is, with eigenvalues

$$\text{inside }B_1:\ -\beta(h_a+h_{a'});\qquad \text{inside }B_2:\ -\beta(h'_b+h'_{b'});\qquad \text{cross}:\ \alpha(h_a+h'_b).$$

*In-block branch.* Depends on one copy only, so its supremum over the joint space is [L146](../findings/second-order.md)'s own $1/\sqrt{m-1}$, attained by putting the whole Frobenius budget in one copy.

*Cross branch.* $\lVert H\rVert_F^2=\frac{m(m-2)}{2(m-1)}(\lVert h\rVert^2+\lVert h'\rVert^2)$ by Hilbert–Schmidt orthogonality of the two images, so on $\lVert H\rVert_F=1$, $\lVert h\rVert^2+\lVert h'\rVert^2=\frac{2(m-1)}{m(m-2)}$. For traceless diagonal $h$, $\max_a\lvert h_a\rvert\le\sqrt{(m-1)/m}\,\lVert h\rVert$. Hence

$$\alpha\max_{a,b}\lvert h_a+h'_b\rvert\ \le\ \frac{m-2}{2(m-1)}\sqrt{\tfrac{m-1}m}\,(\lVert h\rVert+\lVert h'\rVert)\ \le\ \frac{m-2}{2(m-1)}\sqrt{\tfrac{m-1}m}\cdot\sqrt2\cdot\sqrt{\tfrac{2(m-1)}{m(m-2)}}\ =\ \frac{\sqrt{m-2}}m .$$

That is the entry's $\sqrt{m-2}/m$, exactly, and it reproduces $2/6=0.333$ at $m=6$. The two branches compare as $\frac{m-2}{m^2}$ against $\frac1{m-1}$, i.e. $(m-2)(m-1)=m^2-3m+2<m^2$, **strict at every $m\ge3$, not only at $n=12$**. So the in-block branch wins throughout, the joint supremum equals the one-copy supremum, and no $\sqrt2$ is owed. **C1 and C2 CONFIRMED**, with the closed form the entry left at one dimension.

The rest of C1 is $\lVert H_r\rVert_{op}\le\lVert H_r\rVert_F=w$, standard for a symmetric operator on $\Lambda^2$ but not stated; and homogeneity of [L146](../findings/second-order.md) so $\lVert H_s\rVert_F\le1$ only helps, which is right since $\lVert H\rVert_{op}$ is $1$-homogeneous.

## 3. $\rho_n^{\mathrm{eff}}$, reconstructed

I could not find the factor $\tfrac29$ derived anywhere in the entry, so I traced it. [L134](../findings/second-order.md):949 gives, on the $(2,2)$ four-set blocks, $Q/\lVert H\rVert^2=3\theta_0(2\mu s-\mu-\tfrac12)+\tfrac29\lvert\kappa_n\rvert s$ with the support bound $\sigma\le\tfrac29$. Reading the penalised margin as $-Q/\lVert H\rVert^2$ at $s=1$ gives $3\theta_0(\tfrac12-\mu)-\tfrac29\lvert\kappa_n\rvert=\mu_{\min}^{\text{pen}}$, and by §1 the coefficient of $w^2$ is $\mu_{\min}^{\text{pen}}-c_p$, the penalty landing on $\Lambda^2\!\otimes\!\Lambda^2$ and not on $c_p$ ([L148](../findings/second-order.md) empties the defect on the margin summand). So

$$\mu_{\min}^{\text{pen}}-c_p=3\theta_0\frac{(m-3)-1}{2(m-1)}-\tfrac29\lvert\kappa_n\rvert=3\theta_0\frac{n-8}{2(n-2)}-\tfrac29\lvert\kappa_n\rvert=\rho_n^{\mathrm{eff}},$$

which is the entry's display, term for term. **CONFIRMED AS ALGEBRA.**

All four printed values reproduce. With $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$: $\theta_0(12)=\sqrt{220}/12$, $\theta_0(14)=\sqrt{312}/14$, $\theta_0(16)=\sqrt{420}/16$, giving $\rho^{\mathrm{eff}}=0.719044$, $0.872389$, $0.985639$ against the entry's $0.71904$, $0.87239$, $0.98564$; and $\tfrac32\sqrt2-2(\sqrt2-\sqrt{3/2})=1.742379$ against $1.74238$.

### 3.1 Withdrawn candidate, "the entry subtracts $\lvert\kappa_n\rvert$ in one place and $\tfrac29\lvert\kappa_n\rvert$ in another"

*Located*: the display $\rho_n^{\mathrm{eff}}=3\theta_0\frac{n-8}{2(n-2)}-\frac29\lvert\kappa_n\rvert$ against "The penalty term, which had no account", which says "*the net coefficient is $\tfrac32\theta_0-\lvert\kappa_n\rvert\to2.1213-1.7053=0.416$*". Both limits are of the same object, since $3\theta_0\frac{n-8}{2(n-2)}\to\tfrac32\theta_0$.

*Charitable reading, which holds*: the two are the $s=1$ and $s\le\tfrac29$ readings of the same support parameter. $\tfrac32\theta_0-\lvert\kappa_n\rvert\le\tfrac32\theta_0-\tfrac29\lvert\kappa_n\rvert$, so the paragraph states a **cruder but valid** positivity, and the display carries the sharp one. Both are positive at every $n$ in range. **Withdrawn.** What survives is a wording objection only: two different numbers are each called "the coefficient", with the definite article, twelve lines apart.

## 4. $\lvert\kappa_n\rvert$ at the smallest admissible dimension, REFUTED AS STATED

*Located.* The display $\lvert\kappa_n\rvert=9\big(\theta_0(n)-\sqrt{3/2}\big)$, under a lemma whose stated range is "For $m\ge5$", i.e. $n\ge10$, a range the entry itself exercises, quoting $w^*=3.16$ "at $n=10$".

*Exhibited, in closed form.* At $m=5$, $n=10$:

$$\theta_0(10)=\frac{\sqrt{2\cdot9\cdot8}}{10}=\frac{\sqrt{144}}{10}=\frac{6}{5}\ \text{exactly},\qquad \frac65<\sqrt{\tfrac32},$$

since $(6/5)^2=36/25=1.44<1.5$. So $9\big(\theta_0(10)-\sqrt{3/2}\big)=\tfrac{54}5-9\sqrt{3/2}=-0.222494\dots<0$: the right-hand side of an equation whose left-hand side is an absolute value is negative. The crossing is at $\theta_0(n)^2=\tfrac32$, i.e. $n^2-12n+8=0$, $n=6+2\sqrt7=11.2915\dots$, so the expression is a magnitude only from $n\ge12$. This matches the record's own signed definition, $\kappa_n=9(\sqrt{3/2}-\theta_0(n))$ at [L133](../findings/second-order.md):894, which is **negative** for $n\ge12$ and positive at $n=10$; L149's expression is $-\kappa_n$, which equals $\lvert\kappa_n\rvert$ only above the crossing.

*The opposite argued.* Read as $\lvert\kappa_n\rvert=9\lvert\theta_0(n)-\sqrt{3/2}\rvert$ and the entry is repaired at no cost: $\lvert\kappa_{10}\rvert=0.222494$ and $\rho_{10}^{\mathrm{eff}}=3\cdot\tfrac65\cdot\tfrac2{16}-\tfrac29(0.222494)=0.45-0.049443=0.400557>0$, so the $\Omega(n^{-1})$ conclusion is untouched. Alternatively the intended range is $n\ge12$, which the $\rho^{\mathrm{eff}}$ table's starting point suggests and which both [L133](../findings/second-order.md) ("for every $n\ge12$") and [L134](../findings/second-order.md) ("$n=2m\ge12$") state as the range in which the imported constant is proved.

**The finding stands under either repair**, because the defect is in the range statement rather than the number: **L149 claims $m\ge5$ and carries a constant its own sources establish only for $n\ge12$.** The conclusion survives; the stated range does not. All three of the trap list's edge items, the boundary of the stated interval, the smallest admissible dimension, and an imported theorem's hypotheses, meet at this one line.

## 5. The uniformity proof

### 5.1 The algebra, which is correct

$g(w)=\sqrt{c+w^2}/(A+Bw)$. Then $\frac{d}{dw}\log g=\frac w{c+w^2}-\frac B{A+Bw}$, which vanishes iff $w(A+Bw)=B(c+w^2)$, iff $wA=Bc$. So $\operatorname{sign}g'=\operatorname{sign}(wA-Bc)$ ✓ and $w^*=Bc/A$ is a minimum ✓. At $w^*$: $c+w^{*2}=c(A^2+B^2c)/A^2$ and $A+Bw^*=(A^2+B^2c)/A$, so

$$g(w^*)=\frac{\sqrt c}{\sqrt{A^2+B^2c}}\ \checkmark,\qquad\text{and with }A=n^{1/2},B=n,c=\kappa/n:\quad A^2+B^2c=n(1+\kappa),\quad g(w^*)=\frac1n\sqrt{\frac\kappa{1+\kappa}}\ \checkmark.$$

Endpoints: $g(0)=\sqrt{\kappa/n}/\sqrt n=\sqrt\kappa/n$ ✓ and $g(1)=\sqrt{1+\kappa/n}/(n^{1/2}+n)\asymp1/n$ ✓. Every line of the proof's algebra checks.

**C7 CONFIRMED.** $g(w^*)$ is the infimum over all $w\ge0$, hence a lower bound on $[0,1]$ whatever $w^*$ is; and with the repaired coefficient, $\sqrt{c+\rho w^2}/(A+Bw)$ has minimum $\sqrt{c\rho}/\sqrt{\rho A^2+B^2c}=\frac1n\sqrt{\frac{\kappa(n-8)}{3n-8}}$, I get the entry's closed form exactly, from $\kappa/\rho=\frac{3\theta_0n}{n-2}\cdot\frac{2(n-2)}{3\theta_0(n-8)}=\frac{2n}{n-8}$, with $\theta_0$ cancelling as the entry says. Since $n-8\ge2$ for $n\ge10$, this is $\Theta(n^{-1})$. **Branch 2 is $\Omega(n^{-1})$ uniformly in $w\in[0,1]$.**

### 5.2 "a single interior minimum", REFUTED AS STATED

*Located.* "*so $g$ has a single interior minimum at $w^*=Bc/A=\kappa n^{-1/2}$*", followed by "*The endpoints give $\sqrt\kappa/n$ and $\asymp1/n$*", a three-point comparison that is the structure of a minimisation over $[0,1]$.

*Exhibited.* $\kappa=3\theta_0n/(n-2)=3\sqrt2\sqrt{n-1}/\sqrt{n-2}$, so $w^*=\kappa n^{-1/2}=3\sqrt2\sqrt{n-1}/(\sqrt{n-2}\sqrt n)$. At $n=12$: $3\sqrt2\sqrt{11}/(\sqrt{10}\sqrt{12})=1.28454>1$. At $n=18$: $1.03083>1$. At $n=20$: $0.97468<1$. So $w^*>1$ for every $n\le19$ and the stationary point lies **outside** the domain $[0,1]$ at every dimension the record works in. On $[0,1]$, $g'<0$ throughout, so $g$ is strictly decreasing and its minimiser is the endpoint $w=1$.

*The opposite argued.* "Interior" may mean interior to $(0,\infty)$ rather than to $[0,1]$, and the conclusion drawn ("*the branch never leaves that order*"), is an order statement that $g(w^*)$ supports regardless. That reading rescues C7 and does not rescue C8: the sentence names $w^*$ as the minimum and then compares it against the endpoints, which is only a minimisation if $w^*$ is admissible. The entry's own later blockquote says exactly this for the repaired coefficient ("*the stationary point is outside $[0,1]$ at every dimension in range*") and the proof paragraph, which is what proves the lemma, was not brought into line with it.

### 5.3 The displayed value $\frac1n\sqrt{\kappa/(1+\kappa)}$, REFUTED AS STATED

*Located.* "*With $g(w)=\sqrt{c+w^2}/(A+Bw)$, $c=\kappa/n$, $A=n^{1/2}$, $B=n$*".

*Exhibited.* $A$ is fixed by $\lVert A''\rVert\le\Theta(n)\lVert H\rVert_{op}$ and bullet 1, so $A=\Theta(n)\cdot\sup\lVert H_s\rVert_{op}$. The record's own value for that supremum is [L146](../findings/second-order.md)'s $1/\sqrt{m-1}=\sqrt2/\sqrt{n-2}$, giving

$$A=\frac{n\sqrt2}{\sqrt{n-2}}\quad\text{rather than}\quad A=n^{1/2},\qquad\text{a factor }\sqrt{\frac{2n}{n-2}}=1.5492\ \text{at }n=12.$$

Since $g$ decreases in $A$, taking $A$ too small makes $g(w^*)$ too **large**, a lower bound stated upward. Exactly, at $n=12$ with $c=c_p=3\theta_0(12)/10=\sqrt{220}/40$: with $A^2=12$, $A^2+B^2c=12+144c=65.3966$ and $g(w^*)=0.0752945$; with $A^2=2n^2/(n-2)=28.8$, $A^2+B^2c=82.1966$ and $g(w^*)=0.0671675$. The displayed value **overstates the branch-2 minimum by $12.10\%$**. It also moves the stationary point: $w^*=Bc/A=3\sqrt{n-1}/n=3\sqrt{11}/12=0.82916$ under the record's constant, admissible, against $1.28454$, not.

*The opposite argued.* Every constant in the two bullets is written as $\Theta(\cdot)$, so the proof may intend only the order, which it states ("*never leaves that order*"). But the entry then spends the value: it computes ratios from it, calls the closed form "$15.5\%$ low", and [L158](../findings/second-order.md) carries "the branch-2 prefactor $K$" into a dimension-free comparison. A constant that is used is a constant that is claimed. The order-level reading holds; the displayed number does not.

## 6. Branch 3, and where the kernel enters

"*Hence $\lVert A''\rVert=O(1/\rho)=O(n^{1/2}+nw)$*" is two steps. The second is bullet 1 times $\Theta(n)$. The first needs $1/\rho(H)\le\Theta(n)\lVert H\rVert_{op}$, i.e. $\rho(H)\ge g_n/\lVert H\rVert_{op}$ with $g_n=\Theta(n^{-1})$, [L146](../findings/second-order.md)'s "analyticity disc $g_n/\lVert H\rVert_{op}$", **not stated in L149**. Given it, branch 3 is $\rho(H)/2\ge g_n/(2(\Theta(n^{-1/2})+1))=\Omega(n^{-1})$ ✓ **C11 CONFIRMED**.

**This is where $\ker W\ne0$ reaches the lemma.** $\rho(H)$ is the radius on which $s\mapsto W(s)_-$ is analytic, and $x\mapsto x_-$ is non-smooth at $0$: the disc is limited by the first eigenvalue crossing, so $g_n>0$ is a spectral-gap hypothesis on $W^*$, i.e. **$\ker W^*=0$**. L149 states no such hypothesis. It is supplied upstream, and the record is explicit that where it fails the analysis does not run, [L133](../findings/second-order.md) records the $\mathbb{CP}^2$-type competitor, "*where $W$ has a kernel and $\delta^2$ has a kink*", as the scenario its own argument does not touch.

*Does a padded object falsify the statement?* No, and the reason is scope rather than luck: L149 quantifies over directions $H$ at the single point $W^*=S^m\times S^m$, so a padded or $\mathbb{CP}^m$ base point is not an instance of it. **The finding is the missing hypothesis line, not a counterexample.** What a reader carrying L149 forward must not do is read "over every direction" as "at every critical point": the $g_n>0$ that branches 2 and 3 both rest on is a property of $W^*$.

## 7. The statement box, clause by clause

### 7.1 "the second branch is $\Omega(n^{-1})$ uniformly in $w\in[0,1]$", CONFIRMED (§5.1)

### 7.2 "the first is minimised at $w=0$", REFUTED AS STATED

*Located.* The clause, and the display it refers to, $\min\!\big(\frac{c_p+w^2}{S},\dots\big)$.

*Exhibited.* [L147](../findings/second-order.md), "The chain has two branches, not three", gives the chain's first branch as $f(u)=(c_p+u^2)/(S+au)$ with

$$f'(0)=-\frac{ac_p}{S^2}<0,\qquad u^*=\frac{\sqrt{S^2+a^2c_p}-S}a>0,\qquad f(u^*)=\frac{2u^*}a,$$

so "$u=0$ is **never** its minimum". L149's $(c_p+w^2)/S$ drops the $au$ from the denominator; since $S+au>S$ for $u>0$, the displayed branch is an **upper** bound on the chain's branch 1, and a lower bound on $r$ cannot be read off an upper bound on a branch. The clause is true of the expression L149 prints and false of the object that expression names. Two variables are also conflated: L147's branch 1 runs in the defect weight $u$, and L149 writes all three branches in $w$, having elsewhere only $u\le w$.

*The opposite argued.* One may read L149 as deliberately coarsening the denominator to $S$; but that coarsening runs the wrong way for a lower bound, so the reading does not rescue the clause. What does survive is the order: $f(u^*)=\Theta(\min(c_p/S,\sqrt{c_p}/a))$, and $\sqrt{c_p}/a$ **is** branch 2, already inside the minimum. So $\min$ over the three branches is unchanged at order level and the lemma's conclusion is untouched. Charitably: the clause is a defect in the statement, not in the conclusion.

### 7.3 "the validity branch is $\Omega(n^{-1})$", CONFIRMED, on the unstated $g_n>0$ (§6)

### 7.4 Quantifier order, no finding

The two inputs are bounds on $c(H)$ from below and $\lVert A''(H)\rVert$ from above **in the same scalar $w(H)$**, so forming $\sqrt{c_p+\rho w^2}/(A+Bw)$ and minimising over $w\in[0,1]$ is a valid lower bound over all admissible $H$: no $\min$ was distributed across terms sharing a variable, and no $\sup$ was taken twice. Passing to $\min(\inf_w f,\inf_w g)\le\inf_w\min(f,g)$ likewise runs in the safe direction for a lower bound. **No finding: the statement carries no quantifier the proof mishandles here.**

### 7.5 $\beta\ge0$, used before it is supplied

$\min(\Theta(n^{-1-\beta}),\Omega(n^{-1}))=\Omega(n^{-1-\beta})$ requires $\beta\ge0$; at $\beta=-\tfrac12$ the minimum is $\Theta(n^{-1})$ and the conclusion $r_n\gtrsim n^{-1/2}$ fails. L149 introduces $S=\Theta(n^\beta)$ with no range. It is supplied eight lines below, in the entry's own ceiling clause $c_p/S\le c_p/\theta_0$, which is the statement $S\ge\theta_0$, hence $\beta\ge0$, and [L147](../findings/second-order.md) states it outright ($\sup\lvert P\rvert\ge P(W^*)=\theta_0(n)$, forcing $\beta\ge0$; [L143](../findings/bounds.md) forcing $\beta\le\tfrac12$). **Recorded as an ordering defect, not a gap**: the hypothesis is used above the line that establishes it, and the brief as dispatched cut off before that line.

### 7.6 Two collisions of notation

- **$\rho$.** The analyticity radius in "$\lVert A''\rVert=O(1/\rho)$" and "$\rho(H)/2$"; the margin coefficient in "$\rho_n^{\mathrm{eff}}$", "*the repaired form carries $\rho_n$ on the $w^2$*", and "*At $\rho=0$, which is $m=4$*". Context disambiguates each use, but "$O(1/\rho)$" and "$\rho=0$" appear eleven lines apart with opposite referents.
- **$\kappa$.** $\kappa=nc_p$ in the proof; $\kappa_n$ the quartic-tail constant in the blockquote. [L158](../findings/second-order.md):1276 flags exactly this ("*the $\kappa$ here is $nc_p$ and collides with the penalty constant $\kappa_n$*") for its own display. L149, where both symbols originate, carries no such note.

### 7.7 Parity

$n=2m$ throughout ([L146](../findings/second-order.md)'s box fixes it; the identity $\frac{m-4}{2(m-1)}=\frac{n-8}{2(n-2)}$ requires it). $W^*=S^m\times S^m$ exists only at even $n$, so the conclusion "$r_n\gtrsim n^{-1-\beta}$" is established at **even $n$ only**, and the display carries no parity marker. This is scope rather than error (the balanced orbit is an even-dimensional object) but a reader taking $r_n$ for the record's general tube radius would over-read it. **Recorded, at low severity.**

## 8. The value I could not reproduce

"*What the closed form $\tfrac1n\sqrt{\kappa(n-8)/(3n-8)}$ remains is a valid but lossy lower bound, $15.5\%$ low at $n=12$*". No derivation of $15.5\%$ appears in the entry, and it names no reference value explicitly. I evaluated the closed form against the four reference values the entry's own text supplies, all at $n=12$, all by hand from $\theta_0(12)=\sqrt{220}/12$:

| Reference value | Closed form / reference |
|---|---|
| $\min_{[0,1]}$ of $\sqrt{c_p+\rho_nw^2}/(n^{1/2}+nw)$, attained at $w=1$ | $0.9742$, $2.6\%$ low |
| the same under the saturation kink $w_0=(n-4)/n=\tfrac23$ | $0.9102$, $9.0\%$ low |
| the same two with $\rho_n^{\mathrm{eff}}$ in place of $\rho_n$ | $0.9712$, $2.9\%$ low |
| the same with the record's $A=n\sqrt2/\sqrt{n-2}$ | $0.9978$, $0.2\%$ low |

None is $15.5\%$, and none is the entry's own quoted $0.9008$ / $0.9794$ / $0.9215$ / $0.9840$ either. I do not have a definition of "the admissible envelope" against which those are taken, so I **do not refute** the figure. Per the discrepancy protocol this candidate fails step 2, I cannot exhibit the failure, only my inability to reproduce the claim. The finding is therefore the weaker and exact one: **this claim has no argument on file**, and the number is unsupported within the entry.

## 9. What would break it, and what I did to look

**The object that would falsify the statement**: a direction $H\in T_{W^*}S\cap T_{W^*}\mathcal O^\perp$ with $\lVert H\rVert_F=1$, small weight $w$ off the two $S^2_0$ copies, and $\lVert H\rVert_{op}$ bounded away from $0$, i.e. the "low-margin, high-operator-norm" direction the headline denies. Such an $H$ would give $c(H)=c_p+O(w^2)=\Theta(n^{-1})$ with $\lVert A''\rVert=\Theta(n)$ and return branch 2 to $\Theta(n^{-3/2})$, refuting the uniformity.

**What I did to look for it.** I did not search; I closed it. $\lVert H\rVert_{op}\le\lVert H_s\rVert_{op}+w$ and $\lVert H_s\rVert_{op}\le1/\sqrt{m-1}$ hold with $\lVert H_s\rVert_{op}$ **attained** at the pair-concentrated $h$ (§2), so $w\to0$ forces $\lVert H\rVert_{op}\to O(n^{-1/2})$ with no escape. The candidate direction does not exist, and I verified the constant $1/\sqrt{m-1}$ governs the joint two-copy space and not merely one copy, the one place a two-copy object could have hidden a $\sqrt2$, and it does not.

**The second object I looked for**: a summand of [L27](../findings/nondegeneracy.md)'s ten with margin below $3\theta_0\frac{m-3}{2(m-1)}$ inside the domain, which would break C3's coefficient. I enumerated all ten (§1); the only smaller ones are $\langle W\rangle$'s negative margin and the orbit's zero, and both are removed exactly by $T_{W^*}S\cap T_{W^*}\mathcal O^\perp$, the second by [L27](../findings/nondegeneracy.md)'s $E(\tfrac12)=$ orbit tangent. I also checked the one dimension at which a summand could migrate into $H_s$ and found it is $m=4$, the same dimension at which the coefficient vanishes.

**The third**: an admissible dimension at which the imported constants are undefined. I found one, $n=10$ (§4).

## Verdict

**GAP.**

The lemma's order conclusion ($r_n\gtrsim n^{-1-\beta}$ over every direction at $W^*$, with $\Theta(n^{-1})$ the ceiling), is **established**, and both of its two inputs are correct, the margin bullet exactly tight and the operator-norm bullet correct with a closed form the entry only asserted at $n=12$. What is not established, in the statement as written:

1. **"the first is minimised at $w=0$"** is refuted by [L147](../findings/second-order.md)'s own form of branch 1 (§7.2). The order conclusion survives because $f(u^*)=\Theta(\min(c_p/S,\sqrt{c_p}/a))$ and the second term is already in the minimum, but the clause is false of the object it names.
2. **The proof's displayed minimum** $\frac1n\sqrt{\kappa/(1+\kappa)}$ is a lower bound stated upward by $12.1\%$ at $n=12$, because $A=n^{1/2}$ discards the record's own $\lVert H_s\rVert_{op}\le1/\sqrt{m-1}$ (§5.3), and the same substitution is what puts $w^*$ outside $[0,1]$, making "a single interior minimum" false for every $n\le19$ (§5.2).
3. **The stated range $m\ge5$ overruns its imports.** At $n=10$ the entry's own $\lvert\kappa_n\rvert=9(\theta_0(n)-\sqrt{3/2})$ is negative, $\theta_0(10)=6/5$ exactly, and both [L133](../findings/second-order.md) and [L134](../findings/second-order.md) state their constants for $n\ge12$ (§4).

**Owed, if the entry is to keep its stated form:** the hypothesis $\ker W^*=0$ in the form $g_n=\Theta(n^{-1})$, on which branches 2 and 3 both rest and which appears nowhere in L149 (§6); the range $\beta\in[0,\tfrac12]$, used above the line that supplies it (§7.5); and a derivation for "$15.5\%$ low at $n=12$", which has none on file (§8).

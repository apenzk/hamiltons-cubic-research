# VERIFY v139, L23: the closed forms $\theta=\tfrac2n\sqrt{rN/(N-r)}$ and $S_{\mathfrak{mmm}}=(N-r)[2(n-2)-4(n-1)r/N]$, the cap $r\le n(n-2)/4$, and the equality locus

**Cold brief.** Verifier v139 on [ROUND_L23.md](ROUND_L23.md), checking the block at [ungraded-slack.md](../findings/ungraded-slack.md):124–150. **No numerical work was done**: no script was run, no sweep, no screen. Every value below is an exact hand evaluation, and every rational or radical is written in closed form. Log: [agent_logs/verify-L23-v139.log](../agent_logs/verify-L23-v139.log). No other verifier's report was read; [REVIEW_r25.md](../reviews/REVIEW_r25.md) was read because the block cites it, and [REVIEW_r491.md](../reviews/REVIEW_r491.md) / [REVIEW_r492.md](../reviews/REVIEW_r492.md) only as far as their headline lines, to confirm what the block's two blockquotes attribute to them.

## Claim table

| # | claim, as the block states it | verdict |
|---|---|---|
| 1 | $S_{\mathfrak{hhh}}+S_{\mathfrak{hmm}}=\kappa r$ and $2S_{\mathfrak{hmm}}+S_{\mathfrak{mmm}}=\kappa(N-r)$, $\kappa=2(n-2)$ | **CONFIRMED** |
| 2 | the two scalar equations are the traces of $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$ against $\Pi_{\mathfrak h}$, $\Pi_{\mathfrak m}$ | **CONFIRMED** |
| 3 | the elimination gives $S_{\mathfrak{hmm}}=2\sigma r(N-r)/N$ and $\theta=\sigma ur/(N-r)$, $\sigma=n-1$ | **CONFIRMED, and forced** (system determinant $N/2r\ne0$) |
| 4 | $\theta=\tfrac2n\sqrt{rN/(N-r)}$ | **CONFIRMED**, and normalisation-dependent, see §3 |
| 5 | $S_{\mathfrak{mmm}}=(N-r)\big[2(n-2)-\tfrac{4(n-1)r}N\big]$ | **CONFIRMED** |
| 6 | $S_{\mathfrak{mmm}}\ge0\Rightarrow r\le n(n-2)/4$ | **CONFIRMED** |
| 7 | $r\le n(n-2)/4\Rightarrow\theta\le\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ | **CONFIRMED**, by strict monotonicity of $r\mapsto rN/(N-r)$ |
| 8 | the two equality cases coincide, both being $S_{\mathfrak{mmm}}=0$ | **CONFIRMED** |
| 9 | $S_{\mathfrak{mmm}}=0\iff[\mathfrak m,\mathfrak m]\subseteq\mathfrak h\iff$ sign-graded $\iff$ symmetric pair | **CONFIRMED**, with the block's account of *which* arrow needs the argument **MIS-ASSIGNED**, see §5.2 |
| 10 | "$\mathbb Z_2$-graded in the sense settled elsewhere in this file" | **BROKEN POINTER**, the senses are settled in [graded-half.md](../findings/graded-half.md), not in this file |
| 11 | for even $n$ the equality case is $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ alone | **HYPOTHESIS-DEBT**, the arithmetic is exact, the enumeration it runs over rests on an unread source and on an unargued completeness claim at $n=8$ |
| 12 | the maximum over the family is attained at the Weyl operator of $S^{n/2}\times S^{n/2}$ | **HYPOTHESIS-DEBT**, attainment and the identification are both imports, neither argued in the block |
| 13 | for odd $n$ the cap is not an integer and the inequality is strict | **CONFIRMED** |
| 14 | the stated hypothesis range $0<r<N$ | **UNDERSTATED**, the same proof forces $n/2\le r\le n(n-2)/4$, with the left equality exactly at abelian $\mathfrak h$; §6.1 |
| 15 | "the subalgebras that exceed the cap are … $\mathfrak u(m)$, $\mathfrak{su}(m)$, $\mathfrak{sp}(m)\oplus\mathfrak{sp}(1)$ at $m\le2$" | **MIS-SCOPED QUALIFIER**, correct for $\mathfrak{sp}(m)\oplus\mathfrak{sp}(1)$, false if it distributes; §7.5 |
| 16 | the slack closed form $S=\tfrac r{nN}[4(N-r)-n^2]$ on the family | **CONFIRMED** by hand here; **no derivation is on file**, §8 |
| 17 | [results.md](../results.md):134's one-line statement of L23 | **BROKEN**, it drops the eigen-equation hypothesis and reads as the Lie-theoretic bound the block itself withdraws; §9.2 |

**Verdict: GAP.** The mathematics the block calls its proof is correct and I rebuilt every step of it cold; three clauses standing *inside the same Statement sentence* as the proven part are imports with no argument on file, and the record's own one-line citation of the lemma has inherited the defect the block withdrew.

## 0. Conventions, fixed once

Read from [conventions.md](../findings/conventions.md), lines 15, 49, 50, 59, 65, 68, and cross-checked against [problem.md](../findings/problem.md):19 (Jäger's Theorem A, quoted there verbatim as $W^2+W^\#=\theta W$) and [problem.md](../findings/problem.md):539 ($Q(I)=(n-1)I$).

- **Inner product on $\Lambda^2\mathbb R^n=\mathfrak{so}(n)$:** $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$, under which $\{\varphi_{ab}=E_{ab}-E_{ba}\}_{a<b}$ is orthonormal ([conventions.md](../findings/conventions.md):65, 68). The half goes at the $\Lambda^2$ level, not the operator level.
- **Structure constants** $c_{abc}=\langle[\varphi_a,\varphi_b],\varphi_c\rangle$, totally antisymmetric, so $T_{abc}=c_{abc}^2$ is totally symmetric ([conventions.md](../findings/conventions.md):50).
- **Killing row marginal** $\sum_{b,c}c_{abc}^2=\kappa=2(n-2)$ over *ordered* pairs, from $B(X,Y)=(n-2)\operatorname{tr}(XY)$ and $\operatorname{tr}(v^2)=-2$ at a unit bivector ([conventions.md](../findings/conventions.md):49; the general statement is [Lemma L153](../findings/bounds.md)).
- **$\#$** is the halved Böhm–Wilking product, $vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$ ([conventions.md](../findings/conventions.md):59). For $W$ diagonal in an orthonormal basis of $\Lambda^2$ with eigenvalues $w_a$, this gives $(W^\#)_{aa}=\tfrac12\sum_{b,c}c_{abc}^2w_bw_c$, and hence $Q(I)=(1+\kappa/2)I=(n-1)I$, matching the record.
- **$Q(W)=W^2+W^\#$**, $\mathcal W_n\to\mathcal W_n$ ([conventions.md](../findings/conventions.md):15).
- **$\sigma:=1+\kappa/2=n-1$**, $N=\binom n2$, $u=c(1-r/N)$, $v=-cr/N$, $c=\sqrt{N/(r(N-r))}$ so that $\lVert W_{\mathfrak h}\rVert=1$: $\lVert W_{\mathfrak h}\rVert^2=ru^2+(N-r)v^2=c^2r(N-r)/N$.
- **$\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$**, which is the balanced sphere product's value: $\theta(S^p\times S^q)^2=\frac{2(n-1)(p-1)(q-1)}{(n-2)pq}$ ([graded-half.md](../findings/graded-half.md), Lemma L8 box) reads $\frac{2(n-1)(n-2)}{n^2}$ at $p=q=n/2$.

## 1. The hypothesis inventory

### 1.1 What the Statement carries

| # | hypothesis | used by the written proof? |
|---|---|---|
| H1 | $\mathfrak h\subseteq\mathfrak{so}(n)=\Lambda^2\mathbb R^n$ is a **subalgebra** | **yes**, both structure-constant relations R1 and R2 need $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$ |
| H2 | $\mathfrak m=\mathfrak h^\perp$ | **yes**, throughout, and it is what turns $S_{\mathfrak{mmm}}=0$ into $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$ |
| H3 | $r=\dim\mathfrak h$, $N=\binom n2$, $0<r<N$ | **yes**, the elimination divides by $u$ and by $v$, and $c$ is finite only here |
| H4 | $W_{\mathfrak h}$ is the **unit-norm** multiple of $\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$ | **yes, and only for the numerical value of $\theta$**, see §3.3 |
| H5 | $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$ | **yes**, this is the whole input; both scalar equations are its traces |

### 1.2 What the Statement does **not** carry, and where the block needs it anyway

| # | hypothesis | where it is needed | status in the Statement |
|---|---|---|---|
| I1 | $\kappa=2(n-2)$ in the record's normalisation, equivalently $Q(\mathrm{Id})=(n-1)\mathrm{Id}$ | **every** constant: $\theta$, $S_{\mathfrak{mmm}}$, and the cap $n(n-2)/4$ itself | named inside the proof, absent from the Statement |
| I2 | $\lVert\varphi_{ab}\rVert=1$ under the half-trace pairing | fixes I1; under plain Frobenius $\kappa$ would read $n-2$ and the cap would read $(n-1)(n-2)/2$ | absent |
| I3 | (F1) $\mathfrak h,\mathfrak m$ $K$-irreducible **and inequivalent**, $K=N_{O(n)}(\mathfrak h)$ | needed to **produce** any member, i.e. to know H5 ever holds | in "Producing members", **not** in the Statement |
| I4 | (F2) $(\mathrm{Sym}^2\mathbb R^n)^K=\mathbb R\,\mathrm{Id}$ | Ricci-flatness of $W_{\mathfrak h}$, hence $W_{\mathfrak h}\in\mathcal W_n$ | same |
| I5 | (F3) $(\Lambda^4\mathbb R^n)^K=0$ | $\mathrm{Alt}(W_{\mathfrak h})=0$ | same |
| I6 | $Q(\mathcal W_n)\subseteq\mathcal W_n$ | the "Producing members" argument, and nothing else | imported; [Lemma L4](../findings/ungraded-slack.md):107 records it as *"asserted as a remark on Fox at [problem.md](../findings/problem.md) and derived nowhere here"* |
| I7 | the classification of $\mathbb Z_2$-gradings of $\mathfrak{so}(n)$ | the even-$n$ equality case | cited to [trap W2](../findings/INDEX-traps.md), which cites [graded-half.md](../findings/graded-half.md), which argues only that the $n=8$ extras are *new*, never that the list is *complete*. **No source for the classification is in [references/](../references/)**, the folder holds no Helgason, no Cartan, no Berger, no Besse |
| I8 | $n\ge4$ | below it the admissible range for $r$ is empty; §6.2 | absent |

**Nothing in the written proof uses irreducibility of $\mathfrak h$ on $\mathbb R^n$, nor any bound on $\dim\mathfrak m$, nor $\mathfrak h\not\cong\mathfrak m$.** Those three belong to "Producing members", and the block is right to keep them out of the conditional statement. **The one thing the Statement's hypothesis list gets wrong is in the other direction**: $0<r<N$ is far weaker than what the proof forces (§6.1).

**Imported results, each checked against the object it applies to.**

- **[Lemma L153](../findings/bounds.md)** (row marginal $=2(n-2)$) is applied at basis bivectors $\varphi_a$ of an orthonormal basis of $\mathfrak{so}(n)$; L153 is stated for *any* $v\in\mathfrak{so}(n)$ at any $n\ge2$, so the instance is inside its range. [results.md](../results.md):399 makes the citation explicit; the [ungraded-slack.md](../findings/ungraded-slack.md) copy of the block does not, deriving $\kappa$ from "the Killing constant of $\mathfrak{so}(n)$" instead. Both routes land on $2(n-2)$.
- **BW08 Lemma 2.1** ([problem.md](../findings/problem.md):52) is used only implicitly, through §3.4's observation about which half of the eigen-equation does which work.
- **[trap W2](../findings/INDEX-traps.md)** is applied at $n=8$, which is precisely the dimension it exists to flag; the application is in range. What it supplies is a *list*, and the block uses it as an *exhaustive* list, see §5.4.

## 2. The two structure-constant relations (claim 1)

Let $\{\varphi_a\}$ be an orthonormal basis of $\mathfrak{so}(n)$ adapted to $\mathfrak{so}(n)=\mathfrak h\oplus\mathfrak m$.

**R1.** Sum $\sum_{b,c}c_{abc}^2=\kappa$ over $a\in\mathfrak h$. Splitting $(b,c)$ by block: the pair $b,c\in\mathfrak h$ contributes $S_{\mathfrak{hhh}}$; a pair with exactly one index in $\mathfrak m$, say $b\in\mathfrak h$, $c\in\mathfrak m$, has $c_{abc}=\langle[\varphi_a,\varphi_b],\varphi_c\rangle=0$ because $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h\perp\mathfrak m$; the pair $b,c\in\mathfrak m$ contributes $S_{\mathfrak{hmm}}$. Hence

$$S_{\mathfrak{hhh}}+S_{\mathfrak{hmm}}=\kappa r.$$

**R2.** Sum over $a\in\mathfrak m$. The term $b,c\in\mathfrak h$ vanishes for the same reason, read through total antisymmetry ($c_{abc}=c_{bca}$). The two mixed terms $(b\in\mathfrak h,c\in\mathfrak m)$ and $(b\in\mathfrak m,c\in\mathfrak h)$ each equal $S_{\mathfrak{hmm}}$ after relabelling, again by total antisymmetry. The term $b,c\in\mathfrak m$ is $S_{\mathfrak{mmm}}$. Hence

$$2S_{\mathfrak{hmm}}+S_{\mathfrak{mmm}}=\kappa(N-r).$$

**CONFIRMED.** The block's parenthetical *"because $\mathfrak h$ is a subalgebra, $[\mathfrak h,\mathfrak h]\perp\mathfrak m$"* is exactly the step both relations use, and it is stated correctly for both.

## 3. The closed form (pre-registered question 1)

### 3.1 The two scalar equations (claim 2)

$W_{\mathfrak h}$ is diagonal in the adapted basis with $w_a=u$ on $\mathfrak h$ and $w_a=v$ on $\mathfrak m$. So $\langle Q(W)\varphi_a,\varphi_a\rangle=w_a^2+\tfrac12\sum_{b,c}c_{abc}^2w_bw_c$.

Trace against $\Pi_{\mathfrak h}$, i.e. sum over $a\in\mathfrak h$: the $\#$-part splits exactly as in R1, giving $ru^2+\tfrac12(S_{\mathfrak{hhh}}u^2+S_{\mathfrak{hmm}}v^2)$, and the right side is $\theta\operatorname{tr}(\Pi_{\mathfrak h}W)=\theta ru$. Dividing by $r$:

$$u^2+\tfrac1{2r}\big(S_{\mathfrak{hhh}}u^2+S_{\mathfrak{hmm}}v^2\big)=\theta u.\tag{A}$$

Trace against $\Pi_{\mathfrak m}$: the $\#$-part splits as in R2, giving $(N-r)v^2+\tfrac12(2S_{\mathfrak{hmm}}uv+S_{\mathfrak{mmm}}v^2)$, and dividing by $N-r$:

$$v^2+\tfrac1{2(N-r)}\big(2S_{\mathfrak{hmm}}uv+S_{\mathfrak{mmm}}v^2\big)=\theta v.\tag{B}$$

**CONFIRMED**, both equations verbatim as the block writes them, including the asymmetric factor $2$ on $S_{\mathfrak{hmm}}$ in (B) and its absence in (A), which is right, because in (A) the index $a$ runs over $\mathfrak h$ and only one of the four block-patterns survives, while in (B) two do.

### 3.2 The elimination is forced (claims 3, 4, 5)

Substitute $S_{\mathfrak{hhh}}=\kappa r-S_{\mathfrak{hmm}}$ into (A) and $S_{\mathfrak{mmm}}=\kappa(N-r)-2S_{\mathfrak{hmm}}$ into (B):

$$\sigma u^2+\tfrac{S_{\mathfrak{hmm}}}{2r}(v^2-u^2)=\theta u,\qquad \sigma v^2+\tfrac{S_{\mathfrak{hmm}}}{N-r}v(u-v)=\theta v,\qquad \sigma=1+\tfrac\kappa2=n-1 .$$

Divide the first by $u\ne0$ and the second by $v\ne0$ (this is where $0<r<N$ enters). Tracelessness gives $ru+(N-r)v=0$, hence $v=-ru/(N-r)$, $u-v=uN/(N-r)$, $u+v=u(N-2r)/(N-r)$. Writing $X:=S_{\mathfrak{hmm}}uN/(N-r)^2$,

$$\text{(A)}:\quad \sigma u-\tfrac{N-2r}{2r}X=\theta,\qquad\qquad \text{(B)}:\quad -\tfrac{\sigma ru}{N-r}+X=\theta .$$

As a linear system in the two unknowns $(X,\theta)$ the determinant is $\tfrac{N-2r}{2r}+1=\tfrac N{2r}\ne0$, so **the solution is unique, the elimination is forced, not one solution among several.** Subtracting,

$$\sigma u\Big(1+\tfrac r{N-r}\Big)=X\Big(1+\tfrac{N-2r}{2r}\Big)\ \Longrightarrow\ \sigma u\tfrac N{N-r}=X\tfrac N{2r}\ \Longrightarrow\ X=\tfrac{2r\sigma u}{N-r},$$

so $S_{\mathfrak{hmm}}=\dfrac{2\sigma r(N-r)}N$, and back in (B), $\theta=-\dfrac{\sigma ru}{N-r}+\dfrac{2r\sigma u}{N-r}=\dfrac{\sigma ur}{N-r}$. **Both match the block's stated intermediate results exactly.**

Now $u=c(N-r)/N$, so $\theta=\sigma cr/N$, and with $c=\sqrt{N/(r(N-r))}$ and $N=n(n-1)/2$,

$$\theta=(n-1)\frac rN\sqrt{\frac N{r(N-r)}}=(n-1)\sqrt{\frac r{N(N-r)}}=\frac{n(n-1)}{2N}\cdot\frac2n\sqrt{\frac{rN}{N-r}}=\frac2n\sqrt{\frac{rN}{N-r}},$$

the last step because $2N=n(n-1)$. **Claim 4 CONFIRMED.** And from R2,

$$S_{\mathfrak{mmm}}=\kappa(N-r)-2S_{\mathfrak{hmm}}=2(n-2)(N-r)-\frac{4(n-1)r(N-r)}N=(N-r)\Big[2(n-2)-\frac{4(n-1)r}N\Big].$$

**Claim 5 CONFIRMED.**

**Independent cross-check, from the record's own older copy.** [ATTEMPTS.md](../ATTEMPTS.md) Result 7 records, for the *unnormalised* $W=\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$, that $Q(W)=\tfrac{2r}nW$. Setting $c=1$ in the derived $\theta=\sigma ur/(N-r)$ gives $(n-1)\tfrac{N-r}N\tfrac r{N-r}=\tfrac{(n-1)r}N=\tfrac{2r}n$. The two agree exactly, and the older statement was written before this block existed.

### 3.3 Which normalisations the constants depend on

- **$\theta$'s numerical value depends on H4.** $Q$ is quadratic, so $Q(\lambda W)=\lambda^2Q(W)$ and the eigenvalue of $\lambda W$ is $\lambda\theta$. Only $\lVert W_{\mathfrak h}\rVert=1$ pins the printed constant.
- **$\theta$ and the cap depend on I1/I2 together.** Rescaling the $\Lambda^2$ inner product by $\lambda$ sends $c_{abc}\mapsto\lambda^{-1/2}c_{abc}$, hence $\kappa\mapsto\kappa/\lambda$, hence $W^\#\mapsto W^\#/\lambda$ while $W^2$ is unchanged, so $Q$ itself changes. Carrying a general $\kappa$ through §3.2 gives $\sigma=1+\kappa/2$ and

  $$r\le\frac{\kappa N}{4\sigma}=\frac{\kappa N}{2(\kappa+2)} .$$

  At $\kappa=2(n-2)$ this is $\frac{(n-2)N}{2(n-1)}=\frac{n(n-2)}4$. At the plain-Frobenius alternative $\kappa=n-2$ it would read $\frac{(n-2)N}n=\frac{(n-1)(n-2)}2$, a different bound. **So $n(n-2)/4$ is not a convention-free number**; it is tied to the normalisation in which $Q(\mathrm{Id})=(n-1)\mathrm{Id}$, i.e. in which the round sphere's curvature operator is $\mathrm{Id}$. The block's proof names $\kappa=2(n-2)$ but the Statement does not, and [results.md](../results.md):395–401 does not either.
- **$S_{\mathfrak{mmm}}$ and $S_{\mathfrak{hmm}}$ are quadratic in the structure constants**, so they carry the same dependence; $S_{\mathfrak{mmm}}\ge0$ does not.

### 3.4 What each of the two equations actually contributes

Taking the **full** trace of $Q(W)=\theta W$ gives $\operatorname{tr}(W^2)+\operatorname{tr}(W^\#)=\theta\operatorname{tr}W=0$, i.e. $\operatorname{tr}(W^\#)=-1$ at unit norm. In the coordinates of §3.2 this combination is $ru\cdot\text{(A)}+(N-r)v\cdot\text{(B)}$, which reduces to $\sigma u\tfrac N{N-r}=X\tfrac N{2r}$, **exactly the equation that produces $S_{\mathfrak{hmm}}$.** So the split is: one of the two independent consequences of the eigen-equation is its full trace, and *that* is what pins $S_{\mathfrak{hmm}}$ (equivalently, by BW08 Lemma 2.1 at [problem.md](../findings/problem.md):52, what says $W_{\mathfrak h}$ is Ricci-flat); the remaining one determines $\theta$. Nothing is wrong with the block here, the observation is that the constraint the cap rests on is a *trace* consequence, and would be available from Ricci-flatness alone without ever invoking the eigen-equation's off-trace content.

**Answer to pre-registered question 1.** The closed form follows, in full, from H1–H5 plus I1/I2; the elimination is forced by a nonzero determinant rather than selected; and the constants depend on the unit-norm choice and on the $\kappa=2(n-2)$ / $Q(\mathrm{Id})=(n-1)\mathrm{Id}$ normalisation, the latter reaching the cap itself.

## 4. The cap and the two inequalities (pre-registered question 2, first half)

### 4.1 The first inequality, $r\le n(n-2)/4$ (claim 6)

$S_{\mathfrak{mmm}}=\sum_{a,b,c\in\mathfrak m}c_{abc}^2\ge0$ is a sum of squares. With $N-r>0$,

$$S_{\mathfrak{mmm}}\ge0\iff 2(n-2)\ge\frac{4(n-1)r}N\iff r\le\frac{(n-2)N}{2(n-1)}=\frac{(n-2)}{2(n-1)}\cdot\frac{n(n-1)}2=\frac{n(n-2)}4 .$$

**CONFIRMED**, and the equivalence is two-way: $S_{\mathfrak{mmm}}=0\iff r=n(n-2)/4$ exactly.

### 4.2 The second inequality, $\theta\le\theta_0(n)$ (claim 7)

$r\mapsto\dfrac{rN}{N-r}$ has derivative $\dfrac{N(N-r)+rN}{(N-r)^2}=\dfrac{N^2}{(N-r)^2}>0$ on $0<r<N$, so $\theta$ is **strictly** increasing in $r$ at fixed $n$. At $r=n(n-2)/4$,

$$N-r=\frac{n(n-1)}2-\frac{n(n-2)}4=\frac{2n(n-1)-n(n-2)}4=\frac{n\big(2n-2-n+2\big)}4=\frac{n^2}4,$$

which is the block's own intermediate line, and then

$$\theta^2=\frac4{n^2}\cdot\frac{rN}{N-r}=\frac4{n^2}\cdot\frac{\tfrac{n(n-2)}4\cdot\tfrac{n(n-1)}2}{\tfrac{n^2}4}=\frac4{n^2}\cdot\frac{(n-1)(n-2)}2=\frac{2(n-1)(n-2)}{n^2},$$

so $\theta=\sqrt{2(n-1)(n-2)}/n=\theta_0(n)$. **CONFIRMED.**

### 4.3 The two equality cases coincide (claim 8)

Equality in $r\le n(n-2)/4$ is $S_{\mathfrak{mmm}}=0$ by §4.1. Equality in $\theta\le\theta_0$ is $r=n(n-2)/4$ by the **strict** monotonicity of §4.2, this is the step that makes the two loci the same set rather than merely nested, and the block does not name it, though it is one line. **CONFIRMED**, with the strictness supplied.

## 5. The equality locus (pre-registered question 2, second half)

### 5.1 The chain $S_{\mathfrak{mmm}}=0\iff[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$

$S_{\mathfrak{mmm}}=0$ iff $c_{abc}=0$ for all $a,b,c\in\mathfrak m$, iff $\langle[\mathfrak m,\mathfrak m],\mathfrak m\rangle=0$, iff $[\mathfrak m,\mathfrak m]\perp\mathfrak m$, iff $[\mathfrak m,\mathfrak m]\subseteq\mathfrak m^\perp=\mathfrak h$, using H2 and nothing else. **CONFIRMED.**

### 5.2 DISCREPANCY D1, the block assigns the argument to the wrong arrow

**Locate.** [ungraded-slack.md](../findings/ungraded-slack.md):134, verbatim: *"**The one arrow needing an argument is $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$**: the others are definitions, and this one uses $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$, which holds because $\mathfrak h$ is a subalgebra and the form is invariant."*

**Exhibit.** The arrow $S_{\mathfrak{mmm}}=0\iff[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$ is the one §5.1 discharges in a line from $\mathfrak m=\mathfrak h^\perp$, and it does **not** use $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$ anywhere. The arrow that does use it is the *next* one, $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h\Rightarrow(\mathfrak{so}(n),\mathfrak h)$ a symmetric pair: a symmetric pair is the triple of inclusions $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$, $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$, $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$, of which the block's hypotheses give the first and the equality case gives the third; the middle one is precisely what invariance supplies, since $\langle[\mathfrak h,\mathfrak m],\mathfrak h\rangle=-\langle\mathfrak m,[\mathfrak h,\mathfrak h]\rangle\subseteq\langle\mathfrak m,\mathfrak h\rangle=0$. At a named object: $\mathfrak h=\mathfrak{so}(2)\oplus\mathfrak{so}(2)\subset\mathfrak{so}(4)$, where $\mathfrak m=\langle\varphi_{13},\varphi_{14},\varphi_{23},\varphi_{24}\rangle$ has $[\varphi_{13},\varphi_{14}]=-\varphi_{34}\in\mathfrak h$ and $[\varphi_{13},\varphi_{23}]=-\varphi_{12}\in\mathfrak h$, read off from $\mathfrak m^\perp$ with no appeal to $[\mathfrak h,\mathfrak m]$ at all.

**Argue the opposite.** The most charitable reading the words support is that *"this one"* refers not to the displayed inclusion but to the whole equivalence chain the sentence is annotating, i.e. to the run from $S_{\mathfrak{mmm}}=0$ through to "symmetric pair", of which $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$ is indeed the only non-definitional ingredient. On that reading the sentence is loose rather than wrong. **The candidate therefore survives as a labelling defect and not as a mathematical error**: every ingredient the chain needs is present and correct, and only the attribution of which step needs which is misplaced. Recorded as **CONFIRMED-with-mis-assignment** rather than as a break.

### 5.3 DISCREPANCY D2, "$\mathbb Z_2$-graded in the sense settled elsewhere in this file" does not resolve

**Locate.** [ungraded-slack.md](../findings/ungraded-slack.md):134, verbatim: *"when $W_{\mathfrak h}$ is $\mathbb Z_2$-graded in the sense settled elsewhere in this file"*.

**Exhibit.** The three senses of "graded" are settled in [graded-half.md](../findings/graded-half.md), in the block headed *"The two senses of 'graded', ordered, and which results are stated in which"*, which names (C) pair-graded, (A) sign-graded, (B) slice-graded. [ungraded-slack.md](../findings/ungraded-slack.md) settles no sense; where it uses the word it points outward, e.g. at its own line 201: *"the slack is the sign-graded screen, which [graded-half.md](graded-half.md) marks vacuous wherever $\ker W\ne0$"*. A consumer who reads only L23 and follows "this file" finds nothing.

**Argue the opposite.** The two files were one file until 2026-08-31 ([ungraded-slack.md](../findings/ungraded-slack.md):3 records the split), so "this file" was true when written and the pointer is stale rather than wrong. **The candidate survives as a live defect**, because staleness is exactly how a citation stops resolving, and because the sense that is meant matters here: it is (A) sign-graded, and (A) is the sense [graded-half.md](../findings/graded-half.md) marks *vacuous wherever $\ker W\ne0$*.

**And on this family the substance is fine.** For $0<r<N$ one has $u>0>v$, so $\ker W_{\mathfrak h}=0$, $E_+(W_{\mathfrak h})=\mathfrak h$ and $E_-(W_{\mathfrak h})=\mathfrak m$; the (A) bracket conditions are then exactly $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$ (H1), $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$ (invariance) and $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$ (the equality case). [graded-half.md](../findings/graded-half.md) says the same in one clause (*"they coincide on the subalgebra family, where $W$ is projector-like"*) so claim 9's third link is sound in sense (A). **What the block owes is the two words "sign-graded" and the right file.**

### 5.4 The even-$n$ classification (claim 11)

**The arithmetic is exact and I reproduce it.** For $\mathfrak h=\mathfrak{so}(p)\oplus\mathfrak{so}(q)$, $p+q=n$, write $d=p-q$. Then $r=\binom p2+\binom q2=\tfrac{p^2+q^2-n}2$ and $2(p^2+q^2)=n^2+d^2$, so

$$r-\frac{n(n-2)}4=\frac{2(p^2+q^2)-2n-n^2+2n}4=\frac{d^2}4 .$$

So $r=n(n-2)/4$ forces $d=0$, and **every unbalanced split exceeds the cap by exactly $(p-q)^2/4$**, a sharper statement than the block's, and it settles the "unbalanced splits" entry of the exclusion list in one line. For $\mathfrak u(m)\subset\mathfrak{so}(2m)$, $n=2m$: $r=m^2$ against a cap of $2m(2m-2)/4=m(m-1)$, and $m^2-m(m-1)=m>0$. Both of the block's two lines **CONFIRMED**.

**What the arithmetic is run over is the debt.** The step "equality $\Rightarrow$ symmetric pair $\Rightarrow$ one of $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$, $\mathfrak u(n/2)$ (plus $\mathfrak{spin}(7)$, $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$ at $n=8$)" is the classification of involutive automorphisms of $\mathfrak{so}(n)$. It is:

- cited to [trap W2](../findings/INDEX-traps.md), which states the table and the fact $\mathrm{Aut}(\mathfrak{so}(n))=PO(n)$ for $n\ge5$, $n\ne8$, and cites [graded-half.md](../findings/graded-half.md);
- argued in [graded-half.md](../findings/graded-half.md) only to the extent that the two $n=8$ extras are *genuinely new*, *"they act irreducibly on $\mathbb R^8$, so no element of $O(8)$ carries either to a reducible $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$"*, which establishes that the list is **not too short by relabelling**, never that it is **complete**;
- **supported by no source in [references/](../references/)**: the folder holds 67 entries and none of Helgason, Cartan, Berger, Besse or any classification of symmetric pairs. The nearest is [wolf-1968-isotropy-irreducible](../references/wolf-1968-isotropy-irreducible/notes.md), which classifies isotropy-irreducible pairs, a different list.

**Where this bites hardest is at $n=8$ and dimension $12$.** The block's separate check is *"their dimensions $21$ and $13$ both exceed the cap $12$"*, which disposes of the two extras W2 names. It does **not** dispose of a possible triality image of $\mathfrak{so}(4)\oplus\mathfrak{so}(4)$ itself: triality preserves dimension, so such an image would have $r=12=$ the cap and would be a second equality case unless it is $O(8)$-conjugate back. **W2's table asserts that no such class exists and gives no argument, and I decline to supply one**, the finding is that the $n=8$ clause of the equality case rests on the completeness of a table whose completeness is asserted rather than shown, in a dimension the record itself flags as exceptional. **Verdict: HYPOTHESIS-DEBT.** What would have to be shown: *the involutive automorphisms of $\mathfrak{so}(8)$ whose fixed subalgebra has dimension $12$ form a single $O(8)$-conjugacy class*, together with a read source for the classification at general $n$.

### 5.5 Attainment, and the identification with $S^{n/2}\times S^{n/2}$ (claim 12)

The Statement's conclusion *"so the maximum over the family is attained exactly at the Weyl operator of $S^{n/2}\times S^{n/2}$"* needs two things the conditional theorem cannot give:

1. **that $\mathfrak h=\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ satisfies H5 at all.** Supplied by "Producing members" through (F1)–(F3), which are stated and not proved: *"the second makes $W_{\mathfrak h}$ Ricci-flat, the third Bianchi-free, and since $Q$ preserves the Weyl space and the $K$-invariant traceless Weyl operators are $\mathbb R\,W_{\mathfrak h}$, the eigen-equation follows."* Three asserted implications and one import. The import, $Q(\mathcal W_n)\subseteq\mathcal W_n$, is recorded by the record's own [Lemma L4](../findings/ungraded-slack.md):107 as *"asserted as a remark on Fox at [problem.md](problem.md) and derived nowhere here"*.
2. **that $W_{\mathfrak h}$ for that $\mathfrak h$ *is* the Weyl operator of $S^{n/2}\times S^{n/2}$.** Nowhere argued in the block. The natural route (both are the unique $K$-invariant traceless Weyl operator, so they agree up to sign), is available but is not written, and it needs the same (F1)–(F3) plus a sign convention.

**Verdict: HYPOTHESIS-DEBT** on the attainment clause. What a consumer may take from L23 alone is *"no member exceeds $\theta_0(n)$, and a member attains it only at $r=n(n-2)/4$"*; the further claim that a member attains it, and that this member is the balanced sphere product, is carried by the paragraph below the Statement and not by the Statement's proof.

**Answer to pre-registered question 2.** Both inequalities hold and I derived each separately; the two equality cases genuinely coincide, by strict monotonicity; the characterisation $S_{\mathfrak{mmm}}=0\iff[\mathfrak m,\mathfrak m]\subseteq\mathfrak h\iff$ sign-graded $\iff$ symmetric pair is correct on this family, with the block's internal attribution of the arrows mis-assigned and its pointer for "graded" broken; and the *classification* of that locus, plus the claim that it is attained, are imports rather than results of this proof.

## 6. Quantifiers, scope, and every edge of the range

### 6.1 The hypothesis $0<r<N$ is far weaker than the proof's own conclusion (claim 14)

The block uses $S_{\mathfrak{mmm}}\ge0$ and never uses $S_{\mathfrak{hhh}}\ge0$. But $S_{\mathfrak{hhh}}$ is a sum of squares too, and R1 gives $S_{\mathfrak{hhh}}=\kappa r-S_{\mathfrak{hmm}}$, so under the same hypotheses

$$0\le S_{\mathfrak{hhh}}=2(n-2)r-\frac{2(n-1)r(N-r)}N\iff (n-1)(N-r)\le(n-2)N\iff N\le(n-1)r\iff r\ge\frac N{n-1}=\frac n2 .$$

**So the eigen-equation forces $\dfrac n2\le r\le\dfrac{n(n-2)}4$**, and the left equality holds exactly when $S_{\mathfrak{hhh}}=0$, i.e. when $[\mathfrak h,\mathfrak h]\perp\mathfrak h$, i.e. (since $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$) when **$\mathfrak h$ is abelian**. The mirror of the block's own theorem, in the same two lines, and **it is nowhere on the record**: not in the block, not in [results.md](../results.md):395, not in [ATTEMPTS.md](../ATTEMPTS.md):1882, not in [REVIEW_r25.md](../reviews/REVIEW_r25.md). Recorded here as a **hypotheses correction**, not a defect: nothing the block asserts becomes false, but the stated range $0<r<N$ is not the range the family occupies.

*(This is a check, not a repair: I state the consequence of the block's own two relations and do not use it to close anything the block left open.)*

### 6.2 The edges

| edge | what the statement says there | verdict |
|---|---|---|
| $r\to0$ | excluded by $0<r$; and $c=\sqrt{N/(r(N-r))}\to\infty$, so $W_{\mathfrak h}$ does not exist | correctly excluded, and §6.1 excludes everything below $n/2$ as well |
| $r\to N$ | excluded by $r<N$; $\mathfrak h=\mathfrak{so}(n)$ gives $\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}=0$ | correctly excluded, and the cap excludes everything above $n(n-2)/4$, which is $\approx N/2$ |
| $n=3$ | cap $=3/4<1$, so **no $\mathfrak h$ at all**; the range $[n/2,n(n-2)/4]=[1.5,0.75]$ is empty | consistent. Direct check: $\mathfrak h=\langle\varphi_{12}\rangle$ in $\mathfrak{so}(3)$ has $\kappa=2$, $c_{123}^2=1$, and $Q(W)$ has diagonal $c^2(\tfrac49+\tfrac19,\tfrac19-\tfrac29,\tfrac19-\tfrac29)=\tfrac{c^2}9(5,-1,-1)$ against $W\propto(2,-1,-1)$, not proportional, so H5 fails, exactly as the theorem requires |
| $n=4$ | range is $[2,2]$: the single admissible $r$ is $2$, which is both the abelian floor and the cap | consistent, and the unique candidate $\mathfrak{so}(2)\oplus\mathfrak{so}(2)$ is simultaneously a maximal torus and the balanced split $\mathfrak{so}(n/2)^{\oplus2}$ |
| $n=5$ | range $[2.5,3.75]$: the only integer is $r=3$ | consistent with the record's single odd-$n$ member $\mathfrak{so}(3)\subset\mathfrak{so}(5)$, and §7.2 evaluates it |
| **odd $n$** | $n(n-2)$ is a product of two odd numbers, hence odd, hence not divisible by $4$; so $r<n(n-2)/4$ strictly and $\theta<\theta_0(n)$ strictly | **CONFIRMED** (claim 13) |
| **$\mathfrak h$ abelian** | the Statement says nothing | §6.1 forces $r=n/2$, so $n$ must be **even** and $\mathfrak h$ is a maximal torus of $\mathfrak{so}(n)$, whose dimension $\lfloor n/2\rfloor$ equals $n/2$ exactly then. At odd $n$ **no abelian $\mathfrak h$ can satisfy H5.** §7.3 checks the even case |
| $\mathfrak h\cong\mathfrak m$ | not in the Statement; the blockquote at :140 records it as needed for "Producing members" | consistent: $\mathfrak h\cong\mathfrak m$ forces $r=N/2=n(n-1)/4>n(n-2)/4$, so the Statement's own cap already excludes it. The blockquote makes exactly this point |

**Quantifier order.** The Statement is $\forall n\,\forall\mathfrak h\,\forall\theta$: *(subalgebra, $0<r<N$, $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$) $\Rightarrow$ (closed forms, cap, equality characterisation)*. The proof respects that order ($\theta$ is existentially eliminated, never chosen) and no step quantifies over members before fixing $\mathfrak h$. **The one place the order slips is the final clause**, *"the maximum over the family is attained exactly at …"*, which is a statement about the family as a whole and therefore needs an existence claim the implication cannot deliver (§5.5).

## 7. A universal claim with no witness, one subalgebra from each structured family

The Statement quantifies over all subalgebras and exhibits none. Below, one member of each family the record names, evaluated by hand. **$\Lambda:=[n/2,\;n(n-2)/4]$ is the admissible window of §6.1.**

### 7.1 $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$

$r-\tfrac{n(n-2)}4=\tfrac{(p-q)^2}4$ (§5.4). So the split family meets the cap exactly at $p=q$ and exceeds it everywhere else, **no unbalanced split is a member**, and each fails by a computable amount. Named instances: $\mathfrak{so}(5)\oplus\mathfrak{so}(7)\subset\mathfrak{so}(12)$ has $r=10+21=31$ against $30$, exceeding by $(5-7)^2/4=1$, the block's own italic example, **CONFIRMED**; $\mathfrak{so}(3)\oplus\mathfrak{so}(5)\subset\mathfrak{so}(8)$ has $r=3+10=13$ against $12$, exceeding by $1$; $\mathfrak{so}(n-1)\oplus\mathfrak{so}(1)$ exceeds by $(n-2)^2/4$. Balanced: $\mathfrak{so}(3)^{\oplus2}\subset\mathfrak{so}(6)$ has $r=6=6\cdot4/4$, at the cap, $\theta=\theta_0(6)=\sqrt{40}/6=\sqrt{10}/3$. **No falsifier.**

### 7.2 The one odd-$n$ candidate, $\mathfrak{so}(3)\subset\mathfrak{so}(5)$

$n=5$, $r=3$, $N=10$, $N-r=7$, $\Lambda=[2.5,3.75]$ so $r=3$ is the only integer in it.

$$\theta=\frac25\sqrt{\frac{3\cdot10}7}=\frac25\sqrt{\frac{30}7}=\frac2 5\cdot\frac{\sqrt{210}}7=\frac{2\sqrt{210}}{35},\qquad \theta_0(5)=\frac{\sqrt{2\cdot4\cdot3}}5=\frac{2\sqrt6}5 .$$

$\theta^2=\tfrac4{25}\cdot\tfrac{30}7=\tfrac{24}{35}$ and $\theta_0(5)^2=\tfrac{24}{25}$, so $\theta/\theta_0=\sqrt{25/35}=\sqrt{5/7}$, strictly below $1$ as the odd-$n$ clause requires. The decimals $0.828\ldots$ and $0.9798\ldots$ are the pair [REVIEW_r25.md](../reviews/REVIEW_r25.md) prints as *"$0.828$ against $0.980$ at $n=5$"*. **Consistent; no falsifier.** $S_{\mathfrak{mmm}}=(N-r)[2(n-2)-4(n-1)r/N]=7[6-\tfrac{4\cdot4\cdot3}{10}]=7[6-4.8]=\tfrac{42}5>0$, so this member is ungraded, which is what the family exists to supply.

### 7.3 A maximal torus

Take $\mathfrak h=$ a maximal torus of $\mathfrak{so}(n)$, $n=2m$ even, $r=m=n/2$. It is abelian, so $S_{\mathfrak{hhh}}=0$ and R1 gives $S_{\mathfrak{hmm}}=\kappa r=2(n-2)\cdot\tfrac n2=n(n-2)$. The value H5 forces is

$$\frac{2\sigma r(N-r)}N=2(n-1)\cdot\frac n2\cdot\frac{n(n-2)/2}{n(n-1)/2}=n(n-1)\cdot\frac{n-2}{n-1}=n(n-2),$$

using $N-r=\tfrac{n(n-1)}2-\tfrac n2=\tfrac{n(n-2)}2$. **The two agree identically, at every even $n$**, so the maximal torus passes every necessary condition the theorem imposes, and sits at the *floor* of $\Lambda$ exactly as §6.1 predicts for an abelian $\mathfrak h$. At $n=6$, $r=3$, $N=15$, $N-r=12$:

$$\theta^2=\frac4{36}\cdot\frac{3\cdot15}{12}=\frac19\cdot\frac{15}4=\frac5{12},\qquad \frac{\theta^2}{\theta_0(6)^2}=\frac{5/12}{10/9}=\frac38,\qquad \frac\theta{\theta_0}=\sqrt{\tfrac38}=\frac{\sqrt6}4 .$$

$\sqrt6/4=0.6123724\ldots$, which is the entry **$0.612$** in the block's own ratio list at [ungraded-slack.md](../findings/ungraded-slack.md):101. **So the torus is already a member of the record's tabulated family, under a name the record never gives it.** No falsifier, and a positive identification the block does not make.

### 7.4 $\mathfrak{su}(m)\subset\mathfrak{so}(2m)$, and the ambiguity in that name

**Standard embedding (the Berger entry).** $n=2m$, $r=m^2-1$, cap $=m(m-1)=m^2-m$, so $r-\text{cap}=m-1>0$ for every $m\ge2$: **the standard $\mathfrak{su}(m)$ exceeds the cap at every $m\ge2$**, hence is never a member. No falsifier.

**Adjoint embedding.** $\mathfrak{su}(3)\subset\mathfrak{so}(8)$ via the adjoint representation has $n=8$, $r=8$, $N=28$, $N-r=20$, and $\Lambda=[4,12]$ contains $8$:

$$\theta^2=\frac4{64}\cdot\frac{8\cdot28}{20}=\frac1{16}\cdot\frac{56}5=\frac7{10},\qquad\theta=\sqrt{7/10}=0.836660\ldots,$$

exactly the $0.836660$ the block's Verification paragraph prints. $S_{\mathfrak{mmm}}=20[12-\tfrac{4\cdot7\cdot8}{28}]=20[12-8]=80>0$: a genuine ungraded member. **So "$\mathfrak{su}(m)$" names both an excluded case and a member depending on the embedding, and the block writes it unqualified in its exclusion list.** Flagged; the intended reading (the Berger list, hence the standard embedding) is clear from context, so this is a naming hazard rather than an error.

### 7.5 DISCREPANCY D3, the "$m\le2$" qualifier

**Locate.** [ungraded-slack.md](../findings/ungraded-slack.md):142, verbatim: *"The subalgebras that exceed the cap are $\mathfrak g_2\subset\mathfrak{so}(7)$ at $r=14$ against $8.75$, $\mathfrak{spin}(7)\subset\mathfrak{so}(8)$ at $r=21$ against $12$, $\mathfrak{so}(n-1)\subset\mathfrak{so}(n)$, and $\mathfrak u(m)$, $\mathfrak{su}(m)$, $\mathfrak{sp}(m)\oplus\mathfrak{sp}(1)$ at $m\le2$, together with the unbalanced splits."*

**Exhibit.** For $\mathfrak{sp}(m)\oplus\mathfrak{sp}(1)\subset\mathfrak{so}(4m)$: $r=m(2m+1)+3=2m^2+m+3$ and the cap is $\tfrac{4m(4m-2)}4=4m^2-2m$, so $r-\text{cap}=-2m^2+3m+3$, positive exactly for $2m^2-3m-3<0$, i.e. $m<\tfrac{3+\sqrt{33}}4=2.186\ldots$, i.e. **$m\le2$**, the qualifier is exactly right there ($m=2$: $r=13$ against $12$; $m=3$: $r=24$ against $30$, below the cap). For $\mathfrak u(m)$ it is false at every $m\ge3$: $\mathfrak u(3)\subset\mathfrak{so}(6)$ has $r=9$ against a cap of $6$, so it exceeds and the sentence (if the qualifier distributes), would deny it. Same for $\mathfrak{su}(m)$ by §7.4.

**Argue the opposite.** The most charitable reading is that the qualifier attaches only to the item it follows, $\mathfrak{sp}(m)\oplus\mathfrak{sp}(1)$, which is the only one of the three that needs it, and, being the only one that needs it, is presumably why it is there at all. On that reading the sentence is correct and merely comma-thin. **The candidate survives as a live ambiguity** because the error it invites runs in the dangerous direction: a consumer reading the qualifier as distributive concludes that $\mathfrak u(3)$ and $\mathfrak{su}(4)$ do *not* exceed the cap, and both do. **Repair: move "at $m\le2$" to sit only against $\mathfrak{sp}(m)\oplus\mathfrak{sp}(1)$.** The parallel sentence at [ungraded-slack.md](../findings/ungraded-slack.md):97 carries no qualifier at all and is therefore not exposed to this.

### 7.6 DISCREPANCY D4, the $\Lambda^4$ argument covers one case and is asserted for a family

**Locate.** [ungraded-slack.md](../findings/ungraded-slack.md):144, verbatim: *"$\mathfrak{so}(n-1)$ and every unbalanced split have $(\Lambda^4\mathbb R^n)^K=0$ identically, since $\Lambda^4\mathbb R^n=\Lambda^4\mathbb R^{n-1}\oplus\Lambda^3\mathbb R^{n-1}$ over $O(n-1)$ and neither summand carries an invariant for $n\ge6$"*.

**Exhibit.** The displayed decomposition is the branching for the split $(n-1,1)$ and for no other. At $\mathfrak{so}(3)\oplus\mathfrak{so}(5)\subset\mathfrak{so}(8)$, an unbalanced split, the relevant branching is $\Lambda^4\mathbb R^8=\bigoplus_{i+j=4}\Lambda^i\mathbb R^3\otimes\Lambda^j\mathbb R^5$ over $O(3)\times O(5)$, which the quoted sentence does not describe. **The conclusion is not thereby wrong**, but the written justification does not reach the family it is asserted for.

**Argue the opposite.** The most charitable reading is that the sentence gives the argument at its representative case and leaves the general branching to the reader as routine. That is a normal expository move, and the paragraph's point is the *contrast* with $\mathfrak g_2$ and $\mathfrak{spin}(7)$ rather than a census. **The candidate survives as an argument-coverage gap and not as a false statement**, and it is confined to the "what the hypotheses exclude" paragraph, which no numbered claim depends on.

### 7.7 The Berger-list cases the block says the cap excludes

| $\mathfrak h$ | $n$ | $r$ | cap $n(n-2)/4$ | exceeds? |
|---|---|---|---|---|
| $\mathfrak g_2$ | $7$ | $14$ | $35/4=8.75$ | **yes**, by $21/4$ |
| $\mathfrak{spin}(7)$ | $8$ | $21$ | $12$ | **yes**, by $9$ |
| $\mathfrak u(m)$ | $2m$ | $m^2$ | $m(m-1)$ | **yes**, by $m$, every $m\ge1$ |
| $\mathfrak{su}(m)$, standard | $2m$ | $m^2-1$ | $m(m-1)$ | **yes**, by $m-1$, every $m\ge2$ |
| $\mathfrak{sp}(m)\oplus\mathfrak{sp}(1)$ | $4m$ | $2m^2+m+3$ | $4m^2-2m$ | **only $m\le2$** |
| $\mathfrak{so}(n-1)$ | $n$ | $\binom{n-1}2$ | $n(n-2)/4$ | **yes**, by $(n-2)^2/4$ |
| unbalanced $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ | $p+q$ | $\binom p2+\binom q2$ |, | **yes**, by $(p-q)^2/4$ |

Every entry of the block's list checks out, with the single scoping caveat of §7.5. **No structured family produced a falsifier.**

## 8. The slack closed form (claim 16)

The block's closing paragraph states $S=\tfrac r{nN}[4(N-r)-n^2]$ on the family and gives **no derivation**; [REVIEW_r25.md](../reviews/REVIEW_r25.md) records it as *"verified against the definition on all twelve members"*, i.e. numerically. The claim is load-bearing for the sentence *"the cap is that inequality restricted here"*, so it is worth checking. With $S(W)=\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2-\theta\operatorname{tr}(W_-)-\operatorname{tr}(W_-^2)$ ([results.md](../results.md):391), $W_-=\lvert v\rvert\Pi_{\mathfrak m}$, and a member (so $\delta^2=0$ by (F3), $\mathrm{Ric}(W_{\mathfrak h})=0$ by (F2)):

- $\mathrm{Ric}$ satisfies $\operatorname{tr}_{\mathbb R^n}\mathrm{Ric}(A)=2\operatorname{tr}_{\Lambda^2}A$, forced by $\mathrm{Ric}(\mathrm{Id})=(n-1)I_n$ and $\operatorname{tr}\mathrm{Id}=N$. Under (F2), $\mathrm{Ric}(\Pi_{\mathfrak h})$ is scalar, hence $=\tfrac{2r}nI_n$ and $\lVert\mathrm{Ric}(\Pi_{\mathfrak h})\rVert^2=\tfrac{4r^2}n$.
- Ricci-flatness gives $u\,\mathrm{Ric}(\Pi_{\mathfrak h})+v\,\mathrm{Ric}(\Pi_{\mathfrak m})=0$, so $\lvert v\rvert\mathrm{Ric}(\Pi_{\mathfrak m})=u\,\mathrm{Ric}(\Pi_{\mathfrak h})$ and $\lVert\mathrm{Ric}(W_-)\rVert^2=\tfrac{4u^2r^2}n$.
- $\theta\operatorname{tr}(W_-)=\tfrac{(n-1)cr}N\cdot\tfrac{(N-r)cr}N$ and $\operatorname{tr}(W_-^2)=\tfrac{(N-r)c^2r^2}{N^2}$.

Using $u=c(N-r)/N$ and factoring out $\tfrac{c^2r^2(N-r)}{N^2}$,

$$S=\frac{c^2r^2(N-r)}{N^2}\Big[\frac{4(N-r)}n-(n-1)-1\Big]=\frac{c^2r^2(N-r)}{N^2}\cdot\frac{4(N-r)-n^2}n,$$

and $c^2=\tfrac N{r(N-r)}$ collapses the prefactor to $r/N$, giving **exactly** $S=\tfrac r{nN}[4(N-r)-n^2]$. **CONFIRMED by hand.** Two notes:

- $4(N-r)-n^2\ge0\iff N-r\ge n^2/4\iff r\le n(n-2)/4$, so the block's *"non-negative under the same condition"* is right, and the two vanishing loci are the same set, the cross-check is real.
- **The slack formula is a statement about members, not about the conditional theorem.** It uses (F2) and (F3), which the Statement does not carry. A consumer who reads the closing paragraph as an addendum to the Statement is importing two hypotheses.

## 9. Comparing the forms, and reading each citable claim alone (checklist items 4, 5, 6)

### 9.1 The four places the lemma appears

| location | hypothesis $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$? | $0<r<N$? | notes |
|---|---|---|---|
| [ungraded-slack.md](../findings/ungraded-slack.md):130–136, canonical | **yes** | **yes** | the version checked above |
| [results.md](../results.md):397–401, the numbered section | **yes** | **yes** | near-verbatim. Differences: it **adds** the [Lemma L153](../findings/bounds.md) citation for the $2(n-2)$; it **drops** *"in the sense settled elsewhere in this file"*, leaving "$\mathbb Z_2$-graded" with no sense named at all; it **drops** the $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$ remark; and it folds the $n=8$ check into one clause. **The mathematics is identical** |
| [results.md](../results.md):134, the one-line index entry | **no** | **no** | see §9.2 |
| [ROUND_L23.md](ROUND_L23.md), the dispatched brief | **yes** | **yes** | matches [ungraded-slack.md](../findings/ungraded-slack.md):128–150 with the two blockquotes removed. The inequivalence correction survives, folded into "Producing members"; the withdrawn Lie-theoretic reading is correctly absent |

**Lean.** There is **no row for L23 in [lean/INDEX.md](../lean/INDEX.md)**. Two rows *use* the closed form: the row for [L23bound.lean](../lean/HamiltonsCubic/Results/L23bound.lean), titled *"[L23](../results.md)'s extension"*, and the [L105](../lean/HamiltonsCubic/Results/L105.lean) row, which cites $\theta^2=(4/n^2)rN/(N-r)$ and proves it *"strictly increasing in $r$"*, the monotonicity of §4.2. **What an L23 row would have to claim:** given $\kappa=2(n-2)$, the two relations R1 and R2, and the two scalar equations as hypotheses, the identities $S_{\mathfrak{hmm}}=2(n-1)r(N-r)/N$, $\theta^2=\tfrac4{n^2}\cdot\tfrac{rN}{N-r}$ and $S_{\mathfrak{mmm}}=(N-r)[2(n-2)-4(n-1)r/N]$ over $\mathbb Q(n,r)$, plus $S_{\mathfrak{mmm}}\ge0\iff r\le n(n-2)/4$ and $N-r=n^2/4\Rightarrow\theta^2=2(n-1)(n-2)/n^2$. **What it could not claim** without representation theory the base layer lacks: R1, R2, $\kappa=2(n-2)$, and the whole equality-case classification. *That split is exactly the arithmetic-surface/machinery boundary [lean/INDEX.md](../lean/INDEX.md) draws in its own preamble.* The [L105](../lean/HamiltonsCubic/Results/L105.lean) row already evaluates L23's $\theta^2$ at $r=6,7,8$ and $n=6$; note that $r=7,8$ lie **above** the cap $6$ at $n=6$, so those are evaluations of the formula outside the range the derivation permits, legitimate as a comparison of two caps, worth knowing when reading them.

### 9.2 DISCREPANCY D5, the record's own one-line citation restates the withdrawn claim

**Locate.** [results.md](../results.md):134, verbatim: *"**Lemma L23 (landscape). Conjecture A on the subalgebra family, with gradedness doing the separating.** For $W\propto\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$ the value depends on $\dim\mathfrak h$ alone; a sum of squares caps that dimension at $n(n-2)/4$, where the value is $\theta_0(n)$ and $W$ is graded. The family excludes every frontier point."*

**Exhibit.** Read alone, *"a sum of squares caps that dimension at $n(n-2)/4$"* has no antecedent restricting $\mathfrak h$: the sentence's only condition on $\mathfrak h$ is that it be the subalgebra whose $W$ is written, and the eigen-equation is absent. It therefore reads as a bound on the dimension of a subalgebra of $\mathfrak{so}(n)$, which is **the exact claim the block itself withdraws** at [ungraded-slack.md](../findings/ungraded-slack.md):146: *"**The first version read this as a Lie-theoretic bound … and that is withdrawn.**"* Concrete counterexamples to the sentence as it reads: $\mathfrak u(3)\subset\mathfrak{so}(6)$ has $r=9$ against a cap of $6$; $\mathfrak g_2\subset\mathfrak{so}(7)$ has $r=14$ against $35/4$; $\mathfrak{so}(n-1)\subset\mathfrak{so}(n)$ exceeds by $(n-2)^2/4$ at every $n\ge4$. Each is a subalgebra, each has a $W\propto\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$, and none is capped.

**Argue the opposite.** The most charitable reading is that "the value" (the sentence's subject), presupposes a critical value, so a $\mathfrak h$ with no eigen-equation has no "value" and falls outside the sentence's scope silently. That reading rescues the first clause. **It does not rescue the second**, because *"a sum of squares caps that dimension"* has *dimension* as its object, not *value*, and no reading makes a dimension conditional on a criticality the sentence never mentions.

**This is the round's named trap, exactly.** The correction landed at [ungraded-slack.md](../findings/ungraded-slack.md):146, twelve lines below the Statement and in a different file from the index entry that carries the defect; the citable one-liner never took it up. **Verdict: BROKEN**, and the repair is one clause, *"…the eigen-equation caps that dimension at $n(n-2)/4$…"*, or simply restoring "critical" into the subject.

### 9.3 What [Lemma L4](../findings/ungraded-slack.md) uses, against what L23 establishes (checklist item 5)

L4 advertises the closed form as its own at [ungraded-slack.md](../findings/ungraded-slack.md):111–113, and points here for the derivation. Three readings:

- **The closed form itself.** L4 writes *"For a subalgebra $\mathfrak h\subseteq\mathfrak{so}(n)$ with $r=\dim\mathfrak h$, $N=\binom n2$ and $W_{\mathfrak h}$ the unit multiple of $\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$ (two eigenvalues by construction), $\theta=\tfrac2n\sqrt{rN/(N-r)}$"*. **Neither $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$ nor $0<r<N$ appears.** Charitably, "$\theta$" denotes a critical value and criticality is presupposed by the word; L4's own next sentences are careful precisely about when a member is a Casimir, so the presupposition is in the author's mind. **Recorded as an omission in transmission, charitably readable**, but a consumer taking L4's sentence at face value has an unconditional formula, which §9.2 shows is how this record's defects propagate.
- **The monotonicity and the maximiser.** L4's *"At fixed $n$, $\theta$ increases with $r$; the largest subalgebra generating a critical point has $r=n(n-2)/4$"* is exactly §4.2 plus §4.1, and L4 correctly attaches both quantifiers ("at fixed $n$", "$n(n-2)/4$ is not an integer at odd $n$"). **What L4 uses here is what L23 establishes.**
- **The padding arithmetic.** L4's *"$(n,r)=(12,8)$ returns $\sqrt{22/87}=0.502866$"*: $N=66$, $N-r=58$, $\theta^2=\tfrac4{144}\cdot\tfrac{8\cdot66}{58}=\tfrac{528}{2088}=\tfrac{22}{87}$. **Exact, confirmed by hand.**

**So the answer to checklist item 5 is: yes, with one hypothesis dropped.** What L4 uses is L23's conclusion; what it omits from the citation is L23's hypothesis.

### 9.4 Reading the Statement alone, as a consumer would (checklist item 6)

A consumer who takes only [ungraded-slack.md](../findings/ungraded-slack.md):130–134 gets: correct hypotheses (H1–H5), correct closed forms, a correct cap, a correct equality characterisation, **one pointer that does not resolve** ("in the sense settled elsewhere in this file", §5.3), **one mis-assigned attribution** ("the one arrow needing an argument", §5.2), and **one clause that outruns the implication** ("the maximum over the family is attained exactly at …", §5.5) because it asserts existence where the theorem gives only an implication. Nothing in the Statement is false. **What a consumer may cite from L23 alone:**

> Let $\mathfrak h\subseteq\mathfrak{so}(n)$ be a subalgebra with $0<r<N$, in the normalisation where $\{e_i\wedge e_j\}$ is orthonormal and $Q(\mathrm{Id})=(n-1)\mathrm{Id}$. If $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$ then $\theta=\tfrac2n\sqrt{rN/(N-r)}$, $S_{\mathfrak{mmm}}=(N-r)[2(n-2)-4(n-1)r/N]$, and $\tfrac n2\le r\le\tfrac{n(n-2)}4$, the right equality holding iff $S_{\mathfrak{mmm}}=0$ iff $\theta=\theta_0(n)$ iff $(\mathfrak{so}(n),\mathfrak h)$ is a symmetric pair, the left iff $\mathfrak h$ is abelian.

**What a consumer may not cite from L23 alone:** that any $\mathfrak h$ satisfies the hypothesis; that the equality case is $\mathfrak{so}(n/2)^{\oplus2}$ and nothing else; that the maximum is attained; that $W_{\mathfrak h}$ at the balanced split is the Weyl operator of $S^{n/2}\times S^{n/2}$; and that a subalgebra's dimension is bounded by $n(n-2)/4$.

## 10. What would falsify it, and what I did to look

**For the closed forms and the cap.** The falsifier is a subalgebra $\mathfrak h\subseteq\mathfrak{so}(n)$ with $0<r<N$, $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$, and $r>n(n-2)/4$, equivalently, one whose $S_{\mathfrak{hmm}}$ differs from $2(n-1)r(N-r)/N$ while the eigen-equation still holds. Given R1, R2 and $\kappa=2(n-2)$ that object cannot exist, so the only routes to one are (i) an error in R1 or R2, (ii) an error in $\kappa$, (iii) a normalisation mismatch between $Q$ and the structure constants. **What I did:** derived R1 and R2 from total antisymmetry alone; derived $\kappa=2(n-2)$ from the Killing form and checked it against [conventions.md](../findings/conventions.md):49 and against $Q(\mathrm{Id})=(n-1)\mathrm{Id}$ at [problem.md](../findings/problem.md):539; rederived both scalar equations from the $\#$ definition at [conventions.md](../findings/conventions.md):59; checked $n=3$ by hand, where the theorem asserts non-existence, and confirmed $Q(W)\propto(5,-1,-1)$ against $W\propto(2,-1,-1)$; and reproduced exactly, from the closed form, five constants the record prints independently, $\sqrt{7/10}$ at $\mathfrak{su}(3)\subset\mathfrak{so}(8)$, $\sqrt{24/35}$ at $\mathfrak{so}(3)\subset\mathfrak{so}(5)$, $\sqrt6/4$ at the $n=6$ torus, $\sqrt{22/87}$ at the padded object, and $\theta_0(6)^2=10/9$ at the balanced split. **No falsifier, and none of the five structured families the brief names produced one.**

**For the equality case.** The falsifier is a subalgebra $\mathfrak h\subset\mathfrak{so}(n)$, $n$ even, with $r=n(n-2)/4$ and $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$, not $O(n)$-conjugate to $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$. The only dimension where the record itself leaves room is $n=8$, $r=12$, through triality. **What I did:** read [trap W2](../findings/INDEX-traps.md) and [graded-half.md](../findings/graded-half.md):402ff in full; found the four-row table asserted, with an argument that its two $n=8$ entries are new subalgebras and **no argument that the table is complete**; searched [references/](../references/) and found no Helgason, Cartan, Berger or Besse, and nothing else classifying involutions of $\mathfrak{so}(n)$. **I did not construct the missing completeness argument and I do not supply it**, that is the hypothesis debt of §5.4, and a verifier who closed it would be handing the record a fresh proof under the letterhead of a check.

## 11. Verdict

**GAP.**

**What is proven, and I rebuilt every line of it cold:** the two structure-constant relations; the two scalar equations as traces of the eigen-equation; the elimination, forced by a determinant $N/2r\ne0$; $\theta=\tfrac2n\sqrt{rN/(N-r)}$; $S_{\mathfrak{mmm}}=(N-r)[2(n-2)-4(n-1)r/N]$; the cap $r\le n(n-2)/4$ from $S_{\mathfrak{mmm}}\ge0$; $\theta\le\theta_0(n)$ from strict monotonicity; the coincidence of the two equality cases; the chain $S_{\mathfrak{mmm}}=0\iff[\mathfrak m,\mathfrak m]\subseteq\mathfrak h\iff$ sign-graded $\iff$ symmetric pair; the odd-$n$ strictness; and, as a bonus the block does not claim, the slack closed form.

**What is not, and what would have to be shown:**

1. **The equality case's classification** (§5.4), *the involutive automorphisms of $\mathfrak{so}(8)$ with a $12$-dimensional fixed subalgebra form a single $O(8)$-conjugacy class*, plus a read source for the classification of $\mathbb Z_2$-gradings of $\mathfrak{so}(n)$; [references/](../references/) contains none.
2. **Attainment** (§5.5), *(F2)$\Rightarrow$Ricci-flat, (F3)$\Rightarrow$Bianchi-free, and the $K$-invariant traceless Weyl operators are $\mathbb R\,W_{\mathfrak h}$*, all three asserted; and the import $Q(\mathcal W_n)\subseteq\mathcal W_n$, which the record's own [Lemma L4](../findings/ungraded-slack.md) says is *derived nowhere here*. Plus the unwritten identification of $W_{\mathfrak{so}(n/2)^{\oplus2}}$ with the Weyl operator of $S^{n/2}\times S^{n/2}$.

**Corrections owed, in order of cost:**

| | where | what |
|---|---|---|
| **D5** | [results.md](../results.md):134 | **BROKEN**, restates the Lie-theoretic dimension bound the block withdrew. One clause; the repair is to put the eigen-equation back in the subject |
| **D2** | [ungraded-slack.md](../findings/ungraded-slack.md):134 | broken pointer: the sense is **(A) sign-graded**, settled in [graded-half.md](../findings/graded-half.md), not "elsewhere in this file" |
| **D3** | [ungraded-slack.md](../findings/ungraded-slack.md):142 | "at $m\le2$" must attach only to $\mathfrak{sp}(m)\oplus\mathfrak{sp}(1)$; $\mathfrak u(m)$ and $\mathfrak{su}(m)$ exceed the cap at every $m\ge2$ |
| **D1** | [ungraded-slack.md](../findings/ungraded-slack.md):134 | the arrow needing $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$ is *"$\Rightarrow$ symmetric pair"*, not *"$\Rightarrow[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$"* |
| **D4** | [ungraded-slack.md](../findings/ungraded-slack.md):144 | the $\Lambda^4$ branching written is the $(n-1,1)$ one and is asserted for every unbalanced split |
| **add** | Statement, all copies | $\kappa=2(n-2)$ / $Q(\mathrm{Id})=(n-1)\mathrm{Id}$ is a hypothesis of the constants, including the cap (§3.3) |
| **add** | Statement, all copies | the same proof gives $r\ge n/2$, with equality exactly at abelian $\mathfrak h$ (§6.1), the mirror half of the theorem, absent from the record |
| **note** | [ungraded-slack.md](../findings/ungraded-slack.md):101 | the ratio $0.612$ is the maximal torus at $n=6$, exactly $\sqrt6/4$; the record never names that member (§7.3) |

**No finding:** on the quantifier order of the Statement, which is correct throughout except in the attainment clause; on the arithmetic of the exclusion table, every row of which checks (§7.7); on the odd-$n$ clause; on the $\mathfrak h\cong\mathfrak m$ blockquote, whose argument that the criterion without inequivalence contradicts the cap is correct ($r=N/2=n(n-1)/4>n(n-2)/4$); and on any numerical value in the block, none of which I could check without computation and none of which I relied on.

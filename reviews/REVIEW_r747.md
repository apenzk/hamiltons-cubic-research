# Reviewer r747, the two pinned moments of $F_u$, and the check they run on the tabulated $\mathbb{CP}^2$ spectrum (Gate 2, L168)

**Cold brief.** Worked from [BRIEF-g2-l168.md](BRIEF-g2-l168.md) and from what I derived myself; the findings file the brief was cut from stayed shut until every verdict below was fixed. **No numerical work was done.** Every value printed here is exact (rational or symbolic) and the two machine runs were *screens* of arithmetic I had already done by hand, in the sense the brief allows: exact rational and polynomial evaluation of the table I was about to record, never evidence for a positive claim. Log: [agent_logs/g2-l168-r747.log](../agent_logs/g2-l168-r747.log).

## Claim table

| # | Claim | Verdict |
|---|---|---|
| 1 | $\langle F_uh,k\rangle=T(u,h,k)$, with no constant | **PROVEN**, and the constant is impossible, not merely absent |
| 2 | $\mathop{\mathrm{tr}}(F_u)=0$ for all $u\in\mathcal W_n$ | **PROVEN** |
| 3 | $\mathop{\mathrm{tr}}(F_u^2)=\tfrac{(n-1)(2n-1)}4\lVert u\rVert^2$ | **PROVEN, on an inherited constant** |
| 4 | $\lVert T\rVert^2=\tfrac{(n-1)(2n-1)}4\dim\mathcal W_n$ | **PROVEN** |
| 5 | $\mathcal W_n$ absolutely irreducible, $F$ equivariant, at every $n\ge6$ | **PROVEN**, the $O(n)$/$SO(n)$ gap bites only at $n=4$ |
| 6 | The six rows' multiplicities sum to $\dim M_\lambda$; block traces $4,2,\tfrac16,\tfrac12$ | **CONFIRMED**, all six rows, values and multiplicities |
| 7 | The collapse to $\tfrac{(2m+7)(m+3)}6=\tfrac{(2n-1)(n-1)}6$, and $\times\tfrac32$ | **CONFIRMED**, and $253/4$ at $n=12$ |
| 8 | The table holds "identically in $m$", $n\ge6$ | **CORRECTED, it fails at $m=2$ ($n=6$)**: row six's dimension reads $-2$ where the truth is $0$, and the rows then total $86$ against $\dim\mathcal W_6=84$ |
| 9 | "Two scalars not pinning 56 eigenvalues" | **UNDERSTATED**, granting $m$-freeness the identities are 10 scalar conditions, and they *force* the two zero rows; the eigenvalues are still free, and I exhibit witnesses |
| 10 | Blockwise first moment is "more than the identity demands" | **TRUE, BUT THIN**, the identity demands four of the five conditions; the margin is one scalar |
| 11 | $\mathop{\mathrm{tr}}(F_u^3)$ is an invariant cubic **hence** a multiple of $P(u)$ | **REASON REFUTED**, Schur bounds invariant *quadratics*, not cubics; conclusion survives *a fortiori* |
| 12 | $\mathop{\mathrm{tr}}(F_u^3)/\theta^{*3}=\tfrac{2n^2-15n+1}{36}$ | **CONFIRMED** |

**Actionable summary.** The three identities stand and the table's arithmetic is right to the last multiplicity; fix three things on the page, say that $F_u$ is $\pi_{\mathcal W_n}\!\circ B(u,\cdot)$, restrict the table's validity to $m\ge3$ because $n=6$ breaks it, and delete the "hence a multiple of $P(u)$" inference.

---

## 0. Conventions, fixed once

Write $\mathfrak g=\mathfrak{so}(n)\cong\Lambda^2\mathbb R^n$, with $\{\omega_\alpha\}$ an orthonormal basis for the Frobenius metric and structure constants
$$c_{\alpha\beta\gamma}=\langle[\omega_\alpha,\omega_\beta],\omega_\gamma\rangle .$$
The Frobenius metric on $\mathfrak{so}(n)$ is $\mathrm{Ad}$-invariant, so $c$ is **totally antisymmetric** in its three indices. This single fact carries §1.

$S^2(\mathfrak g)$ is the symmetric operators on $\Lambda^2\mathbb R^n$, paired by $\langle X,Y\rangle=\mathop{\mathrm{tr}}(XY)$. $\mathcal W_n\subset S^2(\mathfrak g)$ is the first-Bianchi, Ricci-flat subspace, of dimension $\tfrac{n(n+1)(n+2)(n-3)}{12}$; as an $O(n)$-representation it is $V_{(2,2)}$, the Weyl tensors.

$B(X,Y)=\tfrac12(XY+YX)+X\#Y$ with the halved sharp, normalised so that $B(W,W)=W^2+W^\#=Q(W)$. $F_u=B(u,\cdot)$ followed by orthogonal projection to $\mathcal W_n$ (§1.3). $P(W)=\langle W,Q(W)\rangle$, and $T$ is the symmetric trilinear form with $T(W,W,W)=P(W)$. $m=n-4$ throughout. All of $\theta^*=P(u)=\sqrt{3/2}$, $\lVert u\rVert=1$ and the Killing constant are inherited from the record and are inventoried in §2.

## Hypothesis inventory

| | Hypothesis | Where it is used | Status here |
|---|---|---|---|
| H1 | $n\ge6$ | scope | the arguments need only $n\ge5$; §5 |
| H2 | $\mathcal W_n$ irreducible **and absolutely** irreducible over $\mathbb R$ | Schur, both moments | **derived**, §5 |
| H3 | $F$ equivariant: $F_{g\cdot u}(g\cdot h)=g\cdot F_u(h)$ | Schur, both moments | **derived for all of $O(n)$**, §5.3 |
| H4 | $\#$ halved so $B(W,W)=Q(W)$ | the whole of §1 | **load-bearing**; a factor here is the one thing that rescales $\lVert T\rVert^2$ |
| H5 | $F_u$ carries $\mathcal W_n$ to $\mathcal W_n$ | $F_u$ being an endomorphism at all | **needs the projection**, §1.3; harmless for $T$ |
| H6 | $\mathop{\mathrm{tr}}(L_W^2)=\tfrac{(n-1)(2n-1)}4$ at unit $W$ | fixes the Schur multiple | **inherited**, not re-derived here |
| H7 | $u=W_{\mathbb{CP}^2}$ padded, $\lVert u\rVert=1$, $\theta^*=P(u)=\sqrt{3/2}$, $Q(u)=\theta^*u$ | the whole table check | **inherited**; $\theta^{*2}=\tfrac32$ is what the check actually tests, §7.3 |
| H8 | the six rows are the $O(m)$-isotypic decomposition of $\mathcal W_n$ under $\mathrm{Stab}(u)$ | the table | **fails at $m=2$**, §8 |
| H9 | each $F_\lambda$ is real symmetric | §9's forcing of the zero rows | follows from H5 and orthogonality of the isotypic splitting |

---

## 1. Attack 1, $\langle F_uh,k\rangle=T(u,h,k)$, and why no constant can appear

### 1.1 The anticommutator half

For symmetric $X,Y,Z$, $\langle\tfrac12(XY+YX),Z\rangle=\tfrac12\big(\mathop{\mathrm{tr}}(XYZ)+\mathop{\mathrm{tr}}(YXZ)\big)$. Cyclicity gives $\mathop{\mathrm{tr}}(YXZ)=\mathop{\mathrm{tr}}(XZY)$, so the value is $\tfrac12\big(\mathop{\mathrm{tr}}(XYZ)+\mathop{\mathrm{tr}}(XZY)\big)$, which is visibly symmetric in $Y\leftrightarrow Z$ and, being also symmetric in $X\leftrightarrow Y$ by construction, is totally symmetric. This uses cyclicity of the trace and nothing else, so it holds on all of $S^2(\Lambda^2)$ and *a fortiori* on $\mathcal W_n$, the brief's worry that the symmetry might be lost on the subspace is empty: passing to a subspace can only lose relations that a form fails to have, never symmetry it already has.

### 1.2 The sharp half

Set
$$\Phi(R,S,T)=\sum c_{\alpha\gamma\mu}\,c_{\beta\delta\nu}\;R_{\gamma\delta}\,S_{\mu\nu}\,T_{\alpha\beta},$$
the coupling that defines the halved sharp, so that $\langle R\#S,T\rangle=\Phi(R,S,T)$ and $R\#R=R^\#$. Three relabelings settle total symmetry, each consuming exactly two sign flips of the totally antisymmetric $c$:

- $R\leftrightarrow T$: relabel $\alpha\leftrightarrow\gamma$, $\beta\leftrightarrow\delta$. Then $c_{\gamma\alpha\mu}c_{\delta\beta\nu}=(-c_{\alpha\gamma\mu})(-c_{\beta\delta\nu})$, the two signs cancel.
- $S\leftrightarrow T$: relabel $\alpha\leftrightarrow\mu$, $\beta\leftrightarrow\nu$, with $c_{\mu\gamma\alpha}=-c_{\alpha\gamma\mu}$ and $c_{\nu\delta\beta}=-c_{\beta\delta\nu}$.
- $R\leftrightarrow S$: relabel $\gamma\leftrightarrow\mu$, $\delta\leftrightarrow\nu$, with $c_{\alpha\mu\gamma}=-c_{\alpha\gamma\mu}$ and $c_{\beta\nu\delta}=-c_{\beta\delta\nu}$.

So $\Phi$ is symmetric under the full $S_3$, and $\langle X\#Y,Z\rangle$ is totally symmetric. The proof-as-written calls this "the standard symmetry of $\#$"; it is standard, and it is exactly the total antisymmetry of $c$, which in turn is exactly $\mathrm{Ad}$-invariance of the metric on $\Lambda^2$.

### 1.3 The projection, which the page does not mention

$Q$ preserves first Bianchi, but Ricci-flatness of $u$ and $h$ does not by itself make $B(u,h)$ Ricci-flat, so $F_u$ must be read as $\pi_{\mathcal W_n}\circ B(u,\cdot)$ for $F_u$ to be an endomorphism of $\mathcal W_n$ at all. This is harmless and the page should simply say it: $\pi$ is orthogonal and $k\in\mathcal W_n$, so
$$\langle F_uh,k\rangle=\langle\pi B(u,h),k\rangle=\langle B(u,h),k\rangle=T(u,h,k),$$
unchanged. The same line makes $F_u$ self-adjoint on $\mathcal W_n$, which §3 and §9 both need. Read this way, $(\mathcal W_n,\;(X,Y)\mapsto\pi B(X,Y),\;\langle\,,\rangle)$ is a metrised commutative algebra and $F_u=L_u$ is its multiplication operator, which is what makes $\mathop{\mathrm{tr}}(L_XL_Y)$ the Killing form and H6 the statement it is.

### 1.4 No constant is possible

Stronger than the page claims. A symmetric trilinear form on a real vector space is determined by its cubic diagonal (polarisation). $\langle B(\cdot,\cdot),\cdot\rangle$ is symmetric by §§1.1–1.2 and its diagonal is $\langle B(W,W),W\rangle=\langle Q(W),W\rangle=P(W)$, which is the diagonal defining $T$. Hence $\langle B(X,Y),Z\rangle=T(X,Y,Z)$ **identically**, and a spurious constant would have to be $1$. The only way a factor could enter is upstream, at H4: if the sharp were normalised so that $B(W,W)=W^2+2W^\#$ or $W^2+\tfrac12W^\#$, then $B$'s diagonal would not be $Q$ and $T$ would be a different form. The word "halved" in the definition is therefore doing real work and should stay.

**Verdict: PROVEN**, with the projection to be written in.

## 2. Attack 2, the two Schur arguments, and the range each needs

### 2.1 Irreducibility

$\mathcal W_n=V_{(2,2)}$, the traceless part of the curvature tensors. Its complexification is the $O(n,\mathbb C)$-representation attached to the two-row diagram $(2,2)$, which is irreducible whenever the diagram is $O(n)$-admissible, i.e. whenever the first two column lengths sum to at most $n$: here $2+2\le n$, so $n\ge4$. For $SO(n)$ one extra caveat applies, a diagram with exactly $\lfloor n/2\rfloor$ rows splits into a self-dual pair. $(2,2)$ has two rows, so this bites only at $n=4$. **For every $n\ge5$, $\mathcal W_n$ is irreducible under $SO(n)$ and under $O(n)$**; at $n=4$ it is $O(4)$-irreducible ($10$-dimensional) but splits $5\oplus5$ under $SO(4)$.

### 2.2 Absolute irreducibility

The complexification is irreducible as just described, so the real form is absolutely irreducible and $\mathop{\mathrm{End}}_{O(n)}(\mathcal W_n)=\mathbb R$ for $n\ge4$, $\mathop{\mathrm{End}}_{SO(n)}(\mathcal W_n)=\mathbb R$ for $n\ge5$. This is what the quadratic argument needs and it is correctly named in the proof.

### 2.3 Equivariance: $O(n)$, not merely $SO(n)$

For $g\in O(n)$, $\Lambda^2g$ is orthogonal on $\Lambda^2\mathbb R^n$ and $\mathrm{Ad}(g)$ is an inner-product-preserving Lie algebra automorphism of $\mathfrak{so}(n)$, so $c_{\alpha\beta\gamma}$ is $\mathrm{Ad}(g)$-invariant for **all** of $O(n)$, reflections included. Matrix product and $\#$ are therefore both $O(n)$-natural, hence so are $B$, $\pi$ and $F$. So $u\mapsto\mathop{\mathrm{tr}}(F_u^k)$ is $O(n)$-invariant for every $k$.

### 2.4 What each argument needs

| argument | needs | range |
|---|---|---|
| $\mathop{\mathrm{tr}}(F_u)=0$ | $\mathcal W_n$ irreducible and **not** the trivial representation | $n\ge4$, under either group |
| $\mathop{\mathrm{tr}}(F_u^2)=c\lVert u\rVert^2$ | commutant $=\mathbb R$, so that invariant bilinear forms are one-dimensional | $n\ge5$ under $SO(n)$; $n\ge4$ under $O(n)$ |

The $O(n)$-versus-$SO(n)$ distinction therefore **does not matter anywhere in scope**. It would matter at $n=4$, where $SO(4)$ admits the two invariant quadratics $\lvert W^+\rvert^2$ and $\lvert W^-\rvert^2$ and the Schur step is simply false, and there $F$'s full $O(4)$-equivariance is what would rescue it. Worth one sentence on the page, since it is the only place the reader could be misled.

The multiple is then fixed by evaluating at any unit $u$, and H6 supplies it: $c=\tfrac{(n-1)(2n-1)}4$. **This is a citation, not a derivation**, and I did not re-derive it; the verdict on claim 3 is conditional on that prior Gate 2 pass.

**Verdict: PROVEN.**

## 3. Attack 3, the summation

With $\{u_a\}$ orthonormal in $\mathcal W_n$ and $F_u$ self-adjoint (§1.3),
$$\mathop{\mathrm{tr}}(F_{u_a}^2)=\sum_b\langle F_{u_a}^2u_b,u_b\rangle=\sum_{b,c}\langle F_{u_a}u_b,u_c\rangle\langle F_{u_a}u_c,u_b\rangle=\sum_{b,c}T(u_a,u_b,u_c)\,T(u_a,u_c,u_b)=\sum_{b,c}T(u_a,u_b,u_c)^2,$$
the last step by symmetry of $T$ in its second and third slots. Summing over $a$ gives $\sum_{a,b,c}T(u_a,u_b,u_c)^2=\lVert T\rVert^2$ on the left. On the right $\sum_a\tfrac{(n-1)(2n-1)}4\lVert u_a\rVert^2=\tfrac{(n-1)(2n-1)}4\dim\mathcal W_n$, since each $\lVert u_a\rVert=1$.

Index bookkeeping: one basis, used for the trace resolution, for the insertion, and for the outer sum, and it is the same $\{u_a\}$ throughout. $\lVert T\rVert^2$ is basis-independent (it is the squared norm of $T$ in the induced inner product on $\mathcal W_n^{\otimes3}$) so the identity does not depend on the choice. Nothing to report.

**Verdict: PROVEN.**

## 4. Attack 4, the four block traces, read multiplicity by multiplicity

Read off row by row. Each row: multiplicities first, then the three moments.

| $\lambda$ | $\sum$ mult vs $\dim M_\lambda$ | $\mathop{\mathrm{tr}}F_\lambda/\theta^*$ | $\mathop{\mathrm{tr}}F_\lambda^2/\theta^{*2}$ | $\mathop{\mathrm{tr}}F_\lambda^3/\theta^{*3}$ |
|---|---|---|---|---|
| trivial | $2+6+6+3+2+1=20=\dim M$ ✓ | $-2-1+0+1+1+1=0$ | $2+\tfrac16+0+\tfrac13+\tfrac12+1=4$ | $-2-\tfrac1{36}+\tfrac19+\tfrac14+1=-\tfrac23$ |
| vector | $4+12+4=20=\dim M$ ✓ | $-2+0+2=0$ | $1+0+1=2$ | $-\tfrac12+0+\tfrac12=0$ |
| $\Lambda^2$ | $2+3+1=6=\dim M$ ✓ | $-\tfrac13+0+\tfrac13=0$ | $\tfrac1{18}+0+\tfrac19=\tfrac16$ | $-\tfrac1{108}+0+\tfrac1{27}=\tfrac1{36}$ |
| $S^2_0$ | $6+1+3=10=\dim M$ ✓ | $-1+0+1=0$ | $\tfrac16+0+\tfrac13=\tfrac12$ | $-\tfrac1{36}+0+\tfrac19=\tfrac1{12}$ |
| $V_{(2,1)}$ | $4=\dim M$ ✓ | $0$ | $0$ | $0$ |
| $V_{(2,2)}$ | $1=\dim M$ ✓ | $0$ | $0$ | $0$ |

**All six multiplicity sums match, all four nonzero trace-squares are $4,2,\tfrac16,\tfrac12$ as printed, and every blockwise first moment vanishes.** The brief's own shorthand strings check out too: $-2-1+1+1+1$ (the trivial row, with the six zeros silently dropped), $-2+2$, $-\tfrac13+\tfrac13$, $-1+1$. No transcription defect found.

**One further check the page does not run, and it is the strongest evidence the table is not mistyped.** The six rows must exhaust $\mathcal W_n$:
$$20+20m+6\cdot\tfrac{m(m-1)}2+10\cdot\tfrac{(m+2)(m-1)}2+4\cdot\tfrac{m(m-2)(m+2)}3+1\cdot\tfrac{m(m+1)(m+2)(m-3)}{12}=\tfrac{m^4}{12}+\tfrac43m^3+\tfrac{89}{12}m^2+\tfrac{97}6m+10,$$
and $\dim\mathcal W_{m+4}=\tfrac{(m+1)(m+4)(m+5)(m+6)}{12}=\tfrac{m^4+16m^3+89m^2+194m+120}{12}$, the same polynomial. This is an identity in $m$ that six independently wrong entries would not satisfy, and it pins the $\dim M_\lambda$ column, which the moment collapse alone does not touch. It also sets up §8.

**Verdict: CONFIRMED.**

## 5. Attack 5, the collapse

$$\sum_\lambda\dim V_\lambda\cdot\frac{\mathop{\mathrm{tr}}(F_\lambda^2)}{\theta^{*2}}=4+2m+\frac{m(m-1)}2\cdot\frac16+\frac{(m+2)(m-1)}2\cdot\frac12=4+2m+\frac{m(m-1)}{12}+\frac{(m+2)(m-1)}4,$$
matching the display. Over $12$:
$$\frac{48+24m+(m^2-m)+3(m^2+m-2)}{12}=\frac{4m^2+26m+42}{12}=\frac{2m^2+13m+21}6=\frac{(2m+7)(m+3)}6 .$$
Substituting $m=n-4$: $2m+7=2n-1$ and $m+3=n-1$, giving $\tfrac{(2n-1)(n-1)}6$; times $\theta^{*2}=\tfrac32$ this is $\tfrac{(n-1)(2n-1)}4$. At $n=12$: $\tfrac{23\cdot11}4=\tfrac{253}4$. Every step exact, every step as printed.

**Verdict: CONFIRMED.**

## 6. Attack 8 (value) and the third moment's arithmetic

$$\sum_\lambda\dim V_\lambda\frac{\mathop{\mathrm{tr}}(F_\lambda^3)}{\theta^{*3}}=-\frac23+0\cdot m+\frac{m(m-1)}2\cdot\frac1{36}+\frac{(m+2)(m-1)}2\cdot\frac1{12}=\frac{-48+(m^2-m)+3(m^2+m-2)}{72}=\frac{4m^2+2m-54}{72}=\frac{2m^2+m-27}{36},$$
and $2(n-4)^2+(n-4)-27=2n^2-15n+1$. So $\mathop{\mathrm{tr}}(F_u^3)=\theta^{*3}\tfrac{2n^2-15n+1}{36}$ exactly as claimed. **CONFIRMED.**

The *reason* attached to it is a different matter, §10.

## 7. Attacks 6 and 9 continued, what the check actually licenses

### 7.1 The two moments do not pin the spectra: two witnesses

Both live entirely inside the trivial row, whose weight $\dim V_{\text{trivial}}=1$ is $m$-free, so each preserves the weighted identities *identically in $m$*. Take the trivial row's $20$-tuple and replace one $-1$ and the single $+1$ by $(-1+q,\,1-q)$, and two of the six zeros by $(s,-s)$. The first moment is untouched. The second moment changes by $2(1-q)^2-2+2s^2$, which vanishes iff
$$s^2=q(2-q)\qquad\Longleftrightarrow\qquad (1-q)^2+s^2=1,$$
a circle, whose rational points are $q=\tfrac{2t^2}{1+t^2}$, $s=\tfrac{2t}{1+t^2}$.

- **Witness A ($m$-free, rational), $t=\tfrac12$:** $q=\tfrac25$, $s=\tfrac45$. Trivial row becomes $-1,\,-\tfrac35,\,\tfrac35,\,-\tfrac16^{\times6},\,0^{\times4},\,\tfrac45,\,-\tfrac45,\,\tfrac13^{\times3},\,\tfrac12^{\times2}$, twenty values, first moment $0$, second moment $4$.
- **Witness B ($m$-dependent, rational in $m$), $t=\tfrac1m$:** $q=\tfrac2{m^2+1}$, $s=\tfrac{2m}{m^2+1}$, and $q(2-q)=\tfrac{2}{m^2+1}\cdot\tfrac{2m^2}{m^2+1}=\tfrac{4m^2}{(m^2+1)^2}=s^2$. First moment $0$ and second moment $4$ for every $m$.

Both are genuinely different spectra from the table for every $m\ge1$, and (since the perturbation replaces two sign-symmetric pairs by two sign-symmetric pairs), **both also preserve the third moment $-\tfrac23$**. So the tabled eigenvalues are not pinned even by three moment identities, and the brief's requested $m$-dependent perturbation exists in closed form. Witness B is the concrete answer to attack 6.

### 7.2 But the assessment *understates* what the identities do pin

The block reads the check as "two scalars". That is right at a single $m$. Read as holding **identically in $m$ with $m$-free block data** (which is how the table is used), each identity is a polynomial identity, and the six dimension polynomials $1,\,m,\,\tfrac{m^2-m}2,\,\tfrac{m^2+m-2}2,\,\tfrac{m^3-4m}3,\,\tfrac{m^4-7m^2-6m}{12}$ are linearly independent. Writing $a_\lambda=\mathop{\mathrm{tr}}(F_\lambda^2)/\theta^{*2}$ and $b_\lambda=\mathop{\mathrm{tr}}(F_\lambda)/\theta^*$, coefficient extraction gives five equations each:

$$\textbf{second moment:}\quad a_5=0,\quad a_4=0,\quad a_2=\tfrac23-a_3,\quad a_1=\tfrac52-a_3,\quad a_0=\tfrac72+a_3 ;$$
$$\textbf{first moment:}\quad b_5=0,\quad b_4=0,\quad b_2=-b_3,\quad b_1=-b_3,\quad b_0=b_3 .$$

Each system has rank $5$ in six unknowns, so each leaves a **one-parameter** family, and the table is the point $a_3=\tfrac12$ (giving $a_0=4,a_1=2,a_2=\tfrac16$, the printed row) and $b_3=0$.

Two consequences the block misses:

1. **The two "0 throughout" rows are forced, not observed.** $a_4=a_5=0$ and $F_\lambda$ real symmetric (H9) give $F_{(2,1)}=F_{(2,2)}=0$ outright. The table's last two rows carry no information beyond the identity.
2. **The check is ten scalar conditions, not two** (five on the $a_\lambda$ and five on the $b_\lambda$), of which the two vanishing rows and three linear relations among the four surviving second moments are genuine content.

So the honest statement is a conjunction: *granting $m$-freeness, the identities pin the block moments to within one parameter each and kill two whole rows; without $m$-freeness they pin nothing at all, and even with it the individual eigenvalues remain free, as Witnesses A and B show.* The block's sentence is true where it lands but sells the check short; the phrase "two scalars" should go.

### 7.3 What the second-moment check is really testing

Note where $\theta^{*2}=\tfrac32$ enters. The table records $\mathop{\mathrm{spec}}(F_\lambda)/\theta^*$, so the collapse yields $\mathop{\mathrm{tr}}(F_u^2)=\theta^{*2}\tfrac{(2n-1)(n-1)}6$, and agreement with the theorem's $\tfrac{(n-1)(2n-1)}4$ holds **iff** $\theta^{*2}=\tfrac32$. The check is therefore a genuine one-scalar consistency test between the tabulated spectral *shape* and the record's independently-obtained $\theta^*=P(u)=\sqrt{3/2}$, not a vacuous rearrangement. This is worth saying on the page, because as written the reader cannot see that $\sqrt{3/2}$ is load-bearing rather than cosmetic.

## 8. Attack 9 and the edges, where the table stops being a decomposition

**$m=2$, i.e. $n=6$, breaks.** The last row's dimension $\tfrac{m(m+1)(m+2)(m-3)}{12}$ is the Weyl dimension formula, valid for $m\ge3$; at $m=2$ it returns $\tfrac{2\cdot3\cdot4\cdot(-1)}{12}=-2$, whereas $\dim V_{(2,2)}(\mathbb R^2)=0$, there is no Weyl tensor in two dimensions. With the true dimensions the six rows total
$$20\cdot1+20\cdot2+6\cdot1+10\cdot2+4\cdot0+1\cdot0=86,$$
against $\dim\mathcal W_6=\tfrac{6\cdot7\cdot8\cdot3}{12}=84$. The rows overshoot by exactly $2$.

*Located:* row six, the $\dim V_\lambda$ entry, at $m=2$. *Exhibited:* $-2$ against $0$, and $86$ against $84$ in closed form. *The opposite reading, argued:* one may say the collapse is untouched, because the two offending rows carry zero spectra and drop out of every moment, and indeed the formal evaluation still gives $\tfrac{(2m+7)(m+3)}6=\tfrac{55}6$ at $m=2$, and $\tfrac32\cdot\tfrac{55}6=\tfrac{55}4=\tfrac{(6-1)(2\cdot6-1)}4$, the right answer. **That defence fails**, and this is the sharp point: rows five and six contribute $0$ dimensions at $m=2$, so the surplus of $2$ must come out of rows *one to four*, at least one of the multiplicity spaces $M_{\text{trivial}},M_{\text{vector}},M_{\Lambda^2},M_{S^2_0}$ is genuinely smaller at $m=2$ than the table says, and with it at least one of $4,2,\tfrac16,\tfrac12$. So the $n=6$ instance of the check is not a check; the correct value $\tfrac{55}4$ there is reached by a polynomial continuation of a decomposition that does not exist at $m=2$. **The theorem still holds at $n=6$** (§2 proves it with no reference to the table) but the table's "identically in $m$" must be read as $m\ge3$.

**$m=3$, i.e. $n=7$: sound, but only if read under $O(m)$.** The rows total $20+60+18+50+20+0=168=\dim\mathcal W_7$ ✓. But under $SO(3)$ the listed types collide ($\Lambda^2\mathbb R^3\cong\mathbb R^3$ and $V_{(2,1)}\cong S^2_0$, both $5$-dimensional) so the isotypic decomposition is not the tabled one. Under $O(3)$ they stay distinct, the two colliding pairs differing by $\det$. Since $\mathrm{Stab}(u)\supseteq1\times O(m)$, the $O(m)$ reading is the right one and is available; the page should say $O(m)$, not $SO(m)$. The same remark rescues $m=2$'s $2$-dimensional types, which under $SO(2)$ are of complex type and would break the multiplicity-space argument outright.

**$m=4$, i.e. $n=8$:** $20+80+36+90+64+10=300=\dim\mathcal W_8$ ✓; the $SO(4)$ splittings of $\Lambda^2$ and $V_{(2,2)}$ are again invisible to $O(4)$.

**Odd $n$:** nothing in §§1–3 or §5 sees the parity of $n$; the diagram-admissibility condition $2+2\le n$ and the two-row/$\lfloor n/2\rfloor$ condition are both parity-blind. H6 is cited for both parities. No issue.

**$u=0$:** all three identities are $0=0$ and hold trivially; the linear and quadratic statements are homogeneous, so the point is not special. The table, by contrast, concerns one specific unit $u$ and says nothing at $u=0$; $\theta^*=P(u)$ is only defined as a nonzero number away from the cone $P=0$.

**Finally, the block decomposition itself needs $u$ to be $O(m)$-fixed** for $F_u=\bigoplus F_\lambda\otimes\mathrm{Id}$ to follow from Schur. It is: $u$ is $W_{\mathbb{CP}^2}$ padded, so $1\times O(m)$ fixes it, $F_u$ commutes with that action, and Schur puts $F_u$ in the claimed form on each isotypic piece with $V_\lambda$ absolutely irreducible over $\mathbb R$, true for $O(m)$ tensor types. Sound as stated once "$SO(m)$" is corrected to "$O(m)$".

## 9. Attack 7, the blockwise first moment

The claim "more than the identity demands" is **true but thinner than it reads**. From §7.2, the first-moment identity read identically in $m$ already forces $b_4=b_5=0$ and $b_0=b_3$, $b_1=b_2=-b_3$, four independent conditions on the five-dimensional space of possible blockwise-trace vectors that could have been nonzero. What is left free is exactly **one scalar**, $b_3=\mathop{\mathrm{tr}}(F_{S^2_0})/\theta^*$, and blockwise tracelessness is the single point $b_3=0$ in that line. So the table's extra content, over what $\mathop{\mathrm{tr}}(F_u)=0$ demands, is one number and not six.

Does anything on the record force $b_3=0$? I found no argument that does, and I did not construct one, under the brief's rule, that is the finding: **the blockwise vanishing is an observed fact with no argument on file**, and it is one dimension's worth of information. If the record wants it, what would have to be proved is $\mathop{\mathrm{tr}}(F_u|_{S^2_0\text{-isotypic}})=0$, whereupon the other three follow from the relations above.

## 10. Attack 8, the third moment's reason is unsound

The block writes: *"$\mathop{\mathrm{tr}}(F_u^3)$ is an invariant cubic, hence a multiple of $P(u)$."* The word doing the work is *hence*, and it has nothing behind it.

**Located.** Schur's lemma gives one-dimensionality for invariant **bilinear** forms, because $\mathop{\mathrm{End}}_{O(n)}(\mathcal W_n)=\mathbb R$ transports across the inner product. There is no such transport for trilinear forms: $\dim\big(S^3\mathcal W_n^*\big)^{O(n)}$ is the multiplicity of the trivial representation in $S^3(V_{(2,2)})$, and absolute irreducibility of $V_{(2,2)}$ says nothing about it. The page uses a lemma outside its range.

**Exhibited.** $\langle W,W^2\rangle$ (the trace of the operator cube on $\Lambda^2$), is a second $O(n)$-invariant cubic on $\mathcal W_n$, built by a different contraction pattern from $P=\langle W,W^2\rangle+\langle W,W^\#\rangle$. The two are proportional only if $\langle W,W^\#\rangle$ is a multiple of $\langle W,W^2\rangle$ **as a function on $\mathcal W_n$**, which the record nowhere establishes. In tensor notation these are the two standard cubic Weyl contractions $W_{ab}{}^{cd}W_{cd}{}^{ef}W_{ef}{}^{ab}$ and $W_a{}^c{}_b{}^dW_c{}^e{}_d{}^fW_e{}^a{}_f{}^b$; the literature on curvature invariants treats them as independent in general dimension, with a dimension-dependent identity collapsing them only at $n=4$. **I flag that last sentence as cited rather than derived**, settling $\dim(S^3\mathcal W_n^*)^{O(n)}$ here would need a computation the brief does not authorise, and I did not run one.

**The opposite reading, argued.** Suppose the space *were* one-dimensional. The block's stated conclusion would then be right by luck, but its argument would still be the quadratic Schur statement applied to a cubic, and the reader has no way to tell. And the conclusion the block draws, *"nothing fixes that constant independently, so the value defines it rather than testing the table"*, **survives either way, indeed a fortiori**: with a two-dimensional space of invariant cubics, one evaluation gives one equation in two unknowns, which is even further from a test than the block admits. So the recommendation is narrow: delete "hence a multiple of $P(u)$", keep the conclusion, and if the record wants the stronger reading it should carry the dimension count as its own claim.

**Verdict: reason REFUTED, conclusion intact, value CONFIRMED.**

## 11. Attack 10, what would break it

1. **A factor at H4.** If the sharp is not halved (if $B(W,W)$ is $W^2+2W^\#$ or $W^2+\tfrac12W^\#$) then $B$'s diagonal is not $P$, $\langle B(X,Y),Z\rangle\ne T$, and $\lVert T\rVert^2$ rescales while $\mathop{\mathrm{tr}}(F_u^2)$ does not. This is the single most dangerous line in the argument and the brief is right to put it first. Everything downstream is insulated once the diagonal is checked to be $P$.
2. **The Killing constant (H6).** $\tfrac{(n-1)(2n-1)}4$ is imported. If that prior pass is ever revised, claims 3, 4 and the entire table check move with it. Nothing here re-derives it.
3. **$\theta^{*2}\ne\tfrac32$.** The one place the numerical value of $P(u)$ enters (§7.3). A revision of $\theta^*$ or of $\lVert u\rVert=1$ turns the table check from a pass into a fail with no other change.
4. **The projection (H5) being non-orthogonal**, or $F_u$ being defined by some other extension off $\mathcal W_n$. Then §1.3's cancellation fails and $\langle F_uh,k\rangle\ne T(u,h,k)$.
5. **A transcription error in the table that preserves the four trace-squares.** Invisible to the collapse by construction, Witnesses A and B are exactly such errors. The multiplicity column is protected by §4's dimension identity; the *values* are protected by nothing on the page.
6. **Dropping below $n=5$.** At $n=4$, $SO(4)$-equivariance alone would leave a two-dimensional space of invariant quadratics and the Schur step would be false. Out of scope, but it is where the $O(n)$/$SO(n)$ care earns its keep.
7. **Reading the table at $n=6$** (§8), or reading its types under $SO(m)$ rather than $O(m)$ at $m\le4$.

---

## Overall verdict

**PROVEN, hypotheses corrected.**

The three displayed identities hold, on the stated inheritance of the Killing constant, for every $n\ge5$ and both parities; the metrisation $\langle F_uh,k\rangle=T(u,h,k)$ is not merely constant-free but forced to be, by uniqueness of polarisation; and the table's arithmetic, six multiplicity sums, four block traces, the collapse, $253/4$ at $n=12$, and the third moment $\tfrac{2n^2-15n+1}{36}$, is exactly right, with the further confirmation that the six rows' dimensions sum to $\dim\mathcal W_n$ as a polynomial identity. Three corrections are owed on the page:

- $F_u$ is $\pi_{\mathcal W_n}\!\circ B(u,\cdot)$, and the isotypic decomposition is under $O(m)$, not $SO(m)$;
- the table is a decomposition only for $m\ge3$, at $m=2$ its rows total $86$ against $\dim\mathcal W_6=84$, so the $n=6$ instance of the check is not a check, though the identity itself is unaffected there;
- "hence a multiple of $P(u)$" is deleted, the conclusion it supports standing without it.

And one assessment is revised rather than corrected: the check is not "two scalars" but ten, which force the last two rows of the table to vanish; the eigenvalues nevertheless remain free, as Witness B, $q=\tfrac2{m^2+1}$, $s=\tfrac{2m}{m^2+1}$, exhibits in closed form for every $m$.

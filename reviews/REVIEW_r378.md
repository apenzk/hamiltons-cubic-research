# REVIEW r378, Gate 2 on the $B$-matrix section and the compression claim

*2026-09-02. Adversarial review of the last section-pair of [ATTEMPTS.md](../ATTEMPTS.md): "The pair clause as one PSD matrix, with three exact vectors from criticality" and "The band's first real lever: the deleted submatrix has at most two eigenvalues in $(0,\theta)$". Every identity below was derived from the definitions before the author's text was opened; the order of work is recorded in [agent_logs/gate2-bmatrix-B.log](../agent_logs/gate2-bmatrix-B.log).*

**Analysis only.** One screen was run (seconds, on an $S^6\times S^6$ matrix built here for the purpose) and it reproduced hand arithmetic that stands without it. It is reported as a screen and is not evidence for any positive claim below.

## Verdicts

| # | Claim | Verdict |
|---|---|---|
| 1 | pair block of $L_e$ is $\tfrac12\mathrm{Id}-\tfrac1{2\theta}B$ | **CONFIRMED**, factor and sign exact, on one silently used rescaling |
| 1b | "the clause is exactly $\ker B=\mathbb Ro$" | **CORRECTED**, it is $\ker B\cap\mathbf1^\perp=\mathbb Ro$ |
| 1c | "$B\succeq0$ on $\mathbf1^\perp$ $\iff$ $B\succeq0$" | **CORRECTED**, conditional on $\theta+M_{jk}>0$, which is now derivable (below) |
| 2 | $B\mathbf1=(\theta+M_{jk})\mathbf1$, $Bu=Bv=M_{jk}(u+v)-u\circ v$, $B(u-v)=0$ | **CONFIRMED**, independently re-derived |
| 2b | "criticality has said nothing yet on $\{\mathbf1,u,v\}^\perp$" | **REFUTED**, by the claim-3 compression, in the author's own next section |
| 3 | at most two eigenvalues of $N$ in $(0,\theta)$ | **CONFIRMED, and not new**, it is Cauchy interlacing on the recorded spectral gap |
| 3b | "the two exceptional directions are confined to $\mathop{\mathrm{span}}\{u,v\}$" | **REFUTED**, witness at $S^6\times S^6$, $n=12$, below |
| 4 | scope: PSD at non-maximal critical points | **CONFIRMED**, criticality alone; but the *strictness* the item needs is sphere-products-only |
| 5 | "the identity and its positivity are on record; the compression step is new" | **CONFIRMED**, with the qualification in claim 3 |

## The derivation, done cold

### The criticality identity is a graph Laplacian, and nothing but hollowness enters

Write $W=M^{\circ2}$ for the Hadamard square, hollow, symmetric, entrywise $\ge0$. Off the diagonal, criticality is $(M^2)_{ij}-\theta M_{ij}=-W_{ij}$. On the diagonal, $(M^2)_{ii}=\sum_lM_{il}^2=(W\mathbf1)_i$ and $\theta M_{ii}=0$. Hence

$$M^2-\theta M\;=\;\mathop{\mathrm{diag}}(W\mathbf1)-W\;=\;L_W\;\succeq\;0,$$

with $\ker L_W$ spanned by the indicators of the connected components of $\mathop{\mathrm{supp}}(M)$. Consequently $\mathop{\mathrm{spec}}(M)\cap(0,\theta)=\varnothing$.

**The hypotheses used are exactly: $M$ symmetric, $M$ hollow, and the off-diagonal criticality equation.** No maximality, no $M\mathbf1=0$, no $\theta>0$. This matters for claim 4 and is recorded again there.

This is [diagonal-half.md](../findings/diagonal-half.md)'s $K^2-\lambda K=L(K_{ab}^2)$ and it is indexed as such in [findings/INDEX.md](../findings/INDEX.md) line 53. The author's screen note is accurate.

### $B$ and its exact vectors

$M\mathbf1=0$ gives $(N\mathbf1)_i=-u_i-v_i$, so $\Delta^{(jk)}=-\mathop{\mathrm{diag}}(u+v)-N$ and

$$B=(\theta+M_{jk})\mathrm{Id}-\mathop{\mathrm{diag}}(u+v)-N=(\theta+M_{jk})\mathrm{Id}-\widetilde N,\qquad \widetilde N:=N-\mathop{\mathrm{diag}}(N\mathbf1).$$

Criticality at $(i,j)$ splits over $l\in I,\,l=j,\,l=k$ into $(Nu)_i=\theta u_i-u_i^2-M_{jk}v_i$, whence $Bu=M_{jk}(u+v)-u\circ v$; the $k$-version is the same with $j\leftrightarrow k$. And $\widetilde N\mathbf1=0$ gives $B\mathbf1=(\theta+M_{jk})\mathbf1$. So all three of the author's boxed vectors reproduce, by an independent route. **CONFIRMED.**

### The compression

For $i,l\in I$, $(M^2)_{il}=(N^2)_{il}+u_iu_l+v_iv_l$, so

$$\Pi(M^2-\theta M)\Pi\;=\;N^2-\theta N+uu^\top+vv^\top\;\succeq\;0 .$$

Sharp eigen-form: for every unit eigenpair $(\nu,w)$ of $N$,

$$\nu(\nu-\theta)+(u\!\cdot\!w)^2+(v\!\cdot\!w)^2\;\ge\;0. \tag{$\star$}$$

## Claim 1, the factor and the sign

$$\tfrac12\mathrm{Id}-\tfrac1{2\theta}B=\tfrac12\mathrm{Id}-\tfrac{\Delta^{(jk)}}{2\theta}-\tfrac{\theta+M_{jk}}{2\theta}\mathrm{Id}=-\tfrac1{2\theta}\big(\Delta^{(jk)}+M_{jk}\mathrm{Id}\big)=\tfrac1\theta\Big[-\tfrac12\Delta^{(jk)}-\tfrac12M_{jk}\mathrm{Id}\Big].$$

The bracket is [Lemma L122](../findings/second-order.md)'s block **verbatim**, and the factor $1/\theta$ is exactly the $L_M\to L_e$ rescaling that [second-order.md](../findings/second-order.md) line 709 records in its own words ("the $\tfrac12$ threshold is in $L_e$ units, L121 and L122 giving $L_M$ eigenvalues whose orbit value is $\theta/2$"). **CONFIRMED.**

**The silently used hypothesis is that rescaling.** The passage writes L122's block and the $L_e$-normalised block as if they were the same object; they differ by $\theta$, and the same conflation is the reason an earlier paragraph of ATTEMPTS could write "$\tfrac12$ is an $L_e$-eigenvalue exactly when $-(\theta+M_{jk})$ is an eigenvalue of $\Delta^{(jk)}$", a step that is false in $L_M$ units and true in $L_e$ units. It should be stated where it is used.

**Cross-check against L24's normalisation, which is stronger than the algebra above.** $\mathrm{Hess}(P|_S)=6\theta(L_e-\tfrac12\mathrm{Id})$ collapses on the pair block to

$$\mathrm{Hess}\big|_{\{j,k\}}\;=\;6\theta\Big(-\tfrac1{2\theta}B\Big)\;=\;-3B,$$

so $\ker B=\ker\mathrm{Hess}$ and $B\succeq0\iff\mathrm{Hess}\preceq0$ on that block, with no $\theta$ left over. Independent numerical anchor, by hand: at $S^6\times S^6$ ($\gamma=-1$, $\alpha=\beta=1.2$, $\theta=11$, $M_{jk}=\alpha$) a within-factor block has $\mathop{\mathrm{spec}}(\widetilde N)=\{10,0,1.2^{\times3},-3.2^{\times5}\}$, hence $\mathop{\mathrm{spec}}(B)=\{2.2,\,12.2,\,11^{\times3},\,15.4^{\times5}\}$ and top $L_e$ value $\tfrac12-\tfrac{2.2}{22}=0.4=\tfrac{p-2}{2(p-1)}$, [Lemma L127](../findings/second-order.md)'s recorded within-factor value on the nose. A wrong factor of $\theta$ would print $0.5-2.2/2=-0.6$.

### 1b, $\ker B=\mathbb Ro$ overstates the clause

$B\mathbf1=(\theta+M_{jk})\mathbf1$, so $\mathbf1$ is itself a kernel vector when $\theta+M_{jk}=0$. The tangent space is $\mathbf1^\perp$, so the clause is

$$\ker B\cap\mathbf1^\perp=\mathbb Ro,$$

which coincides with $\ker B=\mathbb Ro$ **only when $\theta+M_{jk}\ne0$**. **CORRECTED**; harmless in substance, but the boxed statement is the one the item will be quoted from.

### 1c, the $\mathbf1$-eigenvector paragraph, and a derivation of its hypothesis

The passage's "$B\succeq0$ on $\mathbf1^\perp$ is then equivalent to $B\succeq0$ outright" is correctly conditioned on $\theta+M_{jk}>0$, but that inequality is nowhere established at a pure critical point, and it is not free: it is a lower bound on the very entry the pair clause's threshold is built from.

**It is derivable, and the derivation is the one row the compression threw away.** Reading criticality at the entry $(j,k)$: $(M^2)_{jk}=\sum_lM_{jl}M_{lk}=u\!\cdot\!v$ (the $l=j$ and $l=k$ terms vanish by hollowness), so

$$\boxed{\;M_{jk}^2-\theta M_{jk}+u\!\cdot\!v=0\;}$$

Hence if $M_{jk}\le-\theta$ then $u\!\cdot\!v=\theta M_{jk}-M_{jk}^2\le-2\theta^2$. Contrapositive:

$$u\!\cdot\!v>-2\theta^2\;\Longrightarrow\;\theta+M_{jk}>0 .$$

This identity is **not on the record** and it is not in the ATTEMPTS section. It is the missing consistency link between $M_{jk}$ and $(u,v)$, and it also validates the other two identities: $\mathbf1^\top Bu=(B\mathbf1)^\top u=(\theta+M_{jk})(-M_{jk})$ from $B\mathbf1$, while computing $\mathbf1^\top\!\big[M_{jk}(u+v)-u\circ v\big]=-2M_{jk}^2-u\!\cdot\!v$ from $Bu$; the two agree **exactly when** the boxed identity holds. Three independent statements closing on each other.

## Claim 2b, "criticality has said nothing yet" on $\{\mathbf1,u,v\}^\perp$

**REFUTED, by the author's own next section.** $(\star)$ is a criticality consequence and it speaks precisely there: *every eigenvector of $N$ orthogonal to both $u$ and $v$ has eigenvalue outside $(0,\theta)$.* The quadratic form $N^2-\theta N$ is PSD on all of $\mathop{\mathrm{span}}\{u,v\}^\perp$. The two sections were written in sequence and the later one contradicts the earlier one's framing; the framing should go, not the section.

**What survives, and it is sharper than the author's closing sentence.** ATTEMPTS ends with "$B$ carries $\mathop{\mathrm{diag}}(u+v)$, which the compression does not control". The obstruction is structural and worth stating as such:

- $B\succeq0$ is $\lambda_{\max}(\widetilde N)\le\theta+M_{jk}$, a **ceiling** on a spectrum.
- Every criticality consequence in hand is $L_W\succeq0$ and its compressions, **floors** on quadratic forms. $(\star)$ bounds $\nu(\nu-\theta)$ from below, which is vacuous exactly on the branch $\nu\ge\theta$ where the ceiling would have to bite. The compression puts no upper bound on $\lambda_{\max}(N)$ whatsoever.
- And the compression identity $N^2-\theta N+uu^\top+vv^\top\succeq0$ **contains no $M_{jk}$**, while $B$'s threshold $\theta+M_{jk}$ moves with it. So the compression alone can never decide the sign of $B$. The boxed scalar identity above is what re-couples them, and it is the natural next object.

Separately: even granting the containment of claim 3b, the inference "…which is the same span criticality already fixed $B$ on" is a **non-sequitur**. Claim 3b is about eigenvectors of $N$; the span on which criticality fixes $B$ is $\mathop{\mathrm{span}}\{\mathbf1,u,v\}$; and $B=(\theta+M_{jk})\mathrm{Id}-N-\mathop{\mathrm{diag}}(u+v)$ does not share eigenvectors with $N$. At the witness below, $u$ is not an eigenvector of $N$ at all.

## Claim 3, the counting step, and what is actually new in it

**The counting is rigorous.** $S:=\bigoplus_{\nu\in(0,\theta)}E_N(\nu)$ carries $N^2-\theta N$ negative definite, so $n_-(N^2-\theta N)\ge\dim S$; and $N^2-\theta N=(L_W)|_I-uu^\top-vv^\top$ with $(L_W)|_I\succeq0$ gives $n_-\le\mathop{\mathrm{rank}}(uu^\top+vv^\top)\le2$. **CONFIRMED.**

**It is not new.** $\mathop{\mathrm{spec}}(M)\cap(0,\theta)=\varnothing$ is on record, and $N$ is $M$ with two rows and columns deleted. Cauchy interlacing twice gives $\lambda_i(M)\ge\lambda_i(N)\ge\lambda_{i+2}(M)$. Put $p=n_+(M)$; then $\lambda_i(N)\ge\lambda_{i+2}(M)\ge\theta$ for $i\le p-2$, and $\lambda_i(N)\le\lambda_i(M)\le0$ for $i\ge p+1$. **Only the indices $p-1$ and $p$ are unaccounted for**, so at most two eigenvalues of $N$ lie in $(0,\theta)$, the same conclusion, from a textbook fact, with the extra information of *which two indices*. Interlacing is already the record's vocabulary ([bispectral.md](../findings/bispectral.md) line 244 calls a different argument "Cauchy interlacing on one compression").

**What genuinely is new is $(\star)$**, the per-eigenvector inequality, which interlacing does not give, and it is $(\star)$, not the count, that does the work below. The section's headline should be the inequality; the count should be attributed to interlacing.

### 3b, "confined to $\mathop{\mathrm{span}}\{u,v\}$": REFUTED, with the witness

The correct consequence of $(\star)$ is **transversality, not containment**: for $\nu\in(0,\theta)$, $(u\!\cdot\!w)^2+(v\!\cdot\!w)^2\ge\theta\nu-\nu^2>0$, so

$$S\cap\mathop{\mathrm{span}}\{u,v\}^\perp=\{0\},$$

which re-proves $\dim S\le2$ and says nothing about containment. Injectivity of $P_{\mathop{\mathrm{span}}\{u,v\}}|_S$ is not $S\subseteq\mathop{\mathrm{span}}\{u,v\}$.

**Structural reason the containment cannot hold in general.** $S$ is $N$-invariant, so $S=\mathop{\mathrm{span}}\{u,v\}$ would force $\mathop{\mathrm{span}}\{u,v\}$ to be $N$-invariant, and by $Nu=\theta u-u\circ u-M_{jk}v$ that is equivalent to $u\circ u,\,v\circ v\in\mathop{\mathrm{span}}\{u,v\}$, an extra algebraic hypothesis on the entries, which nothing in criticality supplies.

**Witness, at a maximiser of the record's own family, by hand.** $S^6\times S^6$, $n=12$, $\gamma=-1$, $\alpha=\beta=-m\gamma/(m-1)=1.2$, $\theta=-(n-1)\gamma=11$. Take a *within-factor* pair $\{j,k\}\subset F_1$; then $u=v$ (the block is orbit-free) and $\mathop{\mathrm{span}}\{u,v\}$ is one-dimensional. $I=(F_1\setminus\{j,k\})\cup F_2$ is an equitable two-block partition for $N$, with quotient matrix

$$\begin{pmatrix}(p-3)\alpha & q\gamma\\ (p-2)\gamma & (q-1)\beta\end{pmatrix}=\begin{pmatrix}3.6 & -6\\ -4 & 6\end{pmatrix},\qquad \mathop{\mathrm{tr}}=9.6,\ \det=-2.4,$$

eigenvalues $\tfrac12\big(9.6\pm\sqrt{101.76}\big)=9.843808$ and $-0.243808$. The other eigenvector types give $-\alpha=-1.2$ (multiplicity $p-3$) and $-\beta=-1.2$ (multiplicity $q-1$), both negative. So **exactly one** eigenvalue of $N$ lies in $(0,\theta)=(0,11)$, namely $\nu=9.843808$, and $\dim S=1$.

Its eigenvector is constant on each part with ratio $y/x=(3.6-\nu)/6=-1.040635$. But $u$ is $\alpha=1.2$ on $F_1\setminus\{j,k\}$ and $\gamma=-1$ on $F_2$, ratio $-0.833\overline3$. **The two ratios differ, so $w\notin\mathop{\mathrm{span}}\{u,v\}$.** $\square$

$(\star)$ meanwhile holds with room: $\theta\nu-\nu^2=11.3813$ against $(u\!\cdot\!\hat w)^2+(v\!\cdot\!\hat w)^2=23.237$, transversal, and far from contained.

*Screen: the whole of the above was reproduced from the definitions on a self-built $S^6\times S^6$ matrix (criticality residual $1.8\times10^{-15}$, $M^2-\theta M=L_W$ to $1.3\times10^{-15}$): $\mathop{\mathrm{spec}}(N)$, $\mathop{\mathrm{spec}}(B)=\{2.2,11^{\times3},12.2,15.4^{\times5}\}$, top $L_e$ block value $0.400000000$, $\lVert P_{\{u,v\}}w-w\rVert=0.1097$, and $M_{jk}^2-\theta M_{jk}+u\!\cdot\!v=0$ exactly. Reported as a screen of hand arithmetic that stands without it.*

**Note what the witness also shows about the clause's usefulness.** At this point $\mathop{\mathrm{spec}}(B)$ is strictly positive with $\lambda_{\min}(B)=2.2$, so the pair clause holds here with slack, the failure is in the *reasoning*, and the clause would be quoted with the containment attached.

## Claim 4, the scope question, which is the load-bearing one

**(a) Does the compression use anything beyond criticality? No.** Every step is: hollowness and symmetry (for $(M^2)_{ii}=(W\mathbf1)_i$), the off-diagonal criticality equation, and the block decomposition $(M^2)_{il}=(N^2)_{il}+u_iu_l+v_iv_l$. **No maximality, no Ricci-flatness, no $\theta>0$.** So the compression and $(\star)$ are available at every non-maximal pure critical point, which is the regime [I18](../plan.md) needs. **CONFIRMED.**

Note the asymmetry this creates, because it limits the tool: $B$'s definition and $B\mathbf1=(\theta+M_{jk})\mathbf1$ **do** need $M\mathbf1=0$ (as does L122's Laplacian rewriting, per the scope correction at [second-order.md](../findings/second-order.md) line 646), and the $L_e$ rescaling needs $\theta>0$. A tool that never sees a hypothesis the target carries is unlikely to settle the target on its own, the $M_{jk}$-freeness noted under claim 2b is the same fact.

**(b) Does the record's PSD statement hold at non-maximal critical points, or only at maximisers?** It holds at every diagonal critical point, and [diagonal-half.md](../findings/diagonal-half.md) says so in exactly those words ("$K^2-\lambda K\succeq0$ is a property of diagonal **CRITICAL** points, REFUTED as a property of the diagonal locus", Reviewer 129's hand-built $n=8$ witness). The proof there is the same Laplacian rearrangement, and I re-derived it cold above. **So the author's use of it is in scope.**

**(c) But the record's *strictness* is not, and that is where the item's weight sits.** What [diagonal-half.md](../findings/diagonal-half.md) verifies at named points is the strict statement, $K^2-\lambda K\succ0$ on $\mathbf1^\perp$ with margin $\varepsilon_1=\min\{pa_1^2+qc^2,\ qa_2^2+pc^2,\ nc^2\}$, and the connectivity table $1/1$, and every row of that table is a **sphere product**. Off the named families, the record has PSD and no margin, because $\ker L_W$ is one dimension per connected component of $\mathop{\mathrm{supp}}(M)$ and nothing on record forces $\mathop{\mathrm{supp}}(M)$ connected at an arbitrary pure critical point.

This does not damage claim 3, whose counting needs only $\succeq0$. It does mean the section's framing ("the band's first real lever"), inherits the record's weakest form, and **[I18](../plan.md)'s pair clause is a strictness statement**: the open question is $\lambda_{\min}\big(\Delta^{(jk)}|_{\mathbf1^\perp}\big)>-(\theta+M_{jk})$, i.e. $\ker B\cap\mathbf1^\perp=\mathbb Ro$, and a PSD-only input cannot separate an equality case from a strict one. Recording the gap in its accurate form: the compression supplies a **non-strict** floor to an item whose whole content is strictness.

## Claim 5, prior art

- **The identity and its positivity: on record.** [diagonal-half.md](../findings/diagonal-half.md) carries $M^{\circ2}+M^2=\theta M+\mathop{\mathrm{diag}}(s_i)$, the Laplacian reading, the kernel-per-component statement, the connectivity table and Reviewer 129's off-locus refutation; [findings/INDEX.md](../findings/INDEX.md) line 53 indexes it as "the vertex matrix as a graph Laplacian, $K^2-\lambda K=L(K_{ab}^2)$ at a diagonal critical point, PSD for free". The author's screen fired correctly and the section's "claiming nothing new" is honest. **CONFIRMED.**
- **The compression to $I=[n]\setminus\{j,k\}$: not on record**, on a sweep of [findings/](../findings/) for "compress" and "interlac". New to this record.
- **Its counting corollary: on record in substance**, as Cauchy interlacing applied to a spectral gap the record already holds, see claim 3.
- **The scalar identity $M_{jk}^2-\theta M_{jk}+u\!\cdot\!v=0$: not on record**, and this review contributes it.

## Silently used hypotheses, collected

1. **$L_e=L_M/\theta$** (claim 1). Load-bearing for the factor; recorded at [second-order.md](../findings/second-order.md) line 709 and unstated where used.
2. **$\theta+M_{jk}>0$** (claim 1c). Stated as a conditional and never discharged; now discharged under $u\!\cdot\!v>-2\theta^2$.
3. **$\theta+M_{jk}\ne0$** (claim 1b), for $\ker B=\ker B\cap\mathbf1^\perp$.
4. **Ricci-flatness $M\mathbf1=0$**, for $\Delta^{(jk)}=-\mathop{\mathrm{diag}}(u+v)-N$ and for L122's Laplacian form, used throughout the $B$ section, stated in neither.
5. **$\mathop{\mathrm{supp}}(M)$ connected**, assumed by any strict reading of the Laplacian's kernel, verified on record only at sphere products.

## What a successor should do

- Delete "and the two exceptional directions are confined to $\mathop{\mathrm{span}}\{u,v\}$ up to the interlacing, which is the same span criticality already fixed $B$ on" and replace it with $S\cap\mathop{\mathrm{span}}\{u,v\}^\perp=\{0\}$.
- Restate the section's headline as $(\star)$ rather than the count, and attribute the count to interlacing.
- Pursue the boxed scalar identity: it is the only recorded statement that couples $M_{jk}$ to $(u,v)$, and $B$'s threshold is the only place $M_{jk}$ enters. A floor-to-ceiling conversion, if one exists, goes through it.

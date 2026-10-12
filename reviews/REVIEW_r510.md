# REVIEW r510, Lemma L122 ("the pair block is a graph Laplacian of the sectional matrix")

**Target**: [findings/second-order.md](../findings/second-order.md), `#### Lemma L122` (line 629) through the next heading.
**Reviewer**: r510, independent adversarial audit, derived cold from the structure constants before reading [DERIVE-df1.md](DERIVE-df1.md). Analysis-only footing: **no computation was run**; every number below is hand algebra.

**VERDICT: PLAUSIBLE**, the mathematics is right and I reproduced all of it independently. Two defects are in the *statement*, and one of them makes the displayed inequality (the line all the citations use), **false as written**, with an explicit witness recorded 170 lines below it in the same file.

---

## Summary of verdicts

| item | verdict |
| --- | --- |
| 1a. the bracketed matrix, from the structure constants | **CONFIRMED**, every sign and every $\tfrac12$ |
| 1b. the rewriting as $-\tfrac12\Delta^{(jk)}-\tfrac12M_{jk}\mathrm{Id}$ | **CONFIRMED**, under the R2 reading of $\Delta^{(jk)}$ and Ricci-flatness of $M$ in rows $i\notin\{j,k\}$; the phrase naming $\Delta^{(jk)}$ is ambiguous and its literal reading gives a false identity |
| 2. is $f_i=e_{ji}\odot e_{ki}$ orthonormal? | **orthogonal, common norm $\sqrt2$**, no normalisation factor is owed |
| 3. "the Ricci cut on this block is exactly $\sum_ix_i=0$" | **CONFIRMED**, exactly $\mathbf1^\perp$, no weighting; and it needs *nothing* about $M$ |
| 4. "diagonality alone, not criticality, not $\theta>0$, not Ricci-flatness" | **REFUTED in part**, as [Lemma L123](../findings/second-order.md)'s scope paragraph already says, but L123 itself over-corrects on the Ricci-cut clause |
| 5. the consequence $\lambda_{\min}(\Delta^{(jk)}\vert_{\mathbf1^\perp})\ge-(\theta+M_{jk})$ | **constant CONFIRMED** ($\theta$, not $\theta/2$); **the statement is REFUTED as written**, it omits the maximiser hypothesis and [post F48](../findings/second-order.md) in the same file exhibits a critical point where it fails |
| 6. "graph Laplacian" | **overreach in the heading.** $\Delta^{(jk)}$ is a *signed* Laplacian with signed degrees and is **not** positive semidefinite, the lemma's own content is that $\lambda_{\min}<0$ |

---

## 1. The identity, derived from the structure constants

**Conventions used**, all from [conventions.md](../findings/conventions.md): $X\circ Y=\tfrac12(XY+YX)+X\#Y$; $(W^\#)_{\alpha\beta}=-\tfrac12\operatorname{tr}(A_\alpha WA_\beta W)$ with $(A_\alpha)_{\beta\gamma}=c_{\alpha\beta\gamma}$; $c$ totally antisymmetric; $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$ on $\Lambda^2$, under which $\varphi_{ab}=E_{ab}-E_{ba}$ is a **unit** bivector ($\operatorname{tr}(v^2)=-2$); $u\odot v=u\otimes v+v\otimes u$; $M$ coordinate-diagonal means $M\varphi_{ab}=M_{ab}\varphi_{ab}$ with $M_{ab}$ the sectional matrix.

**The structure constants.** From $[\varphi_{ab},\varphi_{cd}]=\delta_{bc}\varphi_{ad}-\delta_{ac}\varphi_{bd}-\delta_{bd}\varphi_{ac}+\delta_{ad}\varphi_{bc}$, $c_{\alpha\beta\gamma}\ne0$ **iff** $\alpha,\beta,\gamma$ are the three pairs of a $3$-subset, and then $c=\pm1$. *Anchor*: $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=2(n-2)\cdot1$, matching [conventions.md](../findings/conventions.md)'s Killing marginal exactly. (*Minor, peripheral*: the same bullet's pair cap "$\sum_\gamma T_{\alpha\beta\gamma}=\lVert[v_\alpha,v_\beta]\rVert^2\le2$" is **loose** here, the true value being $1$; the two lines are only jointly tight in a normalisation where the marginal would be $4(n-2)$. Nothing in L122 depends on it.)

**The symmetrised half.** $f_i$ sends $\varphi_{ki}\mapsto\varphi_{ji}$ and $\varphi_{ji}\mapsto\varphi_{ki}$, so $\tfrac12(Mf_i+f_iM)=\tfrac12(M_{ji}+M_{ki})f_i$. Diagonal, factor $\tfrac12$ from $\circ$. **Confirmed.**

**The $\#$ half, and the $-\tfrac14\to-\tfrac12$ collapse is a theorem, not a convention.** Polarising gives $(M\#X)_{\alpha\beta}=-\tfrac14[\operatorname{tr}(A_\alpha MA_\beta X)+\operatorname{tr}(A_\alpha XA_\beta M)]$. Transposing the second trace and using $A^{\mathsf T}_\alpha=-A_\alpha$ (total antisymmetry of $c$) with $M,X$ symmetric gives $(A_\alpha XA_\beta M)^{\mathsf T}=MA_\beta XA_\alpha$, whose trace is the first by cyclicity. **The two traces are equal**, so $(M\#X)_{\alpha\beta}=-\tfrac12\operatorname{tr}(A_\alpha MA_\beta X)$. *This is the step whose omission produced the withdrawn halved form; it is forced by $A^{\mathsf T}=-A$ alone.*

**Evaluating on the block.** With $X=\sum_ix_if_i$ and $y_m$ the coefficient of $f_m$, $y_m=-\tfrac12\sum_{p,q,s}c_{(jm)pq}\,\mu_q\,c_{(km)qs}\,X_{sp}$. Exactly two families of terms survive:

- $q=(jk)$, forced by $i=m$: $c_{(jm)(km)(jk)}=-1$ and $c_{(km)(jk)(jm)}=-1$, product $+M_{jk}$, contributing $-\tfrac12M_{jk}x_m$.
- $q=(im)$, $i\ne m$: $c_{(jm)(ji)(mi)}=-1$ and $c_{(km)(mi)(ki)}=+1$, product $-M_{mi}$, contributing $+\tfrac12\sum_{i\ne m}M_{mi}x_i$.

Hence $(M\#)\vert_{\{j,k\}}=\tfrac12\big[-M_{jk}\mathrm{Id}+M^{(jk)}\big]$ and

$$L\big|_{\{j,k\}}=\tfrac12\Big[\operatorname{diag}(M_{ji}+M_{ki})-M_{jk}\,\mathrm{Id}+M^{(jk)}\Big].$$

**CONFIRMED verbatim.** Hypothesis used: diagonality of $M$ and nothing else.

**Independent validation, my normalisation reproduces Hamilton's $Q$ on the diagonal locus.** The same structure constants give $(M^\#)_{ab}=\sum_{c\ne a,b}M_{ac}M_{bc}$, so $Q(M)_{ab}=M_{ab}^2+\sum_cM_{ac}M_{bc}$, the record's diagonal-locus form. *This is what pins the factor; the block formula and the $Q$ formula come out of the same constants.*

## 1b. The two expressions are equal, but only under one reading of $\Delta^{(jk)}$, and only with Ricci-flatness

**A DEFECT IN THE WORDING, and its literal reading gives a false identity.** L122 says "$\Delta^{(jk)}$ is the weighted graph Laplacian **of $M$** with rows and columns $j,k$ deleted". Two parses:

- **(R1) delete after**: the principal submatrix of $\Delta=\operatorname{diag}(\sum_bM_{ab})-M$. Under Ricci-flatness $\Delta=-M$, so R1 $=-M^{(jk)}$, and $-\tfrac12\mathrm{R1}-\tfrac12M_{jk}\mathrm{Id}$ **misses the whole $\operatorname{diag}(M_{ji}+M_{ki})$ term**. The identity is false under R1.
- **(R2) delete first**: the Laplacian of the induced subgraph, $\Delta^{(jk)}=\operatorname{diag}(r_i)-M^{(jk)}$ with $r_i=\sum_{i'\notin\{j,k\}}M_{ii'}$. This is the intended object and the identity holds.

The English reads more naturally as R1. **Repair**: write "the weighted graph Laplacian of the hollow submatrix $M^{(jk)}$", or state the row sums.

**The row sums of $\Delta^{(jk)}$, and where $M_{ij},M_{ik}$ went.** By construction the Laplacian's row sums are $0$; the *degrees* are $r_i$, and Ricci-flatness $\sum_bM_{ib}=0$ makes $r_i=-(M_{ij}+M_{ik})$, **the deleted entries, negated**. So $-\tfrac12\Delta^{(jk)}=\tfrac12\operatorname{diag}(M_{ji}+M_{ki})+\tfrac12M^{(jk)}$, and the equality follows. **Matching term by term, the identity holds iff $r_i=-(M_{ij}+M_{ik})$ for every $i\notin\{j,k\}$, i.e. iff $\sum_bM_{ib}=0$ for those $i$: $n-2$ of the $n$ Ricci row-sum conditions**, the rows $j$ and $k$ never entering. *That is the sharp hypothesis and it is sharper than "Ricci-flatness".*

## 2. The basis is orthogonal with a common norm, no factor is owed

With $\varphi_\alpha$ orthonormal in $\Lambda^2$ and $f_i=\varphi_{ji}\varphi_{ki}^{\mathsf T}+\varphi_{ki}\varphi_{ji}^{\mathsf T}$:

- $f_i^2=\varphi_{ji}\varphi_{ji}^{\mathsf T}+\varphi_{ki}\varphi_{ki}^{\mathsf T}$ (the cross terms die on $\varphi_{ji}^{\mathsf T}\varphi_{ki}=0$), so $\lVert f_i\rVert^2=\operatorname{tr}(f_i^2)=2$, **the same for every $i$**.
- $\operatorname{tr}(f_if_m)=0$ for $i\ne m$: the supports $\{(ji),(ki)\}$ and $\{(jm),(km)\}$ are disjoint index sets.

So $\{f_i\}$ is an orthogonal basis of the block, uniformly scaled from an orthonormal one. **A uniform scaling leaves the matrix of an operator unchanged**, so the displayed symmetric matrix *is* the matrix of the self-adjoint $L_M$ in an orthonormal basis, and the quadratic-form and operator readings coincide. **No normalisation factor is owed, and no diagonal congruence can hide in it.** *This is worth stating in the lemma, since it is the only thing that makes "$\lambda_{\min}$" of the displayed matrix mean anything.*

## 3. The Ricci cut is exactly $\mathbf1^\perp$, confirmed, and it is a condition on $X$, not on $M$

For $X=\sum_ix_i\,e_{ji}\odot e_{ki}$ read as a $4$-tensor, $X_{jiki}=x_i$ and $\operatorname{Ric}(X)_{jk}=\sum_bX_{jbkb}=\sum_{i\notin\{j,k\}}x_i$. Every other Ricci component vanishes by character: $\operatorname{Ric}$ transforms under $\varepsilon_a\varepsilon_c$ while $X$ sits in $\varepsilon_j\varepsilon_k$, so only the $(j,k)$ entry can be nonzero. **One relation, $\sum_ix_i=0$.** That is $\mathbf1^\perp$ in the coordinates, and by item 2 it is genuinely the orthogonal complement of $\sum_if_i$ in the block, **exactly $\mathbf1^\perp$, with no weighting.** Dimension $n-3$, matching [Lemma L120](../findings/second-order.md).

**And $\mathbf1$ is the Laplacian's kernel**, so it is an $L$-eigenvector at $-\tfrac12M_{jk}$; the Ricci cut removes precisely that eigenvector and leaves $\mathbf1^\perp$ invariant. *This is what makes "$\lambda_{\min}(\Delta^{(jk)}\vert_{\mathbf1^\perp})$" well posed rather than a compression.*

**AN OVER-CORRECTION IN [Lemma L123](../findings/second-order.md)'s SCOPE PARAGRAPH.** It says the rewriting "**and the identification of the Ricci cut with $\mathbf1^\perp$** both require Ricci-flatness". The first half is right (item 1b). The second half is **wrong**: the derivation above uses only that $X$ lies in the pair block and never touches a row sum of $M$; and $\Delta^{(jk)}\mathbf1=0$ holds by construction of a Laplacian, Ricci-flat or not. What Ricci-flatness of $M$ buys is only that this $\mathbf1^\perp$ is the *same* subspace on which the identity of item 1b holds. **Repair L123's clause to name the rewriting alone.**

## 4. The three negatives, and what the hypothesis actually is

| negative | verdict |
| --- | --- |
| "not criticality" | **true** for the bracketed matrix; **false** for the consequence (item 5) |
| "not $\theta>0$" | **true** for the bracketed matrix, $\theta$ does not appear in it; **false** for the consequence |
| "not Ricci-flatness" | **true** for the bracketed matrix; **false** for the Laplacian rewriting on the same display line |

**Is item 3 in tension with the third negative?** No, once the two Ricci conditions are separated, and the lemma runs them together. They are different statements:

- **Ricci-flatness of the tangent vector $X$** ($\sum_ix_i=0$), is the Weyl cut on the block. It needs nothing about $M$ and is what item 3 is about.
- **Ricci-flatness of $M$** ($\sum_bM_{ab}=0$), is what the Laplacian rewriting needs, in rows $i\notin\{j,k\}$ only.

**The precise statement the identity needs.** *Let $M$ be a symmetric hollow $n\times n$ array and $L_M=M\circ(\cdot)$ with $M$ acting diagonally on $\Lambda^2$. Then the bracketed matrix is the $\{j,k\}$ pair block, unconditionally. If moreover $\sum_bM_{ib}=0$ for every $i\notin\{j,k\}$, that matrix equals $-\tfrac12\Delta^{(jk)}-\tfrac12M_{jk}\mathrm{Id}$ with $\Delta^{(jk)}$ the Laplacian of the induced weighted graph on $[n]\setminus\{j,k\}$.* Nothing else.

## 5. The consequence, the constant is right, the statement is not

**The constant.** [Lemma L24](../findings/second-order.md) reads $\lambda_{\max}(L_e\vert_{W^\perp})\le\tfrac12$ with $L_e=L_M/\theta$, so against $L_M$ it is $\le\theta/2$. Every pair block lies wholly inside $W^\perp$ ([Lemma L120](../findings/second-order.md)'s repair: $W^\perp$ cuts $\mathcal D_n$ and nothing else). Then
$$\lambda_{\max}\big(L\vert_{\mathbf1^\perp}\big)=-\tfrac12\lambda_{\min}\big(\Delta^{(jk)}\vert_{\mathbf1^\perp}\big)-\tfrac12M_{jk}\le\tfrac\theta2\ \Longrightarrow\ \lambda_{\min}\big(\Delta^{(jk)}\vert_{\mathbf1^\perp}\big)\ge-(\theta+M_{jk}).$$
**$\theta$ is correct, not $\theta/2$**: the block is written in $L_M$ units and L24 is applied in $L_M$ units, and the two factors of $\tfrac12$ cancel against the $\tfrac12$ in $L=-\tfrac12\Delta-\tfrac12M_{jk}$. **CONFIRMED.**

**Two independent checks that pin every factor.**

- **The orbit test, done by hand from criticality.** For $x_i=M_{ki}-M_{ji}$, the off-diagonal sum is $(S_{mk}-M_{mj}M_{kj})-(S_{mj}-M_{mk}M_{jk})$ with $S_{ab}=(M^\#)_{ab}$; criticality $S_{ab}=\theta M_{ab}-M_{ab}^2$ turns it into $\theta x_m-(M_{mk}+M_{mj})x_m+M_{jk}x_m$, and the two $M$-dependent pieces cancel the $\operatorname{diag}(M_{jm}+M_{km})$ and $-M_{jk}$ terms exactly, leaving $(Lx)_m=\tfrac\theta2x_m$. **Exactly $\theta/2$, all $M$-dependence cancelling.** Equivalently $\Delta^{(jk)}x=-(\theta+M_{jk})x$, so the bound is attained. Also $\sum_ix_i=0$ by Ricci-flatness, so the orbit direction is admissible.
- **The sphere-product value.** At $S^p\times S^q$ with $(p-1)\alpha+q\gamma=0$, $(q-1)\beta+p\gamma=0$, criticality forces $\theta=-(n-1)\gamma$. Diagonalising the within-factor block by the equitable partition gives eigenvalues $0^{p-3}$, $\tfrac12(2\gamma-\alpha-\beta)$ with multiplicity $q-1$, and $\tfrac{p-2}2(\alpha-\gamma)$; dividing the last by $\theta$ with $\alpha-\gamma=-\gamma(n-1)/(p-1)$ gives exactly $\dfrac{p-2}{2(p-1)}$. **The record's within-factor value is reproduced**, and the multiplicities total $n-3$.

**THE DEFECT, and it is the line the citations use.** L122's consequence is displayed under the lemma's own standing hypothesis ("**Let $M$ be a coordinate-diagonal Weyl operator**"), reinforced one sentence earlier by "**not criticality, not $\theta>0$**". **L24 needs $M$ to be a maximiser**; its own statement is "Let $W$ be a critical point with $\theta=P(W)>0$ … **Hence if $W$ is a maximizer**". So the inequality is stated with a hypothesis set that does not support it, and:

> **[Post F48](../findings/second-order.md), 170 lines below in the same file, is an explicit witness that the inequality FAILS under L122's stated hypotheses.** Pad the $S^6\times S^6$ critical point with two zero rows to $n=14$ and take $\{j,k\}$ to be the two padded indices. Then $M$ is coordinate-diagonal, hollow, symmetric, Ricci-flat, critical, $\theta>0$ (every hypothesis L122 states, and more) and $M_{jk}=0$, $M_{ij}=M_{ik}=0$, so $\Delta^{(jk)}=-M'$ with $M'$ the original $S^6\times S^6$ matrix. Since $M'\mathbf1=0$ the top eigenvector lies in $\mathbf1^\perp$, and $\operatorname{tr}M'=0$ with the recorded gap $\operatorname{spec}(M)\cap(0,\theta)=\varnothing$ forces $\lambda_{\max}(M')>\theta$ at a sphere product. Hence
> $$\lambda_{\min}\big(\Delta^{(jk)}\big|_{\mathbf1^\perp}\big)=-\lambda_{\max}(M')<-\theta=-(\theta+M_{jk}).$$
> **I verified the numbers by hand rather than quoting them.** At $S^6\times S^6$ Ricci-flatness gives $5\alpha+6\gamma=0$ and criticality $\theta=-(n-1)\gamma=11\lvert\gamma\rvert$ with $\gamma<0$, so $\alpha=\tfrac65\lvert\gamma\rvert$. The spectrum of $M'$ is $-\alpha=-1.2\lvert\gamma\rvert$ with multiplicity $10$ (sum-zero within a factor), $0$ on $\mathbf1$, and $5\alpha-6\gamma=12\lvert\gamma\rvert$ on $(1,\dots,1,-1,\dots,-1)$, which lies in $\mathbf1^\perp$. So $\lambda_{\min}(\Delta^{(jk)}\vert_{\mathbf1^\perp})=-12\lvert\gamma\rvert$ against a claimed floor of $-\theta=-11\lvert\gamma\rvert$: **violated by $\lvert\gamma\rvert$, a clean $9\%$ margin, not a rounding question.** *Padding preserves $\theta$ and the norm, so the padded point really is in the band.*
>
> **The inequality is violated.** The mathematics is untouched (the padded point is critical and not maximal, so L24 never applied) but **L122 as written asserts the inequality at exactly this point**.

**The two hypothesis sets, stated plainly**, since the block runs them together:

| | identity | inequality |
| --- | --- | --- |
| $M$ diagonal in the frame | required | required |
| $\sum_bM_{ib}=0$, $i\notin\{j,k\}$ | required for the Laplacian form | required |
| $Q(M)=\theta M$ | not used | required (via L24, and for the orbit eigenvalue) |
| $\theta>0$ | not used | required, at $\theta<0$ the criterion reverses |
| $M$ a **maximiser** | not used | **required, and unstated** |

**Repair**: the consequence line must read "at every **maximiser** $M$ with $\theta>0$". The downstream record already knows this, [ATTEMPTS.md](../ATTEMPTS.md) line 3025 writes "at every maximiser, with equality along the orbit", [r375](REVIEW_r375.md) separates the eigenvector fact from the inequality on exactly this ground, and [post F47](../findings/second-order.md) says [I18](../plan.md)'s whole content is that it is needed at a **non-maximal** critical point. **The defect is confined to L122's own sentence, which is the sentence the citations quote.**

## 6. "Graph Laplacian" is doing more work than it can

$M$ is hollow, symmetric and Ricci-flat, so unless $M=0$ its entries take **both signs**. Therefore:

- $\Delta^{(jk)}=\operatorname{diag}(r_i)-M^{(jk)}$ has **signed weights and signed degrees** $r_i=-(M_{ij}+M_{ik})$.
- It is **not** the standard signed-graph Laplacian $\operatorname{diag}(\sum_{i'}\lvert w_{ii'}\rvert)-A$, which *is* positive semidefinite. It is $\operatorname{diag}(\text{signed row sums})-A$, and it is **not positive semidefinite**, the lemma's own consequence is a *lower* bound on a $\lambda_{\min}$ that is negative, attained at $-(\theta+M_{jk})<0$ whenever the orbit direction is nonzero and $\theta+M_{jk}>0$.

**Exactly two Laplacian properties are used**: symmetry, and $\Delta^{(jk)}\mathbf1=0$ (which is what makes $\mathbf1^\perp$ invariant and matches the Ricci cut). **Nothing else transfers**, no positive semidefiniteness, no Matrix-Tree, no Cheeger inequality, no Perron–Frobenius on $-\Delta$, no monotone eigenvalue interlacing for psd matrices. The heading invites all of them. *[LIT-laplacian-block.md](LIT-laplacian-block.md) asks whether anyone has seen this structure; the answer must be read against the signed, indefinite version, not the classical one.* **Repair**: say "a signed weighted graph Laplacian, indefinite in general" once, in the lemma.

---

## Cross-file check

**Grepped [findings/](../findings/) for $\Delta^{(jk)}$, $M^{(jk)}$ and "pair block".** No file restates the identity with different constants. [findings/INDEX-results.md](../findings/INDEX-results.md) row 122 carries the inequality without the maximiser hypothesis either, inheriting the same defect. Everything downstream in [second-order.md](../findings/second-order.md), [Lemma L127](../findings/second-order.md)'s cross-factor row, [post F47](../findings/second-order.md)'s $\widetilde N=-\Delta^{(jk)}=M\vert_I+\operatorname{diag}(p)$, [post F48](../findings/second-order.md), is **consistent** with what I derived; I checked $\widetilde N=\operatorname{diag}(p)+M^{(jk)}$ against my $\Delta^{(jk)}$ and it matches.

**One live ambiguity inside L122 itself.** The paragraph "The within-factor top eigenvalue is $(p-2)/(2(p-1))$" is in **$L_e$ units** (I verified it: the $L_M$ eigenvalue is $\tfrac{p-2}{2}(\alpha-\gamma)=\theta\cdot\tfrac{p-2}{2(p-1)}$), while the paragraph immediately above it (the orbit direction at $\theta/2$), is in **$L_M$ units**. Neither says which. [Lemma L127](../findings/second-order.md)'s table header ("top $L_e$-eigenvalue") and its closing normalisation note settle it correctly, but L122 does not, and this record has lost a cycle to exactly this collision before ([conventions.md](../findings/conventions.md), the $M$ and $\mu$ entries).

## Repairs owed, in priority order

1. **The consequence line gains "at every maximiser $M$ with $\theta>0$"**, without it, [post F48](../findings/second-order.md)'s padded pair refutes it. Same for [INDEX-results.md](../findings/INDEX-results.md) row 122.
2. **Fold [Lemma L123](../findings/second-order.md)'s scope correction into L122's own text**, since "not Ricci-flatness" is quoted by the citations and corrected only 30 lines below; and **narrow L123's clause** to the rewriting alone, the Ricci cut needing nothing about $M$.
3. **Name $\Delta^{(jk)}$ unambiguously** (the Laplacian of the induced subgraph on $[n]\setminus\{j,k\}$, degrees $-(M_{ij}+M_{ik})$) since the literal reading of the present phrase gives a false identity.
4. **Say "signed" and "indefinite"** where "graph Laplacian" appears, and record that only symmetry and $\Delta\mathbf1=0$ are used.
5. **State that $\{f_i\}$ is orthogonal with $\lVert f_i\rVert^2=2$**, which is what licenses reading the displayed matrix spectrally.
6. **Mark the $(p-2)/(2(p-1))$ paragraph as $L_e$ units.**

## Method note

Everything above is hand algebra: the $\mathfrak{so}(n)$ brackets, the two surviving structure-constant families, the $\#$-polarisation transpose argument, the $Q(M)_{ab}=M_{ab}^2+\sum_cM_{ac}M_{bc}$ anchor, the orbit eigenvalue, the equitable-partition diagonalisation at $S^p\times S^q$, and the padded-pair witness. **No screen and no computation was run**, and none was needed. I derived items 1–3 before opening [DERIVE-df1.md](DERIVE-df1.md).

VERDICT: **PLAUSIBLE**, identity CONFIRMED under a hypothesis narrower than stated; consequence's constant CONFIRMED but its statement REFUTED as written, with the witness at [post F48](../findings/second-order.md).

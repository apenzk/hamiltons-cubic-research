# Verifier v165, Lemma L33, one eigenvalue of one sign forces the tensor to vanish

Read cold from the definitions in [conventions.md](../findings/conventions.md) and the verbatim passages in [BRIEF_L33.md](BRIEF_L33.md), then against the three sites that carry the block, [stratum-two-negative.md](../findings/stratum-two-negative.md) lines 119–176, [results.md](../results.md) lines 152 and 471–480, and [07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) line 1027. **No numerical work was done.** Every value below is exact and was obtained by hand; the two objects I built to test claims against ($\star$ on $\Lambda^2\mathbb R^4$, and $W$ with $W^+=\mathop{\mathrm{diag}}(2,-1,-1)$, $W^-=0$) are closed-form and are exhibited in full. The imported theorem was read at whatever source the repository holds: [Petersen–Wink](../references/petersen-wink-2019-bochner-technique/) is on file and was read; Besse is not on file and could not be. Log: [agent_logs/verify-L33-v165.log](../agent_logs/verify-L33-v165.log).

## The claim table

| # | claim | verdict |
| --- | --- | --- |
| 1 | The operator identity $\sum_\alpha\lambda_\alpha\mathop{\mathrm{ad}}(v_\alpha)^2=2W$ on $\mathrm{Weyl}_m$ | **TRUE**, confirmed at four closed-form objects, one per isotypic piece |
| 2 | First Bianchi is load-bearing; Ricci-flatness only deletes the correction | **TRUE** |
| 3 | The $\Lambda^4$ witness: Ricci-flat, eigenvalue $-4$ rather than $+2$ | **TRUE**, rebuilt cold at $m=4$, the value is exactly $-4$ |
| 4 | $\langle u,N_vu\rangle=2\langle v,u\rangle^2+\lVert[v,u]\rVert^2$, $N_v\succeq0$, $\ker N_v=v^\perp\cap\mathfrak z(v)$ | **TRUE** |
| 5 | The rescaling to $N_x=\sum_iN_{y_i}$ | **TRUE**, $N$ is quadratic in $v$, zero eigenvalues drop out |
| 6 | $\ker N_x\subseteq\bigcap_i\ker N_{y_i}$ from positive semidefiniteness | **TRUE**, and it does need every remaining term on one side |
| 7 | The discharge "$\mathfrak c=0$ would force $m\le3$", the conclusion | **TRUE** |
| 8 | The discharge (the written justification | **DEFECTIVE AS WRITTEN**), a non sequitur at every degenerate $x$; the conclusion survives |
| 9 | The [L32](../findings/isotropy-cap.md) step: hypotheses against this object | **TRUE for the hypotheses L33 names** |
| 10 | [L32](../findings/isotropy-cap.md)'s degenerate case, at corank $1$, i.e. odd $m$ | **NO ARGUMENT ON FILE**, the one sentence offered is vacuous there |
| 11 | [L32](../findings/isotropy-cap.md)'s canonical statement carries its repaired hypothesis | **FALSE**, the statement line carries neither repair, and two different repairs are in circulation |
| 12 | The closing step $y_i=0\Rightarrow W=\pm x\otimes x\Rightarrow x=0$ | **TRUE** |
| 13 | The "in particular" clause, rank $3$ at even $m\ge6$ | **TRUE, and it follows from the main clause** |
| 14 | The lemma is FALSE under the distinct-value reading | **TRUE under the existential reading of "that eigenvector" only** |
| 15 | The $\mathrm{Weyl}_4$ witness $W^+=W^-=\mathop{\mathrm{diag}}(2,-1,-1)$ | **REBUILT COLD AND CORRECT** |
| 16 | "with multiplicity" reaches [results.md](../results.md) and [report/](../report/) | **TRUE at all three quoted sites** |
| 17 | The exception is realised and complete | **TRUE** |
| 18 | Besse §1.143 is the source of the evaluation | **UNHELD CITATION**, no Besse in [references/](../references/), and no derivation of the evaluation anywhere on the record |
| 19 | Petersen–Wink "gives the eigenbasis rewriting and not the evaluation" | **ACCURATE**, verified against the on-file text |

**One line.** The statement of L33 is true, its proof is correct, and every falsifier I could construct against it fails; what the round turns up is that two links the proof consumes, the Weitzenböck *evaluation*, and [L32](../findings/isotropy-cap.md) at corank $1$, which is exactly the case L33's odd-$m$ coverage needs, have no argument anywhere on the record, and that the block's own one-line discharge of $\mathfrak c\ne0$ does not follow from what it says.

**Verdict: GAP.**

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), not restated.

> **The Killing form of $\mathfrak{so}(n)$** is $B(X,Y)=(n-2)\mathop{\mathrm{tr}}(XY)$, with $\mathop{\mathrm{tr}}(v^2)=-2$ for a unit bivector, so $\kappa=2(n-2)$ in an orthonormal basis.

> **A skew matrix's norm**, in the form the stratum arguments use: $\langle X,X\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}X)$, singular values in pairs $s_1,s_1,s_2,s_2,\dots$ with $\sum_i s_i^2=1$.

> **A bivector's norm** … $\lVert\varphi_{ab}\rVert^2=1$ under the half-trace pairing of the bullet above, which is the one every result uses and which makes $\{\varphi_{ab}\}_{a<b}$ orthonormal.

> **Structure constants** $c_{abc}=\langle[v_a,v_b],v_c\rangle$ are **totally antisymmetric**, the inner product being ad-invariant.

> The row marginal is **[Lemma L153](../findings/bounds.md)**, in the general form $\sum_\beta\lVert[v,v_\beta]\rVert^2=2(n-2)\lVert v\rVert^2$ for any $v\in\mathfrak{so}(n)$ at any $n\ge2$.

> **$\mathrm{Alt}$ is the ORTHOGONAL PROJECTION of $S^2(\Lambda^2)$ onto $\Lambda^4$** … **Inside $\Lambda^2\mathbb R^4$, $\Lambda^4$ is one-dimensional and $\mathrm{Alt}$ is the projection onto the Hodge star $\star=\Pi_{SD}-\Pi_{ASD}$, with $\lVert\star\rVert^2=6$.**

> $\dim\mathcal W_n$ | $\frac{n(n-3)(n+1)(n+2)}{12}$, $10$ at $n=4$, $84$ at $n=6$, $1638$ at $n=12$

> $N$ | $\binom n2=\dim\Lambda^2\mathbb R^n$

> $q$, $r$ in [stratum-two-negative.md](../findings/stratum-two-negative.md) | **each carries two senses inside that one file.** $q$ is the Weitzenböck operator at line 142 and a scalar parameter of $W_4(q,r)$ at line 166, twenty-four lines apart; $r$ is the support dimension at line 33 and the second parameter of $W_4$ at line 166.

> **The record's convention is Li's** … $\mathring R(e_i\odot e_j)=\sum_{k,l}R_{iklj}\,e_k\odot e_l$ … [stratum-two-negative.md](../findings/stratum-two-negative.md) is written throughout in BK's $ikjl$, consistently.

Two symbols this block needs are tabled nowhere and I use them as the block does: $\mathfrak c:=\mathfrak z(x)\cap x^\perp$, and $N_v:=2\,v\otimes v-\mathop{\mathrm{ad}}(v)^2$ with $v\otimes v$ meaning $u\mapsto\langle v,u\rangle v$.

## 1. The hypothesis inventory

**A pass with no inventory is not a pass, so here is the whole of it.**

### 1.1 What the statement assumes

| # | hypothesis, as written | what it gives | where the written proof uses it |
| --- | --- | --- | --- |
| H1 | $W\in\mathrm{Weyl}_m$ | (a) first Bianchi; (b) $\mathop{\mathrm{Ric}}(W)=0$; (c) $\mathop{\mathrm{tr}}_{\Lambda^2}W=0$, hence both signs occur at $W\ne0$ | (a) and (b) at the identity; (b) again at the closing line. **(c) is used silently**, see §7 |
| H2 | a **one-dimensional** eigenspace on one side, exactly one eigenvalue counted *with multiplicity* | after rescaling, exactly one term of $\sum_\alpha\lambda_\alpha N_{v_\alpha}=0$ sits on the left and every remaining term is a nonnegative multiple of a PSD operator | the rescaling, and the kernel inclusion. **Both fail without it** |
| H3 | that eigenvector is not a multiple of a complex structure on a $4$-dimensional subspace | discharges [L32](../findings/isotropy-cap.md)'s stated exception | the L32 step |

**No hypothesis is stated and unused.** H1(a), H1(b), H2 and H3 are each consumed at a named line; H1(c) is consumed without being named.

### 1.2 What "one-dimensional eigenspace on one side" means, and how it differs from "one distinct eigenvalue"

Read literally, *"a one-dimensional eigenspace on one side"* is satisfied by a spectrum $(3,1,-2,-2)$, whose $+3$-eigenspace is one-dimensional, and the lemma is false there. The gloss *"exactly one eigenvalue counted with multiplicity"* is what makes the phrase safe: it says the whole of one side of the spectrum is a single eigenvalue of multiplicity one. **The gloss is not decoration; it is the hypothesis.** It is present at all three quoted sites (§9).

The other reading (*one distinct value at any multiplicity*), is the one the block flags as false. §9 rebuilds its witness.

### 1.3 The hypotheses of everything imported

| imported | its hypotheses | checked against this object? |
| --- | --- | --- |
| the Weitzenböck evaluation $q(R)\omega=\mathop{\mathrm{Ric}}\circ\omega+\omega\circ\mathop{\mathrm{Ric}}-2\mathring R\omega$, credited to Besse §1.143 | in Besse this is a statement about the Lichnerowicz Laplacian on a **Riemannian manifold**, i.e. about the curvature tensor of an actual metric | **NOT CHECKED, AND THE SOURCE IS NOT ON FILE.** $W\in\mathrm{Weyl}_m$ is an *algebraic* curvature operator and need not be the curvature of any metric. The identity is pointwise-algebraic and so does transfer, but the transfer is a step the block never states. See §8 |
| [Petersen–Wink](../references/petersen-wink-2019-bochner-technique/) Proposition 1.6 | $R:\Lambda^2V\to\Lambda^2V$ an algebraic curvature operator; $\{\Xi_\alpha\}$ an orthonormal eigenbasis | ✔ satisfied. And the block's characterisation of what PW supplies is accurate, §8 |
| [Lemma L32](../findings/isotropy-cap.md) | $x\ne0$; the repaired hypothesis $\mathfrak c\ne0$ (blockquote) or $m\ne3$ (results.md, report); $x$ not a $4$-plane complex-structure multiple | $x\ne0$ ✔; $\mathfrak c\ne0$ ✔ as a fact, though not by the argument given (§4); the exception ✔, it is verbatim H3. **But L32's own proof covers the case L33 needs at odd $m$ in one sentence that says nothing there** (§5) |
| [Lemma L153](../findings/bounds.md), the row marginal | any $v\in\mathfrak{so}(n)$, any $n\ge2$ | ✔, used only inside this report, as a cross-check |

## 2. The operator identity

**Claim.** $\displaystyle\sum_\alpha\lambda_\alpha\mathop{\mathrm{ad}}(v_\alpha)^2=2W$ on $\mathfrak{so}(m)$, for $W=\sum_\alpha\lambda_\alpha v_\alpha\otimes v_\alpha\in\mathrm{Weyl}_m$.

### 2.1 The identity is an eigenvalue of one $O(m)$-equivariant operator

Write $\mathcal L(A):=-\sum_\alpha\lambda_\alpha\mathop{\mathrm{ad}}(v_\alpha)^2$ for $A=\sum_\alpha\lambda_\alpha v_\alpha\otimes v_\alpha$ symmetric. $\mathop{\mathrm{ad}}(v)$ is skew-adjoint, so $\mathop{\mathrm{ad}}(v)^2$ is symmetric and $\mathcal L$ maps $\mathrm{Sym}^2(\Lambda^2\mathbb R^m)$ to itself, linearly and $O(m)$-equivariantly. So it acts by a scalar on each of

$$\mathrm{Sym}^2(\Lambda^2\mathbb R^m)=\mathbb R\ \oplus\ \mathrm{Sym}^2_0(\mathbb R^m)\ \oplus\ \mathcal W_m\ \oplus\ \Lambda^4 .$$

The claim is exactly that the scalar on $\mathcal W_m$ is $-2$.

**$\mathcal L$ is the operator [isotropy-cap.md](../findings/isotropy-cap.md) already calls $T$.** That file writes $T(A)=-\sum_k\mathop{\mathrm{ad}}(f_k)A\mathop{\mathrm{ad}}(f_k)$ over an orthonormal basis $\{f_k\}$ of $\mathfrak{so}(m)$. On $A=v\otimes v$,

$$\mathop{\mathrm{ad}}(f_k)(v\otimes v)\mathop{\mathrm{ad}}(f_k)u=-\langle[f_k,v],u\rangle\,[f_k,v],\qquad\text{so}\qquad \langle u,T(v\otimes v)u\rangle=\sum_k\langle[f_k,v],u\rangle^2 ,$$

and by ad-invariance $\langle[f_k,v],u\rangle=\langle f_k,[v,u]\rangle$, so the sum is $\lVert[v,u]\rVert^2=\langle u,\mathcal L(v\otimes v)u\rangle$. **$T=\mathcal L$ identically.** That file's line *"$T$ acts on $\mathrm{Sym}(\mathfrak{so}(n))=\mathbb R\oplus\mathrm{Sym}^2_0\oplus\mathrm{Weyl}_n\oplus\Lambda^4$ by $2n-4$, $n-4$, $-2$, $4$"* is therefore this identity and its three siblings, sitting 45 lines above [L32](../findings/isotropy-cap.md) in the file L33 cites, and L33 cites it to Besse instead. It is recorded there as *"verified here with multiplicities matching to the digit"*, i.e. measured, so it is corroboration and not a derivation.

### 2.2 The four scalars, each pinned at a closed-form object

**$\mathbb R$, at the round sphere $R=\mathrm{Id}$.** $R_{ijkl}=\delta_{ik}\delta_{jl}-\delta_{il}\delta_{jk}$ gives $\langle R\varphi_{ij},\varphi_{ij}\rangle=R_{ijij}=1$, so $R=\mathrm{Id}$ on $\Lambda^2$. Then $\langle u,\mathcal L(\mathrm{Id})u\rangle=\sum_\alpha\lVert[v_\alpha,u]\rVert^2=2(m-2)\lVert u\rVert^2$ by [L153](../findings/bounds.md). Scalar $2m-4$. Against the evaluation: $\mathop{\mathrm{Ric}}=(m-1)\mathrm{Id}$, so $\mathop{\mathrm{Ric}}\circ\omega+\omega\circ\mathop{\mathrm{Ric}}-2R\omega=(2(m-1)-2)\omega=(2m-4)\omega$. ✔

**$\mathrm{Sym}^2_0$, at $R=h\owedge g$ with $h$ trace-free.** With $(h\owedge g)_{ijkl}=h_{ik}g_{jl}+h_{jl}g_{ik}-h_{il}g_{jk}-h_{jk}g_{il}$ and $(R\omega)_{ij}=\tfrac12\sum_{kl}R_{ijkl}\omega_{kl}$, the four terms give $(h\omega)$, $(\omega h)$, $(h\omega)$, $(\omega h)$, so $R_{h\owedge g}\omega=h\omega+\omega h=:D_h\omega$. And $\mathop{\mathrm{Ric}}_{ik}=\sum_j(h\owedge g)_{ijkj}=(m-2)h_{ik}+(\mathop{\mathrm{tr}}h)\delta_{ik}=(m-2)h_{ik}$. The evaluation gives $D_{(m-2)h}-2D_h=(m-4)R$. Scalar $m-4$. ✔ matches the record's table.

**$\Lambda^4$, at $R=\star$ on $\Lambda^2\mathbb R^4$, the block's own witness, rebuilt cold.** $\mathfrak{so}(4)=\Lambda^+\oplus\Lambda^-$ as commuting ideals. Take orthonormal $\{s_1,s_2,s_3\}$ of $\Lambda^+$ and $\{a_1,a_2,a_3\}$ of $\Lambda^-$. Every orthonormal pair in $\Lambda^+\cong\mathfrak{su}(2)$ brackets to norm-squared $2$ ([L31](../findings/stratum-two-negative.md)), so $[s_i,s_j]=\sqrt2\,\epsilon_{ijk}s_k$ and

$$\mathop{\mathrm{ad}}(s_i)^2s_j=\sqrt2\,\epsilon_{ijk}[s_i,s_k]=2\,\epsilon_{ijk}\epsilon_{ikj}\,s_j=-2s_j\quad(i\ne j),\qquad \mathop{\mathrm{ad}}(s_i)^2s_i=0 .$$

Hence $-\sum_i\mathop{\mathrm{ad}}(s_i)^2=4\,\Pi_+$ and likewise $-\sum_i\mathop{\mathrm{ad}}(a_i)^2=4\,\Pi_-$, both vanishing on the other ideal. With $\star=\Pi_+-\Pi_-$ its eigenvalues are $+1$ on the $s_i$ and $-1$ on the $a_i$, so

$$\mathcal L(\star)=-\sum_i\mathop{\mathrm{ad}}(s_i)^2+\sum_i\mathop{\mathrm{ad}}(a_i)^2=4\Pi_+-4\Pi_-=4\star .$$

Scalar $+4$, i.e. $\sum_\alpha\lambda_\alpha\mathop{\mathrm{ad}}(v_\alpha)^2=-4\star$. **The block's "$\Lambda^4$ … carries eigenvalue $-4$ rather than $+2$" is exact.** And $\star$ is Ricci-flat: $\mathop{\mathrm{Ric}}=-\sum_\alpha\lambda_\alpha v_\alpha^2$, and $\sum_i s_i^2=\sum_i a_i^2=-\tfrac32\mathrm{Id}$ by symmetry, so the two cancel. **Ricci-flatness alone therefore does not give the identity, and the witness the block names is the right one.** ✔

**$\mathcal W_m$, at $W^+=\mathop{\mathrm{diag}}(2,-1,-1)$, $W^-=0$ in $\mathcal W_4$.** This lies in $\mathcal W_4$: both blocks are trace-free, so $\mathop{\mathrm{Ric}}=0$ and $\langle W,\star\rangle=\mathop{\mathrm{tr}}W^+-\mathop{\mathrm{tr}}W^-=0$, i.e. no $\Lambda^4$ component, i.e. first Bianchi. With $\mu=(2,-1,-1)$ on the $s_i$ and $0$ on the $a_i$, the same bracket table gives, for each $j$,

$$\Big(-\sum_i\mu_i\mathop{\mathrm{ad}}(s_i)^2\Big)s_j=2\Big(\sum_{i\ne j}\mu_i\Big)s_j=2\big(\mathop{\mathrm{tr}}\mu-\mu_j\big)s_j=-2\mu_j\,s_j ,$$

and it kills $\Lambda^-$, where $W$ also vanishes. So $\mathcal L(W)=-2W$, i.e. $\sum_\alpha\lambda_\alpha\mathop{\mathrm{ad}}(v_\alpha)^2=2W$. ✔ **The identity is confirmed, coefficient included.**

*The step "$\mathop{\mathrm{tr}}\mu=0$" in that display is where trace-freeness enters, which is the same place it enters in §7.*

### 2.3 The block's account of which hypothesis does which work

The block says: *"First Bianchi is the load-bearing hypothesis (it alone gives $\mathcal A(R)=2R-(\mathop{\mathrm{Ric}}\cdot\omega+\omega\cdot\mathop{\mathrm{Ric}})$) while Ricci-flatness only deletes the correction."*

This is correct, and the sign is right. First Bianchi is what collapses the 2-form curvature action onto the curvature operator itself: from $R_{ijkl}+R_{iklj}+R_{iljk}=0$ one gets $R_{ikjl}=R_{ijkl}+R_{iljk}$, and relabelling $k\leftrightarrow l$ in the last term against skew $\omega$ gives

$$2\sum_{kl}R_{ikjl}\,\omega_{kl}=\sum_{kl}R_{ijkl}\,\omega_{kl},\qquad\text{i.e.}\qquad \mathring R\,\omega=R\,\omega\ \text{ on }\Lambda^2 .$$

Then $\mathcal A(R):=\sum_\alpha\lambda_\alpha\mathop{\mathrm{ad}}(v_\alpha)^2=-\mathcal L(R)=2R-(\mathop{\mathrm{Ric}}\circ\omega+\omega\circ\mathop{\mathrm{Ric}})$ ✔, and the $\Lambda^4$ computation of §2.2 shows the first Bianchi half cannot be dropped. **The division of labour the block claims is the true one.**

The block's further remark that the deleted term is $\mathop{\mathrm{tr}}(u^2v_\alpha^2)$ is also right: $\mathop{\mathrm{Ric}}=-\sum_\alpha\lambda_\alpha v_\alpha^2$ exactly (from $\mathop{\mathrm{Ric}}(x,x)=\sum_\alpha\lambda_\alpha\lVert v_\alpha x\rVert^2$), and $\langle u,\mathop{\mathrm{Ric}}u+u\mathop{\mathrm{Ric}}\rangle=-\mathop{\mathrm{tr}}(u^2\mathop{\mathrm{Ric}})=\sum_\alpha\lambda_\alpha\mathop{\mathrm{tr}}(u^2v_\alpha^2)$.

### 2.4 An independent consistency check on the coefficient $2$

The same file uses the identity 380 lines later, at [line 523](../findings/stratum-two-negative.md): *"The per-row Bianchi balance (Lemma L33 evaluated at a single $v_\beta$) gives $\sum_{\alpha\ne\beta}\lambda_\alpha\epsilon_{\alpha\beta}=0$ for every $\beta$."* Evaluating $\sum_\alpha\lambda_\alpha\langle v_\beta,N_{v_\alpha}v_\beta\rangle=0$ gives $2\lambda_\beta+\sum_\alpha\lambda_\alpha\lVert[v_\alpha,v_\beta]\rVert^2=0$; substituting the deficit $\epsilon_{\alpha\beta}=2-\lVert[v_\alpha,v_\beta]\rVert^2$ and $\sum_{\alpha\ne\beta}\lambda_\alpha=-\lambda_\beta$ turns it into $\sum_{\alpha\ne\beta}\lambda_\alpha\epsilon_{\alpha\beta}=0$ ✔. At the $\mathcal W_4$ object of §2.2 normalised to $\mu=(2,-1,-1)/\sqrt6$ and $\beta=s_1$: $2\lambda_1=4/\sqrt6$ and $\sum_\alpha\lambda_\alpha\lVert[s_1,v_\alpha]\rVert^2=(-1/\sqrt6)\cdot2+(-1/\sqrt6)\cdot2=-4/\sqrt6$, and they cancel exactly. **A wrong coefficient in $N_v$ would break this consumer, and it does not break.**

## 3. $N_v$, by hand

$N_v:=2\,v\otimes v-\mathop{\mathrm{ad}}(v)^2$. Since $\mathop{\mathrm{ad}}(v)$ is skew-adjoint,

$$\langle u,N_vu\rangle=2\langle v,u\rangle^2-\langle u,\mathop{\mathrm{ad}}(v)^2u\rangle=2\langle v,u\rangle^2+\lVert[v,u]\rVert^2 .$$

Both terms are nonnegative, so $N_v\succeq0$ ✔, and the quadratic form vanishes exactly when $\langle v,u\rangle=0$ **and** $[v,u]=0$. The block writes that null set as $\ker N_v=v^\perp\cap\mathfrak z(v)$ ✔, an equality that needs, as [isotropy-cap.md](../findings/isotropy-cap.md) line 299 says, self-adjointness with semidefiniteness for one inclusion and $\ker\mathop{\mathrm{ad}}(v)^2=\ker\mathop{\mathrm{ad}}(v)$ for the other, neither written. **L33 needs only the easy inclusion**: what the proof actually consumes is *"$u\in\mathfrak z(x)\cap x^\perp\Rightarrow\langle u,N_xu\rangle=0$"*, which is immediate from the displayed quadratic form. I confirm the record's own reading of this ([LEDGER.md](../findings/LEDGER.md) line 288) independently.

$N_{cv}=c^2N_v$, which is what makes the rescaling of §4 legitimate.

## 4. The rescaling, the kernel inclusion, and the $\mathfrak c\ne0$ discharge

### 4.1 The rescaling and the inclusion, both correct

Let the minority side be $\{\lambda_1\}$ with $\lambda_1<0$ (the other sign is the mirror image). Set $x:=\sqrt{\lvert\lambda_1\rvert}\,v_1$ and $y_i:=\sqrt{\lambda_i}\,v_i$ over the $\lambda_i>0$. Then $\sum_\alpha\lambda_\alpha N_{v_\alpha}=0$ reads $N_x=\sum_iN_{y_i}$. **Zero eigenvalues contribute nothing and simply drop**, which is the whole of the $\ker W\ne0$ question (§7).

For $u\in\mathfrak c:=\mathfrak z(x)\cap x^\perp$: $0=\langle u,N_xu\rangle=\sum_i\langle u,N_{y_i}u\rangle$, a sum of nonnegatives, so each vanishes, so $\langle y_i,u\rangle=0$ and $[y_i,u]=0$. Hence $y_i\in\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp$ ✔.

**It does need all terms on one side.** H2 is exactly what puts them there: with two eigenvalues on the minority side the left is $\lambda_1N_{v_1}+\lambda_2N_{v_2}$ and its null set is no longer $\ker N_{v_1}$, so the inclusion is lost at its first line.

### 4.2 The discharge of $\mathfrak c\ne0$, **the conclusion is true, the written justification is not**

The blockquote after the proof reads:

> For skew $x\ne0$ on $\mathbb R^n$, $\mathfrak z(x)$ contains the torus spanned by $x$'s own $2$-blocks, so $\dim\mathfrak z(x)\ge\lfloor n/2\rfloor$

**Located.** [stratum-two-negative.md](../findings/stratum-two-negative.md), the blockquote immediately below L33's $\square$.

**The failure, in closed form.** Take $x=\varphi_{12}\in\mathfrak{so}(6)$. Its own $2$-blocks are one block, so *the torus spanned by $x$'s own $2$-blocks* is $\mathbb R\varphi_{12}$, of dimension $1$. The stated inference therefore yields $\dim\mathfrak z(x)\ge1$ and $\dim\mathfrak c\ge0$, vacuous, at the very object it is invoked for. The bound $\lfloor n/2\rfloor$ needs a **maximal** torus containing $x$, which is $x$'s own blocks *together with $\lfloor(n-2p)/2\rfloor$ further blocks inside $\ker x$*, a set the quoted phrase excludes by name.

**The charitable reading.** "The torus spanned by $x$'s own $2$-blocks" can be read as "a maximal torus containing $x$", which is what the next inequality wants. Under that reading $\dim\mathfrak z(x)\ge\lfloor n/2\rfloor$, hence $\dim\mathfrak c\ge\lfloor n/2\rfloor-1\ge1$ at every $n\ge4$, and the discharge goes through. The conclusion is independently true anyway: with $x$ of rank $2p$ and $k=m-2p$,

$$\dim\mathfrak c\ \ge\ (p-1)+\binom k2 ,$$

since $\mathfrak t_S\cap x^\perp$ has dimension $p-1$ and $\mathfrak{so}(\ker x)$ is orthogonal to $x$ and centralises it; this is $\ge1$ at every $m\ge4$ and every rank. **So the claim "$\mathfrak c=0$ would force $m\le3$, where $\mathrm{Weyl}_m=0$" is correct** ✔, at $m=3$, $\dim\mathcal W_3=3\cdot0\cdot4\cdot5/12=0$, and $\mathcal W_2=\mathcal W_1=0$ by inspection.

**Reported as: a defect of the written justification, with the conclusion intact.** It clears all three protocol steps.

### 4.3 Two different repairs of L32 are in circulation, and the canonical block has neither

| site | what it carries | status |
| --- | --- | --- |
| [isotropy-cap.md](../findings/isotropy-cap.md), L32 **Statement** line | *"Let $x\in\mathfrak{so}(m)$ be nonzero and $\mathfrak c=\mathfrak z(x)\cap x^\perp$. Then …"*, **no hypothesis at all**; the repair sits only in a blockquote above, `REFUTED AS STATED` | **the canonical statement is still the refuted one** |
| [results.md](../results.md) line 465 | *"Let $m\ne3$, let $x\in\mathfrak{so}(m)$ be nonzero…"* | repaired, by a different condition |
| [07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) line 1027ff | *"For $m\ne3$ and skew $x$…"* | repaired, same different condition |

The two repairs are **equivalent where it matters**, I checked: $\mathfrak c=0$ happens exactly at $m\in\{2,3\}$, and at $m=2$ the conclusion holds anyway ($\mathfrak z(0)\cap0^\perp=\mathfrak{so}(2)=\mathbb Rx$), so "$m\ne3$" and "$\mathfrak c\ne0$" cut out the same failures. **But L33 cites the block whose statement line carries neither**, and it cites it by the hypothesis that block does not state. A reader following the link finds a lemma marked refuted and a statement that is the refuted one.

## 5. The L32 step, and the case it does not cover

### 5.1 The nondegenerate case is correct, and uniform in the singular values

With $x$ of full rank $2p=m$, singular-value vector $a$ (no zero entries), $\mathfrak t$ the block torus: $\mathfrak c\supseteq\mathfrak t\cap x^\perp=a^\perp$, so $\mathfrak z(\mathfrak c)\subseteq\mathfrak z(a^\perp)=\mathfrak t\oplus\bigoplus\{\mathfrak g_\beta:\beta|_{a^\perp}=0\}$, and $\beta|_{a^\perp}=0$ iff $\beta\propto a$. Roots of $D_p$ are $\pm e_i\pm e_j$, with $p-2$ zero coordinates; $a$ has none. So at $p\ge3$ no root qualifies, $\mathfrak z(\mathfrak c)\subseteq\mathfrak t$, and $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp\subseteq\mathfrak t\cap(a^\perp)^\perp=\mathbb Rx$, with $x$ in it. At $p=2$ the roots have no zero coordinate and $a\propto(1,\pm1)$ qualifies, rank $4$, equal singular values, i.e. a multiple of a complex structure. **Nothing in the argument depends on the singular values beyond "none is zero", so the report's gloss "uniform in the singular values" is defensible and the split is on $p$, not on $a$.** I raised and then withdrew a candidate here, see §11.1.

**The exception list is therefore complete** at nondegenerate $x$: the only way out is $p=2$ with equal singular values. ✔ The block's *"the exception is realised and complete … with no second family"* survives.

### 5.2 The degenerate case, **no argument on file at corank $1$**

L32's whole treatment of degenerate $x$ is one sentence:

> For degenerate $x$ the same argument runs inside the support, with $\mathfrak z(\mathfrak c)$ additionally centralising $\mathfrak{so}(\ker x)$.

**Located.** [isotropy-cap.md](../findings/isotropy-cap.md), the last line of L32's proof.

**What it has to do.** Write $S=(\ker x)^\perp$, $K=\ker x$, $k=\dim K$, $2p=\dim S$. Then $\mathfrak{so}(m)=\mathfrak{so}(S)\oplus\mathfrak{so}(K)\oplus(K\otimes S)$, and *"the same argument runs inside the support"* is a computation in $\mathfrak{so}(S)$. So the sentence owes a reason why $\mathfrak z(\mathfrak c)$ meets the **mixed** part $K\otimes S$ in $0$. The reason it offers is centralising $\mathfrak{so}(\ker x)$.

**The failure, in closed form.** Take $m=7$ and $x=\varphi_{12}+2\varphi_{34}+3\varphi_{56}$. Then $K=\mathbb Re_7$, $k=1$, and $\mathfrak{so}(\ker x)=\mathfrak{so}(1)=0$. **The sentence's only tool is the zero algebra, and the six mixed elements $\varphi_{17},\dots,\varphi_{67}$ are never touched.** At $k\ge2$ the tool works, for $u=\sum_\kappa\varphi_{\kappa,s_\kappa}$ mixed, $[\varphi_{\kappa_1\kappa_2},u]=\varphi_{\kappa_2,s_{\kappa_1}}-\varphi_{\kappa_1,s_{\kappa_2}}$, which vanishes only at $u=0$, so the gap is exactly $k=1$, that is, **odd $m$ with $x$ of corank one.**

**Why this is the case that matters here.** The block's own box says L33 *"covers odd $m$ and degenerate minority eigenvectors"*. At odd $m$ every $x$ is degenerate and corank $1$ is the generic case: at $m=5$ a rank-$4$ minority eigenvector, at $m=7$ a rank-$6$ one. **L33's odd-$m$ clause rests on precisely the L32 case whose written proof is vacuous there.**

**The charitable reading.** *"The same argument runs inside the support"* could be read as itself asserting the reduction to $\mathfrak{so}(S)$. But that reduction is the step in question, and the only justification the sentence supplies for it is the $\mathfrak{so}(\ker x)$ clause, which is empty at $k=1$. The charitable reading names the conclusion; it does not argue it.

**The conclusion is true**, so this is `GAP` and not `BROKEN`: a mixed $\varphi_{\kappa,s}$ centralises $\mathfrak c$ only if $s$ lies in the common kernel of $\mathfrak c$ inside $S$, and $\mathfrak c\supseteq\mathfrak t_S\cap x^\perp$ already has trivial common kernel there whenever $p\ge2$ (given a block $j$, $a^\perp\not\subseteq\{c_j=0\}$, since equality would force $a\propto e_j$, impossible with $p\ge2$ and no zero entry); $p=1$ with $k=1$ is $m=3$. **But that argument is mine, made to grade the step, and it is not on the record.** Per the standing rule I record the debt rather than filing the repair: *what is owed is the elimination of $B_p$'s short root spaces $\mathfrak g_{\pm e_i}$ from $\mathfrak z(\mathfrak c)$ at $\dim\ker x=1$.*

### 5.3 The exception clause of L33 matches L32's exactly

L32's exception is *"$x$ a multiple of a complex structure on a $4$-dimensional subspace"*; L33's H3 is the same words. Being a complex-structure multiple is scale-invariant, so passing from $v_1$ to $x=\sqrt{\lvert\lambda_1\rvert}v_1$ changes nothing. ✔ **No mismatch between the hypothesis L33 discharges and the hypothesis L32 requires.**

## 6. The closing step

Every $y_i\in\mathbb Rx$; and $y_i\perp x$ because $x$ and $y_i$ are eigenvectors of the symmetric $W$ for eigenvalues of opposite sign, hence distinct. So $y_i=0$ ✔, i.e. every majority-side $\lambda_i=0$, i.e. $W=\lambda_1v_1\otimes v_1=\pm\,x\otimes x$ ✔ with the sign of $\lambda_1$. Then $\mathop{\mathrm{Ric}}=-\lambda_1v_1^2=\lambda_1v_1^{\mathsf T}v_1$, which is definite on $\mathop{\mathrm{im}}v_1\ne0$ unless $\lambda_1=0$. So $x=0$ and $W=0$ ✔.

*The block reaches for Ricci-flatness here; $N_x=\sum_iN_{y_i}=0$ evaluated at $u=x$ gives $2\lVert x\rVert^4=0$ directly, and trace-freeness gives it too. Three routes, all closing. Not a defect, noted because §7 turns on which one is used.*

## 7. Every edge of every range

| edge | what the statement says there | verdict |
| --- | --- | --- |
| **the smallest admissible $m$** | $\mathcal W_m=0$ at $m\le3$, so H2 is unsatisfiable and the lemma is vacuous. At $m=4$ it is non-vacuous and **its conclusion never fires**: if $W\ne0$ has exactly one eigenvalue on one side then one of $W^\pm$ vanishes and the other is $\mathop{\mathrm{diag}}(q,r,-(q+r))$ up to sign, whose minority eigenvector lies in $\Lambda^\pm$ and so *is* a complex structure. **Every $m=4$ instance is the exception** | consistent |
| **odd $m$** | covered by the statement, and used at [line 398](../findings/stratum-two-negative.md). Rests on [L32](../findings/isotropy-cap.md) at corank $1$, **§5.2** | **the one place where the chain has no argument** |
| **degenerate minority eigenvectors** | covered; L32's degenerate case handles $k\ge2$ by the sentence it gives, and $k=1$ by nothing | as above |
| **$m=4$, where the exception lives** | $W_4(q,r)=-(q+r)w_1\otimes w_1+q\,w_2\otimes w_2+r\,w_3\otimes w_3$ with $q,r>0$: signature $(2,1)$, one negative eigenvalue of multiplicity one, minority eigenvector $w_1\in\Lambda^+$ of unit norm, i.e. $\tfrac1{\sqrt2}J$. **A nonzero object meeting H1 and H2, and failing only H3** | **the exception is necessary and is realised** ✔ |
| **$\ker W\ne0$** | see below | ✔ |

**$\ker W\ne0$, asked at a padded object.** This is the trap the brief names, so here is the answer in full. Pad $W_4(q,r)$ into $\mathbb R^m$: $\dim\ker W=\binom m2-3$, which is $12$ at $m=6$ and $63$ at $m=12$. The statement counts eigenvalues **on one side**, and zero is on neither side, so the hypothesis reads on the three nonzero eigenvalues alone; the proof drops the kernel eigenvectors from $\sum_\alpha\lambda_\alpha N_{v_\alpha}=0$ because their coefficient is zero. **The lemma neither degenerates nor becomes vacuous at $\ker W\ne0$, it says exactly the same thing about the padded object as about the $m=4$ one, namely that it is the exception.** This is the opposite of [W4](../findings/INDEX-traps.md)'s $S(W)$ screen, which the same conventions file records as vacuous when $\ker W\ne0$; the contrast is worth having on the record.

**One hypothesis is used and never named: trace-freeness.** $\mathop{\mathrm{tr}}_{\Lambda^2}W=0$ is what makes "one side" non-empty, without it a $W$ with all eigenvalues positive has an empty minority side and H2 is unreadable. It is also what closes §6 by the shortest route, and it is what makes the §2.4 consumer's identity come out. It is a consequence of H1, so nothing is wrong; it is simply never named as being used.

## 8. The sources

**Besse, *Einstein Manifolds*, §1.143 is not in [references/](../references/).** I listed the directory: there is no Besse entry, and no `notes.md` anywhere in `references/` mentions Besse. **The unheld citation carries the one step of the identity that nothing else on the record derives**, the evaluation $q(R)\omega=\mathop{\mathrm{Ric}}\circ\omega+\omega\circ\mathop{\mathrm{Ric}}-2\mathring R\omega$. And its hypotheses were never checked against this object: in Besse this is a formula about the Lichnerowicz Laplacian on a Riemannian manifold, whereas $W\in\mathrm{Weyl}_m$ is an algebraic curvature operator with no metric behind it. The formula is pointwise-algebraic and so does transfer, but **the record nowhere says so, and "it transfers" is a claim about a source no one here can open.**

**[Petersen–Wink](../references/petersen-wink-2019-bochner-technique/) is on file**, PDF, extracted text, and a `notes.md`. I read Proposition 1.6 in the extracted text at line 319 and confirm the `notes.md` quotes it verbatim. Combined with their Proposition 1.11, $g(\mathrm{Ric}(S),T)=g(R(\hat S),\hat T)$, and $E=\Lambda^2$ so that $\Xi T=[\Xi,T]$, PW give

$$\langle q(R)u,u\rangle=\sum_\alpha\lambda_\alpha\lVert[v_\alpha,u]\rVert^2=-\Big\langle u,\sum_\alpha\lambda_\alpha\mathop{\mathrm{ad}}(v_\alpha)^2u\Big\rangle .$$

**That is the eigenbasis rewriting and it is not the evaluation.** I grepped the extracted text: "Weitzenböck" occurs once, in the bibliography, and neither §1.143 nor the two-form evaluation appears. **The block's line (*"[Petersen–Wink] gives the eigenbasis rewriting and not the evaluation"*), is accurate, and it accurately identifies the half that is missing.**

**What the record does have instead.** [isotropy-cap.md](../findings/isotropy-cap.md)'s $T$-eigenvalue table is the same statement (§2.1) and is recorded as *measured* at $n=4,5,6,7$. The [PW notes.md](../references/petersen-wink-2019-bochner-technique/notes.md) carries a project-authored derivation that supplies the Bianchi rearrangement in full and then hands the evaluation itself back to the same unheld source. **So the chain from PW to $\sum_\alpha\lambda_\alpha\mathop{\mathrm{ad}}(v_\alpha)^2=2W$ has exactly one link with no argument and no source on file.**

I did not fetch Besse, and per the brief a search-tool summary would not be a citation. **What is owed is either the book in [references/](../references/) with its text and a `notes.md`, or four lines deriving the $\mathcal W_m$ scalar $-2$, which §2.2 shows is one closed-form object away.**

## 9. The ambiguity, and whether the repair travelled

### 9.1 The $\mathrm{Weyl}_4$ witness, rebuilt cold

$\mathcal W_4=\mathrm{Sym}^2_0(\Lambda^+)\oplus\mathrm{Sym}^2_0(\Lambda^-)$. Take $W^+=W^-=\mathop{\mathrm{diag}}(2,-1,-1)$ in the bases $\{s_i\}$, $\{a_i\}$ of §2.2.

- **Membership.** Both blocks trace-free $\Rightarrow\mathop{\mathrm{Ric}}=0$; $\langle W,\star\rangle=\mathop{\mathrm{tr}}W^+-\mathop{\mathrm{tr}}W^-=0\Rightarrow$ no $\Lambda^4$ part $\Rightarrow$ first Bianchi. So $W\in\mathcal W_4$ ✔
- **Spectrum** $(2,2,-1,-1,-1,-1)$ ✔, and $\mathop{\mathrm{tr}}W=0$ ✔
- **One distinct positive value**, $+2$, of multiplicity $2$, eigenspace $\mathop{\mathrm{span}}(s_1,a_1)$ ✔
- **A rank-$2$ element in it that is no complex structure.** With $s_1=\tfrac1{\sqrt2}(\varphi_{12}+\varphi_{34})$ and $a_1=\tfrac1{\sqrt2}(\varphi_{12}-\varphi_{34})$, $\tfrac1{\sqrt2}(s_1+a_1)=\varphi_{12}$: unit norm, rank $2$, kernel of dimension $2$. **A complex structure on a $4$-plane has rank $4$, so this is not one under any reading** ✔
- $W\ne0$ ✔

**So the lemma read as "one distinct value at any multiplicity" is false, and the witness is correct.** ✔

### 9.2 The precise scope of that refutation

**The witness refutes the distinct-value reading only under the *existential* reading of "that eigenvector"**, "the eigenspace contains an eigenvector that is not a complex-structure multiple". Under the *universal* reading ("every eigenvector in it is not one"), the exception clause fires at $s_1$, which **is** a complex structure multiple, and the loose lemma says nothing about this object. The same holds of the $m=8$ witness of [L34](../findings/stratum-two-negative.md): its negative eigenspace is spanned by two padded $\tfrac1{\sqrt2}J$'s on orthogonal $4$-planes, each of which is the exception, while a generic combination has rank $8$ and is not.

I reached this independently and then found the record already carries it, at [LEDGER.md](../findings/LEDGER.md) lines 983 and 997 and in [INDEX-results.md](../findings/INDEX-results.md) row 34. **Convergence, recorded as such.** The block's own phrase *"its $+2$ eigenspace contains a rank-$2$ element"* is the existential reading and is honest about it.

*Checked and cleared: the $m=8$ witness does not touch L33 under the record's own reading. Its spectrum $\{-1/\sqrt3\,(\times2),\,1/(2\sqrt3)\,(\times4)\}$ has a two-dimensional negative eigenspace, so it fails H2. The numbers are exact, two padded $W_4(q,q)$ give $(-2q,-2q,q,q,q,q)$, and $12q^2=1$ gives $q=1/(2\sqrt3)$, $-2q=-1/\sqrt3$, trace $0$.*

### 9.3 Does "with multiplicity" reach every site?

| site | text | verdict |
| --- | --- | --- |
| [stratum-two-negative.md](../findings/stratum-two-negative.md) line 122 | *"exactly one eigenvalue counted **with multiplicity**"* | ✔ |
| [results.md](../results.md) line 152, landscape | *"exactly one eigenvalue counted *with multiplicity*"* | ✔ |
| [results.md](../results.md) line 473, canonical | *"exactly one eigenvalue counted *with multiplicity*"* | ✔ |
| [07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) line 1027 | *"exactly one eigenvalue counted \emph{with multiplicity}"* | ✔ |

**All four carry it.** The repair the [LEDGER](../findings/LEDGER.md) records as owed against three quoted copies has landed. I found no fifth site: grepping `report/` and `results.md` for the phrasing turns up nothing else.

## 10. The "in particular" clause

*"In particular no rank-$3$ $\mathrm{Weyl}_m$ tensor at even $m\ge6$ has a nondegenerate minority-side eigenvector."*

**It follows from the main clause.** A rank-$3$ $W$ is trace-free with three nonzero eigenvalues, so its signature is $(2,1)$ or $(1,2)$ and the minority side carries exactly one eigenvalue of multiplicity one, H2 ✔ for free. If its eigenvector is nondegenerate then at even $m\ge6$ it has $p=m/2\ge3$ blocks and rank $m\ge6>4$, so it is not a complex structure on a $4$-plane, H3 ✔ for free. The lemma then gives $W=0$, against rank $3$. ✔

**Both range conditions are load-bearing and both are stated.** "Even" is needed for a nondegenerate element of $\mathfrak{so}(m)$ to exist at all; "$m\ge6$" is needed because at $m=4$ a full-rank bivector with equal singular values *is* the exception, and $-W_4(q,r)$ is the standing counterexample, which the same file already flags at [line 398](../findings/stratum-two-negative.md): *"The citation of Lemma L33 needs $m\ge6$."*

**The clause is strictly weaker than the lemma**, since it asks nondegeneracy where the lemma asks only "not a $4$-plane complex structure". The block says so. ✔ **No claim proven on a subfamily and used in general**, the traffic runs the safe way.

## 11. Withdrawn candidates

### 11.1 "The report's L32 gloss *uniform in the singular values* is false", **withdrawn**

The report writes *"Three root-system lines, uniform in the singular values."* I raised this because L32's proof splits on $p\ge3$ against $p=2$ and its exception is a singular-value condition. **Withdrawn at protocol step 3**: the split is on the number of blocks, not on the singular values, and within each case the only property of $a$ used is that no entry is zero. The gloss is defensible.

### 11.2 "L33 assumes $m\ge4$ without saying so", **withdrawn**

At $m\le3$, $\mathcal W_m=0$, so H2 is unsatisfiable and the statement is vacuously true. No hypothesis is missing. **Withdrawn at protocol step 2**: no failure can be exhibited.

### 11.3 "The closing step needs trace-freeness, which is unstated", **withdrawn as a defect, kept as a note**

Trace-freeness is a consequence of $W\in\mathrm{Weyl}_m$, so nothing is assumed that is not given. Recorded in §7 as a used-but-unnamed consequence rather than as a missing hypothesis.

## 12. Symbol collisions

Checked against [conventions.md](../findings/conventions.md)'s own list. **Four are live inside this block, and only one of them is tabled.**

| symbol | the two objects | tabled? |
| --- | --- | --- |
| $\mathring R$ | at [line 142](../findings/stratum-two-negative.md), the curvature action **on $2$-forms**, $(\mathring R\omega)_{ij}=\sum_{kl}R_{ikjl}\omega_{kl}$, which first Bianchi collapses onto $W$ itself; at [line 323](../findings/stratum-two-negative.md) of the same file, the **second-kind operator on symmetric $2$-tensors**, $(\mathring Rh)_{ij}=\sum_{kl}e_{ikjl}h_{kl}$. Different spaces, one symbol, $181$ lines apart. And [conventions.md](../findings/conventions.md)'s $\mathring W$ is a third thing again, the same $S^2_0$ operator in **Li's $iklj$**, i.e. the negative of this file's | **NO** |
| $q$ | the Weitzenböck operator $q(R)$ at line 142; the scalar parameter of $W_4(q,r)$ at line 166, **both inside L33's own block, $24$ lines apart** | yes, and correctly |
| $r$ | the support dimension at line 33; the second parameter of $W_4$ at line 166 | yes |
| $N$ | $N_v$, L33's positive semidefinite operator, at lines 139–152; the index $\binom m2$ in $v_{N-1},v_N$ at lines 61, 83, 178, and throughout [L30](../findings/stratum-two-negative.md) and [L34](../findings/stratum-two-negative.md) (**the same file, and $N_v$ is not in the table at all** | half), $N$ is tabled, $N_v$ is not |
| $x$ | L33's minority eigenvector, a **bivector** in $\mathfrak{so}(m)$; the vector in $\mathbb R^m$ of $\mathop{\mathrm{Ric}}(W)(x,x)$ at [line 186](../findings/stratum-two-negative.md), sixty lines below | **NO** |
| $\mathfrak c$ | one sense only, $\mathfrak z(x)\cap x^\perp$ in both L32 and L33, and [isotropy-cap.md](../findings/isotropy-cap.md) line 301 states the identification with $\ker N_v$ explicitly | untabled but **consistent** |

## 13. One dead link

[stratum-two-negative.md](../findings/stratum-two-negative.md) line 398 cites `#lemma-l33--the-nondegeneracy-criterion`. **No such heading exists in the file**, the four `#### Lemma L3x` headings are at lines 119, 208, 369, 409, 451, and L33's is `#lemma-l33--one-eigenvalue-of-one-sign-forces-the-tensor-to-vanish--canonical-statement-and-proof`. The one sentence in the file that correctly restricts L33's citation to $m\ge6$ points at nothing.

## 14. What would break it, and what I did to look for one

**The falsifier is a nonzero $W\in\mathrm{Weyl}_m$ with exactly one eigenvalue of one sign counted with multiplicity, whose minority eigenvector is not a multiple of a complex structure on a $4$-plane.**

What I did, all of it by hand and in closed form:

1. **Exhausted $m=4$.** If $W\ne0$ has one eigenvalue on one side, one of $W^\pm$ must vanish (each is trace-free, so a nonzero block contributes an eigenvalue of each sign), and the survivor is $\pm\mathop{\mathrm{diag}}(q,r,-(q+r))$ with $q,r>0$. Its minority eigenvector lies in a single $\Lambda^\pm$ and every unit element there is $\tfrac1{\sqrt2}J$. **Every candidate at the smallest dimension is the exception, and none escapes it.**
2. **Attacked the L32 step at every shape of $x$**, since that is the only place a falsifier could hide: full rank with distinct singular values, full rank with $a=(a,a,a)$ at $m=6$ (where $\mathfrak c=\mathfrak{su}(3)$ and $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp$ is still the $\mathfrak u(1)$, i.e. $\mathbb Rx$), full rank with $a=(a,a,b)$, corank $1$ at $m=5$ and $m=7$, corank $2$, corank $\ge3$. **All return $\mathbb Rx$ except $p=2$ with equal singular values, which is the stated exception.**
3. **Tested whether the exception could be a family rather than a point.** The criterion is $a\propto$ a root of $D_p$; roots carry $p-2$ zero coordinates and $a$ carries none, so only $p=2$ survives, and there $a\propto(1,\pm1)$. **One family, both orientations, and it is the one the block names.**
4. **Checked the two objects the record itself offers as near-misses**, the padded $W_4(q,r)$ and [L34](../findings/stratum-two-negative.md)'s $m=8$ witness. The first fails H3 and the second fails H2. **Neither is a falsifier.**
5. **Checked the padded regime**, where $\ker W$ is as large as $63$ of $66$ dimensions at $m=12$, since that is where a statement about "one side" most often silently degenerates. It does not degenerate.

**I found none, and the proof explains why there is none.** The one place the record leaves an opening is not a candidate falsifier but an unargued step: §5.2. A falsifier could only live at odd $m$ with a corank-one minority eigenvector, and only if L32 failed there, and it does not fail there; it is merely unproved there.

## 15. Verdict

**GAP.**

- **The statement is true** under its own with-multiplicity reading, at every $m$, at odd $m$, at degenerate minority eigenvectors, and at $\ker W\ne0$.
- **The proof is correct at every step it writes**: the identity (verified at four closed-form objects, one per isotypic piece), the positive-semidefinite splitting, the kernel inclusion, the L32 application, and the closing.
- **The exception is necessary, realised, and complete.**
- **Two links have no argument on the record.** The Weitzenböck **evaluation**, whose only source is an unheld Besse and whose transfer from a manifold statement to an algebraic curvature operator is never stated (§8); and [L32](../findings/isotropy-cap.md)'s degenerate case at $\dim\ker x=1$, which is exactly what L33's odd-$m$ coverage consumes (§5.2). Both conclusions are true (I checked each against closed-form objects) and neither argument is written anywhere.
- **Three defects of the written record**, none of which changes a conclusion: the $\mathfrak c\ne0$ discharge is a non sequitur as phrased (§4.2); [L32](../findings/isotropy-cap.md)'s canonical statement line still carries the refuted form while two other sites carry a different repair (§4.3); and the one sentence that correctly restricts L33's citation to $m\ge6$ points at a dead anchor (§13).
- **Nothing here needs computation.** Every value in this report is exact.

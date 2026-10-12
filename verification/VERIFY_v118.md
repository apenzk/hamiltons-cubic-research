# VERIFY v118, L7's compression inequality, its $6\delta^2$, and what its equality clause actually characterises

*Verifier v118, round L07, cold brief. **No numerical work was done**: every value below is an exact hand evaluation from structure constants and closed forms, and the two decimal figures quoted are quoted from the record and converted to exact surds before use. Log: [agent_logs/verify-L07-v118.log](../agent_logs/verify-L07-v118.log).*

## Claim table

| # | Claim, and where a consumer meets it | Verdict |
|---|---|---|
| C1 | The exact identity $\theta\operatorname{tr}(W_-)+\operatorname{tr}(W_-^2)=-\operatorname{tr}(\Pi_-W^\#)$ at a critical point, [bounds.md](../findings/bounds.md):51 | **PROVEN** |
| C2 | The compression step to $\le2\operatorname{tr}(W_+\#W_-)$, [bounds.md](../findings/bounds.md):51 | **PROVEN** |
| C3 | The final equality $2\operatorname{tr}(W_+\#W_-)=\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2$, and the coefficient $6$, [bounds.md](../findings/bounds.md):51 | **PROVEN, coefficient right** |
| C4 | The inequality itself, at every critical point, [bounds.md](../findings/bounds.md):47–49, [results.md](../results.md):326 | **PROVEN** |
| C5 | The equality clause as three bracket conditions, [bounds.md](../findings/bounds.md):57 | **PROVEN** |
| C6 | The kernel-closure upgrade retiring the "modulo $\ker W$" hedge, [bounds.md](../findings/bounds.md):57 | **PROVEN, criticality is load-bearing and unnamed there** |
| C7 | "which is exactly the condition defining a compact symmetric pair with $E_+$ the isotropy algebra", [results.md](../results.md):326 | **BROKEN** |
| C8 | "and it fails strictly at the low-value ones", [results.md](../results.md):326 | **BROKEN** |
| C9 | The ingredient list "needs only bilinearity of $\#$, its rank-one positivity, a partial trace, and the polarized identity", [results.md](../results.md):326 | **BROKEN, three hypotheses omitted** |
| C10 | "$vv^{\mathsf T}\#ww^{\mathsf T}=[v,w][v,w]^{\mathsf T}$, a theorem rather than an assumption", [bounds.md](../findings/bounds.md):51 | **BROKEN, off by a factor $2$; inert for L7, live for a consumer** |
| C11 | "the last two used twice each in the final step", [bounds.md](../findings/bounds.md):53 | **PROVEN for one route, once each for the route the block describes** |
| C12 | "$\delta^2=\tfrac19$ and both sides are $\tfrac43$" at $W_{\mathbb{CP}^2}$, [bounds.md](../findings/bounds.md):53 | **PROVEN, reproduced exactly** |
| C13 | "$S^2\times S^4$ at $n=6$ attains equality exactly at $\theta=0.968246<1$", [bounds.md](../findings/bounds.md):59 | **PROVEN, reproduced exactly, $\theta^2=15/16$** |
| C14 | "THIS FILE SAYS SO 79 LINES BELOW", [bounds.md](../findings/bounds.md):59 | **BROKEN, the pointer resolves to a block about $\Delta$** |
| C15 | The heading "the symmetric-pair equality class", [bounds.md](../findings/bounds.md):43, [results.md](../results.md):326 | **BROKEN, the heading carries the refuted reading** |

**Verdict: PROVEN, hypotheses corrected, for the inequality and for [bounds.md](../findings/bounds.md)'s equality clause; BROKEN for the canonical statement at [results.md](../results.md):326, which a consumer reading it alone cannot use.**

**One line.** The mathematics is right and I rebuilt all of it (identity, compression, the $6$, and the equality class) and reproduced equality exactly at three named objects; what is broken is the canonical form a consumer actually cites, which asserts an equivalence false in both directions, a strictness claim I refuted by hand, and an ingredient list missing the three hypotheses the proof uses.

## 0. Conventions, fixed once

Everything below runs in the normalisations of [conventions.md](../findings/conventions.md), plus two that file does not table and that I pinned from the record's own anchors. I state all of them, because the coefficient $6$ is a statement about them.

- **The $\Lambda^2$ inner product is the half-trace**, $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$, so $\{\varphi_{ab}=E_{ab}-E_{ba}\}_{a<b}$ is orthonormal ([conventions.md](../findings/conventions.md):60).
- **On $S^2(\Lambda^2)$ the norm is the operator Hilbert–Schmidt norm** of that basis, $\lVert A\rVert^2=\operatorname{tr}(A^2)$. Pinned by [conventions.md](../findings/conventions.md):94's $\lVert\star\rVert^2=6$ at $n=4$: $\star$ has eigenvalues $\pm1$ with multiplicity $3$ each, so $\operatorname{tr}(\star^2)=6$.
- **$W_-:=\tfrac12(\lvert W\rvert-W)\succeq0$**, the positive-semidefinite magnitude of the negative spectral part ([conventions.md](../findings/conventions.md):95), $\lvert W\rvert$ spectral. So $W=W_+-W_-$, $\lvert W\rvert=W_++W_-$, $\Pi_-W=-W_-$, and $\operatorname{tr}(W_-)\ge0$.
- **$\mathfrak p=\operatorname{ran}W_+$, $\mathfrak m=\operatorname{ran}W_-$, $\mathfrak k=\ker W$**, and $P_\pm=\Pi_\pm$, $P_0$ the three spectral projections, summing to $\mathrm{Id}$.
- **Ricci contraction**: writing $A_{ijkl}=\langle A\varphi_{ij},\varphi_{kl}\rangle$ extended antisymmetrically in each pair, $\mathrm{Ric}(A)_{ij}=\sum_kA_{ikjk}$, and $\lVert\mathrm{Ric}(A)\rVert^2$ is the plain Frobenius norm of that $n\times n$ symmetric matrix. **This is not tabled anywhere on the record**; I pinned it by requiring the block's own anchor $\lVert\mathrm{Ric}(W_-)\rVert^2=\tfrac23$ at $W_{\mathbb{CP}^2}$, and it then reproduces $\mathrm{Ric}(\mathrm{Id})=(n-1)\,\mathrm{id}_n$ and $\mathrm{Ric}(\star)=0$.
- **$\operatorname{scal}(A)=\operatorname{tr}\mathrm{Ric}(A)=2\operatorname{tr}_{\Lambda^2}(A)$.** **Also not tabled anywhere on the record**, and load-bearing for the $6$. Pinned by the record's own $\operatorname{tr}(W^\#)=-1$ at a unit Weyl tensor ([conventions.md](../findings/conventions.md):122, [bounds.md](../findings/bounds.md):39): [L15](../findings/problem.md)'s identity at $R=W$ Weyl reads $2\operatorname{tr}(W^2)+2\operatorname{tr}(W^\#)=0$, which gives $-1$ under this convention and under no other multiple.
- **$\#$**: the symmetric bilinear map with $A\#B=\tfrac12\sum_{i,j}a_ib_j\,[u_i,v_j][u_i,v_j]^{\mathsf T}$ for spectral decompositions $A=\sum a_iu_iu_i^{\mathsf T}$, $B=\sum b_jv_jv_j^{\mathsf T}$, sums over ordered pairs; $A^\#:=A\#A$. Under it $(A+B)^\#=A^\#+2A\#B+B^\#$, $\mathrm{Id}^\#=(n-2)\mathrm{Id}$, and $\langle v,W^\#v\rangle=\tfrac12\sum_{a,b}\lambda_a\lambda_bc_{1ab}^2$, the last being [bounds.md](../findings/bounds.md):187's own walk identity, which carries the $\tfrac12$ explicitly. **$\#$ maps the PSD cone into itself**, since every summand is a rank-one PSD matrix with a non-negative weight.
- **$\mathrm{Alt}$** is the orthogonal projection of $S^2(\Lambda^2)$ onto $\Lambda^4$ ([conventions.md](../findings/conventions.md):94), self-adjoint and idempotent, vanishing on every Bianchi operator; $\delta^2:=\lVert\mathrm{Alt}(W_-)\rVert^2$ ([results.md](../results.md):362).
- **Criticality is $Q(W)=\theta W$ with $Q(W)=W^2+W^\#$**, the unprojected operator equation ([conventions.md](../findings/conventions.md):119, :15). This is legitimate *because* $Q$ maps $\mathcal W_n$ to itself ([conventions.md](../findings/conventions.md):41(ii), from [Böhm–Wilking](../references/boehm-wilking-2008-space-forms/notes.md)); had $Q(W)$ carried a Ricci part, the criticality equation would only hold after projection and the trace against $\Pi_-$ would pick up a correction. **The block does not say it is relying on this.**

## 1. The hypothesis inventory, a pass without one is not a pass

### 1.1 What the block names

| Hypothesis | Where used in the written proof | Load-bearing? |
|---|---|---|
| Criticality, $Q(W)=\theta W$ | The exact identity, step 1 | **Yes.** Without it there is no identity at all. Also load-bearing a second, unnamed time, see §5. |
| Ricci-flatness, $\mathrm{Ric}(W)=0$ | $\mathrm{Ric}(W_+)=\mathrm{Ric}(W_-)$, in the final equality | **Yes.** Without it the RHS is $\langle\mathrm{Ric}W_+,\mathrm{Ric}W_-\rangle$, which is not a square and can be negative. |
| First Bianchi, $\mathrm{Alt}(W)=0$ | $\mathrm{Alt}(W_+)=\mathrm{Alt}(W_-)$, in the final equality | **Yes**, identically. |

### 1.2 What the block imports, each checked against the object it applies to

| Import | Applied to | Checked |
|---|---|---|
| [Observation L15](../findings/problem.md)'s identity $\operatorname{scal}(R^2+R^\#)=\lVert\mathrm{Ric}(R)\rVert^2+6\lVert\mathrm{Alt}(R)\rVert^2$ | Polarised at $(W_+,W_-)$, **neither of which is a curvature operator**: $W_\pm$ satisfy neither Bianchi nor Ricci-flatness | **Legitimate, and this is exactly why the identity must be the one carrying the $6\lVert\mathrm{Alt}\rVert^2$ correction.** [problem.md](../findings/problem.md):190–199 states it for arbitrary $R$ with $\mathrm{Alt}$ the $\Lambda^4$ projection, and records it as "confirmed: verified three ways". I re-checked it at one non-trivial point, $R=W_{\mathbb{CP}^2}$ (§4.3), where it forces $\operatorname{tr}(W^\#)=-1$ and my structure-constant computation returns $-6\varepsilon^2=-1$. **I did not re-derive it in general**; it rests on [Lemma L131](../findings/isotropy-cap.md), which I did not open. |
| Rank-one positivity of $\#$ | $W_+^\#$, $W_-^\#$, $W_+\#W_-$ | **True as a positivity statement, false as the stated formula**, see §6. |
| $0\preceq\Pi_-\preceq\mathrm{Id}$ | $\Pi_-$ | True; both halves are used, and the block attributes the wrong half to the wrong step (§6). |
| [Lemma L154](../findings/bounds.md)(i) and [Lemma L155](../findings/bounds.md) | The kernel-closure upgrade | Both Gate-2 confirmed on file; I re-derived the one step that joins them to L7 (§5). |

### 1.3 What the proof uses without naming it

1. **$Q$ preserves $\mathcal W_n$**, so criticality is an unprojected operator equation. Without it, tracing $Q(W)=\theta W$ against $\Pi_-$ is tracing an equation that does not hold.
2. **$\operatorname{scal}=2\operatorname{tr}_{\Lambda^2}$**, untabled and load-bearing for the $6$ surviving into the final line at coefficient exactly $6$ rather than $3$ or $12$.
3. **$\operatorname{tr}(W_+W_-)=0$**, needed to drop the $\operatorname{scal}(R^2)$ cross term in the polarisation. Free from orthogonality of spectral parts, but it is a step.
4. **Criticality, a second time**, in the kernel-closure clause of the equality statement (§5).
5. **$W$ symmetric**, so that $\Pi_\pm$ exist and commute with $W$, giving $\Pi_-W^2=W_-^2$.

### 1.4 What is *not* used, and where the block is right to say so

- **No unit-norm requirement.** Correct, and I checked the homogeneity: under $W\mapsto tW$ ($t>0$) the eigenvalue scales as $\theta\mapsto t\theta$, because $Q(tW)=t^2Q(W)=t\theta\,(tW)$. Then LHS $\mapsto t^2\,$LHS and RHS $\mapsto t^2\,$RHS, since $\mathrm{Ric}$ and $\mathrm{Alt}$ are linear. The statement is homogeneous of degree $2$ and scale-free.
- **No sign condition.** Correct: $\theta\le0$ is admissible and makes the LHS smaller while the RHS stays $\ge0$, so the inequality only weakens. Nothing in the derivation branches on a sign.
- **No parity condition and no lower bound on $n$** beyond $\mathcal W_n\ne0$, i.e. $n\ge4$. Nothing in the derivation sees $n$ at all; the $6$ is dimension-free.

## 2. Question 1, does the compression give the inequality? The derivation in full

### 2.1 The exact identity (C1)

The block writes: *"Tracing $Q(W)=\theta W$ against $\Pi_-$ gives the exact identity $\theta\operatorname{tr}(W_-)+\operatorname{tr}(W_-^2)=-\operatorname{tr}(\Pi_-W^\#)$."*

Trace $W^2+W^\#=\theta W$ against $\Pi_-$:
$$\operatorname{tr}(\Pi_-W^2)+\operatorname{tr}(\Pi_-W^\#)=\theta\operatorname{tr}(\Pi_-W).$$
$\Pi_-$ commutes with $W$ and is idempotent, so $\Pi_-W^2=(\Pi_-W)^2=(-W_-)^2=W_-^2$, while $\Pi_-W=-W_-$. Hence
$$\operatorname{tr}(W_-^2)+\operatorname{tr}(\Pi_-W^\#)=-\theta\operatorname{tr}(W_-),\qquad\text{i.e.}\qquad \theta\operatorname{tr}(W_-)+\operatorname{tr}(W_-^2)=-\operatorname{tr}(\Pi_-W^\#).$$
**Confirmed, and the sign convention is doing real work.** Under the opposite sign convention $W_-=\Pi_-W\preceq0$ the same computation returns $\operatorname{tr}(W_-^2)-\theta\operatorname{tr}(W_-)$ on the left: the plus sign in the block's statement is only correct under [conventions.md](../findings/conventions.md):95's $W_-\succeq0$, which that file marks as a collision that "refuted four lemmas in one day". The block does not restate the sign, and the brief's "$W_\pm$ the positive and negative spectral parts" is ambiguous about it. **A consumer must import [conventions.md](../findings/conventions.md):95 with this statement**; I record that below as part of what may be cited.

### 2.2 The compression (C2)

Bilinearity of $\#$ with $W=W_+-W_-$ gives $W^\#=W_+^\#-2\,W_+\#W_-+W_-^\#$, exactly as written. So
$$-\operatorname{tr}(\Pi_-W^\#)=-\operatorname{tr}(\Pi_-W_+^\#)-\operatorname{tr}(\Pi_-W_-^\#)+2\operatorname{tr}\big(\Pi_-(W_+\#W_-)\big).$$
All three of $W_+^\#$, $W_-^\#$, $W_+\#W_-$ are PSD, because $\#$ carries the PSD cone into itself. Then

- $\Pi_-\succeq0$ gives $\operatorname{tr}(\Pi_-W_+^\#)\ge0$ and $\operatorname{tr}(\Pi_-W_-^\#)\ge0$, so the first two terms are $\le0$ and drop;
- $\Pi_-\preceq\mathrm{Id}$ gives $\operatorname{tr}(\Pi_-(W_+\#W_-))\le\operatorname{tr}(W_+\#W_-)$.

Hence $\theta\operatorname{tr}(W_-)+\operatorname{tr}(W_-^2)\le2\operatorname{tr}(W_+\#W_-)$. **Confirmed**, and it is exactly the block's "$\le2\operatorname{tr}(W_+\#W_-)$". The block's attribution of both moves to "$\Pi_-\preceq I$" is imprecise; see §6.2.

### 2.3 The final equality, and where the $6$ comes from (C3)

[L15](../findings/problem.md)'s identity is a quadratic identity in $R$ over all of $S^2(\Lambda^2)$. Write $R=A+B$ and collect the cross terms, using $\operatorname{scal}=2\operatorname{tr}$:

| term | value at $R$ | cross part |
|---|---|---|
| $\operatorname{scal}(R^2)$ | $2\operatorname{tr}(R^2)$ | $4\operatorname{tr}(AB)$ |
| $\operatorname{scal}(R^\#)$ | $2\operatorname{tr}(R^\#)$ | $2\operatorname{scal}(A\#B)$ |
| $\lVert\mathrm{Ric}(R)\rVert^2$ |, | $2\langle\mathrm{Ric}A,\mathrm{Ric}B\rangle$ |
| $6\lVert\mathrm{Alt}(R)\rVert^2$ |, | $12\langle\mathrm{Alt}A,\mathrm{Alt}B\rangle$ |

So the polarised identity is $4\operatorname{tr}(AB)+2\operatorname{scal}(A\#B)=2\langle\mathrm{Ric}A,\mathrm{Ric}B\rangle+12\langle\mathrm{Alt}A,\mathrm{Alt}B\rangle$. Put $A=W_+$, $B=W_-$. Their spectral supports are orthogonal, so $\operatorname{tr}(W_+W_-)=0$ and the first term drops:
$$\operatorname{scal}(W_+\#W_-)=\langle\mathrm{Ric}W_+,\mathrm{Ric}W_-\rangle+6\langle\mathrm{Alt}W_+,\mathrm{Alt}W_-\rangle.$$
Now $W=W_+-W_-$ with $\mathrm{Ric}(W)=0$ gives $\mathrm{Ric}(W_+)=\mathrm{Ric}(W_-)$, and $\mathrm{Alt}(W)=0$ gives $\mathrm{Alt}(W_+)=\mathrm{Alt}(W_-)$. Hence
$$2\operatorname{tr}(W_+\#W_-)=\operatorname{scal}(W_+\#W_-)=\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2,$$
and chaining with §2.2 gives the stated inequality. **Confirmed exactly.**

**Where the $6$ comes from, and why its coefficient is right.** It is [L15](../findings/problem.md)'s $6$ and nothing else, and it survives the polarisation through a two-step cancellation that could have gone wrong:

1. Polarising $6\lVert\mathrm{Alt}(R)\rVert^2$ produces $12\langle\mathrm{Alt}W_+,\mathrm{Alt}W_-\rangle$, i.e. a *doubled* coefficient;
2. the same polarisation produces $2\operatorname{scal}(W_+\#W_-)$ on the left, whose $2$ divides the $12$ back to $6$;
3. and the compression's own bound is stated in $2\operatorname{tr}(W_+\#W_-)$, which equals $\operatorname{scal}(W_+\#W_-)$ **only because $\operatorname{scal}=2\operatorname{tr}$**. Under $\operatorname{scal}=\operatorname{tr}$ the coefficient would come out $3$; under $\operatorname{scal}=4\operatorname{tr}$ it would be $12$.

So the coefficient is right, and it is right *conditionally on an untabled convention*. §4 pins it independently: at $W_{\mathbb{CP}^2}$ the two sides are $\tfrac43$ and $\tfrac23+6\cdot\tfrac19=\tfrac43$, which fails at coefficient $3$ ($\tfrac23+\tfrac13=1$) and at $12$ ($\tfrac23+\tfrac43=2$). **The equality anchor is what certifies the $6$, and it certifies it uniquely.**

### 2.4 "Twice each in the final step" (C11)

The block says the last two hypotheses are *"used twice each in the final step"*. On the route the block describes (polarising L15 at $(W_+,W_-)$), each is used **once**: one substitution $\mathrm{Ric}(W_+)\to\mathrm{Ric}(W_-)$, one substitution $\mathrm{Alt}(W_+)\to\mathrm{Alt}(W_-)$.

**The count is correct on a different route, and that route is natural enough that I record the claim as accurate rather than wrong.** Apply L15 twice, at $R=W$ and at $R=\lvert W\rvert$, and subtract. At $R=W$ the right-hand side vanishes (one use of Ricci-flatness, one of Bianchi) and $\lvert W\rvert^2=W^2$ with $\lvert W\rvert^\#-W^\#=4W_+\#W_-$, so
$$4\operatorname{scal}(W_+\#W_-)=\lVert\mathrm{Ric}\lvert W\rvert\rVert^2+6\lVert\mathrm{Alt}\lvert W\rvert\rVert^2.$$
Then $\mathrm{Ric}(\lvert W\rvert)=2\mathrm{Ric}(W_-)$ and $\mathrm{Alt}(\lvert W\rvert)=2\mathrm{Alt}(W_-)$ (the **second** use of each) and the factors of $4$ cancel. Same conclusion, two uses each.

**Verdict: PROVEN for one route; the phrase is route-dependent and the block does not say which route it is counting.** No defect.

## 3. Question 2, what the equality clause characterises

### 3.1 The condition, derived (C5)

Equality in §2.2 needs all three dropped quantities to vanish. Each of $W_+^\#$, $W_-^\#$, $W_+\#W_-$ is PSD, and for PSD $X$ and a projection $\Pi$, $\operatorname{tr}(\Pi X)=0\iff\Pi X\Pi=0\iff\langle X\xi,\xi\rangle=0$ for all $\xi\in\operatorname{ran}\Pi$. Reading each through $\langle A\#B\,\xi,\xi\rangle=\tfrac12\sum_{i,j}a_ib_j\langle[u_i,v_j],\xi\rangle^2$, a sum of squares with **strictly positive** weights when the sums run over eigenbases of $\mathfrak p$ and $\mathfrak m$ alone:

| dropped quantity | vanishes iff | bracket condition |
|---|---|---|
| $\operatorname{tr}(\Pi_-W_+^\#)$ | $\langle W_+^\#\xi,\xi\rangle=0\ \forall\xi\in\mathfrak m$ | $[\mathfrak p,\mathfrak p]\perp\mathfrak m$ |
| $\operatorname{tr}(\Pi_-W_-^\#)$ | $\langle W_-^\#\xi,\xi\rangle=0\ \forall\xi\in\mathfrak m$ | $[\mathfrak m,\mathfrak m]\perp\mathfrak m$ |
| $\operatorname{tr}\big((\mathrm{Id}-\Pi_-)(W_+\#W_-)\big)$ | $W_+\#W_-$ vanishes on $\mathfrak p\oplus\mathfrak k$ | $[\mathfrak p,\mathfrak m]\perp\mathfrak p$ **and** $[\mathfrak p,\mathfrak m]\perp\mathfrak k$, i.e. $[\mathfrak p,\mathfrak m]\subseteq\mathfrak m$ |

These are exactly the block's three conditions at [bounds.md](../findings/bounds.md):57, $[\mathfrak p,\mathfrak p]\perp\mathfrak m$, $[\mathfrak m,\mathfrak m]\perp\mathfrak m$, $[\mathfrak p,\mathfrak m]\subseteq\mathfrak m$. **Confirmed, verbatim.**

**Note what the raw condition does and does not give.** The first two are *orthogonality to $\mathfrak m$*, not *containment in $\mathfrak p$*: $[\mathfrak p,\mathfrak p]$ and $[\mathfrak m,\mathfrak m]$ may still leak into $\mathfrak k=\ker W$. So the raw equality condition is a grading **modulo $\ker W$** and not, on its own, a subalgebra. That is precisely the hedge [results.md](../results.md):122 still carries and [bounds.md](../findings/bounds.md):57 says is retired; §5 checks the retirement.

### 3.2 Is it "a compact symmetric pair with $E_+$ the isotropy algebra"? (C7)

**No, in both directions.** I take the two directions at named objects.

**Forward, an equality point that is no such pair: $W_{\mathbb{CP}^2}$ at $n=4$.** Its spectrum is $2\varepsilon$ on the Kähler line, $-\varepsilon$ on the $2$-dimensional complement inside $\Lambda^2_+$, and $0$ on the $3$-dimensional $\Lambda^2_-$, with $\varepsilon=1/\sqrt6$ from $4\varepsilon^2+2\varepsilon^2=1$. It attains equality exactly (§4.1). So $\dim\mathfrak p=1$, and $E_+$ would have to be the even part of a $\mathbb Z_2$-grading of $\mathfrak{so}(4)$. **It is not.** The even parts available in $\mathfrak{so}(4)$ are $\mathfrak{so}(3)$ (dimension $3$), $\mathfrak u(2)$ (dimension $4$) and $\mathfrak{so}(2)\oplus\mathfrak{so}(2)$ (dimension $2$); a $1$-dimensional even part is on none of them, since $\mathfrak k_0$ must satisfy $[\mathfrak m,\mathfrak m]\subseteq\mathfrak k_0$ with $\dim\mathfrak m=5$, and the $5$-dimensional odd part of no involution of $\mathfrak{so}(4)$ exists. So $E_+$ is the even part of no grading of $\mathfrak{so}(4)$, which is what the block's box says. **What is true instead**, and what the block's own correction records, is that $\mathfrak p\oplus\mathfrak m=\Lambda^2_+\cong\mathfrak{so}(3)$ is graded as $(\mathfrak{so}(3),\mathfrak{so}(2))$, a symmetric pair **inside a proper subalgebra of $\mathfrak{so}(n)$**, with $\mathfrak k=\Lambda^2_-$ the commuting ideal. I checked the grading directly: $[\mathfrak p,\mathfrak p]=0$, $[\mathfrak p,\mathfrak m]\subseteq\mathfrak m$ (the $\hat\omega$ rotation acting on its own $2$-plane), $[\mathfrak m,\mathfrak m]\subseteq\mathfrak p$, and nothing reaches $\Lambda^2_-$ because $[\Lambda^2_+,\Lambda^2_-]=0$.

**And this failure is generic, not exceptional.** Every zero-padded equality point fails the same way: padded $S^3\times S^3$ at $n=8$ has $\dim\mathfrak p=6$, $\dim\mathfrak m=9$, $\dim\mathfrak k=13$ ([bounds.md](../findings/bounds.md):151), so $\mathfrak p\oplus\mathfrak m$ is the symmetric pair $(\mathfrak{so}(6),\mathfrak{so}(3)\oplus\mathfrak{so}(3))$ sitting inside $\mathfrak{so}(8)$, and $E_+$ is again the isotropy algebra of a pair on a *subalgebra*, not of a decomposition of $\mathfrak{so}(8)$. Since padded $W_{\mathbb{CP}^2}$ is critical at every $n\ge4$ ([Lemma L44](../findings/problem.md)), the forward implication fails at every dimension the record works in, not only at $n=4$.

**Converse, a symmetric pair that produces no equality point.** The equality clause is a condition on **$W$**; "a compact symmetric pair with $E_+$ the isotropy algebra" is a condition on **a pair of subalgebras**. The pair does not determine a $W$, and need not carry a critical one at all. Concretely inside the subalgebra family: $(\mathfrak{so}(6),\mathfrak u(3))$ is a compact symmetric pair, and the family's member $W_{\mathfrak u(3)}\propto\Pi_{\mathfrak u(3)}-\tfrac rN\mathrm{Id}$ satisfies all three of L7's bracket conditions, $[\mathfrak h,\mathfrak h]\perp\mathfrak h^\perp$ because $\mathfrak h$ is a subalgebra, $[\mathfrak h,\mathfrak h^\perp]\subseteq\mathfrak h^\perp$ by ad-invariance, $[\mathfrak h^\perp,\mathfrak h^\perp]\perp\mathfrak h^\perp$ because the pair is symmetric, **and it is not a critical point**: [Lemma L23](../findings/ungraded-slack.md) shows a family member is critical only *at* the cap $r=n(n-2)/4$, which is $6$ at $n=6$, against $\dim\mathfrak u(3)=9$. So it is outside L7's equality locus, which lives inside the critical set. **The two conditions are not even about the same objects**, and no reading of "exactly the condition defining" survives that.

**What the equality clause actually characterises, stated positively.** At a critical point, equality holds exactly when $\mathfrak p\oplus\mathfrak m$ is a $\mathbb Z_2$-graded subalgebra of $\mathfrak{so}(n)$ with even part $\mathfrak p$, that is, $(\mathfrak p\oplus\mathfrak m,\mathfrak p)$ is a symmetric pair, **proper in $\mathfrak{so}(n)$ whenever $\ker W\ne0$**, with $\mathfrak k$ orthogonal to every bracket. That is [Lemma L155](../findings/bounds.md)'s statement, and the "proper whenever $\ker W\ne0$" clause is exactly the content the heading drops.

### 3.3 Where the false reading came from

**On the subalgebra family the false reading is true**, which explains it. For $W_{\mathfrak h}\propto\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$ one has $\mathfrak p=\mathfrak h$, $\mathfrak m=\mathfrak h^\perp$, $\ker W=0$ and $\mathfrak p\oplus\mathfrak m=\mathfrak{so}(n)$; the first and third conditions are free from $\mathfrak h$ being a subalgebra, and the surviving one, $[\mathfrak m,\mathfrak m]\perp\mathfrak m$, is exactly "$(\mathfrak{so}(n),\mathfrak h)$ is a symmetric pair". [Lemma L23](../findings/ungraded-slack.md):134 says the same thing in the same words, and [ungraded-slack.md](../findings/ungraded-slack.md):176 already warns that "the compression slack vanishing certifies a $\mathbb Z_2$-grading **only inside the subalgebra family**". **The canonical statement at [results.md](../results.md):326 generalises a family-restricted equivalence to every critical point, and the counterexample is the record's own headline competitor.**

## 4. Question 5, a universal claim with no witness: one object from each structured family

*Every number in this section is an exact hand evaluation. Nothing was run.*

### 4.1 $\mathbb{CP}^2$ at $n=4$, the block's own pinning point (C12)

Take $\psi_1=\tfrac1{\sqrt2}(\varphi_{12}+\varphi_{34})$, $\psi_2=\tfrac1{\sqrt2}(\varphi_{13}-\varphi_{24})$, $\psi_3=\tfrac1{\sqrt2}(\varphi_{14}+\varphi_{23})$, an orthonormal basis of $\Lambda^2_+$, and $W=\varepsilon\,\mathrm{diag}(2,-1,-1)$ in it, zero on $\Lambda^2_-$. Unit norm forces $6\varepsilon^2=1$.

**Structure constants.** From $[\varphi_{ab},\varphi_{cd}]=\delta_{bc}\varphi_{ad}-\delta_{ac}\varphi_{bd}-\delta_{bd}\varphi_{ac}+\delta_{ad}\varphi_{bc}$:
$$[\varphi_{12},\varphi_{13}]=-\varphi_{23},\quad[\varphi_{12},\varphi_{24}]=\varphi_{14},\quad[\varphi_{34},\varphi_{13}]=-\varphi_{14},\quad[\varphi_{34},\varphi_{24}]=\varphi_{23},$$
so $[\psi_1,\psi_2]=\tfrac12(-\varphi_{23}-\varphi_{14}-\varphi_{14}-\varphi_{23})=-\sqrt2\,\psi_3$, and cyclically $[\psi_a,\psi_b]=-\sqrt2\,\epsilon_{abc}\psi_c$.

**Criticality, from those constants alone.** $W^\#=2\big[\lambda_2\lambda_3\psi_1\psi_1^{\mathsf T}+\lambda_1\lambda_3\psi_2\psi_2^{\mathsf T}+\lambda_1\lambda_2\psi_3\psi_3^{\mathsf T}\big]=2\varepsilon^2\,\mathrm{diag}(1,-2,-2)$, and $W^2=\varepsilon^2\,\mathrm{diag}(4,1,1)$, so
$$Q(W)=W^2+W^\#=\varepsilon^2\,\mathrm{diag}(6,-3,-3)=3\varepsilon\cdot\varepsilon\,\mathrm{diag}(2,-1,-1)=3\varepsilon\,W,$$
**one and the same $\theta=3\varepsilon=\sqrt{3/2}$ on all three eigenvalues**, and $Q(W)=0=\theta\cdot0$ on $\Lambda^2_-$ because $[\Lambda^2_+,\Lambda^2_-]=0$. **$W_{\mathbb{CP}^2}$ is a critical point, verified by hand, with the record's $\theta$.** Two further anchors fall out: $\operatorname{tr}(W^\#)=2\varepsilon^2(1-2-2)=-6\varepsilon^2=-1$, which is the record's $\operatorname{tr}W^\#=-1$; and L15's identity at $R=W$ reads $2(1)+2(-1)=0=\lVert\mathrm{Ric}W\rVert^2+6\lVert\mathrm{Alt}W\rVert^2$, which holds.

**Left side.** $W_-=\varepsilon(\psi_2\psi_2^{\mathsf T}+\psi_3\psi_3^{\mathsf T})$, so $\operatorname{tr}(W_-)=2\varepsilon$, $\operatorname{tr}(W_-^2)=2\varepsilon^2$, and
$$\theta\operatorname{tr}(W_-)+\operatorname{tr}(W_-^2)=6\varepsilon^2+2\varepsilon^2=8\varepsilon^2=\tfrac86=\tfrac43.$$

**Right side.** $\mathrm{Alt}$ at $n=4$ is the projection onto $\mathbb R\star$ with $\lVert\star\rVert^2=6$, so $\delta^2=\operatorname{tr}(W_-\star)^2/6$; $\star=+1$ on $\Lambda^2_+$ so $\operatorname{tr}(W_-\star)=2\varepsilon$ and
$$\delta^2=\frac{4\varepsilon^2}{6}=\frac{4}{36}=\tfrac19.$$
For the Ricci term, $W_-=\varepsilon(\Pi_+-\hat\omega\hat\omega^{\mathsf T})$ with $\hat\omega=\psi_1$. $\Pi_+=\tfrac12(\mathrm{Id}+\star)$ has $\mathrm{Ric}(\Pi_+)=\tfrac12\big((n-1)\mathrm{id}+0\big)=\tfrac32\mathrm{id}_4$; and $(\hat\omega\hat\omega^{\mathsf T})_{ijkl}=\omega_{ij}\omega_{kl}$ gives $\mathrm{Ric}(\hat\omega\hat\omega^{\mathsf T})_{ij}=\sum_k\omega_{ik}\omega_{jk}=(\omega\omega^{\mathsf T})_{ij}=\tfrac12\delta_{ij}$, since $\omega^2=-\tfrac12I_4$. So $\mathrm{Ric}(W_-)=\varepsilon\,\mathrm{id}_4$ and $\lVert\mathrm{Ric}(W_-)\rVert^2=4\varepsilon^2=\tfrac23$. Hence
$$\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2=\tfrac23+\tfrac23=\tfrac43 .$$

**Both sides $\tfrac43$, $\delta^2=\tfrac19$, the block's two numbers, reproduced exactly.** And the three equality conditions are visible in the objects: $W_+^\#=0$ (a single rank one has no self-bracket); $W_-^\#=2\varepsilon^2\psi_1\psi_1^{\mathsf T}$, supported on $\mathfrak p$; $W_+\#W_-=2\varepsilon^2(\psi_2\psi_2^{\mathsf T}+\psi_3\psi_3^{\mathsf T})$, supported on $\mathfrak m$. Also $2\operatorname{tr}(W_+\#W_-)=8\varepsilon^2=\tfrac43$ and $-\operatorname{tr}(\Pi_-W^\#)=8\varepsilon^2=\tfrac43$: **every intermediate quantity in §2 checks.**

### 4.2 $S^3\times S^3$ at $n=6$, a sphere product, $\delta^2=0$

$\mathfrak p=\mathfrak{so}(3)\oplus\mathfrak{so}(3)$ ($6$-dimensional), $\mathfrak m=\mathbb R^3\otimes\mathbb R^3$ ($9$-dimensional), $\ker W=0$, two eigenvalues $\lambda_+$ and $-\lambda_-$. Tracelessness ($\operatorname{tr}W=\tfrac12\operatorname{scal}(W)=0$ from $\mathrm{Ric}(W)=0$) gives $6\lambda_+=9\lambda_-$; unit norm gives $6\lambda_+^2+9\lambda_-^2=1$, hence $\tfrac{45}2\lambda_-^2=1$, $\lambda_-^2=\tfrac2{45}$. With $\theta_0(6)=\sqrt{2\cdot5\cdot4}/6=\sqrt{10}/3$:
$$\theta\operatorname{tr}(W_-)+\operatorname{tr}(W_-^2)=\tfrac{\sqrt{10}}3\cdot9\sqrt{\tfrac2{45}}+9\cdot\tfrac2{45}=3\sqrt{\tfrac{20}{45}}+\tfrac25=2+\tfrac25=\tfrac{12}5 .$$
For the right side, $W_-=\lambda_-\Pi_{\mathfrak m}$ and $\mathrm{Ric}(\Pi_{\mathfrak m})_{aa}$ counts the mixed coordinate pairs through $a$, which is $3$ for every $a$, with no off-diagonal entries; so $\mathrm{Ric}(W_-)=3\lambda_-\mathrm{id}_6$ and $\lVert\mathrm{Ric}(W_-)\rVert^2=54\lambda_-^2=\tfrac{108}{45}=\tfrac{12}5$. And $\delta^2=0$: $\Pi_{\mathfrak m}$ has no component with four distinct indices, which is all $\mathrm{Alt}$ sees.

**Both sides $\tfrac{12}5$. Equality, exactly, with $\delta^2=0$**, consistent with the block's "invisible at every sphere product".

### 4.3 $S^2\times S^4$ at $n=6$, the strictness refutation, derived rather than quoted (C13)

I built this one from scratch because it is the object the block's box uses to refute [results.md](../results.md):326, and the record states only its decimal.

$R=\Pi_{\Lambda^2\mathbb R^2}+\Pi_{\Lambda^2\mathbb R^4}$ for the unit round factors, so $\mathrm{Ric}(R)=\mathrm{diag}(1,1,3,3,3,3)$ and $s=14$. Write $K(h)_{ijkl}=h_{ik}\delta_{jl}+h_{jl}\delta_{ik}-h_{il}\delta_{jk}-h_{jk}\delta_{il}$, for which $\mathrm{Ric}(K(h))=(n-2)h+\operatorname{tr}(h)\,\mathrm{id}$; then $W=R-\tfrac1{n-2}K(h)$ is Ricci-flat for $h=\rho-\tfrac{s}{2(n-1)}\mathrm{id}=\mathrm{diag}(-\tfrac25,-\tfrac25,\tfrac85,\tfrac85,\tfrac85,\tfrac85)$, and $K(h)$ is diagonal in the $\varphi_{ij}$ basis with entry $h_{ii}+h_{jj}$:

| block | multiplicity | eigenvalue of $W$ |
|---|---|---|
| $\varphi_{12}$, the $S^2$ plane | $1$ | $1-\tfrac14(-\tfrac45)=\tfrac65$ |
| $\varphi_{ij}$, both in the $S^4$ | $6$ | $1-\tfrac14(\tfrac{16}5)=\tfrac15$ |
| mixed | $8$ | $0-\tfrac14(\tfrac65)=-\tfrac3{10}$ |

$\operatorname{tr}W=\tfrac65+\tfrac65-\tfrac{24}{10}=0$ and $\lVert W\rVert^2=\tfrac{36}{25}+\tfrac6{25}+\tfrac{72}{100}=\tfrac{12}5$.

**It is critical**, with $Q(W)=\tfrac32W$, checked on all three blocks from $\langle\xi,W^\#\xi\rangle=\sum_k\lambda_{ik}\lambda_{kj}$ for $\xi=\varphi_{ij}$ (the coordinate structure constants being $\pm1$ on triples $\varphi_{ij},\varphi_{jk},\varphi_{ik}$, and the $\tfrac12$ cancelling against the ordered pairs):

| $\xi$ | $\langle\xi,W^\#\xi\rangle$ | $+\ \lambda_\xi^2$ | $=\ \tfrac32\lambda_\xi$ |
|---|---|---|---|
| $\varphi_{12}$ | $4\cdot(\tfrac3{10})^2=\tfrac9{25}$ | $\tfrac{36}{25}$ | $\tfrac{45}{25}=\tfrac95=\tfrac32\cdot\tfrac65$ ✓ |
| $\varphi_{34}$ | $2(\tfrac3{10})^2+2(\tfrac15)^2=\tfrac{13}{50}$ | $\tfrac1{25}$ | $\tfrac{15}{50}=\tfrac3{10}=\tfrac32\cdot\tfrac15$ ✓ |
| $\varphi_{13}$ | $\tfrac65\cdot(-\tfrac3{10})+3\cdot(-\tfrac3{10})(\tfrac15)=-\tfrac{27}{50}$ | $\tfrac9{100}$ | $-\tfrac{45}{100}=-\tfrac9{20}=\tfrac32\cdot(-\tfrac3{10})$ ✓ |

So $\theta=\tfrac32/\lVert W\rVert$ and $\boxed{\theta^2=\tfrac94\big/\tfrac{12}5=\tfrac{15}{16}}$, i.e. $\theta=\tfrac{\sqrt{15}}4=0.968245\ldots<1$. **The record's decimal and the Lean row's $15/16$ are both exactly right.**

**And it attains equality.** Working unnormalised (the statement is homogeneous, §1.4), with $W_-=\tfrac3{10}\Pi_{\text{mixed}}$: $\operatorname{tr}(W_-)=\tfrac{12}5$, $\operatorname{tr}(W_-^2)=\tfrac{18}{25}$, so the left side is $\tfrac32\cdot\tfrac{12}5+\tfrac{18}{25}=\tfrac{108}{25}$. On the right, $\mathrm{Ric}(\Pi_{\text{mixed}})=\mathrm{diag}(4,4,2,2,2,2)$ by the same pair count, so $\lVert\mathrm{Ric}(W_-)\rVert^2=\tfrac9{100}(16+16+16)=\tfrac{108}{25}$, and $\delta^2=0$. **Both sides $\tfrac{108}{25}$.**

**So equality holds at $\theta=\sqrt{15}/4<1$, and [results.md](../results.md):326's "it fails strictly at the low-value ones" is refuted, by hand, at an object the record's own catalogue supports.** $S^2\times S^4$ sits below $\Theta_6^2=\tfrac{10}9$ as well, so it is extremal in none of the record's senses.

### 4.4 Padded objects

Zero-padding $W_{\mathbb{CP}^2}$ to any $n\ge4$ leaves $\theta$, $W_-$, $\mathfrak p$ and $\mathfrak m$ untouched and adds only to $\ker W$. The left side is unchanged at $\tfrac43$. On the right, $\mathrm{Ric}(W_-)$ is the same $\varepsilon\,\mathrm{id}_4$ padded by zeros, so $\lVert\mathrm{Ric}(W_-)\rVert^2=\tfrac23$; and $\mathrm{Alt}(W_-)$ picks up no new $\Lambda^4\mathbb R^n$ components because $W_-$ has support only on index quadruples inside $\{1,2,3,4\}$, so $\delta^2=\tfrac19$ still. **Equality persists at every $n$**, which independently confirms [results.md](../results.md):362's "whose defect is exactly $1/9$ in every ambient dimension". Padded $S^3\times S^3$ at $n=8$ behaves identically.

### 4.5 A subalgebra Casimir

$W_{\mathfrak h}\propto\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$ has $\mathfrak p=\mathfrak h$, $\mathfrak m=\mathfrak h^\perp$, $\ker W=0$; two of L7's three conditions are free ($\mathfrak h$ a subalgebra, plus ad-invariance) and the third is $[\mathfrak m,\mathfrak m]\perp\mathfrak m$, i.e. $S_{\mathfrak{mmm}}=0$. **So on this family L7's equality is exactly [Lemma L23](../findings/ungraded-slack.md)'s $S_{\mathfrak{mmm}}=0$, which L23 proves is exactly criticality at the cap $r=n(n-2)/4$.** The two statements agree, and L23's own closed-form slack $S=\tfrac r{nN}[4(N-r)-n^2]$ is the same inequality restricted here, as [ungraded-slack.md](../findings/ungraded-slack.md):150 says. **No finding: L7 is consistent with L23 on the whole family, and L23 is where the misreading in §3.3 originates.**

### 4.6 An object with $\ker W\ne0$

$W_{\mathbb{CP}^2}$ itself, with $\dim\ker W=3$ out of $6$, half of $\Lambda^2$. **Nothing in the derivation degrades**: $\Pi_-$ is the only projection that appears, $\Pi_0$ never enters the inequality, and $\Pi_-W^2=W_-^2$ holds regardless. Equality is attained, as §4.1 shows. **The kernel bites only in the equality clause's closure statement** (§5), which is exactly where the record put it.

### 4.7 Is the inequality ever strict?, a witness that it is not an identity

$C_5$ blow-up at $n=10$: a genuine critical point with trivial kernel, $S_{\mathfrak{mmm}}=0$ but $\langle[\mathfrak p,\mathfrak p],\mathfrak m\rangle^2=80$ ([bounds.md](../findings/bounds.md):152, :163). The first equality condition $[\mathfrak p,\mathfrak p]\perp\mathfrak m$ fails, so $\operatorname{tr}(\Pi_-W_+^\#)>0$ and **the inequality is strict there**. This matters: without such a witness the lemma could be an identity in disguise, and its equality clause would be empty of content. *That figure is a recorded measurement, not a hand evaluation; I record its provenance and did not re-derive it.*

## 5. The kernel-closure upgrade, and the hypothesis it needs (C6)

The block asserts: *"The kernel closes too, so the class is a genuine graded subalgebra rather than one stated modulo $\ker W$, [Lemma L155](../findings/bounds.md) carries the closure clause and the hedge is retired."*

**The chain is L7's slack $\to\operatorname{tr}X_{\mathrm{inv}}\to X_{\mathrm{inv}}=0\to$ the grading with closure, and only its first link was unchecked on file.** I checked that link.

With $C=W_+\#W_-$, $S=W_+^\#+W_-^\#$, so that $\lvert W\rvert^\#=S+2C$ and $W^\#=S-2C$, [Theorem A](../ATTEMPTS.md)'s $X_{\mathrm{inv}}=\lvert W\rvert^\#-P_+W^\#P_++P_-W^\#P_-$ has spectral-diagonal blocks
$$P_+X_{\mathrm{inv}}P_+=4P_+CP_+,\qquad P_-X_{\mathrm{inv}}P_-=2P_-SP_-,\qquad P_0X_{\mathrm{inv}}P_0=P_0\lvert W\rvert^\#P_0,$$
which is [L154](../findings/bounds.md)'s Result 5(a) reading and which I reproduce. Hence $\operatorname{tr}X_{\mathrm{inv}}=4\operatorname{tr}(P_+C)+2\operatorname{tr}(P_-S)+\operatorname{tr}(P_0\lvert W\rvert^\#P_0)$.

L7's slack, from §2, is $2\operatorname{tr}(C)+\operatorname{tr}(\Pi_-W^\#)=2\operatorname{tr}(P_+C)+2\operatorname{tr}(P_0C)+\operatorname{tr}(P_-S)$. So
$$\text{slack}-\tfrac12\operatorname{tr}X_{\mathrm{inv}}=2\operatorname{tr}(P_0C)-\tfrac12\operatorname{tr}\big(P_0(S+2C)\big)=-\tfrac12\operatorname{tr}\big(P_0(S-2C)\big)=-\tfrac12\operatorname{tr}(P_0W^\#).$$
**At a critical point $W^\#=\theta W-W^2$, which annihilates $\ker W$, so $\operatorname{tr}(P_0W^\#)=0$ and the slack is exactly $\tfrac12\operatorname{tr}X_{\mathrm{inv}}$.** [r699](../reviews/REVIEW_r699.md)'s claim, which [bounds.md](../findings/bounds.md):70 carries without proof, is confirmed, **and criticality is the hypothesis that makes it true.** Off the critical set the two differ by $\tfrac12\operatorname{tr}(P_0W^\#)$, which has no sign in general.

Given that, [L154](../findings/bounds.md)(i), three PSD blocks, so a vanishing trace forces each block to vanish, and a PSD operator with a zero diagonal block vanishes on that block's whole row, turns the trace statement into $X_{\mathrm{inv}}=0$, and [L155](../findings/bounds.md) reads $X_{\mathrm{inv}}=0$ as the three inclusions **plus** $[\mathfrak p\oplus\mathfrak m,\mathfrak p\oplus\mathfrak m]\perp\mathfrak k$ from the $00$ block. That fourth condition is precisely the closure the raw equality clause of §3.1 lacks. **So the hedge really is retired, and only at a critical point.**

**The finding that goes with it.** [bounds.md](../findings/bounds.md):57 states the retirement with no hypothesis attached, and [L155](../findings/bounds.md)'s own heading advertises "**with no criticality**". Those two sentences sit three lines apart and, read together, say the closure is criticality-free. **It is not**: L155 is criticality-free as a statement about $X_{\mathrm{inv}}=0$, but the passage *from L7's equality to $X_{\mathrm{inv}}=0$* consumes criticality twice over, once through $\operatorname{tr}(P_0W^\#)=0$ above, and once inside L154(i)'s own proof, which uses $W^\#=\theta W-W^2$ to get $P_0C=0$. **Recorded as an imprecision in the block's phrasing, not as a defect in the mathematics.**

## 6. The discrepancy register, three steps each

### 6.1 The rank-one formula is off by a factor $2$ (C10), REAL, inert for L7

**Locate.** [bounds.md](../findings/bounds.md):51: *"rank-one positivity, $vv^{\mathsf T}\#ww^{\mathsf T}=[v,w][v,w]^{\mathsf T}$, a theorem rather than an assumption"*.

**Exhibit, at a named object.** Under that formula, $\mathrm{Id}=\sum_a\varphi_a\varphi_a^{\mathsf T}$ gives $\langle\mathrm{Id}^\#\xi,\xi\rangle=\sum_{a,b}c_{ab\xi}^2=2(n-2)$ for unit $\xi$, using the Killing computation **this same file states at line 188**; so $\mathrm{Id}^\#=2(n-2)\mathrm{Id}$. But L15's identity at $R=\mathrm{Id}$, with $\mathrm{Ric}(\mathrm{Id})=(n-1)\mathrm{id}_n$ and $\mathrm{Alt}(\mathrm{Id})=0$, forces $2\operatorname{tr}(\mathrm{Id})+2\operatorname{tr}(\mathrm{Id}^\#)=n(n-1)^2$, i.e. $\mathrm{Id}^\#=(n-2)\mathrm{Id}$. Sharper still, at $W_{\mathbb{CP}^2}$: with the block's formula, $W^\#=4\varepsilon^2\mathrm{diag}(1,-2,-2)$ and $Q(W)=\varepsilon^2\mathrm{diag}(8,-7,-7)$, which is **not proportional to $W$**, $8\varepsilon^2/2\varepsilon=4\varepsilon$ against $-7\varepsilon^2/(-\varepsilon)=7\varepsilon$. **Under the block's own $\#$, its own pinning point is not a critical point.** And $\operatorname{tr}(W^\#)$ would be $-2$ against the record's $-1$. The correct constant is $\tfrac12$, which is written explicitly at [bounds.md](../findings/bounds.md):187, one hundred and thirty-six lines below.

**Argue the opposite.** The charitable reading is that the block invokes the formula only for the word *positivity* ($\#$ carries rank-one PSDs to rank-one PSDs, whatever the positive constant) and every use of it in the proof is a sign, never a magnitude. **That reading holds, and the inequality is untouched**: the $\tfrac12$ appears in both the identity of §2.1 (through $Q$) and the polarisation of §2.3 (through L15), and cancels. So the error is real as a formula, quoted as a theorem, and inert in its own proof, **live only for a consumer who lifts it**, which is what the record's named trap describes.

### 6.2 "$\Pi_-\preceq I$" is credited with a step it cannot do, WITHDRAWN as a discrepancy

**Locate.** [bounds.md](../findings/bounds.md):51: *"kills two terms against $\Pi_-\preceq I$"*.

**Exhibit.** Dropping $-\operatorname{tr}(\Pi_-W_+^\#)$ needs $\operatorname{tr}(\Pi_-W_+^\#)\ge0$, which needs $\Pi_-\succeq0$: an operator with $\Pi\preceq\mathrm{Id}$ alone can be $-\mathrm{Id}$, for which the term flips sign. It is the *other* half of the sandwich that does the killing; $\Pi_-\preceq\mathrm{Id}$ does the bounding of the surviving term.

**Argue the opposite.** "$\Pi_-\preceq I$" is a standard shorthand for the standing sandwich $0\preceq\Pi_-\preceq\mathrm{Id}$ that every orthogonal projection satisfies, both halves of which are available at that point in the proof and both of which are in fact used. **The charitable reading is available and correct, so this is withdrawn as a discrepancy and recorded as wording.**

### 6.3 "THIS FILE SAYS SO 79 LINES BELOW" (C14), REAL, minor

**Locate.** [bounds.md](../findings/bounds.md):59.

**Exhibit.** Counting from the box itself, line $59+79=138$ lands inside [Lemma L106](../findings/bounds.md):135–137, which is about $\Delta(W)=0$ and its grading consequence and says nothing about the compact-symmetric-pair reading of L7. Counting from the block's heading, $43+79=122$ lands in the $\Delta$ dimension-screen paragraph, which is likewise unrelated. The refutation this file actually carries is at [L155](../findings/bounds.md):74–86, **fifteen lines above** the box, and at [bounds.md](../findings/bounds.md):163.

**Argue the opposite.** The pointer was presumably accurate when written and the file has grown between. That excuses its origin and not its present state: a reader following it arrives at a block about a different invariant. **Real, and it is the mildest form of the named trap, a correction that points away from itself.**

### 6.4 The canonical statement's ingredient list (C9), REAL

**Locate.** [results.md](../results.md):326: *"the proof needs only bilinearity of $\#$, its rank-one positivity, a partial trace, and the polarized identity of Observation L15"*.

**Exhibit.** §1 shows the proof needs criticality (without it there is no identity to compress), Ricci-flatness and first Bianchi (without them the final equality is $\langle\mathrm{Ric}W_+,\mathrm{Ric}W_-\rangle+6\langle\mathrm{Alt}W_+,\mathrm{Alt}W_-\rangle$, neither term a square). None of the three is on that list, and the word *"only"* asserts the list is complete.

**Argue the opposite.** A reader might take criticality as implicit in "at every critical point", which the same sentence carries. That covers criticality and covers neither of the other two: Ricci-flatness and first Bianchi are properties of $\mathcal W_n$, so a reader working in $\mathcal W_n$ gets them free, **but a reader taking the lemma into $S^2(\Lambda^2)$, which is exactly where the polarisation lives, gets a false statement.** [bounds.md](../findings/bounds.md):53 says these were "omitted from the first version's ingredient list" and supplies them; **the correction did not travel to [results.md](../results.md):326, which is the canonical statement.**

### 6.5 The heading (C15), REAL, and it is this record's signature failure

**Locate.** [bounds.md](../findings/bounds.md):43, *"Lemma L7 (a bound at every critical point, and the symmetric-pair equality class), canonical statement and proof"*, and the identical phrase in [results.md](../results.md):326's heading.

**Exhibit.** §3.2 refutes the symmetric-pair reading in both directions. The heading is the anchor other files link to, [lean/INDEX.md](../lean/INDEX.md):179 and the cross-references inside [bounds.md](../findings/bounds.md) itself all resolve through it, so the refuted phrase travels into every citation of the lemma while the correcting box, sixteen lines below, does not.

**Argue the opposite.** The box is inside the same block, in capitals, and any reader of the block reads it. **That is true of a reader of the block and false of a reader of a link, a table of contents, or [results.md](../results.md):122's landscape line**, and it is precisely the failure mode the brief names. **Real.**

## 7. Quantifier order, scope, and every edge of the range

**Quantifier order.** The statement is $\forall n\ \forall W\in\mathcal W_n$ critical: (inequality). $\theta$ is bound *inside*, by $W$, through $Q(W)=\theta W$, it is not a constant of the dimension. **No quantifier is inverted and none is left dangling**; in particular the $6$ is a genuine universal constant, quantified outside everything, and $\delta^2$ is a function of $W$.

| edge | answer |
|---|---|
| **Smallest admissible $n$** | $n=4$, where $\mathcal W_n$ first is nonzero, and where §4.1 exhibits equality. Nothing in the derivation sees $n$. |
| **Odd $n$** | Unaffected. The derivation contains no parity step, no $\theta_0(n)$ and no $\Theta_n$, so the odd-$n$ trap that [results.md](../results.md):362 records for the target bound does not reach L7. **This is worth saying loudly: L7 is one of the few blocks on the record with no parity exposure.** |
| **$\ker W\ne0$** | Fine for the inequality (§4.6); it is where the equality clause needs its closure argument (§5), and where the symmetric-pair reading fails (§3.2). |
| **$W_-=0$** | Both sides are $0$ and equality holds vacuously. **The case cannot occur at $W\ne0$ in $\mathcal W_n$**: $\mathrm{Ric}(W)=0$ gives $\operatorname{tr}_{\Lambda^2}W=\tfrac12\operatorname{scal}(W)=0$, so a nonzero traceless $W$ has eigenvalues of both signs and $W_\pm\ne0$. **The block does not say this**, and a consumer checking the degenerate case has to derive it. |
| **$\theta\le0$** | Admissible and harmless: the left side only decreases while the right stays $\ge0$. Equality at $\theta<0$ is still governed by the same three bracket conditions, so the clause is not a positive-$\theta$ statement. |
| **$W=0$** | Trivially critical for every $\theta$, and $0\le0$. Excluded implicitly by "critical point"; harmless either way. |
| **Scaling** | Degree-$2$ homogeneous (§1.4), so the lemma is a statement about the critical *ray*, not the critical *point*. |

**One reach the record does not note.** $P$ is odd, so $-W$ is critical whenever $W$ is, with eigenvalue $-\theta$ and $(-W)_-=W_+$. Applying L7 at $-W$ gives a second inequality with the *same* right-hand side, since $\mathrm{Ric}(W_+)=\mathrm{Ric}(W_-)$ and $\mathrm{Alt}(W_+)=\mathrm{Alt}(W_-)$. **I record the observation and do not fold it into any verdict**: it is a consequence of the block, unaudited here, and supplying it as though it were checked is exactly what a verifier must not do.

## 8. Comparing the forms

| location | what it says | status |
|---|---|---|
| [findings/bounds.md](../findings/bounds.md):47–59 | The inequality, the proof, the three named hypotheses, the three-condition equality clause, the closure upgrade, and the box refuting the symmetric-pair reading | **The only correct and complete form on the record.** Defects: the $\#$ factor (§6.1), the heading (§6.5), the stale pointer (§6.3), and the unstated criticality in the closure sentence (§5). |
| [results.md](../results.md):326 | The inequality (identical display), then the false equivalence, the false strictness clause, and the deficient ingredient list | **BROKEN as written.** The inequality is right; everything after the semicolon is not. |
| [results.md](../results.md):122 | "equality exactly where the eigenspace ranges are bracket-graded **modulo $\ker W$**, which is wider than the compact symmetric pairs" | **Correct, and superseded.** The hedge is true of the raw equality condition (§3.1) and weaker than what §5 establishes; "wider than the compact symmetric pairs" is right and is the clause [results.md](../results.md):326 contradicts, **in the same file**. |
| [lean/INDEX.md](../lean/INDEX.md):179 | L7 marked **partial**; carries $\theta^2(S^2\times S^4)=15/16$, the margin $1/16$, the correct observation that a matrix inequality implies its trace and not conversely, and **Owed: the inequality itself, and that the bracket-grading conditions hold modulo $\ker W$** | **Row exists and is accurate.** Its $15/16$ I reproduced exactly (§4.3). Its "owed" list is now half-cleared by [L155](../lean/INDEX.md):187, which the index itself records. **What the row still has to claim, and does not, is the closure clause's dependence on criticality** (§5), as written it inherits L155's "criticality unused", which is true of L155 and false of the passage from L7 to it. |

**The two files disagree with each other on the equality class, and one of them disagrees with itself**: [results.md](../results.md):122 says the class is *wider* than the compact symmetric pairs; [results.md](../results.md):326 says it is *exactly* them.

## 9. The gap between what is proven and what is used, what a consumer may cite

**May be cited, in full:**

> Let $W\in\mathcal W_n$ satisfy $Q(W)=\theta W$, and set $W_-=\tfrac12(\lvert W\rvert-W)\succeq0$ using the **spectral** absolute value, $\delta^2=\lVert\mathrm{Alt}(W_-)\rVert^2$. Then $\theta\operatorname{tr}(W_-)+\operatorname{tr}(W_-^2)\le\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2$, at every $n\ge4$, either parity, with no norm and no sign condition, homogeneously of degree $2$. Equality holds exactly when $[\mathfrak p,\mathfrak p]\perp\mathfrak m$, $[\mathfrak m,\mathfrak m]\perp\mathfrak m$ and $[\mathfrak p,\mathfrak m]\subseteq\mathfrak m$; equivalently, and **using criticality a second time**, exactly when $\mathfrak p\oplus\mathfrak m$ is a $\mathbb Z_2$-graded subalgebra of $\mathfrak{so}(n)$ with even part $\mathfrak p$, proper in $\mathfrak{so}(n)$ whenever $\ker W\ne0$.

**Must be carried with it:** the sign convention $W_-\succeq0$ (§2.1), the conventions $\operatorname{scal}=2\operatorname{tr}$ and $\mathrm{Ric}(A)_{ij}=\sum_kA_{ikjk}$ (§0), and the fact that $Q$ preserves $\mathcal W_n$ (§0).

**May not be cited:**

- **"a compact symmetric pair with $E_+$ the isotropy algebra"**, in any form, including the heading. False in both directions (§3.2). It is true **only** on the subalgebra family (§4.5), where it is [L23](../findings/ungraded-slack.md)'s statement and should be cited from there.
- **"it fails strictly at the low-value ones"**. Refuted at $S^2\times S^4$, $\theta=\sqrt{15}/4$ (§4.3).
- **"Every known critical point with value above $1$ satisfies it"** as a proved statement. $\mathbb{HP}^2$'s membership rests on a numerical check to $1.4\times10^{-15}$ ([bounds.md](../findings/bounds.md):70), not on an argument, and I found no proof of it on file. **HYPOTHESIS-DEBT on that one clause**: what is owed is that $\operatorname{ran}W_+\oplus\operatorname{ran}W_-$ at the quaternionic-Kähler operator on $\mathbb{HP}^2$ is a $\mathbb Z_2$-graded subalgebra of $\mathfrak{so}(8)$ with even part $\operatorname{ran}W_+$.
- **"$vv^{\mathsf T}\#ww^{\mathsf T}=[v,w][v,w]^{\mathsf T}$"**. Off by $2$ (§6.1).
- **"L7 is the trace of the matrix inequality $X_{\mathrm{inv}}\succeq0$"** as a claim of equal strength. The trace direction is what I verified (§5); the converse is false, as [lean/INDEX.md](../lean/INDEX.md):179 already records with the $\mathrm{diag}(2,0)$ against $\mathrm{diag}(0,1)$ example. The block states it correctly as a *why only L15's surviving identity is used*, and a consumer must not read it as supplying the refuted half.

**The one imported ingredient I did not verify** is [L15](../findings/problem.md)'s identity in general. It is on file as confirmed three ways, it rests on [Lemma L131](../findings/isotropy-cap.md) which I did not open, and I checked it at $R=W_{\mathbb{CP}^2}$, where my structure-constant computation of $\operatorname{tr}(W^\#)=-1$ agrees with it. **The claim that the $6$ is correct is therefore conditional on L15**, and unconditional on everything else in L7's proof.

## 10. What would break it, and what I did to look for it

**The object that would falsify the inequality** is a critical $W\in\mathcal W_n$ with $\theta\operatorname{tr}(W_-)+\operatorname{tr}(W_-^2)>\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2$. By §2 that requires one of: $\#$ failing to preserve the PSD cone at some pair $(W_+,W_-)$; $\Pi_-$ failing $0\preceq\Pi_-\preceq\mathrm{Id}$; L15's identity failing off the Bianchi locus, at $W_+$ or $W_-$; or $Q(W)$ leaving $\mathcal W_n$ so that criticality is only a projected equation. **Each of the first two is a structural fact with no free parameter**, so the whole of the falsifier's room is in the last two.

**The object that would falsify the equality clause** is a critical $W$ attaining equality whose $\mathfrak p\oplus\mathfrak m$ is not a subalgebra, necessarily one with $\ker W\ne0$, since the leak the raw conditions permit is into $\mathfrak k$ alone (§3.1). By §5 that object cannot exist at a critical point, and the argument's single load-bearing step is $\operatorname{tr}(P_0W^\#)=0$, which is criticality.

**What I did to look for both.** I rebuilt the derivation independently and checked each of its five steps against the object it applies to. I then evaluated the statement exactly at four objects spanning the record's structured families, $\mathbb{CP}^2$ (equality, $\ker W\ne0$, $\delta^2\ne0$), $S^3\times S^3$ (equality, $\delta^2=0$, trivial kernel), $S^2\times S^4$ (equality, three eigenvalues, $\theta<1$), and every zero-padding of the first two (equality at all $n$), deriving criticality itself at two of them rather than taking it from the record, and I located a strict point ($C_5$ blow-up, §4.7) so the lemma is not an identity. **I found no falsifier of the inequality, none of the three-condition equality clause, and two falsifiers of the canonical statement's added clauses.**

## 11. Verdict

**PROVEN, hypotheses corrected**, for the inequality of [bounds.md](../findings/bounds.md):47–49 and for the equality clause of [bounds.md](../findings/bounds.md):57, with the hypothesis list corrected to include $Q$'s preservation of $\mathcal W_n$, the convention $\operatorname{scal}=2\operatorname{tr}$, the sign convention $W_-\succeq0$, and criticality a second time inside the closure clause.

**BROKEN**, for the canonical statement at [results.md](../results.md):326, on three counts read alone as a consumer would read it: the equivalence to a compact symmetric pair with $E_+$ the isotropy algebra, false in both directions; the strictness claim, refuted exactly at $S^2\times S^4$; and the "needs only" ingredient list, missing every hypothesis the proof uses.

**HYPOTHESIS-DEBT**, narrowly, on the clause "every known critical point with value above $1$ satisfies it": $\mathbb{HP}^2$'s membership is numerical, and what is owed is that its $\operatorname{ran}W_+\oplus\operatorname{ran}W_-$ is a $\mathbb Z_2$-graded subalgebra of $\mathfrak{so}(8)$ with even part $\operatorname{ran}W_+$.

*No numerical work was done in this round; the record's decimals were converted to surds before use and every value above is exact.*

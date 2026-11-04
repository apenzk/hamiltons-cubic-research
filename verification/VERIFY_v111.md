# VERIFY v111, L52: the shared-frame majorization bound, its "exact iff one shared frame" clause, the "do not couple usefully" heading, and the $(t_F/2)^{3/2}\Theta_n$ display

**Cold brief, verifier v111.** No numerical work was done: no script was run and no computation was launched. Every number below is an exact hand evaluation of a quantity the record already states, and where a figure of the record's own is quoted it is labelled as the record's and never used as evidence for a positive claim. Log at [agent_logs/verify-L52-v111.log](../agent_logs/verify-L52-v111.log). Sources read in full: [findings/bispectral.md](../findings/bispectral.md), [results.md](../results.md):248 and :721, [lean/INDEX.md](../lean/INDEX.md) rows for L52, L54, CubicConvexity and DoublyStochastic, the theorem headers of [DoublyStochastic.lean](../lean/HamiltonsCubic/Results/DoublyStochastic.lean), and [references/nienhaus-petersen-wink-2022-betti-second-kind/notes.md](../references/nienhaus-petersen-wink-2022-betti-second-kind/notes.md).

## Claim table

| # | Claim, as a consumer reads it | Verdict |
|---|---|---|
| C1 | The displayed inequality $\theta\le\tfrac32[p_3(K)+3M_+(1-p_2(K))]-\tfrac12[p_3(K')+3m(p_2(K')-3)]$ | **PROVEN** |
| C2 | The convexity/concavity directions and the ranges they are asserted on | **PROVEN** |
| C3 | Equality clause, $\Leftarrow$ half ("$W$ diagonal in a shared frame $\Rightarrow$ bound exact") | **BROKEN** as written, false in the basis the block itself cites |
| C4 | Equality clause, $\Rightarrow$ half, by the Karamata route | **PROVEN**, on an unread source (HLP/Karamata equality is in no file under [references/](../references/)) |
| C5 | Equality clause, $\Rightarrow$ half, by the "Karamata is not needed" Jensen route | **BROKEN**, "each row a point mass, so $U$ is a permutation" is false whenever $\mu$ or $\omega$ is degenerate |
| C6 | "Karamata is not needed" for the *inequality* | **PROVEN** |
| C7 | Heading: "the two spectra do not couple usefully through a shared frame" | **BROKEN**, it is not a consequence of the bound, and the bound is an exact identity on the whole diagonal family |
| C8 | Second display $\theta\le(t_F/2)^{3/2}\Theta_n+\tfrac92(M_++m)(1-t_F/2)$ | **HYPOTHESIS-DEBT**, its penalty half is exact algebra (verified here); its $\Theta_n$ half has no argument on file |
| C9 | "The coupling loses exactly when $t_F<\tfrac43$" | **BROKEN**, refuted by hand at $t_F=\tfrac32$ against the display's own constants |
| C10 | [results.md](../results.md):248's "Schur–Horn" | **GAP**, only Schur's half is used; the record says so at [bispectral.md](../findings/bispectral.md):65, outside the block |

**Overall verdict: BROKEN.** *The displayed inequality itself is correct and its hypotheses check out; what is broken is everything the record hangs on it (the equality clause as written, the heading, and the threshold) and the second display has no derivation on file.*

**One line.** L52's inequality is a correct theorem with a correct proof, but its "exact if and only if" clause is stated against a $K'$ the frame does not determine (and is *false* in the basis the block cites for it), its "Karamata is not needed" equality argument contains a false step at exactly the degenerate spectra this programme studies, and its heading is contradicted by the bound's own exactness on the diagonal family, all three reaching a consumer verbatim and uncorrected at [results.md](../results.md):721.

## 0. Conventions, fixed once

- $W\in\mathrm{Weyl}_n$, $n\ge4$. $M$ is $W$ acting on $\Lambda^2\mathbb R^n$, spectrum $\mu$, normalised $\lVert M\rVert_F=1$. $\mathring W$ is the curvature operator of the second kind on $S^2_0$ in Li's convention $(\mathring Wh)_{ij}=\sum_{k,l}W_{iklj}h_{kl}$, spectrum $\omega$. Both are real symmetric.
- $p_k(x)=\sum_i x_i^k$. The record's normalisation gives $\sum\mu=\sum\omega=0$, $p_2(\mu)=1$, $p_2(\omega)=3$, and $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$ ([Lemma L50](../results.md)).
- Sizes: $\mu$ and $K$ have $\binom n2$ entries; $\omega$ and $K'$ have $\dim S^2_0=\tfrac{(n+2)(n-1)}2$ entries. The count closes: $\binom n2+(n-1)=\tfrac{n^2+n-2}2=\tfrac{(n+2)(n-1)}2$.
- $x\prec y$ means $x$ is majorized by $y$. So for $f$ convex on an interval containing both, $\sum f(x)\le\sum f(y)$; for $g$ concave, $\sum g(x)\ge\sum g(y)$.
- $K=(W_{ijij})_{i<j}$, the sectional vector, i.e. the diagonal of $M$ in the basis $\{e_i\wedge e_j\}_{i<j}$ of $\Lambda^2$; equivalently the entries of the $n\times n$ sectional matrix $K^F$, which is hollow, symmetric and has zero row sums.
- $K'=(K,d)$ is "the full $\mathring W$ diagonal" in the basis $\{\varphi_{ij}\}_{i<j}\cup\{\psi_k\}_{k=1}^{n-1}$ of $S^2_0$, with $\varphi_{ij}=(e_i\odot e_j)/\sqrt2$ and $\{\psi_k\}$ *some* orthonormal basis of the trace-free diagonal matrices. **Which basis is left open by the block, and §3.1 shows the choice is load-bearing.**
- $t_F=\lVert K^F\rVert_F^2$, the frame's diagonal mass; $p_2(K)=\tfrac12 t_F$ and, in the [Lemma L54](../results.md) basis, $p_2(K')=\tfrac32 t_F$.
- $M_+$ is any real with $\mu_i\le M_+$ for all $i$; $m$ is any real with $\omega_i\ge-m$ for all $i$. Both are frame-independent, being bounds on spectra.
- $\Theta_n$ is the diagonal maximum of [Lemma L57](../results.md): $\Theta_n^2=2(n-1)(n-2)/n^2$ at even $n$, $2(n-1)(n-3)/((n+1)(n-2))$ at odd $n$.

## 1. Hypothesis inventory

### 1.1 Hypotheses the block carries

| Hypothesis | Stated in the block? | Checked against the object |
|---|---|---|
| $W\in\mathrm{Weyl}_n$ | implicitly, via $\theta$ and the L50 identity | ✓ |
| $\lVert M\rVert_F=1$, hence $p_2(\mu)=1$, $p_2(\omega)=3$ | **no**, the block writes the constants $1$ and $3$ into the display without saying where they come from; they are fixed at [bispectral.md](../findings/bispectral.md):17, seventy lines above | ✓ but unstated at [results.md](../results.md):721, where the display's "$1$" and "$-3$" are unexplained constants |
| a dimension range for $n$ | **no**, neither the block nor [results.md](../results.md):721 states one | no finding: every step below holds at every $n\ge4$ |
| an orthonormal frame $F$ of $\mathbb R^n$ | ✓, universally quantified ("in any orthonormal frame") | ✓ |
| a choice of $\{\psi_k\}$ inside the trace-free diagonal block | **no** (and it is not determined by $F$ | ✗), see §3.1 |
| $\mu_i\le M_+$ | ✓ | ✓; note $M_+>0$ is forced by $\sum\mu=0$, $p_2(\mu)=1$ |
| $\omega_i\ge-m$ | ✓ | ✓; note $m>0$ is forced by $\sum\omega=0$, $p_2(\omega)=3$ |

### 1.2 Hypotheses of every imported result

| Import | Its hypotheses | Object it is applied to | Verdict |
|---|---|---|---|
| **Schur's theorem** (diagonal $\prec$ spectrum) | Hermitian operator; the diagonal taken in a *complete* orthonormal basis | $M$ on $\Lambda^2$ in $\{e_i\wedge e_j\}$ ($\binom n2$ vectors, complete ✓); $\mathring W$ on $S^2_0$ in $\{\varphi_{ij}\}\cup\{\psi_k\}$ (complete by the count in §0 ✓) | **holds** |
| **Horn's converse** |, | not used | the block correctly says "Schur's theorem"; [results.md](../results.md):248 says "Schur–Horn" and overstates. The correction is on file at [bispectral.md](../findings/bispectral.md):65, *above* the block, not in it |
| **NPW Prop 3.10**, $\langle\mathring W\varphi_{ij},\varphi_{ij}\rangle=W_{ijij}$ | algebraic curvature tensor; the stated basis | read in [references/nienhaus-petersen-wink-2022-betti-second-kind/notes.md](../references/nienhaus-petersen-wink-2022-betti-second-kind/notes.md), which transcribes the proposition and records a correction to the printed $\psi_k$ coefficient | **holds**, source read |
| **Karamata / Hardy–Littlewood–Pólya**, inequality half | $x\prec y$, both in an interval $I$; $f$ convex on $I$ | $(K,\mu)$ with $g$ on $(-\infty,M_+]$; $(K',\omega)$ with $f$ on $[-m,\infty)$ | **holds** (§2.2 checks containment) |
| **Karamata / HLP, equality half** | as above, $f$ *strictly* convex | invoked for the $\Rightarrow$ direction | **holds mathematically, but rests on an unread source**: no file under [references/](../references/) carries HLP or Karamata. [lean/INDEX.md](../lean/INDEX.md):254 records the same debt, "majorization theory is not in Mathlib" |
| **Jensen** | $f$ convex on an interval containing the points; nonnegative weights summing to $1$ | rows of $(\lvert U_{ij}\rvert^2)$ against $\mu$ | **holds** |
| **Double stochasticity** of $(\lvert U_{ij}\rvert^2)$ for $U$ orthogonal | $U$ orthogonal/unitary | ✓ rows and columns are unit vectors | **holds**; formalised at [DoublyStochastic.lean](../lean/HamiltonsCubic/Results/DoublyStochastic.lean) |
| **Lemma L54**'s basis identification ($\varphi$-diagonal $=K$, $\psi$-block $=-K\vert_{\mathbf1^\perp}$) | the $\psi_k$ must be an eigenbasis of $K$ on $\mathbf1^\perp$ | **needed to make $K'$ well defined, and never cited by the block** | ✗, see §3.1 |
| **Lemma L94** ($t_F\le2$) |, | needed only by the second display | not cited there |
| **Lemma L57** ($\theta\le\Theta_n$ on the diagonal family) | unit $W$ diagonal in some frame | needed by the second display's first term | **not cited anywhere near it**, see §6 |

### 1.3 Which of these the written proof actually uses

The written proof of the **inequality** uses: Schur's theorem (twice), the two support bounds, and either Karamata's inequality half or the row-wise Jensen argument. It does **not** use Horn, L54, L94 or L57.

The written proof of the **equality clause** uses, in the block's own words, "strict convexity of $t^3+3mt^2$ and the equality case of Karamata", so the $\Rightarrow$ half is Karamata's. The alternative Jensen route is offered for the same half and fails (§4). Neither route is written for the $\Leftarrow$ half, which is where the statement is false as written (§3.1).

## 2. Question 1a, does the inequality follow? **PROVEN**

### 2.1 The derivation, in full

Fix a frame $F$ and a basis $\{\psi_k\}$. Schur's theorem gives $K\prec\mu$ and $K'\prec\omega$.

**The $\mu$ side.** Put $g(t)=t^3-3M_+t^2$. Then $g''(t)=6t-6M_+=6(t-M_+)\le0$ on $(-\infty,M_+]$, so $g$ is concave there. Concavity plus $K\prec\mu$ gives $\sum_i g(K_i)\ \ge\ \sum_i g(\mu_i)$, i.e.

$$p_3(K)-3M_+\,p_2(K)\ \ge\ p_3(\mu)-3M_+\,p_2(\mu)\ =\ p_3(\mu)-3M_+ ,$$

using $p_2(\mu)=1$. Rearranged, $p_3(\mu)\ \le\ p_3(K)+3M_+\big(1-p_2(K)\big)$.

**The $\omega$ side.** Put $f(t)=t^3+3mt^2$. Then $f''(t)=6t+6m=6(t+m)\ge0$ on $[-m,\infty)$, so $f$ is convex there. Convexity plus $K'\prec\omega$ gives $\sum_i f(K'_i)\ \le\ \sum_i f(\omega_i)$, i.e.

$$p_3(K')+3m\,p_2(K')\ \le\ p_3(\omega)+3m\,p_2(\omega)\ =\ p_3(\omega)+9m ,$$

using $p_2(\omega)=3$. Rearranged, $p_3(\omega)\ \ge\ p_3(K')+3m\big(p_2(K')-3\big)$.

**Combining.** $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$, and the coefficients $+\tfrac32$ and $-\tfrac12$ point the two estimates the same way, so

$$\theta\ \le\ \tfrac32\big[p_3(K)+3M_+(1-p_2(K))\big]-\tfrac12\big[p_3(K')+3m(p_2(K')-3)\big].$$

This is the display verbatim. **The inequality is correct.**

### 2.2 The ranges the convexity claims are asserted on, checked at both edges

The brief asks specifically about direction against range. Both check.

- $g$ is asserted concave on $(-\infty,M_+]$ and applied to $K$ and $\mu$. All $\mu_i\le M_+$ by hypothesis. All $K_i\le M_+$ *follows*: $K\prec\mu$ gives $\max_iK_i\le\max_i\mu_i\le M_+$. So both vectors lie in the interval where $g$ is concave. ✓
- $f$ is asserted convex on $[-m,\infty)$ and applied to $K'$ and $\omega$. All $\omega_i\ge-m$ by hypothesis; $K'\prec\omega$ gives $\min_iK'_i\ge\min_i\omega_i\ge-m$. ✓
- **The endpoints.** $f''$ vanishes at $t=-m$ and $g''$ at $t=M_+$, and both points are attainable (when $m=-\min\omega$ exactly). A function with $f''>0$ on the open interval is still *strictly* convex on the closed one, so the block's "$f''=6(t+m)$ vanishing only at the endpoint, so $f$ is strictly convex on $[-m,\infty)$" is right. The same argument makes $g$ *strictly concave* on $(-\infty,M_+]$, a fact the block never states, though its equality clause needs it (§3.2).

### 2.3 The penalty identity, checked by hand

Both penalties are nonnegative, so the display is a genuine upper bound rather than an identity in disguise:

- $M_+>0$ (forced, §1.1) and $1-p_2(K)=p_2(\mu)-p_2(K)=\lVert M_{\mathrm{off}}\rVert_F^2\ge0$, so $\tfrac32\cdot3M_+(1-p_2(K))=\tfrac92M_+\lVert M_{\mathrm{off}}\rVert_F^2\ge0$;
- $m>0$ and $3-p_2(K')=p_2(\omega)-p_2(K')=\lVert\mathring W_{\mathrm{off}}\rVert_F^2\ge0$, so $-\tfrac12\cdot3m(p_2(K')-3)=\tfrac32m\lVert\mathring W_{\mathrm{off}}\rVert_F^2\ge0$.

Summing reproduces [bispectral.md](../findings/bispectral.md):51 exactly, with $\theta_{\mathrm{diag}}=\tfrac32p_3(K)-\tfrac12p_3(K')$:

$$\text{bound}-\theta_{\mathrm{diag}}\ =\ \tfrac92M_+\lVert M_{\mathrm{off}}\rVert_F^2+\tfrac32m\,\lVert\mathring W_{\mathrm{off}}\rVert_F^2 .$$

**No finding:** the block's own warning that "the penalty terms are NOT the slack" is correct, and the arithmetic behind it closes.

## 3. Question 1b, is the equality case right?

### 3.1 The $\Leftarrow$ half is **BROKEN** as written, because $K'$ is not determined by the frame

**Locate it.** [findings/bispectral.md](../findings/bispectral.md):87 and [results.md](../results.md):721, identically: *"Writing $K$ for the sectional vector and $K'$ for the full $\mathring W$ diagonal, Schur's theorem gives $K\prec\mu$ and $K'\prec\omega$"*, opening with *"In any orthonormal frame"*, and :91 / :721: *"The bound is **exact if and only if both operators are diagonal in one shared frame**."*

The definite article in "the full $\mathring W$ diagonal" asserts that an orthonormal frame $F$ of $\mathbb R^n$ fixes $K'$. **It does not.** $F$ fixes the $\binom n2$ entries $\varphi_{ij}$ of the basis, but the remaining $n-1$ dimensions of $S^2_0$ (the trace-free diagonal matrices), carry a whole $O(n-1)$ of orthonormal bases, and the diagonal of $\mathring W$ there depends on which is taken. The only basis the block cites is NPW Prop 3.10's, whose $\psi_k$ are the fixed staircase tensors, transcribed at [notes.md](../references/nienhaus-petersen-wink-2022-betti-second-kind/notes.md) and depending on $n$ and the frame alone.

**Exhibit the failure concretely.** Take the perfect-matching extremiser the record itself certifies at [bispectral.md](../findings/bispectral.md):378, $K_{ab}=(n-2)c$ on a fixed-point-free involution, $-c$ elsewhere, $n$ even, "a genuine coordinate-diagonal Weyl tensor", $t=2$. So $W$ *is* diagonal in a shared frame, and the $\Leftarrow$ half asserts the bound is exact there. Read $K'$ in NPW's basis:

1. The compression of $\mathring W$ to the trace-free diagonal subspace is $-K^F\vert_{\mathbf1^\perp}$ ([bispectral.md](../findings/bispectral.md):256), and that is a statement about the *subspace*, so it holds for any orthonormal basis of it.
2. NPW's first vector is $\psi_1\propto -(n-1)\,e^1\!\otimes\!e^1+\sum_{l\ge2}e^l\!\otimes\!e^l$, i.e. the vector $v_1=-n\,e_1+\mathbf 1$ of $\mathbf1^\perp$. Since $K^F\mathbf1=0$, $K^Fv_1=-n\,K^Fe_1$. If $v_1$ were an eigenvector with eigenvalue $\lambda$, then comparing first coordinates gives $-n\,K^F_{11}=\lambda\cdot(-(n-1))$; hollowness makes the left side $0$, so $\lambda=0$ and hence $K^Fe_1=0$, the first row of $K^F$ vanishes.
3. The matching extremiser's first row is $((n-2)c$ once, $-c$ elsewhere$)$, which is nonzero for $c\ne0$. So $\psi_1$ is not an eigenvector, $\mathring W$ is **not** diagonal in NPW's basis, and $p_2(K')<p_2(\omega)$ strictly.
4. Strict convexity of $f$ on $[-m,\infty)$ with $K'\prec\omega$ and $K'^\downarrow\ne\omega^\downarrow$ then makes $\sum f(K')<\sum f(\omega)$ strictly, so the second penalty is strictly positive and **the bound is strictly greater than $\theta$ at a $W$ that is diagonal in a shared frame.**

**Argue the opposite.** The most charitable reading the words support is that $K'$ means the [Lemma L54](../results.md) diagonal, $\psi_k$ an eigenbasis of $K$ on $\mathbf1^\perp$, so $d=-\{\text{eigenvalues of }K\vert_{\mathbf1^\perp}\}$, under which the $\Leftarrow$ half is true and $p_2(K')=\tfrac32t_F$. That reading is certainly what the record's own numbers use: [bispectral.md](../findings/bispectral.md):65 says "the $\psi$ block carries a further $O(n-1)$ of freedom … which is why the script diagonalises it", and [L54](../results.md) says NPW's own staircase "will not serve". **But the charitable reading is unavailable to a consumer.** It requires L54, which the L52 block never cites; and at [results.md](../results.md):721 (where the consumer reads), there is no L54, no $\psi$, and no hint that a second choice exists. The one correction on file, [bispectral.md](../findings/bispectral.md):65, sits four lines *above* the L52 heading at :69, inside the preceding block. **This is the record's named trap, live: the correction landed beside the statement it corrects.**

**What would falsify this finding.** A sentence, inside the L52 block or at [results.md](../results.md):721, fixing the $\psi$-basis. I searched both files for "$\psi$" and for a pointer from L52 to L54 in either direction; the L52 block carries neither, and L54's own entry points at L52 rather than the reverse.

### 3.2 The $\Rightarrow$ half, Karamata route, **PROVEN**, on an unread source

Suppose the bound is exact. The gap decomposes as

$$\text{bound}-\theta\ =\ \tfrac32\big(A-p_3(\mu)\big)+\tfrac12\big(p_3(\omega)-B\big),$$

with $A=p_3(K)+3M_+(1-p_2(K))$ and $B=p_3(K')+3m(p_2(K')-3)$. §2.1 shows both brackets are $\ge0$, so exactness forces both to vanish separately.

- $p_3(\omega)=B$ is $\sum f(K')=\sum f(\omega)$ with $f$ strictly convex on an interval containing both and $K'\prec\omega$. HLP's equality case gives $K'^\downarrow=\omega^\downarrow$. A Hermitian operator whose diagonal in an orthonormal basis has the same multiset as its spectrum is diagonal in that basis, since then $\sum_i a_{ii}^2=\sum_i\lambda_i^2=\lVert A\rVert_F^2=\sum_{i,j}\lvert a_{ij}\rvert^2$. So $\mathring W$ is diagonal in $\{\varphi_{ij}\}\cup\{\psi_k\}$.
- $A=p_3(\mu)$ is $\sum g(K)=\sum g(\mu)$ with $g$ *strictly concave* and $K\prec\mu$, giving $K^\downarrow=\mu^\downarrow$ and so $M$ diagonal in $\{e_i\wedge e_j\}$.

**Finding, minor but real.** The block argues only the first bullet, "*by strict convexity of $t^3+3mt^2$*", and at :60 "*Hardy–Littlewood–Pólya equality forces $K'=\omega$*". The $\mu$ side needs the strict *concavity* of $t^3-3M_+t^2$, which the block never asserts even in the non-strict form it uses for the inequality, where it says only "concave". It is true ($g''=6(t-M_+)<0$ on $(-\infty,M_+)$) but it is not written, and $K'^\downarrow=\omega^\downarrow$ does not imply $K^\downarrow=\mu^\downarrow$ merely because $K$ sits inside $K'$: majorization of a sub-block by a sub-spectrum is not inherited. **What would have to be shown: strict concavity of $t^3-3M_+t^2$ on $(-\infty,M_+]$ and the concave equality case of HLP.** One line each, and neither is on file.

**Source.** Karamata's equality case, and HLP more generally, appear in no file under [references/](../references/), I listed the directory. [lean/INDEX.md](../lean/INDEX.md):254 records the same gap from the other side: *"Karamata and its equality case stay owed: majorization theory is not in Mathlib, and this is the boundary of what the layer reaches."* **So C4 rests on an unread source.**

### 3.3 The $\Rightarrow$ half, Jensen route, **BROKEN**

**Locate it.** [findings/bispectral.md](../findings/bispectral.md):91, and repeated verbatim at [lean/INDEX.md](../lean/INDEX.md):255: *"The equality case follows directly: tightness in every row makes each row a point mass under strict convexity, so $U$ is a permutation, which is the shared frame."*

**Exhibit the failure concretely.** Jensen's equality case for a strictly convex $f$ and a probability vector $p$ says the *random variable is a.s. constant* (that $\mu_j$ takes one value on $\mathop{\mathrm{supp}}(p)$), not that $p$ is a point mass. The two coincide only when the $\mu_j$ are distinct. Concretely: let $\mathring W$ be diagonal in an orthonormal basis $B=\{b_1,b_2,\dots\}$ with $b_1,b_2$ carrying the same diagonal entry $\lambda$. Its eigenbasis is not unique; take $\tilde B$ equal to $B$ rotated by $45^\circ$ in $\mathop{\mathrm{span}}(b_1,b_2)$, which is still an eigenbasis. The matrix $U$ relating $B$ to $\tilde B$ then has $(\lvert U_{ij}\rvert^2)$ equal to $\begin{pmatrix}1/2&1/2\\1/2&1/2\end{pmatrix}$ in that block and the identity elsewhere. It is doubly stochastic, every row is tight in Jensen (the bound *is* exact, $\mathring W$ is diagonal in $B$), and **it is not a permutation matrix.**

This is not an exotic configuration on this record's objects. Degeneracy is the rule:

- [Lemma L67](../results.md) gives, at $S^m\times S^m$ with $n=2m$ (the record's conjectured maximiser), a second-kind spectrum with exactly *three* distinct values, of multiplicities $(m-1)(m+2)$, $m^2$ and $1$, filling all $\tfrac{(n+2)(n-1)}2$ slots. At $n=12$ that is $28$, $36$ and $1$.
- On the $\Lambda^2$ side the same tensor's $\mu$ repeats wherever two sectional curvatures agree, which for a block-constant $K$ is everywhere.

So at the very point the programme is aimed at, "$U$ is a permutation" is false for every eigenbasis choice outside a measure-zero set of them, while the bound is exact.

**Argue the opposite.** The charitable reading is that "point mass" is meant modulo the eigenvalue, i.e. mass concentrated where $\mu$ is constant. But the sentence's conclusion ("so $U$ is a permutation"), is not modular: $(\lvert U_{ij}\rvert^2)$ a permutation matrix means every entry is $0$ or $1$, which the $45^\circ$ rotation refutes. A second charitable reading is that the conclusion is harmless because "which is the shared frame" is what is wanted, and *that* does survive by the norm identity of §3.2. **It survives, but by the Karamata/HLP equality case, or by an argument nobody has written.** So the answer to the brief's *"say which route the equality case actually needs"* is: **the equality case needs Karamata (or the Frobenius-norm identity); the row-wise Jensen route delivers the inequality and not the equality case.** The block's "**Karamata is not needed**" is true of the bound and false of the clause it is attached to.

**What would falsify this finding.** A doubly stochastic $(\lvert U_{ij}\rvert^2)$ that is forced to be a permutation by row-tightness alone, i.e. a proof that no eigenvalue of $\mathring W$ or $M$ can repeat. Nothing on file claims that, and [Lemma L67](../results.md) states the opposite at the conjectured maximiser.

**What Lean actually proves.** I read the theorem headers of [DoublyStochastic.lean](../lean/HamiltonsCubic/Results/DoublyStochastic.lean): `row_jensen`, `sum_collapses`, `diagonal_le_spectrum`, `equality_forces_rowwise`, `permutation_gives_equality`. **The false step is precisely the one that is not there**, there is no theorem taking row-tightness to a permutation. The file stops at `equality_forces_rowwise` and then proves the easy converse. [lean/INDEX.md](../lean/INDEX.md):255 nevertheless writes the full chain in prose and calls the equality case closed: *"The equality case is the shared frame directly … so $U$ is a permutation … ; a permutation frame gives equality, shown here."* The "shown here" attaches only to the converse. **The index row overstates its own file.**

## 4. Question 1c, "Karamata is not needed", for the inequality, **PROVEN**

The route is: $K_i=\sum_j\lvert U_{ij}\rvert^2\mu_j$ with $U$ orthogonal, so $P=(\lvert U_{ij}\rvert^2)$ is doubly stochastic; Jensen per row gives $f(K_i)\le\sum_jP_{ij}f(\mu_j)$ for $f$ convex on an interval containing every $\mu_j$; summing over $i$ and using the *column* sums $\sum_iP_{ij}=1$ gives $\sum_if(K_i)\le\sum_jf(\mu_j)$.

Every step checks. The rows of $P$ are probability vectors, so each $K_i$ is a convex combination and lies in the same interval, which is what makes the row-wise Jensen legitimate; no sorting and no Abel summation enter, exactly as claimed. **This is the classical proof of the doubly-stochastic form of HLP, and it does replace Karamata for the inequality.** It is what [DoublyStochastic.lean](../lean/HamiltonsCubic/Results/DoublyStochastic.lean) formalises.

**One scope note the record contradicts itself on.** [bispectral.md](../findings/bispectral.md):65 uses Karamata to justify that diagonalising the $\psi$-block is *provably optimal*, correct, since among $\psi$-choices the diagonal of the compression $-K\vert_{\mathbf1^\perp}$ is majorized by its eigenvalues and $f$ is convex, so the eigenbasis maximises $\sum f(K')$ and hence minimises the bound. So Karamata is not needed for the bound but *is* used elsewhere in the same file to certify the figures the block reports. **No finding against the mathematics; a finding against "Karamata is not needed" read as a global claim.**

## 5. Question 2, does the headline follow from the bound? **No. BROKEN.**

**The headline, as a consumer reads it.** [results.md](../results.md):721: *"##### Lemma L52, the two spectra do not couple usefully through a shared frame"*, followed by the statement and *"**Proof:** [bispectral.md](../findings/bispectral.md)"*. [results.md](../results.md):248: *"**Lemma L52 (second-order). The two spectra do not couple usefully through a shared frame.** … The bound is an identity on the diagonal family and, off it, loses to a one-line estimate and to the moment relaxation it was built to improve."*

**What the bound establishes.** A valid inequality, holding in every frame, which is an **exact identity on the entire coordinate-diagonal family**, the block's own "What it costs" paragraph says so, and [Lemma L54](../results.md) says the same from the other side. An inequality that is an identity on a whole family is a coupling that is *sharp* there, which is the opposite of "do not couple". **The bound establishes the negation of its own heading on that family, and something strictly weaker than the heading everywhere else.** What the block actually shows off the diagonal family is an *appraisal* (that the resulting number is beaten by other bounds at the points examined) and an appraisal is not a consequence of the bound.

**The three things on the same page that bear on it.**

1. **The block's own audit banner** ([bispectral.md](../findings/bispectral.md):73) declares the heading refuted, on the ground that the boxed cap $\mu_1(K^F)\le\sqrt{2(n-2)/(n-1)}$ is a shared-frame coupling that the file says proves the projection estimate [target.md](../findings/target.md) leans on. **I check that ground and find it loose.** The cap is about the spectrum of the $n\times n$ sectional matrix $K^F$ (neither $\mu$ nor $\omega$ enters it) so it does not refute a claim about "the two spectra". The cap itself is correct: $K^F$ is symmetric with $K^F\mathbf1=0$ and $\mathop{\mathrm{tr}}K^F=0$, so its $n-1$ eigenvalues on $\mathbf1^\perp$ sum to $0$ with squares summing to $t_F$, whence $\mu_1\le\sqrt{t_F(n-2)/(n-1)}$, and $t_F\le2$ gives the boxed form. The identity the Lean row asserts also checks exactly: $n\theta_0(n)/(n-1)=\sqrt{2(n-1)(n-2)}/(n-1)=\sqrt{2(n-2)/(n-1)}$. **So the banner's conclusion is right and its stated reason is not the one that carries it; the reason that carries it is the identity on the diagonal family.**
2. **The operative clause "off it, loses to a one-line estimate"** at [results.md](../results.md):248 is contradicted at [bispectral.md](../findings/bispectral.md):75, which calls it false on a neighbourhood. The one-line bound is $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)\le\tfrac32M_+p_2(\mu)+\tfrac12m\,p_2(\omega)=\tfrac32M_++\tfrac32m=\tfrac32(M_++m)$, using $\mu_i^3\le M_+\mu_i^2$ and $-\omega_i^3\le m\omega_i^2$ termwise, correct, and I verify the record's strictness argument too: equality needs $\mu_i\in\{0,M_+\}$ for every $i$, whence $\mu_i^2=M_+\mu_i$ termwise and $1=p_2(\mu)=M_+\sum\mu=0$, a contradiction. **So the one-line bound is never attained, while L52's is attained on a whole family, and [results.md](../results.md):248 states the reverse ranking as unconditional.**
3. **The "not independent" banner** ([bispectral.md](../findings/bispectral.md):81) observes that [post F26](../findings/INDEX-traps.md) already rules out any bound exact at $t=2$ and monotone below it. That is a reason the coupling cannot *close* Conjecture A. It is not a reason the spectra "do not couple".

**Verdict.** The bound establishes a coupling; the heading denies one. **The heading does not follow from the bound, it is contradicted by it on the diagonal family, and it reaches a consumer verbatim and uncorrected at both [results.md](../results.md):248 and :721.** The correction exists only inside [findings/bispectral.md](../findings/bispectral.md), in banners above the block.

**What would falsify this finding.** A demonstration that the diagonal family on which the bound is an identity is empty or a single point. [bispectral.md](../findings/bispectral.md):378 exhibits a genuine coordinate-diagonal Weyl tensor at every even $n$, [bispectral.md](../findings/bispectral.md):60 records the identity on "generic hollow $\Lambda$", and [lean/INDEX.md](../lean/INDEX.md):120 records the locus's dimension $n(n-2)$ as positive; so the family is not a point.

## 6. Question 3, is the second display derived or screened? **Screened. HYPOTHESIS-DEBT.**

**Locate it.** [findings/bispectral.md](../findings/bispectral.md):77–79, inside the "THE POSITIVE READING THE RECORD DOES NOT CARRY" banner: $\theta\le(t_F/2)^{3/2}\,\Theta_n+\tfrac92(M_++m)(1-t_F/2)$, *"screened against this record's own six digits, $\tfrac92(1.632993)(0.5)=3.674235$, the block's penalty sum exactly."*

**Where its derivation is.** I searched [findings/bispectral.md](../findings/bispectral.md) and [results.md](../results.md) for the display and for $\Theta_n$ next to $t_F$. **There is none.** The display appears once, in a banner, with the one sentence of support quoted above. [lean/INDEX.md](../lean/INDEX.md):120 says only that "the positive reading's penalty reproduces" and that "the penalty vanishes at $t_F=2$ and is strictly decreasing below it", the penalty again, never the $\Theta_n$ term.

**The penalty half is exact algebra, and I verify it by hand.** In the [Lemma L54](../results.md) basis, $p_2(K)=\tfrac12t_F$ and $p_2(K')=\tfrac32t_F$, so $\lVert M_{\mathrm{off}}\rVert_F^2=1-\tfrac12t_F$ and $\lVert\mathring W_{\mathrm{off}}\rVert_F^2=3-\tfrac32t_F=3(1-\tfrac12t_F)$. Substituting into §2.3's penalty sum:

$$\tfrac92M_+\big(1-\tfrac{t_F}2\big)+\tfrac32m\cdot3\big(1-\tfrac{t_F}2\big)\ =\ \tfrac92(M_++m)\big(1-\tfrac{t_F}2\big),$$

because $\tfrac32\cdot3=\tfrac92$. **This is an identity, not a coincidence**, and it is exactly what the six-digit "screen" reports. At the record's padded $W_{\mathbb{CP}^2}$ the off-diagonal masses are $\tfrac12$ and $\tfrac32$, i.e. $t_F=1$, and the first display's penalty sum is $\tfrac94(M_++m)$ while the second display's is $\tfrac92(M_++m)\cdot\tfrac12=\tfrac94(M_++m)$, **the same expression, evaluated at one point.** With the record's $M_++m=1.632993$, exactly $\tfrac94\cdot\tfrac{2\sqrt6}3=\tfrac{3\sqrt6}2=3.674234\ldots$, the quoted $3.674235$. **So the screen tests nothing beyond $\tfrac32\cdot3=\tfrac92$, and calling six-digit agreement its support understates what is actually available: the penalty half is provable in one line and the record leaves it screened.**

**The $\Theta_n$ half has no argument on file.** For the display to hold, the remaining piece must satisfy $\theta_{\mathrm{diag}}=\tfrac32p_3(K)-\tfrac12p_3(K')\le(t_F/2)^{3/2}\Theta_n$. That would need three statements, none of which is written in or near the display:

1. that $\theta_{\mathrm{diag}}$ is the $\theta$-functional of an *actual* coordinate-diagonal Weyl tensor $W_K$ whose sectional matrix is $K^F$, which needs [Lemma L54](../results.md)'s identification of $K'$ with $W_K$'s full second-kind diagonal *and* its spectrum, and the $\psi$-eigenbasis choice of §3.1;
2. that every hollow symmetric zero-row-sum $K^F$ is realised by such a $W_K$, the record asserts the identification at [results.md](../results.md):270 for the diagonal family but never in this direction here;
3. that [Lemma L57](../results.md)'s $\theta\le\Theta_n$ applies at the right normalisation, $\lVert M_{W_K}\rVert_F^2=\tfrac12\lVert K^F\rVert_F^2=t_F/2$, with cubic homogeneity supplying the $(t_F/2)^{3/2}$.

Point 3 is at least consistent: at $t_F=2$ the display returns $\Theta_n$ with zero penalty, matching [bispectral.md](../findings/bispectral.md):305's independent statement that at $t=2$ the relaxation *is* $\theta$ at a coordinate-diagonal $W$. **That is a consistency check at one endpoint, not a derivation.**

**Verdict on C8: HYPOTHESIS-DEBT.** *What would have to be shown:* items 1–3 above, in the display's own vicinity, with L54, L94 and L57 cited by name. Until then the display supports the banner's strongest sentence, *"L52 is a reduction of Conjecture A to a lower bound on the frame-optimised diagonal mass $t_F$"*, on an inequality whose dominant term is unargued. **A consumer must not cite that reduction.**

**What would falsify the display itself.** A frame $F$ at which $\theta_{\mathrm{diag}}>(t_F/2)^{3/2}\Theta_n$, i.e. a hollow symmetric zero-row-sum $K^F$ that is not the sectional matrix of any Weyl tensor and beats $\Theta_n$ after rescaling. I looked for a realisability statement in [results.md](../results.md):270, [bispectral.md](../findings/bispectral.md) and [lean/INDEX.md](../lean/INDEX.md) and found the identification asserted only for the family, never as a surjection from hollow zero-row-sum matrices.

## 7. The $t_F<\tfrac43$ threshold, **BROKEN**

**Locate it.** [findings/bispectral.md](../findings/bispectral.md):75: *"**The true statement is quantitative: the coupling loses exactly when $t_F<\tfrac43$.**"*

**Exhibit the failure concretely.** Write $s=t_F/2\in[0,1]$. The second display gives $B(s)=s^{3/2}\Theta_n+\tfrac92(M_++m)(1-s)$; the one-line bound is $\tfrac32(M_++m)$. The coupling loses when $B(s)>\tfrac32(M_++m)$, i.e. when $s^{3/2}\Theta_n>(M_++m)\big(\tfrac92s-3\big)$. The value $s=\tfrac23$ (that is $t_F=\tfrac43$), is exactly where the *right-hand side vanishes*, so it is where the **penalty alone** first exceeds the whole one-line bound. It is a sufficient condition for losing, not the threshold.

Take the constants the record itself uses at padded $W_{\mathbb{CP}^2}$, $n=12$: $M_++m=1.632993$ and $\Theta_{12}=\theta_0(12)=\sqrt{220}/12=1.236033\ldots$. At $s=\tfrac34$, i.e. $t_F=\tfrac32>\tfrac43$:

- left: $s^{3/2}\Theta_n=\left(\tfrac34\right)^{3/2}(1.236033)=(0.6495191)(1.236033)=0.802829$;
- right: $(M_++m)\big(\tfrac92\cdot\tfrac34-3\big)=1.632993\cdot0.375=0.612372$.

Left exceeds right, so $B(\tfrac34)=0.802829+\tfrac92(1.632993)(0.25)=0.802829+1.837117=2.639946$ against the one-line $\tfrac32(1.632993)=2.449490$. **The coupling loses at $t_F=\tfrac32$, which is above $\tfrac43$.** So "exactly when $t_F<\tfrac43$" is false; the true crossing solves $s^{3/2}\Theta_n=(M_++m)(\tfrac92s-3)$ and depends on $M_++m$ and $\Theta_n$, so it is not a universal constant at all.

**Argue the opposite.** The charitable reading is that $\tfrac43$ is the threshold for the *penalty term alone* to exceed the one-line bound, a statement that is true and that the words "the coupling loses" could be stretched to cover, since above it the comparison is no longer decided by the penalty. Under that reading the sentence should read "loses **whenever** $t_F<\tfrac43$", and the word carrying the defect is "exactly". **The sentence as written asserts an equivalence; the equivalence is false.**

**What would falsify this finding.** Constants for which the crossing really is at $s=\tfrac23$, that is, $\Theta_n=0$, which holds at no $n\ge4$ since $\Theta_n^2>0$ at both parities.

## 8. Quantifier order and scope

**The bound's quantifier is sound.** "In any orthonormal frame" is a universal, so the display holds for every $F$ and therefore $\theta\le\inf_FB(F)$. $M_+$ and $m$ are bounds on $\mu$ and $\omega$, which are frame-independent, so no frame-dependent quantity was smuggled into a constant. **No $\sup$ or $\inf$ over frames is distributed across the two brackets:** both are evaluated at the same $F$, and the brief's specific worry (a quantifier distributed across terms sharing a variable), does not occur in the display.

**The equality clause's quantifier is not sound.** "Exact if and only if both operators are diagonal in one shared frame" is written under the universal "in any orthonormal frame", and the two readings differ:

| Reading | Statement | Status |
|---|---|---|
| per-frame | for a fixed $F$, $B(F)=\theta$ iff $W$ is coordinate-diagonal in $F$ | true, *given* the [L54](../results.md) $\psi$-choice; false in NPW's basis (§3.1) |
| over frames | $\inf_FB(F)=\theta$ iff $W$ is coordinate-diagonal in *some* frame | true, and this is what "one shared frame" reads as |

The words support the second reading while the proof establishes the first, and the two are joined only by the observation that the infimum is attained where the identity holds. **The block never states which it means, and neither does [results.md](../results.md):721.**

**One further scope point the block hides.** The *reported figures* are $\inf$-like in a second variable as well: the bound is minimised over the $\psi$-basis (correctly, §4), so the numbers the block quotes are not the value of the display at the basis it cites. [bispectral.md](../findings/bispectral.md):63 makes the analogous point for the frame ("the off-diagonal masses at padded $W_{\mathbb{CP}^2}$ describe a FRAME, not the point") and again that correction sits above the block, not in it.

## 9. The edge of every range

| Edge | Finding |
|---|---|
| $\ker W\ne0$ | **No finding.** Nothing in the proof needs $M$ or $\mathring W$ invertible: Schur's theorem, Jensen, and HLP are indifferent to a kernel. $\mu$ and $\omega$ both contain zeros for many $W$ and every step survives. The only exclusion the normalisation makes is $W=0$, which $\lVert M\rVert_F=1$ rules out. |
| smallest admissible $n$ | **The block states no dimension range at all**, at either [bispectral.md](../findings/bispectral.md):87 or [results.md](../results.md):721. The natural floor is $n\ge4$, where $\mathrm{Weyl}_n$ is first nonzero; the basis count closes there ($\binom42=6$, $\psi$: $3$, $\dim S^2_0=9$). Every step above holds at $n=4$. The $n\le5$ Lovelock collapse ([bispectral.md](../findings/bispectral.md)) makes the bound redundant rather than false there. **Finding: an unstated hypothesis, harmless in content but owed in the statement.** |
| $t=-m$, the convexity endpoint | Attained when $m=-\min\omega$ exactly. $f''$ vanishes only there, so $f$ is still strictly convex on the closed interval; the block's phrasing is correct. ✓ |
| $t=M_+$, the concavity endpoint | Same, for $g$, but the block never claims *strict* concavity, which its equality case needs (§3.2). |
| $M_+\le0$ or $m\le0$ | Excluded automatically: $\sum\mu=0$ with $p_2(\mu)=1$ forces $\max\mu>0$, and $\sum\omega=0$ with $p_2(\omega)=3$ forces $\min\omega<0$. So both penalties have the sign §2.3 claims. ✓ |
| $t_F=0$ | Reachable, [bispectral.md](../findings/bispectral.md):224 records $\min_F\lVert K(F)\rVert_F=0$ for every tensor tested. The second display then returns $\tfrac92(M_++m)$, three times the one-line bound, consistent with §7. |
| $t_F=2$ | The upper edge, by [Lemma L94](../findings/bispectral.md). Both displays are exact there, subject to §3.1's basis caveat, under which the first display is *not* exact there in NPW's basis. |
| a degenerate $\mu$ or $\omega$ | **The edge that breaks §3.3.** Not an edge case at all on this record's objects: [Lemma L67](../results.md) gives three distinct eigenvalues filling $\tfrac{(n+2)(n-1)}2$ slots at the conjectured maximiser. |

## 10. Comparing the forms

| Location | What it says | Divergence |
|---|---|---|
| [findings/bispectral.md](../findings/bispectral.md):87–91 (the L52 block) | statement, display, equality clause, the Jensen paragraph, "What it costs" | the fullest form; still carries the false Jensen step (§3.3) and the undetermined $K'$ (§3.1) |
| [findings/bispectral.md](../findings/bispectral.md):71–81 (the banners above it) | headline refuted; operative clause false on a neighbourhood; the second display; "its negative is not independent" | **the corrections live only here, and only in this file** |
| [findings/bispectral.md](../findings/bispectral.md):39–67 (the earlier derivation) | the same display derived in context, plus the penalty-identity correction and Reviewer 290's two scope corrections | contains the $\psi$-freedom correction (:65) that the L52 block needs and does not carry |
| [results.md](../results.md):721 | heading, statement, display, equality clause, "**Proof:** bispectral.md" | **drops the Jensen route, "What it costs", and every banner.** A consumer reads the refuted heading and an equality clause whose $K'$ is undefined, with the Karamata import unflagged |
| [results.md](../results.md):248 | the one-line landscape entry | **adds two defects**: "Schur–Horn" where only Schur is used, and "off it, loses to a one-line estimate and to the moment relaxation" stated unconditionally, which [bispectral.md](../findings/bispectral.md):75 calls false on a neighbourhood |
| [lean/INDEX.md](../lean/INDEX.md):120 (the L52 row) | formalises three of the *audit's* counts, the cap identity, the strict-looseness of the one-line bound, the locus dimension | **does not formalise the bound or its equality case**, and says so; the row is honest about that |
| [lean/INDEX.md](../lean/INDEX.md):254 (CubicConvexity) | the strict convexity, elementarily, gap $=ab(x-y)^2(x+y+u+3m)$ | correct in content, and honest that "Karamata and its equality case stay owed" |
| [lean/INDEX.md](../lean/INDEX.md):255 (DoublyStochastic) | Jensen route, and the equality case "directly" | **overstates its own file**: the row asserts row-tightness $\Rightarrow$ point mass $\Rightarrow$ permutation, which is false (§3.3) and which [DoublyStochastic.lean](../lean/HamiltonsCubic/Results/DoublyStochastic.lean) does not contain, the file stops at `equality_forces_rowwise` and then proves only the converse, `permutation_gives_equality` |

**Is there a Lean form of the bound itself?** No. The row that would carry it would have to claim: *for real symmetric $M$ on $\Lambda^2$ and $\mathring W$ on $S^2_0$ sharing the sectional diagonal, with $\mu_i\le M_+$ and $\omega_i\ge-m$, the displayed inequality holds; and it is an equality iff both are diagonal in the induced bases, the $\psi$-block being read in an eigenbasis of $K\vert_{\mathbf1^\perp}$.* That is not what [lean/INDEX.md](../lean/INDEX.md):120 claims (it claims three audit counts) and the "Owed, narrowed" clause there should not read "**Karamata is no longer needed at all**", since §3.3 shows the substitute closes the inequality and not the equality case.

## 11. The gap between what is proven and what is used, what a consumer may cite

**Proven, and citable as written:**

- The displayed inequality, in any orthonormal frame of $\mathbb R^n$ and any orthonormal basis of the trace-free diagonal block, for any $M_+\ge\max\mu$ and $m\ge-\min\omega$. (§2)
- The row-wise Jensen derivation of it, without Karamata. (§4)
- The $\Leftarrow$ half of the equality clause **provided** the $\psi$-block is read in an eigenbasis of $K\vert_{\mathbf1^\perp}$, i.e. [Lemma L54](../results.md)'s basis. (§3.1)
- The $\Rightarrow$ half of the equality clause, **on Karamata's equality case, an unread source**, and with the strict concavity of $t^3-3M_+t^2$ supplied. (§3.2)
- The penalty collapse $\tfrac92M_+(1-\tfrac{t_F}2)+\tfrac32m\cdot3(1-\tfrac{t_F}2)=\tfrac92(M_++m)(1-\tfrac{t_F}2)$, which is one line of algebra and which the record leaves screened. (§6)

**Not citable:**

- The heading "the two spectra do not couple usefully through a shared frame", at either [results.md](../results.md):248 or :721. (§5)
- The equality clause as it stands at [results.md](../results.md):721, where $K'$ is undefined and the NPW basis it inherits from the proof file makes the $\Leftarrow$ half false. (§3.1)
- "Karamata is not needed" attached to the equality case, and the corresponding sentence at [lean/INDEX.md](../lean/INDEX.md):255. (§3.3)
- The second display, and the "reduction of Conjecture A to a lower bound on $t_F$" drawn from it. (§6)
- "The coupling loses exactly when $t_F<\tfrac43$." (§7)
- "Schur–Horn" at [results.md](../results.md):248, only Schur's half is used. (§1.2)

**The gap in one sentence.** What is proven is a frame-wise inequality that is sharp on the diagonal family; what is used is a headline denying that the coupling exists, an equality clause whose object is undefined, and a reduction resting on an unargued $\Theta_n$ term.

## 12. The named trap, each citable claim read alone

The brief warns that this record's signature failure is a correction landing *beside* the statement it corrects. I read each claim as a consumer arriving at it cold, with no other line in view.

| Claim, read alone | Where its correction lives | Distance |
|---|---|---|
| [results.md](../results.md):721's heading | [bispectral.md](../findings/bispectral.md):73, a banner in a different file | **the consumer never sees it**, [results.md](../results.md):721 points to [bispectral.md](../findings/bispectral.md) for the *proof*, and the banner is not part of the proof |
| [results.md](../results.md):248's "loses to a one-line estimate" | [bispectral.md](../findings/bispectral.md):75 | same |
| [results.md](../results.md):248's "Schur–Horn" | [bispectral.md](../findings/bispectral.md):65 | same |
| "$K'$ the full $\mathring W$ diagonal" | [bispectral.md](../findings/bispectral.md):65 and [Lemma L54](../results.md) | :65 is **four lines above** the L52 heading at :69, in the preceding block; L54 is a different numbered result that L52 never cites |
| "so $U$ is a permutation" | nowhere (the defect is not recorded anywhere in the record |), |
| the second display's $\Theta_n$ term | nowhere |, |

**Three of the six defects have their correction one screen away in the same file and reach [results.md](../results.md) uncorrected; two have no correction anywhere.** The trap is live on this lemma in both of its forms.

## 13. Verdict

**BROKEN.**

- **C1, C2, C6, PROVEN.** The inequality, the convexity directions against their ranges, and the Karamata-free derivation of the bound are correct, and I reproduced each in full above.
- **C3, BROKEN.** The $\Leftarrow$ half of "exact if and only if" is false in the only basis the block cites, at the record's own perfect-matching extremiser.
- **C5, C7, C9, BROKEN.** The Jensen equality argument fails at degenerate spectra, which is where the programme's objects live; the heading is contradicted by the bound's exactness on the diagonal family; the $\tfrac43$ threshold is refuted by hand at $t_F=\tfrac32$.
- **C4, PROVEN on an unread source.** Karamata's equality case is in no file under [references/](../references/), and the record's own Lean layer records the same debt.
- **C8, HYPOTHESIS-DEBT.** *What would have to be shown:* that $\theta_{\mathrm{diag}}$ is the $\theta$ of a genuine coordinate-diagonal Weyl tensor with sectional matrix $K^F$, that every hollow symmetric zero-row-sum matrix is realised as one, and that [Lemma L57](../results.md) applies at the normalisation $\lVert M\rVert_F^2=t_F/2$, after which $(t_F/2)^{3/2}\Theta_n$ follows by cubic homogeneity.
- **C10, GAP.** Only Schur's half is used; [results.md](../results.md):248 claims Schur–Horn.

**The single object that would falsify the surviving positive claim.** The displayed inequality would fail at a $W$, a frame $F$ and a $\psi$-basis for which either $\max_iK_i>M_+$ or $\min_iK'_i<-m$, that is, a diagonal entry outside the spectral support. No such object exists: majorization forces $\max K\le\max\mu$ and $\min K'\ge\min\omega$, which is precisely §2.2's containment check, and that check is what makes the convexity claims legitimate on the ranges asserted. **I looked for the object by checking the containment at both edges of both intervals and by testing whether either support constant could be frame-dependent; it cannot, both being bounds on frame-independent spectra.**

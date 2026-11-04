# Review r637, Lemma L97, the vertex Laplacian is PSD at a diagonal critical point

**Verdict: CONFIRMED, with one false word and two pointer defects.** The criticality equation, both equalities of the display, the factor $\tfrac12$, the identification $K^2-\lambda K=L(K_{ab}^2)$ and the conclusion $K^2-\lambda K\succeq0$ at **every** diagonal critical point are all correct, derived here cold from the definitions. The provenance note is accurate to the minute. What fails is the word **"equivalently"** in the boxed line at [diagonal-half.md:241](../findings/diagonal-half.md): PSD is equivalent to the **open** interval $(0,\lambda)$, and the half-open $(0,\lambda]$ printed there is a strictly stronger fact that only [Lemma L129](../findings/diagonal-half.md) supplies. The "strictly stronger than the scalar one" claim is **true**, but the sentence at [diagonal-half.md:249](../findings/diagonal-half.md) points it at the wrong scalar statement, the one "below" is an open conjecture, not an instance of this lemma.

Reviewer r637, one of an independent pair on identical briefs. Analysis-only footing: nothing below was computed; every number quoted from the record is quoted, never re-derived numerically, and no screen was needed.

## 0. The reading adopted, fixed before anything else

The brief warns that [conventions.md](../findings/conventions.md) is unreliable. These are the senses I adopt, each pinned to a line I can point at, and each cross-checked against a number the block itself prints.

| symbol | reading adopted | where it is pinned |
| --- | --- | --- |
| $K$ | the symmetric hollow $n\times n$ **sectional** matrix, $K_{ab}=W_{abab}$ for $a\ne b$; the block's $K$ and the file's $M$ are the same object | [conventions.md](../findings/conventions.md), "The vertex matrix"; the alias is tabled under "the letter $M$ carries two objects" |
| pairing | the half-trace one at the $\Lambda^2$ level, under which $\{\varphi_{ab}\}_{a<b}$ is orthonormal, so $\lVert W\rVert^2=\sum_{a<b}K_{ab}^2$ | [conventions.md](../findings/conventions.md), "Norms and pairings" |
| $\sum_{ab}$ | **ordered** pairs, $a=b$ included | [conventions.md](../findings/conventions.md), "Sums over pairs are over ORDERED pairs unless the line says otherwise" |
| $t$ | $t=\lVert K\rVert_F^2=\sum_{a\ne b}K_{ab}^2=\mathop{\mathrm{tr}}K^2$, per frame; $t=2$ identically on the diagonal locus at unit Weyl norm | [conventions.md](../findings/conventions.md), "The vertex matrix" |
| $K^{\circ2}$ | the **Hadamard** square, $(K^{\circ2})_{ab}=K_{ab}^2$; entrywise nonnegative, and hollow because $K$ is | the block's own use, and [diagonal-half.md:78](../findings/diagonal-half.md) |
| $K^2$ | the **matrix** square, $(K^2)_{ab}=\sum_cK_{ac}K_{cb}$; **not** hollow, its diagonal being $s_a$ | same |
| $D$ | $\mathop{\mathrm{diag}}(\mathop{\mathrm{diag}}K^2)=\mathop{\mathrm{diag}}(s_1,\dots,s_n)$ with $s_a=\sum_bK_{ab}^2$ | the identity $(K^2)_{aa}=\sum_bK_{ab}K_{ba}=\sum_bK_{ab}^2$, by symmetry alone |
| $\lambda$ | **$\theta$**, the critical value $P(W)/\lVert W\rVert^3$, positive | fixed in §5 below, from the block's own $2/\lambda^2=1.309$ at $n=12$ |

The two squares are distinguished at every occurrence below, and §2 records where each one is load-bearing. The check that $D=\mathop{\mathrm{diag}}(s)$ and $\mathop{\mathrm{diag}}(\mathop{\mathrm{diag}}K^2)$ are the same object costs one line and needs only $K=K^{\mathsf T}$; hollowness is not consumed there.

**A normalisation cross-check, since a factor $2$ is what this audit most often finds.** The file's diagonal-locus problem carries $\mathop{\mathrm{tr}}M^2=2$ ([diagonal-half.md:30](../findings/diagonal-half.md)) against $\sum_{a<b}w_{ab}^2=1$ ([diagonal-half.md:14](../findings/diagonal-half.md)). Those agree exactly under the ordered-pair reading, and they agree with [conventions.md](../findings/conventions.md)'s $t=2$. So the block, the file and the conventions file are in one normalisation, and no factor $2$ enters anywhere in what follows.

## 1. The criticality equation, DERIVED, and it holds

I derive it from scratch rather than from the file's account, then compare.

**The variational problem.** On the diagonal locus a Weyl operator is $W=\mathop{\mathrm{diag}}(w)$ with $W\varphi_{ab}=K_{ab}\varphi_{ab}$, and the locus is parametrised by $\mathcal D_n=\{K\text{ symmetric},\ \mathop{\mathrm{diag}}K=0,\ K\mathbf1=0\}$: hollowness is the absence of an $a=b$ pair, $K\mathbf1=0$ is Ricci-flatness, and the first Bianchi identity is automatic because every component with three or four distinct indices vanishes. The functional is $P(K)=\tfrac12\big(\sum_{a,b}K_{ab}^3+\mathop{\mathrm{tr}}K^3\big)$, and $\theta=P$ at $\mathop{\mathrm{tr}}K^2=2$.

**First variation.** For symmetric hollow $\delta K$,

$$\delta\!\sum_{a,b}K_{ab}^3=3\langle K^{\circ2},\delta K\rangle,\qquad \delta\mathop{\mathrm{tr}}K^3=3\langle K^2,\delta K\rangle,\qquad \delta\mathop{\mathrm{tr}}K^2=2\langle K,\delta K\rangle,$$

the middle one using $\mathop{\mathrm{tr}}(K^2\delta K)=\langle K^2,\delta K\rangle$ by symmetry. The Ricci-flatness constraint contributes $\sum_a v_a\sum_b\delta K_{ab}=\tfrac12\sum_{a,b}(v_a+v_b)\delta K_{ab}$ after symmetrising. Hollowness is a constraint on the diagonal only, so stationarity is imposed off the diagonal alone:

$$\big(K^{\circ2}+K^2\big)_{ab}=c\,K_{ab}+v_a+v_b\qquad(a\ne b).$$

Note that $K^{\circ2}$ and $K^2$ enter through **different** derivatives (the entrywise cube sum gives the Hadamard square, the trace of the cube gives the matrix square) and swapping them changes the equation. This is the conflation the brief flags, and the two terms are distinct here for a structural reason, not by coincidence.

**The multiplier is $\theta$.** Contract with $K$. The $v$ term dies on $K\mathbf1=0$; $\sum_{a\ne b}(K^2)_{ab}K_{ab}=\mathop{\mathrm{tr}}K^3$ because the $a=b$ term is $K_{aa}(K^2)_{aa}=0$; $\sum_{a,b}K_{ab}^2K_{ab}=\sum K_{ab}^3$; and $\sum_{a\ne b}K_{ab}^2=\mathop{\mathrm{tr}}K^2=2$. So $2P=2c$, i.e. $c=P=\theta$ at unit norm. **Unit norm is consumed exactly here** and nowhere else.

**The multiplier vanishes.** Sum the off-diagonal equation over $b\ne a$. The Hadamard term gives $s_a$ (the $a=b$ term is $0$ by hollowness); the matrix term gives $\sum_b(K^2)_{ab}-(K^2)_{aa}=0-s_a$, using $K^2\mathbf1=0$; the $\theta K$ term gives $0$. So $0=(n-2)v_a+\mathbf1^{\mathsf T}v$ for every $a$, hence all $v_a$ are equal, hence $(2n-2)v=0$ and $v=0$ at every $n\ge2$. The file's arithmetic here is right.

**The diagonal comes for free.** $(K^{\circ2})_{aa}=0$, $\theta K_{aa}=0$, $(K^2)_{aa}=s_a$, so the equation extends to $a=b$ once $\mathop{\mathrm{diag}}(s)$ is added:

$$K^{\circ2}+K^2=\theta K+D,\qquad D=\mathop{\mathrm{diag}}(s)=\mathop{\mathrm{diag}}(\mathop{\mathrm{diag}}K^2).$$

**CONFIRMED**, identical to the block's statement and to the boxed equivalence at [diagonal-half.md:78](../findings/diagonal-half.md).

**Hypotheses consumed, exactly.**

| hypothesis | consumed? | where |
| --- | --- | --- |
| coordinate-diagonality | **yes** | the whole parametrisation; the functional is $P(K)$ only on the locus |
| criticality (stationarity) | **yes** | the Euler–Lagrange step |
| $K$ hollow | **yes** | the $a=b$ term dropping in the row sum, and the diagonal extension |
| Ricci-flatness $K\mathbf1=0$ | **yes** | killing $v$ in the contraction, and $K^2\mathbf1=0$ in the row sum |
| unit norm $\mathop{\mathrm{tr}}K^2=2$ | **yes** | only to identify $c$ with $\theta$ rather than an unnamed multiplier |
| maximality | **no** | stationarity alone is used |
| first Bianchi | **not separately** | it is automatic on the locus, so it is consumed in setting up $\mathcal D_n$, never invoked as a step |
| $\theta>0$ | **no**, for the equation | needed only downstream, at the interval reading (§4) |

## 2. The chain of two equalities, both CONFIRMED

**First equality.** $v^{\mathsf T}Dv=\sum_a s_av_a^2=\sum_{a,b}K_{ab}^2v_a^2$ and $v^{\mathsf T}K^{\circ2}v=\sum_{a,b}K_{ab}^2v_av_b$, both sums **ordered and including $a=b$**, so

$$v^{\mathsf T}Dv-v^{\mathsf T}K^{\circ2}v=\sum_{a,b}K_{ab}^2\big(v_a^2-v_av_b\big).$$

**CONFIRMED.** One refinement to what the brief expects: the $a=b$ terms vanish *twice over*. They vanish because $K$ is hollow, and they would vanish anyway because the summand at $a=b$ is $K_{aa}^2(v_a^2-v_a^2)=0$ identically. So the display is insensitive to whether $a=b$ is included, and no ordered/unordered ambiguity can bite here. Hollowness is what makes $D$ the right object at the level of the *criticality equation* (§1) and at the level of the *Laplacian identification* (§3), rather than at this equality.

**Second equality.** $\tfrac12\sum_{a,b}K_{ab}^2(v_a-v_b)^2=\tfrac12\sum_{a,b}K_{ab}^2v_a^2-\sum_{a,b}K_{ab}^2v_av_b+\tfrac12\sum_{a,b}K_{ab}^2v_b^2$. The symmetry $K_{ab}^2=K_{ba}^2$ relabels the third sum into the first, giving $\sum_{a,b}K_{ab}^2v_a^2-\sum_{a,b}K_{ab}^2v_av_b$, which is the middle expression. **CONFIRMED, and the factor $\tfrac12$ is correct**, it is exactly the price of double-counting each unordered pair in an ordered sum, and dropping it or writing $1$ in its place would break the identity by a factor $2$. The symmetry step is real and is used; without it the third sum is not the first.

Non-negativity is then immediate, each term being a square times a square.

## 3. The conclusion, CONFIRMED, with the quantity correctly identified

The criticality equation rearranges **exactly**, with nothing dropped, to $D-K^{\circ2}=K^2-\theta K$. So the quantity shown non-negative *is* $v^{\mathsf T}(K^2-\theta K)v$, term for term, and since $v$ was arbitrary,

$$K^2-\theta K\succeq0\quad\text{at every diagonal critical point.}$$

**The Laplacian identification checks out.** With $w_{ab}=K_{ab}^2\ge0$: the diagonal of $K^2-\theta K$ is $s_a-0=s_a=\sum_bw_{ab}$, which is $L(w)_{aa}$, and the off-diagonal is $(D-K^{\circ2})_{ab}=-K_{ab}^2=-w_{ab}=L(w)_{ab}$. So $K^2-\theta K=L(w)$ on the nose, and the display is the standard $v^{\mathsf T}L(w)v=\tfrac12\sum w_{ab}(v_a-v_b)^2$. The block's one-line route and the pairing route are the same computation read twice; I reached it independently, which is what the block's "reached independently by a cold reviewer" claims of an earlier one.

**The auxiliary identities in the same section also check out**, and I record them because they are what makes the off-locus discussion honest rather than decorative:

- $E:=(K^2-\theta K)-L(K_{ab}^2)$ is **hollow at every $K$ whatsoever**: $E_{aa}=\sum_bK_{ab}^2-0-\sum_bK_{ab}^2=0$, needing only $K$ symmetric and hollow, no criticality and no distinguished scalar. The block's claim is exactly right, including its "for every scalar" clause.
- $U:=\theta K-K^{\circ2}-K^2$ with the diagonal zeroed has $U\mathbf1=0$: the row sum is $0-s_a-(0-s_a)=0$, using $K\mathbf1=0$ and $K^2\mathbf1=0$. And $U=-E$, so $E=L(U_{ab})$ and $K^2-\theta K=L(K_{ab}^2+U_{ab})$, which is the block's general display. **CONFIRMED.**

## 4. The one false word: "equivalently"

$K$ is symmetric, so $K^2-\theta K\succeq0$ holds iff $\kappa^2-\theta\kappa\ge0$ for every eigenvalue $\kappa$ of $K$, iff $\kappa(\kappa-\theta)\ge0$, iff

$$\kappa\le0\quad\text{or}\quad\kappa\ge\theta\qquad(\theta>0).$$

That is precisely "**no eigenvalue in the open interval $(0,\theta)$**". The endpoint $\kappa=\theta$ gives $\kappa^2-\theta\kappa=0\ge0$ and is **permitted** by positive semidefiniteness. So the boxed line at [diagonal-half.md:241](../findings/diagonal-half.md),

> $\boxed{K^2-\lambda K\succeq0}$ &nbsp;&nbsp; equivalently &nbsp;&nbsp; **$K$ has no eigenvalue in** $(0,\lambda]$,

**asserts an equivalence that is false in the $\Leftarrow$-supplying direction**: the half-open statement is strictly stronger than the PSD statement, and no rearrangement of the display yields it.

**The half-open statement is nevertheless true** at every diagonal critical point, and the blockquote immediately below the box says how: [Lemma L129](../findings/diagonal-half.md) adds that $\ker L(w)$ is spanned by the component indicators $\mathbf1_{C_t}$, each of which $K$ annihilates ($(K\mathbf1_{C_t})_a=\sum_{b\in C_t}K_{ab}=\sum_bK_{ab}=0$ for $a\in C_t$, since $K_{ab}=0$ across components), so $Kx=\theta x$ forces $L(w)x=0$, hence $x\in\ker L(w)$, hence $Kx=0$, hence $\theta x=0$, hence $x=0$. I checked that argument and it is sound.

**Git confirms this is an editing scar, not a derivation error.** The line read $(0,\lambda)$ (a correct equivalence), until commit d15e4be0 of 2026-09-02, `feat(diagonal-half): Lemma L129 -- the spectral gap is half-open`, whose diff changes the closing parenthesis to a bracket and leaves "equivalently" standing. The correction made the *fact* right and the *logic* wrong in the same keystroke.

**What is owed, and it is one word.** Either "equivalently ... $(0,\lambda)$, and by [Lemma L129](../findings/diagonal-half.md) in fact $(0,\lambda]$", or "hence ... $(0,\lambda)$; with [Lemma L129](../findings/diagonal-half.md), $(0,\lambda]$". A consumer citing **L97 alone** for the closed endpoint is citing L129 without knowing it, and the record has already had one line of work turn on that endpoint. I did not edit [findings/](../findings/), per the brief.

## 5. Is $\lambda$ the same object throughout? Yes, but it is undeclared, and it collides in-paragraph

$\lambda$ is $\theta$ everywhere in the block. Three independent anchors pin it:

- the counting corollary evaluates $2/\lambda^2=1.309$ "at $\lambda=\theta_0(12)$", and $2/\theta_0(12)^2=144/110=1.3\overline{09}$ under [conventions.md](../findings/conventions.md)'s $\theta_0(n)^2=2(n-1)(n-2)/n^2$;
- the general claim $2/\theta_0(n)^2=n^2/((n-1)(n-2))$ is that same substitution;
- [Lemma L129](../findings/diagonal-half.md) and [r388](REVIEW_r388.md) restate the identical result as $\mathop{\mathrm{spec}}(M)\cap(0,\theta]=\varnothing$ and $M^2-\theta M=L(M^{\circ2})$.

So there is no $\Lambda^2$-eigenvalue reading in play and no $\theta$-for-$\lambda$ substitution error of the kind the brief warns about. **Two presentational hazards remain**, and I record them because the brief asks:

- $\lambda$ is used for $\theta$ without ever being introduced, in a file that writes $\theta$ and $M$ in every neighbouring section and a conventions file that tables $\theta$ and never tables $\lambda$;
- the same paragraph writes $\lambda_{\min}(K^2-\lambda K)=-0.1467$, putting the letter to two different jobs inside one expression, and [diagonal-half.md:180](../findings/diagonal-half.md)–[:196](../findings/diagonal-half.md) uses $\lambda_{\max}(L_e)$ for a third.

## 6. "Strictly stronger than the scalar one", the claim is TRUE, the pointer is WRONG

These are two separate things and the record needs to know which it may cite.

**The claim is true.** The scalar consequence is the $v=u$ instance at the top eigenvector: $u^{\mathsf T}(K^2-\theta K)u=\mu_1^2-\theta\mu_1\ge0$, so $\mu_1\ge\theta$. The matrix statement gives that **and** constrains every other eigenvalue, and the extra content is not vacuous, it is exactly what the block's own counting corollary consumes. Concretely, three things follow from the matrix form that $\mu_1\ge\theta$ cannot give:

1. $r\le t/\lambda^2\le2/\lambda^2$ for the number $r$ of positive eigenvalues, hence $r=1$ at $\lambda=\theta_0(12)$;
2. its contrapositive, $r\ge2\Rightarrow\theta\le1$, which needs a second positive eigenvalue to be constrained;
3. [Lemma L129](../findings/diagonal-half.md)'s kernel argument, which runs on $\ker(K^2-\theta K)$ and so needs the whole matrix.

I checked the counting corollary. $r\lambda^2\le\sum_{\kappa>0}\kappa^2\le\mathop{\mathrm{tr}}K^2=t$, the second step discarding the negative eigenvalues' non-negative contribution; $t=2$ on the locus. The claim "$2/\theta_0(n)^2<2$ at every $n\ge6$" reduces to $n^2<2(n-1)(n-2)$, i.e. $n^2-6n+4>0$, i.e. $n>3+\sqrt5=5.236$, so it is true at every $n\ge6$, of either parity, and the "even" qualifier is there because $\Theta_n=\theta_0(n)$ only at even $n$, not because the inequality needs it. **All CONFIRMED.**

**There is a fourth gain the block does not claim and could.** The scalar $\theta\le\mu_1$ as derived at [diagonal-half.md:214](../findings/diagonal-half.md) bounds $u^{\mathsf T}K^{\circ2}u$ by $\max_as_a$, which is lossless **only where the row norms are equal**, the vertex-transitive locus. The $v=u$ instance of L97's identity gives $\theta\le\mu_1$ at **every** diagonal critical point, vertex-transitive or not. So the matrix form is stronger in reach as well as in content.

**The pointer is wrong.** [diagonal-half.md:249](../findings/diagonal-half.md) reads

> **The scalar Poincaré inequality below is the single instance $v=$ top eigenvector.**

The only Poincaré inequality below is the boxed one at [diagonal-half.md:314](../findings/diagonal-half.md), $\sum_{i,j}M_{ij}^2(u_i-u_j)^2\ge2\mu_1^2/n$. **That is not an instance of L97, it is an open conjecture, B1's entire residual.** The $v=u$ instance of L97's display is the *identity*

$$\sum_{i,j}M_{ij}^2(u_i-u_j)^2=2\mu_1(\mu_1-\theta),$$

so the boxed inequality is equivalent to $2\mu_1(\mu_1-\theta)\ge2\mu_1^2/n$, i.e. to $\theta\le\frac{n-1}{n}\mu_1$, which [diagonal-half.md:216](../findings/diagonal-half.md) names as precisely what is owed. L97 supplies the right-hand side $\ge0$; the box below asks for $\ge2\mu_1^2/n$. **The gap between them is the factor $(n-1)/n$ that the whole of diagonal branch 1 turns on.**

The sentence is therefore a **GAP-grade defect in the reading, not in the mathematics**: taken at its word it says L97 proves B1 on the vertex-transitive locus, which it does not. Read as pointing *upward* to [diagonal-half.md:214](../findings/diagonal-half.md)'s $\theta\le\mu_1$, the sentence is true, on the vertex-transitive locus, where the $s_a$ are equal, that derivation *is* the $v=u$ instance, since $u^{\mathsf T}K^{\circ2}u\le\max_as_a$ is then exactly $u^{\mathsf T}K^{\circ2}u\le u^{\mathsf T}Du$. The single word to fix is **"below"**, and the safe repair is to say which statement is meant and that the boxed Poincaré at [diagonal-half.md:314](../findings/diagonal-half.md) is strictly stronger than any instance of this lemma.

## 7. Scope

**Every diagonal critical point, not only maximisers. CONFIRMED.** §1 uses stationarity and nothing else; no second-order information, no comparison with a competitor, no $\theta=\Theta_n$ enters. The heading is accurate.

**The kernel.** On the locus $K^2-\lambda K$ **is** $L(w)$ with $w_{ab}=K_{ab}^2$, so $\ker(K^2-\lambda K)=\ker L(w)=\mathop{\mathrm{span}}\{\mathbf1_{C_t}\}$ over the connected components $C_t$ of the graph $\{K_{ab}\ne0\}$ (note $w_{ab}>0\iff K_{ab}\ne0$), of dimension the number of components. That is **consistent with the block at [diagonal-half.md:479](../findings/diagonal-half.md)**, which asserts the same span and is what [Lemma L130](../findings/diagonal-half.md) and [Lemma L129](../findings/diagonal-half.md) lean on. The two are the same statement because the identification of $K^2-\lambda K$ with $L(w)$ is exact rather than approximate, which is the point of §3. It also matches [r562](REVIEW_r562.md)'s reading, $\dim\ker M=\#$components, derived from L97/L129.

**Off the locus, in one sentence.** The vertex equation at $(a,b)$ picks up $W^{\#}$ and $C^{pq}$ contributions from the non-diagonal components, so the off-diagonal entry of $K^2-\lambda K$ ceases to be $-K_{ab}^2$; the matrix stays symmetric with the *same* diagonal (because $E$ is hollow for free, §3), and every bit of the failure is carried by off-diagonal weights that are no longer squares and no longer signed. The block says this and it is right, including the sharper reading that the argument is not weakened off the locus but **unavailable** there.

**And criticality is genuinely needed, not merely convenient.** The section records reviewer 129's hand-built $n=8$ witness, two copies of a four-vertex weight at scales $c_1$ and $\delta$, row sums exact, $\lVert K\rVert_F^2=2$, an eigenvalue $4\delta$ inside $(0,\theta)$, which refutes the statement as a property of the diagonal *locus*. That is consistent with §1: the display consumes the vertex equation at every $(a,b)$, which is criticality. Nothing in my derivation would survive dropping it.

## 8. The checklist items

| item | verdict |
| --- | --- |
| **Provenance**, "derived after Reviewer 125 pointed out that the top eigenvector was being used where a general vector is available" | **ACCURATE.** [r125](REVIEW_r125.md), line 94, says "A **general** unit $v$ is the most informative choice and is not used ... which on the diagonal locus is the full matrix statement $K^2-\lambda K\succeq0$ rather than one scalar. **That generalisation is free and the record does not record it.**", and line 100 repeats it. Git orders it: r125 landed in commit 146039bd at 06:43:57 on 2026-08-27, the L97 block in 6d0b5bf4 at 06:48:03 the same morning, four minutes later. One of the clean ones. |
| **"strictly stronger"** | **TRUE as a claim**, wrongly pointed, §6. |
| **"arbitrary"** | **TRUE.** The display holds for every $v\in\mathbb R^n$, with no normalisation, no orthogonality to $\mathbf1$, and no eigenvector hypothesis. |
| **"Gate 2 owed on this section"** | **STALE and misleading.** The section below the hedge carries four separate Gate 2 verdicts (reviewers 127, 128, 129, 130), on the off-locus material, the locus-not-criticality refutation and the frame question. What was never Gate-2'd is the identity itself and the box, which is what this pair is for. The hedge should say which half it applies to. |
| **Does the file settle it above or below?** | **Yes, above.** [diagonal-half.md:78](../findings/diagonal-half.md) already carries the criticality equation as a boxed iff, with the multiplier argument. The block restates it at line 235 in different letters ($K$, $\lambda$, $D$ against $M$, $\theta$, $\mathop{\mathrm{diag}}(s)$) without citing it, a restatement of the kind [conventions.md](../findings/conventions.md) exists to forbid. |
| **Pointers** | **One dead.** [diagonal-half.md:268](../findings/diagonal-half.md) writes `[post F29](INDEX.md)`; [findings/INDEX.md](../findings/INDEX.md) contains no occurrence of "F29", and neither does [INDEX-traps.md](../findings/INDEX-traps.md). The post is at [target.md:54](../findings/target.md), "Post F29, $\lambda\le\mu_{\max}(K)$ in a fixed frame cannot bound $\theta$". The two in-file anchors in the block, to [Lemma L129](../findings/diagonal-half.md) and from [diagonal-half.md:479](../findings/diagonal-half.md) back to L97, both slug correctly and resolve. |

## 9. Summary of what the record may and may not cite

| statement | status |
| --- | --- |
| $K^{\circ2}+K^2=\lambda K+D$ at a diagonal critical point, $D=\mathop{\mathrm{diag}}(\mathop{\mathrm{diag}}K^2)$ | **CONFIRMED**, derived cold here |
| $v^{\mathsf T}(K^2-\lambda K)v=\tfrac12\sum_{a,b}K_{ab}^2(v_a-v_b)^2$ for every $v$ | **CONFIRMED**, both equalities, factor $\tfrac12$ correct |
| $K^2-\lambda K=L(K_{ab}^2)$, the weighted graph Laplacian | **CONFIRMED**, exact, diagonal and off-diagonal |
| $K^2-\lambda K\succeq0$ at **every** diagonal critical point | **CONFIRMED**, no maximality used |
| $K$ has no eigenvalue in $(0,\lambda)$ | **CONFIRMED**, this, and only this, is equivalent to PSD |
| $K$ has no eigenvalue in $(0,\lambda]$ | **TRUE but not by this lemma**, the word "equivalently" at [diagonal-half.md:241](../findings/diagonal-half.md) is false; cite [Lemma L129](../findings/diagonal-half.md) for the endpoint |
| $\ker(K^2-\lambda K)=\mathop{\mathrm{span}}\{\mathbf1_{C_t}\}$ | **CONFIRMED**, consistent with [diagonal-half.md:479](../findings/diagonal-half.md) |
| $r\le2/\lambda^2$, hence $r=1$ at $\lambda=\theta_0(12)$, and $r\ge2\Rightarrow\theta\le1$ at every $n\ge6$ | **CONFIRMED** |
| "strictly stronger than the scalar one" | **CONFIRMED as a claim**; the sentence's word "below" points at B1's open conjecture and should point up |
| provenance to [r125](REVIEW_r125.md) | **CONFIRMED** by text and by git, to the minute |

**Nothing here needed computation, and none was done.** The one place where a run could add anything is the off-locus table and the $10^{-17}$ confirmations, which I neither reproduced nor relied on; the lemma stands or falls on §1–§3, which are four lines of algebra a reader can check.

# Review r411, Gate 2 on "$\mathrm{Ric}(R)\wedge\mathrm{id}=R+R\#I-3\,\mathrm{Alt}(R)$"

*Cold brief. Every step was re-derived from the definition of $\#$ in [boehm-wilking-2008-space-forms/notes.md](../references/boehm-wilking-2008-space-forms/notes.md) before the record's own values were read back; the phase order is in [agent_logs/gate2-wedge-A.log](../agent_logs/gate2-wedge-A.log). **Analysis only, no run was opened, and no screen was needed**: every number below is closed form, and the one value the section could not derive ($c_4$) is settled here three independent ways by hand. Target: the final section of [ATTEMPTS.md](../ATTEMPTS.md).*

## Verdicts

| # | Claim | Verdict |
| --- | --- | --- |
| 1 | The bracket identity is bilinearity alone, for every symmetric $R$ | **CONFIRMED**, and it is a tautology, $I^2=I$, $I$ central, and $\#$ symmetric bilinear with $R^\#:=R\#R$ |
| 2 | Bianchi enters only in identifying the result with $\mathrm{Ric}(R)\wedge\mathrm{id}$ | **CONFIRMED** |
| 3 | $\mathrm{Alt}$ is the orthogonal projection onto $\Lambda^4$, $\mathrm{Ric}$ annihilates $\Lambda^4$, $\Lambda^4$ is irreducible so $c_4$ is one scalar | **CONFIRMED**, with one hypothesis the section never states and needs: **$O(n)$-equivariance, not $SO(n)$**. Under $SO(n)$ the argument fails outright at $n=4$ and is unjustified at $n=8$ |
| 4 | $T=2(\#I)$, "checked on three components", hence $c_4=2$ | **THE ARGUMENT IS REFUTED, the conclusion is CONFIRMED, by a proof the section does not give.** Agreement on three of four summands leaves $c_4$ completely free; the inference is a non-sequitur. But $T=2(\#I)$ is a **two-line identity**: both maps are the quadratic form $h\mapsto-\mathrm{tr}\!\big(R\,\mathrm{ad}(h)^2\big)$, up to the factor $2$ |
| 5 | $c_4=2$, hence $\mathrm{Ric}(R)\wedge\mathrm{id}=R+R\#I-3\,\mathrm{Alt}(R)$ | **CONFIRMED**, three independent ways. The constant $3$ is correct **only because the record's $\mathrm{Alt}$ is idempotent and self-adjoint**, which it is |
| 6 | $H=2\big(\lvert W\rvert+\lvert W\rvert\#I-3\,\mathrm{Alt}(\lvert W\rvert)\big)$ exactly | **CONFIRMED**, factor $2$ included, it is exactly the bridge between Böhm–Wilking's $\wedge\mathrm{id}$ and the record's $h\wedge2\,\mathrm{id}$. **Two hazards flagged**: two incompatible $\wedge$ conventions now sit in [ATTEMPTS.md](../ATTEMPTS.md), and $\mathrm{Alt}(\lvert W\rvert)=\pm2\,\mathrm{Alt}(W_-)$, so $\lVert\mathrm{Alt}(\lvert W\rvert)\rVert^2=4\delta^2$ and **not** $\delta^2$ |
|, | Novelty: "nothing in [findings/](../findings/) carries $\mathrm{Ric}(R)\wedge\mathrm{id}-(R+R\#I)$" | **REFUTED. The boxed identity is [Lemma L15](../findings/problem.md) polarised, and is equivalent to it in one line.** Worse, the record already *names* "the polarized identity of Lemma L15" as a proof ingredient in [bounds.md](../findings/bounds.md) and [ATTEMPTS.md](../ATTEMPTS.md). This is the session's sixth already-on-the-record proposal, and the screen that missed it was again an expression screen where a mechanism screen was owed |

**The section is right and its proof is not.** Its one load-bearing step is an invalid inference that happens to land on the true value; its headline formula is a restatement of a lemma the record has held, proven twice, and used in a theorem. What survives as genuinely new is the thing the section asserted without proof (**$T=2(\#I)$**) which is worth having on its own account, because it identifies the operator [Lemma L36](../findings/isotropy-cap.md) rests on with Böhm–Wilking's $\#I$.

## Conventions used throughout

$\mathfrak{so}(n)\cong\Lambda^2\mathbb R^n$ with $\langle A,B\rangle=-\tfrac12\mathop{\mathrm{tr}}(AB)$, so $\{e_i\wedge e_j\}_{i<j}$ is orthonormal, the normalisation [Böhm–Wilking](../references/boehm-wilking-2008-space-forms/notes.md) state their $\tfrac12$ in $\#$ is an artefact of. Write $\mathcal A_h:=\mathrm{ad}(h)$ for the action of $h\in\mathfrak{so}(n)$ on $\mathfrak{so}(n)$; it is skew, and $\omega(x,y,z)=\langle[x,y],z\rangle$ is totally antisymmetric.

**One formula does all the work below.** From the definition of $\#$,
$$\langle(R\#I)h,h\rangle=\tfrac12\sum_{\alpha\beta}\langle[Rb_\alpha,b_\beta],h\rangle\langle[b_\alpha,b_\beta],h\rangle=\tfrac12\sum_\alpha\langle\mathcal A_hRb_\alpha,\mathcal A_hb_\alpha\rangle=-\tfrac12\mathop{\mathrm{tr}}\!\big(R\,\mathcal A_h^2\big),$$
using $\langle[x,y],h\rangle=\omega(h,x,y)=\langle\mathcal A_hx,y\rangle$ twice and then $\mathcal A_h^*=-\mathcal A_h$.

**It reproduces both of Lemma 2.1's known eigenvalues, which is the check that licenses it.** At $R=I$ and $h=e_1\wedge e_2$: $\mathcal A_h^2=-\mathrm{Id}$ on the $2(n-2)$ vectors $e_1\wedge e_k,e_2\wedge e_k$ and $0$ elsewhere, so $-\tfrac12\mathop{\mathrm{tr}}\mathcal A_h^2=n-2$, that is $I\#I=(n-2)I$. At $R_A=A\wedge\mathrm{id}$ with $A=\mathrm{diag}(a)$ trace-free, the same $h$ gives $\mathop{\mathrm{tr}}(R_A\mathcal A_h^2)=-\sum_{k\ge3}\big[(a_1+a_k)+(a_2+a_k)\big]=-(n-4)(a_1+a_2)$, so $R_A\#I=\tfrac{n-4}2R_A$. At $R$ a self-dual Weyl operator on $\Lambda^2\mathbb R^4$, $\mathrm{diag}(w_1,w_2,w_3)$ on $\Lambda^2_+$ with $\sum w_i=0$, and $h=\omega_1$ the first self-dual unit: $\mathcal A_{\omega_1}$ annihilates $\Lambda^2_-$, and $\mathcal A_{\omega_1}^2=-2$ on $\mathrm{span}\{\omega_2,\omega_3\}$, so $-\tfrac12\mathop{\mathrm{tr}}(R\mathcal A_{\omega_1}^2)=w_2+w_3=-w_1$, that is $W\#I=-W$.

## Step 1, correct, and empty

$I$ is the identity operator on $\Lambda^2$, so $I^2=I$ and $I$ commutes with every $R$; hence $(R\pm I)^2=R^2\pm2R+I$. And $\#$ is symmetric bilinear with $S^\#:=S\#S$, so $(R\pm I)^\#=R^\#\pm2\,R\#I+I^\#$ **by definition**, with no factor to carry. Subtracting, the $R^2$, $I$, $R^\#$ and $I^\#$ terms cancel pairwise and $\tfrac14\big[\cdots\big]=R+R\#I$. **Valid for every symmetric $R$**, as claimed.

*It is worth being blunt about what this establishes: nothing. The identity is the polarisation of a symmetric bilinear map written out, and Böhm–Wilking use it only as bookkeeping before invoking their equation (6), which is where the content and the Bianchi hypothesis both live.* Note also that $I\#I=(n-2)I\ne I$; that asymmetry with $I^2=I$ is invisible here only because $I^\#$ cancels.

## Step 2, correct

Lemma 2.1's proof reaches $\mathrm{Ric}\wedge\mathrm{id}$ through equation (6) on $\langle I\rangle\oplus\langle\mathrm{Ric}_0\rangle$ and through the $n=4$ Weyl verification plus stabilisation, all three inside $S^2_B$. Nothing before that point uses Bianchi. **Confirmed.**

## Step 3, correct, but it silently needs $O(n)$ and would be false under $SO(n)$

**$\mathrm{Ric}$ annihilates $\Lambda^4$: confirmed.** The $\Lambda^4$ summand of $S^2(\Lambda^2)$ is exactly the totally antisymmetric $R_{ijkl}$, and $\mathrm{Ric}(R)_{ik}=\sum_jR_{ijkj}$ has a repeated index in every term, so each term vanishes identically.

**$\mathrm{Alt}$ is the orthogonal projection: confirmed, and it matters.** $\mathrm{Alt}(R)_{ijkl}=\tfrac13(R_{ijkl}+R_{iklj}+R_{iljk})$ fixes totally antisymmetric tensors and kills $S^2_B$, so it is idempotent and self-adjoint, and the record's implementation is checked for exactly those two properties in [review_r12_independent.py:386](../scripts/lib/review_r12_independent.py#L386), with [problem.md](../findings/problem.md) stating "$\mathrm{Alt}$ being the projection onto $\Lambda^4$". **Had the record's $\mathrm{Alt}$ been the unnormalised Bianchi map $b=3\,\mathrm{Alt}$, the constant in the box would be $1$, not $3$.** The section never checks this, and it is the difference between a correct formula and a formula off by a factor of three.

**$\Lambda^4$ irreducible: confirmed under $O(n)$, at every $n$, and the section's argument needs precisely that.** $\#$ is built from the Lie bracket and the metric, both preserved under conjugation by any $g\in O(n)$ including reflections, and $I$ is $O(n)$-invariant; so $\#I$ is $O(n)$-equivariant and Schur applies over $O(n)$. Checking the two places where $SO(n)$ would not suffice:

- **$n=4$.** $\Lambda^4\mathbb R^4=\mathbb R\cdot\star$ is one-dimensional and is the **determinant** representation, *trivial* under $SO(4)$. So under $SO(4)$ the trivial isotypic component of $S^2(\Lambda^2\mathbb R^4)$ has multiplicity two, $\langle I\rangle\oplus\langle\star\rangle$, and an $SO(4)$-equivariant map may mix them: $c_4$ would not be a scalar at all. Under $O(4)$ they are distinguished (trivial versus $\det$) and no mixing is possible.
- **$n=8$.** $\Lambda^4\mathbb R^8=\Lambda^4_+\oplus\Lambda^4_-$ splits under $SO(8)$ (the triality case the brief flags), but the two halves are exchanged by any $g\in O(8)$ with $\det g=-1$, so $\Lambda^4$ is $O(8)$-irreducible and one scalar is forced. *Independently, the Casimir cannot separate them either: the highest weights $e_1{+}e_2{+}e_3\pm e_4$ have equal length and equal $\langle\lambda,2\rho\rangle=12$.*

At the remaining small $n$ the summand is distinct by dimension and weight: $\Lambda^4\cong\Lambda^{n-4}\otimes\det$ has dimension $5,15,35$ at $n=5,6,7$ against $\dim\mathrm{Sym}^2_0=14,20,27$ and $\dim\mathcal W=35,84,168$; the one collision, $\dim\Lambda^4\mathbb R^5=\dim\mathcal W_5=35$ at $n=5$, is not an isomorphism (weights $e_1$ versus $2e_1{+}2e_2$). **So the conclusion stands, but the section states "the irreducible $\Lambda^4$" as if it were free, when at $n=4$ it is exactly the hypothesis that saves the argument.**

## Step 4, the inference is invalid, and the identity is true anyway

### What $T$ actually is

[isotropy-cap.md:33](../findings/isotropy-cap.md#L33) defines
$$T(A)=-\sum_k\mathrm{ad}(f_k)\,A\,\mathrm{ad}(f_k)=2(n-2)\mathrm{Id}-\tfrac12\mathrm{Cas},$$
a completely positive map built from the adjoint action, introduced so that $\mu(\mathfrak m)=\sum_{a,b}\lVert[e_a,e_b]\rVert^2=\langle T(P),P\rangle$ for $P$ the projection onto $\mathfrak m$. **It is not defined as $\#I$, and nothing in [findings/](../findings/) or [references/](../references/) connects the two files**, [isotropy-cap.md](../findings/isotropy-cap.md) never mentions $\#$, and [bounds.md](../findings/bounds.md), [target.md](../findings/target.md) and the Böhm–Wilking notes never mention $T$.

### The section's inference does not survive contact

$S^2(\Lambda^2)$ is multiplicity-free with four summands, so the algebra of $O(n)$-equivariant endomorphisms is **four-dimensional**: an equivariant map is four independent scalars. Fixing three of them fixes nothing about the fourth. Concretely, $2(\#I)+t\,\pi_{\Lambda^4}$ agrees with $2(\#I)$ on $\langle I\rangle$, $\langle\mathrm{Ric}_0\rangle$ and $\mathcal W$ **for every real $t$**, and each such map is a perfectly good equivariant operator. *So "$T=2(\#I)$, checked on three components" is exactly as much evidence for $c_4=2$ as it is for $c_4=17$*, and the section's own framing, "checked on all three components Lemma 2.1 supplies", names the gap without noticing it: Lemma 2.1 supplies three components because $\Lambda^4$ is the one place it is silent, which is the one place the section needs an answer.

### But $T=2(\#I)$ is a two-line identity

$$\langle T(R)h,h\rangle=-\sum_k\langle\mathcal A_kR\mathcal A_kh,h\rangle=\sum_k\langle R\,\mathcal A_kh,\mathcal A_kh\rangle=\sum_k\langle R\,\mathcal A_hf_k,\mathcal A_hf_k\rangle=-\mathop{\mathrm{tr}}\!\big(R\,\mathcal A_h^2\big),$$
using $\mathcal A_k^*=-\mathcal A_k$ and then $\mathcal A_kh=[f_k,h]=-\mathcal A_hf_k$. Against the boxed formula of the conventions section, $\langle(R\#I)h,h\rangle=-\tfrac12\mathop{\mathrm{tr}}(R\mathcal A_h^2)$, so
$$\boxed{\;T=2\,(\#I)\;}$$
as an identity of operators on all of $S^2(\Lambda^2)$, with no representation theory, no eigenvalue table, and no case analysis. **Both maps are the same quadratic form $h\mapsto-\mathop{\mathrm{tr}}(R\,\mathrm{ad}(h)^2)$.**

*The one place a factor could hide is the normalisation of the orthonormal basis $\{f_k\}$ in $T$'s definition against the $-\tfrac12\mathop{\mathrm{tr}}$ product $\#$ is stated in. It does not: $\langle T(P),P\rangle=\sum_a\mathop{\mathrm{tr}}(\mathcal A_{e_a}P\mathcal A_{e_a}^*)=\sum_{a,b}\lVert[e_a,e_b]\rVert^2=\mu$, which is the record's own use of $T$, so both live in the normalisation where $\{e_i\wedge e_j\}_{i<j}$ is orthonormal.*

### And $T$'s spectrum is analytic, not just measured

$T=2(n-2)\mathrm{Id}-\tfrac12\mathrm{Cas}$ with $\mathrm{Cas}(\lambda)=\langle\lambda,\lambda+2\rho\rangle$ and $2\rho=(n-2,n-4,\dots)$ gives $\mathrm{Cas}=0,\,2n,\,4n-4,\,4n-16$ on $\mathbb R,\mathrm{Sym}^2_0(\text{hw }2e_1),\mathcal W(\text{hw }2e_1{+}2e_2),\Lambda^4(\text{hw }e_1{+}\!\cdots\!+e_4)$, hence $T=2n-4,\,n-4,\,-2,\,4$. **This re-derives [isotropy-cap.md](../findings/isotropy-cap.md)'s table, which the record carries as verified at $n=4,\dots,7$ with multiplicities rather than as proven.** The normalisation is fixed by the adjoint itself: hw $e_1+e_2$ gives $\mathrm{Cas}=2n-4$, matching $\sum_k\mathcal A_k^2=-2(n-2)\mathrm{Id}$.

## Step 5, $c_4=2$, confirmed three ways, and the constant $3$ is right

**(i) From $T=2(\#I)$.** $T$'s $\Lambda^4$ eigenvalue is $4$ by the Casimir computation above, so $c_4=2$.

**(ii) Directly, at $n=4$, then by stabilisation.** $\Lambda^4\mathbb R^4=\mathbb R\cdot\star$, orthogonal to $I$ ($\mathop{\mathrm{tr}}\star=3-3=0$), to $\mathcal W_4$ (traceless on each $\Lambda^2_\pm$ block), and to $\langle\mathrm{Ric}_0\rangle$ (whose elements are diagonal in the $e_i\wedge e_j$ basis, where $\star$ has zero diagonal). Take $h=\omega_1=(e_{12}+e_{34})/\sqrt2$, where $\langle\star h,h\rangle=1$. Then $\mathcal A_{\omega_1}^2=-2$ on $\mathrm{span}\{\omega_2,\omega_3\}\subset\Lambda^2_+$ and $0$ elsewhere, while $\star=+1$ on $\Lambda^2_+$, so $\mathop{\mathrm{tr}}(\mathcal A_{\omega_1}^2\star)=-4$ and $\langle(\star\#I)h,h\rangle=2$. Hence $c_4=2$ at $n=4$. Padding into $\mathbb R^n$ changes nothing: $\star_4$ is supported on $\Lambda^2\mathbb R^4$, which $\mathcal A_{\omega_1}$ preserves, so the trace is unchanged and **$c_4=2$ at every $n\ge4$**.

**(iii) From the record's own [Lemma L15](../findings/problem.md).** See the novelty section, L15's constant $6$ is $2(1+c_4)$, and it pins $c_4=2$ on its own.

The arithmetic of the box is then immediate: $R+R\#I=\mathrm{Ric}(R_B)\wedge\mathrm{id}+(1+c_4)\mathrm{Alt}(R)=\mathrm{Ric}(R)\wedge\mathrm{id}+3\,\mathrm{Alt}(R)$, using $\mathrm{Ric}(R_B)=\mathrm{Ric}(R)$ from step 3. **Confirmed.**

## Step 6, confirmed, with two conventions that will bite the next reader

**The factor $2$ is exactly right, and it is not free.** Böhm–Wilking's $\mathrm{Ric}\wedge\mathrm{id}$ must be the *half*-derivation, since Lemma 2.1 at $R=I$ reads $I+I\#I=(n-1)I$ while $\mathrm{Ric}(I)=(n-1)\mathrm{id}$; the derivation convention would give $2(n-1)I$. The record's $H$ is the *full* derivation: [ATTEMPTS.md](../ATTEMPTS.md) Result 5(b) has $H=\mathrm{Ric}^*(\mathrm{Ric}(\lvert W\rvert))$, and $\mathrm{Ric}^*(A)$ is the operator $x\wedge y\mapsto Ax\wedge y+x\wedge Ay$, verified by pairing, $\langle R,\mathrm{Ric}^*A\rangle=\tfrac14\sum_{ijkl}R_{ijkl}\big(A_{ik}\delta_{jl}-A_{il}\delta_{jk}-A_{jk}\delta_{il}+A_{jl}\delta_{ik}\big)=\sum_{ik}A_{ik}\mathrm{Ric}(R)_{ik}$, matching the record's "$H=h\wedge2\,\mathrm{id}$, eigenvalues $h_i+h_j$". So $\mathrm{Ric}^*\mathrm{Ric}(R)=2\big(R+R\#I-3\,\mathrm{Alt}(R)\big)$ and step 6 is **correct as written**.

**Hazard 1, two $\wedge$ conventions now coexist in [ATTEMPTS.md](../ATTEMPTS.md).** The new section writes $\mathrm{Ric}(R)\wedge\mathrm{id}$ (Böhm–Wilking, half) and the $L16$ section three paragraphs above writes $h\wedge2\,\mathrm{id}$ (full). They differ by a factor of two and the section does not say so. *Anyone who reads the box and substitutes it into a formula stated in the other convention is off by two.*

**Hazard 2, $\mathrm{Alt}(\lvert W\rvert)$ is not the record's defect.** The record's $\delta^2=\lVert\mathrm{Alt}(W_-)\rVert^2$ ([results.md](../results.md), [problem.md](../findings/problem.md)). Since $W$ is Weyl, $\mathrm{Alt}(W)=0$, so $\mathrm{Alt}$ of the two spectral parts are equal up to sign and $\mathrm{Alt}(\lvert W\rvert)=\pm2\,\mathrm{Alt}(W_-)$. Hence
$$\lVert\mathrm{Alt}(\lvert W\rvert)\rVert^2=4\,\delta^2 .$$
**The section's closing remark that the constant $3$ "sits beside Result 2's $\tfrac32$-Gram and $\mathop{\mathrm{tr}}D=6\lVert\mathrm{Alt}\rVert^2$, which is where a successor should look for the cancellation" is therefore an invitation to compare three constants that are stated at three different arguments.** A successor chasing that cancellation must carry the factor $4$; the section does not warn them.

## Novelty, refuted: the box is Lemma L15 polarised

[Lemma L15](../findings/problem.md), on the record with two independent proofs and a numerical verification, reads
$$\mathop{\mathrm{scal}}(R^2+R^\#)=\lVert\mathrm{Ric}(R)\rVert^2+6\lVert\mathrm{Alt}(R)\rVert^2\qquad\text{for every symmetric }R .$$

**It is the quadratic form of the boxed identity, and the two are equivalent.** Using $\mathop{\mathrm{scal}}(S)=2\mathop{\mathrm{tr}}(S)$, stated in [ATTEMPTS.md](../ATTEMPTS.md) itself, and Huisken's symmetry of $\mathrm{tri}$, which gives $\mathop{\mathrm{tr}}(R^\#)=\mathrm{tri}(R,R,I)/2-\mathop{\mathrm{tr}}(R^2)=\langle R\#I,R\rangle$ with no Bianchi hypothesis:
$$\mathop{\mathrm{scal}}(R^2+R^\#)=2\mathop{\mathrm{tr}}(R^2)+2\mathop{\mathrm{tr}}(R^\#)=2\big\langle R+R\#I,\;R\big\rangle .$$
Substituting the box, $R+R\#I=\tfrac12\mathrm{Ric}^*\mathrm{Ric}(R)+3\,\mathrm{Alt}(R)$, returns L15 exactly. **And the converse holds too**: L15 says $\langle MR,R\rangle=0$ for $M:=\mathrm{Ric}^*\mathrm{Ric}+6\,\mathrm{Alt}-2(\mathrm{Id}+\#I)$, every summand of which is self-adjoint, $\mathrm{Alt}$ because it is an orthogonal projection, $\#I$ because $\langle R\#I,S\rangle=\tfrac12\mathrm{tri}(R,I,S)$ is totally symmetric, so $M=0$. *A self-adjoint operator is determined by its quadratic form; L15 and the box are the same statement.*

**The record had already taken this step.** [bounds.md:15](../findings/bounds.md#L15) and [results.md:332](../results.md#L332) both list "**the polarized identity of Lemma L15**" among the four ingredients of the compressed-criticality bound, and [ATTEMPTS.md](../ATTEMPTS.md)'s five-step proof of the graded half names "the polarized $\mathop{\mathrm{scal}}$ identity" as its final step. So the polarisation is not merely available, it is already an instrument in a proof the record holds.

**The screen that missed it was the wrong kind.** The section reports screening "by mechanism against [INDEX-traps.md](../findings/INDEX-traps.md) first (no post fences the $J_5$ grant) then by expression, nothing found." The mechanism screen was run against the trap index only; the match is in [findings/problem.md](../findings/problem.md), and it is invisible to an expression screen because L15 is written in $\mathop{\mathrm{scal}}$ and norms while the box is written in $\wedge\mathrm{id}$ and $\#I$. *This is the same failure the section's own neighbouring entry diagnoses, "five proposals this session turned out to be on the record already, in different notation each time", occurring a sixth time in the section that diagnoses it.*

## What is genuinely new, and where it belongs

**$T=2(\#I)$ is not on the record**, and it is the useful half of the section. Its value is not the box; it is that it **connects [isotropy-cap.md](../findings/isotropy-cap.md) to [Böhm–Wilking Lemma 2.1](../references/boehm-wilking-2008-space-forms/notes.md), two files the record notes do not cite each other**:

- **[Lemma L36](../findings/isotropy-cap.md)'s load-bearing eigenvalue is Böhm–Wilking's.** The record says "the whole content is one eigenvalue", that $\mathrm{Weyl}_n$ is exactly $T$'s $-2$ eigenspace, its only negative one. Under $T=2(\#I)$ that statement **is** $W\#I=-W$, i.e. Lemma 2.1's kernel clause. The $\lfloor n^2/4\rfloor$ cap rests on a published identity the record already holds and cites elsewhere.
- **The isotropy quantity is a sharp-product trace.** $\mu(\mathfrak m)=\langle T(P),P\rangle=2\langle P\#I,P\rangle=2\mathop{\mathrm{tr}}(P^\#)$ for $P$ the orthogonal projection onto $\mathfrak m$. So Lemma L36's bracket mass is $2\mathop{\mathrm{tr}}(\Pi_{\mathfrak m}^\#)$, and the whole cap argument is available inside the $\#$-calculus.
- **The $T$ eigenvalue table becomes proven rather than measured**, by the Casimir computation in step 4 above, at every $n$ rather than at $n=4,\dots,7$.

**Recommended disposition.** Record $T=2(\#I)$ and the two consequences above in [isotropy-cap.md](../findings/isotropy-cap.md) with a cross-reference to the Böhm–Wilking notes. Record the box, if at all, in [problem.md](../findings/problem.md) **as the operator form of Lemma L15**, not as a new correction, with the $\lVert\mathrm{Alt}(\lvert W\rvert)\rVert^2=4\delta^2$ conversion and the $\wedge$-convention warning attached. **Strike the claim that it gives $L16$(a) something Bianchi-free that the record lacked**: [ATTEMPTS.md](../ATTEMPTS.md)'s Result 7 already records that Lemma 3.2.4's Bianchi input "extends to every symmetric $R$ because $\Lambda^4\perp\langle I\rangle\oplus\langle\mathrm{Ric}_0\rangle$ and $\mathrm{Ric}$ annihilates $\Lambda^4$", which is step 3, in the record, a year of sections earlier.

## Nothing here needed a run

Every verdict above is closed form. The three routes to $c_4=2$ are a Casimir eigenvalue, an explicit $6\times6$ trace at $n=4$, and a one-line pairing against a lemma already proven, so no screen was taken and none was needed. *If a successor wants independent confirmation, the cheapest decisive check is $\lVert T(R)-2(R\#I)\rVert$ at a single random symmetric $R$ on $\Lambda^2\mathbb R^6$ with a nonzero $\Lambda^4$ component; it would confirm the operator identity rather than the three eigenvalues already known, and a nonzero result would refute step 4's conclusion as well as its argument. That run is not opened here.*

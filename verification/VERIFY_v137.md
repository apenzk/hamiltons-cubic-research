# VERIFY v137, L23: the closed form $\theta=\tfrac2n\sqrt{rN/(N-r)}$, the companion $S_{\mathfrak{mmm}}$, the cap $r\le n(n-2)/4$, and the claim that equality is exactly $S_{\mathfrak{mmm}}=0$

**Standfirst.** Cold brief on [ROUND_L23.md](ROUND_L23.md), whose quoted text is [ungraded-slack.md](../findings/ungraded-slack.md):124–150. **No numerical work was done: no script was run, and every value below is an exact hand evaluation**, either a rational or a surd carried in closed form. Log: [agent_logs/verify-L23-v137.log](../agent_logs/verify-L23-v137.log). This verifier read no other verifier's report.

## Claim table

| # | Claim, as the block states it | Verdict |
|---|---|---|
| C1 | The two scalar trace equations are the traces of $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$ against $\Pi_{\mathfrak h}$ and $\Pi_{\mathfrak m}$ | **CORRECT** |
| C2 | $S_{\mathfrak{hhh}}+S_{\mathfrak{hmm}}=\kappa r$ and $2S_{\mathfrak{hmm}}+S_{\mathfrak{mmm}}=\kappa(N-r)$, $\kappa=2(n-2)$ | **CORRECT** |
| C3 | The elimination gives $S_{\mathfrak{hmm}}=2\sigma r(N-r)/N$ and $\theta=\sigma ur/(N-r)$, $\sigma=n-1$ (and is **forced** | **CORRECT), the $2\times2$ system is nonsingular for $0<r<N$** |
| C4 | $\theta=\tfrac2n\sqrt{rN/(N-r)}$ | **CORRECT**, given $c>0$ |
| C5 | $S_{\mathfrak{mmm}}=(N-r)\big[2(n-2)-\tfrac{4(n-1)r}N\big]$ | **CORRECT** |
| C6 | $S_{\mathfrak{mmm}}\ge0$ gives $r\le n(n-2)/4$ | **CORRECT** |
| C7 | $\theta\le\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ | **CORRECT, but the monotonicity of $\theta$ in $r$ is used and not stated in this proof** |
| C8 | Equality in either place exactly when $S_{\mathfrak{mmm}}=0$, and the two equality cases coincide | **CORRECT** |
| C9 | $S_{\mathfrak{mmm}}=0\iff[\mathfrak m,\mathfrak m]\subseteq\mathfrak h\iff W_{\mathfrak h}$ $\mathbb Z_2$-graded $\iff(\mathfrak{so}(n),\mathfrak h)$ a symmetric pair | **CORRECT, with the ingredient attached to the wrong arrow, and the pointer for "graded" unresolvable inside the file** |
| C10 | For $n$ even the equality case is $\mathfrak h=\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ **alone**, $n=8$ included | **HYPOTHESIS-DEBT, rests on Cartan's classification of the symmetric pairs of $\mathfrak{so}(n)$, which [references/](../references/) does not hold** |
| C11 | For $n$ odd the cap is not an integer and the inequality is strict | **CORRECT** |
| C12 | "**What the hypotheses exclude is the Berger list**", with the stated list of cap-exceeders | **CORRECT ONLY UNDER A CHARITABLE READING, $\mathfrak{sp}(m)$ is absent, and $\mathfrak{sp}(m)\oplus\mathfrak{sp}(1)$ is below the cap for $m\ge3$** |
| C13 | "only $\mathfrak g_2$ and $\mathfrak{spin}(7)$ are excluded by the $4$-form" | **CORRECT ONLY UNDER A CHARITABLE READING, $\mathfrak{sp}(2)\subset\mathfrak{so}(8)$ is below the cap and has $(\Lambda^4)^K\ne0$** |
| C14 | $(\Lambda^4\mathbb R^n)^K=0$ for $\mathfrak{so}(n-1)$ **and every unbalanced split** | **CONCLUSION CORRECT, REASON UNDER-COVERS, the displayed branching is the $q=1$ case only** |
| C15 | $W_{\mathfrak h}$ at the cap is the Weyl operator of $S^{n/2}\times S^{n/2}$ | **CORRECT, ASSERTED WITHOUT ITS ONE-LINE CHECK** |
| C16 | [results.md](../results.md):134's one-line form of L23 | **BROKEN AS WRITTEN, the criticality hypothesis is gone, and without it the cap is false** |
| C17 | [Lemma L4](../findings/ungraded-slack.md)'s display of the same closed form | **BROKEN AS WRITTEN, same missing hypothesis; refuted by hand at $\mathfrak{so}(5)\subset\mathfrak{so}(6)$** |

**One line.** The theorem and its proof are correct and I rebuilt both from the definitions, including two exact hand checks at genuine members ($\mathfrak t\subset\mathfrak{so}(4)$ and $\mathfrak t\subset\mathfrak{so}(6)$) and one at a non-member that refutes the hypothesis-free reading; what fails is beside the theorem, the identification clause imports an unread classification, and the two places the record re-states the lemma in one line both drop the hypothesis that carries it.

**Verdict: PROVEN, hypotheses corrected**, for everything through C9 and C11; **HYPOTHESIS-DEBT** confined to C10, named exactly in §5.

## 0. Conventions, fixed once

Read from [conventions.md](../findings/conventions.md), not from memory.

- $\Lambda^2\mathbb R^n=\mathfrak{so}(n)$, $N=\binom n2$, with $\{\varphi_a\}$ an **orthonormal basis of $\Lambda^2$**; $\lVert W\rVert^2=\mathop{\mathrm{tr}}_{\Lambda^2}(W^2)=1$ at a unit operator.
- $Q(W)=W^2+W^\#$ with $\#$ the **halved** Böhm–Wilking product, $vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$ ([conventions.md](../findings/conventions.md):59). So for $W=\sum_\alpha\lambda_\alpha v_\alpha v_\alpha^{\mathsf T}$ in an orthonormal eigenbasis, $(W^\#)_{\gamma\gamma}=\tfrac12\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta T_{\alpha\beta\gamma}$ with $T_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle^2$. **This is the identity every trace below runs on.**
- $T$ is **totally symmetric**, because $\langle[x,y],z\rangle$ is totally antisymmetric under an invariant form and the square kills the sign. Every "$S_{\mathfrak{hmm}}$" is therefore a well-defined sum over ordered triples with a fixed index pattern, and the three patterns with two $\mathfrak m$'s agree.
- The **Killing row marginal** is [Lemma L153](../findings/bounds.md), quoted rather than reproved: $\sum_\beta\lVert[v,v_\beta]\rVert^2=2(n-2)\lVert v\rVert^2$, i.e. $\sum_{b,c}T_{abc}=2(n-2)=\kappa$ per unit $a$ in the **ordered** reading, the reading [conventions.md](../findings/conventions.md):100 warns must be converted before constants are compared. The block's $\kappa$ is the ordered one, consistently.
- The **Killing constant of a subalgebra** $\mathfrak g\subseteq\mathfrak{so}(n)$, used only in §6: $\sum_{b\in\mathfrak g}\lVert[a,b]\rVert^2=c_{\mathfrak g}\lVert a\rVert^2$ with $c_{\mathfrak g}=2h^\vee/I$, $I$ normalised so the $\mathfrak{so}(n)$ vector representation has index $1$, which is exactly what makes $c_{\mathfrak{so}(n)}=2(n-2)=\kappa$.
- $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$, derived at [problem.md](../findings/problem.md) from cone invariance at $a=0$, not read off the sphere products.

## 1. The hypothesis inventory

**Carried by the statement.**

| # | Hypothesis | Used where |
|---|---|---|
| H1 | $\mathfrak h\subseteq\mathfrak{so}(n)$ is a **subalgebra** | Twice, and essentially: it kills the $\mathfrak{hhm}$ index pattern, which is what makes the two trace equations close on three $S$'s and what makes the two Killing relations hold |
| H2 | $\mathfrak m=\mathfrak h^\perp$, the orthogonal complement in $\Lambda^2$ | Definition of the splitting; also the step $[\mathfrak m,\mathfrak m]\perp\mathfrak m\Rightarrow[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$ |
| H3 | $0<r<N$ | Three times: $u\ne0$, $v\ne0$, and $u\ne v$, the last is what makes the elimination's determinant nonzero |
| H4 | $W_{\mathfrak h}$ is the **unit-norm** multiple of $\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$ | Fixes $c=\sqrt{N/(r(N-r))}$, hence the scale of $\theta$. Without it $\theta$ scales linearly and the closed form is meaningless |
| H5 | $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$ | Everything. It is the only source of the two scalar equations; §6 exhibits a subalgebra where the closed form is false without it |

**Used by the proof and not carried by the statement.**

| # | Hypothesis | Status |
|---|---|---|
| H6 | $c>0$, i.e. $u>0$ on $\mathfrak h$ and $v<0$ on $\mathfrak m$ | **Missing.** "The unit-norm multiple" names two operators, $\pm W_{\mathfrak h}$. $Q$ is even and $\theta$ is odd ($Q(-W)=Q(W)=-\theta(-W)$) so the $c<0$ branch has eigenvalue $-\tfrac2n\sqrt{rN/(N-r)}$ and the displayed sign is false there. The proof line "$u=c(1-r/N)>0$" fixes the branch silently. *This is not a pedantic point on this record*: [ATTEMPTS.md](../ATTEMPTS.md):2434 records a cycle lost to exactly this flip, where $S$ was measured on $-W$ and $\mathfrak h,\mathfrak m$ swapped with it |
| H7 | $\theta$ is strictly increasing in $r$ at fixed $n$ | **Used, unstated in this proof.** The block evaluates $\theta$ *at* $r=n(n-2)/4$ and calls it the cap; getting from $r\le n(n-2)/4$ to $\theta\le\theta_0(n)$ needs monotonicity. It is true and immediate ($\theta^2=\tfrac{4N}{n^2}\cdot\tfrac r{N-r}$ with $r\mapsto r/(N-r)$ strictly increasing on $[0,N)$), it is stated in the [Lemma L4](../findings/ungraded-slack.md) block above, and it is **machine-checked**, [lean/INDEX.md](../lean/INDEX.md):151 records $\theta^2$ proved strictly increasing in $r$ in [L105.lean](../lean/HamiltonsCubic/Results/L105.lean). So the step is on the record; it is not in this proof |

**Not used, and worth saying so because a reader expects them.** Ricci-flatness of $W_{\mathfrak h}$, the first Bianchi identity, $W_{\mathfrak h}\in\mathcal W_n$, $\mathfrak h$ irreducible, $\mathfrak h$ semisimple, $\mathfrak h\not\cong\mathfrak m$, any bound on $n$, and every one of the three member-producing conditions. The derivation is pure structure-constant bookkeeping against H1–H5. **No finding: the statement carries no hypothesis the proof leaves idle, apart from the ones just listed being absent rather than idle.**

**Imported results, each checked against the object it applies to.**

| Import | Applied to | Verdict |
|---|---|---|
| [Lemma L153](../findings/bounds.md), the row marginal | Each unit basis vector of $\Lambda^2\mathbb R^n$ | **Legitimate.** L153 is stated for any $v\in\mathfrak{so}(n)$ at any $n\ge2$, so applying it at basis vectors is inside its scope, and the ordered reading is the one used |
| The halved $\#$ and its structure-constant form | $W_{\mathfrak h}$, a symmetric operator on $\Lambda^2$ | **Legitimate**, and it needs no Weyl hypothesis |
| Cartan's classification of the symmetric pairs of $\mathfrak{so}(n)$ | Clause C10 only | **Unread source.** [references/](../references/) holds no Cartan and no Helgason entry; the record says so itself at [LEDGER.md](../findings/LEDGER.md):1284, and item 7 of its own to-do list asks for the folder. See §5 |
| [trap W2](../findings/INDEX-traps.md), the $n=8$ triality additions | Clause C10 at $n=8$ | **On file and adequate**, and better than the block's own use of it. See §5 |

## 2. Question 1, does the closed form follow? Yes; here it is in full

### 2.1 The two trace equations are what the block says they are

Write $\lambda_a=u$ for $a\in\mathfrak h$ and $\lambda_a=v$ for $a\in\mathfrak m$, and use the $\#$ identity of §0. For $c\in\mathfrak h$,

$$(Q W)_{cc}=u^2+\tfrac12\sum_{a,b}\lambda_a\lambda_bT_{abc}.$$

Split the inner sum by where $a,b$ sit. The pattern $a\in\mathfrak h,b\in\mathfrak m,c\in\mathfrak h$ contributes $T_{abc}=\langle[\varphi_a,\varphi_b],\varphi_c\rangle^2$ with $\langle[\mathfrak h,\mathfrak m],\mathfrak h\rangle=-\langle\mathfrak m,[\mathfrak h,\mathfrak h]\rangle=0$ by invariance and H1, so it vanishes. Summing over $c\in\mathfrak h$ and dividing by $r$,

$$u^2+\frac1{2r}\big(S_{\mathfrak{hhh}}u^2+S_{\mathfrak{hmm}}v^2\big)=\theta u .$$

For $c\in\mathfrak m$ the pattern $a,b\in\mathfrak h$ vanishes for the same reason, the two mixed patterns each give $uv\,S_{\mathfrak{hmm}}$, and dividing by $N-r$,

$$v^2+\frac1{2(N-r)}\big(2S_{\mathfrak{hmm}}uv+S_{\mathfrak{mmm}}v^2\big)=\theta v .$$

**Both are the block's, character for character.** The factor $2$ on $S_{\mathfrak{hmm}}$ in the second and its absence in the first is the count of mixed orderings, correct in each.

### 2.2 The two Killing relations

Sum $\sum_{b,c}T_{abc}=\kappa$ over $a\in\mathfrak h$: the $bc$-patterns are $\mathfrak{hh}$ giving $S_{\mathfrak{hhh}}$, $\mathfrak{hm}$ and $\mathfrak{mh}$ each vanishing by H1, $\mathfrak{mm}$ giving $S_{\mathfrak{hmm}}$. Hence $S_{\mathfrak{hhh}}+S_{\mathfrak{hmm}}=\kappa r$. Sum over $a\in\mathfrak m$: $\mathfrak{hh}$ vanishes, $\mathfrak{hm}$ and $\mathfrak{mh}$ each give $S_{\mathfrak{hmm}}$, $\mathfrak{mm}$ gives $S_{\mathfrak{mmm}}$. Hence $2S_{\mathfrak{hmm}}+S_{\mathfrak{mmm}}=\kappa(N-r)$. **Both correct.**

### 2.3 The elimination, and that it is forced

Substitute the two relations, put $X=S_{\mathfrak{hmm}}$ and $\sigma=1+\kappa/2=n-1$, and divide the first by $u\ne0$ and the second by $v\ne0$:

$$\theta+X\,\frac{(u-v)(u+v)}{2ru}=\sigma u,\qquad\qquad \theta-X\,\frac{u-v}{N-r}=\sigma v .$$

This is a linear $2\times2$ system in $(\theta,X)$ with determinant

$$-\frac{u-v}{N-r}-\frac{(u-v)(u+v)}{2ru}=-(u-v)\Big[\frac1{N-r}+\frac{u+v}{2ru}\Big].$$

With $u=c(N-r)/N$ and $v=-cr/N$ one has $u-v=c$ and $u+v=c(N-2r)/N$, so

$$\frac1{N-r}+\frac{u+v}{2ru}=\frac{2r}{2r(N-r)}+\frac{N-2r}{2r(N-r)}=\frac N{2r(N-r)}>0 .$$

The determinant is $-cN/(2r(N-r))\ne0$ for every $0<r<N$ and $c\ne0$. **So the solution is unique, the elimination is forced, not one solution among several.** Note the bracket is positive even when $u+v<0$, i.e. when $r>N/2$; no case split is needed.

Solving: $\sigma=X\cdot N/(2r(N-r))$, i.e.

$$\boxed{S_{\mathfrak{hmm}}=\frac{2\sigma r(N-r)}N}$$

and then $\theta=\sigma v+\dfrac X{N-r}(u-v)=-\dfrac{\sigma cr}N+\dfrac{2\sigma cr}N=\dfrac{\sigma cr}N$, which is the block's $\theta=\sigma ur/(N-r)$ since $u=c(N-r)/N$. **Both display lines confirmed.**

### 2.4 The constant, and which normalisations it depends on

$\lVert W\rVert^2=ru^2+(N-r)v^2=\dfrac{c^2r(N-r)}{N^2}\big[(N-r)+r\big]=\dfrac{c^2r(N-r)}N$. Setting this to $1$ and taking $c>0$ (H6) gives $c=\sqrt{N/(r(N-r))}$, so

$$\theta=\frac{\sigma cr}N=(n-1)\sqrt{\frac r{N(N-r)}}=\frac{n-1}N\sqrt{\frac{rN}{N-r}}=\frac2n\sqrt{\frac{rN}{N-r}},$$

the last step being $(n-1)/N=2/n$ exactly. **C4 confirmed.** Back-substitution into the second Killing relation gives

$$S_{\mathfrak{mmm}}=\kappa(N-r)-2S_{\mathfrak{hmm}}=2(n-2)(N-r)-\frac{4(n-1)r(N-r)}N=(N-r)\Big[2(n-2)-\frac{4(n-1)r}N\Big].$$

**C5 confirmed.**

**Which normalisations the constants depend on, four, and one of them is load-bearing in a way the block does not flag.**

1. **$\lVert W\rVert=1$ in the $\Lambda^2$ Frobenius norm.** It fixes $c$ and so the whole scale of $\theta$. Under the $\sqrt2$-shifted reading of the norm that [conventions.md](../findings/conventions.md):130 warns about, $\theta$ moves.
2. **The halved $\#$.** The $\tfrac12$ in $(W^\#)_{\gamma\gamma}=\tfrac12\sum\lambda_\alpha\lambda_\beta T_{\alpha\beta\gamma}$ is what puts the $\tfrac1{2r}$ and $\tfrac1{2(N-r)}$ in the trace equations. [conventions.md](../findings/conventions.md):59 records that under the other $\#$ in circulation an identity of this shape becomes *false rather than rescaled*.
3. **The ordered reading of the row marginal**, $\kappa=2(n-2)$ rather than $n-2$.
4. **And the one that binds them: $\sigma=1+\kappa/2$ adds a $1$ coming from $W^2$ (normalisation-free), to a $\kappa/2$ coming from $\#$ and the bracket.** So the identification $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$ cannot be rescaled independently of the norm: rescaling the bracket by $t$ scales $\kappa$ by $t^2$ and leaves the $1$ alone, and $\sigma$ is no longer $n-1$. The block states $\kappa$ and the $\#$ convention but never says that the two must be in the *same* identification for $\sigma=1+\kappa/2$ to mean anything. That the whole thing then lands on $\theta_0(n)$ at the cap, a constant derived independently at [problem.md](../findings/problem.md) from cone invariance, is the strongest available check that the conventions are mutually consistent, and it passes.

## 3. Question 2, the cap, the two inequalities separately, and the equality locus

### 3.1 $r\le n(n-2)/4$

$S_{\mathfrak{mmm}}$ is a sum of squares of real numbers, so $S_{\mathfrak{mmm}}\ge0$. Since $N-r>0$ by H3, the closed form gives $2(n-2)\ge 4(n-1)r/N$, i.e.

$$r\le\frac{2(n-2)N}{4(n-1)}=\frac{(n-2)}{2(n-1)}\cdot\frac{n(n-1)}2=\frac{n(n-2)}4 .$$

**C6 confirmed**, and the only inputs are H1–H5 plus non-negativity. Note where the hypotheses bite: it is $S_{\mathfrak{mmm}}$ *as computed from the eigen-equation* that is being bounded below by the sum of squares, the inequality is a consistency condition between the eigen-equation and the genuine bracket data, not a bound on subalgebras.

### 3.2 $\theta\le\theta_0(n)$, a separate step, and it needs H7

$\theta^2=\dfrac{4N}{n^2}\cdot\dfrac r{N-r}$, and $r\mapsto r/(N-r)$ is strictly increasing on $[0,N)$, so $\theta$ is strictly increasing in $r$. At $r=n(n-2)/4$,

$$N-r=\frac{n(n-1)}2-\frac{n(n-2)}4=\frac{2n(n-1)-n(n-2)}4=\frac{n^2}4,$$

exactly as the block says, and

$$\theta=\frac2n\sqrt{\frac{\frac{n(n-2)}4\cdot\frac{n(n-1)}2}{\frac{n^2}4}}=\frac2n\sqrt{\frac{(n-1)(n-2)}2}=\frac{\sqrt{2(n-1)(n-2)}}n=\theta_0(n).$$

**C7 confirmed.** The monotonicity is the step the proof performs without naming; see H7. It is on the record twice over, so this is a completeness defect in the proof text, not a gap in the mathematics.

### 3.3 The two equality cases coincide

- Equality in the cap $\iff$ $2(n-2)=4(n-1)r/N$ $\iff$ $S_{\mathfrak{mmm}}=(N-r)\cdot0=0$, using $N-r>0$ in both directions. So **equality in $r\le n(n-2)/4$ is exactly $S_{\mathfrak{mmm}}=0$**.
- Equality in $\theta\le\theta_0(n)$ $\iff$ $r=n(n-2)/4$, by the *strict* monotonicity of §3.2.

The two therefore coincide, both being $r=n(n-2)/4$, and both are $S_{\mathfrak{mmm}}=0$. **C8 confirmed.** The block's "equality in either place" is exactly right and the "either" is doing real work: the two are separate inequalities with a shared equality locus, and the second one's equality case is only pinned because the monotonicity is *strict*.

### 3.4 The characterisation of the locus

$S_{\mathfrak{mmm}}=\sum_{a,b,c\in\mathfrak m}\langle[\varphi_a,\varphi_b],\varphi_c\rangle^2$ is a sum of squares, so it vanishes iff every term does, iff $[\mathfrak m,\mathfrak m]\perp\mathfrak m$, iff $[\mathfrak m,\mathfrak m]\subseteq\mathfrak m^\perp=\mathfrak h$. Then with $\sigma_\pm=+1$ on $\mathfrak h$, $-1$ on $\mathfrak m$: the three bracket rules $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$ (H1), $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$ (H1 plus invariance) and $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$ make $\sigma_\pm$ an involutive automorphism of $\mathfrak{so}(n)$ with fixed set exactly $\mathfrak h$, so $(\mathfrak{so}(n),\mathfrak h)$ is a symmetric pair. Conversely a symmetric pair has $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$, hence $S_{\mathfrak{mmm}}=0$. **The chain closes in both directions. C9's mathematics is right.**

**Two defects in how C9 is written, neither touching the mathematics.**

**(a) The ingredient is attached to the wrong arrow.** The block writes: *"**The one arrow needing an argument is $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$**: the others are definitions, and this one uses $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$, which holds because $\mathfrak h$ is a subalgebra and the form is invariant."* The arrow $S_{\mathfrak{mmm}}=0\Rightarrow[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$ uses **only** $\mathfrak h=\mathfrak m^\perp$; $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$ plays no part in it. Where that ingredient is genuinely needed is (i) two paragraphs earlier, in the trace equations, where it kills the $\mathfrak{hhm}$ pattern, and (ii) in the *next* arrow, to a symmetric pair. **Charitable reading, which I accept:** "this one" refers forward to the symmetric-pair conclusion rather than back to the named arrow, and under that reading the sentence is true. It is still the case that a reader following the sentence as written attaches a correct fact to a step that does not use it, and does not learn that the trace equations depend on it.

**(b) "$\mathbb Z_2$-graded in the sense settled elsewhere in this file" cannot be resolved inside the file.** The senses are settled in [graded-half.md](../findings/graded-half.md):280–302, which distinguishes **(A) sign-graded**, **(B) slice-graded** in two inequivalent readings, and **(C) pair-graded**, and states that (A) and (C) are **incomparable**, with $\mathbb{CP}^2$ in (C) and not (A). Inside [ungraded-slack.md](../findings/ungraded-slack.md) the only appearance of the three grading conditions is at line 322, inside a *review note on a different lemma*, as (F1) $[E_+,E_+]\perp E_-$, (F2) $[E_+,E_-]\subseteq E_-$, (F3) $[E_-,E_-]\perp E_-$. **The claim survives every sense, which is why this is a legibility defect rather than an error**: on this family $E_+=\mathfrak h$ and $E_-=\mathfrak m$, (F1) and (F2) hold by H1, (F3) is exactly $S_{\mathfrak{mmm}}=0$, so (A) holds iff $S_{\mathfrak{mmm}}=0$; (C) is the symmetric-pair clause already proved; and (B) holds at the cap with $\sigma=\mathrm{diag}(I_{n/2},-I_{n/2})$. [graded-half.md](../findings/graded-half.md):302 states independently that the three coincide on this family, "where $W$ is projector-like". **But a consumer of the L23 block alone cannot establish any of that**, and the file it is pointed at is the wrong one.

**(c) A label collision inside the block's own file.** "(F1), (F2), (F3)" denote the three *member-producing* conditions at [ungraded-slack.md](../findings/ungraded-slack.md):96 and the three *grading* conditions at line 322. The L23 block then writes "**they fail (F2) instead**" (meaning $(\mathrm{Sym}^2\mathbb R^n)^K=\mathbb R\,\mathrm{Id}$, the line-96 sense), **while its own "Producing members" paragraph never labels its three conditions at all**. Read alone, as a consumer reads it, "(F2)" in the L23 block is undefined, and the nearest definition in the same file is the other one.

## 4. Question 3, what the family requires of $\mathfrak h$, and the edges of every range

The full list is §1. Restated as an answer to the question: the derivation asks of $\mathfrak h$ **exactly two things** (that it be closed under the bracket (H1) and that its dimension satisfy $0<r<N$ (H3)), plus two things about the *operator* rather than the algebra: unit norm with a sign (H4, H6) and the eigen-equation (H5). **It asks nothing about irreducibility, semisimplicity, $\mathfrak m$, or $n$.** The statement carries H1–H5 and does not carry H6 or H7.

**Quantifier order.** The statement is $\forall n\,\forall\mathfrak h\,[\,\text{H1–H4}\wedge\exists\theta\,(QW_{\mathfrak h}=\theta W_{\mathfrak h})\Rightarrow(\text{closed form}\wedge\text{cap}\wedge\text{equality case})\,]$. The "exactly when" of the equality clause sits **inside** the conditional, quantified over members only. **This is the correct order and the block gets it right**, the same block records, in its own withdrawal note, that reading the cap as an unconditional Lie-theoretic dimension bound is false and withdrawn. §6 exhibits the witness for that: $\mathfrak{so}(n-1)$ has $r=\binom{n-1}2>n(n-2)/4$ for every $n\ge5$.

**The edges.**

| Edge | What happens |
|---|---|
| $r\to0$ | Excluded by H3, and it must be: at $r=0$, $\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}=0$ has no unit multiple, so H4 is vacuous and $\theta$ undefined. The formula's value $\theta\to0$ is not a limit of anything |
| $r\to N$ | Excluded by H3, same reason ($\mathfrak h=\mathfrak{so}(n)$ gives $W=0$). The closed form diverges as $r\to N$, and the cap is what forbids members near that end |
| $r=1$, $\mathfrak h$ abelian | Consistent with the statement and empty in fact for $n\ge3$: §6.3 shows a member needs $c_{\mathfrak h}=4r/n-2$, which at $c_{\mathfrak h}=0,r=1$ forces $n=2$ |
| $\mathfrak h$ abelian generally | Forces $r=n/2$ exactly; the maximal torus at even $n$ is the case, and §6.2 verifies it is a genuine member by hand at $n=4$ and $n=6$ |
| Smallest admissible $n$ | $n=2$: $N=1$ and no $r$ satisfies H3. $n=3$: cap $=3/4<1$, so no member; consistent, since $\mathfrak{so}(3)$ has no $2$-dimensional subalgebra and its $1$-dimensional ones fail the abelian condition. $n=4$: cap $=2$, and the maximal torus $=\mathfrak{so}(2)\oplus\mathfrak{so}(2)$ realises it. **The lemma is a general algebraic statement with no $n\ge12$ hypothesis, and none is needed** |
| $n$ odd | $n(n-2)$ is odd$\times$odd $=$ odd, so $n(n-2)/4\notin\mathbb Z$ and $r\le n(n-2)/4$ is $r<n(n-2)/4$; by the *strict* monotonicity of §3.2, $\theta<\theta_0(n)$. **C11 confirmed.** Symmetrically, $n(n-2)/4\in\mathbb Z$ for every even $n$: at $n\equiv0\ (4)$ from the factor $n$, at $n\equiv2\ (4)$ from $n(n-2)=4k(k-1)$ with $n=2k$ |
| $r>N/2$ | No case split needed; §2.3 shows the elimination's determinant keeps its sign through $u+v<0$. Vacuous in fact, since the cap gives $r\le n(n-2)/4<N/2$ for $n\ge3$ |

## 5. C10, the equality case is $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ "alone": what is proved and what is owed

**What the block proves.** Among the pairs $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ with $p+q=n$: $\binom p2+\binom q2=\tfrac{p^2+q^2-n}2$, and setting this to $\tfrac{n^2-2n}4$ gives $p^2+q^2=n^2/2$; with $p^2+q^2=\tfrac{n^2+(p-q)^2}2$ this forces $(p-q)^2=0$, so $p=q=n/2$. **Exact and correct.** And $\mathfrak u(m)\subset\mathfrak{so}(2m)$ has $r=m^2$ against a cap $\tfrac{2m(2m-2)}4=m(m-1)=m^2-m$, so $r$ misses the cap by $m$ for every $m\ge1$. **Exact and correct.** In the other direction $\mathfrak{so}(n/2)^{\oplus2}$ does have $r=2\binom{n/2}2=\tfrac n2(\tfrac n2-1)=\tfrac{n(n-2)}4$, so the cap is attained.

**What the block therefore needs, and does not have on file in [references/](../references/).** The two calculations are exhaustive only against a *list*: that every symmetric subalgebra of $\mathfrak{so}(n)$ is $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ or $\mathfrak u(n/2)$, plus the $n=8$ exceptions. That is **Cartan's classification of the involutive automorphisms of $\mathfrak{so}(n)$**, and the record states plainly that it has no source: [LEDGER.md](../findings/LEDGER.md):1284 (*"Cartan's classification is cited to no source anywhere), [references/](../references/) holds no Helgason or Cartan entry, and four findings files appeal to it bare"*, with item 7 of the same ledger's to-do list asking for the folder, and the acquisition recorded as blocked on the user. I confirmed the absence directly: no folder in [references/](../references/) names Cartan, Helgason, or symmetric-space classification, and `grep` over [references/INDEX.md](../references/INDEX.md) for those terms returns nothing.

**So C10's verdict is HYPOTHESIS-DEBT, and what would have to be shown is exactly this:** *every subalgebra $\mathfrak h\subset\mathfrak{so}(n)$ that is the fixed set of an involutive automorphism, taken up to $SO(n)$-conjugacy, appears in the list $\{\mathfrak{so}(p)\oplus\mathfrak{so}(q)\}\cup\{\mathfrak u(n/2)\}$ for $n\ne8$, and that list plus $\mathfrak{spin}(7)$ and $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$ at $n=8$.* Nothing weaker will do, because the argument is an exhaustion over the list.

**The $n=8$ clause, checked separately, and the block's own reason is weaker than the record's.** The block argues: triality adds $\mathfrak{spin}(7)$ at $21$ and $\mathfrak{sp}(1)\oplus\mathfrak{sp}(2)$ at $13$, and $21,13\ne12$. That is sound **given** that those are the only additions, which is what [trap W2](../findings/INDEX-traps.md) and the table at [graded-half.md](../findings/graded-half.md):404–411 assert. But the concern the record raises about Cartan is precisely that the classification is up to $\mathrm{Aut}(\mathfrak{so}(n))$ while the lemma consumes $SO(n)$-conjugacy ([LEDGER.md](../findings/LEDGER.md):1268), so an argument that reads dimensions off an $\mathrm{Aut}$-list is arguing in the register that the caveat is about. **The record holds the right argument, and it is not in this block**: [LEDGER.md](../findings/LEDGER.md):1272, *"$\mathrm{Ad}(\mathrm{diag}(-1_4,1_4))$ has $\det=+1$ and is **inner**, so Cartan up to $\mathrm{Aut}$ already delivers $SO(8)$-conjugacy, where $\mathrm{Ad}(\mathrm{diag}(-1_3,1_5))$ has $\det=-1$ and is outer, **which is why dimension $12$ is safe and $13$ is not**."* I checked this independently and it is right: the dimension-$12$ involution of $\mathfrak{so}(8)$ is inner, and an inner class is a single $SO(8)$-class, so the balanced split is unique up to $SO(8)$ at $n=8$, which is what C10 needs and what the dimension count alone does not give. **No finding: the $n=8$ clause is true and the record can support it; the support sits in [LEDGER.md](../findings/LEDGER.md) under a different lemma's audit.**

**C15, in passing.** "the maximum over the family is attained exactly at the Weyl operator of $S^{n/2}\times S^{n/2}$" adds an identification the block asserts without checking: that $W_{\mathfrak{so}(n/2)^{\oplus2}}$ *is* that Weyl operator. It is true and the check is one line, the operator is diagonal in the $e_i\wedge e_j$ basis with $u$ on within-block and $v$ on cross-block pairs, and its Ricci row sum at $i$ in block one is $(m-1)u+mv=\tfrac cN\big[(m-1)m^2-m\cdot m(m-1)\big]=0$ with $m=n/2$, $r=m(m-1)$, $N-r=m^2$, so $W$ is Ricci-flat, diagonal hence Bianchi-free, and two-eigenvalue, which is the sphere product's Weyl operator. **Stated here because the block does not state it and the clause is what every consumer quotes.**

## 6. The universal claim, tried against one subalgebra from each structured family the record names

**Verifier's apparatus, declared as such.** To test membership I use one identity I derived for the purpose. It is a *restatement of the block's own necessary condition*, not a repair of anything, and it is used only to decide which candidate algebras can satisfy H5.

For an orthonormal basis of $\mathfrak g\subseteq\mathfrak{so}(n)$ and $X\in\mathfrak g$, ad-antisymmetry gives $\sum_{b\in\mathfrak g}\lVert[X,\varphi_b]\rVert^2=-\mathop{\mathrm{tr}}_{\mathfrak g}(\mathrm{ad}X)^2=-B_{\mathfrak g}(X,X)$, while $\lVert X\rVert^2_{\Lambda^2}=-\tfrac12\mathop{\mathrm{tr}}_{\mathbb R^n}(X^2)$ under $e_i\wedge e_j\leftrightarrow E_{ij}-E_{ji}$. Hence the subalgebra's own Killing constant is

$$c_{\mathfrak h}=\frac{2B_{\mathfrak h}(X,X)}{\mathop{\mathrm{tr}}_{\mathbb R^n}(X^2)},\qquad S_{\mathfrak{hhh}}=c_{\mathfrak h}r .$$

Sanity check on $\mathfrak g=\mathfrak{so}(n)$ itself, where $B(X,Y)=(n-2)\mathop{\mathrm{tr}}_{\mathbb R^n}(XY)$ per [conventions.md](../findings/conventions.md): $c=2(n-2)=\kappa$, agreeing with [Lemma L153](../findings/bounds.md). Combining $S_{\mathfrak{hhh}}=\kappa r-S_{\mathfrak{hmm}}$ with the block's $S_{\mathfrak{hmm}}=2(n-1)r(N-r)/N$ and $2(n-1)/N=4/n$ gives the **membership test**

$$c_{\mathfrak h}=\frac{4r}n-2 .$$

**It is necessary, never sufficient**, it is one trace of the eigen-equation, so it screens candidates out and never in.

### 6.1 $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$

**Balanced, $p=q=m=n/2$.** For $X$ in one block the other block commutes with it, so $c_{\mathfrak h}$ is the marginal inside $\mathfrak{so}(m)$, namely $2(m-2)$; the test wants $\tfrac{4m(m-1)}{2m}-2=2(m-2)$. **Passes**, and $r=m(m-1)=n(n-2)/4$ sits exactly at the cap, with $S_{\mathfrak{mmm}}=0$ since $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$ for the split. Consistent in every clause.

**Unbalanced.** These are symmetric pairs, so $S_{\mathfrak{mmm}}=0$ genuinely; by §3.3 the eigen-equation would then force $r=n(n-2)/4$, which by §5 forces $p=q$. **So every unbalanced split fails H5**, exactly as the block says ("a symmetric pair is critical only *at* the cap"). Checked directly at $q=1$: for $\mathfrak h=\mathfrak{so}(n-1)$, $S_{\mathfrak{mmm}}=0$ and the second Killing relation gives $S_{\mathfrak{hmm}}=\tfrac{\kappa(N-r)}2=(n-2)(n-1)$, while H5 demands $\tfrac{2(n-1)r(N-r)}N=\tfrac{2(n-1)^2(n-2)}n$. These agree only at $n=2$. **Fails, for every $n\ge3$.**

**And this is the witness for the quantifier point.** $\mathfrak{so}(n-1)$ has $r=\binom{n-1}2=\tfrac{(n-1)(n-2)}2$ against a cap of $\tfrac{n(n-2)}4$, a ratio of $2(n-1)/n>1$ for every $n\ge3$. So **the cap is false as a statement about subalgebras** and true as a statement about members, which is what the block's own withdrawal note records, and what [results.md](../results.md):134 loses (§7).

### 6.2 A maximal torus, and the only two exact hand verifications of the whole lemma in this report

Abelian $\mathfrak h$ has $c_{\mathfrak h}=0$, so the test reads $r=n/2$: **a maximal torus can be a member only at even $n$, where $r=\lfloor n/2\rfloor=n/2$ is exactly right.** It then also passes the second trace equation: $S_{\mathfrak{hmm}}=\kappa r=2(n-2)r$ and $S_{\mathfrak{mmm}}=\kappa(N-r)-2S_{\mathfrak{hmm}}=2(n-2)(N-3r)$, while the closed form at $r=n/2$ demands $\tfrac{4(n-1)r}N=4$, hence $(N-r)(2n-8)$; with $N=\tfrac{n(n-1)}2$ and $r=\tfrac n2$ both read $n(n-2)(n-4)$. **Agree identically.**

**$n=4$.** $\mathfrak h=\mathrm{span}(e_{12},e_{34})=\mathfrak{so}(2)\oplus\mathfrak{so}(2)$, $r=2$, $N=6$. Take $c=3$: $u=2$ on $\mathfrak h$, $v=-1$ on $\mathfrak m$. $W$ is diagonal in the $e_i\wedge e_j$ basis, so $\#$ acts by the diagonal formula $(W\#W)_{ij}=\sum_kw_{ik}w_{jk}$ of [problem.md](../findings/problem.md) and $Q(W)$ is again diagonal. Then $(W\#W)_{12}=w_{13}w_{23}+w_{14}w_{24}=2v^2=2$ and $(Q W)_{12}=u^2+2=6=3u$; $(W\#W)_{13}=w_{12}w_{32}+w_{14}w_{34}=2uv=-4$ and $(QW)_{13}=v^2-4=-3=3v$. **So $Q(W)=3W$ exactly, and this is a genuine member.** Unit-norm: $\lVert W\rVert^2=2u^2+4v^2=12$, so $\theta=3/\sqrt{12}=\sqrt3/2$. The closed form gives $\tfrac24\sqrt{\tfrac{2\cdot6}4}=\tfrac{\sqrt3}2$. **Equal.** And $r=2=n(n-2)/4$ is the cap, $\theta_0(4)=\sqrt{2\cdot3\cdot2}/4=\sqrt3/2$, **the cap, the closed form and $\theta_0$ all check against one another at one object, by hand.**

**$n=6$, off the cap and ungraded, the sharper test.** $\mathfrak h=\mathrm{span}(e_{12},e_{34},e_{56})$, $r=3$, $N=15$, cap $=6$. Take $c=5$: $u=4$, $v=-1$. Then $(W\#W)_{12}=\sum_{k=3,4,5,6}w_{1k}w_{2k}=4v^2=4$, so $(QW)_{12}=16+4=20=5u$; and $(W\#W)_{13}=w_{12}w_{32}+w_{14}w_{34}+w_{15}w_{35}+w_{16}w_{36}=uv+vu+v^2+v^2=-4-4+1+1=-6$, so $(QW)_{13}=1-6=-5=5v$. **$Q(W)=5W$ exactly.** Unit-norm: $\lVert W\rVert^2=3\cdot16+12=60$, $\theta=5/\sqrt{60}=\tfrac1{2}\sqrt{5/3}$. The closed form gives $\tfrac26\sqrt{\tfrac{3\cdot15}{12}}=\tfrac13\sqrt{15}/2=\tfrac1{2}\sqrt{5/3}$. **Equal.** $S_{\mathfrak{mmm}}$: by the abelian count $2(n-2)(N-3r)=8\cdot6=48$; by the block's closed form $(15-3)[8-\tfrac{4\cdot5\cdot3}{15}]=12\cdot4=48$. **Equal, and nonzero, so this is a member strictly inside the cap, strictly below $\theta_0(6)$, and ungraded.** The member is Ricci-flat (row sum $u+4v=0$) and Bianchi-free (diagonal), so it is a genuine Weyl critical point.

**This is the strongest single check in this report:** the closed form, the companion $S_{\mathfrak{mmm}}$ and the strictness of the cap all verified at one object away from the equality locus, with no numerical work.

### 6.3 $\mathfrak{su}(m)$, in both embeddings the record uses

**$\mathrm{ad}(\mathfrak{su}(3))\subset\mathfrak{so}(8)$, the bi-invariant member.** Here $\mathbb R^8=\mathfrak{su}(3)$ and $X$ acts as $\mathrm{ad}X$, so $\mathop{\mathrm{tr}}_{\mathbb R^8}(X^2)=B_{\mathfrak{su}(3)}(X,X)$ and $c_{\mathfrak h}=2$. The test wants $\tfrac{4\cdot8}8-2=2$. **Passes**, so $S_{\mathfrak{hhh}}=16$, $S_{\mathfrak{hmm}}=\kappa r-16=96-16=80$, which is exactly the block's $2(n-1)r(N-r)/N=\tfrac{2\cdot7\cdot8\cdot20}{28}=80$. **The closed form then reads $\theta^2=\tfrac4{64}\cdot\tfrac{8\cdot28}{20}=\tfrac{56}{80}=\tfrac7{10}$, i.e. $\theta=\sqrt{7/10}$**, the record's $0.836660$, recovered here from the Killing form of $\mathfrak{su}(3)$ alone. $r=8$ against a cap of $12$, so it is a member strictly inside.

**$\mathfrak{su}(m)\subset\mathfrak{so}(2m)$, the Berger entry.** $r=m^2-1$ against a cap of $m(m-1)=m^2-m$: **exceeds for every $m\ge2$**, by $m-1$.

### 6.4 $\mathfrak g_2\subset\mathfrak{so}(7)$

$r=14$, $n=7$, $N=21$, cap $=35/4=8.75$. **Exceeds**, so H5 fails. Sharper: the block's closed form would give $S_{\mathfrak{mmm}}=(21-14)\big[2\cdot5-\tfrac{4\cdot6\cdot14}{21}\big]=7[10-16]=-42<0$, impossible for a sum of squares, **so the eigen-equation is refuted at $\mathfrak g_2$ by the lemma itself**, which is the block's mechanism and it works. This agrees with [ATTEMPTS.md](../ATTEMPTS.md):1876ff, where $\mathfrak g_2$ was built as a control and returned criticality residual $0.655$ and $\mathrm{Alt}(W)\ne0$.

### 6.5 $\mathfrak{spin}(7)\subset\mathfrak{so}(8)$ and the rest of the Berger list

$\mathfrak{spin}(7)$: $r=21$, $n=8$, $N=28$, cap $=12$; $S_{\mathfrak{mmm}}$ would be $7[12-21]=-63<0$. **Excluded.** Cap comparisons for the whole list, all exact:

| Berger entry | $n$ | $r$ | cap $n(n-2)/4$ | exceeds? |
|---|---|---|---|---|
| $\mathfrak u(m)$ | $2m$ | $m^2$ | $m^2-m$ | **yes, every $m\ge1$** |
| $\mathfrak{su}(m)$ | $2m$ | $m^2-1$ | $m^2-m$ | **yes, every $m\ge2$** |
| $\mathfrak{sp}(m)\oplus\mathfrak{sp}(1)$ | $4m$ | $2m^2+m+3$ | $4m^2-2m$ | **only $m\le2$** ($m=2$: $13>12$; $m=3$: $24<30$) |
| $\mathfrak{sp}(m)$ | $4m$ | $2m^2+m$ | $4m^2-2m$ | **only $m=1$** ($m=2$: $10<12$) |
| $\mathfrak g_2$ | $7$ | $14$ | $35/4$ | yes |
| $\mathfrak{spin}(7)$ | $8$ | $21$ | $12$ | yes |

**So two Berger entries sit below the cap** and are not excluded by it: $\mathfrak{sp}(m)$ for $m\ge2$ and $\mathfrak{sp}(m)\oplus\mathfrak{sp}(1)$ for $m\ge3$. Screened against the membership test at the first of each: $\mathfrak{sp}(2)\subset\mathfrak{so}(8)$ has $c_{\mathfrak h}=2m+2=6$ from $B_{\mathfrak{sp}(m)}=(2m+2)\mathop{\mathrm{tr}}_{\mathbb C^{2m}}$ and $\mathop{\mathrm{tr}}_{\mathbb R^{4m}}=2\mathop{\mathrm{tr}}_{\mathbb C^{2m}}$, against a required $\tfrac{4\cdot10}8-2=3$, **fails**. And $\mathfrak{sp}(3)\oplus\mathfrak{sp}(1)\subset\mathfrak{so}(12)$ has $S_{\mathfrak{hhh}}=21\cdot8+3\cdot\tfrac43=172$ (using $c_{\mathfrak{sp}(1)\text{ on }\mathbb H^m}=4/m$) against a required $(\tfrac{4\cdot24}{12}-2)\cdot24=144$, **fails**. *Both screens are mine, not the record's*; see §7 for what the record does and does not say about these two entries.

## 7. Discrepancies, each with its three steps

### D1, [results.md](../results.md):134 states L23 without the hypothesis that carries it. **BROKEN as a standalone claim.**

**Locate.** [results.md](../results.md):134, the landscape line: *"**Lemma L23 (landscape). Conjecture A on the subalgebra family, with gradedness doing the separating.** For $W\propto\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$ the value depends on $\dim\mathfrak h$ alone; a sum of squares caps that dimension at $n(n-2)/4$, where the value is $\theta_0(n)$ and $W$ is graded."* There is no "if $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$" anywhere in the sentence, and no "critical".

**Exhibit.** $\mathfrak h=\mathfrak{so}(5)\subset\mathfrak{so}(6)$: a subalgebra, $n=6$, $r=10$, $N=15$, so $0<r<N$ and the sentence's hypotheses are met in full. Its dimension is $10$, and $n(n-2)/4=6$. **The cap is violated by $4$.** For the same reason "the value depends on $\dim\mathfrak h$ alone" fails: reading "the value" as $P(W)=\langle W,Q(W)\rangle$, which is defined at every $W$, this object has $S_{\mathfrak{hhh}}=60$, $S_{\mathfrak{hmm}}=20$, $S_{\mathfrak{mmm}}=0$, $c=\sqrt{3/10}$, $u=c/3$, $v=-2c/3$, and
$$P=\mathop{\mathrm{tr}}W^3+\tfrac12\big[u^3S_{\mathfrak{hhh}}+3uv^2S_{\mathfrak{hmm}}+v^3S_{\mathfrak{mmm}}\big]=\frac{-30+150}{27}c^3=\frac{40c^3}9=\frac2{15}\sqrt{30},$$
against the closed form's $\tfrac13\sqrt{30}$. **Exactly two fifths of it.**

**Argue the opposite.** The most charitable reading is that "the subalgebra family" in the heading is a defined term meaning *the critical members*, so the hypothesis rides in the noun. That reading is available, [results.md](../results.md):395 states the lemma in full, correctly, sixty lines earlier, but it does not survive the way the line is used: [results.md](../results.md):318 cites "Lemma L23 shows they are its maximum" and [results.md](../results.md):38 cites "the subalgebra family is capped at $\theta_0(n)$ **by a dimension count**", which is precisely the reading the block's own withdrawal note declares false and withdrawn. **The candidate stands.**

### D2, [Lemma L4](../findings/ungraded-slack.md)'s advertisement of the closed form is the same defect, in the file the round was opened over. **BROKEN as written.**

**Locate.** [ungraded-slack.md](../findings/ungraded-slack.md):111: *"**The Casimir family and its closed form.** For a subalgebra $\mathfrak h\subseteq\mathfrak{so}(n)$ with $r=\dim\mathfrak h$, $N=\binom n2$ and $W_{\mathfrak h}$ the unit multiple of $\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$ (two eigenvalues by construction), $\theta=\tfrac2n\sqrt{rN/(N-r)}$, **derived in full at [Lemma L23](../findings/ungraded-slack.md) below**."* The quantifier is "for a subalgebra", full stop; H5 is absent, and $0<r<N$ is absent.

**Exhibit.** The same $\mathfrak{so}(5)\subset\mathfrak{so}(6)$. Under the only reading that gives the symbol $\theta$ a value at a non-member ($\theta:=P(W)$, the value the record maximises), the displayed formula is false there by a factor of $\tfrac52$.

**Argue the opposite.** $\theta$ could be read as *defined* by the eigen-equation, so that the display is vacuous where no eigenvalue exists. That is the charitable reading and it makes the sentence true. But the same paragraph goes on to say *"a member obtained from the criterion is not thereby a Casimir"* and *"the largest subalgebra **generating a critical point** has $r=n(n-2)/4$"*, so the paragraph knows the distinction and restores the conditional in the prose while leaving it out of the display. **What L4 uses is what L23 establishes; what L4 *states* is strictly stronger than what L23 establishes**, and the answer to the round's item 5 is that the gap is one hypothesis wide and lies in L4's display, not in L23.

### D3, "only $\mathfrak g_2$ and $\mathfrak{spin}(7)$ are excluded by the $4$-form". **Survives only under a reading the text does not supply.**

**Locate.** The block's sixth paragraph: *"**Each of the three conditions does its own excluding, and only $\mathfrak g_2$ and $\mathfrak{spin}(7)$ are excluded by the $4$-form.**"*

**Exhibit.** $\mathfrak{sp}(2)\subset\mathfrak{so}(8)$: $r=10$, cap $12$, so **it is not excluded by the cap**; and with $K=N_{O(8)}(\mathfrak{sp}(2))\supseteq Sp(2)Sp(1)$ the quaternionic $4$-form $\Omega=\omega_1\wedge\omega_1+\omega_2\wedge\omega_2+\omega_3\wedge\omega_3$ is $K$-invariant and nonzero, so $(\Lambda^4\mathbb R^8)^K\ne0$ and the $4$-form condition **does** exclude it. The same holds for every $\mathfrak{sp}(m)$ and for $\mathfrak{sp}(m)\oplus\mathfrak{sp}(1)$ at $m\ge3$. The block's own companion block at [ungraded-slack.md](../findings/ungraded-slack.md):111 makes the analogous point about $\mathfrak u(m)$, "which has $\omega\wedge\omega\ne0$".

**Argue the opposite.** Read "excluded by the $4$-form" as "*whose only* failing condition is the $4$-form". Then the sentence is true, because $\mathfrak{sp}(m)$ and $\mathfrak{sp}(m)\oplus\mathfrak{sp}(1)$ both fail the irreducibility condition first, $\mathfrak m$ contains the $\mathfrak{sp}(1)$ summand as a $K$-submodule in the first case, and $\mathfrak h$ splits into two non-isomorphic ideals in the second, whereas $\mathfrak g_2$ and $\mathfrak{spin}(7)$ satisfy irreducibility and $\mathrm{Sym}^2$ and fail only $\Lambda^4$. **I accept this reading, so the sentence is not false.** What remains is that the reading turns on facts about $\mathfrak{sp}(m)$ that appear nowhere on the record, and that the two entries are the only Berger cases the cap does not reach.

### D4, "What the hypotheses exclude is the Berger list", with a list that omits $\mathfrak{sp}(m)$. **Incomplete as written.**

**Locate.** *"**What the hypotheses exclude is the Berger list.** The subalgebras that exceed the cap are $\mathfrak g_2\subset\mathfrak{so}(7)$ …, $\mathfrak{spin}(7)\subset\mathfrak{so}(8)$ …, $\mathfrak{so}(n-1)\subset\mathfrak{so}(n)$, and $\mathfrak u(m)$, $\mathfrak{su}(m)$, $\mathfrak{sp}(m)\oplus\mathfrak{sp}(1)$ at $m\le2$, together with the unbalanced splits."*

**Exhibit.** $\mathfrak{sp}(m)\subset\mathfrak{so}(4m)$ is on Berger's list and is absent from the sentence; at $m=2$ it has $r=10$ against a cap of $12$, so it does not exceed the cap and would not belong in the list even if named. **And the ancestor framing in [ATTEMPTS.md](../ATTEMPTS.md):1876ff is flatly false**: *"the subalgebras beating the cap are exactly the Berger special-holonomy list, so the third hypothesis says '$\mathfrak h$ is not a special-holonomy algebra'"*, $\mathfrak{sp}(2)$ and $\mathfrak{sp}(3)\oplus\mathfrak{sp}(1)$ are Berger entries that do not beat the cap, and $\mathfrak{so}(n-1)$ and the unbalanced splits beat it without being on Berger's list, so the equivalence fails in both directions.

**Argue the opposite.** The findings block has already weakened the ATTEMPTS framing from "exactly" to "what the hypotheses exclude is", and the "at $m\le2$" is correct if it attaches to $\mathfrak{sp}(m)\oplus\mathfrak{sp}(1)$ alone, which the arithmetic confirms ($m=2$ gives $13>12$, $m=3$ gives $24<30$). **So the sentence is defensible clause by clause.** The finding is that the *heading* claim, "what the hypotheses exclude is the Berger list", is not supported by the list beneath it for two of the six entries, and the block says nothing about which condition reaches them. *This is the round's named trap in its purest form: the heading is what a consumer quotes and the qualifications are in the sentence beneath it.*

### D5, "at $m\le2$" distributes across three algebras in the reading the punctuation invites. **Citation hazard.**

**Locate.** Same sentence: "$\mathfrak u(m)$, $\mathfrak{su}(m)$, $\mathfrak{sp}(m)\oplus\mathfrak{sp}(1)$ at $m\le2$".

**Exhibit.** Under the distributive reading a consumer concludes that $\mathfrak{su}(3)\subset\mathfrak{so}(6)$ does *not* exceed the cap. It does: $r=8$ against $6$. So does $\mathfrak u(3)\subset\mathfrak{so}(6)$ at $r=9$.

**Argue the opposite.** The intended attachment is to the last item only, and under it every clause is right. **Accepted; recorded as a hazard rather than an error**, because the two readings disagree about a concrete algebra at $n=6$, which is inside the range the record cares about.

### D6, the sign branch. **A missing hypothesis, and one the record has paid for before.**

**Locate.** Statement: *"let $W_{\mathfrak h}$ be the unit-norm multiple of $\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$"*; proof: *"Write $u=c(1-r/N)>0$ …"*.

**Exhibit.** $-W_{\mathfrak h}$ is also a unit-norm multiple. $Q$ is even, so $Q(-W)=Q(W)=\theta W=(-\theta)(-W)$: the eigenvalue is $-\tfrac2n\sqrt{rN/(N-r)}$ and the displayed formula, which is manifestly positive, is false at it. At the $n=4$ torus of §6.2 the two branches give $\pm\sqrt3/2$.

**Argue the opposite.** "The" unit-norm multiple may be intended as the positive-$\theta$ one, and the proof's first line fixes it. **Accepted as the intent**, but it is a hypothesis, it is not in the statement, and [ATTEMPTS.md](../ATTEMPTS.md):2434 records a full cycle lost to exactly this flip, where $\mathfrak h$ and $\mathfrak m$ exchanged under $W\mapsto-W$ and a point was carried for a cycle with $S$ measured on the wrong sign. **The correction is one clause: "with $c>0$".**

### D7, the $(\Lambda^4)^K=0$ reason covers $q=1$ and is asserted for all unbalanced splits. **Conclusion right, reason short.**

**Locate.** *"$\mathfrak{so}(n-1)$ and every unbalanced split have $(\Lambda^4\mathbb R^n)^K=0$ identically, since $\Lambda^4\mathbb R^n=\Lambda^4\mathbb R^{n-1}\oplus\Lambda^3\mathbb R^{n-1}$ over $O(n-1)$ and neither summand carries an invariant for $n\ge6$."*

**Exhibit.** The displayed branching is the restriction to $O(n-1)$, i.e. the split $(p,q)=(n-1,1)$. For $(p,q)=(2,6)$ at $n=8$ the relevant decomposition is $\bigoplus_{i+j=4}\Lambda^i\mathbb R^2\otimes\Lambda^j\mathbb R^6$, which the sentence's formula does not describe.

**Argue the opposite.** The conclusion is true for every unbalanced split, by the same one-line mechanism: $K=O(p)\times O(q)$, and $(\Lambda^i\mathbb R^p)^{O(p)}=0$ unless $i=0$ (the top form flips under a reflection) so the only surviving term needs $i=j=0$, impossible at total degree $4$. **So this is a reason that under-covers its conclusion, not a false claim.** *Worth recording because the same paragraph's next sentence, "they fail (F2) instead", is the load-bearing one, and a reader who checks the $\Lambda^4$ reason and finds it inapplicable has no way to tell whether the conclusion survives.*

## 8. Comparing the forms, findings, results, Lean

| Where | Form | Agreement |
|---|---|---|
| [ungraded-slack.md](../findings/ungraded-slack.md):130–136, the canonical block | Full statement with H1–H5 | The object of this report |
| [ungraded-slack.md](../findings/ungraded-slack.md):83–92, a **second full statement of the same theorem, 40 lines above the canonical one** | Identical displays; the equality chain identical; "Among symmetric pairs only the balanced split reaches the cap" identical | **Agrees, and this is itself worth flagging**: two statements of one theorem in one file, differing only in that the earlier omits the $n=8$ triality clause and the later omits nothing. A correction applied to one will not reach the other |
| [results.md](../results.md):395–401 | Verbatim the canonical block, plus an attribution of the $2(n-2)$ to [Lemma L153](../findings/bounds.md) that the findings block lacks | **Agrees, and is the better text of the two**, the L153 attribution is the one thing a reader needs and the findings block leaves the constant bare |
| [results.md](../results.md):134, the landscape line | Hypothesis-free | **Disagrees. D1** |
| [results.md](../results.md):38 and :318 | "capped at $\theta_0(n)$ **by a dimension count**"; "Lemma L23 shows they are its maximum" | **Both inherit D1's reading**, the second is fine, the first is the withdrawn Lie-theoretic reading in four words |
| [findings/INDEX-results.md](../findings/INDEX-results.md):38 | Gate 2 row: statement and proof correct, prose carried five errors, all repaired | **Consistent with this report**, which finds the statement and proof correct and six further defects in the surrounding prose, none of them among the five named there |
| [ATTEMPTS.md](../ATTEMPTS.md):1876ff | The derivation in summary, plus the Gate 1 and Gate 2 record | **The mathematics agrees**; its "the subalgebras beating the cap are exactly the Berger list" framing is refuted at D4 |

**Lean.** *There is no row for L23 in [lean/INDEX.md](../lean/INDEX.md).* What exists is adjacent: [L23bound.lean](../lean/HamiltonsCubic/Results/L23bound.lean) formalises an *extension* of the bound at sphere products, [PQInvariant.lean](../lean/HamiltonsCubic/Results/PQInvariant.lean) records that L23's $N-r$ **is** $pq$, and [L105.lean](../lean/HamiltonsCubic/Results/L105.lean) proves $\theta^2=\tfrac4{n^2}\cdot\tfrac{rN}{N-r}$ **strictly increasing in $r$**, which is H7, the one step this proof uses without stating.

**What an L23 row would have to claim.** The formalisable part is everything that is finite algebra over $\mathbb Q$ in the symbols $(n,r,N,\kappa,\sigma,u,v,c,\theta,S_{\mathfrak{hhh}},S_{\mathfrak{hmm}},S_{\mathfrak{mmm}})$: *given the two trace equations, the two Killing relations, $ru+(N-r)v=0$, $ru^2+(N-r)v^2=1$, $c>0$ and $0<r<N$, the system has a unique solution, and it is $S_{\mathfrak{hmm}}=2(n-1)r(N-r)/N$, $\theta=\tfrac2n\sqrt{rN/(N-r)}$, $S_{\mathfrak{mmm}}=(N-r)[2(n-2)-4(n-1)r/N]$; and $S_{\mathfrak{mmm}}\ge0\iff r\le n(n-2)/4\iff\theta\le\theta_0(n)$, each with equality together.* **Not claimable in that row**: that the trace equations *are* the traces of $Q(W)=\theta W$ (that is the $\#$ identity and the vanishing of the $\mathfrak{hhm}$ pattern), that $S_{\mathfrak{mmm}}$ is a sum of squares, and the whole of C10, which needs Cartan.

## 9. The gap between what is proven and what is used, what a consumer may cite

**May be cited, from the proof on file:** for a subalgebra $\mathfrak h\subseteq\mathfrak{so}(n)$ with $0<r<N$, **whose unit-norm Casimir with $c>0$ satisfies $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$**,

1. $\theta=\tfrac2n\sqrt{rN/(N-r)}$ and $S_{\mathfrak{hmm}}=2(n-1)r(N-r)/N$ and $S_{\mathfrak{mmm}}=(N-r)\big[2(n-2)-4(n-1)r/N\big]$;
2. $r\le n(n-2)/4$, and $\theta\le\theta_0(n)$;
3. equality in either, together, exactly when $S_{\mathfrak{mmm}}=0$, exactly when $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$, exactly when $(\mathfrak{so}(n),\mathfrak h)$ is a symmetric pair, and exactly when $W_{\mathfrak h}$ is graded in **all three** of the senses of [graded-half.md](../findings/graded-half.md):280–302, which coincide here;
4. for odd $n$, $\theta<\theta_0(n)$ strictly.

**May be cited only with the debt attached:** that the equality case is $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ **alone**, and hence that the family's maximiser is the Weyl operator of $S^{n/2}\times S^{n/2}$. Both need Cartan's classification, unread (§5). *The $n=8$ half of it is secure, by the inner-versus-outer argument at [LEDGER.md](../findings/LEDGER.md):1272 rather than by the dimension count the block gives.*

**May not be cited:** any hypothesis-free form of the cap or the closed form (D1, D2); "the subalgebras that exceed the cap are the Berger list" (D4); "only $\mathfrak g_2$ and $\mathfrak{spin}(7)$ are excluded by the $4$-form" without the "only failing condition" gloss (D3).

**And the standing caveat the block states about itself is correct and should travel with every citation:** the cap on this family **is** the graded-compression inequality restricted here, $S=\tfrac r{nN}[4(N-r)-n^2]\ge0\iff r\le n(n-2)/4$, which I checked reduces to the same inequality since $r,n,N>0$, so it is a re-derivation, not independent leverage; and $W_{\mathbb{CP}^3}$ ties $\theta_0(6)$ from outside the family, so uniqueness within the family is not uniqueness of the maximiser of $P$.

## 10. What would falsify the statement, and what I did to look for it

**The object that would break it.** A subalgebra $\mathfrak h\subseteq\mathfrak{so}(n)$ with $0<r<N$, whose unit Casimir $W_{\mathfrak h}$ (with $c>0$) satisfies $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$, and with **either** $\theta\ne\tfrac2n\sqrt{rN/(N-r)}$ **or** $r>n(n-2)/4$. By §2 the two are the same object: the closed form is forced by the two traces, so any counterexample to the cap is a counterexample to the elimination, and the elimination is a nonsingular $2\times2$ solve. **Equivalently, and this is the only place a falsifier could hide: a subalgebra whose genuine bracket data gives $S_{\mathfrak{hhh}}\ne(4r/n-2)r$ while its Casimir is still an eigenvector of $Q$.** That is impossible if the $\#$ identity of §0 is the record's $\#$, so the falsifier is really a falsifier of the convention, not of the algebra.

**Where I looked.** (i) The four structured families the round names, each carried through the membership test of §6: $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ balanced and unbalanced, the maximal torus at $n=4$ and $n=6$ with the eigen-equation verified in full by hand, $\mathrm{ad}(\mathfrak{su}(3))\subset\mathfrak{so}(8)$ with $c_{\mathfrak h}=2$ recovered from the Killing form, and $\mathfrak{su}(m)\subset\mathfrak{so}(2m)$. (ii) The whole Berger list against the cap, exactly, including the two entries that fall below it. (iii) The edges of every range in §4. (iv) The two candidate cracks in the equality case, the $n=8$ triality classes, and the $\mathrm{Aut}$-versus-$SO(n)$ mismatch that the record's own ledger flags, both of which close, the second via [LEDGER.md](../findings/LEDGER.md):1272.

**Found none.** The two hand-verified members at $n=4$ and $n=6$ agree with the closed form, the companion $S_{\mathfrak{mmm}}$ and the strictness of the cap exactly, and the one non-member I evaluated in full, $\mathfrak{so}(5)\subset\mathfrak{so}(6)$, disagrees with the closed form by exactly the factor $\tfrac52$, which is not a counterexample to the lemma but the witness that its hypothesis is load-bearing, and the exhibit for D1 and D2.

**No numerical work was performed.** Every value above is exact: $\sqrt3/2$, $\tfrac12\sqrt{5/3}$, $\sqrt{7/10}$, $\tfrac13\sqrt{30}$, $\tfrac2{15}\sqrt{30}$, and the integers $16$, $48$, $60$, $80$, $144$, $172$.

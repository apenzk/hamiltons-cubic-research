# Gate 2, reviewer r773, L179's support reduction and L180's PSD form of Ricci-flatness

Cold brief, worked from [BRIEF-g2-l179-l180.md](BRIEF-g2-l179-l180.md) and nothing else; [findings/](../findings/) was not opened. **No numerical work was done. Every value in this report is exact and was derived by hand.** One screen is reported as such in §13, exact rational arithmetic, seconds, on an object I constructed for the purpose of screening a claim I was about to record; the evidence of record is the closed-form derivation that precedes it. Log: [agent_logs/g2-l180-r773.log](../agent_logs/g2-l180-r773.log).

## Verdicts

| # | claim | verdict |
| --- | --- | --- |
| L179(a) | $W$ is supported on $\Lambda^2V$ | **SOUND, STATEMENT UNDER-SPECIFIED**, true; "an index leaves $V$" is only meaningful in a frame adapted to $V$, and the adaptation is never stated |
| L179(b) | Bianchi is $\sum_{\lambda_\alpha\ne0}\lambda_\alpha\,\omega_\alpha\wedge\omega_\alpha=0$ | **SOUND**, confirmed at source; the identity is a vanishing statement so the projection's constant is immaterial |
| L179(c) | rank one is impossible | **SOUND** |
| L179(d) | all decomposable $\Rightarrow$ Bianchi automatic, $\dim V\le6$; the three planes are not mutually orthogonal | **SOUND BUT CONDITIONAL AND PARTIAL**, correct given the imported coordinate-diagonal fact, which I took as given and did not verify; it disposes of one sub-case of one case |
| L180(1) | Ricci-flatness is $\sum_i\lambda_iA_i=0$, $A_i\succeq0$, $\mathop{\mathrm{tr}}A_i=2$ | **SOUND, NO FACTOR OF TWO**, the normalisation is exactly right in the brief's own conventions |
| L180(2) | tracelessness is its trace | **SOUND** |
| L180(3) | $V$ is the minority form's support; $\dim V$ even and $\ge4$ | **SOUND, AND ITS ONE DEBT IS NOW DISCHARGED**, range additivity was stated with no argument; it is TRUE, proved below and read at source |
| L180(4) | at rank two $A_1=A_2$ | **SOUND** |
| item 5 | range additivity of PSD sums | **PROVED, AND SOURCED**, [Yang, Semidefinite Optimization, Corollary 2.1](../references/yang-2024-semidefinite-optimization/notes.md) |
| item 7 | the evenness of $\dim V$ | **DOES NOT CIRCLE**, the identification $V=\mathop{\mathrm{supp}}\omega_{\min}$ is derived from range additivity, not assumed |
| item 13 | *"$\dim V\ge6$ is the whole of what remains"* for a rank-three tensor | **REFUTED IN CLOSED FORM**, a rank-three algebraic Weyl tensor with $\dim V=4$ exists in every $n\ge4$, exhibited in §13 |

**Overall: SOUND CORE, REFUTED COROLLARY.** Both lemmas hold as stated. The conclusion the record draws from them does not.

## Actionable summary, one line

Keep L179 and L180 as they stand with three repairs, adapt the frame in L179(a), cite [Corollary 2.1](../references/yang-2024-semidefinite-optimization/notes.md) in L180(3), and record the imported fact L179(d) leans on, then strike *"$\dim V\ge6$ is the whole of what remains"*, because $W=2\,\omega_1\otimes\omega_1-\omega_2\otimes\omega_2-\omega_3\otimes\omega_3$ on the self-dual forms of $\mathbb R^4\subseteq\mathbb R^n$ is a rank-three Weyl tensor with $\dim V=4$.

## 0. Conventions, fixed once

Everything below is in the brief's conventions and adds nothing to them.

- $f_1,\dots,f_n$ is a fixed orthonormal frame of $\mathbb R^n$; $\{f_a\wedge f_b\}_{a<b}$ is orthonormal in $\Lambda^2\mathbb R^n$.
- A $2$-form is $\omega=\sum_{a<b}\omega_{ab}f_a\wedge f_b$ and simultaneously the skew matrix $(\omega_{ab})$ with $\omega_{ba}=-\omega_{ab}$ and $\omega_{aa}=0$. Then $\lVert\omega\rVert^2=\sum_{a<b}\omega_{ab}^2$, and for $a<b$, $\langle\omega,f_a\wedge f_b\rangle=\omega_{ab}$.
- $\mathop{\mathrm{supp}}\omega:=\mathop{\mathrm{Im}}(\omega_{ab})\subseteq\mathbb R^n$, of even dimension.
- $W$ is self-adjoint on $\Lambda^2\mathbb R^n$ with $W(f_a\wedge f_b)=\sum_{c<d}W_{abcd}f_c\wedge f_d$, spectral form $W=\sum_\alpha\lambda_\alpha\,\omega_\alpha\otimes\omega_\alpha$, $(\omega\otimes\omega)(\eta)=\langle\omega,\eta\rangle\,\omega$.
- $\mathcal W_n$: the Riemann symmetries, the first Bianchi identity, and $\sum_bW_{abcb}=0$ for all $a,c$.
- $A_i:=-\omega_i^2=\omega_i\omega_i^{\mathsf T}$; $S_i:=\mathop{\mathrm{supp}}\omega_i$; $V:=\sum_{\lambda_\alpha\ne0}S_\alpha$; $r:=\mathop{\mathrm{rank}}_{\Lambda^2}W$.
- **One convention the brief does not fix and this record should:** $\lVert W\rVert$. The brief fixes the inner product on $\Lambda^2$ but never says whether $\lVert W\rVert^2$ means $\sum_{a<b,\,c<d}W_{abcd}^2$ (the $\Lambda^2$-operator norm, $=\sum_\alpha\lambda_\alpha^2$) or $\sum_{a,b,c,d}W_{abcd}^2$ (the $(0,4)$-tensor norm, four times as large). The two differ by a factor of $2$ in $\lVert W\rVert$ and therefore by $8$ in $\theta=P/\lVert W\rVert^3$. Nothing in L179 or L180 touches $\theta$, so nothing here depends on the choice, but given that this record has admitted a factor-of-two error twice, and given that [Petersen–Wink](../references/petersen-wink-2019-bochner-curvature-conditions/notes.md) use the first convention for forms and the second for tensors *in the same paragraph*, the ambiguity is a live hazard on any line that imports a constant.

## 1. Hypothesis inventory

### Used and stated

| hypothesis | where it does work |
| --- | --- |
| $W$ self-adjoint on $\Lambda^2$ | pair symmetry $W_{abcd}=W_{cdab}$, used in L179(a)'s second half and in the symmetry of the Ricci matrix |
| $W$ realised through $\Lambda^2$ | the two antisymmetries, free |
| $\lambda_i\ne0$ for the indices summed | L179(a) (defines $V$), L179(b) (the zero terms drop), L180 throughout |
| $\omega_i$ orthonormal | $\mathop{\mathrm{tr}}A_i=2$ in L180(1); $\sum_i\lambda_i=0$ in L180(2); linear independence in L180(3)'s $\dim V\ge4$ |
| $\sum_bW_{abcb}=0$ | L180(1); and through its trace, L179(c) and L180(2) |
| first Bianchi identity | L179(b), L179(d) |
| $\omega$ decomposable $\iff$ support is a plane $\iff$ $\omega\wedge\omega=0$ | L179(d) |
| rank exactly three | L179(d), L180(3) |
| **imported:** a nonzero coordinate-diagonal Weyl tensor has $\Lambda^2$-rank $\ge4$ | L179(d) only. **Taken as given per the brief; not verified here.** L179(d) is conditional on it and nothing else in this report is. |

### Stated and unused

$n\ge12$; the threshold $\sqrt{3/2}$; $\theta_0(12)=1.236033$; the crossover $n=6+2\sqrt7$; $\theta$; $P(W)=\langle W,W^2+W^\#\rangle$. **Not one of the six enters either proof.** This is worth recording as a positive fact rather than a complaint: L179 and L180 are dimension-free algebraic statements, valid for every $n\ge4$ and vacuous for $n\le3$ where $\mathcal W_n=0$. It also means neither lemma can be defended by appeal to the conjecture's range, see §12 and §13.

### Used and unstated

1. **L179(a): the frame is adapted to $V$.** "$W_{abcd}=0$ whenever any index leaves $V$" has no meaning unless $V=\mathop{\mathrm{span}}\{f_a:a\in I\}$ for some index set $I$. The frame $f_a$ is fixed before $V$ is defined. Repair: "there is an orthonormal frame in which $V$ is coordinate-spanned, and in any such frame…". §8.
2. **L179(a), L180(3): $\mathop{\mathrm{supp}}\omega\subseteq V\Rightarrow\omega\in\Lambda^2V$.** Used twice and proved nowhere. §8 proves it.
3. **L179(a): $V$ does not depend on the eigenbasis chosen inside a degenerate eigenspace.** The lemma says "an orthonormal eigenbasis", so if $V$ depended on the choice the object would be ill-defined. §11 proves it does not.
4. **L180(3): $\mathop{\mathrm{range}}(A)=\ker(A)^\perp$ for symmetric $A$.** The written proof establishes $\ker A=\ker\omega$ and then asserts the ranges agree. Passing from kernels to ranges needs symmetry of $A$ and skewness of $\omega$. §4.
5. **L180(3): range additivity of PSD sums.** Flagged by the brief; the record has no argument for it. §5 supplies one and a source.
6. **L179(b): the constant in $\mathfrak b$.** Harmless, because Bianchi is a vanishing condition; said explicitly in §9.
7. **L179(d): $\lVert\omega\rVert=1$ and decomposable forces $\omega=\pm f_{i}\wedge f_{j}$ in an adapted frame.** §10.

## 2. The normalisation of $W_{abcd}=\sum_i\lambda_i(\omega_i)_{ab}(\omega_i)_{cd}$

**Derived from scratch, in the brief's conventions. There is no factor of $2$ and no factor of $\tfrac12$.**

Take $a<b$ and $c<d$. By the definition of the action and the orthonormality of $\{f_c\wedge f_d\}_{c<d}$,
$$W_{abcd}=\big\langle W(f_a\wedge f_b),\,f_c\wedge f_d\big\rangle .$$
Insert the spectral form and the definition $(\omega\otimes\omega)(\eta)=\langle\omega,\eta\rangle\omega$:
$$W(f_a\wedge f_b)=\sum_i\lambda_i\,\langle\omega_i,f_a\wedge f_b\rangle\,\omega_i ,\qquad\text{so}\qquad W_{abcd}=\sum_i\lambda_i\,\langle\omega_i,f_a\wedge f_b\rangle\,\langle\omega_i,f_c\wedge f_d\rangle .$$
The brief's inner product is the one making $\{f_a\wedge f_b\}_{a<b}$ orthonormal, and the brief's coordinates $\omega_{ab}$ are the coefficients in exactly that basis. Hence $\langle\omega_i,f_a\wedge f_b\rangle=(\omega_i)_{ab}$ for $a<b$, **with coefficient $1$**, and
$$\boxed{\;W_{abcd}=\sum_i\lambda_i\,(\omega_i)_{ab}(\omega_i)_{cd}\quad\text{for }a<b,\ c<d.\;}$$

**Extension to all four index values.** Both sides are antisymmetric under $a\leftrightarrow b$ and under $c\leftrightarrow d$ (the left by the Riemann symmetries, the right by the skew-matrix convention) and both vanish when $a=b$ or $c=d$. So the identity holds for every quadruple, which is what §3 needs.

**Where the factor of two actually lives, and why it is not here.** The two natural traces of $\omega\otimes\omega$ disagree:
$$\mathop{\mathrm{tr}}_{\Lambda^2}(\omega\otimes\omega)=\sum_{a<b}\langle\omega,f_a\wedge f_b\rangle^2=\lVert\omega\rVert^2,\qquad \mathop{\mathrm{tr}}_{\mathbb R^n}(\omega\omega^{\mathsf T})=\sum_{a,b}\omega_{ab}^2=2\lVert\omega\rVert^2 .$$
That $2$ is real, and the record has it in the right place: L180(1) says $\mathop{\mathrm{tr}}A_i=2$, not $1$. The trap is that the same $2$ relates the $\Lambda^2$-trace of $W$ to the trace of the Ricci matrix, and §6 shows the record uses the relation consistently.

**Would a factor change any conclusion?** Suppose the true normalisation were $W_{abcd}=c\sum_i\lambda_i(\omega_i)_{ab}(\omega_i)_{cd}$ for some $c>0$. Then the Ricci matrix would be $c\sum_i\lambda_iA_i$ and the condition $\sum_i\lambda_iA_i=0$ would be unchanged; the trace would give $2c\sum_i\lambda_i=0$, so $\sum_i\lambda_i=0$ unchanged; §5–§7 read only ranges and signs, both invariant under a positive scale. **So L180(1)–(4) and L179(a)–(d) are all invariant under any positive renormalisation, and would survive even had I found a factor.** What a factor would move is every numerical constant relating $\lambda_i$ to $\lVert W\rVert$, $P$ and $\theta$, none of which appears in these two lemmas, and all of which are exposed to the unfixed $\lVert W\rVert$ convention flagged in §0.

## 3. The Ricci contraction, index by index

The claim is that for a skew matrix $\omega$,
$$\sum_{b=1}^{n}\omega_{ab}\,\omega_{cb}=(\omega\omega^{\mathsf T})_{ac}.$$
By definition of the matrix product and the transpose, $(\omega\omega^{\mathsf T})_{ac}=\sum_b\omega_{ab}(\omega^{\mathsf T})_{bc}=\sum_b\omega_{ab}\omega_{cb}$. **Yes, exactly, with no sign and no factor.** And $\omega^{\mathsf T}=-\omega$ gives $\omega\omega^{\mathsf T}=-\omega^2$, so $A=-\omega^2=\omega\omega^{\mathsf T}$ as the brief has it.

**The bookkeeping, done explicitly.** The sum runs over all $n$ values of $b$, including $b=a$ and $b=c$; those terms carry a diagonal entry of a skew matrix and vanish, so including them is harmless. Substituting §2's identity, **which is why §2's extension beyond $a<b$, $c<d$ was necessary, since $b$ ranges freely on both sides of $a$ and of $c$**,
$$\sum_bW_{abcb}=\sum_b\sum_i\lambda_i(\omega_i)_{ab}(\omega_i)_{cb}=\sum_i\lambda_i\,(\omega_i\omega_i^{\mathsf T})_{ac}=\Big(\sum_i\lambda_iA_i\Big)_{ac}.$$
**Consistency check on symmetry.** The right side is symmetric in $a\leftrightarrow c$ because each $A_i$ is. The left side is symmetric because pair symmetry gives $W_{abcb}=W_{cbab}$. The two agree, as they must. **L180(1) is sound.**

One scope note. The brief calls $\sum_bW_{abcb}=0$ "Ricci-flatness". For a tensor carrying the full Riemann symmetries *including* the first Bianchi identity that is the standard Ricci trace; for a merely self-adjoint operator on $\Lambda^2$ it is the total trace-freeness in the definition of $\mathcal W_n$. L180(1) as an equivalence needs only the latter, and the latter is what §5–§7 consume, so nothing is lost, but the word "Ricci" is doing work the hypotheses do not license unless Bianchi is also assumed.

## 4. $A=\omega\omega^{\mathsf T}$: the three properties, separately

**(i) Positive semidefinite.** $x^{\mathsf T}Ax=x^{\mathsf T}\omega\omega^{\mathsf T}x=\lVert\omega^{\mathsf T}x\rVert^2\ge0$. Sound.

**(ii) $\mathop{\mathrm{range}}(A)=\mathop{\mathrm{supp}}\omega$.** The brief's argument is that $\omega^2x=0$ forces $\lVert\omega x\rVert^2=-x^{\mathsf T}\omega^2x=0$. Correct, and it gives $\ker A\subseteq\ker\omega$; the reverse inclusion is immediate, so $\ker A=\ker\omega$. **The step the brief omits** is the passage from kernels to ranges. It goes: $A$ is symmetric, so $\mathop{\mathrm{range}}(A)=\ker(A)^\perp$; $\omega$ is skew, so $\mathop{\mathrm{range}}(\omega)=\mathop{\mathrm{range}}(\omega^{\mathsf T})=\ker(\omega)^\perp$. Hence
$$\mathop{\mathrm{range}}(A)=\ker(A)^\perp=\ker(\omega)^\perp=\mathop{\mathrm{range}}(\omega)=\mathop{\mathrm{supp}}\omega .$$
Sound, with a gap in the writing rather than in the mathematics.

**(iii) $\mathop{\mathrm{tr}}A=2\lVert\omega\rVert^2$.** $\mathop{\mathrm{tr}}(\omega\omega^{\mathsf T})=\sum_{a,b}\omega_{ab}^2=2\sum_{a<b}\omega_{ab}^2=2\lVert\omega\rVert^2$. Sound, and equal to $2$ at unit norm, as L180(1) says.

## 5. Range additivity, proved, and read at source

**The claim is TRUE.** I prove it, then give the source, as the brief directs.

**Proposition.** *Let $A_1,\dots,A_k$ be positive semidefinite. Then $\mathop{\mathrm{range}}\big(\sum_jA_j\big)=\sum_j\mathop{\mathrm{range}}(A_j)$.*

*Proof.* Write $A=\sum_jA_j$, itself PSD and symmetric. For $x\in\mathbb R^n$,
$$x^{\mathsf T}Ax=\sum_jx^{\mathsf T}A_jx,$$
a sum of nonnegative terms, so $x^{\mathsf T}Ax=0$ iff $x^{\mathsf T}A_jx=0$ for every $j$. For a single PSD $B$, $x^{\mathsf T}Bx=0$ iff $Bx=0$: writing $x=\sum_i a_iv_i$ in an orthonormal eigenbasis of $B$ with eigenvalues $\mu_i\ge0$, $x^{\mathsf T}Bx=\sum_i\mu_ia_i^2$, a sum of nonnegative terms, so it vanishes iff $\mu_ia_i^2=0$ for every $i$, i.e. iff $a_i=0$ whenever $\mu_i>0$, i.e. iff $Bx=\sum_i\mu_ia_iv_i=0$. Also $Ax=0\Rightarrow x^{\mathsf T}Ax=0$. Chaining these,
$$\ker A=\{x:x^{\mathsf T}Ax=0\}=\bigcap_j\{x:x^{\mathsf T}A_jx=0\}=\bigcap_j\ker A_j .$$
Take orthogonal complements, using $\mathop{\mathrm{range}}(S)=\ker(S)^\perp$ for symmetric $S$ and $\big(\bigcap_jU_j\big)^\perp=\sum_jU_j^\perp$:
$$\mathop{\mathrm{range}}(A)=\ker(A)^\perp=\Big(\bigcap_j\ker A_j\Big)^{\!\perp}=\sum_j\ker(A_j)^\perp=\sum_j\mathop{\mathrm{range}}(A_j).\qquad\square$$

**Positive semidefiniteness is indispensable, not decorative.** For general symmetric summands the statement fails outright: $A_1=I$, $A_2=-I$ have ranges spanning $\mathbb R^n$ each while $\mathop{\mathrm{range}}(A_1+A_2)=0$. In L180(3) that is exactly the danger being avoided, since the $\lambda_i$ there have mixed signs, and the record avoids it correctly, by moving the minority term to the other side *before* invoking additivity, so that every summand on each side carries a positive coefficient. **This is the single most delicate point in L180 and the record gets it right.**

**Source.** Heng Yang, *Semidefinite Optimization and Relaxation*, chapter 2, [Corollary 2.1 (Range of PSD Matrices)](https://hankyang.seas.harvard.edu/Semidefinite/sdp.html): "*Let $A,B\in\mathbb S^n_+$, then we have $\mathop{\mathrm{Range}}(A+B)=\mathop{\mathrm{Range}}(A)+\mathop{\mathrm{Range}}(B)$, with '$+$' the Minkowski sum.*" It is induced there from Lemma 2.3, $\mathop{\mathrm{Range}}(A)\subseteq\mathop{\mathrm{Range}}(A+B)$, whose proof runs through the same kernel identity I use. Fetched, transcribed and annotated at [references/yang-2024-semidefinite-optimization/notes.md](../references/yang-2024-semidefinite-optimization/notes.md); the source states it for two summands, and $k$ follows by induction because a finite sum of PSD matrices is PSD. **Left uncommitted**, see the closing note.

**Verdict on the record's use.** The fact is true and the use is correct, but as it stood in L180(3) it was an assertion. Now that it is sourced I would not carry it as debt; before this audit it was `HYPOTHESIS-DEBT` in the citation, never in the mathematics.

## 6. L180(3)'s sign analysis, each pattern separately

First, why $\sum_i\lambda_i=0$. Take the trace of $\sum_i\lambda_iA_i=0$ and use §4(iii) at unit norm: $\sum_i\lambda_i\mathop{\mathrm{tr}}A_i=2\sum_i\lambda_i=0$. **This is L180(2), and it is sound**: it is a consequence of L180(1), not an independent condition, exactly as claimed. (Equivalently $\mathop{\mathrm{tr}}(\omega_i^2)=-\mathop{\mathrm{tr}}A_i=-2$, the brief's phrasing.)

**Are $(+,+,-)$ and $(+,-,-)$ the only patterns?** Three nonzero reals summing to zero cannot all share a sign, since then the sum would be nonzero of that sign. So the sign vector lies in $\{+,-\}^3$ minus the two constant vectors: six vectors, falling into two classes under relabelling, represented by $(+,+,-)$ and $(+,-,-)$. **Yes, exactly two, and in each the minority sign occurs exactly once**, so "the single form carrying the minority sign" is well defined. Sound.

**Pattern $(+,+,-)$**, say $\lambda_1,\lambda_2>0>\lambda_3$. Move the minority term:
$$\lambda_1A_1+\lambda_2A_2=|\lambda_3|A_3 .$$
Every coefficient is positive, and $\mathop{\mathrm{range}}(cA)=\mathop{\mathrm{range}}(A)$ for $c>0$, so §5 applied to the left gives $S_1+S_2$ and applied to the right gives $S_3$. Hence
$$S_3=S_1+S_2\supseteq S_1,\ S_2,\qquad V=S_1+S_2+S_3=S_3 .$$

**Pattern $(+,-,-)$**, say $\lambda_1>0>\lambda_2,\lambda_3$. Move the minority term:
$$\lambda_1A_1=|\lambda_2|A_2+|\lambda_3|A_3 ,$$
so $S_1=S_2+S_3\supseteq S_2,S_3$ and $V=S_1$.

**Both patterns give $V=\mathop{\mathrm{supp}}\omega_{\min}$, the minority-sign form's support.** Sound in both, and the reason is the same in both: the minority class is a singleton, so one side of the moved equation is a single range. The argument is not symmetric between the patterns in any way that could hide a gap, in the first the minority side is the right, in the second the left, and §5 is applied to whichever side has more than one summand. **Verdict: sound, checked case by case.**

**A scope observation the record should carry.** What the argument really proves is
$$\sum_{\lambda_i>0}S_i=\sum_{\lambda_i<0}S_i=V,$$
at every rank, not only three. The stronger conclusion "$V$ is *one* form's support" needs one of the two sign classes to be a singleton, which at rank three is automatic and at rank four already fails for the pattern $(+,+,-,-)$. **So the evenness of $\dim V$ does not survive past the ranks where a sign class is a singleton**, and any use of L180(3) at rank $\ge4$ must say which pattern it is in.

## 7. $\dim V$ is even and at least four, and the argument does not circle

**Does it circle?** No. The chain runs, in this order and with no step reaching forward:

1. $V:=\sum_iS_i$ is *defined* as a span of several supports. At this stage nothing says $\dim V$ is even, and nothing should, **a span of even-dimensional subspaces is in general odd-dimensional**, as two distinct planes in $\mathbb R^3$ show.
2. §6 *derives*, from L180(1) and range additivity, the identity $V=S_{\min}$ for the single minority-sign index.
3. $S_{\min}$ is the image of a single real skew matrix, so its dimension is even, a skew matrix has even rank, since its nonzero eigenvalues come in conjugate pairs $\pm i\mu$.

Step 3 uses only step 2, and step 2 uses only L180(1), the sign count, and §5. **The evenness is a consequence of the identification, and the identification is proved rather than assumed. No circle.** Had the record asserted evenness first and used it to identify $V$, that would circle; it does not.

**Is $\dim V=2$ really impossible?** Yes, and the brief's one-line reason is correct. Two ingredients:

- *Each $\omega_i$ lies in $\Lambda^2V$.* Proof: choose an orthonormal frame with $V=\mathop{\mathrm{span}}(f_1,\dots,f_m)$ and write $\omega_i$ in blocks, $\omega_i=\begin{pmatrix}B&C\\-C^{\mathsf T}&D\end{pmatrix}$. The image lies in $V$ exactly when the lower block row vanishes, i.e. $C^{\mathsf T}=0$ and $D=0$; then $C=0$ too and $\omega_i$ is supported on the $V$ block, i.e. $\omega_i\in\Lambda^2V$. (This is the used-and-unstated fact 2 of §1.)
- *The $\omega_i$ are linearly independent*, being orthonormal.

Hence $r\le\dim\Lambda^2V=\binom{\dim V}{2}$. At $\dim V=2$ that is $1$, so $r\le1$, contradicting $r=3$. **Sound.** With evenness this excludes $\dim V\in\{0,1,2,3\}$, leaving $\dim V\ge4$.

**And that is all it leaves.** $\binom42=6\ge3$, so the counting obstruction is silent at $\dim V=4$; nothing in L179 or L180 excludes it. §13 shows it is not merely unexcluded but realised.

## 8. L179(a)

**Does $\mathop{\mathrm{Im}}W\subseteq\Lambda^2V$ follow?** Yes. $\mathop{\mathrm{Im}}W=\mathop{\mathrm{span}}\{\omega_\alpha:\lambda_\alpha\ne0\}$, each such $\omega_\alpha$ has $\mathop{\mathrm{supp}}\omega_\alpha\subseteq V$ by the definition of $V$, and by the block argument of §7 a $2$-form with support in $V$ lies in $\Lambda^2V$. The span of forms in the subspace $\Lambda^2V$ lies in $\Lambda^2V$. Sound.

**Is the pair-symmetry step valid for all four indices?** Yes. Fix a frame adapted to $V$, $V=\mathop{\mathrm{span}}\{f_a:a\in I\}$. For $c<d$ with $\{c,d\}\not\subseteq I$ the basis vector $f_c\wedge f_d$ is orthogonal to $\Lambda^2V$, so
$$W_{abcd}=\langle W(f_a\wedge f_b),f_c\wedge f_d\rangle=0 ,$$
since $W(f_a\wedge f_b)\in\Lambda^2V$. That kills the last two slots. For the first two, $W_{abcd}=W_{cdab}$ by self-adjointness, and the case just settled applies to $W_{cdab}$ whenever $\{a,b\}\not\subseteq I$. **So the two applications together cover all four index positions, and the conclusion "$W_{abcd}=0$ whenever any index leaves $V$" is correct.** Antisymmetry extends it off $a<b$, $c<d$.

**The defect is in the statement, not the proof.** The frame $f_a$ is fixed in the conventions *before* $V$ is constructed, and for a general $V$ no index "belongs" to $V$ at all. The lemma is only meaningful once the frame is adapted, and adapting is always possible but is never said. A cleaner frame-free statement, equivalent to the one given, is: $W$ vanishes on $(\Lambda^2V)^\perp=\big(V\wedge V^\perp\big)\oplus\Lambda^2V^\perp$ and maps $\Lambda^2\mathbb R^n$ into $\Lambda^2V$, the first from the second by self-adjointness. **Verdict: sound, statement under-specified.**

## 9. L179(b), the Bianchi map

**In this normalisation, with no constant?** Substituting §2 into the cyclic sum,
$$W_{abcd}+W_{acdb}+W_{adbc}=\sum_i\lambda_i\Big[(\omega_i)_{ab}(\omega_i)_{cd}+(\omega_i)_{ac}(\omega_i)_{db}+(\omega_i)_{ad}(\omega_i)_{bc}\Big],$$
and the bracket is, up to a fixed nonzero constant depending only on the convention chosen for $\wedge$, the $(abcd)$ component of $\omega_i\wedge\omega_i$. So the cyclic sum vanishes identically iff $\sum_i\lambda_i\,\omega_i\wedge\omega_i=0$ in $\Lambda^4$. **The constant is immaterial precisely because both sides are being set to zero**, a point the record should state rather than leave to be noticed, since a constant that is immaterial here would not be immaterial in any quantitative use of $\mathfrak b$.

**Read at source.** [Petersen–Wink, arXiv:1908.09958v4](https://arxiv.org/abs/1908.09958), section 1.1: "*Recall that there is an orthogonal decomposition $\mathrm{Sym}^2(\Lambda^2V)=\mathrm{Sym}^2_B(\Lambda^2V)\oplus\Lambda^4V$, where the vector space $\mathrm{Sym}^2_B(\Lambda^2V)$ consists of all tensors $T\in\mathrm{Sym}^2(\Lambda^2V)$ that also satisfy the first Bianchi identity.*" So satisfying the first Bianchi identity is exactly having zero $\Lambda^4$ component, i.e. lying in the kernel of $\mathfrak b:S^2\Lambda^2\to\Lambda^4$. Transcribed at [references/petersen-wink-2019-bochner-curvature-conditions/notes.md](../references/petersen-wink-2019-bochner-curvature-conditions/notes.md).

**"The zero eigenvalues drop out, so at rank $r$ it constrains $r$ terms and no more."** Correct as arithmetic, a term with $\lambda_\alpha=0$ contributes nothing to a linear expression in the $\lambda$. I would resist reading it as a statement about how *strong* the constraint is: $\mathfrak b(W)=0$ is one equation in $\Lambda^4\mathbb R^n$, of dimension $\binom n4$, so at $n\ge12$ it is $\binom n4\ge495$ scalar conditions on $r$ terms, not $r$ conditions. The count of *terms* is $r$; the count of *conditions* is not. **Verdict: sound, with a phrase that invites a wrong reading.**

## 10. L179(c) and L179(d)

**(c) Rank one.** If $W=\lambda\,\omega\otimes\omega$ with $\lambda\ne0$ and $\lVert\omega\rVert=1$, then $\mathop{\mathrm{tr}}_{\Lambda^2}W=\lambda\lVert\omega\rVert^2=\lambda\ne0$. And total trace-freeness forces $\mathop{\mathrm{tr}}_{\Lambda^2}W=0$: setting $a=c$ in $\sum_bW_{abcb}=0$ and summing over $a$ gives $\sum_{a,b}W_{abab}=2\sum_{a<b}W_{abab}=2\mathop{\mathrm{tr}}_{\Lambda^2}W=0$. Contradiction. **Sound.** (Equivalently, take the trace of L180(1): $2\sum_i\lambda_i=0$ has no solution with a single nonzero $\lambda$.) Note it uses only the trace, a strict consequence of the hypotheses, so it is robust.

**(d), first half.** If $\omega_i=u_i\wedge v_i$ is decomposable then $\omega_i\wedge\omega_i=u_i\wedge v_i\wedge u_i\wedge v_i=0$, so *every* term of $\sum_i\lambda_i\,\omega_i\wedge\omega_i$ vanishes separately and the Bianchi condition of (b) holds however the $\lambda_i$ are chosen. **Sound**, and worth stating in the record for what it is: in the all-decomposable case Bianchi imposes nothing, so it cannot be the obstruction there. And $\dim V\le\sum_i\dim S_i=3\cdot2=6$. **Sound**, trivially.

**(d), second half.** Suppose the three planes $S_1,S_2,S_3$ are mutually orthogonal. Then $n\ge6$ and one may choose an orthonormal frame with $S_1=\mathop{\mathrm{span}}(f_1,f_2)$, $S_2=\mathop{\mathrm{span}}(f_3,f_4)$, $S_3=\mathop{\mathrm{span}}(f_5,f_6)$. A unit decomposable $2$-form with support $S_1$ is $\pm f_1\wedge f_2$: writing $\omega_1=u\wedge v$ with $u,v$ spanning $S_1$, expand $u,v$ in $f_1,f_2$ and the wedge is a multiple of $f_1\wedge f_2$, of modulus $1$ by unit norm. So $\omega_1=\varepsilon_1f_1\wedge f_2$, $\omega_2=\varepsilon_2f_3\wedge f_4$, $\omega_3=\varepsilon_3f_5\wedge f_6$ with $\varepsilon_i=\pm1$, and the signs are absorbed by $\omega\otimes\omega$. Then
$$W=\sum_i\lambda_i\,(f_{2i-1}\wedge f_{2i})\otimes(f_{2i-1}\wedge f_{2i}),$$
whose components $W_{abcd}$ vanish unless $\{a,b\}=\{c,d\}\in\{\{1,2\},\{3,4\},\{5,6\}\}$, coordinate-diagonal in the brief's sense. $W\ne0$ since the $\lambda_i\ne0$. The imported fact then forces $\Lambda^2$-rank $\ge4$, contradicting rank three. **Sound, conditional on the imported fact, which I took as given per the brief and did not verify.** If $n<6$ the hypothesis is vacuous and the conclusion holds trivially.

**What (d) does not do.** It handles one sub-case of one case: all three forms decomposable *and* the planes mutually orthogonal. It says nothing about decomposable triples in general position, nothing about mixed triples, and nothing about the all-indecomposable case, which is where §13's object lives. **The record should not let (d) read as progress toward excluding rank three.**

## 11. The kernel

**Does any step assume $\ker W=0$, or anything close?** No, and the record is careful here. Item by item:

| step | how it handles the kernel |
| --- | --- |
| L179(a) | restricts the span to $\lambda_\alpha\ne0$ by construction; $\mathop{\mathrm{Im}}W$ is the span of exactly those eigenforms |
| L179(b) | says explicitly that the zero eigenvalues drop out |
| L179(c) | uses the trace, to which zero eigenvalues contribute nothing |
| L180(1) | the sum is over $\lambda_i\ne0$; $\lambda_i=0$ terms contribute $0\cdot A_i=0$ to the Ricci matrix, so including or excluding them is the same equation |
| L180(3),(4) | consume only $\lambda_i\ne0$, $\sum\lambda_i=0$, $\sum\lambda_iA_i=0$ |

At $n\ge12$, $\dim\Lambda^2=\binom n2\ge66$ and $r=3$, so $W$ is $63$-dimensional kernel and $3$-dimensional image; every statement above is a statement about the image and none of them degrades as the kernel grows. **Nothing assumes otherwise.**

**One kernel-adjacent hazard the record does not address, which I checked and found harmless.** With a repeated nonzero eigenvalue the orthonormal eigenbasis is not unique, so "the span of the supports of the $\omega_\alpha$" could in principle depend on the choice. It does not: if $\omega=\sum_\alpha c_\alpha\omega_\alpha$ then the skew matrix of $\omega$ is that linear combination of skew matrices, so $\mathop{\mathrm{supp}}\omega\subseteq\sum_\alpha\mathop{\mathrm{supp}}\omega_\alpha$. Applying this in both directions between two eigenbases of $\mathop{\mathrm{Im}}W$ gives equality of the spans. **So $V$ is well defined, and equals the span of the supports of all elements of $\mathop{\mathrm{Im}}W$.** This should be stated in L179(a); it is used and unstated. Note it also bears on §13's example, where $\lambda_2=\lambda_3=-1$ is a genuine repetition and $V$ is nevertheless unambiguous.

## 12. The boundary

| case | status |
| --- | --- |
| $n\le3$ | $\mathcal W_n=0$, so every statement is vacuous. No claim breaks. |
| $n=4$ exactly | $\dim\Lambda^2=6$. Everything holds, and **this is where §13's object lives.** L179(d)'s orthogonal-planes hypothesis is vacuous ($n<6$). |
| $n=5$ | $\dim\Lambda^2=10$. L179(d)'s hypothesis still vacuous. §13's object embeds. |
| odd $n$ | $\dim V$ even and $V\subseteq\mathbb R^n$ is no contradiction, $V$ is a proper subspace. Nothing breaks; the record should not read evenness of $\dim V$ as a statement about $n$. |
| $n=6+2\sqrt7\approx11.2915$ | Not an integer, so not a dimension. It appears in the conventions and in neither proof. **Stated and unused.** |
| $n<12$ | Both lemmas are dimension-free; they neither use nor need $n\ge12$. **Stated and unused.** This cuts against the record: the lemmas cannot be defended by restricting to the conjecture's range, and neither can the object in §13 be excluded by it. |
| $n\ge12$ | Everything holds; §13's object extends by zero and remains a rank-three algebraic Weyl tensor. |

## 13. Overreach, *"$\dim V\ge6$ is the whole of what remains"*

**Not entailed. Refuted.**

What L179 and L180 together prove about a rank-three $W\in\mathcal W_n$ is: $V=\mathop{\mathrm{supp}}\omega_{\min}$, $\dim V$ even, $\dim V\ge4$, and $\binom{\dim V}{2}\ge3$. Reaching "$\dim V\ge6$" requires excluding $\dim V=4$, and **no step on file excludes it.** That alone makes the conclusion `HYPOTHESIS-DEBT`. But it is worse than unsupported, because $\dim V=4$ is realised.

### The object, in closed form

Work in $\mathbb R^4\subseteq\mathbb R^n$ with orthonormal $f_1,f_2,f_3,f_4$, and set
$$\omega_1=\tfrac1{\sqrt2}\big(f_1\wedge f_2+f_3\wedge f_4\big),\qquad \omega_2=\tfrac1{\sqrt2}\big(f_1\wedge f_3-f_2\wedge f_4\big),\qquad \omega_3=\tfrac1{\sqrt2}\big(f_1\wedge f_4+f_2\wedge f_3\big),$$
$$W\ :=\ 2\,\omega_1\otimes\omega_1\ -\ \omega_2\otimes\omega_2\ -\ \omega_3\otimes\omega_3 ,$$
extended by zero to $\Lambda^2\mathbb R^n$. All values below are exact.

**Orthonormality.** Each $\omega_i$ has two coefficients of modulus $1/\sqrt2$ on distinct basis $2$-vectors, so $\lVert\omega_i\rVert^2=\tfrac12+\tfrac12=1$; the three pairs $\{12,34\},\{13,24\},\{14,23\}$ are disjoint, so the $\omega_i$ are mutually orthogonal. Hence $\mathop{\mathrm{rank}}_{\Lambda^2}W=3$, with $\lambda=(2,-1,-1)$, all nonzero. **Sign pattern $(+,-,-)$.**

**Support.** In skew-matrix form each $\omega_i$ has exactly one nonzero entry of modulus $1/\sqrt2$ in every row, so $A_i=\omega_i\omega_i^{\mathsf T}=\tfrac12I_4$, which is invertible. Therefore $S_1=S_2=S_3=\mathbb R^4$ and
$$\boxed{\ \dim V=4\ }$$
Consistent with L180(3): the minority sign is the single $+$, and $V=S_1$, which indeed contains $S_2$ and $S_3$.

**Total trace-freeness.** By L180(1), the condition is $\sum_i\lambda_iA_i=0$, and here
$$2\cdot\tfrac12I_4+(-1)\cdot\tfrac12I_4+(-1)\cdot\tfrac12I_4=\tfrac12(2-1-1)I_4=0 .$$
Checked independently by direct contraction: $\sum_bW_{1b1b}=W_{1212}+W_{1313}+W_{1414}=2\cdot\tfrac12-1\cdot\tfrac12-1\cdot\tfrac12=0$, and $\sum_bW_{1b2b}=\sum_bW_{1b3b}=0$ because in each surviving term one factor carries an index pair on which the relevant $\omega_i$ vanishes.

**First Bianchi.** With $f_{1234}:=f_1\wedge f_2\wedge f_3\wedge f_4$,
$$\omega_1\wedge\omega_1=\tfrac12\cdot2\,f_{12}\wedge f_{34}=f_{1234},\qquad \omega_2\wedge\omega_2=-f_{13}\wedge f_{24}=f_{1234},\qquad \omega_3\wedge\omega_3=f_{14}\wedge f_{23}=f_{1234},$$
using $f_{13}\wedge f_{24}=-f_{1234}$ and $f_{14}\wedge f_{23}=+f_{1234}$ (the permutation $1423$ is even). Hence
$$\sum_i\lambda_i\,\omega_i\wedge\omega_i=(2-1-1)\,f_{1234}=0 ,$$
which is L179(b), and by §9 is the first Bianchi identity. Checked componentwise as well: $W_{1234}=2\cdot\tfrac12=1$, $W_{1342}=-1\cdot\tfrac1{\sqrt2}\cdot\tfrac1{\sqrt2}=-\tfrac12$, $W_{1423}=-1\cdot\tfrac12=-\tfrac12$, and $1-\tfrac12-\tfrac12=0$. In $n=4$ the cyclic sum is totally antisymmetric, so $\Lambda^4\mathbb R^4$ being one-dimensional makes this single component sufficient.

**Extension to $n\ge12$.** Define $W_{abcd}=0$ whenever any index exceeds $4$. The Riemann symmetries are inherited. The cyclic sum vanishes for any quadruple with an index outside $\{1,2,3,4\}$, since every one of its three terms then contains that index and vanishes. And $\sum_{b=1}^nW_{abcb}$ is zero when $a$ or $c$ exceeds $4$, and otherwise reduces to the four-dimensional sum already checked. **So $W\in\mathcal W_n$ for every $n\ge4$, in particular throughout the conjecture's range $n\ge12$, with $\Lambda^2$-rank three and $\dim V=4$.**

**Independent confirmation at source.** $\omega_1,\omega_2,\omega_3$ are literally the vectors $\Xi_1,\Xi_2,\Xi_3$ of [Petersen–Wink, Remark 2.5](../references/petersen-wink-2019-bochner-curvature-conditions/notes.md), an orthonormal basis of the self-dual part $\Lambda^+\mathbb R^4$ in a Singer–Thorpe basis. That remark states: an operator diagonal in such a basis with eigenvalues $\lambda_1,\dots,\lambda_6$ satisfies the first Bianchi identity **iff** $\lambda_1+\lambda_2+\lambda_3=\lambda_4+\lambda_5+\lambda_6$. Here $(2,-1,-1)$ against $(0,0,0)$ gives $0=0$. It further states that such an operator is Einstein iff it commutes with the Hodge star, which a Singer–Thorpe-diagonal operator does; and $\mathop{\mathrm{tr}}=\sum_\alpha\lambda_\alpha=0$ makes the scalar curvature vanish, so the operator is Ricci-flat and equals its own Weyl tensor. **The construction is a special case of a published recipe, not an artefact of my algebra.**

**Screen.** I reconstructed $W_{abcd}$ from the definitions in exact rational arithmetic (seconds of compute, on an object I built for this purpose) and it returns, exactly: the three forms orthonormal; the pair symmetry and both antisymmetries; $W_{abcd}+W_{acdb}+W_{adbc}=0$ on all $4^4$ quadruples; $\sum_bW_{abcb}=0$ for all $a,c$; $\Lambda^2$-rank $3$; $\dim\mathop{\mathrm{supp}}\omega_i=4$ for each $i$; and $W_{1234}=1$, $W_{1342}=W_{1423}=-\tfrac12$. **Reported as a screen and cited for nothing.** The refutation stands on the closed-form derivation above and is complete without it.

### What this does and does not settle

- It **refutes** "$\dim V\ge6$ is the whole of what remains" for a rank-three tensor, and refutes any claim that rank three forces $\dim V\ge6$.
- It **does not** settle whether a rank-three Weyl tensor with $\dim V=6$ exists. That question is untouched.
- It **does not** contradict the imported coordinate-diagonal fact: this $W$ is diagonal in a Singer–Thorpe basis of $\Lambda^2$, which is not a coordinate basis, and no orthonormal frame of $\mathbb R^4$ makes it coordinate-diagonal.
- It **does not** contradict L179(d): none of $\omega_1,\omega_2,\omega_3$ is decomposable, since $\omega_i\wedge\omega_i=f_{1234}\ne0$, so (d)'s hypothesis fails.

**If the record intends "$\dim V\ge6$ is what remains" under some extra hypothesis (all forms decomposable, say, or $W$ not of self-dual type) then that hypothesis is not on file and the sentence is false as written.**

## Name what would break it

For each claim, the object whose existence falsifies it, and what I did to look. **I ran no search, sweep, census or falsifier hunt: the programme is on an analysis-only footing and I have no approval. Everything below was reasoned in closed form, and where I say "found" I mean written down and verified by hand.**

| claim | the falsifier | what I did |
| --- | --- | --- |
| L179(a) | a $W$ with some $W_{abcd}\ne0$ for an index outside $V$, i.e. $\mathop{\mathrm{Im}}W\not\subseteq\Lambda^2V$ | proved the inclusion from the definition of $V$ plus the block form of a skew matrix with image in $V$; the falsifier cannot exist |
| L179(b) | a $W\in\mathcal W_n$ with $\sum\lambda_\alpha\omega_\alpha\wedge\omega_\alpha\ne0$, or a Bianchi-violating $W$ with that sum zero | read the orthogonal decomposition $S^2\Lambda^2=S^2_B\Lambda^2\oplus\Lambda^4$ at source; the equivalence is exact and the falsifier cannot exist |
| L179(c) | a rank-one algebraic Weyl tensor | the $\Lambda^2$-trace is $\lambda\ne0$; excluded in one line |
| L179(d) | three mutually orthogonal planes carrying a rank-three Weyl tensor | reduced to a coordinate-diagonal $W$, which the imported fact excludes. **Conditional: I did not verify that fact.** If it is wrong, (d)'s second half falls |
| L180(1) | a mismatch between $\sum_bW_{abcb}$ and $(\sum_i\lambda_iA_i)_{ac}$ | re-derived both sides from the definitions in §2 and §3, and checked the symmetry of both in $a\leftrightarrow c$; they agree with no constant |
| L180(3) | a rank-three Weyl tensor whose $V$ is not any one form's support, or with $\dim V$ odd, or $\dim V=2$ | range additivity forbids the first two, the $\binom{\dim V}2\ge r$ count forbids the third; and my §13 object satisfies L180(3) exactly as predicted, which is a live consistency test rather than a proof |
| L180(4) | a rank-two Weyl tensor with $A_1\ne A_2$ | $\lambda_1(A_1-A_2)=0$ with $\lambda_1\ne0$; excluded. **Incidentally rank two is non-empty**: $(\lambda_1,\lambda_2,\lambda_3)=(1,-1,0)$ in §13's construction is a rank-two Weyl tensor with $A_1=A_2=\tfrac12I_4$ and $\dim V=4$ |
| **"$\dim V\ge6$ is what remains"** | **a rank-three Weyl tensor with $\dim V=4$** | **found, in closed form, §13.** Not by searching: the four-dimensional self-dual/anti-self-dual splitting is the one place where a three-dimensional space of everywhere-nondegenerate $2$-forms sits inside $\Lambda^2$, and a trace-free operator on it is automatically a Weyl tensor |

**The object the brief most wants (a rank-three Weyl tensor with six-dimensional support), I did not produce, and my failure to produce it settles nothing.** I did not look for one, because looking would be a search. What I can say analytically is where the pressure sits: at $\dim V=6$ the three orthonormal forms live in $\Lambda^2\mathbb R^6$, of dimension $15$, the Bianchi condition is one equation in $\Lambda^4\mathbb R^6\cong\mathbb R^{15}$, the Ricci condition $\sum\lambda_iA_i=0$ is $21$ scalar equations, and L180(3) additionally demands that the minority form be nondegenerate on all of $\mathbb R^6$ while the other two have support inside it. That is a well-posed closed-form question and it is the one I would put next.

## Overall verdict

**SOUND CORE, REFUTED COROLLARY.**

- **L179(a)–(d) and L180(1)–(4) are all correct as stated**, with the three repairs of §1 (adapted frame in L179(a); the $\mathop{\mathrm{supp}}\omega\subseteq V\Rightarrow\omega\in\Lambda^2V$ and eigenbasis-independence steps written down; the range-to-kernel passage in L180(3)) and with L179(d) recorded as conditional on an imported fact.
- **The normalisation of $W_{abcd}$ carries no factor of $2$ and no factor of $\tfrac12$**, and every conclusion in both lemmas is invariant under a positive renormalisation in any case. The record's factor-of-two history does not repeat here. The live convention hazard is instead $\lVert W\rVert$, which the brief never fixes, §0.
- **Range additivity is true, is now proved and sourced**, and is used correctly, the mixed signs are moved before it is applied, which is the only way it can be applied.
- **The evenness of $\dim V$ does not circle**, and its scope is narrower than it looks: it depends on a sign class being a singleton, which fails from rank four onward.
- **What the record concludes from all this is false.** A rank-three algebraic Weyl tensor with $\dim V=4$ exists in every $n\ge4$, exhibited in closed form in §13 and confirmed against a published construction. "$\dim V\ge6$ is the whole of what remains" must be struck.

## Files

Committed: this report alone, [reviews/REVIEW_r773.md](REVIEW_r773.md).

**Left uncommitted, for the parent to fold in**, as the brief directs: [references/yang-2024-semidefinite-optimization/](../references/yang-2024-semidefinite-optimization/) (fetched page, README, notes, the range-additivity source for item 5) and [references/petersen-wink-2019-bochner-curvature-conditions/](../references/petersen-wink-2019-bochner-curvature-conditions/) (PDF, text layer, README, notes, the Bianchi-decomposition source for item 9 and the Singer–Thorpe confirmation for §13). Neither folder is registered in [references/INDEX.md](../references/INDEX.md); registering them is the parent's call. The working tree also carries edits from other threads, which I did not touch.

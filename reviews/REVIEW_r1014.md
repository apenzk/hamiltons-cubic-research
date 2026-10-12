# r1014, the first variation of $P$ at an arbitrary direction and the full symmetry of $T$, an adversarial audit

*Cold brief, worked without reading the sibling reviewer. **No numerical work**: every value below is exact, rational or symbolic, and the two machine runs recorded are a build of the committed Lean layer and one screen, named as a screen where it appears. Log: [agent_logs/r1014.log](../agent_logs/r1014.log).*

| # | claim | verdict |
|---|---|---|
| 1 | Step 1's first equality, $\mathrm{sharpQF}(R,\eta)=-\tfrac12\operatorname{Tr}(\operatorname{ad}_\eta R\operatorname{ad}_\eta R)$ | **CORRECT AT A LINEAR $R$, SCOPE OVERSTATED** |
| 2 | Step 1's second equality, the polarisation in $\eta$ | **CORRECT** |
| 3 | Step 2's index expansion of $\Phi$ | **CORRECT, EVERY INDEX AND THE SIGN** |
| 4 | Step 3, the outer-slot swap | **CORRECT, NO HYPOTHESIS** |
| 5 | Step 3, the rotation at a symmetric first slot | **CORRECT, AND STRONGER THAN STATED** |
| 6 | Step 4's trace part | **CORRECT** |
| 7 | Step 4's conclusion and its reach | **CORRECT, AND NOTHING NEEDS $S$ SELF-ADJOINT OR $R$ WEYL**, with the Euler remark **AMBIGUOUS** |
| 8 | Step 5, $T$'s formula and its full symmetry | **CORRECT, WITH THE ATTRIBUTION "BY THE OUTER-SLOT SWAP ALONE" INCOMPLETE** |
| 9 | The by-hand check at $R=\mathrm{id}$ | **CORRECT, AND IT COULD HAVE FAILED** |
| 10 | The Lean side, statement fidelity and axioms | **FAITHFUL, THREE STANDARD AXIOMS, NO `sorry`** |
| 11 | The two `sorry`s | **FAITHFUL, ONE NARROWER THAN PROVED AND NEITHER WIDER** |
| 12 | Prose claiming more than is established | **THREE FOUND**, quoted in §12 |

**Actionable summary: the derivation is correct in every step and every constant, so the work is to delete "with no hypothesis on $R$" from step 1 and from [plan.md](../plan.md) line 150 in favour of "at every linear $R$, self-adjoint or not", and correct "two of the three need cyclicity" to "one of the three" in [TraceOp.lean](../lean/HamiltonsCubic/Results/TraceOp.lean), [FirstVariation.lean](../lean/HamiltonsCubic/Results/FirstVariation.lean) and [lean/INDEX.md](../lean/INDEX.md) line 137.**

## 0. Conventions, fixed once

$\Lambda^2$ is the skew matrices under $\langle A,B\rangle=\tfrac12\operatorname{tr}(A^{\mathsf T}B)$, which is [inner2](../lean/HamiltonsCubic/Base/WeylReal.lean). The family $\varphi_{ij}=\mathrm{single}_{ji}-\mathrm{single}_{ij}$ satisfies $\varphi_{ji}=-\varphi_{ij}$, $\varphi_{ii}=0$ and $\langle\varphi_{ij},\varphi_{ij}\rangle=1$ at $i\ne j$, so $\{\varphi_{ij}\}_{i<j}$ is an orthonormal basis, written $\{e\}$ below. **The ordered-pair convention used throughout**: for $F$ with $F(-X)=F(X)$ and $F(0)=0$, $\sum_{i,j}F(\varphi_{ij})=2\sum_{i<j}F(\varphi_{ij})$, so $\tfrac12\sum_{i,j}=\sum_e$. This is the $\tfrac12$ in [innerOp2](../lean/HamiltonsCubic/Base/Bivectors2.lean) and in [trOp](../lean/HamiltonsCubic/Results/TraceOp.lean), and it is the whole content of the $-\tfrac14$ against $-\tfrac12$ in item 1.

Operators are linear maps $\Lambda^2\to\Lambda^2$, $A^*$ is the adjoint against $\langle\,,\rangle$, $\operatorname{Tr}M=\sum_e\langle Me,e\rangle$, $\langle A,B\rangle_{\mathrm{op}}=\operatorname{Tr}(A^*B)=\sum_e\langle Ae,Be\rangle$, $A_{ge}=\langle g,Ae\rangle$ so that $(A^*)_{ge}=A_{eg}$, and $c_{efm}=\langle[e,f],m\rangle$.

## Hypothesis inventory

| fact | where it is used | is it on the record |
|---|---|---|
| $\operatorname{ad}_X$ skew-adjoint on $\Lambda^2$ at skew $X$ | step 2's move of $\operatorname{ad}_e$ across, and fact (iii) | yes, [ad_skewAdjoint](../lean/HamiltonsCubic/Results/L33Statement.lean), kernel-proved |
| $c$ totally antisymmetric | steps 3 and 5 | derived in the block from the line above, and the derivation of it is correct (§4) |
| $\operatorname{Tr}$ cyclic | steps 1, 4, 5 | yes, [trOp_comp_comm](../lean/HamiltonsCubic/Results/TraceOp.lean), kernel-proved |
| $\operatorname{Tr}M=\operatorname{Tr}M^*$ | steps 4, 5, and the final claim of step 5 | on the record as [innerOp2_comm](../lean/HamiltonsCubic/Base/Bivectors2.lean) in the form the layer uses |
| **$R$ linear on $\Lambda^2$ and $\Lambda^2$-valued** | **step 1, both equalities**, and hence everything downstream | **stated as OWED** in [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean), and supplied by the type in the `CurvOp2` layer |
| $R^*=R$ | step 4's trace part and the rotation instance $\Phi(R;S,R)=\Phi(S;R,R)$, and step 5's full symmetry | hypothesis of the claim |
| $S$ self-adjoint, $R$ Weyl, Bianchi, trace-freeness | **nowhere** | not needed, and §7 records that this is genuine |
| $Q(\mathcal W_n)\subseteq\mathcal W_n$ | not used, and correctly disclaimed by the block | absent from the record, as the block says |

## 1. Step 1's first equality

**The constant is right.** With $f(\varphi_{ij}):=\langle\operatorname{ad}_\eta R\operatorname{ad}_\eta R\,\varphi_{ij},\varphi_{ij}\rangle$ one has $f(\varphi_{ii})=0$ because $\varphi_{ii}=0$, and $f(\varphi_{ji})=f(\varphi_{ij})$ because both arguments change sign, so $-\tfrac14\sum_{i,j}f=-\tfrac12\sum_ef$. That is exactly the layer's $-\tfrac14$ read against the derivation's $-\tfrac12$, and it holds. The docstring of [sharpQF](../lean/HamiltonsCubic/Base/WeylReal.lean) gives the same account of its own constant, "the $\tfrac12$ of the definition times the $\tfrac12$ paying for the ordered-pair double count".

**"With no hypothesis on $R$" is false of the object the sentence names.** The sentence says *the layer's* $\mathrm{sharpQF}$, and the layer's $R$ has type `Matrix ι ι ℝ → Matrix ι ι ℝ`, an arbitrary function. Both halves of $f(\varphi_{ji})=f(\varphi_{ij})$ need $R(-X)=-R(X)$, and reading $\sum_e\langle Me,e\rangle$ as a trace of an operator on $\Lambda^2$ needs $R$ linear and bivector-valued.

**Located, exhibited, and argued against.** Take $R$ the constant map $X\mapsto C$ for a fixed nonzero skew $C$. Then $\operatorname{br}\eta(R(\operatorname{br}\eta(R\varphi_{ij})))=[\eta,C]$ for every $(i,j)$, and by [inner2_phi](../lean/HamiltonsCubic/Base/WeylReal.lean) the summand is $-[\eta,C]_{ij}$, so
$$\mathrm{sharpQF}(R,\eta)=-\tfrac14\sum_{i,j}\big(-[\eta,C]_{ij}\big)=0,$$
because a skew matrix sums to zero over all ordered pairs, while the asserted right side is $\tfrac12\sum_{i<j}[\eta,C]_{ij}$. At $n=3$, $\eta=\varphi_{12}$, $C=\varphi_{13}$ the bracket is $[\varphi_{12},\varphi_{13}]=\varphi_{23}$, whose only entry above the diagonal is $(\varphi_{23})_{23}=-1$, so the two sides are $0$ and $-\tfrac12$. Exact, by hand, no computation used. **The opposite reading**, and it is the strong one: the block's own conventions paragraph declares that operators are linear maps $\Lambda^2\to\Lambda^2$, so "no hypothesis" plainly means "no self-adjointness and no Weyl condition", and under that reading the equality is correct and the phrase is loose rather than wrong. **What decides it against the sentence** is that [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) records precisely this as an open debt of that file, "*`sharpQF R η = -½ tr(ad_η R ad_η R)` is quadratic in `η` only then*", where "then" is $R$ linear. A derivation that names the layer's object should not assert as hypothesis-free the one thing the layer files as owed.

**Impact: none on any conclusion.** In the `CurvOp2` layer the hypothesis is discharged by the type, and in the prose it is discharged by the conventions paragraph. The correction is one clause.

**And the "no self-adjointness" part of the claim is load-bearing rather than decorative**, which is worth saying because it is the reason the loose phrase was reached for: step 4 applies step 1 at $R+tS$, which is not self-adjoint for a general $S$, so the equality really is needed off the self-adjoint locus.

## 2. Step 1's second equality, the polarisation

Write $F(\eta):=-\tfrac12\operatorname{Tr}(\operatorname{ad}_\eta R\operatorname{ad}_\eta R)$, a quadratic form in $\eta$ since $\eta\mapsto\operatorname{ad}_\eta$ is linear. Then
$$\mathrm{sharpBil}(R,X,Y)=\tfrac12\big(F(X+Y)-F(X)-F(Y)\big)=-\tfrac14\big[\operatorname{Tr}(\operatorname{ad}_XR\operatorname{ad}_YR)+\operatorname{Tr}(\operatorname{ad}_YR\operatorname{ad}_XR)\big].$$
**The two cross terms do combine**, by cyclicity applied as a shift by two factors, $\operatorname{Tr}(\operatorname{ad}_YR\operatorname{ad}_XR)=\operatorname{Tr}(\operatorname{ad}_XR\operatorname{ad}_YR)$, giving $-\tfrac12\operatorname{Tr}(\operatorname{ad}_XR\operatorname{ad}_YR)$ as claimed. **Cyclicity alone**: self-adjointness of $R$ is used nowhere, and the derivation does not claim it here.

**The passage from $\mathrm{sharpBil}$ to $\langle R^\#X,Y\rangle$ is also right, and it is where linearity pays.** $Y\mapsto\mathrm{sharpBil}(R,X,Y)$ is linear because $\operatorname{ad}_Y$ is, so by Riesz it is $\langle V,\cdot\rangle$ for a unique $V\in\Lambda^2$, and [skew_expand](../lean/HamiltonsCubic/Base/WeylReal.lean) then gives $\tfrac12\sum_{i,j}\mathrm{sharpBil}(R,X,\varphi_{ij})\,\varphi_{ij}=V$, which is [sharpOp](../lean/HamiltonsCubic/Base/WeylReal.lean)'s definition. So $\mathrm{sharpOp}\,R\,X=R^\#X$ and $\langle R^\#X,Y\rangle=\mathrm{sharpBil}(R,X,Y)$ on bivectors. A by-product worth recording: the right side is symmetric in $X$ and $Y$ by the same cyclic shift, so $R^\#$ is self-adjoint at every linear $R$.

## 3. Step 2's index expansion

Verified term by term. $\Phi(A;B,C)=\sum_e\operatorname{Tr}(\operatorname{ad}_eB\operatorname{ad}_{Ae}C)=\sum_{e,f}\langle[e,B[Ae,Cf]],f\rangle$ by $\operatorname{Tr}M=\sum_f\langle Mf,f\rangle$, and one application of skew-adjointness with $U=B[Ae,Cf]$ and $V=f$ gives $-\sum_{e,f}\langle B[Ae,Cf],[e,f]\rangle=-\sum_{e,f}\langle[Ae,Cf],B^*[e,f]\rangle$. Then

- $[Ae,Cf]=\sum_{g,h}A_{ge}C_{hf}[g,h]=\sum_{g,h,k}A_{ge}C_{hf}\,c_{ghk}\,k$;
- $B^*[e,f]=\sum_mc_{efm}B^*m=\sum_{m,k}c_{efm}\,(B^*)_{km}\,k=\sum_{m,k}c_{efm}B_{mk}\,k$, which is the line the brief asks about, and $(B^*)_{km}=B_{mk}$ is the conventions paragraph's own rule read at the right pair;
- pairing the two against the orthonormal $k$ gives $\Phi(A;B,C)=-\sum_{e,f,g,h,k,m}c_{ghk}c_{efm}A_{ge}B_{mk}C_{hf}$.

**Every index placement and the single overall sign check out.** The one hypothesis consumed is that $A$, $B$, $C$ carry $\Lambda^2$ into $\Lambda^2$, since $Ae=\sum_gA_{ge}g$ drops nothing only then.

## 4. Step 3, the outer-slot swap

Total antisymmetry first, because the swap consumes it twice. $c_{efm}=\langle[e,f],m\rangle=-\langle f,[e,m]\rangle=\langle f,[m,e]\rangle=c_{mef}$ is correct, and with $c_{efm}=-c_{fem}$ from the bracket the two generate the alternating character on $S_3$. **The derivation's chain is right as written.**

Rename $g\leftrightarrow h$ and $e\leftrightarrow f$ in the six-index sum. The two $c$'s become $c_{hgk}c_{fem}=(-c_{ghk})(-c_{efm})=c_{ghk}c_{efm}$, **the two sign flips cancelling as claimed**, $B_{mk}$ is untouched, and $A_{ge}C_{hf}\mapsto A_{hf}C_{ge}$. The result is $-\sum c_{ghk}c_{efm}C_{ge}B_{mk}A_{hf}$, which is the index formula for $\Phi(C;B,A)$. **No hypothesis beyond §3's.**

## 5. Step 3, the rotation

**Correct, and I verified the matching twice by independent routes.** Route one is the derivation's own. Route two, which I ran to have an argument that does not reuse its bookkeeping: write out the target first,
$$\Phi(B;C,A^*)=-\sum c_{GHK}c_{EFM}B_{GE}C_{MK}(A^*)_{HF}=-\sum c_{GHK}c_{EFM}B_{GE}C_{MK}A_{FH},$$
and read off the unique substitution that makes the three matrix factors agree with $A_{ge}B_{mk}C_{hf}$: $G=m$, $E=k$ from $B$, $M=h$, $K=f$ from $C$, and $F=g$, $H=e$ from $A$. That is a bijection of the six labels, $(E,F,G,H,K,M)=(k,g,m,e,f,h)$. Under it $c_{GHK}=c_{mef}$ and $c_{EFM}=c_{kgh}$, and cyclicity gives $c_{efm}=c_{mef}$ and $c_{ghk}=c_{kgh}$, so the two summands are identical term by term. Hence
$$\Phi(A;B,C)=\Phi(B;C,A^*)\qquad\text{with no hypothesis},$$
and $\Phi(A;B,C)=\Phi(B;C,A)$ at $A^*=A$. **The substitution the derivation prints, $h'=e$, $k'=f$, $f'=g$, $m'=h$ together with its $m\to g'$, $k\to e'$, is exactly this bijection**, so the matching it performs is the one I reproduce, and nothing fails anywhere in it.

Two remarks. **The identity is stronger than the block claims**: the hypothesis-free form $\Phi(A;B,C)=\Phi(B;C,A^*)$ is what the relabelling actually gives, and self-adjointness enters only when one wants $A^*$ back as $A$. Recording the stronger form would cost nothing and would make step 4's use of it visibly a one-line specialisation. **And the two relations do generate $S_3$**: the swap is the transposition $(1\,3)$ of slots and the rotation is the $3$-cycle, so at three self-adjoint arguments $\Phi$ is fully symmetric, as the block says.

## 6. Step 4's trace part

The three trace terms of the $t$-coefficient are $\operatorname{Tr}(S^*R^*R)$, $\operatorname{Tr}(R^*S^*R)$ and $\operatorname{Tr}(R^*R^*S)$, from $U(S,R,R)$, $U(R,S,R)$ and $U(R,R,S)$ respectively.

| term | route to $\operatorname{Tr}(S^*R^2)$ | what it consumes |
|---|---|---|
| $\operatorname{Tr}(S^*R^*R)$ | substitute $R^*=R$ | $R^*=R$ alone |
| $\operatorname{Tr}(R^*S^*R)=\operatorname{Tr}(S^*RR^*)$ | cyclic shift, then $R^*=R$ | cyclicity and $R^*=R$ |
| $\operatorname{Tr}(R^*R^*S)=\operatorname{Tr}(R^2S)=\operatorname{Tr}\big((R^2S)^*\big)=\operatorname{Tr}(S^*(R^*)^2)$ | $\operatorname{Tr}M=\operatorname{Tr}M^*$, then $R^*=R$ | $\operatorname{Tr}M=\operatorname{Tr}M^*$ and $R^*=R$ |

**The sum is $3\operatorname{Tr}(S^*R^2)$ and the derivation's attribution, "by cyclicity and $\operatorname{Tr}(R^2S)=\operatorname{Tr}((R^2S)^*)$", names the two facts correctly.** All three also use $R^*=R$, which is the standing hypothesis of the step and so is not an omission. **Cyclicity is used by exactly one of the three**, which matters in §12.

## 7. Step 4's conclusion and its reach

**The boxed identity is right.** $U(A,B,C)=\operatorname{Tr}(A^*B^*C)-\tfrac12\Phi(A;B,C)$ is trilinear, each of the four factors being linear in each slot, and $P(R)=U(R,R,R)$ by step 1, so the displayed expansion of $P(R+tS)$ in $t$ is the ordinary expansion of a trilinear form on the diagonal and holds with no hypothesis. The $\Phi$ part of the $t$-coefficient is $3\Phi(S;R,R)$ by §4 for $\Phi(R;R,S)=\Phi(S;R,R)$ and by §5 for $\Phi(R;S,R)=\Phi(S;R,R^*)=\Phi(S;R,R)$. With §6 this is $3\operatorname{Tr}(S^*R^2)-\tfrac32\Phi(S;R,R)$, and $\langle S,R^2\rangle_{\mathrm{op}}=\operatorname{Tr}(S^*R^2)$ and $\langle S,R^\#\rangle_{\mathrm{op}}=-\tfrac12\Phi(S;R,R)$ turn it into $3\langle S,Q(R)\rangle_{\mathrm{op}}$.

**Nothing secretly needs $S$ self-adjoint.** I checked each step for a slot where $S$ appears: $S$ enters only as the first slot of $\Phi(S;R,R)$ and as $S^*$ inside a trace, and the two symmetries invoked place their hypothesis on $R$, which the swap does not need at all and the rotation needs in the slot occupied by $R$. **Nothing needs $R$ Weyl**: the Bianchi clause and trace-freeness of [IsWeyl2](../lean/HamiltonsCubic/Base/Bivectors2.lean) appear nowhere, and only self-adjointness is drawn on.

**One requirement is real and is met**: $S$ must be an operator on $\Lambda^2$, since step 1 is applied at $R+tS$ and §3's expansion needs every operator to carry $\Lambda^2$ into $\Lambda^2$. The block's own conventions supply it, and in the Lean layer the type `CurvOp2` supplies it. So "for every $S\in\operatorname{End}(\Lambda^2)$, at every self-adjoint $R$" is the correct scope, stated correctly.

**The Euler sentence is ambiguous and one of its two readings is false.** Read as "the case $S=R$ of the box contributes nothing beyond Euler's identity" it is correct and is a useful caution, since at $S=R$ the box gives $3\langle R,Q(R)\rangle_{\mathrm{op}}=3P(R)$ by [Pcubic2_eq_inner_Qop](../lean/HamiltonsCubic/Base/Bivectors2.lean), which homogeneity already gives. Read as written, "Euler's identity $DP(R)[R]=3P(R)$ **is** the case $S=R$ of it", it is false: Euler's identity holds at every $R$ by degree-three homogeneity, self-adjoint or not, while the box says nothing at a non-self-adjoint $R$. The same sentence appears in [FirstVariation.lean](../lean/HamiltonsCubic/Results/FirstVariation.lean)'s module docstring and in [lean/INDEX.md](../lean/INDEX.md) line 138, so the fix is three edits of the same phrase.

## 8. Step 5

**$X\circ Y=\tfrac12(XY+YX)+X\#Y$ is right.** $Q$ splits as $R\mapsto R^2$ plus $R\mapsto R^\#$, both quadratic, so the polarisation splits: $\tfrac12((X+Y)^2-X^2-Y^2)=\tfrac12(XY+YX)$, and $X\#Y:=\tfrac12((X+Y)^\#-X^\#-Y^\#)$ is the polarisation of the second with $X\#X=X^\#$.

**The $T$ formula follows.** $\langle\tfrac12(XY+YX),Z\rangle_{\mathrm{op}}=\tfrac12\operatorname{Tr}(Z^*XY)+\tfrac12\operatorname{Tr}(Z^*YX)$ using the symmetry $\operatorname{Tr}(A^*B)=\operatorname{Tr}(B^*A)$ of the pairing, and polarising $\langle Z,R^\#\rangle_{\mathrm{op}}=-\tfrac12\Phi(Z;R,R)$ in $R$ gives $\langle Z,X\#Y\rangle_{\mathrm{op}}=-\tfrac14[\Phi(Z;X,Y)+\Phi(Z;Y,X)]$, because $\Phi$ is bilinear in its second and third slots. Summing reproduces the displayed $T(X,Y,Z)$ exactly.

**Full symmetry at self-adjoint $X,Y,Z$ holds.** The trace half is $\tfrac12[\operatorname{Tr}(XYZ)+\operatorname{Tr}(XZY)]$, the sum over both cyclic classes, hence invariant under all of $S_3$, and the $\Phi$ half is $\tfrac12\Phi(X;Y,Z)$ once §5's full symmetry applies, hence invariant too.

**The final claim is correct, and the attribution is incomplete.** $T(X,Y,Z)=\tfrac12[U(X,Y,Z)+U(Y,X,Z)]$ identically, as claimed. Its $\Phi$ half is the outer-slot swap and nothing else: $\Phi(X;Y,Z)+\Phi(Y;X,Z)=\Phi(Z;Y,X)+\Phi(Z;X,Y)$ by §4 applied twice. **Its trace half is not the swap**, it is fact (i)'s $\operatorname{Tr}M=\operatorname{Tr}M^*$: $\operatorname{Tr}(X^*Y^*Z)=\operatorname{Tr}(Z^*YX)$ and $\operatorname{Tr}(Y^*X^*Z)=\operatorname{Tr}(Z^*XY)$. So "by the outer-slot swap alone" should read "by the outer-slot swap on the $\Phi$ half and $\operatorname{Tr}M=\operatorname{Tr}M^*$ on the trace half". Both facts are on the record, so this is a wording correction. The rider "step 4's coefficient is $3T(R,R,S)$" is correct and inherits step 4's $R^*=R$, since $U(S,R,R)+U(R,S,R)+U(R,R,S)$ collapses to $3U(R,R,S)=3T(R,R,S)$ only there.

**One precision on "hence $L_e$ is self-adjoint there".** What the symmetry gives on $\mathcal W_n$ is that the form $(X,Y)\mapsto T(e,X,Y)$ is symmetric, hence that the **compression** $P_{\mathcal W}\circ(e\circ\cdot)|_{\mathcal W_n}$ is self-adjoint. Upgrading that to self-adjointness of $e\circ(\cdot)$ as an operator on $\mathcal W_n$ needs $Q(\mathcal W_n)\subseteq\mathcal W_n$, which the block's own closing paragraph says is absent from the record. The two readings agree once that fact lands, and the compression is what [Lemma L24](../findings/second-order.md) consumes, so nothing downstream breaks. The sentence would be exact with "the compression" in it.

## 9. The by-hand check

**The normalisation conversion is correct.** [sum_inner2_ad2](../lean/HamiltonsCubic/Base/StructureConstants.lean) reads, on disk,
$$\sum_{i}\sum_{j}\langle\operatorname{ad}_X\operatorname{ad}_Y\varphi_{ij},\varphi_{ij}\rangle=2\big(n-2\big)\operatorname{tr}(XY),$$
an **ordered** double sum on the left and the **matrix** trace on the right. Converting both sides: the left is $2\operatorname{Tr}(\operatorname{ad}_X\operatorname{ad}_Y)$ by the ordered-pair rule, and the right is $-4(n-2)\langle X,Y\rangle$ because $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)=-\tfrac12\operatorname{tr}(XY)$ at skew $X$. Hence $\operatorname{Tr}(\operatorname{ad}_X\operatorname{ad}_Y)=-2(n-2)\langle X,Y\rangle$, which is exactly the derivation's "read in the present normalisation", and with $(\operatorname{ad}_X)^*=-\operatorname{ad}_X$ it is the same as its $\langle\operatorname{ad}_X,\operatorname{ad}_Y\rangle_{\mathrm{op}}=2(n-2)\langle X,Y\rangle$. **The step the brief asked me to check rather than grant is sound.**

The check then runs: $\Phi(S;\mathrm{id},\mathrm{id})=\sum_e\operatorname{Tr}(\operatorname{ad}_e\operatorname{ad}_{Se})=-2(n-2)\sum_e\langle e,Se\rangle=-2(n-2)\operatorname{Tr}S$, so $3\langle S,\mathrm{id}^\#\rangle_{\mathrm{op}}=-\tfrac32\Phi=3(n-2)\operatorname{Tr}S$, and $\mathrm{id}^\#=(n-2)\mathrm{id}$ gives $3(n-2)\operatorname{Tr}(S^*)=3(n-2)\operatorname{Tr}S$. **The two sides agree.**

**Could it have failed?** Yes, and that is worth stating positively. The two anchors it joins, [sum_inner2_ad2](../lean/HamiltonsCubic/Base/StructureConstants.lean) and [sharpOp_id](../lean/HamiltonsCubic/Base/StructureConstants.lean), are kernel-proved independently of anything in this block, and the check fixes three separate constants at once: the $-\tfrac14$ to $-\tfrac12$ conversion of §1, the $-\tfrac12$ in $\langle R^\#X,Y\rangle$ of §2, and the ordered-to-unordered factor in $\sum_e$. Any single factor of $2$ wrong in steps 1 or 2 would break it. **What it does not test is steps 3 to 5**: at $R=\mathrm{id}$ the form $\Phi(S;\mathrm{id},\mathrm{id})$ is symmetric for trivial reasons, so no relabelling is exercised. It is a normalisation check and the block presents it as one.

## 10. The Lean side

**Built under the project toolchain.** `lake env lean --version` reports Lean 4.33.1 and `lake build` completes, 9218 jobs, warnings only.

**`trOp` is the trace, not a differently-normalised pairing.** $\mathrm{trOp}\,M=\tfrac12\sum_{i,j}\langle M\varphi_{ij},\varphi_{ij}\rangle$, and since a `CurvOp2` is linear the summand is even under $(i,j)\mapsto(j,i)$ and vanishes on the diagonal, so $\mathrm{trOp}\,M=\sum_{i<j}\langle M\varphi_{ij},\varphi_{ij}\rangle=\operatorname{Tr}M$ against the orthonormal $\{\varphi_{ij}\}_{i<j}$. The $\tfrac12$ is the ordered-pair payment, not an extra factor.

**`innerOp2_eq_trOp`'s hypothesis is on the right argument.** Its signature is `{A : CurvOp2 ι} (hA : IsSelfAdjoint2 A) (B : CurvOp2 ι) : innerOp2 A B = trOp (A ∘SL B)`. Since $\mathrm{innerOp2}\,A\,B=\operatorname{Tr}(A^*B)$ and $\mathrm{trOp}(A\circ B)=\operatorname{Tr}(AB)$, the hypothesis belongs on $A$ and is on $A$. It is also necessary in the quantified form, $\operatorname{Tr}((A^*-A)B)=0$ for every $B$ forcing $A^*=A$, so the file's "and only there" is right.

**`trCube2_first_variation` states the composition half of step 4, in full.** Its three summands are $\mathrm{innerOp2}(S\circ R)R=\operatorname{Tr}(R^*S^*R)$, $\mathrm{innerOp2}(R\circ S)R=\operatorname{Tr}(S^*R^*R)$ and $\mathrm{innerOp2}(R^2)S=\operatorname{Tr}(R^*R^*S)$, which are exactly §6's three terms, and the right side $3\,\mathrm{innerOp2}\,S\,(R^2)=3\operatorname{Tr}(S^*R^2)$ is exactly §6's value. **It is not weaker.** What it does not contain is the statement that these three are the $t$-coefficient of $\langle(R+tS)^2,R+tS\rangle$; that expansion is unformalised and is listed as owed at [plan.md](../plan.md) line 156.

**`#print axioms`**, run through `lake env lean`:

| declaration | axioms |
|---|---|
| `trOp_comp_comm`, `trOp_comp_entries`, `sum4_swap`, `innerOp2_eq_trOp`, `trCube2_first_variation`, `foxTri2_comm` | `propext`, `Classical.choice`, `Quot.sound` |
| `sum_inner2_ad2`, `sharpOp_id` | `propext`, `Classical.choice`, `Quot.sound` |
| `hasDerivAt_Pcubic2_line`, `foxTri2_symm_right` | the same three plus `sorryAx` |

**The six proved declarations are clean and the two statements carry their `sorry` visibly, as the file says.**

## 11. The two `sorry`s

**`hasDerivAt_Pcubic2_line` states step 4 and no more.** Its signature, `(R S : CurvOp2 ι) (hR : IsSelfAdjoint2 R) : HasDerivAt (fun t : ℝ => Pcubic2 (R + t • S)) (3 * innerOp2 S (Qop2 R)) 0`, quantifies $S$ freely and puts self-adjointness on $R$ alone, matching the box exactly.

**`HasDerivAt` along a line is the right notion for what the block derives.** The block proves an identity of polynomials in $t$ and reads its linear coefficient, which is precisely a derivative of a real function of one real variable, and `HasDerivAt` needs no topology on `CurvOp2`. It is weaker than the Fréchet form, and the module docstring says so and lists `HasFDerivAt` as owed, which is honest. A Fermat argument over a sphere will want the Fréchet form or a family of lines, and [plan.md](../plan.md) line 156 carries that as owed too.

**The $\tfrac12$ in `innerOp2` makes `3 * innerOp2 S (Qop2 R)` the right value, not a doubled one.** $\mathrm{innerOp2}\,S\,T=\tfrac12\sum_{i,j}\langle S\varphi_{ij},T\varphi_{ij}\rangle=\sum_e\langle Se,Te\rangle=\langle S,T\rangle_{\mathrm{op}}$, the $\tfrac12$ paying the ordered-pair double count rather than rescaling the pairing. And $\mathrm{Qop2}\,R=\mathrm{compOp2}\,R+\mathrm{sharpMapCL}\,R$ is $R^2+R^\#$ with [sharpMap](../lean/HamiltonsCubic/Base/Bivectors2.lean) carrying the same $\tfrac12\sum_{i,j}$ reassembly as [sharpPair2](../lean/HamiltonsCubic/Base/Bivectors2.lean) uses, so the two normalisations match. The value is $3\langle S,Q(R)\rangle_{\mathrm{op}}$.

**`foxTri2_symm_right` is narrower than what step 5 proves, and that is the safe direction.** Step 5 gives full symmetry at self-adjoint arguments; the signature asks only for the last-two-slot transposition at self-adjoint $X,Y,Z$. With [foxTri2_comm](../lean/HamiltonsCubic/Results/FirstVariation.lean), which is proved with no hypothesis because [foxProd2](../lean/HamiltonsCubic/Results/FirstVariation.lean) is visibly symmetric in $X$ and $Y$, the two transpositions generate $S_3$, so the pair is equivalent to full symmetry at a self-adjoint triple. **Neither statement is wider than the derivation.** One genuine narrowing worth noting: the derivation's $\Phi$ symmetries need self-adjointness only in the rotated slot, so a sharper signature is available, but a reviewer does not ask for the sharpest statement, only for a true one.

## 12. Claims that reach past what is established

**(a) "with no hypothesis on $R$", in step 1 of [second-order.md](../findings/second-order.md) and again in [plan.md](../plan.md) line 150**, which reads *"$\langle R^\#X,Y\rangle=-\tfrac12\operatorname{Tr}(\operatorname{ad}_XR\operatorname{ad}_YR)$ with no hypothesis"*. Linearity of $R$ is a hypothesis, it is consumed twice, and [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) files it as an open debt of the very definition the sentence quotes. §1 exhibits the failure at a constant $R$. **The repair is "at every linear $R$, self-adjoint or not", which is what the block means and what it needs.**

**(b) "two of the three need cyclicity", in three places.** [TraceOp.lean](../lean/HamiltonsCubic/Results/TraceOp.lean)'s docstring for `trCube2_first_variation` says *"Two of the three need cyclicity and the third does not"*; [FirstVariation.lean](../lean/HamiltonsCubic/Results/FirstVariation.lean) says *"two of them by cyclicity of the trace, which is why that file exists"*; [lean/INDEX.md](../lean/INDEX.md) line 137 says *"two of them needing cyclicity and one not"*. **Exactly one of the three needs it.** The committed proof shows this on its face: `h2` is `rw [innerOp2_comm, innerOp2_eq_trOp hR, ← ContinuousLinearMap.comp_assoc]; rfl`, associativity and no cyclicity, and `h3` is a bare application of `innerOp2_eq_trOp`. Only `h1` calls `trOp_comp_comm`. **Screened**, and reported as a screen: I re-proved `h2`, `h3` and the right-hand side in a scratch file importing [TraceOp.lean](../lean/HamiltonsCubic/Results/TraceOp.lean), with no mention of `trOp_comp_comm` in any proof term, and all three elaborate under `lake env lean`. The mathematics of §6 agrees independently: term two needs $R^*=R$ alone and term three needs $\operatorname{Tr}M=\operatorname{Tr}M^*$, which the layer absorbs into `innerOp2_comm`. **The conclusion "which is why that file exists" survives**, since one term still needs cyclicity and the pairing cannot supply it; only the count is wrong.

**(c) "Euler's identity is the case $S=R$ of it and nothing more"**, in [second-order.md](../findings/second-order.md) step 4, [FirstVariation.lean](../lean/HamiltonsCubic/Results/FirstVariation.lean)'s docstring and [lean/INDEX.md](../lean/INDEX.md) line 138. Euler's identity holds at every $R$ by homogeneity, where the box holds only at self-adjoint $R$, so the identification runs one way only. §7 gives both readings. **The repair is "and its case $S=R$ adds nothing to Euler's identity".**

**(d) A lesser one, recorded rather than pressed**: "hence $L_e$ is self-adjoint there" in step 5, which is exact for the compression and needs $Q(\mathcal W_n)\subseteq\mathcal W_n$ for the operator reading, as §8 sets out. The block's closing paragraph already disclaims that fact, so the defect is that two sentences of the same block read differently rather than that anything is overclaimed against the record.

**Where I found nothing.** [lean/INDEX.md](../lean/INDEX.md) line 138's "NOT stated" list is accurate on all three of its entries. The I36 block of [plan.md](../plan.md) marks the derivation "UNREVIEWED" and lists the $\Phi$ half, the expansion in $t$ and the Fréchet form as owed, which matches what the layer holds. [sharpQF_reduced](../lean/HamiltonsCubic/Results/SharpReduced.lean) carries both of its hypotheses explicitly and its own file says it is the first step and not the theorem. The closing paragraph of the block, on $\operatorname{Ric}(Q(W))=0$, understates rather than overstates what is on file.

## Overall verdict

**PROVEN (hypotheses corrected).**

Every step of the derivation is correct, every constant is correct, and the two symmetries of $\Phi$ carry the argument exactly as claimed; the rotation, which the brief flagged as the likeliest failure, verifies term by term under two independent routes and is in fact true without the self-adjointness it is stated with. The correction is to one hypothesis, **$R$ linear on $\Lambda^2$ in step 1**, which the block's own conventions supply and which the Lean layer's `CurvOp2` supplies by type, together with the three wording repairs of §12.

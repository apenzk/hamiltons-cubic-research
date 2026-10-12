# Review r1013: the first variation of $P$ at an arbitrary direction, and the full symmetry of $T$ on self-adjoint operators

*Cold brief, worked from the block in [second-order.md](../findings/second-order.md#the-first-variation-of-p-at-an-arbitrary-direction-and-the-full-symmetry-of-t-on-self-adjoint-operators-the-derivation) read off disk. No numerical work: every value below is exact, rational or symbolic. One screen was run, reported as a screen in section 5 and cited for nothing positive. Log: [agent_logs/r1013.log](../agent_logs/r1013.log).*

| # | claim | verdict |
|---|---|---|
| 1 | Step 1's first equality, $\mathrm{sharpQF}(R,\eta)=-\tfrac12\operatorname{Tr}(\operatorname{ad}_\eta R\operatorname{ad}_\eta R)$, "no hypothesis on $R$" | CORRECT, QUALIFIER NARROWED |
| 2 | Step 1's second equality, $\mathrm{sharpBil}(R,X,Y)=-\tfrac12\operatorname{Tr}(\operatorname{ad}_XR\operatorname{ad}_YR)$ | CORRECT |
| 3 | Step 2's index expansion of $\Phi$ | CORRECT |
| 4 | Step 3's outer-slot swap $\Phi(A;B,C)=\Phi(C;B,A)$ | CORRECT |
| 5 | Step 3's rotation $\Phi(A;B,C)=\Phi(B;C,A^{\mathsf T})$, hence $\Phi(B;C,A)$ at symmetric $A$ | CORRECT |
| 6 | Step 4's trace part | CORRECT |
| 7 | Step 4's boxed identity and its stated reach | CORRECT |
| 8 | Step 5, $X\circ Y$, the $T$ formula, and $T=\tfrac12[U+U^{\mathrm{swap}}]$ identically | CORRECT, ONE CITATION SHORT |
| 9 | The by-hand check at $R=\mathrm{id}$ | CORRECT, AND IT COULD HAVE FAILED |
| 10 | The Lean side: `trOp`, `innerOp2_eq_trOp`, `trCube2_first_variation` | FAITHFUL, AXIOMS CLEAN |
| 11 | The two `sorry`s: `hasDerivAt_Pcubic2_line`, `foxTri2_symm_right` | FAITHFUL |
| 12 | Prose, [plan.md](../plan.md)'s I36 item, [lean/INDEX.md](../lean/INDEX.md)'s rows: overreach | THREE FOUND |

**Actionable summary.** The derivation is right at every step, including the rotation, and the three repairs owed are textual: restrict step 1's "with no hypothesis on $R$" to "no hypothesis beyond the conventions' standing linearity", delete "and not otherwise" from the $\operatorname{Tr}R^3$ aside, and correct "two of the three need cyclicity" to one in [TraceOp.lean](../lean/HamiltonsCubic/Results/TraceOp.lean), [FirstVariation.lean](../lean/HamiltonsCubic/Results/FirstVariation.lean) and [lean/INDEX.md](../lean/INDEX.md) row 137.

## 0. Conventions, fixed once

I use the derivation's own conventions, which I re-derive rather than grant where they carry content.

- $\Lambda^2$ is the skew matrices with $\langle A,B\rangle=\tfrac12\operatorname{tr}(A^{\mathsf T}B)$. The family $\varphi_{ij}=E_{ji}-E_{ij}$ at $i<j$ is orthonormal: $\varphi_{ij}^{\mathsf T}\varphi_{ij}=E_{ii}+E_{jj}$ has trace $2$, so $\langle\varphi_{ij},\varphi_{ij}\rangle=1$, and $\varphi_{ii}=0$, $\varphi_{ji}=-\varphi_{ij}$.
- The ordered-pair identity used throughout: for $f$ with $f(-X)=f(X)$, $\sum_{i,j}f(\varphi_{ij})=2\sum_{i<j}f(\varphi_{ij})=2\sum_ef(e)$, the $i=j$ terms vanishing because $\varphi_{ii}=0$. **Evenness of $f$ is what the halving needs, and it is the one place where linearity of $R$ enters step 1.**
- $\operatorname{Tr}M=\sum_e\langle Me,e\rangle$, $\langle A,B\rangle_{\mathrm{op}}=\operatorname{Tr}(A^*B)=\sum_e\langle Ae,Be\rangle$, $A_{ge}=\langle g,Ae\rangle$, $(A^*)_{ge}=\langle g,A^*e\rangle=\langle Ag,e\rangle=A_{eg}$, $c_{efm}=\langle[e,f],m\rangle$.
- Screened for normalisation: $\operatorname{Tr}(\mathrm{id})=\tfrac12\sum_{i,j}\langle\varphi_{ij},\varphi_{ij}\rangle=\tfrac12n(n-1)=\dim\Lambda^2$, so `trOp` is the trace and not a rescaled pairing.

## Hypothesis inventory

What the derivation actually consumes, listed once so each section can name its line.

| label | hypothesis | where it is consumed |
|---|---|---|
| (L) | $R$ is a linear map $\Lambda^2\to\Lambda^2$, so in particular $R$ is odd and preserves skewness | step 1's halving of the ordered double sum, and every occurrence of $\operatorname{Tr}$ and of cyclicity |
| (C) | $\operatorname{Tr}$ is cyclic on $\operatorname{End}(\Lambda^2)$ | step 1's polarisation, step 4's middle trace term, step 5's trace half |
| (T) | $\operatorname{Tr}M=\operatorname{Tr}M^*$ | step 4's third trace term, step 5's trace half, and the identification $\operatorname{Tr}(R^*R^*R)=\operatorname{Tr}(R^*R^2)$ |
| (S) | $c$ totally antisymmetric, from `ad_skewAdjoint` | steps 2, 3 |
| (A) | $R^*=R$ | step 4 only, in the trace part and in the one application of the rotation |
| (none) | **Jacobi is never used.** Every identity in steps 2 to 5 is tensor algebra in a totally antisymmetric $c$, and holds for a $c$ that is no Lie algebra's | nowhere |

## 1. Step 1's first equality, and what "no hypothesis on $R$" covers (attack item 1)

The layer's definition, read off [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean), is `sharpQF R η = -(1/4) * ∑ i, ∑ j, inner2 (br η (R (br η (R (phi i j))))) (phi i j)`, and $\operatorname{ad}_\eta R\operatorname{ad}_\eta R\,e=[\eta,R[\eta,Re]]$ matches the composite exactly, in that order. The constant is right: the summand is even in $\varphi$ under (L), the $i=j$ terms vanish, so $-\tfrac14\sum_{i,j}=-\tfrac12\sum_e$, and $-\tfrac12\sum_e\langle Me,e\rangle=-\tfrac12\operatorname{Tr}M$.

**The qualifier is the finding.** Two things are consumed, neither of them self-adjointness or Weylness.

1. The halving needs $f(-\varphi)=f(\varphi)$, which needs $R(-X)=-R(X)$.
2. $\operatorname{Tr}$ on $\operatorname{End}(\Lambda^2)$ needs $\operatorname{ad}_\eta R\operatorname{ad}_\eta R$ to be a linear endomorphism of $\Lambda^2$, so $R$ must be linear and map bivectors to bivectors. Without skew-preservation, $\langle Me,e\rangle$ is still a number but it is the trace of $\mathrm{proj}_{\Lambda^2}\circ M$, and cyclicity, which steps 2 and 4 use, is then unavailable.

Both are granted by the derivation's own conventions block, "Operators $A,B,\dots$ are linear maps $\Lambda^2\to\Lambda^2$", so inside this document "with no hypothesis on $R$" is a true statement about the *further* hypotheses. It is false when read against the layer, whose `sharpQF` takes a bare `Matrix ι ι ℝ → Matrix ι ι ℝ`, and the sentence names the layer ("The layer's $\mathrm{sharpQF}$").

**Located and exhibited.** At $n=3$ take $R$ to be the identity on every matrix except $R(\varphi_{10})=0$. This is a legitimate argument to the layer's `sharpQF`. At $\eta=\varphi_{02}$: $[\varphi_{02},\varphi_{01}]=-\varphi_{12}$ and $[\varphi_{02},\varphi_{12}]=\varphi_{01}$, so the ordered sum collects $-1$ at $(0,1)$, $0$ at $(1,0)$ by the modification, $0$ at $(0,2)$ and $(2,0)$ because $[\eta,\eta]=0$, and $-1$ at each of $(1,2)$ and $(2,1)$, total $-3$ and `sharpQF` $=3/4$. The unordered reading gives $f(\varphi_{01})+f(\varphi_{02})+f(\varphi_{12})=-2$ and $-\tfrac12(-2)=1\ne 3/4$.

**The opposite reading, argued.** The conventions block fixes operators as linear maps $\Lambda^2\to\Lambda^2$ before step 1 is stated, and no later step is applied to anything outside that class, so the mathematics is untouched. The defect is that the phrase is quoted verbatim into [plan.md](../plan.md) (section 12), where the conventions block does not travel with it.

**Corroboration from the kernel.** Push the same computation one step further with (A) added: $-\tfrac12\operatorname{Tr}(\operatorname{ad}_\eta R\operatorname{ad}_\eta R)=\tfrac12\sum_e\langle R\operatorname{ad}_\eta Re,\operatorname{ad}_\eta e\rangle=\tfrac12\sum_e\langle[\eta,Re],R[\eta,e]\rangle$, which in ordered pairs is $\tfrac14\sum_{i,j}\langle[\eta,R\varphi_{ij}],R[\eta,\varphi_{ij}]\rangle$. That is `sharpQF_reduced` in [SharpReduced.lean](../lean/HamiltonsCubic/Results/SharpReduced.lean) on the nose, sign and constant included, and it is kernel-proved. Its hypotheses are `hskew` and `hsa`, which is the layer agreeing that skew-preservation is not free.

## 2. Step 1's second equality (attack item 2)

Write $g(\eta)=-\tfrac12\operatorname{Tr}(\operatorname{ad}_\eta R\operatorname{ad}_\eta R)$. Since $\operatorname{ad}$ is linear in its subscript,
$$g(X+Y)=g(X)+g(Y)-\tfrac12\big[\operatorname{Tr}(\operatorname{ad}_XR\operatorname{ad}_YR)+\operatorname{Tr}(\operatorname{ad}_YR\operatorname{ad}_XR)\big],$$
so $\mathrm{sharpBil}(R,X,Y)=\tfrac12[g(X+Y)-g(X)-g(Y)]=-\tfrac14\big[\operatorname{Tr}(\operatorname{ad}_XR\operatorname{ad}_YR)+\operatorname{Tr}(\operatorname{ad}_YR\operatorname{ad}_XR)\big]$.

The two cross terms do combine, and what combines them is (C) alone, applied as the two-place cyclic shift $\operatorname{Tr}(MNPQ)=\operatorname{Tr}(PQMN)$ at $M=\operatorname{ad}_Y,N=R,P=\operatorname{ad}_X,Q=R$. **Self-adjointness of $R$ is not used and is not needed.** Hence $\mathrm{sharpBil}(R,X,Y)=-\tfrac12\operatorname{Tr}(\operatorname{ad}_XR\operatorname{ad}_YR)$, which is symmetric in $X,Y$, matching the kernel-proved `sharpBil2_comm` in [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean).

Two consequences the derivation uses without saying so, both sound. First, the right side is linear in $Y$, which is what licenses reading $\mathrm{sharpOp}$'s coordinate reassembly as a vector: $\mathrm{sharpOp}\,R\,X=\tfrac12\sum_{i,j}\mathrm{sharpBil}(R,X,\varphi_{ij})\varphi_{ij}=\sum_e\langle R^\#X,e\rangle e$, so $\langle R^\#X,Y\rangle=\mathrm{sharpBil}(R,X,Y)$ for every $Y\in\Lambda^2$. Second, $R^\#$ is self-adjoint for *every* $R$ in the class, since $\operatorname{Tr}(\operatorname{ad}_XR\operatorname{ad}_YR)$ is symmetric in $X,Y$ by (C). Section 8 needs that.

Finally $\langle S,R^\#\rangle_{\mathrm{op}}=\sum_e\langle R^\#e,Se\rangle=-\tfrac12\sum_e\operatorname{Tr}(\operatorname{ad}_eR\operatorname{ad}_{Se}R)=-\tfrac12\Phi(S;R,R)$, using only that $Se\in\Lambda^2$, which holds for any $S\in\operatorname{End}(\Lambda^2)$.

**One item worth recording positively**: $P(R)=\operatorname{Tr}(R^*R^*R)-\tfrac12\Phi(R;R,R)$ needs $\operatorname{trCube}=\sum_e\langle R^2e,Re\rangle=\operatorname{Tr}(R^*R^2)$ to equal $\operatorname{Tr}(R^*R^*R)$, and it does, at every $R$, because $(R^*R^*R)^*=R^*RR$ and (T). The two forms are interchangeable and the derivation's switch between them is safe.

## 3. Step 2's index expansion (attack item 3)

Expanding the trace over a second basis, $\Phi(A;B,C)=\sum_{e,f}\langle[e,B[Ae,Cf]],f\rangle$. Fact (ii) at $X=e$ gives $\langle[e,U],f\rangle=-\langle U,[e,f]\rangle$, so
$$\Phi(A;B,C)=-\sum_{e,f}\langle B[Ae,Cf],[e,f]\rangle=-\sum_{e,f}\langle[Ae,Cf],B^*[e,f]\rangle,$$
the last step being the definition of the adjoint. Both moves are as printed.

Now the three expansions. $[Ae,Cf]=\sum_{g,h}A_{ge}C_{hf}[g,h]=\sum_{g,h,k}A_{ge}C_{hf}c_{ghk}\,k$. For the other factor, $[e,f]=\sum_mc_{efm}m$ and $B^*m=\sum_k(B^*)_{km}k=\sum_kB_{mk}k$, so $B^*[e,f]=\sum_{m,k}c_{efm}B_{mk}\,k$, **which is the printed line, and its index order is right**: the adjoint is what turns $B_{km}$ into $B_{mk}$, by $(B^*)_{km}=B_{mk}$ as fixed in section 0. Pairing the two and using $\langle k,k'\rangle=\delta_{kk'}$,
$$\Phi(A;B,C)=-\sum_{e,f,g,h,k,m}c_{ghk}\,c_{efm}\,A_{ge}\,B_{mk}\,C_{hf},$$
sign and every placement as printed. **Nothing beyond (L), (S) and the definition of the adjoint is used, and Jacobi is not.**

## 4. Step 3's outer-slot swap (attack item 4)

Substitute the dummy names $(e,f,g,h)\mapsto(f,e,h,g)$, a bijection of the summation set that fixes $k$ and $m$. The summand $c_{ghk}c_{efm}A_{ge}B_{mk}C_{hf}$ becomes $c_{hgk}c_{fem}A_{hf}B_{mk}C_{ge}$, and $c_{hgk}c_{fem}=(-c_{ghk})(-c_{efm})=c_{ghk}c_{efm}$, so the two sign flips do cancel, being one flip in each $c$. What remains is $-\sum c_{ghk}c_{efm}C_{ge}B_{mk}A_{hf}$, which is the index formula for $\Phi(C;B,A)$ read off section 3 with $A\mapsto C$ and $C\mapsto A$. **So $\Phi(A;B,C)=\Phi(C;B,A)$ with no hypothesis beyond (L) and (S).** Only antisymmetry in the first two slots of $c$ is used here, not the cyclic half.

## 5. Step 3's rotation (attack item 5)

This is the step the brief flags, and it holds, transpose included.

Rename $m\to g'$ and $k\to e'$, which is a relabelling and nothing more:
$$\Phi(A;B,C)=-\sum_{e,f,g,h,g',e'}c_{ghe'}\,c_{efg'}\,A_{ge}\,B_{g'e'}\,C_{hf}.$$
Rotate each $c$ by (iii): $c_{ghe'}=c_{e'gh}$ and $c_{efg'}=c_{g'ef}$, both cyclic shifts, both sign-free. So
$$\Phi(A;B,C)=-\sum c_{e'gh}\,c_{g'ef}\,B_{g'e'}\,C_{hf}\,A_{ge}. \tag{$\ast$}$$
The target, straight from section 3's formula at $(A,B,C)\mapsto(B,C,A^*)$ with dummies primed, is
$$\Phi(B;C,A^{*})=-\sum_{g',h',k',e',f',m'}c_{g'h'k'}\,c_{e'f'm'}\,B_{g'e'}\,C_{m'k'}\,(A^{*})_{h'f'}.$$
Apply the derivation's matching $h'=e$, $k'=f$, $f'=g$, $m'=h$, term by term against $(\ast)$:

| factor in $\Phi(B;C,A^*)$ | after the matching | factor in $(\ast)$ |
|---|---|---|
| $c_{g'h'k'}$ | $c_{g'ef}$ | $c_{g'ef}$ |
| $c_{e'f'm'}$ | $c_{e'gh}$ | $c_{e'gh}$ |
| $B_{g'e'}$ | $B_{g'e'}$ | $B_{g'e'}$ |
| $C_{m'k'}$ | $C_{hf}$ | $C_{hf}$ |
| $(A^{*})_{h'f'}$ | $(A^{*})_{eg}=A_{ge}$ | $A_{ge}$ |

Every factor agrees, the last by $(A^*)_{eg}=A_{ge}$ from section 0, and the matching is a bijection of the six summation names, $\{g',h',k',e',f',m'\}\mapsto\{g',e,f,e',g,h\}$. **So $\Phi(A;B,C)=\Phi(B;C,A^{*})$ with no hypothesis, and $\Phi(A;B,C)=\Phi(B;C,A)$ exactly when the first slot carries a self-adjoint operator.** The transpose is load-bearing rather than decorative.

With the swap of section 4, the two relabellings realise the transposition $(1\,3)$ and the cycle $(1\,2\,3)$ on the slots, which generate $S_3$, so $\Phi$ is fully symmetric when all three operators are self-adjoint, each application of the cycle finding a self-adjoint operator in the first slot.

**Screen, reported as a screen and cited for nothing.** To guard against a transcription error in my own bookkeeping I evaluated both sides in exact rationals on a totally antisymmetric $c$ in dimensions $3$ (the Levi-Civita symbol) and $4$ (a $c$ that satisfies no Jacobi identity), at fixed rational $A,B,C$ constructed for the purpose: the operator definition $\sum_a\operatorname{Tr}(\operatorname{ad}_aB\operatorname{ad}_{Ae_a}C)$ agreed with the index formula, the swap and the rotation with the transpose both held, the rotation without the transpose failed, and the six slot orders agreed at symmetrised arguments. The positive claims above rest on the derivations, not on this.

## 6. Step 4's trace part (attack item 6)

The three terms, and what each needs, at $R^*=R$ and arbitrary $S$:

| term | source | reduction | consumes |
|---|---|---|---|
| $\operatorname{Tr}(S^*R^*R)=\operatorname{Tr}(S^*R^2)$ | $U(S,R,R)$ | none | (A) |
| $\operatorname{Tr}(R^*S^*R)=\operatorname{Tr}(RS^*R)$ | $U(R,S,R)$ | $\operatorname{Tr}(RS^*R)=\operatorname{Tr}(S^*RR)$ | (A), (C) |
| $\operatorname{Tr}(R^*R^*S)=\operatorname{Tr}(R^2S)$ | $U(R,R,S)$ | $\operatorname{Tr}(R^2S)=\operatorname{Tr}((R^2S)^*)=\operatorname{Tr}(S^*R^2)$ at $R^*=R$ | (A), (T) |

So the sum is $3\operatorname{Tr}(S^*R^2)$, and the derivation's own attribution, "by cyclicity and $\operatorname{Tr}(R^2S)=\operatorname{Tr}((R^2S)^*)$", names exactly the right two facts for the second and third terms. **Exactly one of the three needs (C).** Section 12 records where that count is printed wrongly.

## 7. Step 4's conclusion and its reach (attack item 7)

The polynomial identity is an identity, since $U$ is trilinear: $\operatorname{Tr}(A^*B^*C)$ is trilinear by inspection, and $\Phi(A;B,C)=\sum_e\operatorname{Tr}(\operatorname{ad}_eB\operatorname{ad}_{Ae}C)$ is linear in $A$ through $Ae$, in $B$ and in $C$ directly. $P(X)=U(X,X,X)$ holds at every $X\in\operatorname{End}(\Lambda^2)$ by sections 1 and 2, **and that it holds without (A) is exactly what the expansion consumes**, because $R+tS$ is not self-adjoint when $S$ is not.

The $\Phi$ part of the $t$-coefficient is $\Phi(S;R,R)+\Phi(R;S,R)+\Phi(R;R,S)$. Section 4 gives $\Phi(R;R,S)=\Phi(S;R,R)$ with no hypothesis. Section 5 gives $\Phi(R;S,R)=\Phi(S;R,R^*)=\Phi(S;R,R)$, using (A) twice, once to license the rotation at a self-adjoint first slot and once to remove the transpose. So the $\Phi$ part is $3\Phi(S;R,R)$ and the boxed identity reads
$$\tfrac{d}{dt}\big|_{0}P(R+tS)=3\operatorname{Tr}(S^*R^2)-\tfrac32\Phi(S;R,R)=3\langle S,R^2\rangle_{\mathrm{op}}+3\langle S,R^\#\rangle_{\mathrm{op}}=3\langle S,Q(R)\rangle_{\mathrm{op}},$$
the middle equality being $\langle S,X\rangle_{\mathrm{op}}=\operatorname{Tr}(S^*X)$ at $X=R^2$ and section 2's $\langle S,R^\#\rangle_{\mathrm{op}}=-\tfrac12\Phi(S;R,R)$.

**Nothing secretly needs $S$ self-adjoint.** I checked each place $S$ appears: in section 2's pairing, where only $Se\in\Lambda^2$ is used; in section 4's swap, which is hypothesis-free; in section 5's rotation, whose hypothesis falls on the first slot, which is $R$ at every application; and in section 6's trace table, where $S^*$ is carried symbolically and never cancelled. **Nothing needs $R$ Weyl**: Bianchi and the Ricci clause of `IsWeyl` are never invoked, and the ambient is $\operatorname{End}(\Lambda^2)$ throughout.

The Euler remark is correct and is correctly deflated. At $S=R$ the boxed identity gives $3\langle R,Q(R)\rangle_{\mathrm{op}}=3P(R)$, which is also what homogeneity gives directly from $P((1+t)R)=(1+t)^3P(R)$, so the case $S=R$ carries no information the boxed identity does not, and conversely Euler alone reaches no direction other than $R$.

## 8. Step 5 (attack item 8)

$Q$ is quadratic in its argument, $\operatorname{compOp}$ manifestly and $R^\#$ by section 2, so the polarisation is well posed. $\tfrac12[(X+Y)^2-X^2-Y^2]=\tfrac12(XY+YX)$ and $\tfrac12[(X+Y)^\#-X^\#-Y^\#]=X\#Y$ with the derivation's convention for $\#$, so $X\circ Y=\tfrac12(XY+YX)+X\#Y$ is right.

Pairing against $Z$ and using $\langle M,Z\rangle_{\mathrm{op}}=\operatorname{Tr}(Z^*M)$ gives the trace half as printed. For the $\#$ half, polarise section 2's $\langle S,R^\#\rangle_{\mathrm{op}}=-\tfrac12\Phi(S;R,R)$ in $R$ and use bilinearity of $\Phi$ in its second and third slots:
$$\langle Z,X\#Y\rangle_{\mathrm{op}}=-\tfrac14\big[\Phi(Z;X,Y)+\Phi(Z;Y,X)\big],$$
so $T(X,Y,Z)=\tfrac12\operatorname{Tr}(Z^*XY)+\tfrac12\operatorname{Tr}(Z^*YX)-\tfrac14[\Phi(Z;X,Y)+\Phi(Z;Y,X)]$ as printed. At self-adjoint $X,Y,Z$ the trace half is $\tfrac12[\operatorname{Tr}(ZXY)+\operatorname{Tr}(ZYX)]$, the full symmetrisation, symmetric under the $3$-cycles by (C) and under a transposition by (T); the $\Phi$ half is symmetric by section 5. **So $T$ is fully symmetric on the self-adjoint operators**, and since `IsWeyl`'s symmetry clause makes every member of $\mathcal W_n$ self-adjoint on bivectors, on $\mathcal W_n$ too.

**The one citation that is short.** The concluding identity $T(X,Y,Z)=\tfrac12[U(X,Y,Z)+U(Y,X,Z)]$ is true identically, and I verified both halves:
- the $\Phi$ halves match by the outer-slot swap alone, $\Phi(X;Y,Z)=\Phi(Z;Y,X)$ and $\Phi(Y;X,Z)=\Phi(Z;X,Y)$, exactly as claimed;
- the trace halves match by (T) and not by the swap, $\operatorname{Tr}(X^*Y^*Z)=\operatorname{Tr}((X^*Y^*Z)^*)=\operatorname{Tr}(Z^*YX)$ and $\operatorname{Tr}(Y^*X^*Z)=\operatorname{Tr}(Z^*XY)$.

So "by the outer-slot swap alone" is one fact short of what the sentence claims, while the identity it claims is correct and hypothesis-free. The strongest reading that saves the words is that "alone" contrasts with the rotation and is meant of the $\Phi$ half only, which the sentence's position after the $\Phi$ discussion supports. I record it as a citation to repair, not a defect. With it, "step 4's coefficient is $3T(R,R,S)$" is right at self-adjoint $R$, since $T(R,R,S)=U(R,R,S)$ and section 6's table makes $U(R,R,S)$ a third of the coefficient.

**A second, smaller reach.** "hence $L_e$ is self-adjoint there" is true of the compression of $L_e$ to $\mathcal W_n$, which is all the symmetry of $T$ on $\mathcal W_n$ delivers. Self-adjointness of $L_e$ as an operator *on* $\mathcal W_n$ additionally needs $X\circ Y\in\mathcal W_n$, which is the closure the derivation's own closing paragraph declares off file. The paragraph is three sentences later, so a reader is warned, but the two sentences sit in tension and the first should say "the compression".

## 9. The by-hand check (attack item 9)

`sum_inner2_ad2`, read on disk in [StructureConstants.lean](../lean/HamiltonsCubic/Base/StructureConstants.lean), is
`∑ i, ∑ j, inner2 (br X (br Y (phi i j))) (phi i j) = 2 * ((Fintype.card ι : ℝ) - 2) * (X * Y).trace`
at skew $X,Y$. The sum is the **ordered** double sum, so $\operatorname{Tr}(\operatorname{ad}_X\operatorname{ad}_Y)=\sum_e\langle\operatorname{ad}_X\operatorname{ad}_Ye,e\rangle=\tfrac12\cdot 2(n-2)\operatorname{tr}(XY)=(n-2)\operatorname{tr}(XY)$, which is $\mathfrak{so}(n)$'s Killing form as the file's own header says.

The derivation's conversion is then two steps, both of which I re-derived rather than granted. First, $\operatorname{ad}_X^*=-\operatorname{ad}_X$ gives $\langle\operatorname{ad}_X,\operatorname{ad}_Y\rangle_{\mathrm{op}}=\operatorname{Tr}(\operatorname{ad}_X^*\operatorname{ad}_Y)=-(n-2)\operatorname{tr}(XY)$. Second, at skew $X$, $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)=-\tfrac12\operatorname{tr}(XY)$, so $\operatorname{tr}(XY)=-2\langle X,Y\rangle$ and $\langle\operatorname{ad}_X,\operatorname{ad}_Y\rangle_{\mathrm{op}}=2(n-2)\langle X,Y\rangle$. **That is the "read in the present normalisation" the brief asked me to check rather than grant, and it is right.**

Hence $\Phi(S;\mathrm{id},\mathrm{id})=\sum_e\operatorname{Tr}(\operatorname{ad}_e\operatorname{ad}_{Se})=-\sum_e\langle\operatorname{ad}_e,\operatorname{ad}_{Se}\rangle_{\mathrm{op}}=-2(n-2)\sum_e\langle e,Se\rangle=-2(n-2)\operatorname{Tr}S$, and $3\langle S,\mathrm{id}^\#\rangle_{\mathrm{op}}=-\tfrac32\Phi=3(n-2)\operatorname{Tr}S$, against $\langle S,(n-2)\mathrm{id}\rangle_{\mathrm{op}}=(n-2)\operatorname{Tr}(S^*)=(n-2)\operatorname{Tr}S$ from `sharpOp_id`. The two agree.

**Could it have failed?** Yes, and that is what makes it worth its line. It is a check against a kernel-proved anchor the derivation does not control, `sharpOp_id`, and it is sensitive to the sign and the $\tfrac12$ of step 1, to the ordered-to-unordered factor $2$ in `sum_inner2_ad2`, and to the factor $-2$ between $\operatorname{tr}(XY)$ and $\langle X,Y\rangle$. Any one of those wrong by a sign or a factor of two breaks the agreement, and three of the four errors would break it in a way no later step would catch. **What it cannot see is steps 2 to 5**: at $R=\mathrm{id}$ the two matrices $B$ and $C$ inside $\Phi$ collapse, the contraction degenerates to the Killing form, and every index symmetry under audit becomes vacuous. It is a normalisation check and not a structural one, and the derivation presents it as such.

## 10. The Lean side (attack item 10)

Built with `lake build` under the project toolchain, Lean 4.33.1 as `lake env lean --version` reports, `Build completed successfully (9218 jobs)`. `#print axioms` was run through `lake env lean` on the built library:

| declaration | axioms |
|---|---|
| `trOp`, `trOp_comp_entries`, `sum4_swap`, `trOp_comp_comm`, `innerOp2_eq_trOp`, `trCube2_first_variation`, `foxTri2_comm` | `propext, Classical.choice, Quot.sound` |
| `sum_inner2_ad2`, `sharpOp_id` | `propext, Classical.choice, Quot.sound` |
| `hasDerivAt_Pcubic2_line`, `foxTri2_symm_right` | `propext, sorryAx, Classical.choice, Quot.sound` |

**Is `trOp` the trace?** Yes. `trOp M = (1/2) * ∑ i, ∑ j, inner2 (applyPhi M i j) (phi i j)` is $\sum_e\langle Me,e\rangle$, the $\tfrac12$ being the ordered-pair doubling and not a rescaling, and section 0's $\operatorname{Tr}(\mathrm{id})=\dim\Lambda^2$ fixes that. The halving is licensed here by the type: `CurvOp2 ι` is `skewSub ι →L[ℝ] skewSub ι`, so (L) holds by construction and the exposure of section 1 does not exist in this file.

**Is `innerOp2_eq_trOp`'s hypothesis on the right argument?** Yes. `innerOp2 A B = ∑_e ⟨Ae, Be⟩ = Tr(A*B)` and `trOp (A.comp B) = Tr(AB)`, so the identity is $\operatorname{Tr}((A^*-A)B)=0$, and the hypothesis `hA : IsSelfAdjoint2 A` falls on `A`, the first argument, which is the one carrying the adjoint. The proof rewrites with `hA (B φ) φ`, moving `A` off the `B` slot, which is the same placement. Quantified over all `B` the hypothesis is also necessary, the pairing being nondegenerate.

**Does `trCube2_first_variation` state the composition half of step 4?** Yes, and not something weaker. Expanding $\operatorname{trCube2}(R+tS)=\langle(R+tS)^2,R+tS\rangle$, the $t$-coefficient is $\langle R^2,S\rangle+\langle RS,R\rangle+\langle SR,R\rangle$, which is the theorem's left side term for term, and the right side is $3\langle S,R^2\rangle$. The hypothesis is `IsSelfAdjoint2 R` with `S` unconstrained, matching step 4's scope exactly. It stops short of the expansion in $t$, which is honest: the file and [FirstVariation.lean](../lean/HamiltonsCubic/Results/FirstVariation.lean) both say the expansion is owed.

One disagreement with the prose around the theorem, on which facts it consumes, is in section 12.

## 11. The two `sorry`s (attack item 11)

`hasDerivAt_Pcubic2_line (R S : CurvOp2 ι) (hR : IsSelfAdjoint2 R) : HasDerivAt (fun t : ℝ => Pcubic2 (R + t • S)) (3 * innerOp2 S (Qop2 R)) 0`.

- **Hypotheses.** `IsSelfAdjoint2 R` is self-adjointness against `inner2` on `skewSub`, which is the derivation's $R^*=R$, and `S` is an arbitrary `CurvOp2`. That is step 4's scope, neither wider nor narrower. `IsWeyl2` is absent, which section 7 confirms is right.
- **Is `HasDerivAt` along a line the right notion?** For what the derivation proves, yes: the derivation computes the $t$-coefficient of a cubic polynomial in one real variable, and `HasDerivAt f v 0` for `f : ℝ → ℝ` is exactly that, needing no topology or inner product on `CurvOp2`. It is weaker than the Fréchet form a Lagrange argument on the sphere consumes, and both the docstring and [lean/INDEX.md](../lean/INDEX.md) row 138 say so in terms. No overreach.
- **Is `3 * innerOp2 S (Qop2 R)` the right value given `innerOp2`'s $\tfrac12$?** Yes. `innerOp2` with its $\tfrac12$ is $\sum_e\langle Re,Se\rangle$, which is the derivation's $\langle\,,\rangle_{\mathrm{op}}$ in the same normalisation, and `Qop2 R = compOp2 R + sharpMapCL R` is $R^2+R^\#$. Two independent anchors on the constant: at $S=R$ the stated value is $3\,$`innerOp2 R (Qop2 R)`, which `Pcubic2_eq_innerOp2` (kernel-proved) makes $3P(R)$, and homogeneity of the cubic forces exactly that; and at $R=\mathrm{id}$ section 9's check fixes the $\#$ half's normalisation against `sharpOp_id`.

`foxTri2_symm_right (X Y Z) (hX hY hZ : IsSelfAdjoint2 _) : foxTri2 X Y Z = foxTri2 X Z Y` states symmetry in the last two slots at three self-adjoint arguments, which is narrower than step 5's full symmetry and together with the proved `foxTri2_comm` is equivalent to it. `foxProd2 X Y = (1/2) • (Qop2 (X+Y) - Qop2 X - Qop2 Y)` is the derivation's $X\circ Y$ with the same polarisation convention, so `foxTri2` is the derivation's $T$. The hypothesis set is the derivation's. Nothing is claimed at a non-self-adjoint argument.

**Both are `sorry`-carrying, confirmed by `sorryAx` above.** The headline claims of the audited block are typed and unproved in the layer, and the files say so where a reader meets them.

## 12. Claims that reach past what is established (attack item 12)

Three, each quoted.

**(a) "with no hypothesis on $R$", carried into [plan.md](../plan.md).** The I36 item reads: *"$\langle R^\#X,Y\rangle=-\tfrac12\operatorname{Tr}(\operatorname{ad}_XR\operatorname{ad}_YR)$ with no hypothesis"*. Section 1 locates what is consumed, linearity and skew-preservation, and exhibits the failure at a bare function. Inside [second-order.md](../findings/second-order.md) the conventions block grants both a paragraph earlier. In [plan.md](../plan.md) it does not travel with the sentence, and the phrase there is the whole of what a reader gets. **Repair**: "at every linear $R:\Lambda^2\to\Lambda^2$, with no further hypothesis, in particular none of self-adjointness".

**(b) "and not otherwise", on $\operatorname{Tr}R^3$.** The aside in step 1 reads: *"it is $\operatorname{Tr}R^3$ at a self-adjoint $R$ and not otherwise"*, and [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean)'s `trCube2` docstring carries the same in the form **"IT IS `tr R³` ONLY AT A SELF-ADJOINT `R`"**. As a pointwise claim it is false. Take any nonzero skew-adjoint $R\in\operatorname{End}(\Lambda^2)$, for instance $R=\operatorname{ad}_X$ at $X\ne0$, which fact (ii) makes skew-adjoint: then $\operatorname{Tr}(R^3)=\operatorname{Tr}((R^3)^*)=\operatorname{Tr}((R^*)^3)=-\operatorname{Tr}(R^3)$, so $\operatorname{Tr}(R^3)=0$, and $\operatorname{trCube}(R)=\operatorname{Tr}(R^*R^2)=-\operatorname{Tr}(R^3)=0$ as well. The two agree at an operator that is as far from self-adjoint as the space allows. What is true is the quantified statement, that $\operatorname{Tr}(R^*R^2)=\operatorname{Tr}(R^3)$ *for every* $R$ forces $R^*=R$. The opposite reading, that "not otherwise" was meant of the identity as a law rather than at a point, is the reading I would repair it into, and it is not what the words say. **This is the same class of defect [r1012](REVIEW_r1012.md) was answering when it made the layer say the trace reading needs $R^*=R$, corrected one step too far.**

**(c) The cyclicity count, in three places.** [TraceOp.lean](../lean/HamiltonsCubic/Results/TraceOp.lean)'s header says *"every move the first variation of $P$ needs is a CYCLIC one, $\langle SR,R\rangle=\langle S,R^2\rangle$ and its two companions, which the pairing cannot make on its own"*; its `trCube2_first_variation` docstring says **"Two of the three need cyclicity and the third does not"**; [FirstVariation.lean](../lean/HamiltonsCubic/Results/FirstVariation.lean) says *"two of them by cyclicity of the trace"*; and [lean/INDEX.md](../lean/INDEX.md) row 137 repeats both, *"every move the first variation needs is CYCLIC"* and *"two of them needing cyclicity and one not"*. **Exactly one of the three needs cyclicity**, and the file's own proof directly beneath the docstring says so: `h1` invokes `trOp_comp_comm`, `h2` reaches its trace by `innerOp2_eq_trOp` and `comp_assoc` alone, and `h3` is `innerOp2_eq_trOp hRR S` with no cyclic step anywhere. Two of the three are available to the pairing without any trace at all: $\langle RS,R\rangle=\sum_e\langle R(Se),Re\rangle=\sum_e\langle Se,R(Re)\rangle=\langle S,R^2\rangle$ by self-adjointness applied pointwise, and $\langle R^2,S\rangle=\langle S,R^2\rangle$ is `innerOp2_comm`. Section 6 finds the same count in the prose's trace form, where the middle term needs (C) and the third needs (T). The strongest reading that saves the docstring is that `h1`'s proof uses `trOp_comp_comm` twice, so "two" may be a count of rewrites rather than of terms. The sentence says terms. **What survives intact is the file's reason for existing**: $\langle SR,R\rangle=\langle S,R^2\rangle$ genuinely needs a second summation basis and the pairing cannot reach it, so `trOp` earns its place on one of the three.

Nothing else in the audited block, in the I36 item, or in rows 137 and 138 of [lean/INDEX.md](../lean/INDEX.md) claims more than is established. In particular row 138's "NOT stated" list is accurate, the I36 item's Fermat trap paragraph is about `UniqueDiffWithinAt` and is untouched by this round, and the derivation's closing paragraph on $\operatorname{Ric}(Q(W))=0$ correctly marks the closure of $\mathcal W_n$ under $Q$ as off file.

## Overall verdict

**PROVEN (hypotheses corrected).** Every step of the derivation holds, including step 5's rotation, which the brief flagged as the most likely to be wrong and which survives term by term with the transpose load-bearing. The first variation $\tfrac{d}{dt}|_0P(R+tS)=3\langle S,Q(R)\rangle_{\mathrm{op}}$ is right at every self-adjoint $R\in\operatorname{End}(\Lambda^2)$ and every $S\in\operatorname{End}(\Lambda^2)$, and $T$ is fully symmetric on the self-adjoint operators. The corrections are to hypotheses as stated and not to results: step 1 holds at every linear $R:\Lambda^2\to\Lambda^2$ rather than at no hypothesis, "and not otherwise" is false pointwise, "by the outer-slot swap alone" is one fact short, "hence $L_e$ is self-adjoint there" holds of the compression, and the Lean layer's cyclicity count is one rather than two. The two headline statements remain `sorry`-carrying, which their files and index rows say.

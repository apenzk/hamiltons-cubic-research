# Notes, Bettiol, Kummer, Mendes, *Convex Algebraic Geometry of Curvature Operators*

Source on file: [bettiol-kummer-mendes-2021-convex-curvature.pdf](https://arxiv.org/abs/1908.03713), arXiv:1908.03713v2 [math.DG], 8 Feb 2021; published SIAM J. Appl. Algebra Geom. **5** (2021) 200–228. Text for grepping: [bettiol-kummer-mendes-2021-convex-curvature.txt](https://arxiv.org/abs/1908.03713).

## Setting and notation (§2)

$\mathrm{Sym}^2_b(\wedge^2\mathbb{R}^n)$ is the space of symmetric endomorphisms of $\wedge^2\mathbb{R}^n$ satisfying the first Bianchi identity, the *algebraic curvature operators*. For $R$ in that space and $\sigma = X\wedge Y \in \mathrm{Gr}^+_2(\mathbb{R}^n) = \{X\wedge Y \in \wedge^2\mathbb{R}^n : \|X\wedge Y\|=1\}$, the sectional curvature is $\sec_R(\sigma) := \langle R(\sigma),\sigma\rangle$.

> **Definition 2.1.** Given $k\in\mathbb{R}$ and $n\ge2$,
$$\mathcal{R}_{\sec\ge k}(n) = \bigl\{R \in \mathrm{Sym}^2_b(\wedge^2\mathbb{R}^n) : \sec_R \ge k\bigr\},$$
and similarly for $\mathcal{R}_{\sec>k}(n)$, $\mathcal{R}_{\sec\le k}(n)$, $\mathcal{R}_{\sec<k}(n)$.

> **Remark 2.2** reduces every bound to $\sec\ge0$: $\overline{\mathcal{R}_{\sec>k}(n)} = \mathcal{R}_{\sec\ge k}(n)$, $\operatorname{int}\mathcal{R}_{\sec\ge k}(n) = \mathcal{R}_{\sec>k}(n)$, and $\sec_R\ge k \iff \sec_{R-k\,\mathrm{Id}}\ge0$, $\sec_R\le k \iff \sec_{k\,\mathrm{Id}-R}\ge0$, so $\mathcal{R}_{\sec\ge k}(n)$ and $\mathcal{R}_{\sec\le k}(n)$ are affine images of $\mathcal{R}_{\sec\ge0}(n)$. Consequence of linearity of $R\mapsto\sec_R$ together with $\sec_{\mathrm{Id}}\equiv1$.

Under the identification of $\mathcal{R}_{\sec\ge0}(n)$ with quadratic forms on the Plücker cone (2.10): $P_{\mathrm{Gr}_2(n)} = \mathcal{R}_{\sec\ge0}(n)$, the cone of quadratic forms nonnegative on the real points of $\mathrm{Gr}_2(n)$, and $\Sigma_{\mathrm{Gr}_2(n)}$ (the sums of squares modulo the Plücker ideal), is the set of curvature operators with *strongly nonnegative curvature* in the sense of Bettiol–Mendes [BM17, BM18].

## The three main theorems

> **Theorem A.** *For all $k\in\mathbb{R}$, each of the sets $\mathcal{R}_{\sec\ge k}(n)$ and $\mathcal{R}_{\sec\le k}(n)$ is:*
1. *not a spectrahedral shadow, if $n\ge5$;*
2. *a spectrahedral shadow, but not a spectrahedron, if $n=4$;*
3. *a spectrahedron, if $n\le3$.*

The dimension split is where the paper's weight lies. (3) is the equivalence, for $n\le3$, of $\sec_R\ge k$ with $R - k\,\mathrm{Id}\succeq0$. The first half of (2) is Thorpe's trick (Proposition 3.1 below). (1) is new and gives a class of counterexamples to the Helton–Nie conjecture, after Scheiderer [Sch18b] and Fawzi [Faw19]. Statements (1) and (2) carry over to the strict bounds $\sec>k$, $\sec<k$ (Remarks 2.2, 2.4).

> **Theorem B.** *For all $k\in\mathbb{R}$ and $n\ge2$, there are inner and outer approximations of $\mathcal{R}_{\sec\ge k}(n)$ by nested sequences $I_m$ of spectrahedral shadows and $O_m$ of spectrahedra,*
$$I_0\subset I_1\subset\cdots\subset I_m\subset\cdots\subset \mathcal{R}_{\sec\ge k}(n)\subset\cdots\subset O_m\subset\cdots\subset O_1\subset O_0,\qquad m\ge0,$$
*which are $O(n)$-invariant and satisfy $\bigcup_{m\ge0} I_m = \mathcal{R}_{\sec\ge k}(n) = \bigcap_{m\ge0} O_m$.*

By Theorem A the hierarchies do **not** stabilise after finitely many steps for any $n\ge5$. At $k=0$: $I_0$ is exactly strongly nonnegative curvature, $O_0$ is exactly $\mathrm{Ric}\ge0$; $I_0 = \mathcal{R}_{\sec\ge k}(n)$ iff $n\le4$, and $O_0 = \mathcal{R}_{\sec\ge k}(n)$ iff $n=2$.

> **Theorem C.** *The set $\mathcal{R}_{\sec\ge k}(4)$ is an algebraic interior with minimal defining polynomial $p_k : \mathrm{Sym}^2_b(\wedge^2\mathbb{R}^4)\to\mathbb{R}$ given by*
$$p_k(R) = \operatorname{disc}_x\bigl(\det(R - k\,\mathrm{Id} + x\,\ast)\bigr).$$
*More precisely $\mathcal{R}_{\sec\ge k}(4) = \overline{C_k}$, where $C_k$ is the only connected component of $\{R : p_k(R)>0\}$ with $(k+1)\mathrm{Id}\in C_k$.*

Here $\ast$ is the Hodge star on $\wedge^2\mathbb{R}^4$ and $\operatorname{disc}_x$ the discriminant in $x$. **Remark 3.3**: $\operatorname{disc}_x\det(R+x\ast)$ is homogeneous of degree $30$ in the coefficients of $R$. A related result, reading (1.3) as a polynomial in $k$, is Fodor [Fod20].

## The supporting statements

> **Definition 2.5** (Helton–Vinnikov [HV07]). A closed $S\subset\mathbb{R}^n$ is an *algebraic interior* if it is the closure of a connected component of $\{x : p(x)>0\}$ for some $p\in\mathbb{R}[x_1,\dots,x_n]$, the *defining polynomial*. **Remark 2.6**: a defining polynomial of minimal degree divides every defining polynomial ([HV07, Lem. 2.1]), so it is unique up to a positive constant.

> **Lemma 2.7.** *Every spectrahedron $S$ with $\operatorname{int}(S)\ne\emptyset$ is an algebraic interior whose minimal defining polynomial $p$ satisfies $p(x)\ne0$ for all $x\in\operatorname{int}(S)$.* This is what rules out "spectrahedron" in Theorem A (2), via Proposition 3.5.

**Lemma 2.10 (Finsler).** *Let $A,B\in\mathrm{Sym}^2(\mathbb{R}^d)$. The following are equivalent:*
1. *$\langle Av,v\rangle\ge0$ for all $v\in\mathbb{R}^d\setminus\{0\}$ with $\langle Bv,v\rangle=0$;*
2. *there exists $x\in\mathbb{R}$ with $A + xB \succeq 0$.*

*The analogous statement with all inequalities strict also holds. Moreover, if (i) holds, there is $v\ne0$ with $\langle Av,v\rangle=\langle Bv,v\rangle=0$, and $B$ has full rank, then $x$ in (ii) is unique.* Cited to Finsler [Fin36], the paper's point is that Thorpe's trick is an instance of a result almost 100 years old, apparently unnoticed until now; Calabi [Cal64] gave an independent topological proof, and [DP06] surveys others.

**Example 2.11** is the dimension count behind the $n\le4$ / $n\ge5$ split. With $\operatorname{codim}\mathrm{Gr}_2(n) = \binom n2 - 1 - 2(n-2) = \tfrac{(n-2)(n-3)}2$ and $\deg\mathrm{Gr}_2(n) = \tfrac{(2(n-2))!}{(n-2)!\,(n-1)!}$ [EH16, Ex. 4.38], one has $\deg = \operatorname{codim}+1$ iff $n\le4$. Blekherman–Smith–Velasco [BSV16, Thm. 1] then gives $\Sigma_{\mathrm{Gr}_2(n)} = P_{\mathrm{Gr}_2(n)}$ **iff $n\le4$**. For $n\ge5$ the explicit nonnegative-but-not-SOS witness is Zoltek's [Zol79]
$$R_{\mathrm{Zol}} = x_{12}^2 + 2x_{13}^2 + 2x_{23}^2 + 2x_{14}^2 + x_{15}^2 + x_{34}^2 + 2x_{25}^2 + 2x_{45}^2 - 2x_{12}x_{34} - 2x_{12}x_{15} - 2x_{34}x_{15}.$$

> **Theorem 2.14** (the criterion extracted from Scheiderer [Sch18b]; implies [Faw19, Thm. 3]). *Let $L\subset\mathbb{R}[x_1,\dots,x_n]$ be a finite-dimensional vector space with $1\in L$, and let $f$ be a nonnegative polynomial which is not a sum of squares. Suppose that for all $y\in\mathbb{R}^n$ the coefficients of $f^h(t, x_1-y_1,\dots,x_n-y_n)$, as a polynomial in $t$, belong to $L$. Then*
$$K = \{g\in L : g(x)\ge0 \text{ for all } x\in\mathbb{R}^n\}$$
*is not a spectrahedral shadow.* Proof: $K = C^*$ for $C=\operatorname{conv}\{\varphi_x\}$ the convex hull of evaluations; $C$ fails to be a spectrahedral shadow by [Sch18b, Lem. 4.17, Prop. 4.18, Prop. 4.19, Ex. 4.20, Rem. 4.21]; duality plus $1\in L$ transfers the failure to $K$.

**Proposition 3.1 (Thorpe's trick, [Tho72]).** *A curvature operator $R\in\mathrm{Sym}^2_b(\wedge^2\mathbb{R}^4)$ has $\sec_R\ge0$ if and only if there exists $x\in\mathbb{R}$ with $R + x\ast \succeq 0$, and analogously for $\sec_R>0$. Moreover, if $R$ has $\sec_R\ge0$ but not $\sec_R>0$, then $x$ is unique.* Immediate from Lemma 2.10 with $B=\ast$.

> **Proposition 3.2.** *$p(R)=\operatorname{disc}_x(\det(R+x\ast))$ vanishes on the topological boundary $\partial\mathcal{R}_{\sec\ge0}(4)$.* The proof runs through $T=\operatorname{diag}(1,1,1,\sqrt{-1},\sqrt{-1},\sqrt{-1})$, a square root of $\ast$, giving $\operatorname{disc}_x\det(R+x\ast) = \operatorname{disc}(TRT)$ (3.3), and shows the Finsler–Thorpe $x_0$ is a root of multiplicity $\ge2$.

> **Proposition 4.1.** *The closed convex cone $P_{\mathrm{Gr}_2(5)}$ is not a spectrahedral shadow.* This is the main step of Theorem A (1): apply Theorem 2.14 in the affine chart $x_{15}\ne0$ of $\mathrm{Gr}_2(5)$, with $f$ the restriction of a Zoltek-type $P\in P_{\mathrm{Gr}_2(5)}\setminus\Sigma_{\mathrm{Gr}_2(5)}$.

> **Corollary 4.2.** *$P_{\mathrm{Gr}_k(n)}$ is not a spectrahedral shadow* for the stated range, by reduction to Proposition 4.1.

> **Definition 5.1** (inner hierarchy). With $r=\sum_{i<j}x_{ij}^2\in\mathbb{R}[\mathrm{Gr}_2(n)]_2$ and $\varphi_m : \mathbb{R}[\mathrm{Gr}_2(n)]_2\to\mathbb{R}[\mathrm{Gr}_2(n)]_{2m+2}$, $\varphi_m(P) = r^m\cdot P$, let $I_m = \varphi_m^{-1}(\text{sums of squares})$.

> **Proposition 5.2.** *For each $n\ge2$, $\{I_m\}_{m\ge0}$ is a nested sequence of $O(n)$-invariant spectrahedral shadows with $\mathcal{R}_{\sec>0}(n)\subset\bigcup_{m\ge0}I_m\subset\mathcal{R}_{\sec\ge0}(n)$; in particular $\overline{\bigcup_{m\ge0}I_m} = \mathcal{R}_{\sec\ge0}(n)$.* The exhaustion uses the Positivstellensatz [Sch12, Cor. 4.2] applied to the pull-back of $\mathcal{O}(1)$ under the Plücker embedding. **Example 5.3**: $R_{\mathrm{Zol}}\in\mathcal{R}_{\sec\ge0}(5)\setminus I_0$ but $R_{\mathrm{Zol}}\in I_1$, checked with the Macaulay2 package SOS. **Remark 5.4**: both inclusions are strict in general, read as an element of $\mathbb{R}[\mathrm{Gr}_2(7)]_2$, $R_{\mathrm{Zol}}$ lies in no $I_m$ at all, having a *bad point* in the sense of [Del97]. **Remark 5.5**: each condition $I_m$ is preserved by Riemannian submersions, via Gray–O'Neill in the form [BM18, Thm. B], $R^{\overline M} = (R^{\overline M})|_{\wedge^2 TM} + 3\alpha - 3b(\alpha)$.

> **Definition 5.6** (outer hierarchy). $O_m = \bigl\{R : K(R,\mathrm{Sym}^p_0\mathbb{R}^n)\succeq0 \text{ for all } 1\le p\le m+1\bigr\}$, where $K(R,\mathrm{Sym}^p_0\mathbb{R}^n)$ is the curvature term in the Weitzenböck formula for traceless symmetric $p$-tensors,
$$\bigl\langle K(R,\mathrm{Sym}^p_0\mathbb{R}^n)\psi,\psi\bigr\rangle = c_{p,n}\int_{S^{n-1}} R\bigl(x\wedge\nabla\psi(x)\bigr),\ x\wedge\nabla\psi(x)\ dx,\qquad c_{p,n}>0,$$
see [BM, Prop. 3.1].

> **Proposition 5.7.** *For each $n\ge2$, $\{O_m\}_{m\ge0}$ is a nested sequence of $O(n)$-invariant spectrahedra with $\bigcap_{m\ge0}O_m = \mathcal{R}_{\sec\ge0}(n)$.* Forward inclusion because the integrand in (5.1) is a sectional curvature; the reverse is [BM, Thm. A]. **Remark 5.8**: $O_0$ is exactly $\mathrm{Ric}\ge0$ [BM, Ex. 2.2].

**Algorithms.** Algorithm 1 iterates semidefinite programs over $I_m$/$O_m$ to decide membership in $\mathcal{R}_{\sec\ge k}(n)$ for $n\ge5$, except on a measure-zero set of inputs where it fails to halt. Algorithms 2 and 3 decide membership in $\mathcal{R}_{\sec\ge0}(4)$ and $\mathcal{R}_{\sec>0}(4)$ by Sturm root counting (Propositions 5.10, 5.11 give termination and correctness).

**Appendix A** generalises Theorems A, B, C to semi-Riemannian signature: **Theorem A'** covers $\mathcal{R}_{\sec\ge k}(n,\nu)$ for $0\le\nu\le n$. **Appendix B** collects facts on the discriminant of symmetric matrices (Proposition B.1, Lemmas B.3, B.4).

## What it cites, for the record

Scheiderer [Sch18b] and Fawzi [Faw19] for the failure of Helton–Nie; Blekherman–Smith–Velasco [BSV16] for $\Sigma_X = P_X$ iff $\deg X = \operatorname{codim}X + 1$; Zoltek [Zol79] for the explicit nonnegative non-SOS form on $\mathrm{Gr}_2(5)$; Finsler [Fin36] and Calabi [Cal64] for Lemma 2.10; Thorpe [Tho72] for Proposition 3.1; Bettiol–Mendes [BM17, BM18] for strongly nonnegative curvature and the Gray–O'Neill formula; Lasserre [Las01] and Parrilo [Par00] for the shape of the inner hierarchy; Weinstein [Wei72, p. 260] for the original quantifier-elimination observation.

## Bearing on this project

The relevant fact is the $n\ge5$ half of Theorem A together with Example 2.11: the *quadratic* sectional-curvature condition on algebraic curvature operators already escapes exact semidefinite description from $n=5$ onward, and the obstruction is exactly the gap $P_{\mathrm{Gr}_2(n)}\setminus\Sigma_{\mathrm{Gr}_2(n)}$ opened by the degree/codimension count. Only hierarchies $I_m$, $O_m$ remain, and Theorem A says they never stabilise. Nothing here treats cubic forms in $R$ or the extremal problem for $\langle R, R^2+R^\#\rangle$.

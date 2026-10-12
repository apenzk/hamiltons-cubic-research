# Notes, El-Hasan, Li, Nienhaus, Petersen, Stanfield, Wink, *A Characterization of Complex Projective Space via the Calabi Curvature Operator*

Source on file: [elhasan-li-npw-2026-calabi-operator.pdf](https://arxiv.org/abs/2608.23778), arXiv:2608.23778v1 [math.DG], 24 Aug 2026. Text for grepping: [elhasan-li-npw-2026-calabi-operator.txt](https://arxiv.org/abs/2608.23778). The work began at the AIM workshop *The Bochner Technique*, May 2026, and resolves one of the problems posed there [AIM].

## The Calabi curvature operator

On a Kähler manifold, $S^{2,0}\subset T^{1,0}\otimes T^{1,0}$ is the bundle of symmetric $(2,0)$-tensors. The Kähler symmetries make
$$\bigl\langle C(Z_\alpha\otimes Z_\beta),\ \bar Z_\gamma\otimes\bar Z_\delta\bigr\rangle = R_{\alpha\bar\gamma\beta\bar\delta}$$
well defined, inducing a self-adjoint map $C : S^{2,0}\to S^{2,0}$, the **Calabi curvature operator**, introduced by Calabi–Vesentini [CV60] for the deformation theory of compact locally symmetric Kähler manifolds.

**Conventions** (§2.1) matter for every constant below: $|T|^2$ means the *full* tensor norm summing over all barred/unbarred index placements, while $|T_{a\bar b c\bar d}|^2$ means only the part with bars in the indicated positions; thus $|R|^2 = 4|R_{a\bar b c\bar d}|^2$ for Kähler curvature tensors. The Laplacian is the complex one, $\Delta^{\mathbb C} = \tfrac12(\nabla_\mu\nabla_{\bar\mu} + \nabla_{\bar\mu}\nabla_\mu) = \tfrac12\Delta^{\mathbb R}$.

A self-adjoint operator with eigenvalues $\lambda_1\le\cdots\le\lambda_m$ is **$k$-nonnegative** for $k\ge1$ if
$$\lambda_1 + \cdots + \lambda_{\lfloor k\rfloor} + (k-\lfloor k\rfloor)\lambda_{\lfloor k\rfloor+1} \ \ge\ 0.$$

## The main theorem

> **Theorem A.** *Let $(M,g)$ be a closed Kähler–Einstein manifold of complex dimension $n\ge2$ with $\mathrm{Ric}(g)=\lambda g$ for some $\lambda\ge0$. If $C - \frac{\lambda}{n+1}\,\mathrm{id}$ is $\frac{2(n+1)}5$-nonnegative, then $(M,g)$ is isometric to complex projective space with the Fubini–Study metric, or flat.*

The average eigenvalue of $C$ on a Kähler–Einstein manifold is $\frac{2\lambda}{n+1}$, so $C - \frac{\lambda}{n+1}\mathrm{id}$ is a "half-trace" operator sitting between $C$ and its traceless part; it is the combination the Bochner formulas produce. The hypothesis is genuinely incomparable with conditions on $C$ itself: full positivity of the spectrum of $C$ does not imply it, and it does not imply $k$-nonnegativity of $C$ for $k$ below roughly $\frac{n+1}5$.

## The Bochner formula

For the curvature tensor of a Kähler–Einstein manifold (automatically harmonic),
$$\Delta^{\mathbb C}\,|R_{\alpha\bar\beta\gamma\bar\delta}|^2 = |\nabla_\mu R_{\alpha\bar\beta\gamma\bar\delta}|^2 + |\nabla_{\bar\mu} R_{\alpha\bar\beta\gamma\bar\delta}|^2 + \tfrac18\,\mathrm{Ric}_L(R,R),$$
with $\mathrm{Ric}_L$ a zeroth-order curvature term. The paper's technical core is an explicit formula for $\mathrm{Ric}_L$ through $C$.

**Theorem B (= Theorem 3.1).** *Let $(M^n,g)$ be Kähler–Einstein with $R_{\alpha\bar\beta}=\lambda g_{\alpha\bar\beta}$, and let $\{S_A\}$ be a unitary eigenbasis of $S^{2,0}$ for $C$ with $C(S_A)=\sigma_A S_A$. Then*
$$\mathrm{Ric}_L(R,\bar R) = 4\sum_A \sigma_A\,|S_A R|^2 + 16\,\mathrm{tr}(C^3) - 16\lambda\,\mathrm{tr}(C^2),$$
*where $S_A R$ is the natural action of $S^{2,0}$ on $(0,4)$-tensors (Definition 2.4).*

> **Remark 3.2** gives the equivalent form after splitting the curvature into scalar and Bochner parts (still Einstein):
$$\mathrm{Ric}_L(R,\bar R) = 4\sum_A \sigma_A |S_A B|^2 + 16\,\mathrm{tr}(C^3) - \frac{16(n+5)}{n+1}\lambda\,\mathrm{tr}(C^2) + \frac{32n(n+3)}{(n+1)^2}\lambda^3.$$

Note the **cubic** shape: $\mathrm{tr}(C^3)$ against a quadratic $\lambda\,\mathrm{tr}(C^2)$ and a weighted sum $\sum\sigma_A|S_AB|^2$ that is itself cubic in the curvature. The paper is explicit that the sign of this term is *not* apparent even when the whole spectrum of $C$ is nonnegative, in contrast with the Riemannian operators of the first [Tac74] and second kind [DF24, CW25] and the standard Kähler curvature operator [PW21], where the Bochner formulas have easily apparent sign. This is recorded as two open problems:

> **Question A.** What is the largest $k(n)$ such that for every Kähler–Einstein algebraic curvature tensor $R$, $k$-nonnegativity of its associated Calabi curvature operator $C$ implies $\mathrm{Ric}_L(R,R)\ge0$?
>
> **Problem B.** Let $R$ be a Kähler–Einstein algebraic curvature tensor. Prove that if $C$ is nonnegative, then $\mathrm{Ric}_L(R,R)\ge0$.

Mok–Zhong [MZ86] forces the answer at the global level: nonnegative $C$ implies nonnegative bisectional curvature, so for closed Kähler–Einstein manifolds with globally nonnegative $C$ the curvature term must vanish.

## The algebraic apparatus

> **Definition 2.4** (the action). For $S\in T^{1,0}\otimes T^{1,0}$, viewed as a map $T_{\mathbb C}M\to T_{\mathbb C}M$ by raising the first index (zero on $T^{1,0}$, mapping $T^{0,1}\to T^{1,0}$), and $T\in(T^{p,q})^*$,
$$ST(\cdot,\dots,\cdot) := -T(S(\cdot),\cdot,\dots,\cdot) - \cdots - T(\cdot,\dots,\cdot,S(\cdot)) \ \in (T^{p-1,q+1})^*.$$

> **Lemma 2.5.** *For $T$ an algebraic Kähler curvature tensor, $S\in S^{2,0}$, and $x,y,z,w\in T^{1,0}$:*
$$-ST(\bar x,\bar y,\bar z,w) = T(S(\bar x),\bar y,\bar z,w) - T(S(\bar y),\bar x,\bar z,w).$$

> **Lemma 2.6.** *Under the same hypotheses,*
$$|ST|^2 = 4\sum_{\alpha\beta\gamma\delta}\bigl|T(S(\bar Z_\alpha),\bar Z_\beta,\bar Z_\gamma,Z_\delta) - T(S(\bar Z_\beta),\bar Z_\alpha,\bar Z_\gamma,Z_\delta)\bigr|^2 .$$
*If $S=\sum_\alpha\rho_\alpha Z_\alpha\otimes Z_\alpha$ is diagonal with $\rho_\alpha\ge0$ in a unitary frame, then*
$$|ST|^2 = 4\sum_{\alpha\beta\gamma\delta}\bigl|\rho_\alpha T_{\alpha\bar\beta\gamma\bar\delta} - \rho_\beta T_{\beta\bar\alpha\gamma\bar\delta}\bigr|^2. \tag{2.2}$$

> **Proposition 3.3** (Laplacian of a Kähler curvature tensor field). *Let $T$ be a smooth algebraic Kähler curvature tensor field satisfying the Kähler second Bianchi identity $\nabla_\mu T_{\alpha\bar\beta\gamma\bar\delta} = \nabla_\alpha T_{\mu\bar\beta\gamma\bar\delta}$, $\nabla_{\bar\mu}T_{\alpha\bar\beta\gamma\bar\delta} = \nabla_{\bar\beta}T_{\alpha\bar\mu\gamma\bar\delta}$. Then*
$$\Delta|T_{\alpha\bar\beta\gamma\bar\delta}|^2 = 2\nabla_\gamma\nabla_{\bar\delta}\mathrm{Ric}(T)_{\alpha\bar\beta}T_{\beta\bar\alpha\delta\bar\gamma} + 2R_{\alpha\bar\mu\gamma\bar\nu}T_{\nu\bar\beta\mu\bar\delta}T_{\beta\bar\alpha\delta\bar\gamma} - 4R_{\nu\bar\mu\gamma\bar\delta}T_{\alpha\bar\beta\mu\bar\nu}T_{\beta\bar\alpha\delta\bar\gamma} + 2R_{\nu\bar\beta}T_{\alpha\bar\nu\gamma\bar\delta}T_{\beta\bar\alpha\delta\bar\gamma} + |\nabla_\mu T|^2 + |\nabla_{\bar\mu}T|^2,$$
*where $\mathrm{Ric}(T)_{\alpha\bar\beta}=T_{\alpha\bar\beta\mu\bar\mu}$.* Compare [CCG+07, Prop. 2.79] for $T=R$ and [IK04], [CDLR19] for the Bochner tensor.

> **Proposition 3.4** (the bridge to $C$). *If $\{S_A\}_{A=1}^N$, $N=\frac{n(n+1)}2$, is a unitary basis of $S^{2,0}$ and $R$ is induced from the algebraic Calabi operator $C$ with $C(S_A)=\sigma_A S_A$, then for any algebraic Kähler curvature tensor $T$,*
$$\sum_{A=1}^N \sigma_A|S_AT|^2 = 8R_{\nu\bar\beta}T_{\alpha\bar\nu\gamma\bar\delta}T_{\beta\bar\alpha\delta\bar\gamma} - 8R_{\nu\bar\mu\gamma\bar\delta}T_{\alpha\bar\beta\mu\bar\nu}T_{\beta\bar\alpha\delta\bar\gamma}.$$

> **Proposition 3.5.** *Every smooth (not necessarily harmonic) Kähler curvature tensor field $T$ satisfying the Kähler second Bianchi identity satisfies*
$$\tfrac18\mathrm{Ric}_L(T,\bar T) = \Delta|T_{\alpha\bar\beta\gamma\bar\delta}|^2 - 2\nabla_\gamma\nabla_{\bar\delta}\mathrm{Ric}(T)_{\alpha\bar\beta}T_{\beta\bar\alpha\delta\bar\gamma} - |\nabla_\mu T|^2 - |\nabla_{\bar\mu}T|^2 = 2\,\mathrm{tr}(C_R\circ C_T\circ C_T) + \tfrac12\sum_A\sigma_A|S_AT|^2 - 2R_{\nu\bar\beta}T_{\alpha\bar\nu\gamma\bar\delta}T_{\beta\bar\alpha\delta\bar\gamma}.$$

> **Proposition 4.1** (the total weight, in the sense of the weight principle [NPW23, §3]). *For $T$ an algebraic Kähler curvature tensor and $\{S_A\}$ a unitary basis of $S^{2,0}$,*
$$\sum_A |S_AT|^2 = 4n|T_{\alpha\bar\beta\gamma\bar\delta}|^2 - 4|T_{\alpha\bar\beta}|^2 .$$
Proof by applying Proposition 3.4 with $R=I$ (the Fubini–Study tensor), where $C_R = 2\,\mathrm{id}_{S^{2,0}}$, all $\sigma_A=2$, and $R_{\alpha\bar\beta}=(n+1)g_{\alpha\bar\beta}$.

## The optimisation that fixes the constant

Passing to the traceless (Bochner) part $B$, with $C_B$ having eigenvalues $\tau_A = \sigma_A - \frac{2\lambda}{n+1}$, equation (4.1) reads
$$\tfrac{1}{8}\mathrm{Ric}_L(R,\bar R) = \tfrac12\sum_A\tau_A|S_AB|^2 + 2\sum_A\tau_A^3 + 2\lambda\sum_A\tau_A^2 .$$

> **Proposition 4.2** (the weak version). *If $C - \frac{\lambda}{n+1}\mathrm{id}_{S^{2,0}}$ is nonnegative, then $\mathrm{Ric}_L(R,\bar R)\ge0$.* Proof: with $\tau_{\min}=\min\tau_A$, the display above gives $\tfrac18\mathrm{Ric}_L \ge 2\bigl((n+1)\tau_{\min}+\lambda\bigr)|B_{\alpha\bar\beta\gamma\bar\delta}|^2 \ge 0$.

> **Lemma 4.3** (the reduction). *Set*
$$c = \max_{|S|=1}\ \frac{|SB|^2 + 4|B(S)|^2}{|B|^2}.$$
*If $C - \frac{\lambda}{n+1}$ is $\frac{n+1}{c}$-nonnegative, then $\mathrm{Ric}_L(R,\bar R)\ge0$.*

> **Lemma 4.4** (the straightforward bound). *$|SB|^2 \le 8|S|^2|B_{\alpha\bar\beta\gamma\bar\delta}|^2$.* From (2.2) and $|ax-by|^2\le(a^2+b^2)(|x|^2+|y|^2)$, noting the summand vanishes for $\alpha=\beta$.

> **Lemma 4.5** (the sharp bound, the paper's real work). *$|SB|^2 \le 6|S|^2|B_{\alpha\bar\beta\gamma\bar\delta}|^2$.* Proof splits $|SB|^2$ over multisets $I$ of four indices and estimates each block separately.

> **Remark 4.6**: the estimate is **sharp** on algebraic Kähler curvature operators with no further conditions, take $T$ with $T_{1\bar21\bar2} = \pm2T_{1\bar12\bar2}\ne0$ real and all other free coefficients zero, $S = Z_1\otimes Z_1 + Z_2\otimes Z_2$; this $T$ is realised by $C = \begin{pmatrix}0&a&0\\a&0&0\\0&0&b\end{pmatrix}$ in the basis $Z_1\odot Z_1, Z_2\odot Z_2, Z_1\odot Z_2$. The example is Einstein and $S$ is an eigenvector of $C$, so neither condition can improve the constant. **Remark 4.7**: Lemmas 4.4 and 4.5 never use that $B$ is a Bochner tensor; they hold for any algebraic Kähler curvature tensor, and no better dimension-independent bound is possible.

> **Corollary 4.8.** *Theorem A is true.* Combining Lemma 4.5 with $|B(S)|^2 \le |C_B|^2_{\mathrm{op}}|S|^2 = |B_{\alpha\bar\beta\gamma\bar\delta}|^2|S|^2$ and $|B|^2 = 4|B_{\alpha\bar\beta\gamma\bar\delta}|^2$ gives $c \le \frac{6+4}{4} = \frac52$, so Lemma 4.3 applies at $\frac{n+1}{c} = \frac{2(n+1)}5$. Then $\mathrm{Ric}_L(R,\bar R)\ge0$ forces $\nabla R=0$ globally by the maximum principle, and the Calabi–Vesentini tables [CV60] leave only $\mathbb{CP}^n$ among non-flat symmetric spaces. (The table consultation is avoidable: strict inequality in Lemma 4.5 for $|B|^2\ne0$ gives strict inequality in the Bochner formula, impossible by the maximum principle.)

## Model computations (§5) and the conjectures

**Example 2.1.** $\mathbb{CP}^n$, Fubini–Study normalised to constant holomorphic sectional curvature $2$: $I_{\alpha\bar\beta\gamma\bar\delta} = g_{\alpha\bar\beta}g_{\gamma\bar\delta} + g_{\alpha\bar\delta}g_{\gamma\bar\beta}$ and $C = 2\,\mathrm{id}_{S^{2,0}}$.

**Example 2.2.** The complex quadric $Q^n$ with $\mathrm{Ric}_{\alpha\bar\beta}=ng_{\alpha\bar\beta}$: $R_{\alpha\bar\beta\gamma\bar\delta} = g_{\alpha\bar\beta}g_{\gamma\bar\delta} + g_{\alpha\bar\delta}g_{\gamma\bar\beta} - q_{\alpha\gamma}q_{\beta\delta}$, so $Ch = 2h - \langle h,\bar q\rangle q$, two eigenvalues, $\sigma_0 = 2-n$ on $\langle q\rangle$ and $\sigma_1 = 2$ with multiplicity $\frac{(n-1)(n+2)}2$.

**Example 2.3.** $\mathbb{CP}^p\times\mathbb{CP}^q$, $p+q=n$, product Kähler–Einstein with $\mathrm{Ric}_{\alpha\bar\beta}=g_{\alpha\bar\beta}$: $C$ diagonalises along $S^{2,0}(V\oplus W) = S^2V\oplus(V\odot W)\oplus S^2W$ with eigenvalues $\frac2{p+1}$, $0$, $\frac2{q+1}$.

For products of two projective spaces the ratio $\frac{|SB|^2+4|B(S)|^2}{|S|^2|B|^2}$ is $\frac{d_j+1}{d_i(n+2)}$ and $\bigl(\frac{n+1}{d_1d_2} - \frac1{n+2}\frac{(d_1+1)(d_2+1)}{d_1d_2}\bigr)$ on the two eigenspaces; for $d_1=1$ the second is $1+\frac4{(n-1)(n+2)}$. On the complex quadric the maximum is attained at $q$, with value $\frac{n+2}n|B|^2|S|^2$, so $|SB|^2+4|B(S)|^2 \le 2|S|^2|B|^2$ there (worst at $n=2$).

> **Remark 5.1.** The half-trace $C-\frac{\lambda}{n+1}\mathrm{id}$ is $k$-nonnegative exactly for $k\ge\frac{n(n+1)}{n+2}$, precisely the value Lemma 4.3 predicts under $|SB|^2+4|B(S)|^2 \le \frac{n+2}n|B|^2|S|^2$.

**Conjecture 5.2.** *If $B$ is an algebraic Bochner operator, then $|SB|^2 + 4|B(S)|^2 \le 2|B|^2|S|^2$ for any eigenvector $S$ of $B$ viewed as an operator on $S^{2,0}$.* No asymptotically better constant can exist by Remark 4.6; the worst case known for actual manifolds is $\frac{n+2}n$.

**Conjecture 5.3.** *Let $M$ be Kähler–Einstein with $C - \frac{\lambda}{n+1}$ being $\frac{n(n+1)}{n+2}$-positive. Then $M$ is isometric to $\mathbb{CP}^n$ up to scaling. If $C-\frac{\lambda}{n+1}$ is only $\frac{n(n+1)}{n+2}$-nonnegative, then $M$ is flat, isometric to $\mathbb{CP}^n$, or isometric to a complex quadric.*

Table 1 at the end of the paper collects $\lambda$, $|B|^2$, and the ratios for $\mathbb{CP}^{d_1}\times\mathbb{CP}^{d_2}$, $(\mathbb{CP}^1)^k$, and the quadrics.

## What it cites, for the record

Calabi–Vesentini [CV60] for the operator and the symmetric-space tables; [Bor60, OT80, Sit73] for the classical development; [BNP+26], [WY25], [FXY25] for the recent partial-positivity, quadratic Weitzenböck–Bochner–Kodaira and Laplacian-comparison uses; Nienhaus–Petersen–Wink [NPW23, §3] for the weight principle that Lemma 4.3 and Proposition 4.1 implement; Tachibana [Tac74], [DF24], [CW25], Petersen–Wink [PW21] for the first-kind, second-kind and Kähler analogues with apparent sign; Mok–Zhong [MZ86] for the bisectional-curvature classification; [CCG+07, Ch. 2] for Kähler background; [IK04], [CDLR19] for Bochner-tensor Laplacians.

## Bearing on this project

Two things are worth carrying. First, the shape of Theorem B: a Bochner curvature term expressed as $\mathrm{tr}(C^3)$ plus a weighted quadratic $\sum_A\sigma_A|S_AB|^2$, cubic in the operator, with the sign an open problem (Question A, Problem B) even at the algebraic level. Second, the method by which the constant is pinned: an operator-norm optimisation (Lemma 4.3) over a single quantity $\max_{|S|=1}(|SB|^2+4|B(S)|^2)/|B|^2$, with a sharp algebraic bound (Lemma 4.5) supplying the number, and the sharpness witnessed by an explicit low-rank $C$ (Remark 4.6). The mechanism itself is global (Bochner, $\nabla$, the maximum principle, compactness) and the setting is Kähler, so nothing transfers directly to the real second-kind algebra; the group is nevertheless the closest active programme to it.

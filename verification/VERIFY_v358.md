# Verifier v358, Lemma L115 step F1: λ_max(M)=θ at every global maximiser

Cold brief ([ADJ_L115_F1.md](ADJ_L115_F1.md)), no numerical work, no scripts written, every value exact and derived by hand. Log: [agent_logs/verify-L115-v358.log](../agent_logs/verify-L115-v358.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | At any critical point, $M\lambda=\theta\lambda$ and $\theta\le\lambda_{\max}(M)$ (Passage B) | CONFIRMED |
| 2 | $\langle x,M(\lambda)x\rangle=\langle Q(D_x),W\rangle$ with $D_x=\sum_\alpha x_\alpha v_\alpha\otimes v_\alpha\in\mathcal D$, so $\lambda_{\max}(M)=\theta\,\lambda_{\max}$ of the compression of $L_e$ to $\mathcal D$ | CONFIRMED AS ALGEBRA |
| 3 | At a global maximiser, $\langle Q(X),W\rangle\le\theta\|X\|^2$ for every $X\in\mathcal W_n$ | CONFIRMED |
| 4 | The Weyl and Weyl-orthogonal parts of $D\in\mathcal D$ do not interact in $\langle Q(D),W\rangle$ | CONFIRMED |
| 5 | $\mathcal D\not\subseteq\mathcal W_n$, and a non-Weyl element of $\mathcal D$ carries positive Rayleigh value (padded $W_{\mathbb{CP}^2}$, $n\ge5$) | CONFIRMED |
| 6 | Heading: $\lambda_{\max}(M)=\theta$ at every global maximiser, every $n$, no further hypothesis | REFUTED AS STATED (unsupported, truth open) |
| 7 | By-product $\theta\ge\max_\alpha\lambda_\alpha$ at a global maximiser | CONFIRMED (strictly, without claim 6) |

**Summary: the step FAILS as a proof step, because nothing on the record caps $\langle Q(Z),W\rangle$ on $\mathcal W_n^\perp$, and it is VALID exactly under that one added hypothesis (H⊥), the rest being proved here.**

## 0. Conventions, fixed once

- $\mathcal S=S^2(\mathfrak{so}(n))$, symmetric operators on $\Lambda^2\mathbb R^n$, Frobenius inner product. $\mathcal W_n\subset\mathcal S$ the Weyl tensors, $\mathcal W_n^\perp$ its orthogonal complement in $\mathcal S$.
- $Q(X)=X^2+X^\#$ on all of $\mathcal S$, $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, $T(X,Y,Z)=\langle X\circ Y,Z\rangle$.
- $W$ unit, $Q(W)=\theta W$, $\theta=P(W)$, $e=W/\theta$, $L_e=e\circ(\cdot)$. $\{v_\alpha\}$ an orthonormal eigenframe, $c'_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle$ totally antisymmetric, $c'^2_{\alpha\beta\gamma}=(c'_{\alpha\beta\gamma})^2$.
- In $\mathbb R^4$, $\omega_1=(e_{12}+e_{34})/\sqrt2$, $\omega_2=(e_{13}+e_{42})/\sqrt2$, $\omega_3=(e_{14}+e_{23})/\sqrt2$, with $e_{ij}=e_i\wedge e_j$ orthonormal. Then $|c'_{\omega_1\omega_2\omega_3}|=\sqrt2$, the normalisation under which Passage B's formula gives $P(W_{\mathbb{CP}^2})=\sqrt{3/2}$ (checked in §5).

## Hypothesis inventory

- (S1) $T$ is totally symmetric on $\mathcal S$. Standard: $\langle X^2,Y\rangle=\mathop{\mathrm{tr}}(XXY)$, and $\langle X^\#,Y\rangle=\tfrac12\sum c_{\alpha\gamma\delta}c_{\beta\varepsilon\zeta}X_{\gamma\varepsilon}X_{\delta\zeta}Y_{\alpha\beta}$ is invariant under $(\alpha,\beta)\leftrightarrow(\gamma,\varepsilon)$ by two sign changes.
- (S2) $Q$ maps algebraic curvature operators (Bianchi) to algebraic curvature operators, hence so does $\circ$ by polarisation. Standard (Hamilton, Böhm and Wilking).
- (S3) $\mathop{\mathrm{Ric}}(Q(R))$ is linear in $\mathop{\mathrm{Ric}}(R)$ with coefficients linear in $R$ (the reaction term of the Ricci evolution in an Uhlenbeck frame, $2R_{acbd}\mathop{\mathrm{Ric}}_{cd}$). Polarised, $\mathop{\mathrm{Ric}}(X\circ Y)=0$ for $X,Y\in\mathcal W_n$. Standard, and the record itself uses its $X=Y=W$ case when it writes critical points as $Q(W)=\theta W$ inside $\mathcal W_n$.
- (S4) Banach's theorem: a symmetric trilinear form on a real inner product space has norm equal to the sup of its cubic on the unit sphere. Standard.
- (G) $W$ is a global maximiser, so $\theta=M(n)$. Given by the step.
- **(H⊥), added:** $\langle Q(Z),W\rangle\le\theta\|Z\|^2$ for every $Z$ in the orthogonal projection of $\mathcal D$ onto $\mathcal W_n^\perp$ (it suffices on all of $\mathcal W_n^\perp$). This is the cap Passage A names as missing. Nowhere on the record.

## 1. θ is an eigenvalue and a lower bound (claim 1)

$M_{\alpha\beta}$ is symmetric because $c'^2$ is. $\langle\lambda,M\lambda\rangle=P=\theta$ with $\|\lambda\|=1$ gives $\theta\le\lambda_{\max}(M)$. $(M\lambda)_\alpha=\lambda_\alpha^2+\tfrac12\sum c'^2_{\alpha\beta\gamma}\lambda_\beta\lambda_\gamma=Q(W)_{\alpha\alpha}$, and $Q(W)=\theta W$ is diagonal in the frame with entries $\theta\lambda_\alpha$. So $M\lambda=\theta\lambda$. CONFIRMED.

## 2. The matrix is the compression of L_e to the diagonal algebra (claim 2)

For $D_x$ diagonal, $(D_x^\#)_{\gamma\gamma}=\tfrac12\sum c'^2_{\gamma\alpha\beta}x_\alpha x_\beta$, so $\langle Q(D_x),W\rangle=\sum\lambda_\alpha x_\alpha^2+\tfrac12\sum c'^2_{\alpha\beta\gamma}x_\alpha x_\beta\lambda_\gamma=\langle x,Mx\rangle$. With (S1), $\langle Q(D),W\rangle=T(D,D,W)=\theta\langle D,L_eD\rangle$. Since $\|D_x\|=\|x\|$,

$$\lambda_{\max}(M)=\theta\max_{D\in\mathcal D,\ \|D\|=1}\langle D,L_eD\rangle .$$

The step is therefore equivalent to $\langle D,L_eD\rangle\le\|D\|^2$ on $\mathcal D$. Where eigenvalues repeat, $\mathcal D$ depends on the frame, and the strongest reading asks this for every eigenframe.

## 3. The cap on all of the Weyl space (claim 3)

$P$ is odd, so $\sup_{\|X\|=1}|P(X)|=M(n)$ on $\mathcal W_n$. By (S4) applied to $T|_{\mathcal W_n}$, $|T(X,X,W)|\le M(n)\|X\|^2\|W\|$. Under (G), $\langle Q(X),W\rangle\le\theta\|X\|^2$ for all $X\in\mathcal W_n$, that is $\lambda_{\max}(L_e|_{\mathcal W_n})\le1$. This is stronger than Lemma L24 (Passage C), which gives $\tfrac12$ on $W^\perp\cap\mathcal W_n$ for local maximisers only, and it still says nothing off $\mathcal W_n$.

## 4. No cross term (claim 4)

Write $D=D_W+D_c$ with $D_W\in\mathcal W_n$, $D_c\in\mathcal W_n^\perp$. By (S1), $T(D_W,D_c,W)=\langle D_c,D_W\circ W\rangle$. By (S2) $D_W\circ W$ is Bianchi and by (S3) its Ricci contraction vanishes, so $D_W\circ W\in\mathcal W_n$ and the pairing is $0$. Hence

$$\langle Q(D),W\rangle=T(D_W,D_W,W)+T(D_c,D_c,W)\le\theta\|D_W\|^2+T(D_c,D_c,W).$$

Under (H⊥) the last term is at most $\theta\|D_c\|^2$, the sum is at most $\theta\|D\|^2$, and with §1 and §2, $\lambda_{\max}(M)=\theta$. This is the VALID reading, and it holds in every eigenframe.

## 5. The cap really is needed: a non-Weyl direction of positive value (claim 5)

**$\mathcal D\not\subseteq\mathcal W_n$ always:** $\mathop{\mathrm{Id}}\in\mathcal D$ in every frame and $\mathop{\mathrm{Ric}}(\mathop{\mathrm{Id}})\ne0$.

**A direction that L24 does not see and that carries positive value.** Take padded $W_{\mathbb{CP}^2}$ in $\mathbb R^n$, $n\ge5$: eigenvalues $2a,-a,-a$ on $\omega_1,\omega_2,\omega_3$, $0$ elsewhere, $\|W\|^2=6a^2=1$. Passage B's formula gives $\sum\lambda^3=6a^3$ and $\tfrac12\cdot6\cdot2\cdot\lambda_1\lambda_2\lambda_3=12a^3$, so $P=18a^3=\sqrt{3/2}$, and $Q(W)_{\omega_1}=4a^2+2a^2=\theta\cdot2a$ gives $\theta=3a$. Consistent.

Complete the kernel frame with $f_i=e_i\wedge e_5$, $i=1,\dots,4$. $[f_i,f_j]=\pm e_{ij}$ and each $e_{ij}$ with $i<j\le4$ lies in exactly one $\omega_k$ with coefficient $\pm1/\sqrt2$, so $c'^2_{f_if_j\omega_k}=\tfrac12$ and $M_{f_if_j}=\lambda_k/4$. The block is

$$B=\frac a4\begin{pmatrix}0&2&-1&-1\\2&0&-1&-1\\-1&-1&0&2\\-1&-1&2&0\end{pmatrix},$$

with eigenvectors $(1,1,1,1)$, $(1,1,-1,-1)$, $(1,-1,0,0)$, $(0,0,1,-1)$ and eigenvalues $0,a,-a/2,-a/2$. The block decouples: $[f_i,\omega_k]\in\mathop{\mathrm{span}}\{f_j\}$, so $c'_{f_i\,\cdot\,\omega_k}$ vanishes against every frame vector outside that span. So $D=\tfrac12(f_1^{\otimes2}+f_2^{\otimes2}-f_3^{\otimes2}-f_4^{\otimes2})\in\mathcal D$ has $\langle Q(D),W\rangle=a=\theta/3>0$, and $\mathop{\mathrm{Ric}}(D)_{11}=D(f_1,f_1)=\tfrac12\ne0$, so $D\notin\mathcal W_n$.

**Arguing the opposite.** Here the value $\theta/3$ sits below $\theta$, and the same block analysis for the $\omega$ block (eigenvalues $3a,0,-3a$) and the remaining kernel gives $\lambda_{\max}(M)=\theta$ exactly at padded $W_{\mathbb{CP}^2}$. So this is no counterexample to the statement. It shows the inference from a Weyl-space cap reaches directions outside $\mathcal W_n$, which is the gap.

## 6. Where the heading fails (claim 6)

- **Located.** The heading "Lemma L115, $\lambda_{\max}(M)=\theta$ at every global maximiser" (line 268) asserts the unrestricted form. The only route in the passages is Passage A's "The step to $\lambda_{\max}(L_e|_{\mathcal D})=1$ reads that cap over the whole eigenframe-diagonal algebra $\mathcal D$", and Passage A itself says "The unrestricted form is not citable".
- **Exhibited.** By §2 the step is a cap over $\mathcal D$. By §5, $\mathcal D$ leaves $\mathcal W_n$ in directions of positive value. By §3 and §4 the passages plus standard facts control the $\mathcal W_n$ part and kill the cross term, and the residue $T(D_c,D_c,W)$ is uncontrolled. The Lean file L115.lean's cap_on_subspace_transfers_nothing records exactly this logical shape and proves nothing about $M$.
- **Opposite argued.** No global maximiser with $\lambda_{\max}(M)>\theta$ is exhibited, and none can be without knowing the maximisers. The statement may be true. Its proof is missing one inequality.
- **What would decide it.** The exact quantity is $\mu(W)=\max\{T(Z,Z,W):Z\in\pi_{\mathcal W_n^\perp}(\mathcal D),\ \|Z\|=1\}$ at each global maximiser. $\mu\le\theta$ makes the step VALID by §4. $\mu>\theta$ does not by itself refute it, since $\|D_W\|$ and $\|D_c\|$ are coupled through $\mathcal D$. A refutation needs $\max_{D\in\mathcal D}\big(T(D_W,D_W,W)+T(D_c,D_c,W)\big)>\theta\|D\|^2$ at an actual global maximiser.

## 7. The by-product (claim 7)

$\mathop{\mathrm{diag}}M=\lambda$ because $c'^2_{\alpha\alpha\gamma}=0$. The record's route via claim 6 is not needed: under (G), $\theta=M(n)\ge\sqrt{3/2}>1\ge|\lambda_\alpha|$ since $\|\lambda\|=1$, which is the Lean theorem theta_gt_lambda in L115Statement.lean. CONFIRMED, with strict inequality and a margin $\sqrt{3/2}-1$.

## Verdict

**FAILS.** The heading claims $\lambda_{\max}(M)=\theta$ at every global maximiser with no hypothesis beyond global maximality, and the passages supply only $\theta\le\lambda_{\max}(M)$ and a cap confined to $\mathcal W_n$. The step is **VALID under (H⊥)** together with the standard facts (S1)–(S4) and (G): §§1–4 then give $\lambda_{\max}(M)=\theta$ in every eigenframe. Without (H⊥), the truth of the statement is open and turns on the quantity named in §6.

# Verifier v368, frame independence of $\lambda_{\max}(M)$ at repeated eigenvalues (L115, step F7)

Cold brief ([ADJ_L115_F7.md](ADJ_L115_F7.md)). No numerical work, no scripts written, every value below is exact and every comparison is between integers or exact surds. Log: [agent_logs/verify-L115-v368.log](../agent_logs/verify-L115-v368.log).

| Claim | Verdict |
|---|---|
| $\lambda_{\max}(M)$ is independent of the orthonormal eigenbasis when the spectrum of $W$ is simple | CONFIRMED |
| $\lambda_{\max}(M)$ is independent of the orthonormal eigenbasis at every unit $W$, including repeated eigenvalues or a kernel | REFUTED AS STATED |
| $x^{\mathsf T}M(\lambda)x=\langle X,L_WX\rangle$ for $X=\sum_\alpha x_\alpha v_\alpha v_\alpha^{\mathsf T}$, so $M$ is the compression of $L_W$ to the frame-diagonal operators | CONFIRMED AS ALGEBRA |
| $\sup$ over eigenframes of $\lambda_{\max}(M)$ is intrinsic (the top Rayleigh value of $L_W$ on the commutant of $W$) | CONFIRMED |

**Summary: the step FAILS. At the unit Weyl tensor $W=\mathop{\mathrm{diag}}(2,4,-6)\oplus\mathop{\mathrm{diag}}(2,-1,-1)/\sqrt{62}$ on $\Lambda^+\oplus\Lambda^-$ of $\mathbb R^4$ (padded to any $n\ge4$), the coordinate eigenframe gives $\lambda_{\max}(M)=\sqrt{84/62}$ and a frame rotated inside the eigenvalue-$2$ plane gives $r_*/\sqrt{62}$ with $r_*$ the largest root of $x^3-x^2-59x+84$, which lies in $(7,8)$.**

## 0. Conventions, fixed once

- $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$ with $E_{ij}=e_ie_j^{\mathsf T}-e_je_i^{\mathsf T}$ orthonormal. The bracket is $[E_{ij},E_{kl}]=\delta_{jk}E_{il}-\delta_{ik}E_{jl}-\delta_{jl}E_{ik}+\delta_{il}E_{jk}$.
- For an orthonormal basis $\{v_\alpha\}$ of $\Lambda^2$, $c_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle$ is totally antisymmetric. $c^2_{\alpha\beta\gamma}$ denotes its square, totally symmetric. This is the reading under which Passage B's formula $P=\sum\lambda_\alpha^3+\tfrac12\sum c'^2_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$ and its remark "symmetric in its first two indices" hold.
- $M(\lambda)_{\alpha\beta}=\delta_{\alpha\beta}\lambda_\alpha+\tfrac12\sum_\gamma c^2_{\alpha\beta\gamma}\lambda_\gamma$, computed in a chosen orthonormal eigenbasis of $W$, exactly as Passage B defines it.
- $\Lambda^\pm\subset\Lambda^2\mathbb R^4$ carry the orthonormal bases $\omega_1=\tfrac{E_{12}+E_{34}}{\sqrt2}$, $\omega_2=\tfrac{E_{13}-E_{24}}{\sqrt2}$, $\omega_3=\tfrac{E_{14}+E_{23}}{\sqrt2}$ and $\eta_1=\tfrac{E_{12}-E_{34}}{\sqrt2}$, $\eta_2=\tfrac{E_{13}+E_{24}}{\sqrt2}$, $\eta_3=\tfrac{E_{14}-E_{23}}{\sqrt2}$.
- Scaling $W$ by $t>0$ scales $M$ by $t$, so frame dependence of $\lambda_{\max}(M)$ is decided on any positive multiple. The worked example uses the unnormalised $W$ with $|W|^2=62$ and divides by $\sqrt{62}$ at the end.

## 1. Hypothesis inventory

- **H1 (reading of $c'^2$).** $c'^2_{\alpha\beta\gamma}=(c'_{\alpha\beta\gamma})^2$. Forced by Passage B's formula for $P$, as in Section 0.
- **H2 (normalisation).** The squared structure constant of an orthonormal triple in $\Lambda^\pm$ is $2$. Forced by the brief's value $P(W_{\mathbb{CP}^2})=\sqrt{3/2}$ (Section 2) and independently by the bracket in Section 0. The failure mechanism of Section 4 needs only that this constant is nonzero, the specific integers use $2$.
- **H3 (the space).** $n\ge4$ and $\mathcal W_n$ as in the brief. In $n=4$, $\mathcal W_4=\mathrm{Sym}_0(\Lambda^+)\oplus\mathrm{Sym}_0(\Lambda^-)$, and a Weyl tensor on $\mathbb R^4$ extended by zero is a Weyl tensor on $\mathbb R^n$.
- **H4 (what "well defined" means).** $\lambda_{\max}(M)$ is the top eigenvalue of the matrix Passage B builds from one chosen orthonormal eigenbasis, and the step asserts that this number is the same for every such choice.
- **V1 (a hypothesis under which the step holds).** The spectrum of $W$ on $\Lambda^2$ is simple. A simple zero eigenvalue is allowed.
- **V2 (a redefinition under which the step holds).** $\lambda_{\max}(M)$ is replaced by its supremum over orthonormal eigenframes.

## 2. The structure constants of $\Lambda^\pm$ and the normalisation

From the bracket, $[E_{12}+E_{34},E_{13}-E_{24}]=-E_{23}-E_{14}-E_{14}-E_{23}=-2(E_{14}+E_{23})$, so $[\omega_1,\omega_2]=-\sqrt2\,\omega_3$ and $c^2(\omega_1,\omega_2,\omega_3)=2$. The same computation with $E_{34}\mapsto-E_{34}$ (orientation reversal) gives $c^2(\eta_1,\eta_2,\eta_3)=2$, and $[\Lambda^+,\Lambda^-]=0$.

Cross-check with the brief. For $W_{\mathbb{CP}^2}=s\mathop{\mathrm{diag}}(2,-1,-1)$ on $\Lambda^+$ and $0$ on $\Lambda^-$, $|W|^2=6s^2$, and Passage B's formula gives $P=6s^3+\tfrac12\cdot6\cdot2\cdot(2)(-1)(-1)s^3=18s^3$. At $s=1/\sqrt6$ this is $18/(6\sqrt6)=3/\sqrt6=\sqrt{3/2}$, the brief's value. So H2 agrees with the record.

Consequence. For $W=\mathop{\mathrm{diag}}(a_1,a_2,a_3)$ on $\Lambda^+$ in the basis $\omega$, the $\Lambda^+$ block of $M$ has $M_{ii}=a_i$ and $M_{ij}=\tfrac12\cdot2\cdot a_l=a_l$ for $\{i,j,l\}=\{1,2,3\}$:

$$M^+(a)=\begin{pmatrix}a_1&a_3&a_2\\a_3&a_2&a_1\\a_2&a_1&a_3\end{pmatrix}.$$

When $a_1+a_2+a_3=0$, each row sums to $0$, so $(1,1,1)$ is a $0$-eigenvector. The trace is $0$ and $\mathop{\mathrm{tr}}(M^+)^2=3|a|^2$, so the spectrum is $\{0,\pm\sqrt{3/2}\,|a|\}$. The same holds for $\Lambda^-$ with $b$.

## 3. The step holds under V1

Let the spectrum of $W$ be simple. Each eigenline is determined by $W$, so any two orthonormal eigenbases differ by a permutation of labels and sign changes $v_\alpha\mapsto\epsilon_\alpha v_\alpha$, $\epsilon_\alpha=\pm1$.

- A sign change sends $c_{\alpha\beta\gamma}\mapsto\epsilon_\alpha\epsilon_\beta\epsilon_\gamma c_{\alpha\beta\gamma}$, which leaves $c^2_{\alpha\beta\gamma}$ unchanged, and leaves $\lambda$ unchanged. So $M$ is unchanged.
- A permutation $\pi$ of labels replaces $M$ by $P_\pi^{\mathsf T}MP_\pi$, which has the same spectrum.

So $\lambda_{\max}(M)$, and indeed the whole spectrum of $M$, is a function of $W$ alone. A simple eigenvalue $0$ is a simple eigenvalue like any other, so "a kernel" is covered when it is one-dimensional.

## 4. Why a repeated eigenvalue breaks it: $M$ is a compression

For a frame $\{v_\alpha\}$ put $\mathcal D=\mathop{\mathrm{span}}\{v_\alpha v_\alpha^{\mathsf T}\}$ and $X=\sum x_\alpha v_\alpha v_\alpha^{\mathsf T}\in\mathcal D$, so $|X|^2=\sum x_\alpha^2$. With $L_WX=W\circ X=\tfrac12(WX+XW)+W\#X$ and $(A\#B)_{\rho\sigma}=\tfrac12\sum c_{\rho\gamma\delta}c_{\sigma\epsilon\zeta}A_{\gamma\epsilon}B_{\delta\zeta}$ (the bilinear form behind Passage B's formula for $P$), every operator involved is diagonal in the frame, so

$$\langle X,L_WX\rangle=\sum_\alpha\lambda_\alpha x_\alpha^2+\tfrac12\sum_{\alpha\beta\gamma}c^2_{\alpha\beta\gamma}\lambda_\gamma x_\alpha x_\beta=x^{\mathsf T}M(\lambda)x .$$

So $M$ is the matrix of the compression of $L_W$ to $\mathcal D$, and $\lambda_{\max}(M)$ is the largest Rayleigh value of $L_W$ on $\mathcal D$. When an eigenspace $E$ of $W$ has dimension at least $2$, the part $\mathcal D\cap\mathrm{Sym}(E)$ is the set of operators diagonal in the chosen basis of $E$, and it turns with that basis. Different frames give different subspaces, so the compressions differ, and nothing in Passage B forces their top eigenvalues to agree. Section 5 shows they do not.

This section explains the mechanism and is used nowhere below. Section 5 computes $M$ directly from Passage B's definition in both frames.

## 5. The counterexample in closed form

### 5.1 The tensor

On $\Lambda^2\mathbb R^4$ let

$$W=a_1\omega_1\omega_1^{\mathsf T}+a_2\omega_2\omega_2^{\mathsf T}+a_3\omega_3\omega_3^{\mathsf T}+b_1\eta_1\eta_1^{\mathsf T}+b_2\eta_2\eta_2^{\mathsf T}+b_3\eta_3\eta_3^{\mathsf T},\qquad a=(2,4,-6),\ b=(2,-1,-1).$$

Both triples are trace-free, so $W\in\mathcal W_4$ by H3. Its eigenvalues are $2,4,-6,2,-1,-1$, all nonzero, with $|W|^2=62$. The eigenvalue $2$ has the two-dimensional eigenspace $\mathop{\mathrm{span}}\{\omega_1,\eta_1\}$.

### 5.2 Frame 1, the coordinate eigenframe $(\omega_1,\eta_1,\omega_2,\omega_3,\eta_2,\eta_3)$

Every nonzero $c^2$ comes from the triples $\{\omega_1,\omega_2,\omega_3\}$ and $\{\eta_1,\eta_2,\eta_3\}$, each equal to $2$. So $M_1=M^+(a)\oplus M^-(b)$ with

$$M^+(a)=\begin{pmatrix}2&-6&4\\-6&4&2\\4&2&-6\end{pmatrix},\qquad M^-(b)=\begin{pmatrix}2&-1&-1\\-1&-1&2\\-1&2&-1\end{pmatrix}.$$

By Section 2, $\mathop{\mathrm{tr}}(M^+)^2=168$ and $\mathop{\mathrm{tr}}(M^-)^2=18$, so $\mathop{\mathrm{spec}}M_1=\{\pm\sqrt{84},0,\pm3,0\}$ and

$$\lambda_{\max}(M_1)=\sqrt{84}.$$

### 5.3 Frame 2, rotated inside the eigenvalue-2 plane

Put $p=\tfrac{\omega_1+\eta_1}{\sqrt2}$ and $q=\tfrac{\omega_1-\eta_1}{\sqrt2}$, both eigenvectors of eigenvalue $2$. Frame 2 is $(p,q,\omega_2,\omega_3,\eta_2,\eta_3)$, orthonormal, with $\lambda=(2,2,4,-6,-1,-1)$.

Structure constants, from $[\omega_2,\omega_3]=\pm\sqrt2\,\omega_1$, $[\eta_2,\eta_3]=\pm\sqrt2\,\eta_1$ and $[\Lambda^+,\Lambda^-]=0$:

- $c(p,\omega_2,\omega_3)=\langle[\omega_2,\omega_3],p\rangle=\pm1$, and likewise for $(q,\omega_2,\omega_3)$, $(p,\eta_2,\eta_3)$, $(q,\eta_2,\eta_3)$. Each square is $1$.
- $[p,q]=\tfrac12[\omega_1+\eta_1,\omega_1-\eta_1]=-[\omega_1,\eta_1]=0$, so $c(p,q,\cdot)=0$.
- Every triple mixing $\omega_{2,3}$ with $\eta_{2,3}$ vanishes.

Passage B's definition then gives, in frame 2:

- diagonal $(2,2,4,-6,-1,-1)$, and $M_{pq}=0$
- $M_{p\omega_2}=M_{q\omega_2}=\tfrac12a_3=-3$, $M_{p\omega_3}=M_{q\omega_3}=\tfrac12a_2=2$
- $M_{p\eta_2}=M_{q\eta_2}=\tfrac12b_3=-\tfrac12$, $M_{p\eta_3}=M_{q\eta_3}=\tfrac12b_2=-\tfrac12$
- $M_{\omega_2\omega_3}=\tfrac12(1\cdot2+1\cdot2)=2$, $M_{\eta_2\eta_3}=2$, all other entries $0$

Sanity check on the construction: $\lambda^{\mathsf T}M\lambda$ must equal $P(W)$ in both frames. Frame 1 gives $(8+64-216)+(8-1-1)+6\cdot(2\cdot4\cdot(-6))+6\cdot(2\cdot1)=-414$. Frame 2 gives $(8+8+64-216-1-1)+2\cdot3\cdot(2\cdot4\cdot(-6))+2\cdot3\cdot(2\cdot1)=-138-288+12=-414$. They agree.

Block reduction of $M_2$:

- $\tfrac{1}{\sqrt2}(1,-1,0,0,0,0)$ is an eigenvector with eigenvalue $2$, since its couplings to $\omega_{2,3},\eta_{2,3}$ cancel.
- $\tfrac{1}{\sqrt2}(0,0,0,0,1,-1)$ is an eigenvector with eigenvalue $-1-2=-3$, since $b_2=b_3$ makes its coupling to $p,q$ cancel.
- On the orthonormal remainder $u=\tfrac{1}{\sqrt2}(1,1,0,0,0,0)$, $\omega_2$, $\omega_3$, $F=\tfrac{1}{\sqrt2}(0,0,0,0,1,1)$ the matrix is

$$A=\begin{pmatrix}2&-3\sqrt2&2\sqrt2&-1\\-3\sqrt2&4&2&0\\2\sqrt2&2&-6&0\\-1&0&0&1\end{pmatrix}.$$

Characteristic polynomial. The leading $3\times3$ block $A_3$ has trace $0$, principal $2\times2$ minors $-10,-20,-28$ (sum $-58$), and $\det A_3=2(-28)+3\sqrt2(14\sqrt2)+2\sqrt2(-14\sqrt2)=-56+84-56=-28$, so $\det(xI-A_3)=x^3-58x+28$. Expanding $\det(xI-A)$ along the last row, the $(4,1)$ minor is $\det\begin{pmatrix}x-4&-2\\-2&x+6\end{pmatrix}=x^2+2x-28$, so

$$\det(xI-A)=(x-1)(x^3-58x+28)-(x^2+2x-28)=x\,(x^3-x^2-59x+84).$$

Checks: the $x^3$ coefficient is $-1=-\mathop{\mathrm{tr}}A$, and the sum of squared roots is $1^2-2(-59)=119=\mathop{\mathrm{tr}}A^2$ (diagonal $57$ plus twice the off-diagonal $31$).

Let $f(x)=x^3-x^2-59x+84$. Then $f(7)=-35$ and $f(8)=60$, and $f'(x)=3x^2-2x-59>0$ for $x\ge5$, so $f$ has exactly one root in $[5,\infty)$ and it lies in $(7,8)$. Call it $r_*$. Hence

$$\mathop{\mathrm{spec}}M_2=\{2,\,-3,\,0\}\cup\{\text{roots of }f\},\qquad\lambda_{\max}(M_2)=r_*\in(7,8).$$

### 5.4 Comparison

$r_*<8$ gives $r_*^2<64<84$, so $\lambda_{\max}(M_2)=r_*<\sqrt{84}=\lambda_{\max}(M_1)$. Both frames are orthonormal eigenbases of the same $W$. For the unit tensor $W/\sqrt{62}$ the two values are $\sqrt{84}/\sqrt{62}$ and $r_*/\sqrt{62}$, still distinct.

The whole spectrum moves as well: $\mathop{\mathrm{tr}}M_1^2=186$ and $\mathop{\mathrm{tr}}M_2^2=4+9+119=132$.

### 5.5 The same failure at every $n\ge5$, with a kernel present

Extend $W$ by zero to $\mathbb R^n$, $n=4+m$, $m\ge1$. It is Weyl (Bianchi holds inside $\mathfrak{so}(4)$ and every Ricci contraction is a $4$-dimensional one or zero). Its kernel is $K=\mathop{\mathrm{span}}\{E_{is}:i\le4<s\}\oplus\Lambda^2\mathbb R^m$, and its nonzero eigenvectors lie in $\Lambda^2\mathbb R^4$ because all six eigenvalues are nonzero.

- **Support and kernel decouple in every frame.** For a kernel frame vector $\kappa$ and support frame vectors $\rho,\gamma$, $c(\kappa,\rho,\gamma)=\langle[\rho,\gamma],\kappa\rangle=0$ because $[\rho,\gamma]\in\Lambda^2\mathbb R^4\perp K$. Every entry $M_{\kappa\rho}$ sums over support $\gamma$ only, so $M=M_{\mathrm{supp}}\oplus M_{\ker}$, and $M_{\mathrm{supp}}$ is the $6\times6$ matrix of Section 5.2 or 5.3.
- **The kernel block in the coordinate frame.** $M_{\ker}(\kappa,\kappa')=\tfrac12\sum_\gamma c(\kappa,\kappa',\gamma)^2\lambda_\gamma$ is nonzero only when $[\kappa,\kappa']$ has a $\Lambda^2\mathbb R^4$ component, which among coordinate kernel vectors happens only for $\kappa=E_{is}$, $\kappa'=E_{js}$, $i\ne j$, where $[E_{is},E_{js}]=-E_{ij}$. Then $M_{\ker}(E_{is},E_{js})=\tfrac12\langle E_{ij},WE_{ij}\rangle$. Writing $E_{12},E_{34}$ in terms of $\omega_1,\eta_1$ gives $\tfrac12\langle E_{12},WE_{12}\rangle=\tfrac14(a_1+b_1)=1$, and likewise $\tfrac14(a_2+b_2)=\tfrac34$ on the pairs $13,24$ and $\tfrac14(a_3+b_3)=-\tfrac74$ on the pairs $14,23$.
- Each $s$ contributes the $4\times4$ block with those entries, whose eigenvectors are the four sign patterns $(1,\pm1,\pm1,\pm1)$ with an even number of minus signs, with eigenvalues $1+\tfrac34-\tfrac74=0$, $1-\tfrac34+\tfrac74=2$, $-1+\tfrac34+\tfrac74=\tfrac32$, $-1-\tfrac34-\tfrac74=-\tfrac72$. The $\Lambda^2\mathbb R^m$ block is $0$. So $\lambda_{\max}(M_{\ker})=2$ in the coordinate kernel frame.

Use the coordinate kernel frame in both frames 1 and 2. Then $\lambda_{\max}(M_1)=\max(\sqrt{84},2)=\sqrt{84}$ and $\lambda_{\max}(M_2)=\max(r_*,2)=r_*$, which differ. So the failure holds at every $n\ge4$, at a tensor with a repeated nonzero eigenvalue and, for $n\ge5$, a kernel of dimension $4m+\binom m2$.

## 6. Arguing the opposite

- **Could the rotated frame be illegitimate?** $p,q$ lie in the eigenspace of eigenvalue $2$ and are orthonormal, so frame 2 is an orthonormal eigenbasis, which is all the step quantifies over.
- **Could $\lambda_{\max}$ survive although the spectrum moves?** It does in symmetric cases. At the $S^2\times S^2$ tensor ($a=b=(2,-1,-1)$) and at padded $W_{\mathbb{CP}^2}$ every rotation I tried inside a repeated eigenspace changed the spectrum and left $\lambda_{\max}$ fixed, because the lost eigenvalues were interlaced inside the kept ones. That is why the example takes $a_2\ne a_3$ and $|a|>|b|$: the unique top eigenvector of $M_1$ is $(x_1,x_2,x_3)$ in the $\omega$ block with $x_1\ne0$ (an $x_1=0$ eigenvector would be $(0,1,-1)$, which forces $a_2=a_3$), so it is not in the span that frame 2 compresses to, and the top value drops strictly. Section 5.3 confirms the drop with an exact polynomial.
- **Could a different reading of $c'^2$ rescue it?** Passage B's formula for $P$ pins $c'^2$ as the square of the structure constant (H1). The mechanism in Section 4 uses only that $M$ is built from squared frame components, which are not a tensor under rotation within an eigenspace.
- **Could the normalisation matter?** With a general nonzero triple constant $k$ in place of $2$, the argument that the top eigenvector of $M_1$ has a nonzero $\omega_1$ component still needs only $a_2\ne a_3$, and taking $b$ small keeps the top eigenspace simple and inside the $\omega$ block. The integers above are for the record's normalisation $k=2$, fixed in Section 2.
- **Does the step's context rescue it?** The step says "at every unit $W$". The tensor above is a unit Weyl tensor after scaling and is not claimed to be critical. Whether frame independence holds at every critical point or every global maximiser is a narrower question that this report leaves open.

## 7. Readings under which the step is true

- **V1.** If $W$ has simple spectrum, Section 3 proves the full spectrum of $M$ is frame independent. This covers generic $W$ and a one-dimensional kernel.
- **V2.** Define $\Lambda(W)=\sup$ over orthonormal eigenframes of $\lambda_{\max}(M)$. The union over frames of the subspaces $\mathcal D$ is the commutant $\mathcal C_W=\{X\in\mathrm{Sym}(\Lambda^2):XW=WX\}$, because a symmetric operator commutes with $W$ exactly when some eigenframe of $W$ diagonalises it. With the identity of Section 4, $\Lambda(W)=\max\{\langle X,L_WX\rangle:X\in\mathcal C_W,\ |X|=1\}$, which depends on $W$ alone. The identity needs the bilinear $\#$ of Section 4 on all of $\mathrm{Sym}(\Lambda^2)$, which is the form behind Passage B's formula.
- Neither V1 nor V2 is written in the passages. Passage B's "$\sup_W\lambda_{\max}(M)$" and Passage A's uses would need one of them stated to be well posed at tensors with repeated eigenvalues, such as $S^m\times S^m$.

## 8. Verdict

**FAILS.** As written (H1 to H4), $\lambda_{\max}(M)$ is not independent of the orthonormal eigenbasis at repeated eigenvalues: at $W=(\mathop{\mathrm{diag}}(2,4,-6)\oplus\mathop{\mathrm{diag}}(2,-1,-1))/\sqrt{62}\in\mathcal W_4$, and its zero-padding in every $\mathcal W_n$ with $n\ge5$, two orthonormal eigenframes give $\sqrt{84/62}$ and $r_*/\sqrt{62}$ with $f(r_*)=0$, $r_*\in(7,8)$, $f(x)=x^3-x^2-59x+84$. The step is VALID under V1 (simple spectrum, a simple kernel allowed), and becomes VALID for every $W$ under V2 (take the supremum over eigenframes, equivalently the top Rayleigh value of $L_W$ on the commutant of $W$).

# r829: Gate 2 on r826 §6, the one-dimensional stabiliser, and the closure of the $\mathfrak u(3)$ case

*Cold brief. I was given the setting as a list of givens and [r826](REVIEW_r826.md) §6 verbatim, and read [r826](REVIEW_r826.md) in full and nothing else of the record: in particular I did not read [r824](REVIEW_r824.md), [r825](REVIEW_r825.md) or [r827](REVIEW_r827.md), so where §6 leans on [r824](REVIEW_r824.md) §7 I replaced the appeal with a derivation of my own rather than checking it. **The programme is on an analysis-only footing. I ran no computation at all, not even a screen**: every bracket, trace, eigenvalue and dimension below was worked by hand and is exact. Log: [agent_logs/g2-dim1-r829.log](../agent_logs/g2-dim1-r829.log).*

| Item | What was checked | Verdict |
|---|---|---|
| 1 | §5.5's enumeration of $\mathfrak z(X)$ is exhaustive, four shapes $\mathfrak t^3,\mathfrak k,\Lambda^2Q\oplus\Lambda^2Q^\perp,\mathfrak u(3)$ | **CONFIRMED**, re-derived from the skew normal form. Seven eigenvalue patterns collapse to exactly those four algebras up to conjugacy |
| 2 | The $\mathfrak t^3$ bullet | **CONFIRMED.** $\dim U=3=\dim\mathfrak z(X)$ forces $U=\mathfrak t^3$, and $\mathfrak z(\mathfrak t^3)=\mathfrak t^3$ because a Cartan subalgebra is its own centraliser |
| 3 | The $\mathfrak k$ bullet, and whether §5 secretly uses $\dim\mathfrak z(U)=2$ | **CONFIRMED.** §5.1 to §5.4 use only $U\subseteq\mathfrak k$. The hypothesis $\dim\mathfrak z(U)=2$ enters only in §5.5's reduction, which at $\dim\mathfrak z(U)=1$ is replaced by the cheaper $U\subseteq\mathfrak z(\mathfrak z(U))=\mathfrak z(X)$ |
| 4 | The seven-dimensional bullet, step by step | **CONCLUSION CONFIRMED, WRITE-UP DEFECTIVE IN TWO PLACES.** I re-derived the whole constraint list block by block and it is complete. The Sylvester step and the case split are both sound and the split is exhaustive. The rank-one paragraph has $\mathcal V$ where it needs $\mathcal V^{\mathsf T}$ throughout, and its appeal to [r824](REVIEW_r824.md) §7 is unnecessary: §5.4's own lemma closes that branch |
| 5 | $X=(c,0,0)$ and $X=(c,c,c)$ as representatives | **CONFIRMED.** Both are right, and the argument depends only on the conjugacy class, the constraint system being $O(6)$-equivariant and $\mathfrak z(X)$ being scale-invariant in $X$ |
| 6 | The scope of the conclusion | **EARNED**, with a correction of emphasis: no bullet uses any hypothesis on $\dim V$, and what is genuinely six-dimensional is the ambient $\mathfrak{so}(6)$, not the support |
| 7 | The untouched $\mathfrak u(3)$ case | **IT CLOSES.** Three lemmas, proved below: Bianchi forces $U\subseteq\mathfrak{su}(3)$, Ricci then forces $A_1^2=A_2^2=A_3^2$, and that classifies the triple as the padded family $\Lambda^{\pm}P$ on a $J$-complex $4$-plane, with $\dim\mathfrak z(U)=4$. **So no triple has $\dim\mathfrak z(U)=1$ at all**, and the surviving shape of §6's conclusion is empty |
| 8 | A falsifier of the whole claim | **NONE FOUND**, and §7's closure removes the target: a triple with $\dim\mathfrak z(U)=1$ does not exist in any of the four shapes |

**One line.** *Every disposed bullet of §6 stands and I re-derived each of them, so §6's conclusion is earned as written, and the case it left open closes too, which upgrades the conclusion from "$\mathfrak z(U)=0$ or $\mathfrak z(U)=\mathbb RJ$ with $U\subseteq\mathfrak u(3)$" to the flat statement that a solution at $\dim V=6$ has $\mathfrak z(U)=0$.*

## 0. Conventions, fixed once

$\Lambda^2\mathbb R^6\cong\mathfrak{so}(6)$, a $2$-form is a real skew $6\times6$ matrix, $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$, the bracket is the commutator. $E_{ab}=e_ae_b^{\mathsf T}-e_be_a^{\mathsf T}$ is unit in this norm, and a unit $(anti)$self-dual form on a $4$-plane $P$ squares to $-\tfrac12\Pi_P$. The triple is $\omega_1,\omega_2,\omega_3$ orthonormal, $U=\mathop{\mathrm{span}}(\omega_i)$, $\Lambda=\mathop{\mathrm{diag}}(\lambda_1,\lambda_2,\lambda_3)$ with $\sum_i\lambda_i=0$ and every $\lambda_i\neq0$, Ricci is $\sum_i\lambda_i\omega_i^2=0$ and Bianchi is $\sum_i\lambda_i\,\omega_i\wedge\omega_i=0$. $V$ is the support, the sum of the images of the $\omega_i$.

In §7 I identify $\mathbb R^6$ with $\mathbb C^3$ through a complex structure $J$, write $\mathfrak u(3)$ for the anti-hermitian $3\times3$ complex matrices, and put $\omega_i\leftrightarrow A_i=iH_i$ with $H_i$ hermitian. $\tau_i=\mathop{\mathrm{tr}}H_i$, $\sigma_1,\sigma_2,\sigma_3$ are the elementary symmetric functions of the eigenvalues, $\mathop{\mathrm{adj}}$ is the classical adjugate, and $(\cdot)_0$ is the trace-free part.

## 1. Hypothesis inventory

What every derivation below is allowed to use: orthonormality of the triple; $\sum_i\lambda_i=0$; every $\lambda_i\neq0$; Ricci; Bianchi; the ambient being $\mathfrak{so}(6)$; and the two givens of the brief, that $\dim\mathfrak z(U)\ge3$ is excluded and that $\dim\mathfrak z(U)=2$ is excluded. What is **not** used anywhere in §2 to §8: any hypothesis on $\dim V$, any genericity of $\lambda$, any assumption that $U$ is a subalgebra, and any numerical input. §7 additionally uses that the complex dimension is exactly $3$, in two places that I flag where they occur.

## 2. Item 1: the enumeration of $\mathfrak z(X)$, derived rather than quoted

Let $X\in\mathfrak{so}(6)$ be nonzero. In a suitable orthonormal basis $X=\bigoplus_{k=1}^3c_kJ_2$ with $c_1\ge c_2\ge c_3\ge0$, where $J_2$ is the standard $2\times2$ rotation generator. Decompose $\mathbb R^6=\ker X\oplus\bigoplus_cV_c$, the sum over the distinct values $c>0$ occurring among the $c_k$, where $V_c$ is the sum of the blocks carrying $c$. These are the eigenspaces of the symmetric operator $X^2$, with eigenvalues $0$ and $-c^2$, so **every $Y$ commuting with $X$ preserves each of them**, and $\mathfrak z(X)$ is the direct sum of its parts. On $\ker X$ the condition is empty, contributing $\mathfrak{so}(\ker X)$. On $V_c$ the operator $X/c$ is a complex structure and commuting with it is exactly complex linearity, so the contribution is $\mathfrak u(V_c)$, of real dimension $m_c^2$ where $\dim_{\mathbb R}V_c=2m_c$.

The patterns, with $X\neq0$:

| pattern | $\mathfrak z(X)$ | $\dim$ |
|---|---|---|
| $c_1>c_2>c_3>0$ | $\mathfrak u(1)^3$ | $3$ |
| $c_1=c_2>c_3>0$ | $\mathfrak u(2)\oplus\mathfrak u(1)$ | $5$ |
| $c_1>c_2=c_3>0$ | $\mathfrak u(1)\oplus\mathfrak u(2)$ | $5$ |
| $c_1=c_2=c_3>0$ | $\mathfrak u(3)$ | $9$ |
| $c_1>c_2>0=c_3$ | $\mathfrak u(1)^2\oplus\mathfrak{so}(2)$ | $3$ |
| $c_1=c_2>0=c_3$ | $\mathfrak u(2)\oplus\mathfrak{so}(2)$ | $5$ |
| $c_1>0=c_2=c_3$ | $\mathfrak u(1)\oplus\mathfrak{so}(4)$ | $7$ |

Seven patterns, four algebras. The two dimension-$3$ rows are maximal tori, since $\mathfrak{so}(2)=\mathfrak u(1)$, and all maximal tori of $\mathfrak{so}(6)$ are conjugate. The three dimension-$5$ rows are each $\mathfrak u(P,J_P)\oplus\mathfrak{so}(P^\perp)$ for a $4$-plane $P$ carrying a compatible complex structure, and any two such pairs $(P,J_P)$ are carried to one another by $O(6)$, so all three are conjugate to $\mathfrak k=\mathbb Ra\oplus\Lambda^-P\oplus\mathbb R\varepsilon$. The identification is r826 §4.3's, with $\mathfrak u(2)=\Lambda^-P\oplus\mathbb Ra$ and $a$ the Kähler form of $J_P$. The dimension-$7$ row is $\Lambda^2Q\oplus\Lambda^2Q^\perp$ with $Q$ the $2$-plane where $X$ is nonzero and $Q^\perp=\ker X$, of dimension $1+6=7$. The dimension-$9$ row is $\mathfrak u(3)$ at $X=cJ$.

**So §5.5's four shapes are exhaustive, including at every degenerate eigenvalue pattern.** The degenerate patterns are exactly the last three rows and they produce no new algebra: a zero eigenvalue of multiplicity one block gives $\mathfrak{so}(2)$, which is a torus factor like any other, and a zero eigenvalue of multiplicity two blocks gives the $\mathfrak{so}(4)$ that makes the dimension-$7$ shape. **CONFIRMED.**

**Argue the opposite.** The place a shape could hide is a cross term between two eigenspaces of $X^2$ sharing an eigenvalue, which is what the grouping into $V_c$ is for, and a cross term between $\ker X$ and some $V_c$, which cannot commute with $X$ because $X$ is invertible on one side and zero on the other. Both are covered. The other place is $X=0$, giving $\mathfrak{so}(6)$, excluded because $\mathfrak z(U)=\mathbb RX$ is one-dimensional.

## 3. Item 2: the $\mathfrak t^3$ bullet

The bullet uses exactly what the brief suspects. $U\subseteq\mathfrak z(\mathfrak z(U))=\mathfrak z(X)=\mathfrak t^3$, the $\omega_i$ are orthonormal hence linearly independent so $\dim U=3$, and $\dim\mathfrak t^3=3$, so $U=\mathfrak t^3$. Then $\mathfrak z(U)=\mathfrak z(\mathfrak t^3)$.

**$\mathfrak z(\mathfrak t^3)=\mathfrak t^3$ in $\mathfrak{so}(6)$.** One inclusion is abelianness. For the other, pick a regular $Y\in\mathfrak t^3$, one with $c_1>c_2>c_3>0$, which §2's first row shows has $\mathfrak z(Y)=\mathfrak t^3$, and then $\mathfrak z(\mathfrak t^3)\subseteq\mathfrak z(Y)=\mathfrak t^3$. So $\dim\mathfrak z(U)=3\neq1$, and the bullet closes. **CONFIRMED**, and note the bullet needs no constraint equation at all: it is pure dimension counting.

## 4. Item 3: the $\mathfrak k$ bullet, and whether §5 is really available

**Where the dimension-two hypothesis lives in §5.** I read §5.1 to §5.5 for it. §5.1 decomposes $\omega_i=\alpha_ia+m_i+c_i\varepsilon$ against the orthogonal splitting of $\mathfrak k$ and needs only $U\subseteq\mathfrak k$. §5.2 computes $\omega_i^2$ and $\omega_i\wedge\omega_i$ block by block and needs only that decomposition. §5.3 needs only $\sum_i\lambda_i=0$ with $\lambda_i\neq0$, giving signature $(2,1)$ or $(1,2)$ and Witt index $1$. §5.4 needs only orthonormality, the isotropy of $u$ and $\Lambda$ nonsingular. **Nowhere in §5.1 to §5.4 does $\dim\mathfrak z(U)=2$ appear.** It appears once, in §5.5, and only in the reduction that produces $U\subseteq\mathfrak k$ in the first place: $\dim\mathfrak z(U)=2$ makes $\mathfrak z(U)$ toral, and a singular $2$-torus is Weyl-conjugate to $\ker(e_1-e_2)$, whose centraliser is $\mathfrak k$.

**At $\dim\mathfrak z(U)=1$ that reduction is replaced by something cheaper and the bullet is legitimate.** $\mathfrak z(U)=\mathbb RX$ gives $U\subseteq\mathfrak z(\mathfrak z(U))=\mathfrak z(X)$ with no toral or conjugacy input, and §2 says a five-dimensional $\mathfrak z(X)$ is conjugate to $\mathfrak k$, with the conjugation free because the constraint system is $O(6)$-equivariant. Then §5.1 to §5.4 run verbatim and give $\alpha=c=0$, so the three orthonormal $\omega_i$ lie in the three-dimensional $\Lambda^-P$ and $U=\Lambda^-P$. Its centraliser is $\Lambda^+P\oplus\Lambda^2P^\perp$ of dimension $3+1=4$, by r826 §1's block computation with the two chiralities exchanged. $4\neq1$. **CONFIRMED.**

**The one thing the bullet should say and does not.** "§5 applies verbatim" is true of §5.1 to §5.4 and false of §5.5, whose reduction is about a hypothesis this case does not have. The repair is one clause: *by $U\subseteq\mathfrak z(\mathfrak z(U))$ and the conjugacy of five-dimensional centralisers*. As written a careful reader is entitled to ask where the dimension-two hypothesis went, and the answer is that the bullet supplies its own substitute for it.

## 5. Item 4: the seven-dimensional bullet, step by step

Write $Q$ for the $2$-plane on which $X$ acts, $Q^\perp=\ker X$ of dimension $4$, $\varepsilon_Q$ the unit area form of $Q$, and $\Lambda^\pm Q^\perp$ the two chiralities on $Q^\perp$, identified with $\mathbb R^3$ by orthonormal bases. So $\mathfrak z(X)=\mathbb R\varepsilon_Q\oplus\Lambda^+Q^\perp\oplus\Lambda^-Q^\perp$, three mutually orthogonal summands of dimensions $1+3+3=7$, and $\omega_i=t_i\varepsilon_Q+\alpha_i+b_i$ with $\alpha_i\leftrightarrow u_i$ and $b_i\leftrightarrow v_i$ is a legitimate and exhaustive orthogonal decomposition. **The block decomposition is right.**

### 5.1 The constraint list, re-derived from scratch

Since $\varepsilon_Q=\varepsilon_Q\Pi_Q$ and $\alpha_i,b_i$ kill $Q$, the cross products vanish as matrices and $\omega_i^2=t_i^2\varepsilon_Q^2+(\alpha_i+b_i)^2$. Now $\varepsilon_Q^2=-\Pi_Q$, and on $Q^\perp$ the two chiralities commute, $\alpha_i^2=-\tfrac12\lvert u_i\rvert^2\Pi_{Q^\perp}$, $b_i^2=-\tfrac12\lvert v_i\rvert^2\Pi_{Q^\perp}$ and $\alpha_ib_i=b_i\alpha_i$ lies in $S^2_0Q^\perp$. So

$$\omega_i^2=\big[-t_i^2\Pi_Q\big]\ \oplus\ \Big[-\tfrac{\lvert u_i\rvert^2+\lvert v_i\rvert^2}{2}\Pi_{Q^\perp}+2\alpha_ib_i\Big],$$

with the cross block $Q\otimes Q^\perp$ empty because every $\omega_i$ is block diagonal. Ricci splits into the $Q$ trace, the $Q^\perp$ trace and the $Q^\perp$ trace-free part:

$$\sum_i\lambda_it_i^2=0,\qquad \sum_i\lambda_i\big(\lvert u_i\rvert^2+\lvert v_i\rvert^2\big)=0,\qquad \sum_i\lambda_i\alpha_ib_i=0 .$$

For Bianchi, $\varepsilon_Q\wedge\varepsilon_Q=0$, $\alpha_i\wedge b_i=0$ because the chiralities are orthogonal for the wedge pairing, and $\alpha\wedge\alpha=+\lvert u\rvert^2\mathrm{vol}$, $b\wedge b=-\lvert v\rvert^2\mathrm{vol}$ up to one common positive factor. The three blocks of $\Lambda^4\mathbb R^6$ are $\Lambda^4Q^\perp$ of dimension $1$, $Q\wedge\Lambda^3Q^\perp$ of dimension $8$, empty here, and $\Lambda^2Q\wedge\Lambda^2Q^\perp$ of dimension $6$. So

$$\sum_i\lambda_i\big(\lvert u_i\rvert^2-\lvert v_i\rvert^2\big)=0,\qquad \sum_i\lambda_it_iu_i=0,\qquad \sum_i\lambda_it_iv_i=0 .$$

Adding and subtracting the two scalars from the two sides gives $\sum_i\lambda_i\lvert u_i\rvert^2=\sum_i\lambda_i\lvert v_i\rvert^2=0$. **This is exactly the bullet's list, nothing dropped and nothing double-counted.** Two remarks the write-up owes a reader, neither of them a defect in the mathematics:

- **One of the three scalars is implied by the other two.** Orthonormality gives $t_i^2+\lvert u_i\rvert^2+\lvert v_i\rvert^2=1$, so $\sum_i\lambda_i(t_i^2+\lvert u_i\rvert^2+\lvert v_i\rvert^2)=\sum_i\lambda_i=0$ identically. This is the same redundancy r826 §5.2 flags in the $\mathfrak k$ case, and it is the reason the two trace parts of Ricci are one condition rather than two.
- **The sign convention is immaterial.** Reversing the orientation of $Q^\perp$ exchanges $\Lambda^+$ and $\Lambda^-$ and flips the sign of the $\mathrm{vol}$ equation. The pair of scalars still yields $\sum\lambda_i\lvert u_i\rvert^2=\sum\lambda_i\lvert v_i\rvert^2=0$.

**The identification $S^2_0\mathbb R^4\cong\Lambda^+\otimes\Lambda^-$ is legitimate.** Both are $9$-dimensional, both are the irreducible $(1,1)$ representation of $\mathfrak{so}(4)=\mathfrak{su}(2)_+\oplus\mathfrak{su}(2)_-$, and $(\alpha,b)\mapsto\alpha b$ is bilinear, equivariant and nonzero, so it is an isomorphism by Schur. Under it $\sum_i\lambda_i\alpha_ib_i=0$ is $\sum_i\lambda_iu_iv_i^{\mathsf T}=0$, which with $\mathcal U=[u_1\,u_2\,u_3]$ and $\mathcal V=[v_1\,v_2\,v_3]$ is $\mathcal U\Lambda\mathcal V^{\mathsf T}=0$. **CONFIRMED**, and the column convention is the right one for this equation.

### 5.2 The Sylvester step and the exhaustiveness of the case split

$\Lambda$ is invertible, so $\mathop{\mathrm{rank}}(\mathcal U\Lambda)=\mathop{\mathrm{rank}}\mathcal U$, and $(\mathcal U\Lambda)\mathcal V^{\mathsf T}=0$ puts the column space of $\mathcal V^{\mathsf T}$ inside $\ker(\mathcal U\Lambda)$, of dimension $3-\mathop{\mathrm{rank}}\mathcal U$. Hence $\mathop{\mathrm{rank}}\mathcal V\le3-\mathop{\mathrm{rank}}\mathcal U$. **CONFIRMED**, and it is rank-nullity rather than anything deeper.

**The split is exhaustive.** If $\mathop{\mathrm{rank}}\mathcal U\ge2$ and $\mathop{\mathrm{rank}}\mathcal V\ge2$ then the sum is at least $4$, against the bound. So $\min(\mathop{\mathrm{rank}}\mathcal U,\mathop{\mathrm{rank}}\mathcal V)\le1$, and the four treated cases $\mathop{\mathrm{rank}}\mathcal U\in\{0,1\}$ together with $\mathop{\mathrm{rank}}\mathcal V\in\{0,1\}$ cover every admissible pair, including $(2,1)$ and $(3,0)$. The bullet leaves this one-line argument implicit and it should be written, since "the cases $\mathop{\mathrm{rank}}\mathcal V\le1$ are the same" is doing real work: without the observation that the two rank conditions cannot both fail, the reader has no reason to think the four cases are all of them.

**The reflection is a genuine symmetry.** Take $g\in O(6)$ acting as the identity on $Q$ and as a reflection on $Q^\perp$. It fixes $X$, so it preserves $\mathfrak z(X)$, it exchanges $\Lambda^+Q^\perp$ and $\Lambda^-Q^\perp$, hence exchanges $\mathcal U$ and $\mathcal V$, and Ricci and Bianchi are equations in $O(6)$-representations so they are preserved. $\dim\mathfrak z(U)$ is a conjugation invariant. So the $\mathop{\mathrm{rank}}\mathcal V\le1$ cases really are the $\mathop{\mathrm{rank}}\mathcal U\le1$ cases read in a mirror.

### 5.3 The two branches, and the appeal to §5.4's lemma

**$\mathop{\mathrm{rank}}\mathcal U=0$, closed without [r824](REVIEW_r824.md) §7.** Then $u_i=0$, so $\omega_i=t_i\varepsilon_Q+b_i$ and the surviving constraints are $\sum_i\lambda_it_i^2=0$, $\sum_i\lambda_it_iv_i=0$, with orthonormality $\mathcal V^{\mathsf T}\mathcal V=I_3-tt^{\mathsf T}$. Put $M=\mathcal V^{\mathsf T}$, the $3\times3$ matrix whose **rows** are the $v_i$, so that $MM^{\mathsf T}$ is their Gram matrix. The three displayed facts are $MM^{\mathsf T}=I-\gamma^2uu^{\mathsf T}$ with $u=t$ and $\gamma=1$, $u^{\mathsf T}\Lambda u=0$, and $M^{\mathsf T}(\Lambda u)=0$. **That is §5.4's lemma exactly**, and it gives $t=0$. Then the three orthonormal $\omega_i$ lie in $\Lambda^-Q^\perp$, so $U=\Lambda^-Q^\perp$ and $\mathfrak z(U)=\Lambda^+Q^\perp\oplus\Lambda^2Q$ of dimension $4\neq1$. **So the bullet's appeal to [r824](REVIEW_r824.md) §7 is replaceable by the lemma it has already stated**, which is worth doing: it removes a cross-reference from a different review, and it makes the branch visibly the same phenomenon as the other one.

**$\mathop{\mathrm{rank}}\mathcal U=1$.** Then $u_i=p_i\hat u$ with $\hat u$ unit and $p\neq0$. The scalars become $p^{\mathsf T}\Lambda p=0$ and $t^{\mathsf T}\Lambda t=0$, and $\sum_i\lambda_it_iu_i=0$ becomes $p^{\mathsf T}\Lambda t=0$, so $\mathop{\mathrm{span}}(p,t)$ is totally isotropic for a form of signature $(2,1)$ or $(1,2)$, whose Witt index is $1$, so that span is a line: $p=p\,\xi$ and $t=q\,\xi$ with $p\neq0$. The Ricci trace-free block $\mathcal U\Lambda\mathcal V^{\mathsf T}=0$ reads $\hat u\big(\sum_i\lambda_ip_iv_i\big)^{\mathsf T}=0$, so $\sum_i\lambda_i\xi_iv_i=0$, and orthonormality reads $\mathcal V^{\mathsf T}\mathcal V=I-(p^2+q^2)\xi\xi^{\mathsf T}$. With $M=\mathcal V^{\mathsf T}$ again these are $MM^{\mathsf T}=I-\gamma^2\xi\xi^{\mathsf T}$ with $\gamma^2=p^2+q^2$, $\xi^{\mathsf T}\Lambda\xi=0$ and $M^{\mathsf T}(\Lambda\xi)=0$: **§5.4's lemma at the objects it was proved on**, a $3\times3$ Gram matrix, a $3$-vector isotropic for the same nonsingular $\Lambda$ of Witt index $1$, and the same vanishing. Its two branches run unchanged. If $\gamma^2\lvert\xi\rvert^2<1$ then $M$ is invertible and $\Lambda\xi=0$ forces $\xi=0$. If $\gamma^2\lvert\xi\rvert^2=1$ then $MM^{\mathsf T}\xi=0$ and $\mathop{\mathrm{rank}}MM^{\mathsf T}=2$ give $\ker M^{\mathsf T}=\mathbb R\xi$, so $\Lambda\xi=\kappa\xi$, so $\kappa\lvert\xi\rvert^2=\xi^{\mathsf T}\Lambda\xi=0$ and $\Lambda\xi=0$, again $\xi=0$. Either way $p=0$, against $\mathop{\mathrm{rank}}\mathcal U=1$. **The appeal is legitimate.**

### 5.4 The defect in the write-up, located and stated

**Located.** The rank-one paragraph of [r826](REVIEW_r826.md) §6, third bullet, at the words *"$\mathcal V\mathcal V^{\mathsf T}=I-(p^2+q^2)\xi\xi^{\mathsf T}$ with $\mathcal V^{\mathsf T}(\Lambda\xi)=0$"*.

**The failure, concretely.** The same paragraph defines $\mathcal U,\mathcal V$ as *"the matrices with columns $u_i,v_i$"*, which is the convention the Sylvester step needs, since $\sum_i\lambda_iu_iv_i^{\mathsf T}=\mathcal U\Lambda\mathcal V^{\mathsf T}$ only in that convention. In it, the Gram matrix of the $v_i$ is $\mathcal V^{\mathsf T}\mathcal V$ and the vector equation $\sum_i\lambda_i\xi_iv_i=0$ is $\mathcal V\Lambda\xi=0$. The two quoted expressions are each the transpose of what the text needs, and $\mathcal V\mathcal V^{\mathsf T}$ is not a Gram matrix, so the Gram positivity $\gamma^2\lvert\xi\rvert^2\le1$ that makes §5.4's two branches exhaustive is not available for the object as written.

**Argue the opposite, which is where this lands.** Read $\mathcal V$ in the rank-one sentence as §5.4's $M$, whose rows are the vectors, and both expressions are correct verbatim and the lemma applies word for word, which is plainly what the author meant by *"§5.4's lemma verbatim"*. The slip is a single consistent transposition inside one sentence, it does not touch the Sylvester step in the preceding sentence, and no conclusion moves. **Recorded as a write-up defect, not a mathematical one**: fix it by writing $\mathcal V^{\mathsf T}\mathcal V$ and $\mathcal V(\Lambda\xi)=0$, or by saying once that $M=\mathcal V^{\mathsf T}$.

## 6. Item 5: the representatives

$X=(c,0,0)$ is the pattern with $c_1>0=c_2=c_3$, and §2's table gives $\mathfrak z(X)=\Lambda^2Q\oplus\Lambda^2Q^\perp$ with $\dim Q=2$, so the bullet's representative matches its own description. $X=(c,c,c)$ is $X=cJ$ for the complex structure $J$ built from the three blocks, and $\mathfrak z(X)=\mathfrak u(3)$. Both are right.

**Nothing depends on the representative.** $\mathfrak z(X)=\mathfrak z(sX)$ for $s\neq0$, so the value of $c$ is irrelevant; conjugating $X$ conjugates $\mathfrak z(X)$; and Ricci, Bianchi, orthonormality and $\dim\mathfrak z(U)$ are all $O(6)$-equivariant or $O(6)$-invariant, so a solution in one representative's centraliser transports to one in any conjugate. What the argument genuinely uses is the conjugacy class of $\mathfrak z(X)$ as a subalgebra, which §2 shows is determined by its dimension. One caveat worth stating: in the $\mathfrak u(3)$ row, $c$ and $-c$ give $J$ and $-J$, two different complex structures with the **same** $\mathfrak u(3)$, so even the sign is immaterial.

## 7. Item 6: the scope of the conclusion

**No bullet uses a hypothesis on $\dim V$.** §3 is a dimension count inside $\mathfrak{so}(6)$. §4 inherits r826 §5.5's own finding that its constraint computation has no dimension hypothesis. §5 is a block computation in $\mathfrak z(X)$ and never mentions the support. §8 below is the same. What each bullet produces is a value of $\dim\mathfrak z(U)$ in $\{3,4\}$, contradicting $1$.

**What is six-dimensional is the ambient, not the support.** The enumeration of §2, the shapes $\mathfrak k$, $\Lambda^2Q\oplus\Lambda^2Q^\perp$ and $\mathfrak u(3)$, and the value $4$ for the centraliser of a chirality on a $4$-plane, are all statements about $\mathfrak{so}(6)$ and would each need redoing in $\mathfrak{so}(2n)$. So the honest scope line is *"in $\mathfrak{so}(6)$, with no hypothesis on the support"*, and §6's *"at $\dim V=6$"* is inherited from the surrounding programme rather than used.

**The final sentence is earned**, given the brief's two givens. Reading it as *no solution has $\dim\mathfrak z(U)\ge2$ by the givens, and a solution with $\dim\mathfrak z(U)=1$ has $\mathfrak z(U)=\mathbb RJ$ and $U\subseteq\mathfrak u(3)$ by §6's four bullets*, every step is supplied: the enumeration is exhaustive by §2, three bullets close by §3 to §5, and in the surviving one $\mathfrak z(U)=\mathbb RX$ with $\mathfrak z(X)=\mathfrak u(3)$ forces $X$ to be a multiple of a complex structure, so $\mathfrak z(U)=\mathbb RJ$. The qualifier *"at $\dim V=6$"* is nonetheless needed for a reason the bullets do not display: the padded family satisfies Ricci and Bianchi with $\dim\mathfrak z(U)=4$, so the given that $\dim\mathfrak z(U)\ge3$ is excluded can only be a statement about solutions of full support.

## 8. Item 7: the $\mathfrak u(3)$ case closes

This is the section the brief asked for, and the outcome is stronger than narrowing. Throughout, $U\subseteq\mathfrak u(3)$, $\omega_i\leftrightarrow A_i=iH_i$ with $H_i$ hermitian $3\times3$, and $\tau_i=\mathop{\mathrm{tr}}H_i$.

### 8.1 The three conditions in these terms

**Inner product.** For $\mathbb C$-linear maps $\mathop{\mathrm{tr}}_{\mathbb R}=2\mathop{\mathrm{Re}}\mathop{\mathrm{tr}}_{\mathbb C}$, and the real transpose of $A$ is the hermitian adjoint $A^*$, so $\langle\omega,\omega'\rangle=\tfrac12\mathop{\mathrm{tr}}_{\mathbb R}(A^*A')=\mathop{\mathrm{Re}}\mathop{\mathrm{tr}}(A^*A')=\mathop{\mathrm{tr}}(H H')$. **Orthonormality is $\mathop{\mathrm{tr}}(H_iH_j)=\delta_{ij}$**, and the unit condition $\mathop{\mathrm{tr}}A_iA_i^*=1$ of the brief is $\mathop{\mathrm{tr}}H_i^2=1$.

**Ricci.** $A_i^2=-H_i^2$ is hermitian and $\mathbb C$-linear, and the real symmetric matrix it defines determines it, so $\sum_i\lambda_i\omega_i^2=0$ is **$\sum_i\lambda_iH_i^2=0$**, nine real equations. Its trace is $\sum_i\lambda_i\mathop{\mathrm{tr}}H_i^2=\sum_i\lambda_i=0$ identically, so the content is eight.

**Bianchi, stated in these terms, which the brief asks for.** Take $H=\mathop{\mathrm{diag}}(h_1,h_2,h_3)$ in a unitary basis and the adapted real basis $e_{2k-1},e_{2k}=Je_{2k-1}$. Then $\omega=\sum_kh_k\,e^{2k-1}\wedge e^{2k}$ and $\omega\wedge\omega=2\sum_{k<l}h_kh_l\,e^{2k-1}\wedge e^{2k}\wedge e^{2l-1}\wedge e^{2l}$, whose Hodge dual is $2(h_2h_3e^{12}+h_1h_3e^{34}+h_1h_2e^{56})$, that is $2i\mathop{\mathrm{adj}}(H)$ under $e^{12}\leftrightarrow i\mathop{\mathrm{diag}}(1,0,0)$ and its partners. Both $H\mapsto\mathop{\mathrm{adj}}(H)$ and $\omega\mapsto\ast(\omega\wedge\omega)$ are $U(3)$-equivariant quadratic maps, and every hermitian matrix is unitarily diagonalisable, so they agree everywhere. $\ast$ is an isomorphism $\Lambda^4\to\Lambda^2$, so **Bianchi is $\sum_i\lambda_i\mathop{\mathrm{adj}}(H_i)=0$**, nine more real equations.

**Bianchi is an extra condition, not implied.** By Cayley-Hamilton, $\mathop{\mathrm{adj}}(H)=H^2-\sigma_1(H)H+\sigma_2(H)I$, and $\sigma_2(H_i)=\tfrac12(\tau_i^2-\mathop{\mathrm{tr}}H_i^2)=\tfrac12(\tau_i^2-1)$ because every $H_i$ is unit. So **given Ricci**, Bianchi is exactly

$$\sum_i\lambda_i\tau_iH_i=\kappa I,\qquad \kappa:=\sum_i\lambda_i\sigma_2(H_i)=\tfrac12\sum_i\lambda_i\tau_i^2, \tag{$\ast$}$$

using $\sum_i\lambda_i=0$ to drop the constant. This is a genuine extra condition on a general triple in $\mathfrak u(3)$, and it is vacuous exactly on the trace-free ones: if every $\tau_i=0$ then both sides vanish. §8.2 shows the converse, that ($\ast$) forces the trace-free case, so **the entire content of first Bianchi here is "the triple is trace-free"**.

### 8.2 Lemma U1: Bianchi forces $U\subseteq\mathfrak{su}(3)$

*Assume Ricci, Bianchi, orthonormality, $\sum_i\lambda_i=0$ and every $\lambda_i\neq0$. Then $\tau_i=0$ for every $i$.*

Pair ($\ast$) with $H_j$ in the trace inner product. The left side gives $\lambda_j\tau_j$ by orthonormality, and the right gives $\kappa\mathop{\mathrm{tr}}H_j=\kappa\tau_j$. So

$$\lambda_j\tau_j=\kappa\tau_j\quad\text{for }j=1,2,3. \tag{8.1}$$

Suppose $\kappa\neq0$. The left side of ($\ast$) lies in $U$, so $\kappa I\in U$, so $I\in U$, so the orthogonal projection of $I$ into $U$ is $I$ itself and $\sum_j\tau_j^2=\lVert I\rVert^2=\mathop{\mathrm{tr}}(I^2)=3$. By (8.1), $\lambda_j=\kappa$ for every $j$ with $\tau_j\neq0$, so

$$\kappa=\tfrac12\sum_i\lambda_i\tau_i^2=\tfrac12\sum_{\tau_i\neq0}\kappa\,\tau_i^2=\tfrac{\kappa}{2}\sum_i\tau_i^2=\tfrac{3\kappa}{2},$$

whence $\kappa=0$, a contradiction. So $\kappa=0$, and then (8.1) reads $\lambda_j\tau_j=0$ with every $\lambda_j\neq0$, giving $\tau_j=0$. $\square$

The proof uses orthonormality twice, once for the pairing and once through $\mathop{\mathrm{tr}}H_i^2=1$ in $\sigma_2$, and it uses $\lVert I\rVert^2=3$, which is where the complex dimension being $3$ enters.

### 8.3 Lemma U2: on $\mathfrak{su}(3)$, Ricci forces equal squares

*Assume in addition $\tau_i=0$. Then $H_1^2=H_2^2=H_3^2$.*

Write $Y_i=(H_i^2)_0=H_i^2-\tfrac13I$, using $\mathop{\mathrm{tr}}H_i^2=1$. Ricci gives $\sum_i\lambda_iY_i=-\tfrac13(\sum_i\lambda_i)I=0$.

**Every $Y_i$ has the same length.** For a traceless hermitian $3\times3$ matrix with $\mathop{\mathrm{tr}}H^2=1$, the eigenvalues satisfy $p_1=0$ and $p_2=1$, so $e_1=0$ and $e_2=-\tfrac12$, and Newton's identity $p_4=e_1p_3-e_2p_2+e_3p_1$ gives $\mathop{\mathrm{tr}}H^4=p_4=\tfrac12$. Hence

$$\lVert Y_i\rVert^2=\mathop{\mathrm{tr}}\big(H_i^2-\tfrac13I\big)^2=\mathop{\mathrm{tr}}H_i^4-\tfrac23\mathop{\mathrm{tr}}H_i^2+\tfrac13=\tfrac12-\tfrac23+\tfrac13=\tfrac16 .$$

Two checks by hand: $H=\tfrac1{\sqrt6}\mathop{\mathrm{diag}}(1,1,-2)$ gives $Y=\tfrac16\mathop{\mathrm{diag}}(-1,-1,2)$ of squared length $6/36$, and $H=\tfrac1{\sqrt2}\mathop{\mathrm{diag}}(1,-1,0)$ gives $Y=\tfrac16\mathop{\mathrm{diag}}(1,1,-2)$, the same.

**Equal lengths plus the relation forces equality.** From $\sum_i\lambda_iY_i=0$ and $\lambda_3=-\lambda_1-\lambda_2$, $\ \lambda_1(Y_1-Y_3)+\lambda_2(Y_2-Y_3)=0$ with $\lambda_1,\lambda_2\neq0$, so $Y_1-Y_3$ and $Y_2-Y_3$ are parallel and $Y_1,Y_2,Y_3$ are collinear. A line meets the sphere of radius $1/\sqrt6$ in at most two points, so at most two distinct values occur. If exactly two occur, say $Y_i=y$ for $i\in S$ and $y'\neq y$ otherwise, then $\big(\sum_{S}\lambda_i\big)y+\big(\sum_{S^c}\lambda_i\big)y'=0$ with the two coefficients summing to zero, so $\big(\sum_S\lambda_i\big)(y-y')=0$ and $\sum_S\lambda_i=0$: with $\lvert S\rvert=1$ that is $\lambda_i=0$ and with $\lvert S\rvert=2$ it makes the third weight zero, both excluded. So all three $Y_i$ coincide, and adding $\tfrac13I$ gives $H_1^2=H_2^2=H_3^2$. $\square$

The identity $\mathop{\mathrm{tr}}H^4=\tfrac12(\mathop{\mathrm{tr}}H^2)^2$ for traceless $H$ is special to $3\times3$, and it is the second place the complex dimension enters. Note also what the lemma does **not** need: it is independent of the weights beyond $\sum\lambda_i=0$ and $\lambda_i\neq0$, and it never touches Bianchi.

### 8.4 Lemma U3: equal squares classify the triple

*Let $H_1,H_2,H_3$ be traceless hermitian, orthonormal, with $H_1^2=H_2^2=H_3^2=:K$. Then, in a suitable unitary basis, $H_i=\tfrac1{\sqrt2}\sigma(n_i)\oplus0$ for an orthonormal basis $n_1,n_2,n_3$ of $\mathbb R^3$, where $\sigma(n)$ is the traceless hermitian involution $n\cdot\sigma$ of $\mathbb C^2$.*

$K$ is positive semidefinite with $\mathop{\mathrm{tr}}K=1$, and each $H_i$ commutes with $K=H_i^2$, hence preserves each eigenspace of $K$. Take the eigenvalue multiplicities in turn.

- **Three distinct eigenvalues.** Every $H_i$ is diagonal in $K$'s eigenbasis and traceless, and the traceless diagonal hermitian matrices form a $2$-dimensional real space, which cannot contain three orthonormal vectors. Impossible.
- **$K=\tfrac13I$.** Then $H_i=\tfrac1{\sqrt3}S_i$ with $S_i^2=I$ hermitian, so $S_i$ has eigenvalues $\pm1$ on $\mathbb C^3$ and $\mathop{\mathrm{tr}}S_i\in\{\pm3,\pm1\}$, never $0$. Impossible, and this is the third and last use of the complex dimension being odd.
- **Eigenvalues $(k,k,k')$ with $k\neq k'$**, with eigenspaces $W$ of complex dimension $2$ and $L$ of complex dimension $1$. Each $H_i$ acts on $L$ by $\pm\sqrt{k'}$ and on $W$ by $\sqrt k\,S_i$ with $S_i$ a hermitian involution of $W$, so $S_i=\pm I_W$ or $\mathop{\mathrm{tr}}S_i=0$. If $k=0$ then $H_i=0\oplus(\pm\sqrt{k'})$ spans a real line and three orthonormal vectors do not fit, so $k>0$. If some $S_i$ is traceless then $\mathop{\mathrm{tr}}H_i=\pm\sqrt{k'}=0$, so $k'=0$, and then for any $j$ with $S_j=\pm I_W$ we would need $\mathop{\mathrm{tr}}H_j=\pm2\sqrt k=0$, impossible, so **every** $S_i$ is traceless. Otherwise every $S_i=\pm I_W$ and $\mathop{\mathrm{tr}}H_i=\pm2\sqrt k\pm\sqrt{k'}=0$ forces $k'=4k$ and $H_i=\pm\sqrt k\mathop{\mathrm{diag}}(1,1,-2)$, again a single real line and no room for three. So $k'=0$, $\mathop{\mathrm{tr}}K=2k=1$, $k=\tfrac12$, and $H_i=\tfrac1{\sqrt2}\sigma(n_i)\oplus0$ with $\lvert n_i\rvert=1$.

Finally $\mathop{\mathrm{tr}}(H_iH_j)=\tfrac12\mathop{\mathrm{tr}}\big(\sigma(n_i)\sigma(n_j)\big)=n_i\cdot n_j$, so orthonormality of the triple is orthonormality of the $n_i$. $\square$

### 8.5 What the three lemmas give

$U=\mathop{\mathrm{span}}\{i\sigma(n_i)\oplus0\}=i\,\mathfrak{su}(W)$, three orthonormal forms all annihilating the real $2$-plane underlying $L$. So the support is the real $4$-plane $P$ underlying $W$, $\dim V=4$, and $U$ is one chirality $\Lambda^{\pm}P$: each $\omega_i$ squares to $-\tfrac12\Pi_P$ and the three span an $\mathfrak{su}(2)$. **This is the padded family**, and by r826 §1 its centraliser is $\Lambda^{\mp}P\oplus\Lambda^2P^\perp$ of dimension $4$.

**Consistency, in both directions.** The padded family does satisfy everything: $\omega_i^2=-\tfrac12\Pi_P$ gives $\sum_i\lambda_i\omega_i^2=-\tfrac12(\sum_i\lambda_i)\Pi_P=0$, and $\omega_i\wedge\omega_i$ is the same multiple of $\mathrm{vol}_P$ for each $i$, so Bianchi is $\sum_i\lambda_i=0$. In the $\mathfrak u(3)$ language, $\tau_i=0$, $Y_i=\tfrac16\mathop{\mathrm{diag}}(1,1,-2)$ for all three, of squared length $\tfrac16$ as Lemma U2 requires, and $\mathop{\mathrm{adj}}(H_i)=\mathop{\mathrm{diag}}(0,0,-\tfrac12)$ for all three, so Bianchi is again $\sum_i\lambda_i=0$. **The derivation therefore lands exactly on the record's known family rather than emptying the case**, which is the outcome a correct argument must have.

**Conclusion of item 7.** *Every rank-three triple with $U\subseteq\mathfrak u(3)$ is the padded family on a $J$-complex $4$-plane, and has $\dim\mathfrak z(U)=4$.* In particular the fourth bullet of §6 closes exactly like the other three, with the value $4$ rather than $1$, and **there is no triple with $\dim\mathfrak z(U)=1$**. With the brief's two givens, a solution at $\dim V=6$ has $\mathfrak z(U)=0$, full stop.

**Argue the opposite.** The strongest case for the $\mathfrak u(3)$ stratum being inhabited at $\dim\mathfrak z(U)=1$ is that $\mathfrak u(3)$ is $9$-dimensional and rich in irreducibly-acting $3$-planes, so a dimension count leaves plenty of room. The count is right and the room is closed by the equations rather than by dimensions. The sharpest test I could put to my own argument is the pair $H_1=\tfrac1{\sqrt6}\mathop{\mathrm{diag}}(1,1,-2)$ and $H_2=\tfrac1{\sqrt2}\sigma(n)\oplus0$, which are orthonormal, traceless and satisfy $H_1^2+H_2^2=\tfrac23I$, so that with $H_3=I/\sqrt3$ and $\lambda=(1,1,-2)$ they satisfy **Ricci exactly**: $\lambda_1H_1^2+\lambda_2H_2^2+\lambda_3H_3^2=\tfrac23I-\tfrac23I=0$. That triple has $\dim\mathfrak z(U)=3$ and would refute the brief's first given if it were a solution. It fails Bianchi: $\mathop{\mathrm{adj}}(H_1)=\mathop{\mathrm{diag}}(-\tfrac13,-\tfrac13,\tfrac16)$, $\mathop{\mathrm{adj}}(H_2)=\mathop{\mathrm{diag}}(0,0,-\tfrac12)$, $\mathop{\mathrm{adj}}(I/\sqrt3)=\tfrac13I$, and the weighted sum is $-I\neq0$, exactly as Lemma U1 predicts, since this triple has $I\in U$. **So the trace-free reduction is not decoration: it is the step that kills the only near miss I could build.**

## 9. Item 8: falsifiers, and what I did to look for them

| Claim I record | What would falsify it | What I did |
|---|---|---|
| §6's enumeration is exhaustive | An $X$ whose centraliser is none of the four shapes, most plausibly at a degenerate spectrum | Re-derived the centraliser from the skew normal form as $\mathfrak{so}(\ker X)\oplus\bigoplus_c\mathfrak u(V_c)$, tabulated all seven patterns, and checked the three dimension-$5$ rows are one conjugacy class |
| The $\mathfrak t^3$ and $\mathfrak k$ bullets | A hidden use of $\dim\mathfrak z(U)=2$ inside §5, which would make the $\mathfrak k$ bullet circular | Read §5.1 to §5.5 for the hypothesis and found it in §5.5 alone, in the reduction, which the dimension-one case supplies for itself by $U\subseteq\mathfrak z(\mathfrak z(U))$ |
| The seven-dimensional bullet | A dropped Ricci or Bianchi block, a non-exhaustive rank split, or an application of §5.4's lemma to objects it does not cover | Recomputed all three Ricci blocks and all three Bianchi blocks by hand, found the same list plus one redundancy; checked $\min(\mathop{\mathrm{rank}}\mathcal U,\mathop{\mathrm{rank}}\mathcal V)\le1$; checked the lemma's inputs one by one at the objects of the rank-one branch |
| **A triple with $\dim\mathfrak z(U)=1$ whose centre is not $\mathbb RJ$** | Such a triple in $\mathfrak t^3$, $\mathfrak k$ or $\Lambda^2Q\oplus\Lambda^2Q^\perp$ | It would have to break one of the three re-derivations above, since each ends at $\dim\mathfrak z(U)\in\{3,4\}$ with no free parameters left. None of the three has a branch that survives, and §8 removes the remaining shape as well, so the falsifier does not exist rather than merely not having been found |
| **Lemma U1**, the trace-free reduction | A triple with some $\tau_i\neq0$ satisfying Ricci and Bianchi | Built the sharpest candidate I could, $I/\sqrt3$ together with $\tfrac1{\sqrt6}\mathop{\mathrm{diag}}(1,1,-2)$ and a Pauli block, which satisfies Ricci exactly, and computed its adjugates: Bianchi fails by $-I$ |
| **Lemma U2**, equal squares | A unit trace-free hermitian $H$ with $\lVert(H^2)_0\rVert^2\neq\tfrac16$, which would break the sphere argument | Proved $\mathop{\mathrm{tr}}H^4=\tfrac12$ from Newton's identities at $e_1=0$, $e_2=-\tfrac12$, and checked the value at two explicit $H$ with different spectra |
| **Lemma U3**, the classification | An eigenvalue multiplicity of $K$ I did not treat, or a hermitian involution I dismissed too quickly | Took the three multiplicity patterns in turn, and in each the obstruction is that traceless matrices commuting with $K$ span too small a space to hold three orthonormal ones |

**Computation.** *None was run. The analysis-only rule was in force, the screening allowance was available and unused, and every trace, eigenvalue and dimension above was worked by hand. The two numerical spot-checks in §8.3 and the counterexample in §8.5 are exact rational arithmetic done in the text.*

## 10. Protocol

- **Located exactly.** The one defect I record is in [r826](REVIEW_r826.md) §6, third bullet, rank-one sentence, quoted in §5.4 above, together with the same bullet's avoidable appeal to [r824](REVIEW_r824.md) §7 and the same bullet's unstated exhaustiveness argument; and one clause of the second bullet, *"§5 applies verbatim"*, which is true of §5.1 to §5.4 and false of §5.5.
- **Exhibited concretely.** §5.4 gives the transposition in closed form and says which positivity it costs. §5.3 gives the replacement for the [r824](REVIEW_r824.md) §7 appeal in full. §8.5 exhibits the near-miss triple that satisfies Ricci and fails Bianchi by $-I$.
- **Argued the opposite.** §2, §5.4, §7 and §8.5 each carry the most charitable reading. In §5.4 the charitable reading is correct mathematics and the defect is demoted to the write-up. In §7 the charitable reading of the final sentence is the one under which it is earned.
- **Nothing withdrawn.** No candidate discrepancy failed the three tests, and none was dropped for lack of a concrete exhibit.

## 11. Verdict

**§6 is CONFIRMED as far as it goes, and its open case closes.**

1. **The three disposed bullets stand**, each re-derived here independently: $\mathfrak t^3$ by a dimension count, $\mathfrak k$ by §5.1 to §5.4 with a substitute reduction, and the seven-dimensional shape by a block computation, a rank-nullity bound and two applications of §5.4's lemma.
2. **Two write-up repairs are owed before §6 is recorded**: replace *"§5 applies verbatim"* with the clause naming $U\subseteq\mathfrak z(\mathfrak z(U))$ and the conjugacy of five-dimensional centralisers, and fix the transposed $\mathcal V$ in the rank-one sentence. A third is optional and worth taking: the $\mathop{\mathrm{rank}}\mathcal U=0$ branch closes by §5.4's own lemma, so the appeal to [r824](REVIEW_r824.md) §7 can go.
3. **The $\mathfrak u(3)$ case is empty of anything new.** Bianchi forces the triple into $\mathfrak{su}(3)$, Ricci then forces the three squares to be equal, and equal squares classify the triple as the padded family with $\dim\mathfrak z(U)=4$.
4. **Therefore no triple has $\dim\mathfrak z(U)=1$**, and §6's conclusion should be recorded in the stronger form: *with $\dim\mathfrak z(U)\ge3$ and $\dim\mathfrak z(U)=2$ excluded by the givens, a solution at $\dim V=6$ has $\mathfrak z(U)=0$.* This strengthening is my own derivation under a Gate 2 brief and has had no independent audit. The three lemmas of §8 are where a second reviewer should aim, and Lemma U2's constant $\lVert(H^2)_0\rVert^2=\tfrac16$ is the single step everything downstream rests on.

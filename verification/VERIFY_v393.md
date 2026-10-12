# Verifier v393, adjudication of step H3 in round L64-r2

Cold brief ([ADJ_L64r2_H3.md](ADJ_L64r2_H3.md)) plus the imported source [paper.pdf](https://arxiv.org/abs/2307.04230) and its extraction [txt.txt](https://arxiv.org/abs/2307.04230), read at Definition 2.4 to Theorem 2.11, the induced-representation paragraph (lines 795-820) and Lemmas A.8 to Theorem A.13. No numerical work: every value below is exact and derived by hand, and no script was written or run. Log: [agent_logs/verify-L64-v393.log](../agent_logs/verify-L64-v393.log).

| # | Claim in Passage C | Verdict |
|---|---|---|
| C1 | The kernel clause needs the adjoint to be a morphism, which is equivalent to $\mathrm{Ric}$ commuting with truncation | VALID |
| C2 | $\mathrm{Ric}$ does not commute with truncation | VALID |
| C3 | The Ricci part is padding-closed only for $h\propto I$, and the round sphere is exactly that exception | VALID at one padding step, $n_0\ge3$ |
| C4 | The sums clause needs the Ricci part padding-closed | VALID AS A CONDITION, MISATTRIBUTED: it is the hypothesis of the images clause applied to the orthogonal projection onto $\mathcal W$ |
| C5 | Hence Theorem 2.11's calculus yields no $k_B$ for $\{\mathrm{Sym}^d\mathcal W_n^*\}$ at all | VALID, HYPOTHESES CORRECTED: the two reasons close two routes, and the universal claim needs Lemma T below, which generalises reason C1 from $\mathrm{Ric}$ to every morphism |

**Summary: both reasons are correct and C1 names the right obstruction, but they close only the kernel-of-Ricci and Ricci-splitting routes, and the universal "at all" holds once C1's truncation criterion is lifted to an invariant (commuting support projections) that every module the calculus produces carries and that $\mathrm{Sym}^d\mathcal W^*$ violates at $n=5$ for every $d\ge1$, with the sums reason reassigned to the images clause.**

## 0. Conventions, fixed once

Quoted from the brief.

- "$\mathcal W_n$ is the space of algebraic Weyl tensors on $\mathbb R^n$: 4-tensors with the curvature symmetries $W_{ijkl}=-W_{jikl}=-W_{ijlk}=W_{klij}$, the first Bianchi identity $W_{ijkl}+W_{iklj}+W_{iljk}=0$, and every Ricci contraction zero, with the Frobenius inner product. $\mathcal W_n=0$ for $n\le3$."
- "$O(n)$, and its subgroups $SO(n)$ and the signed permutation group $B_n$, act on $\mathcal W_n$ by $(g\cdot W)_{ijkl}=g_{ia}g_{jb}g_{kc}g_{ld}W_{abcd}$. Zero-padding sends $W\in\mathcal W_{n_0}$ to the tensor on $\mathbb R^n$ with the same components on indices in $[n_0]$ and zero elsewhere."
- "$\mathrm{Sym}^d\mathcal W_n^*$ is the space of homogeneous polynomials of degree $d$ on $\mathcal W_n$. $S^n$ is the space of real symmetric $n\times n$ matrices."
- From Passage A's setting: "Zero-padding embeds $\mathcal W_{n_0}$ isometrically in $\mathcal W_n$ and makes $\{\mathrm{Sym}^d\mathcal W_n^*\}$ a module over the base $\{\mathbb R^n\}$ with the group sequence $\{B_n\}$ of signed permutations. $k_B(d)$ is that module's presentation degree."

Notation added here. $\mathcal K_n$ is the space of algebraic curvature tensors (curvature symmetries and Bianchi, no trace condition). $\mathrm{Ric}(R)_{jl}=\sum_iR_{ijil}$. For $h,k\in S^n$, $(h\owedge k)_{ijkl}=h_{ik}k_{jl}+h_{jl}k_{ik}-h_{il}k_{jk}-h_{jk}k_{il}$. For a consistent sequence $U$ with inclusions $\iota:U_n\to U_{n+1}$, truncation is $P=\iota^*$, the orthogonal projection of $U_{n+1}$ onto $U_n$.

## 1. Hypothesis inventory

- **(H1) Base modules.** The calculus starts from modules whose presentation degree the source supplies: $\{\mathbb R^n\}$ (Example 2.8), $\{(\mathbb R^n)^{\otimes k}\}$ and $\{\mathrm{Sym}^k\mathbb R^n\}$ (Example 2.12), and algebraically free sequences, which are sums of induction sequences (Definition 2.6, presented in their generation degree by Definition 2.7 with zero kernel). Checked against the source: these are the modules it presents directly.
- **(H2) What "yields" means.** A presentation degree is yielded for $\{\mathrm{Sym}^d\mathcal W_n^*\}$ when that sequence is, up to an isometric isomorphism of consistent sequences, one of the sequences the four clauses of Theorem 2.11 (equivalently Theorem A.13) output. Checked: the clauses state degrees for $W\oplus U$, $\mathrm{im}\,A$, $\ker A$, $W\otimes U$ and Schur functors of $W$, each carrying the inner product and embeddings inherited from its construction.
- **(H3) The dual module.** $\mathrm{Sym}^d\mathcal W_n^*$ is identified with $\mathrm{Sym}^d\mathcal W_n\subseteq\mathcal W_n^{\otimes d}$ by the Frobenius inner product, with embedding $F\mapsto F\circ P$ corresponding to $\iota^{\otimes d}$ and truncation $P^{\otimes d}$. Checked: this is the structure under which the Schur-functor clause is stated (proof of Corollary A.12).
- **(H4) Padding closure is a one-step condition, $n_0\ge3$.** Definition 1.3 asks for $\varphi_n:V_n\to V_{n+1}$ at each $n$. Checked: C3 is exact in this form, §2.3.
- **(H5) $d\ge1$.** Needed so that $\mathrm{Sym}^d$ of the zero space is zero. Checked: the step fixes $d\ge1$.

## 2. The argument

### 2.1 C1: the kernel clause and truncation

The route is $\mathcal W=\ker\mathrm{Ric}$ with $\mathrm{Ric}:\mathcal K\to S$. Both $\{\mathcal K_n\}$ and $\{S^n\}$ are submodules of tensor sequences cut out by index permutations, so their degrees come from Example 2.12 and Proposition A.11. $\mathrm{Ric}$ is $B_n$-equivariant and commutes with padding, because every term of $\sum_iR_{ijil}$ with $i>n_0$ vanishes on a padded tensor. So $\mathrm{Ric}$ is a morphism (Definition 2.1). Theorem A.13 requires $\mathrm{Ric}^*$ to be a morphism as well. The condition $\mathrm{Ric}^*_{n+1}\iota_S=\iota_{\mathcal K}\mathrm{Ric}^*_n$ is, after taking adjoints of both sides, $P_S\,\mathrm{Ric}_{n+1}=\mathrm{Ric}_n\,P_{\mathcal K}$, which is commutation with truncation. The two conditions are adjoint to each other, so they are equivalent. **C1 VALID.**

For completeness, $\mathrm{Ric}^*$ is explicit. Expanding $\langle R,h\owedge I\rangle$ term by term with the curvature symmetries gives four copies of $\langle\mathrm{Ric}\,R,h\rangle$, so $\mathrm{Ric}^*h=\tfrac14\,h\owedge I_n$, and the orthogonal complement of $\mathcal W_n$ in $\mathcal K_n$ is $\mathcal R_n=\{h\owedge I_n:h\in S^n\}$.

### 2.2 C2: $\mathrm{Ric}$ fails to commute with truncation

For a symmetric array $K_{ij}$ ($i\ne j$) set $R_{ijkl}=K_{ij}(\delta_{ik}\delta_{jl}-\delta_{il}\delta_{jk})$. It has the curvature symmetries, since a nonzero component needs $\{k,l\}=\{i,j\}$. Bianchi holds: with $(k,l)=(i,j)$ the three terms are $K_{ij}+0-K_{ij}=0$, with $(k,l)=(j,i)$ they are $-K_{ij}+K_{ij}+0=0$, and the other cases follow by the cyclic symmetry of the identity. Its Ricci tensor is $\mathrm{Ric}_{jl}=\delta_{jl}\sum_{i\ne j}K_{ij}$. Its inner product with $R'$ built from $K'$ is $\langle R,R'\rangle=4\sum_{i<j}K_{ij}K'_{ij}$.

Take $K_{1,n+1}=1$ and every other entry zero, on $\mathbb R^{n+1}$. Then $\mathrm{Ric}_{n+1}(R)=E_{11}+E_{n+1,n+1}$, whose truncation to $[n]$ is $E_{11}$. The truncation of $R$ to $[n]$ has every $K$ entry zero, so $\mathrm{Ric}_n(P_{\mathcal K}R)=0$. Hence $P_S\,\mathrm{Ric}_{n+1}(R)=E_{11}\ne0=\mathrm{Ric}_n(P_{\mathcal K}R)$. **C2 VALID.**

### 2.3 C3: padding closure of the Ricci part

Let $m\ge3$, $h\in S^m$, and suppose the padding of $h\owedge I_m$ equals $h'\owedge I_{m+1}$ for some $h'\in S^{m+1}$. Write $c=h'_{m+1,m+1}$.

- Components $(i,m+1,k,m+1)$ with $i,k\le m$: the padded side is $0$ and the other is $h'_{ik}+c\,\delta_{ik}$. So $h'|_{[m]}=-cI_m$.
- Components $(i,j,k,m+1)$ with $i,j,k\le m$: the other side is $h'_{j,m+1}\delta_{ik}-h'_{i,m+1}\delta_{jk}$. Taking $i=k\ne j$ gives $h'_{j,m+1}=0$. So $h'=\mathrm{diag}(-cI_m,c)$.
- Components in $[m]$: $(h+cI_m)\owedge I_m=0$. Since $\mathrm{Ric}(g\owedge I_m)=(m-2)g+(\mathrm{tr}\,g)I_m$, whose trace is $(2m-2)\,\mathrm{tr}\,g$, the map $g\mapsto g\owedge I_m$ is injective for $m\ge3$. So $h=-cI_m$.

Conversely $h=-cI_m$ with $h'=\mathrm{diag}(-cI_m,c)$ matches on every component type: all indices in $[m]$ by construction, two indices $m+1$ in positions 2 and 4 by $-c\delta_{ik}+c\delta_{ik}=0$, one index $m+1$ because $h'$ is diagonal, and two indices $m+1$ in one antisymmetric pair trivially. So $\iota(\mathcal R_m)\cap\mathcal R_{m+1}=\iota\{cI_m\owedge I_m\}$, a line inside the $\tfrac{m(m+1)}2$-dimensional $\mathcal R_m$, and $\{\mathcal R_n\}$ is not padding-closed. The round sphere's curvature tensor $\tfrac12I\owedge I$ lies on that line, so a padding test run on $S^{n_0}$ passes although the sequence fails. **C3 VALID** in the one-step form (H4) with $m\ge3$. At two steps even the line fails, because the one-step image $\mathrm{diag}(-cI_m,c)$ is proportional to $I_{m+1}$ only when $c=0$.

### 2.4 C4: which clause the condition belongs to

The Sums clause takes two modules and returns the degree of their sum. Applied to $\mathcal K=\mathcal W\oplus\mathcal R$ it needs $\mathcal R$ to be a consistent sequence, which C3 refutes, so the stated condition is a genuine hypothesis of that application. But the output of Sums is $k_{\mathcal K}$ from $k_{\mathcal W}$ and $k_{\mathcal R}$, so Sums never returns the degree of a summand, whatever its hypotheses. The route that would return $k_{\mathcal W}$ from the splitting is the Images clause on the orthogonal projection $\pi_{\mathcal W}:\mathcal K\to\mathcal K$, which is self-adjoint. It is a morphism exactly when $\{\mathcal R_n\}$ is padding-closed: if $\pi_{\mathcal W}\iota=\iota\pi_{\mathcal W}$ then $r\in\mathcal R_m$ gives $\pi_{\mathcal W}\iota r=0$, so $\iota r\in\mathcal R_{m+1}$, and the converse holds because $\mathcal W$ is padding-closed. A projection onto $\mathcal W$ along any other complement $X$ has adjoint the projection along $\mathcal R$, so the same condition reappears. **C4 VALID AS A CONDITION, MISATTRIBUTED**: the reason blocks the splitting route once "sums clause" is read as "images clause on the projection".

### 2.5 C5: the universal claim

**What the reasons cover.** C1 and C2 close $\mathcal W=\ker\mathrm{Ric}$ (and equally $\mathcal W$ as the kernel of the full trace map on $(\mathbb R^n)^{\otimes4}$, which fails truncation by the same tensor). C3 and C4 close $\mathcal W$ as a complement of the Ricci part. Neither reason addresses $\mathcal W$ as the kernel or image of some other morphism, nor $\{\mathrm{Sym}^d\mathcal W_n^*\}$ reached directly as the image of a morphism out of a module of known degree, which the Images clause allows since it needs a degree only for the domain. So the passage from the two reasons to "at all" needs a further lemma. It is supplied here, and it is C1's truncation criterion stated for every morphism at once.

**Support projections.** Let $U$ be a $V$-module with $V=\{\mathbb R^n\}$, $G_n=B_n$. For $S\subseteq[n]$ with $|S|=m$ choose a permutation $\sigma\in S_n\subseteq B_n$ with $\sigma([m])=S$ and set $U_S=\sigma U_m$ and $Q_S=\sigma\,\iota^{n-m}P^{n-m}\sigma^{-1}$, the orthogonal projection of $U_n$ onto $U_S$. Two choices of $\sigma$ differ by a permutation of $[m]$, which preserves $U_m$, times a permutation of $[n]\setminus[m]$, which lies in $H_{n,m}$ and fixes $U_m$ pointwise because $U$ is a $V$-module (Definition 2.5). So $U_S$ and $Q_S$ are well defined.

**Property (L).** $Q_SQ_{S'}=Q_{S\cap S'}$ for all $n$ and all $S,S'\subseteq[n]$.

**Lemma T.** Every module whose presentation degree Theorem 2.11 yields from the base modules (H1) satisfies (L).

*Proof.* Induction on the derivation.

- *Base.* On $\mathbb R^n$, $Q_S$ is the coordinate projection onto $\mathrm{span}\{e_i:i\in S\}$, and (L) holds. On $(\mathbb R^n)^{\otimes k}$, $Q_S=(Q_S^{\mathbb R^n})^{\otimes k}$ keeps the components whose indices all lie in $S$, and (L) holds. $\mathrm{Sym}^k\mathbb R^n$ is invariant under these operators and inherits (L). An induction sequence $\mathrm{Ind}^{B_n}_{B_dH_{n,d}}\mathsf W$ is, by the source's (Ind) paragraph, the orthogonal sum $\bigoplus_ig_i\mathsf W$ over cosets, with the inclusion given by completing coset representatives. The cosets of $B_dH_{n,d}=B_d\times B_{n-d}$ in $B_n$ are indexed by the $d$-subsets $T=g([d])$ of $[n]$, the inclusion adds the summands with $T\not\subseteq[n]$, and $Q_S$ keeps the summands with $T\subseteq S$. So (L) holds, and sums of such sequences inherit it.
- *Sums.* $Q_S^{W\oplus U}=Q_S^W\oplus Q_S^U$.
- *Tensors and Schur functors.* The embedding of $W\otimes U$ is $\iota\otimes\iota$, its truncation is $P\otimes P$ and $\sigma$ acts diagonally, so $Q_S^{W\otimes U}=Q_S^W\otimes Q_S^U$ and (L) holds. A Schur functor is the image of a Young symmetriser in $R[S_\ell]$, which commutes with $(Q_S)^{\otimes\ell}$, so it inherits (L).
- *Images and kernels.* Let $A:X\to U$ with $A$ and $A^*$ morphisms and $X$ satisfying (L). Taking adjoints in $A^*\iota=\iota A^*$ gives $PA=AP$, and $A$ also commutes with $\iota$ and with $\sigma$, so $Q_S^UA=AQ_S^X$. For $\ker A$: $P(\ker A_{n+1})\subseteq\ker A_n$, so the orthogonal projection of $\ker A_{n+1}$ onto $\ker A_n$ is the restriction of $P$ (for $x\in\ker A_{n+1}$, $Px\in\ker A_n$ and $x-Px\perp X_n\supseteq\ker A_n$), hence $Q_S^{\ker A}=Q_S^X|_{\ker A}$ and (L) restricts. For $\mathrm{im}\,A$: $P(A_{n+1}x)=A_nPx\in\mathrm{im}\,A_n$, so by the same argument $Q^{\mathrm{im}A}_S=Q^U_S|_{\mathrm{im}A}$, and $Q_SQ_{S'}Ax=AQ_SQ_{S'}x=AQ_{S\cap S'}x=Q_{S\cap S'}Ax$.
- *Isometric isomorphism (H2).* An isometric isomorphism $J$ of consistent sequences has $J^*=J^{-1}$ a morphism, so $J$ commutes with truncation and transports (L). $\square$

**Lemma W.** $\{\mathrm{Sym}^d\mathcal W_n^*\}$ violates (L) at $n=5$ for every $d\ge1$.

*Proof.* Use the array family of §2.2 on $\mathbb R^5$, where $R\in\mathcal W_5$ exactly when every row sum $\sum_{i\ne j}K_{ij}$ vanishes.

- $w$: $K_{12}=K_{34}=-1$, $K_{23}=K_{14}=1$, $K_{13}=K_{24}=0$, every entry involving $5$ zero. Row sums: $-1+0+1$, $-1+1+0$, $0+1-1$, $1+0-1$, $0$. So $w\in\mathcal W_5$, supported in $S=\{1,2,3,4\}$, hence $w\in(\mathcal W)_S$.
- $w'$: $K'_{23}=K'_{45}=1$, $K'_{24}=K'_{35}=0$, $K'_{25}=K'_{34}=-1$, every entry involving $1$ zero. Row sums: $1+0-1$, $1-1+0$, $0-1+1$, $-1+0+1$, $0$. So $w'\in(\mathcal W)_{S'}$ with $S'=\{2,3,4,5\}$.
- $\langle w,w'\rangle=4\big(K_{23}K'_{23}+K_{24}K'_{24}+K_{34}K'_{34}\big)=4(1+0+1)=8$, the only shared pairs lying in $\{2,3,4\}$.
- $S\cap S'=\{2,3,4\}$, so $(\mathcal W)_{S\cap S'}\cong\mathcal W_3=0$ and $Q^{\mathcal W}_{S\cap S'}=0$.

By (H3), $Q_S$ on $\mathrm{Sym}^d\mathcal W_5$ is $(Q^{\mathcal W}_S)^{\otimes d}$. Then $Q_{S\cap S'}=0$, while $Q_SQ_{S'}(w'^{\otimes d})=(Q^{\mathcal W}_Sw')^{\otimes d}$, which is nonzero because $\langle Q^{\mathcal W}_Sw',w\rangle=\langle w',w\rangle=8$. $\square$

Lemmas T and W together give C5 under (H1)-(H5): no derivation in Theorem 2.11's calculus outputs $\{\mathrm{Sym}^d\mathcal W_n^*\}$, for any $d\ge1$. The case $d=1$ also survives identifications that are merely isomorphisms of sequences, since pairwise-annihilating idempotents onto the five translates $(\mathcal W)_S$, $|S|=4$, would make those translates independent, giving $5\cdot\dim\mathcal W_4=50\le\dim\mathcal W_5=35$, which is false ($\dim\mathcal W_n=n(n+1)(n+2)(n-3)/12$). For $d\ge2$ a non-isometric identification is outside the reading, and it is also outside Theorem 2.11, whose clauses state degrees for the sequences they construct.

### 2.6 Strongest reading and defence

The strongest reading takes C1 as the operative reason: every clause that carves a submodule out of the tensors is the images-and-kernels clause, it demands truncation compatibility, and the Weyl condition is incompatible with truncation. Lemma T is that reading made exact, and C2's tensor is its simplest witness. Read this way the step is correct, and its conclusion is what Passage A's bullet cites ("Theorem 2.11's kernel and sums clauses do not apply to $\{\mathcal W_n\}$"). The corrections the reading needs are three. The universal quantifier rests on Lemma T, which Passage C does not state. The sums reason belongs to the images clause on the projection, since Sums cannot return a summand's degree. And C3 holds at one padding step with $n_0\ge3$.

Three checks for a FAILS were attempted and none clears. The only locatable gap is the passage from two routes to all routes, and the closed-form search for a third route ends in Lemma W, which blocks every route the calculus offers. No false statement appears in either reason. So the step is VALID with the hypotheses and the missing lemma recorded above.

**Verdict: VALID**

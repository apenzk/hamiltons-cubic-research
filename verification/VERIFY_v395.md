# Verifier v395, adjudication of step H4 in round L64-r2

Cold brief ([ADJ_L64r2_H4.md](ADJ_L64r2_H4.md)), read with the imported source [paper.pdf](https://arxiv.org/abs/2307.04230) and [txt.txt](https://arxiv.org/abs/2307.04230) only. No numerical work was done: every value is exact and derived by hand, and no script was written or run. Log: [agent_logs/verify-L64-v395.log](../agent_logs/verify-L64-v395.log).

| Claim | Verdict |
|---|---|
| C1. Zero-padding is a $B_n$-equivariant isometric embedding $\mathcal W_n\hookrightarrow\mathcal W_{n+1}$, and it induces a canonical consistent sequence $\{\mathrm{Sym}^d\mathcal W_n^*\}$ | HOLDS |
| C2. $\{\mathrm{Sym}^d\mathcal W_n^*\}$ is a module over the base $\{\mathbb R^n\}$ with $\{B_n\}$ (Definition 2.5) | HOLDS |
| C3. The module is finitely generated in the sense of Definition 2.2 | HOLDS, by Theorem A.5 (Noetherianity) of the source |
| C4. It is presented in some finite degree, so the minimum in Definition 2.7 exists and $k_B(d)\in\mathbb N$ for every $d\ge1$ | HOLDS |
| C5. "$n\ge n_0\ge k_B(d)$" is a definite condition at every $d\ge1$, and it is satisfiable | HOLDS |
| Step H4 as written | VALID |

**Summary: the module $\{\mathrm{Sym}^d\mathcal W_n^*\}$ is a submodule of the finitely generated $\{B_n\}$-module $\{(\mathbb R^n)^{\otimes4d}\}$, so the Noetherianity theorem the source imports (Theorem A.5, for $\mathrm{FI}_{BC}$) makes it finitely generated with finitely generated relations, the set of admissible presentation degrees in Definition 2.7 is a nonempty set of naturals, and $k_B(d)$ is a definite natural number at every $d\ge1$.**

## 0. Conventions, fixed once

Quoted from the brief:

- "$\mathcal W_n$ is the space of algebraic Weyl tensors on $\mathbb R^n$: 4-tensors with the curvature symmetries $W_{ijkl}=-W_{jikl}=-W_{ijlk}=W_{klij}$, the first Bianchi identity $W_{ijkl}+W_{iklj}+W_{iljk}=0$, and every Ricci contraction zero, with the Frobenius inner product. $\mathcal W_n=0$ for $n\le3$."
- "$O(n)$, and its subgroups $SO(n)$ and the signed permutation group $B_n$, act on $\mathcal W_n$ by $(g\cdot W)_{ijkl}=g_{ia}g_{jb}g_{kc}g_{ld}W_{abcd}$. Zero-padding sends $W\in\mathcal W_{n_0}$ to the tensor on $\mathbb R^n$ with the same components on indices in $[n_0]$ and zero elsewhere."
- "$\mathrm{Sym}^d\mathcal W_n^*$ is the space of homogeneous polynomials of degree $d$ on $\mathcal W_n$. $S^n$ is the space of real symmetric $n\times n$ matrices."
- "This loop does no numerical work. A claim supported only by a run is `HYPOTHESIS-DEBT`. Screening a claim by hand on an object you construct is allowed, and is reported as a screen, never as evidence for a positive claim."

The step under adjudication: "$k_B(d)$ is defined by the setting for every $d\ge1$, and part 2's hypothesis "$n\ge n_0\ge k_B(d)$" has a definite meaning as written, at every $d\ge1$."

Notation. The letter $d$ is the polynomial degree throughout. Generation and relation degrees of Definitions 2.2 and 2.7 are written $g$ and $r$. $B_n\subseteq B_{n+1}$ by $g\mapsto\mathrm{blkdiag}(g,1)$, as in Example 1.5 of the source. $H_{n,m}=\mathrm{blkdiag}(I_m,B_{n-m})$ is the centralizing subgroup of $\mathbb R^m$ in $B_n$ (Example 2.8).

## 1. Hypothesis inventory

The step needs the following, each checked in Section 2.

- **H-emb.** The embedding $\mathrm{Sym}^d\mathcal W_n^*\hookrightarrow\mathrm{Sym}^d\mathcal W_{n+1}^*$ that "zero-padding makes" is the canonical one, $p\mapsto p\circ P_n$ with $P_n$ the orthogonal projection $\mathcal W_{n+1}\to\mathcal W_n$. The setting leaves this implicit. It is the unique isometric embedding whose adjoint is restriction of polynomials, which is the map the lemma's proof step (iii) uses. Checked in 2.1.
- **H-seq.** The data form a consistent sequence (Definition 1.3): orthogonal $B_n$-representations, $B_n$-equivariant isometric inclusions, indexed by all $n\in\mathbb N$, with $U_n=0$ for $n\le3$. Checked in 2.1.
- **H-mod.** The module condition $U_m\subseteq U_n^{H_{n,m}}$ of Definition 2.5. Checked in 2.2.
- **H-fp.** Some finite $k$ satisfies Definition 2.7, so that "the smallest $k$" exists. This is the substantive hypothesis, since Definition 2.7 supplies no value when the set of admissible $k$ is empty. Checked in 2.3 to 2.5 from Theorem A.5 of the source.
- **H-inv.** The presentation degree is an invariant of the module up to isomorphism of sequences, so identifying $\mathrm{Sym}^d\mathcal W_n^*$ with $\mathrm{Sym}^d\mathcal W_n$ changes nothing. Checked in 2.1.

## 2. The argument

### 2.1 The consistent sequence (H-emb, H-seq, H-inv)

**Padding lands in $\mathcal W_{n+1}$.** Let $W\in\mathcal W_n$ and $W'$ its padding. The curvature symmetries and the Bianchi identity are componentwise linear identities among components with the same index multiset. On multi-indices inside $[n]$ they are those of $W$. On a multi-index containing $n+1$ every term is zero. Ricci: for $i,k\in[n]$, $\sum_{j\in[n+1]}W'_{ijkj}=\sum_{j\in[n]}W_{ijkj}+W'_{i,n+1,k,n+1}=0+0=0$, and if $i=n+1$ or $k=n+1$ every term vanishes. So $W'\in\mathcal W_{n+1}$.

**Isometry and equivariance.** $\lVert W'\rVert^2$ sums the same nonzero squares as $\lVert W\rVert^2$. For $g\in B_n$ and $g'=\mathrm{blkdiag}(g,1)$, $g'_{n+1,a}=\delta_{a,n+1}$ and $g'_{ia}=0$ for $i\le n<a$. So $(g'\cdot W')_{ijkl}$ is $(g\cdot W)_{ijkl}$ when all indices lie in $[n]$ and is $0$ otherwise. Padding is $B_n$-equivariant.

**The induced sequence.** Give $\mathrm{Sym}^d\mathcal W_n^*$ the inner product transported from $\mathrm{Sym}^d\mathcal W_n\subseteq\mathcal W_n^{\otimes d}$ by $p_S(W)=\langle S,W^{\otimes d}\rangle$, $S\in\mathrm{Sym}^d\mathcal W_n$. This identification is $B_n$-equivariant and isometric. Padding $S$ into $\mathrm{Sym}^d\mathcal W_{n+1}$ gives the polynomial $W\mapsto\langle S,W^{\otimes d}\rangle=\langle S,(P_nW)^{\otimes d}\rangle=p_S(P_nW)$, because $S\in\mathcal W_n^{\otimes d}$. So the embedding is $p\mapsto p\circ P_n$. It is isometric, and it is $B_n$-equivariant because $B_n$ acts orthogonally on $\mathcal W_{n+1}$ preserving $\mathcal W_n$, hence commutes with $P_n$. Its adjoint sends $q$ to $q|_{\mathcal W_n}$: both sides of $\langle p\circ P_n,q\rangle=\langle p,q|_{\mathcal W_n}\rangle$ read $\langle S,T|\rangle$ with $T|$ the component of $T$ in $\mathcal W_n^{\otimes d}$. This is the restriction used in part (iii) of the proof, which fixes H-emb. For $n\le3$, $\mathcal W_n=0$ and $\mathrm{Sym}^d(0)^*=0$ for $d\ge1$, which Definition 1.3 admits. So H-seq holds.

**Invariance.** An isomorphism of sequences $\Theta:U\to U'$ carries a surjective morphism $F\to U$ with kernel $K$ to $F\to U'$ with the same kernel $K$. So Definition 2.7 admits the same $k$ for $U$ and $U'$. Write $U=\{U_n\}=\{\mathrm{Sym}^d\mathcal W_n\}$ from here on, which is H-inv.

### 2.2 The module condition (H-mod)

Let $m\le n$ and $h=\mathrm{blkdiag}(I_m,h_0)\in H_{n,m}$. For $W$ supported on $[m]$, $h_{ia}W_{abcd}$ with $a\in[m]$ has $h_{ia}=\delta_{ia}$, so $h\cdot W=W$. Thus $h$ fixes $\mathcal W_m$ pointwise, fixes $\mathcal W_m^{\otimes d}$ pointwise, and fixes $U_m$ pointwise inside $U_n$. So $U_m\subseteq U_n^{H_{n,m}}$, and $U$ is a $\{\mathbb R^n\}$-module over $\{B_n\}$. This confirms the setting's "makes $\{\mathrm{Sym}^d\mathcal W_n^*\}$ a module over the base $\{\mathbb R^n\}$".

### 2.3 The imported theorem, and its range

The source, Appendix A:

- Definition A.2 and the paragraph after it: a $V$-module in the sense of Definition 2.5 is a $\mathcal C_V$-module and conversely, and morphisms of functors coincide with morphisms of sequences.
- Example A.3(b): for $V=\{\mathbb R^n\}$ with $G_n=B_n$, $\mathcal C_V$ is (the skeleton of) $\mathrm{FI}_{BC}$.
- Theorem A.5 (Noetherianity), for $\mathcal C=\mathrm{FI}_W$, which includes $\mathrm{FI}_{BC}$: "Any submodule of a finitely-generated $\mathcal C$-module is finitely-generated." Its proof cites Wilson [50, Thm. 4.21] for $\mathrm{FI}_{BC}$.

"Finitely-generated" is the source's Definition 2.2: generated in degree $g$ for some $g<\infty$. For a sequence of inclusions this coincides with categorical finite generation, because an element of $U_m$ with $m\le g$ already lies in $U_g$, and the image of $x\in U_m$ under a morphism $m\to n$ is $g\cdot x$ with $g\in B_n$. So a set of generators in degrees $\le g$ gives $R[B_n]U_g=U_n$ for $n\ge g$, and conversely $U_0,\dots,U_g$ generate categorically when $R[B_n]U_g=U_n$ for $n\ge g$.

### 2.4 Finite generation of $U$ (C3)

$T=\{(\mathbb R^n)^{\otimes4d}\}$ with padding and $B_n$ is generated in degree $4d$ and presented in degree $4d$ (Example 2.12 with $k=4d$, $G_n=B_n$). $U_n=\mathrm{Sym}^d\mathcal W_n\subseteq\mathcal W_n^{\otimes d}\subseteq(\mathbb R^n)^{\otimes4d}$ is $B_n$-stable, and by 2.1 the embedding $U_n\subseteq U_{n+1}$ is the restriction of padding $T_n\subseteq T_{n+1}$. So $U$ is a submodule of $T$. Theorem A.5 gives a finite $g$ with $R[B_n]U_g=U_n$ for all $n\ge g$. Passage A's lower bound makes $g\ge4d$, which is consistent and plays no role here.

### 2.5 A finite presentation (C4)

**Free cover.** For $0\le m\le g$, $H_{m,m}=\{g\in B_m:g\text{ fixes }\mathbb R^m\}=\{I\}$ acts trivially on $U_m$, so Definition 2.6(a) gives the induction sequence $\mathrm{Ind}_{B_m}(U_m)=\{\mathrm{Ind}^{B_n}_{B_mH_{n,m}}U_m\}_n$, a $V$-module. Set $F=\bigoplus_{m=0}^{g}\mathrm{Ind}_{B_m}(U_m)$, algebraically free by Definition 2.6(b). Define $\beta_n$ on the $m$-th summand by $[x\otimes u]\mapsto x\cdot u$ for $x\in B_n$, $u\in U_m\subseteq U_n$. This is well defined because $H_{n,m}$ fixes $U_m$ (2.2) and $B_m$ preserves $U_m$, it is $B_n$-equivariant, and it commutes with the embeddings because $x\cdot u$ is computed the same way in $U_n$ and $U_{n+1}$ (equivariance of the inclusion). So $\beta:F\to U$ is a morphism of sequences.

**Surjectivity at every $n$.** For $n\ge g$, $\beta_n(F_n)\supseteq R[B_n]U_g=U_n$. For $n<g$, the summand $m=n$ has $\mathrm{Ind}^{B_n}_{B_nH_{n,n}}U_n=U_n$ mapped identically. Summing over $m\le g$ is what handles $4\le n<g$, where $U_n\ne0$ and a single summand of degree $g$ would be zero.

**$F$ is generated in degree $g$.** At level $n=m$ the $m$-th summand is $U_m$, and $\mathrm{Ind}^{B_n}_{B_mH_{n,m}}U_m=R[B_n]\cdot U_m$, with $U_m$ contained in $F_g$ for $m\le g$. So $R[B_n]F_g=F_n$ for $n\ge g$. Each $U_m$ is finite dimensional, so $F$ is finitely generated.

**Relations.** $K=\ker\beta=\{\ker\beta_n\}$ is a sequence of $B_n$-subrepresentations with $K_n\subseteq K_{n+1}$ (because $\beta$ commutes with the embeddings), with restricted inner products and isometric inclusions, so it is a submodule of $F$. Theorem A.5 makes $K$ generated in some finite degree $r$.

**Conclusion.** $U$ is presented in degree $\max\{g,r\}<\infty$ in the sense of Definition 2.7. The set of $k\in\mathbb N$ for which Definition 2.7 holds is nonempty, so it has a least element by well ordering. That least element is $k_B(d)$, and it is a natural number for every $d\ge1$. The setting's companion statement $g(d)\le k_B(d)$ is the source's note after Definition 2.7.

### 2.6 The hypothesis of part 2 (C5)

With $k_B(d)\in\mathbb N$, "$n\ge n_0\ge k_B(d)$" is the conjunction of two inequalities between natural numbers. It is definite at every $d\ge1$, and it is satisfiable (take $n=n_0=k_B(d)$, and note $k_B(d)\ge4d\ge4$ so $\mathcal W_{n_0}\ne0$). The argument proves existence and gives no value, which is consistent with Passage A's "No finite $k_B(d)$ is on file": that sentence records the absence of a computed value, and 2.5 supplies finiteness without one.

### 2.7 Attacks attempted, and the defence

- **Empty minimum.** Definition 2.7 defines "the smallest $k$" and carries no convention for an empty set. Were $U$ not finitely presented, $k_B(d)$ would be undefined as written, and only a reading with $\min\emptyset=\infty$ would rescue a (vacuous) meaning. Defeated by 2.4 and 2.5: the set is nonempty.
- **Passage C.** Post F32 says Theorem 2.11's kernel and sums clauses do not apply to $\{\mathcal W_n\}$. That concerns the calculus that would bound $k_B(d)$. The existence argument above uses Theorem A.5 alone and never invokes Theorem 2.11's images, kernels or sums clauses, so the obstruction recorded there does not touch it.
- **Unspecified embedding.** The setting names padding on $\mathcal W_n$ and leaves the induced map on $\mathrm{Sym}^d\mathcal W_n^*$ implicit. The consistent-sequence axioms (isometric, equivariant) together with the proof's use of restriction as the projection determine it as $p\mapsto p\circ P_n$ (2.1). The truncation of a Weyl tensor on $\mathbb R^{n+1}$ to $[n]$ need not be traceless, so $P_n$ is truncation followed by trace removal. It is still well defined and $B_n$-equivariant, and nothing in 2.1 to 2.5 uses a formula for it.
- **Dependence on choices.** The presentation degree is a minimum over all free covers, so it does not depend on the cover chosen in 2.5, and 2.1 shows it is invariant under the identification with $\mathrm{Sym}^d\mathcal W_n$.
- **Scope of the imported theorem.** Theorem A.5 is stated for $\mathcal C$-modules valued in real inner product spaces with isometries. Footnote 7 of the source records that the results hold for functors to real vector spaces, and Wilson's theorem covers characteristic zero. $U$, $F$, $K$ and $T$ are all functors of the admissible kind.
- **Low indices.** $U_n=0$ for $n\le3$ and the sequence is indexed by all of $\mathbb N$. Zero terms are admissible in Definition 1.3 and cause no difficulty in 2.5, where the summands with $m\le3$ are zero.

Strongest reading and the hypotheses it needs: $k_B(d)$ is the presentation degree of $\{\mathrm{Sym}^d\mathcal W_n^*\}$ with the embedding H-emb, over $\{\mathbb R^n\}$ with $\{B_n\}$. It is a natural number at every $d\ge1$ by H-seq, H-mod and Theorem A.5 of the imported source, and part 2's hypothesis is then a definite and satisfiable condition. The only unwritten hypothesis the step needs is H-emb, which the passages determine.

**Verdict: VALID**

# Verifier v394, adjudication of step H4 in round L64-r2

Cold brief ([ADJ_L64r2_H4.md](ADJ_L64r2_H4.md)) and the imported source ([paper.pdf](https://arxiv.org/abs/2307.04230), [txt.txt](https://arxiv.org/abs/2307.04230)) only. No numerical work: no scripts, no computations, every value exact and derived by hand. Log: [agent_logs/verify-L64-v394.log](../agent_logs/verify-L64-v394.log).

| Claim | Verdict |
|---|---|
| C1. Under zero-padding, $\{\mathrm{Sym}^d\mathcal W_n^*\}$ is a consistent sequence of $\{B_n\}$-representations and a $V$-module over $V=\{\mathbb R^n\}$ in the sense of Definitions 1.3 and 2.5 | VALID |
| C2. That module is finitely generated, at every $d\ge1$ | VALID |
| C3. It admits a presentation in some finite degree, so the set over which Definition 2.7 takes its minimum is a nonempty set of natural numbers | VALID |
| C4. $k_B(d)$ is therefore a definite natural number at every $d\ge1$, and "$n\ge n_0\ge k_B(d)$" is a definite condition on the integers $n,n_0$ | VALID |
| The step as a whole | VALID |

**Summary: the step holds, because the module is a submodule of the finitely generated free module $\{(\mathbb R^n)^{\otimes4d}\}$ over $\mathrm{FI}_{BC}$, so the Noetherianity clause of Theorem A.5 gives a finitely generated free cover with a finitely generated kernel, and Definition 2.7's minimum is taken over a nonempty set of natural numbers.**

## 0. Conventions, fixed once

Quoted from the brief.

- "$\mathcal W_n$ is the space of algebraic Weyl tensors on $\mathbb R^n$: 4-tensors with the curvature symmetries $W_{ijkl}=-W_{jikl}=-W_{ijlk}=W_{klij}$, the first Bianchi identity $W_{ijkl}+W_{iklj}+W_{iljk}=0$, and every Ricci contraction zero, with the Frobenius inner product. $\mathcal W_n=0$ for $n\le3$."
- "$O(n)$, and its subgroups $SO(n)$ and the signed permutation group $B_n$, act on $\mathcal W_n$ by $(g\cdot W)_{ijkl}=g_{ia}g_{jb}g_{kc}g_{ld}W_{abcd}$. Zero-padding sends $W\in\mathcal W_{n_0}$ to the tensor on $\mathbb R^n$ with the same components on indices in $[n_0]$ and zero elsewhere."
- "$\mathrm{Sym}^d\mathcal W_n^*$ is the space of homogeneous polynomials of degree $d$ on $\mathcal W_n$."
- The setting: "Fix a degree $d\ge1$. Zero-padding embeds $\mathcal W_{n_0}$ isometrically in $\mathcal W_n$ and makes $\{\mathrm{Sym}^d\mathcal W_n^*\}$ a module over the base $\{\mathbb R^n\}$ with the group sequence $\{B_n\}$ of signed permutations. $k_B(d)$ is that module's presentation degree, in the sense of Definition 2.7 of Levin–Chandrasekaran, and $g(d)\le k_B(d)$ is its generation degree."

Notation of this report. Definition 2.7 uses the letter $d$ for a generation degree. To avoid the clash, the polynomial degree stays $d$ and module indices are written $m,n$. $V=\{\mathbb R^n\}$ with $G_n=B_n$, and $H_{n,m}\subseteq B_n$ is the centralizing subgroup of Definition 2.4. $U_n=\mathrm{Sym}^d\mathcal W_n^*$.

## 1. Hypothesis inventory

The step needs the following. Each is checked in Section 2 or is imported verbatim from the source.

- **R1, the embedding (a reading, supplied).** The setting names zero-padding on $\mathcal W_n$ and leaves the induced map on $\mathrm{Sym}^d\mathcal W_n^*$ implicit. The strongest reading is the induced one: $\psi_n(p)=p\circ P_n$, where $P_n:\mathcal W_{n+1}\to\mathcal W_n$ is the orthogonal projection onto the padded copy. Under the Frobenius identification $\mathrm{Sym}^d\mathcal W^*\cong\mathrm{Sym}^d\mathcal W\subseteq\mathcal W^{\otimes d}$ this is $\mathrm{Sym}^d$ of zero-padding. It is the only natural candidate: Definition 1.3 requires an injective map $U_n\hookrightarrow U_{n+1}$, and restriction of polynomials runs the other way. CHECKED in 2.1.
- **R2, the inner product on $U_n$.** Any choice restricting the tensor inner product of $\mathcal W_n^{\otimes d}$ to the symmetric tensors. Generation, induction, kernels and Definition 2.7 are linear and group theoretic, so $k_B(d)$ does not depend on a rescaling of that inner product. CHECKED in 2.1.
- **R3, $\mathcal W_n$ is $B_n$-stable and padding-closed.** CHECKED in 2.1.
- **I1, the category.** For $V=\{\mathbb R^n\}$ with $G_n=B_n$, the category $C_V$ of Definition A.2 is $\mathrm{FI}_{BC}$ (Example A.3(b)), and $V$-modules coincide with $C_V$-modules, with morphisms of sequences as natural transformations (the paragraph after Definition A.2). IMPORTED.
- **I2, Noetherianity.** Theorem A.5: for $C=\mathrm{FI}_{BC}$, any submodule of a finitely generated $C$-module is finitely generated ([50, Thm. 4.21] in the source). IMPORTED.
- **I3, free generators.** Example 2.12: $\{(\mathbb R^n)^{\otimes k}\}$ over $B_n$ is generated in degree $k$. Definition 2.6(a): an induction sequence $\mathrm{Ind}_{G_m}(W)$ is a $V$-module, and a direct sum of such is algebraically free. IMPORTED.
- **R4, "definite meaning".** Read as: $k_B(d)$ is a well-defined element of $\mathbb N$, so the hypothesis is a determinate predicate on $(n,n_0)$. The step asserts no numerical value, and none is needed.

## 2. The argument

### 2.1 C1, the module structure

**$\mathcal W_n$ under padding.** Let $W\in\mathcal W_m$ and let $\bar W$ be its padding to $\mathbb R^n$. The curvature symmetries and Bianchi identity are componentwise and hold for $\bar W$ because every component is either a component of $W$ or $0$. A Ricci component $\sum_{j\in[n]}\bar W_{ijkj}$ vanishes when $i$ or $k$ exceeds $m$ (every term is $0$), and equals $\sum_{j\in[m]}W_{ijkj}=0$ otherwise. So $\bar W\in\mathcal W_n$, padding is an isometry for the Frobenius norm, and it is $B_m$-equivariant with $B_m\ni g\mapsto\mathrm{blkdiag}(g,I_{n-m})$. $B_n\subseteq O(n)$ preserves the symmetries, the Bianchi identity and tracelessness, so $\mathcal W_n$ is an orthogonal $B_n$-representation. This is R3.

**The induced sequence.** $\mathrm{Sym}^d$ of an isometric equivariant linear map is isometric and equivariant for the restricted tensor inner product, so $\psi_n$ of R1 is a $B_n$-equivariant isometry $U_n\hookrightarrow U_{n+1}$. For $n\le3$, $U_n=\mathrm{Sym}^d(0)^*=0$ since $d\ge1$, which is a legitimate (zero) term. So $\{U_n\}$ satisfies Definition 1.3. This is R1 and R2.

**The $V$-module condition.** A signed permutation fixing $e_1,\dots,e_m$ is $\mathrm{blkdiag}(I_m,h')$ with $h'\in B_{n-m}$, so $H_{n,m}=\{\mathrm{blkdiag}(I_m,h')\}$. For such $h$ and $\bar W$ padded from $\mathcal W_m$, $(h\cdot\bar W)_{ijkl}=h_{ia}h_{jb}h_{kc}h_{ld}\bar W_{abcd}$ with $a,b,c,d\in[m]$, and $h_{ia}=\delta_{ia}$ for $a\in[m]$. Hence $h\cdot\bar W=\bar W$. So $h$ fixes the padded copy of $\mathcal W_m$ pointwise, and being orthogonal it preserves its complement, so $h$ commutes with the projection $P$ onto that copy and $P\circ h=P$. For $p\in U_m$ embedded as $p\circ P$, $(h\cdot(p\circ P))(W)=p(P h^{-1}W)=p(PW)$. So $U_m\subseteq U_n^{H_{n,m}}$ for all $m\le n$, which is Definition 2.5. **C1 VALID.**

A side check on R1 that confirms it is the reading part 2 uses: for $t\in\mathrm{Sym}^d\mathcal W_{n}$ with polynomial $w\mapsto\langle t,w^{\otimes d}\rangle$ and padded $w\in\mathcal W_{m}$, $\langle t,w^{\otimes d}\rangle=\langle P^{\otimes d}t,w^{\otimes d}\rangle$. So the orthogonal projection $P_{U_m}$ is restriction of polynomials to the padded copy, which is the map Proposition 2.9 is applied to in the proof's step (iii).

### 2.2 C2, finite generation

$U_n\cong\mathrm{Sym}^d\mathcal W_n\subseteq\mathcal W_n^{\otimes d}\subseteq(\mathbb R^n)^{\otimes4d}$, and the three inclusions are $B_n$-equivariant. The embedding of $(\mathbb R^n)^{\otimes4d}$ into $(\mathbb R^{n+1})^{\otimes4d}$ is zero-padding of $4d$-tensors, and restricted to $\mathrm{Sym}^d$ of padded Weyl tensors it is $\mathrm{Sym}^d$ of padding, which is $\psi_n$ under R1. So $\{U_n\}$ is a $C_V$-submodule of $T=\{(\mathbb R^n)^{\otimes4d}\}$. By I3, $T$ is generated in degree $4d$, and $T_{4d}$ is finite dimensional, so $T$ is finitely generated. By I2, $\{U_n\}$ is finitely generated: there is $g<\infty$ with $\mathbb R[B_n]U_g=U_n$ for all $n\ge g$ (Definition 2.2). The paper's own "finitely-generated if generated in degree $d$ for some $d<\infty$" and the categorical notion of finitely many generators agree here, because every $U_m$ is finite dimensional and a generator in degree $m\le g$ is carried into $U_g$ by the embeddings. **C2 VALID.**

### 2.3 C3, a presentation in finite degree

**The free cover.** $H_{m,m}=\{I_m\}$, so every $B_m$-representation is admissible in Definition 2.6(a). Set
$$F=\bigoplus_{m=1}^{g}\mathrm{Ind}_{B_m}(U_m),\qquad F_n=\bigoplus_{m\le\min(n,g)}\mathrm{Ind}_{B_mH_{n,m}}^{B_n}U_m .$$
By I3, $F$ is algebraically free. Each summand is generated in degree $m\le g$, since the induced representation is spanned by $B_n$-translates of its degree-$m$ piece, so $F$ is generated in degree $g$. Each $F_n$ is finite dimensional (finitely many cosets, finite dimensional $U_m$).

**The map.** On the summand $m$ define $\beta_n(c\otimes u)=c\cdot\iota_{m,n}(u)$ for $c\in B_n$ and $u\in U_m$, where $\iota_{m,n}=\psi_{n-1}\cdots\psi_m$. It is well defined because $B_mH_{n,m}$ acts on $\iota_{m,n}(U_m)$ through $B_m$, the factor $H_{n,m}$ acting trivially by C1. It is $B_n$-equivariant by construction. It commutes with the embeddings: the coset map $B_n/B_mH_{n,m}\to B_{n+1}/B_mH_{n+1,m}$ is injective, since an element of $B_n\cap B_mH_{n+1,m}$ fixes $e_{n+1}$ and so lies in $B_mH_{n,m}$, and then $\beta_{n+1}(c\otimes u)=c\cdot\psi_n\iota_{m,n}(u)=\psi_n(c\cdot\iota_{m,n}(u))=\psi_n\beta_n(c\otimes u)$ by $B_n$-equivariance of $\psi_n$. So $\beta=\{\beta_n\}$ is a morphism of sequences (Definition 2.1).

**Surjectivity at every $n$.** If $n\le g$, the summand $m=n$ is $\mathrm{Ind}_{B_n}^{B_n}U_n=U_n$ and $\beta_n$ is the identity on it. If $n\ge g$, the summand $m=g$ has image $\mathbb R[B_n]\iota_{g,n}(U_g)=U_n$ by C2. The lower summands $m<g$ are needed exactly because Definition 2.7 asks for a surjective morphism of sequences, surjective at every index, and $U_n$ can be nonzero for $4\le n<g$.

**The kernel.** $K_n=\ker\beta_n$ is $B_n$-stable, and $\psi$ carries $K_n$ into $K_{n+1}$ because $\beta$ is a morphism, so $K$ is a $C_V$-submodule of $F$ with the restricted inner products. $F$ is finitely generated (C2's argument applied to $F$: generated in degree $g$ with $F_g$ finite dimensional). By I2, $K$ is finitely generated, hence generated in some degree $r<\infty$.

So $U$ is generated in degree $g$, related in degree $r$, and presented in degree $\max\{g,r\}<\infty$. The set $\{k\in\mathbb N:U\text{ is presented in degree }k\}$ is nonempty. **C3 VALID.**

### 2.4 C4, definiteness

A nonempty subset of $\mathbb N$ has a unique least element, so "the smallest $k$ for which this holds" in Definition 2.7 names a unique $k_B(d)\in\mathbb N$ for each $d\ge1$, and it is at least the generation degree $g(d)$ by the note after Definition 2.7. The minimum ranges over all algebraically free covers and all surjections, so it depends on no choice made in 2.3. By R2 it depends on no rescaling of the inner product. Part 2's hypothesis "$n\ge n_0\ge k_B(d)$" is then a determinate predicate on the pair of integers $(n,n_0)$, and Proposition 2.9 applies to $U$ with $k=k_B(d)$. **C4 VALID.**

### 2.5 The strongest case against, and why it does not hold

- **"Definition 2.7 takes a minimum over a set that may be empty, and the record says no finite $k_B(d)$ is on file."** This is the only route to FAILS. The passages' remark is a statement about what the record has computed, and Passage C's point is that Theorem 2.11's calculus does not produce a bound. Existence of a finite presentation does not go through Theorem 2.11: it comes from Noetherianity (I2) applied twice, as in 2.2 and 2.3. The value stays unknown and the passages' lower bound $k_B(d)\ge4d$ is untouched, but the step claims definiteness only.
- **"The embedding on $\mathrm{Sym}^d\mathcal W_n^*$ is never written."** Definition 1.3 forces an injective equivariant isometry $U_n\hookrightarrow U_{n+1}$, and the setting derives it from zero-padding. The induced map of R1 is the one that does so, and 2.1 shows it is the one whose adjoint is the restriction used in the proof. A reader who chose some other equivariant isometry would be departing from "zero-padding ... makes", so this is a gap of explicitness, not of meaning.
- **"The letter $d$ is used twice."** The fixed polynomial degree and Definition 2.7's generation degree share a symbol. The setting's own "$g(d)$ is its generation degree" keeps them apart, and nothing in the step turns on the clash.
- **"At small $d$ or small $n$ the module degenerates."** $U_n=0$ for $n\le3$ is a valid zero term, the free cover of 2.3 handles it (the summands $m\le3$ are zero), and $d\ge1$ is used only in $\mathrm{Sym}^d(0)^*=0$. No $d\ge1$ is exceptional.

A screen, not evidence: if the step had read "$k_B(d)$ is a known finite number" it would fail on the passages' own admission. It does not say that.

**Verdict: VALID**

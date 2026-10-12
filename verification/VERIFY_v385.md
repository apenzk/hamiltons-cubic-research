# Verifier v385, Lemma L64 (the transfer mechanism): setting, existence, uniqueness, the SO clause, the bound $k_B(d)\ge4d$, the $n_0=3$ edge, the $\mathrm{Sym}^2S^n$ exhibit, Passages B and C, and L64.lean

The brief [BRIEF_L64r2.md](BRIEF_L64r2.md) was read cold and every check below works from its quoted passages and definitions, with the imported theorems read at source in [paper.pdf](https://arxiv.org/abs/2307.04230) (pages 16 and 17 checked against the extraction) and [txt.txt](https://arxiv.org/abs/2307.04230). No numerical work was done, no scripts were written, no Lean was compiled, and every value reported is exact and obtained by hand. Hand checks on constructed objects are reported as screens. The log is [agent_logs/verify-L64-v385.log](../agent_logs/verify-L64-v385.log).

| # | Claim attacked | Verdict | Reason |
|---|---|---|---|
| 1 | Setting: $\{\mathrm{Sym}^d\mathcal W_n^*\}$ is a $\{\mathbb R^n\}$-module over $\{B_n\}$ and $k_B(d)$ is its presentation degree | CONFIRMED | Definitions 1.3 and 2.5 hold with embedding $p\mapsto p\circ P$, and the adjoint is restriction of forms. The case of no finite $k$ needs a stated convention, harmless because part 2 is then vacuous |
| 2 | Part 1, existence of an $O(n)$-invariant extension for every $n\ge n_0$ | CONFIRMED | FFT spanning holds at every $n_0$, complete contractions carry no free $\delta$, and padded components above $n_0$ vanish |
| 3 | Part 2, uniqueness of the $B_n$-invariant extension for $n\ge n_0\ge k_B(d)$ | CONFIRMED | Proposition 2.9 as printed gives isomorphisms at every level $\ge k$, and the composite from $n$ to $n_0$ is restriction |
| 4 | "The same holds with $SO$ in place of $O$" | REFUTED AS STATED | At $n_0=4$, $d=2$, $n=5$ the $SO(4)$-invariant form $\sum\varepsilon_{ijkl}W_{klpq}W_{pqij}$ has no $SO(5)$-invariant extension. The reflection sentence proves only that the $SO$ case reduces to the $O$ case |
| 5 | $k_B(d)\ge g(d)\ge4d$, so $k_B(6)\ge24>12$ | CONFIRMED | $T\in\mathcal W_4$ checks, the block product has component $1/d!$ at $(1,\dots,4d)$, and signed permutations preserve support size |
| 6 | "No finite $k_B(d)$ is on file", resting on Passage C's kernel and sums clauses | CONFIRMED | A statement of record, with Passage C's kernel-clause obstruction screened true on a padded curvature tensor |
| 7 | Passage C: "Theorem 2.11's calculus yields no $k_B$ here at all" | HYPOTHESIS-DEBT | The argument addresses the kernel and sums clauses only. The images, tensors and Sym clauses are not discussed. Nothing in L64 depends on the stronger wording |
| 8 | The $n_0=3$, $d=2$ edge | CONFIRMED | $\mathcal W_3=0$, $k_B(2)\ge8>3$, and $0$ and $\lvert W\rvert^2$ are distinct $B_n$-invariant extensions for $n\ge4$ |
| 9 | The $\mathrm{Sym}^2S^n$ exhibit | CONFIRMED | Presented in degree $(2-1)\cdot2+2=4$, the identity expands exactly, $G(I_5)=-\tfrac54$, and $G$ is the unique $B_5$-invariant extension |
| 10 | Passage B against Passage A | REFUTED AS STATED | The detail statement carries the $SO$ clause over the existence part as well. Everything else agrees |
| 11 | Passage E, L64.lean | CONFIRMED AS ALGEBRA | The file types only arithmetic ($4\cdot6=24>12$) and tautologies. No declaration mentions forms, Weyl tensors, invariance or $k_B$ |

**Summary: the $O$ lemma is proven as written (existence unconditionally, uniqueness for $n\ge n_0\ge k_B(d)$), but the $SO$ clause is false for existence at $n_0=4$, $d=2$, $n=5$ and must be cut back in Passages A and B to "an $SO(n_0)$-invariant form with a $B_n$-invariant extension is $O(n_0)$-invariant, so the $SO$ case is the $O$ case".**

## 0. Conventions, fixed once

Quoted from the brief:

- "$\mathcal W_n$ is the space of algebraic Weyl tensors on $\mathbb R^n$: 4-tensors with the curvature symmetries $W_{ijkl}=-W_{jikl}=-W_{ijlk}=W_{klij}$, the first Bianchi identity $W_{ijkl}+W_{iklj}+W_{iljk}=0$, and every Ricci contraction zero, with the Frobenius inner product. $\mathcal W_n=0$ for $n\le3$."
- "$O(n)$, and its subgroups $SO(n)$ and the signed permutation group $B_n$, act on $\mathcal W_n$ by $(g\cdot W)_{ijkl}=g_{ia}g_{jb}g_{kc}g_{ld}W_{abcd}$. Zero-padding sends $W\in\mathcal W_{n_0}$ to the tensor on $\mathbb R^n$ with the same components on indices in $[n_0]$ and zero elsewhere."
- "$\mathrm{Sym}^d\mathcal W_n^*$ is the space of homogeneous polynomials of degree $d$ on $\mathcal W_n$. $S^n$ is the space of real symmetric $n\times n$ matrices."

Additional notation used in this report only: $\mathrm{pad}$ is zero-padding, $P:\mathcal W_n\to\mathcal W_{n_0}$ its adjoint (truncation), and for $W\in\mathcal W_4$ the matrix $M$ is $W$ read as a symmetric operator on $\Lambda^2\mathbb R^4$ in the basis $e_{12},e_{13},e_{14},e_{23},e_{24},e_{34}$, $M(ij,kl)=W_{ijkl}$.

## 1. Hypothesis inventory

**Hypotheses of the statement (Passage A).**

| Label | Hypothesis | Used where |
|---|---|---|
| S1 | Zero-padding embeds $\mathcal W_{n_0}$ isometrically in $\mathcal W_n$ | Setting, step (iii) |
| S2 | $\{\mathrm{Sym}^d\mathcal W_n^*\}$ is a module over $\{\mathbb R^n\}$ with $\{B_n\}$ | Step (iii) |
| S3 | $k_B(d)$ is its presentation degree (Definition 2.7), $g(d)$ its generation degree | Step (iii), scope bullet 1 |
| H1 | $d\ge1$ | Unused by the proof. The lemma holds at $d=0$ as well (constants). Harmless |
| H2 | $F$ is an $O(n_0)$-invariant form of degree $d$ on $\mathcal W_{n_0}$ | Step (i) |
| H3 | $n\ge n_0$ | Step (ii) |
| H4 | $n\ge n_0\ge k_B(d)$ | Step (iii) |
| H5 | For the $SO$ clause: $F$ is $SO(n_0)$-invariant | The reflection sentence only. No argument covers existence under H5 (section 4) |

**Imported results and their hypotheses checked against the object.**

| Imported result | Hypotheses | Check against the object |
|---|---|---|
| First fundamental theorem for $O(m)$ (cited by name, no source given) | Real orthogonal group, multilinear invariant functional on $(\mathbb R^m)^{\otimes 2p}$. The spanning statement holds for every $m\ge1$, and linear independence of the contractions fails for small $m$ | $F\circ\pi_{n_0}$ is $O(n_0)$-invariant because $\pi_{n_0}$ is the orthogonal projection onto an invariant subspace, hence equivariant. Its full polarisation is a linear functional on $(\mathbb R^{n_0})^{\otimes4d}$, and $4d$ is even. Satisfied. The source is uncited, a citation debt only |
| Definition 1.3 (consistent sequence) | Compact $G_n\subseteq G_{n+1}$, orthogonal representations, $G_n$-equivariant isometric embeddings | $B_n$ finite, embedded as $\mathrm{blkdiag}(g,1)$ (Example 1.5). Padding is a $B_n$-equivariant isometry $\mathcal W_n\to\mathcal W_{n+1}$, and $p\mapsto p\circ P$ is its $d$-th symmetric power. Satisfied (section 2) |
| Definition 2.5 ($V$-module) | $U_m\subseteq U_n^{H_{n,m}}$ with $H_{n,m}$ the signed permutations fixing $e_1,\dots,e_m$ (Example 2.8) | Satisfied (section 2) |
| Proposition 2.9 | $V$ consistent sequence, $U$ a $V$-module presented in degree $k$. Conclusion: $P_{U_n}:U_{n+1}^{G_{n+1}}\to U_n^{G_n}$ iso for all $n\ge k$ | $V=\{\mathbb R^n\}$ with $B_n$, $U=\{\mathrm{Sym}^d\mathcal W_n^*\}$, $k=k_B(d)$ when finite. Satisfied under H4 (section 3) |
| Theorem 2.11 (Sym clause) and Example 2.12 | $V=\{\mathbb R^n\}$ with $G_n\in\{B_n,D_n,S_n\}$, $W$ a $V$-module generated in $d_W$, presented in $k_W$ | Used only in the exhibit: $S^n=\mathrm{Sym}^2\mathbb R^n$ with $B_n$, $d_W=k_W=2$. Satisfied (section 8) |

**Used but unstated.** (a) A convention for $k_B(d)$ when no finite presentation exists (Definition 2.7 defines "the smallest $k$", which may not exist). With $k_B(d)=\infty$ part 2 is vacuous, so no conclusion is affected. (b) The source of the first fundamental theorem. (c) For the $SO$ clause, an existence argument (section 4). **Stated but unused.** H1, and $g(d)$ outside the scope bullet.

## 2. The setting against Passage D (brief item 1)

**Consistent sequence.** Padding preserves the curvature symmetries and Bianchi trivially, and the Ricci contraction of a padded tensor is $\sum_{i\le n}\mathrm{pad}(W)_{ijil}$, which is $\mathrm{Ric}(W)_{jl}$ for $j,l\le n_0$ and $0$ otherwise. So padding maps $\mathcal W_{n_0}$ into $\mathcal W_n$, isometrically in the Frobenius product. For $g\in B_{n_0}$, $\mathrm{pad}(g\cdot W)=\mathrm{blkdiag}(g,I)\cdot\mathrm{pad}(W)$ componentwise, so padding is equivariant. Identifying $\mathrm{Sym}^d\mathcal W_n^*$ with symmetric tensors in $\mathrm{Sym}^d\mathcal W_n$ by the inner product, the source's embedding $\varphi^{\otimes d}$ (Section 2.3, Polynomials) is $p\mapsto p\circ P$, and its adjoint $P_{U_n}$ sends the tensor $s$ with $q(W)=\langle s,W^{\otimes d}\rangle$ to $P^{\otimes d}s$, which represents $W\mapsto\langle s,\mathrm{pad}(W)^{\otimes d}\rangle=q(\mathrm{pad}\,W)$. **So the projection of Proposition 2.9 is restriction of forms to the padded copy.**

**$V$-module.** $h\in H_{n,m}$ is $\mathrm{blkdiag}(I_m,h')$ with $h'$ a signed permutation. It acts as the identity on the padded copy of $\mathcal W_m$ and preserves its orthogonal complement, so $Ph=P$ on $\mathcal W_n$ and $(p\circ P)(h^{-1}W)=p(PW)$. Hence $U_m\subseteq U_n^{H_{n,m}}$. Satisfied.

**Well-definedness of $k_B(d)$.** Definition 2.7 defines it as a minimum over a set that is either nonempty (then well defined) or empty. The passages give no convention for the empty case. No finding against the conclusions, since the empty case makes part 2 vacuous. Remark only: the source's Theorem A.5 (Noetherianity of $\mathrm{FI}_{BC}$-modules) bears on whether the set is nonempty, and the passages do not cite it. This report does not settle finiteness.

**Generation degree $g(d)\le k_B(d)$.** The source's note after Definition 2.7 states it, and it follows from Proposition B.2 plus monotonicity of "generated in degree $m$" in $m$. No finding.

## 3. Existence and uniqueness for $O$ (brief items 2, 3, 4)

**Step (i).** $F\circ\pi_{n_0}$ is a degree-$d$ polynomial on $(\mathbb R^{n_0})^{\otimes4}$, $O(n_0)$-invariant, restricting to $F$ on $\mathcal W_{n_0}$. Its polarisation $\Phi$ satisfies $F(W)=\Phi(W^{\otimes d})$ for $W\in\mathcal W_{n_0}$, and the FFT spanning statement gives $\Phi=\sum_\pi a_\pi\,\mathrm{contr}_\pi$. At small $n_0$ the contractions satisfy relations, so the $a_\pi$ are not unique. Nothing later needs uniqueness: part 1 needs one choice, and part 2 proves the resulting $G$ independent of the choice in its range. Below that range $G$ may depend on the choice, and no claim is made there. At $n_0\le3$, $\mathcal W_{n_0}=0$, $F=0$, and any choice works. No finding.

**Step (ii).** $C_\pi^{(n)}(W)=\sum_{\iota}\prod W_{\iota(\cdot)}$ over assignments $\iota$ of values in $[n]$ to the $2d$ pairs of $\pi$. It is a polynomial of degree $d$ on $\mathcal W_n$ and $O(n)$-invariant because a complete contraction of $W^{\otimes d}$ is. "No closed $\delta$-loop occurs" means every $\delta$ of the contraction joins two tensor slots, so no factor $\delta_{ii}=n$ appears that would make the formula depend on $n$ off the tensor. That is exactly what the restriction needs. On $\mathrm{pad}(W)$ every assignment using a value above $n_0$ hits a zero component, so $C_\pi^{(n)}(\mathrm{pad}\,W)=C_\pi^{(n_0)}(W)$ and $G\circ\mathrm{pad}=F$. No finding.

**Step (iii) against Proposition 2.9 as printed.** Page 16 of the PDF: "the maps $\mathcal P_{\mathbb U_n}:\mathbb U^{G_{n+1}}_{n+1}\to\mathbb U^{G_n}_n$ are isomorphisms for all $n\ge k$." For $n\ge n_0\ge k$ every level $m\in\{n_0,\dots,n-1\}$ satisfies $m\ge k$, so each one-step restriction is injective, and their composite is restriction from $\mathcal W_n$ to the padded $\mathcal W_{n_0}$ because the embeddings compose. At $n=n_0$ the claim is trivial. $G$ is $O(n)$-invariant, hence $B_n$-invariant, and restricts to $F$. Any other $B_n$-invariant $G'$ with the same restriction has $G-G'$ in the kernel, so $G'=G$. "Exactly one" and "therefore the $O(n)$-invariant extension of part 1" both follow. Proposition 2.9 in fact gives surjectivity too, which the lemma does not claim. No finding.

## 4. The $SO$ clause (brief item 5). REFUTED AS STATED

**Step 1, location.** Passage A: "The same holds with $SO$ in place of $O$, because $B_{n_0}$ contains the reflection $\mathrm{diag}(-1,1,\dots,1)$: an $SO(n_0)$-invariant form with a $B_n$-invariant extension is $O(n_0)$-invariant." Passage B repeats "The same holds with $SO$ in place of $O$" after both parts. With $SO$ in place of $O$, part 1 reads: every $SO(n_0)$-invariant form of degree $d$ on $\mathcal W_{n_0}$ has an $SO(n)$-invariant extension for every $n\ge n_0$, with no hypothesis on $n_0$. The stated reason covers only forms that already have a $B_n$-invariant extension. Step (i) uses the FFT for $O(n_0)$, and the $SO(n_0)$ theorem adds $\varepsilon$-contractions, which step (ii) does not handle.

**Step 2, failure in closed form.** Take $n_0=4$, $d=2$, $n=5$.

- The form. $F(W)=\sum_{i,j,k,l,p,q}\varepsilon_{ijkl}W_{klpq}W_{pqij}$ on $\mathcal W_4$. It is a complete contraction of $\varepsilon\otimes W\otimes W$, so $F(gW)=\det(g)F(W)$ for $g\in O(4)$. In particular $F$ is $SO(4)$-invariant and $F(rW)=-F(W)$ for $r=\mathrm{diag}(-1,1,1,1)$, since the nonzero terms have $\{i,j,k,l\}=[4]$ and pick up $s_1s_2s_3s_4=-1$.
- A tensor with $F\ne0$. $W=W^D+T$, where $W^D$ has $W^D_{1212}=W^D_{3434}=1$, $W^D_{1313}=W^D_{2424}=-1$, $W^D_{1414}=W^D_{2323}=0$ with symmetry images and all else zero, and $T$ is the brief's tensor. $W^D$ is traceless ($\mathrm{Ric}_{11}=1-1+0$, $\mathrm{Ric}_{22}=1+0-1$, $\mathrm{Ric}_{33}=-1+0+1$, $\mathrm{Ric}_{44}=0-1+1$, off-diagonal Ricci zero) and satisfies Bianchi (e.g. $W_{1212}+W_{1122}+W_{1221}=1+0-1$). $T\in\mathcal W_4$ is checked in section 5. In the $\Lambda^2$ basis, $M$ has diagonal $(1,-1,0,0,-1,1)$ and off-diagonal entries $M(12,34)=1$, $M(13,24)=T_{1324}=1$, $M(14,23)=0$. The Hodge matrix is $S(12,34)=\varepsilon_{1234}=1$, $S(13,24)=\varepsilon_{1324}=-1$, $S(14,23)=\varepsilon_{1423}=1$. Summing over ordered pairs gives $F(W)=8\,\mathrm{tr}(SM^2)$. Row by row $SM=M$, so $W$ is self-dual and $\mathrm{tr}(SM^2)=\mathrm{tr}(M^2)=4+4=8$. **So $F(W)=64$ and $F(rW)=-64$.**
- No extension. Let $G$ be any $SO(5)$-invariant form on $\mathcal W_5$ and $g=\mathrm{diag}(-1,1,1,1,-1)\in SO(5)$. For $W\in\mathcal W_4$, $(g\cdot\mathrm{pad}\,W)_{ijkl}=g_{ii}g_{jj}g_{kk}g_{ll}\,\mathrm{pad}(W)_{ijkl}$ vanishes unless all indices lie in $[4]$, where it equals $(rW)_{ijkl}$. So $g\cdot\mathrm{pad}(W)=\mathrm{pad}(rW)$ and $G(\mathrm{pad}(rW))=G(\mathrm{pad}\,W)$. If $G$ extended $F$ this would give $-64=64$. **$F$ has no $SO(5)$-invariant extension**, and the same $g$ padded by ones rules out every $n\ge5$.

**Step 3, the charitable reading.** The reason given, "an $SO(n_0)$-invariant form with a $B_n$-invariant extension is $O(n_0)$-invariant", is correct: with $H$ a $B_n$-invariant extension and $r\in B_{n_0}\subseteq B_n$, $F(rW)=H(\mathrm{pad}(rW))=H(r\cdot\mathrm{pad}W)=F(W)$. The most charitable reading of the clause is therefore "the $SO$ case adds nothing: an $SO(n_0)$-invariant form enters the lemma only if it is $O(n_0)$-invariant". That reading is true, but the words "the same holds" assert parts 1 and 2 for $SO(n_0)$-invariant $F$, and part 1 carries "No hypothesis on $n_0$ enters", which $n_0=4$ meets. The candidate survives. For part 2 with $SO$, the reason itself shows that an $SO(n_0)$-invariant form which is not $O(n_0)$-invariant has zero $B_n$-invariant extensions, so "exactly one" fails whenever such a form exists at some $n_0\ge k_B(d)$. Whether one exists in that range is not settled here, since no finite $k_B(d)$ is known. **The corrected clause is the charitable reading, stated as such.**

## 5. The bound $k_B(d)\ge g(d)\ge4d$ (brief item 6). CONFIRMED

- $T$ is well defined. The three curvature-symmetry orbits of $1234$, $1342$, $1423$ each have 8 elements and are disjoint, covering all 24 permutations: $\{1234,2134,1243,2143,3412,4312,3421,4321\}$ with values $\pm1$, $\{1342,3142,1324,3124,4213,2413,4231,2431\}$ with values $\pm1$ ($T_{1324}=1$), and the $1423$ orbit, all zero. No component receives two values.
- Bianchi. With four distinct indices each instance is a signed copy of the sum the brief checks. By hand: $i=1$: $1-1+0=0$. $i=2$: $T_{2134}+T_{2341}+T_{2413}=-1+0+1=0$. $i=3$: $T_{3124}+T_{3241}+T_{3412}=-1+0+1=0$. $i=4$: $T_{4123}+T_{4231}+T_{4312}=0+1-1=0$. With a repeated index every term is zero. The brief records only the first instance, and the others hold.
- Traceless. $\mathrm{Ric}_{jl}=\sum_iT_{ijil}$ has a repeated $i$, so every term is zero.
- The product. With $T^{(k)}$ the copy of $T$ on block $\{4k-3,\dots,4k\}$ (a permutation translate of $\mathrm{pad}\,T$, so in $\mathcal W_{4d}$), the symmetric tensor $\mathrm{sym}(T^{(1)}\otimes\cdots\otimes T^{(d)})\in\mathrm{Sym}^d\mathcal W_{4d}\subseteq(\mathbb R^{4d})^{\otimes4d}$ has component $\tfrac1{d!}\prod_kT_{1234}=\tfrac1{d!}\ne0$ at $(1,2,\dots,4d)$, since only the identity ordering places each block's indices on its own copy.
- Support. A padded element of $\mathrm{Sym}^d\mathcal W_m$ inside $(\mathbb R^n)^{\otimes4d}$ is supported on multi-indices with values in $[m]$, hence at most $m$ distinct values. A signed permutation permutes values and changes signs, preserving the number of distinct values. For $m<4d$ every element of $\mathbb R[B_{4d}]U_m$ vanishes at $(1,\dots,4d)$, so $U_{4d}\ne\mathbb R[B_{4d}]U_m$ and the module is not generated in degree $m$ (Definition 2.2, which needs all $n\ge m$). Hence $g(d)\ge4d$ and $k_B(d)\ge4d$. At $d=6$: $24>12$.

The argument bounds the generation degree, which is what it claims. No finding.

## 6. "No finite $k_B(d)$ is on file" and Passage C (brief item 7)

**Passage A's sentence. CONFIRMED.** It is a claim about the record, not a claim that $k_B(d)=\infty$, and nothing in the passages exhibits a finite value. It rests on Passage C.

**Kernel clause, screened.** Theorem 2.11's kernel clause needs $A$ and $A^*$ both morphisms. With $A=\mathrm{Ric}$ from curvature tensors to $S^n$ (kernel $\mathcal W_n$), $A^*$ commutes with padding exactly when, taking adjoints, $\mathrm{Ric}$ commutes with truncation. Screen: on $\mathbb R^5$ let $R_{1515}=1$ with symmetry images. Then $\mathrm{Ric}(R)_{11}=R_{5151}=1$, while the truncation of $R$ to $[4]$ is $0$, so $\mathrm{Ric}(PR)=0\ne P\,\mathrm{Ric}(R)$. Passage C's claim holds on this object.

**Sums clause, screened.** With $h\odot I$ the Kulkarni–Nomizu product, $(k\odot I_n)_{iqjq}=k_{ij}+k_{qq}\delta_{ij}$ for $i,j\le n_0<q$, while $\mathrm{pad}(h\odot I_{n_0})$ vanishes there. So $\mathrm{pad}(h\odot I_{n_0})=k\odot I_{n_0+1}$ forces $k|_{[n_0]}=-k_{qq}I$ and then $h\propto I$, matching Passage C at one padding step. At a second step, $(k\odot I)_{pqpq}=k_{pp}+k_{qq}$ for distinct $p,q>n_0$ forces $h=0$. That strengthens Passage C's conclusion and changes nothing in L64. Reported as a screen.

**Passage C's "yields no $k_B$ here at all". HYPOTHESIS-DEBT.** The argument on file covers the kernel and sums clauses. The images clause, and the tensors and Sym clauses (which need a presentation degree of $\{\mathcal W_n\}$ as input), are not discussed. To discharge it: show that no clause of Theorem 2.11, applied to any decomposition of $\{\mathcal W_n\}$ from modules of known degree, yields a bound. L64 uses only the weaker "none on file".

## 7. The $n_0=3$ edge and "Below the range, uniqueness fails" (brief item 8). CONFIRMED

$\mathcal W_3=0$, so $F=0$ is the only form, and $k_B(2)\ge8>3$ puts $n_0=3$ below the range. For $n\ge4$, $0$ and $\lvert W\rvert^2=\sum W_{ijkl}^2$ are both $O(n)$-invariant, hence $B_n$-invariant, both restrict to $0$ on the zero space, and they differ because $\mathcal W_n\ne0$. These are two extensions of the kind part 2 counts. The sentence needs $n\ge4$, which is implicit.

### 7a. Withdrawn: "Below the range, uniqueness fails" as a general claim

1. Location: Passage A, scope bullet 3, read as "for every $n_0<k_B(d)$ uniqueness fails".
2. Failure: at $d=1$, $n_0=3<4\le k_B(1)$, $F=0$. A $B_n$-invariant linear form is $\langle A,\cdot\rangle$ with $A\in\mathcal W_n$ fixed by $B_n$. Sign-change invariance kills every component in which some value appears an odd number of times, leaving patterns $iiii$, $iijj$ (both zero by antisymmetry), $ijij=\alpha$ and $ijji=-\alpha$ for $i\ne j$. Tracelessness gives $(n-1)\alpha=0$. So $A=0$, and the extension is unique at $n_0=3$, below the range.
3. Charitable reading: the sentence is followed at once by "at $n_0=3$ and $d=2$", so it reads as "uniqueness can fail below the range, for instance...". That reading is true and is what the passage supports. **Withdrawn.** Wording note: "can fail" would state what is shown.

## 8. The $\mathrm{Sym}^2S^n$ exhibit (brief item 9). CONFIRMED

- Degree. $S^n=\mathrm{Sym}^2\mathbb R^n$ with zero padding, over $B_n$, is generated and presented in degree $2$ by Example 2.12. Theorem 2.11's Sym clause (valid for $V=\{\mathbb R^n\}$ with $B_n$) gives $\mathrm{Sym}^2$ of it generated in degree $2\cdot2=4$ and presented in degree $(2-1)\cdot2+2=4$. Quadratic forms on $S^n$ are identified with $\mathrm{Sym}^2S^n$ by the trace inner product.
- Identity. $\mathrm{tr}\big((X-\tfrac14\mathrm{tr}X\,I_4)^2\big)=\mathrm{tr}X^2-\tfrac12(\mathrm{tr}X)^2+\tfrac1{16}(\mathrm{tr}X)^2\cdot4=\mathrm{tr}X^2-\tfrac14(\mathrm{tr}X)^2$, and it is $\ge0$ as the trace of the square of a symmetric matrix.
- Extension. $G(X)=\mathrm{tr}X^2-\tfrac14(\mathrm{tr}X)^2$ on $S^5$ is $O(5)$-invariant and $G(\mathrm{pad}X)=F(X)$. With $n_0=4\ge4$, Proposition 2.9 makes it the unique $B_5$-invariant extension. $G(I_5)=5-\tfrac{25}4=-\tfrac54$.
- Conclusion drawn. The mechanism, even inside its range, does not carry nonnegativity off the padded copy (on $S^5$, $G\ge0$ on every matrix with nonzero kernel, which is an $O(5)$-conjugate of a padded one). "Needs an argument of its own" follows. The exhibit is on a different module from $\{\mathrm{Sym}^d\mathcal W_n^*\}$, and the passage presents it as "the same mechanism", which is accurate. The reference to Post F31 lies outside the brief and was not checked.

## 9. Passages B and C against Passage A (brief item 10)

| Point | Passage A | Passage B (landscape) | Passage B (detail) | Passage C |
|---|---|---|---|---|
| Range of part 1 | every $n\ge n_0$ | every $n\ge n_0$ | every $n\ge n_0$ | every $n\ge n_0$ |
| Range of part 2 | $n\ge n_0\ge k_B(d)$ | "when $n_0\ge k_B(d)$", $n\ge n_0$ implicit in "that extension" | $n\ge n_0\ge k_B(d)$ | "once $n_0\ge k_B(d)$" |
| $SO$ clause | both parts, with a reason that covers neither | absent | "The same holds", both parts, no reason | absent |
| Bound | $k_B(d)\ge g(d)\ge4d$ | $k_B(d)\ge4d$ | $k_B(d)\ge4d$, $k_B(6)\ge24$ | none |
| Theorem 2.11 | kernel and sums clauses do not apply | none | none | "yields no $k_B$ here at all" |
| Sign | "only on the padded copy" | same | same | none |

**Passage B detail: REFUTED AS STATED**, the same defect as section 4, now in the canonical statement. Passage B's landscape entry omits the $SO$ clause and is correct. Passage C's "Equivariance was never the obstruction" is correct for $O$ and false for $SO$ (section 4), but Passage C speaks of $O$ only. Passage C's "at all" is stronger than Passage A's wording (section 6). Every other qualifier agrees.

## 10. Passage E, L64.lean (brief item 11 and standing item 5). CONFIRMED AS ALGEBRA

| Declaration | What it states | Relation to Passage A |
|---|---|---|
| generation_degree | $4\cdot6=24$ | Arithmetic of $4d$ at $d=6$ |
| exceeds_twelve | $12<24$ | Arithmetic of "$24>12$" |
| six_blocks_support | $6\cdot4=24$ | Arithmetic of the block count |
| support_cap_at_six | $2\cdot6=12$ | No counterpart. Passage A has no support cap $2d$ |
| counts_disagree | $2\cdot6<6\cdot4$ | No counterpart in Passage A |
| support_forces_degree | $24\le2d\Rightarrow12\le d$ over $\mathbb N$ | No counterpart in Passage A |
| overstatement_factor | $24=2\cdot12$ | No counterpart in Passage A |
| indexed_not_scalar | strictly increasing $k:\mathbb N\to\mathbb N$ has $k(d)\ne k(d+1)$ | Hypothesis `hmono` is never established for $k_B$, and Passage A claims only $k_B(d)\ge4d$ |
| unbounded | strictly increasing $k$ is unbounded | Same hypothesis gap. The bound $k_B(d)\ge4d$ would give unboundedness directly, and it is not what is typed |
| transfer_not_order | some $T:\mathbb Q\to\mathbb Q$ with $P=\mathrm{True}$ preserved sends $1\ge0$ to $-1$ | A toy with $T=-x$. The exhibit's $G(I_5)=-\tfrac54$ is not typed |
| conditional_of_free | $Q\to(P\to Q)$ | Tautology |

No declaration mentions $\mathcal W_n$, forms, $O(n)$, $B_n$, invariance, extension, Proposition 2.9 or $k_B$. Binders are natural numbers and rationals only. The lemma's existence, uniqueness and $SO$ clauses, and the bound $k_B(d)\ge4d$, are untyped. Four declarations refer to a "support cap $2d$" that Passage A does not contain, which reads as left over from an earlier version. The file was not compiled.

## 11. The standing list

1. **Hypotheses.** Section 1. Unused: $d\ge1$. Used but unstated: a convention for $k_B(d)$ when no finite presentation exists, the FFT citation, and an existence argument for $SO$.
2. **Quantifier order and scope.** Part 1: for all $F$ and all $n\ge n_0$ there exists $G$, and the $a_\pi$ chosen at $n_0$ serve every $n$ at once. Part 2: for all $n\ge n_0\ge k_B(d)$, uniqueness, which makes $G$ independent of the choice of $a_\pi$. The order is correct. The $SO$ clause's scope over part 1 is the defect of section 4.
3. **Edges.** $n=n_0$: $G=\sum a_\pi C^{(n_0)}_\pi=F$ and uniqueness is trivial. $d=1$: the only $O(n_0)$-invariant linear form on $\mathcal W_{n_0}$ is $0$ (every contraction of four slots of $W$ is a trace), so $F=0$ and $G=0$, and section 7a shows uniqueness at every $n_0$. $\mathcal W_n=0$ for $n\le3$: part 1 holds with $F=G=0$ available, and part 2 cannot reach $n_0\le3$ because $k_B(d)\ge4$. $\ker W\ne0$ at a padded object: step (ii) uses exactly that all components with an index above $n_0$ vanish, and the phrase "a sign only on the padded copy" concerns these objects and their $O(n)$-orbit, where $G$ takes the values of $F$. No finding.
4. **Proven versus used.** Part 2 is proven under $n_0\ge k_B(d)$ and used only conditionally, with the scope paragraph stating that no instance exists. The $O$ result is not stretched to $SO$ by the proof, only by the unsupported clause.
5. **Lean.** Section 10.

**Traps by name.** $\ker W\ne0$: item 3, no finding. Range boundaries: item 3 and section 7a. Subfamily used in general: item 4. Hypothesis stated but unused: $d\ge1$. Used but unstated: section 1. Universal claim with no witness: the $SO$ clause, broken by a self-dual element of $\mathcal W_4$ (section 4). Structured families: the diagonal family $W^D$ has $F(W^D)=0$ (its $M$ is diagonal and $S$ has zero diagonal, so $\mathrm{tr}(SM^2)=0$) and cannot witness alone, the padded family is the object of step (ii), and a self-dual Weyl tensor (the family containing $\mathbb{CP}^2$'s, with $W^-=0$) is where the $SO$ form is nonzero, which is why $W^D+T$ was used. Sphere products were not needed. Imported theorems with unchecked hypotheses: Proposition 2.9, Theorem 2.11 and Example 2.12 were checked (sections 2, 3, 8), and the FFT is uncited but its hypotheses hold.

**Brief items 1 to 12 by number.** 1: section 2. 2: section 3, step (i). 3: section 3, step (ii). 4: section 3, step (iii). 5: section 4. 6: section 5. 7: section 6. 8: section 7. 9: section 8. 10: section 9. 11: section 10. 12: standing item 3 above, with section 7a.

## 12. What would break it

- **The $O$ lemma, part 1**: an $O(n_0)$-invariant form whose FFT expansion needs a contraction depending on $n$ off the tensor. Every complete contraction of $W^{\otimes d}$ joins slots only, so none exists. I read step (ii) against the definition of $C_\pi^{(m)}$ and found nothing.
- **Part 2**: a module in which Proposition 2.9's one-step maps fail to compose to restriction, or a presentation degree smaller than the level where injectivity starts. The composite is restriction by section 2, and Proposition 2.9 was read at source.
- **The $SO$ clause**: an $SO(n_0)$-invariant, non-$O(n_0)$-invariant form. Found at $n_0=4$, $d=2$ (section 4). It breaks existence at every $n\ge5$.
- **The bound**: a combination of translates of padded low-support elements with a component on $4d$ distinct indices. Impossible by support counting (section 5).

At commit time a sibling's report, verification/VERIFY_v386.md, was staged in the shared index. It was left alone and not read, and this commit is restricted by pathspec to this report.

## 13. Verdict

**PROVEN, hypotheses corrected.** The $O(n_0)$ lemma holds as written: existence at every $n\ge n_0$ and uniqueness of the $B_n$-invariant extension when $n\ge n_0\ge k_B(d)$, with $k_B(d)\ge4d$ and the $\mathrm{Sym}^2S^n$ exhibit exact. The correction is to the $SO$ clause in Passage A and in Passage B's detail statement. It holds only with the added hypothesis that $F$ is $O(n_0)$-invariant, which makes it the $O$ case. As written it is false: $F(W)=\sum\varepsilon_{ijkl}W_{klpq}W_{pqij}$ on $\mathcal W_4$ has no $SO(5)$-invariant extension. Minor items: Passage C's "at all" is HYPOTHESIS-DEBT, "below the range, uniqueness fails" should read "can fail", the $k_B(d)=\infty$ convention should be stated, and L64.lean types arithmetic only.

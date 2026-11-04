# Verifier v387, Lemma L64 (the transfer mechanism): setting, parts 1 and 2, the SO clause, the bound k_B(d) >= 4d, the n_0=3 edge, the Sym^2 S^n exhibit, Passages B, C and E

The brief ([BRIEF_L64r2.md](BRIEF_L64r2.md)) was cold, and this report works from its definitions and from Levin and Chandrasekaran read at source ([paper.pdf](https://arxiv.org/abs/2307.04230) pages 13 and 15 to 18, Appendix A of [txt.txt](https://arxiv.org/abs/2307.04230)). No numerical work was done and every value below is exact. No scripts were written and no computation was run, the Lean file included. The log is [agent_logs/verify-L64-v387.log](../agent_logs/verify-L64-v387.log).

| # | Claim attacked | Verdict | Reason |
|---|---|---|---|
| 1 | Setting: $\{\mathrm{Sym}^d\mathcal W_n^*\}$ is a consistent sequence and a $V$-module over $\{\mathbb R^n\}$ with $\{B_n\}$ | CONFIRMED | padding preserves the Weyl conditions, the embedding is $\varphi^{\otimes d}$ and its adjoint is restriction of a polynomial to the padded copy |
| 2 | Step (i), the FFT expansion $F=\sum_\pi a_\pi C^{(n_0)}_\pi$ | CONFIRMED | FFT spanning holds at every $n_0$, the $a_\pi$ need not be unique and nothing later uses uniqueness |
| 3 | Step (ii) and part 1 (O version) | CONFIRMED | every contraction index sits on a $W$ slot, so each term with an index above $n_0$ vanishes on a padded tensor |
| 4 | Step (iii) and part 2 (O version) | CONFIRMED | Proposition 2.9 at each level $n_0,\dots,n-1\ge k$ composes to an injection on invariants, and $G$ is $O(n)$-, hence $B_n$-invariant |
| 5a | SO clause applied to part 1 | REFUTED AS STATED | at $n_0=4$, $d=2$, $n=5$ the SO(4)-invariant $F(W)=\sum\varepsilon_{ijkl}W_{abij}W_{abkl}$ has no SO(5)-invariant extension |
| 5b | SO clause applied to part 2 (existence half of "exactly one") | HYPOTHESIS-DEBT | the reflection sentence proves only the conditional, and no argument shows SO($n_0$)-invariant forms are O($n_0$)-invariant at $n_0\ge k_B(d)$ |
| 6 | $k_B(d)\ge g(d)\ge4d$, so $k_B(6)\ge24>12$ | CONFIRMED | $T\in\mathcal W_4$, the block product has a component with $4d$ distinct indices, and signed permutations preserve the count of distinct indices |
| 7 | "No finite $k_B(d)$ is on file" and Passage C | CONFIRMED | a statement about the record, consistent with the lemma, which is conditional on $k_B(d)$ |
| 8 | Below the range uniqueness fails ($n_0=3$, $d=2$) | CONFIRMED | $3<8\le k_B(2)$ and $0$, $\lvert W\rvert^2$ are distinct $B_n$-invariant extensions of $F=0$ |
| 9 | The $\mathrm{Sym}^2S^n$ exhibit | CONFIRMED | presented in degree $(2-1)\cdot2+2=4$, $F=\mathop{\mathrm{tr}}((X-\tfrac14\mathop{\mathrm{tr}}X\,I_4)^2)$, $G(I_5)=-\tfrac54$ |
| 10 | Passages B and C against A | REFUTED AS STATED | Passage B's detail carries the SO clause unconditionally over part 1, the other differences are harmless |
| 11a | Passage E states Lemma L64 | REFUTED | no declaration mentions $\mathcal W_n$, a form, a group, an extension or a presentation degree |
| 11b | Passage E's declarations as arithmetic | CONFIRMED AS ALGEBRA | each is a true statement about $\mathbb N$ or $\mathbb Q$ |
| 12 | Boundary: $n=n_0$, $d=1$, $n_0\le3$, padded $W$ with $\ker W\ne0$ | CONFIRMED | each edge closes, and the padded case is exactly where the lemma carries information |

**Summary: parts 1 and 2 of Lemma L64 over $O$ are proven as written, and the SO clause must be cut back to the conditional the reflection sentence actually proves ("an SO($n_0$)-invariant form with a $B_n$-invariant extension is O($n_0$)-invariant"), since as stated for part 1 it fails at $n_0=4$, $d=2$, $n=5$.**

## 0. Conventions, fixed once

Quoted from the brief:

- $\mathcal W_n$ is the space of algebraic Weyl tensors on $\mathbb R^n$: 4-tensors with the curvature symmetries $W_{ijkl}=-W_{jikl}=-W_{ijlk}=W_{klij}$, the first Bianchi identity $W_{ijkl}+W_{iklj}+W_{iljk}=0$, and every Ricci contraction zero, with the Frobenius inner product. $\mathcal W_n=0$ for $n\le3$.
- $O(n)$, and its subgroups $SO(n)$ and the signed permutation group $B_n$, act on $\mathcal W_n$ by $(g\cdot W)_{ijkl}=g_{ia}g_{jb}g_{kc}g_{ld}W_{abcd}$. Zero-padding sends $W\in\mathcal W_{n_0}$ to the tensor on $\mathbb R^n$ with the same components on indices in $[n_0]$ and zero elsewhere.
- $\mathrm{Sym}^d\mathcal W_n^*$ is the space of homogeneous polynomials of degree $d$ on $\mathcal W_n$. $S^n$ is the space of real symmetric $n\times n$ matrices.

From the source, Section 1.3 and Section 2.3: $\mathrm{Sym}^kV$ is identified with the polynomials of degree $k$ on $V$ and with the symmetric $k$-tensors, the sequence $\mathrm{Sym}^k\mathcal V$ has embeddings $\varphi_n^{\otimes k}$, and $\mathcal P_{U_n}=\varphi_n^*$ is the orthogonal projection. Below, "restriction" of a form $p$ on $\mathcal W_n$ means $p\circ\mathrm{pad}$ on $\mathcal W_{n_0}$.

## 1. Hypothesis inventory

**The statement's hypotheses.**

| Hypothesis | Where used | Status |
|---|---|---|
| $d\ge1$ | only in the scope bullet $k_B(d)\ge4d$ | stated, unused by the proof, harmless (every step also closes at $d=0$) |
| $n_0\in\mathbb N$, unrestricted in part 1 | step (i) at every $n_0$ | used, and "no hypothesis on $n_0$ enters" is correct |
| $F$ an $O(n_0)$-invariant degree-$d$ form on $\mathcal W_{n_0}$ | step (i), invariance of $F\circ\pi_{n_0}$ and hence of its polarisation | used |
| $n\ge n_0$ | step (ii), padding $\mathcal W_{n_0}\subseteq\mathcal W_n$ | used |
| $n_0\ge k_B(d)$ (part 2) | step (iii), Proposition 2.9 at levels $n_0,\dots,n-1$ | used |
| Zero-padding is an isometric embedding $\mathcal W_{n_0}\to\mathcal W_n$ | setting, step (ii), step (iii) | asserted without argument, checked in Section 2 below |
| $g(d)$, the generation degree | only in the scope bullet | stated, used there only |

**Imported: Definition 1.3 (consistent sequence).** Needs compact nested groups, orthogonal representations, equivariant isometric embeddings. Checked against $\{\mathrm{Sym}^d\mathcal W_n^*\}$ with $B_n\subseteq B_{n+1}$ by $g\mapsto\mathrm{blkdiag}(g,1)$: holds (Section 2).

**Imported: Definition 2.5 ($V$-module).** Needs $U_m\subseteq U_n^{H_{n,m}}$, where $H_{n,m}\subseteq B_n$ fixes $e_1,\dots,e_m$. Checked: holds (Section 2).

**Imported: Definition 2.7 (presentation degree).** The smallest $k$ admitting an algebraically free $F\to U$ generated in degree $\le k$ with kernel generated in degree $\le k$. Defined only when some presentation exists. The record gives no value and no finiteness claim, and part 2 is conditional, so the reading $k_B(d)=+\infty$ when none exists makes part 2 vacuous and leaves every other sentence true. No finding.

**Imported: Proposition 2.9.** Hypotheses: $V$ a consistent sequence, $U$ a $V$-module presented in degree $k$. Conclusion: $\mathcal P_{U_n}:U_{n+1}^{G_{n+1}}\to U_n^{G_n}$ is an isomorphism for all $n\ge k$. Checked against the object in Section 4. Note from the source: Proposition 2.9's proof takes injectivity from Proposition 2.3, which needs only generation in degree $k$. Step (iii) uses only injectivity, so the hypothesis $n_0\ge k_B(d)$ is stronger than the step consumes. This does not affect correctness, and the scope bullet bounds $g(6)\ge24$ anyway, so the $n_0=12$ conclusion survives either reading.

**Imported: Theorem 2.11 (Sym clause) and Example 2.12.** Used only in the exhibit. Hypotheses: $V=\{\mathbb R^n\}$ with $G_n\in\{B_n,D_n,S_n\}$, $\mathcal W$ a $V$-module generated in degree $d_W$, presented in degree $k_W$. Checked in Section 9.

**Imported: the first fundamental theorem for $O(m)$.** Classical, cited by name, not quoted in the brief. Used as: every $O(m)$-invariant linear functional on $(\mathbb R^m)^{\otimes 2p}$ is a combination of complete contractions along perfect matchings, for every $m$. That spanning statement holds at every $m$ (relations at small $m$ belong to the second fundamental theorem). The proof uses only spanning.

**Unstated hypothesis found in use.** The SO clause's existence half needs "every SO($n_0$)-invariant degree-$d$ form on $\mathcal W_{n_0}$ is O($n_0$)-invariant". It is stated nowhere and is false at $n_0=4$, $d=2$ (Section 5).

## 2. Brief item 1: the setting against Definitions 1.3 and 2.5

**Padding lands in $\mathcal W_n$.** For $W\in\mathcal W_{n_0}$, the padded tensor has the curvature symmetries and the Bianchi identity componentwise. Its Ricci contraction $\sum_{b\in[n]}W_{abcb}$ vanishes for $a,c\in[n_0]$ because the terms $b>n_0$ are zero and the rest is the Ricci contraction of $W$, and vanishes for $a$ or $c>n_0$ because every term is zero. Padding preserves the Frobenius norm. It commutes with $\mathrm{blkdiag}(g,1)$ for $g\in B_{n_0}$ (indeed for $g\in O(n_0)$).

**The sequence of forms.** By source Section 2.3, $\mathrm{Sym}^d$ of a consistent sequence is consistent, with embedding $\varphi^{\otimes d}$ on symmetric tensors. Identifying a symmetric tensor $s\in\mathrm{Sym}^d\mathcal W_m$ with $p_s(X)=\langle s,X^{\otimes d}\rangle$, the embedding sends $p_s$ to $p_s\circ P$ with $P:\mathcal W_n\to\mathcal W_m$ the orthogonal projection, and its adjoint sends $p_t$ on $\mathcal W_n$ to $X\mapsto\langle\varphi^{*\otimes d}t,X^{\otimes d}\rangle=\langle t,(\varphi X)^{\otimes d}\rangle=p_t(\mathrm{pad}\,X)$. So $\mathcal P_{U_m}$ is restriction to the padded copy, which is the map step (iii) needs. The record does not name the embedding of forms, but the only one satisfying Definition 1.3 through Section 2.3 is this one, and the proof uses only its adjoint.

**$V$-module.** $H_{n,m}\subseteq B_n$ is the set of signed permutations fixing $e_1,\dots,e_m$. An element of $U_m$ embedded in $U_n$ is a symmetric tensor all of whose nonzero components have every index in $[m]$, and such a tensor is fixed by $H_{n,m}$. So $U_m\subseteq U_n^{H_{n,m}}$.

**No finding.** The setting is well posed, and $k_B(d)$ is well defined whenever a presentation exists (Section 1 for the other case).

## 3. Brief item 2: step (i)

- $\mathcal W_{n_0}$ is an $O(n_0)$-invariant subspace of the orthogonal representation $(\mathbb R^{n_0})^{\otimes4}$, so its orthogonal projection $\pi_{n_0}$ is $O(n_0)$-equivariant.
- $F\circ\pi_{n_0}$ is $O(n_0)$-invariant of degree $d$, and its polarisation is a symmetric $d$-linear invariant form on $((\mathbb R^{n_0})^{\otimes4})^d$, a linear invariant functional $\Phi$ on $(\mathbb R^{n_0})^{\otimes4d}$ with $\Phi(X^{\otimes d})=F(\pi_{n_0}X)$.
- FFT spanning gives $\Phi=\sum_\pi a_\pi\,\mathrm{contr}_\pi$. For $W\in\mathcal W_{n_0}$, $F(W)=\Phi(W^{\otimes d})=\sum_\pi a_\pi C^{(n_0)}_\pi(W)$.
- Small $n_0$: spanning holds at every $n_0$. For $n_0\le3$, $\pi_{n_0}=0$ and $F=0$, and any $a_\pi$ representing $\Phi=0$ is admissible.
- Uniqueness of $a_\pi$: fails at small $n_0$ (contractions satisfy relations). Step (ii) fixes one choice and step (iii) never compares choices, so nothing needs it.

**No finding.**

## 4. Brief items 3 and 4: step (ii), step (iii), parts 1 and 2

**Step (ii).** $C^{(n)}_\pi$ is a polynomial on $(\mathbb R^n)^{\otimes4}$, restricted to $\mathcal W_n$, and is $O(n)$-invariant because a complete contraction of $W^{\otimes d}$ is. "No closed $\delta$-loop" means every summation index is shared by two slots of $W$ factors, with no free trace $\delta_{ii}$ that would sum to $n$. That is exactly what the restriction needs: $C^{(n)}_\pi(\mathrm{pad}\,W)=\sum_{\text{indices}\in[n]}\prod W_{\cdots}$, and every term with an index above $n_0$ contains a zero component, so the sum equals $C^{(n_0)}_\pi(W)$. Hence $G(\mathrm{pad}\,W)=F(W)$. Part 1 follows. **No finding.**

**Step (iii).** For $n\ge n_0\ge k$, where $U$ is presented in degree $k=k_B(d)$, Proposition 2.9 makes each $\mathcal P_{U_m}:U_{m+1}^{B_{m+1}}\to U_m^{B_m}$ an isomorphism for $m=n_0,\dots,n-1$, all $\ge k$. The composite is restriction from $\mathcal W_n$ to $\mathcal W_{n_0}$ (Section 2), and it is injective. $G$ is $O(n)$-invariant, so $B_n$-invariant. If $G'$ is another $B_n$-invariant extension, $G-G'$ lies in $U_n^{B_n}$ and restricts to $0$, so $G=G'$. Every $O(n)$-invariant extension is $B_n$-invariant, so it equals $G$, which justifies "the $O(n)$-invariant extension of part 1". At $n=n_0$ the composite is the identity. **No finding.**

## 5. Brief item 5: the SO clause

### 5.1 Candidate A, part 1 with SO in place of O (clears all three steps, reported)

1. **Locate.** Passage A: "The same holds with $SO$ in place of $O$, because $B_{n_0}$ contains the reflection $\mathrm{diag}(-1,1,\dots,1)$". Passage B detail: "Then for every $n\ge n_0$, $F$ has an $O(n)$-invariant extension to $\mathcal W_n$, and when ... The same holds with $SO$ in place of $O$." Read over part 1 this asserts: every SO($n_0$)-invariant degree-$d$ form on $\mathcal W_{n_0}$ has an SO($n$)-invariant extension for every $n\ge n_0$. The step it needs and lacks is O($n_0$)-invariance of $F$, since step (i) applies the FFT for $O(n_0)$.
2. **Exhibit.** Take $n_0=4$, $d=2$, $n=5$ and $F(W)=\sum_{a,b,i,j,k,l}\varepsilon_{ijkl}W_{abij}W_{abkl}$ on $\mathcal W_4$.
   - $F$ is SO(4)-invariant, because summing over $a,b$ absorbs $g^\top g=I$ and $\varepsilon_{ijkl}g_{ii'}g_{jj'}g_{kk'}g_{ll'}=\det g\,\varepsilon_{i'j'k'l'}$.
   - With $r=\mathrm{diag}(-1,1,1,1)$, the same computation gives $F(rW)=\det r\,F(W)=-F(W)$.
   - Witness. Let $\omega_1=(e_{12}+e_{34})/\sqrt2$, $\omega_2=(e_{13}+e_{42})/\sqrt2$, $\omega_3=(e_{14}+e_{23})/\sqrt2$ as antisymmetric component arrays, and $W_{ijkl}=\sum_a\lambda_a\,\omega_a(ij)\,\omega_a(kl)$ with $\lambda=(2,-1,-1)$ (the self-dual type of $\mathbb{CP}^2$). Curvature symmetries hold by construction. Bianchi at $(1,2,3,4)$: each $\omega_a$ contributes $\tfrac12$, total $\tfrac12\sum_a\lambda_a=0$, and repeated-index Bianchi sums vanish from the antisymmetries. Ricci: $\sum_j\omega_a(ij)\omega_a(kj)=\tfrac12\delta_{ik}$ for each $a$, so $\mathrm{Ric}=\tfrac12(\sum_a\lambda_a)\delta=0$. So $W\in\mathcal W_4$.
   - Each $\omega_a$ is self-dual: $\tfrac12\sum_{kl}\varepsilon_{ijkl}\omega_a(kl)=\omega_a(ij)$, checked at $(12)$, $(13)$, $(14)$ and their complements. Hence $\sum_{kl}\varepsilon_{ijkl}W_{abkl}=2W_{abij}$ and $F(W)=2\lvert W\rvert^2$. The components of distinct $\omega_a$ have disjoint supports with $\sum_{ij}\omega_a(ij)^2=2$, so $\lvert W\rvert^2=4\sum_a\lambda_a^2=24$ and $F(W)=48$, $F(rW)=-48$.
   - Suppose $G$ on $\mathcal W_5$ is SO(5)-invariant with $G\circ\mathrm{pad}=F$. The element $h=\mathrm{diag}(-1,1,1,1,-1)$ has $\det h=1$, and on a padded tensor (every component with index $5$ zero) $h\cdot\mathrm{pad}\,X=\mathrm{pad}(rX)$. Then $-48=F(rW)=G(h\cdot\mathrm{pad}\,W)=G(\mathrm{pad}\,W)=F(W)=48$, a contradiction. The same $h=\mathrm{diag}(-1,1,\dots,1,-1)$ works at every $n>4$.
3. **Argue the opposite.** The most charitable reading is that "the same" governs part 2 only, since the justifying sentence speaks of a $B_n$-invariant extension. Passage A's placement after both items and Passage B's sentence, which follows the part 1 clause "for every $n\ge n_0$" with no restriction, both carry the clause over part 1. The charitable reading survives for Passage A and is handled as Candidate B, and it cannot be given to Passage B's wording. **Reported: REFUTED AS STATED.**

**What the reflection sentence does prove, confirmed.** If an SO($n_0$)-invariant $F$ has a $B_n$-invariant extension $G'$, then $F(rX)=G'(\mathrm{pad}\,rX)=G'(\mathrm{blkdiag}(r,1)\,\mathrm{pad}\,X)=F(X)$, and SO($n_0$) with $r$ generates O($n_0$). That conditional is correct and is the form the clause should take.

### 5.2 Candidate B, part 2 with SO in place of O (reported as debt)

1. **Locate.** Under the charitable reading, the clause asserts: for $n\ge n_0\ge k_B(d)$, an SO($n_0$)-invariant $F$ has exactly one $B_n$-invariant extension. "Exactly one" has an existence half.
2. **Exhibit.** The written argument gives only "at most one, and if one exists then $F$ is O($n_0$)-invariant". Existence for an SO-but-not-O-invariant $F$ is false wherever such an $F$ exists (Section 5.1 shows none can have even an SO($n$)-invariant extension). The exhibit of 5.1 sits at $n_0=4<8\le k_B(2)$, outside part 2's range, so it does not refute this reading. No closed-form object inside the range was exhibited.
3. **Argue the opposite.** The claim holds inside the range if every SO($n_0$)-invariant degree-$d$ form on $\mathcal W_{n_0}$ is O($n_0$)-invariant whenever $n_0\ge k_B(d)$. No such argument is in the passages. **HYPOTHESIS-DEBT: what would have to be proved is that SO($n_0$)-invariant forms of degree $d$ on $\mathcal W_{n_0}$ are O($n_0$)-invariant for $n_0\ge k_B(d)$, or else the clause restated as the conditional of 5.1.**

## 6. Brief item 6: $k_B(d)\ge g(d)\ge4d$

- **$T\in\mathcal W_4$.** The three curvature-symmetry orbits of multi-indices with distinct entries correspond to the pair partitions $\{12|34\}$, $\{13|24\}$, $\{14|23\}$, so the assignments $a=T_{1234}=1$, $b=T_{1342}=-1$, $c=T_{1423}=0$ are independent. With all indices distinct, every Bianchi sum reduces to $\pm(a+b+c)$ (checked at $i=1$ and $i=2$: $T_{2134}+T_{2341}+T_{2413}=-a-c-b$), and $a+b+c=0$. Repeated-index Bianchi sums vanish from the antisymmetries. Every Ricci component $\sum_bT_{abcb}$ has a repeated index, so it is zero. $T\ne0$.
- **The block product.** $T_k$, the translate of padded $T$ to block $\{4k-3,\dots,4k\}$, lies in $\mathcal W_{4d}$ (a permutation of padded $T$). The form $\prod_k\langle T_k,\cdot\rangle$ lies in $U_{4d}$, and as a symmetric tensor $T_1\odot\cdots\odot T_d$ its component at $(1,2,\dots,4d)$ is $\tfrac1{d!}$, because only the identity ordering of factors meets each block. Nonzero, with $4d$ distinct index values.
- **Support.** A padded element of $U_m$ has every nonzero component at a multi-index with at most $m$ distinct values. A signed permutation sends the component at $I$ to $\pm$ the component at $\sigma^{-1}(I)$, which has the same number of distinct values. So every element of $\mathbb R[B_{4d}]U_m$ vanishes at $(1,\dots,4d)$ when $m<4d$, and $U$ is not generated in degree $m$ (Definition 2.2 fails at $n=4d$). Hence $g(d)\ge4d$.
- **$k_B\ge g$.** The source's note after Definition 2.7. So $k_B(6)\ge24>12$.

**No finding.** The phrase "maps a support of size $m$ to a support of size $m$" is loose, and the per-multi-index count above is what makes it exact.

## 7. Brief item 7: "no finite $k_B(d)$ is on file" and Passage C

- The sentence reports the state of the record. The lemma is conditional on $k_B(d)$, so the sentence does not bear on its correctness. **No finding.**
- Passage C's kernel clause reading checks against Theorem 2.11 as printed. With $A_n=\mathrm{Ric}$ (a morphism, since Ricci commutes with padding), $A^*$ is a morphism iff $A^*_{n+1}\varphi=\varphi A^*_n$, iff (taking adjoints) $\varphi^*A_{n+1}=A_n\varphi^*$, and $\varphi^*$ on $(\mathbb R^n)^{\otimes4}$ is componentwise truncation. Ricci does not commute with truncation because $\sum_{b\le n+1}$ includes $b=n+1$. Confirmed.
- Passage C's sums clause sentence ("holds only for $h\propto I$", the round sphere remark) has no argument in the passages. It is supporting commentary, it is not used by the lemma, and the Sums clause of Theorem 2.11 bounds a direct sum from its summands, which is the direction Passage C says fails to help.
- Remark for the round: the source also states Noetherianity for FI$_{BC}$-modules (Theorem A.5). Passage C does not consider it. Whether it bears on finiteness of $k_B(d)$ is not argued on file and is outside this check.

## 8. Brief item 8: the $n_0=3$ edge

$3<8\le g(2)\le k_B(2)$, so $n_0=3$ is below the range. $F=0$ on $\mathcal W_3=0$ is a degree-2 form. For $n\ge4$, $0$ and $\lvert W\rvert^2$ are both $O(n)$-, hence $B_n$-invariant, both restrict to $0$ on the zero space, and differ on $\mathcal W_n\ne0$. They are extensions of exactly the kind part 2 counts. **No finding.**

### 8.1 Withdrawn: "Below the range, uniqueness fails" read universally

1. **Locate.** Passage A's bullet head "Below the range, uniqueness fails."
2. **Exhibit.** At $d=1$, $n_0=3<4\le k_B(1)$, uniqueness holds. Screen by hand: a $B_n$-invariant $W\in\mathcal W_n$ must be invariant under every sign flip, so its nonzero components have every index appearing an even number of times, which forces the form $W_{ijij}$. Permutation invariance makes $W_{ijij}=c$ for $i\ne j$, and $\mathrm{Ric}_{ii}=(n-1)c=0$ gives $c=0$. So the only $B_n$-invariant linear form is $0$, and $F=0$ has one extension.
3. **Argue the opposite.** The bullet exhibits a single instance and reads naturally as "can fail". **Withdrawn**, with the suggestion to write "can fail".

## 9. Brief item 9: the $\mathrm{Sym}^2S^n$ exhibit

- **Presentation degree 4.** Source Table 1 gives $S^n=\mathrm{Sym}^2(\mathbb R^n)$. Example 2.12 with $B_n$: generated and presented in degree $2$. Theorem 2.11 (Sym clause, $V=\{\mathbb R^n\}$, $G_n=B_n$, $\ell=2$, $d_W=k_W=2$): $\mathrm{Sym}^2S^n$ is presented in degree $(2-1)\cdot2+2=4$. Confirmed.
- **Identity.** $\mathop{\mathrm{tr}}\big((X-\tfrac t4I_4)^2\big)=\mathop{\mathrm{tr}}X^2-\tfrac t2\,t+\tfrac{t^2}{16}\cdot4=\mathop{\mathrm{tr}}X^2-\tfrac14t^2$ with $t=\mathop{\mathrm{tr}}X$. It is a trace of a square of a symmetric matrix, so $\ge0$. Confirmed.
- **Value.** Padding preserves $\mathop{\mathrm{tr}}X$ and $\mathop{\mathrm{tr}}X^2$, so $G$ restricts to $F$. $G(I_5)=5-\tfrac{25}4=-\tfrac54$. Confirmed. Both contractions are pure slot pairings, so this is the mechanism of steps (i) and (ii), and $n_0=4\ge4$ makes $G$ the unique $B_5$-invariant extension.
- **Conclusion drawn.** The paragraph concludes only that transferring a nonnegativity certificate needs its own argument. The exhibit supports exactly that, on a different module. The reference to "Post F31" and "the degree-6 certificate" points outside the brief and was not checked.

### 9.1 Withdrawn: "carries a sign only on the padded copy"

1. **Locate.** Passage A, final paragraph, and Passage B.
2. **Exhibit.** By $O(n)$-invariance, $G(g\cdot\mathrm{pad}\,W)=F(W)\ge0$ for every $g\in O(n)$, so the sign carries to the whole $O(n)$-orbit of the padded copy, which is larger than the padded copy (for example $W$ supported on indices $\{2,\dots,n_0+1\}$).
3. **Argue the opposite.** "Only" naturally means that the lemma guarantees the sign on no tensor beyond the padded type, and the orbit follows at once from the invariance the lemma states. **Withdrawn.**

## 10. Brief item 10: Passages B and C against Passage A

| Point | A | B | C | Assessment |
|---|---|---|---|---|
| Range of part 1 | $n\ge n_0$, any $n_0$ | same | same | agree |
| Range of part 2 | $n\ge n_0\ge k_B(d)$ | landscape "$n_0\ge k_B(d)$", detail $n\ge n_0\ge k_B(d)$ | "$n_0\ge k_B(d)$" | agree, $n\ge n_0$ implicit |
| SO clause | after both parts, with the reflection reason | landscape omits it, detail states it bare after part 1 | absent | B detail carries the refuted reading (Section 5.1) |
| Bound | $k_B(d)\ge g(d)\ge4d$ | $k_B(d)\ge4d$ | absent | agree |
| Degree-6 at $n_0=12$ | "lies outside its range" | "the lemma does not reach" it | absent | B's "does not reach" is under the hypothesis sentence, so it concerns part 2, part 1 still applies there. Wording only |
| Sign | only on the padded copy | same | absent | agree (Section 9.1) |
| Contractions restrict | "every summation index sits on a slot of a Weyl factor" | "every slot sits on a Weyl factor" | absent | agree |

**Finding: Passage B's detail states the SO clause over part 1 without the conditional, REFUTED AS STATED by Section 5.1.**

## 11. Brief item 11: Passage E against Passage A

- `generation_degree`, `exceeds_twelve`, `six_blocks_support`: $4\cdot6=24$, $12<24$, $6\cdot4=24$. True, and they match the arithmetic of $k_B(6)\ge24>12$.
- `support_cap_at_six`, `counts_disagree`, `support_forces_degree`, `overstatement_factor`: statements about $2\cdot6=12$ and $24\le2d\Rightarrow12\le d$. True, but Passage A's support count is $4d$, and nothing in Passages A to C uses a count of $2d$.
- `indexed_not_scalar`, `unbounded`: about an arbitrary strictly increasing $k:\mathbb N\to\mathbb N$. The proofs close by eye (induction gives $d\le k(d)$). Nothing in the passages asserts $k_B$ is strictly increasing, and $k_B(d)\ge4d$ gives unboundedness without it.
- `transfer_not_order`: $T=-x$, $P=\mathrm{True}$, $x=1$. True and unrelated to $\mathcal W_n$.
- `conditional_of_free`: $Q\to(P\to Q)$, a tautology.
- **What is not typed.** $\mathcal W_n$, forms, $O(n)$, $SO(n)$, $B_n$, padding, the FFT expansion, extension, uniqueness, Proposition 2.9, presentation degree, and the inequality $g(d)\ge4d$. **REFUTED as a statement of L64. CONFIRMED AS ALGEBRA as arithmetic.** The Lean was read, not compiled.

## 12. Brief item 12 and the standing list

**Boundary.**

- $n=n_0$: the extension is $F$, and uniqueness is trivial. Closes.
- $d=1$: every contraction of one $W$ is a trace, so $F=0$ and $G=0$, and the screen in 8.1 shows $0$ is the only $B_n$-invariant linear form for $n\ge4$. Closes, consistent with $g(1)\ge4$ (since $\mathcal W_3=0$).
- $n_0\le3$: $F=0$, part 1 holds with any $a_\pi$, and part 2 is out of range. Closes.
- $\ker W\ne0$: every padded $W$ annihilates $e_{n_0+1},\dots,e_n$. Step (ii) uses exactly this vanishing, and the lemma makes no claim at a $W$ of full rank. **No finding.**

**Quantifier order and scope.** Part 1 is "for all $F$, for all $n\ge n_0$, there exists $G$", and the construction of $G$ depends on $F$ and a choice of $a_\pi$ only, not on $n$ beyond the summation range. Part 2 is "for all $n\ge n_0\ge k_B(d)$, for all $F$, at most one $B_n$-invariant extension, and $G$ is one". **No finding.**

**Subfamily used in general.** Step (i) is applied at all $n_0$ and step (iii) at all levels $\ge k$, so no step is proven on a subfamily. The one generalisation beyond what is proven is the SO clause (Section 5). **Finding recorded there.**

**Universal claims and witnesses.** Part 1 screened on $F=\lvert W\rvert^2$ at $n_0=4$ ($G=\lvert W\rvert^2$ restricts correctly), on the $\mathrm{Sym}^2S^n$ analogue, and at $d=1$. The SO clause was tested on a $\mathbb{CP}^2$-type self-dual Weyl tensor and failed. Diagonal, padded and sphere-product objects enter only through the sign remark, which the lemma does not assert beyond the padded copy.

**Imported theorems whose hypotheses were never checked.** Proposition 2.9 and Theorem 2.11 are checked in Sections 2, 4 and 9. The FFT is classical and used only for spanning. **No finding.**

**Sibling files.** `git status` showed a clean index when this report was staged. No sibling file was touched.

## 13. What would break it

- **Parts 1 and 2 over $O$.** A break needs a non-pairing $O(n_0)$-invariant functional (none exists by the FFT), a contraction whose restriction picks up an $n$-dependent factor (impossible without a $\delta$-trace, and none arises from a pairing of $W$ slots), or a level $m\ge k$ at which restriction on invariants is not injective (excluded by Proposition 2.9). I looked at $n_0\le3$, $d=1$, $n=n_0$ and at non-uniqueness of $a_\pi$, and none breaks it.
- **SO clause.** Broken by any SO($n_0$)-invariant, non-O($n_0$)-invariant form, exhibited at $n_0=4$, $d=2$. Inside part 2's range, what would break the SO reading is such a form at some $n_0\ge k_B(d)$. I did not search for one, since that would mean building invariant theory the proof does not use.
- **$g(d)\ge4d$.** Broken only if the block-product component could be produced from level $m<4d$, which the distinct-index count excludes.

## 14. Verdict

**PROVEN, hypotheses corrected.** Parts 1 and 2 over $O(n_0)$, the bound $k_B(d)\ge g(d)\ge4d$, the $n_0=3$ edge and the $\mathrm{Sym}^2S^n$ exhibit are proven as written. The SO clause must be restated as the conditional "an SO($n_0$)-invariant form with a $B_n$-invariant extension is O($n_0$)-invariant, so the SO case reduces to the O case", equivalently the hypothesis "F is O($n_0$)-invariant" restored, in both Passage A and Passage B's detail. The Lean file formalises none of the lemma.

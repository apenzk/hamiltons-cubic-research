# Verifier v386, Lemma L64 (the transfer mechanism): existence, uniqueness, the SO clause, the bound k_B(d) ≥ 4d, the n0 = 3 edge, the Sym²Sⁿ exhibit, Passages B, C and E

The brief ([BRIEF_L64r2.md](BRIEF_L64r2.md)) was cold and this check worked from its definitions and from Levin and Chandrasekaran at source ([paper.pdf](https://arxiv.org/abs/2307.04230), [txt.txt](https://arxiv.org/abs/2307.04230), Definitions 1.3, 2.2, 2.4 to 2.7, Propositions 2.3 and 2.9 with the proof of 2.9, Theorem 2.11, Example 2.12). No numerical work was done, every value below is exact, no scripts were written and nothing was compiled. Hand screens on constructed objects are labelled as screens. The log is [agent_logs/verify-L64-v386.log](../agent_logs/verify-L64-v386.log).

| # | Claim attacked | Verdict | Reason |
|---|---|---|---|
| 1 | Setting: {Sym^d 𝒲_n^*} with padding is a consistent sequence of B_n-representations and a V-module over {ℝⁿ} | CONFIRMED | padded 𝒲_d is fixed by H_{n,d}, the induced embedding is an equivariant isometry and its adjoint is restriction of forms |
| 2 | Part 1, existence of an O(n)-invariant extension, every n ≥ n0 | CONFIRMED | steps (i) and (ii) close at every n0, the coefficients a_π need not be unique and nothing uses uniqueness |
| 3 | Part 2, uniqueness for n ≥ n0 ≥ k_B(d) | CONFIRMED | Proposition 2.9 at adjacent levels composes to injectivity of restriction from level n to level n0, conditional on k_B(d) finite |
| 4 | The SO clause, part 1 ("the same holds with SO in place of O") | REFUTED AS STATED | at n0 = 4, d = 2, n = 5 the SO(4)-invariant form ε_{abcd}W_{abef}W_{cdef} has no SO(5)-invariant extension |
| 5 | The SO clause, part 2 | REFUTED AS STATED | by the record's own reflection sentence an SO(n0)-invariant F that is not O(n0)-invariant has zero B_n-invariant extensions, so "exactly one" holds only in the O case |
| 6 | The reflection sentence itself | CONFIRMED AS ALGEBRA | a B_n-invariant extension is invariant under diag(−1,1,…,1), which acts on the padded copy as the O(n0) reflection |
| 7 | k_B(d) ≥ g(d) ≥ 4d, hence k_B(6) ≥ 24 > 12 | CONFIRMED | T ∈ 𝒲_4, the block product has a component on 4d distinct indices, signed permutations preserve the number of distinct index values |
| 8 | "No finite k_B(d) is on file" (Passage A) | CONFIRMED | a statement of record status, consistent with Passages A to C |
| 9 | "Theorem 2.11's calculus yields no k_B here at all" (Passage C) | HYPOTHESIS-DEBT | the argument rules out the kernel-of-Ric route and the sums route, and says nothing of the image clause or any other construction |
| 10 | n0 = 3, d = 2: 0 and \|W\|² both extend F = 0 | CONFIRMED | 𝒲_3 = 0 and 3 < 8 ≤ k_B(2), both forms are O(n)- and B_n-invariant and differ for n ≥ 4 |
| 11 | Sym²Sⁿ exhibit: presented in degree 4, F = tr((X − ¼ tr X I_4)²) ≥ 0, G(I_5) = −5/4 | CONFIRMED | Example 2.12 gives degree 2 for Sⁿ, the Sym clause with ℓ = 2 gives (2−1)·2 + 2 = 4, the identity and value check exactly |
| 12 | Passage E states the lemma | REFUTED AS STATED | no declaration mentions 𝒲_n, O(n), B_n, a form, an extension or a presentation degree, and four declarations record numbers (2·6 = 12, 24 = 2·12) that match no line of Passage A |

**Summary: the O(n) lemma is proven as written (existence unconditionally, uniqueness conditional on a finite k_B(d) ≤ n0), but the sentence "The same holds with SO in place of O" is false for part 1 at n0 = 4, d = 2, n = 5 and must be deleted from Passages A and B or restricted to SO(n0)-invariant forms that are also O(n0)-invariant, which is the O case.**

## 0. Conventions, fixed once

Quoted from the brief:

- "$\mathcal W_n$ is the space of algebraic Weyl tensors on $\mathbb R^n$: 4-tensors with the curvature symmetries $W_{ijkl}=-W_{jikl}=-W_{ijlk}=W_{klij}$, the first Bianchi identity $W_{ijkl}+W_{iklj}+W_{iljk}=0$, and every Ricci contraction zero, with the Frobenius inner product. $\mathcal W_n=0$ for $n\le3$."
- "$O(n)$, and its subgroups $SO(n)$ and the signed permutation group $B_n$, act on $\mathcal W_n$ by $(g\cdot W)_{ijkl}=g_{ia}g_{jb}g_{kc}g_{ld}W_{abcd}$. Zero-padding sends $W\in\mathcal W_{n_0}$ to the tensor on $\mathbb R^n$ with the same components on indices in $[n_0]$ and zero elsewhere."
- "$\mathrm{Sym}^d\mathcal W_n^*$ is the space of homogeneous polynomials of degree $d$ on $\mathcal W_n$. $S^n$ is the space of real symmetric $n\times n$ matrices."

Notation used below for elements of $\mathcal W_4$. Write a curvature-type 4-tensor on $\mathbb R^4$ as a symmetric matrix $M$ on $\Lambda^2\mathbb R^4$ in the basis $e_{12},e_{13},e_{14},e_{23},e_{24},e_{34}$, with $M(e_{ab},e_{cd})=W_{abcd}$. Let $D(x,y,z)$ be diagonal with $x$ at $12,34$, $y$ at $13,24$, $z$ at $14,23$. Let $J_1,J_2,J_3$ be the symmetric matrices with $1$ at the off-diagonal pairs $(12,34)$, $(13,24)$, $(14,23)$ respectively. Put $M=D(x,y,z)+aJ_1+bJ_2+cJ_3$, so $W_{1234}=a$, $W_{1324}=b$, $W_{1423}=c$. A hand check gives: the repeated-index Bianchi identities hold automatically from the pair symmetries, the distinct-index Bianchi identity is $W_{1234}+W_{1342}+W_{1423}=a-b+c=0$, the off-diagonal Ricci components vanish because $W_{iaib}$ with $a\ne b$ needs $\{i,a\}$ and $\{i,b\}$ to be complementary pairs, and the diagonal Ricci components all equal $x+y+z$. So $M\in\mathcal W_4$ exactly when $x+y+z=0$ and $a-b+c=0$.

## 1. Hypothesis inventory

**The statement (Passage A).**

| Hypothesis | Where stated | Used by |
|---|---|---|
| $d\ge1$ | Setting | nowhere essential (at $d=0$ every step still closes) |
| $F$ is $O(n_0)$-invariant, homogeneous of degree $d$ on $\mathcal W_{n_0}$ | Lemma | step (i) (FFT needs invariance of $F\circ\pi_{n_0}$), step (iii) ($F$ is $B_{n_0}$-invariant) |
| $n\ge n_0$ | parts 1 and 2 | step (ii) (padding goes upward), step (iii) |
| $n_0\ge k_B(d)$ | part 2 | step (iii) only, via Proposition 2.9 |
| $k_B(d)$ finite | nowhere written | step (iii) needs a presentation to exist. When none exists Definition 2.7's "smallest k" is undefined and part 2's hypothesis should be read as never met. Not a defect of the proof, but the convention is unwritten |
| The module structure on $\{\mathrm{Sym}^d\mathcal W_n^*\}$ (which embedding) | Setting, "zero-padding ... makes" | step (iii) needs Proposition 2.9's $P_{U_n}$ to be restriction of forms. The record leaves the embedding implicit. The paper's (Polynomials) construction $\{(\mathrm{Sym}^kV_n,\varphi_n^{\otimes k})\}$ applied to padded $\{\mathcal W_n\}$ supplies it (Section 2 below) |

No hypothesis is stated and unused, and no step uses an unstated hypothesis other than the finiteness convention for $k_B(d)$.

**Imported: Definition 1.3 (consistent sequence).** Needs compact $G_n\subseteq G_{n+1}$, $V_n$ an orthogonal $G_n$-representation, $\varphi_n$ a linear $G_n$-equivariant isometry. Checked in Section 2: holds for $\mathcal W_n$ and for $\mathrm{Sym}^d\mathcal W_n^*$ with $B_n$ finite, embedded by $g\mapsto\mathrm{blkdiag}(g,1)$.

**Imported: Definition 2.5 (V-module).** Needs $U_d\subseteq U_n^{H_{n,d}}$ for $d\le n$, with $H_{n,d}$ the centralizing subgroups of $V=\{\mathbb R^n\}$, which Example 2.8 names as the signed permutation matrices fixing the first $d$ coordinates. Checked in Section 2.

**Imported: Definition 2.7 and the note after it (presentation degree at least generation degree).** Used for $k_B(d)\ge g(d)$. Checked: the note is printed at source.

**Imported: Proposition 2.9.** Hypotheses: $V$ a consistent sequence, $U$ a $V$-module presented in degree $k$. Conclusion: $P_{U_n}:U_{n+1}^{G_{n+1}}\to U_n^{G_n}$ is an isomorphism for all $n\ge k$. Checked against the object in Section 4: holds when $k_B(d)$ is finite, with $k=k_B(d)$.

**Imported: the first fundamental theorem for $O(n_0)$.** Named, not quoted, and not in the reference folder. Its standard form (invariant multilinear forms in $4d$ vectors are spanned by products of inner products along perfect matchings) holds at every $n_0\ge1$ as a spanning statement. The proof uses only spanning.

**Imported, used only in the scope paragraph: Example 2.12 and Theorem 2.11 (Sym clause).** Hypotheses: $V=\{\mathbb R^n\}$ with $G_n=B_n$, $D_n$ or $S_n$, and $W$ a $V$-module generated in degree $d_W$ and presented in degree $k_W$. Checked in Section 9 with $G_n=B_n$.

## 2. The setting against Passage D (brief item 1)

- **$\{\mathcal W_n\}$ is a consistent sequence of $B_n$-representations.** Padding sends $\mathcal W_{n}$ into $\mathcal W_{n+1}$: curvature symmetries and the Bianchi identity are componentwise, and each Ricci component $\sum_{i\le n+1}W_{iaib}$ loses only the term $i=n+1$, which is zero. Padding preserves the Frobenius norm and commutes with $\mathrm{blkdiag}(g,1)$ for $g\in B_n$. The action is orthogonal.
- **It is a V-module over $\{\mathbb R^n\}$.** For $g=\mathrm{blkdiag}(I_d,h)\in H_{n,d}$ and $W$ padded from $\mathcal W_d$, $(g\cdot W)_{ijkl}=g_{ia}g_{jb}g_{kc}g_{ld}W_{abcd}$ with $a,b,c,d\le d$, and $g_{ia}=\delta_{ia}$ there, so $g\cdot W=W$.
- **$\{\mathrm{Sym}^d\mathcal W_n^*\}$ is a consistent sequence and a V-module**, by the paper's (Polynomials) construction and its closing sentence "If $V$, $U$ are $V_0$-modules ... then all the above are $V_0$-modules as well". Identifying a form $p$ with a symmetric tensor $P$ by $p(w)=\langle P,w^{\otimes d}\rangle$, the embedding $\varphi^{\otimes d}$ sends $p$ to $p\circ\mathrm{pr}$ with $\mathrm{pr}$ the orthogonal projection onto the padded copy, and its adjoint $(\varphi^*)^{\otimes d}$ sends $q$ on $\mathcal W_{n+1}$ to $v\mapsto\langle Q,\varphi(v)^{\otimes d}\rangle=q(\varphi(v))$, which is restriction to the padded copy.
- **$k_B(d)$ is well defined when some presentation exists**, as the minimum in Definition 2.7. When none exists the definition returns nothing, and the record writes no convention. Finding (presentational, verdict unaffected): part 2 should say "$k_B(d)=\infty$ when no finite presentation exists, in which case part 2 is empty".

No finding on the structure itself: it is the one the paper's constructions produce, and it is the one step (iii) needs.

## 3. Part 1, existence (brief items 2 and 3)

**Step (i).** $\mathcal W_{n_0}$ is an $O(n_0)$-invariant subspace of $(\mathbb R^{n_0})^{\otimes4}$ under an orthogonal action, so its orthogonal projection $\pi_{n_0}$ is equivariant, and $F\circ\pi_{n_0}$ is an $O(n_0)$-invariant degree-$d$ form. Its full polarisation is a symmetric $d$-linear form on $(\mathbb R^{n_0})^{\otimes4}$, equivalently a linear functional on $(\mathbb R^{n_0})^{\otimes4d}$, equivalently a $4d$-linear form in vectors, and it is $O(n_0)$-invariant. The FFT (spanning) writes it as $\sum_\pi a_\pi\prod_{\{s,t\}\in\pi}\langle v_s,v_t\rangle$. Evaluating the functional at $W^{\otimes d}$ with $W=\pi_{n_0}W\in\mathcal W_{n_0}$ returns $F(W)$ (up to the fixed polarisation normalisation, absorbed into $a_\pi$) and returns $\sum_\pi a_\pi C^{(n_0)}_\pi(W)$ by linearity. So $F=\sum_\pi a_\pi C^{(n_0)}_\pi$ on $\mathcal W_{n_0}$.

- At small $n_0$ the FFT still spans. The relations among contractions (second fundamental theorem when $n_0<2d$, and the Weyl symmetries in any dimension) make $a_\pi$ non-unique.
- At $n_0\le3$, $\mathcal W_{n_0}=0$, $F=0$, and $a_\pi=0$ serves.
- **Nothing later needs uniqueness of $a_\pi$.** Part 1 needs one choice. Part 2 shows every choice gives the same $G$ when $n_0\ge k_B(d)$.

**Step (ii).** For a fixed choice of $a_\pi$, $G=\sum_\pi a_\pi C^{(n)}_\pi$ is a well-defined homogeneous degree-$d$ polynomial on $\mathcal W_n$. Each $C^{(n)}_\pi$ is a complete contraction of $W^{\otimes d}$, and for $g\in O(n)$ the factors $g_{ia}g_{ib}$ sum to $\delta_{ab}$ along each matched pair, so $C^{(n)}_\pi(g\cdot W)=C^{(n)}_\pi(W)$.

- "No closed δ-loop occurs" means every $\delta$ joins two slots of Weyl factors, so no trace $\delta_{ii}=n$ produces an $n$-dependent scalar. That is true because $C_\pi$ has no free $\delta$ at all.
- What the restriction actually needs is the companion clause: every summation index sits on a Weyl slot. For padded $W$, any term with an index above $n_0$ contains a factor $W_{\cdots}$ carrying that index, which is $0$. So $C^{(n)}_\pi(\mathrm{pad}\,W)=C^{(n_0)}_\pi(W)$ and $G$ restricts to $F$.

Verdict: **CONFIRMED**. Screen at $d=1$: the three contractions of a single $W$ are $W_{iijj}=0$ (antisymmetry), $W_{ijij}=0$ (tracelessness), $W_{ijji}=-W_{ijij}=0$, so $F=0$ and $G=0$, consistent.

## 4. Part 2, uniqueness (brief item 4)

- Proposition 2.9 as printed: for a $V$-module $U$ presented in degree $k$, $P_{U_m}:U_{m+1}^{G_{m+1}}\to U_m^{G_m}$ is an isomorphism for all $m\ge k$. The paper fixes $\varphi_m^*=P_{V_m}$ as the orthogonal projection, which for $U=\mathrm{Sym}^d\mathcal W^*$ is restriction of forms to the padded copy (Section 2).
- For $n>n_0\ge k$, the composite $P_{U_{n_0}}\circ\cdots\circ P_{U_{n-1}}$ is an isomorphism $U_n^{B_n}\to U_{n_0}^{B_{n_0}}$, and it equals restriction along the composite padding $\mathcal W_{n_0}\hookrightarrow\mathcal W_n$. At $n=n_0$ it is the identity. The record says "injective", which is the half it uses. The composition is left to the reader, and it closes.
- $F$ is $B_{n_0}$-invariant because $B_{n_0}\subseteq O(n_0)$. $G$ is $B_n$-invariant because $B_n\subseteq O(n)$. Restriction of a $B_n$-invariant form lands in $B_{n_0}$-invariants because $B_{n_0}\subseteq B_n$ preserves the padded copy.
- Two $B_n$-invariant extensions differ by a $B_n$-invariant form restricting to $0$, which injectivity kills. Existence is part 1. So there is exactly one, it is $G$, and in particular the $O(n)$-invariant extension is unique and independent of the choice of $a_\pi$.

Verdict: **CONFIRMED**, conditional on $k_B(d)$ finite, which the hypothesis $n_0\ge k_B(d)$ presupposes.

## 5. The SO clause (brief item 5)

The clause: "The same holds with $SO$ in place of $O$, because $B_{n_0}$ contains the reflection $\mathrm{diag}(-1,1,\dots,1)$: an $SO(n_0)$-invariant form with a $B_n$-invariant extension is $O(n_0)$-invariant."

### 5.1 The reflection sentence

If $G$ on $\mathcal W_n$ is $B_n$-invariant and restricts to $F$, then $r'=\mathrm{diag}(-1,1,\dots,1)\in B_{n_0}\subseteq B_n$ preserves the padded copy and acts on it as $r=\mathrm{diag}(-1,1,\dots,1)\in O(n_0)$, so $F(r\cdot W)=F(W)$. $SO(n_0)$ and $r$ generate $O(n_0)$. **CONFIRMED AS ALGEBRA.**

### 5.2 Candidate: part 1 fails with SO in place of O

1. **Location.** Passage A, the sentence after part 2, and Passage B detail, "The same holds with $SO$ in place of $O$". Part 1 with $SO$ reads: an $SO(n_0)$-invariant form of degree $d$ on $\mathcal W_{n_0}$ has, for every $n\ge n_0$, an $SO(n)$-invariant extension. "No hypothesis on $n_0$ enters." The justification offered addresses only $B_n$-invariant extensions, which part 1 does not produce in the $SO$ setting.
2. **Failure in closed form.** Take $n_0=4$, $d=2$, $n=5$.
   - $F(W)=\sum\varepsilon_{abcd}W_{abef}W_{cdef}$ on $\mathcal W_4$. For $g\in O(4)$ the pairs $e,f$ contract by orthogonality and $\varepsilon_{abcd}g_{aa'}g_{bb'}g_{cc'}g_{dd'}=\det g\,\varepsilon_{a'b'c'd'}$, so $F(g\cdot W)=\det g\,F(W)$. $F$ is $SO(4)$-invariant and $F(r\cdot W)=-F(W)$.
   - $F$ is not zero. Summing over ordered pairs, $F(W)=8\,\mathrm{tr}(SM^2)$ with $S$ the Hodge star matrix ($S(12,34)=S(14,23)=1$, $S(13,24)=-1$, symmetric, zero diagonal). For $M=D(x,y,z)+aJ_1+bJ_2+cJ_3$, $M^2(12,34)=2ax$, $M^2(13,24)=2by$, $M^2(14,23)=2cz$, so $F=32(ax-by+cz)$. Take $W_0$ with $x=1$, $y=-1$, $z=0$, $a=b=1$, $c=0$: that is $W_{1212}=W_{3434}=1$, $W_{1313}=W_{2424}=-1$, $W_{1234}=W_{1324}=1$, all else determined by symmetry or zero. The conditions $x+y+z=0$ and $a-b+c=0$ hold, so $W_0\in\mathcal W_4$, and $F(W_0)=32(1+1+0)=64$.
   - Let $G$ be any $SO(5)$-invariant form on $\mathcal W_5$ restricting to $F$. Put $h=\mathrm{diag}(-1,1,1,1,-1)\in SO(5)$. On a padded tensor every nonzero component has indices in $[4]$, where $h$ acts as $r$, so $h\cdot\mathrm{pad}(W_0)=\mathrm{pad}(r\cdot W_0)$. Then $F(r\cdot W_0)=G(\mathrm{pad}(r\cdot W_0))=G(h\cdot\mathrm{pad}W_0)=G(\mathrm{pad}W_0)=F(W_0)$, so $-64=64$. No such $G$ exists.
   - The same argument, with $h=\mathrm{diag}(-1,1,\dots,1,-1)$, shows at every $n>n_0$ that an $SO(n)$-invariant extension forces $O(n_0)$-invariance. So the $SO$ version of part 1 holds exactly for the $SO(n_0)$-invariant forms that are already $O(n_0)$-invariant.
3. **The opposite argued.** (a) Read "SO in place of O" as replacing only the extension's group, with $F$ still $O(n_0)$-invariant: that reading is trivially true, but the justification explicitly takes "an $SO(n_0)$-invariant form", so the words place $SO$ on $F$. (b) Read the conclusion as an $O(n)$-invariant extension: stronger, and refuted by the same witness. (c) Read the clause as applying only to forms that have a $B_n$-invariant extension: then $F$ is $O(n_0)$-invariant by 5.1 and the clause says nothing beyond the O lemma, which is not what "the same holds" asserts. (d) A range restriction the author may have meant: $n_0=4$ is admissible for part 1 by its own words, and odd $n_0$ are no refuge for a universal claim. The candidate survives.

**REFUTED AS STATED.**

### 5.3 Candidate: part 2 fails with SO in place of O

1. **Location.** Part 2 with $SO$: for $n\ge n_0\ge k_B(d)$, an $SO(n_0)$-invariant $F$ has exactly one $B_n$-invariant extension.
2. **Failure.** By 5.1, an $SO(n_0)$-invariant $F$ that is not $O(n_0)$-invariant has no $B_n$-invariant extension, so "exactly one" is false for every such $F$ in range. A witness in range needs $n_0\ge k_B(d)\ge4d$, and no finite $k_B(d)$ is on file, so no in-range object can be exhibited. The record's own sentence proves the clause false for every non-O-invariant $F$, and true only for $O(n_0)$-invariant $F$.
3. **The opposite argued.** If no $SO(n_0)$-invariant, non-$O(n_0)$-invariant form of degree $d$ exists at any $n_0\ge k_B(d)$, the clause is vacuously the O case. The record gives no argument that such forms are absent in range, and the justification it offers is an argument that they fail, not that they are absent.

**REFUTED AS STATED** as a claim with content. The honest statement is the O lemma, and the SO sentence should be deleted or restricted to forms that are also $O(n_0)$-invariant.

## 6. k_B(d) ≥ g(d) ≥ 4d (brief item 6)

- **$T\in\mathcal W_4$.** In the notation of Section 0, $T$ is $M=J_1+J_2$: $a=W_{1234}=1$, $b=W_{1324}=-W_{1342}=1$, $c=0$, $x=y=z=0$. Then $a-b+c=0$ and $x+y+z=0$. The record's reasons ("Bianchi sum $1-1+0=0$", "every Ricci component carries a repeated index") match. **Confirmed.**
- **The block product is in the module and has the stated component.** Let $T_k$ be $T$ transported to the block $\{4k-3,\dots,4k\}$ (a permutation, hence a $B_{4d}$-translate of padded $T$, hence in $\mathcal W_{4d}$). The symmetric product $T_1\odot\cdots\odot T_d\in\mathrm{Sym}^d\mathcal W_{4d}$ is a sum over orderings of $T_{\sigma(1)}\otimes\cdots\otimes T_{\sigma(d)}$. At the multi-index $(1,2,3,4,5,\dots,4d)$ only the identity ordering survives, since $T_j$ vanishes on indices outside block $j$, and the component is $T_{1234}^d=1$ times the normalisation. Nonzero, with $4d$ distinct values.
- **The support argument.** An element of padded $\mathrm{Sym}^d\mathcal W_m$ inside $(\mathbb R^n)^{\otimes4d}$ has nonzero components only on multi-indices with values in $[m]$, so with at most $m$ distinct values. A signed permutation sends the component at $(i_1,\dots,i_{4d})$ to $\pm$ the component at $(\sigma(i_1),\dots,\sigma(i_{4d}))$, which has the same number of distinct values. So for $m<4d$ every element of $\mathbb R[B_{4d}]U_m$ vanishes at every multi-index with $4d$ distinct values, and $\mathbb R[B_{4d}]U_m\ne U_{4d}$.
- **What it bounds.** Definition 2.2 requires $\mathbb R[G_n]U_m=U_n$ for all $n\ge m$. It fails at $n=4d$ for every $m<4d$, so $g(d)\ge4d$. The note after Definition 2.7 gives $k_B(d)\ge g(d)$.
- $k_B(6)\ge24>12$ follows.

**CONFIRMED.** The record's phrase "maps a support of size $m$ to a support of size $m$" is loose (it means the set of distinct index values), and the tensor picture of $\mathrm{Sym}^d\mathcal W_n^*$ is used without being named. Neither affects the argument.

## 7. "No finite k_B(d) is on file" and Passage C (brief item 7)

- Passage A's sentence is a statement of record status and needs no proof. **CONFIRMED.**
- Passage C's kernel clause. $\mathcal W_n=\ker(\mathrm{Ric})$ on algebraic curvature tensors. Theorem 2.11 needs $\mathrm{Ric}^*$ to be a morphism, $\mathrm{Ric}^*_{n+1}\psi_n=\varphi_n\mathrm{Ric}^*_n$. Taking adjoints this is $\varphi_n^*\mathrm{Ric}_{n+1}=\mathrm{Ric}_n\psi_n^*$, and both adjoints are truncation (the truncation of a curvature tensor is a curvature tensor, and the discarded components are orthogonal). $\mathrm{Ric}_n(\mathrm{trunc}R)_{ab}$ and $\mathrm{trunc}\,\mathrm{Ric}_{n+1}(R)_{ab}$ differ by $R_{(n+1)a(n+1)b}$. Screen confirms the paragraph.
- Passage C's sums clause. Screen by hand: if $\mathrm{pad}(h\wedge\delta_{n_0})=h'\wedge\delta_{n_0+1}$ with $N=n_0+1$, the components $(iNkN)$ force $h'_{ik}=-h'_{NN}\delta_{ik}$ for $i,k\le n_0$, the components $(ijkN)$ force $h'_{iN}=0$, and then $h\propto I$. Conversely $\mathrm{pad}(I\wedge\delta_{n_0})=\mathrm{diag}(I_{n_0},-1)\wedge\delta_N$. Screen confirms "holds only for $h\propto I$".
- **Candidate: "Theorem 2.11's calculus yields no $k_B$ here at all".**
  1. Location: Passage C, second paragraph, first clause.
  2. Failure: the argument covers the kernel of $\mathrm{Ric}$ and a direct-sum splitting. Theorem 2.11's images clause (for example $\mathcal W_n$ as the image of a morphism with morphism adjoint from some other module) and any other construction are not addressed. "At all" is universal and its argument is two instances.
  3. Opposite: "the calculus" may mean "the calculus applied along the two natural routes". The words say "at all", and the claim is not used by the lemma.

  **HYPOTHESIS-DEBT.** What would have to be proved: no chain of Theorem 2.11's clauses from $\{(\mathbb R^n)^{\otimes k}\}$ over $B_n$ produces $\{\mathcal W_n\}$ or $\{\mathrm{Sym}^d\mathcal W_n^*\}$ with a bound. Otherwise weaken to "the kernel and sums routes yield none". Impact on the lemma: none.

## 8. The n0 = 3 edge (brief item 8)

- $k_B(2)\ge g(2)\ge8>3$, so $n_0=3$ lies below the range. **Confirmed.**
- $F=0$ is the only form on $\mathcal W_3=0$. For $n\ge4$, $0$ and $\lvert W\rvert^2$ are degree-2, $O(n)$- and $B_n$-invariant, restrict to $0$ on $\{0\}$, and differ because $\mathcal W_n\ne0$. They are two extensions of the kind part 2 counts. The record omits "$n\ge4$", which is implicit (at $n=3$ they coincide). **CONFIRMED.**

### 8.1 Withdrawn: "Below the range, uniqueness fails" as a universal claim

1. Location: Passage A, third scope bullet, heading clause.
2. Read universally it fails at $n=n_0<k_B(d)$, where the only extension is $F$ itself.
3. Opposite: a heading followed by one instance reads as "uniqueness can fail below the range", which the instance proves. **Withdrawn**, the charitable reading is the natural one. Wording note only: "can fail".

## 9. The Sym²Sⁿ exhibit (brief item 9)

- **Presented in degree 4.** $S^n=\mathrm{Sym}^2\mathbb R^n$ is generated and presented in degree $2$ over $B_n$ by Example 2.12 with $k=2$. The Sym clause of Theorem 2.11 with $\ell=2$, $d_W=k_W=2$ gives generation degree $\ell d_W=4$ and presentation degree $(\ell-1)d_W+k_W=4$. Quadratic forms on $S^n$ are identified with $\mathrm{Sym}^2S^n$ by the Frobenius product, and the V-module hypothesis holds by the paper's closing sentence on constructions. **Confirmed.**
- **The identity.** $\mathrm{tr}\big((X-\tfrac14\mathrm{tr}X\,I_4)^2\big)=\mathrm{tr}X^2-\tfrac12(\mathrm{tr}X)^2+\tfrac1{16}(\mathrm{tr}X)^2\cdot4=\mathrm{tr}X^2-\tfrac14(\mathrm{tr}X)^2$, and the left side is the squared Frobenius norm of a symmetric matrix, so $F\ge0$. **Confirmed.**
- **The transfer.** $\mathrm{tr}X^2$ and $(\mathrm{tr}X)^2$ are complete contractions with every index on an $X$ slot, so the same formula on $S^5$ is $O(5)$-invariant and restricts to $F$. $G(I_5)=5-\tfrac{25}4=-\tfrac54$. **Confirmed.** Since $n_0=4\ge4$, this $G$ is the unique $B_5$-invariant extension, so the negative value is forced, not an artefact of a choice.
- **What the paragraph concludes.** "Carrying a nonnegativity certificate from $n_0$ to $n$ needs an argument of its own, and none is on file." The exhibit shows the mechanism, with its uniqueness hypothesis met, does not preserve a sign, on an analogous module. That supports the conclusion as a statement that the lemma gives no sign transfer. **CONFIRMED.** The pointer "Post F31, above, is the instance at the balanced sphere product" is not quoted in the brief and was not checked.

### 9.1 Withdrawn: "the extension carries a sign only on the padded copy" as a claim about 𝒲

1. Location: Passage A, final paragraph, first sentence, and Passage B.
2. Read as "the extension of a nonnegative form fails to be nonnegative off the padded copy", it fails for $F=\lvert W\rvert^2$ at $n_0=4$, whose extension $\lvert W\rvert^2$ is nonnegative everywhere. The exhibit is on $\mathrm{Sym}^2S^n$, not on $\mathrm{Sym}^d\mathcal W_n^*$.
3. Opposite: "carries a sign only on the padded copy" says what the lemma guarantees, and restriction to $F$ is the whole guarantee. **Withdrawn**, the guarantee reading is the one the sentence's verb supports.

## 10. Passages B and C against Passage A (brief item 10)

| Point | Passage A | Passage B | Passage C | Finding |
|---|---|---|---|---|
| Range of part 1 | every $n\ge n_0$, no hypothesis on $n_0$ | every $n\ge n_0$ | every $n\ge n_0$ | agree |
| Range of part 2 | $n\ge n_0\ge k_B(d)$ | landscape "when $n_0\ge k_B(d)$", detail "$n\ge n_0\ge k_B(d)$" | "once $n_0\ge k_B(d)$" | agree, $n\ge n_0$ inherited from the first sentence |
| Base of the module | over $\{\mathbb R^n\}$ with $\{B_n\}$ | detail names the base, landscape names only $\{B_n\}$ | not named | harmless by Remark 2.10 (depends on the centralizing subgroups) |
| SO clause | stated with the reflection justification | detail: "The same holds with $SO$ in place of $O$", no justification | absent | Passage B inherits the refutation of Section 5 |
| $k_B(d)\ge4d$ | argued | stated | absent | agree |
| Sign | "only on the padded copy", certificate needs its own argument | same | "Equivariance was never the obstruction. The hypothesis is." | see 10.1 |

### 10.1 Withdrawn: Passage C names one obstruction where Passage A records two

1. Location: Passage C, "Equivariance was never the obstruction. The hypothesis is."
2. Passage A shows that with the hypothesis met ($\mathrm{Sym}^2S^n$ at $n_0=4$) a certificate still fails to transfer, so the sign is a second obstruction.
3. Opposite: Passage C's sentence follows a description of transferring an invariant element, and for that transfer the hypothesis is the only obstruction, which Passage A agrees with. **Withdrawn**, the context supports the element reading. Wording note: a reader of Passage C alone could take it to cover certificates.

## 11. Passage E against Passage A (brief item 11, standing item 5)

| Declaration | What it states | Relation to Passage A |
|---|---|---|
| generation_degree | $4\cdot6=24$ | the arithmetic in $k_B(6)\ge24$ |
| exceeds_twelve | $12<24$ | the arithmetic in $24>12$ |
| six_blocks_support | $6\cdot4=24$ | the arithmetic of $d$ blocks of size 4 |
| support_cap_at_six | $2\cdot6=12$ | matches no line of Passage A |
| counts_disagree | $2\cdot6<6\cdot4$ | matches no line of Passage A |
| support_forces_degree | $24\le2d\Rightarrow12\le d$ over ℕ | matches no line of Passage A (a "$2d$" support count Passage A does not use) |
| overstatement_factor | $24=2\cdot12$ | matches no line of Passage A |
| indexed_not_scalar | strictly increasing $k:\mathbb N\to\mathbb N$ has $k(d)\ne k(d+1)$ | Passage A asserts no monotonicity of $k_B$ |
| unbounded | strictly increasing $k$ is unbounded | same, the proof ($d\le k(d)$ by induction) closes |
| transfer_not_order | a map preserving a trivial predicate can send $0\le x$ to $T(x)<0$, witness $T=-\mathrm{id}$ | a toy analogue of "carries a sign only on the padded copy", with no form, no padding and no invariance |
| conditional_of_free | $Q\to(P\to Q)$ | a tautology |

- No declaration has a binder for a dimension, a group, a Weyl tensor, a form, an extension or a presentation degree. Existence, uniqueness, the SO clause and the support argument are all untyped.
- **REFUTED AS STATED** for "the Lean file states the claim". It states none of it. The file was read, not compiled.

## 12. The boundary (brief item 12, standing item 3)

- **$n=n_0$.** Part 1 gives $G=F$ from the formula. Part 2 is the identity map. No finding.
- **$d=1$.** $F=0$ by the three vanishing contractions (Section 3). Screen for part 2: a $B_n$-invariant linear form is $\langle W_*,\cdot\rangle$ for a $B_n$-invariant $W_*\in\mathcal W_n$. Such $W_*$ has $W_{iiii}=0$ and a single value $c$ on $W_{ijij}$, $i\ne j$, with Ricci $(n-1)c=0$, and distinct-index components are killed by sign changes, so $W_*=0$. Consistent with uniqueness. No finding.
- **$\mathcal W_n=0$ for $n\le3$.** Part 1 holds with $F=G=0$. Part 2's range starts at $k_B(d)\ge4d\ge4$, so it never meets $n_0\le3$. The edge in Section 8 is correctly placed below the range. No finding.
- **Padded $W$ with $\ker W\ne0$.** Every padded $W$ annihilates $e_{n_0+1},\dots,e_n$ in every slot. Step (ii) uses exactly this. No step assumes nondegeneracy. The same kernel is what makes $h$ in Section 5.2 act as a reflection on the padded copy, which is the mechanism of the SO counterexample. No further finding.
- **Smallest admissible dimension.** Part 1 has none, and holds at $n_0=0,1,2,3$ trivially. Part 2's smallest admissible $n_0$ is $k_B(d)$, not on file.

## 13. Standing list, explicit answers

1. **Hypothesis inventory.** Section 1. One unwritten convention ($k_B(d)$ finite, or $\infty$ when no presentation exists). No stated hypothesis unused.
2. **Quantifier order and scope.** "For every $n\ge n_0$, $F$ has an extension" is $\forall F\,\forall n\,\exists G$, and the proof builds $G$ from $F$ and $n$ with a choice of $a_\pi$, matching. Part 2 is $\forall F\,\forall n\ge n_0\ge k_B(d)\,\exists!\,G$, matching. The SO clause is the only scope failure (Section 5). No other finding.
3. **Range edges.** Section 12.
4. **Proven versus used.** Nothing proven on a subfamily is stated in general inside the lemma. The scope paragraph's sign claim is supported by an exhibit on a different module and is withdrawn as a defect under the guarantee reading (Section 9.1). No finding.
5. **The Lean file.** Section 11: it states none of the claim.

**Traps by name.**

- $\ker W\ne0$: Section 12, no finding in the O lemma, and it drives the SO counterexample.
- Range boundaries: Sections 8 and 12, no finding.
- Subfamily used in general: Section 9.1, withdrawn.
- Hypothesis stated but unused or used but unstated: the $k_B(d)=\infty$ convention, presentational.
- Universal claim with no witness: the SO clause, refuted with a witness. Screens on the structured families: diagonal ($D(1,-1,0)$, $F=0$, since $a=b=c=0$), the sphere product $S^2\times S^2$ (its Weyl part is of diagonal type, so $F=0$), and the diagonal-plus-$J$ element $W_0$ ($F=64$). $\mathbb{CP}^2$ was not evaluated. For part 1 in the O case with $F=\lvert W\rvert^2$ every family restricts correctly.
- Imported theorem with unchecked hypotheses: Proposition 2.9, Definitions 1.3 and 2.5, Theorem 2.11 and Example 2.12 all checked against the object (Sections 2, 4, 9). The FFT is cited by name without a source on file, and only its spanning form, valid at every dimension, is used.

## 14. The brief's items, by number

1. Section 2. CONFIRMED, with the $k_B=\infty$ convention unwritten.
2. Section 3. CONFIRMED. The coefficients are not unique and nothing needs them to be.
3. Section 3. CONFIRMED. "No closed δ-loop" is true, and the restriction needs "every index on a Weyl slot", which the record also states.
4. Section 4. CONFIRMED. $P_{U_n}$ is restriction, adjacent isomorphisms compose, $G$ is $B_n$-invariant, "exactly one ... therefore the $O(n)$-invariant extension" follows.
5. Section 5. The reflection sentence CONFIRMED AS ALGEBRA. The SO clause REFUTED AS STATED for part 1 (witness $n_0=4$, $d=2$, $n=5$) and for part 2 (false for every non-O-invariant $F$).
6. Section 6. CONFIRMED.
7. Section 7. Passage A's sentence CONFIRMED. Passage C's two route failures confirmed by hand screen. Passage C's "at all" is HYPOTHESIS-DEBT.
8. Section 8. CONFIRMED. The universal reading of "below the range, uniqueness fails" withdrawn.
9. Section 9. CONFIRMED.
10. Section 10. Passage B detail repeats the refuted SO clause. Other differences harmless or withdrawn.
11. Section 11. The Lean file types none of the lemma.
12. Section 12. No finding at any boundary.

## 15. What would break it

- **The O lemma, part 1**: an $O(n_0)$-invariant $F$ with no $O(n)$-invariant extension. Steps (i) and (ii) construct one for every $F$, so a break would need a failure of the FFT's spanning statement or a contraction with an index not on a Weyl slot. I checked both, and the $d=1$ and $d=2$ screens, and found none.
- **The O lemma, part 2**: two distinct $B_n$-invariant extensions at some $n\ge n_0\ge k_B(d)$. That contradicts Proposition 2.9 as printed. The only exposure is a mistaken identification of $P_{U_n}$ with restriction, checked in Section 2.
- **The SO clause**: broken by $F=\varepsilon_{abcd}W_{abef}W_{cdef}$ on $\mathcal W_4$, $W_0$ with $F(W_0)=64$, and $h=\mathrm{diag}(-1,1,1,1,-1)\in SO(5)$.
- **$k_B(d)\ge4d$**: a $B_{4d}$-translate of a padded element of smaller support with a component on $4d$ distinct indices. Signed permutations preserve the count of distinct index values, so none exists.
- **The exhibit**: a different value of $G(I_5)$ or a presentation degree above $4$. Both checked exactly against Example 2.12 and the Sym clause.

## 16. Index state and verdict

At commit time nothing was staged. A sibling verifier's untracked report, verification/VERIFY_v385.md, was present and was left alone. This commit is path-limited to this report.

**Verdict: `PROVEN, hypotheses corrected`.** The O(n) lemma is proven as written, with part 2 conditional on a finite $k_B(d)$. The SO clause in Passages A and B is false as stated and holds only after its hypothesis is corrected from "$SO(n_0)$-invariant" to "$SO(n_0)$-invariant and $O(n_0)$-invariant", which is the O case, so the clause should be deleted or restricted accordingly.

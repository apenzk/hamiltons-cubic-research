# Verifier v392, adjudication of step H3 in round L64-r2

Cold brief ([ADJ_L64r2_H3.md](ADJ_L64r2_H3.md) and the Levin–Chandrasekaran paper only). No numerical work: no scripts were written and no computation was run. Every value below is exact and derived by hand. Log: [agent_logs/verify-L64-v392.log](../agent_logs/verify-L64-v392.log).

| # | Claim | Verdict |
|---|---|---|
| C1 | The kernel clause of Theorem 2.11 needs the adjoint sequence to be a morphism | VALID |
| C2 | For $A=\mathrm{Ric}:\mathrm{Curv}\to S$, "adjoint is a morphism" is equivalent to $\mathrm{Ric}$ commuting with truncation | VALID |
| C3 | $\mathrm{Ric}$ does not commute with truncation | VALID |
| C4 | Padding keeps an element of the Ricci part inside the Ricci part only for $h\propto I$ | VALID for one padding step, $n\ge3$ |
| C5 | The round sphere is exactly that exception, so a test with $S^{n_0}$ misleads | VALID for a one-step test (a two-step test with $S^{n_0}$ already detects the failure) |
| C6 | "The sums clause needs the Ricci part padding-closed" | IMPRECISE: the Sums clause bounds a sum from its parts and never a part. The route meant is the Images clause applied to the projection onto a summand, and for that route the condition is right |
| C7 | From C1 to C6: "Theorem 2.11's calculus yields no $k_B$ here at all", for $\{\mathrm{Sym}^d\mathcal W_n^*\}$ | FAILS as an inference |
| C8 | Repair: no chain of Theorem 2.11's clauses starting from the free modules on file reaches $\{\mathcal W_n\}$, and none reaches $\{\mathrm{Sym}^2\mathcal W_n^*\}$ | VALID (proved below) |
| C9 | The same for $\{\mathrm{Sym}^d\mathcal W_n^*\}$ with $d\ge3$, in particular $d=6$ | OPEN (neither proved nor refuted here) |

**Summary: every mechanical reason in Passage C is correct, but those reasons exclude only two presentations of $\{\mathcal W_n\}$ inside the curvature tensors, while Theorem 2.11 acts on isomorphism classes and applies to $\{\mathrm{Sym}^d\mathcal W_n^*\}$ directly, so "no $k_B$ at all" does not follow (a closed-form $B_n$-module satisfying the same two reasons whose square the calculus does present is exhibited), and the conclusion can be repaired for $d=1,2$ only.**

## 0. Conventions, fixed once

Quoted from the brief.

- "$\mathcal W_n$ is the space of algebraic Weyl tensors on $\mathbb R^n$: 4-tensors with the curvature symmetries $W_{ijkl}=-W_{jikl}=-W_{ijlk}=W_{klij}$, the first Bianchi identity $W_{ijkl}+W_{iklj}+W_{iljk}=0$, and every Ricci contraction zero, with the Frobenius inner product. $\mathcal W_n=0$ for $n\le3$."
- "$O(n)$, and its subgroups $SO(n)$ and the signed permutation group $B_n$, act on $\mathcal W_n$ by $(g\cdot W)_{ijkl}=g_{ia}g_{jb}g_{kc}g_{ld}W_{abcd}$. Zero-padding sends $W\in\mathcal W_{n_0}$ to the tensor on $\mathbb R^n$ with the same components on indices in $[n_0]$ and zero elsewhere."
- "$\mathrm{Sym}^d\mathcal W_n^*$ is the space of homogeneous polynomials of degree $d$ on $\mathcal W_n$. $S^n$ is the space of real symmetric $n\times n$ matrices."
- "$k_B(d)$ is that module's presentation degree, in the sense of Definition 2.7 of Levin–Chandrasekaran, and $g(d)\le k_B(d)$ is its generation degree."
- "This loop does no numerical work."

Further notation used here, all standard. $\mathrm{Curv}_n$ is the space of 4-tensors with the curvature symmetries and Bianchi identity. The Kulkarni–Nomizu product is $(h\wedge g)_{ijkl}=h_{ik}g_{jl}+h_{jl}g_{ik}-h_{il}g_{jk}-h_{jk}g_{il}$. "Truncation" is the adjoint $\phi_n^*$ of the padding embedding, the orthogonal projection onto the coordinates in $[n]$. $\mathrm{Ind}_m(X)$ is the $V$-induction sequence of Definition 2.6 for $V=\{\mathbb R^n\}$, $G_n=B_n$, so $\mathrm{Ind}_m(X)_n=\mathrm{Ind}_{B_m\times B_{n-m}}^{B_n}(X\boxtimes\mathrm{triv})$ has dimension $\binom nm\dim X$. "Free" means algebraically free.

## 1. Hypothesis inventory

| # | Hypothesis the step needs | Status |
|---|---|---|
| H-a | $\{\mathcal W_n\}$, $\{\mathrm{Curv}_n\}$, $\{S^n\}$ and $\{\mathrm{Sym}^d\mathcal W_n^*\}$ with padding are $V$-modules over $\{\mathbb R^n\}$, $\{B_n\}$ | Holds. Padding preserves every symmetry, the Bianchi identity and every Ricci contraction, it is an isometry, and it commutes with $B_n\subset B_{n+1}$. $H_{n,d}$ fixes the padded level $d$ |
| H-b | $\mathcal W_n=\ker(\mathrm{Ric}:\mathrm{Curv}_n\to S^n)$ and $\mathrm{Curv}_n=\mathcal W_n\oplus\{h\wedge I_n\}$ orthogonally, $n\ge3$ | Holds (definition, and injectivity of $h\mapsto h\wedge I_n$ for $n\ge3$) |
| H-c | $\mathrm{Ric}$ is a morphism of sequences | Holds: $\mathrm{Ric}$ of a padded tensor is the padded $\mathrm{Ric}$, since summands with an index above $n$ vanish |
| H-d | The only modules whose degrees the calculus can start from are those on file for $B_n$: $\{\mathbb R^n\}$, its tensor powers and symmetric powers (Examples 2.8, 2.12) | Unwritten. Needed for any "at all" reading, and supplied in §4 |
| H-e | Presentation degree is an invariant of the isomorphism class of a $V$-module | Holds directly from Definition 2.7: compose the surjection $F\to U$ with the isomorphism. This hypothesis is what the step overlooks |
| H-f | Tensor products of free $\mathrm{FI}_{BC}$-modules are free | Imported, Theorem A.4 of the paper |

## 2. The mechanical reasons, C1 to C6

**C1.** Theorem 2.11 (Images and kernels) and Theorem A.13 assume that both $A$ and $A^*$ are morphisms. VALID.

**C2.** Let $A:X\to Y$ be a morphism with embeddings $\phi_n$ on $X=\mathrm{Curv}$ and $\psi_n$ on $Y=S$. $A^*$ is a morphism iff $A^*_{n+1}\psi_n=\phi_nA^*_n$ for all $n$. Taking adjoints of both sides, this is $\psi_n^*A_{n+1}=A_n\phi_n^*$, which says that truncating $\mathrm{Ric}$ equals $\mathrm{Ric}$ of the truncation. The two conditions are adjoint to each other, so they are equivalent. VALID.

**C3.** For $R\in\mathrm{Curv}_{n+1}$ and $i,k\le n$, $(\phi_n^*\mathrm{Ric}_{n+1}R)_{ik}=\sum_{j\le n+1}R_{ijkj}$ while $(\mathrm{Ric}_n\phi_n^*R)_{ik}=\sum_{j\le n}R_{ijkj}$. They differ by $R_{i,n+1,k,n+1}$. For $R=I_{n+1}\wedge I_{n+1}$ this is $2\delta_{ik}\ne0$. VALID. The same computation shows more than the passage states: $\mathcal W$ is not closed under truncation, so no morphism $A$ on $\mathrm{Curv}$ or on $(\mathbb R^n)^{\otimes4}$ with $A^*$ a morphism has kernel or image equal to the literal $\{\mathcal W_n\}$ (kernels and images of such $A$ are truncation-closed, since $A_n\phi_n^*=\psi_n^*A_{n+1}$). The Weyl projection itself fails for the same reason.

**C4.** Fix $n\ge3$ and $h\in S^n$, and ask for $h'\in S^{n+1}$ with $h'\wedge I_{n+1}$ equal to the padded $h\wedge I_n$. The component $(i,n+1,k,n+1)$ with $i,k\le n$ equals $h'_{ik}+h'_{n+1,n+1}\delta_{ik}$, which must vanish, so $h'_{ik}=-c\,\delta_{ik}$ with $c=h'_{n+1,n+1}$. The component $(i,j,n+1,j)$ with $i\ne j\le n$ equals $h'_{i,n+1}$, which must vanish. So $h'=\mathrm{diag}(-cI_n,c)$, and on $[n]$ the product is $-c\,I_n\wedge I_n$, forcing $h=-cI_n$. Conversely $h=aI_n$ is met by $h'=\mathrm{diag}(aI_n,-a)$: every component with $n+1$ appearing once vanishes, and $(i,n+1,k,n+1)$ gives $a\delta_{ik}-a\delta_{ik}=0$. VALID for one step. The Ricci part is therefore not a consistent sequence.

**C5.** The round sphere has curvature proportional to $I\wedge I$, the case $h\propto I$. One step of padding keeps it in the Ricci part, consistent with $S^{n_0}\times\mathbb R$ being conformally flat. Two steps do not: with two added indices $a,b$, the component $(a,b,a,b)$ of $h'\wedge I$ is $h'_{aa}+h'_{bb}=2c$, which must vanish, so $c=0$ and $h=0$. VALID for a one-step test, which is the reading "testing with $S^{n_0}$" supports.

**C6.** The Sums clause (Theorem A.13, Lemma A.8) takes presentations of $W$ and $U$ and presents $W\oplus U$. It never presents a summand. A presentation of $\mathcal W$ from $\mathrm{Curv}$ would come from the Images clause applied to the projection $\mathrm{Curv}\to\mathcal W$, which is a morphism with morphism adjoint exactly when the complement (the Ricci part) is a consistent sequence. With that correction C6 is the right condition, and C4 shows it fails.

## 3. The inference C7 and where it fails

**The step concludes about every application of Theorem 2.11 to $\{\mathrm{Sym}^d\mathcal W_n^*\}$. The reasons concern two presentations of $\{\mathcal W_n\}$ as a literal subsequence of $\{\mathrm{Curv}_n\}$.** Two gaps separate them.

1. **Isomorphism class (H-e).** Presentation degree depends only on the isomorphism class of the module, and an isomorphism of sequences need not be an isometry or respect any ambient truncation. A module can fail every literal truncation test and still be isomorphic to an image the calculus presents.
2. **Direct route.** The Sym clause is one sufficient route to $k_B(d)$, and it runs through a presentation of $\mathcal W$. The Images and Tensors clauses can reach $\mathrm{Sym}^d\mathcal W^*$ or an isomorphic copy of it without presenting $\mathcal W$ at all. The passage does not consider this.

**Closed-form exhibit, over the same base $\{\mathbb R^n\}$ and $\{B_n\}$.** Let $E_i=e_ie_i\in S^n$, $D_n=\mathrm{span}\{E_i\}$ (diagonal matrices) and $D^0_n=\{\sum a_iE_i:\sum a_i=0\}$ (traceless diagonal). $B_n$ acts on $D_n$ through its permutation quotient.

- *Both of Passage C's reasons hold verbatim for $D^0$.* $D^0=\ker(\mathrm{tr}:D\to\mathbb R)$, $\mathrm{tr}$ is a morphism, and its adjoint $t\mapsto tI_n$ is not, because padded $I_n\ne I_{n+1}$. Equivalently $\mathrm{tr}$ does not commute with truncation ($\mathrm{tr}\,\phi_n^*I_{n+1}=n\ne n+1$). The complement $\mathbb R I_n$ is not padding-closed, so the summand route is closed too.
- *$D^0$ itself is out of reach, like $\mathcal W$.* $D^0_2$ is 1-dimensional and $D^0_1=0$. If $D^0$ were free it would contain $\mathrm{Ind}_2(D^0_2)$, of dimension $\binom32=3$ at level 3, but $\dim D^0_3=2$ (argument of §4).
- *The calculus still presents $\mathrm{Sym}^2D^0$.* $S^n=\mathrm{Sym}^2\mathbb R^n$ is presented in degree 2 (Example 2.12). The diagonal mask $S^n\to S^n$ is $B_n$-equivariant, self-adjoint and commutes with padding, so $D=\mathrm{im}$ is presented in degree $\le2$ and generated in degree $\le2$ (Images clause). The Sym clause presents $\mathrm{Sym}^2D$ in degree $\le(2-1)\cdot2+2=4$. The off-diagonal mask on $\mathrm{Sym}^2D$ (keep $E_iE_j$ with $i<j$) is again equivariant, self-adjoint and padding-compatible, so its image $O_n=\mathrm{span}\{E_iE_j:i<j\}$ is presented in degree $\le4$. Define $\Phi_n:O_n\to\mathrm{Sym}^2D^0_n$ by $E_iE_j\mapsto(E_i-E_j)^2=E_i^2-2E_iE_j+E_j^2$. $\Phi$ is $B_n$-equivariant and commutes with padding. The images are linearly independent, since the coefficient of $E_iE_j$ is $-2$ in the image of $E_iE_j$ and $0$ in every other image. Both sides have dimension $\binom n2$. So $\Phi$ is an isomorphism of sequences, and by H-e $\mathrm{Sym}^2D^0$ is presented in degree $\le4$.

So the premises of the step (a kernel whose adjoint is not a morphism, a complement that is not padding-closed, the module itself unreachable) are compatible with the calculus yielding a presentation degree for the symmetric power. **The failure is located at the words "yields no $k_B$ here at all": they do not follow from the reasons given.**

**Strongest defence.** Read "$k_B$" as "a presentation of $\{\mathcal W_n\}$ to feed the Sym clause". Then the step says that the two natural routes to $k_{\mathcal W}$ are closed, which C1 to C6 establish. A further defence is that the conclusion may be true for the actual modules. §4 proves it for $\mathcal W$ and for $d=2$ with an argument Passage C does not contain, and shows that the passage's own reasons cannot be the proof, since the $D^0$ exhibit satisfies them. The words "at all" and the object $\{\mathrm{Sym}^d\mathcal W_n^*\}$ rule out the narrow reading as what is written, and the defence does not reach $d\ge3$.

## 4. The repair, and how far it reaches

**Lemma R1 (the calculus preserves freeness).** Every module produced by the clauses of Theorem A.13 from free $\mathrm{FI}_{BC}$-modules is isomorphic to a free module.

*Proof.* Say $P$ is a summand of free if $F=P\oplus P'$ as modules with $F$ free. (Sums) A sum of summands of free modules is a summand of the free sum. (Images and kernels) If $A,A^*$ are morphisms then $\{P_{\ker A_n}\}$ is a morphism (proof of Lemma A.10), so $V=\ker A\oplus\mathrm{im}A^*$ as modules, and $A$ restricts to a bijective morphism $\mathrm{im}A^*\to\mathrm{im}A$. Both $\ker A$ and $\mathrm{im}A$ are summands of $V$. (Tensors) If $V\oplus V'$ and $U\oplus U'$ are free then $V\otimes U$ is a summand of their tensor product, which is free by Theorem A.4. (Schur functors) $S_\lambda V=\mathrm{im}\,c_\lambda$ with $c_\lambda,c_\lambda^*$ morphisms (proof of Corollary A.12), a summand of $V^{\otimes|\lambda|}$. It remains to show a summand of a free module is free. Put $H_0(P)_n=P_n/\mathrm{span}(B_n\cdot P_{n-1})$, additive over direct sums. $H_0(\mathrm{Ind}_m X)$ is $X$ at level $m$ and $0$ elsewhere, because $\mathrm{Ind}_mX$ vanishes below $m$ and is generated in degree $m$. Choose equivariant sections $s_n:H_0(P)_n\to P_n$ (Maschke) and let $Q=\bigoplus_n\mathrm{Ind}_n(H_0(P)_n)$ with the induced morphism $\Phi:Q\to P$ (the map $g\otimes u\mapsto g\cdot u$ of Proposition B.2). $\Phi$ is onto at every level by induction on $n$. A morphism out of $\mathrm{Ind}_d(X)$ is fixed by its equivariant restriction $X\to U_d$, and every such map to $P_d$ lifts through the equivariant surjection $\Phi_d$ (Maschke), so the projection $F\to P$ lifts to $F\to Q$, and its restriction $\sigma$ to $P$ has $\Phi\sigma=\mathrm{id}$. Then $Q=\sigma(P)\oplus\ker\Phi$ and $H_0(Q)\cong H_0(P)\oplus H_0(\ker\Phi)$, while $H_0(Q)_n\cong H_0(P)_n$ by construction. So $H_0(\ker\Phi)=0$, hence $\ker\Phi_n=\mathrm{span}(B_n\ker\Phi_{n-1})$ for every $n$, and $\ker\Phi=0$ from level 0 upward. $\square$

The inputs on file for $B_n$ (H-d) are free: $\{\mathbb R^n\}$ by Example 2.8, its tensor powers by Theorem A.4, its symmetric powers as images of symmetrizers. So by R1 and H-e, a chain of clauses yields a presentation degree for a module only if that module is free.

**Lemma R2 ($\mathcal W$ is not free).** $\mathcal W_n=0$ for $n\le3$ and $\dim\mathcal W_4=\tfrac{16\cdot15}{12}-10=10$, so a free $\mathcal W$ would be $\cong\mathrm{Ind}_4(\mathcal W_4)\oplus\bigoplus_{m\ge5}\mathrm{Ind}_m(Y_m)$, of dimension at least $\binom54\cdot10=50$ at level 5. But $\dim\mathcal W_5=\tfrac{25\cdot24}{12}-15=35$. $\square$

So no chain of clauses presents $\{\mathcal W_n\}$, which covers $d=1$ and closes the Sym-clause route for every $d$. This is the argument the step needed for its narrow reading, and it is absent from Passage C.

**Lemma R3 ($\mathrm{Sym}^2\mathcal W$ is not free).** Restrict to the diagonal sign group $(\mathbb Z/2)^n\subset B_n$ and write $\mu_T(n)$ for the multiplicity of the character $\chi_T:\varepsilon\mapsto\prod_{a\in T}\varepsilon_a$. By Mackey, the multiplicity of $\chi_T$ ($|T|=t$) in $\mathrm{Ind}_m(Y)_n$ is $\binom{n-t}{m-t}y_t^{(m)}$, with $y_t^{(m)}$ the multiplicity of $\chi_{[t]}$ in $Y$. So for a free module $\mu_T(t+N)=\sum_k\binom Nk y^{(t+k)}_t$, and the inverse transform $y^{(t+N)}_t=\sum_k(-1)^{N-k}\binom Nk\mu_T(t+k)$ must be $\ge0$.

For $\mathcal W_n$, $n\ge3$, the pieces are: $\chi_\emptyset$ with multiplicity $w_0=\tfrac{n(n-3)}2$, the dimension of $\{b\in S^n:b_{ii}=0,\ \sum_jb_{ij}=0\}$ (components $b_{ij}=W_{ijij}$), $\chi_{\{i,k\}}$ with multiplicity $w_2=n-3$ (components $W_{ijkj}$, $j\notin\{i,k\}$, summing to $0$), and $\chi_U$, $|U|=4$, with multiplicity $2$. Check: $\tfrac{n(n-3)}2+\binom n2(n-3)+2\binom n4$ gives $10$ at $n=4$ and $35$ at $n=5$.

For $\mathrm{Sym}^2\mathcal W_n$ and $T=\{1,2\}$, the unordered pairs of pieces with symmetric difference $T$ are $\{\emptyset,T\}$, $\{\{1,a\},\{2,a\}\}$, $\{\{1\}\cup A,\{2\}\cup A\}$ with $|A|=3$, and $\{U,U\cup T\}$ with $|U|=2$, so for $n\ge3$

$$\mu_T(n)=Q(n):=w_0w_2+(n-2)w_2^2+4\binom{n-2}3+2\binom{n-2}2w_2 .$$

(Cross-check by characters of $(\mathbb Z/2)^4$ and $(\mathbb Z/2)^5$: $\mu_T(4)=\tfrac1{16}\big(2\cdot55-2\cdot7\big)=6$ and $\mu_T(5)=\tfrac1{32}\big(2\cdot630-2\cdot22\big)=38$, both equal to $Q$.) The actual values are $\mu_T(2)=\mu_T(3)=0$, $\mu_T(4)=6$, $\mu_T(5)=38$, $\mu_T(6)=Q(6)=27+36+16+36=115$. Then

$$y^{(6)}_2=\mu_T(6)-4\mu_T(5)+6\mu_T(4)-4\mu_T(3)+\mu_T(2)=115-152+36=-1<0 .$$

$\square$ The defect is $Q(2)=1\ne0=\mu_T(2)$, and $\deg Q=3$ makes it surface at $N=4$.

**Why the repair stops at $d=2$.** The character of $\mathcal W_n$ on $B_n\subset O(n)$ is $s_{22}-s_2$ (Schur polynomials in the eigenvalues, a formula in the power sums $\mathrm{tr}\,g^k$ that is exact at $n\ge3$), and at $n\le2$ it continues to the virtual classes $-\mathrm{triv}$ ($n=1$) and $-\rho_2$ ($n=2$, $\rho_2$ the traceless symmetric $2\times2$ matrices). Then $\mathrm{Sym}^d$ of these is $(-1)^d\Lambda^d$ of a representation of dimension at most 2, which is $0$ for $d\ge3$. So for $d\ge3$ the small-$n$ defect that drives R2 and R3 vanishes, and character counts no longer separate $\mathrm{Sym}^d\mathcal W$ from a free module. The $D^0$ exhibit shows the same mechanism already at $d=2$ in a smaller module (there $\dim D^0_n=n-1$ continues to $-\mathrm{triv}$ at $n=0$ only, and $\mathrm{Sym}^2(-\mathrm{triv})=\Lambda^2\mathrm{triv}=0$). Whether $\{\mathrm{Sym}^d\mathcal W_n^*\}$ is free for some $d\ge3$, and in particular for $d=6$, is not settled here, and deciding it needs an argument beyond characters.

**Scope of what survives.** "Theorem 2.11's calculus, started from the free modules on file, yields no presentation degree for $\{\mathcal W_n\}$, hence none through the Sym clause, and none for $\{\mathrm{Sym}^d\mathcal W_n^*\}$ at $d=1,2$" is VALID under H-d, H-e, H-f, by R1 to R3. The written step, "yields no $k_B$ here at all", with the reasons of Passage C as its support, is not.

**Verdict: FAILS**

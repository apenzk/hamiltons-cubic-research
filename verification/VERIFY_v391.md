# Verifier v391, adjudication of step H2 in round L64-r2

Cold brief ([ADJ_L64r2_H2.md](ADJ_L64r2_H2.md) and the Levin–Chandrasekaran text only). No numerical work: every value below is exact and derived by hand, and no script was written or run. Log: [agent_logs/verify-L64-v391.log](../agent_logs/verify-L64-v391.log).

| # | Claim | Verdict |
|---|---|---|
| C1 | An $SO(n_0)$-invariant form with a $B_n$-invariant extension is $O(n_0)$-invariant (the sentence's stated reason) | VALID |
| C2 | For $n\ge n_0\ge k_B(d)$, $F$ has at most one $B_n$-invariant extension | VALID |
| C3 | For $n\ge n_0\ge k_B(d)$, every $SO(n_0)$-invariant $F$ has at least one $B_n$-invariant extension | TRUE, NOT ESTABLISHED BY THE STATED REASON |
| C4 | That extension is the $SO(n)$-invariant extension of part 1 | VALID GIVEN C3 AND LEMMA S |
| S | Lemma S (supplied here): for $m\ge4d$, every $SO(m)$-invariant form of degree $d$ on $\mathcal W_m$ is $O(m)$-invariant | VALID |
| C5 | The sentence's stated reason establishes the step | FAILS |

**Summary: the step's conclusion is true under its hypothesis, but the stated reflection argument only shows that a $B_n$-invariant extension, if one exists, is the $O(n)$-invariant one, so the existence half of "exactly one" rests on an unstated fact (Lemma S, from the first fundamental theorem for $SO(m)$, the vanishing $W_{[ijkl]}=0$ and $k_B(d)\ge4d$) that the sentence never invokes, and the identical argument at $n_0=4$, $d=2$ meets the form $\varepsilon_{ijkl}W_{ijmn}W_{klmn}$, which has no $B_n$-invariant extension at all.**

## 0. Conventions, fixed once

Quoted from the brief:

- "$\mathcal W_n$ is the space of algebraic Weyl tensors on $\mathbb R^n$: 4-tensors with the curvature symmetries $W_{ijkl}=-W_{jikl}=-W_{ijlk}=W_{klij}$, the first Bianchi identity $W_{ijkl}+W_{iklj}+W_{iljk}=0$, and every Ricci contraction zero, with the Frobenius inner product. $\mathcal W_n=0$ for $n\le3$."
- "$O(n)$, and its subgroups $SO(n)$ and the signed permutation group $B_n$, act on $\mathcal W_n$ by $(g\cdot W)_{ijkl}=g_{ia}g_{jb}g_{kc}g_{ld}W_{abcd}$. Zero-padding sends $W\in\mathcal W_{n_0}$ to the tensor on $\mathbb R^n$ with the same components on indices in $[n_0]$ and zero elsewhere."
- "$\mathrm{Sym}^d\mathcal W_n^*$ is the space of homogeneous polynomials of degree $d$ on $\mathcal W_n$."
- The step: "when $n\ge n_0\ge k_B(d)$, an $SO(n_0)$-invariant form $F$ of degree $d$ on $\mathcal W_{n_0}$ has exactly one $B_n$-invariant extension, which is therefore the $SO(n)$-invariant extension of part 1, and the sentence's stated reason establishes this."
- The sentence: "The same holds with $SO$ in place of $O$, because $B_{n_0}$ contains the reflection $\mathrm{diag}(-1,1,\dots,1)$: an $SO(n_0)$-invariant form with a $B_n$-invariant extension is $O(n_0)$-invariant."

Summation over repeated indices is implied. $r=\mathrm{diag}(-1,1,\dots,1)$. An extension of $F$ to $\mathcal W_n$ is a form whose restriction to the padded copy of $\mathcal W_{n_0}$ is $F$.

## 1. Hypothesis inventory

- **H1, $k_B(d)<\infty$.** The hypothesis $n_0\ge k_B(d)$ presupposes a finite presentation degree. If none exists the step is vacuous. The analysis below assumes it. Checked: this is the only reading under which the step says anything.
- **H2, the module structure.** $U_n=\mathrm{Sym}^d\mathcal W_n^*$ with padding is a consistent sequence of $B_n$-representations (padding is an isometric $B_n$-equivariant embedding, with $B_n\subset B_{n+1}$ as $\mathrm{blkdiag}(g,1)$) and a $\{\mathbb R^n\}$-module in the sense of Definition 2.5: the centralising subgroup $H_{n,m}$ consists of the signed permutations fixing $e_1,\dots,e_m$, which act trivially on padded elements of $U_m$. Checked.
- **H3, restriction is the projection of Proposition 2.9.** Writing $p(x)=\langle s,x^{\otimes d}\rangle$ with $s\in\mathrm{Sym}^d\mathcal W_n$ and $\iota$ the padding, $p(\iota y)=\langle(\iota^{\otimes d})^*s,y^{\otimes d}\rangle$, and $(\iota^{\otimes d})^*=\phi^*$ is the orthogonal projection $P_{U_m}$. Checked.
- **H4, injectivity from $n$ down to $n_0$.** Proposition 2.9 (verified verbatim in txt.txt line 950) makes $P_{U_m}:U_{m+1}^{B_{m+1}}\to U_m^{B_m}$ an isomorphism for every $m\ge k_B(d)$. Composing for $m=n-1,\dots,n_0$ gives injectivity of restriction $U_n^{B_n}\to U_{n_0}^{B_{n_0}}$ when $n_0\ge k_B(d)$. Checked.
- **H5, restrictions of invariants are invariant.** Padding intertwines $g\in B_{n_0}$ with $\mathrm{blkdiag}(g,I_{n-n_0})\in B_n$, so the restriction of a $B_n$-invariant form is $B_{n_0}$-invariant. Checked.
- **H6, the reflection.** $r\in B_{n_0}$ and $O(n_0)=SO(n_0)\sqcup r\,SO(n_0)$. Checked.
- **H7, $k_B(d)\ge4d$.** Needed for existence (Section 3). Passage A's argument is checked in Section 3.3.
- **H8, Lemma S.** Needed for existence and for the definite article in "the $SO(n)$-invariant extension". The sentence does not state it. Proved in Section 3.

## 2. What the stated reason proves

### 2.1 C1 holds

Let $E$ be a $B_n$-invariant extension of an $SO(n_0)$-invariant $F$. By H5, $F=E|_{\mathcal W_{n_0}}$ is $B_{n_0}$-invariant, so $F(r\cdot W)=F(W)$. By H6 every element of $O(n_0)$ is $h$ or $rh$ with $h\in SO(n_0)$, and $F(rh\cdot W)=F(h\cdot W)=F(W)$. So $F$ is $O(n_0)$-invariant.

### 2.2 C2 holds, and needs no reflection

If $E_1,E_2$ are $B_n$-invariant extensions of $F$, then $E_1-E_2\in U_n^{B_n}$ restricts to $0$, so $E_1=E_2$ by H4. This uses nothing about $SO$ or $O$.

### 2.3 Consequence: the conditional form

C1 and C2 together, with part 2 for $O$, give: **if $F$ has a $B_n$-invariant extension $E$, then $F$ is $O(n_0)$-invariant, the construction $G=\sum_\pi a_\pi C^{(n)}_\pi$ of part 1 applies, $G$ is $O(n)$-invariant hence $B_n$-invariant, and $E=G$.** Part 1's construction for $O(n_0)$-invariant $F$ checks: each $C^{(n)}_\pi$ is $O(n)$-invariant, and on a padded tensor every term with an index above $n_0$ has a zero factor, so $C^{(n)}_\pi$ restricts to $C^{(n_0)}_\pi$.

### 2.4 Where the step leaves the stated reason

"Exactly one" is C2 plus C3. The stated reason is a conditional whose antecedent is the existence of a $B_n$-invariant extension. It delivers $O(n_0)$-invariance only for forms already known to extend, so it cannot deliver C3 without circularity. It also nowhere uses $n_0\ge k_B(d)$, and C3 is false without a range condition, as the next screen shows.

### 2.5 Screen at $n_0=4$, $d=2$ (outside the hypothesis, reported as a screen)

Define on $\mathcal W_4$
$$F_4(W)=\varepsilon_{ijkl}W_{ijmn}W_{klmn}.$$

- **$SO(4)$-invariant.** $\varepsilon_{ijkl}g_{ia}g_{jb}g_{kc}g_{ld}=\det g\,\varepsilon_{abcd}$ and $g_{mp}g_{mq}=\delta_{pq}$, so $F_4(g\cdot W)=\det g\,F_4(W)$.
- **Odd under $r$.** $\det r=-1$, so $F_4(r\cdot W)=-F_4(W)$.
- **Nonzero, in closed form.** Take $\lambda=(\lambda_1,\lambda_2,\lambda_3)=(1,1,-2)$ and let $W^\lambda$ have $W_{1212}=W_{3434}=W_{1234}=\lambda_1/2$, $W_{1313}=W_{4242}=W_{1342}=\lambda_2/2$, $W_{1414}=W_{2323}=W_{1423}=\lambda_3/2$, with their curvature-symmetry images and all other components zero.
  - Bianchi on distinct indices: $W_{1234}+W_{1342}+W_{1423}=(\lambda_1+\lambda_2+\lambda_3)/2=0$. With a repeated index the Bianchi sum vanishes from the pair symmetries alone.
  - Ricci: $\mathrm{Ric}_{11}=W_{1212}+W_{1313}+W_{1414}=(\lambda_1+\lambda_2+\lambda_3)/2=0$, and likewise $\mathrm{Ric}_{22}=W_{1212}+W_{2323}+W_{2424}$, $\mathrm{Ric}_{33}$, $\mathrm{Ric}_{44}$ are each $(\lambda_1+\lambda_2+\lambda_3)/2=0$. For $j\ne l$, $W_{ijil}$ has index pairs $\{i,j\},\{i,l\}$ that are neither equal nor disjoint, and every nonzero component of $W^\lambda$ has equal or disjoint pairs, so $\mathrm{Ric}_{jl}=0$. So $W^\lambda\in\mathcal W_4$.
  - Value: in the oriented bivector basis $e_{12},e_{34},e_{13},e_{42},e_{14},e_{23}$, the Hodge star swaps $e_{12}\leftrightarrow e_{34}$, $e_{13}\leftrightarrow e_{42}$, $e_{14}\leftrightarrow e_{23}$ with sign $+1$ (the permutations $1342$, $1423$ and their inverses are 3-cycles). Let $S$ be that swap matrix and $M$ the $6\times6$ matrix of $W^\lambda$, so $M=\sum_a\lambda_a f_af_a^{\mathsf T}/2$ with $f_1=e_{12}+e_{34}$, $f_2=e_{13}+e_{42}$, $f_3=e_{14}+e_{23}$, mutually orthogonal with $|f_a|^2=2$ and $Sf_a=f_a$. Summing over the four orderings of each complementary pair gives $F_4(W)=8\,\mathrm{tr}(SM^2)$, and $M^2=\sum_a\lambda_a^2f_af_a^{\mathsf T}/2$, so $\mathrm{tr}(SM^2)=\sum_a\lambda_a^2=6$ and $F_4(W^\lambda)=48$.

So $F_4(r\cdot W^\lambda)=-48\ne48=F_4(W^\lambda)$, and by C1 **$F_4$ has no $B_n$-invariant extension for any $n\ge4$**. The sentence's argument applies to $F_4$ word for word and yields zero extensions, not one. Its conclusion for $n_0\ge k_B(d)$ therefore depends on something the sentence does not say. The screen sits outside the step's hypothesis because $k_B(2)\ge8>4$, and it is not offered as a counterexample to the step's conclusion.

## 3. The strongest reading: the conclusion is true, via Lemma S

### 3.1 Lemma S

**For $m\ge4d$, every $SO(m)$-invariant form $F$ of degree $d$ on $\mathcal W_m$ is $O(m)$-invariant, and equals $\sum_\pi a_\pi C^{(m)}_\pi$ on $\mathcal W_m$.**

Proof. Let $\pi_m$ be the $O(m)$-equivariant orthogonal projection of $(\mathbb R^m)^{\otimes4}$ onto $\mathcal W_m$. The polarisation $P$ of $F\circ\pi_m$ is an $SO(m)$-invariant multilinear form on $(\mathbb R^m)^{\otimes4d}$. By the first fundamental theorem for $SO(m)$, such forms are spanned by complete $\delta$-contractions along perfect matchings of the $4d$ slots together with terms $\varepsilon(\text{$m$ slots})\cdot\prod\delta(\text{remaining pairs})$, the latter present only when $m\le4d$ and $4d-m$ is even. Under $m\ge4d$ an $\varepsilon$-term occurs only at $m=4d$, where it is $c\,\varepsilon_{i_1\dots i_{4d}}$ on all slots (reordering slots only changes the sign). On $W^{\otimes d}$ with $W\in\mathcal W_m$ it evaluates to
$$c\,\varepsilon_{i_1\dots i_{4d}}W_{i_1i_2i_3i_4}\cdots W_{i_{4d-3}\dots i_{4d}},$$
which contracts the antisymmetric indices $i_1,\dots,i_4$ against $W$ and so sees only $W_{[i_1i_2i_3i_4]}$. That part is zero: averaging over positions $2,3,4$ and using $W_{ijkl}=-W_{ijlk}$ gives $W_{i[jkl]}=\tfrac13(W_{ijkl}+W_{iklj}+W_{iljk})=0$ by Bianchi, and full antisymmetrisation factors through this average. Hence $F(W)=P(W,\dots,W)=\sum_\pi a_\pi C^{(m)}_\pi(W)$, a combination of $O(m)$-invariants. $\square$

The range is sharp for the argument: at $m=4<4d=8$ the term $\varepsilon_{ijkl}\delta_{mm'}\delta_{nn'}$ pairs only two slots of each factor with $\varepsilon$, and Section 2.5 shows it survives.

### 3.2 C3 and C4 under H1, H7 and Lemma S

Assume $n\ge n_0\ge k_B(d)$. By H7, $n_0\ge4d$, so Lemma S makes $F$ $O(n_0)$-invariant. Part 1's $G$ is then an $O(n)$-invariant, hence $B_n$-invariant, extension, which is C3. C2 makes it the only one. For C4, "the $SO(n)$-invariant extension" is well defined: any $SO(n)$-invariant extension is $O(n)$-invariant by Lemma S at $m=n\ge4d$, hence $B_n$-invariant, hence equal to $G$ by C2.

### 3.3 H7 checked

$T\in\mathcal W_4$ with $T_{1234}=1$, $T_{1342}=-1$, $T_{1423}=0$ satisfies Bianchi ($1-1+0=0$) and is traceless because every Ricci component $T_{ijil}$ carries a repeated index and every nonzero component of $T$ has four distinct indices. The symmetric product of the $d$ block translates of $T$ in $\mathrm{Sym}^d\mathcal W_{4d}$ has a nonzero component at a multi-index with $4d$ distinct values (only the ordering matching blocks to factors contributes). A signed permutation carries an element supported on $m$ index values to one supported on $m$ values, and components are linear, so for $m<4d$ the span of translates of padded $\mathrm{Sym}^d\mathcal W_m$ misses this element at $n=4d$. Hence $g(d)\ge4d$, and $k_B(d)\ge g(d)$ because a surjection from a module generated in degree $d'$ makes the target generated in degree $d'$ (the note after Definition 2.7).

### 3.4 The defence attempted

- **Defence 1: "exactly one" was meant as "at most one, and it is $G$".** Under that reading C1, C2 and Section 2.3 suffice and the stated reason does real work. The words say "exactly one", and the $O$-version of part 2 asserts existence through $G$, so "the same holds" carries existence with it. The weaker reading is not what the sentence says.
- **Defence 2: the range makes the $SO$ case collapse to the $O$ case, and the author knew it.** True (Lemma S), and it is the repair. The sentence gives a different reason, one that is blind to the range, and Section 2.5 shows the range is indispensable. The reason as written does not establish the step.
- **Defence 3: vacuity.** If $k_B(d)=\infty$ the step holds vacuously. Under H1, the only reading with content, the gap stands.

The failure is located at the inference from the reflection clause to existence (C3). It is exhibited in closed form by $F_4$ and $W^\lambda$, where the same reasoning produces no extension. The strongest defence, Lemma S plus $k_B(d)\ge4d$, proves the conclusion but is absent from the sentence.

**Repair.** Replace the reason with: "because $n_0\ge k_B(d)\ge4d$, and for $m\ge4d$ the only $\varepsilon$-term the first fundamental theorem for $SO(m)$ allows in degree $d$ is the full contraction, which vanishes on $\mathcal W_m$ since $W_{[ijkl]}=0$, so $SO(m)$- and $O(m)$-invariant forms of degree $d$ on $\mathcal W_m$ coincide for $m\in\{n_0,n\}$." The same observation is what part 1's $SO$ clause needs, since for $n_0<4d$ the form $F_4$ has no $SO(n)$-invariant extension at odd $n$ either ($-I\in O(n)$ acts trivially on even-rank tensors).

**Verdict: FAILS**

# Verifier v389, adjudication of step H1 in round L64-r2

Cold brief ([ADJ_L64r2_H1.md](ADJ_L64r2_H1.md)), no numerical work, every value exact and derived by hand, no scripts. Log: [agent_logs/verify-L64-v389.log](../agent_logs/verify-L64-v389.log).

| Claim | Verdict |
| --- | --- |
| For every $n\ge n_0$, every $SO(n_0)$-invariant form $F$ of degree $d$ on $\mathcal W_{n_0}$ has an $SO(n)$-invariant extension to $\mathcal W_n$ (the step) | **FAILS** |
| For $n>n_0$, any form on $\mathcal W_{n_0}$ with an $SO(n)$-invariant extension is $O(n_0)$-invariant | **VALID** |
| The supplied object $F(W)=\sum\varepsilon_{ijkl}W_{abij}W_{abkl}$ on $\mathcal W_4$ is $SO(4)$-invariant, satisfies $F(g\cdot W)=\det(g)\,F(W)$, and is nonzero | **VALID** |
| The explicit $W\in\mathcal W_4$ of section 2 has $F(W)=192$ and $F(r\cdot W)=-192$ for $r=\mathrm{diag}(-1,1,1,1)$ | **VALID** |
| Passage A's justifying clause: an $SO(n_0)$-invariant form with a $B_n$-invariant extension is $O(n_0)$-invariant | **VALID** |
| The step under the reading "$F$ is $SO(n_0)$-invariant and also $O(n_0)$-invariant", or $n_0$ odd, or $n=n_0$ | **VALID** |

**Summary: the step fails for every $n>n_0$ at $n_0=4$, $d=2$, because $\mathrm{diag}(-1,1,\dots,1,-1)\in SO(n)$ acts on the padded copy as the reflection $\mathrm{diag}(-1,1,1,1)$, so an $SO(n)$-invariant extension forces $F(r\cdot W)=F(W)$, while the supplied $SO(4)$-invariant form has $F(W)=192$ and $F(r\cdot W)=-192$ on an explicit Weyl tensor.**

## 0. Conventions, fixed once

Quoted from the brief:

- "$\mathcal W_n$ is the space of algebraic Weyl tensors on $\mathbb R^n$: 4-tensors with the curvature symmetries $W_{ijkl}=-W_{jikl}=-W_{ijlk}=W_{klij}$, the first Bianchi identity $W_{ijkl}+W_{iklj}+W_{iljk}=0$, and every Ricci contraction zero, with the Frobenius inner product. $\mathcal W_n=0$ for $n\le3$."
- "$O(n)$, and its subgroups $SO(n)$ and the signed permutation group $B_n$, act on $\mathcal W_n$ by $(g\cdot W)_{ijkl}=g_{ia}g_{jb}g_{kc}g_{ld}W_{abcd}$. Zero-padding sends $W\in\mathcal W_{n_0}$ to the tensor on $\mathbb R^n$ with the same components on indices in $[n_0]$ and zero elsewhere."
- "$\mathrm{Sym}^d\mathcal W_n^*$ is the space of homogeneous polynomials of degree $d$ on $\mathcal W_n$."
- The step: "for every $n\ge n_0$, an $SO(n_0)$-invariant form $F$ of degree $d$ on $\mathcal W_{n_0}$ has an $SO(n)$-invariant extension to $\mathcal W_n$, a form restricting to $F$ on the padded copy."

Write $\iota:\mathcal W_{n_0}\to\mathcal W_n$ for zero-padding. An extension of $F$ is a form $G$ on $\mathcal W_n$ with $G\circ\iota=F$. Summation over repeated indices is written out or implied, ranging over $[n_0]$ on $\mathcal W_{n_0}$.

## 1. Hypothesis inventory

1. **$F$ is a form of degree $d$ on $\mathcal W_{n_0}$ invariant under $SO(n_0)$.** This is the only hypothesis on $F$ the step states. For the supplied object it holds (section 2.1).
2. **$n\ge n_0$, with no hypothesis on $n_0$.** Passage A part 1 says "No hypothesis on $n_0$ enters", and the SO sentence carries that over. The object takes $n_0=4$, $n=5$.
3. **An extension exists and is $SO(n)$-invariant.** This is the conclusion under test.
4. **Implicit hypothesis the step would need: $F$ is $O(n_0)$-invariant.** Section 2.2 shows it is necessary whenever $n>n_0$, and Passage A part 1 shows it is sufficient. It is not written into the step.
5. **Imported theorems.** Part 1 of Passage A uses the first fundamental theorem for $O(n_0)$ only. Proposition 2.9 of Levin and Chandrasekaran enters part 2, which the step does not use. No imported result is needed to decide the step.

## 2. The argument

### 2.1 The object is $SO(4)$-invariant and odd under reflections

For $g\in O(4)$ and $W\in\mathcal W_4$,

$$F(g\cdot W)=\sum \varepsilon_{ijkl}\,g_{aa'}g_{bb'}g_{ii'}g_{jj'}W_{a'b'i'j'}\,g_{aa''}g_{bb''}g_{kk'}g_{ll'}W_{a''b''k'l'}.$$

Orthogonality gives $\sum_a g_{aa'}g_{aa''}=\delta_{a'a''}$ and the same for $b$. The defining property of the determinant gives $\sum_{ijkl}\varepsilon_{ijkl}g_{ii'}g_{jj'}g_{kk'}g_{ll'}=\det(g)\,\varepsilon_{i'j'k'l'}$. Hence

$$F(g\cdot W)=\det(g)\,F(W).$$

So $F$ is $SO(4)$-invariant, a quadratic form on $\mathcal W_4$, and $F(r\cdot W)=-F(W)$ for $r=\mathrm{diag}(-1,1,1,1)$. It is $O(4)$-invariant only if it vanishes identically, which section 2.3 rules out.

### 2.2 An $SO(n)$-invariant extension forces $O(n_0)$-invariance when $n>n_0$

Let $n>n_0$, let $G$ be an $SO(n)$-invariant form on $\mathcal W_n$ with $G\circ\iota=F$, and set

$$g=\mathrm{diag}(-1,1,\dots,1,-1)\in SO(n),\qquad r=\mathrm{diag}(-1,1,\dots,1)\in O(n_0).$$

The matrix $g$ is diagonal with entries $s_1=-1$, $s_n=-1$, and $s_m=1$ otherwise, so $\det g=+1$. Its action is $(g\cdot T)_{ijkl}=s_is_js_ks_l\,T_{ijkl}$. On $\iota(W)$ every component with an index equal to $n$ is zero, and on indices in $[n_0]$ the signs $s_m$ agree with those of $r$. Hence

$$g\cdot\iota(W)=\iota(r\cdot W)\quad\text{for every }W\in\mathcal W_{n_0}.$$

Therefore

$$F(r\cdot W)=G(\iota(r\cdot W))=G(g\cdot\iota(W))=G(\iota(W))=F(W).$$

Every element of $O(n_0)\setminus SO(n_0)$ is $r$ times an element of $SO(n_0)$, so $F$ is $O(n_0)$-invariant. This argument uses only the definitions of section 0.

### 2.3 An explicit Weyl tensor on which the object is nonzero

Define $W$ on $\mathbb R^4$ by the components

$$W_{1212}=W_{3434}=2,\quad W_{1234}=2,$$
$$W_{1313}=W_{2424}=-1,\quad W_{1324}=1,$$
$$W_{1414}=W_{2323}=-1,\quad W_{1423}=-1,$$

together with every image of these under the curvature symmetries $W_{ijkl}=-W_{jikl}=-W_{ijlk}=W_{klij}$, and zero on every other multi-index. The listed values are consistent: no two of them are related by a curvature symmetry, since the index pairs $\{\{1,2\},\{3,4\}\}$, $\{\{1,3\},\{2,4\}\}$, $\{\{1,4\},\{2,3\}\}$ and the diagonal pairs $\{\{i,j\},\{i,j\}\}$ are distinct.

**Curvature symmetries.** They hold by construction.

**Bianchi identity.** For a tensor with the curvature symmetries, the cyclic sum $W_{ijkl}+W_{iklj}+W_{iljk}$ equals $3W_{[ijkl]}$, the total antisymmetrisation (standard: the 24 terms of $W_{[ijkl]}$ fall into the three cyclic types, eight terms each, all equal within a type). So every component with a repeated index vanishes automatically, and in dimension 4 the one remaining condition is

$$W_{1234}+W_{1342}+W_{1423}=2+(-W_{1324})+(-1)=2-1-1=0.$$

**Ricci contractions.** The nonzero components have index multiset $\{i,i,j,j\}$ with $i\ne j$ or $\{1,2,3,4\}$. The component $W_{ijil}$ with $j\ne l$ has multiset $\{i,i,j,l\}$ with three distinct values when $i\notin\{j,l\}$, and a triple index otherwise, so it vanishes and the off-diagonal Ricci components are zero. With $K_{ij}=W_{ijij}$, the values are $K_{12}=K_{34}=2$ and $K_{13}=K_{24}=K_{14}=K_{23}=-1$. The diagonal Ricci components are

$$\mathrm{Ric}_{11}=K_{12}+K_{13}+K_{14}=0,\quad \mathrm{Ric}_{22}=K_{12}+K_{23}+K_{24}=0,$$
$$\mathrm{Ric}_{33}=K_{13}+K_{23}+K_{34}=0,\quad \mathrm{Ric}_{44}=K_{14}+K_{24}+K_{34}=0.$$

Every other Ricci contraction equals $\pm$ this one by the curvature symmetries. So $W\in\mathcal W_4$.

**Evaluating $F$.** For an antisymmetric $X$ on $\mathbb R^4$, group the ordered sum $\sum_{ijkl}\varepsilon_{ijkl}X_{ij}X_{kl}$ by the unordered partition $\{\{i,j\},\{k,l\}\}$ of $[4]$. Each partition contributes 8 equal terms (swap within each pair: both $\varepsilon$ and $X$ change sign, swap the pairs: $\varepsilon$ is unchanged). With $\varepsilon_{1234}=1$, $\varepsilon_{1324}=-1$, $\varepsilon_{1423}=1$,

$$\sum_{ijkl}\varepsilon_{ijkl}X_{ij}X_{kl}=8\,Q(X),\qquad Q(X)=X_{12}X_{34}-X_{13}X_{24}+X_{14}X_{23}.$$

Put $X^{ab}_{ij}=W_{abij}$. Since $X^{ba}=-X^{ab}$ and $Q$ is quadratic, $F(W)=2\cdot 8\sum_{a<b}Q(X^{ab})$. Reading off the components:

| $(a,b)$ | nonzero entries of $X^{ab}$ | $Q(X^{ab})$ |
| --- | --- | --- |
| $(1,2)$ | $X_{12}=2$, $X_{34}=2$ | $4$ |
| $(3,4)$ | $X_{12}=2$, $X_{34}=2$ | $4$ |
| $(1,3)$ | $X_{13}=-1$, $X_{24}=1$ | $1$ |
| $(2,4)$ | $X_{13}=1$, $X_{24}=-1$ | $1$ |
| $(1,4)$ | $X_{14}=-1$, $X_{23}=-1$ | $1$ |
| $(2,3)$ | $X_{14}=-1$, $X_{23}=-1$ | $1$ |

So $F(W)=16\cdot12=192$.

**Evaluating $F(r\cdot W)$ directly.** $(r\cdot W)_{ijkl}=W_{ijkl}$ times $(-1)$ raised to the number of indices equal to 1. The diagonal components $K_{ij}$ keep their sign, and $W_{1234}\mapsto-2$, $W_{1324}\mapsto-1$, $W_{1423}\mapsto1$. The six values of $Q$ become $-4,-4,-1,-1,-1,-1$, so $F(r\cdot W)=-192$, in agreement with section 2.1.

### 2.4 The failure, located

Take $n_0=4$, $d=2$, and any $n\ge5$ (in particular $n=5$). If $G$ were an $SO(n)$-invariant extension of $F$, section 2.2 would give $F(r\cdot W)=F(W)$, that is $-192=192$. **No $SO(n)$-invariant form on $\mathcal W_n$ restricts to $F$ on the padded copy, for any $n>4$.** The step as written is false.

The failure sits in carrying part 1's proof over to $SO$. The first fundamental theorem for $SO(n_0)$ writes an $SO(n_0)$-invariant multilinear form as a combination of complete contractions along matchings and of contractions carrying one or more Levi-Civita symbols $\varepsilon^{(n_0)}$ on $n_0$ slots. Step (ii) of Passage A lifts a matching contraction $C^{(n_0)}_\pi$ to $C^{(n)}_\pi$, but an $\varepsilon^{(n_0)}$ factor has no $SO(n)$-invariant counterpart with $n_0$ slots once $n>n_0$. The supplied $F$ is exactly such a term. Passage A's justifying clause, "an $SO(n_0)$-invariant form with a $B_n$-invariant extension is $O(n_0)$-invariant", is correct, and section 2.2 is its $SO(n)$ analogue: both show that the $SO$ version reaches only forms that were already $O(n_0)$-invariant, which is a restriction of scope and not a transfer.

The same object bears on the $SO$ reading of part 2, where "exactly one $B_n$-invariant extension" becomes "none" for a form that is not $O(n_0)$-invariant. That reading is outside the step and is recorded here only as the same mechanism.

### 2.5 The strongest defence, and the hypotheses it needs

- **Reading (a): the justifying clause restricts scope.** "The same holds with $SO$ in place of $O$" is read as applying to those $SO(n_0)$-invariant forms that admit a $B_n$-invariant (or $SO(n)$-invariant) extension. Such $F$ is $O(n_0)$-invariant by the clause or by section 2.2, and part 1 then gives an $O(n)$-invariant, hence $SO(n)$-invariant, extension. **VALID**, with the hypothesis "$F$ is $O(n_0)$-invariant" in place of "$F$ is $SO(n_0)$-invariant". This is part 1 itself, and the word "every" in the step is lost.
- **Reading (b): only the extension's invariance is weakened.** $F$ stays $O(n_0)$-invariant and the conclusion asks for $SO(n)$-invariance. **VALID** and immediate from part 1, since $SO(n)\subset O(n)$.
- **Reading (c): $n_0$ odd.** Then $-I_{n_0}\in O(n_0)\setminus SO(n_0)$ acts trivially on 4-tensors, because $(-1)^4=1$, so every $SO(n_0)$-invariant form is $O(n_0)$-invariant and part 1 applies. **VALID** for odd $n_0$, with that hypothesis unwritten.
- **Reading (d): $n=n_0$.** $G=F$ works. **VALID** and trivial.

None of these is the step as written, which quantifies over every $SO(n_0)$-invariant form and every $n\ge n_0$ with no hypothesis on $n_0$. The object at $n_0=4$, $n=5$ lies inside that quantifier and outside all four readings.

### 2.6 Three checks before FAILS

1. **Located.** The step fails at the passage from $O(n_0)$-invariant to $SO(n_0)$-invariant $F$, in part 1 with $n>n_0$ and $n_0$ even. In the proof it fails at step (ii), which has no lift for $\varepsilon^{(n_0)}$-contractions.
2. **Exhibited in closed form.** $n_0=4$, $d=2$, $n=5$, $F(W)=\sum\varepsilon_{ijkl}W_{abij}W_{abkl}$, the explicit $W$ of section 2.3 with $F(W)=192$ and $F(r\cdot W)=-192$, and $g=\mathrm{diag}(-1,1,1,1,-1)\in SO(5)$ with $g\cdot\iota(W)=\iota(r\cdot W)$.
3. **Strongest defence stated.** Section 2.5: the step holds exactly when $F$ is $O(n_0)$-invariant (automatic for odd $n_0$) or $n=n_0$, and those hypotheses are not in the text.

**Verdict: FAILS**

# Verifier v390, adjudication of step H2 in round L64-r2

Cold brief ([ADJ_L64r2_H2.md](ADJ_L64r2_H2.md) and the Levin–Chandrasekaran [paper.pdf](https://arxiv.org/abs/2307.04230) and [txt.txt](https://arxiv.org/abs/2307.04230) only). No numerical work: every value below is exact and derived by hand, and no script was written or run. Log: [agent_logs/verify-L64-v390.log](../agent_logs/verify-L64-v390.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | At most one $B_n$-invariant extension exists for any form on $\mathcal W_{n_0}$ when $n\ge n_0\ge k_B(d)$ (Proposition 2.9) | VALID |
| 2 | The stated reason: an $SO(n_0)$-invariant form with a $B_n$-invariant extension is $O(n_0)$-invariant | VALID |
| 3 | Under the reading "an $SO(n_0)$-invariant form with a $B_n$-invariant extension", that extension is unique and equals the $O(n)$-invariant (hence $SO(n)$-invariant) extension of part 1, by the stated reason | VALID |
| 4 | The stated reason, alone, supplies existence of a $B_n$-invariant extension for every $SO(n_0)$-invariant $F$ | FAILS |
| 5 | Existence nonetheless holds in range: for $n_0\ge4d$ every $SO(n_0)$-invariant degree-$d$ form on $\mathcal W_{n_0}$ is $O(n_0)$-invariant (first fundamental theorem for $SO$ plus the Bianchi identity) | VALID |
| 6 | Passage A's bound $k_B(d)\ge g(d)\ge4d$, which places the range inside $n_0\ge4d$ | VALID |
| 7 | The step, on its strongest reading (claim 3, with claim 5 supplying the unconditional form) | VALID |

**Summary: the step holds, since the reflection argument makes any $B_n$-invariant extension of an $SO(n_0)$-invariant form the unique $O(n)$-invariant one, and existence for every such form, which the stated reason does not itself supply, follows in range because $n_0\ge k_B(d)\ge4d$ leaves no pseudo-invariant of degree $d$ on $\mathcal W_{n_0}$.**

## 0. Conventions, fixed once

Quoted from the brief:

- "$\mathcal W_n$ is the space of algebraic Weyl tensors on $\mathbb R^n$: 4-tensors with the curvature symmetries $W_{ijkl}=-W_{jikl}=-W_{ijlk}=W_{klij}$, the first Bianchi identity $W_{ijkl}+W_{iklj}+W_{iljk}=0$, and every Ricci contraction zero, with the Frobenius inner product. $\mathcal W_n=0$ for $n\le3$."
- "$O(n)$, and its subgroups $SO(n)$ and the signed permutation group $B_n$, act on $\mathcal W_n$ by $(g\cdot W)_{ijkl}=g_{ia}g_{jb}g_{kc}g_{ld}W_{abcd}$. Zero-padding sends $W\in\mathcal W_{n_0}$ to the tensor on $\mathbb R^n$ with the same components on indices in $[n_0]$ and zero elsewhere."
- "$\mathrm{Sym}^d\mathcal W_n^*$ is the space of homogeneous polynomials of degree $d$ on $\mathcal W_n$."
- Setting of Passage A: "$k_B(d)$ is that module's presentation degree, in the sense of Definition 2.7 of Levin–Chandrasekaran, and $g(d)\le k_B(d)$ is its generation degree."

Write $J:\mathcal W_{n_0}\to\mathcal W_n$ for zero-padding and $r=\mathrm{diag}(-1,1,\dots,1)\in B_{n_0}$. $B_{n_0}$ sits in $B_n$ as $h\mapsto\mathrm{blkdiag}(h,I_{n-n_0})$, as in Example 1.5.

The step under adjudication: "when $n\ge n_0\ge k_B(d)$, an $SO(n_0)$-invariant form $F$ of degree $d$ on $\mathcal W_{n_0}$ has exactly one $B_n$-invariant extension, which is therefore the $SO(n)$-invariant extension of part 1, and the sentence's stated reason establishes this." The sentence is "The same holds with $SO$ in place of $O$, because $B_{n_0}$ contains the reflection $\mathrm{diag}(-1,1,\dots,1)$: an $SO(n_0)$-invariant form with a $B_n$-invariant extension is $O(n_0)$-invariant."

## 1. Hypothesis inventory

- **(H1) $\{\mathrm{Sym}^d\mathcal W_n^*\}$ is a $V$-module over $V=\{\mathbb R^n\}$ with $G_n=B_n$, and $k_B(d)<\infty$.** Definition 2.7 and Proposition 2.9 need both. The Setting asserts the module structure. Finiteness is what "$n_0\ge k_B(d)$" presupposes, and Passage A records that no finite value is on file. The step is conditional on it, as the lemma is, so it is carried as a hypothesis and never used as established. Checked: the step asserts nothing when (H1) fails.
- **(H2) The consistent-sequence embedding of $\mathrm{Sym}^d\mathcal W_n^*$ is $\mathrm{Sym}^d$ of padding, so its adjoint $P_{U_{n_0}}$ is restriction to the padded copy.** Checked in §2.1.
- **(H3) The embedding $B_{n_0}\subset B_n$ is block-diagonal and $J$ is $B_{n_0}$-equivariant.** Checked in §2.2.
- **(H4) $O(n_0)=SO(n_0)\cup r\,SO(n_0)$.** Standard, since $\det r=-1$.
- **(H5) Part 2 for $O$: an $O(n_0)$-invariant $F$ with $n\ge n_0\ge k_B(d)$ has exactly one $B_n$-invariant extension, the $O(n)$-invariant $G=\sum_\pi a_\pi C^{(n)}_\pi$.** This is the lemma's own part 2, which the SO sentence reduces to. Existence of $G$ and its $O(n)$-invariance come from part 1's steps (i) and (ii). $O(n)\supset B_n$ gives $B_n$-invariance, and uniqueness is claim 1. Taken as given from the passage for the reduction, with claim 1 rechecked independently.
- **(H6) Either the conditional reading ("with a $B_n$-invariant extension"), or the supplied fact of claim 5 together with $k_B(d)\ge4d$.** This is the ingredient the SO sentence does not write. Checked in §2.4 to §2.6.

## 2. The argument

### 2.1 Restriction is Levin–Chandrasekaran's projection

Identify a degree-$d$ polynomial $q$ on $\mathcal W_n$ with the element of $\mathrm{Sym}^d\mathcal W_n$ satisfying $q(x)=\langle q,x^d\rangle$. The embedding $\mathrm{Sym}^dJ$ is an isometry, and its adjoint is $\mathrm{Sym}^dJ^*$. For $y\in\mathcal W_{n_0}$, $(\mathrm{Sym}^dJ^*q)(y)=\langle\mathrm{Sym}^dJ^*q,y^d\rangle=\langle q,(Jy)^d\rangle=q(Jy)$. So the projection $P_{U_{n_0}}$ of Definition 1.3 is restriction to the padded copy, and "extension" in the lemma means a preimage under that projection. The composite from $n$ down to $n_0$ is the composite of the one-step projections, each mapping $G_{m+1}$-invariants to $G_m$-invariants (proof of Proposition 2.3).

### 2.2 Claim 1, uniqueness for any form

Proposition 2.9 (txt.txt line 950 to 952, verbatim in the brief) makes each $P_{U_m}:U_{m+1}^{B_{m+1}}\to U_m^{B_m}$ an isomorphism for $m\ge k_B(d)$. For $n\ge n_0\ge k_B(d)$ the composite from $U_n^{B_n}$ to $U_{n_0}^{B_{n_0}}$ is therefore an isomorphism. If $G_1,G_2$ are $B_n$-invariant extensions of the same $F$, then $G_1-G_2$ is $B_n$-invariant and restricts to $0$, so $G_1=G_2$. This uses no invariance of $F$ at all. **VALID.**

### 2.3 Claim 2, the stated reason

Let $G$ be a $B_n$-invariant extension of $F$, so $F=G\circ J$. For $h\in B_{n_0}$ put $g=\mathrm{blkdiag}(h,I)$. For $W\in\mathcal W_{n_0}$ and $i,j,k,l\in[n_0]$, $(g\cdot JW)_{ijkl}=h_{ia}h_{jb}h_{kc}h_{ld}W_{abcd}=(J(h\cdot W))_{ijkl}$, since $g_{ia}=0$ for $i\le n_0<a$. If some index, say $i$, exceeds $n_0$, then $g_{ia}=\delta_{ia}$ forces $a>n_0$ and the padded component vanishes, matching $J(h\cdot W)$. So $g\cdot JW=J(h\cdot W)$, and $F(h\cdot W)=G(g\cdot JW)=G(JW)=F(W)$. Hence $F$ is $B_{n_0}$-invariant, in particular $r$-invariant. An $SO(n_0)$-invariant form that is also $r$-invariant is invariant under the group generated, which is $O(n_0)$ by (H4). **VALID.**

### 2.4 Claim 3, the conditional reading

Suppose $F$ is $SO(n_0)$-invariant and has a $B_n$-invariant extension $G'$, with $n\ge n_0\ge k_B(d)$. By claim 2, $F$ is $O(n_0)$-invariant. By (H5), $F$ has the $O(n)$-invariant extension $G$, which is $B_n$-invariant because $B_n\subset O(n)$. By claim 1, $G'=G$. So $F$ has exactly one $B_n$-invariant extension, and it is $G$, which is $SO(n)$-invariant because $SO(n)\subset O(n)$. This is word for word what the SO sentence's colon clause licenses: "an $SO(n_0)$-invariant form with a $B_n$-invariant extension". **VALID.**

### 2.5 Claim 4, where the stated reason stops

The step as quoted asserts existence unconditionally: every $SO(n_0)$-invariant $F$ "has exactly one $B_n$-invariant extension". The stated reason is an implication whose premise is the existence of such an extension, so it cannot deliver that existence. Proposition 2.9's surjectivity does not repair this by itself either: it produces a $B_n$-invariant preimage only of a $B_{n_0}$-invariant $F$, and $B_{n_0}$-invariance of an $SO(n_0)$-invariant $F$ is again $r$-invariance, the very point at issue.

The inference pattern "$SO(n_0)$-invariant, hence extends $B_n$-invariantly" is false without a range condition. Screen, outside the step's range and reported only to locate the gap: at $n_0=4$, $d=2$, $F(W)=\varepsilon^{abef}W_{abcd}W_{ef}{}^{cd}$ is $SO(4)$-invariant. Under $r$ the tensor $\varepsilon$ changes sign and $W$'s contraction does not, so $F\circ r=-F$. In the standard splitting $\mathcal W_4=\mathcal W^+\oplus\mathcal W^-$ into self-dual and anti-self-dual parts, $F$ is a nonzero multiple of $\lvert W^+\rvert^2-\lvert W^-\rvert^2$, nonzero on any $W\in\mathcal W^+\setminus0$. By claim 2 this $F$ has no $B_n$-invariant extension for any $n\ge4$, although it is $SO(4)$-invariant. The same reflection argument, run with $\mathrm{diag}(-1,1,\dots,1,-1)\in SO(n)$ for $n>n_0$, shows it has no $SO(n)$-invariant extension either, so the SO transcription of part 1 needs $O(n_0)$-invariance as well. That is outside the step. Here $k_B(2)\ge8>4$, so the screen does not contradict the step. It shows only that the range hypothesis must do work the SO sentence does not name. **FAILS** as a claim about the stated reason alone.

### 2.6 Claim 5, no pseudo-invariants once $n_0\ge4d$

Let $F$ be an $SO(n_0)$-invariant degree-$d$ form on $\mathcal W_{n_0}$, and split $F=F_++F_-$ with $F_\pm=\tfrac12(F\pm F\circ r)$. Both are $SO(n_0)$-invariant because $r$ normalises $SO(n_0)$, $F_+$ is $O(n_0)$-invariant, and $F_-\circ r=-F_-$.

Let $\pi_{n_0}$ be the $O(n_0)$-equivariant orthogonal projection of $(\mathbb R^{n_0})^{\otimes4}$ onto $\mathcal W_{n_0}$, as in the lemma's step (i). The polarisation $\Phi$ of $F_-\circ\pi_{n_0}$ is a symmetric $d$-linear form on $(\mathbb R^{n_0})^{\otimes4}$, equivalently a $4d$-linear form on $\mathbb R^{n_0}$, invariant under $SO(n_0)$ and odd under $r$. By the first fundamental theorem for $SO(n_0)$, $4d$-linear invariants are spanned by products of pairings $\langle v_i,v_j\rangle$ and products of one determinant $\det(v_{i_1},\dots,v_{i_{n_0}})$ with pairings, a product of two determinants reducing to pairings. Pairing terms are $r$-even and single-determinant terms are $r$-odd, so $\Phi$ lies in the span of single-determinant terms. Such a term needs $n_0$ of the $4d$ slots, so:

- **If $n_0>4d$**, there is no such term, $\Phi=0$, and $F_-(W)=\Phi(W,\dots,W)=0$ for $W\in\mathcal W_{n_0}$, since $\pi_{n_0}W=W$.
- **If $n_0=4d$**, $\Phi$ is a multiple of $\varepsilon$ taking all $4d$ slots. Evaluated on $W^{\otimes d}$ it contracts the four indices of each factor $W$ into $\varepsilon$, so it factors through the total antisymmetrisation $W_{[abcd]}$. The first Bianchi identity gives $W_{a[bcd]}=0$, hence $W_{[abcd]}=0$, and $F_-(W)=0$.

So $F_-=0$ and $F=F_+$ is $O(n_0)$-invariant whenever $n_0\ge4d$. **VALID.**

### 2.7 Claim 6, the range lies inside $n_0\ge4d$

Passage A's witness, checked from the definitions. $T\in(\mathbb R^4)^{\otimes4}$ has $T_{1234}=1$, $T_{1342}=-1$, $T_{1423}=0$ and their images under the curvature symmetries, every other component zero.

- Curvature symmetries hold by construction.
- Bianchi on distinct indices is the single condition $T_{1234}+T_{1342}+T_{1423}=1-1+0=0$. Bianchi with a repeated index follows from the curvature symmetries alone. For $i=j$: $T_{iikl}=0$ and $T_{ikli}+T_{ilik}=T_{ikli}-T_{ikli}=0$, using $T_{ilik}=T_{ikil}=-T_{ikli}$. For $j=k$: $T_{ijjl}+T_{ijlj}+T_{iljj}=T_{ijjl}-T_{ijjl}+0=0$. For $i=k$: $T_{ijil}+T_{ilji}=T_{ijil}-T_{ijil}=0$, using $T_{ilji}=T_{jiil}=-T_{ijil}$. The other coincidences follow by the same symmetries.
- Ricci: $\sum_iT_{ijil}$ has a repeated index in every term, and every nonzero component of $T$ has four distinct indices, so it vanishes.

Let $T^{(k)}$ be $T$ moved to the block $\{4k-3,\dots,4k\}$ of $[4d]$. In $T^{(1)}\odot\dots\odot T^{(d)}\in\mathrm{Sym}^d\mathcal W_{4d}$, the component at $(1,2,\dots,4d)$ receives a contribution from an ordering $\sigma$ of the factors only if $T^{(\sigma(k))}$ is supported on block $k$ for every $k$, so only $\sigma=\mathrm{id}$ contributes, with value $1$ times the symmetrisation constant, which is nonzero. Every element of $\mathrm{Sym}^d\mathcal W_m$ padded into $\mathrm{Sym}^d\mathcal W_{4d}$ has components only at multi-indices with values in $[m]$, hence at most $m$ distinct values, and a signed permutation preserves the number of distinct values of a multi-index. For $m<4d$ the $B_{4d}$-span of the padded copy misses the element above, so the sequence is not generated in degree $m$ (Definition 2.2 at $n=4d$). Thus $g(d)\ge4d$, and $k_B(d)\ge g(d)$ by the note after Definition 2.7. **VALID.**

### 2.8 Assembly and the defence

For $n\ge n_0\ge k_B(d)$ and $F$ an $SO(n_0)$-invariant degree-$d$ form: claim 6 gives $n_0\ge4d$, claim 5 makes $F$ $O(n_0)$-invariant, (H5) supplies the $O(n)$-invariant, hence $B_n$-invariant and $SO(n)$-invariant, extension $G$, and claim 1 makes it the only $B_n$-invariant extension. The unconditional step is therefore true.

The attempted failure is claim 4, and the three checks were run against it. It is located exactly: the SO sentence's reason presupposes a $B_n$-invariant extension and never produces one. It is exhibited in closed form, but only outside the range, by the degree-2 pseudo-invariant at $n_0=4$. The strongest defence succeeds: the colon clause of the sentence is itself phrased conditionally ("an $SO(n_0)$-invariant form with a $B_n$-invariant extension"), and on that reading claim 3 proves the step from the stated reason, Proposition 2.9 and part 2 alone. On the unconditional reading, the one missing ingredient, claim 5, is a short standard argument that holds throughout the range by claim 6. No reading of the words yields a false statement inside the hypothesis $n\ge n_0\ge k_B(d)$, so FAILS cannot be sustained.

Hypotheses the valid reading needs: (H1) the module structure and a finite $k_B(d)$, as the lemma already assumes, and (H6) either the conditional reading or the supplied fact that $SO(n_0)$- and $O(n_0)$-invariant degree-$d$ forms on $\mathcal W_{n_0}$ coincide for $n_0\ge4d$. A faithful correction of the SO sentence would cite that fact: "The same holds with $SO$ in place of $O$: in the range of part 2, $n_0\ge4d$, so an $SO(n_0)$-invariant form of degree $d$ on $\mathcal W_{n_0}$ is $O(n_0)$-invariant, and $B_{n_0}\ni\mathrm{diag}(-1,1,\dots,1)$ shows conversely that only $O(n_0)$-invariant forms can have a $B_n$-invariant extension."

**Verdict: VALID**

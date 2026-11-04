# Review r469, Lemma L15

**Claim under audit:** Lemma L15, `findings/problem.md`, "what stops the diagonal proof from lifting, identified exactly".

**Status: outstanding** (report written incrementally; findings appended as reached).

## Findings

_(none yet)_

### F1, VERIFIED: the displayed identity is correct in the record's conventions

$\mathop{\mathrm{scal}}(R^2+R^\#)=\lVert\mathrm{Ric}(R)\rVert^2+6\lVert\mathrm{Alt}(R)\rVert^2$ checks on two anchors that separate its two terms, with $\mathop{\mathrm{scal}}(S)=2\mathop{\mathrm{tr}}_{\Lambda^2}S$, $\mathrm{Ric}(R)_{jl}=\sum_iR_{ijil}$, and $\mathrm{Alt}$ carrying its $\tfrac13$ as in `findings/conventions.md`:

- $R=\mathrm{Id}$ on $\Lambda^2$: $\mathrm{Alt}(\mathrm{Id})=0$, $\mathrm{Ric}=(n-1)g$, $\mathrm{Id}^\#=(n-2)\mathrm{Id}$ (this is $\kappa=2(n-2)$), so $Q=(n-1)\mathrm{Id}$ and $\mathop{\mathrm{scal}}(Q)=n(n-1)^2=\lVert\mathrm{Ric}\rVert^2$. Fixes the Ricci coefficient at $1$.
- $R=\star$ on $\Lambda^2\mathbb R^4$: $\mathrm{Ric}(\star)=0$, $\mathrm{Alt}(\star)=\star$, $\lVert\star\rVert^2=6$. With $\star=\Pi_+-\Pi_-$ and $\Pi_\pm^\#=2\Pi_\pm$, cross term zero: $\star^\#=2\,\mathrm{Id}$, $\star^2=\mathrm{Id}$, $Q(\star)=3\,\mathrm{Id}$, $\mathop{\mathrm{scal}}=36=6\cdot6$. Fixes the $\mathrm{Alt}$ coefficient at exactly $6$.

"No cross-term" follows from Schur: $\Lambda^4$, $S^2_0$, the trivial rep and Weyl are pairwise non-isomorphic $O(n)$-summands of $S^2(\Lambda^2)$, so an invariant quadratic form has no cross terms between them. The Weyl coefficient is $0$, which is the record's $\mathop{\mathrm{tr}}W^\#=-\lVert W\rVert^2$, re-derived directly on the diagonal locus from $M\mathbf1=0$: $\mathop{\mathrm{tr}}W^\#=\tfrac12\sum_{i\ne j}(M^2)_{ij}=\tfrac12(\mathbf1^\top M^2\mathbf1-\mathop{\mathrm{tr}}M^2)=-\mathop{\mathrm{tr}}(W^2)$.

The factor $24$ is then forced and correct: $\mathrm{Ric}(W)=0$ and $\mathrm{Alt}(W)=0$ give $\mathrm{Alt}(\lvert W\rvert)=2\,\mathrm{Alt}(W_-)$, so $6\lVert\mathrm{Alt}(\lvert W\rvert)\rVert^2=24\lVert\mathrm{Alt}(W_-)\rVert^2$.

### F2, VERIFIED: the exception is correctly identified, and it is a genuine diagonal/non-diagonal dichotomy

A coordinate-diagonal $W$ has $W_{ijkl}=0$ unless $\{i,j\}=\{k,l\}$, and $\mathrm{Alt}(R)$ is totally antisymmetric, hence supported on four distinct indices. So $\mathrm{Alt}$ annihilates every coordinate-diagonal operator, including $\lvert W\rvert$, which stays coordinate-diagonal. **On the diagonal locus $\lvert W\rvert$ does satisfy the first Bianchi identity**, which is exactly the licence Jäger's opening step needs and exactly what fails off the locus. The identification is right.

The second failure of $\lvert W\rvert$ to be Weyl ($\mathrm{Ric}(\lvert W\rvert)=2\,\mathrm{Ric}(W_-)\ne0$), is correctly **not** listed as an exception: it is present on the diagonal locus too, where it is the row-sum vector of $\lvert M\rvert$, i.e. the very "quadratic data about row sums" the block says the contraction produces. It also transfers cleanly, since $W_-\succeq0$ gives $\mathrm{Ric}(W_-)(v,v)=\sum_iW_-(e_i\wedge v,e_i\wedge v)\ge0$ with no coordinate input.

### F3, VERIFIED: the $\delta^2$ arithmetic at the competitor

At the padded $W_{\mathbb{CP}^2}=\mathrm{diag}(0,0,0,-1,-1,2)/\sqrt6$, $W_-=\tfrac1{\sqrt6}\Pi$ on the two $-1$ directions inside $\Lambda^2_+$, so $\langle W_-,\star\rangle=\mathop{\mathrm{tr}}W_-=2/\sqrt6$ and $\mathrm{Alt}(W_-)=\tfrac{\langle W_-,\star\rangle}{6}\star=\tfrac1{3\sqrt6}\star$. That is `conventions.md`'s $a=1/(3\sqrt6)$ on the nose, and $\delta^2=a^2\lVert\star\rVert^2=1/9$, matching Conjecture L16's "defect exactly $1/9$ in every ambient dimension". The sign convention $W_-=\tfrac12(\lvert W\rvert-W)\succeq0$ is respected; and $\delta^2$ is even in $W_-$, so the sign trap that has refuted four lemmas here cannot bite this display.

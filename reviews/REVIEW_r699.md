# REVIEW r699, the scalar-$h$ equality lemma of [DERIVE-j5.md](DERIVE-j5.md) batch 2

**Verdict: CONFIRMED.** Every step of the offered proof holds from the definitions, and each record input it cites checks out by hand. Three corrections, one of them substantive: the lemma's core step uses no hypothesis on $h$ at all, so it proves more than it states, and what it proves is the operator form of [Lemma L7](../findings/bounds.md)'s equality class, a cross-reference the batch missed.

*Analysis only, per the standing rule; no computation was run. Every identity below was re-derived by hand from $W=W_+-W_-$, $\lvert W\rvert=W_++W_-$, bilinearity and PSD-preservation of $\#$, and the operator equation $W^2+W^\#=\theta W$.*

## 1. The record inputs, each verified

| input | what it says | check |
| --- | --- | --- |
| $\lvert W\rvert^\#=W^\#+4C$, $2G=\lvert W\rvert^\#+W^\#$ | with $C=W_+\#W_-$, $G=W_+^\#+W_-^\#$ | bilinear symmetric $\#$: $(W_+\pm W_-)^\#=G\pm2C$. Holds for every symmetric $W$, critical or not. |
| Result 5(a), $++$ block | $P_+X_{\mathrm{inv}}P_+=4P_+CP_+$ | $P_+(\lvert W\rvert^\#-W^\#)P_+=4P_+CP_+$. Hypothesis-free. |
| Result 5(a), $--$ block | $P_-X_{\mathrm{inv}}P_-=2P_-GP_-$ | $P_-(\lvert W\rvert^\#+W^\#)P_-=2P_-GP_-$. Hypothesis-free. |
| Result 5(a), $00$ block | $P_0X_{\mathrm{inv}}P_0=P_0\lvert W\rvert^\#P_0$ | immediate from the definition. Hypothesis-free. |
| PSD of the three blocks | | $C\succeq0$, $G\succeq0$, $\lvert W\rvert^\#\succeq0$ by $A\#B\succeq0$ for $A,B\succeq0$; a compression of a PSD operator is PSD. |
| Theorem A | $X_{\mathrm{inv}}=4C-2\theta W_--2W_-^2$ at critical points | on $\operatorname{ran}P_+$, $W^\#=\theta W_+-W_+^2$; on $\operatorname{ran}P_-$, $W^\#=-\theta W_--W_-^2$; so $-P_+W^\#P_++P_-W^\#P_-=-\theta\lvert W\rvert+W_+^2-W_-^2$ and $\lvert W\rvert^\#=4C+\theta W-W^2$; the $W_+$ terms cancel exactly. |
| consistency of the two $--$ forms | $2P_-GP_-$ versus $4P_-CP_--2\theta W_--2W_-^2$ | $4C=2G-2W^\#$ and $P_-W^\#P_-=-\theta W_--W_-^2$ give $4P_-CP_-=2P_-GP_-+2\theta W_-+2W_-^2$; the two forms are the same operator, and it is PSD by the first form whatever the sign of $\theta$. |
| $P_0W^\#=0$ | | $W^\#=\theta W-W^2$ kills $\ker W$, and $W^\#$ is symmetric, so $P_0W^\#=(W^\#P_0)^{\mathsf T}=0$. Needs exactly $Q(W)=\theta W$ as an operator, which is the record's definition of a critical point ([conventions.md](../findings/conventions.md)); $Q$ preserves $\mathcal W_n$, so the constrained critical-point equation is the operator equation. |
| batch 1 (2), $H$ in $h$'s frame | eigenvalues $\eta_i+\eta_j$ on $e_i\wedge e_j$ | $\langle\mathrm{Ric}(A),h\rangle=\sum_i\eta_i\sum_{k\ne i}A_{ik,ik}=\sum_{i<k}(\eta_i+\eta_k)A_{ik,ik}$ for $h$ diagonal, with $\{e_i\wedge e_k\}_{i<k}$ orthonormal. Confirmed. The lemma needs less: $\langle\mathrm{Ric}(X),\lambda\,\mathrm{id}\rangle=\lambda\operatorname{tr}\mathrm{Ric}(X)=2\lambda\operatorname{tr}X$ directly. |

## 2. The proof, step by step

- **$\lambda>0$.** $\operatorname{tr}h=\operatorname{tr}\mathrm{Ric}(\lvert W\rvert)=2\operatorname{tr}\lvert W\rvert$, positive whenever $W\ne0$. *Correction (minor): the statement needs $W\ne0$; $W=0$ satisfies $Q(W)=\theta W$ for every $\theta$ and has $\lambda=0$. The record's critical points are unit-norm, so this is a missing word rather than a gap.*
- **The pairing constant is positive.** $J_5=\lambda\operatorname{tr}\mathrm{Ric}(X_{\mathrm{inv}})$, and $\operatorname{tr}\mathrm{Ric}(A)$ is $\operatorname{tr}A$ times a positive convention-dependent factor ($2$ under Frobenius on $n\times n$ and the orthonormal $\{e_i\wedge e_j\}$). There is no hidden sign. *Factor slip on the record, inert for the lemma: batch 1 (2) and [post F54](../findings/second-order.md) write $H=\lambda\,\mathrm{Id}$ at scalar $h$; with eigenvalues $\eta_i+\eta_j$ it is $H=2\lambda\,\mathrm{Id}$, as batch 2 writes.*
- **$\operatorname{tr}X_{\mathrm{inv}}\ge0$.** The trace of a symmetric operator is the sum of the traces of its three diagonal blocks, each PSD. Correct.
- **Trace zero forces every block zero.** A PSD operator with zero trace is zero. Correct.
- **A zero diagonal block of a PSD operator kills its row.** $P_+CP_+=0$ gives $\lVert C^{1/2}P_+\rVert=0$, so $CP_+=0=P_+C$; likewise $P_0\lvert W\rvert^\#=0$. Correct.
- **$P_0C=0$.** $4P_0C=P_0\lvert W\rvert^\#-P_0W^\#=0$ by the row fact and $P_0W^\#=0$. Correct.
- **$C=P_-CP_-$ and $X_{\mathrm{inv}}=P_-X_{\mathrm{inv}}P_-=0$.** $W_-$ and $W_-^2$ are supported in the $--$ block by definition, and the block is one of the three that vanished. Correct, for every sign of $\theta$.
- **Irreducible isotropy gives scalar $h$.** $h$ is $O(n)$-equivariant in $W$ (spectral calculus and $\mathrm{Ric}$ both commute with conjugation), so the stabiliser $K$ of $W$ fixes the symmetric matrix $h$, whose eigenspaces are then $K$-invariant; an $\mathbb R$-irreducible action leaves one eigenspace. Correct. Two remarks: irreducibility over $\mathbb R$ is what is used, which is the weaker of the two readings; and a subgroup acting irreducibly makes the full stabiliser act irreducibly, so the statement as written (the full isotropy group) is the weakest hypothesis of its kind. The wreath-product isotropy of $(S^m)^k$ acts irreducibly, so the balanced products are inside the class; the unbalanced $S^p\times S^q$ are outside it, as the batch says.

## 3. The substantive correction: the lemma understates itself, and its equality class is on the record

**The row argument uses nothing about $h$.** From "suppose $\operatorname{tr}X_{\mathrm{inv}}=0$" onward the proof reads $X_{\mathrm{inv}}$ alone, so what it proves is

> **at every critical point, $\operatorname{tr}X_{\mathrm{inv}}=0$ if and only if $X_{\mathrm{inv}}=0$; equivalently, $X_{\mathrm{inv}}\ne0$ forces $\operatorname{scal}(X_{\mathrm{inv}})>0$ strictly.**

The scalar-$h$ hypothesis enters only to identify $J_5$ with $\lambda\operatorname{tr}X_{\mathrm{inv}}$. The batch wraps the hypothesis-free statement inside the conditional one.

**And $\operatorname{tr}X_{\mathrm{inv}}$ is [Lemma L7](../findings/bounds.md)'s slack.** L7's proof traces $Q(W)=\theta W$ against $P_-$ to get $\theta\operatorname{tr}W_-+\operatorname{tr}W_-^2=-\operatorname{tr}(P_-W^\#)$, drops $-\operatorname{tr}(P_-W_+^\#)$, $-\operatorname{tr}(P_-W_-^\#)$ and $-2\operatorname{tr}((I-P_-)C)$, and identifies the remaining $2\operatorname{tr}C$ with $\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2$ by polarising [L15](../findings/problem.md). So its slack is $S=2\operatorname{tr}C-\theta\operatorname{tr}W_--\operatorname{tr}W_-^2=\tfrac12\operatorname{tr}X_{\mathrm{inv}}$ by Theorem A, which [ATTEMPTS.md](../ATTEMPTS.md) records at the withdrawn "slack in bracket data" section ("$S=\tfrac12\operatorname{tr}(X_{\mathrm{inv}})$ … is Lemma L7"). L7's equality class is the graded one, $[E_+,E_+]\perp E_-$, $[E_-,E_-]\perp E_-$, $[E_+,E_-]\subseteq E_-$, modulo $\ker W$ ([bounds.md](../findings/bounds.md), canonical statement). Combining the two:

> **At every critical point, $X_{\mathrm{inv}}=0\iff\operatorname{tr}X_{\mathrm{inv}}=0\iff$ the eigenspace ranges are graded (mod $\ker W$). In particular $X_{\mathrm{inv}}=0$, hence $J_5=0$, at every graded critical point, whatever $h$ is.**

This is consistent with the row argument's own output: $P_+CP_+=0$ is $[E_+,E_+]\perp E_-$, $P_0CP_0=0$ is $[E_0,E_+]\perp E_-$, i.e. $[E_+,E_-]\perp E_0$, and the $--$ block's vanishing is the two remaining relations, so the three graded relations are exactly the diagonal-block conditions the proof extracts.

**What this does to the batch's "consequence" paragraph.**

- "$X_{\mathrm{inv}}=0$ at $\mathbb{HP}^2$, a statement the record made only for $\mathcal S^4(\alpha)$" is true at operator level and was one step from the record at trace level: L7 lists $\mathbb{HP}^2$ among its equality points and [ATTEMPTS.md](../ATTEMPTS.md) proves it graded (the $\mathfrak{sp}(2)\oplus\mathfrak{sp}(1)=\mathfrak{so}(5)\oplus\mathfrak{so}(3)$ coincidence). The row argument is the step that was missing, and it is the batch's genuine contribution. The screen at $1.4\times10^{-15}$ is now a check of a theorem rather than the evidence for it.
- "The lemma explains it on the irreducible class rather than observing it", the better explanation is gradedness, which also covers the unbalanced sphere products, where $h$ is block-scalar and the lemma's hypothesis fails. [r697](REVIEW_r697.md)'s hand proof that $X_{\mathrm{inv}}\equiv0$ at every $S^p\times S^q$ becomes the special case of a graded point.
- "At every recorded point where the grant is sharp, $X_{\mathrm{inv}}=0$" is consistent with the record, and the reason is now uniform: every recorded sharp point (the sphere products, $\mathcal S^4(\alpha)$, $\mathbb{HP}^2$), is graded. The overreach is only in the framing: sharpness of the grant on the graded class is a theorem, and the recorded points are instances of it.
- The open question the batch poses, "is the grant's equality locus exactly $\{X_{\mathrm{inv}}=0\}$ at every critical point", reads better in the record's own terms: **is $J_5=0$ only at graded critical points?** A counterexample needs non-scalar $h$ (the lemma), an ungraded eigenspace structure (L7), and $\langle X_{\mathrm{inv}},H\rangle=0$ with $\operatorname{tr}X_{\mathrm{inv}}>0$ and $H\succeq0$, so $X_{\mathrm{inv}}$ must be indefinite there with its positive and negative parts balanced against $H$'s eigenvalues $\eta_i+\eta_j$. Every recorded $J_5>0$ point ($SU(3)$ with $\operatorname{tr}X_{\mathrm{inv}}=1.14$, the $n=5$ point) has $\operatorname{tr}X_{\mathrm{inv}}>0$, as L7's strict side requires.

## 4. Where the lemma was already on the record

| component | where |
| --- | --- |
| $J_5=\lambda\operatorname{scal}(X_{\mathrm{inv}})\ge0$ at scalar $h$ | batch 1 (2) of [DERIVE-j5.md](DERIVE-j5.md); [post F54](../findings/second-order.md) |
| $\operatorname{scal}(X_{\mathrm{inv}})\ge0$ at every critical point | Result 5(a) of [ATTEMPTS.md](../ATTEMPTS.md); [Lemma L7](../findings/bounds.md) as $S\ge0$ |
| $\operatorname{tr}X_{\mathrm{inv}}=0\iff$ graded | [Lemma L7](../findings/bounds.md), equality clause |
| $\operatorname{tr}X_{\mathrm{inv}}=0\Rightarrow X_{\mathrm{inv}}=0$ | **new, batch 2's row argument** |
| irreducible isotropy $\Rightarrow$ $h$ scalar | Schur; implicit in [post F54](../findings/second-order.md)'s "isotropy makes $h$ block-scalar" |

## 5. Corrections to record, in order of weight

1. **Restate the lemma in two parts.** (i) At every critical point with $W\ne0$: $\operatorname{tr}X_{\mathrm{inv}}=0\iff X_{\mathrm{inv}}=0\iff$ graded (mod $\ker W$), by the row argument and [Lemma L7](../findings/bounds.md); hence $J_5=0$ on the whole graded class. (ii) When $h=\lambda\,\mathrm{id}$: $\lambda>0$ and $J_5$ is a positive multiple of $\operatorname{tr}X_{\mathrm{inv}}$, so $J_5=0\iff X_{\mathrm{inv}}=0\iff$ graded.
2. **Add $W\ne0$** to the hypotheses (or "unit-norm critical point").
3. **Say "irreducibly over $\mathbb R$"**, which is what Schur needs and the weaker requirement.
4. **Reconcile the factor**: $H=2\lambda\,\mathrm{Id}$ at scalar $h$ under the $\eta_i+\eta_j$ eigenvalues; batch 1 (2) and post F54 carry $\lambda\,\mathrm{Id}$. Inert for every sign statement.
5. **Re-word the $\mathbb{HP}^2$ sentence**: the record had $\operatorname{tr}X_{\mathrm{inv}}=0$ there (graded, L7); the new fact is the upgrade to $X_{\mathrm{inv}}=0$, and it holds at every graded point.

## 6. What was not done

No computation. The one place a number might have been tempting (checking $S=\tfrac12\operatorname{tr}X_{\mathrm{inv}}$), is an identity between two record theorems (L7's proof and Theorem A) and needs none; the record's own note at [ATTEMPTS.md](../ATTEMPTS.md) already states it.

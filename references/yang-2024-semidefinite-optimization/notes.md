# Range additivity for positive semidefinite matrices, read at source

Transcribed 2026-09-08 by reviewer r773, for item 5 of [BRIEF-g2-l179-l180.md](../../reviews/BRIEF-g2-l179-l180.md). The brief flagged the fact as load-bearing for L180(3) and stated with no argument.

## The two statements, verbatim

**Lemma 2.3 (Range of PSD Matrices).** *Let $A,B \in \mathbb{S}^{n}_{+}$, then we have*
$$\mathrm{Range}(A) \subseteq \mathrm{Range}(A + B),$$
*where $\mathrm{Range}(A)$ denotes the span of the column vectors of $A$.*

**Corollary 2.1 (Range of PSD Matrices).** *Let $A, B \in \mathbb{S}^{n}_{+}$, then we have*
$$\mathrm{Range}(A + B) = \mathrm{Range}(A) + \mathrm{Range}(B),$$
*with "$+$" the Minkowski sum.*

## The proof of Lemma 2.3, verbatim

> For any symmetric matrix $S$, we know $\mathrm{Range}(S) = \mathrm{ker}(S)^{\perp}$. Therefore, to prove (2.2), it is equivalent to prove $\mathrm{ker}(A) \supseteq \mathrm{ker}(A + B)$. Pick any $u \in \mathrm{ker}(A + B)$, we have
> $$(A + B) u = 0 \Rightarrow u^\top(A + B) u = 0 \Rightarrow u^\top A u + u^\top B u = 0 \Rightarrow u^\top A u = u^\top B u = 0,$$
> where the last derivation is due to $A, B \succeq 0$. Now that we have $u^\top A u = 0$, we claim that $Au = 0$ must hold, i.e. $u \in \mathrm{ker}(A)$. To see this, write $u = \sum_{i=1}^n a_i v_i$, where $a_i = \langle u, v_i\rangle$ and $v_i$ are the eigenvectors of $A$ corresponding to eigenvalues $\lambda_i$. Then $Au = \sum a_i \lambda_i v_i$ and $u^\top A u = \sum \lambda_i a_i^2 = 0$. Since $\lambda_i \ge 0$, $a_i^2 \ge 0$, we have $\lambda_i a_i^2 = 0$ for all $i$. This indicates that if $\lambda_i > 0$ then $a_i = 0$. Therefore $a_i$ can only be nonzero for $\lambda_i = 0$, which leads to $Au = 0$.

## What transfers to L180(3), and the one thing the source leaves to the reader

Three points the record should carry with the citation:

1. **The mechanism is the kernel, not the range.** The source proves $\ker(A+B) = \ker A \cap \ker B$ for PSD summands and dualises. This is what makes positive semidefiniteness essential: for general symmetric matrices the sum of two nonzero ranges can collapse, as $A + (-A) = 0$ shows.
2. **Two summands extend to $k$ by induction**, since a finite sum of PSD matrices is PSD; L180(3) needs $k=2$ only.
3. **Positive scalar multiples are free**: $\mathrm{Range}(cA) = \mathrm{Range}(A)$ for $c>0$, which is how $\lambda_1 A_1 + \lambda_2 A_2 = |\lambda_3| A_3$ is read as a range identity.

A second, older source for the same fact in the operator setting is Fillmore–Williams, *On operator ranges*, Advances in Mathematics **7** (1971) 254–281, whose Theorem 2.2 gives $\mathrm{ran}(A^{1/2}) + \mathrm{ran}(B^{1/2}) = \mathrm{ran}\big((A+B)^{1/2}\big)$; in finite dimension $\mathrm{ran}(A^{1/2}) = \mathrm{ran}(A)$, so it specialises to Corollary 2.1. That paper was located but is paywalled and was **not** read, so it is cited as a pointer and nothing here rests on it.

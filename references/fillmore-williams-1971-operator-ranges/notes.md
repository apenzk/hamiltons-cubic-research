# Notes, Fillmore–Williams, *On operator ranges* (1971)

## What was read

§2, pp. 261–262, Theorem 2.2 and its corollaries. Transcribed from the filed PDF.

## Theorem 2.2, verbatim in content

> **Theorem 2.2.** If $A,B\in\mathcal B(\mathcal H)$, then $\mathcal R(A)+\mathcal R(B)=\mathcal R\big(\sqrt{AA^*+BB^*}\big)$.
>
> *Proof.* Let $T=\begin{pmatrix}A&B\\0&0\end{pmatrix}$ act on $\mathcal H\oplus\mathcal H$ in the usual way. Then $(\mathcal R(A)+\mathcal R(B))\oplus\{0\}=\mathcal R(T)=\mathcal R((TT^*)^{1/2})=\mathcal R\big(\begin{pmatrix}(AA^*+BB^*)^{1/2}&0\\0&0\end{pmatrix}\big)=\mathcal R(\sqrt{AA^*+BB^*})\oplus\{0\}$.

The step $\mathcal R(T)=\mathcal R((TT^*)^{1/2})$ is the paper's Theorem 2.1 (Douglas' range-inclusion theorem), also in §2.

## The specialisation the record needs

Let $A,B$ be positive semidefinite $n\times n$ real matrices. Apply Theorem 2.2 to the pair $A^{1/2},B^{1/2}$, which are self-adjoint, so $A^{1/2}(A^{1/2})^*+B^{1/2}(B^{1/2})^*=A+B$:

$$\mathcal R(A^{1/2})+\mathcal R(B^{1/2})=\mathcal R\big((A+B)^{1/2}\big).$$

In finite dimensions $\mathcal R(M^{1/2})=\mathcal R(M)$ for positive semidefinite $M$, the two have the same kernel, and both are self-adjoint, so the ranges are the same orthogonal complement. Hence

$$\mathop{\mathrm{range}}(A+B)=\mathop{\mathrm{range}}(A)+\mathop{\mathrm{range}}(B),$$

and by induction the same holds for any finite sum of positive semidefinite matrices. This is the statement L180(3) uses.

## Corroborating statement in finite dimensions

Hu, Im, Lin, Lütkenhaus, Wolkowicz, *Robust Interior Point Method for Quantum Key Distribution Rate Computation*, Quantum **6** (2022), [arXiv:2104.03847](https://arxiv.org/abs/2104.03847), equation (A.7) in Appendix A.2:

> $A,B\succeq 0 \implies \mathop{\mathrm{range}}(A+B)=\mathop{\mathrm{range}}(A)+\mathop{\mathrm{range}}(B).$

They state it as a recalled fact and use it without proof; it is the exact matrix form, so it is worth citing alongside the Fillmore–Williams proof rather than instead of it.

## Elementary proof, for the record's own use

For positive semidefinite $A$, $x^{\mathsf T}Ax=0\iff Ax=0$ (write $x^{\mathsf T}Ax=\lVert A^{1/2}x\rVert^2$). So for positive semidefinite $A_1,\dots,A_k$ and $x$ with $\sum_iA_ix=0$: $0=x^{\mathsf T}\big(\sum_iA_i\big)x=\sum_ix^{\mathsf T}A_ix$ is a sum of non-negative terms, hence each vanishes, hence each $A_ix=0$. Therefore $\ker\big(\sum_iA_i\big)=\bigcap_i\ker A_i$. Taking orthogonal complements of symmetric matrices, $\mathop{\mathrm{range}}\big(\sum_iA_i\big)=\big(\bigcap_i\ker A_i\big)^\perp=\sum_i(\ker A_i)^\perp=\sum_i\mathop{\mathrm{range}}A_i$.

The positivity is essential and not decoration: $A=\begin{pmatrix}1&0\\0&0\end{pmatrix}$, $B=-A$ gives $\mathop{\mathrm{range}}(A+B)=0$ while $\mathop{\mathrm{range}}A+\mathop{\mathrm{range}}B$ is a line.

# Huisken 1985, Lemma 3.5, and why it cannot leave dimension four

## Lemma 3.5 (p. 57), the sharp bound

> On a four-dimensional manifold we have the estimate $\lvert2W_{ijkl}W_{imkn}W_{jmln}+\tfrac12W_{ijkl}W_{klmn}W_{ijmn}\rvert\le\tfrac{\sqrt6}4\lvert W\rvert^3$.

**Mind the norm.** Huisken's $\lvert W\rvert$ is the full tensor norm; this project's $\lVert W\rVert$ is the operator norm on $\Lambda^2$, and $\lvert W\rvert=2\lVert W\rVert$ (Xu's (2.54) makes this explicit: $4(n-1)\lvert W\rvert^2=16(n-1)\lVert W\rVert^2$). The sharp constant is $\frac{\sqrt6}4$ against $\lvert W\rvert^3$, *(Reviewer 93; a first transcription here wrote $\frac{\sqrt6}2\lvert W\rvert^3$, which is true but not sharp)*. In the project's normalisation it becomes $\frac{\sqrt6}2=\sqrt{3/2}$, the $\mathbb{CP}^2$ value and the live target: with $\Lambda^2$-spectrum $(2,-1,-1,0,0,0)$, $\lVert W\rVert^2=6$ and $\mathop{\mathrm{tr}}(W^3)=6$, so $\theta=3\cdot6/6^{3/2}=\frac{\sqrt6}2$ exactly. Reviewer 93 confirms the constant independently by Gröbner elimination, critical values $(t^2-432)(t^2-216)=0$, maximum attained at the self-dual $W_{\mathbb{CP}^2}$, with $S^2\times S^2$ a factor $\sqrt2$ below. It is the only sharp instance of that constant anywhere in the literature consulted here.

## The mechanism, and it is not the one previously recorded

The proof invokes **the normal-form theorem for the Weyl tensor in dimension four**: there is a local orthonormal frame in which $W$, viewed as a symmetric operator on $\Lambda^2$, becomes the block matrix built from $A=\mathop{\mathrm{diag}}(\lambda_1,\lambda_2,\lambda_3)$ and $B=\mathop{\mathrm{diag}}(\mu_1,\mu_2,\mu_3)$, with $\sum\lambda_i=0$ (trace-free) and $\sum\mu_i=0$ (first Bianchi). The cubic then becomes an explicit polynomial,

$$2W_{ijkl}W_{imkn}W_{jmln}+\tfrac12W_{ijkl}W_{klmn}W_{ijmn}=8P(\lambda_i,\mu_i),$$

$$P=6\{\lambda_1\lambda_2\lambda_3+\lambda_1\mu_2\mu_3+\lambda_2\mu_1\mu_3+\lambda_3\mu_1\mu_2\}+\{\lambda_1^3+\lambda_2^3+\lambda_3^3\}+3\{\lambda_1\mu_1^2+\lambda_2\mu_2^2+\lambda_3\mu_3^2\},$$

*(**Corrected by Reviewer 93.** A first transcription put $\mu_i^3$ in the middle term, misreading the garbled `pdftotext` output. Swapping chiralities is $\mu\mapsto-\mu$ and preserves the cubic, so $P$ must be **even in $\mu$**, which holds for $\lambda_i^3$ and fails for $\mu_i^3$. One-line parity test.)*

and Huisken finishes by enumerating **all stationary points** of $P$ on the sphere (3.9) via Lagrange multipliers (3.10).

**So the argument works because at $n=4$ the alignment degrees of freedom are gone.** After using the $O(n)$ gauge, a Weyl tensor retains

$$\dim\mathrm{Weyl}_n-\dim O(n)=\frac{n(n-3)(n+1)(n+2)}{12}-\frac{n(n-1)}2=\frac{n^2(n^2-13)}{12}$$

moduli, **exactly $4$ at $n=4$**, matching Huisken's $(\lambda_i,\mu_i)$ with two linear constraints, and then $25$, $69$, $272$, $1572$ at $n=5,6,8,12$, growing like $n^4/12$.

> **This is the precise reason the technique is confined to $n=4$, and it is sharper than the reason previously on file** ("$\mathfrak{so}(4)$ is the unique semisimple non-simple case"). That is true but not operative. The operative fact is that a finite stationary-point enumeration is possible only when the moduli count is finite and small, and $n=4$ is the only dimension where it is.

**It also names the crux exactly.** "Alignment", the residue every route this project has tried fails on, *is* these $\frac{n^2(n^2-13)}{12}$ moduli. A spectral bound sees only the $N$ eigenvalues; the moduli are what remains, and at $n=12$ that is $1572$ parameters against $66$ eigenvalues.

## Theorem 3.3 (pp. 52–55)

The general cubic estimate Xu quotes as his Lemma 2.14, Xu notes it "was not written down as an independent lemma in [16]", and indeed it appears inside this proof. Huisken's own argument splits by dimension: a strict inequality "holds for $n>6$" (p. 55), with the small cases handled separately, which is the ancestor of Xu's piecewise split at $n=10/11$.

## Lemma 3.4 (p. 54), the Weyl tensor on traceless symmetric 2-tensors

> **Lemma 3.4.** We have the estimate $\Big\lvert\frac6{n-2}\mathring R_{ik}\mathring R_{jl}W^{ijkl}\Big\rvert\le\frac{3\sqrt2}{\sqrt{(n-1)(n-2)}}\,\lvert W\rvert\Big(S-\frac1nR^2\Big)$.

Here $S-\tfrac1nR^2=\lvert\mathring R\rvert^2$ and $\lvert W\rvert$ is the full tensor norm. **Rearranged**: $\lvert W_{ijkl}h_{ik}h_{jl}\rvert\le\sqrt{\tfrac{n-2}{2(n-1)}}\,\lvert W\rvert\,\lvert h\rvert^2$. *The proof (via $V\circ V$ and its Weyl part $T_3$, $\lvert T_3\rvert^2\le\frac{32}{(n-1)(n-2)^3}(S-\tfrac1nR^2)^2$) uses only that $\mathring R$ is traceless and symmetric, so the estimate holds for every traceless symmetric $h$, not only a traceless Ricci tensor.* This is the form [Fu–Xiao](https://www.sciencedirect.com/science/article/pii/S092622451730089X) cite as Huisken's inequality. Read from the PDF page image, since the text extraction garbles the constant. Consumed by [the half-summed pair inequality](../../reviews/2026-09-25-I73c-per-vector-rows.md).

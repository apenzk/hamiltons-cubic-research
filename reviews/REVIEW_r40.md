### Reviewers 40 and 41: nondegeneracy of the $\mathbb{CP}^m$ family

**They agree on all six verdicts, reached the same ten-summand decomposition by different routes, and each found prior art the other did not.** Own implementations in [review_r40_core.py](scripts/review_r40_core.py) and [review_r41_core.py](scripts/review_r41_core.py) with five to eight companions apiece; nothing under review imported. Reports in [review_r40_report.md](agent_logs/review_r40_report.md) and [review_r41_report.md](agent_logs/review_r41_report.md).

**C1 CONFIRMED and sharpened.** $\mathfrak u(m)\subset\mathfrak{so}(2m)$ is the solution space of $EJ=JE$ among antisymmetric $E$, of dimension $m^2$. The pitfall is worse than the brief stated: only $m$ elementary generators $E_{ab}-E_{ba}$ commute with $J$, not a number near $m^2$, they span the maximal torus, and the erroneous $m(m-1)$ invariant dimension is that torus's zero-weight space, confirmed as a general fact at $m=3\ldots10$.

**C2 CONFIRMED and upgraded to a theorem for all $m\ge2$**: the $\mathfrak u(m)$-invariant subspace of $\mathrm{Weyl}_{2m}$ is one-dimensional and its generator is critical, residual $\sim10^{-15}$. The negative-branch warning is real, the generator came out negative at $m=3,4,5,7$.

**C3 CONFIRMED as to numbers, and the brief's own prose REFUTED.** $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$, exact at $m=3\ldots12$. But the setup text, which wrote $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^\top Y)$ and applied it at the **operator** level, inflates every $\theta$ by $\sqrt2$, giving $1.4907$, $1.3944$, $1.3416$ against the correct $1.0541$, $0.9860$, $0.9487$. The $\tfrac12$ belongs at the $\Lambda^2$ level, where it makes $\{\phi_{ij}\}$ orthonormal; the pair matrix carries the plain Frobenius product. Anchored by reproducing $\theta_0(n)$ at the balanced sphere product and Nienhaus Proposition 2.25 at four splits. **The repository's numbers are correct and only the briefing prose was wrong**, and nothing downstream moves since $e=W/\theta$ is invariant under the rescaling.

**C4 and C5 CONFIRMED**, pushed to $m=7$ by both: $\dim E(\tfrac12)=\dim(\text{orbit})=m(m-1)$, and $\lambda_{\max}=\tfrac{m+2}{2(m+1)}=\tfrac12+\tfrac1{2(m+1)}$ carried by the $\mathfrak{su}(m)$ adjoint of dimension $m^2-1$.

**C6 CONFIRMED, in closed form, and it is published.** $\mathrm{Weyl}_{2m}\otimes\mathbb C$ is $U(m)$-multiplicity-free with ten summands, nine at $m=3$:

| summand | dimension | $L_e$ |
|---|---|---|
| trivial, $=W$ | $1$ | $1$ |
| $\mathfrak{su}(m)$ adjoint | $m^2-1$ | $\frac{m+2}{2(m+1)}$ |
| $\Lambda^2E\oplus\Lambda^2\bar E$, **the orbit** | $m(m-1)$ | $\tfrac12$ |
| $V_{(1,1);(1,1)}$ | $\frac{m^2(m+1)(m-3)}{4}$ | $\frac{2}{m+1}$ |
| $V_{(2,1);(1)}\oplus\text{conj}$ | $\frac{2m^2(m^2-4)}{3}$ | $0$ |
| $V_{(2);(2)}$, Bochner | $\frac{m^2(m+3)(m-1)}{4}$ | $0$ |
| $V_{(2,2);\varnothing}\oplus\text{conj}$ | $\frac{m^2(m^2-1)}{6}$ | $-\frac{3}{m+1}$ |

Dimensions sum to $\dim\mathrm{Weyl}_{2m}$ and $\mathop{\mathrm{tr}}(L_e)=0$, both **identically in $m$**; $\mathop{\mathrm{tr}}L_e^2$ and $\mathop{\mathrm{tr}}L_e^3$ match measurement at $m=3\ldots7$. Established four ways between them: a from-scratch Littlewood–Richardson derivation, Racah on integer torus weights at $m=3\ldots7$, a basis-free character count at $m=3\ldots10$, and explicit highest-weight vectors with residual $\|L_ev-\lambda v\|\sim10^{-16}$ at $m=3\ldots12$.

**Nondegeneracy for every $m\ge3$, with no exception.** Setting each eigenvalue equal to $\tfrac12$ symbolically, only $\frac2{m+1}$ ever reaches it, at $m=3$, precisely where that summand's dimension $\frac{m^2(m+1)(m-3)}4$ vanishes. So $E(\tfrac12)$ is the orbit at every $m\ge3$, which is **cleaner than the sphere products**, where $(3,3)$ is a genuine exception.

**The Casimir trap fires inside this problem.** $V_{(2,1);(1)}$ and $V_{(2,2);\varnothing}$ share $\mathfrak u(m)$-Casimir $4m$ while carrying $0$ and $-\frac3{m+1}$; they separate only by the central $U(1)$ charge. A Casimir-only split merges a $30$- and a $12$-dimensional summand at $m=3$ and reads a scalar off a two-eigenvalue block, the exact failure mode refuted three cycles ago, now with a live example here.

**What both say is still owed, in the same words.** Multiplicity-freeness is proved for all $m$; the seven eigenvalues are **verified rather than derived**, at $m=3\ldots7$ by one reviewer and $m=3\ldots12$ by the other. Since Schur makes each summand's value an eigenvalue rather than a lower bound, nondegeneracy follows the moment the closed forms are established, and the missing step is one explicit $m$-independent test vector per summand, exactly as Reviewers 38 and 39 supplied for the sphere products. Two facts make it cheap: $e$ has entries rational in $m$, the surd in $\theta$ cancelling, and $W=a P_m+b P_{\mathfrak{su}(m)}+c P_\omega$ in the three $U(m)$-isotypic projectors of $\Lambda^2\mathbb R^{2m}$.

**Prior art, found independently by each.** [Howe–Tan–Willenbring §2.3.1](https://arxiv.org/abs/math/0311159), $GL_n\subset O_{2n}$ branching with $\lambda=(2,2)$, gives exactly these ten $GL(m)$ summands, all multiplicity one, for every $m\ge4$, stored at [references/howe-tan-willenbring-2005-stable-branching/](references/howe-tan-willenbring-2005-stable-branching/). [Tricerri–Vanhecke, Trans. AMS 267 (1981)](https://www.ams.org/journals/tran/1981-267-02/S0002-9947-1981-0626479-0/) decompose the full curvature space, their count of $10/9/7$ real unitary modules matching after the three Ricci-and-scalar modules are removed, stored at [references/tricerri-vanhecke-1981-almost-hermitian-curvature/](references/tricerri-vanhecke-1981-almost-hermitian-curvature/), the AMS copy being paywalled so the count is quoted from an open restatement, [arXiv:1105.0185](https://arxiv.org/abs/1105.0185). **The $L_e$ eigenvalues and the identification of the orbit summand are not prior art.**

**Reconciliation.** No verdict conflicts, and the two reports differ only in reach and in which prior source each located. Both name the same remaining step in the same terms.

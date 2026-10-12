# Notes: Lauret and Will 2021 (arXiv:2111.07842)

**Setting** (§1). Einstein metrics are the critical points of the Hilbert action $\widetilde{Sc}$ on unit-volume metrics $\mathcal M_1$; for a homogeneous $M=G/K$ the restriction to $G$-invariant metrics $\mathcal M_1^G$ is finite-dimensional. Definition 1.1: stable ($\widetilde{Sc}''<0$ on TT-tensors), semistable ($\le0$), neutrally stable ($\le0$ with nonzero kernel), and the $G$-versions on $G$-invariant TT-tensors.

**The neutrally stable irreducible symmetric spaces** (p. 2, citing [K, GG, SW, S]): $SU(n)$, $SU(n)/SO(n)$, $SU(2n)/Sp(n)$ ($n\ge3$), $SU(p+q)/S(U(p)\times U(q))$ ($p\ge q\ge2$), $E_6/F_4$. "Curiously enough, stable irreducible symmetric spaces are the only known local maxima of $\widetilde{Sc}|_{\mathcal C_1}$ with $Sc>0$."

> **Theorem 1.2.** The following Einstein metrics are not local maxima of $\widetilde{Sc}|_{\mathcal C_1}$: (i) The bi-invariant metric on $SU(n)$ for any $n\ge3$, which is not a local maximum of $Sc$ among left-invariant metrics of volume one. (ii) [BWZ, Example 6.8] The symmetric metric on $SU(2n)/Sp(n)$ for any $n\ge3$, which is not a local maximum of $Sc$ among $SU(2n-1)$-invariant metrics of volume one.

The proof finds an explicit curve $g(t)\in\mathcal M_1^G$ through the neutrally stable point along which $Sc(g(t))$ has an inflection point (§4).

> **Theorem 1.5.** The standard metric on the full flag manifold $SO(2n)/T^n$ is not a local maximum of $Sc|_{\mathcal M_1^G}$ (nor of $\widetilde{Sc}|_{\mathcal C_1}$) for any $n\ge4$.

**Two isotropy summands** (§3, citing [DK, H, Ke, WZ2]). With inequivalent summands $\dim\mathcal M_1^G=1$. (i) If $K$ is maximal in $G$: a global maximum of $Sc|_{\mathcal M_1^G}$ exists, with at most two further Einstein metrics. (ii) If $K$ is not maximal: at most two Einstein metrics, and no global minima or maxima. (iii) A unique invariant Einstein metric is then an inflection point, never a local maximum, and $G$-neutrally stable.

**Bearing on the record.** The shape matches [L263](../../findings/second-order.md) and [L264](../../findings/second-order.md) (4): on a two-component family the record's second root and $I/c$ exchange stability, and at the exchange (a double root) the point is marginal, as the unique Einstein metric in (iii) is. The difference is the functional: $Sc=\sum\frac{d_ib_i}{2x_i}-\frac14\sum L_{ijk}\frac{x_k}{x_ix_j}$ under $\prod x_i^{d_i}=1$, against $F=\tfrac12\sum T_{ijk}\lambda_i\lambda_j\lambda_k$ under $\sum d_i\lambda_i^2=1$.

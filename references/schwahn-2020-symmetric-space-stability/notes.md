# Notes, Schwahn, arXiv:2012.10524 (read pp. 1–8; Sections 5–6 and Appendix skimmed for shape only)

## The stability problem and its threshold (Section 1–2)

Einstein metrics are the critical points of the Einstein–Hilbert action $S(g)=\int\mathrm{scal}\,\mathrm{vol}$ on unit-volume metrics. On the tt-slice ($\mathscr S^2_{tt}$: transverse traceless) the second variation is $S''_g(h,h)=-\tfrac12\langle\Delta_L h-2Eh,h\rangle$ with $\Delta_L=\nabla^*\nabla+q(R)$ the Lichnerowicz Laplacian and $E$ the Einstein constant. So:

- **stable** $\iff\Delta_L\ge2E$ on tt-tensors; **strictly stable** $\iff>$; the null directions at the critical eigenvalue $2E$ are exactly the **infinitesimal Einstein deformations**.
- The paper closes the last open irreducible cases: $\mathrm{SU}(n)$ ($n\ge3$) and $E_6/F_4$ are linearly stable (Thm 1.3). With Koiso, Gasqui–Goldschmidt, Semmelmann–Weingart (quaternionic Grassmannians unstable for $p\ge q\ge2$, Cayley plane stable), the irreducible compact-type stability problem is **completely resolved** (Thm 1.1/1.2 collect the history).
- Products of positive Einstein factors are **always unstable**, witness $h=n_2\pi_1^*g_1-n_1\pi_2^*g_2$ (p. 3), the direct-sum saddle, identical in form to the record's direct-sum lemma eigenvector $H=\|W_2\|^2W_1-\|W_1\|^2W_2$ (nondegeneracy.md).

## The method, spectrum by isotype, never by direction (Section 3)

For $M=G/K$ reductive homogeneous, every tensor bundle is $\Gamma(G\times_\rho V)\cong C^\infty(G,V)^K$, and Peter–Weyl + Frobenius reciprocity give

$$C^\infty(G,V)^K\cong\overline{\bigoplus_\gamma}V_\gamma\otimes\mathrm{Hom}_K(V_\gamma,V).$$

$\Delta_L$ is $G$-invariant, so by Schur it acts on the isotype of $\gamma$ through an endomorphism $L_\gamma$ of the **finite-dimensional multiplicity space** $\mathrm{Hom}_K(V_\gamma,V)$. In general the $L_\gamma$ are cumbersome; **on a symmetric space** (Prop 3.1):

1. $\Delta_L=\mathrm{Cas}^G_\ell$ on the left-regular representation, the Lichnerowicz Laplacian *is* the Casimir;
2. Freudenthal: $\mathrm{Cas}^G_\gamma=\langle\gamma,\gamma+2\delta_{\mathfrak g}\rangle_{\mathfrak t^*}$ on the irreducible $V_\gamma$.

So the entire spectrum on tt-tensors is: enumerate the highest weights $\gamma$ with $\mathrm{Hom}_K(V_\gamma,\mathrm{Sym}^2_0\mathfrak m)\neq0$ (a branching computation), evaluate $\langle\gamma,\gamma+2\delta\rangle$, compare to $2E$. **No test direction is ever named; the answer is a count over non-trivial isotypes.** Section 4 adds a dimension formula for the tt-part of each eigenspace (splitting off the divergence-free condition via Killing fields); Sections 5–6 run the branching for $\mathrm{SU}(n)$ and $E_6/F_4$.

## Transfer to this programme

At an equivariant critical point $W$ with stabiliser $H\subseteq\mathrm O(n)$, $L_e$ commutes with the $H$-action on $\mathcal W_n$, so $e^\perp$ splits into $H$-isotypes and $L_e$ acts on each multiplicity space by Schur, the finite-dimensional analogue of Section 3, with no Peter–Weyl needed because $\mathcal W_n$ is already finite-dimensional. What plays Freudenthal's role: at diagonal points built from Lie-algebra data (the record's $W(M)$ on graded pairs), the record already has $L_e$-eigenvalue formulas in Casimir terms on specific isotypes (the block closed form $(p-2)/(2(p-1))$ is one such entry). The missing piece Schwahn supplies a model for is the **branching enumeration**: list the $H$-isotypes of $\mathcal W_n$, get one eigenvalue per isotype, and read $\lambda_{\max}(L_e)$ off the finite table.

**Limit of the transfer**: this decides stability at *symmetric* points only. The record's hard points (the $\theta=1.088948$ witness) are non-equivariant; there the isotype table has one block of size $>1$ per isotype and Schur gives matrices, not scalars, the method degrades from arithmetic to finite linear algebra, which is still a reduction.

# REVIEW r1218: batches 23 and 24 of the I73 class-ceiling note (coordinate quartic bound)

Reviewer r1218, adversarial Gate 2. Claim: sections "Batch 23" and "Batch 24" of [the D6 working note](2026-09-26-I73-class-ceiling.md), read off disk. Analysis-only footing: every numerical item below is a screen of seconds, reported as a screen and never as proof.

**Verdict: the theorem is correct. All six items CONFIRMED, with two repairs to the wording: the equality case also includes the edgeless graph, and the Pearson citation does not give the upper bound it is cited for (a self-contained proof is supplied below).**

| Claim | Verdict |
|---|---|
| C1 codegree diagonal, S(G) <= (n-2)^2 e^2/N | CONFIRMED |
| C2 tr A^4 = sum d_i^2 + 2S | CONFIRMED |
| C3 fourth-moment bound c_n | CONFIRMED, citation repaired, proof supplied |
| C4 the chain, equality at K_n | CONFIRMED, equality case repaired (K_n or edgeless) |
| C5 ||Pi#Pi||_F^2 = 8(tr Z^4 - tr(Z^2 (Z^2)^Gamma)) | CONFIRMED (derivation of normalisation plus screen) |
| C6 Lean coordinate_quartic | CONFIRMED |

## C1

- Record basis: $e_i\wedge e_j=E_{ij}-E_{ji}$ has $\tfrac12\mathop{\mathrm{tr}}(A^{\mathsf T}A)=1$, so the coordinate basis is record-orthonormal. For distinct $i,j,k$, $[E_{ij}-E_{ji},E_{jk}-E_{kj}]=E_{ik}-E_{ki}$ (direct product), and the bracket of two coordinate elements sharing no index, or equal, is $0$. So every structure constant $c_{\alpha\beta\gamma}$ in this basis is $0$ or $\pm1$, and $[b_\beta,b_\gamma]$ is always a single coordinate element or zero.
- The index formula (findings/bounds.md, the one L244 uses) $(A\#B)_{jk}=\tfrac12\sum c_{jcd}c_{kef}A_{ce}B_{df}$ at $A=B=\Pi=\mathop{\mathrm{diag}}(1_E)$ reads $(\Pi\#\Pi)_{\alpha\alpha'}=\tfrac12\sum_{c,d\in E}c_{\alpha cd}c_{\alpha' cd}$.
- Off-diagonal: $c_{\alpha cd}c_{\alpha'cd}\ne0$ needs $[b_c,b_d]$ to have components on both $b_\alpha$ and $b_{\alpha'}$, impossible for $\alpha\ne\alpha'$. So the off-diagonal entries vanish exactly.
- Diagonal at $\alpha=ik$: the ordered pairs $(c,d)\in E^2$ with $[b_c,b_d]=\pm b_{ik}$ are $(ij,jk)$ and $(jk,ij)$ for each common neighbour $j$, so the entry is $\tfrac12\cdot2\mathop{\mathrm{codeg}}(i,k)=\mathop{\mathrm{codeg}}(i,k)$. This holds at every pair $ik$, edge or not, which is what the Frobenius norm on all of $\mathfrak{so}(n)$ needs.
- Cross-check against L257's form $\tfrac14\sum\langle[v_i,v_j],[v_k,v_l]\rangle^2$: for each $ik$ there are $2\mathop{\mathrm{codeg}}(i,k)$ ordered pairs with bracket $\pm b_{ik}$, giving $\tfrac14\sum_{ik}(2\mathop{\mathrm{codeg}})^2=S$. Consistent.
- Hence $\lVert\Pi\#\Pi\rVert_F^2=S(G)$ and L257's bound with $d=e$ is $S\le(n-2)^2e^2/N$. The "equivalently" display follows from $t=2e$ and $N=n(n-1)/2$.
- Screen: $\Pi\#\Pi$ rebuilt from structure constants at $n=6$ on five random edge sets, off-diagonal exactly $0$, diagonal equal to codegrees exactly.

## C2

- $(A^2)_{ii}=d_i$ and $(A^2)_{ik}=\mathop{\mathrm{codeg}}(i,k)$ for $i\ne k$. $A^2$ is symmetric, so $\mathop{\mathrm{tr}}A^4=\lVert A^2\rVert_F^2=\sum_id_i^2+\sum_{i\ne k}\mathop{\mathrm{codeg}}^2=\sum_id_i^2+2S$. CONFIRMED.

## C3

- Value at the extremal: $x=(a,-a/(n-1),\dots)$ with $\sum x^2=1$ gives $a^2=(n-1)/n$ and $\sum x^4=\frac{(n-1)^3+1}{n^2(n-1)}=\frac{n^2-3n+3}{n(n-1)}$, using $(n-1)^3+1=n(n^2-3n+3)$.
- **Citation defect.** Pearson's inequality $b_2\ge b_1+1$ is a LOWER bound on kurtosis. At the extremal skewness $(n-2)/\sqrt{n-1}$ it gives $b_2\ge n-2+\tfrac1{n-1}$, which is the same number, but it cannot prove the upper bound. The bound itself is the classical maximum of the sample kurtosis, $b_2\le n-2+\tfrac1{n-1}$ (equivalently $\sum x^4\le c_n(\sum x^2)^2$). Repair: replace the parenthetical by the proof below or by a correct reference.
- **Proof.** Maximise $\sum x_i^4$ on $\{\sum x_i=0,\ \sum x_i^2=1\}$, compact, with constraint gradients $\mathbf 1$ and $x$ independent (since $x\not\parallel\mathbf 1$). At a maximiser, Lagrange gives $4x_i^3-2\mu x_i-\nu=0$ for all $i$, so the entries are roots of a cubic with no $x^2$ term.
  - Second-order condition: $\mathop{\mathrm{diag}}(12x_i^2-2\mu)$ is negative semidefinite on the codimension-2 tangent space, so at most two indices have $12x_i^2>2\mu$.
  - If the cubic has three simple real roots $r_1<r_2<r_3$ (sum $0$), its derivative $12x^2-2\mu$ is positive at $r_1,r_3$. So $r_1$ and $r_3$ carry total multiplicity at most $2$. If a root is repeated or only one root is real, the entries take at most two values (one value is impossible under the constraints).
  - Two values: $k$ entries $\alpha$, $n-k$ entries $\beta$ give $\sum x^4=\frac{(n-k)^3+k^3}{n^2k(n-k)}=\frac n{k(n-k)}-\frac3n$, largest at $k(n-k)=n-1$, value $c_n$.
  - Three values with $r_1,r_3$ simple and $r_2$ of multiplicity $n-2$: $r_1+r_3+(n-2)r_2=0$ and $r_1+r_2+r_3=0$ give $(n-3)r_2=0$. For $n\ge4$, $x=(p,-p,0,\dots)$ with value $\tfrac12\le c_n$, since $c_n-\tfrac12=\frac{(n-2)(n-3)}{2n(n-1)}\ge0$. At $n=3$, $\sum x^4=\tfrac12(\sum x^2)^2$ identically ($p_4=2e_2^2$ when $e_1=0$), and $c_3=\tfrac12$.
  - So the maximum is $c_n$, attained exactly at one value against $n-1$ equal ones (for $n\ge4$). $\square$
- Screen: random vectors plus the full two-singleton family at $n=3,\dots,11$, largest ratio to $c_n$ equal to $1$ within $10^{-8}$.

## C4

- $c_n-\tfrac1n=\frac{n^2-3n+3-(n-1)}{n(n-1)}=\frac{(n-2)^2}{n(n-1)}$. With $\mathop{\mathrm{tr}}A^4\le c_nt^2$ (C3 applied to the eigenvalues of the traceless symmetric $A$) and $\sum d_i^2\ge t^2/n$ (Cauchy-Schwarz, $\sum d_i=t$), C2 gives $2S\le\frac{(n-2)^2}{n(n-1)}t^2$, and $t=2e$ turns this into $S\le\frac{2(n-2)^2e^2}{n(n-1)}=(n-2)^2e^2/N$. CONFIRMED.
- **Equality, repaired.** Equality forces a regular graph and the extremal spectrum. The edgeless graph attains $0=0$, so "equality exactly at $K_n$" must read "exactly at $K_n$ and the edgeless graph", or "among graphs with an edge, exactly $K_n$". The note's one-line equality argument is correct for $e\ge1$ once spelled out: the sign-reversed spectrum $(-\lambda,\lambda/(n-1),\dots)$ violates Perron-Frobenius ($\lambda_{\max}\ge\lvert\lambda_{\min}\rvert$) for $n\ge3$, so the spectrum is $(\lambda,-\tfrac{\lambda}{n-1}\times(n-1))$, $A+\tfrac\lambda{n-1}I$ has rank one with constant row sums, and a $0/1$ zero-diagonal matrix of that form is $J-I$.

## C5

- Normalisation: a record-unit element is $v=\sqrt2U$ with $U$ Frobenius-unit, and $\langle X,Y\rangle_{\mathrm{rec}}=-\tfrac12\mathop{\mathrm{tr}}(XY)$ on skew matrices, so $\langle[v_i,v_j],[v_k,v_l]\rangle=-2\mathop{\mathrm{tr}}([U_i,U_j][U_k,U_l])$ and L257's formula gives $\lVert\Pi\#\Pi\rVert_F^2=\sum_{ijkl}\mathop{\mathrm{tr}}([U_i,U_j][U_k,U_l])^2$.
- Expanding the commutators gives sixteen terms of type $\sum\mathop{\mathrm{tr}}(U_\sigma)\mathop{\mathrm{tr}}(U_\tau)$. Those with matching orders sum to $\mathop{\mathrm{tr}}\widetilde Z^4=\sum\mathop{\mathrm{tr}}(U_iU_jU_kU_l)^2$, those with one pair transposed to $\mathop{\mathrm{tr}}(\widetilde Z^2(\widetilde Z^2)^\Gamma)$, and the remaining ones reduce to these by cyclicity and $U^{\mathsf T}=-U$. The constant $8$ was checked rather than rederived term by term.
- $\widetilde Z^{\mathsf T}=\sum(-U_i)\otimes(-U_i)=\widetilde Z$, so partial transpose on either factor gives the same trace. $\mathop{\mathrm{tr}}\widetilde Z=\sum(\mathop{\mathrm{tr}}U_i)^2=0$ and $\mathop{\mathrm{tr}}\widetilde Z^2=\sum_{ij}\mathop{\mathrm{tr}}(U_iU_j)^2=d$, as stated.
- Screen: $\lVert\Pi\#\Pi\rVert_F^2$ built from structure constants against $8(\mathop{\mathrm{tr}}\widetilde Z^4-\mathop{\mathrm{tr}}(\widetilde Z^2(\widetilde Z^2)^\Gamma))$ on random subspaces at $(n,d)=(5,4),(6,7),(7,5)$: agreement to $10^{-15}$ relative. The constant and the record normalisation of $\lVert\Pi\#\Pi\rVert$ are right. CONFIRMED (identity checked by screen plus the normalisation derivation, full sixteen-term expansion owed if it enters a proof).

## C6

- [I73CoordinateQuartic.lean](../lean/HamiltonsCubic/Results/I73CoordinateQuartic.lean) compiles with no errors, warnings or `sorry` (`lake env lean`, 9 s), and is imported at HamiltonsCubic.lean line 577.
- `coordinate_quartic` takes reals $n>2$, $T_4=D_2+2S$ (C2), $T_4\,n(n-1)\le(n^2-3n+3)t^2$ (C3), $t^2\le nD_2$ (Cauchy-Schwarz) and concludes $2S\,n(n-1)\le(n-2)^2t^2$, exactly C4's inequality. The docstring and INDEX row 105 list all three inputs as hypotheses and the codegree reading as the note's. Nothing is hidden. The equality case is untyped, as the docstring implies.

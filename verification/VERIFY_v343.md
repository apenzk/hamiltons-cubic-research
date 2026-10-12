# Verifier v343, the Λ² multiplicities and dropped counts of L111 step D8 at S³×S³ and S²×S²

*Cold brief ([ADJ_L111_D8.md](ADJ_L111_D8.md)). No numerical work, no scripts written, every value below is exact and derived by hand. Log: [agent_logs/verify-L111-v343.log](../agent_logs/verify-L111-v343.log).*

| # | Claim | Verdict |
|---|---|---|
| 1 | $\dim\Lambda^2\mathbb R^6=15=3+3+9$ and $\dim\Lambda^2\mathbb R^4=6=1+1+4$, as block sizes of the product splitting $\Lambda^2V_1\oplus\Lambda^2V_2\oplus(V_1\otimes V_2)$ | CONFIRMED |
| 2 | The Λ² spectrum of the unit Weyl tensor of $S^3\times S^3$ has multiplicities $(3,3,9)$ | REFUTED. It has two eigenvalues, $\sqrt{10}/10$ with multiplicity $6$ and $-\sqrt{10}/15$ with multiplicity $9$ |
| 3 | The bracket form drops $57$ of $120$ conditions at $S^3\times S^3$ | REFUTED AS STATED. It drops $21+45=66$ of $120$ |
| 4 | The Λ² spectrum of the unit Weyl tensor of $S^2\times S^2$ has multiplicities $(1,1,4)$ | REFUTED. It has two eigenvalues, $\sqrt3/3$ with multiplicity $2$ and $-\sqrt3/6$ with multiplicity $4$ |
| 5 | The bracket form drops $12$ of $21$ conditions at $S^2\times S^2$ | REFUTED AS STATED. It drops $3+10=13$ of $21$ |
| 6 | The arithmetic in `multiplicities_six`, `dropped_six`, `multiplicities_four`, `dropped_four` ($3+3+9=15$, $6+6+45=57$, $1+1+4=6$, $1+1+10=12$) | CONFIRMED AS ALGEBRA |

**Summary: the step FAILS, because Ricci-flatness forces the two factor blocks $\Lambda^2V_1$ and $\Lambda^2V_2$ onto one eigenvalue for every Weyl tensor with the product's block structure, so the spectra are $(6,9)$ and $(2,4)$ and the dropped counts are $66/120$ and $13/21$.**

## 0. Conventions, fixed once

- $n=2p$, $\mathbb R^n=V_1\oplus V_2$ with $\dim V_1=\dim V_2=p$, and $\{e_i\}$ an orthonormal frame adapted to the splitting. Indices $i\in V_1$ means $e_i\in V_1$.
- An algebraic curvature tensor is read as a symmetric operator on $\Lambda^2\mathbb R^n$. A **coordinate-diagonal** operator acts by $e_i\wedge e_j\mapsto w_{ij}\,e_i\wedge e_j$ with $w_{ij}=w_{ji}$. Its Ricci tensor is diagonal with $\mathrm{Ric}_{ii}=\sum_{j\ne i}w_{ij}$.
- The round unit sphere has curvature operator $\mathrm{id}$ on $\Lambda^2$. A Riemannian product of spheres of curvatures $a$ and $b$ therefore has the coordinate-diagonal curvature operator $R$ with $w_{ij}=a$ for $i,j\in V_1$, $w_{ij}=b$ for $i,j\in V_2$, and $w_{ij}=0$ for mixed pairs.
- Unit means Frobenius norm $1$ as an operator on $\Lambda^2$, the inner product of the brief. Normalisation rescales eigenvalues and leaves multiplicities unchanged.
- Following Passage C, criticality `IsCriticalHere` imposes one condition per unordered pair $\{k,l\}$ with $k\le l$, a total of $\binom{N+1}2$. `BracketForm` imposes the condition only when $\lambda_k\ne\lambda_l$, so it drops exactly the pairs with $\lambda_k=\lambda_l$, diagonal included, which is $\sum_i\binom{m_i+1}2$ over the eigenvalue multiplicities $m_i$. This is the definition `dropped m = Nat.choose (m + 1) 2` in [L111.lean](../lean/HamiltonsCubic/Results/L111.lean).

## Hypothesis inventory

- **H1.** "Spectrum" means the eigenvalues of $W$ on $\Lambda^2$ with their multiplicities, as the step's words say. This is also the only reading under which `BracketForm`, keyed to $\lambda_k\ne\lambda_l$, determines a dropped count.
- **H2.** $W\in\mathcal W_n$, so $W$ satisfies the first Bianchi identity and is Ricci-flat (totally trace-free).
- **H3.** The "unit Weyl tensor of $S^p\times S^p$" is the normalised Weyl part of a product metric of two round $p$-spheres. §2 shows the conclusion is the same for every pair of radii, so the radii need not be equal.
- **H4 (the reading that would rescue the numbers).** "Multiplicities" means the dimensions of the three irreducible summands of the $SO(p)\times SO(p)$ isotropy splitting. §4 shows this reading makes claim 1 true but does not reach the dropped counts.

## 1. A block-constant coordinate-diagonal Weyl tensor has one eigenvalue on both factor blocks

Let $W$ be coordinate-diagonal with $w_{ij}=\alpha$ for $i,j\in V_1$, $w_{ij}=\beta$ for $i,j\in V_2$, and $w_{ij}=\gamma$ for mixed pairs. The first Bianchi identity holds automatically for a coordinate-diagonal tensor, since its only nonzero components carry an index pattern $R_{ijij}$ up to the pair symmetries. In the sum $R_{ijkl}+R_{jkil}+R_{kijl}$ with $i,j,k$ distinct every term has at least three distinct indices and vanishes, and with two of $i,j,k$ equal the sum cancels by antisymmetry in each pair. So $W\in\mathcal W_n$ exactly when it is Ricci-flat (this is the $\binom n2-n=n(n-3)/2$ dimensional family Passage A names). Ricci-flatness at an index $i\in V_1$ reads

$$(p-1)\alpha+p\gamma=0,$$

and at an index $i\in V_2$ reads

$$(p-1)\beta+p\gamma=0.$$

Subtracting gives $(p-1)(\alpha-\beta)=0$, and $p\ge2$ gives $\alpha=\beta=-\tfrac{p}{p-1}\gamma$. **So the eigenvalue on $\Lambda^2V_1$ equals the eigenvalue on $\Lambda^2V_2$ for every Weyl tensor with this block structure.** The multiplicity of that shared eigenvalue is $2\binom p2=p(p-1)$, and the eigenvalue $\gamma$ on $V_1\otimes V_2$ has multiplicity $p^2$. If $\gamma=0$ then $W=0$, which has no unit normalisation, so a unit $W$ has $\gamma\ne0$ and two distinct eigenvalues.

## 2. The Weyl tensor of $S^p(a)\times S^p(b)$ is of this form

Take the product curvature operator $R$ of §0. Its Ricci tensor is $(p-1)a$ on $V_1$ and $(p-1)b$ on $V_2$, and its scalar curvature is $s=p(p-1)(a+b)$. The Schouten tensor $A=\frac1{n-2}\big(\mathrm{Ric}-\frac{s}{2(n-1)}g\big)$ is diagonal and constant on each factor, and $A\owedge g$ acts on $e_i\wedge e_j$ by $A_{ii}+A_{jj}$ (the normalisation checked by the round sphere, where $A=\tfrac a2 g$ and $A_{ii}+A_{jj}=a$). Hence $W=R-A\owedge g$ is coordinate-diagonal and constant on the three blocks, so §1 applies and the two factor blocks share one eigenvalue whatever $a,b>0$ are.

For the record, the values. With $n=2p$ and $A_1=\frac{1}{2p-2}\big((p-1)a-\frac{p(p-1)(a+b)}{2(2p-1)}\big)$ on $V_1$ and $A_2$ symmetric on $V_2$:

- **$p=3$, $n=6$.** $A_1=\tfrac{7a-3b}{20}$, $A_2=\tfrac{7b-3a}{20}$. On $\Lambda^2V_1$: $a-\tfrac{7a-3b}{10}=\tfrac{3(a+b)}{10}$. On $\Lambda^2V_2$: $b-\tfrac{7b-3a}{10}=\tfrac{3(a+b)}{10}$. On $V_1\otimes V_2$: $-\tfrac{(7a-3b)+(7b-3a)}{20}=-\tfrac{a+b}{5}$. Check against §1: $2\alpha+3\gamma=\tfrac{3(a+b)}5-\tfrac{3(a+b)}5=0$.
- **$p=2$, $n=4$.** $A_1=\tfrac{2a-b}{6}$, $A_2=\tfrac{2b-a}{6}$. On $\Lambda^2V_1$: $a-\tfrac{2a-b}{3}=\tfrac{a+b}3$. On $\Lambda^2V_2$: $\tfrac{a+b}3$. On $V_1\otimes V_2$: $-\tfrac{a+b}6$. Check against §1: $\alpha+2\gamma=0$.

At equal radii the conclusion also follows from symmetry alone: the isometry exchanging the factors commutes with $W$ and swaps $\Lambda^2V_1$ with $\Lambda^2V_2$, so the two blocks carry one eigenvalue.

## 3. The exact spectra and the dropped counts

**$S^3\times S^3$.** Up to the positive factor $a+b$, $W$ has eigenvalue $\tfrac3{10}$ with multiplicity $6$ and $-\tfrac15$ with multiplicity $9$. Trace $6\cdot\tfrac3{10}-9\cdot\tfrac15=0$. Squared norm $6\cdot\tfrac9{100}+9\cdot\tfrac1{25}=\tfrac{90}{100}=\tfrac9{10}$. The unit Weyl tensor therefore has eigenvalue $\tfrac3{10}\sqrt{\tfrac{10}9}=\tfrac{\sqrt{10}}{10}$ with multiplicity $6$ and $-\tfrac15\sqrt{\tfrac{10}9}=-\tfrac{\sqrt{10}}{15}$ with multiplicity $9$. Check: $6\cdot\tfrac{10}{100}+9\cdot\tfrac{10}{225}=\tfrac35+\tfrac25=1$. The multiplicities are $(6,9)$, and the bracket form drops

$$\binom72+\binom{10}2=21+45=66\quad\text{of}\quad\binom{16}2=120.$$

**$S^2\times S^2$.** Up to the factor $a+b$, $W$ has eigenvalue $\tfrac13$ with multiplicity $2$ (eigenvectors $e_1\wedge e_2$ and $e_3\wedge e_4$, equivalently $e_1\wedge e_2\pm e_3\wedge e_4$, one in each of $\Lambda^\pm$) and $-\tfrac16$ with multiplicity $4$. Squared norm $\tfrac29+\tfrac4{36}=\tfrac13$. The unit Weyl tensor has eigenvalue $\tfrac{\sqrt3}3$ with multiplicity $2$ and $-\tfrac{\sqrt3}6$ with multiplicity $4$. Check: $2\cdot\tfrac13+4\cdot\tfrac1{12}=1$. Each of $W^\pm$ has spectrum $(\tfrac{\sqrt3}3,-\tfrac{\sqrt3}6,-\tfrac{\sqrt3}6)$, the standard shape for $S^2\times S^2$. The multiplicities are $(2,4)$, and the bracket form drops

$$\binom32+\binom52=3+10=13\quad\text{of}\quad\binom72=21.$$

**Where the step fails.** `multiplicities_six` and `dropped_six` treat $\Lambda^2V_1$ and $\Lambda^2V_2$ as separate eigenspaces, giving $\binom42+\binom42+\binom{10}2=57$. They are one eigenspace, and the $3\times3=9$ pairs $(k,l)$ with $k\in\Lambda^2V_1$, $l\in\Lambda^2V_2$ have $\lambda_k=\lambda_l$, so `BracketForm` drops them too: $57+9=66$. Likewise `multiplicities_four` and `dropped_four` miss the single cross pair $(e_1\wedge e_2,e_3\wedge e_4)$: $12+1=13$. Passage C's own first file, `counts_at_balanced_products` in [L111Statement.lean](../lean/HamiltonsCubic/Results/L111Statement.lean), already carries the correct six-dimensional split $6+9=15$ with dropped count $66$ of $120$, so the two Lean files of the same lemma disagree, and the first is right.

## 4. Arguing the opposite

- **Unequal radii (H3 weakened).** §2 shows the two factor eigenvalues coincide for all $a,b>0$, so no choice of radii produces $(3,3,9)$ or $(1,1,4)$.
- **Some other Weyl tensor with the product's block structure.** §1 shows Ricci-flatness forces $\alpha=\beta$ for every block-constant coordinate-diagonal element of $\mathcal W_n$, so no element of $\mathcal W_6$ constant on the three blocks has three distinct eigenvalues. The spectrum $(3,3,9)$ would need to come from a tensor outside that family, and the step names the product tensor.
- **The isotropy reading (H4).** Under $SO(3)\times SO(3)$ the summands $\Lambda^2V_1\cong\mathfrak{so}(3)\oplus0$, $\Lambda^2V_2\cong0\oplus\mathfrak{so}(3)$ and $V_1\otimes V_2$ are irreducible and pairwise inequivalent, of dimensions $(3,3,9)$, and for $p=2$ the dimensions are $(1,1,4)$. Read this way claim 1 holds. The dropped count, however, is defined by `BracketForm`, which keys on equality of the eigenvalues $\lambda_k$ alone, so the count stays $66$ and $13$. The number $57$ counts the conditions dropped by a different form, one that imposes vanishing across isotropy blocks, and Passages A, B and C define the bracket form by eigenvalues. Under the full isotropy group including the factor swap, $\Lambda^2V_1\oplus\Lambda^2V_2$ is a single irreducible summand, and that reading returns $(6,9)$ and $(2,4)$ as well.
- **A different counting convention.** Excluding the diagonal pairs changes both counts by $N$: $66-15=51$ against $57-15=42$, and $13-6=7$ against $12-6=6$. The discrepancy of $9$ and $1$ cross pairs survives every convention, since it is exactly the pairs between the two factor blocks.

## Verdict

**FAILS.** The located failure is `theorem multiplicities_six : 3 + 3 + 9 = Nat.choose 6 2` together with `theorem dropped_six : dropped 3 + dropped 3 + dropped 9 = 57`, and `theorem multiplicities_four : 1 + 1 + 4 = Nat.choose 4 2` together with `theorem dropped_four : dropped 1 + dropped 1 + dropped 4 = 12`. Their arithmetic is correct, but the multiplicities they encode are block dimensions rather than eigenvalue multiplicities: Ricci-flatness forces $\Lambda^2V_1$ and $\Lambda^2V_2$ onto one eigenvalue (§1), so the unit Weyl tensor of $S^3\times S^3$ has spectrum $\sqrt{10}/10$ (×6), $-\sqrt{10}/15$ (×9) and the bracket form drops $66$ of $120$, and that of $S^2\times S^2$ has spectrum $\sqrt3/3$ (×2), $-\sqrt3/6$ (×4) and the bracket form drops $13$ of $21$. No hypothesis rescues the dropped counts: H4 recovers only the block sizes, and the dependent `share_six` ($57/120=19/40$) inherits the error, the correct share being $66/120=11/20$ as `counts_at_balanced_products` and `dropped_fractions` in [L111Statement.lean](../lean/HamiltonsCubic/Results/L111Statement.lean) record.

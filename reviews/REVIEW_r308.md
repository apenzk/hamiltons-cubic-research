# Review r308, the graded split of criticality, and the two-point mass conjecture

Independent implementation from the definitions only, in [scripts/reviewers/r308/](../scripts/reviewers/r308/). Nothing from the code under review was imported: the $\mathfrak{so}(n)$ structure constants, the $\#$ product, the Weyl subspace, the sphere-product operators and the Newton solver were all rebuilt.

## Verdict table

| Claim | Verdict | One line |
|---|---|---|
| L1, criticality splits | **CONFIRMED as an identity, REFUTED as stated** | both equations hold to $10^{-16}$, but they need only $W$-invariance of the splitting; the "hence" from the bracket relations is an over-credit, and the pair carries one independent scalar, not two |
| L2, the $\mathfrak m$-equation is the one to attack | **REFUTED** | at the level L1 states it, the two equations are the *same* equation modulo the definition of $\theta$; at matrix level the $\mathfrak m$-equation is blind to 23 of the 85 available $A$-directions at the witness |
| L3, $\lVert A\rVert^2$ pinned by $(p,q)$ | **REFUTED** | $0.6249259$ at the witness against the exact $13/21=0.6190476$, a $0.95\%$ gap at a residual of $3\times10^{-15}$, and the record's competing $46\%$ figure is measured against a splitting that is not the witness's grading |

**Target not refuted.** No graded critical point above $\sqrt{3/2}$ was found. Across every graded point produced here (pairs $(3,3),(3,4),(3,5),(4,4),(2,6),(3,6),(4,5)$), the maximum $\theta$ is the pair's own sphere-product value, topping out at $\theta_0(8)=1.1456439$.

## Build and controls

Conventions were pinned by two facts outside this repo's code, so no constant was inherited.

- $\mathfrak{so}(n)=\Lambda^2\mathbb R^n$ in the basis $\varphi_{ij}=E_{ij}-E_{ji}$, orthonormal for $\langle A,B\rangle=\tfrac12\operatorname{tr}(A^\top B)$; structure constants read off the matrix commutator.
- $(R\# S)_{ab}=-\tfrac14\big(\operatorname{tr}(C_aRC_bS)+\operatorname{tr}(C_aSC_bR)\big)$ with $C_a=\operatorname{ad}(\varphi_a)$. The overall constant was fixed by the *published* diagonal formula $(R\#S)_{ij,ij}=\tfrac12\sum_k(r_{ik}s_{jk}+r_{jk}s_{ik})$ (Jäger 2016 / Poljsak 2022): agreement to $8.9\times10^{-16}$ on random diagonal $R,S$.

Controls, all at machine precision ([r308_lib.py](../scripts/reviewers/r308/r308_lib.py)):

- $\dim\mathcal W_n=84,168,300$ at $n=6,7,8$, matching $n(n+1)(n+2)(n-3)/12$, from an SVD nullspace of (first Bianchi, Ricci) with no imported projector;
- $\theta(S^{n/2}\times S^{n/2})=\theta_0(n)$ at $n=6,8$ and $\theta(S^3\times S^5)=1.1155467$, $\theta(S^4\times S^6)=1.1858541$, each with $\lVert Q(W)-\theta W\rVert\le1.7\times10^{-16}$;
- the saved witness [w_n8_nondiagonal_witness.npy](../scripts/data/w_n8_nondiagonal_witness.npy) returns $\theta=1.088948053$ at residual $2.9\times10^{-15}$, reproduced, not assumed.

**$Q$ maps $\mathcal W_n$ into $\mathcal W_n$, measured.** On random unit Weyl operators at $n=8$, $\lVert Q(W)-\Pi_{\mathcal W}Q(W)\rVert=7\times10^{-16}$. So the projected criticality equation $\Pi Q(W)=\theta W$ and the unprojected $Q(W)=\theta W$ coincide, and $N:=Q(W)-\theta W$ vanishes identically at every critical point. Any correction term of the form $\langle A,N\rangle$ is structurally zero, at equivariant and non-equivariant points alike; there is no missing hypothesis here.

## L1, the split is real, its stated derivation is not

**Both equations hold, at every point and every splitting tested**, to $\le1.1\times10^{-16}$ ([r308_L1.py](../scripts/reviewers/r308/r308_L1.py)): at $S^3\times S^5$, at the $n=8$ witness in its spectral splitting, and at the witness in the coordinate $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$ splitting.

**Gradedness is not what makes them hold.** Two deliberately non-graded but $W$-invariant splittings were run:

| splitting | $[\mathfrak m,\mathfrak m]$ leakage | L1 $\mathfrak p$-equation | L1 $\mathfrak m$-equation | sorting of $W^\#$ |
|---|---|---|---|---|
| $\mathfrak{so}(3)$-planes vs the other 25, at $S^3\times S^5$ | $15.5$ | holds, $1.1\times10^{-16}$ | holds, $0$ | **fails**, $\lVert W^\#\vert_{\mathfrak m}-2(A\#B)\vert_{\mathfrak m}\rVert=0.478$ |
| first 5 eigenvectors vs the other 23, at the witness | $13.9$ | holds, $5.6\times10^{-17}$ | holds, $1.1\times10^{-16}$ | **fails**, $0.549$ and $0.581$ |

So the recorded framing (the bracket relations sort $W^\#$ by block, *hence* criticality separates), inverts the logic. $W=A\oplus B$ gives $W^2=A^2\oplus B^2$, so $\langle A,W^2\rangle=\operatorname{tr}A^3$ with no cross terms, and $\langle A,\theta W\rangle=\theta\lVert A\rVert^2$; that is the entire hypothesis. The grading buys the *sorting*, which is a statement about what $W^\#\vert_{\mathfrak p}$ is made of, not about whether the equations separate. Confirmed at machine precision where the grading does hold: $W^\#\vert_{\mathfrak p}=(A\#A+B\#B)\vert_{\mathfrak p}$ and $W^\#\vert_{\mathfrak m}=2(A\#B)\vert_{\mathfrak m}$ to $8\times10^{-16}$ at both graded points.

**A further deflation the brief does not mention: at a critical point the block-diagonality of $W^\#$ is free.** $W^\#=\theta W-W^2$, and both terms are block-diagonal for any $W$-invariant splitting. Measured: $\lVert W^\#-W^\#\vert_{\mathfrak p}-W^\#\vert_{\mathfrak m}\rVert=2.3\times10^{-15}$ even in the badly non-graded eigen-splitting above.

**The $\mathfrak m\times\mathfrak m$ term is not zero, it is the larger of the two.** At $S^3\times S^5$: $\operatorname{tr}A^3=0.206794$, $\langle A,A\#A\rangle=0.240943$, $\langle A,B\#B\rangle=0.242840$. At the witness: $0.261675$, $0.174815$, $0.244022$. The $\mathfrak m\times\mathfrak m$ contribution is the single largest term in the $\mathfrak p$-equation at both points.

**The pair carries one independent scalar.** Writing $\tau:=\langle A,B\#B\rangle$, full symmetry of the trilinear form gives $\langle B,2A\#B\rangle=2\tau$ exactly, measured $0.485680=2\times0.242840$ and $0.488044=2\times0.244022$ at the two points, and $0.540244=2\times0.270122$ in the coordinate splitting. So the pair is

$$\theta\lVert A\rVert^2=P(A)+\tau,\qquad \theta\lVert B\rVert^2=\operatorname{tr}B^3+2\tau,$$

with $P(A)=\operatorname{tr}A^3+\langle A,A\#A\rangle$ and $\langle B,B^\#\rangle=0$ because $B\#B$ lives in $\mathfrak p$. Their sum is $\theta=P(W)$, the definition of $\theta$. **Presenting this as two equations overstates it by exactly one.**

**Residual content of L1**, stated positively: on a graded point, criticality contracted against the two blocks gives one scalar identity beyond $P(W)=\theta$, namely $\theta\lVert A\rVert^2=P(A)+\tau$, together with the exact sorting $W^\#\vert_{\mathfrak p}=(A\#A+B\#B)\vert_{\mathfrak p}$, $W^\#\vert_{\mathfrak m}=2(A\#B)\vert_{\mathfrak m}$, which is where the grading earns its keep.

## L2, the route claim is backwards

**Its mechanism is true.** $(W\#W)\vert_{\mathfrak m}=2(A\#B)\vert_{\mathfrak m}$ holds to $8\times10^{-16}$, and it is bilinear in $A$ and $B$ through the isotropy action, exactly as claimed: for $a,b\in\mathfrak m$ both $\operatorname{ad}$'s swap the grading, so the trace picks up $A$ once and $B$ once.

**The conclusion does not follow, on three counts.**

1. **At the level L1 states it, choosing the $\mathfrak m$-equation is not a choice.** The two scalar equations sum to the definition of $\theta$, so either one implies the other. "The $\mathfrak m$-equation is the one to attack" and "the $\mathfrak p$-equation is the one to attack" are the same sentence.
2. **The coupling is not confined to the $\mathfrak m$-equation.** The same scalar $\tau$ sits in the $\mathfrak p$-equation with half the weight. There is no term that appears in one and not the other.
3. **At matrix level the $\mathfrak m$-equation is the *least* sensitive to $A$, not the most.** The $\mathfrak m$-equation $\theta B=B^2+2(A\#B)\vert_{\mathfrak m}$ is *linear* in $A$, and that linear map has a large kernel. Over the 155-dimensional graded Weyl space at $n=8$, $(3,5)$, whose projection to $\mathrm{Sym}(\mathfrak k)$ is 85-dimensional, the rank of $H\mapsto2(H_{\mathfrak k}\#B)\vert_{\mathfrak m}$ is **50 at $S^3\times S^5$ and 62 at the witness**, so the $\mathfrak m$-equation cannot see 35, respectively 23, of the 85 $A$-directions. The $\mathfrak p$-equation carries $(A\#A)\vert_{\mathfrak p}$, quadratic in $A$, and is where $A$'s structure actually enters.

**The one measurement that is kind to L2**, reported because it cuts the other way from the rest: splitting $A$ at the witness into its $\operatorname{ad}(\mathfrak k)$-equivariant part and the rest ($\lVert A_{\rm eq}\rVert=0.712915$, $\lVert A_{\rm ne}\rVert=0.341581$), the coupling does see the non-equivariant part, $\langle A_{\rm ne},B\#B\rangle=4.81\times10^{-2}$, a fifth of $\tau=0.244022$. So the claim is not vacuous, only mis-ranked: $P(A)$ moves by $0.103$ under the same replacement, a larger absolute and relative change.

**What a successor should do instead.** Keep the matrix pair, drop the scalar pair. Given $B$, the equation $2(A\#B)\vert_{\mathfrak m}=\theta B-B^2$ is a *linear* system for $A$: 85 unknowns against 120 equations, of rank 50–62, so it is simultaneously over-determined in its image and blind on its kernel. That is a usable handle in one direction only, it produces consistency conditions on $B$ alone, from the 58–70 dimensions of $\mathrm{Sym}(\mathfrak m)$ outside the image, and it can never determine $A$. Any route that expects the $\mathfrak m$-equation to pin the non-equivariant structure of $A$ is asking a map with a 23-dimensional kernel to be injective.

## L3, refuted, and the record's refutation is measured against the wrong splitting

**The equivariant value is exact and in closed form.** At the equivariant graded point of the pair $(p,q)$,

$$\lVert A\rVert^2=\frac{\tfrac1{2p(p-1)}+\tfrac1{2q(q-1)}}{\tfrac1{2p(p-1)}+\tfrac1{2q(q-1)}+\tfrac1{pq}}=\frac{p^2+q^2-n}{(n-1)(n-2)},\qquad n=p+q,$$

derived from the sphere-product eigenvalues $\big(\tfrac1{p(p-1)},\tfrac1{q(q-1)},-\tfrac1{pq}\big)$ with no numerics: the denominator is $p^2+q^2+2pq-3p-3q+2=(n-1)(n-2)$ identically. It gives $26/42=13/21=0.6190476$ at $(3,5)$ and $4/7=0.5714286$ at $(4,4)$, both reproduced numerically.

**This is not forced by Weyl-ness.** Random unit elements of the graded Weyl space at $n=8$, $(3,5)$ give $\mathfrak k$-block masses spread over $0.383\ldots0.498$, so the pinning is a property of the equivariant critical point, not of the ambient space.

**The framing correction, which is the substantive part of this section.** The brief and Lemma L8 define $\mathfrak p$ and $\mathfrak m$ as the strictly positive and strictly negative eigenspaces of $W$. Measured against that definition:

- the witness's positive eigenspace has dimension 13 and satisfies $[\mathfrak p,\mathfrak p]\subset\mathfrak p$, $[\mathfrak p,\mathfrak m]\subset\mathfrak m$, $[\mathfrak m,\mathfrak m]\subset\mathfrak p$ with bracket defects **exactly $0$** (the same test returns $15.5$ and $3.46$ on deliberately non-graded splittings, so it is not vacuous);
- $\mathbb R^8$ decomposes as $3+5$ under that $\mathfrak p$, the commutant of $\mathfrak p$ in $\mathrm{End}(\mathbb R^8)$ is 2-dimensional with a generic element of multiplicities $\{3,5\}$, so it is a genuine $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$, *conjugate to but distinct from* the coordinate one: the principal angles between the two 13-spaces are $(1,1,1,1,1,0,\ldots,0)$, i.e. they meet in dimension 5;
- conjugating the witness by the $\Lambda^2$ of the orthogonal map that carries its invariant $3+5$ splitting of $\mathbb R^8$ to the coordinate one ([r308_conj.py](../scripts/reviewers/r308/r308_conj.py)) gives a block-diagonal operator with off-block $2.0\times10^{-16}$, $\theta=1.088948053$ preserved at residual $3.1\times10^{-15}$, $A\succ0$ (spectrum $0.0667\ldots0.5731$), $B\prec0$ (spectrum $-0.3024\ldots-0.0989$), and $\lVert A\rVert^2=\mathbf{0.6249259}$.

So $0.6249259$ *is* the coordinate $\mathfrak k$-block mass, in the frame where the witness's grading is the coordinate pair. The competing figure $0.332496$ is the witness's $\mathfrak k$-block in the *original* frame, where the coordinate $\mathfrak k$-block is indefinite (8 negative and 5 positive eigenvalues) and therefore is not the grading the definition names. The witness is block-diagonal for two different $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$ pairs; L1's identities hold for both, but only one of them is its $\mathbb Z_2$-grading. **The "$46\%$ deviation" now in [graded-half.md](../findings/graded-half.md) compares $S^3\times S^5$'s grading block against the witness's non-grading block.**

**The verdict is unchanged by the correction: L3 is refuted either way.** $0.6249259\ne0.6190476$ at a criticality residual of $3\times10^{-15}$; the gap is $5.878\times10^{-3}$, i.e. $0.95\%$, some twelve orders of magnitude above the noise. $\lVert A\rVert^2$ is not pinned by $(p,q)$, the two equations do not become a two-variable system, and no extension of Lemma L8 off the equivariant locus follows. What changes is the size of the failure and the reason for it, and the record should not keep a figure that is $50\times$ too large.

**A second scalar, to show the near-agreement is a coincidence of one number.** The positive trace $\operatorname{tr}A$ is $2.390457$ at $S^3\times S^5$ against $2.165992$ at the witness, a $9.4\%$ gap on the same two points whose mass split agrees to $0.95\%$. Nothing about the two graded points is nearly equal in general.

## The search for more graded points

The block-diagonal Weyl space over a symmetric pair was rebuilt independently, dimension 155 at $n=8$, $(3,5)$, matching the figure in [run_f4b_newton.py](../scripts/runs/run_f4b_newton.py), and the criticality system was reduced to coordinates by precomputing the symmetric cubic tensor $T_{abc}=\langle B_a,\Phi(B_b,B_c)\rangle$ on that basis (symmetric to $4\times10^{-16}$, and reproducing $\langle B_a,Q(W)\rangle$ to $4\times10^{-14}$). Solves use a hand-rolled damped Gauss–Newton, and every solution is re-screened against the *full* $\mathcal W_n$ residual $\lVert Q(W)-\theta W\rVert<10^{-9}$.

**Gradedness was imposed rather than hoped for.** A block-diagonal critical point with $W\vert_{\mathfrak k}\succ0$ and $W\vert_{\mathfrak m}\prec0$ has its sign eigenspaces equal to $\mathfrak k$ and $\mathfrak m$, so it is graded by definition; and every graded critical point of type $(p,q)$ is conjugate to one of these, as the witness's own conjugation demonstrates. That makes the search exhaustive up to conjugacy, which an unfiltered solve is not: an unfiltered run at $n=7$, $(3,4)$ returned 129 distinct critical points of which **one** was graded.


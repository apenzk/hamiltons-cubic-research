# Brief, round L88

**Cold brief. Every passage below is quoted verbatim from the record, with its source lines. No prior verdict is included.**

## Passage A, the heading and the argument ([findings/sym3-blocks.md](../findings/sym3-blocks.md) line 106, and lines 120-130)

#### Lemma L88, $\dim\mathrm{Sym}^2=65$, $\dim\Lambda^2=24$, and the $24$ are gauge

## The unknown count is real symmetric, and a Hermitian ansatz over $\mathbb Q(i)$ inflates it

An SOS Gram is an invariant **quadratic form** on $\mathrm{Sym}^3(\mathcal W_5)$, so the unknowns are $\mathrm{Sym}^2(\mathrm{Sym}^3\mathcal W_5)^{O(5)}$, a dimension rather than a basis convention. Weyl integration settles it in [run_n5_unknown_count.py](../scripts/runs/run_n5_unknown_count.py), touching none of the certificate machinery: no adapted basis, no cache, no prime, no highest-weight vectors.

$$\dim\mathrm{Sym}^2(\mathrm{Sym}^3\mathcal W_5)^{O(5)}=65,\qquad \dim\Lambda^2(\mathrm{Sym}^3\mathcal W_5)^{O(5)}=24,\qquad 65+24=89,$$

and those are exactly $\sum m(m+1)/2$, $\sum m(m-1)/2$ and $\sum m^2$ on the measured multiplicities, twelve blocks with $m=1$, nine with $m=2$, one with $m=3$, two with $m=4$. **So the $24$ directions a Hermitian ansatz offers beyond the $65$ are genuine $O(5)$-invariants, of $\Lambda^2$. An antisymmetric form contributes nothing to a quadratic, hence nothing to the sextic, and they are gauge.**

**THE DIMENSION IS RIGHT AND THE COORDINATES ARE NOT.** *Reviewer 204, refuting the labelling rather than the count.* That $24$ of the $89$ directions are gauge is a theorem. That they are the *imaginary* coordinates of the $\mathbb Q(i)$ highest-weight basis is **false**: the identification holds only in a basis real for the real structure $\sigma$, and such a basis forces $h$ real symmetric, while $h$ is *measured* non-real on $\lambda=(2,0)$. On a multiplicity-$2$ block the kernel direction is the imaginary coordinate iff $\operatorname{Im}h=0$, and over $4000$ bases consistent with the measured $h$ the relative distance never fell below $0.541$. **The converse fails too**: $Q=\mathrm{diag}(1,i)$ gives $h=I$ with a real symmetric kernel direction, which the split would have kept among the $65$. Rephasing one copy by $i$ moves the split while passing the Hermitian assert, $\det h\ne0$ and the multi-probe test. *Identifying the actual $24$ needs the real structure computed on each $M_\lambda$.*

**They appear because the $41$ highest-weight vectors were built over $\mathbb Q(i)$ and are not a real basis of $M_\lambda$.** Every one of the $24$ weights is *integral* for $B_2$, hence of real type, the quaternionic representations of $\mathfrak{so}(5)\cong\mathfrak{sp}(4)$ are the half-integral spin ones, and none occur, so each multiplicity space carries a real structure and the invariant form is real symmetric in a real basis. **That $h$ is measured Hermitian with nonzero imaginary off-diagonals is the evidence that the basis in hand is not that one**, and it is not a contradiction: reviewer 192's $h=\begin{psmallmatrix}1&55i/37\\-55i/37&5075/1628\end{psmallmatrix}$ on $(2,0)$ is reproduced exactly by reviewers 201 and 202.

## Passage B, the block table the sums are taken over, a given ([findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 23-36)

## The 24 blocks

The dimension and Casimir columns are arithmetic on the highest weights: the Weyl dimension formula for $B_2$ is a product of four linear factors, and $c_2(\lambda)=\lambda_1(\lambda_1+3)+\lambda_2(\lambda_2+1)$. The weight list and the multiplicities come from the character computation. [run_casimir_separation.py](../scripts/runs/run_casimir_separation.py).

| mult | blocks (highest weight, dimension) | unknowns |
|---|---|---|
| $4$ | $(4,2)_{220}$, $(2,2)_{35}$ | $20$ |
| $3$ | $(3,2)_{105}$ | $6$ |
| $2$ | $(5,2)_{390}$, $(4,3)_{231}$, $(4,4)_{165}$, $(4,1)_{154}$, $(3,1)_{81}$, $(4,0)_{55}$, $(2,1)_{35}$, $(3,0)_{30}$, $(2,0)_{14}$ | $27$ |
| $1$ | $(6,6)_{455}$, $(6,4)_{810}$, $(6,3)_{770}$, $(6,2)_{625}$, $(6,0)_{140}$, $(5,4)_{429}$, $(5,3)_{455}$, $(5,1)_{260}$, $(5,0)_{91}$, $(3,3)_{84}$, $(1,0)_{5}$, $(0,0)_{1}$ | $12$ |

The table has $24$ blocks, $\sum m_\lambda d_\lambda=7770=\binom{37}3$ exactly, multiplicities summing to $41$ and unknowns to $65$, of which only $7770$ is an external check. The twelve multiplicity-$1$ dimensions sum to $4125$.

**The trivial multiplicity is $1$ here**, which agrees with the Lovelock relation $\langle W^\#,W\rangle=2\operatorname{tr}(W^3)$ on $\mathcal W_5$ ([bispectral.md](bispectral.md)): the cubic invariants are then spanned by $\operatorname{tr}(W^3)$ once the two contractions span them. *That spanning, and $\operatorname{tr}(W^3)\not\equiv0$ on $\mathcal W_5$, are owed.*

## Passage C, the Lean files

Both Lean files are withheld, their docstrings quoting prior verdicts.

## Definitions and sources

- $\mathcal W_5$ is the space of algebraic Weyl tensors on $\mathbb R^5$, $U=\mathrm{Sym}^3(\mathcal W_5)$, decomposed under $O(5)$ as $\bigoplus_\lambda V_\lambda\otimes M_\lambda$ with $\dim M_\lambda=m_\lambda$. An SOS Gram for a sextic is a quadratic form on $U$.
- Schur's lemma and the real, complex and quaternionic types of real representations are classical and unfiled.
- **This loop does no numerical work**; a statement supported only by a script, a run or a measurement is HYPOTHESIS-DEBT.
- The lemma has **no entry in [results.md](../results.md)**.

## What to attack, beyond the standing list

1. **The three dimensions**: $\dim\mathrm{Sym}^2(U)^{O(5)}=65$, $\dim\Lambda^2(U)^{O(5)}=24$, $65+24=89$. Whether an argument on file gives them, or only the cited script, and whether $\sum\binom{m+1}2$, $\sum\binom m2$, $\sum m^2$ over Passage B produce them.
2. **"$65+24=89$"** as a check: what it could detect.
3. **Real type**: "Every one of the $24$ weights is *integral* for $B_2$, hence of real type, the quaternionic representations ... are the half-integral spin ones", and the consequence that the invariant form is real symmetric in a real basis.
4. **"The $24$ directions ... are genuine $O(5)$-invariants, of $\Lambda^2$. An antisymmetric form contributes nothing to a quadratic, hence nothing to the sextic, and they are gauge"**, both for the map from Gram to sextic and for positive semidefiniteness of a Gram.
5. **"The dimension is right and the coordinates are not"**: the claim about the $\mathbb Q(i)$ basis, the measured non-real $h$, the "$4000$ bases" figure, and the converse example $Q=\mathrm{diag}(1,i)$.
6. **Scope**: dependence on Passage B's multiplicities, which carry no derivation on file.
7. **Passage C**, if read: what the Lean files state.

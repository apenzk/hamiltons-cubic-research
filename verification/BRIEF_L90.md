# Brief, round L90

**Cold brief. Every passage below is quoted verbatim from the record, with its source lines. No prior verdict is included.**

## Passage A, the heading and the argument ([findings/sym3-blocks.md](../findings/sym3-blocks.md) line 149, and lines 163-181)

#### Lemma L90, evaluation is injective on the image

**Why $40$ equations give an identity, which is the load-bearing step and was nowhere in the record.** Satisfying the map's equations at $40$ points is agreement of polynomials at $40$ places, not equality, unless evaluation is injective on the image. Writing $\mu$ for the Gram-to-sextic map and $\mathrm{ev}$ for evaluation, $\ker(\mathrm{ev}\circ\mu)\supseteq\ker\mu$ always, while $\mathrm{rank}(\mathrm{ev}\circ\mu)=13=\mathrm{rank}\,\mu$ is measured at four primes. Equal dimensions force equal kernels, so $\mathrm{ev}$ is injective on the image and a sextic there is pinned by those $40$ values. $F_5$ lies in the image, so the unique element agreeing with it at those points **is** $F_5$.

**Two audits stand behind it, and both found real errors.** Reviewers 211 and 212, independently and two minutes apart, refuted the first point: the dump ordered blocks by $\lambda$ while the consumer ordered them by $(-m,\lambda)$, so the $47$ columns were partitioned wrongly and the reported point had minimum eigenvalue $-1440$. Corrected, the optimum is $t=2.34\times10^{-2}$, strictly positive and interior. **And the first acceptance test was itself wrong**: an inline LDL passed the denominator-$10^4$ point, whose second block has third leading minor $-3.47\times10^{-4}$, the same defect reviewers 181 and 182 had found in [run_n5_sdp.py](../scripts/runs/run_n5_sdp.py)'s `ldl_psd`, reintroduced. *A false certificate is the one error here that would not announce itself, which is why the accepted point is verified by a file that shares no code with the one producing it.*

**THE RESTRICTED RANK IS $13$, AND THE NECESSARY CONDITION IS A THEOREM.** The restricted sampled rank attains the derived cap: $13$ at $40$ points mod $1000033$, and reviewer 209 reproduced it independently at $p=1000003$ (which is $3\bmod4$, so $\mathbb F_p[i]$ is a field rather than a split algebra), with its own code, its own points, and $T$ rebuilt from three different positions. Sampling and reduction only lose rank, so attaining the cap forces equality.

$$\mathrm{rank}=13,\qquad \dim\mathrm{ANN}=1,\qquad \mathrm{ANN}=\mathbb R\,\mathcal A(W_0^6),\qquad \boxed{F_5\ \text{lies in the image}}$$

since $F_5\perp\mathcal A(W_0^6)$ because $F_5(W_0)=0$, exact over $\mathbb Z$ in both normalisations. **The affine family is $36-13=23$ dimensional**, and reviewer 208's numerical determination (gap $425$–$458$, kernel at $0.02°$) is confirmed by exact arithmetic.

**Three things the cap argument needs, each found by an audit rather than stated in advance.**

- **The rank cap is conditional on equivariance.** The sampled row is $\mu^*(\mathrm{ev}_W)$ only when the copies are identified equivariantly; reviewer 209 exhibited $S_3$ on $\mathbb R^3$ where giving one copy its own position list yields sampled rank $10$ against a cap of $7$. **What guards it is the multi-probe Schur test**, which is therefore load-bearing for the rank argument and was not described as such.
- **Vanishing at $W_0$ suffices for vanishing on the orbit**, because the restriction cuts the *copy* index and leaves $V_\lambda$ whole, so the restricted cubics form an $O(5)$-submodule, and a submodule vanishing at $W_0$ vanishes at every $gW_0$. *Reviewer 210; the record had asserted the equivalence without argument.* Restricting positions instead would break it.
- **Attainment is not self-validating.** A defect landing the rank exactly *on* the cap is invisible. The three wrong restrictions were caught only by coming out *above* it, the correct condition is $Ta=0$ for the **expansion** vector $a$, **unconjugated**; the two wrong ones each carried one half, and the vectors differ by the multiplicity Gram.

**On the restricted space the argument does not carry, and the rank is open in $[1,13]$.** The certificate ranges over the cubics $K$ satisfying $\sigma_\lambda(W_0)=0$, which do **not** span $\mathrm{Sym}^3$, so $\mu$ restricted to them need not stay onto.

- **Upper bound $13$, and it comes from order $1$.** *Reviewer 203.* A product of two cubics of $K$ already vanishes at $W_0$, and evaluation there is a nonzero functional on the $14$. What order-$2$ vanishing shows is that the bound **cannot be sharpened** by demanding more vanishing at the point, the extra condition being free.

## Passage B, Lemma L89, a given ([findings/sym3-blocks.md](../findings/sym3-blocks.md) line 128)

**Statement.** Let $\mu:\mathrm{Sym}^2(\mathrm{Sym}^3\mathcal W_5^*)\to\mathrm{Sym}^6\mathcal W_5^*$ be multiplication. Then $\mu$ restricted to $O(5)$-invariants is onto $(\mathrm{Sym}^6\mathcal W_5^*)^{O(5)}$, so its rank is $\dim(\mathrm{Sym}^6\mathcal W_5^*)^{O(5)}$ and its nullity is $\dim\mathrm{Sym}^2(\mathrm{Sym}^3\mathcal W_5^*)^{O(5)}$ less that rank. **With Observation L85's $14$ and L88's $65$, which rests on Observation L83's table, these are $14$ and $51$**, and the two values carry those Observations' standing.

## Passage C, Lemma L62, a given ([findings/sym3-blocks.md](../findings/sym3-blocks.md) line 260)

#### Lemma L62, $\dim\mathrm{ann}=1$, so the rank is $13$

## Passage D, the Lean files

Both Lean files are withheld, their docstrings quoting prior verdicts.

## Definitions and sources

- $\mathcal W_5$ is the space of algebraic Weyl tensors on $\mathbb R^5$, $W_0$ the padded Weyl tensor of $\mathbb{CP}^2$, $F_5=\tfrac32\lVert W\rVert^6-9\operatorname{tr}(W^3)^2$. $\mu$ carries a Gram to its sextic, $\mathrm{ev}$ evaluates a sextic at the $40$ sample points, $K$ is the space of cubics with $\sigma_\lambda(W_0)=0$. $\mathcal A$ and $\mathrm{ANN}$ are as Passage A uses them.
- **This loop does no numerical work**; a statement supported only by a script, a run or a measurement is HYPOTHESIS-DEBT. A rank computed mod a prime and reported is a measurement.
- The lemma has **no entry in [results.md](../results.md)**.

## What to attack, beyond the standing list

1. **The load-bearing step**: "$\ker(\mathrm{ev}\circ\mu)\supseteq\ker\mu$ always, while $\mathrm{rank}(\mathrm{ev}\circ\mu)=13=\mathrm{rank}\,\mu$ is measured at four primes. Equal dimensions force equal kernels". Which of the two ranks is measured, which direction sampling bounds, and whether the step is circular.
2. **Whether a non-circular route exists in the passages**: Passage C's cap, and the unrestricted rank.
3. **"Was nowhere in the record"**, and the attribution "measured at four primes" and "two audits stand behind it".
4. **The restricted rank**: "$13$ at $40$ points ... Sampling and reduction only lose rank, so attaining the cap forces equality", and the display $\mathrm{rank}=13$, $\dim\mathrm{ANN}=1$, $F_5$ in the image.
5. **"On the restricted space the argument does not carry, and the rank is open in $[1,13]$"** against item 4.
6. **The three conditions**: equivariance of the sampled row, vanishing at $W_0$ sufficing for the orbit, attainment not self-validating.
7. **Why $40$ points**, and the statement's scope: which map, which space, which points.
8. **Passage D**: what the Lean files state.

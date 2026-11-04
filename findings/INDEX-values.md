# Index, every catalogued value

**Check a new number against this file before calling it new.** Values are $\theta$ at a critical point unless marked otherwise. Grep the file named, or `grep -rn` over [findings/](.).

*Three refutations on record came from points already here, all missed because the search used the vocabulary of the construction rather than the value.* **Query by NUMBER, not by name.**

**Ten of these values appear in the record in two printings, a rounding and a truncation one part in $10^6$ apart, and $58$ of $216$ occurrences, $26.9\%$, use the truncated one; for $1.248376$, $0.759555$ and $0.686607$ the truncation is the *more* common form.** Each such row prints both spellings, so **a query by number finds the row whichever form it was written in**, audited in full at [PrintingAudit.lean](../lean/HamiltonsCubic/Results/PrintingAudit.lean).

Results by number: [INDEX-results.md](INDEX-results.md). Which file for which subject: [INDEX.md](INDEX.md).

**Check a new number against this table before calling it new.** Values are $\theta$ at a critical point unless marked otherwise. Grep the file named, or `grep -rn findings/`.

| $\theta$ | Point | $n$ | Where |
| --- | --- | --- | --- |
| $\sqrt2=1.414214$ *(also written 1.414213)* | limit of $\theta_0(n)$ | $\to\infty$ | [problem.md](problem.md) |
| $1.270978$ | $S^7\times S^8$, $\Theta_{15}^2=\frac{2\cdot14\cdot12}{16\cdot13}=\frac{336}{208}=\frac{21}{13}$ | 15 | [route-a.md](route-a.md) |
| $1.248376$ *(also written 1.248375)* | $S^6\times S^7$, $\Theta_{13}^2=\frac{2\cdot12\cdot10}{14\cdot11}=\frac{240}{154}=\frac{120}{77}$ | 13 | [route-a.md](route-a.md) |
| $1.324617$ | $S^{11}\times S^{13}$ | 24 | [target.md](target.md) |
| $1.236033=\theta_0(12)$ | $S^6\times S^6$, the conjectured maximiser | 12 | [problem.md](problem.md) |
| $1.228239=\sqrt{264/175}$ | $S^5\times S^7$, **refutes the band target** | 12 | [target.md](target.md) |
| $\sqrt{3/2}=1.224745$ *(also written 1.224744)* | $W_{\mathbb{CP}^2}$ and every padding, **the threshold**, and now **proved to be the maximum over all compact *irreducible* symmetric spaces**. *Built exactly over $\mathbb Q$ at $n=5$: $\Lambda^2$ spectrum $(2,-1,-1,0^7)/\sqrt6$, $\lVert W_0\rVert^2=1$, $\mathop{\mathrm{tr}}(W_0^3)=1/\sqrt6$, and first Bianchi with $\mathrm{Ric}=0$ satisfied exactly*, [run_n5_extremiser.py](../scripts/runs/run_n5_extremiser.py) | $\ge4$ | [target.md](target.md), [graded-half.md](graded-half.md), [sym3-blocks.md](sym3-blocks.md) |
| $1.200000=\theta_0(10)$ | $S^5\times S^5$ | 10 | [problem.md](problem.md) |
| $1.145644=\theta_0(8)$ *(also written 1.145643)* | $S^4\times S^4$ | 8 | [problem.md](problem.md) |
| $1.115547=\sqrt{56/45}$ *(also written 1.115546)* | $\mathbb{HP}^2$ **and** $S^3\times S^5$, a triality pair, one diagonal and one not | 8 | [target.md](target.md) |
| $1.095445=\sqrt{6/5}$ | $(\mathfrak{su}(3),\mathfrak{so}(3))$; also Jensen's second metric on $S^3\times S^3$ | 6 | [target.md](target.md) |
| $1.054093=\theta_0(6)$ *(also written 1.054092)* | $S^3\times S^3$ **and** $\mathbb{CP}^3$, $\theta^2=\tfrac{10}9$ for both, **exactly** (Reviewer 93; previously only to $2\times10^{-16}$), so the named maximiser is not unique at $n=6$ | 6 | [graded-half.md](graded-half.md) |
| $1.035098$ | $(\mathfrak{su}(5),\mathfrak{so}(5))$ | 10 | [target.md](target.md) |
| $1.024695$ | $(\mathfrak{su}(6),\mathfrak{so}(6))$ | 12 | [target.md](target.md) |
| $0.986013$ | $\mathbb{CP}^4$, **and [graded-half.md](graded-half.md)'s table carries this value at the same $n$ under $SO(8)/U(4)$**, a space of $\dim\mathfrak m=12$ against $\mathbb{CP}^4$'s $8$; whether the two coincide is open ([HermitianCollision.lean](../lean/HamiltonsCubic/Results/HermitianCollision.lean)) | 8 | [graded-half.md](graded-half.md) |
| $0.948683$ | $\mathbb{CP}^5$ | 10 | [graded-half.md](graded-half.md) |
| $\kappa^2=\frac3{m+1}$ | the frame-optimised diagonal spread on $\mathbb{CP}^m$, **not a $\theta$**, listed because $\theta/\kappa\to\infty$ refutes "large $\theta$ forces near-diagonality" | $2m$ | [bispectral.md](bispectral.md) |
| $0.866025=\sqrt3/2$ | $(+\mathrm{Fox})\oplus(-\mathrm{Fox})$ | 8 | [second-order.md](second-order.md) |
| $0.836660=\sqrt{7/10}$ | $\mathfrak{su}(3)$ adjoint; also the Type II closed form $\theta^2=\frac{4(n-1)}{n(n-3)}$ at $n=8$ | 8 | [graded-half.md](graded-half.md) |
| $0.720082=\sqrt{14/27}$ | $\mathrm{Gr}_{\mathbb C}(2,2)$ | 8 | [graded-half.md](graded-half.md) |
| $0.596068=\sqrt{275/774}$ | $\mathrm{Gr}_{\mathbb C}(2,3)$ | 12 | [graded-half.md](graded-half.md) |
| $1.0825318=\tfrac{5\sqrt3}8$ | **unidentified**, found by [r315](../reviews/REVIEW_r315.md) in $6$ of $400$ slice ascents at $n=8$, spectrum multiplicities $3+3+8$ on a $14$-dimensional support, the dimensions of $\mathfrak g_2$ and its $\mathfrak{su}(3)$-decomposition, and **not** a symmetric-pair grading | 8 | [graded-half.md](graded-half.md) |
| $0.759555=\sqrt{15/26}$ *(also written 0.759554)* | $Q_3=G_2(\mathbb R^5)$, has $S=30$, **not** $S=0$ | 6 | [target.md](target.md) |
| $0.717137=\sqrt{18/35}$ | $\mathfrak{so}(5)$ adjoint, **the Type II closed form $\theta^2=\frac{4(n-1)}{n(n-3)}$ at $n=10$**, the same form the $0.836660$ row carries at $n=8$ | 10 | *no findings file states this value; see [ValuePointers.lean](../lean/HamiltonsCubic/Results/ValuePointers.lean)* |
| $0.699379=\sqrt{45/92}$ *(also written 0.699378)* | $Q_5=G_2(\mathbb R^7)$ | 10 | [target.md](target.md) |
| $0.686607=\sqrt{33/70}$ *(also written 0.686606)* | $Q_6=G_2(\mathbb R^8)$ | 12 | [target.md](target.md) |
| $1.088948$ | **the highest $\{S=0,\ \Delta>0\}$ critical point on record, and NON-diagonal**, $\Delta=1.512231$, $\dim\mathfrak m=15$, trivial kernel, five distinct positive eigenvalues, on the graded block-diagonal space over $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$; siblings at $1.083689$, $1.081549$, $1.080092$. It cuts the margin to $\sqrt{3/2}$ from $1.71\times$ to $1.12\times$ | 8 | [bounds.md](bounds.md) |
| $0.716134$ | the highest **diagonal** $\{S=0,\ \Delta>0\}$ critical point, $\Delta=16.3998$, twelve distinct rows, found from a random maximal triangle-free negative graph, it displaces the $C_5$ blow-up as the ceiling and is still $1.71\times$ below $\sqrt{3/2}$ | 12 | [bounds.md](bounds.md) |
| $0.670820$ | the $C_5$ blow-up, highest $S=0$, $\Delta>0$ point **at $n=10$**, no longer the ceiling | 10 | [diagonal-half.md](diagonal-half.md) |
| $0.5557$, $0.0823$ | the two $8$-cycle circulants | 8 | [second-order.md](second-order.md) |
| $0.852944=\sqrt{275/378}$ *(also written 0.852943)* | $\mathbb{HP}^3$ | 12 | [graded-half.md](graded-half.md) |
| $0.745356=\sqrt{5/9}$ | $\mathbb{HP}^4$ | 16 | [problem.md](problem.md) |

**Recurring numbers that are not a $\theta$**, listed because they have been mistaken for one: $0.5748$ the tube radius; $1.206011$ the ratio $\lambda_{\max}(M)/\theta$ at the $C_5$ blow-up; $1.7227$, $1.5305$, $1.413614$, $1.306498$ linear-programming optima; $\tfrac12$ the second-order eigenvalue bound; $\sqrt3$ the target for $M(n)$.


**The quaternionic family is closed in form**: $\theta^2(\mathbb{HP}^m)=\frac{(m+2)^2(4m-1)}{9m(m-1)(2m+1)}$, strictly decreasing, so $\sup_m\theta=\sqrt{56/45}<\sqrt{3/2}$ and $\theta\to\sqrt2/3$, every $m$ is covered without adding a row. Likewise $\mathbb{CP}^m$ at $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$ and the $(\mathfrak{su}(m),\mathfrak{so}(m))$ family at $\theta^2=\frac{m(m+1)}{(m-1)(m+2)}$.

**AND THE MULTI-BLOCK SPHERE-PRODUCT FAMILY IS CLOSED IN FORM, AT EVERY $k$**: for $S^{n_1}\times\dots\times S^{n_k}$ with each $n_a\ge2$ and $n=\sum_an_a$, $\theta^2=1/(4R)$ with $R=\tfrac{k-1}8+\tfrac18\big(\sum_a\tfrac1{n_a-1}-\tfrac1{n-1}\big)$, which is $\lVert W\rVert^2$ at the Einstein normalisation $\lambda=\tfrac12$. *Proved at every $k$ by [Lemma L212](graded-half.md#lemma-l212-the-multi-block-vertex-solution-is-critical-at-every-partition-and-its-second-moment-is-the-norm-identity), where the form was on file verified symbolically to $k=4$, and equivalent to [ungraded-slack.md](ungraded-slack.md)'s $\theta^2=\frac{2(n-1)^2}{(k-1)n^2+\sum_a(n-n_a)^2/(n_a-1)}$.* **So a two-block or multi-block value is CHECKED against this form rather than sought in the table above**, which carries only the individual points a cycle happened to record: $\theta_0(12)$, $S^5\times S^7$ and $S^7\times S^8$ are all instances of it.

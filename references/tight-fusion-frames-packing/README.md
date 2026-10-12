# Tight fusion frames and Grassmannian packings, two sources

| | |
| --- | --- |
| **Sources** | [A brief introduction to equi-chordal and equi-isoclinic tight fusion frames](https://arxiv.org/abs/1708.08879), Casazza and Fickus; [Robust dimension reduction, fusion frames, and Grassmannian packings](https://arxiv.org/abs/0709.2340), Kutyniok, Pezeshki, Calderbank and Liu |
| **Retrieved** | 2026-09-12, as [casazza-fickus-1708.08879.pdf](https://arxiv.org/abs/1708.08879) and [kutyniok-0709.2340.pdf](https://arxiv.org/abs/1708.08879), extracted alongside |
| **Consulted for** | [I80](../../plan.md)'s premise, that Grassmannian packing bounds cap how many $2$-planes with one right principal angle per pair can coexist, and so bound eigenvalue multiplicities |
| **Statements that matter** | Casazza–Fickus **Theorem 5.1**, the simplex bound $\max_{j\ne j'}\lVert\Phi_j^*\Phi_{j'}\rVert_{\mathrm{Fro}}^2\ge\frac{c(Mc-d)}{d(M-1)}$ with equality exactly at an equi-chordal tight fusion frame, and the equi-isoclinic condition $P_{j'}P_jP_{j'}=\sigma^2P_{j'}$ with $\sigma^2=\frac{Mc-d}{d(M-1)}$ |

## Verdict

**The simplex bound is this record's own per-index relation.** *At $c=2$ and $d=n$ it reads $\max_{\alpha\ne\beta}S_{\alpha\beta}\ge\frac{2(2M-n)}{n(M-1)}$, and $\sum_{\beta\ne\alpha}S_{\alpha\beta}=2(\kappa-1)$ with $\kappa=2M/n$ has exactly that as its mean, so the two are one statement and the symbolic difference is zero.* **Its equality case, the tight fusion frame $\sum_jP_j=\alpha I$, is the record's isotropy condition**, which confirms the vocabulary and supplies no new constraint.

**It caps no multiplicity.** *The bound is a lower bound on the largest overlap, and capping a multiplicity needs an upper one; $S_{\alpha\beta}\le1$ is too weak to bite at any $n>4$. At a full decomposable basis it gives only $\max S\ge\frac4{n+1}$.* **So [I80](../../plan.md)'s stated payoff does not follow from it.** *Detail at [diagonal-half.md](../../findings/diagonal-half.md)'s I76 section.*

**What the sources do give is the equi-isoclinic notion**, which the record had already met: the six icosahedral complex lines in $\mathbb C^3=\mathbb R^6$ form an equi-isoclinic tight fusion frame at $\cos^2=\frac15$ and fail $\Lambda^2$-orthonormality, which is how that configuration was already disposed of.

**Both ids were checked against their titles before fetching**, which is how this pair differs from [I79](../../plan.md)'s, where one cited id turned out to be a paper on another subject.

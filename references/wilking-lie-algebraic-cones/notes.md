# Wilking, the Lie-algebraic form of `#`

**B. Wilking, *A Lie algebraic approach to Ricci flow invariant curvature conditions and Harnack inequalities*, [arXiv:1011.3561](https://arxiv.org/abs/1011.3561)** (J. reine angew. Math.). Found while searching for a bound on $\langle M^\#,M\rangle$, the term route B must couple. **The formula it supplies was already implemented in [rsharp_basis_free.py](../../scripts/rsharp_basis_free.py) and already stated in sources filed here**; this note records the citation, not a discovery.

## The definition this programme needs, quoted from the body

> $R' = R^2 + R^\#$ where $\langle R^\#x,y\rangle=-\tfrac12\operatorname{tr}(\mathrm{ad}_x R\,\mathrm{ad}_y R)$ for $x,y\in\mathfrak g$.

And the step it makes available, from the paper's own Claim (p. 212 of the extraction):

> If $R\in C(S,h)$ and $v\in S$ with $R(v,\bar v)=h$, then $R^2(v,\bar v)+R^\#(v,\bar v)\ge0$, via $2R^\#(v,\bar v)=-\operatorname{tr}(\mathrm{ad}_v R\,\mathrm{ad}_{\bar v}R)\ge0$.

## Why it matters here

The record's target is $\theta=\langle W,Q(W)\rangle$ with $Q(W)=W^2+W^\#$, and the bi-spectral identity puts it as $\theta=p_3(\mu)+\langle M^\#,M\rangle$. **So the whole coupling problem is a statement about $\langle M^\#,M\rangle$**, the term separating the two spectra, since $\langle M^\#,M\rangle=\tfrac12(p_3(\mu)-p_3(\omega))$.

The formula above rewrites that term through the **adjoint representation of $\mathfrak{so}(n)$**: $\langle M^\#,M\rangle$ is a trace of products of $\mathrm{ad}$-operators, so its size is governed by the structure constants and the Killing form rather than by the spectrum alone.

**That is exactly what [fence post 33](../../findings/INDEX.md) demands.** Post 33 proves two moments plus a support bound cannot supply the coupling, so the coupling must use the operator itself and not its spectrum, and $\mathrm{ad}$ is the operator-level structure the spectrum discards.

## The target this opens

> **Bound $\lvert\langle M^\#,M\rangle\rvert$ in terms of $\operatorname{tr}(M^3)$ and $\lVert M\rVert$ using the $\mathrm{ad}$-form**, sharply enough that $\theta=p_3(\mu)+\langle M^\#,M\rangle$ closes at $\theta_0(n)$.

*Separate Okumura caps on the two cubics reach $4.0129$ at $n=12$ against $\theta_0(12)=1.236$, a factor $3.25$ ([bispectral.md](../../findings/bispectral.md)). Any bound treating the two terms independently is already known to fail by that margin, so the $\mathrm{ad}$-form has to be used for the coupling and not as a second separate cap.*

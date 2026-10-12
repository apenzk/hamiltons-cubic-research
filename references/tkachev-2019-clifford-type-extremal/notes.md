# Tkachev 2019, extraction

## The theorem, and the hypothesis that decides it here

> If $V$ is a finite-dimensional **unital** commutative (possibly nonassociative) algebra carrying an associative positive-definite bilinear form, there exists a nonzero idempotent $c$ of shortest length, and $\lvert c\rvert^2=\tfrac12\lvert e\rvert^2$ holds **exactly when** $V$ is a Jordan algebra of Clifford type.

Unitality appears in the abstract and is fixed again at Definition 1.1 ("a unital Euclidean metrised algebra such that equality in (5) holds"), with §2.3 devoted to unital algebras.

## Why it does not transfer to $\mathrm{Weyl}_n$

$\mathrm{Weyl}_n$ under $X\circ Y=\tfrac12\big(Q(X+Y)-Q(X)-Q(Y)\big)$ carries the right bilinear form but **has no unit**: a unit $u$ would give $L_u=\mathrm{Id}$ and hence $\operatorname{tr}(L_u)>0$, while $\operatorname{tr}(L_x)\equiv0$ for every $x$ in this algebra. The characterisation therefore says nothing about the extremal idempotent $e=W/\theta$ at a maximiser, and the Clifford/Hurwitz–Radon cap stays closed.

## What remains usable

The *inequality* half (every extremal idempotent satisfies $\lvert c\rvert^2\le\tfrac12\lvert e\rvert^2$), is likewise stated for unital algebras, so it does not supply a length bound here either. **The live Krasnov–Tkachev thread is the Peirce-spectrum syzygies of their §3–§4, not this paper.** Those are stated for *generic* algebras, and $\mathrm{Weyl}_n$ is non-generic precisely because $\tfrac12\in\sigma(A)$, see [second-order.md](../../findings/second-order.md).

# Notes, Lasserre 2021

Problem (1.1) is $\min\{f(x):x\in S^{n-1}\}$ for a degree-$d$ form $f$. Pages 4 to 9 of the extraction.

> **Proposition 2.1.** Let $f\in\mathbb R[x]$ and for every $x\in S^{n-1}$ let $x^\perp:=\{u\in S^{n-1}:u^{\mathsf T}x=0\}$. If $x^*\in S^{n-1}$ is a local minimizer of (1.1) then there exists $\lambda^*\in\mathbb R$ such that (i) FONC: $\nabla f(x^*)+2\lambda^*x^*=0$; (ii) SONC: $u^{\mathsf T}\nabla^2f(x^*)u+2\lambda^*\ge0$ for all $u\in(x^*)^\perp$. (iii) Conversely, if $x^*$ satisfies (2.3) and SOSC $u^{\mathsf T}\nabla^2f(x^*)u+2\lambda^*>0$ for all $u\in(x^*)^\perp$, then $x^*$ is a local minimizer.

> **Corollary 2.2.** Let $f$ be a degree-$d$ form and $x^*\in S^{n-1}$ be a local minimizer. Then in (2.3), $2\lambda^*=-d\,f(x^*)$. In addition, (2.3) holds if and only if $\lVert\nabla f(x^*)\rVert^2=d^2f(x^*)^2$, and SONC reads $u^{\mathsf T}\nabla^2f(x^*)u\ge d\,f(x^*)$ for all $u\in(x^*)^\perp$.

> **Lemma 2.3.** Let $f$ be a form of degree $d>2$ and $x^*\in S^{n-1}$ satisfy FONC. Define $\tau(x^*):=\min_{u\in(x^*)^\perp}u^{\mathsf T}\nabla^2f(x^*)u$. Then $\lambda_1(\nabla^2f(x^*))=\min[d(d-1)f(x^*),\tau(x^*)]$, and if $\lambda_1(\nabla^2f(x^*))=d(d-1)f(x^*)$ then $\tau(x^*)=\lambda_2(\nabla^2f(x^*))$.

> **Corollary 2.4.** Let $f$ be a degree-$d$ form with $d>2$ and $x^*\in S^{n-1}$ satisfy FONC. Then $x^*$ satisfies SONC if and only if $\lambda_1(\nabla^2f(x^*))\ge d\,f(x^*)$ when $f(x^*)\ge0$, and $\lambda_2(\nabla^2f(x^*))\ge d\,f(x^*)$ when $f(x^*)<0$. Moreover, if $f(x^*)<0$ then $\lambda_1(\nabla^2f(x^*))=d(d-1)f(x^*)$.

> **Corollary 3.1.** Let $f$ be a degree-$d$ form and $\Theta:=\{x\in S^{n-1}:\lVert\nabla f(x)\rVert=d\lvert f(x)\rvert\}$. (i) If $f$ is nonnegative then it has no spurious local minima on $S^{n-1}$ if $f$ is constant on $\Delta^+:=\{x\in\Theta:\lambda_1(\nabla^2f(x))\ge\lVert\nabla f(x)\rVert\}$, in which case all SONC points are global minimizers.

> **Theorem 3.3.** Consider problem (1.1) where $f$ is a degree-$d$ form ($d>2$). Then $f$ has no spurious local minima on $S^{n-1}$ if there is only one index $j^*\ge1$ in (3.3) such that $\tilde W_{j^*}\cap\Omega\ne\emptyset$, where $\Omega:=\{x\in S^{n-1}:f(x)<0,\ \lambda_2(\nabla^2f(x))\ge-\lVert\nabla f(x)\rVert\}\cup\{x\in S^{n-1}:f(x)\ge0,\ \lambda_1(\nabla^2f(x))\ge\lVert\nabla f(x)\rVert\}$. If $f$ has no spurious local minima on $S^{n-1}$ then all SONC points with value $f^*$ belong to a unique set $\tilde W_{j^*}\cap\Omega$.

The $\tilde W_j$ of (3.3) are the components of the gradient variety of $g:=f-\tfrac{d}{d+2}\lVert x\rVert^2f$ on which $g$ is constant. The proof of Theorem 3.3 is one paragraph: each nonempty $\tilde W_j\cap\Omega$ is a set of SONC points sharing one value $f_j^*\ge f^*$, so a single such set forces $f_{j^*}^*=f^*$.

**Read for maximising by negating $f$.** For the programme's cubic, $\nabla^2P(W)=6L_W$, the $W$-eigenvalue is $d(d-1)\theta=6\theta$, and SONC for a maximum is $6\lambda_{\max}(L_W\vert_{W^\perp})\le3\theta$, i.e. $\lambda_{\max}(L_e\vert_{W^\perp})\le\tfrac12$, which is [L24](../../findings/second-order.md).

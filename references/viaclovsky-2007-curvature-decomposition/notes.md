# Notes, Viaclovsky, Math 865 (Fall 2007), §4.2

## What was read

§4.2, pp. 15–16, equations (4.14)–(4.25). Transcribed from the filed PDF.

## The Bianchi symmetrisation map

The curvature tensor as a $(0,4)$-tensor satisfies $\mathrm{Rm}\in S^2(\Lambda^2T^*M)$, equation (4.14). Define $b:S^2\Lambda^2\to S^2\Lambda^2$ by

$$b\,\mathrm{Rm}(x,y,z,t)=\tfrac13\big(\mathrm{Rm}(x,y,z,t)+\mathrm{Rm}(y,z,x,t)+\mathrm{Rm}(z,x,y,t)\big) \qquad (4.15)$$

Then $S^2(\Lambda^2)=\ker(b)\oplus\mathop{\mathrm{Im}}(b)$, equation (4.16), and

$$b(\alpha\odot\beta)=\tfrac16\,\alpha\wedge\beta \qquad (4.17)$$

for $\alpha,\beta\in\Lambda^2$, so $\mathop{\mathrm{Im}}(b)=\Lambda^4T^*M$, equation (4.18). The space of curvature-like tensors is $\mathcal C=\ker(b)$, equation (4.19), giving $S^2(\Lambda^2)=\mathcal C\oplus\Lambda^4$, equation (4.20). The notes remark that $b\equiv0$ for $n=2,3$ and $\dim\mathop{\mathrm{Im}}(b)=1$ for $n=4$.

## What this settles for the record

The first Bianchi identity for a tensor already carrying the Riemann pair and skew symmetries is exactly the vanishing of its $\Lambda^4$ component under $b$. Under (4.17) the brief's map $\mathfrak b(\omega\odot\eta)=\omega\wedge\eta$ is $6b$ on symmetric products, a nonzero universal multiple, so the two have the same kernel and the record's "$\sum_\alpha\lambda_\alpha\,\omega_\alpha\wedge\omega_\alpha=0$ in $\Lambda^4$" is a correct rendering of the identity.

Relative to the Bianchi sum $B_{abcd}=W_{abcd}+W_{acdb}+W_{adbc}$ the constant is $2$: $b=\tfrac13B$ by (4.15) and $\omega\wedge\omega=6\,b(\omega\odot\omega)$ by (4.17), so $\big(\sum_i\lambda_i\,\omega_i\wedge\omega_i\big)_{pqrs}=2B_{pqrs}$. That matches the direct coefficient computation in [REVIEW_r774.md](../../reviews/REVIEW_r774.md) §9.

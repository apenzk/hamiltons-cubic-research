# REVIEW r1128: Gate 2 on L244, criticality per vector and the symmetric-family ceiling

Brief: [2026-09-25-L244-gate2-brief.md](2026-09-25-L244-gate2-brief.md). Log: [agent_logs/r1128.log](../agent_logs/r1128.log).

**Verdict: L244 stands. Every line of (i) and (ii) and every number at $n=12$ re-derives. Two presentational corrections, no mathematical ones.**

| Item | Verdict |
|---|---|
| 1. The operator identity | CONFIRMED |
| 2. The per-vector rows | CONFIRMED |
| 3. The caps | CONFIRMED |
| 4. The symmetric derivation (ii) | CONFIRMED, with a labelling correction |
| 5. The consequences at n=12 | CONFIRMED |
| 6. The check at S5xS7 | CONFIRMED as a screen, with a wording correction |
| Lean statements | CONFIRMED |

## 1. The operator identity: CONFIRMED

- With the trace pairing on self-adjoint operators of $\Lambda^2$ and $\mathop{\mathrm{tr}}W^2=1$, $\tfrac{d}{dt}\mathop{\mathrm{tr}}(W+tH)^3=3\mathop{\mathrm{tr}}(W^2H)$ and, by the full symmetry of $\langle A,B\#C\rangle$ (conventions.md, $T$ third sense), $\tfrac{d}{dt}\langle W+tH,(W+tH)^\#\rangle=3\langle W^\#,H\rangle$. So the gradient on $\mathcal W_n$ is $3\pi_{\mathcal W_n}(W^2+W^\#)$.
- L234 step (1) gives $W^2+W^\#\in\mathcal W_n$, so the projection is the identity on it and the Lagrange condition reads $W^2+W^\#=\mu W$ in $\mathcal W_n$, which is a set of operators on $\Lambda^2$. Pairing with $W$ gives $\mu=P(W)=\theta$.
- $W^2$ is operator composition on $\Lambda^2$ and $W^\#$ the Lie-algebraic operator; neither is separately in $\mathcal W_n$ in general, only the sum, and the identity used is the sum's. Nothing more is needed.
- Screen: at Einstein $S^5\times S^7$ (sectional curvatures $3$, $2$, $0$ minus $12/11$, normalised), $\theta=1.2282392=\sqrt{264/175}$ and $\lVert W^2+W^\#-\theta W\rVert_\infty=8\cdot10^{-17}$.

## 2. The per-vector rows: CONFIRMED

- By bilinearity of $\#$: $\sum_{a,b}P_a\#P_b=I\#I$, $\sum\lambda_bP_a\#P_b=I\#W$, $\sum\lambda_a\lambda_bP_a\#P_b=W\#W=W^\#$. The givens supply $I\#I=(n-2)I$ and $I\#W=-W$.
- Normalisation, independently: with $\psi$ orthonormal for $-\tfrac12\mathop{\mathrm{tr}}XY$ and invariance $\langle[\psi_\gamma,\psi_\delta],x\rangle=\langle\psi_\delta,[x,\psi_\gamma]\rangle$, $\langle(I\#I)x,x\rangle=\tfrac12\sum_\gamma\lVert[x,\psi_\gamma]\rVert^2=\tfrac12\mathop{\mathrm{tr}}(-\mathrm{ad}_x^2)=n-2$. So $B_{ab}=\tfrac12\sum[\psi_\gamma,\psi_\delta]\otimes[\psi_\gamma,\psi_\delta]$ is the record's $\#$, not twice it.
- Every right side is a scalar multiple of $x$ on $E_c$ ($(n-2)x$, $-\lambda_cx$, $(\theta\lambda_c-\lambda_c^2)x$), so the rows hold at EVERY unit $x\in E_c$, not only at basis vectors.
- Screen: at $S^5\times S^7$, $I\#I$ and $I\#W=-W$ to $2\cdot10^{-16}$, every $B_{ab}\succeq0$, and the three rows at random unit $x$ in each eigenspace equal $10$, $-\lambda_c$, $\lambda_c(\theta-\lambda_c)$ to six printed digits.

## 3. The caps: CONFIRMED

- $\sum_{\gamma\in E_a}\lVert[x,\psi_\gamma]\rVert^2=\sum_{\gamma\in E_a}\sum_{\delta}\langle[\psi_\gamma,\psi_\delta],x\rangle^2$ with $\delta$ over an orthonormal basis of all of $\Lambda^2=\bigoplus_bE_b$, which is $2\sum_bb_{ab}(x)$ (the sum over $b$ includes $b=a$).
- The left side is $\mathop{\mathrm{tr}}(P_a(-\mathrm{ad}_x^2)P_a)$, at most $\kappa_{m_a}(x)$ by Ky Fan. For $a=c$, take $x$ as one basis vector of $E_c$: $[x,x]=0$, so the trace runs over $E_c\cap x^\perp$, of dimension $m_c-1$, and Ky Fan gives $\kappa_{m_c-1}(x)$.

## 4. The symmetric derivation (ii): CONFIRMED, with a labelling correction

- Unit $W$ with spectrum $(-a,0,a)$, multiplicities $(p,\cdot,p)$: $2pa^2=1$, so $a=1/\sqrt{2p}$.
- In the ordered sum, an unordered off-diagonal $b_{st}$ carries $\lambda_s+\lambda_t$ in row (B) and $2\lambda_s\lambda_t$ in row (C). Row (B) at $x\in E_{-a}$: $a(-b_{00}+b_{22}-b_{01}+b_{12})=a$, so $b_{12}+b_{22}-b_{00}-b_{01}=1$. Row (C): $a^2(b_{00}+b_{22}-2b_{02})=-a(\theta+a)$, so $2b_{02}-b_{00}-b_{22}=\theta/a+1=K$.
- Substituting $2b_{02}$ and $b_{12}$ into row (A) $b_{00}+b_{11}+b_{22}+2(b_{01}+b_{02}+b_{12})=n-2$ gives $K=n-4-4b_{00}-4b_{01}-b_{11}$ exactly.
- $K\le2b_{02}\le2(b_{00}+b_{01}+b_{02})\le\kappa_{p-1}(x)$ and $K+2=2b_{02}+2b_{12}+b_{22}-3b_{00}-2b_{01}\le2(b_{02}+b_{12}+b_{22})\le\kappa_p(x)$.
- Nonnegativity used: $b_{00},b_{01},b_{11},b_{22}\ge0$ only, matching the Lean docstring. $\theta=a(K-1)$ with $a>0$ gives the display. No sign of $\theta$ is assumed.
- **Correction (labelling).** (ii)'s proof indexes the eigenspaces $0,1,2$ for $-a,0,a$ and writes $x\in E_0$ for the NEGATIVE eigenspace, while the statement says "negative eigenspace" and nothing defines the index. $E_0$ reads naturally as the kernel of $W$, the zero eigenspace, which is index $1$ here. Write "index $0,1,2$ for $-a,0,a$" once, or name the spaces $E_-,E_0,E_+$. The letter $a$ also carries both the eigenvalue $1/\sqrt{2p}$ and the index in $b_{ab}$.

## 5. The consequences at n=12: CONFIRMED

- $\theta_0(12)^2=2\cdot11\cdot10/144=220/144$. $\theta\le7/\sqrt{2p}$ gives $\theta^2\le49/(2p)$: $49/34<220/144$ at $p=17$ and so at every $17\le p\le33$, and $49/32\ge220/144$ at $p=16$. This is an exclusion, since the $x$-free bound holds at every unit $x\in E_{-a}$ and $E_{-a}\ne0$.
- Equal-angle unit $x\in\mathfrak{so}(12)$: angles $\mu$ with $6\mu^2=1$; $-\mathrm{ad}_x^2$ is $0$ on $\mathfrak u(6)$ (dim 36) and $4\mu^2=\tfrac23$ on the 30-dimensional complement (trace $20=2(n-2)$). So $\kappa_{11}=22/3$, $\kappa_{12}=8$, the minimum is $\kappa_{12}-2=6$, and $\theta\le5/\sqrt{24}=1.0206$.
- "Rank four" means two equal angles, $\mu^2=\tfrac12$: $-\mathrm{ad}_x^2$ has $2$ twice and $\tfrac12$ thirty-two times. $\kappa_{11}=8.5$, $\kappa_{12}=9$, the minimum is $\min(8.5,7,8)=7$, and $\theta\le6/\sqrt{24}=1.2247<1.2360=\theta_0(12)$.
- What is claimed of these two is a necessary condition ("the negative eigenspace of such a point contains neither"), and it is worded as one; the working note says so explicitly. Nothing is presented as an exclusion that is only necessary.
- L242's spectrum $(-\tfrac3{20},0,\tfrac3{20})$ is unnormalised ($24\cdot\tfrac9{400}\ne1$), but $\theta^2=50/27$ is its unit value and $1.361\le7/\sqrt{24}=1.4289$ holds. The comparison is scale-free, so it is sound.

## 6. The check at S5xS7: CONFIRMED as a screen, with a wording correction

- Labelled a screen with its script, as it should be. My own independent construction (0.3 s) reproduces it: the six-variable LP ceiling is $1.22824=\theta$ at every sampled $x$ (five random and one basis vector) in both extreme eigenspaces, the negative one (mixed block, $m=35$) and the top one ($\Lambda^2\mathbb R^5$, $m=10$), and $2.354$ in the middle one. Soundness forces ceiling $\ge\theta$ at every $x$, so tightness is plausible and here holds at every vector sampled, not only at the minimum.
- **Correction (wording).** "which (ii) reproduces in closed form" sits next to the $S^5\times S^7$ check, but $S^5\times S^7$ has spectrum multiplicities $(35,21,10)$, far from the symmetric family, so (ii) does not apply to it. The clause means that (ii) is the closed form of the same LP at the symmetric spectrum. Say that, for instance "the programme whose symmetric case (ii) solves in closed form".

## Lean statements: CONFIRMED

- `per_vector_ceiling`: `hA`, `hB`, `hC` are rows (A), (B)/a, (C)/a² at $x\in E_{-a}$ as derived in item 4; `h0` is the $E_{-a}$ cap with `κ₀` standing for $\kappa_{p-1}(x)$, `h2` the $E_{+a}$ cap with `κ₂` for $\kappa_p(x)$; the conclusion is the three bounds on $K$.
- `theta_bound`: $\theta=a(K-1)$, $a>0$, giving $a(n-5)$, $a(\kappa_0-1)$, $a(\kappa_2-3)$, which is the display.
- `p17_excluded` states $p=17$ only; $p\ge17$ follows by monotonicity of $49/(2p)$, a one-line step the prose may leave implicit. `p16_not_excluded` is the right direction.
- The untyped part (the rows and caps as hypotheses) is declared as such in the file's header.

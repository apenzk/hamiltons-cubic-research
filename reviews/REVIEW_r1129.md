# Gate 2 review r1129: L244, criticality per vector and the symmetric-family ceiling

Brief: [2026-09-25-L244-gate2-brief.md](2026-09-25-L244-gate2-brief.md). Log: [agent_logs/r1129.log](../agent_logs/r1129.log). Analysis only, with one screen of about a second on an object built here (S5xS7), reported as a screen.

| Item | Verdict |
|---|---|
| 1. The operator identity | CONFIRMED |
| 2. The per-vector rows | CONFIRMED |
| 3. The caps | CONFIRMED |
| 4. The symmetric derivation (ii) | CONFIRMED |
| 5. The consequences at n=12 | CONFIRMED, with one numeral to correct (138 should read 179) |
| 6. The check at S5xS7 | CONFIRMED as a screen, with one wording correction |
| Lean statements | CONFIRMED |

## 1. The operator identity: CONFIRMED

- $P(W)=\operatorname{tr}W^3+\langle W,W^\#\rangle$ has gradient $3(W^2+W^\#)$ projected to $\mathcal W_n$, because the trilinear form of $\#$ is fully symmetric. The Lagrange condition on the unit sphere is $\pi_{\mathcal W}(Q(W))=\theta W$, and pairing with $W$ gives $\theta=P(W)$.
- $Q(\mathcal W_n)\subseteq\mathcal W_n$ (the given behind L234 step (1)) makes $\pi_{\mathcal W}Q(W)=Q(W)$, so $W^2+W^\#=\theta W$ holds exactly in $\operatorname{End}(\Lambda^2)$.
- $W^2$ and $W^\#$ are both taken as symmetric operators on $\Lambda^2$, the space where $\mathcal W_n$ lives. The identity is an operator identity, and it is what (i) uses when it applies both sides to a vector $x$.

## 2. The per-vector rows: CONFIRMED

- $\sum_{a,b}P_a\#P_b=I\#I$ and $\sum\lambda_bP_a\#P_b=I\#W$ follow by bilinearity. $I\#I=(n-2)I$ is the record's pinned normalisation (conventions, `sharpOp_id`). $I\#W=-W$ is the given Weyl identity: $R\#I=c\,\mathrm{Ric}\wedge\mathrm{id}-R$ with $\mathrm{Ric}=0$, and the constant is fixed by $R=I$.
- $B_{ab}=P_a\#P_b=\tfrac12\sum_{\gamma\in E_a,\delta\in E_b}[\psi_\gamma,\psi_\delta][\psi_\gamma,\psi_\delta]^{\mathsf T}\succeq0$ for every ordered pair, including $a\ne b$, by $vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$. So $b_{ab}(x)\ge0$ and $b_{ab}=b_{ba}$.
- Each right side ($(n-2)I$, $-W$, $\theta W-W^2$) acts on $E_c$ as the scalar $n-2$, $-\lambda_c$ or $\lambda_c(\theta-\lambda_c)$. Pairing with any unit $x\in E_c$ therefore gives the three rows at EVERY unit $x\in E_c$, basis-free.
- The sums run over ordered pairs $(a,b)$. The Lean row `hA` writes this as $b_{00}+b_{11}+b_{22}+2(b_{01}+b_{02}+b_{12})$, which is consistent.
- Consistency check: row (A) also follows from the caps' identity below, since $\tfrac12\operatorname{tr}(-\mathrm{ad}_x^2)=n-2$.

## 3. The caps: CONFIRMED

- Invariance gives $\langle[\psi_\gamma,\psi_\delta],x\rangle=\langle\psi_\delta,[x,\psi_\gamma]\rangle$. The eigenbases of all classes together form an orthonormal basis of $\Lambda^2$, so summing over $\delta$ and $b$ gives $\sum_bb_{ab}(x)=\tfrac12\sum_{\gamma\in E_a}\lVert[x,\psi_\gamma]\rVert^2$.
- $\sum_{\gamma\in E_a}\lVert[x,\psi_\gamma]\rVert^2$ is the trace of $-\mathrm{ad}_x^2$ compressed to $E_a$, which is basis-independent. Ky Fan bounds it by $\kappa_{m_a}(x)$.
- For $a=c$, choose the orthonormal basis of $E_c$ with $\psi_1=x$. Since $[x,x]=0$ the first term vanishes, and the rest is the trace over $E_c\cap x^\perp$ (dimension $m_c-1$), which is at most $\kappa_{m_c-1}(x)$.

## 4. The symmetric derivation (ii): CONFIRMED

- Unit norm: $2pa^2=1$, so $a=1/\sqrt{2p}$. The trace is zero automatically.
- Row (B) at $x\in E_0$ ($\lambda_c=-a$): $a(S_2-S_0)=a$ with $S_b=\sum_ab_{ab}$, which gives $b_{12}+b_{22}-b_{00}-b_{01}=1$. This matches.
- Row (C): $a^2(b_{00}+b_{22})-2a^2b_{02}=-a(\theta+a)$, which gives $2b_{02}-b_{00}-b_{22}=\theta/a+1=K$. This matches.
- Eliminating $b_{12}$ through (B) and then $b_{02}$ through (A) gives $K=(n-4)-4b_{00}-4b_{01}-b_{11}$. This matches.
- $K\le2b_{02}\le2(b_{00}+b_{01}+b_{02})\le\kappa_{p-1}(x)$ uses $b_{00},b_{01},b_{22}\ge0$.
- $K+2=2b_{02}+2b_{12}+b_{22}-3b_{00}-2b_{01}\le2(b_{02}+b_{12}+b_{22})\le\kappa_p(x)$ uses $b_{00},b_{01},b_{22}\ge0$.
- Nonnegativity used overall: $b_{00},b_{01},b_{11},b_{22}\ge0$ only. $b_{02}$ and $b_{12}$ are free, exactly as the Lean docstring states. $\theta=a(K-1)$ with $a>0$ gives the ceiling.

## 5. The consequences at n=12: CONFIRMED, one numeral to correct

- $\theta\le7/\sqrt{2p}<\sqrt{220}/12$ holds iff $2p>49\cdot144/220\approx32.07$, that is iff $p\ge17$. At $p=16$ we have $49/32=1.53125\ge1.5278$, so $p=16$ is not excluded. The symmetric family also needs $N-2p\ge1$ ($p\le32$). For $17\le p\le32$ this is a genuine exclusion, because every $x\in E_0$ gives the bound and $E_0\ne0$.
- Equal angles at $n=12$ means $x=tJ$ with $6t^2=1$. Then $-\mathrm{ad}_x^2$ has eigenvalue $4t^2=\tfrac23$ on the 30-dimensional complement of $\mathfrak u(6)$ and $0$ on $\mathfrak u(6)$ (trace $20=2(n-2)$). So $\kappa_{11}=\tfrac{22}3$ and $\kappa_{12}=8$, the minimum is $\min(\tfrac{22}3,6,8)=6$, and $\theta\le5/\sqrt{24}\approx1.0206$. All three values are correct.
- "Rank four" must mean matrix rank four (two equal angles, $t^2=\tfrac12$). The eigenvalues are $2$ (multiplicity 2), $\tfrac12$ (multiplicity 32) and $0$. So $\kappa_{11}=8.5$ and $\kappa_{12}=9$, the minimum is $7$, and $\theta\le6/\sqrt{24}\approx1.2247$, which is correct. The same computation at rank ten gives $1.3472$, which matches the working note. *Suggest writing "rank-four (two equal angles)" to rule out the four-angle reading.*
- The equal-angle statements are correctly phrased as a necessary condition ("the negative eigenspace contains neither"), not as an exclusion. The only claimed exclusion is $p\ge17$, and it is genuine.
- **Correction**: "the 138 asymmetric survivors" appears nowhere else in the record. [plan.md](../plan.md) gives 190 survivors at $\theta_0(12)$, of which 11 are symmetric, so 179 are asymmetric (also the figure in commit d1d1023a). Replace 138 by 179, or cite the screen that produces 138.
- The L242 remark: $7/\sqrt{24}=1.4289$ is the $p=12$ value, and L242 has $p=12$, so this is consistent. L242 is recorded as unrealisable, so this is a consistency remark only, which is how it is worded.

## 6. The check at S5xS7: CONFIRMED as a screen, one wording correction

- **Screen (about 1.4 s, built here, reported as a screen)**: $S^5\times S^7$'s Weyl operator, diagonal in the $e_{ij}$ basis. It has multiplicities $(35,21,10)$, $\theta=1.2282391577$ against $\sqrt{264/175}$, and $Q(W)=\theta W$ to $6\cdot10^{-17}$. $I\#I=(n-2)I$ and $I\#W=-W$ hold to $10^{-16}$. The three rows hold at random unit $x$ in each class with the stated constants. The six-variable LP ceiling equals $\theta$ to $10^{-12}$ in the negative class and the top class, at random and at simple $x$. In the middle class the ceiling is $2.354$. The claim that the ceiling is tight in both extreme classes is confirmed.
- It is labelled as a screen. **Wording correction**: "which (ii) reproduces in closed form" cannot refer to $S^5\times S^7$, whose spectrum is not of the form $(-a,0,a)$ with multiplicities $(p,\cdot,p)$. What (ii) reproduces in closed form is the screen's symmetric-family values at $p=12$ ($5/\sqrt{24}$, $6/\sqrt{24}$). Rephrase to say so.

## Lean statements: CONFIRMED

- `per_vector_ceiling`: its hypotheses are exactly rows (A), (B)/a and (C)/a², the two caps with $\kappa_0:=\kappa_{p-1}(x)$ and $\kappa_2:=\kappa_p(x)$, and nonnegativity of $b_{00},b_{01},b_{11},b_{22}$. Its conclusion is the three bounds on $K$. This is what the prose needs.
- `theta_bound`: $\theta=a(K-1)$ with $a>0$, giving the three bounds whose minimum is the stated ceiling.
- `p17_excluded` and `p16_not_excluded`: exactly the two rational comparisons. Only the comparison at $p=17$ is typed, but for $p>17$ the bound $49/(2p)$ is smaller still, so the gap is trivial. Monotonicity in $p$ is left to the prose.
- The per-vector rows and the caps enter as hypotheses, as the Lean section declares.

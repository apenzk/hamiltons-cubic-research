# Gate 2 brief: the rank reduction of the pair operator, and r >= p (r1146, r1147)

**Two reviewers, independently: the round checks an argument.** Analysis-only: argue from the definitions; seconds of computation on objects you construct are allowed only as a screen, never as evidence for a positive claim. Model: opus.

## The claims, verbatim from [the working file](2026-09-25-I73c-per-vector-rows.md) as committed at e1f74374

Claim 1 (the reduction):

> **The rank lead, reduced: the bracket part binds only if $\dim[E_0,E_2]<4T\le p$.** Write $C:E_0\otimes E_2\to\Lambda^2$, $u\otimes v\mapsto[u,v]$, so $\mathcal B=CC^{\mathsf T}$ and the leading term of the pair matrix is $B\approx-\tfrac14C^{\mathsf T}eC$. The nonzero eigenvalues of $C^{\mathsf T}eC$ are those of $e\,CC^{\mathsf T}=e\mathcal B$, so **$\operatorname{rank}B\le r:=\operatorname{rank}\mathcal B=\dim[E_0,E_2]$**, and a symmetric matrix of rank $r$ and trace $T>0$ has top eigenvalue at least $T/r$. With $G\approx\tfrac12I$ this gives $\lambda_{\max}(L_e)\gtrsim2T/r$ directly, **which supersedes Wolkowicz–Styan** (whose gain over the mean is only a factor $1+O(r^{-1/2})$ where this one is $D/r$). Here $T=\operatorname{tr}B=\sum_u\tfrac a{2\theta}\big(b_{20}(u)-b_{22}(u)\big)$ over a basis of $E_0$, the half-summed bracket term above. **So the bracket part alone exceeds the bound $\tfrac12$ exactly when $r<4T$, and the scale check's per-vector ceiling of about $\tfrac14$ gives $4T\le p$: the lead needs $\dim[E_0,E_2]<p$**, far below the generic value $\min(p^2,N)$ of a bracket map on two $p$-dimensional subspaces. *What the rows give toward it: $P_0[u,E_2]\subseteq E_0$, and $\operatorname{rank}(P_0\operatorname{ad}_u|_{E_2})\ge2b_{20}(u)/\lVert\operatorname{ad}_u\rVert_{\mathrm{op}}^2$, which with $b_{20}\ge\tfrac12(\theta\sqrt{2p}+1)$ is of order $\sqrt p$, so the rows alone leave $\sqrt p\lesssim r<p$ open.* **Owed**: whether $r<p$ is compatible with the rows and criticality (it asks $E_2$ to nearly centralise $E_0$), and the corrections, since the Ricci and $\Lambda^4$ terms of $L_e$ have full rank and enter through $\lambda_{\max}(A+B)\ge\lambda_{\max}(A)+\lambda_{\min}(B)$ with a sign the leading term does not control. Linear algebra on the leading term; normalisations as in the half-summed note, unchecked; no computation.

Claim 2 (r >= p and the threshold):

> **The rows force $\dim[E_0,E_2]\ge p$, and the rank lead becomes a sharp threshold.** By ad-invariance, $\langle[u,v],w\rangle=-\langle u,[w,v]\rangle$, so a $w\in E_0$ orthogonal to $P_0[E_0,E_2]$ has $P_0[w,v]=0$ for every $v\in E_2$, i.e. $b_{20}(w)=0$. **L244's rows give $b_{20}(w)\ge\tfrac12(\theta\sqrt{2p}+1)>0$ at every unit $w\in E_0$, so $P_0[E_0,E_2]=E_0$ and $r=\dim[E_0,E_2]\ge\operatorname{rank}(P_0C)=p$.** The $r<p$ branch of the reduction above is empty. With $a=1/\sqrt{2p}$, the condition $2T/r>\tfrac12$ reads

## Givens (quoted from the same file; treat as established)

> **The half-summed inequality, assembled on the symmetric family.** Take unit $u\in E_0$, sum the projected-pair test $\langle X,e\circ X\rangle\le\tfrac12\lVert X\rVert^2$ (valid since $\langle X,W\rangle=\langle u,Wv\rangle=0$) over an orthonormal basis $\{v\}$ of $E_2$, using [the projected-pair note](2026-09-23-I73c-projected-pair.md)'s boxed formula. With $\varepsilon=\lambda/\theta$ and $\lambda=(-a,0,a)$, the first term is $-\tfrac14\langle[u,v],e[u,v]\rangle$ (the $\varepsilon$ average vanishes for $u\in E_0$, $v\in E_2$), and $\sum_v\lvert P_c[u,v]\rvert^2=2b_{2c}(u)$, so

> **The degree-eight invariant is an operator trace, and it reopens the spread (a lead).** The leading term of $\sum_{\alpha\beta}B_{\alpha\beta}^2$ is $\tfrac1{16}\sum\langle[u,v],e[u',v']\rangle^2$ over $u,u'\in E_0$, $v,v'\in E_2$, and with $\mathcal B=\sum_{u,v}[u,v][u,v]^{\mathsf T}=2B_{02}$, where $B_{02}=P_0\#P_2$ is **the per-vector rows' own operator**, that sum is exactly $\operatorname{tr}\big((\mathcal Be)^2\big)$. Cauchy–Schwarz on $\mathcal B^{1/2}e\,\mathcal B^{1/2}$ gives $\operatorname{tr}\big((\mathcal Be)^2\big)\ge(\operatorname{tr}\mathcal Be)^2/\operatorname{rank}\mathcal B$. **The denominator is $\operatorname{rank}B_{02}$, not $D\approx p^2$**, so where $B_{02}$ has small rank this lower-bounds the spread past the mean, which is what Wolkowicz–Styan needed and the diagonal could not supply. *Owed: whether $\operatorname{rank}B_{02}$ is forced small on the bulk (its range lies in $[E_0,E_2]$), and whether the Ricci and $\Lambda^4$ corrections to $B_{\alpha\beta}$ leave the leading term dominant. A reformulation, not yet a bound.*

> **A lead past the mean: Wolkowicz–Styan on the pair operator.** Maximality bounds $\lambda_{\max}(L_e)\le\tfrac12$ on $V=\pi_{\mathcal W}(E_0\odot E_2)\cap W^\perp$, and excluding a spectrum needs that spectrum to FORCE $\lambda_{\max}>\tfrac12$. [F76](../findings/fence-posts.md) closed the first-moment route (the trace, i.e. the mean). **Wolkowicz–Styan** ($\bar m+s/\sqrt{D-1}\le\lambda_{\max}$, with $D=\dim V$, $\bar m=\operatorname{tr}/D$, $s^2=\operatorname{tr}(L_e^2)/D-\bar m^2$; stated and CONFIRMED on the record by [r379](REVIEW_r379.md) item (d), there applied to a different operator) **adds the second moment**, so a spectrum whose pair operator has a large spread is excluded even when its mean is under $\tfrac12$. *What it needs is $\operatorname{tr}(L_e^2)$ on $V$ as a function of the class data, a fourth-order class invariant, together with $D\le p^2$; whether that invariant is expressible in the class system's variables, or needs new ones, is the next question.* A lead, not a result.

- **L244's rows**: at every unit $u\in E_0$, $b_{20}(u)\ge\tfrac12(\theta\sqrt{2p}+1)$, where $b_{2c}(u)=\tfrac12\sum_{v}\lvert P_c[u,v]\rvert^2$ over an orthonormal basis $\{v\}$ of $E_2$. Symmetric family: spectrum $(-a,0,a)$ on $E_0,E_1,E_2$, $\dim E_0=\dim E_2=p$, $a=1/\sqrt{2p}$, $e=\lambda/\theta$.
- The inner product on $\Lambda^2=\mathfrak{so}(n)$ is $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$ and the bracket is the commutator.

## Lean

| claim | declaration |
|---|---|
| Top eigenvalue of a symmetric matrix of rank $r$ and trace $T>0$ is at least $T/r$ | none: the claim lives on the class data $E_0,E_2,e$, which the layer has no objects for (no declaration of the per-vector masses $b_{2c}$ exists); the linear-algebra step alone is standard |
| $\operatorname{rank}(C^{\mathsf T}eC)\le\operatorname{rank}(CC^{\mathsf T})$ | none, same reason |
| $r\ge p$ from ad-invariance and the rows | none, same reason |

## Items

1. Does each step of claim 1 follow from the one above and from the givens? In particular: is $\operatorname{rank}B\le r$ right when $e$ is indefinite; is $T=\operatorname{tr}B$ with the sign stated; does $\lambda_{\max}(L_e)\gtrsim2T/r$ follow from $G\approx\tfrac12I$ (and what does "$\approx$" hide).
2. Claim 2: is the ad-invariance identity stated correctly for this inner product, does $w\perp P_0[E_0,E_2]$ really force $b_{20}(w)=0$, and does $r\ge\operatorname{rank}(P_0C)=p$ follow?
3. Is the displayed threshold the correct rewriting of $2T/r>\tfrac12$ with $a=1/\sqrt{2p}$?
4. Is any conclusion stated beyond what the leading-term approximation supports (the corrections are declared owed)?

## Protocol

Reviewer N (1146 or 1147, as your dispatch names) logs to `agent_logs/rN.log` (first line PID and phase plan, a line per phase, heartbeat every ~3 minutes). The LAST line must START with the word DONE or FAILED. Commit a skeleton `reviews/REVIEW_rN.md` first and update it, committing only that file by path (`git commit -- reviews/REVIEW_rN.md`). Do NOT edit `reviews/INDEX.md` or any other file, and do not read the other reviewer's report or log. Verdict per item: CONFIRMED, PLAUSIBLE or REFUTED with corrections.

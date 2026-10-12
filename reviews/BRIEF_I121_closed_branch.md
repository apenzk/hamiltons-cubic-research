# Gate 2 brief, the closed branch at a product diagonal, for I121 (route R52)

**Cold brief. The claims are quoted verbatim from [reviews/2026-09-28-I121-MG-audit.md](2026-09-28-I121-MG-audit.md) as it stands at dispatch. You are asked to break them.** Verdicts per claim: CONFIRMED, PLAUSIBLE or REFUTED with corrections. **Analysis-only footing**: argue from the definitions; compute only to refute, the smallest computation that does it, saying why an argument could not (numpy is available under `sage -python`).

## Givens, each stated in full

- **[L284](../findings/second-order.md)** (Gate 2 passed, proved in Lean): at a unit critical point $W=A+B$, $Q(W)=\rho W$, split by the sign characters of an orthonormal frame, $\rho^2t^2b^2\lVert C\rVert^2=\lVert q_\perp\rVert^2+\sum_U\lVert Y_U\rVert^2+\sum_Up_U(\lambda_U-\bar\lambda)^2$, with $q_\perp=Q(A)-\tfrac{P(A)}{t^2}A$, $Q(A,B_U)=\lambda_UB_U+Y_U$, $Y_U\perp B_U$. So $C=0$ means $Q(e)=de$ for $e=A/t$, and $f=B/b$ is one eigenvector of $L_e=Q(e,\cdot)$, eigenvalue $\tau$.
- **$L_e$ preserves each sign character** when $e$ is diagonal ([L120](../findings/second-order.md)).
- **The one-plane bound** (Gate 2 passed, [r1797](REVIEW_r1797.md), [r1798](REVIEW_r1798.md)): in a frame globally maximising the diagonal mass, for every pair $i\ne j$, $\langle\delta,x\rangle=0$ and $\lVert x\rVert\le\lVert\delta\rVert$, where $x_m=W(e_i\wedge e_m,e_j\wedge e_m)$ and $\delta_m=\tfrac12(a_{im}-a_{jm})$, $m\notin\{i,j\}$.
- **The double-rotation inequality** (same audit): with every pair profile zero, a pairing $(12\,|\,34)$ of four indices gives $(v+w)^2\le\tfrac14\square^2+(\delta^{34}_1+\delta^{34}_2)^2+(\delta^{12}_3+\delta^{12}_4)^2+2\sum_{m\ge5}[(\delta^{12}_m)^2+(\delta^{34}_m)^2]$, $v=W_{13,24}$, $w=W_{14,23}$, $\square=a_{13}-a_{14}-a_{23}+a_{24}$; the other pairings bound $u-w$ and $-(u+v)$, $u=W_{12,34}$.
- **The outside author's Proposition 25.1**, *unaudited on the record and to be checked by you where the claims use it*: at the unit product tensor $e$ of $S^p\times S^q$, $Q(e)=de$, $L_e$ has on the pair characters $W_{2,PP}$ the values $0,-c_*,\tau_P$ with multiplicities $p-3,q-1,1$; on $W_{2,PQ}$ the values $0,d/2$ (the orbit line); on a four-set with $r\ne2$ indices in $P$ zero; on a $2+2$ four-set $\pm c_*$; $c_*=d\tfrac{n-2}{2(p-1)(q-1)}$, $\tau_P=d\tfrac{p-2}{2(p-1)}$. The action on a four-set's Bianchi coordinates $(u,v,w)$, $u-v+w=0$, is $2u'=A_0u+B_0w-C_0v$, $2v'=B_0v-C_0u-A_0w$ with $A_0=a_{ij}+a_{kl}$, $B_0=a_{ik}+a_{jl}$, $C_0=a_{il}+a_{jk}$ (before normalising by $\sqrt K$).
- **The author's binary endpoint criterion**, *unaudited*: for $d>0$, $\tau>0$, $q\ge0$, $d\ge2\tau$, $\max_{t,u\ge0,t^2+u^2=1}(dt^3+3\tau tu^2+qu^3)=d$ iff $dq^2\le(d+\tau)^2(d-2\tau)$.

## The claims

## Second attempt: the closed branch at a product-of-spheres diagonal, in a globally maximal frame

**Derived here, unreviewed.** Assume $C=0$, $\tau>0$, the frame globally maximal, and $e=A/t$ the Weyl tensor of a product $S^p\times S^q$ in its own frame (block-constant diagonal, factors $P$ and $Q'$). By [L284](../findings/second-order.md), $f=B/b$ is one eigenvector of $L_e$ with eigenvalue $\tau$, and $L_e$ preserves each character, so every character component of $f$ is a $\tau$-eigenvector. The author's Proposition 25.1 gives $L_e$ on each character. Character by character:

| component of $f$ | spectrum of $L_e$ there | what survives |
|---|---|---|
| pair block $\chi_{ij}$, $i,j$ in one factor | $0,-c_*,\tau_P$ | **zero**: $\delta^{ij}=0$, so the one-plane bound forces the profile to vanish |
| pair block, $i\in P$, $j\in Q'$ | $0$, and $d/2$ on the orbit line | **zero**: $\tau\ne0$, and the orbit line is removed by the first-order condition $\langle\delta,x\rangle=0$ |
| four-set inside one factor | $0$ | **zero**, twice over: $\tau\ne0$, and every $\delta$ and $\square$ vanish, so all three pairings force their combinations to zero |
| four-set split $3+1$ | $0$ | **zero**: $\tau\ne0$ |
| four-set split $2+2$, $\{i,j\}\subset P$, $\{k,l\}\subset Q'$ | $\pm c_*$, eigenvectors $(u,v,w)\propto(2,1,-1)$ for $+c_*$ and $(0,1,1)$ for $-c_*$ | **the $+c_*$ mode only**: the pairing $(ij\,|\,kl)$ has $\square=0$ and every $\delta=0$, so the double rotation forces $v+w=0$, which the $-c_*$ mode violates |

Here $u=W_{ij,kl}$, $v=W_{ik,jl}$, $w=W_{il,jk}$; from the author's action (5) with $A_0=a+c$, $B_0=C_0=2b$ and $a+c-2b=1$, $2u'=u$ and $2v'=-w$. **So in this case $\tau=c_*$ and $f$ is a combination of the $+c_*$ modes of the $2+2$ four-sets.**

- **I104's configuration survives.** Three four-sets $Q_1,Q_2,Q_3=Q_1\triangle Q_2$ sharing pairs are all $2+2$ exactly when each shared pair is split across the factors (for $Q_1=\{1,2,3,4\}$, $Q_2=\{1,2,5,6\}$: $1,3,5\in P$ and $2,4,6\in Q'$, up to relabelling), and then each block is restricted to its $+c_*$ mode. *The author's open core, active weight-four rectangles, is exactly this.*
- **What frame maximality still owes here.** The cross pairings $(ik\,|\,jl)$ have $\square\ne0$ and $\delta\ne0$, so they bound $\lVert\nu_Q\rVert$ against $t$ rather than killing it, which bounds $r=b/t$. **The next computation**: those bounds for the $+c_*$ mode, fed into the author's closed-branch scalar analysis with $\tau=c_*$, to see whether $\rho\le\max\{\sqrt{3/2},d\}$ follows at product diagonals.
- **Hypothesis to discharge**: that $e$ is a product of two spheres. In the closed branch $e$ is a diagonal Weyl operator with $Q(e)=de$; which of these the record classifies is to be checked before the case is called general.

## The cross pairings bound each surviving $+c_*$ mode against $t$

**Derived here, unreviewed.** The Weyl tensor $E=\pi_{\mathcal W}(I_P)$ of $S^p\times S^q$ has sectional values $\alpha=\tfrac{q(q-1)}N$ inside $P$, $\beta=-\tfrac{(p-1)(q-1)}N$ across, $\gamma=\tfrac{p(p-1)}N$ inside $Q'$, $N=(n-1)(n-2)$, so $\alpha+\gamma-2\beta=1$, $\alpha-\beta=\tfrac{q-1}{n-2}$, $\beta-\gamma=-\tfrac{p-1}{n-2}$, $\alpha-\gamma=\tfrac{q-p}{n-2}$, and $e=E/\sqrt K$, $K=\tfrac{p(p-1)q(q-1)}{2N}$. For a $2+2$ four-set $\{i,j\}\subset P$, $\{k,l\}\subset Q'$, the cross pairing $(ik\,|\,jl)$ moves $u-w$, and the double-rotation inequality with every pair profile zero reads, for $A=te$,
$$(u-w)^2\le\frac{t^2}K\Big[\tfrac14+\tfrac12(\alpha-\gamma)^2+(p-2)(\alpha-\beta)^2+(q-2)(\beta-\gamma)^2\Big],$$
the terms being $\tfrac14\square^2$ with $\square=\alpha+\gamma-2\beta$, the two in-block sums $\tfrac12(\alpha-\gamma)$, and the outside indices, $p-2$ of them in $P$ and $q-2$ in $Q'$. The pairing $(il\,|\,jk)$ gives the same bound on $u+v$. The $+c_*$ mode $\sigma(2,1,-1)$ has $u-w=3\sigma$ and $\lVert\nu_Q\rVert^2=12\sigma^2$, so $(u-w)^2=\tfrac34\lVert\nu_Q\rVert^2$. **At the balanced product $p=q=m$** the bracket is $\tfrac{2m-3}4$ and $K=\tfrac{m^2(m-1)}{4(2m-1)}$, so
$$\frac{\lVert\nu_Q\rVert^2}{t^2}\le\frac43\cdot\frac{(2m-3)(2m-1)}{m^2(m-1)},\qquad 0.733\ \text{at}\ n=12,\quad\sim\frac{16}{3m}.$$
**What it gives and what it does not.** Each four-set's share of $W$ is at most a constant times $t$, decaying like $m^{-1/2}$; with many active four-sets the total $r=b/t$ is not bounded by this alone. At the balanced product $\tau=c_*=\tfrac d{m-1}\le\tfrac d2$, so the author's binary endpoint criterion (the closed branch's maximum is $d$ iff $dq^2\le(d+\tau)^2(d-2\tau)$) reduces the balanced closed branch to a bound $q^2\le d^2\,\tfrac{m^2(m-3)}{(m-1)^3}$ on $q=P(f)$, $f$ a unit combination of $+c_*$ modes whose diagonal squares sum to $\tau e$. **That bound on $P(f)$ is the next computation**, and the frame bound above enters it only if the combination is forced to be spread over few four-sets.

## The Lean table

| claim | declaration | what it covers |
|---|---|---|
| the character-by-character table | none: it combines L284, L120, the one-plane and double-rotation bounds and Proposition 25.1; check each row | |
| the $\pm c_*$ eigenvectors of a $2+2$ four-set | none: a $2\times2$ computation from the author's action; check it | |
| I104's triple surviving | none: a combinatorial assignment; check it | |
| the cross-pairing bound and its balanced constant | none yet: the arithmetic is the double-rotation formula (`block_exchange`, `pair_exchange` in [DoubleRotation.lean](../lean/HamiltonsCubic/Results/DoubleRotation.lean)) evaluated at the product's sectional values; check the evaluation | |
| the reduction to $q^2\le d^2\tfrac{m^2(m-3)}{(m-1)^3}$ | none: the endpoint criterion at $\tau=c_*=\tfrac d{m-1}$; check it | |

## What to attack

1. Each row of the table: does the stated reason kill (or keep) that component, from the givens alone? In particular, is the orbit line in $W_{2,PQ}$ exactly what $\langle\delta,x\rangle=0$ removes?
2. The $2+2$ eigenvectors: are $(2,1,-1)$ for $+c_*$ and $(0,1,1)$ for $-c_*$ right, with $u=W_{ij,kl}$, $v=W_{ik,jl}$, $w=W_{il,jk}$ and $\{i,j\}\subset P$, and does the pairing $(ij\,|\,kl)$ force $v+w=0$ with $\square$ and every $\delta$ zero?
3. Proposition 25.1 where it is used: the $W_{2,PQ}$ spectrum, the vanishing on $r\ne2$ four-sets, and the $2+2$ values. Rebuild them from the definitions.
4. The cross-pairing bound: every term, including which outside indices contribute and with what coefficient, and the sectional values $\alpha,\beta,\gamma$ of $\pi_{\mathcal W}(I_P)$.
5. The balanced constant $\tfrac43\tfrac{(2m-3)(2m-1)}{m^2(m-1)}$ and its value $0.733$ at $n=12$.
6. The reduction via the endpoint criterion, including $c_*=\tfrac d{m-1}$ at $p=q=m$ and $d\ge2\tau$.
7. **Hypotheses**: every place the argument assumes the frame globally maximal, $\tau>0$, $C=0$, or $e$ a product of two spheres. Is any used without being stated?

## Protocol

- Your log file is already created empty (see the dispatch); first line your PID and phase plan, a heartbeat at least every three minutes with live state, closing with a line opening `DONE` or `FAILED`.
- Commit a skeleton to your `reviews/REVIEW_rN.md` (already created empty as your claim) in your first phase, every verdict `NOT REACHED`, then overwrite rows. **Do not edit [reviews/INDEX.md](INDEX.md).** Commit only your own files, named after `--`.

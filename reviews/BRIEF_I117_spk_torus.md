# Gate 2 brief (two readers): sp(k)'s torus system, its s/d decoupling, and uniqueness of I/c on the equal-weight sector

**This round checks an argument, so it has two readers working independently.** Nothing here is typed yet (a Lean proof of the matrix steps is in progress in parallel). Verdict per item: CONFIRMED, PLAUSIBLE or REFUTED with corrections. **Analysis-only footing**: derive from definitions. Computation is allowed to check a value or refute a step, the smallest that does it: seconds, or a bounded construction of $\mathfrak{sp}(k)$ at $k\le4$ stated in advance in your log. No sweeps, no searches over solutions.

## The block under review, verbatim from [the note](2026-09-28l-I117-g2-torus.md)

## $\mathfrak{sp}(k)$'s torus system (read off the construction at $k=3$, unreviewed)

In $\mathfrak{so}(4k)$'s metric the long roots $2\varepsilon_i$ have $\lvert\alpha\rvert^2=2$ and the short $\varepsilon_i\pm\varepsilon_j$ have $1$. The table has the $\mathfrak g_2$ shape, $A^\#A=0$, $A^\#P_\alpha=\tfrac12(\alpha^{\mathsf T}A\alpha)P_\alpha$, $P_\alpha^\#P_\alpha=\alpha\alpha^{\mathsf T}$, with mixed coefficients $\tfrac14$ for short plus short onto short and $\tfrac12$ otherwise ([screen_I117_sp3_torus.py](../scripts/misc/screen_I117_sp3_torus.py)'s construction). With long weights $u_i$, short weights $p_{ij}$ on $\varepsilon_i-\varepsilon_j$ and $q_{ij}$ on $\varepsilon_i+\varepsilon_j$, and in Cartan coordinates $\varepsilon_i=f_i/\sqrt2$, $$a_i=A_{ii}=2u_i^2+\tfrac12\sum_j(p_{ij}^2+q_{ij}^2),\qquad A_{ij}=\tfrac12(q_{ij}^2-p_{ij}^2),$$ and $C^\#C=C$ reads $$u_i(1-2a_i)=\sum_jp_{ij}q_{ij},\quad p_{ij}\big(1-X^-_{ij}\big)=(u_i+u_j)q_{ij}+\tfrac12\sum_l(p_{il}p_{jl}+q_{il}q_{jl}),\quad q_{ij}\big(1-X^+_{ij}\big)=(u_i+u_j)p_{ij}+\tfrac12\sum_l(p_{il}q_{jl}+q_{il}p_{jl}),$$ with $X^\pm_{ij}=\tfrac12(a_i+a_j)\pm\tfrac12(q_{ij}^2-p_{ij}^2)$. **Without the $u$'s this is $\mathfrak{so}(2k)$'s torus system** ([L271](../findings/second-order.md), two coupled copies exchanged by $P$ and $Q$). *The conjecture is that its only positive solution is uniform ($I/c$), and a proof would add the long-root rows to L271's machinery.*

- **The system decouples in $s=p+q$ and $d=p-q$** (derived, the identities checked at a random point): with $m_{ij}=\tfrac12(a_i+a_j)$ and $a_i=2u_i^2+\tfrac14\sum_j(s_{ij}^2+d_{ij}^2)$, $$s_{ij}\big(1-m_{ij}-\tfrac12d_{ij}^2\big)=(u_i+u_j)s_{ij}+\tfrac12\sum_ls_{il}s_{jl},\qquad d_{ij}\big(1-m_{ij}-\tfrac12s_{ij}^2\big)=-(u_i+u_j)d_{ij}+\tfrac12\sum_ld_{il}d_{jl},$$ and $u_i(1-2a_i)=\tfrac14\sum_j(s_{ij}^2-d_{ij}^2)$; positive definiteness is $s>\lvert d\rvert$ and $u>0$. **$d=0$ is an invariant sector holding the uniform point** ($u=\tfrac1c$, $s=\tfrac2c$, $c=k+1$). *So the uniqueness conjecture splits: the $d$-sector vanishes at every positive solution, and on $d=0$ an $\mathfrak{so}(k)$-like system with vertex weights $u_i$ has only the uniform solution.*
- **The $d$-sector's trace identity.** Weighting the $d$-rows by $d_{ij}$ and summing, $\sum_{ij}B_{ij}d_{ij}^2=\tfrac12\mathop{\mathrm{tr}}D^3$ with $B_{ij}=1-m_{ij}-\tfrac12s_{ij}^2+u_i+u_j$. So a nonzero $D$ with every $B_{ij}\ge\beta>0$ has $\lambda_{\max}(D)\ge2\beta$, while $\lambda_{\max}(D)\le\max_i\sum_j\lvert d_{ij}\rvert<\max_i\sum_js_{ij}$. **Hence $D=0$ wherever $2\min B\ge\max_i\sum_js_{ij}$.** At the uniform point $B=1+\tfrac1c-\tfrac2{c^2}>1$ and the row sums are $\tfrac{2(k-1)}{k+1}<2$, so the $d$-sector vanishes near $I/c$. *Globally the crude bounds ($a_i\le\tfrac12$ from the long rows) give neither side, so this is the open step of the $d$-half.*

## On the sector $p=q$, $I/c$ is the only positive-definite idempotent of $\mathfrak{sp}(k)$'s torus family (derived, Gate 2 owed)

**Statement.** *Every positive solution of $\mathfrak{sp}(k)$'s torus system with $p_{ij}=q_{ij}$ for all $i\ne j$ is the uniform one, $u_i=\tfrac1{k+1}$ and $p_{ij}=q_{ij}=\tfrac1{k+1}$, which is $I/c$.*

**Proof.** *Put $s=p+q=2p$ and $U=\mathop{\mathrm{diag}}(u)$, and let $S$ be the symmetric matrix of the $s_{ij}$ with zero diagonal.*
1. **The long rows give $a_i=u_i$.** With $d=0$, $u_i(1-2a_i)=\tfrac14r_i$ and $a_i=2u_i^2+\tfrac14r_i$, $r_i=\sum_js_{ij}^2$, give $r_i=4u_i(1-2u_i)$ and so $a_i=u_i$. *The long rows' own positivity also gives $a_i\le\tfrac12$, so $u_i\le\tfrac12$.*
2. **The $s$-rows are one matrix equation.** With $m_{ij}=\tfrac12(u_i+u_j)$ they read $(S^2)_{ij}=s_{ij}\big(2-3(u_i+u_j)\big)$ off the diagonal, and step 1 is $(S^2)_{ii}=4u_i(1-2u_i)$, so $$S^2=2S-3(US+SU)+4U-8U^2 .$$
3. **Completing the square**, $T=S+3U-I$ satisfies $T^2=(I-U)^2$, a diagonal matrix (checked symbolically).
4. **All $u_i$ are equal.** $T$ commutes with $T^2$, so $T_{ij}\big((1-u_i)^2-(1-u_j)^2\big)=0$, and $T_{ij}=s_{ij}>0$ off the diagonal with $u\le\tfrac12$ gives $u_i=u_j$.
5. **So $T=(1-u)(2\Pi-I)$ for a projection $\Pi$** with constant diagonal (since $T_{ii}=3u-1$) and positive off-diagonal entries ($\Pi_{ij}=s_{ij}/(2(1-u))$).
6. **Such a projection has rank one.** For a unit $x$ in its range, $\langle\lvert x\rvert,\Pi\lvert x\rvert\rangle\ge\langle x,\Pi x\rangle=1$, so $\lvert x\rvert$ is in the range and, the off-diagonal entries being positive, $x$ has constant sign; then $\Pi x=x$ with positive off-diagonal entries leaves no zero coordinate. A range of dimension two would contain a nonzero vector with a zero coordinate. *(Perron–Frobenius for projections, elementary.)*
7. **So $\Pi=J/k$**, the constant diagonal fixing the positive unit vector as $\mathbf 1/\sqrt k$, and $3u-1=(1-u)(\tfrac2k-1)$ gives $u=\tfrac1{k+1}$ and $s=\tfrac{2}{k+1}$. $\square$

**What it gives.** *On the equal-weight sector the uniqueness conjecture is proved at every $k$. What remains is that every positive solution lies in that sector, which is the $d$-half above, proved near $I/c$ by the trace identity.* **Lean**: none yet; steps 2 to 4 are matrix identities and step 6 an elementary lemma, all within Mathlib's reach, since Mathlib carries no Perron–Frobenius theorem but step 6 needs none.

## Givens, quoted from the record

- **Hamilton's sharp** in the record's normalisation: $(A^\#B)_{\alpha\beta}=\tfrac12\sum c_{\alpha\gamma\delta}c_{\beta\varepsilon\zeta}A_{\gamma\varepsilon}B_{\delta\zeta}$, $c$ the structure constants of $\mathfrak{so}(m)$ in the orthonormal basis $e_{ij}=E_{ij}-E_{ji}$ (inner product $\tfrac12\mathop{\mathrm{tr}}X^{\mathsf T}Y$), so $I^\#I=(m-2)I$; a $\#$-idempotent is $C^\#C=C$. $\mathfrak{sp}(k)\subset\mathfrak{so}(4k)$ as the commutant of right quaternion multiplication, with $I^\#I=cI$, $c=k+1$ in this metric.
- **The $\mathfrak g_2$ analogue** (Gate 2 [r1884](REVIEW_r1884.md), [r1885](REVIEW_r1885.md)): on a torus family, $A^\#A=0$, $A^\#P_\alpha=\tfrac12(\alpha^{\mathsf T}A\alpha)P_\alpha$, $P_\alpha^\#P_\alpha=\alpha\alpha^{\mathsf T}$, and $(P_\alpha^\#P_\beta)|_{V_\gamma}=S/4$ with $S$ the totally symmetric sum of squared structure constants over the three planes.
- **[L265](../findings/second-order.md)**: $I/c$ on $\mathfrak{sp}(m)$, $m\ge2$, is unstable, its $[\omega_2]$ eigenvalue being $\tfrac{m+2}{2(m+1)}$.

## Items

1. **The torus system at general $k$.** Are the root lengths ($2$ long, $1$ short), the mixed coefficients ($\tfrac14$ short plus short onto short, $\tfrac12$ otherwise), the Cartan block $a_i$, $A_{ij}$ and the three families of rows right for every $k$, not only at the $k=3$ construction they were read from? Derive from $C_k$'s root system and the $S/4$ rule.
2. **The decoupling** into $s$ and $d$, the invariance of $d=0$, and the positivity condition $s>\lvert d\rvert$.
3. **The trace identity** $\sum B_{ij}d_{ij}^2=\tfrac12\mathop{\mathrm{tr}}D^3$ and the criterion $2\min B\ge\max_i\sum_js_{ij}\Rightarrow D=0$; is the claim "the $d$-sector vanishes near $I/c$" established as stated, and in what neighbourhood?
4. **The equal-weight theorem**, steps 1 to 7, each read against the one above: $a_i=u_i$; the matrix equation; the square completion; the commutation giving equal $u_i$ (is $u\le\tfrac12$ available where it is used?); the projection; the rank-one lemma; the value.
5. **Scope.** Does the block claim more than it shows about the whole torus family, given the $d$-half is open away from $I/c$?

## Lean table

| claim | declaration |
|---|---|
| the torus system and its coefficients | none: untyped, item 1 checks it by hand |
| the matrix steps 2 to 7 of the equal-weight theorem | none yet: a Lean file is being written in parallel, and this round reads the prose |
| the trace identity | none: item 3 checks it |

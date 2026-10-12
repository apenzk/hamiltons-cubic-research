# Review r1910: the absolute trace floor and the exceptional algebras (I117)

Log: [agent_logs/r1910-trace-floor.log](../agent_logs/r1910-trace-floor.log). Analysis only. Two screens of seconds, reported as screens: a random search for $\max\lVert\mathrm{ad}_x\rVert^2$ on $\mathfrak{so}(5)$, $\mathfrak{so}(7)$, and exact rational evaluation of the four end values.

**Verdict: CONFIRMED on (1) and (2), one correction to the closing bullet on $\mathfrak g_2$ (every embedding with $j\ge2$ passes, which includes the reducible $\mathbf7\oplus\mathbf7$ and $\mathbf7^{\oplus3}$).**

| # | claim | verdict |
|---|---|---|
| 1 | diagonal identity, $\sum_ic_{ijm}=\lVert[u_j,u_m]\rVert^2$, chain to $2\le K\operatorname{tr}C$ | CONFIRMED |
| 2 | $K=\max\lVert\mathrm{ad}_x\rVert_{\mathrm{op}}^2=\lvert\theta\rvert^2$ | CONFIRMED |
| 3 | $\lvert\theta\rvert^2=2c/h^\vee$, $c=h^\vee/j$, the indices $3,6,12,30$ and their minimality | CONFIRMED |
| 4 | $g=1-\tfrac r2$, the lower-end formula, monotonicity, $3.15$, $10.6$, $32.2$, $135$ | CONFIRMED |
| 5 | assembly, including reducible embeddings | CONFIRMED |
| 6 | closing bullets | PLAUSIBLE, one correction ($\mathfrak g_2$: $j\ge2$, not $j\ge4$) |
| 7 | Lean declarations and axioms | CONFIRMED, standard three axioms |
| 8 | prior record | new to the record |

## 1. The diagonal identity and the chain

$C^\#C=\tfrac12\sum_{i,j}\lambda_i\lambda_j[u_i,u_j][u_i,u_j]^{\mathsf T}$, so $\langle u_m,C^\#Cu_m\rangle=\tfrac12\sum_{i,j}c_{ijm}\lambda_i\lambda_j$, and $C^\#C=C$ makes this $\lambda_m$. The $u_i$ are an orthonormal basis of all of $\mathfrak h$ (zero eigenvalues included, which is what makes the row sum complete), and invariance gives $\langle[u_i,u_j],u_m\rangle=\langle u_i,[u_j,u_m]\rangle$ up to sign, so $\sum_ic_{ijm}=\lVert[u_j,u_m]\rVert^2$. With $\lambda_m=\max\lambda_i$: $c_{ijm}\lambda_i\lambda_j\le c_{ijm}\lambda_m\lambda_j$ uses $c_{ijm}\ge0$ and $\lambda_j\ge0$, so PSD is exactly what is needed. Then $\lambda_m\le\tfrac12\lambda_m\sum_j\lambda_j\lVert[u_j,u_m]\rVert^2$, and dividing needs $\lambda_m>0$, which holds because $C\ne0$ is PSD. The last step $\lVert[u_j,u_m]\rVert^2\le K$ again uses $\lambda_j\ge0$.

## 2. $K=\lvert\theta\rvert^2$

$\max_{\lvert x\rvert=\lvert y\rvert=1}\lVert[x,y]\rVert^2=\max_{\lvert x\rvert=1}\lVert\mathrm{ad}_x\rVert_{\mathrm{op}}^2$ by definition of the operator norm. The metric is $\mathrm{Ad}$-invariant, so $x$ may be conjugated into a Cartan $\mathfrak t$. There $\mathrm{ad}_x$ is $0$ on $\mathfrak t$ and a rotation by $\alpha(x)$ on each real root plane, so $\lVert\mathrm{ad}_x\rVert_{\mathrm{op}}^2=\max_\alpha\alpha(x)^2$, and the maximum over unit $x\in\mathfrak t$ is $\max_\alpha\lvert\alpha\rvert^2=\lvert\theta\rvert^2$ with $\lvert\cdot\rvert$ the dual norm of the given metric. Screen: on $\mathfrak{so}(5)$ and $\mathfrak{so}(7)$ with $e_{ij}$ orthonormal, 300 random unit $x$ give $\max\lVert\mathrm{ad}_x\rVert^2$ of $1.9985$ and $1.980$, approaching $2=\lvert\theta\rvert^2$ from below, and $\tfrac12\operatorname{tr}(\mathrm{ad}_x^{\mathsf T}\mathrm{ad}_x)=n-2$.

## 3. The normalisations

- $\langle u,I^\#Iu\rangle=\tfrac12\sum_{a,b}\langle[e_a,e_b],u\rangle^2=\tfrac12\operatorname{tr}(\mathrm{ad}_u^{\mathsf T}\mathrm{ad}_u)$, so $\operatorname{tr}(\mathrm{ad}_x^{\mathsf T}\mathrm{ad}_x)=2c\lvert x\rvert^2$, the same fact as L260's $\sum_{i,j}c_{ijk}=2c$.
- On $\mathfrak t$, each pair $\pm\alpha$ contributes $2\alpha(x)^2$ to that trace, so it equals $\sum_{\alpha\in\Delta}\alpha(x)^2=-B(x,x)$. With $(\,,)_0$ the invariant form where $\lvert\theta\rvert_0^2=2$, $-B=2h^\vee(\,,)_0$. Write $\langle\,,\rangle=s(\,,)_0$: then $\lvert\theta\rvert^2=2/s$ and $\sum_\alpha\alpha(x)^2=2h^\vee\lvert x\rvert^2/s=h^\vee\lvert\theta\rvert^2\lvert x\rvert^2$. Hence $2c=h^\vee\lvert\theta\rvert^2$, that is $\lvert\theta\rvert^2=2c/h^\vee$.
- In $\mathfrak{so}(n)$'s metric $\langle X,Y\rangle=-\tfrac12\operatorname{tr}(\rho X\rho Y)$, and $-\operatorname{tr}(\rho X\rho Y)=\ell_\rho(X,Y)_0$ with $\ell(\mathrm{ad})=2h^\vee$ (L256's convention). So $s=\ell_\rho/2=j$, the index in the note's normalisation ($j(\mathrm{ad})=h^\vee$), and $c=h^\vee\lvert\theta\rvert^2/2=h^\vee/j$. The index is additive over summands, so this holds for reducible $\rho$ too.
- Checks: $\mathfrak{so}(n)$ on $\mathbb R^n$, $j=1$, $h^\vee=n-2$, $c=n-2$. $\mathfrak g_2$ on $\mathbb R^7$, $j=1$, $h^\vee=4$, $c=4$, and $\lvert\theta\rvert^2=2$, which matches the long roots of $\mathfrak{su}(3)\subset\mathfrak g_2$ being roots $\varepsilon_i-\varepsilon_j$ of $\mathfrak{so}(6)$. $\mathfrak{sp}(k)$ on $\mathbb R^{4k}$, the realified $\mathbb C^{2k}$, $j=2\cdot\tfrac12=1$, $c=k+1$. $\mathfrak{so}(3)$ on $\mathbb R^3$ (the adjoint of $\mathfrak{su}(2)$, $j=h^\vee=2$) gives $c=1=n-2$ and floor $2$, against its only PSD idempotent $I$, trace $3$.
- Indices ($\ell=2j$), matching the record's own table in L256 and the D6 note batch 17 ($\ell=6,12,24,60$): $\mathfrak f_4$ on $\mathbf{26}$ (real), $j=3$. $\mathfrak e_6$: $\mathbf{27}$ is complex, so a real representation containing it contains $\overline{\mathbf{27}}$, $j\ge2\cdot3=6$, attained on $\mathbb R^{54}$. $\mathfrak e_7$: $\mathbf{56}$ is quaternionic, so it occurs with even multiplicity, $j\ge12$, attained on $\mathbb R^{112}$; the next irreducible is the adjoint, $j=18$. $\mathfrak e_8$: the adjoint is the smallest, $j=30$. Every other nontrivial irreducible has larger index, so these are the minima of $j$ over all real embeddings, reducible ones included.

## 4. $g$, the lower-end formula, the values

- $\gamma_V=c-\mathrm{Cas}_V/4=c-r\cdot2c/4=c(1-r/2)$. $\operatorname{Sym}^2\mathfrak h$ has exactly three components for the four algebras ($1+324+1053=1378$, $1+650+2430=3081$, $1+1539+7371=8911$, $1+3875+27000=30876$, each $d(d+1)/2$). The $2\theta$ component has $r=2+2/h^\vee>2$, so a negative scalar, and the other one is $\gamma^*=cg$ with $g=\tfrac5{18},\tfrac14,\tfrac29,\tfrac15$, all positive as L286 (1) requires.
- At $\tau=j$ with $c=h^\vee/j$: $\big(j-c(1-g)j^2/d\big)/(cg)=j^2\big(1-h^\vee(1-g)/d\big)/(gh^\vee)$. The bracket is positive ($\tfrac78,\tfrac{69}{78},\tfrac{119}{133},\tfrac{224}{248}$), so the value is a positive multiple of $j^2$ and increases in $j$.
- Exact: $\tfrac{63}{20}=3.15$, $\tfrac{138}{13}=10.62$, $\tfrac{612}{19}=32.21$, $\tfrac{4200}{31}=135.5$. The note's four numbers are right.

## 5. The assembly

- $\varphi(\tau)=\big(\tau-(c-\gamma^*)\tau^2/d\big)/\gamma^*$ is concave because $c-\gamma^*=c(1-g)>0$ and $\gamma^*>0$, so on an interval it is at least its smaller end value (`concave_min`, with $A=(c-\gamma^*)/d$, then division by $\gamma^*$).
- The interval: $\tau\ge j$ by (1), and $\tau\le d/c$ by L260 (4) on a simple $\mathfrak h$ ($K=cI$). It is nonempty since $d/c=dj/h^\vee\ge j$.
- The upper end $\varphi(d/c)=d/c^2$ (direct), and L256 with $\mathcal M=2cd$ reads $c/\sqrt d\le(n-2)/\sqrt N$, which is $d/c^2\ge N/(n-2)^2$. Here it is not even needed: $d/c^2=dj^2/h^{\vee2}\ge5.78$.
- $N/(n-2)^2=\tfrac{n(n-1)}{2(n-2)^2}$ decreases for $n\ge9$ from $\tfrac{36}{49}=0.735<\tfrac34$, and every embedding of the four has $n\ge26$.
- Every embedding: $c=h^\vee/j$ with $j\ge j_{\min}$, both end values increase in $j$, so the minimal-index case bounds all others, reducible ones included. With L270 this covers every stable PD idempotent whose range is one of the four. CONFIRMED.

## 6. The closing bullets

- $h^\vee/d$: $\tfrac4{14}=\tfrac27$ on $\mathfrak g_2$, $\tfrac{k+1}{k(2k+1)}\approx\tfrac1{2k}$ on $\mathfrak{sp}(k)$. Correct, and the point that this is no substitute for U's $\operatorname{tr}C\ge d/c$ is right.
- $\mathfrak g_2\subset\mathfrak{so}(7)$: floor $h^\vee/c=1$ against $\tau_-=\tfrac{12}7$. Correct. $\mathfrak{sp}(k)$ floor $1$ in $\mathfrak{so}(4k)$: correct. $\mathfrak{su}(k)$ (on $\mathbb R^{2k}$, $j=1$, floor $1$) falls short, e.g. $\mathfrak{su}(3)$ with $\gamma^*=c/2$ gives $\varphi(1)=0.54<0.735$. Plausible as stated qualitatively.
- **Correction.** "The larger embeddings of $\mathfrak g_2$ ($j\ge4$) pass" understates. On $\mathfrak g_2$, $g=1-\tfrac7{12}=\tfrac5{12}$ and the lower-end value is $j^2\big(1-4\cdot\tfrac7{12}/14\big)/\big(\tfrac5{12}\cdot4\big)=j^2/2$, and the upper end is $\tfrac{7}{8}j^2$. So every embedding with $j\ge2$ passes: $\mathbf7\oplus\mathbf7\subset\mathfrak{so}(14)$ ($j=2$, value $2$), $\mathbf7^{\oplus3}$ ($j=3$), the adjoint ($j=4$) and all larger. The only embeddings left are $\mathbf7\oplus\text{trivial}$ ($j=1$, value $\tfrac12$), where L286 covers the torus family. Suggested text: "Every other embedding of $\mathfrak g_2$ ($j\ge2$, from $\mathbf7\oplus\mathbf7$ on) passes, the lower end being $j^2/2$."

## 7. Lean

- `trace_floor` takes $\lambda\ge0$, $c_{ijk}\ge0$, $\lambda_i\le\lambda_m$, $\lambda_m>0$, the diagonal identity and row sums $\le K$, and concludes $2\le K\sum_i\lambda_i$. That is the scalar core as the table says.
- `concave_min`: $A\ge0$, $a\le t\le b$ gives $\min(\varphi(a),\varphi(b))\le\varphi(t)$ for $\varphi(t)=t-At^2$. As stated.
- `f4_end` … `e8_end` are literally $\tfrac34<j^2(1-h^\vee(1-g)/d)/(gh^\vee)$ with $(j,h^\vee,d,g)=(3,9,52,\tfrac5{18})$, $(6,12,78,\tfrac14)$, $(12,18,133,\tfrac29)$, $(30,30,248,\tfrac15)$, all matching.
- `#print axioms`: all six depend on `propext`, `Classical.choice`, `Quot.sound` only (run from lean/ against the built module, exit 0). No `sorryAx`.

## 8. The record

- No trace lower bound is on the record. The D6 note batch 33 (line 331 of [2026-09-26-I73-class-ceiling.md](2026-09-26-I73-class-ceiling.md)) records the opposite obstacle, that the pairings bound the trace only from above. The new floor is weaker than $d/c$ by the factor $h^\vee/d$, so it is consistent with that obstacle, as the first bullet says.
- The exceptional algebras appear on the record only in L256's index table (same $\ell$ values as here), L265's scalars, and the graded-half list. No earlier result disposes of them for H. New to the record.
- A sanity check of sharpness, beyond the brief: the $\mathfrak{su}(2)$ through $\theta$ has its own $c'=\lvert\theta\rvert^2=2c/h^\vee$, so $\Pi/c'$ has trace $\tfrac32h^\vee/c$, within a factor $\tfrac32$ of the floor. The floor is the right order.

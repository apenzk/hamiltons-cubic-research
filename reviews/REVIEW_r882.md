# Review r882: the n = 5 non-coordinate two-eigenvalue witness survives every attack I could mount

Reviewer r882, adversarial, cold brief. Log: [../agent_logs/review-r882-witness.log](../agent_logs/review-r882-witness.log). Brief: [brief-r881-r882.md](../../../private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d494340f-1dff-4003-801d-ae0e180c75c5/scratchpad/brief-r881-r882.md), absolute path `/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d494340f-1dff-4003-801d-ae0e180c75c5/scratchpad/brief-r881-r882.md`. Scripts I wrote sit beside it as `r882_core.py`, `r882_polish.py`, `r882_frame.py`, `r882_final.py`, `r882_exhibit.py`, `r882_gradchk.py`. The polished solution is in `r882_x_hi.txt` to 55 digits. I read the brief and the witness file and nothing else of the record.

## Claim table

| # | Claim | Verdict | Decisive evidence |
|---|---|---|---|
| C1 | Every reported figure reproduces from the witness file | **Confirmed** | All six figures reproduce to the digits quoted |
| C2 | The object lies in $\mathcal W_5$ | **Confirmed** | $\operatorname{tr}W = 8\cdot10^{-17}$, $\lVert\mathrm{Ric}\rVert = 1.9\cdot10^{-11}$, $\max\lvert\mathrm{Alt}(W)\rvert = 2.6\cdot10^{-12}$ from the contraction definitions, and exactly zero after the polish |
| C3 | It has two eigenvalues, $\pm 1/\sqrt{10}$, each of multiplicity five | **Confirmed** | Spectrum computed, and $\lVert W\rVert^2 = 1.000000000000000$ |
| C4 | It is not coordinate-diagonal in any frame | **Confirmed** | $\operatorname{tr}(\Pi_1\Pi_2) = 0.498509755736202811\ldots$ to 45 digits, and that quantity is an $O(5)$ invariant |
| C5 | The proof of non-coordinacy runs through L201 | **Refuted as stated** | Only the easy direction is used: the pairwise trace is an invariant and coordinate planes force values in $\{0,1\}$. L201 is never needed |
| C6 | $A^\perp$ admits an orthonormal decomposable basis | **Confirmed** | Five forms exhibited, max Pfaffian $2.8\cdot10^{-17}$, $\lVert\Theta(A^\perp)-2\,\mathrm{Id}\rVert = 3.3\cdot10^{-16}$ |
| C7 | The $10^{-11}$ residual could hide a coordinate exact solution | **Refuted** | Polished to $\lVert F\rVert = 3.6\cdot10^{-61}$, and the solution moved by $2\cdot10^{-10}$ and the defect moved by $8\cdot10^{-11}$ |
| C8 | It is a rotation of the coordinate pentagon | **Refuted** | Trace multisets differ, and the singular values of $\mathrm{span}\{\Pi_\alpha\}$ are $(2,1.6081,1.3924,0.99999,0.6895)$ against the pentagon's $(2,\varphi,\varphi,\varphi^{-1},\varphi^{-1})$ |
| C9 | Its $\theta$ is one of $\sqrt{24}/5$, $\sqrt{3/2}$ | **Refuted** | $\operatorname{tr}W^3 = 0$ and $\langle W,W^\#\rangle = 0$, so $P(W) = 0$ and $\theta = 0$ |
| C10 | It is a critical point of $P$ on the unit sphere of $\mathcal W_5$ | **Confirmed, at critical value zero** | $\Pi_{\mathcal W_5}\bigl(3(W^2+W^\#)\bigr) = 1.2\cdot10^{-15}$ |
| C11 | The derivational argument for first Bianchi is valid | **Valid but stronger than needed** | $\mathrm{Alt}(\mathrm{Id}) = 0$ exactly, so $\mathrm{Alt}(\Pi_{A^\perp}) = -\mathrm{Alt}(\Pi_A) = 0$ and $A^\perp$ need not be decomposable |
| C12 | The refutation extends past $n = 5$ | **Confirmed for $n = 5$ and every $n \ge 8$** | $n = 8, 9, 10, 12$ built and verified, while $n = 6, 7$ are out of reach of this padding |

## One-line summary

The witness is what it is claimed to be, so the statement "every two-eigenvalue critical point of the decomposable locus is coordinate-diagonal" is false at $n = 5$, and the coordinate pentagon itself turns out to sit on a positive-dimensional family of solutions whose generic member is non-coordinate, which makes the refutation independent of the witness file.

## Conventions

I used the brief's conventions unchanged: $\langle X,Y\rangle = \tfrac12\operatorname{tr}(X^{\mathsf T}Y)$ on skew matrices, $u\wedge v = vu^{\mathsf T}-uv^{\mathsf T}$, $\varphi_{ij} = E_{ji}-E_{ij}$ as the orthonormal basis of $\Lambda^2\mathbb R^5$. Coordinates of a form are $c_{ij}(\omega) = \langle\omega,\varphi_{ij}\rangle = \omega_{ji}$, which I verified rather than assumed. The curvature 4-tensor of an operator $W$ on $\Lambda^2$ is $R_{ijkl} = \langle W\varphi_{ij},\varphi_{kl}\rangle$ extended antisymmetrically, Ricci is $\mathrm{Ric}_{ik} = \sum_j R_{ijkj}$, and first Bianchi is $R_{ijkl}+R_{iklj}+R_{iljk} = 0$ on the five quadruples.

Two conventions the brief leaves open, which I fixed and calibrated:

- **The sharp operator.** $[X,Y] = XY-YX$, and $(W^\#)_{\alpha\beta} = \tfrac12\sum C^{\gamma\delta}_{\alpha}C^{\varepsilon\zeta}_{\beta}W_{\gamma\varepsilon}W_{\delta\zeta}$ with $C^{\alpha\beta}_{\gamma} = \langle[\varphi_\alpha,\varphi_\beta],\varphi_\gamma\rangle$. Calibration: $\mathrm{Id}^\# = (n-2)\,\mathrm{Id}$ holds to exactly zero, which is the standard Hamilton normalisation. Equivalently $\langle W,W^\#\rangle = \tfrac12\sum_{\alpha\beta}\langle W[b_\alpha,b_\beta],[Wb_\alpha,Wb_\beta]\rangle$, and in an eigenbasis $\langle W,W^\#\rangle = \tfrac12\sum_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma(C^{\alpha\beta}_\gamma)^2$. If the record uses a different factor, my $\theta$ scales but stays zero.
- **$\lVert W\rVert$.** Hilbert-Schmidt on operators, $\lVert W\rVert^2 = \operatorname{tr}W^2$. This is what makes $\lambda = 1/\sqrt{10}$ put $W$ on the unit sphere, which it does to 15 digits, so the intended convention is not in doubt.

## Hypothesis inventory

What I took as given without checking: the four numbered givens of the brief, except that I re-derived given 1 and given 2 rather than using them (section 2). What I checked: everything else. What I did not check: the record's statement of I76 itself, the $\kappa=1$ theorem's proof, and $\theta_0(5) = \sqrt{24}/5$ as a value, since the brief forbids reading the record. Where a conclusion depends on those, I say so.

Standing footing: **numerics refute and never establish**. Every positive claim below that rests on a search is labelled as a search. The claims that carry the verdict rest on an invariant plus a high-precision solve of a square-ish system, which is refutation-shaped evidence about a specific exhibited object, and I say where it still falls short of a proof (section 10).

## 1. Rebuilding the object and reproducing the figures

I reshaped the 50 reals as five $5\times2$ blocks, took the QR factor's first two columns, and wedged. The plane is the column space of the block, so it does not depend on which orthonormalisation is used, and the sign ambiguity in $\omega_\alpha$ affects nothing below: $\Pi_\alpha$, $\Theta$ and the pairwise traces are sign-free, and the Gram off-diagonals and Pfaffians are zero either way.

| Reported | Reproduced |
|---|---|
| $\lVert\omega_i\rVert^2 = 1$ | $\max\lvert\lVert\omega_i\rVert^2-1\rvert = 8.9\cdot10^{-16}$ |
| max off-diagonal $6.0\cdot10^{-12}$ | $5.97\cdot10^{-12}$ |
| max $4\times4$ Pfaffian $2.8\cdot10^{-17}$ | $2.78\cdot10^{-17}$ |
| $\lVert\sum\Pi-2\,\mathrm{Id}\rVert = 2.5\cdot10^{-11}$ | $2.466\cdot10^{-11}$ Frobenius, $1.07\cdot10^{-11}$ max entry |
| integrality defect $0.498510$ | $0.498510$ |
| $A^\perp$ decomposable to residual $4.8\cdot10^{-24}$ | my own search reaches sum of squares $2.3\cdot10^{-31}$, see section 4 |

Nothing failed to reproduce. The ten pairwise traces are

$$0.028968,\ 0.029141,\ 0.058109,\ 0.469542,\ 0.472349,\ 0.498510,\ 0.501490,\ 0.941891,\ 1,\ 1 .$$

Two of them are exactly $1$, so $P_0\cap P_3$ and $P_2\cap P_4$ are lines. One structural check worth recording: $\Theta(A) = 2\,\mathrm{Id}$ forces $\sum_{\beta\ne\alpha}\operatorname{tr}(\Pi_\alpha\Pi_\beta) = \operatorname{tr}(\Pi_\alpha\Theta)-2 = 2$ for each $\alpha$, and every row of the trace matrix does sum to $2.000000$. That is an independent consistency test on the reported figures and it passes.

## 2. Membership in $\mathcal W_5$, from the definitions

I built $W$ as a $10\times10$ matrix in the $\varphi$ basis as $\lambda(2\Pi_A-\mathrm{Id})$ and contracted by hand.

- **Symmetry**: $\lVert W-W^{\mathsf T}\rVert = 0$ by construction.
- **Trace**: $\operatorname{tr}W = 8.3\cdot10^{-17}$. The spectrum is five values $+0.3162278$ and five $-0.3162278$, so the $5+5$ split and $\lambda_\pm = \pm1/\sqrt{10}$ are exact, and $\operatorname{tr}W^2 = 1.000000000000000$.
- **Ricci**: contracting $\mathrm{Ric}_{ik} = \sum_j R_{ijkj}$ gives $\lVert\mathrm{Ric}\rVert = 1.86\cdot10^{-11}$, which is the isotropy residual and nothing more, and after the polish of section 5 it is zero to 60 digits.
- **First Bianchi**: the five components of $\mathrm{Alt}(W)$ have max modulus $2.59\cdot10^{-12}$.

**On the derivational arguments.** Given 1 reproduces: I verified $\mathrm{Ric}(\Pi_A) = \Theta(A)$ to $3.2\cdot10^{-12}$, and separately $\mathrm{Ric}(\mathrm{Id}_{\Lambda^2}) = 4\,\mathrm{Id}$ to exactly zero, so $\mathrm{Ric}(W) = \lambda(2\Theta(A)-4\,\mathrm{Id})$ and Ricci-flatness is equivalent to $\Theta(A) = 2\,\mathrm{Id}$ alone. The brief's route through "$\sum_{A^\perp}\Pi = 2\,\mathrm{Id}$" is correct but is an extra step.

The Bianchi argument is where the brief overshoots. It says every eigenform is decomposable, so $\mathrm{Alt}(W)\propto\sum\lambda_\alpha\omega_\alpha\wedge\omega_\alpha = 0$ term by term. That is valid, but it needs $A^\perp$ to be spanned by decomposable forms, which is the nontrivial claim of item 4. The shorter route needs only $A$: $\mathrm{Alt}(\mathrm{Id}_{\Lambda^2}) = 0$ exactly (I checked it: the identity's tensor is $\delta_{ik}\delta_{jl}-\delta_{il}\delta_{jk}$ and its alternation cancels identically), so $\mathrm{Alt}(\Pi_{A^\perp}) = -\mathrm{Alt}(\Pi_A)$, and I measured both at $4.10\cdot10^{-12}$. Writing $W = (\lambda_+-\lambda_-)\Pi_A+\lambda_-\mathrm{Id}$ gives $\mathrm{Alt}(W) = 0$ from the decomposability of $A$ alone.

**Consequence for the record.** Membership in $\mathcal W_5$ is immune to any failure of item 4. Only the phrase "whose eigenbasis is orthonormal and decomposable", and with it the reading of the refuted statement that quantifies over the *decomposable locus*, depends on $A^\perp$. Item 4 turns out to hold, so this is a robustness note rather than a defect.

## 3. Non-coordinacy

**The claim holds, and the stated proof is stronger than necessary.** For $g\in O(5)$ one has $\Pi_{gP} = g\Pi_Pg^{\mathsf T}$, hence $\operatorname{tr}(\Pi_{gP}\Pi_{gP'}) = \operatorname{tr}(\Pi_P\Pi_{P'})$: the pairwise plane trace is a frame invariant. If all five planes were coordinate planes of some frame, then in that frame every $\Pi_\alpha$ is a $0/1$ diagonal of trace two, so every pairwise trace is the number of shared indices, an element of $\{0,1\}$ for distinct planes. The witness has $\operatorname{tr}(\Pi_1\Pi_2) = 0.4985097557\ldots$, so no frame exists. **L201 is not used.** L201 is the converse, that traces in $\{0,1\}$ force coordinate planes, and nothing here needs it. This matters: the refutation of I76 does not inherit L201's risk.

**The search the brief asked for.** I parametrised $g = \exp(X)$, $X\in\mathfrak{so}(5)$, and minimised the coordinateness residual $\sum_\alpha\bigl(\sum_{i<j}M^\alpha_{ij}{}^2+\sum_i(M^\alpha_{ii}(1-M^\alpha_{ii}))^2\bigr)$ with $M^\alpha = g^{\mathsf T}\Pi_\alpha g$, over 3000 random starts of Levenberg-Marquardt. Best residual $8.218\cdot10^{-1}$. The same code on the coordinate pentagon reaches $1.08\cdot10^{-28}$ in 40 starts and recovers the pentagon's incidence pattern exactly, so the search is capable of finding a frame when one exists. The best frame found leaves diagonals such as $(0.842, 0, 0.144, 1, 0.014)$, nowhere near integral. This is a search and therefore establishes nothing on its own. The invariant argument above is what carries the verdict.

## 4. Is $A^\perp$ genuinely decomposable?

**Yes.** I searched independently, over 400 random starts, for five planes whose forms are mutually $\Lambda^2$-orthonormal, orthogonal to all of $A$, and isotropic. Best residual $4.80\cdot10^{-16}$, sum of squares $2.3\cdot10^{-31}$, which is better than the reported $4.8\cdot10^{-24}$ and consistent with it being the same solution converged further. The five forms, as coordinate vectors in $\{\varphi_{01},\varphi_{02},\varphi_{03},\varphi_{04},\varphi_{12},\varphi_{13},\varphi_{14},\varphi_{23},\varphi_{24},\varphi_{34}\}$:

```
eta_0 = ( 0.334594146, -0.231523071,  0.179497417, -0.501515347, -0.412248568,
         -0.044352763, -0.126459330,  0.251846131, -0.530405966, -0.134320087)
eta_1 = (-0.249963048,  0.036237559, -0.274794499,  0.366013965, -0.132130851,
         -0.299682151, -0.243694870,  0.188702214, -0.158146693, -0.706719908)
eta_2 = (-0.426487668,  0.108388118, -0.067191162, -0.286757445, -0.239630868,
         -0.633724156, -0.138092370,  0.198808199,  0.196215539,  0.404341193)
eta_3 = (-0.013624214,  0.649083574, -0.128415078, -0.214300963, -0.450606474,
          0.099729034,  0.149294764, -0.504088651, -0.024909898, -0.161501355)
eta_4 = (-0.524620445, -0.357626731,  0.278994212, -0.179382368, -0.301759160,
          0.327081788,  0.319808170,  0.062491143,  0.321188823, -0.281913020)
```

Their five $4\times4$ Pfaffians are at most $2.8\cdot10^{-17}$ each, computed directly and not inferred from the parametrisation, so the residual is not an artefact. The Gram is the identity to $2.2\cdot10^{-16}$, the components inside $A$ are at most $1.4\cdot10^{-16}$, and $\Theta(A^\perp) = 2\,\mathrm{Id}$ to $3.3\cdot10^{-16}$, which is forced anyway by $\Theta(\Lambda^2\mathbb R^5) = 4\,\mathrm{Id}$.

**A finding the brief did not ask for.** $A^\perp$ is itself non-coordinate: its own pairwise traces are $0.0038, 0.0084, 0.0122, 0.3072, 0.3110, 0.6806, 0.6890, 0.9878, 1, 1$. So the witness yields a second, inequivalent non-coordinate configuration for free. Better still, running the same search on the *coordinate pentagon's* $A^\perp$ (which is the coordinate pentagram, an obvious coordinate solution) returns a non-coordinate basis with traces $0.0012,\ldots,0.9913$ at residual $1.2\cdot10^{-16}$. That is already a second counterexample, found inside the pentagon's own data.

## 5. Precision: does the defect move?

**No.** I re-solved the system in mpmath at 60 digits by Gauss-Newton with minimum-norm SVD steps and a central-difference Jacobian at $h = 10^{-25}$, starting from the file. The constraint map has 25 components: the ten Gram off-diagonals, the ten off-diagonal entries of $\Theta$, and the five diagonal entries of $\Theta - 2\,\mathrm{Id}$.

| Iteration | $\lVert F\rVert$ |
|---|---|
| start | $2.135\cdot10^{-11}$ |
| 1 | $9.909\cdot10^{-21}$ |
| 2 | $4.244\cdot10^{-41}$ |
| 3 | $3.579\cdot10^{-61}$ |

Quadratic convergence to the working precision, so the file sits next to an honest solution and not near a fold. The solution moved by $\lVert x-x_0\rVert = 2.0\cdot10^{-10}$ and the traces moved by at most $7.8\cdot10^{-11}$:

$$\operatorname{tr}(\Pi_1\Pi_2):\quad 0.49850975568505662\ \longrightarrow\ 0.498509755736202811499657983651257164559162939 .$$

The exact defect is $0.4985097557362028114996579836512571645591629\ldots$, which is $1.49\cdot10^{-3}$ below $\tfrac12$ and $0.4985$ away from the nearest integer. Imprecision of order $10^{-11}$ cannot account for a gap of $0.4985$: the nearby exact solution is non-coordinate by four hundred million times the residual.

**Conditioning, so that the above is not a guess.** At the solution the $25\times50$ Jacobian has rank 18, with smallest nonzero singular value $0.2393$ and the next seven at $10^{-36}$ or below. So the system is well conditioned in its effective directions and the tangent nullity is 32. The known gauge directions, namely $GL(2)$ per plane (four each, which reparametrise a plane without moving it) plus $\mathfrak{so}(5)$ acting on all five at once, span a 30-dimensional space, and projecting the null space off it leaves exactly **2** genuine directions. The witness therefore lies on a 2-parameter moduli of solutions modulo frames.

**PSLQ.** I asked for a minimal polynomial of each trace, degree at most six, integer coefficients at most $10^6$, tolerance $10^{-40}$. The two integral traces return $x-1$, confirming they are exactly one. The other eight return nothing, so if the defect is algebraic it is of higher degree or larger height than that box. This does not weaken the verdict, it only means I cannot hand over a closed form.

## 6. Is it a rotation of the pentagon?

**No, on two independent invariants.**

| Invariant | Witness | Coordinate pentagon |
|---|---|---|
| Sorted pairwise traces | $0.0290, 0.0291, 0.0581, 0.4695, 0.4723, 0.4985, 0.5015, 0.9419, 1, 1$ | $0,0,0,0,0,1,1,1,1,1$ |
| Gram spectrum of $\{\omega_\alpha\}$ | $1,1,1,1,1$ | $1,1,1,1,1$ |
| Singular values of $\{\Pi_\alpha\}$ stacked | $2,\ 1.608078765,\ 1.392386619,\ 0.999995558,\ 0.689457083$ | $2,\ \varphi,\ \varphi,\ \varphi^{-1},\ \varphi^{-1}$ with $\varphi = 1.618033989$ |
| $\operatorname{rank}\,\mathrm{span}\{\Pi_\alpha\}$ | 5 | 5 |

The Gram spectrum is useless as a separator, since orthonormality forces it to be all ones for any configuration of this kind, and I note that so the record does not treat its agreement as evidence of anything. The trace multiset and the $\{\Pi_\alpha\}$ spectrum both separate the two. The pentagon's golden-ratio spectrum reflects its $C_5$ adjacency matrix. The witness has no such structure, and its fourth singular value $0.999995558$ differs from $1$ by $4.4\cdot10^{-6}$, far outside the $10^{-15}$ accuracy of the polished input, so that near-miss is a real feature and not rounding.

## 7. Its $\theta$, and criticality

$\operatorname{tr}W^3 = 0$ exactly, because the spectrum is $\pm\lambda$ with equal multiplicities. And $\langle W,W^\#\rangle = 0$ to machine precision. So

$$P(W) = 0,\qquad \theta = P(W)/\lVert W\rVert^3 = 0,$$

against $\theta_0(5) = \sqrt{24}/5 = 0.979796$ and $\sqrt{3/2} = 1.224745$. The **coordinate pentagon gives $\theta = 0$ as well**, which is a useful cross-check and is not an accident: with $A$ the pentagon and $A^\perp$ the pentagram, both 5-cycles, the structure constants satisfy $[A,A]\subseteq A^\perp$, $[A^\perp,A^\perp]\subseteq A$, and $[A,A^\perp]$ splitting 2 and 2 per edge, and the signed sum $\sum\varepsilon_\alpha\varepsilon_\beta\varepsilon_\gamma(C^{\alpha\beta}_\gamma)^2 = -10+10+10-10-10+10 = 0$ by hand. I did that computation on paper before trusting the number.

**It is a critical point of $P$ on the unit sphere of $\mathcal W_5$, with critical value zero.** I verified $\nabla P = 3(W^2+W^\#)$ by finite differences at a random symmetric point, maximum relative deviation $4.8\cdot10^{-8}$ over twelve directions at $h=10^{-6}$, which is the expected truncation error. I then built $\mathcal W_5$ as the linear space of symmetric operators satisfying the twenty Ricci and Bianchi conditions, obtaining $\dim\mathcal W_5 = 35$ as it must be at $n = 5$, confirmed $W\in\mathcal W_5$ to $7\cdot10^{-16}$, and found

$$\bigl\lVert\Pi_{\mathcal W_5}\bigl(3(W^2+W^\#)\bigr)\bigr\rVert = 1.16\cdot10^{-15}$$

at the witness and $5.6\cdot10^{-17}$ at the pentagon. Since $W^2 = \tfrac1{10}\mathrm{Id}$ and the identity is orthogonal to $\mathcal W_5$, this says $\Pi_{\mathcal W_5}(W^\#) = 0$, which is the full criticality condition and is consistent with the Euler relation $\langle\nabla P,W\rangle = 3P(W) = 0$.

**What this means for the programme.** The witness is a critical point at value zero, so it is a saddle or a degenerate point and **no competitor for $\sup P$**. The refutation is about the classification of two-eigenvalue critical points, not about the value of $\theta_0(5)$, and any bound proved by maximising $P$ is untouched. Whether some argument in the record uses coordinate-diagonality of two-eigenvalue points as a *step* toward a bound is something I cannot check without reading the record, and that is where the impact has to be traced.

## 8. Reach beyond $n = 5$

The construction pads. Write $\kappa = 2a/n$ for a configuration of $a$ decomposable orthonormal forms with $\Theta = \kappa\,\mathrm{Id}_n$. A direct sum $\mathbb R^{n_1}\oplus\mathbb R^{n_2}$ of two such configurations with the **same** $\kappa$ is again one: the forms of different blocks are automatically $\Lambda^2$-orthogonal and $\Theta$ adds blockwise. The witness has $\kappa = 2$, and $\kappa = 2$ blocks exist in dimensions 3 (the three coordinate planes of $\mathbb R^3$), 4 (the four planes $\{01,23,02,13\}$ of $\mathbb R^4$) and 5 (the pentagon or the witness). Every integer $m\ge3$ is a sum of 3s, 4s and 5s, so $n = 5+m$ gives a non-coordinate witness for **every $n\ge8$**, plus $n = 5$ itself. I built and verified four of them:

| $n$ | Blocks | $a$ | $\lVert\mathrm{Ric}\rVert$ | $\max\lvert\mathrm{Alt}\rvert$ | $\lambda_+,\lambda_-$ | Defect |
|---|---|---|---|---|---|---|
| 8 | witness + triangle | 8 | $4.6\cdot10^{-16}$ | $3.7\cdot10^{-17}$ | $0.298807^{(8)},-0.119523^{(20)}$ | $0.498510$ |
| 9 | witness + square | 9 | $4.9\cdot10^{-16}$ | $1.3\cdot10^{-16}$ | $0.288675^{(9)},-0.096225^{(27)}$ | $0.498510$ |
| 10 | witness + witness | 10 | $5.5\cdot10^{-16}$ | $5.6\cdot10^{-17}$ | $0.278887^{(10)},-0.079682^{(35)}$ | $0.498510$ |
| 12 | witness + square + triangle | 12 | $3.4\cdot10^{-16}$ | $3.0\cdot10^{-17}$ | $0.261116^{(12)},-0.058026^{(54)}$ | $0.498510$ |

Each is trace-free to $10^{-16}$, has $\lVert W\rVert^2 = 1$, exactly two eigenvalues, and carries the $0.498510$ trace inside the witness block, so none is coordinate in any frame. So the answer to "does it reach $n\ge12$" is yes.

**Two limits I want on the record.** First, $n = 6$ and $n = 7$ are *not* reached by padding: $6 = 5+1$ and $7 = 5+2$ fail because a single plane has $\kappa = 1$, and the witness's own $\Theta$ is $2\,\mathrm{Id}_5\oplus0$, which is not $\kappa\,\mathrm{Id}_6$ for any $\kappa$. Whether $n = 6,7$ admit non-coordinate examples is open from here, and settling it would need a search, which I have not run. Second, the padded objects are in $\mathcal W_n$ by the section 2 argument, which needs only $A$ decomposable. Whether their $A^\perp$ is also decomposable, and hence whether they sit on the *decomposable locus* under the strictest reading, I did not check for $n>5$.

## 9. $\kappa$ and the $\kappa=1$ theorem

The brief does not define $\kappa$, so I read it off the equivalence it states. "$\kappa = 1$ iff $a = n/2$" together with $\operatorname{tr}\Theta = 2a$ and $\Theta = \kappa\,\mathrm{Id}_n$ gives $\kappa = 2a/n$. Here $a = 5$, $n = 5$, so **$\kappa = 2$**. The alternative reading, $\Theta(A) = \kappa\,\mathrm{Id}$ directly, gives $\kappa = 2$ as well, so the conclusion does not depend on which is meant.

The $\kappa=1$ theorem asserts that $a = n/2$ forces the planes to be mutually orthogonal, hence all pairwise traces zero. It cannot apply here: $a = n/2$ needs $n$ even, and $n = 5$ is odd. **No contradiction.** I also checked the theorem's conclusion is genuinely violated at $\kappa=2$, as it must be: the witness has traces $0.4985$ and $1$, and even the coordinate pentagon has five traces equal to one, so mutual orthogonality already fails for the coordinate case at $\kappa = 2$. The theorem's hypothesis is doing real work and the witness is on the other side of it.

## 10. What would make this round wrong

Four ways, and what I did about each.

1. **The witness reconstruction could differ from what the proposer meant.** Ruled out structurally: the plane is the column space of each block, independent of the orthonormalisation, and every quantity I report is invariant under the residual sign of $\omega_\alpha$. Confirmed empirically, since all six reported figures came back at the quoted digits through my independent code path.
2. **The defect could be a numerical artefact.** This is the attack the round exists for and it is the one I pushed hardest. Answered in section 5: three Newton steps at 60 digits take the residual to $3.6\cdot10^{-61}$, the solution moves $2\cdot10^{-10}$, and the defect moves $8\cdot10^{-11}$ while sitting $0.4985$ from the nearest integer. Rank 18 with least nonzero singular value $0.2393$ says the system is not ill conditioned.
3. **My sharp operator or $\mathcal W_5$ projector could be wrong, making $\theta$ and the criticality claim junk.** I found and fixed exactly this: my first attempt at $W^\#$ was miscontracted and I caught it because it disagreed with a hand computation of the pentagon's signed structure-constant sum. The version reported is calibrated on $\mathrm{Id}^\# = (n-2)\mathrm{Id}$ (exact), cross-checked against the eigenbasis formula, and its gradient identity verified by finite differences, and $\dim\mathcal W_5 = 35$ came out right independently. The residual risk is a factor convention differing from the record's, which would rescale $\theta$ without changing that it is zero.
4. **The whole thing could be one lucky point, so that the record could quarantine it as an oddity.** Ruled out, and this is my main contribution beyond the brief. I computed the Jacobian at the **coordinate pentagon** in the same parametrisation: rank 15, nullity 35, gauge span 30, leaving **5** non-gauge directions against the witness's 2. I then continued along each of the five, 24 steps out to arclength $s = 1.2$, re-solving at every step with the step size pinned, and the residual stayed below $8.9\cdot10^{-16}$ the whole way. The integrality defect rises continuously from 0:

   | Direction | Defect at $s=1.2$ | Traces at $s = 1.2$ |
   |---|---|---|
   | 0 | $0.146404$ | $0.0048, 0.0404, 0.0452, 0.1012, 0.1060, 0.8536, 0.8940, 0.9548, 1, 1$ |
   | 1 | $0.190412$ | $0, 0.00002, 0.00002, 0.1904, 0.1904, 0.8096, 0.8096, 0.99998, 1, 1$ |
   | 2 | $0.441100$ | $0.0628, 0.1628, 0.2156, 0.2256, 0.2783, 0.5589, 0.7217, 0.7745, 1, 1$ |
   | 3 | $0.410861$ | $0.0522, 0.1418, 0.1940, 0.2168, 0.2690, 0.5891, 0.7310, 0.8060, 1, 1$ |
   | 4 | $0.399376$ | $0.1545, 0.2323, 0.2449, 0.3683, 0.3868, 0.3994, 0.6006, 0.6132, 1, 1$ |

   **The coordinate pentagon is not rigid.** The pairwise trace multiset takes a continuum of values on the solution set, whereas coordinate configurations realise only the single multiset $\{0^5,1^5\}$, because up to a frame the only $2$-regular graph on five vertices is the 5-cycle. A finite set of exact solutions cannot produce a continuum of an invariant along a path whose residual stays at $10^{-15}$ over 24 samples. So the refutation of I76 does not depend on the witness file at all: it follows from the pentagon having a non-gauge deformation, and the witness is one particular point of the family, sitting at moduli dimension 2 rather than the pentagon's tangential 5.

**What I did not do, and would need approval for.** An exact algebraic witness. The natural route is to solve the reduced system over $\mathbb Q$ and exhibit an algebraic number as the defect, which would turn this from verified numerics into a proof. Two cheaper sub-steps are also available and unrun: an exact Jacobian rank at the rational pentagon point via a square-root-free graph parametrisation of the planes, and a $\mathbb Z_5$-equivariant reduction (in which the Fourier weights of the frame are forced to $p = 2/5$, $q = r = 4/5$, a result I did derive by hand, though that ansatz gives a zero-dimensional family and so cannot host the deformation). None of these is needed for the verdict, and each is a computation the analysis-only footing reserves for the parent.

## Verdict

**The claim is upheld. I76 is refuted at $n = 5$**, and I could not break the witness on any of the ten fronts. The object is a genuine two-eigenvalue element of $\mathcal W_5$ with orthonormal decomposable eigenbasis on both sides of the splitting, and its integrality defect $0.4985097557362028114996579836512571645591629$ is a frame invariant, established at 45 digits against a residual of $3.6\cdot10^{-61}$, so no frame makes it coordinate.

Four corrections and additions the record should absorb:

- **Drop L201 from the argument.** Non-coordinacy needs only that the pairwise plane trace is an $O(n)$ invariant taking integer values on coordinate planes. Using L201 imports risk for nothing.
- **Drop $A^\perp$ from the membership proof.** $\mathrm{Alt}(\mathrm{Id}_{\Lambda^2}) = 0$ makes first Bianchi follow from the decomposability of $A$ alone. $A^\perp$ is in fact decomposable, so this is robustness, not repair.
- **Record $\theta = 0$.** The witness and the pentagon both sit at $P(W) = 0$, both are critical points of $P$ on the unit sphere of $\mathcal W_5$, and neither bears on $\theta_0(5) = \sqrt{24}/5$. The refutation touches the classification of two-eigenvalue critical points and leaves the supremum alone.
- **Promote the pentagon's non-rigidity over the witness file.** The coordinate pentagon has a 5-dimensional non-gauge kernel and its deformations move the trace invariant continuously off $\{0,1\}$. That is a stronger and more checkable statement than any single witness, and it is where an exact proof should start.

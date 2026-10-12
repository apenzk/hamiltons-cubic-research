# REVIEW r1691: L47's CP^m closed form read off the CP^m Weyl operator (a7dc391a)

**Verdict: CONFIRMED.** `cp_theta` in [L47CPm.lean](../lean/HamiltonsCubic/Results/L47CPm.lean) proves $(1/2)/\sqrt{\texttt{cpNormSq}\,m}=\theta(W_{\mathbb{CP}^m})$ at every $m\ge2$ for [L70CPm.lean](../lean/HamiltonsCubic/Results/L70CPm.lean)'s `WCPm`, which is the Fubini–Study Weyl operator with positive orientation and Einstein constant $2m+2$. Since $\theta$ is homogeneous of degree zero and a critical operator with value $\tfrac12$ has $P=\tfrac12\lVert W\rVert^2$, the rescaling $W'=W/(4(m+1))$ has $\lVert W'\rVert^2=1/(4\theta^2)=\texttt{cpNormSq}\,m$, which is the record's reading (L46, `theta_le_of_floor`). `cp_theta_le` is $\theta\le\sqrt{3/2}$ through `cp_floor`, consistent with L10 and with L53CPm's `thetaSq_WCPm`, and new as a statement about the operator. The axiom screen puts 2/2 declarations on the standard three. Two observations, neither a defect: the Einstein-½ identification is composed in prose rather than typed, although every ingredient is in the layer, and `cp_theta_le` restates a fact already reachable from `thetaSq_WCPm` and L10Statement.

| # | Claim | Verdict |
|---|---|---|
| 1 | `WCPm` is the Weyl operator of $\mathbb{CP}^m$, $n=2m$, up to a positive scalar, in the layer's conventions | **CONFIRMED** |
| 2a | `cp_theta`: $(1/2)/\sqrt{\texttt{cpNormSq}\,m}=\theta(\texttt{WCPm})$ at $m\ge2$ | **CONFIRMED** |
| 2b | Reading `cpNormSq m` as $\lVert W\rVert^2$ at Einstein constant $\tfrac12$ through $\theta=(1/2)/\lVert W\rVert$ and scale invariance | **CONFIRMED** (observation O1) |
| 3a | `cp_theta_le`: $\theta(\texttt{WCPm})\le\sqrt{3/2}$ at $m\ge2$ | **CONFIRMED** |
| 3b | No contradiction with L10, L53CPm's `thetaSq_WCPm` or L53's `thetaSq` | **CONFIRMED** (observation O2) |
| 4 | Axioms: standard three only | **CONFIRMED** (screen by the repo's audit script) |
| 5 | The [lean/INDEX.md](../lean/INDEX.md) L47 row states what is proved | **CONFIRMED** |

One line: the record's $\mathbb{CP}^m$ closed form is now tied to an explicit, kernel-checked Weyl operator through $\theta$, and the value it gives agrees with L10's $\theta^2=(m+1)(2m-1)/(3m(m-1))$.

## Attack line 1: `WCPm` is the $\mathbb{CP}^m$ Weyl operator

- **Definition** ([L70CPm.lean](../lean/HamiltonsCubic/Results/L70CPm.lean)): `WCPm X = cA m • X + Jm * X * Jmᵀ + frob Jm X • Jm`, $c_A=-3/(2m-1)$, `Jm` the standard complex structure ($J^2=-1$, $J^{\mathsf T}=-J$, `Jm_mul_self`, `Jm_skew`).
- **Tensor by hand.** From `WCPm_phi_apply` and `WCPm_R4`, $\langle W\varphi_{ij},\varphi_{kl}\rangle=c_A(\delta_{ik}\delta_{jl}-\delta_{il}\delta_{jk})+J_{ik}J_{jl}-J_{il}J_{jk}+2J_{ij}J_{kl}$, using $J_{ki}J_{lj}=J_{ik}J_{jl}$. The Fubini–Study tensor at holomorphic sectional curvature $4$ is the same expression with coefficient $1$ on the $\delta\delta$ term, has $\mathrm{Ric}=2(m+1)g$ and scalar curvature $4m(m+1)$. Its Weyl part subtracts $\frac{s}{n(n-1)}=\frac{2(m+1)}{2m-1}$ from that coefficient, giving $1-\frac{2(m+1)}{2m-1}=-\frac3{2m-1}=c_A$. So `WCPm` is the FS Weyl tensor with coefficient $+1$, not merely up to scalar.
- **Sign.** The orientation is the positive one: `WCPm_J` gives eigenvalue $c_A+1+2m>0$ on the Kähler form, and `WCPm_critical` ([L70CPmCrit.lean](../lean/HamiltonsCubic/Results/L70CPmCrit.lean)) gives `IsCritical WCPm (2m+2)`, the criticality value equal to the Einstein constant $2(m+1)$ as L46's $Q(W)=\lambda W$ requires. A reversed sign would flip $P$ and give $\theta<0$.
- **Proved of it.** `WCPm_isWeylOp` (linear, skew, self-adjoint, first Bianchi, Ricci-flat at $m\ge1$), `WCPm_critical`, `normSq_WCPm` ($12m(m^2-1)/(2m-1)$), `Pcubic_WCPm` ($P=(2m+2)\lVert W\rVert^2$, from `Pcubic_eq_innerOp_Qop` and `innerOp_Qop_of_critical`), `thetaSq_WCPm`.
- **Check at $m=2$.** Spectrum $(4,-2,-2,0,0,0)$ (file header), $\sum\lambda^2=24=$ `normSq_WCPm` at $m=2$, $P=6\cdot24=144$, $\theta=144/24^{3/2}=\sqrt{3/2}$.

## Attack line 2: `cp_theta` and the Einstein-½ reading

- **The identity.** With $N=12m(m^2-1)/(2m-1)$, $\theta=P/\lVert W\rVert^3=(2m+2)N/N^{3/2}=2(m+1)/\sqrt N$. And $N/(4(m+1))^2=\frac{12m(m-1)}{16(m+1)(2m-1)}=\frac{3m(m-1)}{4(m+1)(2m-1)}=\texttt{cpNormSq}\,m$, so $(1/2)/\sqrt{\texttt{cpNormSq}\,m}=2(m+1)/\sqrt N$. The Lean proof does exactly this (`hcp`, `hsq`, then `Pcubic_WCPm`, `normSq_WCPm`), with `theta` unfolded as `Pcubic R / norm R ^ 3` ([WeylReal.lean:180](../lean/HamiltonsCubic/Base/WeylReal.lean#L180)).
- **The reading is the record's.** L46 in [results.md](../results.md) gives $Q(W)=\lambda W$ and $\theta=\lambda/\lVert W\rVert$, so at $\lambda=\tfrac12$, $\theta=(1/2)/\lVert W\rVert$, and `theta_le_of_floor` in [L47Statement.lean](../lean/HamiltonsCubic/Results/L47Statement.lean) takes $\theta$ in that form.
- **The identification is legitimate.** $Q$ is quadratic, so $W'=cW$ with $c=1/(4(m+1))$ has $Q(W')=c^2(2m+2)W=\tfrac12W'$: Einstein constant $\tfrac12$ by L46. For any critical operator with value $t$, $P=\langle W,Q(W)\rangle=t\lVert W\rVert^2$ in the layer's own inner product, so $\theta(W')=\tfrac12/\lVert W'\rVert$ and $\lVert W'\rVert^2=1/(4\theta(W')^2)=1/(4\theta(W)^2)=\texttt{cpNormSq}\,m$. The norm is the layer's `normSq`, the one in which $\theta$ is defined, so no second normalisation enters.
- **Nothing beyond what is proved is claimed in Lean.** The typed statement is the $\theta$ identity. The sentence "`cpNormSq m` is $\lVert W\rVert^2$ at the Einstein-½ normalisation" is in the docstring and the row, attributed to scale invariance and L46.
- **O1.** That sentence is composable in the layer as it stands: `normSq (c • WCPm) = cpNormSq m` and `IsCritical (c • WCPm) (1/2)` at $c=1/(4(m+1))$ follow from `normSq_WCPm`, `WCPm_critical` and the homogeneity of `normSq` and of `IsCritical`'s two sides. Typing it would make the row's second clause a theorem. Not a defect, since the row names the step it reads.

## Attack line 3: `cp_theta_le`, duplication and consistency

- **Statement.** `theta (WCPm (m := m)) ≤ √(3/2)` at `2 ≤ m`, by `rw [← cp_theta hm]` and `theta_le_of_floor (cp_floor _)`. Correct, and sharp at $m=2$ (`cp_at_two`).
- **Consistency.** $1/(4\,\texttt{cpNormSq}\,m)=\frac{(m+1)(2m-1)}{3m(m-1)}$, which is L10's $\theta^2$ in [results.md](../results.md), L53.lean's `thetaSq`, and what `thetaSq_WCPm` gives as $P^2/\lVert W\rVert^6$. The three agree.
- **O2, partial duplication.** L10Statement already proves $\theta^2\le3/2$ on the closed form, and `thetaSq_WCPm` with $P>0$ already transports that to `WCPm`. No declaration in the layer stated `theta (WCPm ...)` before this commit (grep over lean/HamiltonsCubic for `theta (WCPm`), so `cp_theta_le` is the first statement of the bound on the operator, reached through L47's floor rather than L10's closed form. A second route to the same fact, consistent with the first.

## Attack line 4: axioms

- `python3 scripts/misc/axiom_audit.py --only L47CPm`, run in the background: "2/2 clean -- resting on the standard three alone". A screen, covering `cp_theta` and `cp_theta_le` with `WCPm_critical` beneath them.

## The row

- The L47 row says `cp_theta` proves the $\theta$ identity for `WCPm`, "so" the closed form is $\lVert W\rVert^2$ at Einstein ½, "$\theta$ being scale-invariant", and that `cp_theta_le` goes through `cp_floor`. Both match the Lean. The HP^m closed form is filed owed, which is right: the layer defines no quaternionic Weyl operator.

## What would break the claims, and where I looked

- **A sign or scale error in `WCPm`** (a negative multiple of the FS Weyl tensor, or the wrong $c_A$) would make $\theta$ negative or the closed form a different function of $m$. I derived $c_A$ from the FS scalar curvature by hand, read the sign off `WCPm_J` and `WCPm_critical`, and checked the $m=2$ spectrum against `normSq_WCPm`.
- **A norm mismatch** between the layer's `normSq` and the record's $\lVert W\rVert$ would make "`cpNormSq` is $\lVert W\rVert^2$" false while `cp_theta` stays true. The identification runs through $\theta$ in the layer's own norm, and at $m=2$ it gives $1/6$ with $\theta=\sqrt{3/2}$, the value r1690 confirmed for the unit-norm $W_{\mathbb{CP}^2}$.
- **An earlier contradictory statement** of $\theta(\mathbb{CP}^m)$ in the layer. I compared L10, L53's `thetaSq` and `thetaSq_WCPm`, and all three agree.

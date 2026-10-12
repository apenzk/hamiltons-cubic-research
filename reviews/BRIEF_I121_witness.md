# Gate 2 brief, the rotated-product witness for the small-mass node of (MG), for I121

**Cold brief. The claims are quoted verbatim from [reviews/2026-09-28b-LIT-step8-sweep.md](2026-09-28b-LIT-step8-sweep.md) as it stands at dispatch. You are asked to break them.** Verdicts per claim: CONFIRMED, PLAUSIBLE or REFUTED with corrections. **Analysis-only footing**: argue from the definitions, reading the written chain link by link; compute only to refute or to check a value, the smallest computation that does it (numpy under `sage -python`). A run of a few minutes on objects you construct is allowed; no sweeps or open-ended searches.

## Definitions

- $\mathcal W_n$: algebraic Weyl tensors as symmetric operators on $\Lambda^2\mathbb R^n$, Hilbert–Schmidt norm. $Q(R)=R^2+R^\#$, $P(W)=\langle Q(W),W\rangle$. A unit critical point has $Q(W)=\rho W$.
- In an orthonormal frame $\{e_i\}$: the **diagonal part** keeps the entries $W(e_i\wedge e_j,e_i\wedge e_j)$, the **pair part** the entries $W(e_a\wedge e_c,e_b\wedge e_c)$ with $a,b,c$ distinct, the **four-set part** the entries with four distinct indices. $t^2$ is the diagonal part's squared norm at unit $W$. The **pair-free subspace** is where the pair part vanishes.
- The balanced product: $n=2m$, $\mathbb R^n=P\oplus Q'$ with orthonormal bases $e_{p_1},\dots,e_{p_m}$ and $e_{q_1},\dots,e_{q_m}$, and $e$ the unit Weyl tensor of $S^m\times S^m$ in that frame, a critical point with value $\theta_0(n)$. Every rotation of it is a critical point with the same value.
- **(MG)**: at a unit global maximiser, in a frame globally maximising $t$, $\rho\le\max\{\sqrt{3/2},P(A)/\lVert A\rVert^3\}$, $A$ the diagonal part.

## The claims

- **The exact witness** ([check_I121_rotated_product.py](../scripts/misc/check_I121_rotated_product.py), a checked object, derived here, unreviewed). Rotate the balanced product $e$ of $S^m\times S^m$ by $\tfrac\pi4$ in the $m$ planes $(p_k,q_k)$ pairing the two factors. The result is critical with value $\theta_0(n)$, has **pair part exactly $0$** (to $10^{-31}$ at $n=8,12$) and **diagonal mass $t^2=\tfrac1n$** ($\tfrac18$ and $\tfrac1{12}$). *At other angles the pair part is nonzero.*
- **Proof of the witness (derived here, unreviewed).** In the product frame $e=\alpha(\Pi_{\Lambda^2P}+\Pi_{\Lambda^2Q'})+\beta\Pi_{P\otimes Q'}$ with $\alpha=\tfrac{m(m-1)}N$, $\beta=-\tfrac{(m-1)^2}N$, $N=(n-1)(n-2)$. The rotation sends the factors to $P'=\operatorname{span}\{u_k\}$, $Q''=\operatorname{span}\{v_k\}$, $u_k=\tfrac{e_{p_k}+e_{q_k}}{\sqrt2}$, $v_k=\tfrac{-e_{p_k}+e_{q_k}}{\sqrt2}$, so $g\cdot e=\beta\,I+(\alpha-\beta)(\Pi_{\Lambda^2P'}+\Pi_{\Lambda^2Q''})$. Each $e_a$ has $u$-coordinate $\tfrac1{\sqrt2}\delta_{k(a)}$ and $v$-coordinate $\tfrac{\sigma_a}{\sqrt2}\delta_{k(a)}$, $\sigma=-1$ on $P$ and $+1$ on $Q'$, so $\langle(\Pi_{\Lambda^2P'}+\Pi_{\Lambda^2Q''})\,e_a\wedge e_c,\,e_b\wedge e_d\rangle$ is a sum of two $2\times2$ Gram determinants. **Diagonal**: $e_{p_k}\wedge e_{q_k}=u_k\wedge v_k$ has entry $\beta$, every other pair has half its mass in $\Lambda^2P'\oplus\Lambda^2Q''$ and entry $\tfrac{\alpha+\beta}2=\tfrac{m-1}{2N}$, so $t^2=\dfrac{m\beta^2+(\binom n2-m)\big(\tfrac{\alpha+\beta}2\big)^2}{m(m-1)\alpha^2+m^2\beta^2}=\dfrac{m-\tfrac12}{m(2m-1)}=\dfrac1n$. **Pair part**: at $(a,c;b,c)$, $a\ne b$, the entry is $(\alpha-\beta)\cdot\tfrac14(1+\sigma_a\sigma_b)\big(\delta_{k(a)k(b)}-\delta_{k(a)k(c)}\delta_{k(c)k(b)}\big)$, which vanishes: if $k(a)=k(b)$ then $\{a,b\}=\{p_k,q_k\}$ and $\sigma_a\sigma_b=-1$, and otherwise both deltas vanish. $\square$
- **What it settles.** A critical point at the maximal value sits in the pair-free subspace at $t=n^{-1/2}$, the four-set route's own scale. **So no bound built from criticality and the sign-character sectors alone can separate small diagonal mass from the maximiser**, and the screen's near-rotated product at $t=0.3$ was this object's neighbour. What excludes it is the maximal frame: the finite-angle inequality at the inverse matching rotation restores $t=1$. *So the global frame-maximality inequality the node needs must see multi-plane rotations adapted to $W$ itself, of which the matching rotation is the example.*

## The Lean table

| claim | declaration | what it covers |
|---|---|---|
| the witness's diagonal and pair parts | none: a coordinate computation, checked numerically to $10^{-31}$ at $n=8,12$; check the hand proof | |
| $t^2=\tfrac1n$ | none: arithmetic on $\alpha,\beta$; check it, including the values of $\alpha,\beta$ and the norm | |
| what it settles | none: an argument about which bounds can separate small $t$; check its reach | |

## What to attack

1. The rotated operator's form $g\cdot e=\beta I+(\alpha-\beta)(\Pi_{\Lambda^2P'}+\Pi_{\Lambda^2Q''})$ and the values $\alpha,\beta$: is $e$ block-scalar in its frame with these values, and does the identity term's appearance matter for Weylness?
2. The diagonal entries ($\beta$ on $(p_k,q_k)$, $\tfrac{\alpha+\beta}2$ elsewhere) and the arithmetic giving $t^2=\tfrac1n$.
3. The pair entries: the Gram-determinant formula, the factor $\tfrac14(1+\sigma_a\sigma_b)(\delta_{k(a)k(b)}-\delta_{k(a)k(c)}\delta_{k(c)k(b)})$, and that it vanishes in every case.
4. **What it settles**: that no bound built from criticality and the sign-character sectors alone can separate small diagonal mass from the maximiser. Is this the right conclusion from one object at $t=n^{-1/2}$? What exactly does it rule out, and what does it leave (for instance bounds that use the maximal frame, or smaller $t$)?
5. That the finite-angle inequality at the inverse matching rotation excludes this witness from being in its maximal frame.

# REVIEW r1833, the rotated-product witness for I121

Brief: [BRIEF_I121_witness.md](BRIEF_I121_witness.md). Source: [2026-09-28b-LIT-step8-sweep.md](2026-09-28b-LIT-step8-sweep.md), Batch 4. Log: [agent_logs/r1833-i121-witness.log](../agent_logs/r1833-i121-witness.log). Screen script: [scripts/reviewers/r1833_frame_screen.py](../scripts/reviewers/r1833_frame_screen.py) (seconds, `sage -python r1833_frame_screen.py 4 6`).

**Verdict: the witness and its hand proof are correct. The conclusion drawn from it holds, with two scoping corrections: a local fourth-order frame condition already excludes the witness, so the finite-angle or global inequality is sufficient but the witness does not show it is needed.**

| # | claim | verdict |
|---|---|---|
| 1 | rotated operator form, values of alpha and beta | CONFIRMED, with a normalisation note |
| 2 | diagonal entries and t^2 = 1/n | CONFIRMED |
| 3 | pair part vanishes, and is nonzero at other angles | CONFIRMED, with the exact angle law |
| 4 | what it settles | PLAUSIBLE, with scoping corrections |
| 5 | inverse matching rotation restores t = 1 | CONFIRMED, with a correction on what is needed to exclude the witness |

## 1. The operator form and alpha, beta

- $S^m\times S^m$ has curvature operator $\Pi_{\Lambda^2P}+\Pi_{\Lambda^2Q'}$ and is Einstein with scalar curvature $n(m-1)$, so its Weyl operator is that minus $\tfrac{m-1}{n-1}I$. This gives $\tfrac m{n-1}$ on $\Lambda^2P\oplus\Lambda^2Q'$ and $-\tfrac{m-1}{n-1}$ on $P\otimes Q'$, ratio $-\tfrac m{m-1}$. The brief's $\alpha=\tfrac{m(m-1)}N$, $\beta=-\tfrac{(m-1)^2}N$ have the same ratio (common factor $\tfrac{m-1}{n-2}$). It also matches `al`, `be` in [check_I121_rotated_product.py](../scripts/misc/check_I121_rotated_product.py) at $p=q=m$.
- **Normalisation note.** With these values $\lVert e\rVert^2=m(m-1)\alpha^2+m^2\beta^2=\tfrac{m^2(m-1)}{4(2m-1)}$, which is $\tfrac{12}7$ at $m=4$, so the displayed $e$ is the unit product only up to scale. The $t^2$ formula divides by this norm, so nothing downstream changes. The text should read $e\propto\alpha(\dots)+\beta\Pi_{P\otimes Q'}$.
- The rotation by $\tfrac\pi4$ in $(p_k,q_k)$ sends $e_{p_k}\mapsto u_k$, $e_{q_k}\mapsto v_k$ (matching the script's matrix, whose column $a$ is $c\,e_a+s\,e_b$). Since $I=\Pi_{\Lambda^2P'}+\Pi_{\Lambda^2Q''}+\Pi_{P'\otimes Q''}$, the form $\beta I+(\alpha-\beta)(\Pi_{\Lambda^2P'}+\Pi_{\Lambda^2Q''})$ is an identity of operators. The $I$ term is a bookkeeping device: $g\cdot e$ is Weyl because $O(n)$ preserves $\mathcal W_n$, and the rewrite changes no entry. Criticality with value $\theta_0$ follows from $O(n)$-equivariance of $Q$.

## 2. Diagonal entries and t^2

- $\langle\Lambda^2(\pi_U)\,x\wedge y,z\wedge w\rangle$ is the $2\times2$ Gram determinant of the projected vectors. With $\langle\pi_{P'}e_a,e_b\rangle=\tfrac12\delta_{k(a)k(b)}$ and $\langle\pi_{Q''}e_a,e_b\rangle=\tfrac{\sigma_a\sigma_b}2\delta_{k(a)k(b)}$, the diagonal entry at $e_a\wedge e_c$ is $\beta+(\alpha-\beta)\tfrac12(1-\delta_{k(a)k(c)})$. This is $\beta$ on the $m$ matching pairs and $\tfrac{\alpha+\beta}2=\tfrac{m-1}{2N}$ on the other $\binom n2-m=2m(m-1)$ pairs.
- Numerator $m\beta^2+2m(m-1)\tfrac{(m-1)^2}{4N^2}=\tfrac{m(m-1)^3(m-\frac12)}{N^2}$, denominator $\tfrac{m^2(m-1)^3(2m-1)}{N^2}$, ratio $\tfrac1{2m}=\tfrac1n$. Every step of the brief's arithmetic checks. Reproduced numerically at $n=8,12$ in the screen script.

## 3. The pair part

- At $(a,c;b,c)$ with $a\ne b$ the $\beta I$ term contributes $0$. The $P'$ determinant is $\tfrac14(\delta_{ab}-\delta_{ac}\delta_{cb})$ and the $Q''$ determinant is $\tfrac14\sigma_a\sigma_b\sigma_c^2(\delta_{ab}-\delta_{ac}\delta_{cb})$ (writing $\delta_{xy}$ for $\delta_{k(x)k(y)}$), so the entry is $(\alpha-\beta)\tfrac14(1+\sigma_a\sigma_b)(\delta_{ab}-\delta_{ac}\delta_{cb})$ as claimed. The case split is complete: $k(a)=k(b)$ with $a\ne b$ forces $\{a,b\}=\{p_k,q_k\}$ and $\sigma_a\sigma_b=-1$, and otherwise $\delta_{ab}=0$ and $\delta_{ac}\delta_{cb}=1$ would force $k(a)=k(b)$.
- **Other angles, made exact.** At rotation angle $\theta$ in every matching plane the entry at $(p_k,p_j;q_k,p_j)$, $j\ne k$, is $(\alpha-\beta)\cos\theta\sin\theta(\cos^2\theta-\sin^2\theta)=\tfrac14(\alpha-\beta)\sin4\theta$. The pair part therefore vanishes exactly at $\theta\in\tfrac\pi4\mathbb Z$ (the product frame $\theta=0$ trivially, the witness at $\tfrac\pi4$) and is nonzero at every other angle, which confirms the italic sentence.

## 4. What it settles

The inference is sound in the form: no argument whose hypotheses are criticality, value $\theta_0(n)$, pair-freeness and the sign-character decomposition in a fixed frame can conclude $t^2>\tfrac1n$. Corrections to its reach:

- **"At the maximal value" is conditional.** $\theta_0(n)$ is the maximum only if Conjecture A holds. The argument still stands, because a proof of Conjecture A must hold in the world where it is true, where the witness is a global maximiser. The sentence should say "at the value $\theta_0(n)$, a global maximiser if Conjecture A holds".
- **It rules out only thresholds above $n^{-1/2}$.** A sector bound of the form $t\ge c\,n^{-1/2}$ with $c\le1$ is untouched, and nothing here says whether pair-free critical points at value $\theta_0$ exist below $t=n^{-1/2}$.
- **"The screen's near-rotated product at $t=0.3$ was this object's neighbour"** is PLAUSIBLE only: $n^{-1/2}=0.2887$ at $n=12$ and the recorded spectrum distance $0.012$ fit, but no distance from the screen's operator to an $O(n)$-orbit point of the witness is recorded.
- **"The global frame-maximality inequality the node needs must see multi-plane rotations"**: the multi-plane half is confirmed by screen (section 5), the "global" half is overstated for this witness.

## 5. The inverse matching rotation, and what excludes the witness

- $g^{-1}\cdot(g\cdot e)=e$ is diagonal in the standard frame, so the inverse matching rotation gives $t=1>n^{-1/2}$ and the witness frame is not maximal. CONFIRMED (and immediate).
- **Screen of the local frame conditions** ([r1833_frame_screen.py](../scripts/reviewers/r1833_frame_screen.py), $n=8,12$, seconds): at the witness frame the gradient of $t^2$ over $\mathfrak{so}(n)$ is $0$ and its Hessian is negative semidefinite (largest eigenvalue $0$, smallest $-0.583$ at $n=8$, $-0.244$ at $n=12$). **So first- and second-order frame maximality do not exclude the witness.** Single-plane rotations of all three types (matching, within a factor, cross non-matching) never raise $t^2$ above $\tfrac1n$ at any angle on a 181-point grid.
- **Along the joint matching direction $t^2$ rises at fourth order.** Rotating all $m$ matching planes by $\varphi$ from the witness frame, the values fit $t^2(\varphi)=\tfrac1n+(1-\tfrac1n)\sin^4 2\varphi$: the fourth-order coefficient is $16(1-\tfrac1n)$ to three digits at $n=6,8,12$, and the formula matches at $\varphi=0.4$, $n=8$ to five digits. This fit is a screen, not a proof.
- **Correction.** The witness frame fails to be a local maximum of $t$ at fourth order. A local fourth-order frame condition in the joint multi-plane direction already excludes it, so the finite-angle inequality at $\tfrac\pi4$ is sufficient but this witness does not show that a global or finite-angle inequality is necessary. The supported statement is: the frame condition the node needs must reach fourth order and must see simultaneous rotations in several planes adapted to $W$. Whether other small-$t$ obstructions force a genuinely global inequality is open.

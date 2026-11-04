# REVIEW r1904: I123 second attempt, the Ricci-free extension (Gate 2)

Log: [agent_logs/r1904-i123-ricci-free.log](../agent_logs/r1904-i123-ricci-free.log). Section under review: [2026-09-28o-I123-coupling.md](2026-09-28o-I123-coupling.md), "Second attempt" and "Where the coupling stands". Analysis-only footing: every number below is either derived by hand or labelled a screen.

**Verdict: the counterexample to P$^+$ is CONFIRMED, derived by hand end to end. The closing sentence overreaches: "no lift that relaxes either can carry it" and "closes the lifting approach" are proved only for the $O(n)$-invariant linear enlargements of the Weyl subspace with the same functional and the same constant.**

| # | claim | verdict |
|---|---|---|
| 1 | the space, and the L181 reading | CONFIRMED (the space); the L181 gloss PLAUSIBLE, better cited as L183 |
| 2 | the Hessian split | CONFIRMED, and it strengthens to a genuine local maximum |
| 3 | the screen values | CONFIRMED as a screen (all three block tops reproduced by an independent build; the $S^4\times S^8$ top also derived exactly) |
| 4 | the $P_\pm$ products, the cubic and the norm | CONFIRMED term by term |
| 5 | the plane, the value, $\theta_0(12)$ | CONFIRMED |
| 6 | the conclusion | PLAUSIBLE only in a narrowed form; as written, overreach |
| 7 | the Lean | CONFIRMED for what it types; the table's scope is accurate |

## 1. The space

- $\mathop{\mathrm{Sym}}^2\Lambda^2=\mathcal B\oplus\Lambda^4$ with $\mathcal B$ the Bianchi (algebraic curvature) operators, orthogonally. The Ricci contraction $R_{ikjk}$ kills $\Lambda^4$ (a contraction of a totally antisymmetric tensor). On $\mathcal B=\mathrm{Weyl}\oplus\mathrm{Ric}_0\oplus\mathbb R$ it has kernel exactly Weyl, since $h\mapsto\mathrm{Ric}(h\owedge g)=(n-2)h+(\mathop{\mathrm{tr}}h)g$ is injective for $n\ge3$. So the kernel on $\mathop{\mathrm{Sym}}^2\Lambda^2$ is $\mathrm{Weyl}\oplus\Lambda^4$. Confirmed.
- The L181 gloss. L181's matrix $M^{\mathsf T}\Lambda M$ exists only for the simultaneously block-diagonal family, where Ricci fixes the diagonal and Bianchi the off-diagonal. As a statement about all of $\mathop{\mathrm{Sym}}^2\Lambda^2$, the accurate reference is [L183](../findings/diagonal-half.md): with $X=\sum\lambda_i\omega_i\omega_i^{\mathsf T}$, Ricci is $\sum\lambda_i\omega_i^2$ and the $\Lambda^4$ component is $\sum\lambda_i\,\omega_i\wedge\omega_i$. "Keeps the Ricci condition, drops Bianchi" is then exact. Correction: cite L183 for the general statement, L181 as its block-diagonal instance.

## 2. The Hessian split

- On the unit great circle $X(s)=\cos s\,W_0+\sin s\,V$: $G=\cos^3s\,\theta_0+3\cos^2s\sin s\,T(W_0,W_0,V)+3\cos s\sin^2s\,T(W_0,V,V)+\sin^3s\,G(V)$, and $T(W_0,W_0,V)=\langle Q(W_0),V\rangle=\theta_0\langle W_0,V\rangle=0$. The second derivative at $0$ is $6T(W_0,V,V)-3\theta_0$. Confirmed.
- $T(X,Y,Z)=\langle B(X,Y),Z\rangle$ follows from $\nabla G=3Q$ (which uses the full symmetry of $\langle A^\#B,C\rangle$). $B$ preserves Weyl because $Q$ does and $B$ is its polarisation, and $\mathrm{Weyl}\perp\Lambda^4$. Cross term zero. Confirmed.
- **Strengthening, worth recording.** The $\Lambda^4$-gradient $3\langle Q(X),Y\rangle$ vanishes at every Weyl $X$, not only at $W_0$. So $f(X_W+Y)=f(X_W)+\tfrac12\,Y^{\mathsf T}H(X_W)Y+O(\lVert Y\rVert^3)$ with $H$ continuous in $X_W$. A local maximum of P on the Weyl sphere plus a negative definite $\Lambda^4$ block is then a local maximum on the Ricci-free sphere, with no second-order degeneracy issue in the Weyl directions. "Survives at the balanced product" holds in this sense.
- The comparison constant is each product's own $\theta$ ($0.61412=1.228239/2$, $0.60078=1.201561/2$), which is the right one at a non-balanced critical point. Correct.

## 3. The screen values (screen, not evidence)

- Independent build: so(12) in the $e_i\wedge e_j$ basis, $W^\#Y=\tfrac12\sum w_k\,\mathrm{ad}_{e_k}Y\mathrm{ad}_{e_k}^{\mathsf T}$ for diagonal $W$, $I^\#I=10I$ checked, $Q(W)=\theta W$ checked at each product, the 495 normalised $\Lambda^4$ basis elements, the form $K_{kl}=\langle\tfrac12(WY_k+Y_kW)+W^\#Y_k,Y_l\rangle$ (symmetric to machine precision).
- Tops: $0.4045199$ at $S^6\times S^6$ ($\theta=1.2360331$), $0.5862051$ at $S^5\times S^7$ ($1.2282392$), $0.8738629$ at $S^4\times S^8$ ($1.2015615$). All three match the note.
- **Exact value of the $S^4\times S^8$ direction**, from row 5's cubic: the $t^2$ coefficient $-144c$ equals $3T(W,\star,\star)$, and with $\lVert\star\rVert^2=6$ and $c=-\sqrt{21/1760}$ at unit $W$, $T(W,\hat\star,\hat\star)=8\sqrt{21/1760}=0.873863$. That the volume form is the top eigenvector is only a screen.
- Not checked: padded $W_{\mathbb{CP}^2}$ ($0.40825$). It carries no weight in the argument.

## 4. The products, the cubic, the norm

- Normalisation: the given $P_{\mathfrak{so}(p)}^\#P_{\mathrm{mix}}=\tfrac{p-1}2P_{\mathrm{mix}}$ forces the L265 $v_i$ to be the $e_a\wedge e_b$ acting on $\mathbb R^n$ as $E_{ab}-E_{ba}$ (then $\sum v_iv_i^{\mathsf T}=(p-1)I_p$).
- **$P_\pm^\#P_{\mathrm{mix}}$, derived directly.** An orthonormal basis of $\Lambda^2_\pm\mathbb R^4$ is $J/\sqrt2$ for three complex structures $J$ of the matching orientation, $JJ^{\mathsf T}=I_4$. On $\mathrm{mix}=\mathbb R^4\otimes\mathbb R^8$, $\mathrm{ad}_v$ acts as $v\otimes1$, so $P_\pm^\#P_{\mathrm{mix}}=\tfrac12\sum_{J}\tfrac12JJ^{\mathsf T}\otimes1=\tfrac34P_{\mathrm{mix}}$. Confirmed, with no appeal to orientation reversal.
- $P_\pm^\#P_\pm=2P_\pm$: $\mathrm{ad}_v$ for $v\in\Lambda^2_+$ kills $\Lambda^2_-$, so $P_+^\#P_-=0$, and $P_+^\#P_+$ lives on $\Lambda^2_+$ and is $SO(3)$-invariant there. $I^\#I=2I$ on $\mathfrak{so}(4)$ then gives $2P_\pm$. $P_\pm^\#P_{\mathfrak{so}(8)}=0$ by the same kernel argument.
- The screen code also checks $P_+^\#P_{\mathrm{mix}}=\tfrac34P_{\mathrm{mix}}$ and $P_+^\#P_+=2P_+$ with the eigen-decomposition form of L265 (screen).
- $X^\#X=(2\alpha^2+8c^2)P_++(2\beta^2+8c^2)P_-+(6b^2+4c^2)P_{\mathfrak{so}(8)}+\big(\tfrac32(\alpha+\beta)c+7bc\big)P_{\mathrm{mix}}$. With dimensions $3,3,28,32$: $\mathop{\mathrm{tr}}X^3=3\alpha^3+3\beta^3+28b^3+32c^3$ and $\langle X^\#X,X\rangle=6\alpha^3+6\beta^3+168b^3+24(\alpha+\beta)c^2+112bc^2+48(\alpha+\beta)c^2+224bc^2$. Sum: $9,9,196,32,72,336$. Matches the displayed $G$. The norm $3\alpha^2+3\beta^2+28b^2+32c^2$ matches.
- Cross-check: setting $\alpha=\beta=a$ reproduces the $O(4)\times O(8)$ cubic $18a^3+196b^3+32c^3+144ac^2+336bc^2$ built from the given table.

## 5. The plane and the value

- $\star=P_+-P_-$ is the Hodge star on $\Lambda^2\mathbb R^4$, the operator of $e_{1234}$, totally antisymmetric: a $\Lambda^4$ element. Writing $\alpha P_++\beta P_-=\tfrac{\alpha+\beta}2P_{\mathfrak{so}(4)}+\tfrac{\alpha-\beta}2\star$, the Ricci of the family is that of the $O(4)\times O(8)$ part, zero exactly on the given Weyl line $\tfrac{\alpha+\beta}2=-\tfrac83c$, $b=-\tfrac47c$. So the plane is exactly the Ricci-free part of the four-parameter family. Confirmed (and in the screen the witness has Ricci $\sim10^{-15}$ and violates Bianchi, as it must).
- On the plane: $9(\alpha^3+\beta^3)=-\tfrac{1024}3c^3-144ct^2$, $196b^3=-\tfrac{256}7c^3$, $72(\alpha+\beta)c^2=-384c^3$, $336bc^2=-192c^3$, plus $32c^3$: $-\tfrac{19360}{21}c^3-144ct^2$. Norm $\tfrac{128}3+\tfrac{64}7+32=\tfrac{1760}{21}$, plus $6t^2$. Confirmed.
- At $c=-1$, $u=t^2$: stationarity of $(A+144u)^2/(B+6u)^3$ gives $16(B+6u)=A+144u$, $u=\tfrac{16B-A}{48}=\tfrac{550}{63}=\tfrac{3850}{441}$. There $G=\tfrac{137280}{63}$, $N=\tfrac{8580}{63}$, $G/N=16$, and $f^2=\tfrac{256\cdot63}{8580}=\tfrac{1344}{715}=\big(\tfrac{8\sqrt{15015}}{715}\big)^2$, $f=1.371029$. It is the maximum over $u\ge0$ (the ratio is $1.201561$ at $u=0$ and tends to $0$). The $c>0$ half has $G<0$.
- $t=0$: $f^2=\tfrac{2541}{1760}=\tfrac{2310}{1600}$. $\theta_0(12)$: the $O(6)\times O(6)$ cubic $75(a^3+b^3)+36c^3+270(a+b)c^2$ at $a=b=\tfrac65$, $c=-1$ gives $G=871.2$, $N=79.2$, $f^2=\tfrac{121}{79.2}=\tfrac{55}{36}$. Confirmed. The excess is $1.1092$, the stated $11\%$.

## 6. The conclusion

- **What is established.** $\mathop{\mathrm{Sym}}^2\Lambda^2=\mathrm{Weyl}\oplus\mathrm{Ric}_0\oplus\mathbb R\oplus\Lambda^4$ has four pairwise non-isomorphic $O(n)$-irreducible summands ($\Lambda^4$ stays $O(n)$-irreducible at $n=8$). So the $O(n)$-invariant linear subspaces containing Weyl are Weyl plus any subset of the other three, and each of the seven proper enlargements contains one of the three tested. With the same functional $G/\lVert\cdot\rVert^3$ and the same constant $\theta_0(n)$, every invariant enlargement fails at $n=12$. This is the argument the section needs and does not write down.
- **What is not established.** "No lift that relaxes either can carry it" and "This closes the lifting approach" cover more than that:
  - a lift with a changed functional, for instance a weighted norm $\lVert X_W\rVert^2+\kappa\lVert X_{\Lambda^4}\rVert^2$ or a bound $\theta_0\lVert X\rVert^3+(\text{penalty in the relaxed component})$. At the witness the $\Lambda^4$ part is large ($6t^2=52.4$ against $83.8$ on the Weyl part), so a modest penalty may restore the bound;
  - a non-invariant or nonlinear enlargement, such as a cone or a subvariety through Weyl;
  - other $n$ for the $\Lambda^4$ direction, shown only at $n=12$ (the Ricci direction is shown at every even $n$). A dimension-dependent lift is not excluded at $n\ne12$.
- The inference "a coupling must use both Weyl conditions at once" holds only in that narrowed sense.
- **Correction.** Replace the last two sentences with: every $O(n)$-invariant linear enlargement of the Weyl subspace in $\mathop{\mathrm{Sym}}^2\Lambda^2$, with P's functional and constant, fails (at $n=12$ for those containing $\Lambda^4$, at every even $n$ for those containing $\mathrm{Ric}_0$, at every $n$ for those containing $I$). Lifts that change the functional or the constant stay untested. Add the one-paragraph irreducibility count that makes the three tests exhaustive.

## 7. The Lean

- `#print axioms` on all four: `[propext, Classical.choice, Quot.sound]` only. No `sorry`, no project axioms.
- `G` and `N` are definitions and match the displayed cubic and norm symbol for symbol. `G_plane` and `N_plane` restate row 5's plane formulas and close by `ring`.
- `ricci_free_beats` states, for any real $t$ with $t^2=\tfrac{3850}{441}$, $0<G$ and $\tfrac{55}{36}N^3<G^2$ at $c=-1$. Together these give $G/N^{3/2}>\sqrt{55}/6$, which is the claim the table assigns it.
- What stays prose, as the table and the module docstring both say: the cubic from the $\#$ table (the load-bearing step, confirmed by hand in row 4), the exact value $\tfrac{8\sqrt{15015}}{715}$, and that the witness is a Ricci-free operator.
- `scalar_flat_beats` is the trivial $\tfrac{55}{36}<\tfrac{120}{77}$. It belongs to the first attempt's traceless value; its listing under this section is harmless.

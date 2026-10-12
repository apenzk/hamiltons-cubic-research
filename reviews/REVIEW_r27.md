### Reviewer 27: the second-order criterion, its localization, and the rank-two bound

**The criterion holds and the gate's direction survives; two of the framings around it do not.** Fourteen independent scripts built from the definitions ([review_r27_core.py](scripts/review_r27_core.py) and dependents; report in [review_r27_report.md](agent_logs/review_r27_report.md)).

**CONFIRMED, the criterion.** The Hessian of $P$ constrained to the unit sphere is $6\theta(L_e-\tfrac12\mathrm{Id})$, verified through the geodesic second derivative to $10^{-10}$, so a maximizer satisfies $\lambda_{\max}(L_e|_{W^\perp})\le\tfrac12$. The hypothesis $\theta>0$ is needed: at $\mathfrak u(2)\subset\mathfrak{so}(4)$, $\theta=-0.866$ and the inequality reverses.

**CONFIRMED, the direction gate G needs.** Every ungraded point violates, and the sweep is far wider than the original: 155 converged critical points at $n=6$, all ungraded, together with every structured ungraded point, give $\lambda_{\max}\in[1.17,\,96.3]$, and **not one** has $\lambda_{\max}\le\tfrac12$.

**REFUTED, "graded points do not violate".** Two families of graded violators exist. $S^2\times S^{n-2}$, the symmetric pair $\mathfrak{so}(2)\oplus\mathfrak{so}(n-2)$, is exactly critical with $S_{\mathfrak{mmm}}=0$ and $\lambda_{\max}=\tfrac12+\tfrac1{2(n-3)}$ exactly at $n=5\ldots12$, with the explicit eigenvector $v=2\varphi_{12}\odot\varphi_{ab}+(\varphi_{1a}\odot\varphi_{2b}-\varphi_{1b}\odot\varphi_{2a})$. And $\mathfrak u(m)\subset\mathfrak{so}(2m)$ gives $\lambda_{\max}=\tfrac{m+2}{2(m+1)}$, whose $m=3$ member is $W_{\mathbb{CP}^3}$, graded, at $\theta=\theta_0(6)$ exactly, and not even a local maximizer.

**Why the earlier reading looked clean.** $\lambda_{\max}\ge\tfrac12$ holds at **every** critical point, because orbit directions are exact $\tfrac12$-eigenvectors ($3\times10^{-16}$). So "graded points sit at $\tfrac12$" says only that they attain a universal floor. The criterion detects **non-maximality, not gradedness**, and every graded point tested earlier was $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ with $p,q\ge3$, exactly the ones that pass. The violators all carry a simple top eigenvalue of $W$, a distinguished $2$-form.

**Consequence.** Any construction aiming at an equivalence (a violating direction exists **iff** $S>0$), is now known impossible. Gate G's one-directional target is untouched.

**REFUTED, the localization to $\mathrm{Sym}^2(\mathfrak m)$.** That subspace, intersected with the Weyl space and $W^\perp$, is strictly negative: $-\tfrac14$, $-\tfrac34$, $-\tfrac13$ at the three points. The measured $\tfrac34$ and $\tfrac13$ belong to the **even part** $\mathrm{Sym}^2(\mathfrak h)\oplus\mathrm{Sym}^2(\mathfrak m)$, whose odd complement sits at exactly $\tfrac12$ everywhere; and even that repair fails at $\mathfrak{so}(3)\subset\mathfrak{so}(5)$.

**CONFIRMED, the rank-two impossibility, with two corrections.** The formula $R(x,y)=\alpha-\tfrac12(\beta|z_{\mathfrak h}|^2+\alpha|z_{\mathfrak m}|^2)$, the factor $\tfrac14$ in $\langle v,e^\#v\rangle=-\tfrac14\langle z,ez\rangle$ and $\alpha=-1/(n-1)$ are all exact, and $\sup\|[x,y]\|^2=2$ **is** attained on $\mathfrak m$. But "$\alpha(1-C/2)=0$" holds only because $C=2$ exactly, and $v=x\odot y$ does not lie in the Weyl space, projecting changes every value. It lowers them, so the conclusion stands, but the derivation as written was about the wrong object.

**CONFIRMED, the $d_{abc}$ identification**, and its non-generality is stronger than claimed.

**On the basis artifact.** Orthonormality is clean under the $\sqrt2$-scaled vectorization, Gram error $\le2\times10^{-15}$, and the graded values come out $0.500000000000001$, so the earlier $0.5303$ was indeed a basis artifact and nothing more.

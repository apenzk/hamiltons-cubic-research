# REVIEW r909: does F66 correctly close the moment-map route (R22)?

Log: agent_logs/review-r909-f66.log

Standfirst: this round checks a route-closing argument, the [F66](../findings/fence-posts.md) claim that the two named actions both give a trivial or degenerate moment map on the Weyl module, so no two Weyl tensors are separated by a moment map and [R22](../routes.md) is dead. I read the F66 post and the [R22 row](../routes.md), the Kempf-Ness definition supplied in the brief, and the [IsWeyl](../lean/HamiltonsCubic/Base/WeylReal.lean) definition the post cites. I derived the $GL_n$ moment map from the infinitesimal action and the definition of $\mathop{\mathrm{Ric}}$, and I ran a closed-form check at $n=4$ and a flatness screen at $n=4,5,6,7$ on explicit Weyl tensors I constructed (seconds of compute, objects in hand). Skeleton committed first, rows overwritten one per phase.

| # | Item | Verdict | Reason |
|---|------|---------|--------|
| 1 | $SO(n)$ half | SOUND | compact isometric action gives $\mathfrak p=0$, and the skew momentum $\langle X\cdot W,W\rangle$ vanishes identically, so there is genuinely no separation |
| 2 | $GL_n$ half, derived | REFUTED | the moment map is $-4$ times the quadratic Gram contraction $A_{pi}=\sum_{jkl}W_{pjkl}W_{ijkl}$, not the linear Ricci contraction, and Ricci is not $GL_n$-equivariant |
| 3 | zero-fibre load-bearing | REFUTED | the zero fibre is $\{0\}$ for $GL_n$ and $\{A\propto I\}$ for $SL_n$, and $\mathcal W_n$ equals neither, so for $n\ge5$ the moment map varies over $\mathcal W_n$, so the rivals do not agree by construction |
| 4 | degree/dimension argument | SOUND CORE, LOOSE FRAMING | the cubic-criticality vs quadratic-moment-zero type mismatch is correct and robust, and $\dim\mathcal W_n=\binom n2$ has no solution for $n\ge4$, while the "$\mathcal W_n\cong\mathfrak g$" phrasing is a strawman that does not affect the conclusion |
| 5 | third action | NUANCED | Route B on the structure tensor is a genuinely different object, correctly labelled, but the standard $SL_n$ action on curvature tensors is itself a natural action whose moment map is not flat on $\mathcal W_{n\ge5}$, against the post |
| 6 | reach of the closure | OVERREACH IN JUSTIFICATION | the conclusion that R22 is dead is correct, but the stated reason is wrong and the successor instruction "it is flat on $\mathcal W_n$" is false for $n\ge5$ |

Summary: R22 is correctly closed in outcome, but F66's argument is wrong in two of its three load-bearing steps and must be rewritten around the robust reason.

## 1. The $SO(n)$ half

Sound. $SO(n)$ is compact and acts on $\mathcal W_n$ by isometries. In the Kempf-Ness Cartan decomposition of a compact group the noncompact part is $\mathfrak p=0$, so the moment map $m:\mathcal W_n\to\mathfrak p$ is trivially zero and every vector minimises the norm on its orbit, since the orbit lies on a sphere of constant radius. There is no orbit separation by norm minimisation.

I also checked the refined possibility the brief raises, that a compact momentum valued in $\mathfrak{so}(n)^*$ carries information the claim ignores. For skew $X\in\mathfrak{so}(n)$ the isometry property gives $\tfrac{d}{dt}\lVert e^{tX}W\rVert^2=2\langle X\cdot W,W\rangle=0$, so the real quadratic momentum $\langle X\cdot W,W\rangle$ is identically zero on every $W$. It carries nothing. A genuine symplectic moment map would need a compatible complex or Kähler structure on $\mathcal W_n$, which is a different setup not in play. So the post's "no separation" for $SO(n)$ is correct.

## 2. The $GL_n$ half, derived

Refuted. The infinitesimal action of $X\in\mathfrak{gl}_n$ on an algebraic curvature tensor, acting on each slot of the $(0,4)$-tensor, is
$$(X\cdot W)_{ijkl}=-\big(X^p{}_i W_{pjkl}+X^p{}_j W_{ipkl}+X^p{}_k W_{ijpl}+X^p{}_l W_{ijkp}\big).$$
Pairing with $W$ under the full-contraction inner product $\langle W,W\rangle=\sum W_{ijkl}W_{ijkl}$, which is the $O(n)$-invariant product the Kempf-Ness framework requires, the four terms are equal by the pair-antisymmetry and pair-exchange symmetry of $W$, giving for symmetric $X$
$$\langle X\cdot W,W\rangle=-4\sum_{p,i}X_{pi}A_{pi},\qquad A_{pi}=\sum_{jkl}W_{pjkl}W_{ijkl}.$$
So the moment map is $m(W)=-4A(W)$, where $A(W)$ is the symmetric Gram matrix of $W$ read along its first slot. This is a quadratic function of $W$.

The Ricci contraction $\mathop{\mathrm{Ric}}(W)_{ij}=\sum_k W_{ikjk}$ is linear in $W$. A homogeneous degree-two quantity equals a constant times a homogeneous degree-one quantity only when both vanish, so the moment map is not proportional to the Ricci contraction, nor to its trace-free part, nor to any Ricci-plus-scalar combination. Two further nails. The moment map must be $GL_n$-equivariant, and $\mathop{\mathrm{Ric}}$ is only $O(n)$-equivariant because it contracts with the metric $\delta$. And the post itself writes the moment map as the quadratic $\langle X\cdot W,W\rangle$ while equating it to the linear $\langle\mathop{\mathrm{Ric}}(W),X\rangle$, which is the error in one line.

I verified the derivation at $n=4$ on an explicit Weyl tensor built as a sum of Kulkarni-Nomizu products projected to $\mathop{\mathrm{Ric}}=0$. The identity $\langle X\cdot W,W\rangle=-4\langle A,X\rangle$ held to machine precision on four random symmetric $X$, while $\langle\mathop{\mathrm{Ric}}(W),X\rangle=0$ throughout and $\langle X\cdot W,W\rangle$ was of order $10^4$. The moment map is the quadratic Gram contraction, and it does not vanish on Weyl tensors.

The likely origin of the mistake is the Lauret-Will theorem the [R22 row](../routes.md) cites, where the moment map for the $GL_n$ action on the variety of Lie brackets is a multiple of the Ricci operator. There the Ricci operator is itself quadratic in the structure constants, so the degrees match. Transported to curvature tensors, where Ricci is linear, the analogy fails on the degree.

## 3. The load-bearing step: is $\mathcal W_n$ the whole moment-map zero fibre?

Refuted, and this is the step that most damages the post. With the correct moment map $m(W)=-4A(W)$:

- For the full $GL_n$, $m(W)=0$ forces $A_{pp}=\sum_{jkl}W_{pjkl}^2=0$ for each $p$, a sum of squares, so $W=0$. Equivalently $\mathop{\mathrm{tr}}A=\lVert W\rVert^2$, which I confirmed numerically. The zero fibre is $\{0\}$, and $\mathcal W_n$ has dimension $10$ at $n=4$, so it is not contained in the fibre.
- For $SL_n$, the reductive group whose minimal vectors are meaningful because the scaling direction is removed, the moment map is the trace-free part of $-4A$, and the zero fibre is $\{A\propto I\}$. This is the condition that $W$ is isotropic in its first slot, which is not the Ricci-flat condition.

The relation of $\mathcal W_n$ to $\{A\propto I\}$ is dimension-dependent, and this is the decisive finding. At $n=4$ every Weyl tensor satisfies $A=\tfrac14\lVert W\rVert^2\,\delta$, the special four-dimensional identity $W_{ipqr}W_{jpqr}=\tfrac14\delta_{ij}\lVert W\rVert^2$, which I confirmed as $A=588.17\,I$ with $\mathop{\mathrm{tr}}A=4\times588.17=\lVert W\rVert^2$. So $\mathcal W_4$ does lie in the $SL_4$ zero fibre, but by that quadratic identity and not because $\mathop{\mathrm{Ric}}=0$. At $n=5,6,7$ the screen returned $A\not\propto I$, with off-diagonal and diagonal-spread magnitudes comparable to $\lVert W\rVert^2$. So for $n\ge5$ the moment map varies over $\mathcal W_n$, and two generic Weyl tensors sit in different fibres.

The consequence the post rests on, that the two idempotent rivals agree in the moment map by construction because both are Ricci-flat, is therefore false for $n\ge5$. Ricci-flatness places both in $\mathcal W_n$, but $\mathcal W_n$ is not a fibre of the correct moment map above dimension four.

## 4. The degree and dimension argument

Sound core, loose framing. The essential claim is correct and robust: $Q(W)=\theta W$ is the Lagrange condition for a critical point of the cubic $P$ on the unit sphere, an equation valued in $\mathcal W_n$ with a $W$-dependent multiplier, whereas a moment-map-zero condition $m(W)=0$ is valued in $\mathfrak p=\mathrm{Sym}(n)$ and is quadratic. The two are different variational problems, criticality of a cubic on a sphere against minimisation of a norm on a group orbit, so their critical sets have no reason to coincide.

The dimension check is also correct. Setting $\dim\mathcal W_n=n(n+1)(n+2)(n-3)/12$ equal to $\binom n2=n(n-1)/2$ reduces, after dividing by $n$ and clearing denominators, to $(n+1)(n+2)(n-3)=6(n-1)$. At $n=4$ the left side is $30$ against $18$, at $n=5$ it is $35$ against $10$ once written as dimensions, and the cubic left side outruns the linear right side for every $n\ge4$, so there is no solution. The dimensions are $10$ against $6$ at $n=4$ and $35$ against $10$ at $n=5$, growing apart.

The one loose point is the framing "for $Q$ to be a moment map one would need $\mathcal W_n\cong\mathfrak g$." A moment map is a map into $\mathfrak p$ and does not require the representation space to be isomorphic to the Lie algebra, so the isomorphism is a strawman. The correct statement is the degree-and-target mismatch above, which the dimension count then reinforces rather than establishes. The conclusion stands.

## 5. The third-action question

Nuanced. Route B, the moment map for $GL(\mathcal W_n)$ acting on the structure tensor of the Fox curvature algebra, is a genuinely different object. Its vector space is the multiplication tensor in $\mathcal W_n^*\otimes\mathcal W_n^*\otimes\mathcal W_n$, and the moment map is quadratic in that structure tensor in the Lauret-Will manner, which is why medial and isospectral algebras enter. It is not R22 relabelled, since R22 is the moment map of the vector $W$ itself, so the post's redirection is correct on this point.

The sharper answer to "is there a natural action whose moment map is not flat on $\mathcal W_n$" is yes, and it is the very action the post treats. The standard $SL_n$ action on curvature tensors has moment map the trace-free part of $-4A$, which for $n\ge5$ is not flat on $\mathcal W_n$. This does not rescue R22, because the maximiser equation is still cubic criticality rather than a minimal-vector condition, and because $\mathcal W_n$ is not $SL_n$-invariant, so flowing a Weyl tensor by $SL_n$ leaves the Ricci-flat locus. But it means the post's factual claim of flatness is wrong above dimension four.

## 6. The reach of the closure

The conclusion is correct, the justification is not, and the successor instruction overreaches. R22 is genuinely dead, for the robust reason that the maximiser equation $Q(W)=\theta W$ is criticality of a cubic on a sphere and not a minimal-vector condition, and that the only group acting on $\mathcal W_n$ by isometries is the compact $SO(n)$, which contributes no moment map, while every noncompact reductive group such as $GL_n$ fails to preserve $\mathcal W_n$ because Ricci-flatness is not $GL_n$-invariant. So there is no moment-map or Kempf-Ness structure on $\mathcal W_n$ whose minimal vectors are the maximisers, at any $n$.

The post reaches this conclusion through claims that are false, that the $GL_n$ moment map is the Ricci contraction and that $\mathcal W_n$ is its zero fibre, and it hands a successor the instruction "do not bring the moment map of the vector $W$ again, it is flat on $\mathcal W_n$." That instruction is false for $n\ge5$, where the $SL_n$ moment map separates Weyl tensors. A successor who checks will find the moment map is not flat and may wrongly conclude the route reopens, when the real obstruction is the cubic-criticality mismatch. The [fence-post](../findings/fence-posts.md) and the [R22 row](../routes.md) should be rewritten to close the route on the robust reason and to drop the flatness claim.

## 7. What would break it

The object that would reopen R22 is a noncompact reductive group acting on $\mathcal W_n$, preserving both the space and a structure for which the minimal-vector condition is exactly $Q(W)=\theta W$. Two facts block it. The inner product on $\mathcal W_n$ is positive definite, so its isometry group is compact and offers no $\mathfrak p$ direction. And the maximiser equation is degree three valued in $\mathcal W_n$, while a moment-map-zero condition is degree two valued in $\mathfrak p$, so no change of group alone converts one into the other. To break the closure one of these would have to change, for instance an indefinite or complex structure on $\mathcal W_n$ giving a noncompact isometry group, or a reformulation of the maximiser problem as a genuine norm minimisation. I looked by deriving the $GL_n$ and $SL_n$ moment maps and checking their equivariance and degree, and by screening the flatness of $A$ over $\mathcal W_n$ at $n=4,5,6,7$. Neither escape appeared.

## Verdict

F66 closes R22 correctly in outcome: the route that would separate maximisers from low-moment rivals using the moment map of the vector $W$ is genuinely dead. But F66 closes it by an incorrect argument. Its $GL_n$ moment map is the quadratic Gram contraction, not the Ricci contraction. $\mathcal W_n$ is not the moment-map zero fibre, and the moment map is not flat on $\mathcal W_n$ for $n\ge5$, so the capstone that the rivals agree by construction fails above dimension four. The route stays closed only on the robust reason, that the maximiser equation is cubic criticality on a sphere and no noncompact group acts on $\mathcal W_n$ preserving it. The fence-post and the R22 row need rewriting so a successor is not told the false "flat on $\mathcal W_n$."

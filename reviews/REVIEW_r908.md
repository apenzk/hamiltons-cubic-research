# Review r908, does F66 correctly close the moment-map route R22?

**Standfirst.** This round checks a route-closing argument: whether [F66](../findings/fence-posts.md) correctly retires [R22](../routes.md), the moment-map / Kempf-Ness route to separating the cubic's maximisers, chosen as the primary direction of 2026-09-13. I read the post verbatim at [fence-posts.md](../findings/fence-posts.md) and the route row in [routes.md](../routes.md). I derived the GL_n moment map from the action and the definition of the Ricci contraction, and I checked it numerically at n=4, 5, 6 by building explicit Weyl tensors in a throwaway script under the session scratchpad. Log at [agent_logs/review-r908-f66.log](../agent_logs/review-r908-f66.log).

| Item | Verdict | Reason |
|---|---|---|
| 1. SO(n) half | VALID | real orthogonal action, so the Cartan p is zero and the moment map is trivial, and a compact moment map on a real orthogonal representation vanishes identically, so it hides nothing |
| 2. GL_n half, derived | WRONG | the moment map is the quadratic M(W) = sum W_ajkl W_ijkl valued in Sym(n), not the linear Ricci contraction, and the stated proportionality equates a degree-2 form with a degree-1 form |
| 3. Zero fibre is exactly W_n | WRONG for n>=5, accidental at n=4 | W_n is the zero fibre of the true (quadratic) moment map only at n=4, by the dimension-4 identity W_ajkl W_ijkl = |W|^2 delta / 4, while for n>=5 generic Weyl tensors have nonzero moment map, so the map is non-flat and separates them |
| 4. Degree/space argument | PARTLY WRONG | the two equations are genuinely different in type, but the dimension claim uses dim so(n) where the GL_n-relevant target is Sym(n), and dim W_4 = dim Sym(4) = 10, so "dimensions forbid it" fails at n=4 |
| 5. Third action | VALID with a correction | Route B on the structure tensor is a genuinely different object, not a relabelled R22, but a non-flat moment map on W_n already exists, namely the GL_n vector moment map the post dismissed, for n>=5 |
| 6. Reach of the closure | OVERREACH | "any moment-map route is dead before it starts" is unsupported by the argument and is false for n>=5, where the GL_n moment map is non-flat on W_n |

**Summary.** F66 does not correctly close R22. The SO(n) half is right, but the load-bearing GL_n half misidentifies the moment map, and its central claim that W_n is the moment-map zero fibre holds only at n=4 (by an identity the post never invokes) and is false for n>=5.

## 1. The SO(n) half

VALID. SO(n) is compact and acts on the real Euclidean space W_n by isometries. In the real Kempf-Ness framework the group here is compact, so its Cartan decomposition has p = 0, the moment map m : W_n -> p is into the zero space, and every unit vector is a minimal vector because the orbit norm is constant along an isometric action. The post's two sentences are correct.

The brief asks whether a compact moment map valued in so(n)* carries information the claim ignores. It does not, in this setting. The candidate compact moment map is the map defined by <m(v), X> = <X . v, v> for X in so(n). For a real orthogonal representation every d rho(X) with X in so(n) is skew-symmetric with respect to the inner product, so <X . v, v> = 0 for all v, and this map vanishes identically. A nontrivial compact moment map is the Kahler moment map on a complex or symplectic vector space, which needs a compatible complex structure that W_n does not carry canonically. So there is no hidden separating datum on the SO(n) side, and the claim is right for the reason it gives.

## 2. The GL_n half, derived

WRONG. Take the natural GL_n action on covariant algebraic curvature tensors, g acting on each slot. The infinitesimal action of X in gl_n is
(X . R)_{ijkl} = -( X^a_i R_{ajkl} + X^a_j R_{iakl} + X^a_k R_{ijal} + X^a_l R_{ijka} ).
For X in Sym(n) the moment-map component is <m(R), X> = <X . R, R>. Contracting and using the pair symmetries of R, the four slot terms coincide, giving
<X . R, R> = -4 <X, M(R)>,  where  M(R)_{ai} = sum_{jkl} R_{ajkl} R_{ijkl}.
So the moment map is m(R) = -4 M(R), the trace-free part of M for the unimodular part SL_n, a symmetric-matrix-valued quadratic in R.

This is not the Ricci contraction. The Ricci contraction Ric(R)_{jl} = sum_i R_{ijil} is linear in R, whereas M(R) is quadratic in R. The post's own phrase "the symmetric-matrix-valued quadratic <X . W, W> proportional to <Ric(W), X>" equates a degree-2 form on the left with a degree-1 form on the right, which no nonzero constant can do. The numerical scale test confirms it directly: under W -> 2W the left side scales by 4 and the right side by 2, at both n=4 and n=5, on both a Weyl tensor and a non-Weyl algebraic curvature tensor.

The likely source of the error is the theorem that the Ricci curvature is a moment map, from [lauret-will-2006](../references/lauret-will-2006-einstein-solvmanifolds-moment-map/notes.md) and Lauret's work. There the variable is the Lie bracket mu, and the Ricci curvature of the associated metric is a quadratic function of mu, which genuinely is the moment map for GL_n acting on brackets. The post transported "Ricci is a moment map" to a setting where the variable is itself a curvature tensor, so its Ricci is the linear contraction, a different object. The correct GL_n moment map of the curvature tensor is the quadratic contraction M(W), which one may call a Ricci-type contraction of W tensor W, not the Ricci of W.

## 3. The load-bearing step: is W_n the whole zero fibre?

WRONG for n>=5, and only accidentally true at n=4. The zero fibre of the true SL_n moment map is the set where the trace-free part of M(W) vanishes, that is where sum_{jkl} W_{ajkl} W_{ijkl} is proportional to delta_{ai}. This is a quadratic condition, not the linear condition Ric(W) = 0 that defines W_n.

I built explicit Weyl tensors by projecting random algebraic curvature tensors onto Ric = 0 and measured the trace-free part of M(W):

- n = 4, three seeds: the trace-free part is zero to 1e-15, so M(W) = ( |W|^2 / 4 ) delta for every Weyl tensor. This is the classical dimension-4 identity W_{ajkl} W_{ijkl} = |W|^2 delta_{ai} / 4, a Bel-Robinson-type isotropy special to four dimensions. So W_4 is contained in the moment-map zero fibre, and the traceless moment-map component <X_tf . W, W> vanishes on all of W_4.
- n = 5 and n = 6, three seeds each: the trace-free part of M(W) is order one, and the traceless moment-map component on a Weyl tensor is 11.1 at n = 5 while Ric(W) is zero to 1e-16. So W_n is not contained in the zero fibre for n >= 5, the moment map is non-flat there, and it separates Weyl tensors that the linear Ricci condition cannot tell apart.

The consequence the post rests on, that no two Weyl tensors are separated by m because both are Ricci-flat and hence both minimal vectors, therefore fails for n >= 5. Ricci-flat does not imply minimal vector, since minimal vector means M(W) is isotropic, a strictly stronger quadratic condition. The inference holds at n = 4 only, and there it is the Bel-Robinson identity doing the work, not the linear Ric = 0 the post cites.

## 4. The degree / space argument

PARTLY WRONG. The post is directionally right that Q(W) = theta W is not literally a moment-map-zero condition: it is the eigen-equation of a cubic, valued in W_n, whereas m(W) = 0 is the vanishing of a quadratic valued in Sym(n), and these are different equations of different type. That structural observation stands.

The dimension argument attached to it does not. The post writes dim W_n = n(n+1)(n+2)(n-3)/12 against dim so(n) = binom(n,2) and concludes the dimensions forbid W_n isomorphic to g. For the GL_n action the relevant p is Sym(n), of dimension n(n+1)/2, not so(n). Solving the two comparisons for n >= 4:

- dim W_n = binom(n,2) requires (n+1)(n+2)(n-3) = 6(n-1), which fails for every n >= 4 (30 against 18 at n = 4, and the cubic left side outruns the linear right side thereafter). So against so(n) the inequality holds, as the post says.
- dim W_n = dim Sym(n) requires (n+2)(n-3) = 6, that is n^2 - n - 12 = 0, whose only root n >= 4 is n = 4. So dim W_4 = dim Sym(4) = 10 exactly.

So the coincidence the post rules out actually occurs at n = 4 for the GL_n-relevant target space. The dimension count does not forbid the identification there, and the argument as written picks the wrong Lie algebra to compare against.

## 5. The third-action question

VALID, with one correction. The successor note points to the Fox algebra's structure tensor under GL(W_n), Route B, citing [krasnov-tkachev-2022](../references/krasnov-tkachev-2022-medial-isospectral/notes.md). This is a genuinely different object and not a relabelled R22. In R22 the variable is the curvature tensor W and the group acts on the underlying R^n. In Route B the variable is the multiplication structure tensor of the nonassociative algebra, and GL(W_n) acts on W_n itself, which is the Lauret template where the moment map is quadratic in the structure constants. Different variable, different group, so no mislabelling.

The correction: one does not need a third action to find a non-flat moment map on W_n. The second action already supplies one. The GL_n moment map of the vector W, the very map the post dismisses as flat, is non-flat on W_n for n >= 5, as item 3 shows. Natural further candidates are the conformal or parabolic actions, but the immediate reopening comes from correcting the analysis of the action the post already named.

## 6. The reach of the closure

OVERREACH. The post's closing scope, that any route reaching for the moment map, the Kempf-Ness minimal-vector condition, or the Kirwan-Ness stratification to separate maximisers from low-moment rivals is dead before it starts, is broader than the argument supports. The argument bears on two specific actions. It is correct on one of them, the isometric SO(n), and wrong on the other, GL_n. For n >= 5 the GL_n moment map is non-flat on W_n, so the sweeping claim that the rivals agree in the moment map by construction is false in every dimension above four. The correct scope of the closure is narrow: the moment map of the vector W under SO(n) does not separate, and under GL_n it does not separate at n = 4, by the Bel-Robinson identity. Neither statement licenses "any moment map is dead".

## 7. What would break it

The object that reopens R22 is the true GL_n moment map itself, the trace-free part of M(W)_{ai} = sum_{jkl} W_{ajkl} W_{ijkl}. It is a nonconstant, SO(n)-equivariant, Sym_0(n)-valued quadratic on W_n for n >= 5, so it is not flat and it does separate Weyl tensors. If it takes distinct values on the distinct Fox idempotents Q(e) = theta e, the Kirwan-Ness stratum label separates them and the route lives again for n >= 5.

To look for it I derived the moment map from the action rather than taking it from the post, wrote it in closed form as M(W), and evaluated it on explicit Weyl tensors at n = 4, 5, 6, confirming isotropy at n = 4 and anisotropy above. What I did not have in hand is the family of Fox idempotents, so the remaining screen the route owes is to evaluate the trace-free part of M on the specific rival idempotents at n >= 5 and check whether their moment-map values differ. The closure foreclosed that screen on a false premise, which is why the burden it was meant to carry is not carried.

## Verdict

F66 does not correctly close R22. The SO(n) half is right. The substantive GL_n half is wrong: the moment map is the quadratic contraction M(W), not the linear Ricci contraction, so the identity the post asserts cannot hold. The load-bearing claim that W_n is the moment-map zero fibre is true only at n = 4, by a dimension-4 identity the post does not use, and false for n >= 5, where the GL_n moment map is non-flat on W_n and separates Weyl tensors. The dimension argument compares against the wrong Lie algebra and its stated obstruction fails at n = 4. The reach overclaims. The route is genuinely dead only for the vector moment map at n = 4. For n >= 5 the closure's central premise fails, and whether R22 truly reopens turns on a screen of the specific idempotents that the closure never ran.

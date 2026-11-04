# Review r955, Gate 2 on Lemma L229 ($G(2)$ at fixed total norm on the common-eigenvector stratum)

*Reviewer r955, working [BRIEF_L229.md](BRIEF_L229.md) independently of r956. Log: `agent_logs/r955-L229.log`. Analysis only: every verdict below is argued from the definitions. Three computations are reported, each seconds long on objects constructed for the purpose, each a screen of a step being reported and never evidence for a positive claim.*

**Vocabulary.** CONFIRMED means the block's claim survived the attack the brief names. GAP means the conclusion is right and the written justification does not establish it, which the brief asks to be reported separately from the result being wrong. No item is REFUTED.

| # | Checklist item | Verdict |
|---|---|---|
| 1 | Item 1's identity, and the conversion of batch 11's $K$'s | **CONFIRMED**, every sign right, cross term is $\cos(\vartheta_1-\vartheta_2)$ |
| 2 | The claim $\Lambda>0$ and the normalisation $d_A,d_C,v_2>0$ | **CONFIRMED, with a GAP**: the normalisation is legitimate, the symmetries that make it so are never named, and the degenerate cases are never mentioned |
| 3 | Item 2's annulus and the distance formula | **CONFIRMED**, including all three degenerate cases |
| 4 | Item 3's "exactly when $1\notin\mathop{\mathrm{int}}\mathcal A$" | **CONFIRMED**, both directions, and the interior gap is strict |
| 5 | Item 4's coefficients and the norm segment | **CONFIRMED**, every coefficient and $B$ exact |
| 6 | Step 5's topology | **CONFIRMED**, all four edge cases survive |
| 7 | The quantifier in the conclusion | **GAP**: the proof gives domination, the statement asserts attainment, and the bridge is never stated |
| 8 | Gate 1, clause (a) | **GAP**: the clause overstates twice, once in the way the brief predicted |
| 9 | Gate 1, clause (c), "to $0$" | **CONFIRMED** as the theorem's own prediction, not self-comparison, with a caveat on its strength |
| 10 | The Lean file | **CONFIRMED**, six declarations faithful and on standard axioms, `diagonal_matches` the only `sorryAx`, both non-vacuities exhibited |
| 11 | Scope | **CONFIRMED**, nothing claims $G(2)$ or the $\lvert J\rvert=3$ step closed. Two write-up defects in the index rows |
| 12 | Against the record | **CONFIRMED**, item 2 reproduces batch 12 in all three regimes and is strictly more general, and the record carries neither object elsewhere |

**The lemma stands.** Items 1 to 4 and step 5 are correct as mathematics, and I found no error in any closed form, coefficient or topological step. What I found is three write-up defects: the normalisation's symmetries are asserted rather than named (item 2), attainment is asserted where only domination is proved (item 7), and Gate 1 (a) claims a check against the trusted block value that the cited script does not perform (item 8). The last is the one the brief warned had been written wrongly twice before in this series, and it was written wrongly again.

## Item 1, the identity. CONFIRMED

**The expansion.** With $w=\rho_2e^{i\vartheta_1}+\rho_1e^{i\vartheta_2}$, $\lvert1-w\rvert^2=1-2\mathop{\mathrm{Re}}w+\lvert w\rvert^2$. Here $\mathop{\mathrm{Re}}w=\rho_2\cos\vartheta_1+\rho_1\cos\vartheta_2$ and $\lvert w\rvert^2=\rho_1^2+\rho_2^2+2\mathop{\mathrm{Re}}\big(\rho_2e^{i\vartheta_1}\overline{\rho_1e^{i\vartheta_2}}\big)=\rho_1^2+\rho_2^2+2\rho_1\rho_2\cos(\vartheta_1-\vartheta_2)$. The conjugate is what puts the difference of phases in the cross term, and $\cos(\vartheta_1+\vartheta_2)$ would need $\rho_1e^{i\vartheta_2}$ unconjugated, which is not what a squared modulus contains. So $\Lambda\lvert1-w\rvert^2=\Lambda(1+\rho_1^2+\rho_2^2)-g$ exactly, with $g$ as item 1 writes it. **The sign the brief flags as inverting the lemma is right.**

**The conversion from batch 11 is right, and it is the part no cited script checks.** Batch 11 has $K_1=2p\,d_A$ on $\cos2\varphi$, $K_2=2r\,d_C$ on $\cos2\chi$ and $K_{12}=-2\beta p\,v_2\,r$ on $\cos(2\varphi-2\chi)$. With $\Lambda=\frac{d_Ad_C}{\beta v_2}$, $\rho_1=\frac{\beta v_2r}{d_A}$, $\rho_2=\frac{\beta v_2p}{d_C}$:

- $2\Lambda\rho_2=2\frac{d_Ad_C}{\beta v_2}\cdot\frac{\beta v_2p}{d_C}=2p\,d_A=K_1$, and it multiplies $\cos\vartheta_1=\cos2\varphi$, which is $K_1$'s angle.
- $2\Lambda\rho_1=2\frac{d_Ad_C}{\beta v_2}\cdot\frac{\beta v_2r}{d_A}=2r\,d_C=K_2$, on $\cos\vartheta_2=\cos2\chi$.
- $-2\Lambda\rho_1\rho_2=-2\frac{d_Ad_C}{\beta v_2}\cdot\frac{\beta v_2r}{d_A}\cdot\frac{\beta v_2p}{d_C}=-2\beta p\,v_2\,r=K_{12}$, **including the sign**, on $\cos(\vartheta_1-\vartheta_2)$.

The subscripts cross over, $\rho_2$ carrying $p$ against $d_C$ while $\rho_1$ carries $r$ against $d_A$, and they cross over consistently in every one of the three.

*Screen, seconds, on triples I constructed.* Drawing $d_A,d_C,v_2>0$ and $p,r\ge0$ and forming both sides, the three coupling identities held to $7\cdot10^{-15}$ over 200 draws, and item 2's closed form matched a $2001^2$ grid maximum of batch 11's $g$ **written in its own couplings $K_1,K_2,K_{12}$** to $1.6\cdot10^{-5}$, that grid's resolution. Reported because item 8 records that no cited script does this. It screens the omission and is not evidence for item 1, which the algebra above settles.

## Item 2, $\Lambda>0$ and the normalisation. CONFIRMED, with a GAP

**$\Lambda>0$ follows from the normalisation**, since $\Lambda=d_Ad_C/(\beta v_2)$ and $\beta=\tfrac94>0$. It is used twice, for the inequality in item 1 and, unremarked, for item 2: maximising $g$ is minimising the deficit only because the deficit carries a positive factor, and at $\Lambda<0$ item 2's formula would compute a minimum. Item 2's statement carries no hypothesis at all, so it is true only inside the Setting's normalisation. Worth a hypothesis on the item.

**The normalisation is legitimate, and the block does not say why.** Batch 11's frustration condition is $K_1K_2K_{12}<0$, which is $-8\beta p^2r^2\,d_Ad_Cv_2<0$, that is $d_Ad_Cv_2>0$: a condition on the **product**, whereas the Setting takes all three factors positive. Two symmetries close that gap, and neither is named in the block:

- **Swapping $e_1$ and $e_3$.** Conjugating $\hat U,V,A,C$ by that permutation preserves every trace in $\Phi$ and both norms, keeps $u_2,v_2,p,r$, sends $A\mapsto\mathop{\mathrm{diag}}(A_3,A_2,A_1)$ and $C$ likewise, hence $(d_A,d_C)\mapsto(-d_A,-d_C)$ with $\tilde a,\tilde c$ fixed, and carries pairs diagonal in $F$ to pairs diagonal in $F$.
- **$V\mapsto-V$ together with $C\mapsto-C$.** $\mathop{\mathrm{tr}}(\hat UV^2)$ and $\lvert V\rvert$ are unchanged and $\mathop{\mathrm{tr}}(VC)$ is unchanged, so $\Phi$ is preserved, and it sends $(d_C,v_2)\mapsto(-d_C,-v_2)$.

Both flip two signs at once, so the group they generate is the even subgroup acting on the sign triple $(\mathop{\mathrm{sign}}d_A,\mathop{\mathrm{sign}}d_C,\mathop{\mathrm{sign}}v_2)$, whose orbits are exactly the two level sets of the product. **So $d_Ad_Cv_2>0$ does reduce to all three positive**, which is what the Setting needs, and the reduction is genuinely unavailable from the product condition alone without exhibiting these maps. *Screen, seconds: both flips preserved $\Phi$ to $4\cdot10^{-14}$ over 2000 random configurations, reported as a screen of the two maps I am asserting.*

**The degenerate cases are never mentioned, and they are outside the whole parametrisation.** At $v_2=0$ the quantity $\Lambda$ is undefined, and at $d_A=0$ or $d_C=0$ so are $\rho_1$ or $\rho_2$, so items 1 to 4 say nothing there. Each case has $d_Ad_Cv_2=0$, hence $K_1K_2K_{12}=0\ge0$, so batch 11's unfrustrated clause applies verbatim and puts the phase maximum at $\vartheta_1,\vartheta_2\in\{0,\pi\}$, a diagonal pair at the same amplitudes. The same covers every $v_2\le0$ once the field is normalised, and $p=0$ or $r=0$ are fine inside the parametrisation. **The mathematics is complete only because batch 11 covers what L229's own proof does not**, and the block's Statement is unconditional while its proof runs only in the frustrated regime.

**Correction owed.** The Setting should name the two symmetries and say that $d_Ad_Cv_2\le0$, including each vanishing case, is batch 11's unfrustrated clause rather than anything items 1 to 5 prove. One sentence.

## Item 3, the annulus. CONFIRMED

**The set is the closed annulus.** $\{\rho_2e^{i\vartheta_1}+\rho_1e^{i\vartheta_2}\}$ is the Minkowski sum of the circles of radii $\rho_2$ and $\rho_1$. Every element has modulus in $[\lvert\rho_1-\rho_2\rvert,\rho_1+\rho_2]$ by the triangle inequality, and conversely every modulus in that range is realised because the third side of a triangle with sides $\rho_1,\rho_2$ ranges over exactly that interval, while turning both phases together rotates the sum through every argument. So the image is $\mathcal A$, closed because the torus is compact.

**The three degenerate cases all come out right.**

| Case | The set | $\mathcal A$ as written | $\mathop{\mathrm{dist}}(1,\cdot)$ by the formula | Correct |
|---|---|---|---|---|
| $\rho_1=0$ | circle of radius $\rho_2$ | $\rho_2\le\lvert z\rvert\le\rho_2$, that circle | $\max(0,1-\rho_2,\rho_2-1)=\lvert1-\rho_2\rvert$ | yes |
| $\rho_1=\rho_2$ | closed disc of radius $2\rho_1$ | $0\le\lvert z\rvert\le2\rho_1$ | $\max(0,1-2\rho_1,-1)$ | yes |
| $\rho_1=\rho_2=0$ | $\{0\}$ | $0\le\lvert z\rvert\le0$ | $\max(0,1,-1)=1$ | yes |

**The formula is right in general.** If $\lvert\rho_1-\rho_2\rvert\le1\le\rho_1+\rho_2$ then $1\in\mathcal A$ and both non-zero entries are $\le0$, giving $0$. If $1>\rho_1+\rho_2$ the nearest point is $\rho_1+\rho_2$ on the positive real axis and the third entry is $\le\rho_1+\rho_2-1<0$. If $1<\lvert\rho_1-\rho_2\rvert$ the nearest point is $\lvert\rho_1-\rho_2\rvert$ and the second entry is negative. The three cases are mutually exclusive, so the maximum picks the live one every time.

**One imprecision in the written justification.** The proof says "the distance from a point of modulus $1$ to $\mathcal A$", which is true for any such point by rotational invariance, but the argument only ever needs it at $z=1$ and item 3 later relies on $1$ being *real and positive*, so the generality is decorative. Not a defect.

## Item 4, "exactly when $1\notin\mathop{\mathrm{int}}\mathcal A$". CONFIRMED

**The nearest point formula holds in every case.** Write $R=\rho_1+\rho_2$ and $\varrho=\lvert\rho_1-\rho_2\rvert$, so $\varrho\le R$. The claim is that the nearest point of $\mathcal A$ to $1$ is $\min(R,\max(1,\varrho))$.

- $\varrho\le1\le R$: nearest point is $1$ itself, and $\min(R,\max(1,\varrho))=\min(R,1)=1$.
- $1>R$: nearest point is $R$, and $\min(R,\max(1,\varrho))=\min(R,1)=R$.
- $1<\varrho$: nearest point is $\varrho$, and $\min(R,\max(1,\varrho))=\min(R,\varrho)=\varrho$.

**Both directions of the "exactly when" hold.** If $1\notin\mathop{\mathrm{int}}\mathcal A$ then $1\ge R$ or $1\le\varrho$, and the nearest point is $R$ or $\varrho$, each of which is among $\{\pm\rho_1\pm\rho_2\}$. Conversely if $1\in\mathop{\mathrm{int}}\mathcal A$, that is $\varrho<1<R$, then $\mathop{\mathrm{dist}}(1,\mathcal A)=0$ while the four distances $\lvert1-R\rvert,\lvert1+R\rvert,\lvert1-\varrho\rvert,\lvert1+\varrho\rvert$ are all **strictly** positive, the first because $R>1$, the third because $\varrho<1$, the other two because $1+R$ and $1+\varrho$ are at least $1$.

**The brief's question about equality in the interior has a clean answer: it cannot happen.** The strictness is not marginal, it is the strictness of $\varrho<1<R$ that defines the interior. Had it been possible for a diagonal pair to match the cap at an interior point, step 5 would still go through, since it only ever needs agreement outside $E^\circ$, so this is a case where the proof has slack rather than a dependency.

**Empty interior is handled correctly.** When $\rho_1\rho_2=0$ the annulus degenerates to a circle whose interior in $\mathbb C$ is empty, so $1\notin\mathop{\mathrm{int}}\mathcal A$ automatically, which is exactly what step 5 invokes at the endpoints of the norm segment.

## Item 5, item 4's coefficients. CONFIRMED

**The two cap terms.** $\Lambda\rho_2^2=\frac{d_Ad_C}{\beta v_2}\cdot\frac{\beta^2v_2^2p^2}{d_C^2}=\frac{\beta v_2d_A}{d_C}x$ and $\Lambda\rho_1^2=\frac{d_Ad_C}{\beta v_2}\cdot\frac{\beta^2v_2^2r^2}{d_A^2}=\frac{\beta v_2d_C}{d_A}y$. Both as written, and again the subscripts cross over. The constant term of the cap is $\Lambda=\frac{d_Ad_C}{\beta v_2}$, which is the fifth summand of item 4's bracket.

**The phase-free part.** Batch 11 gives $\alpha(\tfrac34u_2^3-3u_2p^2)+\beta\big(u_2v_2^2-u_2(\tfrac{v_2^2}4+r^2)\big)+A_2u_2-\tfrac{u_2}2(A_1+A_3)+C_2v_2-\tfrac{v_2}2(C_1+C_3)$. The $\beta$ bracket collapses to $\beta u_2(\tfrac34v_2^2-r^2)$, and the field terms are $\tilde au_2+\tilde cv_2$ by the Setting's definitions of $\tilde a$ and $\tilde c$. So it contributes $-3\alpha u_2x$ to the $x$ coefficient, $-\beta u_2$ to the $y$ coefficient, and $\tfrac34\alpha u_2^3+\tfrac34\beta u_2v_2^2+\tilde au_2+\tilde cv_2$ to the constant. Adding the cap reproduces item 4 term by term, all three coefficients and all five constant summands.

**The norm and $B$.** $T=\tfrac32\lvert\hat U\rvert^2+\tfrac12\lvert V\rvert^2$ with $\lvert\hat U\rvert^2=\tfrac32u_2^2+2p^2$ and $\lvert V\rvert^2=\tfrac32v_2^2+2r^2$ gives $T=\tfrac94u_2^2+3x+\tfrac34v_2^2+y$. The asymmetry the brief flags is real and correctly carried: $\tfrac32\cdot2=3$ on $x$ and $\tfrac12\cdot2=1$ on $y$. Hence $B=T-\tfrac94u_2^2-\tfrac34v_2^2$, as written, and the segment is $3x+y=B$ rather than $x+y=B$.

**One imprecision.** Item 4 writes "$\Phi=\ldots$" for a quantity that is the maximum of $\Phi$ over the phases, and that equals the affine expression only where the cap is attained. The hedge "the value with the cap in place" carries this, but the displayed equation does not, and the block never gives that maximum a symbol. Cosmetic, and step 5 uses it only on $E$, where it is an equality.

## Item 6, step 5's topology. CONFIRMED

Parametrise $I$ by $x\in[0,B/3]$ with $y=B-3x$. Then $\rho_1=\beta v_2\sqrt{B-3x}/d_A$ and $\rho_2=\beta v_2\sqrt x/d_C$ are continuous on $I$.

- **$E$ is closed in $I$**: it is $\{\varrho\le1\}\cap\{1\le R\}$, two weak inequalities between continuous functions. Correct as written, and $I$ compact makes $E$ compact.
- **Components are closed subintervals**: components of any space are closed in it, $E$ is closed in $I$ which is closed in $\mathbb R$, and connected subsets of $\mathbb R$ are intervals. Bounded because $I$ is. Correct.
- **The endpoint dichotomy holds.** Let $[s,t]$ be a component and consider $t$. If $t$ is interior to $I$, maximality plus closedness of $E$ gives points of $I\setminus E$ arbitrarily close above $t$, so at those points $1>R$ or $1<\varrho$, and continuity at $t$ combined with $t\in E$ forces $1=R$ or $1=\varrho$. Either way $1\in\partial\mathcal A$ and $1\notin\mathop{\mathrm{int}}\mathcal A$. Otherwise $t$ is an endpoint of $I$: at $x=B/3$ we get $y=0$ so $\rho_1=0$, and at $x=0$ we get $\rho_2=0$, and in both the annulus is a circle with empty interior. Correct in both branches.
- **The affine maximum.** Affine on a closed bounded interval attains its maximum at an endpoint. **The constant case the brief raises is harmless**: a constant attains its maximum at both endpoints, so "at one of its two endpoints" remains true, and step 5 needs only one such endpoint.

**The four edge cases.**

| Case | What happens | Survives |
|---|---|---|
| $E=\emptyset$ | $E^\circ\subseteq E=\emptyset$, so every point of $I$ is outside $E^\circ$ and item 3 already gives a diagonal value | yes, vacuously |
| $E$ a single point $\{s\}$ | if $s$ is interior to $I$ it is in $\partial E$, so $1\in\partial\mathcal A$ and $s\notin E^\circ$, hence $E^\circ=\emptyset$ | yes |
| $E=I$ | the single component is $I$, whose endpoints are $I$'s, where $\rho_1\rho_2=0$ | yes |
| $B=0$ | $I$ is the point $(0,0)$, $\rho_1=\rho_2=0$, $\mathcal A=\{0\}$ with empty interior, and the configuration is already diagonal since $p=r=0$ | yes |

**A worry that does not bite.** $E$ could in principle have infinitely many components, but the argument is pointwise in $z\in E^\circ$ and uses only $z$'s own component, so the cardinality is irrelevant. Moreover $E^\circ$ is open in $I$, because $\mathop{\mathrm{int}}\mathcal A$ is open and $\rho_1,\rho_2$ are continuous, so the component of any $z\in E^\circ$ is non-degenerate whenever $I$ is, and no degenerate component can contain an interior point. The chain closes.

*Screen, seconds.* Over 200000 random $(\rho_1,\rho_2)$ the two distance functions agreed to $0$ exactly on the complement of $\mathop{\mathrm{int}}\mathcal A$, with no violation of the "exactly when" in either direction. A screen of items 3 and 4's agreement set, which is what step 5 consumes.

## Item 7, the quantifier. GAP

**They are not the same claim.** The Statement says $\sup\Phi$ at fixed $T$ "is attained with $\hat U$ and $V$ both diagonal in $F$". What steps 1 to 5 produce is: for every configuration of the stratum there is a diagonal configuration, at the same $T$, $u_2$ and $v_2$, of value at least as large. That is **domination**, and it yields $\sup_{\text{stratum}}\Phi=\sup_{\text{diagonal}}\Phi$ and nothing more. Attainment is a further assertion, and the proof's last sentence ("Every configuration of the stratum is therefore matched ...") states the domination, not the attainment. The word "attained" in the Statement is never discharged.

**The result is nonetheless true, in one added line.** The constraint set $\{\tfrac32\lvert\hat U\rvert^2+\tfrac12\lvert V\rvert^2=T\}$ is a sphere in the ten-dimensional space of pairs of traceless symmetric $3\times3$ matrices, hence compact. The stratum is closed in it, being the finite union over $i\in\{1,2,3\}$ of the sets where $e_i$ is a common eigenvector, each cut out by linear equations. The diagonal configurations form a closed subset too, and $\Phi$ is continuous. So both suprema are attained, and the domination makes them equal. **This is a one-sentence repair and it is missing.**

**Why it is worth fixing rather than waving through.** The whole point of L229 over batch 13 is that it replaces a screen by an argument, and "attained" is the word that distinguishes the lemma from the weaker statement about suprema. Leaving the compactness unstated leaves the lemma's own headline unproved by its own proof. Note also that the Lean file is honest here where the prose is not: `diagonal_matches` types the domination and claims nothing about attainment, and the block's Lean paragraph says so.

**Correction owed.** Add the compactness sentence to step 5, or weaken the Statement to "the supremum over the stratum equals the supremum over its diagonal points". The first is better, since it is true and is what the lemma is for.

## Item 8, Gate 1 clause (a). GAP, overstated twice

**The brief predicted this and it happened again.** Read against the scripts rather than against its own wording, the clause is wrong in two places.

**First, "screened against the trusted block value" is not what the cited script does.** [screen_I106_G2_commonaxis.py](../scripts/misc/screen_I106_G2_commonaxis.py) builds $\hat U,V,A,C$ as explicit $3\times3$ matrices, computes `direct` as $\alpha\mathop{\mathrm{tr}}\hat U^3+\beta\mathop{\mathrm{tr}}(\hat UV^2)+\mathop{\mathrm{tr}}(\hat UA)+\mathop{\mathrm{tr}}(VC)$, and compares it with batch 11's reduced formula. It imports `numpy` and nothing else. It never touches [curvature_operator.py](../scripts/lib/curvature_operator.py) and never forms a Weyl tensor. **So the screen is batch 11's reduction against $\Phi$'s own definition, which is itself a derived object**, batch 5's, reached from L228's item 1 through a shift and a change of variables. The two scripts in this family that do reach the trusted operator are [screen_I106.py](../scripts/misc/screen_I106.py) and [screen_I106_m3.py](../scripts/misc/screen_I106_m3.py), and both screen L228, not $\Phi$. The script's own row in [scripts/INDEX.md](../scripts/INDEX.md) describes it correctly, as "the two-block value and both norms equal the reduced formula", so the overstatement is in the Gate 1 clause alone.

**Second, "items 1 to 4 are checked against that reduced formula" is true of item 4 and false of items 1 and 2.** In [screen_I106_annulus.py](../scripts/misc/screen_I106_annulus.py), `check_identity` and `check_closed_form` draw $\rho_1,\rho_2,\Lambda$ **independently at random** and form $a,b,c$ from them. They never construct $d_A,d_C,v_2,p,r$ and never form $K_1,K_2,K_{12}$. So they screen the abstract identity and the abstract closed form, and they leave the conversion of batch 11's couplings entirely unexercised, which is precisely the step the brief's item 1 singles out as the one whose sign error would invert the lemma. Only `value`, used by `check_affine_and_closure`, goes through $d_A,d_C,v_2$.

**Nothing is hiding in the unscreened step.** The conversion is exact by the algebra in item 1 above, and my own screen closed the hole numerically: the three couplings matched to $7\cdot10^{-15}$, and item 2's closed form matched a $2001^2$ grid maximum of $g$ **in batch 11's own couplings** to that grid's resolution. Reported as a screen of the omission.

**A third, smaller point on the same clause.** "item 4's affineness to $3\cdot10^{-14}$" is a fair description: `check_affine_and_closure` substitutes the predicted closed form and tests affineness of the composite in $(x,y)$ by a midpoint identity, which is a real algebraic check of item 4.

**Correction owed.** The clause should read that batch 11's reduction was screened against $\Phi$ evaluated directly on the matrices, formula to formula with no contact with the trusted operator, and that items 1 and 2 are screened in the abstract amplitudes while the conversion from $K_1,K_2,K_{12}$ is screened separately or by hand.

## Item 9, Gate 1 clause (c), "to $0$". CONFIRMED as the prediction

**It is the theorem's own prediction, not a quantity compared with itself.** The two numbers are maxima over the same 4001-point grid of two genuinely different functions, $S+\Lambda(1+\rho_1^2+\rho_2^2)-\Lambda\,\texttt{annulus\_dist}^2$ and the same with `collinear_dist`. They differ on all of $E^\circ$, which is a non-empty open set in the cases the screen samples. Since the four points $\pm\rho_1\pm\rho_2$ lie in $\mathcal A$, `annulus_dist` $\le$ `collinear_dist` pointwise, so the gap is $\ge0$ by construction and only its vanishing carries information. **It vanishes exactly when the free maximum over the segment is attained at a grid point where the two distances agree, which is item 3's agreement set, which is what step 5 predicts.** So a reported $0$ is content.

**The caveat on its strength.** The agreement is bit-exact rather than approximate, because on $\{1\ge\rho_1+\rho_2\}$ both functions evaluate the same floating-point expression `1 - r1 - r2`, and likewise on $\{1\le\lvert\rho_1-\rho_2\rvert\}$. Combined with the fact that the affine maximum lands at a vertex of the segment in the typical case, and vertices are exact grid points where $\rho_1\rho_2=0$, the screen most often confirms the easy branch of step 5's dichotomy rather than the boundary branch. **The "to $0$" is real, and it is weaker evidence than a generic residual of $10^{-14}$ would be**, because it tests a case where the two formulas coincide identically rather than nearly. The block's own label, "a screen of a derived conclusion", is the right one.

## Item 10, the Lean file. CONFIRMED

**Axioms, from `#print axioms` on a scratch file importing the module after `lake build`.**

| Declaration | Axioms |
|---|---|
| `phase_deficit` | `propext, Classical.choice, Quot.sound` |
| `phase_le_cap` | `propext, Classical.choice, Quot.sound` |
| `collinear_eq_phaseSum` | `propext, Classical.choice, Quot.sound` |
| `collinear_deficit` | `propext, Classical.choice, Quot.sound` |
| `cap_attained_of_boundary` | `propext, Classical.choice, Quot.sound` |
| `capValue_affine` | `propext, Classical.choice, Quot.sound` |
| `diagonal_matches` | `propext, `**`sorryAx`**`, Classical.choice, Quot.sound` |

Six on standard axioms and `sorryAx` in `diagonal_matches` alone, as the block and [lean/INDEX.md](../lean/INDEX.md) both claim. The build reports exactly one `declaration uses 'sorry'` warning, at the `diagonal_matches` line.

**Each declaration states what the prose attributes to it.** `phaseSum` is item 1's $g$ verbatim and `phaseCap` the cap. `phase_deficit` writes the deficit as $l\big((1-r_2\cos t_1-r_1\cos t_2)^2+(r_2\sin t_1+r_1\sin t_2)^2\big)$, which is the squared modulus of $1-r_2e^{it_1}-r_1e^{it_2}$ with the real part squared plus the imaginary part squared, the sign of the imaginary part being immaterial under the square. It is stated with no hypothesis on `l`, correctly, since the identity is unconditional. `phase_le_cap` adds `0 ≤ l`, which is weaker than $\Lambda>0$ and sufficient. `collinear` and `collinear_deficit` are item 3's value and its exact square, the latter needing only $e_j^2=1$. `capValue_affine` is item 4, with $r_1=b v_2\sqrt y/d_A$ and $r_2=b v_2\sqrt x/d_C$ matching $\rho_1,\rho_2$ at $p=\sqrt x$, $r=\sqrt y$, and its right-hand side reproducing all three coefficients and all five constant summands.

**`diagonal_matches` is a faithful typing of step 5, and it is neither vacuous nor weaker than the step.** It says: for every feasible $(x,y)$ on $3x+y=B$ there is a feasible $(x',y')$ on the same segment whose **diagonal** value, the affine part less $l\cdot\texttt{collinearDist}^2$, is at least the **free** value at $(x,y)$, the affine part less $l\cdot\texttt{annulusDist}^2$. That is exactly the domination step 5 proves, no more and no less. It is stated for arbitrary $c_0,c_1,c_2$, which is right, because step 5 never uses any relation between the affine coefficients and the amplitudes. It is correspondingly **not** the attainment claim and makes no contact with blocks, which the block's Lean paragraph states.

**Non-vacuity, exhibited.** Both witnesses typecheck against the real declarations:

- `cap_attained_of_boundary 1 (1/2) (1/2) (Or.inl (by norm_num))` discharges the hypothesis at $r_1=r_2=\tfrac12$, on the outer circle.
- `capValue_affine (15/4) (9/4) 0 1 1 1 0 0 1 1` discharges all six hypotheses at $\alpha=\tfrac{15}4$, $\beta=\tfrac94$, $u_2=0$, $v_2=d_A=d_C=1$, $\tilde a=\tilde c=0$ and $x=y=1$, so the $b\ne0$, $v_2\ne0$, $d_A\ne0$, $d_C\ne0$, $0\le x$, $0\le y$ hypotheses are all live and jointly satisfiable.

**One imprecision, in the file's own header rather than in a theorem.** The third header bullet says the diagonal value and the cap "agree exactly on the annulus boundary". They also agree everywhere **outside** the annulus, where neither attains the cap, which is what item 3's "$1\notin\mathop{\mathrm{int}}\mathcal A$" covers. The theorem `cap_attained_of_boundary` is correctly scoped to the boundary, since only there does a diagonal pair attain the cap, so the theorem is right and the header sentence conflates two different agreements. Worth a word.

## Item 11, scope. CONFIRMED, with two write-up defects

**Nothing claims $G(2)$ or the $\lvert J\rvert=3$ step closed.** The block's "What it gives" is scoped to the stratum and its "Open" line names both remainders, the no-common-eigenvector stratum and the induction from $G(2)$ to $G(m)$. [plan.md](../plan.md)'s I106 row is still open, lists L229 as "Gate 2 in flight", and names the same two open items. [lean/INDEX.md](../lean/INDEX.md)'s row is scrupulous, marking the file **partial** and listing the three owed pieces.

**Defect one, a dangling fragment.** The [findings/INDEX-results.md](../findings/INDEX-results.md) row ends "Closes the stratum carrying [F68]'s witness. the common-eigenvector stratum | ...", where the trailing clause is an uncapitalised leftover that belongs to no sentence. A stray edit, not a scope error.

**Defect two, a dependency the glance entry does not show.** [results.md](../results.md)'s entry states L229 over $\mathcal S_J\cap\mathcal W_n$ at $\lvert J\rvert=3$, which is the block level. L229's own proof lives entirely at the level of $\Phi$ with $\alpha=\tfrac{15}4$, $\beta=\tfrac94$ and diagonal $A,C$, and the passage from the block problem to $\Phi$, including those two constants and the construction of $A$ and $C$ from the fixed blocks, is batch 5, a given that L229 does not prove and the brief does not quote. That is legitimate, and the glance entry should carry the same dependency the block's Setting does. Its phrase "the supremum is attained with both blocks diagonal in $F$ whenever they share an eigenvector of $F$" also reads at first pass as a statement about the unrestricted supremum, where what is meant is the supremum restricted to the stratum. Worth tightening, and it inherits item 7's attainment gap.

## Item 12, against the record. CONFIRMED

**Item 2 reproduces batch 12 in all three regimes.** With $a=2\Lambda\rho_2$, $b=2\Lambda\rho_1$, $c=2\Lambda\rho_1\rho_2$:

- **The triangle condition matches.** Batch 12's condition is that $1/a,1/b,1/c$ satisfy the triangle inequalities. Scaling that triple by $2\Lambda\rho_1\rho_2>0$ turns it into $(\rho_1,\rho_2,1)$, whose triangle inequalities are $\rho_1+\rho_2\ge1$ and $\lvert\rho_1-\rho_2\rvert\le1$, which is $1\in\mathcal A$. The block's Gate 1 (b) claim is exactly right.
- **The triangle value matches.** $ab/c=2\Lambda$, $bc/a=2\Lambda\rho_1^2$, $ca/b=2\Lambda\rho_2^2$, so $\tfrac12(ab/c+bc/a+ca/b)=\Lambda(1+\rho_1^2+\rho_2^2)$, which is item 2 at $\mathop{\mathrm{dist}}=0$.
- **Outside, below the annulus.** At $\rho_1+\rho_2<1$ item 2 gives $\Lambda[1+\rho_1^2+\rho_2^2-(1-\rho_1-\rho_2)^2]=2\Lambda(\rho_1+\rho_2-\rho_1\rho_2)$. Batch 12 gives $a+b+c-2\min(a,b,c)$, and there $\rho_1,\rho_2<1$ forces $\rho_1\rho_2<\min(\rho_1,\rho_2)$, so the minimum is $c$ and the value is $2\Lambda(\rho_1+\rho_2+\rho_1\rho_2)-4\Lambda\rho_1\rho_2$, the same.
- **Outside, inside the hole.** At $\rho_1-\rho_2>1$ item 2 gives $\Lambda[1+\rho_1^2+\rho_2^2-(\rho_1-\rho_2-1)^2]=2\Lambda(\rho_1-\rho_2+\rho_1\rho_2)$. There $\rho_1>1$ makes $\rho_1\rho_2>\rho_2$ and $\rho_1>\rho_2$, so batch 12's minimum is $a$ and its value is $2\Lambda(\rho_1+\rho_2+\rho_1\rho_2)-4\Lambda\rho_2$, the same. Symmetric in the other sign.

*Screen, seconds:* over 200000 random $(\rho_1,\rho_2,\Lambda)$ the two closed forms agreed to $1.4\cdot10^{-14}$, evaluating batch 12's by its own case split. A screen of the case-by-case algebra above.

**Item 2 is strictly more general than batch 12.** Batch 12 needs $a,b,c>0$ and divides by $c$, so it excludes $\rho_1\rho_2=0$, and it states the triangle condition with strict inequalities, leaving the boundary to the collinear branch. Item 2 covers $\rho_1=0$, $\rho_2=0$ and the boundary in one expression, and on the boundary the two branches coincide anyway, since the cap equals the collinear value there. **So "supersedes" is accurate**, and the supersession is what removes batch 13's owed four-amplitude comparison, since the deficit $D$ batch 13 was built around never has to be compared with $2\tilde cv_2$: the move of step 5 keeps $v_2$ fixed and never flips it.

**Nothing on the record carries either object under another name.** Searching by the objects rather than by this block's vocabulary, "annulus", "sum of two circles", "Minkowski sum" and "squared distance" across the record: the annulus occurrences are [REVIEW_r441.md](REVIEW_r441.md) and [REVIEW_r439.md](REVIEW_r439.md), both the tube annulus of the I6 isolation estimate, unrelated; "Minkowski sum" is the range-of-PSD-matrices corollary in the Yang reference notes; "two circles" elsewhere is the grid over diagonal configurations in [post F68](../findings/fence-posts.md) and its brief, a different object. The cap $\Lambda(1+\rho_1^2+\rho_2^2)$ and the identity appear only in L229, batch 14 and the skill-proposal note recording the batch 12 and 13 detour. **No duplication.**

## What I did not check

The reduction of the block problem to $\Phi$ (batches 5 and 10), and batch 11's reduction to the six-parameter form, are givens under the brief and I did not attack them, beyond reading the cited screen to decide item 8. The `sorry` in `diagonal_matches` is unproved by construction, and I checked only that its statement is the right one to prove.

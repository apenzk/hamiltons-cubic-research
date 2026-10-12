# Gate 2 brief: the Osserman closure, and the reclassification of a `sorry`

You are an adversarial reviewer. **Work from the definitions below and from the mathematics alone.** Do not read the findings files, the fence posts, the screens or the Lean files under review.

**Two reviewers on identical briefs.** Most of what follows is an argument being made rather than text compared against something fixed.

## Part A, the setting for the Osserman claims

$W$ is an algebraic Weyl tensor on $\mathbb R^n$: a $4$-tensor with the Riemann symmetries, the first Bianchi identity, and all traces zero. Its **Jacobi operator** at a vector $x$ is

$$J(x)_{ab}=\sum_{i,j}W_{aibj}\,x^i x^j .$$

$W$ is called **Osserman** when the spectrum of $J(x)$ restricted to $x^{\perp}$ is the same for every unit $x$.

**A kernel direction** of $W$ is an $x\ne0$ with $W(x,\cdot,\cdot,\cdot)=0$.

**GIVEN, and not audited here.** For $n>4$, *padded* $W_{\mathbb{CP}^2}$ means the $\mathbb{CP}^2$ Weyl tensor supported on a fixed $4$-dimensional coordinate block and zero on every index touching the complement. It is the conjecture's non-diagonal equality case, attaining $\theta=\sqrt{3/2}$.

## Part B, the setting for the adjugate claims

On $\mathbb R^6$, with $\varepsilon$ the Levi-Civita symbol on six indices, and $X$ a skew $6\times6$ matrix read as a $2$-form:

$$(\star T)_{ab}=\tfrac1{4!}\sum_{cdef}\varepsilon_{abcdef}T_{cdef},\qquad (X\wedge X)_{abcd}=2\big(X_{ab}X_{cd}-X_{ac}X_{bd}+X_{ad}X_{bc}\big),$$
$$\sigma(X)=\tfrac12\star(X\wedge X),\qquad \mathrm{Pf}(X)=\tfrac1{48}\sum\varepsilon_{abcdef}X_{ab}X_{cd}X_{ef},\qquad \mathrm{triple}(X,Y,Z)=\tfrac1{48}\sum\varepsilon_{abcdef}X_{ab}Y_{cd}Z_{ef}.$$

**GIVEN, on the record and not audited here.** A recorded lemma derives the target identity $\star(J\wedge J)=2\varepsilon_JJ$ at a complex structure $J$ (meaning $J$ skew with $J^2=-\mathrm{Id}$) from two inputs: the **adjugate law** $X\,\sigma(X)=-\mathrm{Pf}(X)\,\mathrm{Id}$ at every skew $X$, and $\mathrm{Pf}(J)=\pm1$.

**The adjugate law carries a `sorry` in the machine-checked layer**, whose stated justification is quoted verbatim:

> The `sorry` is the normal form and nothing else: the identity is checked in a frame adapted to `ω`, and carrying that to every `ω` needs the real skew normal form together with the `SO(6)`-equivariance of `⋆`, `∧` and the Pfaffian. *Neither is in this layer and Mathlib carries neither in a usable shape.*

## The claims to attack, one row per claim, with the Lean declaration that types it

| # | claim | Lean |
|---|---|---|
| 1 | if $W$ has a kernel direction $x$ then $J(x)=0$, so an Osserman $W$ has constant spectrum $0$, so every $J(y)$ vanishes on $y^\perp$, so $W=0$ | none: the layer carries no Jacobi operator at all, which is itself worth remarking on |
| 2 | hence a NONZERO Osserman Weyl tensor has no kernel direction | none, same reason |
| 3 | padded $W_{\mathbb{CP}^2}$ has kernel directions for $n>4$ and is therefore not Osserman, while $W_{\mathbb{CP}^2}$ at $n=4$ IS | none: a property of a constructed tensor, screened rather than typed |
| 4 | therefore a route proposing to classify non-diagonal maximisers via the Osserman classification has a FALSE warrant, since its supporting instance fails | none: a claim about a route |
| 5 | $\varepsilon_J=\mathrm{Pf}(J)$, and at $J=\varphi_{01}+\varphi_{23}+\varphi_{45}$ the value is $-1$, so $\star(J\wedge J)=-2J$ there | none: `pf6` exists in the layer, the identification does not |
| 6 | both signs of $\mathrm{Pf}(J)$ occur, one per $SO(6)$ orbit of complex structures, so $\varepsilon_J$ is genuinely two-valued | none: needs the orbit structure |
| 7 | $\langle\star(X\wedge X),Z\rangle=12\,\mathrm{triple}(Z,X,X)$ at every skew $X,Z$ | none, **AND THIS IS THE GAP THE ITEM STILL OWES** |
| 8 | the adjugate law holds at EVERY skew $X$, hence both sides are matrices of cubics in the $15$ free entries | none: this is exactly the `sorry` |
| 9 | **therefore the `sorry`'s stated justification is FALSE: it needs neither the skew normal form nor equivariance** | none: a claim about a proof strategy |
| 10 | the fifteen entries $\sigma(X)_{ij}$, $i<j$, equal the signed Pfaffian of the complementary four-set | `sigma_0_1` … `sigma_4_5`, fifteen theorems, **proved**, standard axioms |
| 11 | $\mathrm{Pf}(X)=\tfrac13\sum_{a<b}\sigma(X)_{ab}X_{ab}$, a consequence of claim 7 at $Z=X$ | none: untyped |

## What to do

1. **Claim 9 is the one this brief most doubts, and the doubt is about EVIDENCE rather than truth.** Claims 8 and 9 rest on the law having been checked at $300$ random skew matrices and failing off the skew locus. **A polynomial identity is not established by finitely many samples unless a degree bound closes the gap.** So say whether claim 8 is *proved*, and if not, what would prove it: a degree argument plus enough points, or the expansion itself. **And say whether claim 9 survives if claim 8 is only screened**, since "the statement is polynomial, so the normal form is unnecessary" is an argument about the statement rather than about the evidence for it.
2. **Claim 1 is the load-bearing algebra of part A and should be checked line by line.** Does $J(x)=0$ really follow from a kernel direction, with the symmetries as stated? Does "constant spectrum equal to $0$" really force $W=0$, or only that every $J(y)$ vanishes on $y^\perp$, which might be weaker? **Name precisely which Weyl symmetry carries the last step.**
3. **Claim 4 asks about reach.** A route's warrant failing is not the route failing. State what claim 4 does and does not close, and whether the target statement survives its supporting instance being wrong.
4. **Claim 7 is the one everything else would be built on.** Derive it yourself. The three wedge terms are claimed equal under $\varepsilon$'s antisymmetry, collapsing $\tfrac1{24}$ against $\tfrac1{48}$ to give $12$. **Check the constant.**
5. **Claim 10 is machine-checked, so check the STATEMENT and not the proof**: is the signed Pfaffian of the complementary four-set the right closed form, and is the sign the permutation's?
6. **Claim 3's $n=4$ half is a control.** Confirm $W_{\mathbb{CP}^2}$ at $n=4$ is Osserman, and say whether that follows from it being rank-one symmetric or needs checking.
7. Return **CONFIRMED**, **PLAUSIBLE** or **REFUTED** per claim, with corrections.

**State what a claim would look like if it were vacuous, and check that it is not.** Claim 2 in particular: if every Weyl tensor of interest had a kernel direction, the claim would exclude everything and say nothing about maximisers.

## Standing rules

**Analysis only.** A LONG or OPEN-ENDED run needs the user's approval for the specific task. **Permitted without asking**: screening a claim you are about to record, seconds of compute on objects you construct for that purpose, and any run finishing in a few minutes on objects already in hand. **The deliverable is a derivation, and a number is a screen.**

**A control is an assertion, never a printed expectation.** *One of the screens behind this brief drew orthogonal matrices from a QR factorisation and got $\det=-1$ on every draw, sampling one orbit while reporting on two. Random is not uniform.*

**Report.** Write `reviews/REVIEW_r<N>.md`, skeleton committed in your FIRST phase with every verdict `NOT REACHED`. **Commit with an explicit PATHSPEC**, `git commit -m "<msg>" -- reviews/REVIEW_r<N>.md`, never `git add -A` and never `git commit -a`. **Never amend.** **Do not write to reviews/INDEX.md.**

**Two traps in the commit gate.** [cycle_deliverable.py](../.claude/hooks/cycle_deliverable.py) reads the first physical line of the bash command for `refut\w+`, so a subject line containing "refutes" trips its opens-an-item tripwire while the parent has `plan.md` staged. Its `SEARCHED` regex anchors on `$` under `re.M`, so a trailer works only when the closing shell quote sits on the next line.

**Log** to `agent_logs/<task-name>.log`: PID and phase plan on the first line, a line per phase, a heartbeat carrying live state at least every 3 minutes, and a closing line OPENING with `DONE ` or `FAILED `.

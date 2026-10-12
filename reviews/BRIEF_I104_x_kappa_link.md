# Gate 2 brief: I104's $x\to\kappa_i$ link, and whether it can be spent

You are an adversarial reviewer. **Work from the definitions below and from the mathematics alone.** Do not read the findings files or the working note these blocks come from, and do not import the scripts or the Lean file under review.

**Two reviewers on identical briefs.** New mathematics is being made rather than read, so two readers sample a wide distribution of reasoning errors and rarely find each other's.

## The setting, given because every attack item below needs it

$\mathcal D_n$ is the space of hollow symmetric $n\times n$ matrices with zero row sums ("sectional matrices"), with $\langle K,L\rangle=\sum_{a<b}K_{ab}L_{ab}$.

For a four-set $Q=\{i,j,k,l\}$, $\Pi_Q\subset\mathcal D_n$ is the plane of matrices supported on $Q$, carrying one coefficient on each of the three **pairings** $\{ij,kl\}$, $\{ik,jl\}$, $\{il,jk\}$: that is $K_{ij}=K_{kl}=x$, $K_{ik}=K_{jl}=y$, $K_{il}=K_{jk}=z$, with $x+y+z=0$. So $\Pi_Q$ is a $2$-plane and $\lVert K\rVert^2=2(x^2+y^2+z^2)$.

Three four-sets are in play, **overlapping pairwise in two indices**:

$$Q_1=\{i,j,k,l\},\qquad Q_2=\{i,j,m,p\},\qquad Q_3=\{k,l,m,p\}.$$

**Two planes share exactly ONE matrix entry**: the pair $ij$ for $(Q_1,Q_2)$, the pair $kl$ for $(Q_1,Q_3)$, the pair $mp$ for $(Q_2,Q_3)$.

**Write $x_a$ for plane $a$'s coefficient on its FIRST pairing.** For $Q_1$ that pairing is $\{ij,kl\}$, so the one coefficient $x_1$ sits on BOTH the entry shared with $Q_2$ and the entry shared with $Q_3$. That is why only three numbers appear across all three overlaps.

**GIVEN, and proved on the record, NOT audited here**: $\langle q_1,q_2\rangle=x_1x_2$ and cyclically, so each cross-Gram **factors through a single linear functional on each plane: it has rank one, and the principal cosines are exactly $(\tfrac13,0)$.**

Let $D\in\mathcal D_n$, let $q_1$ be the orthogonal projection of $D$ onto $\Pi_{Q_1}$, let $r_1=D-q_1$, and write

$$p=r_1[i,j],\qquad p'=r_1[k,l],\qquad c=q_1\text{'s first-pairing coefficient}.$$

**GIVEN, quoted verbatim from the coupling step this link is meant to feed.** With $\hat q$ the unit sectional matrix of $\Pi_Q$ and $r\perp\Pi_Q$:

> **The coupling.** For unit $\hat q=(x,y,z)$ and $r\perp\Pi_Q$, split $r$ into its $Q$-internal entries $p,p',a',b',c',d'$ on the pairs $ij,kl,ik,jl,il,jk$, its columns $c_m=(r_{am})_{a\in Q}$ for $m\notin Q$, and the rest. Then $2\langle L_{\hat q}r,r\rangle=2[x(p^2+p'^2)+y(a'^2+b'^2)+z(c'^2+d'^2)]+2\Sigma+\sum_mc_m^{\mathsf T}\hat qc_m$ with $\Sigma=z(p+p')(a'+b')+y(p+p')(c'+d')+x(a'+b')(c'+d')$, the entries outside $Q$'s rows not entering.

and that form is then discarded in favour of $\kappa\le\max(x,y,z)\lVert q\rVert\lVert r\rVert^2\le\tfrac1{\sqrt3}\lVert q\rVert\lVert r\rVert^2$, with $\kappa:=\langle L_qr,r\rangle$.

**The item this feeds.** A chain fails by a deficit of $0.0148$ at a configuration with $t=0.346$, where a separate bound pins $\sum_iu_i^2$ and hence confines $u$ to $[0.437539,0.438432]$. The full coupling bound $\kappa_i\le\tfrac{u_i}{\sqrt3}(t-u_i^2)$ is about $0.039$ there.

## The derivation under review, quoted verbatim from disk

> **Derived from this file's own geometry.** *$q_1$ lies in $\Pi_{Q_1}$, whose $ij$ and $kl$ entries share a pairing and are therefore EQUAL, so $(q_1)_{ij}+(q_1)_{kl}=2c$ with $c$ the first-pairing coefficient. $D_{ij}=x_1+x_2$ and $D_{kl}=x_1+x_3$, since $Q_3$ misses $ij$ and $Q_2$ misses $kl$. So $p+p'=2x_1+x_2+x_3-2c$, and the cross-Gram's principal cosine of exactly $\tfrac13$ gives $c=x_1+\tfrac13(x_2+x_3)$.*
>
> $$p+p'=\tfrac13(x_2+x_3).$$
>
> **Two facts decide how it can be spent, and the second is a limitation rather than a caveat.** *$p$ and $p'$ are NOT separately determined, only their sum, so this feeds a BOUND on $\kappa_1$ and cannot feed an identity.* **And it is SCOPED: the relation holds for $D$ in the span of the three planes and FAILS once $D$ carries a component orthogonal to all three**, which a general $D\in\mathcal D_n$ does.

## The claims to attack, one row per claim, with the Lean declaration that types it

| # | claim | Lean |
|---|---|---|
| 1 | $q_1$'s entries at $ij$ and $kl$ are equal, so $(q_1)_{ij}+(q_1)_{kl}=2c$ | none: a property of membership in $\Pi_{Q_1}$, which the base layer does not carry as a subspace; it enters as the definition of $c$ |
| 2 | $D_{ij}=x_1+x_2$ and $D_{kl}=x_1+x_3$ | `hD_ij` and `hD_kl`, hypothesis binders of `shared_channel_sum`, **and this is exactly where the scope enters** |
| 3 | $c=x_1+\tfrac13(x_2+x_3)$, from the cross-Gram having rank one at principal cosine $\tfrac13$ | `hc`, a hypothesis binder; the geometry behind it is given above and is not audited here |
| 4 | $p+p'=\tfrac13(x_2+x_3)$ | `shared_channel_sum`, **proved**, standard axioms |
| 5 | $p^2+p'^2\ge\tfrac1{18}(x_2+x_3)^2$ | `channel_norm_lower`, **proved**, standard axioms |
| 6 | that bound is attained exactly at $p=p'$ | `channel_bound_sharp`, **proved**, standard axioms |
| 7 | $p$ and $p'$ are not separately determined by $x_2,x_3$, only their sum is | none: a non-existence statement about what the projection determines, needing $\Pi_{Q}$ as a subspace |
| 8 | the relation FAILS for $D$ with a component orthogonal to all three planes | none: same reason as row 7, and it is asserted in the screen rather than typed |
| 9 | at the surviving configuration the full $\kappa$ bound is about $0.039$ against a $0.0148$ deficit, so the coupling source is live | none: a comparison of two computed numbers |
| 10 | **the link can actually be SPENT: knowing $p^2+p'^2\ge\tfrac1{18}(x_2+x_3)^2$ improves the bound on $\kappa$** | none, **AND THIS IS THE ONE THE BRIEF MOST DOUBTS**: the quadratic form's sign is not controlled, so a lower bound on one group of terms may not bound $\kappa$ in the useful direction at all |

## What to do

1. **Claim 10 first, and the brief believes it may be FALSE.** The bound to be improved is an UPPER bound on $\kappa=\langle L_qr,r\rangle$. The link supplies a LOWER bound on $p^2+p'^2$. In the quoted expansion those terms appear as $2x(p^2+p'^2)$, and $x$ is a coefficient of $\hat q$ with $x+y+z=0$, so **$x$ may be negative**. Work out whether a lower bound on $p^2+p'^2$ pushes $\kappa$ up or down, and say plainly whether the link improves the upper bound, worsens it, or is unusable without a sign condition on $x$. **If it is unusable, that is the finding and it retires the item's remaining source.**
2. **Claim 4 is the load-bearing algebra.** Derive $p+p'$ yourself from claims 1 to 3 and confirm the $\tfrac13$. Then ask whether claim 3 is correctly stated: the principal cosine is a statement about the ANGLE between planes, and $c=x_1+\tfrac13(x_2+x_3)$ is a statement about a projection's coefficient. Say whether the second follows from the first, or needs more.
3. **Claim 8 is the scope and it is the item's next obstacle.** Confirm the relation fails off the span of the three planes, and say what the honest repair is: split $r_1$ into its in-span part and the rest, or add a hypothesis. **Say whether a critical point's $D$ has any reason to lie in that span.**
4. **Claim 7 is a non-existence claim and those are the easiest to get wrong.** Confirm that the projection genuinely leaves the split between $p$ and $p'$ free, rather than the screen having sampled a family too narrow to see it pinned.
5. **Claim 5's constant.** Check $\tfrac1{18}$, and in particular that it is one half times one ninth and not one quarter times one ninth.
6. **Claim 9 asks whether a number is being compared against a number at the same configuration.** This file has been corrected once for mixing configurations. Confirm $0.039$ and $0.0148$ are at the same point.
7. Return **CONFIRMED**, **PLAUSIBLE** or **REFUTED** per claim, with corrections.

**State what a claim would look like if it were vacuous, and check that it is not.** Claim 5 in particular: a lower bound on a quantity that nothing else constrains buys nothing, so say where $p^2+p'^2$ is actually used.

## Standing rules

**Analysis only.** A LONG or OPEN-ENDED run needs the user's approval for the specific task. **Permitted without asking**: screening a claim you are about to record, seconds of compute on objects you construct for that purpose, and any run finishing in a few minutes on objects already in hand. **The deliverable is a derivation, and a number is a screen.**

**A control is an assertion, never a printed expectation.**

**Report.** Write `reviews/REVIEW_r<N>.md`, skeleton committed in your FIRST phase with every verdict `NOT REACHED`. **Commit with an explicit PATHSPEC**, `git commit -m "<msg>" -- reviews/REVIEW_r<N>.md`, never `git add -A` and never `git commit -a`. **Never amend.** **Do not write to reviews/INDEX.md.**

**Two traps in the commit gate.** [cycle_deliverable.py](../.claude/hooks/cycle_deliverable.py) reads the first physical line of the bash command for `refut\w+`, so a subject line containing "refutes" trips its opens-an-item tripwire while the parent has `plan.md` staged. Its `SEARCHED` regex anchors on `$` under `re.M`, so a trailer works only when the closing shell quote sits on the next line.

**Log** to `agent_logs/<task-name>.log`: PID and phase plan on the first line, a line per phase, a heartbeat carrying live state at least every 3 minutes, and a closing line OPENING with `DONE ` or `FAILED `.

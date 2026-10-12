# Reviewer 104, PARTIAL (salvaged from its log)

**This reviewer did not file a report.** Salvaged 2026-08-26 from `agent_logs/reviewer104.log` at the moment it was stopped, so the findings it had already reached are not lost. **Nothing here has been reconciled against the record, and none of it should be cited as a verdict**, a partial reviewer's numbers are exactly the kind that get propagated wrongly (see Reviewer 78, whose unverified quadric values reached FINDINGS.md for a commit).

Its phase plan and every line it logged, verbatim, 9 lines:

```
PID 85702 | PHASE PLAN: 1=setup+tooling+context 2=Claim1 vertex-matrix/diagonal identities 3=Claim2 t=2 forcing + iff 4=Claim3 Okumura feasibility over vertex matrices 5=Claim4 solver attack (beat the numbers) 6=Claim5 the inference (MAIN) 7=report
14:26:49 PHASE 2 start: own Weyl implementation + Claim 1
14:27:53 PHASE2: Claim1 all four items confirmed at 1e-16, n=5..8; theta identity reproduced with M#=(1/2)ccMM
14:32:12 PHASE 3 start: Claim 2 (t=2 forcing + iff) and vertex-map realizability
14:35:23 PHASE 4/5: vertex map is ONTO {hollow,sym,zero-row-sum} (rank n(n-3)/2) at n=5,6,7 -> Claim3/4 K-family exactly realizable. Building own separable solver.
14:35:45 PHASE5: solver validated -- Relax_K at t=2 returns theta_0 exactly for S3xS3, S4xS4. Now Claim 3.
14:37:08 PHASE5: Claim3 done. Found analytic sharp lemma |min K| >= sqrt(t/(n(n-1)(n-2))) => mu-side Okumura infeasible for t>4/(n+1). Also found Claim3 FAILS at n=6,t<=0.1 (25/60 feasible at t=0.05). Now Claim 4 sweep.
15:27:45 PHASE6 start (claim4 sweep running in bg): kappa^2 = max_F t for real Weyl, and Relax at the ACTUAL K
15:34:04 PHASE6: kappa^2(random W,n=6) approx 0.95-1.19; Relax at ACTUAL kappa-optimal K = 1.9-2.5 = 1.8-2.35x theta_0. Tight ONLY at the exact sphere product; 1.004 at eps=0.05.
```

## What to do with this

Either re-launch a reviewer on the same brief and let it finish, or rebuild any number above from the object's own definition before recording it. Do not fold it into the record as-is.

"""Reviewer 21 phase 1: is B really 0 on the joint frontier, or is the ascent stuck?

Three independent attacks on  max_{W1 in S(V13), K in S(ker)}  A + t B:

 1. ALTERNATING GLOBAL SOLVES.  With one factor fixed the objective is
    linear+quadratic on a sphere, i.e. a trust-region subproblem, solved to
    global optimality by the secular equation.  No local ascent anywhere.
 2. MANY RESTARTS, including seeds at the A-maximiser and at the B-maximiser.
 3. SECOND-ORDER BIFURCATION ANALYSIS at the A-maximiser: the exact t at which
    the corner stops being a local max, from the Hessians of A and B on the
    product of spheres.  This predicts the true threshold instead of sampling it.
"""
import sys
import time
import numpy as np

from review_r21_core import Setup, sphere_quad_max, unit

A_SUP = np.sqrt(5.0 / 6.0)
B_SUP = 2.0 / 3.0


def maximize_A(S, restarts=40, iters=300, seed=0):
    """sup_{W1 in S(V13)} ||P_ker Q(W1)||, by ascent on ||Q(W1)||^2 (the <u>
    component is constant = theta*/3, so this is the same maximisation)."""
    rng = np.random.default_rng(seed)
    best = (-1.0, None)
    for _ in range(restarts):
        y = unit(rng.normal(size=S.d13))
        for _ in range(iters):
            W1 = S.mat13(y)
            qk = S.q_ker(W1)                       # A = <qk, y_K>
            K = S.matker(unit(qk))
            # gradient of A(W1, K) in W1 with K fixed  = 2 P13 Fbil(W1,K)
            g = S.f_13(W1, K)
            ng = np.linalg.norm(g)
            if ng < 1e-300:
                break
            y = unit(0.7 * y + g / ng) if False else unit(g)
        W1 = S.mat13(y)
        val = np.linalg.norm(S.q_ker(W1))
        if val > best[0]:
            best = (val, y.copy())
    return best


def maximize_B(S, restarts=30, iters=200, seed=1):
    """sup_{K in S(ker)} ||P_13 Q(K)||."""
    rng = np.random.default_rng(seed)
    best = (-1.0, None)
    for _ in range(restarts):
        y = unit(rng.normal(size=S.dker))
        for _ in range(iters):
            K = S.matker(y)
            p = S.q_13(K)
            W1 = S.mat13(unit(p))
            g = S.f_ker(W1, K)
            ng = np.linalg.norm(g)
            if ng < 1e-300:
                break
            y = unit(g)
        K = S.matker(y)
        val = np.linalg.norm(S.q_13(K))
        if val > best[0]:
            best = (val, y.copy())
    return best


def AB(S, y1, y2):
    W1, K = S.mat13(y1), S.matker(y2)
    return float(S.q_ker(W1) @ y2), float(S.q_13(K) @ y1)


def exact_alternate(S, y1, y2, t, rounds=8, log=None):
    """Alternate GLOBAL trust-region solves.  Returns (val, y1, y2, history)."""
    hist = []
    for r in range(rounds):
        # --- global solve in K, W1 fixed
        W1 = S.mat13(y1)
        Mk = S.block_fast(W1, S.Vker, S.Vker)          # B = y2^T Mk y2
        Mk = 0.5 * (Mk + Mk.T)
        qk = S.q_ker(W1)                          # A = qk . y2
        y2, _ = sphere_quad_max(t * Mk, qk)
        a, b = AB(S, y1, y2)
        hist.append(("K", a, b, a + t * b))
        # --- global solve in W1, K fixed
        K = S.matker(y2)
        M1 = S.block_fast(K, S.V13, S.V13)             # A = y1^T M1 y1
        M1 = 0.5 * (M1 + M1.T)
        q1 = S.q_13(K)                            # B = q1 . y1
        y1, _ = sphere_quad_max(M1, t * q1)
        a, b = AB(S, y1, y2)
        hist.append(("W", a, b, a + t * b))
        if log:
            log(f"      round {r}: A={a:.9f} B={b:.9f} val={a+t*b:.9f}")
        if r >= 2 and abs(hist[-1][3] - hist[-3][3]) < 1e-13:
            break
    a, b = AB(S, y1, y2)
    return a + t * b, y1, y2, hist


def cheap_alternate(S, y1, y2, t, iters=250):
    """Riemannian-ish ascent used only to generate candidates cheaply."""
    for _ in range(iters):
        W1, K = S.mat13(y1), S.matker(y2)
        g2 = S.q_ker(W1) + 2 * t * S.f_ker(W1, K)
        if np.linalg.norm(g2) > 1e-300:
            y2 = unit(g2)
        K = S.matker(y2)
        g1 = 2 * S.f_13(W1, K) + t * S.q_13(K)
        if np.linalg.norm(g1) > 1e-300:
            y1 = unit(g1)
    a, b = AB(S, y1, y2)
    return a + t * b, y1, y2

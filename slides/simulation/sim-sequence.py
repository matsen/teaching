import numpy as np
import time


def evolve_sequence_gillespie(seq, t, kappa=2.0, mu=1e-1):
    # Define the rate matrix for the Kimura 2-parameter model with kappa and beta=1
    Q = np.array(
        [
            [-2 - kappa, kappa, 1, 1],
            [kappa, -2 - kappa, 1, 1],
            [1, 1, -2 - kappa, kappa],
            [1, 1, kappa, -2 - kappa],
        ]
    )

    # Ensure the rows of the rate matrix sum to zero
    Q = Q / -np.diag(Q)[:, None]
    # Scale the rate matrix by mu
    Q *= mu

    assert np.allclose(Q.sum(axis=1), 0), "Rows of the rate matrix must sum to zero"

    # DNA bases
    bases = ["A", "G", "C", "T"]

    # Convert the sequence to a list of states
    states = [bases.index(base) for base in seq]

    print(seq)

    # Simulation of the Markov chain
    start_time = time.time()
    while time.time() - start_time < t:
        # Compute the rates of leaving each state
        rates = np.array([-Q[state, state] for state in states])
        total_rate = rates.sum()

        # Sample the waiting time until the next jump
        wait_time = np.random.exponential(1 / total_rate)

        if wait_time <= t - (time.time() - start_time):
            # If there's time for a jump before t, sleep for the wait time and make the jump
            time.sleep(wait_time)

            # Choose which state will jump
            jump_state = np.random.choice(len(states), p=rates / total_rate)

            # Update the jumping state
            rates_to_next = (
                -Q[states[jump_state], states[jump_state]]
                * Q[states[jump_state], :].copy()
            )
            rates_to_next[states[jump_state]] = 0
            states[jump_state] = np.random.choice(
                4, p=rates_to_next / rates_to_next.sum()
            )
        else:
            # Otherwise, no more jumps can happen before t
            break

        # Print the current sequence
        print("".join(bases[state] for state in states))

    return "".join(bases[state] for state in states)


seq = "AAAGGGCCCTTT"
print(f"evolving original sequence {seq} for the middle node")
middle_seq = evolve_sequence_gillespie(seq, 5)
print(f"\nevolving middle sequence {middle_seq} for the left leaf for 4 seconds")
left_seq = evolve_sequence_gillespie(seq, 4)
print(f"\nevolving middle sequence {middle_seq} for the right leaf for 3 seconds")
right_seq = evolve_sequence_gillespie(seq, 3)

print(f"\n>left_leaf\n{left_seq}")
print(f">right_leaf\n{right_seq}")

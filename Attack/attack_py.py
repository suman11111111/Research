import numpy as np
import matplotlib.pyplot as plt

# Parameters
N = 30000  # Total number of iterations
dt = 0.001  # Step length

a = 100  # Amplitude of attack signal


# Initial conditions
x = np.zeros((N+1, 3))
w = np.zeros((N+1, 3))

x[0, :] = [1, 2, 3]
w[0, :] = [1, 2, 3]

e = np.zeros((N, 3))

for i in range(N):
    x_act = a * np.sin(i * dt) if 2000 <= i < 7000 else 0
    
    e[i, :] = x[i, :] - w[i, :]
   
    x1, x2, x3 = x[i, :]
    w1, w2, w3 = w[i, :]
    
    x[i+1, 0] = x1 + dt * ((-1) * (x1 - x2) + x_act)
    x[i+1, 1] = x2 + dt * ((-1) * (2 * x2 - x1 - x3))
    x[i+1, 2] = x3 + dt * ((-1) * (x3 - x2))
    
    
    w[i+1, 0] = w1 + dt * ((-1) * (w1 - w2))
    w[i+1, 1] = w2 + dt * ((-1) * (2 * w2 - w1 - w3))
    w[i+1, 2] = w3 + dt * ((-1) * (w3 - w2))

# Plotting
plt.figure()
plt.plot(x[:, 0], label='Node 1')
plt.plot(x[:, 1], label='Node 2')
plt.plot(x[:, 2], label='Node 3')
plt.legend()
plt.title('States')
plt.show()

plt.figure()
plt.plot(e[:, 0], label='Node 1')
plt.plot(e[:, 1], label='Node 2')
plt.plot(e[:, 2], label='Node 3')
plt.legend()
plt.title('Errors')
plt.show()

print(f"x1={x[-1, 0]}, x2={x[-1, 1]}, x3={x[-1, 2]}")
print(f"e1={e[-1, 0]}, e2={e[-1, 1]}, e3={e[-1, 2]}")



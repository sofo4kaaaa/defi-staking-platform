flowchart LR

A[User connects wallet] --> B[Stake tokens]
B --> C[Smart Contract locks tokens]
C --> D[Reward accrual]
D --> E{Unstake?}
E -->|Yes| F[Transfer tokens + rewards]

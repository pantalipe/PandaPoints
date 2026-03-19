# PandaPoints Contract

BEP20 token on Binance Smart Chain with a built-in AMM, liquidity pools, staking, and referral system — deployed without relying on external DEXes like PancakeSwap.

## Deployed Contract

| Network | Address |
|---------|---------|
| BSC Mainnet | [`0xa59a4f398be9ee072aa800e489ce74429a4746f5`](https://bscscan.com/address/0xa59a4f398be9ee072aa800e489ce74429a4746f5) |

## Overview

PandaPoints (PP) is a self-contained DeFi token. Instead of integrating with external protocols, all financial mechanics — buying, selling, liquidity, and staking — are handled directly inside the contract. This makes it fully autonomous and independent from third-party infrastructure.

## Features

### Token
- BEP20 / ERC20 standard
- Built on OpenZeppelin v4.8.0

### AMM — Built-in Exchange
The contract implements its own constant product market maker (x * y = k) without relying on PancakeSwap or Uniswap.

| Function | Description |
|----------|-------------|
| `buyTokens()` | Buy PP with BNB at current pool price |
| `sellTokens()` | Sell PP back to BNB |
| `openTrading()` | Initialize liquidity pool (owner only) |

### Liquidity Pool
| Function | Description |
|----------|-------------|
| `addLiquidity()` | Add BNB + PP to the pool, receive LP shares |
| `removeLiquidity()` | Withdraw proportional share from pool |
| `hugeUnbalancedEmergencialRemoveLiquidity()` | Emergency withdrawal for large positions |

Liquidity has a minimum lock period of 24 hours (`86400` seconds) after each deposit or withdrawal.

### Staking
| Function | Description |
|----------|-------------|
| `stakeTokens()` | Lock PP tokens for 30 days (2592000 seconds) |
| `withdrawStakeTokens()` | Withdraw staked tokens + reward after lock period |
| `addStakeTokens()` | Add more tokens to an active stake |

Staking reward is 1% of the staked amount, funded by trading fees accumulated in `stakingTotalBalance`.

### Referral System
Each buy and sell automatically credits 1% of the transaction value to the referrer linked to the buyer/seller via `refLi[address]`. If no referrer is set, the reward goes back to the trader.

### Fee Distribution (on buy/sell)
| Recipient | Amount |
|-----------|--------|
| Dev wallet 0 | 1% |
| Marketing wallet 1 | 2% |
| Liquidity reward pool | 1% |
| Referrer (or trader) | 1% |

## Contract Architecture

This is a flattened single-file contract (`ppflat.sol`) that includes:

- `IERC20` — ERC20 interface (OpenZeppelin v4.6.0)
- `IERC20Metadata` — metadata interface
- `Context` — msg.sender abstraction
- `ERC20` — base token implementation (OpenZeppelin v4.8.0)
- `PandaPoints` — main contract with all DeFi mechanics

## Stack

- Solidity `^0.8.18`
- OpenZeppelin Contracts v4.8.0
- Hardhat (deployment and testing)
- Binance Smart Chain (BSC)

## Security Notes

- `pandaMasterOwner` is set at deploy time and controls privileged functions
- `openTrading()` can only be called once (requires zero liquidity)
- Transfer fees only apply to addresses flagged in `tFBl` mapping
- Liquidity withdrawals have a 24h cooldown after each operation

## License

GPL

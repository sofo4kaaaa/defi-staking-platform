// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC20 {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function transfer(address recipient, uint256 amount) external returns (bool);
}

contract Staking {

    IERC20 public token;
    uint256 public apr = 10;

    struct StakeInfo {
        uint256 amount;
        uint256 startTime;
    }

    mapping(address => StakeInfo) public stakes;

    constructor(address _token) {
        token = IERC20(_token);
    }

    function stake(uint256 _amount) external {
        require(_amount > 0, "Invalid amount");
        token.transferFrom(msg.sender, address(this), _amount);

        stakes[msg.sender] = StakeInfo({
            amount: _amount,
            startTime: block.timestamp
        });
    }

    function calculateReward(address _user) public view returns (uint256) {
        StakeInfo memory userStake = stakes[_user];
        uint256 duration = block.timestamp - userStake.startTime;

        return (userStake.amount * apr * duration) / (365 days * 100);
    }

    function unstake() external {
        StakeInfo memory userStake = stakes[msg.sender];
        require(userStake.amount > 0, "No stake");

        uint256 reward = calculateReward(msg.sender);
        uint256 total = userStake.amount + reward;

        delete stakes[msg.sender];
        token.transfer(msg.sender, total);
    }
}

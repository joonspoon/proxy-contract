// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract Box is OwnableUpgradeable {
    uint256 private _value;

    // Emitted when the stored value changes
    event ValueChanged(uint256 value);

    function store(uint256 value) public {
        _value = value;
        emit ValueChanged(_value);
    }

    function retrieve() public view returns (uint256) {
        return _value;
    }

    function withdrawFeesCollected() public { //external onlyOwner {
        _value = 0;
        emit ValueChanged(_value);
        payable(msg.sender).transfer(address(this).balance);
    }
}

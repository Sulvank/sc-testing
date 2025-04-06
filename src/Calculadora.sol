// SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

contract Calculadora {

    // Variables
    uint256 public result;
    address public admin;

    // Events
    event Addition(uint256 firstNumber, uint256 secondNumber, uint256 result);
    event Subtraction(uint256 firstNumber, uint256 secondNumber, uint256 result);
    event Multiplication(uint256 firstNumber, uint256 secondNumber, uint256 result);
    event Division(uint256 firstNumber, uint256 secondNumber, uint256 result);

    // Modifiers
    modifier onlyAdmin() {
        require(msg.sender == admin, "Not allowed");
        _;
    }
    constructor(uint256 firstResult_, address admin_) {
        result = firstResult_;
        admin = admin_;
    }

    // Functions

    // 1.Addition
    function addition(uint256 firstNumber_, uint256 secondNumber_) external returns (uint256 result_) {
        result_ = firstNumber_ + secondNumber_;
        result = result_;

        emit Addition(firstNumber_, secondNumber_, result_);
    }

    // 2.Subtraction
    function subtraction(uint256 firstNumber_, uint256 secondNumber_) external returns (uint256 result_) {
        result_ = firstNumber_ - secondNumber_;
        result = result_;

        emit Subtraction(firstNumber_, secondNumber_, result_);
    }

    // 3.Multiplier
    function multiplier(uint256 firstNumber_, uint256 secondNumber_) external returns (uint256 result_) {
        result_ = firstNumber_ * secondNumber_;
        result = result_;

        emit Multiplication(firstNumber_, secondNumber_, result_);
    }

    // 4.Division
    function division(uint256 firstNumber_, uint256 secondNumber_) external onlyAdmin returns (uint256 result_) {
        require(secondNumber_ != 0, "Division by zero is not allowed.");
        result_ = firstNumber_ / secondNumber_;
        result = result_;

        emit Division(firstNumber_, secondNumber_, result_);
    }
}
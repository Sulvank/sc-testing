// SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

import "forge-std/Test.sol";
import "../src/Calculadora.sol";

contract CalculadoraTest is Test {
    Calculadora public calculadora;
    uint256 public firstResult = 100;
    address public admin = vm.addr(1);
    address public randomUser = vm.addr(2);

    function setUp() public {
        calculadora = new Calculadora(firstResult, admin);
    }

    // Unit testing
    function testCheckFirstResult() public view {
        uint256 firstResult_ = calculadora.result();
        assert(firstResult_ == firstResult);
    }

    function testAddition() public {
        uint256 firstNumber_ = 5;
        uint256 secondNumber_ = 5;

        uint256 result_ = calculadora.addition(firstNumber_, secondNumber_);
        assert(result_ == firstNumber_ + secondNumber_);
    }

    function testSubstraction() public {
        uint256 firstNumber_ = 5;
        uint256 secondNumber_ = 5;

        uint256 result_ = calculadora.subtraction(firstNumber_, secondNumber_);
        assert(result_ == firstNumber_ - secondNumber_);
    }

    function testMultiplier() public {
        uint256 firstNumber_ = 5;
        uint256 secondNumber_ = 5;

        uint256 result_ = calculadora.multiplier(firstNumber_, secondNumber_);
        assert(result_ == firstNumber_ * secondNumber_);
    }

    function testCanNotMultiply2LargeNumbers() public {
        uint256 firstNumber_ = 2 ** 128;
        uint256 secondNumber_ = 2 ** 128;

        vm.expectRevert();
        calculadora.multiplier(firstNumber_, secondNumber_);
    }

    function testCanNotDivideByZero() public {
        vm.startPrank(admin);
        uint256 firstNumber_ = 10;
        uint256 secondNumber_ = 0;

        vm.expectRevert();
        calculadora.division(firstNumber_, secondNumber_);

        vm.stopPrank();
    }

    function testIfNotAdminCallsDivisionReverts() public {
        vm.startPrank(randomUser);
        uint256 firstNumber_ = 5;
        uint256 secondNumber_ = 2;

        vm.expectRevert();
        calculadora.division(firstNumber_, secondNumber_);

        vm.stopPrank();
    }

    function testAdminCanCallDivisionCorrectly() public {
        vm.startPrank(admin);
        uint256 firstNumber_ = 10;
        uint256 secondNumber_ = 5;

        uint256 result_ = calculadora.division(firstNumber_, secondNumber_);
        assert(result_ == firstNumber_ / secondNumber_);
        vm.stopPrank();
    }

    function testDefaultCanNotCallDivisionCorrectly() public {
        uint256 firstNumber_ = 5;
        uint256 secondNumber_ = 2;

        vm.expectRevert();
        calculadora.division(firstNumber_, secondNumber_);
    }

    function testDefaultExecutesCorrectly() public {
        vm.startPrank(admin);
        uint256 firstNumber_ = 5;
        uint256 secondNumber_ = 2;

        uint256 result_ = calculadora.division(firstNumber_, secondNumber_);
        assert(result_ == firstNumber_ / secondNumber_);
        vm.stopPrank();
    }

    // Unit testing = given inputs
    // Fuzzint testing = random inputs

    // Fuzzing testing

    function testFuzzingDivision(uint256 firstNumber_, uint256 secondNumber_) public {
        vm.startPrank(admin);

        calculadora.division(firstNumber_, secondNumber_);
        vm.stopPrank();
    }
}

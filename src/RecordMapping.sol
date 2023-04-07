// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/// @title RecordMapping
contract RecordMapping {
  int length;
  mapping(address => int) data;
  mapping(int => mapping(int => int)) nestedData;

  function setData(address addr, int value) public {
      data[addr] = value;
  }

  function setNestedData(int i, int j) public {
      nestedData[i][j] = i * j;
  }
}
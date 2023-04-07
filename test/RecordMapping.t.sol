// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "src/RecordMapping.sol";

contract RecordMappingTest is Test {
    RecordMapping target;

    function setUp() external {
        target = new RecordMapping();
    }

    
    function testRecordMapping() public {
        // Start recording
        vm.startMappingRecording();

        // Verify Records
        target.setData(address(this), 100);
        target.setNestedData(99, 10);
        target.setNestedData(98, 10);

        bytes32 dataSlot = bytes32(uint(1));
        bytes32 nestDataSlot = bytes32(uint(2));
        assertEq(uint(vm.getMappingLength(address(target), dataSlot)), 1, "number of data is incorrect");
        assertEq(uint(vm.getMappingLength(address(this), dataSlot)), 0, "number of data is incorrect");
        assertEq(uint(vm.getMappingLength(address(target), nestDataSlot)), 2, "number of nestedData is incorrect");

        bytes32 dataValueSlot = vm.getMappingSlotAt(address(target), dataSlot, 0);
        assertEq(vm.getMappingParentOf(address(target), dataValueSlot), dataSlot, "parent of data[i] is incorrect");
        assertGt(uint(dataValueSlot), 0);
        assertEq(uint(vm.load(address(target), dataValueSlot)), 100);

        for (uint k; k < vm.getMappingLength(address(target), nestDataSlot); k++) {
            bytes32 subSlot = vm.getMappingSlotAt(address(target), nestDataSlot, k);
            uint i = vm.getMappingKeyOf(address(target), subSlot);
            assertEq(vm.getMappingParentOf(address(target), subSlot), nestDataSlot, "parent of nestedData[i][j] is incorrect");
            assertEq(uint(vm.getMappingLength(address(target), subSlot)), 1, "number of nestedData[i] is incorrect");
            bytes32 leafSlot = vm.getMappingSlotAt(address(target), subSlot, 0);
            uint j = vm.getMappingKeyOf(address(target), leafSlot);
            assertEq(vm.getMappingParentOf(address(target), leafSlot), subSlot, "parent of nestedData[i][j] is incorrect");
            assertEq(j, 10);
            assertEq(uint(vm.load(address(target), leafSlot)), i * j, "value of nestedData[i][j] is incorrect");
        }
    }
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std-new/Test.sol";
import "src/RecordMapping.sol";

contract RecordMappingTest is Test {
    RecordMapping target;

    function setUp() external {
        target = new RecordMapping();
    }

    
    function testRecordMapping() public {
        emit log_string("-----start recording(startMappingRecording)------");
        // Start recording
        vm.startMappingRecording();

        emit log_string("-----init map data-----");
        target.setData(address(this), 314);
        target.setData(address(1), 42);

        target.setNestedData(1000, 1000);
        target.setNestedData(1000, 48);
        target.setNestedData(1000, 24);
        target.setNestedData(100, 100);
        target.setNestedData(10, 10);

        emit log_string("-----test getMappingLength-----");
        bytes32 dataSlot = bytes32(uint(1));
        bytes32 nestDataSlot = bytes32(uint(2));
        
        uint dataLen = vm.getMappingLength(address(target), dataSlot);
        emit log_named_uint("data's length", dataLen);
        assertEq(dataLen, 2, "number of data is incorrect");

        assertEq(uint(vm.getMappingLength(address(this), dataSlot)), 0, "number of data is incorrect");

        emit log_string("-----test getMappingSlotAt-----");
        bytes32 dataValueSlot0_0 = vm.getMappingSlotAt(address(target), dataSlot, 0);
        emit log_named_bytes32("map data's 0th slot index", dataValueSlot0_0);
        bytes32 dataValueSlot0_1 = keccak256(abi.encode(address(this), dataSlot));
        emit log_named_bytes32("map data's 0th slot index", dataValueSlot0_1);

        bytes32 dataValueSlot1_0 = vm.getMappingSlotAt(address(target), dataSlot, 1);
        emit log_named_bytes32("map data's 1st slot index", dataValueSlot1_0);
        bytes32 dataValueSlot1_1 = keccak256(abi.encode(address(1), dataSlot));
        emit log_named_bytes32("map data's 1st slot index", dataValueSlot1_1);

        emit log_string("-----test load storage slot value-----");
        emit log_named_uint("map data's 0th slot value", uint(vm.load(address(target), dataValueSlot0_0)));
        emit log_named_uint("map data's 0th slot value", uint(vm.load(address(target), dataValueSlot0_1)));
        emit log_named_uint("map data's 1st slot value", uint(vm.load(address(target), dataValueSlot1_0)));
        emit log_named_uint("map data's 1th slot value", uint(vm.load(address(target), dataValueSlot1_1)));
        emit log_named_bytes32("map data's origin slot value", vm.load(address(target), dataSlot));

        emit log_string("-----test getMappingKeyOf-----");
        emit log_named_uint("this's address", uint(uint160(address(this))));
        emit log_named_uint("map data's 0th slot key", vm.getMappingKeyOf(address(target), dataValueSlot0_0));
        emit log_named_uint("map data's 0th slot key", vm.getMappingKeyOf(address(target), dataValueSlot0_1));
        emit log_named_uint("map data's 1th slot key", vm.getMappingKeyOf(address(target), dataValueSlot1_0));
        emit log_named_uint("map data's 1th slot key", vm.getMappingKeyOf(address(target), dataValueSlot1_1));

        emit log_string("-----test getMappingParentOf-----");
        emit log_named_uint("dataValueSlot0_0_parent", uint(vm.getMappingParentOf(address(target), dataValueSlot0_0)));
        emit log_named_uint("dataValueSlot1_0_parent", uint(vm.getMappingParentOf(address(target), dataValueSlot0_1)));

        emit log_string("-----test nestdata-----");
        uint nestedDataLen = vm.getMappingLength(address(target), nestDataSlot);
        emit log_named_uint("nestedData Map's length", nestedDataLen);

        for (uint k; k < nestedDataLen; k++) {
            bytes32 subSlot = vm.getMappingSlotAt(address(target), nestDataSlot, k);
            emit log_named_uint("-----k: -----", k);
            emit log_named_bytes32("nestData's k_th submap's slot", subSlot);

            emit log_named_uint("submap's len", vm.getMappingLength(address(target), subSlot));
            for (uint a; a < vm.getMappingLength(address(target), subSlot); a++ ) {
                bytes32 sub = vm.getMappingSlotAt(address(target), subSlot, a);
                emit log_named_uint("loop a", a);
                emit log_named_bytes32("map nestedData's submap slot index", sub);

            }
            if (k == 0) {
                emit log_named_bytes32("map nestedData's slot index, (1000)", keccak256(abi.encode(uint(1000), nestDataSlot)));
                emit log_named_bytes32("map nestedData's slot index, (1000, 1000)", keccak256(abi.encode(uint(1000), keccak256(abi.encode(uint(1000), nestDataSlot)))));
                emit log_named_bytes32("map nestedData's slot index, (1000, 48)", keccak256(abi.encode(uint(48), keccak256(abi.encode(uint(1000), nestDataSlot)))));
                emit log_named_bytes32("map nestedData's slot index, (1000, 24)", keccak256(abi.encode(uint(24), keccak256(abi.encode(uint(1000), nestDataSlot)))));
            } else if (k == 1) {
                emit log_named_bytes32("map nestedData's slot index, (100)", keccak256(abi.encode(uint(100), nestDataSlot)));
                emit log_named_bytes32("map nestedData's slot index, (100, 100)", keccak256(abi.encode(uint(100), keccak256(abi.encode(uint(100), nestDataSlot)))));
            } else {
                emit log_named_bytes32("map nestedData's slot index, (10)", keccak256(abi.encode(uint(10), nestDataSlot)));
                emit log_named_bytes32("map nestedData's slot index, (10, 10)", keccak256(abi.encode(uint(10), keccak256(abi.encode(uint(10), nestDataSlot)))));
            }
            
            assertEq(vm.getMappingParentOf(address(target), subSlot), nestDataSlot, "parent of nestedData[i][j] is incorrect");
            emit log_named_bytes32("nestData's subMap's Parent", vm.getMappingParentOf(address(target), subSlot));

            uint i = vm.getMappingKeyOf(address(target), subSlot);
            emit log_named_uint("nestData's k_th map's Key", i);
            emit log_named_uint("length of nestData's SubMap", uint(vm.getMappingLength(address(target), subSlot)));

            bytes32 leafSlot = vm.getMappingSlotAt(address(target), subSlot, 0);
            emit log_named_bytes32("leafSlot", vm.getMappingParentOf(address(target), subSlot));

            uint j = vm.getMappingKeyOf(address(target), leafSlot);
            assertEq(vm.getMappingParentOf(address(target), leafSlot), subSlot, "parent of nestedData[i][j] is incorrect");
            assertEq(uint(vm.load(address(target), leafSlot)), i * j, "value of nestedData[i][j] is incorrect");
        }
    }
}
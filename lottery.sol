// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract lottery{
    address public owner;
    address payable[] public holder;

    constructor() {
        owner==msg.sender;
    }
    
    receive() external payable{
        require(msg.value==1 ether);
        holder.push(payable(msg.sender));
    }
    function Balance() public view returns(uint) 
    {
        require(msg.sender==owner);
        return address(this).balance;
    }
    function random() public view returns(uint){
       return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,holder.length)));

    }

    function winneris() public {
        require(msg.sender==owner);
        require(holder.length>=3);
        uint xyz=random();
        uint index=xyz % holder.length;
        address payable winner;
        winner=holder[index];
        winner.transfer(Balance());
        holder=new address payable[](0);
    }
}
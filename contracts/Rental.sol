// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Bu kontrat her yıl devletin söylediği miktarda kirayı artıran bir kontrat. Kira da bu kontrat üstünden ödeniyor.
contract Rental{
    event updatedRent(uint rentingPrice);
    event paid(bool sent);
    address private owner;
    uint256 today = block.timestamp;

    constructor() payable{
        owner = msg.sender;
    }

    receive() external payable{}

    struct Renter{ //Struct of the renter to keep track of them.
        uint rentingPrice;
        address renterID;
        uint increment;
        uint startAt;
        bool[] rentTrack;
    }

    Renter[] private renters; //An arraylist to store renters.


    function addRenter(uint _rentingPrice, address _renterID, uint _increment, uint _startAt) external{
        require(owner == msg.sender);
        bool[] memory _rentTrack;
        Renter memory renter = Renter(_rentingPrice, _renterID, _increment, _startAt, _rentTrack);
        renters.push(renter);
    }

    function getRenter(uint index) view external returns(uint, address, uint, uint) {
        uint start = renters[index].startAt;
        uint diff = (today - start) / 60 / 60 / 24;
        return (renters[index].rentingPrice, renters[index].renterID, renters[index].increment, diff);
    }

    //update reting price method (if the renter stayed at there over a year)
    function updateRent(uint i) external{
        //If the renter stayed at there over a year, owner can increment the amount of the rent
        if((today - renters[i].startAt)/60/60/24 >= (365)){
            renters[i].rentingPrice = renters[i].rentingPrice + renters[i].increment;
        }
        emit updatedRent(renters[i].rentingPrice);
    }

    //Pay for the rent
    function payForTheRent(uint i, address payable _to) external payable{
        uint timeDiffMonths = (today - renters[i].startAt) /60/60/24/30;
        require(timeDiffMonths >= 1);
        require(msg.sender == renters[i].renterID);
        require(_to == owner);
        bool sent = _to.send(renters[i].rentingPrice);
        require(sent, "send failed");
        if(sent){
            renters[i].rentTrack.push(true);
        }else{
            renters[i].rentTrack.push(false);
        }
        emit paid(sent);
    }

    //Delete the renter if renter didn't pay for the month
    function deleteRenter(uint index) external{
        uint count = 0;
        for (uint i = 0; i < renters[index].rentTrack.length; i++){
            if(renters[index].rentTrack[i] == false){
                count++;
            }
        }

        if(count > 0){
            delete renters[index];
        }
    }
}
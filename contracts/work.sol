pragma solidity ^0.8.11;

contract work {

    string public name;
    constructor(){
        name = "abhishek's project";


        create(7,"Delhi Care Centre");
        create(10, "Noida Anath Ashram");
        create(5,"Jaypee NSS");
        create(7,"JYC Fees");
        
    }

    uint public pcount = 0;
    
    struct ngo{
        uint id;
        string ngoname;
        address owner;
        uint amount;
        uint donated;
        bool donation;
    }


    mapping(uint=>ngo) public ngolist;

    function create(uint _amount,string memory _name) public {
        
        require(bytes(_name).length > 0,'Enter a name');
        require(_amount >0);

        ngolist[pcount] = ngo(pcount,_name,msg.sender,_amount,0,false);
        pcount++;
    }

    function getcount() public view returns(uint){
        return pcount;
    }

    function getdata(uint _id) public view returns (ngo memory){
        ngo memory cur = ngolist[_id];

        return (cur);
    }



    function donate(uint _id) public payable{
        ngo memory _new = ngolist[_id];
        
        require(msg.value > 0);

        address _ngo = _new.owner;

        _new.donated += (msg.value/(1 ether));
        
        
        ngolist[_id] = _new;

        payable(address(_ngo)).transfer(msg.value);

    }

}
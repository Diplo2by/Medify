pragma solidity ^0.8.12; // *important* make sure your version of solidity is 0.8.12 else change respective pragma

contract Medifi { // contract
	uint public Total_records = 0;
	string public name = "Medifi";
	mapping(uint => Record) public records; // mapping the class


struct Record{ // the class/ solidity struct
	uint pat_id; // patient id
	string cid; //record cid of the ipfs data record
	string name; // patient name
	string blood_grp;
	string vaccines;
	string std;
	string diabetes;
}


constructor() public {
	
}

function UploadRecord(string memory _cid, string memory pat_id, string memory _name,string memory _blood_grp, string memory _vaccines, string memory _std,string memory _diabetes )public{

	require(bytes(_cid).length > 0); // check if there is a hash associated with a record
	require(bytes(pat_id).length>0); // check for the patient id
	require(msg.sender != address(0)); // make sure uploader is using an actual adress
	Total_records++;

	records [Total_records] = Record(Total_records,_cid,_name,_blood_grp,_vaccines,_std,_diabetes);
}
function get(uint x) public view returns (string memory){
	return records[x].cid;
}
function getAll(uint y) public view returns (Record memory){
	return records[y];

}
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract Medium is Initializable,UUPSUpgradeable{

    address payable owner;
    uint number_of_article;
  
    
    struct User{
        string name;
        string city;
        string profession;
        bool isAdded;
    }

    struct Article{
        string title;
        string Author_name;
        string tags;
        string Description;

    }
 
    mapping(address => User)public users;

    Article[] public articles;

    function initialize()public initializer{
        owner = payable(msg.sender);
    }

    modifier  onlyOwner()  {
        require(msg.sender==owner,"You are not authorized to Withdraw fund");
        _;
    }

    function _authorizeUpgrade(address) internal override onlyOwner {}
 
    function AddUser(string memory _name,string memory _city,string memory _profession,bool _isAdded)public payable {
       require(msg.value>=0.00001 ether,"You need to pay eth to create User");
        require(!users[msg.sender].isAdded,"Users is already Registed");
        User memory newUser = User(_name,_city,_profession,_isAdded);
        users[msg.sender] = newUser;
       
    }

    function createArticle(string memory _title,string memory _Author_name,string memory _tags,string memory _description)public payable{
        require(msg.value>=0.00001 ether,"You need to pay publish Article");
        require(users[msg.sender].isAdded == true,"Users not registed Pleaes Registed yourself First");
        articles.push(Article(_title,_Author_name,_tags,_description));
        number_of_article += 1;
    }

    function getArticle(uint _index)public view returns(string memory title,string memory author,string memory tags, string memory description){
        Article storage article = articles[_index];
        return (article.title,article.Author_name,article.tags,article.Description);
    }

    function withdrawFund()external payable {
        owner.transfer(address(this).balance);
    }

    function getOwner()public view returns(address){
        return owner;
    }

    function NumberOfArticle()public view returns(uint){
        return number_of_article;
    }

    function getUsersData(address _user)public view returns(bool){
        return users[_user].isAdded;
    }

    function getAllArticles()public view returns(Article[] memory){
        return articles;
    }

}


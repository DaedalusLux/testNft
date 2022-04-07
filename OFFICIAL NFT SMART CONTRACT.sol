// SPDX-License-Identifier: ROBERTDEV
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";



contract GiveAway is ERC721, ERC721Enumerable, Ownable {
    uint256 internal Supply;
    uint256 public Price = 0.1 ether;
    uint256 public maxMintable = 1;
    bool mintIsOpen = false;

    
  
    

    constructor() ERC721("Green chart Giveaways", "GREENGIVEAWAY") {
      
    }





      function setPrice( uint256 _newPrice ) public onlyOwner {
       Price = _newPrice;
      }

       function setMintIsOpen(bool _newState) public onlyOwner {
        mintIsOpen = _newState;
       }
  

    function mint(uint256 mintAmount, string memory  ) public payable {
        uint256 supply = totalSupply();
        require(mintIsOpen, "Mint is closed");
    require(mintAmount > 0);
    require(mintAmount <= maxMintable, "bro too much");

   
    

    if (msg.sender != owner()) {
      require(msg.value >= Price * mintAmount);
    }

    for (uint256 i = 1; i <= mintAmount; i++) {
      _safeMint(msg.sender, supply + i);
    }

  }

  function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        return "https://ipfs.infura.io/ipfs/QmS2wrYKF3pRfi8YhtB6ahGSsMVRemuWboZq45hTENirDu";
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function withdraw() public payable onlyOwner {
      (bool os, ) = payable(owner()).call{value: address(this).balance}("");
    require(os);
    
  }

  function ROBERTDEVisCREATOR() public pure returns(bool){
    return true;
  } 
}

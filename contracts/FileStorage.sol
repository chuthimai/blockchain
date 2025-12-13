// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract FileStorage {
    uint256 public fileId;
    string public fileHash;
    string public fileSignature;


    event FileStored(
        uint256 fileId,
        string fileHash,
        string fileSignature,
        uint256 blockId
    );

    function storeFile(uint256 _fileId, string memory _fileHash, string memory _fileSignature) public {
        fileId = _fileId;
        fileHash = _fileHash;
        fileSignature = _fileSignature;

        emit FileStored(
            _fileId,
            _fileHash,
            _fileSignature,
            block.number
        );
    }

    function getFile() public view returns (uint256, string memory, string memory) {
        return (fileId, fileHash, fileSignature);
    }
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract FileStorage {
    uint256 public fileId;
    string public fileHash;

    event FileStored(
        uint256 fileId,
        string fileHash,
        uint256 blockId
    );

    function storeFile(uint256 _fileId, string memory _fileHash) public {
        fileId = _fileId;
        fileHash = _fileHash;

        emit FileStored(
            _fileId,
            _fileHash,
            block.number
        );
    }

    function getFile() public view returns (uint256, string memory) {
        return (fileId, fileHash);
    }
}
